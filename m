Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286013AFC
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 163B3730F9
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:52:39 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A3AAF73150
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:52:38 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2] connection: Rename 'ipv[46]_gateway' gateway config field.
Date: Wed, 29 Nov 2023 11:52:37 -0800
Message-ID: <20231129195237.1296695-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129000816.1230451-1-gerickson@nuovations.com>
References: <20231129000816.1230451-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames the 'gateway_data' structure 'ipv[46]_gateway' fields as
'ipv[46]_config' to:

    1. Better align the fields with their type, 'gateway_config'.
    2. Disambiguate the fields from their type field, 'gateway'.
    3. Align with and mirror 'ipconfig'.
---
 src/connection.c | 352 +++++++++++++++++++++++------------------------
 1 file changed, 176 insertions(+), 176 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 7c65b0951243..d4873861e0b6 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -52,8 +52,8 @@ struct gateway_config {
 struct gateway_data {
 	int index;
 	struct connman_service *service;
-	struct gateway_config *ipv4_gateway;
-	struct gateway_config *ipv6_gateway;
+	struct gateway_config *ipv4_config;
+	struct gateway_config *ipv6_config;
 	bool default_checked;
 };
 
@@ -167,7 +167,7 @@ static void gateway_data_debug(const char *function,
 		interface = connman_inet_ifname(data->index);
 
 		DBG("from %s %s %p: { index: %d (%s), service: %p (%s), "
-			"ipv4_gateway: %p, ipv6_gateway: %p, default_checked: %u }",
+			"ipv4_config: %p, ipv6_config: %p, default_checked: %u }",
 			function,
 			description,
 			data,
@@ -175,17 +175,17 @@ static void gateway_data_debug(const char *function,
 			maybe_null(interface),
 			data->service,
 			connman_service_get_identifier(data->service),
-			data->ipv4_gateway,
-			data->ipv6_gateway,
+			data->ipv4_config,
+			data->ipv6_config,
 			data->default_checked);
 
-		if (data->ipv4_gateway)
-			gateway_config_debug(function, "ipv4_gateway",
-				data->ipv4_gateway);
+		if (data->ipv4_config)
+			gateway_config_debug(function, "ipv4_config",
+				data->ipv4_config);
 
-		if (data->ipv6_gateway)
-			gateway_config_debug(function, "ipv6_gateway",
-				data->ipv6_gateway);
+		if (data->ipv6_config)
+			gateway_config_debug(function, "ipv6_config",
+				data->ipv6_config);
 	}
 }
 
@@ -202,15 +202,15 @@ static struct gateway_config *find_gateway(int index, const char *gateway)
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		struct gateway_data *data = value;
 
-		if (data->ipv4_gateway && data->index == index &&
-				g_str_equal(data->ipv4_gateway->gateway,
+		if (data->ipv4_config && data->index == index &&
+				g_str_equal(data->ipv4_config->gateway,
 					gateway))
-			return data->ipv4_gateway;
+			return data->ipv4_config;
 
-		if (data->ipv6_gateway && data->index == index &&
-				g_str_equal(data->ipv6_gateway->gateway,
+		if (data->ipv6_config && data->index == index &&
+				g_str_equal(data->ipv6_config->gateway,
 					gateway))
-			return data->ipv6_gateway;
+			return data->ipv6_config;
 	}
 
 	return NULL;
@@ -229,12 +229,12 @@ static struct gateway_data *lookup_gateway_data(struct gateway_config *config)
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		struct gateway_data *data = value;
 
-		if (data->ipv4_gateway &&
-				data->ipv4_gateway == config)
+		if (data->ipv4_config &&
+				data->ipv4_config == config)
 			return data;
 
-		if (data->ipv6_gateway &&
-				data->ipv6_gateway == config)
+		if (data->ipv6_config &&
+				data->ipv6_config == config)
 			return data;
 	}
 
@@ -254,13 +254,13 @@ static struct gateway_data *find_vpn_gateway(int index, const char *gateway)
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		struct gateway_data *data = value;
 
-		if (data->ipv4_gateway && data->index == index &&
-				g_str_equal(data->ipv4_gateway->gateway,
+		if (data->ipv4_config && data->index == index &&
+				g_str_equal(data->ipv4_config->gateway,
 					gateway))
 			return data;
 
-		if (data->ipv6_gateway && data->index == index &&
-				g_str_equal(data->ipv6_gateway->gateway,
+		if (data->ipv6_config && data->index == index &&
+				g_str_equal(data->ipv6_config->gateway,
 					gateway))
 			return data;
 	}
@@ -296,9 +296,9 @@ static void get_gateway_cb(const char *gateway, int index, void *user_data)
 	family = connman_inet_check_ipaddress(params->vpn_gateway);
 
 	if (family == AF_INET)
-		config = data->ipv4_gateway;
+		config = data->ipv4_config;
 	else if (family == AF_INET6)
-		config = data->ipv6_gateway;
+		config = data->ipv6_config;
 	else
 		goto out;
 
@@ -327,10 +327,10 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		ipconfig = __connman_service_get_ip4config(service);
-		config = new_gateway->ipv4_gateway;
+		config = new_gateway->ipv4_config;
 	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 		ipconfig = __connman_service_get_ip6config(service);
-		config = new_gateway->ipv6_gateway;
+		config = new_gateway->ipv6_config;
 	} else
 		return;
 
@@ -367,7 +367,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 		 * the VPN. The route might already exist depending
 		 * on network topology.
 		 */
-		if (!active_gateway->ipv4_gateway)
+		if (!active_gateway->ipv4_config)
 			return;
 
 
@@ -379,11 +379,11 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 								gateway))
 			return;
 
-		DBG("active gw %s", active_gateway->ipv4_gateway->gateway);
+		DBG("active gw %s", active_gateway->ipv4_config->gateway);
 
-		if (g_strcmp0(active_gateway->ipv4_gateway->gateway,
+		if (g_strcmp0(active_gateway->ipv4_config->gateway,
 							"0.0.0.0") != 0)
-			dest = active_gateway->ipv4_gateway->gateway;
+			dest = active_gateway->ipv4_config->gateway;
 		else
 			dest = NULL;
 
@@ -392,18 +392,18 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 
 	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 
-		if (!active_gateway->ipv6_gateway)
+		if (!active_gateway->ipv6_config)
 			return;
 
 		if (connman_inet_compare_ipv6_subnet(active_gateway->index,
 								gateway))
 			return;
 
-		DBG("active gw %s", active_gateway->ipv6_gateway->gateway);
+		DBG("active gw %s", active_gateway->ipv6_config->gateway);
 
-		if (g_strcmp0(active_gateway->ipv6_gateway->gateway,
+		if (g_strcmp0(active_gateway->ipv6_config->gateway,
 								"::") != 0)
-			dest = active_gateway->ipv6_gateway->gateway;
+			dest = active_gateway->ipv6_config->gateway;
 		else
 			dest = NULL;
 
@@ -427,40 +427,40 @@ static int del_routes(struct gateway_data *data,
 	else
 		do_ipv4 = do_ipv6 = true;
 
-	if (do_ipv4 && data->ipv4_gateway) {
-		if (data->ipv4_gateway->vpn) {
+	if (do_ipv4 && data->ipv4_config) {
+		if (data->ipv4_config->vpn) {
 			status4 = connman_inet_clear_gateway_address(
 						data->index,
-						data->ipv4_gateway->vpn_ip);
+						data->ipv4_config->vpn_ip);
 
-		} else if (g_strcmp0(data->ipv4_gateway->gateway,
+		} else if (g_strcmp0(data->ipv4_config->gateway,
 							"0.0.0.0") == 0) {
 			status4 = connman_inet_clear_gateway_interface(
 								data->index);
 		} else {
 			connman_inet_del_host_route(data->index,
-						data->ipv4_gateway->gateway);
+						data->ipv4_config->gateway);
 			status4 = connman_inet_clear_gateway_address(
 						data->index,
-						data->ipv4_gateway->gateway);
+						data->ipv4_config->gateway);
 		}
 	}
 
-	if (do_ipv6 && data->ipv6_gateway) {
-		if (data->ipv6_gateway->vpn) {
+	if (do_ipv6 && data->ipv6_config) {
+		if (data->ipv6_config->vpn) {
 			status6 = connman_inet_clear_ipv6_gateway_address(
 						data->index,
-						data->ipv6_gateway->vpn_ip);
+						data->ipv6_config->vpn_ip);
 
-		} else if (g_strcmp0(data->ipv6_gateway->gateway, "::") == 0) {
+		} else if (g_strcmp0(data->ipv6_config->gateway, "::") == 0) {
 			status6 = connman_inet_clear_ipv6_gateway_interface(
 								data->index);
 		} else {
 			connman_inet_del_ipv6_host_route(data->index,
-						data->ipv6_gateway->gateway);
+						data->ipv6_config->gateway);
 			status6 = connman_inet_clear_ipv6_gateway_address(
 						data->index,
-						data->ipv6_gateway->gateway);
+						data->ipv6_config->gateway);
 		}
 	}
 
@@ -475,11 +475,11 @@ static int disable_gateway(struct gateway_data *data,
 	GATEWAY_DATA_DBG("data", data);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
-		if (data->ipv4_gateway)
-			active = data->ipv4_gateway->active;
+		if (data->ipv4_config)
+			active = data->ipv4_config->active;
 	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
-		if (data->ipv6_gateway)
-			active = data->ipv6_gateway->active;
+		if (data->ipv6_config)
+			active = data->ipv6_config->active;
 	} else
 		active = true;
 
@@ -521,9 +521,9 @@ static struct gateway_data *add_gateway(struct connman_service *service,
 	config->active = false;
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
-		data->ipv4_gateway = config;
+		data->ipv4_config = config;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
-		data->ipv6_gateway = config;
+		data->ipv6_config = config;
 	else {
 		g_free(config->gateway);
 		g_free(config);
@@ -542,14 +542,14 @@ static struct gateway_data *add_gateway(struct connman_service *service,
 	old = g_hash_table_lookup(gateway_hash, service);
 	if (old) {
 		DBG("Replacing gw %p ipv4 %p ipv6 %p", old,
-			old->ipv4_gateway, old->ipv6_gateway);
+			old->ipv4_config, old->ipv6_config);
 		disable_gateway(old, type);
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
-			data->ipv6_gateway = old->ipv6_gateway;
-			old->ipv6_gateway = NULL;
+			data->ipv6_config = old->ipv6_config;
+			old->ipv6_config = NULL;
 		} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
-			data->ipv4_gateway = old->ipv4_gateway;
-			old->ipv4_gateway = NULL;
+			data->ipv4_config = old->ipv4_config;
+			old->ipv4_config = NULL;
 		}
 	}
 
@@ -578,30 +578,30 @@ static void set_default_gateway(struct gateway_data *data,
 	else
 		do_ipv4 = do_ipv6 = true;
 
-	if (do_ipv4 && data->ipv4_gateway &&
-					data->ipv4_gateway->vpn) {
+	if (do_ipv4 && data->ipv4_config &&
+					data->ipv4_config->vpn) {
 		connman_inet_set_gateway_interface(data->index);
-		data->ipv4_gateway->active = true;
+		data->ipv4_config->active = true;
 
 		DBG("set %p index %d vpn %s index %d phy %s",
-			data, data->index, data->ipv4_gateway->vpn_ip,
-			data->ipv4_gateway->vpn_phy_index,
-			data->ipv4_gateway->vpn_phy_ip);
+			data, data->index, data->ipv4_config->vpn_ip,
+			data->ipv4_config->vpn_phy_index,
+			data->ipv4_config->vpn_phy_ip);
 
 		__connman_service_indicate_default(data->service);
 
 		return;
 	}
 
-	if (do_ipv6 && data->ipv6_gateway &&
-					data->ipv6_gateway->vpn) {
+	if (do_ipv6 && data->ipv6_config &&
+					data->ipv6_config->vpn) {
 		connman_inet_set_ipv6_gateway_interface(data->index);
-		data->ipv6_gateway->active = true;
+		data->ipv6_config->active = true;
 
 		DBG("set %p index %d vpn %s index %d phy %s",
-			data, data->index, data->ipv6_gateway->vpn_ip,
-			data->ipv6_gateway->vpn_phy_index,
-			data->ipv6_gateway->vpn_phy_ip);
+			data, data->index, data->ipv6_config->vpn_ip,
+			data->ipv6_config->vpn_phy_index,
+			data->ipv6_config->vpn_phy_ip);
 
 		__connman_service_indicate_default(data->service);
 
@@ -610,31 +610,31 @@ static void set_default_gateway(struct gateway_data *data,
 
 	index = __connman_service_get_index(data->service);
 
-	if (do_ipv4 && data->ipv4_gateway &&
-			g_strcmp0(data->ipv4_gateway->gateway,
+	if (do_ipv4 && data->ipv4_config &&
+			g_strcmp0(data->ipv4_config->gateway,
 							"0.0.0.0") == 0) {
 		if (connman_inet_set_gateway_interface(index) < 0)
 			return;
-		data->ipv4_gateway->active = true;
+		data->ipv4_config->active = true;
 		goto done;
 	}
 
-	if (do_ipv6 && data->ipv6_gateway &&
-			g_strcmp0(data->ipv6_gateway->gateway,
+	if (do_ipv6 && data->ipv6_config &&
+			g_strcmp0(data->ipv6_config->gateway,
 							"::") == 0) {
 		if (connman_inet_set_ipv6_gateway_interface(index) < 0)
 			return;
-		data->ipv6_gateway->active = true;
+		data->ipv6_config->active = true;
 		goto done;
 	}
 
-	if (do_ipv6 && data->ipv6_gateway)
+	if (do_ipv6 && data->ipv6_config)
 		status6 = __connman_inet_add_default_to_table(RT_TABLE_MAIN,
-					index, data->ipv6_gateway->gateway);
+					index, data->ipv6_config->gateway);
 
-	if (do_ipv4 && data->ipv4_gateway)
+	if (do_ipv4 && data->ipv4_config)
 		status4 = __connman_inet_add_default_to_table(RT_TABLE_MAIN,
-					index, data->ipv4_gateway->gateway);
+					index, data->ipv4_config->gateway);
 
 	if (status4 < 0 || status6 < 0)
 		return;
@@ -661,60 +661,60 @@ static void unset_default_gateway(struct gateway_data *data,
 	else
 		do_ipv4 = do_ipv6 = true;
 
-	DBG("type %d gateway ipv4 %p ipv6 %p", type, data->ipv4_gateway,
-						data->ipv6_gateway);
+	DBG("type %d gateway ipv4 %p ipv6 %p", type, data->ipv4_config,
+						data->ipv6_config);
 
-	if (do_ipv4 && data->ipv4_gateway &&
-					data->ipv4_gateway->vpn) {
+	if (do_ipv4 && data->ipv4_config &&
+					data->ipv4_config->vpn) {
 		connman_inet_clear_gateway_interface(data->index);
-		data->ipv4_gateway->active = false;
+		data->ipv4_config->active = false;
 
 		DBG("unset %p index %d vpn %s index %d phy %s",
-			data, data->index, data->ipv4_gateway->vpn_ip,
-			data->ipv4_gateway->vpn_phy_index,
-			data->ipv4_gateway->vpn_phy_ip);
+			data, data->index, data->ipv4_config->vpn_ip,
+			data->ipv4_config->vpn_phy_index,
+			data->ipv4_config->vpn_phy_ip);
 
 		return;
 	}
 
-	if (do_ipv6 && data->ipv6_gateway &&
-					data->ipv6_gateway->vpn) {
+	if (do_ipv6 && data->ipv6_config &&
+					data->ipv6_config->vpn) {
 		connman_inet_clear_ipv6_gateway_interface(data->index);
-		data->ipv6_gateway->active = false;
+		data->ipv6_config->active = false;
 
 		DBG("unset %p index %d vpn %s index %d phy %s",
-			data, data->index, data->ipv6_gateway->vpn_ip,
-			data->ipv6_gateway->vpn_phy_index,
-			data->ipv6_gateway->vpn_phy_ip);
+			data, data->index, data->ipv6_config->vpn_ip,
+			data->ipv6_config->vpn_phy_index,
+			data->ipv6_config->vpn_phy_ip);
 
 		return;
 	}
 
 	index = __connman_service_get_index(data->service);
 
-	if (do_ipv4 && data->ipv4_gateway &&
-			g_strcmp0(data->ipv4_gateway->gateway,
+	if (do_ipv4 && data->ipv4_config &&
+			g_strcmp0(data->ipv4_config->gateway,
 							"0.0.0.0") == 0) {
 		connman_inet_clear_gateway_interface(index);
-		data->ipv4_gateway->active = false;
+		data->ipv4_config->active = false;
 		return;
 	}
 
-	if (do_ipv6 && data->ipv6_gateway &&
-			g_strcmp0(data->ipv6_gateway->gateway,
+	if (do_ipv6 && data->ipv6_config &&
+			g_strcmp0(data->ipv6_config->gateway,
 							"::") == 0) {
 		connman_inet_clear_ipv6_gateway_interface(index);
-		data->ipv6_gateway->active = false;
+		data->ipv6_config->active = false;
 		return;
 	}
 
-	if (do_ipv6 && data->ipv6_gateway)
+	if (do_ipv6 && data->ipv6_config)
 		connman_inet_clear_ipv6_gateway_address(index,
-						data->ipv6_gateway->gateway);
+						data->ipv6_config->gateway);
 
-	if (do_ipv4 && data->ipv4_gateway)
+	if (do_ipv4 && data->ipv4_config)
 		connman_inet_clear_gateway_address(index,
-						data->ipv4_gateway->gateway);
+						data->ipv4_config->gateway);
 }
 
 static struct gateway_data *find_default_gateway(void)
@@ -741,15 +741,15 @@ static bool choose_default_gateway(struct gateway_data *data,
 	 * this one as default. If the other one is already active
 	 * we mark this one as non default.
 	 */
-	if (data->ipv4_gateway && candidate->ipv4_gateway) {
+	if (data->ipv4_config && candidate->ipv4_config) {
 
-		if (!candidate->ipv4_gateway->active) {
+		if (!candidate->ipv4_config->active) {
 			DBG("ipv4 downgrading %p", candidate);
 			unset_default_gateway(candidate,
 						CONNMAN_IPCONFIG_TYPE_IPV4);
 		}
 
-		if (candidate->ipv4_gateway->active &&
+		if (candidate->ipv4_config->active &&
 				__connman_service_compare(candidate->service,
 							data->service) < 0) {
 			DBG("ipv4 downgrading this %p", data);
@@ -758,14 +758,14 @@ static bool choose_default_gateway(struct gateway_data *data,
 		}
 	}
 
-	if (data->ipv6_gateway && candidate->ipv6_gateway) {
-		if (!candidate->ipv6_gateway->active) {
+	if (data->ipv6_config && candidate->ipv6_config) {
+		if (!candidate->ipv6_config->active) {
 			DBG("ipv6 downgrading %p", candidate);
 			unset_default_gateway(candidate,
 						CONNMAN_IPCONFIG_TYPE_IPV6);
 		}
 
-		if (candidate->ipv6_gateway->active &&
+		if (candidate->ipv6_config->active &&
 			__connman_service_compare(candidate->service,
 						data->service) < 0) {
 			DBG("ipv6 downgrading this %p", data);
@@ -866,10 +866,10 @@ static void connection_newgateway(int index, const char *gateway)
 	}
 
 	if (!found) {
-		if (data->ipv4_gateway)
+		if (data->ipv4_config)
 			set_default_gateway(data, CONNMAN_IPCONFIG_TYPE_IPV4);
 
-		if (data->ipv6_gateway)
+		if (data->ipv6_config)
 			set_default_gateway(data, CONNMAN_IPCONFIG_TYPE_IPV6);
 	}
 
@@ -884,18 +884,18 @@ static void remove_gateway(gpointer user_data)
 
 	GATEWAY_DATA_DBG("data", data);
 
-	if (data->ipv4_gateway) {
-		g_free(data->ipv4_gateway->gateway);
-		g_free(data->ipv4_gateway->vpn_ip);
-		g_free(data->ipv4_gateway->vpn_phy_ip);
-		g_free(data->ipv4_gateway);
+	if (data->ipv4_config) {
+		g_free(data->ipv4_config->gateway);
+		g_free(data->ipv4_config->vpn_ip);
+		g_free(data->ipv4_config->vpn_phy_ip);
+		g_free(data->ipv4_config);
 	}
 
-	if (data->ipv6_gateway) {
-		g_free(data->ipv6_gateway->gateway);
-		g_free(data->ipv6_gateway->vpn_ip);
-		g_free(data->ipv6_gateway->vpn_phy_ip);
-		g_free(data->ipv6_gateway);
+	if (data->ipv6_config) {
+		g_free(data->ipv6_config->gateway);
+		g_free(data->ipv6_config->vpn_ip);
+		g_free(data->ipv6_config->vpn_phy_ip);
+		g_free(data->ipv6_config);
 	}
 
 	connman_service_unref(data->service);
@@ -980,12 +980,12 @@ static struct gateway_data *find_active_gateway(void)
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		struct gateway_data *data = value;
 
-		if (data->ipv4_gateway &&
-				data->ipv4_gateway->active)
+		if (data->ipv4_config &&
+				data->ipv4_config->active)
 			return data;
 
-		if (data->ipv6_gateway &&
-				data->ipv6_gateway->active)
+		if (data->ipv6_config &&
+				data->ipv6_config->active)
 			return data;
 	}
 
@@ -1129,18 +1129,18 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	GATEWAY_DATA_DBG("active_gateway", active_gateway);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
-				new_gateway->ipv4_gateway) {
+				new_gateway->ipv4_config) {
 		add_host_route(AF_INET, index, gateway, service_type);
 		__connman_service_nameserver_add_routes(service,
-					new_gateway->ipv4_gateway->gateway);
+					new_gateway->ipv4_config->gateway);
 		type4 = CONNMAN_IPCONFIG_TYPE_IPV4;
 	}
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
-				new_gateway->ipv6_gateway) {
+				new_gateway->ipv6_config) {
 		add_host_route(AF_INET6, index, gateway, service_type);
 		__connman_service_nameserver_add_routes(service,
-					new_gateway->ipv6_gateway->gateway);
+					new_gateway->ipv6_config->gateway);
 		type6 = CONNMAN_IPCONFIG_TYPE_IPV6;
 	}
 
@@ -1151,12 +1151,12 @@ int __connman_connection_gateway_add(struct connman_service *service,
 
 	} else {
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
-					new_gateway->ipv4_gateway)
-			new_gateway->ipv4_gateway->vpn = false;
+					new_gateway->ipv4_config)
+			new_gateway->ipv4_config->vpn = false;
 
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
-					new_gateway->ipv6_gateway)
-			new_gateway->ipv6_gateway->vpn = false;
+					new_gateway->ipv6_config)
+			new_gateway->ipv6_config->vpn = false;
 	}
 
 	if (!active_gateway) {
@@ -1165,21 +1165,21 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	}
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
-				new_gateway->ipv4_gateway &&
-				new_gateway->ipv4_gateway->vpn) {
+				new_gateway->ipv4_config &&
+				new_gateway->ipv4_config->vpn) {
 		if (!__connman_service_is_split_routing(new_gateway->service))
 			connman_inet_clear_gateway_address(
 					active_gateway->index,
-					active_gateway->ipv4_gateway->gateway);
+					active_gateway->ipv4_config->gateway);
 	}
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
-				new_gateway->ipv6_gateway &&
-				new_gateway->ipv6_gateway->vpn) {
+				new_gateway->ipv6_config &&
+				new_gateway->ipv6_config->vpn) {
 		if (!__connman_service_is_split_routing(new_gateway->service))
 			connman_inet_clear_ipv6_gateway_address(
 					active_gateway->index,
-					active_gateway->ipv6_gateway->gateway);
+					active_gateway->ipv6_config->gateway);
 	}
 
 done:
@@ -1262,29 +1262,29 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 
 	GATEWAY_DATA_DBG("service_data", data);
 
-	if (do_ipv4 && data->ipv4_gateway)
-		set_default4 = data->ipv4_gateway->vpn;
+	if (do_ipv4 && data->ipv4_config)
+		set_default4 = data->ipv4_config->vpn;
 
-	if (do_ipv6 && data->ipv6_gateway)
-		set_default6 = data->ipv6_gateway->vpn;
+	if (do_ipv6 && data->ipv6_config)
+		set_default6 = data->ipv6_config->vpn;
 
 	DBG("ipv4 gateway %s ipv6 gateway %s vpn %d/%d",
-		data->ipv4_gateway ? data->ipv4_gateway->gateway : "<null>",
-		data->ipv6_gateway ? data->ipv6_gateway->gateway : "<null>",
+		data->ipv4_config ? data->ipv4_config->gateway : "<null>",
+		data->ipv6_config ? data->ipv6_config->gateway : "<null>",
 		set_default4, set_default6);
 
     /* If necessary, delete any VPN-related host routes. */
 
-	if (do_ipv4 && data->ipv4_gateway &&
-			data->ipv4_gateway->vpn && data->index >= 0)
-		connman_inet_del_host_route(data->ipv4_gateway->vpn_phy_index,
-						data->ipv4_gateway->gateway);
+	if (do_ipv4 && data->ipv4_config &&
+			data->ipv4_config->vpn && data->index >= 0)
+		connman_inet_del_host_route(data->ipv4_config->vpn_phy_index,
+						data->ipv4_config->gateway);
 
-	if (do_ipv6 && data->ipv6_gateway &&
-			data->ipv6_gateway->vpn && data->index >= 0)
+	if (do_ipv6 && data->ipv6_config &&
+			data->ipv6_config->vpn && data->index >= 0)
 		connman_inet_del_ipv6_host_route(
-					data->ipv6_gateway->vpn_phy_index,
-						data->ipv6_gateway->gateway);
+					data->ipv6_config->vpn_phy_index,
+						data->ipv6_config->gateway);
 
 	/* Remove all active routes associated with this gateway data. */
 
@@ -1295,15 +1295,15 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	 * of the gateway settings are to be removed.
 	 */
 	if (do_ipv4 == do_ipv6 ||
-		(data->ipv4_gateway && !data->ipv6_gateway
+		(data->ipv4_config && !data->ipv6_config
 			&& do_ipv4) ||
-		(data->ipv6_gateway && !data->ipv4_gateway
+		(data->ipv6_config && !data->ipv4_config
 			&& do_ipv6)) {
 		g_hash_table_remove(gateway_hash, service);
 	} else
 		DBG("Not yet removing gw ipv4 %p/%d ipv6 %p/%d",
-			data->ipv4_gateway, do_ipv4,
-			data->ipv6_gateway, do_ipv6);
+			data->ipv4_config, do_ipv4,
+			data->ipv6_config, do_ipv6);
 
 	/* with vpn this will be called after the network was deleted,
 	 * we need to call set_default here because we will not receive any
@@ -1374,16 +1374,16 @@ bool __connman_connection_update_gateway(void)
 		if (active_gateway == default_gateway)
 			continue;
 
-		if (active_gateway->ipv4_gateway &&
-				active_gateway->ipv4_gateway->active) {
+		if (active_gateway->ipv4_config &&
+				active_gateway->ipv4_config->active) {
 
 			unset_default_gateway(active_gateway,
 						CONNMAN_IPCONFIG_TYPE_IPV4);
 			updated = true;
 		}
 
-		if (active_gateway->ipv6_gateway &&
-				active_gateway->ipv6_gateway->active) {
+		if (active_gateway->ipv6_config &&
+				active_gateway->ipv6_config->active) {
 
 			unset_default_gateway(active_gateway,
 						CONNMAN_IPCONFIG_TYPE_IPV6);
@@ -1396,13 +1396,13 @@ bool __connman_connection_update_gateway(void)
 	 * set as active yet.
 	 */
 	if (default_gateway) {
-		if (default_gateway->ipv4_gateway &&
-			(updated || !default_gateway->ipv4_gateway->active))
+		if (default_gateway->ipv4_config &&
+			(updated || !default_gateway->ipv4_config->active))
 			set_default_gateway(default_gateway,
 					CONNMAN_IPCONFIG_TYPE_IPV4);
 
-		if (default_gateway->ipv6_gateway &&
-			(updated || !default_gateway->ipv6_gateway->active))
+		if (default_gateway->ipv6_config &&
+			(updated || !default_gateway->ipv6_config->active))
 			set_default_gateway(default_gateway,
 					CONNMAN_IPCONFIG_TYPE_IPV6);
 	}
@@ -1420,12 +1420,12 @@ int __connman_connection_get_vpn_index(int phy_index)
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		struct gateway_data *data = value;
 
-		if (data->ipv4_gateway &&
-				data->ipv4_gateway->vpn_phy_index == phy_index)
+		if (data->ipv4_config &&
+				data->ipv4_config->vpn_phy_index == phy_index)
 			return data->index;
 
-		if (data->ipv6_gateway &&
-				data->ipv6_gateway->vpn_phy_index == phy_index)
+		if (data->ipv6_config &&
+				data->ipv6_config->vpn_phy_index == phy_index)
 			return data->index;
 	}
 
@@ -1445,11 +1445,11 @@ int __connman_connection_get_vpn_phy_index(int vpn_index)
 		if (data->index != vpn_index)
 			continue;
 
-		if (data->ipv4_gateway)
-			return data->ipv4_gateway->vpn_phy_index;
+		if (data->ipv4_config)
+			return data->ipv4_config->vpn_phy_index;
 
-		if (data->ipv6_gateway)
-			return data->ipv6_gateway->vpn_phy_index;
+		if (data->ipv6_config)
+			return data->ipv6_config->vpn_phy_index;
 	}
 
 	return -1;
-- 
2.42.0

