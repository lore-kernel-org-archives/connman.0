Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90085.outbound.protection.outlook.com [40.107.9.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD470
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 15:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyrAbA+EPgGYHIQPVOcQgdCM7pSzy8cFpizJkmcqN80DKG/Ywd3at1x2XUwedi2RBjdsu0ArO+8kNDg+5mJrTXZ2m82ctL+68kIb4J2HLsRfSwQeDWkGE5u7z0y4FO4jcRrWJzJRp9Mx9ztSahThSsGrPZGmcyVRnEJJSirFWylTE3grLdTQE7KwkWJ3y3HlbCZOLEjIAMR1j/eKRBsc2p0a3Az3bkI90bgSxQe1uk7qHNsW7xCAEiQeIT5WrNEcEBKamYvrtOv6+CPDDjJ0nNAYLhNXqx8bFcNI3KvGImMJNbgFgbCUACS91JaXyRyE8dRj/7s/WKCH+w1pfxILUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFN9/NBIC7ATdT7clEiDlRuFx4a0egZOogdN3+HfDPU=;
 b=kF3lLRx+IxIGjqgay+Ln/frrTo4JfQ+i242d6Fokv8pOZVzkEvczVNG5sTLt67Slot18sGfJb73LlX2KeaqU1XMuBYIZxL1eVSqruCAsjx5ox/N4tWAo9518j6LN4smlDZpehr3eK7p9GtRCKRMc5BoT9T+YCoalRk4SPAGq9ijI+MZkOIJ/JTEbb5/P12NY/Dm4lh8oJvRxZyTef8cDAV2ljKgLdxRsUJnpipM2tYnN7VVwjTmx2FJ0J/gNQBOsHxbN+JnA/pdjfL4B2Zw+RcaZ0oUu0NmetV0CYhvd1TYycKyKWNVYR63ggY+HfH+Z/hjI/W1ZWpFrJuY/08W5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFN9/NBIC7ATdT7clEiDlRuFx4a0egZOogdN3+HfDPU=;
 b=ChRYAFIFLYln2p3vtX44bXQ9CAd4WArooGLUWgLqLPGmGps//NJq8/Slt4ocjiR/S0Q4XfNjL0DfDjmjx9H1X4Wd4Gaz2TCCbv/WYcjcGW3NIZJ0V0pIkW6EPJZwmGkSmH9SPF52YPQDuPwnLGrJDkAMuEFrk8870MXZ1mNbYBU=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRXP264MB0037.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Fri, 2 Jul 2021 15:43:58 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682%5]) with mapi id 15.20.4287.027; Fri, 2 Jul 2021
 15:43:58 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix default service update on ready state
Thread-Topic: [PATCH] service: Fix default service update on ready state
Thread-Index: AQHXaCl3q3yULm0o6kitbLJsUjipmqsiz8KAgAAOuVeADHiAgIAAA+gAgACAkXg=
Date: Fri, 2 Jul 2021 15:43:58 +0000
Message-ID:
 <MRZP264MB154494B92E616DB754E5F46A931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210624080757.722whwmmwrnzffvb@beryllium.lan>
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>,<20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
In-Reply-To: <20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dc239bd-5161-4371-713f-08d93d703508
x-ms-traffictypediagnostic: MRXP264MB0037:
x-microsoft-antispam-prvs:
 <MRXP264MB00375CF60EFF05A5891BF34C931F9@MRXP264MB0037.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zpTWUNY30D2P/sUJfGU7ynMCs3MYKJlBqk0uVS1JcBY64y8DmheJgG53Y7qMEEZpiwzfjkMQUZuVnv9QSp4XQzW4LDpA5S/f2QUs6Yu22UCVJQh38ffGYfZi7ciZ2GgFsYY45SvRqkRJR/dGtPhmZCthbBYwhEbHQLhWnbsnFLS3fdfhWbF4e1+lbopJt9wPzj/UzEiEzZ9rlZq3ksBvmb/pW5wF2vWZ7SGOGOJGUpKWWpU9Zotye3fd7plAa+KZIe9rHUb1TGZMEsm4XXihCGpvB3wVvZ5lV+FSMKalc5NmsRFFzlIam/ZeaqpCZFKs7bzhc24irKj9rCadb5UHclywj5kzY6lhf+NiVdBCtobn5ZPRCWljMClTbSl+8yf/fsGzBzRZT0TXTH5WtxNCzlNNNRlV+edw3RGXFx+0K1epVJFo2Hiu3wWuGfNA5fsRqz/cjh4OzgFKCuoTSTqxP3bAEKm63RwgFJXXAigLBIraIRDMrmvUVNzn8Y2slKjCCp7p92GAsfdRe+gvmGbCWj7qsrmrkiSkIkwAwISpEolJ8gExuSBF+gMaTuG/njMBU0mvah/lIu/hX3a+b2UTi2IkQ0SEHuRHgWjq84131KvnDnqR7+u2JOZZ280vNPRJjYiiagvJzVx6f4XQUmzmZg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(6916009)(122000001)(66476007)(66446008)(64756008)(86362001)(2906002)(7696005)(4326008)(38100700002)(71200400001)(33656002)(66556008)(66946007)(8936002)(9686003)(316002)(83380400001)(5660300002)(76116006)(91956017)(6506007)(186003)(52536014)(55016002)(478600001)(8676002)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pMTpCj0ECwjj+9GRbR/aCORFOmcef3cfx3BTVU1Co08mhQhGRMB0VDmIxt?=
 =?iso-8859-1?Q?TmomWr6rc7woPFIWB+758WbXFDJbmn5PQ2IeOSq3MANf8R2zhFVVByEsCC?=
 =?iso-8859-1?Q?59epOC9As2bzOsAT+KM7srhFICh5jmozCxUT8hMLQuG9g/fTQv6HUrkErs?=
 =?iso-8859-1?Q?j7iRDqrI4KsdcWU/KKuvtGWlKC+W3kv16MIibBVtCFWnSjnq2yKPUAi+Vn?=
 =?iso-8859-1?Q?UB2OlToImrpodbxAMX0n/KlSrpiJaTVTi00PRfoSBiQFpeu4LMfh2WnlC3?=
 =?iso-8859-1?Q?YlvFcYpuD8TeewkH9KzZhjYgtw3/n+uWpMPDxI+5c+pESslj0hj7rDI+bX?=
 =?iso-8859-1?Q?FibeCNh8kGynZnrwnvmXiM1mcbBGqIfmfC6cY3aTbyAK36coxtGOD7HBVH?=
 =?iso-8859-1?Q?m8NF7LBNvd0VHDebOmfJvX+xSjNC10A8RQIudl+xxLLJXXJQUj0FxjryVf?=
 =?iso-8859-1?Q?Twud3xQowcA+dqeQun4mSbnlOIfFk5K4yuIp0PsTLSmjG4N4g1Fo3cXCK7?=
 =?iso-8859-1?Q?ezH0yt8z5L4beo5d8tZzlm1W0/UZ8eDQ/9AMyEZ46twM1cTGe8YFZJJLkj?=
 =?iso-8859-1?Q?iqsFrdTnJH0a8XNiWcDgCYABQvVKkRj1jdeeGLyfJvOsDFiLyEsGa9Tf10?=
 =?iso-8859-1?Q?0jgEiZMKvQajl3jZmnUH8JHbB66JVj1/6u9VHco/IyfsBuR5aVZlwg/TTb?=
 =?iso-8859-1?Q?4OGME4TlfHB9WUgc9vXHKEnGo7vVJV/3XyQn7AFrgQyqeE5QSr2aArtWsX?=
 =?iso-8859-1?Q?ECgOOCTmraDsZKBwlClnakN7jc1rwXO5RZV+Hb8iJ2aA15H33Dv+3kiaEH?=
 =?iso-8859-1?Q?ehiwB3HmROwXEfoYULujr+AzzAJ+/8EN1vzFTMLNmem80NVprznmXtzche?=
 =?iso-8859-1?Q?nO7t6PkJxUPLBUximEjh9A8s487msqSL6SzWck0WTvGUPyV9Vfy7TsxsM8?=
 =?iso-8859-1?Q?QAun1hjkOweHqJwdD2mR4oZwxGRHNnXjyq9d4h4rqUlz+EkoOHakObIwu5?=
 =?iso-8859-1?Q?DwKddt3tuRX2U4hXTlakG4r5ZbKKDQeOhWcA4hLS0zgTGVvqKU2x56/dbj?=
 =?iso-8859-1?Q?eGcu4WHAPV0BSTZmI9SxiUAlGqySC2whMYJ6e0MmDV/WcfVlRCW1q8wcVU?=
 =?iso-8859-1?Q?bgOODCfctk5u1waK7n+JHRjOyHe2DG96zo4jQ6s5vTx30x5hdOzsQ0uUas?=
 =?iso-8859-1?Q?yUZ7rTGPx+KIXnrBRQgvGynhrLNYf//CAHOMdLny4KtJmLPlM4Y8GKqS4K?=
 =?iso-8859-1?Q?MOQW5kPrNmEBO5QL3nHIpO6mYJ3jVD+01xNj24dOg4czNRtdQssF8332KB?=
 =?iso-8859-1?Q?N4h6AdEs28NE8puTWWelpXWocGjQ8XncmlFXsPeQtmluDt3jDzvIPnyB+e?=
 =?iso-8859-1?Q?e9e+6O4hr6OzsubDDNetPedTYsOw9AGWCDxOxtFTYqBK0Wi7PQlbw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc239bd-5161-4371-713f-08d93d703508
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 15:43:58.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgWPYLw0qQvsISFjRuLU+SvYPGxpudDvey6qXyYGjdVY3AgyKolHIOLL/SzJvM1vob08bZMdR45mswM+hu9g9jICku3kqB9/AgYssTZiy8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0037

> By moving default_changed() after=0A=
> =A0=A0=A0=A0=A0=A0 def_service =3D connman_service_get_default();=0A=
>=A0=A0=A0=A0=A0=A0=A0 service_update_preferred_order(def_service, service,=
 new_state);=0A=
>=0A=
> the result is the code doesn't make sense anymore. Why calling=0A=
> service_update_preferred_order *before* we change the default?=0A=
>=0A=
> This is the very reason I am pushing back against these changes. They=0A=
> look innocent and might even work for some cases, but anyone later=0A=
> looking at this code will scratch his head and will say "this doesn't=0A=
> make sense". Also The commit message saying "the default shall be=0A=
> re-evaluated" doesn't help either. You need to explain why you need to=0A=
> change the order and why service_update_preferred_order() should operate=
=0A=
> on the 'outdated' default route.=0A=
Daniel,=0A=
=0A=
I shall admit this part is really complex, with separated updates of the =
=0A=
default service and the service list, so maybe it is not the best choice.=
=0A=
I propose to run my full test campaign again and check for a better solutio=
n=0A=
(or at least to describe the issues I am facing), after the completion of t=
he topic=0A=
"service: Ignore state information in service reordering".=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
