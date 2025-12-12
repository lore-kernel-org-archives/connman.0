Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538514B953
	for <connman@lists.linux.dev>; Fri, 12 Dec 2025 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765520882; cv=fail; b=QhGdQ+5BpvGjZ/cmR+zO3/djJbAykeUKl3VvF98LzfvUolOcPKg1/ndePXbWkA4Mqgg+ftm/KIH6oI4HoGZe89VXAzrKkDkS5IxaiS8cep1R4W2h3VrEuetM9Kr/X3ykRgjXIp7jKSjW4W9R+F31NyAFFneFp1CCEH0vDxelwhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765520882; c=relaxed/simple;
	bh=9HA9+ztsQkj/yASgMHdZK5MBltNotf6u2WV2j4ROf/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OVfNQaZiLsGMmAaQNA5vrmCD2FGXUPPzJHs/Q50nGy9z2A71QzPbJYWDcBnacdrjQtBF3siHTvInr+RBkBWiW/8j3+WuhPJsLtJ2g2HDcF378XPOQU4dv1d7X8jZUAZcbWyQ4ShnAqrcyedCEZI6VzVIGXXpj2gbiwrNTvRPjH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=BXBKvRiB; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="BXBKvRiB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ+FXLHyv+dM9DvDc4C7DlwNeXIq/Fv250OcZeJ1aGFF9Pdj5na4IOicEXHvIaGkG7Qx/Pke54eePzN89r5o+X1KGG8fGT46k0aAbt1TW3eQMtmgACRQj9brI43yO+gId41K041KkiJiM+Cbbm8T7tz68WdO3z6u7zDfr5XT4edU4m0C4S2UXZv4JnpVuM4XlrXbrl/z9f2cjC2jDdM1SMZzeD884KvOTfSOkFLzS4W5EpRdgNiRP+WVjXKSy0TY9YUk42VcCt9DAuLXgoF6xN8LsoCNBpda/Q0P8GUhNQX/JqctkBOGwuteFJFgNqdwTnmM4x6iz1OKO+4myz17gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33TAcZUshQ5FD4uWK9tLhxvfCUaqJuuOvHwtT9p2dWM=;
 b=fhv/b7pSbs6yliIhBL9p+5QliqjsISz06REflK91XHFILz7w0rXC1mEzAqZ23uohBSfBuGUt5Djp+WiK5mKnGQSZa3mylCR6+p8VIPcdL+lRFjyyhkXTZmjp8m3fSrki4c40cQYAJ13vSlGQOstXFWZsKNAyOTBcWqOd1VojL5YJbC397gqe/fVB044yuuwXbZJWprwOlAMJmhd/sVFsln9Sd3GYhds8iLvmyQADRZeTWp+a4gZXezLcCURdz5HzI13yfQHcUCdxyijJSGcLlCpl5Oe41J/jTS3Cye3gjfWZzB2QyIWNhsLeKE+N6E7M27ZZ8pyvGHEGIHKLXS2DUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33TAcZUshQ5FD4uWK9tLhxvfCUaqJuuOvHwtT9p2dWM=;
 b=BXBKvRiBpsAatmFur+e+ejakjJPH7X+pY2097x/Ov41fRrpY9ThijQHQGRNzJVNGF7PJzYLcy7EJ3tWY0l0FBQEngESJG1ObYGWiJ9sbRZ7GgZlA1pdawjOGKqabI6eMdDE7AHA7ZPU5DHk209DvvHhwZFKztmO9tVW3AJiMgHxXsnjeHYKYKmAg0NsdHGbnwcCMaO21t26mM952/8GpnklIHPg2z0ygTidcr4bNU91mwn2XMPHEEXXYMK1O1+kjru9/YlotSB46ZSmffwPFd5WU+V9dlQa8z5MtfpTnX8fb1NI80ZUZ1Lblwc80nuYrZoEO7s+ASOAgahqduy/A0g==
