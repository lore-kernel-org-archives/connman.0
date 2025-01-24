Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023088.outbound.protection.outlook.com [40.107.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23321C16B
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721673; cv=fail; b=FKgzYh1Z/KeiTz3vOk1Aj1KeYbRdtJfvIt0YZMAZ85C6QQ/NiteOaLET0pU3B6bAz3YOIjiRL+v++j8zeq8HaZedss2sm+/j5dPpDoeYxggEtgPLfUBwozjANEM5ULhHPwTq+0zBLeBcu6RrLDdlEqlVBQ7mnHDJB8464di0/Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721673; c=relaxed/simple;
	bh=Y/oN2a5b440QXrSO6RfegKbyG1wmAbpNEwiO9rSn7i0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uicEAJ7ISipTS5rj8VdwcvxMeRmDhDeEOSpwl4GB1p2ump4Y5BpYOfBU06h2KCNNRtiLMg1fXn71yu4btwAJlBeg3Fy8TNZ+oXt/qjwkwMMwBZB/ume6weU/SaRDTqS4sfYrm0POU9DykT7BExSL5xtwcuwhzhkZkVAEaZxzbsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=Dy43pYi1; arc=fail smtp.client-ip=40.107.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="Dy43pYi1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdaKh0K7p5/+BEjorwsHnKTECl8HwCYhM4N13pFESq4Iqs631uFJc8I9NCPlVwgV7bUc57eSAsHkhTH6hhcFW8IwmyTz7cESUR0+3NQb3KNDxsuf8BIyWDLyo2h0QI2kFeStbsTGWwa8uZq1i4G74nXlSwlj+pvXCbKzAAhbygz9gvBlZ5sSD8YqQkgw8SbcyyM4Vq0Q4dcEGT9yoOWrmh3c2gF3bHow5lAw4tvpL0DdvFEHn+GFSpM5hSZtRQ0eY4xu+TPqUOnQ+rOpN9eXoH88S8Kv6Eat0Su+YDGDFzcSvp7jAl6DKgVrqAymO3sSIX9i8W6kKn3RqvInQsMPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUOi8uUbQ1w0N0AyEo3tqYggIciaoQwem1BXFPYRBeg=;
 b=dTlDN7SxiIDxQ01Qi4CEcvTQPy2SF1AVlPlzXMl7oPEvMknT+8w5749kT/+3+01lOlz/wEj0tF2iqUTZNssPP1h5s3sWkguIMmK3h8+q8UlwxNCFkZqx2c8obQj6g8Yyye8IMxIZ+UE9K1YX3XxuHt4pB2+DHtmCZ0nAgkjhGpuauHV2aayyBrq3AfEWunyozYx0UeI5HZUOuCbwt6bE5yahBUZUqC4Fc4JLEggV/CHVLhs4wpDKLA2an3RCVGjzrozqq385nDLSRYAiA/IQHqYqNKFYCq2u4TjxfcfGeAJhy6ImyXop1cqV6+yVRkBpQtfXc+wZXJWqv+lxH93bnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUOi8uUbQ1w0N0AyEo3tqYggIciaoQwem1BXFPYRBeg=;
 b=Dy43pYi1+xdaCBmsCtawW1zgRVswp1fhs5wJgYJEebwSkOEIQsYXifF4MCkOUk41s7DYgj3uuVG+YvpAqRoE7ag5D1Hv8muzTqgj0lLNtLtT8BZUxHoRJPHlvJf956VhO1G6EF/MSYC8ZqjkTquulwmbf28dhQhrG3BeS9V/2GFsAinBUjUawxxtLR6avjkXmBPZukiynV16jpliZgNfPU5GjRIVAjuZyP++j64dhY3XhtfjtbHm7WgIS6k3b+67W7LBqL8q5lh8dxZO7XeDNuFxbiNR/wcCOxmKGZwNGIrSMXtNf2RB2Ftb6NS/rrbScZ2Im5jHFuLEptkCckVS9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by VE1PR06MB7134.eurprd06.prod.outlook.com (2603:10a6:800:1a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 12:27:45 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 12:27:45 +0000
Message-ID: <9d647bad-39c1-45d9-adf9-ac17cb166e62@jolla.com>
Date: Fri, 24 Jan 2025 14:27:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: daniel antoine <univac55@gmail.com>,
 Grant Erickson <gerickson@nuovations.com>,
 Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
 <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
 <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
 <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com>
 <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
 <418557AF-4801-44C8-9099-096A0BAD8110@gmail.com>
 <d10885e3-539e-4be1-8c33-c6028d55c7ef@jolla.com>
 <5116CCA9-DA26-4D73-BBA6-C89D58F0B4AC@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <5116CCA9-DA26-4D73-BBA6-C89D58F0B4AC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00014AE0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::313) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|VE1PR06MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7368e0-0822-4461-401c-08dd3c728142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXc3R0d0cXNFNjhUZGdjeTFYcFdSWTNMWVdlYm1tUWxGMGtJdDRVVy8vMGt1?=
 =?utf-8?B?ZVhEVFMzNlUrekJ3UUZkeThLUThxd1lHeDNUUjJwbEZERUJwaVJQcVdUcGZR?=
 =?utf-8?B?cVUrWkZBUXdudEp6WDdjVjdKeHJwMkwvbEZveEk0WFhSMW1mbGlTSW1TendW?=
 =?utf-8?B?RXEyRzNHazB4WGtBcm9rTlFiejN3QXVJRFE5d3oxOHRqa254YzdHRlo1a1B2?=
 =?utf-8?B?L1pOVW14d09BVExMQ2l3cW5CWDNCYytlQU9sRUFEbzhVQzVPSjY1VUsrdGls?=
 =?utf-8?B?U3U1MWxxbHJ5Si9GdVhCNUl0bi9ESEVEUmk1OFZWaWIybUhBTlNnSzBkVHNW?=
 =?utf-8?B?MWhrVW5rbDJGd2pSbGlRSWNHZkkyMmQ1OHd2dEhBaG1YdUVycWZya3ptR1dJ?=
 =?utf-8?B?NkZucDJwRE5ZVkVJcGpsb3Z0bnBPUER0UVFxZmYyeWMvSUFWbHFIOGc1Vi9r?=
 =?utf-8?B?SzRRUEFMdUtZTC9nTEcrMTRqQ1lXYkJCUnUvakNvd1BEYWh5L1o5SUM3bHBT?=
 =?utf-8?B?UmpSOTdqYjZodlAyRTE5aEsxRVphNnc5SWpYWXlTd0dZbDdBclBGTzk0WkNi?=
 =?utf-8?B?WEpWM2kxaFRlZTJjZFlkc0pUUDRNcGRwVUZyOGpXNkhyUXNHRmJtNEl4NkNa?=
 =?utf-8?B?dzFZMHBiRE5GeEhSWkx6QktsV1FDUk1NWDEyUWFzYmJIaGJvK2VndlkvZE5v?=
 =?utf-8?B?ZVpraGFTWkpJdkxjM2NGSGZ0cXFlU2c3UnRZczVmZEIrM3B6bWIxUkF0QU12?=
 =?utf-8?B?dDduL3VJMXk4dHpocVRrL2JieTRYWnJXejVhM1Rsc3MzQStRQ2Q3dUQ2WXJ6?=
 =?utf-8?B?TlFzeEE0VkJMVUpxVk5Td0pGeldJYlEyMHExNnVsT1djT2h5dWoxc2p5T2dI?=
 =?utf-8?B?OWVta2RWYUx5c1J5am5FTWVwT0o2OGI4dHpkUDdwa3NIS2pDNXZRMDFBQ3Fi?=
 =?utf-8?B?b002eW5DaWFXbTFUS3NjWWdwRUcyNVp4dnNIVE9VM085MjRrN2kyeUVVVFJa?=
 =?utf-8?B?UU42SmQ2WThnb2p6cjBRS3RGcmsxNmpiTjIxOWN0bEVYQnJob1VUa3lnckhE?=
 =?utf-8?B?K3VVeC9KSGthM1Z4cmlISmFFNTJCSVlHTE5sWERXWExBc0Yra3pxd1RlVnRq?=
 =?utf-8?B?N2JnQU92MlpxRkt3Ri9CRXA3MnJBTktTQlQzMjIzV0JGMHRvWU5NalhCdGJJ?=
 =?utf-8?B?b3Z6TkZYdHRwcnZENW1CNlZhdy9zcEJCSVQ2ekYzRXNNV2dkWFpTdjFxbEpu?=
 =?utf-8?B?VjZNbGRCV0h6dEZ6VDllRzBmQkNoM1doR1JUL3JReGtTeGNWd0VaV1YwSWtl?=
 =?utf-8?B?N0wzUWRjRDl6eGF0VG0ybWtLQ3ZVeUlBQ0w2WWJiU1h4QkxFNWpKL0l2S21B?=
 =?utf-8?B?TTVsZnF1SXNHVThscE9DVi9kNzV4eldoYW9tOUs2UjNGYWgvV0h2NWpEMGhU?=
 =?utf-8?B?QUp4eDNBa0RVajhseDNiaXlsSXdkVGErdE1QU2N0ZU1VcEk4QUg1YXdvN3h5?=
 =?utf-8?B?SVhBZjljQ3M4S1hxNDVJaG9FWUczRVY1SzNWSGpzVmdaUTBPcktldkRmYXpU?=
 =?utf-8?B?Z1pGb0JVc0RyS0dGdENQek9Cc0N4SlNKNkJGdXpQc1FFeGJMUWJFcTBvWUlz?=
 =?utf-8?B?YVVqeHBDTnBXak5zbnhIODd4T0ZjRTBNNTA5cCtUd3VmZ3RlS2x0dURDdVI4?=
 =?utf-8?B?ZFRkMDlaNFlmdmJNblE5aEZHNStWUm4xUU5ZRjIwU3RtQUpZNzZ2ckRpazlk?=
 =?utf-8?B?NC9TWWFzODgwT1JuQ3dvT29XREVKd05Ib1pudjlJcEgyV2dKVDUwYnQ1VlVj?=
 =?utf-8?B?cENxd0pEN0lxZ1lNVG9sUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJ3V3V2SjB2M0pZNzNpSTNtZzYzUThwVmZ6UXFjM2RJeFVWdEFiaE9IWDRv?=
 =?utf-8?B?N0pwOEVyd29CbmxEUGhRTzhmMTlNMFVYVDlCeER0VWI2S1IvcDV6eDJDUVRR?=
 =?utf-8?B?V1JMbUZnRXhUbTJZR2RtaUdoM09FRGJpM2s0OHpHZlArWVNORnVLd2RvQTFt?=
 =?utf-8?B?eHZSdUVaajhIZ1FkOGNCcTB5dE9QL2V6L25LK2tad29HQWh2SzJpZ1h2RHky?=
 =?utf-8?B?MUtIYXFxK3laNGxuT0pZWTdKNUpQeUE3cFVRNEY0NStUWXR0dkN6cG4rUUx3?=
 =?utf-8?B?bGFrYUJPbEllcTdIbnFKejFxcW40M2c2V2FBTDRoWm1vK2s3bThGRi9KbCt4?=
 =?utf-8?B?Q2hFemsrOElMKzh4YnFucjY1WUpoNi9YVWhsMWthWUdwd0N5WjcxM1ZoWlc2?=
 =?utf-8?B?Wit2L0JrV0pyb3k3R3pBQ0pNU3lzaXlzVWJZYkNzUmpSZEJqd3VnSUNVbThQ?=
 =?utf-8?B?Q1lzSWdoYThUWE4xOFQ2bjVrVjZQcGpseXpIcTkrUU5jVkRBS2tyQ0NpN2FJ?=
 =?utf-8?B?TnhtL0Q3dVp3cmxrNmd1QlZyZVNCUmM4QnJpa2hyTmtSWm9CSTQyQzhic0gy?=
 =?utf-8?B?OXdLVHFQNmdteDl6UFd1RmU1UWxKeTJqRzN1YktPaENiMEFSY1R0eHdvdVBK?=
 =?utf-8?B?VS9CaUoxUGpjbExodlpSSmVIVlZIRkNxZDFqYTVqVkdzaGFULy9paXNtTGlQ?=
 =?utf-8?B?SGVKUlZ3S3dRcEVqMUNEUWlQZWxuWHlXdXhaeElRQkhFMWlLV3R4R2lOUm5t?=
 =?utf-8?B?K2NSVjV0TFRnWGd3cldZdDR4djNJeVVQUUordk05RWV3ZXpYM2ZpbnRqanRJ?=
 =?utf-8?B?WGJnd3NxT1hJVGpweHBUWkNMTDE1S21qNVZCM29xbHdWK21WVW5HZGVJYlhO?=
 =?utf-8?B?czVaQzVhdmd2SWpERkFrQ2JLWlYzb0xKeU9VR2Nmcjhqc2lKaVFrRVJrT2hs?=
 =?utf-8?B?RWRlaEdyMlRXYURmOHpWR2wxTmFHZkQvaFcxUlNnVFNMbzhtQmVvZlpDK1Bp?=
 =?utf-8?B?WUpDUVlkcnY0YUZ3cnNjOStFaHFOWXp3d1FkUkV1cWxNWWwrR0xocUV1K2pi?=
 =?utf-8?B?Qks3eFZ2d1FYNWZMTTJjdS90aVd2OGxxcXp3N3dKRXk1MEhlOFpQeFhUUUpv?=
 =?utf-8?B?RmYvQnNxa0JCWG1JM3hVd2FRU2w4QmV6Q1E0b0xVZjY3dmxLT3hwSzg2eklx?=
 =?utf-8?B?ZlVFOFhpNXBSMUF1TzZNM3NSK0pEVmZJR1VtN1RZQ0pwUG9RcFBrS3l3bXA3?=
 =?utf-8?B?WERNRHRyTUE0aldyelpldXVEeGJRNXRzZEVGS3VkMm02S3hHRTFhUmZxbjBR?=
 =?utf-8?B?S0NSVHJzdXZSRU8rNjZvMnRLWm55cE5qcS9kc3V3NVlvamNIbVpQTDZrM1pu?=
 =?utf-8?B?OFJkK09aL0xINkJEWGs0QmVoWnVyWGxtQk1CK25PUXN6bHd0SXArQjZyZkZm?=
 =?utf-8?B?ZldGQk9vbjlOT2RFWEswMWxKV2RVc1VFRVo3WjdsOWw1cG1lVVNzTzVDcXBZ?=
 =?utf-8?B?cUxBdVE0NGJ5d2xrVFd3c2owRXNhT0lndmtMSTN3RGZVSnNtaE1aQUh6Ujl1?=
 =?utf-8?B?TjVtaXlCUXRoTWRBSEdscktJUHhEQmVsSmdGU2dyQ2tDM3dxUjN6RjFzTjY0?=
 =?utf-8?B?T3lJOEgyaFR5bHpsR005S2dhRTNmYzZmZThJTnhWOU5jUzJVQkJUSWdkQk5F?=
 =?utf-8?B?NlNqS3RiM1NCa2hpaU1qeHZ6a0h2WkE4QU5YUlFjMVZZdVJZZUJoRWNTQmpK?=
 =?utf-8?B?UTAvMFppL2E5c2xud0JEVVE3SGZ4UFUzV2VlTmtKQ3JMbkpzZEx2cVRzaG01?=
 =?utf-8?B?L1h6Y05OeDZnNVlxWndKSTJQLzRxQjcvVmR3dDdEbDVtM3NveDc4LzBWU1Ni?=
 =?utf-8?B?dlo2TmpXQ2NjT0pwekVCN01RZlVzNU42cFVTcXpadG4ybHVYSG15bTJSR05R?=
 =?utf-8?B?N2NjUlJHSmI1b2V0UFFJUjZOR2dGUlEzYUpTdUxuT1ZFc2RZL1QyZFpVWmFv?=
 =?utf-8?B?bHJubXdQR1ZDTW9mWkd3SzFYODBNeXZCaFFwK3ZVS0RjWDhDUUpNd0NHVUpK?=
 =?utf-8?B?bVNndXZWRnkrS3FRaUczbEZhUkIyOUtTODV5WWF5cjBWOUFUUis0dW5RT0o4?=
 =?utf-8?B?bTVEQW9BY0lqT0ZVcnZQTzBQbUtBV0Q1UGdsbERmK1N1ODN6MXRJdVI4bm92?=
 =?utf-8?B?WU1pWEcyeDRKS0dBc1hYNktqV05LWWFCV1lTWFlyYVJCUnUyNHk0Ti9mdWR6?=
 =?utf-8?B?L25Ga0E2K2NORVNsdUlCbjVVOEdnPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7368e0-0822-4461-401c-08dd3c728142
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 12:27:45.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+AW15TGbdpHfQSZb57KLcATBsO+vIr/zcieJj/ZyjXmac8d8rMLSVVNjOf02oOc5e41+ZU3W49sQu5gRyDrLbPLMuQkvoGFnEsdUFwNrdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7134

Hi Christian,

Yes, it will get a bit messy by doing so.

Heh, no need to talk about bribes... unless you have a flux capacitor 
and some glowing fuel for a DeLorean... so it is really a matter of 
time. I'll try to squeeze some time off for doing the patch sets.


- Jussi

On 1/23/25 15:16, Christian Hewitt wrote:
> It’s not impossible, but definitely less convenient. There are some messy script workarounds in our forum and a regular drip-feed of people reporting WireGuard connects but doesn’t work; because they configured Host with an FQDN.
> 
> I’m going to have a play with your fork to see if that meets our needs. If yes, I won’t be switching LibreELEC as we love upstream sources not forks, but I’ll be enquiring how we can bribe you into upstreaming the required changes :)
> 
> Christian
> 
>> On 23 Jan 2025, at 4:08 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>
>> Ok, right. I get your point, if that feature is missing it will be quite impossible to use WG.
>>
>> Our version with the changes does handle that, and also requires CIDR format for IP address, well, check is a bit rudimentary:
>> https://github.com/sailfishos/connman/blob/master/connman/vpn/plugins/wireguard.c#L201 but since all goes through getaddrinfo() checks it should work if DNS is working on the transport medium.
>>
>> - Jussi
>>
>>
>>
>> On 1/23/25 13:49, Christian Hewitt wrote:
>>> Ignore: https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=90592f7a58358a98bde5df6928e2b871041c12bc
>>> So I think this is not the feature I’m thinking of, as it discusses Endpoint re-resolving.
>>> The challenge our users have is ‘Host’ which currently must be an IP address. Upstream WireGuard with wg-quick etc. allows an FQDN. I see users that need to connect to home locations on dynamic IPs where Host will periodically change. I also see users with commercial VPN services which use an FQDN in the (upstream) wireguard configuration format and this resolves to multiple A records (round-robin balancing) and the ‘static’ IPs move around in their ASN range over time in an an attempt to mitigate (poor) IP reputation issues.
>>> Christian
>>>> On 23 Jan 2025, at 3:35 pm, Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>>
>>>> Looking here: https://git.kernel.org/pub/scm/network/connman/connman.git/log/ I’m not finding "wireguard: Regular reresolve endpoint address” and the first page of log goes back to December ’23. Are we using the wrong upstream?
>>>>
>>>> Christian
>>>>
>>>>> On 23 Jan 2025, at 3:22 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>>>>
>>>>> Hi Christian,
>>>>>
>>>>> That is actually in upstream, all the commits regarding WireGuard before July 10, 2024 are taken from the latest upstream and the changes after that are new features.
>>>>>
>>>>> Well, the vpn.c changes do depend on having the ASSOCIATION state also for VPNs to be implemented, that was proposed in the RFC https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 as the state transitions depend on that bit. But it does not seem to be depending on the gateway.c/connection.c. Well, I can try to squeeze time to address the issues Daniel earlier raised on that RFC and push them to upstream, then make a big change on the vpn.c and wireguard.c.
>>>>>
>>>>> Br,
>>>>> Jussi
>>>>>
>>>>>
>>>>> On 1/23/25 13:12, Christian Hewitt wrote:
>>>>>> You don't often get email from christianshewitt@gmail.com. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
>>>>>> Ohh.. I would be VERY keen to see support for FQDN’s resolving to dynamic IP’s upstreamed so this looks interesting:
>>>>>> https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972b866fdbd8bd
>>>>>> Is that feature dependent on any other changes? (being lazy.. I didn’t read all the commits in that branch yet!).
>>>>>> Christian
>>>>>> On 23 Jan 2025, at 3:06 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>>>>> Hello,
>>>>>> Regarding WireGuard, I had to make a bunch of changes to the latest version of it to get it running properly on our fork (yes, we upgrade it slowly, now 1.38): https://github.com/sailfishos/connman/commits/master/connman/vpn
>>>>>> But I haven't had time to figure out all that is needed for upstream to be sent first, like this RFC edit that was forgotten because of... "eastern winds blowing into our direction": https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>>>>>> And then the connection.c was modified a lot (and renamed) and I'm not sure if these will work on top of that anymore. Mostly because we have features that may not have been compatible with latest upstream, like adding a support  for two different devices to be belonging into one service to facilitate CLAT support https://github.com/sailfishos/connman/commits/master/connman/src/connection.c etc. etc. etc.
>>>>>> At some point I'll start pushing changes but not sure when I have time. Mostly they could be RFCs as the changes are big.
>>>>>> BR,
>>>>>> Jussi
>>>>>> On 1/23/25 12:45, daniel antoine wrote:
>>>>>> Hi
>>>>>> I have opened a ticket for connman-vpn not working with wireguard  in
>>>>>> April 2024. If you give me the patches I can test them
>>>>>> Best regards
>>>>>> Daniel
>>>>>> Le mer. 22 janv. 2025 à 18:01, Grant Erickson
>>>>>> <gerickson@nuovations.com> a écrit :
>>>>>> On Jan 13, 2025, at 5:59 AM, Gabriel Sanches <gabriel.sanches@prevas.dk> wrote:
>>>>>> I was testing connman's wireguard plugin and got a segmentation fault.
>>>>>> Looking at the backtrace revealed that there are some typos in the `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 variables instead of ipv6 regarding vpn.
>>>>>> I simply changed them to ipv6 and got it working.
>>>>>> not related to the patch:
>>>>>> I had to manually add ip route so the other devices could be pinged
>>>>>> The plugin adds routes for the WireGuard.DNS configuration setting
>>>>>> # ip route
>>>>>> 1.1.1.1 dev wg0 scope link
>>>>>> 8.8.8.8 dev wg0 scope link
>>>>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>>>>> 10.42.0.1 dev end1 scope link
>>>>>> <vpn host ip> via 10.42.0.1 dev end1
>>>>>> the missing route added manually:
>>>>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>>>>> an equivalent wireguard file adds it properly (using wg-quick)
>>>>>> Is the plugin lacking some implementation?
>>>>>> ---
>>>>>> src/gateway.c | 6 +++---
>>>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>> diff --git a/src/gateway.c b/src/gateway.c
>>>>>> index 16c87f83..b2c211e2 100644
>>>>>> --- a/src/gateway.c
>>>>>> +++ b/src/gateway.c
>>>>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service *service,
>>>>>>                                       is_gateway_config_vpn(
>>>>>>                                               new_gateway->ipv4_config);
>>>>>> -             is_vpn6 = do_ipv4 &&
>>>>>> -                                     new_gateway->ipv4_config &&
>>>>>> +             is_vpn6 = do_ipv6 &&
>>>>>> +                                     new_gateway->ipv6_config &&
>>>>>>                                       is_gateway_config_vpn(
>>>>>> -                                             new_gateway->ipv4_config);
>>>>>> +                                             new_gateway->ipv6_config);
>>>>>>       } else {
>>>>>>               if (do_ipv4 && new_gateway->ipv4_config)
>>>>>> --
>>>>>> 2.43.0
>>>>>> Gabriel,
>>>>>> Great catch on this copy-and-paste typo; thank you!
>>>>>> Best,
>>>>>> Grant
>>>>>
>>>>
>>
> 

