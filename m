Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84575DF2C
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C5B0B7322E
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:10 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7E6307324C
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:10 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 6/8] connection: Document 'connection_{add,del}gateway'.
Date: Wed, 29 Nov 2023 11:21:04 -0800
Message-ID: <20231129192106.1295868-7-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129192106.1295868-1-gerickson@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231129192106.1295868-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'connection_{add,del}gateway'
functions.
---
 src/connection.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index b772a6367570..a4610202d0ba 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -777,6 +777,29 @@ static bool choose_default_gateway(struct gateway_data *data,
 	return downgraded;
 }
 
+/**
+ *  @brief
+ *    Handler for gateway, or default route, -specific routes newly
+ *    added to the Linux kernel routing tables.
+ *
+ *  This is the Linux Routing Netlink (rtnl) handler for gateway, or
+ *  default route, -specific routes newly-added to the Linux kernel
+ *  routing tables. Its primary role and goal is to serve as a
+ *  round-trip acknowledgement that gateway-, or default route,
+ *  related routes added or set to the kernel are now active and in
+ *  use.
+ *
+ *  @param[in]  index    The network interface index associated with
+ *                       the newly-added gateway, or default router.
+ *  @param[in]  gateway  An pointer to an immutable null-terminated
+ *                       C string containing the text-
+ *                       formatted address of the gateway, or default
+ *                       router, that was added.
+ *
+ *  @sa set_default_gateway
+ *  @sa connection_delgateway
+ *
+ */
 static void connection_newgateway(int index, const char *gateway)
 {
 	g_autofree char *interface = NULL;
@@ -791,12 +814,23 @@ static void connection_newgateway(int index, const char *gateway)
 	DBG("index %d (%s) gateway %s", index, maybe_null(interface),
 		gateway);
 
+	/*
+	 * If there is no gateway configuration, then this is not a
+	 * gateway, or default router, route we added or
+	 * set. Consequently, ignore it and return.
+	 */
 	config = find_gateway(index, gateway);
 	if (!config)
 		return;
 
 	GATEWAY_CONFIG_DBG("config", config);
 
+	/*
+	 * Otherwise, this is a gateway, or default router, route we added
+	 * or set and it is now acknowledged by the kernel. Consequently,
+	 * prospectively mark it as active; however, this may be
+	 * subsequently modified as default route determinations are made.
+	 */
 	config->active = true;
 
 	/*
@@ -869,6 +903,29 @@ static void remove_gateway(gpointer user_data)
 	g_free(data);
 }
 
+/**
+ *  @brief
+ *    Handler for gateway, or default route, -specific routes newly
+ *    removed from the Linux kernel routing tables.
+ *
+ *  This is the Linux Routing Netlink (rtnl) handler for gateway, or
+ *  default route, -specific routes newly-removed from the Linux
+ *  kernel routing tables. Its primary role and goal is to serve as
+ *  a round-trip acknowledgement that gateway-, or default route,
+ *  related routes removed or cleared from the kernel are now inactive
+ *  and are no longer in use.
+ *
+ *  @param[in]  index    The network interface index associated with
+ *                       the newly-removed gateway, or default router.
+ *  @param[in]  gateway  An pointer to an immutable null-terminated
+ *                       C string containing the text-
+ *                       formatted address of the gateway, or default
+ *                       router, that was removed.
+ *
+ *  @sa connection_newgateway
+ *  @sa set_default_gateway
+ *
+ */
 static void connection_delgateway(int index, const char *gateway)
 {
 	g_autofree char *interface = NULL;
@@ -880,6 +937,10 @@ static void connection_delgateway(int index, const char *gateway)
 	DBG("index %d (%s) gateway %s", index, maybe_null(interface),
 		gateway);
 
+	/*
+	 * This ends the lifecycle of the gateway associated with the
+	 * newly-removed route; mark it as no longer active.
+	 */
 	config = find_gateway(index, gateway);
 	if (config) {
 		GATEWAY_CONFIG_DBG("config", config);
@@ -887,6 +948,12 @@ static void connection_delgateway(int index, const char *gateway)
 		config->active = false;
 	}
 
+	/*
+	 * Due to the newly-removed gateway route, there may have been a
+	 * concomitant change in service order that has resulted in a new,
+	 * default service, if any. If so, ensure that service acquires
+	 * the high priority default route.
+	 */
 	data = find_default_gateway();
 	if (data) {
 		GATEWAY_DATA_DBG("data", data);
-- 
2.42.0

