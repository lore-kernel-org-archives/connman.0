Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF13FC0
	for <connman@lists.linux.dev>; Wed, 25 Aug 2021 12:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHl/+ZxctaxmSqoSqM/0aDF92iMmEUyY4z/ZW6g36w2Rdv4lRxN4pML24FNpQ8CKHD1YNhoQFosNPe7MTj9nib/61Rgn8Z/JFJi86Cv2gUit+cRvTR/Z9qnZxzVU35W0JUNECbG5paJDN3XjPkpsIy0+6BRucvZIlnsF4ufkNEW/dq7wT6IeXVwlMcSQlajZ1z1eTeu6T5i4pbrkoSEU5r7yCTffsR4GSRmZgAHhTD27ksixkxg2gFibGAr/yvkOnpfSjL7OGObRauq78f91A989AjSQg3RE/1LO0Q8xYo4JwqwRQYlfAN+Sa4DnnzUXLeO9IGB8YYZcpYTUbK9WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RymuNeVJTMmQ3kAIgujZRwW0ff/WsqV59uyctQRu0SI=;
 b=R6otor/5a9WxSjUvjMzv+Hq3eNarfIEiNd6W30lqHIlW1ulZ9rRRMVan9Ju8taA/Pgjbqc/vi/FkpzryPjYQdsU6G8fIlseG5tL7Cwe7uAivRM4B7gFHtzVLaZFDAxAgNkwmsEYzJFEEkglFEsAlEAk4PcmiMOYRqSq1BZbw1Gw7Ex1mYoopDQzPGqkBCSF840yobT1K4f4zQgtYfUXPVGAUdpTnvjuXuJRcDE7oCyUeJEdRV8h4AUufJiFT6BPbZp5f8jQhU8MPsnnZR8zy8yd2TGtI0x/DaAAl2CQzvAKKW99pToNKwNgOo39DFbVi34hE3RWptf7qFp/y/qOL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RymuNeVJTMmQ3kAIgujZRwW0ff/WsqV59uyctQRu0SI=;
 b=ZX15R9REssfmGC+A2+0A347tC1EmU4AtTxyRUtG3/A/biXDnxEZp//26q67O/ZIwYcbGJRqzJLEo7MFIeRF2D8P7Z3evvYy+89CDBPP0Fm9lAF2f1ts632ZalwC0wkQTzmaFQl6VTmTu3QCb753wLAheFdKUctEm9LF3xBXxU7A=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRXP264MB0312.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:16::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Wed, 25 Aug 2021 12:52:24 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d7f:ca70:4ec:896b]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d7f:ca70:4ec:896b%6]) with mapi id 15.20.4436.026; Wed, 25 Aug 2021
 12:52:24 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix default service update on ready state
Thread-Topic: [PATCH] service: Fix default service update on ready state
Thread-Index:
 AQHXaCl3q3yULm0o6kitbLJsUjipmqsiz8KAgAAOuVeADHiAgIAAA+gAgACAkXiAVLNsAw==
Date: Wed, 25 Aug 2021 12:52:24 +0000
Message-ID:
 <MRZP264MB15440F82FD624796E8AB394393C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210624080757.722whwmmwrnzffvb@beryllium.lan>
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>,<20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
 <MRZP264MB154494B92E616DB754E5F46A931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To:
 <MRZP264MB154494B92E616DB754E5F46A931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae1593a9-b571-4bd3-4861-08d967c72fac
