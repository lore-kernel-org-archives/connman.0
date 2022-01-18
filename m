Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120073.outbound.protection.outlook.com [40.107.12.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0C2C9C
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 10:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aok9oxaf0wNYgDFHrHobHo6gxrAcCFt61V/60jr0Wmx9uRUZloFx516ZJOHfAZ5JQ7rg17WeqOk0x7+XBcvfQIgAoQbzht5dNtxNUVuU46GwiJ8G/O3qMHILvcgDYsUscggT72Wv1iqU+kalYG0trsuBDLqJLtJoEYQcAF5oYCnqXC1vUVLj3PhBf46A6zYKsUdjecPkh5yKJBj1kDhaZFVf//iXcpbLB6tHoxjxf6nRfUw3QR53OFzVOUtPKyg3H6Aammup/Fu8kFyCwyEr43uJ/y9X+vWT1HaUv1IhkMqYLWyVJS7OUVe+S4j2FIv4TliiDdU08f5F3AO5SUKlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOBz+AlFZL+8BpBe6zPxcApYVy+bt9EsE04TEkdFxrs=;
 b=TMvVwQNgNd+YPayWBXBsyOCxlcDqT1n5cJQ5N6aZmWuIyudZKgeV8EAlXaFWeZX08ZJLna3f3VGjnYoD7Dtoj4GPj/kK5anU8kM9PpxyAke4NDahkWWCbtGylAA4OXBkZxnLz0PDQ8XXWntGPpEqGr1Ge9oysezW9RvOH/+S3yX16Iw9V3ib7qtWwZafry1gGuT830JbgHuOyT3OI3LRoirfKBkh98pk7hI/ZxVIzXFL8RJmb3SMhbbJySQd0w+Jq4T4o1B3KzZiPosu0zkENkyb7suQQr7iLzqcGworwdh4PD7JJZOx0Yg+FEb+WhWnQlJ0/E+T/NIS3ZdhoM8E/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOBz+AlFZL+8BpBe6zPxcApYVy+bt9EsE04TEkdFxrs=;
 b=X8aCd93vem5cu5hXc0EA4CN5jVX7z6h6biPkMrBuSEzbbsEjeXb7gbOOV14quYUU2fwPH85wtxtgb5L70aJzmYAs3glHYQKz5v06eYEZF0P1mp/+wkkVUFnml87NSPYgP2sIR/1nMUjkV4LvZ7hZosMVndioFEAn2sDZMTeFgY0=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2620.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Tue, 18 Jan 2022 10:39:34 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:39:34 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Fix station in scan callback
Thread-Topic: [PATCH] iwd: Fix station in scan callback
Thread-Index: AQHYDFZFvKv00kRpGEuWjfSrVy/9aqxok/cggAABvf8=
Date: Tue, 18 Jan 2022 10:39:34 +0000
Message-ID:
 <MRZP264MB1544DC10A3C17E1934D4CF0893589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118102842.1199829-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15441C964067460C12EC95B793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To:
 <MRZP264MB15441C964067460C12EC95B793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: f8b88fd1-4d4d-9a8f-8e76-a8fde00e1197
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c1a9c84-1dcc-418a-213d-08d9da6ed170
x-ms-traffictypediagnostic: MRZP264MB2620:EE_
x-microsoft-antispam-prvs:
 <MRZP264MB26208874B0E27A737F71564A93589@MRZP264MB2620.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QhXWZthYxdXRoGq6x8t2VP8ru9EvLH96NEqDpCknWp+wVIE245h5RhStR0JKG0f3E+t7W4wjSVfMWkGX1Fo0tYjvyAUSR88ZTyx9LiNjRw5vvqrpAagGqcsVVUwqwUXnUSNpZ/MYZ7b/9dSFVFjdAeuZ3sFqWMF+Pzwl+ixIs0ZUOGxhRsUMNC1f98AVbn5mWClQPeZn9wEjLh7BpRK64T9DfA2r/s/n2g4NxuqzwJZ/0AL8gfDmUjQClVzmAZsm5LzZsZU4BCHvrjE1T3J08ONuhsYBK2LejPtShVOVCJvVnp68tBh7cKfr7SGmCQfETDVQ/Y9xswIKOJho0KD1XjPWgk4+j0cbhY9TiKkh41UYpBVM0HqjQllucdTTwyTYJMnCS/5NGIWcQih9xae+GTEszUfpU2ttqFg/WGFJp13xlTBa0DndAMk+mW5Sii8C+r6JquDKltKM4YhbZ4GHJnc8eoW9zPgAGWrw9V/jRdGQare7HNnUFneFARYqsf2YR+tSpA1vxvXSL36RK/6r4LCHefk9T5tchBIrxj67d2mU9/5qGWLTB3xgFk5JJwnx4BlTA0+o9wxjaBYMww8HqHGCtyhAtozOYjwPs2bq47zP5Ht2d5Qqhxqn60w9AKg7GxcxFPFeqnJJpqabDNzEPCe77riOXihOxAQ6nzG8W1gPk8W3/RVtOnNgHDG+JRyqXcFqwyJsE9bcf86IuAwO9w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(6506007)(66556008)(5660300002)(6916009)(4744005)(66946007)(8936002)(64756008)(66446008)(7696005)(66476007)(2940100002)(122000001)(2906002)(83380400001)(186003)(8676002)(91956017)(38100700002)(86362001)(71200400001)(316002)(38070700005)(55016003)(76116006)(508600001)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y1lTaKcRGYl/8U+XDuaUsZNjNxYZb1iUpV8OLXNG0+CtCoEarOmjuFLaCI?=
 =?iso-8859-1?Q?KByAioTNhagjdMjH8bZuCmK2Ljad3+JrHNAjHG5G98vTXZ50wxaumPB97P?=
 =?iso-8859-1?Q?12hmAnrd/0EQvvA/90xh+oCQv0aIpI9XITmjvSkidAro4gUNLDm5dsXFE5?=
 =?iso-8859-1?Q?YOQ7qbXiSRLOW3wu9CniWuQknpoGUTi60aHJcwCh2JrFxDqR7Ta5GHXQk4?=
 =?iso-8859-1?Q?R0tIFhH2EcVMoe1ELGUcCR4xFRzP/iRtkplELgyTuCNgYJYRwY+8cSxPbM?=
 =?iso-8859-1?Q?e7Wde0lWkzoUFAKEBvIbIMsJm3MM5ezty/Cq1oBzSjxhkYTSR7CF+s8j8j?=
 =?iso-8859-1?Q?CLtWIjCV4NpNirhcWw+91RjYj9x9tfD8PgmcGvtIRrf0V/lFEFei5JjNaz?=
 =?iso-8859-1?Q?Hwg/CDH4OZcEUbhQhoHS2YX7l8Whq6gHAPotEBJiGvukRssREqM+KrLXDG?=
 =?iso-8859-1?Q?cN0FY3Gv9c+/4QNXb00rd3DTMjL5CMd7R6sg4yiquqOcjAGHMkmZH+/OXQ?=
 =?iso-8859-1?Q?I5PWsyns5NSGPWDmX0XPqKthYZeb9b5WuAf6SNV4auOYgaPVWD0ms+4DxF?=
 =?iso-8859-1?Q?59L79V6cUk/qRxr05tLbywZP1qsVhmRkwgqVfz8CANlHD+AG4dqvmw/xCT?=
 =?iso-8859-1?Q?88kMRZ0D1fh6TYxfRN+0uVzVqxt36liGD/nxCqFtfCZI3N0Llaz3RrBJq5?=
 =?iso-8859-1?Q?f7RCga1At4whzf1s520QwnMjW40reqIyHi8OepkBxAC31qcaQsftKCBgJy?=
 =?iso-8859-1?Q?naAKqmvdQ3lJtwvZRXcLK37GuURQuEVu/51eugxvTgi2on4Ipio8oy3/jU?=
 =?iso-8859-1?Q?vN+MWTiBcBYFnpHFnWEws/YpdvjNxAUr3WMYwRVr1VdPRGxRaGzKrbTSxy?=
 =?iso-8859-1?Q?r0GJkWE8SHnxA5UJmfwzNSYy+dqGdDY9hVmryi6LS0zsSNwMPdD95lQQd0?=
 =?iso-8859-1?Q?2hCGZvtD79atSp0QjDcvZEcVtgAEemjug8r2758kb+lSIUlMYyvxjnxv8g?=
 =?iso-8859-1?Q?k45SN9vWaAx2E/ojAtLxCCa9fdsOBNRoOM5EL9Kuj0OjZLDLgE1RH0+W9W?=
 =?iso-8859-1?Q?M+skL2ESheBw38WdRLAr2Fj0mp7WBi/L5OOPbdUHpFiEjk/CVX1zhCxZin?=
 =?iso-8859-1?Q?FyEpVmAZFgLX8etknj1lQcAd/B61eog2XqqXJ/CyuqQMO49fJSoe08sSCK?=
 =?iso-8859-1?Q?iv8mdo3q59WdFCWC1rszc4WrvPSGLI/eXz+zTEkpZrgsrviXV3zNNb5byA?=
 =?iso-8859-1?Q?myZH6P5uuvSwpdp6iUTxTA68WHaWsMqXicf1jqHwJ2cqZog9Kdolsidhi9?=
 =?iso-8859-1?Q?nxkVZ7945TAtTCPuEmaLmEsZ5bE9YCMYuiiwE+YV9ivNr/BJFDBVD7GTaf?=
 =?iso-8859-1?Q?OLDGK6lhX8P6ndPKjeW9RN4KpMaqlMYZpKloyJdvFT2x1/mxmxHlM85NLu?=
 =?iso-8859-1?Q?3BM4MTConLYlm9dlR3wQ3YO9h4yYao3BtAGa6Emx441Kg7DUiMQG9puyLW?=
 =?iso-8859-1?Q?ofh9w7HYWbKlBXn+HLvpg6y6SyRIFqtPI6m5pKKXEWgk6IHTe5F7BmU9ui?=
 =?iso-8859-1?Q?vfHUeBVrV0MhDUuA9MYR5fzTUVR4GCBpad/p2sdOOcSh+Ach7/eFWh1MfQ?=
 =?iso-8859-1?Q?qKtRZ6rEy76GR3TNeCYuI/WMEpJ9tS5WeuFtiam7IJDdJnfcnZMkQFqR7l?=
 =?iso-8859-1?Q?9ybOJfLxdWUY/iD9dpLwZnwY9tkM/X4/sRSX+SideETlD74AQmYWWUXyvL?=
 =?iso-8859-1?Q?sCxIKIooHqJLROlntPRRSKEfOvC6t0FOPychcvR+dZgfAohQlp2KfnMz1d?=
 =?iso-8859-1?Q?QpYQJZdTDw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1a9c84-1dcc-418a-213d-08d9da6ed170
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 10:39:34.4211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKQf2bnADhL1TRYFaTGLq5kKZg1BiP6t/Fzv5x6uV7FZzMBE0h41DR2jbVW/B2zkPKAtJfNYCvF8HTK8N0csrh//+ipnZd+DdmPeCMyiqV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2620

The station shall be searched in stations table instead of networks.=0A=
Fixes: 8371114aaef9 ("iwd: Hookup manual scan trigger")=0A=
---=0A=
=A0plugins/iwd.c | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index b0e17a4d6396..bb97262eff38 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -555,7 +555,7 @@ static void cm_device_scan_cb(DBusMessage *message, voi=
d *user_data)=0A=
=A0	const char *path =3D user_data;=0A=
=A0	struct iwd_station *iwds;=0A=
=A0=0A=
-	iwds =3D g_hash_table_lookup(networks, path);=0A=
+	iwds =3D g_hash_table_lookup(stations, path);=0A=
=A0	if (!iwds)=0A=
=A0		return;=0A=
=A0=0A=
-- =0A=
2.25.1=0A=
Hi Daniel,=0A=
=0A=
I wish you a happy new year!=0A=
It seems that I am still accountering the tabs -> spaces issue.=0A=
I try to send the patch back in the message.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
