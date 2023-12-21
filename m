Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB44156C5
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E868E730F3
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 02:08:50 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A977C7312B
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 02:08:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] ipconfig: Demote RTNL RTM_{ADD,DEL}ROUTE logs from info to DBG.
Date: Wed, 20 Dec 2023 23:08:49 -0800
Message-ID: <20231221070849.2354559-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

With the "continuous" online check mode, logs can become dominated by
Linux Routing Netlink (rtnl) 'RTM_{ADD,DEL}ROUTE' entries every time
WISPr adds/deletes a host route for the online check.

This demotes those log invocations from 'connman_info' to 'DBG'.
---
 src/ipconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 5ec619fa7e6b..c2d7d2bc02b8 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1102,7 +1102,7 @@ void __connman_ipconfig_newroute(int index, int family, unsigned char scope,
 		}
 	}
 
-	connman_info("%s {add} route %s/%u gw %s scope %u <%s> table %u <%s> "
+	DBG("%s {add} route %s/%u gw %s scope %u <%s> table %u <%s> "
 		"metric %u",
 		ifname, dst, dst_prefixlen, gateway, scope, scope2str(scope),
 		table_id, __connman_inet_table2string(table_id), metric);
@@ -1174,7 +1174,7 @@ void __connman_ipconfig_delroute(int index, int family, unsigned char scope,
 		}
 	}
 
-	connman_info("%s {del} route %s/%u gw %s scope %u <%s> table %u <%s> "
+	DBG("%s {del} route %s/%u gw %s scope %u <%s> table %u <%s> "
 		"metric %u",
 		ifname, dst, dst_prefixlen, gateway, scope, scope2str(scope),
 		table_id, __connman_inet_table2string(table_id), metric);
-- 
2.42.0

