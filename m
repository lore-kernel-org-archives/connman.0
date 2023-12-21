Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45083B673
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A52037324D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:23 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 678367324F
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 38/60] service: Document 'is_online_check_success_threshold_met_predicate'.
Date: Wed, 20 Dec 2023 22:39:42 -0800
Message-ID: <20231221064007.2347566-39-gerickson@nuovations.com>
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

This adds documentation to the
'is_online_check_success_threshold_met_predicate' function.
---
 src/service.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/service.c b/src/service.c
index beb339b89256..6a9db3c98e56 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2546,6 +2546,32 @@ static bool online_check_failures_threshold_is_met(
 			is_online_check_failure_threshold_met_predicate);
 }
 
+/**
+ *  @brief
+ *    Determine whether the service has met the online check success
+ *    threshold.
+ *
+ *  This predicate determines whether the online check success
+ *  threshold has been met by the specified network service.
+ *
+ *  @param[in]  service                A pointer to the immutable
+ *                                     network service for which to
+ *                                     check whether its has met the
+ *                                     online check success threshold.
+ *  @param[in]  counter_description    A pointer to a null-terminated
+ *                                     C string describing the success
+ *                                     counter. For example,
+ *                                     "success".
+ *  @param[in]  counter_threshold      The threshold value to check the
+ *                                     success counter against.
+ *
+ *  @returns
+ *    True if the online check success counter has met the success
+ *    threshold; otherwise, false.
+ *
+ *  @sa online_check_successes_threshold_is_met
+ *
+ */
 static bool is_online_check_success_threshold_met_predicate(
 			const struct connman_service *service,
 			const char *counter_description,
-- 
2.42.0

