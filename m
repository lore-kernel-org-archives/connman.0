Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634A241673
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232431; cv=fail; b=gy/oqo7FmzEnfvb69HzbGJjrr7YVQXU5LHU4aCBlDiyEQFqBxbsfQVbj+Hl7WmysvBI+9sG+8tb/Th3V8xdtPaHG0oURiCfFvZCCZkWmLLhW2wJSAEDbKpN0dW2fWEGUQmsws+28wdjWGMrK28HQGGozRXNtQlSDGDQRJ+2/NQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232431; c=relaxed/simple;
	bh=0nazygIrbLiPb7NwU3vhUa6y4q8xD55QkL97w2HiocU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fSR/61W9l2XVEPECY617vzVehbsxBhaWl/JzWvw68GWkqWSjnx6GJ4mjFQ83u5ffJccTyzdw20jw5zLHc9Fvgv6ydFlgkjUgehr3a4Msi3yPZpOgJghTHP1rH0aMuID2PcHhwwHJrUqwokWiW37tASYtJdqWhv1VsEkp0BhlMtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.53 with ESMTP; 11 Jul 2025 20:13:38 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo5.lge.com) (165.244.66.186)
	by 156.147.1.127 with ESMTP; 11 Jul 2025 20:13:38 +0900
X-Original-SENDERIP: 165.244.66.186
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO PUWP216CU001.outbound.protection.outlook.com) (40.93.139.0)
	by 165.244.66.186 with ESMTP; 11 Jul 2025 20:19:20 +0900
X-Original-SENDERIP: 40.93.139.0
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: michael@amarulasolutions.com,
	connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+YnvXHw3RjXF7vDvSvyDt/II7s+bQRVOB1FpBQYIBhqRGYlXBDEtv57oboxKx8FNTf/AsQzRNGN1wLkg4b+soxxGTyzJO6z2hpngl5jdXb/Jzb9stOog936mi1WoYDbabo8XD5+7pHTMXKEYmtX6fEwT+iysmk9qnLM2k4bxlzkM6OYD6/ke5jUd8G4OMqsEUnyfz68a0+qv0iFFfAtwco7ChWFpQQG3ZPp/nsQkO2uGmBUFI16iFE+kJXlYGhzTUFImO7V7TAeRcXQOwStMOsbd/i8yEph4pCrh7zombraKWvtLktSD0ysvO3qbSnIPyTKamsZ+UCVNWHM2+6+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nazygIrbLiPb7NwU3vhUa6y4q8xD55QkL97w2HiocU=;
 b=DlbNlEsRNWxEBOp+rzYwUlXrvnjW7a//YHAgxxRTsY5SBEnK5jSh4bpRMhemIJEKxt/fN68/2IuRr8Xk0ETHWjLjafeIQOnILb9GH96fDHT32WxuPA71HwE+EiciL5e8a9vvFQP4frO82KUU+YGjAcqomTx4FUxUqdcg5Hb3CQ00iMYRyns+mPGX/6togDC8RDkwS7+WTpQhGpD7z+/o3vEaS1rYkqglHWJw7uurnOdMKmQETt7TfVLr7J9Ty8qnRg83yLJ0gYNuLiAewK7OPjoYx7W3BDpSC6Vj9fo4nu8VhkDYSySF2++nH/srdQqcWoj2iftZRc0D4e1l0HrrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by SL2P216MB2912.KORP216.PROD.OUTLOOK.COM (2603:1096:101:280::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:13:36 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%7]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 11:13:36 +0000
From: Shailesh Rathod/LGSI Connectivity Team <shailesh.rathod@lge.com>
To: "michael@amarulasolutions.com" <michael@amarulasolutions.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>, Shailesh Rathod/LGSI
 Connectivity Team <shailesh.rathod@lge.com>, Vasu Kantubukta/LGSI
 Connectivity Team <vasu.kantubukta@lge.com>
Subject: Re: [PATCH] connman : Introduce softap with ip feature to connman
Thread-Topic: [PATCH] connman : Introduce softap with ip feature to connman
Thread-Index: AQHb8kvUKi3C/Nd0NUGyCfAAxwYCVQ==
Date: Fri, 11 Jul 2025 11:13:36 +0000
Message-ID:
 <SE1P216MB2647C232928EFD6B3B54BCA8F04BA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|SL2P216MB2912:EE_
