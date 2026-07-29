Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E233D8906
	for <connman@lists.linux.dev>; Wed, 29 Jul 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330523; cv=none; b=XWNU8Ee3phs21YPOCcBItsGsv+U8dD2Q6JiMw36lJYe9EDro4H8kSrjRjMP+5/cTVFNbfKQbQ/Qn7KWOlg/2XVtJNTSBjRQ32p9r0gKyg9nZI+pX77vxd+obKVv5A0bCkIiC+xw9CtQH56D1FrYoDy+NJ40udbOGM2HMRuJZLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330523; c=relaxed/simple;
	bh=r8B0ID9/OKnp9oOcnudtFN8bprtif6qA7vd4tjSlgfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGv2vzmv21vLEeANOXj8ucipR8L4T2EON1YSypboG3FQ3esS/nTsIKNIxqiDezYBhOl+L3H9cQHhpyl8eCxMomFOS+H5iS+xjMQ9GvL7kW4R0JomUJkUmbxyJ2xAwAKBVtFe0aCZjsVswYh828DXvhPjpsUR+SuAEiVSKbqYDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Mvz40e+h; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Mvz40e+h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ti5PY2ngxVXEeZaXsJBIXn7QC/jKRMz56Nch1v5MDLo=; b=Mvz40e+h5zCEkj/ckhFrbwdPXX
	6Xb0QEWxBC84PG8rLah9ocnVYaHiBO7D0WnwyKMFVfpyZBshmlMsskQ9G4KbcmOjKYPNJq+HKHkTh
	gF9HBKGOvQQse8JyVZe1OMS0+i7rn54pRy7NI+yM5LZwOgQIu4kjIMEEEzuncQ645hMYSxLJZGna1
	qRzHnjWhRTR7r8QLG3xw6z8Su0SBRzU9CysVjYDh8r0AscApn2BuOJztUpxio+KRxhuQq79x53mft
	TdiZ0xdamXnUfD2ZpbQE4Pc0jNRZBaK2ETSrvYnR7sDZHVCc1GhTjPOXKSFoPNKYRCbcBQEIdQsNE
	uasqkAMQ==;
Received: from 109-204-176-126.cust.valoonet.fi ([109.204.176.126] helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wp3gr-00BKna-14
	for connman@lists.linux.dev;
	Wed, 29 Jul 2026 15:47:21 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCHv2 6/9] setting: Move settings from main to setting with hash table support
Date: Wed, 29 Jul 2026 15:46:53 +0300
Message-ID: <20260729124706.74591-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-7-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-7-jussi.laakkonen@jolla.com>
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
 Symbol: BAYES_HAM(-3.00)
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
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:109.204.176.0/22, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260729124706.74591-1-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

Move all setting from main.c to setting.c. Add internal and external
getters for new content. Put the defines into setting.h for other
components to access. Modify main.c to support new way of using
settings, initialize settings early so the startup options can be set as
well.

The additional configs may have a small amount of keys, it is more
optimal to read only what are set. Furthermore, this avoids from
resetting values to default which have a default value, like a string
list for blacklisted interfaces, when additional config is read by going
through all the values.

Use a new configuration options struct with union field corresponding to
the option type in order to cleanup the code and make adding new config
options more straightforward. Allow to speficy callbacks for parsing the
config option, these are handled as an union so each option needs to
specify one corresponding to the value type - or set it NULL if no
parsing is required. An error handling callback can be set as well.

The different types that are supported in the current config value
(current_val) and default value (default_val) union variables with their
respective parser callbacks:

 Type           Config type           Parser callback
----------------------------------------------------------------
 bool           CONF_TYPE_BOOL        -
 double/real    CONF_TYPE_DOUBLE      -
 uint           CONF_TYPE_UINT        -
 uint* (array)  CONF_TYPE_UINTARR     parse_uint_list_cb
 char*          CONF_TYPE_STR         parse_str_cb
 char**         CONF_TYPE_STRARR      parse_list_cb
 GHashTable     CONF_TYPE_HASHTABLE   parse_hashtable_cb

The char* and double/real types support reading as the set value type and
converting it to an uint type. This is to accommodate some current
configuration needs.

The default values are either copied directly (bool, double/real, uint)
or returned from the default when value is not set. With different
return types, like when the char* is supposed to be parsed into an
integer, the char* value is not directly used, nor changed from default,
thus it not getting free'd and, therefore, is not duplicated at start.
Any array that needs to be initialized must be done in
initialize_default_values(), and free'd in __connman_setting_cleanup().

The option parsing is kept in main.c and to save only "wifi" option in
settings. The other options do not need to be in settings, only the "wifi"
needs to be accessed by other parts of the code.

Add a separate log call for settings, currently prints out the online
check status as before the changes. This is to be called after all
configs are processed.

Fixed the reading of service types and nameservers to not to clear the
list if the new list read from the config contains invalid values.

---
Changes in v2:
 - Moved all parser callbacks into an union, a new opt needs to define
   only one cb. Dropped the list item callback.
 - Fixed memory usage issues potentially causing leaked memory.
   Allocating options is now more consistent and less complex.
 - Fixed the service type and nameserver list parsing to not to clear
   the list if the new list read from config is invalid.
 - Removed the unnecessary enum for each config option.
 - Improved the commit message.

 Makefile.am       |    2 +-
 include/setting.h |   45 +-
 src/connman.h     |    7 +
 src/main.c        | 1115 +------------------------------------
 src/setting.c     | 1339 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1417 insertions(+), 1091 deletions(-)
 create mode 100644 src/setting.c

diff --git a/Makefile.am b/Makefile.am
index 568e9f92..89348872 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -129,7 +129,7 @@ src_connmand_SOURCES = $(gdhcp_sources) $(gweb_sources) $(stats_sources) \
 			src/6to4.c src/ippool.c src/bridge.c src/nat.c \
 			src/ipaddress.c src/inotify.c src/ipv6pd.c src/peer.c \
 			src/peer_service.c src/machine.c src/util.c \
-			src/acd.c
+			src/acd.c src/setting.c
 
 if INTERNAL_DNS_BACKEND
 src_connmand_SOURCES += src/dnsproxy.c
