Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90058.outbound.protection.outlook.com [40.107.9.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65697168
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 08:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZeUFx4awxTdYMg1P2FS4qHSIDiUdfnQ4ZOigXCh8XCHGAz7zseemgW3Z7bA7biznbviYuYp/Gh2qfxzc7er/xSzBNzIbXTjRO+K8Ye0sMxmDZmIfZOoNHY/xDagiifAKRmiT5fJPb5w95X91OIakCvZB9KP5omKaElcmAchr/JYZFDvWxZsu9ff+iw7cJwd/YKb8yCPtUQvgIm+j2D30Ou3IaiSPKfYzlHmoD04FRUMtZbzAu6JvpFLNzYAFENqWJE7ytIImbEbKUw23d7/hmx6pwhty0ZrjdbwwSohY1NBUKoNNROqQ0XmxOpfDhOBq9v9KhH4TRkXGwhgwevUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHCL7HuEqJqEznXTZC+vaUi+bGMEeEELfH0QP5Fs+AY=;
 b=G89dwdxxVFa2gkfom/8lR58R7OxeGZ6Gditgfo0NuxKCRqcep0+dLMa+J678JXq6w4P9DH1mCCajkjYlKb18ghzeFFZwLGYqYAj2NgwefKvGSxS6uTCGv7v6j1xkvSsseQpssNb1djV3DTuhA3vPnGM1Q5BAvAAjO3zmOFfIxPXeGPbZZidIAf+kO+Fw8pxrPSuJ9eh2Lm0gOs4AM8pYRqQlikX+nv0hMM5F/Gfar6cO1vojS44zpLQLOQxXucqF+u7/fseHk9BLChm/2yjJHoKYYG4TWOFYX/+tCJVHebJyirTLWjzOwwAZ/pbt5bWVzWRZhBtkACATDJIXROTPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHCL7HuEqJqEznXTZC+vaUi+bGMEeEELfH0QP5Fs+AY=;
 b=UebHE3OUnWSDi3aGoBC7d1yUU3RVf6S8WtRb5ZIe4MDLmcRy8qiMGPT/3sYEg1XK0bcfwfZj3ktshUvX8vQ4GzW+cRVf29npARob8TwHLXgZRTeGJWhsXr90SMFPT13uNz2v2MI20SxvGAFxO/pC2XGbtOnlokBeRYO54JIuaoc=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1732.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Fri, 2 Jul 2021 08:05:36 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682%5]) with mapi id 15.20.4287.027; Fri, 2 Jul 2021
 08:05:36 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: apply_relevant_default_downgrade cleanup
Thread-Topic: [PATCH] service: apply_relevant_default_downgrade cleanup
Thread-Index: AQHXaDVATkruXajV7kO02p4ua5SYXqsvXemAgAADZ8Y=
Date: Fri, 2 Jul 2021 08:05:36 +0000
Message-ID:
 <MRZP264MB15442051C6A984DDBC180816931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB4794724A7C2ACD0A92E18F6193089@PR1PR02MB4794.eurprd02.prod.outlook.com>,<20210702075211.2oxu5tsvj33ly7og@beryllium.lan>
