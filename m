Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083C361
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B03E47311A
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:35 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 72FA873145
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:35 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/8] connection: Document 'inet_mask_addr_data'.
Date: Thu, 14 Dec 2023 16:10:28 -0800
Message-ID: <20231215001032.2127527-6-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215001032.2127527-1-gerickson@nuovations.com>
References: <20231215001032.2127527-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'inet_mask_addr_data' function.
---
 src/inet.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index cc450355bf7e..ca999fa31633 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -651,6 +651,31 @@ static int inet_get_addr_data(int family,
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Apply the specified prefix length to the specified binary
+ *    address data.
+ *
+ *  This attempts to apply the specified prefix length as a network /
+ *  prefix mask to the specified address data, in network (that is,
+ *  big endian) byte order, to generate a network address / prefix.
+ *
+ *  @param[in]      addr_len   The length, in bytes of the address
+ *                             pointed to by @a addr_data.
+ *  @param[in,out]  addr_data  A pointer to the mutable address data
+ *                             in binary form in network (that is,
+ *                             big endian) byte order to mask with @a
+ *                             prefixlen.
+ *  @param[in]      prefixlen  The prefix length to apply to @a
+ *                             addr_data as a mask to generate a
+ *                             network address / prefix.
+ *
+ *  @retval  0              If successful.
+ *  @retval  -EINVAL        If @a addr_len or @a addr_data are null
+ *                          or if the specified prefix length exceeds
+ *                          the address length.
+ *
+ */
 static int inet_mask_addr_data(size_t addr_len,
 			void *addr_data,
 			uint8_t prefixlen)
-- 
2.42.0

