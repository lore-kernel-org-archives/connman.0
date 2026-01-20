Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9E3F23C5
	for <connman@lists.linux.dev>; Tue, 20 Jan 2026 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906409; cv=fail; b=EyTZkmV/cCnf3PibSETaCeHKOf10BUr/CrYY2LEcOD/4f/+NFXhtrZwhREkJcJ9No55kItQbbDdDo5kbC7cjILpUnno1lgMVhmqprCG89P+aH7PXaEhzq91N3pI3ip5yrYEj30oX8Vv1qVvVaEaG4mBolKXxIMcDJwGe9BLi6jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906409; c=relaxed/simple;
	bh=7GNf+ciHsvvVbb7AP4DhdCbOGFyoUfAye5zuAA0RikA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AbPJl6J8UYEqfaVmU34V8HoRJhYmmXpHMDEYDVQoh9aj6WQQqsmiowXfrFcfrqqvVESWi+4rvofkGTIdX2ZyDgHZukS/yNnJ+d1QeM4aaNkm8TtdQ+qy+QKhP7a2ApqZN8hahXG1YJz4nt31K1onSp1zpqjuX+AavGzwF82nGuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=h1gZTQ63; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="h1gZTQ63"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMUye1Zem0mr9SlrVw+OQd7my3vWoZRfk0CeljBOnVY/C8mouYckFI67A1Lr6LZ5yzYz3nKVaf5e8LBCUG9UVFmAw3ZspVkIjr6Es0Eeae6qhwApsPj+BIyZvxGoakNqcSphorvAQJN0vETHVixmFNzNWl3wcCxjVdVWnemIyyzUzwomkHw3UWovreZzp74JUce5E+uf/b2K17NxQZ2rUGmahAJvdi76PnP4OLKKOVj19QyJOQuVkGClC6Pbzc+ErVw0XNUO0XvMVD7W99E0y9V2bvMGCePl75SB4BM+U5Rgvweh6Z1hzez67RF+F5DAvqDkqt2V9TWzhVfmDxHKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPy4k9mPkmFnsmZTtPj8G3wvs201LKhi3ZZpKdCniOI=;
 b=U89QuHZJFWn4gWYdTq5ImBuplH8Cpzemcix9wXwJstbGUVGKxMjJ+Cb5bQrWmLCjLwzdS7jVNdk79KWkV5A71wgTo4ElR7ta2IFhjw13OFL+z3MnUXKsHM0DxYxzi8kbIjrDWOf65Wt8w9eCi3ObWyRB04oiW6H+AVCFQuuYc/fb0yaUv99VfFtSpsdYUF8E4qlPEq0Sslx5eHpj68Xdc65gJPosuhC2mfPWTemzEZhLJXy+WDw5TdpzP6KhDsE0WdN1ofkJ4cVyPBVQxeJIl7pfEv1wOAnfdvQF6+aO0jHD5KvV4TLJcgTxgqF2HfJP5xAje7Pd+ajp1g4APu2qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPy4k9mPkmFnsmZTtPj8G3wvs201LKhi3ZZpKdCniOI=;
 b=h1gZTQ63wXckLGRP/fHise8ZfNgUC1O7AwJqP5Jxh2m8TRKS/USJOC+eHMZJEfhiBT5lDRILzZ/ZeVxPAaPH5HvMCS/pIYWNiMgJyBoiYWt4w2vs8qES/pHKSJt1wCk8zz9BjU8ffxpXOoiGMN1jdbbKDhnstMTLi1zp46K2+8qD0XfjXnHDsWLjp/mdnP9GggdAyV9TOqmgFSc8imiT+a+AQTU/+Fr6PJuOWGlSWrVMMnuStGwm3qo3l9qQbTQDARIzJINLESmn59yaGBAPMyIh23IWwy62bAEg7VqMk85r+CGa+h0NwwTByFF3SkJhblChUIDF5WjhLrxmBXS0gg==
