Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84F12B68
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 868D573145
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:29 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 48BD47315D
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:29 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/11] wispr: Document 'wispr_portal_context_route_ops'.
Date: Fri, 15 Dec 2023 22:12:22 -0800
Message-ID: <20231216061223.2199037-11-gerickson@nuovations.com>
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

This adds documentation to the 'wispr_portal_context_route_ops'
structure.
---
 src/wispr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 317146af8cb8..1af880118e14 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -75,6 +75,10 @@ struct wispr_route {
 	uint32_t metric;
 };
 
+/**
+ *  Gateway configuration function pointers for IP configuration
+ *  type-specific route set/clear/add/delete operations.
+ */
 struct wispr_portal_context_route_ops {
 	int (*add_host_route_with_metric)(int index,
 		const char *host,
@@ -90,7 +94,13 @@ struct connman_wispr_portal_context {
 	int refcount;
 	struct connman_service *service;
 	enum connman_ipconfig_type type;
+
+	/**
+	 *	A pointer to immutable function pointers for route
+	 *	set/clear/add/delete operations.
+	 */
 	const struct wispr_portal_context_route_ops *ops;
+
 	__connman_wispr_cb_t cb;
 	struct connman_wispr_portal *wispr_portal;
 
-- 
2.42.0

