Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369F190679
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927937; cv=none; b=Qu5jTYHmCE+bT0i5wM0N3GLr45ucGlgggpKNyo10X7pUKcx2X1RDUC3sqRHhINMdHkkssGRu6peosYR2BZnQDGCRHqhv6IRnO6vUW9aE9LEu68NjHdSjWF685fBSKHyYDjUo9c5Yd9BgSyO2Z5ROnuNhoCNScc/9qrTyg041pwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927937; c=relaxed/simple;
	bh=BbwZUv+fcXJTN+ntRyHaajCq6Cb2MZbnx77o/NqkRck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lpc+ptWt7HUsQdrKa4uxuJjrnNIk/GDIaMdLD+J+KXJ4SUctp17/3Mc5OeDI2hpeh1yHxXuN3BB8d0i61MOW4Evd6n5OkQWyHRihlVyS5J40v+Oi2bSoL/f1taeSlQPTYKBp8pY/AP+44nypUqUY+07adwcDmGdNzA9woIUuix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=OtoH2cL/; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="OtoH2cL/"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 131571649B9
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 14:38:53 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id ABAC0124FE6
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 14:38:52 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] wispr: Do not pass a negative error status to 'strerror'.
Date: Tue, 25 Mar 2025 11:38:51 -0700
Message-ID: <049cfab18dd9dd33a8bedcc5766f16ffca27b87d.1742927708.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=GxzsbOXC14SldERjTxJCsNVNDWv9Ol8+jnMn/Tjiimg=; b=OtoH2cL/BAV4Qw5+oZWxnb5qL5k6nQCc74dWF8/BlWQL3rYn+ZDo7aHoyGfcSZuJC2bQ04qp2KhfDh61SWemsYST27ZUdJPuFeW+YQ4ri00phQogiJp7nSTg0uagnE0gT90ekecq4t2wqoRDFqJahnPK2UNvpOHZEr1iQ8VaMQBSOnA3HsEPBHtsd0PdakV24LAeZ9lGZH3EFivlmZ9MQ7+g5wbk6LAvPOBho1l/w2nxZbRNPwMDyBeTINUPwRwi9TUC6S01XxLhEvbRvevPV1FXGuL0hpOQZml8s4NkVpi5MYAe19Rs/rvzJYgmCCDcFVWu80Dc3yG86dkXQ9BP0A==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Fixes: 52546061c590 ("wispr: Refactor 'wispr_portal_web_result' to leverage 'GError'.")
---
 src/wispr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index 21657f375473..a40cf353b54e 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1735,7 +1735,7 @@ int __connman_wispr_cancel(struct connman_service *service,
 	cancel_connman_wispr_portal_context(wp_context);
 
 	portal_manage_failure_status(wp_context, -ECANCELED,
-		strerror(-ECANCELED));
+		strerror(ECANCELED));
 
 	wispr_portal_context_unref(wp_context);
 
-- 
2.45.0

