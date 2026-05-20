Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73662308F15
	for <connman@lists.linux.dev>; Wed, 20 May 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288458; cv=none; b=qXyG071CuO0A3serP8dfLYdiYil96bovQxYrLWgdTTIdM1gbAUC49X+5D5lGrELT/Gw6bneNk/W8vN0LE13FGSBZc3Zl9lYvoaeBEdg9Q+kuz5QaP9q2a21TbgMH+MaIb1TLzIACRz26+sJVKGupPPH+DgptOVqQDHzoTsi/DGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288458; c=relaxed/simple;
	bh=7+S53nTDdXgWC3qps/Xe3thPTGDC4FIInLmTphf9raU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyGq3oZ7XYuwLo5daxp4BQ4Stmqq/Zlr71tcvAFV6MNm2oYQzjliONb/TGJSEzmk/H8TosSLU/Ms+P04vZk3owBse/a8qUj+5o9sPAp7ZGy4nRtSP6WNTq3IniPkRkUL8u0WOwvlPPQdV9QLF37GjP84ccjeNPoXYG9tPBMmRJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=XnSrHlwu; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="XnSrHlwu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=h4NB2V18mNa/Kaweyc3otk1hJHlqIpSCZmHQiW5wxqY=; b=XnSrHlwuLzey+gw8I9caVrM+FQ
	ambu/dOjJBjXmtMlLpzefYg4TonvXNDgeitFiQRy5yKXAIGGKUTO/nWnQ50PoxTMCJbzJbjkaoEWl
	JgYLXmC2LUpwoITOdlHrTikr+bHqRskqK+fRljldxHvso5Vf6i7JIsZYhYMrPem+Kx1aiHPbuTh0i
	DsAzlEOSAc/WxZa6Ky4C4jS8byfHB6/pP7Ss2rTWrjxIi+QuwIdZ+52CRbCCfiBeeIXX5WU/2Evb2
	uUxWbG9rNPKL7eABeuu9yKAQsTSwibDEaPX+l/N3uTeW+16titFGwuVGpRRrKjpkGsJBXmBAfX3Q5
	Cn3x41qA==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGj-002WBi-37
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:30 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/9] main: Reformat processing of configuration values
Date: Wed, 20 May 2026 16:47:09 +0300
Message-ID: <20260520134720.981315-6-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.944]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-6-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

---
 src/main.c | 831 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 468 insertions(+), 363 deletions(-)

diff --git a/src/main.c b/src/main.c
index b1b4fd5a..2752a872 100644
--- a/src/main.c
+++ b/src/main.c
@@ -3,7 +3,7 @@
  *  Connection Manager
  *
  *  Copyright (C) 2007-2013  Intel Corporation. All rights reserved.
- *  Copyright (C) 2025  Jolla Mobile Ltd. All right reserved.
+ *  Copyright (C) 2025-2026  Jolla Mobile Ltd. All right reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -258,6 +258,58 @@ static const char *supported_options[] = {
 	NULL
 };
 
