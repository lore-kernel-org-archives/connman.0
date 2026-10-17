Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8BD6DCE1
	for <connman@lists.linux.dev>; Sat, 17 Oct 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258145; cv=none; b=rlRwcJ2Gzy2PPfUFo8W9IbVvZm6pUmDFAlqGV5ZSlN3d/jrnsUujsvswGTnd62Kh6s+5L9Qst41yY2m4DR9d99wKjpCzhOAe3HAfSvwPsekz4zwPqVKI8KTYedUfUKqufLMymaqMybsQtRQRuvGVpLpVQhePSZDu6yDAccKwTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258145; c=relaxed/simple;
	bh=luodoVoj56EwqxCEeI6A+2zUXO6pA+mkMTbKwVihbas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZiQ68EE7EctlvZYiOVCqPGjGwl5gJ/FOryqC6zCldmUcc1fAienWllvXe931HG753YExsqc/CZDfoLtP9rVIVNUL4R2cnxqcBhHpovmd/ZMJeaZTCD3Y8HHFgxsUeY72kARswocxvD/4hinSdPRdAW5lfgj+l/hIH9aVGZi+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=y55X8UOL; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="y55X8UOL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KWO/gy8aTK4w5fr91Yu0eQ+96KJpS1LwyRMC0DwyoyQ=; b=y55X8UOLZZ7b9RyE14TtD/eGYG
	2h+Oet9EPKvabPjf8NrXJPGPsrOpipQH2iUu4zv4ogsYgdi6nti7B2zTZ+Zq1MtvreqDatMOmQh4E
	tAjit0a5awlGiJT84vgBhfi36dNOjTrfuC+e1tMvEjqfzsALsk7pe3Jp6nGfH9X8jyI4HbxcdETlD
	4rUEFtWh9rIHGHng1IYYLP5WEMQCEKhU8NFkee/bOK3nHzY2nyB+aWoC/kyhmwBGGEt7sl0b942H0
	CITdW2Wt946AZZxxp2TDyby1qcA25gSpLdhGDtMXxg45tTCbDbgkEu6Oj3vpuVlaqh6x5GI08bB+l
	odz7386w==;
Received: from [2a10:a5c0:37:6500:692b:4032:511f:1a05] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1xI7NR-00GTaE-2t;
	Sat, 17 Oct 2026 19:35:26 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Cc: Hannu Mallat <hannu.mallat@jollamobile.com>
Subject: [PATCH 1/2] inotify: Add user_data pointer to inotify callback
Date: Sat, 17 Oct 2026 19:34:34 +0300
Message-ID: <20261017163501.480955-2-jussi.laakkonen@jolla.com>
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
 Message-ID: 20261017163501.480955-2-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

From: Hannu Mallat <hannu.mallat@jollamobile.com>

It's useful to have a callback data pointer to handle events from
multiple locations in the same callback. Any memory allocated for
the pointer should be released in a GDestroyNotify callback which
can be given as a registration parameter along with the user data
pointer.
---
 include/inotify.h              | 10 +++++---
 plugins/session_policy_local.c |  9 ++++---
 src/config.c                   |  7 ++---
 src/inotify.c                  | 47 ++++++++++++++++++++++++++++------
 vpn/vpn-config.c               |  7 ++---
 5 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/include/inotify.h b/include/inotify.h
index 4bc63303..291d874a 100644
--- a/include/inotify.h
+++ b/include/inotify.h
@@ -25,10 +25,14 @@
 struct inotify_event;
 
 typedef void (* inotify_event_cb) (struct inotify_event *event,
-					const char *ident);
+					const char *ident,
+					gpointer user_data);
 
-int connman_inotify_register(const char *path, inotify_event_cb callback);
-void connman_inotify_unregister(const char *path, inotify_event_cb callback);
+int connman_inotify_register(const char *path, inotify_event_cb callback,
+				gpointer user_data,
+				GDestroyNotify free_func);
+void connman_inotify_unregister(const char *path, inotify_event_cb callback,
+				gpointer user_data);
 
 #ifdef __cplusplus
 }
diff --git a/plugins/session_policy_local.c b/plugins/session_policy_local.c
index 32b9c697..667c3e0e 100644
--- a/plugins/session_policy_local.c
+++ b/plugins/session_policy_local.c
@@ -696,7 +696,8 @@ static int read_policies(void)
 
 
 static void notify_handler(struct inotify_event *event,
-                                        const char *filename)
+				const char *filename,
+				gpointer user_data)
 {
 	struct policy_file *file;
 
@@ -761,7 +762,7 @@ static int session_policy_local_init(void)
 	gid_hash = g_hash_table_new_full(g_str_hash, g_str_equal,
 					NULL, NULL);
 
-	err = connman_inotify_register(POLICYDIR, notify_handler);
+	err = connman_inotify_register(POLICYDIR, notify_handler, NULL, NULL);
 	if (err < 0)
 		goto err;
 
@@ -775,7 +776,7 @@ static int session_policy_local_init(void)
 
 err_notify:
 
-	connman_inotify_unregister(POLICYDIR, notify_handler);
+	connman_inotify_unregister(POLICYDIR, notify_handler, NULL);
 
 err:
 	if (file_hash)
@@ -814,7 +815,7 @@ static void session_policy_local_exit(void)
 
 	dbus_connection_unref(connection);
 
-	connman_inotify_unregister(POLICYDIR, notify_handler);
+	connman_inotify_unregister(POLICYDIR, notify_handler, NULL);
 }
 
 CONNMAN_PLUGIN_DEFINE(session_policy_local,
diff --git a/src/config.c b/src/config.c
index d2832187..bdeebe1b 100644
--- a/src/config.c
+++ b/src/config.c
@@ -959,7 +959,8 @@ static int read_configs(void)
 }
 
 static void config_notify_handler(struct inotify_event *event,
-                                        const char *ident)
+					const char *ident,
+					gpointer user_data)
 {
 	char *ext;
 
@@ -1016,7 +1017,7 @@ int __connman_config_init(void)
 	config_table = g_hash_table_new_full(g_str_hash, g_str_equal,
 						NULL, unregister_config);
 
-	connman_inotify_register(STORAGEDIR, config_notify_handler);
+	connman_inotify_register(STORAGEDIR, config_notify_handler, NULL, NULL);
 
 	return read_configs();
 }
