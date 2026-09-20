Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE773E1208
	for <connman@lists.linux.dev>; Sun, 20 Sep 2026 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789937819; cv=none; b=PSu2NbQ3yzjOK3wsA0HjmetWZ1gfaTSUKkh5YSAtvtqt/fxMFCeB41UqYyLkmx/00HqFh/pv/7nBXP2eCS3eJ5AsUBGcGFQsJFrmNCrPBuSzGTgt1JgDIGKFdhIkJ+rBN8HYjlBtoc1qDq+jITFcOcOXLXzZkFVdGfzzhxKTxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789937819; c=relaxed/simple;
	bh=EWJ3tYMvH7pfwNbuym49L0cQnmsvf2C2a32ql41dC9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3jt85Qvg0eveHVTuVfQTCIUBwCauMQtLMyXd8yo53M6KURdiQraLekDVGdmy+9lIZdblv3VV/m5dkDvV1e6Cp9pp5mPSr3np68M07fhxvfouU0QVclTe0GCU9i2URviJQOYgdkNhDwpF+sLDsp+H8qJ2iGfQQXvKbiX3iRtrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=TYnPUfAi; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="TYnPUfAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1789937816; bh=KUJJbLKiHNokUkklGLmdXPkfpz97j+0zAy6mXuu6MEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYnPUfAivYyyDzrg513Pp+qCwCYjgLkI8AmmRb4l1RBzlfCxoTa5l/t2BsPCy5qyX
	 2MEeb8Q/Swgvx6/z855WnSOUKRtm15RN7Tgjlzsg1a2tTp5QYSKDnFlynJ+6dDJh6o
	 xBtuwrLPP2INo0g8ytWIcCOff+Wqh/ACTjBeEWeE=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with UTF8SMTPS id 4hnzF45D0YzDrBf
	for <connman@lists.linux.dev>; Sun, 20 Sep 2026 20:56:56 +0000 (UTC)
X-Riseup-User-ID: 4F9A72939515392317A1954F1B439772EA8747657971143C5203224A66B37970
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with UTF8SMTPSA id 4hnzF40tcNz1xnd;
	Sun, 20 Sep 2026 20:56:55 +0000 (UTC)
From: Doemela <kasuta@riseup.net>
To: connman@lists.linux.dev
Cc: Doemela <kasuta@riseup.net>
Subject: [PATCH v7] plugins/wifi: Fix GSupplicantInterface socket leak during teardown
Date: Sun, 20 Sep 2026 22:56:36 +0200
Message-ID: <20260920205637.1324-1-kasuta@riseup.net>
In-Reply-To: <20260830133850.1423-1-kasuta@riseup.net>
References: <20260830133850.1423-1-kasuta@riseup.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cancel any pending GSupplicantInterface DBus calls and drop the
interface reference in the interface_removed() early-return paths.
Without this, ConnMan leaks file descriptors on Wi-Fi teardown
cycles, eventually hitting the 1024 fd limit and crashing.

Verified on LibreELEC 13 nightly 20260920-b68ee23 (ConnMan 2.0,
iwd backend) with kernel-space WireGuard connection cycles:

- Without patch: fd count 22 -> 49+, monotonically rising, no recovery
- With patch:    fd count returns to baseline (22) after each cycle

Changes in v7:
- Fix compile error: use 'struct wifi_data' instead of nonexistent
  'struct connman_wifi' in interface_removed()
---
 plugins/wifi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 9ce7b5a3..d17588be 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2734,8 +2734,10 @@ static void interface_state(GSupplicantInterface *interface)
 
 static void interface_removed(GSupplicantInterface *interface)
 {
-	const char *ifname = g_supplicant_interface_get_ifname(interface);
 	struct wifi_data *wifi;
+	const char *ifname;
+
+	ifname = g_supplicant_interface_get_ifname(interface);
 
 	DBG("ifname %s", ifname);
 
@@ -2747,12 +2749,11 @@ static void interface_removed(GSupplicantInterface *interface)
 	if (wifi && wifi->tethering)
 		return;
 
-	if (!wifi || !wifi->device) {
-		DBG("wifi interface already removed");
-		return;
-	}
+	if (wifi != NULL && wifi->device != NULL)
+		connman_device_set_powered(wifi->device, FALSE);
 
-	connman_device_set_powered(wifi->device, false);
+	g_supplicant_interface_set_data(interface, NULL);
+	g_supplicant_interface_cancel(interface);
 
 	check_p2p_technology();
 }
-- 
2.47.3

