Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9886175BF
	for <connman@lists.linux.dev>; Mon,  2 Jun 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846984; cv=fail; b=FMUS/PBeW7V2JiABRKVYEs95aINYbTF+73PI9Z5KAvx2T6i8N6Scdupr7OEwDssx78JpUytI0b4uzlANomCT+jHEqtZSHbWYT8N1VwriUZKKiWMcvIuUCsb8NWuNwczrQTWEpjcZ9JF5m3gt7m4fHXh+GJ53g06fDMips1x8XaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846984; c=relaxed/simple;
	bh=YSnI09+CFjwNxfL7T8aGl/T4kHI3as2UN/1tqtC/KMY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IP3TWxkg7bRjzGQALxmZg+0MuNuvHfbYGA7EICeCvukDxlixj4ht3uqOjz+BZJpD0UjGm+5/u/X5YGb2uqHaJaNdR4EZClNPpQ9SFvO6vb89JaYkh24e69cJaoK0kNi3JtIRqyXZpaAhQj2MQUywBf+5RLh4ixmye0qSibcZKBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.51 with ESMTP; 2 Jun 2025 15:49:38 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo6.lge.com) (165.244.66.187)
	by 156.147.1.126 with ESMTP; 2 Jun 2025 15:49:38 +0900
X-Original-SENDERIP: 165.244.66.187
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO SEVP216CU002.outbound.protection.outlook.com) (40.93.138.53)
	by 165.244.66.187 with ESMTP; 2 Jun 2025 15:51:31 +0900
X-Original-SENDERIP: 40.93.138.53
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVwht2PgEKYWO4pDKwnZSVPYGhJiTWASvy1yzoJ+cEXWwmqAIhQ/6aOcIvm8yrFQj1yJ6F0VHgyuFGJZZLaUPWEKHotirgGgbaErJO4hIlYY8V8MOQI8iusyGK7D+tjD3ouTu6qAWUUr/y/gStN4FgFU/DkfYr+93tzmN5HsPdkspqjqwvHrPJbxEqzrZMdzuoOVfq/Fo8swN6RT+aFkQ4U8AVy+dn0bvxR0TUvdQT3XgL6TZjgxyeJ8UdqHNlhKBnbEB8Zw1Kh7ESNmd9lXsnNLJtxql548P5WGHaiGrmA6FTuVQGDpyrTcLNNJsWliKnTI98NONkC++PFsnBwyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSnI09+CFjwNxfL7T8aGl/T4kHI3as2UN/1tqtC/KMY=;
 b=PpYqhUCYqTreHX6P9Mam6tc74dZwCFRnLqkSzw4sRA6ZuTCFS7Tg86q+3mZrPHVUid3dluD1EbXShoOOJFUhhastJn7YrR1phw/kWFGWKndil1h41lehO//bNRXNzgCGJLQgbevkFzwuZzUtEMokxmqp2T5a+MxC5FOb0UiI2HkwDfEP261N8koOG6AIfa2sywir5wyeq4H5wiHPN5neo07TXvnzg18anlOeMAH1RjHDkHnR6ZtYRdIujl7M5Y8GTad2ybya6Y3E9/wWy6nHZCwkjDl53CejzP1Q79Ij33Vs0aUBiS1/ZbXLm30FQvOGpHYhi61Qowe9+4/tcJnnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by SE2P216MB2279.KORP216.PROD.OUTLOOK.COM (2603:1096:101:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 06:49:36 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%5]) with mapi id 15.20.8792.033; Mon, 2 Jun 2025
 06:49:36 +0000
From: Shailesh Rathod/LGSI GPOS Dev <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject: [PATCH] connman : Add null check in prepare_target to avoid SIG=6
Thread-Topic: [PATCH] connman : Add null check in prepare_target to avoid
 SIG=6
Thread-Index: AQHb04owuqU2nEEUbkOsqTk298ZMFw==
Date: Mon, 2 Jun 2025 06:49:36 +0000
Message-ID:
 <SE1P216MB264701D18124CD7147BCAF1AF062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|SE2P216MB2279:EE_
