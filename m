Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2133.outbound.protection.outlook.com [40.107.249.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A9291140
	for <connman@lists.linux.dev>; Tue, 15 Apr 2025 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714081; cv=fail; b=t48R9SvIU8Hdud6fGwND3T2mhZavCYmi6EHugo0+Q/9xJzMHf4Em97wSAt+JG6wYySHFbGdwJOd+g+fxeCwz0fmMJPDwFbyJ+sD9NpqWyfYKzhVcYF2+m+cLdD3E53Ma2b4zLLGPmo1wJnaH9rmd8xQU13fUfLlgraKaGI9YrSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714081; c=relaxed/simple;
	bh=NeFCB+RUxSvLrGCGQ3VUDgVNWjPZ4JThuUVkJB5lwzc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gPcsCkdP81CmEyYKXV3e5RRfFEOLsFQcQezh4/BxPmDvfHY4R6SdZUb3Q1EyqxuQwJfv70qlwg+nq5A+iifeHx8Zs6neW7/jX0UxdDPsNcZliFW/ZPpgJHkkMN2dhGam/fXZ65uXZDx89JgJm5fCx0s/Dw6i4NjDiW5xxX4uMRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=JwQB0sQp; arc=fail smtp.client-ip=40.107.249.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="JwQB0sQp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhuCSiRwL3sWf8CXkZLRt86zk545DjhYVXn3HNuUQ2D5M3Itk8xU4K6ik0y+EVReh6EDC2fGNfYe0egaqz24Cra1DbKYeJ6c1beKsCyoUq6k41SWyfinXXDLOrNlntLsw+1KnM1peoOqPUtzqO2kQwV8+XgzPlCdvLpoL5BOzbQ3KefQY+748PTrzqI6z6R/RAo0lUPkgZJ+KJt8Y9VktLFMVL43efxOoD6QdzcrMtJg5foccJAnRrAf1MT4OJCTnYkeqTMdrBfqss5wbGQqCeh3Fj2HF2cbK8uaJgflzoCi0QlN8goSbaez/GMOhLZomIUz1L7S8T5V4pNBZ7VzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgD9swc5cezZdMQ/SiVSRISmNUm7qpLd1nLgZWpqCoU=;
 b=hnmumkBufvkmMlRMFBh2N75K1ndm+H6gjlouBCfGOGRwwntHi4nHIoA5hlLXh+XBbNUVTYspfoDk6ZgCyCPsx77ezKx68cYusHkJ6jeUWNJ3QTvq4fYYkJi1yf50bQsIJQDxPf/XK6gKUsi7ReT4zc4VwE52z8CrILqHVNgcOZFOVCFYBI9VyqNFy1oZWZ8s4zr5Kl4E6qX68pAeIIgGf8C7qBArJCS+Ox30SGqfmJ0WdwfEc2F8vAqCtF6Gp95JMEcoRU2M9y0bCiqOMUsiQ5kixhLIwEWbSBcfEKAeQXIQQnuxN0c2XNvNA/hmpGtsLnEqCdLsKVcwEKd9v/k+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgD9swc5cezZdMQ/SiVSRISmNUm7qpLd1nLgZWpqCoU=;
 b=JwQB0sQpbuadYj3Sv44PAEdjxOXSi8PhHb2p1T+AO7F+ZaLQqlqmsz/L1bMp8NYT8bQyvRHEZxmRsij42cXtVSQZex2Rvhs0bcbTr6ZfV0lwienOK2RyrXXAbM4ZEkpKBfX1l5+Xk9PRdULk9VaKuXjWyjwZ4sJSHEszMKYfY2qxx1t/qb0AGVTTfJ7y6wBxy0IighaVG1LE/GC/5NMFRrp11yBpPvTHGeheASu82UuisrwGafjVWBACp1a1CkFoJtArQQoXQqkKBoNpamz/8ocrlBXjtuDSyd3kGAsVWhMebTeUtJmNrrxVi6aIfR3ShJZUvIsJM1wy/lHJBC91JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PA2PR06MB9362.eurprd06.prod.outlook.com (2603:10a6:102:408::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 10:47:56 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 10:47:55 +0000
Message-ID: <79bc2a55-92bd-4be1-8396-aa243d98f9f5@jolla.com>
Date: Tue, 15 Apr 2025 13:47:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] ipconfig: Fix Clang garbage value complaints
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
 <20250410155846.252858-6-jussi.laakkonen@jolla.com>
 <321172c0-abe5-44ba-bf03-ad22a1fb1ba8@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <321172c0-abe5-44ba-bf03-ad22a1fb1ba8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::11) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PA2PR06MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cc8067-5080-46aa-81c3-08dd7c0afac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXFpaHB4R1gwdThGdVNyR2hHUGp1V3lCaDJ2ZWFSeU43b240SG5qYkhTYndY?=
 =?utf-8?B?bDFkN3pjbjNZa1dGeGEzMHViaStDUFJmRUZ0bGJEc05BU1UvaWl5NFJGV0Zz?=
 =?utf-8?B?YnZVenRLZzZuUkxYQUtvMk0rSEYrR0o3d0RzajloblQ4WEF4TVo1VUVaR2lx?=
 =?utf-8?B?QnZ2dXJmTS9xR1o0T0FHbnZqd21HU3BOcG4vSVJubTRTdm1tRkZvMjVScWtR?=
 =?utf-8?B?cFBoaHU4NU9yUnc2UExDUnRHZTUzUFo3WXRnRGlsZGQ0YXpRUVhyK0tzeXVF?=
 =?utf-8?B?Vk9iS0dCMFU1NWlDUlprQ1JrbTloYW9XckhhS3FXcjlFVEI1aWpMWTViVlpG?=
 =?utf-8?B?em0ybzhRMXVWVGJjVHFIODV0eFZUNnczdkZXS0FNL1FOSlg2WUxLRVk5TlBV?=
 =?utf-8?B?WUFmNkxEWEw5THJWaTF0cTVKeEVDTldIVWEzRUlaL2M0bGUvc0x3ajlFMjAz?=
 =?utf-8?B?V0p3a3d2VjdZbWJBenlMWmRRMGZIWGQyWVFLOHo1aHNXNWZsMDVVV0xjWWdK?=
 =?utf-8?B?MUQ0bmh6N1pIanBTWlNicHA5YXVBTTFuSmx1dkVjRXliajNUVXI2THh5WFFr?=
 =?utf-8?B?SElGa2FVWWZtczJ1SGtvdFd2NTBpOHBCWlJjeDAyRnhzV0lSc1JlaTV6RFMx?=
 =?utf-8?B?UWdNeXY5b1p1YXgrcFlWQkdBQVJ6WityclFoTWpHdG9XR1RobVFlVUJRMisy?=
 =?utf-8?B?OVZxQnhzTHVtQ3dpNHBWa1FJL0d5SWcwc0dTMWsreG9zbGlaMGlTUmJ1Sk1p?=
 =?utf-8?B?dFVtdHpjVHdjODJtanpWM0hNcTBsZEREak9BOVN0SVdHa0JoTHdpSHhXQjZr?=
 =?utf-8?B?Wm5aTUNMQVQ2bzl5RXg4VHBRTVpFM0hwbytWNGtNOWJhOVl5NjUwMXlnS1lJ?=
 =?utf-8?B?ZTh3a3pWSUI3S2pEUjVjSDhFeTg2Sk5GMmF0MmorZ0ljT0NYUm5OeFNaK1dq?=
 =?utf-8?B?akRJbmtlUEFrWFJyNHRPRGM3R3M3QUExTEZsckJ1UjFUcXlUS09FdmlFNkl6?=
 =?utf-8?B?M1hKTE1NellKY0FPS2swOHJYR0dCYTBTQ0xxSjhFNlZ0WkdUakk3WmRzeUlv?=
 =?utf-8?B?c3cxOVg5RWRqT0RZdXF4VmhiQnh2Zi84c1ptSVBTb2ozUldPdXFlUWtUSFY5?=
 =?utf-8?B?aW9rVVphWkZ3RTgyZGZHTlhLbVNCRktjWnl3bEVUcExDMThUay94ZWhWdExR?=
 =?utf-8?B?L3RaUFRXQndnVVJKR216VG4rKzB5YnlJdnlaVWV2SEMyUUx0aHdiUHk4aFp0?=
 =?utf-8?B?RHJMUkp3UktOYWE2ZkFIbFpkaXMveEE1QWFhMStDcGQzTnpCRWRTZmk0YURz?=
 =?utf-8?B?SnRDWHFKam95NnlzM2lSeXI5eHVLMGNjak5PU09yNVRPMXJiU2k3TC9oM2Nz?=
 =?utf-8?B?VmxsSEpSZnFzWEJNeVpaVVNmQWxsUXAxUDVjcVFxTm43akdabHorU0VRVDU4?=
 =?utf-8?B?ZXhtSlZMWHBURVp2T3lvUndjVk5TWWVCSmN4bUQvTXdTYkE2cVk3bzJBd1lI?=
 =?utf-8?B?TXdlZUg3aDdKYm9BM0k2dDA0eGJTcXgyU0laSyt6VGZDSUQwM3g1bjlLTXJC?=
 =?utf-8?B?WEVob0N3cG83dHBIYTkxSTlyYVYvdkVNakExMEdiMEVDcElTSWZGZUNHRzl5?=
 =?utf-8?B?RWFmZVZ6aDcxczFraUNlSFdlMUhqL1dGOTZWelBaaHozazNyaEIzTUtYOVJF?=
 =?utf-8?B?R3BmQlo3dlBlenhmeFJaem1lWFZBTU9TQlpEWUhLeFFadVJlUFJNNmR1N2RO?=
 =?utf-8?B?Nm5sWXc5dkxhZCtoV1NRcXdIWWNERzQrT0tiNHhJZ3o3cDhLRVppSFNqUDhy?=
 =?utf-8?B?elNNWDRaQkthTkZMb2hsNXFIMVQvQVRyK3dCaXZZUHF0dDdmVnhVT1hiUWU2?=
 =?utf-8?B?MWJnSmUxUWRBYzIzZGNEV3FDN29ZWVFpUmhkdW1VOGFHQ2RKTjJrb1VDa2tz?=
 =?utf-8?Q?g9acg2NEvH0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHJIQXVJa01pb0lubVFsSkUzNVV6dnNuQzVDbExXRXNpamNMZVRKV2EraWxw?=
 =?utf-8?B?U1Z4dDRqWi90dGhWMHkwWWtNeWhSa0xUeStZOUkyK1I3UmtrZSsyaXZPNFc0?=
 =?utf-8?B?ZDFiYy9BeVJaSDNrM0JqU3lUTkg5eEVVa0Iza3JuRStUM1lWZFRnWU9TbDFS?=
 =?utf-8?B?bFg5Y0RvRWNFc1FTSi9YdDZidVNQaXF3VXFXTzEveSsvWlIrcWkrNWppMmU2?=
 =?utf-8?B?bmZsNGk3Z2VPaXFpMzRkcnhqMmRVNzRmTHcwZnpNUlpYWWZxMERpdHBjelZH?=
 =?utf-8?B?R3I4cTVSdnBaNk52ZzROR3NZOWJqcmNGaGpDZjgzYVpVVUFNRjhFNi9XQkxp?=
 =?utf-8?B?d3ZXL3NITWJCYTc1dUNKQ1lkbExwS3A2bHBrdjMrcUgyREwwMzZTaENNYlk0?=
 =?utf-8?B?SW9HTjFPUVI2Z3BMUHVqd3RiRjVEMzk0ckVlY0RyN1RGQmR1MTBVYUF0NlZ1?=
 =?utf-8?B?L1lXd0tLWWpMV2k3WnFsTjZibGVrdDAzTjFuVE5iU3k3KzR2K29TRWJZenZQ?=
 =?utf-8?B?SmEyVm1IT0t4ai9IMDJiSWhjMnJwR2Z3WHl1YUxLVVdIaGR6eWF5T0RxZjRY?=
 =?utf-8?B?M05jRUV1b2VENTBvNGJqUEdpV2EyOHZPS2llVFlSdXF2eXR2SVFUY0xTVTI0?=
 =?utf-8?B?YldZVDg2Y3Z2bGttT3pHemQ0S3Z4Z1o3cU9WYUlOQThDbml4Nytza3RLUnNC?=
 =?utf-8?B?cFllQ1ByMWgyTXNKckwwcWJaSWY1bDdBYUNVQzdqSXlQRGFBWjVyRFFwVjF2?=
 =?utf-8?B?Qk43Vjd1cUxHVU83b1ZuN2ZUcGhITmc3L3BSS3FuZU1PekVibS9RbzlwZXN6?=
 =?utf-8?B?TnNBUFlMWmRHVGFPWCtiMkR6MXNnY3JuVDVCb2djTm5CbTdrMWMwTXZTZHQr?=
 =?utf-8?B?cTQ3ZWgxYnptaWlmYnViaEM3aU1xYnVMTkpWdGV0cTRUM2l0UWppdldHNEtM?=
 =?utf-8?B?a2J1bFRXMHI1d2NOUENtZTN4K3krbytjaytYUDlINE0vMEMzNWpLNkt0Tk84?=
 =?utf-8?B?dFBFYXJnS3RZRnlHL3ZsbTFvaTZMR253TjYyMmFLMG1SOWRRVUNzTGR0R3JF?=
 =?utf-8?B?d1hYdHo4ZnZlQlBYZCtsSDRnWkdKNmp2bllKSjRsSEszbjJzQXFiSTFKMmJn?=
 =?utf-8?B?Y3hrVC9jbWVtY0Nib1RkYTdWb1ljVDBJRFpoYWc5UDM0UUxRNkI2azVmL3ZL?=
 =?utf-8?B?b0RGY0xQVHVYOFNIVTByQ1J2ejk2UTY0WTRVSFg4d0tuS3FhZi9kSFh2OHdo?=
 =?utf-8?B?cVVuOGEvTDZ1c096bksvUVVrbE9JSlBBZGVORjI1OTF6ZitLT1RvbTFLNjBj?=
 =?utf-8?B?WEpTYkd2ZU1UanlITFQwMm51cEh6RHAvS1lEUW9PYWxLNHFzQ1ZSMHhDSnRO?=
 =?utf-8?B?TUFBTzZnRU9OWG1mNXZxZHhLQWhJdHk3TUhaMzd2cDFmUkZPKzJPMEZ5dkxk?=
 =?utf-8?B?WTVTY3g4Skx3ajhwbG16dTNzNkZDWWh5SHhoSmZSK29IcEVudHNOcTZvVW4y?=
 =?utf-8?B?cHo5a2EzMEZHT1lkTnJYcGpZSFFvYzhRdTZIdzY5STNDQXluaXlidGQ4akoy?=
 =?utf-8?B?V2wzVkpldnJLa3lFeDMzZ0J5amttT1M0WWp1UExqaWF1Q244cnpRUTRYSWlr?=
 =?utf-8?B?RHkvUW4xemVoOWF3U09nYmdMR0JaQUNrWnlScTIxcTdoSVNXUzM2cTAzd0dR?=
 =?utf-8?B?eDJiL1RDTENPTmd4c3YxbHVXWlRJTnI2cFhuL3I1d2NGdnprQ1RlQi82b2R3?=
 =?utf-8?B?MGplOTFWKzNZa3dHS1BFUElkbkRDWTRvVHRlTk9SZ2ZuQWNodU5oM0xCN1lK?=
 =?utf-8?B?bjF0STFCODlZQkdpTlNmSUhxOUpSZGZHekV6Yk5LaGkvUjRBQUtFNDBoQW10?=
 =?utf-8?B?YXVYLy9DT2VlR3M1TEZ1QnpKN09xcnhVOTNhK2ZBQ3FiaFNTU1I5YXZaN1cr?=
 =?utf-8?B?dUdCUjc5N1J2SDVPN0dnRWRablhKTEJqOURweU1GY2dJRzUrc0M4RUEwTk9I?=
 =?utf-8?B?UFB5T1NBeUFNeFFiRW9UMU0wNGMvMkFYVXphQnROVER5SWl1N2w5RC9pbkpT?=
 =?utf-8?B?dzc2eExOMUZRclVnaTZCMUdNOFNRZzZtcHk3eVlST0ZOcStmSHYxM2kyZHlx?=
 =?utf-8?B?bWMxU1hFZFhpd21yS0tRaEJieHFINnpaU2szdXVLSnhocndJRVUrUExqNkp0?=
 =?utf-8?B?SERPcGZxZE9mRDBVUDRLLzJHV1hQNkt0bEluZ2orREt0NmdlVDFhZ0VXbGhU?=
 =?utf-8?B?NE1qZ3BVSGNFTllnc0FGYkpjdnJBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cc8067-5080-46aa-81c3-08dd7c0afac7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 10:47:55.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVSaVIGipWzcQJcAzRApl4iIqVcAS7RFF+1KYV99MAUs1G3G1ApEmjNAdKdxCXqjfSZN7J87BQjqIQEeFo1S861+HZrEErCRsBW996k/jiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9362

