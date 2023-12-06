Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFE328C7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A9AF373200
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:04 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6C4AF73206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:04 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 16/90] connection: Refactor '__connman_connection_gateway_add'.
Date: Wed,  6 Dec 2023 15:49:39 -0800
Message-ID: <20231206235056.322578-17-gerickson@nuovations.com>
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

In '__connman_connection_gateway_add', there are only two allowable
values for the 'type' parameter among four total in the enumeration
for 'type'. Error-check against the two invalid values from that
enumeration and return -EINVAL for the invalid values.

In addition, use this check to set 'do_ipv4' and 'do_ipv6' local
Booleans (similar to other functions in the module) that allows for
simplifying the overall logic and flow of the function.
---
 src/connection.c | 54 ++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index d645078d85ee..354340f0ef87 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1828,11 +1828,11 @@ int __connman_connection_gateway_add(struct connman_service *service,
 {
 	struct gateway_data *any_active_gateway = NULL;
 	struct gateway_data *new_gateway = NULL;
-	enum connman_ipconfig_type type4 = CONNMAN_IPCONFIG_TYPE_UNKNOWN,
-		type6 = CONNMAN_IPCONFIG_TYPE_UNKNOWN;
 	enum connman_service_type service_type;
 	int index;
 	g_autofree char *interface = NULL;
+	bool do_ipv4 = false, do_ipv6 = false;
+	bool is_vpn4 = false, is_vpn6 = false;
 	int err = 0;
 
 	DBG("service %p (%s) gateway %p (%s) type %d (%s) peer %p (%s)",
@@ -1844,6 +1844,13 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	if (!service)
 		return -EINVAL;
 
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+		do_ipv4 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+		do_ipv6 = true;
+	else
+		return -EINVAL;
+
 	index = __connman_service_get_index(service);
 	if (index < 0)
 		return -EINVAL;
@@ -1859,15 +1866,12 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	 * gateway for ipv4 is 0.0.0.0 and for ipv6 is ::, meaning the
 	 * interface
 	 */
-	if (!gateway && type == CONNMAN_IPCONFIG_TYPE_IPV4)
+	if (!gateway && do_ipv4)
 		gateway = ipv4_addr_any_str;
 
-	if (!gateway && type == CONNMAN_IPCONFIG_TYPE_IPV6)
+	if (!gateway && do_ipv6)
 		gateway = ipv6_addr_any_str;
 
-	DBG("service %p index %d gateway %s vpn ip %s type %d",
-		service, index, gateway, peer, type);
-
 	err = add_gateway(service, index, gateway, type, &new_gateway);
 	if (err < 0)
 		return err;
@@ -1878,20 +1882,16 @@ int __connman_connection_gateway_add(struct connman_service *service,
 
 	GATEWAY_DATA_DBG("any_active_gateway", any_active_gateway);
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
-				new_gateway->ipv4_config) {
+	if (do_ipv4 && new_gateway->ipv4_config) {
 		add_host_route(AF_INET, index, gateway, service_type);
 		__connman_service_nameserver_add_routes(service,
 					new_gateway->ipv4_config->gateway);
-		type4 = CONNMAN_IPCONFIG_TYPE_IPV4;
 	}
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
-				new_gateway->ipv6_config) {
+	if (do_ipv6 && new_gateway->ipv6_config) {
 		add_host_route(AF_INET6, index, gateway, service_type);
 		__connman_service_nameserver_add_routes(service,
 					new_gateway->ipv6_config->gateway);
-		type6 = CONNMAN_IPCONFIG_TYPE_IPV6;
 	}
 
 	if (service_type == CONNMAN_SERVICE_TYPE_VPN) {
@@ -1899,13 +1899,21 @@ int __connman_connection_gateway_add(struct connman_service *service,
 		set_vpn_routes(new_gateway, service, gateway, type, peer,
 							any_active_gateway);
 
+		is_vpn4 = do_ipv4 &&
+					new_gateway->ipv4_config &&
+					is_gateway_config_vpn(
+						new_gateway->ipv4_config);
+
+		is_vpn6 = do_ipv4 &&
+					new_gateway->ipv4_config &&
+					is_gateway_config_vpn(
+						new_gateway->ipv4_config);
+
 	} else {
-		if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
-					new_gateway->ipv4_config)
+		if (do_ipv4 && new_gateway->ipv4_config)
 			gateway_config_clear_vpn(new_gateway->ipv4_config);
 
-		if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
-					new_gateway->ipv6_config)
+		if (do_ipv6 && new_gateway->ipv6_config)
 			gateway_config_clear_vpn(new_gateway->ipv6_config);
 	}
 
@@ -1914,18 +1922,14 @@ int __connman_connection_gateway_add(struct connman_service *service,
 		goto done;
 	}
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
-			new_gateway->ipv4_config &&
-			is_gateway_config_vpn(new_gateway->ipv4_config)) {
+	if (is_vpn4) {
 		if (!__connman_service_is_split_routing(new_gateway->service))
 			connman_inet_clear_gateway_address(
 				any_active_gateway->index,
 				any_active_gateway->ipv4_config->gateway);
 	}
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
-			new_gateway->ipv6_config &&
-			is_gateway_config_vpn(new_gateway->ipv6_config)) {
+	if (is_vpn6) {
 		if (!__connman_service_is_split_routing(new_gateway->service))
 			connman_inet_clear_ipv6_gateway_address(
 				any_active_gateway->index,
@@ -1933,12 +1937,12 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	}
 
 done:
-	if (type4 == CONNMAN_IPCONFIG_TYPE_IPV4)
+	if (do_ipv4)
 		__connman_service_ipconfig_indicate_state(service,
 						CONNMAN_SERVICE_STATE_READY,
 						CONNMAN_IPCONFIG_TYPE_IPV4);
 
-	if (type6 == CONNMAN_IPCONFIG_TYPE_IPV6)
+	if (do_ipv6)
 		__connman_service_ipconfig_indicate_state(service,
 						CONNMAN_SERVICE_STATE_READY,
 						CONNMAN_IPCONFIG_TYPE_IPV6);
-- 
2.42.0

