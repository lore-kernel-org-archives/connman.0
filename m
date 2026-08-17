Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3603AEF3B
	for <connman@lists.linux.dev>; Mon, 17 Aug 2026 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947478; cv=fail; b=OKHu/z580eZx9qwdRISS6KgnStmIodihyU+BSxIc3Djjij53XbUSyc0XVUKNirLQPCGn0MhFAEwhQNf+0RelsP+6VLNm5awFaJIryv2yQwIx4mz72AVNdFzYD8FJB9V34ntHfHn5j6fuYGE+cc+tIexv6gw7Xz/4MiE59g2/JUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947478; c=relaxed/simple;
	bh=ccs+iOnnG6/Q/lc5BMcDHCQxdfGysIsrjUtebHccH4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+1QN4OXVHu5n88f0lgKtrnPOC5ht3HdSg124AiqRPZeYRb/JFMGqksmRWs55KZ0Zt1jm+grY5TH9A3x0V9BTSKxGkXhthTWEjCp2vpftRrJ7VC6QGwhHwF3Aj5vp0GVjDqR17jlyER87NvMfXPuCcq0SBVNUP1WZbw+JTnOOlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=2Oiu6PKR; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="2Oiu6PKR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtfqS389ghwLNgSBqqVay2nnnuK4es31YHuKq7+fBjjUbNG8N4sdK2FEzqa6NBGp+O6RQAmGjYcKoxusnabJXjLd9u5sJY0LDc+lMu4DxeATk7BB948jlf5F0UagPcIb8d68hvKqwAxBIeZ7QhYQIN9sFEXFanJevHMppSuaF1pqdS7Y0Om6qRSzWBxv9LFNMkCg+DpwnlcQbUFcRgjQmtq8K+XH4X2YDQ1HMjDv9kXBhCa3A9tE7pTZoTZdg6rCo/JpiBmdygInBrbzo8cIBCOBNNIqDUUl1O+UQu+HVOAdEV+3WVgF5I94q2Re3sOnxmFOLxZ5eEY/Ua74qSHIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uQfrwU8egMvui8c1mRiG67hJoioYqkegRBW3LUKSKg=;
 b=PGXv+LEp05UxktoJmTUr8r0TgYwA3WL6ImCWQrQXC8VWTqeCqIB9o4VmHJolVV9l/4RTxSTrJ7gJcVj5ESyN7WGGp4cwWq4zsOx/G/F7qNmvQU4Gdk46UeTMxhDEWYmvaCypj91+G9Y29eI8g8CF1htfG4CrI9IeGnjQbq63wzAnwNJ01G1rXYha+2tgziAelecctq5w3W7n9l6mja1iw4FzHDaQ0Z533Pwv6pEGHp97LTwiC/O8UirIDEtr4kNWtArB3CnS8rPKQrKd983iEao26UmT3qS2qIgZgLWSmd7I+rTuoPq6mQxMZkz2wmMdRrFAMK49oPwP+tT6lKII3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uQfrwU8egMvui8c1mRiG67hJoioYqkegRBW3LUKSKg=;
 b=2Oiu6PKRd87hKODh5BjSqBe7xSZVdV+QFgmtu33Y6OXq4EvoA+I7BYlUjXIczihcwym18aMPfUXDZu1nQVdbzHxE3x3ml2arhEqv0fxghH2fRa1+KKs3xh2nkbeZ3V/7rrv6KhK/jZXsG7rBO/YdOt+IKNJXpmk6eZAY4xxlMCkgAmbMvhB2tYzaLyDWK/StGKRDCZChc9s1I+UbGSCT6Wh0NODfVTFdGpCY5sCScq7zY5VzrPfF5DV/mSs0wvnDLNZuq2BFjjWilkZEDWNBHkau05AfHcmVpbIzRx+aGvBeld/sWi9tyM0A7+1PsYwBDdDP2u+OnVpRYxARp+EIPQ==
Received: from VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::13)
 by PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:17:50 +0000
