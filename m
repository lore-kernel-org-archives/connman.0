Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A75255232
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122191; cv=none; b=WcjjWjrhqDiPll423E6WIJA5SK79qRrE078LxfbcSjrOQEV4JTheNRkC5B/oJ7mqzzeN9sttM1mGg2nqvWd8X2IXieOzsXiOx58mDYbFRpIErWap2ab+HJLtF6b0cXLRvCU6qSyB1Aa9tBMcCkz4xAhCjDgvlSRjztoF1l3UCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122191; c=relaxed/simple;
	bh=Lre3kmfOa4Ij0oghy9g9vKtGotpZgfYR18P4a9kaR2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on7x7aKCobPkNlj3BaZ0nWEduEHQ/dCQuCmnPx51F7P6uGqr6FyUwn0env2IdLsoiTqWd3KWct72r8Eaj9khMXfIx+T8v7q3XCSkORUC5s3j0agBcY39oNQF2WJ2VKx9cD1+LMczw7prvxot7+mN3hW7NJlr+PZF9xsQIfFHhcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=bSVknXxa; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="bSVknXxa"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C1EFE164B5C
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:07 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 724AB1262B4
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/7] service: Add 'service_set_proxy_method' function.
Date: Tue,  4 Mar 2025 13:03:00 -0800
Message-ID: <7441cb904a35bd70b37b79a93c609e1f45cfc66e.1741121901.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Bgw5WNU5okFcWA0MjXHDYdMLbiC/N5nkcSuAy+IOdLg=; b=bSVknXxaEFy+JHhpxq5tmLdWHAq+BnmAWzm0u/+QCRUzfUmeMYsuuysSfaD4t9XU4NdkhZPrZZsOoEgLlhSVt6x72EYODM9sX6bRGI9jMcSjkKUVD/I1T8vEuZTzZyjfMblP9qT2YvyjWuOx1HBevlBNqzkgN1vZPc/GY7A3y5QirpH01aalxHMm8e/5uGFHLSk3sA1bH+yBUm5b62jLnLqG/jqMsZRngkQUi0KSaVOcbhNXvfyEDApvdREWicXA6nC7QR/VjOoiIPCKnpVDuxGMMgRhSraP9NkGK7g9LuEJEQNDacKFafjU1rIXJVWwdUsaEoYE2DAou13RNnZ/Dg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Allows for logging, setting, and dispatching property changed
notifications for the network service proxy method and associated URL,
if any, from a single place.
---
 src/service.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/service.c b/src/service.c
index b261f4ce0681..db6ec26240fd 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5569,6 +5569,37 @@ const char * const *connman_service_get_timeservers(const struct connman_service
 	return (const char * const *)service->timeservers;
 }
 
+static void service_set_proxy_method(struct connman_service *service,
+			enum connman_service_proxy_method method,
+			bool donotifier,
+			bool (*handler)(struct connman_service *service,
+				enum connman_service_proxy_method method,
+				const void *context),
+			const void *context)
+{
+	DBG("service %p (%s) method %d (%s) donotifier %u "
+		"handler %p, context %p",
+		service, connman_service_get_identifier(service),
+		method, proxymethod2string(method),
+		donotifier,
+		handler,
+		context);
+
+	if (!service || service->hidden)
+		return;
+
+	service->proxy = method;
+
+	if (handler != NULL)
+		if (handler(service, method, context) != true)
+			return;
+
+	proxy_changed(service);
+
+	if (donotifier)
+		__connman_notifier_proxy_changed(service);
+}
+
 /**
  *  @brief
  *    Set the web proxy method of the specified service.
-- 
2.45.0

