Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023131.outbound.protection.outlook.com [40.107.159.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36828DB7B
	for <connman@lists.linux.dev>; Wed,  9 Jul 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057710; cv=fail; b=rtmArBc6xcO1i3775Ga6L3d+mjkyZdOMZBirWLH5ysmC6s/NnrTl4lNKK2/qtvz7IDHlkAxDAWnVZc3gIkzHwc9D3LOBibuGLoe2oKYUz9CWcwmj0wR/2fOcbzO42OKx/1lCqXeXKcJxSZSvN2n/4wVAJkoHp8gVFqUsSPZkdpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057710; c=relaxed/simple;
	bh=/zASTtDICtn3hIPECrC0vGcfj+eiAOMAD1jAhVuE/4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R45z0DduE8s5Q98q50B74ZVCcaMoyw/hezc+pFpVRE/jj3+PVsl3t/VliS4zrxBVka9Fzp6iNGwOEbXC4dyxjkmfRVfzbi1/ekJEXZoJYc/uaNHOatlHkra1ADUF0iBwns3qKZapg0/vi9X0unjBfAmHw9d7Qdm3H91dSGoWo4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=oJBV5axz; arc=fail smtp.client-ip=40.107.159.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="oJBV5axz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXF3ajctWvMm59Pp9hOG1pObhP28p/jctbtldC29TE+VKe8K9VMcExKKNyw2XHRPGQ2VEkMHGk2rjBDOKHHPQXkxX8HP/bUHY2b2uxam1LQG4Xm+odIuNgclrjzjRhH79ANFAAZJS9yfMTB6kNwcyfgWVowy6+TD2nKZPGkc3IsU+mTIcBZ70tWwHHU5atTBq9wT7rK46bku7OlN5T00SBjAKVIiRAYu3XWBmeV0jWWI5jsyCCMjncn6kT+mRv3QfXJpe/bul01GVoV6nfBMDKFx24VuoS3Tdh4RTD88S8GioRQFaCSvtXnV9MWELImps0sEcLWM2UzQO3Gek/IoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LXoL80lkc9OMR/oFdwtGao3ox8H3UxpxGwHn1olGek=;
 b=yEz+5Ex+AfPn6ZGSL5BokD0MhaKzgzprtJX4gUt+jdPAnaGa/Bn9RKXfoX9qc1Rl6VfqnEadIs5NPnRKU1tcAKMfgbpDZAJNFmy/46+BNJ8V6odTgXj6Vur4vBO5PP3biAXDjiqaeXcd5obwzYrCTx0DClGhW5qTtGLMOjZwQpjGmueNLUz2ixmJd3IKjMQVG6ccCetdNmh5GvL7kfksdn/vea0oRqmk8i7ylNu2ZDX19i/pqQIJ3/wTtOWTNZzVp95ARkKGn86dJas6RwuzDDJ99836EeALnUeknZEPrORHDoaXq9AlTTTIaQNv76PEP0+Ck5Hbwb+8gFJALTq/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LXoL80lkc9OMR/oFdwtGao3ox8H3UxpxGwHn1olGek=;
 b=oJBV5axz2deggHQV7k4ez6G7tDu/MXO9uLZeeZbdciHktj09sqDn+AnwBZQ0wrktAVW7dq3mOkD148pG+i44JojB12nLXcnLqj1qn3GRum4vLLO/iYYolUSOCs3+FBQm5vN1M7DeNyzFEWWz47vUXC91E9omIJ2yJqh3DJyKpCionGxK6Jtlo/TKJhq4xRFzVJdqdl+rkb1n3nVLiV6/AZfiqqpprZdNcloDqBznC23YAGAd+4qC5wjsGwAwsDPMQIRCbdXDD4qOLE9pS1gJUCulvgZNgfR54qUbbPLtdCyy5fJp+VFmKpji5XG1qTp4Yu0fxoEXAdl6YRS/WcquVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by AM9PR06MB7171.eurprd06.prod.outlook.com (2603:10a6:20b:2c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 10:41:44 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:41:44 +0000
Message-ID: <40677814-1c1d-492a-8bd8-3edc0014bfa4@jolla.com>
Date: Wed, 9 Jul 2025 13:41:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Improve WireGuard disconnect, error and hostname
 lookup
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: connman@lists.linux.dev
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
 <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
 <3438fe24-9c02-4c45-aaaf-cfbe260902b1@jolla.com>
 <E23C544B-4E82-49A6-B72E-2279D1BAFC67@gmail.com>
 <c6ae8a9c-df3f-4170-951b-a8a049bf9676@jolla.com>
 <07d1c218-be94-4b63-bb98-f57679844148@jolla.com>
 <5950C2C2-37F5-440F-9E5F-25CD9D896A7A@gmail.com>
 <673eaec4-a289-4b97-8572-b1398e8aa869@jolla.com>
 <7c6dddcc-6b90-4df1-a9a2-cabd2483f728@jolla.com>
 <303D17B9-998B-4487-8CCD-24A3F0A10B1C@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <303D17B9-998B-4487-8CCD-24A3F0A10B1C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00014AED.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::31c) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|AM9PR06MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fda9a1-3644-47f7-b714-08ddbed5325e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekNyS3BIb2tHYTRMTksrdVJRdUMvdmFlSDJVcjNzRTlWbzJyUHdSTDNDNDBC?=
 =?utf-8?B?Z1pZNVFwOHR3TEZ1RTNWRkZzbXJKSTkycFhqbzdoWmdlTEZoOVUwdlF4bHlj?=
 =?utf-8?B?NFcydks1NjJINmVnOWZvNFBJcVlINWMralpxdzBveTZzNCtJTGQvUU5PeGcv?=
 =?utf-8?B?b2VGZVVqc29MMmxpbnRoQitOTkI3R043QWF3NXhJcUphb3FYVlY2L3dZY3kz?=
 =?utf-8?B?VkpEOFpYVWdUM0NXY3Rma2JlODFEdnRjNUF5cjB3RUtoMXpWakY5OFh2Rmw3?=
 =?utf-8?B?Wk1kSit6Y3FSb3VPU0FhOGxMU09kekxSaW14T2FTYWhDTGdVdlF3akM0TjdU?=
 =?utf-8?B?enhaYWppY01EaWRIQ3NaNTVVT2V0MFlwTzdRNlpuVUJ4WkR6T04xVEE5T3Yy?=
 =?utf-8?B?TmNZYVd4WmlXTnhGQVBqSnl3OVVFTldhWWJ5bG9vM3FTSUIvQ001SmJjWkRz?=
 =?utf-8?B?ZU9oanZydXRoclZIcjZjSmZ5VzBCR1JxODJYbklyakZ2ZG1nZDF2S0FCQVly?=
 =?utf-8?B?L2RIS0JrMmt5NDRiTC92QTRVVW1lTmM4VFkrOGJoZjVpYjdzcDF3ckxkbzht?=
 =?utf-8?B?RXhlaldwZStSd05UWENobnBOZzVVUWRkMWZia3E0cHp5MTdpOFV1a1hidTNR?=
 =?utf-8?B?aWRrZ01sdmYwckZqdkJndy9NTEMrK2pJcU41WUlqN2JTUjR3THFmRElQZkNS?=
 =?utf-8?B?NytEN25BMG5QaDZhWnZFK1E1ZWZRUVNSdWNPZDhHd1k4ODhJM2hrWTBTOXJ4?=
 =?utf-8?B?eHRGSmZmaWhDcmpNaVdSS1N5MEc1cE9lZHozdzJJVEdCdnpHMzNWblRpdWRu?=
 =?utf-8?B?SmNIUXRvRk9jV21LNXZOUkpTRzl3NDZlVDhOOUF4bFBmai90enU0Y1dmQjRl?=
 =?utf-8?B?cmNUQ2prWTQrZnJoQkR3cXA2MGgxWmpIQlQ5VHhpWk40dUF3Z043SVF4WjlX?=
 =?utf-8?B?aEFUWGRKQm9OaERHV0pxSDBOTGd4bmZwUWxwNGJkY1ZRRlIwcmQ4c3IvSlZk?=
 =?utf-8?B?WDY1MEptUzFXU3h4QUtrYlJ1VkcrUWhqMFFsSWxmTlFUQTRBQmdESjFLQjI4?=
 =?utf-8?B?eURRRWF4Q0dIR3ZkaU82QU9sS2dVcWJIdXNUVG5yMGp4SmhvT3B0Qy9wWmhK?=
 =?utf-8?B?aTIzT016UWRWZ0RWR1JKQTc4ZmZuWU5oU2xaVmtZdUpCZ1VzRk5LLzlhRzJs?=
 =?utf-8?B?cU12OEpWTm1ISTV3ck1nTW5ZczdtNnZzLzU1WlJzNWNHWkJJc3JOb3lFZTFK?=
 =?utf-8?B?Smh1cS81MERGWm4wSlJJeW5vRitHZEUxWDBkeXBYZnY3SWNic0cyVGNlSkJt?=
 =?utf-8?B?VEh6bkJYSzFaZUF6ZURUTEFkc1piRzJKbDR3THd6a0RId2plYkcySDhSTVFX?=
 =?utf-8?B?MFZyTmpWLy9wKzdhVmFnaW9IMzd0NkZHS1daWnl2L0dPUVV2d3BsTHlrMlVT?=
 =?utf-8?B?blhIY3JIaHMwdWFNTGp0cXZvYTJNNDFjTVVpWUdYbGQxVUhldHhIU2l0OTFL?=
 =?utf-8?B?WDQ5d0RYMmptUnB6dUtJTmtNQjIzMitCRUJMamJScDJNOWNCV001T0lIMXJM?=
 =?utf-8?B?MDlPUXM2S2dJS1p6WWhnUXVDUkkrRklqdXZlZmFkREY5TTlENXkxS3hyeEtF?=
 =?utf-8?B?b05YOVRmNnJaOUxHa2ZCQzJQQ3VRcFhuZU00QkEyKzlNaTlLeURBc0FJbGcz?=
 =?utf-8?B?c2JQWTJVZVRzOEh2TXVZWElhSHBRK3lsaGVDdFQ5UXROVmkrM05CcDlBaEhz?=
 =?utf-8?B?ZExJekdYZmkwTnk0MjVYalNLVDcrM3NYbkRJN2lyckNiS0I3b0RHL1Njd3V0?=
 =?utf-8?Q?8DG0L/X9QY56dcilMtAE+x/Z4CdwAAAVX3L3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlEyTmw3cXEzL0p3dEhjMTJTc1NzM240aXZpK2k0ZVhNVlM5cENhMi9FY1hG?=
 =?utf-8?B?YlFxVFJXZ2NuRE44VTFBRVFjbVdxcmlRdWZoRElXQjJDcDZSZFNMeXNBWXRq?=
 =?utf-8?B?bDFDUmFPZGljV3N1aUxUY2JxRGdOaThpa3dtaVlmODNka1BuZTZMTmdLZzF0?=
 =?utf-8?B?Mk5FYVZONUpINjdKOEpDa2d5cjlBbXZBamxjN3Vsd0NmVDhzRTVtblRzYlkr?=
 =?utf-8?B?TVhuNkZ2V1F3bmpxYkxHYXBOS3V1ZllTdWgrbW9PWWthR2g1b0F1VVhWMURY?=
 =?utf-8?B?ZGhQUGhFanMrOHNDbldZaXhTaDgxRnVCV3pTNnBJWVN5eFl2V29LVEZXR1Jl?=
 =?utf-8?B?ZzVUYXAvdEE5aU8zeGlIMnl6RVFGT1BVRzBpSXdTa0hMOTdkbEFZNkx1SW5N?=
 =?utf-8?B?RzlyM3d3NkxTQS82VmNlaFFhNE1ZVmswREJmeGZ4STJXRFh0d3BZcC9VbVVq?=
 =?utf-8?B?N2tYU3laNGlMWlZ0WHhhcW8vSlVaOWFLdW52L2hhNGFITDV4TklLRDB4Z200?=
 =?utf-8?B?aSs5Wlh4T1NubVNaNEwxaUtWYTRvSWRVSHVoV3IyaXdvcTJad3pQMm4zQWIy?=
 =?utf-8?B?WkNWVlNvZ3B3eVAyT1VlUkc3cFUvb2hwYmZhN2tQMmNrRjlrTG8wUHhlMm96?=
 =?utf-8?B?OWl0cXlhRm1KdU55QjZ3eDdDRlRWaWhJc2NFN210OElWZ0dXVEhrMmNVOSs0?=
 =?utf-8?B?ekJYd3lzTENVeTl4YjE0YXpnK2t6alVCZHhtZWlFWFZTQWxKb2N4VkFudStW?=
 =?utf-8?B?cFB1dWlOQW55d1gvWndXbGI3dDFpVkxOWG9PRzFWSVF5SzVHUUh4bXVxU3BT?=
 =?utf-8?B?K3o3dlVNS256UllDQzVRT3JJV01ZTmVoZjl0dlI2NWdkdXFNWHlLRnp0N0hv?=
 =?utf-8?B?THdBU1pTVi9Ib0UwVWFCdkQwelhoS0pQU2pCaGRqTVJLS1lEcWI2eGQxeGlN?=
 =?utf-8?B?SmNBbjQ0ZVBsenh4MG5pT1hhcER5LzU4VTBYRjgvbDFOS3M4c3RudFU0QVh3?=
 =?utf-8?B?RGZvOXZKL3RyN05naXgxLytFdmJwcUl2eldFNkdyQjRETkZDMHpMUUhoQTFu?=
 =?utf-8?B?K1c0WmZvZmM5TzZqbWY2enFSelJQS0pKckNTYUdYdGRVRmZYYms4MHdXUzJP?=
 =?utf-8?B?dEk4TkF1UzNHUWZDT0lxd2w2UlN4VGE3VEQyYmlqZ0NOOGkvdG1oejJkQ2FS?=
 =?utf-8?B?TGF4TnFWcm1aQnY4NmlUYitrQzA2MGtVUWM1N0VyakFOVzBZYVltd1IvOW5J?=
 =?utf-8?B?Rlp1SnMyWXpGU3M1eWRpaXRSQXNDT094ZE5tL0pVZFVXSDFFREc5djJHNncw?=
 =?utf-8?B?ZGFHTmhQQ0RhdmN5bStPVE81LzdWdG9RMEtDbEFjZUlhU0tTTjAyUFJRZzUv?=
 =?utf-8?B?akhXdzZQaXFURytYSjlvMklPYWJNMElNNWJuYks0cnRWSFhMZUxQV095ajJh?=
 =?utf-8?B?cThleHBNYklYdjRUMkd0OVNJT1VVYTR4Yk0vQnVya24zUFZMWDdXdjBzb0xp?=
 =?utf-8?B?Nk9wK2p1djZ5ZjEwRU1KZVhHUXR3dGx0ZHlWTXlUNklpYTRXbGxoK3dxc1R3?=
 =?utf-8?B?YndTK3BwZFlJOGZvdDJkVjV1cDVBNGJ2bVE0bE9VZkp5dkRsNkxYbjdCZ0Fi?=
 =?utf-8?B?SUx3dVhid1lXK1pNZmpKZDRMZ0ptdTRaSkdpSzh5bE1vbk9HMFVNeGVLekgy?=
 =?utf-8?B?eXJsRk5TY1ArNGtKeUxDNy82UHlyK0R2TkJVdHMrWUVsL1pwSm9RdUthUWRz?=
 =?utf-8?B?VCtRdkRQV0E2SG0vd09LWFFmVFJUQmpzeWJ6Qmo5UnFKck1yRnhUL0lFRmZ5?=
 =?utf-8?B?NnFiRFZoL1dYVEc0Z1p3aFhSbHNMRXlYQVV6c0tjcHBJbmNsMzlpNEF3VkhC?=
 =?utf-8?B?VHZFbGw3bHcrRStzMkp3RlN5SitNSmd4TXVBcWZqRk0yTWdFVFkxZzZPTEhJ?=
 =?utf-8?B?ZkE4WXVEclcrenZWYkY2SkQ3V0tpSjJkS1NmNUZFcW5qUEN5bVkwY01OY0dM?=
 =?utf-8?B?dWRDNGtQWm1IT2pwbXJlNWh2YStTcTV5QVNxN3dvR2h3RHg1Y2ZBNTNWeXVH?=
 =?utf-8?B?OTFOQzg5MG1NeWFRUHJNVFRuTWIvUW96dDVZcXpWdURWVXpkd1IyL1RETmti?=
 =?utf-8?B?dzFHMDhHNzQ1d2ZQcWozaTJ1ak9OSGxtdlcxaTdTcFdTQlRTZUNYMm4ybHZ6?=
 =?utf-8?B?Tit1UW84S0hCbjNrU2RVUjN2R1RPT0xmNTFJZzhkZTVWRXlKYS9UODRUM3RJ?=
 =?utf-8?B?RStHS3Y2NTJ3cFo1RkZDa2R2bWlBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fda9a1-3644-47f7-b714-08ddbed5325e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:41:44.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1ZeaBdT5KQkmYpx72eN5GGuXn0qB5seTj2tGTJuEZbHmlcQUQEdyavokoc13ss0iIPhPQL45COFCZtrfsyTFxHwg9AyVrdwh8aM9wsYPPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7171

Hi Christian!

No worries, it happens.

That sounds really good. I think I can make a combined big patch set of 
the VPN association changes and WireGuard changes for maintainers to 
review based on this feedback, or the lack of negative feedback ;).

