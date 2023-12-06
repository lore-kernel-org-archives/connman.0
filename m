Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81389328CD
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id BBF5C7315A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:02 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7DC0E731A8
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:02 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 11/90] connection: Split '{un,}_default_gateway' IP-specific functions.
Date: Wed,  6 Dec 2023 15:49:34 -0800
Message-ID: <20231206235056.322578-12-gerickson@nuovations.com>
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

As this module is refactored, there are common patterns across both
set and unset as well as across IPv4 and IPv6.

To set the stage for further aligning these, split the core bodies of
'{un,}_default_gateway' into '{un,}set_ipv{4,6}_default_gateway',
leaving '{un,}_default_gateway' nearly identical.
---
 src/connection.c | 264 +++++++++++++++++++++++++++--------------------
 1 file changed, 150 insertions(+), 114 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index ac0565c14257..2c4c716560fe 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1079,6 +1079,94 @@ static int add_gateway(struct connman_service *service,
 	return err;
 }
 
+static int set_ipv4_default_gateway(struct gateway_data *data,
+				struct gateway_config *config)
+{
+	int err = 0;
+
+	if (is_gateway_config_vpn(config)) {
+		connman_inet_set_gateway_interface(data->index);
+
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+
+		DBG("set %p index %d vpn %s index %d phy %s",
+			data, data->index, config->vpn_ip,
+			config->vpn_phy_index,
+			config->vpn_phy_ip);
+	} else if (is_ipv4_addr_any_str(config->gateway)) {
+		if (connman_inet_set_gateway_interface(
+					data->index) < 0)
+			goto done;
+
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+
+		DBG("set %p index %d",
+			data, data->index);
+	} else {
+		err = __connman_inet_add_default_to_table(
+					RT_TABLE_MAIN,
+					data->index,
+					config->gateway);
+		if (err < 0)
+			goto done;
+
+		DBG("set %p index %d gateway %s",
+			data, data->index, config->gateway);
+	}
+
+	gateway_config_type_set(config,
+		CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT);
+
+done:
+	return err;
+}
+
+static int set_ipv6_default_gateway(struct gateway_data *data,
+				struct gateway_config *config)
+{
+	int err = 0;
+
+	if (is_gateway_config_vpn(config)) {
+		connman_inet_set_ipv6_gateway_interface(data->index);
+
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+
+		DBG("set %p index %d vpn %s index %d phy %s",
+			data, data->index, config->vpn_ip,
+			config->vpn_phy_index,
+			config->vpn_phy_ip);
+	} else if (is_ipv6_addr_any_str(config->gateway)) {
+		if (connman_inet_set_ipv6_gateway_interface(
+					data->index) < 0)
+			goto done;
+
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+
+		DBG("set %p index %d",
+			data, data->index);
+	} else {
+		err = __connman_inet_add_default_to_table(
+					RT_TABLE_MAIN,
+					data->index,
+					config->gateway);
+		if (err < 0)
+			goto done;
+
+		DBG("set %p index %d gateway %s",
+			data, data->index, config->gateway);
+	}
+
+	gateway_config_type_set(config,
+		CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT);
+
+done:
+	return err;
+}
+
 /**
  *  @brief
  *    Set, or assign, the gateway, or default route, for the specified
@@ -1134,82 +1222,80 @@ static void set_default_gateway(struct gateway_data *data,
 	else
 		return;
 
-	if (do_ipv4 && data->ipv4_config) {
-		if (is_gateway_config_vpn(data->ipv4_config)) {
-			connman_inet_set_gateway_interface(data->index);
+	if (do_ipv4 && data->ipv4_config)
+		status4 = set_ipv4_default_gateway(data, data->ipv4_config);
 
-			gateway_config_state_set(data->ipv4_config,
-				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+	if (do_ipv6 && data->ipv6_config)
+		status6 = set_ipv6_default_gateway(data, data->ipv6_config);
 
-			DBG("set %p index %d vpn %s index %d phy %s",
-				data, data->index, data->ipv4_config->vpn_ip,
-				data->ipv4_config->vpn_phy_index,
-				data->ipv4_config->vpn_phy_ip);
-		} else if (is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
-			if (connman_inet_set_gateway_interface(
-						data->index) < 0)
-				return;
+	DBG("status4 %d (%s) status6 %d (%s)",
+		status4, strerror(-status4),
+		status6, strerror(-status6));
 
-			gateway_config_state_set(data->ipv4_config,
-				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+	if (status4 < 0 || status6 < 0)
+		return;
 
-			DBG("set %p index %d",
-				data, data->index);
-		} else {
-			status4 = __connman_inet_add_default_to_table(
-						RT_TABLE_MAIN,
-						data->index,
-						data->ipv4_config->gateway);
+	__connman_service_indicate_default(data->service);
+}
 
-			DBG("set %p index %d gateway %s",
-				data, data->index, data->ipv4_config->gateway);
-		}
+static void unset_ipv4_default_gateway(struct gateway_data *data,
+				struct gateway_config *config)
+{
+	if (is_gateway_config_vpn(config)) {
+		connman_inet_clear_gateway_interface(data->index);
 
-		gateway_config_type_set(data->ipv4_config,
-			CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT);
-	}
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
-	if (do_ipv6 && data->ipv6_config) {
-		if (is_gateway_config_vpn(data->ipv6_config)) {
-			connman_inet_set_ipv6_gateway_interface(data->index);
+		DBG("unset %p index %d vpn %s index %d phy %s",
+			data, data->index, config->vpn_ip,
+			config->vpn_phy_index,
+			config->vpn_phy_ip);
+	} else if (is_ipv4_addr_any_str(config->gateway)) {
+		connman_inet_clear_gateway_interface(data->index);
 
-			gateway_config_state_set(data->ipv6_config,
-				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
-			DBG("set %p index %d vpn %s index %d phy %s",
-				data, data->index, data->ipv6_config->vpn_ip,
-				data->ipv6_config->vpn_phy_index,
-				data->ipv6_config->vpn_phy_ip);
-		} else if (is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
-			if (connman_inet_set_ipv6_gateway_interface(
-						data->index) < 0)
-				return;
+		DBG("unset %p index %d",
+			data, data->index);
+	} else {
+		connman_inet_clear_gateway_address(data->index,
+					config->gateway);
 
-			gateway_config_state_set(data->ipv6_config,
-				CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+		DBG("unset %p index %d gateway %s",
+			data, data->index, config->gateway);
+	}
+}
 
-			DBG("set %p index %d",
-				data, data->index);
-		} else {
-			status6 = __connman_inet_add_default_to_table(
-						RT_TABLE_MAIN,
-						data->index,
-						data->ipv6_config->gateway);
+static void unset_ipv6_default_gateway(struct gateway_data *data,
+				struct gateway_config *config)
+{
+	if (is_gateway_config_vpn(config)) {
+		connman_inet_clear_ipv6_gateway_interface(data->index);
 
-			DBG("set %p index %d gateway %s",
-				data, data->index, data->ipv6_config->gateway);
-		}
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
-		gateway_config_type_set(data->ipv6_config,
-			CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT);
-	}
+		DBG("unset %p index %d vpn %s index %d phy %s",
+			data, data->index, config->vpn_ip,
+			config->vpn_phy_index,
+			config->vpn_phy_ip);
+	} else if (is_ipv6_addr_any_str(config->gateway)) {
+		connman_inet_clear_ipv6_gateway_interface(data->index);
 
-	DBG("status4 %d status6 %d", status4, status6);
+		gateway_config_state_set(config,
+			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
-	if (status4 < 0 || status6 < 0)
-		return;
+		DBG("unset %p index %d",
+			data, data->index);
+	} else {
+		connman_inet_clear_ipv6_gateway_address(data->index,
+					config->gateway);
 
-	__connman_service_indicate_default(data->service);
+		DBG("unset %p index %d gateway %s",
+			data, data->index, config->gateway);
+	}
 }
 
 /**
@@ -1265,61 +1351,11 @@ static void unset_default_gateway(struct gateway_data *data,
 	else
 		return;
 
-	if (do_ipv4 && data->ipv4_config) {
-		if (is_gateway_config_vpn(data->ipv4_config)) {
-			connman_inet_clear_gateway_interface(data->index);
-
-			gateway_config_state_set(data->ipv4_config,
-				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
-
-			DBG("unset %p index %d vpn %s index %d phy %s",
-				data, data->index, data->ipv4_config->vpn_ip,
-				data->ipv4_config->vpn_phy_index,
-				data->ipv4_config->vpn_phy_ip);
-		} else if (is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
-			connman_inet_clear_gateway_interface(data->index);
-
-			gateway_config_state_set(data->ipv4_config,
-				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
-
-			DBG("unset %p index %d",
-				data, data->index);
-		} else {
-			connman_inet_clear_gateway_address(data->index,
-						data->ipv4_config->gateway);
-
-			DBG("unset %p index %d gateway %s",
-				data, data->index, data->ipv4_config->gateway);
-		}
-	}
-
-	if (do_ipv6 && data->ipv6_config) {
-		if (is_gateway_config_vpn(data->ipv6_config)) {
-			connman_inet_clear_ipv6_gateway_interface(data->index);
-
-			gateway_config_state_set(data->ipv6_config,
-				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
-
-			DBG("unset %p index %d vpn %s index %d phy %s",
-				data, data->index, data->ipv6_config->vpn_ip,
-				data->ipv6_config->vpn_phy_index,
-				data->ipv6_config->vpn_phy_ip);
-		} else if (is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
-			connman_inet_clear_ipv6_gateway_interface(data->index);
-
-			gateway_config_state_set(data->ipv6_config,
-				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
-
-			DBG("unset %p index %d",
-				data, data->index);
-		} else {
-			connman_inet_clear_ipv6_gateway_address(data->index,
-						data->ipv6_config->gateway);
+	if (do_ipv4 && data->ipv4_config)
+		unset_ipv4_default_gateway(data, data->ipv4_config);
 
-			DBG("unset %p index %d gateway %s",
-				data, data->index, data->ipv6_config->gateway);
-		}
-	}
+	if (do_ipv6 && data->ipv6_config)
+		unset_ipv6_default_gateway(data, data->ipv6_config);
 }
 
 /**
-- 
2.42.0

