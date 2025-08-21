Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54AD2F4A
	for <connman@lists.linux.dev>; Thu, 21 Aug 2025 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763323; cv=fail; b=ni1fyKYK/hImi8WmPz5hgxZLKVWoENKS2Mdku1FaVme5k2UWe5oNsB4LRWEV/5uL4PItg+KXGU7GufdVG0zjbyY9nRmvAVXngZVyhF1Qdkt/6PD1nrwITDclgl0GK4SPVg/LfXnSJQCnmcGxeMbw/fd0DrsePDuLNBi6dT75TUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763323; c=relaxed/simple;
	bh=waCyHIHONqpzI7FKsfnsSELhQaQ19Oc3AuluCcloX/Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BmcAh8HjGYvvAS8Yhg+5sc98YGvfV1l377goFdSCByVE5ewGpQZm6yTcDThh0NgpN8BAksp+iDrRsoUWvUG7aR7d39mgUXyyFaRFZqgaxDd4yI3AhXXeaIWhbegYiFRScczKYykr8MpnHufQkc41Xn/iM8F5024/pQsENAd0B7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=MAVAdrvk; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="MAVAdrvk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuWGfZ/VKv4XAchof9pCpW+1Oz2KxFmXSL7lK0RW4HKUyxn9iwWDLJlBqlDfO7Ck8zi638g3OMKaBsJFUD2C4CWna+uUDQ1oTODdBZdGf9dG30iakIR3YgaBrmemp1PdOdLa5fnJpOznp2+w1jhyn1Uzi+izuhu+xDbigSuN93X3AyLhI7vrt+b7vs5WSUDf+3MIsQ78HgzT969+CF39goDUK0ZmI16oZT2CjZv09HqEqrwyTrGXuvtUi6CzxdhSYoKCNl8Pz4az08XIYkfQnb/c1Rz4Di3llHwQjHurObR3H9ru5EuuVtWc++TDRTqFGrIvuD5cYFZms4Dd4J72tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waCyHIHONqpzI7FKsfnsSELhQaQ19Oc3AuluCcloX/Y=;
 b=iU6DUcS+gEW4eEaoolzdm5FNw5g/nlcgkuW5qDKO7Q7woithsg+SRzA46B1Hutv2lKRX05r8oj2xQGh+0cFneyjXvJ9p8nswV7nliQaSjldfEyLBpyInSATt4wbJ8mR/VaYd+wgB1ZHgDW+1x5lgAfssmtzT3flaIqSuSJwWBusC8OIFgttPqYYpTYXfzMJd/tRxnz+ythoU/cvpom/CrW+KG6DJJRRSM5RvmQDKZLy+Eh3fZM7ZfKOev4LZKC6iVnb/ovUBa3+QDoD9BLBIIM0G+yiI3kahK7tYNG16eBRce0KFOaT+zgBGQYUa5pDq2F/n57okDIs0Je8f3r+aeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waCyHIHONqpzI7FKsfnsSELhQaQ19Oc3AuluCcloX/Y=;
 b=MAVAdrvk/agim2l+shX95w0DBHDI5jaKPoCvQGALPO6xPcYfdNsfv3LZmfqTiE5sXam7rUeKVuQ6zfLSn0C/OE2yqAhwDIRYl2x0Oiv2UyYeQVzxuLO3il9vT24gt4eJKxEJ5bdeEmdOTiHo+ggOqqEA/ZwqmEsBcXUKnha6wFM9P70EZ213gB3k3mYm5w8h7aP79fcHty2Bc3cen15FgVQEj+XNk9nvSqGhIapNqBanP81dSNg97zamSOdlvHH25xPAyZfCOSvzsoiJwdH1NHlssef6J927q/gwGbRK37JJo9EPwBNLnmqt6raSi3PV7a9UTgcCaysIgvq/BqrwRw==
Received: from AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1b::23)
 by AS4PR10MB5989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 08:01:56 +0000
Received: from AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cad1:dee5:5e34:33a5]) by AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cad1:dee5:5e34:33a5%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 08:01:56 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
To: "hugo.portisch@yahoo.de" <hugo.portisch@yahoo.de>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: AW: AW: AW: v1.45, broken wifi connect
Thread-Topic: AW: AW: v1.45, broken wifi connect
Thread-Index: AQHcCDoLcbNVKf7saEulAds0rK8QjbRraU8ggAAwvICAAAU2EIABGXwAgAAW/cA=
Date: Thu, 21 Aug 2025 08:01:56 +0000
Message-ID:
 <AM5PR10MB1682BF72395A55D04F486CA8F432A@AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM>
