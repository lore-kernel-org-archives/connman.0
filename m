Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8138B654
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3984B73203
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:52 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id EDB4573229
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:51 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 40/60] service: Document 'online_check_counter_increment_and_log'.
Date: Wed, 20 Dec 2023 22:17:03 -0800
Message-ID: <20231221061734.2344286-41-gerickson@nuovations.com>
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

This adds documentation to the
'online_check_counter_increment_and_log' function.
---
 src/service.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/service.c b/src/service.c
index 333c072739ed..9d27a5692034 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2836,6 +2836,24 @@ static void reschedule_online_check(struct connman_service *service,
 		online_check_state->interval++;
 }
 
+/**
+ *  @brief
+ *    Increment and log the specified online check counter.
+ *
+ *  This increments by one (1) and logs the post-increment value of
+ *  the specified online check counter associated with the specified
+ *  network service.
+ *
+ *  @param[in]  service              A pointer to the immutable network
+ *                                   service associated with @a
+ *                                   counter.
+ *  @param[in]  type                 The IP configuration type associated
+ *                                   with @a counter.
+ *  @param[in]  counter_description  A pointer to a null-terminated C
+ *                                   string describing @a counter. For
+ *                                   example, "failure".
+ *
+ */
 static void online_check_counter_increment_and_log(
 			const struct connman_service *service,
 			enum connman_ipconfig_type type,
-- 
2.42.0

