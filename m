Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120045.outbound.protection.outlook.com [40.107.12.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F92C81
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 08:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWWtGqmGw8qS3TnPnftKcUzkBv3VQUDsTMQJgyx0/VgONlM2iTRvVF6NM9b/7gYXl8PUCORguLqCJOQxdunKHpRiKFJwh7EPZu6ZZVLB4JA3B9XpbBJwvvk+3YPZp6F3yOpSJLo9UWBPr5qRYn4ZDeK0DInsx6e1Ok8IbnEiTQfMfBWEQUcXchjewRFQDE+Vz1kyURSXFoztEcO3O7FyS1+lAtDqYBMAHouOM9A7JCZJ5SIcG6D5pts0iQh0gcWdr0RA/+/9aOE5hDt6CTaK5F2eRIxH59GVPnv05DqsAAGpIXIpjYU5vE/VLGu4wFiLVLdTaKaAJ9qVvvVBfHQATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGpzrpQP6P+dZku0ZX+Z4OrE9XU0CHmFaNFwDXrxpXw=;
 b=NhEyLJMnyqNzt0uQjDK3M4iWODW3UwVg4pTagAAEIfIVUmP7PE5bBXLe+Pq/VhA8FjgIIlNTHuWEki2/kMgNR/Ip4bUBorwwChNQ849y3W12dRbTRNhgVgsiKYiRUcXNlcXeO15EVtFfFKqCJ0jI0+e2GkqZhuc0uT3p9GJWj+W1wGp8/vLr4CBZWVmCMISAYYZM8PLRCMO9UL3BEFmLzZDj9OzGY8bN025oaqhSUd1LJCt6i02wx00gwpNH+39uzfVk5jwIlsk/dZ6oo0XqL29mFkQP1Y1cQiBPADsPxmxjjBvEEcumg1Mxsoo9shOwmZ/xQssvPa4s0Sf/oNiSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGpzrpQP6P+dZku0ZX+Z4OrE9XU0CHmFaNFwDXrxpXw=;
 b=cpjDVRW6Lf10nUbu4upi4x0jjVtB1GrI51kqlJJajWy6x8WodGvfq2XSJhwyt6sgElMqoEHrd/IuPRnOCMCCQoUOWQ3qgdWWMvYjzoHlhKBloaS4fl1/frOUMa/eY2ffIC7xXJ2xM2NAGYcQAyfYsmo0jLYmQOwyYYVPDsqP88M=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2117.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 15 Oct 2021 08:55:10 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%6]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 08:55:10 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH v1 0/3] Fixup clang error messages
Thread-Topic: [PATCH v1 0/3] Fixup clang error messages
Thread-Index: AQHXvzfDb7eh/qRWGE2sPZyz81DOgKvTxKqQ
Date: Fri, 15 Oct 2021 08:55:10 +0000
Message-ID:
 <MRZP264MB154433CE695C2E97B02500D193B99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20211012070648.28947-1-wagi@monom.org>
