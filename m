Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90040.outbound.protection.outlook.com [40.107.9.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4E173
	for <connman@lists.linux.dev>; Sun, 23 Jan 2022 17:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6SNwGobSUYzDe73ba+5HKNwGSaQWYAsaNtBkejxMc9b0KbUJ1qwevh3W8fTjXbOb+mM/qFypa4/T1I8teCHrIFsbM7LmiMeY3oS1OupmTwChEZ9rjCqxSo/2c+0XQEoWTlfu7TxrAPJY73kH13ZZFc1CLQ0i9QrkNhtOZ9KNyTnyn4F1ssfe0h/8R3SuvlcZSPSC2yj1r+ulA0YK8Ma6gFRviHS3wIZ6KYuvEuhSg/M3ZuZ/VlXmbhzaSN/PvQjgMeBnom2wWFXsnttfC+5tOR/Vhx5oyHZCivTeoyqLraKHYOb60AHARtHbL1Ebtei37d9mmMrQSMkBCeqOl1BTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8gO8QJLM2RB2F3WVOql2H0RKy75VBm/vQi3zGGRyNU=;
 b=hojrDZnJt0sLSxtZovzmZSChdvb0g7K+NzpbjGvWfVA2BIuhOLKiY01b8qzSYLLqttr4DsSSP+U2KB5+oQufoD5Bl9SZqLR37MozJzsxzRM/ibljT8HOXD1piJ0U+Hmy1lHFLx9gD+0Ftfs1r+98YtkEEh5aRH2AaEoTyEZmuAMzV4eysIVV3SBHLc7NfWbO6h7gnQs9voZlhMDBwBDeL5hU4ZG+5fc9dRECZWoYlP8URGm2JQ1drTwVb4BdO7Urm/1QCubojM5fQHb0AbxP98YDux38Z7IzhRk09/bf5ZsACu2LGSDctkPbpC2VagzBq+d4rSh58c1AHb+o7sD1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8gO8QJLM2RB2F3WVOql2H0RKy75VBm/vQi3zGGRyNU=;
 b=XaM7qsmuphVkyQ++G7s/DNN3NxgtrL9+R0MMa4mZ9gNP1ngf9De+47jcCjtcsnNCTNS9pa0j6inou00HakFWwkgRRrgxPuFT/HCaSZyEuw5K2y3KKLqLysyg02rFtVDyx8YPe9Pms5ycbG5XemXtYgms5qz1/33DdTkmWZizS4U=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB4199.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:256::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Sun, 23 Jan 2022 17:40:46 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 17:40:46 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Always disconnect connection completely
Thread-Topic: [PATCH] iwd: Always disconnect connection completely
Thread-Index: AQHYDToIeiDoGCT3CUepeyAMsEYbTKxqWabqgALCOgCAADDRYIADUC4AgABGFqw=
Date: Sun, 23 Jan 2022 17:40:45 +0000
Message-ID:
 <MRZP264MB1544816EE2A3ECBCC2347C80935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220119133927.1245607-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15449D2CB5CB2656550C629A93599@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220121074740.axzlpaj55xtzeg5s@beryllium.lan>
 <MRZP264MB154465E0619D397C2859ABA6935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123131808.x7vvxmkhbu3jieiz@beryllium.lan>
In-Reply-To: <20220123131808.x7vvxmkhbu3jieiz@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: c6a2e5e8-d700-2551-f48b-d8850427341d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd1d21a3-6bc0-4827-c86b-08d9de977c86
x-ms-traffictypediagnostic: PR1P264MB4199:EE_
x-microsoft-antispam-prvs:
 <PR1P264MB4199D2C3781C053A3DBA4FF8935D9@PR1P264MB4199.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 du8xxfsEkZWxz4yv7W3hhWzinNj2DJtrzupd/4JB0TkfHYCbit1HxXETpW/q1qzKTVrBs4buoMxsmN9SyPXOHl6q11oIhqsFLcb/LPuVmf3/TFJE88ai+w5P2KLbarDsqb8KWrspajb9iQaG87N2jS6MK2pnw0tsXzrvBXQ9LBQCPhMiDQ9ube8XXwW9Einculy7CEI8p3ASXw3rB6BXIqaFpj4InsQz/vv2L7RsrBm9PfVCzQ4vUfHJv6TJSe0LELC34Z6vSdaLrzS5kVt5BIBUodKP0yfrtE5kjlMBrg5lRPFUPi+QZeaXMQ/EFsqskYlAWmClOB+Ogd0enUBvh4UfVRexJjuc7tBPT9ZidNY9vqcdpMIPojm0hRZJIBNkTvUwwK2fzFQph4snm6bYlwUgDckxUYg0CN+PRqjhHRYEDB70lCOQiE9+btoEXkq1YWu5LAgjySPZONd75Cfc1HIaPzskBws1W+FlqNfwzhwOvVT/t6nRop4Bs8rDP1os89fHgEXESYa+Cg+X7e0PgLF+Lmfy7ouWKLUlfFInTh4KR2cxM4GvxZzgosLBTHTJVZY+XaClQapAExt94e/XjuckmODfpJ988mX2oGtPI4hUFQyi1+E4ke2qFoe1rD541O/Hv1qhXxNWEeNc5iQDH2PEz0MaXJlG7yippQu+UHHDlQ9ioWbirUZavxvO59n9iKj7+iaWb4MVOs5qfApPfA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(508600001)(83380400001)(122000001)(38100700002)(66476007)(2906002)(66556008)(6916009)(71200400001)(33656002)(38070700005)(4744005)(6506007)(52536014)(8936002)(7696005)(86362001)(5660300002)(55016003)(186003)(66946007)(76116006)(9686003)(91956017)(64756008)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?L0fIBqwO9lur/9pH2zE0fMAgQc+DHVrxIdhji+SW65pGXb33WgXXDuIjFg?=
 =?iso-8859-1?Q?vn+iI9WQYDU9dZsMLtgfTZunJvajHDDMD1A41nrL4fMxvKJL3LXvtNXo+7?=
 =?iso-8859-1?Q?K3YXe+CEfEOlCqKAV0WSd/bYBj7y12bCWRtMc53SEopNisapjRwpBKcggR?=
 =?iso-8859-1?Q?e3bt6Op9BLSk3d6OPyXXhWwRzdZxDRf5MiGw/TGmAe95xtVaHsUi8CTE+P?=
 =?iso-8859-1?Q?A/5Y9jLqg+l8vgB9ERruq0Hz1VhbgpWNnETbaXFH13aN5rPFqfTCxT7Spo?=
 =?iso-8859-1?Q?iUsuH1Lcu63BSi4bB8C37DYSDH4eGNqgWnpbdWYk8R9ponuJpB1pqISJF7?=
 =?iso-8859-1?Q?CD/eO2UIyNhTkdhvAcz+jW5QY0VZUZoPMS/4XCKcfuBODfjsY8+Hug8LNM?=
 =?iso-8859-1?Q?pOnHx+7AjfgRkeQh/gqRhDv1LnAaP0lyCHa0+bloEsd3Y8Iu/QtL0E4heN?=
 =?iso-8859-1?Q?39chQCqJE94uP2F4J400ZsIVuj+G6Dw1Zir4vA2pQ5M7uFF3WYv251PEPq?=
 =?iso-8859-1?Q?zMuqW1IknJvySXJLRdcGVDjSuFXKo0Njm0MHRQfpRNik18spEEsAjUq67e?=
 =?iso-8859-1?Q?ZmipXIIH2i3W5O45aDWoUZV/7ItjbFDuSUErpTyqtyTbNjOSPVqdicXetW?=
 =?iso-8859-1?Q?Q20OOnN4XcKgGHz4RPQ4x5GeiKWTaIcYTyqvYBQsSFHq9LAe/V9t9jH7sF?=
 =?iso-8859-1?Q?KT0IXT/BBNLahWqzTm2jtOK3+xvs2oSCPswxaLJUxwNbzPyjY16wpujNh3?=
 =?iso-8859-1?Q?MRbX2UUfunmgZZq1aV1kTx9JaPZPdFZHDSP4u8lcJ8MFTILHw/fb8lqdap?=
 =?iso-8859-1?Q?5V/up8ZtGnTLzbJUHm+Ef1ZtweXM648URsX1Q1ju7KzoXVi6Wrv0fk5Xtb?=
 =?iso-8859-1?Q?A3QFjN0WV4uTNN5eeDtWfa2OFnZ0YX7iwRo5mBfwXhadUCzVGes+MmJDxt?=
 =?iso-8859-1?Q?DLxp4MAbnsHLYoK5o1Srxc5R+h7o0CfgOt8by6e642f/L+lmCCSb0925vW?=
 =?iso-8859-1?Q?tfwxsLn9HKloZPf6jwIePWrUXYKLyk0njE4N5/b+O+NERtCACbm3iXlPCb?=
 =?iso-8859-1?Q?FeIZjQfxpEWP6obWIpG5c9/vNSLE3VfCCHZxTEjUGMpXKyaYMe/E3TsAAZ?=
 =?iso-8859-1?Q?aU8mMsHTsPtBJ3Kh5SC9+bXusauQ1zoiXf/C6BWZcoMje+1VnJVZN+Fw5r?=
 =?iso-8859-1?Q?+GdEoVeOHeWffDE7efc+UakyTVBY3STciwqt6n8BZiq9+qx1e/DDRYF488?=
 =?iso-8859-1?Q?EbRv/GpYs402yuZa4MD20zyM8LYIPEFMBkB8HQpucyoPY4dRAIVD0TF3Jl?=
 =?iso-8859-1?Q?H5V3qvOfXzfAuArE3GoT1R1ogRNKKBi/tDsyAIVf5fS7CRLACp8c5IQQkB?=
 =?iso-8859-1?Q?h4zGnOdUEIzpJvUr4XwJ+0/qKgI/IQPro0b8iG5gCABGmo+IRznG0MCuUO?=
 =?iso-8859-1?Q?k5mhp90H41PfQmnnZId3kqxUNmTE3hmzJBusEjYCYZHGcFS+rnm/tBFLvN?=
 =?iso-8859-1?Q?bnCO9hwax6zJptnk76keCsyTHss3gkf3bqcn+6c2vSaG6rY9hLYfViMRUm?=
 =?iso-8859-1?Q?eNiyAeKSiSisN7Ndo92OXX+wGBXQEDYI0H9QIqpQq5bFlU/CcqQ/ToRCO8?=
 =?iso-8859-1?Q?6IVSiJfGMwv9DzXg4K/eXa6MyiyedFXZ9Rn3Hxgdc/NWA9sodSgWgtjRuG?=
 =?iso-8859-1?Q?2pA3g7iqgV+KMGtJPx5pJRV/WrdM6DseeKZWBtZALKKoUh91fXJNh/IR/t?=
 =?iso-8859-1?Q?wgl9V/LuQ+eOtZmHS5XJAk1lHgKYaerKeThieuuYY3+Ai5TwLA2rXk8VSp?=
 =?iso-8859-1?Q?HLKXchW48A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1d21a3-6bc0-4827-c86b-08d9de977c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2022 17:40:45.9646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d++SxJD42UclsuMrodSeCWXbx0sfnwFICzal0aaH6r3WowytKb4bwtNXJagkigpJDAA/1PQ1d+rcpmDULSCpvy8Q10dSuGUq9dW8AKu/mIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB4199

> You forgot a static.=0A=
Yes you are right, I have activated  -Wmissing-declarations,=0A=
which was not activated by -Wall.=0A=
For your information, it seems that some other code does=0A=
not compile with this option (xt_match_parse, xt_target_parse in =0A=
unit/test-iptables.c & reset_xtables with no void argument in src/iptables.=
c).=0A=
=0A=
> BTW, please check your formatting=0A=
What do you mean by that? Do you have some link with associated=0A=
guidelines to follow?=0A=
=0A=
Best regards=0A=
=0A=
Emmanuel=0A=
