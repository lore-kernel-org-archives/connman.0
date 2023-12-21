Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8414262
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D831173123
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 02:33:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9ACEA73171
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 02:33:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] service: Make log output of 'online_check_is_enabled_check' consistent.
Date: Wed, 20 Dec 2023 23:33:05 -0800
Message-ID: <20231221073307.2361429-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221073307.2361429-1-gerickson@nuovations.com>
References: <20231221073307.2361429-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This makes the info-level log output of
'online_check_is_enabled_check' consistent with other messages using
the format of:

    ... [Ii]nterface <interface name> [ <service type> ] ...

to achieve:

    Online check disabled; interface wlan0 [ wifi ] remains in ready
    state.
---
 src/service.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 99b322a91684..d3bd1fe83b37 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2195,9 +2195,17 @@ static void cancel_online_check(struct connman_service *service,
 static bool online_check_is_enabled_check(
 		const struct connman_service *service)
 {
+	g_autofree char *interface = NULL;
+
 	if (!__connman_service_is_online_check_enabled()) {
-		connman_info("Online check disabled. "
-			"Default service remains in READY state.");
+		interface = connman_service_get_interface(service);
+
+		connman_info("Online check disabled; "
+			"interface %s [ %s ] remains in %s state.",
+			interface,
+			__connman_service_type2string(service->type),
+			state2string(CONNMAN_SERVICE_STATE_READY));
+
 		return false;
 	}
 
-- 
2.42.0

