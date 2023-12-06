Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CF328C7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6B77F73219
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:17 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2EE8373225
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 46/90] inet: Add a metric parameter to 'iproute_default_modify'.
Date: Wed,  6 Dec 2023 15:50:12 -0800
Message-ID: <20231206235056.322578-50-gerickson@nuovations.com>
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

This adds a Routing Netlink (rtnl) metric/priority parameter to
'iproute_default_modify'.
---
 src/inet.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/src/inet.c b/src/inet.c
index 4882f9b78205..650eb9cbadf1 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -3208,8 +3208,9 @@ static const char *rtnl_route_cmd2string(int cmd)
 	return "";
 }
 
-static int iproute_default_modify(int cmd, uint32_t table_id, int ifindex,
-			const char *gateway, unsigned char prefixlen)
+static int iproute_default_modify(int cmd, uint32_t table_id, uint32_t metric,
+			int ifindex, const char *gateway,
+			unsigned char prefixlen)
 {
 	struct __connman_inet_rtnl_handle rth;
 	unsigned char buf[sizeof(struct in6_addr)];
@@ -3220,11 +3221,12 @@ static int iproute_default_modify(int cmd, uint32_t table_id, int ifindex,
 
 	interface = connman_inet_ifname(ifindex);
 
-	DBG("cmd %d (%s) ifindex %d (%s) gateway %s/%u table %u <%s>",
+	DBG("cmd %d (%s) ifindex %d (%s) gateway %s/%u table %u <%s> metric %u",
 		cmd, rtnl_route_cmd2string(cmd),
 		ifindex, interface,
 		gateway, prefixlen,
-		table_id, __connman_inet_table2string(table_id));
+		table_id, __connman_inet_table2string(table_id),
+		metric);
 
 	switch (family) {
 	case AF_INET:
@@ -3280,6 +3282,9 @@ static int iproute_default_modify(int cmd, uint32_t table_id, int ifindex,
 	__connman_inet_rtnl_addattr32(&rth.req.n, sizeof(rth.req),
 							RTA_OIF, ifindex);
 
+	__connman_inet_rtnl_addattr32(&rth.req.n, sizeof(rth.req),
+							RTA_PRIORITY, metric);
+
 	ret = __connman_inet_rtnl_open(&rth);
 	if (ret < 0)
 		goto done;
@@ -3295,31 +3300,49 @@ done:
 int __connman_inet_add_default_to_table(uint32_t table_id, int ifindex,
 						const char *gateway)
 {
-	/* ip route add default via 1.2.3.4 dev wlan0 table 1234 */
+	static const uint32_t metric = 0;
+	static const unsigned char prefixlen = 0;
 
-	return iproute_default_modify(RTM_NEWROUTE, table_id, ifindex, gateway, 0);
+	/*
+	 * ip route add default/0 via <gateway> dev wlan0 table <table_id>
+	 * metric 0
+	 */
+	return iproute_default_modify(RTM_NEWROUTE, table_id, metric, ifindex,
+		gateway, prefixlen);
 }
 
 int __connman_inet_add_subnet_to_table(uint32_t table_id, int ifindex,
 						const char *gateway, unsigned char prefixlen)
 {
-	/* ip route add 1.2.3.4/24 dev eth0 table 1234 */
-	return iproute_default_modify(RTM_NEWROUTE, table_id, ifindex, gateway, prefixlen);
+	static const uint32_t metric = 0;
+
+	/* ip route add 1.2.3.4/24 dev eth0 table 1234 metric 0 */
+	return iproute_default_modify(RTM_NEWROUTE, table_id, metric, ifindex,
+		gateway, prefixlen);
 }
 
 int __connman_inet_del_default_from_table(uint32_t table_id, int ifindex,
 						const char *gateway)
 {
-	/* ip route del default via 1.2.3.4 dev wlan0 table 1234 */
+	static const uint32_t metric = 0;
+	static const unsigned char prefixlen = 0;
 
-	return iproute_default_modify(RTM_DELROUTE, table_id, ifindex, gateway, 0);
+	/*
+	 * ip route del default/0 via <gateway> dev wlan0 table <table_id>
+	 * metric 0
+	 */
+	return iproute_default_modify(RTM_DELROUTE, table_id, metric, ifindex,
+		gateway, prefixlen);
 }
 
 int __connman_inet_del_subnet_from_table(uint32_t table_id, int ifindex,
 						const char *gateway, unsigned char prefixlen)
 {
-	/* ip route del 1.2.3.4/24 dev eth0 table 1234 */
-	return iproute_default_modify(RTM_DELROUTE, table_id, ifindex, gateway, prefixlen);
+	static const uint32_t metric = 0;
+
+	/* ip route del 1.2.3.4/24 dev eth0 table 1234 metric 0 */
+	return iproute_default_modify(RTM_DELROUTE, table_id, metric, ifindex,
+		gateway, prefixlen);
 }
 
 int __connman_inet_get_interface_ll_address(int index, int family,
-- 
2.42.0

