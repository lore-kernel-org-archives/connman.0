Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90E328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 51F2173200
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:21 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 13B7673224
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 56/90] connection: Refactor 'add_host_route'.
Date: Wed,  6 Dec 2023 15:50:22 -0800
Message-ID: <20231206235056.322578-60-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206235056.322578-1-gerickson@nuovations.com>
References: <20231206235056.322578-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

From: Grant Erickson <erick205@umn.edu>

This refactors 'add_host_route' to take advantage of the
recently-introduced gateway configuration 'ops'.

This faciliates collapsing the IPv4- and IPv6-specific sub-blocks into
one, hanlding both IPv4 and IPv6.
---
 src/connection.c | 74 +++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 023501c81895..771f9eaccc28 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2443,51 +2443,39 @@ static struct connman_rtnl connection_rtnl = {
 	.delgateway	= connection_delgateway,
 };
 
-static void add_host_route(int family, int index, const char *gateway,
+static void add_host_route(struct gateway_data *data,
+			enum connman_ipconfig_type ipconfig_type,
 			enum connman_service_type service_type)
 {
-	switch (family) {
-	case AF_INET:
-		if (!is_addr_any_str(gateway)) {
-			/*
-			 * We must not set route to the phy dev gateway in
-			 * VPN link. The packets to VPN link might be routed
-			 * back to itself and not routed into phy link gateway.
-			 */
-			if (service_type != CONNMAN_SERVICE_TYPE_VPN)
-				connman_inet_add_host_route(index, gateway,
-									NULL);
-		} else {
-			/*
-			 * Add host route to P-t-P link so that services can
-			 * be moved around and we can have some link to P-t-P
-			 * network (although those P-t-P links have limited
-			 * usage if default route is not directed to them)
-			 */
-			char *dest;
-			if (connman_inet_get_dest_addr(index, &dest) == 0) {
-				connman_inet_add_host_route(index, dest, NULL);
-				g_free(dest);
-			}
-		}
-		break;
+	const struct gateway_config *const config =
+		gateway_data_config_get(data, ipconfig_type);
 
-	case AF_INET6:
-		if (!is_addr_any_str(gateway)) {
-			if (service_type != CONNMAN_SERVICE_TYPE_VPN)
-				connman_inet_add_ipv6_host_route(index,
-								gateway, NULL);
-		} else {
-			/* P-t-P link, add route to destination */
-			char *dest;
-			if (connman_inet_ipv6_get_dest_addr(index,
-								&dest) == 0) {
-				connman_inet_add_ipv6_host_route(index, dest,
+	if (!config)
+		return;
+
+	if (!is_addr_any_str(config->gateway)) {
+		/*
+		 * We must not set route to the phy dev gateway in
+		 * VPN link. The packets to VPN link might be routed
+		 * back to itself and not routed into phy link gateway.
+		 */
+		if (service_type != CONNMAN_SERVICE_TYPE_VPN)
+			config->ops->add_host_route(data->index,
+								config->gateway,
 								NULL);
-				g_free(dest);
-			}
+	} else {
+		/*
+		 * Add host route to P-t-P link so that services can
+		 * be moved around and we can have some link to P-t-P
+		 * network (although those P-t-P links have limited
+		 * usage if default route is not directed to them)
+		 */
+		char *dest;
+
+		if (config->ops->get_dest_addr(data->index, &dest) == 0) {
+			config->ops->add_host_route(data->index, dest, NULL);
+			g_free(dest);
 		}
-		break;
 	}
 }
 
@@ -2593,13 +2581,15 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	GATEWAY_DATA_DBG("default_gateway", default_gateway);
 
 	if (do_ipv4 && new_gateway->ipv4_config) {
-		add_host_route(AF_INET, index, gateway, service_type);
+		add_host_route(new_gateway, type, service_type);
+
 		__connman_service_nameserver_add_routes(service,
 					new_gateway->ipv4_config->gateway);
 	}
 
 	if (do_ipv6 && new_gateway->ipv6_config) {
-		add_host_route(AF_INET6, index, gateway, service_type);
+		add_host_route(new_gateway, type, service_type);
+
 		__connman_service_nameserver_add_routes(service,
 					new_gateway->ipv6_config->gateway);
 	}
-- 
2.42.0

