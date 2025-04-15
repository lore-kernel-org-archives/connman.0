Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2113.outbound.protection.outlook.com [40.107.105.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F3275105
	for <connman@lists.linux.dev>; Tue, 15 Apr 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708765; cv=fail; b=DnZAYfrbr75Up6xWHJBeQeC2cR/83osq+a9ZG9DQiCrHdgjgU7wTmzpItWRqEUsvUzflQ9LbGPkYaRKL09kC/sJjl/P6gXhMBeJVWGt+w73nVTaGIO1hEEgu/f3c4+O+CHv9CEcxgjLygpKb67lVVNS23MHq/ebdfJ/QptaG+nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708765; c=relaxed/simple;
	bh=YM9Kinrs5QLloaj/vmdcebq8dgD4aUrlUk2WzHEV3A8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2G2PIZmwPT3G/cJR6wo0cXYesOIOOvCOO/Im37TZtianOsqCZSetKR4vK5Cay68Qltw9hQQCkShkP1zGKs+El+vNQ1mLyztoce0nQm9jXT434uy3Qlf+2/KLEOW7SAg+j2C8oowMWiO5h1RTwYy2frvXCU5T2544xUNAjKUJrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=I0z1F1WF; arc=fail smtp.client-ip=40.107.105.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="I0z1F1WF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyNc9ZSrrY7SjBr7C9Jq/9okxbY8E9T5YHRcIqaDD/MTbjtrA7QqxaE4noppNU7NZocaXkExAZWbgtb/GAxSCb798Nh2iqpjoQ45O1C/NPKluEDOSNtR8K6dZ+RHH42oBHKdtZN6o3x6PZkB8WXfXtmUL2dMX5CNOh0hR15Pt3QJXy32uJjFC6ZfHNbSKcbp51DDfttxGcoj9zBw7GdHqDYvz1HPVkV0kfcDbNVRVYWKQNmSUnJpMbRmOL6mLU/o+3lFc47IepiDFaQ8sfx4dNzaxZv+43nL35xzAqIf3RnGW+8ri0tZ3extBydJ2xxb0P3asqdqj68lVxPTqIs5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MF1bjmgFPdDY6UJVDUCkW0uIfRhl/f5g4zuyH8wWMg=;
 b=VxHsU6XooLT+Z1goXYe/NTFmAEiAHsGx+jDM2s1FWgYhkCIwrZUJUBcnUnQaJ3lmc6WI3CMuOYxcT6AeBKOo59vExCYjTHpitymGAOK3rW0X6TIqRi5QEnJoFS6w6EY/wfiBZ3V706VjoMVIvbAAFTcWSURPZZNb4Ji87f++2sgxF4B1RnC5sPxgq1JoFLIEhciBdoxI7UsOYxESOgkfBfLdvV5kx0/qjB/OcgYUAs35gK3xornXAW0BYunA5QVeiSURWmHUnbk2vDSponmhMeMYq+UXYjhh813C+AFaruMGmBPlScNybl7sqslVOdHC4yPgggTrRa0fpjIemceURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MF1bjmgFPdDY6UJVDUCkW0uIfRhl/f5g4zuyH8wWMg=;
 b=I0z1F1WFu4Y/j5JHha3qFlbZ7CjizjZDfYhW0tYcXvLTxHi8nNwkmZfVvmlp9zNnYgAe9GaxTPp5rW7qz9t0N5mMRRzHo+7iUQlMUxnsWhT5vZ53ZIOSg49jbRMHF6TyQ1qd+ChJIPiTcuyVwzqXuQVZOErsWcFZA5J5HjedcC8iKsYS8sfZeTasoLA4GTNcOK6euD/+MEw3KewwfAPGzTOC7xUjpNnWo08FU4uixetUbp4kNpck3OCGIFApvS7epb5uV6k5yTldc/m5rOD/5tYcbhBZB6jBdl9nt3DyZZL37GN8vpKcnrJ0+6fanaSUrf6OSyq0zV81zq0BhY3hiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PR3PR06MB6747.eurprd06.prod.outlook.com (2603:10a6:102:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 09:19:21 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 09:19:20 +0000
Message-ID: <e10190b1-9dbf-42ea-b475-77573ee38e8a@jolla.com>
Date: Tue, 15 Apr 2025 12:19:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] vpn: Fix mem leak on nameservers
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
 <20250410155846.252858-5-jussi.laakkonen@jolla.com>
 <45488d9e-325b-425a-841b-599aef0a5a80@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <45488d9e-325b-425a-841b-599aef0a5a80@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::20) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PR3PR06MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c30613-c07f-4d73-edc2-08dd7bfe9ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmNVQUdSRzBuYkMyZ1VvVy83Sll6T0xzQzFESzhqRVZBVlpkcEFjQ3ZJNmRH?=
 =?utf-8?B?aXVGS3pFaVhiNlY2bm05Wkg0S3NvdnBNM3dMVHR6b2dZK0tGbG1tTmp6bnR2?=
 =?utf-8?B?QWQrNTVJRHRZTVlnZW1xV2VvdlU3TUFReGJGN0hWd0xtSFl0aENhTTZGRS9y?=
 =?utf-8?B?YjVvZitxVENicFJwR2pDR0NmRWtQTldENnIyZkRTYXFjRFRuSlEvZEtlNTdY?=
 =?utf-8?B?WlBaTm5mblBmWlVJamQvRlp3d2RBMTM1anN6NEsrUmsrd3hrcVV4OHYvUDE5?=
 =?utf-8?B?Nk9zM2ZEak1iYVo4MHBVTGpTRDJpcWhwTXpVaFA4aDgwNC9PZ1VPSUFLeWFB?=
 =?utf-8?B?MmdRbG1IcXp6QjA0NkRWb3cwR2pWcnRKQ20wSU55RjBENzJTbmFjRm1rQjNO?=
 =?utf-8?B?ckMzcys2YVVTZlRjYm85YlUxYnRyOWI2Vkc4UzdselRQRitkL0ZCdDFGblNB?=
 =?utf-8?B?cFdCVExpMS9PKzd1bDF1ZU1rVE9laElrNkhVOFNDOW5YWHo5TzZIOW1TQlly?=
 =?utf-8?B?dHNCR3E1SDdKeitvRmdoQ1ZBOVdTb1hWUExqVWZia3Q2WmVVVGNKUUxWZWVF?=
 =?utf-8?B?d3AybS9sWmFjZzk5U3pBdE9FUjJwMHdGcUNWMEdVaUJ5ejVoNXlNei9yd1Zo?=
 =?utf-8?B?Y1VMV1hyaE10czRKeEk3T0xXMHZhUklYUFF3OGlxd3lHZXMxYUcrWHdVTll6?=
 =?utf-8?B?MTc4Rm8vZjBqK0NORVltaVBXOUVTMW5JZk1RR1hvajZLaE1HZ25zeGFFOUF6?=
 =?utf-8?B?VjF4cytiOHYrVmY3TDA2MWNqNlVEcTl1ZmxEQThpa2NYQUJJTjlCME9DNWdn?=
 =?utf-8?B?VklYL1FkeU1hWFYzQ2I3OUkvTU9PS2NCRU9aaHhwOWZDaUg0VnIyd0x0N2ll?=
 =?utf-8?B?MVNtUHQ5OHhwajdYL0p6TnBzZHZPNXMySHJpRzJTcGxUU1pzbXBtbitUMzNJ?=
 =?utf-8?B?SGFKVkd4N0srcnhjWitpbE1oUGd1SkxpRThjZXFvQkF2Q2tSQ2RUS2pjUTlZ?=
 =?utf-8?B?dVpxQStsSHNQNGF4d3dJR2V5Z0FubmNFRVNIZGEyLzhZbngvbEpIWnVSeExK?=
 =?utf-8?B?elB1Njg0bUhXOG56aEdSVGR1WkJrK0N5eFRud2QyVU9JbUxDVklVRFl0T1M5?=
 =?utf-8?B?UXBFbXRpL2NLcjhCYUNSdjNBN2Rtb0xkeVFQNnNnR2o4VUNOY3RaZ1RDUEVq?=
 =?utf-8?B?MWRCaVY3aWRWSWFHajZOQWg3N0hWM2dSNmNESVpXaU43TTVaWmdzK0FsbjFP?=
 =?utf-8?B?ZjZoeTlLb2tsczJLNlBwSk9uOWx4emJrMU54aVo5dUF4QlFxTlRYWXRtSllZ?=
 =?utf-8?B?dWpreFFhdTYyUHNaU2gvOHhlaTRJWjRQWi9uR0hoMHluZmJ5TEw1bmlyMW1H?=
 =?utf-8?B?a3NhY0JrMjFqSllteVNLV3M0SkI4UW03dFUrbTlMcEhDRDl0YWk0anBZUDBX?=
 =?utf-8?B?NWpzc2tqOUI3OGxRSzJNdUQ2NWpqWTRNbmpocVRlcm9aLzFUT0tpbDV4WW42?=
 =?utf-8?B?SkxZaFFuVVp1SEJzdFEvNDhoK0xRaEVHV0NjdVNQRXJpS3ZSK1JYaEM3enNz?=
 =?utf-8?B?NTJhRmpOTnpkVnU0WWQrQVZRTFJMMGdJWUxFOGgwSEJ4RlRxNGVuVC9LQmg4?=
 =?utf-8?B?YUEzNWx0Mm03ZUlXdUlmcXhqajBGVUdOM1FUemJnTVBHVTdud2xRdVJmLzVw?=
 =?utf-8?B?V0YzdTJhSmt3WGdxaHRLM3dMWHZGY2lMWlFaRTVOV3NFeXV4UEFIK0RHWk1Z?=
 =?utf-8?B?V3crSWVJQnp0dDFOenRWOXorRDExWmVtSGxKb2pGdTAzR2t0QXZMbXlNTXNs?=
 =?utf-8?B?QmdqWWMxcWlZS3VpOXJEM2xJbEwybVFzcE5GUUR6Y1AyREhJaHhmd2o5dEsw?=
 =?utf-8?B?WDNmdDZMY3NPdW5HbDdnSnpkR3dPamtxK3VDWWlLMmJlVkhNcWlWNDh1ZkdZ?=
 =?utf-8?Q?3qymJ2CrsIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zjl1Z21sQ3RPRFVZc2JuRXcxOHRmYmRvbG5rQzhockNia0JxY2xhRjg4aWds?=
 =?utf-8?B?ZWhnS0FXU09JWWt5bEZZNVMrcTVqeWVBSjYvc0V0T2UxVDNaaCtUYTJpblJ1?=
 =?utf-8?B?d2NOZ0Fxa0Q5WHpLa25Wa3owT25TckpGRW9tcS81OThBNmZmMjViZnNkSTJP?=
 =?utf-8?B?RGpHZ0lOYXFudjgrQzNZcWpkUWpHVnZZdGltNGx1UTBrbDVpOVRUZ0gxazVJ?=
 =?utf-8?B?YzlVVnNPYUkwOTk1UnVBQ1hpZDhCZVBHSDV6T1hYVTN4ZjlpejlpT3pjMzRz?=
 =?utf-8?B?T1l3azlwM3Z2MHd6VHBpTGhzTDg1UjdiSHo3azNyTWM4ZlFBVW5NRktWWU1i?=
 =?utf-8?B?YzBiRjhVWHd6MUszVWlDYVhwbXpNdkJISE5HVUMrZ01XWHJ2Nm9YYm1PQ2FN?=
 =?utf-8?B?OC9nWEgxMzJrUlR5ZEplR1JycTBHTFh6NjEreitwWXhGZHhreE95OEdOdFRy?=
 =?utf-8?B?aWZWenFiWEhiU1pLcnMybzczeFIzOXNqaTFUU1NYcFBQU2Q3cVNDaXRWV3BP?=
 =?utf-8?B?QUN0cm5PWUJqNUtkcENuSEZuWWNWZFdPWDVHU2dvdldYeXNCc093TkVhUndH?=
 =?utf-8?B?K1VKYjVTOW5oallsOE5mKzMrZVEvVUdIYWVMOTF1bWMzSjlFRDcyam1PcW9S?=
 =?utf-8?B?Y05YOVIrczZ5THVsbHpsaFN4Vm1VZFJ6OFkwZEVNZFh2Tzl4azBlMGRQbGND?=
 =?utf-8?B?ZlpsNkdmZFp6c1M0c0M1Y3dYUUhBTzJhYUlndU5WQUtHQ2NyOGk2S3MzcnZs?=
 =?utf-8?B?WVh3eHVTNkkxVE5DaHpKSU5aK1dvQ2d5UkZnNFo3SnhzMndFeWlMcnVNaVZi?=
 =?utf-8?B?bVFSd0YvS1ZuU1lmeWo3UEc1S3RvN21RZm1OU0tSTHZBSGNaWDRRRW1pd1lt?=
 =?utf-8?B?MmhEWm8zVmduVk1McG1EbC9WSHliMUhUMjFpZW5wWFRzWVYvSTdRQlJUeUJE?=
 =?utf-8?B?OHVONXR2ejBVV2p0SHY3OGQ3SEgxUVpDejFhNnBQdGZFcytnYjFETW5lUVBD?=
 =?utf-8?B?a1ZVRzdCb2xIN0ltc3V3TzhrcTREVFZGUmVnQXA3NndEQ3FmTm8rK3FXM25D?=
 =?utf-8?B?dTA5NDFLQ1FBZW9FeGtWTU5tbG1sMGoraFF2Z1pUMzJGMXZTTG4zbHRRVWV2?=
 =?utf-8?B?R1ZYSFNJM052Y0ZCL2dNdDhHekM2Sm5lN1hnbnBhMkZQL2QrcTB0OGVhRmRi?=
 =?utf-8?B?R2w2UCtManpxNGV1eU1kZWlGNTA4TkRacnNuOWI1RnhlbGdoc2RmcEhGdmEz?=
 =?utf-8?B?VHh1OG96NzdFZUIzeEZPN292TzV4bkZJZ1hBZDV5ODZVYVd2SisrMlJxN0lN?=
 =?utf-8?B?QW9aMThtcXpJbHZ6UUlDU0JUSmljRmorWnRBWU1idWowQ1pLUDVzcDQzUkRZ?=
 =?utf-8?B?QkcvOU9ES2dSVVNlV3JCZVZOQjRVeEE0WTlsNjlVeE03MVMrdnFKK21oNXg0?=
 =?utf-8?B?OWdVSHRnU2dwVkVLYXh2b1Q3aFpqL0NWY2JrOS96bjBWK2pxSVhHYS82Wlp0?=
 =?utf-8?B?QjRsdTh1d3F0UTVxclg5M3hJdC9keXZMcG1jaFAvenBFajZXVVFUa2duMFEr?=
 =?utf-8?B?VzlKT0JSNG9FNk9uNGd6K2JSVG9jemt1L1UyZmpEcDhsWW1Ia1Flb01oL3hQ?=
 =?utf-8?B?TEYyNzNURU1vSzE1WG95Z2ZBWUxvdFpxUTA1a0FtV3NFdE03Tk5PNjVabnZC?=
 =?utf-8?B?b2sxRUlobjVCcTAzeTBrODNyZmlMSjVnMDlNK2RQenVjc3BHTGIrNnpVZmt4?=
 =?utf-8?B?d0x4ejdvY1JRem4zeXpjUWVDSzZNVGgwVkZCTUFkczBNbUxYVXEzbUt6WDhL?=
 =?utf-8?B?VEpwb0tEMlNsQUNQUDFZby81QWxPZFlJMTRvQ1UxR1RQYWlFQlZtZkh4emlQ?=
 =?utf-8?B?MHZPdHNFcmZTUHE4RTNDR1JKNVltbTFFR3EwM1lGSlZNeTJHcjB2d0lwZmRa?=
 =?utf-8?B?SjJJa3dETUtWZ202THhtaEF6eEF4N044UHBYbUxNZ0ppRDdXeUdzWmZuS3l3?=
 =?utf-8?B?VUhYWkRUV1BWSWx4ckV3ZnNlTWt4d2IwUkNYMUROYm9EY0k4N212YkdjRmxy?=
 =?utf-8?B?WWVMUUpPQ0dNa1dkeDFLa1N3ODdoN3NaNkFBWXBNSy82WnJsb2ZEQmNUSEJZ?=
 =?utf-8?B?bERaMnJqWWdpaUozVkJaSncrMzFuNi9VcWpaQll2YWlyd0dtbGZvZ0QraURj?=
 =?utf-8?B?ODA0NXB4eUlJTk1JR3VONHBKZzl1MjVMWlBMSGtDQllUK2x1NmFwZzBscW1M?=
 =?utf-8?B?N0VrdEpmN2xqelZnN3QrVitBNmFBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c30613-c07f-4d73-edc2-08dd7bfe9ae6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 09:19:20.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+WstLPpj990iwdlXFJ71KBgIJFtP3UiwbKs0hLqIFavUrJvk49DGhosBxJkf/7ZSa47TAtG5tuxfNzewXGgSmlllWQWVMAA/p+jtkOcJOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6747

