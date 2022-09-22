Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E066E8
	for <connman@lists.linux.dev>; Thu, 22 Sep 2022 15:55:03 +0000 (UTC)
From: Ben Kohler <bkohler@gentoo.org>
To: connman@lists.linux.dev
Subject: [PATCH] gresolv: add missing include to fix clang-16 build
Date: Thu, 22 Sep 2022 10:45:17 -0500
Message-Id: <20220922154517.2326482-1-bkohler@gentoo.org>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current compilers gcc-12 and clang-15 warn about an implicit function
declaration in gresolv.c, and this turns into a fatal error in clang-16
and eventually in future gcc.
---
 gweb/gresolv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 954e7cfe..7c58e055 100644
--- a/gweb/gresolv.c
+++ b/gweb/gresolv.c
@@ -36,6 +36,7 @@
 #include <arpa/inet.h>
 #include <arpa/nameser.h>
 #include <net/if.h>
+#include <cdefs.h>
 
 #include "gresolv.h"
 
-- 
2.37.3

