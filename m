Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6A2906
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AA64873279
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 13:48:18 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4FF0473289
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 13:48:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] service: Colocate online check-related functions.
Message-Id: <B67B48D7-111D-494D-B3F6-86A1652297CD@nuovations.com>
Date: Mon, 6 Nov 2023 10:48:17 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This spatially colocates the following online check-related service =
functions:

   * complete_online_check
   * redo_wispr_ipv4
   * redo_wispr_ipv6
   * redo_wispr
   * start_wispr_if_connected
   * __connman_service_wispr_start

with these online-check related service functions:

   * cancel_online_check
   * start_online_check
---
 src/service.c | 571 +++++++++++++++++++++++++-------------------------
 1 file changed, 286 insertions(+), 285 deletions(-)

diff --git a/src/service.c b/src/service.c
index ff6ee12f..06e220f8 100644
--- a/src/service.c
+++ b/src/service.c
@@ -164,6 +164,7 @@ static void trigger_autoconnect(struct =
connman_service *service);
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success);
+static void service_downgrade_online_state(struct connman_service =
*service);
=20
 struct find_data {
 	const char *path;
@@ -1645,6 +1646,287 @@ static void start_online_check(struct =
connman_service *service,
 	}
 }
=20
+/**
+ *  @brief
+ *    Retry an "online" HTTP-based Internet reachability check.
+ *
+ *  This retries an "online" HTTP-based Internet reachability check
+ *  for the specified network service IP configuration type.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which an "online" reachability check
+ *                           should be retried.
+ *  @param[in]      type     The IP configuration type for which an
+ *                           "online" reachability check should be
+ *                           retried.
+ *
+ *  @sa complete_online_check
+ *  @sa redo_wispr_ipv4
+ *  @sa redo_wispr_ipv6
+ *
+ */
+static void redo_wispr(struct connman_service *service,
+					enum connman_ipconfig_type type)
+{
+	DBG("Retrying service %p (%s) type %d (%s) WISPr",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type));
+
+	__connman_wispr_start(service, type, complete_online_check);
+
+	// Release the reference to the service taken when
+	// g_timeout_add_seconds was invoked with the callback
+	// that, in turn, invoked this function.
+
+	connman_service_unref(service);
+}
+
+/**
+ *  @brief
+ *    Retry an "online" HTTP-based Internet reachability check
+ *    callback.
+ *
+ *  This callback retries an IPv4 "online" HTTP-based Internet
+ *  reachability check for the specified network service.
+ *
+ *  @param[in,out]  user_data  A pointer to the mutable network
+ *                             service for which an IPv4 "online"
+ *                             reachability check should be retried.
+ *
+ *  @returns
+ *    FALSE (that is, G_SOURCE_REMOVE) unconditionally, indicating
+ *    that the timeout source that triggered this callback should be
+ *    removed on callback completion.
+ *
+ *  @sa complete_online_check
+ *  @sa redo_wispr
+ *  @sa redo_wispr_ipv6
+ *
+ */
+static gboolean redo_wispr_ipv4(gpointer user_data)
+{
+	struct connman_service *service =3D user_data;
+
+	service->online_timeout_ipv4 =3D 0;
+
+	redo_wispr(service, CONNMAN_IPCONFIG_TYPE_IPV4);
+
+	return FALSE;
+}
+
+/**
+ *  @brief
+ *    Retry an "online" HTTP-based Internet reachability check
+ *    callback.
+ *
+ *  This callback retries an IPv6 "online" HTTP-based Internet
+ *  reachability check for the specified network service.
+ *
+ *  @param[in,out]  user_data  A pointer to the mutable network
+ *                             service for which an IPv6 "online"
+ *                             reachability check should be retried.
+ *
+ *  @returns
+ *    FALSE (that is, G_SOURCE_REMOVE) unconditionally, indicating
+ *    that the timeout source that triggered this callback should be
+ *    removed on callback completion.
+ *
+ *  @sa complete_online_check
+ *  @sa redo_wispr
+ *  @sa redo_wispr_ipv4
+ *
+ */
+static gboolean redo_wispr_ipv6(gpointer user_data)
+{
+	struct connman_service *service =3D user_data;
+
+	service->online_timeout_ipv6 =3D 0;
+
+	redo_wispr(service, CONNMAN_IPCONFIG_TYPE_IPV6);
+
+	return FALSE;
+}
+
+/**
+ *  @brief
+ *    This completes an "online" HTTP-based Internet reachability
+ *    check for the specified network service and IP configuration
+ *    type.
+ *
+ *  This completes a failed or successful "online" HTTP-based Internet
+ *  reachability check for the specified network service and IP
+ *  configuration type. This effectively "bookends" an earlier
+ *  #__connman_service_wispr_start.
+ *
+ *  If "EnableOnlineToReadyTransition" is deasserted and if @a success
+ *  is asserted, then the state for the specified IP configuration
+ *  type is transitioned to "online" and a future online check is
+ *  scheduled based on the current interval and the
+ *  "OnlineCheckIntervalStyle" setting.
+ *
+ *  Otherwise, if "EnableOnlineToReadyTransition" is asserted, then
+ *  counters are managed for the success or failure and state is
+ *  managed and tracked resulting in the potential demotion of the
+ *  service, placing it into a temporary failure state until such time
+ *  as a series of back-to-back online checks successfully
+ *  complete. If the service is a non-default after demotion and it is
+ *  in failure state or if it is the default service, then a future
+ *  online check is scheduled based on the current interval and the
+ *  "OnlineCheckIntervalStyle" setting.
+ *
+ *  @param[in,out]  service  A pointer to the mutable service for which
+ *                           to complete a previously-requested online
+ *                           check.
+ *  @param[in]      type     The IP configuration type for which to
+ *                           complete a previously-requested online
+ *                           check.
+ *  @param[in]      success  A Boolean indicating whether the =
previously-
+ *                           requested online check was successful.
+ *
+ *  @sa cancel_online_check
+ *  @sa start_online_check
+ *  @sa start_wispr_if_connected
+ *  @sa __connman_service_wispr_start
+ *
+ */
+static void complete_online_check(struct connman_service *service,
+					enum connman_ipconfig_type type,
+					bool success)
+{
+	GSourceFunc redo_func;
+	unsigned int *interval;
+	guint *timeout;
+	enum connman_service_state current_state;
+	guint seconds;
+	guint current_timeout;
+
+	DBG("service %p (%s) type %d (%s) success %d\n",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		success);
+
+	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4) {
+		interval =3D &service->online_check_interval_ipv4;
+		timeout =3D &service->online_timeout_ipv4;
+		redo_func =3D redo_wispr_ipv4;
+	} else {
+		interval =3D &service->online_check_interval_ipv6;
+		timeout =3D &service->online_timeout_ipv6;
+		redo_func =3D redo_wispr_ipv6;
+	}
+
+	if(!enable_online_to_ready_transition)
+		goto redo_func;
+
+	if (success) {
+		*interval =3D online_check_max_interval;
+	} else {
+		current_state =3D service->state;
+		service_downgrade_online_state(service);
+		if (current_state !=3D service->state)
+			*interval =3D online_check_initial_interval;
+		if (service !=3D connman_service_get_default()) {
+			return;
+		}
+	}
+
+redo_func:
+	DBG("updating online checkout timeout period");
+
+	seconds =3D online_check_timeout_compute_func(*interval);
+
+	DBG("service %p (%s) type %d (%s) interval %d style \"%s\" =
seconds %u",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		*interval, online_check_timeout_interval_style, =
seconds);
+
+	current_timeout =3D g_timeout_add_seconds(seconds,
+				redo_func, =
connman_service_ref(service));
+
+	*timeout =3D current_timeout;
+
+	/* Increment the interval for the next time, limiting to a =
maximum
+	 * interval of @a online_check_max_interval.
+	 */
+	if (*interval < online_check_max_interval)
+		(*interval)++;
+}
+
+/**
+ *  @brief
+ *    Start HTTP-based Internet reachability probes if the specified
+ *    service is connected.
+ *
+ *  This attempts to start IPv4 and/or IPv6 HTTP-based Internet
+ *  reachability probes if the IPv4 state or IPv6 state is connected
+ *  (that is, "ready" or "online").
+ *
+ *  @param[in]  service  A pointer to a mutable service on which to =
start
+ *                       reachability probes if the IPv4 or IPv6 state
+ *                       is "connected" (that is, "ready" or "online").
+ *
+ */
+static void start_wispr_if_connected(struct connman_service *service)
+{
+	if (!connman_setting_get_bool("EnableOnlineCheck")) {
+		connman_info("Online check disabled. "
+			"Default service remains in READY state.");
+		return;
+	}
+
+	if (__connman_service_is_connected_state(service,
+			CONNMAN_IPCONFIG_TYPE_IPV4))
+		__connman_service_wispr_start(service,
+					CONNMAN_IPCONFIG_TYPE_IPV4);
+
+	if (__connman_service_is_connected_state(service,
+			CONNMAN_IPCONFIG_TYPE_IPV6))
+		__connman_service_wispr_start(service,
+					CONNMAN_IPCONFIG_TYPE_IPV6);
+}
+
+/**
+ *  @brief
+ *    Start an "online" HTTP-based Internet reachability check for the
+ *    specified network service IP configuration type.
+ *
+ *  This attempts to start an "online" HTTP-based Internet
+ *  reachability check for the specified network service IP
+ *  configuration type.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to start the "online"
+ *                           reachability check.
+ *  @param[in]      type     The IP configuration type for which the
+ *                           "online" reachability check is to be
+ *                           started.
+ *
+ *  @sa cancel_online_check
+ *  @sa start_online_check
+ *  @sa complete_online_check
+ *  @sa start_wispr_if_connected
+ *
+ */
+void __connman_service_wispr_start(struct connman_service *service,
+					enum connman_ipconfig_type type)
+{
+	DBG("service %p (%s) type %d (%s)",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type));
+
+	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4)
+		service->online_check_interval_ipv4 =3D
+					online_check_initial_interval;
+	else
+		service->online_check_interval_ipv6 =3D
+					online_check_initial_interval;
+
+	__connman_wispr_start(service, type, complete_online_check);
+}
+
 static void address_updated(struct connman_service *service,
 			enum connman_ipconfig_type type)
 {
@@ -1827,44 +2109,11 @@ bool __connman_service_index_is_default(int =
index)
 	struct connman_service *service;
=20
 	if (index < 0)
-		return false;
-
-	service =3D connman_service_get_default();
-
-	return __connman_service_get_index(service) =3D=3D index;
-}
-
-/**
- *  @brief
- *    Start HTTP-based Internet reachability probes if the specified
- *    service is connected.
- *
- *  This attempts to start IPv4 and/or IPv6 HTTP-based Internet
- *  reachability probes if the IPv4 state or IPv6 state is connected
- *  (that is, "ready" or "online").
- *
- *  @param[in]  service  A pointer to a mutable service on which to =
start
- *                       reachability probes if the IPv4 or IPv6 state
- *                       is "connected" (that is, "ready" or "online").
- *
- */
-static void start_wispr_if_connected(struct connman_service *service)
-{
-	if (!connman_setting_get_bool("EnableOnlineCheck")) {
-		connman_info("Online check disabled. "
-			"Default service remains in READY state.");
-		return;
-	}
-
-	if (__connman_service_is_connected_state(service,
-			CONNMAN_IPCONFIG_TYPE_IPV4))
-		__connman_service_wispr_start(service,
-					CONNMAN_IPCONFIG_TYPE_IPV4);
+		return false;
=20
-	if (__connman_service_is_connected_state(service,
-			CONNMAN_IPCONFIG_TYPE_IPV6))
-		__connman_service_wispr_start(service,
-					CONNMAN_IPCONFIG_TYPE_IPV6);
+	service =3D connman_service_get_default();
+
+	return __connman_service_get_index(service) =3D=3D index;
 }
