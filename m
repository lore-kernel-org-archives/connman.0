Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E72FB2
	for <connman@lists.linux.dev>; Thu,  2 Sep 2021 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0b812fe0-0c00-11ec-96db-005056bdf889;
	Thu, 02 Sep 2021 18:11:27 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/5] vpn-provider: Add auth error check heuristic to avoid losing creds
Date: Thu,  2 Sep 2021 18:11:22 +0300
Message-Id: <20210902151124.4983-4-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
References: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a heuristic into authentication error getter to avoid losing
credentials in scenarios where the VPN server expects a clean shutdown
but the route/network has gone down and client cannot do this and as a
result the server responds to consequtive authentications with auth
failed message. As a result this would cause the VPN agent to clear the
credentials as the authentication errors are passed to it, even though
there was no real authentication error in place.

This was noticed to happen in a scenario where an OpenVPN service is
1) connected over UDP using cellular, 2) connection is switched to WiFi
letting VPN to connect, 3) triggering cellular off and back on again,
4) disconnecting WiFi and letting VPN to connect over cellular after
which 5) WiFi is re-enabled. Usually this is enough to time the network
disconnects in the sense that OpenVPN binary cannot send the disconnect
message back to server having following in the system log:
    openvpn: event_wait : Interrupted system call (code=4)
    openvpn: SIGTERM received, sending exit notification to peer
    openvpn: write UDP: Network is unreachable (code=101)
    openvpn: Closing TUN/TAP interface

As a solution each provider sets a run-time only "previous_connect_time"
using the monotonic boot time clock whenever the connection has been
successful. This, in conjunction with a limit for allowed authentication
errors is used to determine whether the actual authentication error
count reported to VPN agent or not. After a connection has been made all
errors are cleared. If the connection abruptly goes away, e.g., the
server is lost only the conn_error_counter is increased and
previous_connect_time is cleared but this does not trigger clearing of
the authentication error and, provided the credentials are still valid,
next attempt succeeds whet the server is again reachable. Same applies
for a proper disconnect. Thus, this solution does not interfere with
normal cases but mitigates unwanted credential loss in case if the VPN
server determines connection limit being full and reports back with
authentication error message.

Some VPNs may not require this option at all. Thus, limit is set as a
configurable per provider parameter "AuthErrorLimit" which defaults to
"1" and the heuristic can be completely disabled by setting value "0".
The value can be changed either by the user over D-Bus or made to be a
higher default for a provider by using provider_set_auth_error_limit(),
e.g., by a VPN plugin. The default per provider value is used only when
there is no user defined one. This way the plugin default value will not
get saved to the VPN settings and plugin default is changeable.
---
 vpn/vpn-provider.c | 110 +++++++++++++++++++++++++++++++++++++++++++++
 vpn/vpn-provider.h |   2 +
 2 files changed, 112 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 90e21e95..4200c462 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -24,6 +24,14 @@
 #include <config.h>
 #endif
 
+/*
+ * One hour difference in seconds between connections for checking whether to
+ * treat the authentication error as a real error or as a result of rapid
+ * transport change.
+ */
+#define CONNECT_OK_DIFF		((time_t)60*60)
+#define AUTH_ERROR_LIMIT_DEFAULT	1
+
 #define STATE_INTERVAL_DEFAULT		0
 
 #define CONNMAN_STATE_ONLINE		"online"
@@ -39,6 +47,7 @@
 #include <connman/log.h>
 #include <gweb/gresolv.h>
 #include <netdb.h>
+#include <time.h>
 
 #include "../src/connman.h"
 #include "connman/agent.h"
