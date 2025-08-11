Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020094.outbound.protection.outlook.com [52.101.84.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D422CBE9
	for <connman@lists.linux.dev>; Mon, 11 Aug 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922110; cv=fail; b=LoxmBQnYKAWsaVDLkoRiAVIhOuoW7iN9yKdCSx4fuPOSA5eh0bpq0WSaBx1IoEdoUC40UYJ/ZTNm28qKWpub4iRVwmQaAphtqYjcHDDUNdxtMOMAGlPWR37RexO3Kd7JTfJGiFKquU/f1xNJnO7mmIEbGWaVPfKseucUzus3bMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922110; c=relaxed/simple;
	bh=Lkbs85pIROjiYgIm1Uxfl6ZGsIci7KvGEJBW6ASc89E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oz0RnDMfJLL12eYzxUC2kpKn0zsCwOYxfZjajiVgYs9Dy2eaRg0fo+eaXQcMJ3VO1n5/wdqBFpkmHUFEC86ULQwVzGN2PbFoa6q54WaBKMOEzhXowyv521Qem00siXYpSyHJHzeuJPTSr5XmPDpo5i9lL4K7f70ZIVChKACLChg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=JQXs5M/H; arc=fail smtp.client-ip=52.101.84.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="JQXs5M/H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjFSow8XpmOfeD71q6e0sfb+w93ZRdaHaC9InoaY0DYGExZkbuSzfAWf5SW8LHsSLso0ToMovMWQbecAKNm/1KvBsMz3mxPZhJduc9RFwm1S1g0Ph3MRFq6OgEJWQ/0MRSGyWNYntPoVsN57AD62MuArfg4hVvxtU26G/1SxqZ7bnt9Tqu0ApQvedz/lCFHkKuqpz/TGGAhuPXkvclD3O1A+ciVxxpGDh4VQ1MrIRq+GzY3Uu7bNb/W3eehiA2epnvs4RGRgB4S44PPD7lAYyZvCkgn79yG/AA3CNRRg5LO+CCcS1Hq1z7beU5sNvxUwsJZmjQB9HpqXR+Px0wDEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7d+bxkETl9J1Y3YH32gvAknexMnzZLxlT2eUNIiUMA=;
 b=v8NRn1y03Ir66fof/GH+Se/WxhOzl+zxIHTHBXmO+x0RxWnLHdzmBAb2AueEU0yOj03LqciSJw8bNisDzmlxjA85Z4Spd7+UjemO7Rll7rAcGfFCPCvittST8cHiQN/+/ZJ8Bo7+ctwZzzzw9+YlAYaS4ntzMCLwERxLlNZodW6pHfTv0A27myT3Jk7DoPuX6SQT0LYexa97i23PYhKsW6pGyPTV8/s683Lhlr89NXXHinHUX/dyAhnQyekstLja95Ig7Z/YEDW8EHYV5+mlXhlFo8GWxOC+cPuZE1h+IyEjBvkqmAX3HSJO4vaalZxaYagiNCQuY39K5+QLVxzZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7d+bxkETl9J1Y3YH32gvAknexMnzZLxlT2eUNIiUMA=;
 b=JQXs5M/HHUY0uFf4cJg3xBz6i4LFYR9Tp5rShdSsGgzaKRBJXbdvZdNV1DP3wJPXSRbtuHcKp3UiPWql7JTF8ngf8wozTnoy9q/vOnwbGOVrdd/d1xZI4Zxp9cvlf0ChGzwJMZsxf2aycp883NAnurevhX+Pm8KMRFFxIrQ47SQlBaweSVhwCk+wXW+2a+K8Nq8GKj7nd8BA9f1ADGJxARc0EBV+cLvpgIT/gNTt6aabZSYE+COCp48X9Mf0ORibBzZlHfweSHFgqpiZihf7tCsfrzDqtpD5NJAfKJ+kJewApNx14Jx4hcDhwz7FFOXzACgNVRIHntGpOvBD/GlBXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PA1PR06MB9168.eurprd06.prod.outlook.com (2603:10a6:102:460::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:21:45 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:21:45 +0000
Message-ID: <fd77a689-d06b-477b-9893-4d372d3d0eb2@jolla.com>
Date: Mon, 11 Aug 2025 17:21:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/45] service: Explicit VPN connect timeout, ignore in
 VPN agent wait
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-6-jussi.laakkonen@jolla.com>
 <06df3300-c462-4294-85f6-b90315ef012b@gmail.com>
 <463ce86f-be52-47af-891f-745402387c29@jolla.com>
 <42c25386-1dc7-4ef1-aa0f-b36b5d29dabe@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <42c25386-1dc7-4ef1-aa0f-b36b5d29dabe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNAP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::10)
 To GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PA1PR06MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ff8903-d83c-4c0d-2660-08ddd8e2662c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGk3bCs4TXE4YTNtN2Z0N0hXSUhwNUhFZWtYV3ZXbjNGL1dGdjN2MU9PQ05V?=
 =?utf-8?B?ekQ1WW8zSUx5YldKT2MvYVNqOWpqV1QvdjVOMjJ5c3lnZFhRZVE1US84dGRo?=
 =?utf-8?B?UTA0Wnl4emROZm0xQnJxN1RyTWRpa3cxSWxYakdhRHdpRlRSb3Q2SDBlbEFn?=
 =?utf-8?B?cE9weVV5cW8rQkVnU2JySGtQQzRjTUhtQytWZmI5ZDFlWmErSC9qUTR0Nk9Q?=
 =?utf-8?B?YnZySUw5cUNadmRra0J4RXVZWHVqYXFUMEEzRFFjSU5RaDB2NWUzVmZwa2FZ?=
 =?utf-8?B?REdzdjNGZDhQUDRPRGNkYlVFTkk1ditKUEZhek1Qd3lRTDFNbTZxa3pZY3M3?=
 =?utf-8?B?Y0Y1UEJTdEJ0R0l2WDJLdTJlY3JtWHRFS3pmRGFoaUIxZW00WkR4WEcwSDlO?=
 =?utf-8?B?TGZYc3ppM3lZUVBJN1ZwejVXUVBXcVJtUVAzdlN0UWduczZJMVVjaFlFcWJi?=
 =?utf-8?B?RW51VklCOWxtbFgweUFHUjhiQlFETEFiMlUrb0Y0VjJyVWN5Nmd4NFY0YjhO?=
 =?utf-8?B?M3h6U1VzcmM0b2dSTzYyTjNrakU5c2ZWbzFFUXpMZGFjTk9NbCtELy9nM0ls?=
 =?utf-8?B?RS82TFcycU9LRXo5djR1T2dqVTBtVDNpaDVILzAyQXlzUEs4N1ZsTTRQMll5?=
 =?utf-8?B?QStEQUxVSWt0Sm5oSFBZOTFFd0g5czR1bnVwYTNNN1BGUE1iSGppem1rRUFi?=
 =?utf-8?B?dnRUK3pma2dqdzVoUUY1Qkx4aDAwL2QwaW4wRXM5REhlUDRFWnF6Zjh3QWlh?=
 =?utf-8?B?WHozRjRXTGtsdE1uaDNJLzJCNGt6N3FLN1RoUjhucHpzbWJOVkRCM3Y2aW5x?=
 =?utf-8?B?aTBsdXpjb2FSZEN1V3pKZ2g5NHhTQ25sYUlsbnRXVVVOWFJEdTZ5RkFmbFY0?=
 =?utf-8?B?cWw5UjV5RUN2UHllK1FIMkJTTnZoSjI3ZUpuQkhJa3hESGFkSUE2cDltTUdH?=
 =?utf-8?B?SnNKdHlhdU9yZHBVWU1jQWJpMVB2MUI0Uk5SNndGVGYzbWRHVElFQzg1Q0NN?=
 =?utf-8?B?VzZEN0tSSkpwR3hyR0NheE9kNTdua1FBbGJXcTNYMjk5SS8wM0VGVGVJTVA2?=
 =?utf-8?B?M1dOQUNXaXR4NVBwZjdOYmllcFlDckxsQXJFZWg4eUdPWmR0QWE2SmVtdUNX?=
 =?utf-8?B?RU5VdFNJNWZjWnpUVDF5S01uMU4vcVNrbFhTb0o2STJ1RjFKVXpKM1NMYWlC?=
 =?utf-8?B?OHgySG9RZkR2bjBxdmt5VU42YnRaZUlleVZydVpCM1hDN1RZZDFta0VlWElr?=
 =?utf-8?B?TUVscDNQVjdWSWNLeFZIeEcwd0lWcWFLaTFNVXd6RjM4QktKTkRKMjlWbWVl?=
 =?utf-8?B?ZlZqU0JuekYyTy9JTU1PRkhLVnYxZmdUVVdwVzd0L3lyRjFXZ1pSUHdCOTdv?=
 =?utf-8?B?b1g5QktNbmUrREVYSHJkNUhnN3Y0ZGlGZEJva25PV0dVbEY1U3ZTNW5MUUxu?=
 =?utf-8?B?SjJCelJpcWxCd2hyekdFRXFzeEJQc1g3dnpESFFFVW5lY2pmZ2JkRlhSV3ZP?=
 =?utf-8?B?eDAvZmNjZm5ZVkdIWFd2aW82MEM2R3FnV0grSlpQanhuM2Fqd01pNzlwT2NG?=
 =?utf-8?B?eWwxOHp5VXlwN1FZRGNldm5lWDdwOFFaMVFGQUVibTJWa29pcUZ5dVNjSEYz?=
 =?utf-8?B?YkJESk0xSU82aVNXclFZMkdTZVJsaUVjak5aVDQwTThLZjdJOUVVdHhSOFZZ?=
 =?utf-8?B?TkxQN2JSVGxRd3YzNWJwOThRamF2OGg2cFA0d2ZSMGowVEIzQjdhMU5MclBC?=
 =?utf-8?B?QzVhM3N1Vjg2TWpuRTRnSzhRN1R1NmRaZDB1QlNvam5Uazg4R3haZFZMbCty?=
 =?utf-8?Q?Ws189oGcnHza3ATpLOUT+ECnUWokpaXu82hZs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5QVmttU2lxMk5rS2pIU2hKbnBFemxXWkExV2lMUTlWWlF5MlZ5YVErQXl0?=
 =?utf-8?B?OHJtQWhhc0VnUmVJd3dWbDc5MTVMWWt1SE1aMDNaNDExb21BbGNzWlBnQnRJ?=
 =?utf-8?B?OFFhcWgyRGFIZ2lCNXpmZk9QTTdzY1pGazZ4cnBPYzVFTmJRMklNZHZZcWtt?=
 =?utf-8?B?M0V1NE44QzYvejNWUHdXc2JscGJQVElZRVpQeUw1YVV0ZmlFNFVQVURtdW93?=
 =?utf-8?B?VXlKRWJVSHEveEZHMzdHVy82QkFMbHpFNXYybTBlc0hUMy90Rlpqd09POTVn?=
 =?utf-8?B?Tnk3akowZVNlYlYxL3NCMGVFbzlZcytMZEVnNjVLYW5LWkdnNmtCSEZ0elV1?=
 =?utf-8?B?OVY0UGJUc2VnL3RmVzNQSG1NdXZuS25vNjJNa0hxWExlQnUyeURsMHFwd21w?=
 =?utf-8?B?bnB1RjJYRmpiYytKUzFKODI1MHRQZXdwSzMwYy9wM3pIejNjQjBkUS9Ddm5O?=
 =?utf-8?B?d3dWdkNXSzk2YTQzY0tDb253MWNKRlA4UnhBRm5XcFJ0blc5aEMwVDlsVzFL?=
 =?utf-8?B?cVVLMlQrVXQzcXlERklQdVcxL0xES2pLRENvTUJtY3lXVWpadEZpQ3JLYTRl?=
 =?utf-8?B?b3VwN1h1LzNjZS93bXd0b3BCcmRReEp4Yy9vclNUME9FNTBXSFBmckZvWloz?=
 =?utf-8?B?VTY4S0Uvd0JwK3A3NWRITEhHY3ZmSEM3djlSelg4STljaFZReXUwUTVSWWlH?=
 =?utf-8?B?ZlBhQitsd2txekUvR3o0UmpPN2lmNVdSNjN2TnQ4WnRMaThqTEJlSm9vWE1L?=
 =?utf-8?B?U29ITEZnYW9GWUZrWi9MZmFEZ3ZBNUJxalExUTVLVXVZcVVUWWE1SFdzSUcw?=
 =?utf-8?B?aEIrSlJDeUVLWjhBMVFQODd4WHZiek90Y0g5MFZvQ0dQWFF4QlgySUI2SFVz?=
 =?utf-8?B?WFArQ0VmaENSUkEzdzE3bXFoSDJtQ3JqMHovUHlJTThrMEhnbmVidENjWGo2?=
 =?utf-8?B?VFJ3K3NrRFVMTUkveTdFQUczRUFEUlNmQVo4eWNDcUJCd2ppMjJoZmczaDlr?=
 =?utf-8?B?cFhEdHUycjRacmljNTcweUd4VEltQzQ2MTM0U2lXOGRjRmhSb3hiSHZRdDBn?=
 =?utf-8?B?ZlBsM2cvcGZMOGRHZXVzbkE4SXNIY2s4dktObDlvRmpRR1hUN29SVnI3MFhj?=
 =?utf-8?B?Q01hTkNEcndldHp5bExlTTduSGsvRFFMTkRIZno1R2hXc1dXdkZ6Q3JEcjY4?=
 =?utf-8?B?cmczclo4cE96Qm1NVGlIYTc1Vm9wYmQxSkE2Vi8yQTlBdlY5L250LzF1NXJL?=
 =?utf-8?B?bnVtcnMxdk5aSXQzaWcwWmE5ZitpOTEvRzVIRjQ2WDFkVHRVVnhRMHBZbysx?=
 =?utf-8?B?UnVSaWNNOStORWpYdGluZHVvNGtQVjg5L2NEdnRwT3NVSzcyV1JIWnVBN3Fk?=
 =?utf-8?B?eVNWU0xySEg4Z3JYNmhFTVozdEEzV284c0ZrQzRXVkcxWHpkY2xpWmNDblFS?=
 =?utf-8?B?cE92OUxPUlJMTm9ONE5iamZmN1hMSzhoUDlPOUZQOHkycHpqYVJ3dHNPMkNn?=
 =?utf-8?B?TmpIR2cxTkFQQjZCbkFKcnY0UjlxbW9Fa2owSTZjaDVEcDhTWDU0OU5Ydytn?=
 =?utf-8?B?aUlsazhobmVMa1U2aXgvMnVqTklVeUhUb1VTdUI1ZFhaVWhIclRiT0J5MjNo?=
 =?utf-8?B?SFkwQTRIN3JmNElQRUY5eUhpK3VGMUFqZW9ySjZ2NVZ2cWFnRzdOWnYzVVlS?=
 =?utf-8?B?OEI2VFFhdURSTjNBVnJCeHpvV2hyR05RbVhqb3JWRmorV0JKNUJ4Ukk2VTJT?=
 =?utf-8?B?OEVBQ2srVzQwcThid2I3eXJBVEh1eU1MMkhkT0FnanJOTVdnR2FFUVZKNkk2?=
 =?utf-8?B?S0hNY1crRkovTmExZkhVUG1zK1BQc0NqVER2YjlTd1dNQmJSSmhsRHIzMkdU?=
 =?utf-8?B?WjhuT04rUGVheHNCYTFER1FQMXRvT1BFaUhFMnVnMTYzemxwUUhsMGx4NVJ5?=
 =?utf-8?B?V3daTzU5RjgvQ3p1SDZETmcrR0ppSjFMSDVxOGYwK0hZYlpmQ1FlZU9BVU9J?=
 =?utf-8?B?UzJ6S1BRMmVGWENTeUtkMzdnalo0NjFIMjk4bHBuYUJiVXRKLzE1bFpobHQ0?=
 =?utf-8?B?bEdScGt6T2VtY1lBelJEUGxIcHRvR1g0Z1ZwdWVMMVFiclcrTEdTbzRXbFp6?=
 =?utf-8?B?OWRveFpIeFY0LytvSGVEUng5eFBxcE9LWVZHSlNWeFRoUnZHUTBXZ0w0QTJK?=
 =?utf-8?B?c1Zyb3JCZzAxSlBLeVJtVVBmd2pLTnIvTmVVS2ZPZTZUQkZKRGR5cSt4eHdv?=
 =?utf-8?B?b3gzR1BWdnJMY2JscWZoMzhDZFNBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ff8903-d83c-4c0d-2660-08ddd8e2662c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:21:44.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrtYTajzDnElFFCpJpgVHEkHk+zsS4piKgVpAbTfT+DrFHW1/ZaX5K0kO8Frv3ij6L6Vpu2pI9dcZzBu64h74GgEw4ZYcEweYCSKLOstMpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9168

