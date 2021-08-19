Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68A6D1B
	for <connman@lists.linux.dev>; Thu, 19 Aug 2021 12:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEqDuAoUDVbILtSWC7mkBjfQCMwQpBBroqPh2JZdVFhg27c3Wf3aKpq4yKtCUB5H+/SpSWFbFMpj9N2XmknTrMlP782WlJjaMfi5/DqhKG5K1QOR1JuNMmiJCxZWEp521Vy1ULIPHoksh0YGwZtkhTsjmr3EGqnrPJ1nGoRrF6GrFCF51gI/btNoEFUwfFrkWwEQSc3HNtukjNLUoJOo+76cDrMLU8rsi1e7RSZrn829/7Z7fL5PjWzORbMI6WF095kCnYh1wPPDxaKmMA9WcijHbtZbhZ0XnFT6VRNBVtUBuBPu/KGF8c9DnvZaVew7H8TYOsVNDu9oPmcSUTsrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO+Aj6lCBxrpmzCBYimNzJ8U16rCMaIOB9kKuayHAYM=;
 b=oe5wY+ulZNifiHqKwODc2VZoKCm4ttPV7UkVEg+8bM6VwNtSGDFEcHcyK6dD4XWCJsVsW8yXwuEWFYtsEa7gWOdVr/Ri+Juu6Sj9AT4ROSYI6lAjU3mJqXH23g9L/xO8sEV35tt8s4ZsILI1psMajFRY226z4ZaLAB/l5lQuccOF+A7+2qe6ocZtbdQrw5X8VSg/+tmAJCbdRVedico2teiGDVcMOdJybMWj8hsUuxdEsxYcNQHSVGCgEadPran+EcnYcatJdbf6vUds2dRTHioQKsGwl0R2HsCHXlXq06VOWdN6YFUksQUWv8EMEmj4Ix6M4RTVh+EPTVlrgm7Buw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO+Aj6lCBxrpmzCBYimNzJ8U16rCMaIOB9kKuayHAYM=;
 b=GFabvNXdvy6VwjeYpOap4yYLOqtZNIu9oYQu594LFugIzgbnX0JgvBBzZf/8CHGPlolGvPmEsrDHQGZy4sg6TXbHFE9Oo/bfBnp9fnky+lBp+1fU5eRVLTSqIERdq3Fx+xZU9UBeJFPkD17J/yfMbl4/31/PiHho9ol9n+ZxI5rRr5XlwgkiEbzKan+E+XF/zuZMSHah2qYMjmNMXUA9p28PjZMTpXbzqrd7IWDO2N6NZUPcfJ4L+PUst7LrN1Kh6N5tIVzJn3twvXpej+nArcIszCHp/4h0RLo7laVxkcqPEbZND68z/jgpwQTpjytJfRwDYCKxlCgS5WIhMp+HEw==
