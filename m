Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90085.outbound.protection.outlook.com [40.107.9.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926192FB1
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 13:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzdQe0L+P9q9XnHUVsyFlBi9TtxZnsF7XgtHybF8MzQw10veaCnnv839ZfRBzSuqHz/mJ8O9wnpsjdYMQmRYUaY+bjyauoJTK8Z1oJSiTlRFtKjl6tljoWMThg4JvDHGCwargn1KHo9ik5LRQAQYAljE+5sJPY/wiTDw02Gf1x1NKtIbLH7+E/GGWTY/9SBkNCo4jcj3oyn8nK+B+ebv4jNdjy3ZPzy/+x4kdAwXSHHvup/Z/du5LWVr4qanPBSXavbDg8mPhOo/cle9fbUwHrG0blKF1hseTywHZPSQTlyxnNDFR4SSUXzvd/z+YyZc4vf7/fIrACICpU5jENbwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8P78Vj2dHNwLUhYWbiwFr1zqL0ESZlwbIGo2lKjs2E=;
 b=kKzrB/KkrP3ixKFpV96CF5AtHraZFsfxSZl1tIIt+a4JRsWvyr5v8T6srSmOQmaBVCj60/k42bIo5fasP98VCeFRQ6Uqa33Ix6man2fD7Bk+Xk2AnOBhQdjfXzwrJw5qCcG8maXHB080cVaZC0Lb3aWD3GSPEa1DDgbswCj7Bkm2BqMtJOuA9udhXWD84xkokQI2+AjNbRmym+LfCVkPtMxpI2SOBqSvCE1HdUguKuVkp0TR4nV9L3kH1KnSLDz/Kk0ZKkdlHoPxcAPKNGXOwMa0BzJ/eD0Tj2EhJ9WpFl9R9TwYX1QhVRCbjDR+4RzPAqYj8wBqMm/wMJ53lWtsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8P78Vj2dHNwLUhYWbiwFr1zqL0ESZlwbIGo2lKjs2E=;
 b=qUgc2zaC0/yEy8jkII4/WWEsZl/iKEapo7PA7blbgU7w6Ut78ZVbn82gSzZaa/+nuqBDUnKxf3QBzcTzlRtvHcc9F4wiawmxtSruK8JeE05rKNi0xRZjPdQ30D0KdvmYX0nNY3uy4hLsEjaGBeJepyimJWv/V6CgLmDb7vsxLqo=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PR1PR02MB4844.eurprd02.prod.outlook.com (2603:10a6:102:5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 13:41:35 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608%4]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 13:41:35 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] service: apply_relevant_default_downgrade cleanup
Thread-Topic: [PATCH] service: apply_relevant_default_downgrade cleanup
Thread-Index: AQHXaDVATkruXajV7kO02p4ua5SYXg==
Date: Wed, 23 Jun 2021 13:41:35 +0000
Message-ID:
 <PR1PR02MB4794724A7C2ACD0A92E18F6193089@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 563f9bb4-764c-4747-021b-08d9364c9e65
