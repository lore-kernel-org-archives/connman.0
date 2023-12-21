Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91340760A5
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0093A73180
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:22 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B4EB2731A4
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 29/60] service: Document 'online_check_failures_threshold_was_met_set_value'.
Date: Thu, 21 Dec 2023 14:34:36 -0800
Message-ID: <20231221223508.2365510-30-gerickson@nuovations.com>
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
'online_check_failures_threshold_was_met_set_value' function.
---
 src/service.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/service.c b/src/service.c
index e8fc14f1c4ca..b41f29d73d60 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2191,6 +2191,20 @@ static bool online_check_failures_threshold_was_met(
 	return service->online_check_failures_met_threshold;
 }
 
+/**
+ *  @brief
+ *    Set the online check failures threshold state to the specified
+ *    value.
+ *
+ *  @param[in,out]  service  A pointer to the mutable service for which
+ *                           to set the failures threshold state.
+ *  @param[in]      value    The value to set the @a service failures
+ *                           threshold state to.
+ *
+ *  @sa online_check_failures_threshold_was_met_set
+ *  @sa online_check_failures_threshold_was_met_clear
+ *
+ */
 static void online_check_failures_threshold_was_met_set_value(
 			struct connman_service *service, bool value)
 {
-- 
2.42.0

