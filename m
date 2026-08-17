Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906D3E5A35
	for <connman@lists.linux.dev>; Mon, 17 Aug 2026 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961052; cv=fail; b=LYLB4YjMDoNbc8ZC3HuhtVEq2wDKZQa4HS0DNlTebmu9kmGJswR3/o/zcL3LokVcswqVa2sf4QQ1XF8oBfOljMkhEiEyUXV7W7/dM8450B6BEoy1rGi6kmYmhcZ8cbuzTPywjU8Qrh1BMFI9DukVcGibTtdnhrTJr+s22Qc+rbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961052; c=relaxed/simple;
	bh=rUbalfggGADvjmELceQDBQ1Pkz5RF4E/xOVAlEYn7j4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HukBCLuJcd2piufKsrDwx2JnvDkyM/HEqPBK5ZAoEOK1xAKs5GWrUor5ivuP1ocpp9Kd9fq580YYpfsISI/BP39ciPpqbTaVScsbaewXPBDBSzq1jd93YfmAKqh+nAKyTjH74UYEScRxTNQsEBt9EcomakNwO49disKqlxR34wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=YiLUO5eS; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="YiLUO5eS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZikIot9yo0ip/VB4wRbpBy+ngvSWVMHcZ1OUDCOPvwpXQrnRmurbqZu/NFvk3l3nyuNr/I+P5UP6Vcr9zWR+ow+ZI4WKkZmangP7qNFXjryzW9ArgI2YG+cLnYOy4eP2FrQlP1wdeNHqmdHOatwtEQ0Fm5mKxdtVzIYnHMss6tUisVWyfYYM6ZWqI39T3GCv5a1I9ZnTq1GU1JPhld83FZVFB4G4eYQm75mTQNx1QxRKEwWO9Iig/zGwB173XZJFlwnGwvlaF1Ll+TZfn7amXbPvdKaYp3NxzxVT/fgYPLtKNDiQ0WnkoFSgMV+1kFf2UdmxIFOGDJJ1y5PQFAgrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUbalfggGADvjmELceQDBQ1Pkz5RF4E/xOVAlEYn7j4=;
 b=YxDOpV3GCO/ZmeZ+IsiTBlgvtksDlb+RujVKsY+5ubOMWvT53MpO/p/RU95nWuZV5Tea8mRb8Sea5pwrkzMtYN98TCLEGJlur00+BijkEfeHKPBmLfm5BfAFlQfcwdcKxvB+a+O7812VsrxSPpU3wCwdCy5H3UfnADwnCvsbn4HF+gMqrsQBLfMaz/aiQfGS45GQHyBLDxRli27/GE7WNFVy6IAFyLvhGQzrcqzSSADzicW4QR7x0wLw40shhgSSHbs+ggQcfm/+TqqvwTYhSFP+WTloDsEJs24cewTbpE9uKP3CqaZhSL2OilPbZzrIgQ8W6jMWBv2DYZzP+JTP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUbalfggGADvjmELceQDBQ1Pkz5RF4E/xOVAlEYn7j4=;
 b=YiLUO5eSesDHeGcCrM+qPWoD5Yosa/q+JklNK6m35gBiIedBBthebI3rOJyxuewENaEpyPV393/eMTul1qsrfEkyZqr+OCeCLBziu8iJT5EtDsJjHbDUU/s9LhE4010UJkgcLLdisx7daeKZYp8dVYpzrnCKDIx5CyeKrthyRkx4waq/zqFAMavp/wcLMifkdD/F7a2Ix6TounYAo5LwZRLkgdChR/JvD/Ww5IWGWrL64s2NbNMnVceaES4tb+bMvmwYF2F9+InRpBWmQuFozpaxwYF0BesH8XLEL4nRvaTjaR7+Ujo59HuGxNra63CdVHzmsBVzlQDNspoXhVB61Q==
Received: from VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::13)
 by DU0PR10MB6439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:03:58 +0000
