Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00086.outbound.protection.outlook.com [40.107.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9871
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 12:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8gceSvI4Uz6j1Ir6PwAb2aICP5jUtkWj2G4L5p+Obknpksu09BjEm0K+PKwKRq13bGDJY8natduc9T5Er0Vh2rDMBNRv8zKwQAGp2/fAJ2KWvQZHm6f72EZCEXwv/0vKMeURbvIeMHyZQZCaOtuVWfYCK3Y2cmXJGDVe7+BEcoRtXbWeGLuOuKtfp0uvpiXqNICi2Qe7Zh/wH9IuEoKkpqvdGqKzliSSN2tlS+s5HXeHzw8dD//uxA2X0O5C4KEjKXDZrdyLcCBnsvCF0UINxqTTqUgJxTGbWAsrv1bUhtkceJIjpu6I1EHVBOrlUSFehh1rZs25o+x6qH6Fu5+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAUHS3zJecPDNzgolgoRUb9VO26xRqUAA3oLDK7N9Vg=;
 b=oTSO30/z0NCZa+xFrmAnogpi9j71SfTjTYSN2W7ArpUA6fD27o9BVgNNqErh6whPnQlDIVpX2deYvQIi7NZdDGhSrOtRqVJWRD9TdPHV3GppzhMiSrJVkEPmE17mhGXqhSmogou/2AhaWIR5riF38n1cHLonnrAgDn9WVW/iSP0Qu4NgBMv7pv7En63nHzCCoVUGaS2bhkqAb8NYmYAAAhf8sOnUaenxvCWIhYDgw3twIfqZBmMJYlFZdxyH3rCkMtDiXe92eED9J3zFydTgY8FquZRXOEHO4G+nWePUahOCNhQEghuukvrVLfdCeG1dqVbuUmF1hYA1sTvvUOqcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAUHS3zJecPDNzgolgoRUb9VO26xRqUAA3oLDK7N9Vg=;
 b=gGRkP3QoUGjQ50jJH+LVYVHlBbIN21lhIqKZ/IP9VrhCztwcWwpDwlvI638hMGl1whHEQG1qjmK/MVAGpj9ez1hXRAqoCGbQwwRb0iC2+feK097AL1roC9p7QKYMySgSWVsZDmAI8Ao/YLW8CzUq852UPJMbSV7y9Fm/DkBa7h0=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PA4PR02MB7038.eurprd02.prod.outlook.com (2603:10a6:102:bc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Wed, 23 Jun
 2021 12:18:13 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608%4]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 12:18:13 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] service: Fix default service update on ready state
Thread-Topic: [PATCH] service: Fix default service update on ready state
Thread-Index: AQHXaCl3q3yULm0o6kitbLJsUjipmg==
Date: Wed, 23 Jun 2021 12:18:13 +0000
Message-ID:
 <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70fe041b-0a14-423b-ca22-08d93640f913
