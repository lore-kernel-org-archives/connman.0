Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE7BE7D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E389873200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:12 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A378E7321E
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:12 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 11/60] service: Rename 'start_wispr_if_connected'.
Date: Wed, 20 Dec 2023 22:39:15 -0800
Message-ID: <20231221064007.2347566-12-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221064007.2347566-1-gerickson@nuovations.com>
References: <20231221064007.2347566-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames 'start_wispr_if_connected' to
'start_online_check_if_connected' since it aligns more closely with
other '*_online_check' functions and simply uses WISPr to effect the
online check.
---
 src/service.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/service.c b/src/service.c
index cd1e56d0cf7a..cd684fbc0b4f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2046,7 +2046,7 @@ static void cancel_online_check(struct connman_service *service,
  *    enabled for the specified network service; otherwise, false.
  *
  *  @sa start_online_check
- *  @sa start_wispr_if_connected
+ *  @sa start_online_check_if_connected
  *
  */
 static bool online_check_is_enabled_check(
@@ -2090,7 +2090,7 @@ static bool online_check_is_enabled_check(
  *
  *  @sa cancel_online_check
  *  @sa complete_online_check
- *  @sa start_wispr_if_connected
+ *  @sa start_online_check_if_connected
  *  @sa __connman_service_wispr_start
  *
  */
@@ -2503,7 +2503,7 @@ done:
  *
  *  @sa cancel_online_check
  *  @sa start_online_check
- *  @sa start_wispr_if_connected
+ *  @sa start_online_check_if_connected
  *  @sa __connman_service_wispr_start
  *
  */
@@ -2572,7 +2572,7 @@ static void complete_online_check(struct connman_service *service,
  *                      configuration.
  *
  */
-static int start_wispr_if_connected(struct connman_service *service)
+static int start_online_check_if_connected(struct connman_service *service)
 {
 	DBG("service %p (%s) maybe start WISPr",
 		service,
@@ -2621,7 +2621,7 @@ static int start_wispr_if_connected(struct connman_service *service)
  *  @sa cancel_online_check
  *  @sa start_online_check
  *  @sa complete_online_check
- *  @sa start_wispr_if_connected
+ *  @sa start_online_check_if_connected
  *
  */
 int __connman_service_wispr_start(struct connman_service *service,
@@ -2908,7 +2908,7 @@ static void default_changed(void)
 				connman_setting_get_bool("AllowDomainnameUpdates"))
 			__connman_utsname_set_domainname(service->domainname);
 
-		start_wispr_if_connected(service);
+		start_online_check_if_connected(service);
 
 		/*
 		 * Connect VPN automatically when new default service
@@ -4927,7 +4927,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 		nameserver_add_all(service, CONNMAN_IPCONFIG_TYPE_ALL);
 		dns_configuration_changed(service);
 
-		start_wispr_if_connected(service);
+		start_online_check_if_connected(service);
 
 		service_save(service);
 	} else if (g_str_equal(name, "Timeservers.Configuration")) {
-- 
2.42.0

