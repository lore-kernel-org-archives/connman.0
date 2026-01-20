Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB7423A6D
	for <connman@lists.linux.dev>; Tue, 20 Jan 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908862; cv=fail; b=GRautxUFFl51nG+5RJ7LN3Bhxb8WGSWVZ4vMS3w7hudbUe0cnrDORaQZ8+0yh9zIIkqAf3Q+ZfgucIpTSJQVPqRMZoW2QCpMGabiTYoGa+GQk/8iqtnUQIhTuXDyRWYaHjUDDedhznsuRhAHBDIDW30W8VmETybdWQPSgyPqx5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908862; c=relaxed/simple;
	bh=ZxARfj5YfgRj9Uf10DgEkULFT4WBdus6A0sfu82OOpc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DuOPg4ot6FN462fsMWcqQUNFWCzZJR4oOU/zPUFbIn12quz+L7r++upYxcRB6jbs+hgt5hLlCsfGVQOWiZDNBi78rfUFFyxpasfCpnNm33b42pJa8EsYJryelZCpNDi+qyj/XwY7MGKW4lpraEHhTzAt6HZMF8VdkooGorjcxW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=BMsvvja9; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="BMsvvja9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMn5wpKsCTGKvvSwhioA2Msjrycq81DYHpO9T33NrTUUPc4HuY3kXCFV/B+SvtsG2Ln040plHV7dOlZuozpodCqY22hDVOxlBV1uA1dQsfTLwpG0SIg7adxHa2rBu6N2VfrXsPzlwLtbhXa1oLcXsY4x9jHQ2X3lfNvQkQgCltSx71S4Zr6LrdcOJaW/iGsjFRCOn9Ei8+yy1yuqkpdp6p459noM0EmNugQDCkWwVoQ7cJtdf/+0xbXm8EN1LbGLyQg5N2C5+/S8l7Ggti+O0QhewjQG4Z1ZoirZAg+UEmEOFlbv3w4Z2lp/TSzpiboSnXy5IvRBKLoKswnZxlQpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V6FgH72+9bDOR2fn0BbzZYO40EILgfRmN52uX15T6E=;
 b=OuQuqNpwhuPaXF3UvArMOTtdHIva4Bw+weF2iwEGxtdon7jhX4bsnQN8AhMhKqbBW4ucX6NzaomWhZDzRGmH68OepgceU+bDEyRYXzrNhC98mYVm18uaTzoKiSXRTtP1eCBM3lhvMQ8iRjcLQXu+pILAANN/VbEWxEla1OGZmPKLQURg9V6C0R26GjjU6N2+8TW0hweKwt+ivGS9BIydTiVsbMNvZ1ms5OyW0YVtM0UMlshRV+SzSmxAfBCRJkKhUC+/Y0nnJzNddScLhQT8JHlp9wyQ4mESIy+AI7YpcdDx6vlm8RUV9IY7rLjgVZgfbIOsW1/w3wwWE0j8Whonnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V6FgH72+9bDOR2fn0BbzZYO40EILgfRmN52uX15T6E=;
 b=BMsvvja9w7NVRFAHbtCRMoliPOmVxCg49FLW3nhdlRIJYxaWpHz2GHAacxsabVASEU0sCNpYt4kyc7BdYuzdmp+KaX/UQOnTkByH387ZgnX87TqC7VapfapizViXXuzlZ6Ag80+MLiMCBMazRoG3WgQR16Ycq/h62MILgQxNkYwmsUyPffLkxgfdmoi4d5q827vIQCg7J3iXKbP2h/FUYt/BbKScgr7sD01WT/ggUI16gAdZpiRSgPjiF2LeSYY153Ht9NStADVQbdgyRqil5Vuc8MLdm95DOEsCwg2f1+G5V7TjGQ8tb3mxLaRDnay06oQlOGtRK6fA4pfep4meFg==
