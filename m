Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF773214
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 13:59:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C7F75DF77;
	Sun, 28 Aug 2022 15:53:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661694804; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=jVpx6X4DIGAS3EMQWEOATybSi7bnDQCb1EmL9TpxTsA=;
	b=poB2LrkWF8eqxfALzIAs2ti2mDYFMES/npTzeh64RjD9LKmdGM9TUu1yX72nqtpBW4gk91
	kSyKYG6HuY4K1kc8Qeh52AEPL5EHh8T8SIFR5HlD3lvm0hlf0faJJjcNtuKGLpFvkhK6b/
	dhFslA/C8xU8Z7b38PIx5hwr3AautG1EjiiclHiPpKs1iVIfiAauNFgeWoTzFrCLn0yu30
	8SDQEWyRNOKV3E7fxXvYX3A970JoMui/vQoro6eKA/G9oO5K5AzgdsCsx3z6W1ey90OyfV
	z0ML4ELkPUf8PAAvGsi831X17XB3zB1nYt1TjZ0OL1Zho+dqhYm7rGyjA3otQQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] wisrp: Handle wispr_portal_detect failures
Date: Sun, 28 Aug 2022 15:53:22 +0200
Message-Id: <20220828135322.21582-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

__connman_wispr_start() should handle any errors reported by
wispr_portal_detect.

While at it also return early if the service type is not supported.
---
 src/wispr.c | 56 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 84bed33f217d..9b27af5fff55 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -916,7 +916,6 @@ static gboolean no_proxy_callback(gpointer user_data)
 static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context)
 {
 	enum connman_service_proxy_method proxy_method;
-	enum connman_service_type service_type;
 	char *interface = NULL;
 	char **nameservers = NULL;
 	int if_index;
@@ -926,23 +925,6 @@ static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context)
 	DBG("wispr/portal context %p service %p", wp_context,
 		wp_context->service);
 
-	service_type = connman_service_get_type(wp_context->service);
-
-	switch (service_type) {
-	case CONNMAN_SERVICE_TYPE_ETHERNET:
-	case CONNMAN_SERVICE_TYPE_WIFI:
-	case CONNMAN_SERVICE_TYPE_BLUETOOTH:
-	case CONNMAN_SERVICE_TYPE_CELLULAR:
-	case CONNMAN_SERVICE_TYPE_GADGET:
-		break;
-	case CONNMAN_SERVICE_TYPE_UNKNOWN:
-	case CONNMAN_SERVICE_TYPE_SYSTEM:
-	case CONNMAN_SERVICE_TYPE_GPS:
-	case CONNMAN_SERVICE_TYPE_VPN:
-	case CONNMAN_SERVICE_TYPE_P2P:
-		return -EOPNOTSUPP;
-	}
-
 	interface = connman_service_get_interface(wp_context->service);
 	if (!interface)
 		return -EINVAL;
@@ -1012,13 +994,28 @@ int __connman_wispr_start(struct connman_service *service,
 {
 	struct connman_wispr_portal_context *wp_context = NULL;
 	struct connman_wispr_portal *wispr_portal = NULL;
-	int index;
+	int index, err;
 
 	DBG("service %p", service);
 
 	if (!wispr_portal_hash)
 		return -EINVAL;
 
+	switch (connman_service_get_type(service)) {
+	case CONNMAN_SERVICE_TYPE_ETHERNET:
+	case CONNMAN_SERVICE_TYPE_WIFI:
+	case CONNMAN_SERVICE_TYPE_BLUETOOTH:
+	case CONNMAN_SERVICE_TYPE_CELLULAR:
+	case CONNMAN_SERVICE_TYPE_GADGET:
+		break;
+	case CONNMAN_SERVICE_TYPE_UNKNOWN:
+	case CONNMAN_SERVICE_TYPE_SYSTEM:
+	case CONNMAN_SERVICE_TYPE_GPS:
+	case CONNMAN_SERVICE_TYPE_VPN:
+	case CONNMAN_SERVICE_TYPE_P2P:
+		return -EOPNOTSUPP;
+	}
+
 	index = __connman_service_get_index(service);
 	if (index < 0)
 		return -EINVAL;
@@ -1038,16 +1035,20 @@ int __connman_wispr_start(struct connman_service *service,
 		wp_context = wispr_portal->ipv4_context;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
 		wp_context = wispr_portal->ipv6_context;
-	else
-		return -EINVAL;
+	else {
+		err = -EINVAL;
+		goto free_wp;
+	}
 
 	/* If there is already an existing context, we wipe it */
 	if (wp_context)
 		wispr_portal_context_unref(wp_context);
 
 	wp_context = create_wispr_portal_context();
-	if (!wp_context)
-		return -ENOMEM;
+	if (!wp_context) {
+		err = -ENOMEM;
+		goto free_wp;
+	}
 
 	wp_context->service = service;
 	wp_context->type = type;
@@ -1058,7 +1059,14 @@ int __connman_wispr_start(struct connman_service *service,
 	else
 		wispr_portal->ipv6_context = wp_context;
 
-	return wispr_portal_detect(wp_context);
+	err = wispr_portal_detect(wp_context);
+	if (err)
+		goto free_wp;
+	return 0;
+
+free_wp:
+	g_hash_table_remove(wispr_portal_hash, GINT_TO_POINTER(index));
+	return err;
 }
 
 void __connman_wispr_stop(struct connman_service *service)
-- 
2.37.2

