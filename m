Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9A1944B
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="gW/DhmA7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIlHB45+EESxdk0ZrZkZjt8HnA16WdRVaLKl0M8CyBxRQA6djDM/tsqe7zOv8V3KAq06xaTpurgyj6NULweyIW4JurF1dVUWEc22tIr4scu6oUa6PBZpOst98WgzTk7I3xKitG+Amo8dYWhkX6QZiv+jZLaUYkoTsbrA5EYuiaMK+ornDHOeN6Q3eAdstFwPPaGSjMYnWxSbKZIOAQx36s4EdM4kBgvr7Z+byDtd0mKXwlvZLmIcKlhy/ImXtWXWX8idg+1znfHRGIy6pHm9SecQx3r29dD62QudSMO1sozclQ7873PSgzzfpeMAzBLD4B9IXIYo6NJN/1h+VhOyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grKFXDb6+pr+CbZppqHHE0xd/Fk86jlCPDwcdC88K/E=;
 b=lAt5Bx9ZaScpl2uCm9YgkDApW6N3KPgIFfYT3XBP/JuNQURQStPtxlsb5FDL9aP5uEGEz1kzkDrMBFH1zVZLifq7AnBBCJZwFz+CDY0vAHUPDW4mTrEPSvb2rFQpLn6+Ty5lqY0rvXp2Pp7BCu/D7zJccwLhm5PQNPrFaPnPkHxEwu6MVWTZHt8WFfX5dv6TMV8vK6GAdixzQ8xk82vGNDBROPw5Dq+UosHpBbXFrkKtv7Iv2ziEaTdtan3l3pl+JpkOIZn1pJEdCgcx9trQVtKjm5qfadwE4AY7I4eSgYSAO7xhBQBBwVNFeFkQFG7xAuZ+WB0wMSNgxl7kaP3GPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grKFXDb6+pr+CbZppqHHE0xd/Fk86jlCPDwcdC88K/E=;
 b=gW/DhmA7KMF9AF3codIUtJ5EiSBHKi8opmfLzXrCmLN3r3ZE1z4rFxzz2vg5Sp+n8Mr++HR6YjWoz2n6RbAQSra9Xr88miIvN2q0ayI/i6OEtj+vRtAC7s53MRMNXsBlTrczw7rRP1RIDiBxJGW8xEn//DGc+qCI/cz7S8kK5jbEf8zsRLCmmJPm7bOlxRBKwctvyAkzzxV2mF9Y7myrtlFBIAIU+ZO1uZ9lGEN0HsvsSIOFtu8YJ9OokFaR2SM1/DDIMyawt+ED3SSIsTiWkZA4DM3xJB/19Afv1URQrNxVGpzAbDbdrM4UTru9XxXDR/Vuow7UNqj+mz09d5LsOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by VI1PR06MB6768.eurprd06.prod.outlook.com (2603:10a6:800:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 13:32:37 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::b92d:4fba:4a92:b89f]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::b92d:4fba:4a92:b89f%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 13:32:36 +0000
