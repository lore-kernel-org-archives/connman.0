Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347834C041B
	for <connman@lists.linux.dev>; Fri, 21 Aug 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328593; cv=none; b=YGAsD+YCqtd5m+9lPnqjo7x+MisIv5aaUKTh8lV8KCcg1VDvC/u7fgn8P2TquVC1xi4aEoQmGdUF3GHW7KA6lpDo8gDXLlQ6I7iDwy92CofMyxZLwLFHtSidOyK1K+vMjb17KoBG8HeVerPmjB8Y4alhJ1rmLy0CbUzKQie9c4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328593; c=relaxed/simple;
	bh=eBfASb46Eqt5reGM3dqZhZZCSdcJ2TNf4c611Dp/1Ks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP1q4dxddexFJnV+rUCwtxriaj//c0nfYzF4C8RK2ZuH+RW6JSSDhwOKQtAbjEZWQIDpimaLMtun2BCmD9WdScIDfWpasZiLOLrH4CCHSFixKp/iKiDp9yAKQbqk1l1Wl9BPBqPHE/z5J5uw/TX0dak6OdRLi7i0qkMjO0oN2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=u+Q5fEUn; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="u+Q5fEUn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qCoB1aTPeZ2zN/3gDM6V+Cl/oGkQNVvkP7/Vxf4I8C4=; b=u+Q5fEUnGjPkpxzepnTs7DmxG6
	lygfgwygEd8Uhr4CWXWMFgruSK5o+BOEbkwdSbRBgL+O4pKWs59Df4Kt18nOvzHn9bF/mtI3gqC5k
	u0lwXBkQS0vIxWwYMtEzeZx+psM0odj3QDW7IuE4HVbVFTFIwwfoKgyY9mDTE7nFl9gPfNs2x+Tn7
	tsp8agtqqWeDQNUcYPNzKnn8Igykmoxi56ud7OKhRYOxviqBBdcYjOwCBP+twYXq+GxKwhL74PTQh
	nPdbfIEUXoQRfeybL12ifGfo+6VjfSrBA6iRzoawnrSTVesyKy9LY0cexzMGR0KWVb/HCIRT1T2By
	ptaIeX0g==;
Received: from [2a10:a5c0:37:6501:3a8:42b5:e757:c455] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wxRoI-00AHD0-05
	for connman@lists.linux.dev;
	Fri, 21 Aug 2026 19:09:42 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] log: Add update, list and enabled check funcs, allow to disable debug
Date: Fri, 21 Aug 2026 19:09:10 +0300
Message-ID: <20260821160921.386690-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
References: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
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
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260821160921.386690-2-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

Add functionality to update logs (enabled/disabled) and also to list the
sources that are available. Add wrappers for both to be accessible from
plugins as well to update and list builtin logs.

Add a function to check if a debug is enabled on a file. And allow to
disable logs with "!" at the beginning of file name.

Add helper function to check for name/file match. Cleanup log.c code.
---
 include/log.h |   9 ++++
 src/connman.h |   8 ++++
 src/log.c     | 122 +++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/include/log.h b/include/log.h
index f4e1e3a1..9b9e388e 100644
--- a/include/log.h
+++ b/include/log.h
@@ -22,6 +22,10 @@
 #ifndef __CONNMAN_LOG_H
 #define __CONNMAN_LOG_H
 
+#include <stdarg.h>
+#include <stdbool.h>
+#include <glib.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -147,6 +151,11 @@ struct connman_debug_desc {
 					__FILE__, __func__, ##arg); \
 } while (0)
 
