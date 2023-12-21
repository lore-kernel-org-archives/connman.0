Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D9BA43
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1F51373225
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:47 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BF8FD73233
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:46 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 27/60] service: Complete 'continuous' online check mode implementation.
Date: Wed, 20 Dec 2023 22:16:50 -0800
Message-ID: <20231221061734.2344286-28-gerickson@nuovations.com>
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

This completes the implementation of 'EnableOnlineToReadyTransition'
begun by Emmanuel Vautrin with commit f0bd0e8fe578 ("service: Add
online to ready transition feature").

When asserted along with 'EnableOnlineCheck',
'EnableOnlineToReadyTransition' effects what can be thought of as a
"continuous" online check mode, which is different from the "one-shot"
online check more when 'EnableOnlineToReadyTransition' is not asserted
but 'EnableOnlineCheck' is. Effectively, these two Booleans encode
three online check modes:

    1. None (!EnableOnlineCheck)
    2. One-shot (EnableOnlineCheck && !EnableOnlineToReadyTransition)
    3. Continuous (EnableOnlineCheck && EnableOnlineToReadyTransition)

With this change, these three modes are all but formalized.

In "none" mode, as has been the case historically, there are no
"online" HTTP-based Internet reachability checks. Any connected
service and the manager state will terminate at the "ready" state and
will not progress to "online".

In "one-shot" mode, as has been the case historically, there is a
single, one-shot "online" HTTP-based Internet reachability check for
the default service. When the check succeeds, the associated service
and the manager state will terminate at the "online" state. When the
check fails, subsequent checks will be rescheduled according to
"OnlineCheckIntervalStyle", "OnlineCheckInitialInterval", and
"OnlineCheckMaxInterval" and will continue indefinitely until one
succeeds or until the service is disconnected.

In "continuous" mode, which is finalized with this change, there are
ongoing "online" HTTP-based Internet reachability check for the
default service. As with "one-shot" mode, when the first check
succeeds, the associated service and the manager state will terminate
at the "online" state. Thereafter, subsequent checks will be scheduled
according to "OnlineCheckIntervalStyle" and
"OnlineCheckMaxInterval". When the check fails, subsequent checks will
be rescheduled according to "OnlineCheckIntervalStyle",
"OnlineCheckInitialInterval", and "OnlineCheckMaxInterval". This is
largely unchanged. However, what is new with this change is that when
and if "OnlineCheckFailuresThreshold" is met, the service and manager
state will be demoted to "ready" and the service will have its "Error"
property set to "online-check-failed" while subsequent checks will
continue. In the interim, if available, another service may be
promoted to the default service and online checks will be initiated
for it. When and if, for the demoted service,
"OnlineCheckSuccessesThreshold" is met, the service "Error" property
will be cleared and the service state promoted to "online",
potentially causing it to become the default service again.
---
 src/service.c | 661 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 643 insertions(+), 18 deletions(-)

diff --git a/src/service.c b/src/service.c
index 2017370d7ce8..15a79c0aa5c8 100644
--- a/src/service.c
+++ b/src/service.c
@@ -46,6 +46,10 @@
 #define VPN_AUTOCONNECT_TIMEOUT_ATTEMPTS_THRESHOLD 270
 
 typedef guint (*online_check_timeout_compute_t)(unsigned int interval);
+typedef bool (*is_counter_threshold_met_predicate_t)(
+	const struct connman_service *service,
+	const char *counter_description,
+	unsigned int counter_threshold);
 
 static DBusConnection *connection = NULL;
 
@@ -219,12 +223,14 @@ static struct connman_ipconfig *create_ip6config(struct connman_service *service
 static void dns_changed(struct connman_service *service);
 static void vpn_auto_connect(void);
 static void trigger_autoconnect(struct connman_service *service);
+static void service_list_sort(void);
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success,
 					int err);
 static bool service_downgrade_online_state(struct connman_service *service);
 static bool connman_service_is_default(const struct connman_service *service);
+static int start_online_check_if_connected(struct connman_service *service);
 static void set_error(struct connman_service *service,
 					enum connman_service_error error);
 static void clear_error(struct connman_service *service);
@@ -2162,6 +2168,235 @@ done:
 	return status;
 }
 
