Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF8B678
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4D33773200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:48 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 0EB7C73238
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:47 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 30/60] service: Document 'online_check_failures_threshold_was_met_{set,clear}'.
Date: Wed, 20 Dec 2023 22:16:53 -0800
Message-ID: <20231221061734.2344286-31-gerickson@nuovations.com>
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
'online_check_failures_threshold_was_met_{set,clear}' functions.
---
 src/service.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/service.c b/src/service.c
index b41f29d73d60..6e34b4c8ef34 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2215,12 +2215,35 @@ static void online_check_failures_threshold_was_met_set_value(
 	service->online_check_failures_met_threshold = value;
 }
 
+/**
+ *  @brief
+ *    Set (that is, assert) the online check failures threshold state.
+ *
+ *  @param[in,out]  service  A pointer to the mutable service for which
+ *                           to set the failures threshold state.
+ *
+ *  @sa online_check_failures_threshold_was_met_set_value
+ *  @sa online_check_failures_threshold_was_met_clear
+ *
+ */
 static void online_check_failures_threshold_was_met_set(
 			struct connman_service *service)
 {
 	online_check_failures_threshold_was_met_set_value(service, true);
 }
 
+/**
+ *  @brief
+ *    Clear (that is, deassert) the online check failures threshold
+ *    state.
+ *
+ *  @param[in,out]  service  A pointer to the mutable service for which
+ *                           to clear the failures threshold state.
+ *
+ *  @sa online_check_failures_threshold_was_met_set_value
+ *  @sa online_check_failures_threshold_was_met_set
+ *
+ */
 static void online_check_failures_threshold_was_met_clear(
 			struct connman_service *service)
 {
-- 
2.42.0

