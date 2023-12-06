Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F481328B7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3985E73140
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:59 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id EE4A173147
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 03/90] connection: Replace gateway config active Boolean.
Date: Wed,  6 Dec 2023 15:49:26 -0800
Message-ID: <20231206235056.322578-4-gerickson@nuovations.com>
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

There is presently overloading of gateway configuration state, in
particular, the 'active' field. By "overloading", that is, using the
gateway configuration field for a purpose beyond that for which it may
have been originally intended.

The intent of the 'active' field was to make it a state indicating
that a gateway route, added or deleted, had been confirmed or
"activated" by a Linux Routing Netlink (rtnl) notification via this
module's 'connection_{new,del}gateway' functions.

This returns 'active' to its former and sole role as a representative
of that gateway configuration lifecycle state by making it a state
enumeration, currently with two values, ACTIVE and INACTIVE. In the
future, these will be expanded to further represent all states of the
gateway configuration lifecycle.
---
 src/connection.c | 116 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 27 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 6be39a773df1..6c735f761a54 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -38,8 +38,13 @@
 #define GATEWAY_DATA_DBG(description, data) \
 	gateway_data_debug(__func__, description, data)
 
+enum gateway_config_state {
+	CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE = 0,
+	CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE	  = 1
+};
+
 struct gateway_config {
-	bool active;
+	enum gateway_config_state state;
 	char *gateway;
 
 	/* VPN extra data */
@@ -87,6 +92,41 @@ static const char *maybe_null(const void *pointer)
 	return pointer ? pointer : "<null>";
 }
 