+static bool online_check_failures_threshold_was_met(
+			const struct connman_service *service)
+{
+	return service->online_check_failures_met_threshold;
+}
+
+static void online_check_failures_threshold_was_met_set_value(
+			struct connman_service *service, bool value)
+{
+	DBG("service %p (%s) failures met threshold %u",
+		service, connman_service_get_identifier(service),
+		value);
+
+	service->online_check_failures_met_threshold = value;
+}
+
+static void online_check_failures_threshold_was_met_set(
+			struct connman_service *service)
+{
+	online_check_failures_threshold_was_met_set_value(service, true);
+}
+
+static void online_check_failures_threshold_was_met_clear(
+			struct connman_service *service)
+{
+	online_check_failures_threshold_was_met_set_value(service, false);
+}
+
+static inline void online_check_counter_reset(
+			unsigned int *counter)
+{
+	if (!counter)
+		return;
+
+	*counter = 0;
+}
+
+static void online_check_failures_reset(struct connman_service *service)
+{
+	DBG("service %p (%s)",
+		service, connman_service_get_identifier(service));
+
+	online_check_counter_reset(&service->online_check_state_ipv4.failures);
+	online_check_counter_reset(&service->online_check_state_ipv6.failures);
+}
+
+static void online_check_successes_reset(struct connman_service *service)
+{
+	DBG("service %p (%s)",
+		service, connman_service_get_identifier(service));
+
+	online_check_counter_reset(&service->online_check_state_ipv4.successes);
+	online_check_counter_reset(&service->online_check_state_ipv6.successes);
+}
+
+static void online_check_state_reset(struct connman_service *service)
+{
+	online_check_failures_reset(service);
+
+	online_check_successes_reset(service);
+
+	online_check_failures_threshold_was_met_clear(service);
+
+	clear_error(service);
+}
+
+static void online_check_counters_log(
+			const struct connman_service *service,
+			const char *counter_description,
+			unsigned int ipv4_counter,
+			unsigned int ipv6_counter)
+{
+	DBG("service %p (%s) "
+		"ipv4 state %d (%s) %s(s/es) %u "
+		"ipv6 state %d (%s) %s(s/es) %u ",
+		service, connman_service_get_identifier(service),
+		service->state_ipv4, state2string(service->state_ipv4),
+		counter_description,
+		ipv4_counter,
+		service->state_ipv6, state2string(service->state_ipv6),
+		counter_description,
+		ipv6_counter);
+}
+
+static bool online_check_counter_threshold_is_met(
+			const struct connman_service *service,
+			const char *counter_threshold_key,
+			const char *counter_description,
+			is_counter_threshold_met_predicate_t predicate)
+{
+	unsigned int counter_threshold;
+	bool threshold_met = false;
+
+	if (!service ||
+		!counter_threshold_key ||
+		!counter_description ||
+		!predicate)
+		goto done;
+
+	counter_threshold = connman_setting_get_uint(counter_threshold_key);
+
+	threshold_met = predicate(service,
+						counter_description,
+						counter_threshold);
+
+	DBG("service %p (%s) %s threshold %u %s(s) met %u",
+		service, connman_service_get_identifier(service),
+		counter_description,
+		counter_threshold,
+		counter_description,
+		threshold_met);
+
+done:
+	return threshold_met;
+}
+
+static bool is_online_check_failure_threshold_met_predicate(
+			const struct connman_service *service,
+			const char *counter_description,
+			unsigned int counter_threshold)
+{
+	bool ipv4_is_connected;
+	bool ipv6_is_connected;
+	bool threshold_met = false;
+
+	online_check_counters_log(service,
+		counter_description,
+		service->online_check_state_ipv4.failures,
+		service->online_check_state_ipv6.failures);
+
+	ipv4_is_connected = is_connected(service->state_ipv4);
+	ipv6_is_connected = is_connected(service->state_ipv6);
+
+	/*
+	 * It is entirely possible that IPv4 reachability is fine and that
+	 * IPv6 reachablity is not due to the premises ISP, premises
+	 * Internet access equipment (that is, CPE), availability of the
+	 * reachability endpoint infrastructure, etc.
+	 *
+	 * Consequently, we want to see bilateral failures of BOTH IPv4
+	 * AND IPv6 in excess of the threshold, to the extent either is
+	 * connected (based on the #is_connected predicate).
+	 */
+	if ((!ipv6_is_connected &&
+		 ipv4_is_connected &&
+		 service->online_check_state_ipv4.failures >=
+		 counter_threshold) ||
+
+		(!ipv4_is_connected &&
+		ipv6_is_connected &&
+		service->online_check_state_ipv6.failures >=
+		counter_threshold) ||
+
+		(ipv4_is_connected &&
+		service->online_check_state_ipv4.failures >=
+		counter_threshold &&
+		ipv6_is_connected &&
+		service->online_check_state_ipv6.failures >=
+		counter_threshold)) {
+		threshold_met = true;
+	}
+
+	return threshold_met;
+}
+
+static bool online_check_failures_threshold_is_met(
+			const struct connman_service *service)
+{
+	const char * const counter_threshold_key =
+		"OnlineCheckFailuresThreshold";
+	const char * const counter_description =
+		"failure";
+
+	return online_check_counter_threshold_is_met(service,
+			counter_threshold_key,
+			counter_description,
+			is_online_check_failure_threshold_met_predicate);
+}
+
+static bool is_online_check_success_threshold_met_predicate(
+			const struct connman_service *service,
+			const char *counter_description,
+			unsigned int counter_threshold)
+{
+	bool threshold_met = false;
+
+	online_check_counters_log(service,
+		counter_description,
+		service->online_check_state_ipv4.successes,
+		service->online_check_state_ipv6.successes);
+
+	/*
+	 * It is entirely possible that IPv4 reachability is fine and that
+	 * IPv6 reachablity is not due to the premises ISP, premises
+	 * Internet access equipment (that is, CPE), availability of the
+	 * reachability endpoint infrastructure, etc.
+	 *
+	 * Consequently, we want to see bilateral successes of EITHER IPv4
+	 * OR IPv6 (as with #combine_state) in excess of the threshold, to
+	 * the extent either is connected (based on the #is_connected
+	 * predicate).
+	 */
+
+	if ((is_connected(service->state_ipv4) &&
+		service->online_check_state_ipv4.successes >=
+		counter_threshold) ||
+		(is_connected(service->state_ipv6) &&
+		service->online_check_state_ipv6.successes >=
+		counter_threshold)) {
+		threshold_met = true;
+	}
+
+	return threshold_met;
+}
+
+static bool online_check_successes_threshold_is_met(
+			const struct connman_service *service)
+{
+	const char * const counter_threshold_key =
+		"OnlineCheckSuccessesThreshold";
+	const char * const counter_description =
+		"success";
+
+	return online_check_counter_threshold_is_met(service,
+			counter_threshold_key,
+			counter_description,
+			is_online_check_success_threshold_met_predicate);
+}
+
 /**
  *  @brief
  *    Retry an "online" HTTP-based Internet reachability check.
@@ -2356,6 +2591,214 @@ static void reschedule_online_check(struct connman_service *service,
 		online_check_state->interval++;
 }
 
+static void online_check_counter_increment_and_log(
+			const struct connman_service *service,
+			enum connman_ipconfig_type type,
+			const char *counter_description,
+			unsigned int *counter)
+{
+	if (!service || !counter_description || !counter)
+		return;
+
+	(*counter)++;
+
+	DBG("service %p (%s) type %d (%s) %s %u",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		counter_description, *counter);
+}
+
+static void online_check_log_success(const struct connman_service *service,
+			enum connman_ipconfig_type type)
+{
+	g_autofree char *interface = NULL;
+
+	interface = connman_service_get_interface(service);
+
+	connman_info("Interface %s [ %s ] %s online check to %s succeeded",
+		interface,
+		__connman_service_type2string(service->type),
+		__connman_ipconfig_type2string(type),
+		type == CONNMAN_IPCONFIG_TYPE_IPV4 ?
+			connman_setting_get_string("OnlineCheckIPv4URL") :
+			connman_setting_get_string("OnlineCheckIPv6URL"));
+}
+
+static void continuous_online_check_log_counter_threshold_met(
+			const struct connman_service *service,
+			const char *counter_threshold_key,
+			const char *counter_description)
+{
+	g_autofree char *interface = NULL;
+
+	interface = connman_service_get_interface(service);
+
+	connman_warn("Interface %s [ %s ] online check had %u back-to-back "
+		"%s; %s threshold met",
+		interface,
+		__connman_service_type2string(service->type),
+		connman_setting_get_uint(counter_threshold_key),
+				 counter_description,
+				 counter_description);
+}
+
+static void continuous_online_check_log_successes_threshold_met(
+			const struct connman_service *service
+)
+{
+	static const char *const counter_threshold_key =
+		"OnlineCheckSuccessesThreshold";
+	static const char *const counter_description =
+		"success(es)";
+
+	continuous_online_check_log_counter_threshold_met(service,
+		counter_threshold_key,
+		counter_description);
+}
+
+static void continuous_online_check_log_failures_threshold_met(
+			const struct connman_service *service
+)
+{
+	static const char *const counter_threshold_key =
+		"OnlineCheckFailuresThreshold";
+	static const char *const counter_description =
+		"failure(s)";
+
+	continuous_online_check_log_counter_threshold_met(service,
+		counter_threshold_key,
+		counter_description);
+}
+
+static bool handle_oneshot_online_check_success(
+			struct connman_service *service,
+			enum connman_ipconfig_type type,
+			struct online_check_state *online_check_state)
+{
+	const bool reschedule = true;
+
+	/*
+	 * Simply log the success, mark the service IP configuration state
+	 * as ONLINE, and return.
+	 */
+	online_check_log_success(service, type);
+
+	__connman_service_ipconfig_indicate_state(service,
+		CONNMAN_SERVICE_STATE_ONLINE,
+		type);
+
+	return !reschedule;
+}
+
+static bool handle_continuous_online_check_success(
+			struct connman_service *service,
+			enum connman_ipconfig_type type,
+			struct online_check_state *online_check_state)
+{
+	bool failures_threshold_was_met;
+	bool successes_threshold_is_met;
+	const bool reschedule = true;
+
+	/* Unconditionally increment and log the success counter. */
+
+	online_check_counter_increment_and_log(service, type,
+		"successes", &online_check_state->successes);
+
+	/*
+	 * Ultimately, for failures, we are looking for a STRING of
+	 * SUSTAINED, BACK-TO-BACK failures to meet the failures
+	 * threshold. Consequently, any success should reset the
+	 * corresponding failure count back to zero (0).
+	 */
+	online_check_counter_reset(&online_check_state->failures);
+
+	failures_threshold_was_met =
+		online_check_failures_threshold_was_met(service);
+	successes_threshold_is_met =
+		online_check_successes_threshold_is_met(service);
+
+	DBG("failures threshold was met %u, "
+		"successes threshold is met %u, "
+		"default %u",
+		failures_threshold_was_met,
+		successes_threshold_is_met,
+		connman_service_is_default(service));
+
+	/*
+	 * If the service HAD previously-exceeded the failure threshold
+	 * AND if this is the first success, then reset the online check
+	 * interval to the initial, minimum value since we want to recover
+	 * as quickly as possible with a STRING of SUSTAINED, BACK-TO-BACK
+	 * successes, where the length of that string is dictated by the
+	 * "OnlineCheckSuccessesThreshold" settings value.
+	 *
+	 * Otherwise, if the service HAD NOT previously-exceeded the
+	 * failure threshold OR if it HAD previously-exceeded the failure
+	 * threshold AND the successes threshold was met, then reset the
+	 * online check interval to the maximum value.
+	 */
+	if (failures_threshold_was_met &&
+		online_check_state->successes == 1)
+		online_check_state->interval = online_check_initial_interval;
+	else if (!failures_threshold_was_met ||
+		(failures_threshold_was_met && successes_threshold_is_met))
+		online_check_state->interval = online_check_max_interval;
+
+	/*
+	 * If the service HAD NOT previously-exceeded the failure
+	 * threshold, then simply mark the service IP configuration state
+	 * as ONLINE.
+	 *
+	 * Otherwise, if the service HAD previously exceeded the failure
+	 * threshold AND successes meet or exceed the configured success
+	 * threshold, then re-sort the network services and update the
+	 * gateways accordingly.
+	 *
+	 * The succeeding service will be promoted until such time as it
+	 * has a configured number of failures, at which time, we will
+	 * resort again.
+	 *
+	 */
+	if (!failures_threshold_was_met) {
+		if (online_check_state->successes == 1)
+			online_check_log_success(service, type);
+
+		if (connman_service_is_default(service))
+			__connman_service_ipconfig_indicate_state(service,
+				CONNMAN_SERVICE_STATE_ONLINE,
+				type);
+	} else if (failures_threshold_was_met &&
+			   successes_threshold_is_met) {
+		online_check_log_success(service, type);
+
+		continuous_online_check_log_successes_threshold_met(service);
+
+		online_check_state_reset(service);
+
+		/*
+		 * The ordering here is considered and intentional. FIRST, now
+		 * that this service has cleared / reset the online check
+		 * state, re-sort the service list. This may promote this
+		 * service back to the default. SECOND, make the READY to
+		 * ONLINE promotion, since that promotion is qualified with
+		 * this service being the default (that is, has the default
+		 * route) service.
+		 */
+		service_list_sort();
+
+		if (connman_service_is_default(service)) {
+			__connman_service_ipconfig_indicate_state(
+				service,
+				CONNMAN_SERVICE_STATE_ONLINE,
+				type);
+		}
+
+		__connman_gateway_update();
+	}
+
+	return reschedule;
+}
+
 /**
  *  @brief
  *    Handle the successful completion of an "online" HTTP-based
@@ -2395,7 +2838,7 @@ static bool handle_online_check_success(struct connman_service *service,
 				struct online_check_state *online_check_state,
 				bool oneshot)
 {
-	const bool reschedule = !oneshot;
+	bool reschedule;
 
 	DBG("service %p (%s) type %d (%s) "
 		"one-shot %u\n",
@@ -2404,12 +2847,144 @@ static bool handle_online_check_success(struct connman_service *service,
 		type, __connman_ipconfig_type2string(type),
 		oneshot);
 
-	__connman_service_ipconfig_indicate_state(service,
-		CONNMAN_SERVICE_STATE_ONLINE,
-		type);
+	if (oneshot)
+		reschedule = handle_oneshot_online_check_success(service,
+						type,
+						online_check_state);
+	else
+		reschedule = handle_continuous_online_check_success(service,
+						type,
+						online_check_state);
 
-	if (!oneshot)
-		online_check_state->interval = online_check_max_interval;
+	return reschedule;
+}
+
+static void online_check_log_failure(const struct connman_service *service,
+			enum connman_ipconfig_type type,
+			int err)
+{
+	g_autofree char *interface = NULL;
+
+	interface = connman_service_get_interface(service);
+
+	connman_warn("Interface %s [ %s ] %s online check to %s failed: %d: %s",
+		interface,
+		__connman_service_type2string(service->type),
+		__connman_ipconfig_type2string(type),
+		type == CONNMAN_IPCONFIG_TYPE_IPV4 ?
+			connman_setting_get_string("OnlineCheckIPv4URL") :
+			connman_setting_get_string("OnlineCheckIPv6URL"),
+		err,
+		strerror(-err));
+}
+
+static bool handle_oneshot_online_check_failure(
+			struct connman_service *service,
+			enum connman_ipconfig_type type,
+			enum connman_service_state ipconfig_state,
+			struct online_check_state *online_check_state,
+			int err)
+{
+	const bool reschedule = true;
+
+	/* Simply indicate rescheduling another check is desired. */
+
+	DBG("online check mode is one-shot; requesting another check");
+
+	return reschedule;
+}
+
+static bool handle_continuous_online_check_failure(
+			struct connman_service *service,
+			enum connman_ipconfig_type type,
+			enum connman_service_state ipconfig_state,
+			struct online_check_state *online_check_state,
+			int err)
+{
+	bool reschedule = false;
+
+	/* Unconditionally increment and log the failure counter. */
+
+	online_check_counter_increment_and_log(service, type,
+		"failures", &online_check_state->failures);
+
+	/*
+	 * Ultimately, for successes, we are looking for a STRING of
+	 * SUSTAINED, BACK-TO-BACK successes to meet the successes
+	 * threshold. Consequently, any failure should reset the
+	 * corresponding success count back to zero (0).
+	 */
+	online_check_counter_reset(&online_check_state->successes);
+
+	/*
+	 * If this is the first failure, then reset the online check
+	 * interval to the initial, minimum value. Subsequent failures
+	 * will increment the interval on reschedule from here until the
+	 * maximum interval is hit.
+	 */
+	if (online_check_state->failures == 1)
+		online_check_state->interval = online_check_initial_interval;
+
+	DBG("failures threshold was met %u failures threshold is met %u "
+		"default %u",
+		online_check_failures_threshold_was_met(service),
+		online_check_failures_threshold_is_met(service),
+		connman_service_is_default(service));
+
+	/*
+	 * If the service HAD NOT previously-exceeded the failure
+	 * threshold AND failures meet or exceed the configured failure
+	 * threshold, then:
+	 *
+	 *	  1. Assert the failure threshold state.
+	 *	  2. Reset the success counters.
+	 *	  3. Attempt to downgrade the service IP configuration state
+	 *		 from ONLINE to READY.
+	 *	  4. Re-sort the network services.
+	 *	  5. Update the gateways accordingly.
+	 *
+	 * The failing service will be demoted until such time as it has a
+	 * configured number of successes, at which time, we will resort
+	 * again.
+	 *
+	 */
+	if (!online_check_failures_threshold_was_met(service) &&
+		online_check_failures_threshold_is_met(service)) {
+		online_check_failures_threshold_was_met_set(service);
+
+		continuous_online_check_log_failures_threshold_met(service);
+
+		online_check_successes_reset(service);
+
+		/*
+		 * Attempt to downgrade the service state from ONLINE to
+		 * READY.
+		 *
+		 * We attempt BOTH IPv4 and IPv6 IP configuration states since
+		 * the #online_check_failures_threshold_is_met predicate tells
+		 * us that both IP configurations have met the failures
+		 * threshold.
+		 */
+		service_downgrade_online_state(service);
+
+		set_error(service, CONNMAN_SERVICE_ERROR_ONLINE_CHECK_FAILED);
+
+		service_list_sort();
+
+		__connman_gateway_update();
+	}
+
+	DBG("failures threshold was met %u, default %u",
+		online_check_failures_threshold_was_met(service),
+		connman_service_is_default(service));
+
+	/*
+	 * We only want to reschedule future online checks for
+	 * the default service or those that are in failure.
+	 */
+	if (connman_service_is_default(service) ||
+		online_check_failures_threshold_was_met(service))
+		reschedule = true;
 
 	return reschedule;
 }
