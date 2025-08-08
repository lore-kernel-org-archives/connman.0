Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023085.outbound.protection.outlook.com [52.101.72.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B801DFF7
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656601; cv=fail; b=KxkJGOo8VputZ+PxwWE+Jo+8R6QC0UvX1s50ym/opBX5+fsv0X6kipNoPm1jKxU7vhwYhS6GR7FDGj27Rwt5VUAWR6n7Sk3u95w+JXzzz3hj4Pc9346olm0RrwH91FHWRLloUhSr00OEatGn8mQP20vm3ywflbG+BU7KO98jKFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656601; c=relaxed/simple;
	bh=Nl02/he6/XPr5rthac7RDqMhYW5PLJ6GJqzjX3f6byE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gIex5Sc83YKs2T/x5XZq8Clw2gdxq9MCxw69Y5vrlxpAsyBa9uwLMQHifNSUkoFkoVZIrsQtXKput4Dt2p0HqjmjhWLHr/VbMCEwihrz/ejaXyigqCu2yul0LV13rzFKVsMnFulXsXJqNUy607nvViBKoBEV8X9i48Zy2x7qD9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=ustTTZy+; arc=fail smtp.client-ip=52.101.72.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="ustTTZy+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzYy75StZLmo491xsvZMFkyBSkFGe6iNJtXiPuiorYnF8v7Xi2imlLd79bXzdAavsnTqGvZYbjAkZOiRHvupoHNiSmnCbIAqA0mD202jy+WuR6nWKU+s64o0Xn7WlSVj6sdGoKfPi9tKns6hA6Ngij1MUsR2pstthxkBnNx4qgxr6zdHcF2DLvSsihQsojk/+4WW512oNCrfQjXhZ7GdMpWMFpQZLKCxOam5vgOdc9uqQGtgBxQZTrhkRvfZzR+XSj5wtVoARtp83vDY7ubyGk+KHWO+M2wzFJ8JoS4iAbG/cOQfdsZDNIHFb1RXXhRwyR+9ppSfuqJIHlL/V78wug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd2UdiF8o7Bh8vAshj+7/g1AyWWaWRpMkj91MHrOeBA=;
 b=KyW/LKEknaedW6Mx1jvZNrqzlXkesRUy7a8nSn7GxXECqmZd1wfChgCz2aJjLxPq4VR4ekjC6RadJWUy3ONEoDRn/YnMZtxLSKsYQ3mAo6AlCOaXHTEnbofbN02xKaqGQ/0BdLDu7pP6jhEueACQc6ZJXUNKBtgAGbvOD65jFuU9SKeLR7Khzof4saqSxPRRwWz94JbV/TV7skadOWGNlvBjCAKI5oghvYYGD4EAIuxbNDY8cJwjVPmSJM77/Sq6JgObc4xicTOtFCjpO5Tz7Tdnglg7vtI48sKDx+LsI69bs9SSfwSPwTL29h1ComEej3w/C7RAyqwOx16IM2yY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd2UdiF8o7Bh8vAshj+7/g1AyWWaWRpMkj91MHrOeBA=;
 b=ustTTZy+aVHrgOrUGyQk8kMPh5BNcwDmQKz3NaY0GuKlUCQEwYeaV1xWZ8YuN0QRvMY61j1yunhkDHHHxGXIYaXRSCCy/oJySp1DKBv7/8qS3ZAcTncTejOStERwBCEa56nzAM7kJ4BbHL71swj3tJAsIkdFBCs9WQTBUmMUVs8VTAzxzGuidpge9m0AjIgzHUQzSJjdb7drhJNcLcYIvoyfc22OovGjQ0LtmpOtIpDqT8kp9G9uRyEIvAkVW02C82y27FzXQux1+0Vri4U8yruZfXmuRMPDvRwvj16frX6NqGZgquP7LDu9CM1VwHG38zCfzoI2Jj7mLz98MJeOpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by GV1PR06MB9465.eurprd06.prod.outlook.com (2603:10a6:150:1a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 12:36:32 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 12:36:32 +0000
Message-ID: <5be890a9-66d0-4475-b2a2-b881859f9aa7@jolla.com>
Date: Fri, 8 Aug 2025 15:36:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/45] vpn-util: Add wrappers for GResolv hostname lookup
 use
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-18-jussi.laakkonen@jolla.com>
 <c4b5a272-a47e-4644-8bc4-7647f6ed5d40@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <c4b5a272-a47e-4644-8bc4-7647f6ed5d40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0001A059.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::494) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|GV1PR06MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d09fca-65a8-42d7-5fef-08ddd67834cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blRJMit1cHV0ZE5JcFBuSEszQWNSMGZNbTZnMzJqTEJZMGpIT2xBME9wU1Ur?=
 =?utf-8?B?VVhFT20ybE5SR0k1Nkt3dW5vNnhTVytodnRiRjFBRElNQzQ0M3VlOXdMSGYv?=
 =?utf-8?B?NUxLL2FLVHdHdndUbmovQ2YyNG8vQk1iak5oalhjb2xkOGREcDFmcnpUdzBu?=
 =?utf-8?B?ZklQT0xPY1d6Y2VOZlkrbUQzWGRJUC9Jc1JINVRmMVpwUERKNk83aWhpUXM1?=
 =?utf-8?B?bExDSFNobldHWEwzMnJacEx6b3NWN0E2NGI0ZVpRUjdPcVFtUmFrdVFncEhG?=
 =?utf-8?B?aGNqRlBkSloyOFk1VjBTalZyT3RCMjUvZGR3cVM4S3VrMWNHbDYzQWRKMjFj?=
 =?utf-8?B?djEyODhvM1NsdnNEMm5FakJHM0txL2hEKytWZE9DS2w4NzBkK2VOeTdQWUdC?=
 =?utf-8?B?bUF6aEE1WnA3SlBrb0M3WGhiajRxa3U5S29pTk4xam56VzVQd1NteUpzeXVD?=
 =?utf-8?B?cmVtSG5wQmxHcHc3NDRrNE5xRGhReE16Wm9VZkF5UWxJMXNiOFVsM01DUDU0?=
 =?utf-8?B?N3ZiRko5MER3T1lHbk1RSkJLMlFtNnRPZ1JVY3lMSFNjRmZ0RHNaclZXM0or?=
 =?utf-8?B?RDZJeWJyQSsrQU9lT1VUM0FtU1FMZUtWWVFFWVRHbVJXazd0Y1k4SjBIQXdD?=
 =?utf-8?B?aHBZMkZBUnBZMHYyNktKU2ZZY3JTRDc4Q3JDWE1xN0xnbHVTS2VKRGh4eHNV?=
 =?utf-8?B?bDgvSHlET3Q5NWRUN0VvK0JXcFUxMVQ1Y0JkdWpsVk9ad2VGbVBVMFYwampk?=
 =?utf-8?B?eFNOWW5USm43R3JWZFE3aTNVdC8yV0RrdzFhdEkzMXBaQkQxdTAwaitQeUZy?=
 =?utf-8?B?Wk0yK29Oa0xUNUJlcmxkUlNHZ2dCQ202UFdrd2JmMjd5dUs5d3h3ODBxa3hB?=
 =?utf-8?B?L2gvMEV2TVBDeHViRXNwYnViUzFwV0ZselpEalByTTBxeEJNQ1djS2ZkdWUx?=
 =?utf-8?B?WS82N21RcXNMZ0pwMC94N1VkeXFtN3p6dkdQOVRGR3NOaTNYa1oycS9LSk05?=
 =?utf-8?B?d3VRS1E4WWYyLzMxWXNsVDdjZjdkSGVBZXVpWjRVRTltRi8rcW5lS1RhZHc2?=
 =?utf-8?B?REVBTHdBVWIwTHh1UUc0N3RMS0ZrdUpFMXE4L2ptVnlEc2pLcWtoWkhjTEwy?=
 =?utf-8?B?aHBZYWtxdlhHYnVUOVFMMXJmbjM0UERQRG1ZQVh3dW5XUmJrdkswOThHeEUr?=
 =?utf-8?B?T0VFa09DeU01R0ZQZTI5NkJFTXFIdWwzZG1ZUjNWN1NPSHZGODBzVFVMZU16?=
 =?utf-8?B?UUNobVhCRVlabTJJUnhiU3dmQlRuVnFzZDBvUHVZdFp1MDJMMDQ5ME5vdTV0?=
 =?utf-8?B?UnJ6WlBrOGJ2cFJaNE5yYW1NK2lYRGVYcTI3enlnMEFIWDJyWUJ4RTZxYWVQ?=
 =?utf-8?B?cVZSbnVGYzhueHZQWWJ6dmYweU5MZkR6dFdJTEk0WDhoQlVibHFJcmJJc2Rm?=
 =?utf-8?B?OUlaQXMzRWh1Vzl5UEpid21CMFBESG42R1NQSVRxM3RyaUN3N29HUlc4M1Y0?=
 =?utf-8?B?a0Q4QmQrS0x1eWQ1elljT3V1QU1zY2N5OFpqZG9lMzYybWhWRjlSZjVNNFhO?=
 =?utf-8?B?em4yaEtKS3NrV1IzOERmZjZuUjAyMm5BUjFDOEEzWHVnNUNTTVFEZEo1SGRG?=
 =?utf-8?B?ZXk0Mmg0Z0R4a255dFRoMU1tdDZCcFNiRDRrTzc0Q2h4WG56cnlrQlpURzRP?=
 =?utf-8?B?dENMWE53amhuQXYwVzVidHVNaGg2cXREeHQ3cnZQTFRMZGMwNDFiZnFzNlZM?=
 =?utf-8?B?Um9VY3JocEwvMUxSenRkTEtheTBwRldnLzl1K3A1b2VOR1l0T3BVbmJBVE03?=
 =?utf-8?B?cFNPbkJiUjVCL2ZTS2UwY0ZreDJBRHlucXJSSGYyemtKc0ZaMXJzRExvYlVw?=
 =?utf-8?B?WVhzT3E3Wk9EaGZLT3F1a01XczM1NWVnR0ZiWkUzWmxGZS9yaUJTV0hzUlgv?=
 =?utf-8?Q?MRiGkivNPp8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVk0WmF0QVNzSUtHWFdjejdhb3czRXY4Z1BnTXROMzFmT3JmbGd2eld3Zk1Q?=
 =?utf-8?B?VHRjRHpOSWxkc0lzWWpLUUxTZG44VHg2NzhHYjkxTkk3N2lvSjdrSWdVbG1y?=
 =?utf-8?B?VEZhNlhKekJkNDl5UndiOCtzZE5kKytrMk4rMkxMSklxdWtxUUtTT2NuNGtr?=
 =?utf-8?B?T2UzK3Jaa0YzSTU1ZmpiVk9GNHBhQkZ4OEJKVG1McGtnb21GK01aeTQxdEpV?=
 =?utf-8?B?TFk5RkFKNGpBYm1MejNRSWtsVWVlT21XL0dFeDB5cjJzeTBJc2FaYmpCN2tC?=
 =?utf-8?B?RkcrVFMrRmwyMlVTeGpHSVRPTEFrMjJsRWJzQTM5d2ljVUtoNGFRS09rRXMw?=
 =?utf-8?B?WDhvUytMcE9VUTVvWlg3cHJVZHZIMmpxVmxuWjlSWVpObVB0SDhrcmgxZjNL?=
 =?utf-8?B?eTRWSEtTQnUwaGxVM05pNjFlRkREeGVPbEJSb2ZubEoyajFKMDhwZHFhc3FX?=
 =?utf-8?B?dE5Kc2E3elA2L0tLTkJzMzdzYW9aSk1YTE9tc0VKak9IZ3UxVXdPS204REhl?=
 =?utf-8?B?OGpQRWxReS81OTNiYnZ4RXRWM3hGbkl1MWFaRmk0LzFNTFdmY21kT0JIaFV4?=
 =?utf-8?B?VkRZc2VrbGlmdHpCT2ZFeWsrSk1SeElGNStUaytRTm5aSVN5NWo5djRIRjNU?=
 =?utf-8?B?Z3VDTVllSVc0RmJzeExhTHV2b3lJRHlEaWFEUHhVWGhKUW9zM3dNZEJuOVNG?=
 =?utf-8?B?VDFhQVllaVZIZXJHa3A5dDZnRUxiVHFQc3VvanNnRnZkYzdscSsyNWZma2Z1?=
 =?utf-8?B?NFBpWVl1Q3hpSUFSbWJlVDI2c08zVlFBV1JlRForSVdDMnYwd2ttQm9NWXNW?=
 =?utf-8?B?Yk5KWkFLdS9Gci9vcjljU0wvSzU5NVJ2YlFlcHEwSjA3ZUU5cUE3Sm9ibGph?=
 =?utf-8?B?alhybXlzYVVMY21OK2loZFVScFJkYmFzTDVvbWZHRnJ4c0I0SGRMbmZydjVV?=
 =?utf-8?B?aUpzb3hDdE5nMm44Mk5tc1AzNFRCVkRLL2V5WkJwZVVtamMydXYrdStCVlBj?=
 =?utf-8?B?OXpKRDRQVHVNMEN3VlNFUmJjRU1hRGk5VW9RYjBlSzlTc3VKeWtKN1VPeE83?=
 =?utf-8?B?RTJPdkFFN0d2aXVxcSt4cVhMQ3ljc2xzT0JhTDYvM0xXWEJpbE5XVVd4b1Vo?=
 =?utf-8?B?YjhQa0VJcWswZlNpY2pVTy9mVEV1RGJjdlh4L3FxRGZrTnk3V0FjZXRhYzhr?=
 =?utf-8?B?UE5mbGgwUjdrUk1qd2MyM2w0eWNRUng1Z1MxMHptLzI0M280eUk0OXF0RU9i?=
 =?utf-8?B?MlAyclc2QUxtVVRUNDQ4c3Z5akl0SDc1RE1VdGFGV3BnT1M5N1BGSW8vQlZZ?=
 =?utf-8?B?SFF4dndUdEREUzNORTNNakc1QUN6OXE5RlFtQjlxeWR5aDdnUGJHNC96OFNp?=
 =?utf-8?B?MW5JSGhXYmhQMWt2enhNTTlHdUpiZzcvN1Y1TFM4YkZDb1VmeHBtMng0anVJ?=
 =?utf-8?B?ZDN3cXI0OHFHb1dwZ0VqOW1SdkpDYnJJSmV6VDRMaUd4clRaY0ZSQ3VlNnBv?=
 =?utf-8?B?UU0xVE1GQjEyQTJ1Y093VlpieWo0YkNDYmxOUGxMMG9ZN2RkN0hSS1RUZWdm?=
 =?utf-8?B?UFF5cmw5TzBBdmttei9odXZFY0o5anpIZXBzbTRBWlpxSlAyWGJ2dmU0QTdX?=
 =?utf-8?B?bkk1TmpFVXBwWmRJZ3gvVU0weDQzL3h1Z0Y3bHNORE9KRkhNRCs1QzM5YTJK?=
 =?utf-8?B?ckd2UXg3VlU5bDl3YUhidEg0dmZGR2wxRXlTWHhuQXlIT2hTcVBGbWxrWVJo?=
 =?utf-8?B?NTU4K1ZxYjlxd2FCNW5GM3FSaVlNdzlXV056LzRKckJmN3p4dnlFL2k1NERt?=
 =?utf-8?B?T29wbTBhbzhXcUg1dkFXNXdmWU5RTjMvckJnNXNXSGhBREpINGcrd3hkWmYv?=
 =?utf-8?B?NWpoR1pWQ01QREJHOHMrUXRFMmhSSFRYcHd3VlpmNHdqZVBPYzJRL1pjWE1n?=
 =?utf-8?B?d0txL0dBLzhEU1RFOEd3bmpockV0RFZtNFl1azl3aXQ4SXJ6UjdPOGpiTEtw?=
 =?utf-8?B?SzNBTi8va3ZybHd2Q3pkMFNqME5NR3E5eTRrSXB0SDE0UVYxKzNLTnQ2Wm9j?=
 =?utf-8?B?MVgxV01yRU84UzFmYjdJZzE0enA5OENpTEdKc0NCN3puV09nMVpqeTZPNGpv?=
 =?utf-8?B?bVdBelZyMkdVaC9wYVBKYlI5OWlpYkNrRFlBaS9JcThld0tNLzNaT3VJU2RI?=
 =?utf-8?B?ckRicEI0bW14M0RsOWNvUVVLSXQrbGlXdDFadWJ4aUQ5YVBnR2JZdTZoNEk1?=
 =?utf-8?B?RjE2cE4vb0NNSW1jYlc1QTRzQ3VBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d09fca-65a8-42d7-5fef-08ddd67834cf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:36:32.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn06Byn4quhaZfiO7uLPHKThCBlnffKtUZKUP0n85CyI1g9Lgapb6xFO6wFSiBkkZ5zppSFWQVrMTpxVeAt9iEgIoEkFpTfQZIjlfwkaoho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9465

Hi Denis,

On 8/4/25 17:39, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
>> To avoid linking GResolv with every VPN plugin that uses it, add wrappers
>> for the required calls in VPN utils.
> 
> This may need a bit more explanation?  You're still using GResolv types 
> in these functions?  Why can't g_resolv_ be used instead?

I can amend the commit message on this. The issue is that VPN plugins 
can be either builtin, external (or out of code tree plugins), so making 
this wrapper is a bit more straightforward by linking vpnd only with 
gresolv and having the plugins not to care about it?

> 
>> ---
>>   vpn/vpn-util.c | 30 ++++++++++++++++++++++++++++++
>>   vpn/vpn.h      | 10 ++++++++++
>>   2 files changed, 40 insertions(+)
>>
> 
> Regards,
> -Denis

BR,
  Jussi

