Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2093.outbound.protection.outlook.com [40.107.127.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6882C83
	for <connman@lists.linux.dev>; Wed, 17 Nov 2021 07:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc0WBqec0ReUx6K7iceLPUCzhadjt4janv5N9oAH30hwyFujGTu9rdfgr6t4om1naSVl89xxaKIqlTnaHbkugWpDcBuIqS+NNI6G6Kl1usnxG1yiWNAAwBbCFQF4ngD7zhDrxvkZbSuvC+rKNgax9Rlg/Zfbnzycfx9MwJEJtB6KLvPHuCeuL0cJsvGwMaIo+Dr6AxMIrBM8SzfkwHfR/H/ety2Yv66bmprW49EPXez9kMKhYX+fBCtT+f0hCmPAlkODmgdzmxo8Rf9csAh202KqEyhSzpEwXF0ImoipW7sTEsQpspyPXHyOxIBv7xybr/bnohD5FqsSP4TJQlgKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxEELeSARmxTlvwLTksGFZPBGDq+O4cKk+Z60EMdkKE=;
 b=nIKfK84TA5mlRNNPm4zEWQIU3dPBOTg3dSpdwlyyb6AqSea96DXmYWePhbI0BS4fPDNk8sJwveXNyTQ69QyIYmuEn98OUQhuBDjqWwseeMX6dsY1xnAW4xr4YzIF0oPxeiS4fOgTQQllK9LlF+iBvY5pYtKOjPMs1jSmoepn8KKua1aXsmoiJziXE9tdTrsEKaaO4TexNeSiTv2jbqd8PgaCF0Pb8CJn8o6npnI3ycBvlmey03rVEAR6KRwAC0URsW0pdhIboR8qX7lAauqrG/q0UVk72vaj5BAGe4yv8Q1ExGOSz02nIfXW6Zi6kniIlbvNPP34b/6x87PRMd03eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biotronik.com; dmarc=pass action=none
 header.from=biotronik.com; dkim=pass header.d=biotronik.com; arc=none
Received: from FRYP281MB1071.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:76::5) by
 FRYP281MB0942.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:73::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.17; Wed, 17 Nov 2021 07:18:36 +0000
Received: from FRYP281MB1071.DEUP281.PROD.OUTLOOK.COM
 ([fe80::54b9:e999:726f:fd58]) by FRYP281MB1071.DEUP281.PROD.OUTLOOK.COM
 ([fe80::54b9:e999:726f:fd58%9]) with mapi id 15.20.4713.019; Wed, 17 Nov 2021
 07:18:36 +0000
From: Lars George <lars.george@biotronik.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Next Connman version and OWE support?
Thread-Topic: Next Connman version and OWE support?
Thread-Index: Adfbgy4HJlr4cWNlTGGoBt7QH9Bjgw==
Date: Wed, 17 Nov 2021 07:18:36 +0000
Message-ID:
 <FRYP281MB1071B616037CC5361DD75CACEB9A9@FRYP281MB1071.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=biotronik.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d31bf3da-bebd-4d0d-4940-08d9a99a78a7