In-Reply-To: <20210702075211.2oxu5tsvj33ly7og@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [88.165.98.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df149e58-a39b-4b42-8316-08d93d302ccf
x-ms-traffictypediagnostic: MR1P264MB1732:
x-microsoft-antispam-prvs:
 <MR1P264MB173222466C081B84AC19C2C6931F9@MR1P264MB1732.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JeXjrd2FQTmb4l3fmawttmjmgQgtWS+9qBsxUXmlwzrSW+4evAMeskLnuTqEFyU/NV0MMh5afnNvxWqTAv5nac0K4CzG8QRboMJgICU1FsAUw1cJK2kDClgWszDuIe36IKIQHL0MggRfBzvuCSD+Jr5FlC6R9Jq/IW62WlC6tjxdHlBnJGBw+Uxijb5MCE+2kRVgbcrmyqxVdaeap9loC8K8/0O16WCtcgza7Fb4MimH3BuiMz31pm0SMLVQ4RVv1DUJ1GhmPj/BffJZyJMsqd+MnI4n/b9mwgJPiSzXa1INz915GKbrFl6pCueifSUTvzpJVxM5NeIoQ/zPyEBMV44+cPsJWtkZQcKVCIR1/LF/xi/5PDarQzVrmrJvVgh6AnwC6IhLTNTnnGgIPtwL18mtoqI+jbrl8peFLBXSQm9PWDaOmTyYyaYfZKQPyTwMSMNrvq48+0B6YLHfmxAC2vlA4m0RvEuh9jeKpo81XOtRNby9g28k/iacXsDagoAVJo2y/zyo8ZluoOVP5gIMmyqo8D5gD4tPoLzbCqJjIlaDw33c1Meu0F+XUdle5pJwjE9otbnAVAf8E1kud4Ys2ICgbC42ZVFA01F0l+iwwrZqKw1O5yqAR3gVtlOIdGFxkUA2Yuo5Qj4iN/T0f+JQMw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(558084003)(6506007)(5660300002)(4326008)(55016002)(9686003)(316002)(7696005)(6916009)(71200400001)(478600001)(33656002)(8936002)(8676002)(52536014)(26005)(86362001)(66476007)(76116006)(122000001)(2906002)(66946007)(64756008)(38100700002)(66446008)(66556008)(91956017)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Np1pKoqeQc6N7h500fa22KbunQK7pJvJ8gLT8V5cG7N9xYs7mYjqwO7M4a?=
 =?iso-8859-1?Q?2nGvvht9jZ3PkxHCE9uqpsh+GskmOEzd7sOqTuvDa8+RIJ5OEDgubINhF+?=
 =?iso-8859-1?Q?ir46E/c8S655Sg8z+yRHRTynbSRSe3xjB4Tg55hi9Y2fIq25wO+vtmB8B4?=
 =?iso-8859-1?Q?JyUsjctRcuBFZVIBoBVHI8rOR/g7tYOljyaDBhr/iWYgWNnNFK6VOTymvn?=
 =?iso-8859-1?Q?54Iugoxs9XHY/AlJo3kYRz/BvzfFlBQrZyCISpulkn4XU65Ks9Nlw0Zgyf?=
 =?iso-8859-1?Q?gXdPWblZEt/DLPA6DLocQb1WFVAOm12N3rz9joKNK51mGMHx//lJV4yB9S?=
 =?iso-8859-1?Q?I6pKTyiTF3prN2lG3gCN7YVDa4oNUemhVIj5eo1SE2V+te8CL7VVMusaK0?=
 =?iso-8859-1?Q?GVZIFVRK2RJx+LBHIUftT/XAU3S1nurQvAPgiouTpe4bOO+oA+z+hTNdM0?=
 =?iso-8859-1?Q?6jw59rkOR3fNl4+j5NfqKdZw0+Zy7JpEEfmTsKxLwe2JNaULAUHSem1UVb?=
 =?iso-8859-1?Q?lgCj5YkJnKzcz+tRJiuzwXwx2tRAok4g6bnhacKV5L2bJjNORUvmjINOwf?=
 =?iso-8859-1?Q?TcSuMeS5+wpEagFSJfWM3nHgRhcFba6hczKwB98w6hY6IBfReicy0J+Riy?=
 =?iso-8859-1?Q?egvlAX93FaPYLX0NT6UOBQ+g5o/jfeUlyHBJZ2ySV50q9Nk/MLM/CjysDB?=
 =?iso-8859-1?Q?foKcKcpUp+LybxNm/76VAXkyexkQKB6+0hWj3UfeU5au+bhLVFqF8Mc8Xd?=
 =?iso-8859-1?Q?lqnl6U76vOLLSw2VHnQI+8tuYJ3jw0aKe6QUVVNL8jsWhUoXzQgpHBH/YU?=
 =?iso-8859-1?Q?9BN9+fd0+DTsfVQyGYPFrUwyn181Zt9EBHqc16M/YxywLA7o8Papy9bRyZ?=
 =?iso-8859-1?Q?kVZGTp9oTmmUY/W7NIY3peUS2gcs9QgSSabTI+p1/Oojh0xm3w5vO+XvQ3?=
 =?iso-8859-1?Q?BiZzybSHIm1DmTK5GceV74+onI4aOQCI5fKg5ksvM5wtY/EXxsRMcgCuRc?=
 =?iso-8859-1?Q?iarFmAgBzbvvefZ3miYorQyZGtTBI8IMd/Ip9iIZITNxTFfwbzXCu4cn5M?=
 =?iso-8859-1?Q?MPDeHvUTaCtHoXBAfsPuLQQcsKRMtSrOFja4FITTB2n9Gxg15GV4P7W7V2?=
 =?iso-8859-1?Q?DqN9RCnaOhCMSVRwDs6lJYLyfe38w+kBkh6TdY35SZbz6R0d4qnrrrqKAe?=
 =?iso-8859-1?Q?Pg6ssnGXJXzZuQvub+hRhaFqixWpAqnTfEeWBcza9KpYb6GBhwbTPXBDk5?=
 =?iso-8859-1?Q?O4lcYvsuqm7s/IBfVZAJ2QnbOrUbX7HSHjsTcSYRgVI6DW8b3orbwKhT5y?=
 =?iso-8859-1?Q?hZ7I+aAdt33OD5yIO+FDfCqPFqn8ljjM9QZ+LFpNZwvpqyY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df149e58-a39b-4b42-8316-08d93d302ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 08:05:36.7833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZev+jcp8sdXVk4F3OQjmJE2HJ7VO+0zy2CR0TW9X5ebdVyQmH9GYsya67GJxUgeuUxCdawPeNF6H/AECJ0L26F5rfruaLLyWMifD1LuXr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1732

> Patch applied! Nice cleanup.=0A=
Great news, thank you Daniel.=
