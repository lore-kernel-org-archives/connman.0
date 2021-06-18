Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E170
	for <connman@lists.linux.dev>; Fri, 18 Jun 2021 12:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEhlIg4UcKYGidNvOKCgArR6Mg8JD/77GJaVycce0+ngWi/lH1M0kHJaFnlvGMQHTs6KcZTpCUQwbVFyZIqfdm0dhYG6RqWlc2TGfspk4G9wu+bVGFwetf39Qh43TxjRUwaUFpEnQ/08Faf/zEz/xZ6J9PAKpa4097WStJXre/ldzfXI+b4eRHHVV6kZ2cp8lvOw4jBFLlQqgQt2XHGSyfuGqD8nzjwevzt+SuOeopS9Ai0wNiH7HEBuYonyUqOZAVXku4ENdF/zITzmQQuYPe5yGwsbAiyKbV3YOKTAJxmrIdBDeWrDGbtMYTRPHUjuXBRiM8Bj/kVJBDqYf+7QFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCr/mvyfd+m8QW+Hqbakbo8eOUlRyclV7h13haPTfEg=;
 b=anA5TMljrT9uJ7hpsifloUJT9fHG39bv1K1//DQu3y8nzWlM4dH4Q8t1E1v4CYq4ymMF+T4X5y0rHGpJxe4KVH+EPUwO7Z1LVw4v8CzeHel6mUk/g+qE6o4XcSoP/tgMt6uv5kOtWYDzU/Fz5kzENH6GOSvfrqtWMTZ2huZXOFQRHd7ROjZ9s3GTyx+C98UNUo4aT/ybUdM9QcWRyWHjWh1oghqux0EsWDi8UxmG+MfJuScmUrxe9lajEiDm2T9PdHkatEwM9er2PcTwkfoAGZfHQrHq8OuQXkGL7rk2C06zBGNnHWzoeQK+uLyzYhLSpT3coKtEQYDFGhFe+rIBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCr/mvyfd+m8QW+Hqbakbo8eOUlRyclV7h13haPTfEg=;
 b=x6BgOYRGPz9RPBQp1AjzCQyDAWabPakjD58tLOryQegfMCRNgmgZhrR+dH/gWbR3IsYc2hbtbNJAkExFWT4krT0qRv8O6b91bU2Uysagoo/XlWkaks9u+4Ch+rAbjp/wY8kd1RQxl439Ku6RSe/MjlIebeuwiQuIdNY02oM6aOI=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PR3PR02MB6474.eurprd02.prod.outlook.com (2603:10a6:102:5e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 12:39:00 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608%4]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:38:59 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: =?Windows-1252?Q?Luk=E1=9A_Karas?= <lukas.karas@centrum.cz>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] replace strncopy by memcpy
Thread-Topic: [PATCH] replace strncopy by memcpy
Thread-Index: AQHXZDmbHPv62zdogEy7bRZbUxDOOQ==
Date: Fri, 18 Jun 2021 12:38:59 +0000
Message-ID:
 <PR1PR02MB4794D05CFF3F4C689F28ECC0930D9@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: centrum.cz; dkim=none (message not signed)
 header.d=none;centrum.cz; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fd967d8-6333-4690-cff1-08d932560bff
