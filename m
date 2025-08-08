Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022077.outbound.protection.outlook.com [52.101.66.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670C279DCF
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656455; cv=fail; b=VakBwBrYfzBiaPyOBqOqMQ1t0M7toxC7uUfbUL7Q7JzFkcG+mm6SB/sF0WiDf5UHbUFEwf4aNGHQrolgEQJxbZgkDLZkUqOTI7Ba4NX5NumCneWzRfecvfh1BVr2vB1bovodKh5YLBhV7/1X0U4Pfk26/uPv1M3mMfm6iGgxoug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656455; c=relaxed/simple;
	bh=dhQElEsAEsBIB1l67kaVMRUJB7WPr6XenP18F+Aua6M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ghMs0NX2djdZHbigdFOv04PNKLzqZVg0ohV69gyYnEnW6hYGl6LNFtrM5lrsp3mbUrR7J2Ocy+iEUqySskqi3ySSi6062EkWV/ueV4tykqnwJ9YuyS7EMhjFXMghqOAWEVymrH1sn2MA4tBmU/rZZ6PYQyRbKGg5SmqX/KfhcPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=dEEmLf+h; arc=fail smtp.client-ip=52.101.66.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="dEEmLf+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlV3nj5fihzSKgeDj8T2ZWnCREJIlY1vKkbqJwzecKDLkuULOXl6C6mwuLqeL93nI7x348FvM3pXiKyrZ+tY/qT5+bxCspNsHhAq/r0AvWv0Kv8bJNvS7DpOkqhspUp3qij8LQt8xVzmVgb98FvuvwaZE4FFmnVcdzsS/aw1HXM+MsXL7eboxn0RfC4X+2X3bvAs+WltwNehCRWXz+ctWdhrdEewvP/QIXj8jcLVfTf/yPFzm8/51X2K3BDUKqOl8B/qjtm/POFNO5aLvjocTZCtAmW4KowXLoZvgpunqpxvYDMrB6InQsI9EwFYlv2ACTaiSXM0jaTCkmpO2ZPKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIPZbw9IHmCYiBpbMB6+gjAljPh9jnebr+wQAlvIGkA=;
 b=DSrXlLe5jxxriy3QArUKZhmu9+JRBouJC+i8UUkXfJMk96aue2iaiaJy7FX1Paz1mddsmdkG10Toxg5sy+Qqw/Up9GtwD8ZGd700EzyfcVt6l1tjQ/ShDwzUzACLjomWsEDlm6h25hSq1vqK66CzamirB80jBQLLvf4MQb9d81HH/EsO5fzdfnm0ZD0pCkriMf80PR+QlGx+eWgqhwQfG2F2I61aS8sYYK6aVTy/AlpzUgSCNbZgfJvW+KsZYhEGV4WrjUzRL56RaG1Z487NN0Xhe8gEk3DI2xDdMisX2uEE0HCIMqTSNfYPB62mP+6bcbFjdfpWJS59pbR40oarbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIPZbw9IHmCYiBpbMB6+gjAljPh9jnebr+wQAlvIGkA=;
 b=dEEmLf+hEFqK3bzqsnRM2F02TXr6yyy5OLaVBsr6GtR7PiU1Qt7TsDtOUjL9LOsRyfnguDhN4A1pDrwyUWmmW/AtA6FrSZ1kfJk3/NKH8hJxqAYO8sUWQOFoWxIgqnnJj+xod8YyUxkxyoK2Sk5cX/8UzAabiQsPwtlRV1EzWHP21GLVmcSJ0quvGnptn18EmVoCS/pS5uVLDoE/4KKAKy9nQKH/ktbQ7cmPsSJ4BgeEi1+q9FVr49bgvyYM2PGamcQP2+/P4Vya2Lyr88xGOZtcpY9YO/rUL5LwF0KXzs9ILpLeCwMfq5L6p3wA/KOWUm/wZAkehw8seAB4Np1AKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by AS5PR06MB8749.eurprd06.prod.outlook.com (2603:10a6:20b:653::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 12:34:10 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 12:34:10 +0000
Message-ID: <33d0d358-6ba4-4074-a5de-ce1479ceaee5@jolla.com>
Date: Fri, 8 Aug 2025 15:34:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/45] gresolv: Add generic error for GResolv struct with
 getter
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-17-jussi.laakkonen@jolla.com>
 <98baf14c-069b-465f-9532-44f48b12e888@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <98baf14c-069b-465f-9532-44f48b12e888@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::25) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|AS5PR06MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 466cf999-2654-4837-c6be-08ddd677e007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFBGWUkyWjh4OW9ZQ2xmN2h5TEtzSmdGR25JeDdKdThqaHhjU1FXTnhzTDVo?=
 =?utf-8?B?NU1ROHllSnpoMHYrZkpTd0hCSFBiSXJrc0xoV2RvbmM2NThKUFNnb2YvUHhY?=
 =?utf-8?B?b3lWYlRRUitJbXFBOTNWWGpFSU1jWXZ0SWNMTVM0OFBGeWZGbFdWbkwwWE5Q?=
 =?utf-8?B?aG1Qa25UK2UxZ0M1cjRudjRBWVEvekhtSGpFT2swVDBiZGc0YW5iNHhrLzRR?=
 =?utf-8?B?V1c3TXlDMTBZMTBkYklhQnladC82ajZ0WWRjWVFYWlp1TWRYNys5TnBESEk3?=
 =?utf-8?B?M1BCUmxmTHJmZFk5QlIybCtIc0ErN2NyaTJ1QUhVZkR3ZXdWSlJsdEVtWFRT?=
 =?utf-8?B?RkhodnF3UFhiemcwRlZmaUR0bkx0TWZJWEY2aml4cDk3QUpUa1EvZWJvQkMv?=
 =?utf-8?B?dHY1WEtsQUo2cmxPUUZQVzVkN091WEtKaXZHajFqalVNdERrYnFmQm94YzNB?=
 =?utf-8?B?ZUd6MW5FRGtFeTVtdjhJa2lOblV1U25BSHpEUXN3SDJabWZ3amlIZlNhQ2Jt?=
 =?utf-8?B?WnhUekNNSm55MWpydS8yQzd0cW1BU2tLM3k5bjhNM0hiRHFCZXlGREdPMHdx?=
 =?utf-8?B?dTJiMHcva1VtdXZmL3EvMmlRSDA5Q2RnSFRFaVh5Q1dmakJuN3hNcmYwTkFL?=
 =?utf-8?B?ekRwTjNKL0p2a0FmQ2dpWTZ6MmpzTUdvdmJaMno0N24wczUyelRTbEJDMWl3?=
 =?utf-8?B?QkhKK1ZUWWJTd0lEUzc5c0dyKzEvazFNTHp6NEc2S0JpWnRTaTBYaUgrT0x5?=
 =?utf-8?B?Z1E0VHhISzVQTnJpeUFTVWZtM0N5MlR1aHFTODlTcWlTZW9vRC9BUFBPSG1l?=
 =?utf-8?B?WjRkeENBYXNVdmpoVFVGTkFCSk9Xc1FWR1N0UFl4cEtRMEdXRHdCOVhMRDNk?=
 =?utf-8?B?TTlJQmd4cXEwdGRDcFlucTBSeFhBWklsQVNzbVBPd2hEWDhtaGlPc3NyZEh4?=
 =?utf-8?B?Y2JhZyszYWZjVlZwQkNNVzJJazVEMjlGK04raE8rampkR3RRVXFOVStnYXdr?=
 =?utf-8?B?cVQzUEljU0FkaEYvNVo4d1l1c0lyZUhURm0wbnN4WGdtNnVUSlpCY2UxeFE5?=
 =?utf-8?B?UW9rSnVFWWR5azVHZ3E1QWZ4bWJoZVRoa0p5Z3QvdU1Ua1o2ZjBKSDVwQVhF?=
 =?utf-8?B?Vy9IcWJDdURrVG13Y005OWQwZ0MxczV0anArcVd5NkFNd1BueGVRWHlWTXRT?=
 =?utf-8?B?QjU0V0duVWZIRXlqZDNQSjEzamhjV3U4L2VUWWR3YVZ5NjRydVhPWmZRT2ZL?=
 =?utf-8?B?cll6Z2NkZDhGM29XLzF3R2F6Tk12S0hXbHpJU1FWU2VsYXVhNHJidG4yK01Y?=
 =?utf-8?B?MzVFeUhveXcwV0dwTjEvYSs4aUNIU3FuWHhDQTJCTU1XZ0QxUk5ZTDAvTmkr?=
 =?utf-8?B?K096a09ObGZFNFZWck9yQmlsWnJGV044SUU2OU1uTzFJcFl0ckl1V3dDbXdU?=
 =?utf-8?B?cCtqektmL0RocWFTeng5eWMzNk1YdFUzLzlnUUtMMDVzdEhTcFh6NEpiZXRZ?=
 =?utf-8?B?S1pieGVXZ3FBd3pEaHR4VnRLUk1jbkNGWjhKQ1pMYnV5MWkweXFLaTk2SEhr?=
 =?utf-8?B?M2NYbVpjaFpRN3JsTTBhdzZHT0ovZi8wNlAvcElDdmlrV0J4Y25YUTlIc2pw?=
 =?utf-8?B?OFgzREVkQ1RONzZPa01IM0pQeUxiWE5hMkZNSzVoVm4yQjBSWXVSTW5uMy9h?=
 =?utf-8?B?SmtZWkMvT0QxT0tGd3FtbjArRS84VWFrZnI4bkVZYk5OS1JXdHBUbVkvTWNw?=
 =?utf-8?B?RU9kYUpBeUlxdUxzbEhoSVE2NjZjUmZ1dWVSQkc0UU51TGZDbzFBUkViWFk1?=
 =?utf-8?B?ZXQ5Z213dWFnUUZiMVBJQktZVzhjU1M0bGxIRGhieG5CcVhXaGpJRHJBWFlt?=
 =?utf-8?B?VmpvNFc5TVJFK1RTT3hOYk9XUTRsOGJmNklHS3B1c1hkQTBPYlZwaEtpZGcw?=
 =?utf-8?Q?UCZF//q34ak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUFEQjVnc3dKdUFDSzZ6M3lKY1hyNnppQVdUcGFmcW9rNEdvdW40OERCMjV0?=
 =?utf-8?B?Slpxdm9oNHJJTjR0SHZDaDg2RWxsTDM3WFNiaDZGSitSSHZiei8zeFdEUWxl?=
 =?utf-8?B?dU1OckdXcHN4NWx2QlkySG1nSm9FYml5aTcyc1JpYWc2Y2pXQ2Y3cnJ0K0dh?=
 =?utf-8?B?dEJpbVg4VnFmUU1rUHlycDFOTFhGWmJHVjBQcllHbm9zekkxNS8yVFFoZHZN?=
 =?utf-8?B?aTJHQ3ZCWW8wQVJwZStScmpmZUhKLzF2NUxzQ0J0MFlwZk8rOXZrVmZ0ajcx?=
 =?utf-8?B?MWVaWlM5RlpNYllMY1RBVXVjeVhtdGRNOWplc3BoSFFWS0VGU2pFQStoRisx?=
 =?utf-8?B?UHYzYkxxK1dVUlQ2N2gzRmkxM0NZd0UvMDVzcGJxTGRsUTRjTWVqU3JsRTZM?=
 =?utf-8?B?bUx1TmZPcldVU0Iva2FsWFl0YjdsUVlSMEh4b3FkUUpuTjJWZ0hCZEF2Z1hK?=
 =?utf-8?B?dWcxeDhIeEpqbXE5RksrdmhIZVpIN0ZiNVZsblJvblhteWlJVTFvbzdPRklT?=
 =?utf-8?B?NlIvcG9TU1A2bU9sUnMwbTdJRks5dFZZUWJ5eGhNMVRtL1FPbGx5MVZXK0xi?=
 =?utf-8?B?ZHJqeEVEMUZtL2s0emxnU1h4M0NvNkdyTW9qOUIrZUhBLzgyb25kZFQzVmpP?=
 =?utf-8?B?MSsvWHBIb3pUTTdGSHJSTE1KWXRVTi81eFBFL2R5K0V2V25rV2RIaXgvV055?=
 =?utf-8?B?cklldmhRdHVzYjdCTXAxSmJkbHNnS0ZUM0t5b2pzM1VMT2NhRkZCc1JsbG9F?=
 =?utf-8?B?VHpDNzR3NURjTGlLNjhlRVRtdEU5UjVZMDZIeDRqU0lOS0ZLSFdGK2xoQndI?=
 =?utf-8?B?bEF2MWtzSmVwa0tGK0pwM1MyR2RwVWtoN2YrWU5GYmllRDVIMUlXdk5mK2JY?=
 =?utf-8?B?K3pwVlk2dWxVdHp5cVJ0ZmJHajJ3TTZXWmt4WHFacU5vNE01ZCszN3UwQmh1?=
 =?utf-8?B?Z3k3K1N5bDUyRm16STVHSjMwV1hSaG9DcWRySmg2dkFmMVhSaFh1SC9DOHRF?=
 =?utf-8?B?ZVBlVGJyQUpKUFcwbDlDcUl0eG5ySzFDQ1VFbjlhQWtOUUs1dUdZMG9vSmhx?=
 =?utf-8?B?Vko1VXp5cWNwdlRYcjNzQkU2STVHcHFWbGFsbm9kbCtYRDFwVE5DN1ZFZGYx?=
 =?utf-8?B?Q0J0aHI4N3JXSmdyb1ZFbFNqUGJabWhOUmI4bHpJWTZpbTZoUEQ2Vllyd0xi?=
 =?utf-8?B?QkgvY3pSWTJSbXFYbzFGZXRQUlBIYXQrVlh2N2dmd0pna1FaYksxZldpVGZX?=
 =?utf-8?B?YUJ2Tk1WTGZpOXN6RHF3NFZVWWdla3VJVHhOY0hkZ1ZkTEZkLzc5NnNUUmFj?=
 =?utf-8?B?cEU3N0ZuYkJDdjJSYWU3MWw0NHp1Y1RjT2V3RGphZ0xyaWcyVFVTRGNTSFAx?=
 =?utf-8?B?a0ZaZ0FYVjlBWmcyQmNyRDVtZnVMMlpZWld0Sk1DeHoyRkJpZWErdWpvbmdN?=
 =?utf-8?B?Tkx1S0FIbWtITmk3T0dVbDFlR3RRdTVDdkxzQ1NERjJmMm40bHNBeS9RTlMw?=
 =?utf-8?B?L1h3SGFqVGU1NmxZTnBranRzU0EzM0tWMks4NWFBWjFlSmNQMy9od05DUmJw?=
 =?utf-8?B?NWJOckJ5UEFKTG9RYWlEL3B1ZHBiQVRybjIrdzc2THoxc1ZRSXVkVlZDcGlE?=
 =?utf-8?B?emlUNlNYRC9kNENKSHRRdDFPczZKVFE1WUMrTXAwVkM5L0UwK0hlZ1F5YTUx?=
 =?utf-8?B?Uk5UTkZMcGkxTURZU2pCd3V4S2dMZ1Nua3RqZktCU3JOSFIvUGhYdWZpTk1R?=
 =?utf-8?B?OTFmNnBSdjdCVzRoQ1owVEUxbFhrQ1BKSFl2OFhTU3pidjBOZi9ZUVBjbmZQ?=
 =?utf-8?B?SlMvQjgwT0ZVZVAwbDdWV3NvNC9NOWovdmNyMjlKamM4d0RiT0VROTlJK3Rs?=
 =?utf-8?B?SjhpRkswcWZpVTZtbHRDejlTTHhkeWY0c1FwUWlwWWpsY0hlaEdoWkVYTGNt?=
 =?utf-8?B?cFFWWGhlWWJEK1JYWXZxZmlhU3RRVFZFVzZTR2RiWDdiMUt2ZjRBdW5zZUk2?=
 =?utf-8?B?UmV5TElRSzZWY09zcGRCcjVQams5cmlMOGpUL1Jkd25Fc0NRbVFFRkFWeUZx?=
 =?utf-8?B?SkNOK2NRTktnM0FhWXhFcktMaXdSZTM1N1owMTVHRFFVcEp3RnZPbG5wdmE5?=
 =?utf-8?B?Rll0RDdEZldKSzFQOG9yUU1zeGpXZDhONnBvRmE0eGxmT05VbWVBTmk5bTEx?=
 =?utf-8?B?SWhxRWVBRk9uWlV2aHh0UXlBVUxIRHcwaTF6Ym9DZzkwaysyc1d2SkN2Skgw?=
 =?utf-8?B?OUt2eFM2Qk5kMFplUTIyVzNvMERnPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466cf999-2654-4837-c6be-08ddd677e007
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:34:10.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37nuEFR9TWeAmJibkpxGAleAWaWdAUWvMOLuj2WC2iWE3i4mZFZXA8mOZbWCwYf0iBYw15Iapw2r0a+4nVgxll59rdShltRtDXuCzsRcCpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8749

