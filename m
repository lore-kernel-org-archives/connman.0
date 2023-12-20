Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858DC2D8
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 57B53730F7
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 20:41:20 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 17D1A7310B
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 20:41:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] wispr: Make 'wispr_route_request' route add 'DBG' consistent.
Date: Tue, 19 Dec 2023 17:41:18 -0800
Message-ID: <20231220014118.2265388-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This makes the route addition 'DBG' in 'wispr_route_request'
consistent with the route deletion 'DBG' in 'free_wispr_route'.
---
 src/wispr.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index efc0ca2fbaa9..b1b0f337d3f8 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -690,24 +690,19 @@ static bool wispr_route_request(const char *address, int ai_family,
 {
 	int result = -1;
 	struct connman_wispr_portal_context *wp_context = user_data;
+	g_autofree char *interface = NULL;
 	const char *gateway;
 	struct wispr_route *route;
 	uint32_t metric = 0;
 
+	interface = connman_inet_ifname(if_index);
+
 	gateway = __connman_ipconfig_get_gateway_from_index(if_index,
 		wp_context->type);
 
-	DBG("address %s if %d gw %s", address, if_index, gateway);
-
 	if (!gateway)
 		return false;
 
-	route = g_try_new0(struct wispr_route, 1);
-	if (route == 0) {
-		DBG("could not create struct");
-		return false;
-	}
-
 	result = __connman_service_get_route_metric(wp_context->service,
 				&metric);
 	if (result < 0) {
@@ -719,10 +714,21 @@ static bool wispr_route_request(const char *address, int ai_family,
 		return false;
 	}
 
-	DBG("service %p (%s) metric %u",
-		wp_context->service,
-		connman_service_get_identifier(wp_context->service),
-		metric);
+	DBG("add route to %s via %s dev %d (%s) metric %u type %d (%s) "
+		"ops %p",
+		address,
+		gateway,
+		if_index, interface,
+		metric,
+		wp_context->type,
+		__connman_ipconfig_type2string(wp_context->type),
+		wp_context->ops);
+
+	route = g_try_new0(struct wispr_route, 1);
+	if (route == 0) {
+		DBG("could not create struct");
+		return false;
+	}
 
 	result = wp_context->ops->add_host_route_with_metric(
 					if_index,
-- 
2.42.0

