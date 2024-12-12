Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FB17E900
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981309; cv=none; b=mOvPDTokFkf2VnqVAY+aBaWIQWsRME6/VAeBZf/TwY0nw2nO1UUEexA4qRzq8LdYYfhTZRJyTSCS2NI8vrQpeJ0uWvw1R2oO3l42Kwu4sD7/TAEiYKB/Y8+HztgEg/UV4WML05OLoGlqCP6312+51rWpbzGpuBJZ6d1KpkxyPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981309; c=relaxed/simple;
	bh=OLcZcA2X+SwUaNljVtVGNIPngPy9YCn/knMOpQjD+RY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2Oz+w82qjHsBZ3lLBn5qQtVeDWmOwQ+iePQUDRSo8vQBwOwKB9b7279OauZV3E6r5pF2a0arPyHbFBoT+UHCxoDP33m5vDfI3L7DGG4Dzmhr5ZnCw+9zVjzZGj3hO/lLI4giCKnJjvRXAR7kCKw4QrxOwS39vyg4gtDRZiqJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=h/NFSvou; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="h/NFSvou"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 5996E164A60
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:24 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0E73B125164
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 12/15] service: Document '__connman_service_set_proxy_autoconfig'.
Date: Wed, 11 Dec 2024 21:28:14 -0800
Message-ID: <20241212052817.2021264-13-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=upXwsh8pay+i+IW0gkLNj6C+5LcKVcbrOtlcbMVLTWw=; b=h/NFSvou8IAZturPMHOADI2SuU0xHKBPw4rs0zPmYfuE8Ar1nGUCC+++xLSwJ66cTZrWpS41T4y/LBnij2VXFhaP2s1Zq+CwpOdTykl18QgG2IDsQwcnC5hRKs6IbhQbzcbbz0S6g1LXEpjHGBD+xu54wqm4aE/rLvAqg8wMFuSyPbJKAcEvgGb9HOJjNbHwvghnIfwiz1dX+TgHL0FOxthqmCpWJQ/kmRUc/voz1vuQ1y3bv7pKOfJgltbf7/6MwUEP6zJEvhSdfPW0dWQDzXqCDGXJE9VL1GEsili+7486GBi197wJxTqvRgeg6SmFQtfWbXsdWAgL4s02jUv+Gw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the '__connman_service_set_proxy_autoconfig' function.
---
 src/service.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/service.c b/src/service.c
index b27828d98a42..0cfb516016b5 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5748,6 +5748,23 @@ static bool service_set_proxy_method_auto_handler(
 	return true;
 }
 
+/**
+ *  @brief
+ *    Set the network service proxy method to # and proxy
+ *    auto-configuation (PAC) URL.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network
+ *                           service for which to set the proxy
+ *                           method.
+ *  @param[in]  url          An optional pointer to the immutable
+ *                           null-terminated C string containing the
+ *                           proxy auto-configuration (PAC) URL.
+ *
+ *  @sa service_set_pac
+ *  @sa service_set_proxy_method
+ *  @sa service_set_proxy_method_auto_handler
+ *
+ */
 void __connman_service_set_proxy_autoconfig(struct connman_service *service,
 							const char *url)
 {
-- 
2.45.0

