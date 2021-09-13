Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90074.outbound.protection.outlook.com [40.107.9.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA13FC4
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 07:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7rYFMMln5YU43+OgTs60mK42Ng/DaYIbVLDwZLc5F2Drvxvh/KwhQvU0eCLdWin2vAjSGVh+S0bDhUUDbSpmGG71Wz8GruH9LJEVHQKv3kz3kTNuChr0d8vnNEEhD02H3t1ddxGhBPU8akiIx2VmO71daxmwF/2EbzIvkKDKKZIQrM2lWMOImoPdhf0g6aMBp0+Bx+Tg/5XZiVfT+xbt8E4b+7PBeJAVfUdPScmBENE1+Fc2yqP7kHXDcKpjBn8ZjmLyJfxKYAmtqm0rDY19zzPzanf/2LdD9atWOGtCORz0RJv+uTxp8IV8v13TKP5bU+MzGUgzHHbz5g9XYsm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xSLS5tyhDvlpJLpUDwrWDi7bZTMXEZzmbEHEoOl8i5s=;
 b=Rs1Em3YxVJuW2DbktwPsO22c9oUF0M0cDEid7MQKmXDAev0BXvqFkPM1r7ImjDE/cmU4u5855v2vIzmPpFEeQPq9sgmVw9uliiuwo2cg1JPlhe74qW+bkOuBH4f6kyS9FnatwsqkmUAHqnXHNO2KqcRVF0B2Ai/Wvn12EVhAVXg28sKBxQtAWBtSdVeij34vI17Lr493+QNWr31Gfnczm7GoOvc2IFOzucz3E0HsDoB6gSMkHFohz7Bw+wDfHqHiWbllw3iCJeMHtTP+s3nv8avS3sKhzGzqEsNXC7yqamRddGuGdufT5nHmcrRg3l/Ne+t7mWG9UImmNz3ru3aX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSLS5tyhDvlpJLpUDwrWDi7bZTMXEZzmbEHEoOl8i5s=;
 b=TkyX/maYkGJI8Sd88Ioc4N8H97j19sr2o83T50qjJuIesUvfQINyVtkwY9RcwE7pM5k2B7NTmp4RrAOFpXJKcbetzTweel6mtNcnbLZLACS4cXdFu3D2yZ1BdhDSMrl5QFLRUV4/1d74hVNy/e9cYLUe2W+14qOFrEdLyF5mSJM=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRXP264MB0357.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:18::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Mon, 13 Sep 2021 07:45:19 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3144:388c:76cd:f14b]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3144:388c:76cd:f14b%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 07:45:19 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] build: Fix compiler maybe-uninitialized warnings
Thread-Topic: [PATCH] build: Fix compiler maybe-uninitialized warnings
Thread-Index: AQHXqG8ix5L2wlh/SEuCsXQ5xgN7rauhkLOAgAABenA=
Date: Mon, 13 Sep 2021 07:45:19 +0000
Message-ID:
 <MRZP264MB1544BB065A7FADD9BC38F69693D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB15449CB6E42AF281B16F54FE93D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210913072719.3qlnsqjzplntm265@beryllium.lan>
