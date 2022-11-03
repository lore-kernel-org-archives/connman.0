Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60131.outbound.protection.outlook.com [40.107.6.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0FA31
	for <connman@lists.linux.dev>; Thu,  3 Nov 2022 07:50:41 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Bqrw5H91fvLJOqm1rfMgrS5XBSk1VRQlC7q4N8Ctn988cxLmAB2WuOnXNaCsrB0W53VSxwGxyGC4oqoNOOTdDW0bjV9KFo1uYXnHEaRY/p2myUNbOTanSe9TLerIZcsZSwWN7QzdBN5mC3lrsGhxOq0TsH0niVXvsjvA5z0zlc/JShW0d0EmDjCkoXg39uIGD9CkEcqyRdOAj0WGOOyjGPayZxd91oXxnuQKqBRA/gPGeRMxrn6278mPWymNWNSeeoFvgxpK9uv3f+DSiJV9kNqTum9kXv4Z4lwTYmEHb6FKccdaB2Q9VJs6IadPiAV4BR61xlwrDdBrRSZHIrVL/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/5vCXLRg4aXixuQ5R+AHJcAFeedN43xTt6C4u+0dU4=;
 b=JzXSmOuQHjcWyIF177kQ7iHDz6UCs0mpkVhG7uogGai6Hjwe7ShTmG9hld4UNxVvHK/Uk93Vy/vZfKcXWT4rd8GeZY1UvBJc4tjeRVKO1i8hjcZDF2b1OVXdgnCy4pyGx2/N8fd2vFBFi4NpQ3sGEvW0VYCRz+POkIGG9OB6Kl4xxv6H1jdnpwkyseX+0i0wx7eMMN9a4tAic+ic2yjcKTJ79SVIm+j9aA7G4gkAAgf0lN3QP6FezHQaCjKQhg2rI9H7W0as5jl56YLVAik0rri6uyTi12Q2CaZxd7t+DQlBPAXBT+qGYrpwN6SxPpuQAX+JELwxVIOpJc1d0RiZ9A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.52.142.9) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=goeg.at;
 dmarc=bestguesspass action=none header.from=goeg.at; dkim=pass (signature was
 verified) header.d=goegat.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=goeg.at] dkim=[1,1,header.d=goeg.at]
 dmarc=[1,1,header.from=goeg.at])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/5vCXLRg4aXixuQ5R+AHJcAFeedN43xTt6C4u+0dU4=;
 b=AELykXLcT5kJtTFfTRHCnc9Zu2lStDgPnXEU5RDX3waFY1j8HnvtE3/5jLKXEFWw2JpJ2+f3ODCLa1ugpWOQIPCYKkmwbRgJO+B/PNpYfIXpc0GaEbXrYhqppHfi364uuatDUFPFRmB40zDQyrDswsm59zmTUeBktLBOOzpxdrs=
Received: from DBBPR09CA0043.eurprd09.prod.outlook.com (2603:10a6:10:d4::31)
 by AS2PR09MB6461.eurprd09.prod.outlook.com (2603:10a6:20b:59b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 07:50:38 +0000
Received: from DB8EUR05FT018.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::87) by DBBPR09CA0043.outlook.office365.com
 (2603:10a6:10:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 07:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.52.142.9)
 smtp.mailfrom=goeg.at; dkim=pass (signature was verified)
 header.d=goegat.onmicrosoft.com;dmarc=bestguesspass action=none
 header.from=goeg.at;
