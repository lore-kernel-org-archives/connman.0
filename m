Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120085.outbound.protection.outlook.com [40.107.12.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C8568
	for <connman@lists.linux.dev>; Tue, 30 Nov 2021 14:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UunYfC5LgzyO7RESvTaV6XnuJo59z1Ke4r00ZMMVGfxTstLjvUYIVKaf/Kg/98sFIJDNrytrf/nHK+QCVMfl9OVcuK3y0mjyZi7EDE8AZq2vwgNf+BJRIYCwU0fvwVlFO4oEvSGauLbkSdyV0HH3/cZ0Dev34BsTAxenb22n8KhztR19wH4I0SOltIaR6qT/z6JWkkW5jd40LK7sNIABYGF1208kTpkxJBl9MSiLKY3ZdsaIK7lrBdMu2S713KN8vCeIEA5oNwyHBp9yIkVapSRQeCNtNBe5LdIOE8LSqyCGvz4yWPpRD+ssaKe/CrTowKRdOcSXqsQpzuNvxJX19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SPG0QQ07LULDgFaJon9tU1BSt4WQ0hMPZRtlPIJWA4=;
 b=Pzf09yVAFKpg+EfKhMTMS9KSsQYcbkPHYc0Dpf0fUw0H/uuSDOCsfZ6/9sl1yO9WMFHKFx2M/zefxwCWMm3lbVZ+CHZTVL1L/ndGhmGIgT9sReGLdBtAl0F+MJKhDpz9WcoO8nmJy1w0MO2wYRD3bfeC12txbkwMSvVvEpG2vYFQD9RkbFqzaRJjlkaiqyxA6zdtuBEE2jti1bBM3AI0Huffz4dS1JPZpOF+tZrke+cXrQTgd2RK/XyrTkQx5Hy3HLSEy8jfsJiH2z/g1XHXDeKOfCZ+iHD43osLtd+JojQIjBZ6NjB+f7hyg1qWWnYK+6vLoQa+FOcyTsA3nB8dVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SPG0QQ07LULDgFaJon9tU1BSt4WQ0hMPZRtlPIJWA4=;
 b=BehodeLVFdbTFx/uHNV6vSgK4tGdvd8XnPTdki2waR/jkgaGcQa5ctE+dCHDup4TGP9SaD34Fs+dvr3n+edpYHMki+3TAlLKdCVqW254y4dDDgOUUgyAB2dLd3bvXI2xY2qNoSSjFQ5kWXdgX0W3nAPfdHhoUaHd/MmQIhg95Ww=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR2P264MB0147.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Tue, 30 Nov 2021 14:44:21 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f8f2:5a2d:be60:ce07]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f8f2:5a2d:be60:ce07%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 14:44:21 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: comman <connman@lists.linux.dev>
Subject: RE: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
Thread-Topic: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
Thread-Index:
 AQHX4lC3A7XrSe5BI02rfKjJZn9+U6wWAUQAgABZJ4CAA7wxAIAAG4X4gADTMoCAAMZj54AAImGAgAA4wVw=
Date: Tue, 30 Nov 2021 14:44:21 +0000
Message-ID:
 <MRZP264MB1544E1DB616C4374B66629FE93679@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
 <20211126163040.ai2euhv6yf4esnhn@carbon>
 <CAA=hcWQMThadP0TQDhqEoREroP8TNx1yQkFHC3a0=TNv9FR3DQ@mail.gmail.com>
 <CAA=hcWQB7t8GK8h0kQ1gW8iF-eO_Df2G6C354d2jh4jAxJcfSQ@mail.gmail.com>
 <MRZP264MB154446BAABD22138868B793A93669@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAA=hcWS5eXKLMUrTC=MTKUOERiR7eT_J+WdeJL=k8y=i-T40CA@mail.gmail.com>
 <MRZP264MB15442653D8E656E75EC9D94393679@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAA=hcWRC5J4dDtOfy-43nL3j9EyfYNvePp9RyKeGzipLt_Z8bA@mail.gmail.com>