=20
 static void default_changed(void)
@@ -3875,46 +4124,6 @@ int __connman_service_reset_ipconfig(struct =
connman_service *service,
 	return err;
 }
=20
-/**
- *  @brief
- *    Start an "online" HTTP-based Internet reachability check for the
- *    specified network service IP configuration type.
- *
- *  This attempts to start an "online" HTTP-based Internet
- *  reachability check for the specified network service IP
- *  configuration type.
- *
- *  @param[in,out]  service  A pointer to the mutable network service
- *                           for which to start the "online"
- *                           reachability check.
- *  @param[in]      type     The IP configuration type for which the
- *                           "online" reachability check is to be
- *                           started.
- *
- *  @sa cancel_online_check
- *  @sa start_online_check
- *  @sa complete_online_check
- *  @sa start_wispr_if_connected
- *
- */
-void __connman_service_wispr_start(struct connman_service *service,
-					enum connman_ipconfig_type type)
-{
-	DBG("service %p (%s) type %d (%s)",
-		service,
-		connman_service_get_identifier(service),
-		type, __connman_ipconfig_type2string(type));
-
-	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4)
-		service->online_check_interval_ipv4 =3D
-					online_check_initial_interval;
-	else
-		service->online_check_interval_ipv6 =3D
-					online_check_initial_interval;
-
-	__connman_wispr_start(service, type, complete_online_check);
-}
-
 static DBusMessage *set_property(DBusConnection *conn,
 					DBusMessage *msg, void =
*user_data)
 {
@@ -6833,214 +7042,6 @@ static void service_rp_filter(struct =
connman_service *service,
 		connected_networks_count, original_rp_filter);
 }
