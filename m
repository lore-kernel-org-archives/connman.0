Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A152328CD
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9C48B73218
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:16 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5FA4F73224
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:16 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 44/90] inet: Include the command value and string in 'DBG'
Date: Wed,  6 Dec 2023 15:50:10 -0800
Message-ID: <20231206235056.322578-48-gerickson@nuovations.com>
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

This includes the Routing Netlink (rtnl) command value and string in
'DBG' in 'iproute_default_modify' to aid in debugging.
---
 src/inet.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/inet.c b/src/inet.c
index 9d5841fdf2e3..4882f9b78205 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -3196,6 +3196,18 @@ int __connman_inet_del_fwmark_rule(uint32_t table_id, int family, uint32_t fwmar
 	return iprule_modify(RTM_DELRULE, family, table_id, fwmark);
 }
 
+static const char *rtnl_route_cmd2string(int cmd)
+{
+	switch (cmd) {
+	case RTM_NEWROUTE:
+		return "add";
+	case RTM_DELROUTE:
+		return "del";
+	}
+
+	return "";
+}
+
 static int iproute_default_modify(int cmd, uint32_t table_id, int ifindex,
 			const char *gateway, unsigned char prefixlen)
 {
@@ -3208,7 +3220,8 @@ static int iproute_default_modify(int cmd, uint32_t table_id, int ifindex,
 
 	interface = connman_inet_ifname(ifindex);
 
-	DBG("ifindex %d (%s) gateway %s/%u table %u <%s>",
+	DBG("cmd %d (%s) ifindex %d (%s) gateway %s/%u table %u <%s>",
+		cmd, rtnl_route_cmd2string(cmd),
 		ifindex, interface,
 		gateway, prefixlen,
 		table_id, __connman_inet_table2string(table_id));
-- 
2.42.0