Received: from VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c595:d36a:295f:156d]) by VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c595:d36a:295f:156d%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:17:50 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
To: Waldemar Brodkorb <wbx@openadk.org>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	=?iso-8859-1?Q?Fran=E7ois_Galea?= <fgalea@free.fr>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: Connection to a WPA2 Wi-Fi router fails
Thread-Topic: Connection to a WPA2 Wi-Fi router fails
Thread-Index:
 AQHc4e+1v6y0J6G1nEqVaCo5rDvA+rYKIKiAgAnZqhCAgdX8gIABh6owgAJSPICAAnUskIADFvwAgAMlORA=
Date: Mon, 17 Aug 2026 06:17:50 +0000
Message-ID:
 <VI0PR10MB89081958F1C9D72759AEEC8DF4A72@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <anghETbH2WzsZIJ9@waldemar-brodkorb.de>
 <VI0PR10MB8908D439894A87FDC9341D6EF4DE2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <antcGRBvImhKFSyu@waldemar-brodkorb.de>
 <VI0PR10MB8908254CA2980FEFA0F4A905F4DB2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <aoADapzQ-roTDzSP@waldemar-brodkorb.de>
In-Reply-To: <aoADapzQ-roTDzSP@waldemar-brodkorb.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR10MB8908:EE_|PAVPR10MB7355:EE_
x-ms-office365-filtering-correlation-id: c07bebb7-1618-4123-7040-08defc2743bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|10067099003|56012099006|4133799003|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003|38070700021|15866825006|41080700001;
x-microsoft-antispam-message-info:
 p0N+/Dzt/yzcRXmhGaWHzSr7i3mNbSbYxo4JjHaiP5DlrFoSG+xgflxQmljFLpIBH4tbDmMPv6Qv+yZ9jz8K2fjchjy+PS91/NcHFP8mZbdIZXG7VSrjcfX4xdP+ydpUZ33MrhOemY0/zbw9K+yiN4AX+c34xjggCrPlb951Q/LniqokCQSFM8U/A3znGxtsertt6mbwPBOiuKN6Ny9jaRtTIIjL3m/0324m2/4wPjJiXWXZZttFT5pliulqBszgzGiT+VhJRg/nLS7Uj2HpHhnusuBQGRSHmZLuTNhB8OrifmM3Xl6cYptyjB2v5KQM2zDlCqQZ5Ad3U362kBG3yxdruvlBQy4sjWPeom0ZQMpY0puJrZ9XkjLH7weGeHW4xI6bi/Fm+eTPP01RYSYhqKQ20RjzLltMSj3A99hNJVArjRYCB9wo86bLS6sJemomhkKL3p4sCLDmiRbxLq5W7drGqGN5SLIKcQX0ureRF4+8eNNvn0IYGitdP4GvViUh6W84LY68E4udtmYFtFuZ2l1dXTU4JFInoB7atLvC+cC3CV8cYODo5KcabOj9okEOzFGKkxyXBLIztxV5fvhCIUAl2Z36MJXHtVjOQDwrT+b5T1R6GivHqGWKHjGW/7qdNwGmZ9TKYlOLYi8i8E9d3PPsMQ/seXXQ2UJZmydLRHR2b27TuycGO0JExDlY1fzu4pbRmeBn6IhuG2WgFqoG7ECKWVMHTCbIgAU5ox2o5gxZhMpUsDJiMFrNpx4mNutzJYUd0BEguuL2sFJnGS02NhfmuGzctjczlxHXsuwK/iE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(10067099003)(56012099006)(4133799003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021)(15866825006)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HfGY2B0oAqOFDD9Vi3Isw09qk0pB2DZNUZ/CtAvwyCiP2xVTWElbu4FkBs?=
 =?iso-8859-1?Q?uzrenSGIj/tVGasBXrUwIR4r3yKjOAGaicJEfzrjnXUzbeqI3CgElV4lfr?=
 =?iso-8859-1?Q?ABQ9yDua9YaJONB96R5ZE6yV6Pg6OyZQAjk6EXgF1zvi4cXm5C7fqa2EFx?=
 =?iso-8859-1?Q?1Pyg+lvlkInO4W0ZkzPieZwQqFozIzBtF9x2XQTLyWK0NTzFOOjpMhElzk?=
 =?iso-8859-1?Q?oLQ5wQZ2bVO3jGsD/AwFWtpvLu/aH926xsJDImwa0xbdlA9zM1WYoT5qCa?=
 =?iso-8859-1?Q?CwQsMAs1IgmV4veNEU7kxjE20cMJ50vY+zOA0JGoIm6/lSq2yKysgne/Y/?=
 =?iso-8859-1?Q?y6f2Y58QX6HGSC2ieYmE27i4sbdZ7uMWAoGSPppbOO9+uEmbDUahmh0Fv/?=
 =?iso-8859-1?Q?1+lHDcfhgHWWLj3LSvjzdlsc0j3mV4RNlzw/vyiLxClJtqdcZKLJeGAvVG?=
 =?iso-8859-1?Q?1xftBvqCb/I8PVDWvrTuymq00zizMougOMEkgACTScvLsBCtajumFEaH/J?=
 =?iso-8859-1?Q?kFCJcnW+kvth5LhuG/s6DC05PRcPRWyHcssstnQMqLUBzPB8/TfLLiIvxP?=
 =?iso-8859-1?Q?hCKGqiZYm/qWB/C57DpjdzAN9DBrjwT3fuP02i/GYv9Y3cEWkJA1HXmLnX?=
 =?iso-8859-1?Q?sHFbbbepxcDmoKxlB6LwA3im2VgI/JrWNvdDs/MeHpZEy+2j5ZJAeYhGKj?=
 =?iso-8859-1?Q?QNw+iv7KtV8GSLWrEbwoFgy8YghzqtJqWpaFun5ysb19PKrwYka5GZzRlH?=
 =?iso-8859-1?Q?7RufWGgDVs3DdcCF0BcY02xDKUCC0oM58nNV265EF56ADW7n7IN//KnGp0?=
 =?iso-8859-1?Q?1NYIfJXvHSqrP4YZL+3IcHPFC4raf0XQevL7LiD9Yl+MA1omliE+/Lfn2t?=
 =?iso-8859-1?Q?Kltdc9sQdB7lQkeXY40MJuZzNIfepkv37uAOn6gx3hhBfoQcRfu1QY0n9b?=
 =?iso-8859-1?Q?mABucgGMriQyqo9oMhURk17tUNFUk8HqxtNm+NtgOgdW5V7V+uZG3gkjFg?=
 =?iso-8859-1?Q?kElrWrZCClMZXabhOMAL9GRCuAJDrXzqc2LMNUCjd+IrbiOF64+pvBkSh/?=
 =?iso-8859-1?Q?wsxFer0fn/XQyjisLTokviIS/LhaL99Im1AiOBntff5g7MxxMBarf0R5Bs?=
 =?iso-8859-1?Q?/vBZ8q4J9zFvR/VsFBqotiNmt4eNGZlDaDBM6kB7/pgjE4q7ME88Rvp/oA?=
 =?iso-8859-1?Q?FRQISWNP/2drqnIpYe8nP9h89lZAz8UYrMJN5OUh6Wok5SpukMCN3X4iYL?=
 =?iso-8859-1?Q?Z3L4IOPmHWtLTj7mLgefiNuThUgAE3tpmTI09aBcyO0R4zoYBc54JCYL0Z?=
 =?iso-8859-1?Q?moBDLuSTWV6dTCZlCEepUpgvFoJV3s3V8Iu7aPSu6r5VeZYj8Q80KpdK+O?=
 =?iso-8859-1?Q?Mgv83kvf3HgsYkbXb6ICUqcliu+AONn2GYeDcSaQLSV5Lg6s9TPnZHXd4p?=
 =?iso-8859-1?Q?QK+/caE40086olZ8Lv5OH7wgc6ogbmFI5LXuIa17Qcw+q1Qj3ut+qIR/Nb?=
 =?iso-8859-1?Q?xxQ4fwBxMrCxZfUYu2MvRt1wkFdGMTik4R+3hzImHqvo5APMlmNNkgKcKl?=
 =?iso-8859-1?Q?11KLuMmuByhWQbz/CZKXWL6oPXmtqpLH3C/pClLlKOkyCE5TdnBDBDgVmd?=
 =?iso-8859-1?Q?ryKqbmTpJXdXYtzyM0P3+GSg99Qufg5rDTRLknddGK0vKOZ1VSTE1zXsCC?=
 =?iso-8859-1?Q?vsgiV16Qo+gkfTbL12u8e+LscCcPkkKfdJu2X9ENQpG7sv/aH38qwKzbR8?=
 =?iso-8859-1?Q?oO/+yB4PxAjurNB8HbaMTMrKjiKprY/gafqJYMRu7JLlza?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c07bebb7-1618-4123-7040-08defc2743bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 06:17:50.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JMf5DxmhfkDK9IxjAnL6GhlFQU1xr6vqIJx8lYeWRGEy8d+PzTtv6n8GK9TB+Ofc/r1rCqpHukID8jJFLb+aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7355

