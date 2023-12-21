Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2D78E67
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7844A73200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:17 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3104C73224
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 18/60] service: Introduce and use online check 'failures/successes' state.
Date: Thu, 21 Dec 2023 14:34:25 -0800
Message-ID: <20231221223508.2365510-19-gerickson@nuovations.com>
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

This introduces a per-IP configuration online check 'failures' and
'successes' state member that represent the number of sustained,
back-to-back "online" reachability check failures and successes,
respectively, for "continuous" online check mode.
---
 src/service.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/service.c b/src/service.c
index 2599acd832ce..db1d45f61063 100644
--- a/src/service.c
+++ b/src/service.c
@@ -109,6 +109,8 @@ struct online_check_state {
 	 *
 	 */
 	unsigned int interval;
+	unsigned int successes;
+	unsigned int failures;
 };
 
 struct connman_service {
-- 
2.42.0

