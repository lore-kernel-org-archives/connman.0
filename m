Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418B20F5
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6ABEE73146
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 21:16:55 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2AAED73154
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 21:16:55 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] service: Both cancel and stop online checks where appropriate.
Date: Thu, 14 Dec 2023 18:16:53 -0800
Message-ID: <20231215021653.2156275-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215021653.2156275-1-gerickson@nuovations.com>
References: <20231215021653.2156275-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This both cancels, via 'cancel_online_check', and stops, via
'__connman_wispr_stop' online checks on service disconnect or
free. The former terminates any in-flight or recurring check activity
in service.c and the latter terminates the same in wispr.c.

Failure to cancel as well as stop can lead to a use-after-free fault
in one-shot or continuous online check mode when a latent online check
reschedule timer fires after the service has been disconnected or
deallocated.
---
 src/service.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/service.c b/src/service.c
index 6f816ac7af01..020e43fa4038 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6014,7 +6014,10 @@ static void service_free(gpointer user_data)
 	__connman_notifier_service_remove(service);
 	service_schedule_removed(service);
 
+	cancel_online_check(service, CONNMAN_IPCONFIG_TYPE_ALL);
+
 	__connman_wispr_stop(service);
+
 	stats_stop(service);
 
 	service->path = NULL;
@@ -7193,6 +7196,8 @@ static int service_indicate_state(struct connman_service *service)
 
 		default_changed();
 
+		cancel_online_check(service, CONNMAN_IPCONFIG_TYPE_ALL);
+
 		__connman_wispr_stop(service);
 
 		__connman_wpad_stop(service);
-- 
2.42.0

