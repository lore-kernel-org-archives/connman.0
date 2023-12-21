Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B671E4A1
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 80D9E73200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:32 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3D3D47321A
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:32 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 55/60] main/service: Introduce 'OnlineCheckMode' setting.
Date: Thu, 21 Dec 2023 14:35:02 -0800
Message-ID: <20231221223508.2365510-56-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221223508.2365510-1-gerickson@nuovations.com>
References: <20231221223508.2365510-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This introduces a new 'OnlineCheckMode' configuration setting.

This setting is intended to eventually deprecate 'EnableOnlineCheck'
(long-term) and 'EnableOnlineToReadyTransition' (short-term).

When asserted along with 'EnableOnlineCheck',
'EnableOnlineToReadyTransition' effects what can be thought of as a
"continuous" online check mode, which is different from the "one-shot"
online check mode when 'EnableOnlineToReadyTransition' is not asserted
but 'EnableOnlineCheck' is. Effectively, these two Booleans encode
three online check modes:

    1. None (!EnableOnlineCheck)
    2. One-shot (EnableOnlineCheck && !EnableOnlineToReadyTransition)
    3. Continuous (EnableOnlineCheck && EnableOnlineToReadyTransition)

With this change, these three modes are all formalized.

In "none" mode, as has been the case historically, there are no
"online" HTTP-based Internet reachability checks. Any connected
service and the manager state will terminate at the "ready" state and
will not progress to "online".

In "one-shot" mode, as has been the case historically, there is a
single, one-shot "online" HTTP-based Internet reachability check for
the default service. When the check succeeds, the associated service
and the manager state will terminate at the "online" state. When the
check fails, subsequent checks will be rescheduled according to
"OnlineCheckIntervalStyle", "OnlineCheckInitialInterval", and
"OnlineCheckMaxInterval" and will continue indefinitely until one
succeeds or until the service is disconnected.

In "continuous" mode, which is finalized with this change, there are
ongoing "online" HTTP-based Internet reachability check for the
default service. As with "one-shot" mode, when the first check
succeeds, the associated service and the manager state will terminate
at the "online" state. Thereafter, subsequent checks will be scheduled
according to "OnlineCheckIntervalStyle" and
"OnlineCheckMaxInterval". When the check fails, subsequent checks will
be rescheduled according to "OnlineCheckIntervalStyle",
"OnlineCheckInitialInterval", and "OnlineCheckMaxInterval". This is
largely unchanged. However, what is new with this change is that when
and if "OnlineCheckFailuresThreshold" is met, the service and manager
state will be demoted to "ready" and the service will have its "Error"
property set to "online-check-failed" while subsequent checks will
continue. In the interim, if available, another service may be
promoted to the default service and online checks will be initiated
for it. When and if, for the demoted service,
"OnlineCheckSuccessesThreshold" is met, the service "Error" property
will be cleared and the service state promoted to "online",
potentially causing it to become the default service again.
---
 src/connman.h |  9 ++++++++
 src/main.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/service.c | 16 +++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index 796cb202570e..28280a55b0ec 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -800,6 +800,15 @@ const char *__connman_service_type2string(enum connman_service_type type);
 enum connman_service_type __connman_service_string2type(const char *str);
 enum connman_service_security __connman_service_string2security(const char *str);
 
