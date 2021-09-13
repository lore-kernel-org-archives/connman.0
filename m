Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150075.outbound.protection.outlook.com [40.107.15.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104233FD6
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 09:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw6SxKEEpA7vL7acITAmA3Ao73ZWPshHRss3hL5hc8BXVhT6KR7RZCNQl1Lurd9ECVjkcP1GCBhWvmbklu12GWUa8LrvlfcD6yNMXbAfZqjS+LiPpwVsX9Zo4wi3XaybYigINRt9wX4GqEJzQ7AXFFkShYgN01sczj9+07qJ2DmHHKPSy2FwDV7f9NmZ3aGbDIbDHR4YVEJAgARr9jVZs5M2pNmyzfsH+NN8bh/QIcQnP3Zv8baCPgCfGOZqE+Htm3clWnV61c+gYHLgQzcaQ6MSoXyeTstrfNgqx4cc/BvHp42Ac4MUynw4eP8ywpMNduKX1NVC9Z8++Ft+NHcRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uCYY/j+whuueCBtyrLJv0he+Cj82PhlhzI23qiOjxcQ=;
 b=mcsg/H9epqNNu35AE8dC0ZJ4NmsnAN0Em5p/icZzRe5xKzEYGNk9cZF86p23m/gy1ctHZbeLJsdlaDITxkTujOQTkSugeqopVt3CLKSqfC+LWFCDYTZmwZ0Ff62tzfIRAY8/0/yyH3PNp8FtZGrCGxzvnLXHlTnjxMDrXO/4THKNU2c9Jsx8obKNDoghcQOs4rk2RfggKpn0HcA84lXCzP4UKZGAw+ZeaLQ+CFdWOw+dwb56aa0llORjLJRUAFttW50kw/fetJcHCtUSezq1ifKDpumeFj9zdRKghf+AJKKOEgQ+B7XZGomIiBcAMER+ov91M9B3zHPTQCgTTeXCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCYY/j+whuueCBtyrLJv0he+Cj82PhlhzI23qiOjxcQ=;
 b=DUPko+zRXpjJtUAHaIPySmUNSRtDr13fV0iCIBQjH/61+AoHCCA1QSWEjwIQmwVjdqQD0KDWgZgfkkdBS52vTjbiXdfyRzE1ssQ472HkAv85ethZ9BEYQqjsJ1bGOy5VWsbWB+6t7jwaYXZrBibXX5xQBG2ce7V4x3pjUj3obQtYLiGXAzkqBY3duzLoszE/6BVN1s38fH8suM03iLFduKBVWBQuhkqc1BvN7GIF8OtffeqciKeypdkgBHCAbx+zKrpf0BD1t3PhidZWM+uI3U8Oiy/1UtD7VfGl5A19rXS76sUzCqpdZrbpJouaLfZaKAbbEt+c68eO2d7yUFVVLQ==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0601MB2346.eurprd06.prod.outlook.com (2603:10a6:3:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 09:05:49 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 09:05:49 +0000
Subject: Re: [PATCH 2/5] vpn-provider: Ignore error adding when state is
 idle/unknown
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
 <20210902151124.4983-3-jussi.laakkonen@jolla.com>
 <20210913063231.la2wfnnm5jh65hrd@beryllium.lan>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <6747e0f9-5c38-ac97-b759-9f69d0aa6154@jolla.com>
Date: Mon, 13 Sep 2021 12:05:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913063231.la2wfnnm5jh65hrd@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0341.eurprd05.prod.outlook.com
 (2603:10a6:7:92::36) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.1.8] (194.110.84.60) by HE1PR05CA0341.eurprd05.prod.outlook.com (2603:10a6:7:92::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 09:05:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1890c53-b411-4b56-2139-08d97695ae19
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2346:
X-Microsoft-Antispam-PRVS:
	<HE1PR0601MB2346E7CF674EDE31526E51F2EFD99@HE1PR0601MB2346.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HW+Ln9RtgTg6/LtDE65fIRG2wMf9ZH3LDQ9JWr4H93eQQPj4DGgayOC4+ZottpssGRZgsSLaOdDPlVwd1hfcol3Enu6yq62kg4ADRFpnpYn7Dvnwd2UQvw0vUYl/BbFFTeDt4n2cja8WNzXFZqZYRWxg40JT0ZuoZeaSxMvZ0OXI5uzj2ypKBAK4v898Zn5aPNycisPGs9ZcaMnjeO2rrkF0u/xO2C4a1kHkobPzPv4FEl5P/2hegeR/HBOfU+sBGqGUwcHHw9J/blr4BC66gaYfNazBluQcxnHOaVEXExsjgg7nWzlhLYX9gu0dwTy6fnInG5dw7dWozQZBbGxYBXZkfsUSaHcs8nvz/QNFQoRb6+vxKwNx2axvCP/aef/p9nhD17g0cXD5wMO0Y+aH6i8Qqtks7c1ZGfxK+vdJ8kEUmyg+Dh+eqSzySDH0QPGEO+J+447G2iIMyR8QFdVlf3PvjeazWOqOeVacfhkNg+cADNSiqHBEWtQ4FimBmOv/Q+khjjnGO7afcMUos1FULJoleXJmrgAE7MfCJsubvjm7DhonHI0nAjL4masFkki1eMFlTS4yBLv9dmLaUs3YJG8jYDHLk+S9xCM9JhxpvrSJhruGDUHjJfNvWemX+UZTGjYE+uaN7lpWVHVjSdp3I/wuU3cpHQ+dxsg7imWAN4fooQrGNEXwWU4erEOYOrRk5/yjIDZEyYBBMT21ewcW4mL1HCKqAdJolI/QM87ahMArcjB725yXQJbyekt2aDAC+4jq4jdJBbcfFY1NBGIiRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39830400003)(376002)(366004)(346002)(136003)(8676002)(31696002)(36756003)(16576012)(316002)(52116002)(31686004)(956004)(2616005)(2906002)(66476007)(44832011)(8936002)(83380400001)(4326008)(508600001)(86362001)(5660300002)(38350700002)(38100700002)(6486002)(186003)(26005)(66946007)(53546011)(6916009)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEIxU29jZVo2RGE1MkNCNEljV3ZIWERkdmpGWUdJMEozMTFYRDlJYStqOU9n?=
 =?utf-8?B?MGVIRGhSSVNBR1RWWXN2SEJhZ1MvVFhnTzVBek14V3V0Y3kxMWJQT002ZGxY?=
 =?utf-8?B?RDBuUkxSaUwraWdOdi9vQysxazZOSVVEbHk0c0phRERWU0hqQ0R2NUxMMEdl?=
 =?utf-8?B?M3hQVTFjQmVDdS93UmZZQkJBaWtCcUgyMEJoVzNtNWpvRVAvSFZobXZTeGhD?=
 =?utf-8?B?M2d3NmhpTmhhNkRoUG1JZG1Hc0E5N2xjYkdReEd3d3pNMTlwbDZOR28vaXdy?=
 =?utf-8?B?MGdiR3FmM1NZZFFVMU9wM25nTUZEZjA2YzlHbEJZVzB1Ujg4NWRkTDFlL1g0?=
 =?utf-8?B?UkZuWDN1Q0tqalpRYXVDOUhyR0dwb1Z3SUQ5SGhjWFcyb3l3cWYvcGtPRkdu?=
 =?utf-8?B?KzZ4ekhSbDI5bFJlcWJjTmxtNHlSVnUyeXR6VVo0MENJZ1l2MFF1WDhVMmt2?=
 =?utf-8?B?Y0l4Vm8zSmR1T2sxdnZsbCsvV2hBQjcxV1pQNVhYdjIyMEQ5L2NPL1FPOTZN?=
 =?utf-8?B?U2JDSm1LK0h0UUNpbVkyVDdzY25GUmMwQTFoRkRIRG43ek5oS2JaUlM0WkZx?=
 =?utf-8?B?YXhUUW5MZUdzdWZLaUJGNXh0REdZNm9zMTJOYmZOWlYvaGR5YmNhbWxuL3ht?=
 =?utf-8?B?bHlwUjF3cG9YMGh3eHRzU1drVlk1dHpha0dXSy9MRWd0WjJSZHdCaGNUbm9q?=
 =?utf-8?B?eWZsa3NMa3FwckVpRFI5T2tMV2ExbE0zVkY5WnRmQlZ3SnBudkF2VUdlZ0pG?=
 =?utf-8?B?QTJKbzFwSTdwcktsTTdLaG9lbG9mQkdoVHp4VEJPYWxISW82RVdNUnNMbzda?=
 =?utf-8?B?Tm9tSytlaUZQY1dJcDgzek51TVdwMGJrY0FhNElwYkQ0dTZDSXJ1WTRWMkM2?=
 =?utf-8?B?TFA4eEpWVTgrSnU4NjI1TFI3YUxYVy9WbWI4TmxPNGFEeWJNZXNDTHpFWEI5?=
 =?utf-8?B?VkVVMHJ4cU9WSmc0OVh2V0VkNWl4T1lCUjNHa1ZmcFRFM3RzakVsU1BsMjlL?=
 =?utf-8?B?NGE4VXZ5a3FnNmxWSUltc1lHZksyMjFEN24zY2xvZ05qdW9DanJlbWxwUXBO?=
 =?utf-8?B?cDVxdGZ1S2hZb1JnbWxXamErVG9tcHl0ZnU3ZDVncU04eEgwNXVHTW80aDQ4?=
 =?utf-8?B?L3U1MmNuS1hSclQzYXhKYnVkZTF2VDZhaHVaWFBuZm9tM2JGSTErdGlvMDJD?=
 =?utf-8?B?SnlqN0c2NnorN2FkbDlad1FxVnRTWnk0RVFJaDRnQjdpRXE0S3dhMkhVNFp3?=
 =?utf-8?B?eEtJL2cxR1BGaXhYc1dqbkw2UllZaFVYUVpRenFCRjU1azNXTG1jUk9Rcjl1?=
 =?utf-8?B?cHg4d3R5K3ZJT2t2cTBpRDl2UTNDeVQyVmhRNVlqNUw4d09RVHMyVTJkRTFZ?=
 =?utf-8?B?R1IxRVc5N0JuV3BTckc3VDJhR3Z5YkdCc3JFUVVCeTZnV0lrTC9XNnJJRjdz?=
 =?utf-8?B?VGg1UTRCVVdNQ202ODFsT3M1ZCszUnF0MmRUUkhybGN2eDdETE9YQm9VdjUr?=
 =?utf-8?B?UXVDNWdUNWFtdnR0WTBUa0JHSnNOZ3ozdlo0MDBWNjFUVXlpckI1QjV6bU51?=
 =?utf-8?B?ZTVyREJZcC9DUmlCNlJSZFBDUXh2L2ErTGdJT2UrMW83Uk9teTdJRnFTa054?=
 =?utf-8?B?dXBCYzZjaDJ2WWl3M0RvV05ZY2VKaVpuYTFDd2M1dGM2UDNyNHkvMmFLeXAx?=
 =?utf-8?B?R05TSFNTbkJpSSt1Si94QWoxRFhGMDB0MUlKWWNKdkpvaVRYMVVQT1RSNkdz?=
 =?utf-8?Q?xm1QdnTlJcfD8bxXAd2fsiaZdh77MeGTaR01+b+?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1890c53-b411-4b56-2139-08d97695ae19
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 09:05:49.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxfhaXzF4TrasGJnfJoRkvIPPuTCEnNipjH88SxLxs6WtdcqGM3mCfqSR60VU91qaOlwrnPfboviWbPEuYSvW7w4lRjM3K9BhG26Z/ucICo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2346

Hi Daniel,

On 9/13/21 9:32 AM, Daniel Wagner wrote:
> On Thu, Sep 02, 2021 at 06:11:21PM +0300, Jussi Laakkonen wrote:
>> Do not allow to add errors for provider that is already set into idle
>> state or is in unknown state. This case may happen when networks are
>> rapidly changed and VPN did not call the callback connect_cb() until the
>> VPN is died and vpn.c:vpn_died() initiates cleanup in the VPN which
>> eventually calls connect_cb() with an error.
> 
> I wonder if we should set the VPN state immediately when starting the
> connection process to some value != unknown.
> 

Perhaps. But that would need a bit of more work to make sure the state 
machine is not getting any new issues introduced. Maybe a task for some 
later work to improve that. Unknown is not perhaps the best 
representation as a name for that but it does the trick and works, as of 
now :).

