Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E181F
	for <connman@lists.linux.dev>; Tue, 28 Feb 2023 07:09:20 +0000 (UTC)
Received: from smtpclient.apple (p5b3d2561.dip0.t-ipconnect.de [91.61.37.97])
	by mail.holtmann.org (Postfix) with ESMTPSA id E1575CECD7;
	Tue, 28 Feb 2023 08:02:04 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: No 6GHz networks found if connman does the scan, but connman see
 them if 'iw DEV scan' used instead.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1a20dca6-8431-1d24-1ad9-7ae6b386c29d@protonmail.ch>
Date: Tue, 28 Feb 2023 08:02:04 +0100
Cc: Daniel Wagner <wagi@monom.org>,
 connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F230A2F7-0A25-4E12-AAE3-DD4C5D167D5D@holtmann.org>
References: <2712e513-6def-4ed1-d88a-68c961f995e3@protonmail.ch>
 <91794321-2d0b-0c40-3d02-9880c20c7cab@protonmail.ch>
 <20230227080130.gtmid6ojmjmn6h4q@carbon.lan>
 <1a20dca6-8431-1d24-1ad9-7ae6b386c29d@protonmail.ch>
To: Piotr Karbowski <piotr.karbowski@protonmail.ch>
X-Mailer: Apple Mail (2.3696.120.41.1.2)

Hi Piotr,

>> I suppose the best strategy is getting iwd to work in standalone =
first. ConnMan
>> is a user of iwd, so it doesn't really do anything 'special' in the =
iwd plugin.
>> The wpa_supplicant plugin on the other hand has a lot of wireless =
logic in there
>> and it is likely there are some limitiations.
>=20
> That make sense.
>=20
> I sent some time and concluded that my issue is in fact firmware of
> Intel ax210 card. By default it has firmware-choosen country code 00
> that blocks of entire 6 GHz frequencies, only after some, unknown, =
time
> it stays online, based on nearby access points that sends out the
> Country Code (not all of them does) it decides the country code PL is
> the right one and from that moment onward I have working 6 GHz, This =
is
> clearly visible in 'iw phy phy0 reg get'.
>=20
> However the moment I disconnect from network, ax210 goes back on phy#0
> to country 00 and blocks me from reconnecting because all the bands
> above 5835 MHz are disabled (iw list shows them as supported and =
disabled).
>=20
> This makes the entire 6 GHz APs absolute useless with Intel WIFI 6e
> cards as you cannot reliably connect there because of the awful way =
how
> Intel decided to fulfill radio frequency regulations and prevent user
> from setting country code by themselves.

with /etc/main/iwd.conf you have an option to set the country code. The
Intel WiFi might still overwrite it and do their own thing, but there
is some option to set it from the get go.

Regards

Marcel

