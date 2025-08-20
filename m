Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68C226165
	for <connman@lists.linux.dev>; Wed, 20 Aug 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697482; cv=fail; b=MsxIEGK8EQnZcDP3E+MVGjeJF/qpLQfT5AeR8Y/rFvG4ra+bSB6hO9m1sMRcJ3lAASGlL9jiToTlXvNkhM+Uc2M64KFIK4sGGZEOHYhCsuvwJ6P4QmIXKfWg/5bb0+RTnQ4dujDvCh9rjiXtK6s8zeD9YvDUuvZShhPGbpUFxnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697482; c=relaxed/simple;
	bh=Vwh6yrVpGpMFpw3r5pQwF3bDKO16dGbO1k9F6oEGUaU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oVdeTIa02VhqUsRIzBjCfkBjiJtJzvRzbYntg3b+K3KM1EUgvqOwHS11Ka8w8VIlxbRe1U84ZDoVu7lmyormOu9q/54bdm5eHm2Jq93UAO1z2zHXdGoR31DlNf+xrNDqvpGjpNVGLHuQL1Lua2xD7hdC0xzQafDDEx5cdFCPU1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=nl8V1nWx; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="nl8V1nWx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvMAIFmhJPfcKfbHCjvosb/1BxyAqAdlob2jOgKGWAzpBwXO1+bZQsTan+0twUARwTFs3sZeMYPlb2lAdOpEdUDRxIIfRYPu3VrHIiQ1PKNXosmNUoRZMpkSSHUGBHJHz/2kzqIqSphyWDqcdDzRFpAzgZjpp+mG0KGwaN1Xrzob2Ryh8jgZWDrD+8yqGLf1EqmsDMkSA1dCwGcOBvbcqCMip7ANssSCPg5dmRLFb1qpIo9SC/eRe2wzu5tv0nmXHYFxOagthV965wICeSDicWmYW0b1350O3+whZIH7qm6lv92CvSdiKwdUZzkPy31mbYX2lsyf1C9c1+V5O3z7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vwh6yrVpGpMFpw3r5pQwF3bDKO16dGbO1k9F6oEGUaU=;
 b=EisFqR0Qq8bsFXwp9JZne+BFtX026GeMSH7HrkQdbdKmmLEXy4aQrkqR9McgdnuxKmmScNQe1HSxpj/UYFqdXGThg2mt5/RMQCM7ZwOvROeQxh8tMcrIVFDBKjTH1ZN0x6SncoAWAim3oHSobXvwIKQeJ3tt0/Z1zx7zabnrO9myRe45Op7q2CVXBltoTy3xmeDG0KW2Z6HvIw3C5iuWmxSc0hgwdvOlcCVaetl3QOPWBfB8dTgacE/GtZ8c9WMYtcFHfGM3vrcdozItfr7nkuJlDmiU6w+Eofog21fLA01IA9Kpwd/GRjTZLHZKygxXLFJRcsqnW4FONsC06AZbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vwh6yrVpGpMFpw3r5pQwF3bDKO16dGbO1k9F6oEGUaU=;
 b=nl8V1nWxUNBUin7kLF5drOxPrLjI01gqC+sHEUeZxRlINjo6LiSO10HLnvOfZ1PtzEXZ4V1c+SSkE+lk5ppEMPZ/7aaGpcbyzhBG0gz0vJvtuViLHW+qlSDm6eIBtIGx1ZLJonhzL/VSIbcwdYICUfZKZ2hSojsCikA6qrx8QO6l2ogiU1VNZoKnhZasF0+HDlk23m8mWKGqRntJbAPepHIA/WstuMxIP52x4zQNWV2g5HfAHVAtQpEjdXQSHLdjPZnTY17DXuiF5BD2QOcW0pnf5vgJiQaX2g7OVNYxswRFtanjuIj66P8/Hdi8qp10NAsXY3HjXOeAd6sKjTBn1w==
Received: from HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:62::18) by
 PA1PR10MB8503.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:44:37 +0000
Received: from HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35fe:4513:ef73:45d1]) by HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35fe:4513:ef73:45d1%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 13:44:37 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: AW: AW: v1.45, broken wifi connect
Thread-Topic: AW: v1.45, broken wifi connect
Thread-Index: AQHcCDoLcbNVKf7saEulAds0rK8QjbRraU8ggAAwvICAAAU2EA==
Date: Wed, 20 Aug 2025 13:44:36 +0000
Message-ID:
 <HE1PR10MB1690B9444B6197D17AB086A9F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com>
 <1082538859.4574595.1754637525886@mail.yahoo.com>
 <211116062.4586180.1754639815460@mail.yahoo.com>
 <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
 <511456109.2450472.1755696051598@mail.yahoo.com>
