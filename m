Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD612B88
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 30BCB73106
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:27 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DF4467312C
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:26 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 04/11] wispr: Add 'DBG' to '__connman_wispr_start' error path.
Date: Fri, 15 Dec 2023 22:12:16 -0800
Message-ID: <20231216061223.2199037-5-gerickson@nuovations.com>
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

This adds a 'DBG' to the '__connman_wispr_start' error path that
includes both the error and the WISPr portal context associated with
the error.
---
 src/wispr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index ba774a62dd48..19af1e7bede2 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1338,6 +1338,8 @@ int __connman_wispr_start(struct connman_service *service,
 	return 0;
 
 free_wp:
+	DBG("err %d wp_context %p", err, wp_context);
+
 	wp_context->cb(wp_context->service, wp_context->type, false, err);
 
 	g_hash_table_remove(wispr_portal_hash, GINT_TO_POINTER(index));
-- 
2.42.0

