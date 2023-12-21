Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3322BE4B
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 02F3973122
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 02:05:25 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B1D5773147
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 02:05:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] main: Use static global rather than 'General' string literal.
Date: Wed, 20 Dec 2023 23:05:23 -0800
Message-ID: <20231221070523.2354507-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This converts a potential run time error due to a mis-spelling of the
"General" configuration group name repeatedly used a string literal
into a potential compile time error due to a mis-spelling of the
static global that now references it once and only once.
---
 src/main.c | 85 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/src/main.c b/src/main.c
index 241c713d7980..c01a9e59d11c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -69,6 +69,16 @@
 #define MAINFILE "main.conf"
 #define CONFIGMAINFILE CONFIGDIR "/" MAINFILE
 
+/*
+ * This is declared as 'const char *const' to effect an immutable
+ * pointer to an immutable null-terminated character string such that
+ * it ends up in .text, not .data (which would otherwise be the case
+ * for a 'const char *' declaration), and with the 'static'
+ * storage/scope qualifier, the compiler can optimize its use within
+ * this file as it sees fit.
+ */
+static const char *const general_group_name = "General";
+
 static char *default_auto_connect[] = {
 	"wifi",
 	"ethernet",
@@ -321,14 +331,14 @@ static void check_config(GKeyFile *config)
 	keys = g_key_file_get_groups(config, NULL);
 
 	for (j = 0; keys && keys[j]; j++) {
-		if (g_strcmp0(keys[j], "General") != 0)
+		if (g_strcmp0(keys[j], general_group_name) != 0)
 			connman_warn("Unknown group %s in %s",
 						keys[j], MAINFILE);
 	}
 
 	g_strfreev(keys);
 
-	keys = g_key_file_get_keys(config, "General", NULL, NULL);
+	keys = g_key_file_get_keys(config, general_group_name, NULL, NULL);
 
 	for (j = 0; keys && keys[j]; j++) {
 		bool found;
@@ -450,21 +460,22 @@ static void parse_config(GKeyFile *config)
 
 	DBG("parsing %s", MAINFILE);
 
-	boolean = g_key_file_get_boolean(config, "General",
+	boolean = g_key_file_get_boolean(config, general_group_name,
 						CONF_BG_SCAN, &error);
 	if (!error)
 		connman_settings.bg_scan = boolean;
 
 	g_clear_error(&error);
 
-	timeservers = __connman_config_get_string_list(config, "General",
+	timeservers = __connman_config_get_string_list(config,
+					general_group_name,
 					CONF_PREF_TIMESERVERS, NULL, &error);
 	if (!error)
 		connman_settings.pref_timeservers = timeservers;
 
 	g_clear_error(&error);
 
-	str_list = __connman_config_get_string_list(config, "General",
+	str_list = __connman_config_get_string_list(config, general_group_name,
 			CONF_AUTO_CONNECT_TECHS, &len, &error);
 
 	if (!error)
@@ -478,7 +489,7 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	str_list = __connman_config_get_string_list(config, "General",
+	str_list = __connman_config_get_string_list(config, general_group_name,
 			CONF_FAVORITE_TECHS, &len, &error);
 
 	if (!error)
@@ -492,7 +503,7 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	str_list = __connman_config_get_string_list(config, "General",
+	str_list = __connman_config_get_string_list(config, general_group_name,
 			CONF_PREFERRED_TECHS, &len, &error);
 
 	if (!error)
@@ -503,7 +514,7 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	str_list = __connman_config_get_string_list(config, "General",
+	str_list = __connman_config_get_string_list(config, general_group_name,
 			CONF_ALWAYS_CONNECTED_TECHS, &len, &error);
 
 	if (!error)
@@ -514,7 +525,7 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	str_list = __connman_config_get_string_list(config, "General",
+	str_list = __connman_config_get_string_list(config, general_group_name,
 			CONF_FALLBACK_NAMESERVERS, &len, &error);
 
 	if (!error)
@@ -525,21 +536,22 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	integer = g_key_file_get_integer(config, "General",
+	integer = g_key_file_get_integer(config, general_group_name,
 			CONF_TIMEOUT_INPUTREQ, &error);
 	if (!error && integer >= 0)
 		connman_settings.timeout_inputreq = integer * 1000;
 
 	g_clear_error(&error);
 
-	integer = g_key_file_get_integer(config, "General",
+	integer = g_key_file_get_integer(config, general_group_name,
 			CONF_TIMEOUT_BROWSERLAUNCH, &error);
 	if (!error && integer >= 0)
 		connman_settings.timeout_browserlaunch = integer * 1000;
 
 	g_clear_error(&error);
 
-	interfaces = __connman_config_get_string_list(config, "General",
+	interfaces = __connman_config_get_string_list(config,
+			general_group_name,
 			CONF_BLACKLISTED_INTERFACES, &len, &error);
 
 	if (!error)
@@ -550,7 +562,7 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 					CONF_ALLOW_HOSTNAME_UPDATES,
 					&error);
 	if (!error)
@@ -558,7 +570,7 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 					CONF_ALLOW_DOMAINNAME_UPDATES,
 					&error);
 	if (!error)
@@ -566,14 +578,14 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 			CONF_SINGLE_TECH, &error);
 	if (!error)
 		connman_settings.single_tech = boolean;
 
 	g_clear_error(&error);
 
-	tethering = __connman_config_get_string_list(config, "General",
+	tethering = __connman_config_get_string_list(config, general_group_name,
 			CONF_TETHERING_TECHNOLOGIES, &len, &error);
 
 	if (!error)
@@ -581,7 +593,7 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 					CONF_PERSISTENT_TETHERING_MODE,
 					&error);
 	if (!error)
@@ -589,14 +601,14 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 					CONF_ENABLE_6TO4, &error);
 	if (!error)
 		connman_settings.enable_6to4 = boolean;
 
 	g_clear_error(&error);
 
-	string = __connman_config_get_string(config, "General",
+	string = __connman_config_get_string(config, general_group_name,
 					CONF_VENDOR_CLASS_ID, &error);
 	if (!error)
 		connman_settings.vendor_class_id = string;
@@ -605,7 +617,7 @@ static void parse_config(GKeyFile *config)
 
 	/* EnableOnlineCheck */
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 					CONF_ENABLE_ONLINE_CHECK, &error);
 	if (!error) {
 		connman_warn("\"%s\" is deprecated; use \"%s\" instead.",
@@ -619,7 +631,7 @@ static void parse_config(GKeyFile *config)
 
 	/* EnableOnlineToReadyTransition */
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 			CONF_ENABLE_ONLINE_TO_READY_TRANSITION, &error);
 	if (!error) {
 		connman_warn("\"%s\" is deprecated; use \"%s\" instead.",
@@ -633,7 +645,7 @@ static void parse_config(GKeyFile *config)
 
 	/* OnlineCheckMode */
 
-	string = __connman_config_get_string(config, "General",
+	string = __connman_config_get_string(config, general_group_name,
 				CONF_ONLINE_CHECK_MODE, &error);
 	if (!error) {
 		connman_settings.online_check_mode =
@@ -653,7 +665,7 @@ static void parse_config(GKeyFile *config)
 
 	/* OnlineCheckConnectTimeout */
 
-	real = g_key_file_get_double(config, "General",
+	real = g_key_file_get_double(config, general_group_name,
 			CONF_ONLINE_CHECK_CONNECT_TIMEOUT, &error);
 	if (!error) {
 		if (real < 0) {
@@ -670,7 +682,7 @@ static void parse_config(GKeyFile *config)
 
 	/* OnlineCheckIPv4URL */
 
-	string = __connman_config_get_string(config, "General",
+	string = __connman_config_get_string(config, general_group_name,
 					CONF_ONLINE_CHECK_IPV4_URL, &error);
 	if (!error)
 		connman_settings.online_check_ipv4_url = string;
@@ -682,7 +694,7 @@ static void parse_config(GKeyFile *config)
 
 	/* OnlineCheckIPv6URL */
 
-	string = __connman_config_get_string(config, "General",
+	string = __connman_config_get_string(config, general_group_name,
 					CONF_ONLINE_CHECK_IPV6_URL, &error);
 	if (!error)
 		connman_settings.online_check_ipv6_url = string;
@@ -694,14 +706,14 @@ static void parse_config(GKeyFile *config)
 
 	/* OnlineCheck{Initial,Max}Interval */
 
-	integer = g_key_file_get_integer(config, "General",
+	integer = g_key_file_get_integer(config, general_group_name,
 			CONF_ONLINE_CHECK_INITIAL_INTERVAL, &error);
 	if (!error && integer >= 0)
 		connman_settings.online_check_initial_interval = integer;
 
 	g_clear_error(&error);
 
-	integer = g_key_file_get_integer(config, "General",
+	integer = g_key_file_get_integer(config, general_group_name,
 			CONF_ONLINE_CHECK_MAX_INTERVAL, &error);
 	if (!error && integer >= 0)
 		connman_settings.online_check_max_interval = integer;
@@ -722,7 +734,7 @@ static void parse_config(GKeyFile *config)
 
 	/* OnlineCheckFailuresThreshold */
 
-	integer = g_key_file_get_integer(config, "General",
+	integer = g_key_file_get_integer(config, general_group_name,
 			CONF_ONLINE_CHECK_FAILURES_THRESHOLD, &error);
 	if (!error && integer >= 0)
 		connman_settings.online_check_failures_threshold = integer;
@@ -738,7 +750,7 @@ static void parse_config(GKeyFile *config)
 
 	/* OnlineCheckSuccessesThreshold */
 
-	integer = g_key_file_get_integer(config, "General",
+	integer = g_key_file_get_integer(config, general_group_name,
 			CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD, &error);
 	if (!error && integer >= 0)
 		connman_settings.online_check_successes_threshold = integer;
@@ -754,7 +766,7 @@ static void parse_config(GKeyFile *config)
 
 	/* OnlineCheckIntervalStyle */
 
-	string = __connman_config_get_string(config, "General",
+	string = __connman_config_get_string(config, general_group_name,
 					CONF_ONLINE_CHECK_INTERVAL_STYLE, &error);
 	if (!error) {
 		if ((g_strcmp0(string, ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI) == 0) ||
@@ -772,27 +784,28 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 				CONF_AUTO_CONNECT_ROAMING_SERVICES, &error);
 	if (!error)
 		connman_settings.auto_connect_roaming_services = boolean;
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General", CONF_ACD, &error);
+	boolean = __connman_config_get_bool(config, general_group_name,
+				CONF_ACD, &error);
 	if (!error)
 		connman_settings.acd = boolean;
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 				CONF_USE_GATEWAYS_AS_TIMESERVERS, &error);
 	if (!error)
 		connman_settings.use_gateways_as_timeservers = boolean;
 
 	g_clear_error(&error);
 
-	string = __connman_config_get_string(config, "General",
+	string = __connman_config_get_string(config, general_group_name,
 				CONF_LOCALTIME, &error);
 	if (!error)
 		connman_settings.localtime = string;
@@ -801,14 +814,14 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	boolean = __connman_config_get_bool(config, "General",
+	boolean = __connman_config_get_bool(config, general_group_name,
 				CONF_REGDOM_FOLLOWS_TIMEZONE, &error);
 	if (!error)
 		connman_settings.regdom_follows_timezone = boolean;
 
 	g_clear_error(&error);
 
-	string = __connman_config_get_string(config, "General",
+	string = __connman_config_get_string(config, general_group_name,
 				CONF_RESOLV_CONF, &error);
 	if (!error)
 		connman_settings.resolv_conf = string;
-- 
2.42.0

