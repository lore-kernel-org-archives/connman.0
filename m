Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF2374
	for <connman@lists.linux.dev>; Tue, 30 Aug 2022 15:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUfrFr4iowzZIzD13u4ILn1FOItdZEejC9kcwroDzd7Ib0SBRNgK+hN2e5CE4L3KnaK5nyOzTsrM++rvxmVkFowjea7f7kQzzfhkVcDwCpQUVoePfAFf6PyIFEckx2EQLG/3tqqXY+oEp/2zZaKdChinXQSMrtrflHN4ECzrMFXa385ejMK9iu6XZRI3w3uSKame/+F+02/0A1Ogfv6laEQqn0q1j6XXCkV9Ny/WgNoiB5AMkkcpoK8bWN2wlek4OeCWWDbthw0OBFKS74w7NAe2mnsOfJogwZLH5MGUpl83JR8ApD59Vd70PeIb6ROUbVfVcy5SPVTnufng3/KzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvI0KEirjU7+j/p0SkrL2usfS3VuVfLjcNEzF2Fq1Ic=;
 b=f9eg7y2uKQYI7NJyizuGYOYA3M3AcZMNbijkxDjIWj22Mc1eO9ErLoW5wEmrtf951wH9O5XYw5GLbRCrhh+7LSTh1Ret+TdGyyes5LByAS05QqSPFKI7rZT3WPVVIsIdzVPXwTBhCxUvgXz/te21gSpf/QHn91Sb/2JwblgC46usrxQzl22YUqwfxs44065B2yvFyyg+eVGxjBSnbSc2mgTYVzcREoaF5OdRGHkz2pDmvSbpY1lsZ8Yd51+oYV/vDGuGnJoU67Kk6yjTgOEGzvmy0XTj6qNfhvluPhZj2YaxnRgkZvR80uw332V5TUjGMcFraubPfo+l0PAiVSt6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvI0KEirjU7+j/p0SkrL2usfS3VuVfLjcNEzF2Fq1Ic=;
 b=vg6JXWFMw+OqNwufc0zD6yBy5cZzOcGSExWHOp2CtO8316ne1NRPcfqwxOtSiIgK0Z0+YUxBU9UIVKt5jeIMzY9H8fIvzZs/6P23ml5Apvk05ujFAu652HCn4xB/GMybaUFkpEhIxhUV441VO9YjDqR284cw9yg3cZoYUwB33S5/uGoKzlnxJHtocCfmdo/hZ9ZzmBCoxb1G7dTmZdX8kUrZjFJdndrAQr3uqT+bxPojPu0f/a3WJ1Qx8VaoMoUUdYf3KUJanANyNYdYstAsKXirfjqAcbsSYw3D3By4GZ+EmDyRWaCVtFGwYPl8j4EpxcjUmzKk2fRE8Snx+WQyQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0602MB3484.eurprd06.prod.outlook.com (2603:10a6:7:89::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 15:07:26 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::814c:dc92:67ad:eedb]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::814c:dc92:67ad:eedb%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 15:07:26 +0000
Message-ID: <9a0c9457-6d84-9702-5622-8aa72d18e352@jolla.com>
Date: Tue, 30 Aug 2022 18:07:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] resolver: Add path to resolv.conf to config options
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: Daniel Wagner <wagi@monom.org>, Jakub Jirutka <jakub@jirutka.cz>,
 connman@lists.linux.dev
References: <20220615165350.11431-1-jakub@jirutka.cz>
 <7d291a8b-712e-50a5-041d-feeca49f9d4e@monom.org>
 <f4b37626-00d3-19bd-d667-d820db47a35f@jolla.com>
