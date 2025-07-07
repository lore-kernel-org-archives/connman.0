Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90427E7EB
	for <connman@lists.linux.dev>; Mon,  7 Jul 2025 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872403; cv=fail; b=ZhQWKTLD2KvjPWZidClOGkGP+AfTTEu+N3mQfnAPHRyfkyMxAcAmUAEevhM4us+IhLxuiX6+Yv0L2UwDIoyazwHoGw3TkDZefmTp0vHYUEusRAKsSQGH9dC6BszvF5ygQwjV/EofkyOps/VJl0iJq7mywZ1PGRoRQGxpAeXDNqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872403; c=relaxed/simple;
	bh=V9Ha5+VHJml90OCQDkY8A9qSKoZoir2Ccu1t37YHz00=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dYvbqxWRsfjWNJrQEOMrNCJoEnU2yuh6gcPMXXpcBMDnh/wL7wQRiLE1r+5h9c7IoNnemX0WZqVhAcQVF1vc8WaAf6MXG6Il47XbllE5PgXYne+BWDqDH0iyajQa4renHAiYowDeYmqVI+p2Ao0myoZPhAFjZaRrzrEk0XMa4Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.51 with ESMTP; 7 Jul 2025 16:13:15 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo2.lge.com) (165.244.66.182)
	by 156.147.1.125 with ESMTP; 7 Jul 2025 16:13:15 +0900
X-Original-SENDERIP: 165.244.66.182
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO SE2P216CU007.outbound.protection.outlook.com) (40.93.138.31)
	by 165.244.66.182 with ESMTP; 7 Jul 2025 16:17:08 +0900
