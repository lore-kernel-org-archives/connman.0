Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D181F12EC
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878781; cv=none; b=j6TT0aqLuzWDl1gfmgJ8B7DKMZbgh9g8Wo5olQKfHUTXsVdqVEwlYA7NFhDDuxJtDS3dzDF5OhXo80kyETYLgsEdBTVjKjDF3PN14fYFMTeVuYmP8cDyaZIDERUq0YVJBHU+5kfyc8ZkN19uCh5kk+QRMiTQ3/LPtepZnD3KTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878781; c=relaxed/simple;
	bh=9WR/j9MKaHfkEu4J77VvbVhnueLvRqOLuJ3AHOaoYIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TD9n4jL4pzfZpA7sqlTigNPDq8pIDxLXyNwg12CqIQ4J/FKG/fgtV1s/hqbsf6swnKl3WD7O99ErvXSbOrbswEHQYbuPYjKk/8RV9qF7WYzcX6eLY59AsYj6XyhKHuvJwTvQpzy91IcGVrHah2Y2WUj22kydJJxRIcDPVWSfE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=lI0EwnK5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="lI0EwnK5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 917E5164AB4
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:33 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 47E72125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:33 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 9/9] wispr: Add an optional 'message' parameter to '__connman_wispr_cb_t'.
Date: Mon, 24 Mar 2025 21:59:27 -0700
Message-ID: <df5334a7db55dc87c9d499b6ad2c47005478aa07.1742878567.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742878567.git.gerickson@nuovations.com>
References: <cover.1742878567.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=dLqCmHOZonvQi17UuTF3etCgRIzHPvuHek7Br1+VIWk=; b=lI0EwnK5JokH6GgIVvLNLrnZpqk2gGJDr0m9F/ggEMf1FNbUAAg2hg5eRO8LYg1xJLcxb4eVGS76IAxHq4dd8mDoTfMvdaDpb5KHrk1P7fEGzGhQEIuQpmp7aX5Jg3P4zXTjuk4Z7m7mCPneQSs70QgRX1yqJqR3oIQcKQcPKEE6nFvVa/fpNisWelcN6fCdGIj7G4v+lPL9Xu7+JJq3ChquIa9x3uge3611kCG+7TMQcbnF+Gh8ethySNiA5ECJVwlLO6seDImx10PKt/0BeqAj4ZIzuMWu6tiLbigcE8nDG0Y0VHYit3Te6AotxfoC0AEZJPxapYn9NTVU7SPOig==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

'message' is an optional pointer to an immutable null- terminated C
string describing the reason for the online check failure.

In the following instances, GWeb (which WISPr utilizes to make an
online reachability check request) can fail before initiating or while
processing a web request:

  1. TCP connection timeout to the remote server peer.
  2. Decoding a chunked response.
  3. Non-successful events (that is, G_IO_NVAL, G_IO_ERR, or G_IO_HUP)
     from 'g_io_add_watch'.
  4. GResolve "host not found" DNS forward resolution failure.
  5. Transport creation failure from 'create_transport'.
  6. Unexpected remote peer disconnect after connect but before data
     transfer.

When an online check request fails, 'online_check_log_failure' in
src/service.c logs the failure in the form:

  "Interface <interface> [ <technology> ] IPv[46] online check to
   <online check URL> failed: <message>"

where <message> is the contents of this newly-added callback
parameter. This avoids 'online_check_log_failure' having to invoke
'strerror' as the message has already been pre-created and -formatted
by the error source. So, for the failures above, the messages would
be:

  1. "connect timeout to <IP address> after <timeout in
     milliseconds>ms".
  2. "Error in chunk decode <error>".
  3. "I/O error".
  4. "could not resolve <host name>".
  5. Output from 'strerror'.
  6. "Connection reset by peer".
