Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120074.outbound.protection.outlook.com [40.107.12.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175C2568
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 09:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLRnWPPocHUEHYdNFsElGJDycJOVaNAxutjPY8c9pqLJWhz8z0cE1p/sL3wuFOUBeLK+ZuX+g0Jj9dDdOnuqK76+x3NQxk38vDBzzMapUapq3o/J8kAoa36J+SjCQzHSJnGlFESxh2Z2WNTNcUK7x+j+mR3oEQSx2eAk8zm8TnC3BXWbXzGB58XCrJQGWvTgRN8DC5nuZ1DopvUA4DsvrjkX4+r/pZ9mSPopZVIFK89j3lN+Oh8dGlFJ9ZdAu0VOKU85rIXEtf3LY72vT9F9AHkNlUhJV2G1FUuVzM3hHttVC1ljxSBb0pslRNG4TXnLHOxvL+DlKiNwe8rs85KByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9kD/HDCkhmDw2CYdQ1i8ZdMv9wXP1Fi+uYs7A4zCQ4=;
 b=k3q94H1T4LQUN3dVpwAUJ9rcpWs3Illxmxm8IFZXztAOjf51UrAXIRmV8Ypm6s10rqJqvruNcVb2i4zS02GpZlH9Y5DWP2QgME2V3SHn3f3+F6eSSXPinJ8rTEhCanzAgzs5gp4eg/df3jY6oO5pOF4fTIRpOgpw9YPpb6t0Skoax5Ytdp4312D2Be7WA6vDZ2lCevAKK32RWpat1aKm1MXqtH39UvDpdeb1F2NguYTPWlFHOMEEnCZh00YWlDw20mS67Oxc+BGdcxWL9u/c/e5Yv5U4GCjT1K4pyxGInauDuxZXp0EHbE8pHd0IfjK1nU2q/93ArTsYyVi70ih3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9kD/HDCkhmDw2CYdQ1i8ZdMv9wXP1Fi+uYs7A4zCQ4=;
 b=wEWZDwALcRazRjt4LTR/s0MKwHzLmFU5W4+n4Fdg3pcZrX40MsT04d5M7GRDwj2Yb2I/xe8vg9wmej3ScQwnwpx54KISLaBYTnuG1sj1wuBfvxcsTw5eWgN2TyYnucggHucP5sA7BSGLK00n/gQXj6M6s/x7e21cp1m7NfqB4uk=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR0P264MB3434.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:149::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Mon, 21 Feb 2022 09:10:10 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 09:10:09 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Denis Kenzior <denkenz@gmail.com>, Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH v2] iwd: Always disconnect connection completely
Thread-Topic: [PATCH v2] iwd: Always disconnect connection completely
Thread-Index:
 AQHYEP/731R9+FXajUGI5zk313sJNKxx3h9IgAGhxwCAAAOvMoAADyEAgABbfgCAFH1RHIAVdbNZ
