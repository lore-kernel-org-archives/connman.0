Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBD28FFE7
	for <connman@lists.linux.dev>; Mon, 16 Feb 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253944; cv=fail; b=FsDbsC0oGlWIxlppUvqhHmLLdgKG49nEsGPbuqhSUCewOrw06sX1tHqIn21z12cWmabdDkPsEwMXygBb1I0lqPqxmFJA1Q7jGiANiNJA5ltImmU1/H/y1K7Vk2JcDi6U4MZ8/n8ZkKTuiKF/Ms7cBJ6QWs+jo8DsBWF8R5SoB1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253944; c=relaxed/simple;
	bh=CrA0xUT77FKhc1liX07T27l6ZcejQWRCGo4VM5/jZmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uhdK7kvCap04aidYaH7K2Vm+N+YQfeyqj+uGvdFWOIoD+3TOtgNQ0MrmEKrKyLAZVivaeIY/O/WwACIyJ+kuj3vugfQmYWLL/ud2XLMaFlj08VBuxTNMBGGQwWciSCQUpyfJ1sh0he9fXFZBklZRlDv028omRY23libOfXGiFT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=qwwXZMSN; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="qwwXZMSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNXBSo4IrK8O7OINLVPAXWbQWvyvSYQZRTnMOKd6hMFddzcYFkNciVNw0rev19b128nTwInmqxjzEZktWVBECyGmAy915frMBA7U1sB+yrFboPuCpCMxOWKzl5y0niNQKFGewOx7jgHdQHPQbHtp+0nhgBujvZAivgGtqOTEcRodRclif4N01wO3TYSn05n7yDoNJtpy8+208Y1e8a9fhhV4poFY26QJ9AqzyIUyTjBzlWmeeMuWOhlWq2wlpZkL1bnEQ5nIJGkv+Q2vtKzsGZufidHkS4Q7PBlr/HFagCNUdxbeLRhG5t+UbmtkGMcgO2foaKSAbcCy37zSva6t4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrA0xUT77FKhc1liX07T27l6ZcejQWRCGo4VM5/jZmI=;
 b=stwZFuloY66HVNs6IsXb2OI69Uijh4KXRDbMabLAAb+Y9xeh2P2uXHExGSBRaay5rQ/IB48A4ww6mqKtIYpJnekhAWI9ynagqurmRwlmAcyWdL9tH55idNLE7rEAKCsrAE7mn2YWer8MhFEhsdf/2Gsa5ClrDxIDbk16Yv82Wa9VFB2XUvE75z3mOS+bmb/1EBEmC0eAN29rNMry7VqdHCstAz1sSJVseWA0XqtQ2GbI/QqcDv8Eyfw0v9ujN9BoQzGrQKKwfYlT4tF6WsLD/PzvOGEPFQQkvI8fT0gSVACQ0TcJqXOsSYsTKDGTANQwgmcOQEWhLKEZDZf2UjIuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrA0xUT77FKhc1liX07T27l6ZcejQWRCGo4VM5/jZmI=;
 b=qwwXZMSN3FDpjlgHXpbRJH9rHQiyMZfdXBJuYSyUU7Gu3J9Fw9Htvqg3+fKvaYNXTh2TevhddiRUThijFaw1j/+PTq1uWEn58ZXSoKef5EqdNsODtIcjJrQhKG/+1Xtf1B5vSvKMYZZ/DaZlzSGt9pr4J0cdPdnHwBNY0k4fSnr89UT3RSibHvoZDYXolTi2tHClsJoHsJM9/apA9yLaOkerauvDcADhM0L1PmqZKvl6yn4APR1qKdYOyi08GfESpayRU7SKeRaXqaoiteBCuMaepYcOF/MUNnW24Zm3f1reF3Se6vxvV4A2CBTSkSkGp8Phqc1E6V1eW7uCztRFHg==
Received: from PRAPR10MB5399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:293::10)
 by GV1PR10MB6012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 14:59:00 +0000
Received: from PRAPR10MB5399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6b1:f214:bb4f:c469]) by PRAPR10MB5399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6b1:f214:bb4f:c469%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 14:59:00 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <Sven.Dembianny@bshg.com>
To: Christian Hewitt <christianshewitt@gmail.com>, "YAN Chao (BCSC/EPA2, Smart
 Home)" <Chao.YAN2@cn.bosch.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: AW: [PATCH] wifi: Detect invalid key with auth challenge failed