+enum supported_options_val {
+	CONF_BG_SCAN_VAL = 0,
+	CONF_PREF_TIMESERVERS_VAL,
+	CONF_AUTO_CONNECT_TECHS_VAL,
+	CONF_ENABLED_TECHS_VAL,
+	CONF_FAVORITE_TECHS_VAL,
+	CONF_ALWAYS_CONNECTED_TECHS_VAL,
+	CONF_PREFERRED_TECHS_VAL,
+	CONF_FALLBACK_NAMESERVERS_VAL,
+	CONF_TIMEOUT_INPUTREQ_VAL,
+	CONF_TIMEOUT_BROWSERLAUNCH_VAL,
+	CONF_BLACKLISTED_INTERFACES_VAL,
+	CONF_ALLOW_HOSTNAME_UPDATES_VAL,
+	CONF_ALLOW_DOMAINNAME_UPDATES_VAL,
+	CONF_SINGLE_TECH_VAL,
+	CONF_TETHERING_TECHNOLOGIES_VAL,
+	CONF_PERSISTENT_TETHERING_MODE_VAL,
+	CONF_ENABLE_6TO4_VAL,
+	CONF_VENDOR_CLASS_ID_VAL,
+	CONF_ENABLE_ONLINE_CHECK_VAL,
+	CONF_ENABLE_ONLINE_TO_READY_TRANSITION_VAL,
+	CONF_ONLINE_CHECK_MODE_VAL,
+	CONF_ONLINE_CHECK_IPV4_URL_VAL,
+	CONF_ONLINE_CHECK_IPV6_URL_VAL,
+	CONF_ONLINE_CHECK_CONNECT_TIMEOUT_VAL,
+	CONF_ONLINE_CHECK_INITIAL_INTERVAL_VAL,
+	CONF_ONLINE_CHECK_MAX_INTERVAL_VAL,
+	CONF_ONLINE_CHECK_FAILURES_THRESHOLD_VAL,
+	CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD_VAL,
+	CONF_ONLINE_CHECK_INTERVAL_STYLE_VAL,
+	CONF_AUTO_CONNECT_ROAMING_SERVICES_VAL,
+	CONF_ACD_VAL,
+	CONF_USE_GATEWAYS_AS_TIMESERVERS_VAL,
+	CONF_LOCALTIME_VAL,
+	CONF_REGDOM_FOLLOWS_TIMEZONE_VAL,
+	CONF_RESOLV_CONF_VAL,
+	CONF_FALLBACK_DEVICE_TYPES_VAL,
+
+};
+
+static int conf_key_to_int(const char *key)
+{
+	int i;
+
+	for (i = 0; i < CONF_ARRAY_SIZE(supported_options); i++) {
+		if (!g_strcmp0(key, supported_options[i]))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static GKeyFile *load_config(const char *file)
 {
 	GError *err = NULL;
@@ -308,12 +360,12 @@ static uint *parse_service_types(char **str_list, gsize len)
 	return type_list;
 }
 
-static char **parse_fallback_nameservers(char **nameservers, gsize len)
+static char **parse_fallback_nameservers(char **nameservers, gsize *len)
 {
 	char **servers;
 	int i, j;
 
-	servers = g_try_new0(char *, len + 1);
+	servers = g_try_new0(char *, *len + 1);
 	if (!servers)
 		return NULL;
 
@@ -327,6 +379,8 @@ static char **parse_fallback_nameservers(char **nameservers, gsize len)
 		i += 1;
 	}
 
+	*len = j + 1;
+
 	return servers;
 }
 
@@ -375,8 +429,7 @@ static void check_config(GKeyFile *config, const char *file)
 
 	for (j = 0; keys && keys[j]; j++) {
 		if (g_strcmp0(keys[j], GENERAL_GROUP) != 0)
-			connman_warn("Unknown group %s in %s",
-						keys[j], file);
+			connman_warn("Unknown group %s in %s", keys[j], file);
 	}
 
 	g_strfreev(keys);
@@ -395,14 +448,13 @@ static void check_config(GKeyFile *config, const char *file)
 			}
 		}
 		if (!found && !supported_options[i])
-			connman_warn("Unknown option %s in %s",
-						keys[j], file);
+			connman_warn("Unknown option %s in %s", keys[j], file);
 	}
 
 	g_strfreev(keys);
 }
 
-static void online_check_mode_set_from_deprecated(void)
+static int online_check_mode_set_from_deprecated(void)
 {
 	connman_settings.online_check_mode =
 		connman_settings.enable_online_check ?
@@ -410,6 +462,8 @@ static void online_check_mode_set_from_deprecated(void)
 			CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS :
 			CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT :
 		CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE;
+
+	return 0;
 }
 
 static void online_check_mode_set_to_deprecated(void)
@@ -470,316 +524,457 @@ static void online_check_settings_log(void)
 		connman_settings.online_check_successes_threshold);
 }
 
