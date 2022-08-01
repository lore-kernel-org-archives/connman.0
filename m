Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2317E2
	for <connman@lists.linux.dev>; Mon,  1 Aug 2022 08:07:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1ED885DF30;
	Mon,  1 Aug 2022 10:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1659340848; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yfpyb9bej6U4GVGjtyKOvgxBfPQFG5vDeWswEuyty7A=;
	b=Bv6se2rnjfZVJS6Hn+hdY6i98spxgp5UKoaJa6bh1GZ1dgHW8KXFFmnedRBXAHyh0lUkYD
	dPGlRaLWUUHSd+1ispdn5LPWOnjSdukn635eQ3dofmN1HOosNeD6RilAPfIMEw18L4sI4i
	iboTO6/y4ElKRwJgGcNUY/2xQiU9RDouIa5FswHbsy7QRXrKs8cZeEAW+aD6YrAA/579z4
	p7H1Wu8bJyy89SPWG7++DuJvv+ze10UA0qfi+sNBcIkRCLLxqLmoBJp0QkngJc0bjiHezS
	F4fKqL2QjvwjsyJzi6/iTuRuUhZj9qr6LgblMKORd5W54bajXfl56OHQCCxBjQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 4/6] wispr: Update portal context references
Date: Mon,  1 Aug 2022 10:00:41 +0200
Message-Id: <20220801080043.4861-4-wagi@monom.org>
In-Reply-To: <20220801080043.4861-1-wagi@monom.org>
References: <20220801080043.4861-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Maintain proper portal context references to avoid UAF.

Fixes: CVE-2022-32293
---
 src/wispr.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index bde7e63ba4b2..84bed33f217d 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -105,8 +105,6 @@ static bool enable_online_to_ready_transition = false;
 
 static void connman_wispr_message_init(struct connman_wispr_message *msg)
 {
-	DBG("");
-
 	msg->has_error = false;
 	msg->current_element = NULL;
 
@@ -166,8 +164,6 @@ static void free_wispr_routes(struct connman_wispr_portal_context *wp_context)
 static void free_connman_wispr_portal_context(
 		struct connman_wispr_portal_context *wp_context)
 {
-	DBG("context %p", wp_context);
-
 	if (wp_context->wispr_portal) {
 		if (wp_context->wispr_portal->ipv4_context == wp_context)
 			wp_context->wispr_portal->ipv4_context = NULL;
@@ -483,9 +479,6 @@ static void portal_manage_status(GWebResult *result,
 				&str))
 		connman_info("Client-Timezone: %s", str);
 
-	if (!enable_online_to_ready_transition)
-		wispr_portal_context_unref(wp_context);
-
 	__connman_service_ipconfig_indicate_state(service,
 					CONNMAN_SERVICE_STATE_ONLINE, type);
 
@@ -546,14 +539,17 @@ static void wispr_portal_request_portal(
 {
 	DBG("");
 
+	wispr_portal_context_ref(wp_context);
 	wp_context->request_id = g_web_request_get(wp_context->web,
 					wp_context->status_url,
 					wispr_portal_web_result,
 					wispr_route_request,
 					wp_context);
 
-	if (wp_context->request_id == 0)
+	if (wp_context->request_id == 0) {
 		wispr_portal_error(wp_context);
+		wispr_portal_context_unref(wp_context);
+	}
 }
 
 static bool wispr_input(const guint8 **data, gsize *length,
@@ -618,13 +614,15 @@ static void wispr_portal_browser_reply_cb(struct connman_service *service,
 		return;
 
 	if (!authentication_done) {
-		wispr_portal_error(wp_context);
 		free_wispr_routes(wp_context);
+		wispr_portal_error(wp_context);
+		wispr_portal_context_unref(wp_context);
 		return;
 	}
 
 	/* Restarting the test */
 	__connman_service_wispr_start(service, wp_context->type);
+	wispr_portal_context_unref(wp_context);
 }
 
 static void wispr_portal_request_wispr_login(struct connman_service *service,
@@ -700,11 +698,13 @@ static bool wispr_manage_message(GWebResult *result,
 
 		wp_context->wispr_result = CONNMAN_WISPR_RESULT_LOGIN;
 
+		wispr_portal_context_ref(wp_context);
 		if (__connman_agent_request_login_input(wp_context->service,
 					wispr_portal_request_wispr_login,
-					wp_context) != -EINPROGRESS)
+					wp_context) != -EINPROGRESS) {
 			wispr_portal_error(wp_context);
-		else
+			wispr_portal_context_unref(wp_context);
+		} else
 			return true;
 
 		break;
@@ -753,6 +753,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 		if (length > 0) {
 			g_web_parser_feed_data(wp_context->wispr_parser,
 								chunk, length);
+			wispr_portal_context_unref(wp_context);
 			return true;
 		}
 
@@ -770,6 +771,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 
 	switch (status) {
 	case 000:
+		wispr_portal_context_ref(wp_context);
 		__connman_agent_request_browser(wp_context->service,
 				wispr_portal_browser_reply_cb,
 				wp_context->status_url, wp_context);
@@ -781,11 +783,14 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 		if (g_web_result_get_header(result, "X-ConnMan-Status",
 						&str)) {
 			portal_manage_status(result, wp_context);
+			wispr_portal_context_unref(wp_context);
 			return false;
-		} else
+		} else {
+			wispr_portal_context_ref(wp_context);
 			__connman_agent_request_browser(wp_context->service,
 					wispr_portal_browser_reply_cb,
 					wp_context->redirect_url, wp_context);
+		}
 
 		break;
 	case 300:
@@ -798,6 +803,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 			!g_web_result_get_header(result, "Location",
 							&redirect)) {
 
+			wispr_portal_context_ref(wp_context);
 			__connman_agent_request_browser(wp_context->service,
 					wispr_portal_browser_reply_cb,
 					wp_context->status_url, wp_context);
@@ -808,6 +814,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 
 		wp_context->redirect_url = g_strdup(redirect);
 
+		wispr_portal_context_ref(wp_context);
 		wp_context->request_id = g_web_request_get(wp_context->web,
 				redirect, wispr_portal_web_result,
 				wispr_route_request, wp_context);
@@ -820,6 +827,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 
 		break;
 	case 505:
+		wispr_portal_context_ref(wp_context);
 		__connman_agent_request_browser(wp_context->service,
 				wispr_portal_browser_reply_cb,
 				wp_context->status_url, wp_context);
@@ -832,6 +840,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 	wp_context->request_id = 0;
 done:
 	wp_context->wispr_msg.message_type = -1;
+	wispr_portal_context_unref(wp_context);
 	return false;
 }
 
@@ -890,6 +899,7 @@ static void proxy_callback(const char *proxy, void *user_data)
 					xml_wispr_parser_callback, wp_context);
 
 	wispr_portal_request_portal(wp_context);
+	wispr_portal_context_unref(wp_context);
 }
 
 static gboolean no_proxy_callback(gpointer user_data)
-- 
2.37.1

