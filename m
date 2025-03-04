Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EA1C84DB
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059597; cv=none; b=I+P560l0u9BiR82WLGB2Q76eeaAoA0BEr275smssy2l8GVVnp9VBf95jbvlsp6xUmCYFa5Rcpo5nrKMr76acoer6w5go4i46LwQNILIvoReBqFCmbebGRXgUKoq+x7TcL1cBE+pDv/rRfX1XKAdnii14okOW4b24jtPlk5kWlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059597; c=relaxed/simple;
	bh=ZZF0+/nLOFuY3u4SKPLiUn81hqwkXKcdRyQQZJhEpOY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMIr+zYgb8X5gAGbLFIlBXxDfxQdRg3lFwjMTQVBOE9ogu7lpkuADa2jcm5iWe8UiAhst4OuW9PR+sujHw2DAFuh9ZONQcBR9JrJjXzmY8gKj4YNrNPLkNK+lBJUAwi0WxzBcgUGZSu8SVBYvoNhtMvAAAXQNHQkhUqqpFrTETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=LdhbttOi; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="LdhbttOi"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 57AEB164B50
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:55 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0E58C126354
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 20/22] wispr: Document 'wispr_portal_web_result'.
Date: Mon,  3 Mar 2025 19:39:42 -0800
Message-ID: <d11922feb1d52df182db29da9c1fe02698b06b8c.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=bId5SE+Xxi3uGTG3YsYcXNBW6rQ2jPjTFhr+Yn5Of2Q=; b=LdhbttOivba+0Zs90+4zKGr2Z23N0PsncRnhVjWgIuO5XOLK1dgMAQTOqR2HSt5mBWqsnrILMBWfv9ONR78z32McIuTq5gK0TQ1OcINhV6bapTjXNKGknoqVfJC5Y86SalRoleB+Ns9K7E8sumexfqdUWlX7+t6xkD/E5zQd+GRJtO0OvxgaFZOYW4iNbNxbA6LgTckzh0r3n1umBqpWQ0lOWASIXlgfBlpA1P4N8fwsqJ6tTBe4kTaC8/UliF/Ifs9xiCQwbVWD86q21wIr+zd4JUgVzME5neXlXeBjEH+dVqzCCTNT/HQAFohv7q0+xUjVcNmn2Jv/fzWxuKe2IA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result' function.
---
 src/wispr.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index bab12400aae7..963454c823b0 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1145,6 +1145,33 @@ done:
 	return;
 }
 
+/**
+ *  @brief
+ *    Handle the receipt of new data and the potential closure and
+ *    finalization of a web request.
+ *
+ *  This handles the receipt of new data associated with @a result and
+ *  the potential closure and finalization of it, if appropriate.
+ *
+ *  @param[in]      result     A pointer to the mutable web request
+ *                             result with data to process or to be
+ *                             finalized.
+ *  @param[in,out]  user_data  A pointer to the mutable WISPr portal
+ *                             detection context associated with the
+ *                             "online" HTTP-based Internet
+ *                             reachability check this is finalizing.
+ *
+ *  @returns
+ *    True if web request should wait for and process further data;
+ *    otherwise, false.
+ *
+ *  @sa wispr_portal_web_result_err
+ *  @sa wispr_portal_web_result_no_err
+ *  @sa wispr_manage_message
+ *
+ *  @private
+ *
+ */
 static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 {
 	struct connman_wispr_portal_context *wp_context = user_data;
-- 
2.45.0

