Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0B2E7BDD
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244080; cv=none; b=fqgAjnOho2raajNPgVWD+8FitNI8NMfsOxT+e3pqo/OWI42uG+sWxj/Bv/cwuKs4db4BtGfHNSNQXJHBbmWA20VmMtrPeRELnKsZpBOjsV6Gmn2J8LOaaxm6+mFBwQeI8LLV+lBX9xmNmBrKCfd9isB1bT7lE5dxm77hO3XoM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244080; c=relaxed/simple;
	bh=PqWdIetpG1HedQRU4Tla+www2a72JSzb0/hrf99S2Ng=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSTJ7TMS3EEHxAwTxX5Wg+S2fpSj1DOWJTFE5PRC6djU3Qft+NCH8QBXG+1o3inuNhKsoJdPi0ovkQip+eLsh9p13NiEDsJdTvkZ9U/JblImxlr3wR8K20sgLWe1weKC85Ax3NVv9vePRQn5hqpaNmtGCUEc44ypWZFUre3lOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=bGi+nujO; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="bGi+nujO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dzgjUUCMpBvIX8l0uP7BhBf07fR66cdqoYe3q2TuNsg=; b=bGi+nujOUwEvE6BFFWSsfTZwuo
	ldmjWMM2zCEuxUyWjxt2cN6OzmlK40WVZNkEkcKoJ21yXYbVaLx4HOtKw8tByEFt62W/sFRkN8kTl
	kw3HQEycE4izJsZpVbq/991PKVdm4hkttMLYQMQtG1CsXvB4NfLuqCfaB6sVvDPXcxgSwiEmE8YiE
	ChLh4PyeNncpR+d42iRywM7n+jGzTazy8VwIqiEp5m96bxpwdK4WFor+aodo96UyH6DdtvUJuRPHq
	dWEjI4kHnjzvAscm0UWOiO7mOtBxgHETOFQ0zSaN7EMn6K2OWqj1OhPzFwzwgCvUpsf2fexNGNQJY
	sSX5U9qA==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-0i
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 32/45] wireguard: Add routes for other than any addresses
Date: Fri, 11 Jul 2025 17:27:23 +0300
Message-Id: <20250711142736.1757060-33-jussi.laakkonen@jolla.com>
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

This adds a use of the vpn_provider_append_route_complete() to setup the
routes to the AllowedIP networks after WireGuard has connected. Peer
endpoint is used as a gateway and routes to other address family types
are ignored, as well as the any routes, which are setup by
libwireguard.c. This follows then the approach used in wg-quick.

When the endpoint is resolved to a new address the old routes are
removed and new ones are added. This is done without a delay, at startup
there is ROUTE_SETUP_TIMEOUT delay (200ms) to make sure setup is complete.

TODO: do not ignore routes if there is IP address set for the families.
---
 vpn/plugins/wireguard.c | 149 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 139 insertions(+), 10 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 07719273..a22402c8 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -53,6 +53,7 @@
 
 #define DNS_RERESOLVE_TIMEOUT 20
 #define DNS_RERESOLVE_ERROR_LIMIT 5
