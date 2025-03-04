Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DB1DBB13
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059592; cv=none; b=lLBvX0lGXfYh72QgA8RhvfudG3A6oSonql4K3CIUV/5eS0axAeM3XN44SljV0DprIKk/vA52H57a1lkrXs4vfq0Uf75mlP0VzcxzNqsQRfoRddUkUrAIMzuwagJdYuNTxBs/9nDxF+XGGP2/d9qYN1H4ns1AL/Sh61iDr9R8WL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059592; c=relaxed/simple;
	bh=ARM2Zg3E0H5Rgnjib9vPQZxSQjL7ZmsZ+XQGdyJu8u8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baKyU2C2QSfmAQLjhcdu39MMUlZKxg4RuwjYA5louOEdwXew7YKR5+ls/X9wbRj2et0TDlOLEo95yNk88PjpKctARFzeJI1fDjDx5e2XBuFy7EOuz//kNo8g96aZDr/ZkNRafn1m0MKlcsrFpNmYI4lJbudBBIROsGUs0k1G4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=fi6PzL9C; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="fi6PzL9C"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 14FCF164B52
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:49 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BCC9A126352
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 06/22] gweb: Add documentation to 'g_web_result_get_err'.
Date: Mon,  3 Mar 2025 19:39:28 -0800
Message-ID: <e78028fc1e4d24ed1f66aa927082bffdc09f8171.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=6BiM3CXRbEUsETTTn0rWxac0vZUilT2kQKvl4q5RImk=; b=fi6PzL9CQSU30MmomN1DSBoLUsgtwzSBdHT8QWsr247v5RtHYhMv7POFcganH9y4V8gAKX2b8PZBhmQ7NEK/zuErtGEaWzLeUKl8eh9hdsKAoagPiJyOEBBbItzV82ipLRxvfbuMlF+3Sj4ht8N0ZAQCwiLdMUpuqq11GDGDYYO0tv3tscFxfL/s5LuST7S2ZMuaT4puhGpAWIMxYG4CPz1Vj7zSjbq+BBahWQSRrnXg/jDKFdGpSIc2cANAG2APuM3XXGxx09QgAvutWRN2+SivwuY917krV7wFU+hYgWW9RyYzxAG9aGEFmeasOzmLI4UBO006vWw/7yIDtyfOvw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Adds documentation to the 'g_web_result_get_err' function and the
associated 'struct _GWebResult' 'err' data member.
---
 gweb/gweb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 6ada0dfa571c..72f83d8f27e4 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -55,6 +55,12 @@ enum chunk_state {
 };
 
 struct _GWebResult {
+	/**
+	 *	Operating system error, if any, associated with the request.
+	 *
+	 *	0 on success; otherwise, < 0 (negate to arrive at a POSIX
+	 *	domain error number).
+	 */
 	int err;
 	guint16 status;
 	const guint8 *buffer;
@@ -2463,6 +2469,22 @@ bool g_web_cancel_request(GWeb *web, guint id)
 	return true;
 }
 
+/**
+ *  @brief
+ *    Returns the operating system error, if any, associated with the
+ *    web session request result.
+ *
+ *  @param[in]  result  A pointer to the immutable web session
+ *                      request result for which to return the
+ *                      operating system error.
+ *
+ *  @returns
+ *    0 on success; otherwise, < 0 (negate to arrive at a POSIX
+ *    domain error number).
+ *
+ *  @sa g_web_result_get_status
+ *
+ */
 int g_web_result_get_err(const GWebResult *result)
 {
 	if (!result)
-- 
2.45.0

