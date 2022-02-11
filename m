Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEA2F2A
	for <connman@lists.linux.dev>; Fri, 11 Feb 2022 13:53:04 +0000 (UTC)
Received: from xpert.denx.de (unknown [62.91.23.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lusus@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E57068381D;
	Fri, 11 Feb 2022 14:45:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1644587140;
	bh=SNFLGNI6b3WVYtRCPmVzK+E81pTRypbpnkS4WSdVKN0=;
	h=From:To:Cc:Subject:Date:From;
	b=rn3bvFEJwSmi3U3pZ7r1jhCrpcphmj9WTFtdx3iuJ9s7wUAV0SfW3IUCKfFDHWXBN
	 jsL+o2iEoM91xVE4PnIwwaHfDV++JBaWHZGDT/DbhnzrBXGmMBpphp7TkzCZxJRjVu
	 tvxR20ecO9EreHmAaG4/nAzw4sLMUvp2xCuZ5yZoxtdzH6YhV3dsgcb0DA5n+tcTiO
	 ysvHG7dS0McmAJ8Uv2Vf9xtyGGqt6HLyix716XaprDMQc/VoTO2ncr4UE1jAPa2f7R
	 6hcC6IzUPtgv25qIG5C9KN4qmTsrwe0X1gqU2p/14CqVQWmzwYnWJBBJPKMtDuDcAi
	 +p3Q9yVj0r8xQ==
From: Niel Fourie <lusus@denx.de>
To: connman@lists.linux.dev
Cc: Niel Fourie <lusus@denx.de>
Subject: [PATCH] wifi: Duplicate GSupplicantSSID pointer members
Date: Fri, 11 Feb 2022 14:45:18 +0100
Message-Id: <20220211134518.3601268-1-lusus@denx.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean

In ssid_init(), the pointer members of GSupplicantSSID *ssid was
initialised to point to members of a connman_network, which get
freed and replaced, causing ssid's pointers to point to freed heap
memory. To mitigate this, these members are duplicated and then
freed and along with ssid when no longer needed.

Signed-off-by: Niel Fourie <lusus@denx.de>
---
 gsupplicant/supplicant.c | 41 ++++++++++++++++++--
 plugins/wifi.c           | 80 ++++++++++++++++++++++------------------
 2 files changed, 82 insertions(+), 39 deletions(-)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 470d99eb..e140b825 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -810,6 +810,32 @@ static void remove_peer(gpointer data)
 	g_free(peer);
 }
 
+static void remove_ssid(gpointer data)
+{
+	GSupplicantSSID *ssid = data;
+
+	if (ssid) {
+		g_free((void *) ssid->ssid);
+		g_free((char *) ssid->eap);
+		g_free((char *) ssid->passphrase);
+		g_free((char *) ssid->identity);
+		g_free((char *) ssid->anonymous_identity);
+		g_free((char *) ssid->ca_cert_path);
+		g_free((char *) ssid->subject_match);
+		g_free((char *) ssid->altsubject_match);
+		g_free((char *) ssid->domain_suffix_match);
+		g_free((char *) ssid->domain_match);
+		g_free((char *) ssid->client_cert_path);
+		g_free((char *) ssid->private_key_path);
+		g_free((char *) ssid->private_key_passphrase);
+		g_free((char *) ssid->phase2_auth);
+		g_free((char *) ssid->pin_wps);
+		g_free((char *) ssid->bgscan);
+
+		g_free(ssid);
+	}
+}
+
 static void debug_strvalmap(const char *label, struct strvalmap *map,
 							unsigned int val)
 {
@@ -4151,6 +4177,7 @@ done:
 	if (data->callback)
 		data->callback(err, NULL, data->user_data);
 
+	remove_ssid(data->ssid);
 	dbus_free(data);
 }
 
@@ -4469,7 +4496,7 @@ static void interface_select_network_result(const char *error,
 	if (data->callback)
 		data->callback(err, data->interface, data->user_data);
 
-	g_free(data->ssid);
+	remove_ssid(data->ssid);
 	dbus_free(data);
 }
 
@@ -4525,7 +4552,7 @@ error:
 	}
 
 	g_free(data->path);
