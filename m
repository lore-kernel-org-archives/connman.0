Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC71168
	for <connman@lists.linux.dev>; Wed, 18 Aug 2021 09:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKdHN4+YVHv7APPpguFTAtgVZK3rUl2J1M+u0CO0BcJQ4xvgaAm3tE29TcYl6DQa7wbBpnlrRHrdSi9LSOOPRjIgZP43FuPm9qwJa5anyP3Zey3EBPb8NrtakHiGlIv1bm5P6BB3rQjucrxB4hZwOQ2H++uUGl2GHbedqArGs6HmtrkqH1zv4c5DZ/SXI5QbQS7bjln0ZMxP1nauHjZzN8ik6GY/Yi9uqshCkFueIrs+k9MTd1mgoootbmCfb80Ju3RYIbuNS/Yjb6vEB5h6uvmmjqFkFlR7gXjph7fTIDWDcebSIHj+owKJPRb0hGcMoTOqpfFKSwhY64N/A72Oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YejjxFn1/PRfsAUQgGgUJFMpaT83UTmx9+pR9On9J1Y=;
 b=nLUxBizD31DgWbpUcA0ZV1Jwf7vbEMwvV2KAFaG+4L3rT4CFeCPC4PSTGL9VhnKLU224Q2HC+qa+FOZhgS+AFH0YpEbrPdQ5sxAIXAKZiim6lGEpF6nZ50iQyyo+R7qHiH2H9+3DSh3Z2efRzqpWqZw7G9QLCSNQnehH0WDc3r/mklY5jfyGf/YIjz7esNSU+96lXyexW9roDTrqZ6UNMVMCCrlZDmKp7NO/yJA9yzs2cTkXQcNKzBayXtz1ccAfwf9N4gopB2V2ZqBvZ3TMXrOncaFozNpb6XKXZAthh0ILza6H+IuytBfglc3jGcpjVgcP7XamuhFfM1ktBIpPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YejjxFn1/PRfsAUQgGgUJFMpaT83UTmx9+pR9On9J1Y=;
 b=ghb7jT0P6uhuYe9Cowlumk6gRflmGumzUUaJaMRQk62WcXangf9LZ+JIwKmwxGQwC5PI/m8jN7LfpvpZOBPSikbiFyx/e5/8MT7RQk0dbTCefOw+pUR002I2ml2olCMP6cfVPT/e9mBF/AibWF+Yabw1JvICkvx1QGf1su6Lnj84T5kbSrh3u5TwgZCf5OgHarS2QkVUb+u8z8PTc+TIPN3LDAzZztskt0DjsRdILYuMzME03xDK/YV4BkpP20imwvZjWzz8AV8H1TyY7gHLZQgOmB1zrGzhnZ6wSql7hsUmWRyxzPl1pAno3FpXsGYcabwuWRjg1XGQo4PLPDeJow==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0601MB2604.eurprd06.prod.outlook.com (2603:10a6:3:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Wed, 18 Aug
 2021 09:21:26 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 09:21:25 +0000
Subject: Re: [PATCH 1/2] vpn-provider: Implement connmand online state
 checking
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20210817151443.32305-1-jussi.laakkonen@jolla.com>
 <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210817165528.amfp4fyf22ljaehz@carbon.lan>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <7f6eb47b-85fb-4bd8-2be2-dff6518f6a4a@jolla.com>
Date: Wed, 18 Aug 2021 12:21:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210817165528.amfp4fyf22ljaehz@carbon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0096.eurprd04.prod.outlook.com
 (2603:10a6:7:54::25) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.0.5] (194.110.84.60) by HE1PR0401CA0096.eurprd04.prod.outlook.com (2603:10a6:7:54::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 09:21:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5f4fa5-68ec-4530-fd91-08d962298d6b
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2604:
X-Microsoft-Antispam-PRVS:
	<HE1PR0601MB2604BE9006BD79BD53F94053EFFF9@HE1PR0601MB2604.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sgS/kfyXPsu3KTuHnUmQxdIVerX4iB/FYWB32ucoKQBT5O8IwydxX7xfqScdTNrNYpaet/lUwyZr73waqTSKeJEgRcfYUzLt8jt6QVFz5isaaNCaFPTzFmTZ7wFPcObDPJH1Lu1qpX5P/sfkw1kBNiTaH+POTgU6/kq2v9Dncgo5xMi++scewKWVSlli+IFuSgzAnR1J5giQfH2H+6fj9g6ouGdvOW1mRuabSMw8UXJtMqvMSqsKbV64eDAdqg0P7v6lz6Szkj6V1Wgs9m+BJFAjPHoIhEQuuNANew6hoHdTld6sQ6EL23EOILCPGhHaV8HbguDMwpajWVmyZyKighzoa77HcBg84RTzmwQqRD95/MLxGFYjf4eJoDSwDbBgYQ5uIkgINwwbpuM/fusUpYv97kbxO7QinHAOPcBfix5UOzCcyXpx/HqCjOMYlmuCVwjD+r0e0XlW7o/g6fGPRjBWS7qH1xNGuDu7RoNreSLRPg8a4kY50wv0+8WWdTmbTSUDvo4avbKJs2+yqpk6oAgdqqB/Ohoazqwpoj0pYymJcvGKDhthRXiwNy/ChvXWTkgfqs3X5bwtcgBPAvhxduNPZwPZc+7lnitxJueq+xJW0Z8pGi1a1kjW2dBqn8K9q5e0VmIDQE5cZmzMR7/A6NxRsYkPdS+LSiXSRIBreZCMBfVOkt55K6ikZQubegSeQG4OVe5tO/JZ2cx1AAYfgJJQwlcPK//MbZEYCoZ2CB7+glq1uc5BVsb4pbQUHi+ENIQWEcYDb3Ea6rELtCVzsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39830400003)(346002)(36756003)(8936002)(6916009)(31686004)(26005)(316002)(2616005)(16576012)(8676002)(4326008)(5660300002)(83380400001)(53546011)(6486002)(186003)(956004)(44832011)(66556008)(38350700002)(66476007)(2906002)(31696002)(66946007)(38100700002)(478600001)(86362001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVBqVDA0S05pTkdVa3BWRFV5cG1BeEFCa2JoS2NXZXo5TjAvcnFsWjZVQ3dU?=
 =?utf-8?B?K2h3UTh2bXByaWdIWHd2bHRtS1ZlUHpwb1dNRFhRZHUyc040ZmJLajUzZHc4?=
 =?utf-8?B?azJCL1BINW4xMDhrSUk2N0tGY0h4cXQyUkEzNHZPdi9YNWVZYWtnY0huT3Zk?=
 =?utf-8?B?QU1yUlozUE53c2xFNitRVjBRckNYMWUyRDJsZVRJclBaY1FtL3dpQ1ZSWTU5?=
 =?utf-8?B?RlhUVnZ2SFdLZ3ZyL1JZT2lEZ3Y4bTR3Q1A4cStGMDJsbDd2bVlWWThkVm0r?=
 =?utf-8?B?ZlJkSDFRWTZPNDlqaWltY2VnKzMraFpXR2IvS1JuNVRnRzZ6MzVOZ3ZYaU9D?=
 =?utf-8?B?Mmd1OHJCZnhLRjNNRmp1dlBpR0ZNMDR0VXc3dUxFMThFdlZzMDhGMHBaeTR6?=
 =?utf-8?B?ZTd6MmlMbXNGdU5EZmtoRVc2NVhCMkExYnk2RkcyRGh6MnI1RkV0b2YvaXFM?=
 =?utf-8?B?bnVGd1VDQ1hQWDdiRXN6MXdzbUVNK2xkZGx0QUNFNXZZcStHV2ptRENMZ08r?=
 =?utf-8?B?VHNpcXlMT1RQaWMvOXlXNzZLRFlhV05yS29KN3FKQzg5Y2w0Y0FvYTlFb2JM?=
 =?utf-8?B?YUIzSVk5MnhzTUJsVktXMlF5ZkVvQldQR1l6Y3lVczhIRk5MR2NCWFBHS3ZJ?=
 =?utf-8?B?VWlkcFMyS052cXIyU05hYnlTZzZwenpmOU9QcnhhNFhpdDljTUpVeUFobWdK?=
 =?utf-8?B?U2ZwTVVhUzlhV2Y0bmFNUkVDNkVlL1E0REx1Zkpqa3lCcml6WFpCdThkVEx4?=
 =?utf-8?B?a3l0SFE4M2pyOTNkeFNvSGoxVXJVbGQ1Qk4va29ISG5JcXQwRGhJaElNRnJq?=
 =?utf-8?B?bkg4U0t4SDdDRGlGc2dCN1NERjYvT0pRMGtTUlhsdFRBMTFGN2t2OUJlTXA5?=
 =?utf-8?B?THRFY2lHYVpzRUR5emNsS29pdzRZQ2xiVU4rM2FBR0JwNGp6OGw1V1dHMUNJ?=
 =?utf-8?B?N2NPN0ZaSmVLdEVlN292aGdqYXh4amNzZTFEbmpvV0FjUEphM1NFeEdPUXNZ?=
 =?utf-8?B?RTA4QUp2YVR2RjVjNnFJUHF5N1pvdldrV1lTL0djbnZjZHNTOUZzQXB6TmJ4?=
 =?utf-8?B?UzlJMm9iWk5KSXUxOEt2a05KYVlkek9nenVWd3JoaHJXTDZrSTh0WGJCbDAr?=
 =?utf-8?B?Y0xRSnVBMCtWNXJ0UGE0NGc0MzErejA1MElQQTF4WnpOTm8zTHVudWtrbFdl?=
 =?utf-8?B?QkV1Tjg0TmRybk1KTDZkVVRvU2t4Y2gwZ21JdW41YjdqUEltNjYyNlFTVjVt?=
 =?utf-8?B?dFNpeDFGNGREWHova1EwaEcwQUlCN2JaanZ6bDI5WVJUWW1FaDVTUXRVcGtM?=
 =?utf-8?B?Zm5Yd1NRNk9meHFRMGJZMDBLZWtmUml6dDkzdTc5U0t0YVhZNHJueXYyUTFG?=
 =?utf-8?B?RFBVSUdEQk82Sk5PNVh1WVMya29vSVUwdTVqNnJGY1EwVUpxdlJZZFp5YTJq?=
 =?utf-8?B?ZDA3MUl1Q0xYU1NMaW4vOVVYOThqVE5sRkRaRXByZCtQdzI5UllnNDFTU2VL?=
 =?utf-8?B?U2RwL0Z3YnJFci9reTJPL1RKajhZdUpuTUI4VDVsZWFhRXZnbWowZ0RDMHhv?=
 =?utf-8?B?Z2QyMTRjTVkzRlJzNGZhZHRBcmdOcktQMFdkQkRNeHVUZHJrMVpxbjVlTE5Y?=
 =?utf-8?B?cUpnK1RoNWJiUTlaL1NBam9Wdkt2MVhucHNEMmhVcnQ1aGZUUWltOHhWdHl0?=
 =?utf-8?B?WXQwdU1BMUpKdUV6bDc3SjM4S0ExV0NCaEZKK2pSMW1HWXZ2OXpSZTBPWEJF?=
 =?utf-8?Q?bctEHx6t79u8lH4j7Iz6KMZCf15H6BYz4X7I4Iu?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5f4fa5-68ec-4530-fd91-08d962298d6b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 09:21:25.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVUOYsPneQwz9f7lASMsB5shHA7rExOpYeN999rOnq+UrpFzP34gvm3i5y7kBBiYgYznDKRVSorHe2fx9fWXpXzwAEdYtdfedOCKimYMUuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2604

Hi Daniel,

Thanks for the comments. This piece of code has been running in our fork 
for approx. 3 years but that does not mean there wouldn't be any issues 
to fix or to improve.

On 8/17/21 7:55 PM, Daniel Wagner wrote:
> Hi Jussi,
> 
> Just a bunch of small nits.
> 
> On Tue, Aug 17, 2021 at 06:14:42PM +0300, Jussi Laakkonen wrote:
>> +static gboolean do_connect_timeout_function(gpointer data)
>> +{
>> +	DBG("");
>> +
>> +	/*
>> +	 * Keep in main loop if no agents are present yet or if connman is not
>> +	 * yet online
>> +	 */
>> +	if (!connman_agent_get_info(NULL, NULL, NULL) || !connman_online) {
>> +		return G_SOURCE_CONTINUE;
> 
> Doesn't this get the mainloop busy looping?
> 

As far as I can remember this is intentional. This is added to mainloop 
with 1s delay in do_connect_later() for the delayed VPN connect so I 
guess looping with 1s interval is not too busy?

>> +	} else {
> 
> As there is a return above, no need to do a else statement. Makes also
> the indention one less :)

Yep, that cleans up the rest as well a bit.

> 
>> +		struct vpn_provider_connect_data *cdata = data;
>> +		struct vpn_provider *provider = cdata->provider;
>> +		int err;
>> +
>> +		provider->do_connect_timeout = 0;
>> +		err = __vpn_provider_connect(provider, cdata->msg);
>> +
>> +		if (err < 0 && err != -EINPROGRESS) {
>> +			g_dbus_send_message(cdata->conn,
>> +				__connman_error_failed(cdata->msg, -err));
>> +			cdata->msg = NULL;
>> +		}
>> +
>> +		return G_SOURCE_REMOVE;
>> +	}
>> +}
> 
> [...]
> 
>> +static void do_connect_later(struct vpn_provider *provider,
>> +					DBusConnection *conn, DBusMessage *msg)
>> +{
>> +	struct vpn_provider_connect_data *cdata =
>> +		g_try_new0(struct vpn_provider_connect_data, 1);
> 
> Do a g_new0() instead of a g_try_new0().

Right, will do this was following the old coding style :).