Received: from VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c595:d36a:295f:156d]) by VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c595:d36a:295f:156d%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 10:03:58 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
To: Waldemar Brodkorb <wbx@openadk.org>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	=?utf-8?B?RnJhbsOnb2lzIEdhbGVh?= <fgalea@free.fr>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
Subject: RE: Connection to a WPA2 Wi-Fi router fails
Thread-Topic: Connection to a WPA2 Wi-Fi router fails
Thread-Index:
 AQHc4e+1v6y0J6G1nEqVaCo5rDvA+rYKIKiAgAnZqhCAgdX8gIABh6owgAJSPICAAnUskIADFvwAgAMlORCAABHIAIAABZcw
Date: Mon, 17 Aug 2026 10:03:58 +0000
Message-ID:
 <VI0PR10MB8908036D7C21997D37011694F4A72@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <anghETbH2WzsZIJ9@waldemar-brodkorb.de>
 <VI0PR10MB8908D439894A87FDC9341D6EF4DE2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <antcGRBvImhKFSyu@waldemar-brodkorb.de>
 <VI0PR10MB8908254CA2980FEFA0F4A905F4DB2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <aoADapzQ-roTDzSP@waldemar-brodkorb.de>
 <VI0PR10MB89081958F1C9D72759AEEC8DF4A72@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <aoK1zI10OTh5TX7r@waldemar-brodkorb.de>
