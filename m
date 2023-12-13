Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822B7D8AF
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A3C877310E
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 15:00:04 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f04b:507e:d663:adf2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5ED4D7312C
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 15:00:04 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/3] gateway: Rename public and private symbols after file rename.
Date: Wed, 13 Dec 2023 12:00:01 -0800
Message-ID: <20231213200001.1994492-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213200001.1994492-1-gerickson@nuovations.com>
References: <20231213200001.1994492-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames public and private symbols in "gateway.c" reflective of
the recent name change of the file from "connection.c" to "gateway.c".
---
 src/connman.h  | 14 ++++++------
 src/dnsproxy.c |  2 +-
 src/gateway.c  | 60 +++++++++++++++++++++++++-------------------------
 src/ipconfig.c |  8 +++----
 src/main.c     |  4 ++--
 src/network.c  |  2 +-
 src/provider.c |  4 ++--
 src/service.c  | 22 +++++++++---------
 8 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 472429bfc1a2..d179374e2247 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -522,19 +522,19 @@ int __connman_dhcpv6_start_pd_release(struct connman_network *network,
 int __connman_ipv4_init(void);
 void __connman_ipv4_cleanup(void);
 
-int __connman_connection_init(void);
-void __connman_connection_cleanup(void);
+int __connman_gateway_init(void);
+void __connman_gateway_cleanup(void);
 
-int __connman_connection_gateway_add(struct connman_service *service,
+int __connman_gateway_add(struct connman_service *service,
 					const char *gateway,
 					enum connman_ipconfig_type type,
 					const char *peer);
-void __connman_connection_gateway_remove(struct connman_service *service,
+void __connman_gateway_remove(struct connman_service *service,
 					enum connman_ipconfig_type type);
-int __connman_connection_get_vpn_index(int phy_index);
-int __connman_connection_get_vpn_phy_index(int vpn_index);
+int __connman_gateway_get_vpn_index(int phy_index);
+int __connman_gateway_get_vpn_phy_index(int vpn_index);
 
-bool __connman_connection_update_gateway(void);
+bool __connman_gateway_update(void);
 
 typedef void (*__connman_ntp_cb_t) (bool success, void *user_data);
 int __connman_ntp_start(char *server, __connman_ntp_cb_t callback,
diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 4ae485f12439..d4242560f3f3 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -3020,7 +3020,7 @@ static void dnsproxy_default_changed(struct connman_service *service)
 	 * the VPN must be enabled as well, when the transport becomes the
 	 * default service.
 	 */
-	vpn_index = __connman_connection_get_vpn_index(index);
+	vpn_index = __connman_gateway_get_vpn_index(index);
 
 	for (GSList *list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
diff --git a/src/gateway.c b/src/gateway.c
index 35ca9cc6cfc5..61f3226a6771 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -111,14 +111,14 @@
  *    Operationally, down calls from outside this module generally
  *    come from the following three functions:
  *
- *      1. __connman_connection_gateway_add
- *      2. __connman_connection_gateway_remove
- *      3. __connman_connection_update_gateway
+ *      1. __connman_gateway_add
+ *      2. __connman_gateway_remove
+ *      3. __connman_gateway_update
  *
  *    and up calls generally come from the following two functions:
  *
- *      1. connection_newgateway
- *      2. connection_delgateway
+ *      1. gateway_rtnl_new
+ *      2. gateway_rtnl_del
  *
  *    From these five functions above, we are then attempting to do
  *    the following for a gateway associated with a network service
@@ -1595,7 +1595,7 @@ static int del_gateway_routes_if_active(struct gateway_data *data,
  *                    #gateway_data structure and its associated
  *                    #gateway_config.
  *
- *  @sa __connman_connection_gateway_add
+ *  @sa __connman_gateway_add
  *  @sa del_gateway_routes_if_active
  *
  */
@@ -3221,7 +3221,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
  *                             against existing gateway data.
  *
  *  @sa yield_default_gateway
- *  @sa connection_newgateway
+ *  @sa gateway_rtnl_new
  *
  */
 static void check_default_gateway(struct gateway_data *activated)
@@ -3296,10 +3296,10 @@ static void check_default_gateway(struct gateway_data *activated)
  *
  *  @sa check_default_gateway
  *  @sa set_default_gateway
- *  @sa connection_delgateway
+ *  @sa gateway_rtnl_del
  *
  */
-static void connection_newgateway(int index, const char *gateway)
+static void gateway_rtnl_new(int index, const char *gateway)
 {
 	g_autofree char *interface = NULL;
 	struct gateway_config *config;
@@ -3421,11 +3421,11 @@ static void remove_gateway(gpointer user_data)
  *                       formatted address of the gateway, or default
  *                       router, that was removed.
  *
- *  @sa connection_newgateway
+ *  @sa gateway_rtnl_new
  *  @sa set_default_gateway
  *
  */
-static void connection_delgateway(int index, const char *gateway)
+static void gateway_rtnl_del(int index, const char *gateway)
 {
 	g_autofree char *interface = NULL;
 	struct gateway_config *config;
@@ -3467,10 +3467,10 @@ static void connection_delgateway(int index, const char *gateway)
 		DBG("no default gateway data");
 }
 
-static struct connman_rtnl connection_rtnl = {
-	.name		= "connection",
-	.newgateway	= connection_newgateway,
-	.delgateway	= connection_delgateway,
+static struct connman_rtnl gateway_rtnl = {
+	.name		= "gateway",
+	.newgateway	= gateway_rtnl_new,
+	.delgateway	= gateway_rtnl_del,
 };
 
 /**
@@ -3563,11 +3563,11 @@ static void add_host_route(struct gateway_data *data,
  *  @retval  -EINVAL  If service is null or if network interface
  *                    index associated with @a service is invalid.
  *
- *  @sa __connman_connection_gateway_remove
- *  @sa __connman_connection_update_gateway
+ *  @sa __connman_gateway_remove
+ *  @sa __connman_gateway_update
  *
  */
-int __connman_connection_gateway_add(struct connman_service *service,
+int __connman_gateway_add(struct connman_service *service,
 					const char *gateway,
 					enum connman_ipconfig_type type,
 					const char *peer)
@@ -3740,11 +3740,11 @@ done:
  *  @retval  -EINVAL  If service is null or if network interface
  *                    index associated with @a service is invalid.
  *
- *  @sa __connman_connection_gateway_add
- *  @sa __connman_connection_update_gateway
+ *  @sa __connman_gateway_add
+ *  @sa __connman_gateway_update
  *
  */
-void __connman_connection_gateway_remove(struct connman_service *service,
+void __connman_gateway_remove(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
 	struct gateway_data *data = NULL;
@@ -3848,13 +3848,13 @@ void __connman_connection_gateway_remove(struct connman_service *service,
  *  @returns
  *    True if an active gateway was updated; otherwise, false.
  *
- *  @sa __connman_connection_gateway_add
- *  @sa __connman_connection_gateway_remove
+ *  @sa __connman_gateway_add
+ *  @sa __connman_gateway_remove
  *  @sa set_default_gateway
  *  @sa unset_default_gateway
  *
  */
-bool __connman_connection_update_gateway(void)
+bool __connman_gateway_update(void)
 {
 	struct gateway_data *default_gateway;
 	GHashTableIter iter;
@@ -3946,7 +3946,7 @@ done:
 	return updated4 || updated6;
 }
 
-int __connman_connection_get_vpn_index(int phy_index)
+int __connman_gateway_get_vpn_index(int phy_index)
 {
 	GHashTableIter iter;
 	gpointer value, key;
@@ -3968,7 +3968,7 @@ int __connman_connection_get_vpn_index(int phy_index)
 	return -1;
 }
 
-int __connman_connection_get_vpn_phy_index(int vpn_index)
+int __connman_gateway_get_vpn_phy_index(int vpn_index)
 {
 	GHashTableIter iter;
 	gpointer value, key;
@@ -3991,7 +3991,7 @@ int __connman_connection_get_vpn_phy_index(int vpn_index)
 	return -1;
 }
 
-int __connman_connection_init(void)
+int __connman_gateway_init(void)
 {
 	int err;
 
@@ -4000,21 +4000,21 @@ int __connman_connection_init(void)
 	gateway_hash = g_hash_table_new_full(g_direct_hash, g_direct_equal,
 							NULL, remove_gateway);
 
-	err = connman_rtnl_register(&connection_rtnl);
+	err = connman_rtnl_register(&gateway_rtnl);
 	if (err < 0)
 		connman_error("Failed to setup RTNL gateway driver");
 
 	return err;
 }
 
-void __connman_connection_cleanup(void)
+void __connman_gateway_cleanup(void)
 {
 	GHashTableIter iter;
 	gpointer value, key;
 
 	DBG("");
 
-	connman_rtnl_unregister(&connection_rtnl);
+	connman_rtnl_unregister(&gateway_rtnl);
 
 	g_hash_table_iter_init(&iter, gateway_hash);
 
diff --git a/src/ipconfig.c b/src/ipconfig.c
index e26fc13799fb..5ec619fa7e6b 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1359,7 +1359,7 @@ void __connman_ipconfig_set_gateway(struct connman_ipconfig *ipconfig,
  *                    associated with @a service is invalid.
  *
  *  @sa __connman_ipconfig_gateway_remove
- *  @sa __connman_connection_gateway_add
+ *  @sa __connman_gateway_add
  *
  */
 int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
@@ -1385,7 +1385,7 @@ int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
 
 	if (ipconfig->type == CONNMAN_IPCONFIG_TYPE_IPV6 ||
 				ipconfig->type == CONNMAN_IPCONFIG_TYPE_IPV4)
-		return __connman_connection_gateway_add(service,
+		return __connman_gateway_add(service,
 						ipconfig->address->gateway,
 						ipconfig->type,
 						ipconfig->address->peer);
@@ -1408,7 +1408,7 @@ int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
  *                        gateway.
  *
  *  @sa __connman_ipconfig_gateway_add
- *  @sa __connman_connection_gateway_remove
+ *  @sa __connman_gateway_remove
  *
  */
 void __connman_ipconfig_gateway_remove(const struct connman_ipconfig *ipconfig)
@@ -1424,7 +1424,7 @@ void __connman_ipconfig_gateway_remove(const struct connman_ipconfig *ipconfig)
 
 	service = __connman_service_lookup_from_index(ipconfig->index);
 	if (service)
-		__connman_connection_gateway_remove(service, ipconfig->type);
+		__connman_gateway_remove(service, ipconfig->type);
 }
 
 unsigned char __connman_ipconfig_get_prefixlen(struct connman_ipconfig *ipconfig)
diff --git a/src/main.c b/src/main.c
index e9419a603eba..d2ec8296f490 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1067,7 +1067,7 @@ int main(int argc, char *argv[])
 	__connman_detect_init();
 	__connman_session_init();
 	__connman_timeserver_init();
-	__connman_connection_init();
+	__connman_gateway_init();
 
 	__connman_plugin_init(option_plugin, option_noplugin);
 
@@ -1098,7 +1098,7 @@ int main(int argc, char *argv[])
 	__connman_session_cleanup();
 	__connman_plugin_cleanup();
 	__connman_provider_cleanup();
-	__connman_connection_cleanup();
+	__connman_gateway_cleanup();
 	__connman_timeserver_cleanup();
 	__connman_detect_cleanup();
 	__connman_proxy_cleanup();
diff --git a/src/network.c b/src/network.c
index 3f844f76120d..416a7e74670c 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1022,7 +1022,7 @@ static void set_disconnected(struct connman_network *network)
 					CONNMAN_IPCONFIG_TYPE_IPV6);
 
 	if (network->connected) {
-		__connman_connection_gateway_remove(service,
+		__connman_gateway_remove(service,
 						CONNMAN_IPCONFIG_TYPE_ALL);
 
 		__connman_ipconfig_address_unset(ipconfig_ipv4);
diff --git a/src/provider.c b/src/provider.c
index e3d34d8f2cd1..1f0ce10da796 100644
--- a/src/provider.c
+++ b/src/provider.c
@@ -666,7 +666,7 @@ int connman_provider_set_split_routing(struct connman_provider *provider,
 	}
 
 	vpn_index = __connman_service_get_index(provider->vpn_service);
-	service_index = __connman_connection_get_vpn_phy_index(vpn_index);
+	service_index = __connman_gateway_get_vpn_phy_index(vpn_index);
 	service = __connman_service_lookup_from_index(service_index);
 	if (!service)
 		goto save;
@@ -857,7 +857,7 @@ static void provider_service_changed(struct connman_service *service,
 
 	service_index = __connman_service_get_index(service);
 
-	vpn_index = __connman_connection_get_vpn_index(service_index);
+	vpn_index = __connman_gateway_get_vpn_index(service_index);
 
 	DBG("service %p %s state %d index %d/%d", service,
 		connman_service_get_identifier(service),
diff --git a/src/service.c b/src/service.c
index 16b561f48a41..5ead14ac6d98 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5851,7 +5851,7 @@ int __connman_service_move(struct connman_service *service,
 	else
 		switch_service_order(service, target);
 
-	__connman_connection_update_gateway();
+	__connman_gateway_update();
 
 	service_schedule_changed();
 
@@ -6002,7 +6002,7 @@ static void service_free(gpointer user_data)
 	service->path = NULL;
 
 	if (path) {
-		__connman_connection_update_gateway();
+		__connman_gateway_update();
 
 		g_dbus_unregister_interface(connection, path,
 						CONNMAN_SERVICE_INTERFACE);
@@ -6627,7 +6627,7 @@ int __connman_service_set_favorite_delayed(struct connman_service *service,
 
 		service_list_sort();
 
-		__connman_connection_update_gateway();
+		__connman_gateway_update();
 	}
 
 	return 0;
@@ -6765,7 +6765,7 @@ static void report_error_cb(void *user_context, bool retry,
 
 		service_complete(service);
 		service_list_sort();
-		__connman_connection_update_gateway();
+		__connman_gateway_update();
 	}
 }
 
@@ -6905,7 +6905,7 @@ static void request_input_cb(struct connman_service *service,
 		}
 
 		service_complete(service);
-		__connman_connection_update_gateway();
+		__connman_gateway_update();
 	}
 }
 
@@ -6972,7 +6972,7 @@ static int service_update_preferred_order(struct connman_service *default_servic
 	if (service_compare_preferred(default_service, new_service) > 0) {
 		switch_service_order(default_service,
 				new_service);
-		__connman_connection_update_gateway();
+		__connman_gateway_update();
 		return 0;
 	}
 
@@ -7208,7 +7208,7 @@ static int service_indicate_state(struct connman_service *service)
 
 	service_list_sort();
 
-	__connman_connection_update_gateway();
+	__connman_gateway_update();
 
 notifier:
 	if ((old_state == CONNMAN_SERVICE_STATE_ONLINE &&
@@ -7893,7 +7893,7 @@ int __connman_service_provision_changed(const char *ident)
 
 		service_list_sort();
 
-		__connman_connection_update_gateway();
+		__connman_gateway_update();
 	}
 
 	return data.ret;
@@ -7966,7 +7966,7 @@ static int service_register(struct connman_service *service)
 
 	service_list_sort();
 
-	__connman_connection_update_gateway();
+	__connman_gateway_update();
 
 	return 0;
 }
@@ -8463,7 +8463,7 @@ struct connman_service * __connman_service_create_from_network(struct connman_ne
 			__connman_ipconfig_set_index(service->ipconfig_ipv6,
 									index);
 
-		__connman_connection_update_gateway();
+		__connman_gateway_update();
 		return service;
 	}
 
@@ -8589,7 +8589,7 @@ void __connman_service_remove_from_network(struct connman_network *network)
 
 	service->ignore = true;
 
-	__connman_connection_gateway_remove(service,
+	__connman_gateway_remove(service,
 					CONNMAN_IPCONFIG_TYPE_ALL);
 
 	connman_service_unref(service);
-- 
2.42.0

