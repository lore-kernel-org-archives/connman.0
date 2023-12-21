Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D0BA39
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id F00EB73145
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:27 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B0F7873159
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:27 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 49/60] service: Document 'downgrade_connected_services'.
Date: Wed, 20 Dec 2023 22:39:53 -0800
Message-ID: <20231221064007.2347566-50-gerickson@nuovations.com>
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

This adds documentation to the 'downgrade_connected_services'
functions.
---
 src/service.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/service.c b/src/service.c
index cae4258fca7f..efed2fc50ac9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -8709,6 +8709,19 @@ static void request_input_cb(struct connman_service *service,
 	}
 }
 
+/**
+ *  @brief
+ *    Downgrade the service IPv4 and IPv6 states from "online" to
+ *    "ready" of all connected services.
+ *
+ *  This attempts to downgrade the IPv4 and IPv6 states of all
+ *  @a is_connected services to "ready" if they are "online".
+ *
+ *  @sa service_ipconfig_downgrade_online_state
+ *  @sa service_downgrade_online_state
+ *  @sa service_downgrade_online_state_if_default
+ *
+ */
 static void downgrade_connected_services(void)
 {
 	struct connman_service *up_service;
-- 
2.42.0

