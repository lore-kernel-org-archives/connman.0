Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367918C10
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E52E673202
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:21 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9FE0873219
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 13/17] gweb: Factor out GWeb destruction into 'g_web_free'.
Date: Sun, 19 Nov 2023 09:07:09 -0800
Message-ID: <20231119170714.775270-14-gerickson@nuovations.com>
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

This factors out the destruction of a GWeb object into 'g_web_free'
to make it clearer, during debugging and development, when destruction
of the reference-counted object actually occurs and which aspects of
the object are being destroyed.
---
 gweb/gweb.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 7a25fe4c8cc3..ce49e8d3dfc1 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -327,6 +327,8 @@ static void free_session(struct web_session *session)
 	if (!session)
 		return;
 
+	debug(session->web, "session %p", session);
+
 	g_free(session->request);
 
 	web = session->web;
@@ -368,6 +370,8 @@ static void flush_sessions(GWeb *web)
 {
 	GList *list;
 
+	debug(web, "flushing sessions...");
+
 	for (list = g_list_first(web->session_list);
 					list; list = g_list_next(list))
 		free_session(list->data);
@@ -422,16 +426,9 @@ GWeb *g_web_ref(GWeb *web)
 	return web;
 }
 
-void g_web_unref(GWeb *web)
+static void g_web_free(GWeb *web)
 {
-	if (!web)
-		return;
-
-	debug(web, "ref %d",
-		web->ref_count - 1);
-
-	if (__sync_fetch_and_sub(&web->ref_count, 1) != 1)
-		return;
+	debug(web, "freeing...");
 
 	flush_sessions(web);
 
@@ -447,6 +444,20 @@ void g_web_unref(GWeb *web)
 	g_free(web);
 }
 
+void g_web_unref(GWeb *web)
+{
+	if (!web)
+		return;
+
+	debug(web, "ref %d",
+		web->ref_count - 1);
+
+	if (__sync_fetch_and_sub(&web->ref_count, 1) != 1)
+		return;
+
+	g_web_free(web);
+}
+
 bool g_web_supports_tls(void)
 {
 	return g_io_channel_supports_tls();
-- 
2.42.0

