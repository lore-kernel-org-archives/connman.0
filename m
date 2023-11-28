Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942763D0C1
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5603F73140
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 13:51:39 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 0DBC873150
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 13:51:38 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] ipconfig: Const-qualify 'ipconfig' parameters.
Date: Tue, 28 Nov 2023 10:51:36 -0800
Message-ID: <20231128185136.1171884-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the ipconfig arguments of '__connman_ipconfig_get_gateway'
and '__connman_ipconfig_gateway_{add,remove}' to make it clear to the
compiler, static analyzers, and human readers that the functions have
no ipconfig mutation side effects.
---
 src/connman.h  | 6 +++---
 src/ipconfig.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index ae04cd9a26c6..344cb15af6a2 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -378,7 +378,7 @@ const char *__connman_ipconfig_get_peer(struct connman_ipconfig *ipconfig);
 void __connman_ipconfig_set_peer(struct connman_ipconfig *ipconfig, const char *address);
 const char *__connman_ipconfig_get_broadcast(struct connman_ipconfig *ipconfig);
 void __connman_ipconfig_set_broadcast(struct connman_ipconfig *ipconfig, const char *broadcast);
-const char *__connman_ipconfig_get_gateway(struct connman_ipconfig *ipconfig);
+const char *__connman_ipconfig_get_gateway(const struct connman_ipconfig *ipconfig);
 void __connman_ipconfig_set_gateway(struct connman_ipconfig *ipconfig, const char *gateway);
 unsigned char __connman_ipconfig_get_prefixlen(struct connman_ipconfig *ipconfig);
 void __connman_ipconfig_set_prefixlen(struct connman_ipconfig *ipconfig, unsigned char prefixlen);
@@ -410,8 +410,8 @@ enum connman_ipconfig_method __connman_ipconfig_get_method(
 int __connman_ipconfig_address_add(struct connman_ipconfig *ipconfig);
 int __connman_ipconfig_address_remove(struct connman_ipconfig *ipconfig);
 int __connman_ipconfig_address_unset(struct connman_ipconfig *ipconfig);
-int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig);
-void __connman_ipconfig_gateway_remove(struct connman_ipconfig *ipconfig);
+int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig);
+void __connman_ipconfig_gateway_remove(const struct connman_ipconfig *ipconfig);
 
 int __connman_ipconfig_set_proxy_autoconfig(struct connman_ipconfig *ipconfig,
 							const char *url);
diff --git a/src/ipconfig.c b/src/ipconfig.c
index 64a74310d450..25e86bca292b 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1302,7 +1302,7 @@ void __connman_ipconfig_set_broadcast(struct connman_ipconfig *ipconfig,
 	ipconfig->address->broadcast = g_strdup(broadcast);
 }
 
-const char *__connman_ipconfig_get_gateway(struct connman_ipconfig *ipconfig)
+const char *__connman_ipconfig_get_gateway(const struct connman_ipconfig *ipconfig)
 {
 	if (!ipconfig->address)
 		return NULL;
@@ -1321,7 +1321,7 @@ void __connman_ipconfig_set_gateway(struct connman_ipconfig *ipconfig,
 	ipconfig->address->gateway = g_strdup(gateway);
 }
 
-int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
+int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
 {
 	struct connman_service *service;
 
@@ -1347,7 +1347,7 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
 	return 0;
 }
 
-void __connman_ipconfig_gateway_remove(struct connman_ipconfig *ipconfig)
+void __connman_ipconfig_gateway_remove(const struct connman_ipconfig *ipconfig)
 {
 	struct connman_service *service;
 
-- 
2.42.0

