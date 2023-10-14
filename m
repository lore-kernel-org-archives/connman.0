Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D17E
	for <connman@lists.linux.dev>; Sat, 14 Oct 2023 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CC324731EA
	for <connman@lists.linux.dev>; Fri, 13 Oct 2023 21:05:46 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:6d4d:e797:c700:a96b] (unknown [IPv6:2601:647:5a00:15c1:6d4d:e797:c700:a96b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8D62E73278
	for <connman@lists.linux.dev>; Fri, 13 Oct 2023 21:05:46 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Clarifying ConnMan Configuration Multi-technology Feature Fusion
 and Online/Ready Transitions
Date: Fri, 13 Oct 2023 18:05:45 -0700
References: <2CD24062-D2D6-4E13-A6A9-7EA130D38131@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <2CD24062-D2D6-4E13-A6A9-7EA130D38131@nuovations.com>
Message-Id: <47128531-37B9-4428-ADE4-6A2251030BF9@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

ConnMan Community,

I=E2=80=99ve done more testing on this front with some unexpected =
results using the configuration below:

	* I have an Ethernet cable connected to the device under test =
(DUT) to an eight port desktop Ethernet switch which, in turn, is =
connected to another local switch which is yet another switch hop away =
from the backbone and the router.
		- If I leave the DUT connected to the desktop switch but =
disconnect the desktop switch from its parent switch and then monitor, I =
eventually see repeated WiSPR failures over Ethernet (404) but I never =
see Ethernet cede the default route to W-Fi and Wi-Fi transition from =
=E2=80=9CReady=E2=80=9D to =E2=80=9COnline=E2=80=9D.
		- How many back-to-back WiSPR failures are expected =
until another technology / service takes over the default route?

I also did a test in which I changed:

	* EnableOnlineToReadyTransition=3Dfalse
	* SingleConnectedTechnology=3Dtrue

relative to the below. In this situation, Wi-Fi went crazy with its link =
transitioning many times a second from associating to configuration to =
ready to offline. The console became unusable with repeated:

    IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
    IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

messages.

Best,

Grant

> On Oct 10, 2023, at 8:37 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
>=20
> I am working with connman at commit 24180d1243bf on a system with =
Ethernet, Wi-Fi, and Cellular with the following configuration:
>=20
>    [General]
>    AllowDomainnameUpdates=3Dfalse
>    AllowHostnameUpdates=3Dfalse
>    AlwaysConnectedTechnologies=3Dethernet,wifi,cellular
>    BackgroundScanning=3Dtrue
>    DefaultAutoConnectTechnologies=3Dethernet,wifi,cellular
>    EnableOnlineCheck=3Dtrue
>    EnableOnlineToReadyTransition=3Dtrue
>    =
FallbackTimeservers=3D0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.=
ntp.org
>    FallbackNameservers=3D8.8.8.8,8.8.4.4
>    PreferredTechnologies=3Dethernet,wifi,cellular
>    SingleConnectedTechnology=3Dfalse
>    TetheringTechnologies=3D
>=20
> I=E2=80=99ve pored over connman.conf.5 a number of times now and =
acknowledge that =E2=80=98EnableOnlineToReadyTransition=E2=80=99 is =
marked experimental; however, I am trying to understand how the above =
configuration is supposed to work relative to my understanding of how I =
believe it should work relative to how it documented in connman.conf.5.
>=20
> What I see happening is that net.connman.Manager.State is frequently =
flipping between =E2=80=9CReady=E2=80=9D and =E2=80=9COnline=E2=80=9D =
(on the order of seconds) and that a majority of the time, none of the =
connected services associated with the above three technologies is ever =
=E2=80=9COnline=E2=80=9D, just =E2=80=9CReady=E2=80=9D.
>=20
> My expectation is that Ethernet would be marked =E2=80=9COnline=E2=80=9D=
 and steadily stay there until such time as there is a failure of some =
sort for that technology, at which time I=E2=80=99d expected =E2=80=9CWi-F=
i=E2=80=9D to then get promoted to =E2=80=9COnline=E2=80=9D if possible =
and, failing that, =E2=80=9CCellular=E2=80=9D promoted to =E2=80=9COnline=E2=
=80=9D.
>=20
> Am I misunderstanding and/or misconfiguring things relative to my =
assumptions?
>=20
> Best,
>=20
> Grant
>=20
> --=20
> Principal
> Nuovations
>=20
> gerickson@nuovations.com
> http://www.nuovations.com/
>=20

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

