Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CA1E4A1
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EA78C73200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:25 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AC5B373222
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 39/60] service: Document 'online_check_successes_threshold_is_met'.
Date: Thu, 21 Dec 2023 14:34:46 -0800
Message-ID: <20231221223508.2365510-40-gerickson@nuovations.com>
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

This adds documentation to the
'online_check_successes_threshold_is_met' function.
---
 src/service.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/service.c b/src/service.c
index 6a9db3c98e56..333c072739ed 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2608,6 +2608,26 @@ static bool is_online_check_success_threshold_met_predicate(
 	return threshold_met;
 }
 
+/**
+ *  @brief
+ *    Determine whether the online check successes threshold is met.
+ *
+ *  This attempts to determine whether the online check successes
+ *  threshold is met, comparing the current IPv4 and IPv6 online check
+ *  success counts against the "OnlineCheckSuccessesThreshold" settings
+ *  value and returning @a true if @b either the IPv4 @b or IPv6 counts
+ *  meet or exceed the threshold.
+ *
+ *  @param[in]  service  A pointer to the immutable service for which
+ *                       to determine whether the online check success
+ *                       threshold is met.
+ *
+ *  @returns
+ *    True if the success threshold is met; otherwise, false.
+ *
+ *  @sa online_check_failures_threshold_is_met
+ *
+ */
 static bool online_check_successes_threshold_is_met(
 			const struct connman_service *service)
 {
-- 
2.42.0