Received: from PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:299::18)
 by GV1PR10MB6051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 06:27:56 +0000
Received: from PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5edc:fb04:e4ab:bde3]) by PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5edc:fb04:e4ab:bde3%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 06:27:56 +0000
From: "Chen Yaming (BSH GDE-EDSCD)" <Yaming.Chen@bshg.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: "Dembianny Sven (BSH GDE-EDSD7)" <Sven.Dembianny@bshg.com>
Subject: Fix the crash issue when restarting the wpa_supplicant or wifi driver
 while BackgroundScanning is enable
Thread-Topic: Fix the crash issue when restarting the wpa_supplicant or wifi
 driver while BackgroundScanning is enable
Thread-Index: AdxrLUUsPoDeAB9qTIOEHDIxJ5ZvYgAAvjtA
Date: Fri, 12 Dec 2025 06:27:56 +0000
Message-ID:
 <PRAPR10MB5421DDB53D5BE922CBECB47B90AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
References:
 <PRAPR10MB5421CC811D1DDDF69E01283690AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <PRAPR10MB5421CC811D1DDDF69E01283690AEA@PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5421:EE_|GV1PR10MB6051:EE_
x-ms-office365-filtering-correlation-id: e08c1125-edb6-486e-73af-08de394796c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|4053099003|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?gb2312?B?dEI1dW9RQkRzRWZ2YjFEK3JCS1NEWHVwUFp5OXYrcUE3R2M0Q1FyR2FSR3o5?=
 =?gb2312?B?d3p1Nk02MUVVM1B0SFZ2Z0RncTExaUdWV0tDR1pkN2NzZjVTK3ZEcThhMGF3?=
 =?gb2312?B?ZWk2VzFTMTdSZ0RIZUx6RDRkQmhiUmRWekZuaXNEeC83aVh0eGpPSTFsOUlx?=
 =?gb2312?B?WXU3bE1wd3YvcGJ6WGVMSTlyTmZaYjR4djZZdEd6b1JQem8ySnhobUhtc0NH?=
 =?gb2312?B?eUtHRnBlcUJ5VUxTV1RUUmhJdHhxZWNnaFJYemlLSksvdkMwWjI0SWlIRmky?=
 =?gb2312?B?Ty8xcktHd25tZFBKWTdoOTZoQlVkS2pEamQ4OXR1TS9hek1Xa2V3VGIxMUNR?=
 =?gb2312?B?TXdERkYxZ0FsMnZvbHF4S0VUZ3ZtWEtJd0R5azR6S1dmczFVQi9IMkhFZWk4?=
 =?gb2312?B?bFdVcWk3S2dzMm5DTzk2K3VwWHRTMXJuWVdDTVBGakNDZDB3d2tnU2RsM1BU?=
 =?gb2312?B?UFJzT21pTldrWWxFanpIWG1mSC95ZnRCbExvbDdPMThvYmtYWm5LTzNyMlNL?=
 =?gb2312?B?R2wwNVBGN3RjV3lGMHcwdlpiWkxvSFk4Rzd3bXlTVEhxSlMwMGZidHNHZ3dB?=
 =?gb2312?B?cTRzVUE0MlJFM2g3amx1c1FUa3p3Q20vTlFBTlc4eTRibWNidXllN0lUTUFO?=
 =?gb2312?B?ZFNmS3g2eTdNRW1TSnJVZnRJNlptNW1QTWs1aFZhclVTeHhld2FyMG9Gb2Y4?=
 =?gb2312?B?K3V5ZEg3bEQzVXRIbVZHbE00WUc4ZEE0aUZnMlBlTG12clVsK2VneWZ5M2ZD?=
 =?gb2312?B?c0Nyb1hST1RTbEM4MUQrYmZPdWtZbUFzbTdHSndrUDYzZ2NUMG0zOVpSb0RT?=
 =?gb2312?B?OUVkYUVzcHRZV2ZBdEs4dXFnUUJMZ0JNTkUzeTVtWXNua0pVcVdtbllRM09r?=
 =?gb2312?B?eXFibHg5b0IwZGNZUGVLMGVaWEhnOStaZEVadzFGdy9KQzhPWVA2VnFaS0Y3?=
 =?gb2312?B?M2FGcE1BbmdGaEhHQ0ZTa2p5bjN3TzM3L0I3NzNoZmpRTDdQbWFGZTloQytC?=
 =?gb2312?B?N3NqWTh1cE1xTUQ1c3BXcFl3RUViRTk2NEx0ZXV6cVRTVFdhazMvNG5HMFZt?=
 =?gb2312?B?UGJvU1hvZ0VYU2JiaDQrTitERWZNODIxb3NBODhtV3k2VEYxeXVKYTVkdUlm?=
 =?gb2312?B?elptYVEwRElmV1JhOFMxODNscGUvNEV5ZkxGZUxneFBXRFJuY0VvQXBiMHVv?=
 =?gb2312?B?UDl1WDladE1WbjdRZnJ1Y2dSMTg1NzladFpMZzhxSXFkZHdIR2o5TXh1VVpJ?=
 =?gb2312?B?Ymk2d1JMeUdFZmZKL0ZVU0wvZURBWTI3eHIvbDk0WkFLQmxYajVUZ2lyUWEz?=
 =?gb2312?B?R1QraFYxTDZ1Q2V5ay9sOVRUY3RZU01OSGVydDlFdERoSFdMa0pIZ2ZES0JB?=
 =?gb2312?B?Vno4c3l1cW9mK21BWEY5alFQVmNJYWdkOVh1cGFVVmtZdHRrOXFWelpxQ1ht?=
 =?gb2312?B?ajRQbHZua2NCbE5CUmNrNmVaOWI3akhUTTQra1NDLzBnWWU1ZVpsOXpxcldp?=
 =?gb2312?B?aTRWdE5nTzhtYTlEN2l3eG1WYnJSOCt6aVN6cENPRk45cWg5Y2M0R05yaFV5?=
 =?gb2312?B?aHZkUU1QTU9mVnN1Z0JrOElnUGRhT2dUS1hrL2d1K3FBOGtreGpXUTNWTFAv?=
 =?gb2312?B?ZHJtS3VsWE9SM21qK012d0xheEErdytwZkFmZkM2elNQOU1HUm8yK3V3Mnpo?=
 =?gb2312?B?WW9MaWZRL045ZzlXclVpd29mUWZ5WjJ2ZkVYNG1wQXJ1WUtkMjlJNFNsK3dp?=
 =?gb2312?B?dXpGNElKdHRVdVlZSHFCWkN5bEowSWg4RGZ4SmJ2dmoxay8zVFlrbUNPL0N2?=
 =?gb2312?B?RVM2cmNSL0t2QUY3WW1qUFZ2c3hFcStsejJWYTc1TDR0OXNuLzBMeSt6YmZr?=
 =?gb2312?B?UmNsZlVzWDBGaHI1N3F5YnVrVldNaWdyTW9oYnRqMUN4eXlic01vQ2dzVWwr?=
 =?gb2312?B?OFphK2hPdGlXc3BMMWt2ZTAzSGUzMEsxbDJtRkFBT0Vtc1VSaWJnenhidndW?=
 =?gb2312?B?anlZdDBRbWtFREI0Nm0zS2IwZ0VVeEgxVE9SaUMzbnhTcVN6NndnVUJCd0Ju?=
 =?gb2312?Q?sy4qYN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(4053099003)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZEpnbGJ1TTRMRVFNdGM3MXZqZTVseFpBUEN1WnlCeWhtSE0vOGZtakROM2R5?=
 =?gb2312?B?dnQ5enp5eVA1VSsrMkt5Q2EwcitUeHk3OXRSQjc2MG9MV0pCejF4emlodmNo?=
 =?gb2312?B?bytYNDhSSjdCN2R0b2d1YmFtS1QrQjEvdjRHTzFmRWFIUEtER3pDUTZDaVRX?=
 =?gb2312?B?ZUhpQmpFejRRaW03MmpKRmRqWjZFSkVUaFFSbGE0aVZoTkNsNXRrVXBRcDNN?=
 =?gb2312?B?WjhSMlV3Q3pGT3JEa28rYi85WGpzMTJ6aXo5NnNobUxkMWx3TlhQMFRGU0ND?=
 =?gb2312?B?TVRaVDNOTERaandZTHc1b0thMFprL29sK2orc0YwSkRvWkJsZmRiQURZL3Za?=
 =?gb2312?B?RnBlZWlpMHgvSktKV0dYbUpsdVVsbGMzRzMzakQ3MkdBRWdBWFRya25TeWlt?=
 =?gb2312?B?Q0g3Tld6NlNUNXRkWHRTbkozSXhxbXZkQ0RTRUFUS2Z6ZUI1NS84MmVzQnRC?=
 =?gb2312?B?VXhMZnh5L2lYSUFjTVAwbmRhNVlTQXBJd2Q5TmdYNjR6VmVmazFnaDhRRHQw?=
 =?gb2312?B?TkhZMXZBMjM0cmJoVTZqOFM5VWtmL2J5MGV6RnRBNlc0V0ZVQkVXUDRreE1m?=
 =?gb2312?B?bkZHdThQdnZ4RlZHTHI2NU90eWI3NUlWRVpscWhoK1RuaVpVOW5yKzhGYUQr?=
 =?gb2312?B?NFdGeTFlbG4xNld5SGxqUnREZnF6TDRrWHZ3UHl1allvMzE4VzJoMklnMlN1?=
 =?gb2312?B?ekN5QitiUHdxWityeDk2bmpWMlhLdktKWSs3dUdmRGNUK3o2cW8rRUY3Y3cx?=
 =?gb2312?B?bElSa3h6Zk1LRFRqN2tkbGZOTG5TVm8vVkhzOFVKTmFjT1VFaW8xK29nRFpu?=
 =?gb2312?B?Rk5ESnUrSjVvSlFRVWViM0RSZVI2TzVKUUNiSVN4ekZubDFoOHMyMWVCc1A1?=
 =?gb2312?B?TEJBcWFVMEpNMk1KU284RWxMVCtVdU1ya2hnbTdWZVE1MGdHaEZZQ1lobkVj?=
 =?gb2312?B?Wkw2ZXFObzhjU2Fuckt2Y1U2NGhnTFBPK1d0akpKdWtYaTJiOTBWSFBjbUQx?=
 =?gb2312?B?OEcrT3Z4VGVZMWVURjBQZmFCMEhzK2w5ZEpTZzFjbFJBTzFiQXc3R2NXcDBp?=
 =?gb2312?B?bDh5VDhST1dwOU9JUHowZU9zRm45SEJkVWxaV1l5M1JVNG90WE9VMmZyM1dm?=
 =?gb2312?B?REFmMGJBMVFBWmNFTmQzMnJUNjR5R0lwTGFzaHZlT0p5TFFhWmdLRFpxNFFM?=
 =?gb2312?B?SHdNT1JxenlvSEJlMkR2ZlVCSDhGZ2FVYzkvcU9sUjZqSlQwUm5ZMkg0YnNr?=
 =?gb2312?B?SytXai9ZM0o0SFlyOVlnTXdkZHA2QzFRYWR4bzVDMGhjSDFMNHFMRE1oVWpW?=
 =?gb2312?B?MjJyVXFHbFhRVStWR05rbnZjc3pLMC9yVDdXTnpxRDg2dUZabG5JdFgwMFd5?=
 =?gb2312?B?TExOWVNCa3ZIWFlpVVJKdnFZb0xKcVpQaHpEN3VIT3crTVM3eXJBY3BMaUlj?=
 =?gb2312?B?dmpiUVVXTHhYZllLV2Z6NVNnT0hNNVhLSzZla0NockFtM050dGJEVUxFSDRF?=
 =?gb2312?B?OW9qNitSQkw4K3VRZ0xacXkzZnNnb1FuZWh5dVBSU1lOSVQ4SGhseXg1Y0Rw?=
 =?gb2312?B?VWxwckVhSDE3aFNwaHJJSVo0WDZEMGxSaHY4QWMvSFNxK0h2cjhEdXp5QWEz?=
 =?gb2312?B?M3VDZVR4ZW8weElKZGNmMzJ0Ujl1TDVPRUxwQnhQMW9Oak51bkZxUE4wdDgx?=
 =?gb2312?B?aE1ROEFMVzMrUW5TcEltQnNrRkJjZi94UVJ3bFlTcUp4UFd6bDNkUmJaTjln?=
 =?gb2312?B?aCtUL0VoWTZFTjZjeGVrMG9YV2N5bHBweGFwNkVVWlZyWHVPZTZ2OC8wd29K?=
 =?gb2312?B?OEVPTkpxVUdJczdqdEYydERxVEsrQzZaSm1HQXZtbVhyYVovbUNkOStPeGZa?=
 =?gb2312?B?N1dXU2RKb2gzNkM1djZLSzNGcTFpcDdJN1VWMlY2ay8xaTBJWmpaU0taK0pm?=
 =?gb2312?B?RXRCUEhVWlIrSUpCelFUNHpmY0g1WEJpWVRCRDBXRmN2YVpPWndJMnN1UlY2?=
 =?gb2312?B?RkNFZHRWZitYZEsxTjlRTUR4RDFFZFVtQlZvTnpHT0tSZk5TSXBnWktucU1C?=
 =?gb2312?B?aXVRY1JwU1FxZTV4eU5MMWZUTFc5ckxIY3pXcmhZQVlFZmNXVHFYK3AxTTgv?=
 =?gb2312?Q?7eos=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PRAPR10MB5421DDB53D5BE922CBECB47B90AEAPRAPR10MB5421EURP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5421.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e08c1125-edb6-486e-73af-08de394796c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 06:27:56.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkAy6KN+CKurGxYPC7111QxCG+UnBGe6bTR51coNJdSwEiZNgoKQWrylotlLbUtBFQ/wYPvSUBbJUB9ix9buZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6051

