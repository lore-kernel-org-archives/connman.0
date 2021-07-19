Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120047.outbound.protection.outlook.com [40.107.12.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DA173
	for <connman@lists.linux.dev>; Mon, 19 Jul 2021 09:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiVvAGpKGRUEUt/LIBcJsuuYDBf+4XXkH9IrOcMcsukCcLFLmslhxr0qmt7z3Vru/Uu98uEYc9vf34l5vKg4FMuCGpUCqGOzL5cSOpa87riDHsj1inB3/ULGmrWVLTKTyHkLfsoWtsPt2MG67izYjUkNPKtcvfm4Hqccy9/fT+kLMQh4fnrLyb7Y4LkEaHENTYJ9xC+VGerNlid8NcFEpbrjGyhy/FcLh7LDFwXe2nofm0jv2XXk9Uo5E9rHTp5O+An5eZnyopJkHVtakKTcfJTu1nOdtLKQGS1b9DkdXCol1MQeKXsE+LS4R0JrpQR3Hei6+a8rwqGQq7YDGdz5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDIQJkNSowcAlEDNfbKlFp58v+8N5K+uXw1h/MkwQEs=;
 b=njsW4ncFIUazumR9DdlUmo1G5494c4ueL95mi7kvbkqERHVxrVUu31r08RCs5MRjsZ0ckdK7V24HZWRzdYRXtQZCoePAIfQiaHszN1PItSLiduRzuXTD470bopodK9j5/VV5YTNLdS5qWKIaT606e7IGqBRqBIpOY0K8bnfv6UqKFxZBl64Dr4eAwdT7WH5lnnH0nTbIEcn57N7rl3WuCN0xH6eyjo5gpABZ8dyZajJGE3tuCksS80zT1oQiRLE0hPr9rBQVqXWucX6pfjwVy6Ms9Vx+Lwjq4+wV2DXZu8z16Wtf8s8zHJY6nkytg0eXoPw4dF4VHYApq8wyFSUNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDIQJkNSowcAlEDNfbKlFp58v+8N5K+uXw1h/MkwQEs=;
 b=uC+8I2hyqHELQUOvQRbv7SojTTCjRdTexDLJhGYU/B4E34FpemGiazPOD81rGCPS3IGUIVfs+PiDY31gxJqT6B7E5y674IgDAhJvY9KINCYJEZNUupl5F1RkMmPEUE1bl1lqQIQqj4LG018PV17UBY5KUSFrzOllfEBAm7TJGoU=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2164.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 09:01:49 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682%6]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 09:01:49 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] service: service_update_preferred_order cleanup
Thread-Topic: [PATCH] service: service_update_preferred_order cleanup
Thread-Index: AQHXfHxclevzH83B+0aj5OadKVoo/A==
Date: Mon, 19 Jul 2021 09:01:49 +0000
Message-ID:
 <MRZP264MB1544B944E70E53B4B1A9287693E19@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d2e1d49-5965-4ebe-edf1-08d94a93d81f
