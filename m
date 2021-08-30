Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90057.outbound.protection.outlook.com [40.107.9.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C83FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 07:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9zxL9kA2X1rbUQrOGRxEmbgqKt+712vhR4CWR1xVVZ5xVYNUj+7iOslhhM89BfYq8xj/NNrCu9i1gTOZ26cDPpV61kcfsTS4/mDC8zqPiK90BhpuSSaC/PUydKwOzLmMCa6e+M3qoIm7K/ZXR0nu79GGPuhAhH+JIKZv6tzSTFwoT2h+X1LsVehk3fGlphozQFoDjWFCW8kBtT4IzdyoapBlxhxlVF+mq2P6tg0zYC0jvPmMtpCW455VEN2Qh0J5YU3fBBHKRJ5m3JGDFmQa8uxDUAbO491TOlp5UonINaAGP7v/ka79hXUeEsgDWT27UN1SlWXTTMyw7eu7JONyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILhsKYIi5MYfZTCFAuQsoauCRqvh1FDyBY0jFdj0NeU=;
 b=PIR6ABhcP6mi0bvecA5eQrz/GrA1DG8CuRVjOk94x/3J4vFo+oz6tnvEUkf/eTA3MF1G0gofw8F0zL22DXH6mJCKsj4PE4+FZoRXY2/msXLUDTNC0oFsfQKxLT/UCqrarlqGo1agoBnPnwUaU3wDaRUDgpzZZzq7Rf5uwjsSK+aHG2G1OAE6lV3qGQEDPKg2LL+3gK73MaDbcgFmQXVfMb/KTRsdWCFMvTb0PcF3SPmaTNEOiXOoMCZDw3uaQT+/dioJqY4RDeNKB3HKUqCMY7YRBBYGDcT6V1EsLjzfoBGCF0EXVJ2K98v6DXbUIxTDDtDKudKpX1Xd/cdp9yZDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILhsKYIi5MYfZTCFAuQsoauCRqvh1FDyBY0jFdj0NeU=;
 b=nSoDC6SnFeDTxmcyhTzHKUc+GFrTyEAAyIb99E9njuN5wZILq6pXvw5FEpY6Fj0f60ZTn11a8tEdSPLHu6Zpk+gi7AwlFNzKKB/mEK3Kvj7ppChkVTGdGrr634uSVWasDRd3G6qLJEAhdoWR+RFNl7k3FIsurEB9Gus+1ujnSFg=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1905.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17; Mon, 30 Aug 2021 07:41:12 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 07:41:12 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Prevent auto connection during passphrase
 request
Thread-Topic: [PATCH] service: Prevent auto connection during passphrase
 request
Thread-Index: AQHXYP0z1UDC2PJp8EiESz+rAkM0L6uElHlFgAa/0QCAAM48ag==
Date: Mon, 30 Aug 2021 07:41:12 +0000
Message-ID:
 <MRZP264MB1544FFEE2E39694CD2D807F693CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB47941F36176A2E8723EB139193319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <MRZP264MB15442670841BF0B75B350B2A93C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210829192158.3zdnc2hsdaqwuhsz@beryllium.lan>
In-Reply-To: <20210829192158.3zdnc2hsdaqwuhsz@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 786f1eee-7f0c-421f-21eb-08d96b898a66
x-ms-traffictypediagnostic: MR1P264MB1905:
x-microsoft-antispam-prvs:
 <MR1P264MB1905FEB283AE87DEC6E1D92C93CB9@MR1P264MB1905.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fRu1zi54poXq64gPP6KO+bP1GH8GT8ny+KosbRpZEQn7e1zKY0Q9Lsape2edbiaBaMsC1rZlwfwrNeGltg21KRV+4C5MtpBX05abx94opVG14gO4NSRZARh37efskVxIcAx3up/tUiyr1TOrzKjh55wPro/TQHEJWmlPcS1g0k1Q+E887JiosK4iwCYGWIzG7WRlONXOeSvSpS2FF8h9teyvBPhFs/1qb29HRqzHH8jXmZ7u2K8DLOHUhjdT5Vy1BXAnBJx9kGGJAbe3o4Jm2J+Pw9bUHMVker8WzGLnal3o55MF7z0nfWjjtlRh9INx9kqjML2yDXaN7iardKIdF10q1cCL9UTpKjK81Xcebs0WZ9RyLvyMkKdMTRMy6c0Zpv9zq5bfUqXMOlQ8TpSHeEMM1L+yXphGKcV1HT5WRKxAqGscg/mFchwXQXU7lkODrxvJ4lkA30ZXyPmB+bNhDAfOm+6fTptVxylN9Uta+fCA2Eii4mB7I4z0SxuCI9ANk2McHWf7yez2W1BCaA0SveE+j6OS8ztbn56mBZvOhqO1AsXbijM+lnw/3rIn+8P5TjdmI8DZn6ZGPmOwcng0MdhlWkg08iufZ0UwsgJvYPH1Qf3+Z0NoygYhpUsqCxZeWXDPusHYCDvBPW2HVDIDmtIzG4oZjrd9e3D4YvZ1jYYBCCtnQ7ItBfAiyt71U6Y/ItoVXm7Ns7m83WETM5y3qQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(122000001)(5660300002)(6506007)(316002)(55016002)(7696005)(8936002)(478600001)(6916009)(52536014)(66446008)(4326008)(33656002)(86362001)(8676002)(66556008)(64756008)(2906002)(66476007)(558084003)(71200400001)(66946007)(9686003)(83380400001)(38070700005)(186003)(38100700002)(91956017)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pq+jfQK0zd6YEsb4khOHI6OPacoEEJJhKYczQkT7zgHcHhc6hYTj39Mhda?=
 =?iso-8859-1?Q?kwJRRJg3ZjpcuocAnb83JKybhhBI9vmUrAXFQM/+s2CVUFDKo3bcHsabfJ?=
 =?iso-8859-1?Q?cVjsBdk8o9VRliSo116CX/vtBt/OFxhdTC1rlm68sK1BMzxJYV0Q4k2i/c?=
 =?iso-8859-1?Q?ZsX/pfiNp/KjFE7zMWu+26H6JlcK6JwS2nC+MNb0PCzBHjPwwzcIcbLUkP?=
 =?iso-8859-1?Q?9XwzsM1Q31Z3bGffSJ+riLfGFAmq7ADaMSr/b1rVud5dGi5qbtt0EMMvgC?=
 =?iso-8859-1?Q?38Bf5NR8RkKnfBrak7HpVRDyJADwylTAfPn4KzTh/JVMBFOAvQ+mQsDfXT?=
 =?iso-8859-1?Q?zSpL/WKdIDH2OV4yzed7LSFNSZz7qIEzVNJNETbMOcfmiypTY3C4onmI4s?=
 =?iso-8859-1?Q?89kIf0hAs1s3WHVFbDE69SmbnWngr+ZbLOpNNJ82nxYdibJ9KiXmQGWXN9?=
 =?iso-8859-1?Q?7h0VbmOeoCy+TbGA8cEZqAJrhi0hSd/mxXETZEm6HVikN83o473rjS2grp?=
 =?iso-8859-1?Q?pEyn5Frh0OrW+SX7IThL/otx9e45xfn13xIGwnZs80BqjzqH/uD/8hXF8g?=
 =?iso-8859-1?Q?HMsVgNZbSyqMRFmvx7QPCaDbSGfce9Duoyatt5lA8a9g3wE7IRkUfG+9i+?=
 =?iso-8859-1?Q?mt2Q13DUGRR+2CYQEpiSjf/LgqMSH4fmo0FLBGFN8dVJgKXoijorrjJMff?=
 =?iso-8859-1?Q?31IU1BJ4vwlzQriz5Rjo21VFqR4gWYrxtjomrESPNMdr9yWsLf/5h1i5rR?=
 =?iso-8859-1?Q?2IpEjjqkqbkxJo8Nsyx7uwzGpNcBhIIWqvf5PiZ2WSpN7voeh4UugKzhf+?=
 =?iso-8859-1?Q?HHh02TXPlOAN1TdsQfBcMcEzbz9JgPjS4YxKCtxRlOtVxasCLLbC9x28cF?=
 =?iso-8859-1?Q?O093xrwnIQ2bpTv7ZF8KscgBLEsosrmIufQDk0A1kZWM0bmMV1/H3KBwcN?=
 =?iso-8859-1?Q?uJwdbsWaI+Ur1Yfp3/ysEw4fZR4dTv2V0h3iksuZfDabHmQ5TpXTj3+WOy?=
 =?iso-8859-1?Q?qmsM6zgaTlf3Ag0NEsV0N+pW2JOKd3Uc+IahzQwCCMYAWjruYqMkXIZjW/?=
 =?iso-8859-1?Q?ZST5IoKPNehbnJn/AmPXjC9T3RRLa+vvyVHuVijC01RS3p3D/T22K0c/U8?=
 =?iso-8859-1?Q?xfIZqTD8ATCKGqvFmqvy7PLVTwn7QCzkravF/njLlzhBHWl/iz1tnI1CJe?=
 =?iso-8859-1?Q?2fkU5+5WtMYTXqIPB1aR22MD8LnLTxqJTa0rDJyj/uHuWgHZOe1P5gRHZ5?=
 =?iso-8859-1?Q?/SUhsO6aoZOtksV/7nMZz2D8gi+7Ya4rdk9iBuM0EAqPIt49zk/VPeDzxp?=
 =?iso-8859-1?Q?cJOtUnV0COqF7JCJYhK6wI8ipsYJYBOfCMtzm33026bqtPAnJefl2t97LT?=
 =?iso-8859-1?Q?uA+/1PXWoTmwDATtTVlBgscTPTDC/jT+N7162ybMmFitMSMkpkyG8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 786f1eee-7f0c-421f-21eb-08d96b898a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 07:41:12.5141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UarCumJuKFUrx6q+AV1ASIVfb+VblvrwnTdSDHtpvQFHK9EmvbcIGeWMyD22oK0ZdJ7Zl0fLmN8n1WSafPaRO9++8oE9YBRD2xaDBwS6jOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1905

>  No all good. Thanks for extending the commit message. This will be handy=
=0A=
> to figure out what it tries to fix if there is a problem with this=0A=
> change.=0A=
> =0A=
> Patch applied.=0A=
Great Daniel, thank you.=0A=
=0A=
Emmanuel=0A=
=0A=
