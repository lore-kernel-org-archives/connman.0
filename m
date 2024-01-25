Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B536A13A25D
	for <connman@lists.linux.dev>; Thu, 25 Jan 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219784; cv=none; b=Z0V1UZaO2rGBh118iCY5VRhpVRyeWV0e13qbHO1jE1N5ePa9lft8VEZDB2Yy1BDpKQRgmOaZHIm/yH9VfidOtZMj1U736axYbCmJ8QYdcvF4dG8KEmiL1A7z30nWge31gWP+Dvu6rxoK30iSzZ2kpWxi45InJlFqC80VO3tEjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219784; c=relaxed/simple;
	bh=65E8B7RH67cIfnihEbxXftNdb7fTalICW3waVA4ZOgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4eQ1oOYHgAIDoJdVcQ8GEuiGaZTN1FKbnJh5cl/5+l0SZ0QlL7Rr15M9v2islJrmsvQ/Cq4HbHWnoIBdN/DNd6RXytGwSp/r+Cu1v8EwFEUfK26yW+WBdXrdH6ARmHHFN2qi13Wk6hp6AtN0u/reLEsxPj0NphkvRD4LjwuGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyz+7C2k; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyz+7C2k"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5993047a708so3741464eaf.3
        for <connman@lists.linux.dev>; Thu, 25 Jan 2024 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706219781; x=1706824581; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UEyVUyFM6o5DpXyB3qwrmmnY/CQ2EHgHNQaLJUXpdE=;
        b=Qyz+7C2kUcAmRkwwJVyVjOelKHVbdCrrSobjIcgXlFLnDM6PDcooTLUua6RVbPEJ6P
         YrUMTBxhiOdtMUO9bAPTLcJPpdf0Yib7ue9oCgC0cCn8khKElrXoWmcwCtLkagrblsjJ
         MzPqypU4Cs5/E9O1Uyq6uZozw7zz+7n5d6866U1DX8EaOY8nh+mr/Eza+H8lpvPq5MRr
         2wt46/b9Kq6LFXWS7McMYb6pDGaY/gOLalj7X7UUjZ8TUaPyrP37Da9TWADnIGOzoTVZ
         C5ZYMS77IqdArCfGMg9OIdjaOB2zcb5HGIggQNPQhfzLZaveMRmxlgPAtMqqq4+aYnMn
         wfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219781; x=1706824581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UEyVUyFM6o5DpXyB3qwrmmnY/CQ2EHgHNQaLJUXpdE=;
        b=jD395NO80+Ka21y/MDRWfBucrkDPM+3cZIsPpmSa6tTba4faS3Ii0tzV4TBhHK41BZ
         7uUKlkBD+tJ/bZkbe3TKjkn/oslWf8WJNtZwvXHULLLBeDsr1xGCf4R4CJVVG/bsYjLx
         H4d7DkFxlcmRdWNEDbpgq0JeVp7wYEWbmSyDn6G8FhdYoDOjK+D3xIQD4O9VGxpIrCCe
         /uwVRfbrp/AoIOJj4Z1msO/zljxJK5UCD1LJJg0aMVP/duQF08Yix6NRc03yzjx3HgVj
         ZVitSdhlnQoE5yjynPDtJzj1j/jXWTzD3akyDEhLN3fZqg9/cNffrTeq/YNU+8iNtLaQ
         SooQ==
X-Gm-Message-State: AOJu0YxmL41l3Si1zycxoyZTZsV9nz+VAg9N5BBw2CdOmu4pA62AX+Yh
	lo2vFP+sveLpEshldAtUACA4xiLkL7sxHZSnnXRfGx2+/06GjXU82kkIr87k
X-Google-Smtp-Source: AGHT+IGUoYHpMHKn24er1BIYx0jLiTP6cygpwWzuejoykva9bFEcJpQFBi8/eEUDOJZvTHuE+TInHw==
X-Received: by 2002:a4a:c4cb:0:b0:599:c981:61f6 with SMTP id g11-20020a4ac4cb000000b00599c98161f6mr415247ooq.4.1706219781418;
        Thu, 25 Jan 2024 13:56:21 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j1-20020a4ac541000000b00598d6a3ff3bsm586467ooq.13.2024.01.25.13.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:56:21 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] ofono: Remove support for CDMA
Date: Thu, 25 Jan 2024 15:55:15 -0600
Message-ID: <20240125215533.640304-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

