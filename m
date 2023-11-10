Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161477F1
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1C92C730FC
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 20:21:05 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D9AA2731CE
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 20:21:04 -0500 (EST)
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
Subject: [PATCH 1/2] service: Factor out rescheduling an online check.
Date: Thu, 9 Nov 2023 17:21:03 -0800
References: <066A1AD2-8F82-49B6-BF0A-376CBE8243B4@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <066A1AD2-8F82-49B6-BF0A-376CBE8243B4@nuovations.com>
Message-Id: <DF385B18-12DD-4357-B69F-DA9D89878D65@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This factors out rescheduling an online check from =
'complete_online_check'
into 'reschedule_online_check' to make each discrete and individually
and easily auditable.
---
 src/service.c | 73 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/src/service.c b/src/service.c
index 6cd32b47..9e942e12 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1775,6 +1775,49 @@ static gboolean redo_wispr_ipv6(gpointer =
user_data)
 	return FALSE;
 }
=20
+static void reschedule_online_check(struct connman_service *service,
+					enum connman_ipconfig_type type,
+					unsigned int *interval,
+					guint *timeout)
+{
+	GSourceFunc redo_func;
+	guint seconds;
+
+	if (!service || !interval || !timeout)
+		return;
+
+	DBG("service %p (%s) type %d (%s) interval %u timeout %u",
+		service,
+		connman_service_get_identifier(service),
+		type,
+		__connman_ipconfig_type2string(type),
+		*interval, *timeout);
+
+	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4)
+		redo_func =3D redo_wispr_ipv4;
+	else
+		redo_func =3D redo_wispr_ipv6;
+
+	DBG("updating online checkout timeout period");
+
+	seconds =3D online_check_timeout_compute_func(*interval);
+
+	DBG("service %p (%s) type %d (%s) interval %u style \"%s\" =
seconds %u",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		*interval, online_check_timeout_interval_style, =
seconds);
+
+	*timeout =3D g_timeout_add_seconds(seconds,
+				redo_func, =
connman_service_ref(service));
+
+	/* Increment the interval for the next time, limiting to a =
maximum
+	 * interval of @a online_check_max_interval.
+	 */
+	if (*interval < online_check_max_interval)
+		(*interval)++;
+}
+
 /**
  *  @brief
  *    This completes an "online" HTTP-based Internet reachability
@@ -1821,11 +1864,8 @@ static void complete_online_check(struct =
connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success)
 {
-	GSourceFunc redo_func;
 	unsigned int *interval;
 	guint *timeout;
-	guint seconds;
-	guint current_timeout;
=20
 	DBG("service %p (%s) type %d (%s) success %d\n",
 		service,
@@ -1836,11 +1876,9 @@ static void complete_online_check(struct =
connman_service *service,
 	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4) {
 		interval =3D &service->online_check_interval_ipv4;
 		timeout =3D &service->online_timeout_ipv4;
-		redo_func =3D redo_wispr_ipv4;
 	} else {
 		interval =3D &service->online_check_interval_ipv6;
 		timeout =3D &service->online_timeout_ipv6;
-		redo_func =3D redo_wispr_ipv6;
 	}
=20
 	if (success) {
@@ -1851,7 +1889,7 @@ static void complete_online_check(struct =
connman_service *service,
 		if (!enable_online_to_ready_transition)
 			return;
 	} else if (!enable_online_to_ready_transition)
-		goto redo_func;
+		goto reschedule;
=20
 	if (success) {
 		*interval =3D online_check_max_interval;
@@ -1863,27 +1901,8 @@ static void complete_online_check(struct =
connman_service *service,
 		}
 	}
=20
-redo_func:
-	DBG("updating online checkout timeout period");
-
-	seconds =3D online_check_timeout_compute_func(*interval);
-
-	DBG("service %p (%s) type %d (%s) interval %d style \"%s\" =
seconds %u",
-		service,
-		connman_service_get_identifier(service),
-		type, __connman_ipconfig_type2string(type),
-		*interval, online_check_timeout_interval_style, =
seconds);
-
-	current_timeout =3D g_timeout_add_seconds(seconds,
-				redo_func, =
connman_service_ref(service));
-
-	*timeout =3D current_timeout;
-
-	/* Increment the interval for the next time, limiting to a =
maximum
-	 * interval of @a online_check_max_interval.
-	 */
-	if (*interval < online_check_max_interval)
-		(*interval)++;
+reschedule:
+	reschedule_online_check(service, type, interval, timeout);
 }
=20
 /**
--=20
2.42.0

