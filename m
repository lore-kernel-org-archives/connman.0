Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF283B1BB
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 98EA073156
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:17:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 49DA873213
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:17:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] connection: Remove unused local variables.
Date: Wed, 29 Nov 2023 15:17:05 -0800
Message-ID: <20231129231706.1306676-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129231706.1306676-1-gerickson@nuovations.com>
References: <20231129231706.1306676-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

In __connman_connection_gateway_remove, both 'index' and 'interface'
are set; however, neither are used. Remove these unused local
variables.
---
 src/connection.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 297af227a9c3..5a98b8d57c84 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1595,22 +1595,12 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	struct gateway_data *data = NULL;
 	bool set_default4 = false, set_default6 = false;
         bool do_ipv4 = false, do_ipv6 = false;
-	int index;
-	g_autofree char *interface = NULL;
 	int err;
 
 	DBG("service %p (%s) type %d (%s)",
 		service, maybe_null(connman_service_get_identifier(service)),
 		type, __connman_ipconfig_type2string(type));
 
-	index = __connman_service_get_index(service);
-	if (index < 0)
-		return;
-
-	interface = connman_inet_ifname(index);
-
-	DBG("index %d (%s)", index, maybe_null(interface));
-
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		do_ipv4 = true;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
-- 
2.42.0

