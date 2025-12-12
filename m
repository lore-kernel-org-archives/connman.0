Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027821AAE17
	for <connman@lists.linux.dev>; Fri, 12 Dec 2025 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521473; cv=fail; b=WroyIdu9oLkH5VcO9GrdGvDI97mZXkWD/t/x6uRtuy2HOf1CGyKMgcG6UUrWUYzlSZP77PTksajWFmKBtj+lp5YWv+RNO/nxaze67Jl+dk+OJ5VTjXArwzoZpDUkdKbmebIRAWab3FTCPYMeP9oMr8whteEfbHuS89fiQdkiEtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521473; c=relaxed/simple;
	bh=eIaa48qzy6TvoimRbtHKZaREYWLP4p6XQbM9ilNqoU4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N4C58jQUENSJPZ1f1NKwfzdD64qfMxUaND/rdgTiZeBNS9B9d7FBXx9ldpX3OR7XiG2+JNuny7v84RMy5O/FRJw3QAd75k81ZAYJrYhSI7FWhbFQua0JU1pbajUTKpHUYf/VPVXFDRvSTH7/is5Plp6F6x6n8QDGkkwbwjBAsOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=0KaNAdP6; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="0KaNAdP6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brXclmdjtPEZkuc0gmoSA2bCiqIMJHIUEqu5RErXKvlPHUpWrNHGPTn5eHQdic1ncQOo9PLJYKbpf0DanFblce4tzxqoXCfoZNgu/+RKwyl3p1CRtVl0dEjTdHvrx0qa02eLvzjcrWlkcdvlXX8/06+DbOa3rWLfcaOyyJN7+lwxF7Xw1CwiCNmx/gcJNXQqsZ7bi8bikM37yh0YDGEjwJ+hcbZ6YDJFctGyAd0fEMKir7V0l2AGdaKtUqRaJkcLmp6hOvZ+JFbJrIgAnmB5hPY5bIy1S/C7ZGL9ex/xW8Y3JQqYqObB1iAIXr8XepJ9GQ3/1E++gYfSfh8MZsitZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3tLHngXnT6pSGPr8yuv5gHyIwnQ1RTOVpD49O/AAMk=;
 b=lfm9ctEQ8yAj4+kFvpkqbR+VbvvHynC5kqV/Hq9pdkEyFrRqvBLoFRZZgLtHMI7Sxn9ehYRxGtuKoDIu9YVkrJ7f2gzwMtyj/vnSxshTDXPrgs3s16Hb2yHn8cXipwsr1UhXLH97c/2pv1jcgpA8oNXLU0HbWkszx2CS9h2T0uL75D7PXzBor5/GBcL5IHqgQcB/JvwUaCwWmTA3Qgi7X1veF/angDy/g/3UJd423SFaSYOMeOZVc6pBl7koSQrqwm7hQD3qfkpUlrJ15hJFOscNe/O6xKpZLTmnDyBWjNhPIMy2UbgLoEU8K+0Fuxvw4ZGDqbbNLHZpG56+OjG4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3tLHngXnT6pSGPr8yuv5gHyIwnQ1RTOVpD49O/AAMk=;
 b=0KaNAdP6k6wM0OdqlDUJaLqhL8Y1ErxftO+QV56T34LpMrOKeUUUvAMU7HRPc1tR3o5FP3vLwBG4TWvzNJQkViUhSNo4xNrZ51L311R/Y0mUv4cMA6KPqcogMIL7C2tJN0PPyqZYiuO+DO8ev3J1MJuYpHT9roX9m6ogbzPpN/x6g0xkMZl3PVbKeI+wpbuJ7BtGGf5PQMSI3cKNW2PyfLfjhGzqG9/xC2OIYxKBrU8rOQEtAubRSt+lR5jozh+kmtx7LTqvQb0BaYnJhtCmdtMR4wGTlM7fo9ShuwRyEMLQ0UBbOdCR1cC2mqg/V7gl4cCCeAlbd0OSH9iVQ8SY7g==
Received: from PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:299::18)
 by PAVPR10MB7137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:315::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 12 Dec
 2025 06:37:48 +0000
Received: from PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5edc:fb04:e4ab:bde3]) by PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5edc:fb04:e4ab:bde3%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 06:37:48 +0000
From: "Chen Yaming (BSH GDE-EDSCD)" <Yaming.Chen@bshg.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: Fix the crash issue when restarting the wpa_supplicant or wifi
 driver while BackgroundScanning is enable
Thread-Topic: Fix the crash issue when restarting the wpa_supplicant or wifi
 driver while BackgroundScanning is enable
Thread-Index: AdxrLUUsPoDeAB9qTIOEHDIxJ5ZvYgAAvjtAAABGqeA=
Date: Fri, 12 Dec 2025 06:37:48 +0000
Message-ID:
 <PRAPR10MB5421B3F7A9A117FD038BA5BC90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
