Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD7818
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 049DB73208
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:02 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AC28673219
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 03/17] wispr: Add documentation to 'is_wispr_supported'.
Date: Wed, 15 Nov 2023 17:02:44 -0800
Message-ID: <20231116010259.628527-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116010259.628527-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'is_wispr_supported' function.
---
 src/wispr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 9c99402c8c6d..215c6217a02b 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1072,6 +1072,25 @@ done:
 	return err;
 }
 
+/**
+ *  @brief
+ *    Return whether WISPr requests / HTTP-based Internet reachability
+ *    checks are supported.
+ *
+ *  This determines whether WISPr requests / HTTP-based Internet
+ *  reachability check are supported for the specified network service
+ *  based on its associated technology type.
+ *
+ *  @param[in]  service  A pointer to the immutable network service
+ *                       for which to check WISPr requests / HTTP-based
+ *                       Internet reachability check support.
+ *
+ *  @returns
+ *    True if the network service technology type supports WISPr
+ *    requests / HTTP-based Internet reachability checks; otherwise,
+ *    false.
+ *
+ */
 static bool is_wispr_supported(const struct connman_service *service)
 {
 	if (!service)
-- 
2.42.0

