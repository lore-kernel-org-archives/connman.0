Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90070.outbound.protection.outlook.com [40.107.9.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8B70
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 15:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAx+WUrf9Hkls6NtedFkUpIcdBFjcPrCfTA7d7N23HJb37sn4irrNF6H6ygkNN69BU0qrph3MQM33WWszEQYQ5swilNofLxObNoWYxKhPOQTbq9sCkuahSed7UYY3aRnhtErVszgXppttiCO71c22+I4Rc9ryvbMYyz+wm9a6bcSUAZx2q17pP5VeMGbcxZp9/qy3xrVQpBy7L8cjVpxPFtsT/SbrfHPgl3BPwXgmRKC4QIT8CPaoHbUVo8OtF75+nnpY9a/2x1rtN1Ev1Qp7wt0KjztubFpOfl2oo94Sp5ZR4HEDEW83L5OV3WfIzkoqHr0YcSh71dPC+PJg1eTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TNXmTP8TGRkbHr38ACECEOO2LP9asGtWL6njUuLRdE=;
 b=itUNcDxnynAzXCgZZ0hg+Cb4o3JDXXrVZiex2Y9ucdLvr1BIOjuqkwD8G0n4hWxfhIFXpbHXl+BplnddHYB99P9/z7bspEdKxnPLXQR1h3aSkE6+2jZoFVx8ai/C9tSpRKBKsTWCkeOtWB7J/dIr1fg+DP+TbxgI7ZKZJFdBPoQaozhnihYPfdUzbAosiuRrk4rNNfxOSJbbypy3Wu4ZddnoRtSQBi5Xxo4SUkLWWulF6VF283mRf6ZJjLe/lA+US6ZSOYcGOVZVybmjxMqF13kgn05UmrHocnGxDANn6qkADDPsabKEXnZdFfYJHDhXHq5LeXoRP5ohIlkwngtAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TNXmTP8TGRkbHr38ACECEOO2LP9asGtWL6njUuLRdE=;
 b=yVym2or2aRrj+oWN8FhEw0+ftHzirxESx8MM/fNO76vrGu+ERTrSSMZNkvx4cWCIw/ryGmB9zKH0ipwS/hM4FM4/nwOMsxJdrFBbtzuPMT6PtMkE1A5YysyQ7qOsEgkITroPY/UH/yGh8j+/FeC8W3bx79ZarVEG4fri+ve6tVg=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2145.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:11::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Fri, 2 Jul 2021 15:19:28 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682%5]) with mapi id 15.20.4287.027; Fri, 2 Jul 2021
 15:19:28 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Ignore state information in service reordering
Thread-Topic: [PATCH] service: Ignore state information in service reordering
Thread-Index: AQHXaEAKBbWMy4FLOEmVuozxMfJz8qsvXjiAgAADxYyAAAh0AIAAaLYX
Date: Fri, 2 Jul 2021 15:19:28 +0000
Message-ID:
 <MRZP264MB154471078FD87663548DE9BB931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702075335.opqr3lc7kzell6lv@beryllium.lan>
 <MRZP264MB154432CD7A2E3A804089C9B0931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>,<20210702083720.hwb266z5eo4xlv7f@beryllium.lan>