Thread-Topic: [PATCH] wifi: Detect invalid key with auth challenge failed
Thread-Index: AQHcj5W9gYKJkZYTTEmrgkFSiKNAkLWFh2Lw
Date: Mon, 16 Feb 2026 14:58:59 +0000
Message-ID:
 <PRAPR10MB5399445D6B9360DCE2466052F46CA@PRAPR10MB5399.EURPRD10.PROD.OUTLOOK.COM>
References: <20251215100431.1867291-1-chao.yan2@bosch.com>
 <4211481E-C2E9-4EF6-81D9-040AADE0B6EF@gmail.com>
In-Reply-To: <4211481E-C2E9-4EF6-81D9-040AADE0B6EF@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5399:EE_|GV1PR10MB6012:EE_
x-ms-office365-filtering-correlation-id: 390b716a-36c7-4617-c93b-08de6d6beabb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bklNMGxvRWNQSi9ZcnYwK1ZaWEFPaUhkZFdhdDNEU2FKbXVDVEk2RUFoOVUw?=
 =?utf-8?B?SXFmSGlmZHNaVjBiSjZrT2FsMXJmY2lMUjVpUHhkOEQ3eUVOS2MyWDJFY2tU?=
 =?utf-8?B?MlAyRkR4cU50cFNrQmFsZ2dpQmJid0FZS1hRQUxWeklEMWFKRmRYdStncjY1?=
 =?utf-8?B?eVpiS2JOdWFiWTZlQlZUd0VwK0xiK3pFTDVQeHljajdDdlIrR2Jidy9HVXN3?=
 =?utf-8?B?b2hnOXd5b2E4ZUM2MDJrengxTEN3WTh0NUE0bFVtaGxCeDBzbnZxSWlSQkFZ?=
 =?utf-8?B?MjBRbEJsTTBFendLNzc4UWRzdnJIOTJHNGdQN2NnNTkzK0dqS21lUkhRMzM4?=
 =?utf-8?B?dWwrS2VQaDl1Z2s2RXdlN3FGZXpja21XVmxTeWpicy9LYWVieUJKYzN6VXlM?=
 =?utf-8?B?U1dhWkUwUTQwVlJxU2h3WlF0d3B2SzYxek8raDNlUlZMV2tQMUpCMXR6b3do?=
 =?utf-8?B?VENyYXQxTk9DblJRYVFOR1EwVWVENjFDcmFRTlNuYWs5SkFLL2VxWXkwcFd3?=
 =?utf-8?B?M0FyWXVGRnlrajNCUjFkbHNMdWduMmh5anJ2YndkZ1F4SCtjSlhzNFpsZnlH?=
 =?utf-8?B?RldCeWJWRWFXMHRQdEtEQVpxSnM1SVdPK2NJRVluWjR1Ylc1eS92OFhpVFNC?=
 =?utf-8?B?WmNnTXVyUWplRStZZ1IzNjMrdCtWMmdYSkZxa3dRODVwZTB4ZXdkQTJtbGdO?=
 =?utf-8?B?cDliRlVHcFhQejNOd21nQUwrQXpZRzNWSnpYWW9tekh6K2szamJORU5jQkd6?=
 =?utf-8?B?dUZ6cldNblN3OWJ0YVRQRXpxU3I0aHVIRXZjQjRERnd4cEFhUDN5YzVmU0hq?=
 =?utf-8?B?NEh3MjZMM0lRQTdwNWU5S09hUkJveFRDYW85WUo5ZlZjcDNLN2VLZU9VZTB3?=
 =?utf-8?B?UmYwREJmc29tZSt6QXllUjV1NU5yY291N3RmZTJlWXVOZEJxUnpncUxESTZx?=
 =?utf-8?B?aHpVamliYUZXajQvQ1FjTlY4R3JCOFlSRFhSNnR4RWp5bGFqWEtoYXN5Nnli?=
 =?utf-8?B?cFZYODR1c1lXV1FBQTc2NDdrSEUza1BmVGU4VzR2cjZKMDFzQTNGTGNjQTha?=
 =?utf-8?B?MGJFNFRqclB5QWp6R2NYMmtXRUJ4dmtuQ3lGNC9ERzBab0NpVktuQkZSTmZR?=
 =?utf-8?B?alVkclBaT2l6K0F6UEhwVmJEUzR5WWkxKzVXbDlmTnRWNmpleG5VdkJPWVhD?=
 =?utf-8?B?TWlFbG9CQytEcmEvZ3pQbWc1VUk1SDBzanhrdlB5dEQ4R3hiWE0rQ1ExVlZS?=
 =?utf-8?B?WFU3MHJoTnZsV1J5SG9ueWluTzZxYkxZSkdxYisrU0VkaTg3VzNQVXpmS1NV?=
 =?utf-8?B?Z1QrNzN4bE5CYzhOOEtTOFFGamM0dktwMG56d2l5VVNtWGFWTU4raUpMaWpX?=
 =?utf-8?B?N1NEVTBNN1FCek9oMkdiWVA0dU5xVzk2WEJxTzN2dHppeE4xLzZ3V2dDMWYz?=
 =?utf-8?B?TklWZ2IzOURKRWgrNmFRNXNrazROYmsyWGJqdlJPNU9YWFpVV0E5OFlpNmxs?=
 =?utf-8?B?aUI4bUkwMDI3dG9oMEgzeGFoZUwwcVdnckUyRkhleGY5di93aUxCUTN6QzlH?=
 =?utf-8?B?ekV6MWNBNmFXMFhNMWV1TjN3Mjd5aVFpTFJVQVN5QXRyenYzQTUybnNCbUdi?=
 =?utf-8?B?UXlJNWw4ZXZBMURZUW1YRXdKcDlUZGhXVjNOUVo0ejhvV3JKNzBpR1U4djR2?=
 =?utf-8?B?T09XdWVFREZJMEtXeU1USGU5ZlhPRE5kY0Y0SVdOUGFMdlJFQkg2YnB0QnMx?=
 =?utf-8?B?ajBKYU1qc3Y1ZXhpa1h2VDA2am5QRythajV0bW8vbjMwcHNiUWcrbUxUcS84?=
 =?utf-8?B?amVrOU5TTXZVRFhlMFJ4ZkdaNkFsS0gvcXlUenQxZkxsTGRWc1lTU0tTVDBx?=
 =?utf-8?B?bU44NW9SOEYzUUt2OEFELytOT3lYWHd0UlVYTzdnbUNCNVlwRlZmNXl0OG0x?=
 =?utf-8?B?ZzF4RVFrTXJtWFVKNGZkbEhVdXd3blBrNjg2MTA4ZldxN2l0dkJ4eTM5dHVD?=
 =?utf-8?B?N0g3Z1ZJMEVGYTNTTVhYdW55dVd6Wi8xVWlwNEJVWGRINUZ0RXlqZ1V5eXJI?=
 =?utf-8?B?OE1iWU5veGhSRGYraTU1NWpMcDJCSHVXcEF1cjdFK0d2LzBEbW1zZzNteC8y?=
 =?utf-8?B?ekNVc3hPUDFyQ1NqSHRlSnBXVFZydXRCdVlZYUl3Y0ZUOWNvd01EVHhQNENq?=
 =?utf-8?Q?vrlVqoMMkDN1aQT+HjEvdNQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5399.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0xwcnhPR3pQV0NXNjVpWGVBb3MzUzFhblpYZHVFaFVtdHVHUzdyczdGeHBM?=
 =?utf-8?B?MFVmdjlzeFBGbWhLcEk3SzYyQjR0R3NPVGNBV3BBY2g0MStxZUJZc2dZOERs?=
 =?utf-8?B?dWp6VmhxKy9pbW91NlRobENhcGwvMmZWNTJ2cEVyb093bGQ2bmRiTitJQmVG?=
 =?utf-8?B?NTdjTjMrVytVTTFKWnBBRnpieGFlYjF6MVBZMGhlQ3lBVnFYVUNKQXMxODd2?=
 =?utf-8?B?K01XMk1nVTFKOTJ5UGluTW4rUXkwNGluNU9hVlpTUWppdDNqa1RGMlZoVGpN?=
 =?utf-8?B?d1orWm1reHEwT24yN0NwQ25CSHhHYm9aRHJ1VkZhZmY5N0RESmJBVGxKa1Bs?=
 =?utf-8?B?UUVsWEdXKzJYZmVhWW11L0FPWTQybGw5MEJpa3hOZHJWZExUZ1NDeWl3dTF5?=
 =?utf-8?B?RVJ6ZXo5ZHc0dlpWOFg1THQ2MmFDZThFSXRIWjZIVi9IVE1iZUpCMExKckZY?=
 =?utf-8?B?bC9ndlkxRWdzYjNCMHNEbTJNS05qRVI4NklhSkZabnE2S2h6eERsQktQU3Fj?=
 =?utf-8?B?ZjZRT0ZhZUh3K1VaeUJhazRwVDhOMmNna0FzYmVkVzRqbWU1dDhERVRwODRO?=
 =?utf-8?B?cnhuMUsxUVo2cisxT0RKa2N1dlpoQjNVRk10S2tRRjZRRUYydmR1ejg0ZENL?=
 =?utf-8?B?UEpMYnhlcWlHc0ZmVEFvYUFpWXBPc1VMY2paSjlUeTNTdG4wcnpaRXNsNTZn?=
 =?utf-8?B?dEQwblJJUWluRVEya3Vnb05pQkZpQzM4TE11bFB5WEQzY0hybXBZVWdEM0Ni?=
 =?utf-8?B?aUxHTUo2RW8ySGM3Rk5aOERGVnBIWXd1dm9WMDh2QUNFVlhXNVRjTFo4c3ll?=
 =?utf-8?B?SWk2RWg0aDNRVDNLc0RxUE5vMTZWRUo1MEdlTURCWUNUMk81RkZtNFlXR3Vt?=
 =?utf-8?B?V215MS9qdU9XWDFlcmU1M3U0T1p2dUlNNDVNN0hkWUtTVG4ycG5WV2dZZjFn?=
 =?utf-8?B?RTdJdHM2eUVBRGp0N0RDR1hrZ044bGJYdFJMOCsrNEhxUTZDMVBRMHVYWFBS?=
 =?utf-8?B?ZFprdFlNQnZCT25UYmJrcUI2RnhnaVo4bmFQMlQ0Sm92YUdwRFlSR2xWK1B5?=
 =?utf-8?B?WllMcFpuUytMU0JRRk4wclRVazVBTmloUWtPQXpmWm1XOEFQcTFWWTFzaExC?=
 =?utf-8?B?cURqVlFtc054Rm8zTW1qNW5sQW1SRU5QQ1l0dU5yRS9xdlZ4VGZqTjZKMzU4?=
 =?utf-8?B?T09nMm9xVXJpT2NmSzQ0d21yTnJYSzdDamwxendkT0l3SjRTZXBOVnhJUW1q?=
 =?utf-8?B?bE43cGUrdlgwOVFtZGVqaUx2UnNEbFBRTXpaSmRMVE9BSHhnWjh3L2FpaWJp?=
 =?utf-8?B?WlRUSmtvcmM1ZTI5R012UXo3V3FDVWloSHQ0T3BZZEszdjM5SjBoNVJ4bmlD?=
 =?utf-8?B?VklMcFprYUQ3c2dUVFVRNFhUc0JuZ0hUQnVEM0R1MytzWjNXWGxuS0hmSU9a?=
 =?utf-8?B?a3diYkFTS1d0UjBlczE0bzFJMEZVOTVESjJvTlJVV2s0THZLMTcyTFVsYkd3?=
 =?utf-8?B?UTNTY3krUFBPUU9jcFVhM3RaVmFIVi9pTWE5WEJvOVNXRy82R3dsK3EyeUd0?=
 =?utf-8?B?eXNKcGlUNzMwUUxWOE0zcmM3TXd3VUw3OGIxdWJDdW14RVZxZXArV2g3Rzlh?=
 =?utf-8?B?MU4zWDh5MGIwVUhpRldZZ1FYMC9vYnZNOWtpTDlGZERsb05pdHhXai9NVjRz?=
 =?utf-8?B?bjl5dnl2aWh6TTN6MU0yYWhvWmdOUUlMWGVsWHN6bzg2dmtpT3UybGFtMVJC?=
 =?utf-8?B?TzlPUEVGTkVRUXk4aUVUa0kxWitoSGlKMHA5NHpLaFJpQ0Juck5JaTdlbDFZ?=
 =?utf-8?B?dDVmWUk4M1cvOGNpTWxITnNGMHVnZXNiRms0UytMb2pnL2plU1g1ZlZZL0dE?=
 =?utf-8?B?VkZmQWwxbVFMNThhZmE2TWQwK200ZGlZSnpsSVNBTGVaU1NKaXBhSm1neVBk?=
 =?utf-8?B?dE5vM2J0Q20zcnR2S0VuVjNNa1ZTbFd4WEM1UzVFQjR0VkY5b3FXNnQ0d2dw?=
 =?utf-8?B?NFBuTkJZbFdOM2YxUUhhdVI1NWM2NGpzTUt2UzdGbXEyZGwxSzBpa0tVcGVB?=
 =?utf-8?B?VXhyVkprRlhuMDNpS1F6VjF2Z3J5T1NtV0gyWGxPaGZkOFZINVFDbDlJejFW?=
 =?utf-8?B?bEZEblZVcDRJSkkrYWl1VC9yYzNDMkZWZXVjN2xNR3o0Y1NPTmkybXZtaFhD?=
 =?utf-8?B?RnNHNnZVZ2JvOExpUmRUbkJGcTY3ZzdvVit2dW1aMVczd0JIZGE5SjNnYkFx?=
 =?utf-8?B?WkVTL203Y3pqR05FV0prclJxVUFLY1EwcnRUbjl5aDdXQnpoS1c1cXdwSVdu?=
 =?utf-8?Q?uQNCLtRie8m7fF0KiX?=
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
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5399.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 390b716a-36c7-4617-c93b-08de6d6beabb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 14:58:59.9709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOczP9mluqYhYjyE6csCQllYT/qTEsg2N78vLYMj8PGWo1/nkTPNV78kTTBUVttEoQ3Ku/3qNzCdWAgruaNPpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6012

