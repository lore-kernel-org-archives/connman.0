Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06903450F4
	for <connman@lists.linux.dev>; Tue, 17 Oct 2023 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 84E85732C5;
	Tue, 17 Oct 2023 11:55:59 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3d27:84a:9536:a847] (unknown [IPv6:2601:647:5a00:15c1:3d27:84a:9536:a847])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 26D8E7333E;
	Tue, 17 Oct 2023 11:55:59 -0400 (EDT)
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
Date: Tue, 17 Oct 2023 08:55:58 -0700
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <805B2C7C-9DB6-44C7-9B10-25ADB0E5B84F@nuovations.com>
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

After spending some time yesterday digging in on this, it seems like the =
=E2=80=98EnableOnlineToReadyTransition=E2=80=99 option should, in =
theory, do what=E2=80=99s desired. However, I can see that there is at =
least one immediate obstacle that also explains the default service =
=E2=80=9CReady=E2=80=9D / =E2=80=9COnline=E2=80=9D flapping:

    1. ipv6.connman.net appears to be down.

Regarding (1), if I run 'wget -S =
http://ipv6.connman.net/online/status.html -O -=E2=80=98, I see:

    1. I see DNS resolution to 2001:8d8:8b4:c861:5826:fa5f:6690:0 and =
87.106.208.187.
    2. The connection to 2001:8d8:8b4:c861:5826:fa5f:6690:0 eventually =
times out.
    3. A connection to 87.106.208.187 succeeds thereafter which then =
returns a 404: Not found HTTP error.

Is there a monitor process for ipv6.connman.net? If not, can it be =
restarted manually?

The implication of this, coupled with the fact that a state-upgrading =
service can receive a combining promotion whereas a state-downgrading =
service cannot, is that the default service continually flaps between =
=E2=80=98ready=E2=80=99 and =E2=80=98online=E2=80=99 as the WISPr =
=E2=80=98redo_wispr=E2=80=99 functions iterate through geometric backoff =
retry with the IPv4 success causing an upgrade state promotion to =
=E2=80=98online=E2=80=99 and IPv6 failures causing a downgrade state =
demotion to =E2=80=98ready=E2=80=99.

So, in the case of Ethernet, after successful configuration, the =
IPv4/IPv6 states are ready/ready which, through =E2=80=98combine_state=E2=80=
=99 results in an overall service state of =E2=80=98ready=E2=80=99. The =
WISPr reachability probes are then kicked off on both IPv4 and IPv6. =
Though ipv4.connman.net has a high standard deviation, even after =
retries, it=E2=80=99ll eventually succeed and the state goes to =
online/ready which, through =E2=80=98combine_state=E2=80=99 results in =
an overall service state of =E2=80=98online=E2=80=99. On a beat =
frequency with the timeouts and 404 errors of ipv6.connman.net coupled =
with the =E2=80=98redo_wispr=E2=80=99 geometric backoff retries, the =
IPv6 reachability failures trigger =E2=80=98downgrade_state=E2=80=99 =
which does NOT feature state combining, and knocks both IPv4 and IPv6 =
back to =E2=80=98ready=E2=80=99/=E2=80=98ready=E2=80=99 and an overall =
state of =E2=80=98ready.

The second issue that I haven=E2=80=99t figured out or resolved is why, =
on =E2=80=98downgrade_state=E2=80=99 in this situation does Wi-Fi never =
get promoted to the default service (which, of course, would then suffer =
the same gyrations as Ethernet) due to the above. More debugging on that =
today.

Regardless, assuming that Wi-Fi was promoted to the default service, it =
still seems like there some infrastructure missing for promoting =
Ethernet (from Wi-Fi, or Wi-Fi back from Cellular) back to the default =
service should whatever end-to-end connectivity issues were occurring =
get resolved.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