-	g_free(data->ssid);
+	remove_ssid(data->ssid);
 	g_free(data);
 }
 
@@ -5030,7 +5057,7 @@ static void interface_wps_start_result(const char *error,
 		data->callback(err, data->interface, data->user_data);
 
 	g_free(data->path);
-	g_free(data->ssid);
+	remove_ssid(data->ssid);
 	dbus_free(data);
 }
 
@@ -5070,7 +5097,7 @@ static void wps_start(const char *error, DBusMessageIter *iter, void *user_data)
 	if (error) {
 		SUPPLICANT_DBG("error: %s", error);
 		g_free(data->path);
-		g_free(data->ssid);
+		remove_ssid(data->ssid);
 		dbus_free(data);
 		return;
 	}
@@ -5159,6 +5186,7 @@ int g_supplicant_interface_connect(GSupplicantInterface *interface,
 			 * type is 802.11x).
 			 */
 			if (compare_network_parameters(interface, ssid)) {
+				remove_ssid(ssid);
 				return -EALREADY;
 			}
 
@@ -5184,6 +5212,7 @@ int g_supplicant_interface_connect(GSupplicantInterface *interface,
 
 	if (ret < 0) {
 		g_free(data->path);
+		remove_ssid(data->ssid);
 		dbus_free(data);
 		return ret;
 	}
@@ -5234,6 +5263,7 @@ static void network_remove_result(const char *error,
 	} else {
 		if (data->callback)
 			data->callback(result, data->interface, data->user_data);
+		remove_ssid(data->ssid);
 	}
 	g_free(data->path);
 	dbus_free(data);
@@ -5287,6 +5317,7 @@ static void interface_disconnect_result(const char *error,
 							data->user_data);
 
 		g_free(data->path);
+		remove_ssid(data->ssid);
 		dbus_free(data);
 		return;
 	}
@@ -5299,10 +5330,12 @@ static void interface_disconnect_result(const char *error,
 	if (result != -ECONNABORTED) {
 		if (network_remove(data) < 0) {
 			g_free(data->path);
+			remove_ssid(data->ssid);
 			dbus_free(data);
 		}
 	} else {
 		g_free(data->path);
+		remove_ssid(data->ssid);
 		dbus_free(data);
 	}
 }
