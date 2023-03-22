Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2084.outbound.protection.outlook.com [40.107.9.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837A6FAA
	for <connman@lists.linux.dev>; Wed, 22 Mar 2023 14:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3xXKpUGAxF7Lt8TTXvpmTFaLgX8mKxFX9ooQfiwTbY8QA9e7RNEU261S6BaAAApkIff/yya24JaEUhU6FzfD/tyDayzWjos9RVrYR84psHwm6pqsYrLG9ODKZ+I+pWj86VKB6Zrg2sQwFEGDlEjqnDTZntbWqaP0jYPirOiZrTahBpkWY+oa7Y4pSgWOM+leuyaEim3lbklR4/Y3TnYL+NH5QlInPq0Llhd2NWM3bJXWhvr/HhqQEmPr/W+YEg7k/dN65IWOeL1eb4hkoC+ENUTnIgbMc/FK3tlkFoeRUt1H5ImZGdxi1n49xABO5pIdeNS4eQEVpPjrC/Ao5MJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOdE7cYboNgfUUnp9VniPh95JohBtqYIgeOOn7t+AO8=;
 b=LDcNvLB3UGaSiiKLViNBSN5bi0H2hEElDW87+olvDsd7ZbMZnr2ISne2r9myjQXGDOz+ZukuDf7uuyXQkKe6qWJUltfXJH0z/D9C9OSK5bGa8h2wtuji12lZL1Kk4uIQTyrHZ1r7CKuaxdCoGWjaIwxHdnlmm8WBgiLu0fDqGbbXX2LD7L77ZYGKg+OeUVinnlgfx40Z1vJbdYaHAYWygU3TubFsRnG6vZ4QVXGInaBc57SNhbbQVel8xc7acMJoCDfjwLbJ9hvVjWvUUWTLgyxm4zQ3gDLDz08myw1+v8gh/Hy1dGKT9ikxjhRjjKn9TCjc2j9t2229QFyMUYg61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOdE7cYboNgfUUnp9VniPh95JohBtqYIgeOOn7t+AO8=;
 b=bTDPACaxZmebQzcIKScgjvpzJB9RBj+I+f+ue2Pt5tSt0oaQvrWHQ4lLeoLhUxihJbbAtalANLjllbJSbmuMfMpMhGPe8pnBUTh8Nt++PPiTyKsG1kxzQmj2cTnr4qTcRdWKTomXH+1CX8zOeX3jXrFN/qn5vjPUr1xn9Q0H27U=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB3044.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 14:14:07 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6d79:b93c:b64:95ed]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6d79:b93c:b64:95ed%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:14:07 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix hidden service with wrong passphrase
Thread-Topic: [PATCH] service: Fix hidden service with wrong passphrase
Thread-Index: AQHZSs9pXH19TjmI8kerwyJNS+e/Dq8G+xKX
Date: Wed, 22 Mar 2023 14:14:07 +0000
Message-ID:
 <MRZP264MB1544DDBC2971A409B203D51D93869@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB154400DDFBFE8E6BE89E250193AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To:
 <MRZP264MB154400DDFBFE8E6BE89E250193AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB1544:EE_|MR1P264MB3044:EE_
