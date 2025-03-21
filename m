Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2099.outbound.protection.outlook.com [40.107.22.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780022E412
	for <connman@lists.linux.dev>; Fri, 21 Mar 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585512; cv=fail; b=k6HG8QSTvA76918IaAhcZEyd2YCej5Zd8Q90pMi6laoTBFgkX/CN1/9BMtBB5fVV5+KscN3iHmvbcTe4GQ28GtkPng+hSewQRnldHO2sg9Z7Qhp7eylnLCUU9ob8vnX+RWjb6B2uPJKGd+jpaU0OkpT4nOaYbL0mOvjDeY3o6tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585512; c=relaxed/simple;
	bh=zi8jYLSx79tvK/x3voWmG71LK3vqls7KqLnC8hsx2A8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fce7P0Q5zcFzywF6gegd+T5I1VGznYis2OG4EXrlPh0Ej2zbL9mHeGwTNkA3LKahN/YeUK2bo/ifjslVKRAsBtsapP3YBMdRqZw6RQKuZKPFuDVRDhC0AcqUGKIqZYxGoaTYcQSPFefiki8lV8/7bCy0ENnBMK84/EfktT1BSzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=vGi7T1ng; arc=fail smtp.client-ip=40.107.22.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="vGi7T1ng"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtxjKNFnbeKRUXeuQ/wEwcAegypyVzgRlqrx9ktRdLmn7Bo4hbts7XUZ4mTG8KyGbdq8qVOkQzctE69lb3+eRpBgte8qddRIZqGbffaWz4GmKmRCSREQXG2vQZLwhltQTYvnKCVle3OgTT32iWj1igRWoMIep2PwEDBWsi6y2UPsdSVxwUMShtNIJeXCuf17HllMc9NJWVlDKzBvwR3tZ7j3BvKdZdAGIdhxMv7gBNi4/IwTRAQ5orCCnGyawl/1iXUla0BawbYk8Raft6W+Yy/WoRn7vE+BbsF26DTCT3UoqcEfTalYv1rUOQ/rkZ/OAkwt2gXqnRMmebwAZe304g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tDHi/zKNTS1quxawrsZHKs0uoQD7oPZyXz5J5eAByo=;
 b=lV6NeNJ+wC8sDD1zbZvZr+Cj6Ir74ztR1CPiZGKdUprMMu7qt1Sf/RZs/EmpmrQJiSsneQKDcXEkXdqjbAw+Kff3WGRnNhUIeAJdTLMjOpv3ofKKZLhLkVVHZbAjNmhQXXz1c5kHmXFOKPsMuU2pnEvbD9oNUSPUAVcyGcCJloc2FayF8qeN7nhvPbpH27pgCzhyzbg54YxXPgMw8JmK88rAh+hnLGPKKXtNYqNNLLlJSLoAI1rMB6rTgdQP2CmYLyrgrV3bw59q3GfngIjrboijqFCXPDX832nzNnslXZ9Qyj8+MQ8QbHjr1GIjDFn7mzdq9mHHHwirjr+nj747Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tDHi/zKNTS1quxawrsZHKs0uoQD7oPZyXz5J5eAByo=;
 b=vGi7T1ngH8t5Qw3fnkcHIZNCtBGH3bh6otLxnUG8DmQtBuRt4Bpf4Liy60bTEInvmuDsoF0jbaNYpiizI1BZmgqTMsRIqiSw66xL0nwFMDgAFDDb4uPhIOjplr6zC8IRgx0MpdyPqIuUdmW+ThX8cu7phsDwuYJP5T6MY900zAfbQHK/DNIj9whCJxovjD9EXpEm9ehmjz+FDCmW9k0cmdoB4EbG5Io694JQdGHITkZ/l9MgqDJcidafiFVmrSy7G50d0rv9tpQxgtCqUJbNGwo98xistsV89Crzo4LJjcbWHnVA0T8QSS07N5tLJRAzdNrl5AW0IyxISYS4A439nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from PAXPR06MB8376.eurprd06.prod.outlook.com (2603:10a6:102:22a::18)
 by DB8PR06MB6409.eurprd06.prod.outlook.com (2603:10a6:10:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 19:31:47 +0000
Received: from PAXPR06MB8376.eurprd06.prod.outlook.com
 ([fe80::a624:3da2:b1f5:e229]) by PAXPR06MB8376.eurprd06.prod.outlook.com
 ([fe80::a624:3da2:b1f5:e229%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 19:31:46 +0000
Message-ID: <3438fe24-9c02-4c45-aaaf-cfbe260902b1@jolla.com>
Date: Fri, 21 Mar 2025 21:31:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Improve WireGuard disconnect, error and hostname
 lookup
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: connman@lists.linux.dev
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
 <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0093.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::7) To PAXPR06MB8376.eurprd06.prod.outlook.com
 (2603:10a6:102:22a::18)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR06MB8376:EE_|DB8PR06MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd3569a-15be-438f-a31a-08dd68af04dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3M1S2tZdWVSRXRDUzNudVhGUUhGaEJGOENLd0FyQjZIOS9aaVlUYmpiRjNN?=
 =?utf-8?B?cENISWt3NzIxOG42OW01bHFxNGt4L1JEeUlJS3F0aklaRUFXMjNsYzRMcGNI?=
 =?utf-8?B?bk1JeThmeFAxSGl4RURWQytHbmZERjV2Z1VWcm1jcXJ0elNtZHdxV1JaVUlG?=
 =?utf-8?B?d1RjWURaZGdGOGZCVjYvYWZVSER1NE5qUXJ0NDRyUERkTHRtUXpldXRFMzRr?=
 =?utf-8?B?K3pqQTkzQkgzNUhnR0tjMkgzeUtzSE9CVnoxK0I3Z3dkY1hrS2Y3REhQRGxD?=
 =?utf-8?B?WFNqdVNQeTBsVFd6TkswVnh4WXZjUW9ROUdaNWEveWFFUFNxcjlMM2lnNFZt?=
 =?utf-8?B?MWhHYjJWem1tUUFlMk41WFlCcUJFeDRyMzFLbzFOUDBCNUFRT1VJSXRxNGNH?=
 =?utf-8?B?dGVWRmphbHkvRFM5TGpEaWRPUlVxbWtXNDJtalhHMXJ4ZEZaZmtRc0xIVW1n?=
 =?utf-8?B?eUNXY0M3bkFhaVZldTRyWU1tdklCdW43ZjlzYlAyRWwrVkpSRmFtQlg5ZkNV?=
 =?utf-8?B?SW1rMGo1eEJOL2tKS0FiVk5QS2JtRVl0TWZKSFFZS0JlWitaK1N1cC9nWmtH?=
 =?utf-8?B?NEFJL3ArRXp6bHlqbUxhTzh5anlUL2xkN21QakpMZFpxdGJranNJK3ZkVU44?=
 =?utf-8?B?SzNKdmdCQWNlRUs0MHEwRFFpZUZFT0tQVWhOcmY0NE5vRElJUzlUNnZlVmtw?=
 =?utf-8?B?M3NwYlhuMXJrVWRKTkFIa2xLcXl1bkQyZ0RmNkZUZXRKU2NwNC8zb25SS2F1?=
 =?utf-8?B?NVFRUTZRSHg1a2VYZFhVTUREK21RWUE2WlN0dHNDeEV2dnZ4YXNJdHJtcHNt?=
 =?utf-8?B?aFpCUzdHUFMvK2J0YS8xbEJaWmhyWmNpQWRPM0xRbVhaMEFObFVXNW1aVXZZ?=
 =?utf-8?B?TW9jY0QzdFRObFo4bVlESWFTYmdXMk9OZGRLUTZUQ0FlSVVZREpaSTRlb3h4?=
 =?utf-8?B?NktGQURyNzdDcFA1OTRCTXZUblNYVHYxbTlLOEJram5lT1BBdW5ISkVEcWlh?=
 =?utf-8?B?RTdlMDMvam9wNnIzdDBqYU1IZG16b2x2QU12cDZuR2I1RnhEeHcxVTRBajZa?=
 =?utf-8?B?SHkxVmJFTXZ6aSt5UkVFR0VKYXFQYjFNUklVVDdOVUthZXhQUmRVc2hXVTM1?=
 =?utf-8?B?R3VxR0tOaURLQThUZytjcXV4QkxjejFXQWJRUE9IUWcxR2E3Qld3MUxjYStN?=
 =?utf-8?B?aWRvVUxlRnRmVTNYRE5MSmhwU1BhVVpVYm5WY1hrQURPYjgwd01GYTFoUjBl?=
 =?utf-8?B?SXBxWUdJdzJYYTdHU0dDWnBlalpIWDVOakhGRUIwblhnTCs4SWZOZTB2d1cr?=
 =?utf-8?B?eTg3djRyNnE1Wnk4eVdsbW40czBGNTkvOHBoWDNkeVJTYlNPYy9kUEFYOW53?=
 =?utf-8?B?QzBNZ21GOFJLWGk2MnBqL3pSVmVrVTVrQzZoNUsvNlJlNTZnVG9pd0pqY09D?=
 =?utf-8?B?dTZlTFRoRjFCOWZpZXk0cHh1YWE2YkhjeVdYR3RHK1FNSmlvRW1oREVXVmpT?=
 =?utf-8?B?VTc0d21kd050cFFUanAvbWVpT3QzUW9GemJGZ0pmTm10TE5uaktnS2VYZEc2?=
 =?utf-8?B?aVJzaUo1L3RNbzlPajJNUEUwL3VJdTIxL1BmUGRibFp3dklNbGV2SzRpZ0tH?=
 =?utf-8?B?L1JmUm1PMk51TEZ2dnFrczczYVhFT0llOC9IMmVCT0tZakNoalpJY0xjeit3?=
 =?utf-8?B?cDZkcXA0MGxXR2FscWwxNTVyYWtMMDVtT2psYmk4TU1FMDhkaHAzMi9RRXl2?=
 =?utf-8?B?K21Hc0E3K3UySkNQSG5mZHdRQWJCM0F4VEtYSTRSdEFUeWljTHdPVmxoVjEw?=
 =?utf-8?B?SkZWNm10U3l0QU5mUXlnV1djNzZmYnk2R2l0YVpQL2hYMzZmbmhHNEdWWUxM?=
 =?utf-8?Q?6yCPqGtTpT5bl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR06MB8376.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUhCVVROK3RZWVRhSmJWRGxrWVNXVENmYlJ2UzZ2ZEdlSjNQb0JXelNOSXNy?=
 =?utf-8?B?MTJneHZnSFF5MFRUNGZ1TFptYlhobVgxQklkYWxwY1ovdkZNNnY0d2I4c3dQ?=
 =?utf-8?B?cTJheGhZNWtBY3pVYXRwZmhsZ01VdnpxWUFwZWNOOGxvMWdNR1VISjJIOEN4?=
 =?utf-8?B?SndLbWozOFZjanczVXBnVnkxaTRzN3dHQldXL2NWN0VwTTJDZjVzVkFBdEc1?=
 =?utf-8?B?ZGFHMjJNWnBsWmdqY21INGRuWGcvaGpKNExzcTdYZzZqdUp0anpnTndWTXNi?=
 =?utf-8?B?RDBZN2dYc1Q4eGllN2RhbTRxYXpBcFI5MjFxU29Ia3ViMEZFK0NJUlMvSFhR?=
 =?utf-8?B?aTVhVHRSdjduV1BiSWlWbmJkays3SXQrNlJ3ZjV1b2R3d2hXMlBGeGZiVTVK?=
 =?utf-8?B?WlpPbVI0bVRad3Nta2FlMmMyNlBCRUZ0OTNjUEFpdklnV3lUalI4NFdoNGM5?=
 =?utf-8?B?TjVsTU1qbGtqMnpvblFhZ3hTQjVESERsVWs2RXJaNWVMYzZoN01BemdZb1ZL?=
 =?utf-8?B?dVBJOUptbThvNjlqRVNVcThiR2NRdkZ5VnorVk52cS9yc1crdk9pdGk4WTUz?=
 =?utf-8?B?UEZZSWhZM2srUkNGWjhTNlY5V05aSHVjSmtjNVN6NXo5S3F3RWNIdEJORFVV?=
 =?utf-8?B?TEx4NTJlNkhDR3JaUkpNUVUxMzFHb2RCcmxJMTdUQ0hJQnY2S2RNYTB5SURy?=
 =?utf-8?B?Q09kTW1iMnRqOXRwa0hxUm1sMFpKd0VPOXRFRzMyNHRMUnVlK0F0Yyt3QjJV?=
 =?utf-8?B?TkpsTVU5SWI4Ky9qSzZhMGVjdUZOSXRNYnRjZ0lMK3JoQkF4c1lIVVZSVSsv?=
 =?utf-8?B?SjlTNEt5azZjNXJVUktJWUIxMGU1M0ZKSmQrRGZzTktiNUx3RFppNTlvTUZF?=
 =?utf-8?B?MVR5SUF0c0dWK3NYcFZ4UlJpU0F3cFZBd3Q0bk5GQWZaWlh0VXR2N3dyNTdi?=
 =?utf-8?B?djVtRy9nMmFURkNlUlB2Y09FQ0dPWm9HQ1Z4V0lrY0Z3UEFGRExhQ283SlA0?=
 =?utf-8?B?QkN0MzV0OHZ4T0loMFpzc0VjL0pTdGZNRUJ5TkUwREN6Z0IwUFBVMWxrOEJY?=
 =?utf-8?B?RGxLWFFiSFN1RWIvWGJYa1gzZUgrZ3BGb0NqMVJ2dUgyRG9ZaWxqdS9raENx?=
 =?utf-8?B?QkhTdG5STzArSVRGZDBtMnNzYTBsRENhT0J4WGl2UVc3UWZPQTJ2SEpBZThQ?=
 =?utf-8?B?aElvMEZEVFdVTi9TVEFiakNrUmRUZ212RXVTU3MvU1BsSHA0cnRtVkJzZ29I?=
 =?utf-8?B?UitGQVZmWXpNR3hzVHliNjRGOVhMcGFxbWFXRE12aHF2dklFVTV5alY3bTht?=
 =?utf-8?B?clJpTW11dW9rVmJCZDRIMHA1Y3lLMktXOWVRUWQ5Yk1lNjZmeWhkOUFXZVFv?=
 =?utf-8?B?ZlNYMVcrTFpUQUJ1Sm5PL3NsUUE5NUQrck9vRnFFMkNGNDFRNGxWekxNTlQ5?=
 =?utf-8?B?YUg3djBCcFM3MWY4ZWJ4STFnbCszbHBqc1lrQyt5MnVTMW56b0labi9wc0Qw?=
 =?utf-8?B?eG5FcGIzeXJlWUdZdnFlMGVuQUhoQ1A1UTZpUUxGT0dkY29JRHRjQTRTYmJZ?=
 =?utf-8?B?allaWFZocFl6V1lFd0VoM1J0dHQwM1hObWN2SGE2RGxUelFSek9lZlNVU3Mv?=
 =?utf-8?B?NGJqejUwQVo0S1E3ZTIrVTBmWTRkSGRsa2NzVERESnhiNVBJRnQwVFAwSzM2?=
 =?utf-8?B?MVJXMEFlWVd5b0k5NmhMdERzRGM1SS9SSjE2dHlTdHlZRzVRdkt4Uk5kSDNI?=
 =?utf-8?B?U2NtZXNLM0tWZzlOUkR4TytjZXBGRE1yaVF0NnhiMTN6VmFGVzVsUmlNZFNl?=
 =?utf-8?B?eFdsV0FHekVsb3VzSHowU2l1czRYaXJMOHRNaFBhbDNEUURrTXlCOWhJRXBB?=
 =?utf-8?B?WGdVdHNvWUh3UzFkdTBwUWJPM0U3MDg1ckhXeDNNaGw3N0loeldUeWJYam10?=
 =?utf-8?B?a2hoM1YvTTNJRldDSGVDUkhOMFc2aTlWOGtFaFZ3anlwM3ZaOTRmajY3cjgr?=
 =?utf-8?B?NDhQYXVRU000dG03OG80SUE1N2xBSkt1VUpHQTNMRHZleVBTTlJtK2cwR2Iz?=
 =?utf-8?B?Z1JQWmJtQ21QN3dQVTAyQnhycXYxZ2pxZ1l4SVhibFljN3dvYjBwWG5rNVEw?=
 =?utf-8?B?cnVDZEpYQy9OSzNNODhaNUlBR2hJVC9UYlI4RkQ1dGpqbFRXdXdNRlE3bFE2?=
 =?utf-8?B?WVNzeVE1dm5ZbHk1eVFTRnZlZmZOb1hvUUo5NW05aTlQV1NvQS9pdlNtMHJu?=
 =?utf-8?B?RlljNmR6eDhOU0tIUllVcElJblBBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd3569a-15be-438f-a31a-08dd68af04dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR06MB8376.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 19:31:46.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqBhRvlFJhUQiP3whp+/lxmyU4JSkiy7YFkj20GPP99c/tl9vmaaDZnbPzMlXhFz3svBM7tv7u2VRTtuRq5re0X9m9zoRfEIlmth81PXK2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6409

Hi Christian and all,

> 
> I’ve been using this series combined with the following series and patch for several weeks:
> 
> https://patchwork.kernel.org/project/connman/cover/20250124185845.1546384-1-jussi.laakkonen@jolla.com/
> https://patchwork.kernel.org/project/connman/patch/DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/
> 
> Plus a revert of this commit which I’ve previously flagged as breaking the default “route all traffic down tunnel” with WireGuard (the main use-case for LibreELEC users):
> 
> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=9eb1772d31b6fcf78e8711976696491aec9ff5df
> 
> For easier testing all patches are in this branch: https://github.com/chewitt/connman/commits/wireguard
> 
> No issues observed, so:
> 
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> 

I'm happy to hear. I have been fixing other issues related to WG in the 
past weeks a lot and considering to push all of the changes into one big 
WG patch set, as this has been left dangling.

I haven't fully tested this on top of upstream ConnMan, but if you or 
someone else is interested to see if the issues that were previously 
encountering are fixed or not.

All changes are available here, on top of latest upstream ConnMan: 
https://github.com/LaakkonenJussi/connman_upstream/pull/9

It is a PR to the internal repository so anyone can comment there too. 
Decided to put this into public as Mullvad seems to give only IP 
addresses and cannot really rely on demo.wireguard.com alone on this. 
So, feel free to test, if it works I'll setup a patch set, maybe combine 
some of the changes to make fewer patches.

Have a nice weekend you all!

Cheers,
  Jussi

