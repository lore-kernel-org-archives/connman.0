Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020085.outbound.protection.outlook.com [52.101.84.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F427A12C
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655167; cv=fail; b=FnU40RheJHIZWyq09K51gjJbXTz/JD2Ezzdgjkq0hHq4kRQDMtXPwBfoyBYjJkBH4pXYLy/T5KeERc9dn6slgJp2sS1Bxjo9ZE3qTYee1ynN5mrl8MYQvCB6C5Yv2bD76c2giOEvYGzo/ctfRGV29bb37v5VukI2fppi/goTUzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655167; c=relaxed/simple;
	bh=ScPfg7konJ8qa8qahvHG7PTwMLJfVLzEsH+hs14sDvk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KuAJTZUIyrsOGukoJBAhTHqYqLvCFJ/VOoghL7KfDLDYoqeboT4LgtA5GEwrqWuAo0DWlp1yDKLPf/YoIA/qToTTIPkrldBk/8K3JEvxQRGWZovSv1HXSkKQkLWlE0rPX3meb3vyZRiB8i2y0MrZ63hmcTXQbHyDUsghm0snfWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=FtTUjUqN; arc=fail smtp.client-ip=52.101.84.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="FtTUjUqN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prLJD8U9l3pZrBavPENFH6uvEtb1bZE5vVceFICm4WqKLge0+9oF7ks6RtAn+ZRWnsSHEJ+Es7SBABo3DaJNdsX4Lu7dmj9Ni0Ye28d/9xLHDU00I2DzpHS2xyoz7xGoSqWSbu23wlKsBPstw/sM02ue6Oj3y8h2wrnycynTSMqq59EvHt5yO3MOdapMTVe8pzu9hraf+f4A+lrdz7k96pylH+EUonh0eOvoNrzZYje5ysw0dYtK7yFWpDdXAsJaxfBs2p/mCxdQq28q0ThweioV/4P3wua8H+TXeWT1X8aNvAH1zzI7G1TajHjTJZW9SiiCo9dxC95tLH+EU3efbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/kXe9ltXI2HJGko+vS4uyLVt+xnmWwz8MLNRl0upkY=;
 b=BFolndSd9PL2B1hu1oRyFxWCtqsFtAv34xIoMsnlx9LMMSAwvV+Y1DBCWu9dH3A62hTI2yPGekhgTKPAwaRbAnjPIarQSm5Hzssuypn4+YTokIxOVwfq6gH5fivVd3+TI4oLiw8A4kq8fktOZQ1+oahdJ5cdSjaeLpwqMiSpw2s740RpWzR6dCeq5VQRn8/SJHJ0j6sRtG6r21K7T4En1t/nZVpjYCQpcgmpzQTGYkkigmquG5Yyx5ONcevwWMY+F6QdWigeQjSpNmnhRCGhtjh1/eGJ+rN7G5OevuPrFGjfdOJGNPwTQ0HNBCbA3zGLE0t7o0REiioBN88IfZDZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/kXe9ltXI2HJGko+vS4uyLVt+xnmWwz8MLNRl0upkY=;
 b=FtTUjUqNl5h7ndWtkB0luSIue90+wd0efHLAuKIDjM91sr+7OJcnLjB121eLtvg7AwY7t6OvzUZ0/SlOVEA+/OjxTz7tANYuq0ghuVOytnkg/GFKNrpOSFtRXXl94gbID4uJExVP4btgVkXPXKvA9OjRUD0n6VJ6S2akLW1GF3rJG9H3FpgT96eqR09dRqgUFvE4JOh1oQzQuFm2W8SHP23CDtiiGAKQBjZag1Iw6tVrgJJexvjfsVhE0F8ai18s04oMlehoJUs1NIdILPHdM+gLFshQlRWcw2pglNqr2ZAjDKWX3fAJA0XxebaHOEEUeGsTQkaQB2Snzrn3ICukPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PAXPR06MB7582.eurprd06.prod.outlook.com (2603:10a6:102:12f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 12:12:41 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 12:12:41 +0000
Message-ID: <6ff07d86-244d-4827-8349-b6d54358816d@jolla.com>
Date: Fri, 8 Aug 2025 15:12:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/45] provider: Handle VPN configuration and association
 states
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-7-jussi.laakkonen@jolla.com>
 <e82d52a3-aa88-46c0-af63-53aacb565772@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <e82d52a3-aa88-46c0-af63-53aacb565772@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::16) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PAXPR06MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df6dfb6-d80f-42ce-81ba-08ddd674df62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0t2MVVvYmpVT1BoemhnVm9LT01nK0V6SGxXdEtFNHlVdGRlYjJqSEtmdlQy?=
 =?utf-8?B?SFpOTkN0c2F0Wlh3Z040VDFtZHNHazM4MUJLdVpXeU5iNENnTllpMTJHdHEz?=
 =?utf-8?B?RWx0YStiMjR0eFFFRXBFV25pam5nR0FIZGtXSzRSekNmbEdrVFl2N3FVSFo1?=
 =?utf-8?B?NVBDU0RFZ2tEeHFIZjJiVm9wMGQ1WnZEeFVON3dDK2hYWnFFU2FKckJSSGVj?=
 =?utf-8?B?ZU5NSDB5RnVFbEFrTUZxWEFyZldFamFjRkJDd21xS0VjVmxlWEhKeGZpTGVh?=
 =?utf-8?B?OThwWUVibE93KzRIdXlZQUZaUTJEVHNoYTRoRG5EY0szVlQ3Z1Nrak1CbUZZ?=
 =?utf-8?B?eitKOHJwTEdEV2ZEQ3dld0JlL1cyQVZLQnhVQ3N0Vzg4TFBnb2E2eTNqdy9p?=
 =?utf-8?B?V1lrT3JkTEtQUjV3czQ1NjUwc0dNV2JiU2ZLbkpVWWxIUXhPcUZ1K3Q1Sjd2?=
 =?utf-8?B?eEx4TjFoL1h3c3FKVmhQaENZd3VkSm5CMzlrUmo2WGRJVlBwVXRoSWJkdHNT?=
 =?utf-8?B?bTB5ci9RbitaeENQaEcvOHBVZW55QUtlOU0ySnU3THVMeVlSL3JhOW9ZQThW?=
 =?utf-8?B?SUhETlhUL0ppWnd2MmplUWh4NDdxZWNXT2RrUDBGYlRjQU5GMEJDb0cyU0JR?=
 =?utf-8?B?Y3FFRHRaUTdkYkZZNytUNUhRd2hZVWwxeURUd2prYnF3VytTM2NITGhMU2pJ?=
 =?utf-8?B?VlFVR1JyaEwxaGtZdnB6aGJBZ2I3MDVhQXpqUVI0bC9zbFk3Q0xCZHp3VjdD?=
 =?utf-8?B?d3ZQcUlTUHc5eVZhOWQ1S3pxYlJ5ZUVJRUtYaC9KU29lbTJaVW82Y3BrT2tk?=
 =?utf-8?B?SGRTeWE4aG9CSTJ3ZVdieDJFc1Rpendrcld1WlM3UDN2bTF0YzNVcFlxalJk?=
 =?utf-8?B?NW1vRk16Zmp0YkxBNVdwckIwZTd6L3FKelo0UGJVcDh1Q2pmclpISURiVVRE?=
 =?utf-8?B?a0d6ckNlNzFwUmxvOStlb1lkV0lKd2FtT2NWQUJENG04dGh2Vm11bGxUYXlR?=
 =?utf-8?B?RkJ3VlVsZGdQeU9MUW14ZFdWVkZhRXpMZVVSbVRJQmM2ekI3L1J1ZEROcXla?=
 =?utf-8?B?KzBVc0l4eXRpbFBYTlJhaDl0cFpYU2R1UjVvMlR0ZWNtZVdmT2NPUjBPNTJN?=
 =?utf-8?B?cTJCZm1RVzVyV0Y5bTFWN3RBOWd3SW1YWWNUdmpEb0xGdDNGYmVvMnVweFo3?=
 =?utf-8?B?WjMwenoxNkpqMzRGVFJ3dWJzMWxLSWdXOElRU1hRbEhVVTM0ZzFESEVMamdS?=
 =?utf-8?B?YklOVHFVN2M4YnFrVXI1UjVCZTB2dU1mQk5CR1hhbkdJdWQyOWMxeFNlOUNj?=
 =?utf-8?B?SGZxbHMxTWRqdVdteEZMdlY1REhwZDZvTHIwQWV2bnloYm95TjRkUm50UDF3?=
 =?utf-8?B?ODkrbnFycVRkdzFudG02SEw5bThROEpwREhRaGMrbWVHeU9sRlhSRkpaVnZP?=
 =?utf-8?B?UHNoNmtRUFBsRmdnb0wyaU0xNWZaNVdlU0toZUlkQ3FBamtpYnQ4MFJPcFhx?=
 =?utf-8?B?WnFjNWtRKzBkeWRwQ096MVpLenhLNTRjbFF3MFQxdVkxUlZveTB4bUtXaFJ4?=
 =?utf-8?B?TFphT3NNMzd4YlBTNXN1ZUpVbGhwdXBCNE9TakhkNXVINDZla1M2RFo5Rzgw?=
 =?utf-8?B?U1Qxa2doK0JTVDF1Y2NhOFJkZEFTSTNDd0dFMUQzZlNCalJWc1RNUHVURy9k?=
 =?utf-8?B?bzVQQXpvaEtVb1ZVcGRnY1pYRzBYZnUwM0YvaXBoUkJRa0h2b2NoQTR0QklL?=
 =?utf-8?B?aEZtTDg5c1ZyTU41V3NVcVdhVER4cjNiYThaTDVaVVN5WXVsTzYycGxiWVNp?=
 =?utf-8?B?RTRWcXR5M0lZTFhwNGJia3NyMkhkdnhmcXFpcXNqVXZtTEtCR1dmeFhreFJm?=
 =?utf-8?B?bkJHbndMTG15L1BtM0R4bWNNWGQ2emxwY0V0WjJJblI0bXpjZ284RTArVGVY?=
 =?utf-8?Q?kxtwnxl4NhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmNrYzR2RkY1N2RyRXUzem92cHpucENWMm9RNXNoZGxiR09uVUdLcWtGeE5G?=
 =?utf-8?B?ZnZWd1d6MmJqMHdLSGJJSjVCNVNLWFRMbkt0NWJWTlF0c21kREZjdXMxR2Yv?=
 =?utf-8?B?TkVaeXFIT3pCdkJ3OEMrZDhCUFY3L2VVc0R5Z1ArQmtxdURTclBoRTM4UElK?=
 =?utf-8?B?UlJSc0ptdG9nNnp3V3BxL0g0aUl1MkRNcUN0cFFtbG1zQ0t6NVp3VGJGaVFo?=
 =?utf-8?B?NG9GU29PS1VreEt4Vzl3WCtURXplR2VrRWdPekNZdmU4eGIwQ2x2c0sxMUJs?=
 =?utf-8?B?SUdoMVUzYW9WRndTU0F6RUFvRytRSloybmpFOWpXbHhQcTc2YlBmSE5yNnE4?=
 =?utf-8?B?NzlDbmc2UkNVMU1zQVZONzBkMlVhY2dtYXZ1QWlVbXFmWnlrcER5OXM0azN2?=
 =?utf-8?B?UlFwYmErL2R6WlNGK3cyN21kSjFYdzluakUwNEowdDVCMnNJY3piVXllZENv?=
 =?utf-8?B?MGFaRVYrZUp4ZW9FSmNZQkdXUTlsYlNCajd4Q0ZOenR1R2hVZFlsMXc2enFN?=
 =?utf-8?B?RmdpUGNOSkNzdkQ0QXdlZ2lxNWRUQ1dQRkltMHdtT0wyNXM1eWxwSitOaUR5?=
 =?utf-8?B?K3FLbkZjYlZwVi9DVzI4VXhveHpHSGVBblRUTnYzbmhSenJ2YmhiV21VK3RB?=
 =?utf-8?B?cjBBMk1HR2FuOXpTblFtdzlNMVhuOWg0WGN6YU10c3l5b1phSXZYR1pEYVNq?=
 =?utf-8?B?QUhEbG1rWnNmWkE1bHVEVkNXelh1TWhLaURKUSttTWYrZ25NVkswU1IzRlRZ?=
 =?utf-8?B?Q1ErV2o1L2dnd3BZeTY1Si9uQ0prMVcvc3dGRlphbmx5WUcyTk5kYlladFRt?=
 =?utf-8?B?OU9TNEZBYVdBQTVnTTUxS0VIckcrUE1ZUlNjL3RQWGJic1pib3U5MC80b3Q3?=
 =?utf-8?B?MUNQSThVUnZMdWh2QnpTMGgyU0xPN3AzZG1BdkUwcEFPdDdmN3o0UDVJS2Nx?=
 =?utf-8?B?Nk8vcmJ1b2RHeDlyWm13ZzRUTFMwNUVZU0ZRbXAxVU1WbVlrZGQ2U3loTDZO?=
 =?utf-8?B?bFpDY05obEI2Z0FoWTQ0LzZEM2ZkRWJxS3oyeEM3bWZUc2diQjhYeUdHb3hk?=
 =?utf-8?B?RFpmV1VWWXJKNGxlaGh3NllGM0xPNFAreUZsMWN1ZTNKRGFNTzN1ZzVSdkwx?=
 =?utf-8?B?TWs2ZThXL3BvdVJtOXZMVEpZZkZRYlFxYnRFMXQ1bEpham5KQ29OQUcyWW4z?=
 =?utf-8?B?V21TV3NhK2FVVkRFbUIwWkZRdkl1U09tSEVDOFEwU2tGdFhSUmM3dE1OcWgv?=
 =?utf-8?B?WXc1MWRqSXhUMTE5Tytydmx3NDNkL1o3Mi9kcnJORDY0cDBxcWYwMW4rV3NH?=
 =?utf-8?B?THRtQWlqU0dtUk9EWnI4citCTnRPTXNVSjRQblZRYzYwSExWT3FwWmxrR296?=
 =?utf-8?B?cFR3SEI4ZGJjSGNTZWY0WWs5ZHg0bWVvcFU1akhocjVvRDJ5K3gva041K3dP?=
 =?utf-8?B?N2pCak9kUHMrNDMzVFdLYXo0U0owSjA5aGlUcTR3dmRzMCs4OXZaR0hPMmtr?=
 =?utf-8?B?aFluNFJtdUdES1cyUVB4L1g5aUJ2aEtPUFpYdjZ6ckp1ekNQWVo0TmlIWVAw?=
 =?utf-8?B?dG5RKzVUVVpKVkpSbXdyNGNOQjBaVHhkYk1kM3JZVm84NG8ydXkyTXE5a01a?=
 =?utf-8?B?WHdXMndKdzMvaWl6bTBNVFZrZmNIWTJOZVZGc1NCR2ZIb0NyQU82VFRwaXpR?=
 =?utf-8?B?MkMrY0dQNFdyejdlbzhEWFVZZkg2Z2cyNWovb21ucUcxL3UwbWVqWUU5NVVO?=
 =?utf-8?B?S01vL1pCSWpvSVJERnhBa1AyanpVWnl1T2R3a1NEQVdUUUt3bmRyTDl5OGhl?=
 =?utf-8?B?WXNZVGlydUFDWFBCdWRkTkcweHBwNGZyOVRuSmpvK1M5ZkkraXM2WXU4Y2lk?=
 =?utf-8?B?Rkx4MTZQY3FsY1pLQ0pBbkEyd3BFcTVmTFlrOFVmVjh0cTF6djE1YytjNDFh?=
 =?utf-8?B?SUszdEFidmg3SG9yTWpBRUx0MDJ1RzAwRmNNT1ZpTm5YQWw1ZittekZQL2Nw?=
 =?utf-8?B?R0ovMEdmSk5kVEJyYzFicnJnd0RWRGtNWmMxY3FTclE0Q0tiVFA0NTZDTlY1?=
 =?utf-8?B?WXVHSnRzbHozZFdBbGw0OEUxcS8va1gzR0hJcTRZTHBoeVFEU1FZOVFUWEti?=
 =?utf-8?B?LytzazRrejJsSWxIOVZFSFE5TTZ1STIrTUhRMVFPZVlReHhzOHdadzFrUDYv?=
 =?utf-8?B?dnRWZlRROUh2bVdCRjRCYzJ0WFBVV3VyYk5IcXVVTmYvU3NtOXZTcThRaGdy?=
 =?utf-8?B?SG1BTkxndGpndU1sU0VQa1lSN0VRPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df6dfb6-d80f-42ce-81ba-08ddd674df62
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:12:41.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mSf2j2XDdjC6Wt2ZfnBq8yW0KpwM3sN4jUkxqvjF7rD9onFnLbto4U6NZaIjL3ZbvK5dqSrM9qsfC44xTrS1geb7qw2nigqoowtdxc2CpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7582

