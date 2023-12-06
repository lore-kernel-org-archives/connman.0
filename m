Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A7328C1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0878373207
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:24 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BFB6E73227
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 63/90] connection: Document 'is_addr_any_str'.
Date: Wed,  6 Dec 2023 15:50:29 -0800
Message-ID: <20231206235056.322578-67-gerickson@nuovations.com>
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

This adds documentation to the 'is_addr_any_str' function.
---
 src/connection.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index f1e91c7c8518..053164c36297 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -792,6 +792,27 @@ static bool is_ipv6_addr_any_str(const char *address)
 	return g_strcmp0(ipv6_addr_any_str, address) == 0;
 }
 
+/**
+ *  @brief
+ *    Determine whether the specified text-formatted IP address is
+ *    the "any" or "unspecified" address.
+ *
+ *  This determines whether the specified text-formatted IP address
+ *  is the "any" or "unspecified" address.
+ *
+ *  @param[in]  address  A pointer to an immutable null-terminated C
+ *                       string containing the text-formatted address
+ *                       to determine whether it is the IP "any" or
+ *                       "unspecified address.
+ *
+ *  @returns
+ *    True if @a address is the "any" or "unspecified" IP address;
+ *    otherwise, false.
+ *
+ *  @sa is_ipv4_addr_any_str
+ *  @sa is_ipv6_addr_any_str
+ *
+ */
 static bool is_addr_any_str(const char *address)
 {
 	if (!address)
-- 
2.42.0

