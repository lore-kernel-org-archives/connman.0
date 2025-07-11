Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065772E7F04
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244079; cv=none; b=Q7Zjf2r+EW4cH+6KwF8t+o+GDHtRMPE8CnGcQD0kl7PmIH/H926lCcWulqRsTZUplz1m2lo7c1d/vsfWY6LPUEdSafI3lw6or+rDBpD2WsItD/htUHYpScjpQm8QPNNjA4YZQBZsfdp3C6YPuv50e9uOw4iYi/lyjA18InvIuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244079; c=relaxed/simple;
	bh=qF30m9nDA7qyuFLtPXa5USoZojBHpyhrhTZGaGhcl4Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8HaIxo4Cpt+rKNg9LgT+sGIqvjvFKOZ3A0hVYUbfhuvvCOXSqzEBNVI6KzWKxWxcFYwjQgSCBmMs8hPG2Sr/4TbTLkS87KFGUfK8fyk8Y6EVcL772wqx0w5ufHr6CkvYgWwiNtkKRJDlzw0m2QpWvKivarSmYK6xDGucXb9a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=fRj73ihE; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="fRj73ihE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+e66HQOPrdLqAISQ2Egmvm0YUHq7BctSn0FhNLyBDBU=; b=fRj73ihEwN2zjf3lTcjD2otjHe
	6WyYYABehQTP0pyQ6RLaxaWyek4bKBRSJuAhVwUsw2xWriltAv5KEt/rqplkeS/0xkqAXl13gBNJ8
	1JXjIOSscPrklY777/pQT52ZVNnIbqpji9iT2GEysCRIsHIPFV12tjmurN5dZHynSpC1gd/M3FFE1
	/QhU1gj0GqplA6rwnmWhYlnECLo2NTK1juFQoDzweHDok7NCO3rHTtn6kLibcEQDT6F+MTqR1QL4q
	97VeAj3J6CEOz6GqqMk3gu/w1No4LiGOycSoxvTVCXpDrYYk1WaNRyHSMrAH9jLlswftIJ/dZNEeW
	x/pMhRWg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-1l
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 39/45] wireguard: Rework hostname resolve, split code and do not resolve IP
Date: Fri, 11 Jul 2025 17:27:30 +0300
Message-Id: <20250711142736.1757060-40-jussi.laakkonen@jolla.com>
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

This changes how the resolving of the hostname is done and restructures
the code.

First, the endpoint parsing is split into two, mainly because the
resolving of the host is done differently when doing initial connect,
and when executing the DNS reresolve. This is because initial resolving
can be done with getaddrinfo() but reresolve is done with GResolv to
avoid blocking in case the network is not properly setup, which leads
vpnd to be frozen until the timeout occurs. With GResolv the results are
simply converted to sockaddr struct(s) using getifaddrs() with
AI_NUMERICHOST to avoid another DNS query.

Second, if the host is defined as an IP address there is no need to
start the DNS reresolve.

Third, the stop condition for DNS reresolve does now retry also with
name error (NXDOMAIN) and no answer (NOERROR without a message).
---
 vpn/plugins/wireguard.c | 119 ++++++++++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 35 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 756c6f88..a2d92ec6 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -197,42 +197,27 @@ static int parse_allowed_ips(const char *allowed_ips, wg_peer *peer,
 	return 0;
 }
 
-static int parse_endpoint(const char *host, const char *port, struct sockaddr_u *addr)
+static int get_endpoint_addr(const char *host, const char *port, int flags,
+							struct sockaddr_u *addr)
 {
 	struct addrinfo hints;
-	struct addrinfo *result, *rp;
-	char **tokens;
+	struct addrinfo *result = NULL, *rp;
 	int sk;
 	int err;
-	unsigned int len;
-
-	/*
-	 * getaddrinfo() relies on inet_pton() that suggests using addresses
-	 * without CIDR notation. Host should contain the address in CIDR
-	 * notation to be able to pass the prefix length to ConnMan via D-Bus.
-	 */
-	tokens = g_strsplit(host, "/", -1);
-	len = g_strv_length(tokens);
-	if (len > 2 || len < 1) {
-		DBG("Failure tokenizing host %s", host);
-		g_strfreev(tokens);
-		return -EINVAL;
-	}
-
-	DBG("using host %s", tokens[0]);
 
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_family = AF_UNSPEC;
 	hints.ai_socktype = SOCK_DGRAM;
-	hints.ai_flags = 0;
+	hints.ai_flags = flags;
 	hints.ai_protocol = 0;
 
-	err = getaddrinfo(tokens[0], port, &hints, &result);
-	g_strfreev(tokens);
-
-	/* Any non-zero return from getaddrinfo is an error */
-	if (err) {
+	err = getaddrinfo(host, port, &hints, &result);
+	if (err) { /* Any non-zero return from getaddrinfo is an error */
 		DBG("Failed to resolve host address: %s", gai_strerror(err));
+
+		if (result)
+			freeaddrinfo(result);
+
 		return -EINVAL;
 	}
 
@@ -250,7 +235,8 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 	}
 
 	if (!rp) {
-		DBG("no connectable address found in results");
+		DBG("no connectable address found in results: %s",
+							strerror(errno));
 		freeaddrinfo(result);
 		return -EHOSTUNREACH;
 	}
@@ -261,6 +247,62 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 	return 0;
 }
 
