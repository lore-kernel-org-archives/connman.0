Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EB7EC
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 147F573189
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:50:16 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D571E731F4
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:50:15 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 1/2] service: Rename switch_default_service
Date: Thu, 2 Nov 2023 17:50:14 -0700
References: <37EFB709-B379-4AE2-85F6-0D74564EF4C8@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <37EFB709-B379-4AE2-85F6-0D74564EF4C8@nuovations.com>
Message-Id: <C24D2A39-56B3-4DB0-A45F-35AE79B49977@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

The function 'switch_default_service' was formerly used in two contexts:

  1. =46rom '__connman_service_move', which may be called from either =
the
     public D-Bus "MoveAfter" or "MoveBefore" method requests or from
     'connman_provider_set_split_routing' in src/provider.c.

  2. =46rom 'service_update_preferred_order' in which the first argument
     is guaranteed to the default service.

In the D-Bus "MoveAfter" or "MoveBefore" context, the
'switch_default_service' is a misnomer since neither service argument,
in particular the first, is guaranteed to be the default service.
Consequently, 'switch_default_service' is renamed to the more neutral
=E2=80=98switch_service_order' to reflect its varied usage in the above =
contexts.
---
 src/service.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/src/service.c b/src/service.c
index 5e23b8dd..099c24e5 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4909,23 +4909,23 @@ static void =
apply_relevant_default_downgrade(struct connman_service *service)
 	downgrade_state(def_service);
 }
=20
-static void switch_default_service(struct connman_service =
*default_service,
-		struct connman_service *downgrade_service)
+static void switch_service_order(struct connman_service =
*demoted_service,
+		struct connman_service *promoted_service)
 {
 	struct connman_service *service;
 	GList *src, *dst;
=20
-	DBG("default_service %p (%s) default %u downgrade_service %p =
(%s) default %u",
-		default_service,
-		connman_service_get_identifier(default_service),
-		connman_service_is_default(default_service),
-		downgrade_service,
-		connman_service_get_identifier(downgrade_service),
-		connman_service_is_default(downgrade_service));
+	DBG("demoted_service %p (%s) default %u promoted_sevice %p (%s) =
default %u",
+		demoted_service,
+		connman_service_get_identifier(demoted_service),
+		connman_service_is_default(demoted_service),
+		promoted_service,
+		connman_service_get_identifier(promoted_service),
+		connman_service_is_default(promoted_service));
=20
-	apply_relevant_default_downgrade(default_service);
-	src =3D g_list_find(service_list, downgrade_service);
-	dst =3D g_list_find(service_list, default_service);
+	apply_relevant_default_downgrade(demoted_service);
+	src =3D g_list_find(service_list, promoted_service);
+	dst =3D g_list_find(service_list, demoted_service);
=20
 	/* Nothing to do */
 	if (src =3D=3D dst || src->next =3D=3D dst)
@@ -4935,7 +4935,7 @@ static void switch_default_service(struct =
connman_service *default_service,
 	service_list =3D g_list_delete_link(service_list, src);
 	service_list =3D g_list_insert_before(service_list, dst, =
service);
=20
-	downgrade_state(downgrade_service);
+	downgrade_state(promoted_service);
 }
=20
 static struct _services_notify {
@@ -5116,9 +5116,9 @@ int __connman_service_move(struct connman_service =
*service,
 	 * is triggered via downgrading it - if relevant - to state =
ready.
 	 */
 	if (before)
-		switch_default_service(target, service);
+		switch_service_order(target, service);
 	else
-		switch_default_service(service, target);
+		switch_service_order(service, target);
=20
 	__connman_connection_update_gateway();
=20
@@ -6204,7 +6204,7 @@ static int service_update_preferred_order(struct =
connman_service *default_servic
 		return 0;
=20
 	if (service_compare_preferred(default_service, new_service) > 0) =
{
-		switch_default_service(default_service,
+		switch_service_order(default_service,
 				new_service);
 		__connman_connection_update_gateway();
 		return 0;
--=20
2.42.0

