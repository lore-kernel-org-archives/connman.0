Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFA3EDAB1
	for <connman@lists.linux.dev>; Wed, 20 May 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290385; cv=none; b=XKv4WA+Rh43omBc0z/xjw1JW6HBM3aRgKT9ISSw8z2L1Ku+vkMQfzl7f1pQn/Nw5OGUy+ELu/YkVvY/XeImqtDh6rS+JiyEx+6Ph2SNABeLDOhkJTt65mncbBOB30zZIbvW/9zujP/57bk4iDfZz3qBdqldOwCxSwvW3aCEgckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290385; c=relaxed/simple;
	bh=mDsYXywt+O3wR6hF3kvObEHjQJBcyCl9yE34FdPoGHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQwy4qU2t0sbFSUbqGlG+k1ks7LY7FhKbtQ8Mxvp4ZBf+U+YNxEXwRVpq6q5Q+n/tqtdGTorCgn1TJo9vfAL9urVp1iaSi74e9XPdiAtcTy5Ww/YlqBPEzQz0doDA4Vb1nqDFfBkSWHnVQYB08Xtl5grWqHOH/vmRgrxeHX31PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=XVLN9cxL; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="XVLN9cxL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dwwoYczbYKxVblJ68pcjN+h8zOLXfPETi1MCNmb31HQ=; b=XVLN9cxLiCKkfEofQlOw3CTpEN
	vG/cBI6FSXqpaWnVJfW3xJdT5/1iZebgL5wxgqEeqrPDTnly5NoiJajpW0UEbDdXfgLJZdMJ2qwjO
	N3EVafNRL96H9Ia0Rj3n9CsoBScunx4FTzLSesfAtjIEVhEKzHqwL3d5lQ6ZrH+U95TMtyL80fJed
	bxiSi3JSsy+qqjCmAPwued7WGShYr31G9hEZwJMPwsGMjP33dExvGdekaouhZDHrBWq9E3Adckmwq
	xrS5ou06PVcZY97Q6sczFela2BCBKtTUnjaQ6RAyKnRlW6yz4MZajnKAFeCxBN05l2gMHY3FB5K/3
	1n/79cSg==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGk-002WBi-1n
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:30 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 8/9] unit: Add basic unit test for setting
Date: Wed, 20 May 2026 16:47:12 +0300
Message-ID: <20260520134720.981315-9-jussi.laakkonen@jolla.com>
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
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.957]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-9-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

Test the loading of configuration, conf.d support, default values,
"wifi" option and error cases.
---
 Makefile.am         |    9 +
 unit/test-setting.c | 1103 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1112 insertions(+)
 create mode 100644 unit/test-setting.c

diff --git a/Makefile.am b/Makefile.am
index dbfd1723..68ad4dbd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -476,6 +476,15 @@ tools_dnsproxy_standalone_LDFLAGS = $(src_connmand_LDFLAGS) -Wl,-zmuldefs
 noinst_PROGRAMS += tools/dnsproxy-standalone
 endif
 
+noinst_PROGRAMS += unit/test-setting
+
+unit_test_setting_CFLAGS = $(COVERAGE_OPT) $(AM_CFLAGS)
+unit_test_setting_SOURCES = unit/test-setting.c $(backtrace_sources) \
+				src/connman.h src/log.c src/setting.c src/config.c
+unit_test_setting_LDADD = @GLIB_LIBS@ -ldl
+
+TESTS += unit/test-setting
+
 endif
 
 EXTRA_DIST += $(test_scripts)
