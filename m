Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120059.outbound.protection.outlook.com [40.107.12.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB302C80
	for <connman@lists.linux.dev>; Wed, 20 Oct 2021 14:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krJTC8WVHCkhT8ceIuEYfN84oDg7Yo2vLq9GH/53rBx9v3+lh1Doq2J2aCz3red8IUYny61KBWWhcPznOZjkSHEtaQhEEgWJXqoVJYTYoi3HzpP1+s6g8iom4mKQxAlzWyOkLP1EC1eJM9ED7xI9Wq6aaXvpVO+x7irLFHls/NtTUiO/nCwAwduUfNVZncXh5CFppBBa79DPWjMmtLZbU031cBC7YUoG8c4/JpgiG15GOMtlAJDc+VTVka8HVLakoHhptU5XmKviflRmOkWpuCW9R8FFypMRC1hdILF7Ch3OnX/FbafgT51sotQ2gcCLmUzKzYLPk5QZTTqwHHMSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p89Bo3u7Mecm3XsrXa7I4/ZZ0Rq/sB37AGpMmSL3/jY=;
 b=VcJDrvztIceLgyHg4K1beLfzQTKJ3ma6bldE3NDgqoHkT4uPWA+ZaPTG4FsgNy+/tCDcQ3M8yHpHOmTwncdIlNRFcJnDiw3jzT58YAU++yUnGu1igDqLdEYv9EX376nwEzH4xHVDS8RZP/Swg4L2Py8A0U4ObdMl/1Edy0HShWHm2qk75q7KxDoxWbSpolqRc8gYietsCctj1Do/QneZh7TdTPYVUXwx9VHAcXRHUeC5xg+4RDvouGH18jWrNvVkJXH/TKPdyXu+cFEMdKSwqTNydcUXB+plNATqVp4WEvmwKhN5Lm8tG5JO69M6SpMUloch0rNIxHNwaU/cUdchSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p89Bo3u7Mecm3XsrXa7I4/ZZ0Rq/sB37AGpMmSL3/jY=;
 b=nDv49GF5UKNcJW3pNPrVRBKIk57rphR2nXbwOzfVJb5CSsJGIdC+w+GwIwfNpZgRLQdWWmiBEwc06YL9v7vokomWy2KD62dehBYqlvpu37NKDaCqN+q8qBz2JZ0FII/15c8r65IGKVYIAzl+9N3H/AjWw8XMfqfrXw+9BlqnkM4=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2179.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Wed, 20 Oct 2021 14:31:54 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 14:31:54 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 1/3] build: Cleanup of iwd provision_service_wifi()
Thread-Topic: [PATCH 1/3] build: Cleanup of iwd provision_service_wifi()
Thread-Index: AQHXw/h91UCkud5Je0CJGuUzZyM0U6vbac0AgAABYoCAAIaXKQ==
Date: Wed, 20 Oct 2021 14:31:54 +0000
Message-ID:
 <MRZP264MB1544299FB940DEA952709D5D93BE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20211018081602.82984-1-Emmanuel.VAUTRIN@cpexterne.org>
 <163471007023.5510.6880163764440514969.b4-ty@monom.org>
 <20211020061313.y66v5tgyv5li3qjv@carbon.lan>
