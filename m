Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120051.outbound.protection.outlook.com [40.107.12.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176B72
	for <connman@lists.linux.dev>; Mon, 20 Sep 2021 08:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/826y/AbWycCTfWW2NCSOGBSDP3/lz0Pd+IuwB1zKxdyO34VGf5CHJ8TXZ+Je4KtVr9OmYeB/Ug8puGP73BxNKO5LNUoQn+H4eeioceCshrO7VN1NSBU3tEKVx+xdj6TLbhz6ZoKtfgoDHsehULYCek3Zhc/7I4xyNmkZtwWokHiYqlat0+ptSsn39deWHCLLmgteNSJ7W1FfoYxoL7b0E1wibwUIyQjrXsZt5BN4cTch1WnWuXsf2T512E0g4gBeOqafBaygASMJdG2NkFkRBqzz2q4SZx8YFIyHWnsfinzjTbxQUrjiRUE9ADJuYtbtTthQs5lOzA3mr26vXUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lR0tou+VbLWXwF7Bv9qjY1rSJPimroW3ksxIat3ochc=;
 b=gqAWREedg8+P0mzLqoji5uH43eEi6iI3sXGlLJWI+P7CX4JDatrWspQd+Wy6lZBf6mO5EgRdFe2pmz+uODUeS8/wByV3SsXPnt4ww2k3FtSjKz9v+YpVPDzkaSiQ+3xLS5GqTjY0dbiEM54luQc1s0vq8L+/Vj0URBONJQn94jAjhE7VfWZInfaEjqpZCrJcj9JJL99nh2xviof+RtMYzI3ox0U+DyHy5Vqa53uHt6PhTiU4qL42GFn7SHH9RhjJPBtaTwAjTLNgu1XC7h1oGreYv/GbLzJsaqTC99hltA9FQhqJliljb7GbBzkQJgyh3Be+4ELfOjnXgTuW8gj61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR0tou+VbLWXwF7Bv9qjY1rSJPimroW3ksxIat3ochc=;
 b=xAEXsfRT91G2SJNCBVeHvTz5WMA22qq86AcC1PlIbw4qMCneRiYqBnPxgoLHQF/UfM+mvs8nb9wpuwR/Raz75EdcmDaSv6K3k4G5lZ7S9pNgWTEOtnA+nrnQGGQalmVdTImJvRo6/3HzkEFEFyDExzX6dLfBXhsrEtodBJC0C7Q=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1700.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.15; Mon, 20 Sep 2021 08:15:26 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3144:388c:76cd:f14b]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3144:388c:76cd:f14b%9]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 08:15:26 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] build: Fix compiler maybe-uninitialized warnings
Thread-Topic: [PATCH] build: Fix compiler maybe-uninitialized warnings
Thread-Index: AQHXqG8ix5L2wlh/SEuCsXQ5xgN7rauhkLOAgAABenCACv13gIAACMS6
Date: Mon, 20 Sep 2021 08:15:26 +0000
Message-ID:
 <MRZP264MB154402D3255D322D8E7CBC1F93A09@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB15449CB6E42AF281B16F54FE93D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210913072719.3qlnsqjzplntm265@beryllium.lan>
 <MRZP264MB1544BB065A7FADD9BC38F69693D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210920072223.l4pgmhaqsfgee6m6@beryllium.lan>
