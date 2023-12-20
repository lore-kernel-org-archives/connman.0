Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB260BE4C
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D747C73122
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 21:05:46 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 91D1873147
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 21:05:46 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] timeserver: Add service identifier to 'DBG' in 'ts_reset'.
Date: Tue, 19 Dec 2023 18:05:44 -0800
Message-ID: <20231220020544.2272820-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220020544.2272820-1-gerickson@nuovations.com>
References: <20231220020544.2272820-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds the service identifier to the 'DBG' statement in 'ts_reset'
to aid debugging in a multi-technology environment with
"EnableOnlineToReadyTransition" asserted and for consistency with
other 'DBG' statements in other modules.
---
 src/timeserver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/timeserver.c b/src/timeserver.c
index 3eb718aa1568..d364f72870c8 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -417,7 +417,8 @@ static void ts_set_nameservers(const struct connman_service *service)
  */
 static void ts_reset(struct connman_service *service)
 {
-	DBG("service %p", service);
+	DBG("service %p (%s)",
+		service, connman_service_get_identifier(service));
 
 	if (!resolv)
 		return;
-- 
2.42.0

