Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCEBA38
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2033D73233
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:49 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D4B1573247
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 32/60] service: Document 'online_check_{failures,successes}_reset'.
Date: Wed, 20 Dec 2023 22:16:55 -0800
Message-ID: <20231221061734.2344286-33-gerickson@nuovations.com>
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
'online_check_{failures,successes}_reset' functions.
---
 src/service.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/service.c b/src/service.c
index 8a1d09f1a4fd..810ff68cf4f4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2266,6 +2266,18 @@ static inline void online_check_counter_reset(
 	*counter = 0;
 }
 
+/**
+ *  @brief
+ *    Reset to zero (0) the IPv4 and IPv6 online check failure
+ *    counters for the specified service.
+ *
+ *  @param[in]   service   A pointer to the mutable service for which
+ *                         to reset the IPv4 and IPv6 online check
+ *                         failure counters.
+ *
+ *  @sa online_check_successes_reset
+ *
+ */
 static void online_check_failures_reset(struct connman_service *service)
 {
 	DBG("service %p (%s)",
@@ -2275,6 +2287,18 @@ static void online_check_failures_reset(struct connman_service *service)
 	online_check_counter_reset(&service->online_check_state_ipv6.failures);
 }
 
+/**
+ *  @brief
+ *    Reset to zero (0) the IPv4 and IPv6 online check success
+ *    counters for the specified service.
+ *
+ *  @param[in]   service   A pointer to the mutable service for which
+ *                         to reset the IPv4 and IPv6 online check
+ *                         success counters.
+ *
+ *  @sa online_check_failures_reset
+ *
+ */
 static void online_check_successes_reset(struct connman_service *service)
 {
 	DBG("service %p (%s)",
-- 
2.42.0

