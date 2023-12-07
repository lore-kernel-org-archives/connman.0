Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4335D5646A
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5E89A73140
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 18:41:33 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:851a:6a54:a980:b9a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2153373147
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 18:41:33 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/4] connection: Harmonize search function names.
Date: Thu,  7 Dec 2023 15:41:29 -0800
Message-ID: <20231207234130.1093617-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207234130.1093617-1-gerickson@nuovations.com>
References: <20231207234130.1093617-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Prior to this change, there were five service/gateway map search
functions with inconsistent naming patterns:

    * Four of those five were named 'find_*' and only one 'lookup_*'.
    * Four of those five return a pointer to gateway_data but only one
      was suffixed with '_data'.

This harmonizes the five service/gateway map search function names by:

    * Ensuring that they all start with 'find_'.
    * Ensuring that if they return a pointer to 'gateway_config' that
      they are suffixed with '_config' and if they return a pointer to
      'gateway_data' that they are suffixed with '_data'.
---
 src/connection.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index c42988bf337d..cd28f8e80ac6 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -189,7 +189,8 @@ static void gateway_data_debug(const char *function,
 	}
 }
 
-static struct gateway_config *find_gateway(int index, const char *gateway)
+static struct gateway_config *find_gateway_config(int index,
+				const char *gateway)
 {
 	GHashTableIter iter;
 	gpointer value, key;
@@ -216,7 +217,7 @@ static struct gateway_config *find_gateway(int index, const char *gateway)
 	return NULL;
 }
 
-static struct gateway_data *lookup_gateway_data(
+static struct gateway_data *find_gateway_data(
 				const struct gateway_config *config)
 {
 	GHashTableIter iter;
@@ -242,7 +243,7 @@ static struct gateway_data *lookup_gateway_data(
 	return NULL;
 }
 
-static struct gateway_data *find_active_gateway(void)
+static struct gateway_data *find_active_gateway_data(void)
 {
 	GHashTableIter iter;
 	gpointer value, key;
@@ -266,7 +267,7 @@ static struct gateway_data *find_active_gateway(void)
 	return NULL;
 }
 
-static struct gateway_data *find_default_gateway(void)
+static struct gateway_data *find_default_gateway_data(void)
 {
 	struct connman_service *service;
 
@@ -277,7 +278,8 @@ static struct gateway_data *find_default_gateway(void)
 	return g_hash_table_lookup(gateway_hash, service);
 }
 
-static struct gateway_data *find_vpn_gateway(int index, const char *gateway)
+static struct gateway_data *find_vpn_gateway_data(int index,
+				const char *gateway)
 {
 	GHashTableIter iter;
 	gpointer value, key;
@@ -322,7 +324,7 @@ static void get_gateway_cb(const char *gateway, int index, void *user_data)
 	DBG("phy index %d phy gw %s vpn index %d vpn gw %s", index, gateway,
 		params->vpn_index, params->vpn_gateway);
 
-	data = find_vpn_gateway(params->vpn_index, params->vpn_gateway);
+	data = find_vpn_gateway_data(params->vpn_index, params->vpn_gateway);
 	if (!data) {
 		DBG("Cannot find VPN link route, index %d addr %s",
 			params->vpn_index, params->vpn_gateway);
@@ -844,7 +846,7 @@ static void connection_newgateway(int index, const char *gateway)
 	 * gateway, or default router, route we added or
 	 * set. Consequently, ignore it and return.
 	 */
-	config = find_gateway(index, gateway);
+	config = find_gateway_config(index, gateway);
 	if (!config)
 		return;
 
@@ -863,7 +865,7 @@ static void connection_newgateway(int index, const char *gateway)
 	 * if there are two gateways waiting rtnl activation at the
 	 * same time.
 	 */
-	data = lookup_gateway_data(config);
+	data = find_gateway_data(config);
 	if (!data)
 		return;
 
@@ -966,7 +968,7 @@ static void connection_delgateway(int index, const char *gateway)
 	 * This ends the lifecycle of the gateway associated with the
 	 * newly-removed route; mark it as no longer active.
 	 */
-	config = find_gateway(index, gateway);
+	config = find_gateway_config(index, gateway);
 	if (config) {
 		GATEWAY_CONFIG_DBG("config", config);
 
@@ -979,7 +981,7 @@ static void connection_delgateway(int index, const char *gateway)
 	 * default service, if any. If so, ensure that service acquires
 	 * the high priority default route.
 	 */
-	data = find_default_gateway();
+	data = find_default_gateway_data();
 	if (data) {
 		GATEWAY_DATA_DBG("data", data);
 
@@ -1122,7 +1124,7 @@ int __connman_connection_gateway_add(struct connman_service *service,
 
 	GATEWAY_DATA_DBG("new_gateway", new_gateway);
 
-	active_gateway = find_active_gateway();
+	active_gateway = find_active_gateway_data();
 
 	DBG("active %p index %d new %p", active_gateway,
 		active_gateway ? active_gateway->index : -1, new_gateway);
@@ -1312,7 +1314,7 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	 * We hit the same issue if remove_gateway() fails.
 	 */
 	if (set_default4 || set_default6 || err < 0) {
-		data = find_default_gateway();
+		data = find_default_gateway_data();
 
 		GATEWAY_DATA_DBG("default_data", data);
 
@@ -1355,7 +1357,7 @@ bool __connman_connection_update_gateway(void)
 	if (!gateway_hash)
 		return updated;
 
-	default_gateway = find_default_gateway();
+	default_gateway = find_default_gateway_data();
 
 	DBG("default_gateway %p", default_gateway);
 
-- 
2.42.0

