Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD9320C
	for <connman@lists.linux.dev>; Tue,  5 Apr 2022 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 0f44ef24-b4ed-11ec-877a-005056bdfda7;
	Tue, 05 Apr 2022 17:31:19 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/4] ofono: Do not change regdom when it follows timezone
Date: Tue,  5 Apr 2022 17:31:16 +0300
Message-Id: <20220405143116.2272080-5-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405143116.2272080-1-jussi.laakkonen@jolla.com>
References: <20220405143116.2272080-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/ofono.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index f0bd3c5d..8bb53949 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -40,6 +40,7 @@
 #include <connman/dbus.h>
 #include <connman/log.h>
 #include <connman/technology.h>
+#include <connman/setting.h>
 
 #include "mcc.h"
 
@@ -1710,6 +1711,10 @@ static void netreg_update_regdom(struct modem_data *modem,
 	char *alpha2;
 	int mcc;
 
+	/* Do not change regdom here if it is set to follow timezone. */
+	if (connman_setting_get_bool("RegdomFollowsTimezone"))
+		return;
+
 	dbus_message_iter_get_basic(value, &mobile_country_code);
 
 	DBG("%s MobileContryCode %s", modem->path, mobile_country_code);
-- 
2.30.2

