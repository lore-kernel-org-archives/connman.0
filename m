Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021129.outbound.protection.outlook.com [40.107.39.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7335B628
	for <connman@lists.linux.dev>; Thu, 12 Feb 2026 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902775; cv=fail; b=amcTyjAr+LCxJR6VboPH4Jg/FamIWQMC1cna0d+VCOhf9UpgcpLlsvesvoBA5ZW9hficPbxUmmPr0IwVB8YXrd0ZmFV9lU6RZa+ojjmY9JXHj5Y5upKMmHGNcbocpSA63xnK8K01EK7dpn0BIEHE9kV+qs8oGc/apNUHMQ5AKls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902775; c=relaxed/simple;
	bh=SMCnawZltalNiFokfztRtJuuhWem6hdvJpC5A5oK39Y=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=en2WyV/WgUIwkEwUkq02E+c++66VzMza/sOjHMswR94o5KW0osFKgmyNTKIwCvNBWp0Fp8EUICjIp5an0UmREVVSvHvzFUrj7wXJQ3ctGVqmJPJvtxOZfhOaK7yw9iBOcJLOg1N8j8X9xzMpFngR/3hXgyDObrAUzMLvE4ahkfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfqptLeJ4dN5syQgvU4h2q8OWI5aJwanWfuNR8+nYhOvFox5XdA+oJyMgU//bdhWi9WNo2C61v6D6yaNGDdvT1fTDmNPk039KQ4L5Uy+zNSKCfC2HvcKBO8OH0yEsyJQDk6CmWc3RwbVlwma3lqPqq1q1PrPo7G2J6UioI5OO7uAaYcOWxTz+vfEbkzZYZaOuzEHPfDEuHWIqkJMimdMKBNfKcpgHxgC9KFou/JBmN9yqPdqUGbyn/S2Kto3CQu8vghShprQuE6XcD/hBwLEQ5fgTNHkX31esEQvZx6Z/5N72yuyQDJUWeiXMOZgTRgEN5qV7lAUJlCQf+wVEXhtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcaXDjRybRrXgRJXkNdFc4SI5VtGSPcMr+4G9WUwIsg=;
 b=pjU8aUkVDK3tNvmt5rWokbZMGKncjnekJemue8DlPCM/0TlTDMzluuli+LMuhKLx0XTgPAWL1LNV2e1AllA0JqFV1SMwCpLA2GXhjKVv3j6Qpgke3bjMoSY5lfMLYhRJTyOfNCtOafPW8BWr3RXOgJNfKrL7GVztgAq405dXB5sQL/XTQgNskoQYi4V3/kBYC9NHd1TlPtvd+X6Yeoa+0Z0YMnDJ2hS6IwmSSpZZrZ/5vSWe8UacDkdSVRi/zlWaWBbXmRGi+c8pLAYikK3Iu9Mpa5IMkadRY53K72tNkDvyIJlyIBtNFGrU9jlzu8ryO5Eu2OcKervTP/l3Li5jNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 ME4P282MB0838.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Thu, 12 Feb 2026 13:26:10 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 13:26:10 +0000
Date: Thu, 12 Feb 2026 13:25:57 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: connman@lists.linux.dev
Cc: rudi@heitbauum.com
Subject: [PATCH 1/5] vpn: Fix issue with const return value from strrchr
Message-ID: <aY3U5aO25va_wuNf@01676446e9f4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME3PR01CA0057.ausprd01.prod.outlook.com
 (2603:10c6:220:1c2::8) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|ME4P282MB0838:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a46f401-6951-4ba1-fe3a-08de6a3a4987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MhIye2I9AbScofKgP9X4+zF6QS40L0/6x6pcgLd6OB3PBw44zSGi4f6H+UvC?=
 =?us-ascii?Q?y8LjZuIcvWGh538RHDzqnw5x36wNTnuqtQL2VAA19YpD5x66gYXMglYov6sW?=
 =?us-ascii?Q?mLqbn+4C1O3eUHkXYhNJOoDuobSW0oN59jz9u2bRdpUYr5CKXXg7ZlZnSjJd?=
 =?us-ascii?Q?no3QQwMnsUQ2BigsC//JF4Qwqn/MryPMoYaOzWm/KfTC3zgu05t3bIcof9N4?=
 =?us-ascii?Q?Ll5y1ijDtpIyZYaspRa1g3BG62FyO7eDamdQH8DYJ1R7aIPFWE63ChNhFiiK?=
 =?us-ascii?Q?I+opl6tTAgbZb9eplkRhBrACKBa6kWKGsCbWJEnDGH3sjMPqVCe8KF5FCrod?=
 =?us-ascii?Q?gkrsCAT8LpMNkw5+cViD3KATnV1j+2g6nY8lYbJZxfsdHS9pHqc4Ca9vhMva?=
 =?us-ascii?Q?5lK8kKCptKHIlId5ha7w4aYQFPN7V7PtquAH68JIttkKWTWy/DXCqzt0r1nk?=
 =?us-ascii?Q?RUCLjmtQCXD/2dBPEl9lq/yhLCzjkYtDuBmapj0MlcTuk4PKg7Pn0waY7+I8?=
 =?us-ascii?Q?cy/niW6NopKgrfi2lgF1gtCRq/AGjVgrmbBkA8qrr2rrFuPiDoDV3f/9bgT6?=
 =?us-ascii?Q?EMZXgxm2ujNU2cVfYHwHcg0nv8tBv01B4Jfq7LCU+s2EiG8BmNbQ3wdWRPVc?=
 =?us-ascii?Q?e4op7IIY/GldiZTu1Q0ReoqYchIO1eW1mL49OuKDjnoIXz06iFQbQ2iQwfEP?=
 =?us-ascii?Q?1r6jZFSlUESzEIp8ogDlK6suepYl5fdUYNQvG1rel7ea5u/D0B92gC4mAOcA?=
 =?us-ascii?Q?GKzo5VVoBsYAYb1YHcv8YrmkIuPD0mrhbG8w1iHt2W5yR5iieHC48DPdXRLx?=
 =?us-ascii?Q?wOVGSyHFaA+x7VDO4fQINyzTXBFSNZ7IuuqLybLJ4bioQWJsNjn3oVMRxkTU?=
 =?us-ascii?Q?Hw1oUugm0cc34Yz+hO8hw97wIbIIbI7nsKG1kHDxvs1Sb8BG6FjFjRD9Sart?=
 =?us-ascii?Q?pDaz/TXU356hMHxBDCJ9Jp7riETzux+NhjQ4TifbrnzG1GgMfq+oe2Ay1P59?=
 =?us-ascii?Q?wHZSJYpSnApzNfAxp6hFu+zIc0EbHnSz+zANl91whNJ72s/nAVIn63VqXg95?=
 =?us-ascii?Q?1JvsBR7Rv3oNKiOcC/eLhMQoaIMaZtpMrXLD5/y0TkgHwv78iAq71NqRDSw8?=
 =?us-ascii?Q?VRRZ5Yby+bDzww9NjOTvUlwme1rn8gnCgEZDQYw6EhlbkBACHyOdm8BJZA9b?=
 =?us-ascii?Q?E3TiBPqGjkutzVBowhN7hVAGWP2LtnF9RSQQW2Y6iy1shUJt5B+K7ukPsrFR?=
 =?us-ascii?Q?te4oS7h5+WWDjLJL/lwQ6p2lQE6kF8z/ZONyu06DZxiWhsK7OxEygkX6f2Gq?=
 =?us-ascii?Q?Nta2pyJX47WrsZSteitBTYxoDDhsJ5yfXue2EwfHZkphd1u+KgMTJTbJQlT7?=
 =?us-ascii?Q?m3zOaYCu44syfsX5iB0KfsxB+cX9kfrCKUU9b+fuP3Pd0JGYsT8ZdNbTg2sc?=
 =?us-ascii?Q?ZdZmShak8YzP8wKx69YRw9MjKDvJcriOWi8Ezwu9Sx3K5digBiMCi3dsNy8g?=
 =?us-ascii?Q?EQ6l5h6OF4UOZld6K+lEpnaGUKNcNWhh0q5AVDjggP/YADRKk1r4Rsqhy1/t?=
 =?us-ascii?Q?Na4vLsl4+quv3R/ZQc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y7ZFJHFXpZYzqwqlnfuPVn/RGyzlVzOAYGkM2lImSfa/utP3ZC3bXaOjhaRd?=
 =?us-ascii?Q?e3AfU3MTXos5ojdAfFFcb7TfeVjTRmfFnswYYgesdbdsHZGik75BX94H1zPt?=
 =?us-ascii?Q?tQFRhmIJ4xrC6Otu5xKdG9CESOHj6INAXeij3kKxUEV46xZk/uu3a3CXwwmI?=
 =?us-ascii?Q?FJQOMLoZcmlpDvTmRpyK86S255cgXLsgm1cvm3RA+sRnn9Mrp5yjWacGTnkf?=
 =?us-ascii?Q?d3viBfsxJAi1llBul5igDr0iFaHX8OHVMMSJu0KIy/TI/g7DUoEaRM8wqSMv?=
 =?us-ascii?Q?UZ8I4CeozsIJ0iNFw1Mq8hyVFB07eX2Fm/yyvavypeXdjlE4soilkpeZtueD?=
 =?us-ascii?Q?AL5OYvgd+mkuI2LRjkIyk4wrQKRoYBOiCAiLqCPTnys4neJQEPUJYodTfXtF?=
 =?us-ascii?Q?seiuKIuvtQwZog4BxmCUZVysYd33VC4Zr8+jHXOi0FNrgIULh1N2ZE9ZzL7R?=
 =?us-ascii?Q?+/1JpQzare7hcWTWtLcRhwX213xTP9HRHYnKp2Ml4uU1sA4udi0kb/mlY1b/?=
 =?us-ascii?Q?fr7Jbax+eqR0eOYvzkkqhH38G3JnlJTFnsdU4JYdjK5CYjkM2p+ubWuttKnp?=
 =?us-ascii?Q?vVw405ZyeTRaezXB6Rw7jEYoIRyySVc0aS23od1lNiWz126sP+WjTHDbCSmi?=
 =?us-ascii?Q?DL9NdaDmoRjyrrnwx3u0EwnfP25tkuG9Y32Wo5P1OIGjVrQbXNPelgJmypyd?=
 =?us-ascii?Q?+B0/uo1CDChRt9cLwp5X+UvTk/Toaz9s+5uC9ebjKOFCWf+QN0fgdZCoyMlc?=
 =?us-ascii?Q?x4f0Yv+i/+SrluKFclhAHONblh5uw78r0PuBYS/IBWRvxGskobNYRuF+BZh/?=
 =?us-ascii?Q?5fw0NoN5J93xQZcSRAGviGeLWORlYRq+DMKTzh/dReXElILUGXXmKe7me5Jt?=
 =?us-ascii?Q?xcerV4t74YMJjKGKFe8RvZbFP7UEqyYs9IGYEIsWVTqdO8gSNeBgWSx/ruuw?=
 =?us-ascii?Q?OMAXYeuctOnfJGm/xquoizH9eCX+HaBUUaRxY77wyCbjy3ia9mMIHTlQ7+I7?=
 =?us-ascii?Q?0Z6Jp+cCwyeZRrKyrppvSlKbspNtY01ogKbXgOjAAATQP+hkAeOveQrWZ/Sp?=
 =?us-ascii?Q?liXgeFH36WEtyefXLX5fduxh+VA0icW87vMT2ZCQo0XqCLX+Rub3I5FFdDkb?=
 =?us-ascii?Q?ekD9gG/VA8NzKfmOVSKjdNgl5kzD7xkHeLKcjmZMufMAEViNNqVYZCJD+9p4?=
 =?us-ascii?Q?wzQMASRhEL9/W12j4DXee8AmdrwxszNtidEP5YSo/kKfXLOsgiZ8v5Zen0F/?=
 =?us-ascii?Q?dv4C1VoBMff580W+BkcN96mvC9dMVgGiuf70yAzNpSa/Rk+lBHmphhXFQMYl?=
 =?us-ascii?Q?eu/+Cq/VnNCSIm3n+AHtgGeSf0HVZ8q2C+QYDoX2XNoILWJztyBgcpSzbl0C?=
 =?us-ascii?Q?eEIpF8EC2YHKr0g6Fdk0WTKg20BbSTcBLpcyFruy3iW/TifujpIni5Lo54WA?=
 =?us-ascii?Q?gWB7jDmqDqXai+9hHwnWsSxE3FhnSBIF19X9atScHGRD88RruvVnTckJpYF5?=
 =?us-ascii?Q?GPRZLzS/f60g9Cp8etGU2/67TqEMQMN+SNsr8R0WP5NFTQ/1f6zeFAyM3RMz?=
 =?us-ascii?Q?rq33kHwfwY9hHyoocjpy0u03jaydMahvQk2BpFO8+dIBLqNHwp0lUS1oUC65?=
 =?us-ascii?Q?4Ux07ZB2fJTnkQe1657+5N9IGHiPyjWNA/bsNopK5MZB84hGNPoYaMyDQBZ3?=
 =?us-ascii?Q?c2qpgRblDTYiR6MO8npJSTojzue2fxafhffYzCesKOjw6BDCLKUDUWcwjybW?=
 =?us-ascii?Q?98X+GT2Ztg=3D=3D?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a46f401-6951-4ba1-fe3a-08de6a3a4987
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:26:10.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/wmzWZ8udy7EhOAiCWJFTMymA2PyHnXKzz1IZSjf3I18lZJ7+AEjvq9PWeB9DMcXVtYqvJKywE4bTHyGsMFJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0838

When compiling with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
warning occurs because with ISO C23, the function strrrchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the input argument is
a pointer to a const-qualified type.

../plugins/vpn.c: In function 'get_ident':                                                                                         ../plugins/vpn.c:170:13: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]            170 |         pos = strrchr(path, '/');                                                                                                |             ^
---
 plugins/vpn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index 332d8e83..1a6b0194 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -160,9 +160,9 @@ static const char *get_string(struct connman_provider *provider,
 	return g_hash_table_lookup(data->setting_strings, key);
 }
 
-static char *get_ident(const char *path)
+static const char *get_ident(const char *path)
 {
-	char *pos;
+	const char *pos;
 
 	if (*path != '/')
 		return NULL;
@@ -665,7 +665,7 @@ static void add_connection(const char *path, DBusMessageIter *properties,
 {
 	struct connection_data *data;
 	int err;
-	char *ident = get_ident(path);
+	const char *ident = get_ident(path);
 	bool found = false;
 
 	data = g_hash_table_lookup(vpn_connections, ident);
@@ -1092,7 +1092,7 @@ static void configuration_create_reply(DBusPendingCall *call, void *user_data)
 	DBusMessageIter iter;
 	const char *signature = DBUS_TYPE_OBJECT_PATH_AS_STRING;
 	const char *path;
-	char *ident;
+	const char *ident;
 	struct connection_data *data;
 	struct config_create_data *cb_data = user_data;
 
-- 
2.51.0

