Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4251C28E
	for <connman@lists.linux.dev>; Sat,  5 Apr 2025 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743819001; cv=fail; b=Enx+vkMkBHu07GD0zn/NGZX3AxCma6Q1ZUDeD0fxYs9TLRIW0x+oMC3xdkTPG2ciC1qld6+TIFxS+6P02JYhX8WyiT29lHd2NZ/l4wNllLi0ovhqFbtF0o/O2xym3OUZWvnDky5rEHM90YCFXF8a5Wc1j6+moa0ns+8EdrAM9IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743819001; c=relaxed/simple;
	bh=dFCRwV68swy4HM2sUmIrDxW8KuIAr/jJRwkEbKV0Dak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxFaCX2cWQpvY0E9Rai10CmOGK34diRlb0rRzAKZU910C9IOCyfShMdyMLCdO/CBWP19b61PIYbGiVzB9Slmz8VXqcPrdXpQnnX9dMSGfc9ZXpajFqdCcAQm6XsinJw70D7sUCnF07Ke1kdG2BuTKLtg1kNPzFrTMl/31t0e2zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=lwbGOuTh; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="lwbGOuTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tK8E+NFgyQvywSojviwqcfnKgqreXBu2ky2vzxvlZe6/QrOX/yHDVJ4cO6eXMTiN8bQ6Armga2CJOGka+12vJzoOQ2+NMqySMbBXkQ9haJX4ToODinP2l3oFSOjvRr7xANvmR47AejAiWlVlGWGmQISusyBPakAeDsNQokbU1Wfme4JBMGpDDIn4oxBqzCRo5VUr8xlYb+pNnaHL3uuVWVbdXaE03StQojb1HN8Md8jrD8nHlKbKNcSMWWa2GhdXY2/qssOkBr08iLounKCME1r9QfFEi3b1dKX+UVDPzBuz3MJIEKaJNfwVjev6Oftq2Hdt+RX3p/WiSS/OWOdczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G3/7n74gI3fOkgVJlrFrpWfhtVQOeWKrUuOo8qxdxA=;
 b=kFQYLeNowE1Z9DRpp4PZYu7oQQ7XpilF0gZoO7om83jfu8Ku/7RNnGfB39GshuW5umEMdH7nwVEaw25Yvf8NPrRaD8Qz3Wuh3UCXyRFYPug80YQQNN/XIeU/McqRe7uB5dhZKDLZ9d3goDyTnUPFZ3EBe9prl95M1C+83ODPQK3Me54MhguJdS8I2pi9otUt58o4BIGVfc1/wpDsc9aDSRU+lJqUD5uDAf3Hmr9Ma1YiuWOOLYyjiwHfB6vt72k78AM+FrcW6F95KHpKN755wUG8xxIuaxUagLW/sh7oLwAON9blyvyBCKeKDg2tJxrjQhvXZ3pZCrwvFVRfpDHAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G3/7n74gI3fOkgVJlrFrpWfhtVQOeWKrUuOo8qxdxA=;
 b=lwbGOuTh5qH4j5a/63SIhnoiAzqomlWVSGKyhLIn3w1H9tVDwHEblHU6M4PJQZjKfXOJMSYcxX7m6wihn+a35FmRp/5a59qPpSRFvVhsmrLGUYsSI450s0xeAMMjDllbp3lCzcVji2S8jBm6O52jvWyqvgRwgUbYcdCsTSR/VSw=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 LV8PR16MB6029.namprd16.prod.outlook.com (2603:10b6:408:1f3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Sat, 5 Apr 2025 02:09:55 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%4]) with mapi id 15.20.8606.027; Sat, 5 Apr 2025
 02:09:55 +0000
