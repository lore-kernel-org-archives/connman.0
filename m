Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B16328D2
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 40CEF730B4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:06 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 01FA77321D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 20/90] connection: Document 'yield_default_gateway_for_type'.
Date: Wed,  6 Dec 2023 15:49:43 -0800
Message-ID: <20231206235056.322578-21-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206235056.322578-1-gerickson@nuovations.com>
References: <20231206235056.322578-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

From: Grant Erickson <erick205@umn.edu>

This adds documentation to the 'yield_default_gateway_for_type'
enumeration.
---
 src/connection.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/src/connection.c b/src/connection.c
index a89fec393960..72a82dd87f76 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1405,6 +1405,34 @@ static void unset_default_gateway(struct gateway_data *data,
 		unset_ipv6_default_gateway(data, data->ipv6_config);
 }
 
+/**
+ *  @brief
+ *    Decide whether either of the specified gateways should yield the
+ *    default gateway route.
+ *
+ *  This determines whether either of the specified gateway data
+ *  should yield the IP-specific default gateway route via
+ *  #unset_default_gateway. @a activated is a newly-activated gateway
+ *  from a Routing Netlink (rtnl) notification. @a existing is an
+ *  existing gateway from the services-to-gateway data hash.
+ *
+ *  @param[in,out]  activated  A pointer to a mutable newly-activated
+ *                             gateway.
+ *  @param[in,out]  existing   A pointer to a mutable existing
+ *                             gateway.
+ *  @param[in]      type       The IP configuration type for which
+ *                             gateway, or default router, is to be
+ *                             yielded.
+ *
+ *  @returns
+ *    True if @a activated yielded the IP-specific default gateway;
+ *    otherwise, false.
+ *
+ *  @sa __connman_service_compare
+ *  @sa unset_default_gateway
+ *  @sa yield_default_gateway
+ *
+ */
 static bool yield_default_gateway_for_type(struct gateway_data *activated,
 					struct gateway_data *existing,
 					enum connman_ipconfig_type type)
@@ -1492,12 +1520,13 @@ done:
  *                             gateway.
  *
  *  @returns
- *    True of @a activated yielded the default gateway; otherwise,
+ *    True if @a activated yielded the default gateway; otherwise,
  *    false.
  *
  *  @sa check_default_gateway
  *  @sa __connman_service_compare
  *  @sa unset_default_gateway
+ *  @sa yield_default_gateway_for_type
  *
  */
 static bool yield_default_gateway(struct gateway_data *activated,
-- 
2.42.0

