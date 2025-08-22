Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31C2E1F10
	for <connman@lists.linux.dev>; Fri, 22 Aug 2025 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843077; cv=fail; b=AwnSkXH7slJWtnaH6vXg6baWRqDjveLbaOl18j9lvfm3HlfR8OYyDljGKS2Yf2lbnk2GesELKlmiMQCvtDScWSmmmjWqSf7TKfYUG6yx6xEJHyAXIWz58tE4hHcNoRf1tnbzUI1L6matHveWUhjtDXVEMoFbiEMYJGuGjH3UlGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843077; c=relaxed/simple;
	bh=VTqhdS7//izAtLy+FAv6AInA52DpvHvG9OXiuPANT5A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LLMaSTlzsxco5zSdjtlePNWplnpQD2qUlXhhm7m8sTsSQyFcrz5ffVTdwuA960Vc7DMmtL9MmuR1IJdmUwNfzU/wPUXuW04V8BkNSPvU9xPmazVpxPgQJeMNftwUHpIxZTkX7EIaipaPRB7MlG6QPPnDHOCKNGKPB5xFSG6pzzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=xFQPel4c; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="xFQPel4c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHla36RquTfN+ho5cUA34WDhXE/LWlJmkk3E8VQaCWN+cNcD+Q4ak/oVJHpIFszVYiiJXhZ59R786X4PYqp5LphCka29tGZXx9QrbgyWX46AOX/Fbd+/3GnvkvZ3KZ3oWPw8M/eqN7mdaeg35ZWdEs+kqYHRCOwa/5hPivZ5VzyJ43KEenGfrCtRwt7uRrWDjcTMdLtNME3d2aY8P58Yr9Jb60nboWK3A4V0Ltfe7neZzkkV9zzhJUPhrslKKKNaEr0T+k5B1UGYuKrCT1sgHbCjhSZXWpi1w6WRvd96QvctDul2dMz4jlcTETG/GpSzetGzJBApHIYRMkob5Zb8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFM7rQQh08sXHCcfUuwx2rxb2TnyV7RIxhhMy5mw7Dw=;
 b=xG/HtJWaasrpZiNgwGcL6vR3x4M+6dXe1bTvzC4NYkurLe+O3R7WaJGxskpr8YoPcBnLRFrOQuaep0lZrvHmGjNYTYscZSOEiHPXRzAuDqFP1P6orugzRstIa1U8kZshgX7OCbGrFVF4inxYhz4OAQbiJKQN+cnW8qKbZK00s479vNukp1d56HEtygmXpblWahbkP3G6jJlf3xLflrlbEWQ2XIck4oH3UoRf0XFq2WmpgrFs1FfFQZNVeNOqlXCYrk30thMHrCFp6ZYAXMXqnEtKCL64zpZP5MSND5i8WB/amM6pHwgzGm9xfyKzJeUeQp6mdWukbMk0OCrQeEoDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFM7rQQh08sXHCcfUuwx2rxb2TnyV7RIxhhMy5mw7Dw=;
 b=xFQPel4cP8Q7fvD8FVjzjiZpriaDg2QdJ7mWe9vQApQ7ZfDJp4muyXhMCPNMIUEsGSu1AiL3b2KSzAVxQhkQKqyA2QgzlgNxrYqFKqFwu1kzdYDwUK4xanKeLf6KxlobMIhN2FrWFYLSEQt4O66axD8J6bP+5cl/MTLzmaQynb9dDDf0VJaluhpo1erKzodFA96IW2ta7mzYhxY6cU5jvBbHFYx77zFmWYJio+NaQdxgeTIsgmx3KCKWPTMKWsh8i4FnJ3gTKHnrjSldUgyOEoXSaUHPUWcv2n9A855EGMt4ywRAE4NlsI+CTzivz7TDdgdfPM4+y2BWbhrLv+Kiag==
Received: from AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1b::23)
 by AM9PR10MB4005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Fri, 22 Aug
 2025 06:11:11 +0000