In-Reply-To: <511456109.2450472.1755696051598@mail.yahoo.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR10MB1690:EE_|PA1PR10MB8503:EE_
x-ms-office365-filtering-correlation-id: 7da184d1-2172-4939-0678-08dddfefb438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3TdgYjSwn4LzEaFkRypNqAxY7gw4kISgYcfplwhsox4vGS4MRlRt8WYUD3?=
 =?iso-8859-1?Q?eKyI20LuUBD4bj6//sCOE1FPHu3ST4PrYeIG4QZnftjMjs+mcJziNE3xl2?=
 =?iso-8859-1?Q?6tTAizm8QgcqFjptu9a2LCsvRuGYqLo5H3pR4JwujkDDFGxt5eFYdd1tpI?=
 =?iso-8859-1?Q?uApHBR7bX5jnR7mWWN339T2vPsnLIyLHLm1s/ZxUGZPWNAwm3EVaD7qAcQ?=
 =?iso-8859-1?Q?m72GB2xejJnp+nBRsHxF0J+MypDuS/1BHolGhe12PI+an+ol3TTFgSV1W/?=
 =?iso-8859-1?Q?6TZ6fiS09dQ0tbC+eqZ4cwQekwYHHQgbb9Lpn+huFVkhb+wFh3g+2RdNWd?=
 =?iso-8859-1?Q?u2gl8ehiV9jlnt4A3UCILKm3mXmGLP42thKRPgEe6Zd6Vbvirhlp6na0m4?=
 =?iso-8859-1?Q?n0xz0EKj/xQmsoRgHOTf4ozx1yn5EYf0vFD3FSJ93lR4lNlgPQcqfQ7dXc?=
 =?iso-8859-1?Q?UChaEB1r3LWX3bVdRmmd4tAq9YFHIa5f0Pnggptz40XxhUWPhIPbisgNSA?=
 =?iso-8859-1?Q?tgYTiREcbqqsCBTOieM/8Qht6f9Bm9gkfNy4NJwlZAGfB/0rTmAYHHOG62?=
 =?iso-8859-1?Q?48KmUcBy0LSxLsTWl1/1DPNOKW/02rFS0TPP/RfHt4Mts467ar3GD27SrN?=
 =?iso-8859-1?Q?1U84nlwF5XVZ+n/7/xxfW9cZx10mGTcIDWi0FxPZDEvTT9jXCwUePfIIHG?=
 =?iso-8859-1?Q?CvluUG1S2bu1oDhCgxMwc5o8Y0+2OupESVe2esKY9qQnsB4gl0G6VHWO3t?=
 =?iso-8859-1?Q?epjloChKVHd/7PCHltLMhGf/RDHy3cwb3jTd2XLn+XDUxhSdKKyUjMCG8v?=
 =?iso-8859-1?Q?SMc5533Y8SAkxD7tqgkD1o987mOQjeCb0FnDbVDjaYY5+F1YgTzyffUVKu?=
 =?iso-8859-1?Q?39Q+gSsxWWrgVxYVcZ+3YNejUaBDwWKx4sZ22Ycn9xbN+8aO79rD0UEDeH?=
 =?iso-8859-1?Q?Uue+H/GFuIATF2deLGC27gllavHxUJq6vGrrFmxkcir3GoOtYuIVbRpdmM?=
 =?iso-8859-1?Q?u5tWkwP7tVI0xMkdKe+Rb9lCvW8YxmOax68TOITWs1iILrXxj8VgER5Xq8?=
 =?iso-8859-1?Q?35rLWQ1E0+vXm/+THdexfqUjUmRYT/wUYfUjHveapyqcJZOsoAlrc340gI?=
 =?iso-8859-1?Q?X2LcpJE7uhpjZMQLmi1sCaK36LFMeT+bhZXzrC0wRcMUKr8hvfiL+br/sJ?=
 =?iso-8859-1?Q?0Yg2IKW6AC6S9T1N5eDbEfDT+rU4RGSMK9Pn8n4mWCR3qqnBUExMNkX7vM?=
 =?iso-8859-1?Q?gRkG4ukM4+NljVsNLYC6cnsE/ulSN/lQNnEr2xnyH3gwcYktMxhwlmgTNH?=
 =?iso-8859-1?Q?HA1Fu1TpPU4dyHsgQKLkJKHSQdFwPJ6M1HdCUR2BklufDIC4Xm/LKBIVEx?=
 =?iso-8859-1?Q?OmBLeaD93WT9lGfkdTHyVbOa7c8MAplc2yWfosGIxkjuv1l3i1N+MHElDU?=
 =?iso-8859-1?Q?EEzGRA4laz1KUW3kG89rMrlr1oCtq3gq5vEni88wRbQTWsTS20mV7NZFFR?=
 =?iso-8859-1?Q?I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+o2rtgceGFd8JCtj4DRRdEQCe/8L3T0tYZLHK2u2WpvP5wiXVlPJjHk5oY?=
 =?iso-8859-1?Q?pZK7KCBpfqrsdyG/t4mUmseS/gELHrcrmRhC9oQKhMzVIcLDSaa0Ki2xQs?=
 =?iso-8859-1?Q?+u7zjfhlMF1/Kdf0DXysUjrGxHCQkhmqIJun+yk+Ahqr/VgmhAsIacpU4K?=
 =?iso-8859-1?Q?6waTPxjQgIFrSrEOnhTIzSDoesnEha5ZB1xFeJhpMSQXnbgF5kYp7HDKnw?=
 =?iso-8859-1?Q?WONcfujtNjgACI2RyCBtW2hLdn/hNXG8p1KOjpRhtwgtmxCGaMSTwzG7KN?=
 =?iso-8859-1?Q?sNR6pagPNs7IqZHWQqmjhI1lCMj9vb7dVanEgeeeCAAl/ir5S1wl9q91t7?=
 =?iso-8859-1?Q?KbK6n3jbdlXFNS6gprTZNtzYGyfRA0Fccn6F1kYsH3QUu1cr/ov6eTyyZz?=
 =?iso-8859-1?Q?RozKk4tW0NXLRfHYkewL6QazvTouattXzF89WvRRJqt8+F6CeHqP+n0iSx?=
 =?iso-8859-1?Q?dCXs11psvjS/Vzt+ztiCVVPFrCfQyNGJMYwbaWXsCY7a+HBjKXH8e2MgQk?=
 =?iso-8859-1?Q?rsR424S1dL4oG/ZPFDJM/bGfhZfjAhibQYC4GOkbLXRSQEfz9pJHCCYEYE?=
 =?iso-8859-1?Q?nq9od+jfQxIS+L1E9RWrc3W5Tf2NxTyBf0EGNEyIxBYXcalhi5RwA1pIoj?=
 =?iso-8859-1?Q?UaTiGOkHIOOsYFSiQKYYFeUQETyrzXh90Lt5IkEiaNZ/AhZDfB31OFVWh5?=
 =?iso-8859-1?Q?5sy5/1cDVIiH5zx3yaK0T1jcFWnhkCx8Hnv59O4+OPqHWDi4UY99evdJkF?=
 =?iso-8859-1?Q?X3m5OYqovnv+Z1gzSi4hUZD9CQXAIbG46m0/qXYHp+GtZZ8j2T0ty6Ic3R?=
 =?iso-8859-1?Q?VdBtPhOl97U0r5musVTh8Vu19LN0fXbglmMdkG6LA4VyYVjmU24UxXCZCu?=
 =?iso-8859-1?Q?yw6nxzSyul3Bmingz9z3pvYNECyTLO41Gvi6P7DuDuuwQGPzpzv1hEvZrE?=
 =?iso-8859-1?Q?gHmXWFBsNIk+ZY1jzzo1FhGkB0AuIiloof5cJpwHKPpScINBIrGHcsEo91?=
 =?iso-8859-1?Q?KFX94zNzrCMZIPkq1jm+lcCyKvM3Onye+8AH1ngHfJF6/lgafSpvy/g9uP?=
 =?iso-8859-1?Q?Kplq0e41722tcd0TCnNjamv2Ll4U0J1q0nazhT2xyF/lXolYywL0+R7Vpi?=
 =?iso-8859-1?Q?adPaxelf52EqXAgqEKA0lAm9cjC93wDPaYjg/24gdkYURL3tIBbhNzL8cx?=
 =?iso-8859-1?Q?eLxdBWELrUODPLEP08cd/+1laCniwkHefxDgVd+y2dhkwvBjkv9itwqT8H?=
 =?iso-8859-1?Q?8Qk4voCC45jSvkCAM43U3J8T9T2E9r9fXMRLY6nU1FNc3uZkx+/XjTzBp7?=
 =?iso-8859-1?Q?DZHhaE1wmj0L7XjS/yKhG7mhj9n6OskeXmoDKwcAB57sXFWAxLy2ujfCzk?=
 =?iso-8859-1?Q?TcY54hL/0ADEaMJtth3pe0i6WkUl3MaYTp3sh37+X5kuvoBLtO7sZp4lFb?=
 =?iso-8859-1?Q?1l+YkFzgA0XOakUWeXizwXs1ODz2zPGWhhLGdpAWnTZPCHphLazpkw5SxW?=
 =?iso-8859-1?Q?BYrvtDu5WiX+E87dRs8xip4OQUQ6ZbrB8TRxtbZ2Mh1+ruRTKibw8tFJNO?=
 =?iso-8859-1?Q?neS4fSZYWzfUIAQp/5qKlDOEt6aoGAmi3uHKkX7u/7xyy7oIAaFo/NhNlL?=
 =?iso-8859-1?Q?rFzOMNgvJkYRk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da184d1-2172-4939-0678-08dddfefb438
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 13:44:36.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YriuQ0KSQQqmcFPpmdXFApbOvk6ZH/0Q6jmJZ1J8jtl7ec7HRiTDD+GjAvSXfSnKYesyD5VwEMB/D1tbydT2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8503

