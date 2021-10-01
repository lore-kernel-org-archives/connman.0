Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120042.outbound.protection.outlook.com [40.107.12.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA73FCC
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 12:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4T/42rJgpQa18Zyvj2kBxA28I2t7cB3c9+cxpLwrWA491rVms3YOw7+SA3twKPTRbRz5+HUt5St5X3x7yY6HCw+6VN0dHKwZWkRifVtXEbp2E/hAewbRI+7fnxfRsOTjMbf58WoWcYcVZ/8ilzYAqfulaybO9f6yizOtKcLLwQriXUGz04o1/J1zbgvG/LD0JT3p3w7/zEhEapE+CHfNex07ozWTV7ln3bw+11iNFM+TjvZvsZpJzfhvXJMrRSRgizJZSvbaRuqZPLKORkdOLxM2QhCZtvgGyFfEAiBxJg7JcI2VtgLjS8dYi7i/NtWDigle5HLnNr73yMb613gfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4LVqHUVnuR5fsNAGylwxNrPf4h+O9RcReY0Hez96Kc=;
 b=X4fxQCUrSSsJbBM5rsKXY5U7pQFnU4kTUYOTN0NqyMWNlaGTT5DMN6s1CRYuc7xmNwxgWCAN9QZPPDBNCw0BCxYV+micsrNVThmiWHzwAMRS8dlWQVSyMgnDJAcjFbDM3pQyuRZv/4qltsjFkjuSnSn6X50IahsUY3aacJOds3q9S+gXqJyNVwK1T29umBSU+3zNtl1EjsWFw4UrNnCpNFnf710kokftAqRHB3/FdWW+CHfyWH4mUCoZCfcKDuv0bhPLjw4RW1JLXuzEVZTAqXSzfAKE8KtUfOuQpUjRoqkL2JnGYrUlZ8/kkYLqgngCrDRkdC1v7TPgNGIkJQ7fXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4LVqHUVnuR5fsNAGylwxNrPf4h+O9RcReY0Hez96Kc=;
 b=1Kjz6bp0VOvQiXKPl+fKXuXmmbjJruBln+fGhiu5N0Q7GmweufqjnE6p2CtFp+JtTgwKIBFNK91vSzbcSb1Ye8zHaEhFjFLW8UlkEtzUbZv63Qrqb5geEUowFUiqQU2VH7XJ2ljipZd3Q7SZEauSGYLAA8tJVc9ACC2jEoyv/vw=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2580.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Fri, 1 Oct 2021 12:20:27 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 12:20:27 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] service: Report errors to user in native mode
