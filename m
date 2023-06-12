Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2047.outbound.protection.outlook.com [40.107.9.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B01B1992A
	for <connman@lists.linux.dev>; Mon, 12 Jun 2023 13:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZr8jIFRVOLw/2oMGvqpA3RuNPpSSFMAIshGNcYvgYYA8btXW8dWjnp3xkuCubOoMtLBWwoiqWYw+ZlsgU4ejEB5c3ZkM1+ZhklFLG3oi8pOc6Ge2VFDL9Yrvkn6Wyj5cyJmJec5E2dLaT/ObJzOiXHuJmzksmI0NPJnCSc8VOQ/9lgIFfZOfO/XHA0b/pDGTcL2U3clB35MotDSuI/AryjaJXS+1y+cB3ohifHU3q6b4bIVkia57z7KV3DSXrQyzr7jhQsc0iglesCwmlvQum7uKdznqCy8OY2asbSaXEmih3jht/d8H3yyczHEc/UdjI0hpNfsTx5qU8/iqPfWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6fYF2xUhofzoebIFIbqbDCzExS22cn2WNrkTVybV14=;
 b=CF61GYe+YIrkl1xez+qG15Bm77CfjMddwvjMyaS4oKnRH95fizOrgy0Ks8IkGUbkee3BNGlMUxXDDZF6QVKpi/WrlfwHwuiN+pna/NbuIKa1Ugc8smcTKjLmSQI+asYHqt1ygfad3ciYwz+8vqCJo4JEmuq/I8dCg9HlymosyeccUrGabqhzp9dhbPDa3WOWV1XJlKlzxjE1mrGUryyxH8ngxMxgfkD9foZ87FdnhfN6EiFQuSnAnvyPXUMYk4zmL6FQA5n1I9B+cS+hlhQlqlNWXFFcRmLe2XHDHILHAw73NUPPmuvIr8yiQD1MkiFDf/kfmeuzalaxMu7uKtpT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6fYF2xUhofzoebIFIbqbDCzExS22cn2WNrkTVybV14=;
 b=xQmQ6fMesb1yVUmAv/oTqh3a0AMFA5pcpWH0FDALfJyQI0QZm+4valIIcWjhAd2Ok9O9YHKMjBz6kVpkFQuhea1Y+bwIOY9LpIjzo8LczPihUWqlX1YR0j70R2k8ipoqx645HprEPtbLWfzrhi0LohqSJ1RUpQqTatCS1uguA7g=
Received: from MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:15::22)
 by MR1P264MB1699.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:15::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:19:18 +0000
Received: from MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6da2:b278:fe73:b46b]) by MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6da2:b278:fe73:b46b%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:19:18 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH 3/3] wifi: Fix connect-failed error on user reconnection
Thread-Topic: [PATCH 3/3] wifi: Fix connect-failed error on user reconnection
Thread-Index: AQHZnTBRYpo13UT7VUKWojwPY6103Q==
Date: Mon, 12 Jun 2023 13:19:18 +0000
Message-ID:
 <MR1P264MB1540A3B3D6777C951E8910789354A@MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB1540:EE_|MR1P264MB1699:EE_
