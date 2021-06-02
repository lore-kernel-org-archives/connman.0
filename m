Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5772
	for <connman@lists.linux.dev>; Wed,  2 Jun 2021 06:33:27 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id C631550057A;
	Wed,  2 Jun 2021 08:33:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 925B4500256;
	Wed,  2 Jun 2021 08:33:19 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] REAMDE: Announce new mailing list
Date: Wed,  2 Jun 2021 08:33:15 +0200
Message-Id: <20210602063315.30142-1-wagi@monom.org>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The project moved to a new mailing list hosted by the LF.
The 01.org domain does not longer host any ConnMan related
services. Drop these references also from the README.
---
 README | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/README b/README
index e911bc2d6bbd..ff98ee91a341 100644
--- a/README
+++ b/README
@@ -444,10 +444,7 @@ Information
 ===========
 
 Mailing list:
-	connman@connman.net
+	connman@lists.linux.dev
 
 For additional information about the project visit ConnMan web site:
-	https://01.org/connman
-	http://www.connman.net
-
-You can report bugs at https://01.org/jira/browse/CM
+	https://lore.kernel.org/connman/
-- 
2.31.1
