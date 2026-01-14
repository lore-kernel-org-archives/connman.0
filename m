Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A362FFDCB
	for <connman@lists.linux.dev>; Wed, 14 Jan 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384110; cv=fail; b=HE5ubAQsWE85hv6hVAFT08I1DO3LcDl00WA7yRZNUP6h1+B540fmEHhyJuDHMLpzlUUfhLcAZa3Wr2n0tMU93bsauPSar98Es6Ebb46fD5ib3xTzzDhxWslVtbCT+YYZyFLoTSTVXMWN80jH85r81kIKUWekkN6gcKswdlXECUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384110; c=relaxed/simple;
	bh=XPwYTDoJW5JGN7VToY+N7gT/L1TTWSrPopGb2GMYO+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t/aA2FuuaUoyIZqX+yyQszWLrGXiMFNiUkzT6mWbkjH9XD0tc5MbEuajbMbtVfVOP9uArDKpPUiaw5G6ddNIJDoSfrWQkkjAxO41bSaklF63R3CaExApTB7yEEM+yFARPoneoGiN2s6d+Gi10xSz06+c3OUZjv/uwxJirfgGkEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=LLigGe8X; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="LLigGe8X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahQudFT6qirgCWRBm/IXHAXqxZe/Ki4mKtTtdsnOP4h0CFKwgUveIRBXPBRDyUAY6AZlxDtLb0G6QHoZre1O4ICOqGcy9bWmKK1hY2aBPeQjpLLdXO7ETxc0vuw9pMu+B1pRqtMF16sIzkgUT1PIL04lvVeHT2XehCch7Vnu28SWben7dKf1fhjwkVBn1zMKlie2c9Laaf7Ss7I8uPRg8swdbuvnWIpythCkpNrbKSEWv0+BpCr2D22IePj8a7+W9Bn5BSvMjZzDHxZl44mS+yYEH0GxyqUPsFJ73qf5YO1X5nHb8PVw0hAXkVkxc/1SkJUST6k1uALbuOqYLPrnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GElfJ1ofSTvC/iwiSSqfA5VE8Jl2nyNs7+x9EmXHxg=;
 b=MotoouVvMP4avQX21puuVplpDK9xmHX/e0hCdEVya5+6mQFej6EaZm89nEvRN5+F/+C6xf2e+jEg3318LXML2jlUZxFv4HSJ2Vj5b+t3DJCOZZ+nDs7dq4AZJk8ucDlVozG260o5F8MvCX85bAwsffb69uo3SZc55iU6n1NRE5pr3/322nvTbsnkZSPd3HyP+Q3CaNjn50Uv5yhaZ37BNZXRF4Au3o5HlagmTtyHNZYNpXEPHEQWNH5+BPRvLOplrdSlYC6DjA18k/vYVLcYQzlnoHH2mjiVZOf6LXdqIExsXEwpoA+8jcJRb5hdeJIwbDynA/D88AYYeMfb1sWtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GElfJ1ofSTvC/iwiSSqfA5VE8Jl2nyNs7+x9EmXHxg=;
 b=LLigGe8XVIy0peRWHNUHXDJrq1g9T/OcS7lIFx4xWUotQRcXSEYXxZqjeHtP13wcxLcymcaVqWVDXh8MEVanq+TyAER1yn7kglSd/sM8ixpcDyqd02pbHOvVZrzt4KaiNGznfBkmPTO3hNJ174T/VR5WhA5XpNBdpxzWZXalfIL5Ik1cWV7PYzrnYNc1WSAWXmTJ6lH4Sk+dvbLs1V31i79DWQMG86fAbXVYBSN/BrDE2z21HPKLppvO7RPODrwrBmVw04NUSugsOJtIe6KymyU90GyeNgGt8pkwvE4Y/cNrxemBG5Dh5/LVOlAPQAVaOmF+tmyLo6pg/oIj7wFmzg==
