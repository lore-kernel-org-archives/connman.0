Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50082.outbound.protection.outlook.com [40.107.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0E72
	for <connman@lists.linux.dev>; Tue,  7 Sep 2021 08:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iyd8qJSSRjH/KISQW6TdZBh11G/cx545d4czYN8qt8fXHYgT6bVq57/F1PJn1FibMvGQK5NH2+pPVAfr5e8fy1qWU7VYa7W13oHUmRaCjN6tgN3Z1RE/x2u7XO0ySIadsO7iMecVjgjuvpg1iQOt9axgZsJYpFedSsvsbUsWYbxRAxP1X7NwDmLSenteaENmbPnMFUUMb+oY4djk148RxXRh1UQOaR3+P3F9q6fnqk4N2/8dhCrf+FJ27kZacCJw2yXJ7K8C6b62uCibK3zBw6zAbokrW7okJ978PcFZFBS4myT/+AZAVKBwn5uPExfnT+J7ouTiAIPBBzhKjkVXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jyGUPDeuscZBRFB2Kz0szWkAqZw1FTt88x/BdYhJOSs=;
 b=EknM4dRBJgRT7Qq4yDH/GY7jdx0WbUJayY9PUtify9EooZxGq2pErhfp8DuGUiMwg5xMbOgai5eFfZHv6t8mhrkG8/nZf+YkZ1u+FJf5kySyfP8E1reH2DY7drPCbxW2rWmN0wQjKvuhd8TeLtU/MnmDXMONJjZfimMKwFb19l1FuKqfXMPQIJhpkT1ufq2JkM7u0o27ZxKVwjf1cTf1V/1QjgiMKWNa56bM8kaX05zK/hqNcLkKtSpfgJLKmcXrZVo66+jo+6xGN7ypy0PsO3umFijHpBmZfmr1+f5WoabgOoVEkkj2z7G0gwlu4miCPD+ydVhQn039OtgSpx4UDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=my.bosch.com; dmarc=pass action=none header.from=my.bosch.com;
 dkim=pass header.d=my.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=my.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyGUPDeuscZBRFB2Kz0szWkAqZw1FTt88x/BdYhJOSs=;
 b=MsxygTjLQsubbYdOEhH7NIWSwIqCKbbdW4WzQBabprp9AI78FPjgjNdtk6cw3apgs38MBYpVmRfl1U0fzi7syb/YsqDVVUiye8OkilkUIv/yIecOSbb5oArp+7pCSEnB4IOM1Pg2P0xsJkfA9r5CG7E5qT91vT3JqNwHOrvBiEY=
Received: from HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:59::20) by
 HE1PR1001MB1003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:67::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.23; Tue, 7 Sep 2021 08:16:47 +0000
Received: from HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14e9:ba2f:35fd:f606]) by HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14e9:ba2f:35fd:f606%3]) with mapi id 15.20.4478.019; Tue, 7 Sep 2021
 08:16:47 +0000
From: "Then Kit Sen (XC-CI1/ESS1-Pg)" <KitSen.Then@my.bosch.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Managing Wifi Network Interface with connman
Thread-Topic: Managing Wifi Network Interface with connman
Thread-Index: Adeju6pp73DquBECRESPQk2Tda71cQABGcyw
Date: Tue, 7 Sep 2021 08:16:47 +0000
Message-ID:
 <HE1PR10MB154607B2A38761302711B505CDD39@HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM>
References:
 <HE1PR10MB15463985825D31A494396897CDD39@HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <HE1PR10MB15463985825D31A494396897CDD39@HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=my.bosch.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 445ddcf2-0b9a-45f7-b814-08d971d7d601
