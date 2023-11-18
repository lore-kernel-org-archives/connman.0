Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49312376
	for <connman@lists.linux.dev>; Sat, 18 Nov 2023 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 05459730FC
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 19:22:57 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B1A537310B
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 19:22:56 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] service: Bifurcate 'complete_online_check' handling.
Date: Fri, 17 Nov 2023 16:22:43 -0800
Message-ID: <20231118002244.723157-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118002244.723157-1-gerickson@nuovations.com>
References: <20231118002244.723157-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This bifurcates 'complete_online_check' closure handling into a
success and failure handler: 'handle_online_check_success' and
'handle_online_check_failure'.

Both at present and as the continuous online check mode (also known
as, 'EnableOnlineToReadyTransition') evolves, the closure handling of
online checks is both more tractable and easier to reason about when
partitioned into success and failures rather than co-mingling both
into the same function. Moreover, it simplifies
'complete_online_check' itself.
---
 src/service.c | 124 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 93 insertions(+), 31 deletions(-)

diff --git a/src/service.c b/src/service.c
index ee78caf9e0cc..34608ba9ce67 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1872,8 +1872,8 @@ static gboolean redo_wispr_ipv6(gpointer user_data)
  *
  */
 static void reschedule_online_check(struct connman_service *service,
-				enum connman_ipconfig_type type,
-				struct online_check_state *online_check_state)
+			enum connman_ipconfig_type type,
+			struct online_check_state *online_check_state)
 {
 	GSourceFunc redo_func;
 	guint seconds;
@@ -1917,6 +1917,72 @@ static void reschedule_online_check(struct connman_service *service,
 		online_check_state->interval++;
 }
 
+static bool handle_online_check_success(struct connman_service *service,
+				enum connman_ipconfig_type type,
+				struct online_check_state *online_check_state,
+				bool oneshot)
+{
+	const bool reschedule = !oneshot;
+
+	DBG("service %p (%s) type %d (%s) "
+		"one-shot %u\n",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		oneshot);
+
+	__connman_service_ipconfig_indicate_state(service,
+		CONNMAN_SERVICE_STATE_ONLINE,
+		type);
+
+	if (!oneshot)
+		online_check_state->interval = online_check_max_interval;
+
+	return reschedule;
+}
+
+static bool handle_online_check_failure(struct connman_service *service,
+				enum connman_ipconfig_type type,
+				enum connman_service_state ipconfig_state,
+				struct online_check_state *online_check_state,
+				bool oneshot,
+				int err)
+{
+	bool reschedule = false;
+
+	DBG("service %p (%s) type %d (%s) "
+		"one-shot %u err %d (%s)\n",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		oneshot, err, strerror(-err));
+
+	/*
+	 * If this completion closure was a failure with error status
+	 * -ECANCELED, then it was canceled by #__connman_wispr_cancel.
+	 * Simply ignore it and DO NOT reschedule; another check will be
+	 * along to replace the canceled one.
+	 */
+	if (err == -ECANCELED) {
+		DBG("online check was canceled; no action taken");
+
+		goto done;
+	}
+
+	if (oneshot)
+		reschedule = true;
+	else {
+		if (service_downgrade_online_state(service))
+			online_check_state->interval =
+				online_check_initial_interval;
+
+		reschedule = connman_service_is_default(service);
+	}
+
+done:
+	return reschedule;
+}
+
 /**
  *  @brief
  *    This completes an "online" HTTP-based Internet reachability
@@ -1970,46 +2036,42 @@ static void complete_online_check(struct connman_service *service,
 					int err)
 {
 	struct online_check_state *online_check_state;
+	enum connman_service_state *ipconfig_state;
+	bool reschedule = false;
 
-	DBG("service %p (%s) type %d (%s) success %d err %d (%s)\n",
+	DBG("service %p (%s) type %d (%s) "
+		"success %u err %d (%s)\n",
 		service,
 		connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type),
 		success, err, strerror(-err));
 
-	if (!success && err == -ECANCELED) {
-		DBG("online check was canceled; no action taken");
-		return;
-	}
-
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		online_check_state = &service->online_check_state_ipv4;
-	else
+		ipconfig_state = &service->state_ipv4;
+	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 		online_check_state = &service->online_check_state_ipv6;
+		ipconfig_state = &service->state_ipv6;
+	} else
+		return;
 
-	if (success) {
-		__connman_service_ipconfig_indicate_state(service,
-			CONNMAN_SERVICE_STATE_ONLINE,
-			type);
-
-		if (!enable_online_to_ready_transition)
-			return;
-	} else if (!enable_online_to_ready_transition)
-		goto reschedule;
+	if (success)
+		reschedule = handle_online_check_success(service,
+					 type,
+					 online_check_state,
+					 !enable_online_to_ready_transition);
+	else
+		reschedule = handle_online_check_failure(service,
+					 type,
+					 *ipconfig_state,
+					 online_check_state,
+					 !enable_online_to_ready_transition,
+					 err);
 
-	if (success) {
-		online_check_state->interval = online_check_max_interval;
-	} else {
-		if (service_downgrade_online_state(service))
-			online_check_state->interval =
-				online_check_initial_interval;
-		if (service != connman_service_get_default()) {
-			return;
-		}
-	}
+	DBG("reschedule online check %u", reschedule);
 
-reschedule:
-	reschedule_online_check(service, type, online_check_state);
+	if (reschedule)
+		reschedule_online_check(service, type, online_check_state);
 }
 
 /**
-- 
2.42.0

