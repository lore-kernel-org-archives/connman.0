Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2117.outbound.protection.outlook.com [40.107.22.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11C17F6
	for <connman@lists.linux.dev>; Sun,  4 Jun 2023 04:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBmu0ehZxSkmPmgdT9G5h0iX1v9xpf+OHIyejoOAydtBMOujpg9McFn1or5zjgIUuRP3UK5CUFxXEC+TOb5xnGaSJFOP+LhH+DGPw3zyatfsOcKBN2hSJROGKTQlvWuBzX/T0gQB6K4U5Xpsqf69I+0a+5jnp0eo3L3M38jZGsSqH787+pRGab2I3yaF4EAQYCbCvHa8LJalf996ZtndzVsV3YTalFRIWug5nOWvmp9FK9QsO2L/czbfznte4NxaCbiijtygL0in5FBUjX5KEMrg+6uj6h67r0XmIqpp2T2HYEF0bZCNYBtLKC5oaSllW3qPiiWsTMUbPbz/9atXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq+4tZQMuu11O/uLqNwhFlflfCCsFIhmxaWsx96RVV4=;
 b=mBrr1/cmnd7OY1VWxjm5bhi3V0GA+yecpTOt9kN7RowXqac3JSjqqxBkcnRy1oFFKAwI0lrAPUUsUCXXsSYk4ac6ovJ8BILyjN+7b2LnL82WIgYWTa2oV0JU/SG2w87VOnIJe+LbrRcBpeAiQjsVsYfPfNjJlUyNnQS9zDmZuZZ3XwIkFesXc9/E2oXtCb6Fy+OG1gp0DZVWg8HfsNVki0ErCig08MhwKZtKx5d5AbbxTR58Tpn14C18qXVnUAG28wPuSprZfzQxuzEADb6WZTHdftaZrMZOQ0FJUfeRx9jvcwDf5kJoFt8dzPG5T2YyopQjCirBTi0vrPaYCjOCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.136.170.117) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=code1.emi.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=code1.emi.philips.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq+4tZQMuu11O/uLqNwhFlflfCCsFIhmxaWsx96RVV4=;
 b=f4edSysfQj1YL8+d0Gh+Kp/+gCx8k/OABjqgTVXtxZYfq/w4EU7802uCiBeZs8ImGPFYG/NVcjThrzmuZ7TNb/wk5jwRI4hnObQMjrcjCxvoLVu0ABM6ZNTUKWs5oYncbb3SozRt+Vqzt20+tSgQk0AoBKvvrVjRdJdAdRnvKBE=
Received: from OS6P279CA0049.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::18)
 by AM7P122MB0230.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:186::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 04:58:51 +0000
Received: from HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:31:cafe::2e) by OS6P279CA0049.outlook.office365.com
 (2603:10a6:e10:31::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31 via Frontend
 Transport; Sun, 4 Jun 2023 04:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.136.170.117)
 smtp.mailfrom=code1.emi.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=code1.emi.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of code1.emi.philips.com
 designates 18.136.170.117 as permitted sender)
 receiver=protection.outlook.com; client-ip=18.136.170.117;
 helo=ext-asp1.smtp.philips.com; pr=C
