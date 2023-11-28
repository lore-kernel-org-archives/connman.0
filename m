Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED15733D
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ECDE57314E
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:08:49 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A3BBC7315A
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:08:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/8] connection: Introduce and leverage 'gateway_{config,data}_debug'.
Date: Tue, 28 Nov 2023 15:08:41 -0800
Message-ID: <20231128230847.1224497-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128230847.1224497-1-gerickson@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This introduces and leverages two functions
'gateway_{config,data}_debug' to conditionally log gateway data and
configuration at the debug level.
---
 src/connection.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 9d2c6961306d..cba1508da3b8 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -32,6 +32,12 @@
 
 #include "connman.h"
 
+#define GATEWAY_CONFIG_DBG(description, config) \
+	gateway_config_debug(__func__, description, config)
+
+#define GATEWAY_DATA_DBG(description, data) \
+	gateway_data_debug(__func__, description, data)
+
 struct gateway_config {
 	bool active;
 	char *gateway;
@@ -53,6 +59,79 @@ struct gateway_data {
 
 static GHashTable *gateway_hash = NULL;
 
+static const char *maybe_null(const void *pointer)
+{
+	return pointer ? pointer : "<null>";
+}
+
+static void gateway_config_debug(const char *function,
+				const char *description,
+				const struct gateway_config *config)
+{
+	g_autofree char *vpn_phy_interface = NULL;
+
+	if (!function || !description)
+		return;
+
+	if (!config)
+		CONNMAN_DEBUG(function, "%s %p", description, config);
+	else {
+		if (config->vpn_phy_index >= 0)
+			vpn_phy_interface =
+				connman_inet_ifname(config->vpn_phy_index);
+
+		CONNMAN_DEBUG(function,
+			"%s %p: { active: %u, gateway: %p (%s), "
+			"vpn: %u, vpn_ip: %p (%s), vpn_phy_index: %d (%s), "
+			"vpn_phy_ip: %p (%s) }",
+			description,
+			config,
+			config->active,
+			config->gateway, maybe_null(config->gateway),
+			config->vpn,
+			config->vpn_ip, maybe_null(config->vpn_ip),
+			config->vpn_phy_index, maybe_null(vpn_phy_interface),
+			config->vpn_phy_ip, maybe_null(config->vpn_phy_ip));
+	}
+}
+
+static void gateway_data_debug(const char *function,
+				const char *description,
+				const struct gateway_data *data)
+{
+	g_autofree char *interface = NULL;
+
+	if (!function || !description)
+		return;
+
+	if (!data)
+		CONNMAN_DEBUG(function, "%s %p", description, data);
+	else {
+		interface = connman_inet_ifname(data->index);
+
+		CONNMAN_DEBUG(function,
+			"%s %p: { index: %d (%s), service: %p (%s), "
+			"ipv4_gateway: %p, ipv6_gateway: %p, default_checked: %u }",
+			description,
+			data,
+			data->index,
+			maybe_null(interface),
+			data->service,
+			connman_service_get_identifier(data->service),
+			data->ipv4_gateway,
+			data->ipv6_gateway,
+			data->default_checked);
+
+		if (data->ipv4_gateway)
+			gateway_config_debug(function, "ipv4_gateway",
+				data->ipv4_gateway);
+
+		if (data->ipv6_gateway)
+			gateway_config_debug(function, "ipv6_gateway",
+				data->ipv6_gateway);
+	}
+}
+
 static struct gateway_config *find_gateway(int index, const char *gateway)
 {
 	GHashTableIter iter;
@@ -282,6 +361,8 @@ static int del_routes(struct gateway_data *data,
 	int status4 = 0, status6 = 0;
 	bool do_ipv4 = false, do_ipv6 = false;
 
+	GATEWAY_DATA_DBG("data", data);
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		do_ipv4 = true;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
@@ -334,6 +415,8 @@ static int disable_gateway(struct gateway_data *data,
 {
 	bool active = false;
 
+	GATEWAY_DATA_DBG("data", data);
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		if (data->ipv4_gateway)
 			active = data->ipv4_gateway->active;
@@ -426,6 +509,8 @@ static void set_default_gateway(struct gateway_data *data,
 	int status4 = 0, status6 = 0;
 	bool do_ipv4 = false, do_ipv6 = false;
 
+	GATEWAY_DATA_DBG("data", data);
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		do_ipv4 = true;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
@@ -507,6 +592,8 @@ static void unset_default_gateway(struct gateway_data *data,
 	int index;
 	bool do_ipv4 = false, do_ipv6 = false;
 
+	GATEWAY_DATA_DBG("data", data);
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		do_ipv4 = true;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
@@ -586,6 +673,9 @@ static bool choose_default_gateway(struct gateway_data *data,
 {
 	bool downgraded = false;
 
+	GATEWAY_DATA_DBG("data", data);
+	GATEWAY_DATA_DBG("candidate", candidate);
+
 	/*
 	 * If the current default is not active, then we mark
 	 * this one as default. If the other one is already active
@@ -641,6 +731,8 @@ static void connection_newgateway(int index, const char *gateway)
 	if (!config)
 		return;
 
+	GATEWAY_CONFIG_DBG("config", config);
+
 	config->active = true;
 
 	/*
@@ -652,6 +744,8 @@ static void connection_newgateway(int index, const char *gateway)
 	if (!data)
 		return;
 
+	GATEWAY_DATA_DBG("data", data);
+
 	if (data->default_checked)
 		return;
 
@@ -690,6 +784,8 @@ static void remove_gateway(gpointer user_data)
 
 	DBG("gateway ipv4 %p ipv6 %p", data->ipv4_gateway, data->ipv6_gateway);
 
+	GATEWAY_DATA_DBG("data", data);
+
 	if (data->ipv4_gateway) {
 		g_free(data->ipv4_gateway->gateway);
 		g_free(data->ipv4_gateway->vpn_ip);
@@ -717,12 +813,18 @@ static void connection_delgateway(int index, const char *gateway)
 	DBG("index %d gateway %s", index, gateway);
 
 	config = find_gateway(index, gateway);
-	if (config)
+	if (config) {
+		GATEWAY_CONFIG_DBG("config", config);
+
 		config->active = false;
+	}
 
 	data = find_default_gateway();
-	if (data)
+	if (data) {
+		GATEWAY_DATA_DBG("data", data);
+
 		set_default_gateway(data, CONNMAN_IPCONFIG_TYPE_ALL);
+	}
 }
 
 static struct connman_rtnl connection_rtnl = {
@@ -836,11 +938,15 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	if (!new_gateway)
 		return -EINVAL;
 
+	GATEWAY_DATA_DBG("new_gateway", new_gateway);
+
 	active_gateway = find_active_gateway();
 
 	DBG("active %p index %d new %p", active_gateway,
 		active_gateway ? active_gateway->index : -1, new_gateway);
 
+	GATEWAY_DATA_DBG("active_gateway", active_gateway);
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
 				new_gateway->ipv4_gateway) {
 		add_host_route(AF_INET, index, gateway, service_type);
@@ -931,6 +1037,8 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	if (!data)
 		return;
 
+	GATEWAY_DATA_DBG("service_data", data);
+
 	if (do_ipv4 && data->ipv4_gateway)
 		set_default4 = data->ipv4_gateway->vpn;
 
@@ -977,6 +1085,9 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	 */
 	if (set_default4 || set_default6 || err < 0) {
 		data = find_default_gateway();
+
+		GATEWAY_DATA_DBG("default_data", data);
+
 		if (data)
 			set_default_gateway(data, type);
 	}
@@ -996,6 +1107,8 @@ bool __connman_connection_update_gateway(void)
 
 	DBG("default %p", default_gateway);
 
+	GATEWAY_DATA_DBG("default_gateway", default_gateway);
+
 	/*
 	 * There can be multiple active gateways so we need to
 	 * check them all.
@@ -1005,6 +1118,8 @@ bool __connman_connection_update_gateway(void)
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		struct gateway_data *active_gateway = value;
 
+		GATEWAY_DATA_DBG("active_gateway", active_gateway);
+
 		if (active_gateway == default_gateway)
 			continue;
 
-- 
2.42.0

