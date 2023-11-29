Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D2523B
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 02EF873180
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:53:40 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id ED138731D2
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:53:37 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/3] connection: Document 'add_gateway'.
Date: Tue, 28 Nov 2023 20:53:16 -0800
Message-ID: <20231129045321.1263302-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129045321.1263302-1-gerickson@nuovations.com>
References: <20231129045321.1263302-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'add_gateway' function.
---
 src/connection.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index f137c1b037d0..c39b861708fb 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -645,6 +645,59 @@ static int disable_gateway(struct gateway_data *data,
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Associate, or add, a new gateway, or default router, with a
+ *    network service.
+ *
+ *  This attempts to associate, or add, a new gateway, or default
+ *  router, with a network service. On success, a strong (that is,
+ *  uses #connman_service_{ref,unref}) reference to @a service is
+ *  retained in the service-to-gateway data hash.
+ *
+ *  @note
+ *    The caller is responsible for deallocating the memory assigned
+ *    to @a *data on success.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           object with which to associate @a
+ *                           gateway. On success, a strong (that is,
+ *                           uses #connman_service_{ref,unref})
+ *                           reference to this service is retained
+ *                           in the service-to-gateway data hash.
+ *  @param[in]      index    The network interface index for the
+ *                           network interface backing @a service.
+ *  @param[in]      gateway  A pointer to an immutable null-
+ *                           terminated C string containing the
+ *                           text-formatted address of the gateway, or
+ *                           default router, with which to associated
+ *                           with @a service.
+ *  @param[in]      type     The IP configuration type for the gateway,
+ *                           or default router.
+ *  @param[in,out]  data     A pointer to mutable storage for a mutable
+ *                           pointer to a #gateway_data structure. On
+ *                           success, this is assigned a newly-
+ *                           allocated and added structure that
+ *                           associates the @a gateway with @a service
+ *                           and @a type. The caller is responsible
+ *                           for deallocating the memory assigned to
+ *                           @a *data on success.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If service is null, if the network interface @a
+ *                    index is invalid, if @a gateway is null or zero
+ *                    in length, if type is not
+ *                    #CONNMAN_IPCONFIG_TYPE_IPV4 or
+ *                    #CONNMAN_IPCONFIG_TYPE_IPV6, or if @a data is
+ *                    null.
+ *  @retval  -ENOMEM  If memory could not be allocated for the
+ *                    #gateway_data structure and its associated
+ *                    #gateway_config.
+ *
+ *  @sa __connman_connection_gateway_add
+ *  @sa disable_gateway
+ *
+ */
 static int add_gateway(struct connman_service *service,
 					int index, const char *gateway,
 					enum connman_ipconfig_type type,
-- 
2.42.0

