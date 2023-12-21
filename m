Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13CB647
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ED1DF73202
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:56 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AC7C873222
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:56 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 52/60] service: Add function parameter to 'default_changed' and 'service_list_sort'.
Date: Wed, 20 Dec 2023 22:17:15 -0800
Message-ID: <20231221061734.2344286-53-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221061734.2344286-1-gerickson@nuovations.com>
References: <20231221061734.2344286-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

There are four (4) invocations of 'default_changed' and nine (9)
invocations of 'service_list_sort'.

To aid debugging, a function parameter is added to each, which is a
pointer to an immutable null-terminated C string, ostenisbly the name
of the function that invoked either 'default_changed' or
'service_list_sort'.

In addition, 'DEFAULT_CHANGED' and 'SERVICE_LIST_SORT' macros are
added and leveraged at those 13 call sites. These macros invoke
'default_changed' or 'service_list_sort', passing the C preprocessor
predefined '__func__' macro as the function parameter.
---
 src/service.c | 53 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/src/service.c b/src/service.c
index 07322b80bdf7..e04e24f5db97 100644
--- a/src/service.c
+++ b/src/service.c
@@ -45,6 +45,18 @@
 #define VPN_AUTOCONNECT_TIMEOUT_STEP 30
 #define VPN_AUTOCONNECT_TIMEOUT_ATTEMPTS_THRESHOLD 270
 
+/*
+ * There are many call sites throughout this module for these
+ * functions. These are macros to help, during debugging, to acertain
+ * where they were called from.
+ */
+
+#define DEFAULT_CHANGED() \
+	default_changed(__func__)
+
+#define SERVICE_LIST_SORT() \
+	service_list_sort(__func__)
+
 typedef guint (*online_check_timeout_compute_t)(unsigned int interval);
 typedef bool (*is_counter_threshold_met_predicate_t)(
 	const struct connman_service *service,
@@ -223,7 +235,7 @@ static struct connman_ipconfig *create_ip6config(struct connman_service *service
 static void dns_changed(struct connman_service *service);
 static void vpn_auto_connect(void);
 static void trigger_autoconnect(struct connman_service *service);
-static void service_list_sort(void);
+static void service_list_sort(const char *function);
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success,
@@ -3173,7 +3185,7 @@ static bool handle_continuous_online_check_success(
 		 * this service being the default (that is, has the default
 		 * route) service.
 		 */
-		service_list_sort();
+		SERVICE_LIST_SORT();
 
 		if (connman_service_is_default(service)) {
 			__connman_service_ipconfig_indicate_state(
@@ -3457,7 +3469,7 @@ static bool handle_continuous_online_check_failure(
 
 		set_error(service, CONNMAN_SERVICE_ERROR_ONLINE_CHECK_FAILED);
 
-		service_list_sort();
+		SERVICE_LIST_SORT();
 
 		__connman_gateway_update();
 	}
@@ -4075,10 +4087,12 @@ bool __connman_service_index_is_default(int index)
 	return __connman_service_get_index(service) == index;
 }
 
-static void default_changed(void)
+static void default_changed(const char *function)
 {
 	struct connman_service *service = connman_service_get_default();
 
+	DBG("from %s()", function);
+
 	if (service == current_default)
 		return;
 
@@ -8143,13 +8157,20 @@ static gint service_compare(gconstpointer a, gconstpointer b)
  *  the network services list. On completion of the sort, a D-Bus
  *  "ServicesChanged" signal is scheduled.
  *
+ *  @param[in]  function  A pointer to an immutable null-terminated
+ *                        C string containing the function name to
+ *                        which the call to this function should be
+ *                        attributed.
+ *
  *  @sa service_compare
  *  @sa service_compare_preferred
  *  @sa service_schedule_changed
  *
  */
-static void service_list_sort(void)
+static void service_list_sort(const char *function)
 {
+	DBG("from %s()", function);
+
 	if (service_list && service_list->next) {
 		service_list = g_list_sort(service_list, service_compare);
 		service_schedule_changed();
@@ -8434,7 +8455,7 @@ int __connman_service_set_favorite_delayed(struct connman_service *service,
 
 	if (!delay_ordering) {
 
-		service_list_sort();
+		SERVICE_LIST_SORT();
 
 		__connman_gateway_update();
 	}
@@ -8573,7 +8594,7 @@ static void report_error_cb(void *user_context, bool retry,
 		__connman_service_clear_error(service);
 
 		service_complete(service);
-		service_list_sort();
+		SERVICE_LIST_SORT();
 		__connman_gateway_update();
 	}
 }
@@ -8945,7 +8966,7 @@ static int service_indicate_state(struct connman_service *service)
 
 		service_update_preferred_order(def_service, service, new_state);
 
-		default_changed();
+		DEFAULT_CHANGED();
 
 		__connman_service_set_favorite(service, true);
 
@@ -8995,7 +9016,7 @@ static int service_indicate_state(struct connman_service *service)
 
 		reply_pending(service, ECONNABORTED);
 
-		default_changed();
+		DEFAULT_CHANGED();
 
 		cancel_online_check(service, CONNMAN_IPCONFIG_TYPE_ALL);
 
@@ -9032,7 +9053,7 @@ static int service_indicate_state(struct connman_service *service)
 		break;
 	}
 
-	service_list_sort();
+	SERVICE_LIST_SORT();
 
 	__connman_gateway_update();
 
@@ -9046,7 +9067,7 @@ notifier:
 
 	if (is_online(new_state)) {
 		__connman_notifier_enter_online(service->type);
-		default_changed();
+		DEFAULT_CHANGED();
 	}
 
 	return 0;
@@ -9117,7 +9138,7 @@ int __connman_service_indicate_default(struct connman_service *service)
 		return -EINPROGRESS;
 	}
 
-	default_changed();
+	DEFAULT_CHANGED();
 
 	return 0;
 }
@@ -9734,7 +9755,7 @@ int __connman_service_provision_changed(const char *ident)
 	if (services_dirty) {
 		services_dirty = false;
 
-		service_list_sort();
+		SERVICE_LIST_SORT();
 
 		__connman_gateway_update();
 	}
@@ -9807,7 +9828,7 @@ static int service_register(struct connman_service *service)
 	if (__connman_config_provision_service(service) < 0)
 		service_load(service);
 
-	service_list_sort();
+	SERVICE_LIST_SORT();
 
 	__connman_gateway_update();
 
@@ -10232,7 +10253,7 @@ static void update_from_network(struct connman_service *service,
 	if (!service->network)
 		service->network = connman_network_ref(network);
 
-	service_list_sort();
+	SERVICE_LIST_SORT();
 }
 
 static void trigger_autoconnect(struct connman_service *service)
@@ -10439,7 +10460,7 @@ roaming:
 
 sorting:
 	if (need_sort) {
-		service_list_sort();
+		SERVICE_LIST_SORT();
 	}
 }
 
-- 
2.42.0

