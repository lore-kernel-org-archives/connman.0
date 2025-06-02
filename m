Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CCBE6C
	for <connman@lists.linux.dev>; Mon,  2 Jun 2025 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748845991; cv=fail; b=THIY/iyHCiZR1Dk7sAwnkfAsQYhIO1fowamcp4B6VRcVUrPs0PuFxasmnh1X6eWjYwcEamo1w+RIx45yWti4UdrYfjW3GDDKbKB5wAuIp/9BBfcfX1HTKnFdRCzxl+z6XO3fBjuTJlPIJw/6gzf8Wq4jYzBqxFHctHnmzQo1w/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748845991; c=relaxed/simple;
	bh=XdQxVfQxyJxhbBKJYndNoSLTIWb/bsv+E0ZYUGg4rN0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ovntnjiQuUEaI996xxRVMMc81B12/Z72efWmeWA8f2WR9Pgf4d4/gLqHSLbXo0dYCI6a/s7qJyMsJi2cxHnwO5LEJ/aWhsd/+L2yLdSAqszgt7lenI8SuBqYD5z6SWh94XLPuJP+L48plKUDg+ONoPd1o2bMlbziHP9r18NrN9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.52 with ESMTP; 2 Jun 2025 15:33:05 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo6.lge.com) (165.244.66.187)
	by 156.147.1.125 with ESMTP; 2 Jun 2025 15:33:05 +0900
X-Original-SENDERIP: 165.244.66.187
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO SE2P216CU007.outbound.protection.outlook.com) (40.93.138.28)
	by 165.244.66.187 with ESMTP; 2 Jun 2025 15:34:58 +0900
X-Original-SENDERIP: 40.93.138.28
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0VkqVaynqMVOTKgcdhG7uLFJCiwihqCgLmvOtWvHVfjRTgGyhZ99ZT5+apaOYhrxPcohielshLxL/bf4rFj621sBC5RCpQ4WG7K1E9KJcxt4DmZHg/Dq8ydSL5T3RgN6ZBpFl+H2ScOPlNqK1dR5WCJzesKQm0CoBmppw5AoPeKD+4qxL3ORc4c1lGHXm6U1tcOrmEZFVQ9caPA0wpxToMCVmB/T3tgn4JXywM3mAHl0pLd5pGRt2j4J7mWVsLdOrHFCDMm2VhOnB+k/focEmS26dABHsbIodx0spj2QOVKMO89dJawtdxHYCWCtJUXa2q17NczrRx6QykdJ2KFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOTnaHVv2x1UoXX1doKSjlP+aff7pmM+KWquraDY8Is=;
 b=Y29OZzRCyXJA7ciCAMs28G2XhV+38o2rWExxvPS1jzYhL2BbkKhWbpM1EhWoAYltGmhq7iYOONY5hd1hKdJzUpVGY6ger63hWwl/S8+5E245a8QYmimwJ89h8IILcEnJN9TVO+WGr81/eUZICCi6dBBIMWpl9bJ0oGTnZSVXayqrIdyvAqwH7HixKwmavOgWoTD4rJ8bxPj5tBEp1O/7c4wwVcwhU/WuikoGnEc6rifHLGDX9WATLIxsRXZS4Dkj7DnMzy8nJz4jwulUkn8pYgKKZyJRzTQneWxlnnyD8xuVPmeOZI8EXkAaucYRieno0Ll0jPka3CxlmveeV+Sxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by SE2P216MB2257.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 06:33:03 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%5]) with mapi id 15.20.8792.033; Mon, 2 Jun 2025
 06:33:03 +0000
From: Shailesh Rathod/LGSI GPOS Dev <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject: [PATCH] connman : Introduce softap with ip feature to connman
Thread-Topic: [PATCH] connman : Introduce softap with ip feature to connman
Thread-Index: AQHb04edQfbm9G3mi0iVxbmRoyEocA==
Date: Mon, 2 Jun 2025 06:33:02 +0000
Message-ID:
 <SE1P216MB2647222FA0265D346F4C13C1F062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|SE2P216MB2257:EE_
