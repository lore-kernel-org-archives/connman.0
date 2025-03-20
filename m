Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFE215770
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513965; cv=none; b=i8I2hLQCdFTem7Ii0HpF+/YN9xkaI7NgDPrygadylX4PVHaqqKFXSB+RUc99A2lkGQJ9iXyOQ7v8ostjQEryt7Q+bqvczAhRh67hFju6AQCdkfj1C/er2ZV/wVQVeI1v27h8Sxoc5M/UioMV4TpzIw2qx0LNe6txiiWt4lK7BZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513965; c=relaxed/simple;
	bh=NpoCG42s2XK19IxPJj6S14OQ3iutoqYpTCdtV7gb4rc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPt4+eQmqb09XSf2kS48skm5jJj6IYKzhQ1wey/GU/8JYTv+vLEdZul+iknCLMiu+/hMYCDEhrvkGg0e9LbBwwJX1gnqhZh0Z0j6+VfUQglwBVjrc/7zUNnTX/4R+SPnKr/DnB6bnlqBKgGLB4zkM0FlxtzvJQ9rQbxIKwJRQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=M8m534FL; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="M8m534FL"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 55918164AE4
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:17 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0C2C812635A
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:16 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 13/18] gweb: Document 'struct _GWebResult'.
Date: Thu, 20 Mar 2025 16:39:04 -0700
Message-ID: <725a07ae93fe427cab9068c69ce7a6e8bfccb53e.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fWKqDWuso3HpcsWp4K8otMoDUZVqc1DtiX7o5Dp8uAM=; b=M8m534FL8vqTcAY4b68YC+bdOURw3HTpoBBJO4SJX13BuVg0e2rnlsWBdYFwakWNUxP7jaOo4w0OnO1lGWTmQm/sYlfej358G01ElfUlk15pu64wyV6ih1DPiN2006qhysyBg0psAvlBiK/Y4zn9u593LlcEhWnPJ7AxIw7rWGWCqlRJmqjEItv0fXNHHf1XHwPpcenpfUo6ovuvQ872Kinlyi2upGi9BtJVQqF4DTsV10A4JkeU8AYnws/aiLgqgLw79MvavTt9hunbgaEoMJ39AzsaCEpdoOWM0w++cSUMJ/J+rUYN5QJzOn8FqmMJO92WdODb1FjtqMNj1mfaMQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the remainder of the 'struct _GWebResult' data
members and to the overall structure.
---
 gweb/gweb.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index b0f2077a176a..ace3ac4dcb69 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -56,12 +56,44 @@ enum chunk_state {
 	CHUNK_DATA,
 };
 
+/**
+ *	The opaque structure presented to GWeb clients on received data or
+ *	request closures.
+ *
+ *  @private
+ */
 struct _GWebResult {
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

