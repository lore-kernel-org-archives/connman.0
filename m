Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE6BE49
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 976FA730B4
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:27 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4AE9573256
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:27 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 48/60] service: Document interval assignment in '__connman_service_wispr_start'.
Date: Wed, 20 Dec 2023 22:39:52 -0800
Message-ID: <20231221064007.2347566-49-gerickson@nuovations.com>
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

This adds a comment documenting the rationale for setting the check
interval to the initial interval in '__connman_service_wispr_start'.
---
 src/service.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/service.c b/src/service.c
index b1fb6a3e532a..cae4258fca7f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -3832,6 +3832,11 @@ int __connman_service_wispr_start(struct connman_service *service,
 	if (online_check_is_active(service, type))
 		return -EALREADY;
 
+	/*
+	 * At this particular entry point, we assume to be starting an
+	 * "online" HTTP-based Internet reachability check
+	 * afresh. Consequently, set the check interval to initial.
+	 */
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		service->online_check_state_ipv4.interval =
 					online_check_initial_interval;
-- 
2.42.0