From: Colin Wee <cwee@tesla.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Colin Wee <cwee@tesla.com>
Subject: [PATCH] gdbus: fix double free
Thread-Topic: [PATCH] gdbus: fix double free
Thread-Index: AQHbpc/SapYaCo1QX0SIw2qy7vvNV7OUUvAA
Date: Sat, 5 Apr 2025 02:09:55 +0000
Message-ID: <20250405020929.754988-2-cwee@tesla.com>
References: <20250405020929.754988-1-cwee@tesla.com>
In-Reply-To: <20250405020929.754988-1-cwee@tesla.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|LV8PR16MB6029:EE_
x-ms-office365-filtering-correlation-id: fc197298-e513-4844-507a-08dd73e6f591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?IQ6vnRcgRP4eHrzoOGBbW5uAD5KYW6TGa3rQ/ImmlBsNzSVh4n9TM67GFF?=
 =?iso-8859-1?Q?UixKFBjrxJl9qUsE+arOhupURY9oyINzKpnQGIh9HLHuaXGPADFgXFaOl2?=
 =?iso-8859-1?Q?KidxOiw8YFlq6bHe9cEvRJbxl3S+N3ALghIHwCL3g5/WEHhdI68zIhQ880?=
 =?iso-8859-1?Q?tf6q9zsaQ3jAg0eU6AgHewxgJj022nPsrIT+kHI+HuYQkfsyx1tQ+qBclV?=
 =?iso-8859-1?Q?ClCBDxFyZ01yU37S9d3tXLaPyB2jI5c8f/o7RLXxTcaX0W4EVVkGszx0Jl?=
 =?iso-8859-1?Q?vIipMoIH0p9fsFnX997LOh+cvcB3yCP6hZAc4796CTUNdkqqsKG35YnRUx?=
 =?iso-8859-1?Q?2ZCWOm6xSNh3AdDi/ly8rpX7w5o708LZa2iZSJQM8MGfNBHLiImNHq0gIm?=
 =?iso-8859-1?Q?jEBTGy7SdG3bEoPyaNZOf9MyV4OemAmgLuOsta2cA7Tx6HtCb9AqN0kyfo?=
 =?iso-8859-1?Q?2oRiz2iKsLkW6cu0XF/tnL/b1BU4Hases8B8KoXYsxO6+QeB8KQwc5TJOf?=
 =?iso-8859-1?Q?Jdu4fRw2V97oZ8BYwBNDKo3lk7qKE+A+H0warC6rnPH+FNIiRtAXymEE32?=
 =?iso-8859-1?Q?R65G0ydZRuUXC6K9AW7PsPIjO9ewYjq9q/9OFB6UTFrDnQKZ6wlN/lhkVS?=
 =?iso-8859-1?Q?dr85XBPLCtTqBYq3gO7Xoxr5qqSRgpTUJouyT5oF/+G617edNfGY+uomaT?=
 =?iso-8859-1?Q?hsHqEVDnR43lxm2b+u/LbdrSGDFifmg0m5LSv9JO77xKyrt+RJ1hjC60pb?=
 =?iso-8859-1?Q?CDVU9H5CDVdwOdSdkxicGYHarte10XHfZQU+Zdlkv0ri1pBkzNrbx9tJdG?=
 =?iso-8859-1?Q?lONUywV+jzyX0hZy0Enij6NnLtCNbjfWUE9JZN4ZVM4HBXZzzA6KVQI4E2?=
 =?iso-8859-1?Q?dLeDVD0pzmlFOhN3rgz4U3lDQDv/1d0bgvQ8ojYgCZdwG+MN+7JDUR+siG?=
 =?iso-8859-1?Q?W/QUoPaRKFzyHxlrBpZUDHsJM8sgbL6n7NHGxleVtFnoek0Qr6P3OObbSf?=
 =?iso-8859-1?Q?CVL9vLx73XYE7n5eM/7aWP5T/rHAKlnu/1agZdM77kOUFmGGn+fHHyGSFw?=
 =?iso-8859-1?Q?7lUZZB+mQpihzL6XvEHJ+xsm/6cSWP1J1CbHzbJ3ElUNHUo6ZjGLudT1HX?=
 =?iso-8859-1?Q?TnutME5nOcqPX27YcrqyVenoiECdfvClVtEGosV9Bk4pokytB/zGM+Vk33?=
 =?iso-8859-1?Q?Dqs9cIgvif0Y9YEPIuuAD2CdNDnw3NdDhBHLeRsz8s26+qZYnTFzhH5or+?=
 =?iso-8859-1?Q?EfUh1JTEzEG0hkF55tpCb7fkY4C+SDrbSLoM7V2ur7MufkzNOIyWvAJDeO?=
 =?iso-8859-1?Q?Qo87o/LPx+JkNRqsB2sMdSj2gGU3wEnpQB0eDCYjr0pApelgzsg5KEU/8O?=
 =?iso-8859-1?Q?09qHsCJjEnaVfHXVwjCvsX5tQejFSx3usc2B8KAhoifiPwCIl16bGEqx7B?=
 =?iso-8859-1?Q?lBMvLWRVKKPwvB8aNyy7vfkk1wJaK5s0APFBJFtHHf5MM3nbpiUeQE0WXM?=
 =?iso-8859-1?Q?aWdVSSfSU0U38yd2tRrtLw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?f/V2FsuvKcGz3FJ/YHcSGlkGw4e6+MeagOHtSNbgU0L0NxQP6T60PNpuyc?=
 =?iso-8859-1?Q?1nPJ5obIfuBGK29Zc5P01Q7Fvx2VMCmzQ0oDcW9bQ0DDm48lUlkH31vuwg?=
 =?iso-8859-1?Q?e4JT/mqpx2IEFdAAeOaF8c1hkzzRiugFjP/oSnK1/PFPMLtkQoyGgRg3FI?=
 =?iso-8859-1?Q?YxJRccAmSsxlrtBhpi8ElpLhJS6FYbNAMY/1wreq55uZGTbGPTEQ20wFJz?=
 =?iso-8859-1?Q?2x9P4qTTor02xufvty9RO3hBqWsbGfhVrNzB2forAnW8c+8EBQwdHOjPtn?=
 =?iso-8859-1?Q?28A/lTZz0nabHgqSmEkFFUaKpfeAg+vLKn5SkgfNp2EHCQGC5+NNCsLVt+?=
 =?iso-8859-1?Q?/KhLuPzT+NGGbltGeNqbFM4uu7pLlSdaYgYvpAKRHudgPiMYpGVqcpEsYB?=
 =?iso-8859-1?Q?nRvuUv1qctgZIf3Ne/ZQFhnZSzBTFkBwTa95TisRBxoedUlcaIwOorjMQR?=
 =?iso-8859-1?Q?L56mWQi/HpB+OxzOmht+Q3jKhepbtB/OoL66GxzOOFUty/sXBxXSCEFR5D?=
 =?iso-8859-1?Q?z/t9RLIbxAlhqXZgDDGkhtVIDGjXvu8yDQc+PIhpb3cmArAqd7CG58tsOT?=
 =?iso-8859-1?Q?y0Q1i2EYgFpDeRKUTQ9JFCvsZe1IIJzlgLM+FgbOqaUybWiai0c7F36RS+?=
 =?iso-8859-1?Q?ajQuSkNKN2ImyZbMN+ItHTyyGpRrHfOm3DntQXcdPoCRidB+nBAzku+fxY?=
 =?iso-8859-1?Q?Ga6+cGG0NfNKcJuCmvI+CfdzW4KBYppmeEJY7sYS0yR8eyBbdcGgHUQ7dN?=
 =?iso-8859-1?Q?/TT1X6EadYK/ey5PoV9Mybv2OGq+T1myePkTPHxNMWmLom40plfy2O3jfO?=
 =?iso-8859-1?Q?GLUMBI0bAOO6KBNA9QbihWT5R7blKWJjZ5Zw8OW0zje6hmpk+55DVSQMOb?=
 =?iso-8859-1?Q?YGbv9BE3MCnIL6HmyP3hGWq/B7vs2BTemvxBiAvsfmpuz3VuZ8wj6O8oZM?=
 =?iso-8859-1?Q?ynsgdIvvZ4aH++MlvUoL6aVE4JY2q8ybbwzg64iM23y0ikNtY8oUyuo0/l?=
 =?iso-8859-1?Q?so7Xdg7HcGC8sJ4uG1kok9dXZ81l7Fx5TgxXR3MVDoOi8FMFpJp7OxAQag?=
 =?iso-8859-1?Q?jhKxIAm/meo4LDKS43ws8NU+XwWWRx0RJzRHrD3nEvmf8K1s9zUp4u/bLl?=
 =?iso-8859-1?Q?G1GByBQE1crAqspgpkCD619ytkfso3+Y5JVLcdsv4kgnMcZlgfxFo6Jy56?=
 =?iso-8859-1?Q?WGjtu58zZyO34CM8c8uoyB3iSStUaUjL60RBt6mTjZ7smT5sG+2kgsotFO?=
 =?iso-8859-1?Q?j3v/PQtwdQXEG5/YU9e0NdAvWql8x0Sx1D4Uw6ALaDilCFYMYMFdVYjLnf?=
 =?iso-8859-1?Q?MUdkGXga76iygoQbdTFrNryBGPO/S76AnQiVCOaZQfrZt11K2/Fqhm0TNf?=
 =?iso-8859-1?Q?ZUmukeUvxBrKIviX342rgI7Pii9GllAcvggEjyOAnEWqAPwFT4WxXVsAXH?=
 =?iso-8859-1?Q?8M/6E7Bzhyy8+5mmxo2kOUMS62XYJtWbLVW/VpB9ltbIl7xhuMfr9NGi9v?=
 =?iso-8859-1?Q?hn7oGQPzb52LkEQWqB0g8ES27t4qzkq148Bmj6hlrqYtPZr3SDz9VJMS3h?=
 =?iso-8859-1?Q?RUoWUadUR1Ron4CSCHP0mGrdSCkXDwK1gaE/2S21CTfIDEDdV+0IOjlAYm?=
 =?iso-8859-1?Q?OrKLiHqQpVrbDyfZe16RbBWIN3jJX+W5Kf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: tesla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR16MB4504.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc197298-e513-4844-507a-08dd73e6f591
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2025 02:09:55.2920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z43iJdR8jz7/VeNT2dQ9G/3eBbcG68+8Qje5IjYg7AoYxNj4kkJLHSY+fvH3Bkdk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6029

These are freed later in filter_data_free.

Signed-off-by: Colin Wee <cwee@tesla.com>
---
 gdbus/watch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 8fa76cda..5cb2167e 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -332,7 +332,6 @@ static void filter_data_call_and_free(struct filter_dat=
a *data)
 			cb->disc_func(data->connection, cb->user_data);
 		if (cb->destroy_func)
 			cb->destroy_func(cb->user_data);
-		g_free(cb);
 	}
=20
 	filter_data_free(data);
--=20
2.49.0
