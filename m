Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90059.outbound.protection.outlook.com [40.107.9.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5429CA
	for <connman@lists.linux.dev>; Wed, 25 Aug 2021 12:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR3JINqB8ySWTDuiYY3QzUg3+MC1JRbr2Kpe5SB2C3fivpclmWXg6W6cLUqhbiZGiMBp7l03OSvV/2m1e/1/LYhgoAAAatB9tQU/gWCl8ZeUMikJGUKUsdgBoGykyE/n7eWTPvrFT4cfclQS8aEdlKYbeQEOBKzrDr0SFgIylosmb4YWwAkYEh6+v4Ln3BgNrfYX2r83K0lvagfbf7kOVHrPz87u66rZFELYynHcK0mdEjMo1dIsXOCIeASsEGuYh1QQI1omcs+g9DK8AnLqQY7Kc3jlsQdBfMGufB3jfak0i4edmHoMGzU9fZp6gL43kK6FsFIXN9aEFbF9d7ZKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u51N8mtkdzAjQ2+Onw9eeGJY7lQy5Da/HHf6Gv0O74=;
 b=VSlKskTzoGeAFPIqu/WusL7LIKOOVKLPgwD553HXrzFqVyI6PwINpjqq5Nkz56d8B6RM4CywO9eT60J92suREq5aEqmF4KqxQWIYmgXdLZxlvBnJV+3tMYLYuuwrWHoEVMtAvFGHD1huOK2bFtC54utRB8VfZ1tW25vuKvjAr9SEj3sE43rZLwN0i1sj0hG3wzPsjcJasbyO0L9uqMVw1Hbvpto5nDANztGynOVm3iz4S2SZ2nDYQNVEgaY6Lre+OspaS+NNrl/LQA1MX85v8teXpyQGwRbYJKLbM3aos4xwaRlpH3FR+5ytHn9o332t6AI1LrsxginarXejKknqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u51N8mtkdzAjQ2+Onw9eeGJY7lQy5Da/HHf6Gv0O74=;
 b=bfoBYob5DwdRs0EEz/GRuekIjRHS+tCSOxF4hVA3aCmfCd3b/GNMj60hxFGwte+s3+aQtQyZvXiFv7PKCU6yapI3P8rpe4ZG5zJzyw+v5PghTqRISt2AJy8TJ33AOmp00c1wW/RfQnGUfoJqLYdRPhL9/sJG/Vx/tGo1gIgJ9kA=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1732.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.21; Wed, 25 Aug 2021 12:30:27 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d7f:ca70:4ec:896b]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d7f:ca70:4ec:896b%6]) with mapi id 15.20.4436.026; Wed, 25 Aug 2021
 12:30:27 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Ignore state information in service reordering
Thread-Topic: [PATCH] service: Ignore state information in service reordering
Thread-Index:
 AQHXaEAKBbWMy4FLOEmVuozxMfJz8qsvXjiAgAADxYyAAAh0AIAAaLYXgAXKx4CATus9sg==
Date: Wed, 25 Aug 2021 12:30:27 +0000
Message-ID:
 <MRZP264MB1544E87C75134497E7EBC0D293C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702075335.opqr3lc7kzell6lv@beryllium.lan>
 <MRZP264MB154432CD7A2E3A804089C9B0931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210702083720.hwb266z5eo4xlv7f@beryllium.lan>
 <MRZP264MB154471078FD87663548DE9BB931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210706071911.6rl5b2nrooy6lchd@beryllium.lan>
