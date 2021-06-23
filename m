Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E9173
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 07:23:01 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 76C0E50064D;
	Wed, 23 Jun 2021 09:22:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 25B13500412;
	Wed, 23 Jun 2021 09:22:59 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] iwd: Do not try to handle out of memory fails
Date: Wed, 23 Jun 2021 09:22:54 +0200
Message-Id: <20210623072254.30338-1-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is little point in trying to handle out of memory
situation. Most GLib function do fail with calling abort() when memory
allocation fails, e.g. g_strdup(). So fail hard when allocation the
iwd data structures.
---
 plugins/iwd.c | 44 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 38 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 4ba107f3e113..14a442a7b67c 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -1372,13 +1372,7 @@ static void create_adapter(GDBusProxy *proxy)
 	struct iwd_adapter *iwda;
 	GSList *modes, *list;
 
-	iwda = g_try_new0(struct iwd_adapter, 1);
-
-	if (!iwda) {
-		connman_error("Out of memory creating IWD adapter");
-		return;
-	}
-
+	iwda = g_new0(struct iwd_adapter, 1);
 	iwda->path = g_strdup(path);
 	g_hash_table_replace(adapters, iwda->path, iwda);
 
@@ -1423,13 +1417,7 @@ static void create_device(GDBusProxy *proxy)
 	const char *path = g_dbus_proxy_get_path(proxy);
 	struct iwd_device *iwdd;
 
-	iwdd = g_try_new0(struct iwd_device, 1);
-
-	if (!iwdd) {
-		connman_error("Out of memory creating IWD device");
-		return;
-	}
-
+	iwdd = g_new0(struct iwd_device, 1);
 	iwdd->path = g_strdup(path);
 	g_hash_table_replace(devices, iwdd->path, iwdd);
 
@@ -1596,13 +1584,7 @@ static void create_network(GDBusProxy *proxy)
 	const char *path = g_dbus_proxy_get_path(proxy);
 	struct iwd_network *iwdn;
 
-	iwdn = g_try_new0(struct iwd_network, 1);
-
-	if (!iwdn) {
-		connman_error("Out of memory creating IWD network");
-		return;
-	}
-
+	iwdn = g_new0(struct iwd_network, 1);
 	iwdn->path = g_strdup(path);
 	g_hash_table_replace(networks, iwdn->path, iwdn);
 
@@ -1682,12 +1664,7 @@ static void create_know_network(GDBusProxy *proxy)
 	const char *path = g_dbus_proxy_get_path(proxy);
 	struct iwd_known_network *iwdkn;
 
-	iwdkn = g_try_new0(struct iwd_known_network, 1);
-	if (!iwdkn) {
-		connman_error("Out of memory creating IWD known network");
-		return;
-	}
-
+	iwdkn = g_new0(struct iwd_known_network, 1);
 	iwdkn->path = g_strdup(path);
 	g_hash_table_replace(known_networks, iwdkn->path, iwdkn);
 
@@ -1721,12 +1698,7 @@ static void create_station(GDBusProxy *proxy)
 	const char *path = g_dbus_proxy_get_path(proxy);
 	struct iwd_station *iwds;
 
-	iwds = g_try_new0(struct iwd_station, 1);
-	if (!iwds) {
-		connman_error("Out of memory creating IWD station");
-		return;
-	}
-
+	iwds = g_new0(struct iwd_station, 1);
 	iwds->path = g_strdup(path);
 	g_hash_table_replace(stations, iwds->path, iwds);
 
@@ -1754,11 +1726,7 @@ static void create_ap(GDBusProxy *proxy)
 	const char *path = g_dbus_proxy_get_path(proxy);
 	struct iwd_ap *iwdap;
 
-	iwdap = g_try_new0(struct iwd_ap, 1);
-	if (!iwdap) {
-		connman_error("Out of memory creating IWD access point");
-		return;
-	}
+	iwdap = g_new0(struct iwd_ap, 1);
 	iwdap->index = -1;
 
 	iwdap->path = g_strdup(path);
-- 
2.32.0
