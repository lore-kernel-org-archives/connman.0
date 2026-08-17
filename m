Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC6448388
	for <connman@lists.linux.dev>; Mon, 17 Aug 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990506; cv=none; b=enyyddcb2bc8eiSCHiF16/f15aCRA9sQoKVm46tEHUhLr538SiPlvaa0KLLlFIQ3qjjzwNM1HdxeoK6HObkpGIwK83Zcig0eA+GFaVkt2VuMdVl37x4T105C7/g6YaFEIWU+MIP1KS+k6N7mYQPqc7TrB3xApKT+nA8n26EXnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990506; c=relaxed/simple;
	bh=aLnB56TM1PkdqwPseoI2ThxTncCZH9CWRfw/im0IBp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvGsp/dNH4bPjBoXTk3TGTXqWnkG0Qw8AbJcFfsmjNBVPZ0fV/7uD72xR/llYkxZ91p5Ugv/xgc1HK1+o6MJc9REDbiUcj4hJOa0f5wZ323pO/GggiF8ReKYdggoEASh/IOiwy0Dr7TLzRFgkT0NDGD+XFVW/y3iKZuiGmSYvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=l0zypOBg; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="l0zypOBg"
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hP1Fy3Sg9zDsXc
	for <connman@lists.linux.dev>; Mon, 17 Aug 2026 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786990502; bh=bnTZzX5QG1In3LptiAgWJIcVKV0CLgAwZlbTKVRG93c=;
	h=From:To:Cc:Subject:Date:From;
	b=l0zypOBg+ui9iSrdMqwGlZWkra1+Le1blf05k+s1HR2yS66/F8BPo+bzRTFNSW4j+
	 V94xd/CMVVVVUNWM5jpNq3dp1oXgJ4/NdAhEKzKUZojrr8tG/+frXMIHk2wgqd9vEv
	 OYAY/7uDgb8NWNOqoMe7WzhtsedGSaKeL9DbwRJY=
X-Riseup-User-ID: BBE524C95A9199FFBFFBE06C4032D4986CE5277CD7A397F1EA426EDD8AB2CC3E
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews04-sea.riseup.net (Postfix) with ESMTPSA id 4hP1Fx4d0lz5vLb;
	Mon, 17 Aug 2026 18:15:01 +0000 (UTC)
From: Doemela <kasuta@riseup.net>
To: connman@lists.linux.dev
Cc: Doemela <kasuta@riseup.net>
Subject: [PATCH v4] plugins/wifi: Fix GSupplicantInterface socket leak during teardown
Date: Mon, 17 Aug 2026 20:14:44 +0200
Message-ID: <20260817181444.5098-1-kasuta@riseup.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During interface teardown, the GSupplicantInterface resources were not being
properly canceled, leading to a socket file descriptor leak. This patch
ensures that g_supplicant_interface_cancel is executed safely when the
interface is removed.
---
Changes in v4:
  - Restored the missing patch commit description text.
  - Fixed the stray empty line deletion formatting error.

Changes in v3:
  - Fixed a text truncation error that broke the v2 patch file structure.
  - Switched entirely to using git send-email to prevent browser text corruption.
  - Sorry about the email formatting noise; it has been a long time since I used an email mailing list!

Changes in v2:
  - Corrected resource cancellation paths inside GSupplicantInterface.

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

