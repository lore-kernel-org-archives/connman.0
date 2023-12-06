Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E2328C2
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 32DD073200
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:13 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E7D4D73206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:12 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 38/90] rtnl: Add support for extracting the table identifier.
Date: Wed,  6 Dec 2023 15:50:01 -0800
Message-ID: <20231206235056.322578-39-gerickson@nuovations.com>
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
identifier attribute from rtnl messages.
---
 src/rtnl.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/src/rtnl.c b/src/rtnl.c
index e8a8325ee22b..056107831038 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -670,7 +670,8 @@ static void process_deladdr(unsigned char family, unsigned char prefixlen,
 
 static void extract_ipv4_route(struct rtmsg *msg, int bytes, int *index,
 						struct in_addr *dst,
-						struct in_addr *gateway)
+						struct in_addr *gateway,
+						uint32_t *table_id)
 {
 	struct rtattr *attr;
 
@@ -689,13 +690,18 @@ static void extract_ipv4_route(struct rtmsg *msg, int bytes, int *index,
 			if (index)
 				*index = *((int *) RTA_DATA(attr));
 			break;
+		case RTA_TABLE:
+			if (table_id)
+				*table_id = *((uint32_t *) RTA_DATA(attr));
+			break;
 		}
 	}
 }
 
 static void extract_ipv6_route(struct rtmsg *msg, int bytes, int *index,
 						struct in6_addr *dst,
-						struct in6_addr *gateway)
+						struct in6_addr *gateway,
+						uint32_t *table_id)
 {
 	struct rtattr *attr;
 
@@ -715,6 +721,10 @@ static void extract_ipv6_route(struct rtmsg *msg, int bytes, int *index,
 			if (index)
 				*index = *((int *) RTA_DATA(attr));
 			break;
+		case RTA_TABLE:
+			if (table_id)
+				*table_id = *((uint32_t *) RTA_DATA(attr));
+			break;
 		}
 	}
 }
@@ -729,7 +739,8 @@ static void process_newroute(unsigned char family, unsigned char scope,
 	if (family == AF_INET) {
 		struct in_addr dst = { INADDR_ANY }, gateway = { INADDR_ANY };
 
-		extract_ipv4_route(msg, bytes, &index, &dst, &gateway);
+		extract_ipv4_route(msg, bytes, &index, &dst, &gateway,
+			NULL);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
@@ -749,7 +760,8 @@ static void process_newroute(unsigned char family, unsigned char scope,
 		struct in6_addr dst = IN6ADDR_ANY_INIT,
 				gateway = IN6ADDR_ANY_INIT;
 
-		extract_ipv6_route(msg, bytes, &index, &dst, &gateway);
+		extract_ipv6_route(msg, bytes, &index, &dst, &gateway,
+			NULL);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
@@ -786,7 +798,8 @@ static void process_delroute(unsigned char family, unsigned char scope,
 	if (family == AF_INET) {
 		struct in_addr dst = { INADDR_ANY }, gateway = { INADDR_ANY };
 
-		extract_ipv4_route(msg, bytes, &index, &dst, &gateway);
+		extract_ipv4_route(msg, bytes, &index, &dst, &gateway,
+			NULL);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
@@ -806,7 +819,8 @@ static void process_delroute(unsigned char family, unsigned char scope,
 		struct in6_addr dst = IN6ADDR_ANY_INIT,
 				gateway = IN6ADDR_ANY_INIT;
 
-		extract_ipv6_route(msg, bytes, &index, &dst, &gateway);
+		extract_ipv6_route(msg, bytes, &index, &dst, &gateway,
+			NULL);
 
 		inet_ntop(family, &dst, dststr, sizeof(dststr));
 		inet_ntop(family, &gateway, gatewaystr, sizeof(gatewaystr));
-- 
2.42.0