Received: from CWLP123CA0258.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::11)
 by DB4PR10MB7469.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:34:17 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::7e) by CWLP123CA0258.outlook.office365.com
 (2603:10a6:400:19e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 11:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:34:17 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 20 Jan
 2026 12:34:03 +0100
Received: from NAAWCN10001829.asce.corp.bshg.com (10.183.185.167) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 12:34:01 +0100
From: yaming.chen <yaming.chen@bshg.com>
To: <connman@lists.linux.dev>
CC: <sven.dembianny@bshg.com>, <Yaming.Chen@bshg.com>, yaming.chen
	<yaming.chen@bshg.com>
Subject: [PATCH v2] network:Keep network->connecting true during wifi association
Date: Tue, 20 Jan 2026 19:33:24 +0800
Message-ID: <20260120113324.1669726-1-yaming.chen@bshg.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|DB4PR10MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: b474f1dd-70ba-4e3d-09e7-08de5817d896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kK4SbgM3ZkwCQtcF+JY7guzBIHW04mglTDBuhqClqJF3bvY58c7RB55S5iQE?=
 =?us-ascii?Q?w0UWq23PnlU4/CkN4awshma+CKMVyfdVWTHrObSkjmbbSPXcuZec0W/j0SHs?=
 =?us-ascii?Q?3aJ805A87QH2CnVyhCQY7cBH0bJUFa9gKRY0NKeWrxqxO1WPRmRjgdPSn8zd?=
 =?us-ascii?Q?9v5v4iZI9arkXfrkkUOszsa3eKcXQ+9LyLjsLnpAjOjo5fRQDsvqnqgJhpl8?=
 =?us-ascii?Q?Al52nW/jiqDkzUf29aqKlsDLPdMf4RqDKhrpUqT1NGT5ksmdTQsn/Z2/WqWo?=
 =?us-ascii?Q?RCBOp+9XY9Lyxtnlp0VstgXzXHK3G41KrU2xRlrn4hOL/q3irEBRN9/pT1AN?=
 =?us-ascii?Q?ZAvYEqoVgMVQfqTukKmdNEXOguqQTneqlfKgw0vZuAvYwEgdRNVnCjS8Gaol?=
 =?us-ascii?Q?6iNbkrDNV4xGdhdJjmzSkuqVOxmiPPaNampTvdnSrolMYKJC44sZkDcPEMX9?=
 =?us-ascii?Q?sIShiqy3DPUi7LBQI8PFo0F6GWxSWg80I+SEUVUE/iY/fb3pLCkwmJ4WRoVU?=
 =?us-ascii?Q?l6A91GfoyYdoiXNs3P+YY54lHKKg66zf6Dpzb8c1KxhNPBsVWSLc4NUqMUTo?=
 =?us-ascii?Q?PMfXtMBphp7/gg6F/atrcTlSDxqLjdrFMW2X5WoEuVOeruF+D7DXKydgW29j?=
 =?us-ascii?Q?dOeH1D0rtInZX4piunMh9AUNfqxVYQcyfe2PAAyj5CWDM9DjK7yeV5/GfkFQ?=
 =?us-ascii?Q?Y2II4HGiExXLtph4dUva9VdM1/esT7PjByhmKxd/ILES4jYFxtvvSqRPUIan?=
 =?us-ascii?Q?XxQ/QmJibququvTQ8tm0F4vZOd04JfkO+BrQjKmVDfGmRPmvIsVM3vkOiuum?=
 =?us-ascii?Q?E5K3/1dLM7TgksUDCyJ5mQ7VCeJUSu3iDqpjWZgyiX64MfOw1GFTkGq29jBQ?=
 =?us-ascii?Q?9YRNyDGsHMBPX/nbKP2p+MHD6Y2dWNzO3C8K9L+7CgUSmErpXpJd21xRkbo3?=
 =?us-ascii?Q?2UqwZOXqKlZJBwjzDBHXaAZar2OqPoFnrByn6rtu2ZSB9jOUpNz70oul0FDT?=
 =?us-ascii?Q?42QOWk2eaWMl6nKOakY69vknFwP0bXNKBT/Tk3W/8dKfYcCQertXcMxkZxhL?=
 =?us-ascii?Q?FJl0owq9Rf4FK/07pz8IQ7QZYm2uUmLiplGv/7lyQyVXSDd71Wnp+EPhfkme?=
 =?us-ascii?Q?FLakiLI6+3nEt2dMJFwtgO6G52lFvqeLxAI3J6Z1pSiZgoFEmp/WCtwgPtUr?=
 =?us-ascii?Q?G6qRLJiZ4YUPYSRqcj7+gzv2pwIrvog/bkPrJHtT5mc5A35nHOegmFFqzz2D?=
 =?us-ascii?Q?gD2/DTD+8Nk/L1q6ylQGcBTGSSj0JWPfvTiLjb+oD1emY0A/nmqNbW+31u4Z?=
 =?us-ascii?Q?AFDBW4lpsb1O8BBWn3qhAWqonBQFMJIn/XXMJC5df1FjVUBJKVi0mZdK+y5z?=
 =?us-ascii?Q?SMLrZ1nVrMCQf8jr1+W6QLTBj7zVArjd0H/pfPcIcl8IoFHxP+XgfujUb2kr?=
 =?us-ascii?Q?KCpVsYjqKH8nsFd20vQM/ECXREWHCFpokaJdGpvcvPtdGuN1gBuuBjUm8qPj?=
 =?us-ascii?Q?TmjWUdvBpRi/MYuf0jiKpsCpoT+I5yRSMiplrI7pjkQ5rLB2a1WtmT+wuTFn?=
 =?us-ascii?Q?dCo/JjBZi3+Hrqnr45W9D4arj4pqO9vqVy3XK4OQTQyCt7ZbdpG8/b2LIYmN?=
 =?us-ascii?Q?acLujE+rojhTHgqU5UGgVBmBstjHUx7/t4A7nVbM6f7c7Pck8USoLL3IGyrV?=
 =?us-ascii?Q?bbuitg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:34:17.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b474f1dd-70ba-4e3d-09e7-08de5817d896
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7469

In the case of AutoConnect enabled, if the AP powers off, during
the first auto reconnection process, network->connecting is set
to false too early, resulting in no actual network disconnect
operation being performed in the __connman_network_disconnect
function, and the network info of GSupplicantInterface object is
not freed.

So when the AP powers on and connman triggers wifi auto
reconnection again, GSupplicantInterface object still returns
-EALREADY and network->connecting remains false.

If the task of autoscan_timeout and the associating event received
by connman from wpa_supplicant happen at the same time (Now auto
reconnection is dependent on wpa_supplicant), it will cause the
network object to be set as unavailable due to the function
__connman_technology_scan_started and freed in the stop_autoscan
function due to false network->connecting. Therefore, connman will
not do dhcp request after receiving the 4-way handshake and
completed events, and cannot allocate IP to STA device.

No matter how many times connman will request to reconnect to the
same AP again in the future, because the wifi state of wpa_supplicant
is already connected and the GSupplicantInterface object still
returns -EALREADY for connect request, STA will never actually do
the connect action again and will never be allocated an IP address
except for restarting wpa_supplicant forcibly.

---
Changes since v1:
- Format line indentation of the code

---
 src/network.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 416a7e74..d3876efe 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1806,7 +1806,8 @@ int __connman_network_connect(struct connman_network *network)
 	if (err < 0) {
 		if (err == -EINPROGRESS)
 			connman_network_set_associating(network, true);
-		else
+		else if (err != -EALREADY ||
+				network->type != CONNMAN_NETWORK_TYPE_WIFI)
 			network->connecting = false;
 
 		return err;
-- 
2.34.1

