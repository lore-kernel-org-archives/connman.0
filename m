Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F12E7F10
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244078; cv=none; b=Qvguv3GdMsI3wDN8qQjfq+9ipSjuR88pV4IddFRVLrJrGgzEO1zGsSHTXnksqa1R/nVx6qvpK9BhvoFbjtBnZPQ6IJaAdrqOdYOO1/VLYFzC4pW7Yq3xZzaIWzOJUHuRWALNCVWyZiBJMzNDBEL7YTeOC9hejIZZ+E4tOYTJc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244078; c=relaxed/simple;
	bh=xWLzUCbOly5OgIecwqtQcZ5O77tGYTf4EbkGwKd6CuE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QWr4o3uDEaRuWTBgxE9I4UNcjj9O73L8WIpqF5dIQ2bQ2RELFHy/KsxcUnFsLEiyCBxI1ZAcilAxSr4w5m1QXl3jIOuOSM498WTnGocHCWZSeORZH9U4B5iTwew/hrZrNliHdFIbUEn89kmrqB741V8QHoQJWbtjd7PUqlafP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=VTBxEtws; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="VTBxEtws"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OawXDQIBXbRio6/Iu3l1+HPY+lhZKkbQDVJBcYGzJwA=; b=VTBxEtwsrOLOFtFh9OiCEeI4dW
	N6Gp0IyoYN/3iek+8hPhkcA288Cf2puM3YPxfKgBEp+C+5MUE8zot4VjyCHgcpsSsK3B70ZyjrwtV
	ae7Fp4rcyroH0c1gbvwglaNuZLcHs/F5yqdmzflqZR3WPscQS5gFjcTjt/Nb6D7WWLIoaciKWWODr
	7ydh/Kh0HHf3fxXWMRmY8XkSgcVg3gzM1Nco+c6ZrN94Y4GUNa5AZ1NSjnXhr4WtRCBctEDM9lUjh
	2nU+GWNvsZupRWh47QzoEjDurI/rjEE4SgFWerGtg3MOyAk94PMmxcJP7c56ZF/yt1Wb9V3ut2ORc
	P6Szh6RA==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-2T
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 44/45] wireguard: Fix FQDN by using the resolved IP as the gateway
Date: Fri, 11 Jul 2025 17:27:35 +0300
Message-Id: <20250711142736.1757060-45-jussi.laakkonen@jolla.com>
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

This fixes the hostname use with WireGuard by using the resolved IP as
the gateway for the ipaddress. This address will be sent to connmand for
setting up the routes and DNS will be otherwise broken if the FQDN is
set "as is" as the gateway.

By returning also the resolved IP in string format in the initial
resolve, and setting it as the gateway for the address for the interface
in in the ipaddress.c the FQDN using WireGuard services can be used.
---
 vpn/plugins/wireguard.c | 80 +++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 2787aa7e..98a9c71a 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -249,10 +249,35 @@ static int get_endpoint_addr(const char *host, const char *port, int flags,
 	return 0;
 }
 