x-ms-traffictypediagnostic: PA4PR02MB7038:
x-microsoft-antispam-prvs:
 <PA4PR02MB7038AC6DB8BC3875EBFFCAD693089@PA4PR02MB7038.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZHi3ZwSozaDNz6WCK5EbEanoxgExCTbr13YJd2J8ml+wQYzJS7BIv3F3y5YIwnCdCIzJv4mIKTxSujF0oyl/pau38HxZXdqoWoUXM7uHTRmhtAKiverQKQ/KqJnI6k9LVr9v+PPdpBzmseVc7yyc5ALEGKomqy2+N2wTWaswtY8V/uhC5CiG8L46LM+B/UHijqZTetAULSehRu+L6+P3thYbW6+jPVfzl1ctx1eeiWTUujrfX9eNR/lnHty6gn4MNBRpcL7I5z6LCTfjyyZiAiEKVW4GNdR4b+LFEVwqJ4rlEcxvLdigERpmfgZlIggiHGYDk761a1zcXDly2lImCM3rKxTtEoI0K6SrelxC9dc1ncNyHjYVjbu/ZfmBRrTSMgwatSQSfbIAAmn7UVvtFtzEXM72dYwCxmmQDyigADyGM8Z1ZjHv5w1t6ihp2nF5+w1jgCfw43hZ92ULk1p+yfUxr2slfwfgPbIjLoQ78XbZXnsZYl89WWDpbWhOaxhZHezwb+dYeP0rSvp+h8L5JTdZlvHW5WSyONEHC9AWaXzkBL0E0c5FWBcJXNnZKtUpx/PsNDRI64ytHtnv0FTmZW0hC2+VB4D/zKUX2Om81sc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(396003)(366004)(376002)(6916009)(55016002)(52536014)(478600001)(9686003)(66476007)(2906002)(186003)(5660300002)(33656002)(4744005)(66446008)(76116006)(64756008)(66556008)(66946007)(7696005)(8676002)(38100700002)(83380400001)(71200400001)(86362001)(6506007)(8936002)(316002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wLGq1L5/UC1XpCIFtIIaSOe+oCg+nD/QaFeLSd7EPDFb4jOIyCKarZeG2v?=
 =?iso-8859-1?Q?JLkR5aFiQyG/S2psPBA3cEbpon2a2TMSTbiu0of1mjkZhtbIhtqG/3pfvX?=
 =?iso-8859-1?Q?7qbafCtoXaHbpiyJ8k/8gpTire8u68D9wbzjbU52iBwA0Kvr/1DiiVH+4r?=
 =?iso-8859-1?Q?nSSGd6WMThg8OvW0Ma+vOiAGdJoB7K37XuWTN4nWk37ZDsT8f3h2bv78Sn?=
 =?iso-8859-1?Q?lSQInGgbPwahM1GcsG3k/7LiJbye31CtuK6GT2xYs3SSjXqoWIVYqGVRc9?=
 =?iso-8859-1?Q?G1CefgC0DP4zxnrSfPlBzaHivKTVRRukcIb3TblFZktSniISoWPM6NiXBR?=
 =?iso-8859-1?Q?4fcN6mdCePn19MBROblLZ1Sw1kouAMS6mcKRLCLV11/LHi1lDHqoQeTsee?=
 =?iso-8859-1?Q?FqcsqyCKiFhs887tSFAyxWqOlZQqnYNbuTNPDMUM8dbu75xm9hcQcdVxX1?=
 =?iso-8859-1?Q?jleb9Q+0amFQ6+pSkK9FG0otDN9NQ5PkjyG+JKXDMfaoEmyJwhUNJ3QeVL?=
 =?iso-8859-1?Q?0E5MM011xAR1VL/jz7SK8f26DFF85UlBUhSv3KTP/WM9Fj562Cf9PdhJso?=
 =?iso-8859-1?Q?/AZSOenezbGjTH5sdYrxmhvNqDt800u78ycskuUxtIgqsZROVqZ0v3kGNw?=
 =?iso-8859-1?Q?U5t1Omlhp3+oJym3tb/DWfskltPVw3/xeGNfP+z9W8SmqnARHi9hyvJ/k9?=
 =?iso-8859-1?Q?X64QiiD3V5BRokPjItNldaXeyihwZxVFXVbyaimG+njeMyVJsSmp4CaB//?=
 =?iso-8859-1?Q?KpKaQ20tiKV1CRhtp3evmIF1N1EhM1iHhLVKQzNfUt/E4dlGkTvnaF5Xiw?=
 =?iso-8859-1?Q?u8/XJt0MpsdlzvokRFqecQolk36WglH0/Rk42J12iMre11x2cjCAQerqlO?=
 =?iso-8859-1?Q?hL6IOkhwiMe34QKiJ/OP2BIJx/3/aCWz1PC/M3jv2oatZtLgDdtnfergIW?=
 =?iso-8859-1?Q?g9ihLiUE2v9PpNZcnzZQRaYou00UqzuARSLoqloXGoFDTOKf9ofBBG2osm?=
 =?iso-8859-1?Q?nk/SCoSZF8YOz8tvbNZ1k1Tc5A0V12FPT+0NP3ohgv2uVhnPPCWz4wzDPm?=
 =?iso-8859-1?Q?OT+fYgOR6MyrEKnKCtOeX8uLCurdXIsqRPh/AbKqAuHNDIty7S6CItvpS8?=
 =?iso-8859-1?Q?iSvLv9vkUM7WLn2+uL73G/IR5HXEipQYBBsi1LxJqe3ErjjYCeyVVxJNwR?=
 =?iso-8859-1?Q?r4T+Jpm9oUSEFdrFj19wcAx9n0UFKeljLqFPp2WpgA2KsrOj5Lrct3iDzG?=
 =?iso-8859-1?Q?G0BLII5ehbbVeT6ItAkQYh0CBC9dBQg5JDB7nmC/E4kF5aRCzFfJxqfWGZ?=
 =?iso-8859-1?Q?WvCZWvp/D9TwIDs/Y1ds0dajB7giTJqpLCDcphSJyxwKn1vHn78lekKML8?=
 =?iso-8859-1?Q?aFiHepl15g5GmWH6qahBOkM5JwM/nc9tsnIrYZcLibiQLmW4IgG4I=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4794.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fe041b-0a14-423b-ca22-08d93640f913
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 12:18:13.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wi/hCiICCpPIZDsLGiNwn2dbwhgcde9GsuhaqBz/FOdpPxm3BEixgpKn3ywzL7QMLjWn5bmtHLpKEd0shygBapXWBMxzG9Mo2tww3UioYwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7038

On a ready state transition, the default service shall be re-evaluated=0A=
after the preferred service reordering, before being processed.=0A=
---=0A=
 src/service.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index eb74a85d6e32..cb0103fd7221 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -6051,12 +6051,12 @@ static int service_indicate_state(struct connman_se=
rvice *service)=0A=
 =0A=
 		service->new_service =3D false;=0A=
 =0A=
-		default_changed();=0A=
-=0A=
 		def_service =3D connman_service_get_default();=0A=
 =0A=
 		service_update_preferred_order(def_service, service, new_state);=0A=
 =0A=
+		default_changed();=0A=
+=0A=
 		__connman_service_set_favorite(service, true);=0A=
 =0A=
 		reply_pending(service, 0);=0A=
-- =0A=
2.25.1=0A=
=0A=