-static void parse_config(GKeyFile *config, const char *file)
+/* String check callbacks */
+typedef gboolean (*str_check_callback) (const char *value);
+
+static gboolean check_online_mode(const char *str)
 {
-	GError *error = NULL;
-	bool boolean;
-	char **timeservers;
-	char **interfaces;
-	char **str_list;
-	char **tethering;
-	char *string;
-	gsize len;
-	int integer;
-	double real;
+	connman_settings.online_check_mode =
+			__connman_service_online_check_string2mode(str);
+	if (connman_settings.online_check_mode ==
+				CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN) {
+		connman_error("Invalid online check mode \"%s\"", str);
 
-	if (!config || !file) {
-		connman_settings.auto_connect =
-			parse_service_types(default_auto_connect,
-					CONF_ARRAY_SIZE(default_auto_connect));
-		connman_settings.enabled_techs =
-			parse_service_types(default_enabled_techs,
-					CONF_ARRAY_SIZE(default_enabled_techs));
-		connman_settings.favorite_techs =
-			parse_service_types(default_favorite_techs,
-					CONF_ARRAY_SIZE(default_favorite_techs));
-		connman_settings.blacklisted_interfaces =
-			g_strdupv(default_blacklist);
-		connman_settings.online_check_ipv4_url =
-			g_strdup(DEFAULT_ONLINE_CHECK_IPV4_URL);
-		connman_settings.online_check_ipv6_url =
-			g_strdup(DEFAULT_ONLINE_CHECK_IPV6_URL);
-		connman_settings.online_check_interval_style =
-			g_strdup(DEFAULT_ONLINE_CHECK_INTERVAL_STYLE);
-		return;
+		online_check_mode_set_from_deprecated();
+	} else {
+		online_check_mode_set_to_deprecated();
 	}
 
-	DBG("parsing %s", file);
-
-	boolean = g_key_file_get_boolean(config, GENERAL_GROUP,
-						CONF_BG_SCAN, &error);
-	if (!error)
-		connman_settings.bg_scan = boolean;
-
-	g_clear_error(&error);
-
-	timeservers = __connman_config_get_string_list(config, GENERAL_GROUP,
-					CONF_PREF_TIMESERVERS, NULL, &error);
-	if (!error)
-		connman_settings.pref_timeservers = timeservers;
-
-	g_clear_error(&error);
-
-	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_AUTO_CONNECT_TECHS, &len, &error);
-
-	if (!error)
-		connman_settings.auto_connect =
-			parse_service_types(str_list, len);
-	else
-		connman_settings.auto_connect =
-			parse_service_types(default_auto_connect, CONF_ARRAY_SIZE(default_auto_connect));
-
-	g_strfreev(str_list);
-
-	g_clear_error(&error);
-
-	/* DefaultEnabledTechnologies */
-
-	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_ENABLED_TECHS, &len, &error);
-
-	if (!error)
-		connman_settings.enabled_techs =
-			parse_service_types(str_list, len);
-	else
-		connman_settings.enabled_techs =
-			parse_service_types(default_enabled_techs,
-				CONF_ARRAY_SIZE(default_enabled_techs));
-
-	g_strfreev(str_list);
-
-	g_clear_error(&error);
-
-	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_FAVORITE_TECHS, &len, &error);
-
-	if (!error)
-		connman_settings.favorite_techs =
-			parse_service_types(str_list, len);
-	else
-		connman_settings.favorite_techs =
-			parse_service_types(default_favorite_techs, CONF_ARRAY_SIZE(default_favorite_techs));
-
-	g_strfreev(str_list);
-
-	g_clear_error(&error);
-
-	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_PREFERRED_TECHS, &len, &error);
-
-	if (!error)
-		connman_settings.preferred_techs =
-			parse_service_types(str_list, len);
-
-	g_strfreev(str_list);
-
-	g_clear_error(&error);
-
-	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_ALWAYS_CONNECTED_TECHS, &len, &error);
-
-	if (!error)
-		connman_settings.always_connected_techs =
-			parse_service_types(str_list, len);
-
-	g_strfreev(str_list);
-
-	g_clear_error(&error);
-
-	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_FALLBACK_NAMESERVERS, &len, &error);
+	/* Always return false to avoid the string to be set */
+	return false;
+}
 
-	if (!error)
-		connman_settings.fallback_nameservers =
-			parse_fallback_nameservers(str_list, len);
+static gboolean check_online_check_interval_style(const char *str)
+{
+	if ((g_strcmp0(str, ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI) == 0) ||
+		(g_strcmp0(str, ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC) == 0)) {
+		return true;
+	} else {
+		connman_warn("Incorrect online check interval style [%s]", str);
+		return false;
+	}
+}
 
-	g_strfreev(str_list);
+/* String parse callbacks */
+typedef char** (*str_list_parse_callback) (char **str_list, gsize *len);
 
-	g_clear_error(&error);
+/* Error callbacks */
+typedef gboolean (*error_callback) (void);
 
-	integer = g_key_file_get_integer(config, GENERAL_GROUP,
-			CONF_TIMEOUT_INPUTREQ, &error);
-	if (!error && integer >= 0)
-		connman_settings.timeout_inputreq = integer * 1000;
+static int online_check_connect_timeout_error(void)
+{
+	connman_warn("Incorrect online check connect timeout");
+	connman_settings.online_check_connect_timeout_ms =
+				DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT;
 
-	g_clear_error(&error);
+	return 0;
+}
 
-	integer = g_key_file_get_integer(config, GENERAL_GROUP,
-			CONF_TIMEOUT_BROWSERLAUNCH, &error);
-	if (!error && integer >= 0)
-		connman_settings.timeout_browserlaunch = integer * 1000;
+static void set_str(char **ptr, char *value, str_check_callback cb)
+{
+	if (*ptr)
+		g_free(*ptr);
 
-	g_clear_error(&error);
+	if (cb && !cb(value)) {
+		g_free(value);
+		return;
+	}
 
-	interfaces = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_BLACKLISTED_INTERFACES, &len, &error);
+	*ptr = value;
+}
 
-	if (!error)
-		connman_settings.blacklisted_interfaces = interfaces;
-	else
-		connman_settings.blacklisted_interfaces =
-			g_strdupv(default_blacklist);
+static void set_str_list(char ***ptr, char **value, gsize len, bool append)
+{
+	if (append) {
+		/* TODO */
+		DBG("append is ENOTSUP");
+	}
 
-	g_clear_error(&error);
+	if (*ptr)
+		g_strfreev(*ptr);
 
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-					CONF_ALLOW_HOSTNAME_UPDATES,
-					&error);
-	if (!error)
-		connman_settings.allow_hostname_updates = boolean;
+	*ptr = value;
+}
 
