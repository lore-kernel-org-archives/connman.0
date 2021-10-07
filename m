Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA42C83
	for <connman@lists.linux.dev>; Thu,  7 Oct 2021 21:30:26 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id t2so23177820wrb.8
        for <connman@lists.linux.dev>; Thu, 07 Oct 2021 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eITekxS1W1FqDKXgfVZ5sfvKQuBe7k5AOcd0mvh8pGc=;
        b=mYDh+Vv2hm4Q9bXEywq3Re8nD54TAsX29yJd5+y2Ee4SK0Juoi0c23WGpaSxV9g+B8
         bMfsJWErzNCc058kqyEEWmBwaGJqxTS199KeAbtLGUnMvlsywF4pW2BLWQXl+5XFfqJW
         hQwTv8vlp+X+nMry04wRvPi8RMJjW/y9hZKR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eITekxS1W1FqDKXgfVZ5sfvKQuBe7k5AOcd0mvh8pGc=;
        b=Eq612TMLFrOaF66BJpzYOMrKyl8bSt0ddqjCpIpGamDFp8UiQ/Y2pggCDKDKRtOU2a
         biAHmj2G4AG3oEUF6lQRakNPRuz5vAytx0t2GY25HZIFtOyc3TrSVQW5oNJdcakeYJxw
         fDNrqKHA8w3J+nfnyAX3qjLlkoG6KzjaW7t030rSxQohe8S2oLqXrDl3JH3Jf5r+fVro
         o+dNsdGWfgimDL3BkrJKQBTl7AJk8CdzYGfj2rxoFS6OPru8ROlTctaXYqD/3F4B4c+d
         bBkEMvo38Fs1mkB9XcXcDeyIQ8Vkqq/6Ys9aw48QDqreUiH8sIyr4zNuzNnDwrHdAKER
         foJA==
X-Gm-Message-State: AOAM533lqo7vgWkrfT4iMli/HqKBYM5vVLy/v19HufSjxa/BGvCOXUqd
	ypy7SsHO/5uoLllYUDAqyMu418D89PM1YuiV
X-Google-Smtp-Source: ABdhPJx3m6Kot+9t4oFVttU3uvnhu0I3aIgSZM8S9+AIymSwTyzvqRjHGpfw8SjLGcKuoZku9SoL6Q==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr7246322wmq.95.1633642224716;
        Thu, 07 Oct 2021 14:30:24 -0700 (PDT)
Received: from localhost.localdomain ([109.52.197.122])
        by smtp.gmail.com with ESMTPSA id a17sm497068wrx.33.2021.10.07.14.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:30:24 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH 1/4] tethering: Reduce the number of parameters of tech_set_tethering
Date: Thu,  7 Oct 2021 23:30:18 +0200
Message-Id: <20211007213021.58712-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

connman_echnology is an opaque type but has all the parameters to handle
the connection. Those parameters are only used in wifi tethering
one and not in other technologies

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 include/technology.h |  8 ++++++--
 plugins/bluetooth.c  |  1 -
 plugins/ethernet.c   |  1 -
 plugins/gadget.c     |  1 -
 plugins/wifi.c       | 25 ++++++++++++-------------
 src/technology.c     | 20 ++++++++++++--------
 6 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/include/technology.h b/include/technology.h
