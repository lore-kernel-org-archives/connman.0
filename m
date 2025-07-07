Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296E1C3F36
	for <connman@lists.linux.dev>; Mon,  7 Jul 2025 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871902; cv=fail; b=g/HYUzTXfO9E8oH8t5SLEhIeNqEGpKsVgOgqrUVtXBSBKph/Zkg5JlWccLcsRPiK8XIPYBVRxsHAs0gtnCaeZ75bABWaUv+buQgJhyqdIePwbJtYw9wwoFsRDexIfg3v2XikPIj8UMrFrDRQyw9B6/YM4FF3956HsarDxTF9Yos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871902; c=relaxed/simple;
	bh=83ZtcfOjuAukYctbKCtYp5uaFW7DngaDXP60asYPDv4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VM0DNyq7ENNLCPOyaGY8KsEVfJ7J0FV5P3L+0IrM567sLefcoCRahjxlToCQH5QuIlfujzzgr2AxjZaKVBCfBA6gvrDGtiOYDdrsSUd1IpPHoQHUEz1ITDtVx80PhsTWHfixWxnAffN8DiQU33DIpSjZP+nLZr3gn2LHVXU6D1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.51 with ESMTP; 7 Jul 2025 16:04:56 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo3.lge.com) (165.244.66.183)
	by 156.147.1.126 with ESMTP; 7 Jul 2025 16:04:56 +0900
X-Original-SENDERIP: 165.244.66.183
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO PUWP216CU001.outbound.protection.outlook.com) (40.93.139.7)
	by 165.244.66.183 with ESMTP; 7 Jul 2025 16:08:25 +0900
X-Original-SENDERIP: 40.93.139.7
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBq71NZSxhG6kxSKc63NiPK9oy++AaySVs0S8vpV9FMhVcHY7DJaDEOPZya6YokVOUji5ZZhffwgNCvE0bcs1gpsPIH5kRtBzHtWIIspjgUutbj/e7ntb/Xja5N+21M8tUTOh/zv2mTITLdqxtGdR3R+KmyTV3TSOYo3mtkfQxTH2J2G2gOjGE6L4PtABtKkpUt2VK8x56yOWE0m2xPGNZ6RNhGHanOpvWSyEeMsAyea6YJBKSA/q4TETQMJPdW75DByvzgATIDrGZQs7TJN1PYapfgMfAgQjqYmsZgGs3/6vmVznxsJsVZdotZgAkCfE5KcyeP71Db2845RS04igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83ZtcfOjuAukYctbKCtYp5uaFW7DngaDXP60asYPDv4=;
 b=KfLM9Buhx8w61AtJ+DJlauuJ+L2qDWrYZOW19ergIplab0U359WJDHUiOopC5AA7mMbBqw8HwTURD+86ZQf5PTBjdgauQVTl5ukZHI7Mi302sUn9xuz59X+2ttlOxt+HAguczEAQXMFXXdC++14z7nX3FdvDgkq5A6qunyVMIbKXQgPQtkIndqNg+VRx1pC69jhpCmeYbS0+RYnR0Oe0hxswmuRRawWLgUHjspCk8qrbokQqTnEfQn9M6YIvJj0grXpvvGhtHk80EXL0fnARCWKyXhfNIIJr864NEKBS3n0DS5R4aSEDr5dvsNoATo/ZjPgP3hdejG2xO7bFpTz+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by SE1P216MB2148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 07:04:55 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:04:54 +0000
From: Shailesh Rathod/LGSI Connectivity Team <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject: [PATCH] Connman : Add support for P2P WPS (PIN/PBC) in ConnMan
Thread-Topic: [PATCH] Connman : Add support for P2P WPS (PIN/PBC) in ConnMan
Thread-Index: AQHb7w0Nygn3MV6jdEWVBV6+UhcmwA==
Date: Mon, 7 Jul 2025 07:04:54 +0000
Message-ID:
 <SE1P216MB264701522C92F2327FD04590F04FA@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|SE1P216MB2148:EE_
