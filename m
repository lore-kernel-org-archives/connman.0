Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2131.outbound.protection.outlook.com [40.107.104.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63DEEC3
	for <connman@lists.linux.dev>; Tue, 15 Apr 2025 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708501; cv=fail; b=bYL1xSK0Hi1GJpBU7y63D//InARcl2rog+VoXQkOMVHCKKJyln/LqszZ2nKihLFfgL7IGzJgB6Nrd2io8OJhgeGiodJrEvomhCtfwHRABIqwnc6FyEGZCv3Sv80r/fnrb6odJDeZ5fZP2i/rZH1nFa5vgyeOoRhrSzhAgioby5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708501; c=relaxed/simple;
	bh=iYU2J2h+veywF0r+aX6Y8z8mXP1Ic4MOdd+UOWUEld0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MHEC5Y6+DmVcvDopZ4zPWBgiXUICEG5StDq1wL18i5ohev9ATHcfUkGcBFwsv3PYreJb9A3XjsOQv68o313ct+bHeoJlNUwPIWdKxpnFr+u+fbC3YwICVzgxj7uVK5OdZf+vgzWzKqmSTOmp/tFySNqm4Q0oXpSaQeghDzlT9i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=IF+Wk/pE; arc=fail smtp.client-ip=40.107.104.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="IF+Wk/pE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phyBFx8I/pApRHAPT5IL8UuyK6ZxfFqbQBw4E+glW2v4Np9po7DQERRSoRAgy7OEX9/AqKbJ06qtSvlOs4hoQNU4WgJnH2wkH3Ag6NNtY6eiE5o7XjTo9pC3lQD5uUHs7I4kqlusuAEz6ML2Fwy3lpSICv0TTVDX3SzZoIKkyZ4zQ/2d5Od49rTXjC0fldYkgVF0y2x0ae1WPecT1j3W7vSNJuW/Gtr+vovLDN/R8yRvFJtx0S1WEYUBdQzgz+ZDsDbvJ/hGVAwoxwqKwm0+h41JCGNlz408j4NmoPKVh7tmS78XfOOCEfchcReu+xMRS58UbDtEdMnExQ6VV9P+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8+omquLZJUFgjB7R/NpWcnUYt/GPPuIlyR6U0yImLQ=;
 b=Z0q3OKdQE2qhJM44EjgchB+fyNZB8IQk5fl5OfEl7WFQGhGKPnLY1nmRZLXMtFGY1SQ4Coy48dJjikf74ChskEPYyv+v2EfJMDUxeGDG1E5VP7ULNAUNYlzDK2iTdjU4O5JVFJoke+ErR4kr4UNKosFA9hVTAyuDsNH6cmcvT5bllmT4WQUMY91anlcZ7iLOXCJufClybYX7hohhnGn7Ly6yxvi4AKCi1lnkr4UEWqAGimoM2yoI2szAD6GkLhFUCzC/1/s8l4ACyKPcf2IFI/wVHSnmoI0Z5qamG4wES1KLVfkoaojLgQepF6so6VcDyt7gXBuYlkrAug3gvc2n+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8+omquLZJUFgjB7R/NpWcnUYt/GPPuIlyR6U0yImLQ=;
 b=IF+Wk/pEGq3do6r3lTlSlAraOd9utfz/cKEpI0Dp148D1vjY//SO1bJcXHwm6RzjJGfHXSeqo5hB4U5g6JBgZVlyNXM9xX1+sHEfKNkzBTIwfEXf7OiBj6GH+NLeZ4UsAvmdn/85SrLKAanlh4Hfrzhp38d2G7OaXMiNH8hcHFnMy2IUrc3+Ijka3S86xHZGcAAXkfHQbjK4XTMI4SF9EHMBDSdUMWP1zE/vI578bvgoI14MBljJcTw72z5tTfhNGxiz2dBvSY5oPeXB3pmHcQQ0YQ1jXrFCNs5Rh7Xg088D8XgIzWTaVd69JpfUpiqCdUrKjbgc/m3u36Vy+2Xj1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PR3PR06MB6747.eurprd06.prod.outlook.com (2603:10a6:102:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 09:14:54 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 09:14:53 +0000
Message-ID: <1f1eb2d9-87bb-4474-9b49-fa219310bca9@jolla.com>
Date: Tue, 15 Apr 2025 12:14:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Add association state for VPNs
To: Christian Hewitt <christianshewitt@gmail.com>,
 Denis Kenzior <denkenz@gmail.com>
Cc: connman@lists.linux.dev
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
 <00708344-6372-45AF-BA3E-AA45DC298373@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <00708344-6372-45AF-BA3E-AA45DC298373@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::35) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PR3PR06MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a00682-1fea-4962-54c5-08dd7bfdfb93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU1YSnJSQkptNVRWcVBaZ2ZnMm5HR0lCNFlYaHJJLzNyOGYyZWQ5Ynh5b0p2?=
 =?utf-8?B?OGE2NGFVNnFhalBKR3R2bUp6dldlZTA5RlV2TDRQeUZ1NDhJNTkxalpmOFlP?=
 =?utf-8?B?aEFFell4c2lsOEh6RzZnZjNZdEYrakpNSGp5WkhWS0EvQVprTGc4ZGhOMDVj?=
 =?utf-8?B?c0FsVFJYTktoODFDTXpZL3pTVlNjOUY1cWpxbXpJQVVNZ1BpcG12VEhqdU9m?=
 =?utf-8?B?NDNSZlduam1IVnJFU3dIM09kVEVBY1JaalZuL21RYnZJSkpsbWx1bDBmeWlX?=
 =?utf-8?B?WGJTZGxHYjhnS0g2MXlCNk44N1ZtN0F2aXVYWVlaUjRXWjA0VDNDMjdzWFpo?=
 =?utf-8?B?aEZ4UDJ1eFQ2aTY2TzNwV1ZQb2pQaDRlZWlwTWVKL1pvUjZ0UEQ3bHdKTXFC?=
 =?utf-8?B?OERVZFFLeEVNRHF2Y1BQUEYwWkhYblNkVEJqOW1OKzRsa3FCZVZHc1NDTnZH?=
 =?utf-8?B?d2lNTTR5ZTZiWk1ha2w0NHZkN2dyUWtqbENIOEtzSm1wR0RoZ0NBS21jZ0pw?=
 =?utf-8?B?SHpsSUZ0TFFUU2xFZTQ2VEp0UGg5WEhFWVJjcVN5enFGaGlHMDNYVmt4TjlX?=
 =?utf-8?B?QUtFWWRBdEFHOFNsRUVjVncydVkzOGpuU2ZjTTRRT0xPVWlkZ015UXUwVUhP?=
 =?utf-8?B?VkFCcEU4ekxJOXRMU3duazN1UUVvd1VrSEFFRnRMMWZ6RktTWVlWNUcwbzUw?=
 =?utf-8?B?elJxS1A2TnkvSVFldXcyZ2pyUHFCbGtJRFVMM3M3U3VOcEcxNGk1a2h0YXBo?=
 =?utf-8?B?dXh2cXEyMFlPUHNVcWRBL1N3QlRYU1Rmc1FJSi9GVjZ3bGhBN0pvWnd4Y1g4?=
 =?utf-8?B?RTVBUHlqbkRod2Freks2QXBDWTd6TjhHYzV2T01sU2VvMEd2MFFicXNydmVD?=
 =?utf-8?B?Ymlvd0E1YmRYZHBUdHdhaitsSEhZQnY5VU5VTUovdHN2ZkdDVE4ycTBtMFpP?=
 =?utf-8?B?R1FFTlpLMXNZSUJiLzh4ZFZkTENpZmlBcjZDdng2QW9DL0ZKUUlGY0V1d0M5?=
 =?utf-8?B?VVhJTEd2b1h1VDJqNFpYT3BaT1hxemZmaVMvYmRFQXRxZ1I5Qk4yelBQZzhV?=
 =?utf-8?B?L1ZxckwzRERDeU1lMnhFeURXNFVEd1gvcTNCRlBpcjRaUlo4SDRCM0xrbDBm?=
 =?utf-8?B?a2Z5eTFPTTFwS0hSU25DZ0Q2d1c5REozVmJndjFMeGJCYXpHbVBoY09EWEdS?=
 =?utf-8?B?WHNNdjEreE84bHhWeVBsdFVCUXJSQnpFU3JlYlltcEg0bjV5aXpvOTlTc29v?=
 =?utf-8?B?Y3ZPendFMDRncytMQWhRa3ZuMjBIUHI3VjZJRVlmRDFKdlRDaUJaMS8zSER1?=
 =?utf-8?B?c1hqUjk3dEMwVEJvZ1YrZXlscXIrZ2ZIU0lxa1lqZldSVXFnMUNFMzFUZFA0?=
 =?utf-8?B?NXlWTzlRT2F3OUJ6V0l1RlliZGhybWVXUlBBcU5TbUdGcWx0NnhHa3NrZWR4?=
 =?utf-8?B?L1N4VEo1Sm5pQjZrTzdORExXSGNmT3NxOEc2bTdQU1RPeVJ2eEN2Tjk0TEt6?=
 =?utf-8?B?TzRlK2t6TTh0S1dWZC9vZ1JnWDRoOFIycUt3TWdpaitySmdyamNpUmlzWVBS?=
 =?utf-8?B?eXJQZExucmhCc01BKzVCRHpkOGFrM3kya1lJbFZVVWxwaWgveXVaTmFhMzJ6?=
 =?utf-8?B?WVdZTVZCWC9DVGlTZWNleVM5cUYwNmdhczRFQTAyNjhMOTNJeUtYM200QmVs?=
 =?utf-8?B?T0MyejYwUGI4SWcvNnd1cUFkTjF3eU5RQ3I1b0JtK0RnbjdNTFI4VW9rRkJZ?=
 =?utf-8?B?cHNEa0I4Zm1wOHlXcnRjRTM5V1NPTlpuWjdWektkY05SdERnbmI3ZFVXdzJY?=
 =?utf-8?Q?brWicXc764KpCSw4+yku5A5hkQUml09gmdVjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjRLaWZnOFNNRG92Y1pFNzlwM3R0dXg4VkhYNXB6ZEFzYmpQYjlZTFY1SFpW?=
 =?utf-8?B?aHZWcjFyYmxMR0g4NENDVm1JcDNLajdqeng5QjRZaGFnMWx1eFU0VTNmRzJG?=
 =?utf-8?B?ZUNkTHZuK1VDWmFRRjhCM1QrWmJrOW0wbnIzdFNJTDRaSXhnSlB4SU1PU0E2?=
 =?utf-8?B?My9mbXQzNTE4MjRMS0kzQWgwdStidzBjSW9UUjBKeCt1MVlDSmdzQzhzTSt2?=
 =?utf-8?B?Zk81K05pTjB1RXlrZGhMNGt1aTZmSjRPc0dROUdqSGFQejFhd2p4cTRXblhB?=
 =?utf-8?B?U25PWTRMcFlZenllZzVkd0NHR2tLSlNsMW5pT1FmcmJqUFMvNnhYK1NFUXoy?=
 =?utf-8?B?empoa1p2UE5kMnpobDBmYzFQamNWUEcvajZpU2dvQ1BlYXN0dW0xR3YwTHZP?=
 =?utf-8?B?VHR0U3cveFpXVjBqUXVDcjNkOVpjdFFNSlNVRFVlSy9OdS92ZHRvQ3NjMHE4?=
 =?utf-8?B?R1dySUk2NlpGbTRBV0RGd0ltdCtCNmNnd0pjb1VCd21sNVdKYWRhd0VFenVR?=
 =?utf-8?B?MjBFVGluVEQ3UmVuYjdtYytvYjBtYjhnOCtaWFY1cVBjam9veWFkeHBEVGdD?=
 =?utf-8?B?MEJDbmZhQ0VUNklFNHhCSEFJTG1LSERhUG5laUpVOFlacXlTRkFuV0NhZ043?=
 =?utf-8?B?Sm9sYkJlTVpMOXdhOXNFaUJJYmk1Smw4elFGaXduYVQrSmRVMFhLamJEYnN6?=
 =?utf-8?B?QnNuMFlWWHZyUzF1aE5XeGdCZ3RVNGVTSHNycFlwdXRRUTk5UmJUazJXbGhL?=
 =?utf-8?B?cjZDMGhlQVZHWVVvV2tEeUcvMVhvcEtzempMZTEyenhwSUZaMVk4MUlubjB4?=
 =?utf-8?B?eDd5eFA4REdiNEZCczFSQmcyczgyZ05uVThhOFpjcGlMMXpoRVp0ckdsT2FK?=
 =?utf-8?B?NlVnVXJ1Vk5EbFN3ZTI1eGl2TVJpNHFkUUNCTnJTbkZvMHA5MEFQb0QwZGdt?=
 =?utf-8?B?UUNTeFNCRk1FUzlQZitVTEp2QldLTXVlNWRkZkxlaWM3a3VMZVBGd2Q4TWxD?=
 =?utf-8?B?dGlzQmoyNjZSRHZPV0RlQ0c4RHlSb2lmVGxMZlpwRUJrbmJSdXlDNTZ0RFFk?=
 =?utf-8?B?Zk5vRUhRdEgxaWdLbThxUnJmVE0raUtyY1BIbzFqR1pWbitEM2VEd1ZZWENu?=
 =?utf-8?B?K2pQYlcxNkxOdWkxeVhucmdBcmRUNTVDRExnT1prYkE4cEh4dmVaS3A3YUpQ?=
 =?utf-8?B?a1RwS3RHa3B5WUpPZTRPYmo0U2RBOEJzWGJieWsvSFVHT1hwNm12THhkK3E1?=
 =?utf-8?B?NzBWQk1ISmFSVU1WaGhNbnVYM3kycnVvYUFuTXFnRHROZFZjeUlQeERWYWNR?=
 =?utf-8?B?UGVKUk5lQ0creHhpb3cvWkxvbmZoaStDQXE0S2gzNjJwUGNhY3QwRVh2QVMv?=
 =?utf-8?B?UTRHUkJ3cUdIdkczMU4yNC9jaFlteTdRVE1McDhObkoyaHJsY2RvNDhIblcv?=
 =?utf-8?B?VXBlOUFTTmhGUnlmVXljZ1dCR0VrY1FEMkhuVmFHT0xJZmFwNHZZUnh5aGg5?=
 =?utf-8?B?VTlwd0JMVVVNSzN5OFRzTlhwUnFkL0Z0Z3JlREQ3eUx3VWtzMTFscjdSNnJS?=
 =?utf-8?B?bWpKai9PVEljeGtmY0ozSGVNcXc0cUE4OHp1QUtRT2Q4R0VlSENNSE1ZSjQr?=
 =?utf-8?B?R1JSMzZIQlFlV0RHd2FaalI3RDBYOEVaUFhVREU2dkRhT0wzOWlzOHk5MFU1?=
 =?utf-8?B?TFpMU2N0Wko4OThJZEFYdXlSZGI0YWN6NlFJekJjYURtUUZLdWhFc2NoOVIx?=
 =?utf-8?B?TVk4WHpaaGRNam5iZytoZXdHeXZsbnd0MG04ZXplSEN0dnFDWWdxbXhHVDhj?=
 =?utf-8?B?WUIvQlR4V1VIc25aYlc5dXV4OEtZb085clMvU1BjWHpTckdhdVd4d0QzSExC?=
 =?utf-8?B?Q3BnWFhBcFgzT1I5VXBFa2NzK0dwaHNlMnRENkVSY0hHWXlNYk51OWtwUVAr?=
 =?utf-8?B?Y0IzMmZqTG51ays5VmtHcStJaUNTeTNHU3grY1c4WFZ6bTROaFNkbHRuU0g0?=
 =?utf-8?B?N1M0UFhvMm1tVEVNNDBqSFJzNUZUbDl0SGVEQzd4UVVnODlKblVWUWd6TSsy?=
 =?utf-8?B?dCttYWcyNzQyK1ZMM0kwVnptazhubUtScFQycS9GWG51enlzWjZSd1dkZ0kw?=
 =?utf-8?B?UmxiR1RNRWQ4RUsvL3c1NHhxcHV5ZWJBQWhSWUZLa2tqa0UxbW9QR29yVGtG?=
 =?utf-8?B?RndMZUUxeXpzei96cy9kcmp1RGhpR21CcVFyS3hQNFdBY25ZM3NHekRJck1t?=
 =?utf-8?B?RXBYVjEwR0dBTnF1dmRtSjh6WVNBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a00682-1fea-4962-54c5-08dd7bfdfb93
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 09:14:53.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D5eswJ6XjueUPcw6chRQIwMDQzkvsfPxADSaszM706+hUdA5G6pJTtsIPhf0BFLJHLP28LBTZ3d2UL7y2Sqi+Sej6loeN1IXWIxyDIeDtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6747

