Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52781363
	for <connman@lists.linux.dev>; Mon, 16 Jan 2023 08:16:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EC9ADACFA;
	Mon, 16 Jan 2023 09:16:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1673856989; h=from:reply-to:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=I/kEIdRzvI6Hh67RIW4k7NvXOOYg9R/nG0ubCVELO44=;
	b=aBPDed/1wj5fkXBoTovt7SQ0h/0lRLOl6fTJTJgZkMEfEfgD8EqAJ50KMMFrWwJPzp4Eok
	08wEZi3TzJUfsH31qOa7p7bBBs8DEJIFEUL7uEiFdOltzdVDsNtYi3Sk/45wRpqP9YRnCJ
	nK47+8omj1e60kLyhb0ObsVzhUE/dQhwLbaI23vpvFgbQFOEFn6cqrTJf7RaWeBUiUC8AX
	pvF2van0LQMJmYiuI31GmXnawCiOie7jYkAvfJB5QVIMKKRgjl3/Ft2OtGxrFj7wpcRZRf
	eOCem3xUbMMgT2OYreQbcdSZHPnyp9RJjwsTw6ECweshyPw0BMZ3DHaSDyr/uA==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] iwd: Add support to Scan in AP mode
Date: Mon, 16 Jan 2023 09:16:24 +0100
Message-Id: <20230116081624.12618-1-wagi@monom.org>
Reply-To: 20230116073300.hy6spqhqitohj3eu@beryllium.lan
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

iwd support scanning in AccessPoint mode, thus forward scan requests
also when the device is in AccessPoint mode.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---

Only compile tested :)

 plugins/iwd.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 2fe49a23316b..491a0e41da89 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -633,15 +633,28 @@ static void cm_device_scan_cb(DBusMessage *message, void *user_data)
 	}
 }
 
-static int cm_device_scan(struct connman_device *device,
-				struct connman_device_scan_params *params)
+static void cm_ap_scan_cb(DBusMessage *message, void *user_data)
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
+static int cm_station_scan(struct connman_device *device,
+				struct connman_device_scan_params *param)
 {
 	struct iwd_device *iwdd = connman_device_get_data(device);
 	struct iwd_station *iwds;
 
-	if (strcmp(iwdd->mode, "station"))
-		return -EINVAL;
-
 	iwds = g_hash_table_lookup(stations, iwdd->path);
 	if (!iwds)
 		return -EIO;
@@ -653,6 +666,37 @@ static int cm_device_scan(struct connman_device *device,
 	return -EINPROGRESS;
 }
 
+static int cm_ap_scan(struct connman_device *device,
+				struct connman_device_scan_params *param)
+{
+	struct iwd_device *iwdd = connman_device_get_data(device);
+	struct iwd_ap *iwdap;
+
+	iwdap = g_hash_table_lookup(access_points, iwdd->path);
+	if (!iwdap)
+		return -EIO;
+
+	if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
+			NULL, cm_ap_scan_cb, g_strdup(iwdap->path), g_free))
+		return -EIO;
+
+	return -EINPROGRESS;
+}
+
+static int cm_device_scan(struct connman_device *device,
+				struct connman_device_scan_params *params)
+{
+	struct iwd_device *iwdd = connman_device_get_data(device);
+
+	if (!strcmp(iwdd->mode, "station"))
+		return cm_station_scan(device, params);
+
+	if (!strcmp(iwdd->mode, "ap"))
+		return cm_ap_scan(device, params);
+
+	return -EINVAL;
+}
+
 static struct connman_device_driver device_driver = {
 	.name		= "iwd",
 	.type		= CONNMAN_DEVICE_TYPE_WIFI,
-- 
2.39.0

