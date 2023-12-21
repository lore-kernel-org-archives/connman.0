Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B680B667
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 92E3573200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:58 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5469F73232
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 56/60] service: Leverage 'OnlineCheckMode' setting.
Date: Wed, 20 Dec 2023 22:17:19 -0800
Message-ID: <20231221061734.2344286-57-gerickson@nuovations.com>
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

This leverages the newly-introduced 'OnlineCheckMode' setting,
displacing and deprecating both the use of 'EnableOnlineCheck' and
'EnableOnlineToReadyTransition' in this module.
---
 src/connman.h |   7 ++++
 src/service.c | 113 +++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 28280a55b0ec..b33704d31bc4 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -807,8 +807,15 @@ enum service_online_check_mode {
 	CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS = 3
 };
 
+const char *__connman_service_online_check_mode2string(
+		enum service_online_check_mode mode);
 enum service_online_check_mode __connman_service_online_check_string2mode(
 		const char *mode);
+enum service_online_check_mode __connman_service_get_online_check_mode(void);
+bool __connman_service_is_online_check_enabled(void);
+bool __connman_service_is_online_check_mode(
+		enum service_online_check_mode mode);
+
 int __connman_service_nameserver_append(struct connman_service *service,
 				const char *nameserver, bool is_auto);
 int __connman_service_nameserver_remove(struct connman_service *service,
diff --git a/src/service.c b/src/service.c
index c427fc441193..99b322a91684 100644
--- a/src/service.c
+++ b/src/service.c
@@ -83,7 +83,6 @@ static unsigned int vpn_autoconnect_id = 0;
  */
 static struct connman_service *current_default = NULL;
 static bool services_dirty = false;
-static bool enable_online_to_ready_transition = false;
 static unsigned int online_check_connect_timeout_ms = 0;
 static unsigned int online_check_initial_interval = 0;
 static unsigned int online_check_max_interval = 0;
@@ -1749,6 +1748,25 @@ static bool check_proxy_setup(struct connman_service *service)
 	return false;
 }
 
+const char *__connman_service_online_check_mode2string(
+				enum service_online_check_mode mode)
+{
+	switch (mode) {
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN:
+		break;
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE:
+		return "none";
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT:
+		return "one-shot";
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS:
+		return "continuous";
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 enum service_online_check_mode __connman_service_online_check_string2mode(
 				const char *mode)
 {
@@ -1765,6 +1783,61 @@ enum service_online_check_mode __connman_service_online_check_string2mode(
 	return CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN;
 }
 
+/**
+ *  @brief
+ *    Return the "online" HTTP-based Internet reachability check mode.
+ *
+ *  @returns
+ *    The "online" HTTP-based Internet reachability check mode.
+ *
+ */
+enum service_online_check_mode __connman_service_get_online_check_mode(void)
+{
+	return connman_setting_get_uint("OnlineCheckMode");
+}
+
+/**
+ *  @brief
+ *    Return whether the "online" HTTP-based Internet reachability
+ *    checks are enabled.
+ *
+ *  @returns
+ *    True if "online" HTTP-based Internet reachability checks are
+ *    enabled; otherwise, false.
+ *
+ *  @sa __connman_service_get_online_check_mode
+ *
+ */
+bool __connman_service_is_online_check_enabled(void)
+{
+	const enum service_online_check_mode mode =
+		__connman_service_get_online_check_mode();
+
+	return mode != CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN &&
+		mode != CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE;
+}
+
+/**
+ *  @brief
+ *    Determines whether the "online" HTTP-based Internet reachability
+ *    check mode is the specified mode.
+ *
+ *  @param[in]  mode  The "online" HTTP-based Internet reachability
+ *                    check mode to confirm.
+ *
+ *  @returns
+ *    True if the current "online" HTTP-based Internet reachability
+ *    check mode is @a mode; otherwise, false.
+ *
+ *  @sa __connman_service_get_online_check_mode
+ *
+ */
+bool __connman_service_is_online_check_mode(
+		enum service_online_check_mode mode)
+{
+	return __connman_service_get_online_check_mode() == mode;
+}
+
 /**
  *  @brief
  *    Determine whether an "online" HTTP-based Internet reachability
@@ -2122,7 +2195,7 @@ static void cancel_online_check(struct connman_service *service,
 static bool online_check_is_enabled_check(
 		const struct connman_service *service)
 {
-	if (!connman_setting_get_bool("EnableOnlineCheck")) {
+	if (!__connman_service_is_online_check_enabled()) {
 		connman_info("Online check disabled. "
 			"Default service remains in READY state.");
 		return false;
@@ -2142,7 +2215,7 @@ static bool online_check_is_enabled_check(
  *
  *  @note
  *    Any check is skipped, with an informational log message, if @a
- *    EnableOnlineCheck is not asserted.
+ *    OnlineCheckMode is "none".
  *
  *  @param[in,out]  service  A pointer to the mutable network service
  *                           for which to start the "online"
@@ -3614,22 +3687,22 @@ done:
  *  configuration type. This effectively "bookends" an earlier
  *  #__connman_service_wispr_start.
  *
- *  If "EnableOnlineToReadyTransition" is deasserted and if @a success
- *  is asserted, then the state for the specified IP configuration
- *  type is transitioned to "online" and a future online check is
+ *  If "OnlineCheckMode" is "one-shot" and if @a success is asserted,
+ *  then the state for the specified IP configuration type is
+ *  transitioned to "online" and a future online check is scheduled
+ *  based on the current interval and the "OnlineCheckIntervalStyle"
+ *  setting.
+ *
+ *  Otherwise, if "OnlineCheckMode" is "continuous", then counters are
+ *  managed for the success or failure and state is managed and
+ *  tracked resulting in the potential demotion of the service,
+ *  placing it into a temporary failure state until such time as a
+ *  series of back-to-back online checks successfully complete. If the
+ *  service is a non-default after demotion and it is in failure state
+ *  or if it is the default service, then a future online check is
  *  scheduled based on the current interval and the
  *  "OnlineCheckIntervalStyle" setting.
  *
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
  *  @param[in,out]  service  A pointer to the mutable service for which
  *                           to complete a previously-requested online
  *                           check.
@@ -3658,6 +3731,8 @@ static void complete_online_check(struct connman_service *service,
 					bool success,
 					int err)
 {
+	const bool oneshot = __connman_service_is_online_check_mode(
+		CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT);
 	struct online_check_state *online_check_state;
 	enum connman_service_state ipconfig_state;
 	bool reschedule = false;
@@ -3682,13 +3757,13 @@ static void complete_online_check(struct connman_service *service,
 		reschedule = handle_online_check_success(service,
 					 type,
 					 online_check_state,
-					 !enable_online_to_ready_transition);
+					 oneshot);
 	else
 		reschedule = handle_online_check_failure(service,
 					 type,
 					 ipconfig_state,
 					 online_check_state,
-					 !enable_online_to_ready_transition,
+					 oneshot,
 					 err);
 
 	DBG("reschedule online check %u", reschedule);
@@ -10689,8 +10764,6 @@ int __connman_service_init(void)
 
 	remove_unprovisioned_services();
 
-	enable_online_to_ready_transition =
-		connman_setting_get_bool("EnableOnlineToReadyTransition");
 	online_check_timeout_interval_style =
 		connman_setting_get_string("OnlineCheckIntervalStyle");
 	if (g_strcmp0(online_check_timeout_interval_style, "fibonacci") == 0)
-- 
2.42.0