Received: from ext-asp1.smtp.philips.com (18.136.170.117) by
 HE1EUR01FT019.mail.protection.outlook.com (10.152.0.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Sun, 4 Jun 2023 04:58:50 +0000
Received: from smtprelay-asp1.philips.com ([161.92.84.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-asp1.smtp.philips.com with ESMTP
	id 5fodqCBKmiUUo5fpJqKPn8; Sun, 04 Jun 2023 04:58:49 +0000
Received: from INGBTCPIC6LX258.in-101.lan.philips.com ([161.85.103.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by smtprelay-asp1.philips.com with ESMTPA
	id 5fooqiWAgsE2N5fpIquhq0; Sun, 04 Jun 2023 04:58:49 +0000
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
From: Adinath Mhatre <adinathmhatre@code1.emi.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] commands: IPv4LL fallback config support
Date: Sun,  4 Jun 2023 10:28:18 +0530
Message-Id: <f48d13482bc3d4794bcae0e8c59a3ef9ff56f381.1685721540.git.adinath.mhatre@philips.com>
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT019:EE_|AM7P122MB0230:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ff11aeb-fbf8-4e39-e82a-08db64b863bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IDjLfJSw6trboNogTh2ERkTULuxu7QuODs02MjeFCW6XPlHZErHzXuFsvnL+zfVkwIVrzCGzs75FVU0t50levoKRkJm9cv+x4Hg9brLfP+tXaUt81elvv+JILc1IPri3u5UMCOlOu9evNHNkw+D15xSnfB+pVuB4/daIkLtn0JfzdZGlUfDwK/gW0A8U/qffJOmBzCgRwhwhaDAAvKd7kj4JY3y9rh+EofvZTX1uXDedzeLd6NfVkfj8X8YRzR1HVpJ88opPFrJuyCkYIdW8tO4lPprrWrTk/ow3da+HJ2fgOfDKuhoJrJJHHYrIWvb0Gj8YGaBxJN/gzDnoLAF+KRjtsyRdADZM44YhpWeVe/3sj40WlaSkTddKKVF07jnNp9XOwHEsoeg1rjVgtaZ8A5NXk0rVR4zb61K0FKrGiK/SHhWJOsPXynn5m1R648IzABu5CKBrBibyI5XxNeVOQFyzy0QACubBeh4jRhygCg8vOLS0qxBPxBTGpXfWAZS+EusjFWK1GfWOdJJ6mc093p+8eP4NjTfiPZPWDCcpBKF2Xy9GL2YTmqmwLQlscdW1xFipxGbIAHYJFthYDkUEy1XnpCDv53QBMr7yG4V4t1k+bY/2zsBWiCVg77tu5QmzM+D9DKQQBFWwf+9LsAI/DztaK+oo4sCdwXGb/lyQZ7/bYrcqup5Eusi9PYK7QeghjtP8lGD5wUypt+vddD6ycmSZoQPOzgRyqxxFQVraeWkqV3iBnKssKmUslZKfOKHlFF0oJvp1eUYgiLLTRl2fQw==
X-Forefront-Antispam-Report:
	CIP:18.136.170.117;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-asp1.smtp.philips.com;PTR:ec2-18-136-170-117.ap-southeast-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(336012)(83380400001)(8676002)(316002)(5660300002)(82310400005)(8936002)(6916009)(956004)(70206006)(70586007)(36860700001)(41300700001)(47076005)(6666004)(86362001)(478600001)(7696005)(2906002)(36756003)(82960400001)(9686003)(186003)(40460700003)(82740400003)(81166007)(356005)(26005)(40480700001)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: code1.emi.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 04:58:50.7738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff11aeb-fbf8-4e39-e82a-08db64b863bd
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[18.136.170.117];Helo=[ext-asp1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P122MB0230

From: Adinath Mhatre <adinath.mhatre@philips.com>

Added support to set IPv4LL fallback configuration
from connmanctl.

Signed-off-by: Adinath Mhatre <adinath.mhatre@philips.com>
---
 client/commands.c   | 50 ++++++++++++++++++++++++++++++++++++++-------
 doc/connmanctl.1.in | 10 +++++----
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/client/commands.c b/client/commands.c
index 53cc14c8..c967102f 100644
--- a/client/commands.c
+++ b/client/commands.c
@@ -985,18 +985,53 @@ static void config_append_ipv4(DBusMessageIter *iter,
 {
 	struct config_append *append = user_data;
 	char **opts = append->opts;
-	int i = 0;
 
 	if (!opts)
 		return;
 
-	while (opts[i] && ipv4[i]) {
-		__connmanctl_dbus_append_dict_entry(iter, ipv4[i],
-				DBUS_TYPE_STRING, &opts[i]);
-		i++;
+	append->values = 1;
+
+	if (g_strcmp0(opts[0], "dhcp") == 0) {
+		dbus_bool_t val;
+
+		append->values = 2;
+
+		if (opts[1]) {
+			switch (parse_boolean(opts[1])) {
+			case 1:
+				val = TRUE;
+				break;
+			case 0:
+				val = FALSE;
+				break;
+			default:
+				fprintf(stderr, "Error %s: %s\n", opts[1], strerror(EINVAL));
+				return;
+			}
+
+			__connmanctl_dbus_append_dict_entry(iter, "FallbackIPv4LL",
+						DBUS_TYPE_BOOLEAN, &val);
+		}
+
+	} else if (g_strcmp0(opts[0], "manual") == 0) {
+		int i = 1;
+
+		while (opts[i] && ipv4[i]) {
+			__connmanctl_dbus_append_dict_entry(iter, ipv4[i],
+						DBUS_TYPE_STRING, &opts[i]);
+			i++;
+		}
+
+		append->values = i;
+
+	} else if (g_strcmp0(opts[0], "off") != 0) {
+		fprintf(stderr, "Error %s: %s\n", opts[0], strerror(EINVAL));
+
+		return;
 	}
 
-	append->values = i;
+	__connmanctl_dbus_append_dict_entry(iter, "Method", DBUS_TYPE_STRING,
+				&opts[0]);
 }
 
 static void config_append_ipv6(DBusMessageIter *iter, void *user_data)
@@ -2435,7 +2470,8 @@ static struct connman_option config_options[] = {
 	{"proxy", 'x', "direct|auto <URL>|manual <URL1> [<URL2>] [...]\n"
 	               "\t\t\t[exclude <exclude1> [<exclude2>] [...]]"},
 	{"autoconnect", 'a', "yes|no"},
-	{"ipv4", 'i', "off|dhcp|manual <address> <netmask> <gateway>"},
+	{"ipv4", 'i', "off|dhcp [true|false]|\n"
+		      "\t\t\tmanual <address> <netmask> <gateway>"},
 	{"remove", 'r', "                 Remove service"},
 	{ NULL, }
 };
diff --git a/doc/connmanctl.1.in b/doc/connmanctl.1.in
index d87472c3..00fa4208 100644
--- a/doc/connmanctl.1.in
+++ b/doc/connmanctl.1.in
@@ -164,11 +164,13 @@ Config Options:
 Sets the autoconnect property of the service.
 .PP
 .TP
-.BR ipv4\ off \ |\  dhcp \ |\  manual\ \fIaddress\ netmask\ gateway
+.BR ipv4\ off \ |\  dhcp \ <\fIfallback-ipv4ll\fR>\ |\  manual\ \fIaddress\ netmask\ gateway
 Configures the IPv4 settings for the service. The argument
-\fBoff\fR means that IPv4 won't be used, \fBdhcp\fR means that
-dhcp will be used to get the settings and \fBmanual\fR means
-that the given arguments will be used as IPv4 settings.
+\fBoff\fR means that IPv4 won't be used, \fBdhcp\fR means that dhcp will be used
+to get the settings. \fIfallback-ipv4ll\fR is boolean parameter.
+if set \fBfalse\fR, an IPv4LL address will not be assigned if DHCP failed.
+Default is \fBtrue\fR. \fBmanual\fR means that the given arguments will be
+used as IPv4 settings.
 .IR address ,\  netmask " and " gateway
 must be valid IPv4 addresses. See the \fBEXAMPLE\fR section
 of this man page for details.
-- 
2.25.1

