Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A86328C6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4C218731F7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:04 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 0DCE073204
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 15/90] connection: Check service network index for validity.
Date: Wed,  6 Dec 2023 15:49:38 -0800
Message-ID: <20231206235056.322578-16-gerickson@nuovations.com>
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

In '__connman_connection_gateway_add', the network interface index is
retrieved from the 'service' parameter; however, it is not checked for
validity. Since the index will go on and later populate the gateway
data, via 'add_gateway, ensure that the index is valid. If it is not,
return -EINVAL.
---
 src/connection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index e6a6ea42dc59..d645078d85ee 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1845,6 +1845,8 @@ int __connman_connection_gateway_add(struct connman_service *service,
 		return -EINVAL;
 
 	index = __connman_service_get_index(service);
+	if (index < 0)
+		return -EINVAL;
 
 	interface = connman_inet_ifname(index);
 
-- 
2.42.0

