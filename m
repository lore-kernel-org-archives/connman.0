Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2095.outbound.protection.outlook.com [40.107.20.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF3190068
	for <connman@lists.linux.dev>; Mon, 14 Apr 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646455; cv=fail; b=s+B8cGyJ1CvwESTL4uUK4tFln2iOAkIzz2N1NLaFN2HLHrgEZ6kypuKzPlxWiNW4xSh+W/B49mBo3i8UFiSXSaxoAsE52bCTdANenyDoS4R0jDGJYUdv9uBRVf0ZLZjdJgEq3Lj/uPAEXdPof9NFox83i/5gjLFhciTdXyFpIPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646455; c=relaxed/simple;
	bh=BPndsJpV9zbMHz0HbS3gRk280fwDIzRTcCDzpedhPwg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPwbziqnNCLNG6vtPORqpLqvLHx6PT/VXJen90lNf1uqE71O21UU8l6FKbddi4mkPtKCZVlB2DJkW06KSILxbQ77DnafH1zBjlBmDV3sEdpWUJcWVAEkNmGJ9l08EWNE8IV6g1gRqElODKCu1h7460WbVEQJFG1I/eBk435JHNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=DZ1x8rae; arc=fail smtp.client-ip=40.107.20.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="DZ1x8rae"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVWkrmK0j5anx+bz8N5GA2FHP/KNIEB8KhpGVR5G4I+JN4iCXSeA3cIzuxdJ5pcWrMcACvejj3E1GIBb2Dpo53TVM2bZzvrQ74S0h0+AYQSmSTdwLra/k8kMZqt8oOC4YgFjNrB/BAUPl6NdbmwUO5JDHs17GXXR1QPL/2AUU0Pn6zmAaih0pSterp0gOKpeSbGsCgwgrgJBR34LcAPfdIY0bfSF2WdosetLr9Aq7/XTeYoD7Wm1Sa7RSvgJkCp+RvE7DhZbZVeyEc2kaRvDlMYQd7uzwekB4ZGED9JQRS8K1MXEsXVi2rYl/tVu/V7ahI1Y1Cb02RGOliGnEHqdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7CvTIdYzLSTSj6gWwoxyGJnvMFhPk787W0AJLbDUjk=;
 b=hNzH6RIwJc9KqNM3peuw02q+9Ayfm5Eeh6h+88yyrKGheXtHH/KsYj7dOSKcfWW+XLoLynoMdKC8nkMo/AnVB1eaoYTYYazzTL13nxHOXEODX3ANy+yJ9Hr3A0Shac05AiNireH6MKzrGLRgVUzJ8fuU5fKuCaJSfKvp8foTdOMwRDOtg7sMB5dLVVviToA5FCXZTtdBQFMfoc9Dr5ERRBOpy7mnbZmIehsb4JfUvHX11ASZ9rgAZcbkglMhSfl4UJzazbiV9B/i7HFJHy+uQq0cKRN1ZJbwjlwVcB6g6MNQqz0+t3HhbAo71YZvxcTfbIhzupfpaWjLrxDTqGFpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7CvTIdYzLSTSj6gWwoxyGJnvMFhPk787W0AJLbDUjk=;
 b=DZ1x8rae/+XEQ0eQVCNeqLFW+b8CQ1ExHd72CguFDi7Q4aGzK+vXNCzyL/BYtDIUCPlnoM07SX7a3KcgaEuQQyeF+xH0UG3tl7IZ3TtsVKaiXMUGqemplj2oU52vUInRjcAPjAXHB3UpA9qQmNqizEN5e0j+pP1eRc57EPJ/qRzJp/YLL1GNS8W8/4b77xBf1Pt08RMeK1MXSxyCyMbzpd1RszlslHrxrzEc2mX5fabpDR2oVEvc9odFe9emPZreLoogbS8v8LDz8kV5EENN2F+P/CfrXZq1hXWszlK63URB2TpwkJti84rohisVsqBwLdhx6KWeLrqnuH+NP+GZqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by AM9PR06MB7345.eurprd06.prod.outlook.com (2603:10a6:20b:2d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 14 Apr
 2025 16:00:49 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 16:00:49 +0000
Message-ID: <5cf0d794-ec97-473b-a327-c7714a29af4e@jolla.com>
Date: Mon, 14 Apr 2025 19:00:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] vpn: Avoid using uninitialized prefix_len
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
 <20250410155846.252858-4-jussi.laakkonen@jolla.com>
 <fb741df0-6f1b-4287-b494-60bb0d8e618b@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <fb741df0-6f1b-4287-b494-60bb0d8e618b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00006633.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d5) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|AM9PR06MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: d90f78c8-1101-4849-a8f7-08dd7b6d865e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU5kSDE2Z3JZQWZIOGhUOVdWNElocE9jSmxiM2dtcGp0NTY5c0U1ZmFpNEdh?=
 =?utf-8?B?SW4xMHZqMmJjZDg2TVp4cHF0VEZFYnl3d1l3Z2V5b0pUU3FCRTh2RmJFSmt0?=
 =?utf-8?B?elNkSDN2TTVNMlM2VFU2czg1NXdWR1dKdlRXNllrWCt5c040aEtEdDhnQkMz?=
 =?utf-8?B?VmtTNHRPMENtdVlYT0NaNDFtZEVkcW5RankxK2pTOFk0dHdJdWRVK09hdFpU?=
 =?utf-8?B?L0pHbXgzbXV6OGE3aEJMSkRzWVBnVEhoRytLckZ6bEhGcFlGYkh0OFhkdWph?=
 =?utf-8?B?UHFHbWZXYnV4Z2ZDY0xkQ1l4bGZBS3BOdmxOeG1iUlFBeUxmZkE5aVZTSFdz?=
 =?utf-8?B?ZTM3VHYwRXFtU3VKQjVCUHkzN3NKVVFxbndWMHpQemx0dVdWaC9ScThTRE5y?=
 =?utf-8?B?OXVRaVNHUXY5aDV2TEdpZHdOWm8ydHFCbXYvcXl1d0t0a2Z2Z3VIQTZvV3ZE?=
 =?utf-8?B?bElvMURObThFcE1wWlV2czlSMXl1alJ2NnFHdEtwc1dMaU9xU243WVdrTFBR?=
 =?utf-8?B?NEswVjI2Mm12WW56NzVXWVNITnp6aUZmNHU5VFpwZDVEZ1Fud25URms4ZWZq?=
 =?utf-8?B?ZGxGTENOS25hN3g0MGdwS0FwTFFMZUpoaVRiU3NCRUJJRFQ4YSs4V2c5OVRH?=
 =?utf-8?B?UDNZUXRNa3czUnJjeUdRcTZldzVvNFhLYitqc3poUWpCY3BCQlNpWllaUUNZ?=
 =?utf-8?B?YUo5ak5uWGNpNzVPUVNRWXh2anhmQks4VDJjQnBsZ0E4cENQaHllN3FtVGxU?=
 =?utf-8?B?bGJ6SUtrWXZLcEh6b3J6Q1phQ05mSXRzbHFUTXRQK1h3OFFselVrU0tvRW9P?=
 =?utf-8?B?UUtEdUptL2NKZy8yd09MOXhQSHp6UzNoYmx5dE42eGFpU1I5ZmNobEIrVjZj?=
 =?utf-8?B?dkFkVVRpRnJLcmNmMEtiSWhLYk9xMWIyT2czZHpwWkYvN0NpcDVNVEhML2xB?=
 =?utf-8?B?NDBMdzk5M3I2SnRlQmdkZWt5eGlSSzdkWkU0S3Rybm5HaGVIYS8xUTlQS1dy?=
 =?utf-8?B?SXhLeWdPa244eDNXVTRTK21ZNkF4bmU2eWIwSjRFVTdTaWFwdWd0U1dwRElS?=
 =?utf-8?B?a2lxR0hYRHI0b3dlajNweVEwM3pJZ0wvcFZKcGdrMXRtRXJRY09mMGJFVzFK?=
 =?utf-8?B?MzliUEh0QlZSZnpQcHp0U0dzZ3dKRElyVnVzVk8rKzdoQ3JGYzhJbVhOSDdm?=
 =?utf-8?B?VTl3MDhpS3hUQzVkbThsVWlFYkxJZ29uMzZXUytyV0hLVHBqcnRHWkRFc2Rk?=
 =?utf-8?B?Z1p0RzBZQUNkS3ZFcXVrczB3WlcwRVlUcWtQeXFCUEtKb1dBNmNBdGNYMFpB?=
 =?utf-8?B?UUY3azg1ZnV3OHQwN09UaVRsYVd6bDlGQXZOdkhGK0MyU1B1RGE4c2ZZVGlo?=
 =?utf-8?B?ZW93QlIyUlg4ZEtNK2hMM0hLSzhNcnpXYXd4aUl4SlR2cU1USXNwenBEdStG?=
 =?utf-8?B?NzdGQXp4bUtVUDg4byt6bjZZU2NHbkRpSmkxYzBsdkgwcmZGVnU3SnRkcWJU?=
 =?utf-8?B?OWFPTHRwa3MrenJuVE5lK3JGcVdRQjBMNDBYQ3RuSEdmQWkrZzgxOTNPeTdP?=
 =?utf-8?B?aDJpcHIrSmw3SWxyOFhzWXR4b05pdkFUZitwei95WGJrTWFySWlxNFV3ZE5Q?=
 =?utf-8?B?UmtlS3dxR09OankyS0lEVG5IS2xTeGI4Mk52V1FGNVErZ3pCMEVNM0I4T0pF?=
 =?utf-8?B?Ym5SakFnME9lNkIvemhJSkQzNWsycm9lUXBnWTVVdFA1T0tzMis2UVkybWhx?=
 =?utf-8?B?R0JzRytGUTkzVWJwVG5jenY5SFJra0J4d1kzbGJ1R01VM0V5SCtxclJScHY3?=
 =?utf-8?Q?35D5nwFnKz5uuYXk4qEMSCJ9zbsgXCKUowCcY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2VKNlRvNDlxRmprOXRWVFp2Mm1sOHZRdzhjQzQ4eEo2MjJNODZtU2tzVDdq?=
 =?utf-8?B?TXk0OC83c2RPUWdTa1lEL2RxWlAzblFPdzA3akc5NTQ5bklpNkY0anJ6NVpB?=
 =?utf-8?B?RnMyUWhGT0tWWW9nZERhK3o3L0FtNXRvNm5lam9HZVhpOEFhMzdzUWlvUW50?=
 =?utf-8?B?cG1rSzVBRjlFd0tSNTF3QytmdVdFRVRoNWZZeGFLUUV6dlhnVVdsODEwYU1h?=
 =?utf-8?B?ajIrNVpXTzk1bUIrbFk0RStSTmVNdFNSSmtQdUJKUysvTTQzTmVXdmFDMEg5?=
 =?utf-8?B?a2p1L1M4Njg3NHNzOXlPc21SUGU0UXVMSWZpV2x2M1o1b1lmdGpVM2xISlhu?=
 =?utf-8?B?ZDJJSzJhNHQvQmVmb0VIRmpETitVYklqYWxoQnpvR0dBV2VGNHRPdTdZK051?=
 =?utf-8?B?MzZwV2hxbXIrNjVSdkUraXViZEZKbW93LzNkZGNEYzJmR1VOQW0ySlREVCto?=
 =?utf-8?B?NXVCckpwQkVqbWhZSUF6cERDd0Z3TUlmQ0F1RmQvc2orRUhQQWdFblhlQURn?=
 =?utf-8?B?ako4N0ZabXVXQlRBbVBUZTYwUVRVWGxpUkNvSjNTR2N2WHI0NEp5VEx4dWg5?=
 =?utf-8?B?Rlk0ajl6bmpPZXFJZWM1S08xanllUkk4K29ZV3lVSnFUaVhUemFpM3lGclk2?=
 =?utf-8?B?aDlxYXg5MGtvdFluTXpFZTZmbmZnL0NkSktFVDBhWlpWTk8xb01rVFZqbUcy?=
 =?utf-8?B?NDNUbkRvYWw5M1VhYm9GRmtjbldJd1NZV2NTekVOaEtHdWV2MS95ZzJGMTFU?=
 =?utf-8?B?SWpBcUYxMmhpMzFRMlFLWEJKdWdqZ2Y3ZVMrQmVnVTM1dGZFNHFmbkNNR3hp?=
 =?utf-8?B?WDlxeW4rc09ENmNGWXgyYnNTUmtMcTJZcGV5Q0RnZ3AzZ0VQRG9aTDZlSWps?=
 =?utf-8?B?Q3dHdEFNWGNnbGRxb0FicURYTmJvVFQxYmJiODc4S0s2Z3FFbWhCSVR4bXo0?=
 =?utf-8?B?UE5pS0RoYmlYb0xqS0tsTmdHMncxT1czYWVqamVNcTVFZHJaQW9SSTdhMHJm?=
 =?utf-8?B?ZEcyS01YTVBUbHV2Yk5TN2tPcGFTRVZ4bUhvd1piM3VoVk1ydlV1cXhsM1Rt?=
 =?utf-8?B?WGRmWG8zejFoNjlKdG1XdEZvM09uMHNKSHlvczZlWUFZdm1WRkhsZGdJb05M?=
 =?utf-8?B?dWxrVTlabHY2MU9OM1RzUkRoMWYxVFNpNDBHV2lDSERFN0R5bXlMeDk3dlNP?=
 =?utf-8?B?MW5ZbkphTTFySGJ3bGdnUTRBTXpQOE5jOFZyTzBKRVVJUDFWKzRxSVJoSFlY?=
 =?utf-8?B?T2twRmd6d3FVeEV6ZlJ5Qzhycmo4K3pyS3VUL3d6OTRsY09ZRWlJekFnNXJn?=
 =?utf-8?B?Rll2RG1BaVZTVmhBM2tPSGJkam9XVXp4OUxGWFNkaCtmUHA4dVhMRnFrTFVC?=
 =?utf-8?B?Y2dXMFZYZkF0R3BaaGJERWY2VWx1ckp0aG5mc2RLcTRMMU5vNTEzV0F6S2NM?=
 =?utf-8?B?S3B2NzRqR3NyWWlrMGVYOVF3cW0rekdJeGV0MG5xcC8zWFhjTktxbzd5T0Vs?=
 =?utf-8?B?R284alB0a2xrRjZDNW1CNk1oak5xZ3pDMEN3K3M0dnZGSDBTZkNYWGFUeWx6?=
 =?utf-8?B?Q0NlMk9kZkhab1FZdTIwSFpuMnowYndZajZMbmJ5NWIxNU9Zb1Z6Y1dJM21k?=
 =?utf-8?B?SWw1dmVHeG0yL1pjWks4SXhQd0kzd0I3WEkzVnF1TDZmbXpWV1VqZzF3UXl1?=
 =?utf-8?B?L1U0YThKK2lvWDNtaFREUW5JTVRQUFcvcUFZZTdDMnU2K2VxaVBxb1RqNmg2?=
 =?utf-8?B?MGtCTE1LR2lCM1R1TldkeVFJWlVnWTk0UEFxUFI1dmx0WkorQkl1RnRTMHJD?=
 =?utf-8?B?cHk4eXN2UTM4cWNFUU1YUXoxN201WVZiR2hPTWJBYzVheDZsY3hUUGxYd2ZK?=
 =?utf-8?B?VEVSWkNla3V6NGVzSFFWQkJQZFhkU29vaXpXTGhSMlU3NExPTDBWUmFDRmdL?=
 =?utf-8?B?R1JLRm1aWmw2TVZwR09xeGYyb1NDMUpsWHVPcUh6UTYvL3dpZC9yUFQ0ZzYx?=
 =?utf-8?B?SnovN1VyWkwxNXJkMDcxZlgrUmVubzNZL0V6QWVPRzFMN3dXQXJlcHhRa1Vu?=
 =?utf-8?B?Y0Y5cFEyeXEya1o3c3ZvOEpPOHFaZXRad1gvSGVCN21HK3M1S0xBaEtSL1Yw?=
 =?utf-8?B?MmZOWS9SMEFaUVo4K0l2bUpJS1h3THZwd3RmbmMzWnQxMTdGWFNBSTVkOXRv?=
 =?utf-8?B?NEgycTltbGNGb2hpZEptU1pBdHA0RUpXdWdTRXVhcEpwYmN2UWJvdCtGNVJI?=
 =?utf-8?B?WHZHVGdyR2ZUUXZyS3NLRnMvV0xBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90f78c8-1101-4849-a8f7-08dd7b6d865e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 16:00:49.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N1tMUmPPt77+q2ABGjB8XVlJgALHyBzsVrqjXko+S4JWaWUAXhg8MimcZiCWNpP8jbd4ivqTiM0B5lYo2ZISptlssCJYeeCFR51cH9Nr94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7345

