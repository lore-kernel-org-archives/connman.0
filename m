Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7EE249EA
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C4FB87318D
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:25:15 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86] (unknown [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8DE557319E
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:25:15 -0400 (EDT)
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
Subject: [PATCH] Const-qualify 'gchar *' arguments in ipconfig 
 getters/setters.
Message-Id: <F9F0D72A-3FF6-4045-B847-EA891BC4E0A8@nuovations.com>
Date: Fri, 20 Oct 2023 13:25:14 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the 'gchar *' arguments in ipconfig getter/setter
functions to make it clear to the compiler, static analyzers,
and human readers that there are no mutation side effects with
such arguments.
---
 src/ipconfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 34b1724a..bba25ede 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -344,7 +344,7 @@ static int write_ipv6_conf_value(const char *ifname, =
const char *suffix,
 	return write_conf_value(PROC_IPV6_CONF_PREFIX, ifname, suffix, =
value);
 }
=20
-static bool get_ipv6_state(gchar *ifname)
+static bool get_ipv6_state(const gchar *ifname)
 {
 	int disabled;
 	bool enabled =3D false;
@@ -355,7 +355,7 @@ static bool get_ipv6_state(gchar *ifname)
 	return enabled;
 }
=20
-static int set_ipv6_state(gchar *ifname, bool enable)
+static int set_ipv6_state(const gchar *ifname, bool enable)
 {
 	int disabled =3D enable ? 0 : 1;
=20
@@ -364,7 +364,7 @@ static int set_ipv6_state(gchar *ifname, bool =
enable)
 	return write_ipv6_conf_value(ifname, "disable_ipv6", disabled);
 }
=20
-static int get_ipv6_privacy(gchar *ifname)
+static int get_ipv6_privacy(const gchar *ifname)
 {
 	int value;
=20
@@ -380,7 +380,7 @@ static int get_ipv6_privacy(gchar *ifname)
 /* Enable the IPv6 privacy extension for stateless address =
autoconfiguration.
  * The privacy extension is described in RFC 3041 and RFC 4941
  */
-static int set_ipv6_privacy(gchar *ifname, int value)
+static int set_ipv6_privacy(const gchar *ifname, int value)
 {
 	if (!ifname)
 		return -EINVAL;
--=20
2.42.0


