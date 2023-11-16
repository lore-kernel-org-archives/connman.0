Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF9ECE
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1CAF573207
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:01 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C18DC731BE
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/17] wispr: Rename context proxy-related data members.
Date: Wed, 15 Nov 2023 17:02:42 -0800
Message-ID: <20231116010259.628527-2-gerickson@nuovations.com>
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

This renames the WISPr/portal context structure proxy-related data
members 'token' and 'timeout' as 'proxy_token' and 'proxy_timeout',
respectively, to make it clearer in what context they are used.
---
 src/wispr.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index ab763d5bada0..79cb713449bc 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -64,7 +64,7 @@ struct connman_wispr_portal_context {
 
 	/* Portal/WISPr common */
 	GWeb *web;
-	unsigned int token;
+	unsigned int proxy_token;
 	guint request_id;
 
 	const char *status_url;
@@ -83,7 +83,7 @@ struct connman_wispr_portal_context {
 
 	GSList *route_list;
 
-	guint timeout;
+	guint proxy_timeout;
 };
 
 struct connman_wispr_portal {
@@ -184,14 +184,14 @@ static void free_connman_wispr_portal_context(
 			wp_context->wispr_portal->ipv6_context = NULL;
 	}
 
-	if (wp_context->token > 0)
-		connman_proxy_lookup_cancel(wp_context->token);
+	if (wp_context->proxy_token > 0)
+		connman_proxy_lookup_cancel(wp_context->proxy_token);
 
 	if (wp_context->request_id > 0)
 		g_web_cancel_request(wp_context->web, wp_context->request_id);
 
-	if (wp_context->timeout > 0)
-		g_source_remove(wp_context->timeout);
+	if (wp_context->proxy_timeout > 0)
+		g_source_remove(wp_context->proxy_timeout);
 
 	if (wp_context->web)
 		g_web_unref(wp_context->web);
@@ -934,7 +934,7 @@ static void proxy_callback(const char *proxy, void *user_data)
 
 	DBG("proxy %s", proxy);
 
-	wp_context->token = 0;
+	wp_context->proxy_token = 0;
 
 	proxy_server = parse_proxy(proxy);
 	if (proxy_server) {
@@ -961,7 +961,7 @@ static gboolean no_proxy_callback(gpointer user_data)
 {
 	struct connman_wispr_portal_context *wp_context = user_data;
 
-	wp_context->timeout = 0;
+	wp_context->proxy_timeout = 0;
 
 	proxy_callback("DIRECT", wp_context);
 
@@ -1049,19 +1049,20 @@ static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context,
 			proxy_method != CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN) {
 		wispr_portal_context_ref(wp_context);
 
-		wp_context->token = connman_proxy_lookup(interface,
+		wp_context->proxy_token = connman_proxy_lookup(interface,
 						wp_context->status_url,
 						wp_context->service,
 						proxy_callback, wp_context);
 
-		if (wp_context->token == 0) {
+		if (wp_context->proxy_token == 0) {
 			err = -EINVAL;
 			wispr_portal_context_unref(wp_context);
 		}
-	} else if (wp_context->timeout == 0) {
+	} else if (wp_context->proxy_timeout == 0) {
 		wispr_portal_context_ref(wp_context);
 
-		wp_context->timeout = g_idle_add(no_proxy_callback, wp_context);
+		wp_context->proxy_timeout = g_idle_add(no_proxy_callback,
+						wp_context);
 	}
 
 done:
-- 
2.42.0

