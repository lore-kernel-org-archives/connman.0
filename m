Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023107.outbound.protection.outlook.com [40.107.162.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532012367B6
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654766; cv=fail; b=ZuJB1UBGKtUkUrt98AyFW/v0N9E9ZvMnRUVqB/2yrqFFYY3LMHIud3k1C5/U6Vs8bS9AVIhJFY9tgPtWDrYos0cVnW9ypYVMg2v6aKrBl7A405CJUKLP45pGNpZ+MH5NYqiI+PM9C37behYG2Qt1oBMvSnnGkw9zYzvpGBJ3KSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654766; c=relaxed/simple;
	bh=efPF8RXM7xDHJiQs2tcRKhOLvnE1OVp+yageGz57wIY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TsEIsD6NKgpsZo35LHccX5ZCxz2HT9LqNuMcYmydyl+r7Qak49/L14p7dHtG9CD4NP0DFAyAT1VJrS9BkBiKmXQS2XBrJH6syklWXqFsMBL6TZ01ljSq/PQIPSH5BjgeNPpHgbnp+yID3s0bMZUjbE/twKtqfOgZAziuKj8Jy4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=XXq/eDbY; arc=fail smtp.client-ip=40.107.162.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="XXq/eDbY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSXOdWYP8EdPeX2w5rcU2IotukULoS3GP6vNZRqPkF5SFDMLnTLxQnhyEGgRRlpP4gzNgOKSJVwgqOvqSdKCYHJWaB3B84ytcMGA0zgGJG7d7Zadrebxw6rDyvtPrmTKAjZ66VZMlV4rn29A23HGrRJtHLu+5SJDYmXeH+As0JDShrddzWvAJV+MH4ZplkEed/+e2DLuPswBdLnYikdDwEkwY4e4xX0ogZ+jkfBB8SoMwxKbA4/qaYnAsKJkYFgwtB9EaAYvpSgv3kmgJjlbuENdixZLna0bLVF5e9Y2wD9ZpOwPwfzmyLOv705g1i98cMzy5Vsk0KSEbcZCVruXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePBFPWNZP4Tb0Uu40j82BgQy2saFQ6R3E7CwvoFGOhk=;
 b=ha2cNTvSMw/7xnsQXhK2IJw94G4tCD17o0K7Z4rawtwc1bjDeTwZAMyaW0Q8NTAfLtihJidE35ngmdW7+vrNCZ6ecbjasMvT2Cz+zeF6z8mCR9fN3gf1Ky60XVLS6SHP0Hqbge7WtJuDG8/DgnFjCStP0BCobmcb7uguZw2/T7Qnn/adT4DTAS2T0lbDyczhAZY1/gUcKodDzFw2j6opDFBKI7Xzka/eQrATcW5nhtwoTf4xwquPlraAF1MO1deB7jN23M9VlYPABzEG+lBriOSW0lRDba7wVqnbfMfQo5zrMmLWb32+1xgafh0BaSwLdBPmQktgBlHC1jFKUvHQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePBFPWNZP4Tb0Uu40j82BgQy2saFQ6R3E7CwvoFGOhk=;
 b=XXq/eDbYHzjnR6RiwRiUZ/ySbct8gWIWf/32Iox6rX9y/xIwCKFjlaHVlGuh4xFVCrPk8/w2j6aJKAXgIS2Sd4OlJBfYKfTtp1kXAoTVZPTmXtHFSKxAfY52WybGuS8iTX9WOn6+WGiI7BcAdVdsnRMBxH+BlIXBTVDWe9uCOz9r8jHmW/A8cXqWpNYLbOlAtTyG43+hZXJM2GrC7oDf+lnMpDb+YsA0wE3jL1f/lPE+s4Z8RzVNEP3QfcgNXpBZVtjrEa3pwpaaavnhWIPn1IWYjjbPjiDhHpD2togmwue6eIS9Bz956WzGKq2YtyDLsT2uGaffUIbnE7HrJqjtqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PA2PR06MB9616.eurprd06.prod.outlook.com (2603:10a6:102:41c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 12:05:59 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 12:05:58 +0000
Message-ID: <463ce86f-be52-47af-891f-745402387c29@jolla.com>
Date: Fri, 8 Aug 2025 15:05:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/45] service: Explicit VPN connect timeout, ignore in
 VPN agent wait
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-6-jussi.laakkonen@jolla.com>
 <06df3300-c462-4294-85f6-b90315ef012b@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <06df3300-c462-4294-85f6-b90315ef012b@gmail.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PA2PR06MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: c135a99d-1522-4b1f-c131-08ddd673ef59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTAxSk5ZVE82NTl3ckNBZG9uZkx4dGhXaVFRU0I2RlNkbmJnc0VaRnYvTXB3?=
 =?utf-8?B?L1hMRkxOQ0djMzQzWEdma0xJMjl4cklURWlJaE5DRzFBSFlBU0htT0J5VFpr?=
 =?utf-8?B?dWl2blRsVVhCWStNbzA0OVhtTWkvdHJZdUhkQTRkVG5PY1VYWXdLZDlCY3I4?=
 =?utf-8?B?T0pVTlhwUDJablBmSFoxdEl4TUJqRjJSQVcyelIwQkZmMnJCTGJzMnpJT3ls?=
 =?utf-8?B?c3d0OXB6Z0szenlUR0FQcXg1OTFMbFNjUUxnTkpOMldNZW5CSDJFamNGcHdi?=
 =?utf-8?B?Y3RKZnAwcVV2OTVKSmhGdGdpYUlOWFFuWTYwZElzeHUrRWR1ajNTSzA4NVVw?=
 =?utf-8?B?Ri9iRmZuaDlHRFM0OERlNzBndlBQdW0zb2tCRnhrb3V6VEpwK0pnUUxrWVky?=
 =?utf-8?B?SWNlMnRqaXVoL1MyeUNvVGdUNDJuVEY4SU1WcmFwRS80bkQ2YXJNV05SZko2?=
 =?utf-8?B?VFFpbSt2Y0FKMFJwRmxCbkxuMGtVTXArQ3ZtY2h4RTVrbWw3eTJ1MmJHOTlz?=
 =?utf-8?B?VTFSZjBPYnZ4NU9KNU1kcUNwWEFDZ05nMkdrUkdHUjFoRVdaVkFSUXd6UnZ1?=
 =?utf-8?B?L0ZNWGFkVkg4dXVtcFFTTzNZZFNiVWgveHFwcTNQSTZQS2xaM1dTL011R2VR?=
 =?utf-8?B?MXUxN3NXMXJ1bzA4Q3NHNml1cERPeitiUzNYS0ZjNnZCbG16ZU1SUUVSU3NF?=
 =?utf-8?B?emo1czVicm1Mc0tncWlXS2pSMllkRWJ0NWlzOExhRklXL1dPckdid201cXdX?=
 =?utf-8?B?Z2hFcEZnbE82Q1c4NEdjUGR4VS9JWElqbG9GRHlUT3dBWkFVT3FqbVFNYmpJ?=
 =?utf-8?B?TWs3NkxEQUVqdnRmQTdnZUR3ZUE0WUcyN1pmZVdMeWNMREVQSzUreDhIQTVJ?=
 =?utf-8?B?d2FKRlp2d3ZZUGtNcml0Skw1cXdLbVEyN2l6UWJGOTJZMGVzM0J6OGU3cDMw?=
 =?utf-8?B?ZWQ5QUNhZWtnTDAxU3BWOG1HclgyREtOZHNCV25LU2dLR2lyRXdZRzdYcC8y?=
 =?utf-8?B?anFMTXdqbVVSbDFSU1MwK1A2VTNreVBmRE5PSWF3Q3I1eGxEQ3FOUnkyQUtC?=
 =?utf-8?B?RnhEWmsrMFFJUCtybXk5VkNvdnJhVTJiWXdBVEVnSlZxcHMzemhsTlRmOWI0?=
 =?utf-8?B?NGhGbGZJMzJpWms1bmRnRkFSSXphSUs4SVA4NjBKS0lERDU2SDg0VG9Td2ht?=
 =?utf-8?B?a0t4a2RxKzdLY1BQKzh3d2l1MU13V0orT2RkNitUanpFZmNrbWd6SVVocjhM?=
 =?utf-8?B?QnAyaFFNUXRzSVBlWnRXRlZUVU1Xb01CSGtEYURucnN3TjBWN0JSTWNsSWpT?=
 =?utf-8?B?NjE3TG5ObFdRR1ZTVWVvSjZ6Q1ZBR1dYYnd2MGVWWjZFS2FLMDVaV21sV01o?=
 =?utf-8?B?K3cxVDJ6cGI1VGlzcUl6ZW1jUjRWbHd6emZobFplRTdzMnVBWldxZVBZTURI?=
 =?utf-8?B?NFRSQ04wWTJCZm81K3lmU0t6VVZFVXI3cW1ESU5qOWxMNFQ3dDh0QjlwQWc1?=
 =?utf-8?B?cEhYcnpQNGxPMC96cWx1RUZiYkRnU2Q1TlppMGJjU0RZdVlnNktLZFhaRWZh?=
 =?utf-8?B?WDlOZkI3cVArK2FCZU5DeGVrRVVZeldsNEwzdGd5L0hrdWtndEFIODlXRGdK?=
 =?utf-8?B?M0hCMXdJTEIrdFpNV1ZjekwrYlJITjhZQmc5R1l2SURsSEpLU2hueDBaakVT?=
 =?utf-8?B?MThqZnBCZjliREZBV1NCQW9vOWRXMk5GRzlwQ3VMaUhOUjR0RXVnVndCOHFt?=
 =?utf-8?B?czV1VFJiWVR0amVqRmIrV1ZzcWVZSnQvWHNwcGgxMTNseUlkRnB2WXVqamlG?=
 =?utf-8?B?TmpvTXJpUWZDZ3lkNWFVSjRDQlFqRDlRYSs2ajFZcXhvNVJNTmp5aTlSRW4v?=
 =?utf-8?B?ZGdjVjAyUjBCWlY3bnlmQmpWVWJycW5nblFjRmhHSkFybStvK1FqbnhxWDVq?=
 =?utf-8?Q?bU2YNTsC5TQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OStrb1E5SzM0WVpyUXdEc3BCNERVazRta1NaNElwTllvV0IwMzQ3K290VjRP?=
 =?utf-8?B?T1FJSVFuSk13SGRheDFxKzBJRWNBcEQ4Yk93Zm15QzIwN2pialBnSzJ6cEZV?=
 =?utf-8?B?Sk5RVEJ0YWgvdE9kT2RjQ0xMYzM1Ly90SmV2Vm94ZGZaMnhPSE9MYW0zVHU4?=
 =?utf-8?B?ZGhvZmRNRTZydUp1Zk9lZlF1eGpBc2dBQ3RybjlPV20xY3VWTThxbE96bXdy?=
 =?utf-8?B?U25IR21tYythQmhWa2dPYmFjVVlRMDZvRHVtcnhFUlcxUjRwTEQ1NmlkaDZi?=
 =?utf-8?B?eU9JeEJ6clJOQjN0Vmo3dHZwenpCMFZZRWVsc0Y2ZHBRMGl2Qy9XT1Q3VFUy?=
 =?utf-8?B?bEd0UUI1dXR1YzY4RUoxZ2tjMjNMOWgrUUNwNlBOQ09wTnVRaFNXQk1ndnJK?=
 =?utf-8?B?amE3d3lLUzNPRHRyZ2hOMGh1NnpJbUtCK2tTTm9zZjdaaHdQSHlycXMrWE5r?=
 =?utf-8?B?SDl4UXBjUjlLT1hnRzJyNkZvZkQyQi8ya3BpNFoxY2MvdGo2QkxqT1lZa1lO?=
 =?utf-8?B?dTZJeFVKUGpwcnNFL0xWTkkrWTNVL3lZbUhNZ0RTZVFScjVDYzJnb0lIcUdv?=
 =?utf-8?B?U2xna3FUOHJhejRTZFNLVHdCQjZBSjU3QWlaQ2V4RXN6d0NhaE93emNpVE5D?=
 =?utf-8?B?c290UmhyN04vQTJnSDFMOHFxK2ljWXFVYmhRM1dyaEUwNkFVQXR2Y3NFOEdC?=
 =?utf-8?B?dmR3cVhBTzlyVVNMMDdlYXR1aDNHbVpuOEIvNTc5QndzUzdPUFZnOTI0RWdI?=
 =?utf-8?B?U1A3cWNyMlZNV0FHSnZ1QlUyTjRKazlxZ2ZoMVY2Yzh5S3lsTWhSU2lESTdR?=
 =?utf-8?B?VFdjUHJqWkROSjZQL1VtOGxhRWU5SzVvdjM5QkpQMUt6dDdpSVFDQmFDbFFv?=
 =?utf-8?B?OHpLWnVWRDBERXUveHpCY3pIdEVIeDhwRm4yalZzbHVQVHFZVm0ybWRSbWo3?=
 =?utf-8?B?bEhWY2V1Z01TcU81MVBOeitlWk9TY01uR2hVN2VUWGxWZEQyZERkcDgzanhO?=
 =?utf-8?B?L0EzUCtIT0tieXRraTdTUVZKK2dFQmdGdGdqVCsxUDhMa1hjRXI4UTZzYUVq?=
 =?utf-8?B?NDYvdDgySytxWkR6Z2tQYzI0QzZvRHk4K0phVFBiYllmNi8wbjJDMGZjVktj?=
 =?utf-8?B?OTZiVExpTUR6cXVHYStFbCtCR3dXanJtTEVNUWIwMHg1ZTkxdklLdmpWMHBB?=
 =?utf-8?B?QVN3T3orUk8xZ1hUb1Zoc3dBQTd5L2hIRVlkUmRKTWVoN0RYdHo0bzVFRDYr?=
 =?utf-8?B?N05uZUVPRkN2eFI3VVg0cjBIYUM4OWpmK1VPRkFybExLby9CcVU2U1RxaSt1?=
 =?utf-8?B?NjhGRmRQOEszQlBDZk80VjUvcXpuWHJOWjJneG1zcjhaSmxndTZSd2MzTWYr?=
 =?utf-8?B?K0x0clFZdUM5TXRjWWJNY3NWemFYQkFzKzV4aHhGOXprQzRTdStpTDc1dHFm?=
 =?utf-8?B?dk50UzBPNGVaVlhOclVGeHZ4KzRFYXZzQ09pYkluOXNwMlZOU2dSL3UvN3gy?=
 =?utf-8?B?RFFwRjcyR3N1cXhoSWFycDFXR2d5ajFTZTRUS1lMckJpV2dRY1h0bWNvNUFL?=
 =?utf-8?B?OERZMUY2eUlZZGd3V2RGa0tMRFlPbU9uRTd6R3k3eE1ReGdHRUdrMWxMWTUz?=
 =?utf-8?B?MmpyVjJDemxaT0dyVzdOSDA1Ykd1ZU1YMGVOQWxQOUdJSDUrR1NFUlQ5c2pz?=
 =?utf-8?B?Zi83aTNWWjIwVVBWN0FwcWxRN1hIYnVzUWtEZlgvSDJGZUI4OGZYd1d1UUxE?=
 =?utf-8?B?WENoeHNzWUpYVDFnejRGMVdnWW04elRoaGRScEwwd01nT2I2dXpuZ0ZzYkxp?=
 =?utf-8?B?TWpjUm50S3Y2cXI4Vnh0T3NPdE1rTG1ZMXJseG1hK2phK1g1Q2FxdTlPbm9m?=
 =?utf-8?B?VFRrR0ZpV3hBc2d2OVY5czN2U2lTV1hKS0ZxNjJrN0plUTJhaW51aDJwYnBq?=
 =?utf-8?B?c3o0MmZ2dWUzZlhDOFZwbXBwVDBubVVGYVppdkRKeGJXQjZGRGR4ZkRtdVZI?=
 =?utf-8?B?YnU3c01zSXpQanZMWkpQeU5EczRFdjcyQVJWbUJsRHhWQ0M4d0VIYzg4QUdx?=
 =?utf-8?B?N25sVHlDcDgrNmtsZ1NFR2p3Zy9Qd2g2MkFJRjhIZnE0WHVqbDhoVkFNWkE2?=
 =?utf-8?B?MGVkRi92Qk5NdWo5M1RQZEhEQW5XWGVqbE5nN2JmemtNS3F4a3NTR0dZYVhS?=
 =?utf-8?B?WnNQbGlScG9NOFpHa0Q4bnEvN0lJVzdCbVJ4NFJaUHFzQVhtTjh6K2lnWUM5?=
 =?utf-8?B?bVNZaHZEVUdSbFFuOTFtREN1UFNRPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c135a99d-1522-4b1f-c131-08ddd673ef59
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:05:58.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91sbFecueCGc4AXy/96YWOlvqc3Oyq4lJ8h+d25Buv9YFP3lOqoFHGf48vatGTNV6dhS/NuH4TLeRbU5POZFnNjEw3PEzlnxdf3A1vkD6MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9616

Hi Denis,

I'll try to remember this from 3 years back when this was done.

On 8/1/25 22:31, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 7/11/25 9:26 AM, Jussi Laakkonen wrote:
>> Ignore the connect timeout autostarting when connecting a VPN service
>> because initially the VPN is in association state in which the VPN is
>> waiting for the VPN agent. Separate the starting of connect timeout into
>> its own function __connman_service_start_connect_timeout() so provider.c
>> can call it when it enters configuration state.
>>
>> When a VPN is waiting for user input it should not be affected by
>> connect timeout as the connection is not yet attempted. This may happen
>> if VPN resumes to association state when requiring the VPN agent for
>> other, e.g., encrypted private key input after credential input.
>> ---
>>   src/connman.h |  2 ++
>>   src/service.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 49 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/connman.h b/src/connman.h
>> index 7ebda7af..1a8952e4 100644
>> --- a/src/connman.h
>> +++ b/src/connman.h
>> @@ -788,6 +788,8 @@ int __connman_service_connect(struct 
>> connman_service *service,
>>   int __connman_service_disconnect(struct connman_service *service);
>>   void __connman_service_set_active_session(bool enable, GSList *list);
>>   void __connman_service_auto_connect(enum 
>> connman_service_connect_reason reason);
>> +void __connman_service_start_connect_timeout(struct connman_service 
>> *service,
>> +                bool restart);
>>   bool __connman_service_remove(struct connman_service *service);
>>   void __connman_service_set_hidden_data(struct connman_service *service,
>>                   gpointer user_data);
>> diff --git a/src/service.c b/src/service.c
>> index f73f42eb..9fd8fdb1 100644
>> --- a/src/service.c
>> +++ b/src/service.c
>> @@ -7322,8 +7322,27 @@ static gboolean connect_timeout(gpointer 
>> user_data)
>>       if (service->network)
>>           __connman_network_disconnect(service->network);
>> -    else if (service->provider)
>> +    else if (service->provider) {
>> +        /*
>> +         * Remove timeout when the VPN is waiting for user input in
>> +         * association state. By default the VPN agent timeout is
>> +         * 300s whereas default connection timeout is 120s. Provider
>> +         * will start connect timeout for the service when it enters
>> +         * configuration state.
>> +         */
>> +        const char *statestr = connman_provider_get_string(
>> +                    service->provider, "State");
>> +        if (!g_strcmp0(statestr, "association")) {
>> +            DBG("VPN provider %p is waiting for VPN agent, "
>> +                        "stop connect timeout",
>> +                        service->provider);
>> +            return G_SOURCE_REMOVE;
>> +        }
>> +
> 
> I'm a bit confused why this entire block is needed?  If the service is a 
> VPN, then the timeout isn't even started, and thus connect_timeout() 
> shouldn't even be called?

Yes and the point of this was to extend that the provider.c can initiate 
the timeout for the VPNs as well to behave similarly to other services. 
So In ASSOCIATION state there is the 300 timeout for inputting 
credentials etc. which is then followed by the 120 timeout for 
connecting in CONFIGURATION state.

I think this was done because the agent needed a bit longer timeout than 
the connection timeout is for the user to input the credentials and it 
seemed to obey the 120 timeout instead, so the aim was to make VPNs to 
have same states as any other service, to synchronize the behavior.

> 
>>           connman_provider_disconnect(service->provider);
>> +    }
>> +
>> +
>>       __connman_stats_service_unregister(service);
>> @@ -7351,7 +7370,27 @@ static gboolean connect_timeout(gpointer 
>> user_data)
>>                   CONNMAN_SERVICE_CONNECT_REASON_USER)
>>           do_auto_connect(service, CONNMAN_SERVICE_CONNECT_REASON_AUTO);
>> -    return FALSE;
>> +    return G_SOURCE_REMOVE;
>> +}
>> +
>> +void __connman_service_start_connect_timeout(struct connman_service 
>> *service,
>> +                                bool restart)
>> +{
>> +    DBG("");
>> +
>> +    if (!service)
>> +        return;
>> +
>> +    if (!restart && service->timeout)
>> +        return;
>> +
>> +    if (restart && service->timeout) {
>> +        DBG("cancel running connect timeout");
>> +        g_source_remove(service->timeout);
>> +    }
>> +
>> +    service->timeout = g_timeout_add_seconds(CONNECT_TIMEOUT,
>> +                connect_timeout, service);
>>   }
> 
> Given the above, I question the need for this function?

This is needed for keeping the behavior of services in sync, not to 
separate VPNs.

> 
>>   static DBusMessage *connect_service(DBusConnection *conn,
>> @@ -9975,9 +10014,12 @@ int __connman_service_connect(struct 
>> connman_service *service,
>>           return 0;
>>       if (err == -EINPROGRESS) {
>> -        if (service->timeout == 0)
>> -            service->timeout = g_timeout_add_seconds(
>> -                CONNECT_TIMEOUT, connect_timeout, service);
>> +        /*
>> +         * VPN will start connect timeout when it enters CONFIGURATION
>> +         * state.
>> +         */
>> +        if (service->type != CONNMAN_SERVICE_TYPE_VPN)
>> +            __connman_service_start_connect_timeout(service, false);
>>           return -EINPROGRESS;
>>       }
> 
> Regards,
> -Denis

BR,
  Jussi
