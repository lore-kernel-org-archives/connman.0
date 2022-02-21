Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90080.outbound.protection.outlook.com [40.107.9.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29C2569
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 16:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba2I1RN4pTTZGtdQXBWCKxZ94agvGJc+RXNoWGFNgaILtnkc428FeCq7olwWtcLAInfjK05iLrFXVRiB0OOou4hly7HLJs1hQV133Qr6xFAwm+Z30AWFYuEkd5tuU0syesaqrk2qPflp4UFL5qgH0ZjIRd1QZBQ1WzOOl1LkWWBUUm/+oh+XRuQx9/Xkmc7ZK94wJJEhk9oaeOghnkGAlFuJwhLdCnCmQMMjcVtGhLBy57sR1iUny3B1pyyDVGCg0pWnUPuerzpeopFY4mPwVJLoXwlpY/aCA5Dvz2Z1bPYwpX78dnmKXiaw+Uon3dQ1W/3q+qucv1XJA+FoQvfwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSNiPLAZqBis/q1jpdRUpG4Dy1yYs5DUyGH/U3A1WCY=;
 b=KXSTXMvMJQo4r8ZBlp72S5+JAdxB9gCFD06zM3J7X0Ess6g5zdIrqvkyrEUkkrtMugDag6DYGeZyKxd6srHNbcB7jJeau4W9zsHb2slBD4C436T5NKpPjCUgr/EZfIcKGT4kQ0e2ZfdRolpaffyDpCrF0jxU+sMh5bxoiwa7bCauYGsK+h1v1aasPJOv2r7UN2qQp7VBf0kCLwDD4fO6Ad/Jr9rrcroXpZ4FdXvBqnweKpKRGN+AB5CkmjTjyvQpWuNQSz1jI8LC87iG32BJGRGWFf4LilalzvLknd2llirhm7CTcGR5Dmdi9vwnIgSxNqUAt1PAHo3sqXpeF0fI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSNiPLAZqBis/q1jpdRUpG4Dy1yYs5DUyGH/U3A1WCY=;
 b=O2xW1l/MKPgcfqrUquE+nDF3o52IU0Tr7ZgGBrzPZbJeudPaHZizRLxT43cEaqB+TsIkkX3t3XMr8KdPhMWuI4UkEsQVhG1jczlMHsKs4I05RiA1fu9k3AaJ7vbiHp/O3+dQ/XVNAjzJZLPdMzT94ZUlq821jiBHhHcj09tySUc=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB1943.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Mon, 21 Feb 2022 16:53:06 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 16:53:06 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: Denis Kenzior <denkenz@gmail.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH v2] iwd: Always disconnect connection completely
Thread-Topic: [PATCH v2] iwd: Always disconnect connection completely
Thread-Index:
 AQHYEP/731R9+FXajUGI5zk313sJNKxx3h9IgAGhxwCAAAOvMoAADyEAgABbfgCAFH1RHIAVdbNZgACBbQCAAADlkA==
Date: Mon, 21 Feb 2022 16:53:05 +0000
Message-ID:
 <MRZP264MB1544515AF83263F7E4DDC918933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
 <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544C7DAF7A0AA3942D9FC1C933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220221164442.gsg6krtdalemte62@carbon.lan>
