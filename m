Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E211719
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 135A073213
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:15 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C997A7321D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:14 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 12/60] service: Refactor 'start_online_check_if_connected'.
Date: Thu, 21 Dec 2023 14:34:19 -0800
Message-ID: <20231221223508.2365510-13-gerickson@nuovations.com>
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

This refactors 'start_online_check_if_connected' into a support
function, 'start_online_check_if_connected_with_type' to reduce
copy-and-paste and to make common, checking the 'type' parameter,
returning '-ENOTCONN' if the '__connman_service_is_connected_state'
predicate is false, and passing along return status from
'__connman_service_wispr_start'.
---
 src/service.c | 63 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/src/service.c b/src/service.c
index cd684fbc0b4f..b1880fbc6457 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2553,6 +2553,28 @@ static void complete_online_check(struct connman_service *service,
 		online_check_active_clear(service, type);
 }
 
+static int start_online_check_if_connected_with_type(
+					struct connman_service *service,
+					enum connman_ipconfig_type type)
+{
+	int status = 0;
+
+	switch (type) {
+	case CONNMAN_IPCONFIG_TYPE_IPV4:
+	case CONNMAN_IPCONFIG_TYPE_IPV6:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!__connman_service_is_connected_state(service, type))
+		status = -ENOTCONN;
+	else
+		status = __connman_service_wispr_start(service, type);
+
+	return status;
+}
+
 /**
  *  @brief
  *    Start HTTP-based Internet reachability probes if the specified
@@ -2562,21 +2584,34 @@ static void complete_online_check(struct connman_service *service,
  *  reachability probes if the IPv4 state or IPv6 state is connected
  *  (that is, "ready" or "online").
  *
- *  @param[in]  service  A pointer to a mutable service on which to start
- *                       reachability probes if the IPv4 or IPv6 state
- *                       is "connected" (that is, "ready" or "online").
+ *  @param[in,out]  service  A pointer to a mutable service on which
+ *                           to start "online" HTTP-based Internet
+ *                           reachability checks if the IPv4 or IPv6
+ *                           state is "connected" (that is, "ready" or
+ *                           "online").
  *
  *  @retval  0          If successful.
  *  @retval  -EINVAL    If @a service is null or @a type is invalid.
  *  @retval  -EPERM     If online checks are disabled via
  *                      configuration.
+ *  @retval  -ENOTCONN  If @a service is not "connected" (that is,
+ *                      "ready" or "online").
+ *  @retval  -EALEADY   If online checks are already active for @a
+ *                      service.
+ *
+ *  @sa start_online_check
+ *  @sa start_online_check_if_connected_with_type
  *
  */
 static int start_online_check_if_connected(struct connman_service *service)
 {
-	DBG("service %p (%s) maybe start WISPr",
+	int status4 = 0, status6 = 0;
+
+	DBG("service %p (%s) state4 %d (%s) state6 %d (%s) maybe start WISPr",
 		service,
-		connman_service_get_identifier(service));
+		connman_service_get_identifier(service),
+		service->state_ipv4, state2string(service->state_ipv4),
+		service->state_ipv6, state2string(service->state_ipv6));
 
 	if (!service)
 		return -EINVAL;
@@ -2584,17 +2619,17 @@ static int start_online_check_if_connected(struct connman_service *service)
 	if (!online_check_is_enabled_check(service))
 		return -EPERM;
 
-	if (__connman_service_is_connected_state(service,
-			CONNMAN_IPCONFIG_TYPE_IPV4))
-		__connman_service_wispr_start(service,
-					CONNMAN_IPCONFIG_TYPE_IPV4);
+	status4 = start_online_check_if_connected_with_type(service,
+			CONNMAN_IPCONFIG_TYPE_IPV4);
 
-	if (__connman_service_is_connected_state(service,
-			CONNMAN_IPCONFIG_TYPE_IPV6))
-		__connman_service_wispr_start(service,
-					CONNMAN_IPCONFIG_TYPE_IPV6);
+	status6 = start_online_check_if_connected_with_type(service,
+			CONNMAN_IPCONFIG_TYPE_IPV6);
 
-	return 0;
+	DBG("status4 %d (%s) status6 %d (%s)",
+		status4, strerror(-status4),
+		status6, strerror(-status6));
+
+	return (status4 < 0 ? status4 : status6);
 }
 
 /**
-- 
2.42.0

