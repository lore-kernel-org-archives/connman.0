Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7612309B9
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098981; cv=none; b=jt6aUp7a/xlPbnR5G2uva580R4AJ9oXdlf0zbLVI4tneyTbuA9CQjDxRhiL/4qF7uV5u3RQC3/y3mcidHUWdwvemv43OYjqLP4TDQa60SSZlmXr13u1XBCrGorsJAFsZxyUZMc5Hb1nwz4vFRYwxRVUkvAOe4taX9LMw2HZ+LBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098981; c=relaxed/simple;
	bh=ypLwxEPPn9CDih2PM8139R4NqSSqK63Dj8DNJFhaS7E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXdhVx2E0/opX6btCNGhCzXnZvONA56TFwCeXSLVJrnzlyQiRJjX4hvZ3C+vM9vUf/E/3kr95PVY9wxR6n7dM2ae13Jp67cq+SISYiHdUQAYY3YLgCAqx+znnT8+FwYtk5KagP5cGzoz3Ng9LoWNTNrdAV7HXvbQUKqKI66OOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=w9YzVEXa; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="w9YzVEXa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5vL8IGUKjKDjbwodcW55Dn/X9WH1RQsyfJHsAB+P8KE=; b=w9YzVEXae23aX7RLEworQQl8nw
	xv+dN07C50Jmp71qbU9sl78QWpaib6m8ImmAHFieUeV2BLzX234HstGmos0MAEHyQpwYzSfAAAhln
	/4R3Ceefpn3ligW5Ln3lJjN5XY4n4TyvioAuHzU2EsqLcaDGeM6a+nHdte08kThdFaYBQif5q2Orq
	UsP/S2bmIe6DlyPIFuovOKdMY197Q3lEqjflW/tZnj2GXytnlHDL7vcnizPmIMc6LYxlT8pWN9gys
	BG1CIEaXF4JllPmkuS4O1zDAA2ZTPv6zaf5hD77r0twJXpXCVKK1mY9QtoAzwQiOKmxIpGF8UAaoO
	VPEpHrgw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-08
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 24/42] vpn: Add support for dual-IP VPNs
Date: Wed, 13 Aug 2025 18:01:56 +0300
Message-Id: <20250813150214.189282-25-jussi.laakkonen@jolla.com>
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

Information sent by vpn-provider.c on dual-IP VPNs must be handled also
here properly. Adapt to using modified connman_provider_get_family().

Use with the modified connman_provider_get_family() to query which
families are supported to clean up the code.
---
 plugins/vpn.c | 126 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 42 deletions(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index c0739fc1..97ca72c5 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -1554,57 +1554,94 @@ static void set_route(struct connection_data *data, struct vpn_route *route)
 static int save_route(GHashTable *routes, int family, const char *network,
 			const char *netmask, const char *gateway);
 
-static int add_network_route(struct connection_data *data)
+
+static int set_network_route(struct connection_data *data, struct vpn_route *rt)
 {
-	struct vpn_route rt = { 0, };
 	int err;
 
-	if (!data)
-		return -EINVAL;
-
-	rt.family = connman_provider_get_family(data->provider);
-	switch (rt.family) {
-	case PF_INET:
-		err = connman_inet_get_route_addresses(data->index,
-					&rt.network, &rt.netmask, &rt.gateway);
-		break;
-	case PF_INET6:
-		err = connman_inet_ipv6_get_route_addresses(data->index,
-					&rt.network, &rt.netmask, &rt.gateway);
-		break;
-	default:
-		connman_error("invalid protocol family %d", rt.family);
+	if (!data || !rt)
 		return -EINVAL;
-	}
 
 	DBG("network %s gateway %s netmask %s for provider %p",
-						rt.network, rt.gateway, rt.netmask,
-						data->provider);
+					rt->network, rt->gateway, rt->netmask,
+					data->provider);
 
-	if (err) {
-		connman_error("cannot get network/gateway/netmask for %p",
-							data->provider);
-		goto out;
-	}
-
-	err = save_route(data->server_routes, rt.family, rt.network, rt.netmask,
-				rt.gateway);
+	err = save_route(data->server_routes, rt->family, rt->network,
+						rt->netmask, rt->gateway);
 	if (err) {
 		connman_warn("failed to add network route for provider"
 					"%p", data->provider);
-		goto out;
+		return err;
 	}
 
-	set_route(data, &rt);
-
-out:
-	g_free(rt.network);
-	g_free(rt.netmask);
-	g_free(rt.gateway);
+	set_route(data, rt);
 
 	return 0;
 }
 