-	g_clear_error(&error);
+typedef void (*str_list_callback) (const char *value);
 
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-					CONF_ALLOW_DOMAINNAME_UPDATES,
-					&error);
-	if (!error)
-		connman_settings.allow_domainname_updates = boolean;
+static void set_str_list_cb(char **value, str_list_callback cb, gsize len,
+								bool append)
+{
+	int i;
 
-	g_clear_error(&error);
+	if (append) {
+		/* TODO */
+		DBG("append is ENOTSUP");
+	}
 
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-			CONF_SINGLE_TECH, &error);
-	if (!error)
-		connman_settings.single_tech = boolean;
+	for (i = 0; i < len; i++)
+		cb(value[i]);
+}
 
-	g_clear_error(&error);
+static void set_int_list(unsigned int **ptr, unsigned int *value, bool append)
+{
+	if (append) {
+		/* TODO */
+		DBG("append is ENOTSUP");
+	}
 
-	tethering = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_TETHERING_TECHNOLOGIES, &len, &error);
+	if (*ptr)
+		g_free(*ptr);
 
-	if (!error)
-		connman_settings.tethering_technologies = tethering;
+	*ptr = value;
+}
 
-	g_clear_error(&error);
+static void set_hash_table(GHashTable **ptr, char **value, gsize len,
+								bool append)
+{
+	if (append) {
+		/* TODO */
+		DBG("append is ENOTSUP");
+	}
 
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-					CONF_PERSISTENT_TETHERING_MODE,
-					&error);
-	if (!error)
-		connman_settings.persistent_tethering_mode = boolean;
+	if (*ptr)
+		g_hash_table_destroy(*ptr);
+	*ptr = parse_fallback_device_types(value, len);
+}
 
