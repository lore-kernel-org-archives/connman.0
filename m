Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010515A4
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3D15573219
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:04 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E886173227
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/17] wispr: Add documentation to 'cancel_connman_wispr_portal_context'.
Date: Wed, 15 Nov 2023 17:02:49 -0800
Message-ID: <20231116010259.628527-9-gerickson@nuovations.com>
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

This adds documentation to the 'cancel_connman_wispr_portal_context'
function.
---
 src/wispr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 84d4b1d0efb4..1e62e0cd2dee 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -166,6 +166,24 @@ static void free_wispr_routes(struct connman_wispr_portal_context *wp_context)
 	}
 }
 
+/**
+ *  @brief
+ *    Cancel a WISPr/portal request.
+ *
+ *  This attempts to cancel any outstanding request associated with
+ *  the specified WISPr/portal context. This deallocates any resources
+ *  associated with the context, except for the context itself which
+ *  requires invoking #free_connman_wispr_portal_context.
+ *
+ *  @param[in,out]  wp_context  A pointer to the mutable WISPr/portal
+ *                              context for which to cancel an outstanding
+ *                              request, whether a reachability check
+ *                              or otherwise.
+ *
+ *  @sa create_connman_wispr_portal_context
+ *  @sa free_connman_wispr_portal_context
+ *
+ */
 static void cancel_connman_wispr_portal_context(
 		struct connman_wispr_portal_context *wp_context)
 {
-- 
2.42.0