--_004_PRAPR10MB5421DDB53D5BE922CBECB47B90AEAPRAPR10MB5421EURP_
Content-Type: multipart/alternative;
	boundary="_000_PRAPR10MB5421DDB53D5BE922CBECB47B90AEAPRAPR10MB5421EURP_"

--_000_PRAPR10MB5421DDB53D5BE922CBECB47B90AEAPRAPR10MB5421EURP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8sIGNvbm1hbiB0ZWFtOg0KICAgICAgICAgICAgICBJIGFtIGEgc29mdHdhcmUgZGV2ZWxv
cG1lbnQgZW5naW5lZXIgb2YgQlNIIGNvbXBhbnkuIFdlIGhhdmUgZGlzY292ZXJlZCBhIGJ1ZyBp
biBvdXIgcHJvamVjdCB1c2luZyBjb25ubWFuLiBXaGVuIEJhY2tncm91bmRTY2FubmluZyBpcyBl
bmFibGUsIGlmIHRoZSB3aWZpIGRyaXZlciBvciB3cGFfc3VwcGxpY2FudCBpcyByZXN0YXJ0ZWQs
IGl0IHdpbGwgY2F1c2UgY29ubm1hbiBjcmFzaC4gVGhlIHBhcnNpbmcgb2YgdGhlIGNvcmUgZHVt
cCBwcmludCBjYWxsIHN0YWNrIHNob3dzIHRoZSBmb2xsb3dpbmc6DQoNCkNvcmUgd2FzIGdlbmVy
YXRlZCBieSBgL3Vzci9zYmluL2Nvbm5tYW5kIC0tbm9kbnNwcm94eSAtbicuDQpQcm9ncmFtIHRl
cm1pbmF0ZWQgd2l0aCBzaWduYWwgU0lHU0VHViwgU2VnbWVudGF0aW9uIGZhdWx0Lg0KIzAgYXV0
b3NjYW5fdGltZW91dCAoZGF0YT0weDE0NGJjMDApIGF0IC4uL2Nvbm5tYW4tMS40NC9wbHVnaW5z
L3dpZmkuYzoxMzgyDQoxMzgyIC4uL2Nvbm5tYW4tMS40NC9wbHVnaW5zL3dpZmkuYzogTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeS4NCihnZGIpIGJ0DQojMCBhdXRvc2Nhbl90aW1lb3V0IChkYXRh
PTB4MTQ0YmMwMCkgYXQgLi4vY29ubm1hbi0xLjQ0L3BsdWdpbnMvd2lmaS5jOjEzODINCiMxIDB4
NzZkMGY4YjQgaW4gPz8gKCkgZnJvbSAvdXNyL2xpYi9saWJnbGliLTIuMC5zby4wDQojMiAweDc2
ZDBlZmY2IGluIGdfbWFpbl9jb250ZXh0X2Rpc3BhdGNoICgpIGZyb20gL3Vzci9saWIvbGliZ2xp
Yi0yLjAuc28uMA0KIzMgMHg3NmQwZjI0YyBpbiA/PyAoKSBmcm9tIC91c3IvbGliL2xpYmdsaWIt
Mi4wLnNvLjANCiM0IDB4NzZkMGY0YTYgaW4gZ19tYWluX2xvb3BfcnVuICgpIGZyb20gL3Vzci9s
aWIvbGliZ2xpYi0yLjAuc28uMA0KIzUgMHgwMDAxZDEyNiBpbiBtYWluIChhcmdjPTxvcHRpbWl6
ZWQgb3V0PiwgYXJndj08b3B0aW1pemVkIG91dD4pIGF0IC4uL2Nvbm5tYW4tMS40NC9zcmMvbWFp
bi5jOjEyNTMNCg0KV2UgaGF2ZSBjcmVhdGVkIGEgcGF0Y2ggdG8gYXR0ZW1wdCB0byBmaXggdGhp
cyBpc3N1ZSwgcGxlYXNlIGhlbHAgZXZhbHVhdGUgYW5kIHJldmlldyBpdKOsdGhhbmtzo6GjoQ0K
DQoNCkJlc3QgcmVnYXJkc6Oho6ENCg0KDQoNCllhbWluZyBDaGVuDQpHREUtRURTQ0QNCg0KsqnO
97uqtefG96Oova3L1aOp09DP3rmry74sINbQufq9rcvVyqHEz76pytC+rbzDvLzK9b+qt6LH+NKi
0MK087XAMjA4usUgMjEwMDQ2DQrK1rv6o7oxOTk2MjAzMjc1MQ0KWWFtaW5nLkNoZW5AYnNoZy5j
b208bWFpbHRvOllhbWluZy5DaGVuQGJzaGcuY29tPg0KDQo=

