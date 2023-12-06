Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D65328D2
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 55CF373203
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:14 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1871A7321A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:14 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 40/90] rtnl: Add support for extracting the metric/priority.
Date: Wed,  6 Dec 2023 15:50:04 -0800
Message-ID: <20231206235056.322578-42-gerickson@nuovations.com>
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

This adds support for extracting the Routing Netlink (rtnl) table
metric/priority attribute from rtnl messages.
---
 src/rtnl.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/src/rtnl.c b/src/rtnl.c
index eb0ba63961cd..fe53eb2eb5b6 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -671,7 +671,8 @@ static void process_deladdr(unsigned char family, unsigned char prefixlen,
 static void extract_ipv4_route(struct rtmsg *msg, int bytes, int *index,
 						struct in_addr *dst,
 						struct in_addr *gateway,
-						uint32_t *table_id)
+						uint32_t *table_id,
+						uint32_t *metric)
 {
 	struct rtattr *attr;
 
@@ -694,6 +695,10 @@ static void extract_ipv4_route(struct rtmsg *msg, int bytes, int *index,
 			if (table_id)
 				*table_id = *((uint32_t *) RTA_DATA(attr));
 			break;
+		case RTA_PRIORITY:
+			if (metric)
+				*metric = *((uint32_t *) RTA_DATA(attr));
+			break;
 		}
 	}
 }
@@ -701,7 +706,8 @@ static void extract_ipv4_route(struct rtmsg *msg, int bytes, int *index,
 static void extract_ipv6_route(struct rtmsg *msg, int bytes, int *index,
 						struct in6_addr *dst,
 						struct in6_addr *gateway,
-						uint32_t *table_id)
+						uint32_t *table_id,
+						uint32_t *metric)
 {
 	struct rtattr *attr;
 
@@ -725,6 +731,10 @@ static void extract_ipv6_route(struct rtmsg *msg, int bytes, int *index,
 			if (table_id)
 				*table_id = *((uint32_t *) RTA_DATA(attr));
 			break;
+		case RTA_PRIORITY:
+			if (metric)
+				*metric = *((uint32_t *) RTA_DATA(attr));
+			break;
 		}
 	}
 }
@@ -741,7 +751,7 @@ static void process_newroute(unsigned char family, unsigned char scope,
 		struct in_addr dst = { INADDR_ANY }, gateway = { INADDR_ANY };
 
 		extract_ipv4_route(msg, bytes, &index, &dst, &gateway,
-			&table_id);
+			&table_id, NULL);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
@@ -763,7 +773,7 @@ static void process_newroute(unsigned char family, unsigned char scope,
 				gateway = IN6ADDR_ANY_INIT;
 
 		extract_ipv6_route(msg, bytes, &index, &dst, &gateway,
-			&table_id);
+			&table_id, NULL);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
@@ -803,7 +813,7 @@ static void process_delroute(unsigned char family, unsigned char scope,
 		struct in_addr dst = { INADDR_ANY }, gateway = { INADDR_ANY };
 
 		extract_ipv4_route(msg, bytes, &index, &dst, &gateway,
-			&table_id);
+			&table_id, NULL);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
@@ -825,7 +835,7 @@ static void process_delroute(unsigned char family, unsigned char scope,
 				gateway = IN6ADDR_ANY_INIT;
 
 		extract_ipv6_route(msg, bytes, &index, &dst, &gateway,
-			&table_id);
+			&table_id, NULL);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
-- 
2.42.0

