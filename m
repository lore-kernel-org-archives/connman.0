Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC18328C8
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2DD0573204
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:20 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E4B2473224
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:19 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 53/90] connection: Introduce '{de,pro}mote_default_gateway'.
Date: Wed,  6 Dec 2023 15:50:19 -0800
Message-ID: <20231206235056.322578-57-gerickson@nuovations.com>
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

There are 10 instances of either:

    UNSET_DEFAULT_GATEWAY(data, type);

    SET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type);

or:

    UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type);

    SET_DEFAULT_GATEWAY(data, type);

This formalizes the former as 'demote_default_gateway' and the latter
as 'promote_default_gateway'.

In addition, '{DE,PRO}MOTE_DEFAULT_GATEWAY' macros are added and
leveraged at those 10 call sites. These macros invoke
'{de,pro}mote_default_gateway', passing the C preprocessor predefined
'__func__' macro as the function parameter.
---
 src/connection.c | 181 ++++++++++++++++++++++++++---------------------
 1 file changed, 100 insertions(+), 81 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index d41c4010bb61..1f8152e7a7e4 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -50,6 +50,12 @@
 #define UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type) \
 	unset_low_priority_default_gateway(data, type, __func__)
 
+#define PROMOTE_DEFAULT_GATEWAY(data, type) \
+	promote_default_gateway(data, type, __func__)
+
+#define DEMOTE_DEFAULT_GATEWAY(data, type) \
+	demote_default_gateway(data, type, __func__)
+
 #define GATEWAY_CONFIG_DBG(description, config) \
 	gateway_config_debug(__func__, description, config)
 
@@ -1861,6 +1867,58 @@ static int unset_low_priority_default_gateway(struct gateway_data *data,
 	return mutate_default_gateway(data, type, &ops, __func__);
 }
 
