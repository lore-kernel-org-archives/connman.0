Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF097A
	for <connman@lists.linux.dev>; Tue,  5 Apr 2022 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 0e1dbc2c-b4ed-11ec-877a-005056bdfda7;
	Tue, 05 Apr 2022 17:31:17 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/4] main: Add path to localtime to config options.
Date: Tue,  5 Apr 2022 17:31:13 +0300
Message-Id: <20220405143116.2272080-2-jussi.laakkonen@jolla.com>
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

The path to localtime is kept as default /etc/localtime but in some
cases external daemon manages the localtime by changing its own symlink
to which /etc/localtime points to. Thus, ConnMan would not see any
change in the localtime changes.
---
 doc/connman.conf.5.in |  3 +++
 src/main.c            | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 82cceb72..a64b8c6d 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -205,6 +205,9 @@ address will be chosen instead (according to RFC3927). If an address conflict
 occurs for an address offered via DHCP, ConnMan send a DHCP DECLINE once and
 for the second conflict resort to finding an IPv4LL address.
 Default value is false.
+.TP
+.BI Localtime= string
+Path to localtime file. Defaults to /etc/localtime.
 .SH "EXAMPLE"
 The following example configuration disables hostname updates and enables
 ethernet tethering.
diff --git a/src/main.c b/src/main.c
index bf6ccad5..13b7e4bc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -54,6 +54,7 @@
  */
 #define DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL 1
 #define DEFAULT_ONLINE_CHECK_MAX_INTERVAL 12
+#define DEFAULT_LOCALTIME "/etc/localtime"
 
 #define MAINFILE "main.conf"
 #define CONFIGMAINFILE CONFIGDIR "/" MAINFILE
@@ -107,6 +108,7 @@ static struct {
 	bool auto_connect_roaming_services;
 	bool acd;
 	bool use_gateways_as_timeservers;
+	char *localtime;
 } connman_settings  = {
 	.bg_scan = true,
 	.pref_timeservers = NULL,
@@ -134,6 +136,7 @@ static struct {
 	.auto_connect_roaming_services = false,
 	.acd = false,
 	.use_gateways_as_timeservers = false,
+	.localtime = NULL,
 };
 
 #define CONF_BG_SCAN                    "BackgroundScanning"
@@ -162,6 +165,7 @@ static struct {
 #define CONF_AUTO_CONNECT_ROAMING_SERVICES "AutoConnectRoamingServices"
 #define CONF_ACD                        "AddressConflictDetection"
 #define CONF_USE_GATEWAYS_AS_TIMESERVERS "UseGatewaysAsTimeservers"
+#define CONF_LOCALTIME                  "Localtime"
 
 static const char *supported_options[] = {
 	CONF_BG_SCAN,
@@ -190,6 +194,7 @@ static const char *supported_options[] = {
 	CONF_AUTO_CONNECT_ROAMING_SERVICES,
 	CONF_ACD,
 	CONF_USE_GATEWAYS_AS_TIMESERVERS,
+	CONF_LOCALTIME,
 	NULL
 };
 
@@ -569,6 +574,15 @@ static void parse_config(GKeyFile *config)
 				CONF_USE_GATEWAYS_AS_TIMESERVERS, &error);
 	if (!error)
 		connman_settings.use_gateways_as_timeservers = boolean;
+
+	g_clear_error(&error);
+
+	string = __connman_config_get_string(config, "General",
+				CONF_LOCALTIME, &error);
+	if (!error)
+		connman_settings.localtime = string;
+	else
+		g_free(string);
 
 	g_clear_error(&error);
 }
@@ -761,6 +775,10 @@ char *connman_setting_get_string(const char *key)
 			return option_wifi;
 	}
 
+	if (g_str_equal(key, CONF_LOCALTIME))
+		return connman_settings.localtime ?
+			connman_settings.localtime : DEFAULT_LOCALTIME;
+
 	return NULL;
 }
 
@@ -1037,6 +1055,7 @@ int main(int argc, char *argv[])
 	g_free(connman_settings.vendor_class_id);
 	g_free(connman_settings.online_check_ipv4_url);
 	g_free(connman_settings.online_check_ipv6_url);
+	g_free(connman_settings.localtime);
 
 	g_free(option_debug);
 	g_free(option_wifi);
-- 
2.30.2