x-ms-traffictypediagnostic: PR1PR02MB4844:
x-microsoft-antispam-prvs:
 <PR1PR02MB48445ABEEBAD8758DF0CBD0993089@PR1PR02MB4844.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dR5EokUy/EXqmvsxANYFbmPQN9mV4H3dT4aQTjn5wrLoPn7cxVSP5RkYV8yEUYilFQn3it5tCMj9LrUfeZw9GYcvCjVM3A1FDmk363OizFJVK5RFK501cFDXHR5FwG8QKGI2FEzLPUD5WX20Mmp01sixDohmdAR9AuMdvujQ/vFZ4BP+baDYJS/17n6hWj4aRH55X5YkRK0l1Kkxo7CymZYwZrOVZqmUBYI1pjuVZeuxbZ3YvpE7JGCJW43Ge2go/fGbjXO2D0hlxmTJJD/icledb6KJIa4HME6iA7ZxzRn6Ns1pPICkmBCdt7YUth+r5XXUIIc74KtjiSt4frM0hHlckSfBDefsM5DR26a0nX38W1KkZN8ExImr3z+UeqtEyKZu8gEwC3yb5twKbhIxqgDRUmvjeu5onCr9LoS5M4MTkwF8esFsbsqt+birZnE3L7AKSUGtIRvC55lqKnbQ+UPRTpAAvJcj5xxE5AIQPK3PgXd9b6ATI74vuMNnF0fwGohbWV6Ie2AAcC2dKq8HqC8PT8+JZZ3xhYkzoOuLolfaG1KJ+5J//P9AaPQ3gYyRS08auJ6KR9PE8VU9laoprIB5dwD8ZUMFOdSBlkjah7sOGJld5WvvnLM5e5eDO7DWorMkx+x54mw0ckBzrg4eLA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(376002)(136003)(396003)(8936002)(316002)(66556008)(66476007)(71200400001)(7696005)(83380400001)(8676002)(64756008)(76116006)(52536014)(5660300002)(66446008)(66946007)(86362001)(186003)(2906002)(6506007)(122000001)(55016002)(9686003)(33656002)(478600001)(6916009)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Yn3kyGSkwzxYdIXJ+2dkfsCYkxQ4Sl7CCUeYJmZMrdmyzapA7qXLXxcGbC?=
 =?iso-8859-1?Q?sCMoE5cmbK1bAL4V6AcrK+SxYGsh51NSMPoMwEs2ZEiBAadp8inxhtfBeI?=
 =?iso-8859-1?Q?MEpcx3XVMlfe0iwmcUJ/2W0PgZ7yF/ou2p2e0UELJ1AKDDP1Zpx1QwPSVP?=
 =?iso-8859-1?Q?hcpYwvXKK/a67kIXT0DOYUCrjNv88nxk/z60E8JmeNJflbLXZw+WbIlWbF?=
 =?iso-8859-1?Q?0LAO9YhM4FGsO5cOekGDVIfacGOqGeI3fsTjC0EhMl4+/LQIvrOcQN9IKi?=
 =?iso-8859-1?Q?ebDdIHQGyWqlOP2X5rF+hHBU1f1x5zSOXrlkbSUXUD7LJBN5I3FmUyonur?=
 =?iso-8859-1?Q?NjS4Kpd6orx7IHTIc8zChv0CD/nmlgx1+jA0jrlC3/YZBdeCmJYBGZgJ4W?=
 =?iso-8859-1?Q?Ujo8xMtHoaXvX2qyKodENwKq0GbCjOKAucJ4xXXPEsg3S3v4c0pH1MxIqC?=
 =?iso-8859-1?Q?c3d1jVFdLx42lOGNveklND8fJiqNDKI/o/ULQQCkovKx25IGfnTNoDlGie?=
 =?iso-8859-1?Q?jc1vRsJL3UXgM/tvYhWrEUgHQn5bX1pYU/WUQqSjblEagZRX4ajNqgcrg+?=
 =?iso-8859-1?Q?uL6GQ5CwV88+SimOQRe/UzWVzEEVt82ra8dbmPBwxnaRPbRrjOw6QtQVgk?=
 =?iso-8859-1?Q?rFf5L6Z51Uh6YWB692uJ1QYIMbYLJI2Bx3k/tmRURotXMii2ejytGWIe1s?=
 =?iso-8859-1?Q?035ef4jLfqLF325UocbN1BCqvWU2JHuIxdUP/DolvlWIeBKRNga3+W0g8I?=
 =?iso-8859-1?Q?DApXXEPcngajMjoFY8KNpOhe42XdWArHBaNRxglBshD/RlKrUe53Ieqq08?=
 =?iso-8859-1?Q?hE526TqS0sPPAh7di6jpGmOUpi8/WF1G3qNWnnJizyGpooSinRhm0QTj2w?=
 =?iso-8859-1?Q?bFpX7gMfVbeV4TjKN0mRZXlPuILPATr9D/Ndo2OLR3mMwA43AJi1WVS0q0?=
 =?iso-8859-1?Q?mpdvNgyHaNPkI5OUHYzuDsUVzuMf3CibNli3LYqYR6kkN50t7ky23EpGoF?=
 =?iso-8859-1?Q?4a9rFTTT8OSlq7SeNFG2ZfjLoxBZcC6DUaDHvr7FOwCQh8UaHOeOP+gll7?=
 =?iso-8859-1?Q?dM0kVgO1781dQtHR0nSwjuXqm0ag+V80g2M5N2ksdZbvTNT4fdW4ssbCl0?=
 =?iso-8859-1?Q?09KTNqY2ChBnWGQYwIeELgT7jEEo9HnYhInzdkzOTafm5aIvuoJ7TRfTdS?=
 =?iso-8859-1?Q?ewYZ0JgMdn/ZHOhrwkgPNxhWGrC68QiGtNkANkMSIGq7hnNINqHU2RCgQK?=
 =?iso-8859-1?Q?twbkMEf2GHJwGKNuAdEYv0xSI/JoAp4j0vISDwEobrYmccgHi8/VwNsva2?=
 =?iso-8859-1?Q?AlrzxBEN1w0bknOVrIULnhYHcQbGr7aUk9leYket2j35QL8yTsptmMFuwH?=
 =?iso-8859-1?Q?icUYknOueIkTu8ADhJww4DoK/A8cH9z+7Kc7oRAuN9LEzzNi1cJ98=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 563f9bb4-764c-4747-021b-08d9364c9e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 13:41:35.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLFzFPTS8AVi0fF/qaHmvtYH/bMmEmnrBHnxmYhMuojOoucvKDqFjcW+aHMRSyDAvPaB3uDRKgEKhYz5WxgarcGUd+L8zGavKORpW7YtWXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR02MB4844

For uniformity reasons, and to ensure the state coherence, the=0A=
apply_relevant_default_downgrade shall rely on downgrade_state generic=0A=
function, instead of processing itself the state downgrade.=0A=
---=0A=
 src/service.c | 10 +++-------=0A=
 1 file changed, 3 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index cb0103fd7221..13f619be7066 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -4711,15 +4711,11 @@ static void apply_relevant_default_downgrade(struct=
 connman_service *service)=0A=
 	struct connman_service *def_service;=0A=
 =0A=
 	def_service =3D connman_service_get_default();=0A=
-	if (!def_service)=0A=
+	if (!def_service || def_service !=3D service ||=0A=
+		def_service->state !=3D CONNMAN_SERVICE_STATE_ONLINE)=0A=
 		return;=0A=
 =0A=
-	if (def_service =3D=3D service &&=0A=
-			def_service->state =3D=3D CONNMAN_SERVICE_STATE_ONLINE) {=0A=
-		def_service->state =3D CONNMAN_SERVICE_STATE_READY;=0A=
-		__connman_notifier_leave_online(def_service->type);=0A=
-		state_changed(def_service);=0A=
-	}=0A=
+	downgrade_state(def_service);=0A=
 }=0A=
 =0A=
 static void switch_default_service(struct connman_service *default_service=
,=0A=
-- =0A=
2.25.1=0A=
=0A=