+static int demote_default_gateway(struct gateway_data *data,
+				enum connman_ipconfig_type type,
+				const char *function)
+{
+	int unset_status = 0, set_status = 0;
+
+	DBG("from %s() data %p type %d (%s)",
+		function,
+		data,
+		type, __connman_ipconfig_type2string(type));
+
+	unset_status = UNSET_DEFAULT_GATEWAY(data, type);
+
+	set_status = SET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type);
+
+	DBG("unset_status %d (%s) set_status %d (%s)",
+		unset_status, strerror(-unset_status),
+		set_status, strerror(-set_status));
+
+	/*
+	 * Prefer unset status to set status since unsetting is what effects
+	 * the priority demotion.
+	 */
+	return (unset_status == 0 ? unset_status : set_status);
+}
+
+static int promote_default_gateway(struct gateway_data *data,
+				enum connman_ipconfig_type type,
+				const char *function)
+{
+	int unset_status = 0, set_status = 0;
+
+	DBG("from %s() data %p type %d (%s)",
+		function,
+		data,
+		type, __connman_ipconfig_type2string(type));
+
+	unset_status = UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type);
+
+	set_status = SET_DEFAULT_GATEWAY(data, type);
+
+	DBG("unset_status %d (%s) set_status %d (%s)",
+		unset_status, strerror(-unset_status),
+		set_status, strerror(-set_status));
+
+	/*
+	 * Prefer set status to unset status since setting is what effects
+	 * the priority promotion.
+	 */
+	return (set_status == 0 ? set_status : unset_status);
+}
+
 /**
  *  @brief
  *    Decide whether either of the specified gateways should yield the
@@ -1929,9 +1987,7 @@ static bool yield_default_gateway_for_type(struct gateway_data *activated,
 			maybe_null(gateway_config_type2string(
 				config_type)));
 
-		UNSET_DEFAULT_GATEWAY(existing, type);
-
-		SET_LOW_PRIORITY_DEFAULT_GATEWAY(existing, type);
+		DEMOTE_DEFAULT_GATEWAY(existing, type);
 	}
 
 	/*
@@ -1950,9 +2006,7 @@ static bool yield_default_gateway_for_type(struct gateway_data *activated,
 			maybe_null(gateway_config_type2string(
 				config_type)));
 
-		UNSET_DEFAULT_GATEWAY(activated, type);
-
-		SET_LOW_PRIORITY_DEFAULT_GATEWAY(activated, type);
+		DEMOTE_DEFAULT_GATEWAY(activated, type);
 
 		yield_activated = true;
 	}
@@ -2038,7 +2092,6 @@ static void check_default_gateway(struct gateway_data *activated)
 {
 	GHashTableIter iter;
 	gpointer value, key;
-	enum connman_ipconfig_type type;
 	bool yield_activated = false;
 
 	DBG("activated %p", activated);
@@ -2074,21 +2127,13 @@ static void check_default_gateway(struct gateway_data *activated)
 	DBG("yield_activated %u", yield_activated);
 
 	if (!yield_activated) {
-		if (activated->ipv4_config) {
-			type = CONNMAN_IPCONFIG_TYPE_IPV4;
-
-			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(activated, type);
-
-			SET_DEFAULT_GATEWAY(activated, type);
-		}
-
-		if (activated->ipv6_config) {
-			type = CONNMAN_IPCONFIG_TYPE_IPV6;
+		if (activated->ipv4_config)
+			PROMOTE_DEFAULT_GATEWAY(activated,
+				CONNMAN_IPCONFIG_TYPE_IPV4);
 
-			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(activated, type);
-
-			SET_DEFAULT_GATEWAY(activated, type);
-		}
+		if (activated->ipv6_config)
+			PROMOTE_DEFAULT_GATEWAY(activated,
+				CONNMAN_IPCONFIG_TYPE_IPV6);
 	}
 
 	activated->default_checked = true;
@@ -2276,11 +2321,7 @@ static void connection_delgateway(int index, const char *gateway)
 	if (data) {
 		GATEWAY_DATA_DBG("data", data);
 
-		UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data,
-			CONNMAN_IPCONFIG_TYPE_ALL);
-
-		SET_DEFAULT_GATEWAY(data,
-			CONNMAN_IPCONFIG_TYPE_ALL);
+		PROMOTE_DEFAULT_GATEWAY(data, CONNMAN_IPCONFIG_TYPE_ALL);
 	}
 }
 
@@ -2634,11 +2675,8 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 
 		GATEWAY_DATA_DBG("default_data", data);
 
-		if (data) {
-			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(data, type);
-
-			SET_DEFAULT_GATEWAY(data, type);
-		}
+		if (data)
+			PROMOTE_DEFAULT_GATEWAY(data, type);
 	}
 }
 
@@ -2666,7 +2704,7 @@ bool __connman_connection_update_gateway(void)
 	GHashTableIter iter;
 	gpointer value, key;
 	enum connman_ipconfig_type type;
-	int set_status = 0, unset_status = 0;
+	int status = 0;
 	bool updated4 = false, updated6 = false;
 
 	DBG("");
@@ -2690,46 +2728,35 @@ bool __connman_connection_update_gateway(void)
 
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		struct gateway_data *current_gateway = value;
+		struct gateway_config *current_config;
 
 		GATEWAY_DATA_DBG("current_gateway", current_gateway);
 
 		if (current_gateway == default_gateway)
 			continue;
 
-		if (current_gateway->ipv4_config &&
-				is_gateway_config_state_active(
-					current_gateway->ipv4_config)) {
-			type = CONNMAN_IPCONFIG_TYPE_IPV4;
-
-			unset_status =
-				UNSET_DEFAULT_GATEWAY(
-					current_gateway,
-					type);
+		type = CONNMAN_IPCONFIG_TYPE_IPV4;
+		current_config = gateway_data_config_get(current_gateway, type);
 
-			set_status =
-				SET_LOW_PRIORITY_DEFAULT_GATEWAY(
-					current_gateway,
-					type);
+		if (current_config &&
+				is_gateway_config_state_active(
+					current_config)) {
+			status = DEMOTE_DEFAULT_GATEWAY(current_gateway,
+						type);
 
-			updated4 = (unset_status == 0 || set_status == 0);
+			updated4 = status == 0;
 		}
 
-		if (current_gateway->ipv6_config &&
-				is_gateway_config_state_active(
-					current_gateway->ipv6_config)) {
-			type = CONNMAN_IPCONFIG_TYPE_IPV6;
+		type = CONNMAN_IPCONFIG_TYPE_IPV6;
+		current_config = gateway_data_config_get(current_gateway, type);
 
-			unset_status =
-				UNSET_DEFAULT_GATEWAY(
-					current_gateway,
-					type);
-
-			set_status =
-				SET_LOW_PRIORITY_DEFAULT_GATEWAY(
-					current_gateway,
-					type);
+		if (current_config &&
+				is_gateway_config_state_active(
+					current_config)) {
+			status = DEMOTE_DEFAULT_GATEWAY(current_gateway,
+						type);
 
-			updated6 = (unset_status == 0 || set_status == 0);
+			updated6 = status == 0;
 		}
 	}
 
@@ -2740,31 +2767,23 @@ bool __connman_connection_update_gateway(void)
 	 * set as active yet.
 	 */
 	if (default_gateway) {
-		if (default_gateway->ipv4_config &&
-			(updated4 ||
-			!is_gateway_config_state_active(
-				default_gateway->ipv4_config))) {
-			type = CONNMAN_IPCONFIG_TYPE_IPV4;
+		const struct gateway_config *default_config;
 
-			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(default_gateway,
-				type);
+		type = CONNMAN_IPCONFIG_TYPE_IPV4;
+		default_config = gateway_data_config_get(default_gateway, type);
 
-			SET_DEFAULT_GATEWAY(default_gateway,
-				type);
-		}
-
-		if (default_gateway->ipv6_config &&
-			(updated6 ||
-			!is_gateway_config_state_active(
-				default_gateway->ipv6_config))) {
-			type = CONNMAN_IPCONFIG_TYPE_IPV6;
+		if (default_config &&
+			(updated4 ||
+			!is_gateway_config_state_active(default_config)))
+			PROMOTE_DEFAULT_GATEWAY(default_gateway, type);
 
-			UNSET_LOW_PRIORITY_DEFAULT_GATEWAY(default_gateway,
-				type);
+		type = CONNMAN_IPCONFIG_TYPE_IPV6;
+		default_config = gateway_data_config_get(default_gateway, type);
 
-			SET_DEFAULT_GATEWAY(default_gateway,
-				type);
-		}
+		if (default_config &&
+			(updated6 ||
+			!is_gateway_config_state_active(default_config)))
+			PROMOTE_DEFAULT_GATEWAY(default_gateway, type);
 	}
 
 done:
-- 
2.42.0

