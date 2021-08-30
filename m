Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120080.outbound.protection.outlook.com [40.107.12.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB613FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 07:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP+Wn61AE7q9jclg/F0zbOU/ct/53tzLvHSka1g5qg9FYeE6b+9crPCnYRwypSG4BoijXj3JJcBDAeN5OTG+jpDDii3W/PUDaFGnbtAd/iXBc96ty/v8E0HoN+1suPJ9dR/rmK+BknbIS27UVAeLsn5cu4wKon4TwgqOL28sDRJbeWW3zfVFCOf81xFGSva5IMf8nQf14q99fprP2vEzfCuCcFl8bLD3jyHX96nFBMd3ZyyJLcv8o6BlUacyY4JyPFDs/Ro30eZ4gL2Pqw1MGKd8KCtcylNoGHPh3W56WY/u3lRV8Z/NxN/XdvWFV+CCxW7odGEGcg3CXxdG6GBUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31U4inmFvK41W5uUZ9q6XaUUgJNYgzykjUwS51On5iM=;
 b=TahyKx9PlHl3LSLOINTJtVBo77hz1/vv/dEmf6GpAEgqtXS6BbK2YAvTR1hqzY+WT/QyMKxuAPsXe1jycqNf4FMInks9ujo2wJKYWk/EmavKrmibGXvpYjNRHF3/5TvJGaAMD/rge+7aeKJ1bKMCBI+Yp3NRlTYl9B9qqDLxe+c7PxdvfPP8lP87dYxsDYVIY5iICJCljSFz+A2UJ8Jlw59oCFTxVZB0xYDgf+E8WB4YARBR90gOaokye6GmlefNmylt2bnex3S/dxVavqZJcVRh99nfr9Swst9OoiJ6BdcvppYXvE0MHfkKPefZS8qJWlf+xJ3L8kpoK5SzkFLcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31U4inmFvK41W5uUZ9q6XaUUgJNYgzykjUwS51On5iM=;
 b=orvgH/MChQTQJJY37cXq3sPagJVDITqhaj0wkeZ859O0WAZg86KfLCOFNRxEX40BdHLv/FMmNX+zgZBIvkXos1soImaLsyqxMqTHgAOCneJo9oKGXqIzcOTMDD8o3bTH1SdhUupsaY0zf8CfZzTjhgJrKWfmkJJrFbms+4D1kmg=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR2P264MB0450.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20; Mon, 30 Aug 2021 07:38:57 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 07:38:57 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] wispr: Add online check url config options
Thread-Topic: [PATCH] wispr: Add online check url config options
Thread-Index: AQHXYeTK6zVrkCfjz0+UXmRbnjdQQKsVCMengG+QtO+ABrcRgIAAz3SS
Date: Mon, 30 Aug 2021 07:38:57 +0000
Message-ID:
 <MRZP264MB1544FFFBC8AF0C07F3C8D12193CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB479412B2989FCCF93E4AE58F93309@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <PR1PR02MB4794EE1A5F2F997AF8032BB893309@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <MRZP264MB1544E68164633E412919730493C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210829191503.pt5jkevne4gbzyrq@beryllium.lan>
