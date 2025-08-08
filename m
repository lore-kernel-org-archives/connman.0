Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020122.outbound.protection.outlook.com [52.101.69.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0FD27A44A
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656093; cv=fail; b=N8BQ3HEfvCH1rWPD8bFjC9wKZO3HvtyNvcl7lAN7lXBjY1Dk9Fg1snRx3dOWahRLGBh5Tc+GarYdSxzR1SlsANp7+wy9jp+pxvnQACmJFH/u1achvRsbN5hRMRjAYZoNf8N2f+RAdhJ75FUJTJuIIxJWAQoAloK0wXDrRbzwquA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656093; c=relaxed/simple;
	bh=P6UUhi6FpiJfNMclJK+MkJAEuiqtllrFqJYkimMmQLk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b5GtL09whPiqQL4pgvSEt/oa4MWMOsfWrlhumq70MiTbG7QqRoFoKD1qpQXyulA5K25gLaTtJHagKzXm6ZDQoIEpBVIwKOJD5/qmtWJMSbQRxv2B7LmjPFpcxYwxoCzXsb9EByDM05JMQ7e5hHuesKMLAfY0oKFfqfhnpETWu6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=Hyo4bWyj; arc=fail smtp.client-ip=52.101.69.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="Hyo4bWyj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlM2k/VfXl8dR0WXfSZmDaEHtKYC2EHJiZcwjYe28wKB/idReeiFGRE2gV/s0RoohI4D2Ape7quIcN16ITZf2pw3gmJwcAU5T+0hMTtg+21kCoOFJR3f2uommQr2EzB/LP4PnjQd53/9e2our4tINVIYAEonDX0dkbPAogFCk9no4EvW44JWb0Q7+wxh088F+Ib4/icMGftkDKEnUjfhw0r8IgTUDscwAT3lOJjNXZZ9X9JZ6sAk3Qoe2qDBklJSAaCnlUjUxVNbLD1aoIpv8lFAGB2SYCbCVxrwCX5MPjWrURrNI6QSTy9WeJfBrAW5e5InQpmQU5hjQT404du+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vXKgpfWcOXYe3E+FdNVjeIkP8WbnUne6h7TkTpeSk4=;
 b=PF3SU5P3tLwbby+X4UPa+Dseg/dA0HVfH0qqFUEDEpGssCafutjcMKfAJgb7P9Khj4hbiz/w1amMZDuL61E9U8flJceVuYM4CYB7oSdos0OIbO0xNOcTu428SOxWL01f6uvHwObHYIKOCbyPbnnVO57IXM38bf5Ouf9mzlJ4XwYaeVyt8/7+Zi3+VMHrxCiXEz83tiYdHNXSQnPS6at0vOZbVK/LT1qvSf64X6iUsY4ncmP7iZGQg1yI+MpZudIhjnEQ0rGrMN0awSkRYIstdLrl8wQTtnL74DLQXt0YC9nJpVgk2VUyIOLEOici2o1pkuyAvUC74yUDcRbTNc/60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vXKgpfWcOXYe3E+FdNVjeIkP8WbnUne6h7TkTpeSk4=;
 b=Hyo4bWyjB73+Z8bozxsVklEbFAiYoGffKcvzCDhBb/5vfdfsFqGEyUONOpKKMCcXAnZv7CsnP6t0LhIxYgIF8Ds3GjPHci/z5yC0JBfAqU81tbFsojWBO2noG3v4V9QOFsZBilcwwsHLxewHYw4+NtK3pfLf/Zzj+TcGrmD+fmQoHZKQZQHV0P24HdT1YUwiPVOrqNx8nsbMWih8br644C6D0SXXt8UlvvJz5/GjredKfmlKxiXBto/hSRWnVa89OoHFWptI45jW8ltr5g2aHDPCGxzRp8P0CMwRVWlM1avAcm6ydLZHLevonF2TIDiaAvif35jP7fKcyJSULA+3tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by VE1PR06MB6861.eurprd06.prod.outlook.com (2603:10a6:800:1a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 12:28:05 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 12:28:05 +0000
Message-ID: <cd769d53-45c0-4b77-93a4-26afc74d5fa1@jolla.com>
Date: Fri, 8 Aug 2025 15:28:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/45] vpn: Add VPN agent use callback for plugins
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-10-jussi.laakkonen@jolla.com>
 <4810774e-ef89-4b55-a393-356ea8b78c20@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <4810774e-ef89-4b55-a393-356ea8b78c20@gmail.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|VE1PR06MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: c014ea21-54ad-4a61-5b4f-08ddd677065b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0xUU1BRY3UyVEkvOSs4MVhGN0VxaUxsSWVPYlF5UStJT05CNUdQbThoZnJt?=
 =?utf-8?B?T1Q1cThVc1lyVnY3K21yQkhkVFpDd25BQlVSejY1dUlZdkZhRU5RcHNqM3Rv?=
 =?utf-8?B?ZnBsUFdRaEI2aG9McGd2V1c3RmxBRWJZTXUyWEE5dTRoVHdHNzZjRm5BV3d4?=
 =?utf-8?B?ZFV4NVprRVNkRG1pRS81VWRPYnJvYVJLWU1ndlowN3BqUHhRU0YvMmpHWmtv?=
 =?utf-8?B?a0NScW50YThyMWE2anowV3ZhTWJEQWNvYUFRckVOTWVneW1NbFR1R2RrVStS?=
 =?utf-8?B?cURkSHFYVm1yUXVlTGQyMTloMHNabDdDcUo2YmFhNEJOUjZkbkNNWXhWc0E1?=
 =?utf-8?B?UVYvWTR6NjFhSkJzdE9pL2RzVFFOb3puYWJ1cTZGWU1rUWJhZTd5ZkJWa0JZ?=
 =?utf-8?B?alY2bXJZenZZakdLZkZ1aExkOHQyVlVvVXkrTEdmN096VkVneWhXVGJBL3V1?=
 =?utf-8?B?dFlnTzhUNllxdmxqaEVpSk5mVVNBQkpNSHR5Vk0xeFh4UUNDZjhwa2cycm9n?=
 =?utf-8?B?QmNzdXpOaDI2Vmh6QVozQnVTQWRzRHRRdHZuK0dod3NFYzRtekVmSzJpaHRC?=
 =?utf-8?B?WjlCcTlsMWphR0QzN2dUWXp2UldtdXQrT2JVS3NyT0tVajN0cC9zdEtyemxG?=
 =?utf-8?B?NWFoSEtsR3RTWTJIK21IYU83UTZ5TmFIQlpSN0NSWmJteGNBUlVkekZCMm8z?=
 =?utf-8?B?UUIwNmNaTzJ3bkM1dFJpUTFOVWFNRXdPOVJOUGcydXVzclB4Y3RyamZNams3?=
 =?utf-8?B?ayt6WDhmNll4VURCcGNSNXNyZXhqQktRWjFBRjI2QU13dlRwdmd6eDFoMXdJ?=
 =?utf-8?B?c0NLS29jbFZnSTFla0VLcnRObVFrRVFTYXg0RTIzbmJ6M0dmOEFQbnNtdjRp?=
 =?utf-8?B?WXdOVzNWcnBsM0JjN0JRZTMyaXJiK3B6ZjhBWExLSWU1S3hRRlB4VmNvZFpE?=
 =?utf-8?B?eVc5ajYyMFFzWDViS2h6VkRRTklsSXZFbEdRbS9McWEzVlRsNlhPN1NKbGw3?=
 =?utf-8?B?bFRkeVVTQTJKbUJ4U1RRTkgrbkJsd1BOQzh5NmxwOGVFSjNTeVRCM1oraWxD?=
 =?utf-8?B?WDFnOXY0LzdDMjVIYk55OEQ3c21pYjhHc2pldEVYSzMrUDJDdjJjZjBoV3Zh?=
 =?utf-8?B?VUExbS9abFpCbUxmOTE5K3VVMmlpdDR6Q2R5Z0JwSGVnOUxJbzRPWWloODRo?=
 =?utf-8?B?eU5hcTV1MCtFTkpGZnpNbUh4WWtRRHZtN2YxeUdCUzJWM3VTZ2RQSUxsaG95?=
 =?utf-8?B?UmdiTHEyNEVVWTNRVUdoWEhrYTVMVWYzWXF5K0cxcXY0WkdGWStTSDVXVURa?=
 =?utf-8?B?TGVZU0NvS0RjaXU1ZVBPc2VqbHJKWlgybnlYZVBJSnVHWkcydTUxb1RvZDV3?=
 =?utf-8?B?akNvanpjb3pZMDlaOEJIV29mN0xaa3JKNnU3SzI5N050SVdQWElobkxHRXhF?=
 =?utf-8?B?b0RRZ0dJeURKNDIxR2dIcmdyYzZNSFRNVk9LeE1rQ3J1UGdhY0MyVDd4RnBU?=
 =?utf-8?B?L3oxc2xsNHB4SEp6ZDYzRVk1R0ZmTlpsdUFPSVBHbFUyUjQrMytSS0RIekFX?=
 =?utf-8?B?RVlJeUpPS3R5TlFtd0pTQk9NTldsNmF6UHFuUnVGblUyN0t0NmNCd0FZa1dw?=
 =?utf-8?B?UUMyVWp1YkdzekdXeVdLeDByOXpEUWNvK0MwVmRWOXRJbVlKL1Y0SkFLcGMx?=
 =?utf-8?B?eVA4YjNNWXU5TU9YeFVCRktFdE4wRGw4RTJrSGtLcjdqdkFDZnlXN0RjS1pF?=
 =?utf-8?B?WVVmUnZmMTJoUjhXL3l3M0M5ZVl5eWxaZVh2NFRPNHN5MCs5NUJsWVQ1R29R?=
 =?utf-8?B?TmNrNmpVTStYMjcvelROUTZDK2lDNGhUUHZnYVdBUXdPYTV6SzFYT1NHbkww?=
 =?utf-8?B?bWxnanIyUk5GblNtN2Z1ajRETW8xcE5ySlhNMncvOHVpSTA0aWdhZDdENWZQ?=
 =?utf-8?Q?HYR+92eGzr0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azFqaFBFREJvakQxNlQ5ZURNT3BiaVZyaFBoUk5ueVg5SmVqaGNTd2tTb1JR?=
 =?utf-8?B?amovcmhkcVFYdW16SDRQTUtVbC9kdGYvZTRGdE9uSXhoVk56RXd3cGdGU2t5?=
 =?utf-8?B?NVBDbTdDZFJ0TTFBc0M2d203bkdlVG5yLzU3dFdIQk84OTJkOXN2bVdqQUcr?=
 =?utf-8?B?MnlsTm1hZ2doQ0J2VUE4eU9LbkZqTkYveVJ5M0xVQ04yOTUrOTdBKzhwTUNv?=
 =?utf-8?B?bXVKQ0ZnMEx0Yk9naUZ4dmVqWElXT3BCRGpFTVIzVWVzWGwyTjZhYW1SNFU5?=
 =?utf-8?B?dmcydDdLS0cwZWJRQXJYazNvU1FxazNxZEZCaGV1bVdhUGJ4MStvK1VJY1Vo?=
 =?utf-8?B?aXNXYUVxNElBbXhoOHZNcXRBenp6T1dENmZVVEJuWThhOXQ0TXJneHB4SCtv?=
 =?utf-8?B?TW5zTWwrSk8zUURhU3lDTlRoZ2ptTm5nUWNUT3lBQ25ZdnFCMUdPMDNCZ3pm?=
 =?utf-8?B?T2Z3cWNLbDZpR3RTQ2hYTEdTaWVOelNUUU1WcjlRVktGRzhLS3ZRendUL1NC?=
 =?utf-8?B?Y2hML1JoY24zZlpON29pSEJnVko4QzRFSG5MUFNOYTB5ZnBnYmJmWUE3a09o?=
 =?utf-8?B?aXRTWkhxZXZUejJoc2Q4b29RbFB1bjdLS2ZsQzI1Z0EwaWJRQ01DVlp3OTAv?=
 =?utf-8?B?ZkxSaVVzcThSenhNYnFnazg4S0JsaFNOLzN5YzVkUVVJMFdReDZEclBnQUMy?=
 =?utf-8?B?ekNRTm11VTEveisvbkwxK2tmcVNlbUV0MWVDdUNLNG83M0tDcDFMeWl1OVlw?=
 =?utf-8?B?ak8xbkVoY01BS0pFNHQzaStFVGp6cUJGTGlzM2pwZVlJK2hTVStiQVN0MUJ3?=
 =?utf-8?B?aTMrRk1YYzlEWWtkazFGL2lkZTB3eWlTMVRvUnlFdlR3ZHdwYXh3ZTFhaXJJ?=
 =?utf-8?B?YmswQTE4MGoyQm1NRlMrSmppZEMwTzV0VVBTc1RUb3hlcGYvVnYrblJGWTJp?=
 =?utf-8?B?UWVBUi95R3lzOHdQNWtyOUhpVm5EWVJWOTQyVWsyTzVnK1gvTnhweCtQSDYr?=
 =?utf-8?B?ejA3ZW1JRWVzdWJCYnFaT2NWQVMyMGtvR0JkVjhRcjh5YzFoRVRPMHlBcWRC?=
 =?utf-8?B?K2VXQjNtODB4Zis0M0RtQ0tQTm02cVhrY21PVXdoZ0JWVm5JLzVLMVF4Z3RX?=
 =?utf-8?B?a1JycjFJSFZYMlgyK1hGM1BQUkhFeXV4OGErcFR2UnBvdmRoTC9YWlZOa096?=
 =?utf-8?B?TjE2SWk3RjlNZEE1ayttVEZSeUlkRGJXL0lRd0lQVkphNEh3ejBxNWRZL0ZM?=
 =?utf-8?B?SDc4aEV3TXBBQXVlaFNnUzdYUFFHM1QzVnhDSmZWTUNTdXJFaTlrTDlTaVd3?=
 =?utf-8?B?M1FqOHlON3lKSzdiR2t5UjlheStSTmk3VUJwSGJ1TCtqYUJDQkRSeXYxT1dw?=
 =?utf-8?B?S2hIdlRTNXJSM0l5NkJtUmtuZGFrRjJ4Z0V2dHRsemM1SmZuYjROeGJSSDV6?=
 =?utf-8?B?bTlMOHhUc0pJV0FTMmxpbzUwaHFQdkZSZTl2TndEY3VrVHRWRlZKeEZPbmJZ?=
 =?utf-8?B?L205QStycDhUV3picXRBYTVhVmVGd21qUUUrcG1ZQXBTOGZnVkFDRkp2WXZV?=
 =?utf-8?B?VkRzK3Qvdm1nUHA5aHZMN3VId0NPczFRTWJkQVh1Y2JhNFduTjM2eGNYL2J0?=
 =?utf-8?B?UjhOUTNYRUozTGw0Z2dlTHc5MmsyTG5WUkxiTmNIbFJBNm1ObWRmUkdOVGhq?=
 =?utf-8?B?QzRqTGRIMU1vVzc0SVcrMTRzOVVmbk9yblh1QWlLVklxbDZKRzlXdXpSNXBY?=
 =?utf-8?B?U3dNemFDUWJ6aEltcWUxRjdtczVzMTJMZzlkVkdyRDM2S1ZhV01heXhWRGlz?=
 =?utf-8?B?RUxmL0NDVml3eFlscEVWeUdlVXN4QVRCaEVNMlFoUHhDYUFrZWRQMzJ3WkZF?=
 =?utf-8?B?QlFXcDRWRWlzb2ZPZ2FMaXdzZHBEb0ExUTFJNW9OZ2Y3a2VhMUNUcVVyazl5?=
 =?utf-8?B?RTZXZ2s1emhJTVRXNGVxS1orYld5aUkybzlQdzJIdStjRXZ0c05OaVhoQVNm?=
 =?utf-8?B?ZkJDRDFWNHZpUFhMWWpLVTIyZ3hZSFBKYmw1Wm1oeGM0dDM1b3hjOHc5Z1Ex?=
 =?utf-8?B?bG96NW1NUTB0TklkU3BQY3E5K2xRS0hOTG10Snp5L2gxTDZUZTBPRGRaRlNL?=
 =?utf-8?B?VW12UGVHT2xFRmVTY3NZRmRKRFBHblBjUzVXSjh4R3p1dDFFa2Z3eHY0MTR6?=
 =?utf-8?B?b1AvMVg1dEpxcG1sTjl5R1M2L2t3cC9JSnBVSnVvVytCaFNpM0t3NWxsVXdD?=
 =?utf-8?B?ZnlSVUFiQXIwVlR3VnVOSkNMWDdRPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c014ea21-54ad-4a61-5b4f-08ddd677065b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:28:05.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyE9aofhGCjtISZGxoRfFd2NEwGZHAKzwLuQo216lpCWc2FpPumEginuSIaI406+PwELqqaYsNq+TOARFgF8s7OxE1xhQO24UoEEkH+8Hm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6861

Hi Denis,

On 8/1/25 22:39, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
>> Add callback that can be used by the VPN plugins to tell the vpn_driver
>> whether it uses VPN agent or not. Default to using VPN agent if the
>> function is not defined.
>>
>> This is done to accommodate the state transition in vpn-provider when
>> the VPN does not utilize VPN agent.
> 
> What about the case where previous credentials are cached?

This does not have anything to do with caching of credentials? It just 
makes it possible to tell if the plugin uses or does not use agent. If 
there are issues with caching it should be addressed elsewhere and in 
separate patch I think. Sorry for not really understanding what you mean 
now.

> 
>> ---
>>   vpn/plugins/vpn.c  | 22 ++++++++++++++++++++++
>>   vpn/plugins/vpn.h  |  1 +
>>   vpn/vpn-provider.h |  1 +
>>   3 files changed, 24 insertions(+)
>>
> 
> <snip>
> 
>> diff --git a/vpn/plugins/vpn.h b/vpn/plugins/vpn.h
>> index a8d24fc3..b24cbf9b 100644
>> --- a/vpn/plugins/vpn.h
>> +++ b/vpn/plugins/vpn.h
>> @@ -57,6 +57,7 @@ struct vpn_driver {
>>       int (*route_env_parse) (struct vpn_provider *provider, const 
>> char *key,
>>               int *family, unsigned long *idx,
>>               enum vpn_provider_route_type *type);
>> +    bool (*uses_vpn_agent) (struct vpn_provider *provider);
> 
> The only user of this would seem to be wireguard which blankly returns 
> false. Can this be made into a boolean of a set of flags instead?

I simply followed the approach that is used by the VPNs in general. 
Seemed simplest and most readable way to do it.

Sure, it can be extended to be a setup flag based system but it is then 
different of what the VPNs generally use, possibly requiring more changes.

> 
>>   };
>>   int vpn_register(const char *name, const struct vpn_driver *driver,
> 
> Regards,
> -Denis

BR,
  Jussi

