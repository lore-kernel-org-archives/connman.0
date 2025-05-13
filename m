Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A232AF10
	for <connman@lists.linux.dev>; Tue, 13 May 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155868; cv=fail; b=DMsfh9gh1kEXUzGNJPdzU7OJT7Hy/1zE2wCL0mr+i1kloXciLRA+M9lipTnGxqUzHbs1TfSX0jq5gJoTXWc1jrNECwQORaoIYSJx309yvmZ168xPq2KBbEVCrAiNt2d41Q08NbB56gbVYvMkCYp4NiNFcjUiThMidNrPnQJKoW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155868; c=relaxed/simple;
	bh=RLHuLf+0XLKMwRjXsmJ21DVQ2aaZhiStT5CdD9J7gs4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gy8KFZCR/6C9+kuOlzJJA7hnRn6H6KvAuf6qWl57GUl24oMxLgsz6CKzDTQQxtl6da0fkYYnHOW8MxeiGZtEhwmfQ815jddfOL2VkrcQRHjWlztN249Czf6CVTxQjAQblMd4aR29kKCmr1778OB0zqyL2jOubPRmtvD259NOvts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=0zQfXuGR; arc=fail smtp.client-ip=40.107.249.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="0zQfXuGR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycdXdMGXX4S6rOPihlXpb25dj6KCZbyQfnESu08QKqyfu1+Sf9Yf0gTrNqO7NVBVCvGVehXW6BauCQQsR6Q6rbEZxA28h2qQ0fB3RIJiZziQepum8Ptir7Y8qdkgVhn1AYmBsS+k0W1G3i5nUNIm+0pLCV9gJOdi089wRaRa2aO+q1IzQL742aJ2w06hDV/HUw8e+g00bjQ6BRkALUTIXfdbSNziMKWgYf48GP6jqIxlIF3uyqmIeP6Gwx4s3JBw8YHS+vUvqLPs21E/vidOOKaExLbwnqpWs/YYjkzl9by9xuQpYks6yvIY0NvESuJugga0zWwvqjzI5M0O1j7n3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfTGhLmLeuatQJuRcJ1eSc1E9ZoIsUpwqYw3yhCq13s=;
 b=erBq1vD5gDN879SlhKBqAicfnty9s3Pbtz6caMrRxvDUTjVr4F3DcVeGghV02228mQpobTuruZcq9zZraG2lpZPVUuWZsMl7iP2t3M9GB3DF16WBlpete2dHkvicrUovYlRt9g97nGs+jzOViUrZz5eugJVkgQQCk0COX+ZR5ddW9JiQ0Ulj1WjWPGyEXA3rAwfppg8nLiq9DhMo5nh3+g6ZbVE8VCJRwYDznyee8WYsHl3R0DM5AeiumbswLVV9u4oSUUL0iTZRoEzws0So1DD42SwZi4fda4zTN5U01Ine4PpjMU/8anrWQnmTB/ULeJ53eH1L9bAbefGQXKpHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfTGhLmLeuatQJuRcJ1eSc1E9ZoIsUpwqYw3yhCq13s=;
 b=0zQfXuGRFrFT2FBassKXJdfPs7v81UaJZD7nys6uWSomuoxP5fuHxwvFfxd/au2OLAQSgcwiq31KfjDm9NkQ5gJMMdjAFIRnw2mkb/Vh3wmXUO4+1EYFwYGYAQn0v2IxCnDuIYN/w6bRqFPTKiPU95594qB9z7fi+OyLxJKWOLVHbhqDO64RFDVaU4nkGufqlrxy6GXd5Uk6AChKUscO0fDsSVWexNy1byKn1FrdsgDn9aPWMO8JHf7tQulzdPmLqIuKnVxd305MSiyScdyvMV8EO2PAJrOigPOC1OaE4tGtOC9r29wMuRgtLUmJFBfgaPQovfTywDO18xZT5asfOw==