Hi Waldemar,

no idea at the moment, but this looks like a different issue, potentially a=
n initialization-related topic.

Best regards,  Sven
> -----Original Message-----
> From: Waldemar Brodkorb <wbx@openadk.org>
> Sent: Samstag, 15. August 2026 08:13
> To: Dembianny Sven (BSH GDE-EDSD7) <sven.dembianny@bshg.com>
> Cc: Waldemar Brodkorb <wbx@openadk.org>; Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com>; Fran=E7ois Galea <fgalea@free.fr>; connma=
n@lists.linux.dev
> Subject: Re: Connection to a WPA2 Wi-Fi router fails
>=20
> Hi Sven,
>=20
> but without even the possibility to scan I am not able to reproduce the i=
nitial bug anymore. Do you
> have an idea why connmanctl scan wifi fails for me?
>=20
> I use Buildroot master (tried arm and aarch64), enable the wifi firmware =
and connman. After booting
> with the SD card I stop connmand /etc/init.d/S45connman stop modprobe brc=
mfmac
> /etc/init.d/S45connman start connmanctl enable wifi connmanctl scan wifi
>=20
> Error /net/connman/technology/wifi: Not supported
>=20
> When I add -d for debug information before I start connmand, I see in the=
 log that wlan0 is recognized:
> Jan  1 00:01:11 buildroot daemon.info connmand[232]: Adding interface eth=
0 [ ethernet ] Jan  1
> 00:01:11 buildroot daemon.debug connmand[232]: src/technology.c:technolog=
y_find() type 2 Jan  1
> 00:01:11 buildroot daemon.debug connmand[232]: src/rtnl.c:rtnl_message() =
NEWLINK len 1476 type
> 16 flags 0x0002 seq 0 pid 232 Jan  1 00:01:11 buildroot daemon.debug conn=
mand[232]:
> src/ipconfig.c:__connman_ipconfig_newlink() index 3 Jan  1 00:01:11 build=
root daemon.info
> connmand[232]: wlan0 {create} index 3 type 1 <ETHER> Jan  1 00:01:11 buil=
droot daemon.info
> connmand[232]: wlan0 {update} flags 4098 <DOWN> Jan  1 00:01:11 buildroot=
 daemon.info
