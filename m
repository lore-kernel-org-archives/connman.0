Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C55A109
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2811873145
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 16:19:35 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D1D1C731D1
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 16:19:34 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] service: Const-qualify 'connman_service_get_interface'.
Date: Fri, 17 Nov 2023 13:19:29 -0800
Message-ID: <20231117211929.705335-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the network service argument to make it clear to the
compiler, static analyzers, and human readers that the function is
strictly a getter with no network service mutation side effects.
---
 include/service.h     | 2 +-
 src/service.c         | 2 +-
 tools/iptables-unit.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/service.h b/include/service.h
index e45d7b58da7d..69f93574bafb 100644
--- a/include/service.h
+++ b/include/service.h
@@ -116,7 +116,7 @@ void connman_service_unref_debug(struct connman_service *service,
 
 enum connman_service_type connman_service_get_type(const struct connman_service *service);
 enum connman_service_state connman_service_get_state(const struct connman_service *service);
-char *connman_service_get_interface(struct connman_service *service);
+char *connman_service_get_interface(const struct connman_service *service);
 
 const char *connman_service_get_identifier(const struct connman_service *service);
 const char *connman_service_get_domainname(const struct connman_service *service);
diff --git a/src/service.c b/src/service.c
index 81a1bebdc14b..a94d14652eb2 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6196,7 +6196,7 @@ enum connman_service_type connman_service_get_type(const struct connman_service
  *
  * Get network interface of service
  */
-char *connman_service_get_interface(struct connman_service *service)
+char *connman_service_get_interface(const struct connman_service *service)
 {
 	int index;
 
diff --git a/tools/iptables-unit.c b/tools/iptables-unit.c
index b91591f23e7f..d490b87d80ca 100644
--- a/tools/iptables-unit.c
+++ b/tools/iptables-unit.c
@@ -624,7 +624,7 @@ struct connman_service {
 	char *dummy;
 };
 
-char *connman_service_get_interface(struct connman_service *service)
+char *connman_service_get_interface(const struct connman_service *service)
 {
 	return "eth0";
 }
-- 
2.42.0

