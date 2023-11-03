Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3C1F601
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C7EEC73393
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 19:24:20 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 96CFB733A2
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 19:24:20 -0400 (EDT)
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
Subject: [PATCH 1/3] service: Rename 'downgrade_state'.
Date: Fri, 3 Nov 2023 16:24:19 -0700
References: <7581F8B3-D243-4268-B344-FB28A7A15E72@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7581F8B3-D243-4268-B344-FB28A7A15E72@nuovations.com>
Message-Id: <8CEB5E35-B876-408E-8975-CB95BB276BFD@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames 'downgrade_state' to 'service_downgrade_online_state'.
This function does one thing and one thing only: downgrades the IPv4
and IPv6 configuration state from "online" to "ready" if and only if
those states are "online". The revised name more clearly indicates
that role and the action of the function and establishes a baseline
for a consistent nomenclature of related functions.
---
 src/service.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/service.c b/src/service.c
index ddcabca6..badbdb3f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5006,7 +5006,7 @@ static bool check_suitable_state(enum =
connman_service_state a,
 	return a =3D=3D b;
 }
=20
-static void downgrade_state(struct connman_service *service)
+static void service_downgrade_online_state(struct connman_service =
*service)
 {
 	if (!service)
 		return;
@@ -5037,7 +5037,7 @@ static void =
apply_relevant_default_downgrade(struct connman_service *service)
 		!is_online(def_service->state))
 		return;
=20
-	downgrade_state(def_service);
+	service_downgrade_online_state(def_service);
 }
=20
 /**
@@ -5093,7 +5093,7 @@ static void switch_service_order(struct =
connman_service *demoted_service,
 	service_list =3D g_list_delete_link(service_list, src);
 	service_list =3D g_list_insert_before(service_list, dst, =
service);
=20
-	downgrade_state(promoted_service);
+	service_downgrade_online_state(promoted_service);
 }
=20
 static struct _services_notify {
@@ -6350,7 +6350,7 @@ static void downgrade_connected_services(void)
 		if (is_online(up_service->state))
 			return;
=20
-		downgrade_state(up_service);
+		service_downgrade_online_state(up_service);
 	}
 }
=20
@@ -6970,7 +6970,7 @@ static void complete_online_check(struct =
connman_service *service,
 		*interval =3D online_check_max_interval;
 	} else {
 		current_state =3D service->state;
-		downgrade_state(service);
+		service_downgrade_online_state(service);
 		if (current_state !=3D service->state)
 			*interval =3D online_check_initial_interval;
 		if (service !=3D connman_service_get_default()) {
--=20
2.42.0

