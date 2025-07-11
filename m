Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE752E7BB8
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244074; cv=none; b=cmn7Fi0juskciJpmP/b6Eqxdqhl9UR+LWnRirBJUAYulj2M3Fw81pjnSCl4K4YH9kx45+d38mD5d1pF4QD8TSyeR7JG+qaGNwse6y4CqOjnM8wpELEnr8Saicj4u2I7DcxNrGRI2SxOQNo5Knmq/M9J21lwl2YWhu6Zd5MFgN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244074; c=relaxed/simple;
	bh=2tEseAD9GOSaLJ2wd7srGUNSrgaQacesUG9NffK+5tU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEZoVvUcbxfM0+SJsncf602Vo53oLNMNP1p9QuDnxuWjwJkt0hHY1aGa3q3WGWA2h5RRy9cb74OUJvZ9dJ2aI0Zr16vQ3vYI88A6xJ9XVZ6QGxdWqq2ufxZqkzh+bhsSgw/GOonxEThNXux3/LFUtn5EEtffARP2fDW+vQR5v+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=oghyunNi; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="oghyunNi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xRCl6FFxTciNtLW8RqhuCxJXUJTWFXhH0pTGVnZBnSw=; b=oghyunNi+3w1CiozJl0/FVIk+V
	h9+lxy+OLqYzlnkDEruYQvYtovAqQo4xM7w9trOBWQiyuMLtqa0JVQ7S1NfPVnkjmNxhb155+x9xQ
	OJxcyjFCMBPNyZdWLsHB2mf/98t52gww4Q63jnxKfyNObua4cC2PKAAdQdqLgqY7UNwAUM6/yy+MH
	sNyJ+rxRwroAvY243mHahWDuDjP7CeZa8tkKSe7WKLscpAT/hmOebGLCuCyaUVNVhN090JV2gtdNf
	mBl1LRqLdVNFJejkSDw0YvPrnOGmOtHbWtgnBUf4lMFPtI3wkBmIoylIOsboW/lAQwhJR+yt+M51g
	GyK9lpVg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-2K
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 21/45] vpn: Check if disconnect is implemented before calling in stop_vpn()
Date: Fri, 11 Jul 2025 17:27:12 +0300
Message-Id: <20250711142736.1757060-22-jussi.laakkonen@jolla.com>
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

Check if the disconnect() is implemented for the vpn_driver before
attempting to call it when stopping a VPN. Also cleanup the code a bit.
Amends changes made in ffec305c1c93301534144774fffebb25fb9c6c7a
---
 vpn/plugins/vpn.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index 2651d4d0..a6b738b0 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -76,6 +76,7 @@ static int stop_vpn(struct vpn_provider *provider)
 {
 	struct vpn_data *data = vpn_provider_get_data(provider);
 	struct vpn_driver_data *vpn_driver_data;
+	const struct vpn_driver *vpn_driver = NULL;
 	const char *name;
 	struct ifreq ifr;
 	int fd, err;
@@ -88,16 +89,19 @@ static int stop_vpn(struct vpn_provider *provider)
 		return -EINVAL;
 
 	vpn_driver_data = g_hash_table_lookup(driver_hash, name);
+	if (vpn_driver_data)
+		vpn_driver = vpn_driver_data->vpn_driver;
 
-	if (vpn_driver_data && vpn_driver_data->vpn_driver &&
-			vpn_driver_data->vpn_driver->flags & VPN_FLAG_NO_TUN) {
+	if (vpn_driver && vpn_driver->flags & VPN_FLAG_NO_TUN) {
 		/*
 		 * Disconnect only VPNs with daemon, otherwise in error return
 		 * there is a double free with vpn_died() or the failure state
 		 * is overridden by changes made by disconnect to state.
 		 */
-		if (!(vpn_driver_data->vpn_driver->flags & VPN_FLAG_NO_DAEMON))
-			vpn_driver_data->vpn_driver->disconnect(data->provider);
+		if (!(vpn_driver->flags & VPN_FLAG_NO_DAEMON) &&
+							vpn_driver->disconnect)
+			vpn_driver->disconnect(data->provider);
+
 		return 0;
 	}
 
-- 
2.39.5

