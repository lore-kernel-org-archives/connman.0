Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B1A328C2
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E6BC97314E
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:01 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A35B173174
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 09/90] connection: Add function parameter to {un,}set_default_gateway.
Date: Wed,  6 Dec 2023 15:49:32 -0800
Message-ID: <20231206235056.322578-10-gerickson@nuovations.com>
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

There are 13 unique call sites for '{un,}set_default_gateway' in this
module.

To aid debugging, a function parameter is added to
'{un,}set_default_gateway', which is a pointer to an immutable
null-terminated C string, ostenisbly the name of the function that
invoked '{un,}set_default_gateway'.

In addition, '{UN,}SET_DEFAULT_GATEWAY' macros are added and leveraged
at those 13 call sites. These macros invoke
'{un,}set_default_gateway', passing the C preprocessor predefined
'__func__' macro as the function parameter.
---
 src/connection.c | 87 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 1f5997786c13..6df29fe31aa9 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -32,6 +32,18 @@
 
 #include "connman.h"
 
+/*
+ * There are many call sites throughout this module for these
+ * functions. These are macros to help, during debugging, to acertain
+ * where they were called from.
+ */
+
+#define SET_DEFAULT_GATEWAY(data, type) \
+	set_default_gateway(data, type, __func__)
+
+#define UNSET_DEFAULT_GATEWAY(data, type) \
+	unset_default_gateway(data, type, __func__)
+
 #define GATEWAY_CONFIG_DBG(description, config) \
 	gateway_config_debug(__func__, description, config)
 
