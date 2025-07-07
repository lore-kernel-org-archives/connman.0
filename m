Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A68DDA9
	for <connman@lists.linux.dev>; Mon,  7 Jul 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871650; cv=fail; b=RcjE/t7wvXXqH3prB4BCfQcz6S6wjHU0Tkgv9e3WjPAqdKiVrvyw+zQwqr4lPtWHG/eV51J1mu6Qq4pjPYdj1xGWbogrSAohGfX1xU2uovl6Uj2xZk+5rrp34OowPYJjeZ0sB81LkZxA/nydX9By2a2VHdD2XtutcbxLepjdImI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871650; c=relaxed/simple;
	bh=fPT2Emc6BtAC22ZvntN4hbthkIPkH/XTSXIPU+UMhRI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oDJHLmZy79vFCr2vPoytsLyS+j28+70oQUnkNgeksRUv8vMtYcjILei3nYjpDuMe7Cs3hvwt6RAONONj20qFzR3cYLgxqgXgLfaqvZeFVEmkMCH/+NRZMRBesvnnvtXE6NbBhNg2VPE1zULz5RU0KovFOZxjh1FAxciD8WXUijY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.51 with ESMTP; 7 Jul 2025 16:00:38 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo5.lge.com) (165.244.66.186)
	by 156.147.1.127 with ESMTP; 7 Jul 2025 16:00:38 +0900
X-Original-SENDERIP: 165.244.66.186
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO PUWP216CU001.outbound.protection.outlook.com) (40.93.139.7)
	by 165.244.66.186 with ESMTP; 7 Jul 2025 16:06:15 +0900