References: <1082538859.4574595.1754637525886.ref@mail.yahoo.com>
 <1082538859.4574595.1754637525886@mail.yahoo.com>
 <211116062.4586180.1754639815460@mail.yahoo.com>
 <HE1PR10MB1690517074A095230DD71470F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
 <511456109.2450472.1755696051598@mail.yahoo.com>
 <HE1PR10MB1690B9444B6197D17AB086A9F433A@HE1PR10MB1690.EURPRD10.PROD.OUTLOOK.COM>
 <1972372971.2755960.1755757618469@mail.yahoo.com>
In-Reply-To: <1972372971.2755960.1755757618469@mail.yahoo.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR10MB1682:EE_|AS4PR10MB5989:EE_
x-ms-office365-filtering-correlation-id: 9fc69c0a-c2cc-4643-53ba-08dde088ffd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|7053199007|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/cAwpYtFYTrlz4PDlAgjgeBqDKEvv+z+b6KPWO4sBCPca3MmPrvwolsRrD?=
 =?iso-8859-1?Q?NwJ+V4zzW4gOjraO07Bvwr4J/6Kq9TrSkjw3GbOYXxIGJGy8YDIOnYPAiV?=
 =?iso-8859-1?Q?otNBLJw/j2Vjzdy+Ea/h8bubq/wCiCUuFTK+OI/rr10cg6Ev5FCE/Yuame?=
 =?iso-8859-1?Q?CW3Q2G0OV6DagfB4OOV4mVVbGYc2I8yXkznkPZQTe7Q7l7yQFK9hhOzDXa?=
 =?iso-8859-1?Q?a8jtFvuYoerD0A9KG+9AaCkhn0fRViK33WsbAXvakK5a3IjDRpLQmYXVYa?=
 =?iso-8859-1?Q?GYyzLlQvlxBar4ySO6csNvUSJQuOXNCyTdRaWbb8I9JTQTedYSdj5BCePl?=
 =?iso-8859-1?Q?DO0cKYDiBvUX3U0eH2kSs4J+0ildolk+gGGJbFCudx3TyEnVK3QxUXDKb4?=
 =?iso-8859-1?Q?r+DvNOMHtvvghwDTpW5TZ7MdAQ114LEbZLTfpJKM8JVIobd25ZywztIICD?=
 =?iso-8859-1?Q?kWxYAb68cWqH3ywikkkup2NUtbUJ6IbI/2SMR5soarnmbdwoqUl/BYtNre?=
 =?iso-8859-1?Q?rxl/fSMLaM3/S6sW7l7+3LYQ8yUlio18MNfd8gg0BDI9VYU93c+nmmIPa6?=
 =?iso-8859-1?Q?cmQwFro44qlSCzGtvD0j1w3o6WRhB4yfM5PeRkfX0iIevq4GOlkCIOzrlM?=
 =?iso-8859-1?Q?A/yvy0+B5tUdDs98RvSZ7mQpNmimis5QJ6XR6rVff69w4LxQy6FULBPtTv?=
 =?iso-8859-1?Q?tJo1puUTQbFFvCPsZwsLoKtu0l7U43TjNVUFZGhoFSM1chHPPDGKtYd0+N?=
 =?iso-8859-1?Q?II8Kzb9qz/xlJaiZU5HydLDCYYqyDlmscwMnp//TR66x6PO2noAtpfXPVy?=
 =?iso-8859-1?Q?+27saMZH+1HvaplAtI2eu5YpNizX58AYYpzkiGRVU8uuczKSqtz98T7kx0?=
 =?iso-8859-1?Q?w60OlVVLslyb3zf1qxmlda/Sn58uLbTwrMdKIucG285WM8M8BCRFbDpPMj?=
 =?iso-8859-1?Q?eo7VSOeeUyQE0Lvji6mWG3vbOCUWEw16F5y4I2x1QEEnoMgNhI3e7RCzQM?=
 =?iso-8859-1?Q?bsD1YAnQdm9Bl/GU3Y9tHNswLWv3g34ecVnd6N2g+7dOhYXl6qzFPux1Uc?=
 =?iso-8859-1?Q?4IBMEKB2gIBy61hNQg/3LaDjfYBPgtgdy5fTuQAcMhrxtSZ/1M3tGomz8A?=
 =?iso-8859-1?Q?6F+T5/eLjc/oyGrCAkVJU6O33gOhp4BQHobeEcY4Y7f3cVUkKskZbQLFWj?=
 =?iso-8859-1?Q?FIWMi+aoSJc6IlHRjQZoZL6JxwgpbjiKEY3wBxOY9ad+4McXnYKMuPuaHd?=
 =?iso-8859-1?Q?nGWMsEtDyKp14HDEgnKcfZhjC2H6KDPeh2ZYsYrXnSYEAg8ReC+bzvutyt?=
 =?iso-8859-1?Q?5u6hr2kFrYwedKCXqk74Y86dwC5Pd/DJzyKVHeDYaf7L40Q5TSQsV/Pbp5?=
 =?iso-8859-1?Q?NYjVac2aaSS4f41PgVxBGhfEFqp+LKqT0AK8/OqEnnb2mr6gEZRZP+L8ag?=
 =?iso-8859-1?Q?YWDBcOvxJ+sQEPBOKamhTv+/LXN2Gio5lpmFNPQRwGi63zPVcZpIajxini?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR10MB1682.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7053199007)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BC+EgURLm3ZdqK/YHrG3cP47fvuuXw7Q8meM4CKATsr2eAe+372wP5glwO?=
 =?iso-8859-1?Q?Gwx/nOgL01nFkVG8w0ue1Up67cDRByvGng82iJvYtNkMA3WvOElEFF0Rvl?=
 =?iso-8859-1?Q?Qkozv2C3uukmpUoOE2hOyZWd2z+ujOGBJ2Sn5uoNEPoPiSdjHYDJqsiPV7?=
 =?iso-8859-1?Q?1cO47dghnv5DvfA79r6PX1REGojMpYB1aKAXk9s1c3sX0vaxnmD0SklQ0n?=
 =?iso-8859-1?Q?XTR+Ap1JnJ1RbGqAtG+qZQ76uhR9Gk54yVGei1/ze1TP7vJ/SJ9Jz167bw?=
 =?iso-8859-1?Q?5gEEbHASOOYDQIjeiB32GTPsbwqiqnYr6g1eLca9DHk++7ekTq5CoxG2IC?=
 =?iso-8859-1?Q?JJ99SkW7CMkpypyso1viTSDOy/APEWXqkOvzwzYQ1/z2+YEHaTSliYercx?=
 =?iso-8859-1?Q?hzYC0Y14JPe1byFOp9BCLdqipNXHjzXfi11W0cQLR+oF2/k5+sEmeAbN/O?=
 =?iso-8859-1?Q?RrMss/ae6QMy2Mf8cC5RDTVMmmc7CxMhhtQxaXAngaYEKwCO2L0gW3arNn?=
 =?iso-8859-1?Q?N8SbhYfsNkC3eA+5cBItXUazndK0Z6htiduVAYpuvkjSYDpKyc8BP8JdT9?=
 =?iso-8859-1?Q?MsFP4re37a0cMYiutx1wcRt2XPSHQL9jydmJfnkVWEs/9bwyGZApJ9zrnm?=
 =?iso-8859-1?Q?cW5XYmRc2kQewxi5uQAA3WJ2l53rlfNPTop7CahxYK/5GPcKLjhvmaye9E?=
 =?iso-8859-1?Q?nQns4pRPzazzwCidC0Thojw9ZpV30sz4D0BbUIvh5e7QAnIKZhYse8MObn?=
 =?iso-8859-1?Q?aVBEcG9ZsIwBpUurqNkmyv3ZKzlJlyCB8X3flvTggEbUQ3wX0fZcQHr3KQ?=
 =?iso-8859-1?Q?5JtFNxM4ohM3+KOrhh17V/E26q1L5k+y7tlq5OeXdgsoj7+JF2w92JIroO?=
 =?iso-8859-1?Q?gYtWNNp/lWYs/len5eIftgxArMAtFP7DAYQ0kaE0QeJeper2sTqvCDwpMd?=
 =?iso-8859-1?Q?jXrsfC5btfH+Fzfz8RO02WdV8fHG3PdCXMOzGjIhw18L+oB6E9miqv89DN?=
 =?iso-8859-1?Q?038A0nw/omszLbzPXYCg9cA4bDW4HvOyx02OhWN7M7kfr0SPHo+LD+azdm?=
 =?iso-8859-1?Q?lhtC+QZPPE/rhBu3g8Bw8IjnZy65x74MP2e+pyCYtjz7/h28wHtaDNkaWf?=
 =?iso-8859-1?Q?UY7vaBXLCQljfQvjTizileRnjuGOGweDoW34MBhURkXwxpxe7XDaYMduBQ?=
 =?iso-8859-1?Q?YFvX/RojJheKZJv9pTl58MIW3PQWzoLezwHpPHVZ+FNTqGMrh9+uW/Ioo3?=
 =?iso-8859-1?Q?G8GIVGplBplGwI8sxmej84dUZv6EWAVKSsXs31t/tNETnCpRwLMTXNiWMr?=
 =?iso-8859-1?Q?3uEKbIGvyyPKycCYBaBh+auCq31lrspqG3CeaXRylv7CiK6F4rVAEvC4I/?=
 =?iso-8859-1?Q?sRRoPapwTPjxZ7tyGwYTTA61ctPeflr9jwX2xiYO3cAYgiiadzZElZ1mio?=
 =?iso-8859-1?Q?a5L5jJ5UDksmyDisTffG6IQvYUC/JdamyeEeJ8a7pSVOhBqX/68KQfUMAt?=
 =?iso-8859-1?Q?VxPmwqqClJztoNVOkX5gTjFJkUc7Y23t/tlyPO5x/nmKfWwS1UVd00mttx?=
 =?iso-8859-1?Q?7VXXt7W+8xDjG4mv7MiBKHm477G4QrsoFLX4samlUZi5MayptcHcwf8waJ?=
 =?iso-8859-1?Q?9CzkT2SSygI5E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc69c0a-c2cc-4643-53ba-08dde088ffd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 08:01:56.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5jdX4Gv1Bw/MbYl5NL9haA3fdFRQVliD7irbIxYfucVmQCGOEkK68yNqffdK8o2sGMsyly6T91QfWyHsQfOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5989