x-ms-traffictypediagnostic: PR3PR02MB6474:
x-microsoft-antispam-prvs:
 <PR3PR02MB6474D64E57EF83AA1486B09B930D9@PR3PR02MB6474.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SU6t7Ad/Ic0cy3yhkx2hEm3mlHxeQmOBOQfx43+uPTXHVRNnoTz8K7RIXlpdaGI5bosXq9foK9eqHxxewCLRu9BLdLEaVv1yM1U3A1GRiZZapvZCRIF+A3EWBB0d1PBGaEu4HHca2iIXWho4eqWf5PlJb2mACr0Sdp76DSDfMqsNwA9KGOsakLkKqTuyJANsLk0z6llZJzTc/TrH5VENT8UGDoK2lpPjj1PoGl5bFRXdNXxm2TR1eGU9q+54z18ea5eE6v1oBPGPH6edsIYoZp2Kwgcpc76/1YDVQYeP5fVL0YGviKz5M+02hfBfmV7w/qFHTI71N6jg936tCtzdoPkWVQXWdNjPgJTSkxqst9jGLpXRy5cbntd4b1XnGoz2WtcTieSM6f3HtZii8UhQvg6CQiSDEtTLGbuxCPDmDAoa7LiGFVVrsFzV77hSYYqzovVpcsBh2yJazbQcoRxvntQfh17Rj6pnu2QwS12kF/V+gqFtYUxmLMjpcONxfaSSY8jRcXrkgSEC12ctzemNhDbzYWy7KcLtBgDFysr6Eb1zKZ4PNWQtjlQDLnQv5Eh3Q26dM7PlBToRANRX7u23N0WnrWuSHSWjRre6UEa5S/w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39850400004)(346002)(396003)(6506007)(186003)(110136005)(8676002)(33656002)(316002)(2906002)(7696005)(86362001)(52536014)(55016002)(8936002)(5660300002)(9686003)(71200400001)(122000001)(83380400001)(478600001)(64756008)(76116006)(66556008)(66946007)(66446008)(66476007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?+RwevkmsJgfc+wM74RB4xM+TSFdMx2jnYy6T5aUnNbr97QPgLJXtM0HN?=
 =?Windows-1252?Q?hHg2VwbTgV1R8TAfK0v4iVtiy6Eirtrfv7lWBqYWXB/namNvqHyZVSxD?=
 =?Windows-1252?Q?SJsXpvm26N9Jo0w1zMZ3CO0gc4peZ+YkalEc6oPPyqGTPzy477uP7rjX?=
 =?Windows-1252?Q?njuEOfdogQ5zpQnHJVzNvDX0P3xiTxliCO1CWNj0Cay96hcflY6GmMKR?=
 =?Windows-1252?Q?WuQ7czfehXEn05yFuj6QrdklJ4eZsZVv3pArvBSf4QZUf1wNj/U/sMsy?=
 =?Windows-1252?Q?hFCph9Zwp35DBHSIwfRKZ0shgMRxt5PMP3SNRFzsjy71cAZLcPX9ljhE?=
 =?Windows-1252?Q?mpULTKWumPlm1D2C8ZZkI58JrWES+TOTefNhzq0GsMXkbwPXWyg3sH7g?=
 =?Windows-1252?Q?aOnequEFysCsU49YVD6PuYgZMcV6Y6KSX9dKST+XTb3XhxGtBSytiTij?=
 =?Windows-1252?Q?+xg9zSXIzFPBbQkoV23xMFiILZkSM8KPJ4N1zBnw2pdi1Ul09NSr398U?=
 =?Windows-1252?Q?yampgxibfD6RcjCULHWCjB3PMSx2Z2rihRcvWz/d+x6BwJhrRx2TeQ2U?=
 =?Windows-1252?Q?sESCuCrQ78qGzv20VGwfgCAnw3FnnrxF+XQcweVCRNQA/TQZtW1uLiJF?=
 =?Windows-1252?Q?UbLQg44qMV897eirm+ihVWwALf8+hEEAkDy7HiRCINcAJw41aPrcrZYy?=
 =?Windows-1252?Q?9OvDeRkon7Bny0CHfNFAH9dD23+BDy57vEH/PMGfyEieUhuY3Pb8LTqn?=
 =?Windows-1252?Q?vu4pkmaduRF8Vwmioq3AbAPJ9U/TdwdSLkP09aYj15ayrwqzmsnhETjP?=
 =?Windows-1252?Q?0jt2P5JS+GMGmUtCOfKa16F9RggzghCUCMAVAnLgm23R0C8k8ZPjXttF?=
 =?Windows-1252?Q?qWk66GdWoXDvlodNjZgcMhwVBvFemWbya8aYJouo48UsvM8rSY6SfVTt?=
 =?Windows-1252?Q?OgaFj6sUE0hBwoG4ARe+YcOFZo/CvbCyB2qav1qOhwXT6aGafVQeMvhP?=
 =?Windows-1252?Q?jKL66Gv/m5id5s0E6NZsiBWUrEf1tgK2NNzoWGCspmuHOjahrXeaLItR?=
 =?Windows-1252?Q?301zNToVPVeHJt8VM+PoOHSU9uNu/KRjD5g1SzXdoh9BFBdCUi7GyZFF?=
 =?Windows-1252?Q?xShKgGnUJ7rRj2/4WiNgH/3Pr31eJsfAkM1aaIYLU9DHGHKJtRQ0+XRf?=
 =?Windows-1252?Q?gAFxCpwF8cQGfw8TmDaHoxc8ISas439rIZibyoGC3Nb54JnlXwydAHh0?=
 =?Windows-1252?Q?RaVSuFNPdjyPnpWGv2w63kf2G4Ao4v6z9iwgSXKvXOvK8LCRzu67X6QG?=
 =?Windows-1252?Q?uHApF20VTqqvaPt6a7CpkbiWZoLkaX/kXbCUhlg9yGtUuSBarIWE5KzF?=
 =?Windows-1252?Q?g4yrxvV9tCp9wh50RMGvnTXGUwffmeprsgD84Su2SX+yGmA7BTnL1BIR?=
 =?Windows-1252?Q?Gzr+iD4bd8BdGv8GWI/aLIqGhGIYDbdPJovlWhMzKLU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4794.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd967d8-6333-4690-cff1-08d932560bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 12:38:59.8656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hp5uU9heedslNvCElLJa/027HMJQxMSZIeEeXKqbQoKWzAwt7JaMkUJHupOZovCpHp43lwMNnq8N2XV8r7LFL6UZUc3gPpnYlTYUO9ApK8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6474

Hello Luk=E1=9A=0A=
=0A=
Thank you for your patch, but, even if I have not checked the =0A=
related sources, I really doubt about your fix. Maybe it will not=0A=
be a problem, due to the following check:=0A=
if ((uptr + ulen) > uncomp_end)=0A=
 			goto out;=0A=
=0A=
> memcpy is equivalent to strncpy here as pointed by Santtu.=0A=
Please be careful, no more warning does not always imply that=0A=
the problem has been fixed. The warning has only disappear here=0A=
because you have replaced the call to strncpy by another one.=0A=
memcpy and  strncpy are not equivalent.=0A=
strncpy is dedicated to string processing, and enables to avoid not=0A=
null terminated strings, when the string length is equal to the destination=
=0A=
buffer size.=0A=
The good fix is just to replace, in the strncpy call,  ulen by  ulen -1 or=
=0A=
strlen(name).=0A=
If you really want to propose a patch, please refer to the commits=0A=
(sources code + commit message) I mentioned=0A=
(90f0e412569b327d8b25b834623b814f1fddbd19=0A=
& 3dbcc963a66d43e4ac51c97de4fe116ec72eb9f6),=0A=
it will be a better approach.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