@@ -1083,12 +1095,16 @@ static int add_gateway(struct connman_service *service,
  *  service @a service will be signaled as the default via
  *  #__connman_service_indicate_default.
  *
- *  @param[in,out]  data  A pointer to the mutable gateway data to
- *                        assign as the default route.
- *  @param[in]      type  The IP configuration type for which the
- *                        gateway, or default router, configuration
- *                        will be selected from @a data and used to
- *                        set the default route.
+ *  @param[in,out]  data      A pointer to the mutable gateway data
+ *                            to assign as the default route.
+ *  @param[in]      type      The IP configuration type for which the
+ *                            gateway, or default router,
+ *                            configuration will be selected from @a
+ *                            data and used to set the default route.
+ *  @param[in]      function  A pointer to an immutable null-terminated
+ *                            C string containing the function name to
+ *                            which the call to this function should
+ *                            be attributed.
  *
  *  @sa __connman_inet_add_default_to_table
  *  @sa __connman_service_indicate_default
@@ -1097,13 +1113,15 @@ static int add_gateway(struct connman_service *service,
  *
  */
 static void set_default_gateway(struct gateway_data *data,
-				enum connman_ipconfig_type type)
+				enum connman_ipconfig_type type,
+				const char *function)
 {
 	int status4 = 0, status6 = 0;
 	bool do_ipv4 = false, do_ipv6 = false;
 
-	DBG("data %p type %d (%s)", data,
-		type, __connman_ipconfig_type2string(type));
+	DBG("data %p type %d (%s) from %s()", data,
+		type, __connman_ipconfig_type2string(type),
+		function);
 
 	GATEWAY_DATA_DBG("data", data);
 
@@ -1208,12 +1226,17 @@ static void set_default_gateway(struct gateway_data *data,
  *  On success, the gateway configuration specific to @a type will
  *  have its @a active field set to false.
  *
- *  @param[in,out]  data  A pointer to the mutable gateway data to
- *                        clear as the default route.
- *  @param[in]      type  The IP configuration type for which the
- *                        gateway, or default router, configuration
- *                        will be selected from @a data and used to
- *                        unset the default route.
+ *  @param[in,out]  data      A pointer to the mutable gateway data
+ *                            to clear as the default route.
+ *  @param[in]      type      The IP configuration type for which
+ *                            the gateway, or default router,
+ *                            configuration will be selected from @a
+ *                            data and used to unset the default route.
+ *  @param[in]      function  A pointer to an immutable null-terminated
+ *                            C string containing the function name to
+ *                            which the call to this function should
+ *                            be attributed.
+ *
  *
  *  @sa connman_inet_clear_gateway_address
  *  @sa connman_inet_clear_gateway_interface
@@ -1222,12 +1245,14 @@ static void set_default_gateway(struct gateway_data *data,
  *
  */
 static void unset_default_gateway(struct gateway_data *data,
-				enum connman_ipconfig_type type)
+				enum connman_ipconfig_type type,
+				const char *function)
 {
 	bool do_ipv4 = false, do_ipv6 = false;
 
-	DBG("data %p type %d (%s)", data,
-		type, __connman_ipconfig_type2string(type));
+	DBG("data %p type %d (%s) from %s()", data,
+		type, __connman_ipconfig_type2string(type),
+		function);
 
 	GATEWAY_DATA_DBG("data", data);
 
@@ -1356,7 +1381,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
 				maybe_null(gateway_config_type2string(
 					config_type)));
 
-			unset_default_gateway(existing, type);
+			UNSET_DEFAULT_GATEWAY(existing, type);
 		}
 
 		/*
@@ -1375,7 +1400,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
 				maybe_null(gateway_config_type2string(
 					config_type)));
 
-			unset_default_gateway(activated, type);
+			UNSET_DEFAULT_GATEWAY(activated, type);
 
 			yield_activated = true;
 		}
@@ -1402,7 +1427,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
 				maybe_null(gateway_config_type2string(
 					config_type)));
 
-			unset_default_gateway(existing, type);
+			UNSET_DEFAULT_GATEWAY(existing, type);
 		}
 
 		/*
@@ -1421,7 +1446,7 @@ static bool yield_default_gateway(struct gateway_data *activated,
 				maybe_null(gateway_config_type2string(
 					config_type)));
 
-			unset_default_gateway(activated, type);
+			UNSET_DEFAULT_GATEWAY(activated, type);
 
 			yield_activated = true;
 		}
@@ -1490,11 +1515,11 @@ static void check_default_gateway(struct gateway_data *activated)
 
 	if (!yield_activated) {
 		if (activated->ipv4_config)
-			set_default_gateway(activated,
+			SET_DEFAULT_GATEWAY(activated,
 				CONNMAN_IPCONFIG_TYPE_IPV4);
 
 		if (activated->ipv6_config)
-			set_default_gateway(activated,
+			SET_DEFAULT_GATEWAY(activated,
 				CONNMAN_IPCONFIG_TYPE_IPV6);
 	}
 
@@ -1660,7 +1685,7 @@ static void connection_delgateway(int index, const char *gateway)
 	if (data) {
 		GATEWAY_DATA_DBG("data", data);
 
-		set_default_gateway(data, CONNMAN_IPCONFIG_TYPE_ALL);
+		SET_DEFAULT_GATEWAY(data, CONNMAN_IPCONFIG_TYPE_ALL);
 	}
 }
 
@@ -1836,7 +1861,7 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	}
 
 	if (!any_active_gateway) {
-		set_default_gateway(new_gateway, type);
+		SET_DEFAULT_GATEWAY(new_gateway, type);
 		goto done;
 	}
 
@@ -1983,7 +2008,7 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 		GATEWAY_DATA_DBG("default_data", data);
 
 		if (data)
-			set_default_gateway(data, type);
+			SET_DEFAULT_GATEWAY(data, type);
 	}
 }
 
@@ -2045,7 +2070,7 @@ bool __connman_connection_update_gateway(void)
 				is_gateway_config_state_active(
 					active_gateway->ipv4_config)) {
 
-			unset_default_gateway(active_gateway,
+			UNSET_DEFAULT_GATEWAY(active_gateway,
 						CONNMAN_IPCONFIG_TYPE_IPV4);
 			updated = true;
 		}
@@ -2054,7 +2079,7 @@ bool __connman_connection_update_gateway(void)
 				is_gateway_config_state_active(
 					active_gateway->ipv6_config)) {
 
-			unset_default_gateway(active_gateway,
+			UNSET_DEFAULT_GATEWAY(active_gateway,
 						CONNMAN_IPCONFIG_TYPE_IPV6);
 			updated = true;
 		}
@@ -2069,14 +2094,14 @@ bool __connman_connection_update_gateway(void)
 			(updated ||
 			!is_gateway_config_state_active(
 				default_gateway->ipv4_config)))
-			set_default_gateway(default_gateway,
+			SET_DEFAULT_GATEWAY(default_gateway,
 					CONNMAN_IPCONFIG_TYPE_IPV4);
 
 		if (default_gateway->ipv6_config &&
 			(updated ||
 			!is_gateway_config_state_active(
 				default_gateway->ipv6_config)))
-			set_default_gateway(default_gateway,
+			SET_DEFAULT_GATEWAY(default_gateway,
 					CONNMAN_IPCONFIG_TYPE_IPV6);
 	}
 
-- 
2.42.0

