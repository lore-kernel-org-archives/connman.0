Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2931804F
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4DE1073206
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:23 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id EDD9D73222
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 16/17] wispr: Avoid double-free in 'free_wispr_routes'.
Date: Sun, 19 Nov 2023 09:07:12 -0800
Message-ID: <20231119170714.775270-17-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119170714.775270-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
 <20231119170714.775270-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Now that 'free_wispr_routes' can be invoked in terminal free-only
as well as cancel-latently-followed-by-free contexts, ensure that
a double-free is avoided with both the 'route->address' and
'wp_context->route_list->data' by explicitly nulling them after
calling 'g_free' on them.
---
 src/wispr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 3837a87811a9..9cd1e7db501d 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -158,7 +158,10 @@ static void free_wispr_routes(struct connman_wispr_portal_context *wp_context)
 		}
 
 		g_free(route->address);
+		route->address = NULL;
+
 		g_free(route);
+		wp_context->route_list->data = NULL;
 
 		wp_context->route_list =
 			g_slist_delete_link(wp_context->route_list,
-- 
2.42.0