---
 src/connman.h |  3 ++-
 src/service.c | 61 +++++++++++++++++++++++++++++++++++----------------
 src/wispr.c   |  4 ++--
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 32ba55912ad6..7ebda7af3a55 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -550,7 +550,8 @@ void __connman_wpad_stop(struct connman_service *service);
 typedef void (*__connman_wispr_cb_t) (struct connman_service *service,
 				enum connman_ipconfig_type type,
 				bool success,
-				int err);
+				int err,
+				const char *message);
 
 int __connman_wispr_init(void);
 void __connman_wispr_cleanup(void);
diff --git a/src/service.c b/src/service.c
index c44335d9c962..f73f42eba9b0 100644
--- a/src/service.c
+++ b/src/service.c
@@ -240,7 +240,8 @@ static void service_list_sort(const char *function);
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success,
-					int err);
+					int err,
+					const char *message);
 static bool service_downgrade_online_state(struct connman_service *service);
 static bool connman_service_is_default(const struct connman_service *service);
 static int start_online_check_if_connected(struct connman_service *service);
@@ -3451,27 +3452,27 @@ static bool handle_online_check_success(struct connman_service *service,
  *                       check failure.
  *  @param[in]  type     The IP configuration type for which
  *                       the online check failed.
- *  @param[in]  err      The error status, in the POSIX domain,
- *                       associated with the online check failure.
+ *  @param[in]  message  A pointer to an immutable null-terminated
+ *                       C string describing the reason for the online
+ *                       check failure.
  *
  */
 static void online_check_log_failure(const struct connman_service *service,
 			enum connman_ipconfig_type type,
-			int err)
+			const char *message)
 {
 	g_autofree char *interface = NULL;
 
 	interface = connman_service_get_interface(service);
 
-	connman_warn("Interface %s [ %s ] %s online check to %s failed: %d: %s",
+	connman_warn("Interface %s [ %s ] %s online check to %s failed: %s",
 		interface,
 		__connman_service_type2string(service->type),
 		__connman_ipconfig_type2string(type),
 		type == CONNMAN_IPCONFIG_TYPE_IPV4 ?
 			connman_setting_get_string("OnlineCheckIPv4URL") :
 			connman_setting_get_string("OnlineCheckIPv6URL"),
-		err,
-		strerror(-err));
+			message);
 }
 
 /**
@@ -3507,6 +3508,10 @@ static void online_check_log_failure(const struct connman_service *service,
  *                                      the failed previously-requested
  *                                      online check. This is expected
  *                                      to be less than zero ('< 0').
+ *  @param[in]      message             A pointer to an immutable null-
+ *                                      terminated C string describing
+ *                                      the reason for the online
+ *                                      check failure.
  *
  *  @returns
  *    True, unconditionally.
@@ -3520,7 +3525,8 @@ static bool handle_oneshot_online_check_failure(
 			enum connman_ipconfig_type type,
 			enum connman_service_state ipconfig_state,
 			struct online_check_state *online_check_state,
-			int err)
+			int err,
+			const char *message)
 {
 	const bool reschedule = true;
 
@@ -3562,6 +3568,10 @@ static bool handle_oneshot_online_check_failure(
  *                                      the failed previously-requested
  *                                      online check. This is expected
  *                                      to be less than zero ('< 0').
+ *  @param[in]      message             A pointer to an immutable null-
+ *                                      terminated C string describing
+ *                                      the reason for the online
+ *                                      check failure.
  *
  *  @returns
  *    True if another online check should be scheduled; otherwise,
@@ -3576,7 +3586,8 @@ static bool handle_continuous_online_check_failure(
 			enum connman_ipconfig_type type,
 			enum connman_service_state ipconfig_state,
 			struct online_check_state *online_check_state,
-			int err)
+			int err,
+			const char *message)
 {
 	bool reschedule = false;
 
@@ -3699,6 +3710,10 @@ static bool handle_continuous_online_check_failure(
  *                                      the failed previously-requested
  *                                      online check. This is expected
  *                                      to be less than zero ('< 0').
+ *  @param[in]      message             A pointer to an immutable null-
+ *                                      terminated C string describing
+ *                                      the reason for the online
+ *                                      check failure.
  *
  *  @returns
  *    True if another online check should be scheduled; otherwise,
@@ -3714,17 +3729,18 @@ static bool handle_online_check_failure(struct connman_service *service,
 				enum connman_service_state ipconfig_state,
 				struct online_check_state *online_check_state,
 				bool oneshot,
-				int err)
+				int err,
+				const char *message)
 {
 	bool reschedule = false;
 
 	DBG("service %p (%s) type %d (%s) state %d (%s) "
-		"one-shot %u err %d (%s)\n",
+		"one-shot %u err %d message %s\n",
 		service,
 		connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type),
 		ipconfig_state, state2string(ipconfig_state),
-		oneshot, err, strerror(-err));
+		oneshot, err, message ? message : "<null>");
 
 	/*
 	 * Regardless of online check mode, if this completion closure
@@ -3740,7 +3756,7 @@ static bool handle_online_check_failure(struct connman_service *service,
 
 	/* Unconditionally log the failure, regardless of online check mode. */
 