In-Reply-To: <aoK1zI10OTh5TX7r@waldemar-brodkorb.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR10MB8908:EE_|DU0PR10MB6439:EE_
x-ms-office365-filtering-correlation-id: 4a5d4133-566a-471f-a04c-08defc46db13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|3023799007|18002099003|22082099003|38070700021|11063799006|56012099006|4143699003|10067099003|6133799003|41080700001|15866825006;
x-microsoft-antispam-message-info:
 ZjwtU5b5joZA4EShS+PbEqBATsSu8QAhW3OW8BWWKtONMVBFMrJjtgt/vGbYJ/v1rZXXQEOVUQGfu8j0IIw05Z/KvFAHIxnDyB3wLlsXZoqK49LZHl0pBaclLpfDDsRguVDVy9eOOGZao0H+yaFoD7tWeutcDrD/OgvKJVewrRyRTu+gnl0cDhvuSke2WY7qBMhVYgoFB+ECgmmQUJiHg9PbKojTQV+RENiP6HxdqsKv6SxCCKzORMnbgt+Q7qk4DsZ5zYiCXm4S2BQbrZO6WpW6dJaq3BCacmGpCHBOXKnibxRYjijzvNxybSKB3wB77PFJP/aPNss2uan8zw0sOVrc3IwURcJdcM8BjvfCajlS6RuPnmUR0LhNVCBEYwzQMZCK1O3dVNd8ccZ0C6FqqrYP5T1KbyFa9rYxTK1wyZVbY/KnA6xo5P/WEIjQOy1OYLz/UVOtSf4Y7OAOPOwfuCTjEjyn2bWU66MM9xJaYlcq2GytnzqwjDPfOczteietzpNX2oMrP451v3FbEyaw8wVWxYKJQiWYOCqRsj6/te/4t8EhJfHPMWkDGnAvYqgMes2XxrRnxnq4XC298XAscL9nMBg8MnFzTCs6Dkxk6yb7ZO8hY72WngWmBJETbiWyylbS3Q84vlXDjIgzxcsNC7SZwHM54+TEbOGkFcM1sS3AwC9HqNuMoJ1dz5t18JQPGi20GziIpw5AnXp+wlIm3aR5P7RbV5b6OeS/E7fg7o0SY82wlCd1VelYYqkCv2etCJHuSbvQrfU+D36yTlnF9cnHNeRW9WERZcvSqSRMTCk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajVxaWhmK3dDR2dTNVVFWW9vY2ppdW1ab25XV0g1YWo5RWE3QVQwcWtrNk9W?=
 =?utf-8?B?UHRsRVdPVXlNcFRQcEwwaTFVR3NabFpSWkdYZWZXbVlYdys0NnBEanpLcmhn?=
 =?utf-8?B?ZDErdlVhaTh2VFNNcjNsMXlNRGZYcmRSc0IvKzVSTlgxU3luMFJLcExyd3F3?=
 =?utf-8?B?MlRaaksva3o4bHJPU3JCbUk1QzkxZGdFRDIvbnVPUXFpZTNiZUIrRnNpWkF2?=
 =?utf-8?B?UU1qb3hjc28xbzQwdGx0cXFwbEtDUmtPc3cxUnFBN2JhNW5RdDF4ZHNTamNE?=
 =?utf-8?B?SW1TS1RkVXZKWEhEWEd1RGJia2RYdjlXUW5KeFFOTUlvbFJVQ05NRE5kdXlh?=
 =?utf-8?B?Q1RtdGNiU09pMXVuS0Z6eGhBcnJLajBjN0JSa2xGOWg1cTd6VkpMM3ZnSklQ?=
 =?utf-8?B?UXh5VzJMR3RnT25hQk5XbDlYcStwVGI5MVFLci9rOGlBeEpQLzNHN1hFd1ls?=
 =?utf-8?B?WStkUk9sZmh4bGRqeFZqYkhXZzVxbTUwNG5VeUNDU3BRZHIvMEpyUWhsZ0xV?=
 =?utf-8?B?M3c4c2JxclM5TDNTeW5xN2NnbWtwc08vYVZURTVaRk5MYzl1ZFp4WS9YSnVa?=
 =?utf-8?B?TGV1R1NNcDFaTHJDTHVxSWdCRWFjOTgyRGU2cmJnbm5VWlJwbEh6bVF6aW5q?=
 =?utf-8?B?ZDhoZnEyRUpyeGpaRGt6UEx2dFl4SVJFQmltQzJMdlU5Mi9TdmZyVFdnYVhZ?=
 =?utf-8?B?aDY2Z3dkbjJWUisvU2M4b3pSdGE3VHl0b0Q2aG0vbUhaaStERWZJRXBuS0or?=
 =?utf-8?B?b29ncDR0SjBpTVlZU1c1dEMxSUhscHFvcGxwZmtTbXlPQkdZckhOS1M3K3pu?=
 =?utf-8?B?NjhISjZRWXBxeTRqQVpwcmlSSkVBT3YvalV1aFRCZDQwd0hWUi9vSzdpcVM5?=
 =?utf-8?B?N04vU2NTZE9zM1hmbGtpZXhZK2k3UEhxRmR1YlRFbHNFakF6V0xCNTdWbERS?=
 =?utf-8?B?NXJsZURvNk1PbnhmMytWQTJmeXUzaDBFbU9IdDBUN1pNNEhJWTZEOGZNNmUz?=
 =?utf-8?B?UXd6clZhMm1laGhpVmtxQ1lRbWRSSFRod3dvK2Z5akozK1NnTkZLZFFOTmZ4?=
 =?utf-8?B?VUsvV0tiSnlNRUJVTHZMQU4yMEZHTnA0RVdvR01aNzhPMkdBU3JvaFFIUnRx?=
 =?utf-8?B?b1RjTVpMYS9mSUhseUZRMWFockdvYlVXcnlDMGM0SVNzcTJCV20yMzNVMEM0?=
 =?utf-8?B?UUVlYWloREMxcThiU090aUlHNUE1R1hHdk13c3J6RlJkWk05cy9YWWQxSm9B?=
 =?utf-8?B?QWtHQXNhQ1hZSFJjRnJXNnF6T2pPdVErM0FycUZoSmZwQ0E5bC9aeDBWamdS?=
 =?utf-8?B?ZDFWb0FROHJIb1VabkxSWTBQa1BVSXA1U1FISnpYclYzWE53UlhRTWw0eHZj?=
 =?utf-8?B?MmJpaTNuN2RpckR6UFBCMEswL1B5TDQ1cWZITkptQ3hzNTBCYTZxUCtzYURO?=
 =?utf-8?B?TFl5SmhnbnlPbjEzVlo1bTRrVDVIOUNKcTA3cUFBL2Y5UWREd1NhMEF3Y202?=
 =?utf-8?B?Z3dtbnZnUmY2NmlBS1BId0VVd0ZTTWNrYlFCeDFHWjFmOUxSai9yRVVpZ2pa?=
 =?utf-8?B?UU5QYnhhNVI2d3h2TFZOaFJ4Z0g5ZUVzNHR4Q0xzRXYyL3dYTEdLc2I4dHpo?=
 =?utf-8?B?WWZtY3F6T2NvK0FZdFkrL010U1JuSXNTaHBtQnN1ZFppS04yVDJRaWpJekxQ?=
 =?utf-8?B?a0liMHpHejBsZDJQSnk2bkJuOGlPWXU5UVY5VWJWVm9FRnhPN01oS1QrV2hW?=
 =?utf-8?B?VjdhY1lKNlllLzdndDFVaFZFVXByVGkvcW8yd0hDbjZ5azFNTytuTjlPU1I4?=
 =?utf-8?B?dzBYb3N3TDdYZ3VKRE9NZDJJKzQwTGFTL0hjUmRoWmRxRitzTi9XWlFmb2Fp?=
 =?utf-8?B?VU5CbElIWVZSZVc4QjlRcVBvK3VXV2Jtc2lpZE1McFJOdmM4QkdTUVA0VjV0?=
 =?utf-8?B?UEo3cE1QZnlPT2F3QlVXUzhmTHlLVTkxN2FFc0JGeDJNVE45dEJBQnZKVVZ1?=
 =?utf-8?B?Mk1WQW9nbzF2WGRiZ01jbVpGblg2SFJxTGQ2S1krQUMzV2tROEYwaSs3cEF1?=
 =?utf-8?B?STJpLzVOZTNxNk54dUtleTl1Rm5RWE5raWhNTWE3eWdJNENiYzk2L3hkbFE0?=
 =?utf-8?B?dm5BblpPNzFqWHhBQm0xUFlBVTNRNWZqaW5MU3ZBalUrUWViUVI4NUtDdE9K?=
 =?utf-8?B?K1UrRmk2dXk2em1qb1lvUWNMRllBTkUvUklWWUJVL1hKejJMR1MvYkFXUHp4?=
 =?utf-8?B?amJ0OFlTOVZjM3pZRldydlp5cnJVZ2dLd2VrckxqMjZ0ODlUaWxnYjVGbkx2?=
 =?utf-8?Q?hasDa5/C+yphBeoSXN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5d4133-566a-471f-a04c-08defc46db13
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 10:03:58.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXTqkM2di4PN8TWponV9Ix9q3eq1qnO4pJ4HpFjD4jet9eiEGWtf1tX4XJPE+vUCnZTOaQ7SXHvu9EWvi7pSng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6439

