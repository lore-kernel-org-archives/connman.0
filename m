Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF5176FC3
	for <connman@lists.linux.dev>; Fri, 10 May 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385124; cv=fail; b=bw7l05lMNgR6GoScVetzk2ALTl9qEg0ZSr9alNyREYVre+26c08QW3tdTayOMeBG9gTBR8VyQI6MYSdmTGjAFOGAXc93WNsy4sAEw2w42eDHVO1FPWvj9Z0k9SSP7O74REjAN3lu6cJ9bLDb6FlmMAUdzV9DkRsi4d3PfuYATbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385124; c=relaxed/simple;
	bh=Y09seH6Uzov97GwtkOWZ/fFzcpNiwVtot7DE/NBFSs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eTWyJGOiKJjlYNbiYaGN1vH3A483qKBMeJdI0R2eEzzf5d1bBKNkCZnmWU+HnBelv96QbWTqqMEvzYi07Z9FfW/HOn1N8NmuLM4XDlgMmwTjSLOLl40xkZqrrhbO7Dx4gVD5UKMtQnf+0S8GQYomCcnDKsGdJuTdi8qtYoJ/y+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=Ukooa+w9; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="Ukooa+w9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwb7QDlIojVHEidbTuSlWeAujuBwz6a9/C2ODb4N2jFmMQzK+JGo+B+RIUluCHcuu3K6E3PoX+xxOe7CwyT8+LIv+JDJEu/Fcnp08y3Etni+J3ZJjscaazhpYv6jOyb3A71njvkB8RXvI/NxDA3GfyZUAqXJpq1pyywgj/86tfUIp1iHc/I5KqSL5ZGcvi3TeKOOaHWtdxXQq5Ecp5b6SbuM/TfIzyH0Fk0BFgtC/5qU7lduAD25b1WO61Phec1cFGFXcWsPEX5O0un5KGCCSgUnwuNmtCg0iQXCEuEKMOC3bFBBAPHafOPuMbcrbIOhCQr77+0uQE4lVEhpy0nw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y09seH6Uzov97GwtkOWZ/fFzcpNiwVtot7DE/NBFSs4=;
 b=Jc/FK/bKH0YMzFywDPqJp4gqcRj5lUYGB0I7a0yEbJa8t/689qtiyJzTIUaJaFJpNOl33nXbZGVrhPkG6xQ+YnJhxjF1wNBhN4erQVJexzlPj6lUjgsNRqdnksI1UpNL0EYm9+TbbILjlflSL9KxS0Wy3v4KJjTNed30N1ImfX4q9Rl8dCCg3HQ1WBT4nRuI4vxCqhQq6c/3cAq8kGzSey5/bzKM4oFq3Wkc3D2EOFSO8jtvtRcDYI0Pv85clpj9sgWBf0aa6mNMCAxK1GO4ow3IIyZqfpeYrEVy6ns54hOKqpntAInZL50rV5QxbtgdawiaI/iGCSgHyF2RZ5TXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y09seH6Uzov97GwtkOWZ/fFzcpNiwVtot7DE/NBFSs4=;
 b=Ukooa+w9ytGtu1PXL61Dn7ROgBXq2Ayw4rJSxMnHgQ3zAF61q/GYOBjwz7/uJre1LlavEF1Nqj35a5JTX5eZFF3Zb0JNQpGyfU/Z7x/fttL34cxnt9P485ttXG3+JebtBPf6l4Kk6WewOvid0EGBk7dKknJS8SsZ+xXXAmRQ+xo=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 DS0PR16MB5368.namprd16.prod.outlook.com (2603:10b6:8:167::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.47; Fri, 10 May 2024 23:51:56 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%5]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 23:51:56 +0000
