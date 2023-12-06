Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2F182C4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1980C73202
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:32 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D104173229
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:31 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 84/90] connection: Fix documentation typos.
Date: Wed,  6 Dec 2023 15:50:50 -0800
Message-ID: <20231206235056.322578-88-gerickson@nuovations.com>
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

This corrects prior documentation '@param' typos for
'check_default_gateway' and 'remove_gateway'.
---
 src/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index db108ed03a19..0dadc99e2337 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -3038,7 +3038,7 @@ static void check_default_gateway(struct gateway_data *activated)
  *
  *  @param[in]  index    The network interface index associated with
  *                       the newly-added gateway, or default router.
- *  @param[in]  gateway  An pointer to an immutable null-terminated
+ *  @param[in]  gateway  A pointer to an immutable null-terminated
  *                       C string containing the text-
  *                       formatted address of the gateway, or default
  *                       router, that was added.
@@ -3165,7 +3165,7 @@ static void remove_gateway(gpointer user_data)
  *
  *  @param[in]  index    The network interface index associated with
  *                       the newly-removed gateway, or default router.
- *  @param[in]  gateway  An pointer to an immutable null-terminated
+ *  @param[in]  gateway  A pointer to an immutable null-terminated
  *                       C string containing the text-
  *                       formatted address of the gateway, or default
  *                       router, that was removed.
-- 
2.42.0

