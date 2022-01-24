Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120040.outbound.protection.outlook.com [40.107.12.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C42173
	for <connman@lists.linux.dev>; Mon, 24 Jan 2022 08:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfQRjZ+SbrI6Ii43E5m+Szl+gXD/P9GGQ5X4HXwVaHmBEA+j+0YMzCOpQRH/m9dy65SGxzsZHiQerwu60IDnqb88fa8TFUt645uCocjSY2HbtnykeuarGN6pvc3XM2ljIXtPPRAGjeDhU1kNIuqAlz6itfH9qNkzyys9PkUcizwKn/SG16z1d92HXm3MherqPmHOGoDUZR+rfEiViljIDIRrVXng64IAyiqznzJUtrSJ8KM0hawjNeuTfjKto5SXusrEDhJqHTmvTywQpALXQSSODjI9sKo3aa2n9agUOtX/0szzmlSxGpxF9PoYbk1Cy6wH9Eim88GkEaOjyvyKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4OkBGevb6rgVpQGRZ+ZA4Vb05lp6x9ml1jMu9gIGCI=;
 b=aD0XBXFfs/M5UCimpXlm74US5D94Vi+9sdY8v3mqYUYVGjP2HR3DttFDYpir2JNQC3uXg/vsO/3sKbDokhSV76nvzz5k4WozX/zO5s+6H19lxlXrxnw4e1TVyehUWptRdEuRt56YHB42e+wUsSK4P60GEL0y+0/WB2nOZpzWxXYnhmqIK3eqCjjeYNdFwG3J8Js06kp79JR9oBEtk70MRX/5cUuZUAro1Rsat8KJbOQT/tQglOekqs3b/QU1HzuqS78m6VpJifZ2iIbU1QoLIpkpm+uRMpjBq+Qnl7S5y/nscwf2gEv6n98ievtWqTiZP94Sb9JCp3Q4ZmdfUTN4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4OkBGevb6rgVpQGRZ+ZA4Vb05lp6x9ml1jMu9gIGCI=;
 b=qR0twQj6Vg5s2q+KQnk2MXlM428doBiM3U5i8c4I6i3oFnIeud2pjGKK6NtpfoXy0I8xyO66rLx5qiUYnwWlN3wJ6SCXIS9wa9ZhDNHZ53n1Yey7WoU6aGfocGVJ1MKbSYKmIYj4aE7c3pdwTACuKfqLOniUvsiTkHp6UbiHLXQ=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB1934.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:193::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Mon, 24 Jan 2022 08:36:16 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:36:15 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH v3] service: Fix native connection with wrong passphrase
Thread-Topic: [PATCH v3] service: Fix native connection with wrong passphrase
Thread-Index:
 AQHYDrGkr9pHFVUWJ0GnIP17jv5Qa6xtRpVsgANU84CAAA2KfYAAKygAgAAB//KAAQRKgIAAAcUH
Date: Mon, 24 Jan 2022 08:36:15 +0000
Message-ID:
 <MRZP264MB154492A21713BA7EDFB28AAF935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220121102736.3323889-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB1544B85627F19D2599911150935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123132351.ppud4auaysfmcfx3@beryllium.lan>
 <MRZP264MB1544FAB6EF32AED6479EC82D935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123164646.fzmcfsav2tb7vpba@beryllium.lan>
 <MRZP264MB154442FC5C38510C1526952C935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220124082531.x5ldrhrypwg2nu3t@carbon.lan>