In-Reply-To: <20210829191503.pt5jkevne4gbzyrq@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 669f0403-8e11-40e3-9fc4-08d96b8939e0
x-ms-traffictypediagnostic: MR2P264MB0450:
x-microsoft-antispam-prvs:
 <MR2P264MB04505985CC21DFE91542A92593CB9@MR2P264MB0450.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8W5lZmNC5AFegRbVQceZy/Tg+uvad9h5X9NUY92c+Ys6G1pgXrrfUX6aQzoTyKUxV0wJbKyCxXc0ldYACXlegIOOL/EcpZN3dVyQFMfva7sQpLsK15/JVmvHocn+/bkzYbViGKOzsqkoq9EDkiVUG3MkUGoLltONE9wTAJgQDlkcY7G7ofjf0NzMp6xqEZnhHjMtg3sO7lGbJ09Jk2fn+BD5fLDRooVwjKnf2n3C7aerW69M9Iqoe6BinpmToEgsyMKPET3NVSxtt2vUfALIwhqQLsYG9ppUfRU+L5yUPraAtosl61pMv7aDtV0OmEavaqb1fqmaurqqbZBluSpLuafuwjMY4CRDAEv4mz7hpcnI5z8PO0glKgieQC4/LxJwfH8A+jAfGMo4vd8woxuRQAGFFeRS5yf/Mg9pG70Hh7XXcPmJwKjOby9AKkowM7OuZlA5pokTbU6q2Zlh2D3MjnIDCBNquahkeGdWvPGMEZ+8rQxj5xV0SYnOOiGMaE5coq5WbxYOnHBSQtpWL5qC2ErqWIpSRI6UTFpJDd+2DS35MKnZA+VpbKRIrLjEzk/MQhkqGSmVxZxPHSekAdmU57uW7pryub4EigMb15yd3UW2qFvSZGw0AI4xN4Oou7acq2XM5gTlwzLwTRo9tl+P0dwjggSwb0oMBNWotT1YPEp7hQYfnLNAD/i3DBqBnWQLOayb50mlfEtxIUTaRvL0nQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(5660300002)(4326008)(8936002)(91956017)(6916009)(2906002)(558084003)(186003)(9686003)(122000001)(38100700002)(316002)(55016002)(33656002)(6506007)(86362001)(66446008)(64756008)(8676002)(7696005)(508600001)(52536014)(66556008)(76116006)(66476007)(71200400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rB3dkIlwznfMP4NkBToayDIL1JC6DeSXYl3imtRvVeW32vH414zqHUlHUu?=
 =?iso-8859-1?Q?b/5zPP+z318wUU4q23sfdnS1I4poe/HAh/OvqoXgIkjNZ8wmWNF1dGscGp?=
 =?iso-8859-1?Q?M8doLcN+cR9OkRVQTts+p+hwxTj+xRSYQYmfP2EaM0T9weOQJSETDTvXQo?=
 =?iso-8859-1?Q?kXRVBjKCy5CpP+UumYZQ9SFUuaVZDPOFFFyAPfAO28S3u1sUUCzW0IlGRg?=
 =?iso-8859-1?Q?+u32NQ3a8+1Z+T85Z1v+dNl8TQE89g5+v4xE8UN/oE18PB6aoUiR2e1j9Q?=
 =?iso-8859-1?Q?K0G3v/lQrhhG5PId0wqMHJSqex/4oXHQIPyIuVvQ4FyCrkjIvQhvGakR2U?=
 =?iso-8859-1?Q?A67J5ALbQyKixf/T0VPCb2t7m0k1FJFY2dHxuJJnJsA0A+GPaaL5Qgjuay?=
 =?iso-8859-1?Q?aT6KxQqk3PoyB8qQNquIrbBqC5Zmt8EAFjv+vxgHuBfHdCb1NM4GX4ovCv?=
 =?iso-8859-1?Q?FjatGc7uGnw5iuJyNhzR6j7W10r/2HbIMadaE4m42+/ussw3AFucKBV+u4?=
 =?iso-8859-1?Q?+fFuIpsJyN6QjZKQsmzCfMLM/Yg7fMNSGRjSdSHhfaEidjugCFnAO/WpKL?=
 =?iso-8859-1?Q?BKRG73IUIIahbyvWMuhRSpsqkSiGRRqudcK7ODxBFBurp3wTx+b0r03gwG?=
 =?iso-8859-1?Q?oLhALDrAF0tjFkrvpfe6c944GZF8nUvg9yvVOKzZ0bGlSNuMctpentrzk3?=
 =?iso-8859-1?Q?z+JAlYU8FmdE8WBWiLCfyH9GYG0rzXUbZ9kiXZQsSxTo7eykX7igb4Q8qC?=
 =?iso-8859-1?Q?8DBwWrsyK0WZTUV5XRdmCjQWHH/E+Sm+vPY5F8jiDJpAbJosqnnxoScq6S?=
 =?iso-8859-1?Q?sqx7M2trm4xcqDVdM68zdhh5fOKDYl/20SkXaQ3jcCMOmsEQWxH2Wbr/e/?=
 =?iso-8859-1?Q?+QjfpliDMr/KGRsEaIi78fHUGx1/cYa7IHa63ECK6/kij5L1m2xkFjH8RJ?=
 =?iso-8859-1?Q?F3JL5E4wYb7NQz/JEDqt+8etKx267QppLzSP6oU8W2x+dqawuQjQOQnioz?=
 =?iso-8859-1?Q?6OGHTVEoWotQdBqcgn9XeTLRrZVghDK/IZrP82dhlNaJyYgEz8eyDtzpWD?=
 =?iso-8859-1?Q?he746ox6qcD4vMkbck05bn8nkWHT2KY29Fshxu3BMe3cbXrCK1SGrLrcwa?=
 =?iso-8859-1?Q?KVrWhxTvpZgv5tcFY4uzYkX+jED2MMl5P6sN02xzOcKYJHOWVBKe5J+i1T?=
 =?iso-8859-1?Q?gIn83AJN5avkrK2c+6SFbcAmBm/1H7J4MIVMRfoZRCwMU1wQGLhYdAjHM1?=
 =?iso-8859-1?Q?fxdfVXRYj91mqgo3U4bpaeJPVJPhGiJUX4iihJQ948CVJQYvhGXyxRg88C?=
 =?iso-8859-1?Q?le046tBm/6oqMyLKDj5mXzrF4kY57mpbDaxtAW5SQrK11VPINjyP2Irx/o?=
 =?iso-8859-1?Q?y2w4hTSfIxkL1G4gLIYGIHwOucFwZ0RkHLnCuk2tMjcn0Qmvm0KcI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 669f0403-8e11-40e3-9fc4-08d96b8939e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 07:38:57.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7s9rFn3wDSJG1W5dBJ1wROBer2+YuUGcnkGePp/HnHHu8idFf4O+xDoDPYUkm0Vg3Xs2uMMk1p9VNBiK+MnPX0NKPBFxpLGB9hdnQZGEh40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR2P264MB0450

> Patch applied.=0A=
Great news, thank you Daniel.=0A=
=0A=
Emmanuel=0A=
