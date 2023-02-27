Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2049.outbound.protection.outlook.com [40.107.9.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3772F3A
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 17:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8Dkab/AXN8WdNCHsqWl3K8srkaCEJK2mReqq4fz1H2jr/0WOj6muJ/Zb9KdqpeJRVqAk/SE374YXhLel31Onz6fFpfTqhyMyMLtzJlJQtagq9YD3Dvhru4U5er6U+iR4sw1iQ+JNFet6nnnw2gQJnBs6pkmacMAfs2UoWNc+t5zq8goEAERDQyAgF6MF2ndkK+FwX9qZ779RS7P/yROwA6AZtPBXrpvuysvAH0tp4ehx59CVkBaOai0mlA/KHjZgtHbRAKZwgtwiUqsPXQqrz0d1zsllieqibzXAQGCA0X6P3raGED0fdxSDEwnq3LQOuTKtHBcT5Npt40yBKvxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmF2sneohpcDrf10AEIzTRERZn9/TgbRdAyInGF/FY4=;
 b=IyFksNDkj6QK1E42tEwnyK9EcElkX5X6m6fqPm/P0BUY5O+/8f5A/17CpjOw8NB/U7lHc6bHNSgaSyUO63GOtiodNbLHdkXyNVHW1Qd2Eax7ioKCCsCBFd8143rv+GTx+MK50f1v7bgahyIu/qSlKU94H8hUZJXMZZ+Hasv2WdM6nv9ljjFtXu1yXFO04XGxAhySgczvAqf1KAAnTBYecrA7TZNkk0WnWMgNz6vQFhS/NeU7Sx7XWwPIMzA7mYQRkjrPFWyDOa+K2Uky/Vv5vvssmwRS4EyfibeY2enIXhf4nV5ysp9+gg5a142kPzB1n152UCq7lgJ8OxRpfPtvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmF2sneohpcDrf10AEIzTRERZn9/TgbRdAyInGF/FY4=;
 b=WiuyLdoICfSbAtvTvsHQh7Yb7Sw9kzxxVKFx0oFYONVCqWqOG6O793pJMHrd3MD1mircY71Fme606c7/YqzKCqV6vVqHyHonFNc/WjyQEZhTW4i3SYe5i7BuUga2/QOQ4qOE9dJ3EDOvk75E80HU5aYFzFeYwWaF0aV8l3i+8z8=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB1640.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.26; Mon, 27 Feb 2023 17:00:58 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad0e:5229:24f3:920d]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad0e:5229:24f3:920d%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 17:00:58 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] network: Keep failure state after disconnection
Thread-Topic: [PATCH] network: Keep failure state after disconnection
Thread-Index: AQHZSswmMJ9x9jxugk6QqaKMEp4VZQ==
Date: Mon, 27 Feb 2023 17:00:58 +0000
Message-ID:
 <MRZP264MB15448014A6E161ADFD0A280793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB1544:EE_|MRZP264MB1640:EE_
