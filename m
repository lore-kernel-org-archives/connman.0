Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284C23775
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jolla.com
Received: from localhost.localdomain (88-113-60-79.elisa-laajakaista.fi [88.113.60.79])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 511ba8b9-a0e1-11ee-b3cf-005056bd6ce9;
	Fri, 22 Dec 2023 17:46:48 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] device: Setup regdom when powering up to maintain consistency
Date: Fri, 22 Dec 2023 17:46:44 +0200
Message-Id: <20231222154645.278128-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
References: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the regdom has been set for the technology or for all the
technologies as a global setting apply it when powering up a device that
supports changing regdom. Otherwise the changes made to regdom may not
have been propagated to the device if the change has been made when the
device was powered off, for instance.
---
 src/device.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/device.c b/src/device.c
index 264c5e2d..55670099 100644
--- a/src/device.c
+++ b/src/device.c
@@ -589,6 +589,7 @@ int connman_device_set_powered(struct connman_device *device,
 {
 	struct connman_device_scan_params params;
 	enum connman_service_type type;
+	const char *alpha2;
 	int i;
 
 	DBG("device %p powered %d", device, powered);
@@ -607,6 +608,16 @@ int connman_device_set_powered(struct connman_device *device,
 	if (!device->powered) {
 		__connman_technology_disabled(type);
 		return 0;
+	} else {
+		/*
+		 * Check if the technology has regdom set and apply it for the
+		 * device. Regdom may have been changed when the device was
+		 * powered off and, thus, the new regdom has not been applied
+		 * here.
+		 */
+		alpha2 = __connman_technology_get_regdom(type);
+		if (alpha2)
+			connman_device_set_regdom(device, alpha2);
 	}
 
 	__connman_technology_enabled(type);
-- 
2.30.2

