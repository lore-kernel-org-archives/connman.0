Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFA2874F5
	for <connman@lists.linux.dev>; Tue,  7 Jul 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415830; cv=none; b=qz+QkNsJ7kpHXCF4bweBFsx82GIlLJknuwiR2/NhYTSr+sHNdiMlZCN8GaQB7WBcs4AcFTfy4XjhnNCz6cmKrwaOxpZw67PpDR7t4vbOzhToR4aR993s0HnNM2dp8jy/VZi/Zp1OFcjYrGK5ee+nG8jGdf55JgBkbdFilfNyvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415830; c=relaxed/simple;
	bh=I8Cvj2FtXLU3nHcCmNuHY/NHAuLQ/vAnQ0jdGKmGd8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2erTMz+Iyse1MvMUlMkhFCq7CGFVqUmQcXKvBcxIYbi9un8PMqGenYhnXevL8NggKshDxgJ3RlkMK56Qtkd12nn06KiIUM2o4gQRqCvc7mThnLpRjM7qfV2nsCqJugyTbu56dYyWZpa8T4moQylr2ZXJG+dVDiLyqrTs8savzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYvQs7H0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYvQs7H0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so21089745e9.2
        for <connman@lists.linux.dev>; Tue, 07 Jul 2026 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415827; x=1784020627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRPP1eumBJJG5aZTm1HUbyPxMOVqROZ9Nhxk7uhDzBk=;
        b=ZYvQs7H0cZVADHXTuXbrQ52P2FWgV0SBsS63iiGyqyGkqDZByrE6AHchmDymnF1R/0
         TlGsi2DDIOH3TlR5iQadCFYacV9jbiTOacwSEnZwqLqJIvcBEQ+bGtEWGYaBzRVXp8S8
         Zxipu7d9ZM8BQWQJ7GGpEtZpXmY1+6TjnNiRjcZDZ/LjbhhDJPL1f1/x+6HbCwKwmobb
         lz6PZKfr4W/xTeegnMs/73pj8wj8+UPFwu/jWhVYwNNxfEVYX76j1Cdbly1wXGopDUtA
         9H1i8EBSfw5BISpng2FyRdOGdELI5/s66J4vZjCJHnvEEstoXO7GnVMXUauRfFOwIbIG
         BfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415827; x=1784020627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hRPP1eumBJJG5aZTm1HUbyPxMOVqROZ9Nhxk7uhDzBk=;
        b=DjQehE6AjmvTIfvdzyOr6hNhpVSklvEQgeT03C9BOqn9J7aEJVClQ1evO0azn9jPZg
         g+PR/DIOhyi7r2kbsFjxnmNDpoli1Ky4kVRPOHql1nsuWk2CdsA928of7RdbkiQtD7TL
         5X4qQn2LDHVjI2jELd3nCd0b8RtOEy/GZ4YFEGxWfa7t+vXsh9bu5/E09gXyH3zvKJ7Y
         8/ZyMigkJO1zzYUwZZKm7Hi9D2Rd9kBA4gtKDlIGwo5WIlfCcFxCDV3p08YsG9efNPpf
         tkd14PSCy9r7Jk8aExOtyJCWNQmaHyZrn3T3+FXdcjcYFEf7KJnBHkq4irLBVLnZOJeo
         ypDw==
X-Gm-Message-State: AOJu0YywbIeNw3pedTuSxBjZ8wwhAmRJOGilPU7TZdb+fF/rY+hlvxUU
	PUTSUvHBdEdjekNMF2fw8x4vo3rMs8nJTgmbodW9Ub2tDIEjzsmoU00mkOltQwoXCM0=
