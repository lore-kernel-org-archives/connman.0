Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62417C21B
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981308; cv=none; b=XokWXhvpQU0e7T5/ZawOgaJpXnho9UfGb0ikYIWgmEa6uctGQH7XqKlHilEPAI6aBkHgwSTyep4fnMGp8hOlOzrA1yolj9tBARrw4OntYjTkyViQtLi7mxvVUjxUICYJcMVLNkJVzVm/xLhy54ISwafAhnCgQ0ylUH5Vke+TkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981308; c=relaxed/simple;
	bh=o+5g3TCP/NvqP6ob5P8QRjCiuzNJyXcrgiSJvfzVnrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlK7RzdwUVfN3xbc+6NZrdfmP7KBxA4NqCSvzA22ZDtgtL6/Z8cJlrS4hSSUW2JIcbLLmcu9I+5/bMr2uLELxsTDPoT5K2KYBLod1r2Wjz7VPGLV7rgBC1Iewcn7S33O4RnxPvKY/odyLjSH9El4KvDty3pD/gIrl1FoqMrNMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=B+QV17Ej; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="B+QV17Ej"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 823CC164A50
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:22 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 360D4125164
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/15] service: Leverage 'service_set_proxy_method'.
Date: Wed, 11 Dec 2024 21:28:10 -0800
Message-ID: <20241212052817.2021264-9-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=i9NQtwYrWXU2VEI3jPtmOSwIa+ivhSK/aUcNUJQBWCY=; b=B+QV17Ej0lSzmyS10xdhTEjgBW70P+sOLPh4LwkHS3Ksdm+fG6AnUyK7kNE6Z/28ybQogR4zG2TED+zqYb9M3Jm2iqNb+s2uAoAnN9Wau1Y/OAzGmLBDz2NngWEAMKwnM61EfwGS7OTLXQt2kVF6Cvu6ajNSXumWAvXYkbSv9oy4eO/Awb6UDWpZUm+5Cskez4xGRn6I1YjaTojZ/7k1/PYPwkMHsTxrxYCPmxqe2BEL34ptTW80UZqGaK7QZxfD+4wSf5nt42+eqdWEES7iBAGYLSrOr/grMYIjEooj3W0b5aVqWiORQOf6nRASAbcYvE8KnvxyQQogwHm8GNdHIQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Leverage 'service_set_proxy_method' for
'connman_service_set_proxy_method', the first of two call sites.
---
 src/service.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/src/service.c b/src/service.c
index e58958635992..5c94c2962de8 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5617,19 +5617,14 @@ static void service_set_proxy_method(struct connman_service *service,
 void connman_service_set_proxy_method(struct connman_service *service,
 					enum connman_service_proxy_method method)
 {
-	DBG("service %p (%s) method %d (%s)",
-		service, connman_service_get_identifier(service),
-		method, proxymethod2string(method));
-
-	if (!service || service->hidden)
-		return;
-
-	service->proxy = method;
+	const bool donotifier = method != CONNMAN_SERVICE_PROXY_METHOD_AUTO;
+	void * const context = NULL;
 
-	proxy_changed(service);
-
-	if (method != CONNMAN_SERVICE_PROXY_METHOD_AUTO)
-		__connman_notifier_proxy_changed(service);
+	service_set_proxy_method(service,
+		method,
+		donotifier,
+		NULL,
+		context);
 }
 
 enum connman_service_proxy_method connman_service_get_proxy_method(
-- 
2.45.0

