Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604763A4
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7109873154
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 22:09:15 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2203F731F6
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 22:09:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] service: Add DBG statement to 'address_updated'.
Date: Wed, 15 Nov 2023 19:09:11 -0800
Message-ID: <20231116030912.636756-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116030912.636756-1-gerickson@nuovations.com>
References: <20231116030912.636756-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a DBG statement to 'address_upated' to aid in debugging.
---
 src/service.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/service.c b/src/service.c
index 90ed111fc035..f0e8364ee77b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2018,6 +2018,11 @@ void __connman_service_wispr_start(struct connman_service *service,
 static void address_updated(struct connman_service *service,
 			enum connman_ipconfig_type type)
 {
+	DBG("service %p (%s) type %d (%s)",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type));
+
 	if (is_connected(service->state) &&
 			connman_service_is_default(service)) {
 		nameserver_remove_all(service, type);
-- 
2.42.0