SGkgV2FsZGVtYXIsDQoNCnllcywgbm93IHRoZXJlIGlzIGFuIGlkZWE6DQoNCllvdXIgZGV2aWNl
IGlzIHJ1bm5pbmcga2VybmVsIDYuMTguMzgsIGJ1dCB0aGUgb2ZmaWNpYWwgSW5maW5lb24NCnJl
bGVhc2UgZm9yIENZVzQzNDU1IHN1cHBvcnRzIG9ubHkgdXAgdG8ga2VybmVsIDYuNi4yMywgYXMg
ZmFyIGFzIEkgY2FuDQpzZWUgaGVyZToNCg0KaHR0cHM6Ly9jb21tdW5pdHkuaW5maW5lb24uY29t
L3Q1L0FJUk9DLVdpLUZpLWFuZC1XaS1GaS1CbHVldG9vdGgvDQpDeXByZXNzLUxpbnV4LVdpRmkt
RHJpdmVyLVJlbGVhc2UtRk1BQy0yMDI1LTA2LTMwL3RkLXAvMTA0Njk0MA0KDQpUaGF0IG1lYW5z
IHlvdSBhcmUgbWlzc2luZyBzb21lIHBhdGNoZXMgcmVxdWlyZWQgZm9yIHByb3BlciBXaS1GaQ0K
ZnVuY3Rpb25hbGl0eS4gSW4gcGFydGljdWxhciwgV1BBMy1yZWxhdGVkIHBhdGNoZXMgY291bGQg
Y2F1c2UgdGhlIGlzc3VlLA0KZm9yIGV4YW1wbGU6DQoNCjAwNTYtYnJjbWZtYWMtc3VwcG9ydC1l
eHRlcm5hbC1TQUUtYXV0aGVudGljYXRpb24taW4tc3RhdC5wYXRjaA0KMDA2Ny1icmNtZm1hYy1S
ZXZpc2UtY2hhbm5lbC1pbmZvLWZvci1XUEEzLWV4dGVybmFsLVNBRS5wYXRjaA0KMDA2OC1icmNt
Zm1hYy1GaXgtc3RydWN0dXJlLXNpemUtZm9yLVdQQTMtZXh0ZXJuYWwtU0FFLnBhdGNoDQowMDcz
LWJyY21mbWFjLWVuYWJsZS1wbWstY2FjaGluZy1mb3ItZXh0LXNhZS13cGEzLWFwLnBhdGNoDQoN
CkJlc3QgcmVnYXJkcywgU3Zlbg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBXYWxkZW1hciBCcm9ka29yYiA8d2J4QG9wZW5hZGsub3JnPg0KPiBTZW50OiBNb250YWcsIDE3
LiBBdWd1c3QgMjAyNiAwOToxOQ0KPiBUbzogRGVtYmlhbm55IFN2ZW4gKEJTSCBHREUtRURTRDcp
IDxzdmVuLmRlbWJpYW5ueUBic2hnLmNvbT4NCj4gQ2M6IFdhbGRlbWFyIEJyb2Rrb3JiIDx3YnhA
b3BlbmFkay5vcmc+OyBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkNCj4gPG1pY2hhZWxAYW1h
cnVsYXNvbHV0aW9ucy5jb20+OyBGcmFuw6dvaXMgR2FsZWEgPGZnYWxlYUBmcmVlLmZyPjsgY29u
bm1hbkBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IENvbm5lY3Rpb24gdG8gYSBXUEEy
IFdpLUZpIHJvdXRlciBmYWlscw0KPiANCj4gSGkgU3ZlbiwNCj4gDQo+IERlbWJpYW5ueSBTdmVu
IChCU0ggR0RFLUVEU0Q3KSB3cm90ZSwNCj4gDQo+ID4gSGkgV2FsZGVtYXIsDQo+ID4NCj4gPiBu
byBpZGVhIGF0IHRoZSBtb21lbnQsIGJ1dCB0aGlzIGxvb2tzIGxpa2UgYSBkaWZmZXJlbnQgaXNz
dWUsIHBvdGVudGlhbGx5IGFuIGluaXRpYWxpemF0aW9uLXJlbGF0ZWQgdG9waWMuDQo+IA0KPiBG
YWlyIGVub3VnaC4gSW4gdGhlIG1lYW53aGlsZSBJIHN3aXRjaGVkIGZyb20gQnVpbGRyb290IHRv
IE9wZW5BREsgKG15IG93biBlbWJlZGRlZCBzeXN0ZW0NCj4gYnVpbGRzeXN0ZW0pIGFuZCB3aXRo
IHRoYXQgSSBjYW4gcmVwcm9kdWNlIHRoZSBvcmlnaW5hbCBmYWlsdXJlLiBJIHdpbGwgaW52ZXN0
aWdhdGUgdGhlIEJ1aWxkcm9vdCBlcnJvciBsYXRlci4NCj4gDQo+IEF0dGFjaGVkIGlzIHRoZSBv
dXRwdXQgb2Ygd3BhX3N1cHBsaWNhbnQgb24gdGhlIGNvbnNvbGUsIHdoZW4gSSB0cnkgdG8gY29u
bmVjdCB0byBteSBXUEEyIFdMQU4NCj4gcm91dGVyLiB3bGFuMCBpcyB0aGUgaW50ZXJmYWNlLg0K
PiANCj4gQW55IGlkZWEgZm9yIHRoZSBvcmlnaW5hbCBpc3N1ZT8NCj4gDQo+IFRoZSBvbmx5IGVy
cm9yIEkgc2VlIGlzOg0KPiBMaW5lIDA6IGludmFsaWQga2V5X21nbXQgJ1NBRScNCj4gDQo+IGJl
c3QgcmVnYXJkcw0KPiAgV2FsZGVtYXINCg0K
