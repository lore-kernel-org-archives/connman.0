Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB422BEFF5
	for <connman@lists.linux.dev>; Wed, 14 Jan 2026 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378060; cv=fail; b=UFGMQP2a7vgAoucULuIgyYZv76mVdqE/8gU0+INn3+zcttbiDw0NQjeVtvLBJQiz2gi37VO/5hSKdFXBQc1E8JBRRREyAFYeBnw1TH6x028I6jRqa2XYntO0gV2In7FUik2u4w6y7zfUun4OJfWQTB7OWY7mfTsOQkDMKvZ5MQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378060; c=relaxed/simple;
	bh=LSYaVCBS5Gn/UQp2juObTvUDuoZtl2kC2j7TopJ0PsU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+LUBvrC+d/vbhYy1zy/yT4RIqKC50tAfWbfdYPEjrKTOjkPqAYg20DwrR1PWUYyum2/1K139B0jB813N/IsWu3sRpyOSD3yI3iXmdVwzfcgDggOg3VxI8/45pK0LLPyTZRXEey7AeBLOKQBDzl6NsJn8SxlOBGHN8EKxFjOEZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=ZTb6QScI; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="ZTb6QScI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW0bTL4vfCtQqURhwxKH6RL8FJyW2H3PscG9PTRNA2lAS0MGQECYXHUKrNlNM3TfsO/q8WMk83khwAr43c7kbOd9qYI+RktRWsUGTz4Kybi/p8spQr5zymdau4OFyKj+G6a+DzY2xkpUU0Y0hn3H4NQuBu27+gcvztj7MmOoBahxsmcg/9WGuC1ysttd8b2kJxO1oeb6oDL20p9W6nTOyLfB74xr1E5Ale6ikViaZT05Rroi8DNmOFr7wbbFXm22otv8owT92CLv4rMDmeH52NKnq4O3Vo/9Aac16WYnB5Iq78H+kj+VtJyMWc3hf61ty4cLHnevUFPrwrQIkjGq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5LI92JOE1JZS0cJvzU3hekbH6Q7kRysD+ax6UMIh1M=;
 b=SExS1Q4Ur1C4cf3sV9LpanRf6uq+QIYU0L/5U+q4HWYGUzQjgaSj0C6Uc38mEYx1iAZVAYisnfz68ZMJ82EOGumzTYgdqp+4VPYaQKpOO5u3sHVsictv85sqz1Z2Coqk4Ovl4ZBoIZsnhbbIMTHmEtyVvDcA6Ir8k0RgGVFe+TLg23WKKvKS19qjLtaquSkPuPHCQ0WsTPSu5eeF+44Ut4IyPIottIOlINHgtJ/XizqHkfwfjMLAEwqWb2bn3FvzZIT+diszwyq4Uhj03wsmgDdhvaCDXOoWJKHbRlTwA6Gbew8YiunZI6ZP1VFIbMu7TJvv8zKmxLYZOwdyywRReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5LI92JOE1JZS0cJvzU3hekbH6Q7kRysD+ax6UMIh1M=;
 b=ZTb6QScISOVBkqk6vLTOYxYFQ99QsfdDC3h//L32vLe1TaIktUl7Y5Z5Gy3Dd0WXjK7zcFK+fiY+DPRxiyMs30Wj3GlxzYCnsvXoRQrZ/g+YMgpeA3am/ltAHgFmxLmbmNwzfhJDz0w4KHQWRDeUDZEa/6l2bDh48pLxAjHRFKVoj+ooB0Rgc28SraCATLYI2OyWdKqY8gZK0KYK1M212id3Ch8b/S8CD+asC66UWVPUrhi9NsXNHMiZLIp12519FoHOAdblPi77w3C8/85Hd3kftU7xsbbmUySWY0SOMW3ZQZxA1lFQtVLhAwhNAkKak+1Nv5O90UXXCYgWIJqydQ==
