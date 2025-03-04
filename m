Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338ED78F33
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050689; cv=none; b=OpRm2Tm2u0cTj9a22XUYZ2Yp1XgiN7ykxybyKPdm6+LsCZo+gXNlIusmyNv9mQRNoFE7S89MwTScYLDjPIMzyKU3QJM5yVA8o7DLiNZp7IWc+ck5JhimzVMdkG1+V48NbP8t3DM32U0/ULh7fj9eh2OCcwS4pN47xjMJ7UeA5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050689; c=relaxed/simple;
	bh=a2vYA0DwWfWhMSO0qIKXExy9Q4e8EnaKACKm0aLPgRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch+ZcWbwHrYSfnWyyoFED7rjEThSciNP7dV3oa2+5ebeDfM4+VnhDtwqjOKbCzVhhd2Wdy9pNJadfBw28g4xB5Eo4Wqeu3mUIppBPUViCx8XzN4qGp7vbVAra45Pztxk2uYqSOsQCKzDtEfzPKDHSqOoK2cQK3oV9Inu3uFu6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=A4cT/fVG; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="A4cT/fVG"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 39528164B52
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:22 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E5CEF1260D5
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 15/22] wispr: Add and leverage 'portal_manage_failure_status'.
Date: Mon,  3 Mar 2025 17:11:06 -0800
Message-ID: <4eb202c9799b338c737cb536c816eb4717fd984e.1741050622.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
References: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=dhZsM9+IQZheZCuuGM5y51FumH1m01pXtFKzMStaNWM=; b=A4cT/fVGrkAd/tuf8/AHELQFEFYNDcr/CIhE7yf+Qoxb3BXbTkZcmvC6u7D7bNtKzfhAXBVEQrS35oQBr1qrG7vU9m66A7sR8HzVsKQCPhFLaRwYRRBN0p1c9lOBBpvb3lPwoA15x/TPKXVb5fwrQNjbF2H8zxK3Z8kSgFSlLHrnRLomslgoP7sx94gznLWsPsJ3NqoRKcKNVs7itql9Q9mwRsSTYogTqmMIzt1h+NEBQud/PQGEJ6k7B8AljCBywv+kBVhGVG8HzFON3jHxFclQ3SNTEv9DVLLujWjT94P5RKfUr0RF5sYPJ/pPjDHlUID6YSz9l1WfhnYpgZDIHw==
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

