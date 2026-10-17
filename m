Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7F391E6D
	for <connman@lists.linux.dev>; Sat, 17 Oct 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254938; cv=none; b=QB8ghMJIWaT3bzRirxQAgmMNJVzKb7LMyWnup8a5pxIeFxqGql6guIrkJGYSPk+jH5k9LAFW2lSjpUuvI+tzULb7ZEAOlJa6YjvqAL6HjbsGMh/nyzP9wS3yVS1bQ+oFDtiOwjAmUEWxwPi2yKalLoEwGj1sCckmqNXceKSe6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254938; c=relaxed/simple;
	bh=GvTHbEwd+pXyUO7RWRbMPpZCFRlwIGHpP7ElkeJGkGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iE474IJlx6qRFZ/imy0UZAZpbAvenM+8G5eIQFegKiFqF4lU/7jvZeEwCGRaey+r4KcFAtb/UiOGHbcFe5xle8vfsuXMJXsLAUIJyvGQB80CYkP62/x7O0QOQslZMSPTlCdLn8BZSHijup6BDlcRC3CsMyTdE5VZBM5V/JdZLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=JH7wNa/u; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="JH7wNa/u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QUEJyzvLqjC4LzDGzDHYWc4pol2qW2fKHCOQdtEdQ8k=; b=JH7wNa/u6fhRgffSTPuH37VPHk
	Iz8FD3q1w6ZSnyG1V1O4WxEzPE2/VJAOI+WDpX8+OTYy9g/5UmTtC1C29koyp53NKJCw2phkzez9D
	X/rqCD9UmRN20mAbsvFAMoYMbjfEGT+4w8VAdrGuLJdC0+W2izwu+Vq5bfngDv5wJQC+BKKIVTdch
	symrihorbb6n+5dM7d+TTDt4tnhRljUnUY/3L5jfljxfC/1WS57XR75OsxMA/6baf8byORXML0Frm
	4/T+vRC7Sax6/YuoKUUFYAFf/EF5RUkGb45aQ/Z+Zww9p1sqm5mDicplb594KqM144m7w34BlRAc1
	Os2s1NAw==;
Received: from [2a10:a5c0:37:6500:692b:4032:511f:1a05] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1xI7NX-00GTaE-0W;
	Sat, 17 Oct 2026 19:35:31 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Cc: Hannu Mallat <hannu.mallat@jollamobile.com>
Subject: [PATCH 2/2] inotify: Use only one instance and refcount struct accordingly
Date: Sat, 17 Oct 2026 19:34:35 +0300
Message-ID: <20261017163501.480955-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017163501.480955-1-jussi.laakkonen@jolla.com>
References: <20261017163501.480955-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: RCPT_COUNT_TWO(0.00); Two recipients [2]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: TO_DN_SOME(0.00); Some of the recipients have display names
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20261017163501.480955-3-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

From: Hannu Mallat <hannu.mallat@jollamobile.com>

The number of inotify instances available per user is limited.

Instead of having one inotify instance per watch, use the same instance
for all watches and check watch ID when invoking callback functions.

When processing inotify events, callbacks may unregister which can
result in freeing the related connman_inotify struct. However that
struct is referenced in the loop which processes the events read in.

Implement reference counting to make sure the structure is available
while events are being processed.
---
 src/inotify.c | 121 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 43 deletions(-)

diff --git a/src/inotify.c b/src/inotify.c
index db4e5967..85264832 100644
--- a/src/inotify.c
+++ b/src/inotify.c
@@ -50,6 +50,11 @@ struct connman_inotify {
 	GSList *list;
 };
 
+static int inotify_fd = -1;
+static GIOChannel *inotify_channel = NULL;
+static GSList *inotify_list = NULL;
+static uint inotify_watch = 0;
+
 static void cleanup_inotify(gpointer user_data);
 
 static void connman_inotify_ref(struct connman_inotify *i)
@@ -80,7 +85,7 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 	GSList *list;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		inotify->watch = 0;
+		inotify_watch = 0;
 		return FALSE;
 	}
 
@@ -94,7 +99,7 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 		return TRUE;
 	default:
 		connman_error("Reading from inotify channel failed");
-		inotify->watch = 0;
+		inotify_watch = 0;
 		return FALSE;
 	}
 
