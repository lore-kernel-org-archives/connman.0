Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90074.outbound.protection.outlook.com [40.107.9.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD772
	for <connman@lists.linux.dev>; Mon, 29 Nov 2021 09:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alfUUMJAC2P3MQm1lLnGZySkrlP1EDZFcwMKBCjsMPtfAfBp+2M/knzwrJEFyRFpP3lJmb0u6mcQoDNuuFSTRf1GkX0H3J9AcnmOcWN13KHD6c78B/6GSCo/GCgR77QDK7XYzhji+MyWTCTXlz4Emx8jes8TQhwImEN8GHuA3k+3wggcG7OawHtheyUYHARQyU0/SVavTCT4BdBbjAtaXPAqeumjHtb0BKwTDkSSVtv2X0OOsBlDAg6X9DOLIbmK2Zw1wEHMH4A/gliK24aW+3mzx9n/ZCDU38LmHMhdccZCbCl8Jm5UTmgjNTUdjFQnb4B9u0XjvRsHFLdhvSkuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxj86fAvgEyKs6qn+M9/K80k9+SU/OqK+fjyGNjnL3A=;
 b=bN7WMFVNkz+yJE+b0HvlgXxaZETWN8yeixPzegHhlFyz/A7ZeHcOQW9SuauluwT6FPlQM6PWDUMeF43fOrQZ7oke4CIxQxnMaYlNq3evzpsGgPT9d+Xjma8RjKPwgaYMeoHKK8dnc0tpIhIHYeTlt62ylqNo6sf1/xKFWxryZPyFvPqr84agmvmL8gCPxEI6fMfkddcx7VjWCLCxXCOhaBYf4lFwZSiOr6nVmzELthcJZtCfTw5i3j/uF8GihbI2aWASQVJKgmhV3V53QwSsiBXffzcGLO+BkTXkfXJSqUuGcuJ+T2HuF8XZUSGEGUVnndEHFbWmIqtr9eURuLEJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxj86fAvgEyKs6qn+M9/K80k9+SU/OqK+fjyGNjnL3A=;
 b=ca05BLnaYouzFtOOd0aS+agcwcLLWc1DFnG5czoO9JrtHl8XyHehvciI/XtA8hIZUHMWa9oM/18xcKeXgc/KN0gt6xeAJWlI4Rne5zlS6KMAn4TuMqrPfla9GzjOxioa+N0kO98WX+v/6EsFzrzuJZ4a7fW8yxHqogpj6oCgEyU=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB1734.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 09:04:53 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f8f2:5a2d:be60:ce07]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f8f2:5a2d:be60:ce07%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 09:04:53 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: comman <connman@lists.linux.dev>
Subject: RE: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
Thread-Topic: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
Thread-Index: AQHX4lC3A7XrSe5BI02rfKjJZn9+U6wWAUQAgABZJ4CAA7wxAIAAG4X4
Date: Mon, 29 Nov 2021 09:04:53 +0000
Message-ID:
 <MRZP264MB154446BAABD22138868B793A93669@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
 <20211126163040.ai2euhv6yf4esnhn@carbon>
 <CAA=hcWQMThadP0TQDhqEoREroP8TNx1yQkFHC3a0=TNv9FR3DQ@mail.gmail.com>
 <CAA=hcWQB7t8GK8h0kQ1gW8iF-eO_Df2G6C354d2jh4jAxJcfSQ@mail.gmail.com>
In-Reply-To:
 <CAA=hcWQB7t8GK8h0kQ1gW8iF-eO_Df2G6C354d2jh4jAxJcfSQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 8432443e-4817-15fe-e7c4-6dbdc250b4bc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bab97272-0e86-4840-1c19-08d9b3174ebc
