Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120070.outbound.protection.outlook.com [40.107.12.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DC29CA
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 09:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4KGad7A8srAsUxH7Z9oxUp+eOOl9O8I2wfisTg4mbASfdZJc1nz0xc9p7ZWbFL9cGR+pmvh0fO9MiKP4Z/yx1ZGjwgEAeRBiFJ3JLGQR2zZNbZZHff9EX8IX5ZFWyPJ1LxEosqfUopo3glqdIlOcZhsOPUpzoQfRniT2aRsDoIwhXeeesHmrw9Qz2aEr6T9IYazrgPuWhS1Lh6a/37J5D4fZa3KytLjOpi2Hxh6rshNm6zEDw6e25ZXyL8y95LGttytZIa5AmmN0qkqBM6glv9M63ri9zo+w9IfgMKcSv1oNFzWSlpleFQRq2U7sIswshGmPuUmRIlwul3wuhF6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKAgStgqjj02tjVLsE/cMGCxxKaifD7uU5OMH6ZnsT4=;
 b=InJyrlCgrSNR+FX6C1t3PP3/+ZXmVcYTAY56k4dMd0stVxWQQTPTVoqw0Z+hFjixmMH9xwFLmVJJC3myMIDE5lvKttklhIouYMiKVNvjFv4xXl4OzQKQ6km8QTiarfQjCZQVdosGgBlJzLIx9k0vuNHu1pFIvPdUrNHh15oXD/5EBi4RaNGgwrTULA65onRjrG3yWPaTGSk5jtErfnaTa3kMn+tuAFIkfL/or2Mg9fmf1o8aTLudlRXQrvP7hb9MYADEbDf4jlDPdY9APE4naD7xp7Arm0kAfXlW7RBpypT/xu5KGZ3lbD0j4Teo+NJXHbrhR4KGmAPsoIZz6GQ5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKAgStgqjj02tjVLsE/cMGCxxKaifD7uU5OMH6ZnsT4=;
 b=qVqyN/MlUS9RDBIoTHqpz9mLEtkwP9p4HiQbT5mEhv9CJq8QWMpqyBVUY3UkBG3m/OE4KhfSZAxLXSnwKg6jfdJA0cgn1NIKm5/vYiL5n7a0Ra9NKt12EtuB+cQUvdn1o1AbZGMyf7QTo2IweLcvVmg/zMWQhvN/+TpkiNh4s2A=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2617.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Mon, 4 Oct 2021 09:47:47 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 09:47:47 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH] service: Report errors to user in native mode
Thread-Topic: [PATCH] service: Report errors to user in native mode
Thread-Index: AQHXtr6T3NUblXLl20K2GhnbRyD0SavCZi+AgAAaA+KAAAmBAIAADi9k
Date: Mon, 4 Oct 2021 09:47:47 +0000
Message-ID:
 <MRZP264MB15444F04C90696ECF5AEEC4493AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544E59B5B25F0CF95C7A07993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <163332924025.22211.16547270907956272336.b4-ty@monom.org>
 <MRZP264MB1544C9BDFA1AF5DC3557934493AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <a95004bc-f142-5154-e288-0dbd57fdf900@monom.org>
