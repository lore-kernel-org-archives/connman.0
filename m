Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120051.outbound.protection.outlook.com [40.107.12.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAF70
	for <connman@lists.linux.dev>; Mon, 26 Jul 2021 07:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9OEhO8nRXBvwHAKZjPiY+0uz/WCCkBDmesYDdj7/4/k5WIzJcdxWirsTui+NbChr2EG2DtqX5eSZS+79H0zvv+1w0UPS7YZpC2zxZ8x2YWXHOjfTzRJ4nXvh6ug/YNLQT3s4OnvroWxo/kJRwLzA9o3+W8TR8WU0d8fu0UUNPeyzgKVQXZZslwJCaKpq7XnOZbygjgb9jXL985OYkicSMuiee/RX7v7Pg35Jr+TRX/oVC0gMGMnNkvv7Uc/HpDkVkLArLlgQH65e6lj9wq13mYRlwmBJwFNN4mmTPVwyix8FNklMd2FmEMaevxKkXJufoM6rLU1h0w334vaXkwPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T6gXHox6x1ZxvzEK8Uj5vkk7Il1NFe6+6N46cc0ogU=;
 b=SMPy+VY7KTH5upjjo/SxbR7cSQqvXfe/uT5kTMwNtA42SBwIVwJVJWsAEH8Uhd5mFE15WKcWoL0hY5To/WmTFdi6lvIVr9/QEXycJBDCqtgV3Gtun8OCwHLoHodBwKRmXqGWtZ8diPJBrWLLk8nVskuruck/FAnAqEVmfdYMKSLDakzLzCeSWB/x3xGekt3c2XyVwc+JR4l0CvLpUhlqBWSiwpRGOlaFOXcmheCgqGqcl7ssXZXTS3ABPQzLEQ4Lra5C7+tPt4HM9x225ktFD7jrsbyBUo4Awb0Py3Zz0/+q2EDbBqRntRSPz4Pdb+zEPOqcO3gH6iPGln9wPriaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T6gXHox6x1ZxvzEK8Uj5vkk7Il1NFe6+6N46cc0ogU=;
 b=QssS0Bp210Nug+WWrqPqrgKmmSUfFzrJC+7F3Z5bFlPPyvlGQzXYttiRm3NEg6UYtG5h7tsEl/YrADnW05+hs+ODCUsFzGZ4oY3b+mGdfRTEJT9Dd7nN7tXRXqRGtFCgv7bJ4gq5QCLUBoqSl7BxSZ9sjI7/PVj3YUm6uZqK5Pk=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1843.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.28; Mon, 26 Jul 2021 07:52:02 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682%5]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 07:52:02 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: service_update_preferred_order cleanup
Thread-Topic: [PATCH] service: service_update_preferred_order cleanup
Thread-Index: AQHXfHxclevzH83B+0aj5OadKVoo/KtLyJoAgAACqeGACRnVgIAABnH4
Date: Mon, 26 Jul 2021 07:52:02 +0000
Message-ID:
 <MRZP264MB154430044B03961ACEC6373B93E89@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544B944E70E53B4B1A9287693E19@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210720121428.p3t54ne3emuxz3bl@beryllium.lan>
 <MRZP264MB15449923E85D932705598E8F93E29@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>,<20210726072247.q6ri36ovkrwiyua2@beryllium.lan>
