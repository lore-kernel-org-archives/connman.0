Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2045.outbound.protection.outlook.com [40.107.9.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF5E5388
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 09:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJspRWYlIQ+UQFLndo3My2rQMJgdYNGfkM2GGA8NqDFpvo1Kgoep5lRraPH9/DyNLkSu1tdw/B0M2ztNJLiMPffV4OMrN1eMRAoigFHzxaGnChJiqAl6QGlZvV7RbTLjDpMv+Y53e9mTLdF4Bzcr0Nj2CoGCTsy/29kS23pFjhSrMnaYs7wg1A5t4QRIsJgQwSTlar/kI7vHk4xTdCWADMJXPa9Xdhdu65UMbLSXseNjgAAZYJtJ36sKITlWpQE06pGA4V1E0ExWWAxkVxousyV5sEqB3s+rPRXHukGZZuTgKFNF+My+z7oVJVFkX3IWVsTfX35rHXANjHwGZNMBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxihWtiIvlhMGsKeT4BvwwVF2P5Vi6vQcL45I6skjLE=;
 b=GIMAg+IiZatYndh2zcsUimWc/18vUvw5NXUHnXGzmxhCk5vXaBCS8BgTyJH2tSp6Q22koFutrODKQt2qAxNqNv1hWFrDPe2UXz5AzXu+XL/Y3cGqpwxS4Bq1Ju5uGvYDOgO4F2B/uwtuOmiFTr56CcQ9lhAjx+iJ3dzVt79CHLGddeZjUZk3W0u5HcgO3/FMPBUPIAI+fN4QR0ttiCgs+xQWjDAh+pRnDYOJs65ExT5X1ZFZrVw4nukm2UteMDMo9XLxcX0mo8C+611Ulv00PwJk/C3pXW8UHrLf7AhvlpyJcbKO91snX8a23PPKFmz9BIjMTFbMe3Lac80LaE8bVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxihWtiIvlhMGsKeT4BvwwVF2P5Vi6vQcL45I6skjLE=;
 b=l0WuqShXw7WaPrB5CSGQNWJhZZWjRJo0JxzgokIPsQW7RY1joF76J9EXFCf9HlaAUbW0Iuc4w3H6xbCMDlt+3UwH1O71es9X3lS7IzAmmosQRniaama1S+83GamECOY98ScQT9/NZuBGSgs0QH4ng2ibx7g+2FaqULuAyN77JjA=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PAZP264MB1429.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:18b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Tue, 11 Apr 2023 09:00:50 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1ef8:75d8:fe61:d234]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1ef8:75d8:fe61:d234%4]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 09:00:50 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix hidden service with wrong passphrase
Thread-Topic: [PATCH] service: Fix hidden service with wrong passphrase
Thread-Index: AQHZSs9pXH19TjmI8kerwyJNS+e/Dq8l+LQAgAAWvDw=
Date: Tue, 11 Apr 2023 09:00:50 +0000
Message-ID:
 <MRZP264MB1544BE29A8F963CDA91BBE99939A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB154400DDFBFE8E6BE89E250193AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20230411072808.nkxk6iprmgp6jlnz@beryllium.lan>
