Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5C7EC
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6E99F73202
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:50:37 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 383AB73208
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:50:37 -0400 (EDT)
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
Subject: [PATCH 2/2] Add documentation to 'switch_service_order'.
Date: Thu, 2 Nov 2023 17:50:37 -0700
References: <37EFB709-B379-4AE2-85F6-0D74564EF4C8@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <37EFB709-B379-4AE2-85F6-0D74564EF4C8@nuovations.com>
Message-Id: <A777AE03-0F10-434A-9A6F-A552468C155D@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'switch_service_order' function.
---
 src/service.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/service.c b/src/service.c
index 099c24e5..44aab3c2 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4909,6 +4909,33 @@ static void =
apply_relevant_default_downgrade(struct connman_service *service)
 	downgrade_state(def_service);
 }
=20
+/**
+ *  @brief
+ *    Switch the order of the two specified services in the network
+ *    service list.
+ *
+ *  This attempts to switch the order of the two specified services in
+ *  the ntework service list. This has the side-effect of potentially
+ *  downgrading the state of @a demoted_service from "online" to
+ *  "ready" if it is "online" and is the default service and
+ *  downgrading the state of @a promoted_service from "online" to
+ *  "ready".
+ *
+ *  @note
+ *    If the two services have pointer equivalence or are already in
+ *    the specified order, there is no state downgrade of @a
+ *    promoted_service.
+ *
+ *  @param[in,out]  demoted_service   A pointer to the mutable service
+ *                                    to demote in the network service
+ *                                    list to @b after @a
+ *                                    promoted_service.
+ *  @param[in,out]  promoted_service  A pointer to the mutable service
+ *                                    to promote in the network service
+ *                                    list to @b before @a
+ *                                    demoted_service.
+ *
+ */
 static void switch_service_order(struct connman_service =
*demoted_service,
 		struct connman_service *promoted_service)
 {
--=20
2.42.0