-	g_clear_error(&error);
+static void set_value(GKeyFile *config, const char *key, bool append)
+{
+	GError *error = NULL;
+	const char *group = "General";
+	char *def_str = NULL;
+	char **def_str_list = NULL;
+	enum supported_options_val key_value;
+	str_check_callback check_cb = NULL;
+	str_list_callback list_cb = NULL;
+	str_list_parse_callback parse_cb = NULL;
+	error_callback error_cb = NULL;
+	gsize def_str_list_len = 0;
+	gsize len;
+	int int_multiplier = 1;
+
+	/* Ptrs for options */
+	GHashTable **hash_table_ptr = NULL;
+	char ***str_list_ptr = NULL;
+	char **str_ptr = NULL;
+	bool *bool_ptr = NULL;
+	unsigned int **int_list_ptr = NULL;
+	unsigned int *int_ptr = NULL;
+	/* Handle the value as real but save as an int */
+	unsigned int *double_ptr = NULL;
+
+	/* Dummy ptrs*/
+	char *str_dummy = NULL;
+
+	key_value = conf_key_to_int(key);
+
+	/* TODO: use a better structure, like struct with union in htable */
+	switch (key_value) {
+	/* bool */
+	/* BackgroundScanning */
+	case CONF_BG_SCAN_VAL:
+		bool_ptr = &connman_settings.bg_scan;
+		break;
+	/* AllowHostnameUpdates */
+	case CONF_ALLOW_HOSTNAME_UPDATES_VAL:
+		bool_ptr = &connman_settings.allow_hostname_updates;
+		break;
+	/* AllowDomainnameUpdates */
+	case CONF_ALLOW_DOMAINNAME_UPDATES_VAL:
+		bool_ptr = &connman_settings.allow_domainname_updates;
+		break;
+	/* SingleConnectedTechnology */
+	case CONF_SINGLE_TECH_VAL:
+		bool_ptr = &connman_settings.single_tech;
+		break;
+	/* PersistentTetheringMode */
+	case CONF_PERSISTENT_TETHERING_MODE_VAL:
+		bool_ptr = &connman_settings.persistent_tethering_mode;
+		break;
+	/* Enable6to4 */
+	case CONF_ENABLE_6TO4_VAL:
+		bool_ptr = &connman_settings.enable_6to4;
+		break;
+	/* EnableOnlineCheck */
+	case CONF_ENABLE_ONLINE_CHECK_VAL:
+		bool_ptr = &connman_settings.enable_online_check;
+		break;
+	/* EnableOnlineToReadyTransition */
+	case CONF_ENABLE_ONLINE_TO_READY_TRANSITION_VAL:
+		bool_ptr = &connman_settings.enable_online_to_ready_transition;
+		break;
+	/* AutoConnectRoamingServices */
+	case CONF_AUTO_CONNECT_ROAMING_SERVICES_VAL:
+		bool_ptr = &connman_settings.auto_connect_roaming_services;
+		break;
+	/* AddressConflictDetection */
+	case CONF_ACD_VAL:
+		bool_ptr = &connman_settings.acd;
+		break;
+	/* UseGatewaysAsTimeservers */
+	case CONF_USE_GATEWAYS_AS_TIMESERVERS_VAL:
+		bool_ptr = &connman_settings.use_gateways_as_timeservers;
+		break;
+	/* RegdomFollowsTimezone */
+	case CONF_REGDOM_FOLLOWS_TIMEZONE_VAL:
+		bool_ptr = &connman_settings.regdom_follows_timezone;
+		break;
 
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-					CONF_ENABLE_6TO4, &error);
-	if (!error)
-		connman_settings.enable_6to4 = boolean;
+	/* str */
+	/* VendorClassID */
+	case CONF_VENDOR_CLASS_ID_VAL:
+		str_ptr = &connman_settings.vendor_class_id;
+		break;
+	/* OnlineCheckMode */
+	case CONF_ONLINE_CHECK_MODE_VAL:
+		/*
+		 * OnlineCheckMode is read as string but handled as an enum,
+		 * use str_dummy here to trigger the str handling and let the
+		 * callback to handle the real value setting. Callback always
+		 * returns 'false' to avoid setting the value to the str_dummy.
+		 */
+		str_ptr = &str_dummy;
+		check_cb = check_online_mode;
+		error_cb = online_check_mode_set_from_deprecated;
+		break;
+	/* OnlineCheckIPv4URL */
+	case CONF_ONLINE_CHECK_IPV4_URL_VAL:
+		str_ptr = &connman_settings.online_check_ipv4_url;
+		def_str = DEFAULT_ONLINE_CHECK_IPV4_URL;
+		break;
+	/* OnlineCheckIPv6URL */
+	case CONF_ONLINE_CHECK_IPV6_URL_VAL:
+		str_ptr = &connman_settings.online_check_ipv6_url;
+		def_str = DEFAULT_ONLINE_CHECK_IPV6_URL;
+		break;
+	/* Localtime */
+	case CONF_LOCALTIME_VAL:
+		str_ptr = &connman_settings.localtime;
+		break;
+	/* OnlineCheckIntervalStyle */
+	case CONF_ONLINE_CHECK_INTERVAL_STYLE_VAL:
+		str_ptr = &connman_settings.online_check_interval_style;
+		def_str = DEFAULT_ONLINE_CHECK_INTERVAL_STYLE;
+		check_cb = check_online_check_interval_style;
+		break;
+	/* ResolvConf */
+	case CONF_RESOLV_CONF_VAL:
+		str_ptr = &connman_settings.resolv_conf;
+		break;
 
-	g_clear_error(&error);
+	/* str list */
+	/* */
+	case CONF_PREF_TIMESERVERS_VAL:
+		str_list_ptr = &connman_settings.pref_timeservers;
+		break;
+	/* FallbackNameservers */
+	case CONF_FALLBACK_NAMESERVERS_VAL:
+		parse_cb = parse_fallback_nameservers;
+		break;
+	/* NetworkInterfaceBlacklist */
+	case CONF_BLACKLISTED_INTERFACES_VAL:
+		str_list_ptr = &connman_settings.blacklisted_interfaces;
+		def_str_list = default_blacklist;
+		def_str_list_len = CONF_ARRAY_SIZE(default_blacklist);
+		break;
+	/* TetheringTechnologies */
+	case CONF_TETHERING_TECHNOLOGIES_VAL:
+		str_list_ptr = &connman_settings.tethering_technologies;
+		break;
 
-	string = __connman_config_get_string(config, GENERAL_GROUP,
-					CONF_VENDOR_CLASS_ID, &error);
-	if (!error)
-		connman_settings.vendor_class_id = string;
+	/* int */
+	/* InputRequestTimeout */
+	case CONF_TIMEOUT_INPUTREQ_VAL:
+		int_ptr = &connman_settings.timeout_inputreq;
+		int_multiplier = 1000;
+		break;
+	/* BrowserLaunchTimeout */
+	case CONF_TIMEOUT_BROWSERLAUNCH_VAL:
+		int_ptr = &connman_settings.timeout_browserlaunch;
+		int_multiplier = 1000;
+		break;
+	/* OnlineCheckInitialInterval */
+	case CONF_ONLINE_CHECK_INITIAL_INTERVAL_VAL:
+		int_ptr = &connman_settings.online_check_initial_interval;
+		break;
+	/* OnlineCheckMaxInterval */
+	case CONF_ONLINE_CHECK_MAX_INTERVAL_VAL:
+		int_ptr = &connman_settings.online_check_max_interval;
+		break;
+	/* OnlineCheckFailuresThreshold */
+	case CONF_ONLINE_CHECK_FAILURES_THRESHOLD_VAL:
+		int_ptr = &connman_settings.online_check_failures_threshold;
+		break;
+	/* OnlineCheckSuccessesThreshold */
+	case CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD_VAL:
+		int_ptr = &connman_settings.online_check_successes_threshold;
+		break;
 
-	g_clear_error(&error);
+	/* int array */
+	/* DefaultAutoConnectTechnologies */
+	case CONF_AUTO_CONNECT_TECHS_VAL:
+		int_list_ptr = &connman_settings.auto_connect;
+		def_str_list = default_auto_connect;
+		def_str_list_len = CONF_ARRAY_SIZE(default_auto_connect);
+		break;
+	/* DefaultEnabledTechnologies */
+	case CONF_ENABLED_TECHS_VAL:
+		int_list_ptr = &connman_settings.enabled_techs;
+		def_str_list = default_enabled_techs;
+		def_str_list_len = CONF_ARRAY_SIZE(default_enabled_techs);
+		break;
+	/* DefaultFavoriteTechnologies */
+	case CONF_FAVORITE_TECHS_VAL:
+		int_list_ptr = &connman_settings.favorite_techs;
+		def_str_list = default_favorite_techs;
+		def_str_list_len = CONF_ARRAY_SIZE(default_favorite_techs);
+		break;
+	/* AlwaysConnectedTechnologies */
+	case CONF_ALWAYS_CONNECTED_TECHS_VAL:
+		int_list_ptr = &connman_settings.always_connected_techs;
+		break;
+	/* PreferredTechnologies */
+	case CONF_PREFERRED_TECHS_VAL:
+		int_list_ptr = &connman_settings.preferred_techs;
+		break;
 
-	/* EnableOnlineCheck */
+	/* double/real, saved as unsigned int ) */
+	/* OnlineCheckConnectTimeout */
+	case CONF_ONLINE_CHECK_CONNECT_TIMEOUT_VAL:
+		double_ptr = &connman_settings.online_check_connect_timeout_ms;
+		int_multiplier = 1000;
+		error_cb = online_check_connect_timeout_error;
+		break;
 
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-					CONF_ENABLE_ONLINE_CHECK, &error);
-	if (!error) {
-		connman_warn("\"%s\" is deprecated; use \"%s\" instead.",
-			CONF_ENABLE_ONLINE_CHECK,
-			CONF_ONLINE_CHECK_MODE);
+	/* GHashTable */
+	/* FallbackDeviceTypes */
+	case CONF_FALLBACK_DEVICE_TYPES_VAL:
+		hash_table_ptr = &connman_settings.fallback_device_types;
+		break;
 
-		connman_settings.enable_online_check = boolean;
+	default:
+		break;
 	}
 