Received: from DU2PR04CA0156.eurprd04.prod.outlook.com (2603:10a6:10:2b0::11)
 by DB8PR10MB3627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 17:04:22 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::80) by DU2PR04CA0156.outlook.office365.com
 (2603:10a6:10:2b0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Tue,
 13 May 2025 17:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 17:04:22 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 19:04:22 +0200
Received: from localhost (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.43; Tue, 13 May
 2025 19:04:21 +0200
From: Simon Holesch <simon.holesch@bshg.com>
To: <connman@lists.linux.dev>
CC: Simon Holesch <simon.holesch@bshg.com>
Subject: [PATCH] gdhcp: Make DHCP client timeouts suspend-aware
Date: Tue, 13 May 2025 19:01:32 +0200
Message-ID: <20250513170205.244019-1-simon.holesch@bshg.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|DB8PR10MB3627:EE_
X-MS-Office365-Filtering-Correlation-Id: dbdfe8c2-fe64-4f64-eadc-08dd9240353f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HPelc5qfv45izkHL7RClWLTJK+v+72xQvf62r8n9g+cZF4tgu7PTtlnoosEj?=
 =?us-ascii?Q?TQbuZJTJOq1Az2bvxKPVAa48hSiQC8MkKgh21mFcZotvfHfEP7HAgvFtluft?=
 =?us-ascii?Q?Oi/W/xDl5Islxc4DhqBzQmBKmsiqZzXKj9JY8GwEQ+ZBiDnhvqGc6sO4SQjR?=
 =?us-ascii?Q?CCxi7KCT3Wi9L43qVFcR6q5ahJsedZE7x7TG01Rit2JvZ0bV09puAryhQxYG?=
 =?us-ascii?Q?jtgJiZpsdvgrcNrkdEE62Ty9JqADG2R/OezRGMgZ9ajfCaWeR77EZjUxCRpo?=
 =?us-ascii?Q?YU6wMLldhpocGV/4C6aXwJDItv5RYfXhar9dgeqiYFUR4GhYKYHPbhafLPr4?=
 =?us-ascii?Q?d6taU0qDZoYGQMjO+QkE/l5iuA+AR4NaUwfCbk6XxPQUkjtWlc+cup7HT6Zz?=
 =?us-ascii?Q?de6VHgu0O7bKMuBLogk25PUR7ZiJvX4J67s2eP0ygZF/uF2sfA7FqFx1e7mI?=
 =?us-ascii?Q?2106J7fRSPcBFrtPcaOSaMV1O6Xw3zO3TwWMtGQ6HywAVWhZ08RfV02lUJw0?=
 =?us-ascii?Q?4cmz/okmLEBlMP6erwqdBCY/2dT1mZ6dl8MZ+GDJ3kti2qjU4JA0NhRi0L6o?=
 =?us-ascii?Q?i97m/MAg7n4OjsfdmkmFTrvFJ7uELq2Caioe7X7GrXRp/OUL526ejc2L0ZnH?=
 =?us-ascii?Q?cVrWxcgd9XPp56Y57SMKf3r+2azLRrUG0gFzWFLfmOF2uRVjRRygQ/CT+Gok?=
 =?us-ascii?Q?cOXlHla32Himbqz5yQmgefHL6/2fYCZcE+jM25rxcMNoooaaMt9SPny2Tqg3?=
 =?us-ascii?Q?EROMi3rl+9hMw8N3jXtBtBy76V3v4kTg2lHvKAJno5brUIxYek+4hhiYZjuK?=
 =?us-ascii?Q?RDRwjBB/GhcNBcbiicYJqftHYqhuyVEvWpzhrN/v/QTVDkkt3c7D7InJoQcz?=
 =?us-ascii?Q?UVsCIvJL8iu64C74VPjcJMKtGurTT+MGm8ihPR5MiB+Uf/zlZ/232nFYcDfB?=
 =?us-ascii?Q?R8ylD3dmBe19UqWidtA37jCGfey+kvqfBVjrbJF5KB6802WiDxcPqlMhlNx/?=
 =?us-ascii?Q?vtaOYPS/3I93+7LLEZtsNf9ZZ3yxOtqkSckFTaKSwQOUPKJDYEU266Zy6acA?=
 =?us-ascii?Q?2uF20Yp3X7mOSCx+TDxUyee+i1BGumSujDjkqu0kDBW1DK0Tl9/kcQqtdpv8?=
 =?us-ascii?Q?Kepn1Yz2oXTy6b+VrmBAcyJrLamnrPZBZqDRM9ku24vlimBVVH72c1/Bs7Wn?=
 =?us-ascii?Q?FuC1rzSh4VlR1pdYS0YKaZm87L0rfY9djtn2a97PyKP/nMLWt3xaGcuwkhBN?=
 =?us-ascii?Q?gCMKxm1gYrn7rOpFjK32N7pF1KqVyCF5WuJxOmqVD2phnOhgSN2SPYd+AoEe?=
 =?us-ascii?Q?rk4zx8vEe2lHd8jgF/+9YJtA+f6UX+b2RZMkHgUTUlQg2g5N8+jdSa7XE6ms?=
 =?us-ascii?Q?l4qU0Zh3oDIRuLGMaAA2kiyDPFX1tYP1Wpio06h+NehLUBZxUXYlNH5w7BFn?=
 =?us-ascii?Q?Q3qoi0dnBCWwriptv1p0y9kop7i69pl6+sneikcfJrKvnrojD3W41kMCoiCI?=
 =?us-ascii?Q?L+S+t05W93nW9D01F+MGwdL4Lnmprhigig/a?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 17:04:22.4430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdfe8c2-fe64-4f64-eadc-08dd9240353f
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3627

From: Simon Holesch <simon.holesch@bshg.com>

When the system is suspended, ConnMan may keep its IP address longer
than the lease time. This occurs because GLib timeouts use
CLOCK_MONOTONIC, which pauses during suspend on Linux.

This patch switches to timeouts based on CLOCK_BOOTTIME, which continues
to run during suspend.

This is an updated version of the patch reverted in commit 9aede91e
("Revert 'gdhcp: Make DHCP client timeouts suspend aware'"). It now uses
CLOCK_BOOTTIME instead of CLOCK_BOOTTIME_ALARM, so the system will not
wake up to renew the lease, but will send the renew requests right after
resume.
---
 gdhcp/client.c | 183 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 132 insertions(+), 51 deletions(-)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index db8e0596..976773ac 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -32,6 +32,7 @@
 #include <arpa/inet.h>
 #include <sys/time.h>
 #include <resolv.h>
+#include <sys/timerfd.h>
 
 #include <netpacket/packet.h>
 #include <netinet/if_ether.h>
@@ -41,6 +42,7 @@
 #include <linux/filter.h>
 
 #include <glib.h>
+#include <glib-unix.h>
 
 #include "../src/connman.h"
 #include "../src/shared/arp.h"
@@ -160,6 +162,12 @@ struct _GDHCPClient {
 	bool request_bcast;
 };
 
+struct timeout_info {
+	int fd;
+	GSourceFunc callback;
+	gpointer user_data;
+};
+
 static inline void debug(GDHCPClient *client, const char *format, ...)
 {
 	char str[256];
@@ -176,6 +184,101 @@ static inline void debug(GDHCPClient *client, const char *format, ...)
 	va_end(ap);
 }
 
+static gboolean on_timerfd_timeout(gint fd, GIOCondition condition,
+					gpointer data)
+{
+	struct timeout_info *tmo = data;
+
+	return tmo->callback(tmo->user_data);
+}
+
+static void cleanup_timeout_info(struct timeout_info *tmo)
+{
+	if (tmo->fd > 0)
+		close(tmo->fd);
+	g_free(tmo);
+}
+
+static void on_timerfd_destroy(gpointer data)
+{
+	struct timeout_info *tmo = data;
+
+	cleanup_timeout_info(tmo);
+}
+
+static guint timeout_start_timespec(GDHCPClient *dhcp_client, struct timespec *interval,
+					GSourceFunc function, gpointer data)
+{
+	struct itimerspec timeout = {
+		.it_value = *interval,
+		.it_interval = *interval,
+	};
+	struct itimerspec *old_value = NULL;
+	struct timeout_info *tmo;
+	unsigned int id;
+	int flags = 0;
+	int err;
+
+	tmo = g_malloc0(sizeof(*tmo));
+	tmo->callback = function;
+	tmo->user_data = data;
+
+	/*
+	 * CLOCK_BOOTTIME continues to run while the system is suspended. The GLib
+	 * timeout uses CLOCK_MONOTONIC, which is paused during suspend on Linux
+	 * and is therefore unfit for network timeouts.
+	 */
+	tmo->fd = timerfd_create(CLOCK_BOOTTIME, TFD_NONBLOCK | TFD_CLOEXEC);
+	if (tmo->fd == -1) {
+		debug(dhcp_client,
+			"Error creating timerfd: %s", strerror(errno));
+		cleanup_timeout_info(tmo);
+		return 0;
+	}
+
+	err = timerfd_settime(tmo->fd, flags, &timeout, old_value);
+	if (err) {
+		debug(dhcp_client,
+			"Error setting timerfd timeout: %s", strerror(errno));
+		cleanup_timeout_info(tmo);
+		return 0;
+	}
+
+	/*
+	 * The file descriptor returned by timerfd_create can be polled and becomes
+	 * readable on timeout. Add the fd to the GLib event loop.
+	 */
+	id = g_unix_fd_add_full(G_PRIORITY_HIGH, tmo->fd, G_IO_IN,
+				on_timerfd_timeout, tmo, on_timerfd_destroy);
+	if (id == 0) {
+		debug(dhcp_client, "Error adding timerfd to event loop");
+		cleanup_timeout_info(tmo);
+	}
+	return id;
+}
+
+static guint timeout_start_seconds(GDHCPClient *dhcp_client, guint32 interval,
+					GSourceFunc function, gpointer data)
+{
+	struct timespec timeout = {
+		.tv_sec = interval,
+		.tv_nsec = 0,
+	};
+
+	return timeout_start_timespec(dhcp_client, &timeout, function, data);
+}
+
+static guint timeout_start_ms(GDHCPClient *dhcp_client, guint32 interval,
+				GSourceFunc function, gpointer data)
+{
+	struct timespec timeout = {
+		.tv_sec = interval / 1000,
+		.tv_nsec = (long)(interval % 1000) * 1000000,
+	};
+
+	return timeout_start_timespec(dhcp_client, &timeout, function, data);
+}
+
 /* Initialize the packet with the proper defaults */
 static void init_packet(GDHCPClient *dhcp_client, gpointer pkt, char type)
 {
@@ -595,11 +698,8 @@ static gboolean send_probe_packet(gpointer dhcp_data)
 	} else
 		timeout = (ANNOUNCE_WAIT * 1000);
 
-	dhcp_client->timeout = g_timeout_add_full(G_PRIORITY_HIGH,
-						 timeout,
-						 ipv4ll_probe_timeout,
-						 dhcp_client,
-						 NULL);
+	dhcp_client->timeout = timeout_start_ms(dhcp_client, timeout,
+					 ipv4ll_probe_timeout,  dhcp_client);
 	return FALSE;
 }
 
@@ -623,19 +723,17 @@ static gboolean send_announce_packet(gpointer dhcp_data)
 
 	if (dhcp_client->state == IPV4LL_DEFEND) {
 		dhcp_client->timeout =
-			g_timeout_add_seconds_full(G_PRIORITY_HIGH,
+			timeout_start_seconds(dhcp_client,
 						DEFEND_INTERVAL,
 						ipv4ll_defend_timeout,
-						dhcp_client,
-						NULL);
+						dhcp_client);
 		return TRUE;
 	} else
 		dhcp_client->timeout =
-			g_timeout_add_seconds_full(G_PRIORITY_HIGH,
+			timeout_start_seconds(dhcp_client,
 						ANNOUNCE_INTERVAL,
 						ipv4ll_announce_timeout,
-						dhcp_client,
-						NULL);
+						dhcp_client);
 	return TRUE;
 }
 
