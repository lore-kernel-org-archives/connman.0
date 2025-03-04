Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132413BBC9
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050685; cv=none; b=RMjt9CcYxux1oQeZKfoWDONUFY6e0HjnI3LkdSFFr5oJFncRw8h4QmhqR1aBOUU7sHF4HFykZTHfN0nrxT9lDmsNIdThHeLIvETIfEkLlEMo+m3TU0AXp+UTPdrvxRbW6Fnm+qsL0mgnyBFbvQxGfuRKF7B9iEsquUWWEz6z7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050685; c=relaxed/simple;
	bh=45/I3XKHPZk4K7emAp1wjcllQpMZb3IDOmizSdr8Qqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fT9DjXVkuo6uUSPFBvdCS+rrQoqejzinLTqOQrcxcAKSCULJ8vZumItQtB5crFRYKzbOJEpNhWj0cDFAV/fJ+T0t/U3xUX6UK/vEFbycrDaxvvo5GAsq4bETvPW2T0U2TZ/MVmUR40nrJufU9RNC3JWlFP7OjGlXbT+2L2IqbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=inGKM/8r; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="inGKM/8r"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 53411164B4E
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:17 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0A6F7124FD2
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:16 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 04/22] gweb: Add documentation to 'g_web_result_has_headers'.
Date: Mon,  3 Mar 2025 17:10:55 -0800
Message-ID: <41b6aad1ec7965c887d03910babcb19f37d26c1b.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=v3UWlyP63X+L3BtrjIGRHntqZVBmKWlSIv+N0LDC+OE=; b=inGKM/8rhgVWqPmmS86kSUnRgqIE3GuQlaGts4o7pQPMg91pPGLKApdoiX7cESbDutwnQ0cDGS5AxmZC5mBR9dN+3zrBNDfO/xVY7E+jFkVqyymf/ug+Gf11QnR5k9FYvYesqSHEq0vwvpj7gV4o+4GZ3TNsQBz2J6IrdbOTCiL7viIXMe4qJgFjtqmlGzW0stfUAm9PJ/R1D7vuSmAgxkjsFF24n55oUA8XLziD9V6mVpC+3t7wRnMslIUWtIWqRRq/tfAeU/zJQRP9zr20jo9OVNSy+VGwdiCrnYzlTKfbAWpT125/qmOSVJHJI0jEQT4dcgsompf2vkjtMxFgMw==
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

