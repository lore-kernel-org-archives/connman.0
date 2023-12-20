Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9D8BE7
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5BAEF7312B
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 20:24:39 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1B2C073150
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 20:24:39 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] service: Qualify call to '__connman_timeserver_sync' with default check.
Date: Tue, 19 Dec 2023 17:24:37 -0800
Message-ID: <20231220012437.2259325-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This qualifies the call to '__connman_timeserver_sync' in
'__connman_service_ipconfig_indicate_state' with a check against
'connman_service_is_default'.

In a multi-technology and -service environment, there may be a senior,
default service that is providing the network service for time-of-day
synchronization.

Without the 'connman_service_is_default' qualification, in a
multi-technology and -service environment, as junior services
transitions to the 'ready' state, each of those service usurp the
senior, default service and start trying to provide time-of-day
synchronization which is NOT what is desired.

So, in a configuration with Ethernet, Wi-Fi, and Cellular in which
they are preferred in that order and in which Ethernet is the default
and becomes 'ready' first, Ethernet will provide the network service
for time-of-day synchronization. Then, once Wi-Fi becomes 'ready', it
will usurp time-of-day synchronization from Ethernet. Similarly, when
Cellular becomes 'ready' it will usurp time-of-day synchronization
from Wi-Fi. In all of those cases, time-of-day synchronization should
have remained with Ethernet until such time as it was/is no longer the
senior, default service.
---
 src/service.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index b8224e8ff0bc..8e057e051d63 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7773,8 +7773,25 @@ int __connman_service_ipconfig_indicate_state(struct connman_service *service,
 	if (!is_connected(old_state) && is_connected(new_state)) {
 		nameserver_add_all(service, type);
 
-		__connman_timeserver_sync(service,
-					CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
+		/*
+		 * Care must be taken here in a multi-technology and -service
+		 * environment. In such an environment, there may be a senior,
+		 * default service that is providing the network service for
+		 * time-of-day synchronization.
+		 *
+		 * Without an appropriate qualifier here, a junior,
+		 * non-default service may come in and usurp the senior,
+		 * default service and start trying to provide time-of-day
+		 * synchronization which is NOT what is desired.
+		 *
+		 * However, this qualifier should NOT be moved to the next
+		 * most outer block. Otherwise, name servers will not be added
+		 * to junior, non-default services and they will be unusable
+		 * from a DNS perspective.
+		 */
+		if (connman_service_is_default(service))
+			__connman_timeserver_sync(service,
+				CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
 	}
 
 	return service_indicate_state(service);
-- 
2.42.0