Message-ID: <93ee2de3-a7bf-4a43-9893-799af7bb97aa@jolla.com>
Date: Tue, 19 Dec 2023 15:32:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] connection: Rename 'connection.c' to 'gateway.c'
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <20231213200001.1994492-1-gerickson@nuovations.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <20231213200001.1994492-1-gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::34) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3420:EE_|VI1PR06MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aec5d37-2a2c-435e-39be-08dc0096f696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eBtA8yisy/U0TWog4kwpw5HngDBvntfjsmJSxGRxmt4PTgjfGo0u45hQRQTgHSTZDpGSRfreNvyuL0m8PS0OZm8XiSHtw5XQKD+facDUo7uMEoKCv6iHFfFmB4MEyEuWV4O9+Y5ZNoIx8y1P4sA2oJTmVUj8eGMAN0pCazAZQ2KkdSVgpqkF2nqBttUFv/Sxe2pWQFA0K6/qLAZxcjpdqWgIISzy7/yfVCPK+DR25EpDsC9O9Ck8fw17QuVfFSfWJXYcl3dBK0k8dCLiTd8u/n5HrILrCnQPyejfJpQA+tT7dmdhrpJQF13NAxZ7kBOZ/4JD4oYJrBzra1yY3hHw2YFyqz5Q+j4i68xzNGRMPt46kmyxfREomHn2SYKopX7wuvUqAWhJlau3fxPME0SBiYBphcwxUHwc8HuXBbf/1JV+Lew3gCUThUgmkLCu11kN9lqQxBTj1FWAA+NTRsFjc/ijtlDsnMraOvUoKbPXH4YV2yz2RL+e5MNU3OWizSKcnnMZlu5BY0vOOW/Z3MKNWOm67KocM6vskyq364B+gdB5WibgFxINMpOocFng33YrT9jPT+pfyLT3whClxO9prT/C2BCmccZW227aCX48cK8BKn54FHPleMCUcLvU2Xy7hoYHyFHg1Il89mWO3GcEiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39830400003)(396003)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(6512007)(26005)(38100700002)(8676002)(8936002)(6486002)(2906002)(316002)(5660300002)(44832011)(966005)(2616005)(478600001)(41300700001)(6506007)(53546011)(66476007)(6666004)(66946007)(66556008)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW1GU2xEa082QmdLeDZDQ21VNERBck1QYWVhaU9jditPcm9VTWtwTlNmQU90?=
 =?utf-8?B?V0xqVUNWdFFQOUpZS3ltek0vZmo3QTJEczY4OXJuTDhKVHk2YW9Temo2YjF6?=
 =?utf-8?B?QkFONXZDem9rS0d1Uy8rWGh4bXk4TXMwb29HOEhkZ0JCTkNhd3czODB6dEYx?=
 =?utf-8?B?ZEhBWnd1MnFONEJtaGFvYTJLbjJRb3BDVjVLK2lKdnoyQWlNTEMzK3BWZndI?=
 =?utf-8?B?Y2NheVF4bDBjRmxYd3ZFV1UzV04zQ3FLTm1VT0xuRmJHVk5zdlhTdXZqaFFG?=
 =?utf-8?B?Q2FNdDBEeTRLL3ZBMlZZdzBxSW9waS8xaWtac3REYTVLZG41Rm9PN3ZWY3FJ?=
 =?utf-8?B?OTU3TjZmRzZPc0ZYWXhhU3RvNGlIbUZDY0t0aDhaSy9DZTd5TnB4Y3pwUDhF?=
 =?utf-8?B?RExMSE9KRVU3cGZLV3pKRFFYYmNnNU9xaVY2bmR0V1FhNHFGU3BySW11LzZ6?=
 =?utf-8?B?Sm11alFDTm5tSEJaTi9nVUtsM1pHb2Fndk9VVE5Fdkh4SHhoMlJXMEM5eFJy?=
 =?utf-8?B?MXlNeVRlenVGTk5YNnhVZVhUVWpWdDhBaUlEWU9BQ1g2ZURBT3BFYzAwUWdy?=
 =?utf-8?B?STR5dmU0RURtNDhkWlRsaVNTMnlkZXBEWW5vZVRaMDBvRGdaVlVyWmZ6c0o5?=
 =?utf-8?B?TDNCcWFMOWVtL1hlcE92S1gyaldjUEJHZHpNQi8xM0JyTW5MN2M4MjBOK3o3?=
 =?utf-8?B?dUZURkpMdituY0UzWVo0Yi94bEpEUzN0aitRZ0p2SDdSdVpXZU1GVUJFeWVD?=
 =?utf-8?B?WkZlSTQvaUNqMnYxd1Y4S1Vpb2FhSW83K0tsdGFjZjBPS1Bxbm9keDhpVTV0?=
 =?utf-8?B?eHJ6SUNodmpyd1N6UVBQTS84RFV6bEJZeUpFcDNyVFcwcHU1Nkx4Wk9xSVFC?=
 =?utf-8?B?NE1EcmIzOURBOFd1dUVUVG56ZW9WMGYrZ2wrdUlxWFppV2pxRmF0N3JQZUp5?=
 =?utf-8?B?OHByeVB5N1JjTkJ6aE1DNDAyaXFrbXBLbTFxMm0wamNOcWdON3B6NEVpTXlz?=
 =?utf-8?B?QzlVQU5DeFFUcWY4OHdtUlZiditYdVNGSEVQZyszWFdsY05nL2JBditFa3Jn?=
 =?utf-8?B?emMvVDJIMXpKVDhIbU5uUFFXMTlwSnhndm9CeGc1MjlEOTFTRUFxejFlZC9y?=
 =?utf-8?B?angzQnJmMEdBelQ3enQ0cUFrZGpENGxmRmFWcmhCeWUxMk1wRWJMN3lTSDNH?=
 =?utf-8?B?R2gwVlNUQmV1cnJ0QVNybGdVMUwrdGp6N1A3WWpFSnhEN2NkZm9QbWU0YUd4?=
 =?utf-8?B?VEw3bUZVMElQb1dIZElRejBOazBMbjFPMlp1Q21aQ0U4ZG0yU2RYL3ZYdllG?=
 =?utf-8?B?VHAwMGFFdENkVTF5M29PMmFGc1FpOVNmRUVhZzBYbi9QY1FNK3loS1dyNG1E?=
 =?utf-8?B?TkNNU05GdUQ5SDB2czVGSWRiaTR3c2tHOGNuYVFYVWd1Mit1dzUvR3lwT24w?=
 =?utf-8?B?aHdLYkRLdGhhVlNxY2pObHU4Rk9WNWx3bmZkajNvMXluK0tBbmJPYUlndk5P?=
 =?utf-8?B?VUxsVHNhYWxMZEV4eENLTEVyUFp2blBNL0RxbUtJcDBUeEtLb0lBSlZDOCs3?=
 =?utf-8?B?OEExb2p6QVBSU3BVR2xqMzBIMXpJR05RTUszNkRxOTZ4aUpXQ29YM2pWQ0pV?=
 =?utf-8?B?RVVIbTFrdjVNOVNjSTdWakNvZmJSWkNpb1VMQXI3MXJ6RU4wZWY0RjhSNlEr?=
 =?utf-8?B?VGZ3RmQzZi90Q2toaVZlNm9iVm9tNkdYS1RYdHNrSnM4RnkyRzFqNUphTTNF?=
 =?utf-8?B?MlB6V2RuaFJGOU1zMlVtRE9qc3Nlcm9KV1VZOTY2emdOOGhSN005eWp1dUR2?=
 =?utf-8?B?WmhkQU5lckQwYXdvcE1aM3hSS25nZ0dzN2NzM3lOUzdoN20vQVdPZ2M0N0Rj?=
 =?utf-8?B?KzRNa3NwaE9weXZnMW44SElhcGR6dDhKRHY3cmhXV2MzZ2IxZU51K0VrYnhl?=
 =?utf-8?B?L0xRNzAxNXhJek01WktFTXlwYVNhZzh5N1ZXWnE2eHFGWCtPM3RYSzlEYXNt?=
 =?utf-8?B?UDlHdjNSQ0cycGE5VjA0SHNzVDVEVnV3ZGppWW9rR3EvbjZTL29ES2tkeVNo?=
 =?utf-8?B?Y0YxUStabko2M3p0VXFpT2x3cXhPcWgrK3NBbUFkcDJGQ2tWbzdlVEovQkoy?=
 =?utf-8?B?a01ya01UOXUxdC92azc5N0ZzTDNSZSs2cFBQaTBtdDllN1R1aDYvSTg5WHo3?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aec5d37-2a2c-435e-39be-08dc0096f696
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 13:32:36.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efceQRw8Mf/WkcqEIgP9O2iZq9yC8hnPQHtX8pRmoNmy/fyEZAPwMdZBGWwMql/9JbiDSLzIG0LgyErOjm5lT5mw7exTWzrt9pQ82iolpZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6768

