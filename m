Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022082.outbound.protection.outlook.com [52.101.66.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B80199FC9
	for <connman@lists.linux.dev>; Mon, 24 Mar 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844627; cv=fail; b=ZTchRmj5DyU1FLAoN/95d6b/Zq7sx8rZGA1hX3tB9cdhbj25hkad5WP/pJj2pSMKY06tp+XDgCZhxRx/GpLzzCDdvywiX7cpEaQCp2eQxaOZHWi4CGyIBJGV9o9z0AeVxutyX/c3OlUMgJ/yYqkriUc+5zRr2RoGlbE7rjryGBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844627; c=relaxed/simple;
	bh=60JovylrQMJYx1WAS0lpQ9gsGwNOfGcSMm1nvYftZYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtsFgtGXj6YBOhbPF9+MoGaYmN9RZwM0taCxSn1OFHBCOjRdpve4rbMc04trDdsbKesMM4XfKfbDxJM9t1ONCOsm36eMZ0cZvabyhea6QxnFExzeZhesdSNN/mPrsX1TkoAu4QXYAFsEUPBjj56GLWQPSMkVY+lCJgSlqeTqQIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=tenky85s; arc=fail smtp.client-ip=52.101.66.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="tenky85s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2ry6LcTezBAPo3Pfz7Db+y1kYu7SZt3oroJ3NVZyMH4t1kbT4L0CyLCetA65KBIyfb/k3hKPrWqEfK3SsINxVcUopyJEALnUG/DZEvjxvcp4TWiYl7bARFqNaQ97dx5togXXX5CFhVFUMOCKiXkJCIx6nuJFi4Cjqjc5mW+H6BxN5ciR6u/KPPK1fiFgNmmEftFH+IOrgtBLHSU5sGzKOAxrra4ATV0F4YWXY4Iq7f1mGrMaz5oOFtD2B7DbNdG0LH2E2HNcu+JREuLc0S5UQyrPPq4hIEFtSCgxjSwmKDlxymGGareRtkPi851EpBgCaInEUk58JNsJUMX1eOEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCXFnUMM8zB87bvl2vZqMgY8FJnOK4qUq1flDNrB2wc=;
 b=P7ybE/CZbwUWp6vT7QEEq+Cj1LVxsCJK/J81P7xI0/OE3M4EyvuTJRbU5towEOBztUZu0s+tFBXuBlgejUeyFW6+TBFnHKtH30D6iu1cASe7DXRSHFF6vfu74bTzjlSe9qnG1nKVL8U3n8iK+nKykeL3zYPZn7KIwYFeNHovpAwpBMswyMFiwU5GIiBV/f1Jfv8Qo1k917jun8lnCXEsrXvtxcjPGo5Y8yciU93IAZ8Z++IkywXvSsJP0krF0h/s4UljXPif8PWmhSOpXK02C9FNu6f88oRF6u8auuKa/jGLyE85zuuwkQXBBoNfmJD+nkDls3YFpk36oEu+9uo88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCXFnUMM8zB87bvl2vZqMgY8FJnOK4qUq1flDNrB2wc=;
 b=tenky85sQxHv4t6AiH+VbkBJ4I3yrd+s0J+gxhFbV6NoHoq1hRIfQwVSZM7iuh8G+ZHirkzZZ625XblGSTUia6VBK3/QQOv8Ei7Wkz3EvSuOXrjNKa7nrWpIYZPJzTh0dBzVVJtSUnRtM8jsXNITi2Nfv8Nl5rz0DrBOicxXFH4+Jsrqui6jfjsoueuf2KFm8kbYGURvM9dzrlRnTLtxBgm+uetiMIN83Hsq/6Rums9/o7cn8HohTsfOcnXIybQ7sA5tRyyX9x7c/JzSiCazcDOe1UoDJG+hJhrFk98UfxFwjwPbnnpGTfGRTTfHEP9MEnuLTv2RRyJ82zBiLaRmpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by GVXPR06MB9629.eurprd06.prod.outlook.com (2603:10a6:150:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:30:19 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:30:19 +0000
Message-ID: <c6ae8a9c-df3f-4170-951b-a8a049bf9676@jolla.com>
Date: Mon, 24 Mar 2025 21:30:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Improve WireGuard disconnect, error and hostname
 lookup
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: connman@lists.linux.dev
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
 <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
 <3438fe24-9c02-4c45-aaaf-cfbe260902b1@jolla.com>
 <E23C544B-4E82-49A6-B72E-2279D1BAFC67@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <E23C544B-4E82-49A6-B72E-2279D1BAFC67@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00003826.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:5) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|GVXPR06MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 23be0f88-83e4-4171-1316-08dd6b0a4fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SURJTHFNc1htTlU4MXUzaU1sNGRyRGFRMWV5RzZqekhVbjVqT3NFNFpvUGFE?=
 =?utf-8?B?U0Q3RFg1Qkp3WTlNOWdhcGVhQ0l2TFRza0F5SHF2WDF1WjFpenhJWmhXMzVT?=
 =?utf-8?B?ZGFJdU00b1hiR1lLcWd3ellrTklkUnM2SE5lYlp2cXBLc2JUOXVlMno4Rkt2?=
 =?utf-8?B?aHlXdEs5T2NSN1plSjh4aVJZRnh3Yk5ZNTJPcW90UFdoRTlEdGR5TkdoY2N1?=
 =?utf-8?B?bGtxdlB2enp4bU1EdVZSODhNcko4djZLY3diRUVKQkI3ZnlzSE5FditxTUN5?=
 =?utf-8?B?SzB5STZFYzFZL203YWYrVkRVU0h0ZDJCV3BDZkZ2TFhDclFQaHVPdEpockta?=
 =?utf-8?B?cDgwZ1JXUk12VUdxL3NiZDVuOGlEWmFhVjVkaHBhNDI0ekVDTmNoTEU1MXhB?=
 =?utf-8?B?Wm5BM285QXAwT1gySndiRmJGTjBNSXdleFRiMkFDVmp3M0g2aVdBNkFMaytq?=
 =?utf-8?B?WTNmazRxQ2JEQVJCSjdwckV6NlAyby82cXV5SW41anBaTnEvTDFVQUhPbDd4?=
 =?utf-8?B?bWVtaFV4OXRST1E4Ti9QZ1JLZWNpVnhWQlVTNlFWZkRDdkNCakUzclhyQnB4?=
 =?utf-8?B?ajJYZk13SmhJazltSlNmS0w4bFp5cFRYdzBzbXJnWGNBRFk0bm5WTUVqa3F1?=
 =?utf-8?B?Sm0rTW4zZTBZNW1NWldUaHhyTjBSUzN0TmhzeVQ0K3ZuQVBHYWVNV0xRSjR6?=
 =?utf-8?B?WmVFeE1ISGRSTGgwQnE1NWJvTlhRWjZiWjZFeXpRNWYvQnFNZ3EwTE4zK1kz?=
 =?utf-8?B?MjNpNjRsS1VOT2FXK2wxQjVSd3Ewci9jYnpwQVRjWVh3cnlQOFRsVXZZU3pp?=
 =?utf-8?B?MlBpN25BOVlTM0VQS1ZaRE5hdm5MdEVVcjNSTStaRG9kcXY4QkhjbGVVdlZl?=
 =?utf-8?B?czR4U3RQbk4weVI3ZlRlcERhUzVMMDdGOXJOQWRVYUtUUFNDMGhvWUtSN3pD?=
 =?utf-8?B?OEFUbDJHN3FoUDJZdmpQZHdGTlJYZmg0R1ZmRlNEVEsyUHRIS1p5MnNZbjN0?=
 =?utf-8?B?NnpJbTg1UitVelp5blFyODRiQXIwMWFKV1BYVVArUEVMcGZEM2JCUHdpYWtK?=
 =?utf-8?B?WDRON1BhbzNLZm01Ny90dFMwS3RiWUxjSW5weUtJME90Q3hEdzBIbmxXU01M?=
 =?utf-8?B?Z2UwUEdLODVWcjZidlZiMUsyUUhBdk1QaGRGT2tDdlA1UVdlQ3FrOWQwNGxF?=
 =?utf-8?B?NWpHVERGVUJCMjg1S3AzcllrV05PNlQ1czNMVW5oZmc3cUlSNk50Vm1HaHcv?=
 =?utf-8?B?ZUtRVjFnMFdEWlpCdjB0MDlwWVdwYXpsVzZldkZaTFFYWjNlTC85RVB6VlNK?=
 =?utf-8?B?dTF1eFkvMEMzbkFGZS9pQnpaRDVqWFVsR1o4eDRiWWxiSmZUbkNoYm9EV0o3?=
 =?utf-8?B?U2kycTRBRlhxVDRQdk9SWGdSWGdZREZtY3g3djdtRjNpUzVkNnVOZWFjQnBq?=
 =?utf-8?B?Z1VsNTNlZVdibGt5UG9xQ2dZbGRwaW1HRCtWdXo5ZHdGTmF3Um56ZTdkdHp2?=
 =?utf-8?B?VmdIWEI1d2ZpcTlTeUQ5NXFsMGNpRVc5Nnh1S2Jick5mc2IyRXlNR2QvUjRH?=
 =?utf-8?B?TnYvUmNDVHJGS2hLMmY4QmtrbHcvMDI5OUJiQVlEaVV2eTFyRG9jdEFDdkxU?=
 =?utf-8?B?NlZOdU1aZXcvbGp5aCtWamkrMHd2NTNEK3B5cHlmdXovOFVxR2hpWXc1bHdr?=
 =?utf-8?B?QlI3NS8rMGZFR2FnZzNFZEZhenVTRUFWL0U5ZDdqUDFqQWxTMjZkY29aaDlz?=
 =?utf-8?B?ZHJleWl1KzdTWTR5MU1nN2NaSEVmNThVTTNjcWMxNVcrcXhGVVBBUDRZbmdL?=
 =?utf-8?B?dzZ5c0N6NUxjSmx0OHNNMW1YQUFtMjhIWVhtdGdibkEzTjJicjVhaytzVWZW?=
 =?utf-8?Q?XuKa2HhT1V18q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEluTEpLU2FYbnlSMnZrbEx2ZlllSHpudWJybHBaaHFTcWl1WC9pcnJqcFVn?=
 =?utf-8?B?TGVreDN4b2Q2WjltUUJSWnNkNFErcUQxY0F4YkNhV0Y2WjUzdU9kTlI0N0VK?=
 =?utf-8?B?Vmh5dVg1WmRJV3NnN2trWll4TytYdzk5bmRmTkNlRHBnWXpSeE16TWZ1ZUlY?=
 =?utf-8?B?dWxhWXRtWHlnaHZJWHl6bW5CZ3dCWXpRaXRqY01ZdUsxRXpqdFppREh5Slpt?=
 =?utf-8?B?UzhmQmx3S2RkYlRIVHhoRTA5ZEFSdWpBKzBtN3hJditpT1Fka0Fzd2hUUWg0?=
 =?utf-8?B?Qmowc2E1S3JDVE5hdEprRWhOemlLWk5wbkNQUzNIK3NEM0R0c0RCUWIvY3la?=
 =?utf-8?B?bDdSTGlCVjFMZ091QWdEU2lYc0VyL2RqeUFNSGNQUXl1eGx4U1Zsa0d5WEd1?=
 =?utf-8?B?TEI3RVpEck5aYXY4MnNsajR5dXRMR2ZXemdPNzBKdGhTNFgxZjRHVnQxdkJq?=
 =?utf-8?B?Z3BEN2ttUExLa3hOZWNNQW83UEJVcGZXOTBZbW83N0ZUa3QrMUIvZ1dvRXFF?=
 =?utf-8?B?dXd3OGMzUW1CTXBUQ1JCNHh5cWloZVJGYWxCUFZaWWhycjI1SzdqZGF2U0M3?=
 =?utf-8?B?SVhkYVVYcEVPdldjVTVGYmNtT3VGcWJBNTlFNExWQko1WEVDS0NnM01odTEw?=
 =?utf-8?B?WmJ2UjhpcTA0c0pJdkRjcmx4a213R0lYeXZBVzV4cDR5ZjFwTHFiR0pMTkVh?=
 =?utf-8?B?MTdzcC91TFVjS0d2b08zMm9xUzM4L0ZPSnBBVEJBaTRUdVI0ZlBZOVFoYXNx?=
 =?utf-8?B?NDJIcE5TYWpMN1l5LzYvWTFsNWlTREQ4djF2dndmd2RHTGVtTm1DWDRaejFt?=
 =?utf-8?B?WGhJSkM4QVlnRENERThTYmJuTW5TclplQTRXOGgxU0NmQjlaN3R3WjdSdEsw?=
 =?utf-8?B?amdTd2dIaW9xeDFOZkR6Tkl2Rk9PdmNubDgyM3lxbTk5RjlLSkczUzlVbE9h?=
 =?utf-8?B?b1J4b0huRTBUQXgwdndYMHlaeWprbHRaeWNjNG9wemdicmd3eWJwSVByU1FH?=
 =?utf-8?B?YkdKZG1USlpLMHRkc21ITTFVbVJZV2p0d3VKRHR0aXV1UFh5OEMyUUJEdnR1?=
 =?utf-8?B?c081RDJVTVhTYSs2b2VVbm1XdXNLTGxJLzJnVHArQ2NQZnRidTdwc1ZOU0pF?=
 =?utf-8?B?NG5LaXRjN2hUeDlybmNIY1E0RTFKOG0rLzlFUVJsZ0RCNHIwU2RNLzJnLzlN?=
 =?utf-8?B?S3JZOGR2TkxpOHE0N29XVTkrMEFaaUVJNkNhdnJIT2dHc2M0WWNOZGdsNUQ3?=
 =?utf-8?B?VSs0cStDcnErM0xnUmdzVS9OemJwSlhIOTBJZ2U3dXZURFZjVEQ1OXRjN1Nq?=
 =?utf-8?B?dC8xNmdwMDRvSEtiYXE0TDYxU09Jbk04dEhXcDZhNTVrZzNSUzRQYkR5anhC?=
 =?utf-8?B?MEtvVTBvNjlXYUVORWJOUTFTVGFreGw2Y0dyVGxLcUNCSlJ5N3A3SlBNMHRY?=
 =?utf-8?B?RFNyYkVVQ2tzakRpZHgyei8yNXdWUC9mMWU2TDNwN0RoSGY1WFdaZEk3Nzhy?=
 =?utf-8?B?eDRXeHZQSG1FbnV3Z3dpN0h4ai9Vd244am9zckwwaGpJOE5FTlBmbWN5NFpC?=
 =?utf-8?B?YnhyZUVnMDFJOWNoaVJiVkM3UEdhZEJkdlRuRStxemxBcEUrN0pocG5ZOFh3?=
 =?utf-8?B?VUkrUVM2YWV4TUpwaGhFZGdZMTFHb0NqUk9hU21xMEk3ODRkWkxjV21teCsz?=
 =?utf-8?B?Q0tTR1hjNXNWSnNHeXpHRlVid1F3NklzWlpnYzVkOXRpaCsvOEFHVnAxdU1q?=
 =?utf-8?B?clc0N1VHL0ZUSHZKU2Jlc1U5dFFCZmsxR3BrSENPVzVRb2JkbHU3c1FpcFV0?=
 =?utf-8?B?VmI4Z2pwMTZFNnRFaEsvcjZLbVhWL1dDYTFSc2ZBdmdHam96L0RpQkZYUGkv?=
 =?utf-8?B?VTBVUi9PZjRhWHNDajd0RFRIRTFBeXNkcnR5SXVRREFZRzBxeWpDaGZCUG5q?=
 =?utf-8?B?MkRQZVEyRmxWSUhsbHpDT1FPZS9wVUY0OTZEZFJVWm1RZURURHNhejI4V0x3?=
 =?utf-8?B?V0lUanVuaS9WT0pvQWFkeUdnL0M1T3ZxWnFZRGl3K0dKZkIzU0xURjlrK0dJ?=
 =?utf-8?B?UFg5ZUVRQUhTL3hacDlmaFNwVkEvSXhMUVQwY2NnZTJTWHM1c1FMNnUzV1M1?=
 =?utf-8?B?VGUxRVJQc3JSdzdEbVlnSUZ1S1pvbXhsMURSV0Q4bnZDTVgzZnNKRlkrcG9o?=
 =?utf-8?B?RkpLdVVjaVpTcGJwTGVnMkUrTDA5aHhvc2RqaExaU09IVTNsN0hXbXgvazRD?=
 =?utf-8?B?bzBMQjdaYmJIWGIyVjczalBQbTFRPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23be0f88-83e4-4171-1316-08dd6b0a4fe8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:30:19.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDZCT1WvXDIck75DqhHZy5qeizdCfP4dCwimJLoWFUyRZQTn3J7jh3aqgZr4RlYaIwZ/eVqVlJDwEJHo2s11AHPFYQr4nKRvqm3glEuwsCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9629

Hi Christian,

On 3/22/25 06:45, Christian Hewitt wrote:
>> On 21 Mar 2025, at 11:31 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>
>> Hi Christian and all,
>>
>>> I’ve been using this series combined with the following series and patch for several weeks:
>>> https://patchwork.kernel.org/project/connman/cover/20250124185845.1546384-1-jussi.laakkonen@jolla.com/
>>> https://patchwork.kernel.org/project/connman/patch/DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/
>>> Plus a revert of this commit which I’ve previously flagged as breaking the default “route all traffic down tunnel” with WireGuard (the main use-case for LibreELEC users):
>>> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=9eb1772d31b6fcf78e8711976696491aec9ff5df
>>> For easier testing all patches are in this branch: https://github.com/chewitt/connman/commits/wireguard
>>> No issues observed, so:
>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>
>> I'm happy to hear. I have been fixing other issues related to WG in the past weeks a lot and considering to push all of the changes into one big WG patch set, as this has been left dangling.
>>
>> I haven't fully tested this on top of upstream ConnMan, but if you or someone else is interested to see if the issues that were previously encountering are fixed or not.
>>
>> All changes are available here, on top of latest upstream ConnMan: https://github.com/LaakkonenJussi/connman_upstream/pull/9
>>
>> It is a PR to the internal repository so anyone can comment there too. Decided to put this into public as Mullvad seems to give only IP addresses and cannot really rely on demo.wireguard.com alone on this. So, feel free to test, if it works I'll setup a patch set, maybe combine some of the changes to make fewer patches.
>>
>> Have a nice weekend you all!
> 
> Thanks for sharing Jussi. Minor compile error fixed with:
> 
> diff --git a/src/shared/util.h b/src/shared/util.h
> index 44e07b84..9af0303d 100644
> --- a/src/shared/util.h
> +++ b/src/shared/util.h
> @@ -25,7 +25,7 @@
>     #include <glib.h>
>   #include <stdbool.h>
> -#include <inet.h>
> +#include <connman/inet.h>
>     #define AF_INET_POS 0
>   #define AF_INET6_POS 1


Oops, thanks for spotting this. I wonder how my build on Debian did not 
warn about this. I think only <arpa/inet.h> is needed at this point, but 
that works too. Added a commit to that branch.

> 
> An existing WireGuard configuration on the family daily-driver RPi5 running LibreELEC shows no obvious regressions with a private VPN server (not a commercial service). Lots more testing required :)
> 
> Christian
> 

Glad to hear this. I keep wondering if something is still needed from 
our fork... as at least with Mullvad WG I got dual IP support working, 
and data gets routed from both IP families to the host with an IP. But 
this is a quite a big change, so yes, lost more testing is required and 
thanks for helping with this.

Few things I want to point out, that now sure yet if it is correct way 
to do this but the transport services' DNS servers are sent to vpnd from 
connmand when a VPN reaches ready state. It could be earlier, at 
configuration state too, any opinnions? This is because then the 
reresolving of the FQDN hostname seems to start working well.

But, as I now did some more digging I noticed that the FQDN was also 
propagated "as is" to connmand resulting it ending up in the routing 
table, which may be cause for this not working in the first place. And 
I'm talking about DNS reresolve broken in such case as well as the 
traffic getting blocked. I pushed a WIP change to the PR/branch which I 
need to continue tomorrow (as we want this to be working in Sailfish OS 
too) so this can be tested that how it works. The TODO part is about 
making DNS reresolve to work in the similar way too.

Have fun testing!

Cheers,
  Jussi



