Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021140.outbound.protection.outlook.com [40.107.39.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFDC35BDCE
	for <connman@lists.linux.dev>; Thu, 12 Feb 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902803; cv=fail; b=Mk7htHvh+SpP9w1qzuik/hwc8WLNrhqUYeqIdoy0o6aDZ0NHQjtqxlgO0v6azG0msNV3OrWOt3WywT1Z6Btg0MJfznyyxIlz6dt2tcUbz0ladH5cqoZ/+GIICfznfXARvmD8fbNZB76K++dYW/kEsUVU2bT6kigflDfogfzjrSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902803; c=relaxed/simple;
	bh=vxogI84QA4ZwgN6MW6GtTXD4Rwlv0+tsyvTKDUVVpwU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FwyhKVlff4moSHsoZUZQjYHJqVguQtYmjxAsD3P5VjXmjZRvOyED2UHnpFUuy9PreCU04+u44L4NTiPgfSKeEyz3hkgz9RWEoq5o6qDexdX4lkVdQX9+8OLX9+wHGC88XlAN2DoB9Iye6csWFWGXRXCB2YHLZmHOclgSk2Q6ri4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/Cn58I/yoeU0MjCC8SkL8IQ1N05D2S6r7eixQd1VVJX8DPnUAX8O83pN7JLDy+cMRiXI//xRwP7/q65U+PJDPeEvXHwoHQfaop5on9KKfLMWLKQG2DQMNJZKyI9uXN9ceZws2oBs5cup7DCn4xzgvrU363k1CVQ7gc102I09nMMksFCSUtl4sTZQWY30/8PnFoHExNiPu87Adl7fmYNxHPBGiriqAMzKY4o+UJ5f55ntg6X3mRAPolFs4EVFey42xUXmbvNB1ExTISl93arHeQ3mVN/5lV3lE11RCAchQn+wyW5OwSmd2nHw2idE0qCMGBAKgE8on40qBQvBL4WYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUN3q2er1FTquhnqnqZV1H0qkXBuTHQhpF0Xb1tBQ4E=;
 b=bZeh/tc8N3Ah9ZKiyBBdfrtCq5d9uq+iukn9CWLO1yI+mxPeI22xouHWuK+Hi1+4Hty0lTFt42DywpTBdPuMXxBq1y336uGms3KMuVEWG7PJezTNetM14JnM1Eb5FAELXrTxu2NKb7Y5XR6VHeSvqjxA1Xig4eAXm2LWjPdu+R7GozDz1hSTflOJ01UC4ra226gAU2xmbdWp7sXl17GFunFGMkXGo9JGmxnlL0tB48F4J5nZ5BXVU9Igpaq9skQVXflzp0at1D5IhgSIEccokFkTyNTXCbcfHbRARY4eI7og63ESjwe+E/Bb2S/iTR1EWETneJ7sZbT2eZqGM2PAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 ME4P282MB0838.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Thu, 12 Feb 2026 13:26:39 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 13:26:39 +0000
Date: Thu, 12 Feb 2026 13:26:25 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: connman@lists.linux.dev
Cc: rudi@heitbauum.com
Subject: [PATCH 2/5] vpn-provider: Fix issue with const return value from
 strrchr
Message-ID: <aY3VAds7frDakWxu@01676446e9f4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME3P282CA0140.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1c9::11) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|ME4P282MB0838:EE_
X-MS-Office365-Filtering-Correlation-Id: 0503a8f8-58fe-4540-5564-08de6a3a5a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbvXTmqQR4murEB769AgqgPm6IP40GB5LtMmSB13lVvjRBiseTSvllUDVMt3?=
 =?us-ascii?Q?gbJ5Eam81+Ibadg+zOWe/y+RVP5cY8BCHCBc4l9/kr8bZwW2qpaF5VBZZ/gD?=
 =?us-ascii?Q?ifJlE3WIhhOw2MpBQ2xD82+xMfl+9KR2gejHUvQDQy57vUaGwKST9Kd1Qij2?=
 =?us-ascii?Q?gfpwT5wAIbl9kVS0qI/lDkMS+gE6L6A9XMW2rAOtBXeFCZ6HsppX0qkQcS5G?=
 =?us-ascii?Q?EFYhE+EMyIySkMcCppXlvuBTu5ZRbpN4izTE67p9nDzTx9BTfUQsaoJigAKR?=
 =?us-ascii?Q?TSyCd7U74ZG3zpt2qj16oFp6qCWMBGsJYtiNktO1iJblJ4KA/5D1YDxBS0dI?=
 =?us-ascii?Q?h7jrVAHL84LMYAScSiaKhxXVKTde2OitJGmvQkld5Pw8+vMrhqHGIQ77wY4J?=
 =?us-ascii?Q?UbX88yiUxoazFGDA/tsEQqL04tK/R9cNSuCJmsP2CdU9jCR2GW6n4AIMGeWP?=
 =?us-ascii?Q?KXUfCBphHl6qGxP5Vlo3/eQ4RvM0sUFoOGVkWZGCw22e/Ol9xWimeti31ubs?=
 =?us-ascii?Q?ci43nsII48coKNuuGpPu7G6vgOdrvereG6utnISelmfzp39/HCYM2hG2xHzo?=
 =?us-ascii?Q?Y/xrtF/4XRzaZQKELjbt92Ig7v/5WKaHebyqaDocETIZjXVn+FN1dEoxCE6H?=
 =?us-ascii?Q?TbxeN/ZmbDBlHKhhOUW+/j6WW2io9OkK32tlgbuCSO2dXAlIUYuVwRCUhlHp?=
 =?us-ascii?Q?6dYn//AF1wIl/fxJAHNp+zxDOnhGklp0/Ns0PcBmjnU/wEEIYqKI054vRzIH?=
 =?us-ascii?Q?YqqbP+bohRn/i2mYvcj8dX9jv8MYMHKFlBbpcnVuCKvzGf0lF8AF9AlA/gA3?=
 =?us-ascii?Q?pRvTfPoR2f8+RVE80V8O0Rqll97BCH0hKMRtHQUu4L+/U4PFdO0fTTUs2CNu?=
 =?us-ascii?Q?a8g4feU92ASiA5ICOLusKgqspXFS5qZ6b4vic5UgfY1Rt23qvtqT5dAdcfH3?=
 =?us-ascii?Q?6qhmR15KfniN6E6tiBvODaWC9f47J5dBAp09EzTrnf4Rh5Esr9P6CSIqD2DW?=
 =?us-ascii?Q?EiRUbsv/Dqq2MyatBXSyNtpcTcfo6y4fvdFue2aN4IXstu/W14KbbDxGHvWk?=
 =?us-ascii?Q?XtfFbrAD5BqLJxldN9vkvi16vp1yGBqSB5xouagTRcC6cjjczURjM/BEgEY+?=
 =?us-ascii?Q?fKuLA6IiX52D+1JLiKqdZx0EqR9H/XsfSTmpitZ3TIfljDKAgSdPv8sSBv1T?=
 =?us-ascii?Q?Nu9FYTnJa8Jp3Sm80bmBtgYIo+exBitxiG+VuMd5wliFgyy27wGt2BzqC0pB?=
 =?us-ascii?Q?aaw9HkiVOhl58ipU+bDxqMGgnMUhrT6Yj3Lqm3JXIlQ0RvtHLfC7LIHWAceI?=
 =?us-ascii?Q?THhfS7gntjyq48QN69ZYiGqZu+bTG1nEkEJ6jEvcCK+WNJO1IOj5MVHCUR4d?=
 =?us-ascii?Q?ZJQ6wpVoFFsTTqCG2idJv/2TZrpRAAg8hIhZuGmSbrVhLGbST9JG0PmVPhvt?=
 =?us-ascii?Q?GwgkW3ShVQQiW8lLMKweBvVGxY7NB1aaR92GaGmDk1Z+zDRhQ+bc03uv2co9?=
 =?us-ascii?Q?Fzuu47hpmEqm2H4DWP7R/Zal8+RprHiVjT8OiyJMfD149oBY1ud+A240gsSs?=
 =?us-ascii?Q?daqtldu7cBKtVJL0Aas=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOFw6kL08UMeLM/T2sGc4Oh/vCd7Z6gBti3l7W+QlAQA+zoX7mb+kY1qHm+A?=
 =?us-ascii?Q?h7vXOjdDn++SBVWReceb7izOToLabo0typ0DkBYGjqQt+d/aed7MgJGVNghE?=
 =?us-ascii?Q?+LTVl3MsCI9LlGJQ0Y1NDsJ9UndlCCRgjZ4z5Goo1+8RbEQYky8Pg8m+qSwG?=
 =?us-ascii?Q?Kxttj4bzcSt1+XdJbJ58ye8TheTlhXBsMQDWwfPdVySXdVWatRjgkiAfimjp?=
 =?us-ascii?Q?Nw5eqLU1bAkaCVlmhwaRsnXagPp02SajosuDYDCAYV3/Iiyf61almc6oiuXS?=
 =?us-ascii?Q?Mn6G6peoza8DGlUDUW9cWnry/SazW9qdltn5wRmv712fkyqVQ2Ph/DxXVrlQ?=
 =?us-ascii?Q?/XsGOddl1CaCdiz/8k3etlNIPCKOqC+5JCtUns7owTridbkAvBgGVyOkk3G6?=
 =?us-ascii?Q?maT9bc7vuN+oc/LEvySTzlQZiWp2j2DVdO2yzFo4NwE6jfEh38CWyIiwbBXs?=
 =?us-ascii?Q?cMia2NUBTE0ngN0c5PQwGdJeZWRKYhr2TeB8/48mvSllLqc4k7Bf0WA+5HsA?=
 =?us-ascii?Q?psc/hW4f28yavs05cLOyVIdrl3rKidye/ciJWtaYD6MXRX/Ev6vNWjsCJr7h?=
 =?us-ascii?Q?jf9aOTC011ty4CzwxiDxJJw2iWcTBH4tATTfuSpUEyUddvHFNP9pc758J7dC?=
 =?us-ascii?Q?iXLvyca/hSQxMtQOKiSB6FGaOMERP1RDgWH5iSgLZgAhPGR60FLq/koiW5f3?=
 =?us-ascii?Q?xgKTKQDkfCdIacX/5H68yBfNZPRHw+3FWdeaJ8GBKgwJnO10es2XITA4Gw7k?=
 =?us-ascii?Q?nvy6Oo66G/+TBqvuNjDend2unq9U1EKPhJYPs6xi1PW6vGSdKDSQ0kjMMf60?=
 =?us-ascii?Q?wKb1SoOrOYkrhLk8IUZd+/ISzWFLPThGQ6DxLShP6T0E24oQFwp497jhAEXJ?=
 =?us-ascii?Q?H2nBPKu1u2a9K+lZccgsGaZwhi50Jz8NSbSu4YuJ0r7AeumO/LZTG5fDd+U2?=
 =?us-ascii?Q?Rfu/RR7OqeEkcECKKYzs9laSnqz4jfVZC74POhcc+wyVzHsuI8G8/cobSId4?=
 =?us-ascii?Q?xfMniCLoqxtjpSC3ldxcG71F6sdzvzpOOUuXbi0udipHf7yCpbkpKbrpszxh?=
 =?us-ascii?Q?wTgg5yzMa05rXCZ6FWR2VBTtPi9Wmyno3v/PFjoqYvlvlhUdz8Zn62bZnbTg?=
 =?us-ascii?Q?U9B46QGNejMsZ3LK9lYXSfsEU/5c+2hjGdymKwFiLvxy9+aT5kLuqs3reQPQ?=
 =?us-ascii?Q?S0hHoCqUhrYkxJ4DyanczdL9hjRdysQfDps7CvmAu5y5+IDohBLGDJHYBN1X?=
 =?us-ascii?Q?hKnPDwBHoF7/G1TTzY/2rTUXpX9dpvKpl/dwJIZre842N/2X/ByGhRBBh00g?=
 =?us-ascii?Q?mPTVETkG/ouYsZx/EpYm+UpqqxGIuhFsj6wjlQOk+SxVKIga4JITGK9Ao0oC?=
 =?us-ascii?Q?3SILEI5LBLALx8x31O+OS5AxQdOuRZT1TniJpZJYvDH9zV20tICfJL17gTl7?=
 =?us-ascii?Q?AIEPLrHyQ89ZcKFlHb6KvfUm1InJFoWVpv8yaQgErTOgWlK6qrXbTc3MC5lX?=
 =?us-ascii?Q?oiyCeR+wkLIh0pV5hbHKovbDKafJU4etbDRL4SCDQCWCCePPd0eaqkONfBD+?=
 =?us-ascii?Q?FeDhAQZXGEDw2n0OayAVjNJQXSF7C6eToPBb2WMZehTj1nW3Udi13ctNBsfl?=
 =?us-ascii?Q?PPU6cF3NwqV5zOcSKmgDvpATF1rkOCPrQPt7NCM0Z4Sbgj0jlbQEgo5oSDCU?=
 =?us-ascii?Q?JFnmYnVRPBlY5HB+gb9kvRsRzJJG9MHSlOg+RgWyvz7FvfkzAuBjtnBDq0Gc?=
 =?us-ascii?Q?GAKOf3Vu0A=3D=3D?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0503a8f8-58fe-4540-5564-08de6a3a5a86
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:26:39.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2/bvFRdvsmMMYbk0VmitRLJaqvp3ko8bZSHYD/xW82thnwuJfTeJ9hyxgE1iBo799JHEseIyJvp6vd34ljhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0838

When compiling with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
warning occurs because with ISO C23, the function strrrchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the input argument is
a pointer to a const-qualified type.

../vpn/vpn-provider.c: In function 'get_ident':
../vpn/vpn-provider.c:1658:13: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 1658 |         pos = strrchr(path, '/');
      |             ^
---
 vpn/vpn-provider.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 4bcb8373..dafdaffa 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -1648,9 +1648,9 @@ static void connection_removed_signal(struct vpn_provider *provider)
 	dbus_message_unref(signal);
 }
 
-static char *get_ident(const char *path)
+static const char *get_ident(const char *path)
 {
-	char *pos;
+	const char *pos;
 
 	if (*path != '/')
 		return NULL;
@@ -1665,7 +1665,7 @@ static char *get_ident(const char *path)
 int __vpn_provider_remove(const char *path)
 {
 	struct vpn_provider *provider;
-	char *ident;
+	const char *ident;
 
 	DBG("path %s", path);
 
-- 
2.51.0

