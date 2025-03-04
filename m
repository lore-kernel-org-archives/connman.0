Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0EF255232
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122193; cv=none; b=fkpao1SJFp8HysCjFdHsOjKLSPKtVhWP/zjTMKRSF62F+rJ/cYZZOgooIaYUo/j7b9DdanunKoI3rGZAGdlh332RQo2tRZlaaAamIRhm8swQlc0V/wCKxDa0e657POCWevzrpPBp5hz1ILaQDPZv+/NkG7xUiF8ypw2NuEd9hN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122193; c=relaxed/simple;
	bh=Xv/Lr8oxSZRpVMx7a3ghp55HYANkIOOL+iQQVUahQXk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzeOOUsDwNXIEpfb6YGrfBg3o0cj+Gdh+79M2uAl5lrBBc4JaMSYni4/ibfTLD3k57aF6AWubhad3f45La+PPYCARE7p2D9FfOt27kp3vVqGVyIkQVhc9g9O89CJzP/1jnh3pcfsYK0UsrlTY63yznfYFX7zmzu1g5WkZsW7xMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=EcpNJXD/; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="EcpNJXD/"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A64A7164B61
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:09 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 5744A124FE6
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 6/7] service: Document 'service_set_proxy_method_auto_handler'.
Date: Tue,  4 Mar 2025 13:03:04 -0800
Message-ID: <61192d613b0bc8d0c5d1580b3d924c4819d71ff2.1741121901.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1741121901.git.gerickson@nuovations.com>
References: <cover.1741121901.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=YFEOkbj1i+p+bPJmkQPAH9y8/lQ2zUNX14FBktCg7LI=; b=EcpNJXD/6BRbeSn/ZlcG4rKBpEcrKuQbojgDUoyGbls2qDad8jOgt4bMnjabacbADkK4GrCrK9m/nQgnJRveVL4Bt7UJiirDfBtF/qDhQ+mF2ef3g+a7btdR7jjldBekwEkZ/1htNOLJQtQtJVp5u32w+Dh7ThkPHcEMUONYzKdaaNkyjIyI9OTWY33NTOVhBNG49OHMRKVZI3wR77vWlS5GsqZssAHkt9Y+M8tjfli+ItbgC/XGAZ9hVGYmY4vQqHjf3yZtPoZH5SY9UYjiKT8ojv1RgfysQPKBAZm0opJU1MhbQbXfFtS545gkLBUVK+l2jef1blWH2ru7DBvuog==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_set_proxy_method_auto_handler' function.
---
 src/service.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/service.c b/src/service.c
index 17193706d9d4..4b31db3c6358 100644
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

