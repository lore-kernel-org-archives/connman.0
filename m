Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF0222597
	for <connman@lists.linux.dev>; Mon, 17 Aug 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980888; cv=none; b=B0rHJ8pUvVUG1wb+A6bSf5mvqWMvhbiwCUgw9tqh03nW11iRXCCj9pfU7GAR4kfklRBU4D01VZ1fUeYgQa/E0kt7rQqPOpPeiQKALuhZwIKg0axcs9NfN/Rghiqn71PRov2ox5UdHUHn10rQP9GYBEz8R9TPp/MnaCPgE4gt1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980888; c=relaxed/simple;
	bh=YFljbjDU+uuhIpLT5U7n7iL/TIO3hg78DYwDPoIdx2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V23ei4fzfIdWzgyGtVLcLzManC8zFhzEo4TnFm31Xa6mXjMNSAjy6MhnKGnO+k3hUEgjzIvyV4FNpHg+7o48GaLtG9anLbqcHcUUHPT30BmBIJXvtrWGppI8vSc8UQJ4y0AK+2HDO6ff/3GzFoWPZBOQ02iCJrp6XzfSTAbNdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=soEU1n/J; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="soEU1n/J"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hNxj21RHdzDq8g
	for <connman@lists.linux.dev>; Mon, 17 Aug 2026 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786980886; bh=JjCoo1h4f6HqEBE5+AL4u/jDl50EI4vsy4kEm4AU5FU=;
	h=From:To:Cc:Subject:Date:From;
	b=soEU1n/J8fcwaIf/1kylrf28IGx/IyvzmW/lmX0vYQNJkhzBf8Yb4Bdn0Ghc8gEWJ
	 uX3ro9gGYthr6P6Tle8qTOwEqgj/n0+rWBCIPk21fQ+HU0ITERVWJgAxg1Q+marOqu
	 vGmNhxZOshwU5BqUq15TalXk2WSYX1OyQhFPcIQA=
X-Riseup-User-ID: 7573311C040252083E0189CD2EA87E32A9295FF982FE4FF13EF61A95BB703FFA
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4hNxj06f2tz1y2D;
	Mon, 17 Aug 2026 15:34:44 +0000 (UTC)
From: Doemela <kasuta@riseup.net>
To: connman@lists.linux.dev
Cc: Doemela <kasuta@riseup.net>
Subject: [PATCH v3] plugins/wifi: Fix GSupplicantInterface socket leak during teardown
Date: Mon, 17 Aug 2026 17:34:28 +0200
Message-ID: <20260817153428.1851-1-kasuta@riseup.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
Changes in v3:
  - Fixed the truncation error at line 10 that broke the v2 patch.
  - Switched to git send-email to avoid webmail formatting bugs.
  - Sorry about the formatting noise; it has been a while since I used a mailing list!

Changes in v2:
  - Corrected resource cancellation logic inside GSupplicantInterface.

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

