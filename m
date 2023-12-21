Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B5BA39
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CECCF73248
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:24 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9130C7326B
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 41/60] service: Document 'online_check_log_success'.
Date: Wed, 20 Dec 2023 22:39:45 -0800
Message-ID: <20231221064007.2347566-42-gerickson@nuovations.com>
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

This adds documentation to the 'online_check_log_success' function.
---
 src/service.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/service.c b/src/service.c
index 9d27a5692034..029d7b8b6122 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2871,6 +2871,20 @@ static void online_check_counter_increment_and_log(
 		counter_description, *counter);
 }
 
+/**
+ *  @brief
+ *    Log an online check success.
+ *
+ *  This logs an online check success for the specified network
+ *  service IP configuration type.
+ *
+ *  @param[in]  service  A pointer to the immutable network
+ *                       service for which to log an online
+ *                       check success.
+ *  @param[in]  type     The IP configuration type for which
+ *                       the online check was successful.
+ *
+ */
 static void online_check_log_success(const struct connman_service *service,
 			enum connman_ipconfig_type type)
 {
-- 
2.42.0

