Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC3279910
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226307; cv=fail; b=EMqyFBYwus4Pwl95NQP55mwjH++FHm5okTz7QkGINDx0q8dnqUFVT4z42Pj15V6jjz6KDtk+PxwOhDjGxfHrXAHeEMxQGg3Xy8x/idkVeWi/78Ex1RKsDTvlpjqbAdU4UNUJHWfLHEbH+euTcqUH8KnDdoNDzURJW5QiHfI8hgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226307; c=relaxed/simple;
	bh=JwVqP3RQLlwssSe4SBac6exuBD9sg8tEQQy5jnTNBW4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y9y9yPicEmnssDh23icbu58RZbBAWdiT8Nr+WVuNAuCwor+M8KVLM1Wcvxnoot6+VPhUmBD2t+PostJDzHAbqa3FbBFO/2Lk/M0VdA18xNijS/Gufd/LR9atk5uP/byuto1fIvMw2D6creIag8g3t8h8vUrmXZW+AjvcZJRa/Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
	by 156.147.23.51 with ESMTP; 11 Jul 2025 18:31:34 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo7.lge.com) (165.244.66.188)
	by 156.147.1.151 with ESMTP; 11 Jul 2025 18:31:34 +0900
X-Original-SENDERIP: 165.244.66.188
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO SE2P216CU007.outbound.protection.outlook.com) (40.93.138.24)
	by 165.244.66.188 with ESMTP; 11 Jul 2025 18:37:34 +0900
X-Original-SENDERIP: 40.93.138.24
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+qO1GGH6SC1LyoeiqrljTxtFPK5prvUW2U9AOHq2+hpA52yT6/ef1ysh0TwXgEe6BEv6vV+mYmbqGPx3CD7cHNMP95YmaX8+jR1KOZJFZ/c3J/VwOZsO7qQXP0MhPuQo9R9qx3RSXbJHYZ1E3b2NqHUzHmV2CWBtlk4bhHtvRAvdRl22dpaQJM1q7uHhbC4kMgR3VONpV9oTwDMFuv9LIKj0pSn1JtMmg327tW5fmKNfMfbOP5azvo8iTWJGdpZ3BPob4ak4CkWM8B2hywToWOtzSwl6sYUM8itv0Ht7c1Seza7kgROc9mz4KM/XRpGC0W7GJ++24lGUUqw1+TysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwVqP3RQLlwssSe4SBac6exuBD9sg8tEQQy5jnTNBW4=;
 b=pBzcwYQqsFy4YPtve6VoJ/8nfGAtNv/yGrut/N4c6Y6RIsYhPdQXnDjw3ODPhvpp3wvzTGnzfPTCpA1dvKSnOkC1qbALRKppxQp5GLdc7g/YLgs/J7C4PXR/0xukHYYTTovqf6FQphD/5J6wMAhdyc+PlwgDrV4HzLAILAq0SSFYHPYmdhOBbH4D55EroK08E7Kx8dW3dKAT8LgsHqTSOO/f/RQ6fIZo7lg6HcbefPJptxKWq9LkrOqY1KVJOEnBhA4d31xXGvwNJKMLJWuXx0dffgVxExWRWmd8elis5P6pmaGRSd2jtRolf0TEawxdGoeWub5UyaNVEa8UcXngRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by PU4P216MB1503.KORP216.PROD.OUTLOOK.COM (2603:1096:301:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:31:32 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%7]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 09:31:32 +0000
From: Shailesh Rathod/LGSI Connectivity Team <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject: [PATCH] Connman : Allow connmanctl to trigger Wi-Fi scan
Thread-Topic: [PATCH] Connman : Allow connmanctl to trigger Wi-Fi scan
Thread-Index: AQHb8kYZnBFl8lciiU+B6do3gFfvVA==
Date: Fri, 11 Jul 2025 09:31:32 +0000
Message-ID:
 <SE1P216MB264730620165FFEBF76CD1B9F04BA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|PU4P216MB1503:EE_
