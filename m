Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133914AB6
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C2FD973118
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:26:25 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 76CF073150
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:26:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/4] connection: Simplify 'unset_default_gateway' flow.
Date: Wed, 29 Nov 2023 21:26:20 -0800
Message-ID: <20231130052622.1335266-3-gerickson@nuovations.com>
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

Ostensibly over time, the logic of 'unset_default_gateway' has become
a bit complicated with early returns and repeated state checks.

However, amidst all of that, there is a simpler flow to surface. At
its core, the function is two outer conditional blocks, one for IPv4
and one for IPv6, and three inner conditional blocks within those: one
for a VPN, one for a gateway with an any/unspecified address, and one
for everything else.

This simplifies the flow of 'unset_default_gateway' accordingly,
curtailing the number of early returns and reducing the repeated state
checks to one through the use of those simplified conditional blocks.
---
 src/connection.c | 70 +++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 9979ca02c356..2460ca91074c 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -957,53 +957,45 @@ static void unset_default_gateway(struct gateway_data *data,
 	else
 		return;
 
-	if (do_ipv4 && data->ipv4_config &&
-					data->ipv4_config->vpn) {
-		connman_inet_clear_gateway_interface(data->index);
-		data->ipv4_config->active = false;
-
-		DBG("unset %p index %d vpn %s index %d phy %s",
-			data, data->index, data->ipv4_config->vpn_ip,
-			data->ipv4_config->vpn_phy_index,
-			data->ipv4_config->vpn_phy_ip);
-
-		return;
-	}
+	if (do_ipv4 && data->ipv4_config) {
+		if (data->ipv4_config->vpn) {
+			connman_inet_clear_gateway_interface(data->index);
 
-	if (do_ipv6 && data->ipv6_config &&
-					data->ipv6_config->vpn) {
-		connman_inet_clear_ipv6_gateway_interface(data->index);
-		data->ipv6_config->active = false;
+			data->ipv4_config->active = false;
 
-		DBG("unset %p index %d vpn %s index %d phy %s",
-			data, data->index, data->ipv6_config->vpn_ip,
-			data->ipv6_config->vpn_phy_index,
-			data->ipv6_config->vpn_phy_ip);
+			DBG("unset %p index %d vpn %s index %d phy %s",
+				data, data->index, data->ipv4_config->vpn_ip,
+				data->ipv4_config->vpn_phy_index,
+				data->ipv4_config->vpn_phy_ip);
+		} else if (is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
+			connman_inet_clear_gateway_interface(data->index);
 
-		return;
+			data->ipv4_config->active = false;
+		} else {
+			connman_inet_clear_gateway_address(data->index,
+						data->ipv4_config->gateway);
+		}
 	}
 
-	if (do_ipv4 && data->ipv4_config &&
-			is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
-		connman_inet_clear_gateway_interface(data->index);
-		data->ipv4_config->active = false;
-		return;
-	}
+	if (do_ipv6 && data->ipv6_config) {
+		if (data->ipv6_config->vpn) {
+			connman_inet_clear_ipv6_gateway_interface(data->index);
 
-	if (do_ipv6 && data->ipv6_config &&
-			is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
-		connman_inet_clear_ipv6_gateway_interface(data->index);
-		data->ipv6_config->active = false;
-		return;
-	}
+			data->ipv6_config->active = false;
 
-	if (do_ipv6 && data->ipv6_config)
-		connman_inet_clear_ipv6_gateway_address(data->index,
-						data->ipv6_config->gateway);
+			DBG("unset %p index %d vpn %s index %d phy %s",
+				data, data->index, data->ipv6_config->vpn_ip,
+				data->ipv6_config->vpn_phy_index,
+				data->ipv6_config->vpn_phy_ip);
+		} else if (is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
+			connman_inet_clear_ipv6_gateway_interface(data->index);
 
-	if (do_ipv4 && data->ipv4_config)
-		connman_inet_clear_gateway_address(data->index,
-						data->ipv4_config->gateway);
+			data->ipv6_config->active = false;
+		} else {
+			connman_inet_clear_ipv6_gateway_address(data->index,
+						data->ipv6_config->gateway);
+		}
+	}
 }
 
 /**
-- 
2.42.0