X-Original-SENDERIP: 40.93.138.31
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie/HFmR2SP73LAC0z+YqGQV5sm5+lZ63XmhMYUkCIriaXq3773OVRA9KIoTJUeXODPSmGQquN6X9KUTVvnFHAi6A2nBLJ2gtQL7Q6AjmVYdvS9gDeequHX3s3xC3oH+IkBl9fRbOi7Ipp1ZzQqAoR0glWxGlCjknEcyae7jsFIuisvn1IBYhxEG/wmJq8S5mu2JNB4zB7+g8Ms2q4I7AURmtcV5xA02Nzihs4Zak/+PyfSaK98DwaVf3W3fnVb6j8bbczDoNsjks2ly1O93Z/3hxAIsxKt4qYFnMTJWWEWgek8qirmHsscxLH+zVDsPlSMVu7D+h+5mjSkQWy1inrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9Ha5+VHJml90OCQDkY8A9qSKoZoir2Ccu1t37YHz00=;
 b=HpmkEXjOQnwMiyAT8Fg5T5hu2H/vgB/HHxE+Gym5QtJKWeplhLE1YajZJsyon/vgdrJjmsg0+KHVB1LGGjSdRv3TP/tAo+4G7laVNkAVyBd2lyJ3KoOQazvN4JnLn2qXOKQTJbVabESJF+9dBI8YGWpmQlHgqSzYkKB7Ahd1dPd1qUBlqa8UKiF+vfDnnFYMHbFiccQc9p7rGVf9O3Uo8nFWGFnW9kquG25iJ/ei2PaX8nYBVfjbYamwod9UFv3r3wDZsjWqjRWIW3LlbvuQYK5d61MrnqfI12dw9H3Gkojuz7jvNMHeQ6Zn59p3I+1BePDPs0lX4V0Skyx7WZ0iGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by SE2P216MB1969.KORP216.PROD.OUTLOOK.COM (2603:1096:101:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 07:13:13 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:13:13 +0000
From: Shailesh Rathod/LGSI Connectivity Team <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject: [PATCH] Connman : Initial P2P Invite and P2P Scan Implementation
Thread-Topic: [PATCH] Connman : Initial P2P Invite and P2P Scan Implementation
Thread-Index: AQHb7w6C5sTEUMErbEmyQCGP2Z2drQ==
Date: Mon, 7 Jul 2025 07:13:13 +0000
Message-ID:
 <SE1P216MB2647D406E36999304E431A80F04FA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|SE2P216MB1969:EE_
x-ms-office365-filtering-correlation-id: 66b81a9a-73be-48c5-494a-08ddbd25bcc5
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?645faaxdzRkG+5vG0tsfY5UFZh6myBfjTNr+xSu1AjxtDMKGLa/ikxgLfO?=
 =?iso-8859-1?Q?cNw/LUxukKd+gFM1rLhx4d9ZW7RD1Im8mQL4BnD2OGCoASfNWfFswEYfQX?=
 =?iso-8859-1?Q?pYSQRoguHVmBH68DMZ6IkDuA4LSLwfzvujDPXG1SDt3sC0ZhDv9H4/UKRz?=
 =?iso-8859-1?Q?7mgbMS2xp8p9vlfcEAh1WANW+uX+CWNuVUHw4wfqqOpgcxd3knoLRF2iE0?=
 =?iso-8859-1?Q?IlLX/67Hd0bWtsPLdQKqmYMSnDSC4JnKBAnAm/jhKGDlt8DPbRt7Ha0/OR?=
 =?iso-8859-1?Q?idmR2ky2eBsOR2WE0ueXWVr+lKjvHuUubbkUHX89F2hetmtlzM+NIVR07h?=
 =?iso-8859-1?Q?YKGCLc8h7HkOmeSPlBfU4nx0r3Q/d0vyY1XZ8/tSU3pbWnJ76NOitNetgq?=
 =?iso-8859-1?Q?8FzkLK7Dq4JW+sAMjxfVX7SJ2Jnli59GRmbhDgO/NLE2sZCLgtWR75g3/z?=
 =?iso-8859-1?Q?WG0vgNgq/Ch4wUF1N7rLNHVV+oAacwoFV3aB6FOk8E79UPs0/OzyRqKEiR?=
 =?iso-8859-1?Q?hqCa5COlDtlvWip/EDHjEv+DaZ4SwKaGZSx3iJ2tKdfTXrPJ+wYlxwhDcd?=
 =?iso-8859-1?Q?+mMh751yz43hbbVNHcAq2Lo8cuZql+z379k6Lepmu9Ayi0n/QrwlAVra7R?=
 =?iso-8859-1?Q?yaGklT2aMab1OOtRbeG1e5waIGR4vyrqtE2o00wPxfE65AWAtElACD1Nh0?=
 =?iso-8859-1?Q?zxPdJJQ/wRvX3x3agosFtMxrwbXQ5qX3qVw+QLUSd1PR9haInRbIECbNNa?=
 =?iso-8859-1?Q?UpiiMdxOgm1w89itnAe18otckzx1f0SsKjxmV/6FV4YO1ezA6NLxycNreW?=
 =?iso-8859-1?Q?0FsliCH9ARPee+EMZi4lJoojeLiZHnUp86EW0Cbq/h/IPFywxpkNMLeKV5?=
 =?iso-8859-1?Q?KxLN6aeyBHq3W6hRgF+4k1fCHPfykKZFj7PwLVC7H8TtcEE0PZDsb9Fjao?=
 =?iso-8859-1?Q?yZkZWYrufm8B2d3LV4HhrcicurZ767vEitgXSbFQoELemR8dQiaZM68JEG?=
 =?iso-8859-1?Q?uQNwxpv83YoJDDB+XU4Bizm+X3I0ysTvSxPF2cvDnb3llCIDNBR3rx4LW1?=
 =?iso-8859-1?Q?1LISASt/saoVizdfgEtS0Irddw5giSh6NsAFT1VesCxgYm4/ZHa1weqMM/?=
 =?iso-8859-1?Q?oFoMCQfXBdDPBhrI8pPQ39jyWlGGiqPLnEa+bm2pEMnqHLONHhKRVXsJxo?=
 =?iso-8859-1?Q?WqE7BgH8APA6at7rhokWpWEMo2lQCQaL1CT82inrUaqXBfXJy5e3I/y74H?=
 =?iso-8859-1?Q?dVkl9omOyvKZbQDViWZkGbIClnVdJEAQF4GlhMBUmRBOLl9lOjG986OI44?=
 =?iso-8859-1?Q?VXJ6kMHkKb/mHURNbOWn81cAI7+AKix/8bdoYj1LPHd8djs8d0bvoqt+02?=
 =?iso-8859-1?Q?uAoG/P1ahUlCbWImXQREclrVCsskbmspmmtbB7u67ptVclNDv5Q3BnknYO?=
 =?iso-8859-1?Q?S61FMY5X9fQ8ceADuHzyWUCpviqpgftSPg4Ynn5J5Ie89FcJw2vUWKxtVT?=
 =?iso-8859-1?Q?rPbHIbfQ5fUufBVUHm0VI9hVUgkhfbyseI+Ltut4f6bw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oITzlDdwahsOJkd4i/Z3jtoYl/0uay6aB4x3+VT0FRb3Y5KHgtZpbA+zBD?=
 =?iso-8859-1?Q?71obn9bCXU4DgRCEUxE5b9fqmw65rdeJ6IsQ85uh2KEIvJYS+G/1AvgYjS?=
 =?iso-8859-1?Q?16uJklXUlHLGtT0z1aDoYVTTLUylIJBblqT/cUAifgGYgz7aoIb/4kG3Qf?=
 =?iso-8859-1?Q?GO+aekseWNUij8gR6V9bN9c/zWipeqqrs8CdggxnXUVtKThuNiz3fP6ZN5?=
 =?iso-8859-1?Q?nAo5WlagZ3zsRX5AAOR7oUfHCcNy7uXPRbcgmBQWANCcCs8lSN8x2B1FyU?=
 =?iso-8859-1?Q?6SOBRF5pYzc6CRIZ3HUXp017n9Evj+EtJoyo1jRJoStvKyfq5hl3xImW5h?=
 =?iso-8859-1?Q?hG/OKBS5Ro+oEBrlc4NkZG57cCCnmWe2b1QeMrOFHH92G8crGuEMI3Q2ya?=
 =?iso-8859-1?Q?UAhAgJpMC1/hRc0hY/wrbjRGoD14yC68fTivoWMT6zCwUMIxflYUmngAua?=
 =?iso-8859-1?Q?K1sf1amLt6X9M3h9NI49AHrg2vl8C2BkeswloK8eqq8eQ4yWPMZfr25yOl?=
 =?iso-8859-1?Q?f8WCQsKWtpOx167JkXjHbatSI4Fta0G1noiXZ/v5BNitmjaU1vS2ZnsB+N?=
 =?iso-8859-1?Q?RtdCPYls7qurb580KgqrIKKSV1jjNavfLTAY/dM6+DXbEYn5rRTMCt9FkM?=
 =?iso-8859-1?Q?P8XGMl2rX9L1KxTij1RWwBzcjYP2ewPBPYk15lWv4R2rRXuS2A3j0h0l3+?=
 =?iso-8859-1?Q?hi+YRjudFC4jiucpoQxVLpQ1wmlluYLjfQnrPko4N76S258dPXQbDS6VIM?=
 =?iso-8859-1?Q?q3Wo0OXdXaDJt1rSf6hQoTwi1OSpZiM2uzkb95UDqIjNUxwmbNMspnvleg?=
 =?iso-8859-1?Q?m96pXdoBv0gLffRc87D7Xp307BQCZLnTaH7MFdG9NTrg++bzsJHfU+Jg24?=
 =?iso-8859-1?Q?iA4BVgE/EPzVRgi9a2Inafi7Tzs3ve6b3W6r9D5oziSan4zRt9qfg8FykB?=
 =?iso-8859-1?Q?GNDNQHh2/XQxu/uPVdVLTcV2GP64sUHI2D8ti1LvsVxC1wpWh/a+0heC+g?=
 =?iso-8859-1?Q?l3DZnZJkSkJS3lCMAwZT/+p23qhW8YqyekTI8AIYfOG02gRGrETBtBteJ2?=
 =?iso-8859-1?Q?o/VTk6uacQ/bMbNo1jJmQkIbq9NDg0Msx5n6Fj0l53suMIR/5hQ4rpVmbZ?=
 =?iso-8859-1?Q?hinsBjEOkfkxybx2y4BHyLJp/vA2sF/I3XunlBRs7m9Oec4b4x0nPBvZxl?=
 =?iso-8859-1?Q?Do7+pYtwLttAjJO8CPrsdd0OYDnjsU9k34F0yShDcpukNaXV0fRAmqqeGA?=
 =?iso-8859-1?Q?Gf87OjRaGfrTPjsGmYTjFXDQmRz6nYC79DeGlC/7XiRI5ReaUu7WKJ86v3?=
 =?iso-8859-1?Q?miDPsNSSulCWsFje5GrBRBnqBJmXTEHB11nPUqcQgAbcQZ3RzrpYAOchFx?=
 =?iso-8859-1?Q?HMGNpOpsuCNDQ638k7zRY1bAlwNApDp4ao/tFIu2fRQrSisF48Yn8hcZVI?=
 =?iso-8859-1?Q?KyjN2OdRHCJn9k8wSlDmO0XydZqqIUwH+TszNu/nI1dN5tE4EsMZ8EERq9?=
 =?iso-8859-1?Q?v/+pMWz5wvqdp5hA1VlWbd9yIWV+pLCystiZsyG/rPocxaZek602hGnOQC?=
 =?iso-8859-1?Q?Nq76A5wQVjaK0mvDLNBiKP3WJPXsUYDPAJQfhJJmcfKP14r05W0rI5lgW6?=
 =?iso-8859-1?Q?/DVvp9SR7se1vbzxAGk2i+euofRsU5r/0B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b81a9a-73be-48c5-494a-08ddbd25bcc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 07:13:13.4560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJzyUI0wr/MfQV0oAUbC/4EqVkR8Ru0hpApiFzz1DuNDWTsavszZawgwMpc98RHoBBEo9PA3EjhsMKLSHlJgvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1969

From b8ffe29f0969da98ab09de8bf9592a8777d84e5f Mon Sep 17 00:00:00 2001=0A=
From: shailesh <shailesh.rathod@lge.com>=0A=
Date: Tue, 24 Jun 2025 13:41:08 +0000=0A=
Subject: [PATCH] Initial P2P Invite and P2P Scan Implementation=0A=
=0A=
- Added support for P2P Invite operation, including new structures and call=
backs in gsupplicant.=0A=
- Implemented DBus methods and callbacks for handling P2P invitation result=
s and received invitations.=0A=
- Extended device, peer, and technology interfaces to support P2P scan and =
invitation flows.=0A=
- Added new driver hooks and logic in wifi plugin for P2P scanning and invi=
tation handling.=0A=
---=0A=
=A0gsupplicant/gsupplicant.h | =A037 ++++=0A=
=A0gsupplicant/supplicant.c =A0| 425 +++++++++++++++++++++++++++++++++++++-=
=0A=
=A0include/device.h =A0 =A0 =A0 =A0 =A0| =A0 2 +=0A=
=A0include/peer.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 3 +=0A=
=A0include/technology.h =A0 =A0 =A0| =A0 2 +=0A=
=A0plugins/wifi.c =A0 =A0 =A0 =A0 =A0 =A0| 160 +++++++++++++-=0A=
=A0src/connman.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2 +-=0A=
=A0src/device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A043 +++-=0A=
=A0src/group.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A036 +++-=0A=
=A0src/peer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A036 ++--=0A=
=A0src/technology.c =A0 =A0 =A0 =A0 =A0| =A026 ++-=0A=
=A011 files changed, 739 insertions(+), 33 deletions(-)=0A=
=0A=
diff --git a/gsupplicant/gsupplicant.h b/gsupplicant/gsupplicant.h=0A=
index 26d5f73..eecad9c 100644=0A=
--- a/gsupplicant/gsupplicant.h=0A=
+++ b/gsupplicant/gsupplicant.h=0A=
@@ -220,6 +220,37 @@ struct _GSupplicantP2PGroupAddParams {=0A=
=A0=0A=
=A0typedef struct _GSupplicantP2PGroupAddParams GSupplicantP2PGroupAddParam=
s;=0A=
=A0=0A=
+/**=0A=
+ * Parameters for a P2P Invite operation.=0A=
+ *=0A=
+ * peer: =A0 =A0 =A0 =A0 =A0 =A0 =A0The MAC address of the peer device to =
invite.=0A=
+ * persistent_group: =A0The identifier for the persistent group to be used=
 for the invitation.=0A=
+ * frequency: =A0 =A0 =A0 =A0 The frequency (in MHz) on which to perform t=
he invitation.=0A=
+ */=0A=
+struct _GSupplicantP2PInviteParams {=0A=
+ =A0 =A0const char *peer;=0A=
+ =A0 =A0const char *persistent_group;=0A=
+ =A0 =A0int frequency;=0A=
+};=0A=
+=0A=
+typedef struct _GSupplicantP2PInviteParams GSupplicantP2PInviteParams;=0A=
+=0A=
+typedef enum=0A=
+{=0A=
+ =A0 G_SUPPLICANT_P2P_FIND_START_WITH_FULL,=0A=
+ =A0 G_SUPPLICANT_P2P_FIND_ONLY_SOCIAL,=0A=
+ =A0 G_SUPPLICANT_P2P_FIND_PROGRESSIVE=0A=
+} GSupplicantP2PFindType;=0A=
+=0A=
+struct _GSupplicantP2PFindParams {=0A=
+ =A0 int timeout;=0A=
+ =A0 int disc_type;=0A=
+ =A0 const char** seek_array;=0A=
+ =A0 int frequency;=0A=
+};=0A=
+=0A=
+typedef struct _GSupplicantP2PFindParams GSupplicantP2PFindParams;=0A=
+=0A=
=A0/* global API */=0A=
=A0typedef void (*GSupplicantCountryCallback) (int result,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *alpha2,=0A=
@@ -295,6 +326,10 @@ int g_supplicant_interface_p2p_add_service(GSupplicant=
Interface *interface,=0A=
=A0int g_supplicant_interface_p2p_del_service(GSupplicantInterface *interfa=
ce,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantP2PServiceParams *p2p_service_pa=
rams);=0A=
=A0=0A=
+int g_supplicant_interface_p2p_invite(GSupplicantInterface *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantP2PInviteParams *invite_data,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantInterfaceCallback callback, void *=
user_data);=0A=
+=0A=
=A0/* Flushes all P2P peer information and cached data from the given inter=
face. */=0A=
=A0int g_supplicant_interface_p2p_flush(GSupplicantInterface *interface,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantInterfaceCallback callback, void=
 *user_data);=0A=
@@ -452,6 +487,8 @@ struct _GSupplicantCallbacks {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int reasoncode);=0A=
=A0 =A0 void (*p2p_group_started)(GSupplicantGroup *group);=0A=
=A0 =A0 void (*p2p_group_finished)(GSupplicantInterface *interface);=0A=
+ =A0 void (*p2p_invitation_result)(GSupplicantInterface *interface, int st=
atus);=0A=
+ =A0 void (*p2p_invitation_received) (GSupplicantInterface *interface, GSu=
pplicantPeer *p2p_network, const char *go_dev_addr, bool persistent);=0A=
=A0};=0A=
=A0=0A=
=A0typedef struct _GSupplicantCallbacks GSupplicantCallbacks;=0A=
diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c=0A=
index 36159e6..6fd7384 100644=0A=
--- a/gsupplicant/supplicant.c=0A=
+++ b/gsupplicant/supplicant.c=0A=
@@ -146,6 +146,8 @@ static GHashTable *peer_mapping;=0A=
=A0static GHashTable *group_mapping;=0A=
=A0static GHashTable *pending_peer_connection;=0A=
=A0static GHashTable *config_file_table;=0A=
+static GHashTable *p2p_peer_table;=0A=
+=0A=
=A0=0A=
=A0struct _GSupplicantWpsCredentials {=0A=
=A0 =A0 unsigned char ssid[32];=0A=
@@ -302,6 +304,13 @@ struct interface_connect_data {=0A=
=A0 =A0 };=0A=
=A0};=0A=
=A0=0A=
+struct interface_p2p_invite_data {=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+ =A0 GSupplicantInterfaceCallback callback;=0A=
+ =A0 GSupplicantP2PInviteParams *p2p_invite_params;=0A=
+ =A0 void *user_data;=0A=
+};=0A=
+=0A=
=A0struct interface_scan_data {=0A=
=A0 =A0 GSupplicantInterface *interface;=0A=
=A0 =A0 char *path;=0A=
@@ -310,6 +319,15 @@ struct interface_scan_data {=0A=
=A0 =A0 void *user_data;=0A=
=A0};=0A=
=A0=0A=
+struct g_supplicant_p2p_inv_recv_info {=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+ =A0 const char *p2p_go_dev_addr;=0A=
+ =A0 const char *src_addr;=0A=
+ =A0 bool persistent;=0A=
+};=0A=
+=0A=
+static int inv_recv_ref =3D -1;=0A=
+=0A=
=A0static int network_remove(struct interface_data *data);=0A=
=A0=0A=
=A0void __connman_util_byte_to_string(unsigned char *src, char *dest, int l=
en);=0A=
@@ -960,6 +978,9 @@ static void remove_peer(gpointer data)=0A=
=A0 =A0 if (pending_peer_connection)=0A=
=A0 =A0 =A0 =A0 g_hash_table_remove(pending_peer_connection, peer->path);=
=0A=
=A0=0A=
+ =A0 if (p2p_peer_table)=0A=
+ =A0 =A0 =A0 g_hash_table_remove(p2p_peer_table, peer->path);=0A=
+=0A=
=A0 =A0 g_free(peer->path);=0A=
=A0 =A0 g_free(peer->name);=0A=
=A0 =A0 g_free(peer->identifier);=0A=
@@ -1606,6 +1627,84 @@ bool g_supplicant_peer_is_client(GSupplicantPeer *pe=
er)=0A=
=A0 =A0 return false;=0A=
=A0}=0A=
=A0=0A=
+static void interface_p2p_invite_params(DBusMessageIter *iter, void *user_=
data)=0A=
+{=0A=
+ =A0 DBusMessageIter dict;=0A=
+ =A0 struct interface_p2p_invite_data *data =3D user_data;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("");=0A=
+=0A=
+ =A0 supplicant_dbus_dict_open(iter, &dict);=0A=
+=0A=
+ =A0 if (data && data->p2p_invite_params) {=0A=
+ =A0 =A0 =A0 GSupplicantP2PInviteParams* params =3D data->p2p_invite_param=
s;=0A=
+=0A=
+ =A0 =A0 =A0 supplicant_dbus_dict_append_basic(&dict, "peer",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_OBJECT_PATH, &params->peer)=
;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 supplicant_dbus_dict_close(iter, &dict);=0A=
+}=0A=
+=0A=
+static void interface_p2p_invite_result(const char *error,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBusMessageIter *iter, void *user_data)=0A=
+{=0A=
+ =A0 struct interface_p2p_invite_data *data =3D user_data;=0A=
+ =A0 int err =3D 0;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("");=0A=
+=0A=
+ =A0 if (error) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("error %s", error);=0A=
+ =A0 =A0 =A0 err =3D -EIO;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (data->callback)=0A=
+ =A0 =A0 =A0 data->callback(err, data->interface, data->user_data);=0A=
+=0A=
+ =A0 dbus_free(data);=0A=
+}=0A=
+=0A=
+int g_supplicant_interface_p2p_invite(GSupplicantInterface *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantP2PInviteParams *invite_data,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantInterfaceCallback callback, void *=
user_data)=0A=
+{=0A=
+ =A0 struct interface_p2p_invite_data *data;=0A=
+ =A0 int ret;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("");=0A=
+=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return -EINVAL;=0A=
+=0A=
+ =A0 if (!interface->p2p_support)=0A=
+ =A0 =A0 =A0 return -ENOTSUP;=0A=
+=0A=
+ =A0 data =3D dbus_malloc0(sizeof(*data));=0A=
+ =A0 if (!data)=0A=
+ =A0 =A0 =A0 return -ENOMEM;=0A=
+=0A=
+ =A0 data->user_data =3D user_data;=0A=
+ =A0 data->interface =3D interface;=0A=
+ =A0 data->callback =3D callback;=0A=
+ =A0 data->p2p_invite_params =3D invite_data;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("interface->path : %s\n", interface->path);=0A=
+=0A=
+ =A0 ret =3D supplicant_dbus_method_call(interface->path,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SUPPLICANT_INTERFACE ".Interface.P2PD=
evice",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Invite",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interface_p2p_invite_params,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interface_p2p_invite_result, data, in=
terface);=0A=
+=0A=
+ =A0 if (ret < 0) {=0A=
+ =A0 =A0 =A0 dbus_free(data);=0A=
+ =A0 =A0 =A0 return ret;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 return -EINPROGRESS;=0A=
+}=0A=
+=0A=
=A0bool g_supplicant_peer_has_requested_connection(GSupplicantPeer *peer)=
=0A=
=A0{=0A=
=A0 =A0 if (!peer)=0A=
@@ -2837,6 +2936,7 @@ static void signal_name_owner_changed(const char *pat=
h, DBusMessageIter *iter)=0A=
=A0 =A0 =A0 =A0 g_hash_table_remove_all(group_mapping);=0A=
=A0 =A0 =A0 =A0 g_hash_table_remove_all(config_file_table);=0A=
=A0 =A0 =A0 =A0 g_hash_table_remove_all(interface_table);=0A=
+ =A0 =A0 =A0 g_hash_table_remove_all(p2p_peer_table);=0A=
=A0 =A0 =A0 =A0 callback_system_killed();=0A=
=A0 =A0 }=0A=
=A0=0A=
@@ -3295,6 +3395,8 @@ static void peer_property(const char *key, DBusMessag=
eIter *iter,=0A=
=A0 =A0 =A0 =A0 return;=0A=
=A0=0A=
=A0 =A0 if (!key) {=0A=
+ =A0 =A0 =A0 if (g_hash_table_lookup(p2p_peer_table, peer->path) =3D=3D NU=
LL)=0A=
+ =A0 =A0 =A0 =A0 =A0 return;=0A=
=A0 =A0 =A0 =A0 if (peer->name) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 create_peer_identifier(peer);=0A=
=A0 =A0 =A0 =A0 =A0 =A0 callback_peer_found(peer);=0A=
@@ -3377,6 +3479,7 @@ static void peer_property(const char *key, DBusMessag=
eIter *iter,=0A=
=A0=0A=
=A0static void signal_peer_found(const char *path, DBusMessageIter *iter)=
=0A=
=A0{=0A=
+=0A=
=A0 =A0 struct peer_property_data *property_data;=0A=
=A0 =A0 GSupplicantInterface *interface;=0A=
=A0 =A0 const char *obj_path =3D NULL;=0A=
@@ -3404,6 +3507,7 @@ static void signal_peer_found(const char *path, DBusM=
essageIter *iter)=0A=
=A0 =A0 peer->path =3D g_strdup(obj_path);=0A=
=A0 =A0 g_hash_table_insert(interface->peer_table, peer->path, peer);=0A=
=A0 =A0 g_hash_table_replace(peer_mapping, peer->path, interface);=0A=
+ =A0 g_hash_table_replace(p2p_peer_table, g_strdup(peer->path), peer);=0A=
=A0=0A=
=A0 =A0 property_data =3D dbus_malloc0(sizeof(struct peer_property_data));=
=0A=
=A0 =A0 property_data->peer =3D peer;=0A=
@@ -3889,6 +3993,282 @@ static void signal_group_request(const char *path, =
DBusMessageIter *iter)=0A=
=A0 =A0 =A0 =A0 g_hash_table_replace(pending_peer_connection, peer->path, p=
eer);=0A=
=A0}=0A=
=A0=0A=
+static void callback_p2p_invitation_result(GSupplicantInterface *interface=
, int status)=0A=
+{=0A=
+ =A0 if (!callbacks_pointer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (!callbacks_pointer->p2p_invitation_result)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callbacks_pointer->p2p_invitation_result(interface, status);=0A=
+}=0A=
+=0A=
+static void interface_p2p_invitation_result(DBusMessageIter *iter, void *u=
ser_data)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface =3D user_data;=0A=
+ =A0 DBusMessageIter dict, entry, value;=0A=
+ =A0 char *key;=0A=
+ =A0 int status =3D 0;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("interface_p2p_invitation_result");=0A=
+=0A=
+ =A0 if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_ARRAY) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not array\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(iter, &dict);=0A=
+ =A0 if(dbus_message_iter_get_arg_type(&dict) !=3D DBUS_TYPE_DICT_ENTRY) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not dict\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&dict, &entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not string\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&entry, &key);=0A=
+ =A0 SUPPLICANT_DBG("key : %s\n", key);=0A=
+ =A0 if(!g_str_equal(key, "status")) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not status\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_next(&entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not variant\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&entry, &value);=0A=
+ =A0 dbus_message_iter_get_basic(&value, &status);=0A=
+ =A0 SUPPLICANT_DBG("status : %d\n", status);=0A=
+=0A=
+ =A0 callback_p2p_invitation_result(interface, status);=0A=
+}=0A=
+=0A=
+static void signal_invitation_result(const char *path, DBusMessageIter *it=
er)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("signal invitation result");=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, path);=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface_p2p_invitation_result(iter, interface);=0A=
+}=0A=
+=0A=
+static void callback_p2p_invitation_received(GSupplicantInterface *interfa=
ce, GSupplicantPeer *peer, const char *go_dev_addr, bool persistent)=0A=
+{=0A=
+ =A0 if (!callbacks_pointer)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 if (!callbacks_pointer->p2p_invitation_received)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 callbacks_pointer->p2p_invitation_received(interface, peer, go_dev_ad=
dr, persistent);=0A=
+}=0A=
+=0A=
+static gboolean check_inv_src_network(gpointer argv)=0A=
+{=0A=
+ =A0 struct g_supplicant_p2p_inv_recv_info *inv_recv =3D argv;=0A=
+ =A0 GSupplicantInterface *interface =3D inv_recv->interface;=0A=
+=0A=
+ =A0 GSupplicantPeer *peer =3D g_supplicant_interface_peer_lookup(interfac=
e, inv_recv->src_addr);=0A=
+=0A=
+ =A0 if(!peer) {=0A=
+ =A0 =A0 =A0 inv_recv_ref =3D g_timeout_add(200, check_inv_src_network, in=
v_recv);=0A=
+ =A0 =A0 =A0 return FALSE;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 callback_p2p_invitation_received(interface, peer, inv_recv->p2p_go_de=
v_addr, inv_recv->persistent);=0A=
+=0A=
+ =A0 g_free(inv_recv);=0A=
+ =A0 inv_recv_ref =3D -1;=0A=
+ =A0 return FALSE;=0A=
+}=0A=
+=0A=
+static void interface_p2p_invitation_received(DBusMessageIter *iter, void =
*user_data)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface =3D user_data;=0A=
+ =A0 DBusMessageIter dict, entry, value, array;=0A=
+ =A0 char *key;=0A=
+ =A0 int status;=0A=
+ =A0 int addr_len =3D 6;=0A=
+ =A0 unsigned char *bssid, *go_dev_addr, *src_addr;=0A=
+ =A0 char go_dev_addr_str[13], src_addr_str[13];=0A=
+ =A0 char *p_go_dev_addr, *p_src_addr;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("interface_p2p_invitation_received");=0A=
+=0A=
+ =A0 if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_ARRAY) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not array\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(iter, &dict);=0A=
+ =A0 if(dbus_message_iter_get_arg_type(&dict) !=3D DBUS_TYPE_DICT_ENTRY) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not dict\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&dict, &entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not string\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&entry, &key);=0A=
+ =A0 SUPPLICANT_DBG("key : %s\n", key);=0A=
+ =A0 if(!g_str_equal(key, "status")) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not status\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_next(&entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not variant\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&entry, &value);=0A=
+ =A0 dbus_message_iter_get_basic(&value, &status);=0A=
+ =A0 SUPPLICANT_DBG("status : %d\n", status);=0A=
+=0A=
+ =A0 if(status =3D=3D 0) //Persistent group reinvoke case=0A=
+ =A0 =A0 =A0 g_supplicant_interface_p2p_listen(interface, 0, 0);=0A=
+=0A=
+ =A0 else if(status !=3D 1)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 dbus_message_iter_next(&dict);=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&dict, &entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not string\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&entry, &key);=0A=
+ =A0 SUPPLICANT_DBG("key : %s\n", key);=0A=
+ =A0 if(!g_str_equal(key, "sa")) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not sa\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_next(&entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not variant\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&entry, &value);=0A=
+ =A0 dbus_message_iter_recurse(&value, &array);=0A=
+=0A=
+ =A0 dbus_message_iter_get_fixed_array(&array, &src_addr, &addr_len);=0A=
+=0A=
+ =A0 dbus_message_iter_next(&dict);=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&dict, &entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not string\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&entry, &key);=0A=
+ =A0 SUPPLICANT_DBG("key : %s\n", key);=0A=
+=0A=
+ =A0 if(!g_str_equal(key, "go_dev_addr")) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not go_dev_addr\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_next(&entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not variant\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&entry, &value);=0A=
+ =A0 dbus_message_iter_recurse(&value, &array);=0A=
+=0A=
+ =A0 dbus_message_iter_get_fixed_array(&array, &go_dev_addr, &addr_len);=
=0A=
+=0A=
+ =A0 dbus_message_iter_next(&dict);=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&dict, &entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not string\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&entry, &key);=0A=
+ =A0 SUPPLICANT_DBG("key : %s\n", key);=0A=
+ =A0 if(!g_str_equal(key, "bssid")) {=0A=
+ =A0 =A0 =A0 if(status =3D=3D 0)=0A=
+ =A0 =A0 =A0 =A0 =A0 goto go_next; //BSSID is not exist at persistent go c=
ase=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not bssid\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_next(&entry);=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT) {=
=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("not variant\n");=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 dbus_message_iter_recurse(&entry, &value);=0A=
+ =A0 dbus_message_iter_recurse(&value, &array);=0A=
+=0A=
+ =A0 dbus_message_iter_get_fixed_array(&array, &bssid, &addr_len);=0A=
+=0A=
+go_next:=0A=
+=0A=
+ =A0 __connman_util_byte_to_string(go_dev_addr, go_dev_addr_str, 6);=0A=
+ =A0 p_go_dev_addr =3D g_strdup(go_dev_addr_str);=0A=
+=0A=
+ =A0 __connman_util_byte_to_string(src_addr, src_addr_str, 6);=0A=
+ =A0 p_src_addr =3D g_strdup(src_addr_str);=0A=
+=0A=
+ =A0 if (inv_recv_ref !=3D -1) {=0A=
+ =A0 =A0 =A0 g_free(p_src_addr);=0A=
+ =A0 =A0 =A0 g_free(p_go_dev_addr);=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 struct g_supplicant_p2p_inv_recv_info *inv_recv =3D g_try_new0(struct=
 g_supplicant_p2p_inv_recv_info, 1);=0A=
+ =A0 if (!inv_recv) {=0A=
+ =A0 =A0 =A0 g_free(p_src_addr);=0A=
+ =A0 =A0 =A0 g_free(p_go_dev_addr);=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 inv_recv->interface =3D interface;=0A=
+ =A0 inv_recv->p2p_go_dev_addr =3D p_go_dev_addr;=0A=
+ =A0 inv_recv->src_addr =3D p_src_addr;=0A=
+ =A0 inv_recv->persistent =3D !status;=0A=
+ =A0 inv_recv_ref =3D g_timeout_add(500, check_inv_src_network, inv_recv);=
=0A=
+ =A0 return;=0A=
+}=0A=
+=0A=
+static void signal_invitation_received(const char *path, DBusMessageIter *=
iter)=0A=
+{=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+=0A=
+ =A0 SUPPLICANT_DBG("signal invitation received");=0A=
+=0A=
+ =A0 interface =3D g_hash_table_lookup(interface_table, path);=0A=
+ =A0 if (!interface)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 interface_p2p_invitation_received(iter, interface);=0A=
+}=0A=
+=0A=
=A0static void signal_group_peer_joined(const char *path, DBusMessageIter *=
iter)=0A=
=A0{=0A=
=A0 =A0 const char *peer_path =3D NULL;=0A=
@@ -3997,6 +4377,10 @@ static struct {=0A=
=A0 =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "GroupFinished", sig=
nal_group_finished },=0A=
=A0 =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "GONegotiationReques=
t", signal_group_request },=0A=
=A0=0A=
+ =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "InvitationResult", si=
gnal_invitation_result },=0A=
+ =A0 { SUPPLICANT_INTERFACE ".Interface.P2PDevice", "InvitationReceived", =
signal_invitation_received },=0A=
+=0A=
+=0A=
=A0 =A0 { SUPPLICANT_INTERFACE ".Group", "PeerJoined", signal_group_peer_jo=
ined },=0A=
=A0 =A0 { SUPPLICANT_INTERFACE ".Group", "PeerDisconnected", signal_group_p=
eer_disconnected },=0A=
=A0=0A=
@@ -5759,27 +6143,38 @@ int g_supplicant_interface_disconnect(GSupplicantIn=
terface *interface,=0A=
=A0 =A0 return ret;=0A=
=A0}=0A=
=A0=0A=
+struct interface_p2p_find_data {=0A=
+ =A0 GSupplicantInterface *interface;=0A=
+ =A0 char *path;=0A=
+ =A0 GSupplicantInterfaceCallback callback;=0A=
+ =A0 GSupplicantP2PFindParams *p2p_find_params;=0A=
+ =A0 void *user_data;=0A=
+};=0A=
+=0A=
=A0static void interface_p2p_find_result(const char *error,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBusMessageIter *iter, void *user_d=
ata)=0A=
=A0{=0A=
- =A0 struct interface_scan_data *data =3D user_data;=0A=
+ =A0 struct interface_p2p_find_data *data =3D user_data;=0A=
=A0 =A0 int err =3D 0;=0A=
=A0=0A=
- =A0 SUPPLICANT_DBG("error %s", error);=0A=
-=0A=
- =A0 if (error)=0A=
+ =A0 if (error !=3D NULL) {=0A=
+ =A0 =A0 =A0 SUPPLICANT_DBG("error %s", error);=0A=
=A0 =A0 =A0 =A0 err =3D -EIO;=0A=
-=0A=
+ =A0 }=0A=
=A0 =A0 if (interface_exists(data->interface, data->path)) {=0A=
=A0 =A0 =A0 =A0 if (!data->interface->ready)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOLINK;=0A=
- =A0 =A0 =A0 if (!err)=0A=
+ =A0 =A0 =A0 if (!err) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 data->interface->p2p_finding =3D true;=0A=
+ =A0 =A0 =A0 }=0A=
=A0 =A0 }=0A=
=A0=0A=
- =A0 if (data->callback)=0A=
+ =A0 if (data->callback !=3D NULL)=0A=
=A0 =A0 =A0 =A0 data->callback(err, data->interface, data->user_data);=0A=
=A0=0A=
+ =A0 if (data->p2p_find_params)=0A=
+ =A0 =A0 =A0 g_free(data->p2p_find_params);=0A=
+=0A=
=A0 =A0 g_free(data->path);=0A=
=A0 =A0 dbus_free(data);=0A=
=A0}=0A=
@@ -5787,6 +6182,10 @@ static void interface_p2p_find_result(const char *er=
ror,=0A=
=A0static void interface_p2p_find_params(DBusMessageIter *iter, void *user_=
data)=0A=
=A0{=0A=
=A0 =A0 DBusMessageIter dict;=0A=
+ =A0 struct interface_p2p_find_data *data =3D user_data;=0A=
+ =A0 int timeout =3D 0;=0A=
+ =A0 char *disc_type =3D "start_with_full";=0A=
+ =A0 int freq =3D 0;=0A=
=A0=0A=
=A0 =A0 supplicant_dbus_dict_open(iter, &dict);=0A=
=A0 =A0 supplicant_dbus_dict_close(iter, &dict);=0A=
@@ -6706,6 +7105,8 @@ int g_supplicant_register(const GSupplicantCallbacks =
*callbacks)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, NULL)=
;=0A=
=A0 =A0 config_file_table =3D g_hash_table_new_full(g_str_hash, g_str_equal=
,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free, g_f=
ree);=0A=
+ =A0 p2p_peer_table =3D g_hash_table_new_full(g_str_hash, g_str_equal,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_free, NULL)=
;=0A=
=A0=0A=
=A0 =A0 supplicant_dbus_setup(connection);=0A=
=A0=0A=
@@ -6801,6 +7202,16 @@ void g_supplicant_unregister(const GSupplicantCallba=
cks *callbacks)=0A=
=A0 =A0 =A0 =A0 interface_table =3D NULL;=0A=
=A0 =A0 }=0A=
=A0=0A=
+ =A0 if (p2p_peer_table !=3D NULL){=0A=
+ =A0 =A0 =A0 g_hash_table_destroy(p2p_peer_table);=0A=
+ =A0 =A0 =A0 p2p_peer_table =3D NULL;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (p2p_peer_table !=3D NULL){=0A=
+ =A0 =A0 =A0 g_hash_table_destroy(p2p_peer_table);=0A=
+ =A0 =A0 =A0 p2p_peer_table =3D NULL;=0A=
+ =A0 }=0A=
+=0A=
=A0 =A0 if (system_available)=0A=
=A0 =A0 =A0 =A0 callback_system_killed();=0A=
=A0=0A=
diff --git a/include/device.h b/include/device.h=0A=
index 0fc06bd..2a2cc77 100644=0A=
--- a/include/device.h=0A=
+++ b/include/device.h=0A=
@@ -137,6 +137,8 @@ struct connman_device_driver {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 struct connman_device *device);=0A=
=A0 =A0 int (*set_regdom) (struct connman_device *device,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *alpha2);=0A=
+ =A0 int (*scan_p2p)(enum connman_service_type type,=0A=
+ =A0 =A0 =A0 =A0 =A0 struct connman_device *device);=0A=
=A0};=0A=
=A0=0A=
=A0int connman_device_driver_register(struct connman_device_driver *driver)=
;=0A=
diff --git a/include/peer.h b/include/peer.h=0A=
index 6fe5e64..f6be3cb 100644=0A=
--- a/include/peer.h=0A=
+++ b/include/peer.h=0A=
@@ -112,6 +112,9 @@ void connman_peer_driver_unregister(struct connman_peer=
_driver *driver);=0A=
=A0struct connman_peer *connman_peer_get_by_path(const char *path);=0A=
=A0void __connman_peer_get_properties_struct(DBusMessageIter *iter, gpointe=
r user_data);=0A=
=A0=0A=
+struct connman_peer *connman_peer_get_by_path(const char *path);=0A=
+const char *connman_peer_get_identifier(struct connman_peer *peer);=0A=
+=0A=
=A0bool connman_peer_service_is_master(void);=0A=
=A0=0A=
=A0#ifdef __cplusplus=0A=
diff --git a/include/technology.h b/include/technology.h=0A=
index 391b446..965ad49 100644=0A=
--- a/include/technology.h=0A=
+++ b/include/technology.h=0A=
@@ -75,6 +75,8 @@ int connman_technology_driver_register(struct connman_tec=
hnology_driver *driver)=0A=
=A0void connman_technology_driver_unregister(struct connman_technology_driv=
er *driver);=0A=
=A0void connman_technology_set_p2p_listen(struct connman_technology *techno=
logy,bool enabled);=0A=
=A0bool connman_technology_get_p2p_listen(struct connman_technology *techno=
logy);=0A=
+void __connman_technology_p2p_invitation_result(struct connman_technology =
*technology,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int status);=0A=
=A0#ifdef __cplusplus=0A=
=A0}=0A=
=A0#endif=0A=
diff --git a/plugins/wifi.c b/plugins/wifi.c=0A=
index 9fa22dd..c6629f1 100644=0A=
--- a/plugins/wifi.c=0A=
+++ b/plugins/wifi.c=0A=
@@ -61,6 +61,8 @@=0A=
=A0=0A=
=A0#include "src/shared/util.h"=0A=
=A0=0A=
+#include "src/connman.h"=0A=
+=0A=
=A0#define CLEANUP_TIMEOUT =A0 8 =A0 =A0/* in seconds */=0A=
=A0#define INACTIVE_TIMEOUT =A012 =A0 /* in seconds */=0A=
=A0#define FAVORITE_MAXIMUM_RETRIES 2=0A=
@@ -85,6 +87,10 @@ static int p2p_group_ifindex =3D -1;=0A=
=A0=0A=
=A0static char *p2p_go_identifier =3D NULL;=0A=
=A0=0A=
+static guint p2p_scan_ref =3D 0;=0A=
+=0A=
+static int p2p_find_ref =3D -1;=0A=
+=0A=
=A0#define ASSOC_STATUS_AUTH_TIMEOUT 16=0A=
=A0#define ASSOC_STATUS_NO_CLIENT 17=0A=
=A0#define LOAD_SHAPING_MAX_RETRIES 3=0A=
@@ -177,6 +183,7 @@ struct wifi_data {=0A=
=A0 =A0 int servicing;=0A=
=A0 =A0 int disconnect_code;=0A=
=A0 =A0 int assoc_code;=0A=
+ =A0 const char *invited_path;=0A=
=A0};=0A=
=A0=0A=
=A0struct wifi_network {=0A=
@@ -1048,6 +1055,12 @@ static void wifi_remove(struct connman_device *devic=
e)=0A=
=A0 =A0 if (wifi->scan_params)=0A=
=A0 =A0 =A0 =A0 g_supplicant_free_scan_params(wifi->scan_params);=0A=
=A0=0A=
+ =A0 if (p2p_scan_ref) {=0A=
+ =A0 =A0 =A0 g_source_remove(p2p_scan_ref);=0A=
+ =A0 =A0 =A0 p2p_scan_ref =3D 0;=0A=
+ =A0 }=0A=
+=0A=
+=0A=
=A0 =A0 g_free(wifi->autoscan);=0A=
=A0 =A0 g_free(wifi->identifier);=0A=
=A0 =A0 g_free(wifi);=0A=
@@ -1945,6 +1958,22 @@ static gboolean p2p_find_stop(gpointer data)=0A=
=A0 =A0 return FALSE;=0A=
=A0}=0A=
=A0=0A=
+static gboolean p2p_find_complete(gpointer argv)=0A=
+{=0A=
+ =A0 struct connman_device *device =3D argv;=0A=
+ =A0 struct wifi_data *wifi =3D connman_device_get_data(device);=0A=
+ =A0 int ret =3D 0;=0A=
+=0A=
+ =A0 if(!wifi) {=0A=
+ =A0 =A0 =A0 p2p_find_ref =3D -1;=0A=
+ =A0 =A0 =A0 return FALSE;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 p2p_find_ref =3D -1;=0A=
+=0A=
+ =A0 return FALSE;=0A=
+}=0A=
+=0A=
=A0static void p2p_find_callback(int result, GSupplicantInterface *interfac=
e,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user_data)=0A=
=A0{=0A=
@@ -1969,6 +1998,8 @@ static void p2p_find_callback(int result, GSupplicant=
Interface *interface,=0A=
=A0 =A0 if (!wifi->p2p_find_timeout)=0A=
=A0 =A0 =A0 =A0 goto error;=0A=
=A0=0A=
+ =A0 p2p_find_ref =3D -1;=0A=
+=0A=
=A0 =A0 return;=0A=
=A0error:=0A=
=A0 =A0 p2p_find_stop(device);=0A=
@@ -1994,12 +2025,16 @@ static int p2p_find(struct connman_device *device)=
=0A=
=A0=0A=
=A0 =A0 ret =3D g_supplicant_interface_p2p_find(wifi->interface,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p2p_find_callback, device);=
=0A=
+=0A=
+ =A0 DBG("p2p_find returned %d", ret);=0A=
+=0A=
=A0 =A0 if (ret) {=0A=
=A0 =A0 =A0 =A0 connman_device_unref(device);=0A=
=A0 =A0 =A0 =A0 start_autoscan(device);=0A=
=A0 =A0 } else {=0A=
=A0 =A0 =A0 =A0 connman_device_set_scanning(device,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_SERVICE_TYPE_P2P, true);=0A=
+ =A0 =A0 =A0 p2p_find_ref =3D g_timeout_add_seconds(wifi->p2p_find_timeout=
, p2p_find_complete, device);=0A=
=A0 =A0 }=0A=
=A0=0A=
=A0 =A0 return ret;=0A=
@@ -2184,6 +2219,41 @@ static int wifi_set_regdom(struct connman_device *de=
vice, const char *alpha2)=0A=
=A0 =A0 return ret;=0A=
=A0}=0A=
=A0=0A=
+static gboolean check_wifi_device_connecting(gpointer argv)=0A=
+{=0A=
+ =A0 struct connman_device *device =3D argv;=0A=
+=0A=
+ =A0 bool connecting =3D false;=0A=
+ =A0 bool wifi_total =3D false;=0A=
+ =A0 p2p_scan_ref =3D 0;=0A=
+=0A=
+ =A0 p2p_find(device);=0A=
+ =A0 return FALSE;=0A=
+}=0A=
+=0A=
+=0A=
+static int wifi_scan_p2p(enum connman_service_type type,=0A=
+ =A0 =A0 =A0 =A0 =A0 struct connman_device *device)=0A=
+{=0A=
+ =A0 int ret;=0A=
+=0A=
+ =A0 connman_info("wifi_scan_p2p");=0A=
+=0A=
+ =A0 if (!p2p_technology)=0A=
+ =A0 =A0 =A0 return -ENOTSUP;=0A=
+=0A=
+=0A=
+=0A=
+ =A0 if (p2p_scan_ref) {=0A=
+ =A0 =A0 =A0 connman_warn("wifi_scan_p2p p2p_scan_ref=3D%u", p2p_scan_ref)=
;=0A=
+ =A0 =A0 =A0 return -EALREADY;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 p2p_scan_ref =3D g_timeout_add_full(G_PRIORITY_DEFAULT, 2000, check_w=
ifi_device_connecting, device, NULL);=0A=
+=0A=
+ =A0 return 0;=0A=
+}=0A=
+=0A=
=A0static struct connman_device_driver wifi_ng_driver =3D {=0A=
=A0 =A0 .name =A0 =A0 =A0 =3D "wifi",=0A=
=A0 =A0 .type =A0 =A0 =A0 =3D CONNMAN_DEVICE_TYPE_WIFI,=0A=
@@ -2193,10 +2263,16 @@ static struct connman_device_driver wifi_ng_driver =
=3D {=0A=
=A0 =A0 .enable =A0 =A0 =3D wifi_enable,=0A=
=A0 =A0 .disable =A0 =A0=3D wifi_disable,=0A=
=A0 =A0 .scan =A0 =A0 =A0 =3D wifi_scan,=0A=
+ =A0 .scan_p2p =A0 =3D wifi_scan_p2p,=0A=
=A0 =A0 .stop_scan =A0=3D wifi_stop_scan,=0A=
=A0 =A0 .set_regdom =3D wifi_set_regdom,=0A=
=A0};=0A=
=A0=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
=A0static void system_ready(void)=0A=
=A0{=0A=
=A0 =A0 DBG("");=0A=
@@ -3215,6 +3291,82 @@ static void network_associated(GSupplicantNetwork *n=
etwork)=0A=
=A0 =A0 interface_state(interface);=0A=
=A0}=0A=
=A0=0A=
+static void p2p_invitation_result(GSupplicantInterface *interface, int sta=
tus)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi;=0A=
+=0A=
+ =A0 wifi =3D g_supplicant_interface_get_data(interface);=0A=
+=0A=
+ =A0 if (!wifi)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 DBG("status %i", status);=0A=
+=0A=
+ =A0 __connman_technology_p2p_invitation_result(p2p_technology, status);=
=0A=
+}=0A=
+=0A=
+static void p2p_invitation_received(GSupplicantInterface *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantPeer *peer, const char *go_dev_add=
r, bool persistent)=0A=
+{=0A=
+ =A0 struct wifi_data *wifi =3D g_supplicant_interface_get_data(interface)=
;=0A=
+ =A0 struct connman_peer *connman_peer;=0A=
+ =A0 const char *identifier, *path;=0A=
+ =A0 const char *go_dev_addr_colon;=0A=
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
+ =A0 go_dev_addr_colon =3D __connman_util_insert_colon_to_mac_addr(go_dev_=
addr);=0A=
+ =A0 path =3D __connman_peer_get_path(connman_peer);=0A=
+=0A=
+ =A0 if (!path) {=0A=
+ =A0 =A0 =A0 g_free(go_dev_addr_colon);=0A=
+ =A0 =A0 =A0 return;=0A=
+ =A0 }=0A=
+=0A=
+ =A0 if (!persistent) {=0A=
+ =A0 =A0 =A0 connman_peer_set_state(connman_peer, CONNMAN_PEER_STATE_IDLE)=
;=0A=
+=0A=
+ =A0 =A0 =A0 /* Invitation received from GO */=0A=
+ =A0 =A0 =A0 if (g_str_equal(identifier, go_dev_addr)) {=0A=
+ =A0 =A0 =A0 =A0 =A0 wifi->invited_path =3D __connman_peer_get_path(connma=
n_peer);=0A=
+ =A0 =A0 =A0 /* Sometimes there is only src address in InvitationReceived =
signal without GO device address */=0A=
+ =A0 =A0 =A0 } else if (g_str_equal(go_dev_addr, "000000000000")) {=0A=
+ =A0 =A0 =A0 =A0 =A0 wifi->invited_path =3D __connman_peer_get_path(connma=
n_peer);=0A=
+ =A0 =A0 =A0 =A0 =A0 g_free(go_dev_addr_colon);=0A=
+ =A0 =A0 =A0 =A0 =A0 go_dev_addr_colon =3D __connman_util_insert_colon_to_=
mac_addr(identifier);=0A=
+ =A0 =A0 =A0 } else {=0A=
+ =A0 =A0 =A0 =A0 =A0 struct connman_network *network_go =3D connman_device=
_get_network(wifi->device, go_dev_addr);=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 if (network_go) {=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct connman_service *service_go;=0A=
+=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 wifi->invited_path =3D connman_network_get_st=
ring(network_go, "Path");=0A=
+ =A0 =A0 =A0 =A0 =A0 }=0A=
+ =A0 =A0 =A0 }=0A=
+=0A=
+ =A0 =A0 =A0 connman_dbus_property_changed_basic(path, CONNMAN_PEER_INTERF=
ACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 "P2PInvitationReceived", DBUS_TYPE_STRING, &g=
o_dev_addr_colon);=0A=
+=0A=
+ =A0 } else {=0A=
+ =A0 =A0 =A0 p2p_find_stop(wifi->device);=0A=
+ =A0 =A0 =A0 if (connman_technology_get_p2p_listen(wifi_technology)) //alr=
eady changed to listen off=0A=
+ =A0 =A0 =A0 =A0 =A0 connman_technology_set_p2p_listen(wifi_technology, fa=
lse);=0A=
+=0A=
+ =A0 =A0 =A0 connman_dbus_property_changed_basic(path, CONNMAN_PEER_INTERF=
ACE,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 "P2PPersistentReceived", DBUS_TYPE_STRING, &g=
o_dev_addr_colon);=0A=
+ =A0 }=0A=
+}=0A=
+=0A=
+=0A=
=A0static void sta_authorized(GSupplicantInterface *interface,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *addr)=0A=
=A0{=0A=
@@ -3263,11 +3415,15 @@ static void peer_found(GSupplicantPeer *peer)=0A=
=A0 =A0 GSupplicantInterface *iface =3D g_supplicant_peer_get_interface(pee=
r);=0A=
=A0 =A0 struct wifi_data *wifi =3D g_supplicant_interface_get_data(iface);=
=0A=
=A0 =A0 struct connman_peer *connman_peer;=0A=
- =A0 const char *identifier, *name;=0A=
+ =A0 const char *identifier, *name,*path;=0A=
=A0 =A0 int ret;=0A=
=A0=0A=
=A0 =A0 identifier =3D g_supplicant_peer_get_identifier(peer);=0A=
=A0 =A0 name =3D g_supplicant_peer_get_name(peer);=0A=
+ =A0 path =3D g_supplicant_peer_get_path(peer);=0A=
+=0A=
+ =A0 DBG("peer_found - ident: %s", identifier);=0A=
+=0A=
=A0=0A=
=A0 =A0 DBG("ident: %s", identifier);=0A=
=A0=0A=
@@ -3546,6 +3702,8 @@ static const GSupplicantCallbacks callbacks =3D {=0A=
=A0 =A0 .assoc_status_code =A0 =A0 =A0=3D assoc_status_code,=0A=
=A0 =A0 .p2p_group_started =A0=3D p2p_group_started,=0A=
=A0 =A0 .p2p_group_finished =3D p2p_group_finished,=0A=
+ =A0 .p2p_invitation_result =3D p2p_invitation_result,=0A=
+ =A0 .p2p_invitation_received =3D p2p_invitation_received,=0A=
=A0};=0A=
=A0=0A=
=A0static int tech_probe(struct connman_technology *technology)=0A=
diff --git a/src/connman.h b/src/connman.h=0A=
index 034a990..d9adc48 100644=0A=
--- a/src/connman.h=0A=
+++ b/src/connman.h=0A=
@@ -627,7 +627,7 @@ void __connman_device_list(DBusMessageIter *iter, void =
*user_data);=0A=
=A0enum connman_service_type __connman_device_get_service_type(struct connm=
an_device *device);=0A=
=A0struct connman_device *__connman_device_find_device(enum connman_service=
_type type);=0A=
=A0int __connman_device_request_scan(enum connman_service_type type);=0A=
-int __connman_device_request_scan_full(enum connman_service_type type);=0A=
+int __connman_device_request_scan_full(enum connman_service_type type,bool=
 priority);=0A=
=A0int __connman_device_request_hidden_scan(struct connman_device *device,=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *ssid, unsigned int ssid_len,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *identity, const char *passphras=
e,=0A=
diff --git a/src/device.c b/src/device.c=0A=
index 5567009..3ab5268 100644=0A=
--- a/src/device.c=0A=
+++ b/src/device.c=0A=
@@ -174,6 +174,8 @@ static bool device_has_service_type(struct connman_devi=
ce *device,=0A=
=A0 =A0 return service_type =3D=3D device_service_type;=0A=
=A0}=0A=
=A0=0A=
+=0A=
+=0A=
=A0static gboolean device_pending_reset(gpointer user_data)=0A=
=A0{=0A=
=A0 =A0 struct connman_device *device =3D user_data;=0A=
@@ -642,7 +644,7 @@ bool connman_device_get_powered(struct connman_device *=
device)=0A=
=A0=0A=
=A0static int device_scan(enum connman_service_type type,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct connman_device *device,=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool force_full_scan)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool priority)=0A=
=A0{=0A=
=A0 =A0 struct connman_device_scan_params params;=0A=
=A0=0A=
@@ -654,9 +656,11 @@ static int device_scan(enum connman_service_type type,=
=0A=
=A0=0A=
=A0 =A0 memset(&params, 0, sizeof(params));=0A=
=A0 =A0 params.type =3D type;=0A=
- =A0 params.force_full_scan =3D force_full_scan;=0A=
-=0A=
- =A0 return device->driver->scan(device, &params);=0A=
+ =A0 params.force_full_scan =3D priority;=0A=
+ =A0 if(priority)=0A=
+ =A0 =A0 =A0 return device->driver->scan_p2p(type, device);=0A=
+ =A0 else=0A=
+ =A0 =A0 =A0 return device->driver->scan(device, &params);=0A=
=A0}=0A=
=A0=0A=
=A0int __connman_device_disconnect(struct connman_device *device)=0A=
@@ -1102,7 +1106,7 @@ void connman_device_regdom_notify(struct connman_devi=
ce *device,=0A=
=A0}=0A=
=A0=0A=
=A0static int connman_device_request_scan(enum connman_service_type type,=
=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool force_full_scan)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool priority)=0A=
=A0{=0A=
=A0 =A0 bool success =3D false;=0A=
=A0 =A0 int last_err =3D -ENOSYS;=0A=
@@ -1130,7 +1134,7 @@ static int connman_device_request_scan(enum connman_s=
ervice_type type,=0A=
=A0 =A0 =A0 =A0 if (!device_has_service_type(device, type))=0A=
=A0 =A0 =A0 =A0 =A0 =A0 continue;=0A=
=A0=0A=
- =A0 =A0 =A0 err =3D device_scan(type, device, force_full_scan);=0A=
+ =A0 =A0 =A0 err =3D device_scan(type, device, priority);=0A=
=A0 =A0 =A0 =A0 if (err =3D=3D 0 || err =3D=3D -EALREADY || err =3D=3D -EIN=
PROGRESS) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 success =3D true;=0A=
=A0 =A0 =A0 =A0 } else {=0A=
@@ -1150,9 +1154,9 @@ int __connman_device_request_scan(enum connman_servic=
e_type type)=0A=
=A0 =A0 return connman_device_request_scan(type, false);=0A=
=A0}=0A=
=A0=0A=
-int __connman_device_request_scan_full(enum connman_service_type type)=0A=
+int __connman_device_request_scan_full(enum connman_service_type type,bool=
 priority)=0A=
=A0{=0A=
- =A0 return connman_device_request_scan(type, true);=0A=
+ =A0 return connman_device_request_scan(type, priority);=0A=
=A0}=0A=
=A0=0A=
=A0int __connman_device_request_hidden_scan(struct connman_device *device,=
=0A=
@@ -1240,6 +1244,27 @@ static char *index2ident(int index, const char *pref=
ix)=0A=
=A0 =A0 return str;=0A=
=A0}=0A=
=A0=0A=
+struct connman_device *connman_get_device_from_interface(const char* devic=
e_interface)=0A=
+{=0A=
+ =A0 GSList *list_h;=0A=
+ =A0 int i_h =3D 0;=0A=
+=0A=
+ =A0 if (!device_interface)=0A=
+ =A0 =A0 =A0 return NULL;=0A=
+=0A=
+ =A0 for (list_h =3D device_list; list_h; list_h =3D list_h->next) {=0A=
+ =A0 =A0 =A0 struct connman_device *device =3D list_h->data;=0A=
+=0A=
+ =A0 =A0 =A0 if (g_strcmp0(connman_device_get_string(device, "Interface"),=
 device_interface) =3D=3D 0) {=0A=
+ =A0 =A0 =A0 =A0 =A0 return device;=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 }=0A=
+=0A=
+ =A0 return NULL;=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
=A0static char *index2addr(int index)=0A=
=A0{=0A=
=A0 =A0 struct ifreq ifr;=0A=
@@ -1283,6 +1308,8 @@ static char *index2addr(int index)=0A=
=A0 =A0 return str;=0A=
=A0}=0A=
=A0=0A=
+=0A=
+=0A=
=A0struct connman_device *connman_device_create_from_index(int index)=0A=
=A0{=0A=
=A0 =A0 enum connman_device_type type;=0A=
diff --git a/src/group.c b/src/group.c=0A=
index 8715d65..84f1619 100644=0A=
--- a/src/group.c=0A=
+++ b/src/group.c=0A=
@@ -369,6 +369,13 @@ static DBusMessage *p2p_disconnect(DBusConnection *con=
n,=0A=
=A0 =A0 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
=A0}=0A=
=A0=0A=
+static void p2p_invite_callback(int result,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GSupplicantInterface *interface,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user_data)=0A=
+{=0A=
+ =A0 DBG("p2p invite callback %d\n", result);=0A=
+}=0A=
+=0A=
=A0/**=0A=
=A0 * Handles a D-Bus method call to invite a peer to a P2P group.=0A=
=A0 *=0A=
@@ -385,7 +392,34 @@ static DBusMessage *p2p_disconnect(DBusConnection *con=
n,=0A=
=A0static DBusMessage *p2p_invite(DBusConnection *conn,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBusMessage=
 *msg, void *user_data)=0A=
=A0{=0A=
- =A0 // TODO: Implement the logic for inviting a peer to a P2P group.=0A=
+ =A0 struct connman_group *group =3D user_data;=0A=
+ =A0 DBusMessageIter iter;=0A=
+ =A0 const char *peer_path;=0A=
+ =A0 char *peer_ident;=0A=
+ =A0 GSupplicantP2PInviteParams *invite_params =3D NULL;=0A=
+ =A0 struct connman_service *service;=0A=
+ =A0 struct connman_network *network;=0A=
+ =A0 struct connman_peer *connman_peer;=0A=
+ =A0 GSupplicantPeer *gs_peer;=0A=
+=0A=
+ =A0 DBG("group %p", group);=0A=
+=0A=
+ =A0 if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)=0A=
+ =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)=0A=
+ =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&iter, &peer_path);=0A=
+=0A=
+ =A0 invite_params =3D g_try_malloc0(sizeof(GSupplicantP2PInviteParams));=
=0A=
+ =A0 if (!invite_params)=0A=
+ =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 invite_params->peer =3D peer_path;=0A=
+=0A=
+ =A0 g_supplicant_interface_p2p_invite(group->interface, invite_params, p2=
p_invite_callback, NULL);=0A=
+=0A=
=A0 =A0 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
=A0}=0A=
=A0=0A=
diff --git a/src/peer.c b/src/peer.c=0A=
index 03c96c0..e81a038 100644=0A=
--- a/src/peer.c=0A=
+++ b/src/peer.c=0A=
@@ -68,6 +68,9 @@ struct connman_peer {=0A=
=A0 =A0 GDHCPServer *dhcp_server;=0A=
=A0 =A0 uint32_t lease_ip;=0A=
=A0 =A0 GSList *services;=0A=
+ =A0 const char *device_address;=0A=
+ =A0 bool is_groupOwner;=0A=
+ =A0 int config_methods;=0A=
=A0};=0A=
=A0=0A=
=A0static void settings_changed(struct connman_peer *peer);=0A=
@@ -363,6 +366,13 @@ static void append_peer_services(DBusMessageIter *iter=
, void *user_data)=0A=
=A0 =A0 dbus_message_iter_close_container(iter, &container);=0A=
=A0}=0A=
=A0=0A=
+static void append_peer(DBusMessageIter *dict, void *user_data)=0A=
+{=0A=
+ =A0 //TO-DO: Implement append_peer function=0A=
+ =A0 dbus_bool_t val;=0A=
+ =A0 struct connman_peer *peer =3D user_data;=0A=
+}=0A=
+=0A=
=A0static void append_properties(DBusMessageIter *iter, struct connman_peer=
 *peer)=0A=
=A0{=0A=
=A0 =A0 const char *state =3D state2string(peer->state);=0A=
@@ -374,6 +384,7 @@ static void append_properties(DBusMessageIter *iter, st=
ruct connman_peer *peer)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING, &state);=0A=
=A0 =A0 connman_dbus_dict_append_basic(&dict, "Name",=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_STRING, &peer->name);=0A=
+ =A0 connman_dbus_dict_append_dict(&dict, "P2P", append_peer, peer);=0A=
=A0 =A0 connman_dbus_dict_append_dict(&dict, "IPv4", append_ipv4, peer);=0A=
=A0 =A0 connman_dbus_dict_append_array(&dict, "Services",=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_DICT_ENTRY,=0A=
@@ -617,8 +628,9 @@ static int peer_connect(struct connman_peer *peer)=0A=
=A0=0A=
=A0 =A0 if (peer_driver->connect){=0A=
=A0 =A0 =A0 =A0 if(!pin || strlen(pin)=3D=3D0){=0A=
- =A0 =A0 =A0 err =3D peer_driver->connect(peer,=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_PEER_WPS_PBC, NULL);=0A=
+ =A0 =A0 =A0 =A0 =A0 err =3D __connman_agent_request_peer_authorization(pe=
er,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_authorization_cb, tru=
e,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_dbus_sender(peer), NULL);=
=0A=
=A0 =A0 =A0 =A0 }else{=0A=
=A0 =A0 =A0 =A0 err =3D peer_driver->connect(peer,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_PEER_WPS_PIN, pin);=0A=
@@ -687,11 +699,9 @@ static DBusMessage *connect_peer(DBusConnection *conn,=
=0A=
=A0 =A0 g_list_free(start);=0A=
=A0=0A=
=A0 =A0 peer->pending =3D dbus_message_ref(msg);=0A=
-=0A=
=A0 =A0 err =3D peer_connect(peer);=0A=
=A0 =A0 if (err =3D=3D -EINPROGRESS)=0A=
=A0 =A0 =A0 =A0 return NULL;=0A=
-=0A=
=A0 =A0 if (err < 0) {=0A=
=A0 =A0 =A0 =A0 dbus_message_unref(peer->pending);=0A=
=A0 =A0 =A0 =A0 peer->pending =3D NULL;=0A=
@@ -1202,15 +1212,6 @@ static void disconnect_peer_hash_table(gpointer key,=
=0A=
=A0 =A0 peer_disconnect(peer);=0A=
=A0}=0A=
=A0=0A=
-struct connman_peer *connman_peer_get_by_path(const char *path)=0A=
-{=0A=
- =A0 struct connman_peer *peer;=0A=
-=0A=
- =A0 peer =3D g_hash_table_lookup(peers_table, path);=0A=
-=0A=
- =A0 return peer;=0A=
-}=0A=
-=0A=
=A0void __connman_peer_get_properties_struct(DBusMessageIter *iter, gpointe=
r user_data)=0A=
=A0{=0A=
=A0 =A0 struct connman_peer *peer =3D user_data;=0A=
@@ -1223,6 +1224,15 @@ void __connman_peer_disconnect_all(void)=0A=
=A0 =A0 g_hash_table_foreach(peers_table, disconnect_peer_hash_table, NULL)=
;=0A=
=A0}=0A=
=A0=0A=
+struct connman_peer *connman_peer_get_by_path(const char *path)=0A=
+{=0A=
+ =A0 struct connman_peer *peer;=0A=
+=0A=
+ =A0 peer =3D g_hash_table_lookup(peers_table, path);=0A=
+=0A=
+ =A0 return peer;=0A=
+}=0A=
+=0A=
=A0int __connman_peer_init(void)=0A=
=A0{=0A=
=A0 =A0 DBG("");=0A=
diff --git a/src/technology.c b/src/technology.c=0A=
index 10041a1..98c98b2 100644=0A=
--- a/src/technology.c=0A=
+++ b/src/technology.c=0A=
@@ -969,6 +969,16 @@ make_reply:=0A=
=A0 =A0 return reply;=0A=
=A0}=0A=
=A0=0A=
+void __connman_technology_p2p_invitation_result(struct connman_technology =
*technology, int status)=0A=
+{=0A=
+ =A0 if(technology->type !=3D CONNMAN_SERVICE_TYPE_P2P)=0A=
+ =A0 =A0 =A0 return;=0A=
+=0A=
+ =A0 connman_dbus_property_changed_basic(technology->path,=0A=
+ =A0 =A0 =A0 =A0 =A0 CONNMAN_TECHNOLOGY_INTERFACE, "P2PInvitationResult",=
=0A=
+ =A0 =A0 =A0 =A0 =A0 DBUS_TYPE_INT32, &status);=0A=
+}=0A=
+=0A=
=A0static DBusMessage *set_p2p_listen(struct connman_technology *technology=
,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBu=
sMessage *msg, bool enable)=0A=
=A0{=0A=
@@ -1404,6 +1414,8 @@ static DBusMessage *scan(DBusConnection *conn, DBusMe=
ssage *msg, void *data)=0A=
=A0{=0A=
=A0 =A0 struct connman_technology *technology =3D data;=0A=
=A0 =A0 int err;=0A=
+ =A0 DBusMessageIter iter;=0A=
+ =A0 bool priority =3D false;=0A=
=A0=0A=
=A0 =A0 DBG("technology %p request from %s", technology,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 dbus_message_get_sender(msg));=0A=
@@ -1412,11 +1424,21 @@ static DBusMessage *scan(DBusConnection *conn, DBus=
Message *msg, void *data)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !technology->enabled)=0A=
=A0 =A0 =A0 =A0 return __connman_error_permission_denied(msg);=0A=
=A0=0A=
+ =A0 if (!dbus_message_iter_init(msg, &iter))=0A=
+ =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_BOOLEAN)=0A=
+ =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&iter, &priority);=0A=
+=0A=
=A0 =A0 dbus_message_ref(msg);=0A=
=A0 =A0 technology->scan_pending =3D=0A=
=A0 =A0 =A0 =A0 g_slist_prepend(technology->scan_pending, msg);=0A=
=A0=0A=
- =A0 err =3D __connman_device_request_scan_full(technology->type);=0A=
+ =A0 DBG("technology scan set priority =3D %s", priority?"HIGH":"LOW");=0A=
+=0A=
+ =A0 err =3D __connman_device_request_scan_full(technology->type,priority)=
;=0A=
=A0 =A0 if (err < 0)=0A=
=A0 =A0 =A0 =A0 reply_scan_pending(technology, err);=0A=
=A0=0A=
@@ -1430,7 +1452,7 @@ static const GDBusMethodTable technology_methods[] =
=3D {=0A=
=A0 =A0 { GDBUS_ASYNC_METHOD("SetProperty",=0A=
=A0 =A0 =A0 =A0 =A0 =A0 GDBUS_ARGS({ "name", "s" }, { "value", "v" }),=0A=
=A0 =A0 =A0 =A0 =A0 =A0 NULL, set_property) },=0A=
- =A0 { GDBUS_ASYNC_METHOD("Scan", NULL, NULL, scan) },=0A=
+ =A0 { GDBUS_ASYNC_METHOD("Scan", GDBUS_ARGS({ "priority", "b" }), NULL, s=
can) },=0A=
=A0 =A0 { },=0A=
=A0};=0A=
=A0=0A=
=0A=
=0A=
