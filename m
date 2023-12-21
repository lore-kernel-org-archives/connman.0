Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D65AD5E
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0FB0A73213
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:51 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C4F3C73229
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 37/60] service: Document 'online_check_failures_threshold_is_met'.
Date: Wed, 20 Dec 2023 22:17:00 -0800
Message-ID: <20231221061734.2344286-38-gerickson@nuovations.com>
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
'online_check_failures_threshold_is_met' function.
---
 src/service.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/service.c b/src/service.c
index 8c8ff1c7a496..beb339b89256 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2512,6 +2512,26 @@ static bool is_online_check_failure_threshold_met_predicate(
 	return threshold_met;
 }
 
+/**
+ *  @brief
+ *    Determine whether the online check failures threshold is met.
+ *
+ *  This attempts to determine whether the online check failures
+ *  threshold is met, comparing the current IPv4 and IPv6 online check
+ *  failure counts against the "OnlineCheckFailuresThreshold" settings
+ *  value and returning @a true if @b both the IPv4 and IPv6 counts
+ *  meet or exceed the threshold.
+ *
+ *  @param[in]  service  A pointer to the immutable service for which
+ *                       to determine whether the online check failure
+ *                       threshold is met.
+ *
+ *  @returns
+ *    True if the failure threshold is met; otherwise, false.
+ *
+ *  @sa online_check_successes_threshold_is_met
+ *
+ */
 static bool online_check_failures_threshold_is_met(
 			const struct connman_service *service)
 {
-- 
2.42.0

