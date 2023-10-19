Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E027321AA
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ECB4573165
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 19:59:25 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8C1357321E
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 19:59:25 -0400 (EDT)
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
Subject: [PATCH v2] Introduce the 'OnlineCheckIntervalStyle' setting.
Date: Thu, 19 Oct 2023 16:59:24 -0700
References: <B2ACEFEE-39AE-4828-BD03-170E9993749A@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <B2ACEFEE-39AE-4828-BD03-170E9993749A@nuovations.com>
Message-Id: <CE90C22D-1AE5-4CE7-A1F0-4E854997064A@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This introduces the 'OnlineCheckIntervalStyle' setting which is the
style or mathematical series function used to compute the actual
time, in seconds, between two "ready" to "online" HTTP-based Internet
reachability checks. The value of which may be either "geometric" or
"fibonacci" with a default value of "geometric".

The "geometric" style (which is a formalization of the existing,
default series calculation) or function simply takes the square of the
online check interval. For example, at a check interval of 6, the
time, in seconds, is 36 (6^2) seconds.

The "fibonacci" style or function takes the value of the Fibonacci
sequence at the online check interval. For example, at a check interval
of 6, the time, in seconds, is 8 seconds.

The "fibonacci" series and style is more aggressive in check rate up to =
12
steps (its equivalence point with "geometric" at 144 seconds) than
"geometric" but backs off far more aggresively past that point reaching
an hour at interval 19 which "geometric" does not reach until interval
60.

As the "EnableOnlineToReadyTransition" is refined and further developed,
the "fibonacci" style will allow for faster service failover and =
recovery
times for transient failures while backing off more aggressively for =
longer
duration outages where metered services like Cellular may be more =
sensitive
to a less aggresive backoff like "geometric".
---
 README                |  18 +++++--
 doc/connman.conf.5.in |  21 ++++++++
 src/main.c            |  35 +++++++++++++
 src/main.conf         |  21 ++++++++
 src/service.c         | 116 ++++++++++++++++++++++++++++++++++++++----
 5 files changed, 198 insertions(+), 13 deletions(-)

diff --git a/README b/README
index e3268c82..62427e78 100644
--- a/README
+++ b/README
@@ -409,9 +409,21 @@ from ipv4.connman.net (for IPv4 connectivity) and =
ipv6.connman.net
 http://ipv{4|6}.connman.net/online/status.html
=20
 When an online check request fails, another one is triggered after a
-longer interval. The intervals follow the square series of numbers
-in a specific range, by default [1, 12], corresponding to the following
-intervals, in seconds: 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121 and =
144.
+longer interval. The intervals follows one of two mathemetical
+sequences, depending on the "OnlineCheckIntervalStyle" setting:
+"fibonacci" or "geometric", with a default of "geometric". The
+geometric setting is the square series of numbers in the range
+specified by "OnlineCheckInitialInterval" and "OnlineCheckMaxInterval".
+The default values for "OnlineCheckInitialInterval" and
+"OnlineCheckMaxInterval" are the range [1, 12], which correspond to the
+following "geometric" intervals, in seconds: 1, 4, 9, 16, 25, 36, 49, =
64,
+81, 100, 121 and 144 over that range. By contrast, the correspending
+"fibonacci" sequence over that range is 1, 1, 2, 3, 5, 8, 13, 21, 34, =
55,
+89, and 144. The "fibonacci" series and style is more aggressive in =
check
+rate up to 12 steps (its equivalence point with "geometric" at 144 =
seconds)
+than "geometric" but backs off far more aggresively past that point
+reaching an hour at interval 19 which "geometric" does not reach until
+interval 60.
=20
 See connman.conf(5) for the EnableOnlineCheck option, if you need to
 disable the feature.
diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 1f9b2908..44b09daa 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -179,6 +179,27 @@ Range of intervals between two online check =
requests.
 Please refer to the README for more detailed information.
 Default values are 1 and 12 respectively.
 .TP
