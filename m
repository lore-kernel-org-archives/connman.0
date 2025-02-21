Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B5218592
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153422; cv=none; b=JpxTDHXpIVD8hRGE8ssGls8gJbHrIwSYlv4RUbx4VAEFZ2BLp0eYHFNqbpCdQmE1S+fqveEhP8ogKx8jCNFyhBDeF7FvJKnK1aA69+KUFGlQWJrUlfREP15ctCkIqiEKL1bmn1vMo20/ZfCTDTOH3ImMkH7slvzsfBH781f++zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153422; c=relaxed/simple;
	bh=57gUCku/I2vxPDcqPB+tkAZerP/lYQk5jOQAQyv5Rb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQa+kImzG18BKwO1fox15Q72tYrsfJ6erJc8v2nizil9WoxZpOqgDkSgIGiHCr7GD1HZ69nhdTLZRMWXSzujddKz6Ife3k6GI2T8zJ57a49X7Cs06IpGagEsFg/FqbNKuE+2ocugGnDdjwCrCSKXkUUt/TY0EQ334Cb+lEVkkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=QJG6WoVR; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="QJG6WoVR"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1633D164A91
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:58 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C15A5125174
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:57 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/15] service: Document 'service_set_pac'.
Date: Fri, 21 Feb 2025 07:56:44 -0800
Message-ID: <20250221155653.760046-7-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=oIYv6aOm5waad1uh46Oa3qRiL7Tnh7VvBczHijDerzc=; b=QJG6WoVR3FzW2U5GfWVjgOSAVUcD7erwBPz/OdJtJo3Y2oxsGU3BDnlq7a/LzBbVbRo9wZmlaiY1yzyiePUHccKX6uuQb2nv8s5F/AgnNCsVaO6oGfFNTnazF6IJjsUHSIMSV5jtcHnNYq430dCrWZUWqIANuzzFQM1b7w1u57jPMODWRtauBeWLSmJgIjy04oDkcdHTVIAG1F88FozuILRpILCsPluIoNXW3PDAO/O7jW5YztEsvLWTQpGVfvE3B9XYC27ftJ3Q5bulIVVsq/QGqprKp6XRz8Ivu1G8KX0zNWZAMGs6N6cCG5xmhTR7lcbCvhZqgQnJCjDy06emMw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_set_pac' function.
---
 src/service.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/service.c b/src/service.c
index a4b13be2fd47..0713520d88a1 100644
--- a/src/service.c
+++ b/src/service.c
@@ -584,6 +584,30 @@ static void service_log_pac(const struct connman_service *service,
 				 url ? url : "is not set");
 }
 
+/**
+ *  @brief
+ *    Set and log the proxy auto-configuration (PAC) URL for the
+ *    specified service.
+ *
+ *  If the specified service is a hidden service, no set or log
+ *  actions are taken.
+ *
+ *  @param[in,out]  service    A pointer to the mutable network
+ *                             service for which to set the proxy
+ *                             auto-configuration (PAC) URL.
+ *  @param[in]      url        An pointer to the immutable null-
+ *                             terminated C string containing the proxy
+ *                             auto-configuration (PAC) URL to set.
+ *  @param[in]      dochanged  A Boolean indicating whether or a D-Bus
+ *                             change notification should be sent for
+ *                             the service "Proxy" property.
+ *
+ *  @sa proxy_changed
+ *  @sa service_log_pac
+ *
+ *  @private
+ *
+ */
 static void service_set_pac(struct connman_service *service,
 				const char *pac,
 				bool dochanged)
-- 
2.45.0