Hi Denis!

On 4/14/25 18:37, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 4/10/25 10:58 AM, Jussi Laakkonen wrote:
>> Clang complains about the prefix_len being possibly uninitialized. Set
>> the max for IPv6 prefix len as the value.
>> ---
>>   plugins/vpn.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/plugins/vpn.c b/plugins/vpn.c
>> index 42396d2a..9664c82f 100644
>> --- a/plugins/vpn.c
>> +++ b/plugins/vpn.c
>> @@ -4,6 +4,7 @@
>>    *
>>    *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
>>    *  Copyright (C) 2019-2021  Jolla Ltd. All rights reserved.
>> + *  Copyright (C) 2025  Jolla Mobile Ltd
>>    *
>>    *  This program is free software; you can redistribute it and/or 
>> modify
>>    *  it under the terms of the GNU General Public License version 2 as
>> @@ -388,7 +389,7 @@ static int extract_ip(DBusMessageIter *array, int 
>> family,
>>   {
>>       DBusMessageIter dict;
>>       char *address = NULL, *gateway = NULL, *netmask = NULL, *peer = 
>> NULL;
>> -    unsigned char prefix_len;
>> +    unsigned char prefix_len = 128;
> 
> How does this help?  You may want to share the actual error verbatim. 
> 'prefix_len' is set from 'atoi(netmask)'.
> 
> The use of atoi seems to be pretty dangerous here though.


Ah, now I remember, the complaint was because of this:
https://github.com/sailfishos/connman/commit/2fe641f0f7d6deb7b64248c134312db9e564f366

Which I forgot to push. And yes, atoi is dangerous here and the value 
should be read and set from the D-Bus message content directly.

I'll send this patch too asap. Thanks for the comments, it slipped my 
mind completely.

> 
>>
>>       if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_ARRAY)
>>           return -EINVAL;
>> -- 
>> 2.39.5
>>
>>
> 

Cheers,
  Jussi


