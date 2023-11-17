Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18E4315B
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ABBCF73108
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 18:03:30 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6267073122
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 18:03:30 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] service: Group online check state by IP configuration type.
Date: Fri, 17 Nov 2023 15:03:25 -0800
Message-ID: <20231117230325.714769-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

As the implementation of the continuous online check mode (also known
as, EnableOnlineToReadyTransition) evolves, there is an increasing
need for spatial locality of online check state by IP configuration
type.

Consequently, rather than having a collection of individual data
members in the service structure decorated with '_ipv4' and '_ipv6'
and accessing them one-by-one, group them into a common
structure. Then, instantiate that structure twice in the service
structure, once for IPv4 and once for IPv6. This allows for the
desired spatial locality.
---
 src/service.c | 142 +++++++++++++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 58 deletions(-)

diff --git a/src/service.c b/src/service.c
index 9f6e28d34be4..ee78caf9e0cc 100644
--- a/src/service.c
+++ b/src/service.c
@@ -78,6 +78,25 @@ struct connman_stats_counter {
 	struct connman_stats stats_roaming;
 };
 
+/**
+ *  IP configuration type-specific "online" HTTP-based Internet
+ *  reachability check state.
+ *
+ */
+struct online_check_state {
+	/**
+	 *  The current GLib main loop timer identifier.
+	 *
+	 */
+	guint timeout;
+
+	/**
+	 *  The current "online" reachability check sequence interval.
+	 *
+	 */
+	unsigned int interval;
+};
+
 struct connman_service {
 	int refcount;
 	char *identifier;
@@ -141,10 +160,8 @@ struct connman_service {
 	char *pac;
 	bool wps;
 	bool wps_advertizing;
-	guint online_timeout_ipv4;
-	guint online_timeout_ipv6;
-	unsigned int online_check_interval_ipv4;
-	unsigned int online_check_interval_ipv6;
+	struct online_check_state online_check_state_ipv4;
+	struct online_check_state online_check_state_ipv6;
 	bool do_split_routing;
 	bool new_service;
 	bool hidden_service;
@@ -1591,8 +1608,8 @@ static void cancel_online_check(struct connman_service *service,
 		"online_timeout_ipv4 %d online_timeout_ipv6 %d",
 		service, connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type),
-		service->online_timeout_ipv4,
-		service->online_timeout_ipv6);
+		service->online_check_state_ipv4.timeout,
+		service->online_check_state_ipv6.timeout);
 
 	/*
 	 * First, ensure that the reachability check is cancelled in the
@@ -1608,9 +1625,9 @@ static void cancel_online_check(struct connman_service *service,
 	 * this module.
 	 */
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
-		service->online_timeout_ipv4) {
-		g_source_remove(service->online_timeout_ipv4);
-		service->online_timeout_ipv4 = 0;
+		service->online_check_state_ipv4.timeout) {
+		g_source_remove(service->online_check_state_ipv4.timeout);
+		service->online_check_state_ipv4.timeout = 0;
 
 		/*
 		 * This balances the retained referece made when
@@ -1619,9 +1636,9 @@ static void cancel_online_check(struct connman_service *service,
 		 */
 		connman_service_unref(service);
 	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
-		service->online_timeout_ipv6) {
-		g_source_remove(service->online_timeout_ipv6);
-		service->online_timeout_ipv6 = 0;
+		service->online_check_state_ipv6.timeout) {
+		g_source_remove(service->online_check_state_ipv6.timeout);
+		service->online_check_state_ipv6.timeout = 0;
 
 		/*
 		 * This balances the retained referece made when
@@ -1770,7 +1787,7 @@ static gboolean redo_wispr_ipv4(gpointer user_data)
 {
 	struct connman_service *service = user_data;
 
-	service->online_timeout_ipv4 = 0;
+	service->online_check_state_ipv4.timeout = 0;
 
 	redo_wispr(service, CONNMAN_IPCONFIG_TYPE_IPV4);
 
@@ -1803,7 +1820,7 @@ static gboolean redo_wispr_ipv6(gpointer user_data)
 {
 	struct connman_service *service = user_data;
 
-	service->online_timeout_ipv6 = 0;
+	service->online_check_state_ipv6.timeout = 0;
 
 	redo_wispr(service, CONNMAN_IPCONFIG_TYPE_IPV6);
 
@@ -1820,40 +1837,48 @@ static gboolean redo_wispr_ipv6(gpointer user_data)
  *  configuration type with the provided interval and timeout
  *  identifier.
  *
- *  @param[in,out]  service   A pointer to the mutable network service
- *                            for which to reschedule the "online"
- *                            reachability check. On success, the
- *                            service will have a reference retained
- *                            that must be elsewhere released.
- *  @param[in]      type      The IP configuration type for which the
- *                            "online" reachability check is to be
- *                            rescheduled.
- *  @param[in,out]  interval  A pointer to the current mutable "online"
- *                            reachability check sequence interval. On
- *                            success, this will be incremented by one
- *                            (1) if it is less than the value of the
- *                            @a OnlineCheckMaxInterval configuration
- *                            setting.
- *  @param[in,out]  timeout   A pointer to the current GLib main loop
- *                            timer identifier. On success, this will
- *                            be updated with the GLib main loop timer
- *                            identifier associated with the
- *                            rescheduled "online" HTTP-based Internet
- *                            reachability check request.
+ *  @param[in,out]  service             A pointer to the mutable
+ *                                      network service for which to
+ *                                      reschedule the "online"
+ *                                      reachability check. On
+ *                                      success, the service will have
+ *                                      a reference retained that must
+ *                                      be elsewhere released.
+ *  @param[in]      type                The IP configuration type for
+ *                                      which the "online"
+ *                                      reachability check is to be
+ *                                      rescheduled.
+ *  @param[in,out]  online_check_state  A pointer to the mutable IP
+ *                                      configuration type-specific
+ *                                      "online" reachability check
+ *                                      state associated with @a
+ *                                      service and @a type. On
+ *                                      success, the 'interval' field
+ *                                      will be incremented by one (1)
+ *                                      if it is less than the value
+ *                                      of the @a
+ *                                      OnlineCheckMaxInterval
+ *                                      configuration setting and the
+ *                                      'timeout' field this will be
+ *                                      updated with the GLib main
+ *                                      loop timer identifier
+ *                                      associated with the
+ *                                      rescheduled "online"
+ *                                      HTTP-based Internet
+ *                                      reachability check request.
  *
  *  @sa redo_wispr_ipv4
  *  @sa redo_wispr_ipv6
  *
  */
 static void reschedule_online_check(struct connman_service *service,
-					enum connman_ipconfig_type type,
-					unsigned int *interval,
-					guint *timeout)
+				enum connman_ipconfig_type type,
+				struct online_check_state *online_check_state)
 {
 	GSourceFunc redo_func;
 	guint seconds;
 
-	if (!service || !interval || !timeout)
+	if (!service || !online_check_state)
 		return;
 
 	DBG("service %p (%s) type %d (%s) interval %u timeout %u",
@@ -1861,7 +1886,8 @@ static void reschedule_online_check(struct connman_service *service,
 		connman_service_get_identifier(service),
 		type,
 		__connman_ipconfig_type2string(type),
-		*interval, *timeout);
+		online_check_state->interval,
+		online_check_state->timeout);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		redo_func = redo_wispr_ipv4;
@@ -1870,22 +1896,25 @@ static void reschedule_online_check(struct connman_service *service,
 
 	DBG("updating online checkout timeout period");
 
-	seconds = online_check_timeout_compute_func(*interval);
+	seconds = online_check_timeout_compute_func(
+				online_check_state->interval);
 
 	DBG("service %p (%s) type %d (%s) interval %u style \"%s\" seconds %u",
 		service,
 		connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type),
-		*interval, online_check_timeout_interval_style, seconds);
+		online_check_state->interval,
+		online_check_timeout_interval_style,
+		seconds);
 