--_000_PRAPR10MB5421DDB53D5BE922CBECB47B90AEAPRAPR10MB5421EURP_
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
span.EmailStyle19
	{mso-style-type:personal-reply;
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
<a href=3D"mailto:Yaming.Chen@bshg.com"><span style=3D"color:blue">Yaming.C=
hen@bshg.com</span></a></span>
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_PRAPR10MB5421DDB53D5BE922CBECB47B90AEAPRAPR10MB5421EURP_--

--_004_PRAPR10MB5421DDB53D5BE922CBECB47B90AEAPRAPR10MB5421EURP_
Content-Type: application/octet-stream;
	name="0001-wifi-Fix-the-crash-issue-when-restarting-the-wpa_supplicant-or-wifi-driver-while-background-scanning-enable.patch"
Content-Description:
 0001-wifi-Fix-the-crash-issue-when-restarting-the-wpa_supplicant-or-wifi-driver-while-background-scanning-enable.patch
Content-Disposition: attachment;
	filename="0001-wifi-Fix-the-crash-issue-when-restarting-the-wpa_supplicant-or-wifi-driver-while-background-scanning-enable.patch";
	size=2156; creation-date="Fri, 12 Dec 2025 06:27:06 GMT";
	modification-date="Fri, 12 Dec 2025 06:27:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ODAxZDAzYjE3MWU4ODdmNzZkNmFkOWE0ZjczYjdjNjVhMDM1NzE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAieWFtaW5nLmNoZW4iIDx5YW1pbmcuY2hlbkBic2hnLmNvbT4K
RGF0ZTogRnJpLCAxMiBEZWMgMjAyNSAxMzoyNDowOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHdp
Zmk6Rml4IHRoZSBjcmFzaCBpc3N1ZSB3aGVuIHJlc3RhcnRpbmcgdGhlIHdwYV9zdXBwbGljYW50
CiBvciB3aWZpIGRyaXZlciB3aGlsZSBCYWNrZ3JvdW5kU2Nhbm5pbmcgaXMgZW5hYmxlCgpJZiBC
YWNrZ3JvdW5kU2Nhbm5pbmcgaXMgZW5hYmxlLCBwYXNzaXZlIGF1dG8gc2Nhbm5pbmcgdGltZW91
dCB3b3JrIG5lZWQgdG8KYmUgcmVtb3ZlZCB3aGVuIGEgbmV3IGFjdGl2ZSBzY2FubmluZyBpcyB0
cmlnZ2VyZWQuQmVjYXVzZSB3aWZpLT5hdXRvc2NhbgphbmQgYXV0byBzY2FubmluZyB0aW1lb3V0
IHdvcmsgd2lsbCBiZSByZWNlYXRlZCBmb3IgbmV3IGFjdGl2ZSBzY2FubmluZywgYnV0Cm9sZCBw
YXNzaXZlIGF1dG8gc2Nhbm5pbmcgdGltZW91dCB3b3JrIGlzIHN0aWxsIHJ1bm5pbmcsIGlmIHdp
ZmkgZmlybXdhcmUgb3IKd3BhX3N1cHBsaWNhbnQgaXMgcmVzdGFydGVkIGF0IHNvbWUgdGltZSBp
biB0aGUgZnV0dXJlLCBvbGQgd2lmaSBhbmQgYXV0b3NjYW4Kb2JqZWN0cyBwb2ludGVycyB3aWxs
IGJlIGZyZWVkLCBzbyB3aWZpIGFuZCB3aWZpLT5hdXRvc2NhbiBvYmplY3RzIHBvaW50ZXJzIHdp
bGwKYmUgZGFuZ2xpbmcgcG9pbnRlcnMgd2hlbiB0aGUgdGltZW91dCBoYW5kbGVyIGZ1bmN0aW9u
IG9mIG9sZCBwYXNzaXZlIHNjYW5uaW5nCndvcmsgd2lsbCBvYnRhaW4gd2lmaSBhbmQgd2lmaS0+
YXV0b3NjYW4gb2JqZWN0cywgaXQgd2lsbCB0cmlnZ2VyIGEgY3Jhc2ggb2YgY29ubm1hbi4KLS0t
CiBwbHVnaW5zL3dpZmkuYyB8IDE1ICsrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9wbHVnaW5zL3dpZmkuYyBiL3BsdWdpbnMvd2lm
aS5jCmluZGV4IDEyMzg5ZmE2Li5kNDgzNDVhZCAxMDA2NDQKLS0tIGEvcGx1Z2lucy93aWZpLmMK
KysrIGIvcGx1Z2lucy93aWZpLmMKQEAgLTE5OTksNiArMTk5OSwyMSBAQCBzdGF0aWMgaW50IHdp
Zmlfc2NhbihzdHJ1Y3QgY29ubm1hbl9kZXZpY2UgKmRldmljZSwKIAkJfQogCX0KIAorCS8qCisJ
ICogSWYgQmFja2dyb3VuZFNjYW5uaW5nIGlzIGVuYWJsZSwgcGFzc2l2ZSBhdXRvIHNjYW5uaW5n
IHRpbWVvdXQgd29yayBuZWVkIHRvCisJICogYmUgcmVtb3ZlZCB3aGVuIGEgbmV3IGFjdGl2ZSBz
Y2FubmluZyBpcyB0cmlnZ2VyZWQuQmVjYXVzZSB3aWZpLT5hdXRvc2NhbgorCSAqIGFuZCBhdXRv
IHNjYW5uaW5nIHRpbWVvdXQgd29yayB3aWxsIGJlIHJlY2VhdGVkIGZvciBuZXcgYWN0aXZlIHNj
YW5uaW5nLCBidXQKKwkgKiBvbGQgcGFzc2l2ZSBhdXRvIHNjYW5uaW5nIHRpbWVvdXQgd29yayBp
cyBzdGlsbCBydW5uaW5nLCBpZiB3aWZpIGZpcm13YXJlIG9yCisJICogd3BhX3N1cHBsaWNhbnQg
aXMgcmVzdGFydGVkIGF0IHNvbWUgdGltZSBpbiB0aGUgZnV0dXJlLCBvbGQgd2lmaSBhbmQgYXV0
b3NjYW4KKwkgKiBvYmplY3RzIHBvaW50ZXJzIHdpbGwgYmUgZnJlZWQsIHNvIHdpZmkgYW5kIHdp
ZmktPmF1dG9zY2FuIG9iamVjdHMgcG9pbnRlcnMgd2lsbAorCSAqIGJlIGRhbmdsaW5nIHBvaW50
ZXJzIHdoZW4gdGhlIHRpbWVvdXQgaGFuZGxlciBmdW5jdGlvbiBvZiBvbGQgcGFzc2l2ZSBzY2Fu
bmluZworCSAqIHdvcmsgd2lsbCBvYnRhaW4gd2lmaSBhbmQgd2lmaS0+YXV0b3NjYW4gb2JqZWN0
cywgaXQgd2lsbCB0cmlnZ2VyIGEgY3Jhc2ggb2YgY29ubm1hbi4KKwkgKi8KKwlpZiAoY29ubm1h
bl9zZXR0aW5nX2dldF9ib29sKCJCYWNrZ3JvdW5kU2Nhbm5pbmciKSAmJgorCQkJCXdpZmktPnNj
YW5uaW5nX3R5cGUgPT0gV0lGSV9TQ0FOTklOR19QQVNTSVZFKSB7CisJCXJlc2V0X2F1dG9zY2Fu
KGRldmljZSk7CisJfQorCiAJLyogRGlzdGluZ3Vpc2ggYmV0d2VlbiBkZXZpY2VzIHBlcmZvcm1p
bmcgcGFzc2l2ZSBhbmQgYWN0aXZlIHNjYW5uaW5nICovCiAJd2lmaV91cGRhdGVfc2Nhbm5lcl90
eXBlKHdpZmksIFdJRklfU0NBTk5JTkdfQUNUSVZFKTsKIAotLSAKMi4zNC4xCgo=

--_004_PRAPR10MB5421DDB53D5BE922CBECB47B90AEAPRAPR10MB5421EURP_--
