Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3F2E7BB4
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244078; cv=none; b=jhskGh5nRN9zubC74uLDT7hJM5ejtBoALdzkoPaDaZ1s8lz0aGDqGSczpmrNKk64PNEF9PB01g0OjoGY0Wun+YCwq9PDkYWVkH4fbIreJrvHIkzJjLcZ4ZUNnZIGxeB1eP3Lerop4WfxxL0Fg93qKLCrihOpXvljzo35oSGPtDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244078; c=relaxed/simple;
	bh=RQZ3EfTsn2nc9Ld5iHLKfXe0ruK6rRlGM3ZQCsZFvpI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzzYd601yxfKobntcZTuRbRrWwREMg4KS8Y3P98jMLGoCWH8kpSHSoj6lvX0dpZabozuuD58SwxOSn0MFz1fFZWty4re+BLMVrfN1BCLovVL6woDtp/wDKdm48wGr6/i9R6xraZeS6c3FyHvLwXUaztG6cIJiS4B0RsJW/plRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=QVOXAjXE; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="QVOXAjXE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=W32G/exbWG9CXWy1HG9fl7YxXAcfrfgqJEu8gp6bKXo=; b=QVOXAjXEUrH7Jpd6D7dIOFjMBv
	RfRNjw8IinIsX3/FpBhiHTo4f49/KuBm3xhKpzVRaAOAIn6aqXChGPD842lc6rmvDbc3ayHF+gUmM
	8Ch58LL7idr1vNEK1Tkx5oY5mI9rWl6dwsXLhqYEekUnABpz0TtE7kTD2ogB3jR0lC2O0nNcaZQHq
	guEKaxNAZ0lneI3VTbMSzch2qdOHn+X3+QcRv9c8/fZ04nsGXBpNw/QOo5Ad2Knr+Ax+KwPFykZjU
	edAY86mXAAfDTP1fnfqfC/v1CvepUFVO5XTbGTr2pGdeO2q92MmRL6h9rbz2sI91kC9cLYoaHBpZD
	g9hYIGTA==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-1t
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 18/45] wireguard: Use GResolv for DNS reresolve to avoid blocking
Date: Fri, 11 Jul 2025 17:27:09 +0300
Message-Id: <20250711142736.1757060-19-jussi.laakkonen@jolla.com>
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
 vpn/plugins/wireguard.c | 162 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 147 insertions(+), 15 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 2c5981f8..4a3d9ec7 100644
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
+		vpn_util_cancel_resolve(info->resolv, info->resolv_id);
+	}
+
+	info->resolv_id = 0;
+	info->remove_resolv_id = 0;
+
+	vpn_util_resolve_unref(info->resolv);
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
@@ -338,6 +420,39 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 			info->device.name);
 
 	run_dns_reresolve(info);
+}
+
+static gboolean wg_dns_reresolve_cb(gpointer user_data)
+{
+	struct wireguard_info *info = user_data;
+	int err;
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
+	info->resolv = vpn_util_resolve_new(0);
+	if (!info->resolv) {
+		connman_error("cannot create GResolv");
+		return G_SOURCE_REMOVE;
+	}
+
+	info->resolv_id = vpn_util_resolve_hostname(info->resolv,
+						info->endpoint_fqdn,
+						resolve_endpoint_cb, info);
+
+	err = vpn_util_get_resolve_error(info->resolv);
+	if (!info->resolv_id && err) {
+		connman_error("failed to start hostname lookup for %s, err %d",
+						info->endpoint_fqdn, err);
+		vpn_died(NULL, err, info->provider);
+	}
+
 	return G_SOURCE_REMOVE;
 }
 
@@ -346,6 +461,14 @@ static void run_dns_reresolve(struct wireguard_info *info)
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
@@ -446,6 +569,12 @@ static int wg_connect(struct vpn_provider *provider,
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
@@ -528,6 +657,9 @@ static void wg_disconnect(struct vpn_provider *provider)
 	if (info->reresolve_id > 0)
 		g_source_remove(info->reresolve_id);
 
+	if (info->resolv || info->resolv_id)
+		remove_resolv(info);
+
 	vpn_provider_set_plugin_data(provider, NULL);
 
 	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_DISCONNECT);
-- 
2.39.5

