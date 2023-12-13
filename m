Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2C7D8AF
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3EF7573106
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 15:00:09 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f04b:507e:d663:adf2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id EC0487312B
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 15:00:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] gateway: Updated @file comment to reflect recent rename.
Date: Wed, 13 Dec 2023 12:00:00 -0800
Message-ID: <20231213200001.1994492-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213200001.1994492-1-gerickson@nuovations.com>
References: <20231213200001.1994492-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This updates the @file comment to reflect the recent rename of this
file from "connection.c" to "gateway.c".
---
 src/gateway.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/gateway.c b/src/gateway.c
index 30e7d736e1e0..35ca9cc6cfc5 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -222,9 +222,8 @@
  *        'compute_low_priority_metric'.
  *
  *    Historically, this file started life as "connection.c". However,
- *    today it might be better named "route.c" or, perhaps more
- *    precisely, "gateway.c" since its primary focus is gateway routes
- *    and gateway route management.
+ *    it was renamed to "gateway.c" since its primary focus is gateway
+ *    routes and gateway route management.
  *
  */
 
-- 
2.42.0

