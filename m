Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B0382
	for <connman@lists.linux.dev>; Fri,  8 Dec 2023 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DBA82730F2
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 20:27:17 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:851a:6a54:a980:b9a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9581073106
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 20:27:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] connection: Fix typo in @file comment.
Date: Thu,  7 Dec 2023 17:27:16 -0800
Message-ID: <20231208012716.1097174-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This fixes a minor grammatical typo in the @file comment.

---
 src/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/connection.c b/src/connection.c
index 0c1bdba7f515..30e7d736e1e0 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -32,7 +32,7 @@
  *    gateway routes and then uses notifications from the kernel
  *    Routing Netlink (rtnl) to confirm and "activate" those
  *    routes. Likewise, Connection Manager removes/clears/deletes
- *    gateway routes an then uses notifications from the kernel
+ *    gateway routes and then uses notifications from the kernel
  *    Routing Netlink (rtnl) to confirm and "inactivate" those
  *    routes. The following is the state machine for that lifecycle:
  *
-- 
2.42.0

