Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E61328B6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B752B73206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:14 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 75E9C7321D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:14 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 41/90] ipconfig: Pass the rtnl metric to '__connman_ipconfig_{new,del}route'.
Date: Wed,  6 Dec 2023 15:50:05 -0800
Message-ID: <20231206235056.322578-43-gerickson@nuovations.com>
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
(rtnl) metric/priority to '__connman_ipconfig_{new,del}route' from
'process_{new,del}route'.
---
 src/connman.h  |  4 ++--
 src/ipconfig.c | 14 ++++++++------
 src/rtnl.c     | 22 ++++++++++++++--------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 35f11e92ac3c..397e0e42c7f8 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -368,10 +368,10 @@ void __connman_ipconfig_deladdr(int index, int family, const char *label,
 				unsigned char prefixlen, const char *address);
 void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
 					const char *dst, const char *gateway,
-					uint32_t table_id);
+					uint32_t table_id, uint32_t metric);
 void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
 					const char *dst, const char *gateway,
-					uint32_t table_id);
+					uint32_t table_id, uint32_t metric);
 
 void __connman_ipconfig_foreach(void (*function) (int index, void *user_data),
 							void *user_data);
diff --git a/src/ipconfig.c b/src/ipconfig.c
index 011367ec60c3..c23d7a5ab4d6 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1039,7 +1039,7 @@ out:
 
 void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
 					const char *dst, const char *gateway,
-					uint32_t table_id)
+					uint32_t table_id, uint32_t metric)
 {
 	struct connman_ipdevice *ipdevice;
 	char *ifname;
@@ -1100,9 +1100,10 @@ void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
 		}
 	}
 
-	connman_info("%s {add} route %s gw %s scope %u <%s> table %u <%s>",
+	connman_info("%s {add} route %s gw %s scope %u <%s> table %u <%s> "
+		"metric %u",
 		ifname, dst, gateway, scope, scope2str(scope),
-		table_id, __connman_inet_table2string(table_id));
+		table_id, __connman_inet_table2string(table_id), metric);
 
 out:
 	g_free(ifname);
@@ -1110,7 +1111,7 @@ out:
 
 void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
 					const char *dst, const char *gateway,
-					uint32_t table_id)
+					uint32_t table_id, uint32_t metric)
 {
 	struct connman_ipdevice *ipdevice;
 	char *ifname;
@@ -1169,9 +1170,10 @@ void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
 		}
 	}
 
-	connman_info("%s {del} route %s gw %s scope %u <%s> table %u <%s>",
+	connman_info("%s {del} route %s gw %s scope %u <%s> table %u <%s> "
+		"metric %u",
 		ifname, dst, gateway, scope, scope2str(scope),
-		table_id, __connman_inet_table2string(table_id));
+		table_id, __connman_inet_table2string(table_id), metric);
 
 out:
 	g_free(ifname);
diff --git a/src/rtnl.c b/src/rtnl.c
index fe53eb2eb5b6..596e8e4ae124 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -746,19 +746,21 @@ static void process_newroute(unsigned char family, unsigned char scope,
 	char dststr[INET6_ADDRSTRLEN], gatewaystr[INET6_ADDRSTRLEN];
 	int index = -1;
 	uint32_t table_id = RT_TABLE_UNSPEC;
+	uint32_t metric = 0;
 
 	if (family == AF_INET) {
 		struct in_addr dst = { INADDR_ANY }, gateway = { INADDR_ANY };
 
 		extract_ipv4_route(msg, bytes, &index, &dst, &gateway,
-			&table_id, NULL);
+			&table_id, &metric);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_newroute(index, family, scope, dststr,
 								gatewaystr,
-								table_id);
+								table_id,
+								metric);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -773,14 +775,15 @@ static void process_newroute(unsigned char family, unsigned char scope,
 				gateway = IN6ADDR_ANY_INIT;
 
 		extract_ipv6_route(msg, bytes, &index, &dst, &gateway,
-			&table_id, NULL);
+			&table_id, &metric);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_newroute(index, family, scope, dststr,
 								gatewaystr,
-								table_id);
+								table_id,
+								metric);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -808,19 +811,21 @@ static void process_delroute(unsigned char family, unsigned char scope,
 	char dststr[INET6_ADDRSTRLEN], gatewaystr[INET6_ADDRSTRLEN];
 	int index = -1;
 	uint32_t table_id = RT_TABLE_UNSPEC;
+	uint32_t metric = 0;
 
 	if (family == AF_INET) {
 		struct in_addr dst = { INADDR_ANY }, gateway = { INADDR_ANY };
 
 		extract_ipv4_route(msg, bytes, &index, &dst, &gateway,
-			&table_id, NULL);
+			&table_id, &metric);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_delroute(index, family, scope, dststr,
 								gatewaystr,
-								table_id);
+								table_id,
+								metric);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -835,14 +840,15 @@ static void process_delroute(unsigned char family, unsigned char scope,
 				gateway = IN6ADDR_ANY_INIT;
 
 		extract_ipv6_route(msg, bytes, &index, &dst, &gateway,
-			&table_id, NULL);
+			&table_id, &metric);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_delroute(index, family, scope, dststr,
 								gatewaystr,
-								table_id);
+								table_id,
+								metric);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
-- 
2.42.0