@@ -103,9 +108,11 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 	connman_inotify_ref(inotify);
 
 	while (bytes_read > 0) {
+		struct connman_inotify *inotify = NULL;
 		struct inotify_event *event;
 		gchar *ident;
 		gsize len;
+		GSList *ptr;
 
 		event = (struct inotify_event *) next_event;
 		if (event->len)
@@ -122,12 +129,26 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 		next_event += len;
 		bytes_read -= len;
 
-		for (list = inotify->list; list; ) {
-			struct connman_inotify_cb *cb = list->data;
-			GSList *next = list->next;
+		for (ptr = inotify_list; ptr; ptr = ptr->next) {
+			struct connman_inotify *data = ptr->data;
+			if (data->wd == event->wd) {
+				inotify = data;
+				break;
+			}
+		}
+
+		if (inotify) {
+			connman_inotify_ref(inotify);
+
+			for (list = inotify->list; list; ) {
+				struct connman_inotify_cb *cb = list->data;
+				GSList *next = list->next;
+
+				(cb->func)(event, ident, cb->user_data);
+				list = next;
+			}
 
-			(cb->func)(event, ident, cb->user_data);
-			list = next;
+			connman_inotify_unref(inotify);
 		}
 	}
 
@@ -138,60 +159,30 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 
 static int create_watch(const char *path, struct connman_inotify *inotify)
 {
-	int fd;
-
 	DBG("Add directory watch for %s", path);
 
-	fd = inotify_init();
-	if (fd < 0)
+	if (inotify_fd < 0)
 		return -EIO;
 
-	inotify->wd = inotify_add_watch(fd, path,
+	inotify->wd = inotify_add_watch(inotify_fd, path,
 					IN_MODIFY | IN_CREATE | IN_DELETE |
 					IN_MOVED_TO | IN_MOVED_FROM);
 	if (inotify->wd < 0) {
 		connman_error("Creation of %s watch failed", path);
-		close(fd);
 		return -EIO;
 	}
 
-	inotify->channel = g_io_channel_unix_new(fd);
-	if (!inotify->channel) {
-		connman_error("Creation of inotify channel failed");
-		inotify_rm_watch(fd, inotify->wd);
-		inotify->wd = 0;
-
-		close(fd);
-		return -EIO;
-	}
-
-	g_io_channel_set_close_on_unref(inotify->channel, TRUE);
-	g_io_channel_set_encoding(inotify->channel, NULL, NULL);
-	g_io_channel_set_buffered(inotify->channel, FALSE);
-
-	inotify->watch = g_io_add_watch(inotify->channel,
-				G_IO_IN | G_IO_HUP | G_IO_NVAL | G_IO_ERR,
-				inotify_data, inotify);
+	inotify_list = g_slist_prepend(inotify_list, inotify);
 
 	return 0;
 }
 
 static void remove_watch(struct connman_inotify *inotify)
 {
-	int fd;
-
-	if (!inotify->channel)
-		return;
+	if (inotify_fd >= 0 && inotify->wd >= 0)
+		inotify_rm_watch(inotify_fd, inotify->wd);
 
-	if (inotify->watch > 0)
-		g_source_remove(inotify->watch);
-
-	fd = g_io_channel_unix_get_fd(inotify->channel);
-
-	if (inotify->wd >= 0)
-		inotify_rm_watch(fd, inotify->wd);
-
-	g_io_channel_unref(inotify->channel);
+	inotify_list = g_slist_remove(inotify_list, inotify);
 }
 
 int connman_inotify_register(const char *path, inotify_event_cb callback,
@@ -279,6 +270,29 @@ int __connman_inotify_init(void)
 {
 	DBG("");
 
+	inotify_fd = inotify_init();
+	if (inotify_fd < 0) {
+		connman_error("inotify init failed");
+		return -EIO;
+	}
+
+	inotify_channel = g_io_channel_unix_new(inotify_fd);
+	if (!inotify_channel) {
+		connman_error("Creation of inotify channel failed");
+		close(inotify_fd);
+		inotify_fd = -1;
+
+		return -EIO;
+	}
+
+	g_io_channel_set_close_on_unref(inotify_channel, FALSE);
+	g_io_channel_set_encoding(inotify_channel, NULL, NULL);
+	g_io_channel_set_buffered(inotify_channel, FALSE);
+
+	inotify_watch = g_io_add_watch(inotify_channel,
+				G_IO_IN | G_IO_HUP | G_IO_NVAL | G_IO_ERR,
+				inotify_data, NULL);
+
 	inotify_hash = g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, connman_inotify_unref);
 	return 0;
@@ -289,4 +303,25 @@ void __connman_inotify_cleanup(void)
 	DBG("");
 
 	g_hash_table_destroy(inotify_hash);
+
+	if (inotify_watch) {
+		g_source_remove(inotify_watch);
+		inotify_watch = 0;
+	}
+
+	if (inotify_channel) {
+		g_io_channel_unref(inotify_channel);
+		inotify_channel = NULL;
+	}
+
+	if (inotify_fd >= 0) {
+		close(inotify_fd);
+		inotify_fd = -1;
+	}
+
+	if (inotify_list) {
+		g_slist_free(inotify_list);
+		inotify_list = NULL;
+	}
+
 }
-- 
2.47.3

