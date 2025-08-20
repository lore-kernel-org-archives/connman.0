Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6F21CC71
	for <connman@lists.linux.dev>; Wed, 20 Aug 2025 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689623; cv=fail; b=JVUpnTLrIU1A9c0wiYryiNVeb41IN2jOOUXOC2Wi3fldep4mgtl4pD4qM6wZ4mxVx4TEjS0HdVAUwu+HA8CMf0UeZxKbqgS3UEsIAe3xRUazGUQIpE9iXZ9XZzx/N+ToB2tARp+60Ia/tSTIMA9awEFIRIO1pnkoCiG44IA/14o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689623; c=relaxed/simple;
	bh=hQIT1wKAPwSht1NHgIlsUY83YiNKMAwtmqAgUD60AlU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=co4RowLoNvJ62bNnPBGi0oXSqgV8D85tGw9btoiQWqv/jgsg+Ad6Xlpch9PyCHAES/46RZnI3olD0ieiIxhKhFo/yBbvWyP4W/+xc8Nz3op5cNOIJQYvWttH72trmotgfgdSy9X/s+DMHRiRETP5KwmbzfpMz3NMzaK8aQloKyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=yxYtBBL1; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="yxYtBBL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD6TYdPA1orZC+Z05b7FzhGn/e/MAMJykaz1z/fy63Cdj95cO7W95yuh/CIimxJRi5XyOVZ9kT8oJugbSszEGkMXVDq5pzVdN4Hru7VG03mLl3Uuz4z4Pwac8jgqsIVEeTyqu/yaIR14yZrXtlNnKzKEv6c64BF5uAH6ALQuc5DcQ17bfQ88bnXeLMNSNNlT2BtqraWBIByODqdx+5IAyOWzRtXZIur6TLKt0ZDchqPLHkzYLzXzSJ0P0aLtt+iPoxiBeXBFLMyMPm/k5jaZ+Hu+/YW+7QRVk0UQABMZTCcKk807Le28pF5LhXfjJKY0r6TcEpe1bTKnyRYnauVftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQIT1wKAPwSht1NHgIlsUY83YiNKMAwtmqAgUD60AlU=;
 b=gXtAP+edutNEFfNILnej0+RfdPs3BdytLdnpH9ZJGi40ZyLr4sd0tix6OVTYHC9fAe5FO47U+AB+c0FWznFgp9DB3drYmiR70jJVVYjOrP8glmqqsWraFSaGr5XOf6bk99gRDjHqIQ7F2zkjO0tWX0sv4anWteXUQxPXFu3opWtfnWLa8gkMn1EWJkZO2p1bEjhc00JKZf+7W8Asuxo/NS0im29wgFI4n19L44jbS0pEnP805TgXyZgRhTptNHyx8Rem1tKAZN7QE+vtBFePDrIhAiKaKFnmXdmYMTPBgI+56+DF33szhK1h7vbMzOcxPBCWH4kgaw293wgfn1aRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQIT1wKAPwSht1NHgIlsUY83YiNKMAwtmqAgUD60AlU=;
 b=yxYtBBL128W4JJrpu08hCBhPsERLFhuj/uXQzjAH75q3liFjFo/Hai0qm+cxJyaX/SZGJEs/FaV1Mlk0EQ2wBJT+kO5AYdj0DV2/obvK7UFrr8ikZl9NI6VP5onRYypP/KdN1UsDp5ouClZ+ag/MhAXgeNFWgQkLspR6Bo/JXES9RAhHMdjnrgCb9W8lRf4l4AMp2RcKbwDXewe1XN21kuEGOva23s+i6aD0YorO8573DR77blismMmnBuZ8b8bpQzlR7qD/fyG3XEXNHbxycHa9fgXZGOc3SlTngPx+TogfASF+lkkUrIxRi3pBSq2oJSH8Qr6K8/gdtkPA9mkdwg==
Received: from HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:62::18) by
 PAWPR10MB8239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:33:38 +0000
Received: from HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35fe:4513:ef73:45d1]) by HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35fe:4513:ef73:45d1%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 11:33:38 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <Sven.Dembianny@bshg.com>
To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: AW: v1.45, broken wifi connect
Thread-Topic: v1.45, broken wifi connect
Thread-Index: AQHcCDoLcbNVKf7saEulAds0rK8QjbRraU8g
Date: Wed, 20 Aug 2025 11:33:38 +0000
Message-ID:
 <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com>
 <1082538859.4574595.1754637525886@mail.yahoo.com>
 <211116062.4586180.1754639815460@mail.yahoo.com>