@@ -2473,10 +3048,10 @@ static bool handle_online_check_failure(struct connman_service *service,
 		oneshot, err, strerror(-err));
 
 	/*
-	 * If this completion closure was a failure with error status
-	 * -ECANCELED, then it was canceled by #__connman_wispr_cancel.
-	 * Simply ignore it and DO NOT reschedule; another check will be
-	 * along to replace the canceled one.
+	 * Regardless of online check mode, if this completion closure
+	 * was a failure with error status -ECANCELED, then it was canceled
+	 * by #__connman_wispr_cancel. Simply ignore it and DO NOT indicate
+	 * rescheduling another check is desired.
 	 */
 	if (err == -ECANCELED) {
 		DBG("online check was canceled; no action taken");
@@ -2484,15 +3059,26 @@ static bool handle_online_check_failure(struct connman_service *service,
 		goto done;
 	}
 
-	if (oneshot)
-		reschedule = true;
-	else {
-		if (service_downgrade_online_state(service))
-			online_check_state->interval =
-				online_check_initial_interval;
+	/* Unconditionally log the failure, regardless of online check mode. */
 
-		reschedule = connman_service_is_default(service);
-	}
+	online_check_log_failure(service, type, err);
+
+	/* Handle the failure according to the online check mode. */
+
+	if (oneshot)
+		reschedule = handle_oneshot_online_check_failure(
+						service,
+						type,
+						ipconfig_state,
+						online_check_state,
+						err);
+	else
+		reschedule = handle_continuous_online_check_failure(
+						service,
+						type,
+						ipconfig_state,
+						online_check_state,
+						err);
 
 done:
 	return reschedule;
@@ -3004,6 +3590,34 @@ static void default_changed(void)
 
 	__connman_service_timeserver_changed(current_default, NULL);
 
+	/*
+	 * If there is a current default service, then it may either have
+	 * been temporarily:
+	 *
+	 *	 1. promoted as a failover from another senior service that
+	 *		was temporarily demoted
+	 *	 2. demoted as a failover to another junior service that is
+	 *		being temporarily promoted
+	 *
+	 * due to a continuous mode online check failure.
+	 *
+	 * Regardless, only services in online check failure or the default
+	 * service should be running online checks and only the default
+	 * service should be online. Consequently, make the appropriate
+	 * calls on the current default to ensure that is the case BEFORE
+	 * assigning the proposed new default as the current default.
+	 */
+	if (current_default) {
+		if (!online_check_failures_threshold_was_met(current_default) &&
+			current_default->error !=
+				CONNMAN_SERVICE_ERROR_ONLINE_CHECK_FAILED) {
+			cancel_online_check(current_default,
+				CONNMAN_IPCONFIG_TYPE_ALL);
+
+			service_downgrade_online_state(current_default);
+		}
+	}
+
 	current_default = service;
 
 	if (service) {
@@ -6867,6 +7481,15 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 
 	if (a_connected && b_connected) {
 		int rval;
+		if (!online_check_failures_threshold_was_met(service_a) &&
+			online_check_failures_threshold_was_met(service_b)) {
+			return -1;
+		}
+
+		if (online_check_failures_threshold_was_met(service_a) &&
+			!online_check_failures_threshold_was_met(service_b)) {
+			return 1;
+		}
 
 		/* Compare the VPN transport and the service */
 		if ((service_a->type == CONNMAN_SERVICE_TYPE_VPN ||
@@ -7814,6 +8437,8 @@ static int service_indicate_state(struct connman_service *service)
 
 		__connman_wispr_stop(service);
 
+		online_check_state_reset(service);
+
 		__connman_wpad_stop(service);
 
 		domain_changed(service);
-- 
2.42.0