+static void free_network_route(struct vpn_route *rt)
+{
+	g_free(rt->network);
+	rt->network = NULL;
+
+	g_free(rt->netmask);
+	rt->network = NULL;
+
+	g_free(rt->gateway);
+	rt->network = NULL;
+}
+
+static int add_network_route(struct connection_data *data)
+{
+	struct vpn_route rt = { 0, };
+	int err = 0;
+
+	if (!data)
+		return -EINVAL;
+
+	if (connman_provider_get_family(data->provider, AF_INET)) {
+		rt.family = AF_INET;
+		err = connman_inet_get_route_addresses(data->index,
+					&rt.network, &rt.netmask,
+					&rt.gateway);
+		if (err) {
+			connman_error("cannot get IPv4 network/gateway/netmask "
+						"for %p/%s", data->provider,
+						data->ident);
+		} else {
+			err = set_network_route(data, &rt);
+			if (err)
+				connman_error("cannot set IPv4 network route "
+						"for %p/%s", data->provider,
+						data->ident);
+		}
+
+		free_network_route(&rt);
+	}
+
+	if (connman_provider_get_family(data->provider, AF_INET6)) {
+		rt.family = AF_INET6;
+		err = connman_inet_ipv6_get_route_addresses(data->index,
+					&rt.network, &rt.netmask,
+					&rt.gateway);
+		if (err) {
+			connman_error("cannot get IPv6 network/gateway/netmask "
+						"for %p/%s", data->provider,
+						data->ident);
+		} else {
+			err = set_network_route(data, &rt);
+			if (err)
+				connman_error("cannot set IPv6 network route "
+						"for %p/%s", data->provider,
+						data->ident);
+		}
+
+		free_network_route(&rt);
+	}
+
+	return err;
+}
+
 static bool is_valid_route_table(struct connman_provider *provider,
 							GHashTable *table)
 {
@@ -1667,6 +1704,14 @@ static bool check_routes(struct connman_provider *provider)
 	return false;
 }
 
+static void set_default_route(struct connection_data *data, int family,
+							char *ipaddr_any)
+{
+	struct vpn_route def_route = {family, ipaddr_any, ipaddr_any, NULL};
+
+	set_route(data, &def_route);
+}
+
 static int set_routes(struct connman_provider *provider,
 				enum connman_provider_route_type type)
 {
@@ -1699,13 +1744,10 @@ static int set_routes(struct connman_provider *provider,
 	/* If non-split routed VPN does not have a default route, add it */
 	if (!connman_provider_is_split_routing(provider) &&
 						!data->default_route_set) {
-		int family = connman_provider_get_family(provider);
-		const char *ipaddr_any = family == AF_INET6 ?
-							"::" : "0.0.0.0";
-		struct vpn_route def_route = {family, (char*) ipaddr_any,
-						(char*) ipaddr_any, NULL};
-
-		set_route(data, &def_route);
+		if (connman_provider_get_family(provider, AF_INET))
+			set_default_route(data, AF_INET, "0.0.0.0");
+		if (connman_provider_get_family(provider, AF_INET6))
+			set_default_route(data, AF_INET6, "::");
 	}
 
 	/* Split routed VPN must have at least one route to the network */
-- 
2.39.5