X-Gm-Gg: AfdE7clTbWAuiYPHhsA7N66t8B8/yQNnDBQaXh/SP7bIPRPk6m2yXXTKIDH0L/mLu3m
	4HBNIzmOlQ4TvRjUVGipBhn1X9P3GX7owQ0dV/a4gFdDmeUebphC5qe14Is9h1ONu6MZG0uQX0n
	ciwroS5XrcxBwf/G5WeWB30AbAXAIgEvikVDYrN/cVm4oBRnh7DwqjzUF4J24RYkHjGCDTlQBgY
	NrZV0fgX+oRwLNRoLnWHOgUBHIvVjTErIm9xDPIlRHpsmNUpXr26wtiuf9i+16bzsQm74/ip9y3
	/GytQYl5v3EQvp47S82LwdFzF+C0CnZClYZJb1BjvKKRmYf9MgOBrbT1LFX4tuZmOb82gTwNNE4
	zH2Kdo77GgHmy0ZeQJNx+2L9XRjuTwlOS340XjRgJXbuHYH5VuQTmUc9WRcT4jxsEpjJ711rWiS
	UK8RTrJNQNotz+ucBPk9prK+3/bxdnGQXfvPTW0dX+WGvosB1HbPbT556j1w==
X-Received: by 2002:a05:600c:8a1b:20b0:493:bb23:152a with SMTP id 5b1f17b1804b1-493df09c27dmr36225655e9.34.1783415827153;
        Tue, 07 Jul 2026 02:17:07 -0700 (PDT)
Received: from Mac.degu-bleak.ts.net ([2a07:7e81:8205:0:90ff:59e6:6895:a56c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm63406665e9.13.2026.07.07.02.17.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 02:17:06 -0700 (PDT)
From: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
To: connman@lists.linux.dev
Cc: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
Subject: [PATCH 1/2] gweb: Normalize received HTTP header field names to lowercase
Date: Tue,  7 Jul 2026 11:16:44 +0200
Message-ID: <20260707091645.90508-2-giuseppe.eletto98@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260707091645.90508-1-giuseppe.eletto98@gmail.com>
References: <20260707091645.90508-1-giuseppe.eletto98@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modern HTTP servers, including HTTP/2 and HTTP/3 backends acting
as proxies, commonly send header field names in lowercase. While
RFC 9110 Section 5.1 defines field names as case-insensitive,
connman was performing case-sensitive hash table lookups against
fixed mixed-case strings, causing lookups to silently fail when
the server used lowercase names.

Normalize incoming response header field names to lowercase at
parse time so that lookups succeed regardless of the case used
by the server.

- add_header_field: use g_ascii_strdown() instead of g_strdup()
  to normalize the key before inserting it into the hash table
- received_data_continue: look up "transfer-encoding" in lowercase
  to match the normalized store
- g_web_result_get_header: scan the caller-supplied name for
  uppercase characters and normalize with g_ascii_strdown() only
  when needed

Outgoing request headers are left in mixed case. HTTP/1.1
requires that servers recognize header field names regardless
of case, so no change is needed on the sending side.

Signed-off-by: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
---
 gweb/gweb.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 0a87da64..26d18544 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1201,7 +1201,7 @@ static void add_header_field(struct web_session *session)
 		*pos = '\0';
 		pos++;
 
-		key = g_strdup(str);
+		key = g_ascii_strdown(str, -1);
 
 		/* remove preceding white spaces */
 		while (*pos == ' ')
@@ -1390,7 +1390,7 @@ static bool received_data_continue(struct web_session *session,
 			session->header_done = true;
 
 			val = g_hash_table_lookup(session->result.headers,
-							"Transfer-Encoding");
+							"transfer-encoding");
 			if (val) {
 				val = g_strrstr(val, "chunked");
 				if (val) {
@@ -2789,13 +2789,26 @@ bool g_web_result_get_chunk(GWebResult *result,
 bool g_web_result_get_header(GWebResult *result,
 				const char *header, const char **value)
 {
+	const char *p;
+	gchar *lower = NULL;
+
 	if (!result)
 		return false;
 
 	if (!value)
 		return false;
 
-	*value = g_hash_table_lookup(result->headers, header);
+	p = header;
+	while (*p && !g_ascii_isupper(*p))
+		p++;
+
+	if (!*p) {
+		*value = g_hash_table_lookup(result->headers, header);
+	} else {
+		lower = g_ascii_strdown(header, -1);
+		*value = g_hash_table_lookup(result->headers, lower);
+		g_free(lower);
+	}
 
 	if (!*value)
 		return false;
-- 
2.50.1

