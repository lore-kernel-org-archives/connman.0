Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120041.outbound.protection.outlook.com [40.107.12.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A23FC0
	for <connman@lists.linux.dev>; Wed, 25 Aug 2021 12:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAEtTgNAY/XDPkxKz7yMi4IMCMxw0a/dIiikAmQEdKVuh5m9ra4IlNUevK7+eyojd66ZgLdtgPmjljj76YlbCprObYAGS5PAmUeLYFUQTNXgzUemZGhtk//3VkUb9jABc+ziVyBVIy5u9CCL/tAE/pP9pnCwk08ZRNh/ESHAaM5uavnrmXVN33CzsHrbfI2q/1J10ge42wCxlCEEayShFMj28XjhUrap2EH1QJCGQxuuY7nMk62KRdjlAcnf4e62aFa+Z8viiYdBHNuY1QLpwWaXyyRAqOXBwIUWKoLX0zj28lsqyoU/rHYsTsjJmQ0QKIajS5jfVkq1U8O2CC2reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV/v0JFcs5YLFLZiCx753kFweY7SbOcRy0Q6Aw+98gw=;
 b=aV5zOxvBBXtTE6XYmpJxAq+o7mTN2SXDzWI0ukS7Xfyl46G8nQ3Pl6fGxBehzfnG9WNBdn05qZDYiAU1y62xmfICOZ6Xi6VlaPK0ymJeDMRYO320SLhFcPnAkLE36dA91ddE0TnmlA/Fq0jP+KHOw/lE5J5FyppKdOJTFl9jzNN6I0UOUKAUGVdKHZ17NcsttsbaZltuuEAjOwDcpS9xN3p26PVvJAXdqeVHiXLrPwg/HVl5LcK57cNRozP6jSXjfxtKo8vZ6GnUzyH2wF3/Zyk4yr33xTkEdsUcImMU8m8mn3FhbqaJrm9U+xodNXKnTRX1VIuxGLfGcQeOGs+XyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV/v0JFcs5YLFLZiCx753kFweY7SbOcRy0Q6Aw+98gw=;
 b=q13ElaHQ6P/MAQ9utjxT9DLZdSvuiqeoqF4lmHVG1v+50pTswXFzOD8sEKYqy7hWou+t29krCk/d32Wgbf2ixUQsXj3PEduM8lpN7dmgqcZfiLWAoJ8IBmhRWbzi5QF//YE61j+FqbyV3Md2zEOTbGSjYPJOvuK4Rk0Dps0OSK8=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB3154.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Wed, 25 Aug 2021 12:45:38 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d7f:ca70:4ec:896b]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d7f:ca70:4ec:896b%6]) with mapi id 15.20.4436.026; Wed, 25 Aug 2021
 12:45:38 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] wispr: Add online check url config options
Thread-Topic: [PATCH] wispr: Add online check url config options
Thread-Index: AQHXYeTK6zVrkCfjz0+UXmRbnjdQQKsVCMengG+QtO8=
Date: Wed, 25 Aug 2021 12:45:38 +0000
Message-ID:
 <MRZP264MB1544E68164633E412919730493C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB479412B2989FCCF93E4AE58F93309@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <PR1PR02MB4794EE1A5F2F997AF8032BB893309@PR1PR02MB4794.eurprd02.prod.outlook.com>
In-Reply-To:
 <PR1PR02MB4794EE1A5F2F997AF8032BB893309@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6804e6c8-73bb-4365-ad67-08d967c63d6c
