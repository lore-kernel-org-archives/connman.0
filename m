Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1E12B85
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0537F7312B
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:28 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B7BDD73147
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:27 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/11] wispr: Refactor 'free_wispr_routes'.
Date: Fri, 15 Dec 2023 22:12:18 -0800
Message-ID: <20231216061223.2199037-7-gerickson@nuovations.com>
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

This refactors 'free_wispr_routes' into a second, helper function
'free_wispr_route' such that host route deallocation is separated from
container iteration.
---
 src/wispr.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 04229d045cab..568b7f0fc8a7 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -135,30 +135,37 @@ static void connman_wispr_message_init(struct connman_wispr_message *msg)
 	msg->location_name = NULL;
 }
 
+static void free_wispr_route(
+		const struct connman_wispr_portal_context *wp_context,
+		struct wispr_route *route)
+{
+	DBG("free route to %s if %d type %d", route->address,
+			route->if_index, wp_context->type);
+
+	switch (wp_context->type) {
+	case CONNMAN_IPCONFIG_TYPE_IPV4:
+		connman_inet_del_host_route(route->if_index,
+				route->address);
+		break;
+	case CONNMAN_IPCONFIG_TYPE_IPV6:
+		connman_inet_del_ipv6_host_route(route->if_index,
+				route->address);
+		break;
+	case CONNMAN_IPCONFIG_TYPE_UNKNOWN:
+	case CONNMAN_IPCONFIG_TYPE_ALL:
+		break;
+	}
+
+	g_free(route->address);
+	route->address = NULL;
+}
+
 static void free_wispr_routes(struct connman_wispr_portal_context *wp_context)
 {
 	while (wp_context->route_list) {
 		struct wispr_route *route = wp_context->route_list->data;
 
-		DBG("free route to %s if %d type %d", route->address,
-				route->if_index, wp_context->type);
-
-		switch (wp_context->type) {
-		case CONNMAN_IPCONFIG_TYPE_IPV4:
-			connman_inet_del_host_route(route->if_index,
-					route->address);
-			break;
-		case CONNMAN_IPCONFIG_TYPE_IPV6:
-			connman_inet_del_ipv6_host_route(route->if_index,
-					route->address);
-			break;
-		case CONNMAN_IPCONFIG_TYPE_UNKNOWN:
-		case CONNMAN_IPCONFIG_TYPE_ALL:
-			break;
-		}
-
-		g_free(route->address);
-		route->address = NULL;
+		free_wispr_route(wp_context, route);
 
 		g_free(route);
 		wp_context->route_list->data = NULL;
-- 
2.42.0

