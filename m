Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC83FDE
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 21:00:23 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id m22so27747021wrb.0
        for <connman@lists.linux.dev>; Mon, 04 Oct 2021 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PdfXceIR2r8llJnwcsjfdbfwEwgIiLtklFpOKBQxHM4=;
        b=Jk6xed2vgZXJIsJEsZjiGnzcIP+wlrBy4wTFWsYbl7aEupIaVmZFquOUHPsb5Zm3vc
         6VwFuh6pPKKPPi5WeeEckN5d4+WTRogpUvy6Nbo9oCmo2zmSyXhpaR5s8l3JuP25AIOF
         gjXPDrt/Apaf1d6I4IRQu7bczFpWIdVSbfREQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PdfXceIR2r8llJnwcsjfdbfwEwgIiLtklFpOKBQxHM4=;
        b=ZIiWQEWlKJUCpzx3O25inxWj/mjJlVRqJ4rdOlIjAkd+MVgoKy4m/tdSpN44ZwRAgb
         6Dfzo9owILiOt9KwxH1vpcmgHjmjdzNMROnx/mm+PPZZ/xXOFoIuzIQnBBk9Lk4utMZ5
         VFrLX72BaLwBZVvFHEamJI/9NE3KzM/cheihbh23clZ7BTMLvWVEtvXbneBTxrFENDxS
         RJCbDHBXOCp1liZi+L79omuowNigVRSNQzm02eVombtNwz2oUUnGWHv6goXDO4pmaA3C
         UnUpZvzHpaKaGHgHVfbZh7ZCtPXQqoEvSu48gES33Eirv1pHwPVMD+F4QNA8SzC9nLTe
         zaeA==
X-Gm-Message-State: AOAM530bYkU99T8lzh5b0RDbz5chayMD8EI9Ivdyivu7SCaoGzvpcMrM
	2rOQUhTlEkAn6To7KhofjWUC6X6Uh3GQCoy9
X-Google-Smtp-Source: ABdhPJwo+3xWNNSQMDIeSmanvpO4+KVHNBEFWJN7rZgPaGAQu6V5fT328AWMBx7Hkn+PnNtFkWSaDw==
X-Received: by 2002:adf:b353:: with SMTP id k19mr17061224wrd.325.1633381220772;
        Mon, 04 Oct 2021 14:00:20 -0700 (PDT)
Received: from panicking.amarulasolutions.com ([2.196.209.192])
        by smtp.gmail.com with ESMTPSA id d5sm15548134wra.38.2021.10.04.14.00.18
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 14:00:19 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH] tether: Add a way to define a tethering frequency
Date: Mon,  4 Oct 2021 23:00:16 +0200
Message-Id: <20211004210016.1579481-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an optional parameter to set the frequency of access point. Need to
be splitted in multiple patches. This is used as initial idea.

TODO:
- split
- add freq constraints
- move to unsigned int
- ...

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 client/commands.c      | 57 ++++++++++++++++++++++++++--------
 doc/technology-api.txt |  6 ++++
 include/technology.h   |  8 +++--
 plugins/bluetooth.c    |  1 -
 plugins/ethernet.c     |  1 -
 plugins/gadget.c       |  1 -
 plugins/neard.c        |  3 +-
 plugins/wifi.c         | 32 +++++++++++---------
 src/technology.c       | 69 ++++++++++++++++++++++++++++++++++--------
 9 files changed, 133 insertions(+), 45 deletions(-)