X-Original-SENDERIP: 40.93.139.7
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V++gxNExCbpYoXoZhytKMlvBH2Uw1UwzK9Lel40nj6TRYRRtcjHoESlm7ZJ+PncHtrAu6WYTRAvrqO2Mi88tze2j4VFfh4u/lRot/KxfwK22fHx0g2fDyn1lY7pKjbZgqZi9hO6qQq3faeWWp3yFlfpvgmOXlM26hzA0OO0BNXeNENRYvP4d/r8iXPmV9rCa8cNZVJVNr80KI4xrV7c/CvpMQAsLIHSCmS18a+WZdL8Pr3OEJlU98mFN62TQ5K/Mt77TSChHm+YeuNCyEYUX4QjvozRnbLl5w2iYFiG6ufNiPQ9x2+ZJju0h5d3upU1/0a6Po/RJaDAfvRdgBPBKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPT2Emc6BtAC22ZvntN4hbthkIPkH/XTSXIPU+UMhRI=;
 b=nOeodiq8zSlLLbdSAcpY7k+TJLZ/nWPpabNHPkl8wR1hILrhY1nBGL7UjQLQB05MtvnQZY5EIcPURzb258F+WIsD+7EEBC/lRxn97So8RfKcTVQHl7VBuLeiSU0LSl/ssGQzHjKq4t2HYasiGk+JaAjSDRp4yo3ejs9xpAj6EGMVNUGN+Zj2mqutH5TeP5kVrDssUTWOgLPVFkGJo4ifvxJU/8j+jYtQQmxugNgZpltfTmfxaYPip9HbUlq6fDHbXsJ0PFpN76duBUJX8I8UeGCo5iy/90BhJolV8XPTLr1i0ZhOHDQqBz1sK4yh7V4P1zZUg5p7gsO4k1Q25nOOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by SE2P216MB2914.KORP216.PROD.OUTLOOK.COM (2603:1096:101:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 07:00:37 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:00:37 +0000
From: Shailesh Rathod/LGSI Connectivity Team <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject: [PATCH]  Connman : Add initial support for P2P listen mode in ConnMan
Thread-Topic: [PATCH]  Connman : Add initial support for P2P listen mode in
 ConnMan
Thread-Index: AQHb7wo13Wo4Sf2Uq0WxoaYY8K3UCg==
Date: Mon, 7 Jul 2025 07:00:37 +0000
Message-ID:
 <SE1P216MB264723B08F4D99FF50554FB3F04FA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|SE2P216MB2914:EE_
x-ms-office365-filtering-correlation-id: fa7d9f3f-ba92-473e-9591-08ddbd23fa31
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BpmL6qZQPhthr9USFJk8CVkpFJifQ3ONImF86zvxYReUmrOj1iJPiM3ZZR?=
 =?iso-8859-1?Q?ZVQllzUVw4yZBC0aO/Lzsbdz13CRZhiXMPTuNSRbiqjiuvVnAcYFY2p/B9?=
 =?iso-8859-1?Q?k8t19t6P9BfQ/77l5+otP5ZniM547KcMSNi5Z48IfaosVanLCT9/R5Bmx4?=
 =?iso-8859-1?Q?1wUEY79TakmAsA83IAOoQPB+2/PxIxsTjnaZVbPEJzxU2S4iILY3tysb92?=
 =?iso-8859-1?Q?rE7f7JXEdyl8UmDPDLt5g8F7xT13+2nRcqWc7BP0JK5omc/4p/dWPtUdro?=
 =?iso-8859-1?Q?82dzkapL874L3nkdsaqH2bsZgbABMzwMT5NfFm9ByeLcc2WLRcP/Y099An?=
 =?iso-8859-1?Q?WPF2YgrX1jlVa4/u+bDgAyD5TAJQlTzc9eYLYj6GKrGxO4HBzjoaxLAT7q?=
 =?iso-8859-1?Q?iVvVoB5uz+q+ItqvQu3Sve5WBXyHB67batV+QwyNyS1HTov84VTpnq/5pN?=
 =?iso-8859-1?Q?BffaIvOSlIIdhO9QH6/hMafUoEoOkI2lo5lZ1PYwItXjp5ZoWrR+pMcSHk?=
 =?iso-8859-1?Q?RmyEpIAH9dKC5xho4qZvEsO62p5roZx8kHXhSubj25lxnOlNO/kPsxGkAY?=
 =?iso-8859-1?Q?VnjojIxcv3Hc/za6D3UCZKasanmnnbQMosxFwBVTLtAzqdCGBevUDq55uC?=
 =?iso-8859-1?Q?MzCaP4agfqfkffu/ih8cAnBuAp7mnsczz1Dh2LTEuWYJCH0FKxf9CV8RqG?=
 =?iso-8859-1?Q?W26Sn+ubTMuD8gLCRfcmhMffwXiLLElNdDgZmkkbl93PZcrPeg3nltWsOF?=
 =?iso-8859-1?Q?6hc9hES66gpBayj7Gp41wqe0UiXOzdE9shdfwkhn/kJYg68AHjzx+W/35B?=
 =?iso-8859-1?Q?nrjARrBjvdfYkd9YHO/6Y43TdT+btsTyxjxT0BYj+bELVanc2w+tgKkPVR?=
 =?iso-8859-1?Q?3MuP5t3kQHU3Hk60zqONReiAF9Pe3XGxK4+2mIN0BbvWebnJoCE7JW3hR7?=
 =?iso-8859-1?Q?PfOoR30vXRY9O5EYZqjt1WE/jgl04iYYFNyXCFm82GRaaI2HP+YM2RLLsH?=
 =?iso-8859-1?Q?QhkkRzkEKS3xT+Fl2JP9CZk5OQOBJ8uO3Fwty2XKOVIW00xr00FMI2v95s?=
 =?iso-8859-1?Q?UxL0HQihqepFxw51U4tjJEHCcrEYRp5p9JTxfg6cWrhOFt5SHNYeafy2gz?=
 =?iso-8859-1?Q?HWCIu824jae4lxEzR7Rj5xdbfzHWCpa+jApv4kjqmkpcISwn0u9e8i2kLM?=
 =?iso-8859-1?Q?GuQzu+uk65NQr7mcE77pFM/dEs72Ts3LCKR7ODFTmI+I8YufRqCcC6qmpL?=
 =?iso-8859-1?Q?Ijz7qBCVyeTHIkKCiRQHOzJjxrQs8gO68BnXmzIdjb+CtVqjsrV3i3YEmP?=
 =?iso-8859-1?Q?G1ktMLG/rPlA4KJb6hr3sgnwp6L5ifayuu4mhI+XfIxHCPpxdUySbZEOWQ?=
 =?iso-8859-1?Q?kAt6rpLxXd6M8+kwDdxaSwnQBpxCro5k8eFBTtJLui8Bpq50xNc0fC3DJC?=
 =?iso-8859-1?Q?pB4UIX0MLNC2DYqncy4qQnnztF/viw8IkjtXCJsYzq7SOdebBFEej/iHEc?=
 =?iso-8859-1?Q?uCkOQsLMHRXPH9G6rTcQnJxWSKrN1uMSy5ZE8W0/FFGw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4TA11qoSoiNI5mU3aCODTu5NANvQq7zpaFE7ocZpiOQ320XN/4nPS33TpP?=
 =?iso-8859-1?Q?0qb/leHK4bQfwJF7rw+FCYVG9qcXRHFclTBnTMOnGGu/8zmGvKlXWvHfVz?=
 =?iso-8859-1?Q?qSVw3PtbgQGBebJ8ZjqfKUXTUpNzTpexa48FLGNI2Jcu+OSW7b9UsFeCNb?=
 =?iso-8859-1?Q?uK2Qhaq9pYdBdGZa8xDqb+CYzLcHxDvkS3ZOUZbA75FBwHe5prRPuuKbSt?=
 =?iso-8859-1?Q?j3+VJ8TGRoQfCYsAHcdp+pTyNoZYa2MP363md2Z8dboP5+PPy7DD4AUj0z?=
 =?iso-8859-1?Q?TWhtzi6QRduXSQ8vl9RiSFmqWfpDrcaz0HqlFSX+d2kf1N4X2QFczTUxbx?=
 =?iso-8859-1?Q?exjEBjXfP56wqybhMduSMRJ+EeN43GZamAx2xfhgXiWQTHEKTRnWDacFpE?=
 =?iso-8859-1?Q?cuW40nKsQObMoWgsZ0iMD+r+Z052rNGxhnJsmBuJOI4dDZXMf9K5zKHeuE?=
 =?iso-8859-1?Q?Wu8/iYxd4jtrj9NBXvQwq8EeleCWN4bhgDWWSMkN1U2h41PZRX9Cn2oPKl?=
 =?iso-8859-1?Q?ghf650HIg8eXann6kmKLhCh91Jb4gFCzItLh33NOrzK1Me3b3DyE6E1Zb3?=
 =?iso-8859-1?Q?zDfbDgw+Sel2MHtoSvHE8NRA1b60hT7zJmwXPxqd6hLB7Z2vkTKS9ymm2q?=
 =?iso-8859-1?Q?2t8SpVlrAhHHzaLsyks2RltC8H9/xVFUJi6nqyMvi2lM0euRft8eZseZnY?=
 =?iso-8859-1?Q?VYkPOiQG0lWqLwotOXVd8XfCK+TZ2F86qEaFhoc7XK3QLGUnNuu4JIC5sI?=
 =?iso-8859-1?Q?bNQbA4tCbmKXRuEfXMJWvPKGFhAywkDPdEt9VtUPtgJQ7vgEXFe4w0NpI/?=
 =?iso-8859-1?Q?7IrdqbsiGNp67muJpq+CcfRg/aYRrpkAvaw4O2+KmY2KFtq58c1y7HA9hH?=
 =?iso-8859-1?Q?C7ZU9TzCMtfMQ02aUt6RvKsmYMO/18iljYGsjtf9P8J+BWTDnDFRs6BP1L?=
 =?iso-8859-1?Q?R68+wPDbc9VEmHVenKxeN9xYhs64i0I/M0cRQHRzPuNJl7V8oR10GdRdT8?=
 =?iso-8859-1?Q?PfxTh5yxnqy+I+u5IlBWAYQ8C7zyWMJ5jTlIlLWDLtCC7w2NGzKkWcjMZ6?=
 =?iso-8859-1?Q?PfkuVFVU+kw5qDXmtE6jyMf6b18POQeiJZYLpT8GhYttCklNH7lZRg1UiW?=
 =?iso-8859-1?Q?e9Ah/0DCVui9RrFRSa+2wJC6Ym99nDr8Qb8CKXScMB3xAtIctXWLpeNek7?=
 =?iso-8859-1?Q?Qy3bNUHOtJJ5Qe7HmHZ5QZLRc3fZ2+RBOjTsXhguYS0+V/im6p/CKHBZQk?=
 =?iso-8859-1?Q?6/Or5LyOIaNHZb6ptzU6qReoAw4vxPWbXRQKKwvmqL+sxjgZ52xB3zuA3T?=
 =?iso-8859-1?Q?u33PZJ4RgxNcJSt5V8l38Y5jt5YeVvm5PI1nqVyokE30PyF5suPdXrWIoa?=
 =?iso-8859-1?Q?OC+Tc0JXuw2dgRkVp9TAXbwlTLTuEzr1onGAcc7jx+d2rTvo9/MML90bwT?=
 =?iso-8859-1?Q?7r3nyv1GP5L8nv+0RkS9cWzx1kM2SHNutBG3ZdKBoAgrSyjXLdC2inhSyk?=
 =?iso-8859-1?Q?5K0r6x7Tp7d71bPnPv/t1cASc59EnT3sbjptUOxIlDNUjFSt33e/oRjZ0p?=
 =?iso-8859-1?Q?sEKkyWs+qa9gacpOJlj9okEdMfPMeyQULxjfvg+Vl4sngZmg3GB/BDOLHD?=
 =?iso-8859-1?Q?xtJ+lhpkLMe8ik8ywXvrMEx9yx4q6oyw8W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7d9f3f-ba92-473e-9591-08ddbd23fa31
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 07:00:37.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbO2kCKxbTNGkeQesnChPXQhRASHCpW9FVVak4+qhrJmW7VM6cTLErfvo/UbEGbqkZ3Z4bR6tPmuJPKp8B0fBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2914

From c8dafb2ffcd7f68b0e68725838095b755e5139d3 Mon Sep 17 00:00:00 2001=0A=
From: shailesh rathod <shailesh.rathod@lge.com>=0A=
Date: Fri, 30 May 2025 14:19:57 +0900=0A=
Subject: [PATCH] Add initial support for P2P listen mode in ConnMan=0A=
=0A=
- Introduce P2P listen functionality for Wi-Fi Direct (P2P) via new D-Bus=
=0A=
=A0 property "P2PListen" on the technology interface.=0A=
- Add technology driver callback set_p2p_listen and implement it in the WiF=
i plugin.=0A=
- Implement GSupplicantP2PExtendedListenParams and related API to trigger t=
he=0A=
=A0 ExtendedListen method in wpa_supplicant.=0A=
- Update technology and wifi plugin logic to handle enabling/disabling P2P =
listen state.=0A=
- Expose the P2PListen property in D-Bus technology properties and allow it=
 to be set via D-Bus.=0A=
- Ensure proper error handling and state management for repeated or unsuppo=
rted requests.=0A=
---=0A=
=A0gsupplicant/gsupplicant.h | 12 +++++++=0A=
=A0gsupplicant/supplicant.c =A0| 29 +++++++++++++++=0A=
=A0include/technology.h =A0 =A0 =A0| =A01 +=0A=
=A0plugins/wifi.c =A0 =A0 =A0 =A0 =A0 =A0| 35 ++++++++++++++++++=0A=
=A0src/technology.c =A0 =A0 =A0 =A0 =A0| 74 +++++++++++++++++++++++++++++++=
+++++++-=0A=
=A05 files changed, 150 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/gsupplicant/gsupplicant.h b/gsupplicant/gsupplicant.h=0A=
index eab6293..77c2d46 100644=0A=
--- a/gsupplicant/gsupplicant.h=0A=
+++ b/gsupplicant/gsupplicant.h=0A=
@@ -312,6 +312,18 @@ GSupplicantPeer *g_supplicant_interface_peer_lookup(GS=
upplicantInterface *interf=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *identifier);=0A=
=A0bool g_supplicant_interface_is_p2p_finding(GSupplicantInterface *interfa=
ce);=0A=
=A0=0A=
+struct _GSupplicantP2PExtendedListenParams {=0A=
+ =A0 int period;=0A=
+ =A0 int interval;=0A=
+};=0A=
+=0A=
+typedef struct _GSupplicantP2PExtendedListenParams GSupplicantP2PExtendedL=
istenParams;=0A=
+=0A=
+int g_supplicant_interface_p2p_extended_listen(GSupplicantInterface *inter=
face,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantP2PExtendedListenParams *ext=
ended_listen_data,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantInterfaceCallback callback,=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user_data);=0A=
+=0A=
=A0/* Network and Peer API */=0A=
=A0struct _GSupplicantNetwork;=0A=
=A0struct _GSupplicantGroup;=0A=
diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c=0A=
index f3be9e7..7facfe8 100644=0A=
--- a/gsupplicant/supplicant.c=0A=
+++ b/gsupplicant/supplicant.c=0A=
@@ -4009,6 +4009,35 @@ done:=0A=
=A0 =A0 interface_create_data_free(data);=0A=
=A0}=0A=
=A0=0A=
+static void extended_listen_append_args(DBusMessageIter *iter, GSupplicant=
P2PExtendedListenParams *params)=0A=
+{=0A=
+ =A0 //struct GSupplicantP2PExtendedListenParams *params =3D user_data;=0A=
+ =A0 DBusMessageIter dict;=0A=
+=0A=
+ =A0 supplicant_dbus_dict_open(iter, &dict);=0A=
+ =A0 if (params) {=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "period", DBUS_TYPE_=
INT32, &params->period);=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "interval", DBUS_TYP=
E_INT32, &params->interval);=0A=
+ =A0 }=0A=
+ =A0 supplicant_dbus_dict_close(iter, &dict);=0A=
+}=0A=
+int g_supplicant_interface_p2p_extended_listen(GSupplicantInterface *inter=
face,=0A=
+ =A0 GSupplicantP2PExtendedListenParams *params,=0A=
+ =A0 GSupplicantInterfaceCallback callback,=0A=
+ =A0 void *user_data)=0A=
+{=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return -EINVAL;=0A=
+=0A=
+=0A=
+return supplicant_dbus_method_call(interface->path,=0A=
+ =A0 =A0 =A0 SUPPLICANT_INTERFACE ".Interface.P2PDevice",=0A=
+ =A0 =A0 =A0 "ExtendedListen",=0A=
+ =A0 =A0 =A0 extended_listen_append_args,=0A=
+ =A0 =A0 =A0 NULL, =A0// or NULL if no reply handler needed=0A=
+ =A0 =A0 =A0 params,=0A=
+ =A0 =A0 =A0 NULL);=0A=
+}=0A=
=A0static void interface_create_params(DBusMessageIter *iter, void *user_da=
ta)=0A=
=A0{=0A=
=A0 =A0 struct interface_create_data *data =3D user_data;=0A=
diff --git a/include/technology.h b/include/technology.h=0A=
index fcd658e..fd7b87a 100644=0A=
--- a/include/technology.h=0A=
+++ b/include/technology.h=0A=
@@ -65,6 +65,7 @@ struct connman_technology_driver {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *bridge, bool enabled);=0A=
=A0 =A0 int (*set_regdom) (struct connman_technology *technology,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *alpha2);=0A=
+ =A0 int (*set_p2p_listen) (struct connman_technology *technology, bool en=
able);=0A=
=A0};=0A=
=A0=0A=
=A0int connman_technology_driver_register(struct connman_technology_driver =
*driver);=0A=
diff --git a/plugins/wifi.c b/plugins/wifi.c=0A=
index 12389fa..cbfcf5d 100644=0A=
--- a/plugins/wifi.c=0A=
+++ b/plugins/wifi.c=0A=
@@ -184,6 +184,7 @@ static bool wfd_service_registered =3D false;=0A=
=A0static void start_autoscan(struct connman_device *device);=0A=
=A0static int tech_set_tethering(struct connman_technology *technology,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *bridge, bool enabled);=0A=
+static int tech_set_p2p_listen(struct connman_technology *technology, bool=
 enable);=0A=
