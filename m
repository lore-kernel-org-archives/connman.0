Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2114.outbound.protection.outlook.com [40.107.104.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E517F3
	for <connman@lists.linux.dev>; Sun,  4 Jun 2023 04:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZtjFFROfYfULl6qvdhqx8aLEX2EfBo5Q0th73f3q1IeSIHksGHE0lgfx3Bd+ZKZ0GlXmxLBz9lcLZrsPOveq5f05dBMW9x82jpRWDxE/myOOzkxJHj8r4k67AvLWMYeCrSRe4+6obR6owN8RATaoC2hO876P04h0i4XaxHoKUSl1M7tG/mBd4gT6CkBEWDF0H/FuIM/rsOaR3toX6DG5jMp26mOSsgEn69yPq4zNEZlv0fP2YIgpjpsO9yMROrfZtSbtM2ynKafs3Xh2z7m7Kc+A8FcqCedtJi0N3ojrffqHYAdyPYLncQ2fMerFClhm3QNqdLvYe4kdo1IbnS+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8//lghyZPy6YNocldTXBmd/tsiOoptJD/00AQFBi8UU=;
 b=Td69qICW8AYiVFkmEytu5Vpsv5u5/sQ17kfVDGRowNA5IVxgTFizDvhXaircUzBIssoQ3lKEy2LqO07pILakMDflXgcxqLCSwINorinAb10LwkYl5WL7Fgx7uFnddAAiwjz9XE7LDh3Sgy0NibLUUHuncROEZVh7vpge4IuoiuQeCqciTx92WibxZ81dy0dGNF5KVugmyiS1ML1TCnjUGfjAIOOHb+WCnHb/ekX+8K1UK23OBOKN4ByrPmcvx2uLUge41bSdGR7TMc3dKTnnIQYFfGwt3u1b7JIC2RpOu6hyx+CFUZij8fKnSCeB3uWq53E0USSBOt8pSlc/tkckaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.136.170.117) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=code1.emi.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=code1.emi.philips.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8//lghyZPy6YNocldTXBmd/tsiOoptJD/00AQFBi8UU=;
 b=M4bkE/TDLJzsM8ANGzY9x1Tfg3dfGhLCD4CWASrIUQPRiCJIhjDXPPgo8Ppm3iwFxPCv2DbnEUbEJlKZRQGufLfwsIPhVpBuDgbol7Io2aJEHu7ifDA710LLFmU3SjE/fbfHJoVHoEM+f8nIhf6NMG7JsGubJEj9A/pGVeR8ggA=
Received: from GVYP280CA0038.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f9::15)
 by VI1P122MB0109.EURP122.PROD.OUTLOOK.COM (2603:10a6:802:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 04:58:50 +0000
Received: from HE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:f9:cafe::9b) by GVYP280CA0038.outlook.office365.com
 (2603:10a6:150:f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31 via Frontend
 Transport; Sun, 4 Jun 2023 04:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.136.170.117)
 smtp.mailfrom=code1.emi.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=code1.emi.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of code1.emi.philips.com
 designates 18.136.170.117 as permitted sender)
 receiver=protection.outlook.com; client-ip=18.136.170.117;
 helo=ext-asp1.smtp.philips.com; pr=C