Hi all!

On 2/14/25 08:30, Christian Hewitt wrote:
>> On 24 Jan 2025, at 10:58 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>
>> This patch set adds the association state also for the VPNs. This state is to
>> indicate that the VPN is waiting for VPN agent to provide input given by user.
>> In this state service.c must not do connect timeout checks as the timers for
>> both differ in length, default being 120s for connect timeout and 300s for VPN
>> agent dialog timeout.
>>
>> In order to facilitate this change the association state had to be implemented
>> also for VPNs. It is common state for services and like with services the
>> association state for VPNs preceeds the configuration state (on VPN side
>> connect state). Both vpn.c plugins on connmand and vpnd side require changes
>> to accommodate this state. When the VPN agent succeeds in getting the input
>> from the user the state transitions from association to connect (configuration)
>> state and, thus, requires no specific changes to VPN plugins.
>>
>> On connmand side the association state is the initial state when VPN is getting
>> connected and the state needs to be accounted as a connecting state in
>> plugins/vpn.c to not to lose transport ident for it and in provider.c as a
>> pre-configuration state to not to start the connect timeout for the VPN before
>> the VPN is in configuration state. The reason for the latter is that the
>> connect timeout should be exact and start from the point when
>> connect/configuration state is entered.
>>
>> On vpnd side association state is, like on connmand side, the initial state for
>> the VPN getting connected. After the VPN agent succeeds getting the information
>> from the user (credentials) the state transitions to connect (configuratioin).
>> There may be a possibility for a VPN plugin to run without VPN agent and thus
>> in these cases it is ensured that the vpn/plugins/vpn.c:vpn_notify() does
>> the state transition in such cases. It is allowed go back to association state
>> from connect state but not from other states.
>>
>> Jussi Laakkonen (11):
>>   agent: Cancel agent request on NoReply D-Bus error
>>   vpn-provider: Use association state for VPN agent input wait
>>   vpn: Add association state before connect state
>>   vpn-agent: Do connect state transition after input dialog check
>>   service: Explicit VPN connect timeout, ignore in VPN agent wait
>>   provider: Handle VPN configuration and association states
>>   vpn: Add support for association state, add state getter
>>   vpn: Check if connecting when setting state or disconnecting
>>   vpn: Add VPN agent use callback for plugins
>>   vpn-provider: Transition to CONNECT state with agentless VPNs
>>   doc: Update VPN documentation for association state
>>
>> doc/vpn-connection-api.txt |  4 +--
>> doc/vpn-overview.txt       |  7 ++++-
>> include/provider.h         |  9 +++---
>> plugins/vpn.c              | 23 ++++++++++++---
>> src/agent.c                |  4 ++-
>> src/connman.h              |  2 ++
>> src/provider.c             | 22 ++++++++++++++-
>> src/service.c              | 52 ++++++++++++++++++++++++++++++----
>> vpn/plugins/vpn.c          | 44 ++++++++++++++++++++++++++++-
>> vpn/plugins/vpn.h          | 12 ++++----
>> vpn/vpn-agent.c            |  6 +++-
>> vpn/vpn-provider.c         | 58 ++++++++++++++++++++++++++++++++++----
>> vpn/vpn-provider.h         |  7 +++++
>> 13 files changed, 220 insertions(+), 30 deletions(-)
> 
> I’ve been using this series combined with the following series and patch for several weeks:
> 
> https://patchwork.kernel.org/project/connman/list/?series=928220
> https://patchwork.kernel.org/project/connman/patch/DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/
> 
> Plus a revert of this commit which I’ve previously flagged as breaking the default “route all traffic down tunnel” with WireGuard (the main use-case for LibreELEC users):
> 
> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=9eb1772d31b6fcf78e8711976696491aec9ff5df
> 
> For easier testing all patches are in this branch: https://github.com/chewitt/connman/commits/wireguard
> 
> No issues observed, so:
> 
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> 

Denis: The testing of WireGuard changes was done with these changes as 
well, should I resend these patches? I'll try to find time 
today/tomorrow to check if they still apply, and if not, I'll send v2.

- Jussi

