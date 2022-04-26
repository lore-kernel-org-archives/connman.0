Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238F5392
	for <connman@lists.linux.dev>; Tue, 26 Apr 2022 14:54:18 +0000 (UTC)
Received: from smtpclient.apple (p5b3d2020.dip0.t-ipconnect.de [91.61.32.32])
	by mail.holtmann.org (Postfix) with ESMTPSA id 7E225CECDE;
	Tue, 26 Apr 2022 16:46:04 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4deec7b0-a2e5-0d91-a81c-dc4bb79c1594@collabora.com>
Date: Tue, 26 Apr 2022 16:46:03 +0200
Cc: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B96358C-6DA1-41E0-8C79-7724AD78EC53@holtmann.org>
References: <20220425150837.89194-1-sven.dembianny@bshg.com>
 <20220425150837.89194-2-sven.dembianny@bshg.com>
 <4deec7b0-a2e5-0d91-a81c-dc4bb79c1594@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)

Hi Ariel,

>> Previous MFP support was restricted to WPA3, however it is also =
possible
>> to set MFP to mandatory on APs with WPA2.
>>=20
>> wpa_supplicant config:
>>=20
>> * WPA2-Personal: key_mgmt=3D"WPA-PSK-SHA256" ; iee80211w=3D1
>>=20
>> Signed-off-by: Sven Dembianny <sven.dembianny@bshg.com>
>> ---
>> gsupplicant/supplicant.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
>> index 1b92ec44..e9152632 100644
>> --- a/gsupplicant/supplicant.c
>> +++ b/gsupplicant/supplicant.c
>> @@ -4969,6 +4969,10 @@ static void =
add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
>> 				ieee80211w =3D =
G_SUPPLICANT_MFP_REQUIRED;
>> 			}
>> 			add_network_ieee80211w(dict, ssid, ieee80211w);
>> +		} else if (ssid->keymgmt & =
G_SUPPLICANT_KEYMGMT_WPA_PSK_256) {
>> +			key_mgmt =3D "WPA-PSK-SHA256";
>> +			ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
>> +			add_network_ieee80211w(dict, ssid, ieee80211w);
>> 		} else {
>> 			key_mgmt =3D "WPA-PSK";
>=20
> Shall we also consider the "WPA-PSK" case in the same way?

I prefer we remove wpa_supplicant support from ConnMan and you start =
using iwd ;)

And I am only half joking since this part of wpa_supplicant is such a =
mess. Whatever key management they introduce next will turn into your =
next problem and compatibility issues. I am running independent SSIDs in =
my home network to deal with end consumer device since they use a =
wpa_supplicant and management software that is too dumb.

With iwd the WiFi protocol is in one daemon and not split between two =
daemons.

Regards

Marcel

