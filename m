Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2101.outbound.protection.outlook.com [40.107.20.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E751FA6
	for <connman@lists.linux.dev>; Tue, 12 Apr 2022 11:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+t7cH/ThM4P/PVar5Muq6YeV7HYa8n6VEslRciqxYEmzZYL9EAIXN3wri2+SKDBchd/UFMI04Bt8dO5YE1xL6WDNY5QrlM6W5KVY4TBqGxhvV7FHgsyalY0FRRc4OsdEaPjx9e4ZEWS0awUBlTOWoQSAW0pQNkJESz0SLj6Z9CMS5jGDrRRbssovxETFCn+u8mXhiJQHwexLtr+QJjyqQ/wLeRtZLvmfxEvtIECkryHusFh0SOrAENqujhdBPSvHWfCLNwW1myXHCh0fXuFDSyqtS52G8f8wBORP8H5/dBvJLc6gKr3Wc6X1ZOW93cncKAoUkq3DsQZOUXQ5I5F/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKms+ZjTuEZqPNvjw6pNQvxMBBGT1zlGV6M+Eu6rlYM=;
 b=ODkLuGEl1SYGjv3Khs6eWZoj3gm8ST4WBfxn3S+agLc2LncJL9kNvRCCuMBJFHQmFnGgPf5R5dB6pKSrH7Hdk/+xVCXk0mo2qauPM/5f2QHMeDy2igkz4mLXaS5Z7JK/8izbde5kKZ8huEQXaZc4qegy2TiFI8V8sv2mECfVQKNDPDa5f+7qSVjqDXGUkBCEw4HJoxjL9PqXjeDzHzzHtKajZNPnr5zoGnZW/crgQ8yFBaa0aGq1dREoF4pFSSngJM18dbbN007ebtLVvxUCJeAOfCa+gANxT2L2uFOhrFLb1spkrYtjzJnWNZF/uuXrL5g9bNcBJeyygVycp3+WfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKms+ZjTuEZqPNvjw6pNQvxMBBGT1zlGV6M+Eu6rlYM=;
 b=h6iu5m+AHwp1dCyGODnNDQjfKH8YfhOPun3sKXT2K1FprUWXphLCgXuJbEUjCy8R8cU///0vT1qG8a89PxE+h2TwhxpGjl1FYLdGicbsGAqEAKMfVo0pEZ84ZkK1Rqrg90at38TR8oZbGKLkPeu3TNLPn8e5giDFE0tv/OmFN18=
Received: from DB6PR0501CA0035.eurprd05.prod.outlook.com (2603:10a6:4:67::21)
 by AM6P122MB0162.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:12a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 11:52:00 +0000
Received: from DB5EUR01FT088.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::d9) by DB6PR0501CA0035.outlook.office365.com
 (2603:10a6:4:67::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30 via Frontend
 Transport; Tue, 12 Apr 2022 11:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com;
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 DB5EUR01FT088.mail.protection.outlook.com (10.152.5.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 11:52:00 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id e70rn5oCwYo8veF3wnfVe6; Tue, 12 Apr 2022 13:52:00 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id eF3vnKrnVK8w9eF3vnTEP2; Tue, 12 Apr 2022 13:52:00 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl1llst.bbl.ms.philips.com (bbl1llst.bbl.ms.philips.com [130.143.222.207])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id C0D9C182FFE
	for <connman@lists.linux.dev>; Tue, 12 Apr 2022 13:51:59 +0200 (CEST)
Received: by bbl1llst.bbl.ms.philips.com (Postfix, from userid 10189)
	id B84B6540022; Tue, 12 Apr 2022 13:51:59 +0200 (CEST)
From: Lars Steubesand <lars@bbl.ms.philips.com>
To: connman@lists.linux.dev
Subject: [PATCH resend 1/3] gdhcp: Set packet length when receiving L3 packet
Date: Tue, 12 Apr 2022 13:51:57 +0200
Message-Id: <20220412115159.2845-2-lars@bbl.ms.philips.com>
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
X-MS-Office365-Filtering-Correlation-Id: c959a94b-5be9-480b-0d1c-08da1c7ada56
X-MS-TrafficTypeDiagnostic: AM6P122MB0162:EE_
X-Microsoft-Antispam-PRVS:
	<AM6P122MB0162E92F5A4AAB26F47E8753BCED9@AM6P122MB0162.EURP122.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W+0viJaCfxQcH1/4k3+trRVmHHRnniLMxP9xwDwxIUe67IuIumuYXFO95JwT8kzPrRBihGJxM62gevSnviEPbcTPKZ28MCeM++wFgLBM3p2nXs2SdtfwsrhzE0oi7KczjLq6KkZ1C15eU5ghuW3zROr8gcxReSgLi92sZmLlyyZ0/2TPjfa/skKi8PT5WVTk45XEnNzG1hPT2HcbSaHX7tWOt+Q58RBwN3HDa7m3xlPKrmJ2LOyHYWb6A4/PfILwymQyPNVmB58b4X2NKZDXL/mGaziD5yOjYCilP519xo+GkiyHoD88lAVvWDwaXTyGJFzzw3KEYoMuLBpaNe7TtiChW4e1N03w5Uayx8DSZzKqaHSsq8BNOPf6FfMkMdwYVRAPDB95rBiouTatpcrZIS8PEYDCAvccp1A2FnKKjp4x0NIcU9NxagU+0NpENq3kdi4l0fP5/NjNeKBLDglLCPNR7fCdip5PNI1gQZ8TtHuybB4qbuOsUdViTcQGtB1tnzTfzIUJIKt7rni5ZlF/WT5aGkAtQkmtH16c6Qd2Q7LUExZL3cWPkPBsN0+uq1yLVsH7N0wJeJVVBmst+twi9AZgimzT/5SPtTtzJlZ7UETThygTc9DdrBvaupTdIAkqrRxVbDngQBDtvEn1pga0RTviRAThRL0HVcsau4PRq5acr8fxc0c6C7ZdgFLXlmQx
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(508600001)(8676002)(86362001)(6266002)(7636003)(7596003)(40460700003)(36860700001)(6916009)(47076005)(356005)(42186006)(82960400001)(316002)(336012)(426003)(8936002)(82310400005)(2906002)(1076003)(26005)(2616005)(186003)(4744005)(120186005)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 11:52:00.0381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c959a94b-5be9-480b-0d1c-08da1c7ada56
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT088.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P122MB0162

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
2.35.1