x-ms-office365-filtering-correlation-id: 97f3b23c-7950-42dc-bf38-08dda1a1a3c2
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UeMquNbqYNiChXqsd42/5f2dp6F4DfLjcUE/ZsTYF45rrgwAJh0Lhxw/eK?=
 =?iso-8859-1?Q?TKiJfV/cVr3Atu4jiNoGXzozSd4rzarU7LXJ5kfHgD10MFM4nVuf3cWzad?=
 =?iso-8859-1?Q?zIaLbElrLop4ESYU4Ei41RmnK8MJ0XpGUqiPoIIvGKeytos+9l6xRl6EJf?=
 =?iso-8859-1?Q?wFbtXFaAFkvzKddfKlWa3WcK6uLNAWIRALgqYZSoCwhs8gKg150yo2lSJB?=
 =?iso-8859-1?Q?PVK4Bv7ma80502aUD+Ba+JNEuH3y3+tbuafpAB49LPWMPmhyD828KuqHE7?=
 =?iso-8859-1?Q?qxOJYDI6rlaDv0Ittxy6XK6a0rk/LZt/96An7vSE7GER0btnxcOSxu/+NL?=
 =?iso-8859-1?Q?hZ73WLr1TLZciIQT1kkrP0FvvQShJkcJlNeCmgAE327xfsUaBt+bh53hPb?=
 =?iso-8859-1?Q?Htkr4bJIgIFi0thnP13BfIRElSHusj4/fz8yf/VRfP7z1Aw3bd0RTDfYtf?=
 =?iso-8859-1?Q?WF0CpaF/QVOALkukIRxOj5cPP7PV5NOdcvq5cTMAm1EnbgCXQE6rrSVrKK?=
 =?iso-8859-1?Q?qByKe+XI/JzNCbzFxBmM+ZPTQNuQXYL1di3vOFAGE0pok1m0FnEcAogBhT?=
 =?iso-8859-1?Q?q604KvMo+877k2WTbg/H+lH/Hgj9PKDBGhDQCh6VJLbmHl4nc0nd36uULi?=
 =?iso-8859-1?Q?mYqa9F2p4zZ2tADJTBdemizoQ0S8DKHyoT9neJf9Rh2YVrcLqc/emng06x?=
 =?iso-8859-1?Q?bDeMtet6fFaQTr5gPugc+10SVOwkaA8Kmz0yNWw7ELYWfxnl0Z/hG3zcWv?=
 =?iso-8859-1?Q?pzsu861uWgrsbDIo47Njr8cfuMwAtdU/AM+MKxSHwEF/vQaLMAkVpc7A4W?=
 =?iso-8859-1?Q?LGWy2HqJ5fz2wc2giT1Yz1nkRO1Fa7m8p1j70KBS4JwKL7sdFwambmONVo?=
 =?iso-8859-1?Q?EJ5PgorKjbcY/n9WS0aYBcZguI2IjXUppQcIZO4Zes1sT9E0yW6FoISHnr?=
 =?iso-8859-1?Q?ZbLv3n5ZpcbE7dJZwglt69bIUBIdKsCqUX+S1Bk54Xy3Cub74jjpBSp1z0?=
 =?iso-8859-1?Q?kH43pCk1YHSrXfqydqioCk2jmAQ1+oQp3lngpT2Z+nApL0db4HLN63RQ9z?=
 =?iso-8859-1?Q?DSF9PrYmPeJ9I3Wv5P89rpI2SpPHLTFqybDNvITXkLopxDwOX7NR2V9cTq?=
 =?iso-8859-1?Q?TcAwk8IyQO2/ghiV4meoJKRC9lGDMP4+FjGS6+JZSehccQ3mdYRPLL9jss?=
 =?iso-8859-1?Q?ruc8Qr50ko5ludVbKW5z95baIZc1eYDX97NMPqIEGpIYHnE/9eAPa2vxRm?=
 =?iso-8859-1?Q?RqfhWlzezjgSNnYSf/Hk/WJbB/vl2bKcIvG0aYodBlfy9VE3KNe2Y4F6aF?=
 =?iso-8859-1?Q?HT92BP2lx2seYZofEGT0U0AVnWiC58eBYqlYoSob1dt3hX7SoIlzpVv+91?=
 =?iso-8859-1?Q?uU6PgV5QoESKXWMmfVXH4sKxMMLDyUKXxmzQ1hH3Tn2nn1EY8BAQMLABzY?=
 =?iso-8859-1?Q?NYwRz/2AWNaiz0coDkDvFujtjXRN1bENGmo9PHCpSN0nSDYiXIGplZ4rcs?=
 =?iso-8859-1?Q?AOCv1yG+rWERWcPAzIGLI0E31TxQ9g1gfFCKo8VVaXsA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hVZYaWVBAgA8VlKx6IlebCFy05IR4p/L8GYQHTFarHkh/wyeNdqsTYNhUh?=
 =?iso-8859-1?Q?2thcu36B7bjBCHbtJllMvhy9aeVGSxCzByGRh18k7FjscgTYgDxJ3WEow+?=
 =?iso-8859-1?Q?n1Rz1agmxPXpFne7xBsAjk/r8KmM0XJ0148ybdrQwydNgpWuWxQYHUwYKb?=
 =?iso-8859-1?Q?CyShOLNGiKxZwOl7XWFYIJL+7nmmzqUu630C8nRHKGf6EZHbmY73hOSfWB?=
 =?iso-8859-1?Q?LhegIMpXNjT13ofWTYkt/r0usoEHCIUfTFjytadwsaLwCrOLnQ/vLyv+Gx?=
 =?iso-8859-1?Q?aIH7xE56qlcEfRiqkVIXvt0KDLtSUxLd/t57lgRanN5tQypI2arLVMfqBh?=
 =?iso-8859-1?Q?SNdPqmWl/Y4Z2mCPVF9Zz3nC/wZgFLAHQujUnwux4QfcjdB+w14OcZGJKH?=
 =?iso-8859-1?Q?aBY1kTG6+nrlaGBTTzZ3DKteLWBH/rmufma4/+AcWgiAdHOILV2wf8ljmc?=
 =?iso-8859-1?Q?SRSCVTidHBTvKPEHri3PzQFLYR2/m2xOEM8ezQgdaDy7mSUVRC2LWYBE/l?=
 =?iso-8859-1?Q?EV83Ajj/USM/QEXfxU2gDt+MqQ35kDRZT6JLfj79lshCoGQKyMX9BLs4Mc?=
 =?iso-8859-1?Q?DhY4QSeDjAm4NOaX1oPuTRs6RWBwm3fUezIJwkzEX507kFhDRo/kJm99Gj?=
 =?iso-8859-1?Q?wtQY0fDj4FGIxZHncHmZBbqzoqzQSd/xNw2VCzr5gjdBDW7vhmh6FLb57F?=
 =?iso-8859-1?Q?HKuGjRcUPRxpEMsPKPrW0Sc75vNbrPr1o1LgpG7t/eBaeaB0j+/vn2I0us?=
 =?iso-8859-1?Q?3Ridn+x3WqN8k71P5YGlXV4DY3S1Wp2XeBvhQtfcLz9iw7V5+qk1aH0tu8?=
 =?iso-8859-1?Q?qdcD6cQExavUye1W3wfSkkkYL1ncgei9776UfHIJ94SGgcdatD4KZRvNmi?=
 =?iso-8859-1?Q?epv42f9jX91vhc+PFanI09rXq4cjOH1oj0trd5280jJcKC1UUncwBE0QUg?=
 =?iso-8859-1?Q?SRTNVQ6ZYtZ9MI9QVzZ6kToQe6gsZHKwpBiCukN9J9iMTuwz3HdRhG2xkv?=
 =?iso-8859-1?Q?mYBbWvVdLZFdeA5K/GxKvX4qpTtlw10XxUHDDltThQElE65+typk3ZKODD?=
 =?iso-8859-1?Q?NchuEaaofmM+IUsZFp6uuf0XVGu4TrOso1+K6aQqAc2qPZKsPQLrzVsZHs?=
 =?iso-8859-1?Q?xea7FrlHS2diUOUSK+qQPiOIr7NjnG4C5WmNLDIPJG7xbhBJSVOPx3IFVL?=
 =?iso-8859-1?Q?rBarYXkTqUTyOv7bO6BaoKaRfVbxxZ7SPwFIpSzr7MuZ0Qmo0qARwNrWDF?=
 =?iso-8859-1?Q?LPXuzGL0UYIHSA0/nxCN9fUVQ33pLT5X5kiUqyNuWtTJ3KUvW0siP6j6pe?=
 =?iso-8859-1?Q?r0G7Msj6Mb5uvRldMsfavTlRlLsiQ8PDDG7TbgBvvlHUPdWiEsEZvbkUh1?=
 =?iso-8859-1?Q?95RsTSH3oXcfosP/InyaBYqO00w2nNF+SziDUFBbbIlWMy+CWrYLiSDgIk?=
 =?iso-8859-1?Q?WwmkwdTAIR8Y7J4UGNz5TlX7HXrqEqxVevvauwiyn46CQmvvXEWM5+i8BT?=
 =?iso-8859-1?Q?bX+Me9hS1mYkMHo8hXj8qU37OoYwUQjlfJB1378lUDPgjemBVsSxLJ1SDh?=
 =?iso-8859-1?Q?ARqJ87+NbaL13fWzj6l3ytTtg/ycmwt3Mkqt5TrHttO0sqg3GvhHhvPb6x?=
 =?iso-8859-1?Q?G4+MK9iKwpkIU2M/D0VKUOmlE5e+bkl9Z7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f3b23c-7950-42dc-bf38-08dda1a1a3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 06:49:36.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dOiqUOH9olqBPoEq+vT5lRIUsGsTeUH6Il9DnIdNfC3kY86/cQYLxZ+Z1o/pIM3Xi6aueCBOlj7feyVu1SyCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2279

