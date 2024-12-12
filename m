Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749C15B0FE
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981834; cv=none; b=rZqAiSoeIfcKTUsvxxm6fJ2sTLE1CskFFMyom2HXbSzi1JDFrtne2PQyKgAaPtXqUm0VUJ6sUxsw7CJhI3hXZw0Lif7Or9D5jUB5KhwaUQMwT/OWU0Xp+ofpxYLwVBepcS7WjdQq0rci+LLSD8jXdP8OWcq+3tDf12tem6EYjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981834; c=relaxed/simple;
	bh=lpkz8G+VeIvhVSq+BOerm+WjhYTlK+xE7g1I9BuSyXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGMmknPrA63gI2ZdgL85Muj9yJyMe6AsgpuUxkObQCtmMNVVzRAdNMotQTDVcI2dO2DQW63LFJzHdLpECYx6UWju81/fTNoNq8153uRjR38j1oHPW22+VEMxLNs1iGbtI1PVHKbg4sJ2qjUxSy6xGIQGzB6xDPJZUv0M/xiFhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Fc42NaIO; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Fc42NaIO"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 3FF4F164A14
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:20 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E9451124FD2
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:19 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 03/15] service: Leverage 'service_set_pac' function.
Date: Wed, 11 Dec 2024 21:28:05 -0800
Message-ID: <20241212052817.2021264-4-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=4KcKIeLC8PGZeFuYHxLDiBLjQPEdErP6uwgbGjAfD5s=; b=Fc42NaIOqbR0JdOadvMjuQLHnVBbvm+8P0EsluaRa7uJcf9iZ+n/doIyM+n2gtgmSAw4qBitP0IGtly5XKrK96aPhejfLAvegKm0FysLFdukbP0rAawBjlCg6IFWOwCTwJ/OfeTWgptIcuBh87CIaroACjpYvEjIMM8lCozU5EOx0qFSDclNIkeUFk/j4zXzcycZnLpWOIptPkg6/yQFYkJJaZiwg/5AWBWEJokS1B+/xKV9xzaTNe5RMP6bgArm0KF9gDYpMX24evAS5pRfph93wtKZnu3YCRAg2g9UwyTlGaoL9pLqej+4XVp8yRk8RWL1vAomBMciROwh7ECSYg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Leverage 'service_set_pac' at the three call sites the proxy
auto-configuration (PAC) URL is currently set or cleared for a network
service.

Frequently, a spurious, misconfigured, or otherwise incorrect PAC URL
is the source of connectivity problems, particularly for online
reachability checks. Consequently, being able to log all such
mutations can be helpful in triaging such problems.
---
 src/service.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/src/service.c b/src/service.c
index c48959a7940f..da851d681bc7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -770,8 +770,7 @@ static int service_load(struct connman_service *service)
 	str = g_key_file_get_string(keyfile,
 				service->identifier, "Proxy.URL", NULL);
 	if (str) {
-		g_free(service->pac);
-		service->pac = str;
+		service_set_pac(service, str, false);
 	}
 
 	service->mdns_config = g_key_file_get_boolean(keyfile,
@@ -5757,12 +5756,9 @@ void __connman_service_timeserver_changed(struct connman_service *service,
 void __connman_service_set_pac(struct connman_service *service,
 					const char *pac)
 {
-	if (service->hidden)
-		return;
-	g_free(service->pac);
-	service->pac = g_strdup(pac);
+	const bool dochanged = true;
 
-	proxy_changed(service);
+	service_set_pac(service, pac, dochanged);
 }
 
 void __connman_service_set_agent_identity(struct connman_service *service,
@@ -6049,12 +6045,7 @@ static int update_proxy_configuration(struct connman_service *service,
 
 		break;
 	case CONNMAN_SERVICE_PROXY_METHOD_AUTO:
-		g_free(service->pac);
-
-		if (url && strlen(url) > 0)
-			service->pac = g_strstrip(g_strdup(url));
-		else
-			service->pac = NULL;
+		service_set_pac(service, url, false);
 
 		/* if we are connected:
 		   - if service->pac == NULL
-- 
2.45.0

