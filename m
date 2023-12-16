Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644612B79
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id BF3697310B
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:26 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 82B5873145
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:26 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 03/11] wispr: Expand 'DBG' in 'wispr_portal_detect'.
Date: Fri, 15 Dec 2023 22:12:15 -0800
Message-ID: <20231216061223.2199037-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216061223.2199037-1-gerickson@nuovations.com>
References: <20231216061223.2199037-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This includes both the network interface index and name in the 'DBG'
in 'wispr_portal_detect' to make it easier to identify on which
network interface the WISPr portal detection is being made.
---
 src/wispr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 9cd1e7db501d..ba774a62dd48 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1104,8 +1104,6 @@ static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context,
 	if (!interface)
 		return -EINVAL;
 
-	DBG("interface %s", interface);
-
 	if_index = connman_inet_ifindex(interface);
 	if (if_index < 0) {
 		DBG("Could not get ifindex");
@@ -1113,6 +1111,8 @@ static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context,
 		goto done;
 	}
 
+	DBG("index %d (%s)", if_index, interface);
+
 	nameservers = connman_service_get_nameservers(wp_context->service);
 	if (!nameservers) {
 		DBG("Could not get nameservers");
-- 
2.42.0

