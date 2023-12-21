Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C7B662
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4705B73202
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:50 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 08BCE73232
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 35/60] service: Document 'online_check_counter_threshold_is_met'.
Date: Wed, 20 Dec 2023 22:16:58 -0800
Message-ID: <20231221061734.2344286-36-gerickson@nuovations.com>
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

This adds documentation to the 'online_check_counter_threshold_is_met'
function.
---
 src/service.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/service.c b/src/service.c
index e6652f53363c..abf7800b56fa 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2373,6 +2373,38 @@ static void online_check_counters_log(
 		ipv6_counter);
 }
 
+/**
+ *  @brief
+ *    Determine whether an online check counter has met its threshold.
+ *
+ *  This determines whether an online check counter associated with
+ *  the specified network service has met its threshold, where the
+ *  threshold is accessed from the configuration store with the
+ *  specified key.
+ *
+ *  @param[in]  service                A pointer to the immutable
+ *                                     network service associated with
+ *                                     the counter to check.
+ *  @param[in]  counter_threshold_key  A pointer to a null-terminated
+ *                                     C string containing the key to
+ *                                     use with the configuration
+ *                                     store to access the threshold
+ *                                     value to check the counter
+ *                                     against.
+ *  @param[in]  counter_description    A pointer to a null-terminated
+ *                                     C string describing the counter
+ *                                     to check. For example, "failure".
+ *  @param[in]  predicate              A pointer to the predicate
+ *                                     function to invoke to make the
+ *                                     actual determination of whether
+ *                                     the counter has met the
+ *                                     threshold accessed by @a
+ *                                     counter_threshold_key.
+ *
+ *  @returns
+ *    True if the counter has met the threshold; otherwise, false.
+ *
+ */
 static bool online_check_counter_threshold_is_met(
 			const struct connman_service *service,
 			const char *counter_threshold_key,
-- 
2.42.0

