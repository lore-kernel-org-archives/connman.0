Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120048.outbound.protection.outlook.com [40.107.12.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA5A33
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 08:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYERdvJQZiVAivR0AArzzo3vDcNnvxFfo0ww/C1sYsgyv6WM8P5OCj++Ucmce5qOhQNQte9fVxvafKRBtOC5Lpm9VOpZ9L1k1GbNKhSpe8IkhvCjha+DAym5hm1iD44e2cwXPHIbak6KBKRP+6M00vFh7fb6TOmcuPv4WD9k9XoOSfBkNnQCKtIuyfdq50qVkKVTCD+QLycru8bHiChBOl+jjfuBx4hGb5J/uHhdOsA1Lcf6OC3fdFsYCh0PVMuaSHT56Ncz3h94GaJNYc3mXF0xYY1w31ZW8kqlm4JnHTFVQQzDyaDNTnrFOOV8inOZeARqjZmQ60m4DUlSJKCmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhoqvLmPwTs+madDMhfpxjYvVPNt0JGVr9Kx/4EeQb0=;
 b=EoSw1iDqaTtiYXjSpXX83h84gLQekYSyiOrYWY6IiFCA9w9njXMAgP41N66LPnCB/RD/80/2lg9V4KC7G9V1u4nUHSO+heBtNAMiBKxxMnsj6uj1dZHpi/y1tmPflmtPeWGhAG4pL80aswWA3hWDxZiVuA/AW1XlfaHR8z7HoeB96iMew1FBaEnkM1NolikBGoV2Ne0Ea7Xy2ZZb+8VrlFKyVGuDUu7xeVTnY6MCuyrkSkIE8oHEjfVtL5xxqfLSxIAqGqRGfys/7mQURcuTk9LqohJQnCsaFhNmWi5fxh3esDq/DIV8m6VhH0z9SNr8gxqoyyF/KsmMZRB7hx2F4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhoqvLmPwTs+madDMhfpxjYvVPNt0JGVr9Kx/4EeQb0=;
 b=r7niqfotHgy+U8BLsHmMppxYI9mHHrvjAtpCKuAOZ2SDGsnIJJ45bVRQOq3nRhTUD0p4M1DkltLVCBUc+QiGVwGGyjK2RcluR35kqvJ1nrRXl2XwDGg8Spv+YYT9JKrfCB6mwr/rXpI9hfLk8uclU/uRGHmx3mxGfzpVppP4moM=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR0P264MB2888.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Fri, 4 Mar 2022 08:51:50 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e%4]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 08:51:50 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: Denis Kenzior <denkenz@gmail.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: [PATCH v2] iwd: Always disconnect connection completely
Thread-Topic: [PATCH v2] iwd: Always disconnect connection completely
Thread-Index:
 AQHYEP/731R9+FXajUGI5zk313sJNKxx3h9IgAGhxwCAAAOvMoAADyEAgABbfgCAFH1RHIAVdbNZgACBbQCAAADlkIAJhMoAgABT1IWABt8hAIAACRlO
Date: Fri, 4 Mar 2022 08:51:50 +0000
Message-ID:
 <MRZP264MB15445C9003255F75D9CCFBC093059@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
 <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544C7DAF7A0AA3942D9FC1C933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220221164442.gsg6krtdalemte62@carbon.lan>
 <MRZP264MB1544515AF83263F7E4DDC918933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220227180930.ruqnmsgtei26zq4n@beryllium.lan>
 <MRZP264MB154417BCA30F1C47EDE6DAC793009@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220304080542.j4j6jvttcovyqu6s@beryllium.lan>
