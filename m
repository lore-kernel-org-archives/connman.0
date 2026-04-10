Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023072.outbound.protection.outlook.com [40.107.159.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79973976B3
	for <connman@lists.linux.dev>; Fri, 10 Apr 2026 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818935; cv=fail; b=rLH/xoGnClPYNNEL67PAFrZEtdmB2iCwAulmWvUZluMGwaRkICgsTb+tgbkZ3fMy4LPbor9yRSlG4PVV+/wafN6tbo9n5sskBi493mLS0X81nNqCXQytywqN7ibRTrQWxVzclwJ6L4NwF+T1nDHMZHwpKQr26GmOmJlxsJIzcdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818935; c=relaxed/simple;
	bh=Xs4hUHICNEzvlQEPqTcRlGozjz+n2DyuMdmguwwopZU=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LLwj0OqrIM6z+nJWE88e8FXPa+VrODGHXnTz37Uip1Ei7BCpjMhSeXEGBtJVJdVL56IKNOtAoiVAyCaLtW0I0xi/tg9lX492re0hBrl3VLIJQPZkOFjc8PmUJY78G1QSCkpHeaZtj/+f8TcKeqVRCvwjzQo5oMSoWtrs3pPypRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=te/jTcUn; arc=fail smtp.client-ip=40.107.159.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="te/jTcUn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Awr8hgU7sTW1N9d0J18JWDaqGkI2NtAu8ljgQq8s2Td4HwKqaznHTdG4uPDrOcJtnnmlYMzZ1CpfUZC06U8S5GhBJEQGd61IAKpuGqqPcvDHb0nStc9mZHwlteioRaBoehgQbejfMVczUD6xWj8U1x/4vQZlH5RNjUo1jEVf4nGB7YfEn21glOcw2Qh9U8kTW+0kyb8Ege8nPY4k6dT6GfCqsRaDXei4dmQLVy6nXZiw89pdV5dm0ZpmzSnoZklDk5oiROHe+18rcMPliPmS/p/VrHmr8gGmNYhB7Y/86b8ytfES6/elnnZRdldhpHKkN9WqndeqQs50Uw6xW+hjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMhmEi8v+whJmIVRu/XjapY14EtGqphRa8eZORSY888=;
 b=P/upUrgQDsyxc3fXW+UWbGHPBBqIcoen0sIbSH8Pn67YuHH0ymvbCY9149w340rxIvlEMSxpf1d+NRXYkN0+U4hne1DpmXQwbc6nf30uSKpRmOSQyUGpuDa4iLYUsZiTFbhrhNXBiy/5qou1vvuGEs6vyeshw5Y94rQv6WlxRhxZJS89zP2znz8x55KUIBWzdGXdmVsDTN5HE3wI+RBUiimN9t6d6s9GzSUNqCAsfqtRhC30oyaUMWI0KtZDNOu8e6w0HivNlfax5pfdiaSACtX/k0T4BGMkbDZRaf1JJcF8WFjO3Sw44lHs/I6By6EB5Hn2hbQMC9KRIpJFCy+KAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMhmEi8v+whJmIVRu/XjapY14EtGqphRa8eZORSY888=;
 b=te/jTcUnAxhfBX5mFGobBJ8hKhYocKxfIKdce2jdr86XQ73YTFAPNmNsebQRKUvU43EDOpeynPIbjxVAXnMcA5xnEKArhXJSMwyCPKN/iVAiSX5vMt+PDC1dCqQfns74LRJc+7bvCQeJKg24FpV1R/Mze6+mykxk0tVxz1Abwz14klCtodhqgH6gJ+X0ElNUjU/q1y7gmWHMeweyMoPvLynaFU4lEt1BV5MsyWL8hN+wVGZXR8FMQVOZ7XkK86ci2ks2L+NTJVK+1NpK7gqqhDYzkvsQbdIPrBHJTJvXyEQmzmJvAevMGD/iezAxQriEmxhwab0LIrRZKDqCZtPCXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from AS8PR06MB8167.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::13)
 by GV2PR06MB11046.eurprd06.prod.outlook.com (2603:10a6:150:341::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 11:02:09 +0000
Received: from AS8PR06MB8167.eurprd06.prod.outlook.com
 ([fe80::fea6:d2a5:783c:3138]) by AS8PR06MB8167.eurprd06.prod.outlook.com
 ([fe80::fea6:d2a5:783c:3138%3]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 11:02:09 +0000
Message-ID: <077e2d95-ddab-4326-b8c4-2c4e5913018a@jolla.com>
Date: Fri, 10 Apr 2026 14:02:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vpn-provider: Compare using lowercase of type value in
 set_string()
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
References: <20260410105840.1521646-1-jussi.laakkonen@jolla.com>
Content-Language: en-US
In-Reply-To: <20260410105840.1521646-1-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To AS8PR06MB8167.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR06MB8167:EE_|GV2PR06MB11046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd97b41-8c88-48e6-b142-08de96f09c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	72n9uICww5+IwjA+3qmRX59YOnTpQa67VrfPBaU8Ku4rfV0LM/1e2CkFsU+J8zaMvJhZ/PZhpcZfzsJl0tNwdOVcJvH4q7qa19fmijwEP4xA3sXWa6r21SS2uZbKe4EJvg1VrBomQpBrTwoVVe4xtO791TF1jFMUHpK3AD77uSTHXvWvwtBwnO9louM6dBIkhHpyXSveEvlkuiCSndl9Ue5lzskQVkSoO2bDcspxSqrao8FyvtHyJ1VvBR/w+3yrg0mUbJjW6jBJw90CgE9S+71qWPPCZBvI2ADi+JlE42UNvCH1rC44d06TGKoP1GXV74X+Y0QRjgpt24GCypdjgZv1ieuaT0fjolwt8xSqYiB/XHBz36KviP+jL2FHEggK3NyzqFUdItjacmQ3RZ2Z6Z6ybBtVdTWFCWnvtRmb+GrOt6Kb3pWLBpGgYizGOp8HjiaksflynRn7Y2QJn8S5omCVVcz6/o1SpEUxFO9HYw2vpTRZATAHkz8lZ9quyHjHC6O33O5YHF4AZ2VfvEDOQseNwzDFdSGA5XwtBTZxqrf1scEclO0pFu0C18S5g1k67mW2x53bg0lqPj80L+Oee7bizTp4R/9rIcZj73sF2pcNWJzH5b/djTqnOKSYV1TUnbzTTwHb1xKxyA5C0Sz1t5B4cxH7Zc3Q6lY2hAfiabk7rm8QlMotUHN80ecjbofiCG8gZ7Fp4o08+3KUT4DDyE41dG2W1tEDelMJ+vDe+os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB8167.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkYvNlEzTU1xUE5wNmh3SE04RUtpUFRab2pUVk0wSDRpdS9XU3BBdllhUFNt?=
 =?utf-8?B?RHpDS3Rjb08yejlTRnhDbjYvakw5bHVDZW5tTy9SNWlrbkd3eExQdm5KYzFT?=
 =?utf-8?B?S0NCYUIxUWZzMWFxZlFjMHB4MnpSUGdvNklLUWVPZDQvNmVxRkJVbU4xZ3NP?=
 =?utf-8?B?NGp2MXlyZjBneUlTK2tZVm1wSXNZcUgxNkFCakhpSW9ZdlhCcFN3c3FPRGVL?=
 =?utf-8?B?UnpaN2ZhWnVtV3gyb3M5SWlBTENaTnFRS1IzaTBDYnN1UUwwL2MvNFIyZ29S?=
 =?utf-8?B?empKU0RsSGJVUmRJR3ZGRG4rajhpckVnN2dWd2V5ckRib04yUE5qTm9HeW12?=
 =?utf-8?B?WlM0QW1mOE52VTlHZHFwSDBMSUJpZkh6bHlDYjZMdWRNd0szY1hPeWc1ejVi?=
 =?utf-8?B?Z3krRDYzQm5DRnpuelBLejYyVGFJcVBRR3hacXVzOEJ0Z0ZINjFHMGhyRksy?=
 =?utf-8?B?QzByZTI4QlU1WnZoQ240NThWOVVtcDN6T283NnJtb05nUlVVbmYreEdjVTR3?=
 =?utf-8?B?bm4vR3Jub1FPNElSVCtuelcyUklYOEtic0hab1RmV0FFYjExc2s0SDR1YURh?=
 =?utf-8?B?UDE5bmJMWFZZZEhpVlJBSzRsZ2ZxM2oyUTl0RkxiWUlvakl1cVRDcll4V3d6?=
 =?utf-8?B?ekgxZnpPVEM3M0lJamNUbjFyTTU3dU9oV294VUdSVUNtM3NaVU1McXBhRElY?=
 =?utf-8?B?cGFZQ1RuNFNkcmh5YlhHWkdlSXFDZ0Nuc3FtUE9CZ1BiY1d3Umk4TTl6SDda?=
 =?utf-8?B?Z1Z1VGk5T3hTWTQ0K3FINTZvbFFnR0tnenBEMlpFaFBjVEpHcmVjWkd3VndG?=
 =?utf-8?B?SjJ6U1R3bnZnTXhzYjlQWktTWUd2RE1ucDFjNjFoQ3NkOFNjZkVnTEtjTmNt?=
 =?utf-8?B?WFViZEt3cnVURHAya0pGakRCeERFMzdvNmpWaVRVenkvc0RoRXFvckhwbTlv?=
 =?utf-8?B?SG13SWNGSUtFUTE3ZDVYR1ZXbEFHWCtSOExyRVZJVWVCQzMzaC9wcU1ORTBP?=
 =?utf-8?B?aXhlSG9RMG42a2JxUDBjQU1IZ3BYdDQzUE44VjBoeUsrKzZ0Z1BXdmlxUG5m?=
 =?utf-8?B?cHFzb3NBcnU4bTJYbzJFWDMvNUpMZmF3ck1XUG1hTER5cEIrRnIxQ1VURDc2?=
 =?utf-8?B?d1N4dGU4RkovMWFJWHptSjhBOTdydDAxb2VLa2UwN29Uc0ZzeGptY3FTMjhS?=
 =?utf-8?B?U2tDQ0JRWFBTMExsVmFwK0VXaGJzV1NtVmhpci9wTWFxMWk5K0hhQklySGZH?=
 =?utf-8?B?emMwdXRQSW5ZUk5Fb3dVWVY1NVZUTklNa2I4VVkyM1A5eStYRU0xU3BrWlZx?=
 =?utf-8?B?SC82d1pTTHRSMG9UbHlXZ09id3lxRVdHRnNtQzFnWXVHTkM5S2xqNzBHM3kx?=
 =?utf-8?B?Ky9wZk5GWGs3NUExOVNyYk0rR3hhNE1wSGxZNDNmdnZkY2JkZkEvekRGdkRn?=
 =?utf-8?B?c25GL0FvaXhOOUJISGt5S25vQTJXbWhyOHRYZ25DS2h2Wk5pM0FGZ3BzKzA5?=
 =?utf-8?B?UllISXRwNDg1QnhtVFpaYmdrck4zSVlYcVlESWtIT2N5ZFlidXNVMUxiRlVO?=
 =?utf-8?B?TUJ4ZFNaV2lqZ0xabHRxbnRzVzgrdnlxVHovbzZzZ3RpNU5FdHFWYmo4V25i?=
 =?utf-8?B?WERRU3RCbjFNWHR1bEpBcHJuMHBDQnQ1dlIwMHVnUEtxRDRVbjFJYkdOUmhl?=
 =?utf-8?B?WlZnUjZBNElqY2ZvOW5RaXpXNGhNQk1mOENyWUhkUFdvSkt0NW5QMllhV1JJ?=
 =?utf-8?B?eFJnanVXelJZZ0VJRTJmUUU2V2JpQW9tcHR2UTZZNnFGNXNnVkQ2Z1Z1SUcw?=
 =?utf-8?B?SXk0dXNMZ2xYWHE0K0lMcWl1dWZuSkZKQWlDT0pqKzBDejBQUEJzNU1wdHZK?=
 =?utf-8?B?UlhsL0dEZ2FBQS9NREtHNVErUkZPZVZMODVWODVSMlJCTGptQUFKemI3Tk94?=
 =?utf-8?B?T2Rxb2ZXZk9ybkF6bzBjWXZtc1RzeHNoWTdkdzlDMDdWLzJVc3pNZDRuY09t?=
 =?utf-8?B?R3R0bGg1ZUM0SlhxUHV1WXpna0ovQUR1b2pMaHp0VEJaOTQ5ZUtBY2JHSk9C?=
 =?utf-8?B?Y2x3WUc2Vzh5NDcybkRsSlM5dDVnUUVIZWh6T2NyckdhNmEzelhwNlY5NnFU?=
 =?utf-8?B?QnRGcEdaVmc0OGVqWUZjSm9TTEo5MGlycWJacXVMaS9rbmRCZGF1SUtoeW52?=
 =?utf-8?B?TEcvVjZJQmVLanhjUXRrYjBZamQySG82L1FLakt5dm90Q0w5a1ZpOERhRG85?=
 =?utf-8?B?bGZNbmdCK0JWbWNIRi9iOEw4bXMvLytaOVhqcFg1am9hMGVUOEszSHJGRHUr?=
 =?utf-8?B?dU92OXY0NmdMbWp1ZFFXUDVtaElCcW0xUDBENTVRQ0V0VjRFcEdoMlpMdU44?=
 =?utf-8?Q?XRkjfyMET5kjuxurjtFE8VetUKBhquts0yA1eP/uc988+?=
X-MS-Exchange-AntiSpam-MessageData-1: FyHXrlXarvMoFFadjtziIeLycKVkO8yBApE=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd97b41-8c88-48e6-b142-08de96f09c93
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB8167.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:02:09.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pbzESPI9NYK9eCOeqwtg3CYiyAsad1dsaZ+SVs9CKIjHpJYOVi7MfMx5J/ho1LzSATB92wnsFpVxBgULHLKqD/YgWcGRtLh/0lQcwuRORU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB11046

Hi all,

Heh, I thought the email was lost in translation again, this is 
identical without Frank being as CC as I thought it being the reason for 
rejectal, hence other patch I sent went through fast.

Please ignore this one.

Cheers,
  Jussi


On 4/10/26 1:58 PM, Jussi Laakkonen wrote:
> The VPN type value is always converted to lowercase. When the type is
> set via set_string() the comparison must be done also with lowercase.
> The issue was introduced in commit 3aa13afdf706dee92f657bf6799d6bd97b81da4d
> 
> Reported by Frank Liepert <f.liepert@meteocontrol.com>
> ---
>   vpn/vpn-provider.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
> index dafdaffa..2833d249 100644
> --- a/vpn/vpn-provider.c
> +++ b/vpn/vpn-provider.c
> @@ -2754,11 +2754,14 @@ static int set_string(struct vpn_provider *provider,
>   		hide_value ? "<not printed>" : value);
>   
>   	if (g_str_equal(key, "Type")) {
> -		if (!g_strcmp0(provider->type, value))
> +		char *type = g_ascii_strdown(value, -1);
> +		if (!g_strcmp0(provider->type, type)) {
> +			g_free(type);
>   			return -EALREADY;
> +		}
>   
>   		g_free(provider->type);
> -		provider->type = g_ascii_strdown(value, -1);
> +		provider->type = type;
>   		send_value(provider->path, "Type", provider->type);
>   	} else if (g_str_equal(key, "Name")) {
>   		if (!g_strcmp0(provider->name, value))

