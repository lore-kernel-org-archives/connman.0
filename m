Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BA20F7
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0AC7A73144
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 21:16:55 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C26A073159
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 21:16:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] service: Add support for 'CONNMAN_IPCONFIG_TYPE_ALL' to 'cancel_online_check'.
Date: Thu, 14 Dec 2023 18:16:52 -0800
Message-ID: <20231215021653.2156275-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215021653.2156275-1-gerickson@nuovations.com>
References: <20231215021653.2156275-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds support for passing 'CONNMAN_IPCONFIG_TYPE_ALL' to
'cancel_online_check' as the IP configuration type parameter to allow
for canceling both IPv4 and IPv6 checks in a single function call.
---
 src/service.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/src/service.c b/src/service.c
index 5ead14ac6d98..6f816ac7af01 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1615,6 +1615,8 @@ static guint online_check_timeout_compute_geometric(unsigned int interval)
 static void cancel_online_check(struct connman_service *service,
 				enum connman_ipconfig_type type)
 {
+	bool do_ipv4 = false, do_ipv6 = false;
+
 	DBG("service %p (%s) type %d (%s) "
 		"online_timeout_ipv4 %d online_timeout_ipv6 %d",
 		service, connman_service_get_identifier(service),
@@ -1622,20 +1624,34 @@ static void cancel_online_check(struct connman_service *service,
 		service->online_check_state_ipv4.timeout,
 		service->online_check_state_ipv6.timeout);
 
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+		do_ipv4 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+		do_ipv6 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
+		do_ipv4 = do_ipv6 = true;
+	else
+		return;
+
 	/*
-	 * First, ensure that the reachability check is cancelled in the
-	 * WISPr module. This may fail, however, we ignore any such
-	 * failures as we still want to cancel any outstanding check from
-	 * this module as well.
+	 * First, ensure that the reachability check(s) is/are cancelled
+	 * in the WISPr module. This may fail, however, we ignore any such
+	 * failures as we still want to cancel any outstanding check(s)
+	 * from this module as well.
 	 */
-	__connman_wispr_cancel(service, type);
+
+	if (do_ipv4)
+		__connman_wispr_cancel(service, CONNMAN_IPCONFIG_TYPE_IPV4);
+
+	if (do_ipv6)
+		__connman_wispr_cancel(service, CONNMAN_IPCONFIG_TYPE_IPV6);
 
 	/*
-	 * Now that the reachability check has been cancelled in the WISPr
-	 * module, cancel any outstanding check that may be scheduled in
-	 * this module.
+	 * Now that the reachability check(s) has/have been cancelled in
+	 * the WISPr module, cancel any outstanding check(s) that may be
+	 * scheduled in this module.
 	 */
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
+	if (do_ipv4 &&
 		service->online_check_state_ipv4.timeout) {
 		g_source_remove(service->online_check_state_ipv4.timeout);
 		service->online_check_state_ipv4.timeout = 0;
@@ -1646,7 +1662,9 @@ static void cancel_online_check(struct connman_service *service,
 		 * now-cancelled scheduled online check.
 		 */
 		connman_service_unref(service);
-	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
+	}
+
+	if (do_ipv6 &&
 		service->online_check_state_ipv6.timeout) {
 		g_source_remove(service->online_check_state_ipv6.timeout);
 		service->online_check_state_ipv6.timeout = 0;
-- 
2.42.0

