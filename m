Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3520E308
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737631340; cv=fail; b=hVUvHffzjgyMBLKNIMDQCpHEbPgQl/hlsY0v+lqIVNFiLNDSPY5FSgSXJnUGmMNfLCztgxto8eAZLrYd926LA6ptEL2Jt2Mt/eKh93aIuJftJaoLvd9PChjvDm21XG5RNUi6kSuxDPhp64muAgG8wL7IoeIHKVBHqi52larbO0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737631340; c=relaxed/simple;
	bh=k3tzl1Yrc7vEwzaPxhLQ9Bh61su8dB5jnB6OiHtfOqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OzMPVq3YaCQH1LDc8VlnTmD5kxwf0ZlOgMtURftHjXh8j/mfi39BnKBJzsy3WdHxFeNgDNfV1vLL/IGlTXgFhHIXMB+9SBqK2og5pjioCow+oN5ajVy1oOtqr4kOV0i8IGA/Z8GXWFP/VIwaI8NqRiVokURRPU74RsgTlSIXA4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=avH9H3qc; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="avH9H3qc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHyYhD99ts+KolDyoN2mgnlKfGjjh0UpsQH+wFKHwwPGOdy5oAVPkBfQmHmVtdafNb24VmFRin7g5+WeUtcqz4MGUuMiosFOsG7mgjWDfe+URfjM6SQzExmNWm09yFC2+sNyN5i+HxYX635240yeqTvRWm7C5vkmfuhluxAZdy+FiZ8Mn6mLt45Mj417qHiMTDurGPRgeFtkqCYZGE8FHiN0dB9fS8lLrpyA2O6RYHnvU6suqJeAOUq7jnQlrLZwrzVCEkWJkPvxWyzbAaDb/ZqmMTJqKu4kZmYqlrn025eHbBTqR1aRWgJXrvoDhV4ImLyBhGwYq9t3BXlerSOb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBK5GZtfpPs98Ori732u/9anxvejXoUxpKtlXIn+Tkw=;
 b=jNQDm2bMRM+qupTQsHyBxXpa1gco2sw7eeuNRVuEMh3ARtOqsgp1WsytENZfyOyKAxYcGCODsZNNEhPXxPQulyYPAwjs6a081QndIpAX3clmqsZNKBVb6jv4sqM6wR6ue0V9enZwZMUrK6jDw5BHAUlqSWs9MuVZTpVenmNABiI//nKRXiCt/2gZKaMTG+Ns2rKW8vxi8SSi5AfGS2l0e8N9NCt0QCRr11f96xWgW0dbabeRqlyslhCpGn6OsQIrxxMspOhfpP1WBwnEBsRtXIpbSpvJfotUnQWR9mT6Cengfq2tR+DeRcl0aH9SNz1LNhsbjli57xpI3t5aYKretA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBK5GZtfpPs98Ori732u/9anxvejXoUxpKtlXIn+Tkw=;
 b=avH9H3qcfkLLMbnHJNr9+06rkki5np7TBPYKCkCWY3ddSeITNotONdz/AuDEuKrYkH4z3st8a6oyCfkz8LGd8Gm9EzuYPblJCcQlivEjH6tqL3N3Or0/iS/MLkYf2AATM/PsGG+hyeYXUEVU99EPvTyc85HzTCLm395LkHS+BTmlFIJ3zOorHW62D6fjEDdgkERLnfqWjpEk7PHkh6S7qC041ZWje3xIS/oXSdCU1ghHnZhE5f8SB1twia04WDseaXBJMgwVwG5qcXZl43XowAljkci/q+a/BD3dj15izS0e/yKDG79muzmq+VIM33ln1wnox+I4WgvIm3LDNL+Xbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by VI0PR06MB9543.eurprd06.prod.outlook.com (2603:10a6:800:24b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 11:22:13 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 11:22:13 +0000
Message-ID: <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com>
Date: Thu, 23 Jan 2025 13:22:12 +0200
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
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0000662E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3c4) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|VI0PR06MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 37180a0a-29bb-4b8b-a8b2-08dd3ba02f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3FwRkN1OGhqeXBzc25ZblV5MmhMT3pMTXp6cnE4aXU4cUhOSFR3SGZEMkln?=
 =?utf-8?B?dWtpUkxabEZOdGZFbkxMZDFqNnVBVjRCYW1yV2NVRzFaQkp0TTJDS1EvTktv?=
 =?utf-8?B?VisvRm5naWxVeVJWWExCWjZDZVZ4ay96ZUpRa2lkaURJL2F4YWNJcTJKU3Uw?=
 =?utf-8?B?REZsVGlnZFFxQWhmdVRvUG1SMlFOemdoWCs3MUpDZ2s1WC83YzI5WVBqNmp2?=
 =?utf-8?B?MHFLV2pyWHhJUHlneGpMTm9ia1FOdGo2UlpLMENjdW5UanptRS9WTC8ycXl4?=
 =?utf-8?B?YVpjdTNWeWxzZUxHMm1xZXc5eC9tbTBUcHBPRnpVY1pkU3plWDJVejlMQTIz?=
 =?utf-8?B?VzhQZGEyUlYwbVBZUEwxWWM1cXZ1NVZ5WUpDSHlZZGphNHZJMmRkNnhEaDRN?=
 =?utf-8?B?enhxc21nR0o2OXZMbXFYVVAwSmw2ZW9TY2dydU00ZE9MZDArK2s0WFQ2cHVw?=
 =?utf-8?B?R0ZQYnVTSmF2NWRIeWVIWjUvU0N3K1FXMk1LSHRsTWU0ZWc1MFV4VGFPblRD?=
 =?utf-8?B?WnVIQ3hEQnpYTVVKNmw3OWpwMVU5ZGNOY3pEeHl4V3RTcVhLcUVZL2h0Mkds?=
 =?utf-8?B?RlFWdVRlUlNJUlZaTlBsaWZBL281TUFjLzI3ekRKQmJYR2FlR0ZrdEo4L2dt?=
 =?utf-8?B?dGdXTGttRldtN09MdW5yOENRMXRtaTFoaWd6ZkxpalZ6ZjNMUXEzNm4xd2lC?=
 =?utf-8?B?MHhyVDl2S0JLS253SmhPMml5d2h1T0p3YTA3MjdhalBlbDVyYW00alplRHpS?=
 =?utf-8?B?ZTArdURYM2c5ejVUK3p2d2ViakZ6N2NwUnJ2U1FTVFVDbmd4djdhbG95eDI1?=
 =?utf-8?B?MlRkRlVreTlzeWlYR0E5SnQ5ZjMweXowYm9TS21UV292MDJuU012b1FlMU44?=
 =?utf-8?B?NkhsRlN4SXBEQVRIS3ZNMlYxb1BVMXQrb3BkUWhuNlM1SHMvZlhOTW9Cejk5?=
 =?utf-8?B?UUxJNWpLN0FwRUlGMTJYdmgxNEdYRDhYaGw2eDhtN2lpOVNGYjM3V0tsVzBr?=
 =?utf-8?B?eUxVT1p5WUVDWUdsK3R4ZmZUT2VrZVNvdEtNN09iWXQzSk85QncwSUxMYTBC?=
 =?utf-8?B?NVVQTXhnYWo5RmJibHRsT2tnLzUxbXRiWkdMeDdnbmEzMEU5SUpBU1c1bXdP?=
 =?utf-8?B?Y2pVdVRvQ0hmd2U5YU9HNG1HbkRlMFNETTF3dVczRXg5N1ZHVjdpdWhrTy8y?=
 =?utf-8?B?TkNUNTBuVUNncjl2eWZvWjhhdzdTTHhGbjg0YWtsRkd6aWpFbE1TU21aU3VB?=
 =?utf-8?B?ZDhTM3h6ZXllb0ttc28rQ2FEdnhLUkR5MWxpcnQ1UmEyNFdXMUlLL3ZlMEpX?=
 =?utf-8?B?bmF3bU1ISEZCS2NURUJNL0l0T1V4M2d1T3FHZE0xMDQzN0Q3bGtMVXNkZG5Q?=
 =?utf-8?B?Zlh1REMrRFZFUjlxK3ZseUdLN0E1eXRzVWZwblRYRm11Sjh5d2N3clFZSmpo?=
 =?utf-8?B?VDB6dURub0NiSjc2UjNyVzNCa2FQNmJnOUg2ejlaVkVjcGZRUThCdWhCdWI1?=
 =?utf-8?B?dlFqeDc5MmdxMWE2QWJ3cUJXQ3ZGSXJNbDZGVVY0QkVBQ25qSDVtK1VYWlN2?=
 =?utf-8?B?b2hnbFNVWUhwQnNjbGpHNDNXaWxIMWJ3WTFDR1dLYmNxV0VwQnZsMHJTVnQv?=
 =?utf-8?B?NlRoNHRnN3N1Qnl2QURsT2pLNDlFWUpIclRTeVRnMm0vNmhubDZQbFNndEhk?=
 =?utf-8?B?QTcrbDJMUUpWQncwVEg5LzBmNnFpMEJza0hnSDRmZDRyeHh6NHMvb01tSVRj?=
 =?utf-8?B?enZoMXkrUUZhOElBZVVzOUNaZmpmZ3BlbUttVHVKTlV0KzIwdTdiMjQwWnA2?=
 =?utf-8?B?RFYzUGJNR0p3bHJwNkNudz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDNybm80MVhiZTAycHUrTENEYWRZYXZNWGNrSG5BVEV5KzRNUFBJUisvY1Yz?=
 =?utf-8?B?RlBYQ1lxYVVvTlpKQ1ZDM2F1ak5NTDEwSXlzeXp0YUVDaUFzV2ZjNGN1aFRS?=
 =?utf-8?B?NU1yb3RHWFdSQk00SXdCS0lkbXJOWVJJTnRSdTVpbk85SHY2aG9hRk5ITUJq?=
 =?utf-8?B?VVY0aTdrek1Za3hvSlE2aU9aOElVaGxHbFJzYitLa2wzMXpDK0dHUzVtZm15?=
 =?utf-8?B?VElIZnJDYVdLTk9Yd3YrRzJJRU5uSG5hU2pidS9xdzVCU3RKYVpuUjZkeTdt?=
 =?utf-8?B?eHpibkd3U0FVVzRGamNKOUJraVViVjZHRzRacUJVb1FKUnRvVnRjSXZGcGQy?=
 =?utf-8?B?elFhSHRXaUU1YUdlNkdsK1ZjdXlKQ2xPOG0ydFdUOGNMTGY3SUZZTTNVMmQ3?=
 =?utf-8?B?NWNmdDNONHVmVE1DdFBDa3Q4K3dhUEExRUpUMUJ5QmQzeSsweVdLU1h0NjYv?=
 =?utf-8?B?MnEveXVyNHo1cUNKU3RDaEdFRzI3MTNIYVpvcG1JQkZiVHlEd0N3S2Z0TXJE?=
 =?utf-8?B?RXdlLzYrOWx3NitUaDVBY21rdmRDWDY5Y21YRXlEY2crTHFUeVVuYmZJRTR6?=
 =?utf-8?B?b0YzRk5TTDh0WGdBNW0yckZmcFEvN25tM0JWZlNYMDlRNWJhNDhtczZyV0J1?=
 =?utf-8?B?Si9vVGhsMjVtTjhTOVZFWDdqbk1KeWxCZmk1Ykc4cUxFNFdJYjRNVEI5MEFw?=
 =?utf-8?B?Z1o2RUJ5Q2F6YzFoaU84eHJBSzRnQ0xtN21hQVdCK1ZGZ0daTVowcmpHOERz?=
 =?utf-8?B?b3MySWNmTWk3S2pSRm11eTRLaXk5NzlDQit4Wm45WnRLejZndFpUOUlKbGdz?=
 =?utf-8?B?cWdZckMzQTRHeXRBRzBtaGZSbkZJRVlOUVljUlJQbmY4U0xESmVodjRta28z?=
 =?utf-8?B?T1ljNmxDVVBNTkJRME8wWFlhZHUxby9HdktyMXBzR0hyUGJ5dGNSMDRHZGxB?=
 =?utf-8?B?RGVCY2ZZWmUvOWdhOEpXaTdhVXV1cFRnMy8rUmJvSlhuWkxpNGQyZlhwdm94?=
 =?utf-8?B?Ky9xNldhamloNVplZnJoZWZBVU5TeGxiSFFkRUJQTG4rUWZ1MHJDcnZ0UWk5?=
 =?utf-8?B?V29VdkN5SzBHc2gxb1l6OXVQM0xzK2ZCekxEMjhLSVpHVU11cjhydGlWU3pK?=
 =?utf-8?B?UVlodXc4OWRGdy9kaWM5bldnVElkcXlVZENUckQwU3ZzeGlEektZR0NPSFJP?=
 =?utf-8?B?ZGlTZndaL0xnVS90cjNEcnlGcTdSaTR3amtITU9DYitMSHJzYlQveUNURG81?=
 =?utf-8?B?eDFMRmc2WFlWZWM1eWdBMi9CVWRHUzBSRWtIb0IrTFNnMmk5VVNsd1BqcWNr?=
 =?utf-8?B?YWdMVHMxUStpMnZpZGRqYklGR3pwMkZVR3VhMElIVHdvZC94Rm0vdkorblVz?=
 =?utf-8?B?U1NBMisvU2ZwdXNZVTNwTmMrUFZpSmYxRDYzQlpVSmRWczRDL0dBSUN5ME9z?=
 =?utf-8?B?cWdMQ2RGMnNMdGxpancyZEJuMFNEK3EvYjgxdlBVTzZHWndjZ3RQTmFDcDdi?=
 =?utf-8?B?eDVmTW5DUmxpRDlBak1jc2dVbTRmbGN2Nk96RjZnaWhiWmJsenhHWDdjT1hE?=
 =?utf-8?B?V2w1aHJML0I0dEdIZHY2VlV2OCtBQWpuU3EzVlpSMWpTcDA3eGVKMkdCeTQ1?=
 =?utf-8?B?eDNhNWxPbzUrZEJNZUw1blEreC92LzVSUDg2UjdDSmtYSDNxQ2tmRWpTNDVS?=
 =?utf-8?B?azNsSU1CcDZmQTJWRzlJeHlkVzNOcmozalV4N3JVVGVKSkVXZzcvWHZsbVMx?=
 =?utf-8?B?V2UxZjE1dDl3RkJ4eVhIaGZWekpkWHE5M1JMYUpsVVgwTUMwdHoyQmR4QmFV?=
 =?utf-8?B?Y1Jhc210REhWb01XMHBMTVNjeUt3MTEvZXJwL0szYno0U3NsMTByVGlMNVdY?=
 =?utf-8?B?MG1BSG1pK09lcUtCS09lOVFlcW1uUnVCM3hqY1QweTdGaGdlVE9ZcjVSSElj?=
 =?utf-8?B?dWtYOGdiSDBySW9hU2UxWnZWTWZoZDVISUhBdDJnbG5lSFI2YlNWZTlYbERp?=
 =?utf-8?B?RWlkWVRZVnpBRytWVlJsbEdkUmcrMXY5OTkrZjJyYzhsT295NDNRMFZpRjFu?=
 =?utf-8?B?VWpZV3orbWlVN3ZFL3BLS2cxNG9MVk1mMGU3dXpIc1d6T0dyZktncDJxVnEw?=
 =?utf-8?B?Rzk4WnYralZCRWdjUlQ4eUlLN3RqVGlGeTFVVTBCRDFiRVUwb21kUDFkdzBi?=
 =?utf-8?B?azU4SW5jeGhXVkhCL2hURG9DamU1UEVIMktVR2RVMEFIWHlLakwwYS9jUitO?=
 =?utf-8?B?c1JONkVGME9FSkc0WDROaTRHQzZ3PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37180a0a-29bb-4b8b-a8b2-08dd3ba02f85
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 11:22:13.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 225RWdX94Xqeu/Otno+SyeS620ByldME3JHM7hgall+lVGu24wqPfV9XsSXXsDrYvpTJStyIUYow+hiXaCNjhZ7WfCCp00awa2rJqEgp2w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9543

