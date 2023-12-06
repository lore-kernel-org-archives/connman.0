Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D919328C6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0014773144
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:00 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B735473159
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 05/90] connection: Replace gateway config VPN Boolean.
Date: Wed,  6 Dec 2023 15:49:28 -0800
Message-ID: <20231206235056.322578-6-gerickson@nuovations.com>
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

There is presently overloading of gateway configuration state. That
is, using configuration fields for purposes beyond those for which
they may have originally been intended.

While the current VPN Boolean appears unoverloaded, this migrates it
from a single Boolean to a flag in a 32-bit flags field, allowing for
other future flags that alter how a gateway configuration behaves or
is treated, relative to its state and type.
---
 src/connection.c | 91 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 20 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 63c22be0cf83..b13403c4a673 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -38,6 +38,11 @@
 #define GATEWAY_DATA_DBG(description, data) \
 	gateway_data_debug(__func__, description, data)
 
+enum gateway_config_flags {
+	CONNMAN_GATEWAY_CONFIG_FLAG_NONE = 0,
+	CONNMAN_GATEWAY_CONFIG_FLAG_VPN	 = 1U << 0
+};
+
 /**
  *	@brief
  *    Indicates the current lifecycle state of the gateway
@@ -67,6 +72,7 @@ enum gateway_config_state {
 };
 
 struct gateway_config {
+	uint32_t flags;
 
 	/**
 	 *	Indicates the current state of the gateway configuration. See
@@ -76,7 +82,6 @@ struct gateway_config {
 	char *gateway;
 
 	/* VPN extra data */
-	bool vpn;
 	char *vpn_ip;
 	int vpn_phy_index;
 	char *vpn_phy_ip;
@@ -120,6 +125,48 @@ static const char *maybe_null(const void *pointer)
 	return pointer ? pointer : "<null>";
 }
 
