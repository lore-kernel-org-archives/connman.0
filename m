Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731E328C2
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AFE5A73140
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:09 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 72F1F7314B
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 29/90] connection: Leverage 'unset_default_gateway' in 'del_gateway_routes'.
Date: Wed,  6 Dec 2023 15:49:52 -0800
Message-ID: <20231206235056.322578-30-gerickson@nuovations.com>
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

Much of the logic in 'del_gateway_routes' is otherwise identical to
that of 'unset_default_gateway'. However, it side steps managing the
gateway state, type, and flags state, potentially leaving
inconsistencies.

Rather than this separate-but-equal existence, simply leverage
'unset_default_gateway' in 'del_gateway_routes'.
---
 src/connection.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 179649a714bd..702e08dbe37c 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -203,6 +203,10 @@ struct mutate_default_gateway_ops {
 				struct gateway_config *config);
 };
 
+static int unset_default_gateway(struct gateway_data *data,
+				enum connman_ipconfig_type type,
+				const char *function);
+
 /*
  * These are declared as 'const char *const' to effect an immutable
  * pointer to an immutable null-terminated character string such that
@@ -958,15 +962,12 @@ static int del_gateway_routes(struct gateway_data *data,
 						data->index,
 						data->ipv4_config->vpn_ip);
 
-		} else if (is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
-			status4 = connman_inet_clear_gateway_interface(
-								data->index);
 		} else {
 			connman_inet_del_host_route(data->index,
 						data->ipv4_config->gateway);
-			status4 = connman_inet_clear_gateway_address(
-						data->index,
-						data->ipv4_config->gateway);
+
+			status4 = UNSET_DEFAULT_GATEWAY(data, type);
+
 		}
 	}
 
@@ -976,15 +977,12 @@ static int del_gateway_routes(struct gateway_data *data,
 						data->index,
 						data->ipv6_config->vpn_ip);
 
-		} else if (is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
-			status6 = connman_inet_clear_ipv6_gateway_interface(
-								data->index);
 		} else {
 			connman_inet_del_ipv6_host_route(data->index,
 						data->ipv6_config->gateway);
-			status6 = connman_inet_clear_ipv6_gateway_address(
-						data->index,
-						data->ipv6_config->gateway);
+
+			status6 = UNSET_DEFAULT_GATEWAY(data, type);
+
 		}
 	}
 
-- 
2.42.0