Hi Denis,

On 8/8/25 19:08, Denis Kenzior wrote:
> Hi Jussi,
> 
>  >>> @@ -7322,8 +7322,27 @@ static gboolean connect_timeout(gpointer 
> user_data)
>>>>       if (service->network)
>>>>           __connman_network_disconnect(service->network);
>>>> -    else if (service->provider)
>>>> +    else if (service->provider) {
>>>> +        /*
>>>> +         * Remove timeout when the VPN is waiting for user input in
>>>> +         * association state. By default the VPN agent timeout is
>>>> +         * 300s whereas default connection timeout is 120s. Provider
>>>> +         * will start connect timeout for the service when it enters
>>>> +         * configuration state.
>>>> +         */
>>>> +        const char *statestr = connman_provider_get_string(
>>>> +                    service->provider, "State");
>>>> +        if (!g_strcmp0(statestr, "association")) {
>>>> +            DBG("VPN provider %p is waiting for VPN agent, "
>>>> +                        "stop connect timeout",
>>>> +                        service->provider);
>>>> +            return G_SOURCE_REMOVE;
>>>> +        }
>>>> +
>>>
>>> I'm a bit confused why this entire block is needed?  If the service 
>>> is a VPN, then the timeout isn't even started, and thus 
>>> connect_timeout() shouldn't even be called?
>>
>> Yes and the point of this was to extend that the provider.c can 
>> initiate the timeout for the VPNs as well to behave similarly to other 
>> services. So In ASSOCIATION state there is the 300 timeout for 
>> inputting credentials etc. which is then followed by the 120 timeout 
>> for connecting in CONFIGURATION state.
> 
> Yeah, but right now you're introducing something that is essentially 
> dead code? How is this a good idea?  Introduce it in a patch where this 
> is actually needed?
> 
>  > > I think this was done because the agent needed a bit longer timeout 
> than the
>> connection timeout is for the user to input the credentials and it 
>> seemed to obey the 120 timeout instead, so the aim was to make VPNs to 
>> have same states as any other service, to synchronize the behavior.
>>
> 
> Why would the core have a timeout for this at all?  NoReply timeouts are 
> purely a libdbus-1 construct.  You could have a dialog sitting there 
> forever asking user to input username/password prior to initiating a 
> connection.  The driver should really figure out whether a timeout is 
> needed or not.
> 

Ok, now I remember why this was done. Both connmand and vpnd have 
separate and configurable timeouts [1,2]. And by looking at the code, 
any service started will have the connection timeout set [3].

The main reason, with adding the association state to VPN, both can be 
respected and VPNs will have same characteristics regarding timeouts as 
any other service, except that the vpnd side timeout is now respected in 
the code and these two do not overlap. It was a bit puzzling to find 
this out in the first place that why the changes to vpnd timeout value 
has no effect, as, for example, NordVPN credentials are so long and 
since our UI implementation would not bend anymore the timeout for input 
of connmand was not enough for inputting them. And since both had 
separate configuration it did not seem feasible to increase the connmand 
side because of this but make them both work, independently of each 
other. Thus, I think this addresses the issue of these two separate 
timeouts.

Granted, the __connman_service_start_connect_timeout() could have the 
checks that if (vpn && state < CONFIGURATION) ; return; or something.

This part of the patch set was already discussed with earlier maintainer 
[4] but because of reasons I had no time to do the regular, non-RFC 
patch set yet.

BR,
  Jussi

[1] 
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/connman.conf.5.in#n29
[2] 
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/connman-vpn.conf.5.in#n41
[3] 
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/service.c#n9924
[4] 
https://lore.kernel.org/connman/20221213140707.278313-1-jussi.laakkonen@jolla.com/


