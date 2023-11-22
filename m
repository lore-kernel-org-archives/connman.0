Received: from mail.eaton.com (mail.eaton.com [192.104.67.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336404E1DF
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="gE8QVWAr"
Received: from mail.eaton.com (loutcimsva03.etn.com [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF32F8C1D9
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 10:28:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
	s=eaton-s2020-01; t=1700666913;
	bh=4XU4ABBo/VDyF4tGlb1sNDTyiDeqqPujIFjq94bCEC8=; h=From:To:Date;
	b=gE8QVWArxwnkXQMMCEEJyyb4AsXt0870DZB1QWh21rDOGarEq7jQVR9CBi/rHrRWp
	 RCPw7bp31tYlZ+8OXlvFXc9Wep2L1y399/foQNGZnVGpbj9LGoQ+CrIHPcinKUHoQT
	 uHHxeGRFPTlBgFmA/loKyonpjA/yc3BgqXvBvYnKjVxR92odBL8teVP8CTP8OlzeX7
	 19ctRRVPJGkEdatABzg92hlJRMGQDuPhv9T80mXeifq6TTsCH98F+RJPxKSZrR71V2
	 YsNXcZs8VL8m92iUh6uLmMHzFdPXX9gPdSyuqkuqIGJ5/XwxYMyntm/l0xrh7P83kD
	 6doqtoELAWIBQ==
Received: from mail.eaton.com (loutcimsva03.etn.com [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8F318C0E2
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 10:28:32 -0500 (EST)
Received: from USSTCSPGWY01.napa.ad.etn.com (USSTCSPGWY01.napa.ad.etn.com [151.110.126.224])
	by mail.eaton.com (Postfix) with ESMTPS
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 10:28:32 -0500 (EST)
Received: from USSTCSPGWY03.napa.ad.etn.com (151.110.126.247) by
 USSTCSPGWY01.napa.ad.etn.com (151.110.126.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 22 Nov 2023 10:28:12 -0500
Received: from USSTCSEXHET02.NAPA.AD.ETN.COM (151.110.240.154) by
 USSTCSPGWY03.napa.ad.etn.com (151.110.126.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 22 Nov 2023 10:28:12 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 hybridmail.eaton.com (151.110.240.154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 22 Nov 2023 10:28:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmvTyTYmGDq47W0ZUgbpwj13qGm3D1Mk8z8pvXeqpj56ioEaytAwIgaoR/B6BxpEa/BIwcfEEr9HWZ5kAxj73vkvpAcBQXY3NNjzFXAWYFrtQdFPB55zOf3k9zhrWU5bv62mZDGJkP4U2wwitZRIF/FAIDrEHtwh30GKPzMs0EIIijj94Pwx1M5sfQzGhADUZ6DZvQ+7RWqMtNRf3A7uJbSiNb+XQ4/QTKdtYwmpEOlpLf5hVxsx9Y9XesIO0xpQ2GSU/wdLrxhPr1Ve01AZtQX7vBtIL1tP4sTnofWaDclrrR68byATrE+6nokNoRN+sPxOdeuOMXUklwTd1LVfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW7LAmDdOYxE0W8yARerBtaCi7mwsHmO+eUi2QZhVC8=;
 b=DTtxCKgrVqa6OYE8LkXc/b6CmbnffuKezRZUbhzgvePPAsoHi7HlqWfOFp6Dy8+0/nzEss5iwv/IGZL1Rxf+zs+bnu7u/r8+fouvKLuzIAsoCYYsB7Cm3vppG+38mmrHH1/4N63Vfh0pSczEsF7DVIjaPGfdC4HNpKUQFMgUk1yACLK2RNytCHFzAGELBfxSn/5ihV5CqcQZSTXs1FwhUdbjxQyQey26SYOYKdfRUzlQ3Exj1QzOKoI8kmnhSc3+bZo69Hcw2aIR89BFIHWnl+r63+jQ1hGOShKb+llWhSP9rcf4KJBu92NL7lBt2X+BjOtrVC9w4S1T7bQY3G1EiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
Received: from DM4PR17MB6062.namprd17.prod.outlook.com (2603:10b6:8:be::20) by
 MW4PR17MB5641.namprd17.prod.outlook.com (2603:10b6:303:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 15:28:10 +0000
Received: from DM4PR17MB6062.namprd17.prod.outlook.com
 ([fe80::c4f2:27d5:41cd:af48]) by DM4PR17MB6062.namprd17.prod.outlook.com
 ([fe80::c4f2:27d5:41cd:af48%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 15:28:10 +0000
From: =?iso-8859-1?Q?Doumenc=2C_R=E9mi?= <RemiDoumenc@eaton.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Wired 802.1x support
Thread-Topic: Wired 802.1x support
Thread-Index: AdodUXtku7gYgikaRGSHS3IKf/kI2AABmTtQ
Date: Wed, 22 Nov 2023 15:28:10 +0000
Message-ID: <DM4PR17MB606221C32530180BE1CD1BCCACBAA@DM4PR17MB6062.namprd17.prod.outlook.com>
References: <DM4PR17MB6062156344D8310C1353BC28ACBAA@DM4PR17MB6062.namprd17.prod.outlook.com>
In-Reply-To: <DM4PR17MB6062156344D8310C1353BC28ACBAA@DM4PR17MB6062.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ActionId=cac3761f-dca4-44be-b524-1dfa99cb3d60;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ContentBits=0;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Enabled=true;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Method=Standard;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Name=Eaton
 Internal Only
 (IP2);MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SetDate=2023-11-22T14:37:36Z;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SiteId=d6525c95-b906-431a-b926-e9b51ba43cc4;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eaton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR17MB6062:EE_|MW4PR17MB5641:EE_
x-ms-office365-filtering-correlation-id: 885a0a9d-f3ad-4854-3531-08dbeb6fa279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 855iN2LcfnLyvVwlcXJlSuuzKbqwLo5pOxu/HWkLZXnz9hL1a6oOhcKJTe6EVSzEwBSoz1lY3drUCTcz5v8US7alMW/D3KeHklse2wJ2atChTOKwWSF1CIyTvo9IfWvqGryXFE+5Bknv4OxwNObWKpOgLLXCrlzPs4v1dq+nIf+iSQX+q2nbH9Hsqi5m5nt6aEzYXtM3JKv5BisOsW2vmKrqN4nhk7etUxDnI5yLcPSWMnUb32qDMxzI1Pc0x5I23KUUs30KwUSuWakf3RP+rilNPEtduwEz4evIv95HrRe63JaLDLAZFq30aSY5bVwdYcP27qnynftWGpQOxiINg3oBU65OcvHzD/Po1981FQBGf/2wrFAG2lfXkESs7oX2oLkhLRI+BDzDk3SGlUDpWIc8vxiuhXK4NFVfajryOBt1Ub1Kpg4oK1padZGLldKJGCAZ6wq6gr4uxvv4p7NZKGlNAv1FkCl+jpjV+KvR6mZ9PkGxDiAaX2qvFSRV+6Rv+ER5bf+l13nravvx7CbzoRbvVz2U8ONtyYi2JDHGjUOc5AyF47TQK6bzIv3DY/UNc86B5zcajWqxT+W8Lgx8z0eFD/g/wqpEygQeh7fQO6shgwjgf308Gy6HVF4tnicfV2PFSVrPOrs+Rj/8ws5TjmuVqLyecJcOKdx1jxs7rho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR17MB6062.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(4744005)(41300700001)(55016003)(5660300002)(55236004)(9686003)(2940100002)(26005)(71200400001)(82960400001)(6506007)(7696005)(52536014)(38070700009)(8936002)(8676002)(316002)(86362001)(33656002)(76116006)(64756008)(6916009)(478600001)(66446008)(66476007)(66556008)(66946007)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j34OGSUbek3NKLPuXlkQPvEAip/5sSomQELLXhknQVlwIXK0e19pPt9vc6?=
 =?iso-8859-1?Q?U5Yb8GeOq+utdGR23kJH6tqbuZTzoSmxCaDxFvai5846bwE9SfIxYpTNiS?=
 =?iso-8859-1?Q?Qcyp1yUGbYsQC2tp28MC+9dGxVW2/9hM3IfL4YwxD+QxI6iSfwBBtTssLm?=
 =?iso-8859-1?Q?B5QWuuY/BlVp2aKkyKnNZ8jWmxNLxA+1bfsPA8jyt3sbcExdp6BsPM3xLN?=
 =?iso-8859-1?Q?jDxkvokf3+Py8eX5h0R/2eOExIYSN3rdBY5N6N2q5L+f8StAfrOvD5fDoR?=
 =?iso-8859-1?Q?owTHlwcm4lhTmwCt4Iz59sHvYUZwJtXysOb01Bmgk38U+dgWvD1vPTJGRe?=
 =?iso-8859-1?Q?BB6FLSRE8cuLVm6dA65i9OWDuj3OWXMiCYdMm5xsiP4jkTJ93veWHcemtp?=
 =?iso-8859-1?Q?WkvF5ohA2voomF87gwhvTLO9VMP95+d8MbbaNHpuBY9JszNB3rl6nMJUp3?=
 =?iso-8859-1?Q?+6EERnSqjuP9/1s6YM8t7YjL/sMHDTXcvw/c2zm2BrM0wgpl3Z9mRZ3JkV?=
 =?iso-8859-1?Q?XM964pd78V9Jk4vPq6cQrOquYGXwo886xO0JcGNuR23rfVRU69iUqOdxl6?=
 =?iso-8859-1?Q?GiA0iTTW3PJQfCnhmtZdMwo5Fyh3mg8Irt/NH2fr+zNRBzprdpsXmxgE/g?=
 =?iso-8859-1?Q?JmQyfvdbmp7Z2phWVWCzYB5ahjLVEF0Zp1FJzAFBUOqDlHf9Vrjzj8Qj/4?=
 =?iso-8859-1?Q?gjxXEtAX33D6Wk0sujBgqTVqBbw7q4WxJoGfVS+Ko+qkn5+an7I8AnH1Pz?=
 =?iso-8859-1?Q?wtfQEsdNQahyQFGzx/IBGVnp20v/DHM1WpQ82TqYRQVtpF63wXoTcwMNIC?=
 =?iso-8859-1?Q?UevIexpq7ls7wK1Ha0ZSYT9qqrEvBZy2KtvT1lVBNh9TZKGDdwFx6ANJiP?=
 =?iso-8859-1?Q?NVsLJaUbl6wMev9Qbztp8pwkKhKOCxegzQxxR52SGEWD2TfVFi+YWmESIq?=
 =?iso-8859-1?Q?O4q4SskRiVaGb/09IHFjqRVu95eKx9AnJjaeOoGk4iqoDUjaedRbJN0ZXi?=
 =?iso-8859-1?Q?S1NYdZM+tM8Dt55ZgENIRxTZkGw/3RAfgXySGSrixO3aff/zXCDjPVKyTU?=
 =?iso-8859-1?Q?UoCFQ3KLBPRBtlW3dyoX+mf0fhePbPafN/4Pw6nqxcurQokzPUcKOLff/H?=
 =?iso-8859-1?Q?qt143OXZYUF99DZNEed16w4gdh1loT3qYRkpot25bwGx8z4FROq71qphXL?=
 =?iso-8859-1?Q?r+DQQULGMlmnzENtz0GG0GY6SM95YbDXT6SexumNQkWuQP/DGEQfjWIiDu?=
 =?iso-8859-1?Q?sO5BeXFfINhbO1nPjt+hKn4kNKzMAQjf4cnuKmcALkp1RWtUeW47VG8w5x?=
 =?iso-8859-1?Q?Uc9Ji5gYOn/MGgWzP5RPnkmGMGxJaqjCECE7w+3CHDww4/fAoaUNSJfYDM?=
 =?iso-8859-1?Q?4PAutG5ZhlKE14IIy/pI/MaWtsJjoaKpbeNYdOedzUWv+kRjJriHdOg7v+?=
 =?iso-8859-1?Q?A5J1Qd3S2R6kZC7d5FQIH4k64ffyE9yyniB8uC+9T9GCZG0h591Wjjk/pM?=
 =?iso-8859-1?Q?8m1s2vETJQfyQgLj+sEXTkGywtBv14M8gZRIxmmQncHZ4j9zFtkSh7UEOS?=
 =?iso-8859-1?Q?kxSD/fAnP1kikgIFasY2Lg12rUFmnQ0tgOu895CLOtolp13sdxDhWmHPYP?=
 =?iso-8859-1?Q?RkRpUC+ukt14c6oWRltDlEjPJtp94ON1zS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR17MB6062.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885a0a9d-f3ad-4854-3531-08dbeb6fa279
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 15:28:10.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEjfNuK9eifiR/xp3QeS2/kwV6aDX5IAoGXvZqDIczSHbxfH7nadt+9a1dQCbd+VRcgdO8ncX3fGm7hSRrnyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5641
X-OriginatorOrg: eaton.com
X-EXCLAIMER-MD-CONFIG: 96b59d02-bc1a-4a40-8c96-611cac62bce9

=EF=BB=BFHello,

As far as I can check out in the code, connman does not seem to support wir=
ed 802.1x.
Is there any plan to add this support in a near future ?
The implementation seems very similar as Wi-Fi by leveraging the wpa_suppli=
cant.
In case there is no yet plan to support it, would you accept an external co=
ntribution to add this support ?

Thanks

Best regards / Cordialement
R=C3=A9mi DOUMENC


-----------------------------
Eaton Industries (France) S.A.S ~ Si=C3=A8ge social: 110 Rue Blaise Pascal,=
 Immeuble Le Vis=C3=A9o - B=C3=A2timent A Innovall=C3=A9e, 38330, Montbonno=
t-St.-Martin, France ~ Lieu d'enregistrement au registre du commerce: Greno=
ble ~ Num=C3=A9ro d'enregistrement: 509 653 176 ~ Capital social souscrit e=
t liber=C3=A9:=E2=82=AC 16215441 ~ Num=C3=A9ro de TVA: FR47509653176

-----------------------------