> connmand[232]: wlan0 {newlink} index 3 address E4:5F:01:16:5A:26 mtu 1500=
 Jan  1 00:01:11 buildroot
> daemon.info connmand[232]: wlan0 {newlink} index 3 operstate 2 <DOWN> Jan=
  1 00:01:11 buildroot
> daemon.debug connmand[232]: src/detect.c:detect_newlink() type 1 index 3 =
Jan  1 00:01:11 buildroot
> daemon.debug connmand[232]: src/device.c:connman_device_create() node e45=
f01165a26 type 2 Jan
> 1 00:01:11 buildroot daemon.debug connmand[232]: src/device.c:connman_dev=
ice_create() device
> 0x5599d3a8f0 Jan  1 00:01:11 buildroot daemon.debug connmand[232]:
> src/device.c:connman_device_set_string() device 0x5599d3a8f0 key Address =
value E4:5F:01:16:5A:26
> Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/device.c:connma=
n_device_register()
> device 0x5599d3a8f0 name Wireless Jan  1 00:01:11 buildroot daemon.info c=
onnmand[232]: Adding
> interface wlan0 [ wifi ] Jan  1 00:01:11 buildroot daemon.debug connmand[=
232]:
> src/technology.c:technology_find() type 3
>=20
>=20
> Any idea?
>=20
> best regards
>  Waldemar
>=20
> Dembianny Sven (BSH GDE-EDSD7) wrote,
>=20
> > Hi Waldemar,
> >
> > yes, that seems reasonable. We need additional information to better un=
derstand what is happening.
> > Could you please provide a wpa_supplicant log with debug logging enable=
d?
> >
> > Best regards, Sven
> > > -----Original Message-----
> > > From: Waldemar Brodkorb <wbx@openadk.org>
> > > Sent: Dienstag, 11. August 2026 19:30
> > > To: Dembianny Sven (BSH GDE-EDSD7) <sven.dembianny@bshg.com>
> > > Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>;
> > > Fran=E7ois Galea <fgalea@free.fr>; connman@lists.linux.dev;
> > > wbx@openadk.org
> > > Subject: Re: Connection to a WPA2 Wi-Fi router fails
> > >
> > > Hi Sven,
> > > Dembianny Sven (BSH GDE-EDSD7) wrote,
> > >
> > > > Hi Waldemar,
> > > > >
> > > > > Hi Sven,
> > > > > Dembianny Sven (BSH GDE-EDSD7) wrote,
> > > > >
> > > > > > Hi Michael,
> > > > > >
> > > > > > I don't think so, e.g., if AP does not support SAE but repeater=
 does, roaming will fail.