diff --git a/include/setting.h b/include/setting.h
index 920e6754..3a623575 100644
--- a/include/setting.h
+++ b/include/setting.h
@@ -28,11 +28,54 @@
 extern "C" {
 #endif
 
+#define CONF_BG_SCAN                            "BackgroundScanning"
+#define CONF_PREF_TIMESERVERS                   "FallbackTimeservers"
+#define CONF_AUTO_CONNECT_TECHS                 "DefaultAutoConnectTechnologies"
+#define CONF_ENABLED_TECHS                      "DefaultEnabledTechnologies"
+#define CONF_FAVORITE_TECHS                     "DefaultFavoriteTechnologies"
+#define CONF_ALWAYS_CONNECTED_TECHS             "AlwaysConnectedTechnologies"
+#define CONF_PREFERRED_TECHS                    "PreferredTechnologies"
+#define CONF_FALLBACK_NAMESERVERS               "FallbackNameservers"
+#define CONF_TIMEOUT_INPUTREQ                   "InputRequestTimeout"
+#define CONF_TIMEOUT_BROWSERLAUNCH              "BrowserLaunchTimeout"
+#define CONF_BLACKLISTED_INTERFACES             "NetworkInterfaceBlacklist"
+#define CONF_ALLOW_HOSTNAME_UPDATES             "AllowHostnameUpdates"
+#define CONF_ALLOW_DOMAINNAME_UPDATES           "AllowDomainnameUpdates"
+#define CONF_SINGLE_TECH                        "SingleConnectedTechnology"
+#define CONF_TETHERING_TECHNOLOGIES             "TetheringTechnologies"
+#define CONF_PERSISTENT_TETHERING_MODE          "PersistentTetheringMode"
+#define CONF_ENABLE_6TO4                        "Enable6to4"
+#define CONF_VENDOR_CLASS_ID                    "VendorClassID"
+#define CONF_ENABLE_ONLINE_CHECK                "EnableOnlineCheck"
+#define CONF_ENABLE_ONLINE_TO_READY_TRANSITION  "EnableOnlineToReadyTransition"
+#define CONF_ONLINE_CHECK_MODE                  "OnlineCheckMode"
+#define CONF_ONLINE_CHECK_IPV4_URL              "OnlineCheckIPv4URL"
+#define CONF_ONLINE_CHECK_IPV6_URL              "OnlineCheckIPv6URL"
+#define CONF_ONLINE_CHECK_CONNECT_TIMEOUT       "OnlineCheckConnectTimeout"
+#define CONF_ONLINE_CHECK_INITIAL_INTERVAL      "OnlineCheckInitialInterval"
+#define CONF_ONLINE_CHECK_MAX_INTERVAL          "OnlineCheckMaxInterval"
+#define CONF_ONLINE_CHECK_FAILURES_THRESHOLD    "OnlineCheckFailuresThreshold"
+#define CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD   "OnlineCheckSuccessesThreshold"
+#define CONF_ONLINE_CHECK_INTERVAL_STYLE        "OnlineCheckIntervalStyle"
+#define CONF_AUTO_CONNECT_ROAMING_SERVICES      "AutoConnectRoamingServices"
+#define CONF_ACD                                "AddressConflictDetection"
+#define CONF_USE_GATEWAYS_AS_TIMESERVERS        "UseGatewaysAsTimeservers"
+#define CONF_LOCALTIME                          "Localtime"
+#define CONF_REGDOM_FOLLOWS_TIMEZONE            "RegdomFollowsTimezone"
+#define CONF_RESOLV_CONF                        "ResolvConf"
+#define CONF_FALLBACK_DEVICE_TYPES              "FallbackDeviceTypes"
+
+#define CONF_OPTION_WIFI                        "wifi"
+
+#define GENERAL_GROUP "General"
+
 bool connman_setting_get_bool(const char *key);
 unsigned int connman_setting_get_uint(const char *key);
-char *connman_setting_get_string(const char *key);
+const char *connman_setting_get_string(const char *key);
 char **connman_setting_get_string_list(const char *key);
 unsigned int *connman_setting_get_uint_list(const char *key);
+unsigned int connman_setting_get_uint(const char *key);
+mode_t connman_setting_get_fs_mode(const char *key);
 
 unsigned int connman_timeout_input_request(void);
 unsigned int connman_timeout_browser_launch(void);
diff --git a/src/connman.h b/src/connman.h
index 188f74a0..25a0202f 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -149,7 +149,14 @@ void __connman_log_enable(struct connman_debug_desc *start,
 
 #include <connman/setting.h>
 
+void __connman_setting_read_config_values(GKeyFile *config, bool mainconfig,
+								bool append);
 const char *__connman_setting_get_fallback_device_type(const char *interface);
+void __connman_setting_set_option(const char *key, const char *value);
+bool __connman_setting_is_supported_option(const char *key);
+void __connman_setting_log();
+int __connman_setting_init();
+void __connman_setting_cleanup();
 
 #include <connman/plugin.h>
 
diff --git a/src/main.c b/src/main.c
index 2752a872..c1eb2a07 100644
--- a/src/main.c
+++ b/src/main.c
@@ -40,276 +40,13 @@
 
 #include "connman.h"
 #include "src/shared/util.h"
-
-#define CONF_ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]) - 1)
-
-#define DEFAULT_INPUT_REQUEST_TIMEOUT (120 * 1000)
-#define DEFAULT_BROWSER_LAUNCH_TIMEOUT (300 * 1000)
-
-#define DEFAULT_ONLINE_CHECK_IPV4_URL "http://ipv4.connman.net/online/status.html"
-#define DEFAULT_ONLINE_CHECK_IPV6_URL "http://ipv6.connman.net/online/status.html"
-
-#define DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT (0 * 1000)
-/*
- * We set the integer to 1 sec so that we have a chance to get
- * necessary IPv6 router advertisement messages that might have
- * DNS data etc.
- */
-#define DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL 1
-#define DEFAULT_ONLINE_CHECK_MAX_INTERVAL 12
-
-#define DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD 6
-#define DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD 6
-
-#define ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI "fibonacci"
-#define ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC "geometric"
-
-#define DEFAULT_ONLINE_CHECK_INTERVAL_STYLE ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC
-
-#define DEFAULT_LOCALTIME "/etc/localtime"
+#include <connman/setting.h>
 
 #define MAINFILE "main.conf"
 #define CONFIGMAINFILE CONFIGDIR "/" MAINFILE
 #define CONFIGMAINDIR CONFIGMAINFILE ".d"
 #define CONFIGSUFFIX ".conf"
 
-#define GENERAL_GROUP "General"
-
-static char *default_auto_connect[] = {
-	"wifi",
-	"ethernet",
-	"cellular",
-	NULL
-};
-
-static char *default_enabled_techs[] = {
-	"ethernet",
-	NULL
-};
-
-static char *default_favorite_techs[] = {
-	"ethernet",
-	NULL
-};
-
-static char *default_blacklist[] = {
-	"vmnet",
-	"vboxnet",
-	"virbr",
-	"ifb",
-	"ve-",
-	"vb-",
-	"ham",
-	"veth",
-	NULL
-};
-
-static struct {
-	bool bg_scan;
-	char **pref_timeservers;
-	unsigned int *auto_connect;
-	unsigned int *enabled_techs;
-	unsigned int *favorite_techs;
-	unsigned int *preferred_techs;
-	unsigned int *always_connected_techs;
-	char **fallback_nameservers;
-	unsigned int timeout_inputreq;
-	unsigned int timeout_browserlaunch;
-	char **blacklisted_interfaces;
-	bool allow_hostname_updates;
-	bool allow_domainname_updates;
-	bool single_tech;
-	char **tethering_technologies;
-	bool persistent_tethering_mode;
-	bool enable_6to4;
-	char *vendor_class_id;
-	bool enable_online_check;
-	bool enable_online_to_ready_transition;
-	enum service_online_check_mode online_check_mode;
-	char *online_check_ipv4_url;
-	char *online_check_ipv6_url;
-	unsigned int online_check_connect_timeout_ms;
-	unsigned int online_check_initial_interval;
-	unsigned int online_check_max_interval;
-	unsigned int online_check_failures_threshold;
-	unsigned int online_check_successes_threshold;
-	char *online_check_interval_style;
-	bool auto_connect_roaming_services;
-	bool acd;
-	bool use_gateways_as_timeservers;
-	char *localtime;
-	bool regdom_follows_timezone;
-	char *resolv_conf;
-	GHashTable *fallback_device_types;
-} connman_settings  = {
-	.bg_scan = true,
-	.pref_timeservers = NULL,
-	.auto_connect = NULL,
-	.enabled_techs = NULL,
-	.favorite_techs = NULL,
-	.preferred_techs = NULL,
-	.always_connected_techs = NULL,
-	.fallback_nameservers = NULL,
-	.timeout_inputreq = DEFAULT_INPUT_REQUEST_TIMEOUT,
-	.timeout_browserlaunch = DEFAULT_BROWSER_LAUNCH_TIMEOUT,
-	.blacklisted_interfaces = NULL,
-	.allow_hostname_updates = true,
-	.allow_domainname_updates = true,
-	.single_tech = false,
-	.tethering_technologies = NULL,
-	.persistent_tethering_mode = false,
-	.enable_6to4 = false,
-	.vendor_class_id = NULL,
-	.enable_online_check = true,
-	.enable_online_to_ready_transition = false,
-	.online_check_mode = CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN,
-	.online_check_ipv4_url = NULL,
-	.online_check_ipv6_url = NULL,
-	.online_check_connect_timeout_ms = DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT,
-	.online_check_initial_interval = DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL,
-	.online_check_max_interval = DEFAULT_ONLINE_CHECK_MAX_INTERVAL,
-	.online_check_failures_threshold =
-		DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD,
-	.online_check_successes_threshold =
-		DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD,
-	.online_check_interval_style = NULL,
-	.auto_connect_roaming_services = false,
-	.acd = false,
-	.use_gateways_as_timeservers = false,
-	.localtime = NULL,
-	.resolv_conf = NULL,
-	.fallback_device_types = NULL,
-};
-
-#define CONF_BG_SCAN                    "BackgroundScanning"
-#define CONF_PREF_TIMESERVERS           "FallbackTimeservers"
-#define CONF_AUTO_CONNECT_TECHS         "DefaultAutoConnectTechnologies"
-#define CONF_ENABLED_TECHS              "DefaultEnabledTechnologies"
-#define CONF_FAVORITE_TECHS             "DefaultFavoriteTechnologies"
-#define CONF_ALWAYS_CONNECTED_TECHS     "AlwaysConnectedTechnologies"
-#define CONF_PREFERRED_TECHS            "PreferredTechnologies"
-#define CONF_FALLBACK_NAMESERVERS       "FallbackNameservers"
-#define CONF_TIMEOUT_INPUTREQ           "InputRequestTimeout"
-#define CONF_TIMEOUT_BROWSERLAUNCH      "BrowserLaunchTimeout"
-#define CONF_BLACKLISTED_INTERFACES     "NetworkInterfaceBlacklist"
-#define CONF_ALLOW_HOSTNAME_UPDATES     "AllowHostnameUpdates"
-#define CONF_ALLOW_DOMAINNAME_UPDATES   "AllowDomainnameUpdates"
-#define CONF_SINGLE_TECH                "SingleConnectedTechnology"
-#define CONF_TETHERING_TECHNOLOGIES      "TetheringTechnologies"
-#define CONF_PERSISTENT_TETHERING_MODE  "PersistentTetheringMode"
-#define CONF_ENABLE_6TO4                "Enable6to4"
-#define CONF_VENDOR_CLASS_ID            "VendorClassID"
-#define CONF_ENABLE_ONLINE_CHECK        "EnableOnlineCheck"
-#define CONF_ENABLE_ONLINE_TO_READY_TRANSITION "EnableOnlineToReadyTransition"
-#define CONF_ONLINE_CHECK_MODE          "OnlineCheckMode"
-#define CONF_ONLINE_CHECK_IPV4_URL      "OnlineCheckIPv4URL"
-#define CONF_ONLINE_CHECK_IPV6_URL      "OnlineCheckIPv6URL"
-#define CONF_ONLINE_CHECK_CONNECT_TIMEOUT "OnlineCheckConnectTimeout"
-#define CONF_ONLINE_CHECK_INITIAL_INTERVAL "OnlineCheckInitialInterval"
-#define CONF_ONLINE_CHECK_MAX_INTERVAL     "OnlineCheckMaxInterval"
-#define CONF_ONLINE_CHECK_FAILURES_THRESHOLD "OnlineCheckFailuresThreshold"
-#define CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD "OnlineCheckSuccessesThreshold"
-#define CONF_ONLINE_CHECK_INTERVAL_STYLE "OnlineCheckIntervalStyle"
-#define CONF_AUTO_CONNECT_ROAMING_SERVICES "AutoConnectRoamingServices"
-#define CONF_ACD                        "AddressConflictDetection"
-#define CONF_USE_GATEWAYS_AS_TIMESERVERS "UseGatewaysAsTimeservers"
-#define CONF_LOCALTIME                  "Localtime"
-#define CONF_REGDOM_FOLLOWS_TIMEZONE    "RegdomFollowsTimezone"
-#define CONF_RESOLV_CONF                "ResolvConf"
-#define CONF_FALLBACK_DEVICE_TYPES      "FallbackDeviceTypes"
-
-static const char *supported_options[] = {
-	CONF_BG_SCAN,
-	CONF_PREF_TIMESERVERS,
-	CONF_AUTO_CONNECT_TECHS,
-	CONF_ENABLED_TECHS,
-	CONF_FAVORITE_TECHS,
-	CONF_ALWAYS_CONNECTED_TECHS,
-	CONF_PREFERRED_TECHS,
-	CONF_FALLBACK_NAMESERVERS,
-	CONF_TIMEOUT_INPUTREQ,
-	CONF_TIMEOUT_BROWSERLAUNCH,
-	CONF_BLACKLISTED_INTERFACES,
-	CONF_ALLOW_HOSTNAME_UPDATES,
-	CONF_ALLOW_DOMAINNAME_UPDATES,
-	CONF_SINGLE_TECH,
-	CONF_TETHERING_TECHNOLOGIES,
-	CONF_PERSISTENT_TETHERING_MODE,
-	CONF_ENABLE_6TO4,
-	CONF_VENDOR_CLASS_ID,
-	CONF_ENABLE_ONLINE_CHECK,
-	CONF_ENABLE_ONLINE_TO_READY_TRANSITION,
-	CONF_ONLINE_CHECK_MODE,
-	CONF_ONLINE_CHECK_IPV4_URL,
-	CONF_ONLINE_CHECK_IPV6_URL,
-	CONF_ONLINE_CHECK_CONNECT_TIMEOUT,
-	CONF_ONLINE_CHECK_INITIAL_INTERVAL,
-	CONF_ONLINE_CHECK_MAX_INTERVAL,
-	CONF_ONLINE_CHECK_FAILURES_THRESHOLD,
-	CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD,
-	CONF_ONLINE_CHECK_INTERVAL_STYLE,
-	CONF_AUTO_CONNECT_ROAMING_SERVICES,
-	CONF_ACD,
-	CONF_USE_GATEWAYS_AS_TIMESERVERS,
-	CONF_LOCALTIME,
-	CONF_REGDOM_FOLLOWS_TIMEZONE,
-	CONF_RESOLV_CONF,
-	CONF_FALLBACK_DEVICE_TYPES,
-	NULL
-};
-
-enum supported_options_val {
-	CONF_BG_SCAN_VAL = 0,
-	CONF_PREF_TIMESERVERS_VAL,
-	CONF_AUTO_CONNECT_TECHS_VAL,
-	CONF_ENABLED_TECHS_VAL,
-	CONF_FAVORITE_TECHS_VAL,
-	CONF_ALWAYS_CONNECTED_TECHS_VAL,
-	CONF_PREFERRED_TECHS_VAL,
-	CONF_FALLBACK_NAMESERVERS_VAL,
-	CONF_TIMEOUT_INPUTREQ_VAL,
-	CONF_TIMEOUT_BROWSERLAUNCH_VAL,
-	CONF_BLACKLISTED_INTERFACES_VAL,
-	CONF_ALLOW_HOSTNAME_UPDATES_VAL,
-	CONF_ALLOW_DOMAINNAME_UPDATES_VAL,
-	CONF_SINGLE_TECH_VAL,
-	CONF_TETHERING_TECHNOLOGIES_VAL,
-	CONF_PERSISTENT_TETHERING_MODE_VAL,
-	CONF_ENABLE_6TO4_VAL,
-	CONF_VENDOR_CLASS_ID_VAL,
-	CONF_ENABLE_ONLINE_CHECK_VAL,
-	CONF_ENABLE_ONLINE_TO_READY_TRANSITION_VAL,
-	CONF_ONLINE_CHECK_MODE_VAL,
-	CONF_ONLINE_CHECK_IPV4_URL_VAL,
-	CONF_ONLINE_CHECK_IPV6_URL_VAL,
-	CONF_ONLINE_CHECK_CONNECT_TIMEOUT_VAL,
-	CONF_ONLINE_CHECK_INITIAL_INTERVAL_VAL,
-	CONF_ONLINE_CHECK_MAX_INTERVAL_VAL,
-	CONF_ONLINE_CHECK_FAILURES_THRESHOLD_VAL,
-	CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD_VAL,
-	CONF_ONLINE_CHECK_INTERVAL_STYLE_VAL,
-	CONF_AUTO_CONNECT_ROAMING_SERVICES_VAL,
-	CONF_ACD_VAL,
-	CONF_USE_GATEWAYS_AS_TIMESERVERS_VAL,
-	CONF_LOCALTIME_VAL,
-	CONF_REGDOM_FOLLOWS_TIMEZONE_VAL,
-	CONF_RESOLV_CONF_VAL,
-	CONF_FALLBACK_DEVICE_TYPES_VAL,
-
-};
-
-static int conf_key_to_int(const char *key)
-{
-	int i;
-
-	for (i = 0; i < CONF_ARRAY_SIZE(supported_options); i++) {
-		if (!g_strcmp0(key, supported_options[i]))
-			return i;
-	}
-
-	return -EINVAL;
-}
-
 static GKeyFile *load_config(const char *file)
 {
 	GError *err = NULL;
@@ -326,103 +63,19 @@ static GKeyFile *load_config(const char *file)
 		}
 
 		g_error_free(err);
-		g_key_file_free(keyfile);
+		g_key_file_unref(keyfile);
 		return NULL;
 	}
 
 	return keyfile;
 }
 
