Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90B328C7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C56EB73202
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:19 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 764417321D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:19 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 52/90] connection: Add support for low-priority default routes.
Date: Wed,  6 Dec 2023 15:50:18 -0800
Message-ID: <20231206235056.322578-56-gerickson@nuovations.com>
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

This adds support for low-priority (that is, metric > 0) default
routes along side the existing high-priority (that is, metric 0)
default route taken on by the default service.

For IPv6, these are handled and managed automatically by the kernel as
part of Router Discovery (RD) Router Advertisements (RAs) and because
link-local addresses and multi-homing are a natural part of IPv6,
nothing needs to be done for these here. Such routes show up in 'ip -6
route show' as:

    default via fe80::f29f:c2ff:fe10:271e dev eth0
        proto ra metric 1024 expires 1622sec hoplimit 64
        pref medium
    default via fe80::f29f:c2ff:fe10:271e dev wlan0
        proto ra metric 1024 expires 1354sec hoplimit 64
        pref medium

For IPv4, largely invented before the advent of link-local addresses
and multi-homing hosts, these need to be fully-managed here and, with
such management, should up in 'ip -4 route show' as low-priority (that
is, metric > 0) default routes:

    default via 192.168.2.1 dev wlan0 metric 4294967295

The other alternative to low-priority routes would be to use "def1"
default routes commonly used by VPNs that have a prefix length of 1
(hence the "def1" name). These would should up as:

    0.0.0.0/1 via 192.168.2.1 dev wlan0
    128.0.0.0/1 via 192.168.2.1 dev wlan0

However, since these require twice the number of routing table entries
and seem no more effective than the low-priority route approach, this
alternative is not used here at present.

The low-priority metric is determined on a per-network interface basis
and is computed by 'compute_low_priority_metric'.

Operationally, down calls from outside this module generally come from
the following three functions:

  1. __connman_connection_gateway_add
  2. __connman_connection_gateway_remove
  3. __connman_connection_update_gateway

and up calls generally come from the following two functions:

  1. connection_newgateway
  2. connection_delgateway

From these five functions above, we are then either attempting to do
the following for a gateway associated with a network service and its
underlying network interface:

  1. Set, or add, the high- or low-priority default route(s).
  2. Unset, or remove, the high- or low-priority default route(s).
  3. Promote the default route from low- to high-priority.
  4. Demote the default route from high- to low-priority.
---
 src/connection.c | 371 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 308 insertions(+), 63 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index f29f42870cdf..d41c4010bb61 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -44,6 +44,12 @@
 #define UNSET_DEFAULT_GATEWAY(data, type) \
 	unset_default_gateway(data, type, __func__)
 
+#define SET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type) \
+	set_low_priority_default_gateway(data, type, __func__)
+
+#define UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type) \
+	unset_low_priority_default_gateway(data, type, __func__)
+
 #define GATEWAY_CONFIG_DBG(description, config) \
 	gateway_config_debug(__func__, description, config)
 
@@ -226,6 +232,9 @@ typedef int (*mutate_default_gateway_route_cb_t)(struct gateway_data *data,
 static int unset_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function);