> > > > > > This will also break certification tests.
> > > > > >
> > > > > > @ Fran=E7ois do you have more info about your setup, e.g. MFP
> > > > > > setting on AP/wpa_supplicant
> > > > > config/WPA-PSK-SHA256 instead of WPA-PSK?
> > > > >
> > > > > Sorry for the late reply. Francois seems not to answered your
> > > > > question and I see no fixes for this problem in GIT master either=
.
> > > > >
> > > > > My AP is a standard Vodafone AP with WPA2.
> > > > > How can I give you better information about the details of this A=
P?
> > > > What model is being used?
> > >
> > > Vodafone Wifi 6.
> > > It is this one:
> > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
w
> > > w.vodafone.de%2Fdownload&data=3D05%7C02%7Csven.dembianny%40bshg.com%7=
C
> > > 28ff4dffa49c488a7b4e08defa9441af%7C0ae51e1907c84e4bbb6d648ee58410f4%
> > > 7C0%7C0%7C639223711836903590%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGk
> > > iOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjo
> > > yfQ%3D%3D%7C0%7C%7C%7C&sdata=3D%2BG4XESNZmUWwrlifdv2Xda4fX8gZbVaDGCKf=
F
> > > 09Bu88%3D&reserved=3D0
> > > area%2FCGA6444VF-DMS3-CTC-25-
> > > 593_v2.0_German_public_20210511.pdf&data=3D05%7C02%7Csven.dembianny%4=
0
> > > bshg.com%7C59663c
> > > 7c2d2d49ac217508def7ce2d13%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C
> > > 0%7C63922066219
> > > 4440574%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAu
> > > MDAwMCIsIlAiOiJ
> > > XaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DycBjQx=
m
> > > EPcxuLgXBXIMrjCg
> > > OsU9mHQ%2B%2B%2B%2BOcVwvkfTg%3D&reserved=3D0
> > >
> > > > It is possible that MFP is additionally configured as optional.
> > > > Could you please check the AP settings
> > > or the beacon frames?
> > >
> > > It seems not.
> > > See:
> > > sudo iw dev wlan0 scan | grep -A20 -B2 'Vodafone-C30C'
> > >       last seen: 84 ms ago
> > >       Information elements from Probe Response frame:
> > >       SSID: Vodafone-C30C
> > >       Supported rates: 1.0* 2.0* 5.5* 11.0* 18.0 24.0 36.0 54.0
> > >       DS Parameter set: channel 11
> > >       Country: DE     Environment: Indoor/Outdoor
> > >               Channels [1 - 13] @ 20 dBm
> > >       TPC report: TX power: 18 dBm
> > >       ERP: Barker_Preamble_Mode
> > >       Extended supported rates: 6.0 9.0 12.0 48.0
> > >       RSN:     * Version: 1
> > >                * Group cipher: CCMP
> > >                * Pairwise ciphers: CCMP
> > >                * Authentication suites: PSK
> > >                * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
> > >       BSS Load:
> > >                * station count: 2
> > >                * channel utilisation: 31/255
> > >                * available admission capacity: 0 [*32us]
> > >       RM enabled capabilities:
> > >               Capabilities: 0x72 0x00 0x00 0x00 0x00
> > >                       Neighbor Report
> > >                       Beacon Passive Measurement
> > > --
> > >       signal: -72.00 dBm
> > >       last seen: 3208 ms ago
> > >       SSID: Vodafone-C30C
> > >       Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0
> > >       TIM: DTIM Count 0 DTIM Period 1 Bitmap Control 0x0 Bitmap[0] 0x=
0
> > >       Country: DE     Environment: Indoor/Outdoor
> > >               Channels [36 - 64] @ 23 dBm
> > >               Channels [100 - 140] @ 30 dBm
> > >       Power constraint: 0 dB
> > >       TPC report: TX power: 23 dBm
> > >       RSN:     * Version: 1
> > >                * Group cipher: CCMP
> > >                * Pairwise ciphers: CCMP
> > >                * Authentication suites: PSK
> > >                * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
> > >       BSS Load:
> > >                * station count: 6
> > >                * channel utilisation: 6/255
> > >                * available admission capacity: 0 [*32us]
> > >       RM enabled capabilities:
> > >               Capabilities: 0x72 0x00 0x00 0x00 0x00
> > >                       Neighbor Report
> > >                       Beacon Passive Measurement
> > >
> > >
> > > > Also, what firmware version is running on the Raspberry Pi 4? The
> > > > firmware files should be located
> > > under:
> > > > /lib/firmware/
> > >
> > > That is the dmesg output after loading the Wifi driver in Buildroot:
> > > [  249.369934] brcmfmac: F1 signature read @0x18000000=3D0x15264345 [=
  249.373427] brcmfmac:
> > > brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM434=
5/6 [  249.382449]
> usbcore:
> > > registered new interface driver brcmfmac [  249.618723] brcmfmac:
> > > brcmf_c_process_txcap_blob: no txcap_blob available (err=3D-2) [
> > > 249.626771] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> > > wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
> > > 01-b677b91b
> > >
> > > But at the moment I am fighting with connmanctl, it seems I cannot sc=
an wifi anymore:
> > > # connmanctl scan wifi
> > > Error /net/connman/technology/wifi: Not supported # connmanctl
> > > enable wifi wifi is already enabled # connmanctl scan wifi Error
> > > /net/connman/technology/wifi: Not supported # connmanctl technologies
> /net/connman/technology/ethernet
> > >   Name =3D Wired
> > >   Type =3D ethernet
> > >   Powered =3D True
> > >   Connected =3D False
> > >   Tethering =3D False
> > >   TetheringFreq =3D 2412
> > > /net/connman/technology/wifi
> > >   Name =3D WiFi
> > >   Type =3D wifi
> > >   Powered =3D True
> > >   Connected =3D False
> > >   Tethering =3D False
> > >   TetheringFreq =3D 2412
> > >
> > > I can scan wifi with iw on the RPI4.
> > >
> > > best regards
> > >  Waldemar
> > >
> >
