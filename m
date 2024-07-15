Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3756FC1
	for <connman@lists.linux.dev>; Tue, 16 Jul 2024 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.132
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721106039; cv=fail; b=hTkkiQqMB6OcMv0FRH4EedOHL6Xu1WN2f3eIXfiECA8vieUsyLjLgtIHtmCClYhCq3SdUBToFx4dvtYgBOPW+aKETR5UR5HK2F6dRjS25CeGsFvJGX0GyzwGgWGSpc5NvIrGA9LDdb97nV4dL1sXEI8mdwg+zKTnwILKSWPK+qg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721106039; c=relaxed/simple;
	bh=UhH5zvQOQQGcsg72if292wD6j9Lg6O4Cu22kB3xEzlU=;
	h=From:To:Subject:Date:Content-Type:MIME-Version:Message-ID; b=iromZd58NYCbw2+OaIp3AxQYo73eP/JXjZafYDXH1G10utq08uWRs3NTYN9ox3ssB9hzjLX9086NuKfJc1mmegz7UYvYS+F/I+glfOYb17HwNDKjftxinuQq3P9KzEqAQLHYqzNNR32b1vWhDiyS2Fz+yhYkqQj1iyO/jA90UMQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goeg.at; spf=pass smtp.mailfrom=goeg.at; dkim=pass (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b=qKUXq3dT; dkim=fail (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b=ChtVo1qW reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goeg.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goeg.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b="qKUXq3dT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b="ChtVo1qW"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=VL5RKqvJHpJp4dZvGeBZy5ImNTe72Qi1cjndwcjnccxy0s/PR3khQMQRxNlDuyWB0KTOnJAZTxESMeHEBUCuyKgUrR/UFGXbUajXFFYwVEkYGIUN8kN8rxh4cvPZl20XpRg95vkxebd4Vy2dGrEBQkuHM1/lGsG3Nge7U3G7qxtvvZ+AowIOa8xSUP6fizuH3MPy6nC9JAh8WbPMmjYp56NL3NAdFjudO3vWVz9z1lk1GztAik9aaiVwy6XNK6nS7dlqQH+bdD2xyJhceg2rUUUtAANYu20tgYhA/WR7AuvleiRMbuxg263XUxigTNuhczhlLr3QQey3WQUOAhS/MA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhH5zvQOQQGcsg72if292wD6j9Lg6O4Cu22kB3xEzlU=;
 b=GWdd7d7p4DGAdKQr/FA/ch50P6R71b97pPl7Un8yN7NviU9Z+TX1FctePwna6G36gM51Ci3ABGQWjZIUr7gy6atkLDonANVMMzqqSOc+Yz5/MFsci2GnGBSzO4XVxGSXgPiuk6vHCcJ0xMlJUgW9IVn0wywCeUFQktPPmMhOvH82D46dL6OeWNzBxwa6skXOrRFl7msHk9y1dlTG8JTOmxaq+YEfyh/x3mKumM4wJ4O3pOY8Rz+gzOq23SKELdFFYmITaL5U+YTQTTEbPCdzebrRdMvd3HTvBS5SiQu19/G5gtG6uA5uqpsGjB9na2txr9o+FYFgi8ViP06JOnuoWw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.52.142.9) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=goeg.at;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=goeg.at;
 dkim=fail (signature did not verify) header.d=goegat.onmicrosoft.com;
 arc=fail (48)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhH5zvQOQQGcsg72if292wD6j9Lg6O4Cu22kB3xEzlU=;
 b=qKUXq3dTPTUtj0ebQda5ZNDFQ4D4bg/CxzepzdRXQ4U6++bK3Zqm4n5s8FdoA4mX8xYYQp+FPB2/E5OtyOVrATSSyCMXXIRLHm/7DIVl/c4Ki44Jd6dwWQ8YuzJxR6tvOkw2mO5aT7v1hKZEpGABLNTihPkKwcjh1dmyUXl69s4=
Received: from DB9PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:10:1db::32)
 by AS4PR09MB5705.eurprd09.prod.outlook.com (2603:10a6:20b:4ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 05:00:28 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::ba) by DB9PR06CA0027.outlook.office365.com
 (2603:10a6:10:1db::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 05:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.52.142.9)
 smtp.mailfrom=goeg.at; dkim=fail (signature did not verify)
 header.d=goegat.onmicrosoft.com;dmarc=pass action=none header.from=goeg.at;