-	g_clear_error(&error);
+	if (bool_ptr) {
+		bool boolean = __connman_config_get_bool(config, group, key,
+									&error);
+		if (!error)
+			*bool_ptr = boolean;
+	}
 
-	/* EnableOnlineToReadyTransition */
+	if (str_ptr) {
+		char *str = g_key_file_get_string(config, group, key, &error);
+		if (!error)
+			set_str(str_ptr, str, check_cb);
+		else if (error_cb) // Do error handling
+			error_cb();
 
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-			CONF_ENABLE_ONLINE_TO_READY_TRANSITION, &error);
-	if (!error) {
-		connman_warn("\"%s\" is deprecated; use \"%s\" instead.",
-			CONF_ENABLE_ONLINE_TO_READY_TRANSITION,
-			CONF_ONLINE_CHECK_MODE);
+		if (!*str_ptr && def_str)
+			set_str(str_ptr, g_strdup(def_str), check_cb);
+	}
 
-		connman_settings.enable_online_to_ready_transition = boolean;
+	if (str_list_ptr || list_cb) {
+		char **str_list = __connman_config_get_string_list(config,
+						group, key, &len, &error);
+		if (!error) {
+			if (list_cb) {
+				set_str_list_cb(str_list, list_cb, len, append);
+				g_strfreev(str_list);
+			} else if (parse_cb) {
+				char **new_str_list = parse_cb(str_list, &len);
+				g_strfreev(str_list);
+
+				if (new_str_list)
+					set_str_list(str_list_ptr, new_str_list,
+								len, append);
+			} else {
+				set_str_list(str_list_ptr, str_list, len,
+									append);
+			}
+		} else if (str_list_ptr && def_str_list) {
+			set_str_list(str_list_ptr, g_strdupv(def_str_list),
+						def_str_list_len, append);
+		}
 	}
 
-	g_clear_error(&error);
+	if (int_ptr) {
+		int value = g_key_file_get_integer(config, group, key, &error);
+		if (!error && value >= 0)
+			*int_ptr = value * int_multiplier;
+	}
 
-	/* OnlineCheckMode */
+	if (int_list_ptr) {
+		char **str_list = __connman_config_get_string_list(config,
+						group, key, &len, &error);
+		if (!error)
+			set_int_list(int_list_ptr,
+					parse_service_types(str_list, len),
+					append);
+		else if (def_str_list)
+			set_int_list(int_list_ptr,
+					parse_service_types(def_str_list,
+						def_str_list_len),
+					append);
+		g_strfreev(str_list);
+	}
 
