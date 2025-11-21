Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020118.outbound.protection.outlook.com [52.101.69.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938D2C029D
	for <connman@lists.linux.dev>; Fri, 21 Nov 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739413; cv=fail; b=K7aPOC8ofOgS1c1CSs0kSNDx8FHBmL6+DvdfUrQDIm98vXmUXDBWgAnu0qhxznl3l9Zo4OTNuiFfkIFVp0vjb6IUHktz8LI7OqW6wDqqCw6cgVaK0UqzASbUbjkRTb2kq30CNfiFiAhIkdsjVxaLZ0PnwuAJGObyB7TRxymzR/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739413; c=relaxed/simple;
	bh=h94eOJw8fX9ZceI4VkTM9WkUtsoct6cN154YQreypUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f/osbRCXph1GkDe+gB61Nbn2gbKvfhLyOuZ3XDTb6x6ZM+VmoG3Q8sz43alHfaYhYBKdoH/3PCpLOuRQD7BdU0Ht2OafZKB5euzr0EM2yaFut+so/EraqKXO67GDX1dK+hTSOAgbnWCK8sMs2OyqOy1ocTjbSuHM6yax6yy4r4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=B7B4Isju; arc=fail smtp.client-ip=52.101.69.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="B7B4Isju"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNYp8BqVqv5VMijIKp4YoxnGMVIyRnnHA7P3Fo3OxbTrEgCUE5c+xuzdnqybBtEP9Icyw480NAglV10HyutdwmqlCss6aye+k0tloBEcha5S2bnkYRVyMDm9dkE3KluUSYb7d5eQnEm4tfD/H9V9+ZTegg+tyFbp4LAMj818LTIJOPnMJbtEcAnJHI6ZdWtt0U7D4rl5c6UmDqGl+lIlrSx8tYRW7otBdnoUrmFzxgCfwO9kJnW89Fd+MKLwb1VjrNI3iN5rLjxn/9UhKYSkHoBWXiAaHaHs/4sHVWftNOMQ/7v0YgztGsIZrlEylqCKvWGxgUN35Z40p3WMUY1UPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmpqIEurVjxIa/uwVReOtfFgqdOpPOKE2ejY7gZKrSg=;
 b=itXIcmo5DB2N6es631oLivNZmy9QQUziVpWoVfLSmlZxKNoZxEcTb1PH7drIGq+24TPAT9b5g0YzlbECi3IabknGh/28O4YaWtefDqoK37JoqNWL6bBbWpKvaJ+1OzkSsnfCtVF6pLfpIQbdAYF1e43XdRy2FOUWK+H5Kszw4R+g5F5mSAHINT6Yd0fz1lnHoLZz6DKFnSbSO2AYTYAL6SmYgcPzxc22z8yYW4iXfm6CoJCs7KFFq15BQC8PR4p/mGLG8GuUX/1o4c6FTR/G4J1rou+DXZ1VazWocDCemTXxxzVHX03/9Y9Lx2NNNFuyfcMzWuyoyKEQewhQCeltOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmpqIEurVjxIa/uwVReOtfFgqdOpPOKE2ejY7gZKrSg=;
 b=B7B4IsjuBrQPRZWPB1KqSxs0QkFT6K6ny2V/2Rct1fMbeDIsyjIbwwrqLyViRVS5n3Vtgd1OiwkTo3HSF3ePOFyTvjyAOghi1O0K+LY8uwLiSh8AVIqIVHqP4v7J7RZlFqWZachaYXoRjLo8bCNav0CAS0nqhBr1jbPMxMYWQb2UlGe4b+Hg5DtetO6tZDRxUNbMc2Wwzdj68NZW7rdCjqke4yJjmj4s3/3d5vLC+jfUb6qs+A3cMBtJEkMbMoAl/NFor8nhMILkKW/cgivGcDFRZpi+mCPOzbY3WS6B9ZpCNGg3ONPMXr6Ak9WQQYdBWCbX+YdNVmbqQBM8z471mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from AS8PR06MB8167.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::13)
 by AS8PR06MB7335.eurprd06.prod.outlook.com (2603:10a6:20b:250::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 15:36:47 +0000
Received: from AS8PR06MB8167.eurprd06.prod.outlook.com
 ([fe80::910e:5917:aa5d:79c2]) by AS8PR06MB8167.eurprd06.prod.outlook.com
 ([fe80::910e:5917:aa5d:79c2%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 15:36:47 +0000
Message-ID: <8a52a2f7-e406-42e8-a37a-440e0de2d9e0@jolla.com>
Date: Fri, 21 Nov 2025 17:36:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/42] VPN association state, dual IP support and WG
 fixes
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: connman@lists.linux.dev
References: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
 <7493D021-C582-4AF6-8A8F-679FBF4E8876@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <7493D021-C582-4AF6-8A8F-679FBF4E8876@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0437.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::7) To AS8PR06MB8167.eurprd06.prod.outlook.com
 (2603:10a6:20b:3c1::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR06MB8167:EE_|AS8PR06MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bd6306-a7ab-4d19-534c-08de2913c7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjE5b0pWOWpPR1VzMENpWHZ3M3Rna0plYkxsc014RG92OUs0eFlqamZtdXg4?=
 =?utf-8?B?cjI0T1JQNW9rTHJCSXRPS1pOUXRGTVpxUk9pQzR0UDMvTEVaUGkrb0hrVlkz?=
 =?utf-8?B?YlE0K2RkdXhvZndSNmZ2YW5oOGU2NzBCajYwTGNKWGJOcWhjSmhIbFg0blVP?=
 =?utf-8?B?dUNLZmFtVjRaa3ZVUmFOWDQvdmJnSmNhMTlWQnF1SllSMXZpaUFpOVcvazNI?=
 =?utf-8?B?Y2M0dlBiVTdZdzVpN2RaWllOeTNIUy9PZUtGVkVvQnRIZWtjWGlRelpINnBP?=
 =?utf-8?B?MWxNUWNyZ3hDSUh5czRZZXhWNFNFRWpEM1NqVXRHQTBKalNyTW1GSHFmdWl6?=
 =?utf-8?B?Zk9lUTh3MDV2eHVOYmwyM2g4T29hdGljekxYYk1GZWxGOEdsaDl4eWFmTG9X?=
 =?utf-8?B?ZTdOMGswMzd4RER4M2ZmWExJZDdDdGZrMk0xdHlQRjJuZmJBdUZXMGl1Y3Ur?=
 =?utf-8?B?bkkyaFFPRVFsMXFyTTgzY3RjK09tQ0hQWVY0THFJR0J3aE9WWFJjV2pIZDFS?=
 =?utf-8?B?YWpCUlNkTWtrb1VzQ3NkeUd1bGdzNSt5YkIrQUtDT3BKSUM2dndlQTJqbTBu?=
 =?utf-8?B?aWgvN3RwRHd0U0RTWnRNTTlGYmtFTkJXMGNENzBZbTc5c1JMeGxzY3N0ajY1?=
 =?utf-8?B?aklzdDJiSWl5T3psVmJmdTkwc3Fuc28ybFhIcENwWm5GUHhZTTdjelNhYUhY?=
 =?utf-8?B?dG5WMHp0WGZwTW5GZ2lZaW1QRVpmdWNTRmZ6VjhXYTM5ZFZ0cm8yc0dMT2Q4?=
 =?utf-8?B?Z29vVXV0NG1tT21yUzhUTXozQklpQjErcjBMb1lsQ3pRbFIyQ2crbmIxeGtL?=
 =?utf-8?B?ZkFrNjlQQjJ6Rm5CVGxRRFhscXczTTJuUmpDRktXQ0hCeGNhQk9ldHRFcTA0?=
 =?utf-8?B?WlJEYjJlUURZaFBjNmJHMmJobnM0b2gzN3dhT2Z1djhFb0w1QkFnQUdlYll6?=
 =?utf-8?B?anptZDdPeXZNNkRaVW81OTRxb1lmdkJ2ZmFMVlpPYTFQLy9JYWMwYUR0eVhu?=
 =?utf-8?B?RVhQTkNsMHNCSlZ2L2lDWTJEQndMWHhLWmZ1VzBLdjhEOXRRMkR3b0syRjBk?=
 =?utf-8?B?cStlcW10L1lTNGhsWkxUc1dMa3RUc1UxamNVci9zQXFDRXBjVDhJak1qOTFB?=
 =?utf-8?B?dWVFdnVYK0RYb0JURHVHQkpuL2ZUWmppQ0RnMTBVN3RyazV3QkVZeVZIVVNU?=
 =?utf-8?B?VG9Md2xrc1RibStKQVd3eEFkT1RSZm9DSXhRUklCUUlyRUdUSDJIYUlkSnhV?=
 =?utf-8?B?c1kzZDdMSmg0dCtGVE5yeGtPQ1ZXVkpZTnZTK3VIdkVQek5EK1p1VzFLUHE4?=
 =?utf-8?B?NEVreWdEUnFnMXQ2c2llTzZiaFZXYWFHMG5HWjljOGtmczJkVHIwcm00M3BE?=
 =?utf-8?B?WDFRODFHclF0Zitjd2hxeXhZbS9ZS3pjZTZ1RHR3TmF5YjVzOU8xM2IwSHpu?=
 =?utf-8?B?OUtMVXlpamhUZUdGYnJxMDU4a0NpQzJ6ZzQyYm1NYnZwMitCdnlMUTdtV1k3?=
 =?utf-8?B?RVJyNkdBZm5JTHNxcHk4SStBYms4N2NjK0w2VkN3MUxqSFR0VXpKaGVacWlx?=
 =?utf-8?B?ejhRZWxQd1RDOWJEa0pOd2M3bDRWYmhpVURXbmVSOGltMFJxR0J3ckZiTk5H?=
 =?utf-8?B?TWh6amdnYWJSZXY4by9pQWV6QVNsVGtNMUJ4MDVBZnp6OWhrOVIyT3dSWWp4?=
 =?utf-8?B?ZkViN1dWZlMxNWNsZTFjZHh3ZXl3RkRkSTFiODVjd0xqenI1cTlaRGFiaGl5?=
 =?utf-8?B?ZEdrVFFvaVl4cVlMTU9RbEJvT3k3T0Rhd0dHSFJ4L0drZWMyZVJyaHhsL0Z4?=
 =?utf-8?B?QjdXVUlYeklvc0lSYWhzc3BLaHhhdTJGVUx2UEFoKzBjK0RvaVVqeTJLeld5?=
 =?utf-8?B?eW1aR3cxdmVwSXRiZndPYjVZeXBsK0t1ZDNDK1NrWi9seEhxQW9jazRlV0xZ?=
 =?utf-8?Q?uG148bHtA7PI/jAtGWkQ4wtQekT5tl20?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB8167.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ellXTGtYaFZoVlhNQ0ZGWmRjNkEzR3lYSmc1NTdZUHhUcVN4S1o2U0VidEV0?=
 =?utf-8?B?SU44Q3ZzUEp4Rk1PMHRRczlQTmJwOXN2NUQzVlZIWFNJSEMwcWwxYmtVd2lx?=
 =?utf-8?B?eFlETDZXZ0xUS3lKVG0vRm9lcTY4UUJ2YW1DT3FkUWwzMGo2VmZ5bXRrUVhB?=
 =?utf-8?B?U21ndnZsMDFRNUdSQ3MzUlJHd2RuUmxCMVR0TGtYelhjYnQraTlrN3VkNGlT?=
 =?utf-8?B?TXZOaS9EcG5ra1FaTXdrclZXQkN0ZUNxeE5YZTgvcnFFN0VkaGhUcnpNcy8y?=
 =?utf-8?B?RFRvenAycEMycUxrMitvWlFvak8wVktEZXRPOHdLN29Hc3RrcGNKQjFPU3E4?=
 =?utf-8?B?ckpsOW4vK1p1SGZGbHJqK1ZQV25teGZWV3FhRHdXUHZLMFFuOWdWdUNRTCtC?=
 =?utf-8?B?TGR3cDNTakJrb1NMMDNILyttQUNFcHpjRlV3VkFZd0puSVNadFBvR2ZveDVi?=
 =?utf-8?B?WVN4eURvWThRaEgzMmZzeDlLbnV5UURnS0xDNW5BNWxnbWN1QWV4Sy94TXFr?=
 =?utf-8?B?LzY2emJOTy9Jek1XeWgxdzMxQUNNamd1Y3lBUEhQanhRZjBIdGV6L3oxY0xM?=
 =?utf-8?B?TmFYVGVTdWl0OS9QclFVNGZmcVlsT3VJakdUMkpldWZtb1kwOFFIWnpDVmh2?=
 =?utf-8?B?VHVEL2tGK3F0VFNhT3FPc05ocGF2S0FCMjNsdFNONmlPdFBzLzNuWnZIeUlL?=
 =?utf-8?B?akV5SmdWWGdyaVdPcGcwclg5S0VMdWI4WlkvWGQ2NlFXMlFXOUplclZEbjQr?=
 =?utf-8?B?Y1YveC8zbWJJYjFNZk5xL2xGcXVjczZTUXgxQjV2V01wTWkydEw3Y3FMMDho?=
 =?utf-8?B?clZPM3Rxb0NsSDB6Qk1TWC9vdlFkcitJd3NBVUp2ZWRwZXQrZzNDV3h4YWVE?=
 =?utf-8?B?U3E2bUhyb1ptSy9KNjVwNUt3dm5sRmdSbGtXUWI4TmtaVTFHRmxXU0x1SkpO?=
 =?utf-8?B?L2tvRmxCQSs4Wk5xMGlxcTBZWHJsTjkxemxFeWNNN0xwYUMxU2ZYMStDdkZY?=
 =?utf-8?B?V3JjUVNqWjVpcjY4ZmNZYzQwMmg0cm95OE1oTmFrR2hyU2o3U1BzWGViaEdS?=
 =?utf-8?B?cVZVMzYzSS9ZSVhPdENTN3dYWExMMm5TNFczYWxYS1NkelhVcllQYjdOaG9o?=
 =?utf-8?B?dWNwM3QwemRrNnZwSkpENit0a0s4SlMrNExhMWdIVjNLQm5YVEZOV0xaSHN1?=
 =?utf-8?B?ZW93dFNRQVlMOVdnZDE1S1Z6bkRVQnk2bTF6Z0xnYWxxL0d2blRTcWJ3anFJ?=
 =?utf-8?B?STNoSzFidTY2VkRQRVRaa1NnZWNSeG05TTBMUTZqcmJhU3lTN1ZuQ3JMWGly?=
 =?utf-8?B?aEF5YnhFem1XMFYraDRpL0JhTEZPYjMrUE0vUUtidmRUSGh4eXhBRzBUVHQw?=
 =?utf-8?B?Z3VYa2ZNMDFRRTl4ZDlSUXp2SEh4YzdtcmkxNlp6dHhKczFrUHFXaTg3NDMz?=
 =?utf-8?B?ZFFmVDlHZ2hVUzkvaVlENFdJank1YlFiaUgydUFVU2tWWUJ0czhSZzlNWkNJ?=
 =?utf-8?B?aFN3dWEvc056Wmk0S0d5RytLeWprRy9MRXRFZmxEd2dpaDNLWnE0MzEzckxN?=
 =?utf-8?B?MGNUSDZHd2MzNldkRkFjZDZ2NDQzTTZ0WUZVN2JNSTkwSlpmRlpEcFdvK05T?=
 =?utf-8?B?MHZwcXVjWHdCK09nWVRtdGRySWNwVXBDMjJtU0ZZYlg0emdJVlAyQytKMlor?=
 =?utf-8?B?TGFSRjlhRVpiWTRCWW1KcmJ1eHRhYVRYc0dkQm52Rlk2Z2FIRXBSS2FwM2g3?=
 =?utf-8?B?bWVMRzljZUVFM1czSlZaWjlObmgyY3VBeTZwVTA5L25oYlJja0Z4UU9EV1o5?=
 =?utf-8?B?ZGNJMzhMSXFaODZnZzRNa1Z0RzNaSjRXOW1ycWVCOGo1b2JHMk5mYjZvMElP?=
 =?utf-8?B?NUlieTY4dk5mZnVCSWJsUlpwcVBpSzhCdDhXNzA2RitOT2M2Qm85NWxmNEdF?=
 =?utf-8?B?YlNLRnBVUm9sZlI4M0duclpHZE5wQ0dvVExYWjA3cjM0WG9EZGJBK3BESm4v?=
 =?utf-8?B?cTdDN1oyeDhzbms0Z0tBTmsxSlY2NlhkeWFQTUdyQlRGcDlHOVJxaVR5aXpn?=
 =?utf-8?B?V2k4cDlUWC9hN2VVaG9lVm9aOWlhYWJRZ1p3bmdpaGF6L2YzQmRXT0QvM1pK?=
 =?utf-8?B?VWFjd0FtZU90Q2FOTDA4VDVRMEVaWVpFc0FWbnhEanJkWXVMaHM5NTI0M3VN?=
 =?utf-8?B?TTlmdWZsU1o2WU9DQjgzc3RyK2E0TTZ4WVpDMXhTTXA2SzdFUVFvdThuTnBw?=
 =?utf-8?B?YnBsM0JlT29MWDVsdEdYaXM1eXJBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bd6306-a7ab-4d19-534c-08de2913c7f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB8167.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:36:47.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgw1JsR+1Q3XKlnOjP//xt8Sn6SbkzhVbaNkoWyMqIYEQSQKJv66plK3xzgS9N5vKFAdQ5Rj5v0nBMSEMmzd6d5qubJzo0pLOGGnyhfnFOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7335

Hi Christian and all,


On 10/29/25 3:40 AM, Christian Hewitt wrote:
>> On 13 Aug 2025, at 7:01 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>
>> This patch set (1) adds the association state also for the VPNs, (2) implements
>> dual IP support for VPNs and (3) contains fixes for Wireguard address,
>> especially for FQDN handling. This is a combination of all three improvements
>> for the sake of testing them together.
> 
> [snip]
> 
> Patch 21/42 #includes both inet.h and arpa/inet.h; the former results in a
> compile error. This change resolves it:

Oops, I guess this was missed in refactoring. Good catch, I just sent a 
v3 fixing this.

> 
> diff --git a/src/shared/util.h b/src/shared/util.h
> index baaca31e..30630f93 100644
> --- a/src/shared/util.h
> +++ b/src/shared/util.h
> @@ -25,7 +25,6 @@
>     #include <glib.h>
>   #include <stdbool.h>
> -#include <inet.h>
>   #include <arpa/inet.h>
>     typedef void (*util_debug_func_t)(const char *str, void *user_data);
> 
> With that nit solved I was running the series for several months with
> no issues. However the latest ConnMan release now gives me connection
> problems and although patches still compile I had to revert them. I’ve
> not yet had time to bisect and find the breaking change.
> 
Hm, I can at some point try to check it myself when time allows. Good to 
know this, might it be my change or some change merged in master that 
causes this? And may I ask what kind of connection problems you are facing?

Cheers,
  Jussi

