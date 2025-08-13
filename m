Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9F26E14C
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100752; cv=none; b=rr9kN8Tpg6bHQ0gEUT6KofAfvfjSkteasVRVfQmTElI6Mof+vISjEdwxEK0vOro2AojeT22AEVDDZFZw0HBA3sP2RpHwe0yf7mnOh/84YLGHIsIaLjf2x3p0iQvVSbjlnZvWd913HdDZZC2vU8awWMogjMUaRkpz9Qt35mmw8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100752; c=relaxed/simple;
	bh=YNDcNzCEmj5kE+udH5ilmqFeSiVfkjNeeHqDYkPagrc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dc7+Va4o4iwNs+8fVEuEamnssRW+C9/kss8bf3HGfJaXsezYWPyv2KuKXt5DCoeSrXpqoEfmwWZwEIj5cBO1DnD/JLJqSfPQj8W1nhGQUEhoKyR7uQ29u9AC/dDp9XEsBkskZwTyQ9yEoSvyguDe36fgocu0fM/AMsG5jTw5cZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=pwUiouxu; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="pwUiouxu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9bzsCEp+Bz6+flDWEdo16spIvBWApDIRMh7rneSsQf8=; b=pwUiouxu1QjfuZVqIlMhmtwV9l
	AcNi7pX1LOPNmffFfwiWDdXiLXTE3SY968Or6ZT3CK4Wr3MLylBJ4Bfq7rWSmt6tlkx2h3JMShadP
	oM4o2IDSHdNzbkyeX113IzwDxhx+3cZU1uGWS4YnPPI8jN/h1fZlR+R2H1Bq8GqQEEZ9Ic5UDOcSE
	kDoCh4KB/CqN+r7RpijMglswR7RlpmPzO1nsghe6fI8ngfyAz3eJvfWD8TZI0gQOxrMOmMF6Ez1+n
	RJYm5iqDwP6Ak0a93yaI0LD4ZHaQ95sAaTJfSYyi0D3hvBoNAeSQjreLRsTUSQ8U9lD9KHNNvxDh7
	eS7wjBSA==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-1H
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 32/42] wireguard: Treat initial connect failure as unreachable host
Date: Wed, 13 Aug 2025 18:02:04 +0300
Message-Id: <20250813150214.189282-33-jussi.laakkonen@jolla.com>
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

When changing networks WireGuard may connect too early and the network
is not setup yet, causing connection attempts to the resolved host to
fail. These should not be treated as a login error, which is a terminal
error for a VPN. Instead, treat these cases as unreachable host errors
which result in an increase in the connection error limit and keep the
autoconnect value untouched.

Also add a bit more debug into the plugin. This will help to identify
configuration errors in the future.
---
 vpn/plugins/wireguard.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 022055ad..cd91dd15 100644
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
 	info->resolv_id = g_resolv_lookup_hostname(info->resolv,
 						info->endpoint_fqdn,
 						resolve_endpoint_cb, info,
@@ -875,8 +878,14 @@ error:
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
 
 	goto done;
 }
-- 
2.39.5