x-ms-traffictypediagnostic: MR1P264MB2164:
x-microsoft-antispam-prvs:
 <MR1P264MB2164F149473068267C0DA21293E19@MR1P264MB2164.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +GVsvFVyB/qNnI0N9wFTkIW5LC8xbwczBvrlGX27kr65LGaMwFMgt8U6SaUpto2cWWepFc3W97dttcI6zg/25OZsz3bjuksvPgLOEBwDV6BjfxE0Zmdr/qTx5l4qhybm3Uv1X6ohTcUlQtY2W73tv49WUHuFesx5dhDqEUOhir9B4rzLUxOqhkqe0AOXaPvOMnuxkvUVXblMzWdMRkfLmCrAKNxJtM1bpoTwYxN2Jv3uCI241AnKmxl08W0RI7Uz7sNyCajd5i9EfiajhgVG5pnocy1+Vfzsl9YIrLnLBFFamyNQJUKt5EwA2+XQtIf7xbh0rqATrAcecBn8oNtnWh9eXOXFO9Lvnd+LpamiQmdYhsuIH3p1Qbse4tdkzHFyQ51reYQXyTF+oa/kyaxvjLgf66TSAxelTbk9OGupMC/Bkv4GviwaCyJy1pcAFnYR18+41aNElcKElrwIxiGbw5H0Rx2CLuO0ENy1Cizmwxc66PfnAHwTx5KNHGrh6FNDaPTKtTAjac1ih4SjQUlLxzhwbhuuD7MZpEsaWV6mOmRRmku6AOb+iZiNwMa0t2x49YJu7L1L0cfPrj2QBR2pc2B+GiWvHZB/9o7I/EVPMP5527UrvOb0siw2Hg/S1B70btPdbZSuVN3LTdnXkgxq6Keb2OIhuiv07vPlkyhG55z/znuwfII5KCxt0os7BmajzLYTM9M9oi4bWNGzXh1Q7g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(55016002)(8936002)(478600001)(52536014)(76116006)(91956017)(316002)(64756008)(66476007)(9686003)(66556008)(26005)(66946007)(66446008)(8676002)(2906002)(33656002)(122000001)(83380400001)(6506007)(186003)(5660300002)(6916009)(7696005)(86362001)(38100700002)(71200400001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AIce7Wp7xESz3IOmUJGZYGLeuy5DXBrrca5bW2FYOIPR+c5Xj2ldptrePm?=
 =?iso-8859-1?Q?x7afdFBCOqXrGKhUuIUPbtbV8RUx8virDKoJWE4lzC1u2ItueqECFJRR1W?=
 =?iso-8859-1?Q?y2lpGK+wd34kvZnZMFu/085r+1p8fTp3Muu1HdJ5FBLOxop5hMSkeBVHoX?=
 =?iso-8859-1?Q?PjOIfIHI8OUBMbi5dVnmCoCe1jnl7qLJZ+rQAomm8Qq0Nwqi96z+epIXei?=
 =?iso-8859-1?Q?Oqnz//MG1wxTm6lUTnR7hGC5wt/nG+p9jI0B3kywyf06KOjN+8si4EkC9/?=
 =?iso-8859-1?Q?15A5bgqytf6fNStZgpkxdU72iHDlEw2PV63P2WvwV/oDaUqotQPGZLstiv?=
 =?iso-8859-1?Q?4/yuzQmYVWNpIDv0a86kfNyYOKapxw6nzWvA1FiI8IO4totR9VQRWhEXc+?=
 =?iso-8859-1?Q?2NROT9ZVk3P6QzIpUgLqtTZswTurvOre/x7tYwZ5c2KaL5p+UW4CZF+aem?=
 =?iso-8859-1?Q?l1oOEF646AIPoBfgkkzC40GmM4XUB+oPjAi6KjJBznc1e0Ln1gTDXNPLCn?=
 =?iso-8859-1?Q?q0xXP0rGpA3zs8ZR7f0wzSZMk+xe5n1p5RFKpmkt9c+ZTci1UayXNxHarM?=
 =?iso-8859-1?Q?GsOXffbdrmKbnq/ms0NgTJKTOGVZI403jv8XNPQO/dmmHylu2TQ0xAN1UH?=
 =?iso-8859-1?Q?73l6faAiVOMERK0dmzymKgGv2t5+kkM1YV1yRMfk72JlHoVB8uUxhmjIUc?=
 =?iso-8859-1?Q?YlnNoXj4ftUyQO6DmFzppV3s4Jjzd6nskKZcqcAKIrTUg+mc09S3w/XP7+?=
 =?iso-8859-1?Q?0I0O9W/upl/Hir/mTrDxjwOTdSQypWGhHWSjad8vgs6+imeNIzakVCruMa?=
 =?iso-8859-1?Q?8HEMNzElEEH6zlmvCZdY6v68JxAnjxmoJm/Od11UN2ZRYNzuhVZtzUKO/N?=
 =?iso-8859-1?Q?TjdjBcLk+HIk+3C3H8RAPLlsZqT1KBL/l8wjqpUaJIWFOIRTGkdQcViw97?=
 =?iso-8859-1?Q?W8yODE/RUPLnyILLJoysYvrB1U6fWLMdPEDSRR9gMcF+aboYSk0ZCtWvch?=
 =?iso-8859-1?Q?OLbVVvTz4LZDhjUDOYI7/tzJZgqrd7GpO8pBc8HGl/IJ1oc3jPJbqgLYzY?=
 =?iso-8859-1?Q?tNf/gNMouFhaHEj4hK8+vwhqmdokGO8C0PEPMNVV3+DpVFTAOhp2dQPmyI?=
 =?iso-8859-1?Q?9PyWWo33mFXawVnXbsakcS6dFjKcrodzj5WlbllHNN7gKjFkNX9aZT/vsL?=
 =?iso-8859-1?Q?QarRhtzvRJiT+lwpEG6omsNAAyfejVfmfD6VkHdb9QaGoeeq9lGeWcvdGZ?=
 =?iso-8859-1?Q?Ca9OiuNUdejfLsB2wEz7icWaKmtuWi5tptp5AnCBFGIJ2sYCgn5dHgvGKq?=
 =?iso-8859-1?Q?6cs2UGR7AVL7E07/e8yMjedUVwzi7hHiMIexFmzxLlGytBk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2e1d49-5965-4ebe-edf1-08d94a93d81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 09:01:49.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4T+ShIudvGVrIWsPIIR0b592iIjagbarwXMeDyaaoGfI5Il9k6e0XrZ2IfuWntjGQ7lw54ZUhMup3YPj0hWuqidTSNXzG1PquXkpNhwm+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2164

For uniformity reasons, the service_update_preferred_order shall rely=0A=
on service_compare_preferred generic function, instead of processing=0A=
itself the preferred service comparison.=0A=
---=0A=
 src/service.c | 22 +++++-----------------=0A=
 1 file changed, 5 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 149b66ecfbe0..182a1905c32d 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -5917,27 +5917,15 @@ static int service_update_preferred_order(struct co=
nnman_service *default_servic=0A=
 		struct connman_service *new_service,=0A=
 		enum connman_service_state new_state)=0A=
 {=0A=
-	unsigned int *tech_array;=0A=
-	int i;=0A=
-=0A=
 	if (!default_service || default_service =3D=3D new_service ||=0A=
 			default_service->state !=3D new_state)=0A=
 		return 0;=0A=
 =0A=
-	tech_array =3D connman_setting_get_uint_list("PreferredTechnologies");=0A=
-	if (tech_array) {=0A=
-=0A=
-		for (i =3D 0; tech_array[i] !=3D 0; i +=3D 1) {=0A=
-			if (default_service->type =3D=3D tech_array[i])=0A=
-				return -EALREADY;=0A=
-=0A=
-			if (new_service->type =3D=3D tech_array[i]) {=0A=
-				switch_default_service(default_service,=0A=
-						new_service);=0A=
-				__connman_connection_update_gateway();=0A=
-				return 0;=0A=
-			}=0A=
-		}=0A=
+	if (service_compare_preferred(default_service, new_service) > 0) {=0A=
+		switch_default_service(default_service,=0A=
+				new_service);=0A=
+		__connman_connection_update_gateway();=0A=
+		return 0;=0A=
 	}=0A=
 =0A=
 	return -EALREADY;=0A=
-- =0A=
2.25.1=0A=
=0A=