index 7508a9a1..7febd109 100644
--- a/include/technology.h
+++ b/include/technology.h
@@ -44,8 +44,13 @@ void connman_technology_regdom_notify(struct connman_technology *technology,
 
 enum connman_service_type connman_technology_get_type
 				(struct connman_technology *technology);
+
+bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
+						const char **ssid, const char **psk);
+
 bool connman_technology_get_wifi_tethering(const char **ssid,
-							const char **psk);
+						const char **psk);
+
 bool connman_technology_is_tethering_allowed(enum connman_service_type type);
 
 struct connman_technology_driver {
@@ -60,7 +65,6 @@ struct connman_technology_driver {
 	void (*remove_interface) (struct connman_technology *technology,
 								int index);
 	int (*set_tethering) (struct connman_technology *technology,
-				const char *identifier, const char *passphrase,
 				const char *bridge, bool enabled);
 	int (*set_regdom) (struct connman_technology *technology,
 						const char *alpha2);
diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 53361034..57cc8a29 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -882,7 +882,6 @@ static void bluetooth_tech_remove(struct connman_technology *technology)
 }
 
 static int bluetooth_tech_set_tethering(struct connman_technology *technology,
-		const char *identifier, const char *passphrase,
 		const char *bridge, bool enabled)
 {
 	GHashTableIter hash_iter;
diff --git a/plugins/ethernet.c b/plugins/ethernet.c
index 6146b1c0..0bf7fc41 100644
--- a/plugins/ethernet.c
+++ b/plugins/ethernet.c
@@ -407,7 +407,6 @@ static void eth_tech_disable_tethering(struct connman_technology *technology,
 }
 
 static int eth_tech_set_tethering(struct connman_technology *technology,
-				const char *identifier, const char *passphrase,
 				const char *bridge, bool enabled)
 {
 	if (!connman_technology_is_tethering_allowed(
diff --git a/plugins/gadget.c b/plugins/gadget.c
index 1b44bbb5..2d58df3e 100644
--- a/plugins/gadget.c
+++ b/plugins/gadget.c
@@ -294,7 +294,6 @@ static void gadget_tech_disable_tethering(struct connman_technology *technology,
 }
 
 static int gadget_tech_set_tethering(struct connman_technology *technology,
-				const char *identifier, const char *passphrase,
 				const char *bridge, bool enabled)
 {
 	DBG("bridge %s enabled %d", bridge, enabled);
diff --git a/plugins/wifi.c b/plugins/wifi.c
index 578b4be7..cebe6886 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -183,7 +183,6 @@ static bool wfd_service_registered = false;
 
 static void start_autoscan(struct connman_device *device);
 static int tech_set_tethering(struct connman_technology *technology,
-				const char *identifier, const char *passphrase,
 				const char *bridge, bool enabled);
 
 static int p2p_tech_probe(struct connman_technology *technology)
@@ -2791,8 +2790,6 @@ static void ap_create_fail(GSupplicantInterface *interface)
 		wifi->tethering = false;
 
 		ret = tech_set_tethering(wifi->tethering_param->technology,
-				wifi->tethering_param->ssid->ssid,
-				wifi->tethering_param->ssid->passphrase,
 				wifi->bridge, true);
 
 		if ((ret == -EOPNOTSUPP) && (wifi_technology)) {
@@ -3336,14 +3333,20 @@ static void tech_remove(struct connman_technology *technology)
 	wifi_technology = NULL;
 }
 
-static GSupplicantSSID *ssid_ap_init(const char *ssid, const char *passphrase)
+static GSupplicantSSID *ssid_ap_init(const struct connman_technology *technology)
 {
 	GSupplicantSSID *ap;
+	const char *ssid, *passphrase;
+	bool ret;
 
 	ap = g_try_malloc0(sizeof(GSupplicantSSID));
 	if (!ap)
 		return NULL;
 
+	ret = connman_get_wifi_tethering_from_technology(technology, &ssid, &passphrase);
+	if (ret == false)
+		return NULL;
+
 	ap->mode = G_SUPPLICANT_MODE_MASTER;
 	ap->ssid = ssid;
 	ap->ssid_len = strlen(ssid);
@@ -3458,8 +3461,7 @@ static void sta_remove_callback(int result,
 }
 
 static int enable_wifi_tethering(struct connman_technology *technology,
-				const char *bridge, const char *identifier,
-				const char *passphrase, bool available)
+				const char *bridge, bool available)
 {
 	GList *list;
 	GSupplicantInterface *interface;
@@ -3512,14 +3514,14 @@ static int enable_wifi_tethering(struct connman_technology *technology,
 		info->wifi = wifi;
 		info->technology = technology;
 		info->wifi->bridge = bridge;
-		info->ssid = ssid_ap_init(identifier, passphrase);
+		info->ssid = ssid_ap_init(technology);
 		if (!info->ssid)
 			goto failed;
 
 		info->ifname = g_strdup(ifname);
 
 		wifi->tethering_param->technology = technology;
-		wifi->tethering_param->ssid = ssid_ap_init(identifier, passphrase);
+		wifi->tethering_param->ssid = ssid_ap_init(technology);
 		if (!wifi->tethering_param->ssid)
 			goto failed;
 
@@ -3561,7 +3563,6 @@ static int enable_wifi_tethering(struct connman_technology *technology,
 }
 
 static int tech_set_tethering(struct connman_technology *technology,
-				const char *identifier, const char *passphrase,
 				const char *bridge, bool enabled)
 {
 	GList *list;
@@ -3589,13 +3590,11 @@ static int tech_set_tethering(struct connman_technology *technology,
 	}
 
 	DBG("trying tethering for available devices");
-	err = enable_wifi_tethering(technology, bridge, identifier, passphrase,
-				true);
+	err = enable_wifi_tethering(technology, bridge, true);
 
 	if (err < 0) {
 		DBG("trying tethering for any device");
-		err = enable_wifi_tethering(technology, bridge, identifier,
-					passphrase, false);
+		err = enable_wifi_tethering(technology, bridge, false);
 	}
 
 	return err;
diff --git a/src/technology.c b/src/technology.c
index 672d6ea8..e0457890 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -264,8 +264,7 @@ static int set_tethering(struct connman_technology *technology,
 		if (!driver || !driver->set_tethering)
 			continue;
 
-		err = driver->set_tethering(technology, ident, passphrase,
-				bridge, enabled);
+		err = driver->set_tethering(technology, bridge, enabled);
 
 		if (result == -EINPROGRESS)
 			continue;
@@ -356,8 +355,16 @@ enum connman_service_type connman_technology_get_type
 	return technology->type;
 }
 
-bool connman_technology_get_wifi_tethering(const char **ssid,
-							const char **psk)
+bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
+						const char **ssid, const char **psk)
+{
+	*ssid = technology->tethering_ident;
+	*psk = technology->tethering_passphrase;
+
+	return true;
+}
+
+bool connman_technology_get_wifi_tethering(const char **ssid, const char **psk)
 {
 	struct connman_technology *technology;
 
@@ -373,10 +380,7 @@ bool connman_technology_get_wifi_tethering(const char **ssid,
 	if (!technology->tethering)
 		return false;
 
-	*ssid = technology->tethering_ident;
-	*psk = technology->tethering_passphrase;
-
-	return true;
+	return connman_get_wifi_tethering_from_technology(technology, ssid, psk);
 }
 
 static void free_rfkill(gpointer data)
-- 
2.25.1

