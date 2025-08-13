Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A11A23AF
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100765; cv=none; b=Zw01spJ/JpwmBnttpU5teGZ4NQkmHgSjPZd9uxBEAsLANLDTUD+72S6mkmBBe/pIRXPtxU4Knwm3uo14nEtgADdZY4qTtxDot/DZFiejnfeOVZzLlk7LpQVd7FRR3Qes5zaCv4NR6QltfrxRVKW273y1cEUwwTEoMUQbFIKbsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100765; c=relaxed/simple;
	bh=iaWBOhjhWxZ1EiLgJ+Cm9LjRd9qTxpIV/B2dhtbnDls=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eV9s3HSYj7oZp6E7aBcakQli0hmWrLbQAZJFaV8VyO40HxB7eJY897hj8KbwjKK+SXK/DkicoV0j0G5J70o15y2jnWW7pTfw5KsT//QpMcPm9ajRIqNaFTANqEA4SNGN/1Qg3xVu4FctGB4shtMrU6Z2+4k8gghGDGdeIPm6jNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=XGbNffmm; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="XGbNffmm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LzYI40ONoVHOJWbzD4JibGm/gjeg4ecfnI2RkfgbHHM=; b=XGbNffmmFVj7wVSary4hAlYbLj
	NwbK2XCAoCPubxRTXdZeWEiucvqSVhWIZ70EqyHn8NAeigV3yTyJI+XFUezEko5+QqP5mBem4Qhyw
	DJtVFE9LX9Zg6WSsVJ5OQ4bHY3nQRWPAQ62nxaK19abIv7SGq92oHd6Fh8g2632ZWQdqce+Es/Fcx
	k7JkTzQkTNuyPpi94sOGjG7uE9GsnobdI5NhZNvAZQb5ctBlbg62WonmZSLUUCxO8ocMNCIZD58WV
	48xzUb8J1aTs6WwxA1M2+k5dmciLc63Edku+9jSGnNUipJ5epAErscM/mR0eXuYumph3+M73TG4zZ
	GOCQSgBg==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-0Z
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 27/42] wireguard: Set split routing based on AllowedIPs
Date: Wed, 13 Aug 2025 18:01:59 +0300
Message-Id: <20250813150214.189282-28-jussi.laakkonen@jolla.com>
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

Split routing value must be set with WireGuard according to the IP
ranges set with AllowedIPs option. If the option contains an any IP
range (INADDR_ANY/IN6ADDR_ANY_INIT, i.e. 0.0.0.0/0 or ::/0) split
routing must be off since the configuration indicates that the
connection is to be used as the route for all traffic. Similarly,
if there is no any IP range split routing is enabled as only the IP
ranges defined are being encrypted and processed according to the
cryptokey routing table configured on the endpoint.

Also fix a memleak in parse_allowed_ips().
---
 vpn/plugins/wireguard.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 2531fff6..271b57b2 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -134,7 +134,8 @@ static int parse_key(const char *str, wg_key key)
 	return 0;
 }
 
-static int parse_allowed_ips(const char *allowed_ips, wg_peer *peer)
+static int parse_allowed_ips(const char *allowed_ips, wg_peer *peer,
+							bool *do_split_routing)
 {
 	struct wg_allowedip *curaip, *allowedip;
 	char buf[INET6_ADDRSTRLEN];
@@ -142,6 +143,7 @@ static int parse_allowed_ips(const char *allowed_ips, wg_peer *peer)
 	char *send;
 	int i;
 
+	*do_split_routing = true;
 	curaip = NULL;
 	tokens = g_strsplit(allowed_ips, ", ", -1);
 	for (i = 0; tokens[i]; i++) {
@@ -169,6 +171,16 @@ static int parse_allowed_ips(const char *allowed_ips, wg_peer *peer)
 
 		allowedip->cidr = g_ascii_strtoull(toks[1], &send, 10);
 
+		/*
+		 * Force split routing off if any address is detected as using
+		 * these as allowed IPs indicates that WireGuard is to be used
+		 * to route all traffic.
+		 */
+		if (connman_inet_is_any_addr(toks[0], allowedip->family))
+			*do_split_routing = false;
+
+		g_strfreev(toks);
+
 		if (!curaip)
 			peer->first_allowedip = allowedip;
 		else
@@ -579,6 +591,7 @@ static int wg_connect(struct vpn_provider *provider,
 	struct wireguard_info *info;
 	const char *option, *gateway;
 	char *ifname;
+	bool do_split_routing = true;
 	int err = -EINVAL;
 
 	info = create_private_data(provider);
@@ -641,12 +654,15 @@ static int wg_connect(struct vpn_provider *provider,
 		DBG("WireGuard.AllowedIPs is missing");
 		goto error;
 	}
-	err = parse_allowed_ips(option, &info->peer);
+	err = parse_allowed_ips(option, &info->peer, &do_split_routing);
 	if (err) {
 		DBG("Failed to parse allowed IPs %s", option);
 		goto error;
 	}
 
+	vpn_provider_set_boolean(provider, "SplitRouting", do_split_routing,
+							false);
+
 	option = vpn_provider_get_string(provider,
 					"WireGuard.PersistentKeepalive");
 	if (option) {
-- 
2.39.5

