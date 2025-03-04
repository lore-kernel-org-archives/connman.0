Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2CC1DF73A
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059595; cv=none; b=KUge/26nTyXenzggickv2HJ3VyWuCRI0vybBuYYsXcnXxaxGgciYnk19Jnk1HU5Kg2ljGdbg8VIA0DIebzR/5sapDsbw0qz01dqbrQaUV2ONDbyycTpHkLbdnp/snVNO3xZS2xJBC7zhH2ex7X6J3H9bWLp/AKu6xUu8j6Mza7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059595; c=relaxed/simple;
	bh=w2CTuhPGjk0Fn3bB+RzLBfW4v8Rp0JrNtnj94WBFKJc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYhO8vo4nQBdF9HcaDl2owygILaqGBCqFOjETfmg7+b06ZSU9H409mZMiA/xudrUt0XmHnUonmYvqfxO1CNKvh3A7hDST0PWpVviFtRbW5Mxsg4kcFvaTGtchyC1ZRbKoViYn9KusaLSxe+hb9SxX74gBApiTFAp2Ajg9wHy9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=HfM+uI9i; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="HfM+uI9i"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A5D7F164B52
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:52 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 5C878124FE9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 14/22] gweb: Document 'struct _GWebResult'.
Date: Mon,  3 Mar 2025 19:39:36 -0800
Message-ID: <2a78dc5c6e943f96271f4a49f1d0b02120167fbc.1741059516.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1741059516.git.gerickson@nuovations.com>
References: <cover.1741059516.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=3v8CY/6+Dkp+b0bB9D0HK8KetED44shCDGWVZGTzjH0=; b=HfM+uI9iGoATBW7/bElO/P/otPN48bhGFvyH0rIGq9KF7sbRpKqZRn8w074RoC1jytXboQaeIFWJMlNFP1nIrvpsOsYfAO65eG106/i9bXLmIJbYWTVBa1diovy1C++r+PqEjOPET7eMnC31qkWwjjCJqg3+kTrsTg8rimKazqowTbDjMNikXDjMGhzsNbcwpFfW1BXl9FKjdf3COFHxvwiXMPe/Cv+VsaVY3zey3J8TdsgZQj+cIhQNIHCDJ2OoQGr5eiaG1iexhZzkjpL2oQQomWqHAwS1w2Nw3wByZpjN8oL57dJ8W6HnHHtqJPb0S0S86iqv5IHtOOF7t59t+Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the remainder of the 'struct _GWebResult' data
members and to the overall structure.
---
 gweb/gweb.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index c7af3986df8f..050bb2d3e134 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -54,6 +54,12 @@ enum chunk_state {
 	CHUNK_DATA,
 };
 
+/**
+ *	The opaque structure presented to GWeb clients on received data or
+ *	request closures.
+ *
+ *  @private
+ */
 struct _GWebResult {
 	/**
 	 *	Operating system error, if any, associated with the request.
@@ -62,11 +68,38 @@ struct _GWebResult {
 	 *	domain error number).
 	 */
 	int err;
+
+	/**
+	 *	HTTP status code on success.
+	 */
 	guint16 status;
+
+	/**
+	 *	HTTP body content on success; otherwise, NULL.
+	 */
 	const guint8 *buffer;
+
+	/**
+	 *	HTTP body length on success; otherwise, 0.
+	 */
 	gsize length;
+
+	/**
+	 *	Boolean indicating whether the HTTP response uses HTTP/1.1
+	 *	chunked transfer encoding.
+	 */
 	bool use_chunk;
+
+	/**
+	 *	An optional pointer to a null-terminated C string containing
+	 *	the last HTTP header name added as part of a header key/value
+	 *	pair.
+	 */
 	gchar *last_key;
+
+	/**
+	 *	HTTP headers, on success, keyed by the header name.
+	 */
 	GHashTable *headers;
 };
 
-- 
2.45.0

