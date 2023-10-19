Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48F3DFE5
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2ABCA7318D
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:39:57 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id EA22773248
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:39:56 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] Rename 'start_wispr_when_connected'.
Message-Id: <D769C836-3C52-4615-A17A-8CACAD0B0AE3@nuovations.com>
Date: Thu, 19 Oct 2023 14:39:55 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

The current name implies that a deferred action is "hooked" and that when
the service becomes "connected"; a WISPr-based reachability probe will
start. The revised name, 'start_wispr_if_connected' implies, correctly,
a one-shot chance to start WISPr if the service is "connected" at the
time of the call.

---
 src/service.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index 06d02322..31fe8917 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1602,7 +1602,7 @@ bool __connman_service_index_is_default(int index)
 	return __connman_service_get_index(service) == index;
 }
 
-static void start_wispr_when_connected(struct connman_service *service)
+static void start_wispr_if_connected(struct connman_service *service)
 {
 	if (!connman_setting_get_bool("EnableOnlineCheck")) {
 		connman_info("Online check disabled. "
@@ -1645,7 +1645,7 @@ static void default_changed(void)
 				connman_setting_get_bool("AllowDomainnameUpdates"))
 			__connman_utsname_set_domainname(service->domainname);
 
-		start_wispr_when_connected(service);
+		start_wispr_if_connected(service);
 
 		/*
 		 * Connect VPN automatically when new default service
@@ -3748,7 +3748,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 		nameserver_add_all(service, CONNMAN_IPCONFIG_TYPE_ALL);
 		dns_configuration_changed(service);
 
-		start_wispr_when_connected(service);
+		start_wispr_if_connected(service);
 
 		service_save(service);
 	} else if (g_str_equal(name, "Timeservers.Configuration")) {
-- 
2.32.0
