Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB94111B
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 05AE07312C
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:46:02 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B8E2A731F3
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:46:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 2/4] wispr: Document 'wispr_portal_hash'.
Date: Thu, 9 Nov 2023 20:46:01 -0800
References: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
Message-Id: <34261BE2-28DF-4FD2-A552-39FC32000E46@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a documentation comment for the 'wispr_portal_hash' global.
---
 src/wispr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 5f60bed7..96c5f454 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -93,6 +93,11 @@ struct connman_wispr_portal {
 
 static bool wispr_portal_web_result(GWebResult *result, gpointer user_data);
 
+/**
+ *  A dictionary / hash table of network interface indices to
+ *  active / outstanding WISPr / portal request contexts.
+ *
+ */
 static GHashTable *wispr_portal_hash = NULL;
 
 static char *online_check_ipv4_url = NULL;
-- 
2.42.0