+static int unset_low_priority_default_gateway(struct gateway_data *data,
+				enum connman_ipconfig_type type,
+				const char *function);
 
 /*
  * These are declared as 'const char *const' to effect an immutable
@@ -346,6 +355,26 @@ static bool is_gateway_config_state(const struct gateway_config *config,
 	return config->state == state;
 }
 
+static bool is_gateway_config_state_inactive(
+				const struct gateway_config *config)
+{
+	return is_gateway_config_state(config,
+				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
+}
+
+static bool is_gateway_config_state_added(const struct gateway_config *config)
+{
+	return is_gateway_config_state(config,
+				CONNMAN_GATEWAY_CONFIG_STATE_ADDED);
+}
+
+static bool is_gateway_config_state_removed(
+				const struct gateway_config *config)
+{
+	return is_gateway_config_state(config,
+				CONNMAN_GATEWAY_CONFIG_STATE_REMOVED);
+}
+
 static bool is_gateway_config_state_active(const struct gateway_config *config)
 {
 	return is_gateway_config_state(config,
@@ -363,6 +392,18 @@ static void gateway_config_type_set(struct gateway_config *config,
 	config->type = type;
 }
 
+static bool is_gateway_config_type(const struct gateway_config *config,
+				enum gateway_config_type type)
+{
+	return config->type == type;
+}
+
+static bool is_gateway_config_type_none(const struct gateway_config *config)
+{
+	return is_gateway_config_type(config,
+				CONNMAN_GATEWAY_CONFIG_TYPE_NONE);
+}
+
 /**
  *  @brief
  *    Conditionally log the specified gateway configuration.
@@ -988,6 +1029,7 @@ static int del_gateway_routes(struct gateway_data *data,
 
 			status4 = UNSET_DEFAULT_GATEWAY(data, type);
 
+			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type);
 		}
 	}
 
@@ -1003,6 +1045,7 @@ static int del_gateway_routes(struct gateway_data *data,
 
 			status6 = UNSET_DEFAULT_GATEWAY(data, type);
 
+			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type);
 		}
 	}
 
@@ -1329,10 +1372,23 @@ static int set_default_gateway_route_common(struct gateway_data *data,
 	if (!data || !config || !cb)
 		return -EINVAL;
 
+	if (!is_gateway_config_type_none(config) &&
+		!is_gateway_config_type(config, type))
+		return -EINVAL;
+
+	if (is_gateway_config_state_added(config))
+		return -EINPROGRESS;
+
+	if (is_gateway_config_state_active(config))
+		return -EALREADY;
+
 	err = cb(data, config);
 	if (err < 0)
 		goto done;
 
+	gateway_config_state_set(config,
+		CONNMAN_GATEWAY_CONFIG_STATE_ADDED);
+
 	gateway_config_type_set(config, type);
 
 done:
@@ -1392,10 +1448,22 @@ static int unset_default_gateway_route_common(struct gateway_data *data,
 	if (!data || !config || !cb)
 		return -EINVAL;
 
+	if (!is_gateway_config_type(config, type))
+		return -EINVAL;
+
+	if (is_gateway_config_state_removed(config))
+		return -EINPROGRESS;
+
+	if (is_gateway_config_state_inactive(config))
+		return -EALREADY;
+
 	err = cb(data, config);
 	if (err < 0)
 		goto done;
 
+	gateway_config_state_set(config,
+		CONNMAN_GATEWAY_CONFIG_STATE_REMOVED);
+
 done:
 	return err;
 }
@@ -1407,23 +1475,20 @@ static int set_ipv4_high_priority_default_gateway_route_cb(
 	int err = 0;
 
 	if (is_gateway_config_vpn(config)) {
-		connman_inet_set_gateway_interface(data->index);
-
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+		err = connman_inet_set_gateway_interface(data->index);
+		if (err < 0)
+			goto done;
 
 		DBG("set %p index %d vpn %s index %d phy %s",
 			data, data->index, config->vpn_ip,
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
 	} else if (is_ipv4_addr_any_str(config->gateway)) {
-		if (connman_inet_set_gateway_interface(
-					data->index) < 0)
+		err = connman_inet_set_gateway_interface(
+					data->index);
+		if (err < 0)
 			goto done;
 
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
-
 		DBG("set %p index %d",
 			data, data->index);
 	} else {
@@ -1449,23 +1514,20 @@ static int set_ipv6_high_priority_default_gateway_route_cb(
 	int err = 0;
 
 	if (is_gateway_config_vpn(config)) {
-		connman_inet_set_ipv6_gateway_interface(data->index);
-
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+		err = connman_inet_set_ipv6_gateway_interface(data->index);
+		if (err < 0)
+			goto done;
 
 		DBG("set %p index %d vpn %s index %d phy %s",
 			data, data->index, config->vpn_ip,
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
 	} else if (is_ipv6_addr_any_str(config->gateway)) {
-		if (connman_inet_set_ipv6_gateway_interface(
-					data->index) < 0)
+		err = connman_inet_set_ipv6_gateway_interface(
+					data->index);
+		if (err < 0)
 			goto done;
 
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
-
 		DBG("set %p index %d",
 			data, data->index);
 	} else {
@@ -1570,31 +1632,32 @@ static int unset_ipv4_high_priority_default_gateway_route_cb(
 	int err = 0;
 
 	if (is_gateway_config_vpn(config)) {
-		connman_inet_clear_gateway_interface(data->index);
-
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
+		err = connman_inet_clear_gateway_interface(data->index);
+		if (err < 0)
+			goto done;
 
 		DBG("unset %p index %d vpn %s index %d phy %s",
 			data, data->index, config->vpn_ip,
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
 	} else if (is_ipv4_addr_any_str(config->gateway)) {
-		connman_inet_clear_gateway_interface(data->index);
-
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
+		err = connman_inet_clear_gateway_interface(data->index);
+		if (err < 0)
+			goto done;
 
 		DBG("unset %p index %d",
 			data, data->index);
 	} else {
-		connman_inet_clear_gateway_address(data->index,
+		err = connman_inet_clear_gateway_address(data->index,
 					config->gateway);
+		if (err < 0)
+			goto done;
 
 		DBG("unset %p index %d gateway %s",
 			data, data->index, config->gateway);
 	}
 
+done:
 	return err;
 }
 
@@ -1605,31 +1668,32 @@ static int unset_ipv6_high_priority_default_gateway_route_cb(
 	int err = 0;
 
 	if (is_gateway_config_vpn(config)) {
-		connman_inet_clear_ipv6_gateway_interface(data->index);
-
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
+		err = connman_inet_clear_ipv6_gateway_interface(data->index);
+		if (err < 0)
+			goto done;
 
 		DBG("unset %p index %d vpn %s index %d phy %s",
 			data, data->index, config->vpn_ip,
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
 	} else if (is_ipv6_addr_any_str(config->gateway)) {
-		connman_inet_clear_ipv6_gateway_interface(data->index);
-
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
+		err = connman_inet_clear_ipv6_gateway_interface(data->index);
+		if (err < 0)
+			goto done;
 
 		DBG("unset %p index %d",
 			data, data->index);
 	} else {
-		connman_inet_clear_ipv6_gateway_address(data->index,
+		err = connman_inet_clear_ipv6_gateway_address(data->index,
 					config->gateway);
+		if (err < 0)
+			goto done;
 
 		DBG("unset %p index %d gateway %s",
 			data, data->index, config->gateway);
 	}
 
+done:
 	return err;
 }
 
@@ -1705,6 +1769,98 @@ static int unset_default_gateway(struct gateway_data *data,
 	return mutate_default_gateway(data, type, &ops, __func__);
 }
 
+static uint32_t compute_low_priority_metric(const struct gateway_data *data)
+{
+	static const uint32_t metric_base = UINT32_MAX;
+	static const uint32_t metric_ceiling = (1 << 20);
+	static const uint32_t metric_index_step = (1 << 10);
+
+	return MAX(metric_ceiling,
+				metric_base -
+				(data->index * metric_index_step));
+}
+
+static int set_ipv4_low_priority_default_gateway_route_cb(
+				struct gateway_data *data,
+				struct gateway_config *config)
+{
+	const uint32_t metric = compute_low_priority_metric(data);
+
+	DBG("using metric %u for index %d", metric, data->index);
+
+	return __connman_inet_add_default_to_table_with_metric(
+				RT_TABLE_MAIN,
+				data->index,
+				config->gateway,
+				metric);
+}
+
+static int set_ipv4_low_priority_default_gateway(
+				struct gateway_data *data,
+				struct gateway_config *config)
+{
+	static const enum gateway_config_type type =
+			CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT;
+	static const mutate_default_gateway_route_cb_t cb =
+			set_ipv4_low_priority_default_gateway_route_cb;
+
+	return set_default_gateway_route_common(data, config, type, cb);
+}
+
+static int set_low_priority_default_gateway(struct gateway_data *data,
+				enum connman_ipconfig_type type,
+				const char *function)
+{
+	static const struct mutate_default_gateway_ops ops = {
+		set_ipv4_low_priority_default_gateway,
+		NULL
+	};
+
+	DBG("from %s()", function);
+
+	return mutate_default_gateway(data, type, &ops, __func__);
+}
+
+static int unset_ipv4_low_priority_default_gateway_route_cb(
+				struct gateway_data *data,
+				struct gateway_config *config)
+{
+	const uint32_t metric = compute_low_priority_metric(data);
+
+	DBG("using metric %u for index %d", metric, data->index);
+
+	return __connman_inet_del_default_from_table_with_metric(
+				RT_TABLE_MAIN,
+				data->index,
+				config->gateway,
+				metric);
+}
+
+static int unset_ipv4_low_priority_default_gateway(struct gateway_data *data,
+				struct gateway_config *config)
+{
+	static const enum gateway_config_type type =
+			CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT;
+	static const mutate_default_gateway_route_cb_t cb =
+			unset_ipv4_low_priority_default_gateway_route_cb;
+
+	return unset_default_gateway_route_common(data, config, type, cb);
+}
+
+static int unset_low_priority_default_gateway(struct gateway_data *data,
+				enum connman_ipconfig_type type,
+				const char *function)
+{
+	static const struct mutate_default_gateway_ops ops = {
+		unset_ipv4_low_priority_default_gateway,
+		NULL
+	};
+
+	DBG("from %s()", function);
+
+	return mutate_default_gateway(data, type, &ops, __func__);
+}
+
 /**
  *  @brief
  *    Decide whether either of the specified gateways should yield the
@@ -1774,6 +1930,8 @@ static bool yield_default_gateway_for_type(struct gateway_data *activated,
 				config_type)));
 
 		UNSET_DEFAULT_GATEWAY(existing, type);
+
+		SET_LOW_PRIORITY_DEFAULT_GATEWAY(existing, type);
 	}
 
 	/*
@@ -1794,6 +1952,8 @@ static bool yield_default_gateway_for_type(struct gateway_data *activated,
 
 		UNSET_DEFAULT_GATEWAY(activated, type);
 
+		SET_LOW_PRIORITY_DEFAULT_GATEWAY(activated, type);
+
 		yield_activated = true;
 	}
 
@@ -1878,6 +2038,7 @@ static void check_default_gateway(struct gateway_data *activated)
 {
 	GHashTableIter iter;
 	gpointer value, key;
+	enum connman_ipconfig_type type;
 	bool yield_activated = false;
 
 	DBG("activated %p", activated);
@@ -1913,13 +2074,21 @@ static void check_default_gateway(struct gateway_data *activated)
 	DBG("yield_activated %u", yield_activated);
 
 	if (!yield_activated) {
-		if (activated->ipv4_config)
-			SET_DEFAULT_GATEWAY(activated,
-				CONNMAN_IPCONFIG_TYPE_IPV4);
+		if (activated->ipv4_config) {
+			type = CONNMAN_IPCONFIG_TYPE_IPV4;
+
+			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(activated, type);
+
+			SET_DEFAULT_GATEWAY(activated, type);
+		}
+
+		if (activated->ipv6_config) {
+			type = CONNMAN_IPCONFIG_TYPE_IPV6;
+
+			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(activated, type);
 
-		if (activated->ipv6_config)
-			SET_DEFAULT_GATEWAY(activated,
-				CONNMAN_IPCONFIG_TYPE_IPV6);
+			SET_DEFAULT_GATEWAY(activated, type);
+		}
 	}
 
 	activated->default_checked = true;
@@ -1971,11 +2140,23 @@ static void connection_newgateway(int index, const char *gateway)
 
 	GATEWAY_CONFIG_DBG("config", config);
 
+    /*
+     * If the state is removed, then we may have gone a full
+     * added/removed cycle before the added gateway route was even
+     * activated. In this case, it is now a stale added
+     * activation; simply ignore it.
+     */
+	if (is_gateway_config_state_removed(config)) {
+		DBG("ignoring gateway stale added activation; "
+			"probably removed before added activation completed");
+
+		return;
+	}
+
 	/*
-	 * Otherwise, this is a gateway, or default router, route we added
-	 * or set and it is now acknowledged by the kernel. Consequently,
-	 * prospectively mark it as active; however, this may be
-	 * subsequently modified as default route determinations are made.
+	 * Otherwise, this is a gateway default route we added, or set,
+	 * and it is now acknowledged by the kernel. Consequently, mark it
+	 * as active.
 	 */
 	gateway_config_state_set(config,
 		CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
@@ -2095,7 +2276,11 @@ static void connection_delgateway(int index, const char *gateway)
 	if (data) {
 		GATEWAY_DATA_DBG("data", data);
 
-		SET_DEFAULT_GATEWAY(data, CONNMAN_IPCONFIG_TYPE_ALL);
+		UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data,
+			CONNMAN_IPCONFIG_TYPE_ALL);
+
+		SET_DEFAULT_GATEWAY(data,
+			CONNMAN_IPCONFIG_TYPE_ALL);
 	}
 }
 
