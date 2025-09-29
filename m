Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69BA92E
	for <connman@lists.linux.dev>; Mon, 29 Sep 2025 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759120585; cv=fail; b=aM/b5uINVBM/Kdccei/LaE5auqmOdKWHgDEAzrJvBZ35pxP+ECxU7tRd1BDiQhi0M7rLG6LvNKJfAxzk3RKOxNGBau39EGUAao2w+OiuW1mJa+lgALQBGVAV7xc0E5e7C0SE2oJISSD/rxff9SVGVryG+ahRpS/rTx5d8blKU/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759120585; c=relaxed/simple;
	bh=Gmb5gBXi+rbM1EZJgn0bz9g1NkwO1sxJZEDHNYX1HJ4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JgITVrjDFKncsZUda6MwWUePJWxIZ1teByDweDBz4HoDXVMnqL3PllSZsqoqJzzM9nwlnHitGK7SPIJ8A5AMBIkkSdWSJTElb98IGAQwrQ5Y3dKbN+wDG2ErDRYMlYYFzEZ8oZdVqRHmHbMMNIYTRhnetaQA/k+m5Q9EPpzq0lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
	by 156.147.23.53 with ESMTP; 29 Sep 2025 13:06:14 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo4.lge.com) (165.244.66.184)
	by 156.147.1.151 with ESMTP; 29 Sep 2025 13:06:14 +0900
X-Original-SENDERIP: 165.244.66.184
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO SLXP216CU001.outbound.protection.outlook.com) (40.93.138.29)
	by 165.244.66.184 with ESMTP; 29 Sep 2025 13:10:16 +0900
X-Original-SENDERIP: 40.93.138.29
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XClS/tZ95QtC8f3CiBmws05IAfsnu5eJ5zuS1LomEOgiRtu5vSNLOI9/k+aiwhI+FYujywSlN6GSZETnP3l4jLdr2igZor/npY3IGWHhkfet3nFDt2d1Dhl+/lM5aTSWxu2ZhrwXZ+p37XvZL9Q8yxhkTjLd295ObyDOvYkUsw/UO0/1pN4ACWUt64tH0rRcRoLBhxTGlBVVNoP1hTsUd+q/L+1NcyIz07RQrKK/5GCMbVknkcGZrRe4WFXnlj2P+5Dbgoo4oEnFa/X4mROiiEEwnNQ740cgJxB3VNSgURx/CQxtvGROF9QuNYVgTVaGyV2m4zTphL2Dd/tgbdTIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmb5gBXi+rbM1EZJgn0bz9g1NkwO1sxJZEDHNYX1HJ4=;
 b=tpCd2jjksa1cq+vUnZFJTdMXtKwdxgRLlx+rcDTNe5KjVb+kq/hLg8muqVHgbxsxl/5NHhqgLkmk6ixOHcB7y1FqUKrFaQNuDjE/LnjodKEgh/I+k8I4QIdkqTSO+hy4IdxBqLE507fe1o3vYR1wb5ze3S+7kFR0Bkq0Kxv5OTzGz1eZJu8nb9gei4nO+Nw/IWGwjaaITYkuwwUtYhAt3BNyC+cBp/3Kc7dfLp2Safzee1PQ7xmVvU2cGTyzpYmITcB85FJ41KOKw5Vp2otPczJWo9Hj0pPx5PWY0XBWRhVPcJLSSy+0VTXXU99Ot72VP7z/qoCNGOoDVcrWCQCpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by PS2P216MB1203.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 04:06:12 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 04:06:12 +0000
From: Shailesh Rathod/LGSI Connectivity Team <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject:
 =?iso-8859-1?Q?[PATCH]Connman_:_Improve_P2P:_Update_p2p=5Flisten_state_,_?=
 =?iso-8859-1?Q?default_PBC_mode,_and_=A0peer_PBC_request_handling?=
Thread-Topic:
 =?iso-8859-1?Q?[PATCH]Connman_:_Improve_P2P:_Update_p2p=5Flisten_state_,_?=
 =?iso-8859-1?Q?default_PBC_mode,_and_=A0peer_PBC_request_handling?=
Thread-Index: AQHcMPU3tTL1lWNsKUej4V7xuJA6IA==
Date: Mon, 29 Sep 2025 04:06:12 +0000
Message-ID:
 <SE1P216MB2647BC9C66496129729E3E39F01BA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|PS2P216MB1203:EE_
x-ms-office365-filtering-correlation-id: e4a2f8a9-2a52-4a79-eba2-08ddff0d8728
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lsRyiMjLOcIkGSuKsMMLGugIJL/5I+lT3KwyBRoCx2z0fNSa08x99j0uxB?=
 =?iso-8859-1?Q?kee31L2Mg42H224rcZBH1cU1H7Bh989WxgwTmRRBCQy0IGuUB3ONmhxCtQ?=
 =?iso-8859-1?Q?e1cjmty6hqd/cQymGRX6ujFQyLdre/Wo1Ah6+/xky2gX5CvBuOkS/m6Ad4?=
 =?iso-8859-1?Q?3B5L1x+xyrqObzxPjgvZ2v4ufFN8LCYJEtymXQVU1JzjbMBnZ90o3hxDSf?=
 =?iso-8859-1?Q?VAwIZtcN9yZ9w9z7tm9mQeX/jQ1dCrgvEFAxVZeyt6sPkip0NOOkTUTioV?=
 =?iso-8859-1?Q?uIOxfD8vVh+g+yBRPQy4/SxE9vIZu6BuInAbjxco+H67/34Bs2WNj6jLBc?=
 =?iso-8859-1?Q?cF2vwM2i041VS/weSJJCOhM7Q7zVKNp7WUVFhXQds8mSHYfLdMt/GnfZBd?=
 =?iso-8859-1?Q?/DVzVqbo7klJd4u87vPfEU4lsbhvI0KnAZIlVvoE97J7M8rBYEIeNUtj9V?=
 =?iso-8859-1?Q?G0cBHbKZFP2Acbh0HiqFhmWiQDgPBYbm4JokiD4oQLPbr3OdJ9NpnaKh0B?=
 =?iso-8859-1?Q?1AsYqVQ4MHx++2to/Mnr9bFRkWkxaNL3oHAxU4mQV1NV6SEX1E37tihqpH?=
 =?iso-8859-1?Q?fGh+Lmhd6jMwTJgYH6DpkBDcVVOFzcJnwk1atTetVt2kkTHxtLj6z+IUJz?=
 =?iso-8859-1?Q?Oo7u2XSDY+45DybsxX5PGtHMg4Ycut297t6ChKD0Tl3Y4V2TfYMRCeo85c?=
 =?iso-8859-1?Q?7LZAdEDpI+Bh6ppooQ6Byy9I7OAXhum+VDTVBhX0Rw+o5qwFjU6mMhYzFe?=
 =?iso-8859-1?Q?RfSVaJSTffwOcSMxLIvd1ZUBrjr33k56p6AxJn08+RsQjtGA4jkxf1aHJu?=
 =?iso-8859-1?Q?IncYw6qebBwnk3Prdj3RXL95orE7d3n0oJ6nRwfflS9MAGe8KCZg/oS4eY?=
 =?iso-8859-1?Q?Im2r4Z+YlX/hklXUvT3m+YKSdYPjl5P+6r3Dn5eDg3Q5ful2V9ZjdncHKi?=
 =?iso-8859-1?Q?jsP5+W5NNGB4w9Gs9by9iEJiNOyjaaw0yW97A1oIxqUu+YX38vPl3oStNv?=
 =?iso-8859-1?Q?wQt4Gk5uX1aOTzRHbi9l2/5YupW5096UD06AtKhMXlBa7XHtbnHM5Lwpes?=
 =?iso-8859-1?Q?Fu2cush4VS3Kkrn5y37Kz8V7t44ZLBfJKPDMffkevITGfd82wwXTtDW8OS?=
 =?iso-8859-1?Q?Ufhx232vtotgu3viLY57fRPu19pUL4Ystaipvohi+rq8LC2sHphnDtTL+w?=
 =?iso-8859-1?Q?z9a6jtVkmP3qhzEBPmUkZFtwiO6tiBQeJbS8D1a36rfKGqpVzwLKr7dQsW?=
 =?iso-8859-1?Q?Auwc79ARpY+pBQfXwqOQBsr0dIQVRjJDeouu8O/kxRFDpWHhDG3H1QdsMv?=
 =?iso-8859-1?Q?nPt92i733PzFt5Gqd8L4z65DqnOFe52N/BxDByWqwMVSYGua9vYP9VvCfp?=
 =?iso-8859-1?Q?sdZUxrk7BBidv6t+RX8dxABAda8VnDzmPWsoCtjvY2sVtmaCBPsPIk/v5U?=
 =?iso-8859-1?Q?9Qd2PPATobZ7jt2bUTGxImxI9IFN5jjvLWUf74D31wb08PtJkVY8JKoP80?=
 =?iso-8859-1?Q?ZnsjEsa7F1pQMiSgEgF3psXn1Fq7xQ5zJkBDy4FLRieAjAVrbMnJQ6enI7?=
 =?iso-8859-1?Q?nZ6mhRosNQfnds2GeKDZY5Sp2uVE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?REMNuSV1EuSYoxYSvTTy66IkZuI1dsywVpLc7nstTvi8c+JzqPx2f/RaXg?=
 =?iso-8859-1?Q?G5Z7qPXfh2PR0SyjVToIqJCJ0+Q+7NlZSwxXeeSM6ivlr3SohzTSiw0hLk?=
 =?iso-8859-1?Q?bNB0XE+kukj1ulgWNz7ZLDC3bYOUixRltx86xRlgGc0a4kMggWuq5Cd/XX?=
 =?iso-8859-1?Q?Ws7DdhhDgrGhtJYHunaCtsr01A6g8DMF1UmQyI9g4wNRDPjrGntDNi1HgK?=
 =?iso-8859-1?Q?xR+WUErAGOYMxLSLKCJqpJ72o+7fOMKFcI0slo7rSXP/QTVthv0tZE7zeQ?=
 =?iso-8859-1?Q?DNNWPnJkRlMnPk3HNtidB7uJO3P0SmtkthYfkBEfJrkC8vys3hpFoPFZ1E?=
 =?iso-8859-1?Q?y6vntJqLYA/rqRj3+ZjkflLJ+lpaLCeleO1PsbuOMswX0AcvGkIqEhVC0I?=
 =?iso-8859-1?Q?QopgF5eO533riKAs5lPD3kO3KoeLrGPAmVZr6OyBgAhLBA+GYlFdcSbH59?=
 =?iso-8859-1?Q?Mdm88Lavmiq/1lmDSZyHbmrW8aB4nPG/Oh2j3MuQS2J2KYXB8KKEpx5FEm?=
 =?iso-8859-1?Q?EVNMcI5krJ/EAY29pSUOrCf4A7g7bno0lX+oxT0r2PO6JrkYqNavt96bTT?=
 =?iso-8859-1?Q?IHE7K166/6n8wgamPZAttYPGEm8JpReY7cTyHrVvrSZZSIRzRNusKZFdeK?=
 =?iso-8859-1?Q?kgYUbtRGK5RitTu87po8F/EV6hLQW7Jp6NnxBa/wd3fy4DDhR5x7XbhIBx?=
 =?iso-8859-1?Q?Mvc7AdoXIX7PvTtKMUyR6oYu8U+QCe0DbgERVl9rQLFvXewbuL17RNWURs?=
 =?iso-8859-1?Q?gedjJoFSZTDSV6XSyKfQm9hPQfxE7Lol1dmMndhpvd2hN28blNy9M+2Xbz?=
 =?iso-8859-1?Q?lNavQUEw+vcmuRd3QN6MSZFXy6o01oTdaOB20TXpl6f9WPfUnveO7j98pS?=
 =?iso-8859-1?Q?Yv0CCC4jzd5aVeecsqhpeKsEHP9OV10cGUuzoXwONfoFRh+1IlHH8E2OCp?=
 =?iso-8859-1?Q?Tl+CElH98YdCeSgzns8HP5EfUBJQnVHgk6bfIwN2fFdNB7JVML3n5pc9AB?=
 =?iso-8859-1?Q?yZAcEhjWJhHRGR7l330U5F2i2cB6Wt/MJQ03b2CuO9XKNiP880ybfRmMOH?=
 =?iso-8859-1?Q?68DYaf40SmMTvsaFi7GcXIfh8mPaY6sFnW0BRHOLsRedtYSmdfKilCg3/H?=
 =?iso-8859-1?Q?BfxToOkp4XSw0sYt6MxBDPW1ikDs4c9/cq0GrPFZCtHd2y4eVku+ZTACBD?=
 =?iso-8859-1?Q?lKcT5dkKrWnSXDxsB3f0oyx+L8bh6e5FRZnV9/lIvBcIqnJ481CxzUghTs?=
 =?iso-8859-1?Q?TPEYFqZeGcDRibo2RBFcze9TF0CChnGo9t6PsZFmsQaq7e9y+TwhKVtSo/?=
 =?iso-8859-1?Q?rA15P3p1vn7XDdDE/Vg3zUWQI2hi9VMKHxar5PUSRAPOR//mSafbndsjBx?=
 =?iso-8859-1?Q?bHu9qURx0oBCNslUKeuEu42+S3xbe9CYV46calsVRAQKgSZ+iyCe9sA1ET?=
 =?iso-8859-1?Q?pOI/l9cvf9zbUOxAj1aBIKf2QaDrshiigorXGk2zKuftN0kcjrJ2Frysgn?=
 =?iso-8859-1?Q?muMhaUKzAThIuKsZHDCilH0oHVTEVHboo32RJrqRAMhHinw2uEodJ+0q6V?=
 =?iso-8859-1?Q?LIe7k0xlTxCqNzETJk7pDTtmC0eD0pOH0JMFIl0PCkr27mo+nsgXpbop2o?=
 =?iso-8859-1?Q?6vkehOzb/5PV9dSYSQ6gDinsiReO7NLaum?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a2f8a9-2a52-4a79-eba2-08ddff0d8728
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 04:06:12.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnhbTyeizbAkpHqtignBURauiiWexf6WuN2r0ZCuJOS4SADaldbSd8tlt4lM8fKzMNbrWXAahmOhhxVqZNdR+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2P216MB1203

