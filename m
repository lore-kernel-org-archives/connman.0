Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE622FE0D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 19B4573206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:22 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CDCF373226
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 58/90] connection: Document 'gateway_config_state' finite state machine.
Date: Wed,  6 Dec 2023 15:50:24 -0800
Message-ID: <20231206235056.322578-62-gerickson@nuovations.com>
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

This documents the finite state machine (FSM) implied by
'gateway_config_state' and the implementation leveraging it.
---
 src/connection.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/connection.c b/src/connection.c
index 68c919049f20..2022a64727d6 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -88,7 +88,30 @@ enum gateway_config_flags {
  *  Netlink (rtnl) to confirm and "activate" those routes. Likewise,
  *  Connection Manager removes/clears/deletes gateway routes an then
  *  uses notifications from the kernel Routing Netlink (rtnl) to
- *  confirm and "inactivate" those routes.
+ *  confirm and "inactivate" those routes. The following is the state
+ *  machine for that lifecycle:
+ *
+ *                              .----------.    SIOCADDRT /
+ *                              |          |    RTM_NEWROUTE
+ *           .------------------| Inactive |--------------------.
+ *           |                  |          |                    |
+ *           |                  '----------'                    |
+ *           | connman_rtnl                                     |
+ *           | .delgateway                                      |
+ *           |                                                  V
+ *      .---------.         SIOCADDRT / RTM_NEWROUTE        .-------.
+ *      |         |---------------------------------------->|       |
+ *      | Removed |                                         | Added |
+ *      |         |<----------------------------------------|       |
+ *      '---------'         SIOCDELRT / RTM_DELROUTE        '-------'
+ *           ^                                                  |
+ *           | SIOCDELRT /                                      |
+ *           | RTM_DELROUTE                                     |
+ *           |                   .--------.     connman_rtnl    |
+ *           |                   |        |     .newgateway     |
+ *           '-------------------| Active |<--------------------'
+ *                               |        |
+ *                               '--------'
  *
  */
 enum gateway_config_state {
-- 
2.42.0

