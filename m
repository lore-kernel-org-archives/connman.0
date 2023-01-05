Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028A320D
	for <connman@lists.linux.dev>; Thu,  5 Jan 2023 11:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M10YqgvoYdAzUnMK7EFa+1WdsV761kUu3hTBpz9ymPwyDGYYsFt1l6Ha0Fc5PqE4rNjjxdPooSAhWvAz9MMho/YpysKfo5xNpTN/pkuvTOlgwI2mS4C4bIBzWuN76DF6JvOWjKEHvWFiEvOPAwbwZV0GLF49nrO51pmV3OM3DvVoF16CTsiMy1MjcaMIPsaF0GmtjldCzoJrwfWhxV1PfjVFgKzkG/wYZyPzSTR7XKzd9qXcTgKghFsP5v3Gb1T/PJVjfsrtIZ+Zu626uaURA/CTPcs8FYSjjXUPz7iBYdDPs4Mmn7V2pDt2+2/NiYav8Tl8CwJQUtP/slZXBcF8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5L6F8X4n1zHphuFmX76/1ULwSNXwB7D36OighJrlIY=;
 b=CU4KYoahVxe3yBKr2ziPdqfuNP8qfRXjhNCn28FY+AHUCHpQbG3R7vLL07eWGgOR0sQm80eQRGrbDybW8UeVq73T3cBLzQdGyYKYq1brCYEaQZ+kL01zNfUOK5nYdC1afeKHQcxIfB6r8w2r2o2jBrmhCYL5190eqo+S5VVsAm/deuMrcqmf+3OQIJiNpsCSz00daLdk9kbRuMxMMhRjyImkMRg0ywEFqtkd0y0DeVXTLf52Kg9KKeJre0ZY7cp/Oa0aOzrPfSoF7li4bs3+d2HIIJv6ye/1Wpt+P5ZxoCEaIQaJ7evORqdp6HzxkSmoOSWa5YeGogEeEYofoClzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5L6F8X4n1zHphuFmX76/1ULwSNXwB7D36OighJrlIY=;
 b=MyppnDZeVNp8XRoIms2vVbXkZnVO3FeMgbpXKBd84R/AXSrEqhyJL/ijaRj6VqkLy7sk/YUsiYcbiLtaaRSCseQMr8O+3EV+jrhO7t1qbkXmCmz40kHRHWYJ0raKcebqkKHDwgXr/VhVMchfFhBqQK2CvoE/nTlc337gQI+oicGAA+chibi+iXpNgOTIrgg+dWtZQDZyFAj9C+07aiWz0rrDArKIH9nI8Ar6Qh2yd9vnn4WPpw7TuwPWR7q9GSHu0gRqTLpCQGHuDQh2QKRLdiWRcaY0qcPs280iWrO7yGGFUHQRm3sOnXHZQjJOinctoKHgmBZ0JRXJDP+45nxFyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by DB6PR0601MB2648.eurprd06.prod.outlook.com (2603:10a6:4:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 11:39:03 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::bdb9:8bf5:bf79:dca2]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::bdb9:8bf5:bf79:dca2%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 11:39:03 +0000
Message-ID: <a69974f3-3a52-56ae-f50f-f876e1ee28cf@jolla.com>
Date: Thu, 5 Jan 2023 13:39:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 0/9] Add association state for VPNs
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
 <20230102081007.jobeqdgzrzzwwwqx@beryllium.lan>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <20230102081007.jobeqdgzrzzwwwqx@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0502CA0014.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::24) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3420:EE_|DB6PR0601MB2648:EE_
