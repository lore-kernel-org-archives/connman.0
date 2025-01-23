Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2108.outbound.protection.outlook.com [40.107.103.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D520CCCF
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634117; cv=fail; b=HgaikXOlIpK6Psdm4NYnvzsffKxmRZqkO4Q6c0xumIQwM2UEA6MTx8iJ8RNDq0exEVVCyw3gc7mdOzKZId2lxXlRAlvTwCLRBWFQQPEvKp5XhvgCY0LS6WD8b30L4ejPjOmHIK8EHiKpMzTKe9f2QhL+4jn51bT/6E07dtuRKCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634117; c=relaxed/simple;
	bh=/EWD8BaPc5ce14lECUChqjPNXMEeisHNqBFlHXEYvuU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=osm11QPWsRFj1K4zbU9Y15pYJZ5ONAbo2tiAN6ZKfMQyKwzUQvwtu9GmUzKC/QlPNhNH9Tq0Y1k6kry7Z3TcDEAngsV8BCvU6eZJhTJw/0DxPx1w2j+sTDrFYjpZ8D0WCtnbubsz3QLhO7oGFf8o30u1PmXWjHcyNXNVtH7eHKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=Uj1yKLES; arc=fail smtp.client-ip=40.107.103.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="Uj1yKLES"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1kMCpoOg+22fWMTXJMQQ2Lsz7m5UnIQTc1S9jkOr9enMIuyEr6wvdHE0o/hOXpksCGxGv5CmOPBmuTpKkJNO48cqRAbVy/g7H5s24MVYl9vJ7FjPBUs3hkq7lt9gEiskRjHrI6aG5zrnM0sHVTeb2KceS3SgcT+5zUKth8M0cQPi0LllIdwgPRbW8+9hXU/X2A1RJ/ndHJlLolZmU18cxAblLSP5q5TqlrYKO34teg8ui8yIzcFMyqFxFMTD3hbg2BQAjHO512Q+RHG1GNFiCwx2BSGebAipFoxJ5DE+QJut3biQkETXSTz+WAYCtwyGIwMNZqm5RxprpLIp7VnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo93b71PuXSQ1DD/4L+rFGBcxW3Si5lYOpQZumJsX/M=;
 b=AjD2bM3/oRMbaHnzsjb4N2fUIy64QLp68kekxjw1uj5LGQA2kEfgJr39Y2/TwNKxZVE5YnLzBF/8Mzcmo00AdI1iiLKzW7X/n3KsBPL0nSlkBYkCj7cEnhz/4hY1azX0WqbWtC86sVuIjZqLzE7nVqRFyKEp1DRNxr7eaRo5u64daDVMvwF0EoECsoMEwPbiokxaEgv3kJydJxl6S3SzQYU956K98oyHweozkbBlYqjbACLPDqzFDIh6KOwVmFn3sBubXcr4PnUD8m450hxqfGs6scUd82zWaDth4iMKhX8ay/63CEjJ9rSCVYplgy/A6uoKtqPy3XtFT51NHLSwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo93b71PuXSQ1DD/4L+rFGBcxW3Si5lYOpQZumJsX/M=;
 b=Uj1yKLESP8ZQ3h+OXcceRzWuuPwElrTDLcZ1AlHmt7kqWGf1RPZxPumwknxISWau269d6b5FBcO/cxgwM+H7XEBlyuKY+SARUJskhgliEzJWb1FxdFe6rSOuCg9zHP+UplrIJG2L5++lBW++zb4z+nG59Vsb7CTMYfhlFeiHgZPOINODpzg0JbFUUAP0V7FSQECZNWNQZ/AN4WHW+ZUEc0V2cpaQHzYbmuUpzVl6iUxxL3GnAPPo6cVLtwBIMl+d4TBJAVsUJpXZhsAhTi22UJ4eS/wCHKFkSlWi0EfBfouwkC/e88soaDf3mcBUeSGOb53oQT/zHVf9C0/IU1MZhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by DUZPR06MB8724.eurprd06.prod.outlook.com (2603:10a6:10:4b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 12:08:30 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 12:08:30 +0000
Message-ID: <d10885e3-539e-4be1-8c33-c6028d55c7ef@jolla.com>
Date: Thu, 23 Jan 2025 14:08:29 +0200
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
 <418557AF-4801-44C8-9099-096A0BAD8110@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <418557AF-4801-44C8-9099-096A0BAD8110@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::34) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|DUZPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e19de3-60df-4dbe-d3f7-08dd3ba6a681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTVjQ2pqNTIxclR4dnVPTEZvSmVDalJGQlE5dmpCazFKR09hYThsTlNZMytO?=
 =?utf-8?B?ZHU1SHl0b2tRQTN0TGkyWUJER1RTaURGd25DRHlCRW1lbEs0QW1vZmM3NUNP?=
 =?utf-8?B?UElZNU82amxFWE5hbXVQZlAyUU9FcGpMbnZzNHJGNGVkZGI3NlFnZTNUVnl2?=
 =?utf-8?B?WEpBWm13UEVINkFvbzVIMGlwekFIRGUxdEFlUWFnNlI4enRFNXVGN1d4Z0Ur?=
 =?utf-8?B?b216TEh0bkoyUnpuY3BqL1NpTnNxRXM1NklOQ004V1duSXZRU213RlNkMHBv?=
 =?utf-8?B?TmUrTVF4VE1PRTNEU1d5U01HbkZQNnU1TitkZFRlN3JTRzRKRU0xUDZQSDFR?=
 =?utf-8?B?NGRDUWp5My9xaEovNkNtdmVEdXpUT2dWbEJLejdCRGttczJ3ZGxwUkhYL09O?=
 =?utf-8?B?TEF3eDJaaitNcktqZ3NSVHIzbmRUUzJFY3YzNjFCdDNTWkpRSitScG1vNURZ?=
 =?utf-8?B?QWVpclVKdGZwRWFaN2UvczhTcng4amFuQ1JrRzdzZmdXa3ZNZjBnQVhDdWY2?=
 =?utf-8?B?dkxjNGphZWM2UVRJdlROSHE4U2FNSERMU1gyb3VjdnJuVnZoQjRMVGlnN083?=
 =?utf-8?B?Wkl4aFcza3NCTXQ4UUIzdmNCZTlob3VqTmVZSzA0NThTOGlpTTN2Sm1OT0xz?=
 =?utf-8?B?d1ArdmRhNjBnTCthRVVtc096TC9vdm5rWjdLaWV4QlZ0dXRqV0pwNEZxcnhV?=
 =?utf-8?B?TlFYVURUb3dhRzhXZGh5SlpmaU12RHpuWTlzbVJpckt2WFpuczAzVDZ4cEV4?=
 =?utf-8?B?YnZtV3JUMnREWXdBbTRZT2FEUkd6Y1NWS2hsNXl6b1E0WUFXSVllWjBTMjNC?=
 =?utf-8?B?M1drQjZRK3ZYK0VrNmsvY3pTSFRYM0dqSkVabjgwYWZ1bURkWHp4M0NRbUJY?=
 =?utf-8?B?d1krL0c2YVhiOHZCUUdualRxZ3doRkU5eERDWEhoSWhyK2N2WUJacnhRajcr?=
 =?utf-8?B?aFZjNEh3SWFwMlBlUHJ0cFd6N3NmZ3ZYazVqaGlmbHZ0SjdJM3ZqcTIwUVZ1?=
 =?utf-8?B?dnVMaG1MLy9tWGxDT3N6bithQWFTSG4rTTNxQjdVaDduNkc3OWtucUo4QUxu?=
 =?utf-8?B?RVZwUmw5ajdoRFEzMWhPSXBmQzZMOS90MXR6c016d0NyTnFWdjhJME0yb3lR?=
 =?utf-8?B?QkJUbHByWmNSR2h6eWg5R1hhelEvdkJKNVFNdHZUd3dCMW14WU9tZ0JKSjVE?=
 =?utf-8?B?eGR2UlRjancrUDZOcVFTbjVabEVRNmpCaVhZdWNRQTM0MDE4TEIxSEtiMWs1?=
 =?utf-8?B?NDJmQVZzV3lsSFFKMks3NzJNa1IvT3VlUHpTZ0gzek5ZVUJ2a2lYTmN3Tk53?=
 =?utf-8?B?RnptMDR1M0lZQmhOdzd1MElWdmhVMER4N2xWN0I0S3RIdXlzV3RKU1grSTh5?=
 =?utf-8?B?bXVPQ0JwS1lDQlVYTUN3czRTWDNSYXR4OW83aXljV2VuTllJdDRuYVYrTE9v?=
 =?utf-8?B?RzRiWnhKN0pnOWV0bFhiMTBUMG9Kdnl3ODlhNkdLMXY4RXllQzBMUlNnZEFM?=
 =?utf-8?B?RFlrdlgxRy9YakNzWGFhNDNqU1kyYy9aZzhoMno0L0RnbEZhR2tvSERnbFFP?=
 =?utf-8?B?R0pEMEE5c05IUnN1bGVrYkhZYnk3VUFha2VvYjF0ZkFDaTBSajZ1VUpwVFJ0?=
 =?utf-8?B?K24zR2x6WkdFbDU3bnQySU5CeXdTa2JCZ0ZoYVYwV0lTNTBTOEF3TUczN1NF?=
 =?utf-8?B?YzdjMlB2WHl3aUFteEVNRnFuSm53MTA3Ync4SFRxa1FlR0hjaVNBV1VIWnlN?=
 =?utf-8?B?U0t6RlZZSVREUWxXL3JmNTFVbTFXc3dtMHRFSXRFZWxKN1ZCb1MwUjd3bC9C?=
 =?utf-8?B?VnFVUGV0dTdKTTNSQVFCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjdDYUZmNGxZY1k0aXhNWG16akcwMW1Tc1lyNUJFZ1AyanR1QWFlNCtKSXZi?=
 =?utf-8?B?WkxrY21IMGtyckl5cEFGMUcwS2taZDljbnQ4V1hYT2NiYWd5MStjMkN1Kzls?=
 =?utf-8?B?MzY1MzBUSEQwdVc4bFpJL1A0WXFuQ0xTa0FRZXo0YjhzdktRdFdpU1VMaXFn?=
 =?utf-8?B?Yzhabm5MRUlYejU2SDA0NmZUNmhjWmxlR3NTRy9KZDZPRkNINlFuMEdWdlZT?=
 =?utf-8?B?SVRIODIxZEV2UFZlK2U5bHBaUGhVd3ZNb25CMWFzWU1HM2lGeXAzcFNUdjll?=
 =?utf-8?B?NUN1M2ZSZnI4MXVkc1oxT0JCQU9ncCtXaGtZbXZ0cEoyVThSK1VyNWtmQ0F1?=
 =?utf-8?B?TTJPQTZXZUt4NHlsM3NGYnBuNk4xQ2tmRndnaUd6ZG1jMlA5U1lJS1Jsa1JQ?=
 =?utf-8?B?N3ppbW9HVDZOZXlDZmdiTGN0eURWL2VFK1RjQUpoVmc3aWtLbFViU1lGdE0r?=
 =?utf-8?B?bDNiMHNKMWpTLzNXcDY5anJubFZNMFA2c2lLR2NJdCs2dlN6bExhZndycUFB?=
 =?utf-8?B?M1F6U2xCUzh4bitqSmFQdGYrdzdQTVAyazJERGxqSk00RkhsZkdUZjRIQkc0?=
 =?utf-8?B?bUF0YkFaa0dqbm1RVDVxRmc2SlJvRi9vYWtzc0FBTzgzbTVXS2NYWktxYmtv?=
 =?utf-8?B?NnJFYUVKcjRzbkNHaG9OaklwVmNEYzduQXRDTkUrK0JNM0x3VmV1bnYvRTcx?=
 =?utf-8?B?SUpiTy8rQnF5ZU5qTWpxdmpDMTlhVHZwMCtvYnRISVlmZkNxMHVQbHFjbnd2?=
 =?utf-8?B?YmRBeVE4R1k3ZWZQVmFGV254MVhpS1RwRWtXcWlGQXA5KzZ5bnFNNGgwcVho?=
 =?utf-8?B?L0JIMzJmdDhzQUt3ejVZM3JhOE1TNERYQVFRaFZPS2crSS9qVm1Jb2QxSWRl?=
 =?utf-8?B?ODhQd1RlczhNRzErdEtRVllyN1A1K3gybFE0NWFPbkpFOW1uOGtaL2x1WTRk?=
 =?utf-8?B?aXRrWHYyc1lHZDVzZFE2TFdYRzhWOUxHVkN0K2lIdXlnMjFLUnYvUVpkMWdP?=
 =?utf-8?B?aStZZmU1c3pIN1dWM1Z5OGYyU2RMdzdWdmlSOSt0cnlUcVE3dGRGYUVBMEs3?=
 =?utf-8?B?VHRMMFdPT1RBenY0eGVCK1NsdVA2T05VWGhiYTAzV3pkZmRNbWJhZTFUeWdC?=
 =?utf-8?B?U3BjYUNrWThYTEVnd2Y2M3lrbU9tdDJJcVBtT1Z3cUF2VG1QWnN6M1RaQUZZ?=
 =?utf-8?B?S2RsS25NT1JTcjAxYTFwL29VbEhQTWZRdTc3MUlrODBFQzdqaXlmSXNmWXdk?=
 =?utf-8?B?SlowNXlGOFZuMHVmdFBGaXNLVjZqcTRrZUdrVmthd0p2NXVsM3BFQmNNbVBK?=
 =?utf-8?B?RVFEUlZaMWozWWFRZE5hL1N0NW8vU2p1UCt6TTJBVXQvNU1yK0lRM2Zwc09x?=
 =?utf-8?B?OStXK1BZNGthVmllMjlzc0p0c2dPL3VjNEpFTnJPYkd1b3kwZzdQL3czVVJo?=
 =?utf-8?B?Ylg5QVBQMnFFVHpvZHM2ZlZ5cWlCTDE0eit2OTB1MzBWSUpXeDJzT0hQM0FD?=
 =?utf-8?B?VFgrWU9pZFRma2lLa2ZSUVpMWDZML21HaUl3NkQwZkY0SHFiaHlXMXovVG5k?=
 =?utf-8?B?OXNrdHExS0txWXFGM0t5cjU0Wm1pVEx2NnpSSGxSZlNWWjdKYm5PMThSRWsr?=
 =?utf-8?B?S2VGTUtqbzlBN2I0MGVDT3M1OTBGTW5aZHUxNmZEQXlmNjgxVGtucStSeDlV?=
 =?utf-8?B?RXFzamZCeEpmRzNicjdxMUs2d05CbkE0YXg1dFJGZVdnVXFVZkM4UUw4S1hK?=
 =?utf-8?B?T3BETk9xY01RaGY2akY1ZUZTRnAvOG1YZkFFdDEwcWIwNlBaZW12eGRtQVJ2?=
 =?utf-8?B?NkVwRDFPQ1pRRXhNRmp3cGV6bkpjVmV1WEpUU1RkaDlPYzZwYTEyQ0gyUW9m?=
 =?utf-8?B?eXlwc2dRaXJ1UXl0QjhSVnV1N1dZYm5xbEtHM2llbmNyZlZhUisyWk9PNTVW?=
 =?utf-8?B?WHFVckpaUURaRlNRcmZBbmF2TlByemNqd2RiOXAyTzMvV1ExOE9UOUdicTlp?=
 =?utf-8?B?a2ZBQXZKYTJ6WFdCTllOOFpGdEhqOERjdzl6NE9OU09xNEx3cVppRmIvdFgr?=
 =?utf-8?B?alpEZGNkT2RpTzRMZC8wVHhQUm15MGJEbzBwYkdOWG9MNEJZQVNkM3NXdDFC?=
 =?utf-8?B?eHo2OEVTNFZBOGhYcC9tWTBaQ1duQXIwQ01RQlNqYTZqUm9TcmltYXVQbkVD?=
 =?utf-8?B?NTlIeit6aE55VXB1VVlOQmg1bGl2eGlaNU8wTXlZV1h1VlVXampjZDk4ZjJl?=
 =?utf-8?B?Y24raVZ1bUwvUlRrU1BEVEQ5dENBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e19de3-60df-4dbe-d3f7-08dd3ba6a681
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 12:08:30.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIF9qzGnEznoQVPxnn0SY7HEd2MKZToL4HbdUM0MaRO1Vszo0ZRrXh31Xg3TaaBQa/FtcaUaLczURbX/HZ8Ul0FMshqpN4Xln9j+oHDSobQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8724

Ok, right. I get your point, if that feature is missing it will be quite 
impossible to use WG.

Our version with the changes does handle that, and also requires CIDR 
format for IP address, well, check is a bit rudimentary:
https://github.com/sailfishos/connman/blob/master/connman/vpn/plugins/wireguard.c#L201 
but since all goes through getaddrinfo() checks it should work if DNS is 
working on the transport medium.

- Jussi



On 1/23/25 13:49, Christian Hewitt wrote:
> Ignore: https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=90592f7a58358a98bde5df6928e2b871041c12bc
> 
> So I think this is not the feature I’m thinking of, as it discusses Endpoint re-resolving.
> 
> The challenge our users have is ‘Host’ which currently must be an IP address. Upstream WireGuard with wg-quick etc. allows an FQDN. I see users that need to connect to home locations on dynamic IPs where Host will periodically change. I also see users with commercial VPN services which use an FQDN in the (upstream) wireguard configuration format and this resolves to multiple A records (round-robin balancing) and the ‘static’ IPs move around in their ASN range over time in an an attempt to mitigate (poor) IP reputation issues.
> 
> Christian
> 
> 
>> On 23 Jan 2025, at 3:35 pm, Christian Hewitt <christianshewitt@gmail.com> wrote:
>>
>> Looking here: https://git.kernel.org/pub/scm/network/connman/connman.git/log/ I’m not finding "wireguard: Regular reresolve endpoint address” and the first page of log goes back to December ’23. Are we using the wrong upstream?
>>
>> Christian
>>
>>> On 23 Jan 2025, at 3:22 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>>
>>> Hi Christian,
>>>
>>> That is actually in upstream, all the commits regarding WireGuard before July 10, 2024 are taken from the latest upstream and the changes after that are new features.
>>>
>>> Well, the vpn.c changes do depend on having the ASSOCIATION state also for VPNs to be implemented, that was proposed in the RFC https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 as the state transitions depend on that bit. But it does not seem to be depending on the gateway.c/connection.c. Well, I can try to squeeze time to address the issues Daniel earlier raised on that RFC and push them to upstream, then make a big change on the vpn.c and wireguard.c.
>>>
>>> Br,
>>> Jussi
>>>
>>>
>>> On 1/23/25 13:12, Christian Hewitt wrote:
>>>> You don't often get email from christianshewitt@gmail.com. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
>>>> Ohh.. I would be VERY keen to see support for FQDN’s resolving to dynamic IP’s upstreamed so this looks interesting:
>>>> https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972b866fdbd8bd
>>>> Is that feature dependent on any other changes? (being lazy.. I didn’t read all the commits in that branch yet!).
>>>> Christian
>>>> On 23 Jan 2025, at 3:06 pm, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>>> Hello,
>>>> Regarding WireGuard, I had to make a bunch of changes to the latest version of it to get it running properly on our fork (yes, we upgrade it slowly, now 1.38): https://github.com/sailfishos/connman/commits/master/connman/vpn
>>>> But I haven't had time to figure out all that is needed for upstream to be sent first, like this RFC edit that was forgotten because of... "eastern winds blowing into our direction": https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>>>> And then the connection.c was modified a lot (and renamed) and I'm not sure if these will work on top of that anymore. Mostly because we have features that may not have been compatible with latest upstream, like adding a support  for two different devices to be belonging into one service to facilitate CLAT support https://github.com/sailfishos/connman/commits/master/connman/src/connection.c etc. etc. etc.
>>>> At some point I'll start pushing changes but not sure when I have time. Mostly they could be RFCs as the changes are big.
>>>> BR,
>>>> Jussi
>>>> On 1/23/25 12:45, daniel antoine wrote:
>>>> Hi
>>>> I have opened a ticket for connman-vpn not working with wireguard  in
>>>> April 2024. If you give me the patches I can test them
>>>> Best regards
>>>> Daniel
>>>> Le mer. 22 janv. 2025 à 18:01, Grant Erickson
>>>> <gerickson@nuovations.com> a écrit :
>>>> On Jan 13, 2025, at 5:59 AM, Gabriel Sanches <gabriel.sanches@prevas.dk> wrote:
>>>> I was testing connman's wireguard plugin and got a segmentation fault.
>>>> Looking at the backtrace revealed that there are some typos in the `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 variables instead of ipv6 regarding vpn.
>>>> I simply changed them to ipv6 and got it working.
>>>> not related to the patch:
>>>> I had to manually add ip route so the other devices could be pinged
>>>> The plugin adds routes for the WireGuard.DNS configuration setting
>>>> # ip route
>>>> 1.1.1.1 dev wg0 scope link
>>>> 8.8.8.8 dev wg0 scope link
>>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>>> 10.42.0.1 dev end1 scope link
>>>> <vpn host ip> via 10.42.0.1 dev end1
>>>> the missing route added manually:
>>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>>> an equivalent wireguard file adds it properly (using wg-quick)
>>>> Is the plugin lacking some implementation?
>>>> ---
>>>> src/gateway.c | 6 +++---
>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>> diff --git a/src/gateway.c b/src/gateway.c
>>>> index 16c87f83..b2c211e2 100644
>>>> --- a/src/gateway.c
>>>> +++ b/src/gateway.c
>>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service *service,
>>>>                                       is_gateway_config_vpn(
>>>>                                               new_gateway->ipv4_config);
>>>> -             is_vpn6 = do_ipv4 &&
>>>> -                                     new_gateway->ipv4_config &&
>>>> +             is_vpn6 = do_ipv6 &&
>>>> +                                     new_gateway->ipv6_config &&
>>>>                                       is_gateway_config_vpn(
>>>> -                                             new_gateway->ipv4_config);
>>>> +                                             new_gateway->ipv6_config);
>>>>       } else {
>>>>               if (do_ipv4 && new_gateway->ipv4_config)
>>>> --
>>>> 2.43.0
>>>> Gabriel,
>>>> Great catch on this copy-and-paste typo; thank you!
>>>> Best,
>>>> Grant
>>>
>>
> 

