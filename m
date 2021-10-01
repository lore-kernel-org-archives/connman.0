Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90055.outbound.protection.outlook.com [40.107.9.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7A2F80
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 15:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9aeKI7if7MppXs6pW6mu+7c0QKCtzwYy4Yj++zvyxjB/G43QZ0GQWyb3/vu34e4Dqg1R174RYFfT4wukoxQF8nj3zvUotpJ7vyTGKyfAraMpcFFazOKE09GUz62g8/vJyfM9ex8OmUeLlGwud/8VNV9rXXsP9XhL8eYvLoImOyZNWQLmW14zHzJO7JKBM6+lU6XCA62RttweyWYN6UZnG5ZDGSriAjc3fYcbSIMD+WHyCafg733dhp1nF9XkcAIIuohJbFZSMdCDLhmiMlSVDzXSmjvdTfrCzU83EFRf1PTRB0O7QPgKLCtghEoEKDszMbn8B5kGWOWWyY7Nw8gQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfym3JriPCJwzxybSxjJGxxh4SVTLAXET7NXGDMi/Ns=;
 b=YYOPj+8P16OeVwAgceRUumVWjW67iKCRbsLr66fdHlLNKMFp6/FR3/BelHBZhkzLdF5bUrSOhjI/3KolGOEjpG286g6LSiHoM1/fkOjlTX1MluJWnRVqI7Q4h/lYgvBhhKfI3CDs64WEuGHtmQvrJ30+Y4cpzKvNkQmn3FlddSK7bkuwdm63DRwO/EkDtpoNLrVEzPN0kXVaWYHB+Wk+V/YiDeBn5BfI/iHvh8FbxOSBsvglIZ4qEQoTavHcCQ0XuqBp2TVv57v/5/7vPKjWYRcXSPDTIIAko7YiM3BFwRYSR4duiVELMfKiohgnGMwOCEF0tzNB0iiYGHWbg6zrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfym3JriPCJwzxybSxjJGxxh4SVTLAXET7NXGDMi/Ns=;
 b=YfTCAmBc8vdIlypQAHxJmi546cBS60stK/90Gy2DrkNUHEY+zDyJKpEKsoYRdbSyaw84GH+TAp8ezjaWfRkbjPTihnquBrsXm47CT0gSM9PPnH1E33BZ4W4yUNv3DNWb9dn8ZTjYVQLZj/+1tFpQ3Wi7/MEAElWZpNMogA9Wnew=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2135.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Fri, 1 Oct 2021 15:32:28 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 15:32:28 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Fix missing Ethernet attributes
Thread-Topic: [PATCH] iwd: Fix missing Ethernet attributes
Thread-Index: AQHXtr0zj4eFWvbcdUqNbSuyQwaOlau+IvAAgAAB5g6AAAR9gIAAG8mT
Date: Fri, 1 Oct 2021 15:32:28 +0000
Message-ID:
 <MRZP264MB1544E1FC92DA49A2076ED3AF93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544A93191E9041F8D1C61C393AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uwnCvrffN6go_BwM0oOMGM+OZ=EucuV_OnifnmGQ+XE3kQ@mail.gmail.com>
 <MRZP264MB1544DC6779714C03B90848E993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uw=tibsuwk=-TnML2+Ltfd7g_SmUKdrFLX4-OgGtctHUCA@mail.gmail.com>
In-Reply-To:
 <CAOf5uw=tibsuwk=-TnML2+Ltfd7g_SmUKdrFLX4-OgGtctHUCA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 374b430c-487d-0bde-0ac1-e19095dc64c3
authentication-results: amarulasolutions.com; dkim=none (message not signed)
 header.d=none;amarulasolutions.com; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bec7a9b1-4150-4542-3477-08d984f0ad80
x-ms-traffictypediagnostic: MRZP264MB2135:
x-microsoft-antispam-prvs:
 <MRZP264MB21351F65603798B01A00F2E993AB9@MRZP264MB2135.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iTrHMu4AgLiq/akyCsK9vUofxLrRAMFFnoPfbeGfFm6ftkSnK0RMxlxXvTFStvZ+2RcG/8P3CX23FNsBWsMaMinD/y/0YWrcMvjl98XLwdHbI/n4hKvHof/scbtekO7YwrwjFpC39UQfnz9Sz2KqHYn1QRvQmVQfTsSG70ln8qzjMCW+k9eqTue0A/yb3kUG+gzJCwBfarthju58gQnqwznY61tWCMqekxnw4XzJkPDWgrDaZE9VWK0xVzsAASav6NYmBqb5x12H2ovrH0ugYknYLYThom0HSq9eQV/3xt7W0Fi8ya94iO+OrFIud3l2juB4fwsnNL0PXwXL3bGfQJjy7qxwrdi46WsOlcyNyRRQaJxxNDl3qlCf6aCDUW+J/orDeALffDukX/G4CLkl6IkcXtaL9c+uCB7OW8Cj316Db9HeQQJOpzmVCvyzCxaEAXh3EBN6TeiSw7NopeCwmOeOZihHNbRH9a1D9fKUKs9Zl0RwoJJah+hzBS9y2jfGmSg7q87Sjslv3nDRMq4QshIiqTQZubY6onIMdhgbZSx5FT3XTUUAMzY8QSzi2PjfmYZUzKE3gxaRGXrwMmRZy6RtVxScQ9y6C6pluLfo8/g/faDPfKsnCciXLUG7YsPRQWQ2I08SSIcMa9l1AtTmOUJY+m4FVYy+azvA8Aj4oWk/mJ8IVl3T3zt+nHSo9sZFewVZ9bA3JtImWk8aBsAIgA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(4326008)(26005)(2906002)(55016002)(186003)(9686003)(5660300002)(316002)(52536014)(8676002)(66446008)(508600001)(64756008)(66556008)(86362001)(38070700005)(33656002)(7696005)(66946007)(6506007)(66476007)(8936002)(558084003)(76116006)(91956017)(38100700002)(6916009)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RoNaaoHko2ec0XV0lc1kYa0gj3A2WlfLkOIww+ul79ObPkR1RaoUqthU7M?=
 =?iso-8859-1?Q?AKyMCa+PvXV2NbCkb5hlvzDAZXMNOMib1TGSiVRQxPXTWXKfeXQPz/NTby?=
 =?iso-8859-1?Q?I1HfoTtOpVeaZcnNdY20KemSTxNqzTV5nKs58Feg2TdBX510ZZ7p1Kh2xv?=
 =?iso-8859-1?Q?pSml8Ravl5q5uxmzAQsIFSbkQPCCzJ1KSj2NTZvg+M6bWvMR8l1yoogWZw?=
 =?iso-8859-1?Q?2J0sJ7CPrsKYLm/XHEsglhqGPTRtLSblUw1RrN+J+hUSOyiiBvyagoVwyu?=
 =?iso-8859-1?Q?vJZ03yDYTIwylhAkn7qs0HQpRnwpYAXgWrkuRLokA0BrL12UfLb/w6JqvC?=
 =?iso-8859-1?Q?qDdkzwI2QVQBnVWy8LaTRLPiVkug0SqFeRyNs1MbBxyAtGar/GZUbP48xO?=
 =?iso-8859-1?Q?kaHKiiriVYy76PCtrzAPHLqrSoFxr6M++wYmHogIP/t5IzoybN8+5HzBZg?=
 =?iso-8859-1?Q?ujCWsRF9Gkq8CVAMghQbVtDnqnEq21qrSooB53VeRpMAcOWo3QHjFvLFhg?=
 =?iso-8859-1?Q?GsWDIOBrvpZ4OfpZJTjgd4FDcDVbmJ/ItFnrYczMQgEPeOFiAhgoCvtZeB?=
 =?iso-8859-1?Q?xsF54allWz3JOj5Q2fIl1gQo4J0TTQyLndMaKmHYI+RTkwyj23JIri+a/O?=
 =?iso-8859-1?Q?fQxScJOgryhNZC6/WE8lys9ip+7Ak5C7dh/J+9MXkjzy5/jQFYJW+16MPx?=
 =?iso-8859-1?Q?GnWT7t6MzuGk0/+MSyI4MhLlSEt7bzlp5bSribL9Gu1ABleVcfPmDD46qV?=
 =?iso-8859-1?Q?NoCPlbVi1g6gMXS1EjSWdvGZ0AVAF+tzOv0PLDIe6oLvCFlNIlysaq9b/w?=
 =?iso-8859-1?Q?uVsZpw6iJ2FRLg+NPSFnA9IYbST3EZFt0XSmAIcWRuBcuPT1jNk4CgM5T8?=
 =?iso-8859-1?Q?uPcEZDtqHuN+ULmsTJc108pToozogRG3E7lithMKhi8QeKIOFzKhS8glei?=
 =?iso-8859-1?Q?/h7aCGwiav3dVrZEelesHMIlEbMip49a42yWJHqDI7POAO2XnYsN2LynPm?=
 =?iso-8859-1?Q?gbZVJ3sK5yLDSH1CvHDc1x/ES2A8SAXAxfQi4WPI2+DLQqqzZWqNMHna1e?=
 =?iso-8859-1?Q?ySVJnOqmK1SRuqkGfSqu1ROYlT/ZgCyL774vgZMB8PD32jwRRhXjZod71x?=
 =?iso-8859-1?Q?4Y8cq8P1B79uflmJpeEuckmchnSc2F1+2Z0nfNR2V0ADVDRX6oT36KXFDz?=
 =?iso-8859-1?Q?0xVi1lpqIRjdoCc1jXJDcTbYd7GJXUQIg3dnuJpuVB7W/qEBa00obLs1T3?=
 =?iso-8859-1?Q?i4scBODywZh4VHk4L/QKupxVZhzml94UFIq8RGkyEy8CrsE5W6RJet/6kr?=
 =?iso-8859-1?Q?puDgoGS5z9g/hMVOmC176tFis5uHXA9Vat6SzHUE5QrxBi0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bec7a9b1-4150-4542-3477-08d984f0ad80
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 15:32:28.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHt6KSUF6sQZE2vMZZjrWohyxTfLobIZ8HPadKpr2Jmx9nbaBmEHtaZhdhPXiKwTOzIDC+h8nQ4Ugtm0lsqNvKiI4RNuO0c+0KQI0udwR6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2135

> Doing the same, at the moment ;). For another project.=0A=
I have finished sending my patches, I hope it will help your integration.=
