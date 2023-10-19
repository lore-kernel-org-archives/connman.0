Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F683DFE5
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5844E73281
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:40:49 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 23BB673380
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:40:49 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] Add documentation for 'start_wispr_if_connected'.
Message-Id: <1D6BAD07-EBE1-4D5C-8C26-F89AB34FEE03@nuovations.com>
Date: Thu, 19 Oct 2023 14:40:48 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds function documentation to 'start_wispr_if_connected'.

---
 src/service.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/service.c b/src/service.c
index 31fe8917..9e64a57b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1602,6 +1602,20 @@ bool __connman_service_index_is_default(int index)
 	return __connman_service_get_index(service) == index;
 }
 
+/**
+ *  @brief
+ *    Start HTTP-based Internet reachability probes if the specified
+ *    service is connected.
+ *
+ *  This attempts to start IPv4 and/or IPv6 HTTP-based Internet
+ *  reachability probes if the IPv4 state or IPv6 state is connected
+ *  (that is, "ready" or "online").
+ *
+ *  @param[in]  service  A pointer to a mutable service on which to start
+ *                       reachability probes if the IPv4 or IPv6 state
+ *                       is "connected" (that is, "ready" or "online").
+ *
+ */
 static void start_wispr_if_connected(struct connman_service *service)
 {
 	if (!connman_setting_get_bool("EnableOnlineCheck")) {
-- 
2.32.0


