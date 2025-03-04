Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274E1F7076
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122193; cv=none; b=mKGsuQgfdz1ekYyrkU1EkxqvdbPy6SQT/TLA1axWjMi+o7SDiKaMxXNN6Lv+PzGV4BBOaVcIp+o7N0/DR+gQL01VhvAB6Q02ZubuO9EQy6sMD0rG90PU1gc8T9q4xsBn6lBdPiqrcSpnAAPgR3i8kjMZoSkHBfgDcdhQDKZoZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122193; c=relaxed/simple;
	bh=+Sl8qUGNBr/Dngm9ZW/xZDLAlGyCAtdXsIlUfDUD4S4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PianKEHejdWLR1Vqb0s1pbsJzxoLK9khMEf2R1Dy6rHfFWVNW2w3lTaBv9mh+nV2WNe+CGotH0Qq+uTYwMiC+rj2We3orAbKqkoZJpCkIUOJEstb0QJPZYJvrVRxdVu+3BpP/h25GFtc7N1dYaUbFrQdL/giTbjdIM2YlZY82cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=RLgdSI76; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="RLgdSI76"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1FEAE164B62
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:10 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C8E84124FE6
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 7/7] service: Document '__connman_service_set_proxy_autoconfig'.
Date: Tue,  4 Mar 2025 13:03:05 -0800
Message-ID: <b495f5cf7fd0e77ce0a510c67c34a34d7bc57dca.1741121901.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=xFJ1IEejAhzTyyOd6dJCd+Txke0FxEPez8iBCcpRiLM=; b=RLgdSI76SpzLs++FtjFOx39kW4B5s9USJZbTX9kmx0KSQw/j3DkIUsXf5r9oppBrnQ+K3v+QCuGWyGGxqidwNGD+XPIloneVPaVVuFQl8aEZO8Dii3Vjk9rMjwLFVKRm66KZSt8tw/BTmU4H5B9iLHJCH8nSQRjptq3tFA7lP/DH2Qgk39NcrBbafQd4wPwmSUxDJFGNCAhRA7z1oV56s/conV7HfutVITdhS5c13UF6zXB8phtsqvyAfNqtYnmRhUfC0DrM53wDAFuOCaQcrZl1mkB4kWA63YEJODLGYhiIBixQ3rrZK5gyYt71nGsP65e+ROkOQmvcHA2pMXFI9w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the '__connman_service_set_proxy_autoconfig' function.
---
 src/service.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/service.c b/src/service.c
index 4b31db3c6358..ed0dea1dc1e5 100644
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

