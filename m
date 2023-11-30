Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB3636
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 44C8073140
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:23:12 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E2A1A7314E
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:23:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] connection: Fix white space indentation.
Date: Wed, 29 Nov 2023 16:23:03 -0800
Message-ID: <20231130002309.1322111-2-gerickson@nuovations.com>
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

This corrects a white space indentation style issue in
'__connman_connection_gateway_remove'.
---
 src/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/connection.c b/src/connection.c
index 2d9e259c2d28..b5349834c813 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1597,7 +1597,7 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 {
 	struct gateway_data *data = NULL;
 	bool set_default4 = false, set_default6 = false;
-        bool do_ipv4 = false, do_ipv6 = false;
+	bool do_ipv4 = false, do_ipv6 = false;
 	int err;
 
 	DBG("service %p (%s) type %d (%s)",
-- 
2.42.0

