Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE0B24290E
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100769; cv=none; b=VUNyc4DhVE6AAOVrXF9iEsPsKi4uKpH/iBJcGAjW3mvv0k5gKc5miVAURFWkeKrMEAEDbpa+yWEiRVAdbctuznoeBFa/73lQiM6neNEHwP5gws9ZDcCLF74/26Rp4YZbQLc7lnafJPI2xnS+pEufz/Xe4FYY/E4wy2bl2lEywxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100769; c=relaxed/simple;
	bh=V/769q8/JpOu7fk/MQMRci/2ucAoTuYegPlOu5KyzRA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3P/sjxrngyktLG+GeNdaVlPkFivG2vpwwcblYgC3+Q+eaZC+gmBGMtIWc+Ws/jdRbPP7+ypVynnzOu82sBCbS0/li5tKk406/5XP78tpKOYCw/taTbkmIDU+7agN4wck4uiyncl0FxxQuf/shmuunQwC0000yrFiD8eZGwl6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=glsAkCW6; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="glsAkCW6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lmwt4fFKyPLMVlg5ei9yyNNJ1Dpd/hTUUYSAwLwyKgk=; b=glsAkCW6i2z1PLkAFOFejBfKfP
	h7imq/VsQUeGK0l+pDgbi/EDd17/ICOOKV6xX1mTBHccNNGbOwH5rvvJXawnZkPBMPF2LWbk6gQzp
	hX2/kSVNENAX3LgpzSa2l6ESCg/fiM4HEJ+fl8ldI/ddE9LBlMHBphqAufPXbttiC1Eim4laIQxK7
	tS+NOkTx6B1/d0kHFhOhPMX1dl7+r88MxcQBhgJYQUE+ft1k2SseKapnNBiF7xVM/SsVO9qboSgNd
	rUUP/CZB8w3NOEid8vMl5Dvud8F1+z/IUVw3jfoNfwlZTc3ngvaMiwqG8nvAN33RFfKopn5AKSlYz
	gOhVnjtA==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-2D
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 16/42] wireguard: Use GResolv for DNS reresolve to avoid blocking
Date: Wed, 13 Aug 2025 18:01:48 +0300
Message-Id: <20250813150214.189282-17-jussi.laakkonen@jolla.com>
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

Change to use GResolv for the reresolve lookups as with broken
configuration getaddrinfo() will block vpnd for the time it timeouts in
a broken network. By using GResolv the resolving is done first and only
after it is succesful getaddrinfo() is called. This is not done for the
initial connection as the transport medium's network is used, thus it
has no possibility of such misconfiguration as the network is at least
in READY state.

Check the GResolv lookup error and if it is set kill the VPN. This is
because the set error is quite terminal on the connection, better just
to die.

Change reresolve_id to be guint as it should be and handle it properly.

Document why the remove_resolv_cb() and resolv id is used like it is.
---
 Makefile.plugins        |   4 +-
 vpn/plugins/wireguard.c | 165 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index bd5049ec..5392d37b 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -70,7 +70,7 @@ builtin_vpn_sources += src/shared/mnlg.h src/shared/mnlg.c \
 			vpn/plugins/wireguard.h vpn/plugins/libwireguard.c \
 			vpn/plugins/wireguard.c
 builtin_vpn_cflags += @LIBMNL_CFLAGS@ -DWIREGUARD=\"@WIREGUARD@\"
-builtin_vpn_libadd += @LIBMNL_LIBS@
+builtin_vpn_libadd += @LIBMNL_LIBS@ -lresolv
 else
 vpn_plugin_LTLIBRARIES += vpn/plugins/wireguard.la
 vpn_plugin_objects += $(plugins_wireguard_la_OBJECTS)
@@ -83,7 +83,7 @@ vpn_plugins_wireguard_la_CFLAGS = $(plugin_cflags) @LIBMNL_CFLAGS@ \
 					-DVPN_STATEDIR=\""$(vpn_statedir)"\" \
 					-DSCRIPTDIR=\""$(build_scriptdir)"\"
 vpn_plugins_wireguard_la_LDFLAGS = $(plugin_ldflags)
-vpn_plugins_wireguard_la_LIBADD = @LIBMNL_LIBS@
+vpn_plugins_wireguard_la_LIBADD = @LIBMNL_LIBS@ -lresolv
 endif
 endif
 
diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 2c5981f8..b7fa77b3 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -43,6 +43,8 @@
 #include <connman/setting.h>
 #include <connman/vpn-dbus.h>
 
+#include <gweb/gresolv.h>
+
 #include "../vpn-provider.h"
 #include "../vpn.h"
 
@@ -59,7 +61,10 @@ struct wireguard_info {
 	struct wg_peer peer;
 	char *endpoint_fqdn;
 	char *port;
-	int reresolve_id;
+	guint reresolve_id;
+	GResolv *resolv;
+	guint resolv_id;
+	guint remove_resolv_id;
 };
 
 struct sockaddr_u {
@@ -293,43 +298,120 @@ static bool sockaddr_cmp_addr(struct sockaddr_u *a, struct sockaddr_u *b)
 
 static void run_dns_reresolve(struct wireguard_info *info);
 
-static gboolean wg_dns_reresolve_cb(gpointer user_data)
+static void remove_resolv(struct wireguard_info *info)
+{
+	DBG("");
+
+	if (info->remove_resolv_id)
+		g_source_remove(info->remove_resolv_id);
+
+	if (info->resolv && info->resolv_id) {
+		DBG("cancel resolv lookup");
+		g_resolv_cancel_lookup(info->resolv, info->resolv_id);
+	}
+
+	info->resolv_id = 0;
+	info->remove_resolv_id = 0;
+
+	g_resolv_unref(info->resolv);
+	info->resolv = NULL;
+}
+
+static gboolean remove_resolv_cb(gpointer user_data)
+{
+	struct wireguard_info *info = user_data;
+
+	remove_resolv(info);
+
+	return G_SOURCE_REMOVE;
+}
+
+static void resolve_endpoint_cb(GResolvResultStatus status,
+					char **results, gpointer user_data)
 {
 	struct wireguard_info *info = user_data;
 	struct sockaddr_u addr;
 	int err;
 
-	if (vpn_provider_get_connection_errors(info->provider) >=
-						DNS_RERESOLVE_ERROR_LIMIT) {
-		connman_warn("reresolve error limit reached");
-		vpn_died(NULL, -ENONET, info->provider);
-		return G_SOURCE_REMOVE;
+	DBG("");
+
+	if (!info->resolv && info->resolv_id) {
+		DBG("resolv already removed");
+		return;
 	}
 
-	/* If this fails after being connected it means configuration error
-	 * that results in connection errors. */
-	err = parse_endpoint(info->endpoint_fqdn,
-			info->port, &addr);
+	/*
+	 * We cannot unref the resolver here as resolv struct is manipulated
+	 * by gresolv.c after we return from this callback. By clearing the
+	 * resolv_id no attempt to cancel the lookup that has been executed
+	 * here is done.
+	 */
+	info->remove_resolv_id = g_timeout_add(0, remove_resolv_cb, info);
+	info->resolv_id = 0;
+
+	switch (status) {
+	case G_RESOLV_RESULT_STATUS_SUCCESS:
+		if (!results || !g_strv_length(results)) {
+			DBG("no resolved results");
+			if (info->provider)
+				vpn_provider_add_error(info->provider,
+					VPN_PROVIDER_ERROR_CONNECT_FAILED);
+
+			return;
+		}
+
+		DBG("resolv success, parse endpoint");
+		break;
+	/* request timeouts or an server issue is not an error, try again */
+	case G_RESOLV_RESULT_STATUS_NO_RESPONSE:
+	case G_RESOLV_RESULT_STATUS_SERVER_FAILURE:
+		DBG("retry DNS reresolve");
+		if (info->provider)
+			vpn_provider_add_error(info->provider,
+					VPN_PROVIDER_ERROR_CONNECT_FAILED);
+
+		run_dns_reresolve(info);
+		return;
+	/* Consider these as non-continuable errors */
+	case G_RESOLV_RESULT_STATUS_ERROR:
+	case G_RESOLV_RESULT_STATUS_FORMAT_ERROR:
+	case G_RESOLV_RESULT_STATUS_NAME_ERROR:
+	case G_RESOLV_RESULT_STATUS_NOT_IMPLEMENTED:
+	case G_RESOLV_RESULT_STATUS_REFUSED:
+	case G_RESOLV_RESULT_STATUS_NO_ANSWER:
+		DBG("stop DNS reresolve");
+		if (info->provider)
+			vpn_provider_add_error(info->provider,
+					VPN_PROVIDER_ERROR_CONNECT_FAILED);
+
+		return;
+	}
+
+	/*
+	 * If this fails after being connected it means configuration error
+	 * that results in connection errors.
+	 */
+	err = parse_endpoint(info->endpoint_fqdn, info->port, &addr);
 	if (err) {
 		if (info->provider)
 			vpn_provider_add_error(info->provider,
 					VPN_PROVIDER_ERROR_CONNECT_FAILED);
 		run_dns_reresolve(info);
-		return G_SOURCE_REMOVE;
+		return;
 	}
 
 	if (sockaddr_cmp_addr(&addr,
 			(struct sockaddr_u *)&info->peer.endpoint.addr)) {
 		run_dns_reresolve(info);
-		return G_SOURCE_REMOVE;
+		return;
 	}
 
 	if (addr.sa.sa_family == AF_INET)
 		memcpy(&info->peer.endpoint.addr, &addr.sin,
-			sizeof(info->peer.endpoint.addr4));
+					sizeof(info->peer.endpoint.addr4));
 	else
 		memcpy(&info->peer.endpoint.addr, &addr.sin6,
-			sizeof(info->peer.endpoint.addr6));
+					sizeof(info->peer.endpoint.addr6));
 
 	DBG("Endpoint address has changed, udpate WireGuard device");
 	err = wg_set_device(&info->device);
@@ -338,6 +420,42 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 			info->device.name);
 
 	run_dns_reresolve(info);
