Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79171804D
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EA1957310A
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:17 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A435673154
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 04/17] service: Document service unref calls in 'cancel_online_check'.
Date: Sun, 19 Nov 2023 09:07:00 -0800
Message-ID: <20231119170714.775270-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119170714.775270-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
 <20231119170714.775270-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a comment to the two calls to 'connman_service_unref' in
'cancel_online_check' to help aid present and future readers in
identifying where the balacing reference retain occurs.
---
 src/service.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/service.c b/src/service.c
index 075f3fba5abe..5fb53c2084f9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1590,11 +1590,23 @@ static void cancel_online_check(struct connman_service *service)
 	if (service->online_timeout_ipv4) {
 		g_source_remove(service->online_timeout_ipv4);
 		service->online_timeout_ipv4 = 0;
+
+		/*
+		 * This balances the retained referece made when
+		 * g_timeout_add_seconds was called to schedule this
+		 * now-cancelled scheduled online check.
+		 */
 		connman_service_unref(service);
 	}
 	if (service->online_timeout_ipv6) {
 		g_source_remove(service->online_timeout_ipv6);
 		service->online_timeout_ipv6 = 0;
+
+		/*
+		 * This balances the retained referece made when
+		 * g_timeout_add_seconds was called to schedule this
+		 * now-cancelled scheduled online check.
+		 */
 		connman_service_unref(service);
 	}
 }
-- 
2.42.0