X-MS-Office365-Filtering-Correlation-Id: aab683b9-9093-440b-4fac-08daef1171a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zTeoamkhJ6T41azLiWuo+F8waM5vhNM3EwDrXC8S4E3A7yOcDd9bC5dMMSt7iw1a06HXt3lqPUw9UEM+75SzoxepnO3QjBmuh3x2MigOulOCZLTHiJ+HTSVqZ38wEOi47R7YySZZ4XFuGWCK3snnkc1Fx+Fv3EMQn9wo7huHjA6uI4Q58Rn8mGDWPxL3ApLT3Z0x4+T98NU0NG0orm8JAlqWErbVczcdohc2fWlQCUhhvkw4Pe2QqJDMER5zrMT+cDN3imImX9civXE19yJdIS3rSf82/xGM6FYiRV2hFt8jD37MUc6lUgPRnppr9zpUxe7JiJKSkLrPUU1RtXI/Mqb8xk5G7DQIpoy2ExpGIGnO6K1aSwAeEuE0321yR9QtH8qARM7cN7wKjzKPC2k0DyBS5JY663FX03vKFhCvBHIQXL8MHiwDcHXEWjmkE5SOKOXUumxySVcW4fq0AeSNgWbgUMZVrkamz14Zs2XNUTEDr2rrJJ8zWJOyQO6j1Vc1MZmo7hvDqMydPSWA/7NhWUn37o6ZFQ+bfbOwCukvj64QEZErg4yCFqQbs9VkarLCY7Aoc8Z/JYqQYIkx8EO6ZtkB4n3MKf9B3HIEqBca0dp5TplUPY0t86cgcjI7Aczsvs5iEstmhhlR3tyTPJKH1YOdFM+P4/bgf22Qq0KxVbRe2RIhp7JZW5Ig27FcaDM6iKU81lTsztgwXYM8Nyz8USjFX4mWh+z2ljRkKzAxENA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39830400003)(366004)(451199015)(83380400001)(6512007)(26005)(6506007)(86362001)(36756003)(31696002)(2616005)(53546011)(38100700002)(186003)(316002)(4326008)(478600001)(41300700001)(66899015)(8676002)(2906002)(5660300002)(8936002)(44832011)(6486002)(31686004)(66476007)(66556008)(66946007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azA4eGhBSzZaNFRzYUxGTlB1MXVMQWlKTTBIUVpZeHhQVndKaUxJZFp6UkJS?=
 =?utf-8?B?WFYxSEJQaU1rRjU1UTFtZUg2VE9FUFF1Y05QZHJFdlF6VmNTTnAzNVBDd3k0?=
 =?utf-8?B?VXVrU3d3ZThUK0FwVDJzUHNibExwMmd6Y0o2aUFXYVg4VkhPWi9NMlFRZnhG?=
 =?utf-8?B?SGlkSkRsNXpqTXFkU1dkUk9NQW8rV09PcHNXK2owTTh4UHAwLzlMeUdmREZR?=
 =?utf-8?B?bVNzcnplRzRWYTJDdWY3WEVIYlgzcWNUSXBycmRYNGUwWlpmdGZiNGxocG5y?=
 =?utf-8?B?aVE1TDE5RE9nS3dYU2JJQ0l2Z2dmZzNpMTVKRVhiR1VMNHdrZktmcGtyZXNU?=
 =?utf-8?B?Tk1SR3laTDVPdGo3eHZnUDNkeTdDY1dKeVBwZWdRMzNtdnAvSjZ5R3pMbHVv?=
 =?utf-8?B?Z1ZlYldzRnNCRmpxN2RTL2lBRUE2T2pyVGJmQWtzNkV0cVBRTXIzbTNjeCtj?=
 =?utf-8?B?RnpjdXgxaTIzYURUVDVDRmlobUFJeU1OUEF6bGZYYk00TFliVzk2bEZsY1dn?=
 =?utf-8?B?VHJZWVJuNGZDSGM1bFNpZnRnSUxTYzNrVjlTNWNiSEVXbXBBVW5wbW1Lb1dQ?=
 =?utf-8?B?RTYrWTV2VDB2OFNhV25SVCs2K1dPeDNmNldQTVJlSEk4NEU2SzN2anVmSHhh?=
 =?utf-8?B?SUxCbStuVHBzWFMzYlNNY01kblVZZEE2TzBoUnFRY3JMSGoxSXJ5dlhtYzh1?=
 =?utf-8?B?elorNTY5YWFiVGQrQlh5Z2tqTTZpaG55MkN0ZGorbnhMTm0ycERPTEJ3R1FK?=
 =?utf-8?B?UVQreitrTzlwbTVML253a3hKRmdLZVFIWjFaRG93V2NiSXlSUy9uUlZVNXBh?=
 =?utf-8?B?ZkN6eHg1bFZDeGVoMHB6MlRWdFU5T0d1V3VQSjhKT1FSZ0FGVloyRDE2VVhZ?=
 =?utf-8?B?UFRITk9XVEExM0JRVUhmd1FNUU9PRXg0a3ZESFI1N2tjT1pWZEhBZXN5a2x6?=
 =?utf-8?B?dmNJUTNFMGd6UkVEVTFWOWxVcDA3VHpJM0d0MmRlQ3pGZDd2NmZpb0Q4dFlN?=
 =?utf-8?B?dW9PWC95RTYrclF0TVJmamJJMkd5a1EzZTZYbm1PWEtydm5FQkRVR2RrR2sv?=
 =?utf-8?B?dmZzU21NNGpHdlFPbTh2bGU4Y1FBR1M4NDh0YndqR05YekZqd2JVNHl6Ykxz?=
 =?utf-8?B?ZWdUOWhaLzRDQ0w1L0ZHTHZwUGFaZWppUDBUWG9vWE9kSVFBZXptVTBvcjVP?=
 =?utf-8?B?STlkQ3o4TXowNGphQWdWcDYrbXBmaUdNQXo0U3EvT3p4VjV4eEZ2c3lzcXgy?=
 =?utf-8?B?clc3akgvQk40dE1GU3VOeDFrRGw3d0xLRzRUZ3NLR3JLVDd0aEpYbU5qOGpG?=
 =?utf-8?B?VitTdzNpSGtkY1JQWGhGZUcyWEJmdzBWajNUMUZxQjBXSWNHNEtaYkx5OXI1?=
 =?utf-8?B?SVkrL1Q2Y2VIN1htOEVLSGE4VzJYMm5RMXZIa0pRbHQycWQzY0tCV1JDK3VC?=
 =?utf-8?B?Nm11MmdYY01pYS81VkdCUlhXeDBRQ3RMU0s1RSs4K28rT0wyaEllVnYwaFZM?=
 =?utf-8?B?NWV4dGpySFY2V1ZHa2oyTjErYlNXSUQ3UU1KcGZMMTViRHUvMVBjaTFYckFL?=
 =?utf-8?B?ajA2RG91czAya05aN2pGa21vR1Vlc1VBY3ZPRnhOYjBYUkJuQU5mR3NPM2NW?=
 =?utf-8?B?NDVrOFcvUEdMNEw2YVoxQUV2REhhUE5QT053LzFCWWtvNVYzVGtINzdOdVNQ?=
 =?utf-8?B?Wm1VQkJXTHRMZnJSNUxraW1JYkVDbkQ2bWttYm90Y3A0VFlsUjNYRWNFWVl5?=
 =?utf-8?B?MVpXZSt1Y3dHMGFjSStmVmlSdEx6azZiOTg3VTEwVFIyQlFORTBpaDBwZ2lU?=
 =?utf-8?B?aWRqTTJzb3ZjMmNJV2w3QW1MZm9WZEhGQktrYjBRNEJGWDVqTVZ3VGdScXZm?=
 =?utf-8?B?alZzT2pBd0lUTStzNkEvMTJ4ZGxPZllzek9rY0FYdkVENzVDK2hCSm5qOEVJ?=
 =?utf-8?B?a2VyR0NoRkMxUHBiYlkyT0dQbDBZMU9BNi8raHlmb0RheG1TVUpYTzZhd0Vn?=
 =?utf-8?B?MU5QNStFd2haa0lKYWxnaXhVK2VpZUt0cEd5UHl6dGQrQ2YyK3M2ODVlWFcw?=
 =?utf-8?B?VHVaU0NEZENYWmloR1ZvUjNWcEJXZFdsU29xNm9VK3pZMW5rRHRuZEE2YXNX?=
 =?utf-8?B?TEtLeUhlMU9JbFBLMnpQVFhFbjFTZjZIMWZNdkp1c0JpNUpKNkY0U2hveEdV?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab683b9-9093-440b-4fac-08daef1171a7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 11:39:03.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiqopjEMlvmH2ekctO9YZ8+uRDXmVM1YZlsIWrh1ua+meIpuX+kU9t0QEUXuTWGF4FEiqm2vW2C7ep3I6e1meu9nFhLhiBAGfOfuGBW2snU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2648

Hi Daniel

On 1/2/23 10:10, Daniel Wagner wrote:
> Hi Jussi,
> 
>>
>> On vpnd side association state is, like on connmand side, the initial state for
>> the VPN getting connected. After the VPN agent succeeds getting the information
>> from the user (credentials) the state transitions to connect (configuratioin).
>> There may be a possibility for a VPN plugin to run without VPN agent and thus
>> in these cases it is ensured that the vpn/plugins/vpn.c:vpn_notify() does
>> the state transition in such cases. It is allowed go back to association state
>> from connect state but not from other states.
> 
> I can't remember why the VPN part is missing the association state. Propaply it
> was assummed having the configuration state is enough.

Most likely, yes. I had a bit of a head scratching with this that how to 
achieve this and missing state on VPN side seemed the best approach.

> 
>> I'd like to raise the following issues for commenting:
>> a) Is this current approach sound in the way that the vpn-agent.c is
>>     responsible of changing the state? vpn-provider.c:connect_cb() would be
>>     ideal but that does get called in notify if there is no error. Processing
>>     the message with the vpn_agent_check_and_process_reply_error() with success
>>     indicates that VPN agent succeeded getting the input.
> 
> Unfortunatly, I can't remember all these details, though I think the idea of
> connect_cb was to get called as final function. So it's sounds like you want to
> extend it to handle all state transitions. Sounds reasonable, but I suggest to
> update the name so that it refelcts more what it is doing, e.g. match it with
> the service.c::indicate_state, vpn_indicate_state (?) Does this make any sense?
> 

