Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DB173
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 07:21:37 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id E2DBC50064D;
	Wed, 23 Jun 2021 09:21:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 4E0C3500412;
	Wed, 23 Jun 2021 09:21:34 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Carsten Haitzler <raster@rasterman.com>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH] service: Ask for password when using native autoconnect
Date: Wed, 23 Jun 2021 09:21:30 +0200
Message-Id: <20210623072130.29852-1-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the native mode is activated we still need to ask for the
password if it's unknown.

Fixes: 561f318003c1 ("service: Teach autoconnect algorithm native mode")
---

Hi Carsten,

Sorry it took so long. There were some fallouts from recent gcc
warnings I had to look after first. Anyway, this patch fixed the
problem you reported for me. Please, let me know if there is still a
problem after this patch.

Thanks,
Daniel

 src/service.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 20917a8923a4..eb74a85d6e32 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6756,7 +6756,8 @@ int __connman_service_connect(struct connman_service *service,
 				service->provider)
 			connman_provider_disconnect(service->provider);
 
-	if (service->connect_reason == CONNMAN_SERVICE_CONNECT_REASON_USER) {
+	if (reason == CONNMAN_SERVICE_CONNECT_REASON_USER ||
+			reason == CONNMAN_SERVICE_CONNECT_REASON_NATIVE) {
 		if (err == -ENOKEY || err == -EPERM) {
 			DBusMessage *pending = NULL;
 			const char *dbus_sender = get_dbus_sender(service);
-- 
2.32.0
