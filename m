Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37D218AD8
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153424; cv=none; b=r/f2okSHiJnjpOGV3SJzsZrgsvj/dJbpaMcKJBPqtqLB8xOYouUJDgeg3VhwEbDYh91a4MBjWMN5zSTc2qMwRTlV6QJog4eruPvqKel1Pmmh/84aR/A8RGOd5iizJnIi0UFw4GJ/N2WEWHiJwLMKNptHx+inD8zjYrjUF/gXEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153424; c=relaxed/simple;
	bh=06WLl114GJZPfnjKsGAazCqiq6NhLEV4/oIPjyb+t+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cay4QY9VkzCuXaojieDoJ4KQCli6w63pm2CuATCMvw1TgS8606iDlwSj/mFefGVZylw4AWmB+EeefHyYe2f3+k+Xk9dsZN2zdHe+w2OUljAwzzO5oPkyAJXwElWtP2jIVFXkIMCHIqBo6qV93t1EcHYNPKYY+AY0cmekKm7gZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Tail6Y7e; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Tail6Y7e"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1C9CF164A8F
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:02 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C6551125174
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 15/15] wispr: Document 'wispr_log_proxy_failure'.
Date: Fri, 21 Feb 2025 07:56:53 -0800
Message-ID: <20250221155653.760046-16-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250221155653.760046-1-gerickson@nuovations.com>
References: <20250221155653.760046-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=D9gcQT5GxL9r3r50j8b9Y/P/CZlksDC0JO7cUogF18w=; b=Tail6Y7eMwKIe8nQrCWOHtGbFVeC7YAWaYrUjoL3XgOjuFY8he1CA7i6qAU1JFiIhJTqLdv6ArCmNFrvyCt+xVKgveqcE0RtfXihjqieNoqDQi98fuAf/c1/S/JfsHHItBnzSFT/b7BiAzH9a1LrkJ1DS8nZAcBlx6S1Xs6EoS8zaLDJmgUPa9RFoVZd4ywAjMfcrKFK/XlkPd8SiifoNJ6qPrRMyMePMHmzzIk8kG38Qdzg6CrNpu6k+qwBGOr3yucNclSdUR4lHxzZKZwzE/KhyW2VNLVjGGRE3K/ix5Oj4aVzyLADYWkoPYIf2jV1B7xnkXkFdNw1RQ4WezW/rQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_log_proxy_failure' function.
---
 src/wispr.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 10990c725986..9b0e4b24a3db 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1118,6 +1118,26 @@ static char *parse_proxy(const char *proxy)
 	return proxy_server;
 }
 
+/**
+ *  @brief
+ *    Log a Wireless Internet Service Provider roaming (WISPr) proxy
+ *    auto-configuration (PAC)-related online reachability check
+ *    failure.
+ *
+ *  @param[in]  wp_context  A pointer to the immutable WISPr/portal
+ *                          context for which to log the proxy
+ *                          auto-configuration (PAC)-related online
+ *                          reachability check failure.
+ *  @param[in]  reason      A pointer to an immutable, null-terminated
+ *                          C string containing the reason for the
+ *                          proxy auto-configuration (PAC)-related
+ *                          online reachability check failure which
+ *                          will be included at the start of the log
+ *                          message.
+ *
+ *  @private
+ *
+ */
 static void wispr_log_proxy_failure(
 		struct connman_wispr_portal_context const *wp_context,
 		const char *reason)
-- 
2.45.0