Hello Grant and Marcel,

I'm not really understanding what is the real benefit here in renaming 
connection.c to gateway.c. Granted (pun), it is more clear name for it 
but it still has some vpn-related functionality to get the physical 
device index etc. so it is still misleading.

My point here is that this just brings a lot of drawbacks:
  - It is rather complex now to apply patches from older versions, forks 
or heavily patched forks to upstream that contain changes to old 
connection.c
  - It is really not straightforward just to pick an upstream patch made 
with changes to connection.c into these older versions or forks that 
from one reason or another, or like million reasons, like with our fork, 
cannot just be updated directly to latest upstream.
  - And the name was there for... 15 years? It really hasn't gone 
through so much changes that it would need to be renamed from my opinion.

 From my perspective the simple SWOT analysis here would result a 
negative outcome to renaming and positive towards keeping the name.

Also, choose vs. yield, well, for non-native English speakers the first 
would be more obvious in definition and one glance of the name would 
tell what it is supposed to do. Personally I'd prefer concise language 
throughout the project, the function does not really give up anything 
but selects the most suitable one, right? The commit:
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/src/connection.c?id=64a986109880828a4aa727ecb7a82cb97b004623

It is good that stuff gets documented here but reformatting should not 
be done just because reformatting needs. I'd say that compatibility 
should weight there a lot when deciding whether to rename or not.

If the process of upstreaming because of this kind of changes becomes 
rather complex (even more than it already is because of historic 
reasons) and time required to do them increases a lot it just might be 
that those patches do not get done/sent. But this is just my view on the 
matter.


- Jussi

On 12/13/23 21:59, Grant Erickson wrote:
> While historically, "connection.c" might have been a contextually-apt
> name, today it might be better named "gateway.c" since its primary
> focus is gateway routes and gateway route management.
> 
> Reflective of that, this renames "connection.c" to "gateway.c" and
> updates public and private symbol names accordingly.
> 
> Grant Erickson (3):
>    connection: Rename 'connection.c' to 'gateway.c'.
>    gateway: Updated @file comment to reflect recent rename.
>    gateway: Rename public and private symbols after file rename.
> 
>   Makefile.am                     |  2 +-
>   src/connman.h                   | 14 +++----
>   src/dnsproxy.c                  |  2 +-
>   src/{connection.c => gateway.c} | 65 ++++++++++++++++-----------------
>   src/inet.c                      |  2 +-
>   src/ipconfig.c                  |  8 ++--
>   src/main.c                      |  4 +-
>   src/network.c                   |  2 +-
>   src/provider.c                  |  4 +-
>   src/service.c                   | 22 +++++------
>   10 files changed, 62 insertions(+), 63 deletions(-)
>   rename src/{connection.c => gateway.c} (98%)
> 
