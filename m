Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E01BA5E
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 723727310B
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 21:05:46 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2D2D07312B
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 21:05:46 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] session: Add service identifier to 'DBG' in 'service_state_changed'.
Date: Tue, 19 Dec 2023 18:05:43 -0800
Message-ID: <20231220020544.2272820-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220020544.2272820-1-gerickson@nuovations.com>
References: <20231220020544.2272820-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds the service identifier to the 'DBG' statement in
'service_state_changed' to aid debugging in a multi-technology
environment with "EnableOnlineToReadyTransition" asserted and for
consistency with other 'DBG' statements in other modules.
---
 src/session.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/session.c b/src/session.c
index eeefe3f28b3c..bef4b833a3cb 100644
--- a/src/session.c
+++ b/src/session.c
@@ -1937,7 +1937,9 @@ static void service_state_changed(struct connman_service *service,
 {
 	struct connman_service_info *info;
 
-	DBG("service %p state %d", service, state);
+	DBG("service %p (%s) state %d",
+		service, connman_service_get_identifier(service),
+		state);
 
 	info = g_hash_table_lookup(service_hash, service);
 
-- 
2.42.0

