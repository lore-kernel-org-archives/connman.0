Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065131C291
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 35CBB730F3
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:59:55 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id F32DE7310B
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:59:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 5/8] main: Introduce the 'OnlineCheckConnectTimeout' setting.
Date: Sat, 11 Nov 2023 10:59:54 -0800
References: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Message-Id: <23685D88-4C18-4B9D-A011-44B0AEBEF953@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This introduces the 'OnlineCheckConnectTimeout' setting which is the
time, in decimal seconds (for example, 12.3), to wait for a successful
TCP connection to the host associated with "OnlineCheckIPv4URL" or
"OnlineCheckIPv6URL". Connections that take longer than this will be
aborted. The default value is zero ('0') which indicates that no =
explicit
connection timeout will be used, leaving the timeout to the underlying
operating system and network stack.
---
 src/main.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/main.c b/src/main.c
index d6863e668b38..e9419a603eba 100644
--- a/src/main.c
+++ b/src/main.c
@@ -47,6 +47,7 @@
 #define DEFAULT_ONLINE_CHECK_IPV4_URL =
"http://ipv4.connman.net/online/status.html"
 #define DEFAULT_ONLINE_CHECK_IPV6_URL =
"http://ipv6.connman.net/online/status.html"
=20
+#define DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT (0 * 1000)
 /*
  * We set the integer to 1 sec so that we have a chance to get
  * necessary IPv6 router advertisement messages that might have
@@ -110,6 +111,7 @@ static struct {
 	bool enable_online_to_ready_transition;
 	char *online_check_ipv4_url;
 	char *online_check_ipv6_url;
+	unsigned int online_check_connect_timeout_ms;
 	unsigned int online_check_initial_interval;
 	unsigned int online_check_max_interval;
 	char *online_check_interval_style;
@@ -141,6 +143,7 @@ static struct {
 	.enable_online_to_ready_transition =3D false,
 	.online_check_ipv4_url =3D NULL,
 	.online_check_ipv6_url =3D NULL,
+	.online_check_connect_timeout_ms =3D =
DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT,
 	.online_check_initial_interval =3D =
DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL,
 	.online_check_max_interval =3D =
DEFAULT_ONLINE_CHECK_MAX_INTERVAL,
 	.online_check_interval_style =3D NULL,
@@ -172,6 +175,7 @@ static struct {
 #define CONF_ENABLE_ONLINE_TO_READY_TRANSITION =
"EnableOnlineToReadyTransition"
 #define CONF_ONLINE_CHECK_IPV4_URL      "OnlineCheckIPv4URL"
 #define CONF_ONLINE_CHECK_IPV6_URL      "OnlineCheckIPv6URL"
+#define CONF_ONLINE_CHECK_CONNECT_TIMEOUT "OnlineCheckConnectTimeout"
 #define CONF_ONLINE_CHECK_INITIAL_INTERVAL "OnlineCheckInitialInterval"
 #define CONF_ONLINE_CHECK_MAX_INTERVAL     "OnlineCheckMaxInterval"
 #define CONF_ONLINE_CHECK_INTERVAL_STYLE "OnlineCheckIntervalStyle"
@@ -204,6 +208,7 @@ static const char *supported_options[] =3D {
 	CONF_ENABLE_ONLINE_TO_READY_TRANSITION,
 	CONF_ONLINE_CHECK_IPV4_URL,
 	CONF_ONLINE_CHECK_IPV6_URL,
+	CONF_ONLINE_CHECK_CONNECT_TIMEOUT,
 	CONF_ONLINE_CHECK_INITIAL_INTERVAL,
 	CONF_ONLINE_CHECK_MAX_INTERVAL,
 	CONF_ONLINE_CHECK_INTERVAL_STYLE,
@@ -338,6 +343,7 @@ static void parse_config(GKeyFile *config)
 	char *string;
 	gsize len;
 	int integer;
+	double real;
=20
 	if (!config) {
 		connman_settings.auto_connect =3D
@@ -530,6 +536,27 @@ static void parse_config(GKeyFile *config)
=20
 	g_clear_error(&error);
=20
+	/* OnlineCheckConnecTimeout */
+
+	real =3D g_key_file_get_double(config, "General",
+			CONF_ONLINE_CHECK_CONNECT_TIMEOUT, &error);
+	if (!error) {
+		if (real < 0) {
+			connman_warn("Incorrect online check connect =
timeout %f",
+				real);
+			connman_settings.online_check_connect_timeout_ms =
=3D
+				DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT;
+		} else
+			connman_settings.online_check_connect_timeout_ms =
=3D
+				real * 1000;
+	}
+
+	if (connman_settings.online_check_connect_timeout_ms)
+		connman_info("Online check connect timeout %ums",
+			=
connman_settings.online_check_connect_timeout_ms);
+
+	g_clear_error(&error);
+
 	string =3D __connman_config_get_string(config, "General",
 					CONF_ONLINE_CHECK_IPV4_URL, =
&error);
 	if (!error)
@@ -885,6 +912,9 @@ bool connman_setting_get_bool(const char *key)
=20
 unsigned int connman_setting_get_uint(const char *key)
 {
+	if (g_str_equal(key, CONF_ONLINE_CHECK_CONNECT_TIMEOUT))
+		return connman_settings.online_check_connect_timeout_ms;
+
 	if (g_str_equal(key, CONF_ONLINE_CHECK_INITIAL_INTERVAL))
 		return connman_settings.online_check_initial_interval;
=20
--=20
2.42.0

