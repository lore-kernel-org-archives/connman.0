Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144413AE3
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CC17273174
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:18 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 869EA731A8
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 06/17] wispr: Add documentation to '__connman_wispr_stop'.
Date: Sun, 19 Nov 2023 09:07:02 -0800
Message-ID: <20231119170714.775270-7-gerickson@nuovations.com>
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

This adds documentation to the '__connman_wispr_stop' function.
---
 src/wispr.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 84ad21c2d6fb..41f5d462da41 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1268,6 +1268,22 @@ free_wp:
 	return err;
 }
 
+/**
+ *  @brief
+ *    Stop all HTTP-based Internet reachability checks for the specified
+ *    network service.
+ *
+ *  This attempts to stop all HTTP-based Internet reachability checks
+ *  for the specified network service.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to stop all reachability
+ *                           checks.
+ *
+ *  @sa __connman_wispr_start
+ *  @sa __connman_wispr_cancel
+ *
+ */
 void __connman_wispr_stop(struct connman_service *service)
 {
 	struct connman_wispr_portal *wispr_portal;
-- 
2.42.0

