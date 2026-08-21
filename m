Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3448F826
	for <connman@lists.linux.dev>; Fri, 21 Aug 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328809; cv=none; b=TB854Rb2xq2CSrAEHatnes0wGs3GALUqHeA4XZY3wkL52nwQptTkTpHnCieupHPTn+ban+fG4IRBjSr5IdMG+cKhRdkaK1G6DImWe81L+MQLHIaa7DhDpe7C33whW+WmRapa3bbVlFVQMNh9PhjVJiypj3iCUKkyN+TizNxDHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328809; c=relaxed/simple;
	bh=0tBI499yOLAigTswTtNtFu1g8P64KGvbnmFMtsRuP2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1WwE6ir6Ut2vgY36Om+XbEIE853nqBS8tx9jEd1BtleYk7vWGzQIy1Hik5Fx+2uUTbdIiHwByobqWCTVp0K7Ll4SMTQWhI88VeEIjAZMfmJ7KycqJm05PsqPLcsuUU7v79cF1p1wZBpS1IhthpSILBO2FdTUQh7uIDm5KzoVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=lpz521xc; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="lpz521xc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=B1RQr+Xp5nl8GADosdmLvBSibEj0BQvZIFJvAY+6Dys=; b=lpz521xcScC8EN0A0TeCWF0pRg
	kgU6hKFe2cG4ZJOx226Eq6/QhZqRhegyRUqTqO2CWY0Xi7I115cvUSQf9HUI5wv+WgadgDT3vStB2
	0IcoWwyzS+jreqU0jY3qwfzJjSMAX8+GBlCsy1CuE/4puw4icfMKhXIyw6u+w0O4mY0W7tVa2PQEb
	mclk3Bb+apAFoT2l/4CwriSmisDEFZ4tR4Jl8XtQz2YMQWFOdaEQwROuv9q/QRNwBAMMKTiTdRgoY
	3muFple+FUtagAkV8wfGpxgOmmQZkK30K8VUVQz07VELW6DHPPPIPFBxp4Jvf8aoEWvQMGtWsQzvu
	iGNu+v2Q==;
Received: from [2a10:a5c0:37:6501:3a8:42b5:e757:c455] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wxRrs-00AHmh-2E;
	Fri, 21 Aug 2026 19:13:24 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Cc: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 3/3] logcontrol: Implement net.connman.DebugLog interface as a plugin
Date: Fri, 21 Aug 2026 19:12:53 +0300
Message-ID: <20260821161304.386852-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
References: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
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
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: RCPT_COUNT_TWO(0.00); Two recipients [2]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: TO_DN_SOME(0.00); Some of the recipients have display names
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260821161304.386852-1-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

This adds a simple interface to control debugging on run-time. Logs can
be enabled per source file using the exact file name or a pattern, for
example, "*ip*" pattern would enable all files having this in their
name: iptables.c ip6tables.c ipaddress.c etc.. The interface provides
the following methods:

  array{string, boolean} List()
  void Enable(string pattern)
  void Disable(string pattern)

Enable and Disable methods allow to modify connman logging settings
without restarting it. The List method returns the list of files for
which logging can be changed at runtime including their logging enabled
or disabled status as a boolean.

API documentation is available at doc/logcontrol-api.txt.

This plugin can be enabled by --enable-logcontrol configuration option.

Co-Authored-by: Slava Monich <slava.monich@jolla.com>
---
 Makefile.plugins       |   5 ++
 configure.ac           |   5 ++
 doc/logcontrol-api.txt |  38 +++++++++
 plugins/logcontrol.c   | 181 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 doc/logcontrol-api.txt
 create mode 100644 plugins/logcontrol.c

diff --git a/Makefile.plugins b/Makefile.plugins
index bd5049ec..99915b01 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -58,6 +58,11 @@ builtin_modules += dundee
 builtin_sources += plugins/dundee.c
 endif
 
+if LOGCONTROL
+builtin_modules += logcontrol
+builtin_sources += plugins/logcontrol.c
+endif
+
 if VPN
 builtin_modules += vpn
 builtin_sources += plugins/vpn.c
