Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CA2F9D82
	for <connman@lists.linux.dev>; Thu, 13 Aug 2026 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604727; cv=fail; b=B74YLoODt7IIAe4IIbZWvhz+WPk/LmpvBErdCyeuEn5xrmAohptB7gNwuKWIiR7RZc+wNIdcWfWdCYjfrdYHKpzYLsulLIT3RfBOoTH81Glbo3fFeusdfAY5ZULx3DPD7yM5ZnwxpLSvJX4K7lDLjRzIXS6BCl4zP/0zmHQMda8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604727; c=relaxed/simple;
	bh=Whts+ONxwZohX8g+myxb2BUrCCgj7M5nH8OlrU1wGTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrImkz7GzYuXcbLI/wpYTrzjgenqyzTFYy/pcnsIJtyZFYoZibLyigOj2B+3fjYL7sdrOUauYrdniDIt4YiT9ma3gtHQv0Doc7I3Y9uHASta0oKWO6k2n6kBu9YZU7Pj/vBLHAWRDK/suPLEpG63joM13fgSUTmi4whNhGuBPeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=P3XJgbmO; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="P3XJgbmO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COkShnRbrOFF8QSK18utAgfdI1Y3umH4wPYWiWmmsrJpOOmliJ6bqvHhVbGBDhkeSi3yGoq9xRX+a26dBs6U3mijOb0gRM8SABdEdChQD1KHKj/cmVQg8aUWHqyFuyN/l3khqdl0gQn5vqJ9PeAmTAnMSRWygSzpjYpWZ7rYLXuEadplH8cRbE7WsBTPWkJ9V+fyKhx7kHtiFyTPKUJ1MZF3+GypJd8WHemOamiSwXZ7pTP/GySzmb/bUk1X2gQbDpzdJbHQ/+2FV6Cyh6Iedf4ajz9Bmlu/CEp8bnsA0tsfycfDGPEiFr4ztuHnYQpq/lQz7awHxQoXECNpx7qUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiS8wBJeMwrJAVEPmrMi8GHkWru1INQdIfdfevjcVwY=;
 b=xfLuL43rVkR2oEAlsXR+W/FrutHJIicmbYdxdLJl4n3iIdzg/3+FR1FGDc04GAxzIRn3zNEsMIF1gfDPJjG5dVmR/CB77WnnN8M3cozmRPTwvUfAmrT6Q925KZRhnEV1Xtu9y/r1TAq0nwVOMEg8DNHdONtdrIA3fcpjNX4/2o+r8yPut/wDJTuLJtDRNK00+EAMPJIQ9A7gEKS5AtjkrqyqDtBrfII0fSiYE48G4tgnfS+r70PEiTxvR+rI9S4exE2J/9twQocC+o6ttF/LmagiS0TP9BObTTYnS5EqfOrKtylws8j+bUptboDlYioucy530kuRPM1zURgMkfn/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiS8wBJeMwrJAVEPmrMi8GHkWru1INQdIfdfevjcVwY=;
 b=P3XJgbmOTDQHXoUdIkzEk/D6rR9rd7Rx8lxPrs0NAA6RiDz2vCIvP0m+RSA6CGwVPHm3PPFDmFrSwhhId+9sEyBC/3uANLpKWTIuutnpnYx2EPs/OSgIWOtfkoOE3ixlejqHja84sOyiBMbFDrw1ePMAzPF16Iw/YPuEyXVskJpplD8W1Ww48EFK54ApT4+9kLc/Dl2ThHWFZrZCV+Q1QC3ct3gHSUvgI5d/h3QEhj4yZky8BwN3U+Ry5yvzWcW0IVI5lzQYapikc+PMynTogj+sEEUKqV7Jsqsq9HYWOL7jR/PXReeweVXP4M58mBR2aDVW7dhFK/49tACatkQ49A==
Received: from VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::13)
 by DB5PR10MB608954.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:05:22 +0000
Received: from VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c595:d36a:295f:156d]) by VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c595:d36a:295f:156d%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:05:22 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
To: Waldemar Brodkorb <wbx@openadk.org>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	=?iso-8859-1?Q?Fran=E7ois_Galea?= <fgalea@free.fr>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: Connection to a WPA2 Wi-Fi router fails
Thread-Topic: Connection to a WPA2 Wi-Fi router fails
Thread-Index:
 AQHc4e+1v6y0J6G1nEqVaCo5rDvA+rYKIKiAgAnZqhCAgdX8gIABh6owgAJSPICAAnUskA==
Date: Thu, 13 Aug 2026 07:05:22 +0000
Message-ID:
 <VI0PR10MB8908254CA2980FEFA0F4A905F4DB2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <anghETbH2WzsZIJ9@waldemar-brodkorb.de>
 <VI0PR10MB8908D439894A87FDC9341D6EF4DE2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <antcGRBvImhKFSyu@waldemar-brodkorb.de>
