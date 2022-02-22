Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60091.outbound.protection.outlook.com [40.107.6.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE416359
	for <connman@lists.linux.dev>; Tue, 22 Feb 2022 09:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avs2c3K07sgdZQ12P9IEaQUgo5m2Yc+QKnvfk/HX3KLWR7GRjAHcfw8epZwOHf0HCRh/3Eg84irKOjH/93we/lndXiTXBaB6mgcybJUHri/vZInIvFhdpCXanolQx0IMjVJYm1RPgk1c8zHwcSbihmNP7cmRP9ApIUaORCdbHx2/k3XelJVaN9XheFoj1UtHjA3To9I40TJV+oFP6zChk9BzB/yCaWtrU86Im8hOHfKV+Y5LIy39/J6TKTn0a+1KVSilegH/geymG0IzxvbeQrcSY1BBDi8QE3dtK91sDmzW8Kfyl7+Ywhw2FIB72vSVcL51NvXobYbpAA5B/TiPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlgK7G3FK21SRz998IOSopGO9fkyRXUuQsWtxjAYNS4=;
 b=db1tn2XzlpXjqlAJRtHgJ8l8sJWOilf5S/kJ5vMytCzZoYdfTCAP3zu7dVjqCl1PefQMCtmtbKYso1IF9+ZKEJWcuqd4q/o8KzkEehQARDXm72PnyuQFhzssBJ9BA+L9dK+EQG6vWEY4ohtgqPJJno8fUMLU8daA0JT31j0baqxkxUssGxmaVpD3pw61DA7jeqCmz7/jniPm3idfRpBg8wRwKw2sdjYLAle9BJJdCrrgBWefZC1ZcchJnkERO36kroLoUzxMR1jP/9R3hQpBCRsYuhKKMfDazvv8tdZfmxAtk4NbvsCOv04Haw1wS6ek4iqFM3c8oULeYVk4vS801Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlgK7G3FK21SRz998IOSopGO9fkyRXUuQsWtxjAYNS4=;
 b=J+CyNw0YOSiLOZ4hVu9TxVisY27eUzvxEKGOXroIK4guXrVk6sUEvdY9509sSy8SnoS1XVNvwcfisn92qttkWdFI2hCZ0449y2kdZ0k9iztYHfimrnyEgiIX4OcTa0+ssVSTZqOg4L2ZdUOFZ7045ZtGxnzrdgMNA915Wr96omY=
Received: from AS8PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:20b:310::11)
 by VI1P122MB0221.EURP122.PROD.OUTLOOK.COM (2603:10a6:800:177::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Tue, 22 Feb
 2022 09:11:30 +0000
Received: from VE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::1b) by AS8PR04CA0006.outlook.office365.com
 (2603:10a6:20b:310::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Tue, 22 Feb 2022 09:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com;
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 VE1EUR01FT017.mail.protection.outlook.com (10.152.2.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 09:11:29 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id MN8Wn3DwrTYquMRCjnmF67; Tue, 22 Feb 2022 10:11:29 +0100
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id MRCjnaoXpK8w9MRCjn49GV; Tue, 22 Feb 2022 10:11:29 +0100
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl1llst.bbl.ms.philips.com (bbl1llst.bbl.ms.philips.com [130.143.222.207])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 612E0182EFD
	for <connman@lists.linux.dev>; Tue, 22 Feb 2022 10:11:29 +0100 (CET)
Received: by bbl1llst.bbl.ms.philips.com (Postfix, from userid 10189)
	id 52412542248; Tue, 22 Feb 2022 10:11:29 +0100 (CET)
From: Lars Steubesand <lars@bbl.ms.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] gdhcp: Further check invalid data in dhcp_get_option
Date: Tue, 22 Feb 2022 10:11:28 +0100
Message-Id: <20220222091129.29525-3-lars@bbl.ms.philips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222091129.29525-1-lars@bbl.ms.philips.com>
References: <20220222091129.29525-1-lars@bbl.ms.philips.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a9f85c20-9b68-44db-d967-08d9f5e3500c
X-MS-TrafficTypeDiagnostic: VI1P122MB0221:EE_
X-Microsoft-Antispam-PRVS:
	<VI1P122MB02219FAE2CFF5E0E39FAB4B2BC3B9@VI1P122MB0221.EURP122.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OwnM+FGrzQJU8jT7lU+aeAqqvgsLt6+/1vDW/GP15PqffOozX/2Porge3nXCZxOx+fWv8RRIcQSjr8UJ4jTWQELHd/sqsGt47zHVj2mDie596nPn7wpX1xPeThZbZP9QW3fTbyR1vxIXU2d0f/eWIXIwhrd5OUkyRTn0AemCisEU0ojLRzDy0GRp5ckrkzRnjaNnn6npBQAQ9Hkc8wzWCV2Pl/lNa7+Z+4KeQbXVs4GHOW1h6yKvCFRWhO9sZ7NiUh+rVzNrlMcfAt7xwR9fcEqLYSssceqk4av5KMxjOdWmrM+cPPANO5RVL7yDZI1eL4Vle9IVCZtBXq9ZNBsuwa4wXL9ShPWbdriQ8MVpn5I4zBrQmtaawsxKId4k8QSrdlXw/aUdVrxdrfwTnXxgMK+TNk2h3aF0kTjvFrXpOj5dTrebHNvgKp9dCkHx7Ixz8h8fL8le/kLvaB8CSRx+bHqYa9pr8o8GdgQX8lSx9zGXiaHREm/GwkMgmqITE5F24waZmZJ+SALpgX+qrfEjnWZZi2hMyW4b9dX50x8w/KeiXqrbHe1wGC05E1Ijds8a/dhbooCnk/qBkGhimtkt+Gm2W8bD5fYWGuoKfYPC9li3+5Y0LAh6rx8r4Nk4cfMqYNjm+RugcnXBGsWiAk9Osd5ZrmzRuWgXIIBVgn1p0G7cxtIAAltha+5UB5cXIeW4
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(70206006)(7636003)(7596003)(5660300002)(8676002)(42186006)(70586007)(82310400004)(82960400001)(8936002)(6916009)(356005)(508600001)(40460700003)(47076005)(36860700001)(426003)(1076003)(83380400001)(2906002)(2616005)(336012)(86362001)(26005)(186003)(6266002);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 09:11:29.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f85c20-9b68-44db-d967-08d9f5e3500c
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0221

From: Lars Steubesand <lars.steubesand@philips.com>

Improve error case handling for invalid DHCP options
by fixing dhcp_get_option and checking valid lengths
of known DHCP options.

Fixes: 58d397ba7487 ("gdhcp: Avoid reading invalid data in dhcp_get_option")
---
 gdhcp/common.c | 53 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/gdhcp/common.c b/gdhcp/common.c
index c8916aa81666..b3b725f5edc1 100644
--- a/gdhcp/common.c
+++ b/gdhcp/common.c
@@ -73,6 +73,36 @@ GDHCPOptionType dhcp_get_code_type(uint8_t code)
 	return OPTION_UNKNOWN;
 }
 