Received: from AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cad1:dee5:5e34:33a5]) by AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cad1:dee5:5e34:33a5%5]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 06:11:11 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: AW: AW: AW: AW: v1.45, broken wifi connect
Thread-Topic: AW: AW: AW: v1.45, broken wifi connect
Thread-Index:
 AQHcCDoLcbNVKf7saEulAds0rK8QjbRraU8ggAAwvICAAAU2EIABGXwAgAAW/cCAAGRUAIABEAFg
Date: Fri, 22 Aug 2025 06:11:11 +0000
Message-ID:
 <AM5PR10MB168209153ED996ACF90BEA4BF43DA@AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com>
 <1082538859.4574595.1754637525886@mail.yahoo.com>
 <211116062.4586180.1754639815460@mail.yahoo.com>
 <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
 <511456109.2450472.1755696051598@mail.yahoo.com>
 <HE1PR10MB1690B9444B6197D17AB086A9F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
 <1972372971.2755960.1755757618469@mail.yahoo.com>
 <AM5PR10MB1682BF72395A55D04F486CA8F432A@AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM>
 <1430299077.3058830.1755784100023@mail.yahoo.com>
In-Reply-To: <1430299077.3058830.1755784100023@mail.yahoo.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR10MB1682:EE_|AM9PR10MB4005:EE_
x-ms-office365-filtering-correlation-id: f014a64c-188e-4394-9ad4-08dde142b12c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VyOhkHG9CHW3lSqb8x1TF8tsnzzglS+4A/TtGtJx0aFK+9d6VivdXJkIgO?=
 =?iso-8859-1?Q?XaTekag20u1entJp3kQKVO3preLyWYR+W+GskTJi55TalEHW2DK7hMPQy8?=
 =?iso-8859-1?Q?MKLULwgODOD3eIukhHydzHE2AqPx7/MfzrM2ZH6ECBauAkf+Mcfkj1d83b?=
 =?iso-8859-1?Q?0OigMxn3dYhmTWPwk6L0p4ujok8Ya4Tl9Us4p4NpZd2kw+zsiSA4q/Wu7Z?=
 =?iso-8859-1?Q?8ulJ8O4egzny3wQZ9IPbwUTz6DTqekFmdEHTDHls1/HIcJngrDGRT9JqpG?=
 =?iso-8859-1?Q?gRqPOsuq/ABLyUOuK/MwvxRIJoEq8+rF92NGfAMiUI1AYiMloS6K0QLYR+?=
 =?iso-8859-1?Q?46dJpiDnros1vlxXHD+nHgsBcqPMO3jFiCPhM8YeYujLeED+sfjXcEz7Mq?=
 =?iso-8859-1?Q?KgEciUdVyG6rGXHDZmmIQ7sgnZnQ7d2V6ml/fogKi6Dfuh07s3tgpVpS5g?=
 =?iso-8859-1?Q?PW1MAewz1H+w8dvhglCIfA9erNDUpy3mMVENLqvnwZ2K2YgX6Dj9Vp7LWf?=
 =?iso-8859-1?Q?BBfE0pRUoM+QJYTu2d7uUcbld0KPeP0IWj0Xrg0r/++AM7a3/3fusunm33?=
 =?iso-8859-1?Q?bFN9R5on+aqlHlI7IkSUJbODFoXLOSqBu78rpsJtmP9BV2e1TfYZ4yrkYM?=
 =?iso-8859-1?Q?LY2zuNer2M0J11syzPSAuMPWerTLsoOkHgpG2Mbm9FlsgcYgIPXyxKLZs4?=
 =?iso-8859-1?Q?D4LDG+JuEO9VKaPbi7XsMolUEH8qilrZgrBnk/GQVHH2en6hkzhc/isQFi?=
 =?iso-8859-1?Q?CIC6xXyl5u+Jtg9/nIPMuJUJKx17TFChoYeuS6umKo52YBOwq9vjU7bror?=
 =?iso-8859-1?Q?kVFBAoXc/tEYFSnjF9QF6z95r9dSlDdHSn/eFB7cbX7fcmF0JPcCxQRNPm?=
 =?iso-8859-1?Q?jXV5DCa3LJmELIq4Labx/kslHrcQEd0+/QXk7Mz4IAEbokz6eWLf+2Eg1k?=
 =?iso-8859-1?Q?Q8xwD1HWOvHfI0ZjevLHGHp7wgnllywPFSR8xwtW8WRLI9TIq3ronn+VG9?=
 =?iso-8859-1?Q?Uq88RsoU9XeSXBNc1riSZ2oS6BF5/Pp5lhlqqSVE5mLGafbv76/mILgBmA?=
 =?iso-8859-1?Q?bIITDL1O6qBylz4+EBVhLvrkFtdjWs/9Ttza0pZWTtdaN/IboLgzTh3yVT?=
 =?iso-8859-1?Q?4stfkJ9fKJnTeH3m8YhewkYgqo9tcr90JfhwziJgX1YnTbKA42lSH8xBtf?=
 =?iso-8859-1?Q?Zf10UN7n2bXUCuILYhgZfGnI5pBJCSQgKlqfvDxXrHwreCQZ107yhDAykW?=
 =?iso-8859-1?Q?3LY3NCnTX+UtBkcxx8n0PXGkq8DPNoDPs3cRYBltssxP5ezpVwaA4NJ3wb?=
 =?iso-8859-1?Q?emfU4YTka6rVhtnAO5R0B78ARaEj+JVKfpPsV0FcbwZW3VTf7hdwD5KDNy?=
 =?iso-8859-1?Q?HuBwQAranoecT+QUrnNK1yT0nlGjTyikvEdcGBOA50DdDLwJ72jo/9L0zv?=
 =?iso-8859-1?Q?suFE7UlAnyX7fgP4y6ffv9veGjCONvkwjIqjTIT4QhO9n9w2fs7dhq6QDP?=
 =?iso-8859-1?Q?g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wfiqRz2fx2i96vuWHPcMaM1+QZT52p249Crvn4E3WYTHLo4AZdDpyIOkH4?=
 =?iso-8859-1?Q?L8z/ZShYXHo6LNojvMbW6PrL9xU5pPxtDgGq647ArnmkM/mKLlmIxk0aZS?=
 =?iso-8859-1?Q?tzCCWTftAH+6lD3rNuAcI6ss2T+UipI3MQst4ty4C/W5TfOyo5BqCLXGP6?=
 =?iso-8859-1?Q?mk/stTM/E5ZD6YcEgO1h/hVllol9e8HokrwCN26yHbaiDL9s6DIwq0VoK+?=
 =?iso-8859-1?Q?JDQKmFgP3VoekI9Xyo7rPMtLowuid6d5gy7bdSNeLlt12+kL6++YNtbea4?=
 =?iso-8859-1?Q?N2R34ftp7s1zhZFM9L5kxY83VsPxCSG6GfZUXYWLiiScM3GkjxS8/uZ/gt?=
 =?iso-8859-1?Q?zMmY9XRotkAg++LRJZFJYNqyRxhhHOOKZzV1ytsgujYOCahcMMRIRk7Zpp?=
 =?iso-8859-1?Q?NiNfRFbE1Vh+evIRIPSATGV85620m6sCVrcQ5zDJBmIdkG5JqpX+tH7d/L?=
 =?iso-8859-1?Q?Dd/El9HQQDb2FqD40RtcT/JoL36UUkKx/1NHQFMAXTCo7m0gxKL8yyPLgV?=
 =?iso-8859-1?Q?zw2+KrF5FfFSR9bSTRYT2G3oT0usJEWNXMXMvFyAXEPZ1R4hnrWMYJf8ZT?=
 =?iso-8859-1?Q?j4Cela9W3ejDlELt7AzlTPgUGY5wpmrhjq+Okv5owwQlNzKFUJ3YN9diRu?=
 =?iso-8859-1?Q?HaqBieGSUWr8k1NqhiQmN1IQG42XVfb7NKcBuQ0eUzys86SzHiMw8UCQA5?=
 =?iso-8859-1?Q?WcLietLj/5OfEe9fu54yBj2IYz1mNWfvhrFQ0kNYQ2ygqjQL5LwMX7qJQO?=
 =?iso-8859-1?Q?16R4n52s/ZYpbKKTssgNXgfCdfatWGctIriCIF6l/VXa/rwCfYukbmKRQR?=
 =?iso-8859-1?Q?Tyf55DRei3qgofpm8Jf7hUYVTTqn3ifCs0FSnYnEQu78owt7SMaNq9r1kO?=
 =?iso-8859-1?Q?97qTsQcfe/6CItHKY+AzmMpt6xQMJggm/nGGtWMl3wX2+wzBkYUIicmNog?=
 =?iso-8859-1?Q?jm9aMVgePBEBjsulJNFMYnnfKyR42sDWQcKf6eAk5Jp4rxT40XXliWCjSB?=
 =?iso-8859-1?Q?iYD7K5w+o+wBfEGUK+iMnMxuE6ZiH00KUCz1KgtnjQWH9YCNqEfahZEJdb?=
 =?iso-8859-1?Q?sLy4yO3Nt37X6qzcJVdAvSKBDNhuHb+fcy5rUQrcuA/QJsDn0K893Jefju?=
 =?iso-8859-1?Q?wF4LEHFQRAlO0qO4wegFbmLaKQZkSOVYHhunsA+PRJsBYSO1dqGYPWoWLc?=
 =?iso-8859-1?Q?qt/wMFqbD5uhnQqvLXuwM4t/m0icN+M+GPuMIio0bEoFhyMpAXPy0smWB+?=
 =?iso-8859-1?Q?0iXo+OmgOzihsVU9s/OVi1S7cyTsuA5eOrPmR5Oz9a1QwJHYOdxdM+YuFo?=
 =?iso-8859-1?Q?Dp6Ba4A1eTiqmK5Yia2Qj6BY+wRBHc8QyqLgFU1f0V2TUwX5dTzLHSQWqI?=
 =?iso-8859-1?Q?UCk8ZDMbzKU7xbm/IcWmMsEsRYQp54GV0infWh7fU/Q40pQJxLYb6a3lPe?=
 =?iso-8859-1?Q?6jh3CwM18DIIz89sITW7sbnjPBDzO8my6CTrS3GjcYUfID/slQDd917xKI?=
 =?iso-8859-1?Q?p9/UiUL3MI+tJv1ZG5n9fakVt9PLZvrlXrPydR8lnb3xQssrO+bTLgZ6ZR?=
 =?iso-8859-1?Q?oLVvbwYwdC4hx4Eyi4DhZD7I5h19gvtGDqrINDqNTxorJwG5euN3I9w14W?=
 =?iso-8859-1?Q?a6EmslwYE7wdU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f014a64c-188e-4394-9ad4-08dde142b12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 06:11:11.2823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q73qyGhu6aebCgF5rAcLvR4oVPyFz2CLQ6zdpHQqjxSr/Huaxml3XV27MxHtbHllgcI5u4YEWCZLGOu2caT3uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4005