+static const char *endpoint_to_str(struct wg_peer *peer, char *buf,
+							socklen_t len)
+{
+	struct sockaddr_u *addr;
+	int family;
+
+	addr = (struct sockaddr_u *)&peer->endpoint.addr;
+	family = peer->endpoint.addr.sa_family;
+
+	switch (family) {
+	case AF_INET:
+		return inet_ntop(family, &addr->sin.sin_addr, buf, len);
+	case AF_INET6:
+		return inet_ntop(family, &addr->sin6.sin6_addr, buf, len);
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 static int parse_endpoint_hostname(const char *host, const char *port,
-							struct sockaddr_u *addr)
+							struct wg_peer *peer,
+							char **gateway_resolved)
 {
+	struct sockaddr_u *addr;
 	char **tokens;
+	const char *gw = NULL;
+	char buf[INET6_ADDRSTRLEN] = { 0 };
 	unsigned int len;
 	int err;
 
@@ -271,9 +296,21 @@ static int parse_endpoint_hostname(const char *host, const char *port,
 
 	DBG("using host %s", tokens[0]);
 
+	addr = (struct sockaddr_u *)&peer->endpoint.addr;
+
 	err = get_endpoint_addr(tokens[0], port, 0, addr);
-	if (!err)
+	if (!err) {
+		/*
+		 * In case the endpoint is an host address use the resolved
+		 * IP address as gateway for DNS over WireGuard to work.
+		 */
+		if (connman_inet_check_ipaddress(tokens[0]) <= 0)
+			gw = endpoint_to_str(peer, buf, INET6_ADDRSTRLEN);
+
 		DBG("success");
+	}
+
+	*gateway_resolved = gw ? g_strdup(gw) : g_strdup(tokens[0]);
 
 	g_strfreev(tokens);
 
@@ -648,27 +685,6 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 	return G_SOURCE_REMOVE;
 }
 
-static const char *endpoint_to_str(struct wg_peer *peer, char *buf,
-							socklen_t len)
-{
-	struct sockaddr_u *addr;
-	int family;
-
-	addr = (struct sockaddr_u *)&peer->endpoint.addr;
-	family = peer->endpoint.addr.sa_family;
-
-	switch (family) {
-	case AF_INET:
-		return inet_ntop(family, &addr->sin.sin_addr, buf, len);
-	case AF_INET6:
-		return inet_ntop(family, &addr->sin6.sin6_addr, buf, len);
-	default:
-		break;
-	}
-
-	return NULL;
-}
-
 static gboolean wg_route_setup_cb(gpointer user_data)
 {
 	struct wireguard_info *info = user_data;
@@ -767,7 +783,9 @@ static int wg_connect(struct vpn_provider *provider,
 {
 	struct wg_ipaddresses ipaddresses = { 0 };
 	struct wireguard_info *info;
-	const char *option, *gateway;
+	const char *option;
+	const char *endpoint;
+	char *gateway = NULL;
 	char *ifname;
 	bool do_split_routing = true;
 	int err = -EINVAL;
@@ -856,21 +874,20 @@ static int wg_connect(struct vpn_provider *provider,
 	if (!option)
 		option = "51820";
 
-	gateway = vpn_provider_get_string(provider, "Host");
+	endpoint = vpn_provider_get_string(provider, "Host");
 	/*
 	 * Use the resolve timeout only with re-resolve. Here the network
 	 * is setup as the transport is used. In succeeding attempts resolving
 	 * is needed as it is done over potentially misconfigured WireGuard
 	 * connection that may end up blocking vpnd with getaddrinfo().
 	 */
-	err = parse_endpoint_hostname(gateway, option,
-			(struct sockaddr_u *)&info->peer.endpoint.addr);
+	err = parse_endpoint_hostname(endpoint, option, &info->peer, &gateway);
 	if (err) {
-		DBG("Failed to parse endpoint %s:%s", gateway, option);
+		DBG("Failed to parse endpoint %s:%s", endpoint, option);
 		goto error;
 	}
 
-	info->endpoint_fqdn = g_strdup(gateway);
+	info->endpoint_fqdn = g_strdup(endpoint);
 	info->port = g_strdup(option);
 
 	option = vpn_provider_get_string(provider, "WireGuard.Address");
@@ -878,11 +895,14 @@ static int wg_connect(struct vpn_provider *provider,
 		DBG("Missing WireGuard.Address configuration");
 		goto error;
 	}
+
 	err = parse_addresses(option, gateway, &ipaddresses);
 	if (err) {
-		DBG("Failed to parse addresses %s gateway %s", option, gateway);
+		DBG("Failed to parse addresses %s endpoint %s gateway %s",
+						option, endpoint, gateway);
 		goto error;
 	}
+	g_free(gateway);
 
 	ifname = get_ifname();
 	if (!ifname) {
-- 
2.39.5

