Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021124.outbound.protection.outlook.com [52.101.70.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843427726
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745415; cv=fail; b=QlU8itBVNBgL50bVcHPtUct6WGaeVVmQzf27RPJYQBq3zDVGayKO8bxJqlDFYc+jx+c+cXOTQ3tW7OyE28F1oP9yS1VBAF56gZmanYK0Tb8MEca1i15gWNY0GGtshWaz1hiLtQQHw0LK4rve4stEcShNWWp7igkGGdrnl9diJ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745415; c=relaxed/simple;
	bh=zk3GtEk6xyHY7qXiFhaWjFpugolJFoVQ2HpWabhPmOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ImwBWlBKBbKInYxUktZ5kNngiYiu+R0om3STE3iOeCFsWpicYgtqMoE9NTOpL8TiTi+DbxgXGFqF+ymq6OORI5WYGr+NVs1DbFWpDdIOiTBZXgFMv3cJ4o2luWzzQRVfelDmYq9UMC1H0q2UJBNaN3lvq/hNCFzfYIMhArJuxb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=j42VPB+L; arc=fail smtp.client-ip=52.101.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="j42VPB+L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdzNcIat+bD7Y1UwxXWGW/XN6ahLTYxIs4qtSHeIRuHjFQKIZSGPQSk+Xv2TxNn+UID3xTE+karqyJV3SZ+r7MOE9YkyaByGJPkaYdp74Ibr6nvoRY01APoEw5R5zkQs+aw91wT7aMv/dv4zPIW74+/H4lAksXSpEL3xktGHI+U/Ly/Q+WZnm09Nipyg+GpuO7ThWCoYaklpu30CrLn47ZZd9JJuouXpOFKS7NsyIkOUBNBOPWAgAKZxQ0YUBrt3N2V27P36StspzCHEWUslKhgZL2FP27SbvYirSnopIYBXL8/pm1HPTCX+qLloDL9ZkkmXSF1OMDpL+KEndw7edA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozbtd/urxclHjZTA0g3XPx6ga2LmIwl9Q2qibTrv7Wk=;
 b=T3HNwQwAcwDpqecy5xdOBWZs1Pw6RNFug8RhTQLLCb5UgVevDB4BXSoUQyiWBUrHRDibcf4Fp7oZRsfDS3fK66oZxeiXBewTJTE46k1q7bid5S0ZaRY5PVI4FTnW2VkNBKiwrA2AG8fdfcwRtiQXh+74BfusV0szGDdVKjfLQ999K2RCElYT24pBySl/92dgCnHqrAMDEuxr4TTvML6T+QmiLgd+6d1OgW2XQbeDfDOIq6nCHxAeqmP1klLhTcpt6mPxePSD/FIfPCZMoDHZx1MWqTp1H8rQSlTMEx/NSe1bzIUDc5EYpQQQtgi7AWMDirOywvNi6D2yvp2ZKxZ1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozbtd/urxclHjZTA0g3XPx6ga2LmIwl9Q2qibTrv7Wk=;
 b=j42VPB+LkeyN2y6NALciabl2BcAFC5YchZ71y7b/hmw6H9UXRHoDwP2tTBdrkrl4MdCBtj9fiAdV3Q+HVlkWKeuffdHvK2dOjdbdOPZHppwDVNHO7rrg8nmndSPNTKjaVglwHfdOSkaOtWs/AcMmZy8/p3Rt6xhmrCLYmQmlrUGdHvRc8OzdGSixkt/iTfD2/fWUgnFLuAPFhmZSdrnkDflYkwW1esShnqPxVUjDrvX93W+u6FKyvACUhaVllVerZXj/xVp/zCv7Byk/5RDfWEarVsoF1gxZxOfb4VLRkadSKf09vbGlTEcgCb4lbGfkSZvS57UMlYgWglLM3/jWrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by DB9PR06MB8464.eurprd06.prod.outlook.com (2603:10a6:10:36f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 19:03:29 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 19:03:29 +0000
Message-ID: <bb952186-9493-4efc-8256-deaa63c7385f@jolla.com>
Date: Fri, 24 Jan 2025 21:03:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
 <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
 <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
 <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com>
 <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0000366F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::38f) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|DB9PR06MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7de821-a3e4-4c40-e119-08dd3ca9c9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUtaQndiSHpOSTlBTXRVYnpiWE1RT1QyZEdtZWxQd1FWRkNDaXN4SW9DK3RO?=
 =?utf-8?B?TzZYUXduMDdFTUwzZ2F6K0FER29sNmtBT2Z1VTNCcyttbG8vREhDRHhNQm5S?=
 =?utf-8?B?eFh3U3laNjVDZVhBUS9GRmRPc3kwTS9WL1hFeVVOdkw2RjdLNUNyN0pHYU5a?=
 =?utf-8?B?RlBUb0xUT3habWZRSHpHNzJteldEcjd3VjBVbmRkT3J4ejhjdTc5NEdSTWh5?=
 =?utf-8?B?aE5pTk9NS0FWTWpLM1B2UHNCUDVKaW1oUG9MNXptMC83Y1k5YnljNi9CNjlF?=
 =?utf-8?B?ZDNyOVRMTk4vL0RFYmQrUXNOcDlWdmVQRk85VVRSTXlrak02dEZsNk5jS01u?=
 =?utf-8?B?MGYyaUhVc2FJd3BDZDdMMWF3ejAzOENhRHptTk1UOUxRWjdSWUFCRmlJenR5?=
 =?utf-8?B?eEV2dDhaQVROaXI0cjRzZWd5ajdTd1F5OGc5MWJnQ25jRTVCQVAraktBSnZt?=
 =?utf-8?B?QWZXRFo4TmhPRzFlUU1qb2cwdW5OMnh6WmxabDJ1bkFTcVFVeUFDUmpqckIv?=
 =?utf-8?B?S3hybytJVnBEaWN4a2FlUHp2VGRFdUhVOUhwUGloN29DRVhjbFB3NTNRMmta?=
 =?utf-8?B?K1U2ckJqMlVVL095MXVEYUhtM2grS0FIQzBFM0NBVVBDMWJvdHpNMzgzTlda?=
 =?utf-8?B?SW4wU0VmUlBYdi9jMXJzQTdra1oybjFodGVYaDQ3UzRxbnlVNU9rL1hoYmdY?=
 =?utf-8?B?YjVyMDd1MEp0Ylkvc09yQWR3bHN3L1VhamY0Z3pmNkExVUxPRWEyMElDdFJY?=
 =?utf-8?B?SEdTbTNIVXFValUvMGZVQjRZU0NMRGk3Skh0UjJRcS9NQTNrWVJFby9RVGI5?=
 =?utf-8?B?ZXF2TzA4Q0xqV1hSLzZNOThyUkZ3bmpYN08xSE5ZSTJBQm9FbXo1NGFxeUtM?=
 =?utf-8?B?SGVOTG1UeHIvaTBmeFB5TnBQYWp0eERLRWRXMjVtb3B3ZUxVT25Za2NNNUVs?=
 =?utf-8?B?eUtTUDZTUTg4RHVDbXZuQWE0MmtaK2JVS2UyVUR0T0ZTcmMxemdPVG9pTVZ6?=
 =?utf-8?B?QW9OVFpyanNyS1M5eXRWQ0ovVStQajFRZXU3dm4rSVYvNlFUYW9IQWZaQUZ4?=
 =?utf-8?B?SzE4VHhPNTBKaitaNmE5RER5cUNUUjVLOVAxd2NLTTFZOEtESXp4SlZIWXRM?=
 =?utf-8?B?dkF1bTNhOEhBT2R5VmhKa281cU8wdUFyU1hvNEdqZkVMNUR1bFdFMmZsQlVa?=
 =?utf-8?B?SmkvdjZGMmdONTdmVUdVZDRQd0NqWkFwa01PWHgya1l2WnVrbHlpRXBMaFM0?=
 =?utf-8?B?aktuUHdvWmd1UDkyaDJnczQ4bnlERjIvenBZZFVycWpnblVqb3hObXo4R2pN?=
 =?utf-8?B?bng2MG5HMit5VjBmbFpyNkozTHFQYVVkUllhZENlWWNSaFF0TGkwNklCMUhs?=
 =?utf-8?B?WUF2d3c2NXhYUXN4WTd5cm5lSjVqazgwT3JSSkhGNkQyUmdBdnllL2thdDRa?=
 =?utf-8?B?TGo1anp6UGlKaDAvUHlNdnJvRGVseDFFMFp5SGhPUWM3bC8xMkh0UFgzRXl4?=
 =?utf-8?B?YncrN2VhQWlFbzJtamFXSkhVSnA5eEQ4bVV6VEk5TXk2Q1hJQXdROFo3WWxC?=
 =?utf-8?B?NUdVdlhzRDg5LzA1Nk5oQXYyU1NaaTVDSlJEak14ZHIyS3pGbUwxMU5ER2JO?=
 =?utf-8?B?U1J2c0xXN3JFbWxLOTMxeTRTVnV3ZjBhL2NKeDZocEtadmxUN2k2Rm1pdDM1?=
 =?utf-8?B?VUdodnJMcW5JZ0k4UUhia2V6K3BYUnJLejJ1bE5yc2Z4OHNUeWlxaU50cm9B?=
 =?utf-8?B?YUJhbGg0SFkzUk11TnQ1TDcyck1ROCtnajFydEJJRmJDc01RemNDemJyVkJz?=
 =?utf-8?B?UTNwQkFrdkMwSWNoRXNlQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzVUOVB5cnVKRW94dHE1ekUrTnZ1NjU1cjd2ZW10bHRrbnZ2NkVSd2hBMzRt?=
 =?utf-8?B?bE9WTUUzUlQxZElHSzNHUTZqOU9hU3JKV1ZuTXhkYUhBZlh6dlJlQmkvUHNx?=
 =?utf-8?B?Y3lLaGxPaFAxL3ZYZVQzRjdYeGFTbmdpMmFzSW90cWJ0NDZsMjFzWFV3MTFn?=
 =?utf-8?B?T01QNDdCQnZwODlzQjJ1MGVURldmQzVaU1IzZFpISGlpMGUrNFdUa3RMcmVB?=
 =?utf-8?B?L2NMdDRLVHFtKzRMQUY0NWJsU2dyUWNMaktIMW9hd3VMOEd1U2lTdDNZVlRZ?=
 =?utf-8?B?NXRTczFtd2premkybXZqcXZCUnRpTEFkN2tjaksxdnRSZUFHZ2UzTENsWi9F?=
 =?utf-8?B?U0ZHQlFRYnJ3ZDB6SlliaVc0T2FPc3pacTJ5OUU0RW9ZZWFOdFk5QVJzZ0pz?=
 =?utf-8?B?VzNxTHJZSE1WS1M5WEhDcGFmQlZ0aEI5d0dKMVkrcFZFaXkrM0NLL3VGTFlr?=
 =?utf-8?B?SC9wcmpLK0d3Q0w1dEJRVDRwTjROK0tmbC85ak5CVzRZMDArYys3TUd3dUta?=
 =?utf-8?B?UFI3Rmc2REFvT1NwdmIrYWtPdHpXOHhTMzNKS1dLelhSMUE1aFFiUmRDeGps?=
 =?utf-8?B?Wjg0cHpqZXdEZzNoVmpTZ0xkb29lcWtINkNxZzFhVjZnRWZqRmN0WC9CUG5m?=
 =?utf-8?B?TGNzVEFRaUt1WThYbmYxMC9YMlYxWlRpWk5XNUNPN0dwaTVxMVYvQ3lQeWZU?=
 =?utf-8?B?TUR4MjFIbVYwelRJbU1aSjBkaUZhaHVaM0NKZHFGeXllVXI0dzFnMFBQWDAy?=
 =?utf-8?B?ZzJESHVPTTA1M1hESlY4cjRMY1RydEszRldCMGMwaFNwVnczQWlTVUluQUN5?=
 =?utf-8?B?S3BJaDJESHhVenp3ZW0wNGhFbWQ5emhqNCtyMlFQMFJab3Q2elBUOEgrWjU2?=
 =?utf-8?B?MDNvcmliZHowcU9ETXc4Z3VZa3BxdDJ2Z3dsbGdGY0RUalptbStLcDhvU2xL?=
 =?utf-8?B?YU5LSU1qVXd3dk55TDNwcEVucXJIdy9pUWE2SGlkQXFYMEgxQWk1QmxEalBR?=
 =?utf-8?B?aTFlVm4wL2R1SHhaZkJiakE5a2JkUC9yeVVTVjlEWnZRZkpqWnBJRDZHUnZk?=
 =?utf-8?B?aGx2WG9kaWhCYXRORzFKYnpBdGE4TXE3eklTQU1FdEQ3akpaWVRLRW11MVZ0?=
 =?utf-8?B?YURhMzVkcldtWGJCL1Z3bS8wdktCTzdZWlZiM296eHdGN3FWYTJKMzFoS0J6?=
 =?utf-8?B?Qmd4Z0RDSEk2dmk5bndLdDZEcWdoemhiVjJWNGQ1ckZTR280eEJMVmlSbFBm?=
 =?utf-8?B?MS9oVkxSdHBhM3l6YTFFdHo3a1NrYUJZK293RHpQYXN3TzQ0d3N0UU1Tcm10?=
 =?utf-8?B?K3V1U2NEMnV3c2piNi9UNDRrL2lYdFJFRUVGRnR4YlN3Q0hOZG8wRDdTSSt0?=
 =?utf-8?B?em5hSURvb3JIbVg3bVpsY3BtTE5EYThGek5BZmU5STgvd3htbWVMQ3NibS9Q?=
 =?utf-8?B?bnlLSDZObkZvS09UazVURFU0ZTF1QTlHUVZWazg5YndoRklNZVlCLyszUHVD?=
 =?utf-8?B?ZDhuOFY5b0dlQTBMVTQzMHp1R2lvL3J0QlRQTGZGNmdZMHcwdERCcmRPVURN?=
 =?utf-8?B?KzFQL0RMMXcwVkFsZ055NCtnWXdNVzIwS2Rzc29RUldTTGw5YXlFT3ZlS0cy?=
 =?utf-8?B?dEFmcnQvYkdwTS9Ba2F1VHZET2lJQy93VCtYeHJlWUI4ZHh5Rk41c1ZXenhZ?=
 =?utf-8?B?ZWpiSEY0WDNPV0F0MWV2OHo4OFJxQ0pLRXA1Y3BFL3YwQU1wSzNuaTY4cmJh?=
 =?utf-8?B?M0dCTm5PbmNLeklQZG9zVDZyOEp6eXJLZjE2VE9rRFhicFl0L09aWTcyKzN0?=
 =?utf-8?B?Z1g1NklUQWlBSm9HNjc5UTA0NGpSVWdtZDE4VW53cFJpRnNMWHkvY0tweTgv?=
 =?utf-8?B?ZzJDVHM2cTBTcitKbzJWdTJTVEk5c3VlRzNRMG5CMW1Da2NkczVBNlhlZ0tI?=
 =?utf-8?B?aUlQL0hHM0NjQ3p5VmVXZE5Sd2pTLytmWmhTWXJuS2YvNDZTaDZ4RVI0ZTZS?=
 =?utf-8?B?NmRaOUUrZjFHZTg1eDdsOVM2OWRRUHpmaDRJSFNlTTVLcVlkMGplNFBUaGI5?=
 =?utf-8?B?c2w5SnBPeU44dnRpUXRFYVhaSzVEd2FVOGVjY21RUHJJTzBqQkNpeEZZVU9J?=
 =?utf-8?B?UVF5UHZoaGRWcUxJYzJTem9KWHFEejRuZmcvY1hvMXN0Z0E3ekEwNU84RS8x?=
 =?utf-8?B?Q1VHRTRMdlhMU1dDV3ZZa3dlc0R3c0dOK3BzTlBVK1U2d294eTVLemxSRFho?=
 =?utf-8?B?ckdkenJGeGF0aEo2elVNak1SQkdBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7de821-a3e4-4c40-e119-08dd3ca9c9d1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 19:03:29.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1IliDdZLgwlK+kBSKSo+vaGIXGCu2CpQpeCYi+ptcIdLOjsxHm5/w3/ceAXpG8eOStfEzHFTL1buXma9NFDvEk+3WG5YDK4Ee0yGfi9u0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8464

Hi Christian,

Actually, that commit is in upstream. 
https://git.kernel.org/pub/scm/network/connman/connman.git/log/vpn/plugins/wireguard.c 
- the date on the cherry-picked commits is the date of cherry picking (I 
guess I missed some option while doing this..) but the original commit 
is there submitted on 2020-07-31.

I also pushed the association state and most of the wireguard fixes I've 
done to the mailing list. Have fun testing and tell me if it works 
better, we can always improve it if something is still missing. There 
are few commits I held back as they could be the next patch set, because 
support for IPv4 and IPv6 addresses, and the route adding fixes are also 
quite large changes.

BR,
  - Jussi



On 1/23/25 13:35, Christian Hewitt wrote:
> Looking here: https://git.kernel.org/pub/scm/network/connman/connman.git/log/ I’m not finding "wireguard: Regular reresolve endpoint address” and the first page of log goes back to December ’23. Are we using the wrong upstream?
> 
> Christian
> 
>> On 23 Jan 2025, at 3:22 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>
>> Hi Christian,
>>
>> That is actually in upstream, all the commits regarding WireGuard before July 10, 2024 are taken from the latest upstream and the changes after that are new features.
>>
>> Well, the vpn.c changes do depend on having the ASSOCIATION state also for VPNs to be implemented, that was proposed in the RFC https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 as the state transitions depend on that bit. But it does not seem to be depending on the gateway.c/connection.c. Well, I can try to squeeze time to address the issues Daniel earlier raised on that RFC and push them to upstream, then make a big change on the vpn.c and wireguard.c.
>>
>> Br,
>> Jussi
>>
>>
>> On 1/23/25 13:12, Christian Hewitt wrote:
>>> You don't often get email from christianshewitt@gmail.com. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
>>> Ohh.. I would be VERY keen to see support for FQDN’s resolving to dynamic IP’s upstreamed so this looks interesting:
>>> https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972b866fdbd8bd
>>> Is that feature dependent on any other changes? (being lazy.. I didn’t read all the commits in that branch yet!).
>>> Christian
>>> On 23 Jan 2025, at 3:06 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>> Hello,
>>> Regarding WireGuard, I had to make a bunch of changes to the latest version of it to get it running properly on our fork (yes, we upgrade it slowly, now 1.38): https://github.com/sailfishos/connman/commits/master/connman/vpn
>>> But I haven't had time to figure out all that is needed for upstream to be sent first, like this RFC edit that was forgotten because of... "eastern winds blowing into our direction": https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>>> And then the connection.c was modified a lot (and renamed) and I'm not sure if these will work on top of that anymore. Mostly because we have features that may not have been compatible with latest upstream, like adding a support  for two different devices to be belonging into one service to facilitate CLAT support https://github.com/sailfishos/connman/commits/master/connman/src/connection.c etc. etc. etc.
>>> At some point I'll start pushing changes but not sure when I have time. Mostly they could be RFCs as the changes are big.
>>> BR,
>>> Jussi
>>> On 1/23/25 12:45, daniel antoine wrote:
>>> Hi
>>> I have opened a ticket for connman-vpn not working with wireguard  in
>>> April 2024. If you give me the patches I can test them
>>> Best regards
>>> Daniel
>>> Le mer. 22 janv. 2025 à 18:01, Grant Erickson
>>> <gerickson@nuovations.com> a écrit :
>>> On Jan 13, 2025, at 5:59 AM, Gabriel Sanches <gabriel.sanches@prevas.dk> wrote:
>>> I was testing connman's wireguard plugin and got a segmentation fault.
>>> Looking at the backtrace revealed that there are some typos in the `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 variables instead of ipv6 regarding vpn.
>>> I simply changed them to ipv6 and got it working.
>>> not related to the patch:
>>> I had to manually add ip route so the other devices could be pinged
>>> The plugin adds routes for the WireGuard.DNS configuration setting
>>> # ip route
>>> 1.1.1.1 dev wg0 scope link
>>> 8.8.8.8 dev wg0 scope link
>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>> 10.42.0.1 dev end1 scope link
>>> <vpn host ip> via 10.42.0.1 dev end1
>>> the missing route added manually:
>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>> an equivalent wireguard file adds it properly (using wg-quick)
>>> Is the plugin lacking some implementation?
>>> ---
>>> src/gateway.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>> diff --git a/src/gateway.c b/src/gateway.c
>>> index 16c87f83..b2c211e2 100644
>>> --- a/src/gateway.c
>>> +++ b/src/gateway.c
>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service *service,
>>>                                        is_gateway_config_vpn(
>>>                                                new_gateway->ipv4_config);
>>> -             is_vpn6 = do_ipv4 &&
>>> -                                     new_gateway->ipv4_config &&
>>> +             is_vpn6 = do_ipv6 &&
>>> +                                     new_gateway->ipv6_config &&
>>>                                        is_gateway_config_vpn(
>>> -                                             new_gateway->ipv4_config);
>>> +                                             new_gateway->ipv6_config);
>>>        } else {
>>>                if (do_ipv4 && new_gateway->ipv4_config)
>>> --
>>> 2.43.0
>>> Gabriel,
>>> Great catch on this copy-and-paste typo; thank you!
>>> Best,
>>> Grant
>>
> 

