Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB61DC046
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059590; cv=none; b=h989UQaNbdsU2lp4Ve8BLsk471SVFHMpEQoKvORM/5ufzud0mXU+Szqc+YYU3mgL4lYnzfZukFqXUBdeRbJJUooizZYRTZxWn1VClkJbqWhCZ2GNtaS9oRjWs7KDrDzJ11m/j+IK/+vs/2jXRzMfo86tVrX3WwrrcThHUiPFamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059590; c=relaxed/simple;
	bh=47fuW5Tuk/YBmLZBmPu+sGctbNk3+gYm9LTpx6g5i+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RE6MwoSw/MXup8NpJcBnJv8oRN4+f+VNNPj92zIvQQXBa3g+vyfjUK3ybN/AHoj5z+glhPsrJSDYCUWcCvp93hA6GijXM9/shk8QUXl+RBZTHexXPf6ySVAGycd/awasg/TJ0rwTq6Mjd0ZJurhk9ID20oYDFsCa86hQX/kCwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=MGcTBawj; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="MGcTBawj"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B5514164B4E
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:47 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 680CB124FC9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:47 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 03/22] gweb: Added 'g_web_result_has_headers'.
Date: Mon,  3 Mar 2025 19:39:25 -0800
Message-ID: <33b4c08a164f2a8030dd86e254d79f25ac7762de.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Ra9UY3AraOCIXWWAyyZPT2eKq3kmnD1hDB2+GcQ6DPE=; b=MGcTBawjVKQ6JtQYLfaTiyCRgAeqSa+Pge297v3CRs3WkKDxKCpxari05pDXM+g9BuQ9EgvunJNJGiDwEfWkSfMt1j5di8eOK1mwLvaNeD1dkzL5AHFhVJkU9SYWW7xrAsDD6/G1Mq7aWlm2eeq6iwx9SYifT0mwxfgvUs9XmvnRViiqeeIRXhF5k5CUcza5gAqFTa3qNqidYp7eRLas0sElqzGILbaGz15SS5XsSBXugkpo7efD92wcy06GF7ZFf3actObtMYbMe5Ol52GmDvOiI3AJOWSOKaT7O1zQkHotB+l8RzigzVm4+kTMBmDIUUXcsRbSEYmnIb2NPhVNMg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Return whether the web session request result has any HTTP headers
and, if requested, the header count.
---
 gweb/gweb.c | 16 ++++++++++++++++
 gweb/gweb.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index d4bdbdd641f5..76f01c44b88f 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2504,6 +2504,22 @@ bool g_web_result_get_header(GWebResult *result,
 	return true;
 }
 
+bool g_web_result_has_headers(const GWebResult *result,
+				guint *count)
+{
+	guint size;
+
+	if (!result)
+		return false;
+
+	size = g_hash_table_size(result->headers);
+
+	if (count)
+		*count = size;
+
+	return size > 0;
+}
+
 struct _GWebParser {
 	gint ref_count;
 	char *begin_token;
diff --git a/gweb/gweb.h b/gweb/gweb.h
index 7c65aebf4698..90cccadbe883 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -166,6 +166,8 @@ guint16 g_web_result_get_status(GWebResult *result);
 
 bool g_web_result_get_header(GWebResult *result,
 				const char *header, const char **value);
+bool g_web_result_has_headers(const GWebResult *result,
+				guint *count);
 bool g_web_result_get_chunk(GWebResult *result,
 				const guint8 **chunk, gsize *length);
 
-- 
2.45.0