x-ms-traffictypediagnostic: HE1PR1001MB1003:
x-microsoft-antispam-prvs:
 <HE1PR1001MB100371377CDDBC24CD1CE4E4CDD39@HE1PR1001MB1003.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wA1XCh8Lh7iLp7DQ6A3dh9xtF1R8yS3kq3AaujOIWZwh5yAeIY61+WNMNzxlqBA/hWddVFckU9tfc3gm4DPXZS3tPdeL+M7VXMCHEXLh2ZMvNJY40CEAzY+mOI1DMqW5fIWxOCSuJd/khTvG/fiaIzmzuRrkT1viMfPaOtxAImuZQqJPrZ4PkhCfAWT46TfKhJj9GiS35a2hgyBW9hpNWWME2jgqQuCr24z/0LF9qt1qQxwft2cCJEkKiZlynKA66sl5md7R7Gr72EelJ69syrN3t9fN3pIBx1yb1+ODg9AgxrTOpBrUbURH8X7mteYeUK2CnZ3phcZg6bNKPCij5o2aWfM3HeSoMDpglKSmjxLqbegNQeq6Mirt8QY2Egai5WVhLGKKq0Msdq/R7sT6YRdxRki9Ei6/MoarqNUaFREgutPwhl0U/sdo4k2rUXnDsR1y1yF7rPRHXl6b56aDy44SIyjheHpt2B7Jz3Ee5tT+4Iy31k2D6jf/7Zce0k7yW/aYfqsWdMk4EvWy/rJ56D/Bd40WwvFbfwLVPwfpjhhMWrU3RaGThO4RBKsV+Fk84V5beOH6Av+1LGVbmT2li4LUUNI4gFkuUOCG7N39+VAgEg/cmgwK2nXfW1Vryr3Z5LB7ys9EdVgj70vaW8n6TRSm9SOKLXkuRPPVwIw29ewtRmxywR2vPVm3uJJTZnyMgyG9s9YDGgTVsbqhfxutgg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66446008)(66476007)(7696005)(6506007)(76116006)(38100700002)(55016002)(508600001)(66946007)(64756008)(122000001)(33656002)(8936002)(52536014)(38070700005)(86362001)(6916009)(316002)(5660300002)(186003)(4744005)(8676002)(71200400001)(2940100002)(2906002)(9686003)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1ZmUFlXNlJkVFRRWFNHRGI1V1dmcHdHNTd6UDJCbzJmZDlqRnB2NXRyWENt?=
 =?utf-8?B?dyswdnQrcGR4cG1VZ3phZUZibFAwcjJYblAyUGJPKzJjNXRPbnQ3UEo0d0Jk?=
 =?utf-8?B?aThuMWM1bC9ESFJUZ1VnWndIVCtnbmRQQktsUWwvN3N5aGYvQm02c3VOSzQx?=
 =?utf-8?B?ZkV4ejkzSUhobytSTXZ1OGRPek14RkgwalpCWWxvQjdRakZvU2d3a0lURkVJ?=
 =?utf-8?B?enVFVTBQS3FRMWJCdzJLZWdicWFzSC9RTlh2OFRSNWk1ZllrV2Zoc3N4OVNW?=
 =?utf-8?B?eEpYUTE0a2VnWG13VFlBZ2NZc1h0enlodWNQME5tMEdUTFk4Q1hLYVdlOTV2?=
 =?utf-8?B?b0dnWkE1OVlrMmVzbW9wVE9zWWNpQ01LQnZubkhOeHQ3SlBpVUNDQjZYd0JU?=
 =?utf-8?B?Mk9mZUVqckM4UVhiWWtDSzdJL3BwTHorREx0eklyMmZaWmVIcEdWemNBV0ds?=
 =?utf-8?B?Um5uSmdlcFZla2RzeTY4ZzNKaW0ybmtUbXBNS1FXNmdFVFAyeE9OWTVxbTdQ?=
 =?utf-8?B?dVdjTmQ3RDAva2xNaldtd01uT2pnZWFHTTJ0bFR2eHRKUGNSUGJJK3RRb0Y4?=
 =?utf-8?B?WFpDYkNSWjdlL0cvdFNHM3Z6endBd0dhOGlMMUg0VG5MNHRURVZ5WTFSazRU?=
 =?utf-8?B?SWFwZU1SRWJOWko4TVdmbFoycGtQZzNjcUNTOXZDSGRTUWEyaHNDZjBINytR?=
 =?utf-8?B?akcxb3c1S00zb0Y3Y0FzRDA2b2Zma2h5blBnTFdmZjE2UCtXTW95SXhZTndI?=
 =?utf-8?B?c2RUWm12VUtFTExJZ0QwaGZUczBVUno2a29OdXhHcTBtLzhsNThWSnRuV0Zy?=
 =?utf-8?B?emJnK0pQd1hiVUd5K0VLVHNXekpnaUZOR094aW5lRm9wcFYwNWdJaU9NMWho?=
 =?utf-8?B?QXhiVXZtQytwdW93cyttZG1kY3k0bVExV0JVZXVZSVdMT2lkdUtzVjdUbjlU?=
 =?utf-8?B?aXV0Mlp6WHl5ZU02Z2dwOVI4S1hOVWMvaW9Fbm5KZ20wZlRTdFc2c2xyNWFI?=
 =?utf-8?B?L1h2eTNEU1Y5bzJqWUxPUVRFL3pmcDh1SklMS3lUS21NSGFiNTZzZHM1T0Zs?=
 =?utf-8?B?TWQ4MUMwRVFLcWpWVVdIMXZkTGVtZmdkUUxaK3M4OGJWL0FTbnNpVkdqNHM0?=
 =?utf-8?B?VVN2ejZjV052RUJiRnRuZEFaL3lSVldHTFlReWxicHFKM2ZwTEVpU1c1eDVJ?=
 =?utf-8?B?enVYVTQ4UUw5dTc1eTVvb3RDbm1TVm90MUdBNnZ4aU9WMnhCMDJLLzVJd2pJ?=
 =?utf-8?B?SlFUMGRvUG5kcjc4NWVncnQxVjVPR080UDE2b0N2RVpOYTdiUjlEWG10V0F5?=
 =?utf-8?B?NW1lejA2S0xFWVdTMEVFTkVxRjBBaXdQRW1sWFMwUVRncXpFNFhIa0ZVNUNM?=
 =?utf-8?B?SStSejVlUkh4UWQvZWdSbDBodG5waVlHT2c4T0h4NThsSnN4azY1aXZqalZU?=
 =?utf-8?B?dktWYnFaR0JxR1BqYS9rYWNDYWpWck9PWkZjR2R2TElzQ2REM2pjdFl5RkZV?=
 =?utf-8?B?blJkak5CNDJWa2RsaHNLblg2bHdEY0k2M1dwTkNQQ1ZiTXdEWEkxTlQwRWdW?=
 =?utf-8?B?ZVFSNElMTEI2UERBclhRUy83UzQwNVJCaXVLR2xYYU1vQ2pBMzRvWWdzSDhX?=
 =?utf-8?B?ZjVIWDJQRmZxRnc1RXptYnJQZ3pnWGZMNVBJekFaSkYxODlya0w3UEFHcmVv?=
 =?utf-8?B?L0MreEJld3FGWkdTb3RrcUUyNGYzc01ZRXFleklvNXRTQjRXcGJqN0JLMlF4?=
 =?utf-8?Q?TV6JfzIYeVaDHN1ekg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: my.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR10MB1546.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 445ddcf2-0b9a-45f7-b814-08d971d7d601
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 08:16:47.0690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6WQyqPdLBCtwkbMbw5qiCW6BIE1YfJGkoVFkJEWTS52hWlheH00rdio58oIMBX+/CMPwXYrgfjYdy6lfuuuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1003

