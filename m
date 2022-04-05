Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179392F2E
	for <connman@lists.linux.dev>; Tue,  5 Apr 2022 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 0e7d5506-b4ed-11ec-877a-005056bdfda7;
	Tue, 05 Apr 2022 17:31:18 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/4] main: Add RegdomFollowsTimezone option for regdom changes
Date: Tue,  5 Apr 2022 17:31:14 +0300
Message-Id: <20220405143116.2272080-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405143116.2272080-1-jussi.laakkonen@jolla.com>
References: <20220405143116.2272080-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This boolean option toggles whether the regdom is being changed along
timezone changes or not. By default the feature is off.
---
 doc/connman.conf.5.in |  6 ++++++
 src/main.c            | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index a64b8c6d..cb36e9fb 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -208,6 +208,12 @@ Default value is false.
 .TP
 .BI Localtime= string
 Path to localtime file. Defaults to /etc/localtime.
+.TP
+.BI RegdomFollowsTimezone= true\ \fR|\fB\ false
+Enable regdomain to be changed along timezone changes. With this option set to
+true each time the timezone changes the first present ISO3166 country code is
+being read from /usr/share/zoneinfo/zone1970.tab and set as regdom value.
+Default value is false.
 .SH "EXAMPLE"
 The following example configuration disables hostname updates and enables
 ethernet tethering.
diff --git a/src/main.c b/src/main.c
index 13b7e4bc..7b68a930 100644
--- a/src/main.c
+++ b/src/main.c
@@ -109,6 +109,7 @@ static struct {
 	bool acd;
 	bool use_gateways_as_timeservers;
 	char *localtime;
+	bool regdom_follows_timezone;
 } connman_settings  = {
 	.bg_scan = true,
 	.pref_timeservers = NULL,
@@ -166,6 +167,7 @@ static struct {
 #define CONF_ACD                        "AddressConflictDetection"
 #define CONF_USE_GATEWAYS_AS_TIMESERVERS "UseGatewaysAsTimeservers"
 #define CONF_LOCALTIME                  "Localtime"
+#define CONF_REGDOM_FOLLOWS_TIMEZONE    "RegdomFollowsTimezone"
 
 static const char *supported_options[] = {
 	CONF_BG_SCAN,
@@ -195,6 +197,7 @@ static const char *supported_options[] = {
 	CONF_ACD,
 	CONF_USE_GATEWAYS_AS_TIMESERVERS,
 	CONF_LOCALTIME,
+	CONF_REGDOM_FOLLOWS_TIMEZONE,
 	NULL
 };
 
@@ -585,6 +588,13 @@ static void parse_config(GKeyFile *config)
 		g_free(string);
 
 	g_clear_error(&error);
+
+	boolean = __connman_config_get_bool(config, "General",
+				CONF_REGDOM_FOLLOWS_TIMEZONE, &error);
+	if (!error)
+		connman_settings.regdom_follows_timezone = boolean;
+
+	g_clear_error(&error);
 }
 
 static int config_init(const char *file)
@@ -817,6 +827,9 @@ bool connman_setting_get_bool(const char *key)
 	if (g_str_equal(key, CONF_USE_GATEWAYS_AS_TIMESERVERS))
 		return connman_settings.use_gateways_as_timeservers;
 
+	if (g_str_equal(key, CONF_REGDOM_FOLLOWS_TIMEZONE))
+		return connman_settings.regdom_follows_timezone;
+
 	return false;
 }
 
-- 
2.30.2

