Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5131740
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0F55E730FB
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 12:40:28 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B24397310A
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 12:40:27 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 1/3] service: Leverage 'connman_service_is_default'.
Date: Fri, 24 Nov 2023 09:40:23 -0800
Message-ID: <20231124174025.971512-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124174025.971512-1-gerickson@nuovations.com>
References: <20231116030912.636756-1-gerickson@nuovations.com>
 <20231124174025.971512-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages the recently-added 'connman_service_is_default' in
'address_updated' rather than duplicating the same logic from the former
in the latter.
---
 src/service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index dd50b81a7e5a..b98ec00f808c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2239,7 +2239,7 @@ static void address_updated(struct connman_service *service,
 			enum connman_ipconfig_type type)
 {
 	if (is_connected(service->state) &&
-			service == connman_service_get_default()) {
+			connman_service_is_default(service)) {
 		nameserver_remove_all(service, type);
 		nameserver_add_all(service, type);
 		start_online_check(service, type);
-- 
2.42.0

