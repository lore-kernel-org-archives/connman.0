Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120D2185A0
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153423; cv=none; b=KrQa/Y6p3fSikDh5eEjA3P5IEwpgVAO+6YMADbr8gmAdg5TpS/MThlLxubLXj+/dleIeoEIbm8glL0wTZhKJ6e9UprNgUuSIV4zE+sV1wXK5FmnOFh5zCBh1aR3h04eT3bUgvqYfuq6YTq5ikelHt6ZAr26Jd4gljCeSa6T0VcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153423; c=relaxed/simple;
	bh=MhA8GxcFawyataBCTq7owPmn6ubX8NIDsFCGXaYSbrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6lf0s0y86zHkhbF3WMoxjBERLJhRsI0aPH5vZFCbgoEDL72FIL/stBCYDDxP8/BsQ+NSMqs5mpmq/47ch1s1cAHXZ+PgHX7hpzGXBhpWWt+pZbnwEavGHDI/USpnfgT2dCe4NCCAQ+owpk44rTEpO/092d12qBW0S/2jFfuyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=A8iGwcVi; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="A8iGwcVi"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id D37BF164A44
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:59 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8B4F11262B9
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/15] service: Document 'service_set_proxy_method'.
Date: Fri, 21 Feb 2025 07:56:48 -0800
Message-ID: <20250221155653.760046-11-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=DMEVtJxEypbJbdo46QA/JuNoLWGPwQUfFlkxSoG2fnI=; b=A8iGwcVi8thbody9p70nHinkM6aFKSF4OL1gBpChWPHIdAA1P3cZuRIbi+8h8KwNpM0zURk0y9+3OipDGlHgrlTJnxsu3LR4Yix5+uSb3rWiZm8UZRUxRXmfRCxKeMWB5tiw5zlaXGod3QU5KVDArjJgjp/F0V4aGLJbSGaEOQEQk3rbtIn/0EDRFJY8/2K3dYYgj8p5Vj+M03Tkfmwb6CO6/9kNFysyTIOCs5WoYcxoQGGhd5GtRGr/qcL2B4vizuxb/efefit5csaJy5z+nsRR7TN6MT3RDrci5qh+TMXlWMKe8coxIo3M2QXgH409Hd3eXUp51t9og3LgvFTXsg==
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

