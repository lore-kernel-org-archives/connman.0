Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3C72
	for <connman@lists.linux.dev>; Mon, 14 Jun 2021 10:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdfhX4dvt2dnkBYQ4wBMRZyiR3GX+/SGfZTLd9PK78mDtFNk/+OcbGk8TP7Wz4yAaZL5XS64R0RiqJM1lRvNps74aRxOedRuk7JRrNtoX76tVXsCcbrUcz9CSE/PvFVqcEguGcsOMnB3xP9G36Wwm28g7LJfS9RVpuW7aeMiN8I/uxXjstemBXBfybI9tCeh7FBHQCFVe0gSGQMTg/A/mSDuSYQj4+8bMw7h8yzCfbeP99m1PUUYJbqCbhzQaafOt0t8av0JEQL8Fi+IPA8+aehKnnEErj9iT/Jg8Or5z2VRPW1EzsxinViF5647+afGSWuss83ic1Y2XjrcqyQuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GgZ/PQrV1iuk6PQ28PMOemfzTSzUYs7zVbxflwZL/Q=;
 b=bcsKrfFQedDW97JYNgDnJIyC804WR0d5BDOHPr4ROBXazBkFMEt2Ln5wKJFdaJ5KL6ezliPmG4Sc2nK5SXSwbUEWMdbcldA6h4tgTitce8PVmWihtVqPP9Fl5xBoMJLaJ3Ns566ktaEBF7kikwT2cZG1GfyVLmZ87Jkt/cypfEHWBNDh+uCAdjbN7ODXbNh7wS2O5dDDyRcmDfWC6USj4t2t9Y4WcxFXDtbmdG88Ios6yrPqIBchg+novTVs3iSUtY1Hmc+rNLc2Jza1gReySE4L61SHlYwqB/56U4IwEoJmPt5ksdkE3+8aJS0w1tbA+JSK9T2cSpZufvZsMlcGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GgZ/PQrV1iuk6PQ28PMOemfzTSzUYs7zVbxflwZL/Q=;
 b=kZURT/83UrkyjXhrEcBkZ9STXxrjR3F5q6Z8/N4T5PDmmVde3JrHxK4SgSd8Jbx/rGQsOetzQ/rdW68yPV1CYIiiPNa8rpOrUpTHVc//Vq52XkuMABsM4caiXuNznVL/14GWx6L4D7iaJoozi+qjrwvKCTqb7R1dY2UN2jqz3E7GQFRYzN6eoM3UdK/6Z4BN7C24LxbIeGqXLu2qN45hzZd0IJri8i00hz7ERLza+SAOxy9GbRBrqkw5TPbU1IwlfSEumrcu6bon3sGXYoPbcDtyE8ZL5jenFH606GwHh0Awj+OoItZ0/9wWHsHpnsuR4B7ZHqJSdqjWrvRzAIBL3A==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from AM0PR0602MB3409.eurprd06.prod.outlook.com
 (2603:10a6:208:1a::14) by AM0PR0602MB3825.eurprd06.prod.outlook.com
 (2603:10a6:208:6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 10:29:41 +0000
Received: from AM0PR0602MB3409.eurprd06.prod.outlook.com
 ([fe80::ac1b:6407:6811:cae8]) by AM0PR0602MB3409.eurprd06.prod.outlook.com
 ([fe80::ac1b:6407:6811:cae8%4]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 10:29:41 +0000
Subject: Re: [PATCH] service: Fix preferred service reordering on ready state
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
 <Emmanuel.VAUTRIN@cpexterne.org>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <3213af74-2985-ada6-09d4-67d5ccf1f72f@jolla.com>
Date: Mon, 14 Jun 2021 13:29:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.110.84.60]
X-ClientProxiedBy: HE1PR05CA0278.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::30) To AM0PR0602MB3409.eurprd06.prod.outlook.com
 (2603:10a6:208:1a::14)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.1.6] (194.110.84.60) by HE1PR05CA0278.eurprd05.prod.outlook.com (2603:10a6:3:fc::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 10:29:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3720b131-95d3-48db-2f17-08d92f1f5195
X-MS-TrafficTypeDiagnostic: AM0PR0602MB3825:
X-Microsoft-Antispam-PRVS:
	<AM0PR0602MB3825DAB51D4FF093AD381834EF319@AM0PR0602MB3825.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mr+wQneVCpkMMA6pqx+XIsqqS1HxwXpJvN6mB3E5q4lJgLxBD5ovu10ZOhFrzb2JFQpySHQ6Pvm+UA5NkSOEcvgQC5EZupyiSyic1Ys0/CcRxcPLsT6Qjl9KJHMEHzAhtSFfT1zKK6kwuymyk9y10MkHs0k9lz0yOtas7APVHsLyK9JaJof68+LHzvb3fqNaWvkYzrS9SypYxwvgZZyI79g7fkBE+/Uyj3bEjYHEIG51smNnEihSl1mlDazt++ASKtlxYRCtwNQu+SrbmAay+Th5kWhURL6c/5Q5F8Nnz1y6PLdUPMBKHuw9qhvU5N4ZXivFY9cBRadWFigzFcKpWoThC/ubJH3Bm4ibIrrvA9LOgudJQR6LT8eBgHsEBfZ/T601jKFX33WNss8TrJ5dn3KA9j3G7KIlOiISMp3KeqgKVoXxXMKFtVH1zqp3/7jy54SgbBgxz5eQR3wlwyR3x4dtQz6r9HvTg9UkcVx20lcckPBDXha8dHrmOcIHA59LguxYc/fNwcdsNcdrcmRaGm9dfK++MeuUkOfwzwZw+24rVrQQkjYoQ8lnSgHd4O7sx6p/R5NWE+2T/re0ZonmnZ+hRBvGwDA2RFJH4KR2X4qS5FuyNAN29cj9C0Jjq5zZLvQdOTtVHXtyG3RVOp2fMvtKGChkqpIyKna5Ui3rKegLnCTKmg2N0Vyq001ow6FRF2U3iGH3vP+NtzyN1XxfotLqW5DD/PZivJWTWU33PkXj5ysya+dfVO3MOpcqkWboR15hkihhU12xKqKSfn/uCLisuEZBVkcgJqGYaHQKCT/q+VR5saKRarxcD8kLYKlncjSHOvy3NVBKsb59Sp8xTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0602MB3409.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39830400003)(44832011)(6486002)(86362001)(52116002)(38350700002)(38100700002)(36756003)(16526019)(186003)(53546011)(8676002)(2906002)(5660300002)(8936002)(66946007)(316002)(66476007)(110136005)(16576012)(966005)(66556008)(31696002)(26005)(83380400001)(956004)(2616005)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2VOMWNlZ1dTZ0tUaDlJV3hhcXFnVTJFbmdVbFM0TURoQTZlekI4dmx5bGVk?=
 =?utf-8?B?QkYrcmpsMXI0Ym42MSsvQnRkbVRNcExrR0NLWGZiTmRzYUlCdHJRYlhlODFK?=
 =?utf-8?B?RnhCcHNSYnFxT0tnYVdCa2ZHVDkxTGUwWDlKRkVlRmpSWnZUUnFYa3JUL1VL?=
 =?utf-8?B?UmhiWXd0RDF4M1dhZFZ2bmE4ZmJ1Wjk4QnoyOS9JRDQvVEtwb0dZNExsS1Rk?=
 =?utf-8?B?TGZ3aVZlL0Z0L1ZaK2FYNHNaNlFSZHZFbUpzTTVpUkFTT1RiTUNmYzNsVlF4?=
 =?utf-8?B?cVFMaERKTU9wa0lEU3VvTmN5azlmYkEvY0toR3NiQU5Genl5Yy95WVJBNzRG?=
 =?utf-8?B?Q0VSNVZETXJ5ODlOb2lDejZjR2gxeTBlUjV2TU01bVgxUHJlckVpdmUrTzVI?=
 =?utf-8?B?cUY0SGtXMmtDdHA1dzR2UEVET2RobC9QNVpWVFFPQ2I2ZVBlRFB3ejQyZVNL?=
 =?utf-8?B?c1plN0VXTXl6UktORTlsMEZrYUZ5OURZb0hhak4vdXJhN3VSeEVlL0tXekpG?=
 =?utf-8?B?WlFVSlpybHhsYURDdUlaVVprVE9ncmMzZ3lldkEyUDdqQ2FzLzdYbitKOWJH?=
 =?utf-8?B?b1NuOFBVWDVvTTdIb05tUlRzTGpvY25pOGtiUVVwVWpCc0hibGxqb1g3MmRO?=
 =?utf-8?B?N0ZwVXpnRVBWVFdHaXpibFVyRXRoNG91SHdmV2luRGEvRzhrYjZPNzVnWUp6?=
 =?utf-8?B?Tnh5Z0srOW9vK3FDenByZldQM1BqNjNyQS9mOHl0WWFzY09CSkI2V2x5ZFNk?=
 =?utf-8?B?SUtLbjRWWU1Kakp3TzJCV2R1R2d0ZndlWXJoODZCbVdhMWJJdHJ6aVhjNnBj?=
 =?utf-8?B?L2NUd21lVHdsUXBRM0FxVmNOV3ZmSlZiZ3FjK0tEamZLS3RzY3JhUkRQWEpv?=
 =?utf-8?B?K1dlcFRZdmZ6SmowczJrc2hIc2VXeFVvV003SzNyUzFCSVR6MzRWTDVvaGJQ?=
 =?utf-8?B?OWJPOHc3NG5GdW1rbHNleVFWU0JDOXJEbWxGR0xBY1ZZSUVlU2lUbnVKMDBT?=
 =?utf-8?B?Yy9TeHNTcHh0U3pFNUpCOW4zTCtvMlM1SGhNbU1wbGRxVjFLSFN4LzFtTXB1?=
 =?utf-8?B?c0ZOVWFtckdCR2xPUHBIcm5TY3RmYnVMYmNNOUdVYkJsWnA2RHVwL0ZyM3M0?=
 =?utf-8?B?NXFNVHU1OUtCVDBkOS9DZHNudlJCV25ETkpqMXlYYVI1MHNTdnY1SUIwM25X?=
 =?utf-8?B?bXhQTnFHZ0VvTkd2VlZ0b3p5cDZObTk2OXlwVGRwazhJZXVXZUs3aXlVUEM4?=
 =?utf-8?B?b3haOWowd2JncFhDRC9QNUU5QzBEN2RQOXdiOTJhNk9VbG9oNTdmUVQ0M2VC?=
 =?utf-8?B?Qjlac0tXeHZFWlVGS1hPb1h4bXpKcHdCcFRueGowMTFkZTlWZnB5c2FpZFVq?=
 =?utf-8?B?MlBNQzF4ZUxWSFhVUzdsVDh1S0swZ1JqblEvbWNaMWs0dkpzdys1dklaU1pU?=
 =?utf-8?B?QjBGaTBQTDM2dTFyR2lhNUpGSkZ6TWtYUWJ3NWVVaUszdFFqNWJ2TW00dkpV?=
 =?utf-8?B?RFJVRDF2d3VjZ0pSckJLdytXQjU0VUI5MWdFa3ZIUHIxTStOMkNCV2x5cDRI?=
 =?utf-8?B?M25qVjg4T3h0VXg1c0RadGh0K2R6WENCd0NpbnhpcENFY3JzMGNPWkRHUkN3?=
 =?utf-8?B?SkMzUmxqY0kyU211MFRDdG0vb1N6L08yUDlkcFhHV1lRVlQ0VDlKTlQzcXhG?=
 =?utf-8?B?SHE2YmR5NlJTWmVPVXdGUjkwOEJ4MjJtbDRLaFJzK2huWE1pKzJPTUdGMHRI?=
 =?utf-8?Q?+NWHbx5TNBCOVFPkuEz40ZyOSXtDlt2OGCcxbJj?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3720b131-95d3-48db-2f17-08d92f1f5195
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0602MB3409.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 10:29:41.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN8eHGDGczKYY9FQ6SCo22+4qdKKSY5C2yh6wVpohIiwew1S+yvapa8dDdxb6+OkF8Odd1vSpMukp7VIA8gD9o/iDULW1JQf2iBzVsvZwc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0602MB3825

