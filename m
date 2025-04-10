Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020103.outbound.protection.outlook.com [52.101.69.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830302036E0
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288002; cv=fail; b=jRyWx+8Apq05KZfSvXmFp7x/KdPq6xXWR82KsRc2zH0crfoEDAaXIfswLHqEtJ7iZm7QY9wce+Xl7zw5TUNqHdR5s8HrwIcOL635SDvPO4OkO1f9rv7ERwmXy27bZ7cgXfLYXKhw4up20XB+6s/nKeWf+0vO3iz1QLNe4oYEf/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288002; c=relaxed/simple;
	bh=YES/BJo83LhCOF0I1XbctEc+nlYaG/qrBK4tDosNDNE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cUOA2UzYzMCtt0T1/cVPjcwLaD2C7nnrgvoTxK7AOjZf/dDwvkbzujoExgJ/JtdemHMF0McWB7nio5cMvryuZlMlQ/fkFcBAGL3r04GINvVeANzoFqRmSkKh20cnTJP+1sAACtsgoMO5zVgG0ZlBP3Wnb9+fzLVyx9qBeA3OId0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=sn+nVwQJ; arc=fail smtp.client-ip=52.101.69.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="sn+nVwQJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTQmICV69lKJZQG8Mo3sHG/jKzmVgyUlMlaqSMoI7IXnr64Wy3u1i13ONyrnr/tLPuwZAGVLfFr/iyEgFLnALPCfG4p4JjkQ3xvioNl8s/EtDlT8oCTpivCw/Q12AP9YRtOFFMwDgR1ye8DrBwz2Dvnadfyl7UA7zNebi5dBKKc8qRrYt/nabmrTXv5z3kblWS6cCd+Dj6zUDpBINTFZrhRjM3jSLfDgloHzOUDYx9C//+HWvvlk3FfNV1naFaqenYYdqn8/0YbyJ0VTfW94MTZ7fYaIJ18BfwVUfiqMeUsAaApQo3O/8etFMKLAfwvArPh03a1YnnDVIO1/N0BIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0Z6MYtLB/pqKZszNAtBXT0dJAJFcjisZDJr7Gb+Q+o=;
 b=m+nAKaTUWEItpefubJ/UxMNA48NxPg3CeCmna17R/qgvNlZS1DBPpqW0syJTLFu/0egX6WQfz4m2GNjBWiM+Y+plyeQvSUquwOBKaq6twN2nBP6rJxvolKW+X3lCQRtMUDozlKqllIBx8QYGHPsAjiJxBjSpGsChVjONVEJIkpozM3dgY0UmNisuPP0jIDlZI/XInyxDQRyudvj7ol2ciGJcqiHnYTOlydHdQEOWwxGzFHqyTOvTUluM5vMnc7NMmTJ5aLPgZXd6keQx65EjZ/PcwccvzZ9GGQdiO0UGKvEu+DHn8ixqfrM6w4rmyh4GjhuJ2Fy2KW/YCTtmNlS6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0Z6MYtLB/pqKZszNAtBXT0dJAJFcjisZDJr7Gb+Q+o=;
 b=sn+nVwQJwh7jdB2bWV1Q2Di/XtweE38yHSz2ACn6WAoRN1FuT0F+aq5BVDsepi9YtgCN0sN7fCuHmAUV8KzBqbm3a2PguL7rPv7C9RE9cNy3XZvuTHJlmhxMkhDG71r/hOxVzmEH96obhjc1RZnIp2ocWS+0sT2+8x82XczXyUXJ7DInxq2CwGUHVjXFDOSvr7baZ6U29/WYt0RzEp5hjR7+6QjvrILJDelJdiiJ0FvkP4eI6Muskt1oWCWW+vTyBY9cSMUzBgcjZEv/ukpnhUmbv6zfofF85K8qHLr7ODNDbKT8goMhoeEUpdV5EXITlomH1EUG/I2oNm43oSUufw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PAWPR06MB8641.eurprd06.prod.outlook.com (2603:10a6:102:381::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 12:26:36 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 12:26:36 +0000
Message-ID: <7c6dddcc-6b90-4df1-a9a2-cabd2483f728@jolla.com>
Date: Thu, 10 Apr 2025 15:26:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Improve WireGuard disconnect, error and hostname
 lookup
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
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
Content-Language: en-US
In-Reply-To: <673eaec4-a289-4b97-8572-b1398e8aa869@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::27) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PAWPR06MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: ceae7399-16af-4af3-ee87-08dd782aef98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1FJTGN1akJQVVl3UkZtdXNsYlRLbjRZMXNqU1RTekhramRUNkc3dUZsYjlK?=
 =?utf-8?B?aW52S0w4dUxOOFlpUEZJNjN0bDdOTmtzL2VuZWtnYXAwa2o3aE5UNWUybXBm?=
 =?utf-8?B?Mmphd0p3N283SEtZZE1KMG8vOXgySEI0emV3K3IrdmNQY0w2Tis2WE8zZm1T?=
 =?utf-8?B?T3hzK2k0QWhxd2ZLZjR1RHBmTm5PME82czNqTU1rSnBkZmFLQTNMNDdsSS9K?=
 =?utf-8?B?L09YL2orNDRvd1l1T2hNTEs2QnNKR0hwdzN1VmZGa0dSdDZOTE1WazNKeDhh?=
 =?utf-8?B?Wm84bFFETGVPMkpsaUwxbERZYnpOZ1pRL0JSYWlZYlh2KzZ6QnV5TjdwUnMr?=
 =?utf-8?B?WURxZllnL2pmYUtWeFNiMFlQNmt1OGE1emdkYzNLaldVdHFtRWJCZFpVYUpL?=
 =?utf-8?B?SSsvTTZFMjlROWZzbWU2Q0JadDZ3am9oQnM2d2JqT2dTbDhOTmxOeXRQUUpO?=
 =?utf-8?B?Rzd4SkJWbzZyaTJDbWdDSEtWQlNiYWQza1kzSm9aSldyV3lnM2N4QWx5TDhr?=
 =?utf-8?B?K2hrUTkvMkVod2RvcUlQb3h1a2MvanFLTEt2TWxQTWZhNE0xUWtYYk9mRWZZ?=
 =?utf-8?B?clArZzh6TXRDajJrcUZ1OVRMVDZIakNrRWJlenltaEZFb2xGS0N2M25VU3Y4?=
 =?utf-8?B?N1RUZDNaWVRWbnZYYmxqMFp3ZTNEMjhUaVVlaXVtSmU1bXA0UEQzenBXQ0Ju?=
 =?utf-8?B?Vm9MaDVMUThpS3dTc1Z0eVh2aGUwUEJqWnRGOXJPSnpzWnRrQjFkM3poeURK?=
 =?utf-8?B?dlBYclc4ZGZTVmY3ZiswNk5pdi96WGYrNHpQUTJXQk53RzBIVlBkMUVGZFB1?=
 =?utf-8?B?WXZLaEVQZFZiK2ZhSXBPMElFbXVZRGJSYWcxemFyMFk3YkVia0Y0UlI3c2s2?=
 =?utf-8?B?aFdva2IrTXl3eERmZDgzZUd0dDVmZDVzWFdVVndBNlB3UjVHOGtrenQzSmtm?=
 =?utf-8?B?L3oxdWtrUHFmb0h0OUxWUXlkRHphU2NKazdHdzMxaWRka3hqMlFrdi9wYjk4?=
 =?utf-8?B?ZHRLS29tcHl2RUsrZyt5TnlKcm1MckZwQTNpZTA1K0lrZVNnZWovNUNuSnUz?=
 =?utf-8?B?L0VPaXJ1bHp0WFJFNEJkcmhlbzBzdmk2ZndLendEVlN0MVhjZTBtTFZmUjBh?=
 =?utf-8?B?NGR2Z21uMUErVFpPbHVkRFZaUFdyOTJSaEFudmg3L3dJcHVrU2pYUU9PNUd1?=
 =?utf-8?B?V080SWJLVEI4WUlabXVCbUZkejNyQit6VjdjbU8wbjFNb0ptaitLY0ZMZDRF?=
 =?utf-8?B?eEZoMU5HLzlRbnBQQWFnSHZueVdTcUc3QWJHL0pzZ3YxK1oxNDhWSEZIUngr?=
 =?utf-8?B?Mm5WcnN6cWkrL2hPVWo0emtqbmlROEZza1R0bVhTM2VrTm1SYWZmRVN2ZlVP?=
 =?utf-8?B?TEFSdUdVejNNM1NBR2Q2ODVVZS9qcytSbG1XVUQxVkNKQ0tndE93anJ0bVNE?=
 =?utf-8?B?VGFMWk14d1hpemdkWGtGRUtCVlc0QUp1alNKam80ek1KUkFISlM0TEMwRmlr?=
 =?utf-8?B?LzV3SHBBQitOdnNJQnBWamtzN3hEcWhCWUh0SzlKYTlPbTF4MFkyWGVPMnRN?=
 =?utf-8?B?djYrd0tXU2tQSFAwYUVVQ1J0aXVTbHBkYkRWT1hUQm14eG8zYm0zVEJWZTB4?=
 =?utf-8?B?bWthbmFvNVlxRjRoV1M0aFpvcWR2OWR3RzRhdk5vUGRYSm9HSkgweXZGQ1ZX?=
 =?utf-8?B?dGk5NExDNDlFV2FhNHMrUWpnSFRUYlgzKzU5TnQ5NFRpb0xjMzArUjE0TFZ1?=
 =?utf-8?B?SEs0czNnSTA0U3dPbi9rcGhWZHl4a3dHaUxYZlZ0QysyMVozWno5emZhRzky?=
 =?utf-8?B?OFJQZ1NQZVlpdThwOFgrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0RETlBkR0U1QVlBaW5lZ0hZSFhMVG1yejd0c1c1TWZYeHF1K2d4QWlCUnc1?=
 =?utf-8?B?emNRSjRwVW0xajhHMDZESzhBeHJWdjJ3MVJxQjUvbzFZVW53NWxiOVlWaHFC?=
 =?utf-8?B?MVpGbkNhdnRFaThON0JZYnhyZlpPL0FqdUlUNlZpait2Y0xpSHArVWJsRHNU?=
 =?utf-8?B?K3hlUFNuRndPaVdxb0gvNzRXYjJjemVtUC80ZkU4bnVlcDY3Qlg3RTlqYU5W?=
 =?utf-8?B?RTRGVXdSdEo1eFA1SXlkSjJjT0hFN1RMQXBOWFBFV2RtVFBuVXZPOEhyTTdM?=
 =?utf-8?B?VmlQU1B2K0twb2JrcUhBYWJ1UXJCVk9mMmNZclFIMno5Vkx4WnJISUFvbXpk?=
 =?utf-8?B?N0J1ck9wZDJsV0ppVGcvS3ladGlZNXpSN01pdmtMbGdxclhsWk04OVlBbWwx?=
 =?utf-8?B?RUVaSnNYcGREcWVvdXI4K1R5endUUTBOQkhVU3FGNkVWdlAyZ1d6b0paVG9q?=
 =?utf-8?B?QVZuaTNoN0lyNEdYbWlqK0hlRWNXZFMzaXBKNkMxdmJFZWd1S3cvWHNBN1FO?=
 =?utf-8?B?Y0E4bTRjclVmc3FjcTNQckZ6dS93WEc1OUovd1VUbVdxQk1oaHFYbmJ6d0tQ?=
 =?utf-8?B?dkhXbHRubWhZaWlDeTA5NnVyY2JjME8xQktFQm5KaVRjOCtqb1RXcmh1RE1J?=
 =?utf-8?B?Ujk5ZDZ4dlY0aHRVdXpISklXZXpIWWR1eElrMTlqN3RpZkxsbjlONEFzM2JS?=
 =?utf-8?B?MVREL3NLUGtjZzVJQi9uUGJsSTZXVmJPK1hWV2dzV09jaFVLRUYyQktXV3RZ?=
 =?utf-8?B?b29yL0M5NzZmNG4wa25uaDU3cjlVVzdFVkUwdTR2c3Z3WGR6WGdvaUNYSzly?=
 =?utf-8?B?cGhJczRZT0s4NFJyS2dFVHNmMXZyQkdSUDk2WHg1UGhlVW9JczBpc0Fkalgx?=
 =?utf-8?B?d01HU04wemNzUTgvRVk2ZWk3aGtOeWR0RGpnVkluSFpsWGxzZUJDWU14SFFL?=
 =?utf-8?B?ZDBjNFRrSGhyMGM5aXJEcXVTa2tib1ZBODB1bXFxd0dHTUFwTndTblZOTTRq?=
 =?utf-8?B?QndWRkJOakNpMWtFTmd2SzlJb3dkMUp2ZEZoRmd3MlNCY1RLQk1obklJeGI3?=
 =?utf-8?B?OFh6TlhQZTQ1TVVkMVhZTkU2MnZaT1QyNGZaOEZ0aEtDcnY3bmc2NXRBZkJh?=
 =?utf-8?B?dzlIYkVwTEZHVHA5cndUOUZDdldpMWIveWUvN2hGUFltZ0xkV3hDSW1oSVFR?=
 =?utf-8?B?NVBkRXdzYURDeWpVSHFmZUNHd3lIUm50ayt4RFQrc0pTSFlMbExUK0sxbFE2?=
 =?utf-8?B?MWk0NktJTDh5TWE0NmdhZ3QvVm9Jd2h1N1dZZ09pVDNLQlpvUllURnJYbGxS?=
 =?utf-8?B?SDkycGF6QS9VN0JMb1lYQ2phOXdlVXlXMFFmYXltR0FzWXZmR0NBd0ZibkpE?=
 =?utf-8?B?azUwWHZzZldTRkdkV09ZOTV2d0VNTW9LNEJXRzhmVEdqRFZvV2ZkYXNxZDJm?=
 =?utf-8?B?dU9Pa2VhZWFpMk94UStuWVZVY2hlb09yMXZVSDBsNUtHbU5EV3RHTVBpZzF6?=
 =?utf-8?B?cFJlTXRtcTVYZGpsbFpIdmkxSUdQU0pQSUZoREhRT25qdjJlbmplUUpsQXBS?=
 =?utf-8?B?WHI5aTlRa2FiQjRvWjBZVWFDZVZZOWY4VFFWQytrTXZwZUprZUtxemR0aGJF?=
 =?utf-8?B?SUpJd0dPa0g5emNpTGpZQWF0VjJFYzJSK0FHTVhtSlFNU3U2KzkzUG9FR1FZ?=
 =?utf-8?B?aTFRZFZoVjlMZFFEMDFlc2NMVVE1b3hhcjF3ZSt4VHQyNER5RkU1V3hRQXFQ?=
 =?utf-8?B?eVU4REplL25hUkFPOWRQdW9hQXV6RXAwTVRDTXNackV4Z1Ywb0Y3MzFUNmQ4?=
 =?utf-8?B?RFdtUUV5VFo5K3NJMXVxQXErVkVmN29jNndxeFNFR0VRc0dqek5sQW83VVk4?=
 =?utf-8?B?U2xNK3dGOCtFcS80Y3hXdkVtU1VOZ0pQV2srUG5hZnRzaDlVbkRHLzlBSytn?=
 =?utf-8?B?YldXaSsxNzRzcnJMLzZOOGRSYVhCMlZYcnBQQ1hkcmhiaUxXQUpUMHFNRXg3?=
 =?utf-8?B?YTdBMEZ0WXFxK2tMWmdiMVkySE05eFB5NzNKRExaNGRPZ0QxTldyb1lMM1JR?=
 =?utf-8?B?anFzU1N2cSt3SThuNEZwdTkybENuU1F2c3g1bjFYMGlnR1dvYUp4cFl2ZHY3?=
 =?utf-8?B?dkIxcnNRUXN0eU9kYXdsTldQbk9FYVZzdHBKN2RxNFBzcnNxcUdzamlTNjZJ?=
 =?utf-8?B?b1JyNGU4K2RoMWRGZ1JaeTRCaVFLQUFVQUNpamxOLzZUV2p4a0VxcmsrQmZu?=
 =?utf-8?B?QVRuTWdvWnBQNFBTaGcvZmd6WXFnPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceae7399-16af-4af3-ee87-08dd782aef98
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 12:26:36.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTW1A6CWn7Kbo9g/HrD0YIINylZJoE0VkeFGCZ3XveJXzI/6+4e019vh30kIf1Hbwvd+dvfjnKC+ivNVCEmvpvha2pfToMlOb4ooKm8+qNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8641

Hi Christian and others,

I noticed that the testing thread has been quite silent for a while. So 
I've done some internal testing here, and made changes to the git repo
https://github.com/LaakkonenJussi/connman_upstream/commits/wireguard_and_vpn_association/ 
- mostly reverts, as in my tests it seemed to be enough to fix the FQDN 
-> IP use in routing. But can you, and others, tell if this works for 
you too? I'm trying to minimize the changes.

But on the other hand I thought also that the feature to use the 
transport service's DNSs for the DNS reresolve in WireGuard might be 
something someone would want to enable for their WireGuard. Like in a 
scenario where the user has no power to change anything on the server 
side if the resolving of the server's IP is not possible via WireGuard 
connection due to broken DNS configuration on the server. And if this 
would be a good idea to have as an option for WireGuard, I'm taking in 
suggestions on option name, "ReresolveUseTransportDNS" is, well, long.

But let me know if the version with reverts works. Easy to return to the 
later version if this change causes any regressions.

Cheers,
  Jussi



On 3/25/25 19:18, Jussi Laakkonen wrote:
> Hi Christian,
> 
> I'm happy to hear this. And very grateful of that publicity and 
> possibility to get even more testing on this.
> 
> I pushed only one cleanup commit today, as it seems that the route setup 
> that is done when endpoint resolves to an different IP should be enough. 
> In ideal case the gateway (endpoint IP) changes would be propagated to 
> connmand but I need to write another internal task for it and work on it 
> later.
> 
> But lets see what testing reveals.
> 
> - Jussi
> 
> 
> On 3/25/25 15:02, Christian Hewitt wrote:
>> Hello Jussi,
>>
>> The updated branch compiles fine now and I’m able to connect with 
>> ‘Host’ configured with an FQDN instead of an IP address, which is 
>> awesome to see!
>>
>> I’ve posted a thread to our user forum with an experimental image to 
>> crowdsource further feedback:
>>
>> https://forum.libreelec.tv/thread/29601-wireguard-experimental- 
>> support-for-connecting-via-fqdn-not-ip/
>>
>> Let’s see what issues come up :)
>>
>> Christian
>>
>>> On 25 Mar 2025, at 1:58 pm, Jussi Laakkonen 
>>> <jussi.laakkonen@jolla.com> wrote:
>>>
>>> Hi Christian and all,
>>>
>>> On 3/24/25 21:30, Jussi Laakkonen wrote:
>>>> Hi Christian,
>>>> On 3/22/25 06:45, Christian Hewitt wrote:
>>>>>> On 21 Mar 2025, at 11:31 pm, Jussi Laakkonen 
>>>>>> <jussi.laakkonen@jolla.com> wrote:
>>>>>>
>>>>>> Hi Christian and all,
>>>>>>
>>>>>>> I’ve been using this series combined with the following series 
>>>>>>> and patch for several weeks:
>>>>>>> https://patchwork.kernel.org/project/connman/ 
>>>>>>> cover/20250124185845.1546384-1-jussi.laakkonen@jolla.com/
>>>>>>> https://patchwork.kernel.org/project/connman/patch/ 
>>>>>>> DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/
>>>>>>> Plus a revert of this commit which I’ve previously flagged as 
>>>>>>> breaking the default “route all traffic down tunnel” with 
>>>>>>> WireGuard (the main use-case for LibreELEC users):
>>>>>>> https://git.kernel.org/pub/scm/network/connman/connman.git/ 
>>>>>>> commit/? id=9eb1772d31b6fcf78e8711976696491aec9ff5df
>>>>>>> For easier testing all patches are in this branch: https:// 
>>>>>>> github.com/chewitt/connman/commits/wireguard
>>>>>>> No issues observed, so:
>>>>>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>>>>
>>>>>> I'm happy to hear. I have been fixing other issues related to WG 
>>>>>> in the past weeks a lot and considering to push all of the changes 
>>>>>> into one big WG patch set, as this has been left dangling.
>>>>>>
>>>>>> I haven't fully tested this on top of upstream ConnMan, but if you 
>>>>>> or someone else is interested to see if the issues that were 
>>>>>> previously encountering are fixed or not.
>>>>>>
>>>>>> All changes are available here, on top of latest upstream ConnMan: 
>>>>>> https://github.com/LaakkonenJussi/connman_upstream/pull/9
>>>>>>
>>>>>> It is a PR to the internal repository so anyone can comment there 
>>>>>> too. Decided to put this into public as Mullvad seems to give only 
>>>>>> IP addresses and cannot really rely on demo.wireguard.com alone on 
>>>>>> this. So, feel free to test, if it works I'll setup a patch set, 
>>>>>> maybe combine some of the changes to make fewer patches.
>>>>>>
>>>>>> Have a nice weekend you all!
>>>>>
>>>>> Thanks for sharing Jussi. Minor compile error fixed with:
>>>>>
>>>>> diff --git a/src/shared/util.h b/src/shared/util.h
>>>>> index 44e07b84..9af0303d 100644
>>>>> --- a/src/shared/util.h
>>>>> +++ b/src/shared/util.h
>>>>> @@ -25,7 +25,7 @@
>>>>>      #include <glib.h>
>>>>>    #include <stdbool.h>
>>>>> -#include <inet.h>
>>>>> +#include <connman/inet.h>
>>>>>      #define AF_INET_POS 0
>>>>>    #define AF_INET6_POS 1
>>>> Oops, thanks for spotting this. I wonder how my build on Debian did 
>>>> not warn about this. I think only <arpa/inet.h> is needed at this 
>>>> point, but that works too. Added a commit to that branch.
>>>>>
>>>>> An existing WireGuard configuration on the family daily-driver RPi5 
>>>>> running LibreELEC shows no obvious regressions with a private VPN 
>>>>> server (not a commercial service). Lots more testing required :)
>>>>>
>>>>> Christian
>>>>>
>>>> Glad to hear this. I keep wondering if something is still needed 
>>>> from our fork... as at least with Mullvad WG I got dual IP support 
>>>> working, and data gets routed from both IP families to the host with 
>>>> an IP. But this is a quite a big change, so yes, lost more testing 
>>>> is required and thanks for helping with this.
>>>> Few things I want to point out, that now sure yet if it is correct 
>>>> way to do this but the transport services' DNS servers are sent to 
>>>> vpnd from connmand when a VPN reaches ready state. It could be 
>>>> earlier, at configuration state too, any opinnions? This is because 
>>>> then the reresolving of the FQDN hostname seems to start working well.
>>>> But, as I now did some more digging I noticed that the FQDN was also 
>>>> propagated "as is" to connmand resulting it ending up in the routing 
>>>> table, which may be cause for this not working in the first place. 
>>>> And I'm talking about DNS reresolve broken in such case as well as 
>>>> the traffic getting blocked. I pushed a WIP change to the PR/branch 
>>>> which I need to continue tomorrow (as we want this to be working in 
>>>> Sailfish OS too) so this can be tested that how it works. The TODO 
>>>> part is about making DNS reresolve to work in the similar way too.
>>>> Have fun testing!
>>>> Cheers,
>>>>   Jussi
>>>
>>>
>>> Forgot to push the commits there late at night, now they're available 
>>> and will update today as well.
>>>
>>> - Jussi
>>
> 
> 

