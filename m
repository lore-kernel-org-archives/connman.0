Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEAD173
	for <connman@lists.linux.dev>; Tue, 22 Jun 2021 15:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP3d09s53YRdeJxw2SClT/vb9615yG+MatWnxXLjLYP/2naT0xx1IxKA7JzUh7fxv2gBTqItDERrkSxshGVOlit2lTAKuC5IwlF95duZVGy6d2VfolatdIam4cjyR3F+0BrXCz2wiCS9mL9+kn1jOeAQbklc3Nfu79APxXlxs2XXcW6GZtTue254fkRIgLYE7ETjYOW7qXKwoq2s04FVXqoSj8b+2CaEIO/Sv6wsF24nSmUQSZ/R48oGJgFAKJEHwypxoddxGa98FEI2M/gKLgt36R736u3DBqV+d2sEHKYcdLfgpjeI5f4MRlC5CoWjDD43OI58AO+x0znVzrl07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn9mSM6Jyw3qdYYg7BeGXxOTnpuZcGgC+C/OKmwlmFE=;
 b=JqV1qtFqjcy6fK3GDm/LwR3I2BYsdicdVjTRJZIinn5yYfhx4frdhlh1F1/vpqWl/AWLxrUKSrQOWcj8NyQF2+vYdGGUNhSz495kvApNvWfg3f7QsV8UI359xLl0YDAYPno4MRrNazkIdp47G5/XefBkcedKvg9l/FfxwmWesP7WvqTMKtI1DYhcKelZU2rzy+Avx7+ZNLVjwKy51Td0TuK076sKQQPPSWy4Y6emyq5mYJa9AFWMrUV8ispRE6DxgPaIMHUKHvCSuUOKK6bqX/ti8wp4cKUSr4TObOTD3AsmIqf6yL7k3qbs1HhSk/VGHMgSMVZluQ/f+mjBakLIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn9mSM6Jyw3qdYYg7BeGXxOTnpuZcGgC+C/OKmwlmFE=;
 b=lNstGc2uveW6H53zkdf70kKYP0mzy8KrASEXYO9tfrP+/91nhQjeQG9n4OeUhK0Kq3n0Loe3CmQXSyNQ3ihZ8QMwizk11cCseEq771MlwEUicCamsPPHtbiT8qYF/SrBvU15d1Tz7JI3KEPChgVT++j/hieF6BjmQX3rCSfDWPI=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PA4PR02MB7102.eurprd02.prod.outlook.com (2603:10a6:102:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Tue, 22 Jun
 2021 15:38:42 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608%4]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 15:38:42 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: Jussi Laakkonen <jussi.laakkonen@jolla.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix preferred service reordering on ready state
Thread-Topic: [PATCH] service: Fix preferred service reordering on ready state
Thread-Index:
 AQHXYP7y9dYDEFzAnkCTZSq5lr1DgKsTTl6AgAAZu36ABIYwAIAACV/egAYk1gCAAAycJIACCCkK
Date: Tue, 22 Jun 2021 15:38:42 +0000
Message-ID:
 <PR1PR02MB4794A7F14F3BBA04767CEE2093099@PR1PR02MB4794.eurprd02.prod.outlook.com>
References:
 <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <3213af74-2985-ada6-09d4-67d5ccf1f72f@jolla.com>
 <PR1PR02MB4794AE9D35473E527750BE1F93319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <ac94b39a-f446-0e0c-9f1c-5102aec815ba@jolla.com>
 <PR1PR02MB47943483C93F21149F412B96930E9@PR1PR02MB4794.eurprd02.prod.outlook.com>,<20210621073000.uz23zb7bv2qmchrh@beryllium.lan>,<PR1PR02MB479431044E915D119B5A6BEF930A9@PR1PR02MB4794.eurprd02.prod.outlook.com>
In-Reply-To:
 <PR1PR02MB479431044E915D119B5A6BEF930A9@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7e6fc08-303b-416a-9eaa-08d93593d062
