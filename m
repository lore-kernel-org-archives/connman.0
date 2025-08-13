Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20328000A
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100772; cv=none; b=knGEWFCjWyAXkfiw0z/uORrHgNAcYFvkfNVTFcqw48gD9dH91KzuDUIrsufmEaFSJDMfS3mDKTTSWJPiHNlAgraSRBz9xFBnS53Mg2ybyjbjm/pB6mwc3R17MedlhWW7H3ZOsrz9XU3fGM+NpInAX7wfru/zTr+D2MFPKqkeT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100772; c=relaxed/simple;
	bh=SWyf4pEEiH1L71Wo4DTpZKFjhjaPsWroleulbcoeM/Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btu1B4F6XH68+NTgATJVThIoyVWr6X5gXBOCiwRrOP14NOSngk3b500f6IJmSkERJQ0NNhiGruWpCKqGRnkRNf7n5gc8Yfuwz+dxVusQYMSQy7vl5IrmtYvplT/HTZaDy212iuHsbP+2gywNep9vXN378hOnAHlDTle37V+tChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=jV7MKc6Q; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="jV7MKc6Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=b8msAbY7J2TPTgZ+h+sMOLwIAVj1TJExPJWJiUDaVM4=; b=jV7MKc6QuTP5GOoiye66picomj
	zmlV0yTdcG5Et5Ru04Mlus3uV0stc1NPO3QcyI7hI7G68uqDl6GX8A4UTDiLWVMvnSi9dV2AjWAgT
	VW208VwtI8ooLeAbKOEEwGdNlWdReI3KdL1VZEkT8VCtscsZiy65Lr6WkolKwsO1x2AUud2ahHXam
	5Rfn3u6hlIcuO/D1+ksknfKva2DAP4Pio3hua1svZ65rupvC4Nc5IBsDNhWw+19XDWhjQ4Eny2TmR
	FtowlncoazmccbslxFuNIFmG8X1YNuPn6/dPdfJ28ZhW9S6XHbwtdT35N31Hmb7mwmo5OEidphv2+
	fvw36+aw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-0q
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 29/42] vpn-provider: Allow to add complete routes and to remove routes
Date: Wed, 13 Aug 2025 18:02:01 +0300
Message-Id: <20250813150214.189282-30-jussi.laakkonen@jolla.com>
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
index 0462978b..3942c937 100644
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