That's good news.

> -----Urspr=FCngliche Nachricht-----
> Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> Gesendet: Donnerstag, 21. August 2025 08:27
> An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7) <sven.dembian=
ny@bshg.com>
> Betreff: Re: AW: AW: v1.45, broken wifi connect
>
> Thx,
>
> indeed, this do solve the issue:
> https://github.com/CoreELEC/Core
> ELEC%2Fcommit%2Fa8f96d2c4a97bd2afdd49c5aac6d14cd6efb8494&data=3D05%7C02%7=
Csven.dembianny
> %40bshg.com%7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4bbb6d648e=
e58410f4%7C
> 0%7C0%7C638913544287997489%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydW=
UsIlYiOiI
> wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7=
C&sdata=3DGAlOx
> 3ugq0WWVUMwUXE%2F1AqZelOQvRd8FndGqYwiMfM%3D&reserved=3D0
> Maybe connman should be include a switch if this option is enabled or not=
?
No idea, CONFIG_SAE is activated per default by hostap, if mainline defconf=
ig is used, or a self-maintained
one is updated with wpa_supplicant updates there should be no issue:

https://w1.fi/cgit/hostap/tree/wpa_supplicant/defconfig#n258

Best regards, Sven
>
> I tried also to replace wpa_supplicant by iwd like LibreELEC was doing in=
 past.
