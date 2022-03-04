Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120041.outbound.protection.outlook.com [40.107.12.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58862A33
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 09:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emjXVrfZeC8N0x+Qqxaa7exokj+zwTOQMbTfk06PRc15Tp6jxJzC5T+kSDv58wtvcPyjVqPLMJX1OSmrbQkUobbEpft292raXm0a211yukONTA3+TvJ6ajxTdQdz1VKBN1LenTLeN5rqBQb+FvXckmCNAcxutmjFV5UgfPcBlwaUbCIipDH5W9I2QJLzTGER4KlQAn3ohkb5U3YZY8fmQBlNPP+4jJzTtnloZ97eA3Qd3EUVee0xdp3L1BDxLH5siry528MooSUkHs8nqjvhrbhfKz/ZNctsSapkMtIBcntUXErwTn5gFTHaQryqkxq+f3klOtjJ1aM/jkrU8UsBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVxPlpCF7spLS2eQqimkVRNHMkexXmd0IXmyn06NdfA=;
 b=DbPcsKFSkxt3hcrl9CHtwLsQw08ys3DWiAaUe8CInKVcW8Ad/4HUMvzb7w36gQZEUgocv+4KBwBQS5sK9Z7ee6yJT9S1Hxi+FWy7IeqGyjZ2kimEqtM9NxiPLc1O55WmnkIj+bEUYZ1egyssZxKU832B2lK/JjUiEylvydo2OWlz4GvrdWYMVqwuEVTZgtSj1VrAn/86XkKvaJJbxWrPi6B0zw32/EO7VGS7ZYz2qCq6JEU3UR+QwKqohuYysPoDgOYqREi0jMf/ljCz9TrU4pfM0iZsyZteUKOdExiIwcdniRJQ+OK8LJc74IoyKR+CgPsm2pnebRqQeeix0mD4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVxPlpCF7spLS2eQqimkVRNHMkexXmd0IXmyn06NdfA=;
 b=rlmDjwmYhDs+7nHy5DQvVzjinnXjooGpRJmdbjV+U9XjiKiOh/sPb7MVzL3RQNFgUBpa7l9g+fhaYz03zE6jqUxvpnpTjQVpPS59UkNeN7KXJEenX7sVL/hppe6QmxiaWivPNIoS7CFvaIt9BHvi8xKceHC9tBvKdIeGVhR+BU4=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB1646.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Fri, 4 Mar 2022 09:02:32 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e%4]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 09:02:32 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Forget network on service removal
Thread-Topic: [PATCH] iwd: Forget network on service removal
Thread-Index: AQHYLLOOA8J5bMMmrEWII+ZwKAmNa6ypDirRgAXkkACAAACg0A==
Date: Fri, 4 Mar 2022 09:02:32 +0000
Message-ID:
 <MRZP264MB1544901EA2E1EA276F8040C993059@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220228145743.2110055-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15447BECF20D7463FD6EA9C693019@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220304085850.sio5brshuyvbh4gz@beryllium.lan>
