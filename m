Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08B328D6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D556773206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:05 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 981307321A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 19/90] connection: Document 'gateway_data_config_get'.
Date: Wed,  6 Dec 2023 15:49:42 -0800
Message-ID: <20231206235056.322578-20-gerickson@nuovations.com>
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

This adds documentation to the 'gateway_data_config_get' function.
---
 src/connection.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index e328a929b306..a89fec393960 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -394,6 +394,22 @@ static void gateway_data_debug(const char *function,
 	}
 }
 
+/**
+ *  @brief
+ *    Return the IP-specific gateway configuration for the specified
+ *    gateway data.
+ *
+ *  @param[in]  data  A pointer to the mutable gateway data for which
+ *                    the gateway configuration is to be returned,
+ *                    specific to @a type.
+ *  @param[in]  type  The IP configuration type for which the gateway
+ *                    configuration is to be returned.
+ *
+ *  @returns
+ *    The IP-specific gateway configuration for the specified gateway
+ *    data on success; otherwise, null.
+ *
+ */
 static struct gateway_config *gateway_data_config_get(struct gateway_data *data,
 				enum connman_ipconfig_type type)
 {
-- 
2.42.0

