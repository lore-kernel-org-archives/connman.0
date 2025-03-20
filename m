Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE821C9E5
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513961; cv=none; b=p+pGOv+pF4Ig37G1SYuS2NAyvXhry2nAgBbKy6e+yuruqGkFEZWkXQBLV2RJ+v9w0mOFFwjbJOqNkA3rPzyGdMb2zox7H2u303dgKpkzl50xUDa8b4AD/SFmM2VZAzkMqk7m2HkgNfOu6W1/xFwuDbEFRJ8l74a+S+MhkJv6I98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513961; c=relaxed/simple;
	bh=st2g3TFpAijiFCAn0B6ekfXSMyJGOSLZvL1graq0rSU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy3iHFMf9bIEk7MjnWTnH72Dnq3VVthiCw2pWEPhccLz3HUEFm3x2P5G5U9Y0DwBbN27e+uVZYh4PNeyKkSBzAryvVMetmZGoaMDGgeqI4rpBBYPQznE1247u19hewMnQ9WiKBZEz0tiWZQtYPjpmA5l4kDJWlfJVIsqnSAvIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=UApc47S5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="UApc47S5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C7AE9164A52
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:12 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 79A2E125183
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:12 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 03/18] gweb: Add 'G_WEB_ERROR' and 'g_web_error_quark'.
Date: Thu, 20 Mar 2025 16:38:54 -0700
Message-ID: <2ebf4d6f8bb66a8fcc1f630e1b09ad6f8d5414de.1742513884.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742513884.git.gerickson@nuovations.com>
References: <cover.1742513884.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Af4EnQ5MXO6FV5nfBrDT10J3uRnVSES0C7gNrm3TkuQ=; b=UApc47S5GhWdPrtEQlbPGhLkM9WwQmszZ3XyfwjcbOMeuj7GGcKdZXts/wBSTD7TsovfbmgFh7PlVVFLLNseqgJQeAu5hTOtYwBClz/4latRmfI8Utuf4nBOdrxrwin0nIqbgzglFrErrAG+c0Sb7G33ZoJYBRm7VK1h1pHDEO8aZRNZODZlakmQdIbZM9qt6u7C7OCN4ElVHaO0ro2h5/mupg7W/xt84Cyk3dR23imihRQZJRJnDSQPytQww1qz5A801Xdvxq6tpjZVI1MJeYDvAd5vHZ12PRjGI3ZeJu+k+tyS6Krteepamgus+lPBEZNXcN0D25XKt+V+zszHyw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

These allow allocating, instantiating, and setting GWeb-specific GLib
GError structures.
---
 gweb/gweb.c | 8 ++++++++
 gweb/gweb.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index d79d2d0808cd..94d304bd40d6 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -157,6 +157,14 @@ static void _debug(GWeb *web, const char *file, const char *caller,
 	va_end(ap);
 }
 
+/**
+ *  Return the GWeb error quark.
+ *
+ *  @returns
+ *    The GWeb error GQuark.
+ */
+G_DEFINE_QUARK(g-web-error-quark, g_web_error)
+
 static inline void call_result_func(struct web_session *session, guint16 status)
 {
 
diff --git a/gweb/gweb.h b/gweb/gweb.h
index 90cccadbe883..6768601d6c69 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -119,6 +119,8 @@ typedef bool (*GWebInputFunc)(const guint8 **data, gsize *length,
 
 typedef void (*GWebDebugFunc)(const char *str, gpointer user_data);
 
+#define G_WEB_ERROR g_web_error_quark()
+
 GWeb *g_web_new(int index);
 
 GWeb *g_web_ref(GWeb *web);
@@ -183,6 +185,8 @@ void g_web_parser_feed_data(GWebParser *parser,
 				const guint8 *data, gsize length);
 void g_web_parser_end_data(GWebParser *parser);
 
+GQuark g_web_error_quark(void);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.45.0

