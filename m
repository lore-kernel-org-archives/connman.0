Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571064D
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B9E6173150
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:23:12 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6D38273159
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:23:12 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] connection: Optimize conditional '&&' clauses.
Date: Wed, 29 Nov 2023 16:23:04 -0800
Message-ID: <20231130002309.1322111-3-gerickson@nuovations.com>
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

This optimizes the conditional '&&' clauses in
'__connman_connection_gateway_remove' to take advantage of stored,
local state in 'set_default[46]' thereby avoiding redundant checks of
'do_ipv[46]', 'data->ipv[46]_config', and 'data->ipv[46]_config->vpn'.

In '__connman_connection_gateway_remove', local variables
'set_default[46]' are set to reflect the state of 'do_ipv[46] &&
data->ipv[46]_config' as well as that of 'data->ipv[46]_config->vpn',
effectively forming a three-conditional '&&'.

Then, shortly thereafter, with no intervening mutations of 'data',
'do_ipv[46]', 'data->ipv[46]_config', and 'data->ipv[46]_config->vpn'
are checked again, along with 'data->index >= 0', in a
four-conditional '&&'. Since the first three of those checks are
redundant and simply reflect the state of 'set_default[46]', three of
those four conditional '&&' terms can simply be replaced with
'set_default[46]'.

This change makes that replacement.
---
 src/connection.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index b5349834c813..647631e54324 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1640,13 +1640,11 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 
     /* If necessary, delete any VPN-related host routes. */
 
-	if (do_ipv4 && data->ipv4_config &&
-			data->ipv4_config->vpn && data->index >= 0)
+	if (set_default4 && data->index >= 0)
 		connman_inet_del_host_route(data->ipv4_config->vpn_phy_index,
 						data->ipv4_config->gateway);
 
-	if (do_ipv6 && data->ipv6_config &&
-			data->ipv6_config->vpn && data->index >= 0)
+	if (set_default6 && data->index >= 0)
 		connman_inet_del_ipv6_host_route(
 					data->ipv6_config->vpn_phy_index,
 						data->ipv6_config->gateway);
-- 
2.42.0