x-ms-office365-filtering-correlation-id: 756dc5d6-24d0-4e74-e64a-08ddbd249374
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UnYAr9WMJxxcee9w8hJ/HvTyMp4FkRdymWtYNLo1UErQe6tmCwBzI8cXhW?=
 =?iso-8859-1?Q?CBSQner/zQx8sSFi0f5e4D6hFxpG7/ZvcHdVP1Aui/KbiDJ6/e2duLvFnJ?=
 =?iso-8859-1?Q?+n2pD6fIPLoVSHJ/B3ZUKQK+Sn7Y/yaBFg3O9t04LuCiUC0Ny9NERTZF/1?=
 =?iso-8859-1?Q?x6Vt8+JVFaKZ0xVM5TgtlIr/LmT2d9OHWz1DqhXAcVU8EVVbkFtfQhWZ4h?=
 =?iso-8859-1?Q?n3BmXXcmBp1RRzyoxMHcCKdaRmsJfm9PxJouCuAUxUfVNr+rK3IsfE0tc3?=
 =?iso-8859-1?Q?t0d03rJxsCXUB4UKFmTtkaETm/eZsEGDVhlkmSu4KC3l/vwTac1c76M4un?=
 =?iso-8859-1?Q?oFMYg++aNgObEECAFjABxGql25cHNwIrLO9AIgwZkSZJdx45L6/oQDhwNw?=
 =?iso-8859-1?Q?vFhSwcnY3ZxZUlpKTd5sSpMLQRfPRRcP8lW/fDIbpIpIi7POhfAYVrbzNj?=
 =?iso-8859-1?Q?ZsjQd6lfVWPz6TbC8Rk61rQebcEuRkcqfDuJYIzak1DE9fsE7HO/CYAAh3?=
 =?iso-8859-1?Q?skvWRKhTP9ranWABpklraNRqW1fNEgFW2zJpD9gtJJ83asnojMaUgXpNsY?=
 =?iso-8859-1?Q?ULJDk1dgNU269Rt0u5JPfgCuegsXfEKaGC2u0v4wxW/IDfDLHs0MtVnFRg?=
 =?iso-8859-1?Q?ZMBbNazgYu6CFJU8o/lzuccE+GaOo8i5efsFG4R0VOfefEBalaltuepA9H?=
 =?iso-8859-1?Q?FOpxyaIZdCFajNv7N8ahZqo31d4Vqr8UosHQPXuCyHQIX5h1g5GO9t0WH1?=
 =?iso-8859-1?Q?r9TC3TZ78BlUT1AbthGialEbTePQPtyK43On6k5bwyoE+4Xkm1BKZs02dJ?=
 =?iso-8859-1?Q?8dbF702LJ1z1j5VUpr9wU4dRfU7/Y620ztZ2Z0NDH9C/AlW2Vr2UpAyjBI?=
 =?iso-8859-1?Q?tSlI6tLtyyl76r0IE3Jkd1khyY9cFNsWYLwXhEP5EHvY5xNLcVU1aBfXne?=
 =?iso-8859-1?Q?V6As7Enj0hO7eTdh+cCAY0DvuE6rXPqkbo8G4PqD0KCzW6w67KJcUg+7UN?=
 =?iso-8859-1?Q?UCoSj8P3Pdo9HKQI1TJHDcMaUFFY1q+FVA5DX7yS0M/Xf7icSGDGBx/D0P?=
 =?iso-8859-1?Q?72DlwocGpIJ03eStMScxIZd4gigypn268PPX0VEm6Bdinu/0RTJq262EbN?=
 =?iso-8859-1?Q?PcmYzxlEUXAbNTUdxwc51hA9F8YbVfUi3udAZ5hG0AB+K7X2wr8UFX3fX3?=
 =?iso-8859-1?Q?EpgSdkNz0qdIdXh7uJl5em3tI0/b/WOAjThoM0noQRljgJHDypkFCHb58y?=
 =?iso-8859-1?Q?unYvUznIHI2or3KrSe7Jdcp8qJSZ3GVC7/j8fHo4M8+G/hu2DE/zhFhS6/?=
 =?iso-8859-1?Q?JG2q/9KOlUXjrXM3Bf6w4dDrjWp7mfSOqEvrppvFNVHjTCHzuNCWl+wRsB?=
 =?iso-8859-1?Q?PKoD5myBkHotQya/UB+gmrUAhTJfdmFbyCqmsw9fy4Ov+x7dtFUKsU1S5u?=
 =?iso-8859-1?Q?1QxNMVPujlYbERNOzdi79EBaLlEzBjuWh6cNIfwdMrc3d/JXJuq1/dktlA?=
 =?iso-8859-1?Q?+yQmQl2V061XJ5eURh0IpUsoooKeN4NVxutsFtLMCc0w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ercfXbhhczssr4DRGRXgC0n7MpotGM5JGWAL7gL6USe0dAeP5W8QH66NLg?=
 =?iso-8859-1?Q?qHlQbl0YGjgMSE7ghFyK5eAnpBiufhEN2Noap99hwFUG4TnXh8h/MofhUM?=
 =?iso-8859-1?Q?WyJ56kpDgMVjhv3VTKSCqWHq3y5bZEIfR0w+e7p5QrmjWMn6MVGRT6OC6P?=
 =?iso-8859-1?Q?UvOugZYp5ulxhHLoXfFrFc62nNc3bOrLSXchJboT61kryb0p4/K/BdOoiC?=
 =?iso-8859-1?Q?//gpn0Q7kowNdqrJg+NJ+FZGz0pEL9wjzeHAm2yt0z4+UrRPRAiAqs7k+o?=
 =?iso-8859-1?Q?VggsJsBzNEA8aDMF6H2J3COz06voyxVrLOBy3XQoqG+BHgMO49s9pRjg7z?=
 =?iso-8859-1?Q?4xakqZpGSjwCk65GX4dKRMXaM5QLPNs5lp04VdnU1nCZul4wo4oxl1hh8k?=
 =?iso-8859-1?Q?W7yeGVcjV+UDG3ho7Id9+vUOLQK0PPd1DyQlLwjVh65Ib/WfDhnsCxmapH?=
 =?iso-8859-1?Q?Zdm5iCF8I++U/4aG8cWiM6D/NnqSivqmu0dlGwTk/gx1My8yxW5QN3PuDu?=
 =?iso-8859-1?Q?6mfFhMgoTNLFF+ZBwLzSaJTiCArN4Gc7HnpO9oqNNQ/4Vx+vESYR7UNBTg?=
 =?iso-8859-1?Q?56E+Qf5PCqHXz2VryTYrw7ANmw0Mh6itc6JO6JmaUmuZd8LZDdJ2VhWWUj?=
 =?iso-8859-1?Q?F/KPdIiAogbcQbiIrIQBYfHG4qy12IeX5pIPuU3RXTPUzvPeDpqr0IT9J/?=
 =?iso-8859-1?Q?QHNg1NtRZFngHbBHS7aRty8ihtQPrys1+EQoXiQKgKmvLqvNseU2XS694e?=
 =?iso-8859-1?Q?pEDTEgunz9CoDfx9sR0Go44UU23qeG+No1Zj2kRatwFYgZBb6zP5zC6Dr/?=
 =?iso-8859-1?Q?fd58RyW9ceONumTb/ABDQLWu/5LxFf2uaHz+NCQRV/mil9pUx2GemKvzF4?=
 =?iso-8859-1?Q?EQ/dcwbIiRr0tx+Ubw1nyYWWtwVGQNB7mr/WngbFiRgCV/XeJ6K3mX1Qq1?=
 =?iso-8859-1?Q?WMc03M5WHUCGYtbiHHFrq4o5/awEyKdg1H9OD3pH4LnG3aOn/y3KRZsJbJ?=
 =?iso-8859-1?Q?rrt0Rybedj7i2D27bdD84Hn8V7eX1FODbJ/SiNzwJVrVAU83/NVxKDqo94?=
 =?iso-8859-1?Q?p63voro1sG3l1DkyiE4ouZnG0gOXWRY5uX4v/XFogjIvel7VMonWZHSrt4?=
 =?iso-8859-1?Q?g0bagG73drMHOywtYdA5mswJRdxo51hFKjvpyaYX5Gol/jbQRxMEade1o6?=
 =?iso-8859-1?Q?R3S8S16KWg78uPWcBAg2r6SAGFDNsm/9P/SSoMzhHjD31Y79rgCXfthgzz?=
 =?iso-8859-1?Q?b0gBM8vK4Mrso1gG712BwduQ5kda0N2ipHTQhWoRBsLR4vqrTrUFOzS3u5?=
 =?iso-8859-1?Q?VAld1Wneo9DgOEE+ri10EZEcg+i0k8NJPwWHBZZkjdF6xq2iESIfDnq/En?=
 =?iso-8859-1?Q?BNNGmFP+wqdLVBuY+UzznBXGff/Fy4ETXZQxBTo1xmyy8sdhjth7Mj01yf?=
 =?iso-8859-1?Q?uDIOruLbrZqMUkQ5YmVmZc4vQG4AkV3QgX/k43LAEtbyKiagLw4Ij5qke1?=
 =?iso-8859-1?Q?NNPf53Jq3RI+QSj9hVPmxlUyaMVitmIad3ttGzKE3xLQKRDmHZtCudjC5U?=
 =?iso-8859-1?Q?mfbP9x1MH3qaralJKGJ0Z1ur+pr6b4XVBB/K8hNDLFiVB3FsKs+xfvSGIF?=
 =?iso-8859-1?Q?Clrpr/qox1urQale67aJ3/ujJBzmDYg21i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 756dc5d6-24d0-4e74-e64a-08ddbd249374
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 07:04:54.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hysO6E/M3VqUNQr0sORkeS+AFtivKz0FnrlpJ6YXxxpOrJUsev9jwNvpkZS/+DHwyZhjyK7ci2poh14H4oCuyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2148

