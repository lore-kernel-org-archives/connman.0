Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F3DF41
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CF8607312B
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:21:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 889407314E
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:21:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] connection: Rename 'del_routes'.
Date: Tue, 28 Nov 2023 22:21:08 -0800
Message-ID: <20231129062109.1270106-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129062109.1270106-1-gerickson@nuovations.com>
References: <20231129062109.1270106-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames 'del_routes' as 'del_gateway_routes' to align with the
revised name of its sole caller, 'del_gateway_routes_if_active'.
---
 src/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 547a47cf8b6f..23adf570120a 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -567,7 +567,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 	}
 }
 
-static int del_routes(struct gateway_data *data,
+static int del_gateway_routes(struct gateway_data *data,
 			enum connman_ipconfig_type type)
 {
 	int status4 = 0, status6 = 0;
@@ -640,7 +640,7 @@ static int del_gateway_routes_if_active(struct gateway_data *data,
 	DBG("type %d active %d", type, active);
 
 	if (active)
-		return del_routes(data, type);
+		return del_gateway_routes(data, type);
 
 	return 0;
 }
-- 
2.42.0

