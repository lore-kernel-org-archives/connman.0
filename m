Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9E2E7BBC
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=DTBDlpl5rsXSIz9EDoypIhHe3vhpJtn3Vp93H1fqjXFOVxz09J0jLcnjgqH2vq+WBBtoNmSV9s1DE92z1sjnzr8L9oWoc9AI7jzipzFefZAeS7dehiePXtdv+ibypMJ2i7DeUQvV94c103iI4lQ2DjO401BPyNiF6/HGy9qnc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=h9fmCPLzxUbl1OhjkeWtCCeIBXPPXgb+FWreLcgfOwg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGcO+4EsFL6VkL4F2/F0NsucXznYjRiJmzpMId3LWdRx1hsOwkGYAwKKF5WCLor52HyM95Jz/igfPX1/+I7n4LQg/IZPRFOWnbwPP+8AEWOOUk5i82MKvt/2DhTpyDL+haxHCvzHyEuzOhqXoj7K46anwIJk31cGD+idMFCvRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=KB/rJR1y; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="KB/rJR1y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lDys70+kNjFX4dm1ukfqr9O408RlJ6lt/0Ek1EEhJ90=; b=KB/rJR1yHYis9bs0X84plW9VJ1
	NQboGs7mhcUh3M8yE8HdiWwQdapl4deR1nivzaMi0uMF5YdE/hw87XsgJzkqev4TTf+aBeIoEZtHz
	1Qf97AQPHGEqgvDKA0GVG2gbQPlTwbK5WUOQIBAyR8huCfvPyvtvlgtsnoce8pbLtCOQguBJx8eul
	ozM8XuTSaXKpUR901ZqTEZtDjxeSV0HFJPpniym4sb380SyB1wnnIsXqZnFO/oYNAj+eJsvZbhhph
	JcTR4ZUmdSvPeIWdgfJvs3meg5u0leJ3HHER9ph4ESXWlvrxs3CPdttwAGTWAREBwhxu/KvEoiIdv
	QBA5Fd8Q==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-1d
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 38/45] vpn-provider: Delay connect of daemonless VPNs until connmand is online
Date: Fri, 11 Jul 2025 17:27:29 +0300
Message-Id: <20250711142736.1757060-39-jussi.laakkonen@jolla.com>
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

When the connmand state has been queried and a daemonless VPN is being
connected it must be connected later when online state is reached. This
ensures that if the online check on connmand transport is slow, the
daemonless VPN will get connected when state changes.
---
 vpn/vpn-provider.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 9211368a..f72030af 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -920,6 +920,15 @@ static DBusMessage *do_connect(DBusConnection *conn, DBusMessage *msg,
 
 	if (!is_connman_connected(provider)) {
 		if (state_query_completed) {
+			/* Query done but connmand not online for daemonless */
+			if (connman_online_state >= CONNMAN_READY) {
+				DBG("Provider %s start delayed, wait for "
+						"connman online state",
+						provider->identifier);
+				do_connect_later(provider, conn, msg);
+				return NULL;
+			}
+
 			DBG("%s not started - ConnMan not online/ready",
 				provider->identifier);
 			return __connman_error_failed(msg, ENOLINK);
-- 
2.39.5

