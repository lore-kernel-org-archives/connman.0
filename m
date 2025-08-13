Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B523ABA8
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098958; cv=none; b=PAXXYCWjsGEPaqUqvIaaeLV+okacq5RPgHiYGSzPl6tIFo5plxIfdLLPeQK+Z+MzerWyNtXLKcAsOzGCWYx1DakewbpNrM55y8kpPC6lZcFyX0H3hKPQ/DukpSC3FEcIHMKtA5ZzeaWjLjCYUVW045Qe7uB1fFUXwS8pvK7iXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098958; c=relaxed/simple;
	bh=BerLcbz/uKHduWhMP/4kWaC6MQkV/5h/E3yPqhuvpQ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G05NMD9H/X1x3Cax9d85IOyYAupsg8TSu4BXXTVxjZ3cwn/uuT6IjJ2akThMsOV5Gi1VBuDoH8aIcEVcdvRfq9Vq18HziX64UtVS5h2i78XKKlrZe0lqVGUknx80jYfGF0J0SsqNsATl7pAEuhcyPQykZMVmU2kvxl3GIqXtD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=OTJvJ3Dk; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="OTJvJ3Dk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fZxNYJweoOj1ieIR7e96qpy5eaJEt3vvjFiDSlxdp+M=; b=OTJvJ3Dk1NSnZ06SXBS7bBnvhE
	wPcihKeIZJ0WTl1EPs05ROEHqplM/aHdRWUUNC/fTofoVU6PbOtxhmfriKbtd3mlEjf0N3EObOzPP
	0mhN5I5fmW25aCjjmS7v96DNo6tR7RJm5d5BUhfBH4KWqe3s64YOMAdx/j45GaUkHu1u3I6v+T17u
	BxFLBgOM3j9v7+rLvvPh1FNcgg2ooAozIHbJvSXzKp56kLD7ZLxrHJgh5SFilM9OFCmLwV+vWbNKS
	71cXFLDB6rTOWWAi0l39OiCsLxC/rhq5EwOG49+/0gCdDXAO5x+oIr2XSVi2Hg+PpP02MUwxRqPPf
	RRVwGUtw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-0H
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 25/42] wireguard: Support both IPv4 and IPv6 address
Date: Wed, 13 Aug 2025 18:01:57 +0300
Message-Id: <20250813150214.189282-26-jussi.laakkonen@jolla.com>
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

In the configurations there is a possibility to add multiple entries,
separated by commas, for "Address". Implement supporting this in the
plugin via the plugin's WireGuard.Address option.

Only the first valid IPv4 and IPv6 addresses are utilized. The rest are
simply ignored.
---
 vpn/plugins/wireguard.c | 116 +++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 2f077880..2531fff6 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -245,50 +245,97 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 	return 0;
 }
 