From 3ec1fad48a93a88d900e88c01e33a62309dce428 Mon Sep 17 00:00:00 2001=0A=
From: shailesh rathod <shailesh.rathod@lge.com>=0A=
Date: Mon, 9 Jun 2025 19:52:30 +0900=0A=
Subject: [PATCH] Add support for P2P WPS (PIN/PBC) in ConnMan=0A=
=0A=
- Enable P2P WPS connection using either PIN or Push Button Configuration (=
PBC) methods.=0A=
- Store and retrieve the WPS PIN via ConnMan's configuration storage.=0A=
- Add "WiFi.PinWPS" property to the technology D-Bus interface for setting =
and saving the WPS PIN.=0A=
- Update peer connection logic to use the appropriate WPS method based on t=
he presence of a PIN.=0A=
- Ensure proper memory management for the WPS PIN in the technology structu=
re.=0A=
---=0A=
=A0src/peer.c =A0 =A0 =A0 | 14 ++++++++++++--=0A=
=A0src/technology.c | 26 +++++++++++++++++++++++++-=0A=
=A02 files changed, 37 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/src/peer.c b/src/peer.c=0A=
index bad5c84..2b2c636 100644=0A=
--- a/src/peer.c=0A=
+++ b/src/peer.c=0A=
@@ -609,9 +609,19 @@ static int peer_connect(struct connman_peer *peer)=0A=
=A0 =A0 if (is_connected(peer))=0A=
=A0 =A0 =A0 =A0 return -EISCONN;=0A=
=A0=0A=
- =A0 if (peer_driver->connect)=0A=
+ =A0 GKeyFile *keyfile =3D __connman_storage_load_global();=0A=
+=0A=
+ =A0 char *pin =3D g_key_file_get_string(keyfile, "WiFi", "WiFi.PinWPS", N=
ULL);=0A=
+=0A=
+ =A0 if (peer_driver->connect){=0A=
+ =A0 =A0 =A0 if(!pin || strlen(pin)=3D=3D0){=0A=
+ =A0 =A0 =A0 err =3D peer_driver->connect(peer,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_PEER_WPS_PBC, NULL);=0A=
+ =A0 =A0 =A0 }else{=0A=
=A0 =A0 =A0 =A0 err =3D peer_driver->connect(peer,=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_PEER_WPS_UNKNOWN, NULL);=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONNMAN_PEER_WPS_PIN, pin);=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 }=0A=
=A0=0A=
=A0 =A0 if (err =3D=3D -ENOKEY) {=0A=
=A0 =A0 =A0 =A0 err =3D __connman_agent_request_peer_authorization(peer,=0A=
diff --git a/src/technology.c b/src/technology.c=0A=
index 3f3b022..fc90663 100644=0A=
--- a/src/technology.c=0A=
+++ b/src/technology.c=0A=
@@ -86,6 +86,7 @@ struct connman_technology {=0A=
=A0 =A0 bool hardblocked;=0A=
=A0 =A0 bool dbus_registered;=0A=
=A0 =A0 bool p2p_listen;=0A=
+ =A0 char * wps_pin;=0A=
=A0};=0A=
=A0=0A=
=A0static GSList *driver_list =3D NULL;=0A=
@@ -215,6 +216,12 @@ static void technology_save(struct connman_technology =
*technology)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Tethering.Freq",=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 technology->tethering_freq);=0A=
=A0=0A=
+ =A0 if (technology->wps_pin) {=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 g_key_file_set_string(keyfile, identifier,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "WiFi=
.PinWPS",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 techn=
ology->wps_pin);=0A=
+}=0A=
+=0A=
=A0done:=0A=
=A0 =A0 g_free(identifier);=0A=
=A0=0A=
@@ -1220,7 +1227,24 @@ static DBusMessage *set_property(DBusConnection *con=
n,=0A=
=A0 =A0 dbus_message_iter_get_basic(&value, &enable);=0A=
=A0=0A=
=A0 =A0 return set_p2p_listen(technology, msg, enable);=0A=
-} else=0A=
+}else if (g_str_equal(name, "WiFi.PinWPS") =3D=3D TRUE) {=0A=
+ =A0 const char *pin =3D NULL;=0A=
+=0A=
+ =A0 if (type !=3D DBUS_TYPE_STRING)=0A=
+ =A0 =A0 =A0 return __connman_error_invalid_arguments(msg);=0A=
+=0A=
+ =A0 dbus_message_iter_get_basic(&value, &pin);=0A=
+=0A=
+ =A0 // Save the WPS PIN to the technology struct=0A=
+ =A0 g_free(technology->wps_pin); =A0 // free old if any=0A=
+ =A0 technology->wps_pin =3D g_strdup(pin);=0A=
+=0A=
+ =A0 // Call save function=0A=
+ =A0 technology_save(technology);=0A=
+=0A=
+ =A0 if (err < 0)=0A=
+ =A0 =A0 =A0 return __connman_error_failed(msg, -err);=0A=
+}else=0A=
=A0 =A0 =A0 =A0 return __connman_error_invalid_property(msg);=0A=
=A0=0A=
=A0 =A0 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);=0A=
=0A=
=0A=
