Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17747784
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="b9tkGq9j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On3+DA7F8xLO6d3+CcNwNqOJTeDOOeIY/WmDJrFIth+94M5D7K1eIRuPVjW0b/PMZKV0Mmggr+zQte9j4mfhfQ2w7oDWbYkDlWx8gJ/POsyXMQ043cmRd3bFfKpTqqRrFDRzKBAws4bPLb5cq1RNL7CBJAfYsVJIavbZNieuqPnpENZDDP5TEd0HeNFRy2kktd17W5WAzsvzRA+qpBqFc2wU8sZs4oR6Ch09AtKdk8sZBPDObHwybz/yjva/eNCrpli8L1RF1nPRKWOdXrZqvj9Gv5r/ZdPIxEm9zj9WFdTvL01CscquosDHu8GqGigFS95+EFQbaqk06FZp/8O9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ks18cXtCnYLNp2ZXzV0ducCJzaji/YywWaIBfy9USs=;
 b=nhY51shqi7sNMPheuxz/ZG5TyXlYBjEmAcEfgVHnMjiP7B9NPt6xUwTWNSKgiZxhcw67m12HOpo6rivZgXBGecqS32oj4l02ckTiME1/7ZFBxu2bXp4cTI3I3IjvEQOq0YYCmfnDtlDkCiupKC2zN5OcWFREkIHNtrj3C7B4H5BrTx8ABf4AUJMgKR82RBKH3rjg56OjorvJXDH1p22WJNTkpTaVj4RDNGx7ll4oJndlEV70x9Aa3MzMrjT890A3vFBfwpXe1Ge3qj8v+mH0+g9Kvu7uhHpj5Led71IYFC6fHeYXE4jcE+XdqmCnZ2oKdGqfb7bvYFo8OfBhWPNlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ks18cXtCnYLNp2ZXzV0ducCJzaji/YywWaIBfy9USs=;
 b=b9tkGq9jCj6vXdDuayljlM2Q/jgNzNMVz4Qs7C3ZNdzKnzkyQ7ZPzUVScNSOtgbejw8uhAoDsv8GmxZZ/iC68sTmwBbo06cj1SQw04kWoVe0J4gt9badzRllTn+B4qZ6xWi+mbaePfZ2F76mryh93npR6MKOUEBuihsoC2+ikJrp+zS9Hm3ZdQtStGv6uPEsJR1trUaO9MC16jHhf8AjXlVQ6CHhVI1ikR9j1KzwOcKdmbfWKQy1DPl7IzM0c0cciIWK6vHqHIhR/kNw9jvJblv+VADQS9tjVmAVTxPq7CQXUFjrIHq9X7LJnwwl0x2PpJbwvhpwgXvtoOL2iZrjBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by AM7PR06MB6440.eurprd06.prod.outlook.com (2603:10a6:20b:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 17:10:52 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::b92d:4fba:4a92:b89f]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::b92d:4fba:4a92:b89f%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 17:10:51 +0000