+static bool is_gateway_config_flags_set(const struct gateway_config *config,
+		uint32_t flags)
+{
+	return config && ((config->flags & flags) == flags);
+}
+
+static void gateway_config_flags_clear(struct gateway_config *config,
+		uint32_t flags)
+{
+	config->flags &= ~flags;
+}
+
+static void gateway_config_flags_set(struct gateway_config *config,
+	uint32_t flags)
+{
+	config->flags |= flags;
+}
+
+static bool is_gateway_config_vpn(const struct gateway_config *config)
+{
+	static const uint32_t flags =
+		CONNMAN_GATEWAY_CONFIG_FLAG_VPN;
+
+	return is_gateway_config_flags_set(config, flags);
+}
+
+static void gateway_config_set_vpn(struct gateway_config *config)
+{
+	static const uint32_t flags =
+		CONNMAN_GATEWAY_CONFIG_FLAG_VPN;
+
+	return gateway_config_flags_set(config, flags);
+}
+
+static void gateway_config_clear_vpn(struct gateway_config *config)
+{
+	static const uint32_t flags =
+		CONNMAN_GATEWAY_CONFIG_FLAG_VPN;
+
+	return gateway_config_flags_clear(config, flags);
+}
+
 static const char *gateway_config_state2string(enum gateway_config_state state)
 {
 	switch (state) {
@@ -194,16 +241,19 @@ static void gateway_config_debug(const char *function,
 				connman_inet_ifname(config->vpn_phy_index);
 
 		DBG("from %s() "
-			"%s %p: { state: %d (%s), gateway: %p (%s), "
-			"vpn: %u, vpn_ip: %p (%s), vpn_phy_index: %d (%s), "
+			"%s %p: { state: %d (%s), "
+			"flags: 0x%x (%s), "
+			"gateway: %p (%s), "
+			"vpn_ip: %p (%s), vpn_phy_index: %d (%s), "
 			"vpn_phy_ip: %p (%s) }",
 			function,
 			description,
 			config,
 			config->state,
 			maybe_null(gateway_config_state2string(config->state)),
+			config->flags,
+			is_gateway_config_vpn(config) ? "VPN" : "",
 			config->gateway, maybe_null(config->gateway),
-			config->vpn,
 			config->vpn_ip, maybe_null(config->vpn_ip),
 			config->vpn_phy_index, maybe_null(vpn_phy_interface),
 			config->vpn_phy_ip, maybe_null(config->vpn_phy_ip));
@@ -590,7 +640,8 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 		int index = __connman_ipconfig_get_index(ipconfig);
 		struct get_gateway_params *params;
 
-		config->vpn = true;
+		gateway_config_set_vpn(config);
+
 		if (peer)
 			config->vpn_ip = g_strdup(peer);
 		else if (gateway)
@@ -720,7 +771,7 @@ static int del_gateway_routes(struct gateway_data *data,
 		return -EINVAL;
 
 	if (do_ipv4 && data->ipv4_config) {
-		if (data->ipv4_config->vpn) {
+		if (is_gateway_config_vpn(data->ipv4_config)) {
 			status4 = connman_inet_clear_gateway_address(
 						data->index,
 						data->ipv4_config->vpn_ip);
@@ -738,7 +789,7 @@ static int del_gateway_routes(struct gateway_data *data,
 	}
 
 	if (do_ipv6 && data->ipv6_config) {
-		if (data->ipv6_config->vpn) {
+		if (is_gateway_config_vpn(data->ipv6_config)) {
 			status6 = connman_inet_clear_ipv6_gateway_address(
 						data->index,
 						data->ipv6_config->vpn_ip);
@@ -912,10 +963,10 @@ static int add_gateway(struct connman_service *service,
 		return -ENOMEM;
 
 	config->state = CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE;
+	config->flags = CONNMAN_GATEWAY_CONFIG_FLAG_NONE;
 	config->gateway = g_strdup(gateway);
 	config->vpn_ip = NULL;
 	config->vpn_phy_ip = NULL;
-	config->vpn = false;
 	config->vpn_phy_index = -1;
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
@@ -1003,7 +1054,7 @@ static void set_default_gateway(struct gateway_data *data,
 		return;
 
 	if (do_ipv4 && data->ipv4_config) {
-		if (data->ipv4_config->vpn) {
+		if (is_gateway_config_vpn(data->ipv4_config)) {
 			connman_inet_set_gateway_interface(data->index);
 
 			gateway_config_state_set(data->ipv4_config,
@@ -1035,7 +1086,7 @@ static void set_default_gateway(struct gateway_data *data,
 	}
 
 	if (do_ipv6 && data->ipv6_config) {
-		if (data->ipv6_config->vpn) {
+		if (is_gateway_config_vpn(data->ipv6_config)) {
 			connman_inet_set_ipv6_gateway_interface(data->index);
 
 			gateway_config_state_set(data->ipv6_config,
@@ -1121,7 +1172,7 @@ static void unset_default_gateway(struct gateway_data *data,
 		return;
 
 	if (do_ipv4 && data->ipv4_config) {
-		if (data->ipv4_config->vpn) {
+		if (is_gateway_config_vpn(data->ipv4_config)) {
 			connman_inet_clear_gateway_interface(data->index);
 
 			gateway_config_state_set(data->ipv4_config,
@@ -1149,7 +1200,7 @@ static void unset_default_gateway(struct gateway_data *data,
 	}
 
 	if (do_ipv6 && data->ipv6_config) {
-		if (data->ipv6_config->vpn) {
+		if (is_gateway_config_vpn(data->ipv6_config)) {
 			connman_inet_clear_ipv6_gateway_interface(data->index);
 
 			gateway_config_state_set(data->ipv6_config,
@@ -1687,11 +1738,11 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	} else {
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
 					new_gateway->ipv4_config)
-			new_gateway->ipv4_config->vpn = false;
+			gateway_config_clear_vpn(new_gateway->ipv4_config);
 
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
 					new_gateway->ipv6_config)
-			new_gateway->ipv6_config->vpn = false;
+			gateway_config_clear_vpn(new_gateway->ipv6_config);
 	}
 
 	if (!any_active_gateway) {
@@ -1700,8 +1751,8 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	}
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
-				new_gateway->ipv4_config &&
-				new_gateway->ipv4_config->vpn) {
+			new_gateway->ipv4_config &&
+			is_gateway_config_vpn(new_gateway->ipv4_config)) {
 		if (!__connman_service_is_split_routing(new_gateway->service))
 			connman_inet_clear_gateway_address(
 				any_active_gateway->index,
@@ -1709,8 +1760,8 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	}
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
-				new_gateway->ipv6_config &&
-				new_gateway->ipv6_config->vpn) {
+			new_gateway->ipv6_config &&
+			is_gateway_config_vpn(new_gateway->ipv6_config)) {
 		if (!__connman_service_is_split_routing(new_gateway->service))
 			connman_inet_clear_ipv6_gateway_address(
 				any_active_gateway->index,
@@ -1791,10 +1842,10 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	GATEWAY_DATA_DBG("service_data", data);
 
 	if (do_ipv4 && data->ipv4_config)
-		is_vpn4 = data->ipv4_config->vpn;
+		is_vpn4 = is_gateway_config_vpn(data->ipv4_config);
 
 	if (do_ipv6 && data->ipv6_config)
-		is_vpn6 = data->ipv6_config->vpn;
+		is_vpn6 = is_gateway_config_vpn(data->ipv6_config);
 
 	DBG("ipv4 gateway %s ipv6 gateway %s vpn %d/%d",
 		data->ipv4_config ? data->ipv4_config->gateway : "<null>",
-- 
2.42.0

