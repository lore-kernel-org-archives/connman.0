Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D72309B9
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098970; cv=none; b=ZjGBAQtdWMk2G0sIr0Xb1Qq0X1azKl/BbrmijUlYeaxLCopD49j3ix/RmQJl/3lggjeoV1Iq6OJiqHqruemxzPArrJ5RGT4jA1sDz05/4mg5dVq0ldsJIaQYgRJhNVltDsXljCuNYQ92jqVEjwgZTqGM29hhi5fAYqoEVvGXU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098970; c=relaxed/simple;
	bh=9kZTnKJ3pkvS2WwYp0oVwPFxy8DoO0FY/XM08UpruBI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTg9N6WbVgyY3qoA2Qp7DmPgxpOoWp45wvqWYAB8GQTS98iMrkHla1LLi9y91enFrNUYOeMuGGFnbasE2Z4jREckY/7oAmk5kRcQMwjqQR5ZRVmoapr/sQcv1SjPU6pHv/1Oc87oCQZ70NqIZ21G48H/6K6pI70hwNStGqSdZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=t6vYbp9v; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="t6vYbp9v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pAILlpLO/7VBiKJxkJP/iKun/G0fnhpost0uhaqEIZ0=; b=t6vYbp9vfZxQTbrnT0isjWEa5y
	m7icnFVsE0i6UcbASfmnArpWrSowFdd76lOlaXIAaETDDxXOF8a4LEe7As0RS89XfrVJ5X2CbYlQu
	X0WsxhnawqjQiSMdGJX14lRGK4HHbCuz/2guxbatZQLkj2v5CIuBPPx/626x0YYT/1T54kyHB8kzB
	we49dcmlR/yELLdaLh/Sv8whWplXEcXwXjXFkhdZm5raoUjlLDctTx6uF/Tu43gLt6qEVsBMqfoWE
	P8gzDLsxH8ni7XyAuikAgpsFSY0HZiZjTreJ4XOClG/cvv68EenMdkBEd4SJzHkDl7moRvuiNmeuu
	54HpuGiw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-2V
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 18/42] wireguard: Fix shutdown, ensure one exit and set no agent is used
Date: Wed, 13 Aug 2025 18:01:50 +0300
Message-Id: <20250813150214.189282-19-jussi.laakkonen@jolla.com>
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

Split disconnect into wg_disconnect() and disconnect(). Use disconnect()
to properly disconnect when error occurs with the appropriate error
code. Do the same in wg_disconnect() by using the error code to be from
device removal.

The shutdown process requires, that in order to do the proper transition
to IDLE, vpn_died() is to be called. This is normally called by the task
that has been killed so simulate this behavior in WireGuard by adding a
delayed call for that. It is to be executed only once as all the cleanup
is to be done at that last step. Use a delay of 50ms to simulate exit.

Add use of the VPN_FLAG_NO_AGENT to declare that WireGuard does not use
a VPN agent. This ensures that the state transition is done according
to state machine by __vpn_provider_connect().