@@ -1390,11 +1488,8 @@ static void ipv4ll_start(GDHCPClient *dhcp_client)
 	timeout = __connman_util_random_delay_ms(PROBE_WAIT);
 
 	dhcp_client->retry_times++;
-	dhcp_client->timeout = g_timeout_add_full(G_PRIORITY_HIGH,
-						timeout,
-						send_probe_packet,
-						dhcp_client,
-						NULL);
+	dhcp_client->timeout = timeout_start_ms(dhcp_client, timeout,
+					send_probe_packet, dhcp_client);
 }
 
 static void ipv4ll_stop(GDHCPClient *dhcp_client)
@@ -1482,11 +1577,8 @@ static int ipv4ll_recv_arp_packet(GDHCPClient *dhcp_client)
 		timeout_ms = RATE_LIMIT_INTERVAL * 1000;
 	dhcp_client->retry_times++;
 	dhcp_client->timeout =
-		g_timeout_add_full(G_PRIORITY_HIGH,
-				timeout_ms,
-				send_probe_packet,
-				dhcp_client,
-				NULL);
+		timeout_start_ms(dhcp_client, timeout_ms, send_probe_packet,
+				dhcp_client);
 
 	return 0;
 }
@@ -1629,11 +1721,10 @@ static void start_request(GDHCPClient *dhcp_client)
 
 	send_request(dhcp_client);
 
