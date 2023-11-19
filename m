Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42618B14
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7A8A073203
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:21 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 32C2773213
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 12/17] gweb: Add reference count debug statements.
Date: Sun, 19 Nov 2023 09:07:08 -0800
Message-ID: <20231119170714.775270-13-gerickson@nuovations.com>
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

This adds reference count debugging statements in 'g_web_ref' and
'g_web_unref', similar but not identical to other modules in the
project.
---
 gweb/gweb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 0270531a982f..7a25fe4c8cc3 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -414,6 +414,9 @@ GWeb *g_web_ref(GWeb *web)
 	if (!web)
 		return NULL;
 
+	debug(web, "ref %d",
+		web->ref_count + 1);
+
 	__sync_fetch_and_add(&web->ref_count, 1);
 
 	return web;
@@ -424,6 +427,9 @@ void g_web_unref(GWeb *web)
 	if (!web)
 		return;
 
+	debug(web, "ref %d",
+		web->ref_count - 1);
+
 	if (__sync_fetch_and_sub(&web->ref_count, 1) != 1)
 		return;
 
-- 
2.42.0

