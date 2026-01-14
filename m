Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBD3242D2
	for <connman@lists.linux.dev>; Wed, 14 Jan 2026 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385944; cv=fail; b=s6F3TmDZg55b0lxycElsw88TPHzOTN0g6XnOGF6cDRFm0PJjGr4SIaYmsFdcj5PJK21eKMXLFl5qvj3YhY6xhF6mQz+Q6/RbIwnMPCjbdQrUnUa9wB+ocRtUuaXXigQlGV5yOuLNtdJK330mZbZ+OdId2kj0UMFAdUBlmUZbc/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385944; c=relaxed/simple;
	bh=MVVyhHs8XJ6IJdzK5l56RPOIfRWNqAv2p2ZD9P54sqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kKDCm+IGvt8C5bSMapmwm6GT96zBFlR920QwZaMdo74+Xzn6wwYD+MyjdCzSMRps/ehkjuoyQfrzKhjB6Y+IMrNK1y7jchknLw9r/IfHrqyPm5qZ4N/qI8gIaryJ14fKUFQvDI3GsfUnvKuI8AL6xmrf4hSpR/BzP8f5DXYP/hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=BuZu4gAs; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="BuZu4gAs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFxhZNq+DOk3iOEVxZsducLHaAptPjqYt2M5op0dyr+eH/4R6uWI8kWLcqK7MMv1oRM4GORUjdo9H3Ffm/FqFvaYvitHRCd5l2Egmy7MmkZeqLe6vziZ2SVysUMRKzn+q0q+x5yFExHvyXBp0Ae81TCE3nrPYd9sfyM1WLY3AvgCMKaTj/X0vSbpz6fl2QxOIjNyW606mpmV7xsVY+sxWxdvJZMXqMG8+telneKcyHk3cBH+UurhpRyoE6fK2WkUw1XXICcPAI/Wnh5IFClxDBEpXpNGhv4hlb+XhNiJ1yyRuPy8kn4YLZJoPKm8KW5Pwpga5j6x35TmRbP300uc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tghSPC6SYIZ4CQ6llHoo2HyzIe/7wzayNa9t+2K4pM0=;
 b=uW+XE8oVlyJ5bZHgb4ldejmlZZLqIHGQUNMB2HFtLScIgPXoyq9KCTTMG63PUiU71QFSKm+son3XA0IFiAkDUBAFDJpG7uHk0D6kX3uvvA7hAq61lMRe/4Jqb6FmtTAoNdRvpF8wh6MfwANfU3FKzM00VGpGzPpJX+ELf1gb6OX7Cv0a5OtKdaUbRiu6HhjiopIAxZLc9Nwhq6Xrfng3/WNPlmBsVAM4du6ARPWCa9O/vp7iNvCI828uGgCiTKLJ2kZFftk9o99yji0uxxcEnVA12Lh7gTSz7hcpjwWor0a24GW4JrmnYShV6vifzdjss/CmlYIQESEkvJ7eUFgsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tghSPC6SYIZ4CQ6llHoo2HyzIe/7wzayNa9t+2K4pM0=;
 b=BuZu4gAsdYek4yyMxSWksYIr3hk8NS7f0yEBhRqyMciY2N1c9uzyFw+9haqYN/PxRFFXSt9CFM0cPLwe9la8yZskUjrstD/m2l3bWz1jDwNZJZogtgh1+ozq1joQnwWDHvAcGRDo8LXC4e33yRDNwVpz67d96dWS0XBCnZOGYYr3wOO9eaF6FFIWx3XBaG5+umacMW3ac7uZBtTEKT7hfRxB4PXMD1kX+1Sq6pxOO5xHUicegghL3weRPWxhyAajXUAYuHLRf5dkw2GeT/gCt+n6wl1cqxA6bwJZrdSsvnBie3rWlImv4gyJEPL5xQOBtfbUEsIxhjrgIxH3e6AeFQ==
