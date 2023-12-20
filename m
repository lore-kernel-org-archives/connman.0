Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2EF1D698
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3217773128
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:16 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E966373147
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/5] gateway: Handle -ESRCH in 'unset_default_gateway_route_common'.
Date: Tue, 19 Dec 2023 21:56:10 -0800
Message-ID: <20231220055613.2287074-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220055613.2287074-1-gerickson@nuovations.com>
References: <20231220055613.2287074-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This maps the error '-ESRCH' in 'unset_default_gateway_route_common'
to 0 ("Success").

Generally, we mandate that gateway routes follow the documented
lifecycle and finite state machine, using events and down- and upcalls
to drive the lifecycle.

There is one exception, however. When the Linux kernel
recognizes that the next hop (that is, the "via" or RTA_GATEWAY
portion of the route) for a route becomes unreachable, it is
automatically purged from the routing table with no
RTM_DELROUTE RTNL notification. Consequently, routes so purged
will return -ESRCH when we attempt to delete them here in the
mistaken belief they are still there.

By mapping -ESRCH to 0 ("Success") we ensure that gateway
configuration for such routes is not indefinitely stuck in the
"active" or "added" states but rather is correctly advanced to the
"removed" state.
---
 src/gateway.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/src/gateway.c b/src/gateway.c
index 29115250d243..db8636eb20ef 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -221,6 +221,11 @@
  *        interface basis and is computed by
  *        'compute_low_priority_metric'.
  *
+ *    There is one exception to the above. When the Linux kernel
+ *    recognizes that the next hop for a route becomes unreachable, it
+ *    is automatically purged from the routing table with no
+ *    RTM_DELROUTE RTNL notification.
+ *
  *    Historically, this file started life as "connection.c". However,
  *    it was renamed to "gateway.c" since its primary focus is gateway
  *    routes and gateway route management.
@@ -1864,8 +1869,6 @@ done:
  *  @retval  -EPERM         If the current process does not have the
  *                          credentials or capabilities to unset, or
  *                          clear, routes.
- *  @retval  -ESRCH         A request was made to unset, or clear a
- *                          non-existing routing entry.
  *
  *  @sa gateway_config_state_set
  *  @sa is_gateway_config_state
@@ -1892,8 +1895,27 @@ static int unset_default_gateway_route_common(struct gateway_data *data,
 	if (is_gateway_config_state_inactive(config))
 		return -EALREADY;
 
+	/*
+	 * Generally, we mandate that gateway routes follow the documented
+	 * lifecycle and state machine, using events and down- and upcalls
+	 * to drive the lifecycle.
+	 *
+	 * There is one exception, however. When the Linux kernel
+	 * recognizes that the next hop (that is, the "via" or RTA_GATEWAY
+	 * part of the route) for a route becomes unreachable, it is
+	 * automatically purged from the routing table with no
+	 * RTM_DELROUTE RTNL notification. Consequently, routes so purged
+	 * will return -ESRCH when we attempt to delete them here in the
+	 * mistaken belief they are still there.
+	 *
+	 * Map -ESRCH to success such that gateway configuration for such
+	 * routes is not indefinitely stuck in the "active" or "added"
+	 * states.
+	 */
 	err = cb(data, config);
-	if (err < 0)
+	if (err == -ESRCH)
+		err = 0;
+	else if (err < 0)
 		goto done;
 
 	gateway_config_state_set(config,
-- 
2.42.0

