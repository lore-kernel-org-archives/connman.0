Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023123.outbound.protection.outlook.com [52.101.72.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9550266EE7
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656201; cv=fail; b=YI8zrxN52aEEa3YIT6+lBfuHLFZ5FfpqmbwhNtvEWfeN9xuQ2KwWJ3T/lpfrpKUK7y8XKz4QntXb9jR64o2Jg/a8W2SVl+GN6e3E06xZPnpscbO25SBIoL8optLqV9g7uhxCwJYe4dwpD7nmgiE0qJaiWAXVGhVtwD7uCHt1HxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656201; c=relaxed/simple;
	bh=kv0ZvkQZTLVtv877RPHbhCvzrROD4skwFZF+0HPitIk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E49sh/xttOCLgNUQzp07voGgZEQmTnQF6QfpYLLp0zeYS1MUCut2OMHsMUev1MzbE7b7jM3uUMl2MbEe8VYPLPfIc7/KMD7+YnAGeDluimfTMjh+kV3MAn5dhJz+CeHzw5VgcmhBsdnCKkEyYC4XHu9bIzzIzVpqleyii1HAceQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=G6XFCAEb; arc=fail smtp.client-ip=52.101.72.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="G6XFCAEb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtbbvvkQYAgDiKgUtIA+23HTwyxqbuwO0iee6vMp8uZEexJxE1D++W4YELm+Znwt3mjkz43g8qZ4HYrONqNAztgbk/z+9AxosQMQrXIQlUjt+FPZergn34rWXM0fvJO8cU4IeF64F7Xg38EEr7XCht73oFxodzKAn73Ic30lxRYVVc6X+XHBLTVrG941j5lNcSDvjqs7nsl9aELohVctaLeTRS54yrw0GcZNgOnk3qSSGxIRye65GlCilujfP/6VuZa2n5PRl8NMppNGCvG9AEj6KP9YeWT/j7B4V4NtAYM4/V4ClslVjaMJLCdR8kQ+hZqiF32QcECD0QMPLF5yMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERPTUb8l9JmZfAj6KRBpj6a6Nx5fIrwQvKmIQuQ5GCs=;
 b=tHvyP4awTCJa+wPqIlNFB1RRmqRW43KjM5c2pJQy8Er3Z7cjnC5paO6wI016et4l370iGb30ULPNNpXYgEurO8HDngiD7MhG1X3IzBxFRPBPRwF7+coFa7AJIBc2XbTdfRF6YDWDkLIf83HOzlapidzPsvlt2T79UpSB3gd8n8gu2/9jUq6mcV/DIIsLqVJfVLduh/2Wy4hJn4yPFFpiuz6FxRNsAeOj6IOXzWDzR/JJwV21/ojIxKVRwM0LhlQ5IaCGbM58C0Upn9SnGxzFkn/36oTpM2jyXtOr1eHNjOKJy53keLAHEE+hOkYI2m2y2bhrptkfvV+m9A29iSkkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERPTUb8l9JmZfAj6KRBpj6a6Nx5fIrwQvKmIQuQ5GCs=;
 b=G6XFCAEbfBcsXFh+scUdexlP/cTECcXu6olneZeXbMydxX+a3TMyhjs9rmuc/VAaptdVI+zu8RTLUUrKsZ3k9x5N4EXMjb7HeqlV9Ke9/BDnmlvDhHSRUcyWM2LnoFJ3ouWCTV+SvLNKedoj80glxRGxXeLXY+yCwcOwAWShJUfgcgDmEaD8CDTrdI0KY31uoaN2Cpt2N80E1pmJ1ZRitdBabXtRUDHqyQhdFIcq5ElFLfO1i9Cf7SJLyUhXSFYjaCCZfo5WgK8h10Se49AX/PHruYUNK6mjRsy3253oSlOW8SX5kLQK+ixLfXndpsZQyalRy8ByDv5o+oJVlghrMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by AS5PR06MB8749.eurprd06.prod.outlook.com (2603:10a6:20b:653::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 12:29:56 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 12:29:56 +0000
Message-ID: <81c19a74-0e80-4333-8157-4a9b4c506263@jolla.com>
Date: Fri, 8 Aug 2025 15:29:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/45] util: Add address family set/get/reset helpers
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-24-jussi.laakkonen@jolla.com>
 <94f9fdd1-944c-444c-8b1e-49fb0333c740@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <94f9fdd1-944c-444c-8b1e-49fb0333c740@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00014AE2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::315) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|AS5PR06MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 2472936c-f30e-4caa-33f7-08ddd6774890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0xnOXRtWXN5aDg1ZmZ6blp1RWV3UEtMcW80YTRZOXo3RVZyNXBZdFBWdHds?=
 =?utf-8?B?Y0tRdGtQcDdhN1pXNmJNTVBlTWZ3d0ptSlNoR3hNMGR3K3lialU0UFVxWkw2?=
 =?utf-8?B?eldiTmdvTjQ0ZnUvV1kwN1cyNVRGdXlVdkJSSnhRaENkQ3IyYWgvRGZiSXU4?=
 =?utf-8?B?L2FpVHk3M2ozdDVzRm00V1N4RnJSUWVmeXNMRUw4VTk0eVFONlRVTyswR0x3?=
 =?utf-8?B?UUZUVTN4dWRJZmFacGdLWURSV0xkUU5EZzBYNG5MbjZTb2JKd1V6UWpPZmxB?=
 =?utf-8?B?cm5MajczTmcyNTJvblAxOGFrUTVVdjA2d0xkeTVwRTZYb3diNHlGc0QrSm5K?=
 =?utf-8?B?cys1cWdPa3M2blhOc0U1Q0RnYzBnelVJTG50eTdLelE1Tk9HSU1LZlU3Ykp0?=
 =?utf-8?B?QWlWL3lMeEk2SzIwZzVoaXZiOFZLQ3gvYTlpYy9rd1FVNFJOeTkxeFRtQTIr?=
 =?utf-8?B?OVl6d3ZXVzMzLzdyNkc3QU1lcFVlZkZ1UUN3QzlDWDZCR3RNSXcwdlFSa0pJ?=
 =?utf-8?B?dTZkeWswam1yZkk0Y1VQeGl2dkRlS0djWEkxVXY2VUUwTUhTZFI5L2hVNU4w?=
 =?utf-8?B?Z0ZSWGdIOUdzUW5tTWp5L3R3ZWFsMGR0MEw0ZVoxM1ZNMGk2bFQwWXliRlVa?=
 =?utf-8?B?Qmt6S3ZmMGhZRDR6UGlQR3p4emdVRDJvVHpiQXpOZXlGalJtS3lOdTNrbm4z?=
 =?utf-8?B?SExiMkxUcUdxbVFiTUphRml3VUIvcjZvSGdVR25wQ2VMQlFvQ1JLVmhKL094?=
 =?utf-8?B?NnlmK3djVnA1cVdjbXlaaXpnSXoyWG15d3dxVEpHQ3lYeThwazBoN29SNXhV?=
 =?utf-8?B?VlI4cXhRVWVKV1drTEgwZlBmRE5GVGJ0WWx3alRDUExReXNGL3BZSVlXV3dX?=
 =?utf-8?B?bmxuSFpZZm5IYmhBc2ZFRy9wb000MytTT0hCYi8xRk53NzZNOE1BZk4waVY4?=
 =?utf-8?B?cFpZWnZkNVlSVWRZT1htTTF1eS9MaTRPdTJyT29GQWsxeEttN01CUGlrbWJn?=
 =?utf-8?B?SVBtR0FTNXppYmJNMGMzZ2NZVjByM0orSmFoa3R4ZW5SMy9MUWJ1aWFnOFdN?=
 =?utf-8?B?RTNVdElvYWZWU0pIdlRUK2Q3ak04N0E3VFN5MnUwazRzQ2kvS2dNMWwzVWVP?=
 =?utf-8?B?Q0pWa2cxV1kvWGpLQXdDcklyVTU4SmVNUDgrVUZmdEdYdDdwV3AvZGd3QjFj?=
 =?utf-8?B?dnV4Zi9NOFl0elFkd1Z3L2cvenFEL1Nub05DNmQ1SlEwRUF2VlFWTjF6eG5R?=
 =?utf-8?B?MzFEQnllMndGVnJuT3pERzhtcU8wdHdnMmJteXR1Z25iQWZIandIaVk1ekRP?=
 =?utf-8?B?UGZKR3UzQlFhMmhseVJNUzVBVzVIdHU0UDdFSXJFVFJyQUlIeWNkVFg3eWdX?=
 =?utf-8?B?SGkrQ051SDJ2d1ZrY0wwSUVyZTA2T3ZBaTQwQkdKMEdjdkw5RjU4emQyT0J2?=
 =?utf-8?B?YU1Dc1NrZGo0ZCtxMDUrdHBOSUdSR3ZiTG5BeWtjbU5GNzNJL2NReGg3dDB4?=
 =?utf-8?B?MWQvTFBLNkxBUlA5ek9TU1FIejlTUXBzTmJ5ZVp5V251RCtGSXdiWkNvQk9r?=
 =?utf-8?B?TUtEdGxUeUtUSWJpeXdZL3ZKblp6ckFJZXRkYmtSWkJwdkorajhUYUl6WEJZ?=
 =?utf-8?B?WWJpUm4zM05hb0RSTnJOZE5JUDBlanJvN2VYSTFjVldsNzNLSzJkcmQ1TWRq?=
 =?utf-8?B?MGpOcnA3WjI0VXM2bXArSkxWclRiT3pYMjk1M2Q4cjh6QzlDWG01TG15QWdG?=
 =?utf-8?B?WWM0a0Yya2VUMXk1T01oeXo0c3RiL05pNWpIR2l0c2FaZmVSNVh3ZGFvcmVN?=
 =?utf-8?B?c0F6WE83emVycDV3VmJBMHJmZ1lwZC9hVVQ0ZGIxbGh1MDhqTFQ3YWViOTht?=
 =?utf-8?B?ODdLOEZwS01nWUUyUFlSTVhNb2F6SVZPeU5RdkkzQ3NDRFlmdEE0bjg3ZThP?=
 =?utf-8?Q?7zp1H4mRyIA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzNhMmU0WFVnNGNFL0RNd3pNamxaL2dvN3JNaE5xNy96eDNZbmdsUjdaNVJN?=
 =?utf-8?B?QllkTk9laTFPM1J3eVVRRTc5dGR5bVRpOUdqQklXRkJqQk9oZFZoZ3RjQmFp?=
 =?utf-8?B?ZEd2cmwzdG5Ta3F5YnR6bFNBdmhSYUtXSXZhMXRKSDNKMk1GeFFyaEV2amxF?=
 =?utf-8?B?MXgwaFhUZFlGSDY2QUtsNmRNVjRZYWh0eUJEaUR2OHB5ZVNScDB1OGQ4Yjlj?=
 =?utf-8?B?bDZuM0NaM2pTVG5zT3JvMmZGV3JVaGFHVEVIM043ckRZam1LT3ZiYmk2NHFz?=
 =?utf-8?B?U3J3OERGODJ4YnpJRDJZSUJlczd6c1MwdzdJamYyOE1KZitjVVdsdEhTZ01y?=
 =?utf-8?B?Z0YrM1J0RWxZaURTdEhkWXZSYUs5cnYrTWVrUlFoV3JrRTVhWUZQSGEzTjBQ?=
 =?utf-8?B?emtmQUxYMUs0S2g4UFQvbzZ0OER6YnptdE9uQWhKUzdxUFlNWGlxOTFkblV6?=
 =?utf-8?B?VllsZ1c1TWlIK1JBVm1PMUpRWitGMmIxcm5YQVAyUGY5NWZlQTJMbUp4MlVu?=
 =?utf-8?B?V0pmdFRuY2l5VVBCWWVTOVh0YW9USStlYUFqZ1FpMmo1VU9tb3E5Umsvc3dY?=
 =?utf-8?B?U1JFQjJ4c3o5alhvNWljQ0x4cFNWQnIvMGJYRmo5b3VyNDh3clpBbUJKRkRq?=
 =?utf-8?B?ZElVb0VrOXF0amJubXRsR3l4N1kxTWljdkhWdENrUXNzNHJGQ1BNZjN6eEgy?=
 =?utf-8?B?QW9ML2xPbnZRUGJER1VsY2oyWVROM0ZubDNlSXhjbC9vTTVNNzlrdU9LTGFj?=
 =?utf-8?B?aEVjczRuU3ljRnJvMGxzOVIvZ3puVG8vRS9hdkFSOXhnb2E5blRFZzg1eWpr?=
 =?utf-8?B?Z0JvY2xJZUNkdU9vUFltOU5CUnBwbmltRVY3ZTZHQkRpT1djelVYSGE5NkVD?=
 =?utf-8?B?YlFtVXM1ekJGYWM3WnV4WlFzbm8vMDVjMWo3bVJmTER1VjhKcUsyeDRIYisw?=
 =?utf-8?B?OGJaVFBRc2ZpN2tmNU1rRFpPTHNwT3J6M1lpMkZOTk9COE9Ed0MvWmdnMXFI?=
 =?utf-8?B?dmcrV2hkNzBKVDFCajR2ZkZ0VnFZbkYycmlWeC9seHpIdnNMUmtTcWd0UGJR?=
 =?utf-8?B?KzNhVUJvVUE2clNKdy9MMit0NldnUDVOdThCNVB3Umxqc1lPR2pOOGtGc0Rr?=
 =?utf-8?B?dXR5QXpZaE1FcTREYmx1dXR1QjNrRE5IbzlNdHF0UGp4ZEh2THVzK25iNXdm?=
 =?utf-8?B?b1lORVBIRitDZVdmU1hGL2JhTGNleUcxdnpkdmxFSUs2ME83cWhxSk9zbmE0?=
 =?utf-8?B?NFZ5NzZsUWlhcmNrc04zT2IyRHYvMzh3TkhDNzVER1NzcDhBZEtwWEcvNDcx?=
 =?utf-8?B?enZOVGdjaW8rZjVCWmRXNGdESVh0c2dmc2lzNXd2V3c4c0ZqN2krd1E3dVhT?=
 =?utf-8?B?Wmk0RGlGRmZIK1FicWtRTHFBczRSRGJOUkd3dVRWUVBiSStoQS95eHNPYUVT?=
 =?utf-8?B?TERlZDVZSmJ4ZFAxbWwxTmZIZzVxSUtYNDl1NGtrNEo1V2tKMmhHWU1INHAv?=
 =?utf-8?B?OUFudUk0SC9xU2hNWDU4K0ZXVlRSb2RZSUwxS3V4eHM2c2tvdWpvN2NYMmdH?=
 =?utf-8?B?VUJzelVSQ2g3N3djQUpKS3hQam1aOHQza0JpQjh0Y3hYMmp3K3VVckVuaHRP?=
 =?utf-8?B?dUZadEliQlYxT2FFcVlYaTJycEdHWk94elp4Q3BIVmIvd2ZCSlNaWEYrTms0?=
 =?utf-8?B?cVM3azFDcHJQTHVnMlVhM3ZHYnlqeWsvZXBvRHRWbEJ4UEtzdWxWM0x6alN4?=
 =?utf-8?B?SEhnUS90bW9tbXA0K1lXYmZqV1djQjlUSWZFYVZVdVdnTklpb1hsSnRlUFhh?=
 =?utf-8?B?WHJxZU1EWGlGNjdhM29zQkkrWjhDYTBFUzRTKzdFUCtCN3IvVWN4Vkk1M09Y?=
 =?utf-8?B?c0pLaXl6Rk1SUzZpc3hud0ZFOFU4TEJma05acmVZS091bllsNEVLRGRIWit2?=
 =?utf-8?B?MTg3ckpuTHF1VmNQeFlEUHVUZHYrUnRReHJZeGVMaS9mOG1KZlVuRlAyZFpt?=
 =?utf-8?B?SG9mZ295UThnRlMyZXB0aXNta1Brd0xFNmFDd3BuTFZNYTNOd1k5VG9qUis2?=
 =?utf-8?B?Vm1GdG8rSW84bytNUGpOSU43K2hEZUpMRWkzUXpwamFzOUdpbG5VeWxrcjds?=
 =?utf-8?B?aFNQMFdTZ3pCM1RlK3JuRUhJSk5vWnNDQ1k0WSt4MjQ1akFxdFRZNGNQQjNr?=
 =?utf-8?B?SHN0T1NxSmt1SDJvOERnUGF4cTlIY29FR21vb3ZUVHIwOExCQTVZbUt5SURa?=
 =?utf-8?B?dXpPNEgyamxrZEVtNGovRzQ4cTZ3PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2472936c-f30e-4caa-33f7-08ddd6774890
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:29:56.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJb8Cx2x4tll7oKq/1opYhE6T3K7KYeYETyLfYFP/5vT6IfaPkgFF7Yd63Jd/Tza5ea9G2chpFaK572M8cgGPAmFvNl57x9lgYnbes/L5UE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8749

Hi Denis,

On 8/4/25 17:47, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
>> [util] Add address family set/get/reset helpers. JB#62713
> 
> I don't know what this is.  Please drop any references to internal 
> tickets when submitting and spell out what the commit is trying to do in 
> the commit description.

Oops I apparently missed one here. We have the internal tickets on every 
commit so 1/46 was a simple oversight. I'll remove it and put v2 next week.

> 
>>
>> Add address family (af) helper functions to be used with a boolean array
>> defining which address families a provider has. Supports AF_INET and
>> AF_INET6 as set/get parameters. The array must be of AF_ARRAY_LENGTH
>> size.
> 
> Ugh, seriously?  Maybe:
> bool support_ipv6 : 1;
> bool support_ipv4 : 1;
> 
> ?

Yeah it can be made into a struct for sure. I'll make V2 of related 
changes (hopefully) next week.

> 
>> ---
>>   src/shared/util.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   src/shared/util.h | 11 +++++++++++
>>   2 files changed, 51 insertions(+)
>>
> 
> Regards,
> -Denis

BR,
  Jussi

