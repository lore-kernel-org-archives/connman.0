Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120041.outbound.protection.outlook.com [40.107.12.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E02C87
	for <connman@lists.linux.dev>; Wed,  6 Oct 2021 12:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuG1DHyNlxVl2cPB8CWvROWtpgeTkoV5P4F/RSBvYlLkJAiUgiaSAm//zuDdAeNAjIgK/0dPaxwYYny0EpJhJHzRkNVQnxbTgqlaTI6ZU0pG8o51TUEtnlNPtIwaWYaT2fxrXxok8a3inOFnjtGskpsfUeVsHhcWcTF2pasBCA4Ps5eyaAdiQ8gr1p6fQ68OndFH3qC9QV+d31Bwvdo4+fstYpZqPT+ByEP8BKO0F+QVvvccTCAp2uMQYXnl4RCb6v6uPdICYfkvEzB8xZOd/7Y74hWqunHhooG1iKAKtsoQiSphRRVacZUnHeB327CM8tCBNRqnJc8OV4ky3/3W0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3qjYhaDdtRzK46vdOm7VCL5OouX1OEWbydWqcG51mo=;
 b=iSwY1faSoj74+9Vr81CisPjE4YVKAAdjML3NuS9ZqkeYTBeqLllYkLY+knDrfibNThbUO3tVLMN4sMpOJKP/Y8mX9w+kMZv2gU51tlnohzcSK2JXDkIux7QjH6UyUGsFkLeQiHQqUKUP8g49TrDa2rQhmgSbYE2N7jxJQDOZ77qz2FYR/ZErCWMXsM+QxrWO0sCHwrwE5CfeIPwIg5G6Fl0nMq/EavhSK58BtQr2pp3ajoK1sjeIdIxCD/Yf7+aGZ9ABEdkNSqfrPokqG807rX+i2PuGSGpRVixR30qaRr+p/z/tC9mcfBKuQ4K9M8KSxNnanKLebsKITPUBx/TpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3qjYhaDdtRzK46vdOm7VCL5OouX1OEWbydWqcG51mo=;
 b=wt82Djg9i6W7mPFeodyki2UoQMGJ/DlohoQ70X4InWfvdWAQA/jaGghzPjQ7ZSi4P35JOswaQRcUMe2bHo2s0/UmCmMtVsy5D0Pza4Efpy8uEtv7tGpOMa2RJgu9DJmRKZaZ5PQ2ug7yRoy+iuM1SuwOU38cttJ8tPk4fldnPhc=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2178.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Wed, 6 Oct 2021 12:44:05 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4587.018; Wed, 6 Oct 2021
 12:44:05 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 2/3] iwd: Connection of hidden networks
Thread-Topic: [PATCH 2/3] iwd: Connection of hidden networks
Thread-Index: AQHXtti10gxY7PlzJkSp8WEWjZ8UV6vCbhsAgAAYHcyAA19PgIAAAnbn
Date: Wed, 6 Oct 2021 12:44:05 +0000
Message-ID:
 <MRZP264MB154456BC4444DD80E9F399BE93B09@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544676D5E67A464DCECB27493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211004070314.ehj6a5wjkhexu4xb@beryllium.lan>
 <MRZP264MB1544E27898924DAB6CBBF9E793AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211006115927.lfqei7bai5slvyup@carbon.fritz.box>