In-Reply-To: <20220124082531.x5ldrhrypwg2nu3t@carbon.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 28298974-c198-708a-94e7-017a04e9d5a0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5a01b9c-9c46-4948-879c-08d9df149611
x-ms-traffictypediagnostic: PR1P264MB1934:EE_
x-microsoft-antispam-prvs:
 <PR1P264MB1934FF2F2561E2EA23525A4A935E9@PR1P264MB1934.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KtYclbif5uJPuXYi404eypZ/S8QItNaaHOkK5+Du+j9Ozo3dBRgzBeADuKdA94BK79aoQoivN8MtKRaAlX3pM1OM90ZAN/YI+piTr1NuZ9Q1W6YvKfvoeIxlnCI2JyPGxhAWT0zfk5+WCgv6qRi/mRkIFWIioo/G9Hlgo5+BGIVUCpNE9p4cyASEF9Ng0EHql0D7DWbFeAVfjbDrNcgdtvD8lNqssM0mQBe/ABaFrSiurLUodYLYKiGlFO5rDlxStBNPA426W4gk9y4i0aG7wLQw+g9NfIZTgfKGelkESK/fgOKe/HhX5cLDlZ01zgE+znTXVKBfGKbP8rtOEJNhc9xHOoQDTtjLJtMbfCCBKaSM2t1qkYFxO5KiqEmHyogzcB+bF81D/quJiTei9zBZcIgm1Rwqsr3OtWYp0IrbSYCfSv+5/9tIzYZyMP+tcZ72cwVC34cNnDmhQyVasDRqbCWBTPMzHr2jUsaYCiQ9dmURb1e3RsC2HcvWNGBSyX07mLsO4a0jBjud6R7djueGiuYGnu8blDfjTX3y6hhA/USOOOTAafzwGrkJH0vkplmSxu43BwS3fxljMoc8IUYv3c6P2BlnaAhybb1+vNQnLRKluE3pcgA3EtA6/yOLHmcA180C8q1RRRJtgFhOMxCJccYACtb30Bcn0gtLJ0RfxILEHOWT162nGrEss6X2j4JKQa7anKiNqG5rLyny8o2JFg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6506007)(508600001)(186003)(26005)(122000001)(5660300002)(6916009)(2906002)(7696005)(9686003)(316002)(8676002)(66946007)(64756008)(66476007)(52536014)(66556008)(76116006)(558084003)(71200400001)(38100700002)(38070700005)(86362001)(8936002)(33656002)(66446008)(91956017)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ArETAkdZ/dd9uYihN8aGwVoMR4zSlibV0sVLBnAVbWkspD/BqMvyZLXhJl?=
 =?iso-8859-1?Q?ziI3xvtp9gl175Sq6295Wvy/SKngyE1/a4JphT/rSqLQyxXWG9wPwIbHvr?=
 =?iso-8859-1?Q?XQ7h0jfBl4IxTgf6r0DwPkD3SUL2D+s1ekxikw0CSRYfMr9ycpR+u23TYR?=
 =?iso-8859-1?Q?GTMzAMsXK7iSnzE6pKdCMJnalm7xrQ5bV7biMn/6KpaN/28oI2BNmFlntB?=
 =?iso-8859-1?Q?vM2W6fOAqufejQGTnPOpGx3IBd6e74hIoVExe9yGaNHGiEWtnAfNO5d07r?=
 =?iso-8859-1?Q?42p3KJ6FJ54TzrF9VuFXDgnrW2ZQ7kR8KKwY1tiQsKA1rrYsvO0EUzbpjh?=
 =?iso-8859-1?Q?5qp1kSihqMJWovsRYfBrdwnbD3hKBffwuMkJECCGmWVvtqWF0fBGQtCtfg?=
 =?iso-8859-1?Q?MK9V9cOsiNCcctKnL57D1nCA+i+XbuxGbK6z/e7jdNrHrqLXw7kPn7SSg3?=
 =?iso-8859-1?Q?7Uz0JSonIRvgEqstcBHMEZsUwxD6ZlFnG8wc1+SmfgFDjLcViFzKnFsers?=
 =?iso-8859-1?Q?4Dm6SaggxVObZoPhFz0yDTl4hDGzpNY1xY8fj8KISd91QHJrCvSm9ZuufL?=
 =?iso-8859-1?Q?/0YEm3s3XYFW9cCxLBUHejyq+Kt6jw1MHj3aaYoo8GzDo2DCK5CTC0cM1p?=
 =?iso-8859-1?Q?eO3QPkVB07dVLR5GfvalMju8hE2pay3NyBPY21FBVSzbpxz5Uc41yM6p/F?=
 =?iso-8859-1?Q?cb66raJqtRTCs0XcXZGQ716vtfcmrlJYcdyTZfMORd3jNfM2HQ2wGr+/dB?=
 =?iso-8859-1?Q?VNOWeyudrxLPF3MwXbMW644q6rubj9zLjQTZ/I4K0lSF0bqJHf7vw3uGZB?=
 =?iso-8859-1?Q?cksK/jv9pxTukifuq5KwKD4W2Dusp6W7mBGesSKHLn8PJEbRgeWL0Ao95A?=
 =?iso-8859-1?Q?A/Q9P7sPBIoDYrtAVt5nl/U5ayC78fAeqBuHUXLuVSdiehEzWm70OPJhHg?=
 =?iso-8859-1?Q?g0Og4PltjHVguA0wxRkrtgJ9pqe7AZg/BWT/SdXxQU/GOiI55PB+JVfJLt?=
 =?iso-8859-1?Q?r4eZPx1pi2V2Ew+XlO4ipNSM/TBmFs3+aYidwtj2b2GLoGyNQT0wyNxSWr?=
 =?iso-8859-1?Q?UB6PZSSbX9wVQ2a2y3eiJi6vj/HUCrNXrkgHwxpNQU6CVckFpHHDIxoLgi?=
 =?iso-8859-1?Q?YJNbxXZg/QqO6wsJZ3ulSSr7KNuWjxANny1Pl+aXCrGlF+CS4ES7dNXsPu?=
 =?iso-8859-1?Q?6aol7abjPMCKdMzNEixE90G/XROvazGqBtZ+Pwjd5u42KqD0YzjGGj17j2?=
 =?iso-8859-1?Q?4e58+sED3KLn8RNL7cY1T6rlI8UqpxjishB4hbVccpEHshtOvHpcasBzcE?=
 =?iso-8859-1?Q?bWJ1E+d6YfX3AhejvLrejYbj22DV9WH3CqiyFLpjJHMlwyto1gKYOLIBM6?=
 =?iso-8859-1?Q?cFLmSOLQbI87nc7J5bYHsSbuzmbtPZuagxG+8uzFaBGCHeZLZ0E88JKDT6?=
 =?iso-8859-1?Q?oyGkXe0QpFauyaN+oBxOWp95R55DjxKr79CAGdIxYbn655bHMUxv4ATnwO?=
 =?iso-8859-1?Q?+SvIr4MPwri4q6H0RF9rF0WTHvkMETrDs2yZ5xUTN+KOlapFd9f608AA6R?=
 =?iso-8859-1?Q?0imYg/2MvXfQ5PBPtmHyQEe0sz14xrUdOlnF4o+hkrruo3x7kJ/T6dKJN/?=
 =?iso-8859-1?Q?6JbEY70NooFRY8NO8d8dhOow7OP+TmTO+bf3AU+WiwZfqd0w1nT8jR0oK5?=
 =?iso-8859-1?Q?XKvqO1N5z7DVEux7YRKUFrPhZGmS9ksfBVAJmdkO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a01b9c-9c46-4948-879c-08d9df149611
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 08:36:15.8925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMuI/Cx16ScZ8IK4hmAKPSuw3z9iVyIdoU7SPfQExpWBbEJziANNZI1siXz2Y5nc/AtCZKWtd68WnI0x1Hs0QRIwZlDiuiDAENooKrzDOg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1934

> There are no fixed rules. But the usual thing is to stay consistent with=
=0A=
> the rest of the code. There are always variations between files but I=0A=
> try to keep it consistent at least within a file.=0A=
Alright Daniel, I will try to follow this.=0A=
=0A=
Emmanuel=