In-Reply-To: <20210702083720.hwb266z5eo4xlv7f@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c35b559-e6b1-455c-5fa6-08d93d6cc8de
x-ms-traffictypediagnostic: MR1P264MB2145:
x-microsoft-antispam-prvs:
 <MR1P264MB214536688DB6C76656800B70931F9@MR1P264MB2145.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JKpYtElIOtRQN4DXVIvCBeB1qkgZxzIELGLqJx1fE9KND2nfAH3TfgmE6+CkE29IHS2AoRLRfcY2CzqgRTeleVtCg3eoG8rnLSEiJxkOwJQjoakol2urT4fHtHLPaXNiZq7uxIPM3Mr7ijeLf5hMt5LtkZhplQDFgAF6Tc7ax6JbE//IzcSJjJw5nWOvEqT3jB6YbRmJ/wRFE2reTzwM7ah0qyr7zDUUckasgf+mfpeei0iFxg/S5TC14vZX5uZRcm00otQ63yclozW1X0cffZWKYHkwkj1badX5oeYinmKUWWTfcvI59aYQCHKWzCPjuWTRiQOO+fqXsDrk+C91y+3DukHTQQFY/mU0XYpyiDPuAchrJghGIocU3BgPfnsYxgm6iHU4UjURaXyo1R7CuGwDvq14Ua1CZXHscBxLU1DOQ0OfXeRqdd+LjpYuY73PejQX+yaeNqK3wKf/n8EV2C4TbWZxSy2KTz3PTS7vBKohhcVNKFHYZIx6nbSWvraqF8UH3SFToxi0WXfZJPjAc+fgunfPznVykeJnVP46dk6bcvi/8aZ+khKkoh5r/x+amEKW6ScRAmX0OlchLbs0ZeVNiM0mz9gGcxu6AO6LoFyhxW1HDPo9TLjlsv55nw6tUrIz9Lfdd0WBD+R/rg/9vg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(83380400001)(5660300002)(55016002)(7696005)(478600001)(9686003)(33656002)(86362001)(66476007)(64756008)(71200400001)(8676002)(4326008)(316002)(8936002)(66446008)(2906002)(6506007)(66946007)(38100700002)(66556008)(52536014)(186003)(4744005)(6916009)(91956017)(76116006)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?o5gZWQlvleArjYTPoACD4+GzuM2U3NxIfsmnm1OnrbUYEIuS00JSzl2yCM?=
 =?iso-8859-1?Q?srt900xQwIu8dCBS+YygYQHg6UMiEsf/WCwbNegyRQX0X4HNde1TgJmKeW?=
 =?iso-8859-1?Q?30p2BBQapJZZDbtQ+Wro7rBkYYISbQbnsOMvoNn4oBUDjZzB0Zf2DJ7myh?=
 =?iso-8859-1?Q?ZKE7Ci9dQWkXW2gnQx9cr2mDbKIhOYvDnYbGp6qFmyBsYK/SciVd19kmsR?=
 =?iso-8859-1?Q?0+tmBpnkjYnWCV8fYFL2k5yHpq9fQQ1685idXILG0RdQe2Sf9ePrx/xoDW?=
 =?iso-8859-1?Q?Z+aoZpq5xcJ2ezYzF/7wIIfujipZyNqDJCdhQKGLJ3BcssOXXIPUFLIbrN?=
 =?iso-8859-1?Q?qn0uVSxwMGZmCXgfkMqv+3tr462PoPH6FhOP0emERkUEU1ZCVpyo+ibVbS?=
 =?iso-8859-1?Q?A7mpP7Eq79DdJ9lxqO1tMwGnj1R7QCZt+R5jxE1Ct3TPcuxQ5nkc9M1RFn?=
 =?iso-8859-1?Q?48BCsCQ8PiohCaz0nSFYJyOnXLvqLPsVbTLPde91FqnqgvHp8ehhI4FI+b?=
 =?iso-8859-1?Q?jOWkT9kSdfhRq3OX3ejar0E6BfHAVwDXRyBzLLHlJqV6J4U9+lYiDaXfLu?=
 =?iso-8859-1?Q?a3oZxTuei1Q5un8MqzPG42HOV3PsOeRq0hpDT5cDWLj6P4QXfmELoR8Jfk?=
 =?iso-8859-1?Q?4lrNnj2c92ak0sceVO6p3q9WpGbJu8Pp+MYZy/ISS5PJuxTh3z8rh3K6LB?=
 =?iso-8859-1?Q?LxyQ+OEPpOkt7P9cecwO6a4aTI1bJasvmVURbIBHKjA4Uy9zelqKpRa+UZ?=
 =?iso-8859-1?Q?H0HB5S9pc6H1qFZh12+jFcmfy7FK+89gbMdmN6On/NmqabzjYvkIuNycLY?=
 =?iso-8859-1?Q?XL6WsFMfIobEKGsrKbhypBppL68WeIVJ2hZ8Xtp255YvFldS+5OTHx5qXU?=
 =?iso-8859-1?Q?FSsz+EBkt8AF+79Ya/pSvEh1IQTaVd/wO/pT3yEScoroZHtCRmqqiBnnTM?=
 =?iso-8859-1?Q?Kof0et04zfXOisdg8CrakOUgiBYNrTJujnSmNhxVtmCX++cCyaQa2oh184?=
 =?iso-8859-1?Q?/4lCkFL8XsiZSSZ3DN2aAAFF7MF1y5rUu0GMBMp/qr1VW9i+hxgef8FJC/?=
 =?iso-8859-1?Q?bF17Si0FHIxq33AL74Nwr5smRMAcjOcM3Jux6rXVY9ybPz/PYBe4YakzfV?=
 =?iso-8859-1?Q?uIEUv7MsQNVZAbL/wUJpChGQETqPV4w67qbVTRBlX6Vvg0WKWkyDo9xKvI?=
 =?iso-8859-1?Q?zOaHuDy6+YkA7KVmeIRE5YQgefegSgg0oen9oxgdC1WlG7TJ18Ve4EkgPA?=
 =?iso-8859-1?Q?v6xjW8kwbgfkyM4WTt0+a06lTl802FrH2Q0L7vQoru+Kp40IOSAWbk2qJQ?=
 =?iso-8859-1?Q?L+z6nbaDeeBqfr19rcE0zjV+vNhOq7EkNh8pXiXk3ug0jT5K7cTI1nbH8O?=
 =?iso-8859-1?Q?ojnr/gQ7dyIV2QXbG57lUvTYXuEQzIvNHz/cS/G0Nn1rQzlLc0KJ0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c35b559-e6b1-455c-5fa6-08d93d6cc8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 15:19:28.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEQE5hArhopfQH1OcU+TIz0w0alghMWX9PuSYOoKTVGbeC3dfgcSIXWWNBuCtR8PFvnX0XuBp0UfqF33uVQMTophSBsaJ4zjXA7izy3WDS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2145

> So you are saying we should check the order independent of the=0A=
> states. Hmm, without VPN Services I'd say you are right, but let me=0A=
> think this through with VPN in mind.=0A=
Indeed. I have not checked the VPN part.=0A=
I will develop my point.=0A=
With the following context:=0A=
* PreferredTechnologies=3Dethernet,wifi=0A=
* Ethernet (E) unplugged,=0A=
* Wifi (W) network connected and online.=0A=
when plugging the Ethernet, we have=0A=
default_service: W, default_service->state: ONLINE.=0A=
new_service: E, new_state: READY=0A=
So default_service->state !=3D new_state, the service list=0A=
is not updated, as required.=0A=
If the state still matters for VPN part, maybe it will be cleaner=0A=
to call is_connected() instead of checking the state itself.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
