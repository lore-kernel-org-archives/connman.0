Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2111.outbound.protection.outlook.com [40.107.247.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E015CC
	for <connman@lists.linux.dev>; Sun,  4 Jun 2023 04:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIbKjz6DmAjBnjsVdy8qmY/zyDep/Bsz+j1zIOoCIK5oIcYtDU9tkEIGYbo53y1RUPg89iXZ36L3xBOSAlBG+TGib572zn5k2jH3bT+JpjerEuG3au8eMSUIuyO8iUJY/y3876AWZN4iz+Mv+525mghbWx0INTnKhG8BRy7MYtX6wWE3NJbt432aUXbC34v2N6DXP9PJUw7yRVoXXfCJIBKuWFwyCEanVqs2vyWiPy7kkJ7YPO8hCn3aPMFP68CCeHsAxTEpVztJNzkCF1Y3ce4qRdRkWr6VOskn0+/1qXDNez0rd/g3Or1Yh5bBEwTIGaL7XkthcGbI0bY6dR+Cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQTsJiCabN1doTZ4NdN6XRxVwHpXPXkqKwIXPLH/r0Q=;
 b=dBBgQOH6AMuPNnaZ4PvfxYMGB90RlsqGOYQpp4hoL5MD18UErgiCqxUmA25nAlQgUh6DnPjXu8KTRSvtjZHVk6U+pHMxA+zwP+sZ285LsAQWeHnaiXaOBxQtfSR1Jjyekp7Mg98NE9xvR7C/c4+nWHXGkqZ9SM/jpNzEqwfPwXKYWHNu7cvmFZrUF3S62QWIBvqcGXLNkAV6q4WIgKUSYr6ZVTc4jWV/0z0hvg/hwW54DP4uJ3q1ELASdtTHqT8AiWrrWv4es26oeR/xSTfC2/WrGq9BtwQxa0nVJzCbrsMaaP5OXmJNrySfJLhRCOA9qiDwxXk4A+tVnD0P/6tkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.136.170.117) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=code1.emi.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=code1.emi.philips.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQTsJiCabN1doTZ4NdN6XRxVwHpXPXkqKwIXPLH/r0Q=;
 b=YpaLaG8G8JyAfFo3jNdzXSUD/o72UaHPBX4mK6yw6IKu//y/nQdL1TRSs1eF3mwi+ir8+Q011rhSly9CPcyDSiAiKhC+ikUhu2cEVlnVjI5IDEuT7jMy9zRQ54PHzQ61dMoI7w4PHRXz1JgVEqYeGPqKzQ7n4lXxgelHCs24J9c=
Received: from GVYP280CA0002.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:fa::9) by
 VI1P122MB0078.EURP122.PROD.OUTLOOK.COM (2603:10a6:820:33::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.31; Sun, 4 Jun 2023 04:58:50 +0000
Received: from HE1EUR01FT084.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:fa:cafe::41) by GVYP280CA0002.outlook.office365.com
 (2603:10a6:150:fa::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31 via Frontend
 Transport; Sun, 4 Jun 2023 04:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.136.170.117)
 smtp.mailfrom=code1.emi.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=code1.emi.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of code1.emi.philips.com
 designates 18.136.170.117 as permitted sender)
 receiver=protection.outlook.com; client-ip=18.136.170.117;
 helo=ext-asp1.smtp.philips.com; pr=C