In-Reply-To: <20220221164442.gsg6krtdalemte62@carbon.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: ca1c7828-b4cc-1fd2-f09b-286d2cf8491c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bda1d72-bfe8-4da4-a9af-08d9f55aa1d0
x-ms-traffictypediagnostic: MRZP264MB1943:EE_
x-microsoft-antispam-prvs:
 <MRZP264MB1943458C44C8B29573DC9189933A9@MRZP264MB1943.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9Z0pjvx9RcuzVYnpdr87Eu2Ikrw4pG/2xDS/QGU+wC4FvXZfi8JE8M24WhgbTFDnpTiOA2djFrui3odz9VERIyeq70uNLJXinPsMjIlsSxxrA24+HSvySOVAGXhpt07RdNgme7HbNWDeDYj3lXnztxvyjaM4uf0q0/HxMscX1YkqR5S1ux42hORA7/J/4V1uDraFq5aWCtmDwg6SDUwMp06l/J6CTmEsoqkuIY1tyH86z+gtN/6AnebehjhgqGVunaEF9yDKoxnqtQuDm1SpcktTDfH8QVUbref3997m8Un51f6Ju4XSbt6xpe+iqPG/KdvHe++gykdqqDzNF7exILAlAUeubZ2KEFmIJWAPlCHB32opIPoFjfB2o44CTFFDgyG4DDCWJwrMiA4ydQguCeapURO8dS0sUVPSLOwSWlnufhAllVBg6i6DmZC9dVeiHzLHDLZXJDCjbLi5VuMg4FzY85Q7iICzyaewfj/ajITXUs19oU0hMCIk/2LrfW+g5m9c/DpEXoZzju73UmIN7KK+mAv4w7bgHH6NBxRcqBn0K8MF/rQirJDvxj+LfpxzNGP8LVLJDIMBohkAOztuQYy7H6BQ8QdWEuIvGW2Zj1fRSe17d0UIg5DT47nl3fM2g+BujR0F6ua/yo8aNPqpYebgaty/xKq1Jdw3OOX4vo1zf2D8q/NSWti02mS67o/wV6JNow4XaHBR3ZbO9u+TNg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66446008)(64756008)(52536014)(66556008)(2906002)(91956017)(122000001)(33656002)(76116006)(66946007)(8676002)(4326008)(38070700005)(38100700002)(9686003)(8936002)(6506007)(7696005)(508600001)(4744005)(5660300002)(6916009)(55016003)(86362001)(316002)(71200400001)(186003)(26005)(83380400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l0W1eNMlv8ZhEE97LFD+SJ7R2teGGupDDeKpAUqSbcRtUlvn52wB0qPvt9?=
 =?iso-8859-1?Q?rRYutio/qFHy4a7LrHmpy7pAxb7mURe20QYfOaIrYl0GgOW2EM10YXHa1E?=
 =?iso-8859-1?Q?/CT8wBU4KGvcuJMu1J2E2rLAQb+ntzTiDBMg6lZ7kGQ4ZomCikyubv2uNj?=
 =?iso-8859-1?Q?Ceddd+113Lii0zangpnBDUy8lJEFKdAOs8G+DbQ8O0rQQLOYQz84IpgoQe?=
 =?iso-8859-1?Q?lzNfpD/MHoA/8fVlqJRVQ+u4iiS8J011Dapyxw6OzDyr2qqNp3wH30KYNM?=
 =?iso-8859-1?Q?axmte7+tCUe0uY9AbMLu8rNQrUWVX/r45+Q3suoTyKdciEelkC5xD+ioAf?=
 =?iso-8859-1?Q?8nQZpMKgtrV3cDLMA5sTuLsFGG31bueFLxqi0yRDhk9vng9lPPXGDNNT4B?=
 =?iso-8859-1?Q?rNTwUoxu9tU4k/t7591EPRfhtle7DooHvTeEaeqb6BuRzqWiK9H3aFm4n1?=
 =?iso-8859-1?Q?GKnhSJm5KbioCSwjKnbwFQupnZlo/gCQ5GozeQP5vJH0q/EYgiHU9erfQA?=
 =?iso-8859-1?Q?BgAJlt7AEarTv0dfUevEqyE9OMHvtjUP1hgBcMehp7Bvyq07BcKrNiDA8J?=
 =?iso-8859-1?Q?tZ+pwb6ySdYIEsL9IxmDGPeidmFlMeO8DMZnlD1D99RpSY3YrVXkL0dFFJ?=
 =?iso-8859-1?Q?xPR1els9thnFTkt4auEmoXoiYH4urfUB7dLDt+0NGkOX+k+vOHTcamOX7s?=
 =?iso-8859-1?Q?gG1NED9nnfmxaz2WPwQTgGjWb3HX2ZR/SRMsqJfen2ZrkrX9wZ1Q6t1mgb?=
 =?iso-8859-1?Q?6gHYZO1xYLMhL6qCj37UouA8JrlbK9v91zqhPiPFPQS7Z8S+p+jPQh2KS6?=
 =?iso-8859-1?Q?3lTkSb5/bhsf35qtYes4ltZJroproEMSNGfkVQjJpB4H7kdZSGBvJSgBqH?=
 =?iso-8859-1?Q?Ol14LKfr/8hzcnr2WgQqIBBUXxoAQp1kGd8AOWdCfy19BTFmF4PvDUXrdr?=
 =?iso-8859-1?Q?MWowuDlds3GzLAAWjvzo4Pq32JkN7dfV4LV5qsxi+GzpBXRgRUYHmNg2bi?=
 =?iso-8859-1?Q?4lPD9XHDQJSv/KxQRFSjvjkHd2RX7Sj7z2WCz8zsRxnq4saYwwldbodRyl?=
 =?iso-8859-1?Q?vBx3eLvpgUaW+LwMOZ9oAbk0Bu5U37m1BVAtcU26cmN3GLssDop1fSCIDe?=
 =?iso-8859-1?Q?SVJjBDEqi0ohqQfhXoCMkSRhG8eufKJH1oc8vTFaGXaig9aVVYHTei4dYY?=
 =?iso-8859-1?Q?LNhXVvEyqV3YUKIxzN/FXKHQikfQwb6NVuKEMFlUi8U3C7NGXqacLC8xIC?=
 =?iso-8859-1?Q?9g37aTTcG3wjqAa9BncDb1h0tRTmcIUezPo8wbN1xQ0CYmVEhqXYGV65hx?=
 =?iso-8859-1?Q?GdaxT6CxNdipeSuJyvOJGnDv5wkriUaYVmMfXcI0XcRy3wleeZh7IoBQd7?=
 =?iso-8859-1?Q?vPQq21E/k++K/wwWw7FpXaPPF1nnLQW14QNrJa3tw95g9Z+Rwe9YzXU8Rl?=
 =?iso-8859-1?Q?vrKEclC+nEz2/n8hd1tNyrkBGIwnp3qkgUlu/xDOeJ7YKv0DebxglEm4Ss?=
 =?iso-8859-1?Q?hIW6Bpe7vC+Mbu+nCwZSysHnq8DTwgYYSmpVmlx7BVDC+NiQnW4suzU/Uj?=
 =?iso-8859-1?Q?qWWP9X7Na3qv/CO/z8hHvuegsHzse8BlNbLHnMHYDqgArjTUpnImkMC/sK?=
 =?iso-8859-1?Q?JecjoMm3J4lm0K6u0KWv2xBGd6qBpXdpaaGYMC6Lwr7KcKS1QMBDoEMAn9?=
 =?iso-8859-1?Q?uF0xESNUa/kxYADjU1VgNhad4JpwXw4F2WCjXba9ZHwPaAb8QSc98ZMEWy?=
 =?iso-8859-1?Q?qiWA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bda1d72-bfe8-4da4-a9af-08d9f55aa1d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 16:53:05.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hr3/e8bdfOZwx1ydi2ev7XxE8vL5+gGSl+ZxhgQpG2/GecN/M0CPzCZfIZwUEMuC1mIHHaNYvfJdhFsiqt0Fi05a1pnP15TY2+UfbW+ixfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1943

> Yes, Dennis asked you:=0A=
>=0A=
>  Is there a particular scenario which isn't working?=0A=
>=0A=
> As I said previously, I don't like the patch as it add complex logic to=
=0A=
> the plugin. I would prefer we really understand what is not working as=0A=
> expected. Maybe this is something which can be easily addressed in iwd=0A=
> directly?=0A=
Hello Daniel,=0A=
=0A=
In fact, I have already proposed a specific scenario on last mail:=0A=
It is easy to reproduce the issue, by switching quickly between two known=
=0A=
Wifi networks (W1 & W2), via the Service api. By quickly, I mean: one call =
shall=0A=
immediately follow the reply of the previous call.=0A=
In this case, the following steps happen:=0A=
1. Disconnection of current network (W1).=0A=
2. Connection to the new one (W2) failing with "net.connman.iwd.Failed"=0A=
dbus error in cm_network_connect_cb, probably due to the fact that W1=0A=
disconnection was not already completed, aborting connection to W2.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
