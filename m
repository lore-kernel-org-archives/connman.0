Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021131.outbound.protection.outlook.com [40.107.130.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496E4317D
	for <connman@lists.linux.dev>; Tue,  3 Jun 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956927; cv=fail; b=OHbXO/a16gZYkTIGY0IYnmTlPvIvkb+OcAZwtPgLrh36epYcxaLEUBvP0cKAj4fwlAflk9kJfy9obYZL4XHgsX/0Tg/n0NJ+I90tyJoMPvpuCSqdupQaICKJDx13HxxlCVMMfCVfvJbCxGF0iSTrZMJI8Euh9vCKVG/uJrdSNY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956927; c=relaxed/simple;
	bh=iRP8B2Nfmer8AkkcdekLGuPldJ+jHcgVhYtaVQI5lTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sBWe1EJGzBoRwIt3KS5xB7eRunIqnAqO00x5pdS/a1AHLtxyDgcsA0W9eRE1MluQluVJBf4scHlc5aVnRAc4rRSDEdrrHJB1yLCE9C+7cy+7Yr2xumFwGEE3YB2BHWt/nTWdabdtF+qVrzKC7uXRBmTmNtHni0hQV6zZW93Ozrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=mKV3FhNv; arc=fail smtp.client-ip=40.107.130.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="mKV3FhNv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agFbL93j7A6tP8zSe9f/hLS1Gv6MqhXqitg9wdajEXkKTLc6Lb5KJYSFte9Qx4Y4Lune2omCydGCqHn8qfYznqgCq20E2F9eD/ifC88AHxhmauKjvzN7Wv2upRMS2QbUDL0Z7Fp3GwoORWsBXzEMPL+m6OiCikMPac7pAysogAobJgoPp7sEWU6MRURyaAqoKanfds+12VsLWzNIKVBxFwY7cZkI9iZnjPQiclHLyz8Dk4TK82ZcDf1rf335ebGz4rwHLiPtmaZPj200lEHpM7G4rBfS/y5LZw6mJh4eLsPq7fbcdWrrN0hHyMfc0q0AsrwOj4VD/lGZl/CZ7O4Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rS/dD6C1MrPlOUhLwhbfhhFYdQg95lmwLqmu4aNr1I=;
 b=i74M6iSRcs4nuIFYiWUBz1wknvXjWnAxYLE/EN5Q/D8efJEzROV8bNh1FME4Iqkh03MJF1dgPU2WD/kwZnEYxjR9pJXe816xPSUTU45XY0aWroPnmr8mMnHqd1fMP3i+BlrVm7742LqFHFlx5HxCBaucXE8AcO9wg3A574bzLChTvuVjmS0dlsIQ5Z6J3B4yaFGu1EvDR9rCC0pbSxNPJw+aKcdUg6O4XLnuSi4L1hpGq6cYYFiT1GENpGqCRYxB2CGCA47/KChWoJeGxgGxlaEFcc9o2wfAf1i1B+YZMwWm/QHlrP4Tf6SscICVKAI8vEcIEBdj0An89WSz2CYrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rS/dD6C1MrPlOUhLwhbfhhFYdQg95lmwLqmu4aNr1I=;
 b=mKV3FhNv8x2CQOWDvaPVvhF2hGl4m7RFWruG58gYE2kmOg4USkeTkhYC3I7dxWz/0O2VWdV6pNvCbAzXcYkpCh/qtOyHpN0e1ezek6SD1DRlBVRF3JgnrRAOgND9/v11NX5TXX4RHYNMusyVKFo1RbGXKT4mALgsQ3NOGj6+BjinQDTHf5TBoKE0kpaHoBDeWZJJad7IguEAdSz7buwJv3Ua/8wTsyxQGMR8ggqEr/PVJtdBDyqYN2/1kyf18qKukzdGcwqL4Qo+tJrhcr7IoQEyRI0tY7pD2ycuUqSXq/VDLqb09qbfdDodnEkCctrSKKBST0tTTVfG0qZ1gDH/mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:22:01 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 13:22:00 +0000
Message-ID: <b112db9f-1453-402a-be41-dba770ba3dbf@jolla.com>
Date: Tue, 3 Jun 2025 16:17:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] timezone: Replace Localtime file copy with
 symbolic link
To: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>,
 connman@lists.linux.dev
