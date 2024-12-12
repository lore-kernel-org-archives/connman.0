Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25F17CA0B
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981311; cv=none; b=I1na1YqSTcH8kX0xS48Qxv3uHP35WPruRp2H7K2en72JNwJJcNSWCBK7TnAtMISvS1pCW7xg5L5L6pURe9Su45Z+Cg78F0vbitV5Vz//HytSZW8azsggFLx0B7AfpeeJ5M2VfvUW1vVFJcOwk1hYQfGdlBZyohR+6zHuC+p/IX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981311; c=relaxed/simple;
	bh=s+tqkvhhevWvS6C2o+LDJdgd/NBdu8s+G7234EczUwY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4BflSiT2WeERWiBxvonETA+eKTPukTlJNd9fzsjbAAiARl0BJCwEXNIPUvfasyPAcjsqKNz3FndLMeeWIRF8xMqNYzp9h3kuyvH9r2bUVukCnCOYQCJ12d1fjaLSroUVe48GrXbgAu/u9vA4gQ5CzOGrkHDkFVpjuqZvhickT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=W114CcJd; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="W114CcJd"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 42720164A6D
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:25 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id ED088124EDB
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 14/15] wispr: Leverage 'wispr_log_proxy_failure'.
Date: Wed, 11 Dec 2024 21:28:16 -0800
Message-ID: <20241212052817.2021264-15-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241212052817.2021264-1-gerickson@nuovations.com>
References: <20241212052817.2021264-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=a4vlkeonnzeLiFK08Pm2690IlI3UtTy1CuteZv3oQXo=; b=W114CcJdRbUm3yDHtW99tW9Fm6Pf9kssnKJRXVctptOwBbS+Bhxvtl+f2LoDUPc7wWB3wvOe7yP2vJVO6q3sAwOHOk4fhnbxIzQ728whULBepWBn1peVrOnRl/TxBYHpzT3iQfqucwINuUGyIz6BBGyFf17NVWYlQ+KKsPleQOVSl7ccUCGhaVK9rxzwOv9dnXMzYNUFNfN1k/26QbumxeTSp8Z+eIgZvFgv+mw252+i1ujVsi0JLEJ3RXttPV+OsDr/3V3CKuGMhePKWY95EFZ2X+0Pnrfd4iGu0o2+VaKNHVR44tTmpnLla/CFRA5IhIVQR2Z0RbAmI/iH9Vpgcg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Leverage 'wispr_log_proxy_failure' from 'proxy_callback' with the "No
valid proxy" reason and from 'wispr_portal_detect' with the "Failed to
lookup" reason on Wireless Internet Service Provider roaming (WISPr)
online reachability check proxy failures.
---
 src/wispr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index 60a3a011da58..10990c725986 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1147,7 +1147,7 @@ static void proxy_callback(const char *proxy, void *user_data)
 		return;
 
 	if (!proxy) {
-		DBG("no valid proxy");
+		wispr_log_proxy_failure(wp_context, "No valid proxy");
 
 		wp_context->cb(wp_context->service,
 				wp_context->type,
@@ -1320,6 +1320,8 @@ static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context,
 						proxy_callback, wp_context);
 
 		if (wp_context->proxy_token == 0) {
+			wispr_log_proxy_failure(wp_context, "Failed to lookup");
+
 			err = -EINVAL;
 			wispr_portal_context_unref(wp_context);
 		}
-- 
2.45.0