>> ---
>>   vpn/vpn-provider.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
>> index f30ce04f..90e21e95 100644
>> --- a/vpn/vpn-provider.c
>> +++ b/vpn/vpn-provider.c
>> @@ -2026,6 +2026,21 @@ int vpn_provider_indicate_error(struct vpn_provider *provider,
>>   	DBG("provider %p id %s error %d", provider, provider->identifier,
>>   									error);
>>   
>> +	/*
>> +	 * Ignore adding of errors when the VPN is idle or not set. Calls may
>> +	 * happen in a case when networks are rapidly changed and the call to
>> +	 * vpn_died() is done before executing the connect_cb() from the
>> +	 * plugin. Then vpn.c:vpn_died() executes the plugin specific died()
>> +	 * function which may free the plugin private data, containing also
>> +	 * the callback which hasn't yet been called. As a result the provider
>> +	 * might already been reset to idle state when the callback is executed
>> +	 * resulting in unnecessary reset of the previous successful connect
>> +	 * timer and adding of an error for already disconnected VPN.
>> +	 */
>> +	if (provider->state == VPN_PROVIDER_STATE_IDLE ||
>> +				provider->state == VPN_PROVIDER_STATE_UNKNOWN)
>> +		return 0;
> 
> Checking the unknown state looks here a bit strange. The usual meaning
> of unknown is it hasn't been initialized. But then this is exactly
> what's happening here I assume.
> 

Yes, to cover all the cases as we may get these checks for a new VPN.

Cheers,
  Jussi
