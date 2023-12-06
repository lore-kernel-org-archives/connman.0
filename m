Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98D62A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id BCAF9730B4
	for <connman@lists.linux.dev>; Tue,  5 Dec 2023 19:40:25 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:80e1:7a27:5c35:8dc3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 773AC73118
	for <connman@lists.linux.dev>; Tue,  5 Dec 2023 19:40:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 80/80] Added @file comment to 'src/connman.h'.
Date: Tue,  5 Dec 2023 16:40:23 -0800
Message-ID: <20231206004024.249222-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

From: Grant Erickson <erick205@umn.edu>

While there is a very specific organization to the project headers and
symbols, it is not immediately evident at first glance to the uninitiated.

The addition of this file comment helps inform the uninitiated that
'connman.h' is reserved for private, cross-project interfaces which
differentiates it from those publicly-consumable headers in
'include/'.
---
 src/connman.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index e0736e41ad68..6b86be6f5ab3 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -19,6 +19,13 @@
  *
  */
 
+/**
+ *  @file
+ *    This file defines internal, non-public (that is, neither visible
+ *    nor consumable by plugins), cross-module interfaces.
+ *
+ */
+
 #include <stdbool.h>
 
 #include <glib.h>
-- 
2.42.0

