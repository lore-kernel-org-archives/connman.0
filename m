Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87148328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ECEFC73206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:18 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AFB4E73224
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 50/90] inet: Add '__connman_inet_{add,del}_default_{to,from}_table_with_metric'.
Date: Wed,  6 Dec 2023 15:50:16 -0800
Message-ID: <20231206235056.322578-54-gerickson@nuovations.com>
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

This adds two new functions for adding a gateway default route:
'__connman_inet_{add,del}_default_{to,from}_table_with_metric', which
expands on the existing
'__connman_inet_{add,del}_default_{to,from}_table' by allowing the
caller to pass a non-zero metric/priority.
---
 src/connman.h |  8 ++++++++
 src/inet.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index d9ce353c4df4..472429bfc1a2 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -254,9 +254,17 @@ int __connman_inet_rtnl_addattr32(struct nlmsghdr *n, size_t maxlen,
 int __connman_inet_add_fwmark_rule(uint32_t table_id, int family, uint32_t fwmark);
 int __connman_inet_del_fwmark_rule(uint32_t table_id, int family, uint32_t fwmark);
 int __connman_inet_add_default_to_table(uint32_t table_id, int ifindex, const char *gateway);
+int __connman_inet_add_default_to_table_with_metric(uint32_t table_id,
+			int ifindex,
+			const char *gateway,
+			uint32_t metric);
 int __connman_inet_add_subnet_to_table(uint32_t table_id, int ifindex,
 			const char *gateway, unsigned char prefixlen);
 int __connman_inet_del_default_from_table(uint32_t table_id, int ifindex, const char *gateway);
+int __connman_inet_del_default_from_table_with_metric(uint32_t table_id,
+			int ifindex,
+			const char *gateway,
+			uint32_t metric);
 int __connman_inet_del_subnet_from_table(uint32_t table_id, int ifindex,
 			const char *gateway, unsigned char prefixlen);
 int __connman_inet_get_address_netmask(int ifindex,
diff --git a/src/inet.c b/src/inet.c
index 5c5100e25f86..3270a854eb6b 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -3382,6 +3382,21 @@ int __connman_inet_add_default_to_table(uint32_t table_id, int ifindex,
 		gateway, prefixlen);
 }
 
+int __connman_inet_add_default_to_table_with_metric(uint32_t table_id,
+						int ifindex,
+						const char *gateway,
+						uint32_t metric)
+{
+	static const unsigned char prefixlen = 0;
+
+	/*
+	 * ip route add default/0 via <gateway> dev wlan0 table <table_id>
+	 * metric <metric>
+	 */
+	return iproute_default_modify(RTM_NEWROUTE, table_id, metric, ifindex,
+		gateway, prefixlen);
+}
+
 int __connman_inet_add_subnet_to_table(uint32_t table_id, int ifindex,
 						const char *gateway, unsigned char prefixlen)
 {
@@ -3438,6 +3453,21 @@ int __connman_inet_del_default_from_table(uint32_t table_id, int ifindex,
 		gateway, prefixlen);
 }
 
+int __connman_inet_del_default_from_table_with_metric(uint32_t table_id,
+						int ifindex,
+						const char *gateway,
+						uint32_t metric)
+{
+	static const unsigned char prefixlen = 0;
+
+	/*
+	 * ip route del default/0 via <gateway> dev wlan0 table <table_id>
+	 * metric <metric>
+	 */
+	return iproute_default_modify(RTM_DELROUTE, table_id, metric, ifindex,
+		gateway, prefixlen);
+}
+
 int __connman_inet_del_subnet_from_table(uint32_t table_id, int ifindex,
 						const char *gateway, unsigned char prefixlen)
 {
-- 
2.42.0

