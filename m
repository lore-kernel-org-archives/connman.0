Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76A328D0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1A84E73203
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:05 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C942673213
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:04 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 17/90] connection: Remove 'DBG' from '__connman_connection_update_gateway'.
Date: Wed,  6 Dec 2023 15:49:40 -0800
Message-ID: <20231206235056.322578-18-gerickson@nuovations.com>
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

This removes a 'DBG' statement from
'__connman_connection_update_gateway' that is duplicative to the
'GATEWAY_DATA_DBG' that follows it.
---
 src/connection.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 354340f0ef87..ecb8e6b4037a 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2101,8 +2101,6 @@ bool __connman_connection_update_gateway(void)
 
 	default_gateway = find_default_gateway_data();
 
-	DBG("default_gateway %p", default_gateway);
-
 	GATEWAY_DATA_DBG("default_gateway", default_gateway);
 
 	/*
-- 
2.42.0

