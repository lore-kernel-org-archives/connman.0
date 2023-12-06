Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DE328B7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 657F073200
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:24 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 282C973225
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 64/90] connection: Update 'find_any_active_gateway_data' documentation.
Date: Wed,  6 Dec 2023 15:50:30 -0800
Message-ID: <20231206235056.322578-68-gerickson@nuovations.com>
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

This updates documentation to the 'find_any_active_gateway_data'
function now that the module supports both high- and low-priority
default gateways and their routes.
---
 src/connection.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 053164c36297..7bfbefb2cfda 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -971,13 +971,13 @@ static struct gateway_data *find_any_active_gateway_data(void)
  *    default service.
  *
  *  This attempts to find the gateway, or default router, data
- *  associated with default network service (that is, has the default
- *  route).
+ *  associated with default network service (that is, has the
+ *  high-priority default route).
  *
  *  @returns
  *    A pointer to the gateway, or default router, data associated
- *    with the default network service (that is, has the default
- *    route) on success; otherwise, null.
+ *    with the default network service (that is, has the high-priority
+ *    default route) on success; otherwise, null.
  *
  *  @sa find_any_active_gateway_data
  *  @sa find_gateway_data
-- 
2.42.0

