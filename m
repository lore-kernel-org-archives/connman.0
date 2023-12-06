Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A281328D1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C7924731F7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:12 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7EACF73204
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:12 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 37/90] inet: Leverage '__connman_inet_table2string'.
Date: Wed,  6 Dec 2023 15:50:00 -0800
Message-ID: <20231206235056.322578-38-gerickson@nuovations.com>
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

This leverages '__connman_inet_table2string' when logging the Routing
Netlink (rtnl) table identifier in 'iproute_default_modify'.
---
 src/inet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/inet.c b/src/inet.c
index 74a5a78619b9..e135d1ad3cae 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -3205,7 +3205,9 @@ static int iproute_default_modify(int cmd, uint32_t table_id, int ifindex,
 	int family = connman_inet_check_ipaddress(gateway);
 	char *dst = NULL;
 
-	DBG("gateway %s/%u table %u", gateway, prefixlen, table_id);
+	DBG("gateway %s/%u table %u <%s>",
+		gateway, prefixlen,
+		table_id, __connman_inet_table2string(table_id));
 
 	switch (family) {
 	case AF_INET:
-- 
2.42.0