Hi Portisch,

maybe adding WPA3 support for wpa_supplicant can help us.
Can you give it a try and add

CONFIG_SAE=3Dy

in

https://github.com/CoreELEC/CoreELEC/blob/coreelec-22/packages/network/wpa_=
supplicant/config/makefile.config

Best regards, Sven

> -----Urspr=FCngliche Nachricht-----
> Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> Gesendet: Mittwoch, 20. August 2025 15:21
> An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7) <sven.dembian=
ny@bshg.com>
> Betreff: Re: AW: v1.45, broken wifi connect
>
> Hi,
>
> server is OpenWRT with: SSID: CI-0030156, Encryption: mixed WPA2/WPA3 PSK=
, SAE (CCMP) Client
> Khadas VIM3: AP6398S
>
> Same behavior with X96 M300, RTL8822CS, vid: 0x024C, pid: 0xC822
>
> With commit included:
> --------------------------------------
> VIM3:~ # connmanctl
> connmanctl> services
> *AO Wired ethernet_0200001e1f01_cable
> *A CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
> connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed=
_psk: Not registered
> connmanctl> state
> State =3D online
> OfflineMode =3D False
> SessionMode =3D False
> connmanctl> disconnect
> connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed=
_psk: Not connected
> --------------------------------------
>
> With commit reverted:
> --------------------------------------
> VIM3:~ # connmanctl
> connmanctl> services
> *AO Wired ethernet_0200001e1f01_cable
> *AR CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
> connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Error /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed=
_psk: Already
> connected
> connmanctl> disconnect
> connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Disconnected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> Connected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> connmanctl> state
> State =3D online
> OfflineMode =3D False
> SessionMode =3D False
> --------------------------------------
>
> Wifi is working again.
> We got multiple reports from users haveing same issue:
> https://discourse.coreelec.org/t/amlo
> gic-no-
> discussion%2F46663%2F2296&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C3c=
ce9ee05e2049040
> 15108dddfec6794%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638912928619=
230523%7CUn
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa=
W4zMiIsIkFOIjoi
> TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DEjK%2FrOlN1nhCNVmlmxzbpeYwc=
yRt6tqLJt9VS0y
> uJpc%3D&reserved=3D0
> Then we reverted this commit and all is good again.
>
> Thank you very much!
> Portisch
>
>
>
>
> Am Mittwoch, 20. August 2025 um 13:33:40 MESZ hat Dembianny Sven (BSH GDE=
-EDSD7)
> <sven.dembianny@bshg.com> Folgendes geschrieben:
>
>
>
>
>
> Hi Portisch,
> >
> > Hi,
> >
> > current connman is broken and can not connect to encrypted networks.
> >
> do you have more info about your setup?
>
> We can't reproduce the issue with 43455 chip.
> Which chip do you use, is it WPA3 capable?
>
> What AKM is configured on your AP?
> Which wpa_supplicant version?
> Is SAE activated for wpa_supplicant?
> >
> > Revert of this commit do solve the issue.
> >
> > Error log:
> > connmanctl> connect wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > connmanctl> Error
> > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d3030333031353
> > connmanctl> 6_
> > connmanctl> managed_psk: Input/output error disconnect
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk Error
> > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d3030333031353
> > connmanctl> 6_
> > connmanctl> managed_psk: Not connected
> >
> >
> > With 1.44 there is no such error:
> > connmanctl> disconnect
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > connmanctl> Disconnected
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > connmanctl> connmanctl> connect
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > connmanctl> Connected
> > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
>
> >
> > Thanks,
> > Portisch
> > Team CoreELEC
>
> >
> Best regards, Sven