-	*timeout = g_timeout_add_seconds(seconds,
+	online_check_state->timeout = g_timeout_add_seconds(seconds,
 				redo_func, connman_service_ref(service));
 
 	/* Increment the interval for the next time, limiting to a maximum
 	 * interval of @a online_check_max_interval.
 	 */
-	if (*interval < online_check_max_interval)
-		(*interval)++;
+	if (online_check_state->interval < online_check_max_interval)
+		online_check_state->interval++;
 }
 
 /**
@@ -1940,8 +1969,7 @@ static void complete_online_check(struct connman_service *service,
 					bool success,
 					int err)
 {
-	unsigned int *interval;
-	guint *timeout;
+	struct online_check_state *online_check_state;
 
 	DBG("service %p (%s) type %d (%s) success %d err %d (%s)\n",
 		service,
@@ -1954,13 +1982,10 @@ static void complete_online_check(struct connman_service *service,
 		return;
 	}
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
-		interval = &service->online_check_interval_ipv4;
-		timeout = &service->online_timeout_ipv4;
-	} else {
-		interval = &service->online_check_interval_ipv6;
-		timeout = &service->online_timeout_ipv6;
-	}
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+		online_check_state = &service->online_check_state_ipv4;
+	else
+		online_check_state = &service->online_check_state_ipv6;
 
 	if (success) {
 		__connman_service_ipconfig_indicate_state(service,
@@ -1973,17 +1998,18 @@ static void complete_online_check(struct connman_service *service,
 		goto reschedule;
 
 	if (success) {
-		*interval = online_check_max_interval;
+		online_check_state->interval = online_check_max_interval;
 	} else {
 		if (service_downgrade_online_state(service))
-			*interval = online_check_initial_interval;
+			online_check_state->interval =
+				online_check_initial_interval;
 		if (service != connman_service_get_default()) {
 			return;
 		}
 	}
 
 reschedule:
-	reschedule_online_check(service, type, interval, timeout);
+	reschedule_online_check(service, type, online_check_state);
 }
 
 /**
@@ -2051,10 +2077,10 @@ void __connman_service_wispr_start(struct connman_service *service,
 		type, __connman_ipconfig_type2string(type));
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
-		service->online_check_interval_ipv4 =
+		service->online_check_state_ipv4.interval =
 					online_check_initial_interval;
 	else
-		service->online_check_interval_ipv6 =
+		service->online_check_state_ipv6.interval =
 					online_check_initial_interval;
 
 	__connman_wispr_start(service, type,
-- 
2.42.0

