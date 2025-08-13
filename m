Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04C35972
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098994; cv=none; b=at4E9xEPlri+DqGCEXtC+ZS4kiwvoYGZfuiCpx8iSXxx4hwx30AWVc9QsfmhGRJ0bTUm3TXAFWSmZeMDuAaojqJ2uGtnU5N4JvZsIbVkv8LWXTQ0n5SJzA8Oe5g51AqRLKOWKFSz+jjxGPmkhSr5GgIXSy9TYxNySt5y0Z+Ar4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098994; c=relaxed/simple;
	bh=9YeBaAjJ3g/7AMF+oR5MaCf5+rx93VuyQE1oNJZSeg4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l132/8pHkPPojosYABQ4E+DX8JvWCr3fC60oh8/6VTLtrEOwzTZ3Pzqa7keFZG5g/2YPW/VP6uxDaSWyVVjaDOdhIQh9qjDuUpDpj6243ewtwagmRZ0fwp8EfxNsbZAfEzAHSnlHLpn6oQTr7xCNu0aDyMyLnVrI4WLq1VvVFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=CH0JNv0u; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="CH0JNv0u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jf7Atlq5JmBSlLpsij4ePE1mkV5c26Y4n3Wemr3fv8A=; b=CH0JNv0uNhJIupTuJyS7zAxJpA
	RMoiOMC8mHY9JL5l5+SrWpsy6MdYrtGSKqm5D/P0a1JVBTyMfIYNSsrGfPHgnEWpFy/XZqlW0O/rj
	r29mjkI/ym2iVbLskIpIqVLbt1UU0Lm+pMZDgnbdTWg3Hb0ZRMUgVpKEF2P+nG33Gs10qXr8ll/I5
	nPeXEsxkM08ECAjvPuCoxg8S5F+00WSArBFawQqKDznEAn8Hu5w4QOvBj7ewEwBeBUSktsZyTXcdU
	63Utm9v8/mB4uLK4Od1f43c1Mfpy3nJ5+lbUd9OWqdeTyVMiG5sVgeXG6COyoXR64k/da6oDYTgGk
	HpsphEXA==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-1q
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 36/42] wireguard: Rework hostname resolve, split code and do not resolve IP
Date: Wed, 13 Aug 2025 18:02:08 +0300
Message-Id: <20250813150214.189282-37-jussi.laakkonen@jolla.com>
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
 vpn/plugins/wireguard.c | 118 ++++++++++++++++++++++++++++------------
 1 file changed, 83 insertions(+), 35 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index cd91dd15..07829cd6 100644
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
@@ -715,6 +756,7 @@ static int wg_connect(struct vpn_provider *provider,
 	char *ifname;
 	bool do_split_routing = true;
 	int err = -EINVAL;
+	int family;
 
 	info = create_private_data(provider);
 
@@ -806,7 +848,7 @@ static int wg_connect(struct vpn_provider *provider,
 	 * is needed as it is done over potentially misconfigured WireGuard
 	 * connection that may end up blocking vpnd with getaddrinfo().
 	 */
-	err = parse_endpoint(gateway, option,
+	err = parse_endpoint_hostname(gateway, option,
 			(struct sockaddr_u *)&info->peer.endpoint.addr);
 	if (err) {
 		DBG("Failed to parse endpoint %s:%s", gateway, option);
@@ -866,7 +908,13 @@ done:
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

