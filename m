Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840C2E7BDE
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244080; cv=none; b=HoNmA1dczukFgBsVvRc2+BSESfHF43+yVJ5QnQyb372c68Wf3W2gsJEIpYBgcQI1Zl9gPSz92CiAimdMnMwRXK/7D9vD/wLFOVb1ZVoS4FPnNrM3wYAPdzCMIyPNyAnYKZlNLS4flVgaH9AE16koXHaQQ/7BeKJU90Ma9I6VNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244080; c=relaxed/simple;
	bh=criNfX18F3+mkbTUedJXeibugujStQFZ1k2ce4tg+gM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttmvgdqhgBnzBplwvKDZEPl4lDIJZSMdcZxEwCEzK7z8Hd6wEd9ZKjQhrqUjhNDUJe2JLyWjuyaEotQ4NjjyWjevEWJhaNiV0oVX+laU23YLe8iJlw/jDwoCptdLpdk4cAxhmU5yRvHvmKpr/DcGGI1493ziRgjRLS8Qw+S01HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ch4nQLci; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ch4nQLci"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+d2SUfBV5TBc5ONI8kwZNaWh64mZmPmozWpCWSzj9TM=; b=ch4nQLci6/lhW/dcGY3ZoIWXRN
	FPlHDDnlgwvkhLSpH4ZbZ5uiqaodiwIVXZtKnDaz0mySOR7OcGyLaex4O0uG//1mFcGbE/Zla8y54
	wPIAFCRJvrm6qpnp2kRKmiL/+yndlxgRGbLtXH3LG4c26nlH9TafKBuMwanYm3ql3TclxLO+N/SVh
	wWm3iawdjdClADu0oNJ5PZ8uVUpACnRk31e3Rb4alyXJweunIiajOh/o2JJxvgxlsqufNqOlAIt3P
	Qs8MulyBot6EvMbSS9iG5Q6MaUdAhxnuRjc7oG8vsUBOHAHRq9CXfkASW8oLdLbmticQ4xXg1d7fu
	33QnDftQ==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-0F
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 29/45] wireguard: Set split routing based on AllowedIPs
Date: Fri, 11 Jul 2025 17:27:20 +0300
Message-Id: <20250711142736.1757060-30-jussi.laakkonen@jolla.com>
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
index 2783d9bd..07719273 100644
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
@@ -576,6 +588,7 @@ static int wg_connect(struct vpn_provider *provider,
 	struct wireguard_info *info;
 	const char *option, *gateway;
 	char *ifname;
+	bool do_split_routing = true;
 	int err = -EINVAL;
 
 	info = create_private_data(provider);
@@ -638,12 +651,15 @@ static int wg_connect(struct vpn_provider *provider,
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

