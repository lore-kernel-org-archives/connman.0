Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34DC3206
	for <connman@lists.linux.dev>; Tue,  5 Apr 2022 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 0ed9b980-b4ed-11ec-877a-005056bdfda7;
	Tue, 05 Apr 2022 17:31:19 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/4] timezone: Change regdom along timezone, use localtime config
Date: Tue,  5 Apr 2022 17:31:15 +0300
Message-Id: <20220405143116.2272080-4-jussi.laakkonen@jolla.com>
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

This is an optional feature and when enabled with RegdomFollowsTimezone
config option the regdom is changed when the timezone changes. This
feature is useful in cases when the devices without a cellular
functionality or a SIM card to set the regdom for WiFi via regdom
changes indicated by Ofono plugin are remaining the default setting (US).
As a result some region specific channels cannot be utilized with WiFi.

The ISO3166 country code is read from /usr/share/zoneinfo/zone1970.tab
using the set timezone. This is done at startup and when there is an
inotify event for the localtime. The first ISO3166 country code set on
the line is used.

Timezone.c now uses localtime configured in main.conf. It may be a
symlink as external service can manage localtime so IN_CREATE event
is added for inotify watch.
---
 src/timezone.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/src/timezone.c b/src/timezone.c
index cc499097..484d3ecb 100644
--- a/src/timezone.c
+++ b/src/timezone.c
@@ -38,9 +38,9 @@
 
 #include "connman.h"
 
-#define ETC_LOCALTIME		"/etc/localtime"
 #define ETC_SYSCONFIG_CLOCK	"/etc/sysconfig/clock"
 #define USR_SHARE_ZONEINFO	"/usr/share/zoneinfo"
+#define USR_SHARE_ZONEINFO_MAP	USR_SHARE_ZONEINFO "/zone1970.tab"
 
 static char *read_key_file(const char *pathname, const char *key)
 {
@@ -228,18 +228,99 @@ static char *find_origin(void *src_map, struct stat *src_st,
 	return NULL;
 }
 
+static char *get_timezone_alpha2(const char *zone)
+{
+	GIOChannel *channel;
+	struct stat st;
+	char **tokens;
+	char *line;
+	char *alpha2 = NULL;
+	gsize len;
+	int fd;
+
+	if (!zone)
+		return NULL;
+
+	fd = open(USR_SHARE_ZONEINFO_MAP, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		connman_warn("failed to open zoneinfo map %s",
+							USR_SHARE_ZONEINFO_MAP);
+		return NULL;
+	}
+
+	if (fstat(fd, &st) < 0) {
+		connman_warn("zoneinfo map does not exist");
+		close(fd);
+		return NULL;
+	}
+
+	channel = g_io_channel_unix_new(fd);
+	if (!channel) {
+		connman_warn("failed to create io channel for %s",
+							USR_SHARE_ZONEINFO_MAP);
+		close(fd);
+		return NULL;
+	}
+
+	DBG("read %s for %s", USR_SHARE_ZONEINFO_MAP, zone);
+	g_io_channel_set_encoding(channel, "UTF-8", NULL);
+
+	while (g_io_channel_read_line(channel, &line, &len, NULL, NULL) ==
+							G_IO_STATUS_NORMAL) {
+		if (!line || !*line || *line == '#' || *line == '\n')
+			continue;
+
+		/* File format: Countrycodes Coordinates TZ Comments */
+		tokens = g_strsplit_set(line, " \t", 4);
+		if (!tokens) {
+			connman_warn("line %s failed to parse", line);
+			continue;
+		}
+
+		if (g_strv_length(tokens) >= 3 && !g_strcmp0(
+						g_strstrip(tokens[2]), zone)) {
+			/*
+			 * Multiple country codes can be listed, use the first
+			 * 2 chars.
+			 */
+			alpha2 = g_strndup(g_strstrip(tokens[0]), 2);
+			if (strlen(alpha2) != 2) {
+				connman_warn("Invalid ISO3166 code %s", alpha2);
+				g_free(alpha2);
+				alpha2 = NULL;
+				break;
+			}
+
+			DBG("Zone %s ISO3166 country code %s", zone, alpha2);
+		}
+
+		g_strfreev(tokens);
+		g_free(line);
+
+		if (alpha2)
+			break;
+	}
+
+	g_io_channel_shutdown(channel, FALSE, NULL);
+	close(fd);
+
+	return alpha2;
+}
+
 char *__connman_timezone_lookup(void)
 {
 	struct stat st;
 	void *map;
 	int fd;
 	char *zone;
+	char *alpha2;
 
 	zone = read_key_file(ETC_SYSCONFIG_CLOCK, "ZONE");
 
 	DBG("sysconfig zone %s", zone);
 
-	fd = open(ETC_LOCALTIME, O_RDONLY | O_CLOEXEC);
+	fd = open(connman_setting_get_string("Localtime"),
+							O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		g_free(zone);
 		return NULL;
@@ -283,6 +364,15 @@ done:
 
 	DBG("localtime zone %s", zone);
 
+	if (connman_setting_get_bool("RegdomFollowsTimezone")) {
+		alpha2 = get_timezone_alpha2(zone);
+		if (alpha2) {
+			DBG("change regdom to %s", alpha2);
+			connman_technology_set_regdom(alpha2);
+			g_free(alpha2);
+		}
+	}
+
 	return zone;
 }
 
@@ -338,7 +428,7 @@ int __connman_timezone_change(const char *zone)
 		return -EIO;
 	}
 
-	err = write_file(map, &st, ETC_LOCALTIME);
+	err = write_file(map, &st, connman_setting_get_string("Localtime"));
 
 	munmap(map, st.st_size);
 
@@ -432,9 +522,9 @@ int __connman_timezone_init(void)
 
 	g_io_channel_unref(channel);
 
-	dirname = g_path_get_dirname(ETC_LOCALTIME);
+	dirname = g_path_get_dirname(connman_setting_get_string("Localtime"));
 
-	wd = inotify_add_watch(fd, dirname, IN_DONT_FOLLOW |
+	wd = inotify_add_watch(fd, dirname, IN_CREATE | IN_DONT_FOLLOW |
 						IN_CLOSE_WRITE | IN_MOVED_TO);
 
 	g_free(dirname);
-- 
2.30.2