=A0=0A=
=A0static int p2p_tech_probe(struct connman_technology *technology)=0A=
=A0{=0A=
@@ -3663,6 +3664,7 @@ static struct connman_technology_driver tech_driver =
=3D {=0A=
=A0 =A0 .remove =A0 =A0 =3D tech_remove,=0A=
=A0 =A0 .set_tethering =A0=3D tech_set_tethering,=0A=
=A0 =A0 .set_regdom =3D tech_set_regdom,=0A=
+ =A0 .set_p2p_listen =3D tech_set_p2p_listen,=0A=
=A0};=0A=
=A0=0A=
=A0static int wifi_init(void)=0A=
@@ -3700,5 +3702,38 @@ static void wifi_exit(void)=0A=
=A0 =A0 connman_network_driver_unregister(&network_driver);=0A=
=A0}=0A=
=A0=0A=
+static int p2p_enter_listen_state(GSupplicantInterface *interface)=0A=
+{=0A=
+ =A0 GSupplicantP2PExtendedListenParams params =3D {=0A=
+ =A0 =A0 =A0 .period =3D 50, =A0 =A0 =A0// ms=0A=
+ =A0 =A0 =A0 .interval =3D 100 =A0 =A0// ms=0A=
+ =A0 };=0A=
+=0A=
+ =A0 return g_supplicant_interface_p2p_extended_listen(interface, &params,=
 NULL, NULL);=0A=
+}=0A=
+=0A=
+static int tech_set_p2p_listen(struct connman_technology *technology, bool=
 enable)=0A=
