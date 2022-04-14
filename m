Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120057.outbound.protection.outlook.com [40.107.12.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB233219
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 20:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcRPdfYiZqKGe77vUlhPYVt7CQ94ozQLUDpixyGLQ1gvmz3mW8kGhuWYQXL1pHfJn9Rf8QdpHFjQV7Z/ETu/vQ65adwQfPpVyTk9mTtdaCKBJVr46jsIfZw6ZGhFG0eKa9R6OZYaB+pcteevV69f3JsY262fWtwsFMghL2p57EwkZW4A4QVt+Fo2IuMzROWe1mHFx2B3jV3BRvwcXJxzk7hzKchYuGuX3iO3TC9J7CxzWU3qS7k2Q9ffkj+MrHiQFKbm9TGEAH1I5i2YKwJYQnl2XQNdoKdSOfE0294aSDDzryWo6ToSEnq+olQpyfXZxdo6d8PgQubmD5AKDcP5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jo0UlkiP7/vbZDZR4ftS+u1yNN9aFFoS60ZGXiPZI4=;
 b=Qh0RIOyalOvA4WqGpL+3G9NvsHOvWwce8wiLV4Bz3s7ti2nl3By4fRqkU7/6Sclq3WQrtZujuG+JRpgJg7m9A/hlcqee7c9qzglng/TaBNMgJfvcln3ke5o+RbZO4XpQrFkVWHHYdAnMkvFgPoTGrSfcqzSwqPamvr+AzjXsooNreCm/QZJiS/J0b4xkiOHPlYA+VtxflniWwMaVvPqdM3Q0csPBA/0ticlvUGiVY4IaTivbawXY4UlUvlISm/aMXVRHyGRWAMd+Zi7PaVIC+Cbna4YcjaFR+/ifRQbCTgLvIr1LqvXqE7jS5GPHZFt0SRcekcKoKOOt5dPo7X+2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jo0UlkiP7/vbZDZR4ftS+u1yNN9aFFoS60ZGXiPZI4=;
 b=dORptRV4E9ggHiPFi4LUrtWVAY9iJk3WRTuqn8PGDjV6f32j4TCz4Ta/63aPBtDocTfRPw2ZRnW7Q4Ug5avCbqz7nAiunqZVt/C3g9pfTb0jQpX9a7Zpm0oBgbElD7ovNiS+Qe/6/Qkdo0hx/0Hi6eGwEDGN49Nl1EtXsmulp24=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1939.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Thu, 14 Apr 2022 20:15:04 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8bb:351a:92ef:2b6]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8bb:351a:92ef:2b6%9]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 20:15:04 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Fix connection with invalid passphrase format
Thread-Topic: [PATCH] iwd: Fix connection with invalid passphrase format
Thread-Index: AQHYTXmJ+kVvqQMP3kWZjDoSdYhqwazqWP2ogAVsTACAABe1mg==
Date: Thu, 14 Apr 2022 20:15:03 +0000
Message-ID:
 <MRZP264MB15442F951721C02596A38CB293EF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220411075458.78136-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15441C29DB3B9AE00192133193EA9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220414184740.7yimogaa6nzopxfk@beryllium.lan>
