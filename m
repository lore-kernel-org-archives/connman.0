Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E132328D1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7818A73202
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:05 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3A19673219
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 18/90] connection: Refactor 'yield_default_gateway'.
Date: Wed,  6 Dec 2023 15:49:41 -0800
Message-ID: <20231206235056.322578-19-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206235056.322578-1-gerickson@nuovations.com>
References: <20231206235056.322578-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

From: Grant Erickson <erick205@umn.edu>

The IPv4 and IPv6 sub-blocks of 'yield_default_gateway' are nearly-
identical and differ only in a parameterizable IP configuration type
value and the gateway configuration.

This adds a new function, 'gateway_data_config_get', that selects from
between the IPv4 and IPv6 gateway configuration pointers from gateway
data, using an IP configuration type parameter.

This then splits out those common blocks from 'yield_default_gateway'
into 'yield_defalt_gateway_for_type', passing the IP configuration
type parameter, and then leverages 'gateway_data_config_get' to select
the desired gateway configuration from the passed 'activated' and
'existing' gateway data.
---
 src/connection.c | 203 +++++++++++++++++++++++++----------------------
 1 file changed, 107 insertions(+), 96 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index ecb8e6b4037a..e328a929b306 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -394,6 +394,30 @@ static void gateway_data_debug(const char *function,
 	}
 }
 
