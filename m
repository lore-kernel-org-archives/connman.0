Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90042.outbound.protection.outlook.com [40.107.9.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726B72
	for <connman@lists.linux.dev>; Tue, 20 Jul 2021 12:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRtl27Fx9Dule6lFfRKzngjO2FuWtZ19dG/xD8Wri5egECelDWwcyCrOkxegN3QpLVklfqAu2Tuew7v3Jguaj6TA1hHi4F0aFskLl6I0H5dqFVrEdDDwbcPC4a7W2VAw+hN23J4Lj4Vsa/6kHBa4t8SY6fceWUImS4uWgA87BeQJktDNqLLlFRBHoehcRQa/Ihv/jbIHRbSdHP0cwC8PurnST/iQDu0s0hR+2egI3evFkM9ej3ZdCczp0HQkEQb8IYVz5X+K02Bxn51jUGCLggRFAqZogz9cg3JgytAT/qwtLN7k9kugXV+xttLAzHXNL47mHTc/cc7aVNYJpvGi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7cpflKdJ6IeIGoA2QGGwguXldWqwzXKwNZQprWi6Ss=;
 b=WTk8F9PWIlNMmPbw3n9JADzFUDCMx3jgUUKAGUY6PYzvh5qd/YT6rnrII6XLNwPr9YKZCt1dqEqxmdiKRJBJ3BoxjAQtScWzuyOdQi9aYqM8n4WSQe2FIQWEsQgdYJLeF7r5vGuMkEfYp0vnHCn/gA+QpyabSGIsYuhHEyG2+SbFYbCpkLECaM17iccbFKGVlNg/V/k2IF3SU+6EXUxmgwjBxXuWkU8+YEH+vlkhO9wy98Wo5UFqHd0lpbRlaUY5x8mhpe4+7bzyz0Fs3ybQYGuIwA9IJxi5vV/HyYFtzc3wElCxGcsUNy7Xr1oSHtwg7iwTviwi+6Hr4fNnPuem0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7cpflKdJ6IeIGoA2QGGwguXldWqwzXKwNZQprWi6Ss=;
 b=gXueSZZa0tvxMZmesj8XvGpQXhRKGmJrq27MhT/74hOoZ27ZTccc3IFvflOy1C24bWh5sThzDtjlUVsfNLxf7EqSovTCaK8y33ga2/Y+H0J0a6UL4+WD6kR0CLoJS6wIKc0CLx7RdqGUCFFDv0qohClnuLprdM3M8osF9QWzMo8=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRXP264MB0902.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:26::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.29; Tue, 20 Jul 2021 12:31:26 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9cf6:f40b:bff0:c682%6]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 12:31:25 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: service_update_preferred_order cleanup
Thread-Topic: [PATCH] service: service_update_preferred_order cleanup
Thread-Index: AQHXfHxclevzH83B+0aj5OadKVoo/KtLyJoAgAACqeE=
Date: Tue, 20 Jul 2021 12:31:25 +0000
Message-ID:
 <MRZP264MB15449923E85D932705598E8F93E29@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544B944E70E53B4B1A9287693E19@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>,<20210720121428.p3t54ne3emuxz3bl@beryllium.lan>
