Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD37F4
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6A32C73118
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 19:48:02 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 215FA73144
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 19:48:02 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/4] connection: Document search functions.
Date: Tue, 28 Nov 2023 16:47:58 -0800
Message-ID: <20231129004759.1240786-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129004759.1240786-1-gerickson@nuovations.com>
References: <20231129004759.1240786-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the following service/gateway map search
functions:

    * find_gateway_config
    * find_gateway_data
    * find_default_gateway_data
---
 src/connection.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 78fb126194c8..3749d3a59196 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -189,6 +189,35 @@ static void gateway_data_debug(const char *function,
 	}
 }
 
+/**
+ *  @brief
+ *    Find the gateway, or default router, configuration associated
+ *    with a network interface index.
+ *
+ *  This attempts to find a gateway, or default router, configuration
+ *  associated with the specified network interface index.
+ *
+ *  It is possible that there is both an IPv4 and IPv6 gateway, or
+ *  default router, configuration exist for an index. The IP address
+ *  family associated with @a gateway will uniqueify and select among
+ *  them.
+ *
+ *  @param[in]  index    The network interface index for which to find
+ *                       gateway, or default router, configuration.
+ *  @param[in]  gateway  A pointer to an immutable null-
+ *                       terminated C string containing the
+ *                       text-formatted address of the gateway, or
+ *                       default router, for which to find its
+ *                       associated configuration.
+ *
+ *  @returns
+ *    A pointer to the gateway, or default router, configuration
+ *    associated with the provided network interface index on success;
+ *    otherwise, null.
+ *
+ *  @sa find_gateway_data
+ *
+ */
 static struct gateway_config *find_gateway_config(int index,
 				const char *gateway)
 {
@@ -217,6 +246,25 @@ static struct gateway_config *find_gateway_config(int index,
 	return NULL;
 }
 
+/**
+ *  @brief
+ *    Find the gateway, or default router, data associated
+ *    with the configuration.
+ *
+ *  This attempts to find a gateway, or default router, data
+ *  associated with the specified configuration.
+ *
+ *  @param[in]  config   A pointer to an immutable gateway, or
+ *                       default router, configuration for which to
+ *                       find the associated gateway data.
+ *
+ *  @returns
+ *    A pointer to the gateway, or default router, data associated
+ *    with the provided configuration on success; otherwise, null.
+ *
+ *  @sa find_gateway_config
+ *
+ */
 static struct gateway_data *find_gateway_data(
 				const struct gateway_config *config)
 {
@@ -267,6 +315,24 @@ static struct gateway_data *find_active_gateway_data(void)
 	return NULL;
 }
 
+/**
+ *  @brief
+ *    Find the gateway, or default router, data associated with the
+ *    default service.
+ *
+ *  This attempts to find the gateway, or default router, data
+ *  associated with default network service (that is, has the default
+ *  route).
+ *
+ *  @returns
+ *    A pointer to the gateway, or default router, data associated
+ *    with the default network service (that is, has the default
+ *    route) on success; otherwise, null.
+ *
+ *  @sa find_active_gateway_data
+ *  @sa find_gateway_data
+ *
+ */
 static struct gateway_data *find_default_gateway_data(void)
 {
 	struct connman_service *service;
-- 
2.42.0

