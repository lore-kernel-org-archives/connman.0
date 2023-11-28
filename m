Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F246BA7
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A6790730C5
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 14:33:51 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 580D2730FB
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 14:33:51 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] network: Const-qualify network leaf getter functions.
Date: Tue, 28 Nov 2023 11:33:48 -0800
Message-ID: <20231128193348.1186889-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the network arguments in network leaf getter and
introspection functions to make it clear to the compiler, static
analyzers, and human readers that the function is strictly a getter or
introspection function with no network mutation side effects.
---
 include/network.h | 4 ++--
 src/connman.h     | 2 +-
 src/network.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/network.h b/include/network.h
index f1a158afce8e..2078509e75bf 100644
--- a/include/network.h
+++ b/include/network.h
@@ -81,8 +81,8 @@ connman_network_ref_debug(struct connman_network *network,
 void connman_network_unref_debug(struct connman_network *network,
 			const char *file, int line, const char *caller);
 
-enum connman_network_type connman_network_get_type(struct connman_network *network);
-const char *connman_network_get_identifier(struct connman_network *network);
+enum connman_network_type connman_network_get_type(const struct connman_network *network);
+const char *connman_network_get_identifier(const struct connman_network *network);
 
 void connman_network_set_index(struct connman_network *network, int index);
 int connman_network_get_index(const struct connman_network *network);
diff --git a/src/connman.h b/src/connman.h
index ae04cd9a26c6..8b900ff185f8 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -623,7 +623,7 @@ int __connman_network_clear_ipconfig(struct connman_network *network,
 int __connman_network_enable_ipconfig(struct connman_network *network,
 				struct connman_ipconfig *ipconfig);
 
-const char *__connman_network_get_type(struct connman_network *network);
+const char *__connman_network_get_type(const struct connman_network *network);
 const char *__connman_network_get_group(struct connman_network *network);
 const char *__connman_network_get_ident(struct connman_network *network);
 bool __connman_network_get_weakness(struct connman_network *network);
diff --git a/src/network.c b/src/network.c
index e5fadd9cea36..3f844f76120d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1333,7 +1333,7 @@ void connman_network_unref_debug(struct connman_network *network,
 	network_destruct(network);
 }
 
-const char *__connman_network_get_type(struct connman_network *network)
+const char *__connman_network_get_type(const struct connman_network *network)
 {
 	return type2string(network->type);
 }
@@ -1345,7 +1345,7 @@ const char *__connman_network_get_type(struct connman_network *network)
  * Get type of network
  */
 enum connman_network_type connman_network_get_type(
-				struct connman_network *network)
+				const struct connman_network *network)
 {
 	return network->type;
 }
@@ -1356,7 +1356,7 @@ enum connman_network_type connman_network_get_type(
  *
  * Get identifier of network
  */
-const char *connman_network_get_identifier(struct connman_network *network)
+const char *connman_network_get_identifier(const struct connman_network *network)
 {
 	return network->identifier;
 }
-- 
2.42.0