Authentication-Results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0602MB2794.eurprd06.prod.outlook.com (2603:10a6:3:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 19 Aug
 2021 12:11:24 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 12:11:23 +0000
Subject: Re: [PATCH v2 1/2] vpn-provider: Implement connmand online state
 checking
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev, Daniel Wagner <wagi@monom.org>
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210818103137.17409-1-jussi.laakkonen@jolla.com>
Message-ID: <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
Date: Thu, 19 Aug 2021 15:11:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210818103137.17409-1-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::27) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.2.6] (194.110.84.61) by HE1PR09CA0059.eurprd09.prod.outlook.com (2603:10a6:7:3c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 12:11:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b5afdf7-ed06-4ce0-1080-08d9630a763c
X-MS-TrafficTypeDiagnostic: HE1PR0602MB2794:
X-Microsoft-Antispam-PRVS:
	<HE1PR0602MB2794296DA3C597D1A087F384EFC09@HE1PR0602MB2794.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hf4QJ+3K0Ysp3dluuqE9c+5vhooEK1UvMESnbkLX63w7JZSXObye4JVaLPbMyp9Udl8KvML8iNhbkhFpG6dqviq6SPwVF+hvj5sHQ+RIzFxL0KCH+uYf2fvVqKZfhGmdxaQSkgEZ+hics+8zFvVQwUm66URwnufiST+XyoB2ecgDuAhU5DUH0IJbcFmZfU8rLm4Jnxtfw1sFYHLaUcXTQKptwZB0SIBUaj6HAUY7dPvK8vaPpxc6Hly8PSJ3VdvzROzIoHc3nMW/9HBnSEPLy09rEBZ/YZjQ6TmbdS0WMvUlVXsvrr5ycWkiHrOBJspKBxygDOZrQPCoZTkeE+UmVoPDIT+1wzT5AaI4+uqp7h0URLJcmNjJ5dMs0sRNu020FRikfuJBgkJYpjy9oDVM+mO2w7A4eSjRDxcQcLfTu7WXmnbgtbPdXr3k3RWskdfebMegzQI7RQ9VaxUjk4DpsPMckf/ZMTffQk8oH0PpsFEG0E4IQUgoj3bIwj3ohWKWv8LpHcT+9KrtTpKdypGVvUWxWo56J+ZtTezsvn7fwHyOEC3K6pwt5rK+aWFD7ZuA342c3rvdDocIhHWNQRM91/rvHYuexJMTtHgnFzbG3ELNUjUifzKgion2m1ieGrLAC0MaOQztdfvj0EmI/v+jbUydlNsQQo1FLjNQt+89sGSmPgyV6C1bWqMCuCttyB7NEx7nztSAqyyc8u5uHhP8kNI4VWu1kRFpZf6dJb2g+uXHuatw/S2Hxs+x86y7/zA0VcIpSwk1uqVIVpfBiO+DUiKfU7mHZr161dgVojhQ/Fg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39830400003)(366004)(396003)(376002)(44832011)(26005)(2906002)(6486002)(30864003)(8676002)(66556008)(5660300002)(478600001)(956004)(316002)(16576012)(31686004)(6916009)(66946007)(52116002)(38350700002)(83380400001)(38100700002)(186003)(2616005)(53546011)(86362001)(36756003)(31696002)(66476007)(8936002)(2004002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VExPaVEvNC96T1llZjFoL3RPeHM5N1lnU0FNMTYxeDFYVVJ0NVNoZFJET21t?=
 =?utf-8?B?TlVESnlrcGsvV0ZPbU1jUjBhSWdjY0c4R3dabnk3N1RIanZadTd5V1NIYlpT?=
 =?utf-8?B?QXRJZ0hSMmNBbnp6WTgvYS9VME5UcVhzYlh0eDFEQkJHQVorSzJHN3ExSFpU?=
 =?utf-8?B?SFBPak0zYXVKcG1YWVZVZTRnNmQzV2ZzQ3JBOW5UOWNjTkdqSU1rZXdiODlp?=
 =?utf-8?B?ZDNJL1g3S1BzcWhJMGQwZFRMS1FYcmdjY3JqWFIxSXJSSVlOVmh4SXhmbmpD?=
 =?utf-8?B?L2l3SmE1YzFlWFVRNWpqSVZsZCtjQ2dQQm5VMUJiS0p3N3kySWJVMmxBWFVX?=
 =?utf-8?B?bUN2U1BhbFhYenY5TDJ5aFZhSWJUaUtINXp6R09GaVlXbDE0R0hzbzFiczB1?=
 =?utf-8?B?ZWc5cngybmFoNUpQUUVUcWk4N0JsWVlBTE9zZnQvVXVMeldPNWthY1RRcEpF?=
 =?utf-8?B?aGdadCsxTW1rVEJ1U3pYalBleTErUU9CeGVtUGhkcStYT3AvK1pSK0tyd1Nj?=
 =?utf-8?B?UjVBVWxBR29raFZJVWpCTi9HKzhMQ2YvMWtiOUw2alBnNndKUDB0NEw5SlZV?=
 =?utf-8?B?Wm16SGNicGZ6cXgyYUQyZWdEOVFMUElvdUFicUwyNTlVK1JyMTRqUVZYeGFY?=
 =?utf-8?B?dTJEM29XWFo0azVRNzJvZ01EWml4N0pSakNrT28zdjl1TXNRNXFYd0dQcFRi?=
 =?utf-8?B?M2drSWNMY2E4M2ozZUlYbkVnam8yMUFiMzZ3QlJCWjkwalhjWmw1V1BJQVFF?=
 =?utf-8?B?bmpNU3VCenpDaFNTaGJkODdUZWpBRTRSU0djR0ZjKzY5eTNuc2JEYWxhOTJw?=
 =?utf-8?B?K0pmS0x1dllWTnF1WUVjWUY3blVGT05PY00xdTQ1QlVRNEJPbFl1NnZnVmgx?=
 =?utf-8?B?R243VjVDWjRCL2IvanBGc1BlYWJGY0hXc0lsb3N4S0RYejk0QXpOY3F4T2Zt?=
 =?utf-8?B?RXdkZXdURHJUZExDWjhPQVlwbWVJcVV2UFA5MWJFRzM5eFd2Z0xGUjBNTjN3?=
 =?utf-8?B?Q28xNzhPbTd4dUs0L0YweWpHek53ZkhHNzVnUTlvTUtuTE1GdjFBOHZLOEs2?=
 =?utf-8?B?R3BMeDlTcHlnemxqSExrTkxGdmVFWlk2dVpxTVp1TWNKbk5nd011Zmo3YmJl?=
 =?utf-8?B?THZKVTBDVEwxZFVoMUtvekdyTndXUTBRRGV0NERpMFEvRmtVR1JjejFsUkRy?=
 =?utf-8?B?emhNTU80UjkzTFBEL0NTY0p2OEs4YzlsQm1WSDBpbFUyY3EyMDl3WVBxc2Jo?=
 =?utf-8?B?ZXVaMC9Uajlad09FMEZJRFRFblU4TTFud2ZWRTZGUDNwQ1lZeXl3S2RBaUVF?=
 =?utf-8?B?NW9IYjZScGhWU2M4U2ZoZ1loSGo3ampMNzhtYWYwOFNxU3ZYZmthMXJpUi9r?=
 =?utf-8?B?eCt0Z0VHNjZTZi9OSStBbWdoQXdXTnpiVEsvSUlkdys5S0tYNm9zUU5TZ0x1?=
 =?utf-8?B?WUVVNCt3V09oMEdsYTd4VDVuRnFtNXVYaXVVdVBKbXZRbnRFaHoxem84ZTd5?=
 =?utf-8?B?bnhGYlFlbGY5b0pxUms0cHIrMU5GSGxDcHRkcTV1SFpZaWRwUDFhcmN1ZmZt?=
 =?utf-8?B?VVMyN296V2wxU0g5NmMvL1VsQWJUMm1SWHZQa29OcWVab1VVSkw4aU9NV3Qy?=
 =?utf-8?B?clNnQ0NHa1hDb3dDYzI4QUhFenVpVEFDMnZHNysyRGVEd0IzbFJ0SU5Eb1JP?=
 =?utf-8?B?ZmJFS2FlRExTYUQrWmVMdjZTMGxOUEV6SlFCM3Y5WDBjeDFHT2FOcTFBdVpC?=
 =?utf-8?Q?a1xql2aRx6cWPhqmmodOWqPhuOjMN0x/vmvA62h?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5afdf7-ed06-4ce0-1080-08d9630a763c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 12:11:23.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnO/w0+++49CKcZ34f7GP82cIKbHivo1uPhoEZEdnzERKrnb2JCcQtsTmwNYpoXDPRrN37XoNCEJOdSjGnS/ACYB4bdNp3WdvpuLndorNQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB2794

Hi Daniel,

Sorry, I spotted some error with this as apparently our fork has 
something again done differently somewhere. I'll send another version 
when I find the cause. Does not seem to function correctly on top of 1.40.

Sorry for the inconvenience.

- Jussi

On 8/18/21 1:31 PM, Jussi Laakkonen wrote:
> Add a complete mechanism to track connmand state and query it if
> necessary to avoid connecting VPNs when there is either no connmand or
> no network to use. This also makes VPNs to disconnect when connmand
> loses its online state or disappears.
> 
> The connmand state listener uses net.connman.Manager interface to get
> the state using GetProperties at startup. PropertyChanged signal is
> monitored for state changes to update the state. State is changed and
> queried when the D-Bus service listener is notified. Connmand state is
> tracked within vpnd with a boolean: "true" = online/ready, "false" =
> offline/idle.
> 
> Also a feature to support delayed connecting of VPNs is added. It may
> happen in a situation where ConnMan status is not queried yet and
> a request to connect is received over D-Bus. In this case a timeout
> function is added to the main loop that runs with 1s interval. When the
> delayed connect function is running it keeps on trying until connmand
> state is online/ready. If connection request comes when the state is
> queried and it is not online/ready ENOLINK is returned as an error
> ("NoCarrier" D-Bus msg).
> ---
> Changes since v2:
>   * Cleanups and fixes to follow coding style.
>   * Refactor run_get_connman_state().
>   * Replace g_try_new0() with g_new().
> 
>   vpn/vpn-provider.c | 362 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 361 insertions(+), 1 deletion(-)
> 
> diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
> index 59c805c5..72245794 100644
> --- a/vpn/vpn-provider.c
> +++ b/vpn/vpn-provider.c
> @@ -3,7 +3,7 @@
>    *  ConnMan VPN daemon
>    *
>    *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
> - *  Copyright (C) 2019  Jolla Ltd. All rights reserved.
> + *  Copyright (C) 2019-2021  Jolla Ltd. All rights reserved.
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -24,6 +24,13 @@
>   #include <config.h>
>   #endif
>   
> +#define STATE_INTERVAL_DEFAULT		0
> +
> +#define CONNMAN_STATE_ONLINE 		"online"
> +#define CONNMAN_STATE_OFFLINE 		"offline"
> +#define CONNMAN_STATE_READY 		"ready"
> +#define CONNMAN_STATE_IDLE 		"idle"
> +
>   #include <errno.h>
>   #include <stdio.h>
>   #include <string.h>
> @@ -89,15 +96,55 @@ struct vpn_provider {
>   	struct connman_ipaddress *prev_ipv4_addr;
>   	struct connman_ipaddress *prev_ipv6_addr;
>   	void *plugin_data;
> +	unsigned int do_connect_timeout;
>   	unsigned int auth_error_counter;
>   	unsigned int conn_error_counter;
>   	unsigned int signal_watch;
>   };
>   
> +struct vpn_provider_connect_data {
> +	DBusConnection *conn;
> +	DBusMessage *msg;
> +	struct vpn_provider *provider;
> +};
> +
> +static unsigned int get_connman_state_timeout = 0;
> +
> +static guint connman_signal_watch;
> +static guint connman_service_watch;
> +
> +static bool connman_online = false;
> +static bool state_query_completed = false;
> +
>   static void append_properties(DBusMessageIter *iter,
>   				struct vpn_provider *provider);
>   static int vpn_provider_save(struct vpn_provider *provider);
>   
> +static void get_connman_state();
> +
> +static void set_state(const char* new_state)
> +{
> +	if (!new_state || !*new_state)
> +		return;
> +
> +	DBG("old state %s new state %s",
> +				connman_online ?
> +				CONNMAN_STATE_ONLINE "/" CONNMAN_STATE_READY :
> +				CONNMAN_STATE_OFFLINE "/" CONNMAN_STATE_IDLE,
> +				new_state);
> +
> +	/* States "online" and "ready" mean connman is online */
> +	if (!g_ascii_strcasecmp(new_state, CONNMAN_STATE_ONLINE) ||
> +			!g_ascii_strcasecmp(new_state, CONNMAN_STATE_READY))
> +		connman_online = true;
> +	/* Everything else means connman is offline */
> +	else
> +		connman_online = false;
> +
> +	DBG("set state %s connman_online=%s ", new_state,
> +				connman_online ? "true" : "false");
> +}
> +
>   static void free_route(gpointer data)
>   {
>   	struct vpn_route *route = data;
> @@ -740,6 +787,64 @@ static DBusMessage *clear_property(DBusConnection *conn, DBusMessage *msg,
>   	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>   }
>   
> +static gboolean do_connect_timeout_function(gpointer data)
> +{
> +	struct vpn_provider_connect_data *cdata = data;
> +	struct vpn_provider *provider = cdata->provider;
> +	int err;
> +
> +	DBG("");
> +
> +	/*
> +	 * Keep in main loop if no agents are present yet or if connman is not
> +	 * yet online.
> +	 */
> +	if (!connman_agent_get_info(NULL, NULL, NULL) || !connman_online)
> +		return G_SOURCE_CONTINUE;
> +
> +	provider->do_connect_timeout = 0;
> +	err = __vpn_provider_connect(provider, cdata->msg);
> +
> +	if (err < 0 && err != -EINPROGRESS) {
> +		g_dbus_send_message(cdata->conn,
> +				__connman_error_failed(cdata->msg, -err));
> +		cdata->msg = NULL;
> +	}
> +
> +	return G_SOURCE_REMOVE;
> +}
> +
> +static void do_connect_timeout_free(gpointer data)
> +{
> +	struct vpn_provider_connect_data *cdata = data;
> +
> +	if (cdata->msg)
> +		g_dbus_send_message(cdata->conn,
> +				__connman_error_operation_aborted(cdata->msg));
> +
> +	dbus_connection_unref(cdata->conn);
> +	g_free(data);
> +}
> +
> +static void do_connect_later(struct vpn_provider *provider,
> +					DBusConnection *conn, DBusMessage *msg)
> +{
> +	struct vpn_provider_connect_data *cdata =
> +				g_new0(struct vpn_provider_connect_data, 1);
> +
> +	cdata->conn = dbus_connection_ref(conn);
> +	cdata->msg = dbus_message_ref(msg);
> +	cdata->provider = provider;
> +
> +	if (provider->do_connect_timeout)
> +		g_source_remove(provider->do_connect_timeout);
> +
> +	provider->do_connect_timeout =
> +			g_timeout_add_seconds_full(G_PRIORITY_DEFAULT, 1,
> +					do_connect_timeout_function, cdata,
> +					do_connect_timeout_free);
> +}
> +
>   static DBusMessage *do_connect(DBusConnection *conn, DBusMessage *msg,
>   								void *data)
>   {
> @@ -748,6 +853,29 @@ static DBusMessage *do_connect(DBusConnection *conn, DBusMessage *msg,
>   
>   	DBG("conn %p provider %p", conn, provider);
>   
> +	/* Check if any agents have been added, otherwise delay connecting */
> +	if (!connman_agent_get_info(NULL, NULL, NULL)) {
> +		DBG("Provider %s start delayed because no VPN agent is present",
> +							provider->identifier);
> +		do_connect_later(provider, conn, msg);
> +		return NULL;
> +	}
> +
> +	if (!connman_online) {
> +		if (state_query_completed) {
> +			DBG("Provider %s not started because connman "
> +						"not online/ready",
> +						provider->identifier);
> +			return __connman_error_failed(msg, ENOLINK);
> +		} else {
> +			DBG("Provider %s start delayed because connman "
> +						"state not queried",
> +						provider->identifier);
> +			do_connect_later(provider, conn, msg);
> +			return NULL;
> +		}
> +	}
> +
>   	err = __vpn_provider_connect(provider, msg);
>   	if (err < 0 && err != -EINPROGRESS)
>   		return __connman_error_failed(msg, -err);
> @@ -1269,6 +1397,9 @@ static void provider_destruct(struct vpn_provider *provider)
>   {
>   	DBG("provider %p", provider);
>   
> +	if (provider->do_connect_timeout)
> +		g_source_remove(provider->do_connect_timeout);
> +
>   	if (provider->notify_id != 0)
>   		g_source_remove(provider->notify_id);
>   
> @@ -3214,6 +3345,213 @@ static void remove_unprovisioned_providers(void)
>   	g_strfreev(providers);
>   }
>   
> +static gboolean connman_property_changed(DBusConnection *conn,
> +				DBusMessage *message,
> +				void *user_data)
> +{
> +	DBusMessageIter iter, value;
> +	const char *key;
> +	const char *signature = DBUS_TYPE_STRING_AS_STRING
> +				DBUS_TYPE_VARIANT_AS_STRING;
> +
> +	if (!dbus_message_has_signature(message, signature)) {
> +		connman_error("vpn connman property signature \"%s\" "
> +					"does not match expected \"%s\"",
> +					dbus_message_get_signature(message),
> +					signature);
> +		return TRUE;
> +	}
> +
> +	if (!dbus_message_iter_init(message, &iter))
> +		return TRUE;
> +
> +	dbus_message_iter_get_basic(&iter, &key);
> +
> +	dbus_message_iter_next(&iter);
> +	dbus_message_iter_recurse(&iter, &value);
> +
> +	DBG("key %s", key);
> +
> +	if (g_str_equal(key, "State")) {
> +		const char *str;
> +
> +		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_STRING)
> +			return TRUE;
> +
> +		dbus_message_iter_get_basic(&value, &str);
> +		set_state(str);
> +	}
> +
> +	return TRUE;
> +}
> +
> +static void get_connman_state_reply(DBusPendingCall *call, void *user_data)
> +{
> +	DBusMessage *reply = NULL;
> +	DBusError error;
> +	DBusMessageIter iter, array, dict, value;
> +
> +	const char *signature = DBUS_TYPE_ARRAY_AS_STRING
> +				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +				DBUS_TYPE_STRING_AS_STRING
> +				DBUS_TYPE_VARIANT_AS_STRING
> +				DBUS_DICT_ENTRY_END_CHAR_AS_STRING;
> +
> +	const char *key;
> +	const char *str;
> +
> +	DBG("");
> +
> +	if (!dbus_pending_call_get_completed(call))
> +		goto done;
> +
> +	reply = dbus_pending_call_steal_reply(call);
> +
> +	dbus_error_init(&error);
> +
> +	if (dbus_set_error_from_message(&error, reply)) {
> +		connman_error("%s", error.message);
> +
> +		/*
> +		 * In case of timeout re-add the state function to main
> +		 * event loop.
> +		 */
> +		if (g_ascii_strcasecmp(error.name, DBUS_ERROR_TIMEOUT) == 0) {
> +			DBG("D-Bus timeout, re-add get_connman_state()");
> +			get_connman_state();
> +		} else {
> +			dbus_error_free(&error);
> +			goto done;
> +		}
> +	}
> +
> +	if (!dbus_message_has_signature(reply, signature)) {
> +		connman_error("vpnd signature \"%s\" does not match "
> +					"expected \"%s\"",
> +					dbus_message_get_signature(reply),
> +					signature);
> +		goto done;
> +	}
> +
> +	if (!dbus_message_iter_init(reply, &array))
> +		goto done;
> +
> +	dbus_message_iter_recurse(&array, &dict);
> +
> +	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
> +		dbus_message_iter_recurse(&dict, &iter);
> +
> +		dbus_message_iter_get_basic(&iter, &key);
> +
> +		dbus_message_iter_next(&iter);
> +		dbus_message_iter_recurse(&iter, &value);
> +
> +		if (g_ascii_strcasecmp(key, "State") == 0 &&
> +				dbus_message_iter_get_arg_type(&value) ==
> +						DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&value, &str);
> +
> +			DBG("Got initial state %s", str);
> +
> +			set_state(str);
> +
> +			/* No need to process further */
> +			break;
> +		}
> +
> +		dbus_message_iter_next(&dict);
> +	}
> +
> +	state_query_completed = true;
> +
> +done:
> +	if (reply)
> +		dbus_message_unref(reply);
> +
> +	if (call)
> +		dbus_pending_call_unref(call);
> +}
> +
> +static gboolean run_get_connman_state(gpointer user_data)
> +{
> +	const char *path = "/";
> +	const char *method = "GetProperties";
> +	gboolean rval = FALSE;
> +
> +	DBusMessage *msg = NULL;
> +	DBusPendingCall *call = NULL;
> +
> +	DBG("");
> +
> +	msg = dbus_message_new_method_call(CONNMAN_SERVICE, path,
> +					CONNMAN_MANAGER_INTERFACE, method);
> +	if (!msg)
> +		goto out;
> +
> +	rval = g_dbus_send_message_with_reply(connection, msg, &call, -1);
> +	if (!rval) {
> +		connman_error("Cannot call %s on %s", method,
> +						CONNMAN_MANAGER_INTERFACE);
> +		goto out;
> +	}
> +
> +	if (!call) {
> +		connman_error("set pending call failed");
> +		rval = FALSE;
> +		goto out;
> +	}
> +
> +	if (!dbus_pending_call_set_notify(call, get_connman_state_reply,
> +								NULL, NULL)) {
> +		connman_error("set notify to pending call failed");
> +
> +		if (call)
> +			dbus_pending_call_unref(call);
> +
> +		rval = FALSE;
> +	}
> +
> +out:
> +	if (msg)
> +		dbus_message_unref(msg);
> +
> +	/* In case sending was success, unset timeout function id */
> +	if (rval) {
> +		DBG("unsetting get_connman_state_timeout id");
> +		get_connman_state_timeout = 0;
> +	}
> +
> +	/* Return FALSE in case of success to remove from main event loop */
> +	return !rval;
> +}
> +
> +static void get_connman_state()
> +{
> +	if (get_connman_state_timeout)
> +		return;
> +
> +	get_connman_state_timeout = g_timeout_add(STATE_INTERVAL_DEFAULT,
> +						run_get_connman_state, NULL);
> +}
> +
> +static void connman_service_watch_connected(DBusConnection *conn,
> +				void *user_data)
> +{
> +	DBG("");
> +	get_connman_state();
> +}
> +
> +static void connman_service_watch_disconnected(DBusConnection *conn,
> +				void *user_data)
> +{
> +	DBG("");
> +
> +	set_state(CONNMAN_STATE_IDLE);
> +
> +	/* Set state query variable to initial state */
> +	state_query_completed = false;
> +}
> +
>   int __vpn_provider_init(void)
>   {
>   	int err;
> @@ -3233,6 +3571,20 @@ int __vpn_provider_init(void)
>   
>   	provider_hash = g_hash_table_new_full(g_str_hash, g_str_equal,
>   						NULL, unregister_provider);
> +
> +	connman_service_watch = g_dbus_add_service_watch(connection,
> +					CONNMAN_SERVICE,
> +					connman_service_watch_connected,
> +					connman_service_watch_disconnected,
> +					NULL, NULL);
> +
> +	connman_signal_watch = g_dbus_add_signal_watch(connection,
> +					CONNMAN_SERVICE, NULL,
> +					CONNMAN_MANAGER_INTERFACE,
> +					PROPERTY_CHANGED,
> +					connman_property_changed,
> +					NULL, NULL);
> +
>   	return 0;
>   }
>   
> @@ -3247,5 +3599,13 @@ void __vpn_provider_cleanup(void)
>   	g_hash_table_destroy(provider_hash);
>   	provider_hash = NULL;
>   
> +	if (get_connman_state_timeout) {
> +		if (!g_source_remove(get_connman_state_timeout))
> +			connman_error("connman state timeout not removed");
> +	}
> +
> +	g_dbus_remove_watch(connection, connman_service_watch);
> +	g_dbus_remove_watch(connection, connman_signal_watch);
> +
>   	dbus_connection_unref(connection);
>   }
> 
