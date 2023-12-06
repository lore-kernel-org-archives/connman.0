Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A552328C4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E99ED73207
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:20 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AAF847321E
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 55/90] connection: Introduce gateway config 'ops'
Date: Wed,  6 Dec 2023 15:50:21 -0800
Message-ID: <20231206235056.322578-59-gerickson@nuovations.com>
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

This introduces a gateway configuration 'ops' data structure of IPv4-
and IPv6-specific addressing and routing functions.

With this introduction, all accesses to these functions are done
through a pointer to an "ops" structure. This further neutralizes
IPv4- and IPv6-specific code blocks and clears a path towards their
unification.
---
 src/connection.c | 164 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 134 insertions(+), 30 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index cfae70f2055c..023501c81895 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -140,6 +140,39 @@ enum gateway_config_type {
 	CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT  = 2
 };
 
+struct gateway_config_ops {
+	bool (*compare_subnet)(int index,
+		const char *address);
+
+	int (*get_dest_addr)(int index,
+		char **dest);
+
+	int (*add_interface_route)(int index);
+	int (*del_interface_route)(int index);
+
+	int (*add_default_route)(uint32_t table,
+		int index,
+		const char *gateway);
+	int (*del_default_route)(uint32_t table,
+		int index,
+		const char *gateway);
+
+	int (*add_default_route_with_metric)(uint32_t table,
+		int index,
+		const char *gateway,
+		uint32_t metric);
+	int (*del_default_route_with_metric)(uint32_t table,
+		int index,
+		const char *gateway,
+		uint32_t metric);
+
+	int (*add_host_route)(int index,
+		const char *gateway,
+		const char *host);
+	int (*del_host_route)(int index,
+		const char *gateway);
+};
+
 struct gateway_config {
 	/**
 	 *	A 32-bit flag bitfield governing the state and use of the
@@ -158,6 +191,7 @@ struct gateway_config {
 	 *	See #gateway_config_type.
 	 */
 	enum gateway_config_type type;
+	const struct gateway_config_ops *ops;
 	char *gateway;
 
 	/* VPN extra data */
@@ -242,6 +276,62 @@ static int unset_low_priority_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function);
 
+static const struct gateway_config_ops ipv4_gateway_config_ops = {
+	.compare_subnet				   =
+		connman_inet_compare_subnet,
+
+	.get_dest_addr				   =
+		connman_inet_get_dest_addr,
+
+	.add_interface_route		   =
+		connman_inet_set_gateway_interface,
+	.del_interface_route		   =
+		connman_inet_clear_gateway_interface,
+
+	.add_default_route			   =
+		__connman_inet_add_default_to_table,
+	.del_default_route			   =
+		__connman_inet_del_default_from_table,
+
+	.add_default_route_with_metric =
+		__connman_inet_add_default_to_table_with_metric,
+	.del_default_route_with_metric =
+		__connman_inet_del_default_from_table_with_metric,
+
+	.add_host_route				   =
+		connman_inet_add_host_route,
+	.del_host_route				   =
+		connman_inet_del_host_route
+};
+
+static const struct gateway_config_ops ipv6_gateway_config_ops = {
+	.compare_subnet				   =
+		connman_inet_compare_ipv6_subnet,
+
+	.get_dest_addr				   =
+		connman_inet_ipv6_get_dest_addr,
+
+	.add_interface_route		   =
+		connman_inet_set_ipv6_gateway_interface,
+	.del_interface_route		   =
+		connman_inet_clear_ipv6_gateway_interface,
+
+	.add_default_route			   =
+		__connman_inet_add_default_to_table,
+	.del_default_route			   =
+		__connman_inet_del_default_from_table,
+
+	.add_default_route_with_metric =
+		__connman_inet_add_default_to_table_with_metric,
+	.del_default_route_with_metric =
+		__connman_inet_del_default_from_table_with_metric,
+
+	.add_host_route				   =
+		connman_inet_add_ipv6_host_route,
+	.del_host_route				   =
+		connman_inet_del_ipv6_host_route
+};
+
 /*
  * These are declared as 'const char *const' to effect an immutable
  * pointer to an immutable null-terminated character string such that
@@ -451,6 +541,7 @@ static void gateway_config_debug(const char *function,
 		DBG("from %s() "
 			"%s %p: { state: %d (%s), type %d (%s), "
 			"flags: 0x%x (%s), "
+			"ops: %p, "
 			"gateway: %p (%s), "
 			"vpn_ip: %p (%s), vpn_phy_index: %d (%s), "
 			"vpn_phy_ip: %p (%s) }",
@@ -463,6 +554,7 @@ static void gateway_config_debug(const char *function,
 			maybe_null(gateway_config_type2string(config->type)),
 			config->flags,
 			is_gateway_config_vpn(config) ? "VPN" : "",
+			config->ops,
 			config->gateway, maybe_null(config->gateway),
 			config->vpn_ip, maybe_null(config->vpn_ip),
 			config->vpn_phy_index, maybe_null(vpn_phy_interface),
@@ -937,7 +1029,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 		 * If VPN server is on same subnet as we are, skip adding
 		 * route.
 		 */
