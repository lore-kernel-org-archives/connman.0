Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC612B88
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 290CA73147
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:29 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DFEEC73156
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:28 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 09/11] wispr: Document 'wispr_route'.
Date: Fri, 15 Dec 2023 22:12:21 -0800
Message-ID: <20231216061223.2199037-10-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216061223.2199037-1-gerickson@nuovations.com>
References: <20231216061223.2199037-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'wispr_route' structure.
---
 src/wispr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 581205c6662c..317146af8cb8 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -50,9 +50,28 @@ enum connman_wispr_result {
 	CONNMAN_WISPR_RESULT_FAILED  = 3,
 };
 
+/**
+ *  State for host routes used for a WISPr request.
+ */
 struct wispr_route {
+	/**
+	 *	A pointer to a mutable, dynamically-allocated null-terminated
+	 *	C string containing the text-formatted address of the WISPr
+	 *	host.
+	 */
 	char *address;
+
+	/**
+	 *	The network interface index associated with the underlying
+	 *	network interface over which the WISPr request will sent and
+	 *	the reply received.
+	 */
 	int if_index;
+
+	/**
+	 *	The route metric/priority used for the host route created for
+	 *	the WISPr host.
+	 */
 	uint32_t metric;
 };
 
-- 
2.42.0

