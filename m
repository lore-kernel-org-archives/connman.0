Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EFECE
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 261D87321D
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:05 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D2C267322A
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:04 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/17] wispr: Add and leverage an OS error parameter to '__connman_wispr_cb_t'.
Date: Wed, 15 Nov 2023 17:02:51 -0800
Message-ID: <20231116010259.628527-11-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116010259.628527-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds and leverages an operating system error parameter to
'__connman_wispr_cb_t' such that such callbacks can leverage the
error status when 'success' is false to either log the status or
take conditional action.
---
 src/connman.h |  3 ++-
 src/service.c | 15 +++++++++++----
 src/wispr.c   | 37 ++++++++++++++++++++++++++++++-------
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 143a087701d8..d5aa6f5599e7 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -525,7 +525,8 @@ void __connman_wpad_stop(struct connman_service *service);
 
 typedef void (*__connman_wispr_cb_t) (struct connman_service *service,
 				enum connman_ipconfig_type type,
-				bool success);
+				bool success,
+				int err);
 
 int __connman_wispr_init(void);
 void __connman_wispr_cleanup(void);
diff --git a/src/service.c b/src/service.c
index 5fb53c2084f9..0882cd167699 100644
--- a/src/service.c
+++ b/src/service.c
@@ -163,7 +163,8 @@ static void vpn_auto_connect(void);
 static void trigger_autoconnect(struct connman_service *service);
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
-					bool success);
+					bool success,
+					int err);
 static bool service_downgrade_online_state(struct connman_service *service);
 
 struct find_data {
@@ -1902,6 +1903,11 @@ static void reschedule_online_check(struct connman_service *service,
  *                           check.
  *  @param[in]      success  A Boolean indicating whether the previously-
  *                           requested online check was successful.
+ *  @param[in]      err      The error status associated with previously-
+ *                           requested online check. This is expected
+ *                           to be zero ('0') if @a success is @a true
+ *                           and less than zero ('< 0') if @a success
+ *                           is @a false.
  *
  *  @sa cancel_online_check
  *  @sa start_online_check
@@ -1911,16 +1917,17 @@ static void reschedule_online_check(struct connman_service *service,
  */
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
-					bool success)
+					bool success,
+					int err)
 {
 	unsigned int *interval;
 	guint *timeout;
 
-	DBG("service %p (%s) type %d (%s) success %d\n",
+	DBG("service %p (%s) type %d (%s) success %d err %d (%s)\n",
 		service,
 		connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type),
-		success);
+		success, err, strerror(-err));
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		interval = &service->online_check_interval_ipv4;
diff --git a/src/wispr.c b/src/wispr.c
index 4b4c9c1e59ec..9d471628e705 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -564,7 +564,7 @@ static void portal_manage_success_status(GWebResult *result,
 				&str))
 		connman_info("Client-Timezone: %s", str);
 
-	wp_context->cb(service, type, true);
+	wp_context->cb(service, type, true, 0);
 }
 
 static bool wispr_route_request(const char *address, int ai_family,
@@ -618,6 +618,8 @@ static bool wispr_route_request(const char *address, int ai_family,
 static void wispr_portal_request_portal(
 		struct connman_wispr_portal_context *wp_context)
 {
+	int err = 0;
+
 	DBG("wispr/portal context %p service %p (%s) type %d (%s)",
 		wp_context,
 		wp_context->service,
@@ -634,10 +636,13 @@ static void wispr_portal_request_portal(
 					wp_context->status_url,
 					wispr_portal_web_result,
 					wispr_route_request,
-					wp_context, NULL);
+					wp_context, &err);
 
 	if (wp_context->request_id == 0) {
-		wp_context->cb(wp_context->service, wp_context->type, false);
+		wp_context->cb(wp_context->service,
+						wp_context->type,
+						false,
+						err);
 		wispr_portal_error(wp_context);
 		wispr_portal_context_unref(wp_context);
 	}
@@ -910,11 +915,26 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 
 		goto done;
 	case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
+		wp_context->cb(wp_context->service,
+				wp_context->type,
+				false,
+				-EINVAL);
+		break;
+
 	case GWEB_HTTP_STATUS_CODE_NOT_FOUND:
-	case GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT:
-		wp_context->cb(wp_context->service, wp_context->type, false);
+		wp_context->cb(wp_context->service,
+				wp_context->type,
+				false,
+				-ENOENT);
+		break;
 
+	case GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT:
+		wp_context->cb(wp_context->service,
+				wp_context->type,
+				false,
+				-ETIMEDOUT);
 		break;
+
 	case GWEB_HTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED:
 		wispr_portal_context_ref(wp_context);
 		__connman_agent_request_browser(wp_context->service,
@@ -977,7 +997,10 @@ static void proxy_callback(const char *proxy, void *user_data)
 	if (!proxy) {
 		DBG("no valid proxy");
 
-		wp_context->cb(wp_context->service, wp_context->type, false);
+		wp_context->cb(wp_context->service,
+				wp_context->type,
+				false,
+				-EINVAL);
 
 		return;
 	}
@@ -1311,7 +1334,7 @@ int __connman_wispr_start(struct connman_service *service,
 	return 0;
 
 free_wp:
-	wp_context->cb(wp_context->service, wp_context->type, false);
+	wp_context->cb(wp_context->service, wp_context->type, false, err);
 
 	g_hash_table_remove(wispr_portal_hash, GINT_TO_POINTER(index));
 	return err;
-- 
2.42.0

