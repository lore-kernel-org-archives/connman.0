Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0055168C3F
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981309; cv=none; b=iDQVCypJvvTk1JyZ1ri1zV5P8tsousH5AqxuKj47o/iHHO+Bkr29gaEq6JOGjLi1QQKHsi2TqvadbOcMAIbSW3lfk1BHAq35knxX7YV/v+bIHKLhd69qB3TKVpQ81ZWcE6Qu63V/ocfcwwKkREF+uB4fJvKr8WLAjoP6KUvPnfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981309; c=relaxed/simple;
	bh=61058HOzzhny93otOJskC3bMWkU3UTpzplzVkouhHeA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lq2XVOdcez0NCNwQiCNwVHND3bIuirkWCMh1g+QRwoKXK4p5nf8X/CLaiMrWUUntTvDbxdQom+7VuRN4sbBHPrgo5sO+fWtpO1q+smthTYLWfNP1/p9SHeQJHCmzZpcDbdGkhcZjQkPsTOwA0N7tV9d7RirXqXdDukP58Jh/Ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=mm3TRlin; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="mm3TRlin"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 28B87164A45
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:21 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D2C71125164
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 05/15] service: Document 'service_log_pac'.
Date: Wed, 11 Dec 2024 21:28:07 -0800
Message-ID: <20241212052817.2021264-6-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=mdKw2krJ28x56Ubzs4NgZ5fW4XkZzV7PGpcs8wMzYz4=; b=mm3TRlinuDPNbL9NVWeFfChygxaQyrEWrt6sWMZZ8n0TSkZDGjUHPMlpJKTQGbG/xkU+7gBc25iWeHWabGyBq/3LIF3IN3/FhpIZ8G1LMdNhXGGwmB97eepqnppcC7Z54Lt/0khztHeFcesxCS4e+sa5pM27jBEZiCvsY4GlGxfyV35N+wZM0sIC6IWrexlbbnPVegzMXWjK4qjr+Ft7PVevPr/iUwmAdEx/Lgq0NKVfy7EXTUriPCdpXkZsabN0RyLi+Vp4lYGErXse7DWO+Cv7t1JKBVfHDhCzQftdyXftvBMJVM/XHk5V9HaOl/gOkRyFot+D9/Xf1AYpsivIHw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_log_pac' function.
---
 src/service.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/service.c b/src/service.c
index 73cf8bca71a2..a4b13be2fd47 100644
--- a/src/service.c
+++ b/src/service.c
@@ -556,6 +556,21 @@ int __connman_service_load_modifiable(struct connman_service *service)
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Log the proxy auto-configuration (PAC) URL associated with the
+ *    specified service.
+ *
+ *  @param[in]  service  A pointer to the immutable network
+ *                       service for which to log the proxy
+ *                       auto-configuration (PAC) URL.
+ *  @param[in]  url      An optional pointer to the immutable null-
+ *                       terminated C string containing the proxy
+ *                       auto-configuration (PAC) URL.
+ *
+ *  @private
+ *
+ */
 static void service_log_pac(const struct connman_service *service,
 				const char *url)
 {
-- 
2.45.0

