Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E662C87A
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 70D2A73243
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 14:09:06 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3971273255
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 14:09:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] service: Add DBG statement to 'start_wispr_if_connected'.
Message-Id: <91BE5C97-387C-4DF5-A576-BA67CA479688@nuovations.com>
Date: Mon, 6 Nov 2023 11:09:05 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a DBG statement to 'start_wispr_if_connected' to aid in
debugging and correlating WISPr online checks in flight in a multi-
technology environment with "EnableOnlineToReadyTransition" asserted.
---
 src/service.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/service.c b/src/service.c
index 06e220f8..13e22c30 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1870,6 +1870,10 @@ redo_func:
  */
 static void start_wispr_if_connected(struct connman_service *service)
 {
+	DBG("service %p (%s) maybe start WISPr",
+		service,
+		connman_service_get_identifier(service));
+
 	if (!connman_setting_get_bool("EnableOnlineCheck")) {
 		connman_info("Online check disabled. "
 			"Default service remains in READY state.");
-- 
2.42.0
