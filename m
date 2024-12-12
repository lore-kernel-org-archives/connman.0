Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CB17CA1B
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981310; cv=none; b=Pkxawc6XgT761ZJHxF+8l25U6MJFGKSq/3LdffQ3IGk5cfOHmgHrqz/IcumibjmnM2zVD71u9iXHsD7xinUjfPw7LtFajQBrq8ZWZkcUwUZAs9friMCrMrCM5ugtzqWL0SWeFYy1p+dS82k4NE9XZRtImEvHUI2/pFz5ldR2l50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981310; c=relaxed/simple;
	bh=pcdiA+kfE/4PfnJeswFZEsO08yj5hl60J6YA0hI2O5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8S7navO5YYPybIq7nFLZCZq2h7rk7q2sjjtBuB9N+JaKknV9RWTWvVxb8rTVjZOXgXkNHddnqa8a0Qe7dgyse9PQ/8HF1OvdO0BQ8aUs+DOEG0D2/CxRcsUQz2voKhneDKSjnEOxXheiO2HkR5eXIgZZmX2GXLLBktz4HWB4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=G685EjoB; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="G685EjoB"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DEFC3164A5E
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:23 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 93ADB125164
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 11/15] service: Document 'service_set_proxy_method_auto_handler'.
Date: Wed, 11 Dec 2024 21:28:13 -0800
Message-ID: <20241212052817.2021264-12-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=iSeMwyHmrkTmageWa0zvLP83gaNER4Fyqup4KK8kLqw=; b=G685EjoBiz8ZY6vvPhuE3xhWTtE9nOuMcSB4Bxl/kAD7zV/nu3fqc4YU1kuu1toyL8RmfAQX3pcMG4rK93N4nQJ0UHPH3X7eg0FldlycX2fMmlKuc3UvBrdpWvg00cr/W0fB+k3mSSNky9eQeuOdLs4OVg8GpKUWVJW2AFjOjiEvwkeRrybMe1f6no9RYkARiEFUF82VqOA0nQbgr7xJYRh8R5/IhgNbvmxuM7vCgF/THZV8GiRCnLI8IuTNwD3J8FdLQHHhrEYtwuCcp2FU/gdLdD3QHn3QTq3pMcR55wPGp4c4W9EI8SZ1X1Vhxq1O6IwclDcRKSripmPz7wq+LQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_set_proxy_method_auto_handler' function.
---
 src/service.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/service.c b/src/service.c
index 3fd56188093d..b27828d98a42 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5697,6 +5697,36 @@ const char *connman_service_get_proxy_url(const struct connman_service *service)
 	return service->pac;
 }
 
+/**
+ *  @brief
+ *    A post-mutation handler for the service proxy method when the
+ *    method is #CONNMAN_SERVICE_PROXY_METHOD_AUTO.
+ *
+ *  @param[in,out]  service     A pointer to the mutable network
+ *                              service for which the proxy method was
+ *                              set.
+ *  @param[in]      method      The network service proxy method @a
+ *                              service was set to.
+ *  @param[in]      context     An pointer to immutable context
+ *                              that was passed, along with @a
+ *                              service, @a method, and this handler,
+ *                              to #service_set_proxy_method. For this
+ *                              handler, @a context is an optional
+ *                              null-terminated C string containing
+ *                              the service proxy auto-configuration
+ *                              (PAC) URL.
+ *
+ *  @returns
+ *    True if #service_set_proxy_method should continue with state
+ *    change notifications and processing proxy notifier changes after
+ *    the handler returns; otherwise, false.
+ *
+ *  @sa __connman_ipconfig_set_proxy_autoconfig
+ *  @sa service_set_proxy_method
+ *
+ *  @private
+ *
+ */
 static bool service_set_proxy_method_auto_handler(
 				struct connman_service *service,
 				enum connman_service_proxy_method method,
-- 
2.45.0