-static uint *parse_service_types(char **str_list, gsize len)
-{
-	unsigned int *type_list;
-	int i, j;
-	enum connman_service_type type;
-
-	type_list = g_try_new0(unsigned int, len + 1);
-	if (!type_list)
-		return NULL;
-
-	i = 0;
-	j = 0;
-	while (str_list[i]) {
-		type = __connman_service_string2type(str_list[i]);
-
-		if (type != CONNMAN_SERVICE_TYPE_UNKNOWN) {
-			type_list[j] = type;
-			j += 1;
-		}
-		i += 1;
-	}
-
-	type_list[j] = CONNMAN_SERVICE_TYPE_UNKNOWN;
-
-	return type_list;
-}
-
-static char **parse_fallback_nameservers(char **nameservers, gsize *len)
-{
-	char **servers;
-	int i, j;
-
-	servers = g_try_new0(char *, *len + 1);
-	if (!servers)
-		return NULL;
-
-	i = 0;
-	j = 0;
-	while (nameservers[i]) {
-		if (connman_inet_check_ipaddress(nameservers[i]) > 0) {
-			servers[j] = g_strdup(nameservers[i]);
-			j += 1;
-		}
-		i += 1;
-	}
-
-	*len = j + 1;
-
-	return servers;
-}
-
-static GHashTable *parse_fallback_device_types(char **devtypes, gsize len)
-{
-	GHashTable *h;
-
-	h = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, g_free);
-
-	for (gsize i = 0; i < len; ++i) {
-		char **v;
-
-		v = g_strsplit(devtypes[i], ":", 2);
-		if (!v)
-			continue;
-
-		if (v[0] && v[1]) {
-			if (__connman_device_string2type(v[1]) ==
-						CONNMAN_DEVICE_TYPE_UNKNOWN)
-				connman_warn("Invalid FallbackDeviceType in %s",
-								devtypes[i]);
-			else
-				g_hash_table_replace(h, g_strdup(v[0]),
-								g_strdup(v[1]));
-		}
-
-		g_strfreev(v);
-	}
-
-	if (g_hash_table_size(h) > 0)
-		return h;
-
-	g_hash_table_unref(h);
-	return NULL;
-}
-
 static void check_config(GKeyFile *config, const char *file)
 {
 	char **keys;
 	int j;
 
-	if (!config || !file)
+	if (!config)
 		return;
 
 	keys = g_key_file_get_groups(config, NULL);
@@ -437,590 +90,33 @@ static void check_config(GKeyFile *config, const char *file)
 	keys = g_key_file_get_keys(config, GENERAL_GROUP, NULL, NULL);
 
 	for (j = 0; keys && keys[j]; j++) {
-		bool found;
-		int i;
-
-		found = false;
-		for (i = 0; supported_options[i]; i++) {
-			if (g_strcmp0(keys[j], supported_options[i]) == 0) {
-				found = true;
-				break;
-			}
-		}
-		if (!found && !supported_options[i])
+		if (!__connman_setting_is_supported_option(keys[j]))
 			connman_warn("Unknown option %s in %s", keys[j], file);
 	}
 
 	g_strfreev(keys);
 }
 
-static int online_check_mode_set_from_deprecated(void)
-{
-	connman_settings.online_check_mode =
-		connman_settings.enable_online_check ?
-		connman_settings.enable_online_to_ready_transition ?
-			CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS :
-			CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT :
-		CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE;
-
-	return 0;
-}
-
-static void online_check_mode_set_to_deprecated(void)
-{
-	switch (connman_settings.online_check_mode) {
-	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE:
-		connman_settings.enable_online_check = false;
-		connman_settings.enable_online_to_ready_transition = false;
-		break;
-	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT:
-		connman_settings.enable_online_check = true;
-		connman_settings.enable_online_to_ready_transition = false;
-		break;
-	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS:
-		connman_settings.enable_online_check = true;
-		connman_settings.enable_online_to_ready_transition = true;
-		break;
-	default:
-		break;
-	}
-}
-
-static void online_check_settings_log(void)
-{
-	connman_info("Online check mode \"%s\"",
-				 __connman_service_online_check_mode2string(
-					connman_settings.online_check_mode));
-
-	if (connman_settings.online_check_mode ==
-			CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE)
-		return;
-
-	connman_info("Online check IPv4 URL \"%s\"",
-		connman_settings.online_check_ipv4_url);
-
-	connman_info("Online check IPv6 URL \"%s\"",
-		connman_settings.online_check_ipv6_url);
-
-	connman_info("Online check interval style \"%s\"",
-		connman_settings.online_check_interval_style);
-
-	connman_info("Online check interval range [%u, %u]",
-		connman_settings.online_check_initial_interval,
-		connman_settings.online_check_max_interval);
-
-	if (connman_settings.online_check_connect_timeout_ms)
-		connman_info("Online check connect timeout %u ms",
-			connman_settings.online_check_connect_timeout_ms);
-
-	if (connman_settings.online_check_mode !=
-			CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS)
-		return;
-
-	connman_info("Online check continuous mode failures threshold %d",
-		connman_settings.online_check_failures_threshold);
-
-	connman_info("Online check continuous mode successes threshold %d",
-		connman_settings.online_check_successes_threshold);
-}
-
-/* String check callbacks */
-typedef gboolean (*str_check_callback) (const char *value);
-
-static gboolean check_online_mode(const char *str)
-{
-	connman_settings.online_check_mode =
-			__connman_service_online_check_string2mode(str);
-	if (connman_settings.online_check_mode ==
-				CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN) {
-		connman_error("Invalid online check mode \"%s\"", str);
-
-		online_check_mode_set_from_deprecated();
-	} else {
-		online_check_mode_set_to_deprecated();
-	}
-
-	/* Always return false to avoid the string to be set */
-	return false;
-}
-
-static gboolean check_online_check_interval_style(const char *str)
-{
-	if ((g_strcmp0(str, ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI) == 0) ||
-		(g_strcmp0(str, ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC) == 0)) {
-		return true;
-	} else {
-		connman_warn("Incorrect online check interval style [%s]", str);
-		return false;
-	}
-}
-
-/* String parse callbacks */
-typedef char** (*str_list_parse_callback) (char **str_list, gsize *len);
-
-/* Error callbacks */
-typedef gboolean (*error_callback) (void);
 
