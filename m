Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2128.outbound.protection.outlook.com [40.107.20.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147619F487
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923137; cv=fail; b=nk3owLFjP8On2lVpliA+SKq7LBjgtx/y/20WaFU45UHpcFLuFVoKEZm6Wygr2mB4t5J83xBgQ1mJeEuqhnjKXCIYjxnzgiOovNTZ2lx7PV0Cer3SQhSSzmBTV3pyFsec+YWCz05Q3Dg5lBdcqQ4+1u2csK7l76LiFlnDQW9jH+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923137; c=relaxed/simple;
	bh=xCptuq6efi3gqbwOM0gJnLtM2aQNQ4rRRKj1wJDltwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BwRYVF8bk7UnIhucbJJzmIkWwTNWN3vCamgfONUeqF0VedXz6yYQQueUpVgYz/o7hNDu3EJvlAmbf0n0O+kwGcNsiOJkFRPg3waLWIDHrn44aaE6qYonDEs2fuHIq70XvUXrSl8lqMCXyUGSdTDGNnwJb1Gf3YiKtHtnsmT3ups=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=kd7dxo/N; arc=fail smtp.client-ip=40.107.20.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="kd7dxo/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Weu3OgBVKs5ESCv4veAQjxiJaIc2L7VMANRj1vCZSfQBzOgtuvSN+bUvYivmvRCBJPTSbB72/zw6n/6GAyIxJO4XalrSfgXooN6U0kMsFCK7yhrg//LFLC3gewalKU3iiBOltHLfdzcz73yjKB2EjzUJ3tzAU5uCgQvJVdpuZ5UlDhYG6ukbef00c8WywWDW1NJ1N6dLjeiRyDvnHaovfZwUKlQQxpzSTgWvz1VUNyUeX+da16E4Wm6rZXywysxag2E8qLOAz6TrBSE14pg5Td4vIsv2t6k2njn3cHit733Eo2DKp8M6aKVQZJJsT1E7mGM8/zzSPvMC+iKGRnNjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrXSqW3MC+CVVxMlmg2GQIpeCUSfbmTqMcdHh+WZbEQ=;
 b=prsyPaW/RVVblSjlQ7hYVsAU9sEAmlYJ3YD/Qfh0RyQkQlOK1GuX/5uzIXTJx2JGECkQEi+bclHnD9K1v/HdGx71DzXmxOYanPDWFERSA+JNaEKRbLXg9ETAkw4OQcRQ5iDH14t64hO3NDY2FchsN9Cg59+i2BvO3GAYacxi+bTjWgLPjBFBfwo405wYgHeuGnWy+KsLgqfGtxeDK3Dj1o2lBEUlrH7BPhVeSMThaOd9MF6ifeVb6nkOzn/Ipg8Fuehonrw/dxNvv2yktren5MZhEtkMKURVSIPML7IHc0AtM9tuue7ES6xHPWrE8sNEWyyGvAsKVzQ0oHCdxF+BUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrXSqW3MC+CVVxMlmg2GQIpeCUSfbmTqMcdHh+WZbEQ=;
 b=kd7dxo/NbNtQAuQAJGh9NZdQjFB4h37PQtF8Ps0NNBRwvjT1whr/TLLZoYICSui3AqZx81NaI0tldvwdMYTuBYafGmdXQma6avq0RNuiWIzfsVKwnIJUx9ki+WIw0t37kuDI+X17yl8mIB93qODcLQEChHbr2bR/ipVUT2ypn+Zm7KcF6w8awuOJkApSy1TSvOtnFBB1GzZ2IJ3hcGIyeJclJ9WC2pgJrbkNZqlKI/zkHPFo3hPQ3uND0+gywiorY+j4+tzIZmrSDQPqyeHap0vzA+Gfh5bEaeCxXEF+TlQkC2Dud1TpZOxJ0RLYBtoPDnFodZ/zSBhorjiPeO7aSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from PAXPR06MB8376.eurprd06.prod.outlook.com (2603:10a6:102:22a::18)
 by PA2PR06MB9417.eurprd06.prod.outlook.com (2603:10a6:102:402::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:18:52 +0000
Received: from PAXPR06MB8376.eurprd06.prod.outlook.com
 ([fe80::a624:3da2:b1f5:e229]) by PAXPR06MB8376.eurprd06.prod.outlook.com
 ([fe80::a624:3da2:b1f5:e229%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 17:18:51 +0000
Message-ID: <673eaec4-a289-4b97-8572-b1398e8aa869@jolla.com>
Date: Tue, 25 Mar 2025 19:18:49 +0200
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
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <5950C2C2-37F5-440F-9E5F-25CD9D896A7A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF00007A8C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::61c) To PAXPR06MB8376.eurprd06.prod.outlook.com
 (2603:10a6:102:22a::18)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR06MB8376:EE_|PA2PR06MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ec1d16-cc23-4b92-3016-08dd6bc11c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEVkOWFnbHhXY2NFOUF0YW15WWhOajdwY2lsZGFqTS9OYXhtaXBnUnpFenJ6?=
 =?utf-8?B?akU5T1c1a0o2MXVjYXRnZFAra2dORDdoSlBvTnhhemxZb3VuY2w4QzZodXZn?=
 =?utf-8?B?djhLeklqTnhIaVpaM1BpN0tMRi9pajlqK1V4WWpFNHJvL2Z5clYvdGp6OXY4?=
 =?utf-8?B?S0ZJcGFMZ2owclFhbHVUMzczZEJQTGN4dGZZU1hja2c2VG9CY0tnNjljYXNs?=
 =?utf-8?B?WEt0SW91c3ZjMnNXNGs5Y0J6ek9temVCcTlnK2JLVzdESmhNUXZFbFZ0NExG?=
 =?utf-8?B?d25vZHlNdEFrWmFFL0tkVWtGbWIvdWFnOHdUODQyaC9ZcUlTTS9xUkdJUDBQ?=
 =?utf-8?B?K0hlQ1FFOU1OZFVkem9rZkc2VkxkbjdHQmlYREFGM3lkaVhELzdDWnA1Sms2?=
 =?utf-8?B?MmxhRVhSTXN1WGRGR3BsTnVPSzdPTkhMcTRHdXphY1FWRzlpd29kcDVtazcx?=
 =?utf-8?B?L3BNZ1RLWm42N0lBcWYzcStveUNGSEd1R0RwUU5jY2VuUktyQ21qaTVHcEE5?=
 =?utf-8?B?c3VSaE8yYkpVOVhsRXlmVFR3bTk4bWE3NENNYzFUR3NiWkZ6NmdyaGZxanhJ?=
 =?utf-8?B?TGhlbDhvbkRUTXNGVHNxQ2hMZW8zbnliWVBFbCs3c0FPOGZyWndkZktRQkVs?=
 =?utf-8?B?cjFCazJCc21xT1lwZERicXBTRS96R2w2QmptcFdST25hcE10L0c3UmF0eWt3?=
 =?utf-8?B?M0NlT0NyZnFITDV4akdlbmg0dVFHdS9zWmlSRWM5SlpMa05iaEtUOEZjbTNY?=
 =?utf-8?B?TDdPM3NlSi9nd1Jnc0gwci9yelJLNitYeTAxc2FKTm1ESnRpNFZyZ0Z1Uytj?=
 =?utf-8?B?SlpFWnVaaXVoZllWYWhjRlNXNmxXMXdLTGFlcS8vSytyQlJNRWw1eDZubDJB?=
 =?utf-8?B?bFhKWVVSUjdyWVFEZDJ4N09XbUhVb05QZWZHNTIzZHZlVm1LeDMycmI4SXFP?=
 =?utf-8?B?QTllZmJzYzUrUVVsMElNRGdUTFoxSjlHNXFXTml3WjJuY0dSNTRWTFZkZysr?=
 =?utf-8?B?WUhMT0d5Rmk1ZVpNK2tzdjMvVWE3eUp5elk5N1ZTdUMxc0E0UytkRytDZmJl?=
 =?utf-8?B?b05rUk15bit3eTlhTFpkdHprWXRDVUw4ZWs5MHFLK0M4VlQ3d2NBYlphSFhL?=
 =?utf-8?B?cEhITnFYSkgwQzdyWjBoR24wOHdvak9yMmxHNWdaNXZSdmphMVJhTmVzVXVM?=
 =?utf-8?B?c2RrQTc1SkpuL3EwZTArSzNVYmFnbGlBSi9MaTEyRllYMnFSdzNxUWtKUjBO?=
 =?utf-8?B?V0lEVlVFZnArWm1ZRzY0NTM5dlZTcFB3aU1lUHhHQk4yYmxnSnJqQ0pjbnVn?=
 =?utf-8?B?bWFyb0NHQkE3Zmk2NW5FRnRrcEVMVVVRNGdscTcyZkE0YjZCemtpQVNTMGM2?=
 =?utf-8?B?d1BZV2dJeHg4Q3NCN0t1UlE2WkZUL1Q0VjA2Rk1TMGhiY1RJZjgrNzc0RXlh?=
 =?utf-8?B?bVVQaDBwVW1Tb2hZZ21WZWJqU3NLMGV6T05Mcm9DVmhyMlNnRWVBZ3JmMjU0?=
 =?utf-8?B?K2V6ZHduUi9kSFJGZE1uRjFwVGpsSEFGbFE5YkJqTllpUFV3Q3R3UVgyWlFM?=
 =?utf-8?B?QytxQTRRV0NOdE95ZURvUXE0TVNoSHFkT0FkbHYyeVlucVJTNEI4UjVvTFBy?=
 =?utf-8?B?bTJWZWRFblAyb1luelFJTk9sZW9XZElkdWRLSSswcytwN2s5WFNZcUFhMGwx?=
 =?utf-8?B?cFEwRkhOTXVWc0tMdFBQK2NyK2syUW1NV2RUS0F0VWNESnJVcnl4eHJ2Vkxl?=
 =?utf-8?B?NjNBakQ1Q2JZaCtBTEVpYlluSENTckdzK0l5Z1ZVL1VJWEQyZ0lpNENCRlJl?=
 =?utf-8?B?QlZuc2VvcnNiZ1hOeWQvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR06MB8376.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TllPS0tEZERmUk5qVVJlanEyTE00ckFGY0ExVy9uZkN4dFcvZUk0bE5LUzhJ?=
 =?utf-8?B?TXF4cXJ1VER3SE91aE03UmloSVpaV0ZOTERvRSthbEVISE1YNXhlanUvVXdJ?=
 =?utf-8?B?M3pjc3N5MFVQU1AvUUVONFhVTnpCM2VFYVNvN25EN2xWbnQyYUxBSXVnR24x?=
 =?utf-8?B?emxYZWYzYk9WdHo5Q29YRCtjcVJjT1E3T0NrZnN3SHprdzlLWnBSSHhXQi9C?=
 =?utf-8?B?NTcrdE4rNTFQZmlOeVcvRkV6THJPUmhNazJ2SjE1SU1UNkVKcTFkeVZjOGM2?=
 =?utf-8?B?U2h2cUl4U2JPa3k3MVd5QjYzbzdTSjVCWklzZlFrUGwra0tzLzNXMWZwc0Qw?=
 =?utf-8?B?VCs2MThkTWxaQ1BncmEyUTQwRHNrWi9FbWJGVm1uV1VDS2F6c2Rsd0I3akJC?=
 =?utf-8?B?TENQTFBFQm1VcjB6aWhENjJEajRwTVJoNFFUbXFTV1BjUjQ0QnlncVB6N0Vh?=
 =?utf-8?B?dTVKZHQwSE4ySjZSb3c4d291NUY0VytNSWRCaithV2lENEJUTmpPbEtuUTFw?=
 =?utf-8?B?ZzloRE5ySWF1cVB1MVVYSnZsZWlZMkNvS3hsUVNwUXB6WmR4NW1ld3VhS0tZ?=
 =?utf-8?B?R0VwbmYySWFVOFV3ampDcnBjc2F1clRVa2h3VGZqNnR4a0ZtRG9FdVNmMHBy?=
 =?utf-8?B?VzdZMkpuWlNtN29jU0sxbnhQa2FIL0FtcDFJWWJVMWF2a0JGc3d3S1lOajFR?=
 =?utf-8?B?SEFlcURGdGx0bFV2ZXBKMzcwVkZwS1dweFFxMWtmamdhNnhmaDlLM3NlZFBu?=
 =?utf-8?B?OHZsbGZrblhxVVlsY2hObG5CQjBIck5Td3Uvc2t3Q09ZUDFnUlhtdktlam5E?=
 =?utf-8?B?cEQxU0pOdnl2UlF5L0dvb21haTBSVm1FZ0s1WmdjUFZrcWgyQzVPam8wNTJT?=
 =?utf-8?B?QnFuOFNmYmhzQ2pUVC9IL1I3ZUhsWmZMN3ROQ2dqZHZzN0RwejdQZTRhTko2?=
 =?utf-8?B?S09GMU52aStDM0tDTGV4Y3BFVWNubERZakNoYlJtMEVENWxvbk16cUFrcE42?=
 =?utf-8?B?Rm9UKzNrZUpCMG4rcFpVSGUxbEtYbzNFS1FhaFdhOUZ1OFAzaXlTMXBRblVU?=
 =?utf-8?B?a3A1RnFPc2dQNm5qcVBGUm9udlQvalhMMzZRd29STEJWb01SN245SGVBSUpE?=
 =?utf-8?B?aVBUdExHT1hWZ3BZMkNqSDFGM3VTd3lYZlcwMjIwMyszaUdoaWtsVk5sQit4?=
 =?utf-8?B?Q0ZiT0h3NTRKVjVkRTlMY1J4ZXRpdXlWeEkvcmErMzNRQXBlM3RCdFNXVnlZ?=
 =?utf-8?B?NVBLeENkeC9nZnJhcys2Q2FXSGJjSzFZNnpzRGYrVGNuQkNjZFlyekpyUjBF?=
 =?utf-8?B?cU42ME9KOFNKM3FxR0lrQ01vL3dBOE1TdFQrYzVMR2orbDVmMVcxOWE3VjQ5?=
 =?utf-8?B?UndIVlErYU0xWnFzOWVnS3NjSmNuZjdGcGptUjZCSWgzdWVYd0d3TXRnN0R2?=
 =?utf-8?B?ajRYQXZmbUR4cGZoNFB3cDBPa0x1bGJ0QS9iRVlncjF5bFBjdit6TEx1UTZj?=
 =?utf-8?B?T2pGbkN2akZwZHRhU3JJZXFlcHRMUWt0dzNXRmdjL2hxa2h6Y1pLNk5CMm1o?=
 =?utf-8?B?b244V1dLYjVFNnJrbDJ3NEpKSFV3My9ZREZqQjJqVzJRMUpwZVV4bi9uVnhB?=
 =?utf-8?B?dytwV01Dc3F1NVJIZVpod2lkZG9WTWdxOEQrSzRvVHdDQmUzTzRCSDBRNUVE?=
 =?utf-8?B?TjJsVHA2cHlvTGhhNmhMZDVWdjY1dG02SWllSVdBeklPQXZ5b0YzS0RvRXJP?=
 =?utf-8?B?T0xJclQ5dlZ3ZnJlRmpaOVloeFFDM2VrQjc5S2MyMXlMcXU4WHQ5SzY5YVhj?=
 =?utf-8?B?SEl6YW1OK1oyajNOZWh0ZzVhR2lyNWdLM0d5MFh2Q2YrbCt4TXBCYkFnbG5V?=
 =?utf-8?B?cWpsMkM3UEFjS2JFNmZCMyt6bzhKS3dNek03RDZiS2FvSTVRRVVxdHg1TUhk?=
 =?utf-8?B?a3F1Q1hyTnFXQ2NYTXY3NHd6WnJPUjY4S1dhejU2R3Y5cmJDWmg4bFd1dmJB?=
 =?utf-8?B?cUtTWmhpQXUvZ25BOXdUT0thMkNhZng5V3AwVmQ1ODViYXNWWFRpR2pxZzlL?=
 =?utf-8?B?eGdHMHNRbzllZ2Rvc2tBV1lub0ErUWkrYUJ1dHlEVDZHWkFYM3UwdU16bVV6?=
 =?utf-8?B?dkJWd0trN0dvZXZhUnVmMVFYbElwcHhCdVoxOHkycXVYVFVJVTc0NE9mdGZx?=
 =?utf-8?B?TUdmTkYxUkFRSEl2TWxuNEIvc2Q3c3dLSjdKNVRkYUJCVy9TOW9MUTRMc1ZR?=
 =?utf-8?B?QkZiRll2ZFpqMVVzVUUzQ2NJS1NBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ec1d16-cc23-4b92-3016-08dd6bc11c9a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR06MB8376.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 17:18:51.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YClQbeVEcvUQnBxE7FjQMF6FcxEqfBBTY/WZ4q+P1AydHn3r4nbtO4ZkirNygG6WGXF54x3E+HOVeL0rUzjnX++Jo74u+FBam6V3z3+s3S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9417

Hi Christian,

I'm happy to hear this. And very grateful of that publicity and 
possibility to get even more testing on this.

I pushed only one cleanup commit today, as it seems that the route setup 
that is done when endpoint resolves to an different IP should be enough. 
In ideal case the gateway (endpoint IP) changes would be propagated to 
connmand but I need to write another internal task for it and work on it 
later.

But lets see what testing reveals.

- Jussi


On 3/25/25 15:02, Christian Hewitt wrote:
> Hello Jussi,
> 
> The updated branch compiles fine now and I’m able to connect with ‘Host’ configured with an FQDN instead of an IP address, which is awesome to see!
> 
> I’ve posted a thread to our user forum with an experimental image to crowdsource further feedback:
> 
> https://forum.libreelec.tv/thread/29601-wireguard-experimental-support-for-connecting-via-fqdn-not-ip/
> 
> Let’s see what issues come up :)
> 
> Christian
> 
>> On 25 Mar 2025, at 1:58 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>
>> Hi Christian and all,
>>
>> On 3/24/25 21:30, Jussi Laakkonen wrote:
>>> Hi Christian,
>>> On 3/22/25 06:45, Christian Hewitt wrote:
>>>>> On 21 Mar 2025, at 11:31 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>>>>
>>>>> Hi Christian and all,
>>>>>
>>>>>> I’ve been using this series combined with the following series and patch for several weeks:
>>>>>> https://patchwork.kernel.org/project/connman/ cover/20250124185845.1546384-1-jussi.laakkonen@jolla.com/
>>>>>> https://patchwork.kernel.org/project/connman/patch/ DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/
>>>>>> Plus a revert of this commit which I’ve previously flagged as breaking the default “route all traffic down tunnel” with WireGuard (the main use-case for LibreELEC users):
>>>>>> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/? id=9eb1772d31b6fcf78e8711976696491aec9ff5df
>>>>>> For easier testing all patches are in this branch: https:// github.com/chewitt/connman/commits/wireguard
>>>>>> No issues observed, so:
>>>>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>>>
>>>>> I'm happy to hear. I have been fixing other issues related to WG in the past weeks a lot and considering to push all of the changes into one big WG patch set, as this has been left dangling.
>>>>>
>>>>> I haven't fully tested this on top of upstream ConnMan, but if you or someone else is interested to see if the issues that were previously encountering are fixed or not.
>>>>>
>>>>> All changes are available here, on top of latest upstream ConnMan: https://github.com/LaakkonenJussi/connman_upstream/pull/9
>>>>>
>>>>> It is a PR to the internal repository so anyone can comment there too. Decided to put this into public as Mullvad seems to give only IP addresses and cannot really rely on demo.wireguard.com alone on this. So, feel free to test, if it works I'll setup a patch set, maybe combine some of the changes to make fewer patches.
>>>>>
>>>>> Have a nice weekend you all!
>>>>
>>>> Thanks for sharing Jussi. Minor compile error fixed with:
>>>>
>>>> diff --git a/src/shared/util.h b/src/shared/util.h
>>>> index 44e07b84..9af0303d 100644
>>>> --- a/src/shared/util.h
>>>> +++ b/src/shared/util.h
>>>> @@ -25,7 +25,7 @@
>>>>      #include <glib.h>
>>>>    #include <stdbool.h>
>>>> -#include <inet.h>
>>>> +#include <connman/inet.h>
>>>>      #define AF_INET_POS 0
>>>>    #define AF_INET6_POS 1
>>> Oops, thanks for spotting this. I wonder how my build on Debian did not warn about this. I think only <arpa/inet.h> is needed at this point, but that works too. Added a commit to that branch.
>>>>
>>>> An existing WireGuard configuration on the family daily-driver RPi5 running LibreELEC shows no obvious regressions with a private VPN server (not a commercial service). Lots more testing required :)
>>>>
>>>> Christian
>>>>
>>> Glad to hear this. I keep wondering if something is still needed from our fork... as at least with Mullvad WG I got dual IP support working, and data gets routed from both IP families to the host with an IP. But this is a quite a big change, so yes, lost more testing is required and thanks for helping with this.
>>> Few things I want to point out, that now sure yet if it is correct way to do this but the transport services' DNS servers are sent to vpnd from connmand when a VPN reaches ready state. It could be earlier, at configuration state too, any opinnions? This is because then the reresolving of the FQDN hostname seems to start working well.
>>> But, as I now did some more digging I noticed that the FQDN was also propagated "as is" to connmand resulting it ending up in the routing table, which may be cause for this not working in the first place. And I'm talking about DNS reresolve broken in such case as well as the traffic getting blocked. I pushed a WIP change to the PR/branch which I need to continue tomorrow (as we want this to be working in Sailfish OS too) so this can be tested that how it works. The TODO part is about making DNS reresolve to work in the similar way too.
>>> Have fun testing!
>>> Cheers,
>>>   Jussi
>>
>>
>> Forgot to push the commits there late at night, now they're available and will update today as well.
>>
>> - Jussi
> 

