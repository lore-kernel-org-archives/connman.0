Received: from griffin.geeknet.cz (griffin.geeknet.cz [94.142.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FA7A
	for <connman@lists.linux.dev>; Wed, 15 Jun 2022 16:54:37 +0000 (UTC)
Received: 
	by griffin.geeknet.cz (OpenSMTPD) with ESMTP id bfda7d89
	for <connman@lists.linux.dev>;
	Wed, 15 Jun 2022 18:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jirutka.cz; h=from:to:cc
	:subject:date:message-id; s=mail; bh=nwiG9nZ/kW9OoV/nq/YBOJxviCU
	=; b=q8opdNCf/IwdDqPiWs3hlSb5kpKtt7UDoo3bofxnTKLe8j1u9FlQrtJX5Wd
	7BGr/oMl7r6cctO1vsciAv7c6YnDtakaauLBWJX4lUo7G1z7+1ffxOwlNIj52Vb0
	kj8dvVJEGB0EXC5IWUei45ZZqzdH3NbOEBGJJkfVlZVM/lqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=jirutka.cz; h=from:to:cc
	:subject:date:message-id; q=dns; s=mail; b=Njo6MwnzWmi4Teb9tS8x0
	EE3Jv3m/1AcUhl9axzvIT9eMGTx0r3Knd2Pr+iDz6DVnzUvfudhMoEH72RMn30qw
	/6lsbVzlzhzUwI2RgSU7YhKThIJGmQy3ZkpgMJDYJjzJaz6DUQJ5MlJvo2lq0eHl
	KPC3U4TRN57Q2zpBoq9Rew=
Received: 
	by griffin.geeknet.cz (OpenSMTPD) with ESMTPSA id 401f4519 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
	Wed, 15 Jun 2022 18:54:28 +0200 (CEST)
From: Jakub Jirutka <jakub@jirutka.cz>
To: connman@lists.linux.dev
Cc: Jakub Jirutka <jakub@jirutka.cz>
Subject: [PATCH] resolver: Add path to resolv.conf to config options
Date: Wed, 15 Jun 2022 18:53:50 +0200
Message-Id: <20220615165350.11431-1-jakub@jirutka.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>

Before (current state):
If the <STATEDIR> (/var/run/connman) directory exists, ConnMan writes
resolvfile into <STATEDIR>/resolv.conf. If it doesn't exist, it writes
into /etc/resolv.conf. If it fails, it does nothing.

Problem:
This is unclear and error prone. The user (or package maintainer) may
create the /var/run/connman directory for a pidfile or whatever and
surely doesn't expect ConnMan to suddenly stop updating
/etc/resolv.conf. Or the user doesn't want ConnMan to touch
/etc/resolv.conf (e.g. openresolv or similar tool is used),
ever. Configuring this use case by creating directory /run/connman (as
suggested e.g. on
https://wiki.archlinux.org/title/ConnMan#/etc/resolv.conf) is really
weird... and error prone.

After:
The user can explicitly set path for the resolvfile in connman.conf via
"ResolvConf" option. If this option is set, ConnMan writes
resolvfile to the specified file (and creates it if doesn't exist). If
it fails (e.g. directory doesn't exist or file is not writable) or the
path is /dev/null or an empty string, it does nothing.
If this option is not set, it behaves as before.
---
 doc/connman.conf.5.in |  8 ++++++++
 src/main.c            | 14 ++++++++++++++
 src/resolver.c        | 33 ++++++++++++++++++++++++++-------
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index d8084118..1f9b2908 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -215,6 +215,14 @@ Enable regdomain to be changed along timezone changes. With this option set to
 true each time the timezone changes the first present ISO3166 country code is
 being read from /usr/share/zoneinfo/zone1970.tab and set as regdom value.
 Default value is false.
+.TP
+.BI ResolvConf= string
+Path to resolv.conf file. If the file does not exist, but intermediate
+directories exist, it will be created.
+If this option is not set, it tries to write into
+@runstatedir@/connman/resolv.conf and fallbacks to @sysconfdir@/resolv.conf if
+it fails (@runstatedir@/connman does not exist or is not writeable).
+If you do not want to update resolv.conf, you can set /dev/null.
 .SH "EXAMPLE"
 The following example configuration disables hostname updates and enables
 ethernet tethering.
diff --git a/src/main.c b/src/main.c
index 5c632fd1..70277f66 100644
--- a/src/main.c
+++ b/src/main.c
@@ -110,6 +110,7 @@ static struct {
 	bool use_gateways_as_timeservers;
 	char *localtime;
 	bool regdom_follows_timezone;
+	char *resolv_conf;
 } connman_settings  = {
 	.bg_scan = true,
 	.pref_timeservers = NULL,
@@ -138,6 +139,7 @@ static struct {
 	.acd = false,
 	.use_gateways_as_timeservers = false,
 	.localtime = NULL,
+	.resolv_conf = NULL,
 };
 
 #define CONF_BG_SCAN                    "BackgroundScanning"
@@ -168,6 +170,7 @@ static struct {
 #define CONF_USE_GATEWAYS_AS_TIMESERVERS "UseGatewaysAsTimeservers"
 #define CONF_LOCALTIME                  "Localtime"
 #define CONF_REGDOM_FOLLOWS_TIMEZONE    "RegdomFollowsTimezone"
+#define CONF_RESOLV_CONF                "ResolvConf"
 
 static const char *supported_options[] = {
 	CONF_BG_SCAN,
@@ -198,6 +201,7 @@ static const char *supported_options[] = {
 	CONF_USE_GATEWAYS_AS_TIMESERVERS,
 	CONF_LOCALTIME,
 	CONF_REGDOM_FOLLOWS_TIMEZONE,
+	CONF_RESOLV_CONF,
 	NULL
 };
 
@@ -594,6 +598,13 @@ static void parse_config(GKeyFile *config)
 	if (!error)
 		connman_settings.regdom_follows_timezone = boolean;
 
+	string = __connman_config_get_string(config, "General",
+				CONF_RESOLV_CONF, &error);
+	if (!error)
+		connman_settings.resolv_conf = string;
+	else
+		g_free(string);
+
 	g_clear_error(&error);
 }
 
@@ -830,6 +841,9 @@ bool connman_setting_get_bool(const char *key)
 	if (g_str_equal(key, CONF_REGDOM_FOLLOWS_TIMEZONE))
 		return connman_settings.regdom_follows_timezone;
 
+	if (g_str_equal(key, CONF_RESOLV_CONF))
+		return connman_settings.resolv_conf;
+
 	return false;
 }
 
diff --git a/src/resolver.c b/src/resolver.c
index 618353fd..4ab51d6b 100644
--- a/src/resolver.c
+++ b/src/resolver.c
@@ -103,6 +103,7 @@ static int resolvfile_export(void)
 	int fd, err;
 	unsigned int count;
 	mode_t old_umask;
+	const char *resolv_conf;
 
 	content = g_string_new("# Generated by Connection Manager\n");
 
@@ -161,15 +162,33 @@ static int resolvfile_export(void)
 
 	old_umask = umask(022);
 
-	fd = open(RESOLV_CONF_STATEDIR, O_RDWR | O_CREAT | O_CLOEXEC,
-					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-	if (fd < 0) {
-		connman_warn_once("Cannot create "RESOLV_CONF_STATEDIR" "
-			"falling back to "RESOLV_CONF_ETC);
+	resolv_conf = connman_setting_get_string("ResolvConf");
+	/*
+	 * TODO: This is mainly for backward compatibility. In some future version,
+	 * "ResolvConf" setting should default to RESOLV_CONF_STATEDIR or
+	 * RESOLV_CONF_ETC and this branch can be removed.
+	 */
+	if (resolv_conf == NULL) {
+		fd = open(RESOLV_CONF_STATEDIR, O_RDWR | O_CREAT | O_CLOEXEC,
+						S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		if (fd < 0) {
+			connman_warn_once("Cannot create "RESOLV_CONF_STATEDIR" "
+				"falling back to "RESOLV_CONF_ETC);
 
-		fd = open(RESOLV_CONF_ETC, O_RDWR | O_CREAT | O_CLOEXEC,
-					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+			fd = open(RESOLV_CONF_ETC, O_RDWR | O_CREAT | O_CLOEXEC,
+						S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
+			if (fd < 0) {
+				err = -errno;
+				goto done;
+			}
+		}
+	} else if (resolv_conf[0] == '\0' || strcmp(resolv_conf, "/dev/null") == 0) {
+		err = 0;
+		goto done;
+	} else {
+		fd = open(resolv_conf, O_RDWR | O_CREAT | O_CLOEXEC,
+						S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 		if (fd < 0) {
 			err = -errno;
 			goto done;
-- 
2.16.4