x-ms-office365-filtering-correlation-id: d6b97f6f-ddf7-4de4-4620-08db18e4328a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Uc71gO/8qNMsTPiEUeof0Caq5ya8ftecLYBf5lCtFxSaj/hD0ZiCjGAYzSNe+EpnEAHaC9GXnVP6OmEi10lHrmIkHyJayixNFc8QLXnldRHET7FvcYX2Cy+t64z49GUWEeWlv1ZefYkzrKi1IjI2aH4ScNIl12x9/FQWyycCApLPYbHiIjQ5Jvycbws/UA81u1l4ZcYIP3EurVZtcQ2u5CcfmZyUUZjfzV/iRVtr92ikPRGVvCxkB8QItU4vCoF4I6vbn93zF2tA/ijdjq01OzdEsMbpxjroOa+2/2O1gWUGsIATvZc6I4bum9TW6JJ+5BxhfRp6Wng+cUA1U1c/F3fDNtRtH7ZvPrwwBZvpQfiYM3TlsyS5OxI9fuo4QgUkspHQd7TAQmPDlxQXykfTEFXsWOkdDjzjiT46jH4KvLaE8vnbbtpskNyF/DwMab82Dyo9t+Cb70M3m7BD8gWhnE1obVsUiGe2lB5x0Xo/h+X3R6+gL2xBUhQ0+SNkiPam9LwiHCPSaBppFkokmMC0wiIFVIoghlg7zSF78MN+tax5Gl8WhcvXwNAoYZ2zf4ufK3Oav3MwzS/CBdHHdnkdRsq1v1TIQo1jLoTM1Y6+DfL2ftG/SPKRlfrNrHw3e3OWuDXVSHsa9wlZ17R55bdy0u0XvokmiLSqnYIzeFcfm6la0xVVbNk2x3Wp8wPoJd4/8tuX92YceyNGmogBkx7Lww==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(2906002)(316002)(52536014)(83380400001)(33656002)(5660300002)(478600001)(8936002)(91956017)(38070700005)(86362001)(8676002)(6916009)(66946007)(76116006)(66476007)(64756008)(66556008)(66446008)(38100700002)(122000001)(41300700001)(99936003)(55016003)(6506007)(186003)(9686003)(26005)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ymQhan+03AdKFMAw+dLjQhDkR2I+3n/tSeZzsX+0ORyVQ1a4Bzlho9/oS8?=
 =?iso-8859-1?Q?d/UPqigTC8CgbdH2bPsmRYVCwF+EWGd7sbtwTo0DiD9+tQUP8d8GepZitl?=
 =?iso-8859-1?Q?YMGMOEepwSkIhdaWxASE70y7MHB9GSnOoVW3FmX8S8+BiF7NUbrMPqxltx?=
 =?iso-8859-1?Q?WxP+82axiAHzfzuzUXEKyjFDs5qsWV8yQj4W1L/CnDHCu2bICUZlw4t1cz?=
 =?iso-8859-1?Q?eLK/Gg505R2IBjrEhqXd5DHPC3XDERi/0ALZX6pzxy5MwiTN87TU3yAOLq?=
 =?iso-8859-1?Q?IOD8kkqjoSWTSlfuhRI5Q/E2kbDbzmO9XFyy39zizj0l3hWZWUK+jdAgHH?=
 =?iso-8859-1?Q?Ykhan6EzkYlDJw63h6UWcXATctsd7HwjkQp29Ijdtz1KkyhQpSYTlLwKFa?=
 =?iso-8859-1?Q?q006qsSAG/1eCYBbVH5uHVw1/cBw4ZaUA6N0s/X7Gr4y+lfLQTitEetxXS?=
 =?iso-8859-1?Q?PH5zG89DpIZubo8vT8CL40kjMo+aycjaAeaX49kZAlolT7XYi17uLfAQGf?=
 =?iso-8859-1?Q?eprhwjCct4ukY+mP95J4ckVpWQG60CygAW0oDgex317n7JmEjG/np+IVlf?=
 =?iso-8859-1?Q?i2BmQMBTE9ymbhviiPPqOIpN7bdLZVFvn5iH/UCpw2pwefwMiSagf7+d6H?=
 =?iso-8859-1?Q?0anjn8YxBx6hbabWF3B5xX+ohGKij1sZEJDav/X6JV+WNgCJf6k5lL7cBB?=
 =?iso-8859-1?Q?5TmtOdghM4aA2ibG5F20wnHUqTx4gbwIq+rIa1bjBXLFX/s9OjK+UvR8fV?=
 =?iso-8859-1?Q?95DB4vVs628h2DSbtdCmQ64MvDTqf6p/TQeGtbDxEoriooOpugIsA1PsqS?=
 =?iso-8859-1?Q?/6Ms4VH4DUvIeka5VyHVIwak6jw2s719rFJw+h/cCJTsdUpiTNZDBVNWIZ?=
 =?iso-8859-1?Q?4q8vZgzifnZeO2VVmdnuEyhGoWjjxNjFHYWbnKB6Mo6xsc/8D4LCoHliYK?=
 =?iso-8859-1?Q?NUIiXa9XY1H4stHA7/xy0lqomDb9RL2Ge+YpyLDc+6Mq6r0ufAl4mE5vA/?=
 =?iso-8859-1?Q?1hiV4b1wDuZAdpXmD4gEt2q8bG6ghfMNLtEunzOX91lS54txI6yAVHlidX?=
 =?iso-8859-1?Q?CUJsJPoVo4b9zs/iUoo4QOvqS064drp1WVFkZppCmp4GJQQWOEA3iHCxXJ?=
 =?iso-8859-1?Q?RbCW69jNsNH5wZoPjr39cu8kiNbuQLTo2ddwSowoVDsIjXGKTR0Ar4CdMP?=
 =?iso-8859-1?Q?ay8PuaCi1QRF0K43j9KiV7HkcWGmndeVqNv5gkShVAwcxYVWb1J5+4MrJp?=
 =?iso-8859-1?Q?OjciSacQu7qecJBlixSzpMaBT3SqS8WtMTBnljwYfVxfv+7xfAP1P6ajAP?=
 =?iso-8859-1?Q?SJ+tZMjta0W96nGNHWBI6QrxFi9QFYZ62F+PAxH0J6mtdRrEhHlNdlVC+Z?=
 =?iso-8859-1?Q?4Vcy84/0/eNv5t23Qxk+/gA83F10ifChV/B/q3fI0zQO0b7AGjT3swHwO0?=
 =?iso-8859-1?Q?kb6bzvvXjo4Ty/iH1LRbHyBAMOBULM7cd+pC3mcp653egO3DJsRDadPYJF?=
 =?iso-8859-1?Q?hrLqCJJssp96PQRpNUG4fTfSscIJhwQi/RymgJuaBuC67ybJ9MjK20hycp?=
 =?iso-8859-1?Q?6N6rxYQrAcjvXrTw9E8XVbv2YHiFxw8ZIzJcOGmgVCgSnP92esls6DpHek?=
 =?iso-8859-1?Q?tct0cw6rzU/9l5aKvZTUZFLnD6Mw76iXYFc6Gvg7yvHXmgzN9JEjA93g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB15448014A6E161ADFD0A280793AF9MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b97f6f-ddf7-4de4-4620-08db18e4328a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 17:00:58.2277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38UHiM6u5Df+J2BfZrZU6S7MB5tDyleOLfthy+D/4dJPVFEfg4G19pp1WN+7HgOR1iPm7BF1H1+2BD7vTauef4bMD7ZjI64bEo8qehgCejs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1640

