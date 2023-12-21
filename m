Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6051E4A2
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7CEB0731D1
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3D9ED731FD
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 03/60] service: Rename 'online_check_enabled_check'.
Date: Thu, 21 Dec 2023 14:34:10 -0800
Message-ID: <20231221223508.2365510-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221223508.2365510-1-gerickson@nuovations.com>
References: <20231221223508.2365510-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Since 'online_check_enabled_check' is a predicate function, follow
prevailing function name style for such predicates by adding '_is_' to
the name.
---
 src/service.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index e5cd6fcd306a..87ef3b575b1f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1881,7 +1881,8 @@ static void cancel_online_check(struct connman_service *service,
  *  @sa start_wispr_if_connected
  *
  */
-static bool online_check_enabled_check(const struct connman_service *service)
+static bool online_check_is_enabled_check(
+		const struct connman_service *service)
 {
 	if (!connman_setting_get_bool("EnableOnlineCheck")) {
 		connman_info("Online check disabled. "
@@ -1927,7 +1928,7 @@ static void start_online_check(struct connman_service *service,
 		type,
 		__connman_ipconfig_type2string(type));
 
-	if (!online_check_enabled_check(service))
+	if (!online_check_is_enabled_check(service))
 		return;
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 || check_proxy_setup(service)) {
@@ -2380,7 +2381,7 @@ static void start_wispr_if_connected(struct connman_service *service)
 		service,
 		connman_service_get_identifier(service));
 
-	if (!online_check_enabled_check(service))
+	if (!online_check_is_enabled_check(service))
 		return;
 
 	if (__connman_service_is_connected_state(service,
-- 
2.42.0

