Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF63225DA
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CE54F73105;
	Thu, 19 Oct 2023 13:26:25 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6FD54732EE;
	Thu, 19 Oct 2023 13:26:25 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Request for Comment: Implementing Non-link-level Failure
 Monitoring / Failover
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <1B47C370-F3D5-4F60-9753-46D39CAB6728@nuovations.com>
Date: Thu, 19 Oct 2023 10:26:23 -0700
Cc: Emmanuel Vautrin <emmanuel.vautrin@cpexterne.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4901F59-08C1-491C-B31F-B86B5FAD26AD@nuovations.com>
References: <1B47C370-F3D5-4F60-9753-46D39CAB6728@nuovations.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Oct 16, 2023, at 8:46 AM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> Connman Community:
>=20
> I spent most of Friday doing integration testing between connmand and =
my application infrastructure inflicting various communications failures =
and observing how the event chain responds.
>=20
> Perhaps as no surprise to those here, connmand appears to only be =
responsive to local link failures. That is, with Ethernet, only a first =
hop link loss or cable pull at the device under test (DUT) seems to =
cause a failover to Wi-Fi. Likewise, with Wi-Fi, only a complete loss of =
association to the access point seems to cause a failover to Cellular.
>=20
> So, for example, removing an Ethernet link several hops away from the =
DUT or from the Wi-Fi access point, inducing DNS failures, etc. do not =
seem to cause default service failovers. However, I can clearly see the =
WiSPR liveness probes failing with 4xx status=E2=80=94so the right =
signals seem to be present to induce failover.
>=20
> If the community is supportive, I would propose some upstream =
changes=E2=80=94the precise details TBD=E2=80=94that:
>=20
>    1. After some configurable number of WiSPR liveness probes failing =
on the currently =E2=80=9Conline=E2=80=9D link, connmand declares a =
service no longer =E2=80=9Conline=E2=80=9D.
>        a. =E2=80=9Conline=E2=80=9D to =E2=80=9Cready=E2=80=9D does not =
=E2=80=9Cflap=E2=80=9D as it does now for the default service.
>        b. Once it is =E2=80=9Conline=E2=80=9D, it stays =E2=80=9Conline=E2=
=80=9D until those configurable number of WiSPR liveness probes fail.
>    2. In response to the configurable number of liveness problems, =
moves the default route to the next available service (for example, =
Wi-Fi or Cellular from Ethernet or Wi-Fi, respectively).
>        a. For the =E2=80=9Cno longer =E2=80=98online=E2=80=99=E2=80=9D =
service, connmand would then go into TBD (Fibonacci?) back off for WiSPR =
probes and would promote the service back to default only when some =
configurable number of WiSPR liveness probes succeed.
>=20
> Thoughts?

Connman Community:

I=E2=80=99ve a progress update on this front.

The work in progress here will ultimately address both:

    1. connmand Does Not Seem to Failover on Anything But Local Link =
Failures; Complete the Implementation of Non-local Link Failure Failover
    2. connmand Default Service Flaps between Ready and Online at =
Unexpected Times and at an Unusually High Rate Despite Successful HTTP =
Liveness Probes