Received: from AS4P189CA0054.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::18)
 by GV1PR10MB6730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 08:07:29 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::2a) by AS4P189CA0054.outlook.office365.com
 (2603:10a6:20b:659::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 08:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 08:07:29 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 14 Jan
 2026 09:07:22 +0100
Received: from NAAWCN10001829.asce.corp.bshg.com (10.183.185.225) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 14 Jan 2026 09:07:20 +0100
From: yaming.chen <yaming.chen@bshg.com>
To: <connman@lists.linux.dev>
CC: <michael@amarulasolutions.com>, <gerickson@nuovations.com>,
	<sven.dembianny@bshg.com>, <Yaming.Chen@bshg.com>, yaming.chen
	<yaming.chen@bshg.com>
Subject: [PATCH] wifi:Fix the crash issue when restarting the wpa_supplicant or wifi driver while BackgroundScanning is enable
Date: Wed, 14 Jan 2026 16:06:41 +0800
Message-ID: <20260114080641.8184-1-yaming.chen@bshg.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|GV1PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: f6355dcd-1e65-46a1-b2d2-08de5343f68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YFFuprb2wZenP3pWvabjsQvspQxqWyUdQK1r03w6Vl6XQ+eA56rmnA8IQBsp?=
 =?us-ascii?Q?Y5c+FGiXvQT4zU5/nalbVE5I3frTdJ9X/waVgIzPjfV3vqvZMun+sIGUfNjl?=
 =?us-ascii?Q?E5Y+/qFdCxJy5OEv/Q5atcxAq/bWTJ7F7Ox0AMAfr+64xnd0Z2sL7MzKyzwl?=
 =?us-ascii?Q?y3LSR/TzRYzJh+RrY+KBv9CC9H8VuD9la/sHrfDLSRGKFnLoXNtV1PwG9ABf?=
 =?us-ascii?Q?G9u4IZmQNbp3R4Vx/jXIAKrdJebcXIDRl8u+mQV8DbNE6EYGr3cmFXWFaL06?=
 =?us-ascii?Q?2oFerrxFdAbRCmKu4rgwxoAPmWxi6nHSTQOMm8BjOFGRXTAhKbX11dN3jstf?=
 =?us-ascii?Q?+ZxpYgaIau6U2nMfDct42CA1oSJpTFVkHeYrHp+kUGPirPgUnxNiF+Uke+NV?=
 =?us-ascii?Q?jkvlZeIgsH6cIIbuOl4q/miLL+zraSzh1CyeFYh10l2+/+bHNvSZn/fGVp1x?=
 =?us-ascii?Q?Sh3IB5LJeF8oCtnTvIQIpmxOnCOipmpAfEERriErLlQFi6zt5VRAaYqyfWXZ?=
 =?us-ascii?Q?bwEUSioaMDeiM0U8PgT1Bl1BRFEGz//JtuD3+A3P2WCrdslx/BN4I0y90+aN?=
 =?us-ascii?Q?lb6ICAL2ZTq1lqMk6v+2kbz9s4RiWEAmir7UOZ2hCctJYw8ug+vVSGyJnXfK?=
 =?us-ascii?Q?9KaV65sewm0/sYnLiMwdOpwL9JauCnPh/VVcoGwmnWm/ZXeIZMT9SWH1sn+k?=
 =?us-ascii?Q?7V6fc8XH/j8IeL7h5jVFKJbfgxEAbdzx7cFI+VUeZiqs9xg/y3klKz57xaZc?=
 =?us-ascii?Q?e3hAww+JJ56fxhbUKI3jyImypzhgpDkG3pFhIbl3AJGICfnYEcq6zSv3NJeA?=
 =?us-ascii?Q?uneqSH/nSqK2JJKtpYUIV6NgV5ujjzCum8zkS3l8GGU1TmRSufaIRQj7CBDO?=
 =?us-ascii?Q?OUYi4fBgft4JUKN/7IrxC63n3024kTfBGZw16/7uedLe3tlItHgK1rG1XYnp?=
 =?us-ascii?Q?TogpXdsC4puXOawoZNrW9K5rPkRU8bHxoDF942YZSRlXSLGfUBUWhL4DshUG?=
 =?us-ascii?Q?RI14E2NUYr8xC5gfcd/25t70AIwvC5QQEwlXvT8NvPs10dWs4mYdHJ132kLj?=
 =?us-ascii?Q?f0hclp6I1vL73f+SCxEooegpFyTSIn5/7fklTxfKluEnGkpORnSnrbje4q97?=
 =?us-ascii?Q?XXHp13UrRwwXpqmVhV7FAk1NMC1I5+mww2YFeUGXlMB2VAUFEQBLLJrtVNwq?=
 =?us-ascii?Q?cgzUc0Px+Qh5JsOR7LyRCFZxg8TYgYXPN3/AyUwGb75QS7CCq980tKIi/rCV?=
 =?us-ascii?Q?1XB1PgLNBQdKW7Z8s4yjLuqr81ZNGOW7yjMN80OaNH6m7Zxr1uBP5FNd15iq?=
 =?us-ascii?Q?167ZdYB6HjfXjnsAGp1FNsQyacaSCySk2Eh2gzpVu8UYt6J0+vc7iySkXbG0?=
 =?us-ascii?Q?OqdYjC2w9Q1aTq09wq47U6SUHYgb+H70sF5DIkDOQu6cVztKoH6on38W+QT9?=
 =?us-ascii?Q?+tqKuiTcZwgyAK3jj/vH17e4XFDWnY0+FaNNUd375hdC7LYaOKx7PsLKH+CJ?=
 =?us-ascii?Q?j5xFtBJ8oVOlhujv/Au81F7Sa3l24xHRgwV7VOfPVGdcoW1SAaBcjssREs4U?=
 =?us-ascii?Q?gK6As3+eA+sWTrzI9kA=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:07:29.6658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6355dcd-1e65-46a1-b2d2-08de5343f68b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6730

If BackgroundScanning is enable, passive auto scanning timeout work need to
be removed when a new active scanning is triggered.Because wifi->autoscan
and auto scanning timeout work will be receated for new active scanning, but
old passive auto scanning timeout work is still running, if wifi firmware or
wpa_supplicant is restarted at some time in the future, old wifi and autoscan
objects pointers will be freed, so wifi and wifi->autoscan objects pointers will
be dangling pointers when the timeout handler function of old passive scanning
work will obtain wifi and wifi->autoscan objects, it will trigger a crash of connman.
---
 plugins/wifi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 12389fa6..191c4fa0 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -1999,13 +1999,25 @@ static int wifi_scan(struct connman_device *device,
 		}
 	}
 
+	/*
+	 * If BackgroundScanning is enable, passive auto scanning timeout work need to
+	 * be removed when a new active scanning is triggered.Because wifi->autoscan
+	 * and auto scanning timeout work will be receated for new active scanning, but
+	 * old passive auto scanning timeout work is still running, if wifi firmware or
+	 * wpa_supplicant is restarted at some time in the future, old wifi and autoscan
+	 * objects pointers will be freed, so wifi and wifi->autoscan objects pointers will
+	 * be dangling pointers when the timeout handler function of old passive scanning
+	 * work will obtain wifi and wifi->autoscan objects, it will trigger a crash of connman.
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

