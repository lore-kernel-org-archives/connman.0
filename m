Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023099.outbound.protection.outlook.com [52.101.67.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C91C5F14
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630402; cv=fail; b=J572bTTpLkgiZZizmvKFIWhzgc2OYf7MLYQ30CYIS49YwdhG4TBy0vX/+cy8tltWrajHOOs038iUYTP9auNu/0rL4zA/btDvQo1SWEsEb++JdzzVPio+vIf7YERcfb2C73sC70JkjZLqIuuQ4gDAg86qOCChslmf7VnTfjOEZXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630402; c=relaxed/simple;
	bh=myr0l3oNQgCUjmF6bfaM6Y1bC0HS7w1U2V0ooL2Q5Ss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IRVXBQlOohyP1Y21DDX/TPMSiPMIj+31M9k/UZG4Z3rpmnEf5+Rpbz77esXMbR080Rx83X8BN6ARi5b9P07j/toYXEB+7WuUZb5J5nvyjEfdX3pKEjkTBKcK/7wUE3QoKAGNFBSAFqmp5spBjOzCUR12isgEUp+hPQcrb+zc1ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=xvqVki9c; arc=fail smtp.client-ip=52.101.67.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="xvqVki9c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPOLJvJtngRJLJkA3vUTgxl99Pnt93fkJ8TWntuU8NpmLyeMBoVoZkTHh+u8jGhKuiZLJd5JKOUh2eoNrw0kxrHJxoks8q+/pPSNItdnqRAOzvVbJigXKfkyiXpCpAVwsXJwP0lswHB7jbIprLjxG4p8YXtAfUjH/szGx0GbT8H7hAOwqK7UYM7FgAd6uhZs9q+0i145YY93tiGtokuXCa1C6mWZYx44wqp2ov8OTsptM0dtmBdCXK7kuN1MjyjYbZ4yV22vDoPEu2jvy+cz1TL8qgYjV9x67+Q7hbQ9Ofi5a1n3GdTC0KCDkA1wxmVxdw8Kotp2CRT3OdhUVvM0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7St5c/A6PShMhacwXyuDyUKyLCnujxzpwoKFtVq2YE=;
 b=Kjn9ALb+FipvckgdMSBw7Jge5B6fLyETK91ltKLrY7AFaaDO4rbOmcvt47Rc/eirOvu+YjSs12mcFTl1KZaHMNdD+HgVX3dMJ6l4FXONfsvI+HocS0ch7F4hMAOQC6sfpWU4laMRC+tXsMm+u3YrDcpi1cW/McjowrPLmvQmpWekFHfJ1z8TcJFURT1kfqV9IuAfFVeYkys5ykZ6DTEbw4mj3kdKLqL8dEi+0iWaz8LEeuAeuS9G/v6QheYBXtk/lQCqIyf9Ea1G6vNr3eG4Cvb/9ksCFVuaaEuJGdYWbAMW00ojboT2h9xqYWSdvSdxjtrXGksB4b91H69uNoTkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7St5c/A6PShMhacwXyuDyUKyLCnujxzpwoKFtVq2YE=;
 b=xvqVki9cSh3Sf7qt9eVDpEamiWGL3+y5hgsn0yLbCjaP6nEU4rOBUVBvq+srePKWOtye16j4YHcJ8ew3C+lBOf8glP6aMPepDnBWF6bsMSroQstuRs53g5QPbG6JPub7A7IvbJqPxL8uG3Tp/lcEFEUuPeeep4VIaq6b+eXqpLLCbT8xvvFW9veNLZfFiSoiVXaFALpROxvKUcMiblI8SuyVtwNw1UG2dFmHBwPC7f4OKQur4VasZtzddd19Ed3DoCxY06qKTrQwylVDeXPrZw+WrF0faqbpdVT+PD8LUDY0aSFGx0KJhOP8jPy/PbW8rSFoSVwElV45PyV/AS9NQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by VI2PR06MB9403.eurprd06.prod.outlook.com (2603:10a6:800:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 11:06:36 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 11:06:35 +0000
Message-ID: <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
Date: Thu, 23 Jan 2025 13:06:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
To: daniel antoine <univac55@gmail.com>,
 Grant Erickson <gerickson@nuovations.com>, christianshewitt@gmail.com
Cc: Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
 <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00003825.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:4) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|VI2PR06MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: caf91ede-60ac-44d3-ea77-08dd3b9e0062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlBidTFDNWpCWlFMM3pWME1zei9oMjBUNnFseVdhS1VuQTQ3NFBBdFRwQlpP?=
 =?utf-8?B?VThpUFIzOW9mUmFMYmFnWCtzMnZXNFBmelZZOEZ2ZXZqMWNKdjcxampCTVM2?=
 =?utf-8?B?REZKTk5yZlNPU09lZFhJcFJ1VnZpMWtkcHJrQjVSRThFanRyWm5uQXZUcmJG?=
 =?utf-8?B?NCtnbEwydkJ4K3ZuaC9pZTh3ZFY2cWVVQzhOSE1yVWpPTVRxRGRhb2pFOXl4?=
 =?utf-8?B?VjRSMEFYYSt2MnFWSVFDYis1d3RXdVhneW94ejhVTEJndi8xRnRXK1pJcDVs?=
 =?utf-8?B?TS9uZmJwcEc2SXU2MHFjbHB3SktJd1JVamVYem5GSU8zcUY5aGRnOTlwRlhL?=
 =?utf-8?B?YVN3VDB1RVdPSW5zK2hkNlpkVUgxanM2dkxmckJwMjBVZXBjYVJzZkowbjdR?=
 =?utf-8?B?RVVWTVdHN1ltcDhCZC9LeHhsT1Uwci9iY3pndjFBL3JBZFBSaFQwK0NZeTlD?=
 =?utf-8?B?QWphNCtkMW84OHB6R2tRNWV0TURpN2FsOTBxQ0dwUkRNaEpObHpRdW9tRy9w?=
 =?utf-8?B?aGJUamhYUksxdjZuRkFZcXdHOEM0T01uYTdTYnRoMzM5S0RXNElzTmJBSTA1?=
 =?utf-8?B?MW5EV1liNnlLMHh6VitqVGl5U255YUtTWGEyTHMyQ1RNOUZPTGMzU1hMaHlW?=
 =?utf-8?B?TnBpMHZGUXdHaGlYOTlGRm5ZOE9zMzJ2U3ZyRVZYRyt1ZytCaFoxcUVSSG43?=
 =?utf-8?B?S3ZqTldlbjNsbUJPTXdRdzhjOXJ1T0Y3NlhockpST3RWY1dJRDk2amJ4bEla?=
 =?utf-8?B?alhKMDZJc1BSY21KTTV1d01JSTJ0bzBIT294K0IrMzdkZWswbGhDZWpaVUxK?=
 =?utf-8?B?YmxHTTg2YVRxY016aXFKWGVKVTEzc3ZoMWtmQzkyRm9nUVk2a05kbitWQjVD?=
 =?utf-8?B?bWdYSmxvY2EzM3d2RXdkZW5LZGhCM1Vsd1B6Rmd1N28vRlVSRkNpMkxER0tM?=
 =?utf-8?B?UGVMMXFURVk2ZFpvdThOT1RKd09pK2E2Nk1vKzVsZGQ0enBmSzYzTTVFT0M3?=
 =?utf-8?B?ZWs1RVJId0p6QXdxaWR1bXZMeTJVQ0c0MzNjZFN6Q2pHZThPU2xyV3RqdDNB?=
 =?utf-8?B?YjVRNEhvS1dBRHppczVVTVIxWGhwdGx3THFrSmlDNU1QbG81L0lSazhaRVh1?=
 =?utf-8?B?d3VQc2dWaWsyenhBNko5SXZtejBZcUFMSEU5RlhHZlZpSXo2T0J5bnRQN0g2?=
 =?utf-8?B?cFFEdGVtNnFiMnFHVTZBSk5qVnJZZE12NmN2ZUhJcHYwZi9vL0UvNUhydWJV?=
 =?utf-8?B?eWhaWU0vSkNoS0xycGpQdzhWcFFtS0E0MjcwNXhGZzNEb2llRnhpeU9XdnBQ?=
 =?utf-8?B?czFHQ3NzaUFheGprbDJheUdLRWFKM2FtMk9IWFR2T21SUGlHWFV1bW82dWxr?=
 =?utf-8?B?Vk9rV254MlNHbERnZWVDWDB5bFhqWWlQMlZVdkhkcHMxSjRkejMwcmxDenFn?=
 =?utf-8?B?Zzd0T1lyVEpyV1FPM3Y2bGtDam1KVFpzTUwrdHRJaEwrZ0E3NnJiSmxWSWND?=
 =?utf-8?B?WWxmL1J0NCtpTzVKc2lhUUkxTUdheDBXa0JISlFrWFpHQmdDS0dDTVdyVnc0?=
 =?utf-8?B?aURnS1lTUXJjWlROTEsrMmkwVHZPMk9PWjJ3U09aMFE0RmNnSkVCTzRJenFk?=
 =?utf-8?B?NXlIeTJrQjdKTFhiQlhEVTRHSW52RnpveUxYZ3prY1FDQ3NTOXNLNTQxVjg4?=
 =?utf-8?B?c0l2MzR3dDFBRzhqQjhDRXpmVnB2cTRIVEtSQ1lJQVMvZHBxWExMMUIrR1Ir?=
 =?utf-8?B?TEdOR21mZW8xeHhrT3lVYm03bXdkMzUwN1N5WjN1UFhYQ2x6c05QTDVtejlw?=
 =?utf-8?B?V1Rac00rME5jbXdzZExsUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVRuYXZoL3hQQ3JXZjhrQkVPN0tQanlBc0hhSWJTT1dQQWFhTGVxejV3YUNW?=
 =?utf-8?B?eXI3L1RsRWw2MlJnbVlVdldrNExLNTJNQ3lhNU1KUVVGYzBnYjJIQmwxbk15?=
 =?utf-8?B?WkVYYlNUZGtXNW84WmowMkE4M0VyRlpRbUgrYThaUFNoQmx4MERZZFpqY0ll?=
 =?utf-8?B?Z3p3dXZuTDNnTCtxdHVia2JSTUcyZ0dnYm8wZzdDbWlQRGhhRTVXYnNwZHBI?=
 =?utf-8?B?Mm5RaHNTQzU5elQ1bUxBSjRETTVUUE9UdXRINld1bXlONXhlMElLZlpIMnBy?=
 =?utf-8?B?L3R5VGlvTVFMRFpFWHgxcDNzZndRZUNkSEQyd1hqMjNtZjg4MFlDNWE4R1FH?=
 =?utf-8?B?RDA4S3JieHVMMEJoaVd3NU1BYlYxUEJDb3A5VUxURkVzeEd6TkNsRlNiclZj?=
 =?utf-8?B?Wjl2QW9HVGhrQkJibGUySEUzMHcxRHJMVlp3bFZsRDFaUlh5a1NJNG1XU1Rz?=
 =?utf-8?B?YkZMMHYyWm01dUlWdE1uU29DV0doUGpRWDZpdzZoSDljQ3dxbEU5VkJPRHFE?=
 =?utf-8?B?bmtSdzVmdkRsRVRXOUk5cXcvNTJxVnZ2amNCWDRlazVDYjd0OVFPdy8yL1E1?=
 =?utf-8?B?MllKNzN5aHUxcytPTFh3YlVIUUNhdU1aYzJLTEU5N1pVcmVrSCsydHRZZHg4?=
 =?utf-8?B?c2x2TWlydHdHdUludVlteXdOcnE1NUI2TGxSSlZsRVhsZTQ0Q2UzOVVKblc0?=
 =?utf-8?B?Y2JURWg1bytzS01SaktPRUpCbjE3aGVBMy9GRVRXV3E1WUU1YjRyZ1pHN3lk?=
 =?utf-8?B?ZUlYVUZ4eUhJMzJDbG9yalMvYUdVQml2NFJvbmwrSmRRRkNHck9Wcy9Ob2Jp?=
 =?utf-8?B?V1JoYXhHTmVyRlBuSXFNcHd3S05LZ3RyUXZ2QlhIeGVWNTgwaTByZGNLMXpX?=
 =?utf-8?B?WVliTWNhcHNmc29TYXRJaDRWR21VNzFNTDMvbEx6ZWVnMUpqOUtxbVhtMlFu?=
 =?utf-8?B?ZFdWRlo0aWlvbDF1c0VvRXhxdkVUYU1tUldEb2JWS3V6MEdUcnhrWXFLQUlv?=
 =?utf-8?B?K2FGZTdDWFRXeGl4T0ViQ3A2Q3hoSHp1ZWhueEEySTJxZlpHODJLcDlmcTBr?=
 =?utf-8?B?WFVZYzY0M2pzOUo4MEJ3SUVHakxzOVl3ZnRNdU5hcWFDcnVIaVpLQUlPY2do?=
 =?utf-8?B?cXVvM1hoVkREYUpURjRBaUVoRHMvaG9ZcXNPdDBhNUttSU94Rm42d1NHV05z?=
 =?utf-8?B?a1ZqMUJwQTE4d2lIbFZPOE9ieHZ2VEhKYm1RUnRTOHRGc1l5bXVYSjZpNVI4?=
 =?utf-8?B?N2tuaGRPZkRSL3kxMDNGYll0aWZwVFkxRnozVTZEZ2xvS0lBeTVyS0c3T0tJ?=
 =?utf-8?B?MkdwWEN1ZHk0WDV5S3BvT3N1N3VzSnZRblJiYmxsUmh4MFAwditWYkNjSmxz?=
 =?utf-8?B?V3FpTkUyRVl5QkUyQ3Yyck1INW02U1VTbmZOb0hIVlg5NkFFMTdrZ0JlUERF?=
 =?utf-8?B?czNjWnI3bUFlSnBpdTZocG1tcC9WcGljbVliTktEMjhRZ3JzVmFOaXZOdTRz?=
 =?utf-8?B?c013UXphbURDWW5ZYXRpSm1wZllxNW5SWjY0RUJmemJWNTZab29adEJxMG5Z?=
 =?utf-8?B?dE1ISGllZVFoNVBxY3Z1K041WFNQRTJ4QldFcHUyTTMvMXRjN3ozeDV4SndM?=
 =?utf-8?B?bWl3eEdyOU5jQW1Wa0NvSnYzekF4TWdGSEVDVkxtNHQ1UnV6SHZ5bUdPL211?=
 =?utf-8?B?MWtZUkl1ZFB0MzNGWU5POUZ1WUJOcGdobFRLYkFIQUVxNVROVVdIOVJpS1Fv?=
 =?utf-8?B?SjJpWXBKbm1tM0gxSGczanduUnQ5UDVGUzYvdS9YQ2t2SHVwdVM3QWozRHZD?=
 =?utf-8?B?dUFadE5hQU1iUVoraHVFVU8wMlFMZ0tERmY0LzdscmNaV3E5SGFvYW80SW1F?=
 =?utf-8?B?eER5UWZENmJqdlJjTmdzazdPeEhsKzJwYzdjYkhOcXpnSGpPMS9UdFZCRHl6?=
 =?utf-8?B?REFpUDN4M2FFOHM1N00rNnJrbkhUZWRteGFsK0tweXZFbkl1ajBxWUVOT2x1?=
 =?utf-8?B?NnF2ZXZrZTh1NHQxRXAxY3dTRzI1ZlNBc3krY3VJa3dmN1JmSnZkb2dYQ0FR?=
 =?utf-8?B?OW43bTkxTTlDdnc0SlZBcEh3VnlnczVKUERncGU3MUhtUGVZTTVSdXdKR3VE?=
 =?utf-8?B?VVd4V2FudlFhOHpMS1BGZXI1YzgwZlErZWxKMEtNQnNjaktzbHNjSDZ0TnRV?=
 =?utf-8?B?RVZMZEI2REhJOFdOTEJkVjNad0k4NWlJRlkxcEFRdlJIWTVaVnI0MUxoM01Y?=
 =?utf-8?B?RGtqT1BBRHhvSERPMWc5czlvMC93PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf91ede-60ac-44d3-ea77-08dd3b9e0062
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 11:06:35.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYSjJCJHzj8TIwOULalCp29HiL2rnTafN+DmhDD91a/CyqMWfjMysalJpJQl9SSAkvmB9kWVo/2yk6PKKJDtsQ10N2pOOrfrlwKhrZ4iRZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9403

Hello,

Regarding WireGuard, I had to make a bunch of changes to the latest 
version of it to get it running properly on our fork (yes, we upgrade it 
slowly, now 1.38): 
https://github.com/sailfishos/connman/commits/master/connman/vpn

But I haven't had time to figure out all that is needed for upstream to 
be sent first, like this RFC edit that was forgotten because of... 
"eastern winds blowing into our direction": 
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97

And then the connection.c was modified a lot (and renamed) and I'm not 
sure if these will work on top of that anymore. Mostly because we have 
features that may not have been compatible with latest upstream, like 
adding a support  for two different devices to be belonging into one 
service to facilitate CLAT support 
https://github.com/sailfishos/connman/commits/master/connman/src/connection.c 
etc. etc. etc.

At some point I'll start pushing changes but not sure when I have time. 
Mostly they could be RFCs as the changes are big.

BR,
  Jussi


On 1/23/25 12:45, daniel antoine wrote:
> Hi
> 
> I have opened a ticket for connman-vpn not working with wireguard  in
> April 2024. If you give me the patches I can test them
> 
> Best regards
> 
> Daniel
> 
> Le mer. 22 janv. 2025 à 18:01, Grant Erickson
> <gerickson@nuovations.com> a écrit :
>>
>> On Jan 13, 2025, at 5:59 AM, Gabriel Sanches <gabriel.sanches@prevas.dk> wrote:
>>> I was testing connman's wireguard plugin and got a segmentation fault.
>>>
>>> Looking at the backtrace revealed that there are some typos in the `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 variables instead of ipv6 regarding vpn.
>>>
>>> I simply changed them to ipv6 and got it working.
>>>
>>> not related to the patch:
>>> I had to manually add ip route so the other devices could be pinged
>>> The plugin adds routes for the WireGuard.DNS configuration setting
>>> # ip route
>>> 1.1.1.1 dev wg0 scope link
>>> 8.8.8.8 dev wg0 scope link
>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>> 10.42.0.1 dev end1 scope link
>>> <vpn host ip> via 10.42.0.1 dev end1
>>>
>>> the missing route added manually:
>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>>
>>> an equivalent wireguard file adds it properly (using wg-quick)
>>>
>>> Is the plugin lacking some implementation?
>>>
>>> ---
>>> src/gateway.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/src/gateway.c b/src/gateway.c
>>> index 16c87f83..b2c211e2 100644
>>> --- a/src/gateway.c
>>> +++ b/src/gateway.c
>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service *service,
>>>                                        is_gateway_config_vpn(
>>>                                                new_gateway->ipv4_config);
>>>
>>> -             is_vpn6 = do_ipv4 &&
>>> -                                     new_gateway->ipv4_config &&
>>> +             is_vpn6 = do_ipv6 &&
>>> +                                     new_gateway->ipv6_config &&
>>>                                        is_gateway_config_vpn(
>>> -                                             new_gateway->ipv4_config);
>>> +                                             new_gateway->ipv6_config);
>>>
>>>        } else {
>>>                if (do_ipv4 && new_gateway->ipv4_config)
>>> --
>>> 2.43.0
>>
>> Gabriel,
>>
>> Great catch on this copy-and-paste typo; thank you!
>>
>> Best,
>>
>> Grant
>>
>>
> 