@@ -2194,6 +2379,7 @@ int __connman_connection_gateway_add(struct connman_service *service,
 					const char *peer)
 {
 	struct gateway_data *any_active_gateway = NULL;
+	struct gateway_data *default_gateway = NULL;
 	struct gateway_data *new_gateway = NULL;
 	enum connman_service_type service_type;
 	int index;
@@ -2249,6 +2435,10 @@ int __connman_connection_gateway_add(struct connman_service *service,
 
 	GATEWAY_DATA_DBG("any_active_gateway", any_active_gateway);
 
+	default_gateway = find_default_gateway_data();
+
+	GATEWAY_DATA_DBG("default_gateway", default_gateway);
+
 	if (do_ipv4 && new_gateway->ipv4_config) {
 		add_host_route(AF_INET, index, gateway, service_type);
 		__connman_service_nameserver_add_routes(service,
@@ -2284,9 +2474,26 @@ int __connman_connection_gateway_add(struct connman_service *service,
 			gateway_config_clear_vpn(new_gateway->ipv6_config);
 	}
 
+	/*
+	 * If there is no active gateway, then this is the first and only
+	 * gateway. Set the high-priority default route for the gateway
+	 * and service/network interface tuple.
+	 *
+	 * Otherwise, if there is no default gateway either, then set the
+	 * low-priority default route for the gateway and service/network
+	 * interface tuple.
+	 *
+	 * NOTE: Beyond historical momentum, it is not clear that
+	 * '!any_active_gateway' and 'find_any_active_gateway_data' are
+	 * the best fit here. This should likely be '!default_gateway'
+	 * from 'find_default_gateway_data'.
+	 */
 	if (!any_active_gateway) {
 		SET_DEFAULT_GATEWAY(new_gateway, type);
 		goto done;
+	} else if (default_gateway && !is_vpn4 && !is_vpn6) {
+		SET_LOW_PRIORITY_DEFAULT_GATEWAY(new_gateway, type);
+		goto done;
 	}
 
 	if (is_vpn4) {
@@ -2427,8 +2634,11 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 
 		GATEWAY_DATA_DBG("default_data", data);
 
-		if (data)
+		if (data) {
+			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type);
+
 			SET_DEFAULT_GATEWAY(data, type);
+		}
 	}
 }
 
@@ -2453,9 +2663,11 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 bool __connman_connection_update_gateway(void)
 {
 	struct gateway_data *default_gateway;
-	bool updated = false;
 	GHashTableIter iter;
 	gpointer value, key;
+	enum connman_ipconfig_type type;
+	int set_status = 0, unset_status = 0;
+	bool updated4 = false, updated6 = false;
 
 	DBG("");
 
@@ -2464,7 +2676,7 @@ bool __connman_connection_update_gateway(void)
 	 * nothing to update and do; simply return.
 	 */
 	if (!gateway_hash)
-		return updated;
+		goto done;
 
 	default_gateway = find_default_gateway_data();
 
@@ -2487,43 +2699,76 @@ bool __connman_connection_update_gateway(void)
 		if (current_gateway->ipv4_config &&
 				is_gateway_config_state_active(
 					current_gateway->ipv4_config)) {
+			type = CONNMAN_IPCONFIG_TYPE_IPV4;
 
-			UNSET_DEFAULT_GATEWAY(current_gateway,
-						CONNMAN_IPCONFIG_TYPE_IPV4);
-			updated = true;
+			unset_status =
+				UNSET_DEFAULT_GATEWAY(
+					current_gateway,
+					type);
+
+			set_status =
+				SET_LOW_PRIORITY_DEFAULT_GATEWAY(
+					current_gateway,
+					type);
+
+			updated4 = (unset_status == 0 || set_status == 0);
 		}
 
 		if (current_gateway->ipv6_config &&
 				is_gateway_config_state_active(
 					current_gateway->ipv6_config)) {
+			type = CONNMAN_IPCONFIG_TYPE_IPV6;
 
-			UNSET_DEFAULT_GATEWAY(current_gateway,
-						CONNMAN_IPCONFIG_TYPE_IPV6);
-			updated = true;
+			unset_status =
+				UNSET_DEFAULT_GATEWAY(
+					current_gateway,
+					type);
+
+			set_status =
+				SET_LOW_PRIORITY_DEFAULT_GATEWAY(
+					current_gateway,
+					type);
+
+			updated6 = (unset_status == 0 || set_status == 0);
 		}
 	}
 
+	DBG("updated4 %u updated6 %u", updated4, updated6);
+
 	/*
 	 * Set default gateway if it has been updated or if it has not been
 	 * set as active yet.
 	 */
 	if (default_gateway) {
 		if (default_gateway->ipv4_config &&
-			(updated ||
+			(updated4 ||
 			!is_gateway_config_state_active(
-				default_gateway->ipv4_config)))
+				default_gateway->ipv4_config))) {
+			type = CONNMAN_IPCONFIG_TYPE_IPV4;
+
+			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(default_gateway,
+				type);
+
 			SET_DEFAULT_GATEWAY(default_gateway,
-					CONNMAN_IPCONFIG_TYPE_IPV4);
+				type);
+		}
 
 		if (default_gateway->ipv6_config &&
-			(updated ||
+			(updated6 ||
 			!is_gateway_config_state_active(
-				default_gateway->ipv6_config)))
+				default_gateway->ipv6_config))) {
+			type = CONNMAN_IPCONFIG_TYPE_IPV6;
+
+			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(default_gateway,
+				type);
+
 			SET_DEFAULT_GATEWAY(default_gateway,
-					CONNMAN_IPCONFIG_TYPE_IPV6);
+				type);
+		}
 	}
 
-	return updated;
+done:
+	return updated4 || updated6;
 }
 
 int __connman_connection_get_vpn_index(int phy_index)
-- 
2.42.0

