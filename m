Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130129.outbound.protection.outlook.com [40.107.13.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8192594
	for <connman@lists.linux.dev>; Tue, 22 Feb 2022 09:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7+jp9DOH7Hvtw5fBbVQBBz4rQKIjVAQfj9gLiLTJdZ9fS6lOlt6zMA3VHFc4RXBYYxtRfhWXmb/xIo6HFToVOlKT8uu21CEaMjAE0MPDY29DxJ/ZPp17ca9MIuWH5uiumN3HAkkzuYoICb/w71qrd3y3hi9BblZt6aWOSGiENZhtNbuJrq11ZzvKwueapWilAKAH6SjtAZ9IfmDvdhhtfLO0+ym3wth85IP99sMCUQZ+lHPnZKNckk0oOncmXZMHpcFMsu3CInE57NqbJ0iW7u+GfDedmAj6fdfKN2rPsIK+AGEhxm6MFOEj9SbVJLAoiKxedFJRAOnZAVc6nZrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjkDVhkYKwdtbldO82d8P7foDrTJvKdy30A/Bl+Zod4=;
 b=LxtdtVC/DobW3GRivMkTthRXgBduhocDhkfesyVZY+q/cC0X30aHLG5YUX7akSCKOHKpKh9oWoJXe9jmdzsSTRgpu0Sa8Tv6hdfUY8GSryHKi5yhXWbOOZ183kkj7cX8yo/i7GsssYXlBBQGu8h2lYf0LveRb8IIYHwkdtxhPSaspn+u/i/MhRq97CRfWhZUDh9I3vfJeGwpr3RHtGWOZLmpSsRKKQAICELGcD6wCI8MJQchtCy9uf5mpMWQQj/ibD5pP0b95looZNgrk+SdxAyemTnEwdVJHl6vC617jVlGC+4B8vkdPN1BS0qA7mfTQ9Ckg1HTatGyqGZ1cSvMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjkDVhkYKwdtbldO82d8P7foDrTJvKdy30A/Bl+Zod4=;
 b=J3HMCFK+HTsC/IOGmSp0CevIY6aOFWBwkGrqJsBL1MfJgFq2saos4D4+hpjNDoPJVOCXhorrrKz7qAXjclqkt7Id3Wa0cC41L8IlUm8e083yl2TCEO/uv7+HoORFqOsPXduwbsmajUPkpDPPtCZOasA4xL/IQcpn0Lr1XEHxing=
Received: from AS8PR04CA0094.eurprd04.prod.outlook.com (2603:10a6:20b:31e::9)
 by AM4P122MB0084.EURP122.PROD.OUTLOOK.COM (2603:10a6:220:1a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 09:11:30 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::3c) by AS8PR04CA0094.outlook.office365.com
 (2603:10a6:20b:31e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 09:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com;
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 09:11:29 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id MLOGn3AOWTYquMRCjnmF65; Tue, 22 Feb 2022 10:11:29 +0100
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id MRCjnaoXnK8w9MRCjn49GT; Tue, 22 Feb 2022 10:11:29 +0100
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl1llst.bbl.ms.philips.com (bbl1llst.bbl.ms.philips.com [130.143.222.207])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 55BA3182ECC
	for <connman@lists.linux.dev>; Tue, 22 Feb 2022 10:11:29 +0100 (CET)
Received: by bbl1llst.bbl.ms.philips.com (Postfix, from userid 10189)
	id 3A617542247; Tue, 22 Feb 2022 10:11:29 +0100 (CET)
From: Lars Steubesand <lars@bbl.ms.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] Fix DHCP renew handling
Date: Tue, 22 Feb 2022 10:11:26 +0100
Message-Id: <20220222091129.29525-1-lars@bbl.ms.philips.com>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0506ddce-98d4-4ee4-78a8-08d9f5e34ffd
X-MS-TrafficTypeDiagnostic: AM4P122MB0084:EE_
X-Microsoft-Antispam-PRVS:
	<AM4P122MB00840AFB590DBD95B8835492BC3B9@AM4P122MB0084.EURP122.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nBLgeeD+cmlRDH94uO5mTGDlRRhFdAP+XbRCXcPA+hgBj7mR0JA/ZOf1ar9357BN3/DjFOzz02MWahY4YbXiHp/KjfsD5VZMu7sPiTG8lEhNEtZl4fZrvWrli+PSxM8ygzC4owUqtzzk044ImuTyz9lhjfTdPDlSj+DrQkg94VSRcYveXVrQ91yje/gfMIt/rXdyP9ALBnkALYXPWazgvW6snex60dLvHihyRYrwc6tRxLDaNZKix4PskRcvmLkbAzQ18yeRc1uX7CxIVkViiGRXzPNBKIN8YxpaP97XRkEYyA3ln7s4AjW5L+0Eftt6xplglApBGCLAZKkEJtQzJsoCXZ0NZmzuzyD5hck/DVvPju8ZTyKjGRZGgiER8F/7EiUUfNyAIy01A6SbyeaqXuuIf04BfVCLsQZxVzYaFt/WjWDoLNgEyY6y8wVmRoDQ8tE36FOPbDZjRyklJF6MH6qInry3ZWRd5gTqcSkq2p2bj5NwWPnTJOPvRIFSTNpb+VictchZsz9sEz8qY083OSmylHi5UptL7dYVSDWxVz3Io3sxZbXgnhB8cbQZHG9znUq/+1tKxGZ6Mf/OdPkoACmoFyzB3DvCcscJ5r19ZPwXO/+EVuQWeBwXzF1kls7qq2aZ6tTYwjJW9p4SaBjo4lBw2bcusz0F0hG4aIB86NVdBJ7RdXjVWYiZehauerlh
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(6266002)(1076003)(426003)(7636003)(82960400001)(36860700001)(83380400001)(4744005)(40460700003)(336012)(47076005)(2906002)(2616005)(82310400004)(8936002)(356005)(8676002)(6666004)(6916009)(26005)(316002)(186003)(508600001)(86362001)(42186006)(70206006)(70586007)(7596003);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 09:11:29.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0506ddce-98d4-4ee4-78a8-08d9f5e34ffd
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P122MB0084

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


base-commit: b335791af9194d1bd7b9821f4c5abc5405109557
-- 
2.17.1

