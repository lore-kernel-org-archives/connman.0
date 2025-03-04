Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AF1EB9FA
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059592; cv=none; b=V/5nC4+RLWU9QWgZM7yO6S46bocz4hSflz83yCn1+1tDP5P4szcXwsjAQVJnvqGZreuuvPPJAObHzn4KV0hGEHDejAR0Y/z+Uj5J4IIqMPme1GFs8BSjO8tvGXeE6mDrQdsWwfKH9foZGjf5JfLJptSDuuOJ+yuC/6gXg58INvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059592; c=relaxed/simple;
	bh=SLsoLtGt4glfIO7MTGQCzMsadM7FpXEPZJAXxkDnygE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaIwvvZHbnRzivVVTKQ+r1NNgVdCUuFTns5bdAja0brw3xGEAOUj81jDJCADG4ABvbJYNQs/b+XBF7OldWGgMAKbhrRBXg/P62v+2rtcgi2G2nGSdXfcWd4OzloQopwuydQWCn6TR/SGMO8DcaKMV4oRSk2BXG/0segRYHqyzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ftunXxjC; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ftunXxjC"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 98FBB164B50
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:48 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 516BB124FC9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 05/22] gweb: Added 'g_web_result_get_err'.
Date: Mon,  3 Mar 2025 19:39:27 -0800
Message-ID: <3e0b57485a7f50f031d7853b01a40a4821704e05.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=2phLsebY6ZrDr69vpjoZYmfgNhsUrpxApHY06pjvRi4=; b=ftunXxjCV4Rmc7AhLvPguMQ2lJjU0s4zcnQS7jqaObwOGigepCPbnTceOaTdNO3SJIvwLICu3J+yvlAogyhQy8qBJi6sriAmtL0FqRORLPKPwx/JWVOBkkGEycogvOYoRyRXUyYQZ8xbcjNmk/+TbCIyXo3VU8odAzPAzTbf24oZC3HLd+Jt7i79wsolYWiPbWuniAIJTCL9ZRdMpBh7R+gHpthd1NYqPAv5/nC98IEIU4sIuyCE4TQzYri+nR4qvTunxEUbZ31QdZnAx9ZNS1ki8XUIXgOPEQO/9lDwnVxQDLa+xutaZsG/7jKzXPjF1T4cJ0v8JPiFeMHy/ht4pw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Returns the operating system error, if any, associated with the web
session request result.
---
 gweb/gweb.c | 9 +++++++++
 gweb/gweb.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index d79d2d0808cd..6ada0dfa571c 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -55,6 +55,7 @@ enum chunk_state {
 };
 
 struct _GWebResult {
+	int err;
 	guint16 status;
 	const guint8 *buffer;
 	gsize length;
@@ -2462,6 +2463,14 @@ bool g_web_cancel_request(GWeb *web, guint id)
 	return true;
 }
 
+int g_web_result_get_err(const GWebResult *result)
+{
+	if (!result)
+		return -EINVAL;
+
+	return result->err;
+}
+
 guint16 g_web_result_get_status(GWebResult *result)
 {
 	if (!result)
diff --git a/gweb/gweb.h b/gweb/gweb.h
index 90cccadbe883..e9a8eda9f8f7 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -162,6 +162,7 @@ guint g_web_request_post_file(GWeb *web, const char *url,
 
 bool g_web_cancel_request(GWeb *web, guint id);
 
+int g_web_result_get_err(const GWebResult *result);
 guint16 g_web_result_get_status(GWebResult *result);
 
 bool g_web_result_get_header(GWebResult *result,
-- 
2.45.0

