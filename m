Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11867E
	for <connman@lists.linux.dev>; Tue,  6 Sep 2022 18:15:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 450425E0EA;
	Tue,  6 Sep 2022 20:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1662488107; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QHIPNPQG4n50acPlcDbXjzRhGlBGSJCD0uSmFWn4h/4=;
	b=p4YglbKI8Ro/68pniPSsTyx9kfQnHOJGvk/fDC8IzhD4iIZT3DSwaVuJDcooXLiSe2WF3g
	Qe75TNxr9uJeT+lialnZJU4fiZgWqtnG9JxAvEW0Qn/G9KtyfEUexT8H6CkWBxU4zAVmB0
	R8cDAj+HohK15DxXd8y1H6x/ZLSoHBhqgXDQ5/zSXfLhj8AMA7cg7QR9VB+2us7SuzCnoM
	VH53e4tbFbRJKxAFH18TPXXm9tV9M/hdhVgCIj3VbtlDhWpBUWU5ZqePH/TK0sz959KRU7
	rkjueVrMG5uMB9Lu9MXMNC7K0ee+G9efeClQN+NBTxk74AGPzh5oLcYK3QfHXw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 2/2] wispr: Fix contex refcounting in wispr_portal_request_portal()
Date: Tue,  6 Sep 2022 20:15:04 +0200
Message-Id: <20220906181504.7539-2-wagi@monom.org>
In-Reply-To: <20220906181504.7539-1-wagi@monom.org>
References: <20220906181504.7539-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The wispr_portal_request_portal() function is expected to read until
there is no data. Hence, the wp_context refcount is supposed to be
hold on while reading.

Furthermore, we should not return early when we read the
X-ConnMan-Status header. Instead we are supposed to go through the
normal return path so that we cleanup any added routing entries. Thus,
we also don't need to update the refcount in this code path as we
handle it at the main return path.

While at it also do some cleanups and unify the connman_ipconfig_type
checking.

Fixes: 416bfaff9888 ("wispr: Update portal context references")
---
 src/wispr.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 9b27af5fff55..a4372018a3e1 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -537,7 +537,8 @@ static bool wispr_route_request(const char *address, int ai_family,
 static void wispr_portal_request_portal(
 		struct connman_wispr_portal_context *wp_context)
 {
-	DBG("");
+	DBG("wp_context %p %s", wp_context,
+		__connman_ipconfig_type2string(wp_context->type));
 
 	wispr_portal_context_ref(wp_context);
 	wp_context->request_id = g_web_request_get(wp_context->web,
@@ -753,7 +754,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 		if (length > 0) {
 			g_web_parser_feed_data(wp_context->wispr_parser,
 								chunk, length);
-			wispr_portal_context_unref(wp_context);
+			/* read more data */
 			return true;
 		}
 
@@ -783,8 +784,6 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 		if (g_web_result_get_header(result, "X-ConnMan-Status",
 						&str)) {
 			portal_manage_status(result, wp_context);
-			wispr_portal_context_unref(wp_context);
-			return false;
 		} else {
 			wispr_portal_context_ref(wp_context);
 			__connman_agent_request_browser(wp_context->service,
@@ -996,7 +995,8 @@ int __connman_wispr_start(struct connman_service *service,
 	struct connman_wispr_portal *wispr_portal = NULL;
 	int index, err;
 
-	DBG("service %p", service);
+	DBG("service %p %s", service,
+		__connman_ipconfig_type2string(type));
 
 	if (!wispr_portal_hash)
 		return -EINVAL;
@@ -1033,12 +1033,8 @@ int __connman_wispr_start(struct connman_service *service,
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		wp_context = wispr_portal->ipv4_context;
-	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+	else
 		wp_context = wispr_portal->ipv6_context;
-	else {
-		err = -EINVAL;
-		goto free_wp;
-	}
 
 	/* If there is already an existing context, we wipe it */
 	if (wp_context)
-- 
2.37.2

