Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE3123779
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jolla.com
Received: from localhost.localdomain (88-113-60-79.elisa-laajakaista.fi [88.113.60.79])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 5175d85e-a0e1-11ee-b3cf-005056bd6ce9;
	Fri, 22 Dec 2023 17:46:49 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/3] timezone: Fix resolving of proper ISO3166 code from tz data
Date: Fri, 22 Dec 2023 17:46:45 +0200
Message-Id: <20231222154645.278128-4-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
References: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is possible that the region set as localtime region may have matches
in either of the zone map files. And in some cases there may be ISO3166
codes in the deprecated files that are not supported by the backends
such as gsupplicant to set the regulatory domain. Ålands/Mariehamn is an
example of this since as a region it only exists in zone.tab and
provides ISO3166 code AX which cannot be supported as regulatory domain.
But zone1970.tab contains the ISO3166 as a sub-region code for Finland
(FI) that should be set.

Furthermore, the timezone files for sub-regions, like with Ålands in
Finland and Pacific/Midway as UM -> AS, are identical copies and cannot be
compared solely by checking the mmap()'d entries. The path needs to be
taken into account or wrong region might be generated as a search
parameter for getting the ISO3166 code. Otherwise the results in some
cases might be ambiguous and the localtime set would yield another
region as a search parameter for the ISO3661 code.

Therefore, these changes add the real path utilized from the Localtime
path set in ConnMan settings to be used along the comparison of timezone
files. And the resolving of the ISO3661 code supports now more laborous
search if the code is not found using the region as a search parameter.
In such case the ISO3661 code is attempted to be searched from the
deprecated tz map and when found this code is used to search the
zone1970.tab again for a match in any of the defined ISO3166 string
lists. As a result the ISO3166 code of the main region is set that
should be supported by the varying backends to set the WiFi regulatory
domain.
---
 src/timezone.c | 178 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 152 insertions(+), 26 deletions(-)

diff --git a/src/timezone.c b/src/timezone.c
index f8d192df..89c44895 100644
--- a/src/timezone.c
+++ b/src/timezone.c
@@ -38,9 +38,10 @@
 
 #include "connman.h"
 