In-Reply-To:
 <CAA=hcWRC5J4dDtOfy-43nL3j9EyfYNvePp9RyKeGzipLt_Z8bA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: b8472011-1ad8-ae00-d5ae-5a46d1830b27
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95a00a55-6f79-4e31-72de-08d9b40fe56a
x-ms-traffictypediagnostic: MR2P264MB0147:
x-microsoft-antispam-prvs:
 <MR2P264MB0147D259EB4E38D872820A3A93679@MR2P264MB0147.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S9gZjjSS/+UckInuX7rXgnEmGsWVIAS9h1LH4QQxjaTB7saxI5puyCc3X2si4gC2/XLonBEbvVYNWTXGsk+mrG5gf5Oxz//Codw4hKVqheOrEAvFoH0Razp20BVmy9Dvnl9pMYKieCNqI28CpQH/jxwyXGpM4pi6HcppxcF9HBEtTh9KkRrqQ0ZOyJ6zo+A14zRr1s0riNjb+1qiDaOHmLWg4Z3KdF8ZpVzJYPBw5VH5V3V9OhMEQU3aHKcdruEl0hSjay7LVKeklOZSk7MZLcg1udlUEwCYbActr9b41AS4KaToTbhF21twwJCGmcMWme6GGua7gmECJh1mnQ1IhcxFx6lbamNpB0Pfu0nRYNosOL3okHf4zS43szVA4+SlT0VqEx+0OyEIllbk+Mkgv7r6FOlMJDqU6k1YMPjTa4W5bypEem+vfxaCZDEgK7at8PsfP9JXhFbUCBwPTcY9RFvGnZvVXBdPt7NvjEmn/NlWm3TRagBsMZ0ByGGWrIuJSDFegSD3QMA7P5aCC8nImRUwxF8I6MYKJ4UuEUPqnUG41/zWYt9PoTzDcR2o34anyfiGRIUhxVK35AD+Cc0OW/HxyV+5GJmwkrUJRABLtJiEiw1pKAfFtnMyfeXqd7y0hwJwDI4gLCkT01zMrEvg7U47LTiRoc3glpIGlCM75zq2LAkCe3YsquCYCy1qaKgjBLC5FvFaiB+Hk9GM4WpMrA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(55016003)(6506007)(6916009)(66446008)(52536014)(9686003)(508600001)(66556008)(76116006)(86362001)(66476007)(2906002)(38070700005)(186003)(64756008)(71200400001)(26005)(8936002)(8676002)(122000001)(38100700002)(316002)(91956017)(66946007)(83380400001)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?P9DWM0n3KR4BduRk4okSo4fh9rLkL38mGjV2UTd6D342rW55vOnUGlyz1h?=
 =?iso-8859-1?Q?mbyvSS/6zsdNqdhdW0D3ltpd4e4hVgoN6m1ifYeyuopFUWDBSuuy5lbPGa?=
 =?iso-8859-1?Q?XL4U4FKm50u8rujUbtLLpS0mxLFcg/9M3SijxUVvQmg6rUJvELmwCDxsvG?=
 =?iso-8859-1?Q?l84RkXKQr403Iz0Nj2THqbakES8U32OLYUefdDpyHLYtuCzMTViukqGXv5?=
 =?iso-8859-1?Q?1lRWBvG/GxLH0uCIDbzKZIcbsQPQoXvNW2stTUaFRIXTiTZazyeW+XHMMb?=
 =?iso-8859-1?Q?pUWE20gDTs6F9QQ7vok6KhNLRL4oWAGAE2XXx/Oiej+dBz1EhNAFv7wn5n?=
 =?iso-8859-1?Q?Kqg/bMJEorcvzuWPOiymOQ0i+l8MddnHqqSjFlFGJ7QQsGl08U6u5l43yF?=
 =?iso-8859-1?Q?BGgI69jWh3fe2lP9YthXgU23iIGO1T9jIiYtt4/tG2fiwXaXMlJ2m40QHh?=
 =?iso-8859-1?Q?rQ++id8gJd1qKII8RJpcZ04E4K4PEf3dZPTjMuv/UDTk8zKj+q1qdxWflY?=
 =?iso-8859-1?Q?QxRuN7cebNxDxzxtMCK7BSVBpvTYsGsceuBnaGH4vcnbhE1/k7Uh0fRFfC?=
 =?iso-8859-1?Q?gM4WUu6EHtYMTxS5w6Ex+TYaYNJ6uOc0Gol4zItfCL7HfB+8HtrFyQD0Ab?=
 =?iso-8859-1?Q?bcYstQW9JWsLs/mhcei0/NXOc2ljpvrIiRkj/LCYQlMLmYSNHQ3OvnzX0d?=
 =?iso-8859-1?Q?UFrYqAbizVSAb5YoYnRkoLEi8lyMuECsBJieCe2oaSemcsk/IOhAfjbj/+?=
 =?iso-8859-1?Q?XITK1tQv8by4gP770ulseDlndG3o3THigqDuZY5Eu0gCRwh9Jp1llP4dOP?=
 =?iso-8859-1?Q?LaPJbhPpWqflre08pZ5cWJpRjzBTiF7o9SKX5kqQbGYk1Qma/9vycDFDDD?=
 =?iso-8859-1?Q?Pix+tVTg2T/t7gVuirhL5T1gKG/epBmkoVNJG+5KhEJlNSPfXu5s6Kt2PP?=
 =?iso-8859-1?Q?+zY8umS5fHC7ixvJDPhBKLU3sv56GaK3HKPeOLXCeiZV1MkV3MCDZlirfB?=
 =?iso-8859-1?Q?kCosqDrjl3Ft8OGaLFqL5RRFBOvhf4ma4Qsje00O8v7/L5B9ZzwCWCAbUS?=
 =?iso-8859-1?Q?+ailnlBIsLj9/AX+1ZQQtlA21GZJPtTqPln7Bb0hlynyE5Kgbvj/Sy75r3?=
 =?iso-8859-1?Q?TcDxUzUgjRfNdVFGhzWURbwt6piRNGBFixpZ0eHzqFdoZdI5uC2m+Zln47?=
 =?iso-8859-1?Q?tlfiyfJI9f6V4ltnnfN7nQIqTli2POrEFmGDbLCDcuCqzvIinz6eBnij9u?=
 =?iso-8859-1?Q?hfzSuX+rsIjQPIpU6gw9OAFGp4gaLZlHwdCkCtIPfeDw3w1Dl54VcCYeQL?=
 =?iso-8859-1?Q?+yT6dAffN0CzecTsk9ASyI+/PtshQM+ybDiXFQx0StjUhz9YsgTXuRl8Js?=
 =?iso-8859-1?Q?E/tcv8AK3AfvBwpO0yNv7gWYxd0QnzDFNeI1Z7JUjl3xpLhh9N9IZ7r+B/?=
 =?iso-8859-1?Q?fCpkwY9MaW7mzoO2mpoR/2N3kxMEBXCIcvCdVHmt3o4EpI6G/QyYM+7LTB?=
 =?iso-8859-1?Q?4n5U6IMeGk5OTc0WsqP8/8wIvEJ8+uvglx79NVNxXYEc48/Z5p4VbJ6sN+?=
 =?iso-8859-1?Q?8Q0jDqaL6XZVMoaiIuPC9zGofPTnsbiAIwuoRfmd9v5NQJ8034fnIFuyGM?=
 =?iso-8859-1?Q?6PR12/eDZNdK0X+Pw0COWeQ5wOws/QPkuO/01tnRdkOrhUvYMeTldyj+VW?=
 =?iso-8859-1?Q?XLDCgmx9YrmMKScwREeZDrvUAZ4vXUoG2UxlHLau6wjqhfxKrb9+h8TTLE?=
 =?iso-8859-1?Q?5MwA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a00a55-6f79-4e31-72de-08d9b40fe56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 14:44:21.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KY4rleRij5icIYJ7yOrqxWCXcp4nQpgeR0eBuYe0HfzdZk1SPxybh6TE84yW2CJAY+tdMuY58rKRicz8x8oABx++6akLLBNwkHR4Yfw6fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR2P264MB0147

> Yes it worked on 1.37 with wpa_supplicant built by Zeus if you would=0A=
> like to see the result, sorry very lengthy :-):=0A=
Allright great, much better.=0A=
=0A=
> Are you using connman with wpa_supplicant or iwd when you built=0A=
> Hardknott?=0A=
We have been using Yocto with ConnMan and wpa_supplicant  for many years=0A=
(since Jethro I think), and it worked pretty well each time (except few =0A=
regressions, sometimes).=0A=
I have started the integration of iwd, and started to contribute some fixes=
.=0A=
Unfortunately, as it is not my priority, I have stopped working on it, and =
=0A=
I have still not reached the same behavior as with wpa_supplicant, for now.=
=0A=
=0A=
> If your connman works on Hardknott, it should also work on=0A=
> Honister, just be careful the syntax has been changed to use : not _,=0A=
> for example do_install::append, FILES:${PN}, it took me a while to=0A=
> lean the new syntax.=0A=
There where some major changes with Honister, maybe you should =0A=
update to Hardknott, as first step, and add the 1.40 recipe on it=0A=
as second step.=0A=
=0A=
B.R.=0A=
=0A=
Emmanuel=
