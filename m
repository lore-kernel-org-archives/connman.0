Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8871168BC
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D888D7322A
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 14:33:33 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A4E3073238
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 14:33:33 -0500 (EST)
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
Subject: [PATCH] service: Deduplicate online check config query and log.
Message-Id: <C6B61007-3C60-43AC-86FC-9C3412A5613A@nuovations.com>
Date: Mon, 6 Nov 2023 11:33:32 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Identical logic with an identical log statement was used in both
'start_online_check' and 'start_wispr_if_connected'. This deduplicates
that code into a single common, file-scope function,
'online_check_enabled_check', and leverages it in the two locations it
was previously duplicated in.
---
 src/service.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/src/service.c b/src/service.c
index 13e22c30..03e23618 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1599,6 +1599,38 @@ static void cancel_online_check(struct =
connman_service *service)
 	}
 }
=20
+/**
+ *  @brief
+ *    Check whether an online check is enabled for the specified
+ *    service.
+ *
+ *  This determines whether "online" HTTP-based Internet reachability
+ *  checks are enabled for the specified network service. If not, an
+ *  information-level message is logged.
+ *
+ *  @param[in]  service  A pointer to the immutable service for which
+ *                       to determine whether "online" HTTP-based
+ *                       Internet reachability checks are enabled.
+ *
+ *  @returns
+ *    True if "online" HTTP-based Internet reachability * checks are
+ *    enabled for the specified network service; otherwise, false.
+ *
+ *  @sa start_online_check
+ *  @sa start_wispr_if_connected
+ *
+ */
+static bool online_check_enabled_check(const struct connman_service =
*service)
+{
+	if (!connman_setting_get_bool("EnableOnlineCheck")) {
+		connman_info("Online check disabled. "
+			"Default service remains in READY state.");
+		return false;
+	}
+
+	return true;
+}
+
 /**
  *  @brief
  *    Start an "online" HTTP-based Internet reachability check for the
@@ -1634,11 +1666,8 @@ static void start_online_check(struct =
connman_service *service,
 		type,
 		__connman_ipconfig_type2string(type));
=20
-	if (!connman_setting_get_bool("EnableOnlineCheck")) {
-		connman_info("Online check disabled. "
-			"Default service remains in READY state.");
+	if (!online_check_enabled_check(service))
 		return;
-	}
=20
 	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV6 || =
check_proxy_setup(service)) {
 		cancel_online_check(service);
@@ -1874,11 +1903,8 @@ static void start_wispr_if_connected(struct =
connman_service *service)
 		service,
 		connman_service_get_identifier(service));
=20
-	if (!connman_setting_get_bool("EnableOnlineCheck")) {
-		connman_info("Online check disabled. "
-			"Default service remains in READY state.");
+	if (!online_check_enabled_check(service))
 		return;
-	}
=20
 	if (__connman_service_is_connected_state(service,
 			CONNMAN_IPCONFIG_TYPE_IPV4))
--=20
2.42.0


