Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DA71
	for <connman@lists.linux.dev>; Mon, 21 Jun 2021 07:21:05 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 5605450064D;
	Mon, 21 Jun 2021 09:21:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id D29DD5002C0;
	Mon, 21 Jun 2021 09:21:02 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] service: Let PreferredTechnologies overrule connected service sorting
Date: Mon, 21 Jun 2021 09:20:37 +0200
Message-Id: <20210621072036.302-1-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both services are in either READY or ONLINE state ConnMan will
always return either the service in ONLINE state (this is the correct
behavior) or when both services are in ONLINE state service_a
first. PreferredTechnologies is ignored in this case.

For configuration such as

  PreferredTechnologies = ethernet,wifi
  SingleConnectedTechnology = true

ConnMan would almost never sort Ethernet before WiFi, as WiFi is likely
to be in the ONLINE state. Hence the WiFi would stay on forever even
though the Ethernet cable is plugged in (again).

Place the service_compare_preferred() after the service->oder logic as
this is used for split VPN setups which has higher priority in the
sorting.

As we place this call inside the 'is_connected' section where both
service are in either READY or ONLINE state, it overrules the
existing logic where the ONLINE service is preferred over the READY.
---

Just a resend on the new mailing list.

 src/service.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/src/service.c b/src/service.c
index 20917a8923a4..f64ba7031e8c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5316,6 +5316,25 @@ static gint service_compare_vpn(struct connman_service *a,
 	return service_compare(transport, service);
 }
 
+static gint service_compare_preferred(struct connman_service *service_a,
+					struct connman_service *service_b)
+{
+	unsigned int *tech_array;
+	int i;
+
+	tech_array = connman_setting_get_uint_list("PreferredTechnologies");
+	if (tech_array) {
+		for (i = 0; tech_array[i]; i++) {
+			if (tech_array[i] == service_a->type)
+				return -1;
+
+			if (tech_array[i] == service_b->type)
+				return 1;
+		}
+	}
+	return 0;
+}
+
 static gint service_compare(gconstpointer a, gconstpointer b)
 {
 	struct connman_service *service_a = (void *) a;
@@ -5346,6 +5365,10 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 
 		if (service_a->order < service_b->order)
 			return 1;
+
+		rval = service_compare_preferred(service_a, service_b);
+		if (rval)
+			return rval;
 	}
 
 	if (state_a != state_b) {
@@ -5376,20 +5399,11 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 		return 1;
 
 	if (service_a->type != service_b->type) {
-		unsigned int *tech_array;
-		int i;
-
-		tech_array = connman_setting_get_uint_list(
-						"PreferredTechnologies");
-		if (tech_array) {
-			for (i = 0; tech_array[i]; i++) {
-				if (tech_array[i] == service_a->type)
-					return -1;
+		int rval;
 
-				if (tech_array[i] == service_b->type)
-					return 1;
-			}
-		}
+		rval = service_compare_preferred(service_a, service_b);
+		if (rval)
+			return rval;
 
 		if (service_a->type == CONNMAN_SERVICE_TYPE_ETHERNET)
 			return -1;
-- 
2.32.0