-static int online_check_connect_timeout_error(void)
-{
-	connman_warn("Incorrect online check connect timeout");
-	connman_settings.online_check_connect_timeout_ms =
-				DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT;
-
-	return 0;
-}
-
-static void set_str(char **ptr, char *value, str_check_callback cb)
-{
-	if (*ptr)
-		g_free(*ptr);
-
-	if (cb && !cb(value)) {
-		g_free(value);
-		return;
-	}
-
-	*ptr = value;
-}
-
-static void set_str_list(char ***ptr, char **value, gsize len, bool append)
-{
-	if (append) {
-		/* TODO */
-		DBG("append is ENOTSUP");
-	}
-
-	if (*ptr)
-		g_strfreev(*ptr);
-
-	*ptr = value;
-}
-
-typedef void (*str_list_callback) (const char *value);
-
-static void set_str_list_cb(char **value, str_list_callback cb, gsize len,
-								bool append)
-{
-	int i;
-
-	if (append) {
-		/* TODO */
-		DBG("append is ENOTSUP");
-	}
-
-	for (i = 0; i < len; i++)
-		cb(value[i]);
-}
-
-static void set_int_list(unsigned int **ptr, unsigned int *value, bool append)
-{
-	if (append) {
-		/* TODO */
-		DBG("append is ENOTSUP");
-	}
-
-	if (*ptr)
-		g_free(*ptr);
-
-	*ptr = value;
-}
-
-static void set_hash_table(GHashTable **ptr, char **value, gsize len,
-								bool append)
-{
-	if (append) {
-		/* TODO */
-		DBG("append is ENOTSUP");
-	}
-
-	if (*ptr)
-		g_hash_table_destroy(*ptr);
-	*ptr = parse_fallback_device_types(value, len);
-}
-
-static void set_value(GKeyFile *config, const char *key, bool append)
-{
-	GError *error = NULL;
-	const char *group = "General";
-	char *def_str = NULL;
-	char **def_str_list = NULL;
-	enum supported_options_val key_value;
-	str_check_callback check_cb = NULL;
-	str_list_callback list_cb = NULL;
-	str_list_parse_callback parse_cb = NULL;
-	error_callback error_cb = NULL;
-	gsize def_str_list_len = 0;
-	gsize len;
-	int int_multiplier = 1;
-
-	/* Ptrs for options */
-	GHashTable **hash_table_ptr = NULL;
-	char ***str_list_ptr = NULL;
-	char **str_ptr = NULL;
-	bool *bool_ptr = NULL;
-	unsigned int **int_list_ptr = NULL;
-	unsigned int *int_ptr = NULL;
-	/* Handle the value as real but save as an int */
-	unsigned int *double_ptr = NULL;
-
-	/* Dummy ptrs*/
-	char *str_dummy = NULL;
-
-	key_value = conf_key_to_int(key);
-
-	/* TODO: use a better structure, like struct with union in htable */
-	switch (key_value) {
-	/* bool */
-	/* BackgroundScanning */
-	case CONF_BG_SCAN_VAL:
-		bool_ptr = &connman_settings.bg_scan;
-		break;
-	/* AllowHostnameUpdates */
-	case CONF_ALLOW_HOSTNAME_UPDATES_VAL:
-		bool_ptr = &connman_settings.allow_hostname_updates;
-		break;
-	/* AllowDomainnameUpdates */
-	case CONF_ALLOW_DOMAINNAME_UPDATES_VAL:
-		bool_ptr = &connman_settings.allow_domainname_updates;
-		break;
-	/* SingleConnectedTechnology */
-	case CONF_SINGLE_TECH_VAL:
-		bool_ptr = &connman_settings.single_tech;
-		break;
-	/* PersistentTetheringMode */
-	case CONF_PERSISTENT_TETHERING_MODE_VAL:
-		bool_ptr = &connman_settings.persistent_tethering_mode;
-		break;
-	/* Enable6to4 */
-	case CONF_ENABLE_6TO4_VAL:
-		bool_ptr = &connman_settings.enable_6to4;
-		break;
-	/* EnableOnlineCheck */
-	case CONF_ENABLE_ONLINE_CHECK_VAL:
-		bool_ptr = &connman_settings.enable_online_check;
-		break;
-	/* EnableOnlineToReadyTransition */
-	case CONF_ENABLE_ONLINE_TO_READY_TRANSITION_VAL:
-		bool_ptr = &connman_settings.enable_online_to_ready_transition;
-		break;
-	/* AutoConnectRoamingServices */
-	case CONF_AUTO_CONNECT_ROAMING_SERVICES_VAL:
-		bool_ptr = &connman_settings.auto_connect_roaming_services;
-		break;
-	/* AddressConflictDetection */
-	case CONF_ACD_VAL:
-		bool_ptr = &connman_settings.acd;
-		break;
-	/* UseGatewaysAsTimeservers */
-	case CONF_USE_GATEWAYS_AS_TIMESERVERS_VAL:
-		bool_ptr = &connman_settings.use_gateways_as_timeservers;
-		break;
-	/* RegdomFollowsTimezone */
-	case CONF_REGDOM_FOLLOWS_TIMEZONE_VAL:
-		bool_ptr = &connman_settings.regdom_follows_timezone;
-		break;
-
-	/* str */
-	/* VendorClassID */
-	case CONF_VENDOR_CLASS_ID_VAL:
-		str_ptr = &connman_settings.vendor_class_id;
-		break;
-	/* OnlineCheckMode */
-	case CONF_ONLINE_CHECK_MODE_VAL:
-		/*
-		 * OnlineCheckMode is read as string but handled as an enum,
-		 * use str_dummy here to trigger the str handling and let the
-		 * callback to handle the real value setting. Callback always
-		 * returns 'false' to avoid setting the value to the str_dummy.
-		 */
-		str_ptr = &str_dummy;
-		check_cb = check_online_mode;
-		error_cb = online_check_mode_set_from_deprecated;
-		break;
-	/* OnlineCheckIPv4URL */
-	case CONF_ONLINE_CHECK_IPV4_URL_VAL:
-		str_ptr = &connman_settings.online_check_ipv4_url;
-		def_str = DEFAULT_ONLINE_CHECK_IPV4_URL;
-		break;
-	/* OnlineCheckIPv6URL */
-	case CONF_ONLINE_CHECK_IPV6_URL_VAL:
-		str_ptr = &connman_settings.online_check_ipv6_url;
-		def_str = DEFAULT_ONLINE_CHECK_IPV6_URL;
-		break;
-	/* Localtime */
-	case CONF_LOCALTIME_VAL:
-		str_ptr = &connman_settings.localtime;
-		break;
-	/* OnlineCheckIntervalStyle */
-	case CONF_ONLINE_CHECK_INTERVAL_STYLE_VAL:
-		str_ptr = &connman_settings.online_check_interval_style;
-		def_str = DEFAULT_ONLINE_CHECK_INTERVAL_STYLE;
-		check_cb = check_online_check_interval_style;
-		break;
-	/* ResolvConf */
-	case CONF_RESOLV_CONF_VAL:
-		str_ptr = &connman_settings.resolv_conf;
-		break;
-
-	/* str list */
-	/* */
-	case CONF_PREF_TIMESERVERS_VAL:
-		str_list_ptr = &connman_settings.pref_timeservers;
-		break;
-	/* FallbackNameservers */
-	case CONF_FALLBACK_NAMESERVERS_VAL:
-		parse_cb = parse_fallback_nameservers;
-		break;
-	/* NetworkInterfaceBlacklist */
-	case CONF_BLACKLISTED_INTERFACES_VAL:
-		str_list_ptr = &connman_settings.blacklisted_interfaces;
-		def_str_list = default_blacklist;
-		def_str_list_len = CONF_ARRAY_SIZE(default_blacklist);
-		break;
-	/* TetheringTechnologies */
-	case CONF_TETHERING_TECHNOLOGIES_VAL:
-		str_list_ptr = &connman_settings.tethering_technologies;
-		break;
-
-	/* int */
-	/* InputRequestTimeout */
-	case CONF_TIMEOUT_INPUTREQ_VAL:
-		int_ptr = &connman_settings.timeout_inputreq;
-		int_multiplier = 1000;
-		break;
-	/* BrowserLaunchTimeout */
-	case CONF_TIMEOUT_BROWSERLAUNCH_VAL:
-		int_ptr = &connman_settings.timeout_browserlaunch;
-		int_multiplier = 1000;
-		break;
-	/* OnlineCheckInitialInterval */
-	case CONF_ONLINE_CHECK_INITIAL_INTERVAL_VAL:
-		int_ptr = &connman_settings.online_check_initial_interval;
-		break;
-	/* OnlineCheckMaxInterval */
-	case CONF_ONLINE_CHECK_MAX_INTERVAL_VAL:
-		int_ptr = &connman_settings.online_check_max_interval;
-		break;
-	/* OnlineCheckFailuresThreshold */
-	case CONF_ONLINE_CHECK_FAILURES_THRESHOLD_VAL:
-		int_ptr = &connman_settings.online_check_failures_threshold;
-		break;
-	/* OnlineCheckSuccessesThreshold */
-	case CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD_VAL:
-		int_ptr = &connman_settings.online_check_successes_threshold;
-		break;
-
-	/* int array */
-	/* DefaultAutoConnectTechnologies */
-	case CONF_AUTO_CONNECT_TECHS_VAL:
-		int_list_ptr = &connman_settings.auto_connect;
-		def_str_list = default_auto_connect;
-		def_str_list_len = CONF_ARRAY_SIZE(default_auto_connect);
-		break;
-	/* DefaultEnabledTechnologies */
-	case CONF_ENABLED_TECHS_VAL:
-		int_list_ptr = &connman_settings.enabled_techs;
-		def_str_list = default_enabled_techs;
-		def_str_list_len = CONF_ARRAY_SIZE(default_enabled_techs);
-		break;
-	/* DefaultFavoriteTechnologies */
-	case CONF_FAVORITE_TECHS_VAL:
-		int_list_ptr = &connman_settings.favorite_techs;
-		def_str_list = default_favorite_techs;
-		def_str_list_len = CONF_ARRAY_SIZE(default_favorite_techs);
-		break;
-	/* AlwaysConnectedTechnologies */
-	case CONF_ALWAYS_CONNECTED_TECHS_VAL:
-		int_list_ptr = &connman_settings.always_connected_techs;
-		break;
-	/* PreferredTechnologies */
-	case CONF_PREFERRED_TECHS_VAL:
-		int_list_ptr = &connman_settings.preferred_techs;
-		break;
-
-	/* double/real, saved as unsigned int ) */
-	/* OnlineCheckConnectTimeout */
-	case CONF_ONLINE_CHECK_CONNECT_TIMEOUT_VAL:
-		double_ptr = &connman_settings.online_check_connect_timeout_ms;
-		int_multiplier = 1000;
-		error_cb = online_check_connect_timeout_error;
-		break;
-
-	/* GHashTable */
-	/* FallbackDeviceTypes */
-	case CONF_FALLBACK_DEVICE_TYPES_VAL:
-		hash_table_ptr = &connman_settings.fallback_device_types;
-		break;
-
-	default:
-		break;
-	}
-
-	if (bool_ptr) {
-		bool boolean = __connman_config_get_bool(config, group, key,
-									&error);
-		if (!error)
-			*bool_ptr = boolean;
-	}
-
-	if (str_ptr) {
-		char *str = g_key_file_get_string(config, group, key, &error);
-		if (!error)
-			set_str(str_ptr, str, check_cb);
-		else if (error_cb) // Do error handling
-			error_cb();
-
-		if (!*str_ptr && def_str)
-			set_str(str_ptr, g_strdup(def_str), check_cb);
-	}
-
-	if (str_list_ptr || list_cb) {
-		char **str_list = __connman_config_get_string_list(config,
-						group, key, &len, &error);
-		if (!error) {
-			if (list_cb) {
-				set_str_list_cb(str_list, list_cb, len, append);
-				g_strfreev(str_list);
-			} else if (parse_cb) {
-				char **new_str_list = parse_cb(str_list, &len);
-				g_strfreev(str_list);
-
-				if (new_str_list)
-					set_str_list(str_list_ptr, new_str_list,
-								len, append);
-			} else {
-				set_str_list(str_list_ptr, str_list, len,
-									append);
-			}
-		} else if (str_list_ptr && def_str_list) {
-			set_str_list(str_list_ptr, g_strdupv(def_str_list),
-						def_str_list_len, append);
-		}
-	}
-
-	if (int_ptr) {
-		int value = g_key_file_get_integer(config, group, key, &error);
-		if (!error && value >= 0)
-			*int_ptr = value * int_multiplier;
-	}
-
-	if (int_list_ptr) {
-		char **str_list = __connman_config_get_string_list(config,
-						group, key, &len, &error);
-		if (!error)
-			set_int_list(int_list_ptr,
-					parse_service_types(str_list, len),
-					append);
-		else if (def_str_list)
-			set_int_list(int_list_ptr,
-					parse_service_types(def_str_list,
-						def_str_list_len),
-					append);
-		g_strfreev(str_list);
-	}
-
-	if (double_ptr) {
-		double real = g_key_file_get_double(config, group, key, &error);
-
-		if (!error) {
-			if (real < 0 && error_cb)
-				error_cb();
-			else
-				*double_ptr = real * 1000;
-		}
-	}
-
-	if (hash_table_ptr) {
-		char **str_list = __connman_config_get_string_list(config,
-						group, key, &len, &error);
-		if (!error)
-			set_hash_table(hash_table_ptr, str_list, len, append);
-
-		g_strfreev(str_list);
-	}
-
-	g_clear_error(&error);
-}
-
-static void parse_config(GKeyFile *config, const char *file, bool append)
-{
-	int i;
-
-	if (!config || !file) {
-		connman_settings.auto_connect =
-			parse_service_types(default_auto_connect,
-				CONF_ARRAY_SIZE(default_auto_connect));
-		connman_settings.enabled_techs =
-			parse_service_types(default_enabled_techs,
-				CONF_ARRAY_SIZE(default_enabled_techs));
-		connman_settings.favorite_techs =
-			parse_service_types(default_favorite_techs,
-				CONF_ARRAY_SIZE(default_favorite_techs));
-		connman_settings.blacklisted_interfaces =
-			g_strdupv(default_blacklist);
-		connman_settings.online_check_ipv4_url =
-			g_strdup(DEFAULT_ONLINE_CHECK_IPV4_URL);
-		connman_settings.online_check_ipv6_url =
-			g_strdup(DEFAULT_ONLINE_CHECK_IPV6_URL);
-		connman_settings.online_check_interval_style =
-			g_strdup(DEFAULT_ONLINE_CHECK_INTERVAL_STYLE);
-		return;
-	}
-
-	DBG("parsing %s", file);
-
-	for (i = 0; supported_options[i]; i++) {
-		set_value(config, supported_options[i], append);
-	}
-
-	if (!connman_settings.enable_online_check)
-		connman_info("Online check disabled by main config.");
-
-	if (connman_settings.online_check_initial_interval < 1 ||
-		connman_settings.online_check_initial_interval >
-		connman_settings.online_check_max_interval) {
-		connman_warn("Incorrect online check intervals [%u, %u]",
-				connman_settings.online_check_initial_interval,
-				connman_settings.online_check_max_interval);
-		connman_settings.online_check_initial_interval =
-			DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL;
-		connman_settings.online_check_max_interval =
-			DEFAULT_ONLINE_CHECK_MAX_INTERVAL;
-	}
-
-	if (connman_settings.online_check_failures_threshold < 1) {
-		connman_warn("Incorrect online check failures threshold [%d]",
-			connman_settings.online_check_failures_threshold);
-		connman_settings.online_check_failures_threshold =
-			DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD;
-	}
-
-	if (connman_settings.online_check_successes_threshold < 1) {
-		connman_warn("Incorrect online check successes threshold [%d]",
-			connman_settings.online_check_successes_threshold);
-		connman_settings.online_check_successes_threshold =
-			DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD;
-	}
-
-	online_check_settings_log();
-}
-
-static int config_init(const char *file, bool append)
+static int config_init(const char *file, bool mainconfig, bool append)
 {
 	GKeyFile *config;
 
 	config = load_config(file);
-	check_config(config, file);
-	parse_config(config, file, append);
-	if (config)
-		g_key_file_free(config);
+	if (config) {
+		DBG("parsing %s", file);
+		check_config(config, file);
+		__connman_setting_read_config_values(config, mainconfig,
+									append);
+		g_key_file_unref(config);
+	}
 
 	return 0;
 }
 
 static int config_read(const char *file)
 {
-	return config_init(file, false);
+	return config_init(file, false, false);
 }
 
 static GMainLoop *main_loop = NULL;
@@ -1108,7 +204,6 @@ static gchar *option_device = NULL;
 static gchar *option_plugin = NULL;
 static gchar *option_nodevice = NULL;
 static gchar *option_noplugin = NULL;
-static gchar *option_wifi = NULL;
 static gboolean option_detach = TRUE;
 static gboolean option_dnsproxy = TRUE;
 static gboolean option_backtrace = TRUE;