oFono 2.2 removed all support for CDMA since most CDMA networks have
now been shut down.  Remove support for CDMA inside the ofono plugin as
well.
---
 plugins/ofono.c | 425 +-----------------------------------------------
 1 file changed, 8 insertions(+), 417 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 8bb5394926e0..9d0d44547a2c 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -52,8 +52,6 @@
 #define OFONO_NETREG_INTERFACE		OFONO_SERVICE ".NetworkRegistration"
 #define OFONO_CM_INTERFACE		OFONO_SERVICE ".ConnectionManager"
 #define OFONO_CONTEXT_INTERFACE		OFONO_SERVICE ".ConnectionContext"
-#define OFONO_CDMA_CM_INTERFACE		OFONO_SERVICE ".cdma.ConnectionManager"
-#define OFONO_CDMA_NETREG_INTERFACE	OFONO_SERVICE ".cdma.NetworkRegistration"
 
 #define MODEM_ADDED			"ModemAdded"
 #define MODEM_REMOVED			"ModemRemoved"
@@ -72,8 +70,6 @@ enum ofono_api {
 	OFONO_API_SIM =		0x1,
 	OFONO_API_NETREG =	0x2,
 	OFONO_API_CM =		0x4,
-	OFONO_API_CDMA_NETREG =	0x8,
-	OFONO_API_CDMA_CM =	0x10,
 };
 
 /*
@@ -103,27 +99,6 @@ enum ofono_api {
  * successful the modem is connected to the network. oFono will inform
  * the plugin about IP configuration through the updating the context's
  * properties.
- *
- * CDMA working flow:
- *
- * When a new modem appears, the plugin always powers it up. This
- * allows the plugin to create connman_device either using IMSI either
- * using modem Serial if the modem got a SIM interface or not.
- *
- * As for GSM, the core will call modem_enable() if the technology
- * is enabled. modem_enable() will then set the modem online.
- * If the technology is disabled then modem_disable() will just set the
- * modem offline. The modem is always kept powered all the time.
- *
- * After setting the modem online the plugin waits for CdmaConnectionManager
- * interface to appear. Then, once CdmaNetworkRegistration appears, a new
- * Service will be created and registered at the core.
- *
- * When asked to connect to the network (network_connect()) the plugin
- * will power up the CdmaConnectionManager interface.
- * If the operation is successful the modem is connected to the network.
- * oFono will inform the plugin about IP configuration through the
- * updating CdmaConnectionManager settings properties.
  */
 
 static DBusConnection *connection;
@@ -166,9 +141,6 @@ struct modem_data {
 
 	bool set_powered;
 
-	/* CDMA ConnectionManager Interface */
-	bool cdma_cm_powered;
-
 	/* ConnectionManager Interface */
 	bool attached;
 	bool cm_powered;
@@ -179,7 +151,6 @@ struct modem_data {
 	/* Netreg Interface */
 	char *name;
 	uint8_t strength;
-	uint8_t data_strength; /* 1xEVDO signal strength */
 	bool registered;
 	bool roaming;
 
@@ -198,10 +169,6 @@ static const char *api2string(enum ofono_api api)
 		return "netreg";
 	case OFONO_API_CM:
 		return "cm";
-	case OFONO_API_CDMA_NETREG:
-		return "cdma-netreg";
-	case OFONO_API_CDMA_CM:
-		return "cmda-cm";
 	}
 
 	return "unknown";
@@ -660,63 +627,6 @@ static int context_set_active(struct modem_data *modem,
 	return err;
 }
 
-static void cdma_cm_set_powered_reply(struct modem_data *modem,
-				struct network_context *context, bool success)
-{
-	DBG("%s", context->path);
-
-	if (success) {
-		/*
-		 * Don't handle do anything on success here. oFono will send
-		 * the change via PropertyChanged signal.
-		 */
-		return;
-	}
-
-	/*
-	 * Powered = True might fail due a timeout. That means oFono
-	 * still tries to go online. If we retry to set Powered = True,
-	 * we just get a InProgress error message. Should we power
-	 * cycle the modem in such cases?
-	 */
-
-	if (!context->network) {
-		/*
-		 * In the case where we power down the device
-		 * we don't wait for the reply, therefore the network
-		 * might already be gone.
-		 */
-		return;
-	}
-
-	connman_network_set_error(context->network,
-				CONNMAN_NETWORK_ERROR_ASSOCIATE_FAIL);
-}
-
-static int cdma_cm_set_powered(struct modem_data *modem, dbus_bool_t powered)
-{
-	int err;
-	struct network_context *context = NULL;
-
-	if (!modem->context_list)
-		return -1;
-
-	DBG("%s powered %d", modem->path, powered);
-
-	/* In case of CDMA, there is only one context */
-	context = modem->context_list->data;
-	err = set_property(modem, context, modem->path,
-				OFONO_CDMA_CM_INTERFACE,
-				"Powered", DBUS_TYPE_BOOLEAN,
-				&powered,
-				cdma_cm_set_powered_reply);
-
-	if (!powered && err == -EINPROGRESS)
-		return 0;
-
-	return err;
-}
-
 static int modem_set_online(struct modem_data *modem, dbus_bool_t online)
 {
 	DBG("%s online %d", modem->path, online);
@@ -793,10 +703,6 @@ static uint8_t extract_interfaces(DBusMessageIter *array)
 			interfaces |= OFONO_API_NETREG;
 		else if (g_str_equal(name, OFONO_CM_INTERFACE))
 			interfaces |= OFONO_API_CM;
-		else if (g_str_equal(name, OFONO_CDMA_CM_INTERFACE))
-			interfaces |= OFONO_API_CDMA_CM;
-		else if (g_str_equal(name, OFONO_CDMA_NETREG_INTERFACE))
-			interfaces |= OFONO_API_CDMA_NETREG;
 
 		dbus_message_iter_next(&entry);
 	}
@@ -1018,27 +924,19 @@ out:
 	g_free(gateway);
 }
 
