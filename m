Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD20156D7
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1691873204
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:19 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C344073222
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 22/60] service: Add per-service online check failure threshold state.
Date: Thu, 21 Dec 2023 14:34:29 -0800
Message-ID: <20231221223508.2365510-23-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221223508.2365510-1-gerickson@nuovations.com>
References: <20231221223508.2365510-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds per-service state that tracks whether the service has met
the number of sustained, back-to-back "online" reachability check
failures for continuous" online check mode.
---
 src/service.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/service.c b/src/service.c
index 5f9dcab58092..d75399062ed7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -188,6 +188,7 @@ struct connman_service {
 	bool wps_advertizing;
 	struct online_check_state online_check_state_ipv4;
 	struct online_check_state online_check_state_ipv6;
+	bool online_check_failures_met_threshold;
 	bool do_split_routing;
 	bool new_service;
 	bool hidden_service;
-- 
2.42.0

