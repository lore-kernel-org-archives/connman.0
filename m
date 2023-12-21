Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79FB654
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A9178731A8
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:38 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 65A9973208
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:38 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/60] service: Introduce and use online check 'active' state.
Date: Wed, 20 Dec 2023 22:16:29 -0800
Message-ID: <20231221061734.2344286-7-gerickson@nuovations.com>
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

This introduces a per-IP configuration online check 'active' state
member that tracks whether an online check is active / in-flight.

Even with commit 864e48f34e8c ("service: Leverage
'__connman_wispr_cancel'.") it remains too easy to inadvertently
schedule more outstanding online checks for a service than desired
(ideally, there should be one each for IPv4 and IPv6, to the extent
they are "connected"). This is all the more so when
'EnableOnlineToReadyTransition' is asserted / online check mode is
continuous.

Rather than scheduling redundant online check, the 'active' state is
now used to enable the return of -EALREADY when it is asserted from
functions capable of initiating and scheduling an online check.
---
 src/service.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/src/service.c b/src/service.c
index 5077e3fb2d1a..669337ab6734 100644
--- a/src/service.c
+++ b/src/service.c
@@ -93,6 +93,8 @@ struct connman_stats_counter {
  *
  */
 struct online_check_state {
+	bool active;
+
 	/**
 	 *  The current GLib main loop timer identifier.
 	 *
@@ -1690,6 +1692,79 @@ static bool check_proxy_setup(struct connman_service *service)
 	return false;
 }
 
+static bool online_check_is_active(const struct connman_service *service,
+		enum connman_ipconfig_type type)
+{
+	bool do_ipv4 = false, do_ipv6 = false;
+	bool active = false;
+
+	DBG("service %p (%s) type %d (%s)",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type));
+
+	if (!service)
+		goto done;
+
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+		do_ipv4 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+		do_ipv6 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
+		do_ipv4 = do_ipv6 = true;
+	else
+		goto done;
+
+	active = (do_ipv4 && service->online_check_state_ipv4.active) ||
+			 (do_ipv6 && service->online_check_state_ipv6.active);
+
+	DBG("active? %u", active);
+
+ done:
+	return active;
+}
+
+static void online_check_active_set_value(struct connman_service *service,
+		enum connman_ipconfig_type type,
+		bool active)
+{
+	bool do_ipv4 = false, do_ipv6 = false;
+
+	DBG("service %p (%s) type %d (%s) active? %u",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		active);
+
+	if (!service)
+		return;
+
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+		do_ipv4 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+		do_ipv6 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
+		do_ipv4 = do_ipv6 = true;
+	else
+		return;
+
+	if (do_ipv4)
+		service->online_check_state_ipv4.active = active;
+
+	if (do_ipv6)
+		service->online_check_state_ipv6.active = active;
+}
+
+static void online_check_active_set(struct connman_service *service,
+		enum connman_ipconfig_type type)
+{
+	online_check_active_set_value(service, type, true);
+}
+
+static void online_check_active_clear(struct connman_service *service,
+		enum connman_ipconfig_type type)
+{
+	online_check_active_set_value(service, type, false);
+}
+
 /**
  *  @brief
  *    Compute a Fibonacci online check timeout based on the specified
@@ -1858,6 +1933,10 @@ static void cancel_online_check(struct connman_service *service,
 		 */
 		connman_service_unref(service);
 	}
+
+    /* Mark the online check state as inactive. */
+
+	online_check_active_clear(service, type);
 }
 
 /**
@@ -1917,6 +1996,8 @@ static bool online_check_is_enabled_check(
  *  @retval  -EINVAL    If @a service is null or @a type is invalid.
  *  @retval  -EPERM     If online checks are disabled via
  *                      configuration.
+ *  @retval  -EALREADY  If online checks are already active for @a
+ *                      service.
  *
  *  @sa cancel_online_check
  *  @sa complete_online_check
@@ -2379,6 +2460,8 @@ static void complete_online_check(struct connman_service *service,
 
 	if (reschedule)
 		reschedule_online_check(service, type, online_check_state);
+	else
+		online_check_active_clear(service, type);
 }
 
 /**
@@ -2443,6 +2526,8 @@ static int start_wispr_if_connected(struct connman_service *service)
  *
  *  @retval  0          If successful.
  *  @retval  -EINVAL    If @a service is null or @a type is invalid.
+ *  @retval  -EALREADY  If online checks are already active for @a
+ *                      service.
  *
  *  @sa cancel_online_check
  *  @sa start_online_check
@@ -2469,6 +2554,9 @@ int __connman_service_wispr_start(struct connman_service *service,
 		return -EINVAL;
 	}
 
+	if (online_check_is_active(service, type))
+		return -EALREADY;
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		service->online_check_state_ipv4.interval =
 					online_check_initial_interval;
@@ -2479,6 +2567,10 @@ int __connman_service_wispr_start(struct connman_service *service,
 	__connman_wispr_start(service, type,
 			online_check_connect_timeout_ms, complete_online_check);
 
+	/* Mark the online check state as active. */
+
+	online_check_active_set(service, type);
+
 	return 0;
 }
 
-- 
2.42.0

