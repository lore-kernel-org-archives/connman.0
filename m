Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A99205504
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122191; cv=none; b=Db8lTTB6K3Irt+7/qA6Mbx05C5R3AiN5UUcPxsKDWRf1sqofi7+youe9tFYXJ2QxlL7OTs1JOtdg2IYVo+gryPVEMp12/NTNKyQZvDQhpaVyXORrvcadjvKVXMaxmYzsvIcUAeQjmnJQqrTTBnkXbYen5vYiChna4yV6X4K3Q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122191; c=relaxed/simple;
	bh=tzRai6oyHgMM/MMMwjOCZdHgtmBMMW1kJ7pO8Ppgfn0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCeaCoGr6uFlbz/F2Eb/DHhHQJdfg7g6mUfIiKi3oSiNO7KqNF8t/U616Nuc5E/2LdbHHUQY3NyPj+VVcOyQ7Vt04Zfwc1AycWBym6ybP1IiDCoCwziIaVkTrLlrVIWmwyTxnjFMwuxktJzsh/HWXzvxz2MVE4k9sqHxPPYo0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ROyUEPcu; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ROyUEPcu"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B4E32164B5F
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:08 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 67248124FE6
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/7] service: Refactor '__connman_service_set_proxy_autoconfig'.
Date: Tue,  4 Mar 2025 13:03:02 -0800
Message-ID: <e8c2b846c7065de631592721bc38d15f6a9a6575.1741121901.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=C8kqIx0/jeKVyhoflFTC5cJ24wPtA/1cwz8ZNitWcug=; b=ROyUEPcuSwdFvzoDBldI7Mp0uxDmFoohhbC4wtGdrqBrfNANk1OYbye1z3SqISeQZUmgDQMoNjzDPwQqoXGdP7QoAxjbGrwzwxl/RumSz5GvHRv0/9Qv4izW9+k6LbXFC/FyV7xErhzOiIZ0SXI8lnWbUN6wnCTVxpviD+ybgpcJW7Z0NjlMRjDZgF4JluhSTq2MKpp8cJpD2Wwz30HDtIHGKrTbnnskMTMw1zSwDEmJSvbhGBSxAnW7F8LxAHUwYjPa2CgT5IqUwvwxbACO8uc8UWKPKpjI6Z7xX5og+3ILgePTBdiiza6tn0ofuRxxWvv5JegrtxXpySqVli3MSQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

There are currently two places where the network service proxy method
is set:

  1. connman_service_set_proxy_method
  2. __connman_service_set_proxy_autoconfig

Prior to this change, each did a similar, but bespoke set of
operations to set the network service proxy method.

Leverage 'service_set_proxy_method', which embodies the
previously-similar, bespoke operations, for
'__connman_service_set_proxy_autoconfig', the second of the above two
call sites.
---
 src/service.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/src/service.c b/src/service.c
index 6fff20d4de96..cb168b03c790 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5662,32 +5662,46 @@ const char *connman_service_get_proxy_url(const struct connman_service *service)
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
+		url);
 }
 
 const char *connman_service_get_proxy_autoconfig(struct connman_service *service)
-- 
2.45.0