diff --git a/configure.ac b/configure.ac
index dc52cf7e..9a8c7cd7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -477,6 +477,11 @@ AC_ARG_ENABLE(stats, AS_HELP_STRING([--disable-stats],
 					[enable_stats=${enableval}])
 AM_CONDITIONAL(STATS, test "${enable_stats}" != "no")
 
+AC_ARG_ENABLE(logcontrol,
+	AC_HELP_STRING([--enable-logcontrol], [enable log control plugin]),
+			[enable_logcontrol=${enableval}], [enable_logcontrol="no"])
+AM_CONDITIONAL(LOGCONTROL, test "${enable_logcontrol}" != "no")
+
 if (test "${enable_tools}" != "no"); then
 	AC_PATH_PROGS(IPTABLES_SAVE, [iptables-save], [],
 						$PATH:/sbin:/usr/sbin)
diff --git a/doc/logcontrol-api.txt b/doc/logcontrol-api.txt
new file mode 100644
index 00000000..171453a4
--- /dev/null
+++ b/doc/logcontrol-api.txt
@@ -0,0 +1,38 @@
+Debug log control
+=================
+
+Service	net.connman
+Interface	net.connman.DebugLog
+Object path	/
+
+Methods	void Enable(string pattern)
+
+			Enables all debug logs on files during run-time that
+			match the pattern.
+
+			Pattern matching uses GLib g_pattern_match_simple()
+			semantics (shell-style globs: '*', '?', '[]').
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void Disable(string pattern)
+
+			Disables all debug logs on files during run-time that
+			match the pattern.
+
+			Pattern matching is same as for Enable().
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		array{string, boolean} List()
+
+			Returns all available debug file names together with
+			with their current enabled state.
+
+			The boolean is true if debug logging is currently
+			enabled for the corresponding descriptor.
+
+			In order for Enable or Disable call to have any effect,
+			the pattern must match one or more of these strings.
+
+			Possible Errors: none.
diff --git a/plugins/logcontrol.c b/plugins/logcontrol.c
new file mode 100644
index 00000000..c9f1b8fe
--- /dev/null
+++ b/plugins/logcontrol.c
@@ -0,0 +1,181 @@
+/*
+ *
+ *  Connection Manager
+ *
+ *  Copyright (C) 2015, 2026 Jolla Ltd. All rights reserved.
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
+#include <gdbus.h>
+
+#define CONNMAN_API_SUBJECT_TO_CHANGE
+#include <connman/plugin.h>
+#include <connman/log.h>
+#include <connman.h>
+
+#define LOG_INTERFACE  CONNMAN_SERVICE ".DebugLog"
+#define LOG_PATH       "/"
+
+static DBusConnection *connection = NULL;
+
+static DBusMessage *logcontrol_dbusmsg(DBusConnection *conn, DBusMessage *msg,
+			unsigned int set_flags, unsigned int clear_flags)
+{
+	const char *pattern;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
+							DBUS_TYPE_INVALID)) {
+		connman_log_update_builtin(pattern, set_flags, clear_flags);
+		connman_plugin_log_update(pattern, set_flags, clear_flags);
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	}
+
+	return __connman_error_invalid_arguments(msg);
+}
+
+static DBusMessage *logcontrol_enable(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	return logcontrol_dbusmsg(conn, msg, CONNMAN_DEBUG_FLAG_PRINT, 0);
+}
+
+static DBusMessage *logcontrol_disable(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	return logcontrol_dbusmsg(conn, msg, 0, CONNMAN_DEBUG_FLAG_PRINT);
+}
+
+static gint logcontrol_list_compare(gconstpointer a, gconstpointer b)
+{
+	return strcmp((const char *)a, (const char *)b);
+}
+
+struct logcontrol_list_data {
+	GHashTable *hash;
+	DBusMessageIter *array;
+};
+
+static void logcontrol_list_append(gpointer name, gpointer user_data)
+{
+	struct logcontrol_list_data *data = user_data;
+	struct connman_debug_desc *desc;
+	DBusMessageIter *array = data->array;
+	DBusMessageIter iter;
+	const char *name_str = name;
+	dbus_bool_t enabled;
+
+	desc = g_hash_table_lookup(data->hash, name);
+	if (!desc)
+		return;
+
+	enabled = connman_log_is_enabled(desc);
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_STRUCT, NULL, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name_str);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BOOLEAN, &enabled);
+
+	dbus_message_iter_close_container(array, &iter);
+}
+
+static DBusMessage *logcontrol_list(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+	GHashTable *hash;
+	GList *names;
+	struct logcontrol_list_data list_data;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	hash = g_hash_table_new(g_str_hash, g_str_equal);
+
+	connman_log_list_builtin(hash);
+	connman_plugin_log_list(hash);
+
+	names = g_list_sort(g_hash_table_get_keys(hash),
+						logcontrol_list_compare);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING
+			DBUS_TYPE_BOOLEAN_AS_STRING
+			DBUS_STRUCT_END_CHAR_AS_STRING,
+			&array);
+
+	list_data.hash = hash;
+	list_data.array = &array;
+	g_list_foreach(names, logcontrol_list_append, &list_data);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_list_free(names);
+	g_hash_table_destroy(hash);
+
+	return reply;
+}
+
+static const GDBusMethodTable methods[] = {
+	{ GDBUS_METHOD("Enable", GDBUS_ARGS({ "pattern", "s" }), NULL,
+							logcontrol_enable) },
+	{ GDBUS_METHOD("Disable", GDBUS_ARGS({ "pattern", "s" }), NULL,
+							logcontrol_disable) },
+	{ GDBUS_METHOD("List", NULL, GDBUS_ARGS({ "names", "a(sb)" }),
+							logcontrol_list) },
+	{ },
+};
+
+static int logcontrol_init(void)
+{
+	DBG("");
+
+	connection = connman_dbus_get_connection();
+	if (!connection)
+		return -1;
+
+	if (!g_dbus_register_interface(connection, LOG_PATH, LOG_INTERFACE,
+					methods, NULL, NULL, NULL, NULL)) {
+		connman_error("logcontrol: failed to register " LOG_INTERFACE);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void logcontrol_exit(void)
+{
+	DBG("");
+
+	if (connection) {
+		g_dbus_unregister_interface(connection, LOG_PATH,
+								LOG_INTERFACE);
+		dbus_connection_unref(connection);
+		connection = NULL;
+	}
+}
+
+CONNMAN_PLUGIN_DEFINE(logcontrol, "Debug log control interface",
+			VERSION, CONNMAN_PLUGIN_PRIORITY_DEFAULT,
+			logcontrol_init, logcontrol_exit)
-- 
2.47.3

