Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A320E38F927
	for <connman@lists.linux.dev>; Sun, 16 Aug 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786904291; cv=none; b=Uq5++VfHxsS4jzLr4lb1veAw15y8mTllHaxBBOEpYkSPbDG4U5Xo798smhrXn7DHFQP9cvQaeeRAB/tv9jV9eY60kojPeJ8InnDrtfZfxD6b9YPwQPDCnIDtKiMSTZK9dJS99mGAJUoamTEUvX66rlFHhO6TlmKcBegR/IXKXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786904291; c=relaxed/simple;
	bh=O/vqQck3gOvGyGrpy0YfKrZcXAiPRkPzG7tLn0w2cwg=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=EqWQq+/6FR/WX444UNRh/xyYusEihMOKOILJPZg0raFSEcJjHCAQbSlszToAkTkHFhbwr0KdMvOT8/OyRVZrhk4ZcHAf3otUKlFXV9PJkg2flSUVyRPGhZ9oZOR11wyvIILzJpddnZrxQIPwlfIT3RChG4K9IrIWuPayn5r7MnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=mIT8SRe6; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="mIT8SRe6"
Received: from fews03-sea.riseup.net (fews03-sea-pn.riseup.net [10.0.1.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hNPMh0m0pzDqB1
	for <connman@lists.linux.dev>; Sun, 16 Aug 2026 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786904283; bh=rzaSpqQZzivvh+45sErnK+kRZvoOstrsXW1dnsneh48=;
	h=Date:From:To:Subject:From;
	b=mIT8SRe6hu7gAEeHzktfPrGjxjxsTwDwbAT3MjOX2UtNI5GM3gp+tRgmC3ByMuH4a
	 /kHytKUaX5Wld311YsPcQMNyfMFD/8JwnXf3hlAX5UnNalbz/1YT6OXMQPXlTam5wY
	 I7hj4F6Sz0ehb+YXCLUMRHvqD26whSY9yL0kMsqo=
X-Riseup-User-ID: 1BACE372F8A2E8D581CAA0399F6F0CA23003456A8CC78BD678B7C29FA9BBE8CB
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews03-sea.riseup.net (Postfix) with ESMTPSA id 4hNPMg6S92z1y3q
	for <connman@lists.linux.dev>; Sun, 16 Aug 2026 18:17:51 +0000 (UTC)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 18:17:51 +0000
From: kasuta@riseup.net
To: connman@lists.linux.dev
Subject: [PATCH v2] plugins/wifi: Fix GSupplicantInterface socket leak during
 teardown
Message-ID: <98cff95babe8e6de463c9051751a9164@riseup.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

When a virtual or unmanaged wifi interface is dropped out-of-band, 
interface_removed() is invoked within the wireless event loop.

If the underlying wifi struct or its device linkage has already been 
cleared during a topology shift, the current logic bypasses the 
mandatory g_supplicant_interface_cancel() and data unreferencing 
routines due to missing fallback handling. This causes netlink and 
event file descriptors to permanently leak in the process table.

Refactor interface_removed() to ensure resource cancellation runs 
unconditionally, even if device pointers are already gone.

Signed-off-by: Doemela <kasuta@riseup.net>
---
diff --git a/plugins/wifi.c b/plugins/wifi.c
index d18dc6cd..df938c1a 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2284,14 +2284,14 @@ static void
interface_removed(GSupplicantInterface *interface)
 
 	wifi = g_supplicant_interface_get_data(interface);
 
 	if (wifi)
 		wifi->interface = NULL;
 
 	if (wifi && wifi->tethering)
 		return;
 
-	if (wifi == NULL || wifi->device == NULL)
-		return;
-
-	connman_device_set_powered(wifi->device, FALSE);
+	if (wifi != NULL && wifi->device != NULL)
+		connman_device_set_powered(wifi->device, FALSE);
+
+	g_supplicant_interface_set_data(interface, NULL);
+	g_supplicant_interface_cancel(interface);
 }
