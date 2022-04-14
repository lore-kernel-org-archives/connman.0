Received: from griffin.geeknet.cz (griffin.geeknet.cz [94.142.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952A7A
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 00:12:24 +0000 (UTC)
Received: 
	by griffin.geeknet.cz (OpenSMTPD) with ESMTP id c2f7706b
	for <connman@lists.linux.dev>;
	Thu, 14 Apr 2022 02:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jirutka.cz; h=from:to:cc
	:subject:date:message-id; s=mail; bh=imGW8o1urEvtJ+0qWeqsJwZ7lrw
	=; b=ZGxrTnDM32vjtytQwW7ppu5Kz5kQ10ifwjEOZv8htlONustxQ8A8b5EUY2h
	+0VVVqrEkSLSob3KmotbLZZzdvSflYB1Nl/6lPCsST1nwL2eFJk+/h4DBvpO4ExC
	aRMDdP/V0nJWhHja5g542vvOoSibfnIEVwr8YFGNCnko3isc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=jirutka.cz; h=from:to:cc
	:subject:date:message-id; q=dns; s=mail; b=lBx4ZfG57CVO8nueISb0D
	/H7FY6UiMri89cGonwjsTzZOZO/eks7yPtk7SrNuSSdOelytRhTbVNI3bJDwNtnI
	EC3xn7bXQQe1N+tcrDo4Cq6rY7oupielHnxsxuf4V8Kt8yIuqjO8lSbtCAOAXrak
	YyUWEKCXt3kfO/vg7UCe20=
Received: 
	by griffin.geeknet.cz (OpenSMTPD) with ESMTPSA id 88cc8ec3 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
	Thu, 14 Apr 2022 02:12:22 +0200 (CEST)
From: Jakub Jirutka <jakub@jirutka.cz>
To: connman@lists.linux.dev
Cc: Jakub Jirutka <jakub@jirutka.cz>
Subject: [PATCH] timeserver: Add EnableNTPClient option to connman.conf
Date: Thu, 14 Apr 2022 02:12:08 +0200
Message-Id: <20220414001208.4026-1-jakub@jirutka.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>

The builtin NTP client can now only be disabled via DBus or manually
editing the state file /var/lib/connman/settings
(`TimeUpdates = "manual"`). These options are not optimal for a setup
where a standalone NTP client is used.

The approach for disabling NTP client (in timeserver.c) is based on the
existing code for handling state setting `TimeUpdates = "manual"`.

I originally wanted to implement this using CLI option, just
like --nodnsproxy, but after reading the message from Daniel Wagner
on ML (Unification to connman configuration? Now it 3 separated places)
regarding --nodnsproxy, I concluded that the config file is preferred.
---
 doc/connman.conf.5.in |  4 ++++
 src/main.c            | 12 ++++++++++++
 src/timeserver.c      |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index cb36e9fb..9c25cf9d 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -52,6 +52,10 @@ When BackgroundScanning is false, ConnMan will not perform any scan
 regardless of wifi is connected or not, unless it is requested by
 the user through a D-Bus call.
 .TP
+.BI EnableNTPClient=true \fR|\fB\ false
+Enable or disable the builtin NTP client.
+Default is true.
+.TP
 .BI UseGatewaysAsTimeservers=true \fR|\fB\ false
 Assume that service gateways also function as timeservers.
 Default is false.
diff --git a/src/main.c b/src/main.c
index 5c632fd1..f2fc073b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -110,6 +110,7 @@ static struct {
 	bool use_gateways_as_timeservers;
 	char *localtime;
 	bool regdom_follows_timezone;
+	bool enable_ntp_client;
 } connman_settings  = {
 	.bg_scan = true,
 	.pref_timeservers = NULL,
@@ -138,6 +139,7 @@ static struct {
 	.acd = false,
 	.use_gateways_as_timeservers = false,
 	.localtime = NULL,
+	.enable_ntp_client = true,
 };
 
 #define CONF_BG_SCAN                    "BackgroundScanning"
@@ -168,6 +170,7 @@ static struct {
 #define CONF_USE_GATEWAYS_AS_TIMESERVERS "UseGatewaysAsTimeservers"
 #define CONF_LOCALTIME                  "Localtime"
 #define CONF_REGDOM_FOLLOWS_TIMEZONE    "RegdomFollowsTimezone"
+#define CONF_ENABLE_NTP_CLIENT          "EnableNTPClient"
 
 static const char *supported_options[] = {
 	CONF_BG_SCAN,
@@ -198,6 +201,7 @@ static const char *supported_options[] = {
 	CONF_USE_GATEWAYS_AS_TIMESERVERS,
 	CONF_LOCALTIME,
 	CONF_REGDOM_FOLLOWS_TIMEZONE,
+	CONF_ENABLE_NTP_CLIENT,
 	NULL
 };
 
@@ -594,6 +598,11 @@ static void parse_config(GKeyFile *config)
 	if (!error)
 		connman_settings.regdom_follows_timezone = boolean;
 
+	boolean = __connman_config_get_bool(config, "General",
+				CONF_ENABLE_NTP_CLIENT, &error);
+	if (!error)
+		connman_settings.enable_ntp_client = boolean;
+
 	g_clear_error(&error);
 }
 
@@ -830,6 +839,9 @@ bool connman_setting_get_bool(const char *key)
 	if (g_str_equal(key, CONF_REGDOM_FOLLOWS_TIMEZONE))
 		return connman_settings.regdom_follows_timezone;
 
+	if (g_str_equal(key, CONF_ENABLE_NTP_CLIENT))
+		return connman_settings.enable_ntp_client;
+
 	return false;
 }
 
diff --git a/src/timeserver.c b/src/timeserver.c
index 4c25d4b8..4be954b2 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -240,6 +240,9 @@ GSList *__connman_timeserver_get_all(struct connman_service *service)
 	char **fallback_ts;
 	int index, i;
 
+	if (!connman_setting_get_bool("EnableNTPClient"))
+		return NULL;
+
 	if (__connman_clock_timeupdates() == TIME_UPDATES_MANUAL)
 		return NULL;
 
-- 
2.16.4

