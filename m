Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251812E45
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id BFE0D73144
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:28 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7FB1F73150
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:28 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/11] wispr: Document 'free_wispr_route{,s}'.
Date: Fri, 15 Dec 2023 22:12:20 -0800
Message-ID: <20231216061223.2199037-9-gerickson@nuovations.com>
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

This adds documentation to the 'free_wispr_route{,s}' functions.
---
 src/wispr.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 5ea573ca7769..581205c6662c 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -164,6 +164,27 @@ static void connman_wispr_message_init(struct connman_wispr_message *msg)
 	msg->location_name = NULL;
 }
 
+/**
+ *  @brief
+ *    Deallocate resources associated with the specified WISPr host
+ *    route.
+ *
+ *  This attempts to deallocate resources, including host routes,
+ *  associated with the specified WISPr host route belonging to the
+ *  specified WISPr portal context.
+ *
+ *  @param[in]      wp_context  A pointer to the immutable WISPr
+ *                              portal context associated with @a
+ *                              route.
+ *  @param[in,out]  route       A pointer to the mutable WISPr host
+ *                              route structure for which to delete an
+ *                              associated host route and to
+ *                              deallocate any dynamically-allocated
+ *                              resources associated with it.
+ *
+ *  @sa wispr_route_request
+ *
+ */
 static void free_wispr_route(
 		const struct connman_wispr_portal_context *wp_context,
 		struct wispr_route *route)
@@ -205,6 +226,19 @@ free:
 	route->address = NULL;
 }
 
+/**
+ *  @brief
+ *    Deallocate host route resources associated with the specified
+ *    WISPr portal context.
+ *
+ *  This attempts to deallocate host route resources associated with
+ *  the specified WISPr specified WISPr portal context.
+ *
+ *  @param[in]      wp_context  A pointer to the mutable WISPr
+ *                              portal context for which to deallocate
+ *                              resources associated with host routes.
+ *
+ */
 static void free_wispr_routes(struct connman_wispr_portal_context *wp_context)
 {
 	while (wp_context->route_list) {
-- 
2.42.0

