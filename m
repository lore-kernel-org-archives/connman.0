Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829D7D8B0
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DF57673122
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 15:00:03 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f04b:507e:d663:adf2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9058173128
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 15:00:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] connection: Rename 'connection.c' to 'gateway.c'.
Date: Wed, 13 Dec 2023 11:59:59 -0800
Message-ID: <20231213200001.1994492-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213200001.1994492-1-gerickson@nuovations.com>
References: <20231213200001.1994492-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

While historically, "connection.c" might have been a contextually-apt
name, today it might be better named "gateway.c" since its primary
focus is gateway routes and gateway route management.

Reflective of that, this renames "connection.c" to "gateway.c".
---
 Makefile.am                     | 2 +-
 src/{connection.c => gateway.c} | 0
 src/inet.c                      | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename src/{connection.c => gateway.c} (100%)

diff --git a/Makefile.am b/Makefile.am
index 169b4bc66bd5..fad129c81b47 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -117,7 +117,7 @@ src_connmand_SOURCES = $(gdhcp_sources) $(gweb_sources) $(stats_sources) \
 			$(backtrace_sources) $(builtin_sources) $(shared_sources) \
 			src/connman.ver src/main.c src/connman.h src/log.c \
 			src/error.c src/plugin.c src/task.c \
-			src/device.c src/network.c src/connection.c \
+			src/device.c src/network.c src/gateway.c \
 			src/manager.c src/service.c \
 			src/clock.c src/timezone.c src/agent-connman.c \
 			src/agent.c src/notifier.c src/provider.c \
diff --git a/src/connection.c b/src/gateway.c
similarity index 100%
rename from src/connection.c
rename to src/gateway.c
diff --git a/src/inet.c b/src/inet.c
index 31596a76a140..779ed7b2b995 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -3079,7 +3079,7 @@ bool connman_inet_is_ipv6_supported()
  * connmand and vpnd use inet.c, getting the route is via ipconfig and ipconfig
  * is different for both. Gateway is left here for possible future use.
  *
- * Gateway can be NULL and connection.c then assigns 0.0.0.0 address or ::,
+ * Gateway can be NULL and gateway.c then assigns 0.0.0.0 address or ::,
  * depending on IP family.
  */
 bool connman_inet_is_default_route(int family, const char *host,
-- 
2.42.0

