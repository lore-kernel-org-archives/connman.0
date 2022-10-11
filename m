Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656728F6
	for <connman@lists.linux.dev>; Tue, 11 Oct 2022 09:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlLTnjhjR0fJ5WqEehw0gzhMnCUrU0w4/BdXTDmbtbtUxY7s+GLC5tcsUgSjeuFlGYbjMZlo/pWlbl79R4Rl207CGq36rAq9uAlWPbCrNC5W1dofQrnpLihHqXn0EMMf72BdIHzFxx9tQ8Rj3jgN68PLCDFdUwLKnyS4ENcGfzDpSQ6g6rV+C65Lwkd/9TLXizBwf2Kfcp/7zCi3E4zwqUZ1NYSp5hQlq2b2V++bY993gCv1rcwGoNWeQalp+oivJE2QMmklBly8OEAEQm9rbFZTyOxucJ5pgRVrMcm4PuFC8suCW0X2YqowHycagz2NsUe6bIw2FoMJgUSTFA+QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwXw9HPAavl1xYI5eiqD6fMkAHE78l5j96lV0S3+5f4=;
 b=H4XuWDpwabccQtS0Pco7W2lwjmxGnpOVWXYGgvfZFv3nwgm+7R5HC3xGV0HxjLhfmHwe8plkFeePJ3keLTBKpN7r1HotSWoHat6jmsA9YWsRZcOomh2ywvZezB11psBcXxPkcYQZhuXnEMlxD0wo5DYEjhwUbQtwmzGmwNmUYKsQ3/Mc/9rKMUzEnwYnpMpz9bBvOHQ8vyd/aRatqv6kZWXE2eXwyLlcV3OaJ6ZEGBxBUocAPpifGNni++qsgY0cuMFHc2fHf9DHjHFXaWsMfhDIsUePZ0pzwXYPtcwKyqETp61nkw0prfb8B6fk1It0dPvTLZ4x0hyIy7brUaeryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwXw9HPAavl1xYI5eiqD6fMkAHE78l5j96lV0S3+5f4=;
 b=GlFiInwaq8j5fPdEA9PKzem3m1Rz8TIjNvKVDS1Axew5uryE1yBR7IcLwVYCCpUu3J/xuWvOd+zIWpMGOEq3i0RyXGL6FYOD1SDRd1lEmLwLXVcuOdrZCTTzLY8Iv12JOkMAeIDejWa54BAG9x6UrS+Y8n8N5SeRu37IElxKj1shIx4RnkfP6oW4LbQLd4mQdhNaA1apZd7PgnILMbLqX2eFvuIHZ32aX2JCvkpMFi+0hnr9oLAfGWXZd4KkGLIJ/8+bQQFehQ8xzbSjRE4x/DvXIvS+iq09eKW3kj+guyM84isBJ2bnvIxVJbRPFlEVCfmPOlvkuSha6Ypmgr+vYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:21::32)
 by PAVPR10MB7058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 11 Oct
 2022 09:56:58 +0000