In-Reply-To: <20210726072247.q6ri36ovkrwiyua2@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 693eda85-1c75-4734-8a21-08d9500a4125
x-ms-traffictypediagnostic: MR1P264MB1843:
x-microsoft-antispam-prvs:
 <MR1P264MB184350023F54DA97121248B993E89@MR1P264MB1843.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VjExMsZHKk/KvTQzAJqB8ACta8dYYPcZExkolYVihzgZLYQUTDfycHW+/F8nAKSJwxJYDyRQ0FCMWtxoN3gM64WFO2x5kaHBmVZZlW0e9z8Nm1k/heCazHYZLMWRpZUju1fvOKzi1Tl/5fDrDKmcqzKjjDrhae1ePcZSaMDLLokEcIUPjpKcuCOTMqFSWy9Iy+7y8Xj/hWD9P0Mb0iUaAtl9ORYdXTqYsFxXeaUCdb7mkitwZmXloDIDYidF4HqkaITv5TS1fCUPp2OblmaEBI1lHK1pw6mVsia2Fy1uQR4dnLum6oscDI89JN9ZOg1eRHNf+ZcCgMGZrxQ4xMu5ZBssWgcAqeIHY0FQwDVrFuqOzv6g9WJ1taWODbRKYd9vOwqPpd+AkS+dXJVwoa4clK0f/PET5ruKM3DM/4iJHZKs2OrEsRAQ4ckGY/HQWFmVFnHjYhDzcpxq8EH6C7Q86q7Os2ZIAUW+kuA6+uQfhOLyvq8uInBkXk2xN0dgC9navGKRacU2pJdxX3wAYQye6M7wxrqCv2kVMkYDoIpSA6lfAHaJSUOwvfr1OBx5K1G3HNrhNtlcMkoQ9gVcy5xR1EKaPCtFCjc38PRZweOVTO0XUJEn3Nwc4d2CpKwQSB/zjgkTtqclTpypMsmkiF0vB2CckoAJ/kmV3arAYvw6GYeNKmkojTUQqPSE68Mv4AsNhtEAx3T5gmmiw7VWhKvyig==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39850400004)(8676002)(186003)(122000001)(316002)(5660300002)(7696005)(8936002)(86362001)(38100700002)(2906002)(4326008)(52536014)(6916009)(6506007)(55016002)(91956017)(66446008)(66946007)(66476007)(66556008)(64756008)(26005)(76116006)(33656002)(9686003)(558084003)(478600001)(71200400001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eeJhb3pnvqOB5ZTgMNEVm8eKLHdL2qPTS5dj+w93I3urGF0puPiWCNQOsn?=
 =?iso-8859-1?Q?V2R4enF6xFY+tzdfY7fPHaMjMNQUCa051pIg1WVdIBmm66yUdBS7cmaQL8?=
 =?iso-8859-1?Q?5BIipl+ERf9ruTDRxEpWNydiD3LjNn2jEiu/tkMpeNWJKq4FiNwkBRHcar?=
 =?iso-8859-1?Q?3OlmU/zhawyIIAaOUJZdUurHzhw6JSHLXEvu7u0Y2DTUdAPwHx2q70719m?=
 =?iso-8859-1?Q?slMSGJChJOnGbMy34IYojF6jzq7gfDzdJNx7s5RaOqYLaH6ZBUQIEKnC3X?=
 =?iso-8859-1?Q?BHU6le3lEz8qkICT4cxqonCCEv1fq37CZf0N+/rM7ibFCJngrY06hGr+5w?=
 =?iso-8859-1?Q?3yS+dCSNeLxUIIxRc457sr4kpl4/FTgnmqaAIb1Xi51ycEPXV1oJwcyOIg?=
 =?iso-8859-1?Q?/XMXvlPQ0/NIMQFVFM7bO+7Q2TToUqSnaDPknAJowi7RDPCDZBK8wP1txJ?=
 =?iso-8859-1?Q?Q68tsshA0Gc8bG+htDGpYYLWkneL6Oesoe0EkGOnfwxv+YAMGRpOLIdHwY?=
 =?iso-8859-1?Q?ePBE0IzHQJEjykwQv4h0kUwv8ZkRAb7JeLeSHPG3KS3aHWRIQTcCUd1pub?=
 =?iso-8859-1?Q?rLcnTNbSsRMY9grtwf+ATQBWHu6uUZpzeS9LoQePYiG0vJ1+64DrxElhrQ?=
 =?iso-8859-1?Q?HBay85T/qIKM1j3kUVUVaJEtG1JK1yfp7k2e9PdgDLk3GG4vl9wZCj5064?=
 =?iso-8859-1?Q?3ZDBTdupX0CmrNnXqw8s4lnkoRgaPD+/ff9anMa8VaOmnyU50FKrImGn/t?=
 =?iso-8859-1?Q?BXPPHY9SLx+Wg95a2fWXEJinv8QlqAakDkOW0oSabS+aktWOCsZuVL+Q3e?=
 =?iso-8859-1?Q?9qUhQmL+DdcPKXCXIkdjcfAdnkCDqVmhH9nmaFarGRb5M1dEwrEYFoA+XP?=
 =?iso-8859-1?Q?IB4Rnk5ADsJEqGLtQGBtwOa+oKenMpOyOElxMQ/5yHkzzCDEDEakU7hBT9?=
 =?iso-8859-1?Q?fQo86kYyULyvJaJHv5O9KCWfHpofX87PjI+emdguzfkIjagp2CI5ty811R?=
 =?iso-8859-1?Q?nrfSD6ZNOeOg1sZW/2klqC+0MaHfVsazWNWgNbngei6WEgJKxPNPO+JzRY?=
 =?iso-8859-1?Q?oSvBD3SvrtH/bHhCdCrMDw92NRzOXZk9o9GD6dRlh8fWnWl60V3U8G9cAI?=
 =?iso-8859-1?Q?6YWWOM2fvMjZTIKPiCD+eqtitmrjyU77CoKCUAwjXgEUWZEKpwtjS95gSp?=
 =?iso-8859-1?Q?ojB4J6boBQYODAbo96tVHenvoggmKhTYRcP5W6xyO7jkIGfRLnYtYgGt1Z?=
 =?iso-8859-1?Q?0IrIwmw8/jPx6XCckenSFO8dh6QQUNlgLDmH1PwqZgl8aEPsKTinC5GTPq?=
 =?iso-8859-1?Q?wfpNVQpZu6WiVO0tOlUkPmkB952mrhbGCdUL8cjRVs0mY9E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 693eda85-1c75-4734-8a21-08d9500a4125
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 07:52:02.1136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5O7MCWTSaRcDgPJN5P0XcLAH0WAp3+kSxkr5MhcsH+TFQoFmUpqtFq0dubOEEMxxfpf44rsHJ4KRqeSiD2DfIWqSi+gRLYkOFmbiIIkp64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1843

> Ah, right. I'll apply the patch.=0A=
Great news, thank you Daniel.=0A=
=0A=
> Thanks. A few days holiday was really necessary. Though I am still=0A=
> pretty sluggish response time. Sorry about that.=0A=
Indeed, this is important to slow down, moreover for those special times.=
=0A=
=0A=
Emmanuel=