-static int parse_address(const char *address, const char *gateway,
-		struct connman_ipaddress **ipaddress)
+struct wg_ipaddresses {
+	struct connman_ipaddress *ipaddress_ipv4;
+	struct connman_ipaddress *ipaddress_ipv6;
+};
+
+static int parse_addresses(const char *address, const char *gateway,
+		struct wg_ipaddresses *ipaddresses)
 {
 	char buf[INET6_ADDRSTRLEN];
 	unsigned char prefixlen;
+	char **addresses;
 	char **tokens;
 	char *end, *netmask;
 	int err;
+	int i;
 
-	tokens = g_strsplit(address, "/", -1);
-	if (g_strv_length(tokens) != 2) {
-		g_strfreev(tokens);
+	addresses = g_strsplit(address, ", ", -1);
+	if (!g_strv_length(addresses)) {
+		g_strfreev(addresses);
 		return -EINVAL;
 	}
 
-	prefixlen = g_ascii_strtoull(tokens[1], &end, 10);
+	for (i = 0; addresses[i]; i++) {
+		struct connman_ipaddress *ipaddress = NULL;
+		int family = 0;
+
+		tokens = g_strsplit(addresses[i], "/", -1);
+		if (g_strv_length(tokens) != 2) {
+			g_strfreev(tokens);
+			DBG("Invalid Wireguard.Address value %s", addresses[i]);
+			continue;
+		}
 
-	if (inet_pton(AF_INET, tokens[0], buf) == 1) {
-		netmask = g_strdup_printf("%d.%d.%d.%d",
+		DBG("address %s", addresses[i]);
+
+		prefixlen = g_ascii_strtoull(tokens[1], &end, 10);
+
+		if (inet_pton(AF_INET, tokens[0], buf) == 1) {
+			if (ipaddresses->ipaddress_ipv4) {
+				g_strfreev(tokens);
+				DBG("IPv4 address already set");
+				err = -EALREADY;
+				continue;
+			}
+
+			family = AF_INET;
+			netmask = g_strdup_printf("%d.%d.%d.%d",
 				((0xffffffff << (32 - prefixlen)) >> 24) & 0xff,
 				((0xffffffff << (32 - prefixlen)) >> 16) & 0xff,
 				((0xffffffff << (32 - prefixlen)) >> 8) & 0xff,
 				((0xffffffff << (32 - prefixlen)) >> 0) & 0xff);
 
-		*ipaddress = connman_ipaddress_alloc(AF_INET);
-		err = connman_ipaddress_set_ipv4(*ipaddress, tokens[0],
-						netmask, gateway);
-		g_free(netmask);
-	} else if (inet_pton(AF_INET6, tokens[0], buf) == 1) {
-		*ipaddress = connman_ipaddress_alloc(AF_INET6);
-		err = connman_ipaddress_set_ipv6(*ipaddress, tokens[0],
-						prefixlen, gateway);
-	} else {
-		DBG("Invalid Wireguard.Address value");
-		err = -EINVAL;
-	}
+			ipaddress = connman_ipaddress_alloc(family);
+			err = connman_ipaddress_set_ipv4(ipaddress, tokens[0],
+							netmask, gateway);
+			g_free(netmask);
+		} else if (inet_pton(AF_INET6, tokens[0], buf) == 1) {
+			if (ipaddresses->ipaddress_ipv6) {
+				g_strfreev(tokens);
+				DBG("IPv6 address already set");
+				err = -EALREADY;
+				continue;
+			}
+
+			family = AF_INET6;
+			ipaddress = connman_ipaddress_alloc(family);
+			err = connman_ipaddress_set_ipv6(ipaddress, tokens[0],
+							prefixlen, gateway);
+		} else {
+			DBG("Invalid Wireguard.Address value");
+			err = -EINVAL;
+		}
 
-	connman_ipaddress_set_p2p(*ipaddress, true);
+		g_strfreev(tokens);
+		if (err) {
+			connman_ipaddress_free(ipaddress);
+			continue;
+		}
 
-	g_strfreev(tokens);
-	if (err)
-		connman_ipaddress_free(*ipaddress);
+		connman_ipaddress_set_p2p(ipaddress, true);
 
-	return err;
+		if (family == AF_INET)
+			ipaddresses->ipaddress_ipv4 = ipaddress;
+		else if (family == AF_INET6)
+			ipaddresses->ipaddress_ipv6 = ipaddress;
+	}
+
+	g_strfreev(addresses);
+
+	return (ipaddresses->ipaddress_ipv4 || ipaddresses->ipaddress_ipv6) ?
+				0 : -EINVAL;
 }
 
 struct ifname_data {
@@ -528,7 +575,7 @@ static int wg_connect(struct vpn_provider *provider,
 			vpn_provider_connect_cb_t cb,
 			const char *dbus_sender, void *user_data)
 {
-	struct connman_ipaddress *ipaddress = NULL;
+	struct wg_ipaddresses ipaddresses = { 0 };
 	struct wireguard_info *info;
 	const char *option, *gateway;
 	char *ifname;
@@ -635,9 +682,9 @@ static int wg_connect(struct vpn_provider *provider,
 		DBG("Missing WireGuard.Address configuration");
 		goto error;
 	}
-	err = parse_address(option, gateway, &ipaddress);
+	err = parse_addresses(option, gateway, &ipaddresses);
 	if (err) {
-		DBG("Failed to parse address %s gateway %s", option, gateway);
+		DBG("Failed to parse addresses %s gateway %s", option, gateway);
 		goto error;
 	}
 
@@ -663,14 +710,21 @@ static int wg_connect(struct vpn_provider *provider,
 	}
 
 	vpn_set_ifname(provider, info->device.name);
-	if (ipaddress)
-		vpn_provider_set_ipaddress(provider, ipaddress);
+
+	if (ipaddresses.ipaddress_ipv4)
+		vpn_provider_set_ipaddress(provider,
+						ipaddresses.ipaddress_ipv4);
+
+	if (ipaddresses.ipaddress_ipv6)
+		vpn_provider_set_ipaddress(provider,
+						ipaddresses.ipaddress_ipv6);
 
 done:
 	if (cb)
 		cb(provider, user_data, -err);
 
-	connman_ipaddress_free(ipaddress);
+	connman_ipaddress_free(ipaddresses.ipaddress_ipv4);
+	connman_ipaddress_free(ipaddresses.ipaddress_ipv6);
 
 	if (!err)
 		run_dns_reresolve(info);
-- 
2.39.5

