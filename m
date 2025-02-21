Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F721859A
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153422; cv=none; b=JBB1Z9hQgFjzHf2O0CJGs3bjuMGyrCvAz/WEJKh6gJiiinrzY1A3ZQvZ8QhFhPUb3ogi+O8gCjhjk4XWphsbEM3OQA+ldHzAdLgNnpVfGB/lVPAVRKUPfd3COBJeM7yKl1snaIoFAEIWI0DLKnc6+K3lL04eYKKdnwEjoEvIAT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153422; c=relaxed/simple;
	bh=o+5g3TCP/NvqP6ob5P8QRjCiuzNJyXcrgiSJvfzVnrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niuwR3Mxe0c3qDv06sz6nbLqPb2GUdBf5u4rDNV+Ob0oDm3rpmmB7FdpungfhHE9bTVgtSZFZx09LJ+EfckW9FMBKf8Q9aE8YThwmRS9Quk2wP5/3XIdWwiT0peZP07Xj5q4cZL4+hp0KuZuLONj2B+qz11qE/MMaPOvAmLhpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=FkrT0XFU; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="FkrT0XFU"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id F08D9164A95
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:58 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A793B125174
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/15] service: Leverage 'service_set_proxy_method'.
Date: Fri, 21 Feb 2025 07:56:46 -0800
Message-ID: <20250221155653.760046-9-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=i9NQtwYrWXU2VEI3jPtmOSwIa+ivhSK/aUcNUJQBWCY=; b=FkrT0XFUp4C817fAvWrlywSv9yvKTl6MOSO38h/JetMIHWu/FscLZD5jTRH/rZEaajVbachYDvRHvasZTILIKxV+fvX9oaABEdTcNJiEzQI5Sl8BVBWZ9ZdkMBXfq6mWYWqbk4V4XaFGY9aX6P1abe7WO3gp7Vxy7dpOeSy9SLbhmIhbFFxwR/tOY9xU8856QXz1tVYERlCf4eHFRbzMwuBh1JVmry0GmTCxPkx74DTtqqOjSAaksPDn+J4HE2gQifbuSwRe6j8dSesrcTQ5j0cqeZ8WJWdKfv9Uf1YjuTMDGndbQfqZ/ksWi2RZCt9lacVZR2mlK9AqEcEUGgB78w==
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