References:
 <PRAPR10MB5421CC811D1DDDF69E01283690AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
 <PRAPR10MB5421DDB53D5BE922CBECB47B90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <PRAPR10MB5421DDB53D5BE922CBECB47B90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5421:EE_|PAVPR10MB7137:EE_
x-ms-office365-filtering-correlation-id: 96535f10-c657-48c8-10e1-08de3948f739
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021|7053199007|4013099003|4053099003|8096899003;
x-microsoft-antispam-message-info:
 =?gb2312?B?blNKNHRscW5GM2hKYkZINkgrazJUa3YwUDRGSWg0bWh3YW9KQktuU3hQVXJI?=
 =?gb2312?B?UmQwT2dBYklnSGI3TUxWN3FZK043eitFREd0QnR3WUZscEUzV3EzNU93Y01F?=
 =?gb2312?B?SVEwUXVCYlM2S2tJdWovSDhlRXovOXh6c09XZnF3c1B0SkVQemJGSXZWaEZY?=
 =?gb2312?B?NVczUHRuNStNeUFNOVg5ZUZJTXdFSzA1TXJobHZQdGhUbFFkeGZqSlhScENp?=
 =?gb2312?B?UkIwSzVmZk9VMktNVjA3S0prQUlDZ0JZNFhMSm0rK0YyblZjWllXWUU5UHBk?=
 =?gb2312?B?NmI5OW1iSnExb2FxR3E4b2ZvS3c5a1FZeWcyVTZWQm41Z2VobGVmNzRnVE0w?=
 =?gb2312?B?WlJoc3RBVyttajNVbEFFMVJIM3hQU2VaZkEveUxLZGp4Q2FySk5JTFgyK1Fs?=
 =?gb2312?B?R2hhMEpkU0JHZ1hZdnVYNlcrV1lxVi9PaGNzYVVGZXNJQ3llMlBjMWR1ZG9N?=
 =?gb2312?B?RlEyMXhtUmdEOVc2YzloZ0NDaFRjbGNQWGY4cHMyUUFTTURvUEZPY3VsempQ?=
 =?gb2312?B?MytEQzFmN0pOVWhQZjM0SExoZVRZQVlMakFoc0xoYmE0Mi9BNUJDbHMrTzVn?=
 =?gb2312?B?ay9GVTNZcCtRSXhxcENzWVcrWWJ4dy9wYWtLU0lVcHdYRE5Ka3M4cWdCKzM5?=
 =?gb2312?B?Y1hTbkw2T01CWEJKQytMT3N1d1RHU1B1SXovdmc1NzRNV2krQkcwM1hRVjVH?=
 =?gb2312?B?OUhZUjJXanhnZ3BGeEpDQ0hYb3FvUDFGRkdYd0VOQlNzek8zajh2ZUhuVUxp?=
 =?gb2312?B?VCtlbjFxQi9jTTNqdVJwdkk1eGhDSmZzMk9UVFJiaHhNZ05UdllVeHR5ZkVz?=
 =?gb2312?B?Tk9wQnBrRjYvRkgzeVMvNFRueklkUTg2N1diYmM5ZlZPeXJFRWJGeXhJdXV3?=
 =?gb2312?B?NU80MXcxR2ZkcjRnTW5QMjEyeTFCUnBmT1pXR2VXSzFOZVRkWWVoVWI0T3VR?=
 =?gb2312?B?TkdMNUZoa3pXZWxST21YdWJ0d3l3V1M1aDBjaDl2Vms1Uktubi9SaUx6K29u?=
 =?gb2312?B?VjdxOTkvbUdnWERLbHN6VmhscG1oR0VneitCTE5iY01BeCtRdmpzMlBmalIw?=
 =?gb2312?B?d0FzYitjVWJuQVhTR1Znc0toRGhub1c4aDJUdS9JZXZIb0JZdWRYbGtWTFdN?=
 =?gb2312?B?SU1lUDJUOXFvN0VDbElhYm90NDdOajhSSUFZSzAvRk5zS1BCRE5KYXc3T1hZ?=
 =?gb2312?B?eGdYRGpNa1c0b2RnL2hCYzhmVytqMXpmOUlleDRFZTdMUHlhbGtLMk5rUzZt?=
 =?gb2312?B?KzlZU2dLdjJkTlR3WDNYOVpRcVI4L0EyL0V5by8zTnlzcEhzTURhUXR3L0wz?=
 =?gb2312?B?ajkzbVUrMmVyWDduNTN2RHhyMm45OTExaHp6RVFHSHVqd3hGRVBTTVZXUDFE?=
 =?gb2312?B?V0V4SkIrNGRFUXFDWitJNTZhcVBSQzlzTlNlWndHbFAxVFVQenkrQXZMWXZT?=
 =?gb2312?B?RHlPRkpoTzYzQjVLcHVHSEFWV0ZtRmxvYTdHUGhzck5Ja0FGTVR2U3FHTkFs?=
 =?gb2312?B?SkFGbGFsSHBsd2t5Q3ljNmsvYi9XZ3pDb1JEa0ErSzVOQ2JFcUZNNmxUNk5R?=
 =?gb2312?B?WTFDNVJyQ0szNE9LVnAzd1FWcU1JcXg3b3FIaDdjZm9JclZIZ1RnR0tha1JT?=
 =?gb2312?B?WjFmN2pmZUozWXNOS1pneTliZm42cDJrQm94WWlaejJ6eXhkMWJXdFdDWVAr?=
 =?gb2312?B?bittUVU1SVdXc2Q3KzBQVks0V3hpRTArOVRBdklvRy9vNTMzQ3hpZ0I2cGNs?=
 =?gb2312?B?S0o2MEhSUnowZS9RSHJnYkN5T3B1c0p3NGNwb3FqZlUyWGlCT09ub1Q5U2Vq?=
 =?gb2312?B?OVlBU1dKbkdrbm5QMUt4QWFGVlhmRUJ1UHgva3NHNjVjWUt5Vm5LdXhMTCs4?=
 =?gb2312?B?cmxGUFlHWWFwakFyV2tZUkRqWjRuWkRGM202NGRHaTh2ZUUveW5LOGpnTldI?=
 =?gb2312?Q?1zH6oX0AWzrVIB0zCefYYCRIVMHYn+jo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021)(7053199007)(4013099003)(4053099003)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UUZhdHU2Mnh2Y3VrR3E4SXptV3htVUg5NCtOdEQ2MVhWdHRpemdIVkNBMnlJ?=
 =?gb2312?B?QnBnMmc2a1VVR0h6WDluZHNrbzYrOGhxaWIzUlNreXdVMVNxdHZCVXB3emh4?=
 =?gb2312?B?ZUc5Y0w1aUNiTkp4SW5TWkwwdEEzM3ZEWTFoK3NNU3p1N0hGbGwyaVdVdng4?=
 =?gb2312?B?STdKalBIRStNQzI0L1g4QWw4bEFMYnpTbEF1VVdGZ3RSOE10Vm41NWdTVVVB?=
 =?gb2312?B?ci9jSndLTGxvaDhFTXB4RUZheVlVVXVKQUhrYVR0NnNJS1dUOFJtaC93UExa?=
 =?gb2312?B?enRXTkdLeUx6TWhRVGRKOENtaDVUcTNZM0RoUERlTnYrQlBlRys2N0dKWmRj?=
 =?gb2312?B?NEZqTjJrSS9wLzQ5NVJDL0xjRXdXK25peWdXS2p4Q0RKUWVWMHJTaXNFQzFV?=
 =?gb2312?B?Unc0TVhnNFQxMk90SHdUUVNMR0ZWMGxOaDNvMEdySVQrWnNrWXhyRDRxMENo?=
 =?gb2312?B?TUlyVENuSmFyU21kOHZ2NmVZYUgrNm92OVBNSUwyQ1lkYjFxcnNTZzRZc2M5?=
 =?gb2312?B?MndqLzhYV2k2ZU5jN29WS2tPazJ6N1M1bUpaK1o3SzJPRjFKcE9INExxa3BS?=
 =?gb2312?B?eDVwanljRWFBeWRBN2pyMDQ3SWdRaHd6cWNEMDVHcWlxcnUwRjRpYVB4alJa?=
 =?gb2312?B?ZkRUbGpkQWJXakwyUnhCYmQraGNYQ2ovTGZ0VVRjMGV1ajJHcE5OajRKcC9p?=
 =?gb2312?B?TDh6OGlHNjZGMmxVa0hEbkcxaWl6dXBCN09iTCtjektXTGpaUEtmWVBmNldx?=
 =?gb2312?B?d1hTdnN0dkNHdjRqZ2VRVEk3L3BDY0xsTENvRWVVRTZhQWZ2a24xZWNpL0Nv?=
 =?gb2312?B?eE9CWEtKSjVwT1VNdFhzbDFjaGxjdkh0dFdhckZoQkxCaUJPQ0l2dWtYTmkw?=
 =?gb2312?B?NkQ4TzV3N1NPbld5Zm16c3JIWHZ4WVA0cjY5RG9ob0NrU0dsTHFoQ2EraEph?=
 =?gb2312?B?T3ZjQ1gvTitKZE9xKzcvMUY4N0pvajMzaWJmMEVPbzd5ZmpRU0t2Q3JwNm91?=
 =?gb2312?B?SDVwMEttUEM4U3RNOGtoaVc1V25YdEJOa0dwUkc3VjZ1OEdTWm9YSHZSN2Ry?=
 =?gb2312?B?eXVpR2M5NDFjajlBMEp4ekU4Zm15WGFHbnREYWhnRWxJem81VU5JNjhjY1Mx?=
 =?gb2312?B?L3lFdmF1a3Z1V0JwdHZTbHNCU0ZuckpyZ1FYVlRrTG1iR2ppOG16aEJSV1BU?=
 =?gb2312?B?U3ppYXBic1JSOGI5YVVPcWNUOHRqWlRuOS9RWmJKRnY0bEd2QWZ3Y3AxSCtQ?=
 =?gb2312?B?RndVOXVBSXZ6QnFzeW5aUFdzTGp4czYycXVvSk9yMHNEUzdoS0tsUU9JOC92?=
 =?gb2312?B?ZXZQSVh6U0s3K0pYWEVWdFRTSGh5QlZOK09sM2dLV1ZZZjZvYmRSNkk2ckMv?=
 =?gb2312?B?VmNFcTZKRFRXRDRIc2szamRZZUFJS3dxTG1NOEx3NUFVcnV0Q2s4ZGIxa0dJ?=
 =?gb2312?B?MllyNldFdERzb3o4aG1VSG8yTEx3YXo0SW4yQTFqWGJkM1FLTlVwbGUzVE1Q?=
 =?gb2312?B?TllwWDFLeFNUNUV2akVDTnl6WUpualJQckh2aXM2aFdQbzh2bkdaWkhJQ2lP?=
 =?gb2312?B?WnMvRDBzc3NLMlVzbzFiS2FtU3pWam5qZEw2TnBDZzdZQlpRbFBoSlFPK2E5?=
 =?gb2312?B?Wk4yWjNjUlBEeUE4V25vWmxBZE9lZm9QelRQTnVEWEo2aW9FaFJ2dnh3NVNn?=
 =?gb2312?B?R2RWTFN3OWtsR2NkWk93YkhCV214SzJZdVJrSVNiVjFxTXZIejRVMENucm9C?=
 =?gb2312?B?ajJMUGMrWXhYZjdETW1NSjRBOTlsZTZLdFk0QnFpRTNzWEc3a21URkRlbkRB?=
 =?gb2312?B?azlrckpwN2pESGJqNXRBZlRsK01BOEVxdGRTRXhFR2xVT3IvVFpJY21DQ3p1?=
 =?gb2312?B?bHlzVlBzWjFHUHdZdDdUUGZhVUtjYmJ3Wm9xUGxEenlpREs4eitjZGNIRmpI?=
 =?gb2312?B?b2VlZHhqWk55UzhNQWIxdDlYZmtvc3o1aURMbmdSUUJUUnMwOXd0Y2lubnBR?=
 =?gb2312?B?LzhJWEE0V24xR2FPaWN0Zkk5cC9McXQzZVY0enYzSWllU0k4cmVyMFQ4M3Z0?=
 =?gb2312?B?WnhQZGRJeDBGZjI5d01lY0lYNWwzbklncXoxdldaOExwRlNSZE5GNGRtelJD?=
 =?gb2312?Q?S1j8=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PRAPR10MB5421B3F7A9A117FD038BA5BC90AEAPRAPR10MB5421EURP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96535f10-c657-48c8-10e1-08de3948f739
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 06:37:48.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpLlZHwgMel1Vnp/kuPsQn6cP97lfrvBa/TJL06egZKOlz1m6sIsSSAkoJythCU/cMNP28sZyC9QwuAa7CnJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7137