Date: Mon, 21 Feb 2022 09:10:09 +0000
Message-ID:
 <MRZP264MB1544C7DAF7A0AA3942D9FC1C933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
 <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To:
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 321ad94a-3b69-ea06-4fef-6f55c04734da
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3a7f452-7f75-4b7d-33c7-08d9f519f5fa
x-ms-traffictypediagnostic: PR0P264MB3434:EE_
x-microsoft-antispam-prvs:
 <PR0P264MB34346B51E64778B0FFEB04F6933A9@PR0P264MB3434.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YYi0dDvWlkNoqjK5stXkFlFAWUPO85YrCq0JxFeYcs/AvGO5PXGD7U46Miqa6OLKNhdjIikV5ttK7W11rwqWhXQfd7RBzPALJawuxg8U2xjXeA9fBSY3lS7S6sjus8jW1yBIOXEMSNIrHCNMDKzUGXl1vz6htzBH1MGzr7QJIONZqsOzlrM1ouRMS1jVgl/lQlHqxNkLSEYwxOGKnMquKbZMKxau36hrJR9d4RzTWRdq94e1szafN/pU79BmbWj+DwSeogIxACZoG0IjInJ9iRGZJjK5dah88kGkkKhZ31wNQ7ya6tHGsD4yhYDaCBKpY9EcVC09YBoAXLHkdrMIlNPySK8AwRb14db2N58ioag3Jy92biweZ96BsL38ItAitoDFcVr3YRXR6Chg23jY9E4Dq5W8Fb0+5NYdeXhDKay0wScMnUlRO4qzfzz6do9XywjW6iGjOccsBrMP0BeBviq/XAYZIDTnrZPOWpGDGJ3KuV85/xtRtOzpnDwjIM1p9SVeW3Azf+yF6ISP1SMI32usDaI7y99G5GHypSuz1srMudHi9E2q68bH49yOxNOL8ny6bsZD/LvC3oMMO81Uawmpu+79YV+uribWuQbxP/2iCHwxjeu0BUSZ/xrycNbFJmGyOOxbzt7wAckzPY/FneLMWlPgR6vBJqw2BsiAGTf6GHGWYNu97Ps8+LCOqQCs+MCWi5/NdX3zcCdmZno/cw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(558084003)(110136005)(66446008)(64756008)(66946007)(86362001)(91956017)(4326008)(8676002)(55016003)(316002)(33656002)(66556008)(122000001)(76116006)(186003)(66476007)(71200400001)(508600001)(5660300002)(9686003)(7696005)(6506007)(52536014)(2906002)(38070700005)(38100700002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Is3rx469Njmkk1OxmyXNLHdCBMuDyFARPwNX48ne1Txc34BkTV/Xqq1ztV?=
 =?iso-8859-1?Q?jbs4NUtnLy2IJV1J1/2EFmOuMbGYKWS9WaI9Zj1VgbzRf8iezooDfW8Sde?=
 =?iso-8859-1?Q?fymGThawl7b8PvTqwETDUB65ymbB3ta/j6WfqrSBkSL8JnQLZ+c1fN+e1c?=
 =?iso-8859-1?Q?wbgfxcnGM9laa5LeZgIZK94aUNjd341shqOVxgaU0BMC17luAMLOsvCeFi?=
 =?iso-8859-1?Q?SdBBW/G78cuzCRSs7KsBLYtABUGyW5tWfAKqcjmfCeaE91Pa580sYmFmS6?=
 =?iso-8859-1?Q?m7nKf4ZMdbv1NYMW8gAmB5xCuVXJTRp/cJsDi4CmJ5BL1o4iD+DMIRjMu+?=
 =?iso-8859-1?Q?iWc//F1Beoux4gFZ3Y8RXBkkk9FruzLModxmeJdfllEH3g6rXw7tggLWsh?=
 =?iso-8859-1?Q?FrkyD5mRehMxFvk2vU+sdGGPKsJyFFM9sr1FcZseZnFDzXhsCvrGoXchte?=
 =?iso-8859-1?Q?3FQuIw7jq5kG999yIpfpJIjc833ErSRhQf+NJfuaF4SCP31eK39wP0RxOs?=
 =?iso-8859-1?Q?onbBG67rQBTL6+bK6aItOZdMKgesGteNUmFGWLvigsWpgdHsj665yjF4PF?=
 =?iso-8859-1?Q?S9b+jBewiGHfrvWrrsgXoSnImQXOALpKz6evE0wiGeJcejqB1MEIQeVq7P?=
 =?iso-8859-1?Q?EwmJtrGuDhiOUptkbx/TD9byHVlh6ucOqbr9UCNNg6oC9E1OuAxnlMvG4I?=
 =?iso-8859-1?Q?wYyhnFFevH21+AQiWVUxnhDe3d4+lZV66pyiwx6mNly7pR3rjRUi+hh+BY?=
 =?iso-8859-1?Q?rXO+riCcFD8WfwT5RjbpbIctnUgP2VOKqFaBUeE43/lKABhJG0ib+fKZ69?=
 =?iso-8859-1?Q?54tKhJ1u1X+yo4C7O5sJ+FWatetEiMmeKCsV1NOIWqybWxraSQFJO0qdzt?=
 =?iso-8859-1?Q?LYgrmP4aj0LGZF3o7dHmSAEy+qM0Aaz4HUjgsE876M2VlyQIT7OixUTAO1?=
 =?iso-8859-1?Q?HU7r1K/ZwUKYSmU7eZUyW/i3Ri8pYN/Z+jFHo6UEO2j7VWFGGrGqe4IaRd?=
 =?iso-8859-1?Q?aYwtV6CSjb54mS7WBsy1M0CA28186MDAC0YmZfsrPX1JC+zAcbeUPXjtOU?=
 =?iso-8859-1?Q?zk1Jm1PncSEqo43DAW3lSH7utLq/Dp4oFHToTWhj9xTf+VkBjuMtzBysf1?=
 =?iso-8859-1?Q?nWvlKArSSxMeFK4MC7EiLrekUEDRiiONb2FAMklIl9ImDJJoqp/eN5oqym?=
 =?iso-8859-1?Q?JYX0kiRiHjAlD5sOcOkEPtnNqGHRWpnFO5LAWxm62uEG/A8jeTdPUiIhXW?=
 =?iso-8859-1?Q?w12OoV7hGhSsYbS6lKxqgxO/N1R4NLeRycLdbMUIEicCULa97K6MTZXuj6?=
 =?iso-8859-1?Q?VvaYQdszV4Op50HzHHbN7UdPdVXqDKo97pBh5o3Fwb6Y244b+QQGFe0PAQ?=
 =?iso-8859-1?Q?0K+4un2vnkP/RifmdylP8eZNGWHAXzPFZR6Pgc67o1UmGh/JEz8kY3yjUP?=
 =?iso-8859-1?Q?5PTLIanWKXsVx08R6VYVv3UmNZGq4TtGAzreg5Z5Pi6fAx9qmModqVfghl?=
 =?iso-8859-1?Q?vqN+6PAO94XJzomhoKlx9pD4gJf2fd1AVhu4VSxLW6LZlZfPs6kJgozRJi?=
 =?iso-8859-1?Q?shWjr4ERNCSlgm0mO4exv2y8u7BNlLQIrEXKhmSMjCQ/9ePBGSCpN+hdSv?=
 =?iso-8859-1?Q?6NKONfLMcai/N0XSOPYptuHwNaYun+D6s9I/VuvmTjOXKRGj0fceR4z9kk?=
 =?iso-8859-1?Q?tdA3hFlOK8OSemdjyFZbzJhuk7CCdxNG8e/z/GI8jfy+scwknF3V7Ou2YH?=
 =?iso-8859-1?Q?bk94WGGnbI+jVB0NEFHVpf8R4wtAPLRKXANKT3WufgbCD4+2n06rJIcVJ6?=
 =?iso-8859-1?Q?MPAvAaGphg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a7f452-7f75-4b7d-33c7-08d9f519f5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 09:10:09.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCx8TNBDvfsovLApFGA6jcf0m+wosBxMfKfzq62+rQdMa0u/LfXtpehxawXE0yGheyE72krQg4Eae2TS0rVbqk32S1+GG2354OBM5bxoeoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3434

Hi Daniel,=0A=
=0A=
Do you need more information about this subject?=0A=
I have an important patch on iwd networks removal,=0A=
based on this patch. Do you prefer I propose this one first?=0A=
=0A=
Best regards,=0A=
=0A=
Emmanuel=
