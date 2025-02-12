Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216221324C
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403579; cv=none; b=nxluY6SfnE8n4NJrFTWZwGf6y+2W6PBPu8PuadKCsqrhyly6seyofTah17iQo9dM6h/sEfWcIqL/3JgKVccZB74MckGdpQYq7wPhvn6VwJayXwd2xB+FKfCoFJnrZfeZUUqQrHsHFyQX10cnq3/1liMve34TdclQnnb1LcgNIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403579; c=relaxed/simple;
	bh=6CbmRa0KW+lIfwQmjGr+2byl9TC9RYujyvS1TnUU6x8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c37jsLR+PwbhIgkDNMSOO2SLyagAnDHFVxEwOUvkGHGh2b30w2UoySyuBtsydiChNNToARvP4uS9AkeTqZlOrIYLwn2syPplqU08Q7Xt9UKrfV3GYR2CUmatUQoNlUIH3rf/pZLjxoVvlSsHx2eGbhpwwyJPqfq6SiqXkhCAueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=E2VMGWxI; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="E2VMGWxI"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E4ACE164A45
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:36 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id ABAA0124F28
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:36 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/4] ofono: Documentation: Add comment about entry condition for 'context_changed'.
Date: Wed, 12 Feb 2025 15:39:32 -0800
Message-ID: <466481561da0b9599007c43ece3fb362785581b6.1739403363.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739403363.git.gerickson@nuovations.com>
References: <cover.1739403363.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=WwRID6dMKSvk7NrjqKLN6e7S2+au7LWxSPIuemmNiq8=; b=E2VMGWxIkqOiiDZwZ7OjiRHSvPWVkMek4G9YYPLCalTYv0JPCqUy6gy5WmNvuiXww/Ur7LYH/XgbJaKnKh4MCoLi/bjHNR0fsQhK4Bjmq20tD7kdfItfUlM3F+BwFWNVr8TNrzIRfxAGvEg34oOgdzrCMeRQNjWqHZNC2zA6G8qawq+XLcP3lui0U31HmGJ/S6z4oyikMGdQWy20x0HoOSrW/raFliOsGQURuDnHYaHZ+SCOoWM393pklAQhx4BoCxVURJesnGy+ewZxJLDL5idNsZhd35od5OyQDO4bSLCmggg7qpiDAGVwh75Bt+mPSr/ssRF+pFeerl73B5kLJg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Adds a comment to the head of 'context_changed' detailing why the
early exit condition exists: changed cellular contexts cannot be
processed before they are added.
---
 plugins/ofono.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index b7a5f80bda5c..820299765c67 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -1304,6 +1304,12 @@ static gboolean context_changed(DBusConnection *conn,
 
 	DBG("context_path %s", context_path);
 
+	/*
+	 * If there is no modem in the context hash for the associated
+	 * context path, then there is nothing to do at the moment as
+	 * the context must first be added before we can process changes
+	 * to it.
+	 */
 	modem = g_hash_table_lookup(context_hash, context_path);
 	if (!modem)
 		return TRUE;
-- 
2.45.0