In-Reply-To: <20220304080542.j4j6jvttcovyqu6s@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 51d6b48a-88e0-7489-ef27-18778f72c33a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93d55a09-10fc-4b3e-f036-08d9fdbc3911
x-ms-traffictypediagnostic: PR0P264MB2888:EE_
x-microsoft-antispam-prvs:
 <PR0P264MB288816D2BCD5DC070F78869D93059@PR0P264MB2888.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hvSSRkPA41CVoJe15w+z/3zlCdCufARy5GadzcA99/tLD1Act9zZhTeMshGGdun69ZrfEK5szsrVsU8upiWwRAOy85Ik15Z/uvr8lp4UuBKudFn4ttVrzXhRZRiXfmZgyk0p0ZxFPrlOxqHVXyvvSOC8TIGInACMLpOSmfUklSmj5mMOHq6YfGxonlfnQb5OkG7j1YwwXW2Y0vZF5+ajY/hQvz6TbY9p6e1tDrsh0E1eQWJrpW34dL5FRITO1jylQ2xe3tcohq4WRlldduzo4V5HUeWLlu5E5sOS/HWXWN9kq7bPyfqKFXcrwoZOOd4Ef5OtnCKiO8Ih63v2Nb96wYpITAKcjU38DnKvxmEVmcyBlqK0Fm0vtyieOtHFVL9VYx8vDwclp5QhG+dtlGCWYYW3sTNK10X+a7wdyQWLIr05bYgiOKNzT0BfFxIzqQEnzSM77FNvmTRfuNrjbFshOQ8cDmmuubw+G4zkx/zD7fMhpd8X4yMv8VUM6JQP0pkavqX6lonfHgQhlYsM82AQ7Trd0rhGk1XVRHvpx0BJYgXcPiJnpk2KZehHJWwa6JV64OWAgACNZeijkEAPNJEbWexOa7ITIvc4dCZAxfQDtPd7afBW3tAVDatFi7jUaemWt3ugwqDgkpyJpw8yVhG9OFHy6fUPbGm/OiQDwtS05A8J4XP2r5pERBmGpDszAul1nw4Nwcse4CgNH2tTfk5Y5A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(2906002)(6506007)(4744005)(55016003)(33656002)(83380400001)(9686003)(38070700005)(4326008)(508600001)(54906003)(86362001)(6916009)(316002)(66946007)(91956017)(66556008)(64756008)(66446008)(66476007)(76116006)(71200400001)(8676002)(52536014)(8936002)(5660300002)(186003)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7r9KbFXUa5hXRjKXWWo2umol5VeVp4v1VMxyDskN9UGh+TSGLH2NVFr8+Z?=
 =?iso-8859-1?Q?1gW3g10nxDHnw5azMAbwPIFB4jORY3uWU2WZ8VKzYF9+0QGko40jf5DCqK?=
 =?iso-8859-1?Q?dSJcQq7Ge8xaaXqW6nRBJZhlQHpMWCey/ntiCT4ex3Sua+vdQbkiaVlv1B?=
 =?iso-8859-1?Q?t2ih4I8mkIaolNo71Flii+6k21x5WI/719nUft0bGMpPBXoDC5AKi2lIvt?=
 =?iso-8859-1?Q?uILAoB6YTm4f91zp4a3LbuoR+8gZtc9uYag5Cds97fbEzuQ34U1DeHXCxw?=
 =?iso-8859-1?Q?y94pTW9bh2hBzSA1kvBLpFjxfas2hJKQ3TnaT3tbHgb8mR/JUReki6vE1L?=
 =?iso-8859-1?Q?gMwcPLPypJUmJWSxk7HD1Qw9uY1J2+GKBxROGatPul97+azr2WGWXfuJpw?=
 =?iso-8859-1?Q?EscmxJU10+i/qcLqJgZfRq8DA1NqXPMaj9Hkh+C+IqPqA+aWjcWegxb9cG?=
 =?iso-8859-1?Q?6Izmawb6/gH2THgDI8ZtnyTfLWW3bQs/2cwfRtd3ebshV9I6D8n0XK3Jn6?=
 =?iso-8859-1?Q?NSHLISAnJDKRFs06LRFIfQOOvhvnxAfGBsus+3KehVp31mSA7DP9Sulhko?=
 =?iso-8859-1?Q?w+Dr18T19Q0OlKo3tcH0M9UrKzbE7LYftAUG+a+ccJ1yK8+7zR1uXRpsdg?=
 =?iso-8859-1?Q?oNPU7uh/NyMpfhfu52lUoTySdKPtpZjR9CbvSQfB8awcPFHHZLLZ+tjZ2b?=
 =?iso-8859-1?Q?rhnz9Cl2Y2ZX8oxXwGdm5tecNlqG/ce6GQbhRXejTCPX+W2ek1bT3YAmRn?=
 =?iso-8859-1?Q?qzv6ytIi0AXOpf4u2tBczawlqCmUKGdXlX5QEtl/fXMK+mhrnNZP1mWvGU?=
 =?iso-8859-1?Q?66ReJyOuHLVBlfwXPIcQbX6KfMekSMewIhpIdE0uWr1xyTI0t36kljuPrS?=
 =?iso-8859-1?Q?0o5PhjL6P3AFggdC/JbVoTo345uFQXRDvMMp7MoEReaQofzih4PrRR5O8D?=
 =?iso-8859-1?Q?8z5kOgbwMbvAa5rKiIjPtm41PPE6FOStV1s33KYmekwZRmg8uisqjQ3ZnH?=
 =?iso-8859-1?Q?yEoYKPWpzGwPhj1A9OY2RPtrUSt6m+qH3a+kOYYT9xeBtN/ag1ds/ncGJ5?=
 =?iso-8859-1?Q?RvNgh9OQXRJZdARNsrlxWNT0sSQpPLC+NTD4rKR0shECTmsKi6wemcTkl7?=
 =?iso-8859-1?Q?nh/bSrWDWSIKgQCuH5TaeyGQbMIEjSyNjbMyuJYIDhWV6B+RwkQhsALqOB?=
 =?iso-8859-1?Q?cv8IrleRG5+zPWnqjYq+FZ836IzjD8xvOtEcQ37onpk0ZzejdJTZ3XFVec?=
 =?iso-8859-1?Q?JcfQi0rfshoBKF5wuSks9Dh9t79tIDSPJwZ5y6d5gxZ1nb0Gs8IP+L6xhb?=
 =?iso-8859-1?Q?uZ9DwJWpyLN6OTey7DzzFSCFWau99NXynsD3kDP0l2vCZxEudJXGCgCKjx?=
 =?iso-8859-1?Q?ZbT19sIZLdAPU4zQ0V6iiDx+/dKiI+1qei2lVseQ3kOLKBqeiqczELfQnj?=
 =?iso-8859-1?Q?Tl7coD3y7Dpm8EeXL2H7PmWzen0QMMSDHk1lTKpncIPJvWtXGheQW7sOJl?=
 =?iso-8859-1?Q?xEov78kn7QdFqlkt2HT90mujUH9HRGhuKcWGPlxeudF7QvGl8iXIBqfmjz?=
 =?iso-8859-1?Q?oZVYWtEEI6Bwuy78aa6BNK9L+SFnotqVwQthmq/XeJOJDyJhIH198f9GFg?=
 =?iso-8859-1?Q?x7ng7XA6vvWH7u6Gl6IpWBKGpUVQwGPEuMw1QIeof337UAy/uc2fH9eVvq?=
 =?iso-8859-1?Q?lo4usO4xxTFYeo16MQcQjtOcqZd6DKV2vyPRv+lR0dThkAsou1oBHkEEt9?=
 =?iso-8859-1?Q?+bE/EFY+B3xKRnvhm/6k60zmEwpCklIXdDBt4AcbwA5sEUnsmNQeBR5dAj?=
 =?iso-8859-1?Q?4agg/y3h4w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d55a09-10fc-4b3e-f036-08d9fdbc3911
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:51:50.2323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGqgzE4TqORjFXOneRyFv9BVyw8KX3j+2ihnbYi93Qt9K/Kr3DEFsCoYiJu9BGfXmFrtP8jI3gc6wCfL0ZNATr28Za/tPPnBBlWdQwfnoeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2888

> Thanks for this example. It really helps understanding what you want to=
=0A=
> fix. Is the PATH2 Connect necessary for triggering the error?=0A=
Hello Daniel, exactly, PATH2 Connect seems to be necessary to reproduce=0A=
the issue.=0A=
=0A=
> IIRC, Disconnect was designed to return immediately. This might be the=0A=
> source of the problem here.=0A=
I think so. And probably the same issue when removing a network, which is=
=0A=
also designed to return immediately. By my side, I have updated this patch=
=0A=
accordingly, to be applied after [PATCH] iwd: Forget network on service rem=
oval.=0A=
=0A=
I still need to create a patch on iwd repository itself (related to the hid=
den networks),=0A=
but after that, I hope passing my full test campaign completely successfull=
y, as before=0A=
with wpa-supplicant.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
