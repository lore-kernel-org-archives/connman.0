Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DD328CB
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E249C731D1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:03 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A4547731FC
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 14/90] connection: Check 'service' parameter for null.
Date: Wed,  6 Dec 2023 15:49:37 -0800
Message-ID: <20231206235056.322578-15-gerickson@nuovations.com>
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

In '__connman_connection_gateway_add', as an internal, cross-module
function, check that the 'service' parameter is not null. If it is,
return -EINVAL.
---
 src/connection.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index e80443c02a5a..e6a6ea42dc59 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1830,8 +1830,7 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	struct gateway_data *new_gateway = NULL;
 	enum connman_ipconfig_type type4 = CONNMAN_IPCONFIG_TYPE_UNKNOWN,
 		type6 = CONNMAN_IPCONFIG_TYPE_UNKNOWN;
-	enum connman_service_type service_type =
-					connman_service_get_type(service);
+	enum connman_service_type service_type;
 	int index;
 	g_autofree char *interface = NULL;
 	int err = 0;
@@ -1842,12 +1841,17 @@ int __connman_connection_gateway_add(struct connman_service *service,
 		type, __connman_ipconfig_type2string(type),
 		peer, maybe_null(peer));
 
+	if (!service)
+		return -EINVAL;
+
 	index = __connman_service_get_index(service);
 
 	interface = connman_inet_ifname(index);
 
 	DBG("index %d (%s)", index, maybe_null(interface));
 
+	service_type = connman_service_get_type(service);
+
 	/*
 	 * If gateway is NULL, it's a point to point link and the default
 	 * gateway for ipv4 is 0.0.0.0 and for ipv6 is ::, meaning the
-- 
2.42.0

