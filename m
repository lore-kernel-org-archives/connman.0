Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120089.outbound.protection.outlook.com [40.107.12.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B03FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 08:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1BJSfGM+1RiIQPW0qM9TqvFRvrNJFYS0HFlngIXmEZj+ZitN7eSu4rOt7folACSelv+TULo2gjTO+v5dtui1kToPn8bdqvN/C+i4EtlxBKNK8OfcS+faDfaf79Q0HDLvegAqeAfDt6FX3up4tZ8gZa+828Uosq2d4Lkc1/mfKPLJh7l4J+lUUT0deh6Q5GWZV1igLnj/nhngUxdVyhfb4DTYiO+nSRqvj3h4m1TeDmG503PWVXRUUNwH65PcBJ0C2gwdYWB8xTzEJxVyV6mG+GzSzXDzaUwqrXp9RMlhk3EUoX+tSJfWdt/cciXigQgLak0f0Q5UYX5GcPKwNSXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8mNqYVjxOBph4eyBjk0RlTQ+00zz5ZyAL6udzV1Ww4=;
 b=WunVWajnP+fLppEXzOjA5e5DmX9QtOxCEtFxvY4qEbJ7w8fg9XxEAEj+Nv5JsO+6AvN2MBch2iGJlDMpJHQdfJNBOx4LrqQk1Xb/66+i8LQK88jlKVV9te302BJM6iYlup5ryvxETlk6zXIfX0uG3u0U2DU0ZrvguvP+gL1qSGd/O332nyAIiqb1uJjKSKdvP4YsSx+1xSQl1MEBaALdzoaIyYUJsDs1nRydk+PJdF7nMn2VM0TDFKX3aJvgiTLdRKYS21flarQy3RDfeZ+bAzgQcB0ln/NmdUgskhEzysnnRaE71++h40xLQEUUxBYto9518abf0edGop3hf3U6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8mNqYVjxOBph4eyBjk0RlTQ+00zz5ZyAL6udzV1Ww4=;
 b=zEVh+klxWg4IEF6WxLzCFeOaaiTyfMnys0y/ybHC3nBbiBL0tlJj4gFpJ/L1KLHmRkmH8MwZoyN5Q/jg1gl5FCQVUgU6KG5DEk57O0ty1EXIFNcd1/Yk86DedBi3guv8xUmYdW4JY5CTLU6u1QfgghQh9RXpIBODfy23yz1H4eE=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2332.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17; Mon, 4 Oct 2021 08:08:38 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 08:08:38 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH] service: Report errors to user in native mode
Thread-Topic: [PATCH] service: Report errors to user in native mode
Thread-Index: AQHXtr6T3NUblXLl20K2GhnbRyD0SavCZi+AgAAaA+I=
Date: Mon, 4 Oct 2021 08:08:38 +0000
Message-ID:
 <MRZP264MB1544C9BDFA1AF5DC3557934493AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544E59B5B25F0CF95C7A07993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <163332924025.22211.16547270907956272336.b4-ty@monom.org>
