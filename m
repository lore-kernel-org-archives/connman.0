Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F833D6
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 9283BCECD1;
	Wed,  8 Nov 2023 15:46:45 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: Clarifying ConnMan Configuration Multi-technology Feature Fusion
 and Online/Ready Transitions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <47128531-37B9-4428-ADE4-6A2251030BF9@nuovations.com>
Date: Wed, 8 Nov 2023 15:46:35 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9802F66-73D0-49B5-9884-027B757BAE7B@holtmann.org>
References: <2CD24062-D2D6-4E13-A6A9-7EA130D38131@nuovations.com>
 <47128531-37B9-4428-ADE4-6A2251030BF9@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> I=E2=80=99ve done more testing on this front with some unexpected =
results using the configuration below:
>=20
> * I have an Ethernet cable connected to the device under test (DUT) to =
an eight port desktop Ethernet switch which, in turn, is connected to =
another local switch which is yet another switch hop away from the =
backbone and the router.
> - If I leave the DUT connected to the desktop switch but disconnect =
the desktop switch from its parent switch and then monitor, I eventually =
see repeated WiSPR failures over Ethernet (404) but I never see Ethernet =
cede the default route to W-Fi and Wi-Fi transition from =E2=80=9CReady=E2=
=80=9D to =E2=80=9COnline=E2=80=9D.
> - How many back-to-back WiSPR failures are expected until another =
technology / service takes over the default route?
>=20
> I also did a test in which I changed:
>=20
> * EnableOnlineToReadyTransition=3Dfalse
> * SingleConnectedTechnology=3Dtrue
>=20
> relative to the below. In this situation, Wi-Fi went crazy with its =
link transitioning many times a second from associating to configuration =
to ready to offline. The console became unusable with repeated:
>=20
>    IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
>    IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
>=20
> messages.


Hmm. I would really prefer you abandon wpa_supplicant and you use iwd. =
Some things that wpa_supplicant does and various hardware drivers are =
doing is insane and we paper over it. Only when starting with iwd, we =
can address things properly.

Regards

Marcel

