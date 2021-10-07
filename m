Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301E2C94
	for <connman@lists.linux.dev>; Thu,  7 Oct 2021 21:30:28 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id k7so23064409wrd.13
        for <connman@lists.linux.dev>; Thu, 07 Oct 2021 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M+mtFM4CwI6kBtiCEp0TXG29Mb7gMbYNuGl0pnbHEB8=;
        b=hEgPHs8SSTHlDnWQIbcjOViW+bpvrcwy4u7c3DwHWKKot9x77xifjqIrzQ6iihYoHw
         H+Xcd/QCbNKVhxNE8j3bquT9Q/qUyc5TxR+dgz5f3SUds2ovySEDmihvj7bSv7cTFbfs
         Fy36ZUARjxP0cTDH2gy33uftOeNkkJc/VO750=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+mtFM4CwI6kBtiCEp0TXG29Mb7gMbYNuGl0pnbHEB8=;
        b=OZFtHAUjlGk5y2NGHdGb6TM6jgYMCkUFUU6HoqyJdLI5dhA9Oujp7hWmtWqtag3wnc
         JSwbuLvOwydcHoFggxiwLc/weax7p2wBNv88tZy1arY4t7sq7dQ7OO41461xRKW8kYgt
         4nN6h5nheoD1nwjw5BeD/pheO9hafSIEryt1ekHUlMCkrnQaH2KIP4ZouyIt8iFYB9Sv
         swD+kT23k9vKI7cnoIrED9QrWsf/aySBFgx0U/2CT8iroGMYiYTl0MYEvYHGwkIag3qL
         el6SOinD8j1C6j62gBYMLAZljh7KyfzScI9o/CZwFa2em69v92T+mJp2fj08pc5lanIG
         3Omg==
X-Gm-Message-State: AOAM532LUPfpxthSi8gy1W53FcNL3hfwEQIMD7G0fFPhlTHogEpvZnfL
	UQoEobzduapZvpjpVAfh0dPi4+CGcUXHzDrS
X-Google-Smtp-Source: ABdhPJzBT8POf2ThAt5R4saJP3sdwxIBMQWfve1WASMneM7BVpoqGptB8N34FJNY7+hgHwyrVqQItQ==
X-Received: by 2002:adf:8bca:: with SMTP id w10mr8326153wra.43.1633642226078;
        Thu, 07 Oct 2021 14:30:26 -0700 (PDT)
Received: from localhost.localdomain ([109.52.197.122])
        by smtp.gmail.com with ESMTPSA id a17sm497068wrx.33.2021.10.07.14.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:30:25 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH 2/4] tethering: Add possibility to configure the access point frequency
Date: Thu,  7 Oct 2021 23:30:19 +0200
Message-Id: <20211007213021.58712-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007213021.58712-1-michael@amarulasolutions.com>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the tethering mode is started, a WiFi ap is created using the fixed
channel 1 (2412 MHz). Add a way to configure the channel

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 include/technology.h |  4 ++--
 plugins/neard.c      |  3 ++-
 plugins/wifi.c       |  9 +++++++--
 src/technology.c     | 45 +++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/include/technology.h b/include/technology.h
index 7febd109..d89c8164 100644
--- a/include/technology.h
+++ b/include/technology.h
@@ -46,10 +46,10 @@ enum connman_service_type connman_technology_get_type
 				(struct connman_technology *technology);
 
 bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
-						const char **ssid, const char **psk);
+						const char **ssid, const char **psk, int *freq);
 
 bool connman_technology_get_wifi_tethering(const char **ssid,
-						const char **psk);
+						const char **psk, int *freq);
 
 bool connman_technology_is_tethering_allowed(enum connman_service_type type);
 
diff --git a/plugins/neard.c b/plugins/neard.c
index 45effd44..b0cdbde0 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -222,10 +222,11 @@ static DBusMessage *create_request_oob_reply(DBusMessage *message)
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	const char *ssid, *psk;
+	int freq;
 	uint8_t *tlv_msg;
 	int length;
 
-	if (!connman_technology_get_wifi_tethering(&ssid, &psk))
+	if (!connman_technology_get_wifi_tethering(&ssid, &psk, &freq))
 		return get_reply_on_error(message, ENOTSUP);
 
 	tlv_msg = encode_to_tlv(ssid, psk, &length);
