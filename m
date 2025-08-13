Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D527472
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098966; cv=none; b=Gt6ERb5JCzS1ZlMkjbMu/vzXqz95thONsIe8r6tkSPYmEwhRrYNWWNKpcr1PEWimrqvXNlibY88mZ2pPjtBXbZwD7FtspDugh7/8w/sv7EME/7wEcvT0QvMXYs+04xDkjmtg8HdZm+3qPgTKHJ84xe+K2HN2TO1MUfhchsSdyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098966; c=relaxed/simple;
	bh=BxwNBFGTWTpNMd/CS6Jxve7b6oLs7Sa/n4bQ+8GddKw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUneC73Yz28rW3Bg8y48pyqQqDbm0U5DyYOiO3F+/29HVLFSn3w5AZQnZCFgIRVDtF006z+GcKjPaTVdnqCvgdkis+McA8AYWefj5ia5kmEFufoDMBoxX/a6mZcvZdzaow/KaOuxp+SQkodQAIiZV7ups20lRJQfU8daPC3Ywbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=k48lG5C3; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="k48lG5C3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zDxwBKl6ghQ/kZ/P8Gf8eyWdWpUO4WGvNgS2Wttr5Qc=; b=k48lG5C3qWfT5259qTdmhE7DCo
	aoLFUTd4SW1W9vztK067SbhP+sxlgS8KR2dQs0tNLcdboV2OKL9zKA3eY5MBhbASNS5X8KEIlOYcN
	U4FR8N2Zm6fTWJL9w1ITdbQbkyJLTF+wl/44rsSg0tQLBwdvG+bfMyUUwiLnRUd8WEGvjg1MM9jjF
	lKsTtaGg9AHkHvAwrIfMT5DccprgyczxiAxdJirDvx/qaF3KWeUoGw6hJiR7rG/AMhrHlZ5F7HR/g
	Sg7AADTfl/9sZBiRf3NO8aoz4+W/WAZy0PQZu7TxfPIQnrbiFcSUvxvduH2rbaiE+Ro/iNPgUUJdC
	N04Ku5TA==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-1a
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 12/42] wireguard: Use positive errors for VPN provider connect_cb
Date: Wed, 13 Aug 2025 18:01:44 +0300
Message-Id: <20250813150214.189282-13-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
References: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:b275:797e:525b:8df9
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

