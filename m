Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71C14F6A
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C490373154
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:26:26 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7065D731D1
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:26:26 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/4] connection: Document '{un,}set_default_gateway'.
Date: Wed, 29 Nov 2023 21:26:22 -0800
Message-ID: <20231130052622.1335266-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130052622.1335266-1-gerickson@nuovations.com>
References: <20231130052622.1335266-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the '{un,}set_default_gateway'
functions.
---
 src/connection.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 716569debfa5..94b2f90f515b 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -864,6 +864,35 @@ static int add_gateway(struct connman_service *service,
 	return err;
 }
 
+/**
+ *  @brief
+ *    Set, or assign, the gateway, or default route, for the specified
+ *    IP configuration type from the provided gateway data.
+ *
+ *  This attempts to set, or assign, the gateway, or default, route
+ *  for the specified IP configuration type from the provided gateway
+ *  data. The network interface and, by extension, the network service
+ *  with which the gateway is associated is determined by the @a index
+ *  field of @a data.
+ *
+ *  On success, the gateway configuration specific to @a type will
+ *  have its @a active field set to true and the gateway data network
+ *  service @a service will be signaled as the default via
+ *  #__connman_service_indicate_default.
+ *
+ *  @param[in,out]  data  A pointer to the mutable gateway data to
+ *                        assign as the default route.
+ *  @param[in]      type  The IP configuration type for which the
+ *                        gateway, or default router, configuration
+ *                        will be selected from @a data and used to
+ *                        set the default route.
+ *
+ *  @sa __connman_inet_add_default_to_table
+ *  @sa __connman_service_indicate_default
+ *  @sa connman_inet_set_gateway_interface
+ *  @sa connman_inet_set_ipv6_gateway_interface
+ *
+ */
 static void set_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type)
 {
@@ -952,6 +981,33 @@ static void set_default_gateway(struct gateway_data *data,
 	__connman_service_indicate_default(data->service);
 }
 
+/**
+ *  @brief
+ *    Unset the gateway, or default route, for the specified IP
+ *    configuration type from the provided gateway data.
+ *
+ *  This attempts to unset, or clear, the gateway, or default, route
+ *  for the specified IP configuration type from the provided gateway
+ *  data. The network interface and, by extension, the network service
+ *  with which the gateway is associated is determined by the @a index
+ *  field of @a data.
+ *
+ *  On success, the gateway configuration specific to @a type will
+ *  have its @a active field set to false.
+ *
+ *  @param[in,out]  data  A pointer to the mutable gateway data to
+ *                        clear as the default route.
+ *  @param[in]      type  The IP configuration type for which the
+ *                        gateway, or default router, configuration
+ *                        will be selected from @a data and used to
+ *                        unset the default route.
+ *
+ *  @sa connman_inet_clear_gateway_address
+ *  @sa connman_inet_clear_gateway_interface
+ *  @sa connman_inet_clear_ipv6_gateway_address
+ *  @sa connman_inet_clear_ipv6_gateway_interface
+ *
+ */
 static void unset_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type)
 {
-- 
2.42.0