+static struct gateway_config *gateway_data_config_get(struct gateway_data *data,
+				enum connman_ipconfig_type type)
+{
+	struct gateway_config *config = NULL;
+
+	if (!data)
+		return config;
+
+	switch (type) {
+	case CONNMAN_IPCONFIG_TYPE_IPV4:
+		config = data->ipv4_config;
+		break;
+	case CONNMAN_IPCONFIG_TYPE_IPV6:
+		config = data->ipv6_config;
+		break;
+	case CONNMAN_IPCONFIG_TYPE_UNKNOWN:
+	case CONNMAN_IPCONFIG_TYPE_ALL:
+	default:
+		break;
+	}
+
+	return config;
+}
+
 /**
  *  @brief
  *    Determine whether the specified text-formatted IPv4 address is
@@ -1365,6 +1389,76 @@ static void unset_default_gateway(struct gateway_data *data,
 		unset_ipv6_default_gateway(data, data->ipv6_config);
 }
 
+static bool yield_default_gateway_for_type(struct gateway_data *activated,
+					struct gateway_data *existing,
+					enum connman_ipconfig_type type)
+{
+	static const enum gateway_config_type config_type =
+		CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT;
+	const struct gateway_config *const activated_config =
+		gateway_data_config_get(activated, type);
+	const struct gateway_config *const existing_config =
+		gateway_data_config_get(existing, type);
+	bool yield_activated = false;
+
+	DBG("activated data %p config %p "
+		"existing data %p config %p "
+		"type %d (%s)",
+		activated, activated_config,
+		existing, existing_config,
+		type, __connman_ipconfig_type2string(type));
+
+	/*
+	 * There is only an default gateway yield decision to be
+	 * considered if there is an gateway configuration for BOTH the
+	 * activated and existing gateway data.
+	 */
+	if (!activated_config || !existing_config)
+		goto done;
+
+	/*
+	 * If the existing gateway data IS NOT active (that is, HAS
+	 * NOT made it to the RTNL notification phase of its
+	 * lifecycle), then it yields the default gateway to the
+	 * activated gateway data.
+	 */
+	if (!is_gateway_config_state_active(existing_config)) {
+		DBG("%s existing %p yielding %s",
+			__connman_ipconfig_type2string(type),
+			existing,
+			maybe_null(gateway_config_type2string(
+				config_type)));
+
+		UNSET_DEFAULT_GATEWAY(existing, type);
+	}
+
+	/*
+	 * If the existing gateway data IS active (that is, HAS made
+	 * it to the RTNL notification phase of its lifecycle) and if
+	 * its associated service is more "senior" in the service sort
+	 * order, then the activated gateway data yields the default
+	 * gateway to the existing gateway data.
+	 */
+	if (is_gateway_config_state_active(existing_config) &&
+		__connman_service_compare(existing->service,
+				activated->service) < 0) {
+		DBG("%s activated %p yielding %s",
+			__connman_ipconfig_type2string(type),
+			activated,
+			maybe_null(gateway_config_type2string(
+				config_type)));
+
+		UNSET_DEFAULT_GATEWAY(activated, type);
+
+		yield_activated = true;
+	}
+
+	DBG("yield_activated %u", yield_activated);
+
+done:
+	return yield_activated;
+}
+
 /**
  *  @brief
  *    Decide whether either of the specified gateways should yield the
@@ -1393,109 +1487,26 @@ static void unset_default_gateway(struct gateway_data *data,
 static bool yield_default_gateway(struct gateway_data *activated,
 					struct gateway_data *existing)
 {
-	static const enum gateway_config_type config_type =
-		CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT;
-	enum connman_ipconfig_type type;
-	bool yield_activated = false;
-
-	DBG("activated %p existing %p", activated, existing);
+	bool yield_ipv4_activated = false, yield_ipv6_activated = false;
 
 	GATEWAY_DATA_DBG("activated", activated);
 	GATEWAY_DATA_DBG("existing", existing);
 
-	/*
-	 * There is only an IPv4 default gateway yield decision to be
-	 * considered if there is an IPv4 gateway configuration for BOTH
-	 * the activated and existing gateway data.
-	 */
-	if (activated->ipv4_config && existing->ipv4_config) {
-		type = CONNMAN_IPCONFIG_TYPE_IPV4;
-
-		/*
-		 * If the existing IPv4 gateway data IS NOT active (that is,
-		 * HAS NOT made it to the RTNL notification phase of its
-		 * lifecycle), then it yields the default gateway to the
-		 * activated gateway data.
-		 */
-		if (!is_gateway_config_state_active(existing->ipv4_config)) {
-			DBG("%s existing %p yielding %s",
-				__connman_ipconfig_type2string(type),
-				existing,
-				maybe_null(gateway_config_type2string(
-					config_type)));
-
-			UNSET_DEFAULT_GATEWAY(existing, type);
-		}
-
-		/*
-		 * If the existing IPv4 gateway data IS active (that is, HAS
-		 * made it to the RTNL notification phase of its lifecycle)
-		 * and if its associated service is more "senior" in the
-		 * service sort order, then the activated gateway data yields
-		 * the default gateway to the existing gateway data.
-		 */
-		if (is_gateway_config_state_active(existing->ipv4_config) &&
-				__connman_service_compare(existing->service,
-						activated->service) < 0) {
-			DBG("%s activated %p yielding %s",
-				__connman_ipconfig_type2string(type),
-				activated,
-				maybe_null(gateway_config_type2string(
-					config_type)));
-
-			UNSET_DEFAULT_GATEWAY(activated, type);
-
-			yield_activated = true;
-		}
-	}
-
-	/*
-	 * There is only an IPv6 default gateway yield decision to be
-	 * considered if there is an IPv6 gateway configuration for BOTH
-	 * the activated and existing gateway data.
-	 */
-	if (activated->ipv6_config && existing->ipv6_config) {
-		type = CONNMAN_IPCONFIG_TYPE_IPV6;
+	yield_ipv4_activated = yield_default_gateway_for_type(
+						activated,
+						existing,
+						CONNMAN_IPCONFIG_TYPE_IPV4);
 
-		/*
-		 * If the existing IPv6 gateway data IS NOT active (that is,
-		 * HAS NOT made it to the RTNL notification phase of its
-		 * lifecycle), then it yields the default gateway to the
-		 * activated gateway data.
-		 */
-		if (!is_gateway_config_state_active(existing->ipv6_config)) {
-			DBG("%s existing %p yielding %s",
-				__connman_ipconfig_type2string(type),
-				existing,
-				maybe_null(gateway_config_type2string(
-					config_type)));
-
-			UNSET_DEFAULT_GATEWAY(existing, type);
-		}
+	yield_ipv6_activated = yield_default_gateway_for_type(
+						activated,
+						existing,
+						CONNMAN_IPCONFIG_TYPE_IPV6);
 
-		/*
-		 * If the existing IPv6 gateway data IS active (that is, HAS
-		 * made it to the RTNL notification phase of its lifecycle)
-		 * and if its associated service is more "senior" in the
-		 * service sort order, then the activated gateway data yields
-		 * the default gateway to the existing gateway data.
-		 */
-		if (is_gateway_config_state_active(existing->ipv6_config) &&
-			__connman_service_compare(existing->service,
-					activated->service) < 0) {
-			DBG("%s activated %p yielding %s",
-				__connman_ipconfig_type2string(type),
-				activated,
-				maybe_null(gateway_config_type2string(
-					config_type)));
-
-			UNSET_DEFAULT_GATEWAY(activated, type);
-
-			yield_activated = true;
-		}
-	}
+	DBG("yield_ipv4_activated %u yield_ipv6_activated %u",
+		yield_ipv4_activated,
+		yield_ipv6_activated);
 
-	return yield_activated;
+	return yield_ipv4_activated || yield_ipv6_activated;
 }
 
 /**
-- 
2.42.0