-	string = __connman_config_get_string(config, GENERAL_GROUP,
-				CONF_ONLINE_CHECK_MODE, &error);
-	if (!error) {
-		connman_settings.online_check_mode =
-			__connman_service_online_check_string2mode(string);
-		if (connman_settings.online_check_mode ==
-			CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN) {
-			connman_error("Invalid online check mode \"%s\"",
-				string);
-
-			online_check_mode_set_from_deprecated();
-		} else
-			online_check_mode_set_to_deprecated();
-	} else
-		online_check_mode_set_from_deprecated();
+	if (double_ptr) {
+		double real = g_key_file_get_double(config, group, key, &error);
 
-	g_clear_error(&error);
+		if (!error) {
+			if (real < 0 && error_cb)
+				error_cb();
+			else
+				*double_ptr = real * 1000;
+		}
+	}
 
-	/* OnlineCheckConnectTimeout */
+	if (hash_table_ptr) {
+		char **str_list = __connman_config_get_string_list(config,
+						group, key, &len, &error);
+		if (!error)
+			set_hash_table(hash_table_ptr, str_list, len, append);
 
-	real = g_key_file_get_double(config, GENERAL_GROUP,
-			CONF_ONLINE_CHECK_CONNECT_TIMEOUT, &error);
-	if (!error) {
-		if (real < 0) {
-			connman_warn("Incorrect online check connect timeout %f",
-				real);
-			connman_settings.online_check_connect_timeout_ms =
-				DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT;
-		} else
-			connman_settings.online_check_connect_timeout_ms =
-				real * 1000;
+		g_strfreev(str_list);
 	}
 
 	g_clear_error(&error);
+}
 