diff --git a/unit/test-setting.c b/unit/test-setting.c
new file mode 100644
index 00000000..daa38240
--- /dev/null
+++ b/unit/test-setting.c
@@ -0,0 +1,1103 @@
+/*
+ *  ConnMan setting unit tests
+ *
+ *  Copyright (C) 2025-2026 Jolla Mobile Ltd. All rights reserved.
+ *
+ *  Contact: jussi.laakkonen@jolla.com
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+
+#include "src/connman.h"
+#include <connman/setting.h>
+
+int __connman_device_request_scan(enum connman_service_type type)
+{
+	return 0;
+}
+
+int __connman_ipconfig_ipv6_set_privacy(struct connman_ipconfig *ipconfig,
+		const char *value)
+{
+	return 0;
+}
+
+
+void __connman_iptables_validate_init(void)
+{
+	return;
+}
+
+void __connman_service_auto_connect(enum connman_service_connect_reason reason)
+{
+	return;
+}
+
+int __connman_service_connect(struct connman_service *service,
+		enum connman_service_connect_reason reason)
+{
+	return 0;
+}
+
+int __connman_service_disconnect(struct connman_service *service)
+{
+	return 0;
+}
+
+struct connman_ipconfig *__connman_service_get_ip6config(
+		struct connman_service *service)
+{
+	return NULL;
+}
+
+struct connman_network *__connman_service_get_network(struct connman_service *service)
+{
+	return NULL;
+}
+
+int __connman_service_load_modifiable(struct connman_service *service)
+{
+	return 0;
+}
+
+void __connman_service_mark_dirty()
+{
+	return;
+}
+
+int __connman_service_nameserver_append(struct connman_service *service,
+		const char *nameserver, bool is_auto)
+{
+	return 0;
+}
+
+void __connman_service_nameserver_clear(struct connman_service *service)
+{
+	return;
+}
+
+int __connman_service_provision_changed(const char *ident)
+{
+	return 0;
+}
+
+bool __connman_service_remove(struct connman_service *service)
+{
+	return true;
+}
+
+int __connman_service_reset_ipconfig(struct connman_service *service,
+		enum connman_ipconfig_type type, DBusMessageIter *array,
+		enum connman_service_state *new_state)
+{
+	return 0;
+}
+
+void __connman_service_set_config(struct connman_service *service,
+		const char *file_id, const char *section)
+{
+	return;
+}
+
+void __connman_service_set_domainname(struct connman_service *service,
+		const char *domainname)
+{
+	return;
+}
+
+int __connman_service_set_favorite_delayed(struct connman_service *service,
+		bool favorite,
+		bool delay_ordering)
+{
+	return 0;
+}
+
+void __connman_service_set_hidden(struct connman_service *service)
+{
+	return;
+}
+
+int __connman_service_set_ignore(struct connman_service *service,
+		bool ignore)
+{
+	return 0;
+}
+
+int __connman_service_set_immutable(struct connman_service *service,
+		bool immutable)
+{
+	return 0;
+}
+
+int __connman_service_set_mdns(struct connman_service *service,
+		bool enabled)
+{
+	return 0;
+}
+
+void __connman_service_set_search_domains(struct connman_service *service,
+		char **domains)
+{
+	return;
+}
+
+void __connman_service_set_string(struct connman_service *service,
+		const char *key, const char *value)
+{
+	return;
+}
+
+void __connman_service_set_timeservers(struct connman_service *service,
+		char **timeservers)
+{
+	return;
+}
+
+enum connman_service_security __connman_service_string2security(const char *str)
+{
+	return 0;
+}
+
+enum connman_service_type __connman_service_string2type(const char *str)
+{
+	if (!str)
+		return CONNMAN_SERVICE_TYPE_UNKNOWN;
+
+	if (strncmp(str, "ethernet", 8) == 0)
+		return CONNMAN_SERVICE_TYPE_ETHERNET;
+	if (strncmp(str, "gadget", 6) == 0)
+		return CONNMAN_SERVICE_TYPE_GADGET;
+	if (strncmp(str, "wifi", 4) == 0)
+		return CONNMAN_SERVICE_TYPE_WIFI;
+	if (strncmp(str, "cellular", 8) == 0)
+		return CONNMAN_SERVICE_TYPE_CELLULAR;
+	if (strncmp(str, "bluetooth", 9) == 0)
+		return CONNMAN_SERVICE_TYPE_BLUETOOTH;
+	if (strncmp(str, "vpn", 3) == 0)
+		return CONNMAN_SERVICE_TYPE_VPN;
+	if (strncmp(str, "gps", 3) == 0)
+		return CONNMAN_SERVICE_TYPE_GPS;
+	if (strncmp(str, "system", 6) == 0)
+		return CONNMAN_SERVICE_TYPE_SYSTEM;
+	if (strncmp(str, "p2p", 3) == 0)
+		return CONNMAN_SERVICE_TYPE_P2P;
+
+	return CONNMAN_SERVICE_TYPE_UNKNOWN;
+}
+
+const char *__connman_service_online_check_mode2string(
+				enum service_online_check_mode mode)
+{
+	switch (mode) {
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN:
+		break;
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE:
+		return "none";
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT:
+		return "one-shot";
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS:
+		return "continuous";
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+enum service_online_check_mode __connman_service_online_check_string2mode(
+				const char *mode)
+{
+	if (!mode)
+		return CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN;
+
+	if (g_strcmp0(mode, "none") == 0)
+		return CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE;
+	else if (g_strcmp0(mode, "one-shot") == 0)
+		return CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT;
+	else if (g_strcmp0(mode, "continuous") == 0)
+		return CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS;
+
+	return CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN;
+}
+
+GKeyFile *__connman_storage_load_config(const char *ident)
+{
+	return NULL;
+}
+
+bool __connman_storage_remove_service(const char *service_id)
+{
+	return true;
+}
+
+int __connman_util_get_random(uint64_t *val)
+{
+	return 0;
+}
+
+const char *connman_device_get_string(struct connman_device *device,
+		const char *key)
+{
+	return NULL;
+}
+
+enum connman_device_type __connman_device_string2type(const char *str)
+{
+	if (!g_strcmp0(str,"ethernet"))
+		return CONNMAN_DEVICE_TYPE_ETHERNET;
+	if (!g_strcmp0(str,"wifi"))
+		return CONNMAN_DEVICE_TYPE_WIFI;
+	if (!g_strcmp0(str,"bluetooth"))
+		return CONNMAN_DEVICE_TYPE_BLUETOOTH;
+	if (!g_strcmp0(str,"gps"))
+		return CONNMAN_DEVICE_TYPE_GPS;
+	if (!g_strcmp0(str,"cellular"))
+		return CONNMAN_DEVICE_TYPE_CELLULAR;
+	if (!g_strcmp0(str,"gadget"))
+		return CONNMAN_DEVICE_TYPE_GADGET;
+
+	return CONNMAN_DEVICE_TYPE_UNKNOWN;
+}
+
+int connman_inet_check_ipaddress(const char *host)
+{
+	size_t len;
+	int last;
+
+	if (!host)
+		return -1;
+
+	len = strlen(host);
+	if (len < 7)
+		return -1;
+
+	last = atoi(host+(len-1));
+
+	if (g_str_has_prefix(host, "127.0.0.") && last > 0 && last < 9)
+		return 1;
+
+	return 0;
+}
+
+int connman_inotify_register(const char *path, inotify_event_cb callback)
+{
+	return 0;
+}
+
+void connman_inotify_unregister(const char *path, inotify_event_cb callback)
+{
+	return;
+}
+
+struct connman_ipaddress *connman_ipaddress_alloc(int family)
+{
+	return NULL;
+}
+
+void connman_ipaddress_free(struct connman_ipaddress *ipaddress)
+{
+	return;
+}
+
+int connman_ipaddress_set_ipv4(struct connman_ipaddress *ipaddress,
+		const char *address, const char *netmask,
+		const char *gateway)
+{
+	return 0;
+}
+
+int connman_ipaddress_set_ipv6(struct connman_ipaddress *ipaddress,
+		const char *address,
+		unsigned char prefix_length,
+		const char *gateway)
+{
+	return 0;
+}
+
+const void *connman_network_get_blob(struct connman_network *network,
+		const char *key, unsigned int *size)
+{
+	return NULL;
+}
+
+struct connman_device *connman_network_get_device(struct connman_network *network)
+{
+	return NULL;
+}
+
+const char *connman_network_get_identifier(
+				const struct connman_network *network)
+{
+	return NULL;
+}
+
+const char *connman_network_get_string(struct connman_network *network,
+		const char *key)
+{
+	return NULL;
+}
+
+int connman_network_set_ipaddress(struct connman_network *network,
+		struct connman_ipaddress *ipaddress)
+{
+	return 0;
+}
+
+void connman_network_set_ipv4_method(struct connman_network *network,
+		enum connman_ipconfig_method method)
+{
+	return;
+}
+
+void connman_network_set_ipv6_method(struct connman_network *network,
+		enum connman_ipconfig_method method)
+{
+	return;
+}
+
+int connman_notifier_register(const struct connman_notifier *notifier)
+{
+	return 0;
+}
+
+void connman_notifier_unregister(const struct connman_notifier *notifier)
+{
+	return;
+}
+
+const char *connman_service_get_identifier(
+					const struct connman_service *service)
+{
+	return NULL;
+}
+
+enum connman_service_type connman_service_get_type(
+					const struct connman_service *service)
+{
+	return 0;
+}
+
+struct connman_service *connman_service_lookup_from_identifier(const char* identifier)
+{
+	return NULL;
+}
+
+const char *connman_storage_dir(void)
+{
+	return NULL;
+}
+
+const char *connman_storage_user_dir(void)
+{
+	return NULL;
+}
+
+
+static char *config_empty[] = {
+	"",
+	NULL
+};
+
+static char *config_ok[] = {
+	"[General]",
+	"BackgroundScanning = true",
+	"FallbackTimeservers = 127.0.0.1,127.0.0.2",
+	"DefaultAutoConnectTechnologies = ethernet,wifi",
+	"DefaultFavoriteTechnologies = wifi",
+	"AlwaysConnectedTechnologies = ethernet,cellular",
+	"PreferredTechnologies = ethernet,wifi",
+	"FallbackNameservers = 127.0.0.3",
+	"InputRequestTimeout = 10",
+	"BrowserLaunchTimeout = 15",
+	"NetworkInterfaceBlacklist = p2p,usb",
+	"AllowHostnameUpdates = true",
+	"AllowDomainnameUpdates = true",
+	"SingleConnectedTechnology = true",
+	"TetheringTechnologies = wifi",
+	"PersistentTetheringMode = true",
+	"Enable6to4 = true",
+	"VendorClassID = id123",
+	"EnableOnlineCheck = true",
+	"EnableOnlineToReadyTransition = true",
+	"OnlineCheckMode = continuous",
+	"OnlineCheckIPv4URL = http://url.something/204",
+	"OnlineCheckIPv6URL = http://url6.something/204",
+	"OnlineCheckConnectTimeout = 100.00",
+	"OnlineCheckInitialInterval = 10",
+	"OnlineCheckMaxInterval = 50",
+	"OnlineCheckFailuresThreshold = 3",
+	"OnlineCheckSuccessesThreshold = 5",
+	"OnlineCheckIntervalStyle = fibonacci",
+	"AutoConnectRoamingServices = true",
+	"AddressConflictDetection = true",
+	"UseGatewaysAsTimeservers = true",
+	"Localtime = /var/local/lib/localtime",
+	"RegdomFollowsTimezone = true",
+	"ResolvConf = /usr/etc/resolv.conf",
+	"FallbackDeviceTypes = rndis0:gadget,usb0:ethernet",
+	NULL
+};
+
+static GKeyFile* load_config_data(char **data)
+{
+	GKeyFile *config;
+	GError *error = NULL;
+	char *conf_data;
+
+	config = g_key_file_new();
+	g_assert(config);
+
+	conf_data = g_strjoinv("\n", data);
+
+	g_key_file_set_list_separator(config, ',');
+	g_assert_true(g_key_file_load_from_data(config, conf_data, -1,
+						G_KEY_FILE_NONE, &error));
+	g_assert_null(error);
+
+	g_clear_error(&error);
+	g_free(conf_data);
+
+	return config;
+}
+
+static bool do_init = true;
+static bool do_cleanup = true;
+static bool do_load = true;
+static bool do_main = true;
+
+static void setting_test_basic0(void)
+{
+	GKeyFile *config = NULL;
+	char **str_list;
+	unsigned int *int_values;
+
+	if (do_init)
+		__connman_setting_init();
+
+	if (do_load) {
+		config = load_config_data(config_ok);
+		__connman_setting_read_config_values(config, do_main, false);
+	}
+
+	g_assert_true(connman_setting_get_bool(CONF_BG_SCAN));
+
+	str_list = connman_setting_get_string_list(CONF_PREF_TIMESERVERS);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 2);
+	g_assert_cmpstr(str_list[0], ==, "127.0.0.1");
+	g_assert_cmpstr(str_list[1], ==, "127.0.0.2");
+
+	int_values = connman_setting_get_uint_list(CONF_AUTO_CONNECT_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_ETHERNET);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_WIFI);
+	g_assert_cmpuint(int_values[2], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+	int_values = connman_setting_get_uint_list(CONF_FAVORITE_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_WIFI);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+	int_values = connman_setting_get_uint_list(CONF_PREFERRED_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_ETHERNET);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_WIFI);
+	g_assert_cmpuint(int_values[2], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+	int_values = connman_setting_get_uint_list(CONF_ALWAYS_CONNECTED_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_ETHERNET);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_CELLULAR);
+	g_assert_cmpuint(int_values[2], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+	str_list = connman_setting_get_string_list(CONF_FALLBACK_NAMESERVERS);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 1);
+	g_assert_cmpstr(str_list[0], ==, "127.0.0.3");
+
+	g_assert_cmpuint(connman_timeout_input_request(), ==, 10*1000);
+	g_assert_cmpuint(connman_timeout_browser_launch(), ==, 15*1000);
+
+	str_list = connman_setting_get_string_list(CONF_BLACKLISTED_INTERFACES);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 2);
+	g_assert_cmpstr(str_list[0], ==, "p2p");
+	g_assert_cmpstr(str_list[1], ==, "usb");
+
+	g_assert_true(connman_setting_get_bool(CONF_ALLOW_HOSTNAME_UPDATES));
+	g_assert_true(connman_setting_get_bool(CONF_ALLOW_DOMAINNAME_UPDATES));
+	g_assert_true(connman_setting_get_bool(CONF_SINGLE_TECH));
+
+	str_list = connman_setting_get_string_list(CONF_TETHERING_TECHNOLOGIES);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 1);
+	g_assert_cmpstr(str_list[0], ==, "wifi");
+
+	g_assert_true(connman_setting_get_bool(CONF_PERSISTENT_TETHERING_MODE));
+
+	g_assert_true(connman_setting_get_bool(CONF_ENABLE_6TO4));
+
+	g_assert_cmpstr(connman_setting_get_string(CONF_VENDOR_CLASS_ID), ==,
+				"id123");
+
+	g_assert_true(connman_setting_get_bool(CONF_ENABLE_ONLINE_CHECK));
+	g_assert_true(connman_setting_get_bool(
+				CONF_ENABLE_ONLINE_TO_READY_TRANSITION));
+	g_assert_cmpuint(connman_setting_get_uint(CONF_ONLINE_CHECK_MODE), ==,
+				CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS);
+	g_assert_cmpstr(connman_setting_get_string(CONF_ONLINE_CHECK_IPV4_URL),
+				==, "http://url.something/204");
+	g_assert_cmpstr(connman_setting_get_string(CONF_ONLINE_CHECK_IPV6_URL), ==,
+				"http://url6.something/204");
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_CONNECT_TIMEOUT), ==, 100 * 1000);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_INITIAL_INTERVAL), ==, 10);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_MAX_INTERVAL), ==, 50);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_FAILURES_THRESHOLD), ==, 3);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD), ==, 5);
+	g_assert_cmpstr(connman_setting_get_string(
+				CONF_ONLINE_CHECK_INTERVAL_STYLE), ==,
+				"fibonacci");
+
+	g_assert_true(connman_setting_get_bool(
+				CONF_AUTO_CONNECT_ROAMING_SERVICES));
+
+	g_assert_true(connman_setting_get_bool(CONF_ACD));
+
+	g_assert_true(connman_setting_get_bool(
+				CONF_USE_GATEWAYS_AS_TIMESERVERS));
+
+	g_assert_cmpstr(connman_setting_get_string(CONF_LOCALTIME), ==,
+				"/var/local/lib/localtime");
+
+	g_assert_true(connman_setting_get_bool(CONF_REGDOM_FOLLOWS_TIMEZONE));
+
+	g_assert_cmpstr(connman_setting_get_string(CONF_RESOLV_CONF), ==,
+				"/usr/etc/resolv.conf");
+
+	g_assert_cmpstr(__connman_setting_get_fallback_device_type("rndis0"),
+				==, "gadget");
+	g_assert_cmpstr(__connman_setting_get_fallback_device_type("usb0"),
+				==, "ethernet");
+
+
+	if (do_cleanup)
+		__connman_setting_cleanup();
+
+	if (config)
+		g_key_file_unref(config);
+}
+
+static void setting_test_basic1(void)
+{
+	char **str_list;
+	unsigned int *int_values;
+
+	do_init = do_load = do_main = true;
+	do_cleanup = false;
+
+	/*
+	 * Load first with defined names then read the same with the strings
+	 * to make sure these are not changed as in code these are mostly used
+	 */
+	setting_test_basic0();
+
+	g_assert_true(connman_setting_get_bool(CONF_BG_SCAN));
+
+	str_list = connman_setting_get_string_list(CONF_PREF_TIMESERVERS);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 2);
+	g_assert_cmpstr(str_list[0], ==, "127.0.0.1");
+	g_assert_cmpstr(str_list[1], ==, "127.0.0.2");
+
+	int_values = connman_setting_get_uint_list(CONF_AUTO_CONNECT_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_ETHERNET);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_WIFI);
+	g_assert_cmpuint(int_values[2], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+	int_values = connman_setting_get_uint_list(CONF_FAVORITE_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_WIFI);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+	int_values = connman_setting_get_uint_list(CONF_PREFERRED_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_ETHERNET);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_WIFI);
+	g_assert_cmpuint(int_values[2], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+	int_values = connman_setting_get_uint_list(CONF_ALWAYS_CONNECTED_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_ETHERNET);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_CELLULAR);
+	g_assert_cmpuint(int_values[2], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+	str_list = connman_setting_get_string_list(CONF_FALLBACK_NAMESERVERS);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 1);
+	g_assert_cmpstr(str_list[0], ==, "127.0.0.3");
+
+	g_assert_cmpuint(connman_timeout_input_request(), ==, 10*1000);
+	g_assert_cmpuint(connman_timeout_browser_launch(), ==, 15*1000);
+
+	str_list = connman_setting_get_string_list(CONF_BLACKLISTED_INTERFACES);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 2);
+	g_assert_cmpstr(str_list[0], ==, "p2p");
+	g_assert_cmpstr(str_list[1], ==, "usb");
+
+	g_assert_true(connman_setting_get_bool(CONF_ALLOW_HOSTNAME_UPDATES));
+	g_assert_true(connman_setting_get_bool(CONF_ALLOW_DOMAINNAME_UPDATES));
+	g_assert_true(connman_setting_get_bool(CONF_SINGLE_TECH));
+
+	str_list = connman_setting_get_string_list(CONF_TETHERING_TECHNOLOGIES);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 1);
+	g_assert_cmpstr(str_list[0], ==, "wifi");
+
+	g_assert_true(connman_setting_get_bool(CONF_PERSISTENT_TETHERING_MODE));
+
+	g_assert_true(connman_setting_get_bool(CONF_ENABLE_6TO4));
+
+	g_assert_cmpstr(connman_setting_get_string(CONF_VENDOR_CLASS_ID), ==,
+				"id123");
+
+	g_assert_true(connman_setting_get_bool(CONF_ENABLE_ONLINE_CHECK));
+	g_assert_true(connman_setting_get_bool(
+				CONF_ENABLE_ONLINE_TO_READY_TRANSITION));
+	g_assert_cmpuint(connman_setting_get_uint(CONF_ONLINE_CHECK_MODE), ==,
+				CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS);
+	g_assert_cmpstr(connman_setting_get_string(CONF_ONLINE_CHECK_IPV4_URL),
+				==, "http://url.something/204");
+	g_assert_cmpstr(connman_setting_get_string(CONF_ONLINE_CHECK_IPV6_URL),
+				==, "http://url6.something/204");
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_CONNECT_TIMEOUT), ==, 100 * 1000);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_INITIAL_INTERVAL), ==, 10);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_MAX_INTERVAL), ==, 50);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_FAILURES_THRESHOLD), ==, 3);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD), ==, 5);
+	g_assert_cmpstr(connman_setting_get_string(
+				CONF_ONLINE_CHECK_INTERVAL_STYLE), ==,
+				"fibonacci");
+
+	g_assert_true(connman_setting_get_bool(
+				CONF_AUTO_CONNECT_ROAMING_SERVICES));
+
+	g_assert_true(connman_setting_get_bool(CONF_ACD));
+
+	g_assert_true(connman_setting_get_bool(
+				CONF_USE_GATEWAYS_AS_TIMESERVERS));
+
+	g_assert_cmpstr(connman_setting_get_string(CONF_LOCALTIME), ==,
+				"/var/local/lib/localtime");
+
+	g_assert_true(connman_setting_get_bool(CONF_REGDOM_FOLLOWS_TIMEZONE));
+
+	g_assert_cmpstr(connman_setting_get_string(CONF_RESOLV_CONF), ==,
+				"/usr/etc/resolv.conf");
+
+	g_assert_cmpstr(__connman_setting_get_fallback_device_type("rndis0"),
+				==, "gadget");
+	g_assert_cmpstr(__connman_setting_get_fallback_device_type("usb0"),
+				==, "ethernet");
+
+	__connman_setting_cleanup();
+
+	do_cleanup = true;
+}
+
+static void setting_test_defaults0(void)
+{
+	GKeyFile *config = NULL;
+	char **str_list;
+	unsigned int *int_values;
+
+	if (do_init)
+		__connman_setting_init();
+
+	if (do_load) {
+		config = load_config_data(config_empty);
+		__connman_setting_read_config_values(config, do_main, false);
+	}
+
+	g_assert_true(connman_setting_get_bool(CONF_BG_SCAN));
+
+	str_list = connman_setting_get_string_list(CONF_PREF_TIMESERVERS);
+	g_assert_null(str_list);
+
+	int_values = connman_setting_get_uint_list(CONF_AUTO_CONNECT_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_WIFI);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_ETHERNET);
+	g_assert_cmpuint(int_values[2], ==, CONNMAN_SERVICE_TYPE_CELLULAR);
+
+	int_values = connman_setting_get_uint_list(CONF_FAVORITE_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_ETHERNET);
+
+	int_values = connman_setting_get_uint_list(CONF_PREFERRED_TECHS);
+	g_assert_null(int_values);
+
+	int_values = connman_setting_get_uint_list(CONF_ALWAYS_CONNECTED_TECHS);
+	g_assert_null(int_values);
+
+	str_list = connman_setting_get_string_list(CONF_FALLBACK_NAMESERVERS);
+	g_assert_null(str_list);
+
+	g_assert_cmpuint(connman_timeout_input_request(), ==, 120*1000);
+	g_assert_cmpuint(connman_timeout_browser_launch(), ==, 300*1000);
+
+	str_list = connman_setting_get_string_list(CONF_BLACKLISTED_INTERFACES);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 8);
+	g_assert_cmpstr(str_list[0], ==, "vmnet");
+	g_assert_cmpstr(str_list[1], ==, "vboxnet");
+	g_assert_cmpstr(str_list[2], ==, "virbr");
+	g_assert_cmpstr(str_list[3], ==, "ifb");
+	g_assert_cmpstr(str_list[4], ==, "ve-");
+	g_assert_cmpstr(str_list[5], ==, "vb-");
+	g_assert_cmpstr(str_list[6], ==, "ham");
+	g_assert_cmpstr(str_list[7], ==, "veth");
+
+	g_assert_true(connman_setting_get_bool(CONF_ALLOW_HOSTNAME_UPDATES));
+	g_assert_true(connman_setting_get_bool(CONF_ALLOW_DOMAINNAME_UPDATES));
+	g_assert_false(connman_setting_get_bool(CONF_SINGLE_TECH));
+
+	str_list = connman_setting_get_string_list(CONF_TETHERING_TECHNOLOGIES);
+	g_assert_null(str_list);
+
+	g_assert_false(connman_setting_get_bool(CONF_PERSISTENT_TETHERING_MODE));
+
+	g_assert_false(connman_setting_get_bool(CONF_ENABLE_6TO4));
+
+	g_assert_null(connman_setting_get_string(CONF_VENDOR_CLASS_ID));
+
+	g_assert_true(connman_setting_get_bool(CONF_ENABLE_ONLINE_CHECK));
+	g_assert_false(connman_setting_get_bool(
+				CONF_ENABLE_ONLINE_TO_READY_TRANSITION));
+	g_assert_cmpuint(connman_setting_get_uint(CONF_ONLINE_CHECK_MODE), ==,
+				CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT);
+	g_assert_cmpstr(connman_setting_get_string(CONF_ONLINE_CHECK_IPV4_URL),
+				==, "http://ipv4.connman.net/online/status.html");
+	g_assert_cmpstr(connman_setting_get_string(CONF_ONLINE_CHECK_IPV6_URL),
+				==, "http://ipv6.connman.net/online/status.html");
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_CONNECT_TIMEOUT), ==, 0);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_INITIAL_INTERVAL), ==, 1);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_MAX_INTERVAL), ==, 12);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_FAILURES_THRESHOLD), ==, 6);
+	g_assert_cmpuint(connman_setting_get_uint(
+				CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD), ==, 6);
+	g_assert_cmpstr(connman_setting_get_string(
+				CONF_ONLINE_CHECK_INTERVAL_STYLE), ==,
+				"geometric");
+
+	g_assert_false(connman_setting_get_bool(
+					CONF_AUTO_CONNECT_ROAMING_SERVICES));
+	g_assert_false(connman_setting_get_bool(CONF_ACD));
+	g_assert_false(connman_setting_get_bool(
+					CONF_USE_GATEWAYS_AS_TIMESERVERS));
+
+	g_assert_null(__connman_setting_get_fallback_device_type("rndis0"));
+	g_assert_null(__connman_setting_get_fallback_device_type("usb0"));
+
+	g_assert_cmpstr(connman_setting_get_string(CONF_LOCALTIME), ==,
+				"/etc/localtime");
+
+	g_assert_false(connman_setting_get_bool(CONF_REGDOM_FOLLOWS_TIMEZONE));
+
+	g_assert_null(connman_setting_get_string(CONF_RESOLV_CONF));
+
+	if (do_cleanup)
+		__connman_setting_cleanup();
+
+	if (config)
+		g_key_file_unref(config);
+}
+
+static void setting_test_load_confd0(void)
+{
+	do_init = do_cleanup = false;
+
+	__connman_setting_init();
+
+	/* Load empty config and then new config as additional one*/
+	setting_test_defaults0();
+	do_main = false;
+	setting_test_basic0();
+
+	__connman_setting_cleanup();
+
+	do_init = do_cleanup = do_main = true;
+}
+
+static char *conf0[] = {
+	"[General]",
+	NULL
+};
+
+static char *conf_bool[] = {
+	"[General]",
+	"BackgroundScanning = false",
+	NULL
+};
+
+static char *conf_uint[] = {
+	"[General]",
+	"InputRequestTimeout = 5",
+	NULL
+};
+
+static char *conf_uint_list[] = {
+	"[General]",
+	"DefaultAutoConnectTechnologies = cellular,wifi,usb",
+	NULL
+};
+
+static char *conf_str[] = {
+	"[General]",
+	"OnlineCheckIPv4URL = http://url.to/checkv4",
+	NULL
+};
+
+static char *conf_str_list[] = {
+	"[General]",
+	"NetworkInterfaceBlacklist = eth,wlan",
+	NULL
+};
+
+static void setting_test_load_confd1(void)
+{
+	GKeyFile *config;
+	char **str_list;
+	unsigned int *int_values;
+
+	do_init = do_cleanup = false;
+
+	__connman_setting_init();
+
+	/* Load empty config with defaults*/
+	setting_test_defaults0();
+
+	/* Then empty config and check default values*/
+	config = load_config_data(conf0);
+	__connman_setting_read_config_values(config, false, false);
+	g_key_file_unref(config);
+
+	do_load = do_main = false;
+	setting_test_defaults0();
+
+	/* Load configs with one change and check each */
+	config = load_config_data(conf_bool);
+	__connman_setting_read_config_values(config, false, false);
+	g_key_file_unref(config);
+
+	g_assert_false(connman_setting_get_bool(CONF_BG_SCAN));
+
+	config = load_config_data(conf_uint);
+	__connman_setting_read_config_values(config, false, false);
+	g_key_file_unref(config);
+
+	g_assert_cmpint(connman_timeout_input_request(), ==, 5*1000);
+
+	config = load_config_data(conf_uint_list);
+	__connman_setting_read_config_values(config, false, false);
+	g_key_file_unref(config);
+
+	int_values = connman_setting_get_uint_list(CONF_AUTO_CONNECT_TECHS);
+	g_assert(int_values);
+	g_assert_cmpuint(int_values[0], ==, CONNMAN_SERVICE_TYPE_CELLULAR);
+	g_assert_cmpuint(int_values[1], ==, CONNMAN_SERVICE_TYPE_WIFI);
+	/* Usb is not known */
+	g_assert_cmpuint(int_values[2], ==, CONNMAN_SERVICE_TYPE_UNKNOWN);
+
+
+	config = load_config_data(conf_str);
+	__connman_setting_read_config_values(config, false, false);
+	g_key_file_unref(config);
+
+	g_assert_cmpstr(connman_setting_get_string(CONF_ONLINE_CHECK_IPV4_URL),
+						==, "http://url.to/checkv4");
+
+	config = load_config_data(conf_str_list);
+	__connman_setting_read_config_values(config, false, false);
+	g_key_file_unref(config);
+
+	str_list = connman_setting_get_string_list(CONF_BLACKLISTED_INTERFACES);
+	g_assert(str_list);
+	g_assert_cmpuint(g_strv_length(str_list), ==, 2);
+	g_assert_cmpstr(str_list[0], ==, "eth");
+	g_assert_cmpstr(str_list[1], ==, "wlan");
+
+	/* Then load the big config and check values */
+	do_load = true;
+	do_main = false;
+	setting_test_basic0();
+
+	__connman_setting_cleanup();
+
+	do_init = do_cleanup = do_main = true;
+}
+
+static void setting_test_options0(void)
+{
+	const char *key = CONF_OPTION_WIFI;
+
+	__connman_setting_init();
+
+	g_assert_cmpstr(connman_setting_get_string(key), ==, "nl80211,wext");
+	__connman_setting_set_option(key, "wext");
+	g_assert_cmpstr(connman_setting_get_string(key), ==, "wext");
+	__connman_setting_set_option(key, "nl80211");
+	g_assert_cmpstr(connman_setting_get_string(key), ==, "nl80211");
+	g_assert_cmpstr(connman_setting_get_string("wifi"), ==, "nl80211");
+
+	__connman_setting_cleanup();
+}
+
+static void setting_test_error0(void)
+{
+	__connman_setting_init();
+
+	__connman_setting_read_config_values(NULL, true, false);
+
+	g_assert_false(__connman_setting_is_supported_option(NULL));
+	g_assert_false(__connman_setting_is_supported_option(""));
+	g_assert_false(__connman_setting_is_supported_option("NotAKey"));
+
+	g_assert_false(connman_setting_get_bool(NULL));
+	g_assert_false(connman_setting_get_bool(""));
+	g_assert_false(connman_setting_get_bool("NotAKey"));
+
+	g_assert_cmpint(connman_setting_get_uint(NULL), ==, 0);
+	g_assert_cmpint(connman_setting_get_uint(""), ==, 0);
+	g_assert_cmpint(connman_setting_get_uint("NotAKey"), ==, 0);
+
+	g_assert_null(connman_setting_get_uint_list(NULL));
+	g_assert_null(connman_setting_get_uint_list(""));
+	g_assert_null(connman_setting_get_uint_list("NotAKey"));
+
+	g_assert_null(connman_setting_get_string(NULL));
+	g_assert_null(connman_setting_get_string(""));
+	g_assert_null(connman_setting_get_string("NotAKey"));
+
+	g_assert_null(connman_setting_get_string_list(NULL));
+	g_assert_null(connman_setting_get_string_list(""));
+	g_assert_null(connman_setting_get_string_list("NotAKey"));
+
+	g_assert_null(__connman_setting_get_fallback_device_type(NULL));
+	g_assert_null(__connman_setting_get_fallback_device_type(""));
+	g_assert_null(__connman_setting_get_fallback_device_type("NotAKey"));
+
+	__connman_setting_set_option(NULL, NULL);
+	__connman_setting_set_option(NULL, "");
+	__connman_setting_set_option(NULL, "none");
+	__connman_setting_set_option("", NULL);
+	__connman_setting_set_option("", "");
+	__connman_setting_set_option("", "none");
+	__connman_setting_set_option("option", NULL);
+	__connman_setting_set_option("option", "");
+	__connman_setting_set_option("option", "none");
+
+	__connman_setting_cleanup();
+}
+
+static gchar *option_debug = NULL;
+
+static bool parse_debug(const char *key, const char *value,
+					gpointer user_data, GError **error)
+{
+	if (value)
+		option_debug = g_strdup(value);
+	else
+		option_debug = g_strdup("*");
+
+	return true;
+}
+
+static GOptionEntry options[] = {
+	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
+				G_OPTION_ARG_CALLBACK, parse_debug,
+				"Specify debug options to enable", "DEBUG" },
+	{ NULL },
+};
+
+int main (int argc, char *argv[])
+{
+	GOptionContext *context;
+	GError *error = NULL;
+	int err;
+
+	g_test_init(&argc, &argv, NULL);
+
+	context = g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (!g_option_context_parse(context, &argc, &argv, &error)) {
+		if (error) {
+			g_printerr("%s\n", error->message);
+			g_error_free(error);
+		} else
+			g_printerr("An unknown error occurred\n");
+		return 1;
+	}
+
+	g_option_context_free(context);
+
+	__connman_log_init(argv[0], option_debug, false, false,
+			"Unit Tests Connection Manager", VERSION);
+	__connman_iptables_validate_init();
+
+	g_test_add_func("/setting/test_basic0", setting_test_basic0);
+	g_test_add_func("/setting/test_basic1", setting_test_basic1);
+
+	g_test_add_func("/setting/test_defaults0", setting_test_defaults0);
+
+	g_test_add_func("/setting/test_load_config0", setting_test_load_confd0);
+	g_test_add_func("/setting/test_load_config1", setting_test_load_confd1);
+
+	g_test_add_func("/setting/test_options0", setting_test_options0);
+
+	g_test_add_func("/setting/test_error0", setting_test_error0);
+
+	err = g_test_run();
+
+	__connman_log_cleanup(false);
+	g_free(option_debug);
+
+	return err;
+}
+
+/*
+ * Local Variables:
+ * mode: C
+ * c-basic-offset: 8
+ * indent-tabs-mode: t
+ * End:
+ */
-- 
2.47.3

