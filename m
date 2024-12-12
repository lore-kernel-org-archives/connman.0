Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AB17AE1C
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981308; cv=none; b=ZzvmOhGoX3XPnNLlGX8/2Pjn6iOx72X1bBL9KzxqCSJWfUSOzjSDUkyifnhJC1mf84oinCqHpnj0sxDvyQoxh3q4QlPx7gHRCUBq7nBjgupx6h6ZcVXSHVK10Z7svtOGD3s0ED90wEXlqkH1cDnRzPnHxFLtxxzWVERNt4Xmlow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981308; c=relaxed/simple;
	bh=57gUCku/I2vxPDcqPB+tkAZerP/lYQk5jOQAQyv5Rb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMvKHMlhlz+P7Sb8mf54tupYRxbCZ6o0bxpUX/NQR2XiGg5ZkkT22go7Ij53Ms89z5qwnSouNgclehdpG8NUWP8lgl5KxhJJ5IKAMRFH2bLa31GYdgMZxmU3mDsl+Fw1sOu+t/crXFEKVpQDcenQTl36oKPzMo/r8WVvyCiBlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=RhMwjYpU; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="RhMwjYpU"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 9864F164A4C
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:21 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 4CF64125164
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/15] service: Document 'service_set_pac'.
Date: Wed, 11 Dec 2024 21:28:08 -0800
Message-ID: <20241212052817.2021264-7-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=oIYv6aOm5waad1uh46Oa3qRiL7Tnh7VvBczHijDerzc=; b=RhMwjYpUeuiG5ClPAb6GfSnp2gjbPowdcbyMx/euM4nhEhJwtf8GC4htIifjbjdSTZjUvC29WKwvw+pj5roSFDbIZfDv3w9yiUsRKH0ZgjXbCV5rbEHMHoZxTypbwbVEfjkaJbVBbunMvEXeEmolWKn57d+2gWNZXihQTYpi6emjbGlUt99D40e/t6t1Rcc0mDi5UTDAOTGZf7sQVkZUGqASkbxeXJyWn60s5bdM+csFxtbgyLq+Agyi2muaWI9bBDZl7vHimipaIC34J8/0flZDzMQFfFwijDo1LnOQqhWrp3lAMcDsDN5gYvhTMdGf5uBdXsXth7/glP4GatP5ig==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_set_pac' function.
---
 src/service.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/service.c b/src/service.c
index a4b13be2fd47..0713520d88a1 100644
--- a/src/service.c
+++ b/src/service.c
@@ -584,6 +584,30 @@ static void service_log_pac(const struct connman_service *service,
 				 url ? url : "is not set");
 }
 
+/**
+ *  @brief
+ *    Set and log the proxy auto-configuration (PAC) URL for the
+ *    specified service.
+ *
+ *  If the specified service is a hidden service, no set or log
+ *  actions are taken.
+ *
+ *  @param[in,out]  service    A pointer to the mutable network
+ *                             service for which to set the proxy
+ *                             auto-configuration (PAC) URL.
+ *  @param[in]      url        An pointer to the immutable null-
+ *                             terminated C string containing the proxy
+ *                             auto-configuration (PAC) URL to set.
+ *  @param[in]      dochanged  A Boolean indicating whether or a D-Bus
+ *                             change notification should be sent for
+ *                             the service "Proxy" property.
+ *
+ *  @sa proxy_changed
+ *  @sa service_log_pac
+ *
+ *  @private
+ *
+ */
 static void service_set_pac(struct connman_service *service,
 				const char *pac,
 				bool dochanged)
-- 
2.45.0

