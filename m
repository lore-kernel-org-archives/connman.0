Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5E152DE0
	for <connman@lists.linux.dev>; Wed, 27 Mar 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568623; cv=none; b=pngzIJLG4tPRIBx4HJ8fZqH+26kBIapt5/6rTe3sqGRXJY4XI1zs6iZLUU4lwpY5tPbGAVrT331aiuSQ6ZarrZBf01Uo/HPeqzX3Xj8pV/2WCzb8Marpj49B9CqPZe6YpFH2uUq/kCkQV+ZjzDEst2y83bBjCjFTScrvUFV1Z3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568623; c=relaxed/simple;
	bh=Eg8TmbCbDF2KgfeGlwiJ2epl1pEiFLq2+uN53c8ZeDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyFIkkfj3UfSsVYLNTS/nvlhjYP4oKQYBgHyPqmEqwhNehTEtmwx/h2UHo+mmFfR8YRajlub3i81b+egV/Iy/bvso7Uh8iJjr3ah/z4ts23ZmvbHzn1aay3eh9gC1PVa/U6iIVbpoisp/D6PlXIs0XQ5qrrit5zCuNMvYvpyJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsPyAfWy; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsPyAfWy"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e69a9c0eaeso120218a34.3
        for <connman@lists.linux.dev>; Wed, 27 Mar 2024 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711568621; x=1712173421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMwuEd0tiDAgZZHf3MwZpbVZAuvcjSJiti3ykzNut7E=;
        b=HsPyAfWyUwdzoaDCashBZ/9dyFggpYMQfSO239vPKf4Ked6y6IjdLD6L6fbwzRVW8R
         Jv+C4l+ZstIIA1+ahIVSXeVZFh0aIpDfLuz+ZJTady9QT5A6+E+5lmO0uq2Z1YnoB0so
         6gM9zaBHQNYwXY90BG+3o9LSp2jC7k9P+OHV/fxQlWr+zKLjP2j7qX/VPrTaDGC5Mz/v
         HAgV+/4slfxMgEHn6M01B9r0XuH0q0bmifveXHpmtQtAn7Z6MWH7NEM481iG8NHALIE7
         BhFOt27c2j6sn55mRtfTWNYetvatwOCdPQjIoNJc/zU8EVsS8sXB5zGNTaxROJcOKzCU
         Ip7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568621; x=1712173421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMwuEd0tiDAgZZHf3MwZpbVZAuvcjSJiti3ykzNut7E=;
        b=af8vmKQ2csk255oFg8NjgVukauma5ln8sX64cs3h2SkuIznqfG8GpiVyCvzEi6SzzD
         RsmZMPUTDJZV5WcFNpcZOmte0uzHetnUoOJ5JGNQeXSA6l29kKkbJsL1D/sTlYCvsPPX
         IuWDM6ugqIUq3K901bEF2WLL8r81MGzoGmGt4jVXae69C3tUjw1IqTrSa5oopV6xDAN3
         Sia4e5q9JzdbBayYczGoUqWa2gI4gQPcsMxbrC1C9soZ/kToeJPgNMTlsZBT3FCaqxWW
         wBgZLFijswSuyk3eyV2SqdDOGKCTA6pHU8k1EVnMfIlK+6IZSojT03xZE5JpE6i3SWDm
         pzvQ==
X-Gm-Message-State: AOJu0Yyf8/RyJKx+Fl5haotEe67wUAsFBDQbK5Z3K+hnw3NyZvCW/Zdg
	amhLV2LTGSHPGrQ9FY2m9Vy7qhyP6puiV/N8Kx2xd7CE8dfR5e6TTEAqt4pd
X-Google-Smtp-Source: AGHT+IH+Tp2/au4ZXZLI9eF5ItBazvGjh5+iKBcPdfTLXnW0hWW63SX8gpfxQTTz/7W+UtCCfGCsng==
X-Received: by 2002:a9d:650d:0:b0:6e5:3ce1:51ea with SMTP id i13-20020a9d650d000000b006e53ce151eamr1022236otl.18.1711568620982;
        Wed, 27 Mar 2024 12:43:40 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id f22-20020a056830205600b006e6cb624064sm1876919otp.40.2024.03.27.12.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:43:40 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/4] ofono: combine create_device and ready_to_create_device