+static const char *gateway_config_state2string(enum gateway_config_state state)
+{
+	switch (state) {
+	case CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE:
+		return "inactive";
+	case CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE:
+		return "active";
+	}
+
+	return NULL;
+}
+
+static void gateway_config_state_set(struct gateway_config *config,
+				enum gateway_config_state state)
+{
+	DBG("config %p old state %d (%s) => new state %d (%s)",
+		config,
+		config->state, gateway_config_state2string(config->state),
+		state, gateway_config_state2string(state));
+
+	config->state = state;
+}
+
+static bool is_gateway_config_state(const struct gateway_config *config,
+				enum gateway_config_state state)
+{
+	return config->state == state;
+}
+
+static bool is_gateway_config_state_active(const struct gateway_config *config)
+{
+	return is_gateway_config_state(config,
+				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+}
+
 /**
  *  @brief
  *    Conditionally log the specified gateway configuration.
@@ -125,13 +165,15 @@ static void gateway_config_debug(const char *function,
 			vpn_phy_interface =
 				connman_inet_ifname(config->vpn_phy_index);
 
-		DBG("from %s %s %p: { active: %u, gateway: %p (%s), "
+		DBG("from %s() "
+			"%s %p: { state: %d (%s), gateway: %p (%s), "
 			"vpn: %u, vpn_ip: %p (%s), vpn_phy_index: %d (%s), "
 			"vpn_phy_ip: %p (%s) }",
 			function,
 			description,
 			config,
-			config->active,
+			config->state,
+			maybe_null(gateway_config_state2string(config->state)),
 			config->gateway, maybe_null(config->gateway),
 			config->vpn,
 			config->vpn_ip, maybe_null(config->vpn_ip),
@@ -380,11 +422,13 @@ static struct gateway_data *find_any_active_gateway_data(void)
 		struct gateway_data *data = value;
 
 		if (data->ipv4_config &&
-				data->ipv4_config->active)
+				is_gateway_config_state_active(
+					data->ipv4_config))
 			return data;
 
 		if (data->ipv6_config &&
-				data->ipv6_config->active)
+				is_gateway_config_state_active(
+					data->ipv6_config))
 			return data;
 	}
 
@@ -738,14 +782,16 @@ static int del_gateway_routes_if_active(struct gateway_data *data,
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		if (data->ipv4_config)
-			active = data->ipv4_config->active;
+			active = is_gateway_config_state_active(
+						data->ipv4_config);
 	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 		if (data->ipv6_config)
-			active = data->ipv6_config->active;
+			active = is_gateway_config_state_active(
+						data->ipv6_config);
 	} else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
 		active = true;
 
-	DBG("type %d active %d", type, active);
+	DBG("active %u", active);
 
 	if (active)
 		return del_gateway_routes(data, type);
@@ -837,12 +883,12 @@ static int add_gateway(struct connman_service *service,
 	if (!config)
 		return -ENOMEM;
 
+	config->state = CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE;
 	config->gateway = g_strdup(gateway);
 	config->vpn_ip = NULL;
 	config->vpn_phy_ip = NULL;
 	config->vpn = false;
 	config->vpn_phy_index = -1;
-	config->active = false;
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		temp_data->ipv4_config = config;
@@ -932,7 +978,8 @@ static void set_default_gateway(struct gateway_data *data,
 		if (data->ipv4_config->vpn) {
 			connman_inet_set_gateway_interface(data->index);
 
-			data->ipv4_config->active = true;
+			gateway_config_state_set(data->ipv4_config,
+				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
 
 			DBG("set %p index %d vpn %s index %d phy %s",
 				data, data->index, data->ipv4_config->vpn_ip,
@@ -943,7 +990,8 @@ static void set_default_gateway(struct gateway_data *data,
 						data->index) < 0)
 				return;
 
-			data->ipv4_config->active = true;
+			gateway_config_state_set(data->ipv4_config,
+				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
 
 			DBG("set %p index %d",
 				data, data->index);
@@ -962,7 +1010,8 @@ static void set_default_gateway(struct gateway_data *data,
 		if (data->ipv6_config->vpn) {
 			connman_inet_set_ipv6_gateway_interface(data->index);
 
-			data->ipv6_config->active = true;
+			gateway_config_state_set(data->ipv6_config,
+				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
 
 			DBG("set %p index %d vpn %s index %d phy %s",
 				data, data->index, data->ipv6_config->vpn_ip,
@@ -973,7 +1022,8 @@ static void set_default_gateway(struct gateway_data *data,
 						data->index) < 0)
 				return;
 
-			data->ipv6_config->active = true;
+			gateway_config_state_set(data->ipv6_config,
+				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
 
 			DBG("set %p index %d",
 				data, data->index);
@@ -1046,7 +1096,8 @@ static void unset_default_gateway(struct gateway_data *data,
 		if (data->ipv4_config->vpn) {
 			connman_inet_clear_gateway_interface(data->index);
 
-			data->ipv4_config->active = false;
+			gateway_config_state_set(data->ipv4_config,
+				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
 			DBG("unset %p index %d vpn %s index %d phy %s",
 				data, data->index, data->ipv4_config->vpn_ip,
@@ -1055,7 +1106,8 @@ static void unset_default_gateway(struct gateway_data *data,
 		} else if (is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
 			connman_inet_clear_gateway_interface(data->index);
 
-			data->ipv4_config->active = false;
+			gateway_config_state_set(data->ipv4_config,
+				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
 			DBG("unset %p index %d",
 				data, data->index);
@@ -1072,7 +1124,8 @@ static void unset_default_gateway(struct gateway_data *data,
 		if (data->ipv6_config->vpn) {
 			connman_inet_clear_ipv6_gateway_interface(data->index);
 
-			data->ipv6_config->active = false;
+			gateway_config_state_set(data->ipv6_config,
+				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
 			DBG("unset %p index %d vpn %s index %d phy %s",
 				data, data->index, data->ipv6_config->vpn_ip,
@@ -1081,7 +1134,8 @@ static void unset_default_gateway(struct gateway_data *data,
 		} else if (is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
 			connman_inet_clear_ipv6_gateway_interface(data->index);
 
-			data->ipv6_config->active = false;
+			gateway_config_state_set(data->ipv6_config,
+				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
 			DBG("unset %p index %d",
 				data, data->index);
@@ -1145,7 +1199,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		 * lifecycle), then it yields the default gateway to the
 		 * activated gateway data.
 		 */
-		if (!existing->ipv4_config->active) {
+		if (!is_gateway_config_state_active(existing->ipv4_config)) {
 			DBG("ipv4 existing %p yielding default", existing);
 
 			unset_default_gateway(existing, type);
@@ -1158,7 +1212,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		 * service sort order, then the activated gateway data yields
 		 * the default gateway to the existing gateway data.
 		 */
-		if (existing->ipv4_config->active &&
+		if (is_gateway_config_state_active(existing->ipv4_config) &&
 				__connman_service_compare(existing->service,
 						activated->service) < 0) {
 			DBG("ipv4 activated %p yielding default", activated);
@@ -1183,7 +1237,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		 * lifecycle), then it yields the default gateway to the
 		 * activated gateway data.
 		 */
-		if (!existing->ipv6_config->active) {
+		if (!is_gateway_config_state_active(existing->ipv6_config)) {
 			DBG("ipv6 existing %p yielding default", existing);
 
 			unset_default_gateway(existing, type);
@@ -1196,7 +1250,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		 * service sort order, then the activated gateway data yields
 		 * the default gateway to the existing gateway data.
 		 */
-		if (existing->ipv6_config->active &&
+		if (is_gateway_config_state_active(existing->ipv6_config) &&
 			__connman_service_compare(existing->service,
 					activated->service) < 0) {
 			DBG("ipv6 activated %p yielding default", activated);
@@ -1333,7 +1387,8 @@ static void connection_newgateway(int index, const char *gateway)
 	 * prospectively mark it as active; however, this may be
 	 * subsequently modified as default route determinations are made.
 	 */
-	config->active = true;
+	gateway_config_state_set(config,
+		CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
 
 	/*
 	 * It is possible that we have two default routes atm
@@ -1422,7 +1477,8 @@ static void connection_delgateway(int index, const char *gateway)
 	if (config) {
 		GATEWAY_CONFIG_DBG("config", config);
 
-		config->active = false;
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 	}
 
 	/*
@@ -1817,7 +1873,8 @@ bool __connman_connection_update_gateway(void)
 			continue;
 
 		if (active_gateway->ipv4_config &&
-				active_gateway->ipv4_config->active) {
+				is_gateway_config_state_active(
+					active_gateway->ipv4_config)) {
 
 			unset_default_gateway(active_gateway,
 						CONNMAN_IPCONFIG_TYPE_IPV4);
@@ -1825,7 +1882,8 @@ bool __connman_connection_update_gateway(void)
 		}
 
 		if (active_gateway->ipv6_config &&
-				active_gateway->ipv6_config->active) {
+				is_gateway_config_state_active(
+					active_gateway->ipv6_config)) {
 
 			unset_default_gateway(active_gateway,
 						CONNMAN_IPCONFIG_TYPE_IPV6);
@@ -1839,12 +1897,16 @@ bool __connman_connection_update_gateway(void)
 	 */
 	if (default_gateway) {
 		if (default_gateway->ipv4_config &&
-			(updated || !default_gateway->ipv4_config->active))
+			(updated ||
+			!is_gateway_config_state_active(
+				default_gateway->ipv4_config)))
 			set_default_gateway(default_gateway,
 					CONNMAN_IPCONFIG_TYPE_IPV4);
 
 		if (default_gateway->ipv6_config &&
-			(updated || !default_gateway->ipv6_config->active))
+			(updated ||
+			!is_gateway_config_state_active(
+				default_gateway->ipv6_config)))
 			set_default_gateway(default_gateway,
 					CONNMAN_IPCONFIG_TYPE_IPV6);
 	}
-- 
2.42.0

