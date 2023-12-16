Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B5512B95
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9765973128
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:27 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 510C07314E
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:27 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 05/11] wispr: Update 'DBG' in '__connman_wispr_start'.
Date: Fri, 15 Dec 2023 22:12:17 -0800
Message-ID: <20231216061223.2199037-6-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216061223.2199037-1-gerickson@nuovations.com>
References: <20231216061223.2199037-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This updates the initial 'DBG' in '__connman_wispr_start' to ensure
there is space after the connect timeout value and the "ms" unit
designation.
---
 src/wispr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index 19af1e7bede2..04229d045cab 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1281,7 +1281,7 @@ int __connman_wispr_start(struct connman_service *service,
 	struct connman_wispr_portal *wispr_portal = NULL;
 	int index, err;
 
-	DBG("service %p (%s) type %d (%s) connect_timeout %ums callback %p",
+	DBG("service %p (%s) type %d (%s) connect_timeout %u ms callback %p",
 		service, connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type),
 		connect_timeout_ms, callback);
-- 
2.42.0

