Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB91FC0
	for <connman@lists.linux.dev>; Mon, 21 Sep 2026 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954822; cv=none; b=K1yf6/2nrPuOlePlb2oEWHPPabLSazXGR0tpvsiB4jlPrJS58OooN++oK9aKM1iNz3Gd+tqGd8sGEq9kJ1EX/JLllAgIa3yxlhTUy9vqTgZih34Vwcaprm8/Up4zNUSPZqT6TPFxK9WlP/eFxI4DfcaI7wF1X/4d/7g6XQDWTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954822; c=relaxed/simple;
	bh=Jt9E2t0qKomyC+CO+zlRL9DNk18hnMNc8TsxxI6SJ/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQyMw8yxaf3b8dsWRAZ0AHmlWBHQZjwVWfifmF6UhP6j0/DMc9UEXs574ngyAAi/H10pgFVAlnHdcDfHmSX4FbprwfYCzE4tIbZrReaf2J+VoExf0YefPf97dbgTIUMvtbNJ+lGDqXVvMbchY5BUEIbJ+ZQ0AusLTttxvM6T4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=W8BQxsOs; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="W8BQxsOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1789954820; bh=IeI3fxJnHleQW6ieK0ofmrlkQaOgBF/PAmQLmkKw8gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8BQxsOst1e6eYZ2868LoIpL75V2QptdElaHD9NuWFJkWF/LfNb2LiMBNLNJ1M7Qh
	 UOU5j/WBFvFQ73WSMvTEQs7doPzObl9CEiQAzO5s6JK5VdYQ2IYw+CJ6JgS61fiQ7a
	 gOl1V7jxECwkB2C1LOAmf7Y4VnFM4WmzX1lbV4MU=
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with UTF8SMTPS id 4hp5X452YXzDqsQ
	for <connman@lists.linux.dev>; Mon, 21 Sep 2026 01:40:20 +0000 (UTC)
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with UTF8SMTPS id 4hp5Wy4Gxcz9rxV
	for <connman@lists.linux.dev>; Mon, 21 Sep 2026 01:40:14 +0000 (UTC)
X-Riseup-User-ID: 1728607FD49BF5152408AA087A3AF11143D6E22E5F9F6BD4DF0ADAD313D5A95A
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews04-sea.riseup.net (Postfix) with UTF8SMTPSA id 4hp5Wy09mYz5vYQ;
	Mon, 21 Sep 2026 01:40:13 +0000 (UTC)
From: Doemela <kasuta@riseup.net>
To: connman@lists.linux.dev
Cc: Doemela <kasuta@riseup.net>
Subject: [PATCH v8] plugins/wifi: Fix GSupplicantInterface socket leak during teardown
Date: Mon, 21 Sep 2026 03:39:58 +0200
Message-ID: <20260921013958.1218-1-kasuta@riseup.net>
In-Reply-To: <20260920205637.1324-1-kasuta@riseup.net>
References: <20260920205637.1324-1-kasuta@riseup.net>
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

Signed-off-by: Doemela <kasuta@riseup.net>
---
Verified on LibreELEC 13 nightly 20260920-b68ee23 (ConnMan 2.0,
iwd backend) with kernel-space WireGuard connection cycles:

- Without patch: fd count 22 -> 49+, monotonically rising, no recovery
- With patch:    fd count returns to baseline (22) after each cycle

Changes in v8:
- Move testing commentary below the --- separator
- Add Signed-off-by line

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

