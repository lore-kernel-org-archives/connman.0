Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B355173
	for <connman@lists.linux.dev>; Wed, 23 Jun 2021 14:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwSlb5BkfYeSOWlkYxYO9jFNSJoH0dK14E3NMREFOLVhfZOxE71ypyE1EmezfsbXyYrASQeiVvL2IuVqOnDl4rfdEnEQTQd6Qih4RMPg3gN6oAe7tpwRQl1DN9etaJwhG3wFaR/xplUmtk0Rdm6+P3trAv4vZtQDDh0I4P53m5LBY1ekP30uuMYMQx0kUtvDRYYKMMEfCyYwO9ihMzxlZTFWRiuLca/lB94xjVohcd2pELowkxtF55yRGvdfpysfp04LUm+ub2wGd65JkI+G3iXFHkna8DIWO2R96NOf+b68rBtnAqqY2jMKukUXCX5QgLe2Pj3LGfFmKUY/+yk5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbE1iO2hJS9n4/6L2UNiwZd77kM2ogm1ij4VxVTqJVg=;
 b=XgVyIx/+sBqBW0fHsaTL4/SLSkUOnrXGTm64CEL+32vHCezBJfbsTWT8JmDKa1RpeaiNtIFkNpZ6qXCJ5BQU5AWdhyvXt97Ke6P8GO4kjT7GgYZzW929JSeOu8OmVnj3+jTF/Z9sIUYhHkOJEXbEq10FUgMIYxftldcVg9Xa6Z/nS6LseBiwA0qxyzz+hcZYe9isykdJNd76ihyh0jya8bPeISyXc0pQKOSzFuHFZcK01e68xlUZ8lot6vbeRc5bZlZWtYfcViXuMElv1DIZctyq/dN8vJ6lmaVOyyxoR0RfUcLVbhj+obJUn3/5uhev16YElbjzUV/I8XmXsDYwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbE1iO2hJS9n4/6L2UNiwZd77kM2ogm1ij4VxVTqJVg=;
 b=Dad87KsHUoJyfqox4cn0fANhUUnLDDpY8qm9B9Zug4Agb4DRh465j6BFGR78tylyVnxSmMuN7BJXDDhMPora72K5DpUGN1Lvb4y6Ok27RMWhHCGuzLgnjR9zFugwKp1PfNU5fJ44HQgLq6K+SXPGST59YLSH+OcHYd3wyoVXXHk=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PA4PR02MB6719.eurprd02.prod.outlook.com (2603:10a6:102:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 14:58:01 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::35da:223d:94cd:3608%4]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 14:58:00 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] service: Ignore state information in service reordering
