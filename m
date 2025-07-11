Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF42E7636
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=trEm7JCxC36FnvdQRbj3sHWtDDXwTCJvn5qUzziWF+BToedVinfqDGnfXMngpXVYPqrQXn3VJ82lPo91uO/MdVrGu18xrecg+gjaIqnZzCN1BPywio3a7cVtGzB5s8unqC/jTOzhgwvKJXJ+kIUlQd4ptcgH/fzmra+FLbVOyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=oij8ahuAHg7KRzrpO0dFcM58p12m2GJzXp4aqAbWsvs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tckou3YzaEpPVmbGG7DobDDNzPvTTLyFjWzcEgjpRYISNDuX4MJXrEpkigSIXQKQPRno4FyRaPpD3u7OVIFxcRCqhk/ktwDnf9HU3rx95gZQEBBOo6chkv+IqQyNWwz7RbUONv46C1zhAUMOINYZis0We8axSYBoXoAtDOlVUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=w2UcVhmi; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="w2UcVhmi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Vk63hJMwZm4Ato+JcOtrTJqPvJa0JrwcXIneuUpMyoo=; b=w2UcVhmiLaOE+TiE+rAuXF3w8A
	Tdw5H78hSUDxa+28zeataiKLm6jLT0a/vn9VwJpa6ilPOIzwFC619rR+xZWikf2wJ1LATukT5aEsz
	hHOcyC/yxo0l8Oj3Ev80VmBcF4UbeR1J7SRIPWu55+N4fSHpsgBtqJGbID600jCtvVBrGy6vMjzfc
	fHjZG+pt1PbnbE91lOy5RogL5vceqAb73PwZdntcqkZTwCsIsDIrlYoWgQ4Z0c0pWe3AM3PjMSkDv
	KusCNgtxpF7eZACK2hAKr7PSDZ7bcA6qUTzLcChLjfPkf/yiuM+Kwa9alFk46ES9ckurbiw+3Fwvx
	LbKc4LzQ==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj0-003kbq-2x
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:42 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 03/45] vpn: Add association state before connect state
Date: Fri, 11 Jul 2025 17:26:54 +0300
Message-Id: <20250711142736.1757060-4-jussi.laakkonen@jolla.com>
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

This changes the state machine by adding the VPN_STATE_ASSOCIATION to be
entered right after connect() callback is called. This is needed in
order to properly react with the user input dialog waiting on VPNs.
connect state is now set when the dialog is closed to indicate that user
input is given and now the VPN really connects.

When VPN notify() allback is called the connect state is enforced if the
return value indicates so and the internal state is different. This is
to accommodate the changes required and to operate as a fallback that
the states of provider and driver are kept in sync.

Warn about invalid transition to ASSOCIATION state in case vpn_notify()
gets it as a reply back from plugin notify.
---
 vpn/plugins/vpn.c | 22 +++++++++++++++++++++-
 vpn/plugins/vpn.h | 11 ++++++-----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index 1644e16d..52f7cac7 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -220,6 +220,9 @@ static int vpn_set_state(struct vpn_provider *provider,
 	case VPN_PROVIDER_STATE_IDLE:
 		data->state = VPN_STATE_IDLE;
 		break;
+	case VPN_PROVIDER_STATE_ASSOCIATION:
+		data->state = VPN_STATE_ASSOCIATION;
+		break;
 	case VPN_PROVIDER_STATE_CONNECT:
 	case VPN_PROVIDER_STATE_READY:
 		data->state = VPN_STATE_CONNECT;
@@ -282,6 +285,12 @@ static DBusMessage *vpn_notify(struct connman_task *task,
 
 	switch (state) {
 	case VPN_STATE_CONNECT:
+		if (data->state == VPN_STATE_ASSOCIATION) {
+			data->state = VPN_STATE_CONNECT;
+			vpn_provider_set_state(provider,
+						VPN_PROVIDER_STATE_CONNECT);
+		}
+		/* fall through */
 	case VPN_STATE_READY:
 		if (data->state == VPN_STATE_READY) {
 			/*
@@ -334,6 +343,16 @@ static DBusMessage *vpn_notify(struct connman_task *task,
 		break;
 
 	case VPN_STATE_UNKNOWN:
+		break;
+
+	/* State transition to ASSOCIATION via notify is not allowed */
+	case VPN_STATE_ASSOCIATION:
+		connman_warn("Invalid %s vpn_notify() state transition "
+					"from %d to %d (ASSOCIATION)."
+					"VPN provider %p is disconnected",
+					vpn_driver_data->name, data->state,
+					state, provider);
+		/* fall through */
 	case VPN_STATE_IDLE:
 	case VPN_STATE_DISCONNECT:
 	case VPN_STATE_FAILURE:
@@ -568,6 +587,7 @@ static int vpn_connect(struct vpn_provider *provider,
 		data->state = VPN_STATE_IDLE;
 		break;
 
+	case VPN_STATE_ASSOCIATION:
 	case VPN_STATE_CONNECT:
 		return -EINPROGRESS;
 
@@ -648,7 +668,7 @@ static int vpn_connect(struct vpn_provider *provider,
 	DBG("%s started with dev %s",
 		vpn_driver_data->provider_driver.name, data->if_name);
 
-	data->state = VPN_STATE_CONNECT;
+	data->state = VPN_STATE_ASSOCIATION;
 
 	return -EINPROGRESS;
 
diff --git a/vpn/plugins/vpn.h b/vpn/plugins/vpn.h
index fd10addf..a8d24fc3 100644
--- a/vpn/plugins/vpn.h
+++ b/vpn/plugins/vpn.h
@@ -34,11 +34,12 @@ extern "C" {
 enum vpn_state {
 	VPN_STATE_UNKNOWN       = 0,
 	VPN_STATE_IDLE          = 1,
-	VPN_STATE_CONNECT       = 2,
-	VPN_STATE_READY         = 3,
-	VPN_STATE_DISCONNECT    = 4,
-	VPN_STATE_FAILURE       = 5,
-	VPN_STATE_AUTH_FAILURE  = 6,
+	VPN_STATE_ASSOCIATION   = 2,
+	VPN_STATE_CONNECT       = 3,
+	VPN_STATE_READY         = 4,
+	VPN_STATE_DISCONNECT    = 5,
+	VPN_STATE_FAILURE       = 6,
+	VPN_STATE_AUTH_FAILURE  = 7,
 };
 
 struct vpn_driver {
-- 
2.39.5