It does make some sense, however, there is the issue whether we'd want 
each of the plugins explicitly having to call the new 
vpn_indicate_state() for state transition or to automate the state 
transition for the plugins that use VPN agent, which, as of now, seems 
to be the case with the current VPN plugins. I was thinking that might 
it become a bit too complex if the new vpn_indicate_state() 
(connect_cb()) could be called more than once from within the VPN plugin 
as the current approach is that the callback function should be called 
only once.

So options are:
  1) the current proposed way that is cleaner for the plugins using VPN 
agent but needs one extra call for plugins that do not use it.
  2) make the plugins more in control of state transition, each would 
need to call in ASSOCIATION state to transition to CONNECT state with an 
explicit call.

But now as I'm thinking this again, maybe the state transition shouldn't 
be within plugins but by introducing as an additional callback through 
the vpn_driver, e.g., use_vpn_agent() that would be needed to be 
implemented only by the VPN plugins that do not use VPN agent. I.e., 
only when the function exists and explicitly states 1/false as return 
value the vpn-provider.c transitions the state to CONNECT right after 
the __vpn_provider_connect() has done the connect attempt and first 
indicated ASSOCIATION state.

I'm just thinking that which is the cleanest one and requires least 
amount of maintenance.

>> b) Can we figure out a case where the state transition from VPN plugin notify
>>     SHOULD change the state back to ASSOCIATION when normally in CONNECT state?
>>     This change is in vpn/plugins/vpn.c that accommodates transitions from
>>     CONNECT->ASSOCIATION.
> 
> Hmm, the main state machine for ConnMan doesn't allow for this transitioning
> from CONNECT to ASSOCIATION (or CONFIGURATION) state. Don't know if we should
> introduce it. It has a high potential to introduce a lot of bugs. At least
> I would like to have a proper use case why we need it before we start
> touching the main statemachine.

