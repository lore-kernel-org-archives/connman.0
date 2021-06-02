Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6070
	for <connman@lists.linux.dev>; Wed,  2 Jun 2021 06:43:52 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 5681E50057A;
	Wed,  2 Jun 2021 08:43:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 24ACD500256;
	Wed,  2 Jun 2021 08:43:50 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v3] README: Update mailing list info
Date: Wed,  2 Jun 2021 08:43:48 +0200
Message-Id: <20210602064348.32441-1-wagi@monom.org>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ConnMan is hosted on lists.linux.dev from now on. Update the entry and
also explain how to subscribe. While at it also mention the official
archive.
---
 README | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 167f21ee1c23..e36d796c30a7 100644
--- a/README
+++ b/README
@@ -444,6 +444,12 @@ Information
 ===========
 
 Mailing list:
-	connman@connman.net
+	connman@lists.linux.dev
 
-You can report bugs to the mailing list.
+If you would like to subscribe to receive mail in your inbox, just
+send a (empty) message from your email account to
+
+	connman+subscribe@lists.linux.dev
+
+Maling list archive:
+	https://lore.kernel.org/connman
-- 
2.31.1