From: Colin Wee <cwee@tesla.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject:
Thread-Index: AQHaozUKalv0S/El+U+InFD1TOkOzw==
Date: Fri, 10 May 2024 23:51:56 +0000
Message-ID: <20240510235151.3624494-1-cwee@tesla.com>
References: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
In-Reply-To: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.45.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|DS0PR16MB5368:EE_
x-ms-office365-filtering-correlation-id: 3d05fba1-3246-4547-1380-08dc714c2cf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ee01s2kkuCx31ZeSAjuctJMYjEbV2qRwTHAiiPC1GfvzOc3JVkQdrnKlXR?=
 =?iso-8859-1?Q?Wc2XPtqeqfsUxtrEPoU9EJgcjeproY+f+5O/qtWPf61m/MkjhV0uFpEsEK?=
 =?iso-8859-1?Q?oVdKyiMeMTd/sdo6E3wthMMc4SMvIAZwcOgglckwzOGIWlHLq5pa6tRLYc?=
 =?iso-8859-1?Q?M7qZmFp2IPilpFGYu9MxOeL3zy2u9sGGfJpv0aX4sH1nQb5b1KnF+RSSyR?=
 =?iso-8859-1?Q?azC18nxK3VgQuXZcsbx0aIiEnwps6qXlIEft+u3aViLKbTOHhCiheiOOK5?=
 =?iso-8859-1?Q?94ofW2WQa1fd3KW5qLN4lKWk+tTzyUrwRIHxGuZUo55K4EkXv3xHiMzpOP?=
 =?iso-8859-1?Q?m2dc9RYFOJa4XTW6gu0tgSL9RywJrmSd9Wd7lTJkVU4EzYdOa0xXFoDd9P?=
 =?iso-8859-1?Q?tTSDTYQKlr8fT9xLZ4yaNy7NDazk49T9n9BlacJWkjmtnWux3hQKHiADNd?=
 =?iso-8859-1?Q?eD03eA/sZEi+Tksj+9CmS10xRAF+waG51+1C5EQqZ3yprkKmSw1rTdg+b4?=
 =?iso-8859-1?Q?YpsMRHY50rz6Jh+6qCG0J1Mffh4oR+EI5oHfdDpMVE/RTTilmDB8slZFFw?=
 =?iso-8859-1?Q?I0IZsCGXU94y1vLUExftjN1tnC5yxllgLcEQVW9yfps2fm5qgajiaUmHLj?=
 =?iso-8859-1?Q?mSTtUc2jq99g/A82SXJEYcVV9ZFKFYRZeX6mKwJvh24OrbR82DE8OKCk5L?=
 =?iso-8859-1?Q?BNaY0sQO5tGpqjIfz4LULye9hBXf3YZyB8xowTuss+PLMbmu0uE9P09HHI?=
 =?iso-8859-1?Q?dfUfemdrb3PBI84GTAjdWPHR8B9GfK8Fk24VIBvU6N9xpSlhS7rErp8Ul7?=
 =?iso-8859-1?Q?cm7q548niq1JEYrBcdZCTOCJ2LRwcEDkAwYU8XVNFwlitc3Qtx2bYzQ45n?=
 =?iso-8859-1?Q?xjSZSLYlCCVcocsyneUWAX7rBlZetQcxBcZ99p/f8WkTUDMr0r2910bZoZ?=
 =?iso-8859-1?Q?opLgeiDNc+7nJXSUtvUBV65gXMZO9p7sI6r0cN6VrbtkTKlF1KC9KgpeZI?=
 =?iso-8859-1?Q?gdJxo1kbYVAQA+Z9jPN7utPVBZBQMrf5g3Ln60U0yNJFsWxqlDCCHDIGkc?=
 =?iso-8859-1?Q?Ge/8qi/+bGFHYk8kc8VNilrODWHGcTBVU5LYom7wydPrcZ93agxtJjFx0Q?=
 =?iso-8859-1?Q?ykKmYKJaGe1GO9p/tsxfqeWT+Iv/B4ErUdJm8NMEsOwrtP9U3j91cq4iCm?=
 =?iso-8859-1?Q?i0k4HNSHn7zerFQKrDKmZqLL53mEJz0FxpSv6IS8flCNaTlsOKwtgZOVt1?=
 =?iso-8859-1?Q?CQH3MMmpFp3A1BCQqli7ZTxg51Y2AlEyofEYkcvBVTPzK7lDmh27MxhQON?=
 =?iso-8859-1?Q?qpqiD06QyJwJMNhpstoeCdJ23BYQhaWRIzaIAIoLwwMsxHoZmUw3b2YlQV?=
 =?iso-8859-1?Q?V08FIhS/z/GyW4edB0G7XGrbp30ARvLw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uCZSNGr1N5K31HhNCDJDRHcjDFNC8TETgvv1s8uCVCD4iqKs85qthBvAs/?=
 =?iso-8859-1?Q?Huc4VewmgiT1R7AyRvysTEHG6peI0KojXHEpi9Cd1Q5dShe+wseHwM/Idd?=
 =?iso-8859-1?Q?nxeyD/pv8OIVgu7E0IUytsJSUjFrVAlU5wHCy+BovYEUUbRtgr05t0Nkef?=
 =?iso-8859-1?Q?k7CBgbq0OTWajZBJrXc6po951bPUOlcHKWQZhFiNMc/JEx3w1nnDTUzKKs?=
 =?iso-8859-1?Q?zRitBINW6kjtH28K+1Zxx2FiNNxhTIZN9wjtM4zNaapRiMtMrEKQ9zuzQf?=
 =?iso-8859-1?Q?7Yq5WQA6N+aoKKIyyFCvMfg+xF5t92m4I07dTA8xT4hngfyx6lSI2qUtwU?=
 =?iso-8859-1?Q?dR4xM9LaFL9//DaNiceY0EvVqSbRaxkhgLfr0BPH1gvWQzi0opDYOWC77p?=
 =?iso-8859-1?Q?TXbpj4dlnBaBuyTw6CocZKIA3JIcOxLC/moRXcp6DAWKWMWdVbhKzJFbN9?=
 =?iso-8859-1?Q?0pOLtKyVFbaJ7XbFw8gA9UcctIa1ZRw8qnjNvZ5ykfgPH7MgjtVt2gkwfA?=
 =?iso-8859-1?Q?9U7AlCqFnP0KSDKBNhoO7VZs4+fmalMGCAyO5CNu33dQ2QJxLCALmIamyi?=
 =?iso-8859-1?Q?luufw0Pf7ac1bLhDu0uXbCr9csQqy+qXIUEVTOKtc/WxWklb041EEdEVl9?=
 =?iso-8859-1?Q?t9BPoltPuJVL4Vh1snfsq7Cq7rdxZVfbvsac6+D9YC8579XmwgdrblA/aI?=
 =?iso-8859-1?Q?3bHYgbtrug30OVEop3ybS2qIkrz4etUrzU3mHurN1icz5Rdaacxy82vmJX?=
 =?iso-8859-1?Q?1dgGg2fcNTHcaNpy7+ng6WjrPp1lhd9BnZvOfh7wbdJC9tkcMrZZ08BHww?=
 =?iso-8859-1?Q?9vKWZetwNvjB98hs81NkB9DVnoaqNA5W+sJSLk3Vi04clwVNWRo9vveueC?=
 =?iso-8859-1?Q?u6Jrl1jMeQoih+aTvOLszP7yjryoOinmN6AUgTLhmGTB+02pNjyu9+f0sd?=
 =?iso-8859-1?Q?v/rE04Fsfc8L0huPxj00dnfBqkiKoqgrY9Cnj6RQpjlsKp2x241q4JMwVv?=
 =?iso-8859-1?Q?DNpcvVEIP0+qePZ9GIYi2sgWEqiHz5vRWUtCsknXqjlBuZN+7K2AePiS1l?=
 =?iso-8859-1?Q?ws1mcYCV3wb9Xad0YESuoD7EUI2NY2ZMGu4EXxgRvlCg1NSb4fix0ZKBJf?=
 =?iso-8859-1?Q?OR30XswoRy8C8kL+W50ZPUFiGUD7utAKEo7Gj6Nfbdx8+xaUx9i2orevZD?=
 =?iso-8859-1?Q?rA61BqRszVKhko27gmKNyhW22hs6jOk3o0gDk+xOshYIw0Nt1qduwjvEi3?=
 =?iso-8859-1?Q?L2XuB0JoK460zSC1qJ+ccaCDfXTIHyzuLsSpsEoyybQpKTFLhBiAOvsA6w?=
 =?iso-8859-1?Q?gPj8T4RUSm0jAE5f/fFCMfnNLzyrsf+n7tkxZv6yntEopIAyZjPWavphBc?=
 =?iso-8859-1?Q?+iITfA8B43/mXDIYyo6Ypn/ATGQB3Bam/Hy5FHmFd/wUloL/NiEMtuMgGE?=
 =?iso-8859-1?Q?5qV7msO6JTBfxXFRndua8ZPKHgwiDQdKQ2jAJ0fscAvCP2iuHWrUeKWqCh?=
 =?iso-8859-1?Q?zJMH6d97caT50XItGMpkdJYgsNzQuEqBYDBF8/wGYVxz6LQqhhKhsAkW1n?=
 =?iso-8859-1?Q?SBbluxJz+EMnQc6BHDuCC36LEFnZcO/8mIAHhlcmxU094u3YME4zo1hd5H?=
 =?iso-8859-1?Q?0AF8Kp/9NOQQtZnp/5woOVv4XCJwwSx/iz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d05fba1-3246-4547-1380-08dc714c2cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 23:51:56.5443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPLc3kCodHTHDHWS7rndav9551q8sovntyibLGZQ8748URJkAz8jGxvLWpqzeb+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5368

Sure thing! I've updated the patch, let me know how else I can help.

-Colin=