--_004_PRAPR10MB5421B3F7A9A117FD038BA5BC90AEAPRAPR10MB5421EURP_
Content-Type: multipart/alternative;
	boundary="_000_PRAPR10MB5421B3F7A9A117FD038BA5BC90AEAPRAPR10MB5421EURP_"

--_000_PRAPR10MB5421B3F7A9A117FD038BA5BC90AEAPRAPR10MB5421EURP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG86DQoNCiAgICAgICAgICAgIEkgcmVwYWNrYWdlZCB0aGUgcGF0Y2ggZmlsZSBpbnRvIGEg
emlwIGZpbGUsIHBsZWFzZSBjaGVjayBpdCwgdGhhbmtzISENCg0KWWFtaW5nIENoZW4NCkdERS1F
RFNDRA0KDQqyqc73u6q158b3o6i9rcvVo6nT0M/euavLviwg1tC5+r2ty9XKocTPvqnK0L6tvMO8
vMr1v6q3osf40qLQwrTztcAyMDi6xSAyMTAwNDYNCsrWu/qjujE5OTYyMDMyNzUxDQpZYW1pbmcu
Q2hlbkBic2hnLmNvbTxtYWlsdG86WWFtaW5nLkNoZW5AYnNoZy5jb20+DQoNCg0KRnJvbTogQnl0
ZW1hcmsgc3VwcG9ydEBieXRlbWFyay5jby51azxtYWlsdG86c3VwcG9ydEBieXRlbWFyay5jby51
az4NClNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTIsIDIwMjUgMjozMSBQTQ0KVG86IENoZW4gWWFt
aW5nIChCU0ggR0RFLUVEU0NEKSB5YW1pbmcuY2hlbkBic2hnLmNvbTxtYWlsdG86eWFtaW5nLmNo
ZW5AYnNoZy5jb20+DQpTdWJqZWN0OiBZb3VyIGF0dGFjaG1lbnQgd2FzIHJlamVjdGVkDQoNCkRl
YXIgQ2hlbiBZYW1pbmcgKEJTSCBHREUtRURTQ0QpLA0KDQpZb3VyIGVtYWlsIHRvIG91ciBzdXBw
b3J0IHN5c3RlbSBjb3VsZCBub3QgYmUgYWNjZXB0ZWQgaW4gZnVsbC4gVGhlIGZvbGxvd2luZyBm
aWxlKHMpIHdlcmUgcmVqZWN0ZWQgYnkgb3VyIHN5c3RlbTogMDAwMS13aWZpLUZpeC10aGUtY3Jh
c2gtaXNzdWUtd2hlbi1yZXN0YXJ0aW5nLXRoZS13cGFfc3VwcGxpY2FudC1vci13aWZpLWRyaXZl
ci13aGlsZS1iYWNrZ3JvdW5kLXNjYW5uaW5nLWVuYWJsZS5wYXRjaA0KDQpQbGVhc2UgdHJ5IHJl
LXNlbmRpbmcgeW91ciBhdHRhY2htZW50IHVzaW5nIG9uZSBvZiB0aGUgZm9sbG93aW5nIGFsbG93
ZWQgYXR0YWNobWVudCB0eXBlczogZG9jfGRvY3h8eG1sfHBuZ3xnaWZ8anBnfGpwZWd8emlwfHJh
cnxwZGZ8dHh0fGxvZ3x4bHN4fHdhdi4NCg0KS2luZCBSZWdhcmRzLA0KQnl0ZW1hcmsNCg0KDQpG
cm9tOiBDaGVuIFlhbWluZyAoQlNIIEdERS1FRFNDRCkNClNlbnQ6IEZyaWRheSwgRGVjZW1iZXIg
MTIsIDIwMjUgMjoyOCBQTQ0KVG86ICdjb25ubWFuQGxpc3RzLmxpbnV4LmRldicgPGNvbm5tYW5A
bGlzdHMubGludXguZGV2Pg0KQ2M6IERlbWJpYW5ueSBTdmVuIChCU0ggR0RFLUVEU0Q3KSA8U3Zl
bi5EZW1iaWFubnlAYnNoZy5jb20+DQpTdWJqZWN0OiBGaXggdGhlIGNyYXNoIGlzc3VlIHdoZW4g
cmVzdGFydGluZyB0aGUgd3BhX3N1cHBsaWNhbnQgb3Igd2lmaSBkcml2ZXIgd2hpbGUgQmFja2dy
b3VuZFNjYW5uaW5nIGlzIGVuYWJsZQ0KDQpIZWxsbywgY29ubWFuIHRlYW06DQogICAgICAgICAg
ICAgIEkgYW0gYSBzb2Z0d2FyZSBkZXZlbG9wbWVudCBlbmdpbmVlciBvZiBCU0ggY29tcGFueS4g
V2UgaGF2ZSBkaXNjb3ZlcmVkIGEgYnVnIGluIG91ciBwcm9qZWN0IHVzaW5nIGNvbm5tYW4uIFdo
ZW4gQmFja2dyb3VuZFNjYW5uaW5nIGlzIGVuYWJsZSwgaWYgdGhlIHdpZmkgZHJpdmVyIG9yIHdw
YV9zdXBwbGljYW50IGlzIHJlc3RhcnRlZCwgaXQgd2lsbCBjYXVzZSBjb25ubWFuIGNyYXNoLiBU
aGUgcGFyc2luZyBvZiB0aGUgY29yZSBkdW1wIHByaW50IGNhbGwgc3RhY2sgc2hvd3MgdGhlIGZv
bGxvd2luZzoNCg0KQ29yZSB3YXMgZ2VuZXJhdGVkIGJ5IGAvdXNyL3NiaW4vY29ubm1hbmQgLS1u
b2Ruc3Byb3h5IC1uJy4NClByb2dyYW0gdGVybWluYXRlZCB3aXRoIHNpZ25hbCBTSUdTRUdWLCBT
ZWdtZW50YXRpb24gZmF1bHQuDQojMCBhdXRvc2Nhbl90aW1lb3V0IChkYXRhPTB4MTQ0YmMwMCkg
YXQgLi4vY29ubm1hbi0xLjQ0L3BsdWdpbnMvd2lmaS5jOjEzODINCjEzODIgLi4vY29ubm1hbi0x
LjQ0L3BsdWdpbnMvd2lmaS5jOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Lg0KKGdkYikgYnQN
CiMwIGF1dG9zY2FuX3RpbWVvdXQgKGRhdGE9MHgxNDRiYzAwKSBhdCAuLi9jb25ubWFuLTEuNDQv
cGx1Z2lucy93aWZpLmM6MTM4Mg0KIzEgMHg3NmQwZjhiNCBpbiA/PyAoKSBmcm9tIC91c3IvbGli
L2xpYmdsaWItMi4wLnNvLjANCiMyIDB4NzZkMGVmZjYgaW4gZ19tYWluX2NvbnRleHRfZGlzcGF0
Y2ggKCkgZnJvbSAvdXNyL2xpYi9saWJnbGliLTIuMC5zby4wDQojMyAweDc2ZDBmMjRjIGluID8/
ICgpIGZyb20gL3Vzci9saWIvbGliZ2xpYi0yLjAuc28uMA0KIzQgMHg3NmQwZjRhNiBpbiBnX21h
aW5fbG9vcF9ydW4gKCkgZnJvbSAvdXNyL2xpYi9saWJnbGliLTIuMC5zby4wDQojNSAweDAwMDFk
MTI2IGluIG1haW4gKGFyZ2M9PG9wdGltaXplZCBvdXQ+LCBhcmd2PTxvcHRpbWl6ZWQgb3V0Pikg
YXQgLi4vY29ubm1hbi0xLjQ0L3NyYy9tYWluLmM6MTI1Mw0KDQpXZSBoYXZlIGNyZWF0ZWQgYSBw
YXRjaCB0byBhdHRlbXB0IHRvIGZpeCB0aGlzIGlzc3VlLCBwbGVhc2UgaGVscCBldmFsdWF0ZSBh
bmQgcmV2aWV3IGl0o6x0aGFua3OjoaOhDQoNCg0KQmVzdCByZWdhcmRzo6GjoQ0KDQoNCg0KWWFt
aW5nIENoZW4NCkdERS1FRFNDRA0KDQqyqc73u6q158b3o6i9rcvVo6nT0M/euavLviwg1tC5+r2t
y9XKocTPvqnK0L6tvMO8vMr1v6q3osf40qLQwrTztcAyMDi6xSAyMTAwNDYNCsrWu/qjujE5OTYy
MDMyNzUxDQpZYW1pbmcuQ2hlbkBic2hnLmNvbTxtYWlsdG86WWFtaW5nLkNoZW5AYnNoZy5jb20+
DQoNCg==

