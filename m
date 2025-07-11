Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C42E7BBF
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=mpdZ9EmsV83Owswk8OIPCIi74JybF4eT6SDL3vT3ILUiDY6ok+KsbLU1h3IMOy4wDmMg3LXazGq+fjQfmzd4+iL2FSRmHCXLt4Q5HnvyCXYkhR5XIPhmIU/6VGeW+/Y+XPZ4m+x8+B0Jm1bglZB5Wi8MxXefHktMuCMpqKxPtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=o1V52WUckd36yrGJ6+hThZZZxt6Lu0qW/cjFUrBNNEs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6yhsxWDZLM1zUHgwuW4pwg3rILUUUS9uFuJHR4rtUsfYBrHrCrQ3eRrfdLnJUt34LYK+fns/1LJdaukMoBfa+t6iOIn6mmglBob7a5CJ4wQnotbHXl9iTnQQfzZztauWZ5ItpdeoqH8+SR95E9ux2kHrKEO3sdWMs0o8gDUh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=AIWvs8YZ; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="AIWvs8YZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ja7IVY0Iekdv80716AanQTDirfwOm35QFRlrA2bD3LA=; b=AIWvs8YZBDZ1nX8YZVzIVTuXlP
	WxgOuoj4+tsnWSVmIVdu+KroqFGPm6wD7L06SgzODCl4Mkl/lSX45VEBkVpbo9L+iOscpS8OC27Re
	B/c8rv2mTtkHg1gD02ASt1OpEQEyO8rnXumSJi9h4jkHGsHpnnDD09O7yjfI89dnDCRDxjvcYcrUL
	eobVUuoGe/c1POkStQuya3hhs5cjgs7lE9fLLKVi+wfcCUkjbqMg7JDsnSuV34Me9XzEZ8TZEuQVh
	o7Vy2oZplslmoPYb4ZmhFYkr2aLqiDjQJrTtRVyneBhI51cSLYzq+JJUlTPsyeP2Re0so+1WhzFWR
	24xn4cPw==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-32
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 26/45] vpn: Add support for dual-IP VPNs
Date: Fri, 11 Jul 2025 17:27:17 +0300
Message-Id: <20250711142736.1757060-27-jussi.laakkonen@jolla.com>
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

Information sent by vpn-provider.c on dual-IP VPNs must be handled also
here properly. Adapt to using modified connman_provider_get_family().

Use with the modified connman_provider_get_family() to query which
families are supported to clean up the code.
---
 plugins/vpn.c | 126 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 42 deletions(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index d683c67d..46b3a0fb 100644
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

