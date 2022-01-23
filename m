Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90054.outbound.protection.outlook.com [40.107.9.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18365173
	for <connman@lists.linux.dev>; Sun, 23 Jan 2022 17:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpFuwcUCJkRJoZjyGqI1jUkpRkx6XBpwmJ3wgzR07805PDFU3FVqaHUhuoBIG8Ql83A/ioCkVmhdrKPwZxM0uNSJcj/MH/LPEgHG31eXeCMV6+Y3hAt+Iu1TkgO2oLMvQF2SDxFZCsMN/ntc1x+mh/nNcVQCX5AH02VGvDvaXdrcMggEks7rT3yTy/Anw9m48+wotmSqsd/hQKylEi0ahdI2A8GV7SzSr9XuMi5E76yz/EphHKhOaKckrHx7YPBnfmPiSto7MFolDZMy38i09UHPCGO2gYJo0PmlUY4um47D7XpxGOmBqRQxgPUJ6Sd80Shs18PjmGcTbvzHaPLAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6Q5TzS2WrZLr+Ma6daNBKIYbTiIS6X4T/HhEYTh3aY=;
 b=JXhNHu61DwWPtIXFMeIdaFjViCbSeaE1EMW8C1ZIM6t9hLNPVfVKnwE4Wo/bW9eUvTQC+v1kVh+knbVG78QxO3DUJlTxfz9CDwZMg4/FY+6Jyk7CSfgyhGPfgaF3CjK/IFTm2SGrrLi2G+coq4LuR2l4gtd5sGlT0h/9HcnIWXjhKnEne1KPxU10Ac8WUi4zVkPBkmmSgHzIrLFhGFZp5MP/ypRVqQk++E11qU8XhAFynEWbCtkVii4DSRWCCEmyj64N3Thamo5okglC9sNqOS0zPrMPZcjLZO3LlQt2DBVjkeDCbB697kUTj5Gzanh4tqptHS6VLD2BLC7H6Nw6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6Q5TzS2WrZLr+Ma6daNBKIYbTiIS6X4T/HhEYTh3aY=;
 b=KseBM/Wx+bpSOy+h4fI+45//KYrsQUWRwBr+dtDoJDbknwuQfbwMfbVDpfyepl/nskvdbAw7qN5UTG5HawikfHMl7qYGxaxGBa6B6yGaLWzSCwfH0uFD4b8Oj3IDqGI+wdn0c/bpmrP6E3wwSAyQbUz4e1zGer208BBkOm8hi58=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR0P264MB3579.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:164::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.11; Sun, 23 Jan 2022 17:04:33 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 17:04:33 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH v3] service: Fix native connection with wrong passphrase
Thread-Topic: [PATCH v3] service: Fix native connection with wrong passphrase
Thread-Index: AQHYDrGkr9pHFVUWJ0GnIP17jv5Qa6xtRpVsgANU84CAAA2KfYAAKygAgAAB//I=
Date: Sun, 23 Jan 2022 17:04:33 +0000
Message-ID:
 <MRZP264MB154442FC5C38510C1526952C935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220121102736.3323889-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB1544B85627F19D2599911150935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123132351.ppud4auaysfmcfx3@beryllium.lan>
 <MRZP264MB1544FAB6EF32AED6479EC82D935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123164646.fzmcfsav2tb7vpba@beryllium.lan>
In-Reply-To: <20220123164646.fzmcfsav2tb7vpba@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: f9c33ecb-c63c-9f2a-3b10-f75acd4c7aab
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e0b9936-4883-48ee-3744-08d9de926d9d
x-ms-traffictypediagnostic: PR0P264MB3579:EE_
x-microsoft-antispam-prvs:
 <PR0P264MB35795CADB12C9B31D62031C1935D9@PR0P264MB3579.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8RcF10qU1Cv1/Sm0ZRFEoalCJd2neQenL+GUcSR9vSpcwvz947w64iIBk/VpjyImlvWm039Y/db5oM7PZ0VhwHaFTRpE4oNvRr9LHQ9RGbtKN6IfVNmgxJFsQZfPW81oj+3xMUbNpQp14wseuzyozoUoEdgqf+sEZApXmL+OYPsky/IAzYwMoJkb/5djhvLe7NjX/+9pI5Zk6HHsQgfE6FdtvuGXZNSrh5dFpLTFY6t9v8XLYKfz3GzP08o3Aq8arzOgO5KyEgPQ2DNmUb252typsbqHoE3il0PKzHwrHDjIZ/PV+0v4cJLymMeI2tXxp2UxeU9c1yQtno1p/wLwHW76LsD6MMA00AHjGOF9LLGDcA5zuyN9+31ZO+wfMgfGXtUnixMqmWpQmVTn1PRT9/5EhQ4KUuOg+vRNSQ7DnEoHPmbwkJJO4uNhmg9zE7FgXiPEW1M0DHs9YbyDPoMu6NoD3bemh2gPUYqdklyjhQkCxhnBMdVQNnTB04qCKMeQJFYDyNracRVB+xN+T7BDp83vs3u5ouhaefEpcMTnqGUtf8FygTN7CnqHiBWCRCU+UBdVM6yatCto8PRL8BgeHjpPQz+ts8W51heK+LAT4TKTbUyyUaXmktLhmuO2P1AbKmsO5N3oPZ/9S5CuXMhjm9slNk7A7W0OJvFedhDGkFdMhP5TUkP4ImPgEWQuMKVGi6I08yC67FdwnMtYP15sKA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(86362001)(55016003)(8936002)(52536014)(9686003)(83380400001)(38070700005)(2906002)(33656002)(316002)(8676002)(7696005)(6506007)(122000001)(38100700002)(186003)(4744005)(71200400001)(508600001)(66556008)(91956017)(66476007)(76116006)(64756008)(66946007)(66446008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CIE8lznKu/HL0sAa/I9zV0SEy7HCPleMT/FaPeYSZY5rFouAlB/nu0qYRI?=
 =?iso-8859-1?Q?jP3LRX20/CNIjIuW4/F4swT7/d/hsQGur8hZo9ua5cOmjbcswFppV1tSKi?=
 =?iso-8859-1?Q?nh6e0uweSIXsCkXNsAhwxIOfPK7nYWyJfwu9XLqjtKvmigfq97E3CV8tV7?=
 =?iso-8859-1?Q?dJzcuHZTjmpve+QGsI8/zv72xH4zTHg0R3ukwMpdnErz6wk/Yh+ZU+2j9J?=
 =?iso-8859-1?Q?rwYmIOdnHKSNN6wwIYf9jV5c3cWKx86qONTSp4JDQraPFZEXDSsxmsECvl?=
 =?iso-8859-1?Q?f95Mo+4vSvT4FxMmnlAlSWdrONm8PMo00p2G9nW0MY5JatHaq/wFeEWW/6?=
 =?iso-8859-1?Q?Iy6Jg4UF1N/59UQ916HT7wGh2wx4Khzow+rO+mlXFnR8aiFmoBXlJr/55/?=
 =?iso-8859-1?Q?aGxIfNsiya9TBEfAH8OZFkq1LcnZgOu06/aIJQUopGlzIhJlJWnPRku6Yw?=
 =?iso-8859-1?Q?f/esm5DzJ31iP26CQWUN5dwuO402ctwzBGv9dAslCcHAgFilCwHxbNy6I5?=
 =?iso-8859-1?Q?fyVslnUhdSF0Vh2J+hGknGfUmwltn04J4mYgV44zzsQz4R2uuO8Pk8wZQz?=
 =?iso-8859-1?Q?4V9PEzplH+Fe+QiJgLXXVPWJMaODPj107CNfw8jYZmaBMEaAwNJRU7FEue?=
 =?iso-8859-1?Q?oUmnHvvIHBcXl71+HITUcPp9K11UY/OJLqA6hk3EpanAXq9Iu2WQSkGEsG?=
 =?iso-8859-1?Q?tFZCC+i5yYLWieRjz62cMis/p2Zvcksp4u+8cfvoAO026VBsJRR84YMqC4?=
 =?iso-8859-1?Q?oVBBYjMVwOiJvlnxr90+FLol9AycUJcnxXUW+p4+3WypXQhlJEDQ3rwflI?=
 =?iso-8859-1?Q?2kecBtEpo0toc+RkkxtkqgjRPvFXqdvyqQ2SSOGhdWiXdelnCSn7qblYwi?=
 =?iso-8859-1?Q?Ci1L1Olx+DTWFKUWycbwCMPcgMEqvi+E59RPFWxaxCHRikKLpxNb9Lr+vF?=
 =?iso-8859-1?Q?GGqa7jBALNltuVUsnBFpT+w/q8jwVqCKd+ZzrTNMlvCIeXkZhphJAEdwLH?=
 =?iso-8859-1?Q?0iJT00gb/LJQZ3Ys9oHABSUzv4FSPEV2T15BzjT2n9lw1vZcD/APfLaGUT?=
 =?iso-8859-1?Q?i84oscmTAzFRK5vZxnAr4ebcweWlBYnIjB3U8aKqR8VFyYxNK6f3AF+mVQ?=
 =?iso-8859-1?Q?P1B88GRedz9XG/HkthkD4JVHpLRfu0KEMeKs9eE4ZM/VikWyLtZRbYCYMl?=
 =?iso-8859-1?Q?m/1Ct1Sksxy3PE4po3+Zqw43qE0Bkv877VKetqgFuVEcPwKwI+VyLtRvOV?=
 =?iso-8859-1?Q?fF6l0FqJ9b7FVtpS/gmYKhnvWjq6OiWR7zLKt1zlOuTrB89U6tiErzJVAL?=
 =?iso-8859-1?Q?qkVrGLHkzdA1rBxuIrkR19IBBpLI2ZO6EOKu2Vv7eSYS95BVdTiOgNPZKa?=
 =?iso-8859-1?Q?2L8b6nZ5DI4Zp9bVL/sBYBTwZcTyuMbVFMgSJIixLG+zT4xZdSC2ykgacw?=
 =?iso-8859-1?Q?i9IOrUFqA3fExjB+01JlNN5skcJb/2Mo/72MrSpN386J17IDWB7WQ+NnJt?=
 =?iso-8859-1?Q?OqyvfGiA7xZQCX18xkzL2rgbT/JrFZuy6uJL1+05rq4l6+Fgnmir7P6+ER?=
 =?iso-8859-1?Q?zqYb9BJPhynQBY+7fXkFOP4KHlFmD1QlfX+SeYkGLM2vtfrs9EQji+am3U?=
 =?iso-8859-1?Q?SKrOdtTL4bHeTwJdpJPnDthI8LgwGvyganHBf/GacgOSCtWFYQMv/DCzl2?=
 =?iso-8859-1?Q?ZEr5TQlc1lUE0fW3A6AXNnngStXASXFJA8piYpa9qdzlkmViJkgC44kjTR?=
 =?iso-8859-1?Q?+kECvPbOjsiuqYDSWBqgsPfPjnt4/rji2KDQWb6rHo7PKk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0b9936-4883-48ee-3744-08d9de926d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2022 17:04:33.4622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmoyEK0X1woFrJ3DKCzZOzJeBUFMDrtzsmDZUbtbFgI0+1iN1N5GEYGB2rTciujPTxRf9SRa1kUSVOyHHJTUFun99I6JzylJakKGUJQ6KA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3579

> I used the patch from the attachment, not the email. I was not happy=0A=
> with the indention levels and the useless brackets.=0A=
Ah sorry, I haven't noticed the double parentheses.=0A=
For the indentation, in order to respect the 80 line max size,=0A=
I never know how to format the test conditions. Is it 2 extra tabs to=0A=
differ from the execution code (1 extra tab)?=0A=
=0A=
Emmanuel=
