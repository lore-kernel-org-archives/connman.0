Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63B1156DA
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DC41C7315D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:37 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9B56073204
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:37 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 04/60] service: Change return type of 'start_online_check'.
Date: Wed, 20 Dec 2023 22:16:27 -0800
Message-ID: <20231221061734.2344286-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221061734.2344286-1-gerickson@nuovations.com>
References: <20231221061734.2344286-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This changes the return type of 'start_online_check' from 'void' to
'int' to allow callers to conditionally handle its return status.
---
 src/service.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/src/service.c b/src/service.c
index 87ef3b575b1f..0c8a4bc0a0c9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1913,28 +1913,48 @@ static bool online_check_is_enabled_check(
  *                           "online" reachability check is to be
  *                           started.
  *
+ *  @retval  0          If successful.
+ *  @retval  -EINVAL    If @a service is null or @a type is invalid.
+ *  @retval  -EPERM     If online checks are disabled via
+ *                      configuration.
+ *
  *  @sa cancel_online_check
  *  @sa complete_online_check
  *  @sa start_wispr_if_connected
  *  @sa __connman_service_wispr_start
  *
  */
-static void start_online_check(struct connman_service *service,
+static int start_online_check(struct connman_service *service,
 				enum connman_ipconfig_type type)
 {
+	int status = 0;
+
 	DBG("service %p (%s) type %d (%s) maybe start WISPr",
 		service,
 		connman_service_get_identifier(service),
 		type,
 		__connman_ipconfig_type2string(type));
 
-	if (!online_check_is_enabled_check(service))
-		return;
+	if (!service) {
+		status = -EINVAL;
+		goto done;
+	}
+
+	if (!online_check_is_enabled_check(service)) {
+		status = -EPERM;
+		goto done;
+	}
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 || check_proxy_setup(service)) {
 		cancel_online_check(service, type);
-		__connman_service_wispr_start(service, type);
+
+		status = __connman_service_wispr_start(service, type);
 	}
+
+done:
+	DBG("status %d (%s)", status, strerror(-status));
+
+	return status;
 }
 
 /**
-- 
2.42.0

