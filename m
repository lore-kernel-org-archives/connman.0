Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130051.outbound.protection.outlook.com [40.107.13.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320262FB8
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 12:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9wAHaeCj4+lXyDaPJY/dTat7kgykIPHR9gJzZ92t0b+qeeWyjT4P5mLTWeylET6XZoedEV5zDqJuju64pNPQ/rfEc7IrY+4tp7AlVeqhWy/oo4fcrMV6oZ2Q8nnsj6yhOBhN4wcbDbO9AvO9vJM846XdvG9BF3XtuN7wz048ANVASJB4fJ6QnjxS2jIlXTjzOFBoBqm6HjZEKFHQf2hu4IZ6av+gR6KPwX0f5a8fAQu1cz7yhIAU2lHw0D6bqq3bCPGLxQ9XL3ehJFJhnBlD7v7AIWDJvznVZv3iOrMzboKGm/M6in+bA6S40JezubUyZlKXpwv75Qr364zqpCvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je5Tfkc6Q1FeU8wTC+Cuo7+k3x2dWH6lafD7UpaPGt0=;
 b=A5J9qx0TPDN50WkLCBqyGw2v+22S0AqqMPJTktgN2oc6FI1oYVy0M07khWkeEmDIhxsg20Xk7OZeVaC2NqKMrp//aIP61gyg/uLARbY9C3Df2WoiZ4g+2B4av1L6wWawimsI2m8kxT5/IZ9kpmfMgaLBfrst3zLnUDDEJN4td7VvUBilTdTP2w7OmAbIV9KWibNM4RrbYmzbQ2jaQqLxvwyIxszOs2s6K39N7ZJU1XxNBU72wpo2u1yslhSRtCEW1++x7XJsZacwgqqF/eMZEiBvZVT7s7WT5NOk+4XVB+eClpdd3NOSHVDmAja7SMkXafVh0ojvSoUqJ2lmgBlJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je5Tfkc6Q1FeU8wTC+Cuo7+k3x2dWH6lafD7UpaPGt0=;
 b=C8k0b47LqbDAa5Lkw+bKgh/5No6QNldMknvYG6u9FbEmf2/KgWZvn194VXiuZD+YSRczdIV/UQQPf/8IQupPUD5dXIR8BiuPMuB2T/DSPohxcM7hmh/vc8vBYzN7IV1f+J/JOcwo6kTeFnv/U2uWbOsI+qoGwj4ftBFh1QLVfvU=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PAXPR02MB7422.eurprd02.prod.outlook.com (2603:10a6:102:1c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 12:35:57 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 12:35:57 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix preferred service reordering on ready state
Thread-Topic: [PATCH] service: Fix preferred service reordering on ready state
Thread-Index: AQHXYP7y9dYDEFzAnkCTZSq5lr1DgKsTTl6AgAAZu34=
Date: Tue, 15 Jun 2021 12:35:57 +0000
Message-ID:
 <PR1PR02MB4794AE9D35473E527750BE1F93319@PR1PR02MB4794.eurprd02.prod.outlook.com>
References:
 <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>,<3213af74-2985-ada6-09d4-67d5ccf1f72f@jolla.com>
In-Reply-To: <3213af74-2985-ada6-09d4-67d5ccf1f72f@jolla.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: jolla.com; dkim=none (message not signed)
 header.d=none;jolla.com; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [194.4.243.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2318b051-d100-40be-ba83-08d92ffa2015
x-ms-traffictypediagnostic: PAXPR02MB7422:
x-microsoft-antispam-prvs:
 <PAXPR02MB7422AA8E3F87098836DED40693309@PAXPR02MB7422.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WmPVvgNoUWAj8cplkX2A62rTMVj5RZd26v5Ouum8wg5RZK5oOuEXcmj2eBNwn4QG+u1YAibtOzc987x93IrOeaD7AinuqC1fWCs6/8LDRWx/tKP0yv6ss/olSTPXGTD6vV07FOFEqTWADFZAiZVgw7cFGCeD40dc+N6Ly2gcCdFO9lyVKL27OI14mt8cx9Fu4a1tdH00svw/sVd4QqtrxuZ62nOAMG4s5y2JDJbYSgZNYi3EwlzL27UIjT9AzHHhS9hcOYyv1TB2unpsdsyN4wgLbiBZLC8kvs49yTXAhd/Rs+WtewU0MClbHBB4eKMotsOpA0+d7u3srAbip3lwG4OjJU2oSSjkhUJWZZemQivh+dr0Tkz3/mGqGm91D/pAOP5nHPkV20lERiVd/MhDwwHRnqfhvgWjT8j217cFWWwZ1jDtJBlKyQY1NUyJl9nxGUzirTH2AeJcyKibUsQV5JPJSQ9DlrgoPJFxAH9l/Vx3f1EC1D7FKQCuR2Ia9qC9/v+ZZbyBP+9MWumiXh7+9B1M/EmEJ0SaDpiDM0/rjUukqIIurIBz0s0tsz/0gu2bR5lxTfQ5p3BMYlSLVtSHOtY1nQaDeAFxVEezvz246j0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(110136005)(316002)(4744005)(8936002)(2906002)(478600001)(122000001)(5660300002)(186003)(83380400001)(8676002)(52536014)(9686003)(26005)(76116006)(66476007)(66946007)(86362001)(64756008)(66446008)(6506007)(55016002)(38100700002)(66556008)(33656002)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PsU1awipwAPGOXo2fK7cNTP0KcMjmKMknBCKQmPylnCkcmuDl2e8pZ+YAD?=
 =?iso-8859-1?Q?eWsryYOijCodtx4APyzvTUqx+q1vVl8wDC9RB9p/8JPAU5tCaU9CWa2295?=
 =?iso-8859-1?Q?E8u7sVbm3uGhFQK7oXy6p7H0a9BjVPwvKOQ/OV9vSrgr5QACcKZ9zUq5JN?=
 =?iso-8859-1?Q?Z3WaWFMN1oE2faJ9om+3Du171iJL4AYFfgV6hjumPl79OCkUvbkgSU4dWO?=
 =?iso-8859-1?Q?nqxt1ygyd80bCaUjYQQRToroiJck7f8S6go6cQXffDgvozkWncWH0Co7Vd?=
 =?iso-8859-1?Q?n06n/J2qvL+gLfeOYAaNdRaeNh4BQRJfdA75lIZDkUO1V/SSy/QQVUpXjR?=
 =?iso-8859-1?Q?KUtzn2eT/H+WwxLwxkVJaTU5ER6qn3ujQhxhZ+Hy9/jXND0wcTvKZvzgGX?=
 =?iso-8859-1?Q?KsP79mggPeVGo9cn5WvV0Qy3s/6tBd3jSw5WLtanT5Oi5hHvPLXc7Bfg/8?=
 =?iso-8859-1?Q?zH/XeBVpBZbbhbuRaX57gyv8JRe4gfXeEcbKtcLJBtoHufQDoghtv2vXPe?=
 =?iso-8859-1?Q?cwgUce//Ipth3V4VdIIuUtCJqTG7F0c2aTcwPfZGceLST7EtK8x9bCqF98?=
 =?iso-8859-1?Q?kZ3ehdp9ZiTflsGl/I1cXqpb5uWxVzCURQwm4UGYFFTFSYjMBEdcohws41?=
 =?iso-8859-1?Q?pgYMRGu5mkC8swoCrwenRl3uyR/sNvlkYL29YGLf1Vr8EWDzbeCe8uo0j1?=
 =?iso-8859-1?Q?BnAad4PohR4C7Q/0VZUY7D3IznsgOOSSr0X7EIjCeZethg8GdRPz97Q+Hy?=
 =?iso-8859-1?Q?hdy1Whn8oSw+Im0LeRq4IYRLAraDyizLz4pKf8GctrYtdHAlmtnkPGXISj?=
 =?iso-8859-1?Q?jBnFG0fw2dAUADG+gdfgVSBBAmCG3VB9pGym0/6xX76kgMZyeFuT2lNbNC?=
 =?iso-8859-1?Q?2zuRbJUvLXBqIwThQJlJ3angjBwGVs3FqYs6F6SSomNFmvBUzN1P35aQ8Z?=
 =?iso-8859-1?Q?ktby7o+/8Hc55Xus+RmPzgG+YzzmLkESPAb573Sr69rzlE5XS74s6TtLO4?=
 =?iso-8859-1?Q?kH4LjexSuUj+QEdQE+LIdN/ODMGTdZPaL6i7VDufHdfl51/5G2laiuHqqw?=
 =?iso-8859-1?Q?VtDK/Y0scVUiMKoquv6iDyeMNvb05zK5t7Xt36sR2Kt3NCRMdbF1ANDrGo?=
 =?iso-8859-1?Q?c+rAu0diDCu2mZDQ3O4qhFy9VTXp++N2XJi0vSnY2dBfF/6zNbAjAfjwzC?=
 =?iso-8859-1?Q?sLtSxcSTS/xlh/b9xfNNbQVjZgfzecvmiE7IZo0e4AMmcXN7y5y0LHh4O+?=
 =?iso-8859-1?Q?50HFj1YURbbavt7mm5roqPu/24CgbQ2OnsHN8SmO42Gudfp7VPGWxB2XSC?=
 =?iso-8859-1?Q?Hh6j3NVDJM9l+iASjNd1rnbPavjXAmEu/7ENpb+cYWnAl+s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2318b051-d100-40be-ba83-08d92ffa2015
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 12:35:57.5400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qK9a6iY5VTQIpnEPVh8qIogfLS6+RkQu5Zt1x/WVXbj4BGC9KJEYgtk97zBtnHs3w3kocr5rJwlkmzNG3U0/DgZZF5g77Fd3cb4yUqnBEF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7422

Hi Jussi,=0A=
=0A=
> Wouldn't this be more simpler to be done service_compare() utilizing the =
=0A=
> PreferredTechnologies setting as I assume this is the issue you are =0A=
> trying to resolve:=0A=
As I said in the "[PATCH 0/1] start online check even if service is not=0A=
the default service" former thread,  I have also worked on this issue,=0A=
and I presume the reason is not related to the reordering itself, but is=0A=
more a state update matter.=0A=
I let Daniel and Christophe Ronco test and check my changes carefully, =0A=
but I am pretty convinced that fixing the service_compare is not enough.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
 =
