Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA017E918
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981311; cv=none; b=PXKCOvG8wOqKKJQnsdjxVYgJyZLiAYe5oShdzTjYtp6SW0Cte1UMDcbEZlaZdDwpKoascsC0MVlJiTuerhXHw/zPHUVP2pahbJeEgYrm2ty9NEtc9pUefzrT3bwL2ltwr8xZkj0EWcetCyIRXcPt1l/Eq91tqXUM8YRQ9nArTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981311; c=relaxed/simple;
	bh=06WLl114GJZPfnjKsGAazCqiq6NhLEV4/oIPjyb+t+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZT7XyB+ehriAo05vbWIPq61fbMkw+uC3wp2WqQ+gdoZ99OlEb+0NxOA6wiq+MFGLr9LjWo3UfGWuY305Z2UsXjpieK7qlERu099cQSpPl24RZLgsG/eiMfjrOkKiE0Dw6L0jRUKLWJA1hkF0IHswinnEyFuoKAgu/1Ou2whZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=tl51hRrw; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="tl51hRrw"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B40CB164A6F
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:25 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 688FD124EDB
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 15/15] wispr: Document 'wispr_log_proxy_failure'.
Date: Wed, 11 Dec 2024 21:28:17 -0800
Message-ID: <20241212052817.2021264-16-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241212052817.2021264-1-gerickson@nuovations.com>
References: <20241212052817.2021264-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=D9gcQT5GxL9r3r50j8b9Y/P/CZlksDC0JO7cUogF18w=; b=tl51hRrwrznh29goUO3pp1kefK4kYu2oHGyUue46eAFDkYI2Q03gP8IePJ8C2P3TpmH7LZ9J+HU6ZFqAu//SvIrf6MXj1Hgr6sygoBa11vRaikmwRPypy1wM6KQyW12WzTbD1hb21vT4bUGd6yXYyYQ5XdejdHgkfAh7diTyPMq0GqZgv8+bSNsLzD1B+BI/UVuRyuK0MXqY6Z6W7XkvVg2nA9uBzlZsHKfzWK6cIjGh5JuRC4apgEowreO/TsGqq6dHw9hGqlruFoKnRcAI0E9FmRSc96oAEBApMdBp/g89UgNnGb2F5cdB6ehXLzOQUsOGhRljgb9qUKGJ/xqdUg==
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

