Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09F2FAD
	for <connman@lists.linux.dev>; Thu, 19 Aug 2021 12:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+2X6suZXBNuOAGTnwB5Kjba/q0Cqqm9hZjg615Bkww2Ha8KMNaOGz5ODIZ7bEj00fZeozvcjV1ZiCHOGFzDlF+cjipaQZ+C0ZiSTnmL8yXA5YFoFeWuP1h39elge7X/ITlEjEhKY5y1xR1VHic74DN+1P2xwuk4JVq1zrz2qdpHKx0QfYzCAaLvdz2LVaCAmMp4bCTcZq0lbOzOjJcN3a3YMvYu5a36Lvf6UMx6ZhBnh56M/OUJWtskZZLvU8WZHhnO9HlTxnfSSDIagYNe+xe5iHSMElqnjzFQJLTvhlzMfBx7ZgJMs/W3emewR/p4Vd2cY+NTBKF7GVtzm8wjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT6BLboAdOrhiyjyCYy0z8Klo0qdHvbaT0RN4S68n74=;
 b=OSmGQrI3nBWUJ5bHYUU1Kjx5g31DYnvW3yJBuOU4UjEta5U+JA0J+XJX+tp6Q9nefIjciiNAeroAFrCgkzrk45gYUebb4+Pfok3Wiz358nw49teA/tdkW+4jj+YCVuoZKmlUOH4XMDDkm23yOiUwqgA5wleq6ZPVKdfQ8qKRnyMRNOILVJ2NLMZCG8gPS0FNONtXrPMJWJkmcy585iA8btCTXx5+xv710+Nb0b8UXb32bmRTGKkr2QXbY323BxRYKpDS4rq51IQRqex8g1JcstkdVt6sYBSTqtaTEVwAjjxPOBeMLbcci/w5cnERGHc6XiSjKHU/AgVJJo9BtqGrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT6BLboAdOrhiyjyCYy0z8Klo0qdHvbaT0RN4S68n74=;
 b=XgNPl/PqnjU4xkDU3rpEr92/nppInaByeuh4SBRT5cjE4t84KfgNJ9sL64t6XO7bSaVnKOxhKSiYFCfjeW8hEhb2fr7gce2heLT6pThr+c61lQreDYBReShHrooKDVhxqzCe+nuLwv/QBiFVFvt4AYuJMX4ZuAY6iaMRBSYWsw6Q3p0017WiA2n5BePCyicjlKKkL00GEs4u+xGREe9cSBKJHlz5mp9CGKXxEeIilIguAkJEu1pltle1JzLkbKmy0ltRYn2brQ7wEiviFQcVZNzQPUc2LtAOauLjQcixWZB0RlAPCx3BAhqBHqh/RuErRrNJ5wrpNA7iV4it18zNOw==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0601MB2300.eurprd06.prod.outlook.com (2603:10a6:3:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 12:40:05 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 12:40:05 +0000
Subject: Re: [PATCH v2 1/2] vpn-provider: Implement connmand online state
 checking
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210818103137.17409-1-jussi.laakkonen@jolla.com>
 <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
 <20210819123003.r4sqio2pquco5qph@carbon.lan>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <5f76dcbc-8e93-61fe-8d7b-6b0aa7bcb786@jolla.com>
Date: Thu, 19 Aug 2021 15:40:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210819123003.r4sqio2pquco5qph@carbon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0086.eurprd07.prod.outlook.com
 (2603:10a6:3:64::30) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.2.6] (194.110.84.61) by HE1PR0701CA0086.eurprd07.prod.outlook.com (2603:10a6:3:64::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 19 Aug 2021 12:40:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45181414-c646-432e-e375-08d9630e7895
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2300:
X-Microsoft-Antispam-PRVS:
	<HE1PR0601MB2300147B7B4EB1638CA906E4EFC09@HE1PR0601MB2300.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q6BI1BSSf73Oh+kgPToim4dGg7rSgShldm04aKoe/DH8nFY5uZ76bqDgbX62ZMj1big3xgcWZ9bAvcm+gwfReALJFlmhqDLuqm06hvwWt6urWtojFhyCab2k4dKbiGeCu1Z3RqBSA8mxA9bB2S7cQ5AZuRO6uBwG12XdxGGa0ZSBbdxmkr/YEYqzn5/V33e50oEeEn7ErCgzLLlHvwsxHVlxpYs2aHEn7BKin54xCqPWDzBp4aFiIGKt8kJQRusMzFMdztHQseOy9oXezG07n+NwnN9VmR4qhArbEbpA+fVEELcBRLgSfQ2nTqRA73S81t3g7CJqSU/Xv4MXp5cRXN+N4eEk6LkF7Xcol0saIsyBH5IH2AmWdo84xefC0UWiHUGFClo/7G5N2e9UsH4zG5Z+jBsUk48D1dxX1T6c/B+XajXEphf34Ljk4/USAGsXaR+UrcNhxcGUlMvbXNfRCOZe4BEpQ/1ebnJcj4JwXvd8UeCRD7E5QSwCwflAWjb5ntT/kxD93xvYzU8A5N57r7mnU/UHKdIdRSgdWLFUAwYNnXjmXfEjoSN1QX/ZUivUPKd3kCmqlHoA16mBrSXE8v3hTIUdLg8ptIFTs7X05r650lZtvc+5YX/0idTXj3SmhngueTOtiL+Aa4D9WTQAQvisAtrKG7kA6kZFNnJyq0uGr3n9eLRZx/tLMB1A9bkk9tfVyCnJXiFgjborDU7aZ8hC78Uvb6Ws2lc+mGQWUtzSdaPeaGRNsLTyOTS/23zv54OCKhpyC9wJiapf7uoC8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(136003)(396003)(376002)(346002)(366004)(8676002)(66476007)(53546011)(2906002)(66556008)(31696002)(186003)(66946007)(2616005)(5660300002)(478600001)(316002)(16576012)(6486002)(31686004)(52116002)(956004)(36756003)(6916009)(8936002)(4326008)(86362001)(38100700002)(38350700002)(44832011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0FDajl2SXNjZzNsaTlNTnh5TFhrM2Y4SncyNnBnd3djaGRQQUJld0YwaW5h?=
 =?utf-8?B?NFBlOU1FRklKU1grVldHakRuMTBKMTNsNHErZGJISUJJc2NnTDJBZHRJWXJh?=
 =?utf-8?B?RzVwRHR5MnovMFJGTTJsVENvTlhDMzZObEt3dnAzcDdlcUxicTd5dHp6MFdi?=
 =?utf-8?B?Q01PNVFsZGtZZUNhNVdFbXJDV3lYczErK0ZaMEhQYk0rMmhZTVdtZTJ6bjd1?=
 =?utf-8?B?cGRRYTNZVkVrbmNtaHZRZnl0K2dYamcwNHo1cUpNb2hkbUtUZ0p4Z0poakgy?=
 =?utf-8?B?eG8za3dEazkzaVRTRGxyemlmcjJNVDNoNjZBV1FOOUhMaWZhRkZpdStob05K?=
 =?utf-8?B?ay84NEE3bmVTYkw2blZxaDlLYlNKWjJsb0FmbUJ4cDhISDBiKzk0elBKVzBk?=
 =?utf-8?B?WWF5bC9NaWF0aHI3Siswdno0cWNXY0lMYjhEWEF3QlhvMUM2RU9DU25CRWh1?=
 =?utf-8?B?WGxCUTl1ZGRHd1NlcFJ6MXZYRDhqZjcvZzJUREhTZmlQWDF4MlN6UmFTTTU2?=
 =?utf-8?B?czEyVk9LRTVDeFpqcFFOQUxDNFhTUDhndjlMbXpZUW9VZ3dyaDJzQU4xdEVI?=
 =?utf-8?B?ZkNwN2p6c1kzU1dIVTBaSW5mUGpVZURXMGowOEhYblNMTW00bWVNVWhOSW5R?=
 =?utf-8?B?UnJIM2hEOG1zbXJ6b25TZDd3NzZkMGg4dTdZV0QwTUJlTEIzZk5xY3hvTXov?=
 =?utf-8?B?Qms4UTNsTjlLZW5waElXSUlZNlNjazZpbElGZnF6TXI2c2RYNURpTFZraHJ3?=
 =?utf-8?B?SEFieWNDRnhxOE1iRGEyRit1dDlwd2RTYnFqckVrZlJjRXgyaEVUaEN1YWMr?=
 =?utf-8?B?SXBOT2tQZGFhMFJhQ0txUEUwaDBycW5qM2xzaGJjWVFtUWx6bmtxaGlOamV6?=
 =?utf-8?B?UG1zeWVNSGE2bEZQT3V2Ui9yRTVPM24xNVpLNEdaaDZPbmlQOHRWK051cTNo?=
 =?utf-8?B?aVpMYzFFWDhrRjNHR1h6UEk1dTJkMUJuWXpLUFhZaWZzRFA3dGNyUlFwRFNV?=
 =?utf-8?B?UzZka09naUNtcDMxK1p5V0Q2d1g5Yk5Ua3g1dmxocW1TL1UzOW1GalBYVlJw?=
 =?utf-8?B?K1BxY2Y5VlpjUXlMNkVMR1JVMVZwVDJQajNxTHFQL0JucHNIbCtldDQ0YzNC?=
 =?utf-8?B?ZDE1Ymg2UHFPQVN2VUNqSm5pd2Q2bStUOHYvYnRPVktTOXVlTE9MTmRzZVdB?=
 =?utf-8?B?dUJrelpNNGtvR2wwcDhhUnhocnRXSkNmUm9kdHVvZk1ITDEvOVpKTlZWWkVo?=
 =?utf-8?B?WWpGTWpEV1FYcUl6Qkh0R2JxMmNMcUp5V0xmU3VWdGZJc2xZdnVmU1FTcm1M?=
 =?utf-8?B?WGV1Nk9kaGQvL1BBaDNLMHNsa05mVExZWVNxMGVzaUhqWnZiU0xvQ2UwSjdH?=
 =?utf-8?B?cnhrQ0UyTG80dXM4QmtuN0pvNGRiOWs4VTkxeTN0NzU4L3ZBTGFEUndockEy?=
 =?utf-8?B?WXNadzd3aWc1elh5Y2txaDBWQVpBMURtUkRldkJDTm9MYXZEdytUV3RaWGMy?=
 =?utf-8?B?QUFySllZMGxLK3NjZWpmd2c4YjVmRTdYY2RVazdZa2hhSmFCU0h5Um5acEJO?=
 =?utf-8?B?dUQwNnM4cGordWJsVmd5S0hzUUVsSmkwaUhwRStDcTNQRThYeGNMR0gwLy9Q?=
 =?utf-8?B?YUhpQTZlZ2ZweWEvWGhkV1FlUXYxNEc3TC9yY1lnTTk2dXhlT0VoVnFVVDZl?=
 =?utf-8?B?YzhINWxtMTkwMGRLQ2lBWllObmg2NjBCZ0Q5dzFGbmRFQzlpM1dvSzU1aXZp?=
 =?utf-8?Q?DDnorbSnFUOZIvhPjkPZja2ojJzs52JS4Cpp39X?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45181414-c646-432e-e375-08d9630e7895
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 12:40:05.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sdf6qEKGkhQTmnUlF2Ht6HpyJvRyHMWxpBOzX/PYqggonJZvKR/7w8PfpysalFjTAL1CLfK+01B5fgNtjpDXiCCv3tlMUoyxW92WEBNZ8as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2300

Hi Daniel,

On 8/19/21 3:30 PM, Daniel Wagner wrote:
> Hi Jussi,
> 
> On Thu, Aug 19, 2021 at 03:11:21PM +0300, Jussi Laakkonen wrote:
>> Sorry, I spotted some error with this as apparently our fork has something
>> again done differently somewhere. I'll send another version when I find the
>> cause. Does not seem to function correctly on top of 1.40.
> 
> No worries.
> 
> BTW, the question on the busy loop. I am pretty sure there is no timeout
> involved if you just return 'continue'. This tells the caller to queue
> up the callback again without any delay. At least this is how I remember
> it.
> 

I'm fairly confident in that the function is just returned back to the 
normal schedule when returning G_SOURCE_CONTINUE/TRUE.

But the issue is about VPN agent usage actually which is caused by the 
different - and quite possibly invalid use of VPN agent in our case. We 
always have an agent connected so that is our OS specific case which 
after all these years I completely forgot. But after checking with AntiX 
the issue is completely different. I need to dig into that again.

Cheers,
  Jussi


