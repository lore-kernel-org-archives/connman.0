Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6C328C5
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 94B3373202
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:13 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 51E8A73219
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:13 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 39/90] ipconfig: Pass the rtnl table to '__connman_ipconfig_{new,del}route'.
Date: Wed,  6 Dec 2023 15:50:02 -0800
Message-ID: <20231206235056.322578-40-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206235056.322578-1-gerickson@nuovations.com>
References: <20231206235056.322578-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

From: Grant Erickson <erick205@umn.edu>

This adds support for extracting and passing the Routing Netlink
(rtnl) table identifier to '__connman_ipconfig_{new,del}route' from
'process_{new,del}route'.
---
 src/connman.h  |  6 ++++--
 src/ipconfig.c | 16 ++++++++++------
 src/rtnl.c     | 22 ++++++++++++++--------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 19de86346565..35f11e92ac3c 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -367,9 +367,11 @@ int __connman_ipconfig_newaddr(int index, int family, const char *label,
 void __connman_ipconfig_deladdr(int index, int family, const char *label,
 				unsigned char prefixlen, const char *address);
 void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
-					const char *dst, const char *gateway);
+					const char *dst, const char *gateway,
+					uint32_t table_id);
 void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
-					const char *dst, const char *gateway);
+					const char *dst, const char *gateway,
+					uint32_t table_id);
 
 void __connman_ipconfig_foreach(void (*function) (int index, void *user_data),
 							void *user_data);
diff --git a/src/ipconfig.c b/src/ipconfig.c
index 0f40ac207016..011367ec60c3 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1038,7 +1038,8 @@ out:
 }
 
 void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
-					const char *dst, const char *gateway)
+					const char *dst, const char *gateway,
+					uint32_t table_id)
 {
 	struct connman_ipdevice *ipdevice;
 	char *ifname;
@@ -1099,15 +1100,17 @@ void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
 		}
 	}
 
-	connman_info("%s {add} route %s gw %s scope %u <%s>",
-		ifname, dst, gateway, scope, scope2str(scope));
+	connman_info("%s {add} route %s gw %s scope %u <%s> table %u <%s>",
+		ifname, dst, gateway, scope, scope2str(scope),
+		table_id, __connman_inet_table2string(table_id));
 
 out:
 	g_free(ifname);
 }
 
 void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
-					const char *dst, const char *gateway)
+					const char *dst, const char *gateway,
+					uint32_t table_id)
 {
 	struct connman_ipdevice *ipdevice;
 	char *ifname;
@@ -1166,8 +1169,9 @@ void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
 		}
 	}
 
-	connman_info("%s {del} route %s gw %s scope %u <%s>",
-		ifname, dst, gateway, scope, scope2str(scope));
+	connman_info("%s {del} route %s gw %s scope %u <%s> table %u <%s>",
+		ifname, dst, gateway, scope, scope2str(scope),
+		table_id, __connman_inet_table2string(table_id));
 
 out:
 	g_free(ifname);
diff --git a/src/rtnl.c b/src/rtnl.c
index 056107831038..eb0ba63961cd 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -735,18 +735,20 @@ static void process_newroute(unsigned char family, unsigned char scope,
 	GSList *list;
 	char dststr[INET6_ADDRSTRLEN], gatewaystr[INET6_ADDRSTRLEN];
 	int index = -1;
+	uint32_t table_id = RT_TABLE_UNSPEC;
 
 	if (family == AF_INET) {
 		struct in_addr dst = { INADDR_ANY }, gateway = { INADDR_ANY };
 
 		extract_ipv4_route(msg, bytes, &index, &dst, &gateway,
-			NULL);
+			&table_id);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_newroute(index, family, scope, dststr,
-								gatewaystr);
+								gatewaystr,
+								table_id);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -761,13 +763,14 @@ static void process_newroute(unsigned char family, unsigned char scope,
 				gateway = IN6ADDR_ANY_INIT;
 
 		extract_ipv6_route(msg, bytes, &index, &dst, &gateway,
-			NULL);
+			&table_id);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_newroute(index, family, scope, dststr,
-								gatewaystr);
+								gatewaystr,
+								table_id);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -794,18 +797,20 @@ static void process_delroute(unsigned char family, unsigned char scope,
 	GSList *list;
 	char dststr[INET6_ADDRSTRLEN], gatewaystr[INET6_ADDRSTRLEN];
 	int index = -1;
+	uint32_t table_id = RT_TABLE_UNSPEC;
 
 	if (family == AF_INET) {
 		struct in_addr dst = { INADDR_ANY }, gateway = { INADDR_ANY };
 
 		extract_ipv4_route(msg, bytes, &index, &dst, &gateway,
-			NULL);
+			&table_id);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_delroute(index, family, scope, dststr,
-								gatewaystr);
+								gatewaystr,
+								table_id);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -820,13 +825,14 @@ static void process_delroute(unsigned char family, unsigned char scope,
 				gateway = IN6ADDR_ANY_INIT;
 
 		extract_ipv6_route(msg, bytes, &index, &dst, &gateway,
-			NULL);
+			&table_id);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_delroute(index, family, scope, dststr,
-						gatewaystr);
+								gatewaystr,
+								table_id);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
-- 
2.42.0

