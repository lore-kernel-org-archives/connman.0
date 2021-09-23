Received: from web-bm.overkiz.com (web-bm.overkiz.com [92.222.103.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D772
	for <connman@lists.linux.dev>; Thu, 23 Sep 2021 12:53:18 +0000 (UTC)
Received: from laptop-vhenriet.int.overkiz.com (unknown [185.81.55.234])
	(Authenticated sender: v.henriet@overkiz.com)
	by web-bm.overkiz.com (Postfix) with ESMTPSA id F2E0C1BF29F;
	Thu, 23 Sep 2021 14:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=overkiz.com;
	s=202003; t=1632401102;
	bh=RyWAD5mR+T/FmtzP/HNpFEEIZFD33NynUvfTMvuHDag=;
	h=From:To:Cc:Subject:Date:From;
	b=MLboKHuMNnym4+HRwsL+2uJO538UEL5GNA4/dQyEqOVwR3Ac5PfGekjOA0ZGLqZED
	 LwECk/XvXvFiniv0CcNVQl1DGpYq+IgpDzD2/61Ne/UEXOVlLyTNcyJM4f9vW6W/7+
	 UYZz2XNYNlkparIP6K6usSvuBuKNQTWAqgWMlz8hg+bLxI4x7iXLAfbJ0V+8tF3mhN
	 TsTU7R2pzM5ehWQI17WVzBmcS23sohQxA8WtP+j6VFWtp9jfjiGdDg6IcaIIZqlF7l
	 uhUetXSycDmiAggO1hQvt3isQdAgkZFX2rcY7ujSrQ7fBb8YA+J9p/oALC3kcphy0W
	 PN0wueOqUWp1Q==
From: Vivien Henriet <v.henriet@overkiz.com>
To: connman@lists.linux.dev
Cc: Vivien Henriet <v.henriet@overkiz.com>
Subject: [PATCH] wifi: Choose a random channel when opening an ap
Date: Thu, 23 Sep 2021 14:44:29 +0200
Message-Id: <20210923124429.1123-1-v.henriet@overkiz.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: f125012e-72d2-4729-b87c-a5ab9341072c
X-Bm-Transport-Timestamp: 1632401102092

When the tethering mode is started, a WiFi ap is created using the fixed
channel 1 (2412 MHz). There is no way to configure this channel.

This patch make connman choose a random channel every time the ap is created.
---
 plugins/wifi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 578b4be7..936f1750 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -3344,11 +3344,19 @@ static GSupplicantSSID *ssid_ap_init(const char *ssid, const char *passphrase)
 	if (!ap)
 		return NULL;
 
+	/**
+	 * Choose a random channel in the range 1-11. Channels 12-14 are not
+	 * available worlwide.
+	 * Channels within this range are spaced 5 MHz apart from each other.
+	 */
+	int channel = (rand() % 11) + 1;
+	int freq = 2407 + channel * 5;
+
 	ap->mode = G_SUPPLICANT_MODE_MASTER;
 	ap->ssid = ssid;
 	ap->ssid_len = strlen(ssid);
 	ap->scan_ssid = 0;
-	ap->freq = 2412;
+	ap->freq = freq;
 
 	if (!passphrase || strlen(passphrase) == 0) {
 		ap->security = G_SUPPLICANT_SECURITY_NONE;
-- 
2.32.0

