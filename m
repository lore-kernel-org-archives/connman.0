Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE5328C1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5DA2973159
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:02 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 14B5E73180
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/90] connection: Fix 'DBG' copy-and-paste typo.
Date: Wed,  6 Dec 2023 15:49:33 -0800
Message-ID: <20231206235056.322578-11-gerickson@nuovations.com>
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

This corrects an "ipv4" -> "ipv6" copy-and-paste typo in 'DBG'
statements in '{un,}set_default_gateway'.
---
 src/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 6df29fe31aa9..ac0565c14257 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1197,7 +1197,7 @@ static void set_default_gateway(struct gateway_data *data,
 						data->ipv6_config->gateway);
 
 			DBG("set %p index %d gateway %s",
-				data, data->index, data->ipv4_config->gateway);
+				data, data->index, data->ipv6_config->gateway);
 		}
 
 		gateway_config_type_set(data->ipv6_config,
@@ -1317,7 +1317,7 @@ static void unset_default_gateway(struct gateway_data *data,
 						data->ipv6_config->gateway);
 
 			DBG("unset %p index %d gateway %s",
-				data, data->index, data->ipv4_config->gateway);
+				data, data->index, data->ipv6_config->gateway);
 		}
 	}
 }
-- 
2.42.0