Thread-Topic: [PATCH] service: Ignore state information in service reordering
Thread-Index: AQHXaEAKBbWMy4FLOEmVuozxMfJz8g==
Date: Wed, 23 Jun 2021 14:58:00 +0000
Message-ID:
 <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-originating-ip: [2a01:e0a:958:8af0:83c2:ab5b:663:7b6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17f7dd53-f985-43e3-2c96-08d936574bb2
x-ms-traffictypediagnostic: PA4PR02MB6719:
x-microsoft-antispam-prvs:
 <PA4PR02MB6719731A119CDED3824DA4C193089@PA4PR02MB6719.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6XOqZNHWeL5A8PeFsHxBPbGdIoYBWC7kLv2sYmTqafc6GEGkV/u5etFFweBZSyO9b8z0db8jX+QoXLn9m+8wsbOg9/wKnT4FR5euiQX+/9Z5p4pT1knxdGsGtV+yk0VcC9LKsosnEDY4LnHckKd2GuTjaRK5M+0dyQ5X8L3fGqAgD4UOvvWJ/uoIifmtU/vh8YDWl+BrHoeYGOYp4n/upd0hh1bp3BJciIPFlApwnNi7UGQFNbE2BhbnP0Z+csOGaUYYaPdOCjj+X1sOErvtOwGtWYXEUtTxGtqjTLRkw6/mLpdQv6ivF5tp61ajbRk40rPWvmRZiUf98DBHL4/vqLW7Y8ZYxEOZXsRk/nPSLzMYM9F1adLW5UpNSRsbV2w+5Qg2+cStFLehoVyhL+zYxALoKbLIHlmvwRPi4iMuAke/rtFQvYr513Kn+xTQfzUSzxQx11ikytZrTnedhsVmue8IW4eLj1dLbJaBLzOBCDBCcCkOKbDQPf47vZYpN+jyxRi1lo3LCD2QgGqmw6U5fmj/Hy7/8ys394syON2M8SJiWLN5IV7aK3abu3YcjzuxF8ZW27rLhHnXMbqWCf5CbfEjmnLqZfgUl+mu6IqkgVm3kLb7JjGdOYVYIgWyY8ba1RJWiMMRglXbS2OnEvAhxw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(52536014)(6916009)(5660300002)(55016002)(4744005)(9686003)(122000001)(38100700002)(83380400001)(8936002)(316002)(66556008)(2906002)(478600001)(6506007)(7696005)(186003)(33656002)(66446008)(76116006)(71200400001)(66476007)(86362001)(8676002)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?facqDQhJ7hUBw1zfbGQYqPrORbI37pDMUjahXswK11Nq6ITOq89iLeYN5X?=
 =?iso-8859-1?Q?Isz9NVLJ9wvQ/NcJY+8Lvbhn9Hkk3N2mgNabWmn4adjYZkU0jl7w0vdYrl?=
 =?iso-8859-1?Q?MWYkQkPStohDHIBYBwda/4K1jHE8t7q0CaUVM2xHrE9LvByIJq8Gwd9374?=
 =?iso-8859-1?Q?I+T4Jw2o6eK2RjJmki/WgmQfvAnYZyGohUX+ESFLPT+qNYNgPJfhzvKFfx?=
 =?iso-8859-1?Q?9gF9wKrCcfnG4R4xJOICLkvf8ZysmRp55VuR/riqc/Z43wiSQ57P2WkEt6?=
 =?iso-8859-1?Q?7vrQT7Nh4v9XGq74jlOvizxJN22C55oR60A70UjYJNmfFaZAJOp+bDKHTO?=
 =?iso-8859-1?Q?04HRRKSEGTP4FGlCUloI2CXRv2NiR3UoMV6qTr1vs9eEVKddxQIMUfOV7r?=
 =?iso-8859-1?Q?TpvFe6HbDzcy8oSEd4p2X6MCfeV0xsMeMLZto1OBmEOgo+ILgtv/W6lYnb?=
 =?iso-8859-1?Q?XjxSuUqA4kTiB8iiZZbNEFwr8EuyEildVnOOPsO2Alt9AC5drgzKvEUhl3?=
 =?iso-8859-1?Q?AcVewHA38QqWEzdLufPieObIIjcB/gTzCGLapFq9MGCB5KUOe1Xjp9Urfy?=
 =?iso-8859-1?Q?xEiDHGml8QwEgQdLvfwp5efGKYOr+kYmI3ZssfPmDgN8YX/3Ryu0IgQ//V?=
 =?iso-8859-1?Q?KSw2m/+KqpxD1/dnifZbzAJHXl+GnWaI9kMsLlwywO3YoPlgwFzr6+BJOV?=
 =?iso-8859-1?Q?cFOjMFjGuSPqBeOO34l5wq1IAbLYEP1aq0ik0nO9B+XoGQ1gs10RWECZmx?=
 =?iso-8859-1?Q?uXQeHR9DtDq+ljOBzyJ1YYDdUPtSjdOPdVVHYvJLu+o5mMp16ZYF3LyuIG?=
 =?iso-8859-1?Q?ZqfaZ4Mr8eO3saP/oww6H+p+nJ1WtSXtrQRYJatPkOxTntzCkciG1zs3ZX?=
 =?iso-8859-1?Q?3omhXEnR0o55MAjWD84QCV3iohHTUaKM+f3R+peN7kaJhMLmj0EaQFgYfO?=
 =?iso-8859-1?Q?1YPmU8sW9Eg2Tctcd/uTFwdKPWNB//4O6dQNyXIVgA+EVpO1b0c8Emp7D5?=
 =?iso-8859-1?Q?OAywK1cPdkWmGh254scVM4YL8B/OQDLMZWUitQnRo6GHKu2RBJUIBOhOuh?=
 =?iso-8859-1?Q?nmBliuCF7VLc5iAPAnTnSmR8fSpjinP5FLaRQzKpMbNnxNsZngBbQiSElq?=
 =?iso-8859-1?Q?wkhrrFsoRA2QQgb3CsTNMOl7PjPWJ1diT3jZxl4jShbZLjbb0qPpfN1yeK?=
 =?iso-8859-1?Q?R4gG5UddTb2qOCvPnoRjq75zKVCd5OW1HU9i84IC3eFaRzGrniwSv7DrpM?=
 =?iso-8859-1?Q?+iiu4ugnkvfumUU0l8PTx/l+qR5wQmKfuxWD/bl90Bqgp7iwTNUZTcz6wy?=
 =?iso-8859-1?Q?/fCJCD++jVax7JxdLZQSU1iyXZJdQyf1fgrIJYJpEAMtSlg48g2kFAhIcw?=
 =?iso-8859-1?Q?jPqnp/kC4BqzBaQWPFs4XCNbXmg3oZSvLNPm5UEEAE9OE9KXVZ2eE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f7dd53-f985-43e3-2c96-08d936574bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 14:58:00.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kV6Z+j0kDAc3XZ0Op9ynR3SjLEAFd+GXHkDpmvaTJmTAz7wCWn6hhP5UDBnwMoCS9SePlrldwzTEzUt80SKBtjmnP+F7hO5fUzpJFDgRCGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6719

The states of the default and new services shall not impact=0A=
the preferred service reordering.=0A=
---=0A=
 src/service.c | 3 +--=0A=
 1 file changed, 1 insertion(+), 2 deletions(-)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 13f619be7066..222f811c2690 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -5894,8 +5894,7 @@ static int service_update_preferred_order(struct conn=
man_service *default_servic=0A=
 	unsigned int *tech_array;=0A=
 	int i;=0A=
 =0A=
-	if (!default_service || default_service =3D=3D new_service ||=0A=
-			default_service->state !=3D new_state)=0A=
+	if (!default_service || default_service =3D=3D new_service)=0A=
 		return 0;=0A=
 =0A=
 	tech_array =3D connman_setting_get_uint_list("PreferredTechnologies");=0A=
-- =0A=
2.25.1=0A=
=0A=