-	dhcp_client->timeout = g_timeout_add_seconds_full(G_PRIORITY_HIGH,
+	dhcp_client->timeout = timeout_start_seconds(dhcp_client,
 							REQUEST_TIMEOUT,
 							request_timeout,
-							dhcp_client,
-							NULL);
+							dhcp_client);
 }
 
 static uint32_t get_lease(struct dhcp_packet *packet, uint16_t packet_len)
@@ -1704,11 +1795,10 @@ static gboolean continue_rebound(gpointer user_data)
 	if (dhcp_client->T2 > 60) {
 		__connman_util_get_random(&rand);
 		dhcp_client->t2_timeout =
-			g_timeout_add_full(G_PRIORITY_HIGH,
+			timeout_start_ms(dhcp_client,
 					dhcp_client->T2 * 1000 + (rand % 2000) - 1000,
 					continue_rebound,
-					dhcp_client,
-					NULL);
+					dhcp_client);
 	}
 
 	return FALSE;
@@ -1751,11 +1841,10 @@ static gboolean continue_renew (gpointer user_data)
 
 	if (dhcp_client->T1 > 60) {
 		__connman_util_get_random(&rand);
-		dhcp_client->t1_timeout = g_timeout_add_full(G_PRIORITY_HIGH,
+		dhcp_client->t1_timeout = timeout_start_ms(dhcp_client,
 				dhcp_client->T1 * 1000 + (rand % 2000) - 1000,
 				continue_renew,
-				dhcp_client,
-				NULL);
+				dhcp_client);
 	}
 
 	return FALSE;