Date: Wed, 27 Mar 2024 14:43:34 -0500
Message-ID: <20240327194337.2735677-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327194337.2735677-1-denkenz@gmail.com>
References: <20240327194337.2735677-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two functions are called one after the other, repeating the same
comment in multiple places.  Combine them into a single function that
takes care of checking whether the device can be created, and if so,
creating it.  Move the repeated comment to the new function.

While here, refactor handling of 'ident' which removes the need for the
'out' label.  Also, simplify some logic left over from CDMA support that
was checking whether modem->imsi exists.
---
 plugins/ofono.c | 75 ++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index fd8b442a674c..ad85c55d3df3 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -957,57 +957,56 @@ out:
 
 /*
  * This functions tests if we have the necessary information gathered
- * before we are able to create a device.
+ * in order to create the device.
  */
-static bool ready_to_create_device(struct modem_data *modem)
+static bool try_create_device(struct modem_data *modem)
 {
+	struct connman_device *device;
+	char *ident;
+
+	DBG("%s", modem->path);
+
 	if (modem->device)
 		return false;
 
 	if (!modem->imsi)
 		return false;
 
-	return true;
-}
-
-static void create_device(struct modem_data *modem)
-{
-	struct connman_device *device;
-	char *ident = NULL;
 
-	DBG("%s", modem->path);
+	/*
+	 * Create the device and register it at the core. Enabling (setting
+	 * it online is done through the modem_enable() callback.
+	 */
+	device = connman_device_create("ofono", CONNMAN_DEVICE_TYPE_CELLULAR);
+	if (!device) {
+		connman_error("Failed to create device for modem on path: %s",
+				modem->path);
+		return false;
+	}
 
-	if (modem->imsi)
-		ident = modem->imsi;
+	DBG("created device %p", device);
 
-	if (!connman_dbus_validate_ident(ident))
-		ident = connman_dbus_encode_string(ident);
+	if (!connman_dbus_validate_ident(modem->imsi))
+		ident = connman_dbus_encode_string(modem->imsi);
 	else
-		ident = g_strdup(ident);
-
-	device = connman_device_create("ofono", CONNMAN_DEVICE_TYPE_CELLULAR);
-	if (!device)
-		goto out;
-
-	DBG("device %p", device);
+		ident = g_strdup(modem->imsi);
 
 	connman_device_set_ident(device, ident);
+	g_free(ident);
 
 	connman_device_set_string(device, "Path", modem->path);
-
 	connman_device_set_data(device, modem);
 
 	if (connman_device_register(device) < 0) {
-		connman_error("Failed to register cellular device");
+		connman_error("Failed to register cellular device %p", device);
 		connman_device_unref(device);
-		goto out;
+		return false;
 	}
 
 	modem->device = device;
-
 	connman_device_set_powered(modem->device, modem->online);
-out:
-	g_free(ident);
+
+	return true;
 }
 
 static void destroy_device(struct modem_data *modem)
@@ -1835,17 +1834,7 @@ static gboolean sim_changed(DBusConnection *conn, DBusMessage *message,
 
 	if (g_str_equal(key, "SubscriberIdentity")) {
 		sim_update_imsi(modem, &value);
-
-		if (!ready_to_create_device(modem))
-			return TRUE;
-
-		/*
-		 * This is a GSM modem. Create the device and
-		 * register it at the core. Enabling (setting
-		 * it online is done through the
-		 * modem_enable() callback.
-		 */
-		create_device(modem);
+		try_create_device(modem);
 	}
 
 	return TRUE;
@@ -1869,17 +1858,9 @@ static void sim_properties_reply(struct modem_data *modem,
 		if (g_str_equal(key, "SubscriberIdentity")) {
 			sim_update_imsi(modem, &value);
 
-			if (!ready_to_create_device(modem))
+			if (!try_create_device(modem))
 				return;
 
-			/*
-			 * This is a GSM modem. Create the device and
-			 * register it at the core. Enabling (setting
-			 * it online is done through the
-			 * modem_enable() callback.
-			 */
-			create_device(modem);
-
 			if (!modem->online)
 				return;
 
-- 
2.43.0

