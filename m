Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C52110F
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 22B3373213
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 16:18:36 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E3D3973298
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 16:18:35 -0400 (EDT)
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
Subject: [PATCH 2/2] Add documentation to 'service_update_preferred_order'.
Date: Fri, 3 Nov 2023 13:18:35 -0700
References: <570CAA7B-EB14-4E4D-AD37-4E776140A67E@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <570CAA7B-EB14-4E4D-AD37-4E776140A67E@nuovations.com>
Message-Id: <F574DADA-FDDB-47B0-B274-0379A9230563@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'service_update_preferred' function.
---
 src/service.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/service.c b/src/service.c
index 072d5a7d..ddb95143 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6223,6 +6223,36 @@ static void downgrade_connected_services(void)
 	}
 }
=20
+/**
+ *  @brief
+ *    Potentially change the network service list order of the default
+ *    network service and the specified network service.
+ *
+ *  This attempts to switch the order of the specified services in the
+ *  network service list if and only if a) the services are non-null,
+ *  b) do not have pointer equivalence, and c) if @a new_service
+ *  should sort before @a default_service according to the @a
+ *  PreferredTechnologies list.
+ *
+ *  @param[in,out]  default_service  A pointer to the mutable, default
+ *                                   network service to potentially
+ *                                   demote in the network service
+ *                                   list to @b after @a new_service.
+ *  @param[in,out]  new_service      A pointer to the mutable service
+ *                                   to potentially promote in the
+ *                                   network service list to @b before
+ *                                   @a default_service.
+ *  @param[in]      new_state        The pending network service state
+ *                                   of @a new_service that is
+ *                                   precipitating the order update.
+ *
+ *  @retval  0          If the preferred order was successfully
+ *                      changed which includes @a default_service
+ *                      being null or @a default_service and @a
+ *                      new_service having pointer equivalence.
+ *  @retval  -EALREADY  If the preferred order was unchanged.
+ *
+ */
 static int service_update_preferred_order(struct connman_service =
*default_service,
 		struct connman_service *new_service,
 		enum connman_service_state new_state)
--=20
2.42.0

