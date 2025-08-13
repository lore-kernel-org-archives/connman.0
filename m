Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9EC2857CC
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099608; cv=none; b=S4ORIeQFKnw6DbmFmEJGaLwThpaQnKdNQwoe/k2Lmkm4aWtugfTTt6AsPB62jOlC952eG/SMN42xv954Bk4qjHpNn85lEDdaBO4028jumMg5yMb3GwsfVT1ctQXHsSwuVzpgyNDJiUymXKcNZMiy4s4C7ljetZyEkQRtwBmss9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099608; c=relaxed/simple;
	bh=GBAbhVG/MGRl9n8j3XTA3JAvZxkNAmaJMjJjODZmbOc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gf0e4BXFvIdOvbZcdUo67yy55fq98PhxFcVzRhjTapTtol/6qzVghzchp7n/c/F1/fn2TJVuOYsn0MmC5cx9OFvPNFf4/tIg/RWZgAZba2pzfLAvcdxoZH3Ff9Xw9X7QFIuXlHPYM1NFuurThOCl8OlEAxXSQc5mnuNs8LaOaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=MLvqI8P7; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="MLvqI8P7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wvqCr81Bx4MihbCgJaIF3odnOQ8pUI1/XgbHnqVMccg=; b=MLvqI8P7fhhp0ni6HsjUoHqlIT
	8fki12d1OQ8zueN77y0bieqTbKxp+trkf9w7tHKiIvmQqzrP1zFzrjQgBDuv5z39qa1L5m2rdC+Bv
	oy14Bd1DW1MXAkKf8qGpQGZcEUHT0u69gfEeygBMTc1FSaEafhYbT+huz7CtJzypW//ynfjWN1kXe
	yxUDA5mWdigl9RdpfOolOAkBLIPHGgsqCFBzMrdyPtSjntGX+Xda6AXRCRm5hZqiF+NyDtSqoautn
	swJJFDT5Hznyp83G6dtXfxfXREo3SL8jTvUNishhROSIwf04WHPqZOxh5a3rzlY/+vFmxbWHzz9z5
	V73HUZEw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-1m
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 13/42] vpn: Fix VPN_FLAG_NO_DAEMON use in error cases
Date: Wed, 13 Aug 2025 18:01:45 +0300
Message-Id: <20250813150214.189282-14-jussi.laakkonen@jolla.com>
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
index ea64fdc2..9ff2ad6c 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -91,7 +91,13 @@ static int stop_vpn(struct vpn_provider *provider)
 
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
 
@@ -131,16 +137,27 @@ void vpn_died(struct connman_task *task, int exit_code, void *user_data)
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
@@ -156,15 +173,7 @@ void vpn_died(struct connman_task *task, int exit_code, void *user_data)
 
 vpn_exit:
 	if (state != VPN_STATE_READY && state != VPN_STATE_DISCONNECT) {
-		const char *name;
-		struct vpn_driver_data *vpn_data = NULL;
-
-		name = vpn_provider_get_driver_name(provider);
-		if (name)
-			vpn_data = g_hash_table_lookup(driver_hash, name);
-
-		if (vpn_data && vpn_data->vpn_driver &&
-				vpn_data->vpn_driver->error_code)
+		if (vpn_data && vpn_data->vpn_driver->error_code)
 			ret = vpn_data->vpn_driver->error_code(provider,
 					exit_code);
 		else
@@ -183,7 +192,8 @@ vpn_exit:
 	}
 
 done:
-	connman_task_destroy(task);
+	if (!no_daemon)
+		connman_task_destroy(task);
 }
 
 int vpn_set_ifname(struct vpn_provider *provider, const char *ifname)
@@ -546,6 +556,8 @@ static gboolean update_provider_state(gpointer data)
 	vpn_data->watch = vpn_rtnl_add_newlink_watch(index,
 						vpn_newlink, provider);
 	connman_inet_ifup(index);
+	vpn_data->state = VPN_STATE_CONNECT;
+	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_CONNECT);
 
 	return FALSE;
 }
@@ -621,18 +633,10 @@ static int vpn_connect(struct vpn_provider *provider,
 
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
@@ -658,9 +662,12 @@ static int vpn_connect(struct vpn_provider *provider,
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

