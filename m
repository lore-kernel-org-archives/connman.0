Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241F21ADAC
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745173; cv=none; b=I9ORG7D3ytO2hY35tf12mvOe40C7Fmd+PdRKIZA+catt1G499wfk/WPHSHXSi7HCAWQ+LkBELdmms1DBNthL6pW/nq2JdFMfz9kRb10IvPGspu4f4daZpBi++N3JcsdMJwD+DzANS15fG4dmGMjF38O/aFfoiVDoJe3oOe3zV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745173; c=relaxed/simple;
	bh=ot0RsAa02vUfEh34alkEJaL9IXmt+/9VBHZsstHT8sg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtURNKDViY2ULGPhyWGc7WX0U1aw//Sla5hoOA0xxQjH27jXDPMdfo3CLt7f6e9y0p/bXDKcdr0BQ9w4gv5mKxQ6RkwXjsDiypJcxotUfMLe10OAycYqJ1GnlVWVTa9xs7xQJaIuXTl23UaZBCKz2sslHRXs53AU2hEIBBysyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=fN/5wgbT; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="fN/5wgbT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vk3YYEKMMkLnm+DVo5EU7+ayAx3M0sNBT6PfSuGpQqs=; b=fN/5wgbTGUXAIuIOv0Bci+a1oZ
	S99QWxkr2CQ0fOV+VpJGeecxzFhLMuXHwrlFhKhEObz9NjwrQEKxM5osqLiwTgzPAkau3aUbz/15Q
	n/wWGFzxQISmIw51aupcEKz0mq093dbHLasc7DDe3f32b63w+iB/rsdzHu4NxmgH7QzWy7TeVusEO
	SWviG6CeSfKA6ID5HnVT//g/po74/Z6fr18Yad+d1kTaCPPRWG2mVOjBf0pFaAsrcwIpyW5JuXeYl
	+B54bhE+LgrlCAUvIY6cOrnymOM4LSbzNR9A5USZcgwdK5PyPnb/rsZ4YDWuWQxdQoNTiX7mlZYIA
	Pv/ZXGXA==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtq-006LTc-2M
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:26 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 03/12] vpn: Fix VPN_FLAG_NO_DAEMON use in error cases
Date: Fri, 24 Jan 2025 20:59:07 +0200
Message-Id: <20250124185916.1546471-4-jussi.laakkonen@jolla.com>
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

The VPNs that have no daemon, WireGuard, should not be called to
disconnect twice because in error situations the change of state from
error case is overridden. This makes it impossible to track the state
via an UI that relies on state notifications and uses autoconnect to
toggle active VPN(s).

Make vpn_died VPN_FLAG_NO_DAEMON friendly that can be called also by the
VPNs without a task. This makes it possible to use vpn_died in WireGuard
as final call to make state transitions complete.

Make the state transitions of VPN_FLAG_NO_DAEMON to use the
VPN_STATE_ASSOCIATION properly. This is the initial state when
connecting, and the VPN_STATE_CONNECT is set by the
update_provider_state() when driver replies that connection is ok.

Also cleanup some code to use the same base more.
---
 vpn/plugins/vpn.c | 57 ++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index cb0d304b..d963b985 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -90,7 +90,13 @@ static int stop_vpn(struct vpn_provider *provider)
 
 	if (vpn_driver_data && vpn_driver_data->vpn_driver &&
 			vpn_driver_data->vpn_driver->flags & VPN_FLAG_NO_TUN) {
-		vpn_driver_data->vpn_driver->disconnect(data->provider);
+		/*
+		 * Disconnect only VPNs with daemon, otherwise in error return
+		 * there is a double free with vpn_died() or the failure state
+		 * is overridden by changes made by disconnect to state.
+		 */
+		if (!(vpn_driver_data->vpn_driver->flags & VPN_FLAG_NO_DAEMON))
+			vpn_driver_data->vpn_driver->disconnect(data->provider);
 		return 0;
 	}
 
@@ -130,16 +136,27 @@ void vpn_died(struct connman_task *task, int exit_code, void *user_data)
 {
 	struct vpn_provider *provider = user_data;
 	struct vpn_data *data = vpn_provider_get_data(provider);
+	struct vpn_driver_data *vpn_data = NULL;
+	const char *name;
 	int state = VPN_STATE_FAILURE;
 	enum vpn_provider_error ret;
+	bool no_daemon = false;
+
+	name = vpn_provider_get_driver_name(provider);
+	if (name) {
+		vpn_data = g_hash_table_lookup(driver_hash, name);
+		if (vpn_data && vpn_data->vpn_driver)
+			no_daemon = vpn_data->vpn_driver->flags &
+							VPN_FLAG_NO_DAEMON;
+	}
 
-	DBG("provider %p data %p", provider, data);
+	DBG("provider %p data %p no_daemon %d", provider, data, no_daemon);
 
 	if (!data)
 		goto vpn_exit;
 
 	/* The task may die after we have already started the new one */
-	if (data->task != task)
+	if (!no_daemon && data->task != task)
 		goto done;
 
 	state = data->state;
@@ -155,15 +172,7 @@ void vpn_died(struct connman_task *task, int exit_code, void *user_data)
 
 vpn_exit:
 	if (state != VPN_STATE_READY && state != VPN_STATE_DISCONNECT) {
-		const char *name;
-		struct vpn_driver_data *vpn_data = NULL;
-
-		name = vpn_provider_get_driver_name(provider);
-		if (name)
-			vpn_data = g_hash_table_lookup(driver_hash, name);
-
-		if (vpn_data &&
-				vpn_data->vpn_driver->error_code)
+		if (vpn_data && vpn_data->vpn_driver->error_code)
 			ret = vpn_data->vpn_driver->error_code(provider,
 					exit_code);
 		else
@@ -182,7 +191,8 @@ vpn_exit:
 	}
 
 done:
-	connman_task_destroy(task);
+	if (!no_daemon)
+		connman_task_destroy(task);
 }
 
 int vpn_set_ifname(struct vpn_provider *provider, const char *ifname)
@@ -524,6 +534,8 @@ static gboolean update_provider_state(gpointer data)
 	vpn_data->watch = vpn_rtnl_add_newlink_watch(index,
 						vpn_newlink, provider);
 	connman_inet_ifup(index);
+	vpn_data->state = VPN_STATE_CONNECT;
+	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_CONNECT);
 
 	return FALSE;
 }
@@ -598,18 +610,10 @@ static int vpn_connect(struct vpn_provider *provider,
 
 		ret = vpn_driver_data->vpn_driver->connect(provider,
 					NULL, NULL, cb, dbus_sender, user_data);
-		if (ret) {
-			stop_vpn(provider);
-			goto exist_err;
-		}
+		if (!ret)
+			g_timeout_add(1, update_provider_state, provider);
 
-		DBG("%s started with dev %s",
-			vpn_driver_data->provider_driver.name, data->if_name);
-
-		data->state = VPN_STATE_CONNECT;
-
-		g_timeout_add(1, update_provider_state, provider);
-		return -EINPROGRESS;
+		goto done;
 	}
 
 	vpn_plugin_data =
@@ -635,9 +639,12 @@ static int vpn_connect(struct vpn_provider *provider,
 	ret = vpn_driver_data->vpn_driver->connect(provider, data->task,
 						data->if_name, cb, dbus_sender,
 						user_data);
+
+done:
 	if (ret < 0 && ret != -EINPROGRESS) {
 		stop_vpn(provider);
-		connman_task_destroy(data->task);
+		if (data->task)
+			connman_task_destroy(data->task);
 		data->task = NULL;
 		goto exist_err;
 	}
-- 
2.39.5

