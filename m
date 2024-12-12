Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D651166F29
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981309; cv=none; b=dpSyFj39FdJNBZn6Jlw/BmvjT5mMkSGndWVR6p718T/zmxWgPrb+lkUhynZWH2Dhi393cnm7JDjlXMGo04T+R+hJon2a0CSplqTmGpECRjVi57NBJKYP6zJ5medR13yE7jHNIwI/YMWwd1JIPi4prioybzo291YdtlQnl7tsg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981309; c=relaxed/simple;
	bh=sF0P/IxQWwEFRR9llBGL0YLgYAAMYdMm9//6fzFOdEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZltV9hsIrqHn2cfJE0L+frW5Nxo+n+d0d37I7ddNcoHXYNbGzsUy6NLac/PRnYxFgMr6vaKAHmkGEXITtH+xghIExZecrqBABvwVip8hVaMF2qSNGitrKadY9V4cjUlUVO31cyMlCAnMl+12hiNFG92hk4ah3qSkci0Wz3/55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=bJIj2Dmg; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="bJIj2Dmg"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 007BF164A51
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:23 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A6E5F125164
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 09/15] service: Leverage 'service_set_proxy_method'.
Date: Wed, 11 Dec 2024 21:28:11 -0800
Message-ID: <20241212052817.2021264-10-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=8XAx76eSCE0NfTT2qSURjx7LHO5cglpMg09x6rEGG78=; b=bJIj2Dmgi06QmfD1AOIZCTTMGbhCBershWKgTPHurRVuHv1sRDWHRJTgz+mWZJZ7eFWPsqf7tSvfJgXzeGJUOhKQRQrPy5bYoF1+MSC8FDyijVvmH25JHJ/TltFrlPANJS1X6aR93l4YhyE9Cgy5X6HjXpzr/F9Rj5cy7a/VMfHnOWQm+3k9O0GHvu6krdrDhmMb/ww324Kg0DyEAW0x7+/7MHsjFC/DKKXLcb+Y9jl/XP/Q7yEuckvKoN89g5Tk4WGbxjnHjeuYAfYUfPyeK4Th27VUKPuDkFOBZ+7kApXX3yJklGdvXeOaMP7dlAhjz8tsI7x0mB0XbzvhJsuKkQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Leverage 'service_set_proxy_method' for
'__connman_service_set_proxy_autoconfig', the second of two call
sites.
---
 src/service.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/src/service.c b/src/service.c
index 5c94c2962de8..d2d8e7cea065 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5662,32 +5662,47 @@ const char *connman_service_get_proxy_url(const struct connman_service *service)
 	return service->pac;
 }
 
-void __connman_service_set_proxy_autoconfig(struct connman_service *service,
-							const char *url)
+static bool service_set_proxy_method_auto_handler(
+				struct connman_service *service,
+				enum connman_service_proxy_method method,
+				const void *context)
 {
-	const bool dochanged = true;
-
-	if (!service || service->hidden)
-		return;
-
-	service_set_pac(service, url, !dochanged);
-
-	service->proxy = CONNMAN_SERVICE_PROXY_METHOD_AUTO;
+	const char * const url = context;
 
 	if (service->ipconfig_ipv4) {
 		if (__connman_ipconfig_set_proxy_autoconfig(
-			    service->ipconfig_ipv4, url) < 0)
-			return;
+				service->ipconfig_ipv4, url) < 0)
+			return false;
 	} else if (service->ipconfig_ipv6) {
 		if (__connman_ipconfig_set_proxy_autoconfig(
-			    service->ipconfig_ipv6, url) < 0)
-			return;
+				service->ipconfig_ipv6, url) < 0)
+			return false;
 	} else
-		return;
+		return false;
 
-	proxy_changed(service);
+	return true;
+}
+
+void __connman_service_set_proxy_autoconfig(struct connman_service *service,
+							const char *url)
+{
+	const bool dochanged = true;
+	const bool donotifier = true;
+	const void *context = url;
 
-	__connman_notifier_proxy_changed(service);
+	DBG("service %p (%s) url %p (%s)",
+		service,
+		connman_service_get_identifier(service),
+		url,
+		url ? url : "<null>");
+
+	service_set_pac(service, url, !dochanged);
+
+	service_set_proxy_method(service,
+		CONNMAN_SERVICE_PROXY_METHOD_AUTO,
+		donotifier,
+		service_set_proxy_method_auto_handler,
+		context);
 }
 
 const char *connman_service_get_proxy_autoconfig(struct connman_service *service)
-- 
2.45.0