Cc: denkenz@gmail.com, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com
References: <20250603131034.60946-1-andrea.ricchi@amarulasolutions.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <20250603131034.60946-1-andrea.ricchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:7:28::32) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|DBAPR06MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 8932e430-b207-4960-b3c0-08dda2a19f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wjg0MGs4NXYwbU1tK3VxeE8ya0MybHdrelp0MjV4bWtiZGdBNnRkRDExd0xN?=
 =?utf-8?B?d0NsZnZ0blQrVi85SHdxcmVKYjNCVDNXRCt4NkJGZEF0Skw5Qk4wODdsQUdn?=
 =?utf-8?B?L1RKZWlSaTEwaWVla3pBbkpTY0ZVc1k2UmkzN0NpOCswckFTVmg2MC9ldjZ4?=
 =?utf-8?B?dFlkT1czeHU1MTVqQzRONzZsM2NtN3Y2T2Fmb0lXbThJYXBlT1pyZ1BCaTlM?=
 =?utf-8?B?R0RaN3UyWnE5VHpYN3Y5cmlKSXlRQzUxYWxGOTV5WnFQZlIzK0gyVzdQT2Y1?=
 =?utf-8?B?ZmJlaTM2eFJhbkpDeU9hTVVlR0dXTFRaVmN1cTNJeTJDVm1RZDJjU3RRUXRv?=
 =?utf-8?B?VW9BNDFPMWMrWHVLTlBBYnBYTWh0OFVKVnZ2L1hRdkFZdkRvOWVFT0UwcmtZ?=
 =?utf-8?B?d2hiZnFNcGdVZW1lekdaT0ZOZHJneEs0NVJEMnZlWUlXYUs1WHQ2bHk0a3Vn?=
 =?utf-8?B?TnBJa2ZWSUFwenJuUjU5TWQ4SzBlY2JOYjFpNWNiWVJGZkVORGhxOGcwYlht?=
 =?utf-8?B?K0s1b3JScmxhR1dmaVhsVnh0d1U3OEJmeDZvc0ZGT3UrTjV4dWxTWG15eEgw?=
 =?utf-8?B?aW9NelZ1MkorUllNYUJwbDNDZmNwazMzWkNJRXZ2d2R5UHpxeHFEQW1XSi9L?=
 =?utf-8?B?bkNIU09YOUR3aktLaU5nbEF0WmRZWGpJdStmSHo4WFlSVldkc3NwY21DMWlo?=
 =?utf-8?B?dXdxL3ppY1MyOW9lZXpCY0lxL1FkOExjbW14S0FxQ0xaaHdPcmpGYUZMNDF3?=
 =?utf-8?B?WFlzcSt0QjE3NmlJTjREbUdaclJtbTQ4NHJvc2VNNnpEUFhHTU45UmcxaWtL?=
 =?utf-8?B?cWFSUjNnSWZmYmRoOXp4SzNLVXBhSWt5ZE9CeUlITGQxWHFMRmNyTE41RnBa?=
 =?utf-8?B?azN3ZE1oVnhJLzkwQkNqVTd3R05wQUhxTGlwcEhXekNmTHArWkkyMlAvM25T?=
 =?utf-8?B?czRuNG9xTEg4ZW90b1EzQ0x3WGlabWRPWUxkU0h5U3lCQ1RNTjd3UE9hUFFW?=
 =?utf-8?B?Y2hGc2JaY0N0dXViaXQzZHF4TDY1ZGJZcW5QS2xDK2g5SmUxd2haOVJqck91?=
 =?utf-8?B?ZWdiOVp0djRLd0QvUFErRGRFSm5rcjc2L3k4TXM2L3phUW5OTjJhK1Bscngy?=
 =?utf-8?B?SDBxUFRMNERFMDdEQkdKOEtZKzZTeHNad2loaUE1L2x1dUhxWjFtUzJWcnlC?=
 =?utf-8?B?UEY3VEIvbVFkMU50aElSMEVCQ1hWRENHTWJPUnI4Um9EZk1wbE9aV0trTGly?=
 =?utf-8?B?eEFYN0FsY0RhNHlQVlJEeDBnd0RQSjcwVWJ0SjIwQVBVRGUyQmVpRnpFVndP?=
 =?utf-8?B?UXhGSjZUVlNhQTFYUTdPeWNjVFVFbHZRU1daSDd5OHhGTGllc0JpYU8zUGRp?=
 =?utf-8?B?Uk04SUxlWmQ4ejVURjR2bm9SbCtyU1QvKzZqTGFZQlUybjNaUHAvTk5VWDFy?=
 =?utf-8?B?VVZJQWlSQnpNUmZLbUJINFczcHZaWmNwOXVVaWtyWVNQcUFyYkpBWlYydVpt?=
 =?utf-8?B?OTNHdmw3SGlsbWtoMkNpUytSVm9hRWQyRkU3NjdSV0J3Vk5XM0xVTTc3bzRN?=
 =?utf-8?B?SGNjL29mUzNlbDA3dFJQZkphYWR1UHVMZjJ2YUdzcDVNSmxpNmduUWgyY001?=
 =?utf-8?B?MElNZ0g5QlVPdjB0RSszWGRHTnBaTm1QbkpkL1Q5KzBwZUpzMDJNdzZHOHZz?=
 =?utf-8?B?bjUxVkNuZWxZb1lGQXp3SzcxWENKdm5OYnpQSG9MaVRlYWRmSXpRWURWQ202?=
 =?utf-8?B?UkkrQlN3UFhjdHdXeE1Vd1h1ZWQ1V1JmamhQTTUyYjhaN1kyWXM0Z0RpcmlJ?=
 =?utf-8?B?dDlQMVljaTN2OTB2aFF3dzRJMEx2U2dRVndUMUNidTVLSEJkMW43ZmZXanlB?=
 =?utf-8?B?R2hMSjBMSUtRWHlDYXJ6NmZ1a093L2xLY2k3WkcwUDlMVUVLdGp4eVBDRXZY?=
 =?utf-8?Q?gipyLqsEtWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NhMUxpTHRpZGUrdGhlUzEvZHM5NVFkRHF4M1d6Z1A0L0FMR1hUenBCZFJw?=
 =?utf-8?B?YnJhd0tpOEg4bmhrcWpHV3hyTHlGSmN0dUFHQnMzekVQR211RVZTWmFUNDRP?=
 =?utf-8?B?R0dCV201a2hORzZha0xiaTY0VFJaZWlRbGQ5ZlVWK1FLTklZcFg4LzBZbFFT?=
 =?utf-8?B?NXB6V1VxWDgvdDhXTjhuRGZ0NjBrNk1lWGtDZ3R2dndkQnBvY3FqdVJiT1Mw?=
 =?utf-8?B?MzBpbDNldjFOVGJLVXNLZ2t6UEtESGg2a0JnU0VwUEJlTVdOUFRNaWZEZHJQ?=
 =?utf-8?B?Z0NnRjhIKzhRdDN6NTRnTll3VmMyTW9uei92YTYyNWJuRkhCUjJjZ0pTMnJS?=
 =?utf-8?B?WWdLTjNOSnE4UFJWNitPVTRsNFhQVGNMZDZsNXRJTE9pdkdKL2h1Vk1MSnoz?=
 =?utf-8?B?ZWdScTBIOE5Wa255ZnRxbjc0aWlVL2pkL2hlcjhVRHQ3TnpFS0dZQmVXWTUr?=
 =?utf-8?B?ajBLeDQ4dHpJaFN1dlFLK2YzbCtzS2QwR2lNdDFZZGJyekl3M3FxNDExS3cw?=
 =?utf-8?B?Vmh3b1VKVitpeVlzaThiTDFxUTM1Nkl2N01URktSbVA3NjVpczlDYjdMS2Fz?=
 =?utf-8?B?TW1pNmZKVm45SGZPUEhBOWZjMFJOSkpUd2lqeE1aVVZ1elFLTDlmcUFHOGRq?=
 =?utf-8?B?dTFtdXdPMWRNYlVMd2JDWDI1MlZTQ0ErWGhnOUlpQk5LYUJKQXlMVzJiaXpn?=
 =?utf-8?B?S2NDWjdqOW1QZmlFQlFSVVZMcS9icE1NQ0VhNE1zek5vTzRYK3ZBT1Q4TE5S?=
 =?utf-8?B?YXVwSzBlN3lBd3FMdVpaSUU0RW1nK1NVZGhQUjBBTlcxcHF5SCticitCMFlt?=
 =?utf-8?B?TkFoL1NCY2RaTC95MTJwdUtlQU9BSUQ4Tm5Nd2h0ZGVHOE1Ua3I5MlJyR0RM?=
 =?utf-8?B?ZWx1QmpPNGlDM20yM3NMUVprRFQ0b3ExZlYyTzZnV2oxQmpZcUhGcG1JcFhC?=
 =?utf-8?B?Sk02VmFwUW1xN2taL2xXekFOY0wrb2xudmFubHZreloyMkYwV0FLald2OUp3?=
 =?utf-8?B?dUtYYUhHNUV2UFUxTU1icVdwVWVUaDFrQmxiS0VXeEZPM1ZoMzVtemYzcTNo?=
 =?utf-8?B?Q2dRc0ZlQ21HVWNucnlUQ1VKK0pVSE8weVZZMTBkNWZVa2kyWGNLTjVBeklm?=
 =?utf-8?B?d1hDcWJLT242ZVlOYWFpYlUrUFNaVXlYb3lEZUpTY3pCcnZDOGR4MEVib1Zr?=
 =?utf-8?B?TnFFaHpZTlpUQlJ0SHVuQTB3cUVicnJQMER6RlAvT01vNk1aVTFjZEFEb3pM?=
 =?utf-8?B?TzVPRlpwT3pUeEo2MVdvN2x3Uk9XRU12YXdoSXNKeCtqR1hjNnNJU0FDMWcy?=
 =?utf-8?B?eCswcFhBS2drYlpiMFV0bnU0bHVwZU9QeW9BcHFBdHJlbGtWaHJCRzFna2Zo?=
 =?utf-8?B?dmJBSGhObHJvRE5tT3VNWnV1Ujg3NGl1QVdyWUNrOGZWS1BrSWl6VTZGUUNO?=
 =?utf-8?B?K3lkRTZrR1ByTFB1MlJ3WUY5MFhqdjRnTGZjdC9xd29VMVJiRFJYck1hcElv?=
 =?utf-8?B?Y1dOUTlXa1Z2VTM3ZDdkTUxSK1JQOWJDUnBTcDNoNytaamxSYlFKYTg0V0Jw?=
 =?utf-8?B?dTk4ejE1UHpmeUtxV3FRODhLSzdlTnVNUm5jWDZJc0tOdUF3OUhyeVJhSVR0?=
 =?utf-8?B?b2hsY3FraTdlY0U0UmxsZkxScURpMytrMnFMZm12YUdWa21zQWlMS3p4Mmo1?=
 =?utf-8?B?WXlUNkhZSTRSb3FGc3dKT2pZL0oyWXJUUE90N0J4bThmalc0Qm5zanhvcjhY?=
 =?utf-8?B?aGgranY1QUZhSXR2SlpINCtEM2hnTDhpZW5sTzBOaU1qWVF1czUvNkpKT1hN?=
 =?utf-8?B?RDhzbE8xZFM3czhMZ0wybFR3RFVPRjQ5NmRtYUc1VHBnWmxCZmcxeXZkRmFJ?=
 =?utf-8?B?cGMzY3RZeldTMXpTUm1qN1ZxNlhyckl5TURtTlN6NTl6d0V6L1pVcFhWd0o5?=
 =?utf-8?B?dzdISjlJOXppV2xaY0Q1d2o1czlZRnNaeXVLQVZjYkZ3VjZvNHUxQVQ0blpK?=
 =?utf-8?B?bFlDSFZvQjlKRlFIU2EzOEw2K3JwWXdZd3h3RzMvYlNKL0NuKzhOZ3NvWlY1?=
 =?utf-8?B?eWp0OVpiVlJYVzlVZGJLaXVzdTBDYmVCb1EyMnRCK2JHMjNNd3ZycXZZWjNN?=
 =?utf-8?B?cFB2bHA1d2JpcGVjOGJNUy9yREViNGQ2eFdQNTJyQnZhMzhvZllhRTBJWnU0?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8932e430-b207-4960-b3c0-08dda2a19f52
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 13:22:00.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8NKyV+zVmlQsszZWy5DzWgl6BQrIXdaeE31mCBuq/vTNZdM8aMbkMTFpc0TEiyQgxHAXTg33pVCT2MGO+3kl2nVeJc2UEOxbJUKr1BfmQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6901