SGkgQ2hyaXN0aWFuLA0KDQpzb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHksIHRha2luZyBvdmVyIHNp
bmNlIHRoZXJlIGlzIGN1cnJlbnRseSBDaGluZXNlIE5ldyBZZWFyLg0KDQo+IC0tLS0tVXJzcHLD
vG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NCj4gVm9uOiBDaHJpc3RpYW4gSGV3aXR0IDxjaHJpc3Rp
YW5zaGV3aXR0QGdtYWlsLmNvbT4NCj4gR2VzZW5kZXQ6IERpZW5zdGFnLCAyNy4gSmFudWFyIDIw
MjYgMTQ6NTYNCj4gQW46IFlBTiBDaGFvIChCQ1NDL0VQQTIsIFNtYXJ0IEhvbWUpIDxjaGFvLnlh
bjJAYm9zY2guY29tPg0KPiBDYzogY29ubm1hbkBsaXN0cy5saW51eC5kZXYNCj4gQmV0cmVmZjog
UmU6IFtQQVRDSF0gd2lmaTogRGV0ZWN0IGludmFsaWQga2V5IHdpdGggYXV0aCBjaGFsbGVuZ2Ug
ZmFpbGVkDQo+IA0KPiA+IE9uIDE1IERlYyAyMDI1LCBhdCAyOjA04oCvcG0sIFlBTiBDaGFvIChC
Q1NDL0VQQTIsIFNtYXJ0IEhvbWUpIDxjaGFvLnlhbjJAYm9zY2guY29tPiB3cm90ZToNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFlBTiBDaGFvIChCQ1NDL0VQQTIsIFNtYXJ0IEhvbWUpIDxjaGFv
LnlhbjJAYm9zY2guY29tPg0KPiANCj4gSGVsbG8gWWFuIENoYW8sDQo+IA0KPiBDYW4geW91IHBs
ZWFzZSBwcm92aWRlIGEgZGVzY3JpcHRpb24gb2YgdGhlIHByb2JsZW0gdGhhdCB0aGlzIHBhdGNo
IHNvbHZlcz8gLSBJ4oCZbSB3b25kZXJpbmcgaWYgaXQgaXMgdGhlDQo+IHNhbWUg4oCYaW52YWxp
ZC1rZXnigJkgZXJyb3IgdGhhdCB1c2VycyBvZiB0aGUgZGlzdHJvIEkgaGVscCBtYWludGFpbiAo
TGlicmVFTEVDKSBoYXZlIGJlZW4gcmVwb3J0aW5nIGZvciBhDQo+IGNvdXBsZSBvZiB5ZWFycy4g
SW4gb3VyIGRpc3RybyBpdCBzaG93cyB3aGVuIHVzaW5nIGNvbm5tYW4gYW5kIGl3ZCwgYnV0IG5v
dCB3aXRoIGNvbm5tYW4gYW5kDQo+IHdwYV9zdXBwbGljYW50LiBXZSBoYXZlIG5ldmVyIG1hbmFn
ZWQgdG8gcGlucG9pbnQvZmluZCB0aGUgcm9vdCBjYXVzZS4NCj4gDQpUaGUgcGF0Y2ggZml4ZXMg
aW5jb3JyZWN0IGhhbmRsaW5nIG9mIGEgcHJvdmlkZWQgaW52YWxpZCBrZXkgd2l0aCBXUEEzLCB0
byBiZSBhYmxlIHRvIGZvcndhcmQgdGhhdCBpbmZvIHRvDQp0aGUgdXNlci4NCkFTU09DX1NUQVRV
U19BVVRIX0NIQUxMRU5HRV9GQUlMRUQgcmV0dXJuZWQgZnJvbSBXaS1GaSBjaGlwIHdhcyBub3Qg
aGFuZGxlZCBwcmV2aW91c2x5Lg0KU28sIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyByZWxhdGVkIHRv
IHRoZSDCtGludmFsaWQta2V5wrQgZXJyb3IgcmVwb3J0ZWQsIHdoZXJlIGEgY29ycmVjdCBrZXkg
aXMgcHJvdmlkZWQgYnV0DQpyZXN1bHRzIGluIMK0aW52YWxpZC1rZXnCtC4NCg0KQmVzdCByZWdh
cmRzLCBTdmVuDQo+IENocmlzdGlhbg0KPiANCj4gPiAtLS0NCj4gPiBwbHVnaW5zL3dpZmkuYyB8
IDQgKysrLQ0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9wbHVnaW5zL3dpZmkuYyBiL3BsdWdpbnMvd2lmaS5j
IGluZGV4IDEyMzg5ZmEuLjU1MWE1ZmMNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9wbHVnaW5zL3dp
ZmkuYw0KPiA+ICsrKyBiL3BsdWdpbnMvd2lmaS5jDQo+ID4gQEAgLTc0LDYgKzc0LDcgQEANCj4g
PiAjZGVmaW5lIFAyUF9MSVNURU5fUEVSSU9EIDUwMA0KPiA+ICNkZWZpbmUgUDJQX0xJU1RFTl9J
TlRFUlZBTCAyMDAwDQo+ID4NCj4gPiArI2RlZmluZSBBU1NPQ19TVEFUVVNfQVVUSF9DSEFMTEVO
R0VfRkFJTEVEIDE1DQo+ID4gI2RlZmluZSBBU1NPQ19TVEFUVVNfQVVUSF9USU1FT1VUIDE2DQo+
ID4gI2RlZmluZSBBU1NPQ19TVEFUVVNfTk9fQ0xJRU5UIDE3DQo+ID4gI2RlZmluZSBMT0FEX1NI
QVBJTkdfTUFYX1JFVFJJRVMgMw0KPiA+IEBAIC0yNTA1LDcgKzI1MDYsOCBAQCBzdGF0aWMgYm9v
bA0KPiA+IGhhbmRsZV80d2F5X2hhbmRzaGFrZV9mYWlsdXJlKEdTdXBwbGljYW50SW50ZXJmYWNl
ICppbnRlcmZhY2UsDQo+ID4NCj4gPiBpZiAoKHdpZmktPnN0YXRlICE9IEdfU1VQUExJQ0FOVF9T
VEFURV80V0FZX0hBTkRTSEFLRSkgJiYNCj4gPiAhKCh3aWZpLT5zdGF0ZSA9PSBHX1NVUFBMSUNB
TlRfU1RBVEVfQVNTT0NJQVRJTkcpICYmDQo+ID4gLSAod2lmaS0+YXNzb2NfY29kZSA9PSBBU1NP
Q19TVEFUVVNfQVVUSF9USU1FT1VUKSkpDQo+ID4gKyAod2lmaS0+YXNzb2NfY29kZSA9PSBBU1NP
Q19TVEFUVVNfQVVUSF9USU1FT1VUIHx8DQo+ID4gKyAgICAgd2lmaS0+YXNzb2NfY29kZSA9PSBB
U1NPQ19TVEFUVVNfQVVUSF9DSEFMTEVOR0VfRkFJTEVEKSkpDQo+ID4gcmV0dXJuIGZhbHNlOw0K
PiA+DQo+ID4gaWYgKHdpZmktPmNvbm5lY3RlZCkNCj4gDQoNCg==