Hi Denis,

On 8/1/25 22:34, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 7/11/25 9:26 AM, Jussi Laakkonen wrote:
>> Set the association state when VPN is waiting for user input as an
>> initial state after connecting the provider. Set the configuration
>> state (as it is declaced to be the string to connect state in VPN)
>> accordingly as well. Start VPN connect timeout in configuration
>> state with restart option to ensure that the timeout begins from the
>> last known configuration (connect) state.
>> ---
>>   include/provider.h |  9 +++++----
>>   src/provider.c     | 22 +++++++++++++++++++++-
>>   2 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/provider.h b/include/provider.h
>> index 3f2e36ad..aac47527 100644
>> --- a/include/provider.h
>> +++ b/include/provider.h
>> @@ -44,10 +44,11 @@ enum connman_provider_type {
>>   enum connman_provider_state {
>>       CONNMAN_PROVIDER_STATE_UNKNOWN       = 0,
>>       CONNMAN_PROVIDER_STATE_IDLE          = 1,
>> -    CONNMAN_PROVIDER_STATE_CONNECT       = 2,
>> -    CONNMAN_PROVIDER_STATE_READY         = 3,
>> -    CONNMAN_PROVIDER_STATE_DISCONNECT    = 4,
>> -    CONNMAN_PROVIDER_STATE_FAILURE       = 5,
>> +    CONNMAN_PROVIDER_STATE_ASSOCIATION   = 2,
>> +    CONNMAN_PROVIDER_STATE_CONNECT       = 3,
>> +    CONNMAN_PROVIDER_STATE_READY         = 4,
>> +    CONNMAN_PROVIDER_STATE_DISCONNECT    = 5,
>> +    CONNMAN_PROVIDER_STATE_FAILURE       = 6,
>>   };
>>   enum connman_provider_error {
>> diff --git a/src/provider.c b/src/provider.c
>> index 1f0ce10d..ab4aeafb 100644
>> --- a/src/provider.c
>> +++ b/src/provider.c
>> @@ -126,6 +126,22 @@ static int provider_indicate_state(struct 
>> connman_provider *provider,
>>   {
>>       DBG("state %d", state);
>> +    switch (state) {
>> +    case CONNMAN_SERVICE_STATE_UNKNOWN:
>> +    case CONNMAN_SERVICE_STATE_IDLE:
>> +    case CONNMAN_SERVICE_STATE_ASSOCIATION:
>> +        break;
>> +    case CONNMAN_SERVICE_STATE_CONFIGURATION:
>> +        __connman_service_start_connect_timeout(provider->vpn_service,
>> +                                true);
> 
> Possibly handle this inside service.c?
> 

Could be. However, I kept this here mainly because the VPN related 
operations can be extended based on the actual service state. Like, we 
have an IPv6 disable option that was not yet accepted by upstream, which 
simply disables IPv6 from the transport and all connected when VPN setup 
requests so. It was discussed whether undef routes could be used but 
after trying  this approach, also with desktop, it seems that 
applications work really weirdly with it. It is not related to this but 
makes it more convenient to make certain VPN related actions within 
provider.c and not to clutter service.c with more VPN specifics, right?

>> +        break;
>> +    case CONNMAN_SERVICE_STATE_READY:
>> +    case CONNMAN_SERVICE_STATE_ONLINE:
>> +    case CONNMAN_SERVICE_STATE_DISCONNECT:
>> +    case CONNMAN_SERVICE_STATE_FAILURE:
>> +        break;
>> +    }
>> +
>>       __connman_service_ipconfig_indicate_state(provider->vpn_service, 
>> state,
>>                       CONNMAN_IPCONFIG_TYPE_IPV4);
> 
> Regards,
> -Denis

BR,
  Jussi
