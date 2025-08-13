Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59027F00A
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099625; cv=none; b=V/F3aI9ulBgJdhsQX/Q/Zk++lpax5fR1FFhOg5dvRQKPcQxe/yx7vI0zMeY29wwaYIgX38LJDLKJuhPl5qJKiHshsEY+yM0NS6dwqAAEuGMLrHlL/ukfMSA1AxpFYKn471GbCLJxzhUh1knKOzxjB0/YB7pdB7ERmGlgJrK2wwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099625; c=relaxed/simple;
	bh=ops3B1FOX2IeJkpw+Y90dzamV+ZPoXyCn1qWteOpcBU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IhW9HcdFnhTs6vhO4fkpfxUPh/p1h3Mvm08BCZpZ+ZlTUQnrYQPZScaqP+YyjfE+6ol6b2slQGZ82pHvnLBaiySDZMcYgSRYfkKnYbl6RevWkCa/PZGialex/1Vs+aZsi9MkJO+IXPRBQXcU18DEZd/DG1gggXuU5Z1etmRlLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=q4SpZHM+; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="q4SpZHM+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MBOKoISbIV8wwvbAXuk/Qt92kjy4+HDBpg14HMwKZPo=; b=q4SpZHM+JnO2govNknQq+bGm5X
	cney7m3PbjGg6EZF+fs78ZtywIJo0ZOAGtixAciS+ZMb8sBJ1t5U2Lq6j+bi2W3iOuUOjLV1/ZlE9
	kJV90irHdguJ8zbvQPUQP7tpf284JVmzTWUWcI0ujbalF1BoEoZO7ebn+g9Acswz6vIMmCpYbAy/M
	0VOksuQ2aoRgpX4y71dbKLT3bojJlCunJMWHCRS249hYufGsKk+H5Y6mmQC1V1oD3eWDGZq62XS1G
	6agtp9gljc052yA2Zbl3ZGgPwO0W8R2XJ0GnQ4/AligxgawDFV4ziD4NyWg3PNJkLef7wTRSkaVlO
	o7aOjGKw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-0z
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 30/42] wireguard: Add routes for other than any addresses
Date: Wed, 13 Aug 2025 18:02:02 +0300
Message-Id: <20250813150214.189282-31-jussi.laakkonen@jolla.com>
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

This adds a use of the vpn_provider_append_route_complete() to setup the
routes to the AllowedIP networks after WireGuard has connected. Peer
endpoint is used as a gateway and routes to other address family types
are ignored, as well as the any routes, which are setup by
libwireguard.c. This follows then the approach used in wg-quick.

When the endpoint is resolved to a new address the old routes are
removed and new ones are added. This is done without a delay, at startup
there is ROUTE_SETUP_TIMEOUT delay (200ms) to make sure setup is complete.
---
 vpn/plugins/wireguard.c | 147 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 9 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 271b57b2..92a538ea 100644
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
@@ -565,16 +589,107 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
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
 
@@ -582,6 +697,14 @@ static void run_dns_reresolve(struct wireguard_info *info)
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
@@ -663,6 +786,7 @@ static int wg_connect(struct vpn_provider *provider,
 	vpn_provider_set_boolean(provider, "SplitRouting", do_split_routing,
 							false);
 
+
 	option = vpn_provider_get_string(provider,
 					"WireGuard.PersistentKeepalive");
 	if (option) {
@@ -742,8 +866,10 @@ done:
 	connman_ipaddress_free(ipaddresses.ipaddress_ipv4);
 	connman_ipaddress_free(ipaddresses.ipaddress_ipv6);
 
-	if (!err)
+	if (!err) {
 		run_dns_reresolve(info);
+		run_route_setup(info, ROUTE_SETUP_TIMEOUT);
+	}
 
 	return err;
 
@@ -798,9 +924,12 @@ static int disconnect(struct vpn_provider *provider, int err)
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
 
-- 
2.39.5

