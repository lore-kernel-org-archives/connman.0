Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE7205E18
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122192; cv=none; b=mGAcxMt6vO4M6IhvtMM/n31gepbqALJysrqlaQcJmWXDuIwGBwU+UtEEsQBHHEGTSilhahKaqpxre2pvH805w0TWoNeeNpLHaqLbTUxP/nfMgY17+0p3q+9+JpWDfW6YP+NNtvr1rMQihOI1B+dgzTPyBUXyb3Q7E9JrzzaVCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122192; c=relaxed/simple;
	bh=JbTDXTZMBZqw5EpXWGl7A2apvZ8MG5+6p1uU4wutw3s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVyr3M0u6sxjTKgO1JnNr2TfNb8in+LbSchMFZbD3TtABd+IYuO7aN4Zy1/5b8imWaoCp2FGbokycvdwwXM2usZJiCgu+2VS4gJi+uE48loGRb8lxMABByssiwziV/lu9vgyp0vjlceq3INltyNgFkvNr/IK0wX43Poe65dJXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=S24CiIs4; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="S24CiIs4"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 41466164B5D
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:08 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E681A125175
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/7] service: Refactor 'connman_service_set_proxy_method'.
Date: Tue,  4 Mar 2025 13:03:01 -0800
Message-ID: <44b13e5a6dacb06960ed0480ffc598e19b21f8a8.1741121901.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=3lEkqrNfLUY7W+zRpDXKGfaa32MV4yJVPpCuKzJfqgE=; b=S24CiIs4BuTMsbO/G+UJCF+oQoY5DJptaq80vjD6S+3ZRqzZtYzj7ffRy0XkXWXh6FNW8m5/0ebLyHOF4I7OzwdAWbgBRfmxyCUL6pveX38zRJ/EXD8IsujSuEtnvBpjauG5A4JBEG/X0LxQFp6jCMSJ8/5oi72La03SsqK2ujhRkgDJlWW9Ab0kIsqhvKRhMU1uWCKPIyhcuovwy5MfQ7at2otCVNNC1AvLYjPsR60trIMU2KFQkHOOiD33+ICP6wBeEmLArS4UFNmxcpLv9HgBdS4yD7I4AfdAvIDwWiKnQXN3kA4Twn2DR29Zpqo2EzcksgHlI6xvIbuMzTBahw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

There are currently two places where the network service proxy method
is set:

  1. connman_service_set_proxy_method
  2. __connman_service_set_proxy_autoconfig

Prior to this change, each did a similar, but bespoke set of
operations to set the network service proxy method.

Leverage 'service_set_proxy_method', which embodies the
previously-similar, bespoke operations, for
'connman_service_set_proxy_method', the first of the above two call
sites.
---
 src/service.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/src/service.c b/src/service.c
index db6ec26240fd..6fff20d4de96 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5618,19 +5618,13 @@ static void service_set_proxy_method(struct connman_service *service,
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
-
-	proxy_changed(service);
+	const bool donotifier = method != CONNMAN_SERVICE_PROXY_METHOD_AUTO;
 
-	if (method != CONNMAN_SERVICE_PROXY_METHOD_AUTO)
-		__connman_notifier_proxy_changed(service);
+	service_set_proxy_method(service,
+		method,
+		donotifier,
+		NULL,
+		NULL);
 }
 
 enum connman_service_proxy_method connman_service_get_proxy_method(
-- 
2.45.0

