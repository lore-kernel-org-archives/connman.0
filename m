Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D210A2C
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EF06D731BE
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:49 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B06F4731FD
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/4] connection: Document 'yield_default_gateway'.
Date: Tue, 28 Nov 2023 23:39:46 -0800
Message-ID: <20231129073947.1280705-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129073947.1280705-1-gerickson@nuovations.com>
References: <20231129073947.1280705-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'yield_default_gateway' function.
---
 src/connection.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index a8cc6d430467..a4b98c7c7c5f 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1002,6 +1002,31 @@ static void unset_default_gateway(struct gateway_data *data,
 						data->ipv4_config->gateway);
 }
 
+/**
+ *  @brief
+ *    Decide whether either of the specified gateways should yield the
+ *    default gateway route.
+ *
+ *  This determines whether either of the specified gateway data
+ *  should yield the default gateway route via
+ *  #unset_default_gateway. @a activated is a newly-activated gateway
+ *  from a Routing Netlink (rtnl) notification. @a existing is an
+ *  existing gateway from the services-to-gateway data hash.
+ *
+ *  @param[in,out]  activated  A pointer to a mutable newly-activated
+ *                             gateway.
+ *  @param[in,out]  existing   A pointer to a mutable existing
+ *                             gateway.
+ *
+ *  @returns
+ *    True of @a activated yielded the default gateway; otherwise,
+ *    false.
+ *
+ *  @sa check_default_gateway
+ *  @sa __connman_service_compare
+ *  @sa unset_default_gateway
+ *
+ */
 static bool yield_default_gateway(struct gateway_data *activated,
 					struct gateway_data *existing)
 {
@@ -1014,19 +1039,32 @@ static bool yield_default_gateway(struct gateway_data *activated,
 	GATEWAY_DATA_DBG("existing", existing);
 
 	/*
-	 * If the current default is not active, then we mark
-	 * this one as default. If the other one is already active
-	 * we mark this one as non default.
+	 * There is only an IPv4 default gateway yield decision to be
+	 * considered if there is an IPv4 gateway configuration for BOTH
+	 * the activated and existing gateway data.
 	 */
 	if (activated->ipv4_config && existing->ipv4_config) {
 		type = CONNMAN_IPCONFIG_TYPE_IPV4;
 
+		/*
+		 * If the existing IPv4 gateway data IS NOT active (that is,
+		 * HAS NOT made it to the RTNL notification phase of its
+		 * lifecycle), then it yields the default gateway to the
+		 * activated gateway data.
+		 */
 		if (!existing->ipv4_config->active) {
 			DBG("ipv4 existing %p yielding default", existing);
 
 			unset_default_gateway(existing, type);
 		}
 
+		/*
+		 * If the existing IPv4 gateway data IS active (that is, HAS
+		 * made it to the RTNL notification phase of its lifecycle)
+		 * and if its associated service is more "senior" in the
+		 * service sort order, then the activated gateway data yields
+		 * the default gateway to the existing gateway data.
+		 */
 		if (existing->ipv4_config->active &&
 				__connman_service_compare(existing->service,
 						activated->service) < 0) {
@@ -1038,14 +1076,33 @@ static bool yield_default_gateway(struct gateway_data *activated,
 		}
 	}
 
+	/*
+	 * There is only an IPv6 default gateway yield decision to be
+	 * considered if there is an IPv6 gateway configuration for BOTH
+	 * the activated and existing gateway data.
+	 */
 	if (activated->ipv6_config && existing->ipv6_config) {
 		type = CONNMAN_IPCONFIG_TYPE_IPV6;
+
+		/*
+		 * If the existing IPv6 gateway data IS NOT active (that is,
+		 * HAS NOT made it to the RTNL notification phase of its
+		 * lifecycle), then it yields the default gateway to the
+		 * activated gateway data.
+		 */
 		if (!existing->ipv6_config->active) {
 			DBG("ipv6 existing %p yielding default", existing);
 
 			unset_default_gateway(existing, type);
 		}
 
+		/*
+		 * If the existing IPv6 gateway data IS active (that is, HAS
+		 * made it to the RTNL notification phase of its lifecycle)
+		 * and if its associated service is more "senior" in the
+		 * service sort order, then the activated gateway data yields
+		 * the default gateway to the existing gateway data.
+		 */
 		if (existing->ipv6_config->active &&
 			__connman_service_compare(existing->service,
 					activated->service) < 0) {
-- 
2.42.0

