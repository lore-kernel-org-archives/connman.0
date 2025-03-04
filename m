Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15B25F99B
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122193; cv=none; b=aPeItr2oAc36duTpaon09Dz8EdujiNnzYXyZ6lT7gvARUBt8Wdp6Dsam5VHQOMrHCpbaLB72zA3Z0bOt/Aqhqf9y1f1Z4sk+27IIoAeT9LWQ6JXIJN6WXw8mcuaMUjFsf6T4bd3UAttULklLw2iMikofM966xU9oRplPKk7m0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122193; c=relaxed/simple;
	bh=xHRMXDWXhhfVV99ligGEhVqfIBMLtZj0FJtzgUktM+U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exSVziVmf4fWbpaG/umlBl4NJgaYiontp75xNVSibvodYUjjsdGLDy3RKa1dBntYzAlsYDGU3OsUbkwtCwAwrkElp+pxXlB8DDGk4nDPg17qhzv2LtH2Cfd1RcgE/SDr0rK1Bk0gwjuFyvMHmBrT8ytcHLKPP9YZ0Rv3G3jq2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=a9/W1vyv; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="a9/W1vyv"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 33EB6164B60
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:09 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id DA0E3124FE6
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/7] service: Document 'service_set_proxy_method'.
Date: Tue,  4 Mar 2025 13:03:03 -0800
Message-ID: <810603ffd15c53a1347da81bc84d393db4d0e67a.1741121901.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1741121901.git.gerickson@nuovations.com>
References: <cover.1741121901.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=I20+GkBzcFdL/cS3KLpdsGzs/YDVdKoSF5I1Ucr4B+Y=; b=a9/W1vyv8cUIIFwi3Me6gIgY1Fz+Ap1R/fdl/UwYT+hs/VonB7/ktEtHMpxrbxVgEnu6hDSA8QCFVgTXDUzJScEtky1V7A7KcTkuScgC7DGOuUhbrb3qCK2oO99zm2dUvpQcxn/RnMHA3hAIcN8v5AUB27tZ6JBdz7I5NpU7tIJvylp8QrW2RUtfSsrG59HV1kuX30z+InrGtChUb3rEUxRFkKK2ne69HeZWzX1XrkKdqHEu2TRlUkgMhUanS3cVRJXFRmOhmiDplt/DhxB+wDdVF6ZkZx5tZiYRSdiwL5T/NcgixA5qaraIElXOPYOsmBvlxmEDqPlRRMJaV1j6bA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'service_set_proxy_method' function.
---
 src/service.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/service.c b/src/service.c
index cb168b03c790..17193706d9d4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5569,6 +5569,41 @@ const char * const *connman_service_get_timeservers(const struct connman_service
 	return (const char * const *)service->timeservers;
 }
 
+/**
+ *  @brief
+ *    Set the proxy method for the specified service.
+ *
+ *  This attempts to set the proxy method for the specified
+ *  service. If the service is null or if the service is hidden, no
+ *  action is taken. If specified, a handler will be invoked, with the
+ *  specified context, after setting the proxy method.
+ *
+ *  If the handler is specified and it returns true, following, a
+ *  D-Bus change notification should be sent for the service "Proxy"
+ *  property and, if requested by @a donotifier, the proxy changed
+ *  notifier chain will be run.
+ *
+ *  @param[in,out]  service     A pointer to the mutable network
+ *                              service for which to set the proxy
+ *                              method.
+ *  @param[in]      method      The network service proxy method to set
+ *                              on @a service.
+ *  @param[in]      donotifier  A Boolean indicating whether the proxy
+ *                              changed notifier chain should be run
+ *                              after @a method is set on @a service.
+ *  @param[in]      handler     An optional pointer to a handler that,
+ *                              if specified, will be invoked after @a
+ *                              method is set on @a service.
+ *  @param[in]      context     An optional pointer to immutable context
+ *                              that will be passed to @a handler,
+ *                              along with @a service and @a method.
+ *
+ *  @sa __connman_notifier_proxy_changed
+ *  @sa proxy_changed
+ *
+ *  @private
+ *
+ */
 static void service_set_proxy_method(struct connman_service *service,
 			enum connman_service_proxy_method method,
 			bool donotifier,
-- 
2.45.0

