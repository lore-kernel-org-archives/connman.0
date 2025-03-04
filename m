Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352386338
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050690; cv=none; b=POWsFFkLshWVmxggpyfFO+Bdt72sPiN+bi3K4DmUDgVdnmr+U3LEWU0tU2CmymHxlQLbtJfVZTwxahSQ0W41RtnXBv44wtQfVHvMpXV5GqKux9aIxFJNO/msjkr0i26CbF92fbIdXDjYAX+iJ+Zm9juc6OstVeM/l7Yi3rtiVzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050690; c=relaxed/simple;
	bh=S0IoI8cW8osAWztK89NCeIuGZOYZXpRC44vzGmqg3hw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/6rdhjoDozzGwWFHf+THu8ztDSVGyGkyutlU1vv+aNu65LC8wdVi44G+QsZWIAJocJrHJC/X+1emhgf6Ueg7+8zxN6CyaXCWj1RakiJN20H4qkv1CC5N7/xjUIPaPBjROO9QMb3DOZpyOUkPYA6V/4xwcFOty1etZ709RBj9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=IDuaZyb7; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="IDuaZyb7"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 5B7F8164B23
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:25 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 12E90124FD3
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 22/22] service: Capture and propagate '__connman_wispr_start' return status.
Date: Mon,  3 Mar 2025 17:11:13 -0800
Message-ID: <c9ba9fe4ee145481b360a3ab8c35992552766063.1741050622.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
References: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=JzuyPr/g95tGKoZQCm7eAGXm0UDoCaMEAA5YfTq7iZI=; b=IDuaZyb7uhcj2IZvNu55E0cYApKVN8oHsMJWeoJxJKsan/S59aTGK3RuMA0Xm8MM2Enko1bqa+nan+y4YDQ+2RCsnywz5J5Uoe5N1DvYBDRctZK5H/nFbZ3e0EcEvCb3n6tI6EuODN9aQmgasNS0wVqs6mOmlLSDllfxH+q4QEQJRGzxOoL4HWD8of9+AOXThMy/w0QI9IM6t5A9OtdR8WwMG0CdJIfAMrGzmAd4EyIqG8ltdIYNWi1PHUl81toeXgpI+cKdd3AjS9VWqYPUgtuOOjwaEzVEPvQn3iWobxnf+gB3WlhrLjQgAbYaRsYCmYOotBU6kp3AVZuYE1CAiw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

'__connman_wispr_start' has a number of early failure conditions
before the call closure becomes asynchronous. Capture the return
status from '__connman_wispr_start' in '__connman_service_wispr_start'
and propagate it forward, ensuring that 'online_check_active_set' is
NOT called in the failure case.
---
 src/service.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 0cfb516016b5..48a7d1f72367 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4003,6 +4003,8 @@ static int start_online_check_if_connected(struct connman_service *service)
 int __connman_service_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
+	int err;
+
 	DBG("service %p (%s) type %d (%s)",
 		service,
 		connman_service_get_identifier(service),
@@ -4034,14 +4036,17 @@ int __connman_service_wispr_start(struct connman_service *service,
 		service->online_check_state_ipv6.interval =
 					online_check_initial_interval;
 
-	__connman_wispr_start(service, type,
+	err = __connman_wispr_start(service, type,
 			online_check_connect_timeout_ms, complete_online_check);
+	if (err < 0)
+		goto done;
 
 	/* Mark the online check state as active. */
 
 	online_check_active_set(service, type);
 
-	return 0;
+done:
+	return err;
 }
 
 /**
-- 
2.45.0