x-ms-office365-filtering-correlation-id: de06bc4f-8e02-4fee-801e-08dda19f5382
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JeD1l/o2cdYPObxg8sZC2lj0gEin0GifMXmT5biqaXlknPqDqsSbWLaWUJ?=
 =?iso-8859-1?Q?xpqp1cWbFOJI210ae/WcJoR3s1s5qgJO08UA6JiHPzqekNITasK3aYckcJ?=
 =?iso-8859-1?Q?Q5ndh5qUwdC/qW1Qt0gRgIy43rmWtdGr6m22tucpmxs69j/rp+P4pIcBra?=
 =?iso-8859-1?Q?NT3LvdHgiIDyG7E+joF62saW7K4GrhpUHwonJucCNlUpNx2EDoxuY2eDmo?=
 =?iso-8859-1?Q?c5rJ8D0VyJEtIY2AYHEekg5eUjnG+ZzSVhZDXvIbdR9ayTX0yjnpm+o7ry?=
 =?iso-8859-1?Q?D+FCrYgZp7MWGtwNb4sORSalOaWv5BxJWOgzRJqZsyJhOO7dOnl8dhFwUF?=
 =?iso-8859-1?Q?3tGOgmq2wRW6/7txH6DAH3EDqeyHKOZcEfskAKbtsMUsR0dww1Gk6a03Xz?=
 =?iso-8859-1?Q?hLLEQs5Qnn+Ca87pVj4jUsALXZuaOofe3xbzFd9RCPYZx7bab2Sffc8EIp?=
 =?iso-8859-1?Q?aX9K+Aglhn9cwsTRGbq+b6cFM9SH/W74V3SEB3zQqsVoXKFFinbJinHP/W?=
 =?iso-8859-1?Q?dnc+VSSgTGotuGyriJhnY8FxBU+cnhaPbe71i+sJ5ypSGfmunG3/F+AZwP?=
 =?iso-8859-1?Q?OI+vF8W7KdGHOHCwbsg3TgKHh9g1htvf0nPitG4bFwCshxg4Pokb4pGWkS?=
 =?iso-8859-1?Q?kRr8CK0Q6707yYHC0fmxhPA9Olg6urjf7n3FPsJ9EdXemrZBKgXoyV4DMh?=
 =?iso-8859-1?Q?Mxv5dlZk0UMCGhOqBjzmcQbP+D+UdSDBcayi2iBfwBRICUIxuVXyVquVzD?=
 =?iso-8859-1?Q?/IVSxJO9GWt9aXez3z5s5GMcgCv04hL8BYmwbX7K+EIUyRxt/vjvx76ltr?=
 =?iso-8859-1?Q?f6aXFKUBE88MeFsBKvb7IKj9UvDeGsaDc/o3OsTnNTHVlVCwCd7RxNd5rr?=
 =?iso-8859-1?Q?A67YGQ97cnL7td45KAnH+WMNAwI6EOT4JNwdtLqpthtYnwHn3zGa9Hwl4d?=
 =?iso-8859-1?Q?dlM+h9xiubgdDY3xruOKgjZjBM2kfuJDqhvsGwQsGcIt+rIYaJry0V+zw6?=
 =?iso-8859-1?Q?Z4igMpSt6fzy+j4+UKkc4kNFCSraFiAFFCoztm6HYM32LNcntybrs2pvvJ?=
 =?iso-8859-1?Q?BYYFZQxoS5QdCQkFbkeltsrJXHhFMSaSUfCLGdE4rxGg2ma3RAOQ042WnN?=
 =?iso-8859-1?Q?OAuosVT4NsfvK5gPHhXQTmXTeRw7A0TPAaFPhuwrduweYJ46zZ+As20x8p?=
 =?iso-8859-1?Q?i2eGnwd+NfUy5GEmcirsd2EF6Fg7EbKVAlq36GzS1ARoOXNnEjqASK0tgt?=
 =?iso-8859-1?Q?8WJ/se56MqeNmi2gwm9BrAssfl9MbFqS1s2wIGfFoxxuUNAMYGwotM6rwp?=
 =?iso-8859-1?Q?UHYFc2s2Y2ibj51wjKnq2Mx1dg2QK50enGoJUISxFxGNNho6r64LY31ssi?=
 =?iso-8859-1?Q?b9mSVpQbNU8n24tfawAcaWcwGbq+XycTcunF05LSh7N2Poj4MAr45y6Ps/?=
 =?iso-8859-1?Q?JbvN5UXYbkxBAG9pN97RIeqxx1UpLRfLzYBAuqUQILUNvJMHfARhgdtZYY?=
 =?iso-8859-1?Q?7EkLD1kspt5JVHGHbuAUKlAhIlSn71id8dJuVj6dDW31O/Ie2zONo7/Gow?=
 =?iso-8859-1?Q?KIpWjIM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1nYle+tw5q44WXQeNW6JVt8Wv7y8EX/W6lAbCXq6YHhZO5nKzc1FlDaPbG?=
 =?iso-8859-1?Q?/+Qz343PFa2046wLd64LuUbvxaO8ghKE4HC9H4ZKZ5IHWoffrKcK06+nYz?=
 =?iso-8859-1?Q?6ZjDMvKcOvvQ9B1/HyuSRj9CI21HQcwcLllr9YxI4bVySw05Hjhl3Rh9v9?=
 =?iso-8859-1?Q?uH2WKBZQEeMlzjX3f3wmRVBfCQZvMukOYfWEtMS+8ZFWKhjiYI5oVhdKdi?=
 =?iso-8859-1?Q?14TzK+RSo9TRTQsZ9T9KJPi3UWeeQvetIrmT3xKoh0VRLkhM4zf7e/IISd?=
 =?iso-8859-1?Q?cNBKH33PGnNZXdC0O1JcBELTOltbMLCNXoBCzc/qNF86OQUsEwSgbUSlTa?=
 =?iso-8859-1?Q?JlkU/EaxBI18S4XSyjwZTqgQVOYmw3Cbed2fV37pfVaDizXdw6Wv2aZbQP?=
 =?iso-8859-1?Q?CkIgT1BJnF0qLqIu/GRf0Hnbnevon709cXW89PuqLxu3hAoi/PtjYU6Zdj?=
 =?iso-8859-1?Q?mxMPOwI9C9/41d/QPvm2EWbRSRZhYum/JXwwvmsQCbD6lYlwIa/bkq6X9Z?=
 =?iso-8859-1?Q?yxZ8NooH3RqgIGrLoka5U8uJen3XwNPlk8kQM48tgUsMFGHM/7ONkSvh8E?=
 =?iso-8859-1?Q?CVP32i88+tU1zhRVo6zUsH68+P66rd7TFV3MSTKC9ivD5G6uh6YID1BdW8?=
 =?iso-8859-1?Q?pPM6e0tlG6Yp3zF/1or8yl5TMAF0176GWnBEmm3SpoHabrEN30il3VB2VJ?=
 =?iso-8859-1?Q?UldEdQdgUuFCat9kChftUGICB8/ZGsIe2+fyfuAaznJAHsWdSbkTJZbkru?=
 =?iso-8859-1?Q?lV/PZj2QJpqMMQjA0pPEb5TiApGIO8U5EB0Tzt3eYzT7gT0r6mFsx6YsCl?=
 =?iso-8859-1?Q?LBcGXxcb/Dm2LmqPkKr7BBKWcNVZ4ItB4p/wvs0JGv+/dYyahNsqaMoqkc?=
 =?iso-8859-1?Q?PJnkDBdLIoHVt/E69PjbOagXMyyiuGDCMTnxxOjQphz9cOZQv0PMjm59gX?=
 =?iso-8859-1?Q?E5MNaE9JjkPM/xoF6es8mMKwC0G12Gg+WS6xWpCjFlJjaHLzUB8GFfTOAU?=
 =?iso-8859-1?Q?4C5oZlmLzfpCK2o3sL3KUxF1WhsdGEKPj6UEqTfqbqb1wfORn/p/4a+/cL?=
 =?iso-8859-1?Q?7XCdM0QV/hH0YkxRqTbsKkc6m6VS8mxijAmh2EnRNWpnQiQIVQ6h+pRj+/?=
 =?iso-8859-1?Q?nVwzC5P7k7tB7h15UWPTQnMIa9IhaOrfQR24GAHhZAUpvbHwtSyBNlQgvk?=
 =?iso-8859-1?Q?tCnHYl8QDrO5kHewQB5LqYsMuP1DOeWtqojexesgXscMTmJlV7NLqcF0WR?=
 =?iso-8859-1?Q?Db0t6IlqzYp952RmcFOcbnZjzLhVM7K9E89q+iLnfrAEbdZmVBoFyZh7/I?=
 =?iso-8859-1?Q?wxSwvk+HPSkTIWseAVwsLIyP3A+yGwYaCRASqKIkHsN4NLeZL9uFdqYVZS?=
 =?iso-8859-1?Q?BSP1E07aTltXxY7n3eUN2+lhNqXRgy3sUlwy49lDkY4oIl4E9bC9Nsq3Pr?=
 =?iso-8859-1?Q?mM9dQWX8mlN59FLOqmZuc1/REikA4TV1yoRZ7VE19ISajvK3wwiC680eMl?=
 =?iso-8859-1?Q?HjjdTTDpiLTXiF9gPjM384e89q3xObg4c9OM6//VQPpc8gpvP7r4iW1e39?=
 =?iso-8859-1?Q?BwPvzsO59DzWNzHPLYmCTH4mVGIx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: lge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: de06bc4f-8e02-4fee-801e-08dda19f5382
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 06:33:02.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Mro6lSW59Jton+MSltLHRSv59fEcJr2v5Mxc4c8TkFcseHEp8egdI0ORYqS/7vR5dj037qPObvlf4Q7MM5k2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2257