x-ms-traffictypediagnostic: MRZP264MB1734:
x-microsoft-antispam-prvs:
 <MRZP264MB1734C7DFC362312952184EAF93669@MRZP264MB1734.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WR3vLrBTMdQBZaoemifdwX7C6NeHgHvzDU8+1MdWfGvbGr/44rcQ7+1kVUGs3p/WyBtF3Sxy/vYVlIaaOXtxVB1/s3F9xTxVxVKA8q4oswHTwpoacB7fkYC7ba+5rD55iAo29sKllJO03/5cCk5Bis4wrPSwulmAOZULxQrr2/YGARsVa1YMGBH8UnMjVHcsqLOpKvihwKKWpirGdKIfMyRwWzTsJJlEJk9FgEQYsYVtqoSttQCF6SnlT/N3F01YNnaevCmOm6i6aEq/f82YY26LhXcmzxpMcscB7f4aQc114OqzOG3W2QZIhanNiOuxKkqu3LwGemvlsZPi+DyV3zNVqsr8SM0sn/q51GhHFMW09ADz6vSpbCF47NQRM0imKC5l+X1KTztSkNcoJyZ5CfeelarWztyxTTmWhY3YaIXlmDYNE4xXKTL0f9YC50aAnsx2HfSBDSEQcIken50hgheXHyBvX48VHbdhGcIqWLwlxcR6YjGfelI3D++WMEWndP+UC6mu6iN3adDi/OGPvyIhzD1le/Vt5UJyyVYA5or/JKIC8eUS8UFl5TumNDM8xNAJePr5TiHvEBfZa0RQuBEhTTcAk3xxkXYv9WKgD/4OMngI9xswxoR3Wl5l80VrF8BM71ABWK4lx/Mt+CDPTnSuY+T+wsQQCADEhvuNv3QniUUwUXZScxCPaiwZwz/clOK1sKYrKx62N55ti8HCfg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(8936002)(7696005)(86362001)(316002)(71200400001)(9686003)(55016003)(76116006)(66556008)(2906002)(8676002)(38070700005)(186003)(6506007)(5660300002)(6916009)(66446008)(66946007)(38100700002)(508600001)(33656002)(83380400001)(66476007)(122000001)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ja34dSz4dwSxG3mT6Jz9dVGAm0Y6XdX7Hq2dPrcwEYWo8XrJgiqo1rJ1ty?=
 =?iso-8859-1?Q?eQejptU6EdHyncPm9eGGN0moxu/YIfyq9duIPg0RCoAQTM+DlCp6MH/t16?=
 =?iso-8859-1?Q?0pkNAVcp4OnJakyDULTTqULmYICfqhSJKxlikypwIwI0UpP2R6S79KyX2X?=
 =?iso-8859-1?Q?AYnMOVhrjZiGT5jwvGqjhrVSVHyuW6XWRvCIddgJmqyETcOzgrBuXYYIav?=
 =?iso-8859-1?Q?d8Wsyz2Absr00dIZs+qurpKqxjU18hrlF3xw1wN0OaO64SZ1WfrE1wnmxI?=
 =?iso-8859-1?Q?TDqMWIRSwmhsAstq/HoJ2N5fUu7tz89vN9qKm3tRuGz7Y2I7Sh44+qdfkf?=
 =?iso-8859-1?Q?WHPzcqGCjRc3hQspYUDnX4AT+BpIW+QrB7N7FJ8wfjIZv6/u+j+X3owsX6?=
 =?iso-8859-1?Q?CC/yaVIxViZVLCjcBWB/cWsgvCu28fQG45vM+fIOkZ2hkQcpcUpSoC3ZZo?=
 =?iso-8859-1?Q?BsAUKmTovcpzL2Sy8blkbXRtlO3BbuMm6Oh/j3aBhGb5G+ieyqx2M/vvMo?=
 =?iso-8859-1?Q?gCeNNpLyKN/y50IelBZLKw3PB1tlxnyPuvSTrRFVArdMiDupcxy8Q8cQ4o?=
 =?iso-8859-1?Q?+UGXePa+SiEdhi0yGXFpHCAVsn7DVhHSFM1o6T+jzwOixlIu+KNDWwULPi?=
 =?iso-8859-1?Q?64zygKLLrUBhJJiLTyVJ+qGQ3y8VH/J8g4DW6JEvyRSX7UuZ3hg+NqNB1W?=
 =?iso-8859-1?Q?rN4ALY7/zH9j6dPQZDkLE+Uk+1xhUFexHHwJ592m3Z/YB/Vx0HHuAPmqnk?=
 =?iso-8859-1?Q?DCcniHtU1oMi1eHOEBUjTeRbTF+9LSUWIPoI+7JtnyPm5p2UZMiUo8Kkfo?=
 =?iso-8859-1?Q?Gsgswrh94vKksvh149kiv+N6RoSnLy+shq2wSrUfeAWQI29AeBr980+Xi3?=
 =?iso-8859-1?Q?2RiTRtFX5mwL/tgn9neEnydPDGVJTTJEqbaOjuancDjOY9baK1Tm4B+XxL?=
 =?iso-8859-1?Q?JMaN4fKZ5of17HSM44QGnTLhFDzn3d3G2hB4UbGTAAGjlnTeZrYRSQb4Pl?=
 =?iso-8859-1?Q?j8fpr7ISCo7isQWm3WqQcdiZQyM9NERM6CBZonrtesKYrdOshyiEupnBRq?=
 =?iso-8859-1?Q?GsWbiC92jKoJvGktClRCH/1u93Ltpk8zb4zqk3X3FM2Nnj9gC/wWMgAEFD?=
 =?iso-8859-1?Q?lXIu8UZTeVtiqaaj7sCEEOrHFZ3T5CreO+bpi0Ahwy0Bem65ZLzdovAoqi?=
 =?iso-8859-1?Q?2SCW3onay9G0usMbiGurkYS+ZHkMk+cHnm+9BmfXbdVx5DZqtz2q2Vrmas?=
 =?iso-8859-1?Q?GkzL8mS3NJ0urAjMCGWPY2g3RMX7knR6nSxp5g+74+JN8isIsSQsztBWu+?=
 =?iso-8859-1?Q?Qnu9KyXvpi6kkzbpqnU97JWy0SevUH+O88uyCvBk3lLYM2jJ9XmOeCQEc5?=
 =?iso-8859-1?Q?BiQ0PsixEa1Ui+O8rS9SI0HmQb8TbSZG15AtgcLWDUhNr0fqhqDrbPeYZF?=
 =?iso-8859-1?Q?IZ1y4oV2m4e1aiADVWZPPink+mf8RQKmA2KWY38+3vY9OenRNBXhXhqYIl?=
 =?iso-8859-1?Q?QNnly2HYYc9YgDxwlhajsVoTT7WDpJvK/IotxEicGFM2YeLnoiQP8Hrjbg?=
 =?iso-8859-1?Q?MvCc+vCs63GFDOV8BnIP3zw8cK0Slqj5xeBVnk0DaHOJtT6XozrTPeuMud?=
 =?iso-8859-1?Q?8pKNoRcf0Thw+cqV5KBQiv9yKCL8m/e3IlFv/1kUt+JA1ToJEACwODOhuk?=
 =?iso-8859-1?Q?TcYvTGZz6pTweaKhzjGrmjr18l3UxMROKBmYO6L4uInRo5U/YoBw88Ddre?=
 =?iso-8859-1?Q?ngSCct7v+m2903EpMqZ0JfXoUffEwP3JJ3kr16e0g/gUJ41WcHS0Oz+3dD?=
 =?iso-8859-1?Q?DlkWEL2oug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bab97272-0e86-4840-1c19-08d9b3174ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 09:04:53.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: embkm3zV0qAGu7ya0PEHvEM0NK0g3nZfBuaKmkX8dMf9yzAQuV6WbBH7hF1rRI258nerd7/jye0KzGOJFMTHFEJzNd3E+gLCU43I7yib3Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1734

