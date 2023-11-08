Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64813033C
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9259B731B0;
	Wed,  8 Nov 2023 10:30:13 -0500 (EST)
Received: from [192.168.1.128] (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3E916731F1;
	Wed,  8 Nov 2023 10:30:13 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Clarifying ConnMan Configuration Multi-technology Feature Fusion
 and Online/Ready Transitions
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <E9802F66-73D0-49B5-9884-027B757BAE7B@holtmann.org>
Date: Wed, 8 Nov 2023 07:30:12 -0800
Cc: connman@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C03F5DCF-9E72-40BB-AC52-04BBAB498BF9@nuovations.com>
References: <2CD24062-D2D6-4E13-A6A9-7EA130D38131@nuovations.com>
 <47128531-37B9-4428-ADE4-6A2251030BF9@nuovations.com>
 <E9802F66-73D0-49B5-9884-027B757BAE7B@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 8, 2023, at 6:46 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> I=E2=80=99ve done more testing on this front with some unexpected =
results using the configuration below:
>>=20
>> * I have an Ethernet cable connected to the device under test (DUT) =
to an eight port desktop Ethernet switch which, in turn, is connected to =
another local switch which is yet another switch hop away from the =
backbone and the router.
>> - If I leave the DUT connected to the desktop switch but disconnect =
the desktop switch from its parent switch and then monitor, I eventually =
see repeated WiSPR failures over Ethernet (404) but I never see Ethernet =
cede the default route to W-Fi and Wi-Fi transition from =E2=80=9CReady=E2=
=80=9D to =E2=80=9COnline=E2=80=9D.
>> - How many back-to-back WiSPR failures are expected until another =
technology / service takes over the default route?
>>=20
>> I also did a test in which I changed:
>>=20
>> * EnableOnlineToReadyTransition=3Dfalse
>> * SingleConnectedTechnology=3Dtrue
>>=20
>> relative to the below. In this situation, Wi-Fi went crazy with its =
link transitioning many times a second from associating to configuration =
to ready to offline. The console became unusable with repeated:
>>=20
>>   IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
>>   IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
>>=20
>> messages.
>=20
> Hmm. I would really prefer you abandon wpa_supplicant and you use iwd. =
Some things that wpa_supplicant does and various hardware drivers are =
doing is insane and we paper over it. Only when starting with iwd, we =
can address things properly.

Marcel,

I=E2=80=99d like to make that move; unfortunately, for the current =
project I am engaged on, I am locked on linux-4.9.212, glibc-2.28, and =
GCC 8.x. Unfortunately, with that combination, the latest version of ELL =
I can get to build is 0.28 and the latest version of IWD won=E2=80=99t =
compile against it. In parallel, the latest version of ELL fails with a =
number of errors (I=E2=80=99ll follow up on those later per Denis) and =
the version of ELL included with IWD fails with an overlapping but also =
unique set of errors.

Unfortunately, untangling all of that is more than the client is willing =
to take on at the moment. I=E2=80=99ve recommended that they pursue IWD =
after a kernel, glibc, toolchain update in a later effort.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

