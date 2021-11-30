Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2C2C80
	for <connman@lists.linux.dev>; Tue, 30 Nov 2021 09:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8LYcmFuz6elzJvW4eLwO0P9uQiBZ8+rlHBNutmkK00UsxQMisV8bqW+mpMx60fI9QyXZ+irfqxWSBmJQNYyUljngJ/Hw5X8+9J7yvkT6GNfAMqi2ZUC9hFH+KdnwF/sF+K7QTanGcJOpERwz4Tgj7nPDcylPjH+kFfiuCrv68njTEM3uIgPa6LWW1XaKoWPyrkqjTA6nPYKnJHjX2K4M1xGeUZ8YFNvtXJ0D+yAQnWu6EhmUpFDh2njfSjzp8Mx9LlyCKbu+AyT4OQl56ctSgHpZSgppl7AxLGbN1X1VYf93cwYyd0Ej/pRyDjAsjzmAKU3To5MMqLp3iM7My2xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzTFSzVcl70zGUD6OSEHczXNtsiheBDAAv54yCrWOEI=;
 b=jnBDJYFJDCvh5FVu7dMDACQO4i/TTPKHRjd+jfczc9MK0NLOIARBsUQJCdiKrNj3TAo5KhNTI/5AOiAI12DxOoFABVAFZhRx6sCqkKYKeWnQdR23o95LU51DP0oh2p9l/uIW1zDqPKZGwJ52cUlBD2+t3asOZU6y78bV/n6tCWxf2nzqWZEeh/+/HlL+KJNrMJOYBF3CO6YAaopYm4i0wyHXvlUXSZlSB+2dfATt8oH4Jrv5/b+Qq+pDLjZMXHfRi65dA7g2V1/FvNql8CmScIACv6eoVf5uO0BPqyToZ8z0KXpaNR1KZkPfIwBbVF6HJEZYSJCkrTuP0cZ2VyJTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzTFSzVcl70zGUD6OSEHczXNtsiheBDAAv54yCrWOEI=;
 b=FgbiIUgGM7xekxMY4nbEheU3Lt11r+2VlsDuV2mhQNJQ5L4jFRIjw8qM4lWPr3gGcuWvD8eSyqSLrSKsIQvlz+0X5C7apVHo5qMgcUYnHK4FvMZgnzMySr49sEl3nWa4LE3WUnhzWGy6Ipzz1Gn3jKqqvWB5aYobvcLuuOKLmMs=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2338.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:33::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.19; Tue, 30 Nov 2021 09:59:41 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f8f2:5a2d:be60:ce07]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f8f2:5a2d:be60:ce07%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:59:41 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: comman <connman@lists.linux.dev>
Subject: RE: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
Thread-Topic: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
Thread-Index:
 AQHX4lC3A7XrSe5BI02rfKjJZn9+U6wWAUQAgABZJ4CAA7wxAIAAG4X4gADTMoCAAMZj5w==
Date: Tue, 30 Nov 2021 09:59:41 +0000
Message-ID:
 <MRZP264MB15442653D8E656E75EC9D94393679@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
 <20211126163040.ai2euhv6yf4esnhn@carbon>
 <CAA=hcWQMThadP0TQDhqEoREroP8TNx1yQkFHC3a0=TNv9FR3DQ@mail.gmail.com>
 <CAA=hcWQB7t8GK8h0kQ1gW8iF-eO_Df2G6C354d2jh4jAxJcfSQ@mail.gmail.com>
 <MRZP264MB154446BAABD22138868B793A93669@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAA=hcWS5eXKLMUrTC=MTKUOERiR7eT_J+WdeJL=k8y=i-T40CA@mail.gmail.com>
In-Reply-To:
 <CAA=hcWS5eXKLMUrTC=MTKUOERiR7eT_J+WdeJL=k8y=i-T40CA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: f4a379ff-b461-c60c-1484-d5f3e12ed4e5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 209656e2-5e5b-4289-4f4a-08d9b3e82120
