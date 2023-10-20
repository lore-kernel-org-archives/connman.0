Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689D249F7
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 21AC07311D
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:35:38 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86] (unknown [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CA1C873147
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:35:37 -0400 (EDT)
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
Subject: [PATCH] Added function documentation for ipconfig getters.
Message-Id: <44B8A3FE-B61B-4295-8028-DF49DE56FDED@nuovations.com>
Date: Fri, 20 Oct 2023 13:35:36 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds function documentation for:

  * read_conf_value
  * read_ipv4_conf_value
  * read_ipv6_conf_value
  * get_ipv6_privacy
  * get_rp_filter

---
 src/ipconfig.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 34b1724a..5250f333 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -261,6 +261,45 @@ static const char *scope2str(unsigned char scope)
 #define PROC_IPV4_CONF_PREFIX "/proc/sys/net/ipv4/conf"
 #define PROC_IPV6_CONF_PREFIX "/proc/sys/net/ipv6/conf"
=20
+/**
+ *  @brief
+ *    Get the file system configuration value associated with the
+ *    composed prefix, optional network interface name, and suffix
+ *    path components.
+ *
+ *  This attempts to read and return the file system (ostensibly from
+ *  the Linux proc file system) configuration value associated with
+ *  the composed combination of the specified prefix, optional network
+ *  interface name, and suffix path components. If the network
+ *  interface name is null, then "all" is used. The composed path name
+ *  will look like "prefix/<ifname|all>/suffix".
+ *
+ *  @param[in]   prefix  A pointer to the immutable null-terminated C
+ *                       string containing the prefix component(s) of
+ *                       the file system path for which to get the
+ *                       configuration value.
+ *  @param[in]   ifname  An optional pointer to the immutable null-
+ *                       terminated C string containing the network
+ *                       interface name to use as the path component
+ *                       between @a prefix and @a suffix. If null,
+ *                       "all" will be used.
+ *  @param[in]   suffix  A pointer to the immutable null-terminated C
+ *                       string containing the suffix component(s) of
+ *                       the file system path for which to get the
+ *                       configuration value.
+ *  @param[out]  value   A pointer to storage to be populated with the
+ *                       read configuration value, if successful.
+ *
+ *  @retval  1         If successful.
+ *  @retval  0         If no configuration value was successfully read.
+ *  @retval  -ENOMEM   If memory could not be allocated for the
+ *                     configuration path name to be read.
+ *  @retval  -ENOENT   The composed configuration path name does not
+ *                     exist.
+ *  @retval  -EACCESS  The current process does not have permission
+ *                     to access the composed configuration path name.
+ *
+ */
 static int read_conf_value(const char *prefix, const char *ifname,
 					const char *suffix, int *value)
 {
@@ -268,11 +307,14 @@ static int read_conf_value(const char *prefix, =
const char *ifname,
 	FILE *f;
 	int err;
=20
+    // Build the file system path name from the specified,
+    // null-terminated variable argument component list.
+
 	path =3D g_build_filename(prefix, ifname ? ifname : "all", =
suffix, NULL);
 	if (!path)
 		return -ENOMEM;
=20
-	errno =3D 0;
+	errno =3D 0; /* Avoid stale errno values with fopen */
 	f =3D fopen(path, "r");
 	if (!f) {
 		err =3D -errno;
@@ -294,12 +336,84 @@ static int read_conf_value(const char *prefix, =
const char *ifname,
 	return err;
 }
=20
+/**
+ *  @brief
+ *    Get the Linux proc file system configuration value associated
+ *    with the composed /proc/sys/net/ipv4/conf prefix, optional
+ *    network interface name, and suffix path components.
+ *
+ *  This attempts to read and return the file system (ostensibly from
+ *  the Linux proc file system) configuration value associated with
+ *  the composed combination of the /proc/sys/net/ipv4/conf prefix,
+ *  optional network interface name, and suffix path components. If
+ *  the network interface name is null, then "all" is used. The
+ *  composed path name will look like "/proc/sys/net/ipv4/conf/
+ *  <ifname|all>/suffix".
+ *
+ *  @param[in]   ifname  An optional pointer to the immutable null-
+ *                       terminated C string containing the network
+ *                       interface name to use as the path component
+ *                       between @a prefix and @a suffix. If null,
+ *                       "all" will be used.
+ *  @param[in]   suffix  A pointer to the immutable null-terminated C
+ *                       string containing the suffix component(s) of
+ *                       the file system path for which to get the
+ *                       configuration value.
+ *  @param[out]  value   A pointer to storage to be populated with the
+ *                       read configuration value, if successful.
+ *
+ *  @retval  1         If successful.
+ *  @retval  0         If no configuration value was successfully read.
+ *  @retval  -ENOMEM   If memory could not be allocated for the
+ *                     configuration path name to be read.
+ *  @retval  -ENOENT   The composed configuration path name does not
+ *                     exist.
+ *  @retval  -EACCESS  The current process does not have permission
+ *                     to access the composed configuration path name.
+ *
+ */
 static int read_ipv4_conf_value(const char *ifname, const char *suffix,
 								int =
*value)
 {
 	return read_conf_value(PROC_IPV4_CONF_PREFIX, ifname, suffix, =
value);
 }
=20
+/**
+ *  @brief
+ *    Get the Linux proc file system configuration value associated
+ *    with the composed /proc/sys/net/ipv6/conf prefix, optional
+ *    network interface name, and suffix path components.
+ *
+ *  This attempts to read and return the file system (ostensibly from
+ *  the Linux proc file system) configuration value associated with
+ *  the composed combination of the /proc/sys/net/ipv6/conf prefix,
+ *  optional network interface name, and suffix path components. If
+ *  the network interface name is null, then "all" is used. The
+ *  composed path name will look like "/proc/sys/net/ipv6/conf/
+ *  <ifname|all>/suffix".
+ *
+ *  @param[in]   ifname  An optional pointer to the immutable null-
+ *                       terminated C string containing the network
+ *                       interface name to use as the path component
+ *                       between @a prefix and @a suffix. If null,
+ *                       "all" will be used.
+ *  @param[in]   suffix  A pointer to the immutable null-terminated C
+ *                       string containing the suffix component(s) of
+ *                       the file system path for which to get the
+ *                       configuration value.
+ *  @param[out]  value   A pointer to storage to be populated with the
+ *                       read configuration value, if successful.
+ *
+ *  @retval  1         If successful.
+ *  @retval  0         If no configuration value was successfully read.
+ *  @retval  -ENOMEM   If memory could not be allocated for the
+ *                     configuration path name to be read.
+ *  @retval  -ENOENT   The composed configuration path name does not
+ *                     exist.
+ *  @retval  -EACCESS  The current process does not have permission
+ *                     to access the composed configuration path name.
+ *
+ */
 static int read_ipv6_conf_value(const char *ifname, const char *suffix,
 								int =
*value)
 {
@@ -364,6 +478,24 @@ static int set_ipv6_state(gchar *ifname, bool =
enable)
 	return write_ipv6_conf_value(ifname, "disable_ipv6", disabled);
 }
=20
+/**
+ *  @brief
+ *    Return the IPv6 address privacy setting from the Linux kernel
+ *    proc file system for the specified network interface name.
+ *
+ *  This attempts to read and return the IPv6 address privacy setting
+ *  (that is, "use_tempaddr") from the Linux kernel proc file system
+ *  for the specified network interface name.
+ *
+ *  @param[in]  ifname  A pointer to the immutable null-terminated C
+ *                      string of the network interface name for which
+ *                      to return the IPv6 privacy setting.
+ *
+ *  @retval  <=3D 0  IPv6 address privacy is disabled.
+ *  @retval     1  IPv6 address privacy is enabled.
+ *  @retval     2  IPv6 address privacy is preferred.
+ *
+ */
 static int get_ipv6_privacy(gchar *ifname)
 {
 	int value;
@@ -391,6 +523,22 @@ static int set_ipv6_privacy(gchar *ifname, int =
value)
 	return write_ipv6_conf_value(ifname, "use_tempaddr", value);
 }
=20
+/**
+ *  @brief
+ *    Return the IPv4 reverse path routing validation setting from the
+ *    Linux kernel proc file system.
+ *
+ *  This attempts to read and return the IPv6 address privacy setting
+ *  (that is, "rp_filter") from the Linux kernel proc file system.
+ *
+ *  @retval  -EINVAL  The setting could not be read.
+ *  @retval  0        No reverse path routing validation is in effect.
+ *  @retval  1        Strict mode reverse path routing validation is
+ *                    in effect.
+ *  @retval  2        Loose mode reverse path routing validation is
+ *                    in effect.
+ *
+ */
 static int get_rp_filter(void)
 {
 	int value;
--=20
2.42.0


