Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212B38E2
	for <connman@lists.linux.dev>; Mon,  7 Mar 2022 09:03:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 617AD5CD07;
	Mon,  7 Mar 2022 10:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646643806; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5kYo0zUAqFpmLvv65IgLmSOEqgb2oyBYF5NEDh44/m4=;
	b=00NtlX82kBhU/OBu++9HnYiRBnXe8hb3XxhfqdqDEyCGnPrvYwki6i5duBe/nLtilTFIbe
	m7vb2XJSooTz+K19OpeQ21geHAzF6FGsfXnFl/66XkTEediZAFIucr6lZRAclIW2YDOIB5
	Fw2RKjB6XZhcU0On+V88Kh/F2wp7TfWNBv+KCVVRgZnh0zwULrR0mSCM6l/D38iAFNgpQc
	o62bqa5yQk2klFVeI5Y+jsvZLr2SdHRpSGGTplLFyKN5fBmNR2hnFJkXYsBfYiwI7ddk4+
	WLqDEFBl5rZ2xsqqqb92Xpjns7pXLuSUOalzNCShFsCVli094SxF8ApnsSwFsg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] iwd: Add scan support in access point mode
Date: Mon,  7 Mar 2022 10:03:21 +0100
Message-Id: <20220307090321.27204-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

---
 plugins/iwd.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 8974e6645295..5b3ebd3bfee8 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -550,7 +550,7 @@ static int cm_device_disable(struct connman_device *device)
 	return set_device_powered(device, false);
 }
 
-static void cm_device_scan_cb(DBusMessage *message, void *user_data)
+static void cm_device_scan_station_cb(DBusMessage *message, void *user_data)
 {
 	const char *path = user_data;
 	struct iwd_station *iwds;
@@ -566,22 +566,52 @@ static void cm_device_scan_cb(DBusMessage *message, void *user_data)
 	}
 }
 
+static void cm_device_scan_ap_cb(DBusMessage *message, void *user_data)
+{
+	const char *path = user_data;
+	struct iwd_ap *iwdap;
+
+	iwdap = g_hash_table_lookup(access_points, path);
+	if (!iwdap)
+		return;
+
+	if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_ERROR) {
+		const char *dbus_error = dbus_message_get_error_name(message);
+
+		DBG("%s scan failed: %s", path, dbus_error);
+	}
+}
+
 static int cm_device_scan(struct connman_device *device,
 				struct connman_device_scan_params *params)
 {
 	struct iwd_device *iwdd = connman_device_get_data(device);
-	struct iwd_station *iwds;
 
-	if (strcmp(iwdd->mode, "station"))
-		return -EINVAL;
+	if (!strcmp(iwdd->mode, "station")) {
+		struct iwd_station *iwds;
 
-	iwds = g_hash_table_lookup(stations, iwdd->path);
-	if (!iwds)
-		return -EIO;
+		iwds =	g_hash_table_lookup(stations, iwdd->path);
+		if (!iwds)
+			return -EIO;
 
-	if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",
-			NULL, cm_device_scan_cb, g_strdup(iwds->path), g_free))
-		return -EIO;
+		if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",
+				NULL, cm_device_scan_station_cb,
+				g_strdup(iwds->path), g_free))
+			return -EIO;
+	} else if (!strcmp(iwdd->mode, "ap")) {
+		struct iwd_ap *iwdap;
+
+		iwdap = g_hash_table_lookup(access_points, iwdd->path);
+		if (!iwdap)
+			return -EIO;
+
+		if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
+				NULL, cm_device_scan_ap_cb,
+				g_strdup(iwdap->path), g_free))
+			return -EIO;
+	} else {
+		return -EINVAL;
+	}
 
 	return -EINPROGRESS;
 }
-- 
2.35.1

