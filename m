Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A596AB3
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5F51773213
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:57 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 18C8673227
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:57 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 53/60] service: Add @sa documentation reference to 'current_default'.
Date: Wed, 20 Dec 2023 22:17:16 -0800
Message-ID: <20231221061734.2344286-54-gerickson@nuovations.com>
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

This adds an additional @sa ("see also") documentation reference to
'current_default'.
---
 src/service.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/service.c b/src/service.c
index e04e24f5db97..6975b55acaa2 100644
--- a/src/service.c
+++ b/src/service.c
@@ -78,6 +78,7 @@ static unsigned int vpn_autoconnect_id = 0;
  *
  *  @sa connman_service_get_default
  *  @sa connman_service_is_default
+ *  @sa default_changed
  *
  */
 static struct connman_service *current_default = NULL;
-- 
2.42.0

