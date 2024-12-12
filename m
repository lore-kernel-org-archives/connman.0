Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291917D366
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981310; cv=none; b=X22tHbQ7n/Bw9n2H40PsJZ/0BjylR9DdQYpvkUurVS/0ANCp4a+1gav4s/pHFTmOv5Y8aXSOtVZxBOjBYMaiNvQZHzJYgzhDztUuX6Owa7EvyrC9a/Phas0qHkyFEbSfT20vBQRIuKF6JUkQHr5bswwEYPch//ZszPcIAm0jV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981310; c=relaxed/simple;
	bh=MhA8GxcFawyataBCTq7owPmn6ubX8NIDsFCGXaYSbrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKf+rcSgLPjw7aupTwgr3bIcWDH7X/pf/0C6HjaLN9dv1H1NP88xxe50PXjfGHv+XRRHQ+pNqs0MDbV60/N8rlriHSxWhcJnXcr+MPDNIq49/BI5KcMT7iPDflyiOMI8Sh7Hyh7QRwRAvMbCvdvC/qDodLR/dyxv6Cf5BEQlR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=GvTPL2If; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="GvTPL2If"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6FD76164A52
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:23 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 24819125164
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/15] service: Document 'service_set_proxy_method'.
Date: Wed, 11 Dec 2024 21:28:12 -0800
Message-ID: <20241212052817.2021264-11-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=DMEVtJxEypbJbdo46QA/JuNoLWGPwQUfFlkxSoG2fnI=; b=GvTPL2IfFPISrghIDp00tTVLo9Ivl01Qy9p3aMN9/bvlisEVRIqm9ycn52tgpIrngUGSwZTqzGGucVXT7xel2g18P9tilLM23AIXojrY0rCIuj4emQMou8qgUif4U6oRwo/C+/NvGoimqhsAAl1Jj3bVeQeTDVqysohZmO1Jv9EwfXlLgWuZFiuBNoKj9zw4s+t1EklADB91UJunkWGOlo3Dr7pflzBfo9bsbx9ipDahW2xx1Klm4iaA2DAP/irLk9X+GsNdT4DeN7BlPmDBBBUHKasfj6y9E6emVX6t/PcPozpBqUM2EzsMjgAlO5ePot6D3diEcV7sEYyHQNmaug==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_set_proxy_method' function.
---
 src/service.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/service.c b/src/service.c
index d2d8e7cea065..3fd56188093d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5568,6 +5568,41 @@ const char * const *connman_service_get_timeservers(const struct connman_service
 	return (const char * const *)service->timeservers;
 }
 
+/**
+ *  @brief
+ *    Set the proxy method for the specified service.
+ *
+ *  This attempts to set the proxy method for the specified
+ *  service. If the service is null or if the service is hidden, no
+ *  action is taken. If specified, a handler will be invoked, with the
+ *  specified context, after setting the proxy method.
+ *
+ *  If the handler is specified and it returns true, following, a
+ *  D-Bus change notification should be sent for the service "Proxy"
+ *  property and, if requested by @a donotifier, the proxy changed
+ *  notifier chain will be run.
+ *
+ *  @param[in,out]  service     A pointer to the mutable network
+ *                              service for which to set the proxy
+ *                              method.
+ *  @param[in]      method      The network service proxy method to set
+ *                              on @a service.
+ *  @param[in]      donotifier  A Boolean indicating whether the proxy
+ *                              changed notifier chain should be run
+ *                              after @a method is set on @a service.
+ *  @param[in]      handler     An optional pointer to a handler that,
+ *                              if specified, will be invoked after @a
+ *                              method is set on @a service.
+ *  @param[in]      context     An optional pointer to immutable context
+ *                              that will be passed to @a handler,
+ *                              along with @a service and @a method.
+ *
+ *  @sa __connman_notifier_proxy_changed
+ *  @sa proxy_changed
+ *
+ *  @private
+ *
+ */
 static void service_set_proxy_method(struct connman_service *service,
 			enum connman_service_proxy_method method,
 			bool donotifier,
-- 
2.45.0

