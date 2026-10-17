Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B137F01B
	for <connman@lists.linux.dev>; Sat, 17 Oct 2026 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258957; cv=none; b=QbfHO7ULsTTzuQaP8piruJ27fvtrTCGVmfmU2KupzZI8M7uaHGqhwhJG40LtTuI2wMVT/iiIXCC9Ey9cfs6ePGUnlb5n7h5CebG5cYiUa/DgJ/SZ1nDCm0BwdGifQQ6RytSSQWe9dcsLtUSNBUtagj/ojv3E+rtYkI918BE0P4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258957; c=relaxed/simple;
	bh=d7qwIRR+7BDSgQO+MMRJGueBC7wkz4It5BhG/5NgRmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/cbStO90CWW+lcLW6M6zzeARNrtgQdE19c9Yl0x0DSGPJd4Sw7bsWGpMTH7lb9DRgfMrLe62uq++q/SXQvGVcZ70eDdmzpviu7/GHhd7a+bC3rMbFrFD/f0eFXnOL5W/9NO1SRoSKFf6GaYauuK9+a6ndYDfF+xb2QHUNj4FWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=aR/tpOxt; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="aR/tpOxt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PqIMvs03T6JMd2fBC+rsDuu8GiGthozMia7iymS7Ht4=; b=aR/tpOxtHmo5vQJYCeXVozrGzu
	CjZUjpjHT5uWKQbyOqorxhBxMfL1OUY8ieJNGZYokcAIKH3nsk6kCLnX/CootnK6m/U7EfIGT2sE4
	HQeRQVwln00OSu9Ypfpvl2q1VvEYctz4tMCuVDGxyDC1ul//h/atmLMQwk6oIDPLmRTHsRD3dRZ/O
	wOtj8jgJTgWiT64Xh1/Y/m0L/+8DfpIRkdmReD4kf8k/JWLMIVoQdBRk8GLm1hPVN6Xx1dBEH6px+
	sjfchX3qjGWUYVdNAotwqYVq7L6Dq9ct2EJUVy7PXFsz32vWPGF4TovKqa81MWPBlhRgP5zoQUD10
	pxfvV2JA==;
Received: from [2a10:a5c0:37:6500:28a3:537a:c0a3:d53f] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1xI8QM-00GfTk-1e;
	Sat, 17 Oct 2026 20:42:30 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Cc: Hannu Mallat <hannu.mallat@jollamobile.com>
Subject: [PATCHv2 2/2] inotify: Use only one instance and refcount struct accordingly
Date: Sat, 17 Oct 2026 20:41:47 +0300
Message-ID: <20261017174218.488542-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017163501.480955-3-jussi.laakkonen@jolla.com>
References: <20261017163501.480955-3-jussi.laakkonen@jolla.com>
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
 Message-ID: 20261017174218.488542-1-jussi.laakkonen@jolla.com
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
Changes in v2:
 - Fix combined commit order to get the correct state of the changes.
 
 src/inotify.c | 134 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 80 insertions(+), 54 deletions(-)

diff --git a/src/inotify.c b/src/inotify.c
index db4e5967..bf291dac 100644
--- a/src/inotify.c
+++ b/src/inotify.c
@@ -43,27 +43,28 @@ struct connman_inotify_cb {
 struct connman_inotify {
 	unsigned int refcount;
 
-	GIOChannel *channel;
-	uint watch;
 	int wd;
 
 	GSList *list;
 };
 
+static int inotify_fd = -1;
+static GIOChannel *inotify_channel = NULL;
+static GSList *inotify_list = NULL;
+static uint inotify_watch = 0;
+
 static void cleanup_inotify(gpointer user_data);
 
-static void connman_inotify_ref(struct connman_inotify *i)
+void connman_inotify_ref(struct connman_inotify *i)
 {
 	__sync_fetch_and_add(&i->refcount, 1);
 }
 
-static void connman_inotify_unref(gpointer data)
+void connman_inotify_unref(gpointer data)
 {
 	struct connman_inotify *i = data;
-
 	if (__sync_fetch_and_sub(&i->refcount, 1) != 1)
 		return;
-
 	cleanup_inotify(data);
 }
 
@@ -72,7 +73,6 @@ static GHashTable *inotify_hash;
 static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
-	struct connman_inotify *inotify = user_data;
 	char buffer[sizeof(struct inotify_event) + NAME_MAX + 1];
 	char *next_event;
 	gsize bytes_read;
@@ -80,7 +80,7 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 	GSList *list;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		inotify->watch = 0;
+		inotify_watch = 0;
 		return FALSE;
 	}
 
@@ -94,18 +94,18 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 		return TRUE;
 	default:
 		connman_error("Reading from inotify channel failed");
-		inotify->watch = 0;
+		inotify_watch = 0;
 		return FALSE;
 	}
 
 	next_event = buffer;
 
-	connman_inotify_ref(inotify);
-
 	while (bytes_read > 0) {
+		struct connman_inotify *inotify = NULL;
 		struct inotify_event *event;
 		gchar *ident;
 		gsize len;
+		GSList *ptr;
 
 		event = (struct inotify_event *) next_event;
 		if (event->len)
@@ -122,76 +122,58 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
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
 
-			(cb->func)(event, ident, cb->user_data);
-			list = next;
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
+
+			connman_inotify_unref(inotify);
 		}
 	}
 
-	connman_inotify_unref(inotify);
-
 	return TRUE;
 }
 
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
-
-	if (inotify->watch > 0)
-		g_source_remove(inotify->watch);
-
-	fd = g_io_channel_unix_get_fd(inotify->channel);
+	if (inotify_fd >= 0 && inotify->wd >= 0)
+		inotify_rm_watch(inotify_fd, inotify->wd);
 
-	if (inotify->wd >= 0)
-		inotify_rm_watch(fd, inotify->wd);
-
-	g_io_channel_unref(inotify->channel);
+	inotify_list = g_slist_remove(inotify_list, inotify);
 }
 
 int connman_inotify_register(const char *path, inotify_event_cb callback,
@@ -279,6 +261,29 @@ int __connman_inotify_init(void)
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
@@ -289,4 +294,25 @@ void __connman_inotify_cleanup(void)
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

