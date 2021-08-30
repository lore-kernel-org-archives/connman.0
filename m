Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90078.outbound.protection.outlook.com [40.107.9.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E133FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 08:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwAAMH6paSTT3gE1ue7uH26V3/nWQ6EroZMv25jA1TsEu7no+iK37CfAu6qnCdh7+3YIcjkzbcbO7+fr9+SR2M17bFztnrZcRehVmZjtFmS90DegdPkoQ/vqiw/sGFqfXQKsPMstdJpRcoOEM9/8QEC+woszvZB/A+gpXkdP6OuWoaLcrk+1mj6dC/JKDeKKJgLooqHdQc6vJAmYkvPpN4lxfP2LDPuyJfLYfbWn2l6jkHzfY5J8dvEVJuODL3UNxdcdPS9LlRGH0p5gXZrBhA5YDyJm00BxPq4ckT0QQHTp9geEhyM4JiX7YOs71Fc9vmlb9qSrD+AeE39tW9949w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGCpACpbrumPOA0g3cFOZz9RpPmDktfKxTKRhWnqQcw=;
 b=DpvzIO/SjeG/srQ4k+6ULYFcxMlnQV4rSx2Bvu/nAvPiicifK7dQC3TmxnnexHQcObKm0XVLAPM3jLMgX/GbgOqDKG/fMtxwcuWMpHDEziKzL6X5WcsxlRDVu/NC0lGtXp6qxpUrSXw1QuKxW19arR98CwsgVvfSfP5ipZW0sws3I0vEyR6G75INFWujm1qOj9uTbuLL8/nogCtvZHAg/u85v/gH7NhF4iOFarC0LaDJo9IqSVCa+S6dukOqS3/BjVUwQOqSuPGQ5CEGnEkMuc7/vREsoawaWNuf/5aDFzotIZLqp6sF4m3ykHTOQ3dCkOJoUGteY9z0oBlvez7Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGCpACpbrumPOA0g3cFOZz9RpPmDktfKxTKRhWnqQcw=;
 b=c1t1uOo1UGpYfsZsDhNKEDh/aLY4vLwDwFvUT2D0Dgj1aotjhKb9cNZdgsejZkFN3ufyarNy4fc/clENUiT80ZK31iCg5Y+Q8KRepBN2RjAXHqDEkeXG7w0R9S5YaYS55Y9QZdwnT+Czj7SEmVq6qOJMLt/lZdyaPt69GTDp6b8=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1555.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Mon, 30 Aug 2021 08:28:29 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 08:28:29 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Fix default service update on ready state
Thread-Topic: [PATCH] service: Fix default service update on ready state
Thread-Index:
 AQHXaCl3q3yULm0o6kitbLJsUjipmqsiz8KAgAAOuVeADHiAgIAAA+gAgACAkXiAVLNsA4AGsvCAgADOzreAAAzegIAAAS/D
Date: Mon, 30 Aug 2021 08:28:29 +0000
Message-ID:
 <MRZP264MB154443062A2A5FA083766E1F93CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210624080757.722whwmmwrnzffvb@beryllium.lan>
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>
 <20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
 <MRZP264MB154494B92E616DB754E5F46A931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB15440F82FD624796E8AB394393C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210829190711.3fcho47whyclr2id@beryllium.lan>
 <MRZP264MB1544ED7B886A21B5AA73393693CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210830081325.bt3qwlvsmjilhind@carbon.lan>
In-Reply-To: <20210830081325.bt3qwlvsmjilhind@carbon.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff18da93-f0f7-457d-7432-08d96b902537
x-ms-traffictypediagnostic: MR1P264MB1555:
x-microsoft-antispam-prvs:
 <MR1P264MB15552F6E6EC065B00EAF531D93CB9@MR1P264MB1555.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Q64pCMI9SLaR2dSMnH6QGa3FYO1Xo9asi+cPn9zHH3/Hr1Wjmw9wu3v9GAPZo27vjoVK2cJvPzEe/ECAG1f3CAMImeboGVHF9i64YQjJGJm8ybbO6xzHaKSmg+snUzETnauNxF1/IOtRXAp/uyyeDPrDVHnPPDnrqXEJSG4U4XvsTXXdUeiBi0TU/lIsBfFArh6ePMGJ2zP2O7kfRSNSsPLGrK7dghTJeKggHXgoASVRZaZBD+eacUAbJKRMDTLUC5ows3rvUWgqGtBKm09e+/Y5lhdrqHOJfdlJUUYKbcYI24OLbDxNmnmE/uoBbIuERHBYj64QeKskAPhHFyOgsVt1NhJh9bm1YEcZW8cVL8CrqwdJ1YlAUmFLra0zlALVBf+p+DF3CqsBlyf7dw6c3+lzEkrRJEIWKc9tcgaaMzJ295JW8K79euE2E5WW34iznQYLet3TxYuRmwMJUtBWaUQqv/ILBhQd9BYZ6TRqmiuW30/7E9+Clp5bz3urM51KJRIz60Z0fMrfNLrNvdaj4a+wvov/10YWe9Wgg2sCxUO4LQrs78qEi9TsM/lQUXyaZ+9wrzQKKQ9ytJpC+rHIzSAf9IyQNFHuhiZJ7wWV2060Tt5Wd2SZD6APJaZCje+ZlGQZELC9AG9GQqGhc74ylwoP4zqZlbyQWBG7NV1nDGgBg+Qu4eKQeZSIF+RnYuLQSuu+/540oPEdtTsHiGCamg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(122000001)(8936002)(186003)(71200400001)(55016002)(9686003)(52536014)(4326008)(38100700002)(33656002)(8676002)(5660300002)(6506007)(66946007)(91956017)(76116006)(38070700005)(66476007)(316002)(66446008)(64756008)(66556008)(86362001)(2906002)(7696005)(4744005)(6916009)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PmemfO333062fuuPnp+MQRTvc+H10cFIG+xG23Hn1LuMD4zxWxGakA4mpz?=
 =?iso-8859-1?Q?2UN/m/XZcwKwAAy7pngpm78IpUdPBOwEdZJzpWGYrLkuGsPlh+2HsrB6LB?=
 =?iso-8859-1?Q?h/ee+42ITmHzK2E+ldwvKWMyI7d3mCS6MAl3n+UafoTx/2EP6cYEUEe4j/?=
 =?iso-8859-1?Q?OwCWULfuE/t2m570VrSEXb4xmKpMkOlIeKF/2vMJ+qRSjs/8ayx3cNQW7U?=
 =?iso-8859-1?Q?Bp/3Lt5+V9cRexVLJE/yvlP/D/kI9w0fxVhqn87cEKUajHglJfRT1TOq2C?=
 =?iso-8859-1?Q?qJQwvQQ0l62v71qolZRttegYKXbl1NarNPry9MXSsXD7uypiN2z2HRr8Bd?=
 =?iso-8859-1?Q?6t760uitpWasm/WdQycYd8egP56bbQ8QTRe/r6lPo6cJkzERnFee1YJWqC?=
 =?iso-8859-1?Q?0KhOZ/CoQdeagid0tKTNHGQAJUioT3cbRnqdqBst+hBtui4VsdRRZ6fljk?=
 =?iso-8859-1?Q?qvMjs0N26hjJh+D7Gie3JJqElabOCF1PvIYmVc3g1WqBlwSiOpMacQJx+6?=
 =?iso-8859-1?Q?C2Oj4/Nr6zDvbJ30TMz3ApfuLCYSXyHyT9VrruM1VpFAB+uLddoV3Nx3lX?=
 =?iso-8859-1?Q?JIHOVMF8f/NkNI+UtfIvDx8eeNHvrKob3H+Fpp316SAbjme1x7Qoj238U5?=
 =?iso-8859-1?Q?UFAE6geTaxMbWoGZR7hWlT9hOaSDJiMwHLSH/qMBElDIZnx4g4ZuUJZLPe?=
 =?iso-8859-1?Q?BgAtOvfXsT06jf8TmlvBOB/TE6mEWmFhbT6q+Or5f/lPdAIjGf5qlqK14Y?=
 =?iso-8859-1?Q?AapA80x7ZXI91J/t1A5ONGLwLGCfqtcbm/iN2uoo4tgJ7XCqg9XFdwdrLK?=
 =?iso-8859-1?Q?YrZwKi6/BPZs6adDwb7R6NX8AAlSHp4q91bYkbbhA3GTJJdxe4Fyi/1qiv?=
 =?iso-8859-1?Q?XQPkAta48OeImJ7cbp+EZW7+JPxhN9xJxLrTqVLDVOuZble75/jbQPThqX?=
 =?iso-8859-1?Q?AQRYsnmdDZGL9JdyjzuhiVkUL6Kc90VpJYaLQ19Bvq/HbXojRh1+I08gnF?=
 =?iso-8859-1?Q?TX2dEoNUC7+odrfHAB1nmDlefHJ7hk5Md12tHmlt32J6jR0XH+LWZeG95s?=
 =?iso-8859-1?Q?R6n8K2yZRZFXxZfQFsfM81p9e5X5y/JM+RXQ8nnBgS2rlrY2j0KSojrQYs?=
 =?iso-8859-1?Q?Xg/ApbRs1655R3v8KBpo62FlWkqUjX41vEx05xnkVle3wb5mj6H+CghBD8?=
 =?iso-8859-1?Q?0OAZ44a1qFFRVCwZdweYxkMw+5Pi0fMsUYJeKT7Up2o8E5Sm2VZiuaN8hu?=
 =?iso-8859-1?Q?hk4DzkiLWACq4hIZlcsLtCNxW88/UVuN9sDY6fMROTdcG8SHeiMoXtvZGN?=
 =?iso-8859-1?Q?vHyyXgeGqR6aY2lnaBUakapK4q+/dg2vGJnSAhIPcaL92TKxg33cxqf9of?=
 =?iso-8859-1?Q?sHkr/cMsnSQDwzBB3fmNYRjmsONXG1cBswykrGnfjsoQx/DOOOsBg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff18da93-f0f7-457d-7432-08d96b902537
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 08:28:29.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xfkc1z1kJ1GrGVNyVqdpe2iNkIwDYnV/LmBKmjY1nYym7xJcFSegnQANvDHYY+9eot0HikONvsyCdG7+DlZm/b6b0zLfQyx9NsUJx+Z4JBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1555

> No problem. I know I am bottleneck with upstream work. Sorry about=0A=
> that. Now I just hope we didn't introduce new regressions :)=0A=
=0A=
I can imagine such a big time-consumer it is!=0A=
The great news are that I have no more pending patches.=0A=
And it is right on time, because I don't know how much time=0A=
I will keep working on a project integrating ConnMan.=0A=
If I can, I will try to integrate iwd and run my full test campaign with it=
,=0A=
 to check the regressions, if any.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
