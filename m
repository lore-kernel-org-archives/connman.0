Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282B328DE
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5E8F173180
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:12 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 21AA4731A8
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:12 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 36/90] inet: Document '__connman_inet_table2string'.
Date: Wed,  6 Dec 2023 15:49:59 -0800
Message-ID: <20231206235056.322578-37-gerickson@nuovations.com>
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

This adds documentation to the '__connman_inet_table2string'
function.
---
 src/inet.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index 3d40f8d09e82..74a5a78619b9 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -256,6 +256,23 @@ out:
 	return ret;
 }
 
+/**
+ *  @brief
+ *    Return a string describing a Linux Routing Netlink (rtnl)
+ *    routing table identifier.
+ *
+ *  This returns a null-terminated C string describing a Linux Routing
+ *  Netlink (rtnl) routing table identifier.
+ *
+ *  @param[in]  table_id   The Linux Routing Netlink (rtnl) routing
+ *                         table identifier for which to return a
+ *                         descriptive string.
+ *
+ *  @returns
+ *    A pointer to a immutable null-terminated C string describing @a
+ *    table_id on success; otherwise, an empty string ("").
+ *
+ */
 const char *__connman_inet_table2string(uint32_t table_id)
 {
 	switch (table_id) {
-- 
2.42.0