--_000_PRAPR10MB5421B3F7A9A117FD038BA5BC90AEAPRAPR10MB5421EURP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:=CE=A2=C8=ED=D1=C5=BA=DA;
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@=CE=A2=C8=ED=D1=C5=BA=DA";}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; I repackaged the patch file into a zip file, please check it=
, thanks!!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">Yaming Chen<br>
GDE-EDSCD<br>
<br>
</span><span lang=3D"ZH-CN" style=3D"font-size:10.0pt;font-family:&quot;=CE=
=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif;color:black">=B2=A9=CE=F7=BB=AA=B5=
=E7=C6=F7=A3=A8=BD=AD=CB=D5=A3=A9=D3=D0=CF=DE=B9=AB=CB=BE</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">=
,
</span><span lang=3D"ZH-CN" style=3D"font-size:10.0pt;font-family:&quot;=CE=
=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif;color:black">=D6=D0=B9=FA=BD=AD=CB=
=D5=CA=A1=C4=CF=BE=A9=CA=D0=BE=AD=BC=C3=BC=BC=CA=F5=BF=AA=B7=A2=C7=F8=D2=A2=
=D0=C2=B4=F3=B5=C0</span><span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif;color:black">208</span><span lang=3D"ZH-CN" style=3D=
"font-size:10.0pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-ser=
if;color:black">=BA=C5</span><span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif;color:black">
 210046 <br>
