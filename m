Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8D1858
	for <connman@lists.linux.dev>; Mon,  9 May 2022 07:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll+CeTrF5ib2ZLuKr316sPAH4uHIXZ6alaiW6c3z5MHL9WSyb4tBij/NcJS/G0+aaKsZBsx8NsuH8KvywlKIgWNpWWz1rdXGb9ocXjT5Rs2SttzxcsraB0dqRMo1jYMOBeicMsOzcMwsyStMRYVfkhBYTV1ECQOmy9MMofjbpjolzjbjvW7WmYMZEzFj6LTKl5THtKEgxiLp5MIFLOLE7mBJJQeYLVH0Cht1T4L+RS/7u2o2eGd3p2X0BV86ZAXz59jvnEwCndN2AUZc4ATPu8O5U0jC4tAqe9zhctVyrp6J0QQrw+P5Yw1kD+OSh23sPKg/6c6l/TzL4kh/GxDmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN7t1Ngq+MOV6Z4dmGPGiLAd9iFSSDMoFl2xr3mTIMg=;
 b=m2ZPOtAu64wwofujuTerTUqCkY09WDxWFqjrwHPzlCV+kiu7ZNCz1f8QyoyPggweQI0xzSOcrPE7zDIosMky60QEnO36mpZaMmmnUx8+bDFFUNs9MAQqPDtavMNy2S2CaMCCJAyL193QkybwpPNEknB4iKqak6Fz3XyA85n67ytqu7Mt7GsPauUbNHZgzot7d7V4sv2xeKjUypJqsj2klJ8rukzGfEBxrEwWQJbMFytgliTDXzSTm9j4ZR0JKPzjW3+Osvi45wkhkHvoL8Sv7PHchHMaA3Yo8qgOH50NfdsxLhj027t4/kd8M0qj6f8b4tdI+tA/dwlgBNgMGTTNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=holtmann.org smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN7t1Ngq+MOV6Z4dmGPGiLAd9iFSSDMoFl2xr3mTIMg=;
 b=YTh+R4meD2L5OHLFflGmd7m/HfoGrGw1lvJ8j7hEOo1rJYy+k+qVMOMHu72X05M9HOvPalUQIb3CH8KSsq59n58a6xHLQrxgVGn8OJ76N2Vz5F690lIXEsGEK7Zky0fzzB26g/E9UJrMEX8Xc/abEf/GuQqWvaOu1IE6a2cbbEDDEnM76U3shtK6JyMchz3hTMubsRo9nCNI1FeWDKwzWbW042e0tO2f9U9nRDD9lcWwxOs/KvckqrFkLRvhm14WQuecR0A1d5/eemnIFm22sFovIHYLFjlMy6iLv+55U+2V/c3CYnF2HF2rhZFHZSiFCg/xGWuaOSSpnaEVvWs+hA==
Received: from AS8PR04CA0181.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::6)
 by AS4PR10MB5944.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 07:46:56 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f3:cafe::5e) by AS8PR04CA0181.outlook.office365.com
 (2603:10a6:20b:2f3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 07:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 07:46:56 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 9 May
 2022 09:46:53 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Mon, 9 May 2022 09:46:53 +0200
Received: from FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 09:46:52 +0200
Received: from FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) by
 FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 9 May 2022 09:46:52 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Mon, 9 May 2022 09:46:52 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3%6]) with mapi id
 15.01.2375.024; Mon, 9 May 2022 09:46:52 +0200
From: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Thread-Topic: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Thread-Index: AQHYWLZd2qtADdGnG02gfFrLFNvjNq0CHlAAgAAHcICAASo+YIAARooAgBKmxbA=
Date: Mon, 9 May 2022 07:46:52 +0000
Message-ID: <4b9a0754ab29428fb95b53a65c399925@bshg.com>
References: <20220425150837.89194-1-sven.dembianny@bshg.com>
 <20220425150837.89194-2-sven.dembianny@bshg.com>
 <4deec7b0-a2e5-0d91-a81c-dc4bb79c1594@collabora.com>
 <8B96358C-6DA1-41E0-8C79-7724AD78EC53@holtmann.org>
 <6dbc9c41e6f5459291a118bdd0dcfc5f@bshg.com>
 <BC5A9223-D70D-4082-930D-AED73268EF8B@holtmann.org>