+void connman_log_update_builtin(const char *pattern, unsigned int set_flags,
+					unsigned int clear_flags);
+int connman_log_list_builtin(GHashTable *hash);
+bool connman_log_is_enabled(const struct connman_debug_desc *desc);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/connman.h b/src/connman.h
index 7ebda7af..b7a6bd96 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -144,6 +144,14 @@ int __connman_log_init(const char *program, const char *debug,
 void __connman_log_cleanup(gboolean backtrace);
 void __connman_log_enable(struct connman_debug_desc *start,
 					struct connman_debug_desc *stop);
+void __connman_log_update(struct connman_debug_desc *start,
+					struct connman_debug_desc *stop,
+					const char *pattern,
+					unsigned int set_flags,
+					unsigned int clear_flags);
+int __connman_log_list(struct connman_debug_desc *start,
+					struct connman_debug_desc *stop,
+					GHashTable *hash);
 
 #include <connman/backtrace.h>
 
diff --git a/src/log.c b/src/log.c
index 108dcb0b..bc005c99 100644
--- a/src/log.c
+++ b/src/log.c
@@ -148,6 +148,24 @@ extern struct connman_debug_desc __stop___debug[];
 
 static gchar **enabled = NULL;
 
+static bool is_match(const char* pattern, struct connman_debug_desc *desc,
+					const char *alias)
+{
+	if (!pattern || !desc)
+		return false;
+
+	if (desc->name && g_pattern_match_simple(pattern, desc->name))
+		return true;
+
+	if (desc->file && g_pattern_match_simple(pattern, desc->file))
+		return true;
+
+	if (alias && g_pattern_match_simple(pattern, alias))
+		return true;
+
+	return false;
+}
+
 static bool is_enabled(struct connman_debug_desc *desc)
 {
 	int i;
@@ -156,12 +174,16 @@ static bool is_enabled(struct connman_debug_desc *desc)
 		return false;
 
 	for (i = 0; enabled[i]; i++) {
-		if (desc->name && g_pattern_match_simple(enabled[i],
-							desc->name))
-			return true;
-		if (desc->file && g_pattern_match_simple(enabled[i],
-							desc->file))
-			return true;
+		const char* pattern = enabled[i];
+		gboolean value = true;
+
+		if (pattern[0] == '!') {
+			pattern++;
+			value = false;
+		}
+
+		if (is_match(pattern, desc, NULL))
+			return value;
 	}
 
 	return false;
@@ -191,11 +213,97 @@ void __connman_log_enable(struct connman_debug_desc *start,
 				file = NULL;
 		}
 
-		if (is_enabled(desc))
+		if (is_enabled(desc) &&
+				!(desc->flags & CONNMAN_DEBUG_FLAG_PRINT)) {
 			desc->flags |= CONNMAN_DEBUG_FLAG_PRINT;
+		}
+	}
+}
+
+void __connman_log_update(struct connman_debug_desc *start,
+					struct connman_debug_desc *stop,
+					const char *pattern,
+					unsigned int set_flags,
+					unsigned int clear_flags)
+{
+	struct connman_debug_desc *desc;
+	const char *alias = NULL;
+	const char *file = NULL;
+
+	if (!start || !stop || !pattern)
+		return;
+
+	for (desc = start; desc < stop; desc++) {
+		if (desc->flags & CONNMAN_DEBUG_FLAG_ALIAS) {
+			alias = desc->name;
+			file = desc->file;
+			continue;
+		}
+
+		if (file && g_strcmp0(desc->file, file) != 0) {
+			alias = NULL;
+			file = NULL;
+		}
+
+		if (is_match(pattern, desc, alias)) {
+			desc->flags |= set_flags;
+			desc->flags &= ~clear_flags;
+		}
+	}
+}
+
+int __connman_log_list(struct connman_debug_desc *start,
+					struct connman_debug_desc *stop,
+					GHashTable *hash)
+{
+	struct connman_debug_desc *desc;
+
+	if (!start || !stop || !hash)
+		return -EINVAL;
+
+	for (desc = start; desc < stop; desc++) {
+		if (desc->file)
+			g_hash_table_replace(hash, (gpointer)desc->file, desc);
+
+		if (desc->name)
+			g_hash_table_replace(hash, (gpointer)desc->name, desc);
 	}
+
+	return 0;
+}
+
+/*
+ * Log public API. Allow to control all logging for both internal and
+ * dynamically loaded plugins.
+*/
+void connman_log_update_builtin(const char *pattern, unsigned int set_flags,
+					unsigned int clear_flags)
+{
+	__connman_log_update(__start___debug, __stop___debug, pattern,
+				set_flags, clear_flags);
+}
+
+/* Add builtin debug desc's to hash table */
+int connman_log_list_builtin(GHashTable *hash)
+{
+	if (!hash)
+		return -EINVAL;
+
+	return __connman_log_list(__start___debug, __stop___debug, hash);
 }
 
+
+/* Check if debug is enabled on desc. Ensure that return value is 0/1 */
+bool connman_log_is_enabled(const struct connman_debug_desc *desc)
+{
+	if (!desc)
+		return false;
+
+	return !!(desc->flags & CONNMAN_DEBUG_FLAG_PRINT);
+}
+
+/* End of log public API */
+
 int __connman_log_init(const char *program, const char *debug,
 		gboolean detach, gboolean backtrace,
 		const char *program_name, const char *program_version)
-- 
2.47.3