In-Reply-To: <20211020061313.y66v5tgyv5li3qjv@carbon.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: b6e27baf-aa29-0d3b-a04c-1fc6bf2831ff
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ed00674-b4a8-4039-c15c-08d993d65d2c
x-ms-traffictypediagnostic: MR1P264MB2179:
x-microsoft-antispam-prvs:
 <MR1P264MB2179C7CE43388B18BDECC9BF93BE9@MR1P264MB2179.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7jFims0510pDQq53Eq5Ur+o0aiqFoGZEHzDJ5jnbN0/zGJ6dgogP+t6lfssO0DAqJUBcixZsf4co3khulrUqNkxOtOzp0m6due0BWAh+mf2yptH56lrMBv1AuvBsnZD/jEz097VvYf68DUrFVGm0AK/+QSGBeZsDRwLemXo0z0H5CsUbCZUARLvJpX2C6RLZSiGEsF5ns6YWvk+6kKQCaW0hWANpkbY2r2kROG7IHofOyL81Zhdz6cosSkhmcRvqLBgl1i9Ij++7FR+6ph/StTGfoP1JN2Uy+tIMjpcMCLMY43F5srG3aSp3DYtYvNL8IsforxCqTiRVBqzlrgN/oSIukVHbTDdtyjNH0en5vzbJ7y+sLgtsgHtZkCzCuzhYeTsFMR6UbzrNdwN683fnMcwxiW15YBuVp++aIHzTzi6/HrEUv/MSNBdSm2SJWwEaA/pg35ywyquWPt2q22wFBugSUZgQfj4g+BKuiJfCI45hw7ZNjYr2IC4RaoU24WtGUa89kWyJ9P070nYUDSmU7bKqmhSdE6yhpW0LE2YOPKf9Hb+PWNI+XdcKJkLNa33mSC6iSsGp8r7vFiAbEXjjpNqRkHjCK2hpoG53d4xUT5wkAJyj/RwgpNpCaSmj4VS3SRo8UqpQeISfWNb2vx/A7ZXmSeCzwFzT8IvOBm00fb/mzlYGDez9Ds1Mc4LDlHQN1TIFHgiQ46Gt1QeaZiS65A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(122000001)(66476007)(9686003)(71200400001)(55016002)(316002)(38070700005)(2906002)(6506007)(86362001)(33656002)(26005)(38100700002)(8936002)(66946007)(76116006)(7696005)(52536014)(91956017)(8676002)(508600001)(4744005)(64756008)(6916009)(66556008)(5660300002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7PtaYCJ2aGtBaD1nPqX5MQLQdQf4HvMa7Vi98usPj0a3OF3IhnMxdMXu5F?=
 =?iso-8859-1?Q?9ZY0Ni6lCNYySnAwUNDXWbDsaa7ZVt4vUtnOv1AMf9O7i+oLolM1e2y+MQ?=
 =?iso-8859-1?Q?ynBFqYkM9Kx53mAufM48brcS5WCACqWG6wHE4ydSdqcMHpRrl1Mhv3sWe0?=
 =?iso-8859-1?Q?MTBLHxkVO/RARPceSbg7d6/Ci9OdtvpB9ho7fc/+x4iv8fMw/TDAyp2+2P?=
 =?iso-8859-1?Q?CibfVH4BHShXdlKQVFBj2M01IxRvfDmhA5iPTkxJQV4y16HMMdClt1yO6F?=
 =?iso-8859-1?Q?B64TBm1T1aFleZVbry/KwgsGj7AvduOTqoHTjTVV4UQfLrKhbqjmXeLw7f?=
 =?iso-8859-1?Q?wrjvqYEFMbiKnPAARrIKWQYZ8kxuJJOq3XFSexIehAW0dcr4N2l1DpXybQ?=
 =?iso-8859-1?Q?XrRIUJL8BU7vERWadOB0BcySDW79UQvmi4BTBhG/GZhbBgGzoYM1hCB8ic?=
 =?iso-8859-1?Q?wTW5wB1MFLbovTiDBqXsTreCZEV06PnAJ+B60mKU/5QNQhP12kODSmRUhI?=
 =?iso-8859-1?Q?r7FauLaLU2skHVhofAIKo/Lr+yFh0D55VdpBe+B4Jf+ruTmn2+9dbGbwPa?=
 =?iso-8859-1?Q?DRa72XEg/BhNFN7b+fe45y8cgEG9VLBzSDomIP7bFahFkTu+lrXVzUUXaI?=
 =?iso-8859-1?Q?jP0NsERitlQzQuvDJkoA/JhXf9kKn81npXp2GTgSbkQpJGMU3U+yCjMFGf?=
 =?iso-8859-1?Q?Ik+fUUKskqhKdMOFcwoFgLY9wkJPEfg4HN3uUJThWsngahPsrqvgTzBZhh?=
 =?iso-8859-1?Q?MC/yE0FrkeZ+bj2wP+Y9ZDuMsR6l43yoIR/8SLUvFIaof2Sk9oaU7ftp/y?=
 =?iso-8859-1?Q?nBF/ag3xGWqt1NYGDUDPSEFIGMpidAa5wY0FqnR2K1Qmr8O9CwDHpis5Pg?=
 =?iso-8859-1?Q?9uS0NklZmwU75W507Z8O1FNu1++giUU76wkXDs6dCRruhsrRu75RMboedn?=
 =?iso-8859-1?Q?0OjidvJDM8z5ArcONxVGuW7wWsaXjSnwJvuPuDEB3lW+/Sp24dO3C8MNxT?=
 =?iso-8859-1?Q?PhJhHjeeNr3NS1NWugzPY14KXJUzk6UssTaOBDmEjFgqi/IRzDAsczmN1l?=
 =?iso-8859-1?Q?/u+K0NLKC+pCac/isvMfEddx6d69YZKSK74xshiqDEnw9BgYEavFzG/Jal?=
 =?iso-8859-1?Q?qu9+BNEbXEjxuo3mfB+BrMmmHFoXmMaySguSOIQFZbyDBA2wS9030YZ943?=
 =?iso-8859-1?Q?kNFy+3KQd7FU4MX6sHtKIuSDuDekb1Gtq71wylqLLGc+fpQyQW6G6JF90E?=
 =?iso-8859-1?Q?RDwhYexFhfJGuDtbYLdNLmSobczIoAFPuVv33+lW+c3kwUPD7geFSxaP/p?=
 =?iso-8859-1?Q?y1N0/fV7N11P52s9E6/NVyAtpc3aZ5gvWSP7WjOaw1j5NagW1L7by4XYHD?=
 =?iso-8859-1?Q?165iBFbOgIqWvY9uBI658zp0+paa3/P9kg4uPkeyeRrWZgSaIv9tlN9kR0?=
 =?iso-8859-1?Q?uuXiUlSorDRT/BdG1rcNecjadov3RuarWOSlJnASLk0RRbtG5sK4W5yLbL?=
 =?iso-8859-1?Q?dEpRrMOaQ2KMst2oRhX19b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed00674-b4a8-4039-c15c-08d993d65d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 14:31:54.4357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Emmanuel.VAUTRIN@cpexterne.org
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2179

Hi Daniel,=0A=
=0A=
> Thanks for updating your setup. I could pick up these patches via b4 and=
=0A=
> process them easily. Really appreciated you took the time to setup it!=0A=
Indeed, it will be much easier for both of us.=0A=
=0A=
> Ahaaa, I thought -Werror=3Dmaybe-uninitialized was for clang. =0A=
Yes, it was a misunderstanding, I have seen you already had fixed something=
=0A=
similar.=0A=
=0A=
> =0A=
> Applied, thanks!=0A=
> =0A=
Great news, thank you!=0A=
=0A=
Emmanuel=