Message-ID: <d6dfa0ff-202a-49f7-b097-f098334764ce@jolla.com>
Date: Wed, 20 Dec 2023 19:10:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] connection: Rename 'connection.c' to 'gateway.c'
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev, marcel@holtmann.org
References: <20231213200001.1994492-1-gerickson@nuovations.com>
 <93ee2de3-a7bf-4a43-9893-799af7bb97aa@jolla.com>
 <1857CD1F-DCD2-414F-B0A7-7E167242A058@nuovations.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <1857CD1F-DCD2-414F-B0A7-7E167242A058@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0000FA77.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:4) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3420:EE_|AM7PR06MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: e6504b0c-ab93-4860-183d-08dc017e9e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d505w0KFDPY6/2n02iQ5E0Wy0i8yBoIsqF6i3+qMUqIr0MQXjkwP4xEw0UhhxBmxx1ZRG37Ng3dex1Sc0UxCsz69Jm03eVkpKvmMkncHRpCyjFLu1zMBIOly49U0Gkc7OhX7/sMpxawK741+3v7n0N0POkdUrfmsQJEtk7vR4HD7T2dpeI4XPlqCIvqh+s0i1FFODvhjOPvnx01A7iWfFJJOEr9+Kov/+I5oNzOW9zdtgNF+klM7jhUssH8bq0/AlEiJNdcl5OMn+W5TWNa6ZtrZ5mIMk0LNmy74+3xKTy68J1qghB0r0IzuPfhz32oC/VbWV20o5MG3dW3TQbJosdJvgpnINMVWWUBl1hH4xWDobUjNaNhn6NdkJW7EqdbVAYtjiD/SR8YzQQ896on1FW7v8eVC9q6t3WZ5V/pcx2KPG7LVaINTBMdL20uKXskmiz9izqxcpEC/+zcD6ukTPxnHX4QEk8pVxp7uTf3R7BGA+TWkskJc6fW+R7JFjUMc6uusoveM92yZfWNurRgz571XIuHnK/L7V4eGREmNcc0jimk3aBKH3LUNCuBU+AOmGvQDLW0AGDRsW+RMezTaqossxSuJcQMwBvWLEaZqfNtegeeglUUMetZCBtJdj2Fzy3i8Dj5F9kcKPEwX1EwFKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(478600001)(6486002)(2616005)(966005)(41300700001)(26005)(316002)(6916009)(6666004)(83380400001)(6506007)(6512007)(53546011)(31686004)(66556008)(66476007)(86362001)(31696002)(66946007)(36756003)(8676002)(8936002)(38100700002)(2906002)(5660300002)(4326008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUtlNXdSQ1dQc0diWHJzcnJmTU5IYkZlNGxjVEN1WHdWb3MwSlc2NDBCYzRr?=
 =?utf-8?B?VGNyRTJDT0F4aGNPZWszbDN5OFN1dzJFUTdIMnkzL0hpcUVuNGwvVDZMS3NY?=
 =?utf-8?B?ZytyU2E3cVRva3A1NWVvL3N3bU5GTTJYUE9yOFhuMVNQdWxPaEdMcUM1dERh?=
 =?utf-8?B?UEhuZ292eThLTUZwOFVWSU9DeFBFS0x1RHRLNzF4Vzhlay9TNzZsdU8wVFEy?=
 =?utf-8?B?M3R0SHVFUkNDWHR0OFMyemhTYzRndHYxUEloMk53L2owTHcyWFBjUDV3SlpF?=
 =?utf-8?B?UUY1dXZOZGkyKy9uelRwYWFNS3lGK0hsR1NaK2FyYVRYU2hKY0QxT1U3T3dN?=
 =?utf-8?B?MjdIVTQweGFjVXRZS1NqTEI2VW9URktqWlBPWERCZjMyN2NTL2ptdklYMnRS?=
 =?utf-8?B?TTFjMHgxZ25YQXBFUEZHSEQ5Wkw0dS9HK2c2QVJaakk4dFBtYWFjdjQyWlZa?=
 =?utf-8?B?MHNPdHFWUXlXNVVJUkwwcVhaYkIxbDhuYmg2VEYydUZMR3EveGFOSXdFU1d6?=
 =?utf-8?B?TnI0NkQ4S0hWMmd2Z2E0RW1yNWFyZ211akFIZjBxY2FEOGRPdFdaRm9aME4y?=
 =?utf-8?B?b2U5MkF2dlM1QTZKcG8yeWZITjhVR3lka1hOWGxnTVBEbUw0VWpVZHM5MlBM?=
 =?utf-8?B?TFUxbklnMnYzcEFaSVJpM3FJckdnMTdwSE4ydXkyMDRNazNBb25ueHBhY3Ez?=
 =?utf-8?B?cE5pN0xlUG83Zk93YlNyNk8rZFJMS200cXNEWjJ4V2RFeXZndU9CZGN3MlhR?=
 =?utf-8?B?RzVMWVNzOE1rVWYydnoxY1NVOXlWUTlMOGtWa0kwLzE5WkRJVXRwb0Q2ZzZm?=
 =?utf-8?B?V2JXQ3RrUkQyN1dOTEpwell2WERMVVZVdXJnTlQwL1daY0tEeWlobWZydDJ6?=
 =?utf-8?B?R0E5QTFBaEJXZldnQkJxNmpTNzc3UGRjVmVNS0kzc3ptSVZVbm81WmVwb0M3?=
 =?utf-8?B?Nk8zMk0vek10ZHhMUldIRGZjaldvNlZuNUplYVN0czZ4MEptWWUzVTJLYlpM?=
 =?utf-8?B?ajVIVmlFSExmaUczMGdQY0hRUVFnT05iVnVBaFoxL1ZoR3MxUU03bGw3Z3Zw?=
 =?utf-8?B?dVdlWk9seDhWQjk2NXUyeGV2N1hjZ2l6TThuZ1g2UUlmVUlLNk0ycFpQQ0dw?=
 =?utf-8?B?eHU1RUdWMmNVUVd4SHg4SGxsRlZZakhwWUM1YXUzTjA1SEw0Tkc0N2VWMlRC?=
 =?utf-8?B?RncraWV5RStSV0dzNmlsZ2V3OU01NklsS1Urem5ZT0NpY1huTVRRUmswQnJ1?=
 =?utf-8?B?cHB0b1FnazJXOTJaWjJ3TGN4Z1o2bmV6ZTV1dUxKMm9GZ29UT2lEZ24vZU8z?=
 =?utf-8?B?bHZldm1JQWJEYW5yYVdINnlMMVpEK3Q3alZYR1BjSjJCWlRLZmdoM0xORTV2?=
 =?utf-8?B?cG5WQ0dCR1hYbE1uKzJJWUxRVUlpVmx4YTU2dXNhd1MrY3BvUkk1Zno3a0VK?=
 =?utf-8?B?dUxlYVFQK3FES1lCVkZhQlRlRGhpdWxLTjFPWlRleW9lY2VQaS9sRkxiMW9H?=
 =?utf-8?B?RWw0WTlJM1NwQUYwZ1FSaTFLcEJXTG1IS3U4ckwxZitwVGpFbFVUV1FDazVr?=
 =?utf-8?B?UXhOMVZoRC9JbGVXMkIxVGxFem5wOC9qZlVRQlFtbDI5TnFhYkN4Tll3UW9o?=
 =?utf-8?B?cTB5S21CYXJuM3VmcHVBQ3NrbElEbjFvWFZQUXgvQ3VQdjd3OTRJV1JmWWti?=
 =?utf-8?B?VDNMK29tOTlOMVVDT1p0b2F2bDJTcXBaakEvejRvN3BxUzdlcUlDZmpqU08x?=
 =?utf-8?B?SHZFVWVGWHZDdVhKOFA0eUozY2FKNE1CaWd5MUNTQy9xelF0cjR1WXNZQ1Uz?=
 =?utf-8?B?OUMvU1pkN0JLTVpNdVVSam1ocUNDbVp6TU5UYVl4UG9DaFlJOWMzZkVQRy9l?=
 =?utf-8?B?MGV1SkFpcmlkdnlJbG5JRGZPVDUzcmNScUxKQkdaNThFNjBndUsvbWszT1lp?=
 =?utf-8?B?QjJkUU5ZeHhncUVzaTdzR3piYUFqU0E4YkNIMk80Um5QZ2IrSkJna2JKQmRN?=
 =?utf-8?B?SmZwNUhweFM4SGp4ZmhCQmdLeUQvK1RmMG8xMDhLZGZpbHRURENTQmwxTGQw?=
 =?utf-8?B?OGRmODVTb1FldFdjTEo4bTJ4U3ZDNzA0NTEweDFwOFFLb01lQWtwK2NRZUUv?=
 =?utf-8?B?Q0ZhZjdqRW1XSFZ6TFFsRDQyRk1ibzdlMlRYVjVweE1CWmZ5V2ZGSURjRnhY?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6504b0c-ab93-4860-183d-08dc017e9e2a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 17:10:51.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UG/rVmYySHEX8n/xMkJ/wPElEwJAlBrfCDbTyhA8JLqSFVGKYjBQt8VB84fBesBrl2m7Je5X5j/2MwIh2Nclx92oHhir/93c86ccpg8Vds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6440



On 12/20/23 07:53, Grant Erickson wrote:
> On Dec 19, 2023, at 5:32 AM, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>> I'm not really understanding what is the real benefit here in renaming connection.c to gateway.c. Granted (pun), it is more clear name for it but it still has some vpn-related functionality to get the physical device index etc. so it is still misleading.
>>
>> My point here is that this just brings a lot of drawbacks:
>> - It is rather complex now to apply patches from older versions, forks or heavily patched forks to upstream that contain changes to old connection.c
>> - It is really not straightforward just to pick an upstream patch made with changes to connection.c into these older versions or forks that from one reason or another, or like million reasons, like with our fork, cannot just be updated directly to latest upstream.
>> - And the name was there for... 15 years? It really hasn't gone through so much changes that it would need to be renamed from my opinion.
>>
>>  From my perspective the simple SWOT analysis here would result a negative outcome to renaming and positive towards keeping the name.
>>
>> Also, choose vs. yield, well, for non-native English speakers the first would be more obvious in definition and one glance of the name would tell what it is supposed to do. Personally I'd prefer concise language throughout the project, the function does not really give up anything but selects the most suitable one, right? The commit:
>> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/src/connection.c?id=64a986109880828a4aa727ecb7a82cb97b004623
>>
>> It is good that stuff gets documented here but reformatting should not be done just because reformatting needs. I'd say that compatibility should weight there a lot when deciding whether to rename or not.
>>
>> If the process of upstreaming because of this kind of changes becomes rather complex (even more than it already is because of historic reasons) and time required to do them increases a lot it just might be that those patches do not get done/sent. But this is just my view on the matter.
> 
> Jussi,
> 
> In terms of the file and function rename(s), I approached both as someone who was somewhat-initiated in having worked on connman some 13 years ago but was coming back to it with fresh eyes. I reasoned that if file and function names (those in connection.c/gateway.c, in particular) were confusing to me, then they would be more so to someone even less initiated than I. To the extent Marcel and the community were supportive, I submitted the patches. Having substantially refactored a large portion of connection.c/gateway.c, I believe it is more understandable for the uninitiated today than it was before.
> 
> For my own insight, are there specific down-revision features of connman on which Sailfish (I assume Sailfish is the fork in question) would not or could not work with top-of-tree connman?
> 
> Best,
> 
> Grant

Hi Grant,

I was just concerned that the contributions in form of new features and 
fixing existing we and many others have been doing becomes even more 
difficult with renaming of the content hence the differences of the 
forks. Personally I try to avoid renaming much in order to not to break 
any workflows people already have. I'd just reason it in this way that 
better to have a bit of odd naming than break anything ;).

But this "yield" word just really sounded odd, especially since the 
definition would be, from my perspective, ok in thread/fork-related 
cases, or in what https://www.merriam-webster.com/dictionary/yield 
defines but in selecting the default gw it just seems a bit off? Sorry 
about the nag on this.

Yes I'm talking here about Sailfish OS fork of ConnMan. We have had a 
bit different direction, I think since 2014, in some service struct 
reference counting use. I think that is one of them that makes it quite 
difficult to make some changes to work with upstream of make upstream 
work directly with ours. There are other differences as well, which 
haven't been upstreamed throughout the years. But the plan is to 
gradually try to get closer to upstream by each version upgrade, which 
should be started next year.

We do have some interesting features I'd like to someday push as an RFC 
(when time allows), such as firewall via configuration files, multiuser 
support with systemd and a recent CLAT support feature that enables 
dual-index support for the core to name but the biggest changes. These 
just drag with them so much of the old content that is done in a 
different way as the upstream has so it'll take quite a lot of time to 
usually make the patches.

The reason I'd push them as an RFC is that there is no guarantee of how 
they'd really work with upstream. We've had those either in production 
or testing already for months or up to years.

Added Marcel here too if he'd wish to participate/comment.

Cheers,
  Jussi
