Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3065328C8
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2853B73145
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:01 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C4B8873156
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 07/90] connection: Introduce gateway configuration 'type'.
Date: Wed,  6 Dec 2023 15:49:30 -0800
Message-ID: <20231206235056.322578-8-gerickson@nuovations.com>
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

This adds a new gateway configuration field, 'type', an enumeration
indicating the current type or use of the gateway configuration. This
may be used in conjunction with the 'state' and 'flags' fields to
conditionally treat the gateway configuration.
---
 src/connection.c | 69 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 17d3805cd5fd..bcecd886b85b 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -81,6 +81,11 @@ enum gateway_config_state {
 	CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE	  = 1
 };
 
+enum gateway_config_type {
+	CONNMAN_GATEWAY_CONFIG_TYPE_NONE				  = 0,
+	CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT = 1
+};
+
 struct gateway_config {
 	/**
 	 *	A 32-bit flag bitfield governing the state and use of the
@@ -93,6 +98,7 @@ struct gateway_config {
 	 *	#gateway_config_state.
 	 */
 	enum gateway_config_state state;
+	enum gateway_config_type type;
 	char *gateway;
 
 	/* VPN extra data */
@@ -193,6 +199,18 @@ static const char *gateway_config_state2string(enum gateway_config_state state)
 	return NULL;
 }
 
+static const char *gateway_config_type2string(enum gateway_config_type type)
+{
+	switch (type) {
+	case CONNMAN_GATEWAY_CONFIG_TYPE_NONE:
+		return "none";
+	case CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT:
+		return "high-priority default";
+	}
+
+	return NULL;
+}
+
 static void gateway_config_state_set(struct gateway_config *config,
 				enum gateway_config_state state)
 {
@@ -216,6 +234,17 @@ static bool is_gateway_config_state_active(const struct gateway_config *config)
 				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
 }
 
+static void gateway_config_type_set(struct gateway_config *config,
+				enum gateway_config_type type)
+{
+	DBG("config %p old type %d (%s) => new type %d (%s)",
+		config,
+		config->type, gateway_config_type2string(config->type),
+		type, gateway_config_type2string(type));
+
+	config->type = type;
+}
+
 /**
  *  @brief
  *    Conditionally log the specified gateway configuration.
@@ -255,7 +284,7 @@ static void gateway_config_debug(const char *function,
 				connman_inet_ifname(config->vpn_phy_index);
 
 		DBG("from %s() "
-			"%s %p: { state: %d (%s), "
+			"%s %p: { state: %d (%s), type %d (%s), "
 			"flags: 0x%x (%s), "
 			"gateway: %p (%s), "
 			"vpn_ip: %p (%s), vpn_phy_index: %d (%s), "
@@ -265,6 +294,8 @@ static void gateway_config_debug(const char *function,
 			config,
 			config->state,
 			maybe_null(gateway_config_state2string(config->state)),
+			config->type,
+			maybe_null(gateway_config_type2string(config->type)),
 			config->flags,
 			is_gateway_config_vpn(config) ? "VPN" : "",
 			config->gateway, maybe_null(config->gateway),
@@ -977,6 +1008,7 @@ static int add_gateway(struct connman_service *service,
 		return -ENOMEM;
 
 	config->state = CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE;
+	config->type = CONNMAN_GATEWAY_CONFIG_TYPE_NONE;
 	config->flags = CONNMAN_GATEWAY_CONFIG_FLAG_NONE;
 	config->gateway = g_strdup(gateway);
 	config->vpn_ip = NULL;
@@ -1097,6 +1129,9 @@ static void set_default_gateway(struct gateway_data *data,
 			DBG("set %p index %d gateway %s",
 				data, data->index, data->ipv4_config->gateway);
 		}
+
+		gateway_config_type_set(data->ipv4_config,
+			CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT);
 	}
 
 	if (do_ipv6 && data->ipv6_config) {
@@ -1129,6 +1164,9 @@ static void set_default_gateway(struct gateway_data *data,
 			DBG("set %p index %d gateway %s",
 				data, data->index, data->ipv4_config->gateway);
 		}
+
+		gateway_config_type_set(data->ipv6_config,
+			CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT);
 	}
 
 	DBG("status4 %d status6 %d", status4, status6);
@@ -1270,6 +1308,8 @@ static void unset_default_gateway(struct gateway_data *data,
 static bool yield_default_gateway(struct gateway_data *activated,
 					struct gateway_data *existing)
 {
+	static const enum gateway_config_type config_type =
+		CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT;
 	enum connman_ipconfig_type type;
 	bool yield_activated = false;
 
@@ -1293,7 +1333,11 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		 * activated gateway data.
 		 */
 		if (!is_gateway_config_state_active(existing->ipv4_config)) {
-			DBG("ipv4 existing %p yielding default", existing);
+			DBG("%s existing %p yielding %s",
+				__connman_ipconfig_type2string(type),
+				existing,
+				maybe_null(gateway_config_type2string(
+					config_type)));
 
 			unset_default_gateway(existing, type);
 		}
@@ -1308,7 +1352,11 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		if (is_gateway_config_state_active(existing->ipv4_config) &&
 				__connman_service_compare(existing->service,
 						activated->service) < 0) {
-			DBG("ipv4 activated %p yielding default", activated);
+			DBG("%s activated %p yielding %s",
+				__connman_ipconfig_type2string(type),
+				activated,
+				maybe_null(gateway_config_type2string(
+					config_type)));
 
 			unset_default_gateway(activated, type);
 
@@ -1331,7 +1379,11 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		 * activated gateway data.
 		 */
 		if (!is_gateway_config_state_active(existing->ipv6_config)) {
-			DBG("ipv6 existing %p yielding default", existing);
+			DBG("%s existing %p yielding %s",
+				__connman_ipconfig_type2string(type),
+				existing,
+				maybe_null(gateway_config_type2string(
+					config_type)));
 
 			unset_default_gateway(existing, type);
 		}
@@ -1346,7 +1398,11 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		if (is_gateway_config_state_active(existing->ipv6_config) &&
 			__connman_service_compare(existing->service,
 					activated->service) < 0) {
-			DBG("ipv6 activated %p yielding default", activated);
+			DBG("%s activated %p yielding %s",
+				__connman_ipconfig_type2string(type),
+				activated,
+				maybe_null(gateway_config_type2string(
+					config_type)));
 
 			unset_default_gateway(activated, type);
 
@@ -1572,6 +1628,9 @@ static void connection_delgateway(int index, const char *gateway)
 
 		gateway_config_state_set(config,
 			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
+
+		gateway_config_type_set(config,
+			CONNMAN_GATEWAY_CONFIG_TYPE_NONE);
 	}
 
 	/*
-- 
2.42.0

