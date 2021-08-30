Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90073.outbound.protection.outlook.com [40.107.9.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD20E3FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 07:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHmOxs8i8x+JirNKtPcFac/h34IkyeoXe7Z5VROqZfLnUQJ1bTxd7JMo9va3WAGf2qaoh9kkGlG4O7FyWAiErBq8Yz1exhWPmrBjGJA1MhbGMG9KysfveI6JXEzGgNSGjQU3KBD16jk2KFiMJEYRE+v1kOvZog8pxAK4fNlTKxOAc2iHYRVIJxLJnDJtKUxNdGsOr4lZcuQWubW+X37E8RYrG3kFqAwXB3zRNj1Pg7wmWyO6cQqEhA0PJmq2yf7o5d3sRgMRbMWf14o0jy10LUbUR+8H9p5hl1gUg8gw3UMEp79OXTvkIA3YQoFLhRS5a50Ouf9XIFa9CznAXqasUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcqtVne+CeRk9SP/hIKQrUf/HlIJWYHbNyxPfSxnyx0=;
 b=kPO7fWTLxGQu8TTasNscMVoTwq3EAVQoB8jciaWI7RFqAvZLvxM4R5B09mlDUwCt0tEE1O8JRpuAaK3amXLEV3TPZmmIMRcmddD0oLFA9KZ9jClW0vmRHwsaWUDdzeGuUrlWhueF+sYjrQ3fbmckQZPXPqgcb3UQSjuwg4qQROaWGka7bD5OIpZpH8lkCzou0X4GrgTGQ/Py0DZJrQFx+DXCjJF4oc1dFWaYo+vf7inUD2T7JJfobqDIlEJtvrQDKLZsc43AkQwMkZdzV82r+WAH8pSkMd5XMlcYVRS5QAiz8i68QkkWAv1/FcnFxfnZV99pYpQM/kO2rxzyuhSmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcqtVne+CeRk9SP/hIKQrUf/HlIJWYHbNyxPfSxnyx0=;
 b=05VbeKwSIYNX1+qvKhE12HmP2ZgXPlNWglD/rWOCsW+n/MpcLL322ajrRXnba8YAQp4hOYSgZA5SqnZmTSfNZ+iAyvnP9xgtXZc5fcq+b//CRxw9KddiJYBlZn/WeCpFudk6cZlpqwBkB/JmoK7d9nbj7wgOQLwLPj2ryUcPnGk=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2772.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:39::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Mon, 30 Aug 2021 07:31:13 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 07:31:13 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix default service update on ready state
Thread-Topic: [PATCH] service: Fix default service update on ready state
Thread-Index:
 AQHXaCl3q3yULm0o6kitbLJsUjipmqsiz8KAgAAOuVeADHiAgIAAA+gAgACAkXiAVLNsA4AGsvCAgADOzrc=
Date: Mon, 30 Aug 2021 07:31:12 +0000
Message-ID:
 <MRZP264MB1544ED7B886A21B5AA73393693CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210624080757.722whwmmwrnzffvb@beryllium.lan>
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>
 <20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
 <MRZP264MB154494B92E616DB754E5F46A931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB15440F82FD624796E8AB394393C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210829190711.3fcho47whyclr2id@beryllium.lan>
In-Reply-To: <20210829190711.3fcho47whyclr2id@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b723e98c-2f7b-4937-3f08-08d96b882502
x-ms-traffictypediagnostic: MR1P264MB2772:
x-microsoft-antispam-prvs:
 <MR1P264MB2772547EABF24DB06BDA8A3593CB9@MR1P264MB2772.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Gt0iN7uNYm9mpr3X/KQ31FrRHN6acKRMD/X5CS1PBaRuvThfB7wo7N0wX51MqxDVfWOorpKeI1GAJWL/rifqct6UEtGGQ7DooJpI01BzsTjHe9rC35HVawD5ow3KeSgu/4PGOBLrZp401fA1JQJVr9ForZNo+24uU9qE0/0BcKnaC1DycCdJGq17k4+FGdqL+WQic9Sy1R35KTZNxVuaC/PDfVGlIQY48vgn+V1WOt+yTZWYpX7sp6XuzHmAwIYJhv7txbxjh+MD0/+KY+1DdDOZU28tBl+wTv8VNwdhqdWnouQYCRy4hQp70d+2+qNCnu5bcK5Vnm7D7HcXC1Dy9bxBysxmZ/vHqzfOtxE6TqQtV5VlbbgbC+hYhbAPIndol6yc/UrSgsEll0xUea0ZfSAa0E07oe6y4yEPPAaE6Za0RcWDpTQ/Bl1aMLP9zEWboy8RLoqSa1i7/wj1bISvw38PlA1fPsoLEZcwyFUcXQPT7tHSadR2ZJObueSwRbm2JEd5oNRTERijo9OAV66Ov7ntoP1+6UrW2o0E68Y/z8hNbw2XhIiskfAQLRIIfELBD6Ze7WbxBAy8+IAO3WpXzllF6Y5yPHFzdk6/ak/7ic68N4QIrqG4n3tHvzYvW2TAcg28MdJrTRX1F7YHNXFAxjQAjZUoiFXUDLBOn0eVs/G7aMyi0YTocqa7RefVRP58VoM9g/b8AQ10936B6LRO9A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(9686003)(478600001)(2906002)(71200400001)(55016002)(7696005)(6506007)(186003)(5660300002)(33656002)(52536014)(86362001)(91956017)(76116006)(38100700002)(4326008)(15650500001)(66556008)(64756008)(66476007)(6916009)(38070700005)(66446008)(8676002)(8936002)(316002)(4744005)(83380400001)(122000001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6KWbyKSLcO+CeKo3RjtWDjSwrgStsCTa2M3OXn9XcqCWBW1XmeASPbjPnV?=
 =?iso-8859-1?Q?GnjCBQjJFnfWumZLOq6+fNId3uw4pQzwmzLx7/AIq5K1izGjLFxRpdl1yk?=
 =?iso-8859-1?Q?DUFiWsNX+MEUlSHWvBHbDS4zxfvuWTayiCVVRL437DGkw1JDv7uev3/iDs?=
 =?iso-8859-1?Q?lmVbR/sQ1FBW+p931pjRBZcSCq102Vsogg9ezaSsf+mkdHzsdMXYiRp9X6?=
 =?iso-8859-1?Q?N4cxtr9WlGvnChUK+BpxmuqqLNllF2ZoePDKxohaBabjB4oSXtqWqNXTY6?=
 =?iso-8859-1?Q?J6quQCJVRioH9i7+tdLh1INrdHsAWqVqy2sMtQ0QmxWH5hSu+rSxTkutbI?=
 =?iso-8859-1?Q?g9fGF1MXOehipBuZRhfzBnRLuQqJNtHIRa07sFs17ii3IClOUPdxmuvaOm?=
 =?iso-8859-1?Q?TzeFy4hV6O2k4elFn1FLd2DMrqLtuiFJLCc/UGpaLTw79fRlJtSPCMKE0G?=
 =?iso-8859-1?Q?iZTWT4qeUrXnTZLS9t2LfBJbSy0tFnemr+/SiIdHAxtv7VElbY54mFyyYZ?=
 =?iso-8859-1?Q?JDmwavgJOlsNBDSEzjMfZVMy8NNEDwHKabMZ/o1dhPBe11gmGawboGAfTA?=
 =?iso-8859-1?Q?db37TumQNMjXVsh0igwsTK70+LfBOX5120+yPK1cQAGp5ccpauVp2a1Tmu?=
 =?iso-8859-1?Q?N7WZPSAdd/0nWKUm47GEc8r4rwMC4yuBPVl1+x3Vg4zKlDF6lqtopOJRKx?=
 =?iso-8859-1?Q?XxWDl1nJjjcyfbKgC0cXfsPgDVyG85+HXUcdklb8zkZ5fCHH2ty7N0YbK4?=
 =?iso-8859-1?Q?gIp/7D738LJMFYYLiOA+AG/aD2J7960EOQ9Y/yy0DNjr8SWB/1vhLhFfEa?=
 =?iso-8859-1?Q?b7iVTmAtBMPWLc04tjr7L1e/V13MXx+HhdduFckpYoaSr4W1jacm5fcAVM?=
 =?iso-8859-1?Q?hwhm33QGTpWqs01SgAMoUABD/x/ce96VubDDOAPmaFWb5mVXX0pD5GSwGi?=
 =?iso-8859-1?Q?hs5k3QUWxgRahpNIOOG5rS9fRTiaqGnNYYcx2D9wG8sQu/ANCzZlqWkAaI?=
 =?iso-8859-1?Q?tS4zMBD0dADDutuhdZELKVWl25Lab9ykXXnuH5Ua2i64YVYjEgCN7cxY65?=
 =?iso-8859-1?Q?v2bxwSoG1RznN9nDCmKDp2CNaDOjPsln5m5ck+8yfFi25yQqnXzRBk3t4s?=
 =?iso-8859-1?Q?EbunoT8O+lKYp5WCH+fk6Xfs4xXWs2Y2I+V9Upih3SIQeQfjlYQmg4CS5y?=
 =?iso-8859-1?Q?QI+MOKcSdLCNVZgsdSYwULMg80ATxvvSHbyGY/TwMziLul4f/31A1mD/GJ?=
 =?iso-8859-1?Q?vQ2Y4kOwYUrqNudTx76nT4Y2VHwvQkxmrOnZwkszspVoAqFfKzEQG/DxIh?=
 =?iso-8859-1?Q?q6MRpRtmY4M9iGvZC4Px3f9+7Rk19aaLocNH2yi1soNkXcdwa/D86svsnk?=
 =?iso-8859-1?Q?0wzLOUpK3oQoI7jSYb+L+ipQDoQlTkPGRi0BQQ7Fzvle/yE+X3alA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b723e98c-2f7b-4937-3f08-08d96b882502
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 07:31:12.8830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YL/ZrmdbvyLMZDJSgFf0mwXoSTKN7CiLWwiNX+5D3qJ1JQxbvGqwX+oJDH7TNenBwae80GU/29FHz1b2z4XJugQnKpWdHQ+7oyWHMNoHJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2772

> Right, after being absent for a while (sorry) and rereading my argument=
=0A=
> in my last email I checked the code base again more closely. And I see=0A=
> where my thinko is. We have to sort against the old default for the=0A=
> preferred settings. Because we don't know yet the order according the=0A=
> user's preference. After we have done that we update the default route.=
=0A=
> Very tricky stuff.=0A=
=0A=
> Thanks for your patience.=0A=
> Daniel=0A=
=0A=
Great news Daniel, that we could finally converge, thank you for your time.=
=0A=
=0A=
Emmanuel=
