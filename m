Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020080.outbound.protection.outlook.com [52.101.69.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C72E9EBB
	for <connman@lists.linux.dev>; Mon, 20 Oct 2025 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947662; cv=fail; b=FqXpof4TVWsX4yrxkiY/Z+Yg439tqAYIhQ9CudvNM7KGqyW8JtQRZ1A4GgdtRE4GojoLtDgw1Bp6IDHmTlr2JQ57olpZ68NTG66XZQqx84h1uiqxRGCr+cfib5RVsEMdUL5CJKiAAjJfxwT/uKVO7HB9AkmEMnxaca3l+xOBr+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947662; c=relaxed/simple;
	bh=tJXOzmRZ2Gydd1+ydm0+9P22MPhPQBHXi+slZekd9g4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CcEoPF+RfObMTUX96LZExzSJ/HCSQOYJUm0XSId6+ebpiTpLRBaC8yPPCv8WAhNtVr2pyCCdH02aQnELAgCiy82AeAc7Aif0cN4CY28ktNeCTYMbez8GZMZ+W9gfPPguKX2ArSYW2x+TxTqbpDJgRuPqre+HYIej4fFTEXQd9do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goeg.at; spf=pass smtp.mailfrom=goeg.at; dkim=pass (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b=B9PS0hND; arc=fail smtp.client-ip=52.101.69.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goeg.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goeg.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b="B9PS0hND"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZIsFpoXAywebvsbRqF2FtwaCbpsxUMbZe17RPMtvZQSpP/QI7+UkejBz0jO2bnmtfX+HKhnu4KBasIbi8LfGHIzFiDdZljBupLa+5MsNj9IStQRJDme7RMW92Il0kFsNaYxL43iN4aXZ1qHfNrQ8ONVfD6u/8BSZb1wDic7ZI4MuR0KQIOsKuSpSAUz4Ndh92A/cio7tJ4JZYzpnZ7L08I8vA6KC5ZoyKF7QOCK2MOoe5ZkjuSFldvqq1ZYFoP0xV2l+RxWYJ3n52/RtUvIq/5L+UzMZTTsWxtl3IPDhZzZQ9h5ooK5sPJfm0hoimvf7AeqDtgMBAQN8C8THi1Fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJXOzmRZ2Gydd1+ydm0+9P22MPhPQBHXi+slZekd9g4=;
 b=vU2S5vQgFHznNQwC4zkK48LY+FWcUwnaZxcqte2N+D97YlcZMY+YeisBYVYAxmUlCUfUXOGWu6/QJIlC2bR5uiwCjr1xD+SWlV2ei5SlD3raEGQaqvkGqqZDcfSlTnbD73gSuAX4drebW5Q+IpijNpZYzp0k6Owy1Si53z0O1xmHHY99YH+2QXBaSWu4FyCKEGassA8+zWcXwYLe3Wo1TkOhWpsBnkGSNB1nzwbmMz8b7QQis9rkWpk3nikBRTSX4hDrl4De3o8TS0o5ruCN4hVMTEAdWM+m3QXzwRqnPNnQhru5aimNnWEzrGdNtkUeEmtAXd6Hpd+eDTIK6Y8Rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJXOzmRZ2Gydd1+ydm0+9P22MPhPQBHXi+slZekd9g4=;
 b=B9PS0hNDv14QqK9dqiagtP5AFxv61vdeWQBpUtJ3rj3BKQKRhWBFTsPs6u0sD+6iJgysMNmtOBQRCIlZPYibvFD2HAJAjZC6wKVJKHlaEPyjzSGAVnnDKA7ncKcS65EYlYC6cRUvWfetCTVVULsQTnQau57GA8leHL85TWRmEBU=
Received: from VI1PR09MB4462.eurprd09.prod.outlook.com (2603:10a6:800:153::15)
 by GVXPR09MB6876.eurprd09.prod.outlook.com (2603:10a6:150:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 08:07:22 +0000
Received: from VI1PR09MB4462.eurprd09.prod.outlook.com
 ([fe80::e395:88fb:63a7:122d]) by VI1PR09MB4462.eurprd09.prod.outlook.com
 ([fe80::e395:88fb:63a7:122d%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:07:22 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] client: set rl_prompt after saving
Thread-Topic: [PATCH] client: set rl_prompt after saving
Thread-Index: AQHcQHWbP5pVeh1iIkiOUMV6e/pz6bTKsDOA
Date: Mon, 20 Oct 2025 08:07:21 +0000
Message-ID: <f9379940-6eef-4887-9efb-481663d0731c@goeg.at>
References: <20251018212411.181909-1-jsbronder@cold-front.org>
In-Reply-To: <20251018212411.181909-1-jsbronder@cold-front.org>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB4462:EE_|GVXPR09MB6876:EE_
x-ms-office365-filtering-correlation-id: b3c1f542-d3ef-402b-73fb-08de0fafb254
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2dTbXNSN3NQSEtXUXRYSVBhdWEwdlZCTDFvT29ZTW9RVkQzQ200T3d2bTkw?=
 =?utf-8?B?aFErbythbEdXeDg4S2FsTlhtcUU1M2NzcnNVd2k1UlhrUDlXSm9BVjZwQ0tN?=
 =?utf-8?B?Ylphbk16N0N3SXFiSjNEMnN1cXB1dnFubFFNdVQxQ25YRVY5NHFZb0hqRFI1?=
 =?utf-8?B?S1ZuVDF4ZG81N0xId0tCVWVldGRtVkFVam16NHU0YWNlTjVOWFlGSEZBeWVP?=
 =?utf-8?B?SmFlSmNKSU43RE4xNHBXMVl2eUY3cXdhdW9XWlJaY1BNV09HaXRZclU5SWJB?=
 =?utf-8?B?THJ0OXFSdGpDcDJraENCV0lBTXBWUG1xRDNLTjZ4cU9icEhGdHVzalh4YVVU?=
 =?utf-8?B?UmFNb2ZKT2FOZ1dYamhJOHpNQlJCangxVy9nSjhmWHdpZk5rZkFVaTJyNURT?=
 =?utf-8?B?Y2dobGtMeFdxdnRrNUJvdGlWd2Rid2xWaHo2Z1RXcEpMbHk0V0s1VWdxWEs5?=
 =?utf-8?B?M3Q3Y25xR3JLSUE0eGwrL1RwU0dXOTNVay9hbGJWM29lb1Era2hyWmpOcnJQ?=
 =?utf-8?B?K1hkR2hzdE95dUFsRVVqQXZ1VmxXbmJ2S2lTK1lDeHcrVE1PdW55SmRNYVgv?=
 =?utf-8?B?aGxhM29WRUlDN0ZGeHh2R2FwbFh3VlcyQzFtSUJqcDZQY0NWOWlQYWJQY1BD?=
 =?utf-8?B?enducUlFNlU3VVFLYUIxOXVwS0VuS3VXWWd0K0V0emNMWVFhNm1kWlFJTWF5?=
 =?utf-8?B?M1BtSTBzSFA5alBwYjNwUlZMQUFOeGNoWGx0Nmt5RjM3b2dLWTMxN1dpS3Nz?=
 =?utf-8?B?YmVxNWlJcEZZQXNmWkF4bmFKdVQ3QWQrRDJSZFhhcHhmNTgrSTR4RXYxSHM2?=
 =?utf-8?B?eXR6YnpHVW1lZ3ZpUEFWYll1SFE1MkdxelFwelo0RVJ4eGU1ekVVVzc3MHQ2?=
 =?utf-8?B?MVhJeklWNlQyVkNoaVFORVJlVVY1eElVamFrTmpCSXdjNGZlSjlMblNhM1Np?=
 =?utf-8?B?c3RXeWFwSE0waUt1ODhaNGEwN1VMS1BRSTY4elpRM1d3MWZPZUNLRkF4STVr?=
 =?utf-8?B?cDB0OThMV3pDUVNvUGgvdjE3ZnJvb1dHaGp1T1NLU0R4UUp1VHY5Nm94a2dK?=
 =?utf-8?B?RG4xTllXMVZjQ1p3RDJHS0ZvM0U4WmZESE40RE1LOUg2WlZST1k1YkV5T3J1?=
 =?utf-8?B?OFZBY0pyQTNmNHFWS0dGUlZJRHAyWnlLQnU4RHN5dFJNRTU4Vld3MUYrNmpS?=
 =?utf-8?B?QVQ0M0RwNHZjL3pheFJWNGxaUXp2VnJiZy9aMkRWM0xGdzVQeFRiTXpwRDRM?=
 =?utf-8?B?S2prS1hiYzJwNDBEYXBIVFU3dllMRzFPZTlHMG4wWW8zamVnTnlkVHZlb2FW?=
 =?utf-8?B?aHNUd0JsNXJTMWRqWit4UldyMk1kVnVFSlFJVWhGWGNXd1RaTnRhK2prT05J?=
 =?utf-8?B?dEphMldYbXFmZ0ZQc3pBVUo2enh0ZXl2SGlxbEZIQ21MRS81VGpKbU9kSk45?=
 =?utf-8?B?WHh6VllQZmJLMHFaak04OVg3VDVyUkhRVUU1RGdhbGZRK0lyL0ROOUdMK3ZS?=
 =?utf-8?B?RFYrUDJVaWJtSGE1UkNWQlRxRXNROUFmU1dTZmoyOHZrcDMwWFEvdEt1dTVk?=
 =?utf-8?B?NVZxaCt5UCs3ck1MNWd1eHVjaXc1cUZQYkk2emh5QlpzQWVnNTJJZXZvaFZi?=
 =?utf-8?B?dWY5QnQwdjRmV2x0dSs5RVdIMlpFMHNXeWduNVVadnZvdm5kMUxqT3oycEVs?=
 =?utf-8?B?YWhuK0RqaW9QS29oNVBmLzV0cFlac3N6RGR0T3lQUmMwbTFpWVdPcTcwa3JO?=
 =?utf-8?B?NGZKRzlxclZIUkJzWG03S1hQbEF4YmlmeXN3b1RPMGJiZUs5TWNmanNKOWZS?=
 =?utf-8?B?dXMrbHlJWjZ0LzRNdWlYVHVMLzhDaEt3cWJNc0h4OHlYRHBmM2ZSZGhyZXhv?=
 =?utf-8?B?WGNva2RYWmRPVWZVaWszdnplbUo5eVJKUk4wRUczUy9mOVpVdStwVDY2TUc5?=
 =?utf-8?B?TzY3Sm5jcmlYaHFlaEZyVlJNSlZPQWY0NjlQWUprdjJtZmU1MnhnT3FuZjZl?=
 =?utf-8?B?Tm5jSThsMzNQL1dUSlR6ZHUwK2UyRm5VQTgrZ2xWQjYrMGFDa0ZjUUQ2Q0Rk?=
 =?utf-8?Q?rMvMhN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB4462.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTJla2FEMEFvNTZjKzgvVnd4SXo1Uk9TTUVva2ZBM3dFUXBKRDlNWHVwR1ps?=
 =?utf-8?B?djlncE5xQ1A2WTk4bUlNdnJQWWZ1UHF1MFFvTkVsOFM1WXpkNWRucFl3L2Iv?=
 =?utf-8?B?TFh5ODNINFJrOEhGYWM0d0d3czRhQnBBMVhCZXJJMWI5Y0k0SGZQZXRTZ09i?=
 =?utf-8?B?OFJHell3dWRMYlpOOVVoaEhMY2hRZEwwdVRRY1p0M3pUbG8ranR2MGFTZTRi?=
 =?utf-8?B?NWhDODRMaGFpTkRaZmR2Rkl5TDFaMWxFd0JGU0ZEdnRsMzZPQmc3Yzl0OXFz?=
 =?utf-8?B?eXpOYllXOUpuRUpmS2ptVVg0UTYxZkdOYXJrQmlZWEp0Y1pBSis1dCs4MmVS?=
 =?utf-8?B?allNZDcxbGRlSUhLd2JDMElQSmsyTit0QUk1ajNOVWxORTU1emhtVGVIUk1p?=
 =?utf-8?B?N3lxb2UzZ2IraFdaUW9HQytrdTFFR0JkT2tmYzduQ2l6OVdEOGVXeHJIUUk0?=
 =?utf-8?B?STNiNERrTmdta2RuTWIxTTRhZncrY2VhNzVaS0NVMlI1eEFUTzM4dWJndVda?=
 =?utf-8?B?RGdkSVI3NGJHVCtSN1lQczV3djNJQ1BETTQ1MXN6emc1ei9BanFSeXg4Wmo5?=
 =?utf-8?B?QzlOSzdxdHBkTkhzSjlqaWhHNC9ISkplUmJTT1I2VEVrcTR0RWM5KzVlOTkr?=
 =?utf-8?B?Q3Q4ZUMweXBxVzZOTmxPakNIakI2MkdaT2xidVVEcGNiY0lTNGtJWktoMHFE?=
 =?utf-8?B?eTJ1cHNNcDdWYndnZCs4UUt2aGJ5bDY1M3F0NTlTN2lWWS9OSFRtWVIxMDBQ?=
 =?utf-8?B?K3Z1aXl2bk1IU2lHSWx3M1pDSTBVVDQyck0wY0xVQXpOMjFMNTNGdWcrYVQx?=
 =?utf-8?B?dDRlSDJHaS9kc1ZYM3VyK0ttaU93M0h6QjBNRUVLU2x5eU1ycVV4dUswTEVP?=
 =?utf-8?B?a0NuTzUzTFU0dHN3VTNpWTAvdytWY2JHK0pHazlTN2UvaHIxeGZUMjJSZkgz?=
 =?utf-8?B?ekVtQWNkd1VVclUxaXl3djQ1L0o2ck9ENzNleWo3YkVLdGt6TmpUY2MzczhD?=
 =?utf-8?B?MjZEb0JRSGI4ZnpjVVpxZ0dOeFl1RlNucndjRFgyVXl2QTVkVFFaVGorRGV4?=
 =?utf-8?B?cmdZQjZNN1RDenBnYWE5aDhYZ1N2TEI3a1RlUVBTRzhvemU1eStVS1ZiZmw1?=
 =?utf-8?B?eHdzL0VRaGNUU001NzhKcktUakRnb3hmb2FLQzBCTFJjaGNvb0VmYkFJVEgz?=
 =?utf-8?B?b3lkYnBkQ2U0Z2szZjVNQVNySnRKald0dWVpc3czY3dudG9pMkJwc2hnVzFX?=
 =?utf-8?B?Q1BxeExxb202eDVoaWd3M2IwdU5GWjFwNzZHbEVuWFhyQU5UQ3hub0NFMWwx?=
 =?utf-8?B?a2l0L1J1RXBrNFppK1c0YUZ6eXhGbDlMNW9tdm5BT1pTTnhubEE3YnRaUzhP?=
 =?utf-8?B?VEdaNDE0emxxVUxYeWVVMDJjNnZzVmFrQndVRGFEOFBmYnNrbDZlWHhFaFB1?=
 =?utf-8?B?SHdRQTViSUdoVnN0bXNRTitwVmZoc0xoSUNrMm5qTGZSWk9wTnBPZUVSeUh2?=
 =?utf-8?B?VS9NMzRLVUlBcVo1MlFBR01oTTFuQkdjNVpUTTRRV3M3TWFRZy9rQzdSTm55?=
 =?utf-8?B?MFNoT0xrYjNOWGRMUlpLSWNSSFFEMEJITzc1bUhjOHlSSFRZcDI1NzN6cllU?=
 =?utf-8?B?YzgwejJTeEl1UGl3Mlh2N2dRSTBUeWROZWhDdlE0NDNFMXQ1cWp6Vm9ETW5z?=
 =?utf-8?B?RHQvTS9RMXVJWE1VckxwMTBoZEM0MTAzYTUxbm00VUZjcE9xdmkwMEFmMTgz?=
 =?utf-8?B?eG9XclBqSHR5SXU5cGYxekdSek9MRUZ0OVlNRVh4Q1NsR2FMOUZxQlFOYnpL?=
 =?utf-8?B?QThHREcvR2xScmpFNDlNWmo2cWJKOFBMNlFwQkVRaGpDa29VbmNFNzlPVDd2?=
 =?utf-8?B?N3pQUjlqaFdBVlFESVBucTFJVTJiS1phMGkxM25XYW1hL0FGcXlHWVJsbXo1?=
 =?utf-8?B?UmtFeWg0SG1pYTNPaWVPTW4wVitka2VZcWJ2VFFuc29kQVJLTjREbllkbFFU?=
 =?utf-8?B?b0tRZzcxS3phWHdocyt0QkNJNTUwbXJFWW5CQzl0MHZFTW9WaGhXMFRTM0pn?=
 =?utf-8?B?M1luLzc0WEh2cE5ZOTBSU2J6elNldmxaRUg1OW8xcEVPZzBnWDZNTHZ5NXpE?=
 =?utf-8?Q?0ZgpkVkX1MLylXQO2aZmsGEqd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6E4328A508B7D4E9502B67E5A8E3B38@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: goeg.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4462.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c1f542-d3ef-402b-73fb-08de0fafb254
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 08:07:21.8436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoVj4ErzIPhnUPiY0WbL+KGrdSQgKqX+tGgbtYxO4wbrGQNhB02tXwTDl9InCp5x+4kWV1nJ+uYDGM7DrMzANw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6876

fHxTaG91bGRuJ3Qgcmxfc2V0X3Byb21wdCgiIikgYmUgY2FsbGVkIGZpcnN0IGFzIHN0YXRlZCBp
biB5b3VyIGludHJvDQooYW5kIHRoZSBsaW5rIHJlZmVyZW5jZWQpPw0KDQpJIG9ubHkgc2VlIF9f
Y29ubm1hbmN0bF9hZ2VudF9tb2RlIHNldHRpbmcgdGhlIHByb21wdCBhcyB3ZWxsLCBzbyBpZiB0
aGlzDQpmdW5jdGlvbiBpcyBub3QgY2FsbGVkIGJlZm9yZSwgdGhlcmUncyBzdGlsbCBhIHNhdmUg
d2l0aG91dCBhIHNldCBiZWZvcmU/DQoNCk9uIDE4LjEwLjI1IDIzOjI0LCBKdXN0aW4gQnJvbmRl
ciB3cm90ZToNCj4gUmVhZGxpbmUgOC4zIGNyYXNoZXMgd2hlbiBybF9zYXZlX3Byb21wdCgpIGlz
IGNhbGxlZCB3aXRob3V0DQo+IHJsX3NldF9wcm9tcHQoKSBiZWluZyBjYWxsZWQgZmlyc3QgWzFd
LiAgVGhpcyBtZWFucyB0aGF0IGludGVyYWN0aXZlDQo+IGNvbm5tYW5jdGwgaW1tZWRpYXRlbHkg
Y3Jhc2hlcyB1cG9uIGludm9jYXRpb24uIEFzIHdlJ3JlIGFib3V0IHRvIGNsZWFyDQo+IHRoZSBs
aW5lIGFueXdheXMsIHdlIGNhbiBqdXN0IHNldCB0aGUgYnVmZmVyIHRvIGFuIGVtcHR5IHN0cmlu
ZyBhcyB3ZWxsLg0KPg0KPiBBbHRlcm5hdGl2ZWx5LCBJIGJlbGlldmUgdGhhdCBib3RoIHJsX3Nl
dF9wcm9tcHQoKSBhbmQgcmxfcmVwbGFjZV9saW5lKCkNCj4gY291bGQgYmUgcmVwbGFjZWQgYnkg
YSBjYWxsIHRvIHJsX21lc3NhZ2UoIiIpIGJ1dCBJIGRvbid0IHdhbnQgdG8NCj4gZXhwYW5kIHRo
ZSBzY29wZSBvZiB0aGlzIHBhdGNoLg0KPg0KPiAxLiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL2J1Zy1yZWFkbGluZS8yMDI1LTA3L21zZzAwMDA3Lmh0bWwNCj4NCj4gU2lnbmVk
LW9mZi1ieTogSnVzdGluIEJyb25kZXIgPGpzYnJvbmRlckBjb2xkLWZyb250Lm9yZz4NCj4gLS0t
DQo+ICAgY2xpZW50L2lucHV0LmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2NsaWVudC9pbnB1dC5jIGIvY2xpZW50L2lucHV0LmMN
Cj4gaW5kZXggNzgzMTlmZjguLjI3YzI4MWQxIDEwMDY0NA0KPiAtLS0gYS9jbGllbnQvaW5wdXQu
Yw0KPiArKysgYi9jbGllbnQvaW5wdXQuYw0KPiBAQCAtNjIsNiArNjIsNyBAQCB2b2lkIF9fY29u
bm1hbmN0bF9zYXZlX3JsKHZvaWQpDQo+ICAgCQlzYXZlZF9wb2ludCA9IHJsX3BvaW50Ow0KPiAg
IAkJc2F2ZWRfbGluZSA9IHJsX2NvcHlfdGV4dCgwLCBybF9lbmQpOw0KPiAgIAkJcmxfc2F2ZV9w
cm9tcHQoKTsNCj4gKwkJcmxfc2V0X3Byb21wdCgiIik7DQo+ICAgCQlybF9yZXBsYWNlX2xpbmUo
IiIsIDApOw0KPiAgIAkJcmxfcmVkaXNwbGF5KCk7DQo+ICAgCX0NCg0KDQo=