@@ -1027,7 +1028,7 @@ void __connman_config_cleanup(void)
 
 	cleanup = true;
 
-	connman_inotify_unregister(STORAGEDIR, config_notify_handler);
+	connman_inotify_unregister(STORAGEDIR, config_notify_handler, NULL);
 
 	g_hash_table_destroy(config_table);
 	config_table = NULL;
diff --git a/src/inotify.c b/src/inotify.c
index c251c6ff..db4e5967 100644
--- a/src/inotify.c
+++ b/src/inotify.c
@@ -34,6 +34,12 @@
 
 #include "connman.h"
 
+struct connman_inotify_cb {
+	inotify_event_cb func;
+	gpointer user_data;
+	GDestroyNotify free_func;
+};
+
 struct connman_inotify {
 	unsigned int refcount;
 
@@ -116,10 +122,12 @@ static gboolean inotify_data(GIOChannel *channel, GIOCondition cond,
 		next_event += len;
 		bytes_read -= len;
 
-		for (list = inotify->list; list; list = list->next) {
-			inotify_event_cb callback = list->data;
+		for (list = inotify->list; list; ) {
+			struct connman_inotify_cb *cb = list->data;
+			GSList *next = list->next;
 
-			(*callback)(event, ident);
+			(cb->func)(event, ident, cb->user_data);
+			list = next;
 		}
 	}
 
@@ -186,9 +194,11 @@ static void remove_watch(struct connman_inotify *inotify)
 	g_io_channel_unref(inotify->channel);
 }
 
-int connman_inotify_register(const char *path, inotify_event_cb callback)
+int connman_inotify_register(const char *path, inotify_event_cb callback,
+				gpointer user_data, GDestroyNotify free_func)
 {
 	struct connman_inotify *inotify;
+	struct connman_inotify_cb *cb;
 	int err;
 
 	if (!callback)
@@ -214,30 +224,51 @@ int connman_inotify_register(const char *path, inotify_event_cb callback)
 	g_hash_table_replace(inotify_hash, g_strdup(path), inotify);
 
 update:
-	inotify->list = g_slist_prepend(inotify->list, callback);
+	cb = g_new0(struct connman_inotify_cb, 1);
+	cb->func = callback;
+	cb->user_data = user_data;
+	cb->free_func = free_func;
+	inotify->list = g_slist_prepend(inotify->list, cb);
 
 	return 0;
 }
 
+static void cleanup_inotify_cb(gpointer data)
+{
+	struct connman_inotify_cb *cb = data;
+	if (cb->free_func)
+		(cb->free_func)(cb->user_data);
+	g_free(cb);
+}
+
 static void cleanup_inotify(gpointer user_data)
 {
 	struct connman_inotify *inotify = user_data;
 
-	g_slist_free(inotify->list);
+	g_slist_free_full(inotify->list, cleanup_inotify_cb);
 
 	remove_watch(inotify);
 	g_free(inotify);
 }
 
-void connman_inotify_unregister(const char *path, inotify_event_cb callback)
+void connman_inotify_unregister(const char *path, inotify_event_cb callback,
+				gpointer user_data)
 {
 	struct connman_inotify *inotify;
+	GSList *l;
 
 	inotify = g_hash_table_lookup(inotify_hash, path);
 	if (!inotify)
 		return;
 
-	inotify->list = g_slist_remove(inotify->list, callback);
+	for (l = inotify->list; l; l = l->next) {
+		struct connman_inotify_cb *cb = l->data;
+		if (cb->func == callback && cb->user_data == user_data) {
+			cleanup_inotify_cb(cb);
+			inotify->list = g_slist_delete_link(inotify->list, l);
+			break;
+		}
+	}
 	if (inotify->list)
 		return;
 
diff --git a/vpn/vpn-config.c b/vpn/vpn-config.c
index 8c6b0681..53998cca 100644
--- a/vpn/vpn-config.c
+++ b/vpn/vpn-config.c
@@ -461,7 +461,8 @@ static int read_configs(void)
 }
 
 static void config_notify_handler(struct inotify_event *event,
-                                        const char *ident)
+					const char *ident,
+					gpointer user_data)
 {
 	char *ext;
 
@@ -528,7 +529,7 @@ int __vpn_config_init(void)
 	config_table = g_hash_table_new_full(g_str_hash, g_str_equal,
 						NULL, unregister_config);
 
-	connman_inotify_register(dir, config_notify_handler);
+	connman_inotify_register(dir, config_notify_handler, NULL, NULL);
 
 	g_free(dir);
 
@@ -543,7 +544,7 @@ void __vpn_config_cleanup(void)
 
 	cleanup = true;
 
-	connman_inotify_unregister(dir, config_notify_handler);
+	connman_inotify_unregister(dir, config_notify_handler, NULL);
 
 	g_free(dir);
 
-- 
2.47.3