@@ -1149,6 +244,13 @@ static bool parse_noplugin(const char *key, const char *value,
 	return true;
 }
 
+static bool parse_wifi(const char *key, const char *value,
+					gpointer user_data, GError **error)
+{
+	__connman_setting_set_option(key, value);
+	return true;
+}
+
 static GOptionEntry options[] = {
 	{ "config", 'c', 0, G_OPTION_ARG_STRING, &option_config,
 				"Load the specified configuration file "
@@ -1164,7 +266,7 @@ static GOptionEntry options[] = {
 				"Specify plugins to load", "NAME,..." },
 	{ "noplugin", 'P', 0, G_OPTION_ARG_CALLBACK, &parse_noplugin,
 				"Specify plugins not to load", "NAME,..." },
-	{ "wifi", 'W', 0, G_OPTION_ARG_STRING, &option_wifi,
+	{ "wifi", 'W', 0, G_OPTION_ARG_CALLBACK, &parse_wifi,
 				"Specify driver for WiFi/Supplicant", "NAME" },
 	{ "nodaemon", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
@@ -1180,157 +282,6 @@ static GOptionEntry options[] = {
 	{ NULL },
 };
 
-char *connman_setting_get_string(const char *key)
-{
-	if (g_str_equal(key, CONF_VENDOR_CLASS_ID))
-		return connman_settings.vendor_class_id;
-
-	if (g_str_equal(key, CONF_ONLINE_CHECK_IPV4_URL))
-		return connman_settings.online_check_ipv4_url;
-
-	if (g_str_equal(key, CONF_ONLINE_CHECK_IPV6_URL))
-		return connman_settings.online_check_ipv6_url;
-
-	if (g_strcmp0(key, "wifi") == 0) {
-		if (!option_wifi)
-			return "nl80211,wext";
-		else
-			return option_wifi;
-	}
-
-	if (g_str_equal(key, CONF_LOCALTIME))
-		return connman_settings.localtime ?
-			connman_settings.localtime : DEFAULT_LOCALTIME;
-
-	if (g_str_equal(key, CONF_RESOLV_CONF))
-		return connman_settings.resolv_conf;
-
-	if (g_str_equal(key, CONF_ONLINE_CHECK_INTERVAL_STYLE))
-		return connman_settings.online_check_interval_style;
-
-	return NULL;
-}
-
-bool connman_setting_get_bool(const char *key)
-{
-	if (g_str_equal(key, CONF_BG_SCAN))
-		return connman_settings.bg_scan;
-
-	if (g_str_equal(key, CONF_ALLOW_HOSTNAME_UPDATES))
-		return connman_settings.allow_hostname_updates;
-
-	if (g_str_equal(key, CONF_ALLOW_DOMAINNAME_UPDATES))
-		return connman_settings.allow_domainname_updates;
-
-	if (g_str_equal(key, CONF_SINGLE_TECH))
-		return connman_settings.single_tech;
-
-	if (g_str_equal(key, CONF_PERSISTENT_TETHERING_MODE))
-		return connman_settings.persistent_tethering_mode;
-
-	if (g_str_equal(key, CONF_ENABLE_6TO4))
-		return connman_settings.enable_6to4;
-
-	if (g_str_equal(key, CONF_ENABLE_ONLINE_CHECK))
-		return connman_settings.enable_online_check;
-
-	if (g_str_equal(key, CONF_ENABLE_ONLINE_TO_READY_TRANSITION))
-		return connman_settings.enable_online_to_ready_transition;
-
-	if (g_str_equal(key, CONF_AUTO_CONNECT_ROAMING_SERVICES))
-		return connman_settings.auto_connect_roaming_services;
-
-	if (g_str_equal(key, CONF_ACD))
-		return connman_settings.acd;
-
-	if (g_str_equal(key, CONF_USE_GATEWAYS_AS_TIMESERVERS))
-		return connman_settings.use_gateways_as_timeservers;
-
-	if (g_str_equal(key, CONF_REGDOM_FOLLOWS_TIMEZONE))
-		return connman_settings.regdom_follows_timezone;
-
-	return false;
-}
-
-unsigned int connman_setting_get_uint(const char *key)
-{
-	if (g_str_equal(key, CONF_ONLINE_CHECK_CONNECT_TIMEOUT))
-		return connman_settings.online_check_connect_timeout_ms;
-
-	if (g_str_equal(key, CONF_ONLINE_CHECK_INITIAL_INTERVAL))
-		return connman_settings.online_check_initial_interval;
-
-	if (g_str_equal(key, CONF_ONLINE_CHECK_MAX_INTERVAL))
-		return connman_settings.online_check_max_interval;
-
-	if (g_str_equal(key, CONF_ONLINE_CHECK_MODE))
-		return connman_settings.online_check_mode;
-
-	if (g_str_equal(key, CONF_ONLINE_CHECK_FAILURES_THRESHOLD))
-		return connman_settings.online_check_failures_threshold;
-
-	if (g_str_equal(key, CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD))
-		return connman_settings.online_check_successes_threshold;
-
-	return 0;
-}
-
-char **connman_setting_get_string_list(const char *key)
-{
-	if (g_str_equal(key, CONF_PREF_TIMESERVERS))
-		return connman_settings.pref_timeservers;
-
-	if (g_str_equal(key, CONF_FALLBACK_NAMESERVERS))
-		return connman_settings.fallback_nameservers;
-
-	if (g_str_equal(key, CONF_BLACKLISTED_INTERFACES))
-		return connman_settings.blacklisted_interfaces;
-
-	if (g_str_equal(key, CONF_TETHERING_TECHNOLOGIES))
-		return connman_settings.tethering_technologies;
-
-	return NULL;
-}
-
-unsigned int *connman_setting_get_uint_list(const char *key)
-{
-	if (g_str_equal(key, CONF_AUTO_CONNECT_TECHS))
-		return connman_settings.auto_connect;
-
-	if (g_str_equal(key, CONF_ENABLED_TECHS))
-		return connman_settings.enabled_techs;
-
-	if (g_str_equal(key, CONF_FAVORITE_TECHS))
-		return connman_settings.favorite_techs;
-
-	if (g_str_equal(key, CONF_PREFERRED_TECHS))
-		return connman_settings.preferred_techs;
-
-	if (g_str_equal(key, CONF_ALWAYS_CONNECTED_TECHS))
-		return connman_settings.always_connected_techs;
-
-	return NULL;
-}
-
-unsigned int connman_timeout_input_request(void)
-{
-	return connman_settings.timeout_inputreq;
-}
-
-unsigned int connman_timeout_browser_launch(void)
-{
-	return connman_settings.timeout_browserlaunch;
-}
-
-const char *__connman_setting_get_fallback_device_type(const char *interface)
-{
-	if (!connman_settings.fallback_device_types)
-		return NULL;
-
-	return g_hash_table_lookup(connman_settings.fallback_device_types,
-			interface);
-}
-
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -1342,6 +293,7 @@ int main(int argc, char *argv[])
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
+	__connman_setting_init();
 
 	if (!g_option_context_parse(context, &argc, &argv, &error)) {
 		if (error) {
@@ -1398,9 +350,9 @@ int main(int argc, char *argv[])
 	__connman_dbus_init(conn);
 
 	if (!option_config)
-		config_init(CONFIGMAINFILE, false);
+		config_init(CONFIGMAINFILE, true, false);
 	else
-		config_init(option_config, false);
+		config_init(option_config, true, false);
 
 	fs_err = util_read_config_files_from(CONFIGMAINDIR, CONFIGSUFFIX,
 				NULL, config_read);
@@ -1408,6 +360,7 @@ int main(int argc, char *argv[])
 		connman_error("failed to read configs from %s: %s",
 				CONFIGMAINDIR, strerror(-fs_err));
 
+	__connman_setting_log();
 	__connman_util_init();
 	__connman_inotify_init();
 	__connman_technology_init();
@@ -1506,25 +459,9 @@ int main(int argc, char *argv[])
 
 	g_main_loop_unref(main_loop);
 
-	if (connman_settings.pref_timeservers)
-		g_strfreev(connman_settings.pref_timeservers);
-
-	g_free(connman_settings.auto_connect);
-	g_free(connman_settings.favorite_techs);
-	g_free(connman_settings.preferred_techs);
-	g_strfreev(connman_settings.fallback_nameservers);
-	g_strfreev(connman_settings.blacklisted_interfaces);
-	g_strfreev(connman_settings.tethering_technologies);
-	g_free(connman_settings.vendor_class_id);
-	g_free(connman_settings.online_check_ipv4_url);
-	g_free(connman_settings.online_check_ipv6_url);
-	g_free(connman_settings.localtime);
-
-	if (connman_settings.fallback_device_types)
-		g_hash_table_unref(connman_settings.fallback_device_types);
+	__connman_setting_cleanup();
 
 	g_free(option_debug);
-	g_free(option_wifi);
 
 	return 0;
 }
diff --git a/src/setting.c b/src/setting.c
new file mode 100644
index 00000000..8b0c599d
--- /dev/null
+++ b/src/setting.c
@@ -0,0 +1,1339 @@
+/*
+ *
+ *  Connection Manager
+ *
+ *  Copyright (C) 2025-2026  Jolla Mobile Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+#include <getopt.h>
+#include <sys/stat.h>
+#include <net/if.h>
+#include <netdb.h>
+#include <arpa/inet.h>
+
+#include "connman.h"
+
+
+#define CONF_ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]) - 1)
+
+#define DEFAULT_INPUT_REQUEST_TIMEOUT (120 * 1000)
+#define DEFAULT_BROWSER_LAUNCH_TIMEOUT (300 * 1000)
+
+#define DEFAULT_ONLINE_CHECK_IPV4_URL "http://ipv4.connman.net/online/status.html"
+#define DEFAULT_ONLINE_CHECK_IPV6_URL "http://ipv6.connman.net/online/status.html"
+
+#define DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT (0 * 1000)
+/*
+ * We set the integer to 1 sec so that we have a chance to get
+ * necessary IPv6 router advertisement messages that might have
+ * DNS data etc.
+ */
+#define DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL 1
+#define DEFAULT_ONLINE_CHECK_MAX_INTERVAL 12
+
+#define DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD 6
+#define DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD 6
+
+#define ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI "fibonacci"
+#define ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC "geometric"
+
+#define DEFAULT_ONLINE_CHECK_INTERVAL_STYLE ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC
+
+#define DEFAULT_LOCALTIME "/etc/localtime"
+
+#define DEFAULT_WIFI_OPTION "nl80211,wext"
+
+static char *default_auto_connect[] = {
+	"wifi",
+	"ethernet",
+	"cellular",
+	NULL
+};
+
+static char *default_enabled_techs[] = {
+	"ethernet",
+	NULL
+};
+
+static char *default_favorite_techs[] = {
+	"ethernet",
+	NULL
+};
+
+static char *default_blacklist[] = {
+	"vmnet",
+	"vboxnet",
+	"virbr",
+	"ifb",
+	"ve-",
+	"vb-",
+	"ham",
+	"veth",
+	NULL
+};
+
+enum option_type {
+	CONF_TYPE_UINT = 0,
+	CONF_TYPE_UINTARR,
+	CONF_TYPE_STR,
+	CONF_TYPE_STRARR,
+	CONF_TYPE_BOOL,
+	CONF_TYPE_DOUBLE,
+	CONF_TYPE_HASHTABLE
+};
+
+/* Union for storing the values */
+union config_value {
+	bool bool_val;
+	unsigned int uint_val;
+	double double_val;
+	char *str_val;
+	char **str_array_val;
+	unsigned int *int_array_val;
+	GHashTable *hash_table_val;
+};
+
+/* Callback for checking if value is acceptable */
+typedef gboolean (*parse_str_callback)(const char *value);
+
+/* Callback for parsing items in a string list */
+typedef char** (*parse_list_callback)(char **str_list, gsize *len);
+
+/* Callback for parsing uint list from the NULL terminated string list */
+typedef uint* (*parse_uint_list_callback)(char **list, gsize len);
+
+/* Callback for parsing string list into hashtable. */
+typedef GHashTable* (*parse_hashtable_callback)(char **list, gsize len);
+
+/* Error callback */
+typedef int (*error_callback)(void);
+
+union parse_callback {
+	parse_str_callback parse_str_cb;
+	parse_list_callback parse_list_cb;
+	parse_uint_list_callback parse_uint_list_cb;
+	parse_hashtable_callback parse_hashtable_cb;
+};
+
+/*
+ * Configuration options struct.
+ *
+ * Any new configuration option has to have at least key, value and type (and
+ * return type) set. The fields are detailed as follows:
+ *
+ * opt_key		Option name, used for searching in getters
+ * opt_value		enum value for the option
+ * opt_return_type	The type of this option returns, supported: str -> uint
+ * default_val		Default value as union option, must match opt_type
+ * parser		Union for parser callbacks, contains:
+ * 	parse_str_cb		Check string value: CONF_TYPE_STR
+ * 	parse_list_cb		Parse a string list: CONF_TYPE_STRARR
+ * 	parse_uint_list_cb	Parse int list: CONF_TYPE_UINTARR
+ * 	parse_hashtable_cb	Parse a hash table: CONF_TYPE_HASHTABLE
+ * error_cb		Error callback when check_str_cb fails
+ * multiplier		For CONF_TYPE_UINT and CONF_TYPE_DOUBLE correlation
+ *
+ * If parse_str_cb is missing the string is saved as is. If parse_list_strs_cb
+ * is missing the string list is saved as is. If any of the other parser
+ * callbacks is missing the value will not be saved.
+ *
+ * The alternative return type, opt_return_type, can be used to define a
+ * conversion type value for a string. Currently accepted conversions are STR ->
+ * UINT and DOUBLE -> UINT only.
+ *
+ * The error_cb is useful in cases where the value needs a complicated setup.
+ *
+ * The integer multiplier is applied only for INT and DOUBLE values when set.
+ * Keep this 1 for INT/DOUBLE and 0 for everything else.
+ *
+ * The default_val can be used to define the config option default value. All
+ * regular values (BOOL, INT, DOUBLE) will get the value copied to current_val.
+ * STR will get copied only when it is converted to INT at return. Any INTARR,
+ * STRARR or HASHTABLE opt_type needs to be initialized in
+ * initialize_default_values(), and free'd in __connman_settings_cleanup().
+ */
+struct config_option {
+	const char *opt_key;			/* Config option name */
+	enum option_type opt_type;		/* Define valid union field */
+	/* Special handling, read as opt_type, return with this union type */
+	enum option_type opt_return_type;
+
+	/* Unions for default value and current storage */
+	union config_value default_val;
+	union config_value current_val;
+
+	/* Callbacks, parsers are set in union for a type, or NULL if omitted */
+	union parse_callback parser;
+	error_callback error_cb;
+	unsigned int multiplier;		/* For integers/doubles*/
+};
+
+/* Global config options hash table */
+static GHashTable *config_options_table = NULL;
+
+/* Parsers for config options. */
+static uint *parse_service_types(char **str_list, gsize len)
+{
+	unsigned int *type_list;
+	int i, j;
+	enum connman_service_type type;
+
+	type_list = g_try_new0(unsigned int, len + 1);
+	if (!type_list)
+		return NULL;
+
+	i = 0;
+	j = 0;
+	while (str_list[i]) {
+		type = __connman_service_string2type(str_list[i]);
+
+		if (type != CONNMAN_SERVICE_TYPE_UNKNOWN) {
+			type_list[j] = type;
+			j += 1;
+		}
+		i += 1;
+	}
+
+	if (!j) {
+		g_free(type_list);
+		return NULL;
+	}
+
+	type_list[j] = CONNMAN_SERVICE_TYPE_UNKNOWN;
+
+	return type_list;
+}
+
+static char **parse_fallback_nameservers(char **nameservers, gsize *len)
+{
+	char **servers;
+	int i, j;
+
+	servers = g_try_new0(char *, *len + 1);
+	if (!servers)
+		return NULL;
+
+	i = 0;
+	j = 0;
+	while (nameservers[i]) {
+		if (connman_inet_check_ipaddress(nameservers[i]) > 0) {
+			servers[j] = g_strdup(nameservers[i]);
+			j += 1;
+		}
+		i += 1;
+	}
+
+	if (!j) {
+		g_strfreev(servers);
+		*len = 0;
+		return NULL;
+	}
+
+	*len = j + 1;
+
+	return servers;
+}
+
+static GHashTable *parse_fallback_device_types(char **devtypes, gsize len)
+{
+	GHashTable *h;
+	gsize i;
+
+	h = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, g_free);
+
+	for (i = 0; i < len; ++i) {
+		char **v;
+
+		v = g_strsplit(devtypes[i], ":", 2);
+		if (!v)
+			continue;
+
+		if (v[0] && v[1]) {
+			if (__connman_device_string2type(v[1]) ==
+						CONNMAN_DEVICE_TYPE_UNKNOWN)
+				connman_warn("Invalid FallbackDeviceType in %s",
+								devtypes[i]);
+			else
+				g_hash_table_replace(h, g_strdup(v[0]),
+								g_strdup(v[1]));
+		}
+
+		g_strfreev(v);
+	}
+
+	if (g_hash_table_size(h) > 0)
+		return h;
+
+	g_hash_table_unref(h);
+	return NULL;
+}
+
+/* Find option by key */
+static struct config_option *config_option_lookup(const char *key)
+{
+	if (!key || !config_options_table)
+		return NULL;
+
+	return g_hash_table_lookup(config_options_table, key);
+}
+
+/* Type-safe getters using the union */
+bool connman_setting_get_bool(const char *key)
+{
+	struct config_option *opt;
+
+	opt = config_option_lookup(key);
+	if (!opt || opt->opt_type != CONF_TYPE_BOOL)
+		return false;
+
+	return opt->current_val.bool_val;
+}
+
+unsigned int connman_setting_get_uint(const char *key)
+{
+	struct config_option *opt;
+
+	opt = config_option_lookup(key);
+	if (!opt)
+		return 0;
+
+	if (opt->opt_type != CONF_TYPE_UINT &&
+					opt->opt_return_type != CONF_TYPE_UINT)
+		return 0;
+
+	return opt->current_val.uint_val;
+}
+
+const char *connman_setting_get_string(const char *key)
+{
+	struct config_option *opt;
+
+	opt = config_option_lookup(key);
+	if (!opt)
+		return NULL;
+
+	if (opt->opt_type != CONF_TYPE_STR &&
+					opt->opt_return_type != CONF_TYPE_STR)
+		return NULL;
+
+	if (opt->current_val.str_val)
+		return opt->current_val.str_val;
+
+	return opt->default_val.str_val;
+}
+
+char **connman_setting_get_string_list(const char *key)
+{
+	struct config_option *opt;
+
+	opt = config_option_lookup(key);
+	if (!opt || opt->opt_type != CONF_TYPE_STRARR)
+		return NULL;
+
+	if (opt->current_val.str_array_val)
+		return opt->current_val.str_array_val;
+
+	return opt->default_val.str_array_val;
+}
+
+unsigned int *connman_setting_get_uint_list(const char *key)
+{
+	struct config_option *opt;
+
+	opt = config_option_lookup(key);
+	if (!opt || opt->opt_type != CONF_TYPE_UINTARR)
+		return NULL;
+
+	if (opt->current_val.int_array_val)
+		return opt->current_val.int_array_val;
+
+	return opt->default_val.int_array_val;
+}
+
+/* Wrappers for input request/browser launch timeout getters */
+unsigned int connman_timeout_input_request(void)
+{
+	return connman_setting_get_uint(CONF_TIMEOUT_INPUTREQ);
+}
+
+unsigned int connman_timeout_browser_launch(void)
+{
+	return connman_setting_get_uint(CONF_TIMEOUT_BROWSERLAUNCH);
+}
+
+/* Type-safe value setters */
+static void set_bool_value(struct config_option *opt, bool value)
+{
+	if (opt->opt_type != CONF_TYPE_BOOL)
+		return;
+
+	opt->current_val.bool_val = value;
+}
+
+static void set_uint_value(struct config_option *opt, unsigned int value)
+{
+	if (opt->opt_type != CONF_TYPE_UINT &&
+					opt->opt_return_type != CONF_TYPE_UINT)
+		return;
+
+	opt->current_val.uint_val = value;
+}
+
+static void set_str_value(struct config_option *opt, const char *value)
+{
+	if (opt->opt_type != CONF_TYPE_STR)
+		return;
+
+	if (opt->parser.parse_str_cb && !opt->parser.parse_str_cb(value))
+		return;
+
+	if (!g_strcmp0(opt->current_val.str_val, value))
+		return;
+
+	g_free(opt->current_val.str_val);
+	opt->current_val.str_val = g_strdup(value);
+}
+
+static void set_str_array_value(struct config_option *opt, char **value)
+{
+	if (opt->opt_type != CONF_TYPE_STRARR)
+		return;
+
+	g_strfreev(opt->current_val.str_array_val);
+	opt->current_val.str_array_val = g_strdupv(value);
+}
+
+static void set_int_array_value(struct config_option *opt, unsigned int *value)
+{
+	if (opt->opt_type != CONF_TYPE_UINTARR)
+		return;
+
+	g_free(opt->current_val.int_array_val);
+	opt->current_val.int_array_val = value;
+}
+
+static void set_hash_table_value(struct config_option *opt, GHashTable *value)
+{
+	if (opt->opt_type != CONF_TYPE_HASHTABLE)
+		return;
+
+	if (opt->current_val.hash_table_val)
+		g_hash_table_destroy(opt->current_val.hash_table_val);
+
+	opt->current_val.hash_table_val = value;
+}
+
+/* Internal helper-wrappers */
+static int setting_set_bool(const char *key, bool value)
+{
+	struct config_option *opt;
+
+	opt = config_option_lookup(key);
+	if (!opt)
+		return -EINVAL;
+
+	set_bool_value(opt, value);
+
+	return 0;
+}
+
+static int setting_set_uint(const char *key, unsigned int value)
+{
+	struct config_option *opt;
+
+	opt = config_option_lookup(key);
+	if (!opt)
+		return -EINVAL;
+
+	set_uint_value(opt, value);
+
+	return 0;
+}
+
+/* Public setters for internal use */
+void __connman_setting_set_option(const char *key, const char *value)
+{
+	struct config_option *opt;
+
+	if (!key)
+		return;
+
+	opt = config_option_lookup(key);
+	if (!opt)
+		return;
+
+	set_str_value(opt, value);
+}
+
+/* Online mode checking functions */
+static int online_check_connect_timeout_error(void)
+{
+	connman_warn("Incorrect online check connect timeout");
+
+	return setting_set_uint(CONF_ONLINE_CHECK_CONNECT_TIMEOUT,
+					DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT);
+}
+
+static int online_check_mode_set_from_deprecated(void)
+{
+	bool enable_online_check;
+	bool enable_online_to_ready_transition;
+
+	enable_online_check = connman_setting_get_bool(
+					CONF_ENABLE_ONLINE_CHECK);
+	enable_online_to_ready_transition = connman_setting_get_bool(
+					CONF_ENABLE_ONLINE_TO_READY_TRANSITION);
+
+	return setting_set_uint(CONF_ONLINE_CHECK_MODE,
+		enable_online_check ?
+			enable_online_to_ready_transition ?
+				CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS :
+				CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT :
+		CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE);
+}
+
+static void online_check_mode_set_to_deprecated(void)
+{
+	bool enable_online_check;
+	bool enable_online_to_ready_transition;
+
+	switch (connman_setting_get_uint(CONF_ONLINE_CHECK_MODE)) {
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE:
+		enable_online_check = false;
+		enable_online_to_ready_transition = false;
+		break;
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT:
+		enable_online_check = true;
+		enable_online_to_ready_transition = false;
+		break;
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS:
+		enable_online_check = true;
+		enable_online_to_ready_transition = true;
+		break;
+	default:
+		return;
+	}
+
+	setting_set_bool(CONF_ENABLE_ONLINE_CHECK,
+					enable_online_check);
+	setting_set_bool(CONF_ENABLE_ONLINE_TO_READY_TRANSITION,
+					enable_online_to_ready_transition);
+}
+
+static gboolean check_online_mode(const char *str)
+{
+	enum service_online_check_mode online_check_mode =
+			__connman_service_online_check_string2mode(str);
+
+	setting_set_uint(CONF_ONLINE_CHECK_MODE, online_check_mode);
+
+	if (online_check_mode == CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN) {
+		connman_error("Invalid online check mode \"%s\"", str);
+
+		online_check_mode_set_from_deprecated();
+	} else {
+		online_check_mode_set_to_deprecated();
+	}
+
+	return false;
+}
+
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
+
+static void online_check_settings_log(void)
+{
+	if (!connman_setting_get_string(CONF_ONLINE_CHECK_MODE))
+		connman_info("Online check disabled by config");
+	else
+		connman_info("Online check mode \"%s\"",
+				__connman_service_online_check_mode2string(
+					connman_setting_get_uint(
+						CONF_ONLINE_CHECK_MODE)));
+
+	if (connman_setting_get_uint(CONF_ONLINE_CHECK_MODE) ==
+			CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE)
+		return;
+
+	connman_info("Online check IPv4 URL \"%s\"",
+		connman_setting_get_string(CONF_ONLINE_CHECK_IPV4_URL));
+
+	connman_info("Online check IPv6 URL \"%s\"",
+		connman_setting_get_string(CONF_ONLINE_CHECK_IPV6_URL));
+
+	connman_info("Online check interval style \"%s\"",
+		connman_setting_get_string(CONF_ONLINE_CHECK_INTERVAL_STYLE));
+
+	connman_info("Online check interval range [%u, %u]",
+		connman_setting_get_uint(CONF_ONLINE_CHECK_INITIAL_INTERVAL),
+		connman_setting_get_uint(CONF_ONLINE_CHECK_MAX_INTERVAL));
+
+	if (connman_setting_get_uint(CONF_ONLINE_CHECK_CONNECT_TIMEOUT))
+		connman_info("Online check connect timeout %u ms",
+			connman_setting_get_uint(
+				CONF_ONLINE_CHECK_CONNECT_TIMEOUT));
+
+	if (connman_setting_get_uint(CONF_ONLINE_CHECK_MODE) !=
+			CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS)
+		return;
+
+	connman_info("Online check continuous mode failures threshold %d",
+			connman_setting_get_uint(
+				CONF_ONLINE_CHECK_FAILURES_THRESHOLD));
+
+	connman_info("Online check continuous mode successes threshold %d",
+			connman_setting_get_uint(
+				CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD));
+}
+
+static struct config_option config_options[] = {
+	/* BackgroundScanning */
+	{
+		.opt_key = CONF_BG_SCAN,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = true,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* FallbackTimeservers */
+	{
+		.opt_key = CONF_PREF_TIMESERVERS,
+		.opt_type = CONF_TYPE_STRARR,
+		.opt_return_type = CONF_TYPE_STRARR,
+		.default_val.str_array_val = NULL,
+		.parser.parse_list_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* DefaultAutoConnectTechnologies */
+	{
+		.opt_key = CONF_AUTO_CONNECT_TECHS,
+		.opt_type = CONF_TYPE_UINTARR,
+		.opt_return_type = CONF_TYPE_UINTARR,
+		.default_val.int_array_val = NULL,
+		.parser.parse_uint_list_cb = parse_service_types,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* DefaultEnabledTechnologies */
+	{
+		.opt_key = CONF_ENABLED_TECHS,
+		.opt_type = CONF_TYPE_UINTARR,
+		.opt_return_type = CONF_TYPE_UINTARR,
+		.default_val.int_array_val = NULL,
+		.parser.parse_uint_list_cb = parse_service_types,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* DefaultFavoriteTechnologies */
+	{
+		.opt_key = CONF_FAVORITE_TECHS,
+		.opt_type = CONF_TYPE_UINTARR,
+		.opt_return_type = CONF_TYPE_UINTARR,
+		.default_val.int_array_val = NULL,
+		.parser.parse_uint_list_cb = parse_service_types,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* AlwaysConnectedTechnologies */
+	{
+		.opt_key = CONF_ALWAYS_CONNECTED_TECHS,
+		.opt_type = CONF_TYPE_UINTARR,
+		.opt_return_type = CONF_TYPE_UINTARR,
+		.default_val.int_array_val = NULL,
+		.parser.parse_uint_list_cb = parse_service_types,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* PreferredTechnologies */
+	{
+		.opt_key = CONF_PREFERRED_TECHS,
+		.opt_type = CONF_TYPE_UINTARR,
+		.opt_return_type = CONF_TYPE_UINTARR,
+		.default_val.int_array_val = NULL,
+		.parser.parse_uint_list_cb = parse_service_types,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* FallbackNameservers */
+	{
+		.opt_key = CONF_FALLBACK_NAMESERVERS,
+		.opt_type = CONF_TYPE_STRARR,
+		.opt_return_type = CONF_TYPE_STRARR,
+		.default_val.str_array_val = NULL,
+		.parser.parse_list_cb = parse_fallback_nameservers,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* InputRequestTimeout */
+	{
+		.opt_key = CONF_TIMEOUT_INPUTREQ,
+		.opt_type = CONF_TYPE_UINT,
+		.opt_return_type = CONF_TYPE_UINT,
+		.default_val.uint_val = DEFAULT_INPUT_REQUEST_TIMEOUT,
+		.error_cb = NULL,
+		.multiplier = 1000
+	},
+	/* BrowserLaunchTimeout */
+	{
+		.opt_key = CONF_TIMEOUT_BROWSERLAUNCH,
+		.opt_type = CONF_TYPE_UINT,
+		.opt_return_type = CONF_TYPE_UINT,
+		.default_val.uint_val = DEFAULT_BROWSER_LAUNCH_TIMEOUT,
+		.error_cb = NULL,
+		.multiplier = 1000
+	},
+	/* NetworkInterfaceBlacklist */
+	{
+		.opt_key = CONF_BLACKLISTED_INTERFACES,
+		.opt_type = CONF_TYPE_STRARR,
+		.opt_return_type = CONF_TYPE_STRARR,
+		.default_val.str_array_val = NULL,
+		.parser.parse_list_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* AllowHostnameUpdates */
+	{
+		.opt_key = CONF_ALLOW_HOSTNAME_UPDATES,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = true,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* AllowDomainnameUpdates */
+	{
+		.opt_key = CONF_ALLOW_DOMAINNAME_UPDATES,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = true,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* SingleConnectedTechnology */
+	{
+		.opt_key = CONF_SINGLE_TECH,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = false,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* TetheringTechnologies */
+	{
+		.opt_key = CONF_TETHERING_TECHNOLOGIES,
+		.opt_type = CONF_TYPE_STRARR,
+		.opt_return_type = CONF_TYPE_STRARR,
+		.default_val.str_array_val = NULL,
+		.parser.parse_list_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* PersistentTetheringMode */
+	{
+		.opt_key = CONF_PERSISTENT_TETHERING_MODE,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = false,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* Enable6to4 */
+	{
+		.opt_key = CONF_ENABLE_6TO4,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = false,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* VendorClassID */
+	{
+		.opt_key = CONF_VENDOR_CLASS_ID,
+		.opt_type = CONF_TYPE_STR,
+		.opt_return_type = CONF_TYPE_STR,
+		.default_val.str_val = NULL,
+		.parser.parse_str_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* EnableOnlineCheck */
+	{
+		.opt_key = CONF_ENABLE_ONLINE_CHECK,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = true,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* EnableOnlineToReadyTransition */
+	{
+		.opt_key = CONF_ENABLE_ONLINE_TO_READY_TRANSITION,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = false,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* OnlineCheckMode */
+	{
+		.opt_key = CONF_ONLINE_CHECK_MODE,
+		.opt_type = CONF_TYPE_STR,
+		.opt_return_type = CONF_TYPE_UINT,
+		.default_val.uint_val =
+				CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT,
+		.parser.parse_str_cb = check_online_mode,
+		.error_cb = online_check_mode_set_from_deprecated,
+		.multiplier = 0
+	},
+	/* OnlineCheckIPv4URL */
+	{
+		.opt_key = CONF_ONLINE_CHECK_IPV4_URL,
+		.opt_type = CONF_TYPE_STR,
+		.opt_return_type = CONF_TYPE_STR,
+		.default_val.str_val = DEFAULT_ONLINE_CHECK_IPV4_URL,
+		.parser.parse_str_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* OnlineCheckIPv6URL */
+	{
+		.opt_key = CONF_ONLINE_CHECK_IPV6_URL,
+		.opt_type = CONF_TYPE_STR,
+		.opt_return_type = CONF_TYPE_STR,
+		.default_val.str_val = DEFAULT_ONLINE_CHECK_IPV6_URL,
+		.parser.parse_str_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* OnlineCheckConnectTimeout */
+	{
+		.opt_key = CONF_ONLINE_CHECK_CONNECT_TIMEOUT,
+		.opt_type = CONF_TYPE_DOUBLE,
+		.opt_return_type = CONF_TYPE_UINT,
+		.default_val.double_val = DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT,
+		.error_cb = online_check_connect_timeout_error,
+		.multiplier = 1000
+	},
+	/* OnlineCheckInitialInterval */
+	{
+		.opt_key = CONF_ONLINE_CHECK_INITIAL_INTERVAL,
+		.opt_type = CONF_TYPE_UINT,
+		.opt_return_type = CONF_TYPE_UINT,
+		.default_val.uint_val = DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL,
+		.error_cb = NULL,
+		.multiplier = 1
+	},
+	/* OnlineCheckMaxInterval */
+	{
+		.opt_key = CONF_ONLINE_CHECK_MAX_INTERVAL,
+		.opt_type = CONF_TYPE_UINT,
+		.opt_return_type = CONF_TYPE_UINT,
+		.default_val.uint_val = DEFAULT_ONLINE_CHECK_MAX_INTERVAL,
+		.error_cb = NULL,
+		.multiplier = 1
+	},
+	/* OnlineCheckFailuresThreshold */
+	{
+		.opt_key = CONF_ONLINE_CHECK_FAILURES_THRESHOLD,
+		.opt_type = CONF_TYPE_UINT,
+		.opt_return_type = CONF_TYPE_UINT,
+		.default_val.uint_val = DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD,
+		.error_cb = NULL,
+		.multiplier = 1
+	},
+	/* OnlineCheckSuccessesThreshold */
+	{
+		.opt_key = CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD,
+		.opt_type = CONF_TYPE_UINT,
+		.opt_return_type = CONF_TYPE_UINT,
+		.default_val.uint_val = DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD,
+		.error_cb = NULL,
+		.multiplier = 1
+	},
+	/* OnlineCheckIntervalStyle */
+	{
+		.opt_key = CONF_ONLINE_CHECK_INTERVAL_STYLE,
+		.opt_type = CONF_TYPE_STR,
+		.opt_return_type = CONF_TYPE_STR,
+		.default_val.str_val = DEFAULT_ONLINE_CHECK_INTERVAL_STYLE,
+		.parser.parse_str_cb = check_online_check_interval_style,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* AutoConnectRoamingServices */
+	{
+		.opt_key = CONF_AUTO_CONNECT_ROAMING_SERVICES,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = false,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* AddressConflictDetection */
+	{
+		.opt_key = CONF_ACD,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = false,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* UseGatewaysAsTimeservers */
+	{
+		.opt_key = CONF_USE_GATEWAYS_AS_TIMESERVERS,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = false,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* Localtime */
+	{
+		.opt_key = CONF_LOCALTIME,
+		.opt_type = CONF_TYPE_STR,
+		.opt_return_type = CONF_TYPE_STR,
+		.default_val.str_val = DEFAULT_LOCALTIME,
+		.parser.parse_str_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* RegdomFollowsTimezone */
+	{
+		.opt_key = CONF_REGDOM_FOLLOWS_TIMEZONE,
+		.opt_type = CONF_TYPE_BOOL,
+		.opt_return_type = CONF_TYPE_BOOL,
+		.default_val.bool_val = false,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* ResolvConf */
+	{
+		.opt_key = CONF_RESOLV_CONF,
+		.opt_type = CONF_TYPE_STR,
+		.opt_return_type = CONF_TYPE_STR,
+		.default_val.str_val = NULL,
+		.parser.parse_str_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* FallbackDeviceTypes */
+	{
+		.opt_key = CONF_FALLBACK_DEVICE_TYPES,
+		.opt_type = CONF_TYPE_HASHTABLE,
+		.opt_return_type = CONF_TYPE_HASHTABLE,
+		.default_val.hash_table_val = NULL,
+		.parser.parse_hashtable_cb = parse_fallback_device_types,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+	/* Option "wifi" */
+	{
+		.opt_key = CONF_OPTION_WIFI,
+		.opt_type = CONF_TYPE_STR,
+		.opt_return_type = CONF_TYPE_STR,
+		.default_val.str_val = DEFAULT_WIFI_OPTION,
+		.parser.parse_str_cb = NULL,
+		.error_cb = NULL,
+		.multiplier = 0
+	},
+
+	{ 0 }
+};
+
+/* Generic read function that dispatches based on type */
+static void read_config_value(GKeyFile *config, struct config_option *option,
+								bool append)
+{
+	GError *error = NULL;
+	const char *group = GENERAL_GROUP;
+	char *str = NULL;
+	char **list;
+	gsize len;
+
+	if (!option)
+		return;
+
+	if (!g_key_file_has_key(config, group, option->opt_key, NULL))
+		return;
+
+	switch (option->opt_type) {
+	case CONF_TYPE_BOOL:
+		bool value = __connman_config_get_bool(config, group,
+						option->opt_key, &error);
+		if (error) {
+			if (option->error_cb)
+				option->error_cb();
+			break;
+		}
+
+		set_bool_value(option, value);
+
+		break;
+	case CONF_TYPE_UINT:
+		gint integer = g_key_file_get_integer(config, group,
+						option->opt_key, &error);
+		/* Ignore negative integer values. 0 is a valid value. */
+		if (error || integer < 0) {
+			if (option->error_cb)
+				option->error_cb();
+			break;
+		}
+
+		set_uint_value(option, integer * option->multiplier);
+
+		break;
+	case CONF_TYPE_DOUBLE:
+		double real = g_key_file_get_double(config, group,
+						option->opt_key, &error);
+		if (error || real < 0) {
+			if (option->error_cb)
+				option->error_cb();
+			break;
+		}
+
+		set_uint_value(option, real * option->multiplier);
+
+		break;
+	case CONF_TYPE_STR:
+		str = __connman_config_get_string(config, group,
+						option->opt_key, &error);
+		if (error) {
+			if (option->error_cb)
+				option->error_cb();
+			g_free(str);
+			break;
+		}
+
+		if (str) {
+			set_str_value(option, str);
+			g_free(str);
+		}
+
+		break;
+	case CONF_TYPE_STRARR:
+		list = __connman_config_get_string_list(config, group,
+						option->opt_key, &len, &error);
+		if (error) {
+			if (option->error_cb)
+				option->error_cb();
+		} else if (option->parser.parse_list_cb) {
+			char **new_list = option->parser.parse_list_cb(
+							list, &len);
+			if (new_list)
+				set_str_array_value(option, new_list);
+
+			g_strfreev(new_list);
+		} else {
+			set_str_array_value(option, list);
+		}
+
+		break;
+	case CONF_TYPE_UINTARR:
+		list = __connman_config_get_string_list(config, group,
+						option->opt_key, &len, &error);
+		if (error) {
+			if (option->error_cb)
+				option->error_cb();
+		} else if (option->parser.parse_uint_list_cb) {
+			unsigned int *uint_list =
+					option->parser.parse_uint_list_cb(
+								list, len);
+			if (uint_list)
+				set_int_array_value(option, uint_list);
+		}
+
+		g_strfreev(list);
+		break;
+	case CONF_TYPE_HASHTABLE:
+		list = __connman_config_get_string_list(config, group,
+						option->opt_key, &len, &error);
+		if (error) {
+			if (option->error_cb)
+				option->error_cb();
+		} else if (option->parser.parse_hashtable_cb) {
+			GHashTable *hash = option->parser.parse_hashtable_cb(
+								list, len);
+			if (hash)
+				set_hash_table_value(option, hash);
+		}
+
+		break;
+	}
+
+	g_clear_error(&error);
+}
+
+static void read_non_main_config(GKeyFile *config, bool append)
+{
+	GError *error = NULL;
+	struct config_option *opt;
+	char **keys;
+	gsize len;
+	int i;
+
+	DBG("");
+
+	if (!config)
+		return;
+
+	keys = g_key_file_get_keys(config, GENERAL_GROUP, &len, &error);
+	if (!error) {
+		for (i = 0; i < len; i++) {
+			opt = config_option_lookup(keys[i]);
+			if (!opt) {
+				DBG("invalid key %s", keys[i]);
+				continue;
+			}
+
+			read_config_value(config, opt, append);
+		}
+	}
+
+	g_clear_error(&error);
+	g_strfreev(keys);
+}
+
+static void initialize_default_values()
+{
+	struct config_option *opt;
+	int i;
+
+	DBG("");
+
+	for (i = 0; config_options[i].opt_key; i++) {
+		opt = &config_options[i];
+
+		if (g_str_equal(opt->opt_key, CONF_AUTO_CONNECT_TECHS)) {
+			if (!opt->parser.parse_uint_list_cb)
+				continue;
+
+			opt->default_val.int_array_val =
+				opt->parser.parse_uint_list_cb(default_auto_connect,
+					CONF_ARRAY_SIZE(default_auto_connect));
+		} else if (g_str_equal(opt->opt_key, CONF_ENABLED_TECHS)) {
+			if (!opt->parser.parse_uint_list_cb)
+				continue;
+
+			opt->default_val.int_array_val =
+				opt->parser.parse_uint_list_cb(
+					default_enabled_techs,
+					CONF_ARRAY_SIZE(default_enabled_techs));
+		} else if (g_str_equal(opt->opt_key, CONF_FAVORITE_TECHS)) {
+			if (!opt->parser.parse_uint_list_cb)
+				continue;
+
+			opt->default_val.int_array_val =
+				opt->parser.parse_uint_list_cb(default_favorite_techs,
+					CONF_ARRAY_SIZE(default_favorite_techs));
+		} else if (g_str_equal(opt->opt_key,
+						CONF_BLACKLISTED_INTERFACES)) {
+			opt->default_val.str_array_val = g_strdupv(
+							default_blacklist);
+		} else {
+			switch (opt->opt_type) {
+			case CONF_TYPE_STR:
+				/*
+				* Copy the string default only when the
+				* conversion to an another type requires it.
+				*/
+				if (opt->opt_return_type == CONF_TYPE_STR)
+					break;
+			/* Copy simple types */
+			case CONF_TYPE_BOOL:
+			case CONF_TYPE_UINT:
+			case CONF_TYPE_DOUBLE:
+				opt->current_val = opt->default_val;
+				break;
+			case CONF_TYPE_UINTARR:
+			case CONF_TYPE_STRARR:
+			case CONF_TYPE_HASHTABLE:
+				break;
+			}
+		}
+	}
+}
+
+void __connman_setting_read_config_values(GKeyFile *config, bool mainconfig,
+								bool append)
+{
+	unsigned int initial_interval;
+	unsigned int max_interval;
+	unsigned int failures_threshold;
+	unsigned int successes_threshold;
+	int i;
+
+	if (!mainconfig) {
+		read_non_main_config(config, append);
+		return;
+	}
+
+	initialize_default_values();
+
+	if (config) {
+		for (i = 0; config_options[i].opt_key; i++)
+			read_config_value(config, &config_options[i], append);
+	}
+
+	initial_interval = connman_setting_get_uint(
+					CONF_ONLINE_CHECK_INITIAL_INTERVAL);
+	max_interval = connman_setting_get_uint(CONF_ONLINE_CHECK_MAX_INTERVAL);
+	if (initial_interval < 1 || initial_interval > max_interval) {
+		connman_warn("Incorrect online check intervals [%u, %u]",
+						initial_interval, max_interval);
+		setting_set_uint(CONF_ONLINE_CHECK_INITIAL_INTERVAL,
+				DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL);
+		setting_set_uint(CONF_ONLINE_CHECK_MAX_INTERVAL,
+				DEFAULT_ONLINE_CHECK_MAX_INTERVAL);
+	}
+
+	failures_threshold = connman_setting_get_uint(
+					CONF_ONLINE_CHECK_FAILURES_THRESHOLD);
+	if (failures_threshold < 1) {
+		connman_warn("Incorrect online check failures threshold [%d]",
+						failures_threshold);
+		setting_set_uint(CONF_ONLINE_CHECK_FAILURES_THRESHOLD,
+				DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD);
+	}
+
+	successes_threshold = connman_setting_get_uint(
+					CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD);
+	if (successes_threshold < 1) {
+		connman_warn("Incorrect online check successes threshold [%d]",
+						successes_threshold);
+		setting_set_uint(CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD,
+				DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD);
+	}
+}
+
+const char *__connman_setting_get_fallback_device_type(const char *interface)
+{
+	struct config_option *opt;
+
+	opt = config_option_lookup(CONF_FALLBACK_DEVICE_TYPES);
+	if (!opt || !opt->current_val.hash_table_val)
+		return NULL;
+
+	return g_hash_table_lookup(opt->current_val.hash_table_val, interface);
+}
+
+bool __connman_setting_is_supported_option(const char *key)
+{
+	return config_option_lookup(key) != NULL;
+}
+
+void __connman_setting_log()
+{
+	online_check_settings_log();
+}
+
+int __connman_setting_init()
+{
+	struct config_option *opt;
+	int i;
+
+	DBG("");
+
+	if (config_options_table)
+		g_hash_table_unref(config_options_table);
+
+	config_options_table = g_hash_table_new(g_str_hash, g_str_equal);
+	if (!config_options_table)
+		return -ENOMEM;
+
+	for (i = 0; config_options[i].opt_key; i++) {
+		opt = &config_options[i];
+
+		g_hash_table_insert(config_options_table, (gpointer)opt->opt_key,
+					opt);
+	}
+
+	return 0;
+}
+
+void __connman_setting_cleanup()
+{
+	int i;
+	struct config_option *opt;
+
+	DBG("");
+
+	for (i = 0; config_options[i].opt_key; i++) {
+		opt = &config_options[i];
+
+		switch (opt->opt_type) {
+		case CONF_TYPE_BOOL:
+		case CONF_TYPE_UINT:
+			break;
+		case CONF_TYPE_STR:
+			/* Stores into something else, skip */
+			if (opt->opt_return_type != CONF_TYPE_STR)
+				break;
+
+			g_free(opt->current_val.str_val);
+			opt->current_val.str_val = NULL;
+			break;
+		case CONF_TYPE_STRARR:
+			g_strfreev(opt->current_val.str_array_val);
+			opt->current_val.str_array_val = NULL;
+			g_strfreev(opt->default_val.str_array_val);
+			opt->default_val.str_array_val = NULL;
+			break;
+		case CONF_TYPE_UINTARR:
+			g_free(opt->current_val.int_array_val);
+			opt->current_val.int_array_val = NULL;
+			g_free(opt->default_val.int_array_val);
+			opt->default_val.int_array_val = NULL;
+			break;
+		case CONF_TYPE_HASHTABLE:
+			if (opt->current_val.hash_table_val)
+				g_hash_table_unref(
+					opt->current_val.hash_table_val);
+
+			opt->current_val.hash_table_val = NULL;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (config_options_table) {
+		g_hash_table_destroy(config_options_table);
+		config_options_table = NULL;
+	}
+}
-- 
2.47.3

