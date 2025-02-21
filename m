Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA021883D
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153423; cv=none; b=Jh0j+NhwJfTRRNvT6l2patltfAweugRpCRInGsK4qoncxToI/xVxRUoVSmPVsSgDFRcMCt57XgeMqvNmLWeA+pmU2ulJJsqDKPTCyqkZPZHbZuPUxQGz8Y40KPDHfd3pd46C1JjPPUTiO1TD7x9lHItDawyRa/sGTmAqcVnzcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153423; c=relaxed/simple;
	bh=OLcZcA2X+SwUaNljVtVGNIPngPy9YCn/knMOpQjD+RY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COmzf88pxEW8FnRBBvEjnyrf9SbTLoU1hOXGruJGrFzeqxD0DFIpjy7QtjDuWWTClbOBSihMPTmKgctXwnnXViSvtxtmgVYI82qxvaZC2aVO5oN1xDpLqTV6R3WxAOZq2wPlM0bIAxvPvY8F/HdMcQX8Gnq/duPmco6JkeDpsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Qvyag9+4; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Qvyag9+4"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id BA501164A83
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:00 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 71CA412516C
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 12/15] service: Document '__connman_service_set_proxy_autoconfig'.
Date: Fri, 21 Feb 2025 07:56:50 -0800
Message-ID: <20250221155653.760046-13-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=upXwsh8pay+i+IW0gkLNj6C+5LcKVcbrOtlcbMVLTWw=; b=Qvyag9+4BNQwQnVSfFVGzMzln8o7UIZ6K2rYW71MQWc0xhRjje3G2mm0+fEwbgC/spKhTuE90hoMhXGBCrmWKrUxTDrKHNNOKyFzHP7bPzBLyXlLNQkzRb1ZaHUFLoSfcjO6cmknOlkWXymX5yrvvkDqOzthA/HnMUdhhwFkfE+XqyULFDDyAV+TYwSq3Pful3ny9bNAiuZycDT1QEDQtJglZhYhZ/KipOg1sUgl4oo2+Ssxg3lOUI4n6qkW3lu2GWZNr4BzjO66oGAL/fW3MKLDZrZJm2MZ885pbcWJP2UHelCOk6R229bNLo4vPcfP2FRHnJb3YFafM5BizY9NxQ==
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

