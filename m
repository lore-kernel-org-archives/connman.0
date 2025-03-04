Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56F1FC7FF
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122190; cv=none; b=VuZzKjRbWq+gybxPZgbIYUWvQrxMq/W3OZydh/dacGWB7rzvVfPRihEKoz3kD5f3pbI7Y5LXqQca9+lanFIuRFph4A6JDRKvwonBOCf1pw/BkVdNi2vS73OjHIGTxX8iuN+QUxRk83qHW9zgfVwSqfZOmZSNE/wsx3YPpQ6NzJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122190; c=relaxed/simple;
	bh=MC96KuaG4IGUON5XCPXx1JOK6bymsAlL349CBKuoK58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uf+/31ooMuBeymcb71RFWw8yWMKbJxOPQK5yJUN84CZDaD5OIJExt/nCgxHA6StlnaSbNRwIcDZBcYBwOGuWnSdemY7XLOp4PyY9z+sWcyDqsHg3rqtRltC3Lnhig+dYGvjR/siknb9VXcha07rn46BytYWbB7+lOxKNk0ihNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=kb/s/dP3; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="kb/s/dP3"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4DBF0164B59
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:07 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id EE6CE1262B4
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/7] service: Leverage 'service_set_pac' function.
Date: Tue,  4 Mar 2025 13:02:59 -0800
Message-ID: <ba0ce360b3c803e6107d870514bf801a783229d0.1741121901.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=E9rfrUsqm4lUOQWsthmDBzuvW5CHL+l15Ncp6hv/T6Y=; b=kb/s/dP3RGrRy4irwqnnZ5rqFvkD7Kiz1cKnws6n5m7ON6J7x/QCV6/DVYQ6KlmuSU1oP4WC7BwjnFIFueLeJB2rqy7RPcEGEk2NZIDt5rnb9sDxs0cPIy6rV7h6lX5XVvg12riv61ZlvFcqVE5Kp5nLa4q4mI/w4KCc+GaZalwzJ7pyT99sophlBGiHwGBrGQGUSgs0FRUPUr10ex7MmMoxStcrh7X4rNiHyWIavu2egU9Mv6KLX2j0C0hzZxk+CAPHcBLkQCMpXfLkNA1q9GmXT2GMrfeMph2pp8q6ORETWBw+wU26lveLKScdC+7GM+yxhCkZ9rdTC2R6lvyuhg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Leverage 'service_set_pac' at the three call sites the proxy
auto-configuration (PAC) URL is currently set or cleared for a network
service.

Frequently, a spurious, misconfigured, or otherwise incorrect PAC URL
is the source of connectivity problems, particularly for online
reachability checks. Consequently, being able to log all such
mutations can be helpful in triaging such problems.
---
 src/service.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/src/service.c b/src/service.c
index b8943c03f459..b261f4ce0681 100644
--- a/src/service.c
+++ b/src/service.c
@@ -808,10 +808,10 @@ static int service_load(struct connman_service *service)
 
 	str = g_key_file_get_string(keyfile,
 				service->identifier, "Proxy.URL", NULL);
-	if (str) {
-		g_free(service->pac);
-		service->pac = str;
-	}
+	if (str)
+		service_set_pac(service, str, false);
+
+	g_free(str);
 
 	service->mdns_config = g_key_file_get_boolean(keyfile,
 				service->identifier, "mDNS", NULL);
@@ -5800,12 +5800,9 @@ void __connman_service_timeserver_changed(struct connman_service *service,
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
@@ -6092,12 +6089,7 @@ static int update_proxy_configuration(struct connman_service *service,
 
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