I'll keep that config option name them, and include in the updated patch 
set.


Cheers,
  Jussi


On 7/8/25 14:37, Christian Hewitt wrote:
> Hello Jussi,
> 
> I’ve been submerged in some work activities and replying dropped off my radar. Apologies.
> 
> The “wireguard_and_vpn_association” patchset (with reverts) has been used in the dev/test images that I share for a while now and so far there are no negative user reports, so all seems fine. LE users generally have the rather simple use-case of making a connection to home (on a dynamic IP) so it’s not advanced configuration.
> 
> The re-resolve option name is long but I’m not able to come up with anything better/shorter :)
> 
> Christian
> 
>> On 10 Apr 2025, at 4:26 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>
>> Hi Christian and others,
>>
>> I noticed that the testing thread has been quite silent for a while. So I've done some internal testing here, and made changes to the git repo
>> https://github.com/LaakkonenJussi/connman_upstream/commits/wireguard_and_vpn_association/ - mostly reverts, as in my tests it seemed to be enough to fix the FQDN -> IP use in routing. But can you, and others, tell if this works for you too? I'm trying to minimize the changes.
>>
>> But on the other hand I thought also that the feature to use the transport service's DNSs for the DNS reresolve in WireGuard might be something someone would want to enable for their WireGuard. Like in a scenario where the user has no power to change anything on the server side if the resolving of the server's IP is not possible via WireGuard connection due to broken DNS configuration on the server. And if this would be a good idea to have as an option for WireGuard, I'm taking in suggestions on option name, "ReresolveUseTransportDNS" is, well, long.
>>
>> But let me know if the version with reverts works. Easy to return to the later version if this change causes any regressions.
>>
>> Cheers,
>> Jussi
>>
>>
>>
>> On 3/25/25 19:18, Jussi Laakkonen wrote:
>>> Hi Christian,
>>> I'm happy to hear this. And very grateful of that publicity and possibility to get even more testing on this.
>>> I pushed only one cleanup commit today, as it seems that the route setup that is done when endpoint resolves to an different IP should be enough. In ideal case the gateway (endpoint IP) changes would be propagated to connmand but I need to write another internal task for it and work on it later.
>>> But lets see what testing reveals.
>>> - Jussi
>>> On 3/25/25 15:02, Christian Hewitt wrote:
>>>> Hello Jussi,
>>>>
>>>> The updated branch compiles fine now and I’m able to connect with ‘Host’ configured with an FQDN instead of an IP address, which is awesome to see!
>>>>
>>>> I’ve posted a thread to our user forum with an experimental image to crowdsource further feedback:
>>>>
>>>> https://forum.libreelec.tv/thread/29601-wireguard-experimental- support-for-connecting-via-fqdn-not-ip/
>>>>
>>>> Let’s see what issues come up :)
>>>>
>>>> Christian
>>>>
>>>>> On 25 Mar 2025, at 1:58 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>>>>
>>>>> Hi Christian and all,
>>>>>
>>>>> On 3/24/25 21:30, Jussi Laakkonen wrote:
>>>>>> Hi Christian,
>>>>>> On 3/22/25 06:45, Christian Hewitt wrote:
>>>>>>>> On 21 Mar 2025, at 11:31 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>>>>>>>
>>>>>>>> Hi Christian and all,
>>>>>>>>
>>>>>>>>> I’ve been using this series combined with the following series and patch for several weeks:
>>>>>>>>> https://patchwork.kernel.org/project/connman/ cover/20250124185845.1546384-1-jussi.laakkonen@jolla.com/
>>>>>>>>> https://patchwork.kernel.org/project/connman/patch/ DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/
>>>>>>>>> Plus a revert of this commit which I’ve previously flagged as breaking the default “route all traffic down tunnel” with WireGuard (the main use-case for LibreELEC users):
>>>>>>>>> https://git.kernel.org/pub/scm/network/connman/connman.git/ commit/? id=9eb1772d31b6fcf78e8711976696491aec9ff5df
>>>>>>>>> For easier testing all patches are in this branch: https:// github.com/chewitt/connman/commits/wireguard
>>>>>>>>> No issues observed, so:
>>>>>>>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>>>>>>
>>>>>>>> I'm happy to hear. I have been fixing other issues related to WG in the past weeks a lot and considering to push all of the changes into one big WG patch set, as this has been left dangling.
>>>>>>>>
>>>>>>>> I haven't fully tested this on top of upstream ConnMan, but if you or someone else is interested to see if the issues that were previously encountering are fixed or not.
>>>>>>>>
>>>>>>>> All changes are available here, on top of latest upstream ConnMan: https://github.com/LaakkonenJussi/connman_upstream/pull/9
>>>>>>>>
>>>>>>>> It is a PR to the internal repository so anyone can comment there too. Decided to put this into public as Mullvad seems to give only IP addresses and cannot really rely on demo.wireguard.com alone on this. So, feel free to test, if it works I'll setup a patch set, maybe combine some of the changes to make fewer patches.
>>>>>>>>
>>>>>>>> Have a nice weekend you all!
>>>>>>>
>>>>>>> Thanks for sharing Jussi. Minor compile error fixed with:
>>>>>>>
>>>>>>> diff --git a/src/shared/util.h b/src/shared/util.h
>>>>>>> index 44e07b84..9af0303d 100644
>>>>>>> --- a/src/shared/util.h
>>>>>>> +++ b/src/shared/util.h
>>>>>>> @@ -25,7 +25,7 @@
>>>>>>>       #include <glib.h>
>>>>>>>     #include <stdbool.h>
>>>>>>> -#include <inet.h>
>>>>>>> +#include <connman/inet.h>
>>>>>>>       #define AF_INET_POS 0
>>>>>>>     #define AF_INET6_POS 1
>>>>>> Oops, thanks for spotting this. I wonder how my build on Debian did not warn about this. I think only <arpa/inet.h> is needed at this point, but that works too. Added a commit to that branch.
>>>>>>>
>>>>>>> An existing WireGuard configuration on the family daily-driver RPi5 running LibreELEC shows no obvious regressions with a private VPN server (not a commercial service). Lots more testing required :)
>>>>>>>
>>>>>>> Christian
>>>>>>>
>>>>>> Glad to hear this. I keep wondering if something is still needed from our fork... as at least with Mullvad WG I got dual IP support working, and data gets routed from both IP families to the host with an IP. But this is a quite a big change, so yes, lost more testing is required and thanks for helping with this.
>>>>>> Few things I want to point out, that now sure yet if it is correct way to do this but the transport services' DNS servers are sent to vpnd from connmand when a VPN reaches ready state. It could be earlier, at configuration state too, any opinnions? This is because then the reresolving of the FQDN hostname seems to start working well.
>>>>>> But, as I now did some more digging I noticed that the FQDN was also propagated "as is" to connmand resulting it ending up in the routing table, which may be cause for this not working in the first place. And I'm talking about DNS reresolve broken in such case as well as the traffic getting blocked. I pushed a WIP change to the PR/branch which I need to continue tomorrow (as we want this to be working in Sailfish OS too) so this can be tested that how it works. The TODO part is about making DNS reresolve to work in the similar way too.
>>>>>> Have fun testing!
>>>>>> Cheers,
>>>>>>    Jussi
>>>>>
>>>>>
>>>>> Forgot to push the commits there late at night, now they're available and will update today as well.
>>>>>
>>>>> - Jussi
>>>>
>>
> 