In-Reply-To: <211116062.4586180.1754639815460@mail.yahoo.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR10MB1690:EE_|PAWPR10MB8239:EE_
x-ms-office365-filtering-correlation-id: 5d10dbca-be52-4dc8-7b5b-08dddfdd6866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tjXtyqYrOotoL8fRJpX0VB0EqpQyMjBG7lbqTk235gw4Mnyt9ybupkvGgK6Y?=
 =?us-ascii?Q?hNpJNby7mpiEevLFjG87qHl9s8Yw3UVECjyQXScAPapGXAYW2qbxG8m2I+2A?=
 =?us-ascii?Q?zokN4xkFZVbzMgFpvDQLuv/lo0pvxzJ2r/3fFdCAzbqwbux4SUgm0/Hc3Ja9?=
 =?us-ascii?Q?zz9WCfKFZTt9+RUi5fk7gD0vAesXeYC/l5qK0Xb6Qxs0i/KcJxHR2t+Ztx0q?=
 =?us-ascii?Q?/P1LfgVKjwYQD1LH76zp8C/dwjhXHPq/G9n/naxZ+9kTRxYMy659/M+w2v8N?=
 =?us-ascii?Q?6mT1+00jNzYdUw7/FzP5cmfdwFGowxLP+3Tts9a5dPNWDXfxbd4bEocMW2xE?=
 =?us-ascii?Q?BXn1sUbelYp+ZKfIB5SoAma0dQtzCDbYn0Rc3NXflk6RSpb0Gk1hzplfj3dQ?=
 =?us-ascii?Q?xakzvb96KIhSmGdoGeJRO8T9u8DANOck4gkblkbo0F30cxZAhULhUCbzRHZV?=
 =?us-ascii?Q?5q1NEifLFG+Qv17R6XVBhfTQfnDfqam9vFuCZbWRTdzqSbfTRTSJLGM4vaL+?=
 =?us-ascii?Q?S7vEYnundJN7sTdr+t2lMVMfqAzR8HNAWr3Ksz9kd0Thf1nbCgY3sG798+xo?=
 =?us-ascii?Q?OQctqbajD+1dhvLNV4kyvVJ0EWc/azVfSjjjgD58295QL0lhhX8tSmXnat8b?=
 =?us-ascii?Q?VJTL52BI/k0a7tbl2i1lrHkfiVhM+Z/mIHAMvRlgY2afnYXpdNGM7zrXRvnO?=
 =?us-ascii?Q?CpRV6euyW4OVWnYwqReo03wZ7YB5zhuEY9RshD+/oRZ31TDsXV0FEhtoNXxz?=
 =?us-ascii?Q?FjLDzGkpEViUZEfbV/ZyBYFNljEbCIpTqxxRTHj/yxeS3fenhaTLNNCf7MA/?=
 =?us-ascii?Q?mBftylQmRvx9qIMm8IIIhYGgG4LaIc2Q++397I3G7ZwDuhAVhE2xYlP2UbIV?=
 =?us-ascii?Q?DgA/8FGzNvfXRVtr78pee8194iXf7r+UXbD3Qz/ETajwQR6/gEgzaXJm5NwS?=
 =?us-ascii?Q?9exNvlehXM0DkNIEbPCd+Ksf6Cn1QjZ10vYZQmLcMvHDojKB+x36PBzhJt4Y?=
 =?us-ascii?Q?IQovtvHjivTsPBRv43RTeNgDTH9nGDwziFAkUcCGStrZmDB4UakZ5Z0SqOAm?=
 =?us-ascii?Q?aqd6SaKBThU1+JG7qIvLS7kYkXjrMpbmdk0kpYPPmriuyBYjYBmAaFavKv6o?=
 =?us-ascii?Q?fzCJGU/WUCzoYhT1dM4zxJBj6q5dYEeqSOPyeYD9S1GvcHcNJI9RMcbyZndr?=
 =?us-ascii?Q?b+CAGahvEhCk0xVwOGxJAwEh9+pVvyKyGFOgt+qYDGruyUEZv8iJjPma0I43?=
 =?us-ascii?Q?lw0gmClH+B7c/7mAWodGDvhpm1ObCorh0FsvsEqM9q/bgUB4npSQ/XcitkM6?=
 =?us-ascii?Q?tOvE1IwUCkdaOlN9mJ5joP5m0NCmMJPuQH1f6zHTHnTJLBfuKZmNbBTRGjy9?=
 =?us-ascii?Q?3cdbYvqd9s360VfRBQpCErLJdBzWg5Bq9687Abk8WAxsiC7RiyZHHdrMtr2S?=
 =?us-ascii?Q?Vs35DQh6Jukyv6GnPRDqE1ZKHOKmf2goNXqVBfazpAdw/L+e97bELg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tMBeESBP8sA6cMQLLodpz1su/hdN/qUskEzafwNn7N908mznctpI1sM/oAQY?=
 =?us-ascii?Q?LLCJ7/q8IJyf8iwqcclmNbwybssz7YyP8AYU1p09JXX8JNmt3vD0/qOOtSBP?=
 =?us-ascii?Q?oaATIZbklp3GZYBXEXddh9adw0qlo3Cg6NjQFchR5TnPggJ8PE7dRd54h0rK?=
 =?us-ascii?Q?b8l6Q9YESPx1idebwb5kK0gwQY5/69u5plHvdsSKF+mxSdnSysNWtbMjnjYx?=
 =?us-ascii?Q?1tv/oWmPxNTESRI683XiV3p09js/Ufi8etexIjVCpAFblffDAn/OhGlvigaI?=
 =?us-ascii?Q?nd4wV7gxC7XTgtdESr9rWyqnIPE2ZP6tedDFFH7EsGVg4OTUSt4KabPgacZ4?=
 =?us-ascii?Q?98d3g49+mEGFenSmDjnYEOVC+veMWfLlTQTsdxUyQ1Ej741IDFJ/1Z59BOtP?=
 =?us-ascii?Q?YbuPoGzR1Re48nRXaHKXBPg9yRrLBIqY9tRqPxkk8rEPDCU9N6IpN5QdBaDv?=
 =?us-ascii?Q?RsiW7/7PGGLaih3a5c5O/6YaXDl8IRxIfQLqFE7MJ3q1RYVHG62QASUGSd+T?=
 =?us-ascii?Q?2OhB8YzA/ODE/SoL1nS29oZSN/Bq+HJFld2UtFOYx3p116tNDOQDYnCJRwXd?=
 =?us-ascii?Q?1OkmyhfsRqyKEwMQWtjKu/+wQODLEa42XO0+RGvnonBaTzVNcc9m6nodZ0uQ?=
 =?us-ascii?Q?Ho1CgbrPorjJliQnfWgSq+d71qcDgYKh1rVKniT8yb/1kcd2y+AFwytrb0B3?=
 =?us-ascii?Q?G7YLvtgpMPeNwiUHsSFlM2aV2O8gXVBRuzK4MrLqZTT6flKTwR3dkaLBdzel?=
 =?us-ascii?Q?XCdq4k3E7iNJRoJ9jl+O/K2A5M4rWba+6w50uLdxJd90pFQk4EsYVUez2VsX?=
 =?us-ascii?Q?ekqpsXA93+JxIKhECpy21pGdfs7TC0h6tz9s/Otv5DnRTy1oq7CXFqqgqxpx?=
 =?us-ascii?Q?/iKHMHDbcEg0t4n+E0GxD2no5NsTzKzGIJ0cBFD7w0DTZWQRSRC2uLaMq+zd?=
 =?us-ascii?Q?uOlOstubxfkLMMJcI5+V7vdLZpRL6F+xZbABeYpDIIj32A1t8+XneyGwRHox?=
 =?us-ascii?Q?O1hhpOwZX9z+JeobPpx8jf70GW6ULE0C2AmGnZzWSwSjNiN1+sCU3Y5bZ3n2?=
 =?us-ascii?Q?5fsFyyo9sKuD8oy9H2hiiFhd/ovb8lNJzJzNKIZc/QN0Z3aNLyqL996CwBzv?=
 =?us-ascii?Q?sQPALqVVGQ1cNy13EFC71qH5XMBOT4HVgcjrWZ6TZh7UrhWs/KluU7/NxM8w?=
 =?us-ascii?Q?3HfkW1KMGVf7/CVQvHQ9pHTDcgl669dgPYdCg7y9vtbJTa4Q1s/UuesTrddX?=
 =?us-ascii?Q?pwiSyt4MPD4wdTy+oijOo9iBXy8ttgk7cacWaJ6L8g8Rjeay2/LWAO68eTMu?=
 =?us-ascii?Q?eL/vgKAmdV4dZChBjWCWWkuFnJ+PRyQeNfR2WYDCO+hLIK7ZqWsLZ1ND7vCk?=
 =?us-ascii?Q?udyJ+4YbvGOC4H1nHEhvpUEFN6nZKJ40bMg/8W9z0bEnDsKN5tZbsvRQGEmt?=
 =?us-ascii?Q?3FfyHhrFoM3MhHVujkakH+PmMFH2HxcN9SWbsSdVZIS8vwzkhRm1PXXoD6/m?=
 =?us-ascii?Q?OxUHE/yFu30KhuCcI4vUX6ZytFJmpuJWc67V7CmNsJcbNKbhOrdoGibEvOic?=
 =?us-ascii?Q?9E4vrBwTeETkHCDwDnU=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d10dbca-be52-4dc8-7b5b-08dddfdd6866
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 11:33:38.8755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PB4yKi0uiEFblPsVcG55hE3Zht8k19V5CKlhq01/eb/Xe7ctaT37GfA7kxLp56oJEIBgaxRA6f0aSZPuHLYWhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8239

Hi Portisch,
>=20
> Hi,
>=20
> current connman is broken and can not connect to encrypted networks.
>=20
do you have more info about your setup?

We can't reproduce the issue with 43455 chip.
Which chip do you use, is it WPA3 capable?

What AKM is configured on your AP?
Which wpa_supplicant version?
Is SAE activated for wpa_supplicant?
>=20
> Revert of this commit do solve the issue.
>=20
> Error log:
> connmanctl> connect wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> connmanctl> Error
> connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d30303330313536_
> connmanctl> managed_psk: Input/output error disconnect
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk Error
> connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d30303330313536_
> connmanctl> managed_psk: Not connected
>=20
>=20
> With 1.44 there is no such error:
> connmanctl> disconnect
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> connmanctl> Disconnected
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> connmanctl> connmanctl> connect
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk Connected
> connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
>=20
> Thanks,
> Portisch
> Team CoreELEC
>=20
Best regards, Sven
