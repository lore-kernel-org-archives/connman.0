Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B83FE6
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 19:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Slt8/enwx3M2BKKpBhCaNEMLDLNSdjX2ZYfIJBNB7PvToMigNNfxYhkfDXl/IKo/Or+/oPhLSkC6W+3TBHAaJOTBydwOSJpe96ztFiUWtmxkcaK134GV1B6/sfHQhkfyUPOQr3ygbx6ujZsaQBJb27nQAe6CPwvtvSINUdV6EuegLviFQpMRpwzRsE4pO8oolj/7Km9Mw6PZUlNJmMRU8M0VhzlEZ74DrBVXQy04m1Y3/8y4Sc4z5K2co82S3Dy2cs1fQf0F4uyMfQjCpiSP8drBQ9OUBv39N3ojhmcs3r8m4WSQiOGTbiaiCOdAxEWfiOIl3ixszAEx2xDTid/Dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIv0B+dCQbfMkpTUg+kkp3XL0LEf1k77CCs7VogQP8w=;
 b=O5VkuC4uPRbz3ag+WyMMk1abH12hiybDT50RSAJ7pDBuPUZ+x/UB9dA2wFDPYCwsgYioluf4IxDOwRgK2a9tLo/IG9IcdBZHe2CR3TjTspZG4uXsGzUnrXZ15PtERT/SmH+A2cVSYETfXBDJHMShLqqaVeIIUcaLVzWVt1062yhqVPWFZ5O10OIHnmP9RpWcDGcMnfoCVlanEiWDQ4IDYeTna2YSEUa3iJdPJrNdoGFHx1ig/godHRuvoFcZh6QbybF8C38YIuaOjTScCIcZUvBS3Woygyc+lJp9iYL9chNjMbZogPZfCw5OxsNAk/kmXiN/CE6KLgsH15ZhoVb+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIv0B+dCQbfMkpTUg+kkp3XL0LEf1k77CCs7VogQP8w=;
 b=kwloUW9PB1W3puMq6SepSUS2pHEotYDAuojU1GQp7PqqebG/I2Soi/RjBjMj3UqGS0PVcVwU1gm+MdKxlFKgohlFkCyWpjJTsmHmbpjpTo8vi4eIwus/wnPDVlCLfbom39w1ZRKVcRnkOFJILjna/aJpEALY5dPVj0X4dAnywrRcGo3sIS9H8T1qGmpNeJMUkBsaujgN5GvTrYeOvvm1cUCtMOHXoyJobhQesTLtEnw480fJOd+osRR35zOU/MFVUF5YLWu5pt83BHoOtWx4RpY0ZowGK444BGSmoqQ4CAuCpLIKvazG5UsvzcMN8jrdBsuyKa/Ua/Z8spn+nGbgYw==
From: Thomas Green <TGreen2@Sorenson.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: subscribe
Thread-Topic: subscribe
Thread-Index: Ade5WBDt0/j3VSRcSQy/eG2KoEzhPw==
Date: Mon, 4 Oct 2021 19:44:04 +0000
Message-ID:
 <DM6PR04MB7003420646FF4C26ED89F7B39FAE9@DM6PR04MB7003.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44f48db8-a012-48e4-58f1-08d9876f5297