x-ms-office365-filtering-correlation-id: 608e2b4b-2c16-4926-b128-08db6b47a090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nMdFyib07/m7+6UHrcRFjDXxGmtIia0MyeqfYxXWwxO2nxmpxNk6AlzwdMuP3GZZvrZgTR67OyLWnSAehu8MFfBAe7zzfoT2TkR0zmHsuFhkkjcHmnuGD+5eviiE1pkVl9PijoX4ssYRTmplS43Uq/va9sWPswmtM8ijUuaCeZFb8FY9bK4P+rJDNU6QUHJs/XsnopwuaS9iqH+oZsuj526mmEjWjqB1zu+BsRgvFHiM7YVHeFAgfG0i5aNKDFvaHmZbenAXNyOrfhycu48P7eHqhZ1AdH4KsyQej1eiR51yPnwCU6ZEHcLSYpwJ9NcPnSWLZpxuzmj8H1Y5oPX3QzMA2mKx2o4Bor4bamgNCGrcTcHZMc2T5PVzlid6xdhXzOJ1MACv2BC+YlPbYdB6i2DyeDnln1LpIAXxLD220lFNRez4HdebUmRd6FaBSNWYKu0G7z4fmtPeViX2q8eRG+WsinmD8asU5vErSHxNlNxRE4DJ6i9dbfbWyNSfVP4CnEqQS9iyHLA7JHvk/mQp1xjNTsLgdiWrIq9aEq20I4lfA5t3DX7dOgTGyk5fH+UBRiscDThFYLTNDH8f95S9/BjK8A+v6u5cXxfAZ86pwCjkCc4FDIi96CB+vEv8fYRU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(316002)(7696005)(41300700001)(83380400001)(86362001)(38070700005)(6506007)(9686003)(186003)(2906002)(4744005)(33656002)(99936003)(122000001)(38100700002)(55016003)(52536014)(8936002)(5660300002)(8676002)(76116006)(66476007)(66946007)(66556008)(91956017)(478600001)(71200400001)(6916009)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qLpYeN2sniNyygx+FfaHBBKDXpkcG23P25WkGx6Wg5h0yytQf2vzJ/g3Gg?=
 =?iso-8859-1?Q?jsTYulECQKT/zaSFYysLRr4Fe9qvVJVM+TIU9VqkMu5JyLWvY/w1PIcVR1?=
 =?iso-8859-1?Q?YDn76is8f7g2QiH+lu9feQ0Ka5Y7rra9cjpVS2iGqDSOjJ2E6MXcmrrWXH?=
 =?iso-8859-1?Q?mK5LcgwsiP6sQ47MVKikc38VuPF7/dOWqDUKOUYvRUPlmPkwRtHtdQY86J?=
 =?iso-8859-1?Q?rLSCONx1rTfOXygKyeznGgGuKI8NKUR09CaYau48ZiYB0KiyRDFzA2Sv80?=
 =?iso-8859-1?Q?wlwSf/yj6zvbMeBCTgturDjC4Cs26NEgFCfKOCfbC7X2qVDoxd8mKrOdot?=
 =?iso-8859-1?Q?plJsHnh9j1fcvB8qdNjYk65rsiDX9NT6tuWucYzjE2mO9IkbkiSOnTdW/X?=
 =?iso-8859-1?Q?o8Nvt3hcmZ2dwoGMcqluEH5gZlZKCg5pEOZr75DKd+MUDuLEo4KzityfHz?=
 =?iso-8859-1?Q?iRlG1cCdAkBSFjrv8cnQ5vWGtmPcdQTjuPW5/pwKX25vwPgtMMU2HYu59G?=
 =?iso-8859-1?Q?jf4jBz3fPaJr5Y/xJGBcqJr/7AZ255hGRtqpxFkKHXqaV3EoaqAcicDIvE?=
 =?iso-8859-1?Q?8Thgsg3aWlozYcy9S8d2j98ohh/PeZ27wX1dUEzr1qnztFA0xM1TJ4mrYo?=
 =?iso-8859-1?Q?giNyHDsLa2+EdnSsI0xpqGp/etaVzH7keCTkYz1iq/3lbmfdHE6oOOTnTF?=
 =?iso-8859-1?Q?yr3CwHBqjFJAIE6Pguv/PXwZi9Ui0XsSgg3yAQoGIuY1OL9rKligTyhN4Q?=
 =?iso-8859-1?Q?fksey3py8a84fzta1glaE7jxZWiFjTzSeWsRFqgs7Tg3VSkShWxfxtzDks?=
 =?iso-8859-1?Q?fyvI/o5D5C04bCECRUPoARzZzKT6LqXmoHd3L52/zmbyttOjhNOxXt2bGi?=
 =?iso-8859-1?Q?pZ//hhDbzRYhBrdQGynxSAqANaUf19y8dlh1AqT5zsoIcX/PUxrjjuYi6q?=
 =?iso-8859-1?Q?s1VrWnlen224jM4mXLBgJq6c7uHR3C0VJLvVelH4FPW4U+55LWFLLSf2Lg?=
 =?iso-8859-1?Q?nFsU3h+k7mBmQKGwbLKp7iNFZqc9/gBTOBeu+rV6YKQGd2kPgxdGLtk9Eu?=
 =?iso-8859-1?Q?o/HerZjkFYEw6UZiF/KkJ7FzNYbOmV5vxowVV7cBj+t8yUxYgMZMGXXg+7?=
 =?iso-8859-1?Q?/xg27sUZjRLlRlt0gl6EfQ3Ak6FvIE6qj378wuqiNWsN8aIpZ7a6UgRmJq?=
 =?iso-8859-1?Q?A1vZ+1ja6TgwbmI+D4ViLEiMTME3W2bZhz6j0V+jGagS8Q4RiFhwYqCKPl?=
 =?iso-8859-1?Q?3eX/blRKp6foAn/oFfJ8H32YOn3pdMyML9QN0UPslOt1TWSihl8cFDrA/z?=
 =?iso-8859-1?Q?pgLzeaPSK7vjGrAahiVLmL3t1RYbTUFq3f8o+vPmJBRrOHwX4M55DpzwF2?=
 =?iso-8859-1?Q?r3lwwhvfKGkUZAjTjUq/5Ss2L2qqXqJTmoESe0tvu+iMEBJ6l3EbuSQQRw?=
 =?iso-8859-1?Q?kKjcHjNBSqz9TCLwOeA1efibQdp9JhefRm9V4TcI+B5p3bMwkVCXcKTW3s?=
 =?iso-8859-1?Q?sLjHh0aSfEadxYNGJa8RcrJEG67wermZ3NHPsyaqRgzQ52/ZBTlUSn8L++?=
 =?iso-8859-1?Q?5rYJTz+0LRW9hV4Z08rsj/pocegJrshYDJY1qhI013VAADiwUsvdT3qHzZ?=
 =?iso-8859-1?Q?P91qD2tInWJiWvKvWYvu0anyLO+8lDfw9l4Ribe/XAtLGgkCbV0uKFOuCT?=
 =?iso-8859-1?Q?LWLIjNuckiCsSFnvYgKlbfjRVry5NFvECwig9SPukq4osqkR9ha5n5xXG0?=
 =?iso-8859-1?Q?xSdQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MR1P264MB1540A3B3D6777C951E8910789354AMR1P264MB1540FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 608e2b4b-2c16-4926-b128-08db6b47a090
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 13:19:18.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqYchNFQ6UgT0LUqab50nFAy9cxQMlurSdyzexiYywwmenKo+Ktyk25vASx4BsP3pmTuLxG+QlzNJdQbhvqJn5FevjTxzLDwOq+6pyAkISk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1699

