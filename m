Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE891400F
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CCDF47312B
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8432A7314B
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 6/9] service: Add 'DBG' to 'add_nameserver_route'.
Date: Sat, 16 Dec 2023 00:28:01 -0800
Message-ID: <20231216082805.2221938-7-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216082805.2221938-1-gerickson@nuovations.com>
References: <20231216082805.2221938-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a 'DBG' statement to 'add_nameserver_route' to match that in
'del_nameserver_route'.
---
 src/service.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/service.c b/src/service.c
index 55eb4d8d757d..e0a11a2bc6a2 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1348,6 +1348,9 @@ void __connman_service_nameserver_clear(struct connman_service *service)
 static void add_nameserver_route(int family, int index, const char *nameserver,
 				const char *gw)
 {
+	DBG("family %d index %d nameserver %s gw %s",
+		family, index, nameserver, gw);
+
 	switch (family) {
 	case AF_INET:
 		if (connman_inet_compare_subnet(index, nameserver))
-- 
2.42.0