In-Reply-To: <20210920072223.l4pgmhaqsfgee6m6@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 8d8da390-d2f2-5e18-3b81-ccd14146b7b2
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16ff9ede-868b-45da-3f65-08d97c0ecd5a
x-ms-traffictypediagnostic: MR1P264MB1700:
x-microsoft-antispam-prvs:
 <MR1P264MB1700AEE6ACD0B84F7EBCB1BA93A09@MR1P264MB1700.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XOkeuF9ee7hBo24H3tTWFIvN7kC7Mw0x2ca/vtjLwLJAuCSHI9ULrRbuNg7Id8zSH6qjEwD02WQ/vEtUhtaQbVowOUe64ZiYDKix/W/GCvfisCVS46/P+iyvM+xrPLcYANs/Ol/rUtrvst95g82Ntcprt44T6xNeMb9AGFcd+F4S6EyZS1M2s2+qgGDRq2G4Tw0hkr0Wx3Fi3AUJyCz7roqyJ0kbWDNvlYAueI57yVa04o6pw5h02Zu0frIac1DNYXwQ8PiI+bLvFxGsSxNXC+LkoFBcpLyHfwr4UrPCj9GWogojhGqUE8N7oMZ6A1t6BPClzUalV0LGgwOMc4j123xdVYVSoY/zysjLiZDjVrG1NAw4eHjKWDN9rtXlI3LVZrwew/kNkmx7whXeXFlyeO6p7Z4KG4i5gd4O6umQaPf3jc/NnZu6kIS3oTpezVO3ipAGGBsIfDsOHZfAiN9YMLZNXGiaBJzy+7Evn5CNnIdEPc4JDw/QKJ65RQqJsuaW9jXVMqchKUlKajoLk+yvpAuUFmUIC7796ebXTtNTxTNAL+6bAQ6FlGu/HYglj5KlRjBkRZuL1raFLgCdCYH4MNt8HKHeOnkIJFbbJ7XlTK9IG8JNwgIfHqEJ26MeVdhH5XXaJy6fFFDQMy7U03NF30whyoV1DyXLcct81Uz4BHBb55ftSQ40QBEnEBJN8npjJxI5qFDOlSTJzhy9H30EMA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(6506007)(66946007)(6916009)(52536014)(64756008)(66476007)(66446008)(7696005)(71200400001)(508600001)(38070700005)(9686003)(4326008)(83380400001)(186003)(55016002)(8676002)(86362001)(2906002)(316002)(8936002)(66556008)(91956017)(76116006)(122000001)(5660300002)(33656002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3GMgNFAgrVMbCkSyKjtyYKycRd7PAFzGn8pHDE2N0dMM92LjX9OKqyK4AT?=
 =?iso-8859-1?Q?O7pkxdpoNa4zFX+mVuGMNCSMRC9ERlzdp69g8kFOmnrSOc7R/HVlnvlJzM?=
 =?iso-8859-1?Q?+NcMGs444/jR2KXuit1Gg5NfHi0KvUJ5gL5NSBtoFQ9OkrOKEdZmftWO/V?=
 =?iso-8859-1?Q?FqK52xMUVIWYz2NemxaeGa1MgNo/rFDAmxikArZTflMbNqW11cr09nGF3F?=
 =?iso-8859-1?Q?8AbFEjik1jjp110MvwvqMbaXNsiK2KoOa2enDTpy7FuoJQQ28/Xkj3UmWx?=
 =?iso-8859-1?Q?M3q5kEA+rAwGz7Xy15TTo5uKAlDTW0s6uL6tb44LDcYGyU1iBWuhQ8ayT4?=
 =?iso-8859-1?Q?AeILKfgd4yg+axl8i78aFc0BMmMKd4CZnDd6LpiaWfIjNgv3amkCpAnV7K?=
 =?iso-8859-1?Q?Nz0HiVNnvmbnXqW1SDM07BgBeJ+CevIYwiKw1ebpvul6U9AHM/krUhiFfn?=
 =?iso-8859-1?Q?ISXAKoEcdhVoe2PoKFjqpqnzxQ2mRGlZQKL7D+piGMRBKT78cgtfvNlwH1?=
 =?iso-8859-1?Q?/k5Drg6ZaDiv/LiRgL6EaefezmqZVeG1mKyB2q8pSkxowRe/cEAzz0B/b7?=
 =?iso-8859-1?Q?iOx9zLfnfcU75r6UYwi+vFgh7nZOYGOz47JtkwgLXIn2DYKtVfqwduBCgF?=
 =?iso-8859-1?Q?54WP0VXHB8QJxurtvj+4mynK9wZlgsw5d07dP8A5s8BpzrvkFDmx38//ga?=
 =?iso-8859-1?Q?uhU6JoidbMEibsvw8yo4E62vAdNBLxZq4YQjV4vLmXdmG4qo87NQ28Ia7L?=
 =?iso-8859-1?Q?0Rza+WVe5ccqyrwA4x3TBfMyFwcckW0OJEFqbfWYH/5Uy9p582zpgs5HL2?=
 =?iso-8859-1?Q?1AGVeotGTOOHlhIgi5B3i9C8Gjd9/4WMo7B65Y4/RiyMSI0KafMgJcEJVf?=
 =?iso-8859-1?Q?BjRl9UEPSboUVzWUBepu+rWUpuvND9JxenHruiTGOqL0pBZmagkkfFE5QI?=
 =?iso-8859-1?Q?UVJ2OVEckjbzFXzgZrjc9E9uNqFOrQ29wB8NmgxqEcoikpsqHJSKUk8lrG?=
 =?iso-8859-1?Q?ER3l+6Rn5u4XllFbOjmLTpMXpOc2VrMtjxyEm/1Y+chQU/4/+DnMgWyFXT?=
 =?iso-8859-1?Q?eSGJqkq05V/lrGLx+4EqG4nSvpTq5uaCeLuJ0rbDplrLCvAa7UE3pvyJrw?=
 =?iso-8859-1?Q?LLGKuU8UXiNo8UVVRjSr8XIt2iRC3r1ANa1XnU8Ler6Tj0Ek6wJfm3LZwv?=
 =?iso-8859-1?Q?cUe9IrD9uz1qzm8ddHTlHCwJLpq9E23N65qQvEjk9kt277b5B09rF/ADcA?=
 =?iso-8859-1?Q?sPojVmDS53jjrztT/X1l2jER1BKyrie+A3jNYpTkmY7PVyFa0Aiuz7mCdW?=
 =?iso-8859-1?Q?lo/b4GaWJ8G32BROaS/pSuu7bMNGSZSTL+1jE25z6DM6phfujNQBD4kG9w?=
 =?iso-8859-1?Q?QwNHfpzlpi0Qow0XHsCShgt09l93HjWTsR7+Sh1geHPg7QpdgUFWQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ff9ede-868b-45da-3f65-08d97c0ecd5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 08:15:26.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGFdBRao9k7qI4gfIXfJ1LKltxeBvrGfmWqS70AtLLtcqC5VxI3T1SghTx+Q05H9LIbXphVLb3ux0BfhhhOff59Ge+70KO1a7xcNZnJDt2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1700

Hi Daniel,=0A=
> My compiler doesn't report them (gcc11). What compiler do you use and=0A=
> what are the compile flags?=0A=
> (...)=0A=
> BTW, I tried to trigger the warnings and I was not able to. Now I am=0A=
> trying to fix up clang compile errors...=0A=
It is on clang-12 (with  -Wall -Werror,, in order to provide clean patches)=
,=0A=
so you will probably face the problem. I let you finish your integration.=
=0A=
As said in the title, you can try the -Werror=3Dmaybe-uninitialized flag.=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
