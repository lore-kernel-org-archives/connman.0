Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18221DDA1E
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059590; cv=none; b=YtvicN+nfwRwPFp//Mi3UQufPw6G6TK/QCvCsj7tQnx2ZYOtzMttvc0rmZ7SY63nmS0EGd1CdPBweUgfuOhEVKgBYPMGIZi0QUXRCCDuwrr+ZYqvHg+YVd3CGzzO9M2Gn710FkytUg8M+UbfslQR7CypTLt5skHPxVdZOVyshEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059590; c=relaxed/simple;
	bh=45/I3XKHPZk4K7emAp1wjcllQpMZb3IDOmizSdr8Qqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYOre4E1NwN2bJTP5i5KpQ68zaZ3AxCrpE4N7ZfNjrEFr+2FkhUuOHcy6/pF+HpF2sYR4hNYbaT+qCifNQh5hkXvVoPMLbhHT0y+tZxnu/1IVjOhiuKnakVAoYLMvH7Q6JAPNboY5xTU7/9tKgVgodLp5fP8dA1q+PDzLc5lG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=DA4lVVbd; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="DA4lVVbd"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 2D9C2164B4F
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:48 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D91FC124FC9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:47 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 04/22] gweb: Add documentation to 'g_web_result_has_headers'.
Date: Mon,  3 Mar 2025 19:39:26 -0800
Message-ID: <41b6aad1ec7965c887d03910babcb19f37d26c1b.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=v3UWlyP63X+L3BtrjIGRHntqZVBmKWlSIv+N0LDC+OE=; b=DA4lVVbdGveyNAIAe6Y8/I0BbpRDKsJrGt954X6yQlGzh+eNNZJg/MvfFKSQmHSMGI8QZ6qDORZcc69ngV6T5z3eYlEuUohO0nJTPXpfqkLZpp1Vk4i9qnapNJ/YP2mlwibwyT/syFofzPKZBYRP3WVe06HeCxlf8BuCqRhSmr8xyG+0YIeGeZLwh0KlGMq33s8B6g45C/7+NWVs633xVLyHv7RVIsGNitAaAxTa/C5Zd6qIhk1m7xZTE1ugumN0b8DLo2MrmGqKCdhr4K4COghVpJ7CViwd53gdeTBNeJadBoTWwWcvDlTAEKxbbvJ4gjlS49EuMgTRn/0sC6ZCHA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'g_web_result_has_headers' function.
---
 gweb/gweb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 76f01c44b88f..d79d2d0808cd 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2504,6 +2504,25 @@ bool g_web_result_get_header(GWebResult *result,
 	return true;
 }
 
+/**
+ *  @brief
+ *    Return whether the web session request result has any HTTP
+ *    headers.
+ *
+ *  @param[in]  result  A pointer to the immutable web session
+ *                      request result for which to determine if there
+ *                      are any HTTP headers.
+ *  @param[out]  count  An optional pointer to mutable storage for the
+ *                      number of HTTP headers associated with @a
+ *                      result.
+ *
+ *  @returns
+ *    True if there are one or more HTTP headers associated with @a
+ *    result; otherwise, false.
+ *
+ *  @sa g_web_result_get_header
+ *
+ */
 bool g_web_result_has_headers(const GWebResult *result,
 				guint *count)
 {
-- 
2.45.0

