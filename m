Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB18217674
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153422; cv=none; b=c9PzcPRvUyT6wQdKqVVPSr6KGdEHj3BSIxNaO5eK+iN7meixCfuHM5EnShLhWqvCH0fgBPMpA4Uc31qBTCOSgOZ8ZlvG4qCCCUEhutYz/YfwL32l/34Cby+yFIbojFcNlOBjBsX8Hmuuvj+lOXWfvqV6T9/KmxS50XuaMlAgM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153422; c=relaxed/simple;
	bh=lpkz8G+VeIvhVSq+BOerm+WjhYTlK+xE7g1I9BuSyXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS1GD30jLZsuMIhx1a5ACQUIci9IeItZQWhK7CGIjlGkj2rd12JeMaSWpX7dLQ2Pa29tFuXR6nfBND8w7Dy5/ZZY/eCrGvSMdKvMr7mYPkrqNOkOCA/jFiBMRZFr+Ixt67Ck+bfZhD3QNWnw17xdeD43buPUPnEY0Eu26Bj+LFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=aQlqjS4n; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="aQlqjS4n"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B7276164A4D
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:56 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 6E490125174
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:56 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 03/15] service: Leverage 'service_set_pac' function.
Date: Fri, 21 Feb 2025 07:56:41 -0800
Message-ID: <20250221155653.760046-4-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=4KcKIeLC8PGZeFuYHxLDiBLjQPEdErP6uwgbGjAfD5s=; b=aQlqjS4nrw1KBAHc7NlnduL9eTrkBwYhs2hijgzUSEyqdVJzmlAocVm1bJOrvVmZuKFBgRPt1QyT99HgvmoBAwKKU8NHmAjqJPw4KkRzJNlqLu1y1+cpTieMOdlWkqmRjCPjj6y/dCSKlIa0caV9ohBoCEEDLZxxddVTgOhlL/FIuVJX72RXU8awMRZng4+llgKX/OZ5Jx2fRPIoVaXsC9+/GRLqyiMPD/OKeKhIy9ryXZUpvWnb41tTu0zd1a2IOpOytDUQGHbzHrnlbEpXqVh90pq0cYNmYFm9FEGSDWTe6BOeDj4DVFxnCMDdjEZyOfgw330xMSHP04pBXwUMUA==
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

