Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24E70
	for <connman@lists.linux.dev>; Thu, 17 Jun 2021 10:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAauADi2NjPHIQHCZW0ke18H2IMHB5pvmbC1KGp6ZDbuUAOimDNWHHBhxBBzMAWOiDXv3T2WzgApZ9vq+RKIpUghMh+3lhxhVW54BglPHZqiiSKFlZV+OxBFREU7N1qgJjbbXLqFQYrQTG0rJn2wfDMdblaPj9LLOInGU3BA/ZAXtUJk8z43Lz8z0GDsDCT9OSQf6au1yJ8nqFDLeLzv2fNVhXpcXe3XlIt98hY7RjZ/4kobFQlNnIP3pkteT4WU/wpy0/le9IZRJIQcaWBBrc2fmJebhWQS+PYy+FNitOIkUYolTP0yGMeBrTcmVmvUmgKo4aEU/STY35SUJ9EMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQTADQv/zhsxilbFRDreAqU8bA+zM+N2Qyo7c6gOKUQ=;
 b=hNIus4BTVSOvomYRyghz1bk6h+aCM5vRyBEJoClkplki9Z3LhwgypIew0/+/2S7fqu8DOKm+P1NXLY5+7CUHpv/r+mKWTLkUWEEHZT9NEiRHtgcA79FLQzjvHy9buqtBkdWFikLmVtxQGhFQhjJBRH+7n+H5dGGy4pEQwTRVDakmRixpCEMNB86naPA0ZFTJ7hkG8ge4/mfTJ+THyVD+lXkAmR5vSxHQBIxEcYsNkEYYaUIAl0ieBqm6/ZHcd9KELk7DWxKB40+ZZAjTfU5yeY8/4xbih3ln24PNQDpKB56QBtFg6G6edD3+Z4zI+E1lvnxnGQa5LHiJmNpnBizsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQTADQv/zhsxilbFRDreAqU8bA+zM+N2Qyo7c6gOKUQ=;
 b=Zvdhgy5IN5cpoRGwHw1cdJBJYdB6rk6BIOCgLkb1ZuRs5xytjxYJZMst9gPgMOcy6FmuwmVwWL9n3+yrDLESE4npNW2XID1VkigCfldChVxTyziiQOow2XMNzhwzrDehsss94TQEd9JkPO5l0RLOE//MTozfMo4sceEtnzhOdag=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PA4PR02MB6912.eurprd02.prod.outlook.com (2603:10a6:102:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 10:22:18 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830%3]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 10:22:18 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix preferred service reordering on ready state
Thread-Topic: [PATCH] service: Fix preferred service reordering on ready state
Thread-Index: AQHXYP7y9dYDEFzAnkCTZSq5lr1DgKsTTl6AgAAZu36ABIYwAIAACV/e
Date: Thu, 17 Jun 2021 10:22:18 +0000
Message-ID:
 <PR1PR02MB47943483C93F21149F412B96930E9@PR1PR02MB4794.eurprd02.prod.outlook.com>
References:
 <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <3213af74-2985-ada6-09d4-67d5ccf1f72f@jolla.com>
 <PR1PR02MB4794AE9D35473E527750BE1F93319@PR1PR02MB4794.eurprd02.prod.outlook.com>,<ac94b39a-f446-0e0c-9f1c-5102aec815ba@jolla.com>
In-Reply-To: <ac94b39a-f446-0e0c-9f1c-5102aec815ba@jolla.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: jolla.com; dkim=none (message not signed)
 header.d=none;jolla.com; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bffd8ffd-39f3-4d8f-d2d8-08d93179c95c