Hi Denis,

On 4/14/25 18:38, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 4/10/25 10:58 AM, Jussi Laakkonen wrote:
>> Fix Clang analyzer complaint about mem leak on nameservers.
>> ---
>>   plugins/vpn.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/plugins/vpn.c b/plugins/vpn.c
>> index 9664c82f..9e6e26bf 100644
>> --- a/plugins/vpn.c
>> +++ b/plugins/vpn.c
>> @@ -472,8 +472,10 @@ static int extract_nameservers(DBusMessageIter 
>> *array,
>>           DBG("[%d] %s", i, nameserver);
>>
>>           nameservers[i] = g_strdup(nameserver);
>> -        if (!nameservers[i])
>> +        if (!nameservers[i]) {
> 
> g_strdup() doesn't fail (it aborts).  So I'm not sure what this is 
> trying to fix?

Yeah... I guess I fell into the paranoid way of Clang analyzer in this 
one. Getting a NULL from D-Bus for nameserver might not be possible 
either. Yeah, maybe these small allocations should be treated 
differently. Can be skipped for sure.

> 
>> +            g_strfreev(nameservers);
>>               return -ENOMEM;
>> +        }
>>
>>           nameservers[++i] = NULL;
>>
>> -- 
>> 2.39.5
>>
>>
> 

Cheers,
  Jussi