+{=0A=
+ =A0 GList *list;=0A=
+ =A0 struct wifi_data *wifi =3D NULL;=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+ =A0 int err;=0A=
+=0A=
+ =A0 for (list =3D iface_list; list; list =3D list->next) {=0A=
+ =A0 =A0 =A0 wifi =3D list->data;=0A=
+ =A0 =A0 =A0 interface =3D wifi->interface;=0A=
+=0A=
+ =A0 =A0 =A0 if (interface =3D=3D NULL)=0A=
+ =A0 =A0 =A0 =A0 =A0 continue;=0A=
+=0A=
+ =A0 =A0 =A0 if (wifi->interface){=0A=
+ =A0 =A0 =A0 =A0 =A0 err =3D p2p_enter_listen_state(wifi->interface);=0A=
+ =A0 =A0 =A0 =A0 =A0 return err;=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 }=0A=
+=0A=
+ =A0 return -EOPNOTSUPP;=0A=
+}=0A=
+=0A=
=A0CONNMAN_PLUGIN_DEFINE(wifi, "WiFi interface plugin", VERSION,=0A=
=A0 =A0 =A0 =A0 CONNMAN_PLUGIN_PRIORITY_DEFAULT, wifi_init, wifi_exit)=0A=
diff --git a/src/technology.c b/src/technology.c=0A=
index 1bcd184..3f3b022 100644=0A=
--- a/src/technology.c=0A=
+++ b/src/technology.c=0A=
@@ -85,6 +85,7 @@ struct connman_technology {=0A=
=A0 =A0 bool softblocked;=0A=
=A0 =A0 bool hardblocked;=0A=
=A0 =A0 bool dbus_registered;=0A=
+ =A0 bool p2p_listen;=0A=
=A0};=0A=
=A0=0A=
=A0static GSList *driver_list =3D NULL;=0A=
@@ -647,6 +648,10 @@ static void append_properties(DBusMessageIter *iter,=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_INT32,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->tethering_freq);=0A=
=A0=0A=
+ =A0 =A0connman_dbus_dict_append_basic(&dict, "P2PListen",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_BOOLEAN,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &technology->p2p_listen);=0A=
+=0A=
=A0 =A0 connman_dbus_dict_close(iter, &dict);=0A=
=A0}=0A=
=A0=0A=
@@ -957,6 +962,61 @@ make_reply:=0A=
=A0 =A0 return reply;=0A=
=A0}=0A=
=A0=0A=
+static DBusMessage *set_p2p_listen(struct connman_technology *technology,=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBusM=
essage *msg, bool enable)=0A=
+{=0A=
+ =A0 DBusMessage *reply =3D NULL;=0A=
+ =A0 int err =3D 0;=0A=
+ =A0 GSList *tech_drivers;=0A=
+=0A=
+ =A0 __sync_synchronize();=0A=
+ =A0 if (technology->enabled =3D=3D FALSE) {=0A=
+ =A0 =A0 =A0 err =3D -EOPNOTSUPP;=0A=
+ =A0 =A0 =A0 goto make_reply;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (technology->type !=3D CONNMAN_SERVICE_TYPE_WIFI) {=0A=
+ =A0 =A0 =A0 err =3D -EOPNOTSUPP;=0A=
+ =A0 =A0 =A0 goto make_reply;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (technology->p2p_listen =3D=3D enable) {=0A=
+ =A0 =A0 =A0 err =3D -EALREADY;=0A=
+ =A0 =A0 =A0 goto make_reply;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 for (tech_drivers =3D technology->driver_list; tech_drivers !=3D NULL=
;=0A=
+ =A0 =A0 =A0 =A0 =A0 tech_drivers =3D g_slist_next(tech_drivers)) {=0A=
+ =A0 =A0 =A0 struct connman_technology_driver *driver =3D tech_drivers->da=
ta;=0A=
+=0A=
+ =A0 =A0 =A0 if (driver =3D=3D NULL || driver->set_p2p_listen =3D=3D NULL)=
=0A=
+ =A0 =A0 =A0 =A0 =A0 continue;=0A=
+=0A=
+ =A0 =A0 =A0 err =3D driver->set_p2p_listen(technology, enable);=0A=
+ =A0 =A0 =A0 if (err < 0)=0A=
+ =A0 =A0 =A0 =A0 =A0 break;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (err >=3D 0)=0A=
+ =A0 =A0 =A0 technology->p2p_listen =3D enable;=0A=
+=0A=
+ =A0 make_reply:=0A=
+ =A0 if (err =3D=3D -EINPROGRESS)=0A=
+ =A0 =A0 =A0 reply =3D g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
+ =A0 else if (err =3D=3D -EALREADY) {=0A=
+ =A0 =A0 =A0 if (enable =3D=3D TRUE)=0A=
+ =A0 =A0 =A0 =A0 =A0 reply =3D __connman_error_already_enabled(msg);=0A=
+ =A0 =A0 =A0 else=0A=
+ =A0 =A0 =A0 =A0 =A0 reply =3D __connman_error_already_disabled(msg);=0A=
+ =A0 } else if (err < 0)=0A=
+ =A0 =A0 =A0 reply =3D __connman_error_failed(msg, -err);=0A=
+ =A0 else=0A=
+ =A0 =A0 =A0 reply =3D g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
+=0A=
+ =A0 return reply;=0A=
+}=0A=
+=0A=
+=0A=
=A0static DBusMessage *set_property(DBusConnection *conn,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBusMessage *msg, void *data)=0A=
=A0{=0A=
@@ -1148,7 +1208,19 @@ static DBusMessage *set_property(DBusConnection *con=
n,=0A=
=A0 =A0 =A0 =A0 dbus_message_iter_get_basic(&value, &enable);=0A=
=A0=0A=
=A0 =A0 =A0 =A0 return set_powered(technology, msg, enable);=0A=
- =A0 } else=0A=
+ =A0 } else if (g_str_equal(name, "P2PListen") =3D=3D TRUE) {=0A=
+ =A0 bool enable;=0A=
+=0A=
+ =A0 if (type !=3D DBUS_TYPE_BOOLEAN)=0A=
+ =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 if (technology->type !=3D CONNMAN_SERVICE_TYPE_WIFI)=0A=
+ =A0 =A0 =A0 return __connman_error_not_supported(msg);=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&value, &enable);=0A=
+=0A=
+ =A0 return set_p2p_listen(technology, msg, enable);=0A=
+} else=0A=
=A0 =A0 =A0 =A0 return __connman_error_invalid_property(msg);=0A=
=A0=0A=
=A0 =A0 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
=0A=
