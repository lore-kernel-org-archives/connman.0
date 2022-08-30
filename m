Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F54374
	for <connman@lists.linux.dev>; Tue, 30 Aug 2022 15:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVihjVx6K6f1/i3yfdFVCFP3x+6LUMqeuygdpMTRxqxq2MTH9SYDioJbq092CsOBPEntDVDZpbjqYG3B+kuIJehBi6uRJyfIuubEuZD5KQkpa+dv/Hl5R5NX4qZULiKJygAcKjpo0CxztbQqirQwfbx1Uf6S3ZPNW9ZXWgFq86GG3b3LvFFRxdJxYczUXciwOs4ftufU8m6/M0iDBr6ec2Hau0UxV711ldDB7Q3mG/XiClBrMcXJWlW0HF39s2sJ7YErnELx8D9fJ2iomdFmtfzy4YT28qga1s+BXyup2WWwSjcbHyGxHxT8pTerxhpffE7NV3zr+ECyVrmGxjepnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qiHTGy+EEwdu97x5TjdjZAKWAiYcKRjg5qitSOsiJw=;
 b=fJilEdGvdliuzxLr957Y1bCW+V/gtcHxFdsv3GpkA4wqzP0YHfUxu9R3NnRvxMv1uR4W0m4Ne0+Q1If7kzIhsRu1e08g6q+woETRfuzEID32aZPDygWaU1VTdgLymwm5MNhw9Wo2bNtPxhl8go+2X+7CvhPMcZLqvY4GnEEhgdAUDvYJ59BVBj1nw1M/P8jmPEQkrlU0e/168nOnA5bgDQBihAMMQziY17onStqhuDoIMtecUcvcS1/xe0LYW8nDHQbj3M/YOydogQrC8gWY+gJQ14aOzG43d1oAaPuwxdcyeZe4dIAl5CLmKkO0rQnNa+H5+omei4dpaY1tlqvDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qiHTGy+EEwdu97x5TjdjZAKWAiYcKRjg5qitSOsiJw=;
 b=JgoxKW29PtRqMH7Q+u0H01XiuQ3/sxY+lu3qOXQDyLMBfZwVxD3z2vGYVw3w7seK50a/AuzAoVj8Gvdcy5kULcXZKz014hg4+YDZrch05QdojB9y+dlNESeF40YRWrZhHnOMa85S6/vOyFq0y9nIxgr4OrT/e4VYx5v1ZL7wnu+Ud9bH2hwKdVJRpdbO/7hz5/TKrJTCZq/u8xL8h1hHp+g1DlN1owqPMwwA4qEV6cQCt0VyVmt0tMu8q5M9NIfbe9XimXsYfgCKC4EWlErJN0k1ruK1ChjqON3LhPgyI1q/KmQW7wFK1ADOfyMGWfoXnpwA3K3TB1r3Zq4c7/ev6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0602MB3484.eurprd06.prod.outlook.com (2603:10a6:7:89::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 15:06:18 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::814c:dc92:67ad:eedb]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::814c:dc92:67ad:eedb%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 15:06:18 +0000
Message-ID: <f4b37626-00d3-19bd-d667-d820db47a35f@jolla.com>
Date: Tue, 30 Aug 2022 18:06:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] resolver: Add path to resolv.conf to config options
Content-Language: en-US
To: Daniel Wagner <wagi@monom.org>, Jakub Jirutka <jakub@jirutka.cz>,
 connman@lists.linux.dev