diff --git a/plugins/wifi.c b/plugins/wifi.c
index cebe6886..4f859e31 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -3337,13 +3337,15 @@ static GSupplicantSSID *ssid_ap_init(const struct connman_technology *technology
 {
 	GSupplicantSSID *ap;
 	const char *ssid, *passphrase;
+	int freq;
 	bool ret;
 
 	ap = g_try_malloc0(sizeof(GSupplicantSSID));
 	if (!ap)
 		return NULL;
 
-	ret = connman_get_wifi_tethering_from_technology(technology, &ssid, &passphrase);
+	ret = connman_get_wifi_tethering_from_technology(technology, &ssid, &passphrase,
+							 &freq);
 	if (ret == false)
 		return NULL;
 
@@ -3351,7 +3353,10 @@ static GSupplicantSSID *ssid_ap_init(const struct connman_technology *technology
 	ap->ssid = ssid;
 	ap->ssid_len = strlen(ssid);
 	ap->scan_ssid = 0;
-	ap->freq = 2412;
+	if (freq)
+		ap->freq = freq;
+	else
+		ap->freq = 2412;
 
 	if (!passphrase || strlen(passphrase) == 0) {
 		ap->security = G_SUPPLICANT_SECURITY_NONE;
diff --git a/src/technology.c b/src/technology.c
index e0457890..7d5f6a4b 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -66,6 +66,7 @@ struct connman_technology {
 					      */
 	char *tethering_ident;
 	char *tethering_passphrase;
+	int tethering_freq;
 
 	bool enable_persistent; /* Save the tech state */
 
@@ -192,6 +193,13 @@ static void technology_save(struct connman_technology *technology)
 		g_free(enc);
 	}
 
+	if (technology->tethering_freq == 0)
+		technology->tethering_freq = 2412;
+
+	g_key_file_set_integer(keyfile, identifier,
+				"Tethering.Freq",
+				technology->tethering_freq);
+
 done:
 	g_free(identifier);
 
@@ -356,15 +364,17 @@ enum connman_service_type connman_technology_get_type
 }
 
 bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
-						const char **ssid, const char **psk)
+						const char **ssid, const char **psk, int *freq)
 {
 	*ssid = technology->tethering_ident;
 	*psk = technology->tethering_passphrase;
+	*freq = technology->tethering_freq;
 
 	return true;
 }
 
-bool connman_technology_get_wifi_tethering(const char **ssid, const char **psk)
+bool connman_technology_get_wifi_tethering(const char **ssid,
+					const char **psk, int *freq)
 {
 	struct connman_technology *technology;
 
@@ -380,7 +390,7 @@ bool connman_technology_get_wifi_tethering(const char **ssid, const char **psk)
 	if (!technology->tethering)
 		return false;
 
-	return connman_get_wifi_tethering_from_technology(technology, ssid, psk);
+	return connman_get_wifi_tethering_from_technology(technology, ssid, psk, freq);
 }
 
 static void free_rfkill(gpointer data)
@@ -447,6 +457,10 @@ static void technology_load(struct connman_technology *technology)
 				identifier, "Tethering.Passphrase", NULL);
 	if (enc)
 		technology->tethering_passphrase = g_strcompress(enc);
+
+	technology->tethering_freq = g_key_file_get_integer(keyfile,
+				identifier, "Tethering.Freq", NULL);
+
 done:
 	g_free(identifier);
 
@@ -558,6 +572,10 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_STRING,
 					&technology->tethering_passphrase);
 
+	connman_dbus_dict_append_basic(&dict, "TetheringFreq",
+				DBUS_TYPE_INT32,
+				&technology->tethering_freq);
+
 	connman_dbus_dict_close(iter, &dict);
 }
 
@@ -972,6 +990,27 @@ static DBusMessage *set_property(DBusConnection *conn,
 					DBUS_TYPE_STRING,
 					&technology->tethering_passphrase);
 		}
+	} else if (g_str_equal(name, "TetheringFreq")) {
+		dbus_int32_t freq;
+
+		if (type != DBUS_TYPE_INT32)
+			return __connman_error_invalid_arguments(msg);
+
+		dbus_message_iter_get_basic(&value, &freq);
+
+		if (technology->type != CONNMAN_SERVICE_TYPE_WIFI)
+			return __connman_error_not_supported(msg);
+
+		if (freq >= 0) {
+			technology->tethering_freq = freq;
+			technology_save(technology);
+
+			connman_dbus_property_changed_basic(technology->path,
+					CONNMAN_TECHNOLOGY_INTERFACE,
+					"TetheringFreq",
+					DBUS_TYPE_INT32,
+					&technology->tethering_freq);
+		}
 	} else if (g_str_equal(name, "Powered")) {
 		dbus_bool_t enable;
 
-- 
2.25.1