+enum service_online_check_mode {
+	CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN    = 0,
+	CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE       = 1,
+	CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT   = 2,
+	CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS = 3
+};
+
+enum service_online_check_mode __connman_service_online_check_string2mode(
+		const char *mode);
 int __connman_service_nameserver_append(struct connman_service *service,
 				const char *nameserver, bool is_auto);
 int __connman_service_nameserver_remove(struct connman_service *service,
diff --git a/src/main.c b/src/main.c
index 8e47426f2e8c..97ed3ed744b1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -112,6 +112,7 @@ static struct {
 	char *vendor_class_id;
 	bool enable_online_check;
 	bool enable_online_to_ready_transition;
+	enum service_online_check_mode online_check_mode;
 	char *online_check_ipv4_url;
 	char *online_check_ipv6_url;
 	unsigned int online_check_connect_timeout_ms;
@@ -146,6 +147,7 @@ static struct {
 	.vendor_class_id = NULL,
 	.enable_online_check = true,
 	.enable_online_to_ready_transition = false,
+	.online_check_mode = CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN,
 	.online_check_ipv4_url = NULL,
 	.online_check_ipv6_url = NULL,
 	.online_check_connect_timeout_ms = DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT,
@@ -182,6 +184,7 @@ static struct {
 #define CONF_VENDOR_CLASS_ID            "VendorClassID"
 #define CONF_ENABLE_ONLINE_CHECK        "EnableOnlineCheck"
 #define CONF_ENABLE_ONLINE_TO_READY_TRANSITION "EnableOnlineToReadyTransition"
+#define CONF_ONLINE_CHECK_MODE          "OnlineCheckMode"
 #define CONF_ONLINE_CHECK_IPV4_URL      "OnlineCheckIPv4URL"
 #define CONF_ONLINE_CHECK_IPV6_URL      "OnlineCheckIPv6URL"
 #define CONF_ONLINE_CHECK_CONNECT_TIMEOUT "OnlineCheckConnectTimeout"
@@ -217,6 +220,7 @@ static const char *supported_options[] = {
 	CONF_VENDOR_CLASS_ID,
 	CONF_ENABLE_ONLINE_CHECK,
 	CONF_ENABLE_ONLINE_TO_READY_TRANSITION,
+	CONF_ONLINE_CHECK_MODE,
 	CONF_ONLINE_CHECK_IPV4_URL,
 	CONF_ONLINE_CHECK_IPV6_URL,
 	CONF_ONLINE_CHECK_CONNECT_TIMEOUT,
@@ -345,6 +349,36 @@ static void check_config(GKeyFile *config)
 	g_strfreev(keys);
 }
 
+static void online_check_mode_set_from_deprecated(void)
+{
+	connman_settings.online_check_mode =
+		connman_settings.enable_online_check ?
+		connman_settings.enable_online_to_ready_transition ?
+			CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS :
+			CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT :
+		CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE;
+}
+
+static void online_check_mode_set_to_deprecated(void)
+{
+	switch (connman_settings.online_check_mode) {
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE:
+		connman_settings.enable_online_check = false;
+		connman_settings.enable_online_to_ready_transition = false;
+		break;
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_ONE_SHOT:
+		connman_settings.enable_online_check = true;
+		connman_settings.enable_online_to_ready_transition = false;
+		break;
+	case CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS:
+		connman_settings.enable_online_check = true;
+		connman_settings.enable_online_to_ready_transition = true;
+		break;
+	default:
+		break;
+	}
+}
+
 static void parse_config(GKeyFile *config)
 {
 	GError *error = NULL;
@@ -549,6 +583,26 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
+	/* OnlineCheckMode */
+
+	string = __connman_config_get_string(config, "General",
+				CONF_ONLINE_CHECK_MODE, &error);
+	if (!error) {
+		connman_settings.online_check_mode =
+			__connman_service_online_check_string2mode(string);
+		if (connman_settings.online_check_mode ==
+			CONNMAN_SERVICE_ONLINE_CHECK_MODE_UNKNOWN) {
+			connman_error("Invalid online check mode \"%s\"",
+				string);
+
+			online_check_mode_set_from_deprecated();
+		} else
+			online_check_mode_set_to_deprecated();
+	} else
+		online_check_mode_set_from_deprecated();
+
+	g_clear_error(&error);
+
 	/* OnlineCheckConnecTimeout */
 
 	real = g_key_file_get_double(config, "General",
@@ -966,6 +1020,9 @@ unsigned int connman_setting_get_uint(const char *key)
 	if (g_str_equal(key, CONF_ONLINE_CHECK_MAX_INTERVAL))
 		return connman_settings.online_check_max_interval;
 
+	if (g_str_equal(key, CONF_ONLINE_CHECK_MODE))
+		return connman_settings.online_check_mode;
+
 	if (g_str_equal(key, CONF_ONLINE_CHECK_FAILURES_THRESHOLD))
 		return connman_settings.online_check_failures_threshold;
 
diff --git a/src/service.c b/src/service.c
index e44eea376636..c427fc441193 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1749,6 +1749,22 @@ static bool check_proxy_setup(struct connman_service *service)
 	return false;
 }
 
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
 /**
  *  @brief
  *    Determine whether an "online" HTTP-based Internet reachability
-- 
2.42.0