x-ms-office365-filtering-correlation-id: 77f22a97-67bf-4d2e-3754-08ddc05db8dd
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZtnB1LAqoNxFcZwgo6tQog3DgLxXBzU7v7q8oThL9Fp46Q6lHziVTVl/mk?=
 =?iso-8859-1?Q?o7WtcME73dqoWBTy6gzxuNX0RsTV6yKLrHcsxTb4diioLcTHtpOBLEa9qv?=
 =?iso-8859-1?Q?20fzNEgoqu7w6NMXdJG6ZAnPsIhmNVheGPwK1H6+LQSxbiP3u+edBN13UJ?=
 =?iso-8859-1?Q?La+sfPo+PCUaRGkvghYs7MjwzV3DcS+9QnjTUh5G+tAMC5ZWa13qO/tjv+?=
 =?iso-8859-1?Q?n9qPGiSjZBeWCf4N5i+fTZLED5ZRndb8P6bCFAa2D6lhXBELPJW/zyGnMd?=
 =?iso-8859-1?Q?8la/uMz1GaR1DUiV7Mjsj/j8niDhY0/xY8efQj6hovraA2JMp0esYlGWGV?=
 =?iso-8859-1?Q?O03iQ4Pc4tenp4DnBUFDQaJRv92fATVhJiO1yHpBdYknu1MU1NKdql71xr?=
 =?iso-8859-1?Q?VTnVQ6RPJvMeu3jXjNaAlHrrAYTeEO2h+/7e5VbpxsQ+8Cav0ReOf7MsIJ?=
 =?iso-8859-1?Q?RzHHpGFO5n6AoHb3X2tTA6NGBXhpR2b9WB81Z1zWTPE3lJUTV4T4S5DgNx?=
 =?iso-8859-1?Q?aIjmnPa+KuBxyVoRokC9Ltm/xWCuD5reoCNY0Igy1KEtDg+1wKeLz9sMW6?=
 =?iso-8859-1?Q?zxp/EM9+6YjDIf57SUv03rLbkSshNN7JLkNt2CB4CjwlwRatKTwH9XBfNr?=
 =?iso-8859-1?Q?oWc2ttE8olEsqPxi6EqS5XSH1tzwKO1ZrhKGhnvRhu5YKj3+CX7DghaYiS?=
 =?iso-8859-1?Q?ZyrS1/Ic4q7+bdtoP79gPGrEc4sOqsFXnBIMEQMTZeiPovm+mEt+WI/YNv?=
 =?iso-8859-1?Q?dnYlPfqd8s6l3P8Sc2IGqHosxCUrC4iKbxKOiGW4lHClSY7A63bwvo1f4Z?=
 =?iso-8859-1?Q?WBMBuO8F09rD11M7JrMemCXudW0WuNvCX8AEQ2a2l5nouFSsGwNte+MvAt?=
 =?iso-8859-1?Q?xN2zhloWInvH9BpqUNKr0xZIE1nhcbEaaW++tqnnIn5wDA+sK+6zG22Mb5?=
 =?iso-8859-1?Q?SpUDvopnd2/ZjgHVCJpxx5QHB+lq3KSppPUB/7Cgv3xsBJBm34I/5S9LPc?=
 =?iso-8859-1?Q?Hqkvy6Gz4ejx6TzwhxrUZhGo+O11YQkbwqIeqt9QDjw3kUQGMGbR1LXGeM?=
 =?iso-8859-1?Q?IoIDh6jXkYQXffsNhdPl4V7WxXYF2eNHZJzIitPC+cTn3/vjQuEPw7ILM2?=
 =?iso-8859-1?Q?tcNN1EzmAmizFcqLQ5Vdokcp/3fIBsqNxVDM1c4e1bfy3TV0tcu7fs5phR?=
 =?iso-8859-1?Q?dqMvirjN6bkJezmgW0vGubhKZlT4bArLe73AOcQmR0FrCWU/8eGyrrxWIn?=
 =?iso-8859-1?Q?W7SN5N1qdtrMvQepOxHviDcPd0dQUPR65+XdJuPaXbVep/95wjXPfntAjf?=
 =?iso-8859-1?Q?8CjYB0rbMFcXBH6vd7+ekAVjoKQ2MTe5dA548nQFAKO2mAg7lYRxlscR3u?=
 =?iso-8859-1?Q?HxspGK5CqwNDyMvUjOsr1Gs3ovZ8d87l7FIb9bcgv42Xh9OkOCANZwqaT6?=
 =?iso-8859-1?Q?QqkAvYDzDxY6EMDJ5zm5BidescOPv7Qdvq6UU49lBdrjJ47Pytvm5obLKv?=
 =?iso-8859-1?Q?NODoSJU0dXjVBcWCu1arm7fudTi/T+jEic7Xz5f0QY8Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wrfFzFyv4GGFbuOivobwjHIcrai3PhkC6skhY1nQJXBSl5iN0nNLoMrRzM?=
 =?iso-8859-1?Q?SBS2MtGCB2P8g0ajKJboRSt7Xy7W+HSsBuHV3PLBJIUPz88mjSO53GmQ+W?=
 =?iso-8859-1?Q?N8VhQvnxTP52L4/Vki3UBWmHk3M7FMvO46tRVtlI5O4CmdvWbbwcdxb7nH?=
 =?iso-8859-1?Q?8TmwQsSOYUv37pVGPifUvzNkOn33hz6IJ7oCU99zS4aixJGODhrjNXMB/n?=
 =?iso-8859-1?Q?vFnDb5Zc04Pjo6Nbwx0z2MgTt97Gxw0n3Vdphw+bVt30iEIMpLkZOS5rq4?=
 =?iso-8859-1?Q?eD+W/ERan+8x8aniRa3OaPVjTHELTTwGbj6wr29jA9YGuelYJg/mg0tFt8?=
 =?iso-8859-1?Q?sg3Yar8xVNlTR++uCPDISNzaljw2fDw3g4ttY7+Aw+qm4wzsNkREaNy+dp?=
 =?iso-8859-1?Q?60RCyE/NbWCbBDYSi/Grri7vAayppg1UwJ/XSDUMeatCBVR6Bl3AD9f54n?=
 =?iso-8859-1?Q?MpkqPWJNYlXGVmqHyfk+FYIVWjIahJOJ14wyoxYICtGFZPzHdOJv3v+HZ0?=
 =?iso-8859-1?Q?pdecAp+wniN0Z8XTvscPmyHXJAZ2+ClZ/CIoQRp2cb8+M6n49gp6X8roio?=
 =?iso-8859-1?Q?9FI80NYW/Tat7UdGI4NvdNtGoEYRy7b9vJ0aeYcbXFiFWl/ccM1CY960b1?=
 =?iso-8859-1?Q?Y5Unt7mdHjEBeADxqiQEZIIWJWOt/cyNu4f0oYf1yxZ9F+bYZpitJP+POv?=
 =?iso-8859-1?Q?6a8kDl4yxv5GOXmGub3YgL1KBVxtcjhcQe8vrBkQcFPzz0G5DDXSqSTEj7?=
 =?iso-8859-1?Q?4bAuDv9gP2XgpE+4nBcyDDIgaNki7T1hwwVkTN+CAZNkEOrxncjWQgJYy8?=
 =?iso-8859-1?Q?xGXuOadQ49qaJi//aDodIqdGaizxK/lwS1exNhGR/UWRmPaohV1kC5h2Nn?=
 =?iso-8859-1?Q?P4qxfup0S24WMc0G9N8k2h8JtZ/xPRuMx+m4ay2LpDiioHdiB0pL4Ptdxx?=
 =?iso-8859-1?Q?PHizatj1UnLNc4auVVxYfkNr4rHHivd54d3y1R8qgejr1yXZSoVVYEsSMc?=
 =?iso-8859-1?Q?z915SS+V+cC6/CcJNXa+dneb2xAayKLQjnovs8hTst6YyaVilNlz7N+pil?=
 =?iso-8859-1?Q?L581+RsN1KNt+MeRfB5EfrCg9kljh8jflTHHozVMvBCBvn8rK57P+FUz4z?=
 =?iso-8859-1?Q?APO0rpw5lBxP2koGuyD2vlgt+VixuYr1E5uo9dcpQ0NGc4ixcukyqfJSJ6?=
 =?iso-8859-1?Q?0q+oa+WPm3LaEiuutkijruQ9hqMooc9QUuQDpnwfpgXDw05IoYxGdNfhDQ?=
 =?iso-8859-1?Q?Go8R0suhc2WFBD+TDifCN3UlXGyvqIYGH4IODNpSk/DNVU5tRIg0aWRwTx?=
 =?iso-8859-1?Q?TSQAdv2t45sAMHJ42gTcCBxcC9wnI3WNdjV9Ebqllf1aPbNSjQgSL9Z1dL?=
 =?iso-8859-1?Q?gamR/tvC2usZjkYqmWAQzc24/I8IZKWrXE1YlEsLSvxnjhdDcswQ8eaIw+?=
 =?iso-8859-1?Q?6vDUe0Lv4vcK2tU3jjFnKkVz3oHh4pI/SeTUwTgg5DDSEWWtsmnllL+WnG?=
 =?iso-8859-1?Q?4kItiI8C6Q2IT2ZieS8SpWQv6CrHo8zhnTST9Hv5zBUiDpVA3542q2wnsD?=
 =?iso-8859-1?Q?0JRMs6yMYKIylG2jxkyx4BTmK+bTYa55H4rJWMN2phzILRlaTFE1CJ8FFF?=
 =?iso-8859-1?Q?1mhRe9csymjL//9JB2Hc67xuS6aYuBhY2X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f22a97-67bf-4d2e-3754-08ddc05db8dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 09:31:32.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOOjS9JbuGq6iasQktDqj/z+H7PQBC/sF6HCuIzGepZR0aorOug/wKYQP1+yu+PaVJdRjp7o0P1j12QOD8jaoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1503

