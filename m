Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AAEAD7
	for <connman@lists.linux.dev>; Tue,  2 Jan 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="S4c2/Aj7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4eHYCoyvKVKMD1cjEyyWlcx2y0B54ASfdCfZmUoAFcDfg7AXpWj8Ms8TCZVlIrM6sZrUH7MSCvxr1Z+gSJ8sMbldwv1ztcoMtBnu78bJQmiENxvvN5cSapNno1ORwD2IDdV+mGBOOA5CD/GnffzOqxQxH0okKoxCPiKt6jy9kCjEBvg3QPNkbvHbULUqzLW5obRqBxaiXiC13t7T1wTn0MKntIm9GIxWU7UGlSjXr1Fj2XJKzPaHTQV/VHo2iBMUga8ulR9/G7vzFIGGKJ/WscL5rUSvOjFytbTTuUAP0zVSFGmXCTBFpxYwXTezpa7HiQ22dK+G7wdq/sBWMw+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzjF+z1oU9c2rCUNJyQRrdlkHXBkR1ZJeGVtvcsgkbg=;
 b=FnKGOWehGUW292zhNCrHc10Bk+oUpahVFVMKn+zQUqpb2Be+Pp8lWylUhmvEUO1YXm1djIu5oN5RpjuomUolV1AVT1MvO4Xx8K4eKQGi/lDCpVw3VfMvDJuLQXIx7QGZwMWoEe7OJch5cyTNdWFFbu4bOYlOVXRuxGUZ4JjKRxPGQH7/5ypJIYjxvVHF9cKmQ19ArpH1laO4IWaqRy0TCq6JvKT6OZ5XUB6FmJZhch0WIBM9Z2VKA9k2vg47ZZ2m6eyWAX4irDjEr/fREenjowe5wmRWz47hvjraxs9fcnwK7sf7PhXwUW1Um0k7N59dCwH2NHVBtFwnboS4x9vUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzjF+z1oU9c2rCUNJyQRrdlkHXBkR1ZJeGVtvcsgkbg=;
 b=S4c2/Aj7Kl4tkBiCPEsAcEuUI19DyZ/sTiKqUxXzqHGfNqdZuKw0skIDoRoU4ykrKtaKE9izQaipADVDdYs4FLquKXEzBjj5Lioez7JWMAG9brEl/H4glnPjl+CWmyjSm3Af5cVqOVs8sbgvW1odcRjGvHj4zfRnxqB3P0D1g3R2OpaE7DOBMcnruY6s68xU47A68m8fB62WZC60pSgg0ACbk3aVb0JNTP9L+3AM/FozAWY1+1j6hkmDwPjz/u7piM3ANTTPibZWc3q1dGcffiM9Hc+LCbiZpht4zA6nHiWLCVBjOK1V1zumve+Be5EdHxdWz6zW/npkVWvRmb4zXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PAXPR06MB7376.eurprd06.prod.outlook.com (2603:10a6:102:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 11:57:09 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::1a8:462f:5146:101d]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::1a8:462f:5146:101d%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 11:57:09 +0000