Received-SPF: Pass (protection.outlook.com: domain of goeg.at designates
 20.52.142.9 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.52.142.9; helo=goegsIQSUITE01; pr=C
Received: from goegsIQSUITE01 (20.52.142.9) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 05:00:28 +0000
Received: from mail pickup service by goegsIQSUITE01 with Microsoft SMTPSVC;
	 Tue, 16 Jul 2024 07:00:27 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com ([104.47.18.112]) by goegsIQSUITE01 over TLS secured channel with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 15 Jul 2024 20:09:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn9Xqbaus/+HYnleJMvUN30o3wd6bOBqlQSD7skeOHRVwGkD7M5+M5jP8U5kl6ZJ1NY9Iy++7qC5QpSkjuLCT6NrmroTpuH3epwYbOuP/AEgIXRiiZRZeISZt17iI3eXSBdGw9HFM1YmpVHjeos7rfX4pewfZSjf0PYtNOP1jwImdwBxF/WTOyl/qNHGJ0g1t5DJ6x63HeNSTplgVxlgcP3Qg4W/jYeKRs6YJ61+ivi/gcV/0DyqmGzv68RyuWROK3cLYYQU/8J956LpTH+8gmSmLbjp8n1wESEIj0rNQyFPFmeMTMJSO39D2z/m/RJ2KtqsTlF6sgPLGgyOHZ/1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhH5zvQOQQGcsg72if292wD6j9Lg6O4Cu22kB3xEzlU=;
 b=XTiiRoJCyLpx3hXlNWdAxbyNX4ivkba3rDukmQpCDaxNcxNNbh58y61tlf1kRz6SQFvIRHtp3Qg0ca9zH/hDRSCXyYT+5UvJiwhGLgaiYBsCym1Ov26RyGJEfDIG6YmTEmgbA7CC6OI6Y9PmCwsHHYcTQDg1gORldvQQN6BnNxQO4K4+2YZMrIzj9PcKiVZPKWcgWwSrq1i7N6dJq8KML0Occq/paXWDZJRm5niYIGe+uOUxBhsxhbq9IAnWvc+dmaQ6OJzVjTW0RVASXlfzg1jLfFh/g0OG239+VJs8gph/qW0M8e09zxtCx8WP83X/gdKk9hgE4X+jNEbztDVNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhH5zvQOQQGcsg72if292wD6j9Lg6O4Cu22kB3xEzlU=;
 b=ChtVo1qWX1fqBxu9Mm/N7adUR10Ln7Nqyh5/1sTaqiHzqLCPVbZoertfiV2bjktSumSMOz0E5l2Po3f2e1mQPQrEoQfZfA1DjIUmsPYYCLDNqe1T5ssYS8Hc5RWi+3tzJ3G4S6xngPAG20hk/b89xFtAJ8oowycq4LYI7VdFlko=
Received: from AM0PR09MB3633.eurprd09.prod.outlook.com (2603:10a6:208:17d::15)
 by AS5PR09MB6748.eurprd09.prod.outlook.com (2603:10a6:20b:67d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 18:09:10 +0000
Received: from AM0PR09MB3633.eurprd09.prod.outlook.com
 ([fe80::dbc6:2b00:a35f:6eb4]) by AM0PR09MB3633.eurprd09.prod.outlook.com
 ([fe80::dbc6:2b00:a35f:6eb4%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 18:09:10 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: DNS vs. Route preference
Thread-Topic: DNS vs. Route preference
Thread-Index: AQHa1uIX6OYrhHv0vEa7H25i+QChnA==
Date: Mon, 15 Jul 2024 18:09:09 +0000
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
x-ms-traffictypediagnostic:
	AM0PR09MB3633:EE_|AS5PR09MB6748:EE_|DB1PEPF000509FB:EE_|AS4PR09MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d39c13-d8d0-4302-cffc-08dca5543632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aFdueFNRazkyN1dDaHY5RU41bmJja0hySXQvV2QwellIRS9SdERaNVlXNGpr?=
 =?utf-8?B?VXZ2QUhCS0VadkJCeEF0RzRLc09YMkxTWTBiWUJkUUp0VmJ0YnZuTGFkMGhB?=
 =?utf-8?B?KzV5MWRvb2ZrTjBlc0FMR3huWnk4S0dIUG9WdDRHRXl2cEZBUURTT2ZTUTJV?=
 =?utf-8?B?WUhLQ3BObXlWNHMwNmZyRE5PbWJsZUYvbG0rV1ZYRXdkRUNkdzE2bm1nLzdL?=
 =?utf-8?B?aU5PcExXYXVGemRwWkRTbVRFRHBsSUkvMXlPb1B4NmRVL01LZ0Vua3U0MHZn?=
 =?utf-8?B?amlMSitTSnJDMWhQVys1N2lybEhNbXgvb1lIMzdlWVZXQnJ5bW03QWtlTFM4?=
 =?utf-8?B?V0VteG9jTVhPZkFMMEJnQVFyMVE3UnpESkhMMTF4ek02VDZkVEJMeXIwQ0ZK?=
 =?utf-8?B?dDU0dTBwa2xwZkZHQVZpMWl0QTdWTGw4RFFMeHQrN3hCbEV6eW1VSDFMS0xv?=
 =?utf-8?B?VkZZZjF0eFhnNitZWjF2WHpnL1F3alZDaVJMMjZqdGtVdnRTWmhKT2dlbk9P?=
 =?utf-8?B?MXgxamU2Qll1cXVUcmFrRlFYK3FDWmdCQ3JFRmlzOGZ4b3dOZERldUJtdkdB?=
 =?utf-8?B?bjAyay9FdmZ1QlJmRUc2ckdMTzA2NkZRK2FtV212S2RyODFBZUwrNU9oZExL?=
 =?utf-8?B?R2RMRTdxZVdpbDdnY2NCQmdPUzF2RG9xWG55N3pwRGErZVU3WWpDeFNkRHI1?=
 =?utf-8?B?QzFhOHBUSFVBRlQzYVdsMWJoR0tjRTJaZHpwK2V4eU41QjRQcjFZZnl4dzda?=
 =?utf-8?B?RHFDUnZobnE2YUtGTU01NGJGYUIwRjM0dklNa3ZFNzlwWDBUV3VnaTBOQkdP?=
 =?utf-8?B?Nkpod1MzRnlneFN0Zm1xWklYOUxwUFZUVnFENUxWV05JMEYxWlIwakUxR3Y3?=
 =?utf-8?B?cXl3dmk3TE1WZTVYcFdTQmlOSmlJZUV6S0JPMEFCNTlCV3lQNmJjR1ZnUDZz?=
 =?utf-8?B?N0VGbzNxUW5qYndBalpZQlNWZ1hILzFJRHV2cWVwbUtEdVZwbzk4UW9nckZk?=
 =?utf-8?B?VWhsM0tZNlZLUmhYMVo3Wm9PSG1BN3ovUjVYa2ZMdWx0d3FNckpONWxOMzZD?=
 =?utf-8?B?NTdvY05FTWxPV2NmWTdndlF3QmxTWU5QWWM1dmhobU9TR2s4RVQ2cVpBSDYy?=
 =?utf-8?B?MFRuZ0NsQVc1L0ZOZEdWaURveWVQZXA5NDd5MmlOQWhnd1d0Q2dWME5pays5?=
 =?utf-8?B?dnkzSk9GeWNxeEZ6cm1uSFJ1QlRyL0JldHhWZytDb3pYcUJoVEFTdU9KcC9Z?=
 =?utf-8?B?V3YwT1Z0Skt4UTY3MlFXblFGcGlOQ2RqWHJYZWlROTI3RWJKNXljMVc4Wmsr?=
 =?utf-8?B?Sks2NkxjM2U3SlZtd0ZEeFV5RXpXWkxFUUJ3bVF0dDgxa0tPK1lFT0NzUml5?=
 =?utf-8?B?NG16cVVKMzJ2ZXlWVFZubCtvNk81MG9sYTZkRHZpMFBwVDVPV3dweWxQQUx2?=
 =?utf-8?B?RHoralZjcE5laVVhbWtZQnZ2RmsxVmpXdytodFdTL0puVnAvbThJM2dma0E4?=
 =?utf-8?B?YnMwK2c0THRqYnJUWG9WREdHMmJja2EwMUNTQ0wvUHZJZkViSDdha2NyQm56?=
 =?utf-8?B?ZklaVTFSV2VxMEk1bnJXNnErK3VYQndRQndQNHl1VDZZUE1MVFZITjcrT0dC?=
 =?utf-8?B?OXFtRWhnelNQUm1pMncvbklXUHFGRkVucWM4NGZLdkU4STJPNkQ3bS9IZ2xM?=
 =?utf-8?B?Rkp3VUVKa2REa2F0aVZrbHQxTFduZzRoUVd6cUc3SnVuL1JaRHNudGNnT2Z4?=
 =?utf-8?B?Z3VkRjdPbDZBenZubFh0ZTQ1Y0xSRWZSWDZuOXRmY21vL0k4blRYeTJzZWYr?=
 =?utf-8?B?THBmanRUdmpIaTIya1JNcytsL2pxbVFqQ3dvb2MzUzdvZ0U5MjBXcjFabEVr?=
 =?utf-8?B?OWpwUGxNaXJwWHZkQlJwWlQ5RHJMdXRGTlBSQ0M1UWVYalE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB3633.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D67161D12A3634283BC480638286ED7@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR09MB6748
X-OriginalArrivalTime: 15 Jul 2024 18:09:12.0034 (UTC) FILETIME=[1859C420:01DAD6E2]
X-GBS-PROC: 8nEwQmeqoarrBYExp6GMHAPw+uZ08dwygp6X3cXg+bBL/oDgDdyMxLM9x6IBLMBb
X-GBS-PROCJOB: gkxpUYhvItEIlXul1hEle6l7rIP5PdRlnsHL9JwmfPZUEydFsx/516i/6QNS29fp
X-GRP-TAN: goegsIQSUITE01@7D11BDA58E064882808310ED5B0DEC95
X-iqsuite-process: e13a3393-6c38-45eb-8279-3913da145940
Message-ID: <goegsIQSUITE01C8wSA00000006@goegsIQSUITE01>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e8bb917b-f5b6-4a32-d64c-08dca4f9399d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGVDQThOeWgySlhSNVA1STBvakVqUFc1R0xPMUNtallPeHlqUkpWRXBqQkdL?=
 =?utf-8?B?cjNnU0JjVno5Q1AxeFEvbWFlbVNRL1hHNDc3THF5SlRWWWNteHBPakxJVlkr?=
 =?utf-8?B?dTNLNCtSNzV1dkFTdGd4clp0bU14eWVKREJPTERMZDhId1pKaSt2YmZJQWwr?=
 =?utf-8?B?Rk1yaGhHbWpFTlFLZTJ0Z3VnNjUraGVaQkNaaUFFSjdYWkFOZTFKNDVCTUpq?=
 =?utf-8?B?MjJKR0k1amlOaVg5d29zWDdnNnRTSVRBamV2NVRGWGN1VGpvMGsybnAwMEtF?=
 =?utf-8?B?UkUwVHlwRHdUcXMrbkVjbDFRWG1kTDlXbzJad3Jad2ZPcGJ1c0dpbk5CYnVa?=
 =?utf-8?B?K29NWWtYcHUvenNZVUFVcXArZUlYSHJCRVJib3dlMjgzSmJ0dUp1dGhjeDRE?=
 =?utf-8?B?ckc3dTF6RmFvMCs1UG5DZFBlcndCS3hHZGMzd1BuYVowUmowMGFFczE4QldT?=
 =?utf-8?B?YXhQTy9ONS9KTk5HdFpkWkJqTEhCWXNIRFQ4aVpLNjBJazdQS0YzMVRSSW5r?=
 =?utf-8?B?bWJTYXBtRGN5WFpra0RuektNbzljNlE0OHQrT203RDBiVUtuanY3OHJlUi9r?=
 =?utf-8?B?SXZObXJvMlUvMHV4L3RGMlBnZHg2R2FOc1JVV0hLOVVieE1DVXo5ZHZ1M0hs?=
 =?utf-8?B?bmJKUldQbm4wdWJQUWpXZXp1cDM0Vi95dGJkLzFHTHU0MTZMZU9ma09wdFQ3?=
 =?utf-8?B?V0NGSy9UYUFVSXZwRmtRWkF1ejY5N0Evc3d5aDhOQ3dOS3pUK3QxRnFhcEdV?=
 =?utf-8?B?NGxsVnFJbnNuemgzb0dtcUhYK3NHSjVBOG5ORHZlYjBWc3V6S0ZxeXFVTFZP?=
 =?utf-8?B?dFhpVmdJSTlkaHJZRG9odWZpcXI2WTZpS1Y3YkpjS0M5V3RPa0phQnNsRmhr?=
 =?utf-8?B?dFk1dmxrYW93cjF3ZlBkUm5PbFU4YlY4RFVwbnQ4dTBYK1VxdlVMdHZtYTR5?=
 =?utf-8?B?V21aNXV4M2Q5b3NFSEpZK1hJbEFVdzFBUTBjd292eHkrNlpZNEE4a0ViNTk1?=
 =?utf-8?B?bjh6WHd0UnpkUHRHY1J5ZHFIZkFneUtGbHFCd3dLRU1Kbm9DemFQbWs3cDRo?=
 =?utf-8?B?OTFhNTg3cTl6REd3OFR5OUlLTzdZbTgwNGhOSjNFUTdUQUs2bkxkMmdqSFpO?=
 =?utf-8?B?a0VXYmMwUHhBTnp5U09RUzdnMW1VOFo3SHZrNWlvVDVXd3BDWVpwUmF4VmdS?=
 =?utf-8?B?WHJvTm5nL1IyV21JcElkNEZrSkk0WTZ3aCtNWk1vckhrUldyZ3dZajB1ZWd4?=
 =?utf-8?B?MDU4S3NMTkcvS2tIcU9pSTd6YjMrRmtTQzBkazdxRkFGcVNtR2tNSFJRVEhy?=
 =?utf-8?B?Ky9wWUQxSjNPcE5NRWxsbEE2Q0pKeGkzUXJQWTNqR2lROVdoamNOZEhoMld1?=
 =?utf-8?B?TmNDZ3YxUURHUmFBb0tDZTQ2U1Q5RE5iYXlEYlNMSTROZWZ6am5OVEtoMXpq?=
 =?utf-8?B?UkJkVnVMN21sdmVnZW9VUHd5U05zVmIyZUNJWmNIeVc1N3hTUjRZcEY4bEJp?=
 =?utf-8?B?Z21yelRibVllVDc5dXM3ZjRmVytUZ0pYWjYwUWIyRWtnbjVGT2RNQnJjdjBY?=
 =?utf-8?B?YllTL0J1YXNUdUM3UHIzM0VQMlZicU5YczJ6ZnR4cjNYYmZMbjE0SnJvL29E?=
 =?utf-8?B?Y1hDMDhxZUtCR3BLdXN4RFVRUkU0MG1QL09HZEhTcmFXZVRNcGN3N3VBazhW?=
 =?utf-8?B?d0NtdXFYbSsrblo2VUticlFVcEtmOXRrVUlMUkptaUtWK2c2REI3V09tL28v?=
 =?utf-8?B?bUtKOWlmSjZFQ1hFN0c3ai8rRS9abmRPeERybWFDRWtQVUNRWERaajZCOERL?=
 =?utf-8?B?cFJSemZudHVTd3ZwWTBRMDBsNjI0UmEyVWluLzcxMi9HaCtuNW5lc1BacXFS?=
 =?utf-8?B?VlUvbjlza1FTaE8wbDg5UytnMS9JQlFKd3FwQ3hiM2t0aWdoUU5VcmpNT0Zk?=
 =?utf-8?Q?H9XqBOaWwjoFzpTpib0VuEac2Ebqcaiy?=
X-Forefront-Antispam-Report:
	CIP:20.52.142.9;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:goegsIQSUITE01;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(35042699022)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: goeg.at
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 05:00:28.4434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d39c13-d8d0-4302-cffc-08dca5543632
X-MS-Exchange-CrossTenant-Id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff;Ip=[20.52.142.9];Helo=[goegsIQSUITE01]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR09MB5705

SGVsbG8gbGlzdCENCg0KSSBhbSB1c2luZyBEZWJpYW4ncyBjb25ubWFuIDEuNDEgYW5kIG9wZW5W
UE4uDQoNCkkgaGF2ZSB0byBzZXQgYSByb3V0ZSBwcmVmZXJlbmNlICgibW92ZS1iZWZvcmUiKSBm
b3IgbXkgbG9jYWwgY29ubmVjdGlvbiBiZWZvcmUgdGhlIFZQTiwgYXMgb3RoZXJ3aXNlIHBhY2tl
dHMgZG9uJ3QgZ2V0IHJvdXRlZCB2aWEgdGhlIGRlZmF1bHQgZ2F0ZXdheS4NCg0KSG93ZXZlciwg
dGhhdCBhbHNvIG1ha2VzIG15IGxvY2FsIGNvbm5lY3Rpb24ncyBETlMgc2VydmVyIHRoZSBwcmVm
ZXJyZWQgb25lIG92ZXIgdGhlIG9uZSB0aGF0IGdldHMgcHVzaGVkIHZpYSBWUE4uDQoNCkkgZG8g
Z2V0IGNvcnJlY3QgRE5TIHJlc3BvbnNlcyBmb3IgaW50ZXJuYWwgZG9tYWlucyB0aGF0IG9ubHkg
ZXhpc3QgaW50ZXJuYWxseS4NCg0KQnV0IHRoZXJlIGFyZSBzZXJ2aWNlcyB3aGljaCBoYXZlIGFu
IGludGVybmFsIGFuZCBhbiBleHRlcm5hbCBJUCAoZm9yIHRoZWlyIHB1YmxpY2x5IHZpc2libGUg
QSByZWNvcmQpLCBhbmQgd2hlbiBjb25uZWN0ZWQgdmlhIFZQTiwgSSB3YW50IHRvIGdldCBhIHJl
c3BvbnNlIGZvciAoYW5kIGNvbm5lY3QgdG8pIHRoZSBpbnRlcm5hbCBJUC4NCg0KSXMgdGhpcyBh
Y2hpZXZhYmxlL3doaWNoIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyBkbyBJIGhhdmUgdG8gc2V0Pw0K
DQpPciBpcyB0aGlzIGFscmVhZHkgaW1wcm92ZWQgaW4gMS40MiBhbmQvb3IgY3VycmVudCBnaXQg
dmVyc2lvbnMgYW5kIHNob3VsZCBJIHRlc3QgdGhlIGN1cnJlbnQgbWFzdGVyPw0KDQpUaGFua3Mg
aW4gYWR2YW5jZSBmb3IgYW55IHBvaW50ZXJzIQ0KdGgNCg0K