--_002_MR1P264MB1540A3B3D6777C951E8910789354AMR1P264MB1540FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Connecting to a WiFi network under disconnection leads to a=0A=
connect-failed error, when the disconnected status is updated to soon=0A=
by the driver. In this case, interface_state() resets the disconnecting=0A=
status, letting network_connect() try to directly connect, instead of=0A=
setting pending_network variable and waiting disconnect_callback() to=0A=
start the connection.=0A=
---=0A=
 plugins/wifi.c | 1 -=0A=
 1 file changed, 1 deletion(-)=0A=
=0A=
diff --git a/plugins/wifi.c b/plugins/wifi.c=0A=
index 865fe0ef1e55..e141f8dd73c1 100644=0A=
--- a/plugins/wifi.c=0A=
+++ b/plugins/wifi.c=0A=
@@ -2667,7 +2667,6 @@ static void interface_state(GSupplicantInterface *int=
erface)=0A=
 			connman_network_set_connected(network, false);=0A=
 			connman_network_set_associating(network, false);=0A=
 		}=0A=
-		wifi->disconnecting =3D false;=0A=
 =0A=
 		start_autoscan(device);=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=0A=

--_002_MR1P264MB1540A3B3D6777C951E8910789354AMR1P264MB1540FRAP_
Content-Type: text/x-patch;
	name="0003-wifi-Fix-connect-failed-error-on-user-reconnection.patch"
