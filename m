Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B0FC07
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 54AF473146
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:17 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 15E0473171
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/5] gateway: Expand the @param documentation for 'yield_default_gateway{,_for_type}'.
Date: Tue, 19 Dec 2023 21:56:13 -0800
Message-ID: <20231220055613.2287074-6-gerickson@nuovations.com>
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

This expands on the @param documentation for the
'yield_default_gateway{,_for_type}' functions by being more clear
about the source of the parameters.
---
 src/gateway.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/gateway.c b/src/gateway.c
index 42a8da72642c..16c87f83b4d6 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -3102,9 +3102,11 @@ static int promote_default_gateway(struct gateway_data *data,
  *  existing gateway from the services-to-gateway data hash.
  *
  *  @param[in,out]  activated  A pointer to a mutable newly-activated
- *                             gateway.
+ *                             gateway from a Routing Netlink (rtnl)
+ *                             notification.
  *  @param[in,out]  existing   A pointer to a mutable existing
- *                             gateway.
+ *                             gateway from the services-to-gateway
+ *                             hash.
  *  @param[in]      type       The IP configuration type for which
  *                             gateway, or default router, is to be
  *                             yielded.
@@ -3200,9 +3202,11 @@ done:
  *  existing gateway from the services-to-gateway data hash.
  *
  *  @param[in,out]  activated  A pointer to a mutable newly-activated
- *                             gateway.
+ *                             gateway from a Routing Netlink (rtnl)
+ *                             notification.
  *  @param[in,out]  existing   A pointer to a mutable existing
- *                             gateway.
+ *                             gateway from the services-to-gateway
+ *                             hash.
  *
  *  @returns
  *    True if @a activated yielded the default gateway; otherwise,
-- 
2.42.0

