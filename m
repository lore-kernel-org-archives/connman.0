Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7017BEB7
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981310; cv=none; b=XlK1RVNj0D/3G+KdpWPeWjod8yiRFAM9CIPDiFKJJdSXdFFRTRZV6j4f+j9Jei9nWeZlzVGly9rjDIwfAQuB4iTIoAe75Q2T9aLCOg4ekt2QZiNWvNKd9SxmC4iX2m5/eul6AM+uJ24WRMaVJxP+llVihxF/MiaPPEBpD3KqxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981310; c=relaxed/simple;
	bh=bLq76X0qSxzQROLcYaepSthaA4BnwYP0Fftkg7G+tcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjGnsLBhfMytLDJJMebKb/ZL+VjfAL90dNVxQ4L7GSTxzoq7d9DmsGxoqIaH/9nYqcSyiopSYKikcQCJ9LF9hlw78uOuKrsG1hNK7CG6S/iEvDPR8ch3FuSejknUz7DfwLVM2aW1m1fi/osOwRnWqef4HWFFAF3hWJn/K9pYLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=XAD3wcpz; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="XAD3wcpz"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 120B8164A4D
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:22 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BC5B9125164
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 07/15] service: Add 'service_set_proxy_method' function.
Date: Wed, 11 Dec 2024 21:28:09 -0800
Message-ID: <20241212052817.2021264-8-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=7zd9CaAvX9cIOWNcHFeJfp3VCY4w2FRil9KYudA48QM=; b=XAD3wcpzrzLGh+SdLH4dCUh8CRhMbA1BoEcB+OpdUm79jJYv3FfUCcW/cXqFh65Hhl3S8+lBQDkG2YeItrvuYhzGynQIzl9d99elnSC1ixWw1PNz8a9fk3m0U4k+GCxbfUTJ5ldSA21MjLDFRGJWfEnHveVSMGjzL4qfDnXYYeFJZJo/ekhRQNo4qY6oMNcLr2xMIoscpz17JsFV06ol9e7vqdOw7aWtAOQLQ1qFZXRUbHrLx4HclKcWBuLiziU6El8aBIKLzxgpLUAiFqPtZ52jTzHRxJrX1XteVgb5m9QEf7bMaYrRsAd2RBSxKGXUEQcujypWNgpIUBsqcKspQA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Allows for logging, setting, and dispatching property changed
notifications for the network service proxy method and associated URL,
if any, from a single place.
---
 src/service.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/service.c b/src/service.c
index 0713520d88a1..e58958635992 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5568,6 +5568,37 @@ const char * const *connman_service_get_timeservers(const struct connman_service
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