In-Reply-To: <20220414184740.7yimogaa6nzopxfk@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 960fdf37-d9d3-4a03-e100-08da1e53763b
x-ms-traffictypediagnostic: MR1P264MB1939:EE_
x-microsoft-antispam-prvs:
 <MR1P264MB19391B90DF912235DCB4F51393EF9@MR1P264MB1939.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Uta3QOSPkYEevY4IMQFJ0Bqec15Dqcw9vINnBP5fHwoKQ8xJ0q8t1jAJikLSS01VRI2UIdxajTAode9eQ7M54rcpRK7Md1ACdY2Uu3dg1MhSDWkSyKVd2Xnwgp7qviqDjyCr08H1jHWBnYh7ap+kLPlaSOHXg/R9TDRnL+A8FJjwL+2/1N5Hm++7RUjPtwqrgGQVM/Dp1l5dK/3bYGZIH1j6WiaDI8eqNojALR2lvnVQYywPud6kBNZRz8XJIbBEhdxF95ddp87GhlZowc8tFwGXvtxQilq/mKcKoE4ycOlVYVbQnGYsdZJ2QQZMrL1N0q0ZuSLjMcFv2kD5QkwFBccOu0rIbQm9RCb856IEtuXEY+21/fQJHIB1RuOROTQ+t6p7wZYs3+GaPq/bzP7itoqSPwKaLy8GwmJ7WLDc92loC3pMOGIHRRTT4NQwm4Rerzvlt+O2M51PJ7DjalF6t2FltlgWNUF6sKHOUKXP5uCvw+UVlUsQQLvj7YOzi9X7sWSZz5zSJcRQsATDlHtnrBpNN2XYPYIZeIzvK3VJWvadq1hS1hodel/EUMImGewDfTO17f5kEBuWS+CnV9Lh0tvl5xtcSegViIcDlcTnKbydhMXXx7jJtrnucDTC6RDfUoUGaHAupQoV/wia7upy954Yyv+4MzRMJKCANh9BiZJ2dZiRZAVFEwBe5CL+2K9REecoBKWjYFVl2qfEYl9Z/w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8676002)(122000001)(558084003)(86362001)(2906002)(38070700005)(38100700002)(52536014)(8936002)(7696005)(9686003)(6506007)(186003)(508600001)(6916009)(316002)(71200400001)(66446008)(76116006)(66476007)(66946007)(91956017)(66556008)(33656002)(55016003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fUO2szmRHHZe0puCfriOiyKmpyxYa3Q9x2EVWNHqIAGnlpeVqO7N9WWYIu?=
 =?iso-8859-1?Q?UlG76uTg7zxbzlnLHkR8FzzSAe4xz6uJtHeiNGmFFeTBHSvFxigeCEJ115?=
 =?iso-8859-1?Q?Lb1kmDUnlJe+3tz7lbxtr9OKQ/z8ktfETjeN0SPpvk0BWQls5qfEeQUi6u?=
 =?iso-8859-1?Q?owYxLVS8MhTwNlhiYIDPI/Wtps39QQKtbUVYQM/a6MABjFHn1d7Ll4bfAI?=
 =?iso-8859-1?Q?hmmmfOeNA67zgSu+FzYijaZ7EhGrTrdvbA/+MFkKuKrPSsGyBc80LINQ2K?=
 =?iso-8859-1?Q?sesUuoIUzH/Oi0kx2Hkk1v3yVS4Nfx9HMy4L0pJlh7DsQTiROeFbHY7zlc?=
 =?iso-8859-1?Q?/k8gncK6Dj1Egb8DYmEMKoUfKQfTgZTDnFA1u6w4MgCazKVo99gw8E8fkq?=
 =?iso-8859-1?Q?HP8SxiffnFs3ZQMbCbTiTUBajZ5QKUYkTKvTK0Fxtk4MmEnjl1HOooZ4vU?=
 =?iso-8859-1?Q?ST0GXcaY93m/nQmjrD5qysShZSbESWKCpJWOQMFsNOTqtM9gCMKimUWJMr?=
 =?iso-8859-1?Q?j+gH2c2+HWRI6Rs+RG//OENptxqVRArFYlAEthYjkSnwkuI/hMHVDGSwiR?=
 =?iso-8859-1?Q?29/xEviLH4CeUcBdIys/qxF+YxnnsMyljNtTC1SUpGdhac1aR16nV0SLH8?=
 =?iso-8859-1?Q?gyWXaURFrRSohicVtjBTWvumpO3H7K688216VxBTjaql7F3gVwZ2+h2K8E?=
 =?iso-8859-1?Q?qzMLY/4Ilb7u9LkKZt1V/ZI9KRYme2qIPpmjOvVqTgYHhCmzqMa6XD4AR9?=
 =?iso-8859-1?Q?fxG8bzu6TztZWv4MSycTC4ZZkZ9YR4sqJ3F7eCcp7XbuncT5BvdskrA+VJ?=
 =?iso-8859-1?Q?xrDy3+8Bc/1BL+ICcnzO24pImhsfAKyFWB7Db7oJJCMV6olCQW+8ZQaY7G?=
 =?iso-8859-1?Q?7ZQbJGVBOeGFLuWBcevB/rvHnJdZmleMH4zT7pYvlk60AK9bziBK5ukfgH?=
 =?iso-8859-1?Q?nwfQF67mw3g+wRHsNbQ/PbC5I6jMxuT03DrFJStncD7H+cEbgxtd9KY85s?=
 =?iso-8859-1?Q?npZ7+KaJ8p15ndnD+eHrQbluOmUbkAFplXq+Z9qGNPPNw+SwnPzCXXPZ7q?=
 =?iso-8859-1?Q?ZaM4v2IruvsaC5x6v2gxac3cvIs973eKvYdyyU5UIxQ9wv98sqVlp2Irr0?=
 =?iso-8859-1?Q?vXbs+4fXwsi7gZ6DxPxMDIdxjeX+W32G4/JaGjoQkQWH7zollfOxYum3pm?=
 =?iso-8859-1?Q?j1VrAYCUd2BEiemJTEHTVHUQn7CgZvhhM5+1PsQTWAJ4bseiyxaceFJDTD?=
 =?iso-8859-1?Q?Kau6pwJB35uqWoXopEZyG3ViH5/aSKgTXxp9M58FvGaXtko7Hz19bBegpN?=
 =?iso-8859-1?Q?uF9PRxbUAYJzUQDwMmlHBc7CfRn5yRsyLW5Mv5VZR+QIBhyi+5nxu42Rs3?=
 =?iso-8859-1?Q?NZYd/HH2lOd6d4dXHEyw8PSFEKnv5M6Phhi+BbngTNHflOcVz76whw37E9?=
 =?iso-8859-1?Q?4Gakr1JJpC4FvHxkmaKJOB59NZSn+3T1H/qTFApl0u+q8H2tp1Z2UkMPr7?=
 =?iso-8859-1?Q?Qq9zElDThMI5LNTuESU7z+7EENAdtVnyIgupVvUiuHJx14H+FwP0AnMEUl?=
 =?iso-8859-1?Q?A97cztbkQ5wznWn6H1QTmdcEBkeR1upKaNtATn7zRQOCIRx7LdRsEMGkle?=
 =?iso-8859-1?Q?2Uly25SW25ekgcKyFf8TykCfY8+91UTmQa9/hwc0o3gDOXPz+5HsAQMEKb?=
 =?iso-8859-1?Q?kkp2+l9g4N3nEqJaCmxx4qJrpUTHOdElyiFwDP7isMTyQiXH/mF7V2NddF?=
 =?iso-8859-1?Q?vPaGGFVUtaLrGl4xWqd2G/U40CXzA+DliFnmZkUyRT4xi9LDYmsUl1HS+4?=
 =?iso-8859-1?Q?5+ZuDYG37D7sxjTMeWwZRtuTNxbaynITtIA65bid46GnpqZK5B5oKqvEk3?=
 =?iso-8859-1?Q?2J?=
x-ms-exchange-antispam-messagedata-1: gkkACgy6hhhSWm1s6Ygc0iEBrKF0naPnZXw=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 960fdf37-d9d3-4a03-e100-08da1e53763b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 20:15:03.9383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlQfAoP2BmMdGuyA7sR9X3fHVwufn3y0on/C59WzJV5QAZO4IZLle0THL5zk1faW0IV4TNwL3aouiKyC3vLERPqmEXbPn/lbRWXyFNfPsow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1939

> Thanks, patch applied.=0A=
Great. Thank you Daniel!=