From: Shailesh Rathod<shailesh.rathod@lge.com>=0A=
Date: Mon, 21 Apr 2025 18:16:09 +0900=0A=
=0A=
Introduce softap with ip feature to connman=0A=
=0A=
By default, ConnMan supports tethering with a passphrase.=0A=
However, it does not support configuring tethering with a=0A=
specific IP address and channel.For certain applications=0A=
=A0it is essential to set a specific IP address for the SoftAP.=0A=
=0A=
To enable support for specifying the IP address=0A=
and channel, new properties TetheringIPAddress and=0A=
TetheringChannel should be added.=0A=
=0A=
Signed-off-by: Shailesh Rathod<shailesh.rathod@lge.com>=0A=
---=0A=
=A0src/connman.h=A0 =A0 |=A0 15 ++++++=0A=
=A0src/technology.c | 122 +++++++++++++++++++++++++++++++++++++++---=0A=
=A0src/tethering.c=A0 | 136 +++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
=A03 files changed, 267 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/src/connman.h b/src/connman.h=0A=
index 32ba559..4241a58 100644=0A=
--- a/src/connman.h=0A=
+++ b/src/connman.h=0A=
@@ -676,9 +676,24 @@ bool __connman_config_address_provisioned(const char *=
address,=0A=
=0A=
=A0#include <connman/tethering.h>=0A=
=0A=
+struct connman_station_info {=0A=
+=A0 =A0 =A0 =A0 bool is_connected;=0A=
+=A0 =A0 =A0 =A0 char *path;=0A=
+=A0 =A0 =A0 =A0 char *type;=0A=
+=A0 =A0 =A0 =A0 char ip[64];=0A=
+=A0 =A0 =A0 =A0 char mac[32];=0A=
+=A0 =A0 =A0 =A0 char hostname[64];=0A=
+};=0A=
+=0A=
+=0A=
=A0int __connman_tethering_init(void);=0A=
=A0void __connman_tethering_cleanup(void);=0A=
=0A=
+GHashTable *__connman_tethering_get_sta_hash();=0A=
+=0A=
+void __connman_tethering_list_clients(DBusMessageIter *array);=0A=
+int __connman_tethering_set_enabled_with_ip(const char *ip);=0A=
+=0A=
=A0const char *__connman_tethering_get_bridge(void);=0A=
=A0int __connman_tethering_set_enabled(void);=0A=
=A0void __connman_tethering_set_disabled(void);=0A=
diff --git a/src/technology.c b/src/technology.c=0A=
index 270d83d..719c680 100644=0A=
--- a/src/technology.c=0A=
+++ b/src/technology.c=0A=
@@ -69,6 +69,8 @@ struct connman_technology {=0A=
=A0	char *tethering_ident;=0A=
=A0	char *tethering_passphrase;=0A=
=A0	int tethering_freq;=0A=
+	char *tethering_ipaddress;=0A=
+=A0 =A0 unsigned int tethering_channel;=0A=
=0A=
=A0	bool enable_persistent; /* Save the tech state */=0A=
=0A=
@@ -195,6 +197,16 @@ static void technology_save(struct connman_technology =
*technology)=0A=
=A0		g_free(enc);=0A=
=A0	}=0A=
=0A=
+	if (technology->tethering_channel)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_key_file_set_integer(keyfile, identifier=
,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "T=
ethering.Channel",=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 te=
chnology->tethering_channel);=0A=
+=0A=
+=A0 =A0 if (technology->tethering_ipaddress)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_key_file_set_string(keyfile, identifier,=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "T=
ethering.IP",=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0technology->tethering_ipaddress);=0A=
+=0A=
=A0	if (technology->tethering_freq =3D=3D 0)=0A=
=A0		technology->tethering_freq =3D 2412;=0A=
=0A=
@@ -225,18 +237,25 @@ int connman_technology_tethering_notify(struct connma=
n_technology *technology,=0A=
=A0							bool enabled)=0A=
=A0{=0A=
=A0	int err;=0A=
+	const char *ip;=0A=
=0A=
=A0	DBG("technology %p enabled %u", technology, enabled);=0A=
=0A=
=A0	if (technology->tethering =3D=3D enabled)=0A=
=A0		return -EALREADY;=0A=
=0A=
-	if (enabled) {=0A=
-		err =3D __connman_tethering_set_enabled();=0A=
-		if (err < 0)=0A=
-			return err;=0A=
-	} else=0A=
-		__connman_tethering_set_disabled();=0A=
+	ip =3D technology->tethering_ipaddress;=0A=
+=0A=
+=A0 =A0 if (enabled) {=0A=
+=A0 =A0 =A0 =A0 if (!ip || strlen(ip) =3D=3D 0)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 err =3D __connman_tethering_set_enabled();=0A=
+=A0 =A0 =A0 =A0 else=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 err =3D __connman_tethering_set_enabled_with_ip(ip=
);=0A=
+=0A=
+=A0 =A0 =A0 =A0 if (err < 0)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 return err;=0A=
+=A0 =A0 } else=0A=
+=A0 =A0 =A0 =A0 __connman_tethering_set_disabled();=0A=
=0A=
=A0	technology->tethering =3D enabled;=0A=
=A0	tethering_changed(technology);=0A=
@@ -417,6 +436,17 @@ bool connman_technology_get_wifi_tethering(const struc=
t connman_technology *tech=0A=
=A0	return true;=0A=
=A0}=0A=
=0A=
+unsigned int connman_technology_get_wifi_tethering_channel(void)=0A=
+{=0A=
+=A0 =A0 =A0 =A0 struct connman_technology *technology;=0A=
+=0A=
+=A0 =A0 =A0 =A0 technology =3D technology_find(CONNMAN_SERVICE_TYPE_WIFI);=
=0A=
+=A0 =A0 =A0 =A0 if (!technology)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;=0A=
+=0A=
+=A0 =A0 =A0 =A0 return technology->tethering_channel;=0A=
+}=0A=
+=0A=
=A0static void free_rfkill(gpointer data)=0A=
=A0{=0A=
=A0	struct connman_rfkill *rfkill =3D data;=0A=
@@ -479,6 +509,12 @@ static void technology_load(struct connman_technology =
*technology)=0A=
=0A=
=A0	enc =3D g_key_file_get_string(keyfile,=0A=
=A0				identifier, "Tethering.Passphrase", NULL);=0A=
+=0A=
+	technology->tethering_channel =3D g_key_file_get_integer(keyfile,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 identifier, "Tethering.Channel", NULL);=0A=
+=0A=
+=A0 =A0 technology->tethering_ipaddress =3D g_key_file_get_string(keyfile,=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 identifier, "Tethering.IP", NULL);=0A=
=A0	if (enc) {=0A=
=A0		technology->tethering_passphrase =3D g_strcompress(enc);=0A=
=A0		g_free(enc);=0A=
@@ -597,6 +633,15 @@ static void append_properties(DBusMessageIter *iter,=
=0A=
=A0		connman_dbus_dict_append_basic(&dict, "TetheringPassphrase",=0A=
=A0					DBUS_TYPE_STRING,=0A=
=A0					&technology->tethering_passphrase);=0A=
+	if (technology->tethering_ipaddress)=0A=
+=A0 =A0 =A0 =A0 connman_dbus_dict_append_basic(&dict, "TetheringIPAddress"=
,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_ipaddress);=
=0A=
+=0A=
+=A0 =A0 if (technology->tethering_channel)=0A=
+=A0 =A0 =A0 =A0 connman_dbus_dict_append_basic(&dict, "TetheringChannel",=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_UINT32,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_channel);=
=0A=
=0A=
=A0	connman_dbus_dict_append_basic(&dict, "TetheringFreq",=0A=
=A0				DBUS_TYPE_INT32,=0A=
@@ -1016,6 +1061,55 @@ static DBusMessage *set_property(DBusConnection *con=
n,=0A=
=A0					DBUS_TYPE_STRING,=0A=
=A0					&technology->tethering_passphrase);=0A=
=A0		}=0A=
+	} else if (g_str_equal(name, "TetheringChannel")) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbus_uint32_t channel;=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (type !=3D DBUS_TYPE_UINT32)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return __connman_error_inv=
alid_arguments(msg);=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbus_message_iter_get_basic(&value, &chann=
el);=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (technology->type !=3D CONNMAN_SERVICE_=
TYPE_WIFI)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return __connman_error_not=
_supported(msg);=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (channel =3D=3D 0 || channel > 13)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return __connman_error_inv=
alid_arguments(msg);=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (technology->tethering_channel !=3D cha=
nnel) {=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 technology->tethering_chan=
nel =3D channel;=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 technology_save(technology=
);=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 connman_dbus_property_chan=
ged_basic(technology->path,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "TetheringChannel",=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 DBUS_TYPE_UINT32,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &technology->tethering_channel);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
+=A0 =A0 =A0 =A0 } else if (g_str_equal(name, "TetheringIPAddress")) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *str =3D NULL;=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbus_message_iter_get_basic(&value, &str);=
=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (technology->type !=3D CONNMAN_SERVICE_=
TYPE_WIFI)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return __connman_error_not=
_supported(msg);=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!str || strlen(str) =3D=3D 0) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free(technology->tetheri=
ng_ipaddress);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 technology->tethering_ipad=
dress =3D NULL;=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return __connman_error_inv=
alid_arguments(msg);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (g_strcmp0(technology->tethering_ipaddr=
ess, str) !=3D 0) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free(technology->tetheri=
ng_ipaddress);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 technology->tethering_ipad=
dress =3D g_strdup(str);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 technology_save(technology=
);=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 connman_dbus_property_chan=
ged_basic(technology->path,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "TetheringIPAddress",=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 DBUS_TYPE_STRING,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &technology->tethering_ipaddress);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
=A0	} else if (g_str_equal(name, "TetheringFreq")) {=0A=
=A0		dbus_int32_t freq;=0A=
=0A=
@@ -1257,6 +1351,7 @@ static void technology_put(struct connman_technology =
*technology)=0A=
=A0	g_free(technology->regdom);=0A=
=A0	g_free(technology->tethering_ident);=0A=
=A0	g_free(technology->tethering_passphrase);=0A=
+	g_free(technology->tethering_ipaddress);=0A=
=A0	g_free(technology);=0A=
=A0}=0A=
=0A=
@@ -1935,3 +2030,18 @@ void __connman_technology_cleanup(void)=0A=
=0A=
=A0	g_free(global_regdom);=0A=
=A0}=0A=
+=0A=
+void __connman_technology_sta_count_changed(enum connman_service_type type=
, int stacount)=0A=
+{=0A=
+=A0 =A0 =A0 =A0 struct connman_technology *technology;=0A=
+=0A=
+=A0 =A0 =A0 =A0 technology =3D technology_find(type);=0A=
+=A0 =A0 =A0 =A0 if (technology =3D=3D NULL)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;=0A=
+=0A=
+=A0 =A0 =A0 =A0 connman_dbus_property_changed_basic(technology->path,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE, "StaCount",=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 DBUS_TYPE_INT32, &stacount);=0A=
+=0A=
+=0A=
+}=0A=
\ No newline at end of file=0A=
diff --git a/src/tethering.c b/src/tethering.c=0A=
index f930a26..7039037 100644=0A=
--- a/src/tethering.c=0A=
+++ b/src/tethering.c=0A=
@@ -49,6 +49,7 @@=0A=
=A0#endif=0A=
=0A=
=A0#define BRIDGE_NAME "tether"=0A=
+#define SUBNET_MASK_24 "255.255.255.0"=0A=
=0A=
=A0#define DEFAULT_MTU	1500=0A=
=0A=
@@ -200,6 +201,7 @@ static void unregister_all_clients(void)=0A=
=A0	g_hash_table_foreach(clients_table, unregister_client, NULL);=0A=
=A0}=0A=
=0A=
+=0A=
=A0int __connman_tethering_set_enabled(void)=0A=
=A0{=0A=
=A0	int index;=0A=
@@ -363,6 +365,140 @@ void __connman_tethering_list_clients(DBusMessageIter=
 *array)=0A=
=A0	g_hash_table_foreach(clients_table, append_client, array);=0A=
=A0}=0A=
=0A=
+static char *get_ip(uint32_t ip)=0A=
+{=0A=
+=A0 =A0 =A0 =A0 struct in_addr addr;=0A=
+=0A=
+=A0 =A0 =A0 =A0 addr.s_addr =3D htonl(ip);=0A=
+=0A=
+=A0 =A0 =A0 =A0 return g_strdup(inet_ntoa(addr));=0A=
+}=0A=
+=0A=
+int __connman_tethering_set_enabled_with_ip(const char *ip)=0A=
+{=0A=
+=A0 =A0 =A0 =A0 int index;=0A=
+=A0 =A0 =A0 =A0 int err;=0A=
+=A0 =A0 =A0 =A0 const char *gateway;=0A=
+=A0 =A0 =A0 =A0 const char *broadcast;=0A=
+=A0 =A0 =A0 =A0 const char *subnet_mask;=0A=
+=A0 =A0 =A0 =A0 const char *start_ip;=0A=
+=A0 =A0 =A0 =A0 const char *end_ip;=0A=
+=A0 =A0 =A0 =A0 const char *dns;=0A=
+=A0 =A0 =A0 =A0 unsigned char prefixlen;=0A=
+=A0 =A0 =A0 =A0 char **ns;=0A=
+=0A=
+=A0 =A0 =A0 =A0 DBG("enabled %d", tethering_enabled + 1);=0A=
+=0A=
+=A0 =A0 =A0 =A0 if (__sync_fetch_and_add(&tethering_enabled, 1) !=3D 0)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;=0A=
+=0A=
+=A0 =A0 =A0 =A0 err =3D __connman_bridge_create(BRIDGE_NAME);=0A=
+=A0 =A0 =A0 =A0 if (err < 0) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sync_fetch_and_sub(&tethering_enabled, 1=
);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;=0A=
+=A0 =A0 =A0 =A0 }=0A=
+=0A=
+=A0 =A0 =A0 =A0 index =3D connman_inet_ifindex(BRIDGE_NAME);=0A=
+=0A=
+=A0 =A0 =A0 =A0 __connman_ippool_newaddr(index, ip, 24);=0A=
+=0A=
+=A0 =A0 =A0 =A0 struct in_addr inp;=0A=
+=A0 =A0 =A0 =A0 uint32_t start, mask;=0A=
+=0A=
+=A0 =A0 =A0 =A0 if (inet_aton(ip, &inp) =3D=3D 0)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;=0A=
+=0A=
+=A0 =A0 =A0 =A0 start =3D ntohl(inp.s_addr);=0A=
+=A0 =A0 =A0 =A0 mask =3D ~(0xffffffff >> 24);=0A=
+=0A=
+=A0 =A0 =A0 =A0 start =3D start & mask;=0A=
+=0A=
+=A0 =A0 =A0 =A0 gateway =3D ip;=0A=
+=A0 =A0 =A0 =A0 broadcast =3D get_ip(start + 255);=0A=
+=A0 =A0 =A0 =A0 subnet_mask =3D SUBNET_MASK_24;=0A=
+=A0 =A0 =A0 =A0 start_ip =3D get_ip(start + 2);=0A=
+=A0 =A0 =A0 =A0 end_ip =3D get_ip(start + 254);=0A=
+=0A=
+=A0 =A0 =A0 =A0 err =3D __connman_bridge_enable(BRIDGE_NAME, gateway,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 connman_ipaddress_calc_net=
mask_len(subnet_mask),=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 broadcast);=0A=
+=A0 =A0 =A0 =A0 if (err < 0 && err !=3D -EALREADY) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_ippool_free(dhcp_ippool);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_ippool_deladdr(index, ip, 24);=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_bridge_remove(BRIDGE_NAME);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sync_fetch_and_sub(&tethering_enabled, 1=
);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EADDRNOTAVAIL;=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clean;=0A=
+=A0 =A0 =A0 =A0 }=0A=
+=0A=
+=A0 =A0 =A0 =A0 ns =3D connman_setting_get_string_list("FallbackNameserver=
s");=0A=
+=A0 =A0 =A0 =A0 if (ns) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ns[0]) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free(private_network_pri=
mary_dns);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 private_network_primary_dn=
s =3D g_strdup(ns[0]);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ns[1]) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free(private_network_sec=
ondary_dns);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 private_network_secondary_=
dns =3D g_strdup(ns[1]);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
+=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("Fallback ns primary %s secondary %s",=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 private_network_primary_dn=
s,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 private_network_secondary_=
dns);=0A=
+=A0 =A0 =A0 =A0 }=0A=
+=0A=
+=A0 =A0 =A0 =A0 dns =3D gateway;=0A=
+=A0 =A0 =A0 =A0 if (__connman_dnsproxy_add_listener(index) < 0) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 connman_error("Can't add listener %s to DN=
S proxy",=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BRIDGE_NAME);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dns =3D private_network_primary_dns;=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("Serving %s nameserver to clients", dn=
s);=0A=
+=A0 =A0 =A0 =A0 }=0A=
+=0A=
+=A0 =A0 =A0 =A0 tethering_dhcp_server =3D dhcp_server_start(BRIDGE_NAME,=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 gateway, subnet_mask,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 start_ip, end_ip,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 24 * 3600, dns);=0A=
+=A0 =A0 =A0 =A0 if (!tethering_dhcp_server) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_bridge_disable(BRIDGE_NAME);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_ippool_free(dhcp_ippool);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_ippool_deladdr(index, ip, 24);=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_bridge_remove(BRIDGE_NAME);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sync_fetch_and_sub(&tethering_enabled, 1=
);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EOPNOTSUPP;=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clean;=0A=
+=A0 =A0 =A0 =A0 }=0A=
+=0A=
+=A0 =A0 =A0 =A0 prefixlen =3D connman_ipaddress_calc_netmask_len(subnet_ma=
sk);=0A=
+=A0 =A0 =A0 =A0 err =3D __connman_nat_enable(BRIDGE_NAME, start_ip, prefix=
len);=0A=
+=A0 =A0 =A0 =A0 if (err < 0) {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 connman_error("Cannot enable NAT %d/%s", e=
rr, strerror(-err));=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dhcp_server_stop(tethering_dhcp_server);=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_bridge_disable(BRIDGE_NAME);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_ippool_free(dhcp_ippool);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_ippool_deladdr(index, ip, 24);=
=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __connman_bridge_remove(BRIDGE_NAME);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sync_fetch_and_sub(&tethering_enabled, 1=
);=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EOPNOTSUPP;=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clean;=0A=
+=A0 =A0 =A0 =A0 }=0A=
+=0A=
+=A0 =A0 =A0 =A0 err =3D __connman_ipv6pd_setup(BRIDGE_NAME);=0A=
+=A0 =A0 =A0 =A0 if (err < 0 && err !=3D -EINPROGRESS)=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("Cannot setup IPv6 prefix delegation %=
d/%s", err,=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strerror(-err));=0A=
+clean:=0A=
+=A0 =A0 =A0 =A0 g_free(broadcast);=0A=
+=A0 =A0 =A0 =A0 g_free(start_ip);=0A=
+=A0 =A0 =A0 =A0 g_free(end_ip);=0A=
+=A0 =A0 =A0 =A0 if ((err =3D=3D -EOPNOTSUPP) || (err =3D=3D -EADDRNOTAVAIL=
)){=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;=0A=
+=A0 =A0 =A0 =A0 } else {=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("tethering started");=0A=
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;=0A=
+=A0 =A0 =A0 =A0 }=0A=
+}=0A=
+=0A=
=A0static void setup_tun_interface(unsigned int flags, unsigned change,=0A=
=A0		void *data)=0A=
=A0{=0A=
=0A=
