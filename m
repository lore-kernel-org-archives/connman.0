Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECDB66F
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 34D1373207
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:29 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E9A6473236
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:28 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 47/60] service: Document the internals of 'service_compare'.
Date: Thu, 21 Dec 2023 14:34:54 -0800
Message-ID: <20231221223508.2365510-48-gerickson@nuovations.com>
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

This documents the major internal comparison blocks of the
'service_compare' function.
---
 src/service.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/src/service.c b/src/service.c
index c376b559e915..b1fb6a3e532a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7972,8 +7972,21 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 	a_connected = is_connected(state_a);
 	b_connected = is_connected(state_b);
 
+	/*
+	 * If both services are connected (that is, "ready" or "online"),
+	 * then further sort by whether the services are VPN type, then
+	 * service order if there is VPN equivalence, and then by their
+	 * preferred technology status.
+	 */
 	if (a_connected && b_connected) {
 		int rval;
+
+		/*
+		 * If at this point the services are still comparing as
+		 * equivalent, then use online check failure status, giving
+		 * priority to the service that has not met the failure
+		 * threshold.
+		 */
 		if (!online_check_failures_threshold_was_met(service_a) &&
 			online_check_failures_threshold_was_met(service_b)) {
 			return -1;
@@ -8004,6 +8017,15 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 			return rval;
 	}
 
+	/*
+	 * If at this point the services are still comparing as
+	 * equilvalent, then check whether their combined states are
+	 * different. If they are, then prefer the service that is
+	 * "online" to that which is only "ready", then prefer @a a being
+	 * connected versus @a b being connected, and, finally, then
+	 * prefer @a a being in the process of connecting to @a b being in
+	 * the process of connecting.
+	 */
 	if (state_a != state_b) {
 		if (a_connected && b_connected) {
 			/* We prefer online over ready state */
@@ -8025,12 +8047,26 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 			return 1;
 	}
 
+	/*
+	 * If at this point the services are still comparing as
+	 * equivalent, then use favorite status, giving priority to @a a
+	 * as a favorite versus @a b as a favorite.
+	 */
 	if (service_a->favorite && !service_b->favorite)
 		return -1;
 
 	if (!service_a->favorite && service_b->favorite)
 		return 1;
 
+	/*
+	 * If at this point the services are still comparing as
+	 * equivalent, then check whether their types are different. If
+	 * they are, then compare their types. First, against the
+	 * PreferredTechnologies priority list and then by an internal
+	 * prioritization favoring Ethernet over Wi-Fi, Wi-Fi over
+	 * Cellular, Cellular over Bluetooth, Bluetooth over VPN, and VPN
+	 * over Gadget (that is, USB Ethernet).
+	 */
 	if (service_a->type != service_b->type) {
 		int rval;
 
@@ -8069,10 +8105,18 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 			return 1;
 	}
 
+	/*
+	 * If at this point the services are still comparing as
+	 * equivalent, then check their strengths.
+	 */
 	strength = (gint) service_b->strength - (gint) service_a->strength;
 	if (strength)
 		return strength;
 
+	/*
+	 * Finally, if at this point the services are still comparing as
+	 * equivalent, then check their names.
+	 */
 	return g_strcmp0(service_a->name, service_b->name);
 }
 
-- 
2.42.0

