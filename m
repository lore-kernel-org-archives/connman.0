Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541563;
	b=qUrdZy3OBxWJfWnC5OKrowO1cwe2t5RJFuFlp79agENFLFqS6G2p9wXtk90C3t6lhAt1
	 o/u3noS8EEz9YHXNKCXTprmerJRg0niq5t71BebeAcNII1K4BIs9siECsys6rKS5pxxi6
	 xN5IiQbiGwcL74vX0Lb8reB4QQ/rvd1CbXy8PYi48PgwzDz8e09q/uerThPLUnf5QT0Sk
	 ornYAb+eZ7yaVD3Xpj4VyptMCse8awEFHkW6jNo9YchCW+l0pwe7/0a1eEdA7tTspd5V2
	 wdgA4TfjQ4rp9/PmQzbaRtjnROcTVMr3FHXZzdYl7ikz9RnamyVdEBIAO4GXJZueOyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541563;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=qpVV2l8c1qC80aWfbOtcT/j+3QY0N2oqLXUj4/nzJq8=;
	b=RUu4/QNhLgUBijePYBi8zcpUmnZN7eyrt/XcaL1GwI8Wei+PaDG4f5AQlv+I+ChNA2XC
	 hCkXEA5boZe6w6K0WPjHeIYteWYeIYIWj1b7exqU7haDXR3UfcrfKUdaRuglcchsOdGdy
	 fVGtLOaB9ATmayMnV15FIUWcwQh0KqN3zyEinoAx90GT/QG4edBEnDGP07a4+JxsaoCGC
	 9rWnXtab8Kk1DMnHj3P3qgY3nZfKoRXaHNu/UPIqvnBu6IRy6ufIGWqUorGUeRFB9Q4xn
	 Jf3Lh/h4BWqRlqjvEt7BiSCDxZlbPKsfswCeu61bVbhNhTW4tHrt1cuwBNvrFFpnSHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=tSyGW2jB;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37259606A31C
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 03:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37259606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=tSyGW2jB
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 451B0160279;
	Thu, 12 Nov 2026 22:46:02 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id CDAE7124BEC;
	Thu, 12 Nov 2026 22:46:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] gateway: Promote a low-priority default service gateway
Date: Thu, 12 Nov 2026 19:46:00 -0800
Message-ID: <20261113034600.1828963-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=qpVV2l8c1qC80aWfbOtcT/j+3QY0N2oqLXUj4/nzJq8=; b=tSyGW2jB0usmahZZNI63S4K423q+8g2yxr+pszqVh8W0t4X0ofzmctVEUHDvB4ytA81rRm4GG3mNfQ6wtv7tbPufkSoJ1URIiBkEETlZKwKMqwOoPTFv1K+Hli+G0d9wTzAAUAosu+2+yUtXKvk1J6kGqPUE8kdUkN4vD3xB3jwMqq154b+BgPQUaAUXBib6iIHJPRVLIDtqbm4IaXg5weADdk4Yot12ZnuQLnnZD3IJvxMlLgfhD0VAei53i0vicfwgKssnf+e7UdIgsD4gaBpdw4EmaH4ds51dBHEXytbmK49HIHQKfc2qLkgcWqodesPtD7mUsr6c79rxT39cTA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

__connman_gateway_update gives the default service's gateway the
high-priority default route only if demoting another gateway
succeeded, or if the default service's gateway is not yet active.

Since low-priority default routes were introduced 5083062922e5
("connection: Add support for low-priority default routes."), every
connected service's gateway is active. When the default service's
gateway is removed rather than demoted (for example, when its DHCP
lease expires with no server to renew it), nothing is demoted. The
service that is default once the list is re-sorted then keeps its
low-priority default route, active, and is never promoted. No default
route has metric 0, and, since only a promotion calls
__connman_service_indicate_default, the new default service may not be
signaled as such or online checked.

Also promote the default service's gateway when it is active but only
as a low-priority default gateway.
---
 src/gateway.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/gateway.c b/src/gateway.c
index b2c211e2dc8d..86221be5ead9 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -3976,8 +3976,10 @@ bool __connman_gateway_update(void)
 	DBG("updated4 %u updated6 %u", updated4, updated6);
 
 	/*
-	 * Set default gateway if it has been updated or if it has not been
-	 * set as active yet.
+	 * Set default gateway if it has been updated, if it has not been
+	 * set as active yet, or if it is active but only as a
+	 * low-priority default gateway, for example after the gateway of
+	 * the former default service was removed rather than demoted.
 	 */
 	if (default_gateway) {
 		const struct gateway_config *default_config;
@@ -3987,7 +3989,9 @@ bool __connman_gateway_update(void)
 
 		if (default_config &&
 			(updated4 ||
-			!is_gateway_config_state_active(default_config)))
+			!is_gateway_config_state_active(default_config) ||
+			is_gateway_config_type(default_config,
+				CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT)))
 			PROMOTE_DEFAULT_GATEWAY(default_gateway, type);
 
 		type = CONNMAN_IPCONFIG_TYPE_IPV6;
@@ -3995,7 +3999,9 @@ bool __connman_gateway_update(void)
 
 		if (default_config &&
 			(updated6 ||
-			!is_gateway_config_state_active(default_config)))
+			!is_gateway_config_state_active(default_config) ||
+			is_gateway_config_type(default_config,
+				CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT)))
 			PROMOTE_DEFAULT_GATEWAY(default_gateway, type);
 	}
 
-- 
2.52.0

