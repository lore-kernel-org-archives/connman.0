Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AB328C6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 18C6C73145
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:10 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D03A473154
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 30/90] connection: Change return type of 'set_default_gateway'.
Date: Wed,  6 Dec 2023 15:49:53 -0800
Message-ID: <20231206235056.322578-31-gerickson@nuovations.com>
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

This changes the return signature of 'set_default_gateway' from
'void' to 'int' such that its status can be leveraged for conditional
execution where it is called.
---
 src/connection.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 702e08dbe37c..2a21e476bc53 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1371,12 +1371,15 @@ done:
  *                            which the call to this function should
  *                            be attributed.
  *
+ * @returns
+ *   0 if successful; otherwise, < 0 on error.
+ *
  *  @sa mutate_default_gateway
  *  @sa set_ipv4_high_priority_default_gateway
  *  @sa set_ipv6_high_priority_default_gateway
  *
  */
-static void set_default_gateway(struct gateway_data *data,
+static int set_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function)
 {
@@ -1390,9 +1393,12 @@ static void set_default_gateway(struct gateway_data *data,
 
 	status = mutate_default_gateway(data, type, &ops, __func__);
 	if (status < 0)
-		return;
+		goto done;
 
 	__connman_service_indicate_default(data->service);
+
+done:
+	return status;
 }
 
 static int unset_ipv4_high_priority_default_gateway(
-- 
2.42.0

