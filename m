Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342057328
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 01C7173123
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 18:41:33 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:851a:6a54:a980:b9a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AFF7A7314B
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 18:41:32 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/4] service: Const-qualify 'lookup_gateway_data'.
Date: Thu,  7 Dec 2023 15:41:28 -0800
Message-ID: <20231207234130.1093617-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207234130.1093617-1-gerickson@nuovations.com>
References: <20231207234130.1093617-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the gateway configuration argument of
'lookup_gateway_data' to make it clear to the compiler, static
analyzers, and human readers that the function is strictly a getter
with no gateway configuration mutation side effects.
---
 src/connection.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/connection.c b/src/connection.c
index c74dd0741995..c42988bf337d 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -216,7 +216,8 @@ static struct gateway_config *find_gateway(int index, const char *gateway)
 	return NULL;
 }
 
-static struct gateway_data *lookup_gateway_data(struct gateway_config *config)
+static struct gateway_data *lookup_gateway_data(
+				const struct gateway_config *config)
 {
 	GHashTableIter iter;
 	gpointer value, key;
-- 
2.42.0

