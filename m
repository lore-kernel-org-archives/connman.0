Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021112.outbound.protection.outlook.com [40.107.160.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26B288A8
	for <connman@lists.linux.dev>; Thu,  7 Aug 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.160.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754563214; cv=fail; b=HrXE6qrDHB1SdUuej59EQ4DR7fQ58JDy6CbR9BzWLJrZclREADuogBdoD8skbnuLUJmzL8ba413RR4UIk7pFlI71JIunTgpGExLztAiZFal+jRZuibT9nOrT4OIY0kWMryoUKCGSJ6R4h1ggrBmVIuihT3nxe0xPD8+dXSB00Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754563214; c=relaxed/simple;
	bh=nG8CAuHp/MVMeeJECh2IxhPBLxxWiuLFs31dgoNRQSg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LK6Y+arKzt3w5c9BGMmXeIZWNuxLhk4cO0Y6YdkkDSGpxGPfD71wFLP7xmnHzkaIU1ewThJOs5AI88zZ+0ut5Ed+soVVaUSbgv99oqNJHKFs/C+usMvb7MAu0g6rnySLnpjooslkDMssPwMw+uneZ2QOM2oyIMgkBWJvFMFt+ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiifor.com; spf=pass smtp.mailfrom=wiifor.com; dkim=pass (2048-bit key) header.d=wiifor.com header.i=@wiifor.com header.b=FFUcrM3Y; arc=fail smtp.client-ip=40.107.160.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiifor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiifor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiifor.com header.i=@wiifor.com header.b="FFUcrM3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggZq6BfSrKz1kzKvlu0hFurlxQNSKKlLQIso1clzqNA7WCU+Lg8QJW8ul8TkaUd4a37QvSEVjB5HEU4fNmlPQaK8iv0CkoubaLy79oN0uoaWN2BePBe5NHM1V/1BcLpsJkdhr5JyAHiyMW3WeKDPN/4Q8JJBZEP78YdE8W+fCTeQXmmYNHuSr/jwkyH2Fqqu1P1d9R8kEcitJHZU9mAmW2gDOBrKnD1CBN+TeyP2aPTbbJpv/wRHUZqRdlBlv/ysNZ0UwkO6zSv4ByIsh4Fezlp++m7CcsaZ+wK31CMRjMTt72nunZU2WkId0V3a8yDpcip8X1OhOGIn+RlOFMYzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG8CAuHp/MVMeeJECh2IxhPBLxxWiuLFs31dgoNRQSg=;
 b=kIEqjT2tEzMZtslHLiYT4ienS1K9wpwLwisMzJ54mqG7s+kilogkmCkWsAjNLsVk9HrO3hFFpsnF89vxChizB/2w4Ld9QEwCRqOMnvsT+8sV+/8tPjloKlnfeeF4SIDVGsY8GdsfoGlY6UiQ5dvOLdZacVbkRZ0xxWU+2oe/9UJsLnugfhoXBQbOxkEC53czkgPyMEAWaVmpU56U7IP4Jz0YAPSOsOD9XoU/dGzxJOxGmOEWg2EVYRfJHUYkz9aoIlZ2ZxbafX+PRtsAtAmn2UaraIa9bFOG+HS02WnW0R7Y5rFV9UCq7I19p2q0q6c9UZdrRJJgYE21TO5VXmndaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiifor.com; dmarc=pass action=none header.from=wiifor.com;
 dkim=pass header.d=wiifor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiifor.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG8CAuHp/MVMeeJECh2IxhPBLxxWiuLFs31dgoNRQSg=;
 b=FFUcrM3YOCFMIYc+Q6uVXI/Ziea9tK/5tSJ7NNVS2Xp8EzH7MhBm2mE88vp5dUBdtHcAp8G7x3Oui5rCMZ3ZlBsGFEb4Ws4NF6tu4pn4/uq9FH4Ycs+aXdX3kZyCFzhrSMoEkUqiGZKQQUxMMAbqjaoiUXqMysTq7ucnRzSeKpXXkQkqDvVB6nn8A0Xg82uSc9rUFXy10WDs3S7arP/9zr3hfJD6ny5luKn/yhVo8CFIwjewzRZ8IErQoOc6Ng2fKDGwmwlqpgh7pyio0aFb/G07Yw/zWIzxjpj1t0tZn3KEZY8+GZTWvNYeknGquduVKN7KGs42USvCtUC580yLfw==
Received: from PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::15)
 by PA3PPF322DCE311.FRAP264.PROD.OUTLOOK.COM (2603:10a6:108:1::62f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 10:40:08 +0000
Received: from PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM
 ([fe80::22c3:9151:ea3b:cb30]) by PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM
 ([fe80::22c3:9151:ea3b:cb30%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 10:40:08 +0000
From: =?iso-8859-1?Q?L=E9o_Granier?= <leo.granier@wiifor.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: Connman - Issue - AlwaysConnectedTechnologies option not working
Thread-Topic: Connman - Issue - AlwaysConnectedTechnologies option not working
Thread-Index: AQHcB4c23LPuBSze6UKHl2lRGA9/TbRW/67xgAAAUOc=
Date: Thu, 7 Aug 2025 10:40:08 +0000
Message-ID:
 <PR0P264MB16281F81ED11317E303540B2952CA@PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR0P264MB1628F168678E10EA4FFAA794952CA@PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM>
 <PR0P264MB1628D1F35FBA6DA24DB7789C952CA@PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To:
 <PR0P264MB1628D1F35FBA6DA24DB7789C952CA@PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiifor.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB1628:EE_|PA3PPF322DCE311:EE_
x-ms-office365-filtering-correlation-id: 5ee75157-1003-4131-469d-08ddd59ec74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?nnjn/9MzAyCESSEE6C8n9JLek2FBD8HnmUKJPok3zYfB2pyy6mszcGg/Ec?=
 =?iso-8859-1?Q?qZBH6QAvl51YZVdmmMV+aTTIUxnUXOpdsr4ZOfY57FNj3b2nkgWYIhqxyS?=
 =?iso-8859-1?Q?ZOdC8Lt5eHRQ0d3tXgDmuCLkevW4ACVaJRP47sj2eor8lC2abeOvobY2tH?=
 =?iso-8859-1?Q?uYlEvC9W3G8nu+CY7HxD3f90S9qo4VtzaxJ4cUbdORG+AWRTPviQbG2gyK?=
 =?iso-8859-1?Q?0gknX4SFxbHlGkEfH0JqZDhhpT+57T/9xMBsry2E53pscUJ2oEnNqJ8dRM?=
 =?iso-8859-1?Q?y41xXhqqd2bkFBwrc1QgspWxnOyG3+7Soa66S+MADC/xQcCkOH3FojfTxF?=
 =?iso-8859-1?Q?brPJ58y+ysozkHEa/TRkng50I2G/ZyV2891XnHLfwMqlhFbRMWv5160II4?=
 =?iso-8859-1?Q?4PutyhTeICNUgAGcgUbvRZt7+GYikZLQQpgTSzpujT5f3PpERUdked+BiB?=
 =?iso-8859-1?Q?MLCMzU2ReAG0qwrZRKyhbcaeFdpsaozS9IV2ifArizggBQlEEkktAzRavR?=
 =?iso-8859-1?Q?wIjeDLLEcTGxt91NkxJmBE+1mfsCuPveJKV40MLEO93e0/vrGDfxZkb0zk?=
 =?iso-8859-1?Q?FC6c6exog46YjDVnjS8TSdnMFkw0LtrO84Y6yXHCySkk9955ZQH0+y7XGb?=
 =?iso-8859-1?Q?QZP1eyr2oWSliOvHxDQjSM/+xZyOqnuF7n3DtgQZczVgi4Pf0C57U7JYBu?=
 =?iso-8859-1?Q?mQKFthJLavSO/FPffTqjNke1MbSx+rdv5Pk6U+58um6tAxvFZWS72o2dlL?=
 =?iso-8859-1?Q?kFN/aWcuIR/T1Dynx9McwCC1eglS81T6CSZQ0606f2Ly1W82vsGpUTU1ve?=
 =?iso-8859-1?Q?+nZ2qdnvms3LdBUZPN7PDNGdlW0I9+RP/xwUMuLP/m00SBDav5b8Kn5x85?=
 =?iso-8859-1?Q?yuYgyTVXAKST3iPeyBY1a6h3OlhAw0TE7j5OnXQMT7S5YIt0m1u5WZivas?=
 =?iso-8859-1?Q?7n3ZtBKT8KXZiw2N0Tmu0fo8lvMSA56yOR5ahu0q7wgmHEYXL3k/UNtbd0?=
 =?iso-8859-1?Q?mmR77GRjHLAHLDv1zu4hh69779i+kwaUM9TGIGAL9WVaMCQLGjENKgKxn0?=
 =?iso-8859-1?Q?O8Y271BicWtTC9eupmQHlqYr4XJAIJnYO2BRkUQ2s7ZcG6B5N05L00dt58?=
 =?iso-8859-1?Q?iMKyIjvF3vq9qMb2Zx+UuvZAadjgsv8P9mQGPlJbrzp0F1fZN0zClB7rYW?=
 =?iso-8859-1?Q?jDyULWDEatp0ZlOA/jJsGgbhEIGRcTTB+tQcUX2PDOAM8fDdsWjvzbHGFG?=
 =?iso-8859-1?Q?4logG36efwLqdbhGxUSepBaEk/T4ROMK97Gya1fqeaKsePQ6dYyuJDCWhw?=
 =?iso-8859-1?Q?6IsqN4EvtIceocqhejBLt8aDh6NbUCcupHHflMlTbwjo/TujfH0o9rxbyN?=
 =?iso-8859-1?Q?J1E/Ei/JRaSNKAOgYzo8/eE9wjjms+MHdbsbvypIqgTzb1jVnXneZw8JXd?=
 =?iso-8859-1?Q?yLWGqdM3WgnNJMv5HaJdGIYAbDEAapbngXc5axczvP10apY/wDNMMAnabf?=
 =?iso-8859-1?Q?kNRySu7Dm7U+pBmbpB9vzw2Sid8m00VO40FWAELFrrmw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sDjEgasgZhBLag2wlcqB0gEUGsGB9UZRBwYqaZiKgfzdADfsfGKI1Us6mL?=
 =?iso-8859-1?Q?CTZhjLtsa+vQmn1q1hqPLt6CHLHhVG7w6yrQAcBdS60oCjwZi0UANH8mF1?=
 =?iso-8859-1?Q?53XLFn7INH27fz2iMCpX8DeOdtZkW3JjDeuu8OJwDxjAV7jf2wb+62mNOU?=
 =?iso-8859-1?Q?NBet0/krsDzbMmM9W+ddjujfByZmmLs1GYqYqeMtX2uLsnmHMmm5B46WaM?=
 =?iso-8859-1?Q?s0jk9tz9uamC3DaIdZKNudJQ5W+XjZGE5ZnMb4JD4MnaMc1P7NTnEbVep6?=
 =?iso-8859-1?Q?Id8HRRDugnM5ZT32uF8ThTPVrogACmb9RLiwVPS1I3R75zVlKmmu9pHl2q?=
 =?iso-8859-1?Q?1B9X2ApPjPeuRAdgoyG9/n8h4+13QhmhiwTa0B/E+44fCfCTv7f1QWXzZp?=
 =?iso-8859-1?Q?9/cqmxIMeEXKiCXiI3zryPHgfupvXytNBFCg5+SKxIGieotTgqg8JPzu9P?=
 =?iso-8859-1?Q?MnYl8jA9Ghqri5lHuylQAvQsX9luUZlcx9aRu8e++EXJZ2s6dddEPDPl/9?=
 =?iso-8859-1?Q?VxNbEyEOE8nA84lxC6b+HOb8tDuN2GaEj1miJBmyeC2/eCXQIIViDYfHB+?=
 =?iso-8859-1?Q?FPIUMOZSkjmtu97abkEszfkheJANeQIDSQbjmvNNLCh9x17F8AG9WyUD+U?=
 =?iso-8859-1?Q?llJB5TT3T07Ke1Xo7E6LY3EUMUHG9xKZSZVVuFVcX4HfzFcAjrJUWVsMP3?=
 =?iso-8859-1?Q?dLS48y7TONS85Onmj6mpQFbpSXKooJd79/z/Exhd639hx3ljnLHOYnruxS?=
 =?iso-8859-1?Q?t3Q+hCjqLN9s2KTnX0U1J0vPFduCrDaw8XCatOs8J0IqNr26AMKK/udb5f?=
 =?iso-8859-1?Q?Z85eBsjPGw3mO3FkSN+2V3xooh3pcnmnjQcAb0WISI/+8rSxLub9/2/32j?=
 =?iso-8859-1?Q?WYMg6wQrNivpRPEfVfmKINY0YjnVSHJEuwhXuWaGjYLuAq88bES/gZSaNU?=
 =?iso-8859-1?Q?mzgrqFVYhCVKFb0KAB4OlTKsCrNiIPsfRxj+1i39quZXB7sICOMuzFOmJY?=
 =?iso-8859-1?Q?ukfZgLEGbqArjwrpJf43z9Dr0JVTDh+gI5WvQZDFrBQQKb0UQFBMMKRzlU?=
 =?iso-8859-1?Q?8XsFHXcNnauWlLJTsd+Fksb+yHwlTJaHg++Ik8gC3pZrQdcqfvhdyPV+lW?=
 =?iso-8859-1?Q?PRMxFJyBogc1CqziYAPnYJT+eIMwvIKjgo0WT4dR7sQ54qkqex5EFcjO4D?=
 =?iso-8859-1?Q?KIRvghxD+aEdi2cuNVM8i1+JrsJmGOZf0x4vLYCwPG9gPuyKk4biEXc/nA?=
 =?iso-8859-1?Q?CSgaQODGDUvEterFmZ89TiHOmqn2a3jg+3EBKk4lRelhQUdJmOfsl4c3Ao?=
 =?iso-8859-1?Q?WTJ2fb9zrnq6BYWm0jGtTecikuCdLbQTYa1tua7a0IPVrCAvrxI2WG7dW5?=
 =?iso-8859-1?Q?MHDot2gJaxtyF510NERfDWoQffQbcR31K25nVo4BtZtIDsWIRPInqcseJk?=
 =?iso-8859-1?Q?4tOcoIrKyLr1N5hAaE2nCAPPYs1/+OIPWgSNkhgrE8td/GNkSWoHKbZPO7?=
 =?iso-8859-1?Q?eoFQcuOJ5aLr6ZWFGPispgcxDqXbuHPgF5ZZVXytj9rh7bLqPzq4o14L7c?=
 =?iso-8859-1?Q?4fiq9Ugx/zFQWud71lAIaucWwNnJQHzFbC9XPzgUE3FgQHKtm+aFMC2cy6?=
 =?iso-8859-1?Q?iPhfukUSBakwgNgrum+NFOdTCKnc0n/YoF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: wiifor.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee75157-1003-4131-469d-08ddd59ec74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 10:40:08.1274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c1e387d-5579-450a-aee9-eea6dfc6e2da
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29+y4bd3CSdSdv8EBhIM30O1mPDWjxQ56O8/vU2FiDLYBJNZKUpzYs5XnjujPFTiPDnL7fi4qV4z1DZubRCI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPF322DCE311

Hello,=0A=
=0A=
We may have identified an issue related to the fallback mechanism when usin=
g ConnMan.=0A=
=0A=
Problem Description:=0A=
If the=A04G (cellular) interface has never been used as the main interface,=
 the fallback does not work properly. This is because the IP routes are not=
 created for the cellular interface until it has been activated at least on=
ce. The cellular interface is not online or ready.=0A=
It seems that the AlwaysConnectedTechnologies=A0setting does not=A0behave a=
s expected and does not automatically connect=A0the cellular interface at b=
oot.=0A=
=0A=
main.conf=0A=
[General]=0A=
AlwaysConnectedTechnologies =3D cellular=0A=
DefaultAutoConnectTechnologies =3D ethernet,cellular,wifi=0A=
PreferredTechnologies =3D ethernet,cellular=0A=
OnlineCheckMode =3D continuous=0A=
OnlineCheckInitialInterval =3D 30=0A=
OnlineCheckMaxInterval =A0=A0=A0=A0=3D 60=0A=
OnlineCheckFailuresThreshold =A0=A0=3D 2=0A=
OnlineCheckSuccessesThreshold =A0=3D 1=0A=
AutoConnectRoamingServices =3D true=0A=
=0A=
Could=A0you please investigate this behavior on your side? It seems like a =
bug or unexpected behavior in ConnMan or a misconfiguration on our side.=0A=
Let us know if you need logs or further details.=0A=
=0A=
Best regards,=0A=
Leo Granier=0A=
Wiifor=