In-Reply-To: <a95004bc-f142-5154-e288-0dbd57fdf900@monom.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 14990409-be1b-7fa0-0139-1d443f8e9071
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3119d031-b8e9-46c7-1acb-08d9871c05a5
x-ms-traffictypediagnostic: MRZP264MB2617:
x-microsoft-antispam-prvs:
 <MRZP264MB26178AFFBC0280418770F1D693AE9@MRZP264MB2617.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m0CYcd4TSGMm5sT83K6NtJDiauTKM19t37/ojX8GL+zG1KG1ghU7o7MaWN+4dxJ9n/w10yDznTdvNtFOzPqCt7BGfuhLI4HyapZ6H58vvns6c5RQTa1+FCooI+q2EsvUGV+0ZoM8xqOsht8n4hV3zqTaY2SBWsfeqjE1Ky1XxzoMktGgQAXd4PUFpKXQFxJhsfYtR/bF+5usCqKE72AkjYnyVdvtxkZBUSRlxGn8pxjxvkp3WV+6o2sRCTzNHNg/dqYfq5vk2KCn+DwRbywjC7METKXDfzdgcWZIdF1+vqXo3kl9KvZZaBuOqPyVm61dNwv6hGW3lnAtNFXMFFhrqFoYUDpU3bbMdeCI6XCguGAedxiH+zOlqHQY3ivOCQVKYZNOZ+iFWznz+0f0Mg1dUJLwMJIQNcc5JBvgCoYDDrHY6Teer1XPBx53DkKZ042SbQSKmHUwFGWcoPavZKvXdp6o3W3WzEGFpN0ci5g9QsO5K86j+GnhPk/i55tG68HaKqhqFtqzsGALO+9sfVo/UHh2Av98ypXo8To47E9c8Zvuafu+fwf9c1OrUnMeMe/QdIpU+HyzWnpR4PQP9FZxyLHvCD+sXKfn8ab3/xULPuc/QfMzsus9URL1oJPVCZ/BuPl3+u1t63vL9etOfQqCCHMIUZ4p9kvNpqxdyitYSgjQKrQay9awwGk5OgUhJ+/eLyR1lHJRGdqXn0DPMDRmlg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(64756008)(66476007)(91956017)(52536014)(66446008)(86362001)(76116006)(66946007)(186003)(9686003)(122000001)(66556008)(71200400001)(83380400001)(55016002)(38100700002)(8676002)(33656002)(8936002)(7696005)(38070700005)(508600001)(316002)(2906002)(5660300002)(110136005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?S0xJDYy8+Nt5cNS7LKEX51RgXfTy0gciPHl/8SHSMZwG9VTc/leFzdh+r0?=
 =?iso-8859-1?Q?nge55o0n6cI+FfUPztiNZRGfXJ704G0GNpSfVePrsKtJvyDpq2s0uEQ2SE?=
 =?iso-8859-1?Q?JfuoLbZYY0CQQcIz9ddb/bGo8VhlVTaaSn+j7d6U96rcszrwnM3Zc5GBSD?=
 =?iso-8859-1?Q?W8GsG6EC7YTv5NDtec4Mfh58kWAzxbEHkQbvXRJTGAF/oFVlWRDlm4lt9r?=
 =?iso-8859-1?Q?hpP3fpkyYOa6YCUhh0R+qPK5MEBBI6fvWE+R8mAxdSo8lsFr2ayM7saP9/?=
 =?iso-8859-1?Q?pUaYowlS0yt7UygsuU1Dey40zr+UqWyNiWtoOddaXLFoU7efb2NZ5k5J5K?=
 =?iso-8859-1?Q?TaSPtWmJMbUTGG7CDJY5JZw6Zdxzp3ww7EwcQ7tY4NjtdOYgc7p5A14i5s?=
 =?iso-8859-1?Q?MZL81mSf+nPooPr48zWcaNuvOlhohDSQsQd0TQ5aIBuYJAXSu0vvTjWu9h?=
 =?iso-8859-1?Q?2KEAdwFh2unSMKfua5p16oFmSdXgQa+UPzEvQwO5n9xwnLtulA2GVlmf/9?=
 =?iso-8859-1?Q?nxOH6inTwzheCQSwAd9wAoRC/yN1L7PUQdUYCE8cyuKwqcgMppl49emzYP?=
 =?iso-8859-1?Q?ZTWsJ/4reLhsyJwVT1O1VcNPqVOm9JHGLQNmtv0aIOSolxhMwZPy6f/Lbd?=
 =?iso-8859-1?Q?r3QdHAGKDOm+70kRKZ6n3gApwql7Afwp9qT8IsFfrQU4W7iqvbpgYi0czS?=
 =?iso-8859-1?Q?n8KypaQ0Vccapwa7OHU6N5MlGZe9rsXEuevE2hFOExSUtV4RL4aptR+Zu/?=
 =?iso-8859-1?Q?VodnDUDmQm985aQ0J7mHgJfLBlPsyMAhPu3BNWE5dML6yjq3m/u9hviALT?=
 =?iso-8859-1?Q?v2m9IfCnut9yEtaLkIyvect3q8oCxC8N7zqMicV0vNflbHQq/2VfcinT5Y?=
 =?iso-8859-1?Q?BHvwyL4+ILhpTOogN3207JvEEv0KSozZR9883limuVZo6C+Ex98A9/q1CG?=
 =?iso-8859-1?Q?U3VLNQzKyAarRdXgt/ffWvKFjdWrf0nxuia19gIOyzeImlFqWNMfV1VqRL?=
 =?iso-8859-1?Q?QTlplSTEK9GPfoi5gsGC1Vn45ylIBMYh612cI7oA5M/UVENiY7FHFNu3fx?=
 =?iso-8859-1?Q?8BMDX73AQ2ZgeCeLDkg3DmnRQpqjN5+p252ziwgaW8F5E6HAugXClH0fuf?=
 =?iso-8859-1?Q?mNZcKaNFAUy4dChAX8qQCtZkNXX/Smv6EkjE8ii5UTEpBZjDpe7T2BIk3H?=
 =?iso-8859-1?Q?IYror9JKbF3WH0YjKX75lfSwJBvLr1T/FxwgD5jSKWxoWP8iy5SrqHuXYq?=
 =?iso-8859-1?Q?dR1+AvDJ0EspYdK70uFONKZ8qQUHMjgCqQAw2Eo1Q9rhJq0M3qMxlP9PWO?=
 =?iso-8859-1?Q?YLgUQkCx0Mvmidx07lrMDssmKDtdZevdE5NsczSn3Ocyqr4YZsFnu/qc0h?=
 =?iso-8859-1?Q?zRsKCfwQr1Xa+WkYvqVkFPSfN59YqLtHTrdI20R0sauk7ZMWTILAE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3119d031-b8e9-46c7-1acb-08d9871c05a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 09:47:47.2270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKmXj0D4pMWvKqnqXyRboMdFNCRU9uCi3OfQtszzsRHmLCo9doe32jkQaWt0dyJAGnxsMP2hJji7XvcTdcwbLXPSOfzdXWAILPn/P/HXplU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2617

> I was blocked doing the stable-rt update, hence I had no cycles left on=
=0A=
> ConnMan. Now since the stable-rt release is out the door I try to get=0A=
> the clang fixes sorted out as next.=0A=
Allright, good that you have been able to integrate the 4 patches.=0A=
There is no hurry for hidden networks, which is a bit tricky.=0A=
I have tried to add the minimal code to support it.=0A=
There are probably a lot of codes from wifi.c that still need to be adapted=
=0A=
in iwd.c.=0A=
=0A=
Emmanuel=