> But the results are like the Wifi networks are not visible at all anymore=
.
> If visible connection is not possible.
>
> So we will stay with wpa_supplicant.
>
> Thanks for your help!
> Ticket can then be closed now I think.
>
> Portisch
>
>
>
>
>
>
> Am Mittwoch, 20. August 2025 um 15:44:38 MESZ hat Dembianny Sven (BSH GDE=
-EDSD7)
> <sven.dembianny@bshg.com> Folgendes geschrieben:
>
>
>
>
>
> Hi Portisch,
>
> maybe adding WPA3 support for wpa_supplicant can help us.
> Can you give it a try and add
>
> CONFIG_SAE=3Dy
>
> in
>
> https://github.com/CoreELEC/Core
> ELEC%2Fblob%2Fcoreelec-
> 22%2Fpackages%2Fnetwork%2Fwpa_supplicant%2Fconfig%2Fmakefile.config&data=
=3D05%7C02%7Csven.d
> embianny%40bshg.com%7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4b=
bb6d648ee58
> 410f4%7C0%7C0%7C638913544288023231%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG=
kiOnRyd
> WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7=
C0%7C%7C%7C&sd
> ata=3DHSQurgEaI8o%2Fvx5D5IoEQylng796X1TcA181TV9qf3A%3D&reserved=3D0
>
> Best regards, Sven
>
> > -----Urspr=FCngliche Nachricht-----
> > Von: hugo.portisch@yahoo.de <hugo.portisch@yahoo.de>
> > Gesendet: Mittwoch, 20. August 2025 15:21
> > An: connman@lists.linux.dev; Dembianny Sven (BSH GDE-EDSD7)
> > <sven.dembianny@bshg.com>
> > Betreff: Re: AW: v1.45, broken wifi connect
> >
> > Hi,
> >
> > server is OpenWRT with: SSID: CI-0030156, Encryption: mixed WPA2/WPA3
> > PSK, SAE (CCMP) Client Khadas VIM3: AP6398S
> >
> > Same behavior with X96 M300, RTL8822CS, vid: 0x024C, pid: 0xC822
> >
> > With commit included:
> > --------------------------------------
> > VIM3:~ # connmanctl
> > connmanctl> services
> > *AO Wired ethernet_0200001e1f01_cable
> > *A CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Error
> > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_ps
> > k: Not registered
> > connmanctl> state
> > State =3D online
> > OfflineMode =3D False
> > SessionMode =3D False
> > connmanctl> disconnect
> > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Error
> > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_ps
> > k: Not connected
> > --------------------------------------
> >
> > With commit reverted:
> > --------------------------------------
> > VIM3:~ # connmanctl
> > connmanctl> services
> > *AO Wired ethernet_0200001e1f01_cable
> > *AR CI-0030156 wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Error
> > /net/connman/service/wifi_6c21a29b2882_43492d30303330313536_managed_ps
> > k: Already connected
> > connmanctl> disconnect
> > connmanctl> wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Disconnected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > connmanctl> connect wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > Connected wifi_6c21a29b2882_43492d30303330313536_managed_psk
> > connmanctl> state
> > State =3D online
> > OfflineMode =3D False
> > SessionMode =3D False
> > --------------------------------------
> >
> > Wifi is working again.
> > We got multiple reports from users haveing same issue:
> > https://disc/
> > ourse.coreelec.org%2Ft%2Famlo&data=3D05%7C02%7Csven.dembianny%40bshg.co=
m
> > %7C4da5633dff8a4053421a08dde07bc07e%7C0ae51e1907c84e4bbb6d648ee58410f4
> > %7C0%7C0%7C638913544288040178%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGki
> > OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ
> > %3D%3D%7C0%7C%7C%7C&sdata=3Dm%2BtmZYRdI8bMJxhT2%2FU3j5XvwmBZfjqsnZ%2BfO=
K
> > gIeb0%3D&reserved=3D0
> > gic-no-
> > discussion%2F46663%2F2296&data=3D05%7C02%7Csven.dembianny%40bshg.com%7C=
3
> > cce9ee05e2049040
> > 15108dddfec6794%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638912928
> > 619230523%7CUn
> > known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOi
> > JXaW4zMiIsIkFOIjoi
> > TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DEjK%2FrOlN1nhCNVmlmxzbpeY=
w
> > cyRt6tqLJt9VS0y
> > uJpc%3D&reserved=3D0
> > Then we reverted this commit and all is good again.
> >
> > Thank you very much!
> > Portisch
> >
> >
> >
> >
> > Am Mittwoch, 20. August 2025 um 13:33:40 MESZ hat Dembianny Sven (BSH
> > GDE-EDSD7) <sven.dembianny@bshg.com> Folgendes geschrieben:
> >
> >
> >
> >
> >
> > Hi Portisch,
> > >
> > > Hi,
> > >
> > > current connman is broken and can not connect to encrypted networks.
> > >
> > do you have more info about your setup?
> >
> > We can't reproduce the issue with 43455 chip.
> > Which chip do you use, is it WPA3 capable?
> >
> > What AKM is configured on your AP?
> > Which wpa_supplicant version?
> > Is SAE activated for wpa_supplicant?
> > >
> > > Revert of this commit do solve the issue.
> > >
> > > Error log:
> > > connmanctl> connect
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > connmanctl> Error
> > > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d30303330313
> > > connmanctl> 53
> > > connmanctl> 6_
> > > connmanctl> managed_psk: Input/output error disconnect
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk Error
> > > connmanctl> /net/connman/service/wifi_485c2cd4ca36_43492d30303330313
> > > connmanctl> 53
> > > connmanctl> 6_
> > > connmanctl> managed_psk: Not connected
> > >
> > >
> > > With 1.44 there is no such error:
> > > connmanctl> disconnect
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > connmanctl> Disconnected
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > connmanctl> connmanctl> connect
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> > > connmanctl> Connected
>
> > > connmanctl> wifi_485c2cd4ca36_43492d30303330313536_managed_psk
> >
> > >
> > > Thanks,
> > > Portisch
> > > Team CoreELEC
> >
> > >
> > Best regards, Sven