+}
+
+static gboolean wg_dns_reresolve_cb(gpointer user_data)
+{
+	struct wireguard_info *info = user_data;
+	GError *error = NULL;
+
+	DBG("");
+
+	info->reresolve_id = 0;
+
+	if (info->resolv_id > 0) {
+		DBG("previous query was running, abort it");
+		remove_resolv(info);
+	}
+
+	info->resolv = g_resolv_new(0);
+	if (!info->resolv) {
+		connman_error("cannot create GResolv");
+		return G_SOURCE_REMOVE;
+	}
+
+	info->resolv_id = g_resolv_lookup_hostname(info->resolv,
+						info->endpoint_fqdn,
+						resolve_endpoint_cb, info,
+						&error);
+
+	if (!info->resolv_id && error) {
+		connman_error("failed to start hostname lookup for %s, err %d",
+						info->endpoint_fqdn,
+						error->code);
+		vpn_died(NULL, -EIO, info->provider);
+	}
+
+	g_clear_error(&error);
+
 	return G_SOURCE_REMOVE;
 }
 
@@ -346,6 +464,14 @@ static void run_dns_reresolve(struct wireguard_info *info)
 	if (info->reresolve_id)
 		g_source_remove(info->reresolve_id);
 
+	if (vpn_provider_get_connection_errors(info->provider) >=
+						DNS_RERESOLVE_ERROR_LIMIT) {
+		connman_warn("reresolve error limit reached");
+		vpn_died(NULL, -ENONET, info->provider);
+		info->reresolve_id = 0;
+		return;
+	}
+
 	info->reresolve_id = g_timeout_add_seconds(DNS_RERESOLVE_TIMEOUT,
 						wg_dns_reresolve_cb, info);
 }
@@ -446,6 +572,12 @@ static int wg_connect(struct vpn_provider *provider,
 		option = "51820";
 
 	gateway = vpn_provider_get_string(provider, "Host");
+	/*
+	 * Use the resolve timeout only with re-resolve. Here the network
+	 * is setup as the transport is used. In succeeding attempts resolving
+	 * is needed as it is done over potentially misconfigured WireGuard
+	 * connection that may end up blocking vpnd with getaddrinfo().
+	 */
 	err = parse_endpoint(gateway, option,
 			(struct sockaddr_u *)&info->peer.endpoint.addr);
 	if (err) {
@@ -528,6 +660,9 @@ static void wg_disconnect(struct vpn_provider *provider)
 	if (info->reresolve_id > 0)
 		g_source_remove(info->reresolve_id);
 
+	if (info->resolv || info->resolv_id)
+		remove_resolv(info);
+
 	vpn_provider_set_plugin_data(provider, NULL);
 
 	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_DISCONNECT);
-- 
2.39.5

