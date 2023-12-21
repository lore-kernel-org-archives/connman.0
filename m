Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDE539E0
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 48E5773200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:12 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 0A4AF73206
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 05/60] service: Change return type of 'start_wispr_if_connected'.
Date: Thu, 21 Dec 2023 14:34:12 -0800
Message-ID: <20231221223508.2365510-6-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221223508.2365510-1-gerickson@nuovations.com>
References: <20231221223508.2365510-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This changes the return type of 'start_wispr_if_connected' from 'void'
to 'int' to allow callers to conditionally handle its return status.
---
 src/service.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 0c8a4bc0a0c9..5077e3fb2d1a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2394,15 +2394,23 @@ static void complete_online_check(struct connman_service *service,
  *                       reachability probes if the IPv4 or IPv6 state
  *                       is "connected" (that is, "ready" or "online").
  *
+ *  @retval  0          If successful.
+ *  @retval  -EINVAL    If @a service is null or @a type is invalid.
+ *  @retval  -EPERM     If online checks are disabled via
+ *                      configuration.
+ *
  */
-static void start_wispr_if_connected(struct connman_service *service)
+static int start_wispr_if_connected(struct connman_service *service)
 {
 	DBG("service %p (%s) maybe start WISPr",
 		service,
 		connman_service_get_identifier(service));
 
+	if (!service)
+		return -EINVAL;
+
 	if (!online_check_is_enabled_check(service))
-		return;
+		return -EPERM;
 
 	if (__connman_service_is_connected_state(service,
 			CONNMAN_IPCONFIG_TYPE_IPV4))
@@ -2413,6 +2421,8 @@ static void start_wispr_if_connected(struct connman_service *service)
 			CONNMAN_IPCONFIG_TYPE_IPV6))
 		__connman_service_wispr_start(service,
 					CONNMAN_IPCONFIG_TYPE_IPV6);
+
+	return 0;
 }
 
 /**
-- 
2.42.0