In-Reply-To: <20210913072719.3qlnsqjzplntm265@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 6407c8f7-15fa-6603-57d7-7c1734626ca0
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e96a22fc-7ba7-4d95-06ea-08d9768a6f34
x-ms-traffictypediagnostic: MRXP264MB0357:
x-microsoft-antispam-prvs:
 <MRXP264MB0357FCEA67B0CE036E5FCF5693D99@MRXP264MB0357.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H6aeVs23AVmmttrK6BBErQcrSPwxD8UocrQoHs2Vi/ZRhEKrjRVgUt8P75m/pIbGumfRqzhxiVpnn0d9sUVK1fqZn/UJsUahNJqhGP5SEF8Brkl/mRJspuaf4uoArb5irmwYMK3+Ydow0ZS480nhZ34mUuJW0Bz06veV1HGPFwqsv5DrsjJqXzJKxMOuv17M+/0zJbwi9q4TCeeELl9s2S/MA5yub+/ui56yGAWcgTo/aHukH6RyhdZrUFcJmmdqJv3u3tuDUrD1S4JDV8jEDsrF1jhB4mBzkDMeq4PJq5T7F+FvlJFQAkCWYNLKP0Neu358rhW2/TClA87ZVaGm1BOj/B9w4WrfwjZl+KOVWXINlTEf25frbLlbEomPjJL0mIbwFgK/bZ7DwucPK4oCb5MfGrMrGzwVcbPBl4LbzatcY8EOwN0y46cLoFDdmjEbxv9vKOi/Vjktq+phJHsHlhsvlIHfIZBa0Ey7xCqCSrf79qbEUjPLzDQfAqPJEs53EciCi92sWWDf0A7600ShxbvEPteW/A1ooew4dd3zoNChl+Z0alk97OKNW1E8QHo6blXW/P5Gfa3feNtSIowh3GLA9/7X62DFIaekw0YSUOtNA6Wl+/OuYLKxxWAvkRF/9qoaT4YOD7UZSx477airb7gubgpe2E0LTu3UIzyrCCRz/NDhdxd4PByxXbC6J72wlvWq7K1Z2mVPNMjtH2invg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(9686003)(83380400001)(86362001)(8936002)(6916009)(33656002)(26005)(2906002)(38100700002)(66946007)(76116006)(91956017)(478600001)(4326008)(5660300002)(7696005)(71200400001)(8676002)(122000001)(52536014)(66476007)(66556008)(64756008)(66446008)(4744005)(316002)(38070700005)(186003)(55016002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zB4jTrdpcdS9Iji1r7TrujHSNjmxfL30PwQ+fRabeyMI9C3N+JcvnHxd5u?=
 =?iso-8859-1?Q?ScSaWQWpXd1pTmyJd3m3xj3JLlSHvWSs6ewS3z0bWGjyE0cy8djrS37QQ4?=
 =?iso-8859-1?Q?oZG933AngRUXKSVnOwTCf477FQg57P8tnTydQZ1iZ9pqMNlA3Gg2/gBKjz?=
 =?iso-8859-1?Q?1kZeGibVYYfQ/apoLFgeIEsrWQYA//6isgQdCyJckNIiSCHB4V500j+QdT?=
 =?iso-8859-1?Q?N2IyJA38C55MiqmzGVWX1PjqHnq2MZVlqXrPNOmv91KQP3S20ZiHpSRMAT?=
 =?iso-8859-1?Q?Ypxzp0Bs7ZAS45acvDI8jYg9HXfqKxYktCsbqs6gcoJdNvy2+4yXHt0BZl?=
 =?iso-8859-1?Q?aDhKI/Xgk5MLhBQHC4ZiCq4Z+8In1Ak3F7WJE3/n0s8MNUCPepFqtGWYRc?=
 =?iso-8859-1?Q?LNZbOthMcj7NYra91NK+YY6h4VavHOijh88dg1PPqI4gIDLp7mZUcSJiWB?=
 =?iso-8859-1?Q?tL3ItloS2UNPtmaJCAwzer2dsLgCXU8vACcJi0PspeSnIcNCx5p2R2ibgD?=
 =?iso-8859-1?Q?FqiAw5bX2w312Gruccix2ZwXsw9CkfOqbHem4wpFjrJdPGrNSEq/2Z4mgH?=
 =?iso-8859-1?Q?2JQ9ARUdXNOeLNhoTiYERQwBVUjmWj0hV8m6BDjC3VYOJOsKzWjQ7C0bgY?=
 =?iso-8859-1?Q?j1BoBYBFQzgfrk0iOSc/ZwaiCWhMlqDVo/K44l32CdHgDOWdwvlwVm38ki?=
 =?iso-8859-1?Q?fYZi+1O1tq+ysM3DzItbYlgNEDCphDvt/B1Hhv6svvO9ugTKSRq3CcbAnC?=
 =?iso-8859-1?Q?GqjC9gIAJqVrBUIuNGBOC5adq4CCg2nvJxUG7VpRw9pvZanZzQCjJQ6r9u?=
 =?iso-8859-1?Q?qxqbx39rDhJmibI2oijz6tLrZqOP/WexwJGkDK1s09wnQ6OeIIjrLCvCES?=
 =?iso-8859-1?Q?BwIEdaLJNw+QDjQYCuZ1eYlf9IhfniF98Yyy6S+gTsH3SRQqsEhnIOrilG?=
 =?iso-8859-1?Q?xXCId/9cgTbJ3KJTW62QQaDRqoojOTtJuw1JjpYBV/u532yyo1XFf1+B15?=
 =?iso-8859-1?Q?2hi/9jqJ0GCPBZAL30+c5unckSwIhaO+5R1/7MeHpfZvwoC9rhVYo15FtJ?=
 =?iso-8859-1?Q?BuALfMmFztcOyc+yGpTqT6ov4jdHz3leKF/81kucSOmaR5RDs8ZoRUHk6V?=
 =?iso-8859-1?Q?vki3+VJ5b4juoq6+UIPH61mW7AQ6sV7ALk9RRzbswM3zqQ5tR8oEXueRo1?=
 =?iso-8859-1?Q?rw+EfLA0b4PCwbx0WGc/k8iBLD+orPUEzUXJP5Bhl2OGA6P3/iaWid8qcC?=
 =?iso-8859-1?Q?11v8ln0rk9RV91kLU3iIpmHhmUBydHbBsTV5Pwr1v2VOOeqSmXVuNjaHbT?=
 =?iso-8859-1?Q?isMRCpdHRapoN7/vASPbcThR6ne4Nb05vQOZjikFDbyZGiI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e96a22fc-7ba7-4d95-06ea-08d9768a6f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 07:45:19.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZTsjKJYbFdLjk3vK1X9Wr9dUNuYCFb0ceVHKt5oMyBGnqYIyXh9shze9nGlWDFzrKJjIq54GK9sHUvpAVkgc3rWAUM371v9wzNzq97RHYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0357

Hello Daniel,=0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 provision_service_wifi(config, se=
rvice, network,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 ssid, ssid_len);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 provision_service_wifi(config, se=
rvice, network);=0A=
=0A=
> Could you split this into cleanup patch with a commit message?=0A=
In fact, all my modifications are fixes of maybe-uninitialized warnings. =
=0A=
In this case, ssid is not initialized.=0A=
I thought title was explicit enough, what can I had in my comment?=0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char *dom =3D NULL;=0A=
> Same here (maybe including the compiler warning).=0A=
Do you really want to split patches even if they correspond to=0A=
the same activity (maybe-uninitialized warnings)?=0A=
=0A=
> For the tools/* fixes this is okay. Not really important stuff :)=0A=
Indeed, just compilation stuff, I don't think it could have any=0A=
impact at usage, but it fixes the -Wall -Werror compilation.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