+/*
+ * This functions tests if we have the necessary information gathered
+ * before we are able to create a device.
+ */
 static bool ready_to_create_device(struct modem_data *modem)
 {
-	/*
-	 * There are three different modem types which behave slightly
-	 * different:
-	 * - GSM modems will expose the SIM interface then the
-	 *   CM interface.
-	 * - CDMA modems will expose CM first and sometime later
-	 *   a unique serial number.
-	 *
-	 * This functions tests if we have the necessary information gathered
-	 * before we are able to create a device.
-	 */
-
 	if (modem->device)
 		return false;
 
-	if (modem->imsi || modem->serial)
-		return true;
+	if (!modem->imsi)
+		return false;
 
-	return false;
+	return true;
 }
 
 static void create_device(struct modem_data *modem)
@@ -1050,8 +948,6 @@ static void create_device(struct modem_data *modem)
 
 	if (modem->imsi)
 		ident = modem->imsi;
-	else if (modem->serial)
-		ident = modem->serial;
 
 	if (!connman_dbus_validate_ident(ident))
 		ident = connman_dbus_encode_string(ident);
@@ -1611,22 +1507,6 @@ static void netreg_update_strength(struct modem_data *modem,
 	if (!modem->context_list)
 		return;
 
-	/*
-	 * GSM:
-	 * We don't have 2 signal notifications we always report the strength
-	 * signal. data_strength is always equal to 0.
-	 *
-	 * CDMA:
-	 * In the case we have a data_strength signal (from 1xEVDO network)
-	 * we don't need to update the value with strength signal (from 1xCDMA)
-	 * because the modem is registered to 1xEVDO network for data call.
-	 * In case we have no data_strength signal (not registered to 1xEVDO
-	 * network), we must report the strength signal (registered to 1xCDMA
-	 * network e.g slow mode).
-	 */
-	if (modem->data_strength != 0)
-		return;
-
 	/* For all the context */
 	for (list = modem->context_list; list; list = list->next) {
 		struct network_context *context = list->data;
@@ -1639,39 +1519,6 @@ static void netreg_update_strength(struct modem_data *modem,
 	}
 }
 
-/* Retrieve 1xEVDO Data Strength signal */
-static void netreg_update_datastrength(struct modem_data *modem,
-					DBusMessageIter *value)
-{
-	GSList *list;
-
-	dbus_message_iter_get_basic(value, &modem->data_strength);
-
-	DBG("%s Data Strength %d", modem->path, modem->data_strength);
-
-	if (!modem->context_list)
-		return;
-
-	/*
-	 * CDMA modem is not registered to 1xEVDO network, let
-	 * update_signal_strength() reporting the value on the Strength signal
-	 * notification.
-	 */
-	if (modem->data_strength == 0)
-		return;
-
-	/* For all the context */
-	for (list = modem->context_list; list; list = list->next) {
-		struct network_context *context = list->data;
-
-		if (context->network) {
-			connman_network_set_strength(context->network,
-							modem->data_strength);
-			connman_network_update(context->network);
-		}
-	}
-}
-
 static void netreg_update_status(struct modem_data *modem,
 					DBusMessageIter *value)
 {
@@ -1821,115 +1668,6 @@ static int netreg_get_properties(struct modem_data *modem)
 			netreg_properties_reply, modem);
 }
 
