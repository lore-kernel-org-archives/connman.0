Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC21C2CC
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 01CD273106
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 23:59:10 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AC8C373145
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 23:59:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2] service: Leverage 'connman_service_set_proxy_method'.
Date: Wed, 15 Nov 2023 20:59:08 -0800
Message-ID: <20231116045908.638483-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116045404.638187-1-gerickson@nuovations.com>
References: <20231116045404.638187-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Previously, inside 'check_proxy_method', if WPAD failed for any reason
the code would explicitly manipulate the 'proxy' field of the service
object and then invoke '__connman_notifier_proxy_changed'.

However, when 'method' is 'CONNMAN_SERVICE_PROXY_METHOD_DIRECT', which
is the case in 'check_proxy_method', this is 2/3 of what
'connman_service_set_proxy_method' already does. The 1/3  difference is
that 'connman_service_set_proxy_method' calls 'proxy_changed'.

Consequently, since there does not seem to be a well-documented or
compelling reason to avoid the call to 'proxy_changed', simply leverage
and call 'connman_service_set_proxy_method' from 'check_proxy_method' to
set the service proxy method to 'CONNMAN_SERVICE_PROXY_METHOD_DIRECT'
when WPAD fails.
---
 src/service.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 81a1bebdc14b..ac6d8665ccf4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1470,8 +1470,8 @@ static bool check_proxy_setup(struct connman_service *service)
 		return true;
 
 	if (__connman_wpad_start(service) < 0) {
-		service->proxy = CONNMAN_SERVICE_PROXY_METHOD_DIRECT;
-		__connman_notifier_proxy_changed(service);
+		connman_service_set_proxy_method(service,
+			CONNMAN_SERVICE_PROXY_METHOD_DIRECT);
 		return true;
 	}
 
-- 
2.42.0