diff --git a/client/commands.c b/client/commands.c
index 94c375dd..b2bed200 100644
--- a/client/commands.c
+++ b/client/commands.c
@@ -550,20 +550,23 @@ struct tether_properties {
 	int ssid_result;
 	int passphrase_result;
 	int set_tethering;
+	int freq_result;
 };
 
 static int tether_update(struct tether_properties *tether)
 {
 	int ret;
 
-	if (tether->ssid_result == 0 && tether->passphrase_result == 0) {
+	if (tether->ssid_result == 0 && tether->passphrase_result == 0 &&
+			tether->freq_result == 0) {
 		ret = tether_set("wifi", tether->set_tethering);
 		g_free(tether);
 		return ret;
 	}
 
 	if (tether->ssid_result != -EINPROGRESS &&
-			tether->passphrase_result != -EINPROGRESS) {
+			tether->passphrase_result != -EINPROGRESS &&
+			tether->freq_result != -EINPROGRESS) {
 		g_free(tether);
 		return 0;
 	}
@@ -603,9 +606,25 @@ static int tether_set_passphrase_return(DBusMessageIter *iter, int errnum,
 	return tether_update(tether);
 }
 
-static int tether_set_ssid(char *ssid, char *passphrase, int set_tethering)
+static int tether_set_freq_return(DBusMessageIter *iter, int errnum,
+				  const char *error, void *user_data)
 {
-	struct tether_properties *tether = g_new(struct tether_properties, 1);
+	struct tether_properties *tether = user_data;
+
+	if (!error) {
+		fprintf(stdout, "Wifi access point frequency set\n");
+		tether->freq_result = 0;
+	} else {
+		fprintf(stderr, "Error setting wifi frequency: %s\n", error);
+		tether->freq_result = -EINVAL;
+	}
+
+	return tether_update(tether);
+}
+
+static int tether_set_ssid(char *ssid, char *passphrase, int set_tethering, int freq)
+{
+	struct tether_properties *tether = g_new0(struct tether_properties, 1);
 
 	tether->set_tethering = set_tethering;
 
@@ -621,6 +640,14 @@ static int tether_set_ssid(char *ssid, char *passphrase, int set_tethering)
 			tether_set_passphrase_return, tether,
 			"TetheringPassphrase", DBUS_TYPE_STRING, &passphrase);
 
+	if (freq > 0) {
+		tether->passphrase_result =__connmanctl_dbus_set_property(connection,
+				"/net/connman/technology/wifi",
+				"net.connman.Technology",
+				tether_set_freq_return, tether,
+				"TetheringFreq", DBUS_TYPE_INT32, &freq);
+	}
+
 	if (tether->ssid_result != -EINPROGRESS &&
 			tether->passphrase_result != -EINPROGRESS) {
 		g_free(tether);
@@ -638,24 +665,30 @@ static int cmd_tether(char *args[], int num, struct connman_option *options)
 	if (num < 3)
 		return -EINVAL;
 
-	passphrase = args[num - 1];
-	ssid = args[num - 2];
-
 	set_tethering = parse_boolean(args[2]);
 
 	if (strcmp(args[1], "wifi") == 0) {
+		int freq = 0;
 
-		if (num > 5)
+		if (num > 6)
 			return -E2BIG;
 
-		if (num == 5 && set_tethering == -1)
+		if (num >= 5 && set_tethering == -1)
 			return -EINVAL;
 
 		if (num == 4)
 			set_tethering = -1;
 
+		if (num == 6) {
+			freq = atoi(args[num - 1]);
+			num --;
+		}
+
+		passphrase = args[num - 1];
+		ssid = args[num - 2];
+
 		if (num > 3)
-			return tether_set_ssid(ssid, passphrase, set_tethering);
+			return tether_set_ssid(ssid, passphrase, set_tethering, freq);
 	}
 
 	if (num > 3)
@@ -1425,7 +1458,6 @@ static void monitor_del(char *interface)
 	int i;
 	char *rule;
 
-
 	for (i = 0; monitor[i].interface; i++) {
 		if (g_strcmp0(interface, monitor[i].interface) == 0) {
 			if (monitor[i].enabled == false)
@@ -1811,7 +1843,6 @@ static int session_connect_cb(DBusMessageIter *iter, int errnum,
 	return -EINPROGRESS;
 }
 
-
 static int session_connect(void)
 {
 	return __connmanctl_dbus_method_call(connection, "net.connman",
@@ -2768,7 +2799,7 @@ static const struct {
 	  "Disables given technology or offline mode",
 	  lookup_technology_offline },
 	{ "tether", "<technology> on|off\n"
-	            "            wifi [on|off] <ssid> <passphrase> ",
+	            "            wifi [on|off] <ssid> <passphrase> [<freq>]",
 	                                  NULL,            cmd_tether,
 	  "Enable, disable tethering, set SSID and passphrase for wifi",
 	  lookup_tether },
diff --git a/doc/technology-api.txt b/doc/technology-api.txt
index f22e9b29..32f6a6ca 100644
--- a/doc/technology-api.txt
+++ b/doc/technology-api.txt
@@ -100,3 +100,9 @@ Properties	boolean Powered [readwrite]
 			This property is only valid for the WiFi technology,
 			and is then mapped to the WPA pre-shared key clients
 			will have to use in order to establish a connection.
+
+		int TetheringFreq [readwrite]
+
+			The tethering access point frequency
+
+			This property is only valid for the WiFi technology,
diff --git a/include/technology.h b/include/technology.h
index 7508a9a1..d89c8164 100644
--- a/include/technology.h
+++ b/include/technology.h
@@ -44,8 +44,13 @@ void connman_technology_regdom_notify(struct connman_technology *technology,
 
 enum connman_service_type connman_technology_get_type
 				(struct connman_technology *technology);
+
+bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
+						const char **ssid, const char **psk, int *freq);
+
 bool connman_technology_get_wifi_tethering(const char **ssid,
-							const char **psk);
+						const char **psk, int *freq);
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
index 578b4be7..4f859e31 100644
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
@@ -3336,19 +3333,30 @@ static void tech_remove(struct connman_technology *technology)
 	wifi_technology = NULL;
 }
 
-static GSupplicantSSID *ssid_ap_init(const char *ssid, const char *passphrase)
+static GSupplicantSSID *ssid_ap_init(const struct connman_technology *technology)
 {
 	GSupplicantSSID *ap;
+	const char *ssid, *passphrase;
+	int freq;
+	bool ret;
 
 	ap = g_try_malloc0(sizeof(GSupplicantSSID));
 	if (!ap)
 		return NULL;
 
+	ret = connman_get_wifi_tethering_from_technology(technology, &ssid, &passphrase,
+							 &freq);
+	if (ret == false)
+		return NULL;
+
 	ap->mode = G_SUPPLICANT_MODE_MASTER;
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
@@ -3458,8 +3466,7 @@ static void sta_remove_callback(int result,
 }
 
 static int enable_wifi_tethering(struct connman_technology *technology,
-				const char *bridge, const char *identifier,
-				const char *passphrase, bool available)
+				const char *bridge, bool available)
 {
 	GList *list;
 	GSupplicantInterface *interface;
@@ -3512,14 +3519,14 @@ static int enable_wifi_tethering(struct connman_technology *technology,
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
 
@@ -3561,7 +3568,6 @@ static int enable_wifi_tethering(struct connman_technology *technology,
 }
 
 static int tech_set_tethering(struct connman_technology *technology,
-				const char *identifier, const char *passphrase,
 				const char *bridge, bool enabled)
 {
 	GList *list;
@@ -3589,13 +3595,11 @@ static int tech_set_tethering(struct connman_technology *technology,
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
index 672d6ea8..c4b9b0f7 100644
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
 
@@ -264,8 +272,7 @@ static int set_tethering(struct connman_technology *technology,
 		if (!driver || !driver->set_tethering)
 			continue;
 
-		err = driver->set_tethering(technology, ident, passphrase,
-				bridge, enabled);
+		err = driver->set_tethering(technology, bridge, enabled);
 
 		if (result == -EINPROGRESS)
 			continue;
@@ -356,17 +363,9 @@ enum connman_service_type connman_technology_get_type
 	return technology->type;
 }
 
-bool connman_technology_get_wifi_tethering(const char **ssid,
-							const char **psk)
+bool connman_get_wifi_tethering_from_technology(const struct connman_technology *technology,
+						const char **ssid, const char **psk, int *freq)
 {
-	struct connman_technology *technology;
-
-	if (!ssid || !psk)
-		return false;
-
-	*ssid = *psk = NULL;
-
-	technology = technology_find(CONNMAN_SERVICE_TYPE_WIFI);
 	if (!technology)
 		return false;
 
@@ -375,10 +374,26 @@ bool connman_technology_get_wifi_tethering(const char **ssid,
 
 	*ssid = technology->tethering_ident;
 	*psk = technology->tethering_passphrase;
+	*freq = technology->tethering_freq;
 
 	return true;
 }
 
+bool connman_technology_get_wifi_tethering(const char **ssid,
+					const char **psk, int *freq)
+{
+	struct connman_technology *technology;
+
+	if (!ssid || !psk)
+		return false;
+
+	*ssid = *psk = NULL;
+
+	technology = technology_find(CONNMAN_SERVICE_TYPE_WIFI);
+
+	return connman_get_wifi_tethering_from_technology(technology, ssid, psk, freq);
+}
+
 static void free_rfkill(gpointer data)
 {
 	struct connman_rfkill *rfkill = data;
@@ -443,6 +458,10 @@ static void technology_load(struct connman_technology *technology)
 				identifier, "Tethering.Passphrase", NULL);
 	if (enc)
 		technology->tethering_passphrase = g_strcompress(enc);
+
+	technology->tethering_freq = g_key_file_get_integer(keyfile,
+				identifier, "Tethering.Freq", NULL);
+
 done:
 	g_free(identifier);
 
@@ -554,6 +573,11 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_STRING,
 					&technology->tethering_passphrase);
 
+	if (technology->tethering_freq)
+		connman_dbus_dict_append_basic(&dict, "TetheringFreq",
+					DBUS_TYPE_INT32,
+					&technology->tethering_freq);
+
 	connman_dbus_dict_close(iter, &dict);
 }
 
@@ -968,6 +992,27 @@ static DBusMessage *set_property(DBusConnection *conn,
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

