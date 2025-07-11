Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B12E7BC6
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244079; cv=none; b=OgvV88ZtDYIm4vSs6O+a4+Nn8hPUQMUkX97IJnqRATkaWNZSpx69PsRFlELsody4UeZz/8p8TmbAb0Qq6oK0IBHCt49Mels8rxmx0fqf0FOvP+i708Q7lOdYNEpIeA0u1il0Aaz87NQjstNJAYRMsODFyD6+2dE+5edqC9Oo56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244079; c=relaxed/simple;
	bh=Llu4ChIuxfHFq1b/ZRvHksbTzJcabIeR+WboiOP8560=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTR3KHfsWZ99NrWxXD2lL4XBux4fZIG6JOsOJnBUV3ohQ8SruBd6f7ykXTN1GW4eq7H2un0+ZVMbKsJSKGyAXORlrkx3hlNpSs7TaoNh5hgQSZ5j8Uzlj3nYgmVMki5diRWJyy3fhLfGmXzp9LO7Tlm1rya7dSc6Qe2H/ZNUrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ESvRl7Cq; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ESvRl7Cq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sMzbvVB0f6Gmlp57L8KEgZHHQeZiRojcK66g6T7ARco=; b=ESvRl7Cq7z6KMQ8kQNAjPz3mvz
	wzdbGGOOnAkdNSnaPJtiyNrWQarHXKP+AqIRZmzuflnM14idKY7/79PoydCDO54DfNdbjl60drrDK
	qBwf0uYYDoRugvpy+SnBsNRqzf4Lrj1CSLPgJlqXiAu3uVZGTkf3TDtLPB+FhvEVOU87qNLjm9UKi
	4JC7jcDDebP+LgfSTE1x2unQFvJnx368BT09JlnXP54HHMOt2/6x/sFePLPH56glO3bY5f2HTQO34
	8iR4mWxOV7J6E8umYyeToC3mBpsSunEclobi2IvdFqg63ROBiz+8EXIhyxzOPOf/751ZUj3VB37CX
	fClawPDw==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-3A
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 27/45] wireguard: Support both IPv4 and IPv6 address
Date: Fri, 11 Jul 2025 17:27:18 +0300
Message-Id: <20250711142736.1757060-28-jussi.laakkonen@jolla.com>
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

In the configurations there is a possibility to add multiple entries,
separated by commas, for "Address". Implement supporting this in the
plugin via the plugin's WireGuard.Address option.

Only the first valid IPv4 and IPv6 addresses are utilized. The rest are
simply ignored.
---
 vpn/plugins/wireguard.c | 116 +++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index e2714c54..2783d9bd 100644
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
@@ -525,7 +572,7 @@ static int wg_connect(struct vpn_provider *provider,
 			vpn_provider_connect_cb_t cb,
 			const char *dbus_sender, void *user_data)
 {
-	struct connman_ipaddress *ipaddress = NULL;
+	struct wg_ipaddresses ipaddresses = { 0 };
 	struct wireguard_info *info;
 	const char *option, *gateway;
 	char *ifname;
@@ -632,9 +679,9 @@ static int wg_connect(struct vpn_provider *provider,
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
 
@@ -660,14 +707,21 @@ static int wg_connect(struct vpn_provider *provider,
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