In-Reply-To: <BC5A9223-D70D-4082-930D-AED73268EF8B@holtmann.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.49.85.188]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d83ada2-2c3e-47be-bd41-08da31901756
X-MS-TrafficTypeDiagnostic: AS4PR10MB5944:EE_
X-Microsoft-Antispam-PRVS:
	<AS4PR10MB59447B2C67F6963B10812794F4C69@AS4PR10MB5944.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mDYDhE6nUqdlHMT40n2pDAfgXfmcVoevoqVzz8RlLwi2oS0CCEZWpMsQS94VM0vhXnyV5A7LY2HM7Dxr+ekwsyZ/OpM8NPMO9q5K+CNi064EkIrlxmo5v4QA0GTi+cGjn4ohvnyrDASpZukCkEjJbwoF5zx/5DZJJ6JQ/22oWpuQLw29hiCLKK5pY33iUyhO1uKLxjvZiT8HiQdVQTUjolRC6n+Z3ffYG1wUU3KEjxAeN0IAVpuwxHbIi5+cASLIcIAiAFxckS3WsHAPgi4DOVeC465QDitKMV9rS/b2PBGjlPFdWt9Piof9d/UmQ79jxTikEbAoxDNHoMiDVHlFV5IlEtdj0IrHidNgpk4REtxJ1+HQSRkSJ3QSzwZaxOHt43Dgcf/jhds6vRrWEsBAf/4tHxFOMMwoHWFJTtJN5JjEkb5yutpN7TblPtKzPNrZuGLEq2skdFUMo2FJpAEisxNaQM9ZSCi8JHvJ1Xete0UKnCOKNJUC6XZq3UzyyzwU0l7b/TUqmEzUpvvoOk4x+zF46xRi5gL5SyLsQgUCFtJhqa1rG+sdwPIO5L7aYUuhln94/Ifq2TsyLYlCtzT7mVJW/f5W6vL+G2b7wml/HN4WBUdNKJkVQfaKrF7VM1T4PYtCvrXkD8iDo1TpGizk4NBcYtgUO5D09Ea0ekprMl7ecPupcWDlg96lGb5s/AHiKL2t5E8JbqoFWHkH3EPRAzj3s/J2yfaaIMiawsEm/94Dj+R62HbUP1URdIrX9LjHgpsGatWzsfMLvuUllx84TopDee/5uy2eaWIoBZC5t/I=
X-Forefront-Antispam-Report:
	CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(24736004)(70586007)(70206006)(356005)(336012)(426003)(2616005)(8936002)(966005)(47076005)(83380400001)(6916009)(26005)(54906003)(316002)(36756003)(186003)(82310400005)(40460700003)(36860700001)(81166007)(4326008)(2906002)(5660300002)(82960400001)(53546011)(7696005)(86362001)(108616005)(508600001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:46:56.2021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d83ada2-2c3e-47be-bd41-08da31901756
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5944

Hi Marcel,

sorry for the late reply.

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Wednesday, April 27, 2022 2:46 PM
> To: Dembianny, Sven (GDE-EDSO) <Sven.Dembianny@bshg.com>
> Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>;
> connman@lists.linux.dev
> Subject: Re: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
>=20
> Hi Sven,
>=20
> >>>> Previous MFP support was restricted to WPA3, however it is also
> >>>> possible to set MFP to mandatory on APs with WPA2.
> >>>>
> >>>> wpa_supplicant config:
> >>>>
> >>>> * WPA2-Personal: key_mgmt=3D"WPA-PSK-SHA256" ; iee80211w=3D1
> >>>>
> >>>> Signed-off-by: Sven Dembianny <sven.dembianny@bshg.com>
> >>>> ---
> >>>> gsupplicant/supplicant.c | 4 ++++
> >>>> 1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> >>>> index 1b92ec44..e9152632 100644
> >>>> --- a/gsupplicant/supplicant.c
> >>>> +++ b/gsupplicant/supplicant.c
> >>>> @@ -4969,6 +4969,10 @@ static void
> >> add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
> >>>> 				ieee80211w =3D G_SUPPLICANT_MFP_REQUIRED;
> >>>> 			}
> >>>> 			add_network_ieee80211w(dict, ssid, ieee80211w);
> >>>> +		} else if (ssid->keymgmt &
> >> G_SUPPLICANT_KEYMGMT_WPA_PSK_256) {
> >>>> +			key_mgmt =3D "WPA-PSK-SHA256";
> >>>> +			ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
> >>>> +			add_network_ieee80211w(dict, ssid, ieee80211w);
> >>>> 		} else {
> >>>> 			key_mgmt =3D "WPA-PSK";
> >>>
> >>> Shall we also consider the "WPA-PSK" case in the same way?
> >
> > As to my understanding, MFP requires SHA256.
> >
> >>
> >> I prefer we remove wpa_supplicant support from ConnMan and you start
> >> using iwd ;)
> >>
> >> And I am only half joking since this part of wpa_supplicant is such a =
mess.
> >> Whatever key management they introduce next will turn into your next
> >> problem and compatibility issues. I am running independent SSIDs in
> >> my home network to deal with end consumer device since they use a
> >> wpa_supplicant and management software that is too dumb.
> >>
> >> With iwd the WiFi protocol is in one daemon and not split between two
> >> daemons.
> >
> > Unfortunately in our case we are tied to wpa_supplicant because of chip
> vendor specifications.
>=20
> that is horrible. What is missing in nl80211 that you need wpa_supplicant=
? I am
> really curious about that.

You can find the patches on wpa_supplicant from chip vendor in cypress-host=
ap_2_9-1-2022_0321.tar.gz, included in driver package:

https://community.infineon.com/gfawx74859/attachments/gfawx74859/WiFiBlueto=
othLinux/2314/4/cypress-fmac-v5.10.9-2022_0331.zip

No idea, if Wi-Fi chip will also work with iwd without adaptions.

Best regards, Sven