Hi Christian,

That is actually in upstream, all the commits regarding WireGuard before 
July 10, 2024 are taken from the latest upstream and the changes after 
that are new features.

Well, the vpn.c changes do depend on having the ASSOCIATION state also 
for VPNs to be implemented, that was proposed in the RFC 
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 
as the state transitions depend on that bit. But it does not seem to be 
depending on the gateway.c/connection.c. Well, I can try to squeeze time 
to address the issues Daniel earlier raised on that RFC and push them to 
upstream, then make a big change on the vpn.c and wireguard.c.

Br,
  Jussi


On 1/23/25 13:12, Christian Hewitt wrote:
> You don't often get email from christianshewitt@gmail.com. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> Ohh.. I would be VERY keen to see support for FQDN’s resolving to dynamic IP’s upstreamed so this looks interesting:
> 
> https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972b866fdbd8bd
> 
> Is that feature dependent on any other changes? (being lazy.. I didn’t read all the commits in that branch yet!).
> 
> Christian
> 
> On 23 Jan 2025, at 3:06 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
> 
> Hello,
> 
> Regarding WireGuard, I had to make a bunch of changes to the latest version of it to get it running properly on our fork (yes, we upgrade it slowly, now 1.38): https://github.com/sailfishos/connman/commits/master/connman/vpn
> 
> But I haven't had time to figure out all that is needed for upstream to be sent first, like this RFC edit that was forgotten because of... "eastern winds blowing into our direction": https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
> 
> And then the connection.c was modified a lot (and renamed) and I'm not sure if these will work on top of that anymore. Mostly because we have features that may not have been compatible with latest upstream, like adding a support  for two different devices to be belonging into one service to facilitate CLAT support https://github.com/sailfishos/connman/commits/master/connman/src/connection.c etc. etc. etc.
> 
> At some point I'll start pushing changes but not sure when I have time. Mostly they could be RFCs as the changes are big.
> 
> BR,
> Jussi
> 
> 
> On 1/23/25 12:45, daniel antoine wrote:
> Hi
> I have opened a ticket for connman-vpn not working with wireguard  in
> April 2024. If you give me the patches I can test them
> Best regards
> Daniel
> Le mer. 22 janv. 2025 à 18:01, Grant Erickson
> <gerickson@nuovations.com> a écrit :
> 
> On Jan 13, 2025, at 5:59 AM, Gabriel Sanches <gabriel.sanches@prevas.dk> wrote:
> I was testing connman's wireguard plugin and got a segmentation fault.
> 
> Looking at the backtrace revealed that there are some typos in the `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 variables instead of ipv6 regarding vpn.
> 
> I simply changed them to ipv6 and got it working.
> 
> not related to the patch:
> I had to manually add ip route so the other devices could be pinged
> The plugin adds routes for the WireGuard.DNS configuration setting
> # ip route
> 1.1.1.1 dev wg0 scope link
> 8.8.8.8 dev wg0 scope link
> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
> 10.42.0.1 dev end1 scope link
> <vpn host ip> via 10.42.0.1 dev end1
> 
> the missing route added manually:
> ip route add 10.33.0.0/16 dev wg0 scope link
> 
> an equivalent wireguard file adds it properly (using wg-quick)
> 
> Is the plugin lacking some implementation?
> 
> ---
> src/gateway.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/gateway.c b/src/gateway.c
> index 16c87f83..b2c211e2 100644
> --- a/src/gateway.c
> +++ b/src/gateway.c
> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service *service,
>                                        is_gateway_config_vpn(
>                                                new_gateway->ipv4_config);
> 
> -             is_vpn6 = do_ipv4 &&
> -                                     new_gateway->ipv4_config &&
> +             is_vpn6 = do_ipv6 &&
> +                                     new_gateway->ipv6_config &&
>                                        is_gateway_config_vpn(
> -                                             new_gateway->ipv4_config);
> +                                             new_gateway->ipv6_config);
> 
>        } else {
>                if (do_ipv4 && new_gateway->ipv4_config)
> --
> 2.43.0
> 
> Gabriel,
> 
> Great catch on this copy-and-paste typo; thank you!
> 
> Best,
> 
> Grant
> 
> 
> 
> 
> 