In-Reply-To: <20211006115927.lfqei7bai5slvyup@carbon.fritz.box>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 5ac9bfb5-76a4-8748-9da0-e03e66fc90ca
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d7ebe67-8273-493c-ac7a-08d988c6fba3
x-ms-traffictypediagnostic: MR1P264MB2178:
x-microsoft-antispam-prvs:
 <MR1P264MB21785E5D12BABCBD7456759393B09@MR1P264MB2178.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EsSxyKYWf/EI3vi9vxFEtPSbqghLjDsjtG3iYswigGaEp0+nOQa6SG5THJY/Zs2IMC0FTEnOk8Jsc2SC6ZInxz/Jet407uge7Lp12dmb8g4lJTceOA3ymRYOFcsdIeew4ohwbmJGRB1Zu58ZEnCtNRil2yAIfiWfBFaBPsYu4ssGpwuuOv7FbG1x2S9rXbzcPQCuB9miNX429WJWvq16EEQg3ZAKa7Krhg97lX/aTY6O5ckj6CjAO02C3Qg/WT5yeqLQGouBdjoaFoauhYr7DOGXinepMCHS72eD0phhhB3MFC4/f1LK18kGUdFjbN6aCy3X/oKLF0VTp+a9k+dYOTk49pt3cxzOZntSGMgT68vlDdqYxu4s1u8o9B5xDA9oDFo3GmXzkI/RD/8yypA7cYODqXhaattB/fxTNhG9y6n1X1HZg43Vk7JvhD/lHk3gdNzU+0PnxQQkUh58i6LJhQCSR7c+LDFlBUERvqmTTWnpGz6wISbHVR4dhNOAoFHoiqlWqj7AYK6HDQJ9287qGNogLvrWyWlfWefwE5fxXxvCl31aOB5cOfCIeI3GdE28zDH+TqSQ8i2i+1uIHced7WnrD+0VYM0PttBUQrwwpHh2XBmZVsAS+0rjNCqrPS34NdEmrVwqmeDwpWn/mFgv2wfBZ0uyeQCzGyH0z5oLVWqhuni9n7gxtXWIBChECUKNQU836DQQ/6zj75in3CuMIg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(122000001)(8936002)(6506007)(5660300002)(7696005)(6916009)(38100700002)(316002)(2906002)(38070700005)(71200400001)(83380400001)(64756008)(186003)(55016002)(9686003)(66446008)(33656002)(4326008)(508600001)(66556008)(76116006)(66946007)(66476007)(91956017)(86362001)(4744005)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yOP2cTLYmu46ffQKYWk5uLvtVntOp8Uwd8qAQo0I4XKno9Mb3QKGN6EORb?=
 =?iso-8859-1?Q?v7W8k/LSv4e23YsaJVDA6j6kfWTYYEbk11WS6URai1m0LqxtGBuCzg39I7?=
 =?iso-8859-1?Q?Y4O+yP3zQrPJP06g6fqBdsWILUyIIocro2s6xueUZf+4XL6EpZ+vfqdyBk?=
 =?iso-8859-1?Q?mRsq28ZzaQyG8Kkkcl1y9XpNcveZWDR4Vo0rV2zUXFcDghny0Lcm6Qbn2d?=
 =?iso-8859-1?Q?VyZbMu9dQu/R9o3Ud2L8njXUv6WUQTIOHHosyR1JkiHNG8jaNHsbGVtaCw?=
 =?iso-8859-1?Q?wJiDBRwqdiWFhnJ8GbbTOnJIaU5dPV4tH2K7zyIDIQRpEFkbPgIJC45QRc?=
 =?iso-8859-1?Q?5/I1qkKH7VoQB2NfrM+mW7ZFMI/prrb7IrB1s02JL4tseGWV+3Db+dqxb2?=
 =?iso-8859-1?Q?CM0WsbFpRr2V60i/le9a3f/t0wPt6bVSQL5wKGs8uO/6ABRlT1iC/Ropq8?=
 =?iso-8859-1?Q?uh1iFd5469sUPdlHclEJKPLm794uH0L9J4925IwQm+lCWJA41EG3SaRgmw?=
 =?iso-8859-1?Q?/sQxUBIsYhbdD0e/8SK4rPyyDlZFboBb5fY0GLaUL+8UTF1IcRvwse8Ux8?=
 =?iso-8859-1?Q?KWC5a+3Oy+H8feQCXBO+G83i+7vVLhGtQQTDVp89m069ezWK7YC2it0xDW?=
 =?iso-8859-1?Q?wuXJ9O2WG6fdIU1IBIWrdgoQF70g4UpCgcW0vw6ywT1/nDg0b5ikgtE4Uu?=
 =?iso-8859-1?Q?7plLFAtcpo1efbN9B8ZoqCCU9eUoFDCgTPzqwHZsAFidEBuYZOOH/1zuqZ?=
 =?iso-8859-1?Q?kBvBNxHAYeJNoS3Tx5X3al+60wjZUDTlHSz8WF1QPQqA/VjoDdRcyogDS1?=
 =?iso-8859-1?Q?tFX8qvusCPbwL9VGmK+eWtN9oMId4zqXS72Vm8chnU1X338JDVr20fjkmh?=
 =?iso-8859-1?Q?lQwNiQQtFMuQlOwc9yTVQHLeRohznM9lS7rEd1/Gjpvn3KM7Aw4qoq0SXb?=
 =?iso-8859-1?Q?swUrWNthGk3ajpSKAGU1jW/PhGhW8udf7EDPo1u0vWMPgmoSNRhkE2KgM8?=
 =?iso-8859-1?Q?08Wpd21K09wPAjbicSem+OQYoHLJJscEy9H1C6xRaAU4U1l1RqjbdiwZzN?=
 =?iso-8859-1?Q?v8mEiNVhMCWPZz5dCrvTbHtZkJ8h4kdP5XPRrqybWczQBF9NeB8EASjmX+?=
 =?iso-8859-1?Q?bgxvBFmS7Z4JM1kGa7GUa9px2/ivdK7Nwhj3e5TL3rgpfn3OS3nR32UNOj?=
 =?iso-8859-1?Q?VHSRq77jA09k/+VmTj7yEHHcTIkvVaVsZGRPIRkRW15FQAbrWxqKapTl25?=
 =?iso-8859-1?Q?FBnyIl9uCtn++JhJUh5WmNYnap6U+pVS4ANc+bjWygo5Ebj1fg4xX9jvmF?=
 =?iso-8859-1?Q?6kjEtX9xNHVeynpjNnbJqKo3bx1MKc1lAA9oKQEJwesbgYw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7ebe67-8273-493c-ac7a-08d988c6fba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 12:44:05.5519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gH3UfVAWMhq4cNp3Afdty2QsX1pUffzYgNEA/fwE+Pk4rV2bEpcERA9cC7snyg4LId3PVvm1GBzBqS1X5IucZ2scGqWWElYK4ZS0RqysKec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2178

Hi Daniel,=0A=
=0A=
> Please send them as new patch. Thanks.=0A=
Do you mean I should version the updated patches I have just sent back?=0A=
=0A=
> In this case, why do you not release the resources associated with the=0A=
> pointer? Isn't this a leak?=0A=
I don't think so. It is done via the hidden_params_free(), given as argumen=
t of=0A=
g_dbus_proxy_method_call().=0A=
But I shall replace the g_free in station_free() by hidden_params_free.=0A=
=0A=
Emmanuel=
