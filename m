Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B110A29
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 916A273180
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:49 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 54AE9731F7
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/4] connection: Rename 'choose_default_gateway'.
Date: Tue, 28 Nov 2023 23:39:45 -0800
Message-ID: <20231129073947.1280705-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129073947.1280705-1-gerickson@nuovations.com>
References: <20231129073947.1280705-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames 'choose_default_gateway' as 'yield_default_gateway'. The
latter more accurately reflects the action of the function which is
determining which of two gateway data should cede or yield the default
gateway and associated routes. The actual "choice" and acquisition of
the default gateway and associated routes happens outside of the
function.
---
 src/connection.c | 77 +++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 8f6a08e12cf3..a8cc6d430467 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1002,53 +1002,62 @@ static void unset_default_gateway(struct gateway_data *data,
 						data->ipv4_config->gateway);
 }
 
-static bool choose_default_gateway(struct gateway_data *data,
-					struct gateway_data *candidate)
+static bool yield_default_gateway(struct gateway_data *activated,
+					struct gateway_data *existing)
 {
-	bool downgraded = false;
+	enum connman_ipconfig_type type;
+	bool yield_activated = false;
 
-	GATEWAY_DATA_DBG("data", data);
-	GATEWAY_DATA_DBG("candidate", candidate);
+	DBG("activated %p existing %p", activated, existing);
+
+	GATEWAY_DATA_DBG("activated", activated);
+	GATEWAY_DATA_DBG("existing", existing);
 
 	/*
 	 * If the current default is not active, then we mark
 	 * this one as default. If the other one is already active
 	 * we mark this one as non default.
 	 */
-	if (data->ipv4_config && candidate->ipv4_config) {
+	if (activated->ipv4_config && existing->ipv4_config) {
+		type = CONNMAN_IPCONFIG_TYPE_IPV4;
 
-		if (!candidate->ipv4_config->active) {
-			DBG("ipv4 downgrading %p", candidate);
-			unset_default_gateway(candidate,
-						CONNMAN_IPCONFIG_TYPE_IPV4);
+		if (!existing->ipv4_config->active) {
+			DBG("ipv4 existing %p yielding default", existing);
+
+			unset_default_gateway(existing, type);
 		}
 
-		if (candidate->ipv4_config->active &&
-				__connman_service_compare(candidate->service,
-							data->service) < 0) {
-			DBG("ipv4 downgrading this %p", data);
-			unset_default_gateway(data, CONNMAN_IPCONFIG_TYPE_IPV4);
-			downgraded = true;
+		if (existing->ipv4_config->active &&
+				__connman_service_compare(existing->service,
+						activated->service) < 0) {
+			DBG("ipv4 activated %p yielding default", activated);
+
+			unset_default_gateway(activated, type);
+
+			yield_activated = true;
 		}
 	}
 
-	if (data->ipv6_config && candidate->ipv6_config) {
-		if (!candidate->ipv6_config->active) {
-			DBG("ipv6 downgrading %p", candidate);
-			unset_default_gateway(candidate,
-						CONNMAN_IPCONFIG_TYPE_IPV6);
+	if (activated->ipv6_config && existing->ipv6_config) {
+		type = CONNMAN_IPCONFIG_TYPE_IPV6;
+		if (!existing->ipv6_config->active) {
+			DBG("ipv6 existing %p yielding default", existing);
+
+			unset_default_gateway(existing, type);
 		}
 
-		if (candidate->ipv6_config->active &&
-			__connman_service_compare(candidate->service,
-						data->service) < 0) {
-			DBG("ipv6 downgrading this %p", data);
-			unset_default_gateway(data, CONNMAN_IPCONFIG_TYPE_IPV6);
-			downgraded = true;
+		if (existing->ipv6_config->active &&
+			__connman_service_compare(existing->service,
+					activated->service) < 0) {
+			DBG("ipv6 activated %p yielding default", activated);
+
+			unset_default_gateway(activated, type);
+
+			yield_activated = true;
 		}
 	}
 
-	return downgraded;
+	return yield_activated;
 }
 
 /**
@@ -1067,7 +1076,7 @@ static bool choose_default_gateway(struct gateway_data *data,
  *                             gateway route which is to be checked
  *                             against existing gateway data.
  *
- *  @sa choose_default_gateway
+ *  @sa yield_default_gateway
  *  @sa connection_newgateway
  *
  */
@@ -1075,7 +1084,7 @@ static void check_default_gateway(struct gateway_data *activated)
 {
 	GHashTableIter iter;
 	gpointer value, key;
-	bool found = false;
+	bool yield_activated = false;
 
 	DBG("activated %p", activated);
 
@@ -1102,14 +1111,14 @@ static void check_default_gateway(struct gateway_data *activated)
 		if (existing == activated)
 			continue;
 
-		found = choose_default_gateway(activated, existing);
-		if (found)
+		yield_activated = yield_default_gateway(activated, existing);
+		if (yield_activated)
 			break;
 	}
 
-	DBG("found %u", found);
+	DBG("yield_activated %u", yield_activated);
 
-	if (!found) {
+	if (!yield_activated) {
 		if (activated->ipv4_config)
 			set_default_gateway(activated,
 				CONNMAN_IPCONFIG_TYPE_IPV4);
-- 
2.42.0