</span><span lang=3D"ZH-CN" style=3D"font-size:10.0pt;font-family:&quot;=CE=
=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif;color:black">=CA=D6=BB=FA=A3=BA</spa=
n><span style=3D"font-size:10.0pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif;color:black">19962032751</span><span style=3D"font-siz=
e:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">
<br>
</span><a href=3D"mailto:Yaming.Chen@bshg.com"><span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">Yaming.Chen@bshg.c=
om</span></a>
<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Bytemark
<a href=3D"mailto:support@bytemark.co.uk">support@bytemark.co.uk</a> <br>
<b>Sent:</b> Friday, December 12, 2025 2:31 PM<br>
<b>To:</b> Chen Yaming (BSH GDE-EDSCD) <a href=3D"mailto:yaming.chen@bshg.c=
om">yaming.chen@bshg.com</a><br>
<b>Subject:</b> Your attachment was rejected<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Dear Chen Yaming (BSH GDE-EDSCD),<br>
<br>
Your email to our support system could not be accepted in full. The followi=
ng file(s) were rejected by our system:
<strong><span style=3D"font-family:&quot;Aptos&quot;,sans-serif">0001-wifi-=
Fix-the-crash-issue-when-restarting-the-wpa_supplicant-or-wifi-driver-while=
-background-scanning-enable.patch</span></strong><br>
<br>
Please try re-sending your attachment using one of the following allowed at=
tachment types: doc|docx|xml|png|gif|jpg|jpeg|zip|rar|pdf|txt|log|xlsx|wav.=
<br>
<br>
Kind Regards,<br>
<strong><span style=3D"font-family:&quot;Aptos&quot;,sans-serif">Bytemark</=
span></strong> <span style=3D"mso-ligatures:none">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none"> Chen Yaming (BSH GDE-EDSCD)
<br>
<b>Sent:</b> Friday, December 12, 2025 2:28 PM<br>
<b>To:</b> 'connman@lists.linux.dev' &lt;connman@lists.linux.dev&gt;<br>
<b>Cc:</b> Dembianny Sven (BSH GDE-EDSD7) &lt;Sven.Dembianny@bshg.com&gt;<b=
r>
<b>Subject:</b> Fix the crash issue when restarting the wpa_supplicant or w=
ifi driver while BackgroundScanning is enable<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello, conman team:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; I am a software development engineer of BSH comp=
any. We have discovered a bug in our project using connman. When Background=
Scanning is enable, if the wifi driver or wpa_supplicant is restarted, it w=
ill cause connman crash.
 The parsing of the core dump print call stack shows the following:<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">Core was generated b=
