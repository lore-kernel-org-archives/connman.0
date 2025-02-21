Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C324CEC5
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157875; cv=none; b=dhWwrAxlL8HqnPFu/UdJukMygZ7uIy7wdJ9S4xaz4NVOb51n+/dyGV1oMs2pF3I4IpOO8gBZnVYHkUlG9gxJcquD1OJzu9tM2o1XKVYFe8gvtPWwfTnotayEH2f3YgYhBtSFlBdUTo10JCewK4F25kF85+iy4cVvRNHSdUL9QgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157875; c=relaxed/simple;
	bh=OBN2I6mYnS/yM6Ayzpl9E/qGGiCbE3L60jAlo8rcp0c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j2Hys/rR/xsDFYkJ1NtuV3lCn+DxXMWcgFQfCHrRC1WszF8iW+oOdb8FDMbP0M9L6+FgJEywH9B3eqZxdZ/K19uxAM4/cbvZ3200Gp9n+ukz1Hb9tWua5Wt3+Qhhw4xMSwAuvxeEChhOu4gkL/P+O8ra1lyEkSEE2oWCiz+Z0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=VayOujKH; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="VayOujKH"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CE812164A44
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 12:11:11 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 7F9CD124EDF
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 12:11:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] gateway: Fix __connman_connection_gateway_add is_vpn6 calculation.
Date: Fri, 21 Feb 2025 09:11:10 -0800
Message-ID: <5e1a105eda4ae36e7a9132140949c569cd02fe02.1740157858.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=pEGw7FT2HRFMcCZrCgrZfkZDBLzBb/DC0aGxZRNNGYo=; b=VayOujKHjdJS5rhDI7hzCVt7TKKyUJE9OyfczxIZUhQqJv0PilmFcBZ6LAiK7+BPt2AvlpiCjLb43KAL+B2/ZCXm2PfM2RZnE3BeJ67l7vefGwecubayiKhO8jubK+EYkvMY30c13UYPjn1Ad4t1RNFmUWGrbbtoBLaEv3qo1zzFWXGUAhtoidNhtGGnfR8LkMTKRP9YG1mVtt8Jg2DAOU0unVxhYOBWptImBlUBvO+kFkXegpQ1FFX3xBbELEx4F3CGOnIE+wHLqhA4lNQsYeYcx7XYTh0JcT8Y/Pqrw0hhAEGRyNTZ0li8i/eYGVzGsC6g7GG9ABLxnKJLoQlkYg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Address a regression introduced in commit 823d5a2a8cc4 ("connection:
Refactor '__connman_connection_gateway_add'.") in which the 'is_vpn6'
calculation was inadvertently copied-and-pasted from the 'is_vpn4'
calculation by correctly using the associated IPv6-related
'new_gateway' data members.

This stops WireGuard and other VPN-related plugins from faulting on
start-up.

Suggested-by: Gabriel Sanches <gabriel.sanches@prevas.dk>
Signed-off-by: Gabriel Sanches <gabriel.sanches@prevas.dk>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
---
 src/gateway.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/gateway.c b/src/gateway.c
index 16c87f83b4d6..b2c211e2dc8d 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service *service,
 					is_gateway_config_vpn(
 						new_gateway->ipv4_config);
 
-		is_vpn6 = do_ipv4 &&
-					new_gateway->ipv4_config &&
+		is_vpn6 = do_ipv6 &&
+					new_gateway->ipv6_config &&
 					is_gateway_config_vpn(
-						new_gateway->ipv4_config);
+						new_gateway->ipv6_config);
 
 	} else {
 		if (do_ipv4 && new_gateway->ipv4_config)
-- 
2.45.0

