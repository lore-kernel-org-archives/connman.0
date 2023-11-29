Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35F5DF34
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6F75F73174
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 15:41:59 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 232F673226
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 15:41:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 3/3] connection: Document 'is_ipv[46]_addr_any_str'.
Date: Wed, 29 Nov 2023 12:41:56 -0800
Message-ID: <20231129204156.1298225-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129204156.1298225-1-gerickson@nuovations.com>
References: <20231129015253.1254116-1-gerickson@nuovations.com>
 <20231129204156.1298225-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'is_ipv[46]_addr_any_str' functions.
---
 src/connection.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index f7b5ca008d8a..a1a962578e9f 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -200,11 +200,51 @@ static void gateway_data_debug(const char *function,
 	}
 }
 
+/**
+ *  @brief
+ *    Determine whether the specified text-formatted IPv4 address is
+ *    the "any" or "unspecified" address.
+ *
+ *  This determines whether the specified text-formatted IPv4 address
+ *  is the "any" or "unspecified" address, that is "0.0.0.0".
+ *
+ *  @param[in]  address  A pointer to an immutable null-terminated C
+ *                       string containing the text-formatted address
+ *                       to determine whether it is the IPv4 "any" or
+ *                       "unspecified address.
+ *
+ *  @returns
+ *    True if @a address is the "any" or "unspecified" IPv4 address;
+ *    otherwise, false.
+ *
+ *  @sa is_ipv6_addr_any_str
+ *
+ */
 static bool is_ipv4_addr_any_str(const char *address)
 {
 	return g_strcmp0(ipv4_addr_any_str, address) == 0;
 }
 
+/**
+ *  @brief
+ *    Determine whether the specified text-formatted IPv6 address is
+ *    the "any" or "unspecified" address.
+ *
+ *  This determines whether the specified text-formatted IPv6 address
+ *  is the "any" or "unspecified" address, that is "::".
+ *
+ *  @param[in]  address  A pointer to an immutable null-terminated C
+ *                       string containing the text-formatted address
+ *                       to determine whether it is the IPv6 "any" or
+ *                       "unspecified address.
+ *
+ *  @returns
+ *    True if @a address is the "any" or "unspecified" IPv6 address;
+ *    otherwise, false.
+ *
+ *  @sa is_ipv4_addr_any_str
+ *
+ */
 static bool is_ipv6_addr_any_str(const char *address)
 {
 	return g_strcmp0(ipv6_addr_any_str, address) == 0;
-- 
2.42.0

