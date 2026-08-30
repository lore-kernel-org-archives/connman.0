Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E813B3BF0
	for <connman@lists.linux.dev>; Sun, 30 Aug 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100456; cv=none; b=EbNTvaSrhvSz2II7aBnwbJGMF1o9t9FoTNLlxUwEvmPzY9+R06H+eQ6+cTNitosMll5YXo+RSixqJI8XbEexDUp9GyisUAkROOwaqs1eyj7ES5LhyZaR3seMdI7u5fj0D5CtmuWtoePzQOrZxf12OfDbM81BM6LDoWRGp3d0NT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100456; c=relaxed/simple;
	bh=JYLEkzZiQN91liNTa017V4m9VNwKPEIItKEdenrdhRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RO1/UMYnm97JBNBXlGlhEl2JkAVXOKomNYXQ8atyjgvf299bvAoSnoSJrTSoqtZHfl9IJcPzdjaTz/B1op4qZxaebtqzYkjf7612qo5dpyHq2GrGBdjXTkiRIqn4RRz9tF7QpfUbWltE536RRY71XBUNy6P8/qJhVySZY7bnVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=E1lqn+xd; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="E1lqn+xd"
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hXtWZ4C11zDt4F
	for <connman@lists.linux.dev>; Sun, 30 Aug 2026 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1788097146; bh=EFZOkw6AmCtntw1sAvFtQrRCHrmDyQMPC8Jd437O+AM=;
	h=From:To:Cc:Subject:Date:From;
	b=E1lqn+xd9q/dmIGK7PIob6D9Bx/QQo3EJU5wFPqJ4rJfo19vwwUrtFem6f+XjA9pb
	 ertsCX5v9ah8gvJz60rJGJvxtMKT56q3DFXnVs3JGcdtMQQNsULKLtn4vxYd/FyvfS
	 wO+7+dy9s5oYHxbmXhe70HK2Sk13nqOxe/surf/I=
X-Riseup-User-ID: 1C098B5D5D88417E52F0C54E40F3A3F570BCBAA45EBAAE2AD00D27E1344A5236
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews04-sea.riseup.net (Postfix) with ESMTPSA id 4hXtWX5NJbz5vbL;
	Sun, 30 Aug 2026 13:39:04 +0000 (UTC)
From: Doemela <kasuta@riseup.net>
To: connman@lists.linux.dev
Cc: Doemela <kasuta@riseup.net>
Subject: [PATCH v6] plugins/wifi: Fix GSupplicantInterface socket leak during teardown
Date: Sun, 30 Aug 2026 15:38:50 +0200
Message-ID: <20260830133850.1423-1-kasuta@riseup.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During interface teardown GSupplicantInterface resources are not properly
canceled leading to a socket file descriptor leak. Fix this by ensuring
g_supplicant_interface_cancel is always executed when an interface is removed.

---
Changes in v6:
- Fixed stray empty line deletion formatting error before 'if (wifi)' to ensure clean upstream application.

Changes in v5:
- Restored the required 'wifi->interface = NULL;' line that was accidentally dropped in v4.
- Adjusted description tone to use imperative language.

Changes in v4:
- Restored the missing patch commit description text.
- Fixed the stray empty line deletion formatting error.
---
 plugins/wifi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 9ce7b5a3..d0b60bea 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2734,8 +2734,10 @@ static void interface_state(GSupplicantInterface *interface)
 
 static void interface_removed(GSupplicantInterface *interface)
 {
-	const char *ifname = g_supplicant_interface_get_ifname(interface);
-	struct wifi_data *wifi;
+	struct connman_wifi *wifi;
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

