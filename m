Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CF218596
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153422; cv=none; b=duZXmAvzNyjvcqMx6NUjJVQLPhwIE+FfEmo4zF4YRJoOslYa7gtiMkaVYMDRJQLK8Zk+E6SNYDzJlM77ccIHW2CYn+t4D08CJVtcxxF7G0D9ndcwf80NQl/Z+YnoYxgnKdg21+k8U1NanYRHzl6K+1ya6AtTxSoqlcDyPP4BTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153422; c=relaxed/simple;
	bh=bLq76X0qSxzQROLcYaepSthaA4BnwYP0Fftkg7G+tcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQR+ymwltn8/bXQxz66aDR0iJOw/jequNisQCNjN9AjC8EDOfAYrlcSQw7nPGrn7wTnu77vDrlGPMpfhbZxYhngGhh0Eq9vaQynrSQ8nPnbph1INcGjr1lDa8Gs9c1aBjzgQ0+pipkpSUIv33+SHn0Tr1i/UUgM4+PMwduFwboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=T4s45b5B; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="T4s45b5B"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 83944164A93
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:58 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 39F18125174
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 07/15] service: Add 'service_set_proxy_method' function.
Date: Fri, 21 Feb 2025 07:56:45 -0800
Message-ID: <20250221155653.760046-8-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=7zd9CaAvX9cIOWNcHFeJfp3VCY4w2FRil9KYudA48QM=; b=T4s45b5BBXpfrcdc9Br0Z91TNcnNIPUUzafAU2lQ1BNYKUbDqR72F//WCJMTUV2HVoHfziToh8rZ36/DZ+mlexrOMxf23l06uTK3I/CP6iIjiSqWuzoGlB0esrUVBEjHeUlllDBqhcnz9YqS4juof6xlTc8Fx6BZLrxUz/o0eKOltvLLdo/bzheo0zf1yM7ZgbR2Lo0PWWtqtgAr3p37C1URjL+1PAvG5k4Tx7UbWvdnBj9KO4khW6ehYcD/9m8Ku+9k6/SV7f4D5JKrQBpbQahymWKc8snPTTDiuLd6OwP/WUtV3hcZmyn3+8fdCDK+RwvQ1N9Dh+6WNbAIx4iKRA==
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

