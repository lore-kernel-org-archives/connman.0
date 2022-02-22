Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF62581
	for <connman@lists.linux.dev>; Tue, 22 Feb 2022 09:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3i3sjPoyjBs4DiAd3M60iTVCPH5HMgvTGwQdNaujI3j4WZfmRe32bPNTg5v1dghCmaDUHbLzU5cyfhmG7vgFW/PNErcRNt2X/thw2dwQD2lKbfP8o9dUzHW6HVrj+3XYPqFH/YgCQdSh0ZkxNuFdYaAsODj3wib+hIbZ6Ol8vsSsybzILV8Si3QlNHlQY9mxYhDZ/VB0fvNfPa4nf92CxM2hTrfbLM2SyOSlJPk+YIbmsLCEM5p8ASC/YHnOyQUCr53lSdSvImjbNVVqkYwc4+waocP9P9poauKEZpZFtMHcLkL+v6qxngrZtYqe6FUNHeqxIVakELYWq/Lm5UA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8hYTvciLCZYa8SQF9Xs7hvNH0vCvrz/Rt6KVcO850w=;
 b=G2tFWUmMLiZKkR8UwvJfERiiuFl70wu9G96E1R1AYqqqEUIHEtEeJ1NDKp9AaEpebxck3+9I9nhyirx4v2zTrFsr3myHAumyZkBkSqxgjrJ4UY3NTgA2zNglrx5NtpkszRWrE/rf0dP1HNuZFN3g4qwsgydw4VbHjCvrJgw1nftvMQXeVbP2wbeKayKPtSr3/P1NIGmxGAtWz+Nd7xQzarzIfHGmETXU8RtQ4urOuUrCTq7SAHFqLI7oBwz3AwHN4KEwsNk18t/4GjBo4leBd6rl+fG3O5JBR6m//O6k0rwqzPUJvFsYybeBcLO5X1DYc1WQu9uNShkFjmuQK329xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8hYTvciLCZYa8SQF9Xs7hvNH0vCvrz/Rt6KVcO850w=;
 b=eFzJsnhRXiB1eZHXY+DxXGNSItG3PEEcnuThqKM7LPdWm0ahrpjdAGvojJzT01gThJfMRX6f+Kkh672NXQaIGr2zFsROn5uNUZ33ThoQA2bMoH8o5q+W9LHNTNc6u4pQruVsybLVPlThYrl0Na+Am5Plj0JzfMlFAoM6c/NaoOE=
Received: from SV0P279CA0023.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::10)
 by VI1P122MB0080.EURP122.PROD.OUTLOOK.COM (2603:10a6:820:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 09:11:30 +0000
Received: from HE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::2d) by SV0P279CA0023.outlook.office365.com
 (2603:10a6:f10:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 09:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com;
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 HE1EUR01FT060.mail.protection.outlook.com (10.152.0.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 09:11:29 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id MJXKn36rmTYquMRCjnmF66; Tue, 22 Feb 2022 10:11:29 +0100
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id MRCjnaoXoK8w9MRCjn49GU; Tue, 22 Feb 2022 10:11:29 +0100
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl1llst.bbl.ms.philips.com (bbl1llst.bbl.ms.philips.com [130.143.222.207])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 5C2F9182EED
	for <connman@lists.linux.dev>; Tue, 22 Feb 2022 10:11:29 +0100 (CET)
Received: by bbl1llst.bbl.ms.philips.com (Postfix, from userid 10189)
	id 46707542246; Tue, 22 Feb 2022 10:11:29 +0100 (CET)
From: Lars Steubesand <lars@bbl.ms.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] gdhcp: Set packet length when receiving L3 packet
Date: Tue, 22 Feb 2022 10:11:27 +0100
Message-Id: <20220222091129.29525-2-lars@bbl.ms.philips.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b62c379-3079-4bcd-e9f8-08d9f5e34ffa
X-MS-TrafficTypeDiagnostic: VI1P122MB0080:EE_
X-Microsoft-Antispam-PRVS:
	<VI1P122MB00801C50CE5D553C99980116BC3B9@VI1P122MB0080.EURP122.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cw5ygb/U5zGqLRYLAq7cbzY0Y6VeqbKaq9b+t0qTohyiUYoYie5n6rpHEnVDMyjYLzAt6egyaUzLDbykHPfDjdzKOZcH2Dtx+4JQ88XUMZRJ+IMw3+8/6LxlLyELrqLMF7PgXaV5qoW9n7muJTcoCd4nXFw3dq/Qhvu1zpaZW5Cl/TcuJCtXgTC/q7c+Eu+o8uDKV/GWjxpdHIzPtupnyrxOFi0a1g+JW+dRw78AJdXIcZZzzdSjq8bxS8HeRZB4R9qUmlZChkRFASKd4OKYJSQujl2S5SuLhDK9ETrg781vsxkNC6pi+mJIphbyXV2Xs9j2Ry2Dth2OF9AG/VvJqcjRgheM1LlME2H9mxGcJkdMhetReLeLZFIY1jCjSokn17JzbAcuwGVSm0JXobo7CMzQ5eLt+y7BLULw8NDe1hiVTqlyDEnGiSOnBP4Imk4DxLvy81P8ldPBKuK3vsuNOdL9fO9ygIITlL0ou3/acsfMRVr4nJki2NABdLxILnNERp9UIE9LBNhdF4B9w2AM56yR2gdIyi1LKfAk88KUW6/X86JIRN4aAxVwnr5GP5XFRUJYXCDPAii/b7ANiqqcrl7yeubriPP2ZoN6YTZyqJt+gQ74l+oAbedvlJWo/elhx9Xn1VY4D+Nlw2zYB//te9sutwUBKcT7ea9eA7DCM+ISW5tRxi9J3TYFwRhANx1O
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6266002)(2906002)(336012)(1076003)(186003)(5660300002)(2616005)(82960400001)(356005)(26005)(40460700003)(47076005)(426003)(7636003)(8936002)(4744005)(7596003)(508600001)(6916009)(8676002)(70206006)(70586007)(36860700001)(82310400004)(316002)(42186006)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 09:11:29.6923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b62c379-3079-4bcd-e9f8-08d9f5e34ffa
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0080

From: "Lauser, Simon" <simon.lauser@philips.com>

The L3 receive path was not setting the packet length. As a result, the
DHCP options could not be retrieved from the DHCP packet. Thus, renewing
was not properly working, e.g. IP address was proper but netmask
was default set to /32.

Fixes: 58d397ba7487 ("gdhcp: Avoid reading invalid data in
dhcp_get_option")
---
 gdhcp/client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index 3016dfc2582b..dcde98ea95b6 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -2314,6 +2314,7 @@ static gboolean listener_event(GIOChannel *channel, GIOCondition condition,
 		} else {
 			re = dhcp_recv_l3_packet(&packet,
 						dhcp_client->listener_sockfd);
+			pkt_len = (uint16_t)(unsigned int)re;
 			xid = packet.xid;
 		}
 	} else if (dhcp_client->listen_mode == L_ARP) {
-- 
2.17.1