Content-Description:
 0003-wifi-Fix-connect-failed-error-on-user-reconnection.patch
Content-Disposition: attachment;
	filename="0003-wifi-Fix-connect-failed-error-on-user-reconnection.patch";
	size=1055; creation-date="Mon, 12 Jun 2023 13:18:52 GMT";
	modification-date="Mon, 12 Jun 2023 13:18:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiNDlhZTY2NjU1MDc3ZTQwZDQ1YjVjNjdmYjZmNTM4NTA2YWFjODRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IE1vbiwgMTIgSnVuIDIwMjMgMDA6MjQ6MDQgKzAyMDAKU3ViamVj
dDogW1BBVENIIDMvM10gd2lmaTogRml4IGNvbm5lY3QtZmFpbGVkIGVycm9yIG9uIHVzZXIgcmVj
b25uZWN0aW9uCgpDb25uZWN0aW5nIHRvIGEgV2lGaSBuZXR3b3JrIHVuZGVyIGRpc2Nvbm5lY3Rp
b24gbGVhZHMgdG8gYQpjb25uZWN0LWZhaWxlZCBlcnJvciwgd2hlbiB0aGUgZGlzY29ubmVjdGVk
IHN0YXR1cyBpcyB1cGRhdGVkIHRvIHNvb24KYnkgdGhlIGRyaXZlci4gSW4gdGhpcyBjYXNlLCBp
bnRlcmZhY2Vfc3RhdGUoKSByZXNldHMgdGhlIGRpc2Nvbm5lY3RpbmcKc3RhdHVzLCBsZXR0aW5n
IG5ldHdvcmtfY29ubmVjdCgpIHRyeSB0byBkaXJlY3RseSBjb25uZWN0LCBpbnN0ZWFkIG9mCnNl
dHRpbmcgcGVuZGluZ19uZXR3b3JrIHZhcmlhYmxlIGFuZCB3YWl0aW5nIGRpc2Nvbm5lY3RfY2Fs
bGJhY2soKSB0bwpzdGFydCB0aGUgY29ubmVjdGlvbi4KLS0tCiBwbHVnaW5zL3dpZmkuYyB8IDEg
LQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9wbHVnaW5zL3dp
ZmkuYyBiL3BsdWdpbnMvd2lmaS5jCmluZGV4IDg2NWZlMGVmMWU1NS4uZTE0MWY4ZGQ3M2MxIDEw
MDY0NAotLS0gYS9wbHVnaW5zL3dpZmkuYworKysgYi9wbHVnaW5zL3dpZmkuYwpAQCAtMjY2Nyw3
ICsyNjY3LDYgQEAgc3RhdGljIHZvaWQgaW50ZXJmYWNlX3N0YXRlKEdTdXBwbGljYW50SW50ZXJm
YWNlICppbnRlcmZhY2UpCiAJCQljb25ubWFuX25ldHdvcmtfc2V0X2Nvbm5lY3RlZChuZXR3b3Jr
LCBmYWxzZSk7CiAJCQljb25ubWFuX25ldHdvcmtfc2V0X2Fzc29jaWF0aW5nKG5ldHdvcmssIGZh
bHNlKTsKIAkJfQotCQl3aWZpLT5kaXNjb25uZWN0aW5nID0gZmFsc2U7CiAKIAkJc3RhcnRfYXV0
b3NjYW4oZGV2aWNlKTsKIAotLSAKMi4zNC4xCgo=

--_002_MR1P264MB1540A3B3D6777C951E8910789354AMR1P264MB1540FRAP_--