-	online_check_log_failure(service, type, err);
+	online_check_log_failure(service, type, message);
 
 	/* Handle the failure according to the online check mode. */
 
@@ -3750,14 +3766,16 @@ static bool handle_online_check_failure(struct connman_service *service,
 						type,
 						ipconfig_state,
 						online_check_state,
-						err);
+						err,
+						message);
 	else
 		reschedule = handle_continuous_online_check_failure(
 						service,
 						type,
 						ipconfig_state,
 						online_check_state,
-						err);
+						err,
+						message);
 
 done:
 	return reschedule;
@@ -3803,6 +3821,9 @@ done:
  *                           to be zero ('0') if @a success is @a true
  *                           and less than zero ('< 0') if @a success
  *                           is @a false.
+ *  @param[in]      message  An optional pointer to an immutable null-
+ *                           terminated C string describing the reason
+ *                           for the online check failure.
  *
  *  @sa cancel_online_check
  *  @sa start_online_check
@@ -3816,7 +3837,8 @@ done:
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success,
-					int err)
+					int err,
+					const char *message)
 {
 	const bool oneshot = __connman_service_is_online_check_mode(
 		CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT);
@@ -3825,11 +3847,11 @@ static void complete_online_check(struct connman_service *service,
 	bool reschedule = false;
 
 	DBG("service %p (%s) type %d (%s) "
-		"success %u err %d (%s)\n",
+		"success %u err %d message %s\n",
 		service,
 		connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type),
-		success, err, strerror(-err));
+		success, err, message ? message : "<null>");
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		online_check_state = &service->online_check_state_ipv4;
@@ -3851,7 +3873,8 @@ static void complete_online_check(struct connman_service *service,
 					 ipconfig_state,
 					 online_check_state,
 					 oneshot,
-					 err);
+					 err,
+					 message);
 
 	DBG("reschedule online check %u", reschedule);
 
diff --git a/src/wispr.c b/src/wispr.c
index 913c3135fffb..189961936d3b 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -672,7 +672,7 @@ static void portal_manage_failure_status(
 	struct connman_service *service = wp_context->service;
 	enum connman_ipconfig_type type = wp_context->type;
 
-	wp_context->cb(service, type, false, err);
+	wp_context->cb(service, type, false, err, message);
 }
 
 /**
@@ -724,7 +724,7 @@ static void portal_manage_success_status(GWebResult *result,
 				&str))
 		connman_info("Client-Timezone: %s", str);
 
-	wp_context->cb(service, type, true, 0);
+	wp_context->cb(service, type, true, 0, NULL);
 }
 
 static bool wispr_route_request(const char *address, int ai_family,
-- 
2.45.0

