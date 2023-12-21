Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BEB669
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1C13073200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:39 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C3D8173214
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:38 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 07/60] service: Document 'online_check_state' 'active' member.
Date: Wed, 20 Dec 2023 22:16:30 -0800
Message-ID: <20231221061734.2344286-8-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221061734.2344286-1-gerickson@nuovations.com>
References: <20231221061734.2344286-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This documents the 'active' member of the 'online_check_state'
structure.
---
 src/service.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/service.c b/src/service.c
index 669337ab6734..27d261861b7c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -93,6 +93,9 @@ struct connman_stats_counter {
  *
  */
 struct online_check_state {
+	/**
+	 *  Indicates whether an online check is active and in-flight.
+	 */
 	bool active;
 
 	/**
-- 
2.42.0