Thread-Topic: [PATCH] service: Report errors to user in native mode
Thread-Index: AQHXtr6T3NUblXLl20K2GhnbRyD0SQ==
Date: Fri, 1 Oct 2021 12:20:27 +0000
Message-ID:
 <MRZP264MB1544E59B5B25F0CF95C7A07993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 15234eee-3b38-8d2e-540c-272cfe027076
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96aaa237-9345-4ccd-6984-08d984d5da72
x-ms-traffictypediagnostic: MR1P264MB2580:
x-microsoft-antispam-prvs:
 <MR1P264MB2580BC27C6BDFEB0F26AC26393AB9@MR1P264MB2580.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WG4UeUuw/HtiWquy8lQwJFMhMXMypg1Ir9iim3LJz+cGf5K5DOjYxhOCDuXh/N4d/c/AxN0daSFRCb1QEbStz1pCuK/iaFJi16RkYuNTrlP/TaRZEZvv6m2AaeCpQwA3QWdhCAY9x2OqM/qkiUHL1QVdbse8hfCh39FwVYFe54B2/btTERqzJWAqIXildjd11qgCdD3OZfMk71bSFMgDUfZX0hHIYqbNh95Jtw97Y0WD8riyk1SYvJj/Jg/YdQR/7kIZoPT/eHMKKKHzBM9gZMUUeSpbECqguhbe4oHqpyvLC/5PGgygORYZQ6u0jMBmxXyipFYQgo8b9TArYATtepfXhUNuBY4Ili5LW4UJrxujVnVMIqj6ZvsMBFnZ66xz/JwSOuZJM10/Ir96FKdXfz2/pQO2JiV4gx8YV4bRladEd/7+uCdLpI5QWkJziXy0yODZR5sgNuQQnfAxgiu5rRk3zNcUZBfSyUt+u4w+HR5PZpR01ln4JxlkSysehPQq+xswJ9U9XF9qkbZ41q4vEB7fMnTPAxXJ5+bZu7N29RM/hDFOXJzgiks9HQMK7CNitqyJg3PBLOqbfclXimPWqBZYav56bMi6PX87tBgq5SUp1vV8IF6OzGsc+dxROSOHoKqMqMs2WO70+on1VINHAtshl4YmxwRp7l7/QkpSBf5gyMYSBQ0hBMaUv+gbaMqfhbGknAuIVdmqtYgENFXJCw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8676002)(86362001)(5660300002)(122000001)(38070700005)(38100700002)(316002)(26005)(8936002)(64756008)(66946007)(91956017)(6506007)(76116006)(66476007)(66446008)(66556008)(71200400001)(83380400001)(6916009)(4744005)(52536014)(55016002)(33656002)(186003)(2906002)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GtrS00TcJLEvW3KPetsM6+u1Kf6ioc99qmizwlYU7JaCJ/Z5pAF7dLj4Ne?=
 =?iso-8859-1?Q?94w/hjLpfRQFoYnqRNlg/32oIMMwRBzp/aem46waDkTbDVPc++VzNWc/F9?=
 =?iso-8859-1?Q?h7/5uSJb9HEoisau7EBnmxxBTPJIttT9QRy7ncSJYBMUR06NtId1ccG4aD?=
 =?iso-8859-1?Q?GH1BzmZ8W7E86Cc0lAzjNfYR7sleR+/Ge1juBxZAnr31MfKwbVx5II3T7h?=
 =?iso-8859-1?Q?cOP7Iz0Cm1sRL287L+QTtzBn+Y1ORLwPutNT+PrDYPmd3SzpoBsmiy93Mk?=
 =?iso-8859-1?Q?lLzY/yTlfkiAg4dYM6WXnPqqzrJGH1+cQDI7AfSS+OVmATdnomcxxtDDcM?=
 =?iso-8859-1?Q?aQKQKDP0sWgeB5N5tZCOpuGlEf1sR3HOt10oFTgYOxX336CJ4gXZjg0Wwm?=
 =?iso-8859-1?Q?uCxphhapSUuVSdzF6e593YzfsvUt31Gk1KfE4Xm8Nz+vGfIwGYXmLrcREk?=
 =?iso-8859-1?Q?1UvoAiH+1LqdV27Gz7EskLExf543HPEEZcUcZ9ASOUfrOZulevcWtn2LWR?=
 =?iso-8859-1?Q?50gKdJlCDlblZDiINQeJRPsBanYe/U7qP481UIOGgypGO1eqeBin4SRBra?=
 =?iso-8859-1?Q?REbipY+vMIXzSlhXrMgfU5AjbSNqKlKRrsHo0s8Ac360gX/UzHE1vp+UJc?=
 =?iso-8859-1?Q?hXv2CUju8TuU3nH14fTKErUJSLUBhmO3HX9FUArQlOP9mg67LtRXB6yyAI?=
 =?iso-8859-1?Q?O2bOyik/pSqhOZ5t96Hmo/dfPhzny9xM+hB/TEY3EyrQruNNWOe/oRP5fM?=
 =?iso-8859-1?Q?wcbhY/2DA3s+rxTqWeXaonyp1PQitUEMf6dZUW04qT17yNYkNsIo0TaYVe?=
 =?iso-8859-1?Q?Ch5Fw8XiZVEbe6idx9wA1fvwwA3rpFtNx/4oteAD/MopKOePa/T1wWpB+I?=
 =?iso-8859-1?Q?T0d8w1UacOsW0bCxHbxMbNT2/ROKtN1qi3gOCSgWCv6U0zSCMmoXlauhoW?=
 =?iso-8859-1?Q?qi+kzF98lkQpoF67s5igpvtqOw0GAWP0Osyrz9JQjSBjVMvznjc/oIgL3Y?=
 =?iso-8859-1?Q?v1vnIAlFqA0Zg//FSK3yvDAHGF5qm/piFB6seQne0btpcA16v+/l9YSxtU?=
 =?iso-8859-1?Q?Iqivy3ksMmyTdWCNz+WiOygi6eqxxHED14T/YUix++B/upu36Tu7mq3N0X?=
 =?iso-8859-1?Q?arGdtieVkuPv0AgDElvy8aqzbwbxUzGWCF2Li6fnvk2kNxt7ZYZ6PPzLg3?=
 =?iso-8859-1?Q?GYo1TrWV9eUWvp2Z5Mef6Dy+wPEiZxTYOZhsgpADHTFKj6rSi8IUU2K0E/?=
 =?iso-8859-1?Q?f7kvFCpBSyfqMhZ4sIUKyM6jhl06ho6WynbKA/IxI61V4iMzS+jEXAwJ4v?=
 =?iso-8859-1?Q?TRF12ey1EZtYlIrCSElRFLCZJiFQlWNhk91DFo88d95m/uA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aaa237-9345-4ccd-6984-08d984d5da72
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 12:20:27.6422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7LG7YgYtNbiBad/nNOaKuSc4JW37oBjZoRTvBcymhDHagx42SSy84UgT710FgNAK3mwQZwnf03i7DBh551k+n1ECiH0beF7PKTygrH5gPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2580

When the native mode is activated, the user still needs to be informed=0A=
of errors in failure state, via the agent.=0A=
---=0A=
 src/service.c | 3 ++-=0A=
 1 file changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 8097f5373250..70ff26e6a4a1 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -6139,7 +6139,8 @@ static int service_indicate_state(struct connman_serv=
ice *service)=0A=
 		break;=0A=
 =0A=
 	case CONNMAN_SERVICE_STATE_FAILURE:=0A=
-		if (service->connect_reason =3D=3D CONNMAN_SERVICE_CONNECT_REASON_USER) =
{=0A=
+		if (service->connect_reason =3D=3D CONNMAN_SERVICE_CONNECT_REASON_USER |=
|=0A=
+		service->connect_reason =3D=3D CONNMAN_SERVICE_CONNECT_REASON_NATIVE) {=
=0A=
 			connman_agent_report_error(service, service->path,=0A=
 						error2string(service->error),=0A=
 						report_error_cb,=0A=
-- =0A=
2.25.1=0A=
=0A=
