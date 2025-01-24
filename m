Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924942248AE
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745173; cv=none; b=uk0W0xVMmppUIPpRwGftxmgkWEjPbcW4VI6bZ6hHm3P52U+cwyVoG3vZ9TmesMzPVVSRshbFoW+msiiSl/l+8N6m0BwQZc0m6mVYi+4P6bcIYGoTNDaBkVp17od2qt1TXFOrpFmpYi34NZMRp4hYW05q6ej4tFpztvplk0ZY8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745173; c=relaxed/simple;
	bh=cU3vzGLPRYLZU3B/BEHjuQTHeuhX/t/bRDfQgJXyvMo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sx4lRc+aii8MCQqGsukfPqrzmDkioFsCVi8LgfEnuJEs2J82gm/YqZhDLYZtfpm6DD2l88xUmq7SAOqO77uZUu+FJMpky6A+pxmdKFwch9ucnlKy3FHyFSE/QBzZS3uh/19DRs0lgDM3xfhgnQ2n8aQf01K5yOevWvrGpBIzCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=fNFwCzGi; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="fNFwCzGi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dJBCPRVmdT8RJE5QON5vewYXhbZN4G35qrBxido6ODE=; b=fNFwCzGih7PTVCS8TVxKesq3F6
	aTguJyTJlml4QAX+v+ayxQSKRGhXtkiFd2umZ0Nuv5AunAIggJTDDCe7o6C4U1jNmNTWOSfd7k8Zo
	r3YLY1r11a6in721a5Ej3jrBxDbKUHNq5sY0v+SA0JJ+F4LXVXyQbEFd29bj0U7A8rbZ6dwo58Rx1
	Yl24mM1ZZr0jYS60473wxjxwRKxkx3kANRlC5ZnnEMdlMPfBnjiyruUqXdsSgsv2I3NK0eg9azAnK
	ggCRW1DfhoOpSgDQVXRG1G9fHaEqvFtByrmgGKEvY7/5JAPoqtHe/WBwgJaJ8HmN7Z+TUxL98LWk0
	nOAi6KNQ==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtq-006LTc-2W
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:26 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 04/12] wireguard: Handle disconnect, error and network errors better
Date: Fri, 24 Jan 2025 20:59:08 +0200
Message-Id: <20250124185916.1546471-5-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Make the plugin to handle disconnect better by setting state, and
calling vpn_died() with the exit code to make the states indicated
properly to higher layers. This currently handles the ENODEV as an error
code transformation to 0, since it can happen when the device is not up
yet.

When the parameters are wrong use login failed error with ECONNABORTED
to indicate that autoconnect should be stopped on this VPN. It also,
with other changes to vpn.c, makes it possible to keep the error for
higher layers.

Add a limit for the DNS reresolve attempts that makes WireGuard die
after the limit is reached. This is for the cases when the IP
configuration is wrong on the client and after connecting the endpoint
cannot be resolved, and should be indicated as an error to higher
layers. Also, in case the endpoint cannot be resolved, because of
getaddrinfo()'s lengthy timeout vpnd becomes inoperable during that
period. It performs a bit better when the timeout is recreated after
every cb call, but not perfect. It should be running in a thread because
of this deadlock but this is the first step on improving this with
invalid configurations.
---
 vpn/plugins/wireguard.c | 115 +++++++++++++++++++++++++++++++---------
 1 file changed, 91 insertions(+), 24 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index de57b15f..2c5981f8 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -50,9 +50,11 @@
 #include "wireguard.h"
 
 #define DNS_RERESOLVE_TIMEOUT 20