Hi Denis,

On 8/4/25 17:37, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
>> Add a error for the struct to be used with hostname lookup. The function
>> should return either 0 in case of error or the source id, this fixes the
>> wrong returns when error happens and makes it possible to retrieve the
>> error afterwards.
>> ---
>>   gweb/gresolv.c | 15 +++++++++++++--
>>   gweb/gresolv.h |  2 ++
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/gweb/gresolv.c b/gweb/gresolv.c
>> index 8101d718..1f1db474 100644
>> --- a/gweb/gresolv.c
>> +++ b/gweb/gresolv.c
>> @@ -116,6 +116,7 @@ struct _GResolv {
>>       GResolvDebugFunc debug_func;
>>       gpointer debug_data;
>> +    int err;
> 
> These errors are really local to g_resolv_lookup_hostname, so not sure 
> this warrants a member.
> 

Personally I think that the error should be in some way retrievable by 
the caller. Previously the error and the source id's were mixed which is 
never a good option.

>>   };
>>   #define debug(resolv, format, arg...)                \
>> @@ -1060,7 +1061,8 @@ guint g_resolv_lookup_hostname(GResolv *resolv, 
>> const char *hostname,
>>       if (resolv->result_family != AF_INET6) {
>>           if (add_query(lookup, hostname, ns_t_a)) {
>>               g_free(lookup);
>> -            return -EIO;
>> +            resolv->err = -EIO;
>> +            return 0;
> 
> Since this is a glib library, have you considered returning 0 and 
> setting GError in/out parameter instead?

Yeah, sure, I can change it to GError. Just tried to keep things really 
simple here.

> 
>>           }
>>       }
> 
> Regards,
> -Denis


BR,
  Jussi