In-Reply-To: <20230411072808.nkxk6iprmgp6jlnz@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB1544:EE_|PAZP264MB1429:EE_
x-ms-office365-filtering-correlation-id: 638661e1-dcd3-41d1-e148-08db3a6b3fa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BrARnlZy+kGeWmLP/uusM9/GPiaYDddXuc8R8RV4lZhs/sZpexTsmZtPp2YpLlnkYCQBKHUdVpogqcwDrpivPMzuXaDset8hYhjdVrhrnQUtgjn6WmlCIalcCHjzATPbJii8U82lpCvb8ToiaSWuy+VO41TttJpm3vK+InRe2lXxbGk595xN2PNR4sIYU0S7xMoENz/Nxld8973/xM4TcxGr0HWX7t/KlD4aR1OOEJU/g1ieRz5dWjSZ76rMsVG+U1BKwd+3W2kwOb3CmNJcBWL+hMhf2e9SJuTad0YMV5l6SA9Jx2pDr5neDNj6Aob7VmPDxnpEUv6kgLnZOTlkLvDtT9Y3gGS6rtoyU21wSxDIb1eXaZHmh96IAAsrQ5GrRHJraU9Q/YeYs18JCrzn1f9OHBs4gRLbLVFsFddyLVLNbK9F4rd9eBfJxmZ+lZS9zN89jax0G2zUwkSOFNK5gvZLr4DzDOvYwCRFc+gbyHGEldk9WkkqmF6WMDBviqB+osCPpUY14WQv46O1jEgjwEOHS7LxM4s4FETnJH32xynUMGxfd5Ygyfqn3D9VyTfTyCn7KIcfAMH/V+KeWbX3gp0DfH3VXA6mZ/K1TiofvUWNWkXBRyoBCDRXgh6DKYvE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(71200400001)(7696005)(478600001)(316002)(9686003)(6506007)(186003)(91956017)(4744005)(2906002)(5660300002)(66946007)(76116006)(66446008)(41300700001)(8676002)(6916009)(66476007)(64756008)(52536014)(8936002)(66556008)(38100700002)(122000001)(86362001)(55016003)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CZFHgtjbuKeHgNr7fYYTsGROeFCk7zQ5k5H9h0+XrD63nkFCwN9WAOKnuD?=
 =?iso-8859-1?Q?hi4vT3YcX68Sk/8IjGdtcycvp9PIiTc/6mNzmbUOvxPONyJ9vfsJ0WJh4s?=
 =?iso-8859-1?Q?bAEg2AUYm0LrhnKqy2dRkEJA11JXM3aN6f4ds4mIBqLZFS6wXSaCYDMawB?=
 =?iso-8859-1?Q?A8/aSMvnfv9MyDf5uxJjmb2S5BTR7MkiK1y51hSrbEXSf80AyXNojtUh1g?=
 =?iso-8859-1?Q?v4vtophJRDSbKmIC+eWzThwsPZrHElAUECWap02U8tGHordR3E7feR0j+u?=
 =?iso-8859-1?Q?HdmCQAMjMv6rPbcLZs30k6mZEw74jEy8YrLBnWJsGRvLkW1mA2qVBN8saV?=
 =?iso-8859-1?Q?PuvVaZOhqAHA8DeQJ/WfHK85/ygexvxEwSP5GIVfKlbokpYIGdLMR14YTf?=
 =?iso-8859-1?Q?/o4xwhOIWWf3mkXc6ibBZUhNB7XfN8QNqMrkJtt/nPExd08ACT7UEpkOmR?=
 =?iso-8859-1?Q?JLjwl28Xp8gFN+pEToksSSsjrEvE1bEy4kyZhIpFOqjqq/EJ1Jq8NY538X?=
 =?iso-8859-1?Q?NZuYS93aRTocad6VJW9uqt35OV9snxKOq/MDYZnCVog4uekOtkLkHLbBym?=
 =?iso-8859-1?Q?oALAumHqBp/2lnahJMnBfn34jxWQu+elxhxvEdqieEbkfgefvfUICAMCPZ?=
 =?iso-8859-1?Q?EPQf+TcV3zDZgJKnu1oVuF0iBsHkoB5DuTQ15USHNvu/tihYv06bPbvJIT?=
 =?iso-8859-1?Q?rQyvFD1oPAImD7gOobqbx1YLxa+DSHSI3JuCR7GxzWYRWGyXIiJUxpmzsU?=
 =?iso-8859-1?Q?x2x2st6FGq2De9o9sg0KFfrwCGuQpqrG8sapODBiQNas9VuNE44lV2jUzd?=
 =?iso-8859-1?Q?wFAAiKlZYSf3jPQgniUEnKxOBFYtFPLT/HPc7BuQOuvNIRbmz3MzHBjGXA?=
 =?iso-8859-1?Q?7JaP1QS/KDQqjVKufi7ck2c/nF3iqCMcL/rxdrfAr3uHnNSFnyZWtR/atg?=
 =?iso-8859-1?Q?fZA75RkRhcJEg/3ajNYCuA+DhiNw4hy+dmsQd6EEEMrKSa9/aD1zLZW5uz?=
 =?iso-8859-1?Q?SxdFwUTR/Sxs02ds7+5DYn2bzdx5HBGUNeAj3dqN2vKLik7/2zAsb8Ndca?=
 =?iso-8859-1?Q?J3uFVuPPyn+V0hEzkvnwCDmvdqUqJOVcOEj8thCoMA4VQmskL/VCKuhh5q?=
 =?iso-8859-1?Q?Kne9Z3YgN0AuseI6tiHzdNWSIhThoxX2yGN3cVH0oIADdXw+rDK9/k2j/F?=
 =?iso-8859-1?Q?v4IUnVbWBUYQoOUb7UtvDXQ92GU/sQiJJ44Z0ZzV6bnhfL3gX02lsvfd/h?=
 =?iso-8859-1?Q?PdtFU9RksQu072nuDEccmESJ93iCLhbiI6g3qPOOBVmm+kHjxT6ChJNRYP?=
 =?iso-8859-1?Q?BBUpPKobp9oQp2khfXht+C/4Y67LZxMJJToOhBh2UUJ6xm1lM5GAvtvYVy?=
 =?iso-8859-1?Q?cWCRSTfImth+7TmK9/0QJ5MlkkrQO36Q3mRUl8XPz7q75KA9xIYi/JxElY?=
 =?iso-8859-1?Q?SUIn7QmWSd9/O2xLmJTD49+vEwmEksHMCOV0xd9MIjLEuvaB9cYwxcljJU?=
 =?iso-8859-1?Q?vbtY6oanIYSEpU3XLJVQu8KYVxpVt/Qzh5uvlpz40hjSO51ZxO7YHgUC/r?=
 =?iso-8859-1?Q?9ppDaTFeObAxOoMDOz/vM4fJVRHpaYVI4D+y/JYbZDHaaz5EDjeHu/cRia?=
 =?iso-8859-1?Q?vjFee7o6nQSX9PkuGnbnBtvd8uAWlowA4b9e6OpYpAC1lPrUzMyjriCqNd?=
 =?iso-8859-1?Q?370cKnCz/TDiEJCDMyybcSKtuuRuh8ftzvrKgjrhyevzKITtbgpNDzbgW+?=
 =?iso-8859-1?Q?RzZw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 638661e1-dcd3-41d1-e148-08db3a6b3fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 09:00:50.6393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqNqcoHLb5/1DsqbngffgAcf0un/GAgGVkhfBN1Jz73RaMHZKQ1VEH2khBrrRaAVWxSHqRwIYNd+s0dQGSbC07bVHyP3l7kSW45biagDA/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB1429

Hi Daniel,=0A=
=0A=
Thank you spending time integrating my patches.=0A=
=0A=
> This should be handled by the caller of the set function. We are already =
doing=0A=
> this, so please move this part also there.=0A=
=0A=
Do you mean callers of __connman_service_set_passphrase()?=0A=
The problem is that there are 4 calls to __connman_service_set_passphrase:=
=0A=
1759  src/network.c <<connman_network_connect_hidden>>=0A=
             err =3D __connman_service_set_passphrase(service, passphrase);=
=0A=
5728  src/service.c <<__connman_service_set_string>>=0A=
             __connman_service_set_passphrase(service, value);=0A=
5873  src/service.c <<request_input_cb>>=0A=
             err =3D __connman_service_set_passphrase(service, passphrase);=
=0A=
6103  src/service.c <<service_indicate_state>>=0A=
             __connman_service_set_passphrase(service, pass);=0A=
=0A=
Moreover, in network.c, connman_service is opaque, so it is not possible th=
ere.=0A=
But maybe I have misunderstood your proposal.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