+#define DNS_RERESOLVE_ERROR_LIMIT 5
 #define ARRAY_SIZE(a) (sizeof(a)/sizeof(a[0]))
 
 struct wireguard_info {
+	struct vpn_provider *provider;
 	struct wg_device device;
 	struct wg_peer peer;
 	char *endpoint_fqdn;
@@ -155,6 +157,7 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 	struct addrinfo hints;
 	struct addrinfo *result, *rp;
 	int sk;
+	int err;
 
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_family = AF_UNSPEC;
@@ -162,8 +165,9 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 	hints.ai_flags = 0;
 	hints.ai_protocol = 0;
 
-	if (getaddrinfo(host, port, &hints, &result) < 0) {
-		DBG("Failed to resolve host address");
+	err = getaddrinfo(host, port, &hints, &result);
+	if (err < 0) {
+		DBG("Failed to resolve host address: %s", gai_strerror(err));
 		return -EINVAL;
 	}
 
@@ -287,22 +291,38 @@ static bool sockaddr_cmp_addr(struct sockaddr_u *a, struct sockaddr_u *b)
 	return false;
 }
 
+static void run_dns_reresolve(struct wireguard_info *info);
+
 static gboolean wg_dns_reresolve_cb(gpointer user_data)
 {
 	struct wireguard_info *info = user_data;
 	struct sockaddr_u addr;
 	int err;
 
-	DBG("");
+	if (vpn_provider_get_connection_errors(info->provider) >=
+						DNS_RERESOLVE_ERROR_LIMIT) {
+		connman_warn("reresolve error limit reached");
+		vpn_died(NULL, -ENONET, info->provider);
+		return G_SOURCE_REMOVE;
+	}
 
+	/* If this fails after being connected it means configuration error
+	 * that results in connection errors. */
 	err = parse_endpoint(info->endpoint_fqdn,
 			info->port, &addr);
-	if (err)
-		return TRUE;
+	if (err) {
+		if (info->provider)
+			vpn_provider_add_error(info->provider,
+					VPN_PROVIDER_ERROR_CONNECT_FAILED);
+		run_dns_reresolve(info);
+		return G_SOURCE_REMOVE;
+	}
 
 	if (sockaddr_cmp_addr(&addr,
-			(struct sockaddr_u *)&info->peer.endpoint.addr))
-		return TRUE;
+			(struct sockaddr_u *)&info->peer.endpoint.addr)) {
+		run_dns_reresolve(info);
+		return G_SOURCE_REMOVE;
+	}
 
 	if (addr.sa.sa_family == AF_INET)
 		memcpy(&info->peer.endpoint.addr, &addr.sin,
@@ -317,7 +337,17 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 		DBG("Failed to update Endpoint address for WireGuard device %s",
 			info->device.name);
 
-	return TRUE;
+	run_dns_reresolve(info);
+	return G_SOURCE_REMOVE;
+}
+
+static void run_dns_reresolve(struct wireguard_info *info)
+{
+	if (info->reresolve_id)
+		g_source_remove(info->reresolve_id);
+
+	info->reresolve_id = g_timeout_add_seconds(DNS_RERESOLVE_TIMEOUT,
+						wg_dns_reresolve_cb, info);
 }
 
 static int wg_connect(struct vpn_provider *provider,
@@ -336,8 +366,12 @@ static int wg_connect(struct vpn_provider *provider,
 	info->device.flags = WGDEVICE_HAS_PRIVATE_KEY;
 	info->device.first_peer = &info->peer;
 	info->device.last_peer = &info->peer;
+	info->provider = vpn_provider_ref(provider);
+
+	DBG("");
 
 	vpn_provider_set_plugin_data(provider, info);
+	vpn_provider_set_auth_error_limit(provider, 1);
 
 	option = vpn_provider_get_string(provider, "WireGuard.ListenPort");
 	if (option) {
@@ -351,30 +385,30 @@ static int wg_connect(struct vpn_provider *provider,
 		err = vpn_provider_set_nameservers(provider, option);
 		if (err) {
 			DBG("Cannot set nameservers %s", option);
-			goto done;
+			goto error;
 		}
 	}
 
 	option = vpn_provider_get_string(provider, "WireGuard.PrivateKey");
 	if (!option) {
 		DBG("WireGuard.PrivateKey is missing");
-		goto done;
+		goto error;
 	}
 	err = parse_key(option, info->device.private_key);
 	if (err) {
 		DBG("Failed to parse private key");
-		goto done;
+		goto error;
 	}
 
 	option = vpn_provider_get_string(provider, "WireGuard.PublicKey");
 	if (!option) {
 		DBG("WireGuard.PublicKey is missing");
-		goto done;
+		goto error;
 	}
 	err = parse_key(option, info->peer.public_key);
 	if (err) {
 		DBG("Failed to parse public key");
-		goto done;
+		goto error;
 	}
 
 	option = vpn_provider_get_string(provider, "WireGuard.PresharedKey");
@@ -383,19 +417,19 @@ static int wg_connect(struct vpn_provider *provider,
 		err = parse_key(option, info->peer.preshared_key);
 		if (err) {
 			DBG("Failed to parse pre-shared key");
-			goto done;
+			goto error;
 		}
 	}
 
 	option = vpn_provider_get_string(provider, "WireGuard.AllowedIPs");
 	if (!option) {
 		DBG("WireGuard.AllowedIPs is missing");
-		goto done;
+		goto error;
 	}
 	err = parse_allowed_ips(option, &info->peer);
 	if (err) {
 		DBG("Failed to parse allowed IPs %s", option);
-		goto done;
+		goto error;
 	}
 
 	option = vpn_provider_get_string(provider,
@@ -415,8 +449,8 @@ static int wg_connect(struct vpn_provider *provider,
 	err = parse_endpoint(gateway, option,
 			(struct sockaddr_u *)&info->peer.endpoint.addr);
 	if (err) {
-		DBG("Failed to parse endpoint %s gateway %s", option, gateway);
-		goto done;
+		DBG("Failed to parse endpoint %s:%s", gateway, option);
+		goto error;
 	}
 
 	info->endpoint_fqdn = g_strdup(gateway);
@@ -425,12 +459,12 @@ static int wg_connect(struct vpn_provider *provider,
 	option = vpn_provider_get_string(provider, "WireGuard.Address");
 	if (!option) {
 		DBG("Missing WireGuard.Address configuration");
-		goto done;
+		goto error;
 	}
 	err = parse_address(option, gateway, &ipaddress);
 	if (err) {
 		DBG("Failed to parse address %s gateway %s", option, gateway);
-		goto done;
+		goto error;
 	}
 
 	ifname = get_ifname();
@@ -465,16 +499,27 @@ done:
 	connman_ipaddress_free(ipaddress);
 
 	if (!err)
-		info->reresolve_id =
-			g_timeout_add_seconds(DNS_RERESOLVE_TIMEOUT,
-						wg_dns_reresolve_cb, info);
+		run_dns_reresolve(info);
 
 	return err;
+
+error:
+	/*
+	 * TODO: add own category for parameter errors. This is to avoid
+	 * looping when parameters are incorrect and VPN stays in failed
+	 * state.
+	 */
+	vpn_provider_add_error(provider, VPN_PROVIDER_ERROR_LOGIN_FAILED);
+	err = -ECONNABORTED;
+	goto done;
 }
 
 static void wg_disconnect(struct vpn_provider *provider)
 {
 	struct wireguard_info *info;
+	int exit_code;
+
+	DBG("");
 
 	info = vpn_provider_get_plugin_data(provider);
 	if (!info)
@@ -485,11 +530,32 @@ static void wg_disconnect(struct vpn_provider *provider)
 
 	vpn_provider_set_plugin_data(provider, NULL);
 
-	wg_del_device(info->device.name);
+	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_DISCONNECT);
+
+	exit_code = wg_del_device(info->device.name);
 
+	vpn_provider_unref(info->provider);
 	g_free(info->endpoint_fqdn);
 	g_free(info->port);
 	g_free(info);
+
+	DBG("exiting with %d", exit_code);
+
+	/* No task for no daemon VPN - use VPN died with no task. */
+	vpn_died(NULL, exit_code, provider);
+}
+
+static int wg_error_code(struct vpn_provider *provider, int exit_code)
+{
+	DBG("exit_code %d", exit_code);
+
+	switch (exit_code) {
+	/* Failed to parse configuration -> wg_del_device() has no to delete */
+	case -ENODEV:
+		return 0;
+	default:
+		return exit_code;
+	}
 }
 
 static int wg_save(struct vpn_provider *provider, GKeyFile *keyfile)
@@ -518,6 +584,7 @@ static struct vpn_driver vpn_driver = {
 	.connect	= wg_connect,
 	.disconnect	= wg_disconnect,
 	.save		= wg_save,
+	.error_code	= wg_error_code
 };
 
 static int wg_init(void)
-- 
2.39.5