x-ms-traffictypediagnostic: MR1P264MB2338:
x-microsoft-antispam-prvs:
 <MR1P264MB23389A8AF8A6ECDFAD37323F93679@MR1P264MB2338.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ckS6CWdgb9rQFoDoIt6rOwvPB4NGRw1bAd6kBi60PC8Db6ExQvKAm1uqC8u0iIdV9U6Gq+vxn2drXBuq3beKXwwRCK64YvZbTXKw0J69Ins21u+rrTkOqzoh4brPKQCLKAXIsb2j5crIXGEF2kQ/EY0ZT6aR2Hic2BIMTYC3Fl85cWJpaJuV/Q9HXqBjaBCcIki0C9bxxBpvtCws85pUxBydOmd4eKF353lHGnqsKLQV5Eo5O2XtH9DkVjqUSjDzoMAPcGM/0Lf9Tpv2IM+dyS+ea8kNah0ESB69HvMhcCgCryskzwNxXQ7NmsAYpJSokwaifWzq44d81HIXgGmbNLOrsFwqcQpHqY2Lpd4YRjqAPgROf05OHbfd3v40N7/KtfH4wm5Al6fgSjuVunh1u2q8XzUJ8RjmQAJ0oqy4DWqjG2PiqgWvUIx93SBROJ+yVi3WzH2ozPuu78yQal1HYFpYXI8E5RZ0Ijr0ujBBGw/kd0GIevjd61fUbdy1KxV/QgboOhWaq+GysVoKmK4eLsgsfYdccsTEVrYe+NKLTKbUWbLXbPYyj7VK2EAHd0KlguZbb5wRmr+Zc22BJmyvAsEqfNHmGwN8BfCCRMHVMIdH1nzYif1q6pVqBX0xRfZCQLUYCgwlHgNpy0H/K2uOPOTmQjWSdzwzGx6gPc8qGlFrmVmgqLLxWAI3kTdsXPjAGs6OyR7uq2j2xNfgLjA5sQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8936002)(2906002)(316002)(186003)(7696005)(26005)(86362001)(91956017)(66946007)(508600001)(66476007)(66556008)(38100700002)(76116006)(64756008)(6506007)(9686003)(66446008)(38070700005)(71200400001)(122000001)(52536014)(55016003)(5660300002)(8676002)(33656002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nulrRWYUv3gHYgHk4q44HxW6JUmaot4DltNYH0oOIhb0+Wd8t7OfYpS7+R?=
 =?iso-8859-1?Q?B+dTi8oZEPwtzH/Up4lOxs0vrj0SH2SI/igoIj/HI5MMAnxonJJBxLEHQS?=
 =?iso-8859-1?Q?lWzd9JmLo2ehzKfN0wlq34Tr7okV5LvpMBMbYeKG1sC5/V3NoY8GeRU+Po?=
 =?iso-8859-1?Q?Zbr54WwYn5G8+24vg1P9w/oMDTqJ5kcw38VFbUNNohpopre0sM5ih+A87D?=
 =?iso-8859-1?Q?gjWfcv2iTZvWc+RcRPTLvMssboZDz4SX0vD9JJVKSpZV2nyfZ9scekSdIB?=
 =?iso-8859-1?Q?Y0/JB0JntUABhXpifuGoYQBezB+JDg9aOmdzTSWM17MtFp7JxnLo3wtgW6?=
 =?iso-8859-1?Q?ze7UgIHQXJwhiyoLqagyAug2wla6+dAvF+G0+vr/i4SQL+0vi2zZgjCOxS?=
 =?iso-8859-1?Q?9K9Y5VNFezs/rG/Nw41Yh7Gvf/IeWZ1D+iznKWODZ2zxXwDL+G8BTZFMar?=
 =?iso-8859-1?Q?nHqfsaw8+nm4hDNBI0TjSHrCQQf/DfDknz8n2oMsUS18fTgPzZeI31YbdE?=
 =?iso-8859-1?Q?dxs+XQS4qvnoXKJI9eYnbC4/TAFqlID2JBM5rBe/ljsdy2ZkV8Wlk39N/H?=
 =?iso-8859-1?Q?WkbP5AyzRLAKdgNZAaB2uJquPzY7D8ctVARSo9hrb1Q++uTTgEeLTUJb22?=
 =?iso-8859-1?Q?EqJBOqUsb9cNkAClMzniRJHRbhyiPAMh+V/gMpvNQ4WV2hREwGMdwqz2P1?=
 =?iso-8859-1?Q?v5HhBq/WBLXV2nGZcwz1bLlfGORc2xuHn1ULUeSKBfUxAJiOWVC0sJfpF3?=
 =?iso-8859-1?Q?293KsfZjfJmyvwoEtoMOmMjzEEPcSQfgrZKDHknT6+onVlvC6gLnMx5nfF?=
 =?iso-8859-1?Q?0Ydwn7WzqPQX4Gf6kovujZqDoDenA27l3IWQmEWaQZf46vRdqAydO8qq6K?=
 =?iso-8859-1?Q?TPBLFCEiZ2QkQrGwFRbCcRdz2uhw9/AhcKpn4LB4UekpRe3s/CKEpcCYYZ?=
 =?iso-8859-1?Q?pp5blEQMh1D+BVqLSRSeGmnkFN8M5owNX60AsPPLlY2BAxDybfZmgWw8/X?=
 =?iso-8859-1?Q?7t8krcLrR/CngZExUaSrOdyuZaoPT8K4G25ZlA5z0SQy9sbDHaeXugvGeP?=
 =?iso-8859-1?Q?p42Hft6LFgppNwecybOBTDYyoiETcidzkzAX0peVyjR2mrtoynMEot0v9E?=
 =?iso-8859-1?Q?e/yGluxh5wFPPKI2+ZPy01QGFyhVb1rnPXBcv1PyHz6DMXCSqNR/B4Xiph?=
 =?iso-8859-1?Q?+V24GWDNezD+BBZxl+lLhANrF/uZgXGM7lCaIn1E3Uv1E0hpsL5K52SBEY?=
 =?iso-8859-1?Q?4/tsscEkPAyFUUIPaEVJW41ORyymZb2jNjiShqH3nO3a8+VMMPX0Vh4WAM?=
 =?iso-8859-1?Q?ghzKKps8UYpi54dp/mR9STkM7BjCDpUFPfbQxH1nXMh7gqq1Yh1auH6qr3?=
 =?iso-8859-1?Q?gj3izjvN+E9DY62ALIVt6QcznAcADxWEO8sxUu81tXGUp4I8CQNQUFYel2?=
 =?iso-8859-1?Q?+5EnJRC6d/LfUfRRbrgkwAGQFSpSDk3/cu8PffncJMeQYNtai5F7wLhLq/?=
 =?iso-8859-1?Q?HJenHbCbfeh7rp9QaDGyZvFd1smOgwNz82Uqt3jnHwsToIF89IlmAoPgS+?=
 =?iso-8859-1?Q?5Vw+5r9VKPM5yrOx679IwSp3cL+HYB6DEVXouCobr0tMiq0Enh8e36tbN7?=
 =?iso-8859-1?Q?DLf3XnrQ0bnfEk25YAvJJywB3ynipeIwP04VkPVRP6nR3jtVT6Edud7iU0?=
 =?iso-8859-1?Q?OcYHKHNj9P2nJyiFgZEEBRoMpy7NPS2SMn+1vo/IABe+5coa2V5UAe9j+t?=
 =?iso-8859-1?Q?pE2A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 209656e2-5e5b-4289-4f4a-08d9b3e82120
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 09:59:41.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YTldeTxMGjxjP0IQmBcMntrz7UL38O85WUebc3Ii6UngiP+lwOxByRQ26kBlTWmhzPgXK6YjQ9A/NjNY97uEGh8pqrlLZx1k3u19JS2voc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2338

Jupiter,=0A=
=0A=
> When I built connman 1.37 with wpa_supplicant on Zeus, it managed both=0A=
> WiFi and 4G LTE network interfaces well. I did not configure anything=0A=
> for DHCP, I did not even find DHCP package and running dhcpd service,=0A=
> I thought that wpa_supplicant managed DHCP server and connman managed=0A=
> DHCP client, is it correct? I only had DHCP issues when I upgraded to=0A=
> Honister connman 1.40.=0A=
I have no idea about the integration of ConnMan 1.40 on Honister, I have up=
dated=0A=
it by myself on Hardknott with additional patches, integrated after the 1.4=
0.=0A=
=0A=
> Could you please elaborate how the DHCP works in connman with iwd and=0A=
> how to configure DHCP?=0A=
I think normally it shall work directly, no need to configure something spe=
cial to=0A=
activate it by default. My meaning was to (re)activate it dynamically to ch=
eck=0A=
if it worked in that case, for example by calling:=0A=
gdbus call --system -d net.connman -o ${SERVICE_PATH} -m net.connman.Servic=
e.SetProperty IPv4.Configuration "<{'Method': <'dhcp'>}>"=0A=
after a=0A=
gdbus call --system -d net.connman -o ${SERVICE_PATH} -m net.connman.Servic=
e.SetProperty IPv4.Configuration "<{'Method': <'manual'>}>"=0A=
> The dbus is indeed broken, any clues how to debug it further?=0A=
> # dbus-send --system --print-reply --dest=3Dnet.connman / net.connman.=0A=
> Manager.GetServices=0A=
> method return time=3D1628090207.390874 sender=3D:1.3 -> destination=3D:1.=
39 serial=3D522=0A=
> array [=0A=
=A0>=A0 ]=0A=
Pretty strange... Can you confirm it worked with your former configuration =
on 1.37?=0A=
=0A=
To keep moving, I propose you to test the following configurations,=0A=
and check if you get back a coherent service list:=0A=
1. PreferredTechnologies=3Dwifi in main.conf, =0A=
2. ConnMan HEAD on Honister=0A=
SRCREV =3D "0ef47336dc92b101c6d87ed3a9fff4db36096007"=0A=
3. ConnMan 1.37 (from Zeus ?) on Honister=0A=
4. ConnMan 1.39 on Hardknott =0A=
=0A=
By our side we will migrate to Honister next weeks / months, but I hardly=
=0A=
doubt your problem is related to Yocto integration.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
