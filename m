Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8AD2E7BBB
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=O+7+QeR7gom0+kCHEsmClJ/8nwYC5SmyMxjkKo9G7Hb38FLVmdIygQIG+E9V1V3gqrW8oXWpRMV+GF5sh4+vHGEmopq/yqy2N2LLvIH2aRJL4O8vsCULIUf5vIORtUFm0Wwmf9hTEHDProXjTuF86qgYl3I6orw4r28wX+GoFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=/2kLCFpc3H1XHRiABuzSvANGItgD8qtwfmP50FBVcGo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7aYNfBVlW5eyjD+ttHiIl2Nj/GH5Ixwe6OB9n1wS+kKWCwWQ3iT9F0pI0k+mRyZk32Roy7MH+RAY1zH/BuFjNF58kDlXb8Dn9d1J3enX52zsToTSxg9Bt8KbRghjjtWaX5V7lWFYjovfxUhMDIb2WXFvyHDW7hXtfUN3xCVJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=sE1Ksm/X; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="sE1Ksm/X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gJUWd6T5djqn9sbARkIMuKIyzJ2ZWqW+p+Sx3AWRJDA=; b=sE1Ksm/XEdy5CBBSalj8TkgeUR
	3KU0Md/8etkSJYeOJtkZhwtTKJhWLZJfvphG2o96jdYLwKTn6fjOQ6SSOSG4DCO9H5lxDkEfUkbkk
	svJ5uUvUt22tG2etXpMPLC7X0UlENUsMHSwJ9vlaOz+Df1/P/4NkQMpOis0Yf7FCijv5OhNtSxz8M
	s/dEuTs27N+icoCcc2V1NX4rkndwRPFcEjihJWFTXXyNWT0hQ6jX1EJ1UJS8SN6s9iP+vT9QoITwJ
	FlWp/Pp+zKPvs7UkEbb5drcLzs3Ygw6GP3w4v8mD49TOTa9rYsieqhApiHltinjAuChgCZWKwouM7
	X6CHktQg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-0Z
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 31/45] vpn-provider: Allow to add complete routes and to remove routes
Date: Fri, 11 Jul 2025 17:27:22 +0300
Message-Id: <20250711142736.1757060-32-jussi.laakkonen@jolla.com>
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

Adding functionality to add complete routes when all parameters are
known, like with WireGuard. Using the route_env_parse() cb in such case
is too complex and with daemonless VPNs the parameters can be added
once. Move the route lookup into its own function and follow coding
guidelines on memory handling.

Also allow to remove all or a single route from the hash table. In
WireGuard the endpoint may change and this is required for removing the
obsolete routes.
---
 vpn/vpn-provider.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 vpn/vpn-provider.h |  7 ++++++
 2 files changed, 61 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index ff81592c..7ec21b0b 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -3253,6 +3253,60 @@ int vpn_provider_append_route(struct vpn_provider *provider,
 	return 0;
 }
 
+int vpn_provider_append_route_complete(struct vpn_provider *provider,
+				unsigned long idx, int family,
+				const char *network, const char *netmask,
+				const char *gateway)
+{
+	struct vpn_route *route;
+
+	DBG("provider %p idx %lu family %d network %s netmask %s gateway %s",
+						provider, idx, family, network,
+						netmask, gateway);
+
+	if (!netmask || !gateway || !network)
+		return -EINVAL;
+
+	if (g_hash_table_lookup(provider->routes, GINT_TO_POINTER(idx)))
+		return -EALREADY;
+
+	route = g_new0(struct vpn_route, 1);
+	route->family = family;
+	route->network = g_strdup(network);
+	route->netmask = g_strdup(netmask);
+	route->gateway = g_strdup(gateway);
+
+	g_hash_table_replace(provider->routes, GINT_TO_POINTER(idx), route);
+	provider_schedule_changed(provider);
+
+	return 0;
+}
+
+void vpn_provider_delete_all_routes(struct vpn_provider *provider)
+{
+	DBG("provider %p", provider);
+;
+	if (!__vpn_provider_check_routes(provider))
+		return;
+
+	g_hash_table_remove_all(provider->routes);
+	provider_schedule_changed(provider);
+}
+
+int vpn_provider_delete_route(struct vpn_provider *provider,
+							unsigned long idx)
+{
+	if (!__vpn_provider_check_routes(provider))
+		return -ENOENT;
+
+	if (!g_hash_table_remove(provider->routes, GINT_TO_POINTER(idx)))
+		return -EINVAL;
+
+	provider_schedule_changed(provider);
+
+	return 0;
+}
+
 const char *vpn_provider_get_driver_name(struct vpn_provider *provider)
 {
 	if (!provider->driver)
diff --git a/vpn/vpn-provider.h b/vpn/vpn-provider.h
index 8a8b6bfd..c7487525 100644
--- a/vpn/vpn-provider.h
+++ b/vpn/vpn-provider.h
@@ -124,6 +124,13 @@ int vpn_provider_set_nameservers(struct vpn_provider *provider,
 					const char *nameservers);
 int vpn_provider_append_route(struct vpn_provider *provider,
 					const char *key, const char *value);
+int vpn_provider_append_route_complete(struct vpn_provider *provider,
+				unsigned long idx, int family,
+				const char *address, const char *netmask,
+				const char *gateway);
+void vpn_provider_delete_all_routes(struct vpn_provider *provider);
+int vpn_provider_delete_route(struct vpn_provider *provider,
+							unsigned long index);
 
 const char *vpn_provider_get_driver_name(struct vpn_provider *provider);
 const char *vpn_provider_get_save_group(struct vpn_provider *provider);
-- 
2.39.5