In-Reply-To: <f4b37626-00d3-19bd-d667-d820db47a35f@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0401CA0118.eurprd04.prod.outlook.com
 (2603:10a6:7:54::47) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77fe840-8c06-4110-44a3-08da8a9959c3
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3484:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l9824J95UnOHVsdSAkdjbT4mzajzemZaOlCigl+AqWic90Iic14FDyRbR6MRzgXFKB5VyXzU9Li7pmJNFttY3nNknKKTTLp136ZKrU6r8rHeQjXvGcKHjAGGvSi4rmt+68+NoWbUndlWmF2Kaz5DnI/LJSYzrg4Ap9d/pyxGSg5Dla5yY9ImI2ZbFmBqT/lmo4hQFQGp4o2kCHiFBxPcSx7WYVCI0ECqiZpvXHG+nLdVEWDc1Mo4hr7d3iMVPTKp2a1zlYLg+WDCE8SU5+SwY0AAESmKQ5XbvNfaqYARok/Gu03FVg03n7nqRNMy7jG+d6pPSWxLW3uxOcUKPbjXceRqXe+pi4bGaJ8ur4l8r5bMLRDx0sdtsEZAWYyFjh2D6HahNrABOmmpZWvP8QBP533XsqE6L9N290RqnLS4sD+bUeiZq2ueXqmQ/ys81zs/KR4c5n5N2hpCXqoX0/uG9NoA3OAMFNnx7QNO1L7hDYiILHhejW3lDNdMz8/n+z4Nlp520Q3s9RSq3178X5vN9Xkv7TSIxubH+/0A1JOwgJMyf6txp1QZertA9INR6joh2P01SwaTtpha7IEiguWN6C9W8DThCAQTrihEGtLR1tJV6M89itZRC0uVdVmphEZlAiKTPvChxqvchpQOHRhqZA1dviWVO8UC/83Dmrc2+bmsAR3fUCrvnLeeETSCorvFP0HLMa5YjNKzlDif0nMiB86SXx7PmVUXvmIG8UaIwMEQOZNzJsGL27zs/ZGvTm37iyhUbYeg9ylg//EizDOR/pg6J0SwdDQGtrl27S5yKdL880Jx+HJdlEKw96LNateOR9S7Sn1vp/MEHxpjyxov5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39830400003)(396003)(366004)(36756003)(5660300002)(8676002)(31686004)(66476007)(66556008)(66946007)(86362001)(31696002)(38350700002)(316002)(38100700002)(83380400001)(186003)(52116002)(8936002)(478600001)(6512007)(6506007)(41300700001)(6486002)(26005)(110136005)(44832011)(2616005)(53546011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um9XNFRjS29MS1dDREt0dldRRFZJRk40NGMzdEVPamVFVXhtS0F0a05IWUlH?=
 =?utf-8?B?ZC81L1pQMnJKRG91bm84SWQ3UHI4R0dQRDZyVWdxajMzVnN4R3R3Um51cjBz?=
 =?utf-8?B?cWpnVFFyY3BqZDV3U2tDZkNuU1dwdlp4eGtvTzZDaU91K3NMYTYvS2hPVlND?=
 =?utf-8?B?NGtQYitkNytpVEl2MThYN0hTS2VYSEJ4RjN3dkwveC90WmNDUFJMVjNvVlE3?=
 =?utf-8?B?V21VK2czby9nMWJaR0svK0xJV3dkZHJVbE11ekNyZTkzVlNhTjE2ZTFKajhL?=
 =?utf-8?B?UUJNMklqZnlvWXk2cUEvQ3FQS3l6aklDT1MzUncvWklOYk4yZG9oMVNGVm44?=
 =?utf-8?B?VDhkMWNocGVub3VUUUE1eDdkT3dUVDZ0emI1QktNNGcxWHB0enh5OTFqMG9u?=
 =?utf-8?B?ZnFKTWRwR1lLUWR6VWRLbVF3bUZnSmNwTUxjdW1hdFpLbi9FUVNJZGJBY3Jm?=
 =?utf-8?B?WjUrVVgwclhFMlZWZ2hGNXJyWlVxUXVYZ2IreE9tWDJVV2hLRGFBZ3RyalZt?=
 =?utf-8?B?YjZBVzJVQUtONjFGTUgwTndTNUgyMUYxSTExMlVPemlkOGlyZm5OYnF6YWQv?=
 =?utf-8?B?TDNKUGl4REJJNDhHbGNzSW9yd3lrSE9ZMW5oUzBQak9qbFVKMGdmaGQ5c2Rt?=
 =?utf-8?B?aVZWRjkvOEVzNWZRWmdEcmFQbXpBRnA1QUVhV0JrOXduVmt4bmNHWERaSTRW?=
 =?utf-8?B?aWh1aHlEQUo0Mmp2Q1JaaWxKTUVlYkM2MlliREs4SDh6alN3VWFrOE1LS001?=
 =?utf-8?B?YTZkdCtkTUNlUU05aGJLbVFBVHpIQ01jcG42SGtidVFuVDlJZ2tVRCtGSm90?=
 =?utf-8?B?R0RrQUNFcFZPTUZnQVdZTENtVkM2dFI3TjZFOURNZThENEM2Ymh0WldaWGV4?=
 =?utf-8?B?VUlQVmRGVFMzL1IrMCtiUXFnOWY1K0srY3gwQUhJbnUycWY2cTNtNE5EdGo5?=
 =?utf-8?B?ajN0UnRTcXlENGhVMjNzako0ZG5JZmNJcEF2MUcyV1lkREZyRmY0bkRzWXNa?=
 =?utf-8?B?REVqNURWdVcwR25TTm9aSkR2ODdWLzRUL2xaOHR1NEI0N3lERGMyS292bTM2?=
 =?utf-8?B?WXJ6VnEyYk9JcktLM1R2UzF1QjZKV1ZNTkI0RUtnSnkrL09sNEs1UWoySlJj?=
 =?utf-8?B?dWpaMyt6b09sWmI3bWtNY0V0Y01nd04wQVRTMG9mN0VraHk2VUpRckJvdGVZ?=
 =?utf-8?B?M1VpNXFEYUtaUmVwR3M3R0xhU0VwVGhibk02cGxyQTBxa3BINnhYeGhpaTRR?=
 =?utf-8?B?T3pNR2tVNURUcHJVcHovbUlqSk1JYnJqQ0JhaXhQbExuSlplVWhiR2NzYllB?=
 =?utf-8?B?dEJQR2JPM2l6bXJXNmwvN3dtM2oxZC9ZS3oxTEhQKy9pWVh1TzVtS1RSdnNW?=
 =?utf-8?B?MTZ0d05UTGJKdC90TUN3N2t5M3lndDVvekxDRUJFRVF4TkdSZDF3UWlTSWlN?=
 =?utf-8?B?QURUSWlwYzhKSHRXWlpERkUzakYzSXlHTm95RTVCdkJYL2NmcEdJTHgxVG5w?=
 =?utf-8?B?MTFacUtEdFVjeUJXMXFTOUlQajJHbHE0S05nNDI5OENtcWV0aFAxYjlXRWVw?=
 =?utf-8?B?cUJMWjhyTFlTbVJBRHljdTIxWWNLbmFoSmZ6cnFWalpqRGZwL1lUdGdIc0hh?=
 =?utf-8?B?ZjJQZDdtTGdjMWU0Ny9jcVNncDYyWG1GQkp1U3A4WVB2N0lBcUUrbUtnS2NB?=
 =?utf-8?B?c1o3Y1pNc3RCb3RWKzZFeTc4bkVIMGhzYlFLVDBpWmRDREpOUU9tQXBleTJv?=
 =?utf-8?B?azZXb3dxS0pRNjMxMWNmWXNFc2ttdUliTzRWTTJneE1FcmZIZmxqVE5NUzRn?=
 =?utf-8?B?TjRjYmhYeWtBT0ZESUVIWmxPdkVYdW5EVEJYVUxkc0UrY1NjR1pibXcrWnJB?=
 =?utf-8?B?VHlzbHNVakJyVlI1SEszdGYyQURpUFd2L1o5VGRyZFFlelVWWVZ0cUxLOWN6?=
 =?utf-8?B?RXdJaG55SWtoZ21qeVRJZGV0NFdJVUUyV2JNblBBMXJySlBYYjRtYUl0SjIr?=
 =?utf-8?B?ZTByZ1NLV1BldFRObW9wZERUVE0ycTM4MFBjaUJROTJXRmZUUnRtVWwwZnA5?=
 =?utf-8?B?L3lFTTFKOWQ3cU56NHgwWEhOOHJtOVo5Y2V1eCtqUzRsMTkvTGxPandaZlkz?=
 =?utf-8?B?RXBoOFhpbk1LbTBoYjN0NnltTEg5a2dlZE9kcm9VcVlPV2FOUndOR2lTbGlz?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77fe840-8c06-4110-44a3-08da8a9959c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 15:07:26.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFqch114BIogMSdzuzR/K87hF5BBbJLKrtAwhW8bPpuXtcxAaR9QMWM3KpB5BXgmqw5rAWmU+94eYg8fBCh9UdFj+gEjnpkf5mID5jWGCQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3484

Erm, g_clear_error() I meant.

  - Jussi

On 8/30/22 18:06, Jussi Laakkonen wrote:
> Hi Daniel and Jakub,
> 
> Just spotted this mail and might this need one more g_error_free() call 
> before the patch code:
> 
>> @@ -594,6 +598,13 @@ static void parse_config(GKeyFile *config)
>>      if (!error)
>>          connman_settings.regdom_follows_timezone = boolean;
>>
>> +    string = __connman_config_get_string(config, "General",
>> +                CONF_RESOLV_CONF, &error);
>> +    if (!error)
>> +        connman_settings.resolv_conf = string;
>> +    else
>> +        g_free(string);
>> +
>>      g_clear_error(&error);
>>  }
> 
> Cheers,
>   Jussi
> 
> 
> 
> On 8/30/22 17:36, Daniel Wagner wrote:
>> Hi Jakub,
>>
>> seems there is something wrong with this patch:
>>
>> (connmand:3947): GLib-WARNING **: 13:14:06.270: GError set over the 
>> top of a previous GError or uninitialized memory.
>> This indicates a bug in someone's code. You must ensure an error is 
>> NULL before it's set.
>> The overwriting error message was: Key file does not have key 
>> ?ResolvConf? in group ?General?
>>
> 
