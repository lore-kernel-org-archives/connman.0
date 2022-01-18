Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90058.outbound.protection.outlook.com [40.107.9.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFDB168
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 10:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRGv9UPku2TpyJNzchQKoTDhp4QHcoQCLZ9pHl092WnZ3qK2V1PW6LkaDeGC3jjX8q94CXErUDSWqlWe38IPPcScKqpX3LYUlggEBMO0Vjmu55ArY2JKpUI6hfNihP9OuYEvYurcvIVtZ4R9PLhbhgb0Px7K22D/IIvUQaNdTTroofeCHllIet4oQY9VFyn5+B3N0O7R/aE5WSijl4Z7IdgOUZU2u3d6KFPA3n9l11bsPEpYBBBBk1390b6m9LZvF3yX8iYZhrVNkTeD36BBkrgNG4mgeqTD6EG1bQqJH6fDx5wQ9v94Dg6CUjGs7/4+Ev13QmjPkBNgnNBvE1/hzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVCUTkQrKBBa5+PZxSg7dFiA/r75nVZgBrW95Qtjl6Q=;
 b=Af+WHVp3mBb3T3XPxxhUK0m45YMSUGARt+RhEciPuosq8rJeZDT8JH16UBzNH8DHfYjBxS/mf574l4W9P0dzHWIaj50/XsZeT87/cxIFD7xTVw2kceLo6EFfHDVax7p5tlUI1RvXnbX+1k/SwNgaAyldmmjts4TB1qkZA0DGWZKgw6qpxmaM7GGiVkbHQWIqCNxf03Z8I15WKhwrMYQCZyq+Rut0Zkwi+nwMJT0fvFBsJKu4P6q5Hb8zxzNSP6Zvr2kg5nZTEucYQExK6ytCLnPjuwLbWxs1kjh+Xuc+TVak1Gq9364MPiHMn6LaDehl8/2nHm1rD/GpwqttOQvQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVCUTkQrKBBa5+PZxSg7dFiA/r75nVZgBrW95Qtjl6Q=;
 b=bjJpC+XMfh1sG+yeFNLkJ5BkAdiIqCAo9yo6d1nswrNm0RMCcj1PD1l7dkCyvJuTAdKN939X+vDfMyUm2ZdEhQKliGw1AnWrIqh3fLIqTVxjSOIhhRdFdneTQcNYiKChoDI8flLWVTwoh3vlxtJHH15mYg+22PAwXwG+V3qutcg=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR0P264MB1946.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Tue, 18 Jan 2022 10:47:05 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:47:05 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Fix station in scan callback
Thread-Topic: [PATCH] iwd: Fix station in scan callback
Thread-Index: AQHYDFZFvKv00kRpGEuWjfSrVy/9aqxok/cggAACjACAAADrLA==
Date: Tue, 18 Jan 2022 10:47:05 +0000
Message-ID:
 <MRZP264MB1544754C0EEF8458A4A58F7793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118102842.1199829-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15441C964067460C12EC95B793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uwnROoPv55mkO267v97UdSaPo9=Lu2-npKcbObhfxo6HUw@mail.gmail.com>
In-Reply-To:
 <CAOf5uwnROoPv55mkO267v97UdSaPo9=Lu2-npKcbObhfxo6HUw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 994c39ca-a156-0bc3-655f-25d6523c6595
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9b59604-8b9b-4eb0-fc38-08d9da6fde0b
x-ms-traffictypediagnostic: PR0P264MB1946:EE_
x-microsoft-antispam-prvs:
 <PR0P264MB19469B5F5AAFB0798FFA617A93589@PR0P264MB1946.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ScdzlIxFCDnxSHmK3UFdyJLey0J9rkdSo/a0Iyukj3hONd+0DNkeaSSsBQaZfOP/erwG6E7/E1sLhmTKoykNcR47R1hAQX3Ckig5QV8kKVFvADw7fRqAXl219moKLsFLECkDzJoHZP6fSPdhePl8RoWvZ/i+kh5CLQarpHNAXRNKVBrEAtEx+o+K3S0MoMwnPK+T4kRpnjXUQwyNNNocpg+PHNnFBvmvsmutVUpNyNr0rqbvuLVnrelLdM3o7igOpPWyGvvQeSvzrTe/lonO/5TxeIYYYJGLULwmcYIPgzBdjjig4hYhKTroV/u5lv35+NE+QvzzmOxJyIgZA0RXTcs6pKxky5CCBwR+u7vZti1xYTzKFfJeykyv4awqy0fBN1hhYhPw3cboeRgq+eVQp46aM2pIRKzawDtMF1U5OoSQgcmFxPlbqGFDc/TVwcu6SVAoywQM2ZuSaBVaFRrh1ovccILZBayPHoVq0o7av3J2X3oK1QGd3kKTAUMp9fO2OM7R3IKDbI0p4geHVKuVrCQgfnabtCyNO4xWWV7PENdZaKZj/fCINCJpTeNY5htDhkali7OQFLF2K4TLStdDBp7jfRUtBN1mQardaGIUyFPxjoOn+S77hGoT9QrHXMUGE2UXowe80Y23nlp3Bk6MjB+k1yOTgvmGNMxGqjMKZ0V9KFE5yE3rOjgxy2WwhlwNaAxgKfKcFgPGD0+z4VOqJA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(71200400001)(83380400001)(66476007)(6506007)(7696005)(508600001)(4326008)(99936003)(33656002)(86362001)(91956017)(186003)(38100700002)(2906002)(558084003)(66946007)(55016003)(64756008)(66446008)(38070700005)(8676002)(76116006)(5660300002)(6916009)(122000001)(52536014)(9686003)(316002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rYwCgnin/Lzw5lhUY4kEMUv6efZtb0Uq8tN6M45JFN47Of7i4Yy+LLo5mZ?=
 =?iso-8859-1?Q?ByNo/W9wne1zKGtdSsxJtbpLx/4K91asgQDclNrHgpk9wsMH1EyBNXgLdT?=
 =?iso-8859-1?Q?E1rgLn57pKGIjFa1FzMo0qUuUH20Jl/49k11YYchOM4BkDo4Z3+mAHYVVf?=
 =?iso-8859-1?Q?SHKKIEuJ0/2kGo7nKJc9fOiXu6aaYCNn9Cv1xXZCARDTgHZ1abFkTiGRM6?=
 =?iso-8859-1?Q?/kMKk8jYknr5qm5iRnDHLh8nlr3Qb6tICEyxpzRIiRpkQETIM2OASLhoxp?=
 =?iso-8859-1?Q?Ji88V9XO2I5MC4rFD1F7QJno64Zr6al9vERWsvXLEtndjcdiFTgL69lHgf?=
 =?iso-8859-1?Q?N/L6li1w1z9fGZ/NaVZXVzUS6x/Luwyu0zInKBSFGVjK7aT0s0kQRS4UWy?=
 =?iso-8859-1?Q?4xdxhgyrgyfbzELZzpKYK8u00t7UMAumK2+DXHVefZBT3yRRD28QL3LWg4?=
 =?iso-8859-1?Q?z6CkE4ubB3pBKIs5Xn9An9Q7KqhloqJGKfkC5WJ5FfECMOhNqO4X3vXWgW?=
 =?iso-8859-1?Q?Tm2fv46jfe5do5EKjPtucR96gMQscZm5c71bXAySxTpJP0NjJGuf//AkFQ?=
 =?iso-8859-1?Q?LllpwlOmy+cdTECTyyMddV6gOxc3Lqa9WDcZZEWONPdiTVsCv34NtBlqXj?=
 =?iso-8859-1?Q?91dNBn08NzUn/vWgJXS+9lS+QHmPHm7okQlfgrBKDzDgcqcM9iIa6wDt3g?=
 =?iso-8859-1?Q?Vaml+XEzPhGYrSTaXwmcuJUTFrE2VMiOh/FkFIdU6FOMcGlO1WElEKCeiH?=
 =?iso-8859-1?Q?vUCmWjF/GKfyHqvwvF/yBDR3Qg2XB0pbB5YIVlzLHYPShqikGtw1nY5WzB?=
 =?iso-8859-1?Q?Zwn1VLWDrWIa7FUXa8lXjehq8b7zFTcQ4C2+ht/UEJ1sZDXp1YKbzqrYRz?=
 =?iso-8859-1?Q?CktiLWKFwwKZXVdXABROQ3jfDN+0NmtQmx2HpWLDHh4cNEOZtaoaObQT3D?=
 =?iso-8859-1?Q?EyrOVgPt2+iyx34vPstNcJLdwO2avFVekYUSQZp/we17BUpfI+PX896dXX?=
 =?iso-8859-1?Q?yYeHhMlR41wuh2sbn3dgqc3xHaGPHhB9353mEPjplA1iEwIzN7s7JEXv3N?=
 =?iso-8859-1?Q?e9QI5HRIxrP/wXeIsGGpnYfqUxpWGWsG6TJxnkfPb/C9chHtIawocyn7aB?=
 =?iso-8859-1?Q?lwEd1YUfTzpBZQL1Bm2TDXAnxGNgOe52OhSPqxWfdySIDDaTpBp40Zve0o?=
 =?iso-8859-1?Q?oZt8LGmJcF1e7xi7bzjJZ9zM3CMOhKjJEliMRWycWHLIB/U5dAGCGankhh?=
 =?iso-8859-1?Q?cPXN19GvgKzD4871eo8ggXP8Ay2zVXin0p2GkF2tFNtfdf+8EIDHk4N0GI?=
 =?iso-8859-1?Q?PveFUfRfGaZMrvjtstVbICW4hZCzp3JEK+D4g4eDo1StNLozpDG+PbUhEz?=
 =?iso-8859-1?Q?ADQGFt+qtBivA2yOUBYw8InQAYkWDs0iem4fsKWpJ0DG0w3L9mHWe9Aseh?=
 =?iso-8859-1?Q?mLMIpq/citSPDouRBVuIp1RoeVc/oO7jgtzECR6O/XO1gHNTsjkC+u0bOZ?=
 =?iso-8859-1?Q?kA0uJHZ5ZcQlaPO7gXrM0HuE4HyfMh2IwSI7Tc1NrCdpkrKjITZSpVtpCZ?=
 =?iso-8859-1?Q?h5WfCPxr5YXIveKRvEfP82RlIIt4F3tTVoXLxXYfd0irM+vx5vQyrDnA/Y?=
 =?iso-8859-1?Q?ZXByzesHp7Q/VrEo7Tj2F22kvRI+4+zJyV+KHiR6a13E1gHdweejU5tSLF?=
 =?iso-8859-1?Q?Uwe484BOvywcj1d2wlMWeRHuVSLsZt2mW6jn4QIIMV24h5cPAgEtxy9wNa?=
 =?iso-8859-1?Q?vWeLZBNEig31fHGOXQe2P0UKaJGRj1sX8O4zZzY/AmV24rkzL0fJtNKrz4?=
 =?iso-8859-1?Q?DXcMtimePg=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB1544754C0EEF8458A4A58F7793589MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b59604-8b9b-4eb0-fc38-08d9da6fde0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 10:47:05.0562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuIdzUfk9M5uJrgwQZ5RymKQ6iY89am1Ir2Hb5MA9n54WmMmDOFsJTNywCpoaS/Reim8YLMWJMl4wJQV35vPvqQt0pniK509k+CW8eWgm/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1946

--_002_MRZP264MB1544754C0EEF8458A4A58F7793589MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Michael.=0A=
> Can you describe how to verify the problem?=0A=
Only dev logs are impacted. They never were=0A=
called.=0A=
=0A=
As it seems that either via gmail or my pro emails,=0A=
the tabs are automatically replaced by spaces, I attach=0A=
the patch.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
=0A=

--_002_MRZP264MB1544754C0EEF8458A4A58F7793589MRZP264MB1544FRAP_
Content-Type: text/x-patch; name="0001-iwd-Fix-station-in-scan-callback.patch"
Content-Description: 0001-iwd-Fix-station-in-scan-callback.patch
Content-Disposition: attachment;
	filename="0001-iwd-Fix-station-in-scan-callback.patch"; size=820;
	creation-date="Tue, 18 Jan 2022 10:44:27 GMT";
	modification-date="Tue, 18 Jan 2022 10:44:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyY2I0OTdlMWVmNWI5NmU3NDU4ZWVkNjI4M2E5NmFlMWNmZDllOTBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFR1ZSwgMTggSmFuIDIwMjIgMDk6MzA6NTcgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBpd2Q6IEZpeCBzdGF0aW9uIGluIHNjYW4gY2FsbGJhY2sKClRoZSBzdGF0aW9u
IHNoYWxsIGJlIHNlYXJjaGVkIGluIHN0YXRpb25zIHRhYmxlIGluc3RlYWQgb2YgbmV0d29ya3Mu
CkZpeGVzOiA4MzcxMTE0YWFlZjkgKCJpd2Q6IEhvb2t1cCBtYW51YWwgc2NhbiB0cmlnZ2VyIikK
LS0tCiBwbHVnaW5zL2l3ZC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvcGx1Z2lucy9pd2QuYyBiL3BsdWdpbnMvaXdk
LmMKaW5kZXggYjBlMTdhNGQ2Mzk2Li5iYjk3MjYyZWZmMzggMTAwNjQ0Ci0tLSBhL3BsdWdpbnMv
aXdkLmMKKysrIGIvcGx1Z2lucy9pd2QuYwpAQCAtNTU1LDcgKzU1NSw3IEBAIHN0YXRpYyB2b2lk
IGNtX2RldmljZV9zY2FuX2NiKERCdXNNZXNzYWdlICptZXNzYWdlLCB2b2lkICp1c2VyX2RhdGEp
CiAJY29uc3QgY2hhciAqcGF0aCA9IHVzZXJfZGF0YTsKIAlzdHJ1Y3QgaXdkX3N0YXRpb24gKml3
ZHM7CiAKLQlpd2RzID0gZ19oYXNoX3RhYmxlX2xvb2t1cChuZXR3b3JrcywgcGF0aCk7CisJaXdk
cyA9IGdfaGFzaF90YWJsZV9sb29rdXAoc3RhdGlvbnMsIHBhdGgpOwogCWlmICghaXdkcykKIAkJ
cmV0dXJuOwogCi0tIAoyLjI1LjEKCg==

--_002_MRZP264MB1544754C0EEF8458A4A58F7793589MRZP264MB1544FRAP_--
