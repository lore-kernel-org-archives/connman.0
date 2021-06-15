Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCF2FB2
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 09:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU/W/EdccotU5pPhc+ROvwGM0j9eBm9KUff7EGlJVMT7C0GX6Eyke3NkFRlvW592jWY57IctWpf0caTamslBm7C7vZPkKs0OOZGCMgJZPzwTIXja3ACcHNSaw2rqGaPA4K5Hsj2yI+5Y13SpoVVa3ZKFEdOp2YMuaQiYGOd9iYOOUpMTREkrmyMWW2CyQ9hCwMsf7z7okkzQhaHyRN3Nig6BRo4wslPXlRLKXwrF6CMjBG7ofQY4xzZ/yryPucHqXAUeBkoSIpRSw1Jvq0o/XaajVF8wPLqlMTg2JWOlgZ0KC1M72v++RRck0KuSIHqef5pA2MAKX3G8soHzoFYBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzz6TaKDJ0ln89oi2DN4cNQ+EsakIshOkuIDfMtxzrI=;
 b=Pb2mw09P/hLENSamXF869FpkffqseEjJUBBvzY3F4EW5+rBNGouaIOsNHt3cwmMSoT+was9+KPPx3JqfYn/EQ3d5cf5tgc2WfTB5llCawB16pqbR5DjHFVNgRe6ffyJPHjPQMIdXne5XiqF45izqZPDUGjLFb/i23K3kHaEJDQexkxpiVAe0KQM7aDQRmIOZh/om/HHaaklY83c0jxSshpSYvD0F2l2BFqK5HJ17yisMBUojRxuefq5mPsgnZ0gKKoYnLSiwnYhrWfXzhss6Xq2CapDH3j8XSSCYG2V8FXAAghvv2J89CP5/PTdPEjrS9FWKP6RBFoLiGzSyJdjPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzz6TaKDJ0ln89oi2DN4cNQ+EsakIshOkuIDfMtxzrI=;
 b=MYE8iaUW5uPWlMrJ9B0ypA/KHFt4zUyabU0GlP8lgvdv97gI/W8zM5pnkx1TLqZe/G6BPWn4IU7ri9NNzWY47mtokdLHoIHHhDzIb1hZ8LnVk309kf1zfXIFUkPa2XU6pUASPs0OagSEteF4aoamLid17F1EPvdA/xM6HKMPGnk=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PA4PR02MB6768.eurprd02.prod.outlook.com (2603:10a6:102:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 09:51:39 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 09:51:39 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: =?Windows-1252?Q?Luk=E1=9A_Karas?= <lukas.karas@centrum.cz>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] dnsproxy: Suppress GCC warning stringop-overflow
Thread-Topic: [PATCH] dnsproxy: Suppress GCC warning stringop-overflow
Thread-Index: AQHXYbra7GMZXSnru0uGp22q94vg7A==
Date: Tue, 15 Jun 2021 09:51:39 +0000
Message-ID:
 <PR1PR02MB479414C6FC276ADEE776118493309@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: centrum.cz; dkim=none (message not signed)
 header.d=none;centrum.cz; dmarc=none action=none header.from=cpexterne.org;