+.BI OnlineCheckIntervalStyle=3Dfibonacci\ \fR|\fB\ geometric
+The style or mathematical series function used to compute the actual
+time, in seconds, between two "ready" to "online" HTTP-based Internet
+reachability checks. The value of which may be either "geometric" or
+"fibonacci" with a default value of "geometric".
+
+The "geometric" style or function simply takes the square of the
+online check interval (see OnlineCheckInitialInterval and
+OnlineCheckMaxInterval). For example, at a check interval of 6, the
+time, in seconds, is 36 (6^2) seconds.
+
+The "fibonacci" style or function takes the value of the Fibonacci
+sequence at the online check interval. For example, at a check interval
+of 6, the time, in seconds, is 8 seconds.
+
+The "fibonacci" series and style is more aggressive in check rate up to =
12
+steps (its equivalence point with "geometric" at 144 seconds) than
+"geometric" but backs off far more aggresively past that point reaching
+an hour at interval 19 which "geometric" does not reach until interval
+60.
+.TP
 .BI EnableOnlineToReadyTransition=3Dtrue\ \fR|\fB\ false
 WARNING: Experimental feature!!!
 In addition to EnableOnlineCheck setting, enable or disable use of HTTP =
GET
diff --git a/src/main.c b/src/main.c
index ae4a450d..0c1be14e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -54,6 +54,12 @@
  */
 #define DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL 1
 #define DEFAULT_ONLINE_CHECK_MAX_INTERVAL 12
+
+#define ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI "fibonacci"
+#define ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC "geometric"
+
+#define DEFAULT_ONLINE_CHECK_INTERVAL_STYLE =
ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC
+
 #define DEFAULT_LOCALTIME "/etc/localtime"
=20
 #define MAINFILE "main.conf"