y `/usr/sbin/connmand --nodnsproxy -n'.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">Program terminated w=
ith signal SIGSEGV, Segmentation fault.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">#0 autoscan_timeout =
(data=3D0x144bc00) at ../connman-1.44/plugins/wifi.c:1382<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">1382 ../connman-1.44=
/plugins/wifi.c: No such file or directory.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">(gdb) bt<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">#0 autoscan_timeout =
(data=3D0x144bc00) at ../connman-1.44/plugins/wifi.c:1382<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">#1 0x76d0f8b4 in ?? =
() from /usr/lib/libglib-2.0.so.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">#2 0x76d0eff6 in g_m=
ain_context_dispatch () from /usr/lib/libglib-2.0.so.0<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">#3 0x76d0f24c in ?? =
() from /usr/lib/libglib-2.0.so.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">#4 0x76d0f4a6 in g_m=
ain_loop_run () from /usr/lib/libglib-2.0.so.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt">#5 0x0001d126 in mai=
n (argc=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;) at ../connma=
n-1.44/src/main.c:1253<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We have created a patch to attempt to fix this issue=
, please help evaluate and review it<span lang=3D"ZH-CN" style=3D"font-fami=
ly:=B5=C8=CF=DF">=A3=AC</span>thanks<span lang=3D"ZH-CN" style=3D"font-fami=
ly:=B5=C8=CF=DF">=A3=A1=A3=A1</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards<span lang=3D"ZH-CN" style=3D"font-famil=
y:=B5=C8=CF=DF">=A3=A1=A3=A1</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">Yaming Chen<br>
GDE-EDSCD<br>
<br>
</span><span lang=3D"ZH-CN" style=3D"font-size:10.0pt;font-family:&quot;=CE=
=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif;color:black">=B2=A9=CE=F7=BB=AA=B5=
=E7=C6=F7=A3=A8=BD=AD=CB=D5=A3=A9=D3=D0=CF=DE=B9=AB=CB=BE</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">=
,
</span><span lang=3D"ZH-CN" style=3D"font-size:10.0pt;font-family:&quot;=CE=
=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif;color:black">=D6=D0=B9=FA=BD=AD=CB=
=D5=CA=A1=C4=CF=BE=A9=CA=D0=BE=AD=BC=C3=BC=BC=CA=F5=BF=AA=B7=A2=C7=F8=D2=A2=
=D0=C2=B4=F3=B5=C0</span><span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif;color:black">208</span><span lang=3D"ZH-CN" style=3D=
"font-size:10.0pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-ser=
if;color:black">=BA=C5</span><span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif;color:black">
 210046 <br>
</span><span lang=3D"ZH-CN" style=3D"font-size:10.0pt;font-family:&quot;=CE=
=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif;color:black">=CA=D6=BB=FA=A3=BA</spa=
n><span style=3D"font-size:10.0pt;font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif;color:black">19962032751</span><span style=3D"font-siz=
e:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">
<br>
</span><a href=3D"mailto:Yaming.Chen@bshg.com"><span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">Yaming.Chen@bshg.c=
om</span></a>
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_PRAPR10MB5421B3F7A9A117FD038BA5BC90AEAPRAPR10MB5421EURP_--

--_004_PRAPR10MB5421B3F7A9A117FD038BA5BC90AEAPRAPR10MB5421EURP_
Content-Type: application/x-zip-compressed;
	name="0001-wifi-Fix-the-crash-issue-when-restarting-the-wpa_supplicant-or-wifi-driver-while-background-scanning-enable.zip"
Content-Description:
 0001-wifi-Fix-the-crash-issue-when-restarting-the-wpa_supplicant-or-wifi-driver-while-background-scanning-enable.zip
Content-Disposition: attachment;
	filename="0001-wifi-Fix-the-crash-issue-when-restarting-the-wpa_supplicant-or-wifi-driver-while-background-scanning-enable.zip";
	size=1219; creation-date="Fri, 12 Dec 2025 06:33:34 GMT";
	modification-date="Fri, 12 Dec 2025 06:37:47 GMT"
Content-Transfer-Encoding: base64

UEsDBBQACAAIADtsjFsAAAAAAAAAAAAAAAB2ACAAMDAwMS13aWZpLUZpeC10aGUtY3Jhc2gtaXNz
dWUtd2hlbi1yZXN0YXJ0aW5nLXRoZS13cGFfc3VwcGxpY2FudC1vci13aWZpLWRyaXZlci13aGls
ZS1iYWNrZ3JvdW5kLXNjYW5uaW5nLWVuYWJsZS5wYXRjaHV4CwABBAAAAAAEAAAAAFVUDQAHQ6k7
abevO2lDqTtptVXbbtw2EH02v2Lgh2DtvVja+26awI4dp/tQI8AGzUNRCJQ40rKRSIGkvAnS/HuH
lFXfgqQPW2GXunDmzJkzM9K10RXMllEsokkaL2JcLhf5Yi7mXKz4NF9M0kU2n/FoMlvEK/hNK9hi
DfEComgdfjCOoph5mDUcf+GVVMUo26E6hl8e3J2ndkdXunrNrrjDNVwbOYB4DFeYEcJ4BvFkPZ6u
oxX0o2UUsW2T/oWZW8Mf7y8+XP76J+xlLtfX8jO4HUJmuN2BtLZB2BM8GLSOG0fhwv6+5olt6rqU
GVeOgTbBH4SRt0jXO1kivOHZp8LoRoktWSnvKy2g4mmJjG3yHxoMoObWEhrwxmmwnYGTFerGwV6b
T6AQBTjNUiSClb6lu8CW084eeOa8v32A7YwsCjQoRm8w443FQHv42sfwdowr8aOAe1mWEKJlSDIL
yCnz78QaQNo4pkvxX7IgXtZ5YNPcOcu8lTOXptpzg6Qveyy5d7qrCbHgDqyuMMCCVKFEeeMaQzJ6
EgGsSy3kqUP1LdRaKofG/ptZbkjTAcHdOz2WCL7r6ksguCpKn939ji+GJ9PluyO8khokbxQJRs2u
c3ioUicQu1dbp45TSj9hQ5q51v6uxNQDbRNThEwrVXE1YsPhkEFdNoVU9swDjTL4G+IZ9B8fDGLS
nlo4I8KF14NsyAeNJ217/RPGhMxzGA4LisvPnmCmTx4wqQR+pnGcLFc5n49GYrqcTGdcQBxF8+nU
E3uGwojIc6TzcxjGq9VqMId+OI9joGfUCU5mxNEFgRKvTc8602SuSz8ReCszhNP2PGBwdPSNFvqz
/tHZKS1wCoccywB4uNkMcAcd0IB40CkNiIcd1Zbkoee1q80hh7ZN/n+ZXA99Ritp3uv62aLzH6Sk
QJekWpe94+ede3wCL16QHx1t+I5s4r7UCK9ewcfN9SbZXl7c3Gxu3iXvL7bbze9vT+Crd6KyEXbH
uNcOzslL2vrG6CVBQwNX0noSjSTCKbo9knitHSmOhtqvCup2DeYr+6T3KTEI7JKmFtS0YXgVmkCx
5zcGT1heXH7wJF/S5NKLg41Hk+koZuwfUEsHCFID+60tAwAAbAgAAFBLAQIUAxQACAAIADtsjFtS
A/utLQMAAGwIAAB2ABgAAAAAAAAAAAC2gQAAAAAwMDAxLXdpZmktRml4LXRoZS1jcmFzaC1pc3N1
ZS13aGVuLXJlc3RhcnRpbmctdGhlLXdwYV9zdXBwbGljYW50LW9yLXdpZmktZHJpdmVyLXdoaWxl
LWJhY2tncm91bmQtc2Nhbm5pbmctZW5hYmxlLnBhdGNodXgLAAEEAAAAAAQAAAAAVVQFAAFDqTtp
UEsFBgAAAAABAAEAvAAAAPEDAAAAAA==

--_004_PRAPR10MB5421B3F7A9A117FD038BA5BC90AEAPRAPR10MB5421EURP_--
