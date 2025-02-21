Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F62185AC
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153422; cv=none; b=lL+b5HR8niUkB61CDrWIzZ4dwNB82UBZF23TzR3MFkok6/k+8YXkSbOtNVyB9YzMWY0EH8qT8X+bBRN5qwqHguqERBUY+fV+Urssn0+DOjWSOiAAMlvrlSEiuqrwwD7+V4tGgVQEIitKD8MWHdZlaAalpnXnjoCiMLgNdkarALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153422; c=relaxed/simple;
	bh=pcdiA+kfE/4PfnJeswFZEsO08yj5hl60J6YA0hI2O5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3/1ZT7IIpcGWN3jgy6H78q53OdAp/W8fwQprSE0msgli/m3QwC97d78HCf1MNdySp5pTKGdbO//2dC4C8AIilSPypvP/7UyiNjd7XZ69M+2lplBZ1A1H7Ww4SV3+f0odkpzmZNQcia66LIkmchK3ChJiRwR0V0Zj92U51PQDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=O5ReeU9P; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="O5ReeU9P"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4D1051649CB
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:00 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 033F3126356
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 11/15] service: Document 'service_set_proxy_method_auto_handler'.
Date: Fri, 21 Feb 2025 07:56:49 -0800
Message-ID: <20250221155653.760046-12-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=iSeMwyHmrkTmageWa0zvLP83gaNER4Fyqup4KK8kLqw=; b=O5ReeU9PKpFJUGERxjrxMMTakMeK31ld4y3okc0b1Eigk8p5O2RJR/ixDgZIATW+UDvn0pcUIrd7wLgZJYOYaktfpkXzA4cUGMyPUqFq7sIaP5RaICD3uGB5Ys7mwrhBhnnmeiV2psWhQMglXlxDQ3groNrHVuIajeoqK4PNuSHv0zEpMTecgOUn+0/F1GMMDoyFzry2W2Y4FA4a9B4R1inwq0nBRAI7NfL1EIDSHS03XRJLPndqncgaHSfaBnlZGJldryGEXzXDsgThkN8JpLfzIss5bYW+ivd3WJMMTmCdbeW5RVw4DToAN7HMxmeCg6zXuxCOIB2qHqTy1EoSug==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_set_proxy_method_auto_handler' function.
---
 src/service.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/service.c b/src/service.c
index 3fd56188093d..b27828d98a42 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5697,6 +5697,36 @@ const char *connman_service_get_proxy_url(const struct connman_service *service)
 	return service->pac;
 }
 
+/**
+ *  @brief
+ *    A post-mutation handler for the service proxy method when the
+ *    method is #CONNMAN_SERVICE_PROXY_METHOD_AUTO.
+ *
+ *  @param[in,out]  service     A pointer to the mutable network
+ *                              service for which the proxy method was
+ *                              set.
+ *  @param[in]      method      The network service proxy method @a
+ *                              service was set to.
+ *  @param[in]      context     An pointer to immutable context
+ *                              that was passed, along with @a
+ *                              service, @a method, and this handler,
+ *                              to #service_set_proxy_method. For this
+ *                              handler, @a context is an optional
+ *                              null-terminated C string containing
+ *                              the service proxy auto-configuration
+ *                              (PAC) URL.
+ *
+ *  @returns
+ *    True if #service_set_proxy_method should continue with state
+ *    change notifications and processing proxy notifier changes after
+ *    the handler returns; otherwise, false.
+ *
+ *  @sa __connman_ipconfig_set_proxy_autoconfig
+ *  @sa service_set_proxy_method
+ *
+ *  @private
+ *
+ */
 static bool service_set_proxy_method_auto_handler(
 				struct connman_service *service,
 				enum connman_service_proxy_method method,
-- 
2.45.0