Hi Jupiter,=0A=
=0A=
Pretty strange that you are facing such problems on dhcp,=0A=
which is a basic major feature.=0A=
By my side, I have been using wpa_supplicant, via yocto, for years,=0A=
on set-top-boxes deployed projects and it works perfectly, after few patche=
s,=0A=
maybe you can try the HEAD.=0A=
=0A=
Have you checked that your IP configuration method is hdcp?=0A=
Maybe checking the services list will give a clue:=0A=
dbus-send --system --print-reply --dest=3Dnet.connman / net.connman.Manager=
.GetServices=0A=
=0A=
I have started the migration to iwd, which required some fixes, and I have =
still=0A=
not reached the same behavior as with wpa_supplicant (but I am close).=0A=
Unfortunately, I had no more time to spend on this activity, but I hope giv=
ing=0A=
a new try before Christmas.=0A=
=0A=
To integrate iwd on yocto (hardknott), in connman recipe, we are using this=
 line:=0A=
PACKAGECONFIG[iwd] =3D "--enable-iwd --enable-wifi, --disable-iwd, iwd, iwd=
"=0A=
And to activate it via the local.conf=0A=
PACKAGECONFIG_remove_pn-connman =3D "wifi"=0A=
PACKAGECONFIG_append_pn-connman =3D " iwd"=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
