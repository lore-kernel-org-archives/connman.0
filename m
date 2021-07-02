Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120043.outbound.protection.outlook.com [40.107.12.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A6168
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 08:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h87/qxVTtU++7XGeAtm8Ku2KJRAy51VuIqes9hRvu/ERBi0GKG1dyzAyRAhclmlLj/hfHmATJ/+8SWhtNLwbGrz1FBBwI40OB9ZXiQMJ+fwfylvcScOxH0I737x+p3C0eQLkVPDnZe6ASFXbErmMmNARNHEylH0fLT2tyKbJ6tszppP/JwMVz/q7uPi27drt6XMGR3ri0LcMdVyPbRnGeIaQEGc6IHHQK5tHmG3eYlXRn0CscV3jkRYYcr306w8IsEIDEsQ9wVayD547AnBm17Jelnw6tpFgJHE3XH/xdGnslmL3qHmZQ63YdP6SYdB1MrP2Um+MmQtndBxPI2qJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASfMUQWKvfTmoq5WiWTyL1GLXhEzH9V+Khi4joNVTQU=;
 b=cisYaR40Tr9DpkZvxi9jQvm0DjUACErmHAoq+YFKaCeYscTgBxUNkg4cFm1nJYT9SwlRPtTsH/BuATvZpjG0EU89SCYGfuvg1wYwSRWg6cszqVSNO0s6KyJkRiJ4/4QWOQ2vK7p+CaWK1AaIEZqjKCNdz/fMV0OVVqw5Y/YeYkN6i0aBNQdsqqcR+kqAtE/se9k0pawsFXbwzxjcBcoXn6s1Jlvd6OCZH5ITF0gIbQ//ovbyU6DxRiwqDtJt0iej4+9olbB+hUCqExRiSqFhyOMrAkJW24zZKSCgo/A8d7hAXgdv5IYfSD25SAF9GJuW2FEfJuzzEZgY2DRTTgGXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASfMUQWKvfTmoq5WiWTyL1GLXhEzH9V+Khi4joNVTQU=;
 b=0kl/VsFtZQnSDYMEHlYZaXvfsG+y0MdcBKAvhUhmGkA/ebHBUFEDMJvAzL9Zy/CWY2eLvk27NwPjqV7PBQ2gwRGnrauQcuej5+djh3ErXPBgEMM1iYZG9RukmgpT1jx29Eprx0dtO3lBzN3yY/p8GZbO0TUSDowBzK/pLjaknKY=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRXP264MB0648.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:21::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Fri, 2 Jul 2021 08:13:27 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682%5]) with mapi id 15.20.4287.027; Fri, 2 Jul 2021
 08:13:27 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Ignore state information in service reordering
Thread-Topic: [PATCH] service: Ignore state information in service reordering
Thread-Index: AQHXaEAKBbWMy4FLOEmVuozxMfJz8qsvXjiAgAADxYw=
Date: Fri, 2 Jul 2021 08:13:27 +0000
Message-ID:
 <MRZP264MB154432CD7A2E3A804089C9B0931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>,<20210702075335.opqr3lc7kzell6lv@beryllium.lan>
