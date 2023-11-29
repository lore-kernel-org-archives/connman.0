Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45504CB5D
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9C0DD730F3
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:38:03 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 47E8773150
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:38:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] connection: Explicitly handle CONNMAN_IPCONFIG_TYPE_ALL.
Date: Wed, 29 Nov 2023 15:38:01 -0800
Message-ID: <20231129233801.1313129-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

At commit 89f70d225df6 ("ipconfig: Define unique value for
CONNMAN_IPCONFIG_TYPE_ALL"), a unique enumertion value was provided
for 'CONNMAN_IPCONFIG_TYPE_ALL' to make it semantically different from
'CONNMAN_IPCONFIG_TYPE_UNKNOWN'.

However, with that change, the connection module was never updated to
explicitly treat 'CONNMAN_IPCONFIG_TYPE_ALL' as a synonym for
'CONNMAN_IPCONFIG_TYPE_IPV4' + 'CONNMAN_IPCONFIG_TYPE_IPV6' and to
treat 'CONNMAN_IPCONFIG_TYPE_UNKNOWN' as an error.

This makes those changes, treating 'CONNMAN_IPCONFIG_TYPE_ALL' as such
a synonym and 'CONNMAN_IPCONFIG_TYPE_UNKNOWN' as an error.
---
 src/connection.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 91ce39adc167..2d9e259c2d28 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -627,8 +627,10 @@ static int del_gateway_routes(struct gateway_data *data,
 		do_ipv4 = true;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
 		do_ipv6 = true;
-	else
+	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
 		do_ipv4 = do_ipv6 = true;
+	else
+		return -EINVAL;
 
 	if (do_ipv4 && data->ipv4_config) {
 		if (data->ipv4_config->vpn) {
@@ -711,6 +713,12 @@ static int del_gateway_routes_if_active(struct gateway_data *data,
 {
 	bool active = false;
 
+	DBG("data %p type %d (%s)", data,
+		type, __connman_ipconfig_type2string(type));
+
+	if (!data || type == CONNMAN_IPCONFIG_TYPE_UNKNOWN)
+		return -EINVAL;
+
 	GATEWAY_DATA_DBG("data", data);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
@@ -719,7 +727,7 @@ static int del_gateway_routes_if_active(struct gateway_data *data,
 	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 		if (data->ipv6_config)
 			active = data->ipv6_config->active;
-	} else
+	} else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
 		active = true;
 
 	DBG("type %d active %d", type, active);
@@ -871,8 +879,10 @@ static void set_default_gateway(struct gateway_data *data,
 		do_ipv4 = true;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
 		do_ipv6 = true;
-	else
+	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
 		do_ipv4 = do_ipv6 = true;
+	else
+		return;
 
 	if (do_ipv4 && data->ipv4_config &&
 					data->ipv4_config->vpn) {
@@ -949,11 +959,10 @@ static void unset_default_gateway(struct gateway_data *data,
 		do_ipv4 = true;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
 		do_ipv6 = true;
-	else
+	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
 		do_ipv4 = do_ipv6 = true;
-
-	DBG("type %d gateway ipv4 %p ipv6 %p", type, data->ipv4_config,
-						data->ipv6_config);
+	else
+		return;
 
 	if (do_ipv4 && data->ipv4_config &&
 					data->ipv4_config->vpn) {
@@ -1599,8 +1608,10 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 		do_ipv4 = true;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
 		do_ipv6 = true;
-	else
+	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
 		do_ipv4 = do_ipv6 = true;
+	else
+		return;
 
     /* Delete any routes associated with this service's nameservers. */
 
-- 
2.42.0

