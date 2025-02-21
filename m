Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762121858E
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153421; cv=none; b=B8STBrNuUKv9jdefJRndsRH8vtZ9Fb7Ak2NNd0fYReNILjgGk452XGRwaq3/w1+QfKAESecnDjbbhOjEZxWS9szJ1i+tnEMS8MlXiLSO4Bo1RMzNfyyQHUxHSsRRb0RrFV5PBPNAJ2XzQirNHkpUHRFGCy4M2u2XM0/TpWQrjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153421; c=relaxed/simple;
	bh=61058HOzzhny93otOJskC3bMWkU3UTpzplzVkouhHeA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADn5O4JLe+qhMw/xOPe5mpa6RXbhl9EzlX2jE4sIU/crEaQw/7zndMLWCb5cPXkb5/s9l6BtcyXg0ymNcuy+qdvVmPVZ45ufcuL1qKVzzEeyM3rrhHFoT9yvu+K+bKSOFeqw8jD75ueSUfAzknAZxXNY3VUsCHVsdc/dErFplIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=jut9C0zi; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="jut9C0zi"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 9DC1A164A8F
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:57 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 55160125174
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:57 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 05/15] service: Document 'service_log_pac'.
Date: Fri, 21 Feb 2025 07:56:43 -0800
Message-ID: <20250221155653.760046-6-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=mdKw2krJ28x56Ubzs4NgZ5fW4XkZzV7PGpcs8wMzYz4=; b=jut9C0zibL7IkiOMnta7oam9FBtG/nRtRozUoZK6HJ9jTBTbh5g7bX9EYI0tazxsNkgjb8+g/9aq6qJsLVYo4Wa7bRjh34JF0HENJLnhHl/4JFZ8HwMGFAPYhUIZiiPx0Q8bm1WYFGSYTJoUUpOwr6OESXZggzz7N3j3YmiXw/en3NAVXfKiMne16DhtFsj1+O82SGDecsjhh3FONBSB8pxXncqHWNsBjjBv1KDsyT5Rnk2GBo9lFWT+Nlmu3zEkYQJGQ1eXCTG2ZaS8Bug2AHcVEQZUGWirUq0QfVkmgZdLcj9Bmp8a6+G/y0j6/K0Es56lAf0bLIz8H34xCNCAtA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_log_pac' function.
---
 src/service.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/service.c b/src/service.c
index 73cf8bca71a2..a4b13be2fd47 100644
--- a/src/service.c
+++ b/src/service.c
@@ -556,6 +556,21 @@ int __connman_service_load_modifiable(struct connman_service *service)
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Log the proxy auto-configuration (PAC) URL associated with the
+ *    specified service.
+ *
+ *  @param[in]  service  A pointer to the immutable network
+ *                       service for which to log the proxy
+ *                       auto-configuration (PAC) URL.
+ *  @param[in]  url      An optional pointer to the immutable null-
+ *                       terminated C string containing the proxy
+ *                       auto-configuration (PAC) URL.
+ *
+ *  @private
+ *
+ */
 static void service_log_pac(const struct connman_service *service,
 				const char *url)
 {
-- 
2.45.0