+bool dhcp_check_option(uint8_t code, uint8_t data_len)
+{
+	GDHCPOptionType type = dhcp_get_code_type(code);
+	uint8_t len;
+
+	if (type == OPTION_UNKNOWN)
+		return true;
+
+	len = dhcp_option_lengths[type & OPTION_TYPE_MASK];
+
+	if ((type & ~OPTION_TYPE_MASK) == OPTION_LIST) {
+		if ((data_len == 0) || (data_len % len != 0)) {
+			printf("Invalid option len %d (expecting multiple of %d) for code 0x%x\n",
+				data_len, len, code);
+			return false;
+		}
+	} else if (type == OPTION_STRING) {
+		if (data_len >= 1)
+			return true;
+		else
+			return false;
+	} else if (len != data_len) {
+		printf("Invalid option len %d (expecting %d) for code 0x%x\n",
+			data_len, len, code);
+		return false;
+	}
+
+	return true;
+}
+
 uint8_t *dhcp_get_option(struct dhcp_packet *packet, uint16_t packet_len, int code)
 {
 	int len, rem;
@@ -83,13 +113,18 @@ uint8_t *dhcp_get_option(struct dhcp_packet *packet, uint16_t packet_len, int co
 	/* option bytes: [code][len][data1][data2]..[dataLEN] */
 	optionptr = packet->options;
 	rem = sizeof(packet->options);
-	options_len = packet_len - (sizeof(*packet) - sizeof(packet->options));
+
+	if (offsetof(struct dhcp_packet, options) >= packet_len)
+		return NULL;
+
+	options_len = packet_len - offsetof(struct dhcp_packet, options);
 	options_end = optionptr + options_len - 1;
 
 	while (1) {
-		if ((rem <= 0) && (optionptr + OPT_CODE > options_end))
+		if ((rem <= 0) || (optionptr + OPT_CODE > options_end)) {
 			/* Bad packet, malformed option field */
 			return NULL;
+		}
 
 		if (optionptr[OPT_CODE] == DHCP_PADDING) {
 			rem--;
@@ -125,17 +160,21 @@ uint8_t *dhcp_get_option(struct dhcp_packet *packet, uint16_t packet_len, int co
 
 		len = 2 + optionptr[OPT_LEN];
 
+		if (optionptr + len > options_end) {
+			/* bad packet, option length points OOB */
+			return NULL;
+		}
+
 		rem -= len;
 		if (rem < 0)
-			continue; /* complain and return NULL */
+			return NULL;
 
 		if (optionptr[OPT_CODE] == code) {
-			if (optionptr + len > options_end) {
-				/* bad packet, option length points OOB */
+			if (!dhcp_check_option(code, optionptr[OPT_LEN])) {
 				return NULL;
-			} else {
-				return optionptr + OPT_DATA;
 			}
+			else
+				return optionptr + OPT_DATA;
 		}
 
 		if (optionptr[OPT_CODE] == DHCP_OPTION_OVERLOAD)
-- 
2.17.1

