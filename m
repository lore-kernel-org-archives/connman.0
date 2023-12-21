Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531B1E4A2
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 943AB73144
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:21 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 53C9C7314E
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 28/60] service: Document 'online_check_failures_threshold_was_met'.
Date: Thu, 21 Dec 2023 14:34:35 -0800
Message-ID: <20231221223508.2365510-29-gerickson@nuovations.com>
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
'online_check_failures_threshold_was_met' function.
---
 src/service.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/service.c b/src/service.c
index 15a79c0aa5c8..e8fc14f1c4ca 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2168,6 +2168,23 @@ done:
 	return status;
 }
 
+/**
+ *  @brief
+ *    Return the online check failures threshold state.
+ *
+ *  @param[in]  service  A pointer to the immutable service for which
+ *                       to return the online check failures threshold
+ *                       state.
+ *
+ *  @returns
+ *    True if the online check failures threshold was met; otherwise,
+ *    false.
+ *
+ *  @sa online_check_failures_threshold_was_met_set_value
+ *  @sa online_check_failures_threshold_was_met_set
+ *  @sa online_check_failures_threshold_was_met_clear
+ *
+ */
 static bool online_check_failures_threshold_was_met(
 			const struct connman_service *service)
 {
-- 
2.42.0