--_002_MRZP264MB15448014A6E161ADFD0A280793AF9MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

set_disconnected() function shall not prevent the service to process errors=
=0A=
by replacing failure state by idle.=0A=
=0A=
For example, when a connection fails with a wrong passphrase, the user stil=
l=0A=
needs to be informed, via the agent. However, in this case, the associated=
=0A=
service is automatically disconnected, canceling the pending agent requests=
.=0A=
The invalid key error shall be reported, instead of a cancel error.=0A=
---=0A=
 src/network.c | 20 ++++++++++++--------=0A=
 1 file changed, 12 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/src/network.c b/src/network.c=0A=
index 2090e7fe944e..06df023b076e 100644=0A=
--- a/src/network.c=0A=
+++ b/src/network.c=0A=
@@ -940,7 +940,7 @@ static void set_disconnected(struct connman_network *ne=
twork)=0A=
 {=0A=
 	struct connman_ipconfig *ipconfig_ipv4, *ipconfig_ipv6;=0A=
 	enum connman_ipconfig_method ipv4_method, ipv6_method;=0A=
-	enum connman_service_state state;=0A=
+	enum connman_service_state state_ipv4, state_ipv6;=0A=
 	struct connman_service *service;=0A=
 =0A=
 	service =3D connman_service_lookup_from_network(network);=0A=
@@ -1006,18 +1006,18 @@ static void set_disconnected(struct connman_network=
 *network)=0A=
 	 * or in failure. It does not make sense to go to disconnect=0A=
 	 * state if we were not connected.=0A=
 	 */=0A=
-	state =3D __connman_service_ipconfig_get_state(service,=0A=
+	state_ipv4 =3D __connman_service_ipconfig_get_state(service,=0A=
 						CONNMAN_IPCONFIG_TYPE_IPV4);=0A=
-	if (state !=3D CONNMAN_SERVICE_STATE_IDLE &&=0A=
-			state !=3D CONNMAN_SERVICE_STATE_FAILURE)=0A=
+	if (state_ipv4 !=3D CONNMAN_SERVICE_STATE_IDLE &&=0A=
+				state_ipv4 !=3D CONNMAN_SERVICE_STATE_FAILURE)=0A=
 		__connman_service_ipconfig_indicate_state(service,=0A=
 					CONNMAN_SERVICE_STATE_DISCONNECT,=0A=
 					CONNMAN_IPCONFIG_TYPE_IPV4);=0A=
 =0A=
-	state =3D __connman_service_ipconfig_get_state(service,=0A=
+	state_ipv6 =3D __connman_service_ipconfig_get_state(service,=0A=
 						CONNMAN_IPCONFIG_TYPE_IPV6);=0A=
-	if (state !=3D CONNMAN_SERVICE_STATE_IDLE &&=0A=
-				state !=3D CONNMAN_SERVICE_STATE_FAILURE)=0A=
+	if (state_ipv6 !=3D CONNMAN_SERVICE_STATE_IDLE &&=0A=
+				state_ipv6 !=3D CONNMAN_SERVICE_STATE_FAILURE)=0A=
 		__connman_service_ipconfig_indicate_state(service,=0A=
 					CONNMAN_SERVICE_STATE_DISCONNECT,=0A=
 					CONNMAN_IPCONFIG_TYPE_IPV6);=0A=
@@ -1041,10 +1041,14 @@ static void set_disconnected(struct connman_network=
 *network)=0A=
 		}=0A=
 	}=0A=
 =0A=
-	__connman_service_ipconfig_indicate_state(service,=0A=
+	if (state_ipv4 !=3D CONNMAN_SERVICE_STATE_IDLE &&=0A=
+				state_ipv4 !=3D CONNMAN_SERVICE_STATE_FAILURE)=0A=
+		__connman_service_ipconfig_indicate_state(service,=0A=
 						CONNMAN_SERVICE_STATE_IDLE,=0A=
 						CONNMAN_IPCONFIG_TYPE_IPV4);=0A=
 =0A=
+	if (state_ipv6 !=3D CONNMAN_SERVICE_STATE_IDLE &&=0A=
+				state_ipv6 !=3D CONNMAN_SERVICE_STATE_FAILURE)=0A=
 	__connman_service_ipconfig_indicate_state(service,=0A=
 						CONNMAN_SERVICE_STATE_IDLE,=0A=
 						CONNMAN_IPCONFIG_TYPE_IPV6);=0A=
-- =0A=
2.25.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=

--_002_MRZP264MB15448014A6E161ADFD0A280793AF9MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-network-Keep-failure-state-after-deconnection.patch"
Content-Description: 0001-network-Keep-failure-state-after-deconnection.patch
Content-Disposition: attachment;
	filename="0001-network-Keep-failure-state-after-deconnection.patch";
	size=2993; creation-date="Mon, 27 Feb 2023 16:59:36 GMT";
	modification-date="Mon, 27 Feb 2023 16:59:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxYWY4ODc4NGY5MGZlNDIxNmI5MTczNjY0YzVjNTUzNTFmODlhNjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IE1vbiwgMjcgRmViIDIwMjMgMDk6NDg6MzUgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBuZXR3b3JrOiBLZWVwIGZhaWx1cmUgc3RhdGUgYWZ0ZXIgZGVjb25uZWN0aW9u
CgpzZXRfZGlzY29ubmVjdGVkKCkgZnVuY3Rpb24gc2hhbGwgbm90IHByZXZlbnQgdGhlIHNlcnZp
Y2UgdG8gcHJvY2VzcyBlcnJvcnMKYnkgcmVwbGFjaW5nIGZhaWx1cmUgc3RhdGUgYnkgaWRsZS4K
CkZvciBleGFtcGxlLCB3aGVuIGEgY29ubmVjdGlvbiBmYWlscyB3aXRoIGEgd3JvbmcgcGFzc3Bo
cmFzZSwgdGhlIHVzZXIgc3RpbGwKbmVlZHMgdG8gYmUgaW5mb3JtZWQsIHZpYSB0aGUgYWdlbnQu
IEhvd2V2ZXIsIGluIHRoaXMgY2FzZSwgdGhlIGFzc29jaWF0ZWQKc2VydmljZSBpcyBhdXRvbWF0
aWNhbGx5IGRpc2Nvbm5lY3RlZCwgY2FuY2VsaW5nIHRoZSBwZW5kaW5nIGFnZW50IHJlcXVlc3Rz
LgpUaGUgaW52YWxpZCBrZXkgZXJyb3Igc2hhbGwgYmUgcmVwb3J0ZWQsIGluc3RlYWQgb2YgYSBj
YW5jZWwgZXJyb3IuCi0tLQogc3JjL25ldHdvcmsuYyB8IDIwICsrKysrKysrKysrKy0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zcmMvbmV0d29yay5jIGIvc3JjL25ldHdvcmsuYwppbmRleCAyMDkwZTdmZTk0NGUu
LjA2ZGYwMjNiMDc2ZSAxMDA2NDQKLS0tIGEvc3JjL25ldHdvcmsuYworKysgYi9zcmMvbmV0d29y
ay5jCkBAIC05NDAsNyArOTQwLDcgQEAgc3RhdGljIHZvaWQgc2V0X2Rpc2Nvbm5lY3RlZChzdHJ1
Y3QgY29ubm1hbl9uZXR3b3JrICpuZXR3b3JrKQogewogCXN0cnVjdCBjb25ubWFuX2lwY29uZmln
ICppcGNvbmZpZ19pcHY0LCAqaXBjb25maWdfaXB2NjsKIAllbnVtIGNvbm5tYW5faXBjb25maWdf
bWV0aG9kIGlwdjRfbWV0aG9kLCBpcHY2X21ldGhvZDsKLQllbnVtIGNvbm5tYW5fc2VydmljZV9z
dGF0ZSBzdGF0ZTsKKwllbnVtIGNvbm5tYW5fc2VydmljZV9zdGF0ZSBzdGF0ZV9pcHY0LCBzdGF0
ZV9pcHY2OwogCXN0cnVjdCBjb25ubWFuX3NlcnZpY2UgKnNlcnZpY2U7CiAKIAlzZXJ2aWNlID0g
Y29ubm1hbl9zZXJ2aWNlX2xvb2t1cF9mcm9tX25ldHdvcmsobmV0d29yayk7CkBAIC0xMDA2LDE4
ICsxMDA2LDE4IEBAIHN0YXRpYyB2b2lkIHNldF9kaXNjb25uZWN0ZWQoc3RydWN0IGNvbm5tYW5f
bmV0d29yayAqbmV0d29yaykKIAkgKiBvciBpbiBmYWlsdXJlLiBJdCBkb2VzIG5vdCBtYWtlIHNl
bnNlIHRvIGdvIHRvIGRpc2Nvbm5lY3QKIAkgKiBzdGF0ZSBpZiB3ZSB3ZXJlIG5vdCBjb25uZWN0
ZWQuCiAJICovCi0Jc3RhdGUgPSBfX2Nvbm5tYW5fc2VydmljZV9pcGNvbmZpZ19nZXRfc3RhdGUo
c2VydmljZSwKKwlzdGF0ZV9pcHY0ID0gX19jb25ubWFuX3NlcnZpY2VfaXBjb25maWdfZ2V0X3N0
YXRlKHNlcnZpY2UsCiAJCQkJCQlDT05OTUFOX0lQQ09ORklHX1RZUEVfSVBWNCk7Ci0JaWYgKHN0
YXRlICE9IENPTk5NQU5fU0VSVklDRV9TVEFURV9JRExFICYmCi0JCQlzdGF0ZSAhPSBDT05OTUFO
X1NFUlZJQ0VfU1RBVEVfRkFJTFVSRSkKKwlpZiAoc3RhdGVfaXB2NCAhPSBDT05OTUFOX1NFUlZJ
Q0VfU1RBVEVfSURMRSAmJgorCQkJCXN0YXRlX2lwdjQgIT0gQ09OTk1BTl9TRVJWSUNFX1NUQVRF
X0ZBSUxVUkUpCiAJCV9fY29ubm1hbl9zZXJ2aWNlX2lwY29uZmlnX2luZGljYXRlX3N0YXRlKHNl
cnZpY2UsCiAJCQkJCUNPTk5NQU5fU0VSVklDRV9TVEFURV9ESVNDT05ORUNULAogCQkJCQlDT05O
TUFOX0lQQ09ORklHX1RZUEVfSVBWNCk7CiAKLQlzdGF0ZSA9IF9fY29ubm1hbl9zZXJ2aWNlX2lw
Y29uZmlnX2dldF9zdGF0ZShzZXJ2aWNlLAorCXN0YXRlX2lwdjYgPSBfX2Nvbm5tYW5fc2Vydmlj
ZV9pcGNvbmZpZ19nZXRfc3RhdGUoc2VydmljZSwKIAkJCQkJCUNPTk5NQU5fSVBDT05GSUdfVFlQ
RV9JUFY2KTsKLQlpZiAoc3RhdGUgIT0gQ09OTk1BTl9TRVJWSUNFX1NUQVRFX0lETEUgJiYKLQkJ
CQlzdGF0ZSAhPSBDT05OTUFOX1NFUlZJQ0VfU1RBVEVfRkFJTFVSRSkKKwlpZiAoc3RhdGVfaXB2
NiAhPSBDT05OTUFOX1NFUlZJQ0VfU1RBVEVfSURMRSAmJgorCQkJCXN0YXRlX2lwdjYgIT0gQ09O
Tk1BTl9TRVJWSUNFX1NUQVRFX0ZBSUxVUkUpCiAJCV9fY29ubm1hbl9zZXJ2aWNlX2lwY29uZmln
X2luZGljYXRlX3N0YXRlKHNlcnZpY2UsCiAJCQkJCUNPTk5NQU5fU0VSVklDRV9TVEFURV9ESVND
T05ORUNULAogCQkJCQlDT05OTUFOX0lQQ09ORklHX1RZUEVfSVBWNik7CkBAIC0xMDQxLDEwICsx
MDQxLDE0IEBAIHN0YXRpYyB2b2lkIHNldF9kaXNjb25uZWN0ZWQoc3RydWN0IGNvbm5tYW5fbmV0
d29yayAqbmV0d29yaykKIAkJfQogCX0KIAotCV9fY29ubm1hbl9zZXJ2aWNlX2lwY29uZmlnX2lu
ZGljYXRlX3N0YXRlKHNlcnZpY2UsCisJaWYgKHN0YXRlX2lwdjQgIT0gQ09OTk1BTl9TRVJWSUNF
X1NUQVRFX0lETEUgJiYKKwkJCQlzdGF0ZV9pcHY0ICE9IENPTk5NQU5fU0VSVklDRV9TVEFURV9G
QUlMVVJFKQorCQlfX2Nvbm5tYW5fc2VydmljZV9pcGNvbmZpZ19pbmRpY2F0ZV9zdGF0ZShzZXJ2
aWNlLAogCQkJCQkJQ09OTk1BTl9TRVJWSUNFX1NUQVRFX0lETEUsCiAJCQkJCQlDT05OTUFOX0lQ
Q09ORklHX1RZUEVfSVBWNCk7CiAKKwlpZiAoc3RhdGVfaXB2NiAhPSBDT05OTUFOX1NFUlZJQ0Vf
U1RBVEVfSURMRSAmJgorCQkJCXN0YXRlX2lwdjYgIT0gQ09OTk1BTl9TRVJWSUNFX1NUQVRFX0ZB
SUxVUkUpCiAJX19jb25ubWFuX3NlcnZpY2VfaXBjb25maWdfaW5kaWNhdGVfc3RhdGUoc2Vydmlj
ZSwKIAkJCQkJCUNPTk5NQU5fU0VSVklDRV9TVEFURV9JRExFLAogCQkJCQkJQ09OTk1BTl9JUENP
TkZJR19UWVBFX0lQVjYpOwotLSAKMi4yNS4xCgo=

--_002_MRZP264MB15448014A6E161ADFD0A280793AF9MRZP264MB1544FRAP_--
