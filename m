Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD02FAE
	for <connman@lists.linux.dev>; Thu,  2 Sep 2021 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0abea119-0c00-11ec-96db-005056bdf889;
	Thu, 02 Sep 2021 18:11:26 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/5] vpn: Report EALREADY back to caller if VPN is already disconnecting
Date: Thu,  2 Sep 2021 18:11:20 +0300
Message-Id: <20210902151124.4983-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
References: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of reporting EINVAL report EALREADY to return correct
information back to the caller. This way caller knows that the call was
not to a wrong identifier but the VPN has already been requested to
shut down. The error eventually translates to InProgress D-Bus message
back to the caller.
---
 plugins/vpn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index 387447c3..f72d85ab 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -3,6 +3,7 @@
  *  Connection Manager
  *
  *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2019-2021  Jolla Ltd. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -1026,7 +1027,7 @@ static int disconnect_provider(struct connection_data *data)
 
 	if (data->disconnect_call) {
 		DBG("already disconnecting");
-		return -EINVAL;
+		return -EALREADY;
 	}
 
 	message = dbus_message_new_method_call(VPN_SERVICE, data->path,
-- 
2.20.1