From 7a587f647db2d86404bd1a578ee90447b5e2ce26 Mon Sep 17 00:00:00 2001=0A=
From: shailesh <shailesh.rathod@lge.com>=0A=
Date: Thu, 10 Jul 2025 04:32:13 +0000=0A=
Subject: [PATCH] Allow connmanctl to trigger Wi-Fi scan=0A=
=0A=
Due to P2P Scan feature connmanctl couldn't do Wi-Fi Scan.=0A=
This patch enables the use of connmanctl to=0A=
manually trigger a Wi-Fi scan.=0A=
---=0A=
=A0src/device.c =A0 =A0 | 14 +++++++-------=0A=
=A0src/technology.c | 19 +++++++------------=0A=
=A02 files changed, 14 insertions(+), 19 deletions(-)=0A=
=0A=
diff --git a/src/device.c b/src/device.c=0A=
index 3ab5268..2b75026 100644=0A=
--- a/src/device.c=0A=
+++ b/src/device.c=0A=
@@ -644,7 +644,7 @@ bool connman_device_get_powered(struct connman_device *=
device)=0A=
=A0=0A=
=A0static int device_scan(enum connman_service_type type,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct connman_device *device,=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool priority)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool scan_type)=0A=
=A0{=0A=
=A0 =A0 struct connman_device_scan_params params;=0A=
=A0=0A=
@@ -656,8 +656,8 @@ static int device_scan(enum connman_service_type type,=
=0A=
=A0=0A=
=A0 =A0 memset(&params, 0, sizeof(params));=0A=
=A0 =A0 params.type =3D type;=0A=
- =A0 params.force_full_scan =3D priority;=0A=
- =A0 if(priority)=0A=
+ =A0 params.force_full_scan =3D true;=0A=
+ =A0 if(scan_type)=0A=
=A0 =A0 =A0 =A0 return device->driver->scan_p2p(type, device);=0A=
=A0 =A0 else=0A=
=A0 =A0 =A0 =A0 return device->driver->scan(device, &params);=0A=
@@ -1106,7 +1106,7 @@ void connman_device_regdom_notify(struct connman_devi=
ce *device,=0A=
=A0}=0A=
=A0=0A=
=A0static int connman_device_request_scan(enum connman_service_type type,=
=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool priority)=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool scan_type)=0A=
=A0{=0A=
=A0 =A0 bool success =3D false;=0A=
=A0 =A0 int last_err =3D -ENOSYS;=0A=
@@ -1134,7 +1134,7 @@ static int connman_device_request_scan(enum connman_s=
ervice_type type,=0A=
=A0 =A0 =A0 =A0 if (!device_has_service_type(device, type))=0A=
=A0 =A0 =A0 =A0 =A0 =A0 continue;=0A=
=A0=0A=
- =A0 =A0 =A0 err =3D device_scan(type, device, priority);=0A=
+ =A0 =A0 =A0 err =3D device_scan(type, device, scan_type);=0A=
=A0 =A0 =A0 =A0 if (err =3D=3D 0 || err =3D=3D -EALREADY || err =3D=3D -EIN=
PROGRESS) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 success =3D true;=0A=
=A0 =A0 =A0 =A0 } else {=0A=
@@ -1154,9 +1154,9 @@ int __connman_device_request_scan(enum connman_servic=
e_type type)=0A=
=A0 =A0 return connman_device_request_scan(type, false);=0A=
=A0}=0A=
=A0=0A=
-int __connman_device_request_scan_full(enum connman_service_type type,bool=
 priority)=0A=
+int __connman_device_request_scan_full(enum connman_service_type type,bool=
 scan_type)=0A=
=A0{=0A=
- =A0 return connman_device_request_scan(type, priority);=0A=
+ =A0 return connman_device_request_scan(type, scan_type);=0A=
=A0}=0A=
=A0=0A=
=A0int __connman_device_request_hidden_scan(struct connman_device *device,=
=0A=
diff --git a/src/technology.c b/src/technology.c=0A=
index 98c98b2..fcb5f2b 100644=0A=
--- a/src/technology.c=0A=
+++ b/src/technology.c=0A=
@@ -1415,7 +1415,7 @@ static DBusMessage *scan(DBusConnection *conn, DBusMe=
ssage *msg, void *data)=0A=
=A0 =A0 struct connman_technology *technology =3D data;=0A=
=A0 =A0 int err;=0A=
=A0 =A0 DBusMessageIter iter;=0A=
- =A0 bool priority =3D false;=0A=
+ =A0 dbus_bool_t scan_type =3D FALSE;=0A=
=A0=0A=
=A0 =A0 DBG("technology %p request from %s", technology,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 dbus_message_get_sender(msg));=0A=
@@ -1424,21 +1424,16 @@ static DBusMessage *scan(DBusConnection *conn, DBus=
Message *msg, void *data)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !technology->enabled)=0A=
=A0 =A0 =A0 =A0 return __connman_error_permission_denied(msg);=0A=
=A0=0A=
- =A0 if (!dbus_message_iter_init(msg, &iter))=0A=
- =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
-=0A=
- =A0 if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_BOOLEAN)=0A=
- =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
-=0A=
- =A0 dbus_message_iter_get_basic(&iter, &priority);=0A=
-=0A=
=A0 =A0 dbus_message_ref(msg);=0A=
=A0 =A0 technology->scan_pending =3D=0A=
=A0 =A0 =A0 =A0 g_slist_prepend(technology->scan_pending, msg);=0A=
=A0=0A=
- =A0 DBG("technology scan set priority =3D %s", priority?"HIGH":"LOW");=0A=
+ =A0 if(technology->type =3D=3D CONNMAN_SERVICE_TYPE_P2P)=0A=
+ =A0 =A0 =A0 scan_type =3D TRUE;=0A=
+=0A=
+ =A0 DBG("technology scan =3D %s", scan_type?"p2p":"wifi");=0A=
=A0=0A=
- =A0 err =3D __connman_device_request_scan_full(technology->type,priority)=
;=0A=
+ =A0 err =3D __connman_device_request_scan_full(technology->type,scan_type=
);=0A=
=A0 =A0 if (err < 0)=0A=
=A0 =A0 =A0 =A0 reply_scan_pending(technology, err);=0A=
=A0=0A=
@@ -1452,7 +1447,7 @@ static const GDBusMethodTable technology_methods[] =
=3D {=0A=
=A0 =A0 { GDBUS_ASYNC_METHOD("SetProperty",=0A=
=A0 =A0 =A0 =A0 =A0 =A0 GDBUS_ARGS({ "name", "s" }, { "value", "v" }),=0A=
=A0 =A0 =A0 =A0 =A0 =A0 NULL, set_property) },=0A=
- =A0 { GDBUS_ASYNC_METHOD("Scan", GDBUS_ARGS({ "priority", "b" }), NULL, s=
can) },=0A=
+ =A0 { GDBUS_ASYNC_METHOD("Scan", NULL, NULL, scan) },=0A=
=A0 =A0 { },=0A=
=A0};=0A=
=A0=0A=
=0A=