x-ms-office365-filtering-correlation-id: 3b1073a9-cb4f-4b70-a809-08ddc06bfb07
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WLFXDdLfYAgkggDVGJYePA/owtMuq5+hdANhLA5XNBixPMWNJVU+aR78zA?=
 =?iso-8859-1?Q?phooxkxtlTnvOSfS5eUZ773STn0uubEseflBAmMM6VuT0ddB9I3386lAgC?=
 =?iso-8859-1?Q?qolwttugMkGILMjLjDD+osgsrUgkJEGTBcfjIe+ge/DqQ/h1So2o5NNMGS?=
 =?iso-8859-1?Q?GTcxJD3/tbOEfCJUKURDduXWVF7CjOxTImyopY+Ln0f9a8zepJ4tNDdh6g?=
 =?iso-8859-1?Q?l0r98RMouHsh34wjCmA6nVQdp7SlaOhwLJR6OgLEtFQcyh2xXnfQuOTFXM?=
 =?iso-8859-1?Q?ujANzrTmNJCIWo3d5eEL62gsCnTPv0BWewDysFPnHh4iGfaxeVfmH08fBd?=
 =?iso-8859-1?Q?n9wUF5UBoyoyt3yVsip9KCmturHoIPbqTlb9D81xUr49SUJdHTKCmvPrrg?=
 =?iso-8859-1?Q?Ybc282Nna6VKJGGY7c/sUdRiKRq8pv/0SpG80IwBRU5r5VbH6awG0i4VZJ?=
 =?iso-8859-1?Q?E+ifQp18rYB8cPQ0De75PUdt8p5bpkc3Sa4RjSz2rvNcuWl2vFcEO639Kw?=
 =?iso-8859-1?Q?FFpAwvHhdB1idEUXx92mmaEAMfunCeCfo2DNvHouJhR6DxJW/ziIVK9/QG?=
 =?iso-8859-1?Q?7qLCnPanOOkq2Fzloe2IgolVNyuScb86wLNI2K/PRsI7WHvw1vCxE2rtac?=
 =?iso-8859-1?Q?3cs6zV1F4NvdY3nPbiaA4/pYHrqxrlV0XPC/unlR+ooLC9m4JxNHvuwQxw?=
 =?iso-8859-1?Q?uyjOVwD1nlWK3cZf+8yevpXtw4AopTNezb8WvSfkZ4GxRMGYqHUdIzzJzc?=
 =?iso-8859-1?Q?AoeQfcCi6IlF5yI2uOs1xJRFmWCISDpMNBST5c1JfdgAaBWNwjpMWOn78F?=
 =?iso-8859-1?Q?1RU8pVVTz846IlZ7vuOO/fdJ/hstwCojAvjsD6hYYVpqz01gljtEXLZfDv?=
 =?iso-8859-1?Q?9xVRUZ6Dc1hYnpP/a5MI+FtVA6IQ5bsyiDfTRmCbiWe7a0lfkuLqHaBQnL?=
 =?iso-8859-1?Q?q9V5VhK1Myqe8qHCo3GS26FTSHmhWPNMS7ho+x1PzTfBbYxle84dMOpKKd?=
 =?iso-8859-1?Q?9nvqBL8TCgveKBpRUuaebORuO+ly99RF+50rFc50HVvlpvkOlbnBOtOr3o?=
 =?iso-8859-1?Q?alcegy7BDTMza3OSEexLQiFZNAz9Mg0WsoNDthuf+L84u/QjQ3h+lB021w?=
 =?iso-8859-1?Q?Sl4B/WSXc1Mfyxr9/dulyguPAqmPIQu8efTO1Kuh1gfcjs6aydvePTjOqB?=
 =?iso-8859-1?Q?hAEcX4YGMjNsa/QzGMUaSKROTwP+0P1DRrrBs660ffK460iISffHTsEPfr?=
 =?iso-8859-1?Q?zQvK5H+8XvbAt2WsQC8NBSv5n/KrB1vUj7l4X8WFsPnOfnHLhJoi1oH5Wy?=
 =?iso-8859-1?Q?ygJOY36jky5VS2/zv9WT3owIkeT9OyWFVWJGcCSL7j9fv7ad3ig1HDKtFb?=
 =?iso-8859-1?Q?vwqqMwMbKjWqebhQwlP4UufAM8ocFnOWHliB0H0FBseGgmnRqoP+uzqhIJ?=
 =?iso-8859-1?Q?iHwZWzxAmef21YPEZi9wreiCqA1zjntXhPe77F6K5DwdRxc5b1PpY+pb4j?=
 =?iso-8859-1?Q?T3F5AOBALayVqiTNNhendd+eCMNSY+2BXUfe619Hf/uVUoDRKEJ+UfalUD?=
 =?iso-8859-1?Q?0X+bStU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lglWdEElg4hK23KoPuqPNve6ItUCbn7cM+QH7uPO5xNxvZgA7VAgMP4e8i?=
 =?iso-8859-1?Q?P9IXoaU6fyvasUFtr5an9JF03DQWOxiM/o0LGlp8sn4vULB4whGSuWvPji?=
 =?iso-8859-1?Q?GMHGG/pL3ILGuZ/6e9X05b090XQ9PE0nV7lWzCTyaLiA4kIqQUaWL3Z5G+?=
 =?iso-8859-1?Q?VKmGR0VNJjS5bF/QhcH1aqd4j7N8Hj5iOyJf36Pz+w9HWyJ67AjeHXaIHC?=
 =?iso-8859-1?Q?nOLeoEPjTT3lrxz7a/UtEHwshLTyqk/W+WyuWdBGu63DNVcpXFQM1jH6YO?=
 =?iso-8859-1?Q?33RaYO4pcJnD8sgbh1UbCUsZV35793gdC7uGKoW8/MKex81KioyTg2wdlm?=
 =?iso-8859-1?Q?zIuPLoBiuw+6Teg5B0YoVGCvdhyM+CtMjPBYDNBb9kNjSoL+BL4QNxDRek?=
 =?iso-8859-1?Q?8cytKEw8N8/g0egN4mj60ufDsN6lPknYTldVk1qV2DGnK66EvjRhSk3vTM?=
 =?iso-8859-1?Q?zQp/H77JcYUAyEFOanikJ4O49pf0wDcr/E1iQWkPAdnc/hiCk4akKmxaCa?=
 =?iso-8859-1?Q?ZhNJa99o7bprv49+PklXp+DBclCd7QAaoS4ox8USDx8huDJosFor8XXV4A?=
 =?iso-8859-1?Q?MFXGlWHu2zb9ScpRPkriFC7mArl8ws3peSdvlkviHCLCXVhXA5NT9XtO3D?=
 =?iso-8859-1?Q?AUCgdIEpAcKVKbEsp5EHJsbZ5yGa7W2hd55qfwMSvaGF1moDQTKl3SBQZu?=
 =?iso-8859-1?Q?rD8NxBcrdZ0477Rf5lLO8tqch/pbJW8vpgmQdGHyc5X3NpsNUzUw07qYjw?=
 =?iso-8859-1?Q?vwcvxuhD1yF4bLuIY9gdJQSaA9vP6esGiLtTSWybqeaU+yEwZnRLJL/7aa?=
 =?iso-8859-1?Q?eGV4t+SAUiAv/T/g7L+SHntWEkEFXZhaBjd/t+yvu5UPm1VPypMThtYgJ0?=
 =?iso-8859-1?Q?RUO/Nt5JT0IkQRcl4ZjY3f1eiRGjA8O8YWqQ6wlsjzq33k8vZVq370jpqB?=
 =?iso-8859-1?Q?WmjVT0HseCslCj1DffuvvXuZl8FH3Zh5PFxU1m2Lhwy20GhqrRmRGabSgf?=
 =?iso-8859-1?Q?PHcmqdFmOJbEAcp5hb4ARqOUmdwZ/ZhWyiDYN/Su80WAi6faQwCzQ9kMgY?=
 =?iso-8859-1?Q?r/4unxU5/u5m4lGICDc8hRPDu9CPXJkA51gSPuH1Z2QtyTbFkUJptKcVGH?=
 =?iso-8859-1?Q?oE2xoTjxjX20PhdSUI+/g3jEgRAQYmymVyhNeAtp+FIN/sZDjO70YDQFA0?=
 =?iso-8859-1?Q?O3qTpWMJUyDM/AaTOPXvgWy5lzDtxeGoqF4PBJB4zXQre8he073l41r8It?=
 =?iso-8859-1?Q?AupGDE7S0+Y1ZJhW5KoE9Vktx81dSQ0xKQNJSw6itnqu6CkY+/uLj/xtVO?=
 =?iso-8859-1?Q?gGmnfH3j+IIqtH60KWxt6+7Fxx8mPTaEokyU5vlVJBg7UzC5y0BJktXSQZ?=
 =?iso-8859-1?Q?Jn3dr54IL1qqjTvmR8zWybJJuWcicSjv1INb4fh5hBM5OEDv2AAwSelidc?=
 =?iso-8859-1?Q?dx3j8mRRIrO7p/uFxdL+IrV7kdMwQHejWPMJ4R7+LSVac7gHvNJoCKUlp3?=
 =?iso-8859-1?Q?F8SkrVOqfKl5efTM7CvOJZLYeI+2JX7VjkqlexXpNYC1GYG9FELumX0b7b?=
 =?iso-8859-1?Q?bBGZLeDvVg3KtdGKMs4Nk17O8H4hZHv3Lm9pqSeWlP72fBfCEpn0wPpnvi?=
 =?iso-8859-1?Q?o9w+IM9MBsu3mjj/k6QacmE3tnKtacOPIL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1073a9-cb4f-4b70-a809-08ddc06bfb07
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 11:13:36.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4DJO8+rgSiLkl31/6ZJmyEa5x2RN/I7raL//iiAGkgmjLcXa2wkAQ/a/qRbAffPLp6zVDIfD2ALncbqb53jvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2912

