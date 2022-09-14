Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C152F23
	for <connman@lists.linux.dev>; Wed, 14 Sep 2022 18:46:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [186.12.61.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: adalessandro)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id C6C196601F8A;
	Wed, 14 Sep 2022 19:46:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1663181185;
	bh=votv1jOzhkFtShfO2LXmaZTlgO1Zw1tjI6wsrlmvaQk=;
	h=From:To:Cc:Subject:Date:From;
	b=AQRj4rmxxg+ygJaTwtD11I9HVouiKKvt3XLlnQXC9nGIlWO1PmN3OJ/5fbT6xTnM6
	 kxNkYiYTZ3F+o3XuIdFIac3aH2YJgBq3odusf8/+hF+LmB7XXtuhbXYFi64XIluykG
	 Dm2kp0LfcI4YiGRVe0EK78BpwrvkDmXHqJmcDvqpUfK8FmZ80Krmn+EyzZuUvkkdsz
	 LJkcBZF3yMyqiavFHa6BxCqgqgPcmCvi1HwpVVN4OSUPd/l41uR7d1DMUuZR3rere/
	 ymdqqt9teDwLC7Cvxp6Kp+ejW4byc7fAoqh4gI5Dchl4SyMfK1TPESIaxtxsWGetbr
	 y65R67fHWOK3A==
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: connman@lists.linux.dev
Cc: john@metanate.com
Subject: [PATCH] wifi: Handle invalid-key case on WPA-SAE authentication failure
Date: Wed, 14 Sep 2022 15:46:10 -0300
Message-Id: <20220914184610.258763-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On WPA3-SAE authentication, wpa_supplicant goes directly from
authenticating to disconnected state if the key was invalid.

The above is currently not handled and the `connect-failed` error is
reported on such cases. In order to make the client agent prompt for a
new password, we need to handle this transition and report the
`invalid-key` error.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 plugins/wifi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 2a933708..ed7437f5 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2528,6 +2528,25 @@ static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
 	return false;
 }
 
+static bool handle_sae_authentication_failure(struct connman_network *network,
+					      struct wifi_data *wifi)
+{
+	struct wifi_network *network_data = connman_network_get_data(network);
+
+	if (!(network_data->keymgmt & G_SUPPLICANT_KEYMGMT_SAE))
+		return false;
+
+	if (wifi->state != G_SUPPLICANT_STATE_AUTHENTICATING)
+		return false;
+
+	if (wifi->connected)
+		return false;
+
+	connman_network_set_error(network, CONNMAN_NETWORK_ERROR_INVALID_KEY);
+
+	return true;
+}
+
 static void interface_state(GSupplicantInterface *interface)
 {
 	struct connman_network *network;
@@ -2625,6 +2644,13 @@ static void interface_state(GSupplicantInterface *interface)
 						network, wifi))
 			break;
 
+		/*
+		 * On WPA3-SAE authentication, wpa_supplicant goes directly from
+		 * authenticating to disconnected state if the key was invalid.
+		 */
+		if (handle_sae_authentication_failure(network, wifi))
+			break;
+
 		/* See table 8-36 Reason codes in IEEE Std 802.11 */
 		switch (wifi->disconnect_code) {
 		case 6: /* Class 2 frame received from nonauthenticated STA */
-- 
2.37.2