x-ms-traffictypediagnostic: MR1P264MB3154:
x-microsoft-antispam-prvs:
 <MR1P264MB3154B969D8AF6CACD6F1E3D993C69@MR1P264MB3154.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AZEN12WQ0P4ZkVyetdu2cq3lJcdkCV9LGco6fjznA4Z0NBSjBSfzJ6dTC5V2hRVGJgrgUn6pnI2VZvN3k6R57WrmT50N9JTEoIu9EYzk4Sfxen9S14ZRtLSmJGysjJWcEjIH+tpyIH6chFC1qa6mILiGTzNbRTXk2QBZK1r85YcXa2LkIkSUjbQgkxnE+pDWXZwbmz/tgbmXFIvFOv8mraXmIbqm4orCZTNKmF1nJ2b0k/mSwtrnc+yd5M6Jxic2eJwI5QkDRNTAT4FufO37v2m7bZAOFmCdWTDAswu3wBymTrbbVHCV4dzPjJn1i8d1BO723T8YeoNiL7diDf+HFmXyv+lR7l8VyFF7LNE1bgBaIgf2c976lsiW7aHXj26485Bm59Y//zuuj5xGXqkDrXttIWlZS+L4vSES2P/g+raFgKJF9K7AZ2axDUqKdwQF/5g2Wy8DR7z8hA99fewPzNmupyH5/+Ct32ic52XMqn/LRQxiLbVAAyiucJjgNZlKs0p0/3nWtDZXTX8oPaeQu32Rk2KNrv2o4R090pzJ0j6wl8RrDaBhnAtSuzYIWclZBUWzaruGwgA6DE7avNLiTkzPZUS1FW8oZGR0a7kdWytt5Hqn0RbCwAeBUmb77D8pIUq2lx5zgmyndmgsufgL26Wn9xa4PDZWIyABA+Fc5M7P7+weorHn1YJUOBdU2VwyMlQPo7Td3KahWyZW9PSVQw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(26005)(76116006)(91956017)(7696005)(8676002)(66946007)(2906002)(6506007)(478600001)(8936002)(52536014)(5660300002)(6916009)(38100700002)(71200400001)(9686003)(558084003)(66476007)(66446008)(186003)(64756008)(66556008)(316002)(38070700005)(55016002)(86362001)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3HpSQWtAoWEh9sn3Q54rk4Br213qixiqF4exZCTS+EVxUTleHNEgAgMHH1?=
 =?iso-8859-1?Q?pTON0SVKUbQ4KpVZ6bzyjmXNuHwpKBDcwIHv4JYiNdPxJfyQ1QuL3WwQxM?=
 =?iso-8859-1?Q?QmwCHvoW9Hnjof5hYoZWgzQesT1pcFA+vhr+7JW5MfKit9hiPBiuZCJHVM?=
 =?iso-8859-1?Q?HaRn1eay0t5qvSc3h0nf4QANsGQ5Jnfjz/LILa53DA+JhOd4b1AjnRggV7?=
 =?iso-8859-1?Q?vP4smYszQB1b49TuVf8u32NJ2qb88R/9fuE2SKgo+Y0US/ZxV9Tr/56Iki?=
 =?iso-8859-1?Q?8h6te4JJFbI/yQDktIzKixYwnwwB10sOC6hyreCO5qD4hBskHrctaEKKwW?=
 =?iso-8859-1?Q?MRB5FA5g1FR78HK+kLDJY6fCCeJtJV+wGR8rROcQVGAidGZcgzgTGA8Gmk?=
 =?iso-8859-1?Q?p/YTsb0tHya4Q0arWyq1dW/8g4X2JcVbw+GBoLnHwWNlKbBaYGreAUt6fE?=
 =?iso-8859-1?Q?9ybWWBKLIN0Z38GYapCgq/4zvPw579iK7eS7Ax91Y3t1IpDutECw5YjU+i?=
 =?iso-8859-1?Q?WW4oNxzA7WshPCpeq/sJv3IzR9s6pPh8rlBWntahYOmZn/YYPnT2QAcew4?=
 =?iso-8859-1?Q?DlcF/GpwZPWA8ea8X7E296RgwLXjTMcWCHaMNFX47OoZLvA+AHBNEZboDI?=
 =?iso-8859-1?Q?pWu0RrCN6p+Ad7yaZJaWmRmrKj/SY4pKY1YzKmT3iIqA2T8LH0twOQpXEm?=
 =?iso-8859-1?Q?EXqR3QwXePRhZ0WQLrPdjMKvIwmdJwmb9vcSMec4AMLrVxtkJ+ECsgdyY+?=
 =?iso-8859-1?Q?esfzZgPNlqSJEA9dS46SMzoRxyQPkXFdDcd7I5ETOVPr9ouxajYxvT2KMx?=
 =?iso-8859-1?Q?ZPINHSa2MKysfPxgjhmTU3F0I0gT2P3qKI9Mzm0DTOtq+1D+86l0Qp9zOQ?=
 =?iso-8859-1?Q?RlS2ekWQQ019KOLvvhevi9L2gd4hsuxs4goTB973SX7aqXT4yoavh8Vj2O?=
 =?iso-8859-1?Q?FYSC6I38kcORh667oeLaxuEw9aXZL13Zwb4kvqi3c6Jw2ZDxWA+b7A0/XR?=
 =?iso-8859-1?Q?jwdNwrXQmUxn73Q1HOvfeMCmR1p8g0+MdghPdO1N8mK8N82FOQnIOAMX9O?=
 =?iso-8859-1?Q?PSzhbPMghupl/C9sHZD9rFM8UvMPaEkVdvqoc9hOdE0WBKoNXDuAlDv09u?=
 =?iso-8859-1?Q?51wsduJ9HjxhZj9IvylZqF39LQ1ZytFoeSeZluz+sjL23qBU1JVWSKm2hl?=
 =?iso-8859-1?Q?UNGhIT1lsL3O+Jx+hZuJQCHrRQ8AQfEmgHpLe0Vw3Ust3Y2qZcA8WKFUGa?=
 =?iso-8859-1?Q?mfyaCRirdvDDsrDms370xfCD51JgTSx6MlzVBEaIK2qkJLY3cG0XQbd2TH?=
 =?iso-8859-1?Q?w0nD16PpA1mrsneJqikkghyJ74UGhmqo0+OhufMqpzPYIJwfphzJHRk/5C?=
 =?iso-8859-1?Q?rLuHsQpF4w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6804e6c8-73bb-4365-ad67-08d967c63d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 12:45:38.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBMNWeRTv61GNbQrnFQuOYXkt/UHcXIZWIF2hwvRiZlvUIlO7N8NNH29lvE4K2CsOOcbPZWQJIlNdYQLDStfhrVTb7d12rHa7Vu3xS2E/Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3154

Hi,=0A=
=0A=
Was there any progress on this subject? Does it still require some clarific=
ation?=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
