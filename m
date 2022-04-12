Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150134.outbound.protection.outlook.com [40.107.15.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419B1FB6
	for <connman@lists.linux.dev>; Tue, 12 Apr 2022 11:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gp7WESPWJstFn6vZaJ/D8vkjtAzbHmk2kzjmcf4PqB7i6GO/aoRWYmcMqefMRX6Fl9bx9xAVtou48UhJS9NX+O0CQBbboHQVuI3AEnSYKMk632zKKKOLAEBdCPi2BWwDPHZczCri0ryBOX7NXEF6Wv43crKDUwGSeaiaVIEPUotC+WWmGs6Z7l/QOHDLIjnmx1cmiacr+6/1pnu7cfFeogRZcsKZase21BPPJXO7gzDxIxa+uHvkv6jXqvL2CoT9y4vETHZ2b61uK9oNcM4ACcBxnbvSBapg6YJTmaktgXmA0fOL9TDv6uTwoKzYKdye7dwSO3bAGH4JEoL3YadFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okzB1lpRgxtVAq6vRFGLZEaVhNtuLX53BxXNp7X72kA=;
 b=gYkOYmmvTxLJemd7hGDHJLtuSTOY6HUH96Bxhw2rnqyledklu7y2oS5AfmOqT2J/+3OIkjnr3IlvPnUk4AXDsl/MEysrzzFLg7NMVCfasgUw3lqP4avzJjQ+iqlpKeEf3kei9Kk4YJ34kFjHRBKZmdqERr/SGMLQWDFMuiLRzgDvvvtzphCyrX6UqDxhFvGhLaJ53UDvVtbYv6SIWC+4LVg9Ei9L8Ja9qUM0uDWtFkGDmiOJFLoU7EYEXKY6Oycu1cNDv1cq7v+R7KAhz8QgRVMrEUQaDzvqDI7QIyc3PEY4cYyhL3/e8BdsS9lOTCRZKCYj28OxbN4YuyNCX2Fbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okzB1lpRgxtVAq6vRFGLZEaVhNtuLX53BxXNp7X72kA=;
 b=FE6ApirlFF9VcddykO/rQCY0ShxA2nN0O/TIO6kycTA+ZMjAURjrTXRsRace+39tUNOKWFjyaztn6LvVz6hmcCeI9auPE2otHV+xLkbY5a0g6tpIvNH3ZRwGYFQtI7fAjf22+5iluriGiy6gVky2ZKbe/+VFa/Ihg34jL00mAJA=
Received: from AS9PR06CA0257.eurprd06.prod.outlook.com (2603:10a6:20b:45f::11)
 by VI1P122MB0239.EURP122.PROD.OUTLOOK.COM (2603:10a6:800:177::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 11:52:01 +0000
Received: from VE1EUR01FT100.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:45f:cafe::f8) by AS9PR06CA0257.outlook.office365.com
 (2603:10a6:20b:45f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Tue, 12 Apr 2022 11:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com;
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 VE1EUR01FT100.mail.protection.outlook.com (10.152.3.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 11:51:59 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id e1LLn5bA5Yo8veF3wnfVe5; Tue, 12 Apr 2022 13:52:00 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id eF3vnKrnUK8w9eF3vnTEP1; Tue, 12 Apr 2022 13:52:00 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl1llst.bbl.ms.philips.com (bbl1llst.bbl.ms.philips.com [130.143.222.207])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id BB187182FEB
	for <connman@lists.linux.dev>; Tue, 12 Apr 2022 13:51:59 +0200 (CEST)
Received: by bbl1llst.bbl.ms.philips.com (Postfix, from userid 10189)
	id B22F95403AB; Tue, 12 Apr 2022 13:51:59 +0200 (CEST)
From: Lars Steubesand <lars@bbl.ms.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH resend 0/3] Fix DHCP renew handling
Date: Tue, 12 Apr 2022 13:51:56 +0200
Message-Id: <20220412115159.2845-1-lars@bbl.ms.philips.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Lars Steubesand <lars.steubesand@philips.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b1335d99-6999-4ca0-4a0b-08da1c7ada47
X-MS-TrafficTypeDiagnostic: VI1P122MB0239:EE_
X-Microsoft-Antispam-PRVS:
	<VI1P122MB0239A2798B3923ECDBBE133DBCED9@VI1P122MB0239.EURP122.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lbA1pcnlnyWfPAUBQQOJIzwZ7eAEq7GBwSsAw8WwvgxLRKcBE7hVq258jWZE1o+20DL8ReiZ1Dr9khCammCCAwnTt071JtqBFtTiPSPFLqW9BYKAIMHm4osCFr4i5QVU53O9ecWpqKMgInOELfxI5uDgQ/qzrW0CzFEDPig/a+TbwVQn3K0Y9gINf+TevxkqQVPx9gswlQhxr2BP9TU92zOXSl6VfsVkjEAv4JMUy64Vqu3GiHXRvEJdFvKKCPzudAilWQzwkXkDoi4pW25Pm5q4IjsMIcw+8hbEfxhFz41y+giaynLaPmE114oRhodw3CeJi22h1mGfjzdBexpaigt4yUXWRJcJ6ptTBBOOWvIl/UkRvns5DCTWxaE9FDwDBh8/xb+GfmRTI1oSptnppCh3gEOM5YJCSzc18uLciCgMhyXaeBysKINNXtvT1kjBlUR+PT5UTPaGLKr0k6DPq4/0P4wuTSitK+bd0/XSRD1Wsh7TfMQZT+83K3TuV7aLHId/bcZu+UOIE2E7o0hAt03RCgNzWTEld5qpoUS3u2hVuotHVbiUUrkPACtLDTshJTcSMSsKEYXoiQUd+uHdEsvxaxO88hmlFcGmbyv4c27ok+2Hs7AKpWjfe9KTWsNo1vgAT3oXq/w7sjU1O8UVY7SjQkHWSKqI13coJ4ChktPGVemBjuFwvLkANoJZQPmq
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(36860700001)(82960400001)(356005)(86362001)(40460700003)(7596003)(7636003)(6666004)(2906002)(508600001)(82310400005)(5660300002)(8936002)(26005)(4744005)(186003)(6266002)(426003)(120186005)(336012)(1076003)(6916009)(316002)(42186006)(8676002)(70206006)(70586007)(2616005);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 11:51:59.9414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1335d99-6999-4ca0-4a0b-08da1c7ada47
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT100.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0239

From: Lars Steubesand <lars.steubesand@philips.com>

It appears that commit
58d397ba7487 ("gdhcp: Avoid reading invalid data in dhcp_get_option")
broke DHCP renew handling. Fix this and add more robust handling
of DHCP options with length checks.

The patch
[PATCH 3/3] gdhcp: Add unit tests for dhcp_get_option
some minimal form of unit testing for parsing DHCP options.
If not required or not desired this way the patch can be
dropped.

Lars Steubesand (2):
  gdhcp: Further check invalid data in dhcp_get_option
  gdhcp: Add unit tests for dhcp_get_option

Lauser, Simon (1):
  gdhcp: Set packet length when receiving L3 packet

 .gitignore               |   1 +
 Makefile.am              |   9 +
 gdhcp/client.c           |  11 +-
 gdhcp/common.c           |  73 +++++++-
 gdhcp/common.h           |   2 +-
 gdhcp/server.c           |   6 +-
 unit/test-dhcp-options.c | 365 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 449 insertions(+), 18 deletions(-)
 create mode 100644 unit/test-dhcp-options.c


base-commit: 4c25afef72b40c71e8f9d242e6677fee0aa020a4
-- 
2.35.1

