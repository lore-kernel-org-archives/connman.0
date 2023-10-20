Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AB1E530
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2EB69731C4
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:19:26 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86] (unknown [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id EB7CC73225
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:19:25 -0400 (EDT)
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
Subject: [PATCH] Add self-documenting Linux rp_filter enum.
Message-Id: <A838BEF3-E296-4B5A-9B84-8D5D0805FB67@nuovations.com>
Date: Fri, 20 Oct 2023 13:19:24 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This improves self-documentation of the Linux reverse path filtering
(rp_filter) validation setting values by introducing a file scope
enumeration for the possible valid values
---
 src/ipconfig.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 34b1724a..18240458 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -40,6 +40,14 @@
=20
 #include "connman.h"
=20
+/* Linux reverse path filtering (rp_filter) validation setting values.
+ */
+enum {
+	__CONNMAN_LINUX_RP_FILTER_SETTING_NO_VALIDATION          =3D 0,
+	__CONNMAN_LINUX_RP_FILTER_SETTING_STRICT_MODE_VALIDATION =3D 1,
+	__CONNMAN_LINUX_RP_FILTER_SETTING_LOOSE_MODE_VALIDATION  =3D 2,
+};
+
 struct connman_ipconfig {
 	int refcount;
 	int index;
@@ -406,11 +414,11 @@ static int set_rp_filter(int value)
 	/* 0 =3D no validation, 1 =3D strict mode, 2 =3D loose mode */
 	switch (value) {
 	case -1:
-		value =3D 0;
+		value =3D =
__CONNMAN_LINUX_RP_FILTER_SETTING_NO_VALIDATION;
 		/* fall through */
-	case 0:
-	case 1:
-	case 2:
+	case __CONNMAN_LINUX_RP_FILTER_SETTING_NO_VALIDATION:
+	case __CONNMAN_LINUX_RP_FILTER_SETTING_STRICT_MODE_VALIDATION:
+	case __CONNMAN_LINUX_RP_FILTER_SETTING_LOOSE_MODE_VALIDATION:
 		break;
 	default:
 		return -EINVAL;
@@ -421,6 +429,7 @@ static int set_rp_filter(int value)
=20
 int __connman_ipconfig_set_rp_filter()
 {
+	const int default_value =3D =
__CONNMAN_LINUX_RP_FILTER_SETTING_LOOSE_MODE_VALIDATION;
 	int value;
=20
 	value =3D get_rp_filter();
@@ -428,10 +437,10 @@ int __connman_ipconfig_set_rp_filter()
 	if (value < 0)
 		return value;
=20
-	set_rp_filter(2);
+	set_rp_filter(default_value);
=20
-	connman_info("rp_filter set to 2 (loose mode routing), "
-			"old value was %d", value);
+	connman_info("rp_filter set to %d (loose mode routing), "
+			"old value was %d", default_value, value);
=20
 	return value;
 }
--=20
2.42.0
