Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6876218AC8
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153424; cv=none; b=k7wlzXkG/KfBNbonNnvBhl5SaB2cn4D//bMTBe4zrw7LATR4WIRsOhgk1s9OI8HJuOdmG+CjzTs76Ko11o2wheDDDTAcTf6UwTVRvGYzN/+2yVBduTthVeDSXMELa2WXcxMLKqxJOY6jfNUplHokDKkciocKhFiEqiUp31ksC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153424; c=relaxed/simple;
	bh=s+tqkvhhevWvS6C2o+LDJdgd/NBdu8s+G7234EczUwY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNJ6yQVnFukqX548p5d4obWBshFbSbymmV0HD1CY0+uApMsrXtWNYPpJaU0zVoYv79icC1I8d7SubzFTFHTYFWAk4+n/eIcNgRbbeDxtOwHp9X4qHreKvbfgRx73b16TpScoGMUZ5I7bIfVMWOMBg14vxWyxSunG+y+GNPoRsSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=bQNjkAAM; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="bQNjkAAM"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A2289164A9C
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:01 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 59A55125174
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 14/15] wispr: Leverage 'wispr_log_proxy_failure'.
Date: Fri, 21 Feb 2025 07:56:52 -0800
Message-ID: <20250221155653.760046-15-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250221155653.760046-1-gerickson@nuovations.com>
References: <20250221155653.760046-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=a4vlkeonnzeLiFK08Pm2690IlI3UtTy1CuteZv3oQXo=; b=bQNjkAAMzfylvX0R4DNmCcfS1Z6lVT2qmvRmb7aqYzi8SbN2rrn66Wur158kqR7quOeLZAxh/dVdAxTSmTmK4e+T4gSEY6EQnfR09QaPG+66I77AvCmX+pOZ3mFY/TO/33KlNgK37QB8J3THSSEFElz41wdJtNpliwRlvydCgYy8TsyzagYXyKrnSP4vAxaLV00vGCJgfJUAO0TOlFDHYXYEJVJg6cvIIcd8lIDL/GWLlHlrDuWQJtd9AcKCgQ6ViNi++/bK5GaA9h3n9ZEYRN/sTX1m+OJT6f3LQh1GtJxTkxOirMwx5i7OMLHPXINYzIwQRArFlSAhVlTDAYQdUg==
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