In-Reply-To: <20220304085850.sio5brshuyvbh4gz@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 534e9095-846b-1701-fd21-af1b50167d20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edd9b923-5805-4233-1f11-08d9fdbdb804
x-ms-traffictypediagnostic: PR1P264MB1646:EE_
x-microsoft-antispam-prvs:
 <PR1P264MB1646D2309E0CD273D589A29C93059@PR1P264MB1646.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9gE1AZURmFvAAb0evBTAneEdEohllq+j4hLe9AVW8B1LU8Gw0noJEqWoffDa4zqnRINYvlbc7BsIgNQmbQ2cMVT0ebarZiNwbAg/xYqHfHBIfRtD64tOdfwnx78wOq1g2uUJ0LtSd20SdZ7uyiZZqOgvr49t7NO0VbN3ffhWcEuv9Fp7EoPRyT6zPfMt+8CXpYYlhlAC+ip5ptANnnczVzJuVdi9/EjoE6gbwlKswdCxGXZW7IpDZ532lA2uTgeZocuaH99xNThKr6GIoiIr5C/aQhdHPhrAc8Daq1IEaBbN14oW5TnU/Uy9d08MVWHQuUmC7nRuw5opKlKRHQ7HxZwOp5vtyNdJ1I3/gf0bea0SxPMtIjhndYNLmg7cojoQLVf9i4jrwv9G3tcE+XlPDjnamVwBSafgkNgiZ2UbBzp+mgw7ICuzAqVfEf2UqvA6tz7rafnzHArzWQ4VfwdgvwKk40gIw1HiFZn3Brgt46P0jZp88/06/mP8JiWR4gOymTuV718QVy/zJ/ugEUKVhmGvxTy5JIzf8sfQVFserGRYSw2aR8a/Jk7QWA5eQA6LqG7kbQMUu2t8MSf2yagx2Z6vB7HsXDmNNffyAvgb6Fqm2aYAuEuWNqduFQBifFxnHEWe+fMNMp4lL50UuvL+M1EKR3b6cDnU6k5YCSKgFmdWDQCK9DzJ87s1RAFCZ06Ux2PFTBfgbNlC3eCwNtocHg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(8936002)(508600001)(5660300002)(52536014)(38100700002)(9686003)(122000001)(6916009)(316002)(76116006)(66946007)(86362001)(64756008)(66446008)(66476007)(66556008)(8676002)(91956017)(4326008)(71200400001)(55016003)(38070700005)(186003)(558084003)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZA1TQVsbIl8K6jFo7Pp6YADdVFEUTz1JvOGHUOidzr6T93XvWVNhKEAh+y?=
 =?iso-8859-1?Q?i9re6k3vXuy7i0nZDepAG25bNWmjfWNzYnww/G9HL1+CUnyYstKoWwwlTV?=
 =?iso-8859-1?Q?Yp6nmXUg0v+HFHFpfKfvgcXA0r4vrDMoW+gilenvJDGxxx2p90Kn8zfh/h?=
 =?iso-8859-1?Q?9dqSPsXcMaISuzOb1kK3++zsfzzcmWc6xii1W3Osz2iHwIysecOwBA6MD/?=
 =?iso-8859-1?Q?HZSF4mZJsUmevVpylOox2U24vmYphR8pfYKUSmMxKAd1KcPJAWAur2JP23?=
 =?iso-8859-1?Q?cV6OJ/hWOIjDMRE3B2WdligrnMz0NJ2Y6bZ4D5gAl/d/nwSSgCO4ZTSXDD?=
 =?iso-8859-1?Q?TSmCGITmvKa5kaNplzUhMIJ5Ym0hSZ/J6nZsnsUBcCflqNOY9YhTSuk4zi?=
 =?iso-8859-1?Q?S01jwx/2HnPXQFIlISACyz3sc0G7WoqK/kMYSImm6b9BZ/BkzOMsO4Gf9P?=
 =?iso-8859-1?Q?BxvhEbuafXg4nJMIfQc+fSA5ymjzVhaGV9qiu16AcnJ2K30LwM0WzADVvg?=
 =?iso-8859-1?Q?Avz7+qa7s4CMnxmPTLsIH3LLZ2lKOXxM8s4o+N3yPA9aFIlfc4PEplF+VN?=
 =?iso-8859-1?Q?zmEf2fS724YZl6tWkZWZzNy9orbr0Dq2u43FYBRx485M9uGU8CGb/ohczX?=
 =?iso-8859-1?Q?v21euX0xa7791TxpLqgOpuOSqTQVECLxbXmcQ2F75WLikb656Z247ZPFNi?=
 =?iso-8859-1?Q?lLgjDR0qPctcBNFrQS/gXPgROT52q+w/x/fKSy3b25rE9XtYlN8BvE4JVD?=
 =?iso-8859-1?Q?3NGe49RpuUT4NaqvIT5yOmC/QwakPoopOtA2STnmrVGco++Z8FuDJsm5Pf?=
 =?iso-8859-1?Q?957QV5AtA3aZ+20xVP+3nQvCXx31zHkqEZtY22VHSydVDC9gyz+Mv1zIzg?=
 =?iso-8859-1?Q?uhmoWzQp5UIL2aFIwc8Zy6dw5Y2+5PQqFXiz3rtjUls9DZIc4KoIZ82kHm?=
 =?iso-8859-1?Q?LF+NnVKyFRT52SlqFSaljeL2CJwkRntNVWcPjXP8mw6PVAiKgWxNmbksrK?=
 =?iso-8859-1?Q?8v4vbujaHs1OH3mDuCBBZTrY7LKKqgBu4WwN3Pmesos5XMt3NAIQJyqnjq?=
 =?iso-8859-1?Q?1MLIbDBVKIOkIANSk99MOfeQY/6Sy3rk0PcbRQp3rJfc2OvfsWLA1JMgNa?=
 =?iso-8859-1?Q?QTLrEQ98ENPzrE7iY4EUKLFqp3Jglqtlg16jd1+TzLxtPD2b7li3RIpCWf?=
 =?iso-8859-1?Q?uEsdii61Qwimx05PtJTGPeAMSS74PbQEcGtz0JhkEdREZhhpZgXLj0JHv9?=
 =?iso-8859-1?Q?mzcz/wFpflTMNiCSqpWXSQYG4pZUiVOvKIppdL58OoC5zRgNMxrbDmUKkB?=
 =?iso-8859-1?Q?ipcQduigBmdrsV5AO3JnCDDJqt08B2llE1WXRTOJ3N7J4b0YxkdCc2ABsh?=
 =?iso-8859-1?Q?Hl7CyQh3Nvqcj7X681DvYeOFU9uFbRp+JT1V60VUVLHLF9G5S7YIgxvy18?=
 =?iso-8859-1?Q?2lu6o0TU/Fgag44hKF0Q1qTKtF/gDgFct16uVQR7FZqSjkPxSUDdLLVWk0?=
 =?iso-8859-1?Q?KYby2alVGvIBhgs7jnkH2qRpB7effEn3iSkXxIzsYsZ3HzEg//RWwuoM9y?=
 =?iso-8859-1?Q?qVk0gSGfEoGR7Ytd3N0aOkKxnMLLaFIFa13pst+Ldvssl0T2hri989aJsr?=
 =?iso-8859-1?Q?Wm3Os4iBQsy7h+YRWoNmI8wppOeGsFmbdKYs3bQfQ16PHBlrugemwJYydV?=
 =?iso-8859-1?Q?NxPMKvPpf7zHCOrYamsJ5lDXvntLIfyevevq4fqFwfivxuZqWxIJPFPREY?=
 =?iso-8859-1?Q?MR10NyF6asX5qT5SuQeWRpoU5DV4T3m/TrSEWap61AkO44M29+A6DTKoog?=
 =?iso-8859-1?Q?QW0AeZm/xQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: edd9b923-5805-4233-1f11-08d9fdbdb804
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 09:02:32.7247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aN67RR87/WHvO4/4LSQ+Xu4RzA85kAQOxWwQn0cCTEb7CdCAT7UQ/Nllz++7WH/AaCXrgoTJ/wYdorxr6N7Zc/iGpuRFETEqdGY0S6eYecI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1646

> Nice one! Patch applied.=0A=
Thank you Daniel, great news!=0A=
=0A=
Emmanuel=
