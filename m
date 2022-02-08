Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120051.outbound.protection.outlook.com [40.107.12.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6E2F21
	for <connman@lists.linux.dev>; Tue,  8 Feb 2022 15:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HawO70B+qL+9dvDSh3toz4lPYlGoxX/enfSuzWYw6ujgB85ievlDnhKnhr/UZlvYysFcNIf8tvOeEi68ohbmhSw0YqWjPxCp4ObwL0vc/6FW9Y3CFMMrwG3rWfMaZYj5t4bt8fTkIFxtXV3O8quubKNPi2we4F2NlrFXfY/KPudsf7jKP8ssMopnNyqSvJ58rFZyhW6migvs3buJiBuf55DyGQWP4V8AI20sORdX2Sp+bZA0Wt/l60fyCMqdvxpIlEjP1eUEUoEHBB3Ru97Ad04gBb8UYp1KqJzUnBzzcotNaTyGi3zCSvGroOQgzHxaL4lWBqcBWUB2rlqHHUAxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXtkcITF0qFPcuS31nbAL6vXm7jcuJ7cjitsayYKDU8=;
 b=ofUDMWA/2G8Ikk4363n6CMmtzqSmzWZ3pN02XvE9hqsjMYJDwnl9tEOpKH55AoRh/L71n8FDKig7RFfQxWOVRge03ssGgMa29AJNU1ipAwhqrrHP0jpTiSxcK/DNlbzn1eK8pCZEmvCeoUfGbmQ4/y42NjsAjVCeJ7HlQClqwBLqzEtdZ8UMSBUTd+K/l5JkSkc/B3S+Fy5mwK4qL+PsbXmQxnvjBKOCVUK/qm1vHcw4yANxyzP6vaDQ7uUpuLj49VVplfYyORNDlbY+isW+uROsBgwZuxaTbrSG5x/3l2sxVHIqjHpFeNhWqAGXVc7ukOFsa+z566sJHCWrrrYRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXtkcITF0qFPcuS31nbAL6vXm7jcuJ7cjitsayYKDU8=;
 b=MJUpDbYbdrK5bnqWlPZw8qtZ/luJzxpfewSDb+R9npw0a6eIynirabhhWrQ/1a+N2KmunI7fYrOUp90hRFdTV0fXp8Js786vQBEENTskqdyRmTCur34eLadztzNbALqb0K5f9/IuNUd/2J878RpzSDhO1tH0MjHEjpZC3ascXIg=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PAZP264MB2478.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Tue, 8 Feb 2022 15:33:31 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 15:33:31 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Denis Kenzior <denkenz@gmail.com>, Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>, "iwd@lists.01.org"
	<iwd@lists.01.org>
Subject: RE: [PATCH v2] iwd: Always disconnect connection completely
Thread-Topic: [PATCH v2] iwd: Always disconnect connection completely
Thread-Index:
 AQHYEP/731R9+FXajUGI5zk313sJNKxx3h9IgAGhxwCAAAOvMoAADyEAgABbfgCAFH1RHA==
Date: Tue, 8 Feb 2022 15:33:31 +0000
Message-ID:
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
 <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
In-Reply-To: <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: e6c22c76-357c-c041-d712-62a64cbadbf3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 175cf426-310a-494a-3254-08d9eb185caa
x-ms-traffictypediagnostic: PAZP264MB2478:EE_
x-microsoft-antispam-prvs:
 <PAZP264MB247851DA7F1E14C7AFC10FF2932D9@PAZP264MB2478.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nwUZ0aeTs891Smy0sP0HL5KmZN1S+cxQ2K+LnTI/vlGIZD5qRB06Y/aQUgB15iVjNDcdXKT6XHkgqx3hfUujAX63KjzIuCSa96w/Hel4Mubme3YyAlNQPH++6laJFKOEZrMxBzabIiwMzy5EJWKyfBwr0/EUaLMaYw+rREQZwhrv2EWkQVXKxvAMYd9VaDGimUidC5zdelPpPL3rK4fhxkBZC5i9ohcD7yJerfQQksa6zBjWVHbWLIRddlVrd4ariTBhIynueQ3wxbg12ZeaMnr09HAB7sE3NsOHwsClztzLQC/ILSTVLhO8xefCADYgrqmXpjJvteJEFVow79RlL3Hh4wlNKH8cyUq74jOl1Zy+wzBhEucZ1qpS/v63ZzlxYO7IgbfosTEwLcAaceL+jYOsDBxgA1pG1FFBfN7QkodHaLQjmtvUjc1zbuQ6ZU+sdXK8cPAsYbKNdp51QIJ7HqhRYfDEQVqJb7TppF65qocdpa+5JfBi7706i7Teqo4nm6gHnFVPZgVOxVQd7L2I+k9O+MgvlNItiM4DMTNM9NHoX9EnM+lMMN3iv1e7uK9m44Vm+svGilMA4u+j6rdHIRoah8dirQ0qjNCWS+c2bR5fWmU5rR2AT3Ruru2VGY2VHsYnJpS6mSfr9ONSbeHj1OWPSCMhgeKxiGSC9BM05WAonDVbx9nc0MCpdw7fiTxGeYWmqBKOllCMk31h7s/bjz3hW8VNJV4waNvVdqVI9XY3TLFsJo0movjCsb1+av5GaJtZjFlMZikyTtK3hvV9bHC6Ssdtq5X2DysSVQV8xtE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(99936003)(86362001)(55016003)(6506007)(2906002)(110136005)(38070700005)(54906003)(66556008)(66476007)(122000001)(7696005)(508600001)(33656002)(966005)(76116006)(316002)(71200400001)(91956017)(66446008)(64756008)(52536014)(83380400001)(186003)(38100700002)(66946007)(9686003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XPF+P9L/0VfCc+v4Emm5jZ5zYPgDGWhcjSKFTb75vU7P/Vt7KFe9f9VPsT?=
 =?iso-8859-1?Q?TdK4XP2rOuAztvs+4z9q/Z6ROH7ZN/bAUiym0oWnZjDUEr1xCr1bcTv+uy?=
 =?iso-8859-1?Q?eVPQsqaCgu4ZkQbwh3v5A62dapm9qhLdPhIeYkcrTazHeGyG8gnEDJ3JZW?=
 =?iso-8859-1?Q?GOI6X1430Z6wzeMaziSIxkm3P6UfwHDFdHpYXJeGkiuS65hQNg6dJmvmCr?=
 =?iso-8859-1?Q?rLeAcKaPTEU18iGpOyQQiGGpzCtSFuHeFTDS2Y8KNuoumwk+qxCXfTD1bi?=
 =?iso-8859-1?Q?kJCY8Uexe4FOsv2YOCaCE1rvSVzoG3bBAzClBcwCrEg0hTegf6XMWwUpOc?=
 =?iso-8859-1?Q?MxMKU3ugGSMQkd3717T2y0S6clDyG1r7vQevkR+qUqYr6Z49hyOYgemjh1?=
 =?iso-8859-1?Q?Ef9dLIeUTWCV70XEluiF1QGiYVQlZ/FsefGRG7sCflLSOokSUiswRNxWYN?=
 =?iso-8859-1?Q?rswyF5ex35nWLcmhKLxApHQFD9DolkB4AD5DnCFVz5TFh8eeU7Jgeff9T9?=
 =?iso-8859-1?Q?/HD4GQjTbE3EVIB1Lv3EGeT433qsICPdJ6/K2HmPOoj41qjIVmLrtLrpDx?=
 =?iso-8859-1?Q?0gL2jZI33HpvSJBdUPf2LNSMn03EQo7miCqO/AlqRYzKyy1YxEGUssN/eV?=
 =?iso-8859-1?Q?n5TmtF9qBSOX58Rygji9hW9WI9kGTAX6BZBVaalJ5B6jj0wSrHGUvELyS4?=
 =?iso-8859-1?Q?9arKUoZRj6XxiX/zz6GWA39xPKzKRfQaz0uPWZAFUnCRhX3m8L87MrdYLn?=
 =?iso-8859-1?Q?szacJaZQq8nicmk4VfuvBugYye52YYe3tHZmpw6btnMK6eofDArR43I/di?=
 =?iso-8859-1?Q?eBGcjW6M802DGReV9Vyn0XU/c7B9y8/EO7LiQ8wlm/DCtNJeqIaTzjwDAv?=
 =?iso-8859-1?Q?DHzWQdNSZzNm3yP1MMBw/WjvQOsFXb33Nnnddp5vHC/6RvucCGT9J/gEb+?=
 =?iso-8859-1?Q?TqWqOuRiMGYwlAc+vPdToHmWk639WjGQ408Q07v5b6L0gXLlYG6q3vlDx7?=
 =?iso-8859-1?Q?AtDcXGFRJAGEiyOLt/qY7PNfhomftJHhbqQoVB2F6gh3VaruX3BIUq9iHH?=
 =?iso-8859-1?Q?kQr1msAInj025ngIHNbnhoyQPx45VCa0s0HRbWkb4Y5HmFBQe0Da5OTCLD?=
 =?iso-8859-1?Q?Vap/KuvGP93+r/ckXrUbxq+HyKkPi8/6YdcJiDX7I48gzk2LUzJz5cR/KY?=
 =?iso-8859-1?Q?P/5NgCcYDiMJtduPQ89qrOPM3U/zV/ZJ7EXPl8+XTht2FS68jla6B1iuiT?=
 =?iso-8859-1?Q?lD403RZ1/teSSgRbfchCN7QD54d5NaZhj9UwZcUZF9Q5cYaH2A/QNqDEQh?=
 =?iso-8859-1?Q?CPhiKkfgulw/vqplvKaYckLxEcFXjkJaOSfPhFFfbyyApO4fzqctXx8gMg?=
 =?iso-8859-1?Q?FLSG+D7OMOZ+zxFnwmBDiTA7PVFsO1V987oTkha+XLFH+nlhmF/AZmqzpt?=
 =?iso-8859-1?Q?RA6aQ0ahJYsUeKLttBYWb6X/qhtTSXnfFPRF+KoErJ8RZ3qcSjKgDI4QO6?=
 =?iso-8859-1?Q?u2pzkX534xHQdJoeuVLgTURI0R+H6K6o2WdGGDPGiZHuXchjN/+7htw4sb?=
 =?iso-8859-1?Q?GXuaUhwimT/WGOyiXMArGWZFfbqpvQC6GKExxtdPKy2iZDgLyby9Gd5WSo?=
 =?iso-8859-1?Q?OSQa6XOhp7eSE7uk5noz5kfVQiT9SHAAbFZjm543S+ayDK9/5plB/qdEpd?=
 =?iso-8859-1?Q?m71mnSII58Jhtwy3ZebdqRkzASkr0L1QofA5/fDbyCXgLqtwAGEQhBC/Y2?=
 =?iso-8859-1?Q?ZeEoRNN4iNGZnRZNtPttXV7gqWOj/umnZnUY37YyDfGLDOlH38YUKBBBOW?=
 =?iso-8859-1?Q?f7i7AWVKXw=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB154403938B0F44F5C05841D8932C9MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 175cf426-310a-494a-3254-08d9eb185caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 15:33:31.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h83MEjc7UG0Cb23ZtjHfgCcNUdkzTASCpwOaazStOmAkC6qST+44e94msforYJ7fk0Yv4xZCBY5A9eJIIp8uN2iha3cDNBAb6QNDOQxSzpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2478

--_002_MRZP264MB154403938B0F44F5C05841D8932C9MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you Denis for your answer.=0A=
=0A=
> So in theory iwd should gracefully handle such scenarios.  For example:=
=0A=
> - Connect comes while already connected (network switch)=0A=
> - Disconnect comes when connecting (aborts the connect attempt)=0A=
> - Connect while connecting (aborts original attempt, starts new one)=0A=
=0A=
> There may be situations where the timing between requests is so small tha=
t we =0A=
> simply have to return an -EBUSY (net.connman.iwd.Busy).=0A=
=0A=
> Is there a particular scenario which isn't working?=0A=
In my opinion, the fix shall be done at ConnMan level and will always be=0A=
necessary, as the disconnection is asynchronous, contrary to the connection=
.=0A=
=0A=
One year ago, a similar patch was integrated for wpa_supplicant.=0A=
(cf https://lists.01.org/hyperkitty/list/connman@lists.01.org/thread/NSWBVT=
HYPKUDON6K66YPL2OWFY6UYOV2/)=0A=
=0A=
It is easy to reproduce the issue, by switching quickly between two known=
=0A=
Wifi networks (W1 & W2), via the Service api. By quickly, I mean: one call =
shall=0A=
immediately follow the reply of the previous call.=0A=
In this case, the following steps happen:=0A=
1. Disconnection of current network (W1).=0A=
2. Connection to the new one (W2) failing with "net.connman.iwd.Failed"=0A=
dbus error in cm_network_connect_cb, probably due to the fact that W1=0A=
disconnection was not already completed, aborting connection to W2.=0A=
=0A=
=0A=
Daniel, I have attached the v3 of the patch to be more compliant with the c=
oding rules.=0A=
Please tell me both if you need additional information.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=

--_002_MRZP264MB154403938B0F44F5C05841D8932C9MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="v3-0001-iwd-Always-disconnect-connection-completely.patch"
Content-Description: v3-0001-iwd-Always-disconnect-connection-completely.patch
Content-Disposition: attachment;
	filename="v3-0001-iwd-Always-disconnect-connection-completely.patch";
	size=5439; creation-date="Tue, 08 Feb 2022 14:02:30 GMT";
	modification-date="Tue, 08 Feb 2022 14:02:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3YjdkYTE2ZjRlNDk1YzI2OWUxY2EwMjE3N2I4MDMwYTIxODljZWZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IE1vbiwgNyBGZWIgMjAyMiAxNTo0NzoxMCArMDEwMApTdWJqZWN0
OiBbUEFUQ0ggdjNdIGl3ZDogQWx3YXlzIGRpc2Nvbm5lY3QgY29ubmVjdGlvbiBjb21wbGV0ZWx5
CgpCZWZvcmUgYmVpbmcgYWJsZSB0byBjb25uZWN0IHRvIGEgbmV3IG5ldHdvcmssIGZpbmlzaCBk
aXNjb25uZWN0aW5nCnRoZSBvbGQgY29ubmVjdGlvbi4gVGhlIG5ldHdvcmsgY2FuIGNoYW5nZSB3
aGlsZSB0aGUKY21fbmV0d29ya19kaXNjb25uZWN0X2NiIGlzIHNjaGVkdWxlZC4KCkNvbW1pdCAw
MjQzMDlhOWUwNGEgKCJ3aWZpOiBSZXNldCBkaXNjb25uZWN0aW5nIHN0YXR1cyBvZiBhbnkgbmV0
d29yayIpCkNvbW1pdCA3OTU4ODNlOThlYmEgKCJ3aWZpOiBDaGVjayB2YWxpZCBuZXR3b3JrIGlu
IGRpc2Nvbm5lY3QgY2FsbGJhY2siKQpDb21taXQgZGQ4NmYwOTEwN2U4ICgid2lmaTogQWx3YXlz
IGRpc2Nvbm5lY3QgY29ubmVjdGlvbiBjb21wbGV0ZWx5IikKLS0tCiBwbHVnaW5zL2l3ZC5jIHwg
MTE1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTAzIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3BsdWdpbnMvaXdkLmMgYi9wbHVnaW5zL2l3ZC5jCmluZGV4IGFjM2QxZTE3ODdhZC4u
ZDc2ZTA4MThiZmYyIDEwMDY0NAotLS0gYS9wbHVnaW5zL2l3ZC5jCisrKyBiL3BsdWdpbnMvaXdk
LmMKQEAgLTgyLDYgKzgyLDEwIEBAIHN0cnVjdCBpd2RfZGV2aWNlIHsKIAljaGFyICptb2RlOwog
CiAJc3RydWN0IGNvbm5tYW5fZGV2aWNlICpkZXZpY2U7CisKKwljaGFyICpuZXR3b3JrOworCWNo
YXIgKnBlbmRpbmdfbmV0d29yazsKKwlib29sIGRpc2Nvbm5lY3Rpbmc7CiB9OwogCiBzdHJ1Y3Qg
aXdkX25ldHdvcmsgewpAQCAtMjE5LDEyICsyMjMsNiBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfbmV0
d29ya19jb25uZWN0ZWQoc3RydWN0IGl3ZF9uZXR3b3JrICppd2RuKQogCWNvbm5tYW5fbmV0d29y
a19zZXRfY29ubmVjdGVkKGl3ZG4tPm5ldHdvcmssIHRydWUpOwogfQogCi1zdGF0aWMgdm9pZCB1
cGRhdGVfbmV0d29ya19kaXNjb25uZWN0ZWQoc3RydWN0IGl3ZF9uZXR3b3JrICppd2RuKQotewot
CURCRygiaW50ZXJmYWNlIG5hbWUgJXMiLCBpd2RuLT5uYW1lKTsKLQljb25ubWFuX25ldHdvcmtf
c2V0X2Nvbm5lY3RlZChpd2RuLT5uZXR3b3JrLCBmYWxzZSk7Ci19Ci0KIHN0YXRpYyB2b2lkIGNt
X25ldHdvcmtfY29ubmVjdF9jYihEQnVzTWVzc2FnZSAqbWVzc2FnZSwgdm9pZCAqdXNlcl9kYXRh
KQogewogCWNvbnN0IGNoYXIgKnBhdGggPSB1c2VyX2RhdGE7CkBAIC0yNTMsMjEgKzI1MSw5NCBA
QCBzdGF0aWMgdm9pZCBjbV9uZXR3b3JrX2Nvbm5lY3RfY2IoREJ1c01lc3NhZ2UgKm1lc3NhZ2Us
IHZvaWQgKnVzZXJfZGF0YSkKIAl1cGRhdGVfbmV0d29ya19jb25uZWN0ZWQoaXdkbik7CiB9CiAK
K3N0YXRpYyB2b2lkIGFib3J0X3BlbmRpbmdfbmV0d29yayhzdHJ1Y3QgaXdkX2RldmljZSAqaXdk
ZCwKKwkJCQkJZW51bSBjb25ubWFuX25ldHdvcmtfZXJyb3IgZXJyb3IpCit7CisJc3RydWN0IGl3
ZF9uZXR3b3JrICppd2RuOworCisJaWYgKCFpd2RkLT5wZW5kaW5nX25ldHdvcmspCisJCXJldHVy
bjsKKworCWl3ZG4gPSBnX2hhc2hfdGFibGVfbG9va3VwKG5ldHdvcmtzLCBpd2RkLT5wZW5kaW5n
X25ldHdvcmspOworCWlmIChpd2RuKQorCQljb25ubWFuX25ldHdvcmtfc2V0X2Vycm9yKGl3ZG4t
Pm5ldHdvcmssIGVycm9yKTsKKworCWdfZnJlZShpd2RkLT5wZW5kaW5nX25ldHdvcmspOworCWl3
ZGQtPnBlbmRpbmdfbmV0d29yayA9IE5VTEw7Cit9CisKIHN0YXRpYyBpbnQgY21fbmV0d29ya19j
b25uZWN0KHN0cnVjdCBjb25ubWFuX25ldHdvcmsgKm5ldHdvcmspCiB7CiAJc3RydWN0IGl3ZF9u
ZXR3b3JrICppd2RuID0gY29ubm1hbl9uZXR3b3JrX2dldF9kYXRhKG5ldHdvcmspOworCXN0cnVj
dCBpd2RfZGV2aWNlICppd2RkOworCWludCBlcnI7CiAKLQlpZiAoIWl3ZG4pCisJaWYgKCFpd2Ru
IHx8ICFpd2RuLT5pd2RkKQogCQlyZXR1cm4gLUVJTlZBTDsKIAorCWl3ZGQgPSBpd2RuLT5pd2Rk
OworCWlmIChpd2RkLT5kaXNjb25uZWN0aW5nKSB7CisJCWlmIChnX3N0cmNtcDAoaXdkbi0+cGF0
aCwgaXdkZC0+cGVuZGluZ19uZXR3b3JrKSkgeworCQkJYWJvcnRfcGVuZGluZ19uZXR3b3JrKGl3
ZGQsCisJCQkJCUNPTk5NQU5fTkVUV09SS19FUlJPUl9DT05ORUNUX0ZBSUwpOworCQkJaXdkZC0+
cGVuZGluZ19uZXR3b3JrID0gZ19zdHJkdXAoaXdkbi0+cGF0aCk7CisJCX0KKwkJcmV0dXJuIC1F
SU5QUk9HUkVTUzsKKwl9CisKIAlpZiAoIWdfZGJ1c19wcm94eV9tZXRob2RfY2FsbChpd2RuLT5w
cm94eSwgIkNvbm5lY3QiLAogCQkJTlVMTCwgY21fbmV0d29ya19jb25uZWN0X2NiLAotCQkJZ19z
dHJkdXAoaXdkbi0+cGF0aCksIGdfZnJlZSkpCi0JCXJldHVybiAtRUlPOworCQkJZ19zdHJkdXAo
aXdkbi0+cGF0aCksIGdfZnJlZSkpIHsKKwkJZXJyID0gLUVJTzsKKwkJZ290byBvdXQ7CisJfQog
CiAJY29ubm1hbl9uZXR3b3JrX3NldF9hc3NvY2lhdGluZyhpd2RuLT5uZXR3b3JrLCB0cnVlKTsK
IAotCXJldHVybiAtRUlOUFJPR1JFU1M7CisJZ19mcmVlKGl3ZGQtPm5ldHdvcmspOworCWl3ZGQt
Pm5ldHdvcmsgPSBnX3N0cmR1cChpd2RuLT5wYXRoKTsKKworCWVyciA9IC1FSU5QUk9HUkVTUzsK
Kworb3V0OgorCWFib3J0X3BlbmRpbmdfbmV0d29yayhpd2RkLCBDT05OTUFOX05FVFdPUktfRVJS
T1JfVU5LTk9XTik7CisJcmV0dXJuIGVycjsKK30KKworc3RhdGljIHZvaWQgdXBkYXRlX25ldHdv
cmtfZGlzY29ubmVjdGVkKHN0cnVjdCBpd2RfbmV0d29yayAqaXdkbikKK3sKKwlzdHJ1Y3QgaXdk
X2RldmljZSAqaXdkZDsKKworCWlmICghaXdkbiB8fCAhaXdkbi0+aXdkZCkKKwkJcmV0dXJuOwor
CisJaXdkZCA9IGl3ZG4tPml3ZGQ7CisKKwlEQkcoImludGVyZmFjZSBuYW1lICVzIiwgaXdkbi0+
bmFtZSk7CisJY29ubm1hbl9uZXR3b3JrX3NldF9jb25uZWN0ZWQoaXdkbi0+bmV0d29yaywgZmFs
c2UpOworCisJaXdkZC0+ZGlzY29ubmVjdGluZyA9IGZhbHNlOworCisJaWYgKGdfc3RyY21wMChp
d2RuLT5wYXRoLCBpd2RkLT5uZXR3b3JrKSkgeworCQlpZiAoIWdfc3RyY21wMChpd2RuLT5wYXRo
LCBpd2RkLT5wZW5kaW5nX25ldHdvcmspKSB7CisJCQlhYm9ydF9wZW5kaW5nX25ldHdvcmsoaXdk
ZCwKKwkJCQkJQ09OTk1BTl9ORVRXT1JLX0VSUk9SX0NPTk5FQ1RfRkFJTCk7CisJCX0KKwkJREJH
KCJjdXJyZW50IHdpZmkgbmV0d29yayBoYXMgY2hhbmdlZCBzaW5jZSBkaXNjb25uZWN0aW9uIik7
CisJCXJldHVybjsKKwl9CisKKwlnX2ZyZWUoaXdkZC0+bmV0d29yayk7CisJaXdkZC0+bmV0d29y
ayA9IE5VTEw7CisKKwlpZiAoaXdkZC0+cGVuZGluZ19uZXR3b3JrKSB7CisJCXN0cnVjdCBpd2Rf
bmV0d29yayAqaXdkbl9wZW5kaW5nID0KKwkJCWdfaGFzaF90YWJsZV9sb29rdXAobmV0d29ya3Ms
IGl3ZGQtPnBlbmRpbmdfbmV0d29yayk7CisJCWlmICghaXdkbl9wZW5kaW5nKQorCQkJcmV0dXJu
OworCisJCWNtX25ldHdvcmtfY29ubmVjdChpd2RuX3BlbmRpbmctPm5ldHdvcmspOworCX0KIH0K
IAogc3RhdGljIHZvaWQgY21fbmV0d29ya19kaXNjb25uZWN0X2NiKERCdXNNZXNzYWdlICptZXNz
YWdlLCB2b2lkICp1c2VyX2RhdGEpCkBAIC0yNzksNiArMzUwLDkgQEAgc3RhdGljIHZvaWQgY21f
bmV0d29ya19kaXNjb25uZWN0X2NiKERCdXNNZXNzYWdlICptZXNzYWdlLCB2b2lkICp1c2VyX2Rh
dGEpCiAJaWYgKCFpd2RuKQogCQlyZXR1cm47CiAKKwlpZiAoaXdkbi0+aXdkZCkKKwkJaXdkbi0+
aXdkZC0+ZGlzY29ubmVjdGluZyA9IGZhbHNlOworCiAJaWYgKGRidXNfbWVzc2FnZV9nZXRfdHlw
ZShtZXNzYWdlKSA9PSBEQlVTX01FU1NBR0VfVFlQRV9FUlJPUikgewogCQljb25zdCBjaGFyICpk
YnVzX2Vycm9yID0gZGJ1c19tZXNzYWdlX2dldF9lcnJvcl9uYW1lKG1lc3NhZ2UpOwogCkBAIC0z
MDMsMTEgKzM3NywxNiBAQCBzdGF0aWMgaW50IGNtX25ldHdvcmtfZGlzY29ubmVjdChzdHJ1Y3Qg
Y29ubm1hbl9uZXR3b3JrICpuZXR3b3JrKQogewogCXN0cnVjdCBpd2RfbmV0d29yayAqaXdkbiA9
IGNvbm5tYW5fbmV0d29ya19nZXRfZGF0YShuZXR3b3JrKTsKIAlzdHJ1Y3QgaXdkX3N0YXRpb24g
Kml3ZHM7CisJc3RydWN0IGl3ZF9kZXZpY2UgKml3ZGQ7CiAKLQlpZiAoIWl3ZG4gJiYgIWl3ZG4t
Pml3ZGQpCisJaWYgKCFpd2RuIHx8ICFpd2RuLT5pd2RkKQogCQlyZXR1cm4gLUVJTlZBTDsKIAot
CWl3ZHMgPSBnX2hhc2hfdGFibGVfbG9va3VwKHN0YXRpb25zLCBpd2RuLT5pd2RkLT5wYXRoKTsK
Kwlpd2RkID0gaXdkbi0+aXdkZDsKKwlpZiAoaXdkZC0+ZGlzY29ubmVjdGluZykKKwkJcmV0dXJu
IC1FQUxSRUFEWTsKKworCWl3ZHMgPSBnX2hhc2hfdGFibGVfbG9va3VwKHN0YXRpb25zLCBpd2Rk
LT5wYXRoKTsKIAlpZiAoIWl3ZHMpCiAJCXJldHVybiAtRUlPOwogCkBAIC0zMTcsNiArMzk2LDgg
QEAgc3RhdGljIGludCBjbV9uZXR3b3JrX2Rpc2Nvbm5lY3Qoc3RydWN0IGNvbm5tYW5fbmV0d29y
ayAqbmV0d29yaykKIAkJCU5VTEwsIGNtX25ldHdvcmtfZGlzY29ubmVjdF9jYiwgZ19zdHJkdXAo
aXdkbi0+cGF0aCksIGdfZnJlZSkpCiAJCXJldHVybiAtRUlPOwogCisJaXdkZC0+ZGlzY29ubmVj
dGluZyA9IHRydWU7CisKIAlyZXR1cm4gMDsKIH0KIApAQCAtNTE1LDYgKzU5NiwxMiBAQCBzdGF0
aWMgdm9pZCBkZXZpY2VfcG93ZXJlZF9jYihjb25zdCBEQnVzRXJyb3IgKmVycm9yLCB2b2lkICp1
c2VyX2RhdGEpCiAJfQogCiAJY29ubm1hbl9kZXZpY2Vfc2V0X3Bvd2VyZWQoaXdkZC0+ZGV2aWNl
LCBjYmQtPnBvd2VyZWQpOworCisJaWYgKCFjYmQtPnBvd2VyZWQpIHsKKwkJYWJvcnRfcGVuZGlu
Z19uZXR3b3JrKGl3ZGQsCisJCQkJCUNPTk5NQU5fTkVUV09SS19FUlJPUl9DT05ORUNUX0ZBSUwp
OworCQlpd2RkLT5kaXNjb25uZWN0aW5nID0gZmFsc2U7CisJfQogb3V0OgogCWdfZnJlZShjYmQt
PnBhdGgpOwogCWdfZnJlZShjYmQpOwpAQCAtMTMwOSw2ICsxMzk2LDEwIEBAIHN0YXRpYyB2b2lk
IGRldmljZV9mcmVlKGdwb2ludGVyIGRhdGEpCiAJZ19mcmVlKGl3ZGQtPmFkYXB0ZXIpOwogCWdf
ZnJlZShpd2RkLT5uYW1lKTsKIAlnX2ZyZWUoaXdkZC0+YWRkcmVzcyk7CisKKwlnX2ZyZWUoaXdk
ZC0+bmV0d29yayk7CisJZ19mcmVlKGl3ZGQtPnBlbmRpbmdfbmV0d29yayk7CisKIAlnX2ZyZWUo
aXdkZCk7CiB9CiAKLS0gCjIuMjUuMQoK

--_002_MRZP264MB154403938B0F44F5C05841D8932C9MRZP264MB1544FRAP_--
