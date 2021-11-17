Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7D2C82
	for <connman@lists.linux.dev>; Wed, 17 Nov 2021 09:06:54 +0000 (UTC)
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
	by mail.holtmann.org (Postfix) with ESMTPSA id BE905CECED;
	Wed, 17 Nov 2021 09:57:52 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: Next Connman version and OWE support?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <FRYP281MB1071B616037CC5361DD75CACEB9A9@FRYP281MB1071.DEUP281.PROD.OUTLOOK.COM>
Date: Wed, 17 Nov 2021 09:57:52 +0100
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9452C777-5E6E-46DD-AA24-4FC4A42DE5C3@holtmann.org>
References: <FRYP281MB1071B616037CC5361DD75CACEB9A9@FRYP281MB1071.DEUP281.PROD.OUTLOOK.COM>
To: Lars George <lars.george@biotronik.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)

Hi Lars,

> First of all thanks for the great work with Connman.
>=20
> I saw that Connman now also supports SAE (WPA3), but this is currently =
only available in the master branch. Are there any plans of releasing =
the current changes in the near future?
>=20
> It would also be great if OWE (Opportunistic Wireless Encryption) =
would be supported at some point. Connman would need to identify it as =
=E2=80=98none=E2=80=99 type security and when connecting the =
key_mgmt=3DOWE is needed (at least when using wpa_supplicant). The =
information about this can be found in the Information Element data of =
the BSS in the AKM Suite List (see IEEE Std 802.11 chapter 9.4.2.25 =
RSNE). OWE has suite type 18.
>=20
> When parsing the Information Element is already implemented in Connman =
(I am not yet familiar with the code) the usage of the IEEE80211w could =
also be read from it. The Management Frame Protection Required =
(IEEE80211w=3D2) and Management Frame Protection Capable can be found in =
the RSN capabilities (9.4.2.25.4 RSN capabilities - Bits 6 and 7). =
Currently this is only hard coded set within Connman when connecting to =
WPA3-SAE as this is required there and needs to be optional =
(IEEE80211w=3D1) for the transition mode.

frankly, I think you are better served switching to iwd as backend and =
ditching wpa_supplicant. I doubt that it makes sense to copy the logic =
of OWE and OWE transition mode to ConnMan. I think it will be really =
complicated for OWE transition mode and a big mess. The wpa_supplicant =
APIs are not really meant for this kind of handling. And in iwd you have =
this all handled internally. No extra work needed.

Regards

Marcel