@@ -100,6 +109,8 @@ struct vpn_provider {
 	unsigned int auth_error_counter;
 	unsigned int conn_error_counter;
 	unsigned int signal_watch;
+	unsigned int auth_error_limit;
+	time_t previous_connect_time;
 };
 
 struct vpn_provider_connect_data {
@@ -1238,12 +1249,15 @@ static void reset_error_counters(struct vpn_provider *provider)
 	if (!provider)
 		return;
 
+	DBG("provider %p", provider);
+
 	provider->auth_error_counter = provider->conn_error_counter = 0;
 }
 
 static int vpn_provider_save(struct vpn_provider *provider)
 {
 	GKeyFile *keyfile;
+	const char *value;
 
 	DBG("provider %p immutable %s", provider,
 					provider->immutable ? "yes" : "no");
@@ -1274,6 +1288,11 @@ static int vpn_provider_save(struct vpn_provider *provider)
 	g_key_file_set_string(keyfile, provider->identifier,
 			"VPN.Domain", provider->domain);
 
+	value = vpn_provider_get_string(provider, "AuthErrorLimit");
+	if (value)
+		g_key_file_set_string(keyfile, provider->identifier,
+						"AuthErrorLimit", value);
+
 	if (provider->user_networks) {
 		gchar **networks;
 		gsize network_count;
@@ -1782,6 +1801,18 @@ static void append_dns(DBusMessageIter *iter, void *user_data)
 		append_nameservers(iter, provider->nameservers);
 }
 
+static time_t get_uptime(void)
+{
+	struct timespec t = { 0 };
+
+	if (clock_gettime(CLOCK_BOOTTIME, &t) == -1) {
+		connman_warn("clock_gettime() error %d, uptime failed", errno);
+		return 0;
+	}
+
+	return t.tv_sec;
+}
+
 static int provider_indicate_state(struct vpn_provider *provider,
 				enum vpn_provider_state state)
 {
@@ -1797,6 +1828,8 @@ static int provider_indicate_state(struct vpn_provider *provider,
 	provider->state = state;
 
 	if (state == VPN_PROVIDER_STATE_READY) {
+		provider->previous_connect_time = get_uptime();
+
 		connman_dbus_property_changed_basic(provider->path,
 					VPN_CONNECTION_INTERFACE, "Index",
 					DBUS_TYPE_INT32, &provider->index);
@@ -2009,8 +2042,10 @@ void vpn_provider_add_error(struct vpn_provider *provider,
 {
 	switch (error) {
 	case VPN_PROVIDER_ERROR_UNKNOWN:
+		provider->previous_connect_time = 0;
 		break;
 	case VPN_PROVIDER_ERROR_CONNECT_FAILED:
+		provider->previous_connect_time = 0;
 		++provider->conn_error_counter;
 		break;
 	case VPN_PROVIDER_ERROR_LOGIN_FAILED:
@@ -2018,6 +2053,10 @@ void vpn_provider_add_error(struct vpn_provider *provider,
 		++provider->auth_error_counter;
 		break;
 	}
+
+	DBG("%p connect errors %d auth errors %d", provider,
+						provider->conn_error_counter,
+						provider->auth_error_counter);
 }
 
 int vpn_provider_indicate_error(struct vpn_provider *provider,
@@ -2192,6 +2231,7 @@ static void provider_initialize(struct vpn_provider *provider)
 					g_free, free_route);
 	provider->setting_strings = g_hash_table_new_full(g_str_hash,
 					g_str_equal, g_free, free_setting);
+	provider->auth_error_limit = AUTH_ERROR_LIMIT_DEFAULT;
 }
 
 static struct vpn_provider *vpn_provider_new(void)
@@ -2897,6 +2937,15 @@ bool vpn_provider_get_string_immutable(struct vpn_provider *provider,
 	return setting->immutable;
 }
 
+void vpn_provider_set_auth_error_limit(struct vpn_provider *provider,
+							unsigned int limit)
+{
+	if (!provider)
+		return;
+
+	provider->auth_error_limit = limit;
+}
+
 bool __vpn_provider_check_routes(struct vpn_provider *provider)
 {
 	if (!provider)
@@ -3205,9 +3254,70 @@ const char *vpn_provider_get_path(struct vpn_provider *provider)
 	return provider->path;
 }
 
+/*
+ * This crude heuristic is meant to mitigate an issue with certain VPN
+ * providers that allow only one authentication per account at a time. These
+ * providers require the VPN client shuts down cleanly by sending an exit
+ * notification. In many cases this is not possible as the transport may
+ * already be gone and there is no route to the VPN server. In such case server
+ * may return authentication error to indicate that an other client is active
+ * and reserves the slot.
+ *
+ * By allowing the VPN client to try again with the following conditons the
+ * unnecessary credential resets done by VPN agent can be avoided. VPN client
+ * is allowed to retry if 1) there was a successful connection to the server
+ * within the specified CONNECT_OK_DIFF time and 2) the provider specific
+ * limit for auth errors is not reached the unnecessary credential resets in
+ * this case are avoided.
+ *
+ * This feature is controlled by the provider specific value for
+ * "AuthErrorLimit". Setting the value to 0 feature is disabled. User defined
+ * value is preferred if set, otherwise plugin default set with
+ * vpn_provider_set_auth_error_limit() is used, which defaults to
+ * AUTH_ERROR_LIMIT_DEFAULT.
+ */
+static bool ignore_authentication_errors(struct vpn_provider *provider)
+{
+	const char *val;
+	unsigned int limit;
+	time_t uptime;
+	time_t diff;
+
+	val = vpn_provider_get_string(provider, "AuthErrorLimit");
+	if (val)
+		limit = g_ascii_strtoull(val, NULL, 10);
+	else
+		limit = provider->auth_error_limit;
+
+	if (!limit || !provider->previous_connect_time) {
+		DBG("%p errors %u %s", provider, provider->auth_error_counter,
+					!limit ?
+					"disabled by 0 limit" :
+					"no previous ok conn");
+		return false;
+	}
+
+	uptime = get_uptime();
+	diff = uptime - provider->previous_connect_time;
+
+	DBG("%p errors %u limit %u uptime %jd time diff %jd", provider,
+				provider->auth_error_counter, limit,
+				(intmax_t)uptime, (intmax_t)diff);
+
+	if (diff <= CONNECT_OK_DIFF && provider->auth_error_counter <= limit) {
+		DBG("ignore auth errors");
+		return true;
+	}
+
+	return false;
+}
+
 unsigned int vpn_provider_get_authentication_errors(
 						struct vpn_provider *provider)
 {
+	if (ignore_authentication_errors(provider))
+		return 0;
+
 	return provider->auth_error_counter;
 }
 
diff --git a/vpn/vpn-provider.h b/vpn/vpn-provider.h
index f7fa8591..ee09e8ef 100644
--- a/vpn/vpn-provider.h
+++ b/vpn/vpn-provider.h
@@ -88,6 +88,8 @@ int vpn_provider_set_boolean(struct vpn_provider *provider, const char *key,
 							bool force_change);
 bool vpn_provider_get_boolean(struct vpn_provider *provider, const char *key,
 							bool default_value);
+void vpn_provider_set_auth_error_limit(struct vpn_provider *provider,
+							unsigned int limit);
 
 int vpn_provider_set_state(struct vpn_provider *provider,
 					enum vpn_provider_state state);
-- 
2.20.1