Message-ID: <ad84aa34-f467-4589-82e6-1bdd7a2a867c@jolla.com>
Date: Tue, 2 Jan 2024 13:57:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] connection: Rename 'connection.c' to 'gateway.c'
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev, marcel@holtmann.org
References: <20231213200001.1994492-1-gerickson@nuovations.com>
 <93ee2de3-a7bf-4a43-9893-799af7bb97aa@jolla.com>
 <1857CD1F-DCD2-414F-B0A7-7E167242A058@nuovations.com>
 <d6dfa0ff-202a-49f7-b097-f098334764ce@jolla.com>
 <496375AA-E120-4C67-8253-A5DF4DD01154@nuovations.com>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <496375AA-E120-4C67-8253-A5DF4DD01154@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00011B61.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:14) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PAXPR06MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dd67d2-56e0-4e1f-246f-08dc0b89f2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CJTvpv3l/DxzIZxFt3YDhh2Rk8Ru3HaZe6Hrhe0h+wnYR+ryEQa/T7nPaZdxm0CMpxy2dhmKpoTM8VmxuRdsgnV/W88Sa3skJ6HwhA61oxC91FQ1jrVERNQYtSpVdc5gw48fbkbCxQxWJIQ+H8WdBHKI4YO7dDtrW6SHvB/yGBn14c46psg7icz/33fXAPoc8ntd9ZiJaSekawEQt4o1sTI3g/CkV2LT/nPVLeYhGRhCumLsCr3P+4WEX7LZbgMFqrr/wZTqoZTR4IF3B8Fm3BleLJUH+wmIwjp3tnL/BueVptMx0Hu/Psd16BHi+gxCuTOq5sJQqNlv6bp2FyRHcxLLAfSw4MvWq55OfxEx4bkXxG2bAwYH4rR6dbYxn/svxavxgYudGolWvK+k0dKaTVrp6kFfLY6fwmBvL/m9cTPPBzsBjuvIW478+zh1D9eRX4JLPrYM6mgs0SsorgxzyH3YfJrLzfBKs2R7syXX33LFKYRd82UzUfYGphAF9YqJxhaEZc2iRoZjlNBGWeukPt2F7nNNsqyvZD/SDpg9qMSUk8VY4m4qP57fyBH2Rd2Uf+1pw3+6JqLlJH2vjMvUZMRMcIMoA2Dov4f5M1MiAHyVKBoD9eMMl5zk1cy8MITPY3UEmlW7RNDpiRo4VYyhZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39830400003)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(66476007)(66556008)(6486002)(4326008)(44832011)(6916009)(316002)(8676002)(8936002)(2616005)(26005)(6666004)(83380400001)(478600001)(966005)(53546011)(6512007)(2906002)(41300700001)(5660300002)(6506007)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzRFbUxoVkhISXhBbkdkdUVNWUVtTFd0VCtEaGY3a1FyT012QlZobUdSUFhM?=
 =?utf-8?B?ZkVyaGdTQU5IVXZEZUltRjM3MnFaeU1mMUJCWUpaSWFSOVRtTnQrdmhVRm8z?=
 =?utf-8?B?QkpIS3pPbEhRT2JxRzBtSE96Vm9pRDdJMS9CMXJLZE53YnBtLzZnNGtaZzNh?=
 =?utf-8?B?bXlmNi9Tckc2QnZsdjdTSHRQaVZHdC9CL2I3cTJJSGhRK2ZueVNUWGc1Tkwy?=
 =?utf-8?B?VEdSR1U0R0FES1V3ZEVQQkQxM0d1bU5zM0hiSFJIUzJXS242YWFTaENmZVpk?=
 =?utf-8?B?eVE1WEdySEVwZjZ0OWxweEtMVXkrSVdlRWxoZ3hQeVhJK2NwRWpzMzI0bWhs?=
 =?utf-8?B?bzg3OEc1T0dnOEMza0RoejdZazJtTFpOR1ZNZ3IzcnJtZkFaNURZRno4aUxi?=
 =?utf-8?B?dThTSHd5dkdraVpGdnlGS1JUbEJlUFpYVXVjN0pFSE9LeUlBdXF1TXE1ZHdO?=
 =?utf-8?B?azM3OTQ5czJQWEJqWllMUnZ1VVBmZDliZWNFbC9jZHh4M1NQUzRERFNNa2Nr?=
 =?utf-8?B?UDNTakttb05ScHRnRXdoRHRNUUpXWW9tMzZIWDg1bGJUNWQrNVhLMXc4VjM4?=
 =?utf-8?B?bm5WbkwyaTk4UGt5S2oremxpYytuV3VwU0lycCtqdnU3UkFQWkMyQjBhZ0tl?=
 =?utf-8?B?YmlJT3dpWTFLK202cjEvdllVVFlHS1g0YzcxNlQwOVNXcVU1VDRoQkt5WG1F?=
 =?utf-8?B?WW93bXkwN245QjA2ZUpBQk9PemZRU3ZlNXhPaU55a0gyWUdVZUlCMDMwMGRx?=
 =?utf-8?B?YjJFdjhOc3lUM2pQOTUvYVVORjZ0RUQzb3ZOV09MUVhaUlJGdTRUTmpHQlNj?=
 =?utf-8?B?aVpHMnI0YW5uM3FIS2lxNnV0YWg1TGRCakFKaHlldUNoS1NoYzdRWVpHOG54?=
 =?utf-8?B?Z2RqVzJYRi90OUZYS0ZYdnpVWW9MRWxOZWhvREFmb1dmV0xHSzFycXJKK2M3?=
 =?utf-8?B?T252YlpheE1IN2ZLVC9KQ0c0M1JKU3hTeDV5amZKN21LSnRmTVAwTVFRNzNR?=
 =?utf-8?B?WUNqMDlhUk9RQmhselJTVVBLTTlROVZpNVlEZHgrTUl1bUxNdU9KWitadTht?=
 =?utf-8?B?RzYrTlJ0VW1DaFQ4YVJvb2lkWDZyazd0aUM0M1BhRlZqeEEvMG13MGRXOGJt?=
 =?utf-8?B?NVdsTG9QUjVqZG93NEVPTlVCVGxNd1NjNndVSHlQVFVVdFI5NVNmblJOeER2?=
 =?utf-8?B?V05hWDdDUDd2UmxsS1lyTE1hcTE4QXZCbEVicmp6ZnlQcVhYTFp4TXdvVzR5?=
 =?utf-8?B?bHZycVJmb294QUN0OHhqd3MyRngwemFJZ1dVcFJ5MVJ5Sm1vTmJtV3dnRVRI?=
 =?utf-8?B?TFlhM0JBYVA1blRTN3V2Z2tsSDFNVEZaMXB5NGJ4MXZEb3pMNW93eldqV05Q?=
 =?utf-8?B?dUM2cFNpbS9ZWlY5a3hqT2Q2Z2dXY2RVUDE1Tzd2U2I0citEU2hXeWxCb21O?=
 =?utf-8?B?TVdaMkhGdkY0Z1cxOUFzb0lnb3FVVE1YaVBrT0RYRHJYYkN1N1RncFMxLzJi?=
 =?utf-8?B?d0VqV1VuNHNNWEhWZW9yVVN4cWNWMVU2V2FnU1hOaU55UjhtN0VVbC8zcnR4?=
 =?utf-8?B?T2FKaURFNmdiU0tlTDd4dll6aXpyQm4rYm52d1BUNzlqR3lCZEd0bC9SYVdC?=
 =?utf-8?B?dVBZVVNMUU40eHFsclhJV3J3R21nZGNxNVgrelJyVnZZN2JqMWY1aGtDVjV0?=
 =?utf-8?B?Vk5STWFNR3JuR1ZYWGk1MTFhNDd0My9GMDRBcFpRQTJrRmc2eGZnc0xLaXZt?=
 =?utf-8?B?bm1aMjFhdzZsUzVXdEhaampqUXlEOHZLdEE3bkVuakptMWJlYkJlVERiTEZs?=
 =?utf-8?B?Wi9iWTgwdHp1QllXZmhyR3hqRVVvUml4dDJYTWM1SmJERVRwT3c1UkNXbGJJ?=
 =?utf-8?B?WTBQYmpSaDdCZzh2UTVKRHZrdk9TYyt0ZVBWc3h2akY4SjJGc2t0K0hmUnNq?=
 =?utf-8?B?VzlUZXM1UlJKKy9FUkFyMGM0dEl1dkx4bVpIN2VURlZHZkdFVnA2d1AyRzFn?=
 =?utf-8?B?OGczei91WVZyYXRmdHNHTXhTZVdjSFQwai9pcVNXTlpRWXdYUXh2UmVuMEJu?=
 =?utf-8?B?bkN5VitaUisyOEFJcU1PcW1aaUhZMlUzT2p1S3hyRi9sQWlvS1BOa1F0Smtz?=
 =?utf-8?B?ZThVbVUzWHdVUHFxa2RQci9QOWxpNjl1eDRUSzJkNlZMTlRCa1Q5azdHZzdB?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dd67d2-56e0-4e1f-246f-08dc0b89f2a7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 11:57:09.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgxfIHwhRaFmLomZi1nClbnv/375e6YohTPKKL5NPFkMIh/30KxEIxqFFqaQayZcKQLtjDE8ygj1Tvi1gU+NVbG2OwBW+5uiCwNieY3sISU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7376



