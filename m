Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771418040
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0CD9D73200
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:21 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B9F3C73206
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 11/17] service: Add IP configuration type to 'cancel_online_check'.
Date: Sun, 19 Nov 2023 09:07:07 -0800
Message-ID: <20231119170714.775270-12-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119170714.775270-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
 <20231119170714.775270-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

WISPr / portal detection and HTTP-based "online" Internet reachability
checks are, by design, IP configuration-specific. There may be parallel,
independent requests or checks in flight: one for IPv4 and one for IPv6.
Consequently, when attempting to cancel such requests or checks, require
the IP configuration type to indicate which specific request or check is
to be canceled.
---
 src/service.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/src/service.c b/src/service.c
index 0882cd167699..d78ed0123160 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1559,11 +1559,11 @@ static guint online_check_timeout_compute_geometric(unsigned int interval)
 /**
  *  @brief
  *    Cancel any "online" HTTP-based Internet reachability checks for
- *    the specified network service.
+ *    the specified network service IP configuration type.
  *
  *  This cancels any current or pending IPv4 and/or IPv6 "online"
  *  HTTP-based Internet reachability checks for the specified network
- *  service.
+ *  service IP configuration type.
  *
  *  @note
  *    Any lingering WISPr portal reachability context will be lazily
@@ -1574,6 +1574,9 @@ static guint online_check_timeout_compute_geometric(unsigned int interval)
  *                           for which any current or pending IPv4 or
  *                           IPv6 "online" reachability checks should
  *                           be canceled.
+ *  @param[in]      type     The IP configuration type for which the
+ *                           "online" reachability check is to be
+ *                           canceled.
  *
  *  @sa start_online_check
  *  @sa complete_online_check
@@ -1581,14 +1584,18 @@ static guint online_check_timeout_compute_geometric(unsigned int interval)
  *  @sa __connman_wispr_stop
  *
  */
-static void cancel_online_check(struct connman_service *service)
+static void cancel_online_check(struct connman_service *service,
+				enum connman_ipconfig_type type)
 {
-	DBG("service %p (%s) online_timeout_ipv4 %d online_timeout_ipv6 %d",
+	DBG("service %p (%s) type %d (%s) "
+		"online_timeout_ipv4 %d online_timeout_ipv6 %d",
 		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
 		service->online_timeout_ipv4,
 		service->online_timeout_ipv6);
 
-	if (service->online_timeout_ipv4) {
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
+		service->online_timeout_ipv4) {
 		g_source_remove(service->online_timeout_ipv4);
 		service->online_timeout_ipv4 = 0;
 
@@ -1598,8 +1605,8 @@ static void cancel_online_check(struct connman_service *service)
 		 * now-cancelled scheduled online check.
 		 */
 		connman_service_unref(service);
-	}
-	if (service->online_timeout_ipv6) {
+	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
+		service->online_timeout_ipv6) {
 		g_source_remove(service->online_timeout_ipv6);
 		service->online_timeout_ipv6 = 0;
 
@@ -1683,7 +1690,7 @@ static void start_online_check(struct connman_service *service,
 		return;
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 || check_proxy_setup(service)) {
-		cancel_online_check(service);
+		cancel_online_check(service, type);
 		__connman_service_wispr_start(service, type);
 	}
 }
@@ -7185,7 +7192,7 @@ int __connman_service_ipconfig_indicate_state(struct connman_service *service,
 
 	if (is_connected(old_state) && !is_connected(new_state)) {
 		nameserver_remove_all(service, type);
-		cancel_online_check(service);
+		cancel_online_check(service, type);
 	}
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
-- 
2.42.0

