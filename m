Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0DF328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 531967312C
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:09 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 15B9473147
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 28/90] connection: Change return type of 'unset_default_gateway'.
Date: Wed,  6 Dec 2023 15:49:51 -0800
Message-ID: <20231206235056.322578-29-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206235056.322578-1-gerickson@nuovations.com>
References: <20231206235056.322578-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

From: Grant Erickson <erick205@umn.edu>

This changes the return signature of 'unset_default_gateway' from
'void' to 'int' such that its status can be leveraged for conditional
execution where it is called.
---
 src/connection.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 5091a229b4d1..179649a714bd 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1493,12 +1493,15 @@ static int unset_ipv6_high_priority_default_gateway(
  *                            be attributed.
  *
  *
+ * @returns
+ *   0 if successful; otherwise, < 0 on error.
+ *
  *  @sa mutate_default_gateway
  *  @sa unset_ipv4_default_gateway
  *  @sa unset_ipv6_default_gateway
  *
  */
-static void unset_default_gateway(struct gateway_data *data,
+static int unset_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function)
 {
@@ -1509,7 +1512,7 @@ static void unset_default_gateway(struct gateway_data *data,
 
 	DBG("from %s()", function);
 
-	mutate_default_gateway(data, type, &ops, __func__);
+	return mutate_default_gateway(data, type, &ops, __func__);
 }
 
 /**
-- 
2.42.0

