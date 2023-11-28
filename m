Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA15D900
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 87F3273128
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 15:35:06 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 375AB73147
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 15:35:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] service: Const-qualify 'service' param in '*_nameserver_{add,del}_routes'
Date: Tue, 28 Nov 2023 12:35:04 -0800
Message-ID: <20231128203504.1194193-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the network service arguments of
'__connman_service_nameserver_{add,del}_routes' to make it clear to
the compiler, static analyzers, and human readers that the functions
have no network service mutation side effects.
---
 src/connman.h | 4 ++--
 src/service.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index ae04cd9a26c6..4d596f7e6585 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -779,9 +779,9 @@ int __connman_service_nameserver_append(struct connman_service *service,
 int __connman_service_nameserver_remove(struct connman_service *service,
 				const char *nameserver, bool is_auto);
 void __connman_service_nameserver_clear(struct connman_service *service);
-void __connman_service_nameserver_add_routes(struct connman_service *service,
+void __connman_service_nameserver_add_routes(const struct connman_service *service,
 						const char *gw);
-void __connman_service_nameserver_del_routes(struct connman_service *service,
+void __connman_service_nameserver_del_routes(const struct connman_service *service,
 					enum connman_ipconfig_type type);
 void __connman_service_set_timeservers(struct connman_service *service,
 						char **timeservers);
diff --git a/src/service.c b/src/service.c
index d6a55d043bd1..16b561f48a41 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1410,7 +1410,7 @@ static void nameserver_del_routes(int index, char **nameservers,
 	}
 }
 
-void __connman_service_nameserver_add_routes(struct connman_service *service,
+void __connman_service_nameserver_add_routes(const struct connman_service *service,
 						const char *gw)
 {
 	int index;
@@ -1438,7 +1438,7 @@ void __connman_service_nameserver_add_routes(struct connman_service *service,
 	}
 }
 
-void __connman_service_nameserver_del_routes(struct connman_service *service,
+void __connman_service_nameserver_del_routes(const struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
 	int index;
-- 
2.42.0

