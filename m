Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B593B64A
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 02D8473213
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:53 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B7ABA73225
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 42/60] service: Document 'continuous_online_check_log_{counter,failures,successes}_threshold_met'.
Date: Wed, 20 Dec 2023 22:17:05 -0800
Message-ID: <20231221061734.2344286-43-gerickson@nuovations.com>
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
'continuous_online_check_log_{counter,failures,successes}_threshold_met'
functions.
---
 src/service.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/src/service.c b/src/service.c
index 029d7b8b6122..1e2282572892 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2901,6 +2901,29 @@ static void online_check_log_success(const struct connman_service *service,
 			connman_setting_get_string("OnlineCheckIPv6URL"));
 }
 
+/**
+ *  @brief
+ *    Log that an online check counter has met its threshold.
+ *
+ *  This logs that an online check counter associated with the
+ *  specified network service has met its threshold.
+ *
+ *  @param[in]  service                A pointer to the immutable
+ *                                     network service for which to
+ *                                     log that one of its online
+ *                                     check counters has met its
+ *                                     threshold.
+ *  @param[in]  counter_threshold_key  A pointer to a null-terminated
+ *                                     C string containing the key to
+ *                                     use with the configuration
+ *                                     store to access the threshold
+ *                                     value for the counter.
+ *  @param[in]  counter_description    A pointer to a null-terminated
+ *                                     C string describing the counter
+ *                                     to check. For example,
+ *                                     "failure(s)".
+ *
+ */
 static void continuous_online_check_log_counter_threshold_met(
 			const struct connman_service *service,
 			const char *counter_threshold_key,
@@ -2919,6 +2942,20 @@ static void continuous_online_check_log_counter_threshold_met(
 				 counter_description);
 }
 
+/**
+ *  @brief
+ *    Log that an online check success counter has met its threshold.
+ *
+ *  This logs that an online check success counter associated with the
+ *  specified network service has met its threshold.
+ *
+ *  @param[in]  service                A pointer to the immutable
+ *                                     network service for which to
+ *                                     log that its online check
+ *                                     success counter has met its
+ *                                     threshold.
+ *
+ */
 static void continuous_online_check_log_successes_threshold_met(
 			const struct connman_service *service
 )
@@ -2933,6 +2970,20 @@ static void continuous_online_check_log_successes_threshold_met(
 		counter_description);
 }
 
+/**
+ *  @brief
+ *    Log that an online check failure counter has met its threshold.
+ *
+ *  This logs that an online check failure counter associated with the
+ *  specified network service has met its threshold.
+ *
+ *  @param[in]  service                A pointer to the immutable
+ *                                     network service for which to
+ *                                     log that its online check
+ *                                     failure counter has met its
+ *                                     threshold.
+ *
+ */
 static void continuous_online_check_log_failures_threshold_met(
 			const struct connman_service *service
 )
-- 
2.42.0