SGksDQoNCkkgaGFkIGFuIG93biBhcHBsaWNhdGlvbiB0byBzZXR1cCB0aGUgV0lGSSBjbGllbnQg
YW5kIEFjY2VzcyBQb2ludCwgYW5kIHdvdWxkIGxpa2UgdG8gY2hlY2sgd2l0aCB5b3Ugd2hldGhl
ciBjb25ubWFuIGNhcGFibGUgdG8gbWFuYWdlIHRoaXMgSW50ZXJmYWNlIGJ5IHNldHRpbmcgdXAg
dGhpcyBpbnRlcmZhY2UgSVAgYWRkcmVzcyB3aXRoIERIQ1AgY2xpZW50LCBESENQIHNlcnZlciBm
b3IgQVAsIGFuZCBETlMgZm9yIHRoaXMgaW50ZXJmYWNlPw0KDQpGb3IgZWcsIG15IGFwcGxpY2F0
aW9uIHdpbGwgYnJpbmcgdXAgd2xhbjAgYW5kIHVhcDAgbmV0d29yayBpbnRlcmZhY2UgYW5kIHdv
dWxkIGxpa2UgdG8gdXNlIGNvbm5tYW4gdG8gY29uZmlndXJlIERIQ1Agc2VydmVyIGZvciB1YXAw
IGFuZCBzdGF0aWMgSVAgYWRkcmVzcyBmb3Igd2xhbjAuDQoNCkR1ZSB0byBzb21lIHJlcXVpcmVt
ZW50LCBpIHdvdWxkIG5lZWQgdG8gY29uZmlndXJlIDoNCjEuIFN0YXRpYyBJUA0KMi4gRHluYW1p
YyBJUCANCjMuIERIQ1Agc2VydmVyIHN0YXJ0IGFkZHJlc3MsIGVuZCBhZGRyZXNzLCBsZWFzZSBo
b3VyIGFuZCBnYXRld2F5DQo0LiBETlMNCg0KT3IgaXMgaXQgc3VpdGFibGUgdGhhdCB3ZSBkZXZl
bG9wIGEgbmV3IHBsdWdpbiB0byBvbmx5IG1hbmFnZSB0aGlzIG5ldHdvcmsgaW50ZXJmYWNlIGNv
bmZpZ3VyYXRpb24gd2hpY2ggbm90IHNldHVwIGJ5IHRoZSB3aWZpIG9yIGl3IHBsdWdpbiBpbiBj
b25ubWFuPyBPciB0aGlzIGlzIG5vdCByZWNvbW1lbmRlZD8gDQoNCkJlc3QgcmVnYXJkcywNCg0K
S2l0U2VuDQrigIsNCg==