-	/* OnlineCheckIPv4URL */
+static void parse_config(GKeyFile *config, const char *file, bool append)
+{
+	int i;
 
-	string = __connman_config_get_string(config, GENERAL_GROUP,
-					CONF_ONLINE_CHECK_IPV4_URL, &error);
-	if (!error)
-		connman_settings.online_check_ipv4_url = string;
-	else
+	if (!config || !file) {
+		connman_settings.auto_connect =
+			parse_service_types(default_auto_connect,
+				CONF_ARRAY_SIZE(default_auto_connect));
+		connman_settings.enabled_techs =
+			parse_service_types(default_enabled_techs,
+				CONF_ARRAY_SIZE(default_enabled_techs));
+		connman_settings.favorite_techs =
+			parse_service_types(default_favorite_techs,
+				CONF_ARRAY_SIZE(default_favorite_techs));
+		connman_settings.blacklisted_interfaces =
+			g_strdupv(default_blacklist);
 		connman_settings.online_check_ipv4_url =
 			g_strdup(DEFAULT_ONLINE_CHECK_IPV4_URL);
-
-	g_clear_error(&error);
-
-	/* OnlineCheckIPv6URL */
-
-	string = __connman_config_get_string(config, GENERAL_GROUP,
-					CONF_ONLINE_CHECK_IPV6_URL, &error);
-	if (!error)
-		connman_settings.online_check_ipv6_url = string;
-	else
 		connman_settings.online_check_ipv6_url =
 			g_strdup(DEFAULT_ONLINE_CHECK_IPV6_URL);
+		connman_settings.online_check_interval_style =
+			g_strdup(DEFAULT_ONLINE_CHECK_INTERVAL_STYLE);
+		return;
+	}
 
-	g_clear_error(&error);
-
-	/* OnlineCheck{Initial,Max}Interval */
-
-	integer = g_key_file_get_integer(config, GENERAL_GROUP,
-			CONF_ONLINE_CHECK_INITIAL_INTERVAL, &error);
-	if (!error && integer >= 0)
-		connman_settings.online_check_initial_interval = integer;
-
-	g_clear_error(&error);
+	DBG("parsing %s", file);
 
-	integer = g_key_file_get_integer(config, GENERAL_GROUP,
-			CONF_ONLINE_CHECK_MAX_INTERVAL, &error);
-	if (!error && integer >= 0)
-		connman_settings.online_check_max_interval = integer;
+	for (i = 0; supported_options[i]; i++) {
+		set_value(config, supported_options[i], append);
+	}
 
-	g_clear_error(&error);
+	if (!connman_settings.enable_online_check)
+		connman_info("Online check disabled by main config.");
 
 	if (connman_settings.online_check_initial_interval < 1 ||
 		connman_settings.online_check_initial_interval >
@@ -793,13 +988,6 @@ static void parse_config(GKeyFile *config, const char *file)
 			DEFAULT_ONLINE_CHECK_MAX_INTERVAL;
 	}
 
-	/* OnlineCheckFailuresThreshold */
-
-	integer = g_key_file_get_integer(config, GENERAL_GROUP,
-			CONF_ONLINE_CHECK_FAILURES_THRESHOLD, &error);
-	if (!error && integer >= 0)
-		connman_settings.online_check_failures_threshold = integer;
-
 	if (connman_settings.online_check_failures_threshold < 1) {
 		connman_warn("Incorrect online check failures threshold [%d]",
 			connman_settings.online_check_failures_threshold);
@@ -807,15 +995,6 @@ static void parse_config(GKeyFile *config, const char *file)
 			DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD;
 	}
 
-	g_clear_error(&error);
-
-	/* OnlineCheckSuccessesThreshold */
-
-	integer = g_key_file_get_integer(config, GENERAL_GROUP,
-			CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD, &error);
-	if (!error && integer >= 0)
-		connman_settings.online_check_successes_threshold = integer;
-
 	if (connman_settings.online_check_successes_threshold < 1) {
 		connman_warn("Incorrect online check successes threshold [%d]",
 			connman_settings.online_check_successes_threshold);
@@ -823,101 +1002,27 @@ static void parse_config(GKeyFile *config, const char *file)
 			DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD;
 	}
 
-	g_clear_error(&error);
-
-	/* OnlineCheckIntervalStyle */
-
-	string = __connman_config_get_string(config, GENERAL_GROUP,
-					CONF_ONLINE_CHECK_INTERVAL_STYLE, &error);
-	if (!error) {
-		if ((g_strcmp0(string, ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI) == 0) ||
-			(g_strcmp0(string, ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC) == 0)) {
-			connman_settings.online_check_interval_style = string;
-		} else {
-			connman_warn("Incorrect online check interval style [%s]",
-				string);
-			connman_settings.online_check_interval_style =
-				g_strdup(DEFAULT_ONLINE_CHECK_INTERVAL_STYLE);
-		}
-	} else
-		connman_settings.online_check_interval_style =
-			g_strdup(DEFAULT_ONLINE_CHECK_INTERVAL_STYLE);
-
-	g_clear_error(&error);
-
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-				CONF_AUTO_CONNECT_ROAMING_SERVICES, &error);
-	if (!error)
-		connman_settings.auto_connect_roaming_services = boolean;
-
-	g_clear_error(&error);
-
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-				CONF_ACD, &error);
-	if (!error)
-		connman_settings.acd = boolean;
-
-	g_clear_error(&error);
-
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-				CONF_USE_GATEWAYS_AS_TIMESERVERS, &error);
-	if (!error)
-		connman_settings.use_gateways_as_timeservers = boolean;
-
-	g_clear_error(&error);
-
-	string = __connman_config_get_string(config, GENERAL_GROUP,
-				CONF_LOCALTIME, &error);
-	if (!error)
-		connman_settings.localtime = string;
-	else
-		g_free(string);
-
-	g_clear_error(&error);
-
-	boolean = __connman_config_get_bool(config, GENERAL_GROUP,
-				CONF_REGDOM_FOLLOWS_TIMEZONE, &error);
-	if (!error)
-		connman_settings.regdom_follows_timezone = boolean;
-
-	g_clear_error(&error);
-
-	string = __connman_config_get_string(config, GENERAL_GROUP,
-				CONF_RESOLV_CONF, &error);
-	if (!error)
-		connman_settings.resolv_conf = string;
-	else
-		g_free(string);
-
-	g_clear_error(&error);
-
 	online_check_settings_log();
-
-	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
-			CONF_FALLBACK_DEVICE_TYPES, &len, &error);
-
-	if (!error)
-		connman_settings.fallback_device_types =
-				parse_fallback_device_types(str_list, len);
-
-	g_strfreev(str_list);
-
-	g_clear_error(&error);
 }
 
-static int config_init(const char *file)
+static int config_init(const char *file, bool append)
 {
 	GKeyFile *config;
 
 	config = load_config(file);
 	check_config(config, file);
-	parse_config(config, file);
+	parse_config(config, file, append);
 	if (config)
 		g_key_file_free(config);
 
 	return 0;
 }
 
+static int config_read(const char *file)
+{
+	return config_init(file, false);
+}
+
 static GMainLoop *main_loop = NULL;
 
 static unsigned int __terminated = 0;
@@ -1293,15 +1398,15 @@ int main(int argc, char *argv[])
 	__connman_dbus_init(conn);
 
 	if (!option_config)
-		config_init(CONFIGMAINFILE);
+		config_init(CONFIGMAINFILE, false);
 	else
-		config_init(option_config);
+		config_init(option_config, false);
 
 	fs_err = util_read_config_files_from(CONFIGMAINDIR, CONFIGSUFFIX,
-				NULL, config_init);
+				NULL, config_read);
 	if (fs_err && fs_err != -ENOTDIR)
 		connman_error("failed to read configs from %s: %s",
-				CONFIGMAINDIR, strerror(fs_err));
+				CONFIGMAINDIR, strerror(-fs_err));
 
 	__connman_util_init();
 	__connman_inotify_init();
-- 
2.47.3