x-ms-traffictypediagnostic: MRXP264MB0312:
x-microsoft-antispam-prvs:
 <MRXP264MB031293FFA2DEA6467C5F99C093C69@MRXP264MB0312.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hvrLQAHj825ae8wAe6LLPGRG1THTy3MXOP9APTqxfS+TWHx5LZF9DeX3ch2IzzU4Ag3/VLcP65MjH47GSY+5t+iLGhOO3cJZtgCcFwLVdnqHhInMe7k223iNvFsaYLqDpA51KL7NWbx8aYNme2qh3qyXg8L/0pJJKtrB1zmHWQra+zJnMsdbtXaeRpkGRL7niwxz5z1bYY3iAbhhFedtouzj8dq8/Bi6ICYrKUlPTxOj8YKwPXhAN1PfPGuDNjxQEnUrTkpBfH1RfeDVeUYcXc5+yEyrMhYT5SIIK6WgGlOw2URWh9PAJEp0DYKS+oXX5rlWRiVVOH86RkGx+gRieWa6jfDOxTpRZjEvnITtQfzyupjxiXdGMQ2hM8MLZYTGrGa2smFN9abYLFQV3xYeNUoimIqhn8zIcViGv1xgrsSXzKTXrZ/rT5wKD57iGmV9czsWA0LQaxb4TDDeE4HdYbjBAHu9gzAuHRghL6pfEAEFT5uxxvaNHeofcIS2UIhadgFUTIKcUfEQYbNjI92I5+Hgd5j0zMgrQ9LlcFnSKrC5+jQSCmzYR7eDpEnGALLGSXzwyXEreKrIvSD0curIUbMazEXR9YLSQ7SYNHzIzh0IPpW4RKb4yDKB4BJzuaXtr7MhAmwKH3PmSb3DuVM4VDHUTh0vfrZANSB1swM9bigZdOsMVgFDCyo516Pt+vntJCsRMzQJA65ounTFnI600Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(26005)(83380400001)(38070700005)(2906002)(316002)(4744005)(122000001)(7696005)(4326008)(6506007)(38100700002)(52536014)(6916009)(71200400001)(86362001)(8936002)(8676002)(5660300002)(9686003)(55016002)(66446008)(64756008)(66556008)(66476007)(66946007)(508600001)(76116006)(91956017)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Pho3Pz4tCK+uYH0FnsTp27cZTG7VUX5nesmS4FCx2U+Th57CWqkETgiVIC?=
 =?iso-8859-1?Q?VeGvl/l4yyKRu3T/lnuGUClPt5Si2TNHsqbwepRNMfnWV4qWwMRnOIsr7s?=
 =?iso-8859-1?Q?4Kq9a6SqDoWSJNqekc6aFysu/2NqegNGGyp9bFIcqxiLVGmLrFiV8NqAgr?=
 =?iso-8859-1?Q?t4vv8qwnHi9XrTxbEFi2ph0rfEfUFs9nyXPz0nl5PRsrV5pse10MAEohL4?=
 =?iso-8859-1?Q?u1C9z7KuJDQtIWyTwoq+sdLxBpr5D60t9G3L+XUV7jNg+M1sbAcOtrg4Ek?=
 =?iso-8859-1?Q?Qyq7B9Ksarg9Ycb1VmmF1ZQLqGliw0mIW/ecv8N7DQSXLekXWQKZcpnkT+?=
 =?iso-8859-1?Q?6BAh5bcMl/pRPbD05iToqf0cKWS85onhLSQJHfgzQ2ZhIsY7eoYvUmOMIf?=
 =?iso-8859-1?Q?d81Y6tOs6xflTS1o4IrxplI4VvsPtYnqH5tbzq05nmv+0sRI/pgJD1Wv7r?=
 =?iso-8859-1?Q?68rwS7YjURhmfIHlullezArttkZuoar7zJeQbSwIP5n9xMA5dpl3OxJw+z?=
 =?iso-8859-1?Q?6AOH3/rPy6je+gfwLhahbW1MD8NLmGluisMr1aSfP1sz9MuSPlrGnfTfGw?=
 =?iso-8859-1?Q?UsQvXis6kJS5T2Qomke+hguMLllayWMrJeH+4aI5cLknT2yVT03VH4KTQa?=
 =?iso-8859-1?Q?VO4TW/bNpCHvii2WiaNg/g6pgSlCJKJSTmZCgazXX3jRGpc5/vlNQpGPTT?=
 =?iso-8859-1?Q?zkrMTqcsvohnTICz95GY/ByQsXXEOiK5nK7lMRqNfR2sS63PxDFeRWHlJR?=
 =?iso-8859-1?Q?yLHeLxvnXGvhUQijl5ddfeJl5N8onXJAFepvNW18En3TeehGQvWmxAzwb2?=
 =?iso-8859-1?Q?kX/Ru7QpImsBCUWKp9bkyI78HrOQ7eo+r4rXEEgvr5o0RTQ4RT+qadTyzx?=
 =?iso-8859-1?Q?Cruv3RhPyNg6lIlizAvXOmmiPkNefeXBL6PlBjUvzB3RBwOJ1KHUfBU1E+?=
 =?iso-8859-1?Q?bvnTmqqLvg1yM33MviU6moz5qYeReGB20DQdPC98nt0vRq9bv7rAbYD3xD?=
 =?iso-8859-1?Q?qEqWqm8Uy9O3ZfSsEunya1Fz0hTpnB/qE65eqmDoZhnbdFqVhZf7sgZbP1?=
 =?iso-8859-1?Q?bzs6cAJjDBpcb3/331VdyDte4+GggYf4TwawtPrHwD8UBBAS55hNq9zwy7?=
 =?iso-8859-1?Q?pEHnXPp0nF+RXXN948JjLNy/ARWMh2myQORCFj6XXYidiP/N9+noVnc/Ev?=
 =?iso-8859-1?Q?ykRdPM315rgwPwEChew/ueXeDDF97JVRYHcL1BsqHVYafAvq2bxKEHE09B?=
 =?iso-8859-1?Q?2OtbRH9+2vk6lTKdDN+8tn1dHluUHgc3p6qR1nL2lyhuGjPTEKJeZUyQV9?=
 =?iso-8859-1?Q?lWM201vjPjeBoQF2abWtougJbFlvb2Te7yvqdSh/Toy1NT+Z92tobXUAHb?=
 =?iso-8859-1?Q?DjpvilfW8g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1593a9-b571-4bd3-4861-08d967c72fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 12:52:24.4403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaaOVhMacslDBPmRps8ogvXaln730osekt8fbTUOf3G5f+622AjbRULqDQziM2PZd0Ac54DVW78FF2LnOyckrWYcaCyLSgs/TJUtaH+rPhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0312

Hi Daniel,=0A=
=0A=
> I propose to run my full test campaign again and check for a better solut=
ion=0A=
> (or at least to describe the issues I am facing), after the completion of=
 the topic=0A=
> "service: Ignore state information in service reordering".=0A=
I confirm this patch is still necessary, and still makes sense.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
