Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4733D6
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 9C3F3CECD0;
	Wed,  8 Nov 2023 15:47:36 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: Request for Comment: Implementing Non-link-level Failure
 Monitoring / Failover
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <805B2C7C-9DB6-44C7-9B10-25ADB0E5B84F@nuovations.com>
Date: Wed, 8 Nov 2023 15:47:26 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D53DC6A-AD44-468D-85CD-373878CB938A@holtmann.org>
References: <1B47C370-F3D5-4F60-9753-46D39CAB6728@nuovations.com>
 <805B2C7C-9DB6-44C7-9B10-25ADB0E5B84F@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

>> I spent most of Friday doing integration testing between connmand and =
my application infrastructure inflicting various communications failures =
and observing how the event chain responds.
>>=20
>> Perhaps as no surprise to those here, connmand appears to only be =
responsive to local link failures. That is, with Ethernet, only a first =
hop link loss or cable pull at the device under test (DUT) seems to =
cause a failover to Wi-Fi. Likewise, with Wi-Fi, only a complete loss of =
association to the access point seems to cause a failover to Cellular.
>>=20
>> So, for example, removing an Ethernet link several hops away from the =
DUT or from the Wi-Fi access point, inducing DNS failures, etc. do not =
seem to cause default service failovers. However, I can clearly see the =
WiSPR liveness probes failing with 4xx status=E2=80=94so the right =
signals seem to be present to induce failover.
>>=20
>> If the community is supportive, I would propose some upstream =
changes=E2=80=94the precise details TBD=E2=80=94that:
>>=20
>>   1. After some configurable number of WiSPR liveness probes failing =
on the currently =E2=80=9Conline=E2=80=9D link, connmand declares a =
service no longer =E2=80=9Conline=E2=80=9D.
>>       a. =E2=80=9Conline=E2=80=9D to =E2=80=9Cready=E2=80=9D does not =
=E2=80=9Cflap=E2=80=9D as it does now for the default service.
>>       b. Once it is =E2=80=9Conline=E2=80=9D, it stays =E2=80=9Conline=E2=
=80=9D until those configurable number of WiSPR liveness probes fail.
>>   2. In response to the configurable number of liveness problems, =
moves the default route to the next available service (for example, =
Wi-Fi or Cellular from Ethernet or Wi-Fi, respectively).
>>       a. For the =E2=80=9Cno longer =E2=80=98online=E2=80=99=E2=80=9D =
service, connmand would then go into TBD (Fibonacci?) back off for WiSPR =
probes and would promote the service back to default only when some =
configurable number of WiSPR liveness probes succeed.
>>=20
>> Thoughts?
>=20
> Connman Community:
>=20
> After spending some time yesterday digging in on this, it seems like =
the =E2=80=98EnableOnlineToReadyTransition=E2=80=99 option should, in =
theory, do what=E2=80=99s desired. However, I can see that there is at =
least one immediate obstacle that also explains the default service =
=E2=80=9CReady=E2=80=9D / =E2=80=9COnline=E2=80=9D flapping:
>=20
>    1. ipv6.connman.net appears to be down.
>=20
> Regarding (1), if I run 'wget -S =
http://ipv6.connman.net/online/status.html -O -=E2=80=98, I see:
>=20
>    1. I see DNS resolution to 2001:8d8:8b4:c861:5826:fa5f:6690:0 and =
87.106.208.187.
>    2. The connection to 2001:8d8:8b4:c861:5826:fa5f:6690:0 eventually =
times out.
>    3. A connection to 87.106.208.187 succeeds thereafter which then =
returns a 404: Not found HTTP error.
>=20
> Is there a monitor process for ipv6.connman.net? If not, can it be =
restarted manually?

that is not good. I will look into this.

Regards

Marcel