At this point, I have a prototype, extending Emmanuel Vautrin=E2=80=99s =
work begun in June, in which I am able to start with Ethernet, Wi-Fi, =
and Cellular with Ethernet online (after one successful IPv4 probe (see =
previous email in which ipv6.connman.net is down)).

    * I then pull the Ethernet cable one hop away from the DUT (such =
that the DUT still thinks it has a valid link (and it does, it just =
doesn=E2=80=99t work / route anywhere).
    * Ethernet will hit the to-be-added configurable / settings =
=E2=80=9COnlineCheckFailuresThreshold" (set to 6 for my testing) for =
BOTH IPv4 AND IPv6, if either is =E2=80=98is_connected=E2=80=99.
    * Once Ethernet crosses the =E2=80=9COnlineCheckFailuresThreshold=E2=80=
=9D, it gets marked with =E2=80=98online_check_failures_met_threshold=E2=80=
=99 to =E2=80=99true=E2=80=99.
    * It then sorts as lower priority than Wi-Fi and Cellular, where =
Wi-Fi becomes the new default and assumes the default route.
    * After some time, I then reconnect the one-hop-away-Ethernet link, =
the Ethernet service begins successful online check probing again.
    * Eventually, the Ethernet service hits the to-be-added configurable =
/ settings =E2=80=9COnlineCheckSuccessesThreshold=E2=80=9D (also set to =
6 for my testing) for EITHER IPv4 OR IPv6, if either is =
=E2=80=98is_connected=E2=80=99.
    * Once Ethernet crosses the =E2=80=9COnlineCheckSuccessesThreshold=E2=80=
=9D, it gets marked with =E2=80=98online_check_failures_met_threshold=E2=80=
=99 to =E2=80=99false=E2=80=99.
    * It then re-sorts as higher-priority than Wi-Fi and Cellular again.
    * Is allowed to transition to =E2=80=9COnline=E2=80=9D (but not =
before crossing the =E2=80=9COnlineCheckSuccessesThreshold=E2=80=9D =
since we want to avoid service thrashing on high-frequency, transient =
failures).

I=E2=80=99ve also added an =E2=80=9COnlineCheckIntervalStyle=E2=80=9D =
configuration / setting string that works with the current default of =
=E2=80=9Cgeometric=E2=80=9D (interval^2) and have added =E2=80=9Cfibonacci=
". The latter is more aggressive up to 12 steps (it=E2=80=99s =
equivalence point with =E2=80=9Cgeometric=E2=80=9D at 144 seconds) than =
=E2=80=9Cgeometric" which yields quicker recovery for transient failures =
but backs off far more aggressively past that point which is less =
wasteful, particularly for a metered interface like Cellular, when the =
failures are less transient. For example, for an =
=E2=80=9COnlineCheckSuccessesThreshold=E2=80=9D of six (6), =
=E2=80=9Cfibonacci=E2=80=9D gets Ethernet back to =E2=80=9Conline=E2=80=9D=
 in 20 seconds versus 91 seconds for =E2=80=9Cgeometric=E2=80=9D.

There are a number of bugs and issues to resolve / work through, despite =
the successful proof of concept. Among them:

    * Likely due to the parallel email noting corruption that causes =
connman_service_get_nameservers to crash when a service goes away and =
nameservers get removed, the whole works crash about 50% of the time.
        - I also see 'malloc(): smallbin double linked list corrupted=E2=80=
=99 occasionally.
    * I cannot seem to reliably get the online checks to work =
concurrently with the newly-demoted Ethernet (that seems to stay / =
stick) and with the newly-promoted Wi-Fi.
        - I=E2=80=99ve found some issue which I am resolving and testing =
but there are still some =E2=80=9Choles=E2=80=9D in which online checks =
start but then drop and never resume.
            + There are a number of cases (three I=E2=80=99ve found so =
far) in which __connman_start_wispr is not properly =E2=80=9Cbookended=E2=80=
=9D such that start failures =E2=80=9Cfall off a cliff=E2=80=9D and =
there=E2=80=99s no opportunity to retry or mark it as a failure at the =
point of initiation.
        - Last evening, I discovered that the behavior of the network =
service Proxy method configuration is influential here.
            + A latent =E2=80=9CDirect" or a =
never-set-to-anything-but-=E2=80=9CUnknown" seems to cause online check =
probes to fall down a hole and never recover.
            + I=E2=80=99m working on a fix for that of which I=E2=80=99ve =
identified two approaches, both of which may be valid.
    * I still need to resolve the =E2=80=9CThere Is Not a =
Consistently-usable IPv4 Internet-reachable Route with connmand when =
Wi"-Fi Is Not the Default Service=E2=80=9D which impacts Ethernet as =
well when it is not the default and has been demoted due to the =
=E2=80=9COnlineCheckFailuresThreshold".

As I vet pieces of the work, I=E2=80=99ll start submitting patches, as =
soon as today.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

