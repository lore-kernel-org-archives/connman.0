Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90041.outbound.protection.outlook.com [40.107.9.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D6173
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 09:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0wgl2AlzJXpp8ru7qyInNuHU+JZOYWi0Gvp15CQgbHi5ChC1L3cVG6l/HxUQw32LhITmcUU8+NG+mvi5fKk2dZSEUECWfyhCLBuimT1qUeDuP4rxXdcELA49qc9imA+tRtY3kLesnTyGBYmaGl03LV12gjsNeknfsHZDfYdhylfZXAETKya4FTN4g7FJxhcoTevqDIOsd3g0Zrtnf+//f1j+6tJmM8a8/64rmYixz8FUigphLjbnxTiBOhpbHYVzKs0u+GvagZa0z54z6+X7k9n4mMlhceuoh9lBFRC9zQPGZzosU3XWqWvmMROoMP0cnImWvebpsJ1adigJNjKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+9xGh3XlliHJXLSpe7mhukgxnAXDl/JeNpadUkVLfY=;
 b=obtmSBvOrqOwkmpFgBBHjeNhM71xD88I2jOqQs/W+t0hZIc0xXzXdFNuo0XJbtl7uHdU5gIP2s9KV94OK6S96tIIOva+iCraLvuOUvWaBUfPFau/lSL0I1BGmU+fP41yqElLuzViHInkudguump3abkOsK/sR3ZI1ZjQG1DgQm95CnbYHu+cZXDAfHKFMTwPY8AmrGFozvEmE6actzF+7WESYYT2ZnLBHZISXkOLlbzQThJec7uTsTeKNJiiFaUMKTAaPXELuVoq13oQ4m6YS87J5Ps0NQrw16hMLdihwIi9MuNb5fMvVqy4y0S4jIzUJ8XJ1vAllM7r/Ua+yTUQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+9xGh3XlliHJXLSpe7mhukgxnAXDl/JeNpadUkVLfY=;
 b=rKqBtMskoz1Ws0yxTvwMKJ6C7+BB/aWASqn/SIsw12eGDjlqR6oXQgyBdy2puCto570NZ+YNk65+ciqIDx3Hf9NCmnfTAVbcVvfJfpvLXmAYSRiEgYBIbVmkgr3KGE5VuSbg7/NJhAcKm56UeUPnL3HPovRVZAd7zknmkIP68ak=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB1542.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Fri, 21 Jan 2022 09:47:25 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 09:47:25 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Fix station in scan callback
Thread-Topic: [PATCH] iwd: Fix station in scan callback
Thread-Index: AQHYDFZFvKv00kRpGEuWjfSrVy/9aqxok/cggAABvf+ABIhLgIAAINX3
Date: Fri, 21 Jan 2022 09:47:24 +0000
Message-ID:
 <MRZP264MB15441FCF0A51CE92605AF624935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118102842.1199829-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15441C964067460C12EC95B793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544DC10A3C17E1934D4CF0893589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220121074853.t3vugo7mtwtpwmcj@beryllium.lan>
In-Reply-To: <20220121074853.t3vugo7mtwtpwmcj@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 83f4bc46-6b7d-5722-b9b3-c8a17eee27c9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad72934d-fc4a-4329-5741-08d9dcc30763
x-ms-traffictypediagnostic: MRZP264MB1542:EE_
x-microsoft-antispam-prvs:
 <MRZP264MB1542D33242C7FB4D5E7F7444935B9@MRZP264MB1542.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +1bzFGtAZHE84sHx0/8g3DESA+ViKn37qX5ZDA7D5UZ1A+i6ZjxzzZlnHAQwncYtTyjhKxsmw4XhmQZ1yaQZ1gLTqvzYNNmoj7ise6BxL9zJnbYDTrSKswTcrW/jmzY1DuwEjgIl/3AzmNq+YXNQ4+0RzPYzfMGuzVjJbteHoYAZnPYXnBKPopnFpZ4L4pvHpiQhrfsNMKBvyo4gQPDYWTPPnXQR/BjNeJfzMkOpsxVNtrqHEkPYw9YM2h1ynJ1Hep8iAsPPHnz8lnfWwukQFOBaFCYaX2xDosaGnNmkSXZ47HFSmNY4KQ9NYuL1OfFABVglBZkEs/uG3cq2DvF0xpsnUz+QOyapJAAe0goXYnhLt1ek1VqXtYTozESXz2EI3nHJVmMYK1qwwlbp56suMD6LyNz2ZFnBGRzCG6gvobKju0BC46sMAHPxDrmxJkmGDvOhXVUVpJcXQ7Tq2TcMoqXi2pCr9V2Ga3QJBEm2vtH8RH2AhvdcqI49mDYinI5o12U8K2bxpKMRJpB9GE7Xzrx+qvkpnqtXJXkL++Rj9XHoig1QDMKEjjmj3sZY0Bu8+ERLoftfssG4KXN2SHL94WSSui6MXqgT27NGVUVrojjF5L1lnNV8Bx2PN/zNodMiQxCtl0ZjkBd5aSSrLIchfP0oJyTQ1sw5lumc+AXEOWcUSrmQM/VkJoIh7tuMEdZ3eRgBo4abuj9GGHy2wRsiTg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(316002)(6506007)(7696005)(9686003)(558084003)(2906002)(55016003)(186003)(86362001)(6916009)(33656002)(38100700002)(38070700005)(66556008)(64756008)(508600001)(66446008)(66476007)(76116006)(91956017)(66946007)(122000001)(8936002)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Qhg1xCnRvkEfPG8EShUDjVrmqhC7K47DpXUQaTPWTkpQedC+nOzgYloG45?=
 =?iso-8859-1?Q?sqlv6AMr1vfeSMKrwPGDOhmS1hlj41QAoVmO7fqKTgmVs80/jkRIt367iM?=
 =?iso-8859-1?Q?bcOxUaKJFiTc7e74GrCdamkiN/eCPgZ61o9NfrxDEwXjkseSKfTZ2xD0Jd?=
 =?iso-8859-1?Q?eRaRkr8DNtacGEnOxQK817ttTWA4M7i2Ny1udrUyV0tPqTX8EDpUQJ18w7?=
 =?iso-8859-1?Q?zZGabnjsjTUmGFvLjHlwNo5mgPN9gaAx12kwr7fNmGfyl3LetApk3RDm8X?=
 =?iso-8859-1?Q?ZUicJXNGnB9BleLlR9IZw0TJ6mm9qA5yOfOth+2zZE1Qfd4j8mbI+42uak?=
 =?iso-8859-1?Q?QdDFtihvVkZxvRzlC6R8cmGWiB75dQ0MY+3VEKCB6DEERTFKt7bZq/unvC?=
 =?iso-8859-1?Q?w27091KaezAy7G/hCVYXPVN9mRQDwfMORrclfDMjIVhuDEHnPN3fljAlh4?=
 =?iso-8859-1?Q?Oaqq7FHjAL3MbV77wttJFOpA753mC7ZwYAoPrlTwKGpwYChs87RvQvN+ga?=
 =?iso-8859-1?Q?7Ldjiph4i1UbXVIWn+mk/c0IHAgDZU7XI7FoXF5auxriiAxrbC2DTICUT9?=
 =?iso-8859-1?Q?yfyeTb5+yUHvuophXIuYC+W3/2QpCx9h/ijKkiirmksh/tT2MvOgMnNhcc?=
 =?iso-8859-1?Q?Jxref7Cykz7FSVY/s3cpXq20sEfyCvthpJGmMIeg1ZGKCkb47Z+srKBuP8?=
 =?iso-8859-1?Q?611EI+pAc3PBEZhFawTL5+omcO6JMXy6tJCS6PyN2GbP7B6ZEZvDMl+ruY?=
 =?iso-8859-1?Q?6YWsglo6EQoURIrSKzrR4kl5bC0Q9WNI/wXNBITQrrwLrfiypJ/Yi8qQdC?=
 =?iso-8859-1?Q?3KXRl81rg/4/Gfk2np6SH8ZuE1CDCkjuq4qWoeAMu+YF1GZtIOucSGgtLm?=
 =?iso-8859-1?Q?5p7geHd7DNpm+K5X+5hc4x1GlBBIGi6x2da2wHPkcmUW/2UtHQ+bUU82wy?=
 =?iso-8859-1?Q?4cbwZdbvl2aIKSzmdavmCpOeCzDtfsCh6p3FzHuvPwuQOkNmf95NX+IzVh?=
 =?iso-8859-1?Q?DER6sQcG7Ql8Og3DtIDD8pADi7RrIYcsfEY9/YSC85R2YZAhaNdfjJX39a?=
 =?iso-8859-1?Q?Mz0AWtcFEub4L3NpBu6qPlpmp500TLQzSN1TvC0xPwJ6WZ1f94vB1apXf3?=
 =?iso-8859-1?Q?1FxD0z3DY5nfz0Auz16Aat3eZIWiVQE6svJMYGvbWqJDZ/tqAiENLCt306?=
 =?iso-8859-1?Q?dO76HPJfxtb8HmEcLUK/mhTfWfInyHdVObcxDu4btPQ6x/hpLT+hIeEvnU?=
 =?iso-8859-1?Q?IHxKbSC2XfZiqfRpMG72QS+e3kDH4X6F+05nrnNeUozn+6BMKInz/XAyml?=
 =?iso-8859-1?Q?TJpSiBkkQnLdeanPpPcBcKyo6HHyGeR1psuqljp3hjPy/QF5GNPQalc5F6?=
 =?iso-8859-1?Q?XAG7Z3J3rP72ob+0TBnNJO5C04eTLyZDZervGDF/v3SsAXLHVJ5AvcdCho?=
 =?iso-8859-1?Q?J9U9/eC1Wuj+eWSCsDej8nnxshUZTbP0zVWEh9F6I4vpEH3EVO27yr4i3a?=
 =?iso-8859-1?Q?S44Iwt5zWeOnjUJYg4+WJ/UGdLkT7D907LkpZO8cUlfF3CKnGlcAN6rvER?=
 =?iso-8859-1?Q?i1UdYe8BnEiywV95O6MRXRhHIb/hZq1J0qo4qzEzCJitOmR8zMinDNeRzi?=
 =?iso-8859-1?Q?1n7+MJzV9OmfIkkB6UGzoioFjkgKh7mNqmfoKvCmsBGn2wnLJcds5mVlbc?=
 =?iso-8859-1?Q?hjq0N3LJAZN4o+VXFdDINsMxxurwsHgLeawKIqUYq8rAgBJyYSTnVowY6+?=
 =?iso-8859-1?Q?QubJVhk/8tnFsM7okG35MOhkrlU5dAAFPWyj4vJL49PUkNVmiolbukniJZ?=
 =?iso-8859-1?Q?FwTMwJd7Xg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad72934d-fc4a-4329-5741-08d9dcc30763
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 09:47:24.9539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLxTDbb+fRbQLSidE80M9BLbGvIogHRpqgnHAqayxqJd3y+YG+hJqMmEEu04mOB8E6HkdS7qavMxa38lJOEHatXX5OnNDZ/QlS5SksJGrWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1542

> Patch applied. Thanks!=0A=
Great, thank you Daniel!=