x-ms-traffictypediagnostic: PA4PR02MB6912:
x-microsoft-antispam-prvs:
 <PA4PR02MB6912D4BA50E24C1EDB754EF6930E9@PA4PR02MB6912.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mqyv64c6ispEjzAhrskWAIV34GGHXtCTrApTGLBjxEOSoj8CZGbkwAuD0jcmImhW1OBjEF1pgBKXGak4h2EBahBF/T1JjFgMrV1wrCKofkUZC6qo0Hf4Rug8VYsIDPJT087E0ja3m9+WyeqArHs1eHoxh5DWxCTTUP3RInF7zPCtVruggtdE7pJP0WT79g0+9r0+/5wxJTB0ZaOPo9wxOktieyYubI0BFb0hhiPd+bcccJlKGrDuO9Wq5VhOddm5zv4fEWUPNI4EYQ/zkOq/qPtuyTRCNwFyBtmNie7uSApD7A/R3sTu8OAbO5bMcqTLOwHF7Ti908o3ZWp211z3wqk3mvPFf0fKCJ8CP+P4AC916VAfaeEY6EOKI2xuaWhff2sl/tTVuQ4pMdqQAiLbS3BL6+/FoGQfLn6MWgf0b+QZ68IIMl5ibU5lQHDNqLl0JCZ7zi+zRdrvcjdVyD8Y6h8UZLitGrm/RqwvDilWePHXpPjQfCy6Ds8AgOCzfnO68sWbaWXYHQZSkDy1IcpWqu6lWtKabXbJuvxyiLT6pBK4peBYmSvYrKhIocF1NmtyjflHx+0v3tHZpD2zOd6BUWt5xEPrI8+2yA7MGZLikkY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(9686003)(38100700002)(110136005)(55016002)(122000001)(6506007)(52536014)(186003)(5660300002)(316002)(8936002)(2906002)(8676002)(66446008)(66476007)(66556008)(64756008)(83380400001)(478600001)(66946007)(33656002)(71200400001)(7696005)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lUh06AWWAB5JQU3qSxM0Yr5f+749BSaIvJZQQqQEOYUeUga0aX7cXCQWpX?=
 =?iso-8859-1?Q?WDaldJSyXP/UEcnS4FGdWDwX2hFHAwyFUuUT4OlP5uqYUCSAn7PhzHQgHi?=
 =?iso-8859-1?Q?6tXgt7ka1/uqND34m85Wfd073KqYQBTRN6AoIcKqlO2oQ9T9Y0RPw+Nt5O?=
 =?iso-8859-1?Q?QD+XVV176eyaFxNluPfBbJOqhfWtICoRUSmcS1SZMLzac5rJ6LSmhR2rDV?=
 =?iso-8859-1?Q?nQDP1u8DJSCysWMYgsf3QXJQub7D6mjUlmBm886+MAislnELqvtzTqtDWr?=
 =?iso-8859-1?Q?0AFnijjQLZg0uj1iYjfffZbncAuGMtn0pcuiq1B70tlVlOJwpXHISus2/B?=
 =?iso-8859-1?Q?gTGp2MWaGvRKoI1bnNibbUV42bAcXTyu1GRCkpPtwrgjCGQbQO8mvjiy6L?=
 =?iso-8859-1?Q?TMg/jM/BW2pAI5HD6URTTBUrFu9paAKR7hA2xwo43uxc/C97hK+0amb9Qp?=
 =?iso-8859-1?Q?amRJ2heKoxvdFzclPWcCyuoNYnIguNwa976cH/IuXXd2AQQgcwDA/Dc+8I?=
 =?iso-8859-1?Q?OWhPbPPIGsvITHoZ6zmAAG5CM1SucIhWGbfSGMWP2XBdpunBnapzGHbKFR?=
 =?iso-8859-1?Q?v9p5R8CociMOa6fS0QwQJtVxqAyu2Ul0Cei1Suwx5AHM/+mOMeFhdemrly?=
 =?iso-8859-1?Q?GAhijFZIl/UGwu0AxFOEC4opw3A2mstu0U4gKWpz1ksZN//xHHpJf/uGRQ?=
 =?iso-8859-1?Q?At2h2np/0TeUhGfuN72akNrCa/6jxhXzu7ppivJbEir9ocm+ihmUUy30m4?=
 =?iso-8859-1?Q?ClAGxLkXcaZGP4xeqF1U4mDXIA+mOnUACWN2TogtFZdQspt6VEbgxQUQ0q?=
 =?iso-8859-1?Q?n/yGmjv0QEOOJyZ7yjJdHlOKxUP6tygs0s7syRTb5X831nPhyTeaPphR8Q?=
 =?iso-8859-1?Q?hwYNPtbLdJ29X3NWYv01luev1wrm1SOHCXpjVmwp1Z2XPerlh11yt5qHTL?=
 =?iso-8859-1?Q?TR3NhDZH0Zx+1Crz++K+VhIiTnfhGS3eP/1pibiXA2FipPR9kJCgxLkIrY?=
 =?iso-8859-1?Q?27qPO72PiYl/nAsxBUQXv80tXk+BI1xjsCN0+RGZonAIssaTQcn/nb2CfJ?=
 =?iso-8859-1?Q?zoOpeUjeZEeGozHbCBSSjIyA0THCSbDTyCg3oGI+A7ObcSHE0ZlSzMTyUx?=
 =?iso-8859-1?Q?L1KAy6UoWxohlM0s6UJMcPRuPcvBiFvucH0zvUbwfrMZHLj2NGyDwPT1RR?=
 =?iso-8859-1?Q?vb+UdDhDsa2KOt1X3kzTupBI5/sKtc2JXmpShQfCwOU0V8NpgCIKtvOg89?=
 =?iso-8859-1?Q?udSuSBygXpuo0l5gljR1mLsQv1pmrgHWl23e5/tr/bxTS7ZnD4y4ZzKRP+?=
 =?iso-8859-1?Q?N6gWDCPMxFKhWiF1dtyqGXSe8cj5lFnEgOS3OlpJWv7etqlSM0xuf5R3RX?=
 =?iso-8859-1?Q?mKrchbp+2d46RycgGe/KDnpMxE4S6NV9B/T254HVpyLwsGQyl9DLM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4794.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffd8ffd-39f3-4d8f-d2d8-08d93179c95c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 10:22:18.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRuXlizooZI6t7FHVa59d3827RQt77mf9eovS9pUXWnwRBDp4Dtdr6ip3Bmi/7Lbe8kkCgp2ww4GF0lhIsUvxDdOyrbMdgSDc3fsMr+a4Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6912

