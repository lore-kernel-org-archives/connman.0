Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022127.outbound.protection.outlook.com [52.101.66.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2EC24F5A9
	for <connman@lists.linux.dev>; Thu, 17 Apr 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892819; cv=fail; b=tGKPwr5rNu9kpNaZIvZ51yKUXW5ORcVn3VHHbH/zbgi6lrTxNMMQMjKxUl3Jxo8IZbxcrCqrzfGE4aEdJmBGDWDfpAgpMeDUVjOYxa4B1uycGdnSA/3BJDdS5FO8PyILceZpgN/mzsXK06K74CBYtNwVGSqfjmC6va2Y4u6lnhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892819; c=relaxed/simple;
	bh=F61nZ/w84UW7H2AM3Yx8WaSyvN9iqn+ws6BJ18B1ZeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fv4S34VU/3x3yINF8wwRLseWH2dBhZZ84T73JtJw/LxKbW2G0TeIcpWugiV5j9tkslHtmRAFskKGftDp3nEeIKUO/rkBoborUrf6d8s2T4qElJLZmh3xJYE02pn+q9topvJ50U2M+HIDw5zGMdAWUJriPfRZV4x5uxsGwcVw3wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=KpQqWfEa; arc=fail smtp.client-ip=52.101.66.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="KpQqWfEa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZd6fsaDBPzZMzGPHoZk4MbB4XDrdWRA5r4kHq+awFrSSepEOV+ErWuc/nP971Y0EWjwWmnjGEHc/LMFmueFHKxOmkkUPyal4em3nqJZ/NWl+xs46/EWwmgBnieFzOkp3Ne3OtfMAMur99XeHmZnNLUw46l//cdLl2kdBH+V7YRngVTmtj4FVebfhtKP/VRVgr08To1KTUhozPNY4SRbjYUYexmP2P2dPHKVXpMhYOHnzcgV5augmZaZDMGijQjc6PvQBTr7tOz9/GCmlCv7+wBEWif5blHRbdCbV53FBhrXRjWv2ToQioTxDW1nC+j57EHMbS0EmGt6W0pl47XI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNXCkMUVXHY2lUhLlysQa+F+ZB4c6ctxFULGD/eN8Sc=;
 b=pB/0fjI+y3XMRX4ABG0ZPnCualYzWU7bLpAOFESrA9gxVRdlbBRhp51nMW8ZajPZoJFKfQFYJpTUSeVJqunPL3ILDwzbUv2wY5WKlzn3zHdSLQJ7hPUpW3DwKrdUmaWwZDUz5RqiSca9rtSxh3AZbcIhSr45dxibJV801kjYNsM7kTcgkzu3z9MjbqptoucKILO4STwaViEmn5CjlyC1wecn+tibmjk1OzmiiTWNP4hSg2qcll4KSQOgHoVxSC04Cqu81DL+aXeIGpS/2WTOzZAGuB9rCmpT2xeeH/aCGZLgP30HlSyD2bCbfLwdp5fPPnRarem/7Es09SBlr4RA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNXCkMUVXHY2lUhLlysQa+F+ZB4c6ctxFULGD/eN8Sc=;
 b=KpQqWfEasaB+THVHv/wQgJVSuel5NStGq7EXQbJ7IOr41Jf0au59BNQc65ORpwWihLJ+uLntEO1RXw5IVeX+EBy9prY544uHs3AnFFXxqsck6VjeOGZfg9gSflbHNofzqAAQ6swfcmwSmMAZUaQH7XdZSx+73nN06ro7CTG4iduTi1/Z4h3aCCeRH5TP2R1WssTq7NURSMFhlndMJHmX/4MCR3y6TmiAyTceXvhad2hTnrCJ5mb5JjL5CYT8u707cD0aH4hg6EaAf/v3dzkZZdEbk0qEeyE1fzACedf/OYTOgTrnEuGwdYl2N+eyukSGsT4FvqZHafS8Tq6j9DUXqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by VI1PR06MB6559.eurprd06.prod.outlook.com (2603:10a6:800:124::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 12:26:53 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 12:26:53 +0000
Message-ID: <c3187602-117b-4e33-851e-abe1f6a2eb0a@jolla.com>
Date: Thu, 17 Apr 2025 15:22:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Add association state for VPNs
To: Denis Kenzior <denkenz@gmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>
Cc: connman@lists.linux.dev
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
 <00708344-6372-45AF-BA3E-AA45DC298373@gmail.com>
 <1f1eb2d9-87bb-4474-9b49-fa219310bca9@jolla.com>
 <3b1ccf02-2b2c-4229-8ad5-ae0d4c03ced2@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <3b1ccf02-2b2c-4229-8ad5-ae0d4c03ced2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000453E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::355) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|VI1PR06MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c5e235-853b-4e0e-6e82-08dd7dab228b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzI0SWNqUDBiQWMrQ3dtcVBlUTRWMVhLWVFYbHFUV1libFNnTkpjUkE3Wm5p?=
 =?utf-8?B?ak1SQ2JUaE9MV05BRFExcHlyWms3MDdmR0d6N2t0YlVUMHhLRGlrMzRpQ3c1?=
 =?utf-8?B?TFZLWHREZ1dORHh1YzlJZHFnbWF3NHJyU2t3YTl4ckd2aVJYd3NENG54Y01l?=
 =?utf-8?B?S1NQMFgrKzdNa0Jiam9idUZEUW90NW1Id1RRTDZRaHQybGRCZmU5aUh3bDBZ?=
 =?utf-8?B?UzJTL0M0b2xIeGZxRUF1a09SU0t5V1lnb0tiYmh2OU96dDJhaTZoNWx3WFlV?=
 =?utf-8?B?VFNVc05tMG9XUnJCb0w5TWpROXRvKytwSHByOGcreHZ0S01LamNSZFhhNHVV?=
 =?utf-8?B?Tk9icmJYYXhpNTFISlVpV0hqbWhoZHhMZGh0U1RlR1ZXRzFKWG5mOU1QWXZJ?=
 =?utf-8?B?Q1ZUTVQrUkVBOVJMcjdiNVRpWnpINnNTamZob0s4Zjl3ZXdGWms0aG9JMit1?=
 =?utf-8?B?eGF3S09NaTQ3dGFRT3RMOHoxc0xNV1NmTnREUFprWTAzOExnQ2FiMk13V2J3?=
 =?utf-8?B?eEszUzhJQUtTU3NxYlVPQWlCNmtLTnkyVGpGSDk2R3BrWDYvd25wRldHc2Iy?=
 =?utf-8?B?SHh5VmtPaGVJcmx5WGN3MTNuT1hiYUlETEdCUkM3RzBiZWV1UkwwNWZQYjV5?=
 =?utf-8?B?bGx2RzhaTjk5YU4vejE4WSsrUTZEYjUyU0FIWWNRUWJrTnpjdUIwNStvTjg0?=
 =?utf-8?B?ZmF3ZDkyYjc2enppWlFvZzdPWWk2R3BtODRtWmhkRm9KdUhPOUtGWDVRVG1F?=
 =?utf-8?B?VVN5RndTd0Y1aHRZcGhUQ0xwVzlpRHhsM2RvcUtyWGFYQnV1dTVWc0xjTUZ6?=
 =?utf-8?B?b3BObU9XVnQrc21SY3duTTVNVVVmL1VRTXpPendlbTlGZ0Y1aXU5WnZJd1N6?=
 =?utf-8?B?eFp2N3Z6RkJtMkRMcFlMcHo4eTZYelFWQWdkQU1nWHRGZWVVZjM4OWNWTGNG?=
 =?utf-8?B?ZTFWV3RKRjNoampEY1VhelFLUmt5RjJsQlpPL3VmWGRQYjVQaExkb3pvWTYy?=
 =?utf-8?B?b0JxMVNYOUZGdnVsenA4cGlIOG5RQUpXTmFodXk3eUNDTXM3WGdBU0EraWg0?=
 =?utf-8?B?bjdJNnd4eWhvRlVXS0RnbCtTaCtxdjFTL2hmYVZXWDcvVC9pRWRrNjhvaVdO?=
 =?utf-8?B?K29ZK1EzSSt1NXZieDhmbFNUYkl3R3UzTmlFcjZPZHl2QmQvVWhpdlNmWnNK?=
 =?utf-8?B?RXZ3a3FDemh5SFZHNE1QTzdmMFJEM0tnY1B6RVYveUJsd0FxZlRzb3o1dGNy?=
 =?utf-8?B?QWJIRUt0WXJpWGo2UmpNMlBRbnBXdUVNdXdWUCtzaU00bmx2QWVTM3VTNXlX?=
 =?utf-8?B?MVg1bVM3QzJVUWF0Qzd4Sk0rUEVEZkhQeEFsem1oa2tUeklSb0VHb1pNZkxv?=
 =?utf-8?B?S2VZakkzenZXcFQ1Nk5OYXI2SEdtK0thcFZidVN1YkNHSk02ak5jQ3RpN0hs?=
 =?utf-8?B?ekgxU0pSa3B2Rlg5UlZ6UmZObElBM3hIZmRjdW1aZkthNSs3elJld1JpYTlL?=
 =?utf-8?B?cnFES25MbzZnZ0RSQnBIZUlXRnZJNWxJcmpDZUVzd3Y0OHRFRklBQjgzYktK?=
 =?utf-8?B?K0l4VVhvODZiZUt5ZmczQXNnaGFwWFJ3VThvcUovVDBsMnRyV0g1VGJLbXJH?=
 =?utf-8?B?ZUR0VWdmaUl2aFZHQ0tJU1V4WGxkb0IvbmlTNGdtb3dOTXJDRTJGT3grWXpD?=
 =?utf-8?B?d29VSTMvN3Roa2wyeUNNMXVxRFlYVnJkRGRlTFZqRmxUQzVGRnZlN3ZzZkU1?=
 =?utf-8?B?V01QQ1JPVjhaelVyUWk5K0RBdG1lcFdhNFlhamdhVHhVT1pUVk1LdHpGbEtE?=
 =?utf-8?B?dnNuTEVkSU1GUWQ4YVVEbE5ZV2lUeVJlelR3ZUlsREtISmIybDdna21GWVpI?=
 =?utf-8?B?bE9DcXl3U3Y1WE9tY01IL3drajZpQkpMK2x4by8vQXA2Y2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmY3YmszaXZwYUg5WlVVb2M3NkJPZFdFS1dIV2Q5ZWZSTmUrRjRpbHVUclJH?=
 =?utf-8?B?N3F5WkErQ1hkazA1QUFRMVVtbVNneldSQ3RxL3A3NnZyU2cwZVNBd25ncGVn?=
 =?utf-8?B?a0VWYWtoWm9tODhaNXFveVBFOWhON3UvWGUxMjBzOThNc1R0djZLTW4zVk5W?=
 =?utf-8?B?eWs0cWxXbUN3SUhBcW9kQnAyQ1A5VElEWDRKbHBPTWozL0JZdVBEZTA2Z0M2?=
 =?utf-8?B?eFRrUS8xSkRXdklTKy9JU1hIU3VIeEtvdlNBeTNjWXdwaks4UzlkRVVRblZx?=
 =?utf-8?B?dEozQUNBWk4zK1NLS1kyaW1UNC9iYmhLRC9TTUtDQTk5V1hUTFd3SWpNWHFa?=
 =?utf-8?B?WlVtTTlNVEtITEdac1RlVzZhc3NSQVNCR1dzeGw3QW9zZGl4N3FwSXlPTkZU?=
 =?utf-8?B?bnNrVUIxUlByRW5HT0ZZdzB3eklXZ3R3dVVNUmdzR2lOeVI5dkVQN0xKTnZj?=
 =?utf-8?B?MWs2SXdCdzBSdlVudHRXV200ZTlzK292Rlp2VWRjSEx6ZFJocFc4b1lFMVN6?=
 =?utf-8?B?RDVRb3BsUU5WYm9zdGVNTGN4enp4RUYyckx5U1dEazNPL080ak9lelNVUXVM?=
 =?utf-8?B?a2lhaEFGWktQcDBnSmgybFdsbWJacGxTamx3TGdEWXIwdDkrT1FhbUZ1cWtW?=
 =?utf-8?B?dFd4NGFCTWozR1M5dmVmYVQvZEx6UGZkbXpoRGc4UlZ0TlFWNjAyZllSVk9a?=
 =?utf-8?B?ZzBIeGlKNXBJZ2Q0T3BwQnlYbzJkWjRrU2lKT3c2NnBpV1VIL29JWTBUSlpK?=
 =?utf-8?B?ZVRoc3pyaWZFWEQrN2krTVYzMWQ5M2E3UnJrWXlpcmRRdlE0SGYweHRBSk0z?=
 =?utf-8?B?OEc5cWJxYkZZRmVKM29yQ2tYYSt5WEE5VDd1aWdRVVZPcGo3UllTVjg4Z29I?=
 =?utf-8?B?SHJ5cnlCYURBYlBDckl5cVVaMzBGNkwvR1hPRmt2SFd6NVpZandaMnBwdExu?=
 =?utf-8?B?ZXhYeXNRZzJjaEkvZEYwc0ZQVEg2MmFYbDZPOFNDd1NqbzcwUnBHOVROaEh4?=
 =?utf-8?B?cFYweDFPbnczVXhETUpJM2dpM0pNR29qV0VjT3BZdUZqdmJoeUozejJJajNM?=
 =?utf-8?B?aGpiUEUvSWl4eldmTi9kV1l6b3pqbGtzejV1cmt3TzJNRmtoZEVYQjloRnJP?=
 =?utf-8?B?VnZrbGJIMUg0R2F1aFJZZjlUTnJ5bVhVQit2aDAzZ1crV0NMSVJZVnZPK3Yz?=
 =?utf-8?B?RVhQTnlNVGxaWFVmVFkwZWd1RmVBMlRTZVNBY1VrZ0VsTXRWNjFJaFU3cTE5?=
 =?utf-8?B?ZlRJU013Qm1PeDZ3cFpNRE5lKzdFUzJDYVR3QThjc0hjRXpZek9tVzlRT3lk?=
 =?utf-8?B?U3V1MlQvWGFhb0dPM24vZlpjVmNyd3NUOTVONmdwSm5LNkt6TEtVcjl6M2Zk?=
 =?utf-8?B?MTk0dzVON0VqY1dyYmRpL0NLczRuQUpWOUNrb01rd09XVjltYWEyTllpTU5r?=
 =?utf-8?B?YmlzVS9ZVWdJK01LMVZrMWZOb2tkVXNuMUpDa0ZobmdVYUt0a2VvNXp6OUlF?=
 =?utf-8?B?R2tYdzgrcVRCcVRHNzk1RzJXRVpRSkdVYVJkOVNQYks4Mk1qMDdQWnlTblJh?=
 =?utf-8?B?bGxxalJUMGcrUUNrMmx3VlV6UHRicW1NcFJYazkxaUptVnBJZ3J6a3JscTdi?=
 =?utf-8?B?N3FqZlJ2Yno1Mm5zcmJsZy9zb0FLa2xxL2xoOXJoSkhHeUR4c0Y1L1ZMZldx?=
 =?utf-8?B?MVZ2N29rcTlvclBNbDJjWHhlbDFNSXdLN0I3VlA1VEIwdUhBQlNVOFdvSEFO?=
 =?utf-8?B?bGhLQVF4MXJnc2NrdEduOGVudEkybjVKNmZ1L290N1NDUlVKWEo2eFVXNXZp?=
 =?utf-8?B?cnRvSm14YUF6d1VEUDJRdXhwbW9hNVYvcVV1cEFuZ291RUJHT3lCTHZpbEFv?=
 =?utf-8?B?TS9IT2tHZmkxV0drbkxYdjMwZVpsVnBUcExFNlJhQWtWWmJhdTF4S2tiWlp4?=
 =?utf-8?B?akUraCtwTWd6M3RXemt0b3JqWFJVRlFma1NUNUpDVFV4RWRlTStrdGRFbUtZ?=
 =?utf-8?B?UmZVOEZOVXFYYXM4eFF1emZBK2t4dlJlQXhxRlJoZURmMkVON0lnbC9tbzVU?=
 =?utf-8?B?YjZ2TDZIRDJ0LzNtbWJ2U2NncUxRNUZudkdOL1RiOElHT1N6ejlZQnlmejRZ?=
 =?utf-8?B?UW0xdVFkT1pZeWtwaVpQRm1EMUVUTXJDeHg3ODF1ZGVFVzdWT3BvcFAyOTJF?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c5e235-853b-4e0e-6e82-08dd7dab228b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:26:53.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1IR/00oVruehL5hk+B+7oyBvNfeCYPayWYZizWsqWs8gedbVUCqz0B3mEm6/rRbs5L/lw78OcKbDa8bW+JNSTqyhP8vgJbrrUIp6by4l4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6559

Hi Denis,

On 4/15/25 19:04, Denis Kenzior wrote:
> Hi Jussi,
> 
>  >
>> Denis: The testing of WireGuard changes was done with these changes as 
>> well, should I resend these patches? I'll try to find time today/ 
>> tomorrow to check if they still apply, and if not, I'll send v2.
> 
> If you've added/changed anything since the original submission, then go 
> ahead and resend.
> 

I just re-checked these, they did not have any changes from our side and 
they seemed to apply on top of latest master. So this set is good to go 
for review.


Cheers,
  Jussi