-static void add_cdma_network(struct modem_data *modem)
-{
-	struct network_context *context = NULL;
-	/* Be sure that device is created before adding CDMA network */
-	if (!modem->device)
-		return;
-
-	/*
-	 * CDMA modems don't need contexts for data call, however the current
-	 * add_network() logic needs one, so we create one to proceed.
-	 */
-	if (!modem->context_list) {
-		context = network_context_alloc(modem->path);
-		modem->context_list = g_slist_prepend(modem->context_list,
-							context);
-	} else
-		context = modem->context_list->data;
-
-	if (!modem->name)
-		modem->name = g_strdup("CDMA Network");
-
-	add_network(modem, context);
-
-	if (modem->cdma_cm_powered)
-		set_connected(modem, context);
-}
-
-static gboolean cdma_netreg_changed(DBusConnection *conn,
-					DBusMessage *message,
-					void *user_data)
-{
-	const char *path = dbus_message_get_path(message);
-	struct modem_data *modem;
-	DBusMessageIter iter, value;
-	const char *key;
-
-	DBG("");
-
-	modem = g_hash_table_lookup(modem_hash, path);
-	if (!modem)
-		return TRUE;
-
-	if (modem->ignore)
-		return TRUE;
-
-	if (!dbus_message_iter_init(message, &iter))
-		return TRUE;
-
-	dbus_message_iter_get_basic(&iter, &key);
-
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &value);
-
-	if (g_str_equal(key, "Name"))
-		netreg_update_name(modem, &value);
-	else if (g_str_equal(key, "Strength"))
-		netreg_update_strength(modem, &value);
-	else if (g_str_equal(key, "DataStrength"))
-		netreg_update_datastrength(modem, &value);
-	else if (g_str_equal(key, "Status"))
-		netreg_update_status(modem, &value);
-
-	if (modem->registered)
-		add_cdma_network(modem);
-	else
-		remove_all_networks(modem);
-
-	return TRUE;
-}
-
-static void cdma_netreg_properties_reply(struct modem_data *modem,
-					DBusMessageIter *dict)
-{
-	DBG("%s", modem->path);
-
-	while (dbus_message_iter_get_arg_type(dict) == DBUS_TYPE_DICT_ENTRY) {
-		DBusMessageIter entry, value;
-		const char *key;
-
-		dbus_message_iter_recurse(dict, &entry);
-		dbus_message_iter_get_basic(&entry, &key);
-
-		dbus_message_iter_next(&entry);
-		dbus_message_iter_recurse(&entry, &value);
-
-		if (g_str_equal(key, "Name"))
-			netreg_update_name(modem, &value);
-		else if (g_str_equal(key, "Strength"))
-			netreg_update_strength(modem, &value);
-		else if (g_str_equal(key, "DataStrength"))
-			netreg_update_datastrength(modem, &value);
-		else if (g_str_equal(key, "Status"))
-			netreg_update_status(modem, &value);
-
-		dbus_message_iter_next(dict);
-	}
-
-	if (modem->registered)
-		add_cdma_network(modem);
-	else
-		remove_all_networks(modem);
-}
-
-static int cdma_netreg_get_properties(struct modem_data *modem)
-{
-	return get_properties(modem->path, OFONO_CDMA_NETREG_INTERFACE,
-			cdma_netreg_properties_reply, modem);
-}
-
 static void cm_update_attached(struct modem_data *modem,
 				DBusMessageIter *value)
 {
@@ -1999,67 +1737,6 @@ static gboolean cm_changed(DBusConnection *conn, DBusMessage *message,
 	return TRUE;
 }
 
-static void cdma_cm_update_powered(struct modem_data *modem,
-					DBusMessageIter *value)
-{
-	struct network_context *context =  NULL;
-	dbus_bool_t cdma_cm_powered;
-
-	dbus_message_iter_get_basic(value, &cdma_cm_powered);
-	modem->cdma_cm_powered = cdma_cm_powered;
-
-	DBG("%s CDMA cm Powered %d", modem->path, modem->cdma_cm_powered);
-
-	if (!modem->context_list)
-		return;
-
-	/* In case of CDMA, there is only one context */
-	context = modem->context_list->data;
-	if (modem->cdma_cm_powered)
-		set_connected(modem, context);
-	else
-		set_disconnected(context);
-}
-
-static void cdma_cm_update_settings(struct modem_data *modem,
-					DBusMessageIter *value)
-{
-	DBG("%s Settings", modem->path);
-
-	extract_ipv4_settings(value, modem->context_list->data);
-}
-
-static gboolean cdma_cm_changed(DBusConnection *conn,
-				DBusMessage *message, void *user_data)
-{
-	const char *path = dbus_message_get_path(message);
-	struct modem_data *modem;
-	DBusMessageIter iter, value;
-	const char *key;
-
-	modem = g_hash_table_lookup(modem_hash, path);
-	if (!modem)
-		return TRUE;
-
-	if (modem->online && !modem->context_list)
-		cdma_netreg_get_properties(modem);
-
-	if (!dbus_message_iter_init(message, &iter))
-		return TRUE;
-
-	dbus_message_iter_get_basic(&iter, &key);
-
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &value);
-
-	if (g_str_equal(key, "Powered"))
-		cdma_cm_update_powered(modem, &value);
-	if (g_str_equal(key, "Settings"))
-		cdma_cm_update_settings(modem, &value);
-
-	return TRUE;
-}
-
 static void cm_properties_reply(struct modem_data *modem, DBusMessageIter *dict)
 {
 	DBG("%s", modem->path);
@@ -2089,39 +1766,6 @@ static int cm_get_properties(struct modem_data *modem)
 				cm_properties_reply, modem);
 }
 