Hi Andrea and all.



On 6/3/25 16:10, Andrea Ricchi wrote:
> [You don't often get email from andrea.ricchi@amarulasolutions.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Based on the `man 5 localtime` documentation the `/etc/localtime`
> file is expected to be a symbolic link, not a standalone
> regular file.
> 
> This change replaces `write_file` with `write_symlink`, avoiding
> unnecessary file I/O and memory mapping. It ensures Localtime accurately
> reflects the selected timezone without duplicating data. This also
> fixes `__connman_timezone_lookup()`, which requires Localtime to be a
> symlink to function correctly.
> 
> This also fix `compare_file` as is intended to work with symlinks, enabling
> full and accurate matching between the requested timezone and the zoneinfo
> database.

I'd suggest doing two commits. First to revert 
f20ccd19a62bd01aa117bfc8e7c388d2a16cde05 - then to have these other 
changes in their own commit. For me it would be a clear process here.

> 
> Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
> ---
> 
>   Changes v1 -> v2:
>     - Change comit message
> 
>   src/timezone.c | 53 ++++++++++++++------------------------------------
>   1 file changed, 15 insertions(+), 38 deletions(-)
> 
> diff --git a/src/timezone.c b/src/timezone.c
> index fba8b925..9b820477 100644
> --- a/src/timezone.c
> +++ b/src/timezone.c
> @@ -124,8 +124,8 @@ static int compare_file(void *src_map, struct stat *src_st,
> 
>          DBG("real path %s path name %s", real_path, pathname);
> 
> -       if (real_path && !g_strcmp0(real_path, pathname))
> -               return 0;
> +       if (real_path && g_strcmp0(real_path, pathname))
> +               return -1;

Suggestion: this part as a revert commit.

> 
>          fd = open(pathname, O_RDONLY | O_CLOEXEC);
>          if (fd < 0)
> @@ -507,28 +507,20 @@ done:
>          return zone;
>   }
> 
> -static int write_file(void *src_map, struct stat *src_st, const char *pathname)
> +static int write_symlink(const char *target, const char *link)
>   {
>          struct stat st;
> -       int fd;
> -       ssize_t written;
> 
> -       DBG("pathname %s", pathname);
> +       DBG("pathname %s", link);
> 
> -       if (lstat(pathname, &st) == 0) {
> -               if (S_ISLNK(st.st_mode))
> -                       unlink(pathname);
> +       // Remove existing file or symlink if it exists
> +       if (lstat(link, &st) == 0) {
> +               if (S_ISLNK(st.st_mode) || S_ISREG(st.st_mode))
> +                       unlink(link);
>          }
> 
> -       fd = open(pathname, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
> -       if (fd < 0)
> -               return -EIO;
> -
> -       written = write(fd, src_map, src_st->st_size);
> -
> -       close(fd);
> -
> -       if (written < 0)
> +       // Create the symbolic link
> +       if (symlink(target, link) < 0)
>                  return -EIO;
> 
>          return 0;
> @@ -537,33 +529,18 @@ static int write_file(void *src_map, struct stat *src_st, const char *pathname)
>   int __connman_timezone_change(const char *zone)
>   {
>          struct stat st;
> -       char *map, pathname[PATH_MAX];
> -       int fd, err;
> +       char pathname[PATH_MAX];
> +       int err;
> 
>          DBG("zone %s", zone);
> 
>          snprintf(pathname, PATH_MAX, "%s/%s", USR_SHARE_ZONEINFO, zone);
> 
> -       fd = open(pathname, O_RDONLY | O_CLOEXEC);
> -       if (fd < 0)
> +       // Just check that the file exists and is a regular file
> +       if (stat(pathname, &st) < 0 || !S_ISREG(st.st_mode))
>                  return -EINVAL;
> 
> -       if (fstat(fd, &st) < 0) {
> -               close(fd);
> -               return -EIO;
> -       }
> -
> -       map = mmap(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
> -       if (!map || map == MAP_FAILED) {
> -               close(fd);
> -               return -EIO;
> -       }
> -
> -       err = write_file(map, &st, connman_setting_get_string("Localtime"));
> -
> -       munmap(map, st.st_size);
> -
> -       close(fd);
> +       err = write_symlink(pathname, connman_setting_get_string("Localtime"));
> 
>          return err;
>   }
> --
> 2.34.1
> 
> 

Suggestion: and this ^^ as its own commit.


Cheers,
  Jussi

