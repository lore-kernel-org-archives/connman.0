Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30080.outbound.protection.outlook.com [40.107.3.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8F177
	for <connman@lists.linux.dev>; Thu, 24 Jun 2021 09:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfxgGQaDcGVS41Z4fPmpOS4ExqSkU8W3aBcF/rk4OA8sijslFsrRhvYXt1PgENG9FdQ46U7BRqQbQnFQYS/vSQUmkmGOLXwUlK10WjJaWMJ9sTYyjrITDUPwi4yWBsZJbU/ooUszK+2Yotykrt8aPe/EN1OuXLwACj6rIBh8+m5R+AMFMlJOQn8aIJe6xzKPh63BB8uEjizsx1KnTDHAXLIx74HBKjKK+qngmzI3zG0yj2iWxEjjqSLMHaFBrRRXHYYjIbQpn4z9059Ouh78Baqhr/AUclZSUPLQ53mOhR3uMxktoFiT7R848V/SywiWvo4KzBXS7/fdBxY2ENq6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aseRgaASld7lxjYeda0VktJDeOANxgedfdHv2ns2CiQ=;
 b=UzYWL6oYCZ4xxLn2xundjJ5aGhisWbznw6M5dKr9DQLDHW1RKrCsGKMe5ws6LALW959TOMyPH4MRnr5OV885Si4wLtqejRqqelsdIyiH85pw7jZxspXPdrHIni5g2MjySxpptyvuKlwYFw1Gi5iUjEvHZdQlFVVRsOd4RRIarWG+Cc9tSSLyKIyeifscw4svP9w5Taxj87RIJiQMNAWUyBG8FZmUjLorLI1mpiStaPuJzaX5Z+xUK2+10lMZ4jow02NmF8wcG+6VrDM1devEuCTbidq6tSNb8pigAsef1EKWJQXXMRhTZAQwarX/VU/UDtqk91kunscbJSFIfV/1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aseRgaASld7lxjYeda0VktJDeOANxgedfdHv2ns2CiQ=;
 b=zZ+qXVYv0Xo32hWh+LTNYPX84wtWFrwhogMC+deDEFOgBx17oRTk104wA12xEzoA0xe+L/fm866rDvFSr3SiUrNN0z7N0M/i0fTVq2rdryZwl+DofxaLADJAapqtCXU20hCgsVG7+x7BtDxpIOUvYs6goVn2seG9AtHnbmINTf4=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PAXPR02MB7264.eurprd02.prod.outlook.com (2603:10a6:102:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 09:01:37 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608%4]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 09:01:37 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix default service update on ready state
Thread-Topic: [PATCH] service: Fix default service update on ready state
Thread-Index: AQHXaCl3q3yULm0o6kitbLJsUjipmqsiz8KAgAAOuVc=
Date: Thu, 24 Jun 2021 09:01:36 +0000
Message-ID:
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
References:
 <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>,<20210624080757.722whwmmwrnzffvb@beryllium.lan>
In-Reply-To: <20210624080757.722whwmmwrnzffvb@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [176.158.51.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02c4a16a-26f8-463f-4d80-08d936eeac51
x-ms-traffictypediagnostic: PAXPR02MB7264:
x-microsoft-antispam-prvs:
 <PAXPR02MB726485CE8AD6C20EA33D849093079@PAXPR02MB7264.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A2H/e2gFOB1O/iNV4FaV3zqaUBHxlDJrukEQenLc9OuEzF0oxtA5pcRHQ/W35mKtlTlZl89tdrW7j5cO28GylLXs+GkQTidvqskxkMDxsnv/0Qu4OktkzuULHz/oqwrQ7xwRkBzaluwzpK4MdwI0/32D8j6K2qFdzQ5idxntnTqJL3JIZkfXpr3lsjUanil/ujdL9ywrI0q69tKOAeGqM7rXe0rSrviSe98ZAoJ+P52tdrhpJoP6ztcS2y5kWdg1nmh49iVtVDlzm1rBvKJ+hwChyOVc1nELgcaLDi3a0nqxx3FC1fWj9FuGskPZ9975Ss8v3rFtRArk/CEodfl/m2R4s06MSFZ1uCo4n2nTeLtmRUhc4Wd5BH7o8AMuIUBThpT1iqWKoRRuywfIPWGPFvt1XvvkekjwGdKqUf7LPBbK36CASPY3vN8yZgLpATxlNn5+4akFBrSt/EP6MyMfNh/6hzQRXbnGjkMUn7XuJZAe1HFEggfn/TLxgBBA9/7SNuKreWzygQM8JDS9RSYJxSbzpMd/LgSByB7am+b830iQwwQtZlvWfjGmJVyY4p6cE0OPyV/Um+obw23hHww+AlWh6c46E1zAsKPpOnMjMus=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(9686003)(316002)(86362001)(8936002)(7696005)(55016002)(26005)(76116006)(4326008)(186003)(66946007)(66476007)(6916009)(71200400001)(558084003)(8676002)(478600001)(38100700002)(5660300002)(2906002)(6506007)(33656002)(66556008)(66446008)(52536014)(122000001)(83380400001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?25juvpa6R5Q/TYOqagLuNEYXDGg+d4pNC27h6JGGhXGCoSfnZ4LhASSher?=
 =?iso-8859-1?Q?ptDhF7A6v8wfuREFieaMSX2KwLjXSB+CjaW3O+XvZ3ZNPLKhIH9cyfU5xK?=
 =?iso-8859-1?Q?UMoz3XS3Uz+pzdYrvUi/WIa4QAg1d/ZTHZeiIcwa9mR3ZEutRd2zNXY2nv?=
 =?iso-8859-1?Q?i4e2jpXyRdbK9aWRXVxKPCFg9q/bxpwdnU/ofkILCMxRrrq4MSP3d8/oRI?=
 =?iso-8859-1?Q?1pnNmlIuaZwK50GrT4hIu0jLJTJmmWgP6jtiXXxembEQ/Q3IAHdX3cOkh8?=
 =?iso-8859-1?Q?0/uOzKSr5Y/9wSBAN08hyT3u5szFs6P7jXWZJ1EPmqtkMQ05G56jVfVsTq?=
 =?iso-8859-1?Q?9KVjj62xcaQx6xtaWwFxowuLcaVE/dLKKdYiZc/Bu4aRgcVOOntSLAevgg?=
 =?iso-8859-1?Q?JHAZDy2DXwLUCqWis4XnEMDVzmcNQuDKSNzdSvvEYyzgqn/KpVuYhZP0MS?=
 =?iso-8859-1?Q?Ng6VGyFUeEMRaTVIDXy59VQLONIwmBZVCsWq2Ux4L4BOHbq/oJEnMkpvoZ?=
 =?iso-8859-1?Q?e19AbIp3dqbT6znCRtjXPKicPYF4FLQi5V/Ow5duUhNko0X4cdj+RnXu5D?=
 =?iso-8859-1?Q?2D2XjgshFrcexOAOTqkI4fzKEfdenJ+cVwiWVsYQG21OqcqNlmaYTPq1Af?=
 =?iso-8859-1?Q?6X9ZuAkaV7Z7MCYzPkccC2kXDpkOeKTIEPWRCJ16efBmj3aX5Dq+63DPrm?=
 =?iso-8859-1?Q?1nwebAumwfe1osglHEL/GFi2G5CkAYuZ4GBYmH3it2lyc1SaJ6FEWZ50W3?=
 =?iso-8859-1?Q?9CFpJtjGfYC4CfOcoVv8o3XgOc+qszp3493uZ/2Io5M5rYtGEC5S/TIWyj?=
 =?iso-8859-1?Q?Syuolv44CwH96uUJ0njiUp7yfBS2IhqRUq79RVEZUEXrn8+Wa5zCko1jG8?=
 =?iso-8859-1?Q?POU8QO4uXXYU7+vAfo/qkKeX2mQWe50LCkooltekcH/m/cmJoOupqwFufz?=
 =?iso-8859-1?Q?NFD3hoxavQ4iOkZJO7GPNeafsahrI9nOCmeue5+QFzdg/SBWHctOHYaz6S?=
 =?iso-8859-1?Q?oeXovNs0iYVuGVoFNYsJkcxhw23i9QTbW10nRcvohe4E174JmIx7ZHhPD3?=
 =?iso-8859-1?Q?pOtlMOgqOEuHsmOM2FzCgBcSqh6cO7sRfd0JR41Wo3YMf2FuXl8y1d1s8X?=
 =?iso-8859-1?Q?okDcI364uk48QBgTIfhtTjXyaiB/sx/DMerl9HKw8TmjhJTQaCORWzqg/2?=
 =?iso-8859-1?Q?9+HqmIV28qBoPsaV072KFmxICs6HexvHUNGtIFtByDOUAJNGCW9CVkLVlz?=
 =?iso-8859-1?Q?3qaBRcn/vfkO61h45zh+ByKLqC8VspQFeGWYQT+Z4CyZdL6BES3Sq26hyD?=
 =?iso-8859-1?Q?YQ8CO9TFTf/OvG0MfXKJyRQEo6UuEpx/b/VK0yti89XqLiPKjH+azx+UCC?=
 =?iso-8859-1?Q?V+ja1zZR4q?=
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
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4794.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c4a16a-26f8-463f-4d80-08d936eeac51
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 09:01:37.0131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8ah7jJdg8SpBxl4BQiNB4C2Rn4yCoT/VQlRabDvM59i8C+YilyHRv6m7qRzf8DarGVojSHh0p/Jv+jrHSEUcTKjU+MUy1WVolRUycV8H64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7264

Hello Daniel,=0A=
=0A=
> This is needed on top of my reorder patch?=0A=
Indeed.=0A=
=0A=
=0A=
B.R.=0A=
=0A=
Emmanuel=