In-Reply-To: <20210702075335.opqr3lc7kzell6lv@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [88.165.98.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfeb35e1-7817-4f98-41cc-08d93d31452a
x-ms-traffictypediagnostic: MRXP264MB0648:
x-microsoft-antispam-prvs:
 <MRXP264MB06486FE223A9A68D591A39C9931F9@MRXP264MB0648.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2hk3jQ8JpdifFw+AODxojUo89QUQ/K66CExWdmh+qc0j4yn9IUqljqypNKAE8r80tnzrLq83spGdvQmMZ62RpUC1cLSizROp8h+/Pc5vvgG/B2bz74fk3SYXYmhbpJ0DY8Tr/9W4xMF/rzWyjJu/twpHg1x7Kop2Yy/Wyfu555Wj+5D3zomMptnWaVXH04phnYS2U1gk2hse8eRvbLuHaewyGRRhvn4DLtrPUSz+kmmH0hYsSl/mcYotKZaBMXb8wVwH+VMyo3imfAzV/8jpqV9vCCcgHH1+9FCYhIhngax6ji3a0vxRdZNCRAACOIMdy6Awh1O2z6P0Iafa54eNRI/zAoJa8ns4cE0R58jjKAnFfcnY44RY978nyCVtdEbZZgbwGuwhWg7mOSKSWZVlodMftNc2LvNihRs8/Qex7euMqWH1f6agsWOKMi+HBVx67hjcE5hWn44y+V/7zOvy0GuC+EMKGMIXsVi4nmqoRq2yRnXFgtD6jKajwTWRYRPhb2h4N96aQ45CQAuPQ04UBcMIgZgiMj5Z2/unqKYoF0l2ClGd4L9iwrwYNq3rsH56EZVIOlct7p1jR24okfS9leadZ8f6FxgXnbYkgD6qBTDAbPaqgU/mmLcLsjTOUm3v2egDvDOobxNwjghX1LNcBQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(2906002)(66556008)(478600001)(66476007)(66946007)(26005)(52536014)(76116006)(91956017)(4326008)(558084003)(316002)(64756008)(6506007)(66446008)(186003)(5660300002)(7696005)(6916009)(33656002)(55016002)(8936002)(83380400001)(86362001)(8676002)(9686003)(38100700002)(122000001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ASAF9KlTQ4pLDxbGZ8ieTgS/wKi3QQSYI7/CWWASm0Wv0pQiEC97DHqntW?=
 =?iso-8859-1?Q?eYozdQ8KKSloqN7CNkzUyAfzeYKEqDnu0qcKRZI+zmdedrJyyxWdBDnO4r?=
 =?iso-8859-1?Q?rfscCGBik1XVTFNNERStGl5iGHNJzLSHjvhClvoBThoUr/a3pWRRf+O1iB?=
 =?iso-8859-1?Q?OOnaN9E1DZ0TTFmQpLBZDhFbpWHQOvVLksDtgTv23faO7PdtCNFLD2CYRt?=
 =?iso-8859-1?Q?5xXNZlGyCrsw333I5x4s7IAU3GpqrdXfhQrbqyMM9x+FmcFgECGhHDSkXs?=
 =?iso-8859-1?Q?rOHa/O2LH/uxhTzzq4Y0PHywBiRPaHLtPAQbQb/KlugCMuf4uAIWM2fZYc?=
 =?iso-8859-1?Q?LVKNpmtuEjU8CMkbALlgf2apUXPc9rxNqLd0SMhjttj8IDTYwDK1CUMYj1?=
 =?iso-8859-1?Q?Cy0qLaxEgK+PTgldJbTiF9UO3k+1aSeEQWdCqfiTHn4YxaKwmVAbgIr+Xt?=
 =?iso-8859-1?Q?ORFPbA2at1U9vqE22s/1N9qtrcePd9E27IW/V5R0sTfoVHgKB6xsNadO97?=
 =?iso-8859-1?Q?5JuNOeXKYQIb6caIeLZgnC1uYYZ3MpkcyNup6eMmU3hQ9qL6oZieTKbGwa?=
 =?iso-8859-1?Q?NRLPpOtC6OmZzyKhl8W+q1xxvHs0ROOEuwUfE71iTl2CSUEMUr+1/gAZEP?=
 =?iso-8859-1?Q?CiyANPmrP83xzOFXWQMySrAv6tc9w9BBXw1XbgEwuMoI5+N5Nax6jzOAAp?=
 =?iso-8859-1?Q?DPbkcf/g3vWRzqgXbRhuRpIDt8cxT+l0M4ycJaBfE502mqq8P1m2qhYM4g?=
 =?iso-8859-1?Q?onUENtqbUe6B4Q33feOeGz1gZnhrVt5GsIuEBjauv+kBVQQiQYfnighT0V?=
 =?iso-8859-1?Q?5AIP7QsHbxfbq81IFted7gouUg2U3CwQ2qarseSHjhqadqN9ezAQ0RbQ/y?=
 =?iso-8859-1?Q?WWwYiJ6OE6xP+XLf0roMoWclUSe2he2zWoLnxjNca0LyZ8NAoXxnB9bG4D?=
 =?iso-8859-1?Q?1IlZHYgeRBH83mFJCKJD+emXLsfqY4wYnGxxunvwY4DRIbdtMPoO5TWoMf?=
 =?iso-8859-1?Q?TXA/MER4svI7cL7jVBZNa9UpB1kZ0FTsoMy/Q7reERIAwKOX0oqQLDeIMW?=
 =?iso-8859-1?Q?ZuoLiaUo8oRJbpwbgc078ayUbVtcPiJ1DxGnpiN1ulEYxjqBSqJh1CxnK1?=
 =?iso-8859-1?Q?CY6C+Fn9TD4f3y8stcGnHwwG89Vo3LHttusIrvU/T1ir1n/d/n0giPcwOo?=
 =?iso-8859-1?Q?WnOzVoktAS4ewMhJrysdB3697ShFTVzMLAZrbyQLzegq6BNjA1y4Ttb0V2?=
 =?iso-8859-1?Q?XUTlLXcHaA/X1Lvp5e1swBpC3mP3HjADU7HzfEhMHQPBUOXP0ICBWOrUTv?=
 =?iso-8859-1?Q?h46uDkkJraOQOjTN7WbGI9AHQJsphejXbelQHNK2eazdenA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeb35e1-7817-4f98-41cc-08d93d31452a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 08:13:27.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Mu5TocR3F6MTYtIYVEY58iyVowounwIZcwV6QqB4NrEVRhXCeChtn1CsqqC7laQEeBKimz7hzh7zSnnbkaThRsMWIzqEFMziG0WpCunxsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0648

> I suspect this one is needed to the moving of the=0A=
> update_default(). Let's first figure out why you need the first patch.=0A=
Daniel,=0A=
=0A=
The involved states are "online" and "ready", so it is irrelevant=0A=
to take them into account here.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