@@ -1793,20 +1882,17 @@ static void start_bound(GDHCPClient *dhcp_client)
 	dhcp_client->T2 = dhcp_client->lease_seconds * 0.875;
 	dhcp_client->expire = dhcp_client->lease_seconds;
 
-	dhcp_client->t1_timeout = g_timeout_add_seconds_full(G_PRIORITY_HIGH,
+	dhcp_client->t1_timeout = timeout_start_seconds(dhcp_client,
 					dhcp_client->T1,
-					start_renew, dhcp_client,
-							NULL);
+					start_renew, dhcp_client);
 
-	dhcp_client->t2_timeout = g_timeout_add_seconds_full(G_PRIORITY_HIGH,
+	dhcp_client->t2_timeout = timeout_start_seconds(dhcp_client,
 					dhcp_client->T2,
-					start_rebound, dhcp_client,
-							NULL);
+					start_rebound, dhcp_client);
 
-	dhcp_client->lease_timeout= g_timeout_add_seconds_full(G_PRIORITY_HIGH,
+	dhcp_client->lease_timeout= timeout_start_seconds(dhcp_client,
 					dhcp_client->expire,
-					start_expire, dhcp_client,
-							NULL);
+					start_expire, dhcp_client);
 }
 
 static gboolean restart_dhcp_timeout(gpointer user_data)
@@ -2471,11 +2557,9 @@ static gboolean listener_event(GIOChannel *channel, GIOCondition condition,
 
 			remove_timeouts(dhcp_client);
 
-			dhcp_client->timeout = g_timeout_add_seconds_full(
-							G_PRIORITY_HIGH, 3,
-							restart_dhcp_timeout,
-							dhcp_client,
-							NULL);
+			dhcp_client->timeout =
+				timeout_start_seconds(dhcp_client, 3,
+						restart_dhcp_timeout, dhcp_client);
 		}
 
 		break;
@@ -2894,21 +2978,18 @@ int g_dhcp_client_start(GDHCPClient *dhcp_client, const char *last_address)
 		dhcp_client->state = REBOOTING;
 		send_request(dhcp_client);
 
-		dhcp_client->timeout = g_timeout_add_seconds_full(
-								G_PRIORITY_HIGH,
+		dhcp_client->timeout = timeout_start_seconds(dhcp_client,
 								REQUEST_TIMEOUT,
 								reboot_timeout,
-								dhcp_client,
-								NULL);
+								dhcp_client);
 		return 0;
 	}
 	send_discover(dhcp_client, addr);
 
-	dhcp_client->timeout = g_timeout_add_seconds_full(G_PRIORITY_HIGH,
+	dhcp_client->timeout = timeout_start_seconds(dhcp_client,
 							DISCOVER_TIMEOUT,
 							discover_timeout,
-							dhcp_client,
-							NULL);
+							dhcp_client);
 	return 0;
 }
 
-- 
2.49.0