Hi Jussi,=0A=
=0A=
> The thing is that I've been doing similar work on our fork and the end =
=0A=
> result turned out to be fixing the sorting of the services.=0A=
Great.=0A=
=0A=
> It does not anyways seem to be quite feasible to first let the sorting re=
-arrange =0A=
> services, then with these changes make exceptions based on a specific =0A=
> state, which then will change after the services are again sorted?=0A=
> I haven't submitted our changes to upstream just mainly because of =0A=
> historic reasons there is a bit of a different approach in use with =0A=
> service.c. This hopefully changes when there is time to check all things =
=0A=
> and get the fork closer to upstream. Our for does involve a slightly =0A=
> stricter approach [...]=0A=
> and the unit tests (that are not yet 100% complete) [...]=0A=
I have no opinion about that, my knowledge of this part is to light,=0A=
and I have just a limited time to spend on it. I let Daniel check this part=
.=0A=
=0A=
> But since this is about allowing to follow the preferred technologies =0A=
> list that is being set why not do it in the place where the list is =0A=
> already utilized for sorting? I mean that as there is a clear reference =
=0A=
> to prefer online over ready state so the preferred technologies list =0A=
> should be as an exception in this regard.=0A=
> Your approach works but I'm not sure if there are some corner cases =0A=
> induced by this approach. These are my notes on this matter, I hope you =
=0A=
> consider this proposition.=0A=
As first step, I have just proposed a direct fix based on current implement=
ation=0A=
(also fixing the service state update notification), in order to limit=0A=
regressions and quickly be integrated.=0A=
In my opinion, the second step will consist in a more consequent work,=0A=
based directly on the sorting itself, what Daniel has probably also started=
=0A=
by his side, but of course, I let him decide the best way to follow. If req=
uired,=0A=
I can try spending some time to test the final solution based on your both =
works.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
