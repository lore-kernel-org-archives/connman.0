Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021140.outbound.protection.outlook.com [40.107.39.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341635B656
	for <connman@lists.linux.dev>; Thu, 12 Feb 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902865; cv=fail; b=FJgEgRuahCV6cfvcNdSQFi8h0p8cz8VTsgnLblJcULEkEcyx7z90Uc6VKzr4kocQtZa8zU1v7KFqPdt43eMnwZNPvB3RgvfdHCs5nYrUWTs6nAxvlN7xQAfDm6UmpetAw67YnOYe3KqrmHWpqylKaJOXqEwzLbrWj8MPfUeu+kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902865; c=relaxed/simple;
	bh=1Qij37C2QXBlWiYhdHZj0hbu+5AD+Jc9vVLsQJAKuFo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BMM76NqfRJvOi0jhbhOZnazZ+9dDer/0tYBMFIeqFZ46PP5nGvsTnnFldGUwlku0UOj/G6VHtCGwbYk5zKpHNuySaxk/7WFCeHfljhFd0cUmWW4hfNEs8P6eJTjVkgX9G5xV/9Occ2j0OrkGyXJiraLDsdIa2pVTEV+N1ozZ8sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UN9lJXLdqEDMRovsg053WxNaAdtEKLc5C6+6nH6tnTwh2MkD9dK6ILMIPnHGdl+q5Rgl+Vp6os7tfe33uBtFpI2SwwWp7Ym0FV27HPtFNbYFSnWCcXoP3ODbA98/spXL8jwHexcXd5dLk26v8+y/EUAPdcnkMmY5Q2kLN2LAcj7S6ZyFu1xRKeDG5sAXzZpLtom0kjEr7YoN5v8xtT7vcGY9JVOi51KNmg2HNO576Ot70wxcD8YCafAQI/5i2nYA2PUYylBQWy8GJXpg2PpMYQNjsNFNL6V0aK5rXQ7x0LjBDuu5/L4wzlg7zlh/dBzAl4SuZ2y9Ewiuw30qEfyyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKGXBw2ean6ZEd6k25cwX0vif7/KKIsFdJ4APsBNlcY=;
 b=zPqZG2trkohfyJzffaFy+l9DIBuKF+HVc85jLVN+nfs/GXiLJ4Db0ctzaWGQrwVlUp+IRoGVP5654d/Uguzv9WlPNRNQ/qYdzXeYBZuuLq5F56x+8GJGB/2/rkK19mz2uHtyKx25iR+AJGSTWRbw/bd4je93VGaltU+stZ1n5hwoRRAd4ARlGYiDkC95MlGweDSiNlUtHRZpX2bDuUn4Jx4+NPVrCD5NL21foliyVUpmKFyMnrq+HkNxh3foluA9bBtYJIosBYSEY2sN8ELfVWw7J7zOO9nwez/2z/2+IozAjl1DFweDnqabNq7HoAkxfBie/d9mkD1oRyd3eQzQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 ME4P282MB0838.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Thu, 12 Feb 2026 13:27:41 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 13:27:41 +0000
Date: Thu, 12 Feb 2026 13:27:26 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: connman@lists.linux.dev
Cc: rudi@heitbaum.com
Subject: [PATCH 4/5] dundee: Fix issue with const return value from strrchr
Message-ID: <aY3VPvVuJVv9ZTyJ@01676446e9f4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME3P282CA0162.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1c3::9) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|ME4P282MB0838:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e646902-3bed-412f-dd6b-08de6a3a7f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5V94IVQ+CqC0w4f+uHdA3HF9M4nWjm/Vw2W3lo9t5/WuGsShn7UZY8JgxZpj?=
 =?us-ascii?Q?S/uFVAPURE+8FtXUx3QOcOCEDBVrXTx7uOSbemDnZmwZyIsyrK7H+bFZRVSG?=
 =?us-ascii?Q?duYiBQFBl+2LHmDz4zFQFPbeyC84kwwcGgc5qj7xlA7uusIZXIL2vveey6GX?=
 =?us-ascii?Q?XQEju6ncjADB6miTLp+qLfc+Gy3+dvFWha0JxXmGdiLpHtON2f5P/6hGfIZU?=
 =?us-ascii?Q?gLQjKAOIsD++Khztx+5rUxtGgqEqn3/1GQ1gEdFhM65i4n/JJCmXsEjvPKI7?=
 =?us-ascii?Q?eqS+jUSpbfUjo9P+4lJkX3yXfupZScQvutGruz1yx3TXByzsgSaS/2AfrBZD?=
 =?us-ascii?Q?b45KTZTZl6mZeBRhVTWSVinxH3JT9/0p9y9ADqhlOMciJ7ZEZlfrZtiB7gWO?=
 =?us-ascii?Q?XOJpAM9q2xUxZYQLyFCkZTBL8PDkEPzyarL0OGKpyqs30yODvrtO1doNwhhX?=
 =?us-ascii?Q?OA2GablMnYaFI6LQmq5CZELqpY2WioQpQ8Hcwlp9vcrzO3g8QCQJJEEvCWHk?=
 =?us-ascii?Q?7Jp5n0Hg3p/2angFl0EWAIwmlfgj0JMFLlimATR7iI0w9y9eqlrra1qoLu9P?=
 =?us-ascii?Q?V+T+zocB51FK1frmduf56PDdU+7sB/meD5HW1hSYIYuBhO14K8EEAYUOipdl?=
 =?us-ascii?Q?nseASeRr4R9GSsbKj1pfh1jY+n9Ruwbh43Yhx6qyDua91ib8+9NaMX8CzUQM?=
 =?us-ascii?Q?LWGF8RCq3E5AvIwbVInmyTDJhB/u+YXzPb6Js6FOdcKBhLGwoShJvHp1OpFL?=
 =?us-ascii?Q?jIpH+QHgMBNlLvvxGrtBL3HviJJW/uZ7QCMHrYTVQCo+lEEkjJB3OuFdKOks?=
 =?us-ascii?Q?8gL39xacQqasI7OLWaNhee1SREm2+dGC38rw1M/0meqqB02y46kYgHgDOSUn?=
 =?us-ascii?Q?ZPXUqGMVwAkj5cE6OG6l7aAjcG6XBUTzKarX1IZh2HMASJ5a5Cm5/31wp8fl?=
 =?us-ascii?Q?uVbkY96HNBxaoKjEGw5Tq5+Wb3stz9G4CPiIoBYz2taC4x8gal+F+akRGj5r?=
 =?us-ascii?Q?MPUsZrns+SAy7LHffw6V9Oyvq/oZUtZmMuCrgWsxHv0Y/DV9fzXNmWdXDlvb?=
 =?us-ascii?Q?z6k1bqVOToiiMPuXNDIA/kYw8DtTmTA1DKQr0EpGypItRuOTwalKUlrZKUfw?=
 =?us-ascii?Q?zoiwXsJzn40gD2Kp4cpCGhyeae0PjhWRXBxHwWmeo3njIfymoXHR+EdENynw?=
 =?us-ascii?Q?AgEBsG0rZ16LjGz4ahidVhRSa6reBiRMJUIztxB6MoTIe/QqDy9CNWkCxuCM?=
 =?us-ascii?Q?ubxUKuWisyU2SDurUV2ceuFak/HkmWP7VcrnDfIU9vyaTHKp0Cq0wx3fcmCw?=
 =?us-ascii?Q?s4tVRr2BeExG8u5Mf5k8ii1NLMzimQQ2Gslx0agPLroulln80+VOaUmmAQKV?=
 =?us-ascii?Q?EFe3UzIfOkGDuVMO5v1ErbFBt2LbV23EmmLxWPYYDUYkhw9YhWFo94xHsVmt?=
 =?us-ascii?Q?hHOOkCyyKyKt4tU4/I5+JlNmAzqL/57rLkPCEzMjBsLwhfonxPS0vu7xrTgq?=
 =?us-ascii?Q?uQ2i4mSrU+lGynIM5wowJV+zMyKKdBLlGLSucyIZluEqWIIpmcIbCQ27yJRO?=
 =?us-ascii?Q?MBbdS+hO8hbMP4y7K3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xCfMmBxaqAN06SvBj7mRC1dfN/TK6HHxJZc33iQFJbMEwzMFQtdxWS1mbdtb?=
 =?us-ascii?Q?cb+Y0i/l2qNtuqVRxHZIhooOzYnK7LdUtDM+JXRNb4LcwCYknYW/7g7P/uXy?=
 =?us-ascii?Q?9iPImpG1/L/7fWjlWh6sMKE5s0qiNj7qy8dxTSFMMD6pgj6w5gHpiAFMrljU?=
 =?us-ascii?Q?pPmc5eXIPyAZISKtEpuY2S5vVNbDi9YIZZ0y/+DvKzShwXeEEGt3ec6M05OH?=
 =?us-ascii?Q?AIfNNjpFJAZ1Do59HMAPu4odBCSjl/htU8zLXW0g2jJHhpAITI6Asx/udpMP?=
 =?us-ascii?Q?2L7pwrmnKCWFma5EeoTCskoQwWT4NLjGXze3oJZ9GpAoQuXWNpCrLlC8zQ7u?=
 =?us-ascii?Q?ixJ+Qmrhp2A/+lABYLAqgeqqBWXmbF78PYEP256e9GwiUoDgYSoYXr+oFP4F?=
 =?us-ascii?Q?9JPA+WjE8KhxxBR+x+19vEckpUiWHwPMLCL+yDEaxEO52nMlEP4ghwdtG6MS?=
 =?us-ascii?Q?NUFdW3mMoJDbe9/S84xtknBNm4StU8DrsU0DKnt5KlDe8FDOCRS8Czz7VNQi?=
 =?us-ascii?Q?9t/JMWxmh9fMgZvZIPxucj3CJqlHERYr8hdjdS17WrT/sOIiBVuQdBcCPs3a?=
 =?us-ascii?Q?asLUqOEFMgkjIjJKijSij27Iy5HzvICXoLYIFy0K2jCuA2wIt3nkHJVP/To2?=
 =?us-ascii?Q?r9UtB+5cbh4ny88H/6WQf9kuzQ+cy5MWtA19dfAsihtOajjrqTo4bxlfh5Py?=
 =?us-ascii?Q?0gu/kNxwOXUN5sOu63AdQKkpHWQwea4pgbSKVTudjlGGgwPjOq0F+lPbl3zu?=
 =?us-ascii?Q?JdjHXMmEFuYVrQm2lX6AIDr4yhSnh//K1ysafQxX+/yhivY0j1HBkdfTr4Jl?=
 =?us-ascii?Q?FKVCyp8EKWFWuIYQg+j7nVwWm7SaxCV5jzHgjXCF8FqkOIxnxbu5y/k+5B3C?=
 =?us-ascii?Q?Jb7QYVFvmk9afnS9B0MPvt13GodD9jY1KCQ58/SuAKgrBdXbPMbl9X4rq7Iz?=
 =?us-ascii?Q?XnFBKhO3Q79R57B1lw8hm27S2EviCwlmgqnvKVOtGs7acZ4/VxUUX2frDAdm?=
 =?us-ascii?Q?mFjlrCp5oOyk0RP/3Kdeu+CqkgHvzQIpsjPfK8aRK7uaEJPz+jRwVZECEYaA?=
 =?us-ascii?Q?zrdelujLeiaREgyZmg1P7/OUM75hNqUaunFU5HFZlRRxBx6n4s09fiCbN/HZ?=
 =?us-ascii?Q?rm2po4mcT03lUHT4PR6G7rLOavwq/bUisw44KTB3ENLMHKqO5qgdas0BtbcI?=
 =?us-ascii?Q?urmaXACBXrpqHmLbGwhTxpYos5n85/A+Dcc+QAibF88yJGpU05n9D/tmIPKc?=
 =?us-ascii?Q?VHNhUFhHS7aVZ5V6odzTFtCiOM1aJ+c9B8ReAFSy6sSM9liuw7I/tyiBX5Bz?=
 =?us-ascii?Q?u/E4pcpBFF0KKZMsky/BwOECGe4ctCV29CnsHMnluKiwlgIHU4lWTYnKlyDv?=
 =?us-ascii?Q?OOsguy8sKP6rKbGgpU5yJY1sDDPAu3gOPDAERmUMwFo4UKuKeqxB+VjD1Yup?=
 =?us-ascii?Q?GLG8zO38497TlbqZHKL5CaC+EcGPN54rYOphYJ+K+ekCMlSJj4ZVpKqxYUvG?=
 =?us-ascii?Q?gc/lfgPKs/bOte+lNmlMMDCHCKBqDCI1yTsFjSawEOwcp44uhmdyfGdoITI5?=
 =?us-ascii?Q?MPIg+lvMHKP6gB9er4SBjVY6vHMgqIaeP+lGSCrf4uaiw6fzFiKAU1/+IHSC?=
 =?us-ascii?Q?DR4EMg4xkXBqhBZBBwmAgSuw1ZhN9BON6MtJx7GeSInJqOE7be5a7r21gM7d?=
 =?us-ascii?Q?calXWsEVcH/DraW/bIVq3/ggeG6xY6ggYan9yIZobn1tUfMK?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e646902-3bed-412f-dd6b-08de6a3a7f64
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:27:41.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KPqFxoebIG6wB8oFZuWXgipJMd1x2U4a8pjw5d/ixHusM87rzRdAYtlSgPIfrgpgfO5yTA+pCPgdTFq5rmN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0838

When compiling with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
warning occurs because with ISO C23, the function strrrchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the input argument is
a pointer to a const-qualified type.
---
 plugins/dundee.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/dundee.c b/plugins/dundee.c
index 57571ec3..7716ec60 100644
--- a/plugins/dundee.c
+++ b/plugins/dundee.c
@@ -73,9 +73,9 @@ struct dundee_data {
 	DBusPendingCall *call;
 };
 
-static char *get_ident(const char *path)
+static const char *get_ident(const char *path)
 {
-	char *pos;
+	const char *pos;
 
 	if (*path != '/')
 		return NULL;
-- 
2.51.0