Hi Denis,

On 4/14/25 18:42, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 4/10/25 10:58 AM, Jussi Laakkonen wrote:
>> ---
>>   src/ipconfig.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/ipconfig.c b/src/ipconfig.c
>> index c2d7d2bc..ce4bbc27 100644
>> --- a/src/ipconfig.c
>> +++ b/src/ipconfig.c
>> @@ -3,6 +3,7 @@
>>    *  Connection Manager
>>    *
>>    *  Copyright (C) 2007-2013  Intel Corporation. All rights reserved.
>> + *  Copyright (C) 2025  Jolla Mobile Ltd
>>    *
>>    *  This program is free software; you can redistribute it and/or 
>> modify
>>    *  it under the terms of the GNU General Public License version 2 as
>> @@ -325,8 +326,10 @@ static int read_conf_value(const char *prefix, 
>> const char *ifname,
>>       // null-terminated variable argument component list.
>>
>>       path = g_build_filename(prefix, ifname ? ifname : "all", suffix, 
>> NULL);
>> -    if (!path)
>> +    if (!path) {
>> +        *value = -ENOMEM;
>>           return -ENOMEM;
>> +    }
> 
> Looking at g_build_filename, pretty sure it also never fails.  It is 
> customary to not-side effect any inout arguments if the function returns 
> an error, so setting *value here is probably incorrect?

Now that I rethink of this, yes, I guess another trap of 
paranoid-Clang-analyzer. This can be skipped.

> 
>>
>>       errno = 0; /* Avoid stale errno values with fopen */
>>       f = fopen(path, "r");
>> @@ -337,7 +340,7 @@ static int read_conf_value(const char *prefix, 
>> const char *ifname,
>>
>>           err = fscanf(f, "%d", value);
>>           if (err <= 0 && errno)
>> -            err = -errno;
>> +            *value = err = -errno;
> 
> As above.

Yes. I agree.


> 
>>
>>           fclose(f);
>>       }
>> -- 
>> 2.39.5
>>
>>
> 
- Jussi