Received: from AS4P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::8)
 by PA1PR10MB8932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 14 Jan
 2026 10:19:00 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::2d) by AS4P189CA0016.outlook.office365.com
 (2603:10a6:20b:5db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 10:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 10:18:59 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 14 Jan
 2026 11:18:42 +0100
Received: from NAAWCN10001829.asce.corp.bshg.com (10.183.185.225) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 14 Jan 2026 11:18:40 +0100
From: yaming.chen <yaming.chen@bshg.com>
To: <connman@lists.linux.dev>
CC: <michael@amarulasolutions.com>, <gerickson@nuovations.com>,
	<sven.dembianny@bshg.com>, <Yaming.Chen@bshg.com>, yaming.chen
	<yaming.chen@bshg.com>
Subject: [PATCH v3] wifi:Remove passive scan on new active scan
Date: Wed, 14 Jan 2026 18:17:37 +0800
Message-ID: <20260114101736.11023-1-yaming.chen@bshg.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|PA1PR10MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 919da6a6-87e6-49ce-73f8-08de53565589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOzS8gXPz+gsCYG34kUxp7RXokVaD8dG9j6lXKr6nA84M9MSUmGMbRTG7Hmf?=
 =?us-ascii?Q?sFAr672hhoNGXRLcS4wGRpH5NnXu8+VxNI1k0wJy+NjZySpEKa1d2cbxz7Ja?=
 =?us-ascii?Q?V2OkmAuovtsYQlg4DERKxx1wOHN+Ei1uTnuvJqlOv+xI933GrKniTCLPFniU?=
 =?us-ascii?Q?NoTRoMwoO+040Vk8y7Goz69w+OtrVUo5a7vcdzQpk4TP9CCAlt4InSFAVBP4?=
 =?us-ascii?Q?EnyqVdNdBBAwzW+Ho9QmjjAnEMXE7iR7dKtTiWTcx9Kjm2gCr9mSqb2peSK/?=
 =?us-ascii?Q?rrQQ4HSsVytuuUNiHXAntwW2mGKJgwq6Z+AC/akKSgXt6L9BGSaQnOS9riwj?=
 =?us-ascii?Q?B7P+W4C+awUB16ZJZS/mGd6+VU5BJHT1HedcK9WjTF0dXL6JSFT69xXKQ6W1?=
 =?us-ascii?Q?9zvCxzoG0drzf6KcURJ7b/BwnQCa0bzV/qCWqxRw0rrvXVZfAawY/CVlSSSV?=
 =?us-ascii?Q?neAc+tv9Y9w+aLSuR/iX14NSveqn3isVXCosYRXcUFlxWsWnfqfKimAnoRqp?=
 =?us-ascii?Q?fp/xaJK9bOWd/Di8qUHQgLSWErLNT0sqr6jwgIs2D7ZqhJaoY05w15SCrmxC?=
 =?us-ascii?Q?uAehXta7aTBCIjwrdvjfnqljAm8Aeb+CBZz/air+6DSeP8eQLFGHau8SS3dF?=
 =?us-ascii?Q?v7/fXVL1pwYeBhoHNf2qR+u7MfjZpt0i111NsFxlbI6doi3mwHbPnRy0T84i?=
 =?us-ascii?Q?tRg206IdZtqq6kgpE6hJIeYhXNoax0Y7qlJUz2XpxdZdV4ak/boNKvXfg1qV?=
 =?us-ascii?Q?bZFX9k3JEsd7Rqjnji70TrpVbChni+jkUOZDs2vMcj9hqKmzIwGXqYzRFYeo?=
 =?us-ascii?Q?wxh5KXZIMSciyUaiaisFzSB9JLZ4J1xNJQtCNTH30ATI3tLicQ9IhRwkXNPF?=
 =?us-ascii?Q?2bQx5CRaxCvQXKJ4SofNiHPIO/Azy46PycE3VHGD3bJL1FbGZJlpRD6XXxad?=
 =?us-ascii?Q?a8aycJk27jWsLG881O6W/yoGTI6SkRyvDXnUeHaoqmIQwyKlogy2JlJwy+9Q?=
 =?us-ascii?Q?jDfxtcKneH33ohvjlaAo1igKAh//777Scvu6KXGEg6I2k/e4CWK8Mk2j0B89?=
 =?us-ascii?Q?hI492Rf8+IKhakzXf/754uFIzcEzm9BP4fqUJlcP38g/joZI11Crf2Jsvw2Y?=
 =?us-ascii?Q?7BzFJfDiXc+aZyZBE/qfZoXxkz3oKZkwQQq33YYBh4PQKzr0zt87y2UEWy1A?=
 =?us-ascii?Q?Z+yY/HucgUSkEopNtxxCaQ7SXtOuJgr+wEuxTRXIEzyfMRoY6EO9rMmwOZER?=
 =?us-ascii?Q?+IpUAN3PpvNOIWd86UICjmdixyaz3xJz2LaNojPITqX8QhbDFxP5Fsp8MJF3?=
 =?us-ascii?Q?Q7hHoBg5C7NigAE7XhnOVOy9R01mgqJ7+22t9QnP83lnY+52aziJFfdOAk70?=
 =?us-ascii?Q?EzCVtVhQEhMcTECawYj38ZkixpZrdww7sM4UAzkS015camgcfrrzVwtPZs2l?=
 =?us-ascii?Q?JWEwa2NwcyFGjdxg8ElxpBxEV1Qk6C6jG/cz4YL6/Ulc7KG0Pql3aro0V5Iy?=
 =?us-ascii?Q?YqzlXJD3kTYdthNeoW97yGaifKHTQ5EHZm28ZmztXqDjOqNhH8XFgOrr4LaG?=
 =?us-ascii?Q?Xo0G20JM0c9hFa0zGXE=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(19092799006);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:18:59.9798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 919da6a6-87e6-49ce-73f8-08de53565589
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8932

If BackgroundScanning is enable, the old passive scanning task
needs to be removed when the new active scanning is triggered.
It can prevent the old passive scan timeout handler function
from accessing the dangling pointer after restarting the
wpa_supplicant and wifi driver.

---
Changes since v2:
- Remove the change log of the patch file from subject

---
 plugins/wifi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 12389fa6..96c0c127 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -1999,13 +1999,22 @@ static int wifi_scan(struct connman_device *device,
 		}
 	}
 
+	/*
+	 * If BackgroundScanning is enable, the old passive scanning task
+	 * needs to be removed when the new active scanning is triggered.
+	 * It can prevent the old passive scan timeout handler function
+	 * from accessing the dangling pointer after restarting the
+	 * wpa_supplicant and wifi driver.
+	 */
+	if (connman_setting_get_bool("BackgroundScanning") ||
+			wifi->scanning_type != WIFI_SCANNING_PASSIVE) {
+		connman_device_ref(device);
+		reset_autoscan(device);
+	}
+
 	/* Distinguish between devices performing passive and active scanning */
 	wifi_update_scanner_type(wifi, WIFI_SCANNING_ACTIVE);
 
-	connman_device_ref(device);
-
-	reset_autoscan(device);
-
 	ret = g_supplicant_interface_scan(wifi->interface, scan_params,
 						scan_callback, device);
 	if (ret == 0) {
-- 
2.34.1

