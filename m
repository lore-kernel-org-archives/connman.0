Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AE12E43
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5EE287312C
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:28 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 20FD873146
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:28 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 07/11] wispr: Simplify IPv4 vs. IPv6 host route management.
Date: Fri, 15 Dec 2023 22:12:19 -0800
Message-ID: <20231216061223.2199037-8-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216061223.2199037-1-gerickson@nuovations.com>
References: <20231216061223.2199037-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This uses the recently-added, symmetric
'connman_inet_{add,del}_{,ipv6_}host_route_with_metric' functions and
route operations tables to simplify IPv4 vs. IPv6 host route
management for WISPr requests.
---
 src/wispr.c | 112 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 30 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 568b7f0fc8a7..5ea573ca7769 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -53,12 +53,25 @@ enum connman_wispr_result {
 struct wispr_route {
 	char *address;
 	int if_index;
+	uint32_t metric;
+};
+
+struct wispr_portal_context_route_ops {
+	int (*add_host_route_with_metric)(int index,
+		const char *host,
+		const char *gateway,
+		uint32_t metric);
+	int (*del_host_route_with_metric)(int index,
+		const char *host,
+		const char *gateway,
+		uint32_t metric);
 };
 
 struct connman_wispr_portal_context {
 	int refcount;
 	struct connman_service *service;
 	enum connman_ipconfig_type type;
+	const struct wispr_portal_context_route_ops *ops;
 	__connman_wispr_cb_t cb;
 	struct connman_wispr_portal *wispr_portal;
 
@@ -103,6 +116,22 @@ static GHashTable *wispr_portal_hash = NULL;
 static char *online_check_ipv4_url = NULL;
 static char *online_check_ipv6_url = NULL;
 
+static const struct wispr_portal_context_route_ops
+	ipv4_wispr_portal_context_route_ops = {
+	.add_host_route_with_metric    =
+		connman_inet_add_host_route_with_metric,
+	.del_host_route_with_metric    =
+		connman_inet_del_host_route_with_metric
+};
+
+static const struct wispr_portal_context_route_ops
+	ipv6_wispr_portal_context_route_ops = {
+	.add_host_route_with_metric    =
+		connman_inet_add_ipv6_host_route_with_metric,
+	.del_host_route_with_metric    =
+		connman_inet_del_ipv6_host_route_with_metric
+};
+
 #define wispr_portal_context_ref(wp_context) \
 	wispr_portal_context_ref_debug(wp_context, __FILE__, __LINE__, __func__)
 #define wispr_portal_context_unref(wp_context) \
@@ -139,23 +168,39 @@ static void free_wispr_route(
 		const struct connman_wispr_portal_context *wp_context,
 		struct wispr_route *route)
 {
-	DBG("free route to %s if %d type %d", route->address,
-			route->if_index, wp_context->type);
+	g_autofree char *interface = NULL;
+	const char *gateway;
 
-	switch (wp_context->type) {
-	case CONNMAN_IPCONFIG_TYPE_IPV4:
-		connman_inet_del_host_route(route->if_index,
-				route->address);
-		break;
-	case CONNMAN_IPCONFIG_TYPE_IPV6:
-		connman_inet_del_ipv6_host_route(route->if_index,
-				route->address);
-		break;
-	case CONNMAN_IPCONFIG_TYPE_UNKNOWN:
-	case CONNMAN_IPCONFIG_TYPE_ALL:
-		break;
-	}
+	gateway = __connman_ipconfig_get_gateway_from_index(route->if_index,
+		wp_context->type);
+
+	/*
+	 * If gateway was null, as with wispr_route_request, there was no
+	 * host route created. Consequently, there is no host route to
+	 * delete. Simply free the address.
+	 */
+	if (!gateway)
+		goto free;
+
+	interface = connman_inet_ifname(route->if_index);
 
+	DBG("delete route to %s via %s dev %d (%s) metric %u type %d (%s) "
+		"ops %p",
+		route->address,
+		gateway,
+		route->if_index, interface,
+		route->metric,
+		wp_context->type,
+		__connman_ipconfig_type2string(wp_context->type),
+		wp_context->ops);
+
+	wp_context->ops->del_host_route_with_metric(
+				route->if_index,
+				route->address,
+				gateway,
+				route->metric);
+
+free:
 	g_free(route->address);
 	route->address = NULL;
 }
@@ -584,6 +629,7 @@ static bool wispr_route_request(const char *address, int ai_family,
 	struct connman_wispr_portal_context *wp_context = user_data;
 	const char *gateway;
 	struct wispr_route *route;
+	uint32_t metric = 0;
 
 	gateway = __connman_ipconfig_get_gateway_from_index(if_index,
 		wp_context->type);
@@ -599,20 +645,16 @@ static bool wispr_route_request(const char *address, int ai_family,
 		return false;
 	}
 
-	switch (wp_context->type) {
-	case CONNMAN_IPCONFIG_TYPE_IPV4:
-		result = connman_inet_add_host_route(if_index, address,
-				gateway);
-		break;
-	case CONNMAN_IPCONFIG_TYPE_IPV6:
-		result = connman_inet_add_ipv6_host_route(if_index, address,
-				gateway);
-		break;
-	case CONNMAN_IPCONFIG_TYPE_UNKNOWN:
-	case CONNMAN_IPCONFIG_TYPE_ALL:
-		break;
-	}
+	DBG("service %p (%s) metric %u",
+		wp_context->service,
+		connman_service_get_identifier(wp_context->service),
+		metric);
 
+	result = wp_context->ops->add_host_route_with_metric(
+					if_index,
+					address,
+					gateway,
+					metric);
 	if (result < 0) {
 		g_free(route);
 		return false;
@@ -620,6 +662,8 @@ static bool wispr_route_request(const char *address, int ai_family,
 
 	route->address = g_strdup(address);
 	route->if_index = if_index;
+	route->metric = metric;
+
 	wp_context->route_list = g_slist_prepend(wp_context->route_list, route);
 
 	return true;
@@ -1334,10 +1378,18 @@ int __connman_wispr_start(struct connman_service *service,
 	wp_context->cb = callback;
 	wp_context->wispr_portal = wispr_portal;
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		wispr_portal->ipv4_context = wp_context;
-	else
+		wispr_portal->ipv4_context->ops =
+			&ipv4_wispr_portal_context_route_ops;
+	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 		wispr_portal->ipv6_context = wp_context;
+		wispr_portal->ipv6_context->ops =
+			&ipv6_wispr_portal_context_route_ops;
+	} else {
+		err = -EINVAL;
+		goto free_wp;
+	}
 
 	err = wispr_portal_detect(wp_context, connect_timeout_ms);
 	if (err)
-- 
2.42.0

