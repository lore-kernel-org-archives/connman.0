Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9D1DDCE
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 81262731CC
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 19:43:54 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 42B7D731F6
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 19:43:54 -0400 (EDT)
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
Subject: [PATCH] Add documentation to the service default functions.
Message-Id: <FCE44C9C-69FC-4328-B02E-43BF5259C934@nuovations.com>
Date: Thu, 2 Nov 2023 16:43:53 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the service default getter and introspection
functions.
---
 src/service.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/service.c b/src/service.c
index 950d22cb..85f541ee 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1657,6 +1657,18 @@ static void reset_stats(struct connman_service =
*service)
 	g_timer_reset(service->stats_roaming.timer);
 }
=20
+/**
+ *  @brief
+ *    Return the default service, if any.
+ *
+ *  This attempts to return a pointer to the default service (that is,
+ *  the service with the default route), if any.
+ *
+ *  @returns
+ *    A pointer to the mutable default service, if one exists;
+ *    otherwise, null.
+ *
+ */
 struct connman_service *connman_service_get_default(void)
 {
 	struct connman_service *service;
@@ -1664,6 +1676,9 @@ struct connman_service =
*connman_service_get_default(void)
 	if (!service_list)
 		return NULL;
=20
+	// Sorting is such that the default service is ALWAYS at the
+	// head of the service list, if one exists.
+
 	service =3D service_list->data;
=20
 	if (!is_connected(service->state))
@@ -1672,6 +1687,26 @@ struct connman_service =
*connman_service_get_default(void)
 	return service;
 }
=20
+/**
+ *  @brief
+ *    Determine whether the specified network interface index belongs
+ *    to the default service.
+ *
+ *  This determines whether or not the specified network interface
+ *  index belongs to the default service (that is, the service with
+ *  the default route).
+ *
+ *  @param[in]  index  The network interface to determine whether it
+ *                     belongs to the default service.
+ *
+ *  @returns
+ *    True if the specified index belongs to the default service;
+ *    otherwise, false.
+ *
+ *  @sa connman_service_get_default
+ *  @sa __connman_service_get_index
+ *
+ */
 bool __connman_service_index_is_default(int index)
 {
 	struct connman_service *service;
--=20
2.42.0