-#define ETC_SYSCONFIG_CLOCK	"/etc/sysconfig/clock"
-#define USR_SHARE_ZONEINFO	"/usr/share/zoneinfo"
-#define USR_SHARE_ZONEINFO_MAP	USR_SHARE_ZONEINFO "/zone1970.tab"
+#define ETC_SYSCONFIG_CLOCK		"/etc/sysconfig/clock"
+#define USR_SHARE_ZONEINFO		"/usr/share/zoneinfo"
+#define USR_SHARE_ZONEINFO_MAP		USR_SHARE_ZONEINFO "/zone1970.tab"
+#define USR_SHARE_ZONEINFO_MAP_OLD	USR_SHARE_ZONEINFO "/zone.tab"
 
 static char *read_key_file(const char *pathname, const char *key)
 {
@@ -115,12 +116,17 @@ static char *read_key_file(const char *pathname, const char *key)
 }
 
 static int compare_file(void *src_map, struct stat *src_st,
-						const char *pathname)
+				const char *real_path, const char *pathname)
 {
 	struct stat dst_st;
 	void *dst_map;
 	int fd, result;
 
+	DBG("real path %s path name %s", real_path, pathname);
+
+	if (real_path && g_strcmp0(real_path, pathname))
+		return -1;
+
 	fd = open(pathname, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		return -1;
@@ -151,7 +157,8 @@ static int compare_file(void *src_map, struct stat *src_st,
 }
 
 static char *find_origin(void *src_map, struct stat *src_st,
-				const char *basepath, const char *subpath)
+				const char* real_path, const char *basepath,
+				const char *subpath)
 {
 	DIR *dir;
 	struct dirent *d;
@@ -186,7 +193,8 @@ static char *find_origin(void *src_map, struct stat *src_st,
 						"%s/%s/%s", basepath,
 							subpath, d->d_name);
 
-			if (compare_file(src_map, src_st, pathname) == 0) {
+			if (compare_file(src_map, src_st, real_path, pathname)
+									== 0) {
 				if (!subpath)
 					str = g_strdup(d->d_name);
 				else
@@ -214,7 +222,8 @@ static char *find_origin(void *src_map, struct stat *src_st,
 				snprintf(pathname, sizeof(pathname),
 						"%s/%s", subpath, d->d_name);
 
-			str = find_origin(src_map, src_st, basepath, pathname);
+			str = find_origin(src_map, src_st, real_path, basepath,
+						pathname);
 			if (str) {
 				closedir(dir);
 				return str;
@@ -228,7 +237,52 @@ static char *find_origin(void *src_map, struct stat *src_st,
 	return NULL;
 }
 
-static char *get_timezone_alpha2(const char *zone)
+/* TZ map file format: Countrycodes Coordinates TZ Comments */
+enum tz_map_item {
+	TZ_MAP_ITEM_ISO3166 = 0,
+	TZ_MAP_ITEM_COORDINATE = 1,
+	TZ_MAP_ITEM_TIMEZONE = 2,
+	TZ_MAP_ITEM_COMMENT = 3,
+};
+
+static bool iso3166_matches(const char *codes, const char *iso3166)
+{
+	gchar **tokens;
+	guint len;
+	guint i;
+	bool ret = false;
+
+	if (!codes || !iso3166)
+		return false;
+
+	tokens = g_strsplit(codes, ",", -1);
+	if (!tokens)
+		return false;
+
+	len = g_strv_length(tokens);
+	if (len < 2) {
+		g_strfreev(tokens);
+		return false;
+	}
+
+	DBG("search %s from %s", iso3166, codes);
+
+	for (i = 0; i < len; i++) {
+		DBG("#%d %s", i, tokens[i]);
+
+		if (!g_strcmp0(tokens[i], iso3166)) {
+			ret = true;
+			break;
+		}
+	}
+
+	g_strfreev(tokens);
+
+	return ret;
+}
+
+static char *get_timezone_alpha2(const char *zone, const char *mapfile,
+						enum tz_map_item map_item)
 {
 	GIOChannel *channel;
 	struct stat st;
@@ -236,15 +290,15 @@ static char *get_timezone_alpha2(const char *zone)
 	char *line;
 	char *alpha2 = NULL;
 	gsize len;
+	bool found = false;
 	int fd;
 
 	if (!zone)
 		return NULL;
 
-	fd = open(USR_SHARE_ZONEINFO_MAP, O_RDONLY | O_CLOEXEC);
+	fd = open(mapfile, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
-		connman_warn("failed to open zoneinfo map %s",
-							USR_SHARE_ZONEINFO_MAP);
+		connman_warn("failed to open zoneinfo map %s", mapfile);
 		return NULL;
 	}
 
@@ -256,23 +310,23 @@ static char *get_timezone_alpha2(const char *zone)
 
 	channel = g_io_channel_unix_new(fd);
 	if (!channel) {
-		connman_warn("failed to create io channel for %s",
-							USR_SHARE_ZONEINFO_MAP);
+		connman_warn("failed to create io channel for %s", mapfile);
 		close(fd);
 		return NULL;
 	}
 
-	DBG("read %s for %s", USR_SHARE_ZONEINFO_MAP, zone);
+	DBG("read %s for %s", mapfile, zone);
 	g_io_channel_set_encoding(channel, "UTF-8", NULL);
 
 	while (g_io_channel_read_line(channel, &line, &len, NULL, NULL) ==
 							G_IO_STATUS_NORMAL) {
+		found = false;
+
 		if (!line || !*line || *line == '#' || *line == '\n') {
 			g_free(line);
 			continue;
 		}
 
-		/* File format: Countrycodes Coordinates TZ Comments */
 		tokens = g_strsplit_set(line, " \t", 4);
 		if (!tokens) {
 			connman_warn("line %s failed to parse", line);
@@ -280,13 +334,35 @@ static char *get_timezone_alpha2(const char *zone)
 			continue;
 		}
 
-		if (g_strv_length(tokens) >= 3 && !g_strcmp0(
-						g_strstrip(tokens[2]), zone)) {
+		if (g_strv_length(tokens) >= 3) {
+			switch (map_item) {
+			case TZ_MAP_ITEM_ISO3166:
+
+				if (!g_strcmp0(tokens[0], zone)) {
+					found = true;
+					break;
+				}
+
+				if (iso3166_matches(tokens[0], zone))
+					found = true;
+				break;
+			case TZ_MAP_ITEM_COORDINATE:
+				break;
+			case TZ_MAP_ITEM_TIMEZONE:
+				if (!g_strcmp0(g_strstrip(tokens[2]), zone))
+					found = true;
+				break;
+			case TZ_MAP_ITEM_COMMENT:
+				break;
+			}
+
 			/*
 			 * Multiple country codes can be listed, use the first
-			 * 2 chars.
+			 * 2 chars as backends such as gsupplicant support only
+			 * the main country code.
 			 */
-			alpha2 = g_strndup(g_strstrip(tokens[0]), 2);
+			if (found)
+				alpha2 = g_strndup(g_strstrip(tokens[0]), 2);
 		}
 
 		g_strfreev(tokens);
@@ -300,9 +376,8 @@ static char *get_timezone_alpha2(const char *zone)
 			} else {
 				DBG("Zone %s ISO3166 country code %s", zone,
 									alpha2);
+				break;
 			}
-
-			break;
 		}
 	}
 
@@ -312,6 +387,44 @@ static char *get_timezone_alpha2(const char *zone)
 	return alpha2;
 }
 
+static char *try_get_timezone_alpha2(const char *zone)
+{
+	char *alpha2;
+	char *alpha2_old;
+
+	/* First try the official map */
+	alpha2 = get_timezone_alpha2(zone, USR_SHARE_ZONEINFO_MAP,
+							TZ_MAP_ITEM_TIMEZONE);
+	if (alpha2)
+		return alpha2;
+
+	DBG("%s not found in %s", zone, USR_SHARE_ZONEINFO_MAP);
+
+	/* The zone was not found in official map, try with deprecated */
+	alpha2_old = get_timezone_alpha2(zone, USR_SHARE_ZONEINFO_MAP_OLD,
+							TZ_MAP_ITEM_TIMEZONE);
+	if (!alpha2_old) {
+		DBG("%s not found in %s", zone, USR_SHARE_ZONEINFO_MAP_OLD);
+		return NULL;
+	}
+
+	/*
+	 * Found from deprecated, try to get main region code from official new
+	 * map using the iso3166 search. This is because some of the codes
+	 * defined in the deprecated are not supported by the backends, e.g.,
+	 * gsupplicant and the main code should be used.
+	 */
+	alpha2 = get_timezone_alpha2(alpha2_old, USR_SHARE_ZONEINFO_MAP,
+							TZ_MAP_ITEM_ISO3166);
+
+	DBG("%s -> ISO3166 %s found in %s as %s", zone, alpha2_old,
+						USR_SHARE_ZONEINFO_MAP, alpha2);
+
+	g_free(alpha2_old);
+
+	return alpha2;
+}
+
 char *__connman_timezone_lookup(void)
 {
 	struct stat st;
@@ -319,13 +432,16 @@ char *__connman_timezone_lookup(void)
 	int fd;
 	char *zone;
 	char *alpha2;
+	const char *local_time;
+	char real_path[PATH_MAX];
 
 	zone = read_key_file(ETC_SYSCONFIG_CLOCK, "ZONE");
 
 	DBG("sysconfig zone %s", zone);
 
-	fd = open(connman_setting_get_string("Localtime"),
-							O_RDONLY | O_CLOEXEC);
+	local_time = connman_setting_get_string("Localtime");
+
+	fd = open(local_time, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		g_free(zone);
 		return NULL;
@@ -334,6 +450,15 @@ char *__connman_timezone_lookup(void)
 	if (fstat(fd, &st) < 0)
 		goto done;
 
+	if (!realpath(local_time, real_path)) {
+		connman_error("Failed to get real path of %s: %d/%s",
+					local_time, errno, strerror(errno));
+		g_free(zone);
+		close(fd);
+
+		return NULL;
+	}
+
 	if (S_ISREG(st.st_mode)) {
 		map = mmap(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 		if (!map || map == MAP_FAILED) {
@@ -349,14 +474,15 @@ char *__connman_timezone_lookup(void)
 			snprintf(pathname, PATH_MAX, "%s/%s",
 						USR_SHARE_ZONEINFO, zone);
 
-			if (compare_file(map, &st, pathname) != 0) {
+			if (compare_file(map, &st, NULL, pathname) != 0) {
 				g_free(zone);
 				zone = NULL;
 			}
 		}
 
 		if (!zone)
-			zone = find_origin(map, &st, USR_SHARE_ZONEINFO, NULL);
+			zone = find_origin(map, &st, real_path,
+						USR_SHARE_ZONEINFO, NULL);
 
 		munmap(map, st.st_size);
 	} else {
@@ -370,7 +496,7 @@ done:
 	DBG("localtime zone %s", zone);
 
 	if (connman_setting_get_bool("RegdomFollowsTimezone")) {
-		alpha2 = get_timezone_alpha2(zone);
+		alpha2 = try_get_timezone_alpha2(zone);
 		if (alpha2) {
 			DBG("change regdom to %s", alpha2);
 			connman_technology_set_regdom(alpha2);
-- 
2.30.2