Yep, I will remove this from the changes. With an afterthought it might 
not be used after all since notify usually tells either failure or 
success of the connection attempt back to the caller.

> 
>> c) Furthermore, might any of the VPN plugins available (elsewhere) work
>>     without accessing the VPN agent? The flow now requires to use vpn-agent.c
>>     for processing and state transition. However, these cases should then use
>>     the vpn_provider_set_state() directly, as most of the plugins now do in,
>>     e.g., error cases.
> 
> That might be the case, but I don't think we should consider this as really an
> argument to stop us from updating the code base.

Well, with the approach suggested above there would be a way for those 
plugins that do not use VPN agent to indicate that state needs to be 
transitioned to CONNECT at start. So when VPN agent is not needed, 
implement the callback to return 1/false into the VPN plugin.

> 
>> d) The VPN and PROVIDER states, should these be harmonized to follow the same
>>     structure as the common service states to avoid confusion or might this be
>>     risky as many of the headers are public?
> 
> Yes, I think we should have all these state machines updated in sync, to avoid
> complexity and reduce our maintainance burden. Yes, that might break exising
> plugins though I am not sure there are any. In this case I would update our code
> base and if someone is complaining we can still think about mitigation, such as
> introducing some combat function/macros.

Ok, I'll sync those state enums and lets see if someone disagrees :).

> 
>> e) Should the specific VPNs that do need VPN agent more than once then do the
>>     transition back to ASSOCIATION when the first VPN agent returns and sets the
>>     state to CONNECT? This is what I couldn't decide, there is another option to
>>     have the vpn_agent_check_and_process_reply_error() to have an additional
>>     parameter to state that do not transition state, but in the case of OpenVPN
>>     the private key, for instance, can be decrypted and the management interface
>>     queries the passphrase on need basis. Thus, there is no apriori information
>>     on this.
> 
> No idea, you seem to have a why better understanding of the situation. It's up
> to your :)

Well, maybe that could be listed as a TODO as I have no proposal for 
this. In the cases where agent is required after the initial one, which 
leads to ASSOCIATION->CONNECT transition there would be the same timeout 
that there is for the first VPN agent dialog before these changes.

> 
>> And of course, any other issue that may trouble your mind with these changes.
> 
> I don't have any, right now. Let me quickly look though the patches. Though I
> don't expect a lot of comments from my side.
> 

I'll edit the patch set and send it as without RFC tag after I hear your 
thoughts on the matters I just wrote. And thanks for taking time in 
looking through these.


Cheers,
  Jussi