In-Reply-To: <antcGRBvImhKFSyu@waldemar-brodkorb.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR10MB8908:EE_|DB5PR10MB608954:EE_
x-ms-office365-filtering-correlation-id: 3d95f833-6a0a-48e4-f1a0-08def9093e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|11063799006|10067099003|56012099006|6133799003|3023799007|4133799003|4143699003|22082099003|18002099003|38070700021|41080700001|15866825006;
x-microsoft-antispam-message-info:
 nmFObDBZVWhkL2tUjhrwKuWJGjDzcW1yJ45j6eabWRNB9haBn3An4Z5MVziIKnHmuorotTY01GmqHvhvV/mdRY+fJZ+0BGvBFk5rLYULErW/Eg22n/DJNosyas/JbL+hiE+kd6Wiy/uFGTyRr72VtUqnwYfVIbNsAcK3BURPlhgDCBmEntmukTMHRnBHs0CFXsUt7z9HKv1vQd4VRTlzY58lNyl+D9tgXcjfPBsIad6+Gpcvj48NXNTkyMegILCtBWXT54xMZfJyUqlizJ/TIkJdi9KFoY0chrdqUGDKepK50R4/oiedcZPNAYZeLhr4oElijiFGSG/L5YOzSGXXm+SYn3L93cY9kkX9QJjNuskRJbnREaKLSSvwgPjhmetQGmiaICxPsSpwwlD4T8EWPXOe5iEACxa2snUvkLJRIEtv5j1NhVJ7waCY2OEXryVgqGhg7AAnOxRJtruU5b7akWhFJKEK50miDv12jYZ0dqbY0ODG0xYb/lbLv1RJOLVR8WKC/hUk0eNBBYx+Q+BKDdkNkgRdGnY/7N1cx4/2IxaUdl6TF8sYQQuUQJ/ODsg6dR+yeOEuBbwrvPrhoZvC1yq8ARacjl1/iLUuKUctvMMA7wM36MKjepFx24I+917x4gjuJx9rWg9jVwtfzB+md1JnK+l6iHD6P/tTci3ambWfz1QyytKsWYSRQOj6brZSiwcYpUN4LcriUrE4GSMmHWC2EeOaO+WbAAHZVDDH4LQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(3023799007)(4133799003)(4143699003)(22082099003)(18002099003)(38070700021)(41080700001)(15866825006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1w0LV45NwH/Mpf4Ee7hP+x79puw5fKiXLy9sR5BocbcTBm3OI7uihOG4Ea?=
 =?iso-8859-1?Q?zJtCSL57A7XWRgnqNvGs7sfRpiPnKhYXSCxE6iKvwsyiJQhhv8J5SANd46?=
 =?iso-8859-1?Q?noHSDcAHTiu1O5UR8lm5mRwxGyRxd3s/XzdwdYMEh9/IOF1/saX/nKNoHS?=
 =?iso-8859-1?Q?ojNwaJqRNVsn0QYrqyYsrN8SRM0sy9/r3zOUoPIAEaePzrEuyajE1OXIfi?=
 =?iso-8859-1?Q?EVWeflPeiqUto/Xv4UC9D4f8dFQAAzaUZ9CgE72u9UxL0h5g5F3Qo9BGEq?=
 =?iso-8859-1?Q?L85ms0RgZrUJEiNgn0XfJHm4AUUlFEgRvefwbZ9kCkS/PYm/5sF1i3n1C/?=
 =?iso-8859-1?Q?DcJVlbEhPiSc8H7WnhWhrhuRxNXwmCeu0vuRyLrOWiZini6ZXlYRHr4NRa?=
 =?iso-8859-1?Q?V9TuGiTtgwp5b1yRp9cuGnp6Dmf6yeJP7XDQ+hoRAZ+hGJmGzfvGVHVaTl?=
 =?iso-8859-1?Q?3mN+C3PrixG+AscR5jt4BseGz8vPQKkmFg5zXf+y0YH8MIH2clcvnWf182?=
 =?iso-8859-1?Q?VJpCl56UAhDAc+5lI64gXWWi2iFtT821qk+Fu5c8dCEKUZVMswCWJ9LIUY?=
 =?iso-8859-1?Q?YFjeMdA+1bnkUf/eRUZkw4j12idAahWHFlyJyMByKbmM+0NPVLTXh1PmX8?=
 =?iso-8859-1?Q?5/Gtg46uEeWMUsPCI41tifS0BOjnrATZW/sV2decAc5C/C63P/AncuGAPX?=
 =?iso-8859-1?Q?JFR+lBcgEaI1LZpE6gFabp5FWKdY8NTNCTV8N/n2QtnLCm2w4BANCXF0FV?=
 =?iso-8859-1?Q?E5Yy39IF9YHmTZgRaXlSd0ERpV/4x/BU+NP9wRNkz1CkMLSi1jprkNJR0F?=
 =?iso-8859-1?Q?J+EsjuzzJzZejJ7Z2mBswHJHQjBXS+CXQDXYzvCACPQHR0n7ZaNrMlghu6?=
 =?iso-8859-1?Q?qDPhyJjP93A7eUWjQM5Oqr9YD7s+sW5uc2TgyLkod941bPEsXAsMnSSxp0?=
 =?iso-8859-1?Q?KRGRFi3XncoEPdrJA1LzyabMzwQY81f68D+KCtBh9+tya6t3i1MJYwcJPY?=
 =?iso-8859-1?Q?flfUzjlZFjCFJbY3E4I4HIXVScvkCRULQe3YnWbLL8ydoyD8qymmv1158V?=
 =?iso-8859-1?Q?W0oM020LTmhekHuwDJHBUdlqRxgK+r2JQf98KhSewzwE11aUb5/3BhS5HK?=
 =?iso-8859-1?Q?TGmnCjS9SVa5sPleqeK02ov5G8CEA6TP1rZXtvx9aQOHj5q81wMiWDlzS3?=
 =?iso-8859-1?Q?1oVJNRK/L2VI2gdvipUwDAa+Qf6fGoAdiBSxzDN9xNSbarDZMhX3dMu9pf?=
 =?iso-8859-1?Q?YLfwzSqILIXiCg0ULzQGWO+pFLB/fHPq5qK/9ex0XkbCGFCK3WWwDqIKjp?=
 =?iso-8859-1?Q?svIp/saxZkZ28BOs5T8nuMxNHGFfyiKNQHcHUqa52/voyc1xnb3RS0lJyG?=
 =?iso-8859-1?Q?0jWu+xmPx3ZZExaPka0H3I0dMn9rhYOUvjj/QxP7LGzo7P5ssxjnWlYvj2?=
 =?iso-8859-1?Q?NFgJ+RlygicgR6SMqctpul704dKV+Z1v36M6tf4B8eIVM7IfQWtAHSqQ/b?=
 =?iso-8859-1?Q?lh2jz7iDMx+hTt2H1WZq956Rt+YwsoOSCXRgFQSXHhRP6OpmLhhUuR8oZj?=
 =?iso-8859-1?Q?6vIJiM8MOb0i4RJXVKRAUvB77vAT4aKAIffd4V6p2pAGaEIVwwBP1Pqqxv?=
 =?iso-8859-1?Q?31cWaCstFgTQPDuzXhQTKcLp92gQy+ub1axNEVWOe1d9mEGmoOIUwP7tBC?=
 =?iso-8859-1?Q?joiT0vzpsGUxR6IsJJjxs9Iulom/0DqfT1s+RcD0zXbkce8hiPD++MiONM?=
 =?iso-8859-1?Q?i8C2em6D77bQMnMcEAfWYLNEQFv1mQc6QtmeY5pZXpfelT?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d95f833-6a0a-48e4-f1a0-08def9093e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 07:05:22.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjb12fdIxiv9tO2B+Wn/XIuAdKG2vNlg1dtxqaT4GefHIQOtQSJODncupwLjPcXcuQW9ApuSz8VuzNujd6Kphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB608954

Hi Waldemar,

yes, that seems reasonable. We need additional information to better unders=
tand what is happening.
Could you please provide a wpa_supplicant log with debug logging enabled?

Best regards, Sven
> -----Original Message-----
> From: Waldemar Brodkorb <wbx@openadk.org>
> Sent: Dienstag, 11. August 2026 19:30
> To: Dembianny Sven (BSH GDE-EDSD7) <sven.dembianny@bshg.com>
> Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>; Fran=E7oi=
s Galea <fgalea@free.fr>;
> connman@lists.linux.dev; wbx@openadk.org
> Subject: Re: Connection to a WPA2 Wi-Fi router fails
>
> Hi Sven,
> Dembianny Sven (BSH GDE-EDSD7) wrote,
>
> > Hi Waldemar,
> > >
> > > Hi Sven,
> > > Dembianny Sven (BSH GDE-EDSD7) wrote,
> > >
> > > > Hi Michael,
> > > >
> > > > I don't think so, e.g., if AP does not support SAE but repeater doe=
s, roaming will fail.
> > > > This will also break certification tests.
> > > >
> > > > @ Fran=E7ois do you have more info about your setup, e.g. MFP
> > > > setting on AP/wpa_supplicant
> > > config/WPA-PSK-SHA256 instead of WPA-PSK?
> > >
> > > Sorry for the late reply. Francois seems not to answered your
> > > question and I see no fixes for this problem in GIT master either.
> > >
> > > My AP is a standard Vodafone AP with WPA2.
> > > How can I give you better information about the details of this AP?
> > What model is being used?
>
> Vodafone Wifi 6.
> It is this one:
> https://www.vodafone.de/download
> area%2FCGA6444VF-DMS3-CTC-25-
> 593_v2.0_German_public_20210511.pdf&data=3D05%7C02%7Csven.dembianny%40bsh=
g.com%7C59663c
> 7c2d2d49ac217508def7ce2d13%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C6=
3922066219
> 4440574%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM=
CIsIlAiOiJ
> XaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DycBjQxmEPc=
xuLgXBXIMrjCg
> OsU9mHQ%2B%2B%2B%2BOcVwvkfTg%3D&reserved=3D0
>
> > It is possible that MFP is additionally configured as optional. Could y=
ou please check the AP settings
> or the beacon frames?
>
> It seems not.
> See:
> sudo iw dev wlan0 scan | grep -A20 -B2 'Vodafone-C30C'
>       last seen: 84 ms ago
>       Information elements from Probe Response frame:
>       SSID: Vodafone-C30C
>       Supported rates: 1.0* 2.0* 5.5* 11.0* 18.0 24.0 36.0 54.0
>       DS Parameter set: channel 11
>       Country: DE     Environment: Indoor/Outdoor
>               Channels [1 - 13] @ 20 dBm
>       TPC report: TX power: 18 dBm
>       ERP: Barker_Preamble_Mode
>       Extended supported rates: 6.0 9.0 12.0 48.0
>       RSN:     * Version: 1
>                * Group cipher: CCMP
>                * Pairwise ciphers: CCMP
>                * Authentication suites: PSK
>                * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
>       BSS Load:
>                * station count: 2
>                * channel utilisation: 31/255
>                * available admission capacity: 0 [*32us]
>       RM enabled capabilities:
>               Capabilities: 0x72 0x00 0x00 0x00 0x00
>                       Neighbor Report
>                       Beacon Passive Measurement
> --
>       signal: -72.00 dBm
>       last seen: 3208 ms ago
>       SSID: Vodafone-C30C
>       Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0
>       TIM: DTIM Count 0 DTIM Period 1 Bitmap Control 0x0 Bitmap[0] 0x0
>       Country: DE     Environment: Indoor/Outdoor
>               Channels [36 - 64] @ 23 dBm
>               Channels [100 - 140] @ 30 dBm
>       Power constraint: 0 dB
>       TPC report: TX power: 23 dBm
>       RSN:     * Version: 1
>                * Group cipher: CCMP
>                * Pairwise ciphers: CCMP
>                * Authentication suites: PSK
>                * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
>       BSS Load:
>                * station count: 6
>                * channel utilisation: 6/255
>                * available admission capacity: 0 [*32us]
>       RM enabled capabilities:
>               Capabilities: 0x72 0x00 0x00 0x00 0x00
>                       Neighbor Report
>                       Beacon Passive Measurement
>
>
> > Also, what firmware version is running on the Raspberry Pi 4? The firmw=
are files should be located
> under:
> > /lib/firmware/
>
> That is the dmesg output after loading the Wifi driver in Buildroot:
> [  249.369934] brcmfmac: F1 signature read @0x18000000=3D0x15264345 [  24=
9.373427] brcmfmac:
> brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6 =
[  249.382449] usbcore:
> registered new interface driver brcmfmac [  249.618723] brcmfmac: brcmf_c=
_process_txcap_blob: no
> txcap_blob available (err=3D-2) [  249.626771] brcmfmac: brcmf_c_preinit_=
dcmds: Firmware: BCM4345/6
> wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID 01-b677b91b
>
> But at the moment I am fighting with connmanctl, it seems I cannot scan w=
ifi anymore:
> # connmanctl scan wifi
> Error /net/connman/technology/wifi: Not supported # connmanctl enable wif=
i wifi is already enabled #
> connmanctl scan wifi Error /net/connman/technology/wifi: Not supported # =
connmanctl technologies
> /net/connman/technology/ethernet
>   Name =3D Wired
>   Type =3D ethernet
>   Powered =3D True
>   Connected =3D False
>   Tethering =3D False
>   TetheringFreq =3D 2412
> /net/connman/technology/wifi
>   Name =3D WiFi
>   Type =3D wifi
>   Powered =3D True
>   Connected =3D False
>   Tethering =3D False
>   TetheringFreq =3D 2412
>
> I can scan wifi with iw on the RPI4.
>
> best regards
>  Waldemar
>