x-ms-traffictypediagnostic: DM6PR04MB5452:
x-microsoft-antispam-prvs:
 <DM6PR04MB54521DC5E126D95B180E61329FAE9@DM6PR04MB5452.namprd04.prod.outlook.com>
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7003.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(19618925003)(558084003)(508600001)(122000001)(38100700002)(52536014)(33656002)(66446008)(66556008)(66476007)(64756008)(66946007)(76116006)(2906002)(9686003)(5660300002)(4270600006)(38070700005)(6916009)(316002)(71200400001)(42186006)(86362001)(26005)(8936002)(7116003)(3480700007)(186003)(8676002)(166393002)(220243001);DIR:OUT;SFP:1101;
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CLoZvHoFTbGtoTGvpmuSgGsBCioc9ad5voRJv5FB/+05X5mY0yrZrNBJn38kz8R59k+83Oqq9GacR4aPgH3L6z/HZz29pJ0z1HQK5YRebOSqfU0dKzW+AEBadXgiRK3Lwdbt8MOqWHocDEw57RMGnAWRqOWwGJRjNgHeFjK4cECqAfbPnaIvLB013lU4PWrOux2ch1t1VPwM1kXl3feq3X6F39V8eFJoqeWXS3oIRpK/MV5raOwbKzKBoqqH28MNxHHeUHJn2+i0MPy1qiOpJ8BT2bYWZzp6DG1h1zWXLMpAgZX0jIwV/eUa/YYKkp3C48iXDgylF+Nt8Fo8+5cWDYSm5oT2bdhlM1irC/RiHrheIx9zxu4h4SEHkY3PUBULvLXlh+ON7qt6jrM07OFuw1tlD3Czo6tFyyoPjx76WXqTZ97iyM4yioa1KezOQn1L09wgpNTOgVbIABQojhFZYlAbKBmQAz8LNOL24p1yUhxfG9y62YE1QdegVS7ZjNtMI4oqNhs3YOxj0yLALgtXFCQBPD0SryVchdccJVTDoAs7PgGMhfgpQoaR1CBVGQb4x2RyzwKIf9Tl34lJEqRJuOxLxN16FmHYPksneSqS/1Ukg7V27JnU/3gs2A+UiFRAzoefohM+wieyAAANXbNSwxxytd+tiMFyYIGBcnyfKOtdXVh0AahcB0bmkWHxT3N021EWW42tnxcJZCgjRgQjmm7CxhlbcM38JHXX8SzdarPN+dudFA+YmwZ1A8QlcIgV
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hKeyQD4UbCtg+hZ+frFEJIkrFT+mqMHkH0fX6AsuxIkqvcWMXKvVeTXX2OZd?=
 =?us-ascii?Q?FN18rLNMWS+6j1cPDvYfQxYAPGUPT4oMR0cs35M/TZMUwVrVfl3ZqXuJcL7k?=
 =?us-ascii?Q?eIU+o//HqclKP8kZdYTQuuUh3e5n+gMChP7F21MKIBgGC2xBrkPKdz56eZ7T?=
 =?us-ascii?Q?i+d+OPQWcv2wbc/CJGfeTTtatDUi2VPbYUO4cfqHE/fJ71qPkGB0O7zhgjdA?=
 =?us-ascii?Q?HqbSahNsgP2YW8PwlD6NY4T1DLImVafd1qa6Ojn+O9EdGJwf71VXph4nfNiL?=
 =?us-ascii?Q?4mNdBNos+LY6hMVnNczX356Lvm5y/QmyI1ngwHbn++Ki9nKkConGY71YHOQT?=
 =?us-ascii?Q?kroUns2e+xZLGcgNEsiUirZjShY7TaXJAOUJYrOkU5EI26xIfXW7njNm35mz?=
 =?us-ascii?Q?Eb16eDm0xBSgtzlJzyukBClJucbvh01k4kxKyWsnl5pSfOBmGXs6yGIvZJRT?=
 =?us-ascii?Q?kAJBz+GoPDpDZFIhQvBkbxP7hWZ1zYfPFbDND7BhjWmAZFdrPgNUT+Pui9zj?=
 =?us-ascii?Q?wOMCI16eCJJAp7UMnIKX90GBs4clXcEFj7h+peLplwEHgeo8h5JlbWaL3Z+u?=
 =?us-ascii?Q?ALfpZ7STInjRhqy1NYa3vcT9jkJnasVeCM4wQ/vNEik5rdAaAcHeIWZtnaz0?=
 =?us-ascii?Q?voIbSoBAxZzHnOuKXzfnDXT6omcMuPZ5DwsT3jAztFNUCP1moO/M14OrMnMo?=
 =?us-ascii?Q?afZz2ZJ1a2Vv3qqyJ6EknQImizXpQkKL9B3vLO9ywjyB2+Ye19X62hTqLcAD?=
 =?us-ascii?Q?I6bNGgCNoJ4vyxax1z/T8GMkGzhpBgMfn8O5Ie9Plj3JlHN+zPZM++xIwWS9?=
 =?us-ascii?Q?sgzXFUycRBHVr2ltkygqiM5+bRMoLzqMRl83IZ6UNQ+rLFsVkrw1NZSfvRX+?=
 =?us-ascii?Q?v05OqbXQgn1u/ojlCEHIgFJacRDcY0uARCyf7e4NhJxwVKAgmEwQ65RUs5It?=
 =?us-ascii?Q?fk+daRtEnu0cYYeU96pOOfGqxw567L40+mu1RgC+XOSisQW2rWdTK6ACcN0v?=
 =?us-ascii?Q?NyQDnhaxU4rAr40OBoSyPHgMuWll5nCYdVg4HrWfZHMnTK2iDYVEu1HodS7j?=
 =?us-ascii?Q?R00AoeEYU1Ti01scfxTOPszQqt7WbnkdAhFFxoTEpRKZAHVvUOulSU0AvPvw?=
 =?us-ascii?Q?ZXLReBCui+L+tT0E5hcJrjDXaMreGKW1au+c1uw/CNZoFP4jTNdgZIWyJJ4f?=
 =?us-ascii?Q?RpgCIqXrxud6iTchtgVsk4EABHgNsNW0sB8YsugQ5DkuPSG4mBm31/gZKtFp?=
 =?us-ascii?Q?32SKcjZz2gZYZDitaRGMNfnbzz1W5+zaHQO6GbXZ0MnI+0UZMupAn60k61T3?=
 =?us-ascii?Q?xDE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7003.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f48db8-a012-48e4-58f1-08d9876f5297
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 19:44:04.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jhciA4xryE3+oLYSVay+bDPYxXmqwLKe/IXwi1iDU4GhCHBuaNPmQF8DZMIeisTrIC+t+OiG8zEM7GifjmE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5452

Please subscribe me