In-Reply-To: <20210706071911.6rl5b2nrooy6lchd@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7dc58e8-88a9-4597-beb4-08d967c41ea0
x-ms-traffictypediagnostic: MR1P264MB1732:
x-microsoft-antispam-prvs:
 <MR1P264MB17327FAC59134214B2DC032593C69@MR1P264MB1732.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9G/3CsPq5+TtjLV1bctKemCmw1UThXVcnMarlHXKKagQ9hR74ElXztT/UlZgB+2Pn/TdnZf/l8DXnAci30ylxeiDTXy4uZUOGDB2wvzqgovcDXH8q1xEeuTHMvI+sHq1WTaIU9xxN3P+BooaJSmHga3nNGt+kvlKMmuhXhB/pcQU+TCBTT001hLAAblNjK35fPq5Sl6PLQnTtXES5+K6e1KfTqSOIGIxwdgJ4xMJhCppq5WGJzAhSNRwb3tgQt1qIIZly8Ogiktd0l5Zk/kZiTTrR3CJCpz4p0Nv2QLgtlkJ035Y3bAaEtYCk9a4dq8UO/49L0y7edVljiNO6wDNpLNOZAXDCWl4tqu/VSLBQqTaR6x5uECVg37hltZzcT4zean+60s8GR7iTEkk77CFMc37yzK3FgfL/Ve2J17hOb9R/ymGr5kaoVgw0ZWFQ+JPRupXsroBnKWq5H0o23vGu0pCMkOwR/ZI3yQ56kkH/lrzNE2nxORf1+405tc6f7DYvFkoH/TKuO9o/dyx7CY5WssQVOADd3JULGDbxVLOgTGrQ10z4YOALoCwjr6cpX2k90Kz26GEkdxSqvjjIrszrds/dSbO1969DxQBa2KojS0E8CWLyLKmW5SMmBv6MecwtGrL061SnAMdjrN8PaaTFyX3t4/6g9ewwFlUvPM2vUDEBG4d1wkQELIOTfYAkMTsLd+JkRZhURW2BEfH2jjMeg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(186003)(55016002)(5660300002)(8936002)(4326008)(122000001)(6506007)(38100700002)(8676002)(26005)(6916009)(558084003)(478600001)(91956017)(66556008)(66476007)(64756008)(71200400001)(33656002)(316002)(66946007)(76116006)(2906002)(52536014)(7696005)(9686003)(86362001)(66446008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VhhkF+sjrhspnX0iDXrbC+x0Hq712I9LuHZAeRZPwNI8i9gulNnioeuoX/?=
 =?iso-8859-1?Q?6knUtghYn8JFERipSDIpwqQwCw35EzxZl1ca10iVUAUR8y+IzCcMWwUECj?=
 =?iso-8859-1?Q?aGVwO/CuqVN/RovfxyvJD/+OKZmbrZzEycYHNNrK4gtbh1LGx4MKRcDV6U?=
 =?iso-8859-1?Q?DdozDh72ZB5qfPR/G0I66Vo6Fr5yzaJNcwxL3DcSDkcKD/gg1+sd7dcklM?=
 =?iso-8859-1?Q?BYjO2+cWZisRXvA9gpoHCyFSC6GbCyy1eS3fdbKcmdSvrYrru6jJwM4BK3?=
 =?iso-8859-1?Q?fqS44SZjgEp3AMq7AA3tAdXpnKAs54dvc7ccAOvIRT8yX0ryrXGEqwk1BN?=
 =?iso-8859-1?Q?zrY0ENZzRIM90fq/H7NDpiOzkma50CE7u/A/EbowZXtbxESxsfnMnzBupz?=
 =?iso-8859-1?Q?q6HQHs2njvfalpVjN9ZzZPFHyGIHIw9Z2QrwZDzk8lX3fGXoRQi8EWJ+H9?=
 =?iso-8859-1?Q?ey1H80/6mu5JiW6wMDvOadvUb9u8B4aLUGj4CK9vnFDF30CXYxRPsQOb5e?=
 =?iso-8859-1?Q?7tyh9IRcY6aUvuRv7BlS2EQGRuhcM1ZQj5+FQkT4R9tN6I0jmiPBj5WYMb?=
 =?iso-8859-1?Q?OP1UOb8bC5GUGbfDKL006yCPf5AY05OwvSTsFp4HtPDMTNsBTHSGiTMhLN?=
 =?iso-8859-1?Q?enaOYKCFtRumoBdgy+c5gcOCc7MJijybP58jIUo0f8PCzLUOBqEMt7ZFDQ?=
 =?iso-8859-1?Q?4st3KqitLOw884v+Vqqpj8O1Th7p7vcB/mloI23q1WtfOq/eH4SZoZdzaN?=
 =?iso-8859-1?Q?2eEQTVtB+tNTxWeU8z8Q2ZwTfhuQ6Ug8svRK3WDPPSCKRaQPsZwvnojmEI?=
 =?iso-8859-1?Q?M7ymqA+ot3j5ApWTrx1okFv4xD72dZ57knS2NMZ74W6Y+h2CCfD0s4DNrG?=
 =?iso-8859-1?Q?gr6fIq5IL4Zj8kmybKc5fP9qOfJX4+9YKYH+aavqM256djmjUH8sO/NMiM?=
 =?iso-8859-1?Q?ve2kfb/ju/NneTT3+xqP8wJaM3i99AmQXMTfofqaxv4ZuCv1ZAoZBl9+o3?=
 =?iso-8859-1?Q?Y7HHsXibN8gfh+xHmMXy22v1Y+hI40VfQw5f63GDpXojr7aTXWf1YIicPw?=
 =?iso-8859-1?Q?eLvVvGG5NyTE0AoTnis91F2KrC7V7kwNInn/8xzX9cbMjtTQFS3LtXwtQk?=
 =?iso-8859-1?Q?8id8dkOXQ5ibyxq6cAkCGi26knpHKW1WXKHvWGgfUrzIrXrDpXUEoBoG7c?=
 =?iso-8859-1?Q?fMCXTGqe1P6QCoRWzwSzr210etNFzptWwNeGtuvKGfFxP2B1RBPxRxX/mJ?=
 =?iso-8859-1?Q?ge9YC9t0qSlV8STQzwcmdDPey4Rgy8YbS7ah3iv5sB4UM7yQ9P9kINGtDx?=
 =?iso-8859-1?Q?3YF27tHgzJfHElndzOLjipKpxRDloapk8wSsUMGenO91uzU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dc58e8-88a9-4597-beb4-08d967c41ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 12:30:27.3971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXkLUre7RFsLBr0iABqIa6aav4//T3Adh2vRvNpufCTmTlZDXKNcJjiYSt29mNSbp4qvv4ee2tG3uK3S5mSD8WlqGYsjq2JHJKcSf2+cOFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1732

> I need do to test=0A=
> this a bit first though.=0A=
Hi Daniel,=0A=
=0A=
Was there any progress on this subject? Does it still require some clarific=
ation?=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
