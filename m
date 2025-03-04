Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3B6A33B
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050689; cv=none; b=uMQjzb5f5g+BuT66cUPRV03I+A0qFR1YcRbSTVMTn4JRJoMDI3bp1go1oq8PdJoxXJHkYguZvAnvqOhh9XlfVgvLbRYOY8uWzHyWK4dc4Ju8QYcCnzhVxMk9AVtlc6K77ZI1rLK4Thw82rlZ9CuT8ZrhruA6NE9rCc0ZmODzYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050689; c=relaxed/simple;
	bh=w2CTuhPGjk0Fn3bB+RzLBfW4v8Rp0JrNtnj94WBFKJc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm/3uDfBRXM3fjOadQhX+OcofX7H/NPWr8bGTONDhnOxFhntd85j1MO68vp5mgs9q9KXhi84vGIUBuF2HUJoICwq5SSiA6gM//hEpo0NtIxfnJcbgob/MqYXnOjJmY+Lpz113D0s6HWHhiNQ6e0BmL5qSaOPvovFcWajghu0CEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=nW/6sfs5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="nW/6sfs5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C150C164B59
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:21 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 787BC1260D5
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 14/22] gweb: Document 'struct _GWebResult'.
Date: Mon,  3 Mar 2025 17:11:05 -0800
Message-ID: <2a78dc5c6e943f96271f4a49f1d0b02120167fbc.1741050622.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
References: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=3v8CY/6+Dkp+b0bB9D0HK8KetED44shCDGWVZGTzjH0=; b=nW/6sfs5fqp7ublPO3PgQA7zBFpDMnfnqV0SmG7qODTHSsbi3SoMa68owwQ1Dg8WfSpgFUB3EVp8jEUVTM5toExPM+s8dKyU0n7jYwQJ7rjMCe7FQKc8PE1a/42EudTMD4D4PWhJ42aQvhTy3ZYAy7Fo4AyYYsEDFdyUVkYKmSLEyTyih1TmA0Z+HR1in+07UHlLkLQWR2pR8T5Wrys3WKVFpqDRHz+MzGebel+hFns6Wj39nHBHo6o8WalJb/Gyv/648MOr9iLZkwS13SwK5X4E98rQRxNeo9pIXen+RhY11trpJy4ddTtvJYVWp+Zz6WJBJ8KD39xG3G9SDf38sA==
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