Received: from AS4P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::6)
 by AS8PR10MB6604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 10:53:24 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::b7) by AS4P190CA0007.outlook.office365.com
 (2603:10a6:20b:5de::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 10:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 10:53:24 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 20 Jan
 2026 11:53:15 +0100
Received: from NAAWCN10001829.asce.corp.bshg.com (10.183.185.167) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 11:53:12 +0100
From: yaming.chen <yaming.chen@bshg.com>
To: <connman@lists.linux.dev>
CC: <sven.dembianny@bshg.com>, <Yaming.Chen@bshg.com>, yaming.chen
	<yaming.chen@bshg.com>
Subject: [PATCH] network:Keep network->connecting true during wifi association
Date: Tue, 20 Jan 2026 18:52:37 +0800
Message-ID: <20260120105237.1668852-1-yaming.chen@bshg.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|AS8PR10MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: fb033156-d6ca-482d-b435-08de58122288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|19092799006|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TA+TlKwX69IDNs7WVJws/iCxQTPlOx5liy9ga/p65kc7bL3PriNKnPk/rOr5?=
 =?us-ascii?Q?mpbzEMKWJ4cAnn5gwU9NEZpnbv9ezPKOVFrnKSsQCBQ+dbY3z/XY77k9pV+R?=
 =?us-ascii?Q?pfA+snAvEeycAy9YxVoxhgc8N4bN4uXrhCKHbDWr2uzoAHrNEVF2W4JPEuXP?=
 =?us-ascii?Q?Ng6Yb0/Txg0aXYMvbLxUVbrvEwp9F74jccTWBkYhVSxNuby8v8hbudQC1FF7?=
 =?us-ascii?Q?mIppr3eMD9imtxbVeqvVCcsa5DelLOAzKKpIa7uOQ8cPNvjqZ3OwoPynOtFN?=
 =?us-ascii?Q?14nPyv6SHaziFh6beZN6EjL3lRMOjJlQ/CrbYQHHEdGelZHPvkGOOQUITiVc?=
 =?us-ascii?Q?F7fIfQZIF+IfJ4Spjm8MBE85jKISQkvmTExwD56O2lE/pyMS59YSOeX6DA0U?=
 =?us-ascii?Q?QMVSazHduMcyxj2UoC01kg6pMkkZit3wPpsyh/kUxdXDu3/IpgI9keq9v5Ze?=
 =?us-ascii?Q?AYH/VTqbEJeSFSqHFgrlbHdK2dUlulYpR1mUGetrLDY4DCvMez+CxnbhwNUB?=
 =?us-ascii?Q?i9263EePvViyntNzc/kCQpTSCDShYgY7WqR/ssLWSqQz12RGAP3izvsRQfvY?=
 =?us-ascii?Q?P4098aAMrIZWw9UIg3brvKM+dMZY7+rYOy+qjROFSV7iRH+qNCFwLWQny2s7?=
 =?us-ascii?Q?cfQIoiY9AdgjR0rIELYTbZUAhkjCv1b6PDOqxrpNk5xh5k3xd+uQThWR+uj2?=
 =?us-ascii?Q?uaxpMjvHU3wNq7uO/m0G2hkO+xoRlHrq/PcUDMw+al7IWyMsdhtEEnFCyUII?=
 =?us-ascii?Q?PGR7hkEqsjHDDds+wV+Zpl+PJXSjO9tu6TabBYxc+BJA31WAr4JOp8gWVJzv?=
 =?us-ascii?Q?R128stvC86ClMdjbBr1qk/DtPH1jXVZ1llxFbLCm+LyRyz04TI2j1JThqEJe?=
 =?us-ascii?Q?mR87QnIQl2AbbCxQwHCZlkxYoVLLaEqOR1wev8x0IYEdCARFbTTjgMwGiCLy?=
 =?us-ascii?Q?XB1PqVCucX7hcj6az1HB7XwcXPeOWNvP6rfMt6xUgLqdf8Quytvt6HqFNQTu?=
 =?us-ascii?Q?nDAwjWUy6EgRPTW0DkotJ9Zpu/1BQGLUkxN//Kh4m3xN/PvSSiAziCfg6xvm?=
 =?us-ascii?Q?2wknVDr/NJMXgek4ZoBoh9wNNxeiYUS6cuiH/6vBZiZeaAH8TgWD+EvTN4Kn?=
 =?us-ascii?Q?shGRqJkNhUccDBHuN1RNZ0bCJMX6KF4AY2/X7cxNEvhLtHfNk1qsalGLisgo?=
 =?us-ascii?Q?8R8xD0Db++guYG7BVjppWOqlPI3BL56iurESjrrIq+ARbKvJKDABx21ZeCkp?=
 =?us-ascii?Q?UkV0MmQgSWZN1CE/S0yE+gONGT+FhLyKOZ+JlgJiEYRJPpzpDCAuVKowUSgb?=
 =?us-ascii?Q?mZof5d5UmxH9YG3T/rQGzNHhMlcGldNtCGnjoYSiU5C7aG8DELZzjmPQyE0Z?=
 =?us-ascii?Q?Ok8rsYMjD1jK/I34VJi5qZx+3NKDFZmYMkIdPOmMLLACk+oc5slACx4PoS/3?=
 =?us-ascii?Q?KCZFwFlODLBXevzge20IwObba1b5yHECn0d2dklQxKxIxR9TDQB8VCXnyfBe?=
 =?us-ascii?Q?K7qeD+/msp3Ox1drzqCphayhVHgq6tDtpMynIEHenJswGlMpIg2ltnsrUiWx?=
 =?us-ascii?Q?RgD+bHvTkiZYcnsxH+g9caNEtl1QTVOMM2SXlEm+hDGAlVZm6tFUqKsAQRrW?=
 =?us-ascii?Q?5knmIm+CL7ntc4b2joozSKBQVHCdFOnRmG32wBw60IdBNOxMkfZTHBqYRPky?=
 =?us-ascii?Q?X2QWIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(19092799006)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 10:53:24.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb033156-d6ca-482d-b435-08de58122288
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6604

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
reconnection is dependent on wpa_Supplicant), it will cause the
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
 src/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 416a7e74..e5433ebd 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1806,7 +1806,7 @@ int __connman_network_connect(struct connman_network *network)
 	if (err < 0) {
 		if (err == -EINPROGRESS)
 			connman_network_set_associating(network, true);
-		else
+		else if (err != -EALREADY || network->type != CONNMAN_NETWORK_TYPE_WIFI)
 			network->connecting = false;
 
 		return err;
-- 
2.34.1