In-Reply-To: <20210720121428.p3t54ne3emuxz3bl@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b350b8c-d167-4ef3-61a5-08d94b7a4a9d
x-ms-traffictypediagnostic: MRXP264MB0902:
x-microsoft-antispam-prvs:
 <MRXP264MB090203C8A0A0D70198DD98D393E29@MRXP264MB0902.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8k1B6vRwJkuW13FXdTwJTX5vIP8oUMtENRmbYjy4RD9n7YeV3QsebpDFMHXcfYeoIJtTX9zK1QSvVm0KbDowD9NGkFh/Ihha/hxK1T0FfXhc+5hLYaqpyYNPBSjUUYQxuUdWQ9BUknzs5rRdJztT5T6VNIe6Ak4Dcx4+mokW1xOjE31lzg0viqpZmwzAKhX46Cuj65JCtYwl2JI5UHmakEwj2B85lMEnELExml9HNGIfBQ2TtMcLKa0YNAQBMtVMpjqFgnnCLswxI6XBBvKrLV6rh98XwYgWh3lqdfLeutKZgf+1W2tLtyi27aOyJNZlXu66Yu/kJ73BKzvg5aPYq7tnLwvIHWvx73GoNOGO9p+U6MprxotCbhtAGi5YSHzP4LGoh+SWACohieAEEd0HjlP/Wn8j17yI9NNmKKWQ8q/Ai8q7E82HZzqsInOHtNtZSohnU7tfZsCvBvtxAYGgjq3B3N1lbRJuS+g5BZzlb4WMGi4NNjzgkPDMCfzctWjqKNPTWeappA0ovrSFcWKfycpZs1G7E4O3BY4SY3NIFWYCskcV5ipCj8Op9+eF3IQd3MIFgPJHXMcWLdgeasLtD28Ajpmepk4n0VodbN3xXY4U23Vn+PTCRJtfpqTgOWuFTC7233aZw/vTQeOjmGkLc0AckTG4Oc9K3W6Ju+Q2+iM0fPnPqenqmNzgB/cCPd+dLsjtXhdQH6kFLSoKU+b+eQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(8676002)(66446008)(478600001)(5660300002)(52536014)(76116006)(64756008)(66476007)(66946007)(66556008)(6506007)(55016002)(122000001)(71200400001)(38100700002)(91956017)(7696005)(316002)(4326008)(26005)(9686003)(33656002)(2906002)(8936002)(86362001)(4744005)(186003)(6916009)(83380400001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DHSZFrNQXNqCB2pfT49Z1JO9iCFLvdRAQWUEoZyXWEDSL4EqQhngDmLVpl?=
 =?iso-8859-1?Q?I8kic5BrgSdBEjhumPpFimYvcEIvH5cSm6NuL0IrPHfSselqgtcOFuJzyO?=
 =?iso-8859-1?Q?BfHulWUx+CHE183j/4nZlMt1k6+lpTGrHKKLg6A3iILjPAjaLk97pPy0a1?=
 =?iso-8859-1?Q?jP7Q7e4A6k+hl+PKK6MbBrr327A4t/ZpdeNnK1H8WJ4oGlndWeYK8wYtMv?=
 =?iso-8859-1?Q?wuWj6vbKAhD16Ci1Pkcri2fnO83kq+fXKfDyzaF98yMo8NFr6QN/RKYq2b?=
 =?iso-8859-1?Q?zsLDAtk0CDe6X5zI0/yRh2GKoCvxBd5XtZw9O1kS3lEtQORWFwfloA+x2l?=
 =?iso-8859-1?Q?8rk8QFiUyC5lgszL1/JnQSF/150RADrDSGGd7jLQZpnelrXK/6MuTwj/p3?=
 =?iso-8859-1?Q?L+n3DI7uP4dquPFASY3s7LJjTSwiZ9/mwAY5xx4mPm0dWQvDQakaLsEO13?=
 =?iso-8859-1?Q?Dcd2A2w0AfZPrzJyhfcGRyb3pYyOVAYh+225yxHGoACpg0pLyqlm7eByYV?=
 =?iso-8859-1?Q?LRrKsNxXyzlUvhepBdxkQG0qnp2eEu/JRsu2/uiDet7WKh4s7vr1QKtSKq?=
 =?iso-8859-1?Q?2rKXTqJJIYGkKuAymhiorweu8A6CTT93yhn6eZN9ZJeQ8t8uh+dhWRdMxM?=
 =?iso-8859-1?Q?UGew8It9AggWvMKhwFqEBe4YSft/QiTwjHSzqmO1R7LVEkFVV9OW1kzB9E?=
 =?iso-8859-1?Q?E8I3OWVyKGl5jMzYfGBw3Ph5oBh+MfMlinjnu1He62OfYGW/m0u8LdVYr/?=
 =?iso-8859-1?Q?NcsHiOlA4Jn3x3jyAxskj/a+MSx6QQK60N422O4OyMwWDmllyUTJdVsjME?=
 =?iso-8859-1?Q?Xxi/nsagdrgPeIeIYvOz/x+zcKSv5ggFe4Y15/uIa6+MpS7D5G2l8xajqT?=
 =?iso-8859-1?Q?5u65vqmnpqjjyxUU1xr1qrbliorZOjRnoDsZZsBTF8df3TpiADCIn+FPPw?=
 =?iso-8859-1?Q?nfqm6fVhU3dll533sqcLu/i90VsVm1nSH36rIy/DGnrhP2vIBZTbDp1U5e?=
 =?iso-8859-1?Q?R/zIjrtKgpca0Zte0IneKLA1w0QUBn+a3fLW+ueK6igbUVCPUUC2qBuRv2?=
 =?iso-8859-1?Q?BrxhOdYUh+uBsuih5e09esp0ch5wXM1wPYT0PzqFWJoyHEOJoTLssp1dQb?=
 =?iso-8859-1?Q?DJgHtiUw9J+NrDoCRYcfPx1tpEDxfDgFlnpsKgFdQDeYnZ5KwklIKax3XG?=
 =?iso-8859-1?Q?r7Gp73V0mYqTwzA8abFdQ2dC672O5stHfte1KKFU4ixNtAkjr4sKkXQLQV?=
 =?iso-8859-1?Q?ITBaXhNxU+5yF+l6xScv+e3y5UZZ4EiSAvHkEHr85dXYxRDg24DHSeeyhJ?=
 =?iso-8859-1?Q?+MgBrG932FXmtsJFXko8dEzmcVuLxBm0oqpwnC1X0VXEB1g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b350b8c-d167-4ef3-61a5-08d94b7a4a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 12:31:25.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xC3QmUyLpmed+MeD1w88pX+0G7Xki3jG4i+zPI04hik/4gcLDk4y8Q1FZkhoQZPtAVB5stggXEsfu5RBIvqqhwT2hRT+UIbtf+BnQa5jP+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0902

Hi Daniel,=0A=
=0A=
Great to see you back, and hoping you will  be able to check my other=0A=
pending patches, as I will generate a new release soon.=0A=
=0A=
> This is not just a pure refactoring change. Because=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (default=
_service->type =3D=3D tech_array[i])=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 return -EALREADY;=0A=
=0A=
> is missing. This is only relevant for service_indicate_state() when we=0A=
> would ignore the new service. Hmm, not totally sure what it means. Did=0A=
> you figure out why this is not needed anymore?=0A=
In fact, it is not missing, I presume it is the case corresponding to:=0A=
service_compare_preferred(default_service, new_service) =3D=3D -1, =0A=
which means the return -EALREADY; after the condition block of=0A=
if (service_compare_preferred(default_service, new_service) > 0).=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