From 7734bd9ec42e77d0ce8184908f6b31075ab73f31 Mon Sep 17 00:00:00 2001=0A=
From: shailesh <shailesh.rathod@lge.com>=0A=
Date: Fri, 27 Jun 2025 04:49:26 +0000=0A=
Subject: [PATCH] Improve P2P: Update p2p_listen state , default PBC mode, a=
nd=0A=
=A0peer PBC request handling=0A=
=0A=
- Add support for `p2p_listen` state in `GetProperties` for better P2P stat=
e management.=0A=
- Default to WPS PBC mode if no PIN is provided during peer connection.=0A=
- Automatically process peer device PBC requests and initiate connection.=
=0A=
- Refactor listen state logic to allow dynamic enable/disable with timing p=
arameters.=0A=
- Update D-Bus policy to permit `net.connman.Peer` interface messages.=0A=
---=0A=
=A0gsupplicant/gsupplicant.h | =A037 +++=0A=
=A0gsupplicant/supplicant.c =A0| 558 ++++++++++++++++++++++++++++++++++++++=
=0A=
=A0include/technology.h =A0 =A0 =A0| =A0 9 +=0A=
=A0plugins/wifi.c =A0 =A0 =A0 =A0 =A0 =A0| 433 ++++++++++++++++++++++++++++=
-=0A=
=A0src/connman-dbus.conf =A0 =A0 | =A0 1 +=0A=
=A0src/peer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 5 +-=0A=
=A0src/technology.c =A0 =A0 =A0 =A0 =A0| 177 +++++++++++-=0A=
=A07 files changed, 1209 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/gsupplicant/gsupplicant.h b/gsupplicant/gsupplicant.h=0A=
index eecad9c..eaa9083 100644=0A=
--- a/gsupplicant/gsupplicant.h=0A=
+++ b/gsupplicant/gsupplicant.h=0A=
@@ -188,6 +188,7 @@ struct _GSupplicantPeerParams {=0A=
=A0 =A0 bool master;=0A=
=A0 =A0 char *wps_pin;=0A=
=A0 =A0 char *path;=0A=
+ =A0 bool persistent;=0A=
=A0};=0A=
=A0=0A=
=A0typedef struct _GSupplicantPeerParams GSupplicantPeerParams;=0A=
@@ -263,9 +264,11 @@ int g_supplicant_set_country(const char *alpha2,=0A=
=A0/* Interface API */=0A=
=A0struct _GSupplicantInterface;=0A=
=A0struct _GSupplicantPeer;=0A=
+struct _GSupplicantP2PInterface;=0A=
=A0=0A=
=A0typedef struct _GSupplicantInterface GSupplicantInterface;=0A=
=A0typedef struct _GSupplicantPeer GSupplicantPeer;=0A=
+typedef struct _GSupplicantP2PInterface GSupplicantP2PInterface;=0A=
=A0=0A=
=A0typedef void (*GSupplicantInterfaceCallback) (int result,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantInterface *interface,=0A=
@@ -389,11 +392,34 @@ struct _GSupplicantP2PExtendedListenParams {=0A=
=A0=0A=
=A0typedef struct _GSupplicantP2PExtendedListenParams GSupplicantP2PExtende=
dListenParams;=0A=
=A0=0A=
+struct _GSupplicantP2PDeviceConfigParams {=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+ =A0 char *device_name;=0A=
+ =A0 unsigned char pri_dev_type[8];=0A=
+ =A0 dbus_uint32_t go_intent;=0A=
+ =A0 int persistent_reconnect;=0A=
+ =A0 dbus_uint32_t listen_reg_class;=0A=
+ =A0 dbus_uint32_t listen_channel;=0A=
+ =A0 dbus_uint32_t oper_reg_class;=0A=
+ =A0 dbus_uint32_t oper_channel;=0A=
+ =A0 char *ssid_postfix;=0A=
+ =A0 int intra_bss;=0A=
+ =A0 dbus_uint32_t group_idle;=0A=
+ =A0 dbus_uint32_t disassoc_low_ack;=0A=
+ =A0 const void *user_data;=0A=
+};=0A=
+=0A=
+typedef struct _GSupplicantP2PDeviceConfigParams GSupplicantP2PDeviceConfi=
gParams;=0A=
=A0int g_supplicant_interface_p2p_extended_listen(GSupplicantInterface *int=
erface,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantP2PExtendedListenParams *ex=
tended_listen_data,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantInterfaceCallback callback,=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user_data);=0A=
=A0=0A=
+int g_supplicant_interface_get_p2p_device_config(GSupplicantInterface *int=
erface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantP2PDeviceConfigPar=
ams *p2p_device_config);=0A=
+int g_supplicant_interface_set_p2p_device_configs(GSupplicantInterface *in=
terface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantP2PDeviceConfigPar=
ams *p2p_device_config_data,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user_data);=0A=
=A0/* Network and Peer API */=0A=
=A0struct _GSupplicantNetwork;=0A=
=A0struct _GSupplicantGroup;=0A=
@@ -489,10 +515,21 @@ struct _GSupplicantCallbacks {=0A=
=A0 =A0 void (*p2p_group_finished)(GSupplicantInterface *interface);=0A=
=A0 =A0 void (*p2p_invitation_result)(GSupplicantInterface *interface, int =
status);=0A=
=A0 =A0 void (*p2p_invitation_received) (GSupplicantInterface *interface, G=
SupplicantPeer *p2p_network, const char *go_dev_addr, bool persistent);=0A=
+ =A0 void (*p2p_prov_disc_requested_pbc) (GSupplicantInterface *interface,=
 GSupplicantPeer *peer);=0A=
+ =A0 void (*p2p_prov_disc_requested_enter_pin) (GSupplicantInterface *inte=
rface, GSupplicantPeer *peer);=0A=
+ =A0 void (*p2p_prov_disc_requested_display_pin) (GSupplicantInterface *in=
terface, GSupplicantPeer *peer, const char *pin);=0A=
+ =A0 void (*p2p_prov_disc_response_enter_pin) (GSupplicantInterface *inter=
face, GSupplicantPeer *peer);=0A=
+ =A0 void (*p2p_prov_disc_response_display_pin) (GSupplicantInterface *int=
erface, GSupplicantPeer *peer, const char *pin);=0A=
+ =A0 void (*p2p_prov_disc_fail) (GSupplicantInterface *interface, GSupplic=
antPeer *peer, const char * status);=0A=
+ =A0 void (*p2p_device_config_loaded) (GSupplicantInterface *interface);=
=0A=
=A0};=0A=
=A0=0A=
=A0typedef struct _GSupplicantCallbacks GSupplicantCallbacks;=0A=
=A0=0A=
+typedef struct _GSupplicantP2PFindParams GSupplicantP2PFindParams;=0A=
+=0A=
+=0A=
+=0A=
=A0int g_supplicant_register(const GSupplicantCallbacks *callbacks);=0A=
=A0void g_supplicant_unregister(const GSupplicantCallbacks *callbacks);=0A=
=A0=0A=
diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c=0A=
index 6fd7384..494fef3 100644=0A=
--- a/gsupplicant/supplicant.c=0A=
+++ b/gsupplicant/supplicant.c=0A=
@@ -47,6 +47,13 @@=0A=
=A0#define MAX_P2P_SSID_LEN =A0 =A0 =A0 =A0 =A0 32=0A=
=A0#define BSS_UNKNOWN_STRENGTH =A0 =A0-90=0A=
=A0=0A=
+#define WPAS_P2P_WPS_PIN_LENGTH =A0 =A0 =A0 =A08=0A=
+#define MAX_P2P_SSID_LEN =A0 =A0 =A0 =A0 =A0 32=0A=
+=0A=
+=0A=
+typedef void (*g_supplicant_p2p_prov_dics_signal_func) (GSupplicantInterfa=
ce *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer* peer, void* params);=0A=
+=0A=
=A0static DBusConnection *connection;=0A=
=A0=0A=
=A0static const GSupplicantCallbacks *callbacks_pointer;=0A=
@@ -273,6 +280,11 @@ struct _GSupplicantGroup {=0A=
=A0 =A0 char * psk;=0A=
=A0};=0A=
=A0=0A=
+struct _GSupplicantP2PInterface {=0A=
+ =A0 char *path;=0A=
+ =A0 GSupplicantP2PDeviceConfigParams *p2p_device_config_param;=0A=
+};=0A=
+=0A=
=A0struct interface_data {=0A=
=A0 =A0 GSupplicantInterface *interface;=0A=
=A0 =A0 char *path; /* Interface path cannot be taken from interface (above=
) as=0A=
@@ -319,6 +331,13 @@ struct interface_scan_data {=0A=
=A0 =A0 void *user_data;=0A=
=A0};=0A=
=A0=0A=
+struct interface_p2p_device_config {=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+ =A0 GSupplicantInterfaceCallback callback;=0A=
+ =A0 GSupplicantP2PDeviceConfigParams *p2p_device_config_params;=0A=
+ =A0 void *user_data;=0A=
+};=0A=
+=0A=
=A0struct g_supplicant_p2p_inv_recv_info {=0A=
=A0 =A0 GSupplicantInterface *interface;=0A=
=A0 =A0 const char *p2p_go_dev_addr;=0A=
@@ -509,6 +528,78 @@ static void callback_system_ready(void)=0A=
=A0 =A0 callbacks_pointer->system_ready();=0A=
=A0}=0A=
=A0=0A=
+static void callback_p2p_prov_disc_requested_pbc(GSupplicantInterface *int=
erface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, void * data)=
=0A=
+{=0A=
+ =A0 if (!callbacks_pointer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (!callbacks_pointer->p2p_prov_disc_requested_pbc)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callbacks_pointer->p2p_prov_disc_requested_pbc(interface, peer);=0A=
+}=0A=
+=0A=
+static void callback_p2p_prov_disc_requested_enter_pin(GSupplicantInterfac=
e *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, void * data)=
=0A=
+{=0A=
+ =A0 if (!callbacks_pointer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (!callbacks_pointer->p2p_prov_disc_requested_enter_pin)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callbacks_pointer->p2p_prov_disc_requested_enter_pin(interface, peer)=
;=0A=
+}=0A=
+=0A=
+static void callback_p2p_prov_disc_requested_display_pin(GSupplicantInterf=
ace *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, const char *pi=
n)=0A=
+{=0A=
+ =A0 if (!callbacks_pointer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (!callbacks_pointer->p2p_prov_disc_requested_display_pin)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callbacks_pointer->p2p_prov_disc_requested_display_pin(interface, pee=
r, pin);=0A=
+}=0A=
+=0A=
+static void callback_p2p_prov_disc_response_enter_pin(GSupplicantInterface=
 *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, void * data)=
=0A=
+{=0A=
+ =A0 if (!callbacks_pointer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (!callbacks_pointer->p2p_prov_disc_requested_enter_pin)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callbacks_pointer->p2p_prov_disc_response_enter_pin(interface, peer);=
=0A=
+}=0A=
+=0A=
+static void callback_p2p_prov_disc_response_display_pin(GSupplicantInterfa=
ce *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, const char *pi=
n)=0A=
+{=0A=
+ =A0 if (!callbacks_pointer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (!callbacks_pointer->p2p_prov_disc_requested_display_pin)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callbacks_pointer->p2p_prov_disc_response_display_pin(interface, peer=
, pin);=0A=
+}=0A=
+=0A=
+static void callback_p2p_prov_disc_fail(GSupplicantInterface *interface,=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, const char *pi=
n)=0A=
+{=0A=
+ =A0 if (!callbacks_pointer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (!callbacks_pointer->p2p_prov_disc_fail)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callbacks_pointer->p2p_prov_disc_fail(interface, peer, pin);=0A=
+}=0A=
+=0A=
=A0static void callback_system_killed(void)=0A=
=A0{=0A=
=A0 =A0 system_ready =3D FALSE;=0A=
@@ -1027,6 +1118,176 @@ static void debug_strvalmap(const char *label, stru=
ct strvalmap *map,=0A=
=A0 =A0 }=0A=
=A0}=0A=
=A0=0A=
+static void fire_p2p_prov_dics_signal(GSupplicantInterface *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char* path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_supplicant_p2p_prov_dics_signal_fun=
c signal_func,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void* signal_params)=0A=
+{=0A=
+ =A0 GSupplicantPeer *peer;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("");=0A=
+=0A=
+ =A0 peer =3D g_hash_table_lookup(interface->peer_table, path);=0A=
+ =A0 if (!peer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 signal_func(interface, peer, signal_params);=0A=
+ =A0 g_free(signal_params);=0A=
+}=0A=
+=0A=
+static void interface_p2p_prov_disc_request_or_response(DBusMessageIter *i=
ter,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user_data, bool is_request, cha=
r *wps_method)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface =3D user_data;=0A=
+ =A0 char *path, *pin =3D NULL;=0A=
+=0A=
+ =A0 if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_OBJECT_PATH) =
{=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not object path\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(iter, &path);=0A=
+=0A=
+ =A0 if (g_str_equal(wps_method, "disp_pin")) {=0A=
+ =A0 =A0 =A0 dbus_message_iter_next(iter);=0A=
+=0A=
+ =A0 =A0 =A0 if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_STRIN=
G) {=0A=
+ =A0 =A0 =A0 =A0 =A0 SUPPLICANT_DBG("not string\n");=0A=
+ =A0 =A0 =A0 =A0 =A0 return;=0A=
+ =A0 =A0 =A0 }=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(iter, &pin);=0A=
+=0A=
+ =A0 =A0 =A0 if (!pin || strlen(pin) !=3D WPAS_P2P_WPS_PIN_LENGTH) {=0A=
+ =A0 =A0 =A0 =A0 =A0 SUPPLICANT_DBG("strange\n");=0A=
+ =A0 =A0 =A0 =A0 =A0 return;=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 }=0A=
+=0A=
+ =A0 g_supplicant_p2p_prov_dics_signal_func callback_method =3D NULL;=0A=
+=0A=
+ =A0 if (is_request) {=0A=
+ =A0 =A0 =A0 if (g_str_equal(wps_method, "pbc"))=0A=
+ =A0 =A0 =A0 =A0 =A0 callback_method =3D callback_p2p_prov_disc_requested_=
pbc;=0A=
+ =A0 =A0 =A0 else if (g_str_equal(wps_method, "enter_pin"))=0A=
+ =A0 =A0 =A0 =A0 =A0 callback_method =3D callback_p2p_prov_disc_requested_=
enter_pin;=0A=
+ =A0 =A0 =A0 else if (g_str_equal(wps_method, "disp_pin"))=0A=
+ =A0 =A0 =A0 =A0 =A0 callback_method =3D callback_p2p_prov_disc_requested_=
display_pin;=0A=
+ =A0 }=0A=
+ =A0 else {=0A=
+ =A0 =A0 =A0 if (g_str_equal(wps_method, "enter_pin"))=0A=
+ =A0 =A0 =A0 =A0 =A0 callback_method =3D callback_p2p_prov_disc_response_e=
nter_pin;=0A=
+ =A0 =A0 =A0 else if (g_str_equal(wps_method, "disp_pin"))=0A=
+ =A0 =A0 =A0 =A0 =A0 callback_method =3D callback_p2p_prov_disc_response_d=
isplay_pin;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (callback_method)=0A=
+ =A0 {=0A=
+ =A0 =A0 =A0 pin =3D g_strdup(pin);=0A=
+ =A0 =A0 =A0 fire_p2p_prov_dics_signal(interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 callback_method,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)pin);=0A=
+ =A0 }=0A=
+}=0A=
+=0A=
+static void signal_prov_disc_requested_pbc(const char *path, DBusMessageIt=
er *iter)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, path);=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface_p2p_prov_disc_request_or_response(iter, interface, true, "p=
bc");=0A=
+}=0A=
+=0A=
+static void signal_prov_disc_requested_enter_pin(const char *path, DBusMes=
sageIter *iter)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, path);=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface_p2p_prov_disc_request_or_response(iter, interface, true, "e=
nter_pin");=0A=
+}=0A=
+=0A=
+static void signal_prov_disc_requested_disp_pin(const char *path, DBusMess=
ageIter *iter)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, path);=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface_p2p_prov_disc_request_or_response(iter, interface, true, "d=
isp_pin");=0A=
+}=0A=
+=0A=
+static void signal_prov_disc_response_enter_pin(const char *path, DBusMess=
ageIter *iter)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, path);=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface_p2p_prov_disc_request_or_response(iter, interface, false, "=
enter_pin");=0A=
+}=0A=
+=0A=
+static void signal_prov_disc_response_disp_pin(const char *path, DBusMessa=
geIter *iter)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, path);=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface_p2p_prov_disc_request_or_response(iter, interface, false, "=
disp_pin");=0A=
+}=0A=
+=0A=
+static void interface_p2p_prov_disc_fail(DBusMessageIter *iter, void *user=
_data)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface =3D user_data;=0A=
+ =A0 GSupplicantPeer *peer;=0A=
+ =A0 const char *path;=0A=
+ =A0 const char * status;=0A=
+=0A=
+ =A0 if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_OBJECT_PATH) =
{=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not object path\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(iter, &path);=0A=
+=0A=
+ =A0 dbus_message_iter_next(iter);=0A=
+=0A=
+ =A0 if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_INT32) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not int32\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(iter, &status);=0A=
+=0A=
+ =A0 peer =3D g_hash_table_lookup(interface->peer_table, path);=0A=
+=0A=
+ =A0 if (!peer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callback_p2p_prov_disc_fail(interface, peer, status);=0A=
+}=0A=
+=0A=
+static void signal_prov_disc_fail(const char *path, DBusMessageIter *iter)=
=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, path);=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface_p2p_prov_disc_fail(iter, interface);=0A=
+}=0A=
+=0A=
=A0static void interface_capability_keymgmt(DBusMessageIter *iter, void *us=
er_data)=0A=
=A0{=0A=
=A0 =A0 GSupplicantInterface *interface =3D user_data;=0A=
@@ -4377,6 +4638,14 @@ static struct {=0A=
=A0 =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "GroupFinished", sig=
nal_group_finished },=0A=
=A0 =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "GONegotiationReques=
t", signal_group_request },=0A=
=A0=0A=
+ =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "ProvisionDiscoveryPBC=
Request", =A0signal_prov_disc_requested_pbc },=0A=
+ =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "ProvisionDiscoveryReq=
uestEnterPin", signal_prov_disc_requested_enter_pin },=0A=
+ =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "ProvisionDiscoveryReq=
uestDisplayPin", =A0 signal_prov_disc_requested_disp_pin },=0A=
+=0A=
+ =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "ProvisionDiscoveryRes=
ponseEnterPin", =A0 =A0signal_prov_disc_response_enter_pin },=0A=
+ =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "ProvisionDiscoveryRes=
ponseDisplayPin", =A0signal_prov_disc_response_disp_pin },=0A=
+ =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "ProvisionDiscoveryFai=
lure", signal_prov_disc_fail },=0A=
+=0A=
=A0 =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "InvitationResult", =
signal_invitation_result },=0A=
=A0 =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "InvitationReceived"=
, signal_invitation_received },=0A=
=A0=0A=
@@ -4636,6 +4905,295 @@ int g_supplicant_interface_set_p2p_device_config(GS=
upplicantInterface *interface=0A=
=A0 =A0 return ret;=0A=
=A0}=0A=
=A0=0A=
+static void callback_p2p_device_config_loaded(GSupplicantInterface *interf=
ace)=0A=
+{=0A=
+ =A0 SUPPLICANT_DBG("");=0A=
+=0A=
+ =A0 if (!interface->p2p_support)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (callbacks_pointer && callbacks_pointer->p2p_device_config_loaded)=
=0A=
+ =A0 =A0 =A0 callbacks_pointer->p2p_device_config_loaded(interface);=0A=
+}=0A=
+=0A=
+static void p2p_device_config_property_update(DBusMessageIter *iter, void =
*user_data)=0A=
+{=0A=
+ =A0 GSupplicantP2PDeviceConfigParams *p2p_device_config =3D user_data;=0A=
+ =A0 DBusMessageIter iter_dict, iter_dict_entry;=0A=
+ =A0 char *key =3D NULL;=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(iter, &iter_dict);=0A=
+ =A0 dbus_message_iter_get_basic(&iter_dict, &key);=0A=
+=0A=
+ =A0 dbus_message_iter_next(&iter_dict);=0A=
+ =A0 dbus_message_iter_recurse(&iter_dict, &iter_dict_entry);=0A=
+=0A=
+ =A0 if (!key)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (g_strcmp0(key, "DeviceName") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 char *name =3D NULL;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &name);=0A=
+=0A=
+ =A0 =A0 =A0 if(p2p_device_config->device_name !=3D NULL){=0A=
+ =A0 =A0 =A0 =A0 =A0 g_free(p2p_device_config->device_name);=0A=
+ =A0 =A0 =A0 =A0 =A0 p2p_device_config->device_name =3D NULL;=0A=
+ =A0 =A0 =A0 }=0A=
+=0A=
+ =A0 =A0 =A0 p2p_device_config->device_name =3D g_strdup(name);=0A=
+=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("device_name : %s\n", p2p_device_config->devic=
e_name);=0A=
+ =A0 } else if (g_strcmp0(key, "PrimaryDeviceType") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 DBusMessageIter array;=0A=
+ =A0 =A0 =A0 unsigned char *device_type =3D NULL;=0A=
+ =A0 =A0 =A0 int type_len =3D 0;=0A=
+ =A0 =A0 =A0 int i=3D0;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_recurse(&iter_dict_entry, &array);=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_fixed_array(&array, &device_type, &type=
_len);=0A=
+=0A=
+ =A0 =A0 =A0 if(type_len =3D=3D 8) {=0A=
+ =A0 =A0 =A0 =A0 =A0 for(i=3D0; i<type_len; i++)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 p2p_device_config->pri_dev_type[i] =3D device=
_type[i];=0A=
+ =A0 =A0 =A0 } else {=0A=
+ =A0 =A0 =A0 =A0 =A0 SUPPLICANT_DBG("strange device type\n");=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 } else if (g_strcmp0(key, "GOIntent") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_uint32_t go_intent;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &go_intent);=0A=
+ =A0 =A0 =A0 p2p_device_config->go_intent =3D go_intent;=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("go_intent : %d\n", p2p_device_config->go_inte=
nt);=0A=
+ =A0 } else if (g_strcmp0(key, "PersistentReconnect") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_bool_t persistent_reconnect;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &persistent_rec=
onnect);=0A=
+ =A0 =A0 =A0 p2p_device_config->persistent_reconnect =3D persistent_reconn=
ect;=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("persistent_reconnect : %d\n", p2p_device_conf=
ig->persistent_reconnect);=0A=
+ =A0 } else if (g_strcmp0(key, "ListenRegClass") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_uint32_t listen_reg_class;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &listen_reg_cla=
ss);=0A=
+ =A0 =A0 =A0 p2p_device_config->listen_reg_class =3D listen_reg_class;=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("listen_reg_class : %d\n", p2p_device_config->=
listen_reg_class);=0A=
+ =A0 } else if (g_strcmp0(key, "ListenChannel") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_uint32_t listen_channel;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &listen_channel=
);=0A=
+ =A0 =A0 =A0 p2p_device_config->listen_channel =3D listen_channel;=0A=
+ =A0 } else if (g_strcmp0(key, "OperRegClass") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_uint32_t oper_reg_class;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &oper_reg_class=
);=0A=
+ =A0 =A0 =A0 p2p_device_config->oper_reg_class =3D oper_reg_class;=0A=
+ =A0 } else if (g_strcmp0(key, "OperChannel") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_uint32_t oper_channel;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &oper_channel);=
=0A=
+ =A0 =A0 =A0 p2p_device_config->oper_channel =3D oper_channel;=0A=
+ =A0 } else if (g_strcmp0(key, "SsidPostfix") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 char *ssid_postfix =3D NULL;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &ssid_postfix);=
=0A=
+=0A=
+ =A0 =A0 =A0 if(p2p_device_config->ssid_postfix !=3D NULL){=0A=
+ =A0 =A0 =A0 =A0 =A0 g_free(p2p_device_config->ssid_postfix);=0A=
+ =A0 =A0 =A0 =A0 =A0 p2p_device_config->ssid_postfix =3D NULL;=0A=
+ =A0 =A0 =A0 }=0A=
+=0A=
+ =A0 =A0 =A0 p2p_device_config->ssid_postfix =3D g_strdup(ssid_postfix);=
=0A=
+ =A0 } else if (g_strcmp0(key, "IntraBss") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_bool_t intra_bss;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &intra_bss);=0A=
+ =A0 =A0 =A0 p2p_device_config->intra_bss =3D intra_bss;=0A=
+ =A0 } else if (g_strcmp0(key, "GroupIdle") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_uint32_t group_idle;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &group_idle);=
=0A=
+ =A0 =A0 =A0 p2p_device_config->group_idle =3D group_idle;=0A=
+ =A0 } else if (g_strcmp0(key, "disassoc_low_ack") =3D=3D 0) {=0A=
+ =A0 =A0 =A0 dbus_uint32_t disassoc_low_ack;=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&iter_dict_entry, &disassoc_low_a=
ck);=0A=
+ =A0 =A0 =A0 p2p_device_config->disassoc_low_ack =3D disassoc_low_ack;=0A=
+ =A0 } else=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("key %s type %c",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key, dbus_message_iter_get_arg_type(&=
iter_dict_entry));=0A=
+}=0A=
+=0A=
+static void p2p_device_config_property(const char *key, DBusMessageIter *i=
ter,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user_data)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+ =A0 GSupplicantP2PInterface *p2p_device_interface =3D user_data;=0A=
+ =A0 GSupplicantP2PDeviceConfigParams *p2p_device_config =3D p2p_device_in=
terface->p2p_device_config_param;;=0A=
+=0A=
+ =A0 GSupplicantInterface *check_interface =3D NULL;=0A=
+=0A=
+ =A0 if (key){=0A=
+ =A0 =A0 =A0 check_interface =3D g_hash_table_lookup(interface_table, key)=
;=0A=
+ =A0 =A0 =A0 if (check_interface =3D=3D NULL)=0A=
+ =A0 =A0 =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 =A0 =A0 struct wifi_data *check_wifi =3D g_supplicant_interface_get_d=
ata(check_interface);=0A=
+ =A0 =A0 =A0 if (check_wifi =3D=3D NULL)=0A=
+ =A0 =A0 =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (p2p_device_config->interface->path =3D=3D NULL)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, p2p_device_config-=
>interface->path);=0A=
+ =A0 if (interface =3D=3D NULL || interface !=3D p2p_device_config->interf=
ace) {=0A=
+ =A0 =A0 =A0 g_free(p2p_device_interface->path);=0A=
+ =A0 =A0 =A0 g_free(p2p_device_interface);=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (iter)=0A=
+ =A0 =A0 =A0 supplicant_dbus_array_foreach(iter, p2p_device_config_propert=
y_update, p2p_device_config);=0A=
+=0A=
+ =A0 callback_p2p_device_config_loaded(p2p_device_config->interface);=0A=
+=0A=
+ =A0 g_free(p2p_device_interface->path);=0A=
+ =A0 g_free(p2p_device_interface);=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
+int g_supplicant_interface_get_p2p_device_config(GSupplicantInterface *int=
erface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantP2PDeviceConfigParams *p2p=
_device_config_data)=0A=
+{=0A=
+ =A0 GSupplicantP2PInterface *p2p_device_interface =3D NULL;=0A=
+ =A0 int ret;=0A=
+=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return -EINVAL;=0A=
+=0A=
+ =A0 if (!system_available)=0A=
+ =A0 =A0 =A0 return -EFAULT;=0A=
+=0A=
+ =A0 p2p_device_interface =3D g_try_malloc0(sizeof(GSupplicantP2PInterface=
));=0A=
+ =A0 if(!p2p_device_interface)=0A=
+ =A0 =A0 =A0 return -ENOMEM;=0A=
+=0A=
+ =A0 p2p_device_interface->path =3D g_strdup(interface->path);=0A=
+ =A0 p2p_device_interface->p2p_device_config_param =3D p2p_device_config_d=
ata;=0A=
+ =A0 p2p_device_interface->p2p_device_config_param->interface =3D interfac=
e;=0A=
+=0A=
+ =A0 ret =3D supplicant_dbus_property_get(interface->path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SUPPLICANT_INTERFACE ".Interface.P2PDevice",=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 "P2PDeviceConfig",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 p2p_device_config_property,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 p2p_device_interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL);=0A=
+=0A=
+ =A0 if (ret < 0) {=0A=
+ =A0 =A0 =A0 g_free(p2p_device_interface->path);=0A=
+ =A0 =A0 =A0 g_free(p2p_device_interface);=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("Unable to get P2P Device configuration");=0A=
+ =A0 }=0A=
+=0A=
+ =A0 return ret;=0A=
+}=0A=
+=0A=
+static void interface_set_p2p_device_config_result(const char *error,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 DBusMessageIter *iter, void *user_data)=0A=
+{=0A=
+ =A0 struct interface_p2p_device_config *config =3D user_data;=0A=
+=0A=
+ =A0 if (error) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("error %s", error);=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_free(config);=0A=
+}=0A=
+=0A=
+static void interface_set_p2p_device_config_params(DBusMessageIter *iter, =
void *user_data)=0A=
+{=0A=
+ =A0 struct interface_p2p_device_config *config =3D user_data;=0A=
+ =A0 GSupplicantP2PDeviceConfigParams *config_params =3D config->p2p_devic=
e_config_params;=0A=
+ =A0 DBusMessageIter dict;=0A=
+ =A0 uint8_t *pri_dev_type =3D config_params->pri_dev_type;=0A=
+ =A0 uint8_t pri_dev_type_check[8] =3D {0,};=0A=
+=0A=
+ =A0 supplicant_dbus_dict_open(iter, &dict);=0A=
+=0A=
+ =A0 if(config_params->device_name)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "DeviceName", DBUS_T=
YPE_STRING, &config_params->device_name);=0A=
+=0A=
+ =A0 if(memcmp(&pri_dev_type_check[0], pri_dev_type, 8) !=3D 0)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_fixed_array(&dict, "PrimaryDevice=
Type", DBUS_TYPE_BYTE, &pri_dev_type, 8);=0A=
+=0A=
+ =A0 if(config_params->go_intent !=3D 0)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "GOIntent", DBUS_TYP=
E_UINT32, &config_params->go_intent);=0A=
+=0A=
+ =A0 supplicant_dbus_dict_append_basic(&dict, "PersistentReconnect", DBUS_=
TYPE_BOOLEAN, &config_params->persistent_reconnect);=0A=
+=0A=
+ =A0 if(config_params->listen_reg_class !=3D 0)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "ListenRegClass", DB=
US_TYPE_UINT32, &config_params->listen_reg_class);=0A=
+=0A=
+ =A0 if(config_params->listen_channel !=3D 0)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "ListenChannel", DBU=
S_TYPE_UINT32, &config_params->listen_channel);=0A=
+=0A=
+ =A0 if(config_params->oper_reg_class !=3D 0)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "OperRegClass", DBUS=
_TYPE_UINT32, &config_params->oper_reg_class);=0A=
+=0A=
+ =A0 if(config_params->oper_channel !=3D 0)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "OperChannel", DBUS_=
TYPE_UINT32, &config_params->oper_channel);=0A=
+=0A=
+ =A0 if(config_params->ssid_postfix)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "SsidPostfix", DBUS_=
TYPE_STRING, &config_params->ssid_postfix);=0A=
+=0A=
+ =A0 supplicant_dbus_dict_append_basic(&dict, "IntraBss", DBUS_TYPE_BOOLEA=
N, &config_params->intra_bss);=0A=
+=0A=
+ =A0 if(config_params->group_idle !=3D 0)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "GroupIdle", DBUS_TY=
PE_UINT32, &config_params->group_idle);=0A=
+=0A=
+ =A0 if(config_params->disassoc_low_ack !=3D 0)=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "disassoc_low_ack", =
DBUS_TYPE_UINT32, &config_params->disassoc_low_ack);=0A=
+=0A=
+ =A0 supplicant_dbus_dict_close(iter, &dict);=0A=
+}=0A=
+=0A=
+int g_supplicant_interface_set_p2p_device_configs(GSupplicantInterface *in=
terface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 GSupplicantP2PDeviceConfigParams *p2p_device_config_dat=
a,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 void *user_data)=0A=
+{=0A=
+ =A0 struct interface_p2p_device_config *config =3D NULL;=0A=
+ =A0 int ret;=0A=
+=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return -EINVAL;=0A=
+=0A=
+ =A0 config =3D dbus_malloc0(sizeof(*config));=0A=
+ =A0 if (!config)=0A=
+ =A0 =A0 =A0 return -ENOMEM;=0A=
+=0A=
+ =A0 config->interface =3D interface;=0A=
+ =A0 config->user_data =3D user_data;=0A=
+ =A0 config->p2p_device_config_params =3D p2p_device_config_data;=0A=
+=0A=
+ =A0 ret =3D supplicant_dbus_property_set(interface->path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SUPPLICANT_INTERFACE ".Interface.P2PDevice",=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 "P2PDeviceConfig", DBUS_TYPE_ARRAY_AS_STRING=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING_AS_STRING=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_VARIANT_AS_STRING=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_DICT_ENTRY_END_CHAR_AS_STRING,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 interface_set_p2p_device_config_params,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 interface_set_p2p_device_config_result, confi=
g, NULL);=0A=
+=0A=
+ =A0 if (ret < 0) {=0A=
+ =A0 =A0 =A0 dbus_free(config);=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("Unable to set P2P Device configuration");=0A=
+ =A0 }=0A=
+=0A=
+ =A0 return ret;=0A=
+}=0A=
+=0A=
=A0static gboolean peer_lookup_by_identifier(gpointer key, gpointer value,=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpointer user_data)=
=0A=
=A0{=0A=
diff --git a/include/technology.h b/include/technology.h=0A=
index 965ad49..a094c04 100644=0A=
--- a/include/technology.h=0A=
+++ b/include/technology.h=0A=
@@ -69,6 +69,10 @@ struct connman_technology_driver {=0A=
=A0 =A0 int (*set_p2p_listen) (struct connman_technology *technology, bool =
enable);=0A=
=A0 =A0 int (*set_p2p_go) (DBusMessage *msg, struct connman_technology *tec=
hnology,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *identifier, con=
st char *passphrase);=0A=
+ =A0 int (*set_p2p_identifier) (struct connman_technology *technology,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *p2p_identifier);=
=0A=
+ =A0 int (*set_p2p_persistent) (struct connman_technology *technology,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool persistent_reconnect);=
=0A=
=A0};=0A=
=A0=0A=
=A0int connman_technology_driver_register(struct connman_technology_driver =
*driver);=0A=
@@ -77,6 +81,11 @@ void connman_technology_set_p2p_listen(struct connman_te=
chnology *technology,boo=0A=
=A0bool connman_technology_get_p2p_listen(struct connman_technology *techno=
logy);=0A=
=A0void __connman_technology_p2p_invitation_result(struct connman_technolog=
y *technology,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int status);=0A=
+void connman_technology_set_p2p_identifier(struct connman_technology *tech=
nology,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *p2p_ident=
ifier);=0A=
+bool is_technology_enabled(struct connman_technology *technology);=0A=
+bool connman_technology_get_p2p_persistent(struct connman_technology *tech=
nology);=0A=
+void connman_technology_set_p2p_persistent(struct connman_technology *tech=
nology, bool enabled);=0A=
=A0#ifdef __cplusplus=0A=
=A0}=0A=
=A0#endif=0A=
diff --git a/plugins/wifi.c b/plugins/wifi.c=0A=
index c6629f1..121259a 100644=0A=
--- a/plugins/wifi.c=0A=
+++ b/plugins/wifi.c=0A=
@@ -91,6 +91,8 @@ static guint p2p_scan_ref =3D 0;=0A=
=A0=0A=
=A0static int p2p_find_ref =3D -1;=0A=
=A0=0A=
+static int pin_requested_ref =3D -1;=0A=
+=0A=
=A0#define ASSOC_STATUS_AUTH_TIMEOUT 16=0A=
=A0#define ASSOC_STATUS_NO_CLIENT 17=0A=
=A0#define LOAD_SHAPING_MAX_RETRIES 3=0A=
@@ -184,6 +186,10 @@ struct wifi_data {=0A=
=A0 =A0 int disconnect_code;=0A=
=A0 =A0 int assoc_code;=0A=
=A0 =A0 const char *invited_path;=0A=
+ =A0 const char *generated_pin;=0A=
+ =A0 const char *pin_requested_path;=0A=
+ =A0 GSupplicantP2PDeviceConfigParams p2p_device_config;=0A=
+=0A=
=A0};=0A=
=A0=0A=
=A0struct wifi_network {=0A=
@@ -310,6 +316,202 @@ static int tech_set_p2p_go(DBusMessage *msg, struct c=
onnman_technology *technolo=0A=
=A0 =A0 return -err;=0A=
=A0}=0A=
=A0=0A=
+static void save_p2p_identifier(const char *p2p_identifier)=0A=
+{=0A=
+ =A0 GKeyFile *keyfile =3D NULL;=0A=
+ =A0 gchar *identifier =3D NULL;=0A=
+=0A=
+ =A0 keyfile =3D __connman_storage_load_global();=0A=
+ =A0 if(!keyfile)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 identifier =3D g_strdup_printf("%s", "WiFi");=0A=
+ =A0 if (!identifier) {=0A=
+ =A0 =A0 =A0 g_key_file_free(keyfile);=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 g_key_file_set_string(keyfile, identifier, "P2PIdentifier", p2p_ident=
ifier);=0A=
+ =A0 g_free(identifier);=0A=
+=0A=
+ =A0 __connman_storage_save_global(keyfile);=0A=
+=0A=
+ =A0 g_key_file_free(keyfile);=0A=
+}=0A=
+=0A=
+static int tech_set_p2p_identifier(struct connman_technology *technology, =
const char *p2p_identifier)=0A=
+{=0A=
+ =A0 GList *list =3D NULL;=0A=
+ =A0 char *old_device_name =3D NULL;=0A=
+ =A0 char *old_ssid_postfix =3D NULL;=0A=
+ =A0 int err =3D -EOPNOTSUPP;=0A=
+=0A=
+ =A0 if (!p2p_technology)=0A=
+ =A0 =A0 =A0 return -EOPNOTSUPP;=0A=
+=0A=
+ =A0 if (is_technology_enabled(p2p_technology)) {=0A=
+ =A0 =A0 =A0 for (list =3D iface_list; list; list =3D list->next) {=0A=
+ =A0 =A0 =A0 =A0 =A0 struct wifi_data *wifi =3D list->data;=0A=
+ =A0 =A0 =A0 =A0 =A0 GSupplicantInterface *iface =3D wifi->interface;=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 if (!g_supplicant_interface_has_p2p(iface))=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 if (wifi->p2p_device_config.device_name)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_device_name =3D wifi->p2p_device_config.d=
evice_name;=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 if (wifi->p2p_device_config.ssid_postfix)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_ssid_postfix =3D wifi->p2p_device_config.=
ssid_postfix;=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 wifi->p2p_device_config.device_name =3D g_strdup(p2p_=
identifier);=0A=
+ =A0 =A0 =A0 =A0 =A0 wifi->p2p_device_config.ssid_postfix =3D g_strdup_pri=
ntf("-%s", p2p_identifier);=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 err =3D g_supplicant_interface_set_p2p_device_configs=
(iface, &wifi->p2p_device_config, NULL);=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 if(err < 0) {=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free(wifi->p2p_device_config.device_name);=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free(wifi->p2p_device_config.ssid_postfix);=
=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 wifi->p2p_device_config.device_name =3D old_d=
evice_name;=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 wifi->p2p_device_config.ssid_postfix =3D old_=
ssid_postfix;=0A=
+ =A0 =A0 =A0 =A0 =A0 } else {=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 connman_technology_set_p2p_identifier(technol=
ogy, wifi->p2p_device_config.device_name);=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_p2p_identifier(wifi->p2p_device_config.d=
evice_name);=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free(old_device_name);=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free(old_ssid_postfix);=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_device_name =3D NULL;=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_ssid_postfix =3D NULL;=0A=
+ =A0 =A0 =A0 =A0 =A0 }=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 } else {=0A=
+ =A0 =A0 =A0 connman_technology_set_p2p_identifier(technology, p2p_identif=
ier);=0A=
+ =A0 =A0 =A0 save_p2p_identifier(p2p_identifier);=0A=
+ =A0 =A0 =A0 err =3D 0;=0A=
+ =A0 }=0A=
+ =A0 return err;=0A=
+}=0A=
+=0A=
+static const char *load_p2p_identifier()=0A=
+{=0A=
+ =A0 GKeyFile *keyfile =3D NULL;=0A=
+ =A0 gchar *identifier =3D NULL;=0A=
+ =A0 const char *p2p_identifier =3D NULL;=0A=
+=0A=
+ =A0 keyfile =3D __connman_storage_load_global();=0A=
+ =A0 if(!keyfile)=0A=
+ =A0 =A0 =A0 return NULL;=0A=
+=0A=
+ =A0 identifier =3D g_strdup_printf("%s", "WiFi");=0A=
+ =A0 if (!identifier) {=0A=
+ =A0 =A0 =A0 g_key_file_free(keyfile);=0A=
+ =A0 =A0 =A0 return NULL;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 p2p_identifier =3D g_key_file_get_string(keyfile, identifier, "P2PIde=
ntifier", NULL);=0A=
+ =A0 g_free(identifier);=0A=
+=0A=
+ =A0 if(!p2p_identifier) {=0A=
+ =A0 =A0 =A0 g_key_file_free(keyfile);=0A=
+ =A0 =A0 =A0 return NULL;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if(strlen(p2p_identifier) > 32)=0A=
+ =A0 {=0A=
+ =A0 =A0 =A0 g_free(p2p_identifier);=0A=
+ =A0 =A0 =A0 p2p_identifier =3D NULL;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 g_key_file_free(keyfile);=0A=
+=0A=
+ =A0 return p2p_identifier;=0A=
+}=0A=
+=0A=
+static void p2p_device_config_loaded(GSupplicantInterface *interface)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi =3D NULL;=0A=
+ =A0 char dev_type[17] =3D {};=0A=
+ =A0 char hostname[HOST_NAME_MAX+1] =3D {0};=0A=
+ =A0 const char *p2p_identifier;=0A=
+ =A0 char *old_device_name =3D NULL, *old_ssid_postfix =3D NULL;=0A=
+ =A0 int result;=0A=
+=0A=
+ =A0 wifi =3D g_supplicant_interface_get_data(interface);=0A=
+=0A=
+ =A0 if (!wifi)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 p2p_identifier =3D load_p2p_identifier();=0A=
+ =A0 if (wifi->p2p_device_config.device_name)=0A=
+ =A0 =A0 =A0 old_device_name =3D wifi->p2p_device_config.device_name;=0A=
+=0A=
+ =A0 if (wifi->p2p_device_config.ssid_postfix)=0A=
+ =A0 =A0 =A0 old_ssid_postfix =3D wifi->p2p_device_config.ssid_postfix;=0A=
+=0A=
+ =A0 if (!p2p_identifier) {=0A=
+ =A0 =A0 =A0 if (gethostname(hostname, HOST_NAME_MAX) < 0)=0A=
+ =A0 =A0 =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 =A0 =A0 wifi->p2p_device_config.device_name =3D g_strdup(hostname);=
=0A=
+ =A0 }=0A=
+ =A0 else=0A=
+ =A0 =A0 =A0 wifi->p2p_device_config.device_name =3D g_strdup(p2p_identifi=
er);=0A=
+=0A=
+ =A0 if (wifi->p2p_device_config.device_name) {=0A=
+ =A0 =A0 =A0 /* we have to add a hyphen here as wpa-supplicant just adds t=
he postifx to the=0A=
+ =A0 =A0 =A0 =A0* automatically created SSID */=0A=
+ =A0 =A0 =A0 wifi->p2p_device_config.ssid_postfix =3D g_strdup_printf("-%s=
", wifi->p2p_device_config.device_name);=0A=
+ =A0 }=0A=
+=0A=
+ =A0 /**=0A=
+ =A0 =A0* TV icon type listed as Laptop. Reason is the machine type relate=
d interface org.freedesktop.hostname1=0A=
+ =A0 =A0* is not used ,commenting the below source ,using the type from wp=
a_supplicant as it is=0A=
+ =A0 =A0*/=0A=
+ =A0 /* =A0set_device_type(connman_machine_get_type(), dev_type);=0A=
+ =A0 =A0dev_type_str2bin(dev_type, wifi->p2p_device_config.pri_dev_type);*=
/=0A=
+=0A=
+ =A0 result =3D g_supplicant_interface_set_p2p_device_configs(interface, &=
wifi->p2p_device_config, NULL);=0A=
+ =A0 if (result < 0) {=0A=
+ =A0 =A0 =A0 g_free(wifi->p2p_device_config.device_name);=0A=
+ =A0 =A0 =A0 g_free(wifi->p2p_device_config.ssid_postfix);=0A=
+ =A0 =A0 =A0 wifi->p2p_device_config.device_name =3D old_device_name;=0A=
+ =A0 =A0 =A0 wifi->p2p_device_config.ssid_postfix =3D old_ssid_postfix;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 connman_technology_set_p2p_identifier(p2p_technology, wifi->p2p_devic=
e_config.device_name);=0A=
+ =A0 if (old_device_name !=3D wifi->p2p_device_config.device_name)=0A=
+ =A0 =A0 =A0 g_free(old_device_name);=0A=
+ =A0 if (old_ssid_postfix !=3D wifi->p2p_device_config.ssid_postfix)=0A=
+ =A0 =A0 =A0 g_free(old_ssid_postfix);=0A=
+=0A=
+ =A0 =A0g_free(p2p_identifier);=0A=
+}=0A=
+=0A=
+static int tech_set_p2p_persistent(struct connman_technology *technology, =
bool persistent_reconnect)=0A=
+{=0A=
+ =A0 GList *list =3D NULL;=0A=
+ =A0 int err =3D 0;=0A=
+=0A=
+ =A0 if (!p2p_technology)=0A=
+ =A0 =A0 =A0 return -EOPNOTSUPP;=0A=
+=0A=
+ =A0 for (list =3D iface_list; list; list =3D list->next) {=0A=
+ =A0 =A0 =A0 struct wifi_data *wifi =3D list->data;=0A=
+ =A0 =A0 =A0 GSupplicantInterface *iface =3D wifi->interface;=0A=
+=0A=
+ =A0 =A0 =A0 if (!g_supplicant_interface_has_p2p(iface))=0A=
+ =A0 =A0 =A0 =A0 =A0 continue;=0A=
+=0A=
+ =A0 =A0 =A0 wifi->p2p_device_config.persistent_reconnect =3D persistent_r=
econnect;=0A=
+=0A=
+ =A0 =A0 =A0 err =3D g_supplicant_interface_set_p2p_device_configs(iface, =
&wifi->p2p_device_config, NULL);=0A=
+ =A0 =A0 =A0 DBG("g_supplicant_interface_set_p2p_device_configs : %d\n",er=
r);=0A=
+=0A=
+ =A0 }=0A=
+=0A=
+=0A=
+ =A0 return err;=0A=
+}=0A=
=A0=0A=
=A0static struct connman_technology_driver p2p_tech_driver =3D {=0A=
=A0 =A0 .name =A0 =A0 =A0 =3D "p2p",=0A=
@@ -317,6 +519,8 @@ static struct connman_technology_driver p2p_tech_driver=
 =3D {=0A=
=A0 =A0 .probe =A0 =A0 =A0=3D p2p_tech_probe,=0A=
=A0 =A0 .remove =A0 =A0 =3D p2p_tech_remove,=0A=
=A0 =A0 .set_p2p_go =3D tech_set_p2p_go,=0A=
+ =A0 .set_p2p_identifier =3D tech_set_p2p_identifier,=0A=
+ =A0 .set_p2p_persistent =3D tech_set_p2p_persistent,=0A=
=A0};=0A=
=A0=0A=
=A0static bool is_p2p_connecting(void)=0A=
@@ -493,6 +697,11 @@ static int peer_connect(struct connman_peer *peer,=0A=
=A0=0A=
=A0 =A0 peer_params->master =3D connman_peer_service_is_master();=0A=
=A0=0A=
+ =A0 if(connman_technology_get_p2p_persistent(p2p_technology))=0A=
+ =A0 =A0 =A0 peer_params->persistent =3D TRUE;=0A=
+ =A0 else=0A=
+ =A0 =A0 =A0 peer_params->persistent =3D FALSE;=0A=
+=0A=
=A0 =A0 ret =3D g_supplicant_interface_p2p_connect(wifi->interface, peer_pa=
rams,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 peer_connect_callback, wifi=
);=0A=
=A0 =A0 if (ret =3D=3D -EINPROGRESS) {=0A=
@@ -539,7 +748,6 @@ static int peer_disconnect(struct connman_peer *peer)=
=0A=
=A0 =A0 =A0 =A0 peer_cancel_timeout(wifi);=0A=
=A0 =A0 =A0 =A0 wifi->p2p_device =3D false;=0A=
=A0 =A0 }=0A=
-=0A=
=A0 =A0 return ret;=0A=
=A0}=0A=
=A0=0A=
@@ -1768,6 +1976,10 @@ static int wifi_disable(struct connman_device *devic=
e)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_SERVICE_TYPE_WIFI, false);=0A=
=A0 =A0 =A0 =A0 connman_device_unref(wifi->device);=0A=
=A0 =A0 }=0A=
+ =A0 if(p2p_technology) {=0A=
+ =A0 =A0 =A0 if (connman_technology_get_p2p_listen(p2p_technology))=0A=
+ =A0 =A0 =A0 =A0 =A0 tech_set_p2p_listen(p2p_technology, false);=0A=
+ =A0 }=0A=
=A0=0A=
=A0 =A0 remove_networks(device, wifi);=0A=
=A0 =A0 remove_peers(wifi);=0A=
@@ -3575,6 +3787,7 @@ static void peer_request(GSupplicantPeer *peer)=0A=
=A0 =A0 if (!connman_peer)=0A=
=A0 =A0 =A0 =A0 return;=0A=
=A0=0A=
+ =A0 peer_connect(connman_peer,CONNMAN_PEER_WPS_PBC,NULL);=0A=
=A0 =A0 connman_peer_request_connection(connman_peer);=0A=
=A0}=0A=
=A0=0A=
@@ -3677,6 +3890,194 @@ static void p2p_group_finished(GSupplicantInterface=
 *interface)=0A=
=A0 =A0 __connman_group_remove(interface);=0A=
=A0}=0A=
=A0=0A=
+=0A=
+=0A=
+static void p2p_prov_disc_requested_pbc(GSupplicantInterface *interface,=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi =3D g_supplicant_interface_get_data(interface)=
;=0A=
+ =A0 struct connman_peer *connman_peer;=0A=
+ =A0 const char *identifier, *path;=0A=
+ =A0 const char *sig =3D "pbc";=0A=
+=0A=
+ =A0 if (!wifi || !wifi->device)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 identifier =3D g_supplicant_peer_get_identifier(peer);=0A=
+=0A=
+ =A0 DBG("ident: %s", identifier);=0A=
+=0A=
+ =A0 connman_peer =3D connman_peer_get(wifi->device, identifier);=0A=
+ =A0 if (!connman_peer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 connman_peer_set_state(connman_peer, CONNMAN_PEER_STATE_IDLE);=0A=
+ =A0 //connman_peer_set_as_master(connman_peer, false);=0A=
+=0A=
+ =A0 path =3D __connman_peer_get_path(connman_peer);=0A=
+=0A=
+ =A0 if (path && p2p_go_identifier) {=0A=
+ =A0 =A0 =A0 connman_dbus_property_changed_basic(path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_SERVICE_INTERFACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "P2PProvDiscRequestedPBC",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING, &sig);=0A=
+ =A0 }=0A=
+}=0A=
+=0A=
+static void p2p_prov_disc_requested_enter_pin(GSupplicantInterface *interf=
ace,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi =3D g_supplicant_interface_get_data(interface)=
;=0A=
+ =A0 struct connman_peer *connman_peer;=0A=
+ =A0 struct connman_network *connman_network;=0A=
+ =A0 const char *identifier, *path;=0A=
+ =A0 const char *sig =3D "keypad";=0A=
+=0A=
+ =A0 if (!wifi || !wifi->device)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 identifier =3D g_supplicant_peer_get_identifier(peer);=0A=
+=0A=
+ =A0 DBG("ident: %s", identifier);=0A=
+=0A=
+ =A0 connman_network =3D connman_device_get_network(wifi->device, identifi=
er);=0A=
+ =A0 if (!connman_network)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 //wfds_on_p2p_pin_requested(connman_network, NULL);=0A=
+=0A=
+ =A0 connman_peer =3D connman_peer_get(wifi->device, identifier);=0A=
+ =A0 if (!connman_peer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 connman_peer_set_state(connman_peer, CONNMAN_PEER_STATE_IDLE);=0A=
+ =A0 connman_peer_set_as_master(connman_peer, false);=0A=
+=0A=
+ =A0 path =3D __connman_peer_get_path(connman_peer);=0A=
+=0A=
+ =A0 if (p2p_go_identifier) {=0A=
+ =A0 =A0 =A0 connman_dbus_property_changed_basic(path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_SERVICE_INTERFACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "P2PProvDiscRequestedEnterPin",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING, &sig);=0A=
+ =A0 }=0A=
+}=0A=
+=0A=
+static gboolean p2p_pin_requested(gpointer argv)=0A=
+{=0A=
+ =A0 pin_requested_ref =3D -1;=0A=
+=0A=
+ =A0 return FALSE;=0A=
+}=0A=
+=0A=
+static void p2p_prov_disc_requested_display_pin(GSupplicantInterface *inte=
rface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, const char *pi=
n)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi =3D g_supplicant_interface_get_data(interface)=
;=0A=
+ =A0 struct connman_peer *connman_peer;=0A=
+ =A0 struct connman_network *connman_network;=0A=
+ =A0 const char *identifier, *path;=0A=
+ =A0 const char *sig =3D "keypad";=0A=
+=0A=
+ =A0 if (!wifi || !wifi->device)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 identifier =3D g_supplicant_peer_get_identifier(peer);=0A=
+=0A=
+ =A0 DBG("ident: %s", identifier);=0A=
+=0A=
+ =A0 /** Throttle pin requested messages */=0A=
+ =A0 if (pin_requested_ref !=3D -1) {=0A=
+ =A0 =A0 =A0 g_source_remove(pin_requested_ref);=0A=
+ =A0 =A0 =A0 pin_requested_ref =3D g_timeout_add_seconds(2, p2p_pin_reques=
ted, NULL);=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 connman_network =3D connman_device_get_network(wifi->device, identifi=
er);=0A=
+ =A0 if (!connman_network)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 connman_peer =3D connman_peer_get(wifi->device, identifier);=0A=
+ =A0 if (!connman_peer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 connman_peer_set_state(connman_peer, CONNMAN_PEER_STATE_IDLE);=0A=
+ =A0 //connman_peer_set_as_master(connman_peer, false);=0A=
+ =A0 path =3D __connman_peer_get_path(connman_peer);=0A=
+=0A=
+ =A0 wifi->generated_pin =3D pin;=0A=
+ =A0 wifi->pin_requested_path =3D connman_network_get_string(connman_netwo=
rk, "Path");=0A=
+=0A=
+ =A0 //wfds_on_p2p_pin_requested(connman_network, pin);=0A=
+=0A=
+ =A0 if (p2p_go_identifier || __connman_group_exist() =3D=3D FALSE) {=0A=
+ =A0 =A0 =A0 connman_dbus_property_changed_basic(path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_SERVICE_INTERFACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "P2PProvDiscRequestedDisplayPin",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING, &pin);=0A=
+=0A=
+ =A0 =A0 =A0 pin_requested_ref =3D g_timeout_add_seconds(2, p2p_pin_reques=
ted, NULL);=0A=
+ =A0 }=0A=
+}=0A=
+=0A=
+static void p2p_prov_disc_response_enter_pin(GSupplicantInterface *interfa=
ce,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi;=0A=
+ =A0 const char *identifier;=0A=
+ =A0 struct connman_network *connman_network;=0A=
+=0A=
+ =A0 wifi =3D g_supplicant_interface_get_data(interface);=0A=
+ =A0 identifier =3D g_supplicant_peer_get_identifier(peer);=0A=
+=0A=
+ =A0 DBG("identifier %s", identifier);=0A=
+=0A=
+ =A0 connman_network =3D connman_device_get_network(wifi->device, identifi=
er);=0A=
+ =A0 if (!connman_network)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 //wfds_on_p2p_pin_response(connman_network, NULL);=0A=
+}=0A=
+=0A=
+static void p2p_prov_disc_response_display_pin(GSupplicantInterface *inter=
face,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, const char *pi=
n)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi;=0A=
+ =A0 const char *identifier;=0A=
+ =A0 struct connman_network *connman_network;=0A=
+=0A=
+ =A0 wifi =3D g_supplicant_interface_get_data(interface);=0A=
+ =A0 identifier =3D g_supplicant_peer_get_identifier(peer);=0A=
+=0A=
+ =A0 DBG("identifier %s", identifier);=0A=
+=0A=
+ =A0 connman_network =3D connman_device_get_network(wifi->device, identifi=
er);=0A=
+ =A0 if (!connman_network)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 //wfds_on_p2p_pin_response(connman_network, pin);=0A=
+}=0A=
+=0A=
+static void p2p_prov_disc_fail(GSupplicantInterface *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, const char * s=
tatus)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi;=0A=
+ =A0 const char *identifier;=0A=
+ =A0 struct connman_network *connman_network;=0A=
+=0A=
+ =A0 wifi =3D g_supplicant_interface_get_data(interface);=0A=
+ =A0 identifier =3D g_supplicant_peer_get_identifier(peer);=0A=
+=0A=
+ =A0 DBG("identifier %s", identifier);=0A=
+=0A=
+ =A0 connman_network =3D connman_device_get_network(wifi->device, identifi=
er);=0A=
+ =A0 if (!connman_network)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 //wfds_on_p2p_prov_failed(connman_network, status);=0A=
+}=0A=
+=0A=
+=0A=
=A0static const GSupplicantCallbacks callbacks =3D {=0A=
=A0 =A0 .system_ready =A0 =A0 =A0 =3D system_ready,=0A=
=A0 =A0 .system_killed =A0 =A0 =A0=3D system_killed,=0A=
@@ -3704,6 +4105,12 @@ static const GSupplicantCallbacks callbacks =3D {=0A=
=A0 =A0 .p2p_group_finished =3D p2p_group_finished,=0A=
=A0 =A0 .p2p_invitation_result =3D p2p_invitation_result,=0A=
=A0 =A0 .p2p_invitation_received =3D p2p_invitation_received,=0A=
+ =A0 .p2p_prov_disc_requested_pbc =3D p2p_prov_disc_requested_pbc,=0A=
+ =A0 .p2p_prov_disc_requested_enter_pin =3D p2p_prov_disc_requested_enter_=
pin,=0A=
+ =A0 .p2p_prov_disc_requested_display_pin =3D p2p_prov_disc_requested_disp=
lay_pin,=0A=
+ =A0 .p2p_prov_disc_response_enter_pin =3D p2p_prov_disc_response_enter_pi=
n,=0A=
+ =A0 .p2p_prov_disc_response_display_pin =3D p2p_prov_disc_response_displa=
y_pin,=0A=
+ =A0 .p2p_prov_disc_fail =3D p2p_prov_disc_fail,=0A=
=A0};=0A=
=A0=0A=
=A0static int tech_probe(struct connman_technology *technology)=0A=
@@ -4104,12 +4511,16 @@ static void wifi_exit(void)=0A=
=A0 =A0 connman_network_driver_unregister(&network_driver);=0A=
=A0}=0A=
=A0=0A=
-static int p2p_enter_listen_state(GSupplicantInterface *interface)=0A=
+static int p2p_enter_listen_state(GSupplicantInterface *interface, bool en=
able)=0A=
=A0{=0A=
- =A0 GSupplicantP2PExtendedListenParams params =3D {=0A=
- =A0 =A0 =A0 .period =3D 50, =A0 =A0 =A0// ms=0A=
- =A0 =A0 =A0 .interval =3D 100 =A0 =A0// ms=0A=
- =A0 };=0A=
+ =A0 GSupplicantP2PExtendedListenParams params;=0A=
+ =A0 if (enable) {=0A=
+ =A0 =A0 =A0 params.period =3D 50; =A0 =A0// ms=0A=
+ =A0 =A0 =A0 params.interval =3D 100; =A0 =A0// ms=0A=
+ =A0 }else {=0A=
+ =A0 =A0 =A0 params.period =3D 0; =A0 =A0 =A0// ms=0A=
+ =A0 =A0 =A0 params.interval =3D 0; =A0 =A0// ms=0A=
+ =A0 }=0A=
=A0=0A=
=A0 =A0 return g_supplicant_interface_p2p_extended_listen(interface, &param=
s, NULL, NULL);=0A=
=A0}=0A=
@@ -4129,7 +4540,15 @@ static int tech_set_p2p_listen(struct connman_techno=
logy *technology, bool enabl=0A=
=A0 =A0 =A0 =A0 =A0 =A0 continue;=0A=
=A0=0A=
=A0 =A0 =A0 =A0 if (wifi->interface){=0A=
- =A0 =A0 =A0 =A0 =A0 err =3D p2p_enter_listen_state(wifi->interface);=0A=
+ =A0 =A0 =A0 =A0 =A0 if (enable) {=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D p2p_enter_listen_state(wifi->interfac=
e,true);=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 connman_technology_set_p2p_listen(tec=
hnology, true);=0A=
+ =A0 =A0 =A0 =A0 =A0 }else {=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D p2p_enter_listen_state(wifi->interfac=
e,false);=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 connman_technology_set_p2p_listen(tec=
hnology, false);=0A=
+ =A0 =A0 =A0 =A0 =A0 }=0A=
=A0 =A0 =A0 =A0 =A0 =A0 return err;=0A=
=A0 =A0 =A0 =A0 }=0A=
=A0 =A0 }=0A=
diff --git a/src/connman-dbus.conf b/src/connman-dbus.conf=0A=
index 24e2fbc..4ce570d 100644=0A=
--- a/src/connman-dbus.conf=0A=
+++ b/src/connman-dbus.conf=0A=
@@ -10,6 +10,7 @@=0A=
=A0 =A0 =A0 =A0 =A0<allow send_interface=3D"net.connman.Manager"/>=0A=
=A0 =A0 =A0 =A0 =A0<allow send_interface=3D"net.connman.Service"/>=0A=
=A0 =A0 =A0 =A0 =A0<allow send_interface=3D"net.connman.Technology"/>=0A=
+ =A0 =A0 =A0 =A0<allow send_interface=3D"net.connman.Peer"/>=0A=
=A0 =A0 =A0 =A0 =A0<allow send_interface=3D"org.freedesktop.DBus.Properties=
"/>=0A=
=A0 =A0 =A0</policy>=0A=
=A0 =A0 =A0<policy at_console=3D"true">=0A=
diff --git a/src/peer.c b/src/peer.c=0A=
index e81a038..672b4b8 100644=0A=
--- a/src/peer.c=0A=
+++ b/src/peer.c=0A=
@@ -628,9 +628,8 @@ static int peer_connect(struct connman_peer *peer)=0A=
=A0=0A=
=A0 =A0 if (peer_driver->connect){=0A=
=A0 =A0 =A0 =A0 if(!pin || strlen(pin)=3D=3D0){=0A=
- =A0 =A0 =A0 =A0 =A0 err =3D __connman_agent_request_peer_authorization(pe=
er,=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_authorization_cb, tru=
e,=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_dbus_sender(peer), NULL);=
=0A=
+ =A0 =A0 =A0 err =3D peer_driver->connect(peer,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_PEER_WPS_PBC, NULL);=0A=
=A0 =A0 =A0 =A0 }else{=0A=
=A0 =A0 =A0 =A0 err =3D peer_driver->connect(peer,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_PEER_WPS_PIN, pin);=0A=
diff --git a/src/technology.c b/src/technology.c=0A=
index fcb5f2b..e04c7ea 100644=0A=
--- a/src/technology.c=0A=
+++ b/src/technology.c=0A=
@@ -87,6 +87,8 @@ struct connman_technology {=0A=
=A0 =A0 bool dbus_registered;=0A=
=A0 =A0 bool p2p_listen;=0A=
=A0 =A0 char * wps_pin;=0A=
+ =A0 char *p2p_identifier;=0A=
+ =A0 bool p2p_persistent;=0A=
=A0};=0A=
=A0=0A=
=A0static GSList *driver_list =3D NULL;=0A=
@@ -659,6 +661,14 @@ static void append_properties(DBusMessageIter *iter,=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_BOOLEAN,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->p2p_listen);=0A=
=A0=0A=
+ =A0 if(technology->p2p_identifier)=0A=
+ =A0 =A0 =A0 connman_dbus_dict_append_basic(&dict, "P2PIdentifier",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->p2p_identifier);=0A=
+ =A0 val =3D technology->p2p_persistent;=0A=
+ =A0 connman_dbus_dict_append_basic(&dict, "P2PPersistent",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_BOOLEAN,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &val);=0A=
=A0 =A0 connman_dbus_dict_close(iter, &dict);=0A=
=A0}=0A=
=A0=0A=
@@ -1033,6 +1043,123 @@ static DBusMessage *set_p2p_listen(struct connman_t=
echnology *technology,=0A=
=A0 =A0 return reply;=0A=
=A0}=0A=
=A0=0A=
+static int set_p2p_identifier(struct connman_technology *technology,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 const char *p2p_identifier)=0A=
+{=0A=
+ =A0 int result =3D -EOPNOTSUPP;=0A=
+ =A0 int err =3D 0;=0A=
+ =A0 GSList *tech_drivers =3D NULL;=0A=
+=0A=
+ =A0 if (technology->type !=3D CONNMAN_SERVICE_TYPE_P2P)=0A=
+ =A0 =A0 =A0 return -EINVAL;=0A=
+=0A=
+ =A0 for (tech_drivers =3D technology->driver_list; tech_drivers;=0A=
+ =A0 =A0 =A0 =A0tech_drivers =3D g_slist_next(tech_drivers)) {=0A=
+ =A0 =A0 =A0 struct connman_technology_driver *driver =3D tech_drivers->da=
ta;=0A=
+=0A=
+ =A0 =A0 =A0 if (!driver || !driver->set_p2p_identifier)=0A=
+ =A0 =A0 =A0 =A0 =A0 continue;=0A=
+=0A=
+ =A0 =A0 =A0 err =3D driver->set_p2p_identifier(technology, p2p_identifier=
);=0A=
+=0A=
+ =A0 =A0 =A0 if (result =3D=3D -EINPROGRESS)=0A=
+ =A0 =A0 =A0 =A0 =A0 continue;=0A=
+=0A=
+ =A0 =A0 =A0 if (err =3D=3D -EINPROGRESS || err =3D=3D 0) {=0A=
+ =A0 =A0 =A0 =A0 =A0 result =3D err;=0A=
+ =A0 =A0 =A0 =A0 =A0 continue;=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 }=0A=
+=0A=
+ =A0 return result;=0A=
+}=0A=
+=0A=
+bool is_technology_enabled(struct connman_technology *technology)=0A=
+{=0A=
+ =A0 return technology =3D=3D NULL ? false : technology->enabled;=0A=
+}=0A=
+=0A=
+bool connman_technology_get_p2p_persistent(struct connman_technology *tech=
nology)=0A=
+{=0A=
+ =A0 return technology->p2p_persistent;=0A=
+}=0A=
+=0A=
+void connman_technology_set_p2p_persistent(struct connman_technology *tech=
nology, bool enabled)=0A=
+{=0A=
+ =A0 GSList *tech_drivers;=0A=
+ =A0 int err =3D 0;=0A=
+ =A0 dbus_bool_t persistent_enabled;=0A=
+=0A=
+ =A0 if (technology->p2p_persistent =3D=3D enabled)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 technology->p2p_persistent =3D enabled;=0A=
+=0A=
+ =A0 for (tech_drivers =3D technology->driver_list; tech_drivers !=3D NULL=
;=0A=
+ =A0 =A0 =A0 tech_drivers =3D g_slist_next(tech_drivers)) {=0A=
+ =A0 =A0 =A0 struct connman_technology_driver *driver =3D tech_drivers->da=
ta;=0A=
+=0A=
+ =A0 =A0 =A0 if (!driver || !driver->set_p2p_persistent)=0A=
+ =A0 =A0 =A0 =A0 =A0 continue;=0A=
+=0A=
+ =A0 =A0 =A0 err =3D driver->set_p2p_persistent(technology, enabled);=0A=
+ =A0 =A0 =A0 if (err < 0)=0A=
+ =A0 =A0 =A0 =A0 =A0 connman_error("Failed to set P2P persistent state");=
=0A=
+ =A0 }=0A=
+=0A=
+ =A0 persistent_enabled =3D technology->p2p_persistent;=0A=
+ =A0 connman_dbus_property_changed_basic(technology->path,=0A=
+ =A0 =A0 =A0 =A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 "P2PPersistent",=0A=
+ =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_BOOLEAN,=0A=
+ =A0 =A0 =A0 =A0 =A0 &persistent_enabled);=0A=
+}=0A=
+=0A=
+static DBusMessage *set_p2p_persistent(struct connman_technology *technolo=
gy,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 DBusMessage *msg, bool enabled)=0A=
+{=0A=
+ =A0 DBusMessage *reply =3D NULL;=0A=
+ =A0 int err =3D 0;=0A=
+ =A0 GSList *tech_drivers =3D NULL;=0A=
+ =A0 dbus_bool_t persistent_enabled;=0A=
+=0A=
+ =A0 __sync_synchronize();=0A=
+=0A=
+ =A0 if (technology->type !=3D CONNMAN_SERVICE_TYPE_P2P || !technology->en=
abled) {=0A=
+ =A0 =A0 =A0 err =3D -EOPNOTSUPP;=0A=
+ =A0 =A0 =A0 goto make_reply;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if(technology->p2p_persistent =3D=3D enabled)=0A=
+ =A0 =A0 =A0 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
+=0A=
+ =A0 technology->p2p_persistent =3D enabled;=0A=
+=0A=
+ =A0 for (tech_drivers =3D technology->driver_list; tech_drivers !=3D NULL=
;=0A=
+ =A0 =A0 =A0 =A0tech_drivers =3D g_slist_next(tech_drivers)) {=0A=
+ =A0 =A0 =A0 struct connman_technology_driver *driver =3D tech_drivers->da=
ta;=0A=
+=0A=
+ =A0 =A0 =A0 if (driver =3D=3D NULL || driver->set_p2p_persistent =3D=3D N=
ULL)=0A=
+ =A0 =A0 =A0 =A0 =A0 continue;=0A=
+=0A=
+ =A0 =A0 =A0 err =3D driver->set_p2p_persistent(technology, enabled);=0A=
+ =A0 }=0A=
+make_reply:=0A=
+ =A0 if (err < 0)=0A=
+ =A0 =A0 =A0 reply =3D __connman_error_failed(msg, -err);=0A=
+ =A0 else {=0A=
+ =A0 =A0 =A0 reply =3D g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
+=0A=
+ =A0 =A0 =A0 persistent_enabled =3D technology->p2p_persistent;=0A=
+ =A0 =A0 =A0 connman_dbus_property_changed_basic(technology->path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 "P2PPersistent",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_BOOLEAN,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 &persistent_enabled);=0A=
+ =A0 }=0A=
+=0A=
+ =A0 return reply;=0A=
+}=0A=
=A0=0A=
=A0static DBusMessage *set_property(DBusConnection *conn,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBusMessage *msg, void *data)=0A=
@@ -1254,7 +1381,34 @@ static DBusMessage *set_property(DBusConnection *con=
n,=0A=
=A0=0A=
=A0 =A0 if (err < 0)=0A=
=A0 =A0 =A0 =A0 return __connman_error_failed(msg, -err);=0A=
-}else=0A=
+} else if (g_str_equal(name, "P2PIdentifier")) {=0A=
+ =A0 =A0 =A0 int err;=0A=
+ =A0 =A0 =A0 const char *p2p_identifier;=0A=
+=0A=
+ =A0 =A0 =A0 if (type !=3D DBUS_TYPE_STRING)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&value, &p2p_identifier);=0A=
+=0A=
+ =A0 =A0 =A0 if(strlen(p2p_identifier) > 32)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 =A0 =A0 err =3D set_p2p_identifier(technology, p2p_identifier);=0A=
+ =A0 =A0 =A0 if (err < 0)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_failed(msg, -err);=0A=
+} else if (g_str_equal(name, "P2PPersistent")) {=0A=
+ =A0 =A0 =A0 bool enable;=0A=
+=0A=
+ =A0 =A0 =A0 if (type !=3D DBUS_TYPE_BOOLEAN)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 =A0 =A0 if (technology->type !=3D CONNMAN_SERVICE_TYPE_P2P)=0A=
+ =A0 =A0 =A0 =A0 =A0 return __connman_error_not_supported(msg);=0A=
+=0A=
+ =A0 =A0 =A0 dbus_message_iter_get_basic(&value, &enable);=0A=
+=0A=
+ =A0 =A0 =A0 return set_p2p_persistent(technology, msg, enable);=0A=
+} else=0A=
=A0 =A0 =A0 =A0 return __connman_error_invalid_property(msg);=0A=
=A0=0A=
=A0 =A0 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
@@ -1284,6 +1438,26 @@ static void reply_scan_pending(struct connman_techno=
logy *technology, int err)=0A=
=A0 =A0 }=0A=
=A0}=0A=
=A0=0A=
+void connman_technology_set_p2p_identifier(struct connman_technology *tech=
nology, const char *p2p_identifier)=0A=
+{=0A=
+=0A=
+ =A0 if (technology->p2p_identifier) {=0A=
+ =A0 =A0 =A0 g_free(technology->p2p_identifier);=0A=
+ =A0 =A0 =A0 technology->p2p_identifier =3D NULL;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if(p2p_identifier =3D=3D NULL)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 technology->p2p_identifier =3D g_strdup(p2p_identifier);=0A=
+=0A=
+ =A0 connman_dbus_property_changed_basic(technology->path,=0A=
+ =A0 =A0 =A0 =A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 "P2PIdentifier",=0A=
+ =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING,=0A=
+ =A0 =A0 =A0 =A0 =A0 &technology->p2p_identifier);=0A=
+}=0A=
+=0A=
=A0void __connman_technology_scan_started(struct connman_device *device)=0A=
=A0{=0A=
=A0 =A0 DBG("device %p", device);=0A=
@@ -1530,6 +1704,7 @@ static void technology_put(struct connman_technology =
*technology)=0A=
=A0 =A0 g_free(technology->tethering_ident);=0A=
=A0 =A0 g_free(technology->tethering_passphrase);=0A=
=A0 =A0 g_free(technology->tethering_ipaddress);=0A=
+ =A0 g_free(technology->p2p_identifier);=0A=
=A0 =A0 g_free(technology);=0A=
=A0}=0A=
=A0=0A=
=0A=