x-ms-traffictypediagnostic: PA4PR02MB7102:
x-microsoft-antispam-prvs:
 <PA4PR02MB71029FF7B44D91F8CEB160FA93099@PA4PR02MB7102.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4uT6qMFuGo9111e6zBSO9e+Jshk6tqpBebudDd0qWKbB0t5ie3zxZKDR35MSBnuyea1KuTI/cGzc8MrMlAkBYUc8x+BQueQbAMmvsKsF5qI8Qu6jBe+uprxH4HcsePoCnhpHq/4Y/nSOwhhGA369+ZUMM2+PUDWD6fMzVc7D8ZSkWxrJ3QSMba9XTorxoCjuGK11mHlSjEJ9AtNVVNNwRQb61Xr/iMLVm1t5oT+X9UWaUFtnpCM0fA6ED4Fv04UWcQjMkBye/ltnxI5cP9bwf/ruLQaxyZS4yVuqpaQMQzvxoh8byKncCVgL2WXchi9UuZ4092Vrd8uGlGF4tdca5E+4V5othiToLNoj+DBEaI7p4XvZwKHL2yr5ho9NJIADQf9B/VrJ/dX0MkptqvTxCYuHwd5rnY/BSANGbdSYOtd1Q+RUgbWL0TgWvdXXc/Fm+E4+DcYTF7+mDGhIuNbvznps4g8F7b9Vk1GP47G50zJ77zztO49gVRQiBaqTfbbNxixd7RcCPS2COJOb41bKHfwLsGImQxOzsCC5ajcrQBtWzJzkpJCrATd+CUsPVHE6UI5mseupb6yB122Mikf91B7dQjztzWTf+4Hm0i1y/iw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(6506007)(7696005)(186003)(54906003)(316002)(478600001)(5660300002)(2906002)(71200400001)(4326008)(4744005)(33656002)(38100700002)(86362001)(9686003)(76116006)(66946007)(6916009)(8676002)(122000001)(64756008)(66446008)(55016002)(52536014)(83380400001)(66476007)(66556008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?smGlmVoNhPBe6j+Rrv2MTp9sQNt7ddyxDSZSN0DzuxDJDFsAe+jKPP3c1V?=
 =?iso-8859-1?Q?hyre8+UGlFFPZmtStXHG1mSZ8Uxq1UxyQaY9NBR/SOPDW8M9LkgKTDqiKj?=
 =?iso-8859-1?Q?ZvD2KHZ9iOMoaJKgFZdwe+jsRsIRv7YvSND2pR92n4eZjsZKzSKcfVGaqE?=
 =?iso-8859-1?Q?OthvnZqJw97ELgk1K5ZUIM2J2gG2bgDnQOmRRht+R3mZU79fNUQtJO5S+W?=
 =?iso-8859-1?Q?HoGveP8QCrv30/paGi4TeEPi7BihgRvjksMzkqOaMF8LHGabmrBrhfzOVs?=
 =?iso-8859-1?Q?XXpIIcah7zHkKVxdrEx5TqA2MXxKnD+eW4GwrAg2oNGnSwULn4Uc2QLo5/?=
 =?iso-8859-1?Q?4NZiNVPSU/DoRIhxs/FIoNmkuYgVOAGhdRtin4UraSNvA+fByStpeFlDPh?=
 =?iso-8859-1?Q?PaYW08fEEfSoWkkXAxe9/SN2N4SO4c/YFTu8HAyihN59sJzAgAdZ+3o8qL?=
 =?iso-8859-1?Q?CwvbBXqxC1R3Gvt/KbUUsjfVhRimmSjbdLIKR5r8gDRZekmTo6K0g0+/29?=
 =?iso-8859-1?Q?zx5W8jr2fcdoRR53cAUFu9tJeXxFwWzwgAjngGOtixn3UGtTRARkJSqBzH?=
 =?iso-8859-1?Q?5Vg1PGA60v/ie4J6YetQ4HbsMjvDYrtjin7gMKpF1lxpWoqAi2jQQ7/IF/?=
 =?iso-8859-1?Q?hsVOpJpbthT2MCj6kGHKvxXJQZ/a89APgi557aOl+B9rUNxKVILTq8mOkU?=
 =?iso-8859-1?Q?9k7P71QnJAELnvU4pzoGmCTs9k2hl5vC6ZJR2nsnVR0e3fb4D7x8JgObI2?=
 =?iso-8859-1?Q?r9XAyAsuJmucQn12o6Qz91YXhcnTdiCwieB7m0z4IrgdnmvL80ZB20i48k?=
 =?iso-8859-1?Q?821bbY+698nyFPZ1HrBTluv+z0Wgt4PtIMc9yPT6Z+OIybLE/5eQr1t0Di?=
 =?iso-8859-1?Q?7REpTaHxgfhkQbEtYd6XEWJQlh7f/AlGtouTsT96lMYmA8wvpKT/jCPSUH?=
 =?iso-8859-1?Q?hmUB4i8Gw3eNrSDkNIU4UsmwYkm3tDyZXyG1BNpBtxRkZTzdYSjagBHNsz?=
 =?iso-8859-1?Q?yrSGJYVzM88Qfnk/xmkomQm/px80TBiC9s0ik7pO/tz0Bo0ZGvASJCRAOh?=
 =?iso-8859-1?Q?9vGQmOcGLFcxWoc+nI15Z8YmU9IZmk8gqO3VCZgpEhxqbYUQ/Lo5CQOOvJ?=
 =?iso-8859-1?Q?Gs6mocdlJURucxCRWJySCHLqu2iH/W/5fgyuGJPBkSh0kmr6kLcOoUErcr?=
 =?iso-8859-1?Q?iZYdIM3jaEr7SsTlvwPT2eIT92AeB3D1Ys6ZGn06PLJTXRFkWGJA6F9w3Z?=
 =?iso-8859-1?Q?F5+arpGb40RMTp22QAIRKKW7bZFUSYfnLGqAiooEcoA/YW3IW1x1JGqZCV?=
 =?iso-8859-1?Q?KwXCsYn2YEXlmZQ/elpJH+mhKLDL0g+dfnqjLbVm05FntkCKr6Hj0Jxt7t?=
 =?iso-8859-1?Q?U1bZR+KGT7VuNX6S5c+5Q2QNwYmqLf4/MEnTKi9w/K2wjgQ0VqBjo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e6fc08-303b-416a-9eaa-08d93593d062
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 15:38:42.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqsz9GjGSazhXfB9Gz/GZkw6+3Cax9HQuvjonrM1Wf3GaMEV/cbG0LWzKkxaU6VoJuBYdOPsBRm5ldevMDWjANgYgmLBjTfKn19Ai6Fpyko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7102

Hello Daniel,=0A=
=0A=
> My suggestion is to use fix first the=0A=
> sorting as this seems to be something we can agree on it.=0A=
I have tested your patch integrated on a 1.40, and I still reproduce=0A=
the problem quickly, only by unplugging / plugging the Ethernet repeatedly,=
=0A=
with variable delays (less than 5s).=0A=
In this case, when I try to connect manually to a second Wifi network,=0A=
the Ethernet gets back online, as expected.=0A=
That reinforces my belief in a  state update issue.=0A=
=0A=
The good news is that I have not faced any regression with=0A=
this version (1.40 + patch, before I was on 1.39).=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