Received: from ext-asp1.smtp.philips.com (18.136.170.117) by
 HE1EUR01FT033.mail.protection.outlook.com (10.152.0.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Sun, 4 Jun 2023 04:58:48 +0000
Received: from smtprelay-asp1.philips.com ([161.92.84.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-asp1.smtp.philips.com with ESMTP
	id 5fk9qCBJTiUUo5fpIqKPn6; Sun, 04 Jun 2023 04:58:48 +0000
Received: from INGBTCPIC6LX258.in-101.lan.philips.com ([161.85.103.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by smtprelay-asp1.philips.com with ESMTPA
	id 5fooqiWAgsE2N5fpIquhpw; Sun, 04 Jun 2023 04:58:48 +0000
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
From: Adinath Mhatre <adinathmhatre@code1.emi.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] Support to disable IPv4LL fallback
Date: Sun,  4 Jun 2023 10:28:16 +0530
Message-Id: <cover.1685721540.git.adinath.mhatre@philips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT033:EE_|VI1P122MB0109:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ec0c19b7-86f8-4421-14c2-08db64b862aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zqD3vGcrPy7+cEqy9Rpsv4c8JKS5fubb1lBNJqtIqOj0xBRB96VB9eb+bhj+NlYQwEyLTI2iXhyUQ4TSn9B4yFdNszQQ+EbeiCQjZC6DJUaOl9Zs2Y/gtbz7bILwR9JVMLPT4PbRWP8yF/QPS690vpiCGEyO5aaj4CqrGImSyKRs85in4vr4QL2XLVEITEKlPql1HYSbk1CExA+TGtMDub/XzZ3TVhBvo3aQ4qumf2PBK8bn8aqq0xLUBWCTmgYuxCXaOL+g9iJBz7o9YKI0SPuG53zNh5eHgkg3g3dFei6JUJrCIzifh5Q3oHVNtANgDzKTmQhWLXJdMvoiDxX9ALb+ERaJIle3X3nHKAx8kjpDOKSWpD2bsep92ecYjVSH4qSH6iY/sWGOVfEpdUwxAB0VXKX1WkO3lSum8eQ3mxuvRCZdDtah2zLveXvyJptSJmfOFpYvur0y+aczl06T4zv9FPqjsqdnDXZmgehB1qcLP31XgRIX7p/MR2/yggitZ/9nPwbPUpBiI5V2DMhOwk1LDpiz78yXqYeDFWTqjWEqajS/W6nTws4wTFCawzIXqcAIs2zB0yEBIqk4R1ptQwUZMV30W4TOdp7MXuPqtIUoVnAp/3DMobsmD7WYpp2DAwVi3h7w+mci7KElwwgNV0Cx8yCwNBEUN2Kw+39xBPfmAbT79OpdrPA2/y837EoUgNENVt8KB+cAqdGsxIlOmoHkUj4OHl6+yLgL4HlIzKsTB+Mw1w3HJVIgr3sf0Dtz5cTi+Rvx5jwGZicVAfOEZg==
X-Forefront-Antispam-Report:
	CIP:18.136.170.117;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-asp1.smtp.philips.com;PTR:ec2-18-136-170-117.ap-southeast-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(336012)(83380400001)(8676002)(316002)(8936002)(5660300002)(6916009)(956004)(70206006)(70586007)(36860700001)(41300700001)(47076005)(26005)(81166007)(186003)(82740400003)(82960400001)(356005)(40460700003)(40480700001)(9686003)(82310400005)(36756003)(86362001)(2906002)(4744005)(478600001)(7696005)(6666004)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: code1.emi.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 04:58:48.9662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0c19b7-86f8-4421-14c2-08db64b862aa
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[18.136.170.117];Helo=[ext-asp1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0109

From: Adinath Mhatre <adinath.mhatre@philips.com>

In current design of connman, if a client fails to discover
DHCP server, it will fallback to IPv4LL address.
In some systems it is not desirable.
Therefore, added config, D-Bus API and connmanctl option to disable IPv4LL fallback.

Adinath Mhatre (2):
  service:config: Support to disable IPv4LL fallback
  commands: IPv4LL fallback config support

 client/commands.c               | 50 ++++++++++++++++++---
 doc/config-format.txt           |  5 +++
 doc/connman-service.config.5.in |  6 +++
 doc/connmanctl.1.in             | 10 +++--
 doc/service-api.txt             | 10 +++++
 src/config.c                    | 23 ++++++++++
 src/connman.h                   |  2 +
 src/dhcp.c                      |  7 +++
 src/ipconfig.c                  | 80 +++++++++++++++++++++++++++++++--
 test/set-ipv4-method            | 34 +++++++++++---
 10 files changed, 206 insertions(+), 21 deletions(-)

-- 
2.25.1

