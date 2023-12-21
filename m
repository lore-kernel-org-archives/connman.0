Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8832BA38
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2112273202
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:18 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CF3897321D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 24/60] service: Document 'connman_service' 'online_check_state_ipv{4,6}' members.
Date: Wed, 20 Dec 2023 22:39:28 -0800
Message-ID: <20231221064007.2347566-25-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221064007.2347566-1-gerickson@nuovations.com>
References: <20231221064007.2347566-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This documents the 'online_check_state_ipv{4,6}' members of the
'connman_service' structure.
---
 src/service.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/service.c b/src/service.c
index 2ce829ae37a7..6c898476627b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -186,7 +186,15 @@ struct connman_service {
 	char *pac;
 	bool wps;
 	bool wps_advertizing;
+
+    /**
+     *  IPv4-specific "online" reachability check state.
+     */
 	struct online_check_state online_check_state_ipv4;
+
+    /**
+     *  IPv6-specific "online" reachability check state.
+     */
 	struct online_check_state online_check_state_ipv6;
 
     /**
-- 
2.42.0

