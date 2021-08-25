Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120074.outbound.protection.outlook.com [40.107.12.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595EB3FC0
	for <connman@lists.linux.dev>; Wed, 25 Aug 2021 12:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azm5MT8yWn47t9mKm8xLFLDSE92e81MZHSWEB0zRVXCe0I+h7F2KTHVxRHBJk6wgjPPiFd1FMqmJnLRFSysogGa9jLHkPiH8k9zkJnVuvWF4+6hLeT40KRJXtFdvaoy2BVFJOvplqzS9o68/DsHnHkifSl1g4DeYFnOmhchIwg4qb9kn0djFPb7NqB7kpBDzf27oLVwXUPWY6araJK7rUpWq57nBqGrEI380+Zeml1eATZyoPc8Kt+WSNw9Gydflho1DA790sft+BYQv0URnAnNis/9AMSZRXpXrsiQa3lKvBe1jsh6eXUtUouTW2+5T/8E+Sba/53owGQZvBVsIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtvR+SlXsbmBh53B7ADsm3eEsEiejHOJxy+IcKMsN/U=;
 b=gPIxNhFGaYGkDqg0Dwi9nIKVofn6n09s1rpoucxeIie8G/g+GQVtq+Q7M8qaL4YqhALhQzCHC8hQLea63JHaqPzuQ4DxsX9RmZtHodBqoBdVtDnWR7Z29RcB6mUIRVONIenv18WRepjlvcqsAzLHXXploo7JfAVzHtS7GkylOgTlsvsz2XUKsijFIetmyGkvEVQ+r3/Jqlf2P1uyQJOCU4nk06NqZfy15b7ZItPuZ8AJNaHka0u9KodFXNw0Lpa96cQRdSg+0gub5GjcuBGhWUXIifQmZsK3WeSM3uFi5+BN91yRNg2z/DctsLZh3ZD7lhrQDCSlfGqWMgwpekK8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtvR+SlXsbmBh53B7ADsm3eEsEiejHOJxy+IcKMsN/U=;
 b=HIMlEmq9BkBpYG0VULLxM+89r8ANmP/zeYWt8IY6InvOMCjqPBsSbwNIsn+VAtH8RqFJeY0PeyRt1KJe8ZmVCRo8FQlh9NvFn/1ei4M9dHBOAzll/odZCmCTYmU4TEM2Edbtpx7T79cP2n0dSP+gV55Stwha0wz8sqqMYLMcaE8=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2103.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Wed, 25 Aug 2021 12:27:51 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d7f:ca70:4ec:896b]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d7f:ca70:4ec:896b%6]) with mapi id 15.20.4436.026; Wed, 25 Aug 2021
 12:27:50 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Prevent auto connection during passphrase
 request
Thread-Topic: [PATCH] service: Prevent auto connection during passphrase
 request
Thread-Index: AQHXYP0z1UDC2PJp8EiESz+rAkM0L6uElHlF
Date: Wed, 25 Aug 2021 12:27:50 +0000
Message-ID:
 <MRZP264MB15442670841BF0B75B350B2A93C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB47941F36176A2E8723EB139193319@PR1PR02MB4794.eurprd02.prod.outlook.com>
In-Reply-To:
 <PR1PR02MB47941F36176A2E8723EB139193319@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97e7409c-c1ae-48d9-4897-08d967c3c15a