-static void cdma_cm_properties_reply(struct modem_data *modem,
-					DBusMessageIter *dict)
-{
-	DBG("%s", modem->path);
-
-	if (modem->online)
-		cdma_netreg_get_properties(modem);
-
-	while (dbus_message_iter_get_arg_type(dict) == DBUS_TYPE_DICT_ENTRY) {
-		DBusMessageIter entry, value;
-		const char *key;
-
-		dbus_message_iter_recurse(dict, &entry);
-		dbus_message_iter_get_basic(&entry, &key);
-
-		dbus_message_iter_next(&entry);
-		dbus_message_iter_recurse(&entry, &value);
-
-		if (g_str_equal(key, "Powered"))
-			cdma_cm_update_powered(modem, &value);
-		if (g_str_equal(key, "Settings"))
-			cdma_cm_update_settings(modem, &value);
-
-		dbus_message_iter_next(dict);
-	}
-}
-
-static int cdma_cm_get_properties(struct modem_data *modem)
-{
-	return get_properties(modem->path, OFONO_CDMA_CM_INTERFACE,
-				cdma_cm_properties_reply, modem);
-}
-
 static void sim_update_imsi(struct modem_data *modem,
 				DBusMessageIter *value)
 {
@@ -2279,25 +1923,11 @@ static void modem_update_interfaces(struct modem_data *modem,
 		}
 	}
 
-	if (api_added(old_ifaces, new_ifaces, OFONO_API_CDMA_CM)) {
-		if (ready_to_create_device(modem)) {
-			create_device(modem);
-			if (modem->registered)
-				add_cdma_network(modem);
-		}
-
-		if (modem->device)
-			cdma_cm_get_properties(modem);
-	}
-
 	if (api_added(old_ifaces, new_ifaces, OFONO_API_NETREG)) {
 		if (modem->attached)
 			netreg_get_properties(modem);
 	}
 
