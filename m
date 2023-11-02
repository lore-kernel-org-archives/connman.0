Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DE1854
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5485473171
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:19:49 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1847073208
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:19:49 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 1/6] Log the service identifer in service_free.
Date: Wed, 1 Nov 2023 20:19:47 -0700
References: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
Message-Id: <E03C85B8-5C19-40B8-9C54-38B6529535CD@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This logs the service identifier to aid in more quickly identifying
the service being deallocated during debugging.
---
 src/service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 0e4480c1..1c2277ba 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5088,7 +5088,7 @@ static void service_free(gpointer user_data)
 	struct connman_service *service = user_data;
 	char *path = service->path;
 
-	DBG("service %p", service);
+	DBG("service %p (%s)", service, connman_service_get_identifier(service));
 
 	reply_pending(service, ENOENT);
 
-- 
2.42.0

