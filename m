Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476137E1
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3C4E773144
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:23:13 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E3ECC73218
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:23:12 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/3] connection: Rename 'set_default[46]' local variables.
Date: Wed, 29 Nov 2023 16:23:05 -0800
Message-ID: <20231130002309.1322111-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130002309.1322111-1-gerickson@nuovations.com>
References: <20231130002309.1322111-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames the 'set_default[46]' local variables in
'__connman_connection_gateway_remove' to 'is_vpn[46]' to more
accurately reflect that they are tracking the state of:

    do_ipv[46] && data->ipv[46]_config && data->ipv[46]_config->vpn
---
 src/connection.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 647631e54324..23eb3a45def3 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1596,7 +1596,7 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
 	struct gateway_data *data = NULL;
-	bool set_default4 = false, set_default6 = false;
+	bool is_vpn4 = false, is_vpn6 = false;
 	bool do_ipv4 = false, do_ipv6 = false;
 	int err;
 
@@ -1628,23 +1628,23 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	GATEWAY_DATA_DBG("service_data", data);
 
 	if (do_ipv4 && data->ipv4_config)
-		set_default4 = data->ipv4_config->vpn;
+		is_vpn4 = data->ipv4_config->vpn;
 
 	if (do_ipv6 && data->ipv6_config)
-		set_default6 = data->ipv6_config->vpn;
+		is_vpn6 = data->ipv6_config->vpn;
 
 	DBG("ipv4 gateway %s ipv6 gateway %s vpn %d/%d",
 		data->ipv4_config ? data->ipv4_config->gateway : "<null>",
 		data->ipv6_config ? data->ipv6_config->gateway : "<null>",
-		set_default4, set_default6);
+		is_vpn4, is_vpn6);
 
     /* If necessary, delete any VPN-related host routes. */
 
-	if (set_default4 && data->index >= 0)
+	if (is_vpn4 && data->index >= 0)
 		connman_inet_del_host_route(data->ipv4_config->vpn_phy_index,
 						data->ipv4_config->gateway);
 
-	if (set_default6 && data->index >= 0)
+	if (is_vpn6 && data->index >= 0)
 		connman_inet_del_ipv6_host_route(
 					data->ipv6_config->vpn_phy_index,
 						data->ipv6_config->gateway);
@@ -1673,7 +1673,7 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	 * gateway delete notification.
 	 * We hit the same issue if remove_gateway() fails.
 	 */
-	if (set_default4 || set_default6 || err < 0) {
+	if (is_vpn4 || is_vpn6 || err < 0) {
 		data = find_default_gateway_data();
 
 		GATEWAY_DATA_DBG("default_data", data);
-- 
2.42.0

