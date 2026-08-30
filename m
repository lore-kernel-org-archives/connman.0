Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC43B71A5
	for <connman@lists.linux.dev>; Sun, 30 Aug 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104634; cv=none; b=inR02jkAVLq7bLW90EqWyLO+lOUAL6nMGd1oJ7W9zims9rKhDN38TUR1vLWydTl1owmXTBfAaQBWzdd9JkOSlsSged9vb+SsqexxQ0aZjcDJSe35lIdTau9JCyNJr58fD/PzVk+04h6iMKdnL9QppIUDoHrDvYZqlGRGiBjAkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104634; c=relaxed/simple;
	bh=9nLRSEdnQAMN0OKKc0xufORyvYxssJU6Io+Z4V6Yg/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k81v5BS9YJoSYA6QEILStEELELdDSCNHCavtwfiKigP6px6s223asjKNr+Da8gHIKV0orwo3JqGzkMpy5pHG7yqlWgN5Vii1wJEYFUETEC/uFgU3/1q0cJklFWa6v/vEQOGU98eaQDFy+ZqzxYLsSaEdmeH1ZH6jNILGLZo87Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=OEnKKdeV; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="OEnKKdeV"
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hXtC46LlPzDrx0
	for <connman@lists.linux.dev>; Sun, 30 Aug 2026 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1788096288; bh=4Yspp2dt1bgdfLSol7sxO1xpenQox9k+4PmhVA7uYLA=;
	h=From:To:Cc:Subject:Date:From;
	b=OEnKKdeV2TB/QD846LJoO1+vqPpPjMfHwMqH7gdm+A+Uz3RlNhwvTKcl5ozrcdJbm
	 HOHI1MT+AzbH+VC5PzO/JL521NiLxugRtJ1lyBZDuyWaIpEtyyEMduk1wxM5JWQ3+8
	 bPS2lntc4qrIiLjS/sA+0csyVfWj5lQfc8N4TzM0=
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4hXtBw6trbz9t6k
	for <connman@lists.linux.dev>; Sun, 30 Aug 2026 13:24:40 +0000 (UTC)
X-Riseup-User-ID: 74E842993BC270DBAD90706D0816CC68F9F7457A3E714C32C98DCAF85F054201
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews04-sea.riseup.net (Postfix) with ESMTPSA id 4hXtBw14Jbz5vfk;
	Sun, 30 Aug 2026 13:24:39 +0000 (UTC)
From: Doemela <kasuta@riseup.net>
To: connman@lists.linux.dev
Cc: Doemela <kasuta@riseup.net>
Subject: [PATCH v5] plugins/wifi: Fix GSupplicantInterface socket leak during teardown
Date: Sun, 30 Aug 2026 15:24:16 +0200
Message-ID: <20260830132416.1345-1-kasuta@riseup.net>
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
Changes in v5:
- Restored the required 'wifi->interface = NULL;' line that was accidentally dropped in v4.
- Adjusted description tone to use imperative language.

Changes in v4:
- Restored the missing patch commit description text.
- Fixed the stray empty line deletion formatting error.
---
 plugins/wifi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 9ce7b5a3..ce09b556 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2740,19 +2740,17 @@ static void interface_removed(GSupplicantInterface *interface)
 	DBG("ifname %s", ifname);
 
 	wifi = g_supplicant_interface_get_data(interface);
-
 	if (wifi)
 		wifi->interface = NULL;
 
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

