Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EE156D0
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B0E0D731F7
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:36 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7196273203
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:36 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/60] service: Change return type of '__connman_service_wispr_start'.
Date: Wed, 20 Dec 2023 22:16:24 -0800
Message-ID: <20231221061734.2344286-2-gerickson@nuovations.com>
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

This changes the return type of '__connman_service_wispr_start' to
allow callers to conditionally handle its return status which, as of
this revision, is fairly simple but will be expanded over time.
---
 src/connman.h |  2 +-
 src/service.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 622a778590b1..796cb202570e 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -743,7 +743,7 @@ struct connman_ipconfig *__connman_service_get_ipconfig(
 				struct connman_service *service, int family);
 void __connman_service_notify_ipv4_configuration(
 				struct connman_service *service);
-void __connman_service_wispr_start(struct connman_service *service,
+int __connman_service_wispr_start(struct connman_service *service,
                                 enum connman_ipconfig_type type);
 bool __connman_service_is_connected_state(const struct connman_service *service,
 					enum connman_ipconfig_type type);
diff --git a/src/service.c b/src/service.c
index 8e057e051d63..7af0d4a5f60c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2410,13 +2410,16 @@ static void start_wispr_if_connected(struct connman_service *service)
  *                           "online" reachability check is to be
  *                           started.
  *
+ *  @retval  0          If successful.
+ *  @retval  -EINVAL    If @a service is null or @a type is invalid.
+ *
  *  @sa cancel_online_check
  *  @sa start_online_check
  *  @sa complete_online_check
  *  @sa start_wispr_if_connected
  *
  */
-void __connman_service_wispr_start(struct connman_service *service,
+int __connman_service_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
 	DBG("service %p (%s) type %d (%s)",
@@ -2424,6 +2427,9 @@ void __connman_service_wispr_start(struct connman_service *service,
 		connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type));
 
+	if (!service)
+		return -EINVAL;
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		service->online_check_state_ipv4.interval =
 					online_check_initial_interval;
@@ -2433,6 +2439,8 @@ void __connman_service_wispr_start(struct connman_service *service,
 
 	__connman_wispr_start(service, type,
 			online_check_connect_timeout_ms, complete_online_check);
+
+	return 0;
 }
 
 /**
-- 
2.42.0

