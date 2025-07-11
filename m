Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA362E7BA7
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244074; cv=none; b=aQ8/ZL+ITjXjWpAVpFDlE13umwqb9RUG353mBwJD5AKH4fShTINjPmt/jLq8SI/PMlMMEMAgUTZ7rZzhxVAfFo/Rc0gCTjeB1QhcCdjkQcCwFNKsTX4EzzJClQ62Ar8kRKCsphXh1fmjjwMF0jKX2blmCoSkdZHYhjsYZUtrOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244074; c=relaxed/simple;
	bh=BxwNBFGTWTpNMd/CS6Jxve7b6oLs7Sa/n4bQ+8GddKw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FPkDeZeM1M/dSH841xiEouu8QHmsZB29X5v0GTXkzjN9nm74Ag3C2QqsaitjDmTb1T4bvUq0n9IEQ6D1AtEy0S8aI3gwvaJWz6N2uLXw/SX3GATHthSrZ8907rj520slfUsODeGVtxuqcTKb/zrg0+q0Kna1hIbLBmzG6LftO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=AUiF7zXA; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="AUiF7zXA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zDxwBKl6ghQ/kZ/P8Gf8eyWdWpUO4WGvNgS2Wttr5Qc=; b=AUiF7zXAPXswULBqOWjcQ91Ykx
	pgZQlxfYe/3Y3lRuAEmdAZkNWTyC08LLsWWfa9G0t+3oBGglB4SUWF6bBLgrGNwxIUaEFXdMhHvan
	58VOERTmi1rpI4D9sqr9D9MhJM3/s9Q9mrVAD3xWhnn+O7qSoMmQ3T2UWzxU9h0bO0fHcq7ms/JEj
	GsaFrbyO68cF7y8YREgt9JbYN1gCj5z2BdmDu4rBupjh/yzPiDiGCp3G69oPcBt6f7Lf3lPvZ5yGe
	mlFwrAvoF2yS4oEsyAMPMNWtJcUuKzeDXduA1803YqLvdFv6PwKi6d5KN33CM7/gJJ2TF4BBzCNSJ
	HETnfyYg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-1A
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 13/45] wireguard: Use positive errors for VPN provider connect_cb
Date: Fri, 11 Jul 2025 17:27:04 +0300
Message-Id: <20250711142736.1757060-14-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:7901:7c96:5fcf:719b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

The vpn-provider.c:connect_cb() expects the errors to be positive ints.
Remove the sign when calling the cb.

And add debug to see what is really causing the error. For example, when
parsing fails.
---
 vpn/plugins/wireguard.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 735bac58..de57b15f 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -349,8 +349,10 @@ static int wg_connect(struct vpn_provider *provider,
 	option = vpn_provider_get_string(provider, "WireGuard.DNS");
 	if (option) {
 		err = vpn_provider_set_nameservers(provider, option);
-		if (err)
+		if (err) {
+			DBG("Cannot set nameservers %s", option);
 			goto done;
+		}
 	}
 
 	option = vpn_provider_get_string(provider, "WireGuard.PrivateKey");
@@ -359,8 +361,10 @@ static int wg_connect(struct vpn_provider *provider,
 		goto done;
 	}
 	err = parse_key(option, info->device.private_key);
-	if (err)
+	if (err) {
+		DBG("Failed to parse private key");
 		goto done;
+	}
 
 	option = vpn_provider_get_string(provider, "WireGuard.PublicKey");
 	if (!option) {
@@ -368,15 +372,19 @@ static int wg_connect(struct vpn_provider *provider,
 		goto done;
 	}
 	err = parse_key(option, info->peer.public_key);
-	if (err)
+	if (err) {
+		DBG("Failed to parse public key");
 		goto done;
+	}
 
 	option = vpn_provider_get_string(provider, "WireGuard.PresharedKey");
 	if (option) {
 		info->peer.flags |= WGPEER_HAS_PRESHARED_KEY;
 		err = parse_key(option, info->peer.preshared_key);
-		if (err)
+		if (err) {
+			DBG("Failed to parse pre-shared key");
 			goto done;
+		}
 	}
 
 	option = vpn_provider_get_string(provider, "WireGuard.AllowedIPs");
@@ -385,8 +393,10 @@ static int wg_connect(struct vpn_provider *provider,
 		goto done;
 	}
 	err = parse_allowed_ips(option, &info->peer);
-	if (err)
+	if (err) {
+		DBG("Failed to parse allowed IPs %s", option);
 		goto done;
+	}
 
 	option = vpn_provider_get_string(provider,
 					"WireGuard.PersistentKeepalive");
@@ -404,8 +414,10 @@ static int wg_connect(struct vpn_provider *provider,
 	gateway = vpn_provider_get_string(provider, "Host");
 	err = parse_endpoint(gateway, option,
 			(struct sockaddr_u *)&info->peer.endpoint.addr);
-	if (err)
+	if (err) {
+		DBG("Failed to parse endpoint %s gateway %s", option, gateway);
 		goto done;
+	}
 
 	info->endpoint_fqdn = g_strdup(gateway);
 	info->port = g_strdup(option);
@@ -416,8 +428,10 @@ static int wg_connect(struct vpn_provider *provider,
 		goto done;
 	}
 	err = parse_address(option, gateway, &ipaddress);
-	if (err)
+	if (err) {
+		DBG("Failed to parse address %s gateway %s", option, gateway);
 		goto done;
+	}
 
 	ifname = get_ifname();
 	if (!ifname) {
@@ -446,7 +460,7 @@ static int wg_connect(struct vpn_provider *provider,
 
 done:
 	if (cb)
-		cb(provider, user_data, err);
+		cb(provider, user_data, -err);
 
 	connman_ipaddress_free(ipaddress);
 
-- 
2.39.5

