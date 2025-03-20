Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E221ABDC
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513964; cv=none; b=f6jpjNSCq9c9fIFJ4UqDk1JD480rgKD5NbjxgbI/k7oE5meVz/QJe1ybUyG0l7V1+ivi5KVnA/H6qkj0QI72XlVKaq3i4KWgW/xTI+4grmU6MFpBhYL982mkMwzBLLPKsUiTclcFKH1Q6FZC2tZovK8ygAgfZJdKZJwU5KNjwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513964; c=relaxed/simple;
	bh=7Sr0VVHjFtJzy1ZLzpfY2uPu0G099Fej/mHOKokLMDg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4D4cLydLpAi0C48Pn5jHyJaeDft5TkoKQAVbzXJw3fQTkoaG8KZ2YoA4lGVh2ll/G7g/GEsuMwYZsO7S8MZSDV3i5ko3SYiioS9k/MK2HW4tpNftyrygbznu7+JnL+njDhMAwryG7JtBmSUiEmkcJUwrTthA27uExVKMeDV/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=V53aOT1N; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="V53aOT1N"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 9C43A164ACC
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:14 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 52634125183
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:14 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 07/18] gweb: Add documentation to 'g_web_result_get_status'.
Date: Thu, 20 Mar 2025 16:38:58 -0700
Message-ID: <e8edeeaa7d76932cb4051b408efeafaa77b1670f.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=idQoagG4PgzZMjMBbluwzrzFYzLdWAkcCwj6NB6+7u8=; b=V53aOT1NxNYzB9R0goSgmUXM+upE9auEYlG1Q/ahj44qB02rLnJ1FHyTlQ/RolFTEzTzlCYdZrFiq10jy304bvgvYNluQBZQ6Kfh4Ipgpx47LUqfLAwGhsQ/oDrxJNguzxiMmD5RpBPsEmTFaNDKXoGv7CB4b235VBGdDps3cV9TOlfGpwgN+yjwTteMny+0wWv6npf139TfdEAjoI7F+WgAQb+9Xg40uDCYRwzkBvJ9+nfjfvit02zTPO5fI+Gdl6PEcy8wyAVn+c5g0tHRH9b7RwUhTQMP9/U5aYUq9O5IwQt/eDa+Pry3Ot0x5uUpwnQaiECIanyHaf1ZUq4F4g==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'g_web_result_get_status' function.
---
 gweb/gweb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index e4dad4f95e42..c22ca8ef0aff 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2493,6 +2493,19 @@ bool g_web_cancel_request(GWeb *web, guint id)
 	return true;
 }
 
+/**
+ *  @brief
+ *    Returns the HTTP status code, if any, associated with the
+ *    web session request result.
+ *
+ *  @param[in]  result  A pointer to the immutable web session
+ *                      request result for which to return the
+ *                      HTTP status code.
+ *
+ *  @returns
+ *    The HTTP status code.
+ *
+ */
 guint16 g_web_result_get_status(GWebResult *result)
 {
 	if (!result)
-- 
2.45.0

