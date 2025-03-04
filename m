Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B401C84DB
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059595; cv=none; b=ei3OfAtnAwm6QhedE/jH7eyY/1cEhDWbalNKIg5u0ZwuYXPZMevMiY7W/4AI+qeKTYVB6aWl6hnlboEKBLepDjDeEffBDgGiOOpDtMaw3imROJNVpPtxXGrmwwCxXknsOkcaOFKNyaQVTxlHxv5nPR+ZBo/5MVNL4NWCW5xhi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059595; c=relaxed/simple;
	bh=a2vYA0DwWfWhMSO0qIKXExy9Q4e8EnaKACKm0aLPgRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gstc/lmszABldUB9F3ak14cJV8Np3cpK5+5wl+Dl3T0eVrDWoihc3tBmLUzWwbj0vxAYiiQ43DzGDQnyZxqHqpRuylDXYoZcZCylGusTQvQyc9oiL4bpOUMggBF+0Q4ZbhyIGGGFqrKLFuisA9RRa1/EtfCA9ucOZ9IEg8b+/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=S49kfyaW; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="S49kfyaW"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1FB35164B40
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:53 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C9AEE1262C4
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 15/22] wispr: Add and leverage 'portal_manage_failure_status'.
Date: Mon,  3 Mar 2025 19:39:37 -0800
Message-ID: <4eb202c9799b338c737cb536c816eb4717fd984e.1741059516.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1741059516.git.gerickson@nuovations.com>
References: <cover.1741059516.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=dhZsM9+IQZheZCuuGM5y51FumH1m01pXtFKzMStaNWM=; b=S49kfyaWzaRiKF1fpPp8mjFQEJyGywieZdz13ct4zqEn4OnbT9it4jtQHGsfL4pcmT3w2H62VlUqpHzANeNXeDAcIrbBNz3pobeM7AU0Key7DJ0w21bltZbVsetAtKZKmOy/FPaiBxEW6GamoMzIRsG+9GjzVVAH5Lu/zJcGhnNqVntesuoXkf47b4x01kYkl4M4zHvem6ji6lYaGUUgczf3KHB9TO0OTv2XYVqU95GXS74WgYTWtCU9Ri0tNKT5E8Sjp4OaohvGUZcqHPhaS40uKfT5m1cTQZoVlNzrwX0dkYj7hP2L+LMqU3+QZPV4Ip3pTDoJrgiW4gUkiGODeA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Consolidates seven common call site patterns into a common function,
reducing the parameters passed at each call site from four to two.
---
 src/wispr.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 9b0e4b24a3db..fc49778fa607 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -633,6 +633,16 @@ static void wispr_portal_error(struct connman_wispr_portal_context *wp_context)
 	wp_context->wispr_result = CONNMAN_WISPR_RESULT_FAILED;
 }
 
+static void portal_manage_failure_status(
+			struct connman_wispr_portal_context *wp_context,
+			int err)
+{
+	struct connman_service *service = wp_context->service;
+	enum connman_ipconfig_type type = wp_context->type;
+
+	wp_context->cb(service, type, false, err);
+}
+
 /**
  *  @brief
  *    Handle a successful "online" HTTP-based Internet reachability
@@ -773,10 +783,7 @@ static void wispr_portal_request_portal(
 					wp_context, &err);
 
 	if (wp_context->request_id == 0) {
-		wp_context->cb(wp_context->service,
-						wp_context->type,
-						false,
-						err);
+		portal_manage_failure_status(wp_context, err);
 		wispr_portal_error(wp_context);
 		wispr_portal_context_unref(wp_context);
 	}
@@ -1049,24 +1056,15 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 
 		goto done;
 	case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
-		wp_context->cb(wp_context->service,
-				wp_context->type,
-				false,
-				-EINVAL);
+		portal_manage_failure_status(wp_context, -EINVAL);
 		break;
 
 	case GWEB_HTTP_STATUS_CODE_NOT_FOUND:
-		wp_context->cb(wp_context->service,
-				wp_context->type,
-				false,
-				-ENOENT);
+		portal_manage_failure_status(wp_context, -ENOENT);
 		break;
 
 	case GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT:
-		wp_context->cb(wp_context->service,
-				wp_context->type,
-				false,
-				-ETIMEDOUT);
+		portal_manage_failure_status(wp_context, -ETIMEDOUT);
 		break;
 
 	case GWEB_HTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED:
@@ -1169,10 +1167,7 @@ static void proxy_callback(const char *proxy, void *user_data)
 	if (!proxy) {
 		wispr_log_proxy_failure(wp_context, "No valid proxy");
 
-		wp_context->cb(wp_context->service,
-				wp_context->type,
-				false,
-				-EINVAL);
+		portal_manage_failure_status(wp_context, -EINVAL);
 
 		return;
 	}
@@ -1519,7 +1514,7 @@ int __connman_wispr_start(struct connman_service *service,
 free_wp:
 	DBG("err %d wp_context %p", err, wp_context);
 
-	wp_context->cb(wp_context->service, wp_context->type, false, err);
+	portal_manage_failure_status(wp_context, err);
 
 	g_hash_table_remove(wispr_portal_hash, GINT_TO_POINTER(index));
 	return err;
@@ -1605,10 +1600,7 @@ int __connman_wispr_cancel(struct connman_service *service,
 
 	cancel_connman_wispr_portal_context(wp_context);
 
-	wp_context->cb(wp_context->service,
-			wp_context->type,
-			false,
-			-ECANCELED);
+	portal_manage_failure_status(wp_context, -ECANCELED);
 
 	wispr_portal_context_unref(wp_context);
 
-- 
2.45.0