x-originating-ip: [194.4.243.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e72ecc5-8ea3-4452-5e32-08d92fe32c1f
x-ms-traffictypediagnostic: PA4PR02MB6768:
x-microsoft-antispam-prvs:
 <PA4PR02MB6768447DCFF7C1956716351A93309@PA4PR02MB6768.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3d0hxZY7Hq4f4xHN7VHKcc04s+NYJLpdgQP7BsJwsG4LCteZ1spwh3PeTxvE2rbFvfTN/lBTnpZCtbcVAXCU0L7ask/mpb4SSO2qL32YtPR1dAClTPc7e0JrFnzWkwSfp1MEKWb2LzkSHcjEusZfmv9SUASE7Cuc7Xp2YuLoeo3zrod+6kyLeISSyKeGNlOFE12xp7upo3fjE7Rsq1kT5ed2xlBLCWkxxz4hhUkiwnTM+/NjKI0VwnoFkeyU0EsiwdJXIn4YvKbswSXJOQV5eSbjjuO0uvn4eEq29pfGQPjmljqRzdiqOqwckJATNI8c0Nw0OZKd6iDWY1waMUDhVXHStIoaTXZD1lQyh/jmSSJcWAGQUU6V8213goMtcCjk6C6Qk0sI+vmAbzPYB01XAvOjzxlc9PJ5rEXHivwXzvE02HTYTi3w17auHTkcEYhsaD6plPM3ee00ldPS1uAS9SxfEGDAAFWkuKWgSnvJlYcVe6ElnsRKqy5IUiuAvYLdWHW/je44Y5opzFjbwIQYichmwMwsggAkUp6XvzKRbEmSG/9Z/kWcWgLxxCC6qHkKLhi8hShxl/NBKyYHuRV6uzNz9LLbPywbJtg4AytFdi4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(38100700002)(186003)(55016002)(110136005)(33656002)(26005)(8936002)(83380400001)(478600001)(8676002)(9686003)(71200400001)(5660300002)(76116006)(66556008)(66446008)(64756008)(86362001)(52536014)(4744005)(316002)(6506007)(122000001)(2906002)(7696005)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?ZvXQ5wPVKJVRcL0EFYOHlgmsiKKxxyUxhd+7Xqk7JEt2mSyL5chrwp6B?=
 =?Windows-1252?Q?Go0uP0R2+R13FjNyFn/KtuOX3nEFjBAbszQV5pUPzd0EL3J+xfV1y59A?=
 =?Windows-1252?Q?LNJNYzznOyPqaRIxQJ2FlA0KR8V1VMR4GPRZTMopzFcufXAmSJ+GwLak?=
 =?Windows-1252?Q?Hl9vlyaSwaNMSuA0x8OnocFW6mSBL4VwW1utI+qG55pvGxM9jlmNdXSn?=
 =?Windows-1252?Q?fHy62F4j0x5GiLbxr/9sLcBKlAv1uDuHzbQGVzWzeIJ+Zu3fIpEO3ZmN?=
 =?Windows-1252?Q?Xvej5DZ40PxlczH9QKF5OC54le28TyVwY4vUuoTP7QGG/P2LNv7DCNTY?=
 =?Windows-1252?Q?yas0h1ZjI6UkCPT/l5k0zqpw72BvTl5fK6/6OXakdsDxNTMYlzCZTWmx?=
 =?Windows-1252?Q?AtEW933AGeC2jEeZtgr3w21g2KMfiPaEF5wCRQn5ouP9O8F11TKeWWeh?=
 =?Windows-1252?Q?5Wbg+6AGFBrlWgDgFUYbX2gbFyyO1njAsIjwq+2dqwmbKp++efR84Yij?=
 =?Windows-1252?Q?Y8QWi/2f70KTufayPf/OBw2zK4PtOpHF3krZg2tOipwvhWvGVp3Bb4QX?=
 =?Windows-1252?Q?nIkSlkfJmQ5TkyrK9xGZgMLehz9UrjDLDbAc5WJlnhkPW+w5itVs9IZV?=
 =?Windows-1252?Q?2ekVTSAmxPr40mILbuL/yLJrEgD/3WYKSwy4qbXysyr+zDjGSyiq+YXP?=
 =?Windows-1252?Q?jgTgygXxU+8pZryNSIR8BfJ+/Victa01Py6Zeo1kc195VD1TiR1Lc1WI?=
 =?Windows-1252?Q?T5IxXA5s7xc1ubukoaRcAXBVdC9Tmp7VT4xIc5u3nDBVppXZHS7KpDql?=
 =?Windows-1252?Q?G3U0KPUcs5hqFFl3irbLWjlMUhG1SPOl5gFPWjWFRuHvNydsWr1jV8N6?=
 =?Windows-1252?Q?R6WuXYTOD547TGRNzwshJpMcS+MKYCafYgHpQ51r39nZfZUniRYw4fW4?=
 =?Windows-1252?Q?mBOfdaRyG46pnkONWAdX7x992Q6yK9pal/oYVRGnWfETm+vzf6FTMYjF?=
 =?Windows-1252?Q?bO1iHwRg5aS2erDifu4uHHvW2ebKDl1nwTBFBGnu5PXgT1rn+Jq4YXIM?=
 =?Windows-1252?Q?b7mnT/3s4Moy/8/pYYVJziAxU8rSrBDGDQqBRDgTolNUGaGQTXmNBney?=
 =?Windows-1252?Q?luJOWwuUe/48faiYAtVH2ZhvDjnTlmLwM3wpb7Y+ieExzABNK3kYhILx?=
 =?Windows-1252?Q?GB924Z3iO6kTUO0URKxppwSNhFLBLyq/ZNNeEI1LH+SFnHffkJU5jd5J?=
 =?Windows-1252?Q?7Akrk5WwKDdAJNpM7ywJ2sMwK5rNS4wuJGFzZ+Ih9f5dV/RMQCvEhYwn?=
 =?Windows-1252?Q?4y4iUmQwFRvH4vxrW3VKwbWeYaLjFfy7sHrv6czJu9q6V1eOhMzJ7J9+?=
 =?Windows-1252?Q?NsN8fqNGo9CltDm9H1lgQRXa43+Q1LqW/tY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4794.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e72ecc5-8ea3-4452-5e32-08d92fe32c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 09:51:39.2891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zJ7klqtdxFzAOvDZ4QjRI02avf0CYv+BwJa3pAOcCkQl5vQVwFZtz6LixlIfbdxdPRNgDNhPeMegfPVtoYnwBO7v1E1llWlYD19MFAJyDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6768

> Recently added check for buffer size breaks build=0A=
> with GCC 10.3.0, its internal analysis suspect that code=0A=
> is not correct. Build fails with error:=0A=
> '__builtin_strncpy' specified bound depends on the length=0A=
>  of the source argument [-Werror=3Dstringop-overflow=3D]=0A=
> on src/dnsproxy.c:1794=0A=
=0A=
Thank you Luk=E1=9A for your concern.=0A=
=0A=
> I not sure if suppressing compiler warning is a good practice =0A=
> in Connman, but it fixes build for me :-)=0A=
=0A=
In fact, the warning are useful to detect potential issues,=0A=
and normally you can trust them, so inhibiting them is a bad=0A=
practice.=0A=
Moreover, an overflow can lead to security issues,=0A=
so it shall be fixed instead of been ignored.=0A=
The better is to specify the correct size during the copy.=0A=
=0A=
These kind of work (warning fixes on gcc update) is =0A=
usually done frequently by the team, the related commit=0A=
will probably appear soon, as it was done with=0A=
90f0e412569b327d8b25b834623b814f1fddbd19=0A=
& 3dbcc963a66d43e4ac51c97de4fe116ec72eb9f6).=0A=
=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=0A=
