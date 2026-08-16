Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04F12D1F1
	for <connman@lists.linux.dev>; Sun, 16 Aug 2026 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786897291; cv=none; b=tu+wBFBrzLRjUDyfwA7SPHhxhpcs6ovG/IwpFKWI/1kgL/JsmN2gHZS8uFCbZI4aBoTYZTOclRe8nOCouZzk1pukacA7M5vYldQECMQa2axv7pVRlFwHOsWk2eAM0eoGoGLsijrfrhja7U9j7YnIsbMESGCiBjuSw0DYnsCJXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786897291; c=relaxed/simple;
	bh=yEzqCEjrFPHMi+p7AZ7jT5MvKg9ts2kiGXUwtDe/dHs=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=lLoL7JEgh0qVRJXfMY35UO6OL+5G6Nw1QvfqZ8Zf0rLubZ0sJVs53T78P8WDAR/zfgjfCDPmT8jHCDJA4dDvIR+uqN7+HvVEi799EsT0lFC0Q4Eiv4Hfyt60pVatIiNGbVyFx3p6LlurIrCmVdFrFe5nJJXw/07zuFlWBmepMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=LoRlBknv; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="LoRlBknv"
Received: from fews03-sea.riseup.net (fews03-sea-pn.riseup.net [10.0.1.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4hNLnH2sLBz9shd
	for <connman@lists.linux.dev>; Sun, 16 Aug 2026 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786897283; bh=bekX9Yq5h7UnT1z46oKLNpdn5e6ivt2UUISvPZHIEOs=;
	h=Date:From:To:Subject:From;
	b=LoRlBknvR0Qh3/aiyKtptr0tubYuH6VC4UKDU1vkuOkA1ouB8twPzOrv1d26y/4fO
	 0SNb6340EqqmznxOZhIm9BG72Gt6iEHbbPs33FpdDLgXTFe2KDZszetcvNAWIdAJhu
	 yCkXITWrHyeN0LdPJO01KpwvWUFf/fEfQgEILtso=
X-Riseup-User-ID: B3967CEFF6D642902A9A30854262001FCF600D5E3F918F87C8A62CE24E0E3421
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews03-sea.riseup.net (Postfix) with ESMTPSA id 4hNLnH1Jx1z1yRK
	for <connman@lists.linux.dev>; Sun, 16 Aug 2026 16:21:23 +0000 (UTC)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 16:21:22 +0000
From: kasuta@riseup.net
To: connman@lists.linux.dev
Subject: [PATCH] plugins/wifi: Fix GSupplicantInterface socket leak on
 out-of-band drop
Message-ID: <3dc118dce9fca530fffff07dbee1265f@riseup.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

When an unmanaged or virtual interface changes state or drops, 
interface_removed() is invoked within the wireless event pathways. 

If wifi or wifi->device has already been cleared or unlinked during the 
topology shift, the function triggers an early return. This conditional
block accidentally bypasses the mandatory
g_supplicant_interface_cancel()
and data unreferencing routines. As a result, low-level netlink and
event 
file descriptors are permanently leaked in the process table.

Refactor interface_removed() to ensure that the core supplicant 
interface resource cancellation runs unconditionally before releasing
control.

Signed-off-by: Doemela <kasuta@riseup.net>
---
diff --git a/plugins/wifi.c b/plugins/wifi.c
index 9ce7b5a..bcf8321 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -1014,14 +1014,16 @@ static void
interface_removed(GSupplicantInterface *interface)
 	wifi = g_supplicant_interface_get_data(interface);
 
 	if (wifi != NULL && wifi->tethering == TRUE)
 		return;
 
-	if (wifi == NULL || wifi->device == NULL) {
-		DBG("wifi interface already removed");
-		return;
-	}
+	if (wifi != NULL && wifi->device != NULL) {
+		wifi->interface = NULL;
+		connman_device_set_powered(wifi->device, FALSE);
+	} else {
+		DBG("wifi device linkage missing, executing isolated interface
cleanup");
+	}
 
-	wifi->interface = NULL;
-	connman_device_set_powered(wifi->device, FALSE);
+	g_supplicant_interface_set_data(interface, NULL);
+	g_supplicant_interface_cancel(interface);
 }
