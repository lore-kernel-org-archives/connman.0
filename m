Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE423E337
	for <connman@lists.linux.dev>; Mon,  7 Apr 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026296; cv=fail; b=LqcQp+LfBnagNXVIH5u9XtVz6zYbHif608VPgL5/Y9S4Zfza/uJRZVtY2QZfJzfUKM6h1spipDb8EyCGqGuxR6va7dVTxLRq3Txkxjor1pdo8gXqWafL+zadYM/VdNVbQPy+Tl/qebGQWucPM/Tuissd7O3rjFrOu3ZLecBS9Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026296; c=relaxed/simple;
	bh=HLJ+3f55ER+2im9C54ng6DIY5Rx1SeSN7jefsNml8a0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TPZaCt9C1hoTR4NpHDN3WY+/IxvdKMBCQQDwsNhFEsabVJxIEhK23Q4jx1CQW7ziT6wk0JEUKg48YoS651r1GjQcyEzILwG1PCnc6wdX9I0ZHkXZ/4cAo1e9xI59BMzbUa9DYvpma3dJ4MB4fBFgqjOr6428885APYJinJyCjEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=tut41Xh5; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="tut41Xh5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHZwZYmsQiFr9gzoNa6psjqFOTWAxIlGs0XWTGN1mw/7FRrivWeAsVInNg4TNdfjwhq3e+oSUFj61NDbJaIY/CyCPta4VeRB/7AOi/aNRw4VJmEBYBV/4SdN3WOmRakSp0m3SrpNuuq4GnnRW6DnQzIcIzuW8h34W1ln+/tW7aKUFuDEiKOxgc4+XVJSEaZz3DJteCv8sGiEU58oSEqiqa9mQTNuumOTrttAlVgNEwm5GkbFzeXECPOlEU3UikiXNe1Muht1+dOd8fB7xI+LHsfa/UmSf38GEMg5W5jyCew/u6IVkJsnnDb5BGZ8vbDwgT4Sz/Rjkf4/UBX0Tq2vOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhO3F/2CUZrcqM1BCnl82FFDdGAuYvN/VMrgovfzRow=;
 b=tompw6XWJgBrk7fDvE695Pwlt5S5I4DRxjW0tIa9/KOIZ2u+0kRlwPChHJZ6IuhTRbpRzYz1AmfjU2dNbt50pIhZLnjvY1HDpaDGi6udLHZoK3wyCpkZZ+H+QsCIxDELbfcBR+KNxEmp6eIM/KcBq/XpeBE1z8C3fOqojCk1XqzuFTMM5zG6SD0Nngd/VuBcMYod+Ob2cm4ZriicNDCfOejOb+18O1kUgKcit+/CMuzkYo6CMnd4f507eQLdvAq4TWWU5JKKnCHXSAuXKkxnj1bwWbxfkWccMtRMIvxoPkPFviS5hO5JA18TrlzqxEyU+t8+ivNo/flXl1xI2RONBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhO3F/2CUZrcqM1BCnl82FFDdGAuYvN/VMrgovfzRow=;
 b=tut41Xh5jJZv2diDspdjzXkB0kMCVM8BhE/3fb6hcK7DxKsOjFV17ylysYdGqm2nO/RLajBC0eCVRFqqIzMYsZE4GffOKBlSlKwNrMphtGmcFsVLwaRxYBf09bQ4NL6cqqf4w06oedyxrJys6B3SxmY+SD67WLMgjYrkliPQXUTlrzpHgXK3rqGM5cBUZOPCBC6ax4v2MjDTvh2XxRmiJsvdd/FXBPWz+K1kQCrcZT0oktWfMQLt/x1Hlvgj4zi94PgdlqB5BGPZl0F7mHkbmUBSbx615q8VHURiYNMqjg5dXVfM7ElkdA8EBYe2dRKFz6IIN0U61vYdtVa9uW2yJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by GVXPR06MB8705.eurprd06.prod.outlook.com (2603:10a6:150:112::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 11:44:49 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:44:49 +0000
Message-ID: <399bf330-de29-40e7-a231-53fc19cfa6e3@jolla.com>
Date: Mon, 7 Apr 2025 14:44:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbus: fix double free
To: Colin Wee <cwee@tesla.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <20250405020929.754988-1-cwee@tesla.com>
 <20250405020929.754988-2-cwee@tesla.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <20250405020929.754988-2-cwee@tesla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::10) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|GVXPR06MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: da386bf9-abef-4dbe-68fd-08dd75c999c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFkrTTBLcy9GOWhrRTVTZzlLa1lKalZISWJIN296L0pNSVlKV3RIZU02U1F1?=
 =?utf-8?B?MEx0dnY2VnE1Wk9BWldoQ0FaMThrM1NhSmQrbzZDUGt4M1lLTG94ZVFYL0pz?=
 =?utf-8?B?eXVUUVFKUGUzQVR3ZTZ1QWs3blQzT09PYzQxZXY3cHROTVlhQ1NjTFdya1VF?=
 =?utf-8?B?MzYzem1pUEp0M25CdmpOQjlPQy9iRGxqUFp0STZUcVoyM2o2Q1ROaU9jdkY5?=
 =?utf-8?B?aGZNb2VNSG45UGV1MWlPSW1YdmJqRG9HN0xnSUxtTXBBQXAxR2MvaERpOXpi?=
 =?utf-8?B?ZlN4SEFDSlhTV29idzFZcUJGWXNFOUJJOWtxS3VLWldTdjdaeVUrUXJDKzhE?=
 =?utf-8?B?NzhldE1OdWZyaG1ielp3N2p4aUVzU3JjQVVRTml1VkU2VnJ2RnNlKytGeWpv?=
 =?utf-8?B?MGQra0wwNHkxaW9rcWNBTTVEUWZpejdXNU9tc05rMGYwWnNyMTUrNXVUM09r?=
 =?utf-8?B?WkdteGorMC9iU3orLzdWOHQ1SlRDYjN4WjNlKzZRcGZjTDJzcXpORDRXaHMy?=
 =?utf-8?B?WGw1eCtqVXFqOU9GbUs5ZEF6VlBpVWNlbnZwK0hLR3VINXRXYmFkelVFWXVR?=
 =?utf-8?B?NENxNTVXQ0M4WHoySVlzeTFKTE1WY0V4L1R2OGtJY1dXUzBFa29OR25LYnc5?=
 =?utf-8?B?YUJHTkFraUZUenk3bXM0elh5ZkxSTDl6aXMyWkNUdDZObDFLUFU1MnZzbU1s?=
 =?utf-8?B?aE1hRGx0THZ2MHQ3dlpLWVpyU1ZsTEVxdFdtc0pyNk9uVkpwT1BDdzN5UDdi?=
 =?utf-8?B?b0k4c09xcWNoVmpNTVdNa2xtR0RCQ283cW85empjRjJWekk4MlBNM2gzMTQr?=
 =?utf-8?B?VDBDQ0wwTFR1cTdFWk9OMFk1QStnRFFMT0tPcGYzSVl2T0dvNGJXZ2VzVEtj?=
 =?utf-8?B?UUxjMEhQRUYwVTRpYmlidWFseDlacmczUVhTcUwwQlorcTVjY0dEYkVCLzZs?=
 =?utf-8?B?b09kNGJMZzNhb3NBTUlIZVRyajNZTHF6d2pGdEs3NjgzaGliYUZCcXNlZkZZ?=
 =?utf-8?B?WGcyOFZKSGJtcDIzdGI0WlZXeU5EWUVQREdCdjZ6RGJQT1ZMZGFLb2FWUlZ1?=
 =?utf-8?B?UytxNHpPSllEWlBiSHdHWmlFTDE1bUs3eEtYdUNzZmI3RnhNYWp5WUczWmcv?=
 =?utf-8?B?d2FKanl1WTBTMHhvSGNnVk5rQk1wYnVoZ09pNlpUSVdOOXJHYlJCT3RuS0ZD?=
 =?utf-8?B?TWhpNHhVNnN2aUNGeGxzVW9zZ04wcksza0hrbGIzZzFPWlE2RmZqcmhDZGp2?=
 =?utf-8?B?NU9taE1CRDl4cXNHdXVPb3A4VG5YRFJqWTh6Syt6VTNIeHhTT1Q2VkJ3L24v?=
 =?utf-8?B?ZklDb05WR1pwZGwzU1d2V3FaaDYvYkNscFJZNmhOQzZrL2tvdUg1K3NDeDBD?=
 =?utf-8?B?aFRCWjd6TjdLRkVhd0ZqZG1sRzc4WWtUdW4wSnl5VGRhU24xeWRoaWdNUHdN?=
 =?utf-8?B?RnlvQldNNk94RE1HUUhQUThXTVdUZG52TUl3c2JjdUMzVnVqWld3YlJxblpx?=
 =?utf-8?B?cGtXU0QrRFY3RklCb1lmTGphdjJvcjFHYmZqU1BvRm5xdGtxUXZWcWMzNWE0?=
 =?utf-8?B?NkYyUFQ5NERhd1IzZUNkR3pWRUVjWmxiYy9zNFA5U3lxQlM4WHB2dVdvVm9y?=
 =?utf-8?B?cEFGb1IrYTVNNGtRVVpRME9YMTZZNXJteGl0ZWJXUXRXYUNpSUxGcktqVWFp?=
 =?utf-8?B?anZScjkxRWI1UmZ2UFJCUU1LTEgxUGs0OThmRXRTUlV2Y3dZT0xGUCs5dG80?=
 =?utf-8?B?b3dzcDh2czlIYzN0Z0ZINTlNQ0c5R2w5bGlSME80RVlsMXpYcjlXcnZJUG1i?=
 =?utf-8?Q?4SHSUsd1/PA8IwC+BlWgyxON/I1qA5ADI3l5g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3FUdzVmd0MwQjZ1eEk0UWUyTitqUExKeFRyMWdlMlR6bXYyTnBTVXptUDlV?=
 =?utf-8?B?bmlDZUNKUHk1UmEwYWorSVF6Ym02TzlYNFA4TVRpangxQTFHcTZKT29jd0ls?=
 =?utf-8?B?aTlCODdER1VTbE9xc3JtbnVLK21sZjVrTUdScEdwRlFocld5UHJmY1B1ZUhw?=
 =?utf-8?B?b1NsTFFkbmtkaElVdllneWRHdEEreDdzZjNTUlg5cVdpem05N0V5b1QrOW5x?=
 =?utf-8?B?dDlqRFlVTFMwS1AvNFVRZjZYS1dySjFiR05qVVlZODN4MDE2V2RFVmZqR0Z4?=
 =?utf-8?B?TnI4VEd2MkxXdmJ0V1VCaDlXU3hoYmw3NjhjTUhWWlRjdlBORno2SHMzLytX?=
 =?utf-8?B?K1RXMklSTHduVHR0Q0pqNmNVL3diZVZML2l4VlFPblAwTzYxMlRnMWpOR2s0?=
 =?utf-8?B?Vm5RM3VzU2diOGp6TjBSRVlKK3VnbjkvSmdQaUxyN0RlZ0YwSlYzY1N3bXhn?=
 =?utf-8?B?V2NYYUkwVHJ2VGxOVVVTTzJkL1dDeHRrRlFzaDFxbks2bGdIRWVSbDJ0Z3pJ?=
 =?utf-8?B?QXBzWmxDUjZxd284SWtkeC9mNUZpU0VVVEdibFYwb0VxMGh4OHdoUWdrVkdI?=
 =?utf-8?B?TXhrdDlScGhLZHd6VVlwZlViT0FwbFBrN1MyMlY4Z1JNMlpxTzBHZ05VcGVa?=
 =?utf-8?B?QzRNeWt3ckNJNFl2eUtjMFJkYTNya3hEOXpxOWdUZ2dYWlZ2dHhiUkVmWWZY?=
 =?utf-8?B?TXVoK1dGZWRDcG1BRzRrSjRwRXhYR2tLTThLL3R1NTZoZXEzRzV6QjBlQVNr?=
 =?utf-8?B?TzZ0c0RNMlZYU2RWYnc4a2JZdkNtMCtqSENpTU9RdVkwMng2YU5JVmo1V0d4?=
 =?utf-8?B?WHVUcFVhUEVTeFNyZERzMXJxdTl3cXRyVFNrZVBIUUVuWHJXK2dKU2V3NWp0?=
 =?utf-8?B?SW5VWlFnWVQvQzZjeFV2L3g0UjJyZUx3Tm9Nejg4ZkNHVzJaTSt2TDJMT013?=
 =?utf-8?B?UGVkVG1DNUlUNjZOcE1yekNZMlhyQ05ubTQySmZHSDJvOUk3YW02aTNCUGha?=
 =?utf-8?B?Qi92M1NLeHlFdDAxMHE5bWxDYlpzUVdxeUlTQ0l5ZEdLc20wZ01JSjVLYkhY?=
 =?utf-8?B?UG5lVDdxeXFmNnlUUXBoTEJ2Z2JrVDR6cjVISXdOMXRveld2Z3h3SFcyNjdm?=
 =?utf-8?B?MS9Kb29wYlVWYUhQUnhKeFJmL3hUWDdsNlE1bURkTWdPQ0tqR2lSR1VhQ2E4?=
 =?utf-8?B?Mjd2WFQxTkUrY3N2ZW93ZlRNMnFkT2RlWEV6Z2RWN2hWSjVVdnltVitpbXpP?=
 =?utf-8?B?WVh6R0xrRTdyY05Nbjg3dkZXTDBpdnhQZFlpN0lIR3NwcklrVU4rQWMzaVNZ?=
 =?utf-8?B?YThDZi9CazhXMkN5dDBpZlBjSlhmamZrcjF3R2s4cHdIWWdJVDk2cGtEdzRC?=
 =?utf-8?B?NmREMC9DcFNlNSs4bzFRQmN5cW5iRlI2VHJoQSt5M05WUU9SNzJCNy8vajRq?=
 =?utf-8?B?Qm92c2FSQVlPZXMvTlNGVXRoMzNzbmo4c1FnaUxUeUVZd2phc2xzL2xlV3BQ?=
 =?utf-8?B?QlFEMkVnL3RRTHhpVjBQcHhhRXN2WlVMTDV3VFFhRkxkamx3eG9jOFIxR21B?=
 =?utf-8?B?SVBRbWkxSnh3ZzBGUXBPejFuVFcrMXorYjZnNzRxT1liYkJGVWtVUEQwamdm?=
 =?utf-8?B?NUlBd2s2YXp0UklsakZoRzJaQm9VbHBkQ1RobDh2Q2d4VW9PQWZZdFFOQi90?=
 =?utf-8?B?bjFvWmZTaVFmUVFpR0M4ZTNkWkpBajdWc1JTeDFDRndWb0ROdUxobnpjT0Qx?=
 =?utf-8?B?N0lGV3h5THNXSE0vL0VlQkllMGRoZDBHcVdZN05FT1Jsdy80NmZmYkM3K1Bx?=
 =?utf-8?B?aUlZSUNPM2FNUXRDSWswLzNYOXJkdy9oZS9kbEVYMmwxa09pM1BoWHJ4NU9z?=
 =?utf-8?B?cHh0VjFaQ0RzWXkzbmhETnZXWE5uNGhYbG55UUNjcys5cEphTHNLamRycXo0?=
 =?utf-8?B?VlJ5Q3JadjJ5M1l3Q09WNm9kRU5JSnMvMm9IOVBOMWNGWDBGVHFGTWpZZFBM?=
 =?utf-8?B?dXF1eTlBdEtQZTBNdGFmWEszMjhoQnlNYUVRd3NuUWliaEY0L2ZxcEFVRG9h?=
 =?utf-8?B?T0RpRTdMWTdzRXFodFNpUkFidkFlQ09zNFJZK3NWZFhBakFtVlFyTm9DOS90?=
 =?utf-8?B?b0JRdnR2R2Y2Q0hnTWpqSE5xK2pDamhYRnc3NXpSMXUvM1hTUEF6UlYvY0lF?=
 =?utf-8?B?aFlNamxaM1ByWFdWcHNiSTZTODhxWG4zQTVjd2Uzd01nNkdnU0ZEUTJ2Mkgv?=
 =?utf-8?B?N0NrTklEb0ZvY1VlZ1g1VTgxSUx3PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da386bf9-abef-4dbe-68fd-08dd75c999c9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:44:48.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fzV1ZtBbi6g/NVsUiyyfOEkQbAYcwNDcHCr1TJfjlRbaUp9OlT/fMcdsaH1EA1MpVB4G7F+QwlmNE4o3Dteq1ELl3OzJVNOCrReqtwEpBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB8705

Hi Colin,

+1 for this, it was also found by Clang analyzer, I forgot to push my 
finding on this here 
https://github.com/sailfishos/connman/commit/6aa2c2910edc2186233da64726d4afa0c17aa5b3

Cheers,
  Jussi

On 4/5/25 05:09, Colin Wee wrote:
> These are freed later in filter_data_free.
> 
> Signed-off-by: Colin Wee <cwee@tesla.com>
> ---
>   gdbus/watch.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 8fa76cda..5cb2167e 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -332,7 +332,6 @@ static void filter_data_call_and_free(struct filter_data *data)
>   			cb->disc_func(data->connection, cb->user_data);
>   		if (cb->destroy_func)
>   			cb->destroy_func(cb->user_data);
> -		g_free(cb);
>   	}
>   
>   	filter_data_free(data);

