Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020078.outbound.protection.outlook.com [52.101.69.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB41CAB3
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656868; cv=fail; b=K81RgwNOEWaaqXaei7wFw7KPXssOng4d58rnUwy06Ao4VNjJ7EPpfdzLFZbMlpUfppWAIaVrmjzIuYwVDQlUUmJD+VP5b9NY1By2tp0n0V/1ulzLnlADBa+vv/Ti86SxmlAXaDh7x7DT0tpBz+XVZQ7AIKXK2g+LURIC4JoYy3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656868; c=relaxed/simple;
	bh=tI2e4g6lizu44tnDm6fMEBNtov6wd53P3wcL3e4+tLA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AnQepvK7ub3vy12af1DNAOHq8swS+4/84t+mA5amg/6DdqVkO5vM4eSSP4aPepvYgNkKX1ERj97ho9XgxRJXXA8x+LInkwAkvZkkhBjf6FCV1FbNub5/0CmyVmvtx3zwxEtx9H4DdstZf2OAY/GCQU44xXzy6MSTqiBVBJ1zejI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=dfqNFwii; arc=fail smtp.client-ip=52.101.69.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="dfqNFwii"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH9CVxSELB83yUw1QKUydJDXlzHUwwoi+0STCZT1yvEmFDVlNkzTLLEVX0LlrDdQqD57Bp/cENv5ummmKgjOQxHXG9kaYrUgDriziQX8CiLqZlUon3IymtOId1YN8E3q6TRTPWaDf8eKS1Tofs3xv4LkjNsvz8KxV1ILY2LopmeLr1bxcALfokCziIEUqJqgDls+AXJS438HOWMujAAswDfCkDzBoRa4/3NHlMPcm0rU5jAkDGIekomSJo2sbOhSwtQFrG/M0FNTsLFfSll9qXRBwM2PfLybyCUfEDBtdp1C6DzTaHqPmTfv5ykg8Pz4idjRtCTVzszt7qftsRvaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2TlXhJG2uvP60bC5HKFJxuSB13LvmTuGEslf1o3O+0=;
 b=paKjHwrW8PcsxpDXmenubb/WIAsp17BdNTjrO9UJ+HFvoUL+UzY0ZGiXGUEuIK3aZbZeYF4TNZZ5tgjjYVqj6CGZS3P0LIWpDuFcLKL2vUFpjYA7M4hPj5nlux2jAf8D1DQEMnPiSGqNWnYSI6XUBxynUVAKuS2KOdmtE3FBKbC3m045iiX76QbXYqifFXmQSHPXIbbDdk/wtHNMOkT5xarqcw4iBs+876an1BDPdRm6TcEZm37aHk5XUdaztaDZmXIxO/jBewCMU0UQfu/GNPanx2TpYv+0FUNOgigRXYsxzmXuPN/7SwN0Dur6drc9P2TTc5u1XK+LLlxe6GhPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2TlXhJG2uvP60bC5HKFJxuSB13LvmTuGEslf1o3O+0=;
 b=dfqNFwiiZ2nOKLa9tj9YZq1Fc5ZGppolrTX5I8xVCrFAO7+arR4zL+OqTBpCjdvnsFtJGAptWeO73vFmoGg6nvaQv6gTH/o7jwWfKTSP8Zly/Gu/cyz+yKWIrQWNqh9URzdSMZNvA0AAn1veaKbQm/unB1ndTQ3KGCCjrjpvESR7HGysM3FAbi8VyyoZqL14Omz5N8YC22aQwISRFay9gU0FV12QM2aaayPyj5ByXiL9/Ir+SP61xOc9wAOuZbIr43OfkyfhXDJIxA2HJLzDfbZTTYaSl85w5nAyRFDCew4EP51s4R6A+6/e/OeNtbJfxE1xOVNp/4n+vZ8RcuAsoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by GV1PR06MB9139.eurprd06.prod.outlook.com (2603:10a6:150:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 12:40:58 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 12:40:58 +0000
Message-ID: <c577665d-b1ba-4568-9dea-c709313b548a@jolla.com>
Date: Fri, 8 Aug 2025 15:40:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/45] inet: Expose __connman_inet_is_any_addr() for
 plugins to use
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-29-jussi.laakkonen@jolla.com>
 <a32467d4-d902-4cd4-b5ad-3ec3c4b3cec7@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <a32467d4-d902-4cd4-b5ad-3ec3c4b3cec7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0002.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::27) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|GV1PR06MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: f429d4a3-6ebd-4406-594c-08ddd678d330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekJWVGJjODRuN0Z5cVlBTEd3b2NFK2RhMmovN1dsV3pGNE1aL05XQ25FTjdH?=
 =?utf-8?B?ano4S3RDUFYyU20yOXQ4VnU0S08zUW15UktZeGk1Vm13V01yUFAxdGNsSTYy?=
 =?utf-8?B?VzlSOExqWXVCbktSWWc4ZW9za3k5bmJyeTNjUk1HTUU2dWV2K3BGVDA2R05a?=
 =?utf-8?B?bHRkTDNBZXBiR1ZEYnEvakI3dEZHM1FlVzgrcFk3cVdieEZiaUFXcmk5bWlS?=
 =?utf-8?B?ZzdhUUU4QjdaK2dxK1l6K09zeER4REc5WGFPZkthWTZVVDhqaE5XQkFjN2Ro?=
 =?utf-8?B?QlpIZTJ0ZmlXbm50Q2l1TlJ4UXlZQWNwcDExMmVQZjFVVS9NUEptd0kxK211?=
 =?utf-8?B?enNnWUxJdWVMVHkzOXlrR1FCM0dGYU5YT0llRjNndVk2a3FldlgzTEM3Rzdw?=
 =?utf-8?B?SG1ra3dTNHc3VGdRcGNDQllSYmJodzl2RWhDMG5LZVhya3A5YzBpUk5oR0xW?=
 =?utf-8?B?KzZrWUtBM3hYNFlKTGtFdmgxZXFpVFdTN20vREhKUjBBSVBtWlNIcGozSllS?=
 =?utf-8?B?TFNrd1VicWZZNFNNZjN3UUxnVldTWW9uZkx4LzNtTENFWjNzZ3ZEYnl2dUlw?=
 =?utf-8?B?S21DRUtLbjhtVnZPRHN2NzgzYW96MlNiU3FlZVFtWXgzMXp4ZjhaRWdXeTdF?=
 =?utf-8?B?Q25QTEN6TmdCR1NQbFM5NkJCa3dsSVdKN0MwTURHSUozaXYxK3hidjE4cnNY?=
 =?utf-8?B?R3BUdzJnWWN4L1NJZFliVythRVdUU3BvczZESDdBRGtyVy9KYnZRelBmdjha?=
 =?utf-8?B?VEJHeTVMTU51aCtBb0grNkRlc0tlbEoyVG5oMHlEQm9HYUpzWVFXMFRkb1ln?=
 =?utf-8?B?Mi9sM0dVUlVFSWtybm1GUjlTSm4wdit3QStub1djbStORjBxZmpBM3dINTVr?=
 =?utf-8?B?Y0V0SEI0VnJSSS83VXVtVWpWTnNUblVjc0dqSnYyMFhMb1JaYmg1T05hak9S?=
 =?utf-8?B?ZXJ6ZjNuOW4zekZHT1FqNVZIMlB2UXRaZm5IdEd1RndYMXZlbUJyUnhNU2Vk?=
 =?utf-8?B?OTdyZ20yR3FJdHBLSG9BY1RJTjJwRXNpN3hJWCtkOWxyL0t6WVNQSWJodFpC?=
 =?utf-8?B?cHVUbzJIWCt4ODdyQWlTbHVNMFRMbEkvVDlMTWorbHFZZlNvL1pKTlllb1Z2?=
 =?utf-8?B?MFNGVkh5QnBTcjViVWNsUGp1MDBtcjViT2VhcG9vRTl0Q0N5UFRmSk9oNzBO?=
 =?utf-8?B?ZHBpeHNSQWZoSlFGTGNZaTUvSERpYzA5Ym9qRkQyT1BMaHFtQjR5OHFjbllz?=
 =?utf-8?B?VU5SbGFNd0ZMMDNGVk43emZYcTZmd3VnS2lQd2VRd0FXWWxsVE03VWZPUzd0?=
 =?utf-8?B?Y3pyMlI0WFRCaGRtb3VNaVN6ZWcreWhtamw5bXl4bWJzNndwdnluWVNBS1J2?=
 =?utf-8?B?V1IvbUlGODA0TWFEQnBqaW9zZm1XY0Y2ZkxSMTYyV1hBTHlvcWpURTlGekYx?=
 =?utf-8?B?eE15ek9OVnFyWE8vc051ZkVFODV2UGhkaWNnclRtdzFYUWxKaGlDWTQwazlB?=
 =?utf-8?B?dE5BdkI4Tis2a1JEdUZoV05lWXFuWWVWWWJxTWJ5MXdpbzFZQ0ZLeTE0M25N?=
 =?utf-8?B?cDh6TWJ5Z0w0TFM1ckY1UktGRWs5YVh1MUxLdjYydVVlT244dytEaGRIZmhP?=
 =?utf-8?B?bCt3alpFMHNCeXVITGx6bXhJN1pLajUzM21zZ3lrcWZPeVVoMXM0SEVadjZl?=
 =?utf-8?B?MTQ4bS85RVJXMjZaTmJnNUNOM01VMVJPSlZkUGNiTTBBNHNuZUtVMmliWFhE?=
 =?utf-8?B?UnFKdXFnN01lQ0ovbkNoNWZxTnFVbDdTemZhWTZHOEtNbFNWYUUzZXIxWTht?=
 =?utf-8?B?dGZSbUVBelV1RE9Qa1JJT2xnMko0WmQzcUMyTndxeER0YW8vQXhjbWJDc3h5?=
 =?utf-8?B?dnNIQWIxZnZGR241aHRVYlFBc2hDajJReE1nQ3pJUWJWTWJIMjBwbUlzeFNv?=
 =?utf-8?Q?mkTNfeCwrgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzBVT0dsN2JVTzM2d2lVRjA1ZHkzaGc0TDBVUlppLzYrWE1Mb0FwVkpueXMv?=
 =?utf-8?B?dTgzcWJ6ZnlJL1VOK0NXQTQ1VkhMSFFxVXNlSzhvZTkwbHp6SjdmajVYa1VV?=
 =?utf-8?B?Y1ZwVjh0V20xanpHb09ia0cyc2d0TlgzWm90NjJscE1POXg2T2NGTUtWZzhh?=
 =?utf-8?B?Z1RGYWhIcHNOcVltaEYwTkxRdUlRSlRrYnpRdkc2ekdpcUJpNGdmUk55UUZs?=
 =?utf-8?B?Y1p6cEtkTERNODNGWHlPaE9seFdaVjEzYUhYMVdmaHNReWs3MTZ3NHlCbU5E?=
 =?utf-8?B?ckg5U1VPVEowN2RaVTd1c1E2dk5rSE5leVlCNHhWWWYvTGFUUGFPM0VBSUwy?=
 =?utf-8?B?QzdwK3JqQUZYL1JFUnQyeXc1WE9BVGpycmZSUG9NbmRYcVlFcDNneVBwU0Js?=
 =?utf-8?B?RndXK2dTYmJTN2Z3WDh2MjR0eGFtMGhGdDdGQ2daaFhveHBXMW1TUG44cytF?=
 =?utf-8?B?NHhiQXZKcHVlcWhPY1dqeHBnL2k1eHNwNFVVTXlPQzB0dWxpS1hheWpnNmpu?=
 =?utf-8?B?UEFUQzJzQVl1WGptYUZBTGQzQ1d0MHNGcysxTHhvWmJ6bG9NT3ZQWDdUdlNp?=
 =?utf-8?B?cXh0RHJNRmQ4aUJhbUNXakV2c1dMdzI3WTNqSlNEWFo1QlJHQ2lSUTMrc2RC?=
 =?utf-8?B?RFNXLzdpVmlHQ0ZyRjU0YVZLYm55RzlGZ3JBQ3VSdEZhdFUxVkdJdXdOS2Zz?=
 =?utf-8?B?RVFjRDhyRnlaNjcxbnVmMEQveHdBRHo0UE5Ba3dYVkJUU0REdFJ1bFpCcEhR?=
 =?utf-8?B?dlNyOCtzQUo1U2dnc0NFZFdSTXVRZVRDRHBXMytMeUpBVXQ1ekd6eFNTaTFS?=
 =?utf-8?B?c2I5R1hpN21JeS9Fb1lvUzBpcnpUbUVpMGlXNkdJWlJzUlZoMjJNcmdIbEph?=
 =?utf-8?B?b01vanFIeG03QmNacGVVTEJYdG1kSHRIT1ZSc0Y0QkpTNHlvd2h0alVoeTlP?=
 =?utf-8?B?Q2tMUzA4RTdRZFdEckVhbU4vZUhUKzM2NG1sNjJreGdRVjU4SGdjejB0S0wr?=
 =?utf-8?B?TUVPSDRYNUR6d2d0eHZSZVBSSmlOcmdONUZNTktDaWJJTHNsamk3cnJvM1p6?=
 =?utf-8?B?UFc3ckJNWkFHT1FYaCtvTUxJUWcwbDZrOTZncXZ5LzcvZWh6dTFSTnd2K215?=
 =?utf-8?B?Nkd1K0pJWWVoWmdWOGp6MUlJWFJIUFYyQ3lNMVc5VzV2bUtraThjZlNlWHRx?=
 =?utf-8?B?alMyeUtwMFJpTU5zeHlLZy9JQ3dvUWxtZ3p6VEhLT1lxUFE4Uzc0c1FHM2hJ?=
 =?utf-8?B?YjA2QlgvL3prNS8wYmdIV0tzZXlGN1JYQXZyMklKbHkrVmRlOGpOMEFJcGZL?=
 =?utf-8?B?S1Q2enRVOVBZU1RzV1F3bHRpVmIyZXNaNFlxMjBZak1yRFhkanFFRFJWU3VI?=
 =?utf-8?B?bTJGcGZ0TXNsUzNFdHlBVWx2dmNNbURJc0VkVitHSjh2TzJIc0JucFZXeDNj?=
 =?utf-8?B?NGtVYTdIejBmb2p4SUZYdDltRWNpMy84U0pqV24rcStnZGtvTDNNQ0p3emps?=
 =?utf-8?B?OGp0ZmptN2YycE1nTE1QbkJ4Unl5ZzZURU52S00vNUl2REVubmVNUnJVQTBm?=
 =?utf-8?B?dmhXRHdnQ3VJUFNZUnRKV0F6TS9DbG1QZlNqZlI4R1dKdloyaXNva0F0MUJQ?=
 =?utf-8?B?UWMwQzVTMnZORi9jLzRVWWtrbTF6bTUrWFNtejZWNzU5UDNXa05GV0w2OERj?=
 =?utf-8?B?K2hpY1BuMHhxWTArK3BzZjZ0QzQzalpUNFdwclBkZ0ZRbmN2b0FKZ20ydW1I?=
 =?utf-8?B?U3BIL25DSFdYcUFaUlpPKzJQTzZDd1N2MzZFdVorSHpnRThyQ3pkdVBsTW1u?=
 =?utf-8?B?RFo5Zmc2V0xiNHFLalpCS08rMGNVTDBRL0ViT0NhNHpGVTZaSnZCZ0RnK1Fa?=
 =?utf-8?B?UXp4SW9MR1VSbHlNZ1JZT2hSck1STDlLWUUwWndqTm5qaWk0SDQxM1hrZ2tq?=
 =?utf-8?B?ejhOdmRWU0gzck5Pbnk1b0dIWG5Id0Z5c0V4cktsZ0RUTEFneHJiYjJhWjVa?=
 =?utf-8?B?Rm82aVNuNTk0eGZ6RHlRLytOSjhUb24xUlNGRi84M3FXR01raXpIQVZ4MHQy?=
 =?utf-8?B?N1lyZ21Gd2hxWFVUQWpQdXdjYnd6YVNyZ1JnTkxiQnVoenBZaWRVK1RYVllX?=
 =?utf-8?B?NStTYjZKYXpLbEN0N2t3ZSsrazVUYzJDRWtsOEt6Tk9yT21hV1hlL1ZKWXR5?=
 =?utf-8?B?bDZNd3pCMVc5ZHZIS2gyRFRWUlRTdnFjTzRpVWhjR2RSY0ljUi9aaXZ1YldX?=
 =?utf-8?B?Z1FPQ3c2SjVLUmkvNFkrVTNRSjRnPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f429d4a3-6ebd-4406-594c-08ddd678d330
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:40:58.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcZb3mcFNmFYp3+hRwE4ewIyZfMsTDCiuSVdxy9Md998tNSWMwjObYMIsyNfm/Yx3iiTPKok/Bkyv+Ds3k0ZYwMsyD8K/N7vexBJ8Cs0KD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9139

Hi Denis,

On 8/4/25 17:57, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
>> ---
>>   include/inet.h | 1 +
>>   src/inet.c     | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
> 
> <snip>
> 
>> +bool connman_inet_is_any_addr(const char *address, int family)
>> +{
>> +    return __connman_inet_is_any_addr(address, family);
> 
> Might as well just rename __connman_inet_is_any_addr and fixup any users 
> to use __connman_inet_is_any_addr() directly.

It is always an option, yes. Maybe a bit of 
less-changes-and-backwards-compatibility has been in my mind always when 
doing these.

But if you prefer that way it is no biggie, I can make a V2.

> 
>> +}
>> +
>>   struct in6_ifreq {
>>       struct in6_addr ifr6_addr;
>>       __u32 ifr6_prefixlen;
> 
> Regards,
> -Denis

BR,
  Jussi