diff --git a/plugins/wifi.c b/plugins/wifi.c
index e947b169..2a933708 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2163,21 +2163,29 @@ static GSupplicantSecurity network_security(const char *security)
 static void ssid_init(GSupplicantSSID *ssid, struct connman_network *network)
 {
 	struct wifi_network *network_data = connman_network_get_data(network);
+	const char *ssid_blob;
 	const char *security;
 
 	memset(ssid, 0, sizeof(*ssid));
 	ssid->mode = G_SUPPLICANT_MODE_INFRA;
-	ssid->ssid = connman_network_get_blob(network, "WiFi.SSID",
-						&ssid->ssid_len);
+	ssid->ssid_len = 0;
+	ssid_blob =
+		connman_network_get_blob(network, "WiFi.SSID", &ssid->ssid_len);
+	ssid->ssid = g_try_malloc(ssid->ssid_len);
+	if (ssid->ssid)
+		memcpy((void *)ssid->ssid, ssid_blob, ssid->ssid_len);
+	else
+		ssid->ssid_len = 0;
+
 	ssid->scan_ssid = 1;
 	security = connman_network_get_string(network, "WiFi.Security");
 	ssid->security = network_security(security);
 	ssid->keymgmt = network_data->keymgmt;
 	ssid->ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
-	ssid->passphrase = connman_network_get_string(network,
-						"WiFi.Passphrase");
+	ssid->passphrase = g_strdup(
+		connman_network_get_string(network, "WiFi.Passphrase"));
 
-	ssid->eap = connman_network_get_string(network, "WiFi.EAP");
+	ssid->eap = g_strdup(connman_network_get_string(network, "WiFi.EAP"));
 
 	/*
 	 * If our private key password is unset,
@@ -2186,42 +2194,44 @@ static void ssid_init(GSupplicantSSID *ssid, struct connman_network *network)
 	 * cert may have to be provided.
 	 */
 	if (!connman_network_get_string(network, "WiFi.PrivateKeyPassphrase"))
-		connman_network_set_string(network,
-						"WiFi.PrivateKeyPassphrase",
-						ssid->passphrase);
+		connman_network_set_string(network, "WiFi.PrivateKeyPassphrase",
+					   ssid->passphrase);
 	/* We must have an identity for both PEAP and TLS */
-	ssid->identity = connman_network_get_string(network, "WiFi.Identity");
+	ssid->identity =
+		g_strdup(connman_network_get_string(network, "WiFi.Identity"));
 
 	/* Use agent provided identity as a fallback */
 	if (!ssid->identity || strlen(ssid->identity) == 0)
-		ssid->identity = connman_network_get_string(network,
-							"WiFi.AgentIdentity");
-
-	ssid->anonymous_identity = connman_network_get_string(network,
-						"WiFi.AnonymousIdentity");
-	ssid->ca_cert_path = connman_network_get_string(network,
-							"WiFi.CACertFile");
-	ssid->subject_match = connman_network_get_string(network,
-							"WiFi.SubjectMatch");
-	ssid->altsubject_match = connman_network_get_string(network,
-							"WiFi.AltSubjectMatch");
-	ssid->domain_suffix_match = connman_network_get_string(network,
-							"WiFi.DomainSuffixMatch");
-	ssid->domain_match = connman_network_get_string(network,
-							"WiFi.DomainMatch");
-	ssid->client_cert_path = connman_network_get_string(network,
-							"WiFi.ClientCertFile");
-	ssid->private_key_path = connman_network_get_string(network,
-							"WiFi.PrivateKeyFile");
-	ssid->private_key_passphrase = connman_network_get_string(network,
-						"WiFi.PrivateKeyPassphrase");
-	ssid->phase2_auth = connman_network_get_string(network, "WiFi.Phase2");
+		ssid->identity = g_strdup(connman_network_get_string(
+			network, "WiFi.AgentIdentity"));
+
+	ssid->anonymous_identity = g_strdup(
+		connman_network_get_string(network, "WiFi.AnonymousIdentity"));
+	ssid->ca_cert_path = g_strdup(
+		connman_network_get_string(network, "WiFi.CACertFile"));
+	ssid->subject_match = g_strdup(
+		connman_network_get_string(network, "WiFi.SubjectMatch"));
+	ssid->altsubject_match = g_strdup(
+		connman_network_get_string(network, "WiFi.AltSubjectMatch"));
+	ssid->domain_suffix_match = g_strdup(
+		connman_network_get_string(network, "WiFi.DomainSuffixMatch"));
+	ssid->domain_match = g_strdup(
+		connman_network_get_string(network, "WiFi.DomainMatch"));
+	ssid->client_cert_path = g_strdup(
+		connman_network_get_string(network, "WiFi.ClientCertFile"));
+	ssid->private_key_path = g_strdup(
+		connman_network_get_string(network, "WiFi.PrivateKeyFile"));
+	ssid->private_key_passphrase = g_strdup(connman_network_get_string(
+		network, "WiFi.PrivateKeyPassphrase"));
+	ssid->phase2_auth =
+		g_strdup(connman_network_get_string(network, "WiFi.Phase2"));
 
 	ssid->use_wps = connman_network_get_bool(network, "WiFi.UseWPS");
-	ssid->pin_wps = connman_network_get_string(network, "WiFi.PinWPS");
+	ssid->pin_wps =
+		g_strdup(connman_network_get_string(network, "WiFi.PinWPS"));
 
 	if (connman_setting_get_bool("BackgroundScanning"))
-		ssid->bgscan = BGSCAN_DEFAULT;
+		ssid->bgscan = g_strdup(BGSCAN_DEFAULT);
 }
 
 static int network_connect(struct connman_network *network)
@@ -2246,12 +2256,12 @@ static int network_connect(struct connman_network *network)
 
 	interface = wifi->interface;
 
-	ssid_init(ssid, network);
-
 	if (wifi->disconnecting) {
 		wifi->pending_network = network;
 		g_free(ssid);
 	} else {
+		ssid_init(ssid, network);
+
 		wifi->network = connman_network_ref(network);
 		wifi->retries = 0;
 
-- 
2.34.1