In-Reply-To: <20211012070648.28947-1-wagi@monom.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 8eb5a235-0640-c7ef-730f-50b5e8f5e475
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3694ce0-8ee1-41eb-3520-08d98fb97e72
x-ms-traffictypediagnostic: MRZP264MB2117:
x-microsoft-antispam-prvs:
 <MRZP264MB2117F241C3EACA2C78FE72DC93B99@MRZP264MB2117.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yHED1ANpY9JciaCd/RfdfYaQw6zJv7fleK8vSVBH3zh2jaG3kEcv7Y8BsIMug6krPjwis2g7caYIWW2Q+2TgIvlSrhGPamEE44L5LhBDz6kMdlKUBTdjhqeoAlpF0wz+/8QRF3N/cC29PkqvftMCsMAJ/NV53db3BD4ecrcWTi3zB7tImXrl2RNcPXEOwqE3udP/hIg6pNRKbh/msXbpkTwij9QMTqdzuE8rH/OVxm1duMwE8ge8S0+ro4mREUu6dt2LKa5W/lqWvKGOfU2NudeJ/Kgskf568xmbNUqexpiY50FAMI+MMpqht/THK2zQUr3C2Cs0FsAw4Ak5zdCIT3WVWb1qlHQP6EPW5L6SvgZJDKea+vM6LikRAPwdMMpYLtEOAgaJJ/l7Qc//8DW02UkKwqCYahW2Rj6d64jAmpVEVZUm9mUxg09nfKtEtIzybqcCRQ74RvGBCAHytnNVvNrlhRYoxxQYWLEfnme4zgFmilBUs7wLLrdMrh7pqfRKh+rAyu0s5HfUt6j5XtiEzoeBt75M/t3AKv+HE7qB93OAqXCqUSFVAH/Ga9i9d8arzzB5dSRpQsJF2mXVz91ObgEdLuNoxlj0EEmdbPiQL6Hkm4ZBCJDSDKKa4MdixFRbBX0P6o8gJqDZp0HSF7/Y06GnVAovP9jEtA1zy2EY3d3Wlw9/WIUg6DE1FwxUc/o8KBpPoKztCgu7sKsUJNRW/w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(4744005)(8676002)(508600001)(33656002)(71200400001)(83380400001)(6506007)(110136005)(186003)(7696005)(66446008)(64756008)(66946007)(66556008)(66476007)(38070700005)(8936002)(52536014)(76116006)(86362001)(2906002)(5660300002)(38100700002)(91956017)(122000001)(55016002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6mjK35HK+haIg0u/uOqO2OOML/sOPgOaCQ+efCsS08OcpKM3+WC0BOTonK?=
 =?iso-8859-1?Q?dkCIyBYXNqPvTyK/bQzzGVKHNsHdyKdIMQ4uMKfg7W7RIuMirfR4EMZKx3?=
 =?iso-8859-1?Q?nJrHM8zOSK7e/JuZGpjwKADqrtiQ3413P/Lx135cvPfoSAQOmls+ZXeQVj?=
 =?iso-8859-1?Q?iEOQY1FO5BMeNTeNymOwFkNBpVKLpxdk6rj9vNq1EctmiAYw16gODema+Y?=
 =?iso-8859-1?Q?qOktV7j7/9AGHC+KNBBWQrT8gGKoiUaMjpQRomqB5MkV4jUwyHb2CJ5XO0?=
 =?iso-8859-1?Q?Kb1osoobmY5HhqncqdokED8rfxAQJthHUobp2pUmIdm0tb05IVMWU672d9?=
 =?iso-8859-1?Q?Kam4AzO67xP+XJNZGsGfNvv8tlHzYzadlb7RPKXU2DpYzEaSObgBKE4usI?=
 =?iso-8859-1?Q?riVq+resx5yWZP3+ZbEbgJqLyEpK36PkfK/BucyiXNvr9Trq9U6VlsJHSs?=
 =?iso-8859-1?Q?DwqVyTLvougYQREHu9pfMXEptMSK9GNcdrUgEexG2gmYtr+mkKMulPw4HK?=
 =?iso-8859-1?Q?HDsBAT/LiaSjF4jXC3ONhZAMU3gsvkchzXhzOAlGGOl/IaAyhpL9C2u/VY?=
 =?iso-8859-1?Q?FIunm7fQ6+TaQ0MfnSuV4ZiofA1YeEg5S7T1iJGk8OSro/45bSrA+A2cuB?=
 =?iso-8859-1?Q?WZRapvT8boOhhejwQ4bE4ymrTZDv3Y1vH7V3w41/7RZAh7893Pi/y6w2SK?=
 =?iso-8859-1?Q?/XaSQLDCX2IAT3Yx2LYl6JV/7RdfJubksszAVqtsenPcFUeu/y7QARk2zh?=
 =?iso-8859-1?Q?ndLM+4vHvZi2IXquJpH3intAoVNKEBGoyCh3wQZfIMVec4NLxBOC/x1uWF?=
 =?iso-8859-1?Q?D944T2JXAZnsPY50IfGurgznYW4JK6mZUEbJJNcqYOKEltCcnokE6HuBvJ?=
 =?iso-8859-1?Q?n3Q2/fte55LSD56nZwDTkbUlPKJitj4DaScr7FCL2zFKt1s6Bd4yvEIp/0?=
 =?iso-8859-1?Q?i9wqa5Ge4znB7Ha28cdWx7Csk/V9vJkaL3IW0bmzkpBSNoE6DNHytRAYB8?=
 =?iso-8859-1?Q?Yw3/b2xKYzNFrOZVgNvrmQbimQtZJw59yl9T/dfSXjepD5zMpAo6SMRix0?=
 =?iso-8859-1?Q?rUn5gmRmP77981huaDGcteCnBXsQZ49AOlgsFOW2eSQsqm5Gf6hJWMJj9w?=
 =?iso-8859-1?Q?fJ3xJhF8gUijtmx+QRJtDlQzwYOqZhIQaKLkXtOwF7fJ8tR3c6Us8ry3dr?=
 =?iso-8859-1?Q?6hYgYzQAEiJJQEsrCUj7eMLZ360CC8rDT1812oi1OdgXBEyVPLVd9AikD8?=
 =?iso-8859-1?Q?JBk1ImPP2SYUAnJkR1lhnT7nJH50uul1+j727bdEVWFLtRPTLbLgouLINW?=
 =?iso-8859-1?Q?I7euWYlegkmMTI/H++9ZQSpZMH4sp/QTL5/S1sn3tHxgbCaMdmfDYxp/yx?=
 =?iso-8859-1?Q?8LxZtxKypF+dCvzSn3M4X6xzlKDbRmu+vGXB1Hb8XK9yJj79J4Au8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3694ce0-8ee1-41eb-3520-08d98fb97e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 08:55:10.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTuX8T1rC5Ko8/V4xMniekGpKIgOdKuOjvjpgRb+bP3qhCCKN/Kb50j/anB3iiRfs58iui/nXaDgkYt2d6F30rKPhlzzziVqajnBG+PLBDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2117

Hi Daniel=0A=
=A0=0A=
> Based on Emmanuel's patches[1] I tried to get clang to compile=0A=
> ConnMan.=A0 -Wcast-align seems a bit too much for clang so I disabled it=
=0A=
> for clang.=A0 The rest are couple of fallouts. Nothing serious. Though I=
=0A=
> was not able to reproduce the maybe-unitialized warnings.=0A=
Strange that you have not faced the same compilation issues.=0A=
Maybe it is related to the Yocto integration I am using.=0A=
Have you tried to activate maybe-uninitialized warning or do you think it i=
s=0A=
not necessary to check this one before providing patches?=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
