Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E51642B
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0369373203
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:24 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B843B7321A
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 34/60] service: Document 'online_check_counters_log'.
Date: Thu, 21 Dec 2023 14:34:41 -0800
Message-ID: <20231221223508.2365510-35-gerickson@nuovations.com>
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

This adds documentation to the 'online_check_counters_log' function.
---
 src/service.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/service.c b/src/service.c
index 5dfada3af3f5..e6652f53363c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2335,6 +2335,26 @@ static void online_check_state_reset(struct connman_service *service)
 	clear_error(service);
 }
 
+/**
+ *  @brief
+ *    Log the specified IPv4 and IPv6 online check counters for the
+ *    specified service.
+ *
+ *  This logs the specified IPv4 and IPv6 online check counters
+ *  described by the provided description for the specified network
+ *  service.
+ *
+ *  @param[in]  service              A pointer to the immutable network
+ *                                   service associated with @a
+ *                                   ipv4_counter and @a ipv6_counter.
+ *  @param[in]  counter_description  A pointer to a null-terminated C
+ *                                   string describing @a ipv4_counter
+ *                                   and @a ipv6_counter. For example,
+ *                                   "failure".
+ *  @param[in]  ipv4_counter         The IPv4-specific counter to log.
+ *  @param[in]  ipv6_counter         The IPv6-specific counter to log.
+ *
+ */
 static void online_check_counters_log(
 			const struct connman_service *service,
 			const char *counter_description,
-- 
2.42.0

