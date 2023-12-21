Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBDBE4D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 20D6173202
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:14 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CD5C07321D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:13 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 14/60] service: Add an explicit conditional for IPv6 in 'reschedule_online_check'.
Date: Wed, 20 Dec 2023 22:39:18 -0800
Message-ID: <20231221064007.2347566-15-gerickson@nuovations.com>
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

This adds an explicit conditional check for the 'type' parameter
against 'CONNMAN_IPCONFIG_TYPE_IPV6' to ensure that neither
'CONNMAN_IPCONFIG_TYPE_ALL' or 'CONNMAN_IPCONFIG_TYPE_UNKNOWN'
reschedule an IPv6 online check.
---
 src/service.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index b35a4dad1f29..0e25d4879d77 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2293,8 +2293,10 @@ static void reschedule_online_check(struct connman_service *service,
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		redo_func = redo_wispr_ipv4;
-	else
+	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
 		redo_func = redo_wispr_ipv6;
+	else
+		return;
 
 	DBG("updating online checkout timeout period");
 
-- 
2.42.0