Add separate create/free for struct wireguard_info for VPN consistency.
---
 vpn/plugins/wireguard.c | 103 ++++++++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 21 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index b7fa77b3..ee97f378 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -65,6 +65,7 @@ struct wireguard_info {
 	GResolv *resolv;
 	guint resolv_id;
 	guint remove_resolv_id;
+	guint dying_id;
 };
 
 struct sockaddr_u {
@@ -90,6 +91,31 @@ struct {
 	{"WireGuard.PersistentKeepalive", true}
 };
 
+static struct wireguard_info *create_private_data(struct vpn_provider *provider)
+{
+	struct wireguard_info *info;
+
+	info = g_malloc0(sizeof(struct wireguard_info));
+	info->peer.flags = WGPEER_HAS_PUBLIC_KEY | WGPEER_REPLACE_ALLOWEDIPS;
+	info->device.flags = WGDEVICE_HAS_PRIVATE_KEY;
+	info->device.first_peer = &info->peer;
+	info->device.last_peer = &info->peer;
+	info->provider = vpn_provider_ref(provider);
+
+	return info;
+}
+
+static void free_private_data(struct wireguard_info *info)
+{
+	if (vpn_provider_get_plugin_data(info->provider) == info)
+		vpn_provider_set_plugin_data(info->provider, NULL);
+
+	vpn_provider_unref(info->provider);
+	g_free(info->endpoint_fqdn);
+	g_free(info->port);
+	g_free(info);
+}
+
 static int parse_key(const char *str, wg_key key)
 {
 	unsigned char *buf;
@@ -422,6 +448,8 @@ static void resolve_endpoint_cb(GResolvResultStatus status,
 	run_dns_reresolve(info);
 }
 
+static int disconnect(struct vpn_provider *provider, int error);
+
 static gboolean wg_dns_reresolve_cb(gpointer user_data)
 {
 	struct wireguard_info *info = user_data;
@@ -451,7 +479,7 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 		connman_error("failed to start hostname lookup for %s, err %d",
 						info->endpoint_fqdn,
 						error->code);
-		vpn_died(NULL, -EIO, info->provider);
+		disconnect(info->provider, -EIO);
 	}
 
 	g_clear_error(&error);
@@ -467,7 +495,7 @@ static void run_dns_reresolve(struct wireguard_info *info)
 	if (vpn_provider_get_connection_errors(info->provider) >=
 						DNS_RERESOLVE_ERROR_LIMIT) {
 		connman_warn("reresolve error limit reached");
-		vpn_died(NULL, -ENONET, info->provider);
+		disconnect(info->provider, -ENONET);
 		info->reresolve_id = 0;
 		return;
 	}
@@ -487,12 +515,7 @@ static int wg_connect(struct vpn_provider *provider,
 	char *ifname;
 	int err = -EINVAL;
 
-	info = g_malloc0(sizeof(struct wireguard_info));
-	info->peer.flags = WGPEER_HAS_PUBLIC_KEY | WGPEER_REPLACE_ALLOWEDIPS;
-	info->device.flags = WGDEVICE_HAS_PRIVATE_KEY;
-	info->device.first_peer = &info->peer;
-	info->device.last_peer = &info->peer;
-	info->provider = vpn_provider_ref(provider);
+	info = create_private_data(provider);
 
 	DBG("");
 
@@ -646,8 +669,34 @@ error:
 	goto done;
 }
 
-static void wg_disconnect(struct vpn_provider *provider)
+struct wireguard_exit_data {
+	struct vpn_provider *provider;
+	int err;
+};
+
+static gboolean wg_died(gpointer user_data)
 {
+	struct wireguard_exit_data *data = user_data;
+	struct wireguard_info *info;
+
+	DBG("");
+
+	/* No task for no daemon VPN - use vpn_died() with no task. */
+	vpn_died(NULL, data->err, data->provider);
+
+	info = vpn_provider_get_plugin_data(data->provider);
+	if (info)
+		free_private_data(info);
+
+	g_free(data);
+
+	return G_SOURCE_REMOVE;
+}
+
+/* Allow to overrule the exit code for vpn_died */
+static int disconnect(struct vpn_provider *provider, int err)
+{
+	struct wireguard_exit_data *data;
 	struct wireguard_info *info;
 	int exit_code;
 
@@ -655,7 +704,10 @@ static void wg_disconnect(struct vpn_provider *provider)
 
 	info = vpn_provider_get_plugin_data(provider);
 	if (!info)
-		return;
+		return -ENODATA;
+
+	if (info->dying_id)
+		return -EALREADY;
 
 	if (info->reresolve_id > 0)
 		g_source_remove(info->reresolve_id);
@@ -663,21 +715,29 @@ static void wg_disconnect(struct vpn_provider *provider)
 	if (info->resolv || info->resolv_id)
 		remove_resolv(info);
 
-	vpn_provider_set_plugin_data(provider, NULL);
-
 	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_DISCONNECT);
 
 	exit_code = wg_del_device(info->device.name);
 
-	vpn_provider_unref(info->provider);
-	g_free(info->endpoint_fqdn);
-	g_free(info->port);
-	g_free(info);
+	/* Simulate a task-running VPN to issue vpn_died after exiting this */
+	data = g_malloc0(sizeof(struct wireguard_exit_data));
+	data->provider = provider;
+	data->err = err ? err : exit_code;
+
+	info->dying_id = g_timeout_add(50, wg_died, data);
+
+	return exit_code;
+}
+
+static void wg_disconnect(struct vpn_provider *provider)
+{
+	int exit_code;
+
+	DBG("");
 
-	DBG("exiting with %d", exit_code);
+	exit_code = disconnect(provider, 0);
 
-	/* No task for no daemon VPN - use VPN died with no task. */
-	vpn_died(NULL, exit_code, provider);
+	DBG("exited with %d", exit_code);
 }
 
 static int wg_error_code(struct vpn_provider *provider, int exit_code)
@@ -715,11 +775,12 @@ static int wg_save(struct vpn_provider *provider, GKeyFile *keyfile)
 }
 
 static struct vpn_driver vpn_driver = {
-	.flags		= VPN_FLAG_NO_TUN | VPN_FLAG_NO_DAEMON,
+	.flags		= VPN_FLAG_NO_TUN | VPN_FLAG_NO_DAEMON |
+							VPN_FLAG_NO_AGENT,
 	.connect	= wg_connect,
 	.disconnect	= wg_disconnect,
 	.save		= wg_save,
-	.error_code	= wg_error_code
+	.error_code	= wg_error_code,
 };
 
 static int wg_init(void)
-- 
2.39.5