References: <20220615165350.11431-1-jakub@jirutka.cz>
 <7d291a8b-712e-50a5-041d-feeca49f9d4e@monom.org>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <7d291a8b-712e-50a5-041d-feeca49f9d4e@monom.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0102.eurprd04.prod.outlook.com
 (2603:10a6:7:54::31) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b6fb1a-e54c-46dc-9b52-08da8a9930e8
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3484:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eCLio8may5f2dtCEK0UQyaW09rxdRUFmi4EvHBbJu+jCNq0V76dlrsfWBAsfMYeUOS6FkDPIdj8y7KfgajxdP32s8aIyXn0nB6yhy6NCPQa2UoLqeESsbdTnPfuXi6GuczgULdoJcOhSF38zkSyOgIEkAE1qKJ6yCbPtorCYaOtUeHswqaRY1JlHch8tBY99Y6nH/bOj3h0aATcjt5wdZHDGZO10pUm5CCUX7zApFUFgbk0u81YzuGbtXGjet/VO+YN4Bnh7x+4Cex9eDBN+/U385sZIMbOvsE8fo/5wIVd5CBa8k/ySeXVGaVLALBrT1q3MHi0zOHOgpfCtkAbb0d+luvFk/EtMeBNc4niGzslBem7uZvJpEqmLOiGTzbcAfmZx82YtDKy2LvaJahQ4vum7aamn5X6JCmXRYEaRWjEN7LreSa37z3f5DU1fYAsFgpJiiRyD3wrpb0x5BA+3dvbf+zjPKbivkZ7+v+/rzolY/Dt2NnX71ixVnR5PZXSUzahbuMobsH1Rg7DQ6gJqsdZNYgeqee6zNWJyqQoYr+2YaJ+6I16TcucJ/wVjimQjTYPAd+7tSM6uz4d5w7uZdNAThDJ42w8Nknc6TKxssQ1rvCr+SIbccvgCgHaY100L+Vwz4wnN3PEsqPyNa1jNdzFgC8gi48nCg8DCajdNMx/fRze1t77eg6UuR/zDkcogzRewDUPLmH3rez/wQzpvB6HACwLaSsyuO+uZPdhBiFkTkozlZZUk8dmhusjTauiJiXFFvHQ0PZ9swHxEqbEYefTNjz3XhoUC1e8VOXC/QprNanSEKQ1u10kP2enYmvL8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39830400003)(396003)(366004)(36756003)(5660300002)(8676002)(31686004)(66476007)(66556008)(66946007)(86362001)(31696002)(38350700002)(316002)(38100700002)(83380400001)(186003)(52116002)(6666004)(8936002)(478600001)(6512007)(6506007)(41300700001)(6486002)(26005)(110136005)(44832011)(2616005)(53546011)(2906002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0x6T3dBd3ErRjhsWXdRY2ZuSzdreGlScVh6NitEWko5YmRodkUrSzZML0Rj?=
 =?utf-8?B?MlZCTFpNcTljdnJDTkhOWmM4QnJ0MTgrYlY4clhUUVgva3g1MlNVTm83M0J2?=
 =?utf-8?B?anc5K09ZME9OUGt4UWxBSGxOT0t0NWtwVnU4ckxUNVRRMDVBTXFEWWdZT1RH?=
 =?utf-8?B?U0xIR0liMTEva3hLeWxzQWE3L2tJWkg5MStvQ0xDRjlYVVozS25iUDdld09h?=
 =?utf-8?B?dUkrUnlyVE95N0pBMFdGTzhPTGpDTFZLNDVZRkhPbFlEalBUNWtaWVZZN1Bk?=
 =?utf-8?B?cGQ4b2VXdEx1ejdEaHFTTFlIdDVUK0s4WGFYVTBJbFVoVUo4M1lhVnhNUTNs?=
 =?utf-8?B?UEtheDIxT3QrN3F2Q2lLTlg0M0NydUNyZ01DclFhdE4rWnRPSGx5RUVrZ3Rq?=
 =?utf-8?B?RXhUdFBQd1o3QnhNSDNOOC8zUTlTVlc0TkNhSDNWZmdBWjc0MXZkcW9xQ2Jk?=
 =?utf-8?B?K0MzaFEvWkU2LzlpbHdxMWV2eWRnakZSUkM0RDZnamcxUHhpQno4SE5iNG5S?=
 =?utf-8?B?Q1A2REFwVm5LUzZyanFCLzVQNnJuSGRRWnh1ejhlVEcxVEgwTnp3dmJ3YzNO?=
 =?utf-8?B?YTk1M1RidHFSNXJUbHc3Z0dHYWh0NktXOWNpVVkwWkJJVmc5OXR1aXB2cVdD?=
 =?utf-8?B?OEVLaDRWUEgwcnZrSkN1czlMcGdYd1RDMy96VUJLcTYrRTgybWdjZVJGdkgr?=
 =?utf-8?B?MWNhZDU1eHdtZnpHdTBiTTN2MnB5c3V3OHVWWUlJa0Z2NXZTanBrbWcwOXYv?=
 =?utf-8?B?YThRUWxxUk9WK3F4V1pweERPc3pFNW85S1BQM0ZXZDhCTkpRUnE4TkwvVDJw?=
 =?utf-8?B?aVJHbzFXTUx1ZUJ3MWdOQ3c3ajFnWmRhM05Qa28zNzV4TWMzMTJabE1uRWQy?=
 =?utf-8?B?MTc4YkN6Z0lMaVZQNTljV0p2RUtGZG8wWDlQUUtRM25qNE5Ec2hwSnB4QlRq?=
 =?utf-8?B?RjZ2VFNiTmU0cHNYdlZna2h1UlNrUXBNVksvNVZRRlpvcWtXVEZQTUtuN0NM?=
 =?utf-8?B?bUFrSFhVbTVTQzU3MHBmMFNNakZQNGVaM05iTllKeXlDMW5KWEJVRHFVcG1X?=
 =?utf-8?B?cFRpcVpldGc1RFBnMlBBWEltaVhHSFhhbDJlUS9ERW9JZlk3RUZmK3BNbUx6?=
 =?utf-8?B?Nk9SakZuRlZCRmptT1ZsUTZQLzJNZW44STdBYUJJcXpQN0s2b1VrQzV1K05N?=
 =?utf-8?B?K0Y1MmxyNDNLdzcrS0FLTlAzMzNtZ05qaVZpZGsxMlY5OFdKQVN3ZTBMa0ZT?=
 =?utf-8?B?ZFR5OHJ5a0haZEZRTXVvTlp2RjNSU3lnbDlDOFJTOUNHajFkVzA2R2JMMUFN?=
 =?utf-8?B?RExOaXY4M0xPN0VwdzBwSDgwYU1LcFRYMlpYTjNDdjZpN2RCMDk2Q1lpT3gr?=
 =?utf-8?B?aG05dXl3S0JtalREdHIrTHB5RmNTUWUxQlNrbDJTRE4ycDdlRDQwd0Y0aG9a?=
 =?utf-8?B?QkRKMGxBNVNTSHlhdEhwRVNOOStrNmQzMEl2a2xuUjhkUlJsSy9vZFF1VXp6?=
 =?utf-8?B?UVQrZCtnVDlScTN4bnpRRTlteE5xZlB2L1lzN2p0RUhOQmhoYkZDNCtVUUtN?=
 =?utf-8?B?c3V0RjZGbkw1cFlSdXBENEVnZkloR1hzcU0wbjQ5TitrTHgyK3hxbWJ1ZWFI?=
 =?utf-8?B?YURqR1J2d1JIemZ1Y2Y2UTJVMHhLUjhxc1BGNFdWaFQ5MzI2YW1BMnJWczls?=
 =?utf-8?B?WjQ5OGduNjFmalpJZ1JOSnJ5eHRKUzJrdi90T0tpSHZLekp4R2ErSlV4alhl?=
 =?utf-8?B?QTJMQjVuZk5veWdsYW9qMGdXVGpwTkVRNGhsWDlkcERHUFRuWlBDbXRoVHZO?=
 =?utf-8?B?ZUV0azJzdXRyUjFPalloUWN0alRkUGdBVkdtOVZIaVFZa05SaW53Z2Q4UVdQ?=
 =?utf-8?B?OWFoSGVlOXhRWGJiYjF6dTJqbW4yanU2ZkNwNlNnWmdaaXdOdGExL3cydHpB?=
 =?utf-8?B?MUJkZ1loQlBjc1NZWUd5VUxDR2ljb1hCNzZOTzlUQVpjV21pcnpEMTY5MU1X?=
 =?utf-8?B?VEgwcG9qdlZqSXJBUHh0OTVMNkU5Nm5uVEpueWxRaThlREhxclhCdThMMW85?=
 =?utf-8?B?UkNlOW14WnkzZThmVGpKdm1td1RUM0ZQb0xQdGdqampreTBXUm11bElZenJO?=
 =?utf-8?B?Nk5MYnh0NzVoazg1dEdoM084Um5XWTYxYjJGY0J3bi9wVU15clJTdHV3ZytD?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b6fb1a-e54c-46dc-9b52-08da8a9930e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 15:06:18.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHsQ/K+XmU/dOrYuRp9c33F3hEUNuPAq+HU9GcESAVxn+obAH6AS5Edbh498u4HE8cGD6Tpj5vuC+UPEjWvupwWHYhmlP/3EYZdF0HqBDts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3484

Hi Daniel and Jakub,

Just spotted this mail and might this need one more g_error_free() call 
before the patch code:

> @@ -594,6 +598,13 @@ static void parse_config(GKeyFile *config)
>  	if (!error)
>  		connman_settings.regdom_follows_timezone = boolean;
>  
> +	string = __connman_config_get_string(config, "General",
> +				CONF_RESOLV_CONF, &error);
> +	if (!error)
> +		connman_settings.resolv_conf = string;
> +	else
> +		g_free(string);
> +
>  	g_clear_error(&error);
>  }

Cheers,
  Jussi



On 8/30/22 17:36, Daniel Wagner wrote:
> Hi Jakub,
> 
> seems there is something wrong with this patch:
> 
> (connmand:3947): GLib-WARNING **: 13:14:06.270: GError set over the top 
> of a previous GError or uninitialized memory.
> This indicates a bug in someone's code. You must ensure an error is NULL 
> before it's set.
> The overwriting error message was: Key file does not have key 
> ?ResolvConf? in group ?General?
> 
