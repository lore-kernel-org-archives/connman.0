Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BE17986
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8A26773118
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 16:49:30 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3E09E73145
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 16:49:30 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] service: Document the 'current_default' global.
Date: Fri, 17 Nov 2023 13:49:23 -0800
Message-ID: <20231117214923.706301-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This documents the 'current_default' global and includes "see also"
references to related functions.
---
 src/service.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/service.c b/src/service.c
index 81a1bebdc14b..8562be99f6bf 100644
--- a/src/service.c
+++ b/src/service.c
@@ -55,6 +55,15 @@ static GHashTable *passphrase_requested = NULL;
 static GSList *counter_list = NULL;
 static unsigned int autoconnect_id = 0;
 static unsigned int vpn_autoconnect_id = 0;
+/**
+ *  A weak reference to the current default service (that is, has the
+ *  default route) used to compare against another service when the
+ *  default service has potentially changed.
+ *
+ *  @sa connman_service_get_default
+ *  @sa connman_service_is_default
+ *
+ */
 static struct connman_service *current_default = NULL;
 static bool services_dirty = false;
 static bool enable_online_to_ready_transition = false;
-- 
2.42.0

