Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE21A33
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 09:11:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C8895D27D;
	Fri,  4 Mar 2022 10:11:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646385067; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Z35mCGiKYSdB0CGz9m4Yel6QqTFOGDIyy7zS9UPoMCE=;
	b=QcF64fHzOTTpvoPu92a7FnVMXaQaU5yoqumGqnbmWHzlfuzQHO9C87xLPxu/uVHQt0iGDY
	cpFPIotr1LY9wZdyeas/M4hjUQ8tVnz0ft3BTnNN7k3wIkz+Ch8R96azqGKYfhc5b4jMPO
	a/tR2wiY47yVc87U8EIZTCxQpXcXOFltwIwhsTyObvnmZCDJy67Yqo9pje0qbQlRTXBFBm
	5n8wjC/+C6sreki4PeJHPn6wNo9qqbAOXIO+Rsim7ApR+aPuaBQKPF1nYd5UqUOvJPHYNx
	RamiyhtlmjbwFXTRQM6VD0/uzjJN5JBz8Ic8ehgsRhB30951ngZSL0DLX1gP1g==
Date: Fri, 4 Mar 2022 10:11:04 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: request for feature
Message-ID: <20220304091104.g5lbeu55z4oubyej@beryllium.lan>
References: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Mar 03, 2022 at 04:41:36PM -0600, KeithG wrote:
> Group,
> 
> iwd has recently added a feature which can allow headless wireless
> configuration:
> 
> client: add AP scanning support to iwctl
> 
> Would it be acceptable or possible to add the possibility to do a
> 'connmanctl scan' when iwd is configured as AP? Currently, connman
> does not work with iwd in this mode. This addition would allow us to
> ditch hostapd for the headless music player we are working on.
> Currently we use connman with iwd for normal connections, but when we
> are trying to do headless wireless configuration, we fire up
> hostapd/dnsmasq. We would like to just use connman and iwd if
> possible.

plugins/iwd.c:cm_device_scan() needs to be extended to use the new iwd
API net.connman.iwd.AccessPoint Scan(). Shouldn't be too complex to do.

Completely untested:

diff --git a/plugins/iwd.c b/plugins/iwd.c
index ee3ed83e5957..0704945d3e88 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -591,7 +591,7 @@ static int cm_device_disable(struct connman_device *device)
 	return set_device_powered(device, false);
 }
 
-static void cm_device_scan_cb(DBusMessage *message, void *user_data)
+static void cm_device_scan_station_cb(DBusMessage *message, void *user_data)
 {
 	const char *path = user_data;
 	struct iwd_station *iwds;
@@ -607,22 +607,52 @@ static void cm_device_scan_cb(DBusMessage *message, void *user_data)
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
+	if (strcmp(iwdd->mode, "station")) {
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
+	} else if (strcmp(iwdd->mode, "AP")) {
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
