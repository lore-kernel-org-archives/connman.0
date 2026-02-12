Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020116.outbound.protection.outlook.com [52.101.152.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D12EBB8C
	for <connman@lists.linux.dev>; Thu, 12 Feb 2026 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902897; cv=fail; b=CduVjmo2TnQgj4NKrGwB+AgWm8hMlvhmHFheA6/m44Cf5/mMVltEYSTyfeNcb7K368I3SU//DVZO1OCb5a8Qsd/OM5mnXOb1xMt5W0VIi4bCCIyifIbbWHy9qqjlHEFAAlofzwz+evhyKZv0xNOi7oBX6nTueDV+X/GnR+6lpJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902897; c=relaxed/simple;
	bh=g2/HotbdxORIIkKv7b+jlu8/o0hNqk/Ap+YToYLKffo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=AVdJiEcJgeDedO0M0+rhThKhtFLnbVvj3unL6IYC6DHruhk6hPl6ADR/mp5tzAyi2JKx/KzeE2JpeyvQn08tdc/Jc5MGdr012i5t0O/WHBalne+VX6+aVeHb9CaYEbdjrQJRpO4EkdeMs/NurX5Jl1zCIS3h6CQzCAhWJU0lF3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.152.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv/sxwXz8lUNO3eFhMBze9fo4e9h26PRW7xcmRamdi7W0uuQO8c0DhO5sAoFhtj2qUFH8XBJIFphKC+PqiumG0mfx6+LFrVn7V7G0NCNosMvcFLEegisIbK5GIlQlDFjtdJpowEgssX48QsvLPN/F6dYPOvP80khUAZt4dglbhKg5AiVKn8jPUQw4KbR8iEJcDgXcXogBGdLD1JVtDR94FrR1WxSi4vij52zXi/LiwNCoHJetCFq45aipG+CeVbT6iNUaR09690lR2jSk/SlcTY3MnWHZfq2o3K/IsnGjcWUcQgQojcs3eOVeTyK/YjrxiB1Z+H8Aicvst4HGpYBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlTtu/2p39g+0LwHJ31lg0797aVgyNqFg8QxdLEAeXg=;
 b=nKO4pdPYK2EMFZA7RyiPDCK9qlxkUcq7/FyQVPHg8OrNQB93WdRhfQWWf6XhBiQ6HZitmSw52gjt8z6ymoENbtpWPCca9OgXuLXRAz3qKkEc4twpb2JMPgLtR1SRDIyP6ILTm/FbYEZmYKLVMPEE/4Wznn1BqsacgX/3itbVluBKWf07/TeFllvr8uRqXq5A7oN2xPJECl4NGTVs9MAgTEx01yclMP3Y7DN1/2zYw8QQ3N6Zyq5cOFNfGly19LRQrP2Ot01uhvs8rbqCgmF2ow8WMYxSYcWCS4xOkKcqMdJmp73JqyqhYI1nl5gEe79TlUe5aR+n+Vk1Swc6I5gNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 ME4P282MB0838.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Thu, 12 Feb 2026 13:28:13 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 13:28:13 +0000
Date: Thu, 12 Feb 2026 13:27:59 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: connman@lists.linux.dev
Cc: rudi@heitbaum.com
Subject: [PATCH 5/5] ofono: Fix issue with const return value from strrchr
Message-ID: <aY3VX9GIRgdwH-L3@01676446e9f4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWPR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:220:1e3::8) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|ME4P282MB0838:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fc9adf-94b6-4dc3-e8ae-08de6a3a927e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7BNNn2Kyj++n7cqGnQr9ffGdE/qjw+xSN0zM9eogBrp8KwhQ+gbkwnIN6fA?=
 =?us-ascii?Q?Chh9q3qYNvTWDxG+w/5DvbxkU86Rc1FaubG1aS0BoAK8kHObfn/Pkykwo67b?=
 =?us-ascii?Q?/NxyhK2C9Ol4cOrSFVBdSYcp9yKvhLy0Y+N9rZUTv/G88gTb8wwUqcDEaJDT?=
 =?us-ascii?Q?FjRC+d7crBF0sHm+jBbfGw5k5a5AEZ/L7Y58JGPbuzDqITKusHmrVrY1kCUo?=
 =?us-ascii?Q?J5sK3BxCa0Js8J6/TXe+vVH19nwtsWLjuxaU/9DXHdAkkVoaJz2VJbq8IoKt?=
 =?us-ascii?Q?qDUnJ62rTPE0L3NkOav1oKnOzTfN7Uo06mYij77EZJF9EAPFokGJqH/pjLsa?=
 =?us-ascii?Q?PaMSCdXXbcCFHSULYPh5UyTI1gt9TbQaREVT1lPEwzsuJ5e1N4h/Sk7Efyf8?=
 =?us-ascii?Q?f7hVtYzZxjGtQTuoFNLRRqbH4v2XUHH6prmfwp7LO1mC72IGXaCWI6FO3EwP?=
 =?us-ascii?Q?4CVui2OdnKrSQQSlCSMJKOcfGiFC1NeWxiMbIVdWToVcDN4ZDkgBcY8G8Jno?=
 =?us-ascii?Q?kZREiaZZJ/4v/8BK1hkIceesjO9VyQsQ/OiAadKGAsEY0j8McfrUwQIRYlWZ?=
 =?us-ascii?Q?2yUGb0fRqTy8dpBJ5PAs/Pe9svg5/0NYITRUtiPIuVTzRS1YFZoas9Gchnel?=
 =?us-ascii?Q?oY0Twg2FtISNJUnIcgU8gBVa6+m0Xy34iInMvKj33gPZriSm9vSoHeCWcVt4?=
 =?us-ascii?Q?d0vE4vVr9rSdgrug2gpXOnSmEFTDADA3eCDooL4EEFWeA7pfvxx51a4UnU4G?=
 =?us-ascii?Q?tRDfPbH6EZYopC3LvIKI/ldbeDVre+B6wF33Bu1afVFTIXgjl7HGXUOhjIEm?=
 =?us-ascii?Q?HtTwwvwoh8IU5f2vs44Kmxngdn3c1mt9Cn+YDsrVqDQG4npEA6wkQPWxg61C?=
 =?us-ascii?Q?E9fAOOZZhIl+jke0Ioc7zbjZ0/KoAeUmfRaHQ0IUyJop3QNCdrNyR5MUKY51?=
 =?us-ascii?Q?pq6ItNw5T/tEfWaSqGvThW1wgoibsZsgXhRtkV43weV0X6P35OCJcfM7b0CZ?=
 =?us-ascii?Q?7KA+H4o9jJQt6GdbwROgURoXBvQ4mW4J2xkp+tjpqdNBxYIH4ohnoqx9BrwP?=
 =?us-ascii?Q?8NdxWS8g8tzhPKETa7kcZXbxfewQaaRZZRpIDENjH9R7tszVGohBNckOgztE?=
 =?us-ascii?Q?DcdVIIzwiEkEiQlfV/mY0c8tKGKNTkMwCNIjDEC4CpADdFmwFds0YIU717qG?=
 =?us-ascii?Q?/5R5fjSzooSt8YSqOdK/6sev4Lxevj76sM2OSEhQ05UM0pWAwEgZuXyLokbw?=
 =?us-ascii?Q?fCoTJ2ONI0lwY/B2lrzT1dWnCu2YpUcQlKm+OI9uiQ3UEDSixzecl894Tin9?=
 =?us-ascii?Q?EFx/qCG7hOHqdwgBOvpbmknAW3YcPwyGyX9O9L5NzCwJguU/XRqqHoDPc02o?=
 =?us-ascii?Q?Bi2XEQ+1ltUD/0VA15AHvzkC8Uh9mwngqY56TO4Zj9+EQUPfeET2gTGuh1ai?=
 =?us-ascii?Q?QEd/A3/42fvKBxeJMkz/pE0GERNZdMTHHPdWsGaEx9WvxwEeRfbDqhRqOi4D?=
 =?us-ascii?Q?CCIpH7DVQcPi/L0BeyhfvJERxGWiskoACyfAv8OvgvSTQSXcDD0N5Wk+ATsz?=
 =?us-ascii?Q?D44mOtB+PXCcGamxEhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fSIPc/HKFwhqH9ZWaGSaw+DXXHvQM8z3E4UYo5xc3/ZEHDWJXxIFHa9zuaw7?=
 =?us-ascii?Q?wvCf/04xMbbNbnRR9mJbKg2th2gFm6a+Frty//GraSsUhHeCDy2i8RGi8RgU?=
 =?us-ascii?Q?OLVmQh71ynj4Lh4wzxJFiWfWJI2IlDLTosoDRTnjq2BOoI2RAOiyq3jClgCl?=
 =?us-ascii?Q?BU0ygAKnKET63vgXbo886rMPe+ooWe9h/bDRkEIuQpZXnq2OZevYefqXQDnY?=
 =?us-ascii?Q?KIfFGqp9GkuuvUZNSPlVJDnczVQTANIOoK1nQ1q5kYs7VFeRIUKgiGh7wXPK?=
 =?us-ascii?Q?35QlFUPD55cL8QAGWBR2BHNbe7Ai/4cjApVh4CRENobNpGpBOcN0z71Rf+Ct?=
 =?us-ascii?Q?1H3R8zafGcO5Hi5sX2rOjQdArfLXhroP2IRAKxOYv4bJvWKln7FIscUEUbgw?=
 =?us-ascii?Q?4M8cAtnPkqQ773Q+Yi6nL8NvxCk4P7hb40GR9wafguqMWYZK5SkRBj/6Xlxy?=
 =?us-ascii?Q?iUSmbXYpfiDOL/nPNeRWrHgnTVVM959zhFKUxFw2u2LZCJ5S548tYeUtfEJ+?=
 =?us-ascii?Q?XQXwDUliOHbdR+ty84KwEmB2POV5H0dak9OM02xhCxHS+QfBec/ssQVBRUEi?=
 =?us-ascii?Q?vUja1uI5mhSWTGZmY47ngO3Frpj9LiQ8vcNOtACPSPLOV9aRQ5NGYXjBX8nk?=
 =?us-ascii?Q?0zZdtcD7HQuh9lBaC83C05kVvHmMiMsxJcg8ebUvq+RpMElXh7pfMTqff1sb?=
 =?us-ascii?Q?4LETvO5j9Zo66N1rtuiHgyjnW7H0IbIXvcJ/R4TkdRN9bw2tmc9BCt/C1Y+z?=
 =?us-ascii?Q?3ltDxgCA0ubBHMkF6bnq4xCxXgd37jrUWH9EZMFnfef0PbIbIflj6Di8GmLB?=
 =?us-ascii?Q?JWh2nBsikEHJx89BosuCLUHeIcJTo2D+AY2Y95UB1nSC0A+ZzuAYlSSjNYT5?=
 =?us-ascii?Q?J/5wvu6A/KUY/MxWqJv2OwmI7B69A6cgBNPLg69FOinICQAkIGaxCjZQjNc+?=
 =?us-ascii?Q?0LKFj4QgYXYMlKmvn09TOIqyeVsIe1ozbeN17nU5vc332WgtaBxxKVj01xeh?=
 =?us-ascii?Q?nqjyZevsf9CmsS2s8goGHCUwgsDROsc0hv1M0nr+7VqZ5wzoIo98kXkKAEEg?=
 =?us-ascii?Q?i8nbCBuKWGPuJcSYs9WTFxcfrr11TzCJL6fPaaz98ISUq8TLnqtyIRg4cucD?=
 =?us-ascii?Q?Il2ni5HYNB/BphWRA7q+H+XHA5WfNIATW+moN/NnGSt5eVJhktVtiKR2gce2?=
 =?us-ascii?Q?2dx1oHFybE4q5i7baMGzKuOQtuSnB5L4yy823GBTjbNsn4Srj/u+EkzwdtD5?=
 =?us-ascii?Q?3arokuKmXdB2Mb2rU12joPg9baiyi8Il2okqR27N3Daebpgn0SUqvg7b6gJz?=
 =?us-ascii?Q?OdOOD7aZntbZveeytPDpSYWwocxJv50qRMn2WwghGa3MTgqpWboFQMeh7+w+?=
 =?us-ascii?Q?VUYxSHeMZbgGCzr7tx4gl1Y7eSTO8apBCx2IFVaafQ6M5jssgvajKEE2pwiL?=
 =?us-ascii?Q?NVzvt0BoGwXOl1YVw4ZiSMpg+ZMEVYNtJ8VRaCz8msBrVeo8rxeJtW2bemB7?=
 =?us-ascii?Q?ue0hHdJTJUIzgaVjzUlXuv7Pq0+G3lcQSDYX7bgi4ksZ+hU4ZpJFVGG+kjPO?=
 =?us-ascii?Q?LbvpKXCvArhMY+yFGTgz/4QtR+wEW+jaibeXYYEOvQD5luafq/DCGSFwAPnJ?=
 =?us-ascii?Q?jqMIFsv1XOWPW2n9r+JPOG6wwXqcwrSLgzDIZrf6zRtbKOg4tG6NHTYlKg6e?=
 =?us-ascii?Q?+tfw/Z4tHckOCSFbaE1oPI1QuH09oXGfVKGhjhLI2YinBHuJ?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fc9adf-94b6-4dc3-e8ae-08de6a3a927e
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:28:13.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EGu9OsPexwirySzk4L8roOHyBCrb2HIkW1PGKlwSl8H7Ksi1qOkmqIYRE/2ovj62Q6vQZ6ivGY14sSbYcYepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0838

When compiling with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
warning occurs because with ISO C23, the function strrrchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the input argument is
a pointer to a const-qualified type.
---
 plugins/ofono.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 2deb67d2..2b51def0 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -186,9 +186,9 @@ static const char *api2string(enum ofono_api api)
 	return "unknown";
 }
 
-static char *get_ident(const char *path)
+static const char *get_ident(const char *path)
 {
-	char *pos;
+	const char *pos;
 
 	if (*path != '/')
 		return NULL;
-- 
2.51.0

