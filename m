Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1212E7BCC
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=gtPcf4X5/GD/OwcOG2gXr8mx2oBUgD6P5RxXmSlVktrz6VEx8ZdejdTW6zIq4m0KaMdPQmrzme+vFJS9rLoma3Bd/eV/cOlHffB2GymW1mETpBMUJ3PjhWJnlCebicNR+DLzH2Jblbb/s16f4hWPq1qpWDZX//Zryhiw9A3kkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=8g5MBv8RbQQUuJryNeBEAN1dl75OwZ+ARLeVHUEXoBQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tv6cjUd2CrheHTIAQ8mrkfzEfPCKhpeE4N5wJesGCeT09IAkT0CistACELMWp7icyEy/t5vX4A4h02pK4jGNkjlDEvFL7HUkIz8PcQmoNT+292hVg9cMh+xzkg5GA0g37gQAfpKRg8cM+1SVB8GwkA2E1heH9cUyvlexBPAviqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=a1MnwhMU; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="a1MnwhMU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3sDcU0DEP2AoE3h+vuSpBxJJYz1SRevg73nn9ZR+lVA=; b=a1MnwhMUdOvugUf1FH44vexT6F
	KJRQI8jbO8J3xbRixSRBa/wV+L350ChDb8wQ8zHHupgsBz5BwMxAbzkhMvuf41mOd0YhYxBbogO5m
	FNYF/DaN6jmEaXX0lwun2oS+6AYWyZfhQ+o5m+2EIsl97kYTQ9UtWnlYJ7eVluMDpdeji3tGQ//o8
	z65f4X1O9Xaz2F7w1XkMHEn7JZkk1pW4nOvkSN6pWTLbg/UCKoqeU1iQIrS3kZXUJ+BroxVCKJUkv
	z5IjtVrxrJy9iMFF+8Im2Kkjod8nJGilPYMlS+TMW2gctPSEZ5g3f62QysKtR3k4+PgHDUjOBLKuQ
	S4rBinng==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-14
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 34/45] wireguard: Treat initial connect failure as unreachable host
Date: Fri, 11 Jul 2025 17:27:25 +0300
Message-Id: <20250711142736.1757060-35-jussi.laakkonen@jolla.com>
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

When changing networks WireGuard may connect too early and the network
is not setup yet, causing connection attempts to the resolved host to
fail. These should not be treated as a login error, which is a terminal
error for a VPN. Instead, treat these cases as unreachable host errors
which result in an increase in the connection error limit and keep the
autoconnect value untouched.

Also add a bit more debug into the plugin. This will help to identify
configuration errors in the future.
---
 vpn/plugins/wireguard.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index ee7149b7..756c6f88 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -230,7 +230,8 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 	err = getaddrinfo(tokens[0], port, &hints, &result);
 	g_strfreev(tokens);
 
-	if (err < 0) {
+	/* Any non-zero return from getaddrinfo is an error */
+	if (err) {
 		DBG("Failed to resolve host address: %s", gai_strerror(err));
 		return -EINVAL;
 	}
@@ -249,8 +250,9 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 	}
 
 	if (!rp) {
+		DBG("no connectable address found in results");
 		freeaddrinfo(result);
-		return -EINVAL;
+		return -EHOSTUNREACH;
 	}
 
 	memcpy(addr, rp->ai_addr, rp->ai_addrlen);
@@ -572,6 +574,7 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 		return G_SOURCE_REMOVE;
 	}
 
+	DBG("endpoint_fqdn %s", info->endpoint_fqdn);
 	info->resolv_id = vpn_util_resolve_hostname(info->resolv,
 						info->endpoint_fqdn,
 						resolve_endpoint_cb, info);
@@ -872,8 +875,15 @@ error:
 	 * looping when parameters are incorrect and VPN stays in failed
 	 * state.
 	 */
-	vpn_provider_add_error(provider, VPN_PROVIDER_ERROR_LOGIN_FAILED);
-	err = -ECONNABORTED;
+	if (err == -EHOSTUNREACH) {
+		vpn_provider_add_error(provider,
+					VPN_PROVIDER_ERROR_CONNECT_FAILED);
+	} else {
+		vpn_provider_add_error(provider,
+					VPN_PROVIDER_ERROR_LOGIN_FAILED);
+		err = -ECONNABORTED;
+	}
+
 	goto done;
 }
 
-- 
2.39.5