From: Shailesh Rathod <shailesh.rathod@lge.com>=0A=
Date: Wed, 23 Apr 2025 17:48:14 +0900=0A=
=0A=
Add null check in prepare_target to avoid SIG=3D6=0A=
=0A=
When Ethernet is connected and an attempt is made to enable the SoftAP,=0A=
a SIGSEGV (signal 6) is observed.To prevent this, add a null check to=0A=
avoid the segmentation fault.=0A=
=0A=
Signed-off-by: Shailesh Rathod<shailesh.rathod@lge.com>=0A=
---=0A=
=A0src/iptables.c | 11 ++++++-----=0A=
=A01 file changed, 6 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/src/iptables.c b/src/iptables.c=0A=
index a81a077..54e04d3 100644=0A=
--- a/src/iptables.c=0A=
+++ b/src/iptables.c=0A=
@@ -2746,20 +2746,21 @@ static struct xtables_target *prepare_target(struct=
 connman_iptables *table,=0A=
=0A=
=A0 =A0 switch (table->type) {=0A=
=A0 =A0 case AF_INET:=0A=
- =A0 =A0 =A0 if (xt_t->x6_options)=0A=
+ =A0 =A0 =A0 if (xt_t->x6_options && xt_t->option_offset){=0A=
=A0 =A0 =A0 =A0 =A0 =A0 iptables_globals.opts =3D=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xtables_options_xfrm(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iptables_globals.orig_opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iptables_globals.opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xt_t->x6_options,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &xt_t->option_offset);=0A=
- =A0 =A0 =A0 else=0A=
+ =A0 =A0 =A0 }else if(xt_t->extra_opts && xt_t->option_offset){=0A=
=A0 =A0 =A0 =A0 =A0 =A0 iptables_globals.opts =3D=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xtables_merge_options(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iptables_globals.orig_opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iptables_globals.opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xt_t->extra_opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &xt_t->option_offset);=0A=
+ =A0 =A0 =A0 }=0A=
=0A=
=A0 =A0 =A0 =A0 if (!iptables_globals.opts) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 g_free(xt_t->t);=0A=
@@ -2768,21 +2769,21 @@ static struct xtables_target *prepare_target(struct=
 connman_iptables *table,=0A=
=0A=
=A0 =A0 =A0 =A0 break;=0A=
=A0 =A0 case AF_INET6:=0A=
- =A0 =A0 =A0 if (xt_t->x6_options)=0A=
+ =A0 =A0 =A0 if (xt_t->x6_options && xt_t->option_offset){=0A=
=A0 =A0 =A0 =A0 =A0 =A0 ip6tables_globals.opts =3D=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xtables_options_xfrm(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip6tables_globals.orig_opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip6tables_globals.opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xt_t->x6_options,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &xt_t->option_offset);=0A=
- =A0 =A0 =A0 else=0A=
+ =A0 =A0 =A0 }else if(xt_t->extra_opts && xt_t->option_offset){=0A=
=A0 =A0 =A0 =A0 =A0 =A0 ip6tables_globals.opts =3D=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xtables_merge_options(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip6tables_globals.orig_opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip6tables_globals.opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xt_t->extra_opts,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &xt_t->option_offset);=0A=
-=0A=
+ =A0 =A0 =A0 }=0A=
=A0 =A0 =A0 =A0 if (!ip6tables_globals.opts) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 g_free(xt_t->t);=0A=
=A0 =A0 =A0 =A0 =A0 =A0 xt_t =3D NULL;=0A=
