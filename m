Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20046.outbound.protection.outlook.com [40.107.2.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141CF70
	for <connman@lists.linux.dev>; Mon, 21 Jun 2021 08:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUqkqr6MrNx5APLahsF5RJNPl1Dwmt6pq6Z/x62RZuN93qgGnLRDNTnpuclP6co5BCop0Lnq8zuTrj/MH6mF8dGiaHfrXKzFxBSi+F+5ydpFenge0aVJ3Rzik5/29cY4pHhDlwHDhwjVqYDIxbqLg6IQ6V0uK0YMHpvXMopEVk6qA7h+ZsDWZAgcP47JPJzOrfvhtTxDv3V7TQayFSAyCw99Fh7uMNkT4X4GroN3HN3HgrrAQ+sRdn+i4WhhDf0gea5Q7U08M8AGFE3xjegvCU+VwbuWvLueYGhoCuO4AHMb0jqsZc28tuXVjLJt7L7AWFBXoca4awfpocV3s9EKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQlmIBKRZ55RC+1o8q8C7GoM9d3xkWYu5aueFTmxdQk=;
 b=G9yaY+mvwz30aUoR62vMg1G3s7Nu0PI7Jq71+RbvQUeovh5wtkk4zvzTJZYNucvknz7hqaB6hoAF5dJUwXXr4UGwgiazQMFr6N+2fK3Y4GK6ypkR4p84ZxbsRLn6CH3Mi1fRLgiVCzKDaNR5wE497G0lhNcaTIO7CltaFnDxFvmwUkzPS508RBRQZ1Z/i6o3XnSWow1vSYHKEd4yFPHL7u/iZpi23I3vOmdUgrigYEzQ31+/a7uJERX7jASlWRo916ZXAX4gQxc9gCt15hQcG3FJft0Mm4PV0Y2Js80IFHp++dtxdCAkjEv9fHpOuqtV3I8t7ZVTcDiNE2wKRXR6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQlmIBKRZ55RC+1o8q8C7GoM9d3xkWYu5aueFTmxdQk=;
 b=u6rPMcV6eEirF+HNnesJgnxGdgu3fYx5HVJDGzVgRNwhs8HQTiJtF99XrCX7i+g8H0tcr8Cft6derxjqXfVWNKb9CcY0OPuU+2ywBC6F3pmKFP4mzCWFrmXWP1sgdcFPmcoiUhTbuyqErcs5ytxS0Qqx8BZsEy/cMbdGaCuoLPo=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PR3PR02MB6169.eurprd02.prod.outlook.com (2603:10a6:102:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 08:35:15 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608%4]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 08:35:15 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: Jussi Laakkonen <jussi.laakkonen@jolla.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix preferred service reordering on ready state
Thread-Topic: [PATCH] service: Fix preferred service reordering on ready state
Thread-Index:
 AQHXYP7y9dYDEFzAnkCTZSq5lr1DgKsTTl6AgAAZu36ABIYwAIAACV/egAYk1gCAAAycJA==
Date: Mon, 21 Jun 2021 08:35:15 +0000
Message-ID:
 <PR1PR02MB479431044E915D119B5A6BEF930A9@PR1PR02MB4794.eurprd02.prod.outlook.com>
References:
 <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <3213af74-2985-ada6-09d4-67d5ccf1f72f@jolla.com>
 <PR1PR02MB4794AE9D35473E527750BE1F93319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <ac94b39a-f446-0e0c-9f1c-5102aec815ba@jolla.com>
 <PR1PR02MB47943483C93F21149F412B96930E9@PR1PR02MB4794.eurprd02.prod.outlook.com>,<20210621073000.uz23zb7bv2qmchrh@beryllium.lan>
In-Reply-To: <20210621073000.uz23zb7bv2qmchrh@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92daa336-a4e0-45da-0a05-08d9348f7e50
x-ms-traffictypediagnostic: PR3PR02MB6169:
x-microsoft-antispam-prvs:
 <PR3PR02MB61692F3058321099D5553615930A9@PR3PR02MB6169.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rOJPd6+NLgGnsa38kk44yCO/hfxw8aHlLgLXjb7P+g+tviyIl57xSnmoofL+8YqIvUmF9sdThd+mlKnxph6V9dCuOVhHYUW5HspabyFPM6H1F5mjYwneb46H1oa0w7vXzFieA189/21HgcvxPm7pOxJzQcGZCcD2PaLTxUYFzz8+L2Xjhc5o+AcNtnscidxlyrp9ogodz9rdh44IvD44rC7N7RvEmjAFTf43kG5gcBBkeCNz1Ov4+8ZsqUVYtRBk3cuFEAO6XoGJdoe1WIEjZV2/RC9ESf9QEmCOIQiJ407rtLRK022GYax/WoL2FqSDWWrW2IURX96bbTTzLjs3eCW1Yp5YY9MYMTFRgIRJfMSNNdijSQ4qej9Cel+6KBjHFiqqeV6E2LVPWCXwieESFhWxlImxAis3c8GIxoykBsV2q6X+7ShwOAbltpaD1aGS612MScwpirALcpyhx9U2IXAyfmKjGSTuIEL2jbIavFEYQCX82IwcJk2cVYAZjXw96yaMsSY4jLiZ/qhep1+IGqqxCqvcvNGcCYBCcTtvjV/YmvzNkHde2UajFiIBsCFGDwRb5+x3PGADTSrAwVOwi3oZWvb6DLkEMVSFvplNdc/cl1XbY8548J0mH2OyPAvsl+TLlrr+nkswfJM16KQ49fMf2InhCmlOI5IzxWlFmXlkqiYnFc4chcyt+2At8kuqjtcLyB5qkV+dHoc8vmxMk0WX8TJYDxooqxAwp6Lyznc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(7696005)(5660300002)(966005)(122000001)(52536014)(83380400001)(8676002)(86362001)(8936002)(66446008)(186003)(38100700002)(6916009)(71200400001)(66476007)(66556008)(478600001)(64756008)(66946007)(316002)(33656002)(2906002)(6506007)(55016002)(9686003)(76116006)(4326008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EwXq+Btpji08ESYfc0n7g75QVOX/ZiKZ2JMGLxyCeRCSydAv7m0sm92ez+?=
 =?iso-8859-1?Q?X/IG9gve4R6kj89F7NZyHsGe60ENs7qde6Is9eEBYI9vUw+qE05X695rL5?=
 =?iso-8859-1?Q?QG/p8LEDwufW1j1MvpXDX6F/ITt7pwAQrdGP4Qn+PSCy93zL8hfYfJL7NW?=
 =?iso-8859-1?Q?pAJNZr7kI0ZpHlxd6R6S8k0vFSNs636NALoB17C8R1MXePFcVbJACiroeD?=
 =?iso-8859-1?Q?/tEjKEwOdz8gItrjZNuErCpLgIfq77Sx5IJ/UhspmvDfBYQ3N3cCJ+uZnm?=
 =?iso-8859-1?Q?3kc0QkUTldZN/oeggbRx7xkjS1OaarMfwofe2s2s+DUsVvQEyx2bs+2gMi?=
 =?iso-8859-1?Q?EccGrRa3u/3mzON+IhQJKEQs1GbpbDOeShfxg1zoCTZzLlOs7ZTRDZob8i?=
 =?iso-8859-1?Q?WUZ6TsX99aQHcjpqcwErstkXFTlkpLEN+hmVhIpWyKOsnI8uszXVEElhxd?=
 =?iso-8859-1?Q?NfudJy885tERDiqVQUZF029nyKG2Vmovk0guDWOqh6MHCTbWQ+TxataWno?=
 =?iso-8859-1?Q?tto1jvvUpO/y70Qyyfoe29Ulrxk8Q/0g6lSwmZyWt6gnQ+k9N9QgnVQeF6?=
 =?iso-8859-1?Q?esEGOI6azfe6EWu9Dww/j+W8Kqc09egz1ETGMbwmAE7ZxCcdEhBjNMEmYD?=
 =?iso-8859-1?Q?l/IFpQaG/zYfScWgBaJLyMFaCqTq1kZ7As59UCoqU2oUltLmBWC1LzS6Xr?=
 =?iso-8859-1?Q?CDWTxnC3r+DFfgPo46mtFweBnexNGVAYrWIZyoiFW3Sn/khyf/7wCwjRmr?=
 =?iso-8859-1?Q?d88zdIAinnP26q2dgRYBD+PTniDKeC9InIN3k2JOcKPmf6xUng+JjfRjdb?=
 =?iso-8859-1?Q?X6W3KlXbFLZDU7xscFqGY/j3qp5WqrWJQaQ09AVpZiR0QQamDOgvebAOtq?=
 =?iso-8859-1?Q?vAABhS0ACKK4V01jBFUzAmuO3xr7WVfmvB//6OTpKAbMfKxhCkMRWyZGqb?=
 =?iso-8859-1?Q?fqRImdaUEHbaZcgTNaRKjQoyESJopVD8fAlz+vlSVOeg7DKvGWFtB59zap?=
 =?iso-8859-1?Q?AkTOThNuoMkD/PXoHQsoGITpjQDif9zkyrSnqpaUJyO+XcNvpcykPkesT1?=
 =?iso-8859-1?Q?DBwvswUBuAIz7VjkimnyOCLNC+zE2Vsa+Dkr/IzZzs+1a/nk9xe5OZVHJB?=
 =?iso-8859-1?Q?zJ+Fvpao9st9IZvEHSveZxeoEXPa6+CDemFyWlu0RQOQU1I9+pqQDmkiiO?=
 =?iso-8859-1?Q?p0tK5DQbzsMIREDq++09Ju0Gw5QbnPfO6Ea2B5TB6sosSbldJ8qr5AKHl+?=
 =?iso-8859-1?Q?u4lDQclZp+Unuv0js8vw/Qps12ij9M6Yk+1M9cWIw9CGqxUdad+7J5aiQ5?=
 =?iso-8859-1?Q?sq+0rKTTQdxZeVWvboO4oRPyK5roruRV96yMplK1Oup+sCEDfR7edvrSOH?=
 =?iso-8859-1?Q?9fdLwArqfSLLf9PddRtPy3EoWvEN/SReO5F0O8LZ69Mo7in6jnkWA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4794.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92daa336-a4e0-45da-0a05-08d9348f7e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 08:35:15.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0mST6NkzXdsL98LbQK88FGyxU/igCzgwav2wPtFcr+zCpNcc6/pPvzfmh97YQbysfsn1mqvlrSFgQHU3qlCTpBI0nfpNFz690JumesgEWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6169

Hi Daniel,=0A=
=0A=
Great to see you back.=0A=
=0A=
> The whole sorting logic is a overloaded with corner cases. So I am very=
=0A=
> careful with any change in this area.=0A=
Of course.=0A=
=0A=
> There were already not trivial fixes for this section of the code=0A=
> [1]. It clearly shows that there a lot of corner cases to be=0A=
> considered. While Emmanuel's change looks innocent, I can't really say=0A=
> it doesn't have any unwanted side effects. As Jussi points out, the=0A=
> initial problem is clearly in service_compare() not utilizing the=0A=
> PreferredTechnologies setting. My suggestion is to use fix first the=0A=
> sorting as this seems to be something we can agree on it.=0A=
>=0A=
> Can we agree on this one:=0A=
> https://lore.kernel.org/connman/20210621072036.302-1-wagi@monom.org/=0A=
> =0A=
> ? And fix the remaining problems in tiny steps?=0A=
>=0A=
> [1]=0A=
> 5bd396590fdf ("service: Send state changed signal after downgrading state=
")=0A=
> 82c0faebfe4d ("service: Notify leaving online state when downgrading it t=
o ready")=0A=
Allright, I will (re-)check this patch, and propose, if necessary, the rele=
vant fixes=0A=
of my previous patch.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