+static int parse_endpoint_hostname(const char *host, const char *port,
+							struct sockaddr_u *addr)
+{
+	char **tokens;
+	unsigned int len;
+	int err;
+
+	/*
+	 * getaddrinfo() relies on inet_pton() that suggests using addresses
+	 * without CIDR notation. Host should contain the address in CIDR
+	 * notation to be able to pass the prefix length to ConnMan via D-Bus.
+	 */
+	tokens = g_strsplit(host, "/", -1);
+	len = g_strv_length(tokens);
+	if (len > 2 || len < 1) {
+		DBG("Failure tokenizing host %s", host);
+		g_strfreev(tokens);
+		return -EINVAL;
+	}
+
+	DBG("using host %s", tokens[0]);
+
+	err = get_endpoint_addr(tokens[0], port, 0, addr);
+	if (!err)
+		DBG("success");
+
+	g_strfreev(tokens);
+
+	return err;
+}
+
+static int parse_endpoint_results(char **results, const char *port,
+							struct sockaddr_u *addr)
+{
+	int err = 0;
+	int i;
+
+	if (!results) {
+		DBG("no results");
+		return -EINVAL;
+	}
+
+	for (i = 0; results[i]; i++) {
+		DBG("using host %s", results[i]);
+
+		/* Use getaddrinfo to fill in the structs after resolve */
+		err = get_endpoint_addr(results[i], port, AI_NUMERICHOST, addr);
+		if (!err) {
+			DBG("success");
+			return err;
+		}
+	}
+
+	return err;
+}
+
 struct wg_ipaddresses {
 	struct connman_ipaddress *ipaddress_ipv4;
 	struct connman_ipaddress *ipaddress_ipv6;
@@ -454,7 +496,7 @@ static void resolve_endpoint_cb(GResolvResultStatus status,
 {
 	struct wireguard_info *info = user_data;
 	struct sockaddr_u addr;
-	int err;
+	int err = 0;
 
 	DBG("");
 
@@ -486,6 +528,8 @@ static void resolve_endpoint_cb(GResolvResultStatus status,
 		DBG("resolv success, parse endpoint");
 		break;
 	/* request timeouts or an server issue is not an error, try again */
+	case G_RESOLV_RESULT_STATUS_NAME_ERROR: /* NXDOMAIN, might recover? */
+	case G_RESOLV_RESULT_STATUS_NO_ANSWER:
 	case G_RESOLV_RESULT_STATUS_NO_RESPONSE:
 	case G_RESOLV_RESULT_STATUS_SERVER_FAILURE:
 		DBG("retry DNS reresolve");
@@ -498,15 +542,12 @@ static void resolve_endpoint_cb(GResolvResultStatus status,
 	/* Consider these as non-continuable errors */
 	case G_RESOLV_RESULT_STATUS_ERROR:
 	case G_RESOLV_RESULT_STATUS_FORMAT_ERROR:
-	case G_RESOLV_RESULT_STATUS_NAME_ERROR:
 	case G_RESOLV_RESULT_STATUS_NOT_IMPLEMENTED:
 	case G_RESOLV_RESULT_STATUS_REFUSED:
-	case G_RESOLV_RESULT_STATUS_NO_ANSWER:
-		DBG("stop DNS reresolve");
-		if (info->provider)
+		DBG("stop DNS reresolve, error %d", status);
+		if (err && info->provider)
 			vpn_provider_add_error(info->provider,
 					VPN_PROVIDER_ERROR_CONNECT_FAILED);
-
 		return;
 	}
 
@@ -514,7 +555,7 @@ static void resolve_endpoint_cb(GResolvResultStatus status,
 	 * If this fails after being connected it means configuration error
 	 * that results in connection errors.
 	 */
-	err = parse_endpoint(info->endpoint_fqdn, info->port, &addr);
+	err = parse_endpoint_results(results, info->port, &addr);
 	if (err) {
 		if (info->provider)
 			vpn_provider_add_error(info->provider,
@@ -575,6 +616,7 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 	}
 
 	DBG("endpoint_fqdn %s", info->endpoint_fqdn);
+
 	info->resolv_id = vpn_util_resolve_hostname(info->resolv,
 						info->endpoint_fqdn,
 						resolve_endpoint_cb, info);
@@ -712,6 +754,7 @@ static int wg_connect(struct vpn_provider *provider,
 	char *ifname;
 	bool do_split_routing = true;
 	int err = -EINVAL;
+	int family;
 
 	info = create_private_data(provider);
 
@@ -803,7 +846,7 @@ static int wg_connect(struct vpn_provider *provider,
 	 * is needed as it is done over potentially misconfigured WireGuard
 	 * connection that may end up blocking vpnd with getaddrinfo().
 	 */
-	err = parse_endpoint(gateway, option,
+	err = parse_endpoint_hostname(gateway, option,
 			(struct sockaddr_u *)&info->peer.endpoint.addr);
 	if (err) {
 		DBG("Failed to parse endpoint %s:%s", gateway, option);
@@ -863,7 +906,13 @@ done:
 	connman_ipaddress_free(ipaddresses.ipaddress_ipv6);
 
 	if (!err) {
-		run_dns_reresolve(info);
+		/* Run DNS reresolve only for hostnames that require resolve. */
+		family = connman_inet_check_ipaddress(info->endpoint_fqdn);
+		if (family != AF_INET && family != AF_INET6) {
+			DBG("start DNS reresolve for %s", info->endpoint_fqdn);
+			run_dns_reresolve(info);
+		}
+
 		run_route_setup(info, ROUTE_SETUP_TIMEOUT);
 	}
 
-- 
2.39.5