> 
>> +
>> +	cdata->conn = dbus_connection_ref(conn);
>> +	cdata->msg = dbus_message_ref(msg);
>> +	cdata->provider = provider;
>> +
>> +	if (provider->do_connect_timeout)
>> +		g_source_remove(provider->do_connect_timeout);
>> +
>> +	provider->do_connect_timeout =
>> +		g_timeout_add_seconds_full(G_PRIORITY_DEFAULT, 1,
>> +					do_connect_timeout_function, cdata,
>> +					do_connect_timeout_free);
>> +}
>> +
> 
> [...]
> 
>> +static gboolean run_get_connman_state(gpointer user_data)
>> +{
>> +	const char *path = "/";
>> +	const char *method = "GetProperties";
>> +	gboolean rval = FALSE;
>> +
>> +	DBusMessage *msg = NULL;
>> +	DBusPendingCall *call = NULL;
>> +
>> +	DBG("");
>> +
>> +	msg = dbus_message_new_method_call(CONNMAN_SERVICE, path,
>> +		CONNMAN_MANAGER_INTERFACE, method);
>> +
>> +	if (!msg)
>> +		goto out;
>> +
>> +	if (!(rval = g_dbus_send_message_with_reply(connection, msg,
>> +		&call, -1))) {
> 
> Move the 'rval = ...' outside the if condition.

Thanks for pointing that out. It looks indeed messy.

> 
>> +		connman_error("Cannot call %s on %s",
>> +			method, CONNMAN_MANAGER_INTERFACE);
>> +		goto out;
>> +	}
>> +
>> +	if (!call) {
>> +		connman_error("set pending call failed");
>> +		goto error;
>> +	}
>> +
>> +	if (!dbus_pending_call_set_notify(call, get_connman_state_reply,
>> +		NULL, NULL)) {
>> +		connman_error("set notify to pending call failed");
>> +		goto error;
>> +	}
>> +
>> +out:
>> +	if (msg)
>> +		dbus_message_unref(msg);
>> +
>> +	/* In case sending was success, unset timeout function id */
>> +	if (rval) {
>> +		DBG("unsetting get_connman_state_timeout id");
>> +		get_connman_state_timeout = 0;
>> +	}
>> +
>> +	/* Return FALSE in case of success to remove from main event loop */
>> +	return !rval;
>> +
>> +error:
>> +	if (call)
>> +		dbus_pending_call_unref(call);
>> +
>> +	rval = G_SOURCE_REMOVE;
> 
> This looks wrong. Shouldn't this be either TRUE or FALSE?
> 

Hm, as a return from a GSourceFunc G_SOURCE_{REMOVE,CONTINUE} is 
documented to be a more memorable name. But I think as well that in this 
case use of those as mixed, in addition to the comment, just creates 
more confusion. Yeah, maybe it is better to use here that as clear 
TRUE/FALSE.

>> +	goto out;
> 
> Please try to avoid jumping up again. Forward goto's are easy to read
> but the backwards one tend to be hard to grasp (at least for me).
> 

Ouch, that indeed looks a bit messy, hah. I'll refactor that a lot. 
There seems to be indentation refactoring needed as well.

I'll send v2 today at some point.

Cheers,
  Jussi