In-Reply-To: <163332924025.22211.16547270907956272336.b4-ty@monom.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: a8eada6c-b8a5-2986-27e6-994a95b277b5
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f5099d2-b85f-4cfb-a1cc-08d9870e2bca
x-ms-traffictypediagnostic: MRZP264MB2332:
x-microsoft-antispam-prvs:
 <MRZP264MB2332EAC5679F355AB2624C2093AE9@MRZP264MB2332.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A4vF4orbyfBigo1P50VD0fKsxU4zNPQ3Pj0xWwUZkHzUyTuFu3KrL23CBypV4brhg5fAtiGL7Ln/Im5T3hfBzS7BZuBY9tPBaEWZRPa0rwhM4hvIlhiNJsiYdWXJcF4W+2s54mZH0msA8nm1lQPTaCktKkw59KCNm18ssUwq+bswNLUrBC56ySeCOLImlclmpZnowz8/DfBQ0MvDhLD0bGQZClGhzYl5fdOM/bsr2w0PsitU3b8TDEZXdVQPoJ23mkaZHT8ELcYtTMccOBv41Yrl7fU5eqd0j6kErPSq71mwsfZ66B3MRlEgN7XYWe6XTeDhiXiXLl1LlfqjAX6yhg2GnB4hL9uZrCVYyO7wXMxS4a6Wt9a/Dd+8+mqMBgywKQhWx81cUhx019aSSK7bfx49OsKzBHhERke9Grg2+erlqz0Qc5bW5nWVkNovq83Qzgvp6o++KyKSmSjJuGOKku7VLjUNkFM40IQBbNAfhVSNYRzaZuEFJjYA1qnAFqxLmK3kAJKqfvMJUzsPndlr6XdCJQQONAn37C1G13pLvqY0qNd62OXJEkjugfmnLeCa0jHK5LJps5NPzAGmUxfCRWVJtxhmUYSRAd5/1QVgaITZ5rDM5undjdhmlyBFdGwgMYaUeY3blnAWVlpHnGnp/AegQJRRRWNP/CdIrQQLpJ+3a9qH/tfbYHOfHUb6SmERB7QiqWAECIrql7VBcJQAPg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(33656002)(71200400001)(6506007)(9686003)(122000001)(38100700002)(8936002)(76116006)(8676002)(91956017)(55016002)(2906002)(86362001)(508600001)(52536014)(316002)(66446008)(38070700005)(64756008)(66476007)(66556008)(66946007)(110136005)(186003)(5660300002)(558084003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D7GBxi48mJfOj73Qgi6KWwTWR4fHFlcVt1Bd9hDLNrpiCFqDDGt+zU5FCl?=
 =?iso-8859-1?Q?VlhDfJPVuJZZq9uxdR/zvPK37T5sty6UVeOd0HF+FvYJ7SdVgjxsVzPbou?=
 =?iso-8859-1?Q?bOqJiTAYr5WZFW/Cu8WH5wS7Cog1n0Lcmcvaouh0R+EoclFU+8R5GoXe0v?=
 =?iso-8859-1?Q?MmOu+3pLxgLVCw/am1FXFqb5Lwvo7MCuEtnYr8hCcnuMi6sOxQgpdAgc7k?=
 =?iso-8859-1?Q?JE6WScVRehVMb2QNd76OZ4i0w/Uq7+SuEwd2hi5YMrnx8x2nWYBT3POvGE?=
 =?iso-8859-1?Q?VbaEOauumIRsIeh80JisZKMQUJESHC9ZXkGXOS2wZLDlzQ7jRIo9orTMWz?=
 =?iso-8859-1?Q?GrdZOl1bi0I7AMxHLZFFvGDP/s70VdTq+hV14vpvih341MMXZUJqeHYwbV?=
 =?iso-8859-1?Q?1iJ5XfdiuzQrJHl46gtSK7krt8ASXPlY/zLpkrCQ88pMZeAVUS6KiJ6d1b?=
 =?iso-8859-1?Q?bgmfgmqIV6kH9p9rMhI6kjA46nS3ddkbSNUBdMTOJwXTMNfBFg3Mrt+/oS?=
 =?iso-8859-1?Q?RzV0nSsIBPKYH9K2d5SSOt9EOuJNIG52HpByuZ3CFhJE1ZsvDZptmwbKR1?=
 =?iso-8859-1?Q?q2nST7Cmd6HRCqqdZKWqg8y0uxquetDyRiNIQM400vjgcA/ZCDrMC0Yaz8?=
 =?iso-8859-1?Q?lbpA8euQ0AjwN2eTFHbWE2gMP+hVBcGhFYaKweYJY6QyOXC/Zhe+oRjCRT?=
 =?iso-8859-1?Q?Az5tcvDxy9tbZ3+/GiI0N7VuPD/U4hgmZXw+e/Z896MVEKYOvXW2uQx6uf?=
 =?iso-8859-1?Q?XJssTHu/xAiRxPzB7kXnOl2nM7kVZT5Ewg6oEm7HMEETp4obhLU+mFfpne?=
 =?iso-8859-1?Q?pDSDn5qbCjdt2P7A+ag0b3fvkAMilWpIwPb2oliH0EJJLYlksYH7DFhb70?=
 =?iso-8859-1?Q?8/fOYi9iapOUWBxAuHC7MTsgDRUp54Joysijr/KAlaLK17mBAhOwhcakvH?=
 =?iso-8859-1?Q?py5eW5BcxWNCS1K1fxIgnq/6i9+U3C0mTpxzafybTXYzIKLjbzXVyciXTm?=
 =?iso-8859-1?Q?VN4/vXjcNgEtjHMA1iwDz2ntMKUxHY0HuJM/Bz06QKRO0BIVFROIeO6HuQ?=
 =?iso-8859-1?Q?prGChXHHKTf42mYrqF/lqQH3cvDP4Xr7x9ZCXwdWH1ZbOGJ6c7bHMPd5fA?=
 =?iso-8859-1?Q?hct/8hGxnEFqt1EyCv2DGoGRmiXExc7A/XRm0G13RaPm0CtK7GOXvijbNd?=
 =?iso-8859-1?Q?IPnoLodDduOqx5NXziCRP2tpusTjZ0hFK27ttAs94mBORRI9E0JaeFxlM+?=
 =?iso-8859-1?Q?geRb5QC+k1flW2l9O2STrQNkqBVw4CrA2YDFEYJIEurE3RmnuGCJbjJ55E?=
 =?iso-8859-1?Q?gAcZUBYMUzarNdFU5zxaAGkIc+fJ4jUKkqcHVAU3jor5gkBRIZKANBIKmx?=
 =?iso-8859-1?Q?pCgtWYyEVaNmNmw7g8hPmL0Celin6zgswZNrZ2DoIiII47yyl1sOw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5099d2-b85f-4cfb-a1cc-08d9870e2bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 08:08:38.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wv6p4hFZMQyQ/rgW5kWxh+vWF3MTcQlXiq2KdzTxfSFo6pzg7uI8kFMAGVFOiypdQL7gMJPTHh6DFxnALbvDU8iYQzJWm1cwV4lkx2BmsH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2332

> Applied, thanks!=0A=
Great news for this patch and the others! Thank you Daniel!=0A=
=0A=
Emmanuel=