Received: from ext-asp1.smtp.philips.com (18.136.170.117) by
 HE1EUR01FT084.mail.protection.outlook.com (10.152.1.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Sun, 4 Jun 2023 04:58:48 +0000
Received: from smtprelay-asp1.philips.com ([161.92.84.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-asp1.smtp.philips.com with ESMTP
	id 5fodqCBKkiUUo5fpIqKPn7; Sun, 04 Jun 2023 04:58:48 +0000
Received: from INGBTCPIC6LX258.in-101.lan.philips.com ([161.85.103.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by smtprelay-asp1.philips.com with ESMTPA
	id 5fooqiWAgsE2N5fpIquhpy; Sun, 04 Jun 2023 04:58:48 +0000
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
From: Adinath Mhatre <adinathmhatre@code1.emi.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] service:config: Support to disable IPv4LL fallback
Date: Sun,  4 Jun 2023 10:28:17 +0530
Message-Id: <e7f2eaa6c118e9f5687f73a23d51a9fcbb66176e.1685721540.git.adinath.mhatre@philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685721540.git.adinath.mhatre@philips.com>
References: <cover.1685721540.git.adinath.mhatre@philips.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT084:EE_|VI1P122MB0078:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 17988ba2-7c99-4450-06f5-08db64b862ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U5rLuxg6UXXT2uEY7jsJ5LQcPTvHWQDNvT1IimM7hEUEg3Di3ph1N+KD17N4cK7WcCCDZdu+hq/dc9hPf/SeykOmyOTHMcHbnlIICKGpJNDrPCkbhopCt0yBTn3POk7Ff9FXHH2jsaPwdBUpqObEuUG9r+q9qGGxt+lw4KLpF867I61kVLD0pk6JS9btN4BRGTuI/53eDArIiUkBF3UnuAWkIQ/3SW5PBe6GihHLtE9XduOR6D1t64huG+ssz7QFHfOyPuqczaKrIMHe07kS5GL6UmOMTIhcgYkzmVR3q8stP1UBVKdSIiDf5WSjdFZ6Jeof9YLx5K6RJf0AAPNUCV9hZ7jY5iS58O21MYRaysEu5pzep0HYNFVGXQtglAAYoa3UPtTGQVaEriSHx5iVzbE5NNHuwHm2Q6Dc9B2nw24EQAbo7Wp+7/DWBnVyWUKLVOgx8uH20d/p7J714/o03qzvUYnp6GdOGRwrmw7ZWt2v2DPFRb/x8HQk2pkTheaFAVv6X3EEWt12JUwdjqc8zhPWidy03WEkgpCXP4dspwuSqgmVkAMYrnp3HIAQgSSE49ACXtXXiQ4dDMoExo8abwNLBdhItRfmqECKBbsS9SsTTByJ9LNYFybrazDselBXDRutjdNYGxW1U1xWWPYEuYgwbXD+GYwGcT7S4Wzxs1GMo8kSkmW4K8KumNWM9qfYMkqsFLK29BtiNo5qXeshIv4/q3+thtIx8w2lBL77vXoodvakiKFxMylZLTs1dr0w8oHEak3DnFsTumdAvJFThQ==
X-Forefront-Antispam-Report:
	CIP:18.136.170.117;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-asp1.smtp.philips.com;PTR:ec2-18-136-170-117.ap-southeast-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(336012)(83380400001)(8676002)(316002)(8936002)(5660300002)(6916009)(956004)(70206006)(70586007)(36860700001)(41300700001)(66899021)(47076005)(26005)(81166007)(186003)(82740400003)(82960400001)(356005)(40460700003)(19627235002)(40480700001)(9686003)(82310400005)(36756003)(86362001)(2906002)(478600001)(7696005)(30864003)(6666004)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: code1.emi.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 04:58:48.9855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17988ba2-7c99-4450-06f5-08db64b862ad
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[18.136.170.117];Helo=[ext-asp1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT084.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0078

From: Adinath Mhatre <adinath.mhatre@philips.com>

In current design of connman, if a client fails to discover
DHCP server, it will fallback to IPv4LL address.
In some systems it is not desirable.
Therefore, added config and D-Bus API to disable IPv4LL fallback.

Signed-off-by: Adinath Mhatre <adinath.mhatre@philips.com>
---
 doc/config-format.txt           |  5 +++
 doc/connman-service.config.5.in |  6 +++
 doc/service-api.txt             | 10 +++++
 src/config.c                    | 23 ++++++++++
 src/connman.h                   |  2 +
 src/dhcp.c                      |  7 +++
 src/ipconfig.c                  | 80 +++++++++++++++++++++++++++++++--
 test/set-ipv4-method            | 34 +++++++++++---
 8 files changed, 157 insertions(+), 10 deletions(-)

diff --git a/doc/config-format.txt b/doc/config-format.txt
index cdde9cbc..a870a68c 100644
--- a/doc/config-format.txt
+++ b/doc/config-format.txt
@@ -42,6 +42,11 @@ Allowed fields:
   Example: 192.168.1.2/24/192.168.1.1
            192.168.200.100/255.255.255.0/192.168.200.1
            10.0.0.2/24
+- IPv4.FallbackIPv4LL: Option to disable IPv4LL fallback.
+  IPv4LL fallback is applied when an IPv4 address could not be assigned
+  using DHCP method.
+  If set "false", an IPv4LL address will not be assigned if DHCP failed.
+  Default value is "true".
 - IPv6: The IPv6 address, prefix length and gateway. Format of the entry
   is network/prefixlen/gateway. For IPv6 addresses only prefix length is
   accepted. The gateway can be omitted if necessary.
diff --git a/doc/connman-service.config.5.in b/doc/connman-service.config.5.in
index 701f61f9..e83f9d25 100644
--- a/doc/connman-service.config.5.in
+++ b/doc/connman-service.config.5.in
@@ -48,6 +48,12 @@ If set to \fBdhcp\fP, dhcp will be used to obtain the network settings.
 \fInetmask\fP can be specified as length of the mask rather than the
 mask itself. The gateway can be omitted when using a static IP.
 .TP
+.B IPv4.FallbackIPv4LL=true \fR|\fB false
+IPv4LL fallback is applied when an IPv4 address could not be assigned
+using DHCP method.
+If set \fBfalse\fP, an IPv4LL address will not be assigned if DHCP failed.
+Default value is \fBtrue\fP.
+.TP
 .BI IPv6=off \ \fR|\  auto\ \fR|\  network / prefixlength / gateway
 IPv6 settings for the service. If set to \fBoff\fP, IPv6 won't be used.
 If set to \fBauto\fP, settings will be obtained from the network.
diff --git a/doc/service-api.txt b/doc/service-api.txt
index c0d5adbb..4f329903 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -340,6 +340,16 @@ Properties	string State [readonly]
 
 				The current configured IPv4 gateway.
 
+			boolean FallbackIPv4LL [readonly]
+
+				The current IPv4LL fallback configuration. The
+				value has only meaning if Method is set to "dhcp".
+
+				Value "false" means an IPv4LL address will
+				not be assigned if DHCP failed.
+
+				Default value is "true".
+
 		dict IPv4.Configuration [readwrite]
 
 			Same values as IPv4 property. The IPv4 represents
diff --git a/src/config.c b/src/config.c
index 33fdc737..476e0d37 100644
--- a/src/config.c
+++ b/src/config.c
@@ -67,6 +67,7 @@ struct connman_config_service {
 	char *ipv4_address;
 	char *ipv4_netmask;
 	char *ipv4_gateway;
+	bool ipv4_fallback_ll;
 	char *ipv6_address;
 	unsigned char ipv6_prefix_length;
 	char *ipv6_gateway;
@@ -117,6 +118,7 @@ static bool cleanup = false;
 #define SERVICE_KEY_MDNS               "mDNS"
 
 #define SERVICE_KEY_IPv4               "IPv4"
+#define SERVICE_KEY_IPv4_FALLBACK_LL   "IPv4.FallbackIPv4LL"
 #define SERVICE_KEY_IPv6               "IPv6"
 #define SERVICE_KEY_IPv6_PRIVACY       "IPv6.Privacy"
 #define SERVICE_KEY_MAC                "MAC"
@@ -153,6 +155,7 @@ static const char *service_possible_keys[] = {
 	SERVICE_KEY_SECURITY,
 	SERVICE_KEY_HIDDEN,
 	SERVICE_KEY_IPv4,
+	SERVICE_KEY_IPv4_FALLBACK_LL,
 	SERVICE_KEY_IPv6,
 	SERVICE_KEY_IPv6_PRIVACY,
 	SERVICE_KEY_MAC,
@@ -444,6 +447,17 @@ static bool load_service_generic(GKeyFile *keyfile,
 		g_free(str);
 	}
 
+	service->ipv4_fallback_ll = true;
+	str = g_key_file_get_value(keyfile, group, SERVICE_KEY_IPv4_FALLBACK_LL, NULL);
+
+	if (str) {
+		str = g_strchomp(str);
+		if (strcmp(str, "false") == 0)
+			service->ipv4_fallback_ll = false;
+
+		g_free(str);
+	}
+
 	str =  __connman_config_get_string(keyfile, group, SERVICE_KEY_IPv6, NULL);
 	if (str && check_address(str, &service->ipv6_address)) {
 		long int value;
@@ -1380,6 +1394,15 @@ static int try_provision_service(struct connman_config_service *config,
 		connman_ipaddress_free(address);
 	}
 
+	if (g_ascii_strcasecmp(config->ipv4_address, "dhcp") == 0) {
+		struct connman_ipconfig *ipconfig;
+
+		ipconfig = __connman_service_get_ip4config(service);
+		if (ipconfig)
+			__connman_ipconfig_set_ipv4_fallback_ll(ipconfig,
+							config->ipv4_fallback_ll);
+	}
+
 	__connman_service_disconnect(service);
 
 	service_id = connman_service_get_identifier(service);
diff --git a/src/connman.h b/src/connman.h
index b955d98b..dae79162 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -435,6 +435,8 @@ bool __connman_ipconfig_ipv6_is_enabled(struct connman_ipconfig *ipconfig);
 
 int __connman_ipconfig_set_rp_filter();
 void __connman_ipconfig_unset_rp_filter(int old_value);
+bool __connman_ipconfig_get_ipv4_fallback_ll(struct connman_ipconfig *ipconfig);
+int __connman_ipconfig_set_ipv4_fallback_ll(struct connman_ipconfig *ipconfig, bool val);
 
 #include <connman/utsname.h>
 
diff --git a/src/dhcp.c b/src/dhcp.c
index 18dbab27..2766252e 100644
--- a/src/dhcp.c
+++ b/src/dhcp.c
@@ -252,6 +252,7 @@ static gboolean dhcp_retry_cb(gpointer user_data)
 static void no_lease_cb(GDHCPClient *dhcp_client, gpointer user_data)
 {
 	struct connman_dhcp *dhcp = user_data;
+	struct connman_service *service;
 	int err;
 
 	DBG("No lease available ipv4ll %d client %p", dhcp->ipv4ll_running,
@@ -266,6 +267,12 @@ static void no_lease_cb(GDHCPClient *dhcp_client, gpointer user_data)
 	if (dhcp->ipv4ll_running)
 		return;
 
+	if (!__connman_ipconfig_get_ipv4_fallback_ll(dhcp->ipconfig)) {
+		service = connman_service_lookup_from_network(dhcp->network);
+		__connman_service_save(service);
+		return;
+	}
+
 	err = ipv4ll_start_client(dhcp);
 	if (err < 0)
 		DBG("Cannot start ipv4ll client (%d/%s)", err, strerror(-err));
diff --git a/src/ipconfig.c b/src/ipconfig.c
index 34b1724a..577d7a28 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -55,6 +55,7 @@ struct connman_ipconfig {
 	int ipv6_privacy_config;
 	char *last_dhcp_address;
 	char **last_dhcpv6_prefixes;
+	bool ipv4_fallback_ll;
 };
 
 struct connman_ipdevice {
@@ -451,6 +452,24 @@ bool __connman_ipconfig_ipv6_privacy_enabled(struct connman_ipconfig *ipconfig)
 	return ipconfig->ipv6_privacy_config == 0 ? FALSE : TRUE;
 }
 
+bool __connman_ipconfig_get_ipv4_fallback_ll(struct connman_ipconfig *ipconfig)
+{
+	if (!ipconfig)
+		return true;
+
+	return ipconfig->ipv4_fallback_ll;
+}
+
+int __connman_ipconfig_set_ipv4_fallback_ll(struct connman_ipconfig *ipconfig, bool val)
+{
+	if (!ipconfig)
+		return -EINVAL;
+
+	ipconfig->ipv4_fallback_ll = val;
+
+	return 0;
+}
+
 bool __connman_ipconfig_ipv6_is_enabled(struct connman_ipconfig *ipconfig)
 {
 	struct connman_ipdevice *ipdevice;
@@ -1299,6 +1318,7 @@ struct connman_ipconfig *__connman_ipconfig_create(int index,
 	}
 
 	ipconfig->system = connman_ipaddress_alloc(AF_INET);
+	ipconfig->ipv4_fallback_ll = true;
 
 	ipconfig_set_p2p(index, ipconfig);
 
@@ -1921,8 +1941,14 @@ void __connman_ipconfig_append_ipv4(struct connman_ipconfig *ipconfig,
 
 	case CONNMAN_IPCONFIG_METHOD_AUTO:
 	case CONNMAN_IPCONFIG_METHOD_MANUAL:
+		append_addr = ipconfig->system;
+		break;
+
 	case CONNMAN_IPCONFIG_METHOD_DHCP:
 		append_addr = ipconfig->system;
+
+		connman_dbus_dict_append_basic(iter, "FallbackIPv4LL",
+						DBUS_TYPE_BOOLEAN, &ipconfig->ipv4_fallback_ll);
 		break;
 	}
 
@@ -2063,9 +2089,14 @@ void __connman_ipconfig_append_ipv4config(struct connman_ipconfig *ipconfig,
 	switch (ipconfig->method) {
 	case CONNMAN_IPCONFIG_METHOD_UNKNOWN:
 	case CONNMAN_IPCONFIG_METHOD_OFF:
-	case CONNMAN_IPCONFIG_METHOD_DHCP:
 	case CONNMAN_IPCONFIG_METHOD_AUTO:
 		return;
+
+	case CONNMAN_IPCONFIG_METHOD_DHCP:
+		connman_dbus_dict_append_basic(iter, "FallbackIPv4LL",
+						DBUS_TYPE_BOOLEAN, &ipconfig->ipv4_fallback_ll);
+		return;
+
 	case CONNMAN_IPCONFIG_METHOD_FIXED:
 	case CONNMAN_IPCONFIG_METHOD_MANUAL:
 		break;
@@ -2103,6 +2134,7 @@ int __connman_ipconfig_set_config(struct connman_ipconfig *ipconfig,
 	int prefix_length = 0, privacy = 0;
 	DBusMessageIter dict;
 	int type = -1;
+	dbus_bool_t fallback_ipv4ll = 1;
 
 	if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_ARRAY)
 		return -EINVAL;
@@ -2166,15 +2198,20 @@ int __connman_ipconfig_set_config(struct connman_ipconfig *ipconfig,
 
 			dbus_message_iter_get_basic(&value, &privacy_string);
 			privacy = string2privacy(privacy_string);
+		} else if (g_str_equal(key, "FallbackIPv4LL")) {
+			if (type != DBUS_TYPE_BOOLEAN)
+				return -EINVAL;
+
+			dbus_message_iter_get_basic(&value, &fallback_ipv4ll);
 		}
 
 		dbus_message_iter_next(&dict);
 	}
 
 	DBG("method %d address %s netmask %s gateway %s prefix_length %d "
-		"privacy %s",
+		"privacy %s fallback_ipv4ll %s",
 		method, address, netmask, gateway, prefix_length,
-		privacy_string);
+		privacy_string, fallback_ipv4ll ? "true" : "false");
 
 	switch (method) {
 	case CONNMAN_IPCONFIG_METHOD_UNKNOWN:
@@ -2237,6 +2274,7 @@ int __connman_ipconfig_set_config(struct connman_ipconfig *ipconfig,
 			return -EOPNOTSUPP;
 
 		ipconfig->method = method;
+		ipconfig->ipv4_fallback_ll = fallback_ipv4ll;
 		break;
 	}
 
@@ -2283,6 +2321,7 @@ void __connman_ipconfig_load(struct connman_ipconfig *ipconfig,
 	struct ipconfig_store is = { .file = keyfile,
 				     .group = identifier,
 				     .prefix = prefix };
+	bool skip_fallback_ipv4ll = false;
 
 	DBG("ipconfig %p identifier %s", ipconfig, identifier);
 
@@ -2364,6 +2403,13 @@ void __connman_ipconfig_load(struct connman_ipconfig *ipconfig,
 		 */
 		__connman_ipconfig_set_method(ipconfig,
 					CONNMAN_IPCONFIG_METHOD_DHCP);
+
+		/*
+		 * If IPv4 method is AUTO then we enable
+		 * IPv4LL fallback.
+		 */
+		ipconfig->ipv4_fallback_ll = true;
+		skip_fallback_ipv4ll = true;
 		/* fall through */
 
 	case CONNMAN_IPCONFIG_METHOD_DHCP:
@@ -2373,6 +2419,26 @@ void __connman_ipconfig_load(struct connman_ipconfig *ipconfig,
 			ipconfig->last_dhcp_address = str;
 		}
 
+		if (skip_fallback_ipv4ll)
+			break;
+
+		ipconfig->ipv4_fallback_ll = true;
+
+		char *pk, *valstr;
+
+		pk = g_strdup_printf("%s%s", is.prefix, "fallback_ipv4ll");
+		valstr = g_key_file_get_value(is.file, is.group, pk, NULL);
+		if (!valstr) {
+			g_free(pk);
+			break;
+		}
+
+		valstr = g_strchomp(valstr);
+		if (strcmp(valstr, "false") == 0)
+			ipconfig->ipv4_fallback_ll = false;
+
+		g_free(valstr);
+		g_free(pk);
 		break;
 	}
 }
@@ -2407,6 +2473,14 @@ void __connman_ipconfig_save(struct connman_ipconfig *ipconfig,
 		break;
 
 	case CONNMAN_IPCONFIG_METHOD_DHCP:
+		if (ipconfig->type == CONNMAN_IPCONFIG_TYPE_IPV4) {
+			char *pk;
+
+			pk = g_strdup_printf("%s%s", is.prefix, "fallback_ipv4ll");
+			g_key_file_set_boolean(is.file, is.group, pk, ipconfig->ipv4_fallback_ll);
+			g_free(pk);
+		}
+
 		store_set_str(&is, "DHCP.LastAddress",
 				ipconfig->last_dhcp_address);
 		/* fall through */
diff --git a/test/set-ipv4-method b/test/set-ipv4-method
index 09c194d7..3e949681 100755
--- a/test/set-ipv4-method
+++ b/test/set-ipv4-method
@@ -6,8 +6,20 @@ import dbus
 def make_variant(string):
 	return dbus.String(string, variant_level=1)
 
+def make_bool_variant(string):
+        if string == "true":
+                return dbus.Boolean(1)
+        if string == "false":
+                return dbus.Boolean(0)
+        else:
+                print("Invalid argument")
+                sys.exit(1)
+
 def print_usage():
-	print("Usage: %s <service> [off|dhcp|manual <address> [netmask] [gateway]]" % (sys.argv[0]))
+	print(
+                "Usage: %s <service> [off|dhcp|manual [fallback_ipv4ll=true|false] "\
+                "[<address> [netmask] [gateway]]]" % (sys.argv[0])
+        )
 
 
 if (len(sys.argv) < 3):
@@ -24,12 +36,20 @@ properties = service.GetProperties()
 print("Setting method %s for %s" % (sys.argv[2], sys.argv[1]))
 
 ipv4_configuration = { "Method": make_variant(sys.argv[2]) }
-if (len(sys.argv) > 3):
-	ipv4_configuration["Address"] = make_variant(sys.argv[3])
-if (len(sys.argv) > 4):
-	ipv4_configuration["Netmask"] = make_variant(sys.argv[4])
-if (len(sys.argv) > 5):
-        ipv4_configuration["Gateway"] = make_variant(sys.argv[5])
+if (sys.argv[2] == "dhcp") and (len(sys.argv) > 3):
+        if "fallback_ipv4ll=" in sys.argv[3]:
+                bool_val = sys.argv[3].split("fallback_ipv4ll=", 1)[1]
+                ipv4_configuration["FallbackIPv4LL"] = make_bool_variant(bool_val)
+        else:
+                print("Invalid argument")
+                sys.exit(1)
+else:
+	if (len(sys.argv) > 3):
+		ipv4_configuration["Address"] = make_variant(sys.argv[3])
+	if (len(sys.argv) > 4):
+		ipv4_configuration["Netmask"] = make_variant(sys.argv[4])
+	if (len(sys.argv) > 5):
+		ipv4_configuration["Gateway"] = make_variant(sys.argv[5])
 
 service.SetProperty("IPv4.Configuration", ipv4_configuration)
 print("New IPv4.Configuration: ", ipv4_configuration)
-- 
2.25.1

