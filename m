Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5213FF8
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6367273128
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1B8BA73146
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/9] service: Const-qualify 'add_nameserver_route'.
Date: Sat, 16 Dec 2023 00:28:00 -0800
Message-ID: <20231216082805.2221938-6-gerickson@nuovations.com>
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

Const-qualify the nameserver argument of 'add_nameserver_route' to
make it clear to the compiler, static analyzers, and human readers
that the function is strictly a getter with no nameserver argument
mutation side effects.
---
 src/service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 1f227a2e0125..55eb4d8d757d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1345,7 +1345,7 @@ void __connman_service_nameserver_clear(struct connman_service *service)
 	nameserver_add_all(service, CONNMAN_IPCONFIG_TYPE_ALL);
 }
 
-static void add_nameserver_route(int family, int index, char *nameserver,
+static void add_nameserver_route(int family, int index, const char *nameserver,
 				const char *gw)
 {
 	switch (family) {
-- 
2.42.0