Hi Emmanuel,

Wouldn't this be more simpler to be done service_compare() utilizing the 
PreferredTechnologies setting as I assume this is the issue you are 
trying to resolve:
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/service.c#n5353 
?

Cheers,
  Jussi


On 6/14/21 12:41 PM, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> When a service reaches the ready state, the service list shall always
> be reordered according to the PreferredTechnologies config options.
> 
> This issue can be reproduced with PreferredTechnologies=ethernet,wifi,
> by following the steps above:
> 1. Starting, Ethernet (E) plugged, with a known Wifi (W) network.
> E idle -> online, W idle -> ready
> 2. Unplug Ethernet.
> E online -> idle, W ready -> online
> 3. Plug Ethernet.
> E idle -> ready, W online
> Even if Ethernet has the highest priority, it will never be online,
> except if Wifi connection is lost.
> 
> Fixes: e600366f6035 ("service: Start online check on IP address update")
> ---
>   src/service.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/src/service.c b/src/service.c
> index 20917a8923a4..cadd9fc76881 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -4711,15 +4711,11 @@ static void apply_relevant_default_downgrade(struct connman_service *service)
>   	struct connman_service *def_service;
>   
>   	def_service = connman_service_get_default();
> -	if (!def_service)
> +	if (!def_service || def_service != service ||
> +		def_service->state != CONNMAN_SERVICE_STATE_ONLINE)
>   		return;
>   
> -	if (def_service == service &&
> -			def_service->state == CONNMAN_SERVICE_STATE_ONLINE) {
> -		def_service->state = CONNMAN_SERVICE_STATE_READY;
> -		__connman_notifier_leave_online(def_service->type);
> -		state_changed(def_service);
> -	}
> +	downgrade_state(def_service);
>   }
>   
>   static void switch_default_service(struct connman_service *default_service,
> @@ -5898,8 +5894,7 @@ static int service_update_preferred_order(struct connman_service *default_servic
>   	unsigned int *tech_array;
>   	int i;
>   
> -	if (!default_service || default_service == new_service ||
> -			default_service->state != new_state)
> +	if (!default_service || default_service == new_service)
>   		return 0;
>   
>   	tech_array = connman_setting_get_uint_list("PreferredTechnologies");
> @@ -6051,12 +6046,12 @@ static int service_indicate_state(struct connman_service *service)
>   
>   		service->new_service = false;
>   
> -		default_changed();
> -
>   		def_service = connman_service_get_default();
>   
>   		service_update_preferred_order(def_service, service, new_state);
>   
> +		default_changed();
> +
>   		__connman_service_set_favorite(service, true);
>   
>   		reply_pending(service, 0);
> 