-	if (api_added(old_ifaces, new_ifaces, OFONO_API_CDMA_NETREG))
-		cdma_netreg_get_properties(modem);
-
 	if (api_removed(old_ifaces, new_ifaces, OFONO_API_CM)) {
 		if (modem->call_get_contexts) {
 			DBG("cancelling pending GetContexts call");
@@ -2308,14 +1938,8 @@ static void modem_update_interfaces(struct modem_data *modem,
 		remove_all_contexts(modem);
 	}
 
-	if (api_removed(old_ifaces, new_ifaces, OFONO_API_CDMA_CM))
-		remove_all_contexts(modem);
-
 	if (api_removed(old_ifaces, new_ifaces, OFONO_API_NETREG))
 		remove_all_networks(modem);
-
-	if (api_removed(old_ifaces, new_ifaces, OFONO_API_CDMA_NETREG))
-		remove_all_networks(modem);
 }
 
 static gboolean modem_changed(DBusConnection *conn, DBusMessage *message,
@@ -2385,15 +2009,6 @@ static gboolean modem_changed(DBusConnection *conn, DBusMessage *message,
 		modem->serial = g_strdup(serial);
 
 		DBG("%s Serial %s", modem->path, modem->serial);
-
-		if (has_interface(modem->interfaces,
-					 OFONO_API_CDMA_CM)) {
-			if (ready_to_create_device(modem)) {
-				create_device(modem);
-				if (modem->registered)
-					add_cdma_network(modem);
-			}
-		}
 	}
 
 	return TRUE;
@@ -2717,8 +2332,6 @@ static int network_connect(struct connman_network *network)
 
 	if (has_interface(modem->interfaces, OFONO_API_CM))
 		return context_set_active(modem, context, TRUE);
-	else if (has_interface(modem->interfaces, OFONO_API_CDMA_CM))
-		return cdma_cm_set_powered(modem, TRUE);
 
 	connman_error("Connection manager interface not available");
 
@@ -2741,8 +2354,6 @@ static int network_disconnect(struct connman_network *network)
 
 	if (has_interface(modem->interfaces, OFONO_API_CM))
 		return context_set_active(modem, context, FALSE);
-	else if (has_interface(modem->interfaces, OFONO_API_CDMA_CM))
-		return cdma_cm_set_powered(modem, FALSE);
 
 	connman_error("Connection manager interface not available");
 
@@ -2833,8 +2444,6 @@ static guint context_added_watch;
 static guint context_removed_watch;
 static guint netreg_watch;
 static guint context_watch;
-static guint cdma_cm_watch;
-static guint cdma_netreg_watch;
 
 static int ofono_init(void)
 {
@@ -2907,25 +2516,11 @@ static int ofono_init(void)
 						netreg_changed,
 						NULL, NULL);
 
-	cdma_cm_watch = g_dbus_add_signal_watch(connection, OFONO_SERVICE,
-						NULL, OFONO_CDMA_CM_INTERFACE,
-						PROPERTY_CHANGED,
-						cdma_cm_changed,
-						NULL, NULL);
-
-	cdma_netreg_watch = g_dbus_add_signal_watch(connection, OFONO_SERVICE,
-						NULL, OFONO_CDMA_NETREG_INTERFACE,
-						PROPERTY_CHANGED,
-						cdma_netreg_changed,
-						NULL, NULL);
-
-
 	if (watch == 0 || modem_added_watch == 0 || modem_removed_watch == 0 ||
 			modem_watch == 0 || cm_watch == 0 || sim_watch == 0 ||
 			context_added_watch == 0 ||
 			context_removed_watch == 0 ||
-			context_watch == 0 || netreg_watch == 0 ||
-			cdma_cm_watch == 0 || cdma_netreg_watch == 0) {
+			context_watch == 0 || netreg_watch == 0) {
 		err = -EIO;
 		goto remove;
 	}
@@ -2950,8 +2545,6 @@ static int ofono_init(void)
 	return 0;
 
 remove:
-	g_dbus_remove_watch(connection, cdma_netreg_watch);
-	g_dbus_remove_watch(connection, cdma_cm_watch);
 	g_dbus_remove_watch(connection, netreg_watch);
 	g_dbus_remove_watch(connection, context_watch);
 	g_dbus_remove_watch(connection, context_removed_watch);
@@ -2994,8 +2587,6 @@ static void ofono_exit(void)
 	connman_device_driver_unregister(&modem_driver);
 	connman_network_driver_unregister(&network_driver);
 
-	g_dbus_remove_watch(connection, cdma_netreg_watch);
-	g_dbus_remove_watch(connection, cdma_cm_watch);
 	g_dbus_remove_watch(connection, netreg_watch);
 	g_dbus_remove_watch(connection, context_watch);
 	g_dbus_remove_watch(connection, context_removed_watch);
-- 
2.43.0

