Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5755328B7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 22E6973206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:34 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CB94873219
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:33 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 89/90] connection: Add whitespace around 'del_gateway_routes_if_active'.
Date: Wed,  6 Dec 2023 15:50:55 -0800
Message-ID: <20231206235056.322578-93-gerickson@nuovations.com>
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

Increase visual visibility of 'del_gateway_routes_if_active' in
'add_gateway' by adding blank lines both before and after the function
call.
---
 src/connection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 47ec67e6717a..3128110a27e2 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1659,7 +1659,9 @@ static int add_gateway(struct connman_service *service,
 	if (old) {
 		DBG("Replacing gw %p ipv4 %p ipv6 %p", old,
 			old->ipv4_config, old->ipv6_config);
+
 		del_gateway_routes_if_active(old, type);
+
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 			temp_data->ipv6_config = old->ipv6_config;
 			old->ipv6_config = NULL;
-- 
2.42.0

