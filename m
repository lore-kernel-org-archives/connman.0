Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3C8F54
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1682673202
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:16 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CBB127321E
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 19/60] service: Document 'online_check_state' 'failures/successes' members.
Date: Wed, 20 Dec 2023 22:39:23 -0800
Message-ID: <20231221064007.2347566-20-gerickson@nuovations.com>
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

This documents the 'failures/successes' members of the
'online_check_state' structure.
---
 src/service.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/service.c b/src/service.c
index db1d45f61063..5f9dcab58092 100644
--- a/src/service.c
+++ b/src/service.c
@@ -109,7 +109,17 @@ struct online_check_state {
 	 *
 	 */
 	unsigned int interval;
+
+	/**
+	 *	The number of sustained, back-to-back "online" reachability
+	 *	check successes for "continuous" online check mode.
+	 */
 	unsigned int successes;
+
+	/**
+	 *	The number of sustained, back-to-back "online" reachability
+	 *	check failures for "continuous" online check mode.
+	 */
 	unsigned int failures;
 };
 
-- 
2.42.0