Received: from DB9PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:10:1da::23)
 by AM0PR10MB3233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:183::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 09:48:23 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::ef) by DB9PR05CA0018.outlook.office365.com
 (2603:10a6:10:1da::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 09:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:48:23 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 14 Jan
 2026 10:48:11 +0100
Received: from NAAWCN10001829.asce.corp.bshg.com (10.183.185.225) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 14 Jan 2026 10:48:08 +0100
From: yaming.chen <yaming.chen@bshg.com>
To: <connman@lists.linux.dev>
CC: <michael@amarulasolutions.com>, <gerickson@nuovations.com>,
	<sven.dembianny@bshg.com>, <Yaming.Chen@bshg.com>, yaming.chen
	<yaming.chen@bshg.com>
Subject: [PATCH v2] wifi:Remove passive scan on new active scan
Date: Wed, 14 Jan 2026 17:47:22 +0800
Message-ID: <20260114094722.10158-1-yaming.chen@bshg.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|AM0PR10MB3233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4824e25d-49e9-4cab-8ace-08de53520ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMXAgZkYWpf1AlQbO4kfcwYGS48b+Zka7XMetmJho9KuqX9Aaz2wRnUOv71G?=
 =?us-ascii?Q?s0LIs7hRhDpIfinCVBb7DjsY6K+tqsvMZmuTXg9r4r56cHUN0NTm+NV6+TLM?=
 =?us-ascii?Q?At8BJyudjGrNOB1P+SFL87fxP9iVo5nUOkktWVGmkVLFuNWpqg+9JM3KpQC/?=
 =?us-ascii?Q?8dwBjfwWkhSVl9VT8//xdWRZiLL1vPITM16N4WWF/oKnahYjn7BPhfQNZ2GY?=
 =?us-ascii?Q?dFxUOEPyFcdvgCY7/NJ1iJslw0FzS5exytfLMIf9xlT+fKEDNaNeq8RYiK1A?=
 =?us-ascii?Q?9HvwQ9/QaUIAR2goM2OMZG0hQTFdi64iBkY72ILDc9MnqDmT1egFwhkY7LpB?=
 =?us-ascii?Q?zxmE+EG78uyqD8BnerSmIZNvcNLTw78I9J92v64YdNJ2PAbVEc/qLz8BKdI9?=
 =?us-ascii?Q?c4ppxbj0mEO1LTRqNZwBNeLSF6XwT8pQGevX9xv29CV9pEWVv3JGaqyFG/OZ?=
 =?us-ascii?Q?vg03ze2jcntmrnfuXcIlWPxVPrdpyql3w8fkxBYRJD73do0y4Bpzi5LOiJwJ?=
 =?us-ascii?Q?yWxruUPnFXl5kGrhvTV8s0jGyVqnREKAMGXLnfYfWazReyR93zQF4cvypDw5?=
 =?us-ascii?Q?JDQlVE3p2V0nVP1ixfBjIB4qLUtH7cZ/cxvWngJ7BAvBT0lCexHBXfWylxfx?=
 =?us-ascii?Q?vPYibhhmVKH+rpu+lTQxvZDs54YIuV0mY/idwfOmQZ5Alm0S53WStgc4r7el?=
 =?us-ascii?Q?3BStj4/lWwyUtY2M1h0RlucO0mv/4L9jEwptXsxVJewxLWrYwP1jYG/8ybpT?=
 =?us-ascii?Q?AjB26LuSDup+HuEbdGhYfnEKKzuDpqsRtmj0vn0o+dhNUmajGGjaAMqQvgoi?=
 =?us-ascii?Q?pcO4w8P0Jynmk+ftZJvUGAlKdVEsjASa3ZPn/x5DORIeEqWmxhhCTvDNtW0h?=
 =?us-ascii?Q?fyHftseZ+TZZ3ps0xwpPOQUHnsjpvv81KefJ04B2ND2LFheiXphIiHbeR4D2?=
 =?us-ascii?Q?m3x9ow0rQBHjLEuk7O77QrzVvsRG0Qn+TRmY4WzqUgp5dq6dMyL41PFNj5IS?=
 =?us-ascii?Q?L7Nb3y+bMG/V/j1/3k46KnzC/ScsuMtiYS63yuqVreoxw+aK+TyYbPCyisCy?=
 =?us-ascii?Q?mrbl+kE7W7IVJA2oHJX871VxZ0S9id4NHa15ETuMt0eoCiVgRqH4gxF2ijDw?=
 =?us-ascii?Q?q4HQV5BVN4okO4OreOHp6kEDRqtNjXAW6KQnsVLnZ8nrtDuK0tc8MeMdGHcp?=
 =?us-ascii?Q?qY9AR0PNs97rRdN4HmHWetu3//YfhCiKQ+luM1/9Hur2T+yaKNSe4C0b1Hbt?=
 =?us-ascii?Q?Ln7GVvDUl525l8k1+Z/MfIxfSjQ5hCfkYeFnGWT6bvAG0O4QeoZZ/8CnbAV0?=
 =?us-ascii?Q?bcxatxPuDJuALOVMdOB7bmFtwS5uxnNxuilLwVbxrv6bU7BCaVqcSD2a0K9l?=
 =?us-ascii?Q?Pueem2Junuphi/tTyIiRxUcvUHt3wAZ71i+++NX7VSxXKMmkofN/UOVQTcQf?=
 =?us-ascii?Q?a4IWgh0p90R6tmzs2MA8CrNEvkQgUmFV6t/4yyj3dE0DK5NL4+juC///KOWF?=
 =?us-ascii?Q?lv6+uCzJthe90DXdHCbMGiInCnFAq2d+vxDPNXBdX8XzuollhrupKEVTr1HJ?=
 =?us-ascii?Q?rOVRJSX7Ott2u4romGo=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:48:23.2332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4824e25d-49e9-4cab-8ace-08de53520ec5
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3233

If BackgroundScanning is enable, the old passive scanning task
needs to be removed when the new active scanning is triggered.
It can prevent the old passive scan timeout handler function
from accessing the dangling pointer after restarting the
wpa_supplicant and wifi driver.

Changes since v1:
- Shorten the patch subject and inline code comments

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

