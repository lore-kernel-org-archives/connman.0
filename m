Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5EF17E5
	for <connman@lists.linux.dev>; Mon,  1 Aug 2022 08:07:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89DFE5DF1D;
	Mon,  1 Aug 2022 10:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1659340847; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=W8L6+awZQMjViniyaYxPJ3F0YWuYseHOTb0eEOHOU1k=;
	b=sPl9dV4IGxRBfsD0d8leGQdwxfzYA4S+KTEDFRDKjptlG+qidqAIUtfDQZ1Tvpbwo/DEGc
	JRUZxKU2V1I4gTZmtP9F/bS82bCXVbXeZfl0gb5Ln386rOrGkmrwMybxc2Mg7ggt0dBEeu
	W+43OYYs8BDnKKFP/Qa8cDXB4sJMwS0K8eP+PZjs4278hKA+jUKrHcn/xU9goiBuugRL3T
	LZYwwK0NfrlE9hQ/pYFDRp8/dhCchXmli6KZwtJv6I3HsRQW9aOD4fdEDqPEy5nk3uWhYF
	fAkNJMghvKsylN6pL+KoPPtrgHdzZBb+fbVXl/ciPXSIOgo3+1eH425fFu5YAQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 3/6] wispr: Add reference counter to portal context
Date: Mon,  1 Aug 2022 10:00:40 +0200
Message-Id: <20220801080043.4861-3-wagi@monom.org>
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

Track the connman_wispr_portal_context live time via a
refcounter. This only adds the infrastructure to do proper reference
counting.

Fixes: CVE-2022-32293
---
 src/wispr.c | 52 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index a07896cabe48..bde7e63ba4b2 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -56,6 +56,7 @@ struct wispr_route {
 };
 
 struct connman_wispr_portal_context {
+	int refcount;
 	struct connman_service *service;
 	enum connman_ipconfig_type type;
 	struct connman_wispr_portal *wispr_portal;
@@ -97,6 +98,11 @@ static char *online_check_ipv4_url = NULL;
 static char *online_check_ipv6_url = NULL;
 static bool enable_online_to_ready_transition = false;
 
+#define wispr_portal_context_ref(wp_context) \
+	wispr_portal_context_ref_debug(wp_context, __FILE__, __LINE__, __func__)
+#define wispr_portal_context_unref(wp_context) \
+	wispr_portal_context_unref_debug(wp_context, __FILE__, __LINE__, __func__)
+
 static void connman_wispr_message_init(struct connman_wispr_message *msg)
 {
 	DBG("");
@@ -162,9 +168,6 @@ static void free_connman_wispr_portal_context(
 {
 	DBG("context %p", wp_context);
 
-	if (!wp_context)
-		return;
-
 	if (wp_context->wispr_portal) {
 		if (wp_context->wispr_portal->ipv4_context == wp_context)
 			wp_context->wispr_portal->ipv4_context = NULL;
@@ -201,9 +204,38 @@ static void free_connman_wispr_portal_context(
 	g_free(wp_context);
 }
 
+static struct connman_wispr_portal_context *
+wispr_portal_context_ref_debug(struct connman_wispr_portal_context *wp_context,
+			const char *file, int line, const char *caller)
+{
+	DBG("%p ref %d by %s:%d:%s()", wp_context,
+		wp_context->refcount + 1, file, line, caller);
+
+	__sync_fetch_and_add(&wp_context->refcount, 1);
+
+	return wp_context;
+}
+
+static void wispr_portal_context_unref_debug(
+		struct connman_wispr_portal_context *wp_context,
+		const char *file, int line, const char *caller)
+{
+	if (!wp_context)
+		return;
+
+	DBG("%p ref %d by %s:%d:%s()", wp_context,
+		wp_context->refcount - 1, file, line, caller);
+
+	if (__sync_fetch_and_sub(&wp_context->refcount, 1) != 1)
+		return;
+
+	free_connman_wispr_portal_context(wp_context);
+}
+
 static struct connman_wispr_portal_context *create_wispr_portal_context(void)
 {
-	return g_try_new0(struct connman_wispr_portal_context, 1);
+	return wispr_portal_context_ref(
+		g_new0(struct connman_wispr_portal_context, 1));
 }
 
 static void free_connman_wispr_portal(gpointer data)
@@ -215,8 +247,8 @@ static void free_connman_wispr_portal(gpointer data)
 	if (!wispr_portal)
 		return;
 
-	free_connman_wispr_portal_context(wispr_portal->ipv4_context);
-	free_connman_wispr_portal_context(wispr_portal->ipv6_context);
+	wispr_portal_context_unref(wispr_portal->ipv4_context);
+	wispr_portal_context_unref(wispr_portal->ipv6_context);
 
 	g_free(wispr_portal);
 }
@@ -452,7 +484,7 @@ static void portal_manage_status(GWebResult *result,
 		connman_info("Client-Timezone: %s", str);
 
 	if (!enable_online_to_ready_transition)
-		free_connman_wispr_portal_context(wp_context);
+		wispr_portal_context_unref(wp_context);
 
 	__connman_service_ipconfig_indicate_state(service,
 					CONNMAN_SERVICE_STATE_ONLINE, type);
@@ -616,7 +648,7 @@ static void wispr_portal_request_wispr_login(struct connman_service *service,
 				return;
 		}
 
-		free_connman_wispr_portal_context(wp_context);
+		wispr_portal_context_unref(wp_context);
 		return;
 	}
 
@@ -952,7 +984,7 @@ static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context)
 
 		if (wp_context->token == 0) {
 			err = -EINVAL;
-			free_connman_wispr_portal_context(wp_context);
+			wispr_portal_context_unref(wp_context);
 		}
 	} else if (wp_context->timeout == 0) {
 		wp_context->timeout = g_idle_add(no_proxy_callback, wp_context);
@@ -1001,7 +1033,7 @@ int __connman_wispr_start(struct connman_service *service,
 
 	/* If there is already an existing context, we wipe it */
 	if (wp_context)
-		free_connman_wispr_portal_context(wp_context);
+		wispr_portal_context_unref(wp_context);
 
 	wp_context = create_wispr_portal_context();
 	if (!wp_context)
-- 
2.37.1

