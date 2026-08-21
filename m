Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023091.outbound.protection.outlook.com [52.101.83.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07335472549
	for <connman@lists.linux.dev>; Fri, 21 Aug 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787329118; cv=fail; b=AG5u8Mp2Lx4d46bhqcLq4XKfXw+ZMpjCXJRz0UAp6QYaSeTHGuWpR2F6IQY337aNFa3kGIr/Qsg8nMizy/AW2zxrQkQ0iN2oqLJJLW/xvebE1eKcurK2x9Q8GTDXIYmC1m2bz9FmFoAgJVfzCVBGFefnDzjl9S/CipqnOj+Je7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787329118; c=relaxed/simple;
	bh=0HytQb0htexOkXUqrG1c+oXTvscN5hTe62CvmX7P454=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOzqGt6/Wbm5oxjGSCdV1k1v+l+tBcoAwE3A0OXLyHYIx70UAxHsxCtEDuG0lxZ6c4KHkVemZzo2JEv+e+TE1oX5zxGmppTtLS9Q0QfA6ABnKjj2DxlJcpMqvE13VFQqBxmNotNOONQH1N8ZJuTS+er05zYW6uyXXlaCux+TlOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=RKjersKJ; arc=fail smtp.client-ip=52.101.83.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="RKjersKJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx/PTk5YG6NnjqelnP9f+nC8PTsxP3DIYTdqfxxJDJCISLdrKuVYg2QyBRZSpy5eEHnZAdKNqe5TVzbjQ8ng2BLJLXNjPutQRB47uToZ599oRz8Ap4vamq2GL2FlFDcX2gBPQUhKrseygH3dA5oxwBRAsnDaDLvm4h+p4GTeuNs4Aoui+la6jwORYt27LFs28MwtC/4hCdiA5RSps9+wSVFtaw6M2Q1ftg+nS5rvopOLIqhmGGA4I8pAdl3TpswQXxzptGBGGyznJYRbJ+3NsNiTGOzriYK8ZmPxFnT5LIOZXcGUOTc6mTXqoKEY0rIjkFtt4iz7kn62LbmU/eH0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25w645v1WoqYv8uQPrxgGylOgnaXwM1xISbMKgJI+Ng=;
 b=hO3GP8tL4si8jN9HuGkM9qRnLHCUWDcZEaX7OBtGCmzXCzHfsGyyZmW/d1Me8poE8ghaYeGoXj7eVDuU5bDItz9xv79/duvJhkobk8AGmxMytyO6lrhx3z3StqQ1mKqKdgpg7PX08eZQ7kdACSRoq5a9fm8zfxVJ6BcRWFQEq674D95bfCsgs5QTnxnSDyJJA57elZd4czWqRYYyNCglGChfcJZAIY11DS8sia9SlPbAwB6foDHCHJWaxyINCk1Z0E93hjuEAy5pudEZgj2M1T5a3fi+Co78z+Z5fz+BhxkEbk5ng1HJiLVWBFO+sptJOE+qPH5XLjrfH2v0EUvkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25w645v1WoqYv8uQPrxgGylOgnaXwM1xISbMKgJI+Ng=;
 b=RKjersKJKFpysJkw8oP5xvO1Jg694SuJgvrmjnq92+ov0yf+ixgD6RwO5WMYaeIRv9GbbhimUE5x8JTo9oRA2zGNEV2OI3wl6CWfNs4Cb/N8M61vjA9CSITvD/YsXF9ELir2LQ/LEkqFLQHFwybrnF4vr4ZAvjB3WacccjdFFc1yvZoXcqpdOPPoMPJLEWtFXALK9KwM3myEdiMbWVC7gb6sXolEls86QdiTNnr4NaG879RhJJiW5DlMTts+2ge9A0OCnMUUSfOnNYEMrTJCrgNyWgulwHVS47VaDz1m+oKCFBcGu3lW61rwuSa9RLah/SBSZEQHo6wYMUiL36iL7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from PAXPR06MB8174.eurprd06.prod.outlook.com (2603:10a6:102:1aa::5)
 by DBAPR06MB6869.eurprd06.prod.outlook.com (2603:10a6:10:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:18:32 +0000
Received: from PAXPR06MB8174.eurprd06.prod.outlook.com
 ([fe80::6b12:6b0b:77d0:c3bf]) by PAXPR06MB8174.eurprd06.prod.outlook.com
 ([fe80::6b12:6b0b:77d0:c3bf%3]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 16:18:32 +0000
Message-ID: <b5b6a302-8849-4fb0-8169-2ecf122127bf@jolla.com>
Date: Fri, 21 Aug 2026 19:18:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Implement D-Bus API for toggling debug on/off at
 run-time
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
References: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
Content-Language: en-US
In-Reply-To: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::7) To PAXPR06MB8174.eurprd06.prod.outlook.com
 (2603:10a6:102:1aa::5)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR06MB8174:EE_|DBAPR06MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9aee03-9241-444a-0d72-08deff9fd82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|376014|1800799024|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lEGAWwAoClFLBnfx22YgB/p3tgck1nZwuEpqdNH3vPHCrzkb4HZbU37Atl7IszIWkav8g2hPrY26JF4xg/mJdvRz+KyQFA40aExnFMdSfqWeAhhLjv2lfkfLrTEraSXx0HsikAa6+jEuTud0e8fH1NbxpInWBAtefFYuxf+QNW+ryPGIwppp9mMuGY7FDEXe3Nxngl+ZhE8/yXfNCmPZGBAzUqUl4Ld3cdEfKC+62NzbZbCOm3BYqn1B+Eu1+8Up3mnCAtF2CG46lMivC1YCkKDgCubQ86XX1ape491K4Ikpha7qtBSDcA9bDh24Og81kJQfQkIw3oP4ek6nKx8hw3ytR0a78/5pOxHakvLjeoKNB4x2CcMB/48GB2Z7b0MHvMRtdalyTR/lO3FhH7Mql4xEnShNi1L9GlMv6MXkcG2SzQ6RYGKWNDgDc4FQOUobzKxHBAESrBx8TcGjdfaFTRdp/AeHwUHGXOzSXJNxZSKNUzDShjy3zNxlLigp9ZVIuF+uGPjt6ruH6vPqNSQiA8wUnOfI7ZxQ6ExizIyE8+PQUX3fr83dd62WbfA0/g/zklqjpevs+DX7rz0+Fi/VmkXRdCNx09Zu53ut5SUAi5JDtCvoCpuXeYYgInGjUmjpLccksIn5DOOoP5+oMOnNxAV/vaCF1tsHifk7IzFlKqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR06MB8174.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDViMGprSVNoTURSb2lUVkhGZGhhMHVZTUJreXRyM2h2cnBISG5RaTAwMEtk?=
 =?utf-8?B?R3plcnZnWlE3U2p6UWRPci8xMW5VRGE3by94Uk1JU3lqb3RRLzBDQkZOVWE5?=
 =?utf-8?B?K3lSeW0zSlJSWnlUTFNUZkJVOEFDcyt6QkhPUmptTkJGaGdPb2VIamJEL0dr?=
 =?utf-8?B?eExoMHRYUVloQjAwbUdocEtLVlM4enRPZ0pKOFBXa2RVWkE0aWhWUER6UWZC?=
 =?utf-8?B?QytZYlFUTWZHMndrWHNNbEtxMWFPUDN2bzFYaVFDdHJRRXd0ZHU0S1RIRFFy?=
 =?utf-8?B?RWNvZUNibTdUckNDN3NYUjNZYzVUa1RwWkdDc0lXOXk3QkxYdGxncnZnSXZL?=
 =?utf-8?B?aDM3aVZYV0ltL05KVDcwb1BRL3JCdUQ2SjhFNGcrazJ3bEN0TDVIc0d6cWNs?=
 =?utf-8?B?MU92U0JuUHJYTmF2aSswVmtnRFAxS0xHbDM3SVZhdWJhWVhpZUkwVFhOS1FC?=
 =?utf-8?B?OTMycXFXQXI3MlFtWGtJNUJyM0V5RlNybVFWZm1KamgxMDdudXFWdFNxM1lS?=
 =?utf-8?B?U1ZDcE5OQVVDd2VQcGk0L0hFdlFjcThwRGtKRi9CVEk2OE9pbm94R2N0OVk3?=
 =?utf-8?B?aGJHME1Va0NnaVNvVEpxUUVUbElvZUhRblBrdUFuLzNjUmZDaURlY1NXRms0?=
 =?utf-8?B?ZEo1MGgrQWlVdDFOdmw3OElHQklBdzRoemtZaW0xajZZQ2Rqdm5JYW94eUtZ?=
 =?utf-8?B?eFpJWHhKS1VxTzAyK25vdVZoMWY4enArVlNnVktZYVpId2xCckpuR1l0WFMx?=
 =?utf-8?B?MzZ6Y3h1TDV2UGxrcWkwOVhEanZ6ZkxuQXdxVk5yOTJyWHZIdkNvRGhkUExH?=
 =?utf-8?B?RWRKbGgyOTFCQ3pIekpiOGtVNXdaMEVubmxjY3dkZVFmS3JtL2JWV3VETTIv?=
 =?utf-8?B?d0w5b1ZvOHZtakdmdUhJa1cvZm5JVTdKTE1HMHMzbC94bE9idmhXRVVna2tK?=
 =?utf-8?B?TklQMWdKb0ltY29vSGE1SnVndkZzUTZNc25nazVWTEJ3Z2pIUGpOSnIvOG1q?=
 =?utf-8?B?OTBwalZuUlhqRWlwVDJTeEtUZDR4clBzZXNCNktnYkNrdy9NdjhlaTFUYXA4?=
 =?utf-8?B?ZUhqeXFOTWQ2UExRS0hjYVRsL3pvc2h3WDRqSm9heHlyRjRnTWczbnp0TW9y?=
 =?utf-8?B?bmEwQU02eTRWQ1VJVUJqcUZBQjRtM3dSNjF6eG5Wa0NVazYvZCtBY05wbTJL?=
 =?utf-8?B?WXFEdVBvQVdINTM5Tmd1MEhXUDFVQkc1dHhrbElVcHdmWTdNRXpNNHhzek5N?=
 =?utf-8?B?S2owU2dLSUJMNjdMNTNFb0pvM05tRGw1aG12OG1RY3dMK2dPMVAzZHNqc3BF?=
 =?utf-8?B?OTJ2MENFTGd0a1dSaHZ6ZnpFN2JKUDVUZXBOZ0trSmx2ZXhCcjE3MXdRV2xp?=
 =?utf-8?B?UlJXSE9oVmw0WHBZSTVDVEZaa0o0eFNTcDI4NWROb29yWnY5cVYza2Rib2FJ?=
 =?utf-8?B?Y09FRXl3VW1wSXhMb0RSU1NvRzhKQm9mN3hpL2FxQkgxR1FrdDdsK2hzUnho?=
 =?utf-8?B?RU52VkRVUXgvenJ1OWp3NHR3ZjZicFh1aFlRZ2h5RXQvOXh5U1QzSG82V05w?=
 =?utf-8?B?YWwzUkpyd0t6VlBqcVhBcUFLUzJFRlZNNHE1YTVVSmhYd2NxVmpkcEUyWWlT?=
 =?utf-8?B?MjJYN21iMm5zOTZsdlpJRmRETTZ0YWNLaGo3MzRJa2lERUF1Wk5LWjB6QlVx?=
 =?utf-8?B?OEZCeS9NMkt0cm9YZy83eE9lOEhaVDlYNjJyeCthSWdKdGZ0VnI4dzc4NWli?=
 =?utf-8?B?bC9ZZ2RQR3pJL01BemdJNkV4WkRYY1VkWFBRWHRrNExaZU03T3lRS2VNRWlz?=
 =?utf-8?B?U05hNUF6YStQcWRxYTVHV3QwYW1TUWdRejhTUkVwNHR1TXN6b0FpYnNaZUh2?=
 =?utf-8?B?YThjalArdmx4L1dJWC91RjBvdFhRcGR1L2F5ZFVlM0NxU3dvd0Q2SmVEZ0s0?=
 =?utf-8?B?RVdEZmhYT01pcFpPYTYwcG9qWm9UcU90NmVWUVNueG5YUVNwMjRSbHgyUjg4?=
 =?utf-8?B?aktTTFNaVmdrTnJORUE0cTliTjVxYVQwV0M4WUtUY3pwVXF1OFJnZEl2Z01X?=
 =?utf-8?B?Vitqck1pbk44NnkvN0dSOU4yS2phVGZWU2xYUGc1dkZ6am1neXFiMWozZHZ1?=
 =?utf-8?B?R3VmR2RXOHpDaE1zZTJoOXJQSzlTd2YxdjR0UU9TSGFmOVNpOUN1V0t0WFdT?=
 =?utf-8?B?US8yUzFRbzZmWWw5OEVnSXF4c21tbEtIRW80KzRLZEhrNU80WVZLTkZDNHF1?=
 =?utf-8?B?YzJBMiszczhkOE5ZZlg4YmVTQ0pRV0lWY0o3Q0dSQkxySjlEV2RnVmhMM1VO?=
 =?utf-8?B?M0hZbTIrVmdjeCtPWTJsTll4WWxrTGV6eEdOMVZQZkpIV0RxZC9pTlVhRHJq?=
 =?utf-8?Q?lJ2zWojPzcD72eZbnO0/d2EeRo8c33V+DuAW8cWqkyTTz?=
X-MS-Exchange-AntiSpam-MessageData-1: n8tmO60W2QF0SQ==
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9aee03-9241-444a-0d72-08deff9fd82c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR06MB8174.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:18:32.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QtqErwTch03ikA8FKGiRYcoCG05Mv8i89FttWr++NSKt6oM8FYDHLZiK0WzWvkBNKKbyTH6AZK9hkBxKoZkk4CZ03aHJ33NgRbh0uODPJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6869

Hello all,

Sorry, a bit of Friday night brainfog:

On 8/21/26 7:09 PM, Jussi Laakkonen wrote:
> This patch set contains a new D-Bus API, net.connman.DebugLog, for toggling
> debug on/off during run-time. The API itself is implemented as a plugin an can
> be enabled by building ConnMan with --enable-debuglog. The aim is to help in
The last line should have been:

"be enabled by building ConnMan with --enable-logcontrol"

BR,
  - Jussi Laakkonen