x-ms-traffictypediagnostic: FRYP281MB0942:
x-microsoft-antispam-prvs:
 <FRYP281MB0942AFA007E32F0C96B72BF3EB9A9@FRYP281MB0942.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XuMhvcBHH4v9Y1rZgkAuGRIpSb3VmAJF7V0cvhbvGGNkXCcU/jgZ+KmYXVPVmX7guVPqBajUlp/eOVt1dMeqan7JrIHJdP+uc8KKS6j7NyqazCa0i3qmkwetmP1lifgwAVMfgq4Tqt/xXHJpyMkxk8N+FRJCdvfwl4TzpKwP1usjfzx4a6j8niGWn+LvFaLMjrdDqu8mfec27LjyWw1cq4WWL5nqgbOVHS2CeySqX9vjlkq1DHDHWy95tf2q8YAuPxs62fo8o3PzySuHjcGpWk9ZCtzB0q4FgQZRQxZMveOAJ3Mi1O89wpfS5i9ih90e8jm3hOKBibir1HSjjLrL15ouAJ51KZGT66yyx2XbYy4UkQpb6FlESvMH7zH58s7sKEpLf1kPO5/S3eIc2C2NyqdaJ2yXHHdi5cPAJDDuqsglF+zZ1sLs2EcRt9F4ahKPHHHB/mmIgnerWWhJFYPsSjS1s/Q98ff2UbhBi+o+/uyf/vxvyu714yETAQglfuc+OqE1xB/GR6SQ4eTUjEl4LNQj/5RTBcNi9haZV7Ny+Gdq5MYchi5vJddajzq2JTtD22+7yW74iT8nlZrEHzRhlmrl156DOd+FKuLsoebMOaNb65OgpB3N8uP+fB0dNvDqxX0+oy1wHhXVexZsvhQVE5x9SZIR4vZXNTwVW5wsv67FiQjxJhjRe/pGe3jC5/afqu2Y89hQHMcas3M+/YqwCg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB1071.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(2906002)(5660300002)(9686003)(508600001)(64756008)(66446008)(66574015)(8936002)(66946007)(76116006)(83380400001)(38100700002)(45080400002)(122000001)(316002)(8676002)(66556008)(86362001)(7696005)(44832011)(33656002)(38070700005)(71200400001)(6506007)(6916009)(55016002)(186003)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1JKdmpoOEkvYmJscEVCN2prbWhFbThQSHpMeGxTcWFIZVBBTXFONDU3cnFT?=
 =?utf-8?B?Smg5Z2JTT01BKzFmR2RYY1VDeWdwVE51YlJ2VlBwSzNoQ3NCa3hQTUZZZHFy?=
 =?utf-8?B?dHJmSnRtbThoZnlCdmZJbko5TEhMK3ZxZG5FWmhpcVNNcUtZcGZUQXhEUllx?=
 =?utf-8?B?UTB5L0JtM04xUTRnOXA0MWN4NWRnb20yM1A2RUtFKzZtVUdyN0xqQW81NmhH?=
 =?utf-8?B?QzhTSWM2TE4zUC9SbkJtSUpVRm5seXdhN3F2OVVqY1lMcGJCSERIcGhQT0Uz?=
 =?utf-8?B?Qm1WVjhKQmtCZzV0ci81SzkyaXEzblkvbmNVYjUzbTJ4MWRzZHl4b3lHckRS?=
 =?utf-8?B?b1J0R1NOWlkySkxiUVNiaDhBYTRITVRHK3VacU5XS25qUzNodmpxaTRyRTVJ?=
 =?utf-8?B?SjJoWGwvcGd4dW51T0MvdWZaTk1CT2ZyckRRYTN2azdlb0IzYkd3OWlQNFhs?=
 =?utf-8?B?NkJ2QURxU25RNmZrUjBkWnZ2bFRGeFc2YmUweE96R3lKMG5hbnBzOWtNR2RB?=
 =?utf-8?B?N2xKdVRtd05JV0Q5a294a3ZwRXRSTU55RXV1WFBtUG0vU3k4dzRnc2tKQ3J4?=
 =?utf-8?B?b0NZR3JrRURqUDkxTjZrdjRKc1o1ZW5Td2JTWDYvSzVaRTJoeS9TUWR3VUkr?=
 =?utf-8?B?QzV5M2hVREdhZG81MnBReEt6T3FkVXBtRUZCS3g4Ri84a0xUdk8rZTkrUThH?=
 =?utf-8?B?eDZFZkNpbURWQlB3T2xEYTRIZ3ZFUisrdkpkbGhPWmlUSXBoVzFxdFNLTVVs?=
 =?utf-8?B?d244L0R0amlrU3FndzRZNGJhVDhaTCtyR09nVXU1UzVrWG1rZElSVVN2OU9l?=
 =?utf-8?B?UUhMSHREbWxQbVc3RmVseWEwdFhtOTJxVnRrcHFkbUE4MWxPRlZPNi9kMnQ4?=
 =?utf-8?B?Z0g2MEVZQURjTmVQOXRWbDNabTdBeWFUTU5uSEVkUVNKcDlJWWJtaUFWcE12?=
 =?utf-8?B?TjFMVGE3bVRZZkRzMTQ3TFh4UG8zZGlzeXorcHk1UVJmZXFXMXdsUEtUai9S?=
 =?utf-8?B?VnlGRkJadVhadjR3ZVVNSTBBc3VlaTdUeTFuakVPTEhjYkZwWUV4c3U4Um5E?=
 =?utf-8?B?bE9RWjkxYXI5d3pEaXIrT0IrSnhydEozTEJ2WWZyTkFBcHgwUytaM1VuTEhv?=
 =?utf-8?B?a3NncEU2NVVoZGpLNi9rMWZ3dHQ4WUtzU3p0SFpKSW1mS29FTkExT0V6czNi?=
 =?utf-8?B?bk9CdEFUV1hkaWtzM3VLRjBTaCs3K3UrVFNyUE9FNUlJSGQ5TytkOTV3M3RB?=
 =?utf-8?B?QVJJdnpLbEkxL1JaN01hUVpvd21oaHhubm82UkxwMXlxYkdtWmVjbWJuY2Ri?=
 =?utf-8?B?cVhYVGZHSW11ZllhcVV4Q2w1VFI0dk56L2p3ams3eTFvL25WVlZLL2JHME9N?=
 =?utf-8?B?U0ZUVTkyVy8wSTd5cEZSMXgxQlFCS3J4NnlySnhZc3dJTlhEM3ByUnZBUHRU?=
 =?utf-8?B?SHQ5OEUvMm5uelM5Um92TStkQkRJNUliTjVsc3RsNkN4TjZ4OVNFa2pBT21H?=
 =?utf-8?B?RE9qVTN0dm1IYTUwZ1hveDdyeUk0OEVnb0hLTWRhYi9yVGhFZFc3OGQycHFt?=
 =?utf-8?B?enFWV1BBY0VaSVdNMTc3UlJ6WVB0MnVQcWtEQlFoSDRPS3d5Y1dGVXBHLzZG?=
 =?utf-8?B?Z01UdTFDWThLQ0VvVGowT0h3TUVGazE2ZmpZTnVEQ3JXY2M2TEwxeDZhL0Y4?=
 =?utf-8?B?WEZidFhYRzhxRTBKSFFiL3VTVGhsR1FDVHB6NHZZb2hzdjhScEt1UG1iZkF3?=
 =?utf-8?B?cVczbWxyKzV0ZHA4WFNwYnBkR1FiUzVSdTJJVW9ZMkN4cUJJUVFNSUZ6ODMr?=
 =?utf-8?B?cGVvdWM0MnlWb2xDcm9DamVlUEloT2NNVHlvRVRBV2lrMVBXblhwNk5HWWFI?=
 =?utf-8?B?N25aZFNxTktOU3Rrdno2UXNDcEp1RnFpS284WkVMSUFJQXYyZitScjFtMEJs?=
 =?utf-8?B?YTQ1ekZFaE5lM1Y5aDh5SFVDT1Jlak9uY3k0L01UUGRPdW1HNlp2ZFI2KzFi?=
 =?utf-8?B?cGd4Q2lGSWlRL2NiL3k3Ukt4cVY3Qm5JZzVmT2xCVytlS1Roa2NIcjlGQVpI?=
 =?utf-8?B?MHNWUlRwRm5rZWVGRUhUejRRWEplMEF6ZW5iN0JJNHp3V1JpcE9WNWpyeHl0?=
 =?utf-8?B?ZHJvSlo0cThQb1JWZlpEdG1VVDJwRHVodGdCcWRxUFk0Z0diT2M2SWNwdHl3?=
 =?utf-8?B?SGZ5ZjlBSGR2UytOczhFeEI4WmFBek5RdVNrbG41ZWxaUkNmeTA3blFwc21Y?=
 =?utf-8?B?UGdjRlJLY2VhZ0RSd0R6bzQ0QlRDOXBGSEtzWEhPMHV0ajdpSkNlS0xTZ0xL?=
 =?utf-8?B?OHZvdWd4VGt2UHpaajZjcm9ncHZQbHJ5cUVwT1p0cVZxclNYbkZLZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: biotronik.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB1071.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d31bf3da-bebd-4d0d-4940-08d9a99a78a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 07:18:36.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2ca232a-b693-4c5c-85c0-fa32e65ba0b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpvWDtYwWNMeDUpBMZdTuAwLXcLc4htFeWixZevM9FSh72t3sJo/C+aPx4gDEU1v62s74W2PlA6FOBb6J6dJREhhImuYNgH7pjO3QldVCjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0942