Hello Michael,=0A=
=0A=
Sorry for the delayed response.=0A=
=0A=
I dont think roman patch handles the channel settings and other ip checks (=
ex.=0A=
__connman_tethering_set_enabled_with_ip=A0 function impl)=0A=
=0A=
Let me know your thoughts on our implementation.=0A=
=0A=
Please find the corrected patch.=0A=
=0A=
From 84d64870ddecede4fe687eb1cafcbb4fac87a990 Mon Sep 17 00:00:00 2001=0A=
From: "jisoo.cha" <jisoo.cha@lge.com>=0A=
Date: Mon, 21 Apr 2025 18:16:09 +0900=0A=
Subject: [PATCH] Introduce softap with ip feature to connman=0A=
=0A=
By default, ConnMan supports tethering with a passphrase.=0A=
However, it does not support configuring tethering with a=0A=
specific IP address and channel.For certain applications=0A=
it is essential to set a specific IP address for the SoftAP.=0A=
To enable support for specifying the IP address=0A=
and channel, new properties TetheringIPAddress and=0A=
TetheringChannel should be added.=0A=
---=0A=
=A0src/connman.h =A0 =A0| =A013 +++++=0A=
=A0src/technology.c | 109 +++++++++++++++++++++++++++++++++++++-=0A=
=A0src/tethering.c =A0| 135 +++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
=A03 files changed, 256 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/src/connman.h b/src/connman.h=0A=
index 7ebda7a..85f221e 100644=0A=
--- a/src/connman.h=0A=
+++ b/src/connman.h=0A=
@@ -677,9 +677,22 @@ bool __connman_config_address_provisioned(const char *=
address,=0A=
=A0=0A=
=A0#include <connman/tethering.h>=0A=
=A0=0A=
+struct connman_station_info {=0A=
+ =A0 bool is_connected;=0A=
+ =A0 char *path;=0A=
+ =A0 char *type;=0A=
+ =A0 char ip[64];=0A=
+ =A0 char mac[32];=0A=
+ =A0 char hostname[64];=0A=
+};=0A=
+=0A=
=A0int __connman_tethering_init(void);=0A=
=A0void __connman_tethering_cleanup(void);=0A=
=A0=0A=
+GHashTable *__connman_tethering_get_sta_hash();=0A=
+=0A=
+void __connman_tethering_list_clients(DBusMessageIter *array);=0A=
+int __connman_tethering_set_enabled_with_ip(const char *ip);=0A=
=A0const char *__connman_tethering_get_bridge(void);=0A=
=A0int __connman_tethering_set_enabled(void);=0A=
=A0void __connman_tethering_set_disabled(void);=0A=
diff --git a/src/technology.c b/src/technology.c=0A=
index 270d83d..51f3cf0 100644=0A=
--- a/src/technology.c=0A=
+++ b/src/technology.c=0A=
@@ -69,6 +69,8 @@ struct connman_technology {=0A=
=A0 =A0 char *tethering_ident;=0A=
=A0 =A0 char *tethering_passphrase;=0A=
=A0 =A0 int tethering_freq;=0A=
+ =A0 char *tethering_ipaddress;=0A=
+ =A0 unsigned int tethering_channel;=0A=
=A0=0A=
=A0 =A0 bool enable_persistent; /* Save the tech state */=0A=
=A0=0A=
@@ -195,6 +197,16 @@ static void technology_save(struct connman_technology =
*technology)=0A=
=A0 =A0 =A0 =A0 g_free(enc);=0A=
=A0 =A0 }=0A=
=A0=0A=
+ =A0 if (technology->tethering_channel)=0A=
+ =A0 =A0 =A0 g_key_file_set_integer(keyfile, identifier,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Tethering.Channel",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 technology->tethering_channel);=0A=
+=0A=
+ =A0 if (technology->tethering_ipaddress)=0A=
+ =A0 =A0 =A0 g_key_file_set_string(keyfile, identifier,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Tethering.IP",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 technology->tethering_ipaddress);=0A=
+=0A=
=A0 =A0 if (technology->tethering_freq =3D=3D 0)=0A=
=A0 =A0 =A0 =A0 technology->tethering_freq =3D 2412;=0A=
=A0=0A=
@@ -225,14 +237,21 @@ int connman_technology_tethering_notify(struct connma=
n_technology *technology,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool enabled)=0A=
=A0{=0A=
=A0 =A0 int err;=0A=
+ =A0 const char *ip;=0A=
=A0=0A=
=A0 =A0 DBG("technology %p enabled %u", technology, enabled);=0A=
=A0=0A=
=A0 =A0 if (technology->tethering =3D=3D enabled)=0A=
=A0 =A0 =A0 =A0 return -EALREADY;=0A=
=A0=0A=
+ =A0 ip =3D technology->tethering_ipaddress;=0A=
+=0A=
=A0 =A0 if (enabled) {=0A=
- =A0 =A0 =A0 err =3D __connman_tethering_set_enabled();=0A=
+ =A0 =A0 =A0 if (!ip || strlen(ip) =3D=3D 0)=0A=
+ =A0 =A0 =A0 =A0 =A0 err =3D __connman_tethering_set_enabled();=0A=
+ =A0 =A0 =A0 else=0A=
+ =A0 =A0 =A0 =A0 =A0 err =3D __connman_tethering_set_enabled_with_ip(ip);=
=0A=
+=0A=
=A0 =A0 =A0 =A0 if (err < 0)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 return err;=0A=
=A0 =A0 } else=0A=
@@ -417,6 +436,17 @@ bool connman_technology_get_wifi_tethering(const struc=
t connman_technology *tech=0A=
=A0 =A0 return true;=0A=
=A0}=0A=
=A0=0A=
+unsigned int connman_technology_get_wifi_tethering_channel(void)=0A=
+{=0A=
+ =A0 =A0 =A0 struct connman_technology *technology;=0A=
+=0A=
+ =A0 =A0 =A0 technology =3D technology_find(CONNMAN_SERVICE_TYPE_WIFI);=0A=
+ =A0 =A0 =A0 if (!technology)=0A=
+ =A0 =A0 =A0 =A0 =A0 return 0;=0A=
+=0A=
+ =A0 =A0 =A0 return technology->tethering_channel;=0A=
+}=0A=
+=0A=
=A0static void free_rfkill(gpointer data)=0A=
=A0{=0A=
=A0 =A0 struct connman_rfkill *rfkill =3D data;=0A=
@@ -479,6 +509,12 @@ static void technology_load(struct connman_technology =
*technology)=0A=
=A0=0A=
=A0 =A0 enc =3D g_key_file_get_string(keyfile,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 identifier, "Tethering.Passphrase", NULL);=
=0A=
+=0A=
+ =A0 technology->tethering_channel =3D g_key_file_get_integer(keyfile,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 identifier, "Tethering.Channel", NULL);=0A=
+=0A=
+ =A0 technology->tethering_ipaddress =3D g_key_file_get_string(keyfile,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 identifier, "Tethering.IP", NULL);=0A=
=A0 =A0 if (enc) {=0A=
=A0 =A0 =A0 =A0 technology->tethering_passphrase =3D g_strcompress(enc);=0A=
=A0 =A0 =A0 =A0 g_free(enc);=0A=
@@ -597,6 +633,15 @@ static void append_properties(DBusMessageIter *iter,=
=0A=
=A0 =A0 =A0 =A0 connman_dbus_dict_append_basic(&dict, "TetheringPassphrase"=
,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_passphrase);=
=0A=
+ =A0 if (technology->tethering_ipaddress)=0A=
+ =A0 =A0 =A0 connman_dbus_dict_append_basic(&dict, "TetheringIPAddress",=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_ipaddress);=0A=
+=0A=
+ =A0 if (technology->tethering_channel)=0A=
+ =A0 =A0 =A0 connman_dbus_dict_append_basic(&dict, "TetheringChannel",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_UINT32,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_channel);=0A=
=A0=0A=
=A0 =A0 connman_dbus_dict_append_basic(&dict, "TetheringFreq",=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_INT32,=0A=
@@ -1016,6 +1061,54 @@ static DBusMessage *set_property(DBusConnection *con=
n,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_passphrase);=
=0A=
=A0 =A0 =A0 =A0 }=0A=
+ =A0 } else if (g_str_equal(name, "TetheringChannel")) {=0A=
+ =A0 =A0 =A0 dbus_uint32_t channel;=0A=
+=0A=
+ =A0 =A0 =A0 if (type !=3D DBUS_TYPE_UINT32)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&value, &channel);=0A=
+=0A=
+ =A0 =A0 =A0 if (technology->type !=3D CONNMAN_SERVICE_TYPE_WIFI)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_not_supported(msg);=0A=
+=0A=
+ =A0 =A0 =A0 if (channel =3D=3D 0 || channel > 13)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 =A0 =A0 if (technology->tethering_channel !=3D channel) {=0A=
+ =A0 =A0 =A0 =A0 =A0 technology->tethering_channel =3D channel;=0A=
+ =A0 =A0 =A0 =A0 =A0 technology_save(technology);=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 connman_dbus_property_changed_basic(technology->path,=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "TetheringChannel",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_UINT32,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_channel);=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 } else if (g_str_equal(name, "TetheringIPAddress")) {=0A=
+ =A0 =A0 =A0 const char *str =3D NULL;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&value, &str);=0A=
+=0A=
+ =A0 =A0 =A0 if (technology->type !=3D CONNMAN_SERVICE_TYPE_WIFI)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_not_supported(msg);=0A=
+=0A=
+ =A0 =A0 =A0 if (!str || strlen(str) =3D=3D 0) {=0A=
+ =A0 =A0 =A0 =A0 =A0 g_free(technology->tethering_ipaddress);=0A=
+ =A0 =A0 =A0 =A0 =A0 technology->tethering_ipaddress =3D NULL;=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 =A0 =A0 if (g_strcmp0(technology->tethering_ipaddress, str) !=3D 0) {=
=0A=
+ =A0 =A0 =A0 =A0 =A0 g_free(technology->tethering_ipaddress);=0A=
+ =A0 =A0 =A0 =A0 =A0 technology->tethering_ipaddress =3D g_strdup(str);=0A=
+ =A0 =A0 =A0 =A0 =A0 technology_save(technology);=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 connman_dbus_property_changed_basic(technology->path,=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "TetheringIPAddress",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_ipaddress);=0A=
+ =A0 =A0 =A0 }=0A=
=A0 =A0 } else if (g_str_equal(name, "TetheringFreq")) {=0A=
=A0 =A0 =A0 =A0 dbus_int32_t freq;=0A=
=A0=0A=
@@ -1257,6 +1350,7 @@ static void technology_put(struct connman_technology =
*technology)=0A=
=A0 =A0 g_free(technology->regdom);=0A=
=A0 =A0 g_free(technology->tethering_ident);=0A=
=A0 =A0 g_free(technology->tethering_passphrase);=0A=
+ =A0 g_free(technology->tethering_ipaddress);=0A=
=A0 =A0 g_free(technology);=0A=
=A0}=0A=
=A0=0A=
@@ -1935,3 +2029,16 @@ void __connman_technology_cleanup(void)=0A=
=A0=0A=
=A0 =A0 g_free(global_regdom);=0A=
=A0}=0A=
+=0A=
+void __connman_technology_sta_count_changed(enum connman_service_type type=
, int stacount)=0A=
+{=0A=
+ =A0 struct connman_technology *technology;=0A=
+=0A=
+ =A0 technology =3D technology_find(type);=0A=
+ =A0 if (technology =3D=3D NULL)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 connman_dbus_property_changed_basic(technology->path,=0A=
+ =A0 =A0 =A0 =A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE, "StaCount",=0A=
+ =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_INT32, &stacount);=0A=
+}=0A=
\ No newline at end of file=0A=
diff --git a/src/tethering.c b/src/tethering.c=0A=
index f930a26..2e1e6a4 100644=0A=
--- a/src/tethering.c=0A=
+++ b/src/tethering.c=0A=
@@ -49,6 +49,7 @@=0A=
=A0#endif=0A=
=A0=0A=
=A0#define BRIDGE_NAME "tether"=0A=
+#define SUBNET_MASK_24 "255.255.255.0"=0A=
=A0=0A=
=A0#define DEFAULT_MTU =A0 =A01500=0A=
=A0=0A=
@@ -363,6 +364,140 @@ void __connman_tethering_list_clients(DBusMessageIter=
 *array)=0A=
=A0 =A0 g_hash_table_foreach(clients_table, append_client, array);=0A=
=A0}=0A=
=A0=0A=
+static char *get_ip(uint32_t ip)=0A=
+{=0A=
+ =A0 struct in_addr addr;=0A=
+=0A=
+ =A0 addr.s_addr =3D htonl(ip);=0A=
+=0A=
+ =A0 return g_strdup(inet_ntoa(addr));=0A=
+}=0A=
+=0A=
+int __connman_tethering_set_enabled_with_ip(const char *ip)=0A=
+{=0A=
+ =A0 int index;=0A=
+ =A0 int err;=0A=
+ =A0 const char *gateway;=0A=
+ =A0 const char *broadcast;=0A=
+ =A0 const char *subnet_mask;=0A=
+ =A0 const char *start_ip;=0A=
+ =A0 const char *end_ip;=0A=
+ =A0 const char *dns;=0A=
+ =A0 unsigned char prefixlen;=0A=
+ =A0 char **ns;=0A=
+=0A=
+ =A0 DBG("enabled %d", tethering_enabled + 1);=0A=
+=0A=
+ =A0 if (__sync_fetch_and_add(&tethering_enabled, 1) !=3D 0)=0A=
+ =A0 =A0 =A0 return 0;=0A=
+=0A=
+ =A0 err =3D __connman_bridge_create(BRIDGE_NAME);=0A=
+ =A0 if (err < 0) {=0A=
+ =A0 =A0 =A0 __sync_fetch_and_sub(&tethering_enabled, 1);=0A=
+ =A0 =A0 =A0 return 0;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 index =3D connman_inet_ifindex(BRIDGE_NAME);=0A=
+=0A=
+ =A0 __connman_ippool_newaddr(index, ip, 24);=0A=
+=0A=
+ =A0 struct in_addr inp;=0A=
+ =A0 uint32_t start, mask;=0A=
+=0A=
+ =A0 if (inet_aton(ip, &inp) =3D=3D 0)=0A=
+ =A0 =A0 =A0 return 0;=0A=
+=0A=
+ =A0 start =3D ntohl(inp.s_addr);=0A=
+ =A0 mask =3D ~(0xffffffff >> 24);=0A=
+=0A=
+ =A0 start =3D start & mask;=0A=
+=0A=
+ =A0 gateway =3D ip;=0A=
+ =A0 broadcast =3D get_ip(start + 255);=0A=
+ =A0 subnet_mask =3D SUBNET_MASK_24;=0A=
+ =A0 start_ip =3D get_ip(start + 2);=0A=
+ =A0 end_ip =3D get_ip(start + 254);=0A=
+=0A=
+ =A0 err =3D __connman_bridge_enable(BRIDGE_NAME, gateway,=0A=
+ =A0 =A0 =A0 =A0 =A0 connman_ipaddress_calc_netmask_len(subnet_mask),=0A=
+ =A0 =A0 =A0 =A0 =A0 broadcast);=0A=
+ =A0 if (err < 0 && err !=3D -EALREADY) {=0A=
+ =A0 =A0 =A0 =A0__connman_ippool_free(dhcp_ippool);=0A=
+ =A0 =A0 =A0 =A0__connman_ippool_deladdr(index, ip, 24);=0A=
+ =A0 =A0 =A0 =A0__connman_bridge_remove(BRIDGE_NAME);=0A=
+ =A0 =A0 =A0 =A0__sync_fetch_and_sub(&tethering_enabled, 1);=0A=
+ =A0 =A0 =A0 err =3D -EADDRNOTAVAIL;=0A=
+ =A0 =A0 =A0 goto clean;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 ns =3D connman_setting_get_string_list("FallbackNameservers");=0A=
+ =A0 if (ns) {=0A=
+ =A0 =A0 =A0 if (ns[0]) {=0A=
+ =A0 =A0 =A0 =A0 =A0 g_free(private_network_primary_dns);=0A=
+ =A0 =A0 =A0 =A0 =A0 private_network_primary_dns =3D g_strdup(ns[0]);=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 =A0 =A0 if (ns[1]) {=0A=
+ =A0 =A0 =A0 =A0 =A0 g_free(private_network_secondary_dns);=0A=
+ =A0 =A0 =A0 =A0 =A0 private_network_secondary_dns =3D g_strdup(ns[1]);=0A=
+ =A0 =A0 =A0 }=0A=
+=0A=
+ =A0 =A0 =A0 DBG("Fallback ns primary %s secondary %s",=0A=
+ =A0 =A0 =A0 private_network_primary_dns,=0A=
+ =A0 =A0 =A0 private_network_secondary_dns);=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dns =3D gateway;=0A=
+ =A0 if (__connman_dnsproxy_add_listener(index) < 0) {=0A=
+ =A0 =A0 =A0 connman_error("Can't add listener %s to DNS proxy",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BRIDGE_NAME);=
=0A=
+ =A0 =A0 =A0 dns =3D private_network_primary_dns;=0A=
+ =A0 =A0 =A0 DBG("Serving %s nameserver to clients", dns);=0A=
+ =A0 }=0A=
+=0A=
+ =A0 tethering_dhcp_server =3D dhcp_server_start(BRIDGE_NAME,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gateway, subnet_mask,=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start_ip, end_ip,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24 * 3600, dns);=0A=
+ =A0 if (!tethering_dhcp_server) {=0A=
+ =A0 =A0 =A0 __connman_bridge_disable(BRIDGE_NAME);=0A=
+ =A0 =A0 =A0 __connman_ippool_free(dhcp_ippool);=0A=
+ =A0 =A0 =A0 __connman_ippool_deladdr(index, ip, 24);=0A=
+ =A0 =A0 =A0 __connman_bridge_remove(BRIDGE_NAME);=0A=
+ =A0 =A0 =A0 __sync_fetch_and_sub(&tethering_enabled, 1);=0A=
+ =A0 =A0 =A0 err =3D -EOPNOTSUPP;=0A=
+ =A0 =A0 =A0 goto clean;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 prefixlen =3D connman_ipaddress_calc_netmask_len(subnet_mask);=0A=
+ =A0 err =3D __connman_nat_enable(BRIDGE_NAME, start_ip, prefixlen);=0A=
+ =A0 if (err < 0) {=0A=
+ =A0 =A0 =A0 connman_error("Cannot enable NAT %d/%s", err, strerror(-err))=
;=0A=
+ =A0 =A0 =A0 dhcp_server_stop(tethering_dhcp_server);=0A=
+ =A0 =A0 =A0 __connman_bridge_disable(BRIDGE_NAME);=0A=
+ =A0 =A0 =A0 __connman_ippool_free(dhcp_ippool);=0A=
+ =A0 =A0 =A0 __connman_ippool_deladdr(index, ip, 24);=0A=
+ =A0 =A0 =A0 __connman_bridge_remove(BRIDGE_NAME);=0A=
+ =A0 =A0 =A0 __sync_fetch_and_sub(&tethering_enabled, 1);=0A=
+ =A0 =A0 =A0 err =3D -EOPNOTSUPP;=0A=
+ =A0 =A0 =A0 goto clean;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 err =3D __connman_ipv6pd_setup(BRIDGE_NAME);=0A=
+ =A0 if (err < 0 && err !=3D -EINPROGRESS)=0A=
+ =A0 =A0 =A0 =A0 =A0 DBG("Cannot setup IPv6 prefix delegation %d/%s", err,=
=0A=
+ =A0 =A0 =A0 =A0 =A0 strerror(-err));=0A=
+clean:=0A=
+ =A0 g_free(broadcast);=0A=
+ =A0 g_free(start_ip);=0A=
+ =A0 g_free(end_ip);=0A=
+ =A0 if ((err =3D=3D -EOPNOTSUPP) || (err =3D=3D -EADDRNOTAVAIL)){=0A=
+ =A0 =A0 =A0 return err;=0A=
+ =A0 } else {=0A=
+ =A0 =A0 =A0 DBG("tethering started");=0A=
+ =A0 =A0 =A0 return 0;=0A=
+ =A0 }=0A=
+}=0A=
+=0A=
=A0static void setup_tun_interface(unsigned int flags, unsigned change,=0A=
=A0 =A0 =A0 =A0 void *data)=0A=
=A0{=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