Received-SPF: Pass (protection.outlook.com: domain of goeg.at designates
 20.52.142.9 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.52.142.9; helo=goegsIQSUITE01; pr=C
Received: from goegsIQSUITE01 (20.52.142.9) by
 DB8EUR05FT018.mail.protection.outlook.com (10.233.238.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 07:50:38 +0000
Received: from mail pickup service by goegsIQSUITE01 with Microsoft SMTPSVC;
	 Thu, 3 Nov 2022 08:50:37 +0100
Received: from EUR04-VI1-obe.outbound.protection.outlook.com ([104.47.14.51]) by goegsIQSUITE01 over TLS secured channel with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 3 Nov 2022 08:50:36 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQncPKY60KnNghDXouzhVF7J4lSJGuWiv4Kc51YdzUkkAunkVxTvpTXpa+neo2U6AK62k/krPMGNXt7wX1Af0IggAFf2dfVTZEEpBgccIlJVh45Tub7Oq0qpZvXh9Z71gRQmZO06rknZLtpZ7mciZzV+EW84DR3onXIXk7JM8CM7LqClwHz05XfvkshWkoK8ZjzRVLe0vSMydXkbpoQfblsU0WvcCGfzILkUp2eis3ebNDyJERwxan4mDWdyqS+zHwjnVivi959cYrMVt7ssYLHYOkMIcljTSANh8SgVvwj/1Qh2y61VJGgeYVGDPGgev7ZKdNwOdfgDBkY9WMFCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/5vCXLRg4aXixuQ5R+AHJcAFeedN43xTt6C4u+0dU4=;
 b=RLJpVss6xtzy+/AxEp8gyM2psucNfz/qH4t6E7sIFUwksqqbFEIlJXQ49H104rqkEiZ4pVjWZ3m2Zl+2LgeQjw0xJuylZXKQgzw2cOyWcqfbqKpxKC7OxmDkyrq7ZURmDdoF2qfRkZuSF6YhU+hYcqQYR6w7KCn0cBqCV3JXkFiVTDnBKsWScvYAYzUhRnK3PnL6E+svEAKxfDY+vrIzf9fEMhMpvTC15/n1wu0egOQ7c0f0IL6SfRI7UP4MjJLRLCC+uercHCjuSOX0C30plinJoPbmLBJwPzqMXuPtVlCE7ruoW9/LOsBwLYdsKmf14wsI67od0fvOmcEO8/Xryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/5vCXLRg4aXixuQ5R+AHJcAFeedN43xTt6C4u+0dU4=;
 b=AELykXLcT5kJtTFfTRHCnc9Zu2lStDgPnXEU5RDX3waFY1j8HnvtE3/5jLKXEFWw2JpJ2+f3ODCLa1ugpWOQIPCYKkmwbRgJO+B/PNpYfIXpc0GaEbXrYhqppHfi364uuatDUFPFRmB40zDQyrDswsm59zmTUeBktLBOOzpxdrs=
Received: from AS8PR09MB5270.eurprd09.prod.outlook.com (2603:10a6:20b:371::8)
 by AM7PR09MB4102.eurprd09.prod.outlook.com (2603:10a6:20b:11d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 07:50:36 +0000
Received: from AS8PR09MB5270.eurprd09.prod.outlook.com
 ([fe80::d827:df54:c815:2f25]) by AS8PR09MB5270.eurprd09.prod.outlook.com
 ([fe80::d827:df54:c815:2f25%6]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 07:50:36 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Getting currently configured upstream DNS server
Thread-Topic: Getting currently configured upstream DNS server
Thread-Index: AQHY71j1zAkaKiKtPUiJExxXzXiAdg==
Date: Thu, 3 Nov 2022 07:50:36 +0000
Message-ID: <c34932cf-6f39-8391-471d-7629a1b448ed@goeg.at>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
x-ms-traffictypediagnostic:
	AS8PR09MB5270:EE_|AM7PR09MB4102:EE_|DB8EUR05FT018:EE_|AS2PR09MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b8c89b-75f3-4be9-4ef4-08dabd701914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 cSOpZluq27jMkKmU6FzOqIrizIWMQsw00NhlHGsGCTYbUMJJfAr3hN9Dy2C7+LXDaXFqtoXgKiJ3Dpng0KcvM/eKAMqnZViYdzxbNDz6tdhvPHtFUXp6D+ladAHhzhVPlh6ANr9Wmo8kQEfRlcDgp3BxXm1rOZmHuGBr2xEyUp/taLYQTTSL2yO0+yyvE4tbUBjLBxhi4Sz6z3NEw3Vw4NmDV/0D1qYuSDg/AGDojSFcqDeb6veC5ew/yrHuzHuF/Oqy/Q70aUPH+Jn5/duIxnP3BAAn9B1sWKin0xHYE1xmutpX9bjr6yrzxnv1XfHOem6epPTCEsEmOq+StqT/U2xxzC+xUX1OkjR4qVFmjzoUi1xTfQzar5RHguSQheh6KnSCabOum8dPUDUXiAkyDIKc+x7x07g6PLaSOgNRp2WFL1tcFowAsrgGuYtHC1ihlb4x7OczEiCqXlm+J5Ljcm2pZUA/ORwZAoG+558UsDh1AyvJc+1JJqhDyGgoI84IwduPf/0nDqbbNf2hUqwz7aWbYx0aAO2VE06v6mgRFA/vScsryjkIkPMQb/fcAAAz5kxhEbdrkqO1D5OtC82SAIH7gGfIr7Wlcnu/Uis0++buPVOKp493w75wpGGSoTLQnB+xgIvfmLv6qEpJyZhfgm+tLTo3JjgdQhN4P1Qfqz4eovtDIPKlxWOjq+rYlzGgX7NLUpnEfXPa4XWjFZI6jBIZq6reTH8+G46Nxfv1PzI+V8nzVFJT+uegH1AKMnfq9BAqb5FDzc/T7hm7zJWF2b+2wYnj6Nlb23NbW6lqYOg9i+4NZIYL5daUzL5+vkDmbaWdGfdlw3b8oP5AAi9khQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR09MB5270.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39850400004)(451199015)(36756003)(122000001)(8936002)(316002)(5660300002)(186003)(8676002)(2616005)(6916009)(4744005)(2906002)(66446008)(64756008)(38100700002)(71200400001)(41300700001)(66946007)(66476007)(91956017)(66556008)(31696002)(76116006)(26005)(6512007)(6506007)(31686004)(38070700005)(83380400001)(478600001)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3E030AF8E00F54FB009B78E8ABBA91D@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB4102
X-OriginalArrivalTime: 03 Nov 2022 07:50:36.0956 (UTC) FILETIME=[F5ED4DC0:01D8EF58]
X-GBS-PROC: 8nEwQmeqoarrBYExp6GMHNW9/71RDCOb6MGLMbpS0NUUhpJu4skruGbN/GDGKQN5
X-GBS-PROCJOB: ovx8mrbXd68HcOEj+9Cm8ZBlSVgiUe626MOmNrG6rEJgHnbbUKWZQbDaS+F0E+Go
X-GRP-TAN: goegsIQSUITE01@7EDEFB01646D419A948AECFA5494264F
X-iqsuite-process: e13a3393-6c38-45eb-8279-3913da145940
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB8EUR05FT018.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9db417a4-ed2f-4a44-633f-08dabd7017ec
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+vTl+pMtlaHarLhFwktHWRAGG2Ig6yIFMyKxJ/cX+dg9KyKJLrwdlw7YVXVfKwOEZY0NH1smCa2vkgzw9lugZKFGYcx7z7rXf1MEVaP6W4so1FcEym9a4H0a4671sUwaa45uuO9a5Uxkf4coNsGCXXWf5JOaefQJQYB5wGEwkq2B1BqL5Oy5HEisYwYLnzLrbPjMzA2h65STSiwyawk9+01a0+1yyKoMILP2WrCHuTay4WY+so/8kgrvZ4xrLjPswZEkBVXlMAb9+IESYxa2S9JG1hFDtNX0vERkskp8OKySDFU7HCqLpgmE7x5u/GZr/Ugp1pcH6T30lB2yCLPJK1O6QaxVEvOkoGfYBZzaSb2+TFIEvuAr5yihjTrM1M6HjrQPCcWD9+m0lixw7Y+AnobEar5TV4uZVa3C/rpuwlEULfSh7fPtEAFmHRLwQ9Z+8PJhqR+hXh6RlgpZC9Imli24V3qcvoQ/+LdN8NPFGzHkEwukTDwtb6Q1IVnHHVt5VxTkEnLfOgSiB1gcm084aXTAwmwh39PQAVBWCXsRzCVDgLJGsr4jUmd1qUm+c7fGf9X7xHOX7QoT3d1wlBnK5ZTrQjKb+V0KYhs7W776okmAoTYQ88w66uBKrfv5vMQA1qwgPOMP+jFCZALpjKJhxERZIv4YsjNkEpXLa9dacZVaG96BcnKGJpfBRIly1AKZ05pnMTT7ee6/F+5Xt2hdXzNRC8vCR+eN97sxXSbSh7OxkGfa8zMaE+ofeDPpy5fxwAolTyEim98nmvCNJB7ztPCql9e1I/OGzx6/bUiqlkSK5STGkCAgLvvj6+tbVeRmd7fBv/uqGdS9qEUxlIZA/g==
X-Forefront-Antispam-Report:
	CIP:20.52.142.9;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:goegsIQSUITE01;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(136003)(39850400004)(346002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(47076005)(82740400003)(316002)(478600001)(36860700001)(6486002)(186003)(6512007)(40460700003)(86362001)(82310400005)(26005)(31696002)(6916009)(6506007)(336012)(2616005)(83380400001)(36756003)(5660300002)(2906002)(41300700001)(8936002)(4744005)(31686004)(70206006)(70586007)(8676002)(40480700001)(81166007)(356005)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: goeg.at
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 07:50:38.0469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b8c89b-75f3-4be9-4ef4-08dabd701914
X-MS-Exchange-CrossTenant-Id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff;Ip=[20.52.142.9];Helo=[goegsIQSUITE01]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT018.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR09MB6461

SGkhDQoNCkkgYW0gdXNpbmcgY29ubm1hbiB3aXRoIG9wZW52cG4gKGhhbmRsZWQgYnkgY29ubm1h
biBpdHNlbGYpLg0KDQpUaGUgVlBOIHNlcnZlciBwdXNoZXMgYSBETlMgc2VydmVyLg0KDQpDb25u
bWFuIGlzIGNvbmZpZ3VyZWQgdG8gcHJveHkgRE5TIHJlcXVlc3RzICh0aGUgZGVmYXVsdCkuDQoN
CkhvdyBkbyBJIGdldCB0aGUgdXBzdHJlYW0gRE5TIHNlcnZlciAoaS5lLiB0aGUgb25lIHB1c2hl
ZCBieSB0aGUgVlBOIHNlcnZlciBpbiBteSBjYXNlKSB0aGF0IGNvbm5tYW4gY29udGFjdHMgaXRz
ZWxmPw0KDQpIYXZlbid0IGZvdW5kIGFueSBjb25ubWFuY3RsIGNvbW1hbmQgc28gZmFyLCAvdmFy
L2xpYi9jb25ubWFuIGFsc28gZGlkIG5vdCBoZWxwLg0KDQpUaGFua2Z1bCBmb3IgYW55IHBvaW50
ZXJzIQ0KDQpCZXN0LA0KdGgNCg0K