SGVsbG8gZXZlcnlib2R5LA0KDQpGaXJzdCBvZiBhbGwgdGhhbmtzIGZvciB0aGUgZ3JlYXQgd29y
ayB3aXRoIENvbm5tYW4uDQoNCkkgc2F3IHRoYXQgQ29ubm1hbiBub3cgYWxzbyBzdXBwb3J0cyBT
QUUgKFdQQTMpLCBidXQgdGhpcyBpcyBjdXJyZW50bHkgb25seSBhdmFpbGFibGUgaW4gdGhlIG1h
c3RlciBicmFuY2guIEFyZSB0aGVyZSBhbnkgcGxhbnMgb2YgcmVsZWFzaW5nIHRoZSBjdXJyZW50
IGNoYW5nZXMgaW4gdGhlIG5lYXIgZnV0dXJlPw0KDQpJdCB3b3VsZCBhbHNvIGJlIGdyZWF0IGlm
IE9XRSAoT3Bwb3J0dW5pc3RpYyBXaXJlbGVzcyBFbmNyeXB0aW9uKSB3b3VsZCBiZSBzdXBwb3J0
ZWQgYXQgc29tZSBwb2ludC4gQ29ubm1hbiB3b3VsZCBuZWVkIHRvIGlkZW50aWZ5IGl0IGFzIOKA
mG5vbmXigJkgdHlwZSBzZWN1cml0eSBhbmQgd2hlbiBjb25uZWN0aW5nIHRoZSBrZXlfbWdtdD1P
V0UgaXMgbmVlZGVkIChhdCBsZWFzdCB3aGVuIHVzaW5nIHdwYV9zdXBwbGljYW50KS4gVGhlIGlu
Zm9ybWF0aW9uIGFib3V0IHRoaXMgY2FuIGJlIGZvdW5kIGluIHRoZSBJbmZvcm1hdGlvbiBFbGVt
ZW50IGRhdGEgb2YgdGhlIEJTUyBpbiB0aGUgQUtNIFN1aXRlIExpc3QgKHNlZSBJRUVFIFN0ZCA4
MDIuMTEgY2hhcHRlciA5LjQuMi4yNSBSU05FKS4gT1dFIGhhcyBzdWl0ZSB0eXBlIDE4Lg0KDQpX
aGVuIHBhcnNpbmcgdGhlIEluZm9ybWF0aW9uIEVsZW1lbnQgaXMgYWxyZWFkeSBpbXBsZW1lbnRl
ZCBpbiBDb25ubWFuIChJIGFtIG5vdCB5ZXQgZmFtaWxpYXIgd2l0aCB0aGUgY29kZSkgdGhlIHVz
YWdlIG9mIHRoZSBJRUVFODAyMTF3IGNvdWxkIGFsc28gYmUgcmVhZCBmcm9tIGl0LiBUaGUgTWFu
YWdlbWVudCBGcmFtZSBQcm90ZWN0aW9uIFJlcXVpcmVkIChJRUVFODAyMTF3PTIpIGFuZCBNYW5h
Z2VtZW50IEZyYW1lIFByb3RlY3Rpb24gQ2FwYWJsZSBjYW4gYmUgZm91bmQgaW4gdGhlIFJTTiBj
YXBhYmlsaXRpZXMgKDkuNC4yLjI1LjQgUlNOIGNhcGFiaWxpdGllcyAtIEJpdHMgNiBhbmQgNyku
IEN1cnJlbnRseSB0aGlzIGlzIG9ubHkgaGFyZCBjb2RlZCBzZXQgd2l0aGluIENvbm5tYW4gd2hl
biBjb25uZWN0aW5nIHRvIFdQQTMtU0FFIGFzIHRoaXMgaXMgcmVxdWlyZWQgdGhlcmUgYW5kIG5l
ZWRzIHRvIGJlIG9wdGlvbmFsIChJRUVFODAyMTF3PTEpIGZvciB0aGUgdHJhbnNpdGlvbiBtb2Rl
Lg0KDQpLaW5kIHJlZ2FyZHMNCkxhcnMNCg0KYmlvdHJvbmlrLmNvbTxodHRwczovL3d3dy5iaW90
cm9uaWsuY29tPg0KRm9sbG93IHVzIG9uIFR3aXR0ZXI8aHR0cHM6Ly90d2l0dGVyLmNvbS9iaW90
cm9uaWtfbmV3cz4gYW5kIExpbmtlZEluPGh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55
L2Jpb3Ryb25paz4NCg0KW0xvZ29dDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
DQpCSU9UUk9OSUsgU0UgJiBDby4gS0cNCldvZXJtYW5ua2VocmUgMSwgMTIzNTkgQmVybGluLCBH
ZXJtYW55DQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IEJlcmxpbiwgUmVnaXN0ZXJnZXJpY2h0OiBC
ZXJsaW4gSFJBIDY1MDENCg0KVmVydHJldGVuIGR1cmNoIGlocmUgS29tcGxlbWVudMOkcmluOg0K
QklPVFJPTklLIE1UIFNFDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IEJlcmxpbiwgUmVnaXN0ZXJn
ZXJpY2h0OiBCZXJsaW4gSFJCIDExODg2NiBCDQpHZXNjaMOkZnRzZsO8aHJlbmRlIERpcmVrdG9y
ZW46IFByb2YuIERyLiBIYW5ucy1QZXRlciBLbmFlYmVsIChWb3JzaXR6ZW5kZXIpLCBEci4gRGFu
aWVsIELDvGhsZXIsIERyLiBUaG9tYXMgS3JhZnQsIFN0ZXBoYW4gU2NodWx6LUdvaHJpdHoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNClRoaXMgZS1tYWlsIGFuZCB0aGUgaW5m
b3JtYXRpb24gaXQgY29udGFpbnMgaW5jbHVkaW5nIGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRp
YWwgYW5kIG1lYW50IG9ubHkgZm9yIHVzZSBieSB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpOyBk
aXNjbG9zdXJlIG9yIGNvcHlpbmcgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBu
b3QgYWRkcmVzc2VkLCBidXQgaW4gdGhlIHBvc3Nlc3Npb24gb2YgdGhpcyBlLW1haWwsIHBsZWFz
ZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIHRoZSBkb2N1bWVudC4N
Cg==
