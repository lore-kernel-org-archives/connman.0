Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB432360
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 52D5073123
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:35 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 161A973144
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:35 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/8] connection: Document 'inet_get_addr_data'.
Date: Thu, 14 Dec 2023 16:10:27 -0800
Message-ID: <20231215001032.2127527-5-gerickson@nuovations.com>
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

This adds documentation to the 'inet_get_addr_data' function.
---
 src/inet.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index cb2fa4f111e2..cc450355bf7e 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -597,6 +597,37 @@ static const char *rtnl_route_cmd2string(int cmd)
 	return "";
 }
 
+/**
+ *  @brief
+ *    Convert the specified address from text to binary form.
+ *
+ *  This attempts to converts the specified address in text form into
+ *  binary form in network (that is, big endian) byte order, according
+ *  to the specified address family.
+ *
+ *  @param[in]      family       The address family describing the
+ *                               address pointed to by @a addr_string.
+ *  @param[in]      addr_string  A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               address, in text form, to convert to
+ *                               binary form.
+ *  @param[in,out]  addr_data    A pointer to storage sufficiently
+ *                               large to hold @a addr_string
+ *                               converted into binary form. This will
+ *                               point to the converted binary address
+ *                               data on success.
+ *
+ *  @retval  0              If successful.
+ *  @retval  -EINVAL        If @a addr_string or @a addr_data are
+ *                          null or @a addr_string does not contain a
+ *                          character string representing a valid
+ *                          network address in @a family.
+ *  @retval  -EAFNOSUPPORT  If @ family does not contain a valid
+ *                          address family.
+ *
+ *  @sa inet_pton
+ *
+ */
 static int inet_get_addr_data(int family,
 			const char *addr_string,
 			void *addr_data)
-- 
2.42.0

