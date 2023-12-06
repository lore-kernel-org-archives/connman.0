Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C7328B6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 01A9A73156
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:12 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B8871731A4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 35/90] inet: Add '__connman_inet_table2string'.
Date: Wed,  6 Dec 2023 15:49:58 -0800
Message-ID: <20231206235056.322578-36-gerickson@nuovations.com>
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

This adds the function '__connman_inet_table2string', which returns a
null-terminated C string describing a Linux Routing Netlink (rtnl)
routing table identifier.
---
 src/connman.h |  2 ++
 src/inet.c    | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index 6b86be6f5ab3..19de86346565 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -174,6 +174,8 @@ int __connman_inet_get_interface_mac_address(int index, uint8_t *mac_address);
 
 bool __connman_inet_is_any_addr(const char *address, int family);
 
+const char *__connman_inet_table2string(uint32_t table_id);
+
 #include <netinet/ip6.h>
 #include <netinet/icmp6.h>
 
diff --git a/src/inet.c b/src/inet.c
index 3465d50cc84b..3d40f8d09e82 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -256,6 +256,24 @@ out:
 	return ret;
 }
 
+const char *__connman_inet_table2string(uint32_t table_id)
+{
+	switch (table_id) {
+	case RT_TABLE_UNSPEC:
+		return "unspecified";
+	case RT_TABLE_COMPAT:
+		return "compat";
+	case RT_TABLE_DEFAULT:
+		return "default";
+	case RT_TABLE_MAIN:
+		return "main";
+	case RT_TABLE_LOCAL:
+		return "local";
+	}
+
+	return "";
+}
+
 int connman_inet_ifindex(const char *name)
 {
 	struct ifreq ifr;
-- 
2.42.0

