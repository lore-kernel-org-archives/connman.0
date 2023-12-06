Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408E328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7CC1E73213
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:34 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3D5CB73222
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:34 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 90/90] connection: Ensure function attribution 'DBG' output is consistent.
Date: Wed,  6 Dec 2023 15:50:56 -0800
Message-ID: <20231206235056.322578-94-gerickson@nuovations.com>
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

This ensures that function call attribution 'DBG' output is consistent
in the format "from %s()".
---
 src/connection.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 3128110a27e2..0c1bdba7f515 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -820,7 +820,7 @@ static void gateway_config_debug(const char *function,
 		return;
 
 	if (!config)
-		DBG("from %s %s %p", function, description, config);
+		DBG("from %s() %s %p", function, description, config);
 	else {
 		if (config->vpn_phy_index >= 0)
 			vpn_phy_interface =
@@ -883,11 +883,11 @@ static void gateway_data_debug(const char *function,
 		return;
 
 	if (!data)
-		DBG("from %s %s %p", function, description, data);
+		DBG("from %s() %s %p", function, description, data);
 	else {
 		interface = connman_inet_ifname(data->index);
 
-		DBG("from %s %s %p: { index: %d (%s), service: %p (%s), "
+		DBG("from %s() %s %p: { index: %d (%s), service: %p (%s), "
 			"ipv4_config: %p, ipv6_config: %p, default_checked: %u }",
 			function,
 			description,
-- 
2.42.0