On 12/22/23 18:24, Grant Erickson wrote:
> On Dec 20, 2023, at 9:10 AM, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>> On 12/20/23 07:53, Grant Erickson wrote:
>>> On Dec 19, 2023, at 5:32 AM, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>>>> I'm not really understanding what is the real benefit here in renaming connection.c to gateway.c. Granted (pun), it is more clear name for it but it still has some vpn-related functionality to get the physical device index etc. so it is still misleading.
>>>>
>>>> My point here is that this just brings a lot of drawbacks:
>>>> - It is rather complex now to apply patches from older versions, forks or heavily patched forks to upstream that contain changes to old connection.c
>>>> - It is really not straightforward just to pick an upstream patch made with changes to connection.c into these older versions or forks that from one reason or another, or like million reasons, like with our fork, cannot just be updated directly to latest upstream.
>>>> - And the name was there for... 15 years? It really hasn't gone through so much changes that it would need to be renamed from my opinion.
>>>>
>>>>  From my perspective the simple SWOT analysis here would result a negative outcome to renaming and positive towards keeping the name.
>>>>
>>>> Also, choose vs. yield, well, for non-native English speakers the first would be more obvious in definition and one glance of the name would tell what it is supposed to do. Personally I'd prefer concise language throughout the project, the function does not really give up anything but selects the most suitable one, right? The commit:
>>>> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/src/connection.c?id=64a986109880828a4aa727ecb7a82cb97b004623
>>>>
>>>> It is good that stuff gets documented here but reformatting should not be done just because reformatting needs. I'd say that compatibility should weight there a lot when deciding whether to rename or not.
>>>>
>>>> If the process of upstreaming because of this kind of changes becomes rather complex (even more than it already is because of historic reasons) and time required to do them increases a lot it just might be that those patches do not get done/sent. But this is just my view on the matter.
>>> Jussi,
>>> In terms of the file and function rename(s), I approached both as someone who was somewhat-initiated in having worked on connman some 13 years ago but was coming back to it with fresh eyes. I reasoned that if file and function names (those in connection.c/gateway.c, in particular) were confusing to me, then they would be more so to someone even less initiated than I. To the extent Marcel and the community were supportive, I submitted the patches. Having substantially refactored a large portion of connection.c/gateway.c, I believe it is more understandable for the uninitiated today than it was before.
>>> For my own insight, are there specific down-revision features of connman on which Sailfish (I assume Sailfish is the fork in question) would not or could not work with top-of-tree connman?
>>> Best,
>>> Grant
>>
>> Hi Grant,
>>
>> I was just concerned that the contributions in form of new features and fixing existing we and many others have been doing becomes even more difficult with renaming of the content hence the differences of the forks. Personally I try to avoid renaming much in order to not to break any workflows people already have. I'd just reason it in this way that better to have a bit of odd naming than break anything ;).
>>
>> But this "yield" word just really sounded odd, especially since the definition would be, from my perspective, ok in thread/fork-related cases, or in what https://www.merriam-webster.com/dictionary/yield defines but in selecting the default gw it just seems a bit off? Sorry about the nag on this.
> 
> In breaking down the syntactic and semantic choice of “choose” versus “yield”, to me, “choose” implied “you have two gateways to consider that are, at the outset, equal. That is, choose one of the two specified gateways and then give it the (what is now) high-priority (that is, metric 0) default route. However, the reality (somewhat complicated more now by the existence of BOTH high- and low-priority default routes) is not only that the action of the function is not simply a side-effect-free choice but also that it is a demotion / unset / give up / yielding of the high-priority default route for one of the two gateways.
> 
> Regardless of its function name, on entry to the function one of the two gateways holds the high-priority (that is, metric 0) default route, so there is not such much a choice between equal gateways. On exit from the function, one of those two gateways will have unset it / given it up / have “yielded” the high-priority default route and will have assumed a low-priority (that is, metric > 0) default route. It is not until after ‘yield_default_gateway’ is called that the activated, if it was not the gateway to unset / give up / yield the high-priority route, is promoted from its low-priority route to the high-priority route.
> 
> Given that this demotion / unset / give up / yielding of the high-priority default route was a central and key side-effect of this function being called, I felt that “yield” was a much more apt action verb than “choose”.
> 
> Comparing it to, say, “pthread_yield”, in that case it is a thread giving up or yielding the processor / scheduler. In this case, it is a gateway giving up or yielding the high-priority default route.
> 
> Does that help color and explain the rationale I had?
> 


Hi Grant,

Thanks for the explanation, with the two priorities of routes it makes a 
bit more sense. Still, it just occurred to me that "provide" might also 
work now that I thought this again after this detailed explanation of 
yours. However, would that confuse as "provider" is already used as a 
term for the VPNs inside ConnMan.

Lots of changes happening here and getting hard to keep up with all of 
those. Oh well, it just takes time.

Sorry for the late reply, I was bit of indisposed during the holidays.

Cheers!

- Jussi
