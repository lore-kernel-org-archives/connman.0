Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021128.outbound.protection.outlook.com [52.101.70.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7D381AF
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632930; cv=fail; b=LlIsigV3sqAzJFjpec7HMna65/pCDPW7hA3t6igjWXagyzrBdTHO+DIJaAOV+8qMbPIy/SwgB8KpwgincH5v7neS6u3/N7IoNvRsaq9hPjtGP0aSEhJ9QdmibbTyMis9xODRa9o6Gzw5Dvsj76cgy2B4hbD9aAJsVcTKs/FFyPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632930; c=relaxed/simple;
	bh=Rm/MV8x8eGo8qpd7yoO7FPSa5EYgkII4CyMTdZ2cXAY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oL9cWGB8C+xyvI5w6U67R+hYlCGniYot2NOg2LwafuR79eqzZi4zi3gZ6zwhxSptocVSDAl1+/5EghywGSsNy9wBHa++cZ2mGq8M+i0JL+SRyTKZQ7H8x5Z3QJp3MnpGfyVtJ2jgcCgKo4A+BBw6nUdeFMYFvh2TfRrmsHg354Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=GtiPPtb2; arc=fail smtp.client-ip=52.101.70.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="GtiPPtb2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QemymG96AtQDkcHRlioL2olhBi4gGvO4ZAagtRbU9aaQO1Xm5Weu5xaEdu97efiStR2hWozQ5KVXQIhae79Rotbwj6Iyup8m+KyL1L16wAKQIVNc4qLj2Bt4iGYKdqHLYegnwmq7SIsywGrWdThtlF6TgDyUPbYvMcrRhCjnWLHtwSwVlq+M2Z1BDyAh4Yu3w8gNSS33I8BYDI6KDXTHwAgICdVOOnon8hABG6xrLY3ClMfQz55rZpFMA7/sU79LzWsZlVuAzr0dg0qbRYN9VX3suS4i48Jxxmv/C7Mu/wsZa6lTS64s7h59UXDt7DMI52ZUfFxN7lvVWa5OoKS7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4LQkSHVs1MyjRMMJr6Ip42BH5W8W5YkxOzyEUSg+Tw=;
 b=v9kpvdeCEJ1S9/Us8KWw3SVUMlNSc8VIe0gwZyXuIUP4f/FQMZEnF0yQmOgNzq5t30hXbyLw848wv84NOWjnX+OV7KkpAjRew/HreTapkcBLmikceAxrQIVVCOqtKSK9b+9Pk93XVw0yvj0xrxHeXxnHd+pmlXLiSSpoRX93VdcSOOEmP62f/ILNsvVvn+2CVuSWjUI60Sk+chKHQEkDNTEAJ41z8J2Jxd9jQb+gXvYR1MMdbPZTup6ZMKvOxgOysTNtWPq2F1GUkH3hASE/buOg+bU+biKHdScPSdEUJkupc+V7zPn/4AEF2GHouqqxKIEZWO+rjcBYsjhlpcZfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4LQkSHVs1MyjRMMJr6Ip42BH5W8W5YkxOzyEUSg+Tw=;
 b=GtiPPtb27rBQFyrZKB7aszqqEKtStgZOpHY8YIXXI68lfEXB9NHpr/TJe8twktVHk5xYkUTGWP9eVxA3HygYu/XkCP6E52uTlXSsjFun5k2XVjk1pWzdlTKL32cyQ7wjX/04kz9/1JMOVUXzHhX/OPyL6M1HzQYBmhFhZHmuQgxZEa90+L0aJZUM8OuDhnHLt8kZN5aJ7oIK05MhTqlic/B6zu3/EkIAj/4HeGza40mjrKUm6GElCkKNEcpvXX+pMPuDQSZ8A+6fpJCfZztPDjkl/geqh3ypJHqvCnLxbOvF7r9NuzxgyIzBdCqK2qI2Y9cUfzpwTfzXD2gA9yeE2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PA2PR06MB9537.eurprd06.prod.outlook.com (2603:10a6:102:411::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 11:48:44 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 11:48:44 +0000
Message-ID: <c7735d8b-b4f3-44ca-9776-36bdfd6ba50e@jolla.com>
Date: Thu, 23 Jan 2025 13:48:43 +0200
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
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVYP280CA0040.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::8) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PA2PR06MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d95ad34-2ee3-4930-dbca-08dd3ba3e3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azNqQUpmOWVFc3RDT3hRclgvb1JoM1pVTjRPTWo2MFdoRmFKT3FyV1Rhb1p6?=
 =?utf-8?B?elhVamRKR0EyNnVaYlJZckJkYW1zS0ZsdE9IYW9HVHNUTmJubG9sZUduTjJy?=
 =?utf-8?B?MVljd3BYZ2F4S3A1eFR6eU5XUWxwa0JsTUdPR1VqSStHeGtMdEJaTDVob05B?=
 =?utf-8?B?QnRldHA4R2wzVldOeDJFOU8ySFJ0cm05MzhMWkVKS0dUaGJjUTRsVE45TFdF?=
 =?utf-8?B?cC9IL044VmJiZ3pOSk9aektzUWNCKzZNdk51VUdpUzVhRWsydDgyTFhMVjRK?=
 =?utf-8?B?bVFJRUdHd0IrUk5DQ3Z3V3Arc1IzaTlITWUveExFdTg1ZXJSTGhUSjdRdS9B?=
 =?utf-8?B?ZW04YTZlVHNPV1hvUUFZeHV1cnkzdkMxaEtEMkZNRjBwRkVlekJ3T25Dc1JI?=
 =?utf-8?B?OW0wZEl0MlFSTDNnTS9QTU1ITHhDdTFGNDBIaTEvZ29NcCs0aWlXeTNnT0hC?=
 =?utf-8?B?QXFaZ1NFVHFCZzZ0cUNBQmc2alpkVitwL0JRNFU0WjIzV2g3R0N3ZkQ0NnAv?=
 =?utf-8?B?RnpINWNvc1pDMkRvWlM1YXZaRE5oRHdWUzE1T0tTUjFTTGg5S1JQS1crTUVj?=
 =?utf-8?B?NUxFa1k4QXZaRHBheWZIdzNMKzJ0Z1AzWmc1ZXZ1eUlxUHkzNEJDbldtRnBG?=
 =?utf-8?B?dFlUYjJhV29tUDVrK2F5K0ZWck1vckl3RklDSnRhd0ptRTcrc3VuYzQ1dWFD?=
 =?utf-8?B?WmM2TVJOQXNQNG5xckxmY0dIRzQwbndZSXRNdzhwQXhRMUlOMDRCL0tFSnpz?=
 =?utf-8?B?dE9La01KZFlNUG94K3JBQUtmWjJ5VHA4VFU4VEpXcS9WbllORlpxWk04aGwv?=
 =?utf-8?B?T1RMZUlkM0kwRnA0NzZEREcvc0VQQ24wQXBZbStRaEFDV3N2VnN1QUJiZ04x?=
 =?utf-8?B?ZGFrNFdXR2dPb3BSYVZBT3Buc0w3WmJlaDFlSHdTSXZKRGlVaGhHZXR0ejdv?=
 =?utf-8?B?K3VlZUhFVkpJMHJIWkY3V1A2SG5QTXU1ZHhjVjVQWFRUSjZVV1VQTFVYd3JQ?=
 =?utf-8?B?K2FwZUtucHZkRyt6UngxUlphVDNZY1Z3YmpSa0Vtdnc2VzdjN0E0M3JNWU5h?=
 =?utf-8?B?dURTUEkrSzM1ekszOEN3TDNhMzNlR2xVYUV3MVpvbUxuN3JnZzFyWVdyZEsw?=
 =?utf-8?B?ZWJEUS9DV093VEtwSkc0cmszTnJhZm5CRnJQbnlWbDZKSGZNVmRnMmZoWU50?=
 =?utf-8?B?YnJWRG1HM2tPdk9wQnppeC8rbmRqa2t0UkMxYXFnREx3ZjhjcXFOSS9pNkpC?=
 =?utf-8?B?cDIxSFJ2S3M4clN2NlA2TSt5UGpaMWdWWkJqZFpOMU12N3ZJNlRGWEhCQWtV?=
 =?utf-8?B?WkFKV2g0TzZyOGxBRERwOGwzR2JCRkVOQWVpS2d1NFJCRFlLKzh1R1o0MklQ?=
 =?utf-8?B?bFZxWjVzZ0cyNE16aG9UQ25WQ1NCV0VSdWlaa2FBRVl0QTlpcGFMa1JYMkNx?=
 =?utf-8?B?TmJrMEpxbktRZ21Xc1ZyTWdTS3BmQzJUTFZsaDc3TlB4bFVuRkFvY0VvaDBZ?=
 =?utf-8?B?dVNlNUtMcFk4TUNwanVlZXJucWdOWnlBekhaQ3I2czlQR2s0VFlzUHdhV3Z0?=
 =?utf-8?B?Z3FLRHRSYWlvaWJ0SENTOCt0MWo0cHpkd1pKclU2UDZkMFlsUkRzTjdhSlhm?=
 =?utf-8?B?ZUhrckhEL2djc1ZmbEVPMmo1NlkrenJveFpVdW9hZDNDNVZKYjd2NFdHV0FK?=
 =?utf-8?B?WU91SWR3bTRMK2M5M0RsQjA4TWRCS1VXM2ZVRGdQZGlveEVxaVFTcVpxUUhm?=
 =?utf-8?B?VnJ2WkRjQ041cVRIT2JmL3dnTW9Ua2Vkc3VEOUxvTzNOYUx0YlFCdmJYdnJ1?=
 =?utf-8?B?ZlI0cllnRFhJYW5rQUs4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJGVzl0V0JHVGFlMHdsaCtFNUFCTExlUVFDVlRidUxTYVZ4ektjNXNqazFW?=
 =?utf-8?B?VUZvM1VUajlxSVptSDlmRzc1SmdiSWVTQzVSZDZGZGhzMWRIakxWK0JYcUZC?=
 =?utf-8?B?T1U3NG5HWG5PNmZFbnFjWVVCdkRhanYreC9UREZ0UFY4eEJONVZFVnBZTVpL?=
 =?utf-8?B?b3ljdzBUOEpJazBPYXcrR256emc3c1pvd2JXcktNbG50UVF1UFNmK21BdzRE?=
 =?utf-8?B?Z3hBdE5HTjN4YzZ4K0hTMHNXVjdlZkwwT2hiNWg5OEpZZWQzVlZlYXBBOFVj?=
 =?utf-8?B?d3Q3b3VBRzZYdDA1dDZVNU1GclJlUEhBT2xOWkZhMUhZNVZFelNUeU01eito?=
 =?utf-8?B?YVhMOFpWQStUS0VuVERER3UvcXA1WmNQcE41Y3lGemM2K1A5MmdyN2NoMkF4?=
 =?utf-8?B?Y3BuaXBic01USWZqbjlaZEt4bVhnSHBJaGtxTGtKblJybjZxMHFXMVJqT3ZY?=
 =?utf-8?B?b0x0dUZaN2FlY1J2QmFFRnFVL2FHdGdKYWtCbTM5WmV3TllwditUSHlWRStw?=
 =?utf-8?B?U1dvZlNMalpnbkV1WXpyeGZmTzgzZEJiZC9qQ3VHNWQrVndGbDYwdEFDWUU0?=
 =?utf-8?B?NWtDdHlicWxBaXdWQm5JdjZJanJhZElzNngva2pTN2VyMzlMa2FScXpwc1RW?=
 =?utf-8?B?QWo3WXVQc0pTcXhtUFA5S01scGxUMHRYNytIcDVpRlNCNU1WR0RnUC9ieGYz?=
 =?utf-8?B?OHpLSHcrVm50cmpTUjVUSkUwRDhRbDlUa0tBQlpoUFc3S0JCVWZMT0JZMmlR?=
 =?utf-8?B?dkg3SFc4UEZjaTJsSVdwbEh4aG84UjF0RFpHRlY4NWEzaVpROVBsckVrYkVj?=
 =?utf-8?B?TWZMWEd5MXh6clhxVzBmUXh5QkIrK01nSGpzb2Q5WERIckFRTFc2WWJ0M1FF?=
 =?utf-8?B?T3BocDY0TkVjOGVaVU9qbGlKUlFreUpLV2lTZzRtb2lGU1JhZ1BxeEpJVEZP?=
 =?utf-8?B?QjFCenhzL3N5SnBMOVZqcHlMODBib2FLQ1VOOHQwcm50VnovNDNrNTNWMWNE?=
 =?utf-8?B?UXdET2lDSllobjdVOG5RQXNLa3JIbmxCSlYzT1NlQW02dW1CaDBYbGxlTkJY?=
 =?utf-8?B?RFdtdlNsSTZGa0xTays4a25HUWFzK3VJSy9EaVJJaHVLcmRwUzJURGVLcXdS?=
 =?utf-8?B?KzBBamVOU2dsdWNkaWY4aWpvVERBQ0F2TldHWE1BMWlHTHFEV2oyaVhtRVRI?=
 =?utf-8?B?TFlNK09NSXI0bzZ0bmsxOHo5QXVmNG9CYlFIeG0yZ0VTdnBTR0pQNmJkeXBj?=
 =?utf-8?B?bVB5ZFdEdExHeWRUVlF3Z1dHT05CcEU5VVdvVDFIZkZTTGRSTm0zUGxyTnNL?=
 =?utf-8?B?Q0lsWWI0dVlXbkRhcXQxMWJqS2JnRkdYU2N5cTN5Z3M5c3F2NFYvOURXOEFk?=
 =?utf-8?B?bThINGtCeTFCNitTYUNya1ZDaGdtRTA3SVVXMFhGaVR0RS95a1loQTJ6dFk5?=
 =?utf-8?B?QlluTVcvR0F4L0dha1dZNlFldE1CUGN0TmtQMllwMUZydTBYbVU3bzlZbDcx?=
 =?utf-8?B?TVJUdHdlZ3gwNWcyRE50M041cEVnUVUwNVZKUXhJVk9vRTdIdTZXdDV4emFa?=
 =?utf-8?B?RDg2RnlDTU5saEhpejFWZVFCUC84dzBvaFN0aXVLRjByVytwRW0xV25IUyt6?=
 =?utf-8?B?eFRXNDh4M2VmU25KVXNUU2hlMitZMWJVbUFBeUJFQUxpVzRKN3pST29QRERp?=
 =?utf-8?B?QXZ5VGxXaEVva2pMckF6S0RxMy9jYzY2d0JlZ2xuTktZVVM0R09mTm9HdnI0?=
 =?utf-8?B?eGMya0I4aTJ0ZlJUbnUxSVAwbGdnMktONkRKMUlYTDJPaTYxLy9zODlYV3dJ?=
 =?utf-8?B?aEp0TUJ1TlVvSEZRZzVFZUNJYzVJQngvU0VXYVVOUzdDdStzQzRGcmdhanNx?=
 =?utf-8?B?YThFN0dIOWw4V05tSEIzaEZxWjR3L241KzQ0dThhRk15QUlrYlA4eXhJZnR1?=
 =?utf-8?B?SVFGeno2SWFnVERMWnU0K2I3b0ZHNENPcGhORFhETXJuVlhSN2NZMHgra1RW?=
 =?utf-8?B?QnJ6U3JNMSswQ2N2WHFabHdTM1Y3NWlwenlGWnFsY1lVa3o2YXlBc1V5WWlQ?=
 =?utf-8?B?NXpQdDF1R09CeGZ5WTFoZHNKbjJSMmQ0TlZpcm05YWpJa3BGUEdUM1Nic2xP?=
 =?utf-8?B?aHRNTTNidXZIWnZSUm1zY2xRSFlpU2dLSFlKckVRT1lRY2JRUmhPVmpvbXhC?=
 =?utf-8?B?UFJ0dmRZYStFMTZ0TFVBOEh4ZlFEVndkdjVJd2xtQVhaNWR2ZU84cm9Nb0tm?=
 =?utf-8?B?bXd1aXAzUlY1VmdWR2MwdkdDZzB3PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d95ad34-2ee3-4930-dbca-08dd3ba3e3b0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 11:48:44.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZSrE57SjsJayQyf1ri5nCA8zkb+RSFAEEyft0cyD9rYoNeaLSBn8/tXuzvnzZVQyvxU0+HG4W/xhxrBiWo37Q8tWOWEPMN1ubSGGlLhNC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9537

Hi Christian,

Ok, now I do not know what is going on, I personally cherry-picked that 
particular commit from upstream, made by Daniel Wagner, into our fork. 
And yes, you are right, it no longer exists there. That had an issue 
with invalid setup, that it did block vpnd for a long time and I changed 
it to use GResolv instead, which seems to work better.

But why it is not in upstream anymore is a big question. If you use the 
cherry-pick commit id, which points to our "upstream" content (yeah, not 
the best way..) I find this 
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/vpn/plugins/wireguard.c?id=90592f7a58358a98bde5df6928e2b871041c12bc 
but it is not in master?

Br,
  Jussi


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

