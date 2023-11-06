Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1C2D048
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9B0C87311D
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 17:08:22 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 67EC27316C
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 17:08:22 -0500 (EST)
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
Subject: [PATCH 2/3] service: Leverage 
 'service_ipconfig_downgrade_online_state'.
Date: Mon, 6 Nov 2023 14:08:22 -0800
References: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
Message-Id: <E69085FD-5C2F-42EE-973A-273351979391@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages 'service_ipconfig_downgrade_online_state' by
reimplementing 'service_downgrade_online_state' and
'service_downgrade_online_state_if_default' against it. In addition,
the return signatures of 'service_downgrade_online_state' and
'service_downgrade_online_state_if_default' are changed from 'void' to
'bool' to allow callers to know, without additional sideband checks,
whether service state was downgraded.
---
 src/service.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/src/service.c b/src/service.c
index b76bbaeb..8b6110b6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -164,7 +164,7 @@ static void trigger_autoconnect(struct =
connman_service *service);
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success);
-static void service_downgrade_online_state(struct connman_service =
*service);
+static bool service_downgrade_online_state(struct connman_service =
*service);
=20
 struct find_data {
 	const char *path;
@@ -5317,13 +5317,21 @@ static bool =
service_ipconfig_downgrade_online_state(
  *                           downgraded to
  *                           #CONNMAN_SERVICE_STATE_READY.
  *
+ *  @returns
+ *    True if either IPv4 or IPv6 service state was downgraded;
+ *    otherwise, false.
+ *
+ *  @sa service_ipconfig_downgrade_online_state
  *  @sa service_downgrade_online_state_if_default
  *
  */
-static void service_downgrade_online_state(struct connman_service =
*service)
+static bool service_downgrade_online_state(struct connman_service =
*service)
 {
+	bool ipv4_downgraded =3D false;
+	bool ipv6_downgraded =3D false;
+
 	if (!service)
-		return;
+		return false;
=20
 	DBG("service %p (%s) state4 %d (%s) state6 %d (%s)",
 		service,
@@ -5331,15 +5339,15 @@ static void =
service_downgrade_online_state(struct connman_service *service)
 		service->state_ipv4, state2string(service->state_ipv4),
 		service->state_ipv6, state2string(service->state_ipv6));
=20
-	if (is_online(service->state_ipv4))
-		__connman_service_ipconfig_indicate_state(service,
-						=
CONNMAN_SERVICE_STATE_READY,
-						=
CONNMAN_IPCONFIG_TYPE_IPV4);
+	ipv4_downgraded =3D =
service_ipconfig_downgrade_online_state(service,
+								 =
service->state_ipv4,
+								 =
CONNMAN_IPCONFIG_TYPE_IPV4);
=20
-	if (is_online(service->state_ipv6))
-		__connman_service_ipconfig_indicate_state(service,
-						=
CONNMAN_SERVICE_STATE_READY,
-						=
CONNMAN_IPCONFIG_TYPE_IPV6);
+	ipv6_downgraded =3D =
service_ipconfig_downgrade_online_state(service,
+								 =
service->state_ipv6,
+								 =
CONNMAN_IPCONFIG_TYPE_IPV6);
+
+	return ipv4_downgraded || ipv6_downgraded;
 }
=20
 /**
@@ -5359,19 +5367,24 @@ static void =
service_downgrade_online_state(struct connman_service *service)
  *                           downgraded to
  *                           #CONNMAN_SERVICE_STATE_READY.
  *
+ *  @returns
+ *    True if either IPv4 or IPv6 service state was downgraded;
+ *    otherwise, false.
+ *
+ *  @sa service_ipconfig_downgrade_online_state
  *  @sa service_downgrade_online_state
  *
  */
-static void service_downgrade_online_state_if_default(struct =
connman_service *service)
+static bool service_downgrade_online_state_if_default(struct =
connman_service *service)
 {
 	struct connman_service *def_service;
=20
 	def_service =3D connman_service_get_default();
 	if (!def_service || def_service !=3D service ||
 		!is_online(def_service->state))
-		return;
+		return false;
=20
-	service_downgrade_online_state(def_service);
+	return service_downgrade_online_state(def_service);
 }
=20
 /**
--=20
2.42.0