Received: from AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::646b:6d29:4cef:1cc7]) by AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::646b:6d29:4cef:1cc7%7]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 09:56:58 +0000
From: Christophe Ronco <c.ronco@kerlink.fr>
To: connman@lists.linux.dev
Cc: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] Enable Fallback DNS server when server is created
Date: Tue, 11 Oct 2022 11:56:40 +0200
Message-Id: <20221011095641.19310-1-c.ronco@kerlink.fr>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:208:14::17) To AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:21::32)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR10MB1795:EE_|PAVPR10MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ccdb52-7c5e-4494-b47a-08daab6eefab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nMpnd+gz+Kn5or/ZDrcoiVUAXHvAOnqq5ltDYJTh1DTWaQn+ZjbNW9nL69Y0z3m2KUtYGEznc09R6nEa4FQr9m6kJaeewelsdQQ9cxWvhqt5J90vB+msMwlMAheDAMsBd+xImGmZ5qucNzHpy8MwJb5137Wd9CQ8TfYpln46P7glbizOfIYib/gPF+xBYVLVdtbma+3ce7IcFJ54ET6U8I+/m7plOQWCBw0d7edROuG+btFSZ4wl6rPf4qjOeV59a4MRdtLeHxLFC2HGWANX/2XfExibsj4i4n8epJ893YftUG442XppvY6nS77FyXxugdwYGKHCY4fVa11C7kV9RVnllTE6g9pd+JIjLaFNS1vMQi3lQ9CIBA5gzgWJhyAy06W6TAFoyu446DUU8E03uR+VFHzjDkSyI+K0LpE+Z8tJS8tGi8mw7qerdjVbulv5YSVsZgvoqkf55nZfF4e6akWNYoiqM8/xIAOYxulG2aBQbpTIhrwPLFS/QjctpNvM3q+kiQARs58nyXt38D3O67MTkfpJKDH0bWtHuHQ5Rm1p+QIYcK3HI1Ln5Gy7lkwLeNy2WNFduQc0gmmkEMZJ/FOOj/V/DtOuvZQWOdfM5kaRY7BHvMfVX3v9V7bG4WHqFBQvvlaMokNDqiVcEtoKQ2VOH1ogLssCDHWAuxM/QbssrDG14zlWFBlhhkatP0KPqpIA/GJgfg/Uc8rJ43Xq0+9vbd8RkqGZxszzpfMT0+Ze4smx/VL63afHkKBDJUS6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39840400004)(136003)(366004)(396003)(451199015)(41300700001)(1076003)(5660300002)(66946007)(2906002)(6512007)(6916009)(6506007)(186003)(52116002)(66556008)(316002)(2616005)(4326008)(38350700002)(8676002)(38100700002)(66476007)(6486002)(86362001)(107886003)(478600001)(36756003)(83380400001)(26005)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5o1BvzTnllQbcXNIyhpzafRAIVa46S+W5AjxEo3OmuysP/ZBla6ccItw7t8?=
 =?us-ascii?Q?17N4rOr4uplWWGg9qYHbOBHsVOF2ImxgWafyYxonZeQYSPAgVzQIKpdq30JB?=
 =?us-ascii?Q?qd3dex5vkW7phbwZfHbAx4b4C1nFbxSFh7C5mj6XAElm41H/ywfBGLKCGMbP?=
 =?us-ascii?Q?QjGuVHIAlr4q2Bx36K9m3Ne9b157UXU5F4FiOJocRbFgNIO6cSD+cqkx4wwm?=
 =?us-ascii?Q?W8Vp8UM9vB3aFi9uHslUr+bkFVuPp4Rvy4JNtrUanEJwjFgsQvmjkjZK1XUf?=
 =?us-ascii?Q?wtriyaD7r1UWwComVD83vrVgfHmwEImHiKzQ9mik9A8MSja6IKZsNfM9Ybk4?=
 =?us-ascii?Q?wSPn4wonYKYSOvAZjG8Vwbpjhzstvf8Zfshm6yHrO2HAl60AV7HllEZKWkPz?=
 =?us-ascii?Q?Ytv4H4dwqGqjb6tM4NQFFbTAErYMLAmoWx4EYPRJoO82aPpxb8eCGDJC0k3D?=
 =?us-ascii?Q?RkUqVG6pQEvGKthhldhKi8rusG75kpRr9wWq4q2R3cDPt/v5B3lLK/ERr7L/?=
 =?us-ascii?Q?0aO24ay4GGlTfFl4x9kzBlVM8/5R8tE954CyiEDpJOXc4FitJi5rde3HybsX?=
 =?us-ascii?Q?7QTD+l79M2/YM9OUEJ92/fnG4TqpooRUbHQT6zD5S6IqP1VselloKcD0g6Zv?=
 =?us-ascii?Q?1OzWVdSZ7R2vcn+OKL+hEwPHfvnaG1TSMTUok9EtUel9UOJRoU857oyUZfZO?=
 =?us-ascii?Q?lbuD99JvEFL5ANhqLkhlc4u7ZI6uyPlWiMZCoSrybWZ01erU5Khd6jFkggvL?=
 =?us-ascii?Q?ppw1PYOpSGsLogpZlQvD5xIPTWFK2q88zwhuTRsi10sgO1cvINDUD2CJT/2x?=
 =?us-ascii?Q?+PbwicrEyi47D7+g9zpC0D/Z2vmCza9Q8LO9CNjExceCm9tZ8mwszCY6rd0x?=
 =?us-ascii?Q?zlTBVYvQh5+0+mYrRD8HnlkBEOe/6VswxRGj8ccKJjZw960k+UEyL9/oA9Zv?=
 =?us-ascii?Q?I5Me7E4shhSlxxMxcdTmud1XlMOgmwKkqJFNo0vA9rnIuUorgiBoi/1lpNgs?=
 =?us-ascii?Q?EKuncQxXMutd4rf2bFexHKVDS8wEksPaltMKIRlTr/GcoWmm3ejgRfsClsn1?=
 =?us-ascii?Q?3ag/j1iaRuCUdPklfL0LXww+lmmVVSR4Mep6sw5WH3RZ/t4IYdSQCFwKb2Ll?=
 =?us-ascii?Q?6VnwWZKIjaOvBOYyxW4WbOeLBPagO2C4S7UtviloPH4cFcmG0LTDaheP1Rmf?=
 =?us-ascii?Q?X1Ojbj7hJ8Js7kYYH5WFBA4mqPkgh3vg3W/nN81SFDPTWPpfKQWx7FLIALPc?=
 =?us-ascii?Q?6n63wAN5CNv30w89Zs1Pzk+Wwr1BW3G7HaaPDjRUL2qFr2Ahia/0vjpbnFah?=
 =?us-ascii?Q?rrKpg1RHppInWOZDu91RarZN1qxywms4nOgU2We+vMFnKuqoYXGu/OjDgukn?=
 =?us-ascii?Q?Hx9TPNbnS5RK8StWiWMNxiTTk8vJHb1PckB86B35WW8pHNBSeNf9r16iuy9R?=
 =?us-ascii?Q?AUHUxTmtYwU576Zx4zDkuur+NmL4Tb0IQYw3sJG26zmSNMJ9tdzTmvCyFEkn?=
 =?us-ascii?Q?VMFYl6MhBMV5g/bKVHPvZYHQjIfo8IZZcrS7GAL0gKPugROCPtVClWmvvJRV?=
 =?us-ascii?Q?Z6+0gIbtc7rrbiZFfG/oL9yX4WN9809c7zTo2r0W?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ccdb52-7c5e-4494-b47a-08daab6eefab
X-MS-Exchange-CrossTenant-AuthSource: AM5PR10MB1795.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 09:56:58.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3G7//QXvGRTn5ul46AMk3qQXC30103H67+e6O1vRtUbepwVWiVtP86IGYFEpJ5G/6rs07jHTO+gOYBzABwoXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7058

I have a DHCP server that do not send DNS servers along with IP address.
I use the FallbackNameservers option in main.conf to handle this case.

After a board reboot or a connman restart, Fallback DNS servers are correctly
displayed in service properties but DNS requests still fail.
If I disconnect and reconnect the service, DNS requests are OK.

DNS requests fail because Fallback servers are not enabled.

They are not enabled because when dnsproxy_default_changed is called, DNS
servers are not created yet and enable_fallback does not do anything.
Then when servers are created in create_server (dnsproxy.c), they are not
enabled because they are fallback servers.

I made a patch to change the behavior in create_server and enable Fallback
server if there is no other DNS servers.

Best Regards,
Christophe Ronco

Christophe Ronco (1):
  dnsproxy: enable Fallback DNS server when created if needed

 src/dnsproxy.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

-- 
2.25.1