=20
-/**
- *  @brief
- *    Retry an "online" HTTP-based Internet reachability check.
- *
- *  This retries an "online" HTTP-based Internet reachability check
- *  for the specified network service IP configuration type.
- *
- *  @param[in,out]  service  A pointer to the mutable network service
- *                           for which an "online" reachability check
- *                           should be retried.
- *  @param[in]      type     The IP configuration type for which an
- *                           "online" reachability check should be
- *                           retried.
- *
- *  @sa complete_online_check
- *  @sa redo_wispr_ipv4
- *  @sa redo_wispr_ipv6
- *
- */
-static void redo_wispr(struct connman_service *service,
-					enum connman_ipconfig_type type)
-{
-	DBG("Retrying service %p (%s) type %d (%s) WISPr",
-		service, connman_service_get_identifier(service),
-		type, __connman_ipconfig_type2string(type));
-
-	__connman_wispr_start(service, type, complete_online_check);
-
-	// Release the reference to the service taken when
-	// g_timeout_add_seconds was invoked with the callback
-	// that, in turn, invoked this function.
-
-	connman_service_unref(service);
-}
-
-/**
- *  @brief
- *    Retry an "online" HTTP-based Internet reachability check
- *    callback.
- *
- *  This callback retries an IPv4 "online" HTTP-based Internet
- *  reachability check for the specified network service.
- *
- *  @param[in,out]  user_data  A pointer to the mutable network
- *                             service for which an IPv4 "online"
- *                             reachability check should be retried.
- *
- *  @returns
- *    FALSE (that is, G_SOURCE_REMOVE) unconditionally, indicating
- *    that the timeout source that triggered this callback should be
- *    removed on callback completion.
- *
- *  @sa complete_online_check
- *  @sa redo_wispr
- *  @sa redo_wispr_ipv6
- *
- */
-static gboolean redo_wispr_ipv4(gpointer user_data)
-{
-	struct connman_service *service =3D user_data;
-
-	service->online_timeout_ipv4 =3D 0;
-
-	redo_wispr(service, CONNMAN_IPCONFIG_TYPE_IPV4);
-
-	return FALSE;
-}
-
-/**
- *  @brief
- *    Retry an "online" HTTP-based Internet reachability check
- *    callback.
- *
- *  This callback retries an IPv6 "online" HTTP-based Internet
- *  reachability check for the specified network service.
- *
- *  @param[in,out]  user_data  A pointer to the mutable network
- *                             service for which an IPv6 "online"
- *                             reachability check should be retried.
- *
- *  @returns
- *    FALSE (that is, G_SOURCE_REMOVE) unconditionally, indicating
- *    that the timeout source that triggered this callback should be
- *    removed on callback completion.
- *
- *  @sa complete_online_check
- *  @sa redo_wispr
- *  @sa redo_wispr_ipv4
- *
- */
-static gboolean redo_wispr_ipv6(gpointer user_data)
-{
-	struct connman_service *service =3D user_data;
-
-	service->online_timeout_ipv6 =3D 0;
-
-	redo_wispr(service, CONNMAN_IPCONFIG_TYPE_IPV6);
-
-	return FALSE;
-}
-
-/**
- *  @brief
- *    This completes an "online" HTTP-based Internet reachability
- *    check for the specified network service and IP configuration
- *    type.
- *
- *  This completes a failed or successful "online" HTTP-based Internet
- *  reachability check for the specified network service and IP
- *  configuration type. This effectively "bookends" an earlier
- *  #__connman_service_wispr_start.
- *
- *  If "EnableOnlineToReadyTransition" is deasserted and if @a success
- *  is asserted, then the state for the specified IP configuration
- *  type is transitioned to "online" and a future online check is
- *  scheduled based on the current interval and the
- *  "OnlineCheckIntervalStyle" setting.
- *
- *  Otherwise, if "EnableOnlineToReadyTransition" is asserted, then
- *  counters are managed for the success or failure and state is
- *  managed and tracked resulting in the potential demotion of the
- *  service, placing it into a temporary failure state until such time
- *  as a series of back-to-back online checks successfully
- *  complete. If the service is a non-default after demotion and it is
- *  in failure state or if it is the default service, then a future
- *  online check is scheduled based on the current interval and the
- *  "OnlineCheckIntervalStyle" setting.
- *
- *  @param[in,out]  service  A pointer to the mutable service for which
- *                           to complete a previously-requested online
- *                           check.
- *  @param[in]      type     The IP configuration type for which to
- *                           complete a previously-requested online
- *                           check.
- *  @param[in]      success  A Boolean indicating whether the =
previously-
- *                           requested online check was successful.
- *
- *  @sa cancel_online_check
- *  @sa start_online_check
- *  @sa start_wispr_if_connected
- *  @sa __connman_service_wispr_start
- *
- */
-static void complete_online_check(struct connman_service *service,
-					enum connman_ipconfig_type type,
-					bool success)
-{
-	GSourceFunc redo_func;
-	unsigned int *interval;
-	guint *timeout;
-	enum connman_service_state current_state;
-	guint seconds;
-	guint current_timeout;
-
-	DBG("service %p (%s) type %d (%s) success %d\n",
-		service,
-		connman_service_get_identifier(service),
-		type, __connman_ipconfig_type2string(type),
-		success);
-
-	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4) {
-		interval =3D &service->online_check_interval_ipv4;
-		timeout =3D &service->online_timeout_ipv4;
-		redo_func =3D redo_wispr_ipv4;
-	} else {
-		interval =3D &service->online_check_interval_ipv6;
-		timeout =3D &service->online_timeout_ipv6;
-		redo_func =3D redo_wispr_ipv6;
-	}
-
-	if(!enable_online_to_ready_transition)
-		goto redo_func;
-
-	if (success) {
-		*interval =3D online_check_max_interval;
-	} else {
-		current_state =3D service->state;
-		service_downgrade_online_state(service);
-		if (current_state !=3D service->state)
-			*interval =3D online_check_initial_interval;
-		if (service !=3D connman_service_get_default()) {
-			return;
-		}
-	}
-
-redo_func:
-	DBG("updating online checkout timeout period");
-
-	seconds =3D online_check_timeout_compute_func(*interval);
-
-	DBG("service %p (%s) type %d (%s) interval %d style \"%s\" =
seconds %u",
-		service,
-		connman_service_get_identifier(service),
-		type, __connman_ipconfig_type2string(type),
-		*interval, online_check_timeout_interval_style, =
seconds);
-
-	current_timeout =3D g_timeout_add_seconds(seconds,
-				redo_func, =
connman_service_ref(service));
-
-	*timeout =3D current_timeout;
-
-	/* Increment the interval for the next time, limiting to a =
maximum
-	 * interval of @a online_check_max_interval.
-	 */
-	if (*interval < online_check_max_interval)
-		(*interval)++;
-}
-
 int __connman_service_ipconfig_indicate_state(struct connman_service =
*service,
 					enum connman_service_state =
new_state,
 					enum connman_ipconfig_type type)
--=20
2.42.0


