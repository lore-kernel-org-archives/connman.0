Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2135.outbound.protection.outlook.com [40.107.247.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99585194094
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896719; cv=fail; b=VeeKPOIBHp6WuyOqGAUFX/X3SKuEUjvvJfaGurMNKApnDQjswHjziIwLQwISr85I48hb3G4S+c3JUJPipWhS1xGjx1+YupzrlMbgc06d0d/29ODOUjDrQ54qkkK+pWzSdj/qDRuWlj2uGPgchOvrW21OhukTug6M38/7diqKEDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896719; c=relaxed/simple;
	bh=7C6mtU3tzab+xhUxHy5niIthsAsSXfp1Jgoe+1dXauA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xyx7izN92DclkICxJ53CqaL1nz/kxns2dUzlKR+cOvOkPrWOp6FQN8WFJ4pSYpbTFHJDpYrKv9AlMl7hSetuHbtZp82DeMEqeGLWoRGhDlaKtgRv8qisF/35LpqvDWh1e3WgTexQF321HOpGX0I7kfYj7ocYhHq7YaQrVBdMpUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=uowErF3b; arc=fail smtp.client-ip=40.107.247.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="uowErF3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpWwMlFNclistJ/9m9fb76TjEdP6i3b5mBFlgn0cn62HkaU7/EvAATYaE0wcrOHr4cHKusgnT/SNhtKlLyOttrSYnmNawzNJLi8iCyd6SiIUEJyZo9dgpV/lYsA9jexDl6oTBpm67eMpVZLt6k+Y1tJK+8hoXRER1+nwbAHb7+kx2yORSp12mFZ9n1qlSyJrP2TY9+h5xCqC0GheLQmEhbtcPjjilhygxAy4WNLa6o5F4GzG54TAAVYcWGrzARfeFCGGx7+tIA2D7SIDkxhWqpYZ6Oro8TDG8vNovhoPjGZy6109CDgTRDgVz8+B1bJEi9o5DrU7wgB967OAs8yALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDQS4nxND82FD9u6H3+/F7CW1N1XjGUesw9W/z/SG6Y=;
 b=p0NAAptX8UI1XBmijALRTvx3qxEuUEaN7J84IC1LtvwZBEFFaj/raPcTKovBIUbBMxDh2Lhr5R4cdq6VykSUQ+jJISoV/fOjJWdEuTRKG61AR/m3s468Sfb7tKpznnngj8FfHGfP+pXSpOqkJ/ChttE6ggKM3QEvq62iAqsMopyK6jk9IUtYU3MFExLx5eg2OMykxZ+AWIVoTesx1bSOJx+zkxpyosUaexJ16v9OmbRpdSdEvKqri1+NfQ88J99xH8pgKptvnxIUFG3Wv3R4d2afzY3O0FmXnu0bBZTkgV2YVl+oEgn6+bRoSx4dxslr0FbtfPcUscVPcCs8yjKjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDQS4nxND82FD9u6H3+/F7CW1N1XjGUesw9W/z/SG6Y=;
 b=uowErF3brM89IANU5NWUbRrhXeMNh4PS7/u47e3diUtIwOkh4W98lBRrILSpP8kBuBy+u9B6oPh61pM9InhPad6GP/csIEgc9tjjP5OYIsXhwMzgrYfNSiVegOFqqeQiI4dB2lYYI1v0A9WsllNKI4pB9GkUTMZDFePiqCVuh5yzHGCCrv+diPxLEKY8adTir6ZOiQu1cTnlMFmNGCdkxuZyXAlcgnfyHnvPO4y4qJO8ggbn30CaZ7pukojWUKu/UDtxUUR6/wJ2kQdveUywCbik9lq4J8hXCA5UqQh5hNiiT09v4gk6c3rdY9H5rH5UL/TVzzlB5x9Qf3hRZP5mcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by VE1PR06MB6861.eurprd06.prod.outlook.com (2603:10a6:800:1a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:58:32 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:58:31 +0000
Message-ID: <07d1c218-be94-4b63-bb98-f57679844148@jolla.com>
Date: Tue, 25 Mar 2025 11:58:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Improve WireGuard disconnect, error and hostname
 lookup
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: connman@lists.linux.dev
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
 <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
 <3438fe24-9c02-4c45-aaaf-cfbe260902b1@jolla.com>
 <E23C544B-4E82-49A6-B72E-2279D1BAFC67@gmail.com>
 <c6ae8a9c-df3f-4170-951b-a8a049bf9676@jolla.com>
Content-Language: en-US
In-Reply-To: <c6ae8a9c-df3f-4170-951b-a8a049bf9676@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0000452C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::352) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|VE1PR06MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fdc1de-79e9-4218-581f-08dd6b839924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXhqenFiV3pwdTdDcVRnc0tmVE15WTBVSHlJaGlKc3VZb3lkWkV2N0EwUE1p?=
 =?utf-8?B?eXg2V0NvZWZPUGp1RG01bzM3OW9ra1JFK0M1U2puUWxFM0NpOFpVNXlJVi9F?=
 =?utf-8?B?K1pVMlBwS2lQM1J0T2V1YWY1aHBURXdyQXZaMEFvcWRUQVUwZzR3aHRiNWk1?=
 =?utf-8?B?ZGRwaXEvMTExdCtFWWlKWnRpY3dYUFE2WFpmdVFYV3duZnhvZmxzZ0lvRm1w?=
 =?utf-8?B?TkoycXRpVTlZMy81bk5oWkRUcjRxQXkzenJsSWUzZHZGU0pOOVp3b25RLzJv?=
 =?utf-8?B?cXJTcWxZUzNoSHkreWFlK2RIckt0ck5aRG45Z0FaaEpiTkRPZDBUaFdUL3cz?=
 =?utf-8?B?K2o2aVFEZC9NR0JQRnA3MlRvQ1RCRjZSbXl3U3ZPMzBKYzR1c0xFc1BvQjU1?=
 =?utf-8?B?UFBVYjVCSWlpLzJkYkNqbzlkMVBDN0F6T0YrNVRsSUU4cnR5RDZhS2lGOWFH?=
 =?utf-8?B?UHluSnRkUFljRTg2WDVXNXl1UWthQmt3ZGdmQUJYQVZNVlZtdDF0anZuZzIw?=
 =?utf-8?B?Yi96Z29LbUxMTll1UjlXd0V0Zi94djJsSXlFcUFwWmtLYTJFUEtQRW1nSXoz?=
 =?utf-8?B?Sk9TVFVRVWN1VzJReFpSMmV6Z3FqRGEwTkI0MWtUZ1NuU2lHZmtvTHB5aFJ0?=
 =?utf-8?B?blQwUWJLSjB0bzNhbXlONDE5TnFnTy9QWVVPTEhoWkZyak9ZbUY5Qk1BT0py?=
 =?utf-8?B?MFpML1ZrQk9DaFgyKzBkOEpzbW54Vy9HNmhsOEZITE4vQWdOVGRJME84dHg2?=
 =?utf-8?B?cHNYZ2UxdmJub2xZcCtleEU3TDhDRHhaN1lBRk5xNTNkZW5oRWdrcDNoUEQz?=
 =?utf-8?B?OUlLYitVS0NjMEZtQ2NUbnZCSDJnOFBNVmg0bWIyQXY4Nzk4Zm5xNUJUQTZR?=
 =?utf-8?B?eExoM01OeDNiRVV1Y25NRFFYcnpUdGZOTW1hdXFzQ1VOLzd4d0dyWEx2c2pJ?=
 =?utf-8?B?NmFqc3JmaVBzbHJLMVY3aldUQzRSRUlZUHMwT2NyZFUwZDd5YXN5Y0ZVR0pC?=
 =?utf-8?B?bEZEcVFmZGQwZkdSYVpuY1EySzRPZWVTMG54SnZXWXprMGtDdGI1VUlZZ1Vt?=
 =?utf-8?B?VFhMcDVucVR6empydXlqZktreGxxT0VuT3I5ZWJUUldlZ1RVMGtxbVVla3Q5?=
 =?utf-8?B?MkVIVjBtV0VZYjlWRXdobjB0bzFDR0IwZmp0akVPMlh4TDlKMjVBRjJ6VWE2?=
 =?utf-8?B?QWRpaWs2V2FOY2pUT3M1bTlFbU93STU4aHZ3bll0N2pjT0JFUTNSS0pRRzFT?=
 =?utf-8?B?bjVLb0Z1MEdrcjhqUi9CeDRKWHVYTkN1bmV5bGlMeC9XcWRyTW02bmJOSVc3?=
 =?utf-8?B?RG93a2EzMVZDZHJHZmVTVmpDbk1PUXBYK3psMTdCOXZuSkJKL00xWkpCb2xO?=
 =?utf-8?B?Yy81TXFTWnU1cTJLU3RDRVNPZnBsNlE5RTJIQUdaTC9SWXNhek5ZVHhTdVJj?=
 =?utf-8?B?Ujl1Q2o5aGNtdDY0UWFKU2dWQWcreG0wSGFZNFBlemVuanhGRzFocDNZVWtC?=
 =?utf-8?B?dmdiZlIvMWJEYTJtVDF1L2FOZEhJOHdFOUNSWmxaRmFVVmFhZ2djU0haNWM5?=
 =?utf-8?B?V2U1d1Z1OXcxWUN6amlCZjJrendnWVRiNmFGVjJBbDM4SWFGbndXc3ZKUHdC?=
 =?utf-8?B?cFI5SFNlM1dobWpjenh4Z1NjNXFCRk5rTmtEZ1BMUkp4TXA3VEc3dWlQeU5i?=
 =?utf-8?B?UHl5NUxDejN2YXhocFoxSWY1b0lSTmZLTnprNFN6SXJIekxrdkJSYVRYVEs3?=
 =?utf-8?B?V1haLzZnYnR4UlRGT2xXNCtzZitkMG0zQzhCWXdkb1k0clJVTklIQW0zb0hP?=
 =?utf-8?B?SlhXdzQ0eTc1QkdQeXNOdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2x1RCtueUtsay9JLzNSRnA2cGduTjRJQTVsdVBwUUZRbG5TWkVoZklZdmZl?=
 =?utf-8?B?YUhOMUdmbG1CbzVDUWpCeUs5V2hBYmJFY0NhUW16UkhrNmw5eUQ4QzdnQjNF?=
 =?utf-8?B?SUVXNXhnOUl5N0Q1amNralQ4NjJXS1ZwYW1PVWJ2UnhwRnBnSXkxVGRQL2ZM?=
 =?utf-8?B?UkpIVmJneDFYSndXVXQ5MkRlY0ZqRWJPeXh3UW9RL3JTMzY3dXhWelFDWDdR?=
 =?utf-8?B?OGpUbDB2OGhmUFNQMHNFeE5EbFpXckR1ZW8vU3JDakdXRitjQ3FvbmFLMEtD?=
 =?utf-8?B?Q2pIbGE4ODBKcXIzYUdMRkFNYzU3eThKTXI0ZGlNMkd6SWtKQVJJdGx1Q0ps?=
 =?utf-8?B?Zm03cGk1dHFLdXZDV3dqclNLSERNUHBHUVlCUms4TXFmUlloOUNLVUxkZ1R5?=
 =?utf-8?B?a0NkSGphN2E3TzZSaEY3RlpaUEQ2V09YMDJCUU9SV3A4bXhIQVVJRk1BSmVx?=
 =?utf-8?B?UFdBSGdNK2hwazlucHpZUE1rYXdrZWE2ZnNHU2k5bjh3OWVtNXJ0WWtlK0JC?=
 =?utf-8?B?YnhUVm9MMllkeC9ycWU0a3RTbDl2NXUwNVdIY3JOVlRDKzZCSytiZkI1b0Yr?=
 =?utf-8?B?YnU3V1g3aUI2T2duTmhMdWxNK2kwY1ppcVh6WUZ2YmlFWUVFY3BVK0NOME9S?=
 =?utf-8?B?bEQzM3VGejFpMHl5SCtWUW5ZeStVdndtblJyczFPWXNyTVRxYk9zYzgxYk1H?=
 =?utf-8?B?ekVPdGlMTVVUZXl6bkNhUURkZlowcS9oWTdNY2NGdkQ2YzVEUU5zUDY1RTls?=
 =?utf-8?B?WHpIdFA1ZGticTZGUkdadkttKzZhRDlDQ2ZBa1FQTTVmSlhYYlBET09GNitR?=
 =?utf-8?B?NTZyRTJpMjJwZnFWT01OL252SnkyZHFGM09pM041ajkrMTJZMVd2aUtHQ2Rm?=
 =?utf-8?B?WDBWcnNIUjJGVnFweGZoMk1MeFRiL1h3V2VadnU2VmRXYVg1UHVCYnpoN3py?=
 =?utf-8?B?cDBOZTJRdklXUDc3S2hlNXVyc1BGaVdHYVQ0SStEdkdJYzYzZHd1bGNabW85?=
 =?utf-8?B?OEo0eU50NXpaNVNwWHY2NkEwMjNjSFArNDRjWTJ0M3RJYTc0cFRUSDVneVlS?=
 =?utf-8?B?SlFTcEYwejcvQXN4aGI0MkU1YndCb2k4bmM0cnlicW94MENLNDM3Ry9veDJV?=
 =?utf-8?B?VGRjY2tmTXdTdXk3RnJieVdtcGQweUNtbUg3MHM1MkdyY0xVTkFTWUJDVlVx?=
 =?utf-8?B?UXlpeU1aaWFvWmlrdkxMcjdKV2JvbWdLaVZ6aTg4SWZnYWZuSUxYT05lU0pa?=
 =?utf-8?B?S1k5Z3ZjM2Raa0xFSVdjRFlRMVEwanRTa2o5anBIY3lpTEkwcHozaGt6RlJQ?=
 =?utf-8?B?NUJHQ0dKYkllcUt3Yjh5SEFubG1Ta1VpZW5pU1kxNk1zcFRGUHlBVGlYYXRo?=
 =?utf-8?B?ZHI3cnF1TTJTb1Q4eFdYb2MzeCttRG5HclU3U01sanZidHFPNTZGL2FXelg4?=
 =?utf-8?B?b01SYitHMXNwa0NITVlzZjluK3FsMHdUVGFJOEx1TU5KMzlZdW1hYUplbVRI?=
 =?utf-8?B?TmU2QzlBUTJJWDJHcDhmRG4wSWV0QkFxTGcxVEwxVHQ5UmhoSFptY1NaN0NX?=
 =?utf-8?B?SHFqZFVwZnI4bnlXdzJzdmZRS1lCZU1CSytHS1FkV2dDSEpxS2JraEt3STJ4?=
 =?utf-8?B?UHJ6Qm8wazZZYm9nZWc0R1owSEZmam5XKzFHMWFuREdUdmJ2TldrV05JQjRo?=
 =?utf-8?B?RDN5ZUdQcXlFa29FUzk5OEJPSHlOQTlHQVdGcUxBaHNSUklVNUcrZXg3SEFj?=
 =?utf-8?B?aVNJNFZqeXoxa1V4a1ZiU0NGQVdReEhsOFNlU0pqOE9kQmdBbzVRR3lRVklR?=
 =?utf-8?B?dHg2Vk15SjJsQ05uR1pKZ2tFWnVOQXdFL1B4S21zNHVWZWZZbi9TSFY1c1lk?=
 =?utf-8?B?cmI5dGNwMWRwbXZ1cTZEdmRhVGtucms5VWFQSlY0b3hCZWQ2RDgvcC8yMVJr?=
 =?utf-8?B?a1dZZHpLcnhrU0lZZ3pHV2V4NmwzcnNnRGxqVVpzTHMweVVSWERqYXZmVTdx?=
 =?utf-8?B?UXI0WjVOalU0aDZJR2JvcjVtUFZiamxzNzl1eU1JaFFLYThaSFl3d2JRRUx3?=
 =?utf-8?B?ZVZCNEZmblBEYlpOSU51T3lod1B3d0Z1L3VLaGJaYmhqeDNvT1F1L0h6M3d0?=
 =?utf-8?B?VlZVTXc2SFpuL2NLVWl6Wjg3QnF6Z1JXR09Sc21JTS9zNlJ5cURnVVhQVEhB?=
 =?utf-8?B?NUhzWTlLR0wyYjlsekY5dmhsbCtwNUZYNm9ENkJoKzI5YnlYbWdDeUVwMG1l?=
 =?utf-8?B?K1lxT3N2UVRlSXZpdms1YVBreEJ3PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fdc1de-79e9-4218-581f-08dd6b839924
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:58:31.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O6oUpo78yn7JOsIo6XmbfRfGBK7PHLMlEMTkH52r0gmj7O6ZJytSZfmns4NoltWybKaeQD0OdgsrUn5Pk3G2Lbfr06v/DXXqbdZzAP/AEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6861

Hi Christian and all,

On 3/24/25 21:30, Jussi Laakkonen wrote:
> Hi Christian,
> 
> On 3/22/25 06:45, Christian Hewitt wrote:
>>> On 21 Mar 2025, at 11:31 pm, Jussi Laakkonen 
>>> <jussi.laakkonen@jolla.com> wrote:
>>>
>>> Hi Christian and all,
>>>
>>>> I’ve been using this series combined with the following series and 
>>>> patch for several weeks:
>>>> https://patchwork.kernel.org/project/connman/ 
>>>> cover/20250124185845.1546384-1-jussi.laakkonen@jolla.com/
>>>> https://patchwork.kernel.org/project/connman/patch/ 
>>>> DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/
>>>> Plus a revert of this commit which I’ve previously flagged as 
>>>> breaking the default “route all traffic down tunnel” with WireGuard 
>>>> (the main use-case for LibreELEC users):
>>>> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/? 
>>>> id=9eb1772d31b6fcf78e8711976696491aec9ff5df
>>>> For easier testing all patches are in this branch: https:// 
>>>> github.com/chewitt/connman/commits/wireguard
>>>> No issues observed, so:
>>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>
>>> I'm happy to hear. I have been fixing other issues related to WG in 
>>> the past weeks a lot and considering to push all of the changes into 
>>> one big WG patch set, as this has been left dangling.
>>>
>>> I haven't fully tested this on top of upstream ConnMan, but if you or 
>>> someone else is interested to see if the issues that were previously 
>>> encountering are fixed or not.
>>>
>>> All changes are available here, on top of latest upstream ConnMan: 
>>> https://github.com/LaakkonenJussi/connman_upstream/pull/9
>>>
>>> It is a PR to the internal repository so anyone can comment there 
>>> too. Decided to put this into public as Mullvad seems to give only IP 
>>> addresses and cannot really rely on demo.wireguard.com alone on this. 
>>> So, feel free to test, if it works I'll setup a patch set, maybe 
>>> combine some of the changes to make fewer patches.
>>>
>>> Have a nice weekend you all!
>>
>> Thanks for sharing Jussi. Minor compile error fixed with:
>>
>> diff --git a/src/shared/util.h b/src/shared/util.h
>> index 44e07b84..9af0303d 100644
>> --- a/src/shared/util.h
>> +++ b/src/shared/util.h
>> @@ -25,7 +25,7 @@
>>     #include <glib.h>
>>   #include <stdbool.h>
>> -#include <inet.h>
>> +#include <connman/inet.h>
>>     #define AF_INET_POS 0
>>   #define AF_INET6_POS 1
> 
> 
> Oops, thanks for spotting this. I wonder how my build on Debian did not 
> warn about this. I think only <arpa/inet.h> is needed at this point, but 
> that works too. Added a commit to that branch.
> 
>>
>> An existing WireGuard configuration on the family daily-driver RPi5 
>> running LibreELEC shows no obvious regressions with a private VPN 
>> server (not a commercial service). Lots more testing required :)
>>
>> Christian
>>
> 
> Glad to hear this. I keep wondering if something is still needed from 
> our fork... as at least with Mullvad WG I got dual IP support working, 
> and data gets routed from both IP families to the host with an IP. But 
> this is a quite a big change, so yes, lost more testing is required and 
> thanks for helping with this.
> 
> Few things I want to point out, that now sure yet if it is correct way 
> to do this but the transport services' DNS servers are sent to vpnd from 
> connmand when a VPN reaches ready state. It could be earlier, at 
> configuration state too, any opinnions? This is because then the 
> reresolving of the FQDN hostname seems to start working well.
> 
> But, as I now did some more digging I noticed that the FQDN was also 
> propagated "as is" to connmand resulting it ending up in the routing 
> table, which may be cause for this not working in the first place. And 
> I'm talking about DNS reresolve broken in such case as well as the 
> traffic getting blocked. I pushed a WIP change to the PR/branch which I 
> need to continue tomorrow (as we want this to be working in Sailfish OS 
> too) so this can be tested that how it works. The TODO part is about 
> making DNS reresolve to work in the similar way too.
> 
> Have fun testing!
> 
> Cheers,
>   Jussi
> 


Forgot to push the commits there late at night, now they're available 
and will update today as well.

- Jussi
