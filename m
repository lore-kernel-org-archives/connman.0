Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E2138A
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C164273218
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:03 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 79C2C73222
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 07/17] wispr: Add and leverage 'cancel_connman_wispr_portal_context'.
Date: Wed, 15 Nov 2023 17:02:48 -0800
Message-ID: <20231116010259.628527-8-gerickson@nuovations.com>
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

This factors out from 'free_connman_wispr_portal_context', adds, and
leverages as an independent, file-scoped function
'cancel_connman_wispr_portal_context'. It attempts to cancel any
outstanding WISPr request associated with the specified WISPr/portal
context, deallocating any resources associated with the context,
except for the context itself which still requires invoking
'free_connman_wispr_portal_context'.
---
 src/wispr.c | 60 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 7018dbc7d302..84d4b1d0efb4 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -166,9 +166,12 @@ static void free_wispr_routes(struct connman_wispr_portal_context *wp_context)
 	}
 }
 
-static void free_connman_wispr_portal_context(
+static void cancel_connman_wispr_portal_context(
 		struct connman_wispr_portal_context *wp_context)
 {
+	if (!wp_context)
+		return;
+
 	DBG("wispr/portal context %p service %p (%s) type %d (%s)",
 		wp_context,
 		wp_context->service,
@@ -176,38 +179,67 @@ static void free_connman_wispr_portal_context(
 		wp_context->type,
 		__connman_ipconfig_type2string(wp_context->type));
 
-	if (wp_context->wispr_portal) {
-		if (wp_context->wispr_portal->ipv4_context == wp_context)
-			wp_context->wispr_portal->ipv4_context = NULL;
-
-		if (wp_context->wispr_portal->ipv6_context == wp_context)
-			wp_context->wispr_portal->ipv6_context = NULL;
-	}
-
-	if (wp_context->proxy_token > 0)
+	if (wp_context->proxy_token > 0) {
 		connman_proxy_lookup_cancel(wp_context->proxy_token);
+		wp_context->proxy_token = 0;
+	}
 
-	if (wp_context->request_id > 0)
+	if (wp_context->request_id > 0) {
 		g_web_cancel_request(wp_context->web, wp_context->request_id);
+		wp_context->request_id = 0;
+	}
 
-	if (wp_context->proxy_timeout > 0)
+	if (wp_context->proxy_timeout > 0) {
 		g_source_remove(wp_context->proxy_timeout);
+		wp_context->proxy_timeout = 0;
+	}
 
-	if (wp_context->web)
+	if (wp_context->web) {
 		g_web_unref(wp_context->web);
+		wp_context->web = NULL;
+	}
 
 	g_free(wp_context->redirect_url);
+	wp_context->redirect_url = NULL;
 
-	if (wp_context->wispr_parser)
+	if (wp_context->wispr_parser) {
 		g_web_parser_unref(wp_context->wispr_parser);
+		wp_context->wispr_parser = NULL;
+	}
 
 	connman_wispr_message_init(&wp_context->wispr_msg);
 
 	g_free(wp_context->wispr_username);
+	wp_context->wispr_username = NULL;
+
 	g_free(wp_context->wispr_password);
+	wp_context->wispr_password = NULL;
+
 	g_free(wp_context->wispr_formdata);
+	wp_context->wispr_formdata = NULL;
 
 	free_wispr_routes(wp_context);
+}
+
+static void free_connman_wispr_portal_context(
+		struct connman_wispr_portal_context *wp_context)
+{
+	DBG("wispr/portal context %p service %p (%s) type %d (%s)",
+		wp_context,
+		wp_context->service,
+		connman_service_get_identifier(wp_context->service),
+		wp_context->type,
+		__connman_ipconfig_type2string(wp_context->type));
+
+	if (wp_context->wispr_portal) {
+		if (wp_context->wispr_portal->ipv4_context == wp_context)
+			wp_context->wispr_portal->ipv4_context = NULL;
+
+		if (wp_context->wispr_portal->ipv6_context == wp_context)
+			wp_context->wispr_portal->ipv6_context = NULL;
+	}
+
+	cancel_connman_wispr_portal_context(wp_context);
 
 	g_free(wp_context);
 }
-- 
2.42.0