x-ms-traffictypediagnostic: MRZP264MB2103:
x-microsoft-antispam-prvs:
 <MRZP264MB2103BFAAAF77CF779072C20793C69@MRZP264MB2103.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 27qy/W4m6DzWHU7ehYjRkl9SdWC0pQMawoFYENJYfrjiLmHQ1Wcfkh7J7aAu9RDR/h5ijtu+HWUnUFOqh4VzccXiU0YRpyuPyJxI1GCAZQcI9PQMXkC4p3dqvWTgIwxozNrOJ4fLT2u70eTOf43FnAm9bTiV86lGfo9E+GLCSEaSwc6UXpG67krGi60IifiifW1RwIUlstA1Uv0Ukl9o3tTGyMKbmoVdoYhidSHIjow8loWvd6s0DYC4NxcqZC+zX9tp1L3/KrIvSKZIybgfmxAOh5r2BDkDJilLHiTwHwmo95dn658UTPkXI+1VNxS7lA/oXe3BpRx7Ywzv19L1GmdPVP7wv3Z0j29fSzv3GZOPX45lcjMem9UJdW/yCi0jE7Rqq1Mfi2JZQ7O8DcvOrzT26ZzDwjesxKQD2pFKoQAefkK/B2c5QPYa6ornKwA4xEmyY0EbjJXLp27ag8Mme3o96Bq9h98P5l53A6BGtJ0o3BwvBLgz0Lgv+U3Q/ckriRKPxOdOiBxWyrR8MeV7LMofjPvPbiG5V3e61kEnbh0jxyDKDDMcekCa7QUy0WApdiFPvsgKIr//58Jtqsy3oEoT7NgZK2YdEP7FHJyK0rvyHO++zvjtfh1D+89tfMoD2uja2/DXDZ+mzLM3T1a3nkSRQfJLg/bOw4+W18uBwcPPh8r0VRT7w+/8ZTzAxD2+Fh+OBy1OqTkbQENHd829dA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(5660300002)(55016002)(7696005)(9686003)(52536014)(86362001)(6916009)(6506007)(66946007)(64756008)(122000001)(2906002)(66476007)(558084003)(38100700002)(66556008)(76116006)(316002)(66446008)(71200400001)(38070700005)(26005)(186003)(478600001)(91956017)(33656002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bFkUgjpzIkHYkix0abNKrU9HPxFXZXIYiKbdmfhAYVxv9qvzPLf6GNa6zL?=
 =?iso-8859-1?Q?lTikZElFg1q8ERVwJeouS7Ljjp+F8Yuoto07+n2hUpxwoKoco7j9StXBAp?=
 =?iso-8859-1?Q?9w23rLFNNRRZfR5qVjP46Gi5OvB+gwl/X1t6z3o2DUXQ6CLKo+bvfhWvtO?=
 =?iso-8859-1?Q?ye2dcyznqCEAlGmPOhxk8DAQDfXiXPbfcMVrSAnSleigXReVHei1iRLBBI?=
 =?iso-8859-1?Q?pQ6DlVXIXcVFH1rPspspY4AdP+MppY31lWfZ6eiXHy7U0AXi3aw9gxOGmj?=
 =?iso-8859-1?Q?HBMAO+6NHLaFrT2e7+qJGtRfuX288GLcG/BV5uLASUvCdu36adT2ncldGf?=
 =?iso-8859-1?Q?2LVpU4XC9cxP7IYhCotT88nnV/7np3YQcT7ONoaVOtBw9x3Ti/IiZZVSsA?=
 =?iso-8859-1?Q?yiKoJxtfDb2j8ao1CJAHXws8tKgyki42rkbrQ4IXiWcCYXjIc0y3djRK74?=
 =?iso-8859-1?Q?kAuk7LwkcPhJeHsvR1c9msU8KIgBTxEzCPQG4hQIearMJqIaKlOJTQIwrb?=
 =?iso-8859-1?Q?7ZPO/D7Za8e/mywKzy/KW96NTLaxB5WAW28bHbvUvgia7CVUA6GEeXoIXa?=
 =?iso-8859-1?Q?HUV9T4t6U2G3+9gM1svwwD91rMWeBT/hCh9QqKQwqarMWagP+sJL2xF4aK?=
 =?iso-8859-1?Q?LdAW53gkFmuu+TAd2uGFf95UUGTSipTdS/uvhxbgjs69NqWbcZ4upzyvFm?=
 =?iso-8859-1?Q?fsDh/lWFLODcYtEhvO36odVLieScIAx4CXx8D9LO7VZbot7QuHT+Eitosw?=
 =?iso-8859-1?Q?KZjIVMDeIkHkK2wl9XLEwwyEhfES5FsOtoacYsHreFLWj96Sv9O/hlTcZ3?=
 =?iso-8859-1?Q?ljBX74PIsnbbV2jNZ9v5nwIF4iT+LP1QPGg1Dl6KJXTqqb4CS8K/jM3Wg/?=
 =?iso-8859-1?Q?HH2dR4SE3yz7woN3L8+zQ/CosBN6CjUJc91FHqQua97ssBJMPe8Hz2YSNi?=
 =?iso-8859-1?Q?EljO35+zXiZlrhPgy2eJyUpS8Uu4EKtNg9kVhN3SEKbQxNfi7Tx7jyt7No?=
 =?iso-8859-1?Q?f61jrtTG34b6pHUrhjtPzBNDbbbAalaoHCKtBeI+ppwjGGNXJEj4UvxBRO?=
 =?iso-8859-1?Q?+RkS8RyLyHXwBCp5JcMR+bSHzaX1UBI66RFtVrtChuwgUDxpffPb7gcUZe?=
 =?iso-8859-1?Q?+UCZZh3YtZPbYYtjy5DrbkFNBhyeAQRrfHyNiVZMUzZgUF+zeSQ+hLQiAY?=
 =?iso-8859-1?Q?dzJjCbq9Ky96pg+NiwF3sKfQ/3llY+PTT92WAHKr3seuW/j8ZxyGM/+H20?=
 =?iso-8859-1?Q?F4N589Zq6ZJOWtA7m7Ok1joQUDOlNFYiJKISSQGRZ3HdySakCMM+AjnATZ?=
 =?iso-8859-1?Q?eihbdJ2rg9DtNpum05Pnjl2L4FbuueRpxXPIfLgS1sa3fe0=3D?=
x-ms-exchange-transport-forked: True
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e7409c-c1ae-48d9-4897-08d967c3c15a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 12:27:50.7688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WW9nyK3rLjr1rQbtKtLrcK/g/9NrHw8OqpKk9Lg4xV4h5MrliWRo+eVTXzxlptWJ8KlQibZwijuRgcEJ7EKbHmbd4haUcO72twYrOqFJFPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2103

Hi,=0A=
=0A=
Was there any progress on this subject? Does it still require some clarific=
ation?=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
