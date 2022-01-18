Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90052.outbound.protection.outlook.com [40.107.9.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B135168
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 10:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Auv040Xo7vPqeehdHO5G4mGE24WTxuoAqfidTY0imR9W6OH9WGOyLJ0lkr6Dh8GVqxiwq1jUPBiJCIhjQ8TK/pQCDPAA8KELxGdoKxEvb49oLz4c5rub513CCuYlXEpSu6FE5ZbjXynoNPBh5vCDhcXuCbwt2SsJTTnUtO48YuVrEnKKmAc580R0AmZ7CumMfqNo6UsRUXYLDFcv2IbrBYzpD0u0RpFd/xWeemBA6d29LMo9tKVk2WM773W0PQDIJJqGmL6YECuoiMEAzPZ/gWjHEs28lJdx5DK0HElmpgVouXlIdB1nLcNXGk/3PzTgf3RCcDh/uWa6/gBoFvYaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sehUj03Nm+DsNFceG05Kqr1Vu1vBIRvj0PBLMTc5Naw=;
 b=Xg4QSMTr4oRrFE7eCwEmEjhCHgjtCFmnCnh1604kfaY0TqTOWXZeVjxK0RYg/d0u3ELTQRpicJRQCvKJNh/JqEXbygO3j3vTmCrJw5mOOBtqXUITGvpMGPWZCTyMQstck9N44FqLaWnfiACqYIO8fjN0A6Sq2LSWHfgBLodrTmbXxScZVS618Hlo/wC6HfLqZEX3RqFjDC2pJS0NXESyTbJqn4x7FahCFLsas8BjOm0iwYGObiky+qJaWkAIuhW7+vBdL3T0Mc4etYmYVf+XSnux2dh0dW+6lnjtBQc82CMq66GmPVCyQKGKs3SletRa08psb0Wrw4eqAqYtV6zr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sehUj03Nm+DsNFceG05Kqr1Vu1vBIRvj0PBLMTc5Naw=;
 b=yj09s9hr9TescwwVQ9bhx09MTNb1qgZCz9SQvOoq6Z6KDtrp2GyXrp/cZz6YR2/0z7FlLJyCm4kMhUo5dCieMgS1j5d8uK3SaA3WjNEYpTwxowvcnzk/gRvAKD94JD6HeS6PjtyQ2tvhV2cVSi7prYq8Y3gnXyt4lXU8NI+m46Y=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR0P264MB3979.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:25a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Tue, 18 Jan 2022 10:33:02 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:33:02 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Fix station in scan callback
Thread-Topic: [PATCH] iwd: Fix station in scan callback
Thread-Index: AQHYDFZFvKv00kRpGEuWjfSrVy/9aqxok/cg
Date: Tue, 18 Jan 2022 10:33:02 +0000
Message-ID:
 <MRZP264MB15441C964067460C12EC95B793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118102842.1199829-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220118102842.1199829-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: b3b942c9-e4f7-2aaf-1cde-a211ec263739
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5877d2f-cfab-4cfb-94d3-08d9da6de799
x-ms-traffictypediagnostic: PR0P264MB3979:EE_
x-microsoft-antispam-prvs:
 <PR0P264MB397927AB4847014790E4B61393589@PR0P264MB3979.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 D2UfMBnC5KTc9rFND1mTD2OWkUW7IPmpDwYz7ZGjuRPnGMmXcmW81Z62wWhlXJxoAPfCuiVWfYrGUh8Lsbu4wbjxTtLb+owiLykBPMIFqmD1hfZDsd91s+88+cj8NMWXSmaYhC8H4v8lcKMBckdbCpBK9T38joieqVSJzu1A6dtvHc+smHiNS5h8WQmKQR73tVIBLKHcjDcSRwQKA7YjSX05LUiIDhkWnbPComOpnV17OorvYS/invs1DtBVSM3wIFLMljUurD1q4FeJplp6vs4Pu0upYmdUmmvposnFVr10oit6R3mHh4UZtbKy2rxYWQAtQMBG0KuNULkkqENevrqQe5PQIE3S8MnWWv+0JSTrhFrSRXS5DvMUzz0iTvkCLNTxkRxi8LE+jzILs7JBk/NUQ7xEVXJkaku8ygQ3p5NgPjhzauhMsTS5I38U0vj14sIz68z4u1Pn9BKdj8qy3J0m1UcC4FxmD1BeGntfnP5QqIZzIi8mgXvLmkP4a72yUvQ/4XKUjvKYSWtNR5bjUhCl9566nH0VoYEiPE+lBzXoK+rCgqKoW4/O8UQE5t0Qh9kexcIcE5DDXIvLh1qkgZqg2T+OdB3jgDznXsuoc/KvqEBGfX5fqKJ8m+Y7KZxe0Ezm7ScOieeqDc+6xDzJ/uLryCBVhGNIBOuxzfeap8VoYBEJiUAFejc+rmIvqJQpXbIOurPQfg5rmltrCuytbw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(71200400001)(52536014)(186003)(33656002)(76116006)(5660300002)(122000001)(4744005)(91956017)(38100700002)(55016003)(86362001)(7696005)(83380400001)(9686003)(316002)(6506007)(38070700005)(66446008)(8936002)(66556008)(66476007)(64756008)(2906002)(508600001)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?G5mjMOwHqjvHpsEgJiCrulkB7TzjeoZJqv71sZw+q4jYo9nkbJ/6VeVjnj?=
 =?iso-8859-1?Q?IUesEDucObYdmn+s8MeKn5OvXfHs98r6fQZJjM3KLuAUni+qJelxSC25hO?=
 =?iso-8859-1?Q?RnscGQXzC0glI5JfuScyRiG9ByBUBQDZH8K9M10cUalUQU/mxZa0ChYDDw?=
 =?iso-8859-1?Q?GQ+ytDFAN9SFI5tjRZIoB4qy7hWe4CntaEx0gDemEJQUm6AFc3+l5nUrMT?=
 =?iso-8859-1?Q?nVd8n41YRCG6gZl5eqw7B6p30VJI06SJw3TrqS7GWYdhuwWkGN5T2LROEO?=
 =?iso-8859-1?Q?GC4v3WDXUYWqh5AChTmgrXuZUJhdeMS8te6/jOFBWr6vbwOkCuTbOdcM82?=
 =?iso-8859-1?Q?CmtB77yHg8tcHnxGzACMZlBSC4nEqd7fqXfIFPRHjOuZXta7XFwDP8jBor?=
 =?iso-8859-1?Q?dtO7RCbqwF5QOQseldOMPaDlr82hAtzv8Ey75YpWlwtg43iwqHDqEc6ZAX?=
 =?iso-8859-1?Q?VRZibDrsvomZOnqcTBIx8otnxDWNEkaWlme4QRfobSW4Qq/2t0vfjVrTQr?=
 =?iso-8859-1?Q?0mefv6+5XwvQSag4yC8aBK3+Xe3wXCncwA37y2MnlqmJ37UoUaeZC12EN4?=
 =?iso-8859-1?Q?+cd8Ehc8rf0LtjYKB2/y2N+y6TplUfOsQByQ4Q1WqQUPsas883D7siq2eX?=
 =?iso-8859-1?Q?33t3mA4FZcC+FystfneVd/4m3Pis5s6mdDC7fckVRSZTElGG6QB16+UT1r?=
 =?iso-8859-1?Q?49O7DoWJTbRkziEfAUkgLOty8/Gl59xNIh8K7QI39/3AbmTC+aJRA0u5Hm?=
 =?iso-8859-1?Q?DqkI+yucqddliGtr5Ts2/1GxCqAfycHT3E44HKIMO25IRcwBJ7o4lqFgk/?=
 =?iso-8859-1?Q?XJT5J7jy0Qlb0FVvF+CjGBNo/SK7caxKbDJ6OWz8/WfFSBYCHtpW38S5M7?=
 =?iso-8859-1?Q?j8Dh6bZxtVkqLaDAPoE3989vsgTq1fL+BTkrC1f2Ob+eqx+zmb3VFze4af?=
 =?iso-8859-1?Q?NvqJXbuYSCN4OLL+8SqQAC9G3qfobZL6FlPxurPOgdsdYSovkf5GExVrdP?=
 =?iso-8859-1?Q?K3CHipJ07Hmo4d2uxTsxruTqxxB4JNqKaNyeP2GTVbmKIWVyGHi1yzkBN2?=
 =?iso-8859-1?Q?SP6+Gj5IcLtlATdWN0v6eHr3GK8RkQ0o2wDMn6PPYT6VV6yGh/QTI6en6/?=
 =?iso-8859-1?Q?hjn2ShLqMMGvUfIKlYnDrjG1k3TzeBmm4ft0DNiU6tSWQvZoDaY7yyFqsc?=
 =?iso-8859-1?Q?WOInKFaJ881z3Mrzss8S3yhatj2vuf5pV752fraFh3qPUAjmL6BFn7AmwF?=
 =?iso-8859-1?Q?tSJNUO5GZc7tjhH5M/r3JFSwtWjshKef6gkRCE/yrUqXM6Es7IlBxMJv7m?=
 =?iso-8859-1?Q?IGTVW+TB6KrWjB6uTOJvn89eKPuUfUe+lCafSbNlefzApxSj9O9kwNDrMr?=
 =?iso-8859-1?Q?n34tI4t7GydIYn12bl7NG0gN0T5cWPBjfgsraC7mKX0oEMVlK79zX1WuHK?=
 =?iso-8859-1?Q?0rhVANbE4D2qS7fqCIrpiIaz5vjMdxKWWNhiVOap/d1Fs8ma8v8MUgGTXs?=
 =?iso-8859-1?Q?ZoRtzDh7ZuZN6aN/TD58+EQIsfUYdAbnCpmverVoYXoMER1xw5jLuXJCJw?=
 =?iso-8859-1?Q?AicgT/f1HthjO2O/WLcNxwSUkSc2tc7DTlgIyeINEuQqX28y6Z7ZT4UvvA?=
 =?iso-8859-1?Q?L6o21IDDTJzxXCk32R4Pl6Ze1KiW4f+6BAA0DEryl5Q7v5bIzFCTIjU8u+?=
 =?iso-8859-1?Q?9R5naZlflzdv8YqJZ+zkboOuD74XAk3svZ/BG/IeY2THe4g+03eiMgPPV9?=
 =?iso-8859-1?Q?IpdvKAodwGSafljSS2+xMInNMZjH+sXoRC8svDFNPBaxd2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5877d2f-cfab-4cfb-94d3-08d9da6de799
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 10:33:02.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z11VBdgAgDvMJS3PWtfDL84KSU/XnDbKQwBd2g+7ev2pGXVkOoiTKbryysLZe3QB0estrnLkm5Qqn3DXIsUPw7Fhadaw5/yospqxwFwzI0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3979

The station shall be searched in stations table instead of networks.=0A=
Fixes: 8371114aaef9 ("iwd: Hookup manual scan trigger")=0A=
---=0A=
 plugins/iwd.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index b0e17a4d6396..bb97262eff38 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -555,7 +555,7 @@ static void cm_device_scan_cb(DBusMessage *message, voi=
d *user_data)=0A=
 	const char *path =3D user_data;=0A=
 	struct iwd_station *iwds;=0A=
 =0A=
-	iwds =3D g_hash_table_lookup(networks, path);=0A=
+	iwds =3D g_hash_table_lookup(stations, path);=0A=
 	if (!iwds)=0A=
 		return;=0A=
 =0A=
-- =0A=
2.25.1=0A=
=0A=