x-ms-office365-filtering-correlation-id: 548bae2b-59d5-4564-08a6-08db2adfb356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Vww3cQY8k0WXrA/Ttq99+8K/9E8ztst/E+SfUEw6xFin4wS8Q/UippbJGh9SobpF0c74mAT6JMoJXH0JjEJ3Z3AvpFjdC7oVgWTEyvSGeJpEGCufVyGe+9+xFbMedITKZl6ivLIaOSHGRtFvupVr12eXq7Ubpci0vtc4dwDAmxPIKhdBrK82leD3czY1LayhskyySyU8ZcOkoKpScVnbE8nxCTkK8+BR0l3DCoalCv/bW7bdfqfUKwqeRmpoB7V9mVnq8IYw5eWBBLRJy4StcaVt2gFKImYt+A2PoCD3/L7sImRvZQMKr1tb+mPRR1beZHmp+wrK3sORtvBAW+H6PLyVnCbWx1kA4ev2Vcmwgp6wMKre9Hnr86et4t7YCKvijXRWS9S1uE4j2CNVuGZScNISoWhd64uCXvqkwHVOo4x4VQGKO/jfLWLlI9SIyk/4/Zp5PzfK/62tyvqmtp2OV/5kqR2I7AVZij0o/auuao2F3KooV6U6vYh9iKs5lrrJohWQNtwBN80yZPlGiGzz4MEggDPGWC54HoJBCAEXPG66egsKGdQ0qWRXJ5V1efn2zftuNsIcFptFPnrzRXlp9wkJb7zvef897JN1R0QVa0IorcB/M7b9l5Eg0lGBgfcJDis9bHsuOqZGE9ex9M7/es0U6BisV+Fahvtbf7A5h+KD4aUMJedwYvnyULQLDbrmWeeCVGuNsVy0NvXzz/ZpxQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199018)(52536014)(8936002)(5660300002)(41300700001)(55016003)(33656002)(558084003)(38070700005)(86362001)(38100700002)(122000001)(2906002)(186003)(478600001)(7696005)(4270600006)(9686003)(6506007)(71200400001)(26005)(316002)(8676002)(76116006)(66446008)(91956017)(6916009)(64756008)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gufkPY5e3DJropVsmFkEur2N6Y5IMvllRapec2Matqwvt/X8zR+EKzF/ko?=
 =?iso-8859-1?Q?kCWmeymYsp2Fmhoq/8GfoF/KrW16ZcvDNLGBNYI/lIounxpV57gVyz/ZV9?=
 =?iso-8859-1?Q?Mn7Yc89J0V4M8ICov0v7cRqM5+2LK/cb8oITElvoig0LZlvzlglvPtDEk5?=
 =?iso-8859-1?Q?H7HX7vqXxCNN4rMATrNBJzJMdsd2+rwI/Nu4t1H9KM1ug96MXvhGAttwV0?=
 =?iso-8859-1?Q?L2Hwhk0NefAEGwAzY73U4huZulE9rBPANBW0XquFQoyd3xA6jeEFB0pOHL?=
 =?iso-8859-1?Q?e4LGSMAShxlv8ZIxLHoCzpTy5g/tK3tsExyEITx8CycuIiubzj74L4Bh3x?=
 =?iso-8859-1?Q?VEl4I7dL2lNWx6ovdaaYpJOqbOzMZTEyC5p6oMYe2HcGQjTTzA+/1q9qDl?=
 =?iso-8859-1?Q?3TtcFd8NMec9FxIR+1Psz6l1Mv+1dEngFyDY7ZWZAxXqCclo/8sOHnW0kd?=
 =?iso-8859-1?Q?Np8eLGteZlKQ62740Bv2YSpmmpVxZdhmEZJYhhE6PPaOrve00b9yIsOtUK?=
 =?iso-8859-1?Q?Sx5FAETI6dzT/3zTtwq5NM907GpxWn12Xb3GQlrGo1KzmI1nXb0AsySKXH?=
 =?iso-8859-1?Q?n3/duutH4VSGx2FeGtlIrF3MgqGiDNY20wVk4HUMXv3kiFvnYrkUZO9HFo?=
 =?iso-8859-1?Q?az1nKXvHePRgMeLWvuMSbw4tAH5XIiDmAtYPMPPp70LmuNxzmTvgyjL72b?=
 =?iso-8859-1?Q?2kbsthWP6CP9f6dpTISgZYkYxHbryjObj1BeZRHMJjrQTo0k/9Ohiin2mE?=
 =?iso-8859-1?Q?OCCQyajLzSTyoNsDJJfO6wGNrmLzL/REJNEOooZyRcrpemyhIX5PUnzOTS?=
 =?iso-8859-1?Q?tmfURD57w4NlDtwEm+Di9FKzTilisvuBCdrA2bw1fcHBIZgcnpTyzs1pkL?=
 =?iso-8859-1?Q?50UDa1shAV315cwbfFatzy4YZijhE639yW6qlhHAEOZ4LfO61qCzucU5ak?=
 =?iso-8859-1?Q?zBaMTb3ut1iH2/jkcKHZvUTFWZBAZ39xXQ9g19VuUiRpeS30UX5wWk+IzW?=
 =?iso-8859-1?Q?uaC30/MVsj89RLY3kSUDNcQcQJXbscs6FpM+K6DsqdIkqtdAH4Y7EGqaTl?=
 =?iso-8859-1?Q?uVOmb5oP4AZLKFJ2aVylhWs0PsU1fG5NwiSVJqFrm33MuAzQwW40bBt2ap?=
 =?iso-8859-1?Q?rYxTZRP5aVkSGz5TE8oDcrS9OxTX72cn1AmTSbJZ1Qb3NZYjxnHMGU4Hmf?=
 =?iso-8859-1?Q?skFA6PZXELeC+4TpqqgjGMQ50/VQYnPp31G3FhuZnWPG2fOIV2Kw2eyClG?=
 =?iso-8859-1?Q?2pa9mf0Sa2iHd06h090V4I/axZ/aaOJHX0c6ylyABhOA3S7FIzoKwHqb4W?=
 =?iso-8859-1?Q?va0IrPn+xTsP2lsGMHXf2gJknwkDOQmCRTTl+pARCopcpoSIB0+4MokpEU?=
 =?iso-8859-1?Q?JHXVhpp1dI8cD5hIJye6h9mcdCMj5NPuaQipur000hlCuiIgtg564RgG0e?=
 =?iso-8859-1?Q?U2hXHa3GvCaO+j0f7PTD5H7AnBd3kzKdEbeGn9qCTFKXGrV0O2FudR9+gS?=
 =?iso-8859-1?Q?xOi1QOrfMHc8HWSji/ytmjcWaE9Nmdq+8OVz2Xewv5wdYpA6SBt0/4mPGu?=
 =?iso-8859-1?Q?U6+qIfhurbgzar+HZ0uufBo2hTYUylwXZ32hqpKS6BMDZv7o1swOlHjF8m?=
 =?iso-8859-1?Q?d1Qz0uz6OJCU+nIlzUbKUU5OjUkOAp84UIEgvm/5vnvctUKexVftvdHg?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 548bae2b-59d5-4564-08a6-08db2adfb356
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 14:14:07.7286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHPNX6nT1pxHBGmpkKrBgxVKe8y4FGtnKZr/z9V86CQQjsUg2Azc7GVX62sX8ETHAtX54Oic5LIWFoDGYcwYgLJwy5IF3YCbKz+aa9gWS9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3044

Hello everyone.=0A=
=0A=
Has anyone been able to check this patch?=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
