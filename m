Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20353B677
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B47D573204
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:48 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6E4BA73236
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 31/60] service: Document 'online_check_counter_reset'.
Date: Wed, 20 Dec 2023 22:16:54 -0800
Message-ID: <20231221061734.2344286-32-gerickson@nuovations.com>
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

This adds documentation to the 'online_check_counter_reset' function.
---
 src/service.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/service.c b/src/service.c
index 6e34b4c8ef34..8a1d09f1a4fd 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2250,6 +2250,13 @@ static void online_check_failures_threshold_was_met_clear(
 	online_check_failures_threshold_was_met_set_value(service, false);
 }
 
+/**
+ *  Reset the specified counter to zero (0).
+ *
+ *  @param[in,out]  counter  A pointer to the counter to reset by
+ *                           setting it to zero (0).
+ *
+ */
 static inline void online_check_counter_reset(
 			unsigned int *counter)
 {
-- 
2.42.0