-		if (connman_inet_compare_subnet(active_gateway->index,
+		if (config->ops->compare_subnet(active_gateway->index,
 								gateway))
 			return;
 
@@ -948,15 +1040,17 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 		else
 			dest = NULL;
 
-		connman_inet_add_host_route(active_gateway->index, gateway,
-									dest);
+		active_gateway->ipv4_config->ops->add_host_route(
+							active_gateway->index,
+							gateway,
+							dest);
 
 	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 
 		if (!active_gateway->ipv6_config)
 			return;
 
-		if (connman_inet_compare_ipv6_subnet(active_gateway->index,
+		if (config->ops->compare_subnet(active_gateway->index,
 								gateway))
 			return;
 
@@ -967,8 +1061,10 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 		else
 			dest = NULL;
 
-		connman_inet_add_ipv6_host_route(active_gateway->index,
-								gateway, dest);
+		active_gateway->ipv6_config->ops->add_host_route(
+							active_gateway->index,
+							gateway,
+							dest);
 	}
 }
 
@@ -1039,7 +1135,8 @@ static int del_gateway_routes(struct gateway_data *data,
 						data->ipv4_config->vpn_ip);
 
 		} else {
-			connman_inet_del_host_route(data->index,
+			data->ipv4_config->ops->del_host_route(
+						data->index,
 						data->ipv4_config->gateway);
 
 			status4 = UNSET_DEFAULT_GATEWAY(data, type);
@@ -1055,7 +1152,8 @@ static int del_gateway_routes(struct gateway_data *data,
 						data->ipv6_config->vpn_ip);
 
 		} else {
-			connman_inet_del_ipv6_host_route(data->index,
+			data->ipv6_config->ops->del_host_route(
+						data->index,
 						data->ipv6_config->gateway);
 
 			status6 = UNSET_DEFAULT_GATEWAY(data, type);
@@ -1232,10 +1330,13 @@ static int add_gateway(struct connman_service *service,
 	config->vpn_phy_ip = NULL;
 	config->vpn_phy_index = -1;
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		temp_data->ipv4_config = config;
-	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+		temp_data->ipv4_config->ops = &ipv4_gateway_config_ops;
+	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 		temp_data->ipv6_config = config;
+		temp_data->ipv6_config->ops = &ipv6_gateway_config_ops;
+	}
 
 	temp_data->service = service;
 
@@ -1490,7 +1591,7 @@ static int set_ipv4_high_priority_default_gateway_route_cb(
 	int err = 0;
 
 	if (is_gateway_config_vpn(config)) {
-		err = connman_inet_set_gateway_interface(data->index);
+		err = config->ops->add_interface_route(data->index);
 		if (err < 0)
 			goto done;
 
@@ -1499,15 +1600,14 @@ static int set_ipv4_high_priority_default_gateway_route_cb(
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
 	} else if (is_addr_any_str(config->gateway)) {
-		err = connman_inet_set_gateway_interface(
-					data->index);
+		err = config->ops->add_interface_route(data->index);
 		if (err < 0)
 			goto done;
 
 		DBG("set %p index %d",
 			data, data->index);
 	} else {
-		err = __connman_inet_add_default_to_table(
+		err = config->ops->add_default_route(
 					RT_TABLE_MAIN,
 					data->index,
 					config->gateway);
@@ -1529,7 +1629,7 @@ static int set_ipv6_high_priority_default_gateway_route_cb(
 	int err = 0;
 
 	if (is_gateway_config_vpn(config)) {
-		err = connman_inet_set_ipv6_gateway_interface(data->index);
+		err = config->ops->add_interface_route(data->index);
 		if (err < 0)
 			goto done;
 
@@ -1538,15 +1638,14 @@ static int set_ipv6_high_priority_default_gateway_route_cb(
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
 	} else if (is_addr_any_str(config->gateway)) {
-		err = connman_inet_set_ipv6_gateway_interface(
-					data->index);
+		err = config->ops->add_interface_route(data->index);
 		if (err < 0)
 			goto done;
 
 		DBG("set %p index %d",
 			data, data->index);
 	} else {
-		err = __connman_inet_add_default_to_table(
+		err = config->ops->add_default_route(
 					RT_TABLE_MAIN,
 					data->index,
 					config->gateway);
@@ -1647,7 +1746,7 @@ static int unset_ipv4_high_priority_default_gateway_route_cb(
 	int err = 0;
 
 	if (is_gateway_config_vpn(config)) {
-		err = connman_inet_clear_gateway_interface(data->index);
+		err = config->ops->del_interface_route(data->index);
 		if (err < 0)
 			goto done;
 
@@ -1656,14 +1755,16 @@ static int unset_ipv4_high_priority_default_gateway_route_cb(
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
 	} else if (is_addr_any_str(config->gateway)) {
-		err = connman_inet_clear_gateway_interface(data->index);
+		err = config->ops->del_interface_route(data->index);
 		if (err < 0)
 			goto done;
 
 		DBG("unset %p index %d",
 			data, data->index);
 	} else {
-		err = connman_inet_clear_gateway_address(data->index,
+		err = config->ops->del_default_route(
+					RT_TABLE_MAIN,
+					data->index,
 					config->gateway);
 		if (err < 0)
 			goto done;
@@ -1683,7 +1784,7 @@ static int unset_ipv6_high_priority_default_gateway_route_cb(
 	int err = 0;
 
 	if (is_gateway_config_vpn(config)) {
-		err = connman_inet_clear_ipv6_gateway_interface(data->index);
+		err = config->ops->del_interface_route(data->index);
 		if (err < 0)
 			goto done;
 
@@ -1692,14 +1793,16 @@ static int unset_ipv6_high_priority_default_gateway_route_cb(
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
 	} else if (is_addr_any_str(config->gateway)) {
-		err = connman_inet_clear_ipv6_gateway_interface(data->index);
+		err = config->ops->del_interface_route(data->index);
 		if (err < 0)
 			goto done;
 
 		DBG("unset %p index %d",
 			data, data->index);
 	} else {
-		err = connman_inet_clear_ipv6_gateway_address(data->index,
+		err = config->ops->del_default_route(
+					RT_TABLE_MAIN,
+					data->index,
 					config->gateway);
 		if (err < 0)
 			goto done;
@@ -1803,7 +1906,7 @@ static int set_ipv4_low_priority_default_gateway_route_cb(
 
 	DBG("using metric %u for index %d", metric, data->index);
 
-	return __connman_inet_add_default_to_table_with_metric(
+	return config->ops->add_default_route_with_metric(
 				RT_TABLE_MAIN,
 				data->index,
 				config->gateway,
@@ -1844,7 +1947,7 @@ static int unset_ipv4_low_priority_default_gateway_route_cb(
 
 	DBG("using metric %u for index %d", metric, data->index);
 
-	return __connman_inet_del_default_from_table_with_metric(
+	return config->ops->del_default_route_with_metric(
 				RT_TABLE_MAIN,
 				data->index,
 				config->gateway,
@@ -2647,13 +2750,14 @@ void __connman_connection_gateway_remove(struct connman_service *service,
     /* If necessary, delete any VPN-related host routes. */
 
 	if (is_vpn4 && data->index >= 0)
-		connman_inet_del_host_route(data->ipv4_config->vpn_phy_index,
-						data->ipv4_config->gateway);
+		data->ipv4_config->ops->del_host_route(
+					data->ipv4_config->vpn_phy_index,
+					data->ipv4_config->gateway);
 
 	if (is_vpn6 && data->index >= 0)
-		connman_inet_del_ipv6_host_route(
+		data->ipv6_config->ops->del_host_route(
 					data->ipv6_config->vpn_phy_index,
-						data->ipv6_config->gateway);
+					data->ipv6_config->gateway);
 
 	/* Remove all active routes associated with this gateway data. */
 
-- 
2.42.0