@@ -106,6 +112,7 @@ static struct {
 	char *online_check_ipv6_url;
 	unsigned int online_check_initial_interval;
 	unsigned int online_check_max_interval;
+	char *online_check_interval_style;
 	bool auto_connect_roaming_services;
 	bool acd;
 	bool use_gateways_as_timeservers;
@@ -136,6 +143,7 @@ static struct {
 	.online_check_ipv6_url =3D NULL,
 	.online_check_initial_interval =3D =
DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL,
 	.online_check_max_interval =3D =
DEFAULT_ONLINE_CHECK_MAX_INTERVAL,
+	.online_check_interval_style =3D NULL,
 	.auto_connect_roaming_services =3D false,
 	.acd =3D false,
 	.use_gateways_as_timeservers =3D false,
@@ -166,6 +174,7 @@ static struct {
 #define CONF_ONLINE_CHECK_IPV6_URL      "OnlineCheckIPv6URL"
 #define CONF_ONLINE_CHECK_INITIAL_INTERVAL "OnlineCheckInitialInterval"
 #define CONF_ONLINE_CHECK_MAX_INTERVAL     "OnlineCheckMaxInterval"
+#define CONF_ONLINE_CHECK_INTERVAL_STYLE "OnlineCheckIntervalStyle"
 #define CONF_AUTO_CONNECT_ROAMING_SERVICES "AutoConnectRoamingServices"
 #define CONF_ACD                        "AddressConflictDetection"
 #define CONF_USE_GATEWAYS_AS_TIMESERVERS "UseGatewaysAsTimeservers"
@@ -197,6 +206,7 @@ static const char *supported_options[] =3D {
 	CONF_ONLINE_CHECK_IPV6_URL,
 	CONF_ONLINE_CHECK_INITIAL_INTERVAL,
 	CONF_ONLINE_CHECK_MAX_INTERVAL,
+	CONF_ONLINE_CHECK_INTERVAL_STYLE,
 	CONF_AUTO_CONNECT_ROAMING_SERVICES,
 	CONF_ACD,
 	CONF_USE_GATEWAYS_AS_TIMESERVERS,
@@ -342,6 +352,8 @@ static void parse_config(GKeyFile *config)
 			g_strdup(DEFAULT_ONLINE_CHECK_IPV4_URL);
 		connman_settings.online_check_ipv6_url =3D
 			g_strdup(DEFAULT_ONLINE_CHECK_IPV6_URL);
+		connman_settings.online_check_interval_style =3D
+			g_strdup(DEFAULT_ONLINE_CHECK_INTERVAL_STYLE);
 		return;
 	}
=20
@@ -565,6 +577,26 @@ static void parse_config(GKeyFile *config)
 			DEFAULT_ONLINE_CHECK_MAX_INTERVAL;
 	}
=20
+	g_clear_error(&error);
+
+	string =3D __connman_config_get_string(config, "General",
+					=
CONF_ONLINE_CHECK_INTERVAL_STYLE, &error);
+	if (!error) {
+		if ((g_strcmp0(string, =
ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI) =3D=3D 0) ||
+			(g_strcmp0(string, =
ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC) =3D=3D 0)) {
+			connman_settings.online_check_interval_style =3D =
string;
+		} else {
+			connman_warn("Incorrect online check interval =
style [%s]",
+				string);
+			connman_settings.online_check_interval_style =3D
+				=
g_strdup(DEFAULT_ONLINE_CHECK_INTERVAL_STYLE);
+		}
+	} else
+		connman_settings.online_check_interval_style =3D
+			g_strdup(DEFAULT_ONLINE_CHECK_INTERVAL_STYLE);
+
+	g_clear_error(&error);
+
 	boolean =3D __connman_config_get_bool(config, "General",
 				CONF_AUTO_CONNECT_ROAMING_SERVICES, =
&error);
 	if (!error)
@@ -801,6 +833,9 @@ char *connman_setting_get_string(const char *key)
 		return connman_settings.localtime ?
 			connman_settings.localtime : DEFAULT_LOCALTIME;
=20
+	if (g_str_equal(key, CONF_ONLINE_CHECK_INTERVAL_STYLE))
+		return connman_settings.online_check_interval_style;
+
 	return NULL;
 }
=20
diff --git a/src/main.conf b/src/main.conf
index ddd57996..abc64744 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -150,6 +150,27 @@
 # default one, in replacement.
 # EnableOnlineToReadyTransition =3D false
=20
+# The style or mathematical series function used to compute the actual
+# time, in seconds, between two "ready" to "online" HTTP-based Internet
+# reachability checks. The value of which may be either "geometric" or
+# "fibonacci".
+#
+# The "geometric" style or function simply takes the square of the
+# online check interval. For example, at a check interval of 6, the
+# time, in seconds, is 36 (6^2) seconds.
+#
+# The "fibonacci" style or function takes the value of the Fibonacci
+# sequence at the online check interval. For example, at a check
+# interval of 6, the time, in seconds, is 8 seconds.
+#
+# "fibonacci" is more aggressive in check rate up to 12 steps (its
+# equivalence point with "geometric" at 144 seconds) but is far less
+# aggresive past that point, reacing an hour at interval 19 compared
+# to "geometric" which does not reach an hour until interval 60.
+#
+# Default value is "geometric".
+# OnlineCheckIntervalStyle=3Dgeometric
+
 # List of technologies with AutoConnect =3D true which are always =
connected
 # regardless of PreferredTechnologies setting. Default value is empty =
and
 # will connect a technology only if it is at a higher preference than =
any
diff --git a/src/service.c b/src/service.c
index 55932efc..228d5f01 100644
--- a/src/service.c
+++ b/src/service.c
@@ -45,6 +45,8 @@
 #define VPN_AUTOCONNECT_TIMEOUT_STEP 30
 #define VPN_AUTOCONNECT_TIMEOUT_ATTEMPTS_THRESHOLD 270
=20
+typedef guint (*online_check_timeout_compute_t)(unsigned int interval);
+
 static DBusConnection *connection =3D NULL;
=20
 static GList *service_list =3D NULL;
@@ -58,6 +60,8 @@ static bool services_dirty =3D false;
 static bool enable_online_to_ready_transition =3D false;
 static unsigned int online_check_initial_interval =3D 0;
 static unsigned int online_check_max_interval =3D 0;
+static const char *online_check_timeout_interval_style =3D NULL;
+static online_check_timeout_compute_t online_check_timeout_compute_func =
=3D NULL;
=20
 struct connman_stats {
 	bool valid;
@@ -1438,6 +1442,82 @@ static bool check_proxy_setup(struct =
connman_service *service)
 	return false;
 }
=20
+/**
+ *  @brief
+ *    Compute a Fibonacci online check timeout based on the specified
+ *    interval.
+ *
+ *  This computes the Fibonacci online check timeout, in seconds,
+ *  based on the specified interval in a Fibonacci series. For
+ *  example, an interval of 9 yields a timeout of 34 seconds.
+ *
+ *  @note
+ *    As compared to a geometric series, the Fibonacci series is
+ *    slightly less aggressive in backing off up to the equivalence
+ *    point at interval 12, but far more aggressive past that point,
+ *    climbing to past an hour at interval 19 whereas the geometric
+ *    series does not reach that point until interval 60.
+ *
+ *  @param[in]  interval  The interval in the geometric series for
+ *                        which to compute the online check timeout.
+ *
+ *  @returns
+ *    The timeout, in seconds, for the online check.
+ *
+ *  @sa online_check_timeout_compute_fibonacci
+ *
+ */
+static guint online_check_timeout_compute_fibonacci(unsigned int =
interval)
+{
+	unsigned int i;
+	guint first =3D 0;
+	guint second =3D 1;
+	guint timeout_seconds;
+
+	for (i =3D 0; i <=3D interval; i++) {
+		timeout_seconds =3D first;
+
+		first =3D second;
+
+		second =3D second + timeout_seconds;
+	}
+
+	return timeout_seconds;
+}
+
+/**
+ *  @brief
+ *    Compute a geometric online check timeout based on the specified
+ *    interval.
+ *
+ *  This computes the geometric online check timeout, in seconds,
+ *  based on the specified interval in a geometric series, where the
+ *  resulting value is interval^2. For example, an interval of 9
+ *  yields a timeout of 81 seconds.
+ *
+ *  @note
+ *    As compared to a Fibonacci series, the geometric series is
+ *    slightly more aggressive in backing off up to the equivalence
+ *    point at interval 12, but far less aggressive past that point,
+ *    only reaching an hour at interval 90 compared to interval 19 for
+ *    Fibonacci for a similar timeout.
+ *
+ *  @param[in]  interval  The interval in the geometric series for
+ *                        which to compute the online check timeout.
+ *
+ *  @returns
+ *    The timeout, in seconds, for the online check.
+ *
+ *  @sa online_check_timeout_compute_fibonacci
+ *
+ */
+static guint online_check_timeout_compute_geometric(unsigned int =
interval)
+{
+	const guint timeout_seconds =3D interval * interval;
+
+	return timeout_seconds;
+}
+
 static void cancel_online_check(struct connman_service *service)
 {
 	if (service->online_timeout_ipv4) {
@@ -6373,17 +6453,21 @@ void __connman_service_online_check(struct =
connman_service *service,
 {
 	GSourceFunc redo_func;
 	unsigned int *interval;
+	guint *timeout;
 	enum connman_service_state current_state;
-	int timeout;
+	guint seconds;
+	guint current_timeout;
=20
 	DBG("service %p type %s success %d\n",
 		service, __connman_ipconfig_type2string(type), success);
=20
 	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4) {
 		interval =3D &service->online_check_interval_ipv4;
+		timeout =3D &service->online_timeout_ipv4;
 		redo_func =3D redo_wispr_ipv4;
 	} else {
 		interval =3D &service->online_check_interval_ipv6;
+		timeout =3D &service->online_timeout_ipv6;
 		redo_func =3D redo_wispr_ipv6;
 	}
=20
@@ -6403,18 +6487,23 @@ void __connman_service_online_check(struct =
connman_service *service,
 	}
=20
 redo_func:
-	DBG("service %p type %s interval %d", service,
-		__connman_ipconfig_type2string(type), *interval);
+	DBG("updating online checkout timeout period");
+
+	seconds =3D online_check_timeout_compute_func(*interval);
=20
-	timeout =3D g_timeout_add_seconds(*interval * *interval,
+	DBG("service %p (%s) type %d (%s) interval %d style \"%s\" =
seconds %u",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		*interval, online_check_timeout_interval_style, =
seconds);
+
+	current_timeout =3D g_timeout_add_seconds(seconds,
 				redo_func, =
connman_service_ref(service));
-	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4)
-		service->online_timeout_ipv4 =3D timeout;
-	else
-		service->online_timeout_ipv6 =3D timeout;
=20
-	/* Increment the interval for the next time, set a maximum =
timeout of
-	 * online_check_max_interval seconds * online_check_max_interval =
seconds.
+	*timeout =3D current_timeout;
+
+	/* Increment the interval for the next time, limiting to a =
maximum
+	 * interval of @a online_check_max_interval.
 	 */
 	if (*interval < online_check_max_interval)
 		(*interval)++;
@@ -7838,6 +7927,13 @@ int __connman_service_init(void)
=20
 	enable_online_to_ready_transition =3D
 		=
connman_setting_get_bool("EnableOnlineToReadyTransition");
+	online_check_timeout_interval_style =3D
+		connman_setting_get_string("OnlineCheckIntervalStyle");
+	if (g_strcmp0(online_check_timeout_interval_style, "fibonacci") =
=3D=3D 0)
+		online_check_timeout_compute_func =3D =
online_check_timeout_compute_fibonacci;
+	else
+		online_check_timeout_compute_func =3D =
online_check_timeout_compute_geometric;
+
 	online_check_initial_interval =3D
 		connman_setting_get_uint("OnlineCheckInitialInterval");
 	online_check_max_interval =3D
--=20
2.32.0

