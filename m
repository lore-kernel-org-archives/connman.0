Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771CE328DE
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D7BE173214
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:15 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9AD9673225
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 42/90] ipconfig: Pass the rtnl dst prefixlen to to '__connman_ipconfig_{new,del}route'.
Date: Wed,  6 Dec 2023 15:50:08 -0800
Message-ID: <20231206235056.322578-46-gerickson@nuovations.com>
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
(rtnl) destination prefix length to
'__connman_ipconfig_{new,del}route' from 'process_{new,del}route'.
---
 src/connman.h  |  8 ++++++--
 src/ipconfig.c | 16 ++++++++++------
 src/rtnl.c     | 28 ++++++++++++++++------------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 397e0e42c7f8..d9ce353c4df4 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -367,10 +367,14 @@ int __connman_ipconfig_newaddr(int index, int family, const char *label,
 void __connman_ipconfig_deladdr(int index, int family, const char *label,
 				unsigned char prefixlen, const char *address);
 void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
-					const char *dst, const char *gateway,
+					const char *dst,
+					unsigned char dst_prefixlen,
+					const char *gateway,
 					uint32_t table_id, uint32_t metric);
 void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
-					const char *dst, const char *gateway,
+					const char *dst,
+					unsigned char dst_prefixlen,
+					const char *gateway,
 					uint32_t table_id, uint32_t metric);
 
 void __connman_ipconfig_foreach(void (*function) (int index, void *user_data),
diff --git a/src/ipconfig.c b/src/ipconfig.c
index c23d7a5ab4d6..55a05694ff14 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1038,7 +1038,9 @@ out:
 }
 
 void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
-					const char *dst, const char *gateway,
+					const char *dst,
+					unsigned char dst_prefixlen,
+					const char *gateway,
 					uint32_t table_id, uint32_t metric)
 {
 	struct connman_ipdevice *ipdevice;
@@ -1100,9 +1102,9 @@ void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
 		}
 	}
 
-	connman_info("%s {add} route %s gw %s scope %u <%s> table %u <%s> "
+	connman_info("%s {add} route %s/%u gw %s scope %u <%s> table %u <%s> "
 		"metric %u",
-		ifname, dst, gateway, scope, scope2str(scope),
+		ifname, dst, dst_prefixlen, gateway, scope, scope2str(scope),
 		table_id, __connman_inet_table2string(table_id), metric);
 
 out:
@@ -1110,7 +1112,9 @@ out:
 }
 
 void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
-					const char *dst, const char *gateway,
+					const char *dst,
+					unsigned char dst_prefixlen,
+					const char *gateway,
 					uint32_t table_id, uint32_t metric)
 {
 	struct connman_ipdevice *ipdevice;
@@ -1170,9 +1174,9 @@ void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
 		}
 	}
 
-	connman_info("%s {del} route %s gw %s scope %u <%s> table %u <%s> "
+	connman_info("%s {del} route %s/%u gw %s scope %u <%s> table %u <%s> "
 		"metric %u",
-		ifname, dst, gateway, scope, scope2str(scope),
+		ifname, dst, dst_prefixlen, gateway, scope, scope2str(scope),
 		table_id, __connman_inet_table2string(table_id), metric);
 
 out:
diff --git a/src/rtnl.c b/src/rtnl.c
index 596e8e4ae124..a28370ae0f0f 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -758,9 +758,10 @@ static void process_newroute(unsigned char family, unsigned char scope,
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_newroute(index, family, scope, dststr,
-								gatewaystr,
-								table_id,
-								metric);
+							msg->rtm_dst_len,
+							gatewaystr,
+							table_id,
+							metric);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -781,9 +782,10 @@ static void process_newroute(unsigned char family, unsigned char scope,
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_newroute(index, family, scope, dststr,
-								gatewaystr,
-								table_id,
-								metric);
+							msg->rtm_dst_len,
+							gatewaystr,
+							table_id,
+							metric);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -823,9 +825,10 @@ static void process_delroute(unsigned char family, unsigned char scope,
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_delroute(index, family, scope, dststr,
-								gatewaystr,
-								table_id,
-								metric);
+							msg->rtm_dst_len,
+							gatewaystr,
+							table_id,
+							metric);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
@@ -846,9 +849,10 @@ static void process_delroute(unsigned char family, unsigned char scope,
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
 
 		__connman_ipconfig_delroute(index, family, scope, dststr,
-								gatewaystr,
-								table_id,
-								metric);
+							msg->rtm_dst_len,
+							gatewaystr,
+							table_id,
+							metric);
 
 		/* skip host specific routes */
 		if (scope != RT_SCOPE_UNIVERSE &&
-- 
2.42.0

