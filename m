Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E427F
	for <connman@lists.linux.dev>; Mon,  1 Aug 2022 08:07:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F7085DDF0;
	Mon,  1 Aug 2022 10:00:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1659340845; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fCfCAq4wDGoJigeUoI4OuPwH8xPbRmnET4zQcZrS7Bg=;
	b=eqVcZVkTI/B8C0tJboUcvhFNVz3Kz2oFShEqIZXQUYUWMmncrKtAcVuZN1+hf8hJ43UFNV
	WUlDUchKCWSFDprI1scJf1QxekZlBL90yrxQ0JVO+hi8+Y3Hz5oeeGtO2luUBvCKq7ys5r
	Z+lwW/QmAoVj/0toBnH7c9IT0SoRulGnwg6Ng7Rem4waIgOq+3p0xLSpRlvHaOhuEjo4IR
	KQiObEhIv7eEu3IRgzmtv4VjvczpmKhw7+hFcB/Vmgw2A/JGpAyL7NV8vkTHNjsGSvJgKQ
	0wtbCSqsmBugqquFwITjHGYmzPfimt6mdvxCYukulfJlbjmgrwMosZNOjum8GQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 1/6] wispr: Rename wispr_portal_list to wispr_portal_hash
Date: Mon,  1 Aug 2022 10:00:38 +0200
Message-Id: <20220801080043.4861-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This data structure is a hash table, so replace the '_list' with
'_hash' to reduce the possibility for confusion.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/wispr.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 7d4a3f54b24b..9bd2a2ef1d5f 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -91,7 +91,7 @@ struct connman_wispr_portal {
 
 static bool wispr_portal_web_result(GWebResult *result, gpointer user_data);
 
-static GHashTable *wispr_portal_list = NULL;
+static GHashTable *wispr_portal_hash = NULL;
 
 static char *online_check_ipv4_url = NULL;
 static char *online_check_ipv6_url = NULL;
@@ -576,7 +576,7 @@ static void wispr_portal_browser_reply_cb(struct connman_service *service,
 	if (index < 0)
 		return;
 
-	wispr_portal = g_hash_table_lookup(wispr_portal_list,
+	wispr_portal = g_hash_table_lookup(wispr_portal_hash,
 					GINT_TO_POINTER(index));
 	if (!wispr_portal)
 		return;
@@ -974,21 +974,21 @@ int __connman_wispr_start(struct connman_service *service,
 
 	DBG("service %p", service);
 
-	if (!wispr_portal_list)
+	if (!wispr_portal_hash)
 		return -EINVAL;
 
 	index = __connman_service_get_index(service);
 	if (index < 0)
 		return -EINVAL;
 
-	wispr_portal = g_hash_table_lookup(wispr_portal_list,
+	wispr_portal = g_hash_table_lookup(wispr_portal_hash,
 					GINT_TO_POINTER(index));
 	if (!wispr_portal) {
 		wispr_portal = g_try_new0(struct connman_wispr_portal, 1);
 		if (!wispr_portal)
 			return -ENOMEM;
 
-		g_hash_table_replace(wispr_portal_list,
+		g_hash_table_replace(wispr_portal_hash,
 					GINT_TO_POINTER(index), wispr_portal);
 	}
 
@@ -1026,14 +1026,14 @@ void __connman_wispr_stop(struct connman_service *service)
 
 	DBG("service %p", service);
 
-	if (!wispr_portal_list)
+	if (!wispr_portal_hash)
 		return;
 
 	index = __connman_service_get_index(service);
 	if (index < 0)
 		return;
 
-	wispr_portal = g_hash_table_lookup(wispr_portal_list,
+	wispr_portal = g_hash_table_lookup(wispr_portal_hash,
 					GINT_TO_POINTER(index));
 	if (!wispr_portal)
 		return;
@@ -1042,14 +1042,14 @@ void __connman_wispr_stop(struct connman_service *service)
 	     service == wispr_portal->ipv4_context->service) ||
 	    (wispr_portal->ipv6_context &&
 	     service == wispr_portal->ipv6_context->service))
-		g_hash_table_remove(wispr_portal_list, GINT_TO_POINTER(index));
+		g_hash_table_remove(wispr_portal_hash, GINT_TO_POINTER(index));
 }
 
 int __connman_wispr_init(void)
 {
 	DBG("");
 
-	wispr_portal_list = g_hash_table_new_full(g_direct_hash,
+	wispr_portal_hash = g_hash_table_new_full(g_direct_hash,
 						g_direct_equal, NULL,
 						free_connman_wispr_portal);
 
@@ -1068,6 +1068,6 @@ void __connman_wispr_cleanup(void)
 {
 	DBG("");
 
-	g_hash_table_destroy(wispr_portal_list);
-	wispr_portal_list = NULL;
+	g_hash_table_destroy(wispr_portal_hash);
+	wispr_portal_hash = NULL;
 }
-- 
2.37.1

