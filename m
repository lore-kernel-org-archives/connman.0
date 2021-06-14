Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F1173
	for <connman@lists.linux.dev>; Mon, 14 Jun 2021 06:44:26 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 62C9050056C;
	Mon, 14 Jun 2021 08:44:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 32AE75004AE;
	Mon, 14 Jun 2021 08:44:18 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] README: Add IRC channel info
Date: Mon, 14 Jun 2021 08:44:15 +0200
Message-Id: <20210614064415.4556-1-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ConnMan project moved to oftc recently. Add the IRC contact
information.
---
 README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README b/README
index b8154e67a7ac..03bdfc1446d3 100644
--- a/README
+++ b/README
@@ -453,3 +453,7 @@ send a (empty) message from your email account to
 
 Mailing list archive:
 	https://lore.kernel.org/connman
+
+IRC:
+	ircs://irc.oftc.net:6697/#connman (for SSL)
+	irc://irc.oftc.net:6667/#connman (for non-SSL)
-- 
2.32.0
