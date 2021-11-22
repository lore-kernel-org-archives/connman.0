Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2128.outbound.protection.outlook.com [40.107.22.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AF72
	for <connman@lists.linux.dev>; Mon, 22 Nov 2021 13:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcnIF0sn8NIt2HRTWEtdM9nGno+QKqdR6rotOYRYMzF2ZZb8k5CljfOrBc2wAkSu/PmO4O+ByY687xKE9zsaACzrWtA8meAWsFkYPld1EFF0GuB6xpuLlkBsY2uEmf6mnMu4YsKDQxEqSW8DR0zipUTPMaIiQt676gu/DD2+8+PslvlCo8d9CBgDt3QAQOmhLieEtU34WG7um8Of52H6585GdCxMOLYqWqWqY4uDdmad+pbpJPEUekjfZaArqTOGQfHIzKYrhndaaEqOHxr2EZD0MJz8Sop8E97RFGrVlxAnjRRezsyfpGKkWZlpYf6woJ7Xi2aoFzfUjAhKRayH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVV3/2xWIh917Tkv0JPc9xHTgPzMBVCXt5PFpA2MQRU=;
 b=Q25QoyaRVp0DkCRJjL10g3YxFKYGyj0SaALbMPcLqRFVaJ0tYUWlVjMVkOox8KRCAqB2YFrmDJLMmc3igKhwbbRolNrqlbfdUArWXNyG4TuI5tKvGwkQKT8DO36PiXRJSw7WH6Jiqu01v5oiZmXMvZq00l7ttTIGBfmLeRcJYOymU7/yegTRQAygmFHuggbBer/kC16IDyLtw+0UzBCMi/osHImn35Q7vcP9yfMlkbP4yss8dtK6Sxnj+LjAapdn8D3yWKNUnTAwuowx/F/JruBtlr+pJ4ZP5PesdEs7QYKcB8sWQI0JpBxS6t3sO1hyYpjBsZIJhMlonHBHePDVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lemonbeat.com; dmarc=pass action=none
 header.from=lemonbeat.com; dkim=pass header.d=lemonbeat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lemonbeatGmbH.onmicrosoft.com; s=selector1-lemonbeatGmbH-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVV3/2xWIh917Tkv0JPc9xHTgPzMBVCXt5PFpA2MQRU=;
 b=bLR7gZgrHPxlOFET8dVvP9PwLuijo5TH0AjyfuuWbtxaTkR8eq8c5nSq2NaW0TelgmnrmFlml7/BX/BptjPHbWCjSfUYRKOYEqaI2RUvhyIla3yoxvtfw6YNsov+8bSCJbi6vrsHw0z6vIHhjXIKPaqVQ/S/y3TYHi3VNojAlnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lemonbeat.com;
Received: from AM0PR09MB3633.eurprd09.prod.outlook.com (2603:10a6:208:17d::15)
 by AM0PR09MB4018.eurprd09.prod.outlook.com (2603:10a6:208:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 13:04:00 +0000
Received: from AM0PR09MB3633.eurprd09.prod.outlook.com
 ([fe80::70f7:5d26:260d:4a16]) by AM0PR09MB3633.eurprd09.prod.outlook.com
 ([fe80::70f7:5d26:260d:4a16%9]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 13:04:00 +0000
From: Christian Taedcke <christian.taedcke@lemonbeat.com>
To: connman@lists.linux.dev
Cc: Christian Taedcke <christian.taedcke@lemonbeat.com>
Subject: [PATCH] ipconfig: Do not enable/disable ipv6 for all ifs
Date: Mon, 22 Nov 2021 14:03:46 +0100
Message-Id: <20211122130346.114768-1-christian.taedcke@lemonbeat.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::19) To AM0PR09MB3633.eurprd09.prod.outlook.com
 (2603:10a6:208:17d::15)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from lbdow077.home.local (2003:d0:d71b:cb00:7530:3727:a535:9e02) by AS9PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:20b:46a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 13:03:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a489c066-6709-4bbd-d0d0-08d9adb88ce3
X-MS-TrafficTypeDiagnostic: AM0PR09MB4018:
X-Microsoft-Antispam-PRVS:
	<AM0PR09MB4018E0F33B17EBB7FFF68CEBE49F9@AM0PR09MB4018.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7xRM7b8ykMJBqnEA8GzH0OkLLiquqE2Oc2LevoSkd0zuryVI3fyFwSubVg7vO4vDvTQsC59429wn6bACo99DgTXRJAJ2J8vjWswqyheSQbKDD97zuC2jmktt9njAPQOf2hZWgC3RXR13iQuPSNOU8S+dhx1PlZW0Us96dp4LV4ssQNAhiaHxwKDF3uWbZOJ789izR00A6jTpesRR3uS0pMrgnPIDKH/1f+2Pu5BYr9vwhQdxh6y1ikjpPumkuJIQcVn0Gxqg2u3Hf18buq09MZkLNdQ2NBIp4HLlPwig9G3VrFUHitQqG8m04uN/ChIK6FptPAEUFRBKjI0PbZKg092UtF2OSEPiq/41Ug2MX99i0ZO2XHXcOm6n5D1E80v9TVCOkejp5u53WYIaWqqvkKex336UZl5UHGGCWXpyVY4a85rmNxy36jVziE8eKb8gCuKT9UefaE5YzEHePaDVaY2kxWu1KCRpf0Inau39F0rMQmasFGf5uEUitgNoWGrnq8J/XKrauTs1fl2PLy6pOsBFEZjm9yY6CQoFVAhK2w8WEbcW8kLyToqqSMQ0/2odYR98GZ467KW0MLdonQICS46KdxN/XqZ3F5Q8G/Cngkf0+PYcKFJA8qLczqlymFeSvoa5IBZIfhlT9H9n8wr10g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB3633.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39830400003)(346002)(2616005)(8676002)(8936002)(186003)(6506007)(6512007)(66476007)(2906002)(6486002)(6666004)(508600001)(316002)(36756003)(66556008)(52116002)(107886003)(4744005)(4326008)(6916009)(44832011)(1076003)(86362001)(38100700002)(66946007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHj4C/W/0cjurzADFLVLIsW4jb0R2NcOGDsxvvNtlhXEwksWu5hXv3UN5+S5?=
 =?us-ascii?Q?L+yz5XSxF9aOv+FKx7J2keAltNuvW0R/HCpQJ7GdEQaVZ6suB3DchZLvG23P?=
 =?us-ascii?Q?umKzaZzRSp9ooCfx36b5p3P4VBRjwLX156x69XgKmEVobBqZJuPIxIUtfucq?=
 =?us-ascii?Q?oPHNfObENoiUpt85UxB1zRCKi/3dZAWDldvb1EepJ9UEPERAYnzUgbUmd9du?=
 =?us-ascii?Q?nlzXdLtRObsGDe9ZHzZwYrDdMQFeyLZzmz84R2/z6c1yj1Ih77J2a5CCRPJw?=
 =?us-ascii?Q?Wxk9zKSJORdbxey+MEesPtUMWvi7+LhV2nac7tiiPg54nyp5GJEkzFwsHjfU?=
 =?us-ascii?Q?83Z726cGq7FkX3alQOyX7p0+7smChuyRC8zICCbw+bj8W7/cz7rskRY/KNM3?=
 =?us-ascii?Q?BUuWglC8w9L6l8j90rzVAVDZPekNJRIabipVnmObjlUsi2ySS6O1wPaMKzVL?=
 =?us-ascii?Q?dg8lr4htl+efVJ18yWHHmLMdU/TehkWnxWGBpJdwwqzV7u2eKDyomCOzCHoR?=
 =?us-ascii?Q?5KzKT57MsQincVG3OjcQDhnXiuZ+EjSNOK8r307Kc9V75mArBQD4j/iaEx0h?=
 =?us-ascii?Q?A6p2YiZAem0ByGVzWswjyZhL2PneqaKYcK9oYv5svQYT9TXHekWv9Ij5awjU?=
 =?us-ascii?Q?TbhWccYnZMuAF8q8ARbNNdwgUKPKdThPSTUzgLkKbTgLYGSlDXWOI3zjdrPH?=
 =?us-ascii?Q?ytSpwet2GbeTVDiAqc0Rka9UY+OKL961hQv3UEuZt+AcQegJyOlgwsTC8+TK?=
 =?us-ascii?Q?o8tMJ2oZG8JfP5HX2Y2zwGM7mL7I4ltv7yVGp/MEEWwfaqJU0zz71YvyEsVB?=
 =?us-ascii?Q?fQ0ZceZ7l9zh4hwm3Fev4i2KRDVDsMJmq4wHgC0ZlqHBpUwXDuEznV7J6OcD?=
 =?us-ascii?Q?nMIKUb78uniB15mrCzZSOLtlqyfIUZqTtl76DSpMTjzZr1qDMEhXkJda0cCE?=
 =?us-ascii?Q?p+je5G6DRe5J83oljmXvRK786dw9BU/dmXBm2g6O93V2mLSMNcCQxedWptgX?=
 =?us-ascii?Q?5sGa2DXutB6WRh10Kzs25Lzw9pjc7aR5B+/a1o7vTGlIrf+juvIwT1GGI/qv?=
 =?us-ascii?Q?c/Vg7a6nAwgKM44+HKUaKgNOMMttc2t9mgbu/NjtG3RaAoEV82g9yEOSWkMR?=
 =?us-ascii?Q?JR8WNOe0zkX7FyUacjf53yqAFLjrMf7q9BImRjVppyo3y1Afr8ZC+L6Fz/Kq?=
 =?us-ascii?Q?RQzadIxzUztCXfGsGTXktCRS1x/k4KAPxVbJrK1Q1BEMVQfT93uRDA4heLh8?=
 =?us-ascii?Q?P//tPtVt90PLbmXOqVhvZKqYERftmFGa5fvQ9Wxm8/gnRx0Z2dKJk1p1I9DB?=
 =?us-ascii?Q?3UUM1gNvwNv6iti8wYDgYk0Z1Z2lxaoKR0A6coHgawj+FWtHk7H50AKyyKyu?=
 =?us-ascii?Q?j4FfbgkmM8+x0rfF2vQWKvLYZYrSi65rKPt0CtX5xoiQODBXIiudmypCIO+r?=
 =?us-ascii?Q?R/rYLFhM9tCzeFK3jDwC6jYaPdC44xzsCNI0YFwXHCZIgrnNyoWOq4v4RiZd?=
 =?us-ascii?Q?xbXIm1b40eVAUf4/HNMxow1TZRO7zpT4uaIVgoZPVEnBCdNUm4PYCg44/2HQ?=
 =?us-ascii?Q?9Bpe41Aqk2+bwDCnIAyhSSXfonIJ8J7mXX8ffwKOT1G3TlQJPy3noJK5nlP0?=
 =?us-ascii?Q?xxRKBmVadI1bwszkHkZt+bMdPj90eKo2/MPy1KvDpKrh5ejpO64leC3iUqvZ?=
 =?us-ascii?Q?afUTX1lEjS5j66fGPecGrHcZxJFHRaKv4A75LzEbmKpr+8zlWpR557ssp8+G?=
 =?us-ascii?Q?ISVJLmZ3SA=3D=3D?=
X-OriginatorOrg: lemonbeat.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a489c066-6709-4bbd-d0d0-08d9adb88ce3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB3633.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 13:04:00.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ac10487d-0152-4454-bfcd-035706067733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAYlRSOOhJ1xfJ6dSB7fKX4O9EbC4HfbNIccxPeSMPpUfgmeO14UlwAf0OY8ce5M3O8nxCpbuGz+48icihByh01XvbpobRfZxwAln76G3gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4018

If the interface name could not be determined (e.g. because the usb
device was unplugged and removed from the system), do not disable ipv6
for all devices.
---
 src/ipconfig.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 1551826b..34b1724a 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1593,6 +1593,9 @@ static void disable_ipv6(struct connman_ipconfig *ipconfig)
 
 	ifname = connman_inet_ifname(ipconfig->index);
 
+	if (!ifname)
+	        return;
+
 	set_ipv6_state(ifname, false);
 
 	g_free(ifname);
@@ -1612,6 +1615,9 @@ static void enable_ipv6(struct connman_ipconfig *ipconfig)
 
 	ifname = connman_inet_ifname(ipconfig->index);
 
+	if (!ifname)
+	        return;
+
 	if (ipconfig->method == CONNMAN_IPCONFIG_METHOD_AUTO)
 		set_ipv6_privacy(ifname, ipconfig->ipv6_privacy_config);
 
-- 
2.25.1

