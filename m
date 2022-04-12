Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130121.outbound.protection.outlook.com [40.107.13.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1A1FB7
	for <connman@lists.linux.dev>; Tue, 12 Apr 2022 11:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXD0u7w80ueyrTQ3wgakEInOf2qNAcbi/TfQWp3D0VYwyG2owlF22AAOYa7yYrf+rpT6p7FS8vpMlQq7r98r/OoNKK1MfsnAePETcfVOwIzv61WQHx9gz7NaqpsX+mrxRR9OCy6fBGFLMhdA1DMeNFwn/PT/dO/vFznOv9Jzlpgm2r1bahEezznkZn9ghBSK/8TGtzfEfJK94KUrJJBx8e4wx9TY03qUpAydKfs8FtmzXavu10Om1ODR4oBi619goTzAOMPWpxD6PvfVa13Rzd/Dg0+LHIEisMS2dI7YdaJXYhDG/YMyk6eDUvF6J4z84TQBdt2nS+WNdpFxcgrHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1RHukAk1FXpx/wEqNG+otDe4gRyxBpg+ULsi1DPEL4=;
 b=RIZUU6YmQ+/MEh5DTDpknXofyl8t9U7CrObkn8BJ/czMz8pJFeea3s8ZecMjLSlGEe3v3S/vpXPLTGLv+ykYEJQWrsZqDBVzMJJqlRUq++V9D+goxTcvRxMeyeRehhRmKuyKVV1rNu+JYDpnagtJOD1gvwZjOavTZLdIMDc8LN5yo9w87TkEPCI6zP7eAy+Vs9mIuLJrr5BSkhswUVIq5wWMs1VXzpi3a3+YHCmEMLGBmi15eJhP5ryOzVLLTbjd2NlYUMWaq1Mlpx6xlaFjNB/CF3BqSbIY7YhfoHRpmhWT7VfDQ/OELFIMnmA+7/7QJf9qiQp4HYBHGLCjXTMP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1RHukAk1FXpx/wEqNG+otDe4gRyxBpg+ULsi1DPEL4=;
 b=mKPnxlZEfbTGs0BmUK3hZl8T01/gavSrkdKhMxgHRdyCxR3g+mwkRj8dqADw48WkUqSbpA9CQ4F1WexH7HJV5c/FSWTtq5gz74nXQsHXIFjeSueCaPJq50D7a06KP8hVt5YHB+9RTKObAtIlyWWpPQtFee+WYwOSzQCqYVDFa8M=
Received: from AM6P194CA0073.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::14)
 by AM9P122MB0283.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 11:52:00 +0000
Received: from VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::8f) by AM6P194CA0073.outlook.office365.com
 (2603:10a6:209:8f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 11:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com;
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 VE1EUR01FT048.mail.protection.outlook.com (10.152.3.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 11:52:00 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id e7jGn5phVYo8veF3wnfVe7; Tue, 12 Apr 2022 13:52:00 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id eF3vnKrnWK8w9eF3vnTEP3; Tue, 12 Apr 2022 13:52:00 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl1llst.bbl.ms.philips.com (bbl1llst.bbl.ms.philips.com [130.143.222.207])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id CA2DC183009
	for <connman@lists.linux.dev>; Tue, 12 Apr 2022 13:51:59 +0200 (CEST)
Received: by bbl1llst.bbl.ms.philips.com (Postfix, from userid 10189)
	id C44E5540022; Tue, 12 Apr 2022 13:51:59 +0200 (CEST)
From: Lars Steubesand <lars@bbl.ms.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH resend 2/3] gdhcp: Further check invalid data in dhcp_get_option
Date: Tue, 12 Apr 2022 13:51:58 +0200
Message-Id: <20220412115159.2845-3-lars@bbl.ms.philips.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412115159.2845-1-lars@bbl.ms.philips.com>
References: <20220412115159.2845-1-lars@bbl.ms.philips.com>
Reply-To: Lars Steubesand <lars.steubesand@philips.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4d16bd76-a00e-402a-4ff3-08da1c7ada60
X-MS-TrafficTypeDiagnostic: AM9P122MB0283:EE_
X-Microsoft-Antispam-PRVS:
	<AM9P122MB0283F866AB29D971F1117CD9BCED9@AM9P122MB0283.EURP122.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rBsyKJV9vQlnLXbVFO+POCATGtynODVB+ZM6ZMQccZC/95TsyP6N9Vq3dz8tnyWj3yf2MTamds6g61CE1piFTMY5MI1J0Ht1jS6gWPrp1z9Q7GfSnCqpsclj7EJX+ipxrhmnpNXNZ9p67gfFLpGPl5shw+gzve09CpnezJNk13B1nwH2IL980owme4mDXhzHWbp02aZCeGMQXHGeeY2Zgc/8ySy+4E61Rw3cQ4t3fJeGPFYW2rb8bCLL7CN7u26AFPC5wsYH+NiNrJ8niLGlZSWFO4HYN10wQ9hKKSOJHs5A0nWkT1oKMv/x0bwDxKT3m/SMZjoFXW9YRzq9vbw8CVRbkAdOcWLMbDDwJvG+2ZBQhINgJ2PUaxJQpTOMjRsAv16o7dINK9Qu2VItGvNkDW8I2HkvUqZVXbuRfc8m4PMygXQQVH606DnS4zVA/CuCNE8XRYdogsq3ok47ciFQdr4rKiobQJIgrzn+MUlu/HOY0vndeobH+250TvSCKgqYKg/dohNnuBH0+cz/WNtO3s33XluEN2Bh33KkuRo6UK3H99x4TVtwXob/N4TZkcC+P4sxso5awJwg06j2uVqOHdx16SYbgFNMGbUVTvvHmmRqe1n6nC3UqtiZaTEcXMso2KnJ6/ECLe9ti0tefT1xDqdrh4PtgbdvMGAE92p/FBFHs6mCRjwx82qP0YvaGeT6
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(42186006)(36860700001)(316002)(8676002)(7636003)(6266002)(5660300002)(70586007)(70206006)(356005)(82960400001)(2906002)(83380400001)(8936002)(7596003)(40460700003)(2616005)(186003)(26005)(120186005)(1076003)(82310400005)(47076005)(426003)(336012)(86362001)(508600001)(6916009);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 11:52:00.0940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d16bd76-a00e-402a-4ff3-08da1c7ada60
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P122MB0283

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
2.35.1