+#define ROUTE_SETUP_TIMEOUT 200 // ms
 #define ARRAY_SIZE(a) (sizeof(a)/sizeof(a[0]))
 
 struct wireguard_info {
@@ -66,6 +67,7 @@ struct wireguard_info {
 	guint resolv_id;
 	guint remove_resolv_id;
 	guint dying_id;
+	guint route_setup_id;
 };
 
 struct sockaddr_u {
@@ -262,6 +264,25 @@ struct wg_ipaddresses {
 	struct connman_ipaddress *ipaddress_ipv6;
 };
 
+static char *cidr_to_netmask(int family, unsigned char cidr)
+{
+	switch (family) {
+	case AF_INET:
+		return g_strdup_printf("%d.%d.%d.%d",
+				((0xffffffff << (32 - cidr)) >> 24) & 0xff,
+				((0xffffffff << (32 - cidr)) >> 16) & 0xff,
+				((0xffffffff << (32 - cidr)) >> 8) & 0xff,
+				((0xffffffff << (32 - cidr)) >> 0) & 0xff);
+
+	case AF_INET6:
+		return g_strdup_printf("%u", cidr);
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 static int parse_addresses(const char *address, const char *gateway,
 		struct wg_ipaddresses *ipaddresses)
 {
@@ -303,12 +324,7 @@ static int parse_addresses(const char *address, const char *gateway,
 			}
 
 			family = AF_INET;
-			netmask = g_strdup_printf("%d.%d.%d.%d",
-				((0xffffffff << (32 - prefixlen)) >> 24) & 0xff,
-				((0xffffffff << (32 - prefixlen)) >> 16) & 0xff,
-				((0xffffffff << (32 - prefixlen)) >> 8) & 0xff,
-				((0xffffffff << (32 - prefixlen)) >> 0) & 0xff);
-
+			netmask = cidr_to_netmask(family, prefixlen);
 			ipaddress = connman_ipaddress_alloc(family);
 			err = connman_ipaddress_set_ipv4(ipaddress, tokens[0],
 							netmask, gateway);
@@ -401,6 +417,7 @@ static bool sockaddr_cmp_addr(struct sockaddr_u *a, struct sockaddr_u *b)
 }
 
 static void run_dns_reresolve(struct wireguard_info *info);
+static void run_route_setup(struct wireguard_info *info, guint timeout);
 
 static void remove_resolv(struct wireguard_info *info)
 {
@@ -524,6 +541,13 @@ static void resolve_endpoint_cb(GResolvResultStatus status,
 			info->device.name);
 
 	run_dns_reresolve(info);
+
+	/*
+	 * Endpoint has changed and only one peer is used -> all old routes
+	 * are invalid. Redo them without delay.
+	 */
+	vpn_provider_delete_all_routes(info->provider);
+	run_route_setup(info, 0);
 }
 
 static int disconnect(struct vpn_provider *provider, int error);
@@ -562,16 +586,107 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 	return G_SOURCE_REMOVE;
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
+static gboolean wg_route_setup_cb(gpointer user_data)
+{
+	struct wireguard_info *info = user_data;
+	struct wg_allowedip *allowedip;
+	char addr[INET6_ADDRSTRLEN] = { 0 };
+	char endpoint[INET6_ADDRSTRLEN] = { 0 };
+	char *netmask;
+	int family;
+	unsigned long idx = 0;
+
+	info->route_setup_id = 0;
+
+	family = info->peer.endpoint.addr.sa_family;
+
+	if (!endpoint_to_str(&info->peer, endpoint, INET6_ADDRSTRLEN)) {
+		DBG("Faulty endpoint set, use endpoint_fqdn");
+		memcpy(&endpoint, info->endpoint_fqdn, INET6_ADDRSTRLEN);
+		family = connman_inet_check_ipaddress(info->endpoint_fqdn);
+	}
+
+	wg_for_each_allowedip(&info->peer, allowedip) {
+		// TODO: search peers when multiple peers are supported
+		if (allowedip->family != family) {
+			DBG("Ignoring AllowedIP with different family as host");
+			continue;
+		}
+
+		memset(&addr, 0, INET6_ADDRSTRLEN);
+
+		switch (allowedip->family) {
+		case AF_INET:
+			if (!inet_ntop(allowedip->family, &allowedip->ip4, addr,
+							INET6_ADDRSTRLEN)) {
+				DBG("ignore invalid IPv4 address");
+				continue;
+			}
+
+			break;
+		case AF_INET6:
+			if (!inet_ntop(allowedip->family, &allowedip->ip6, addr,
+							INET6_ADDRSTRLEN)) {
+				DBG("ignore invalid IPv6 address");
+				continue;
+			}
+
+			break;
+		default:
+			DBG("ignore invalid IP family");
+			continue;
+		}
+
+		if (connman_inet_is_any_addr(addr, allowedip->family)) {
+			DBG("ignore any addr %s", addr);
+			continue;
+		}
+
+		netmask = cidr_to_netmask(allowedip->family, allowedip->cidr);
+
+		vpn_provider_append_route_complete(info->provider, idx,
+						allowedip->family, addr,
+						netmask, endpoint);
+
+		g_free(netmask);
+		++idx;
+	}
+
+	return G_SOURCE_REMOVE;
+}
+
 static void run_dns_reresolve(struct wireguard_info *info)
 {
 	if (info->reresolve_id)
 		g_source_remove(info->reresolve_id);
 
+	info->reresolve_id = 0;
+
 	if (vpn_provider_get_connection_errors(info->provider) >=
 						DNS_RERESOLVE_ERROR_LIMIT) {
 		connman_warn("reresolve error limit reached");
 		disconnect(info->provider, -ENONET);
-		info->reresolve_id = 0;
 		return;
 	}
 
@@ -579,6 +694,14 @@ static void run_dns_reresolve(struct wireguard_info *info)
 						wg_dns_reresolve_cb, info);
 }
 
+static void run_route_setup(struct wireguard_info *info, guint timeout)
+{
+	if (info->route_setup_id)
+		g_source_remove(info->route_setup_id);
+
+	info->route_setup_id = g_timeout_add(timeout, wg_route_setup_cb, info);
+}
+
 static int wg_connect(struct vpn_provider *provider,
 			struct connman_task *task, const char *if_name,
 			vpn_provider_connect_cb_t cb,
@@ -660,6 +783,7 @@ static int wg_connect(struct vpn_provider *provider,
 	vpn_provider_set_boolean(provider, "SplitRouting", do_split_routing,
 							false);
 
+
 	option = vpn_provider_get_string(provider,
 					"WireGuard.PersistentKeepalive");
 	if (option) {
@@ -739,8 +863,10 @@ done:
 	connman_ipaddress_free(ipaddresses.ipaddress_ipv4);
 	connman_ipaddress_free(ipaddresses.ipaddress_ipv6);
 
-	if (!err)
+	if (!err) {
 		run_dns_reresolve(info);
+		run_route_setup(info, ROUTE_SETUP_TIMEOUT);
+	}
 
 	return err;
 
@@ -795,9 +921,12 @@ static int disconnect(struct vpn_provider *provider, int err)
 	if (info->dying_id)
 		return -EALREADY;
 
-	if (info->reresolve_id > 0)
+	if (info->reresolve_id)
 		g_source_remove(info->reresolve_id);
 
+	if (info->route_setup_id)
+		g_source_remove(info->route_setup_id);
+
 	if (info->resolv || info->resolv_id)
 		remove_resolv(info);
 
@@ -871,7 +1000,7 @@ static struct vpn_driver vpn_driver = {
 	.disconnect	= wg_disconnect,
 	.save		= wg_save,
 	.error_code	= wg_error_code,
-	.uses_vpn_agent = wg_uses_vpn_agent
+	.uses_vpn_agent	= wg_uses_vpn_agent
 };
 
 static int wg_init(void)
-- 
2.39.5

