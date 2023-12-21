Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480DBA4B
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7EA4973237
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:49 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4042773243
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 33/60] service: Document 'online_check_state_reset'.
Date: Wed, 20 Dec 2023 22:16:56 -0800
Message-ID: <20231221061734.2344286-34-gerickson@nuovations.com>
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

This adds documentation to the 'online_check_state_reset' function.
---
 src/service.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/service.c b/src/service.c
index 810ff68cf4f4..5dfada3af3f5 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2308,6 +2308,22 @@ static void online_check_successes_reset(struct connman_service *service)
 	online_check_counter_reset(&service->online_check_state_ipv6.successes);
 }
 
+/**
+ *  @brief
+ *    Reset the online check state for the specified service.
+ *
+ *  This resets the online check state for the specified service,
+ *  including its failure threshold state, failure counters, and
+ *  success counters.
+ *
+ *  @param[in]   service   A pointer to the mutable service for which
+ *                         to reset the online check state.
+ *
+ *  @sa online_check_failures_reset
+ *  @sa online_check_successes_reset
+ *  @sa online_check_failures_threshold_was_met_clear
+ *
+ */
 static void online_check_state_reset(struct connman_service *service)
 {
 	online_check_failures_reset(service);
-- 
2.42.0

