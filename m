Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90049.outbound.protection.outlook.com [40.107.9.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49492C9C
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 09:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWqds0+BRpD/xKOzbVoApHCYuJqFCPH3GbxbvtXhEz2oUn9cRmcWQyoraS66H/Sexnm7AIhd0qgc2eQyNlu3d2ZkhMHncsxzvszrPbXxTQUdKigGoRwZ4sWk4ARxqm3MvnbNm+/TATeBB/MzE0ztAYsWW446Wsi7hoop5i58AY8d0uulzBT1beFzkaNQ3chrIx7qLsheMIzxNBPMET3GwVYNbyQ/q5FH6ulFdiQhKRqmFW7aW1L0Dv+x1IPEiyKvu+/hUhPlRmoQQw9qKGqn91/SZ8Cq6neYHyZ6Ij8PZRWX7E8Mjj7OGKBHl/3ru9JKkXzQnP86aLsf3t0EyawQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEKyfPBC2gEe6+eP8D/8FKijb4FK9EXc5nsxw6BNvNY=;
 b=Xp/b0S2bbDbhIbIVjrG3tgTCFcb1x+7UX+UcQPufnpA9PM+fFhKpyLzbhneicsYUU17atbU6fJoyXrW2h+Yc/97AkPjt4J+I9xVYkZ1/y1p/X13EXCoStzF3c/jffBmMMBBOTQ5geqKNrfIIMpLPeuZ2BMdqrcNbLBHfWGKAZiuOHQSFCrlJeBVatg3b70WKFIG7X/YkA0DxZLL66VBGJE96E+wZEhi+cRgL7nse09ViRBHNFQ5s6sSH/+65K51MyEMVWaD1e+u4PxXarY5k3M6mMpTTAlt00n8PuHdYtiL0xvspnNpVs9Xh16viHxUBTnE5o2L6RSnvA1GZiIHP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEKyfPBC2gEe6+eP8D/8FKijb4FK9EXc5nsxw6BNvNY=;
 b=gKS/cii2uxg7e9nXpLKrdk3/ezjchLxzDDFFpdYpfEHbVtBTVlErH3UGHzIA6Gq9SbTTG0AVI4TM22OX0Pg2Y08WOPE9ujNm00EdGVAAch2/sw09i3HYrjgsgsjzTCYLJJ8V8LzzXej1k7Qety+X9KxLVRkSwzolMwJCPYcZ6ZA=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2385.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:32::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Fri, 21 Jan 2022 09:43:04 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 09:43:04 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Mark only reachable networks as available
Thread-Topic: [PATCH] iwd: Mark only reachable networks as available
Thread-Index: AQHYDGo9kiHGf5opQE+wqLtADTATcqxou7kygARjxICAAB0bMQ==
Date: Fri, 21 Jan 2022 09:43:04 +0000
Message-ID:
 <MRZP264MB1544A373628E5F36B3800AA8935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118125207.1204244-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154437A17FE29544A015748A93589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220121075447.nazzfzcc5h2lcnv3@beryllium.lan>
In-Reply-To: <20220121075447.nazzfzcc5h2lcnv3@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 2e7a678b-2dc7-042d-5547-8f73e127844a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 149c2599-5111-46da-78af-08d9dcc26be8
x-ms-traffictypediagnostic: MR1P264MB2385:EE_
x-microsoft-antispam-prvs:
 <MR1P264MB2385688E0C1C83DED94D66AF935B9@MR1P264MB2385.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6fDfC7blrbnc13BWzGWFKCrN4bGKHvS4AShPm6r9SueEg/hnLWpnE8EpXklZ5QqHrVJ8FCP4MP/29laVda0jEI7E4/0zidWqz/p0HKUa33AfqVy7lKWSX617fnAe1a//+KidjAYGys3HtEng2DBY4sgf/huvCMwpqcgfLtgC54WHQ77v3Gs1USm4RxF81yWtjR5m57mXwfGf2lPkMzpd2newdO7UCPcuC6u9Kke7B5z7ySCCLRWC4JrCaMvnbWZLVQWH7XH43wrwL1Z2GeDglLwEV+Ge3DEy5WsnAscWWYj5HWdEgpP9rwQVqR0mZMY8p9S0RjXXUuUYPuGAnFwALkpQpVMYUiKsbdkaHDc6yUo1NPIZcSBype2s8fWHmt1C4OP4JpmPTO3AzlWNRCZ78wZbBjHNNKavpQsKQb2nyTy1VHhrTucYGFOrtaf2s+c3jRjXTrAcyeFCwFnwbz6tZCIbfyvg060mAeeZgxShTCSQdywWQRj754esHJHo4Yos72OOlECRvLr+CPmJcP9PiDs5nmuITwIBd1n35APdPqKk0pB3FQrW0oC4bD8YNnVbxGexf7dyJf9Djo66MhQ7qiIqUKIOle81PR1JzlysSLrjZ8NL1VSN8I2u1UR3T8GMy1ijnLdNIUTE4Ul159850THISHFQqhkBexbXO1VDrApqjby9OWv7x1+2u7clBECHPFdbq5Ppb6HBH+cLWT/Jzg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(52536014)(91956017)(8936002)(33656002)(64756008)(66476007)(66946007)(66556008)(76116006)(316002)(66446008)(38100700002)(2906002)(71200400001)(7696005)(6506007)(8676002)(186003)(508600001)(6916009)(9686003)(558084003)(55016003)(83380400001)(86362001)(5660300002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TtT+HDydMlrPOAy2hgdSJtFYUxEkUiwlKLzeXvIT7B+kOwIxKsd1DbxAL9?=
 =?iso-8859-1?Q?55ibVvMt9Mm/Kk7VU7qqsOZjcs9yNQZ+N15Y43XwBmLzHxe6db6vLHRu8/?=
 =?iso-8859-1?Q?maCHVGkqAfp4/cbcN8zmoVqpmb80CcuFSfl+mb+CcoEu2JVBRDxVosOIrH?=
 =?iso-8859-1?Q?YIUipvUu193a/YzfFf/txeAel+Kzs7514glTiULBltoFxj7xWyrhnmZUtL?=
 =?iso-8859-1?Q?qWMNT9HLG5oVCGMfIxb8ba1fov+5gM+rnGcuq7Ei/sm++WDrHVRgHjw9yR?=
 =?iso-8859-1?Q?gprnpQIC6n0HFPYcQZb160mlMoSMxXNb/6qcn7JqdYsbyWjJb+quYAptQf?=
 =?iso-8859-1?Q?WU1M7wSkDXCleKfB/qxU4wpQmhgpOOVwXrWJ5jHYhYrqjQ88DQ17TVWUM6?=
 =?iso-8859-1?Q?Vo9QCEdbycZfmPug943Ru9EV/v2+xikUtpoPntIXB25mIiwVGL2QBcmBhs?=
 =?iso-8859-1?Q?1J5jnFtVpZTTYJ2zuWCiMGVHJpU5mnsuAYrXz2Nn+X+iI3DjcT9CCtGgbu?=
 =?iso-8859-1?Q?bphYdzTrhFl7luX5O8VCEzYv+6xniD657vR/+Do6HmH9+JVi+rC7Yur8gb?=
 =?iso-8859-1?Q?/PyXA7glyxSWLs8g6b1cuzvGyMPwOB/tuTU+T3Ean/38ANydLv1CVTZuuc?=
 =?iso-8859-1?Q?jNuJqIBuIA48q2fck8nwJ8+XZt4EfIvr3+HFLtEC2oxp3ApBByf2n4LW4L?=
 =?iso-8859-1?Q?IffYkDV3eN2IOsnaY/4KAiCIEnW3OnXJYMyWpGBSWLiUGPg9TB4d+RqlUO?=
 =?iso-8859-1?Q?raykAdVXewgDifWv61qD9pgag1nN0H7pk37okWWTfiMI8Fhj6AlT9Hirqx?=
 =?iso-8859-1?Q?K1A6ucDWsdasBT0Ky6YDE2DylZz9vc5B/DIWh4yYNV6Xd8WH+pE2pqsGXL?=
 =?iso-8859-1?Q?Praqze95gPwwZVL30OHc0gciBd51BGjLm+esXMLaSpNszVMrRwHgR/aFLA?=
 =?iso-8859-1?Q?9lcBzpM+nrUHjVBuWSeGOJFaEfu4W9UEDyJSQK/dK230c8g/aUsU9ghprl?=
 =?iso-8859-1?Q?Ken+5Wt7+TJYl49Plg/p8Za4/z87f2/l8N0D1RCAyg8pZ7ROa8zdZyqw4R?=
 =?iso-8859-1?Q?NRrVRwiQCGRCtQQTf86Kpsv7q/13OTtOYei8+SZp7JVltORoThPxmJlE/u?=
 =?iso-8859-1?Q?+jEIL5DkhniApyXcf/I0X0qIAE477IC0UVczE/ZkdRkvLode8wgxKndQU5?=
 =?iso-8859-1?Q?kpFLo9Ie8EAnaW4whgd5hH7xwNRVDlRhFy7eRHnEElHxDU5X5DSoD3SHu1?=
 =?iso-8859-1?Q?Nehf4M7jXQ7XCRlvD5nWk3o65whD6WIoFYlnoipVCfGW0+6VKVSU5b+MWc?=
 =?iso-8859-1?Q?BzgbJ9Q5t9Nvgb1IcCA6RORVGqk04AZOrkjjssM3RQaYa0yai3C1fK+SXe?=
 =?iso-8859-1?Q?Fb/AlNIIlXmpXKg2jBgnaFy0nTmHpQ49kxhk6gGACJp1LkktkGQcULcFw4?=
 =?iso-8859-1?Q?RhN4KM9OQphLx/67brAyDE4l+/+5Mzl9lSde6i/+g3aRwjEg8Y+mHYq5hW?=
 =?iso-8859-1?Q?t2SGU5aYMHNwBza65iVVKGeETBXImihnco5vVGZCk5Ckqf3gm4dnY0pGDs?=
 =?iso-8859-1?Q?cWyd7jf0muOatcyE4h2xyf63l710vMN6ywDDZBkIJs2ZodncIEAIbon1za?=
 =?iso-8859-1?Q?YXjGA/Ruv0ZodQnnuoSMr/OJpDVyabxL2/lA+wBooQRziI2DVmJiXdCJfw?=
 =?iso-8859-1?Q?TxGRTQVGBcgXu7k8FeDqT0tl/vmuFqF9GnAhwNsWYC6zyugIzDpHZYk/DS?=
 =?iso-8859-1?Q?XjrZpzENdmJJQk4JzbZ52nP4p8692symSIExpvhiEc0WoKqK8/0ahVusTI?=
 =?iso-8859-1?Q?STyEMpIV8A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 149c2599-5111-46da-78af-08d9dcc26be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 09:43:04.1330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+Yem439a/mGx/Ifq1HpueE0rYk9GbnmHW3+SSR2gMT8ZOUXc+KEwbpft3iQlk8jj2Vduy32qYELU0/71dihgoUvLaNNMu0v7Jx6huF9rSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2385

> Patch applied. I was not aware that iwd shows networks with no signal=0A=
> strength. Thanks!=0A=
=0A=
Great news, thank you Daniel!=0A=
Indeed, it is really rare, but I have noticed that during some full test=0A=
campaigns, what I have never noticed (during years) with wpa-supplicant.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
