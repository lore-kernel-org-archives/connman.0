Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BD328D7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0AC2E730F7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:07 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BFE10730CA
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 22/90] connection: Document 'gateway_config_free'.
Date: Wed,  6 Dec 2023 15:49:45 -0800
Message-ID: <20231206235056.322578-23-gerickson@nuovations.com>
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

This adds documentation to the 'gateway_config_free' function.
---
 src/connection.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 5b0f18627f40..f07974aee938 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1698,6 +1698,17 @@ static void connection_newgateway(int index, const char *gateway)
 	check_default_gateway(data);
 }
 
+/**
+ *  @brief
+ *    Deallocate gateway configuration resources.
+ *
+ *  This attempts to deallocate resources associated with the
+ *  specified gateway configuration.
+ *
+ *  @param[in,out]  config  A pointer to the mutable gateway
+ *                  configuration to deallocate.
+ *
+ */
 static void gateway_config_free(struct gateway_config *config)
 {
 	DBG("config %p", config);
-- 
2.42.0