Hi,

I suspect a driver issue, you can check wpa_supplicant & kernel logs.

Spec says to be Wi-Fi certified and 802.11ax capable, WPA3 should be suppor=
ted.

Is latest driver integrated?

Best regards, Sven

> -----Urspr=FCngliche Nachricht-----
> Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> Gesendet: Donnerstag, 21. August 2025 15:48
> An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7) <sven.dembian=
ny@bshg.com>
> Betreff: Re: AW: AW: AW: v1.45, broken wifi connect
>
> Hi,
>
> I just started to test Ugoos X5M Pro with Amlogic W2 chip.
> With this chip it is again not possible to connect to Wifi.
> There does no info exist about this chip, only this source:
> https://github.com/CoreELEC/w2-
> aml&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C10696a11780345b42e8508dd=
e0b966bd%7C0
> ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638913809067032337%7CUnknown%7C=
TWFpbGZs
> b3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT=
WFpbCIsIldUIjoyfQ
> %3D%3D%7C0%7C%7C%7C&sdata=3DX7vKJYz41CPLpsAKFzkNvMXTS4OPDE7O36ZWa8hUqwA%3=
D&reserve
> d=3D0
>
> Only by adding the revert of the connman commit and disable CONFIG_SAE it=
 is working again.
> I also tried without the revert and using wpa_supplicant defconfig it doe=
s not work.
>
> Any idea how to find the reason?
>
> With reverted commit and disabled CONFIG_SAE I get connected with this in=
formation:
> /net/connman/service/wifi_f0960256bbc4_43492d30303330313536_managed_psk
> Type =3D wifi
> Security =3D [ psk ]
> State =3D ready
> Strength =3D 99
> Favorite =3D True
> Immutable =3D False
> AutoConnect =3D True
> Name =3D CI-0030156
> Ethernet =3D [ Method=3Dauto, Interface=3Dwlan0, Address=3DF0:96:02:56:BB=
:C4, MTU=3D1500 ]
> IPv4 =3D [ Method=3Ddhcp, Address=3D192.168.2.221, Netmask=3D255.255.255.=
0, Gateway=3D192.168.2.1 ]
> IPv4.Configuration =3D [ Method=3Ddhcp ]
> IPv6 =3D [ ]
> IPv6.Configuration =3D [ Method=3Doff ]
> Nameservers =3D [ 8.8.8.8, 8.8.4.4 ]
> Nameservers.Configuration =3D [ ]
> Timeservers =3D [ 0.pool.ntp.org, 1.pool.ntp.org, 2.pool.ntp.org, 3.pool.=
ntp.org ] Timeservers.Configuration
> =3D [ ] Domains =3D [ lan ] Domains.Configuration =3D [ ] Proxy =3D [ ] P=
roxy.Configuration =3D [ ] mDNS =3D False
> mDNS.Configuration =3D False Provider =3D [ ]
>
> With reverted commit and enabled CONFIG_SAE, no connection:
>  /net/connman/service/wifi_f0960256bbc4_43492d30303330313536_managed_psk
> Type =3D wifi
> Security =3D [ psk ]
> State =3D failure
> Error =3D invalid-key
> Strength =3D 91
> Favorite =3D True
> Immutable =3D False
> AutoConnect =3D True
> Name =3D CI-0030156
> Ethernet =3D [ Method=3Dauto, Interface=3Dwlan0, Address=3DF0:96:02:56:BB=
:C4, MTU=3D1500 ]
> IPv4 =3D [ ]
> IPv4.Configuration =3D [ Method=3Ddhcp ]
> IPv6 =3D [ ]
> IPv6.Configuration =3D [ Method=3Doff ]
> Nameservers =3D [ ]
> Nameservers.Configuration =3D [ ]
> Timeservers =3D [ ]
> Timeservers.Configuration =3D [ ]
> Domains =3D [ ]
> Domains.Configuration =3D [ ]
> Proxy =3D [ ]
> Proxy.Configuration =3D [ ]
> mDNS =3D False
> mDNS.Configuration =3D False
> Provider =3D [ ]
>
> Thank you for your help!
> Portisch
>
>
> Am Donnerstag, 21. August 2025 um 10:01:59 MESZ hat Dembianny Sven (BSH G=
DE-EDSD7)
> <sven.dembianny@bshg.com> Folgendes geschrieben:
>
>
>
>
>
> That's good news.
>
> > -----Urspr=FCngliche Nachricht-----
> > Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> > Gesendet: Donnerstag, 21. August 2025 08:27
> > An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7)
> > <sven.dembianny@bshg.com>
> > Betreff: Re: AW: AW: v1.45, broken wifi connect
> >
> > Thx,
> >
> > indeed, this do solve the issue:
> > https://gith/
> > ub.com%2FCoreELEC%2FCore&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C1=
0
> > 696a11780345b42e8508dde0b966bd%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%
> > 7C0%7C638913809067076253%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRyd
> > WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3
> > D%7C0%7C%7C%7C&sdata=3DSIEjXqBiozA35HFokZksZLl0SaCZPCLmevSyso6Fd4A%3D&r=
e
> > served=3D0
> > ELEC%2Fcommit%2Fa8f96d2c4a97bd2afdd49c5aac6d14cd6efb8494&data=3D05%7C02=
%
> > 7Csven.dembianny
> > %40bshg.com%7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4bbb6d6
> > 48ee58410f4%7C
> > 0%7C0%7C638913544287997489%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnR
> > ydWUsIlYiOiI
> > wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
> > C%7C&sdata=3DGAlOx
> > 3ugq0WWVUMwUXE%2F1AqZelOQvRd8FndGqYwiMfM%3D&reserved=3D0
> > Maybe connman should be include a switch if this option is enabled or n=
ot?
> No idea, CONFIG_SAE is activated per default by hostap, if mainline defco=
nfig is used, or a self-maintained
> one is updated with wpa_supplicant updates there should be no issue:
>
> https://w1.fi/cgit/hostap/tree%25
> 2Fwpa_supplicant%2Fdefconfig%23n258&data=3D05%7C02%7Csven.dembianny%40bsh=
g.com%7C10696a1
> 1780345b42e8508dde0b966bd%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63=
8913809067
> 107569%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMC=
IsIlAiOiJXa
> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DsZugNQsu5nyx=
7nWvbHO6UDwk
> nzmsyDRwXEy2Rry8jIY%3D&reserved=3D0
>
> Best regards, Sven
> >
> > I tried also to replace wpa_supplicant by iwd like LibreELEC was doing =
in past.
> > But the results are like the Wifi networks are not visible at all anymo=
re.
> > If visible connection is not possible.
> >
> > So we will stay with wpa_supplicant.
> >
> > Thanks for your help!
> > Ticket can then be closed now I think.
> >
> > Portisch
> >
> >
> >
> >
> >
> >
> > Am Mittwoch, 20. August 2025 um 15:44:38 MESZ hat Dembianny Sven (BSH
> > GDE-EDSD7) <sven.dembianny@bshg.com> Folgendes geschrieben:
> >
> >
> >
> >
> >
> > Hi Portisch,
> >
> > maybe adding WPA3 support for wpa_supplicant can help us.
> > Can you give it a try and add
> >
> > CONFIG_SAE=3Dy
> >
> > in
> >
> > https://gith/
> > ub.com%2FCoreELEC%2FCore&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C1=
0
> > 696a11780345b42e8508dde0b966bd%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%
> > 7C0%7C638913809067140991%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRyd
> > WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3
> > D%7C0%7C%7C%7C&sdata=3D6Z6FIbqmAglo9y0b05gAIbTqX0%2BYO1CQnjnRqfDZIRk%3D=
&
> > reserved=3D0
> > ELEC%2Fblob%2Fcoreelec-
> > 22%2Fpackages%2Fnetwork%2Fwpa_supplicant%2Fconfig%2Fmakefile.config&da
> > ta=3D05%7C02%7Csven.d
> > embianny%40bshg.com%7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84
> > e4bbb6d648ee58
> > 410f4%7C0%7C0%7C638913544288023231%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1
> > hcGkiOnRyd
> > WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3
> > D%7C0%7C%7C%7C&sd
> > ata=3DHSQurgEaI8o%2Fvx5D5IoEQylng796X1TcA181TV9qf3A%3D&reserved=3D0
> >
> > Best regards, Sven
> >
> > > -----Urspr=FCngliche Nachricht-----
> > > Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> > > Gesendet: Mittwoch, 20. August 2025 15:21
> > > An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7)
> > > <sven.dembianny@bshg.com>
> > > Betreff: Re: AW: v1.45, broken wifi connect
> > >
> > > Hi,
> > >
> > > server is OpenWRT with: SSID: CI-0030156, Encryption: mixed
> > > WPA2/WPA3 PSK, SAE (CCMP) Client Khadas VIM3: AP6398S
> > >
> > > Same behavior with X96 M300, RTL8822CS, vid: 0x024C, pid: 0xC822
> > >
> > > With commit included:
> > > --------------------------------------
> > > VIM3:~ # connmanctl
> > > connmanctl> services
> > > *AO Wired ethernet_0200001e1f01_cable *A CI-0030156
> > > wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > connmanctl> connect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Error
> > > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_
> > > ps
> > > k: Not registered
> > > connmanctl> state
> > > State =3D online
> > > OfflineMode =3D False
> > > SessionMode =3D False
> > > connmanctl> disconnect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Error
> > > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_
> > > ps
> > > k: Not connected
> > > --------------------------------------
> > >
> > > With commit reverted:
> > > --------------------------------------
> > > VIM3:~ # connmanctl
> > > connmanctl> services
> > > *AO Wired ethernet_0200001e1f01_cable *AR CI-0030156
> > > wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > connmanctl> connect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Error
> > > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_
> > > ps
> > > k: Already connected
> > > connmanctl> disconnect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Disconnected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > connmanctl> connect
> > > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > Connected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > > connmanctl> state
> > > State =3D online
> > > OfflineMode =3D False
> > > SessionMode =3D False
> > > --------------------------------------
> > >
> > > Wifi is working again.
> > > We got multiple reports from users haveing same issue:
> > > https://disc/
> > > ourse.coreelec.org%2Ft%2Famlo&data=3D05%7C02%7Csven.dembianny%40bshg.=
c
> > > om
> > > %7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4bbb6d648ee58410
> > > f4
> > > %7C0%7C0%7C638913544288040178%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG
> > > ki
> > > OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> > > fQ
> > > %3D%3D%7C0%7C%7C%7C&sdata=3Dm%2BtmZYRdI8bMJxhT2%2FU3j5XvwmBZfjqsnZ%2B=
f
> > > OK
> > > gIeb0%3D&reserved=3D0
> > > gic-no-
> > > discussion%2F46663%2F2296&data=3D05%7C02%7Csven.dembianny%40bshg.com%=
7
> > > C3
> > > cce9ee05e2049040
> > > 15108dddfec6794%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C6389129
> > > 28
> > > 619230523%7CUn
> > > known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> > > Oi
> > > JXaW4zMiIsIkFOIjoi
> > > TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DEjK%2FrOlN1nhCNVmlmxzbp=
e
> > > Yw
> > > cyRt6tqLJt9VS0y
> > > uJpc%3D&reserved=3D0
> > > Then we reverted this commit and all is good again.
> > >
> > > Thank you very much!
> > > Portisch
> > >
> > >
> > >
> > >
> > > Am Mittwoch, 20. August 2025 um 13:33:40 MESZ hat Dembianny Sven
> > > (BSH
> > > GDE-EDSD7) <sven.dembianny@bshg.com> Folgendes geschrieben:
> > >
> > >
> > >
> > >
> > >
> > > Hi Portisch,
> > > >
> > > > Hi,
> > > >
> > > > current connman is broken and can not connect to encrypted networks=
.
> > > >
> > > do you have more info about your setup?
> > >
> > > We can't reproduce the issue with 43455 chip.
> > > Which chip do you use, is it WPA3 capable?
> > >
> > > What AKM is configured on your AP?
> > > Which wpa_supplicant version?
> > > Is SAE activated for wpa_supplicant?
> > > >
> > > > Revert of this commit do solve the issue.
> > > >
> > > > Error log:
> > > > connmanctl> connect
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> Error
> > > > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d303033303
> > > > connmanctl> 13
> > > > connmanctl> 53
> > > > connmanctl> 6_
> > > > connmanctl> managed_psk: Input/output error disconnect
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> Error
> > > > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d303033303
> > > > connmanctl> 13
> > > > connmanctl> 53
>
> > > > connmanctl> 6_
> > > > connmanctl> managed_psk: Not connected
> > > >
> > > >
> > > > With 1.44 there is no such error:
> > > > connmanctl> disconnect
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> Disconnected
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> connmanctl> connect
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > > connmanctl> Connected
> >
> > > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > >
> > > >
> > > > Thanks,
> > > > Portisch
> > > > Team CoreELEC
> > >
> > > >
> > > Best regards, Sven

