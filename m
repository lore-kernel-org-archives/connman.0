Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB3171CD
	for <connman@lists.linux.dev>; Tue, 13 May 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136540; cv=fail; b=JYrbWoBdPRyItrfx4bKvvVAegvN9NgcJG19SES3WhiazlpA7ZPzk2VJqjo5cvvs1yFoDIdJpAomHdyaYPkIB8OzEZTj4RA4+0F9cTJVfWlKL0eu2IKeKT+89kOUHPpcCVm7qhyjttpr+bnmgF2YJMnDveMqTQMpfiGemNo+tHf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136540; c=relaxed/simple;
	bh=zhQWZ7d9bacJpIwkMmLl9/HDqq1AplooACMAdxxzgmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQcV6CrMjwd/lkyDtk6BBBtuvd2dajePbVaKAbEgEEUKQzyK0cBVhLKyYK4b/Cv0Xs+xIMp0iwKpC0PgsHJV/M6hHXA8kwVo29NNpD+iv9Awhi//WS88TVvUbvqfvHIPbT7TGd7TJJpaIZBxlPqsgfptYWckMjwHCdF/D0LElDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=GmHrKxas; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="GmHrKxas"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La5sd/+/4Ff95xFl77uv7x8eDf82hicTn6tL+OgBbHfC+z36XGgMwzqLFempXiUec8ywfFS/pGwVX9a8OK4U3tglNwGvfi/Pa0tEODjni4L9d98RaVbLtf3eK7CqaXkhat059f9qQ6WYtzliob/okWodsh9kuoOxviSu2IjqRqqPZiGEMP6QcxsEoJvcBYBgI46RjXosi6FtD4vt65N+LOVQyNgKFGCDdK6Up0TxrZcTfXfEe01hv6oPefejP1vgaihadCEeTU5B8I0iVYiEv0Heu6LV//gdbztVMlu5j4HceRiL1B4oAV/kh+qFh6bDStys+1RSpHqfm4RNHyRxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhQWZ7d9bacJpIwkMmLl9/HDqq1AplooACMAdxxzgmM=;
 b=SIgdXBxSBwg+2XoFAwKyCPh0X1L+816lj0RhwWYEFYU4hfjlv4ZO46IBd9rYCOPa/uTaWsH1qp5sEw7LfNe1PJXZyFWC0/E0111iR3gDM1rD2Nm6MVhO83k7zUD8jNPIZrB+5EHZrdYOdbgUBohF40iXVdajBHuR03CH5nBOKlaeWaXjS32O4w9rewY/jfbZrXcv7ezwX7m1J23B5ITbCFAFIOLgeDJ2gMpZzMXnf+wFHmDwRcXtXOTWUrHWgKBChOTU/R43PWa46Q2GBgjUTHw9BQB5ZdFZDam9q8dOQMv+KlarW7ELmvHgaCrkregc27UDnh0Zvp7JzoUSvrtP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bshg.com; dmarc=pass action=none header.from=bshg.com;
 dkim=pass header.d=bshg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhQWZ7d9bacJpIwkMmLl9/HDqq1AplooACMAdxxzgmM=;
 b=GmHrKxas8irD2wVXBa5HlKuG35Eoj4TpNDArS9UWVa+Lho/hg9+e/UAz+FEGjiA9uow6+8V+k0Zc97MlboDzqHeX9senTjnzFVh7vHMmGm0RMUJm4DrpTHlR4yYFNICibhSQhVknIGvVuCASfBogEalxTe+L6Ml/pEK7AiO9V3u3bkmt3qRKTfFJ8Ag/qkbQsoklVjFcIWQm6DLCrZB18Yf9WGzKJLXZL4pk7alTYerQpOPx9Wa1p38rwp0vD5Z+7dqmMIf7q7mnRzA8i12rpraMEa6COkAWOxWU3SiRiSFVIBekXHWWcH5CSYvgnJMQybXIxgroTc4tJNHmKFNmhg==
Received: from AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::13)
 by DU0PR10MB7946.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 11:42:10 +0000
Received: from AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cb44:f613:f500:fba]) by AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cb44:f613:f500:fba%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 11:42:10 +0000
From: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
To: Denis Kenzior <denkenz@gmail.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
CC: "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>
Subject: AW: [PATCH] gsupplicant: MFP optional for WPA2-Personal
Thread-Topic: [PATCH] gsupplicant: MFP optional for WPA2-Personal
Thread-Index: AQHbwxs0RWXNun/thkK/Bl9SYBa5cbPPX+4AgADhZsA=
Date: Tue, 13 May 2025 11:42:10 +0000
Message-ID:
 <AS4PR10MB5575CAF121D8981792BD1B28F496A@AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM>
References: <20250512085223.411606-1-michael@amarulasolutions.com>
 <95264365-13b3-47bf-8443-078aab4082d6@gmail.com>
In-Reply-To: <95264365-13b3-47bf-8443-078aab4082d6@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bshg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5575:EE_|DU0PR10MB7946:EE_
x-ms-office365-filtering-correlation-id: 2dd6e762-70e2-4cdb-135c-08dd9213324d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2JEK0JwTFRrTkE3djkwY1VHNjlUcGZjdFlMUFEvZUQ5a1ZPWnM1OEFuNVVV?=
 =?utf-8?B?bm9YYjFPbkhLalZzR0xyMHRYT1FoMmhuWVhNOXVxWGVKRDh0a1VDZUVKdnhU?=
 =?utf-8?B?RG54ODlLZ1ZBdktZMTVydURaajY3NkxQTDhJbWlMZlNiWVJOY0hYVmpwRmUz?=
 =?utf-8?B?ai83ODRLcjY2ZUNWZXBTVUdEOStMRlBCOFVtZ0JpeWROa1JkYWIrQnJKQ3dP?=
 =?utf-8?B?THZEaXBoWHlCdURVZmU3Wm5PY0k4Qyt0ekJ3bzR2TVp0Q05FbTl6eW8rdGlD?=
 =?utf-8?B?QXJHeGZ4bXg3dkRTbUN6ME1zcTBpNzVIUmFhNURQM1pqd3AwRmtjc2F4ZXhR?=
 =?utf-8?B?b05IaFJLOWdMSzViOFVkNGdXOFhVc1VKK09kcVNyZE1UTGRrMGxtclRsZnBS?=
 =?utf-8?B?c2JGdTJ3ZmZDVjJ2ckVEQUZPZDlDTENIQnpKTkRMY0RibXBabzdlclhKbnVT?=
 =?utf-8?B?MDZoOW9pRHJ3QVVHVXJXRHhGeUt1VytqN1FuMGFRVHViWkkzc1U2aXBWMSsy?=
 =?utf-8?B?L1VRdU9INGh2WkN2K1hEb2Zwek01aWtJQk03aldFTDBjTEk1akZseFZaV1Z5?=
 =?utf-8?B?ajdZdVkrMGNvVm5IWllhT1ZQby9haEsrc01INnN6QTVJNldaTlFKL2hVNzdD?=
 =?utf-8?B?bzJkYXE5UFZZam5ZMzNrK3dMSXNnQ2RtcmFpWjFXWTNoa0cvY1BRS3k1VXdq?=
 =?utf-8?B?ekRpQWZPRE9XSnV3OGVoZ3JrSW84cXQvRW84RGEvNWQ2Q2ttR0xYbUQ2R3FQ?=
 =?utf-8?B?djkyWEN3V2tLcGNKQjRPNm9EOEdqQ1JRcW1QNEYzRlh1UXFZWldLOG82QkZl?=
 =?utf-8?B?WWhnWk5YN3RUTjFpc1NScS8yQUdkS2JndVlYejFnTzVUeldNRUVBV3l5RTdY?=
 =?utf-8?B?RGwzVDZhdHJLUFJWUmQ0eE9JWFpxZStjakhaeTlTOS9WT3lYQmRneklzT0hw?=
 =?utf-8?B?bklBZ3NTY3ppMUZnWnlqaHNpWXE2Ujd6NU9veEw4ZWduU3p2Q0pvdG92N3hH?=
 =?utf-8?B?QXRtb01LbUk1ZExnOVNXenAwQ1Jwd1Q0SlU1cm9QNVJueDlHUGdmd1g1eXp3?=
 =?utf-8?B?S3V1RmhONW5JaFVPUWpmSFVXSmIvdUJMR1d5UFdPc2JScmFVejVQekhTVmtp?=
 =?utf-8?B?MDQ5M0NkdzB5WjNqU1NHNVhNSEhSMW1RUUdqQXFyY25RNXFpa0RKdFV2dVlo?=
 =?utf-8?B?VFNVQkFPNEgrSzFIZVZtZ29EbW1CeXRUcmJ6NUpwQjNtNzZhcllZNjI5V3cr?=
 =?utf-8?B?NnVRdHRyVmlSWXdYbDVkbUFnTFBQZk5KMTd2REIrVXkySFk1a3MrZWVOVFJ4?=
 =?utf-8?B?bmV3Z1dDKzJ4L2pFTis4eHluQi9NaUN1VGpyZDlhYS9vQlRZbmh6Nk5Xa1VK?=
 =?utf-8?B?NjZKK3N5VFZ2dllTQXlSNWZpamhiZWRBYjVkdUIzaG9PN2RQRWpaSFhlR1NK?=
 =?utf-8?B?SmN2Z2hqeG5meWs5T1E1VDBLSHcwRW4zbFhRTDMxVEhrc2xBdWNTTWlJWlMv?=
 =?utf-8?B?dXQ3a2pwWkNQdy9xUnJrZ21JUFNBZGNIUkhWSWh4RC9yL2wybzQxTEhlMC9p?=
 =?utf-8?B?SlRoeWdZVUpRNllaV1dhMEZmREV3S0hXY21HRlpZSG4zYUhzSU9FekJKWmpa?=
 =?utf-8?B?QWpVem9oQWFFMUpKQ0E3Z081a2tIV0QwQzZXRDhTWXg1WFNwdnBwY1VxeUlk?=
 =?utf-8?B?bDE0ekU1WmVmZEZPTkhkVFFtcGdoQklUY1Jkc2RWU21ZL3ZXNzZZQk83b1h1?=
 =?utf-8?B?b25QVGgzeHhsMkFVUFdORFZXZVlwcDJWRThzUmNtVzZRRGFaUTlyeWVlNnhG?=
 =?utf-8?B?cmlWWnRpSk5Uc3V6ZTRUQ25KSFJ6OHh6aWNRMGtlenVxTTJaa1BxRXJlcUpJ?=
 =?utf-8?B?Z2U3eU8wbHdKUHFKa2lMcHVNblBYYmRVd25BL3hYaDJyTGorNmlEd2cydWVD?=
 =?utf-8?B?cnl1RUhrRllqN1BOQzR5ekZDbDd6ZHVpa1RaRnZWejlLMytLUVMzRHVQeHNE?=
 =?utf-8?B?K0lLc0ZLeER3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTFPWGI0SzRkWi9tWlYrS2pZKzVCTXFuRnZsaW9hQ0ZkWTUvSU9TNWFjbXZB?=
 =?utf-8?B?MnlWSmJ0VzZKemd4bnBWdndsNW5tMUxrNVlQeWtiTkJXSkZGVjNkdXYyMTFH?=
 =?utf-8?B?Y0NZbzdVd1dyNlhHNmQ4VEJkR1IvZGZUbVE2UFlkVlIzSWordlVmUEJLVDVT?=
 =?utf-8?B?Rnc0WDRTcDV2ZVg3cGUvbk8yb2cxOUpnWFJBZ0tFMkVudVd5RVN2VWJSanMy?=
 =?utf-8?B?bkpGcFRBMzJRYitsVHQ4aDBNTXZnSlpKYVJsZzBuMFNrRnVZSlpBeXBQblFY?=
 =?utf-8?B?NXE3bG9tV09EMDRlY1NpUHpwSHF0RVlBQzhPdjBjZ0NySDNZdlFnWHh5amU4?=
 =?utf-8?B?bVU0T0hReDJPZXN0TERqdjdzUkJQaFYrL3dOblV2VUY3MktELzZ5b05SL0Ux?=
 =?utf-8?B?R3pDU1cxak9Vb1pXZDU0ckZCNlEvU0ZJZStIMDJkc3k4Zm4zNGVoYW5uSjM3?=
 =?utf-8?B?Y2N5ZitwUldJbERvOWRTWEtDd0haMXpkUDFuc0hkTUdRd3JyY2JtUjdpc1Ro?=
 =?utf-8?B?UHNqS29kLzM2Q1FkVGNpL3NKU3h1Z3FFRTZIOVZlUEpBYmM1NXVwQ2RyaXBR?=
 =?utf-8?B?L2x0bndxWGVSMnhtRmhZYVlmQ1E4YkxJMkdZZ2UycDJQNWFBTXlOQmFqSXBn?=
 =?utf-8?B?YjVCakFlZnFjaHpxRC9CaGlVeTc3dmRtbXUxR1ZUdUQzeHBLSzNJZzRqTjhP?=
 =?utf-8?B?cEtWVGlFRlNBOVVMajVBSWdZTFdCUWQ3QWhxQXhBbHdickRIOC9hdm5jbWN6?=
 =?utf-8?B?bkZISTZEWFhwVEJmQlBYM1FhMVh3RmlnOWVRWERtUW1zcVRqSFBCUWkrSWNj?=
 =?utf-8?B?OGRXVXJZcWdsbnQxQmthYmZ2YllmZzRpYis1aHUyUldZcXJwOFN6R3BVMGdZ?=
 =?utf-8?B?TzJLc3diS1dDTHNpaDVNb2o4cnZqYk1qN3hXL3dZcFlyZlpWVmwyN0FZWFdK?=
 =?utf-8?B?dW8yL2oxMkpYVjhJbEJsL3czalE3d3Vlb2hDRUJGcXAwakxtUjhkZFZwM0xz?=
 =?utf-8?B?N20vQlpUK3J3NWJFM1dnYmhlb2VFT1paVTJhV0h1NXYrUWMzdndEM2xyUHRO?=
 =?utf-8?B?d3g2Uit4TkVwUTJzVVJrdDlnaFdVUXI0cFRHTFJ5UEVlVURQL2lNWW56Yysr?=
 =?utf-8?B?Z0V5akg5ZENSMVFhajhybTU4MW1UNFJxMGF1M3ZMUHRyV0VXbDNNWlBGTGNY?=
 =?utf-8?B?YnRPR3pldmhFNldXSjdoVGpIRldxQXNnN0JrbTZvcDVmRHZwWCsyalVobnov?=
 =?utf-8?B?V2p1WTROelNkRnd0YWRkRitybDNrK3I3dndqZTRBZUhMYjNJb3Nseko3eVFi?=
 =?utf-8?B?c1gwL3hTWDRTVFkzdHl6WlAwUjlPTTBDbmoxenpXRTNFTXUvWWxUYUl1YjlB?=
 =?utf-8?B?ZENRRkRHTzJ2Q2IxRTE1TURMdSszTjdlbFdUNW9QZnk3VnNjUnJrbkJZMmUx?=
 =?utf-8?B?UnZEZ1h6bFZZSWRKVDNwaEErZlpqOWtqWGIrRXVyVUVOemFlWEpzMkRBZUo4?=
 =?utf-8?B?YmV6Tm45MHB4dDR0QWR4SjBsa3BwVzBuck1IVDVWSm9rYk1tVUFxZ3pWYnkx?=
 =?utf-8?B?VjJHUjJQRVBkRjVGOGhnQU5mMUhuZit4TWpVcXNqa3d0SDlsSTJGSW1HeVlZ?=
 =?utf-8?B?NU1scjVpd1crbDNmUnRPL3NKdmFvZUE3RnpaeGZHWFBCT1NuYW9Hb0p1ZzNB?=
 =?utf-8?B?c1dtUC9zV2VWZnRZWHlmWXNNblB3WjFTZy9YUGlTS1IwbHJzeCtDM3RSdGRu?=
 =?utf-8?B?eXM1c1F5L2VpZlhReGRYcno3cVdjbzZyc21NaHZhS04xSVl3NU1RWHE1ZE13?=
 =?utf-8?B?R3J1cUpDSEF6ZWVzZTBTenFWQUQ4M2JXMmxkTWFIeUJoblUxVmlBak5TT05R?=
 =?utf-8?B?ci8xQ2FxUU9tb3N5UUR0MEV0Y2ZyMGV2dC9kSCtaaHRMRkpTd3gyKzZPU3lt?=
 =?utf-8?B?L3hMK3hvazVLZ0NMZlBQWjd2bTBMMzAxaEJvcTBJSkRnNkpHRzJMcUxMK3JE?=
 =?utf-8?B?Z2JLZW1BcGJzeEExMlVVZGt2QVAzMGxQT1pPNHYxTFJTaDVzUEhqc1E5Qy9P?=
 =?utf-8?B?VmV2dU0xUmYxRXcxVm5UamdMVmhaM01temp2ektnTG0vNDFWSnpjdzdPNkVS?=
 =?utf-8?Q?4rEM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd6e762-70e2-4cdb-135c-08dd9213324d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 11:42:10.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okW05vRf/TvRVJsjsiEBStwwdEiAgBi/8+5Y9y2mKkxAVAdm/JrtWa5pJdACysqrVOc3kLiZZKetiV5dgpFx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7946

SGkgRGVuaXMsDQoNCj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246
IERlbmlzIEtlbnppb3IgPGRlbmtlbnpAZ21haWwuY29tPg0KPiBHZXNlbmRldDogTW9udGFnLCAx
Mi4gTWFpIDIwMjUgMjE6MjINCj4gQW46IE1pY2hhZWwgVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1
bGFzb2x1dGlvbnMuY29tPjsgY29ubm1hbkBsaXN0cy5saW51eC5kZXYNCj4gQ2M6IGxpbnV4LWFt
YXJ1bGFAYW1hcnVsYXNvbHV0aW9ucy5jb207IERlbWJpYW5ueSBTdmVuIChCU0ggR0RFLUVEU0Q3
KQ0KPiA8c3Zlbi5kZW1iaWFubnlAYnNoZy5jb20+DQo+IEJldHJlZmY6IFJlOiBbUEFUQ0hdIGdz
dXBwbGljYW50OiBNRlAgb3B0aW9uYWwgZm9yIFdQQTItUGVyc29uYWwNCj4gDQo+IEhpIE1pY2hh
ZWwsDQo+IA0KPiBPbiA1LzEyLzI1IDM6NTIgQU0sIE1pY2hhZWwgVHJpbWFyY2hpIHdyb3RlOg0K
PiA+IEZyb206ICJEZW1iaWFubnksIFN2ZW4gKEdERS1FRFNENSkiIDxzdmVuLmRlbWJpYW5ueUBi
c2hnLmNvbT4NCj4gPg0KPiA+IFByZXZpb3VzIE1GUCBzdXBwb3J0IHdhcyByZXN0cmljdGVkIHRv
IFdQQTMsIGhvd2V2ZXIgaXQgaXMgYWxzbw0KPiA+IHBvc3NpYmxlIHRvIHNldCBNRlAgdG8gbWFu
ZGF0b3J5IG9uIEFQcyB3aXRoIFdQQTIuDQo+IA0KPiBZZXMsIGFzc3VtaW5nIHlvdXIgZGV2aWNl
IHN1cHBvcnRzIGl0LiAgQnV0IEknbSBub3QgcXVpdGUgc3VyZSBob3cgdGhpcyBkZXNjcmlwdGlv
biBjb3JyZXNwb25kcyB0byB0aGUNCj4gYWN0dWFsIHBhdGNoPyAgSXQgbG9va3MgbGlrZSB0aGUg
aW50ZW50IGlzIHRvIGFsd2F5cyBzZXQgaWVlZTgwMjExdz0xIChNRlAgQ2FwYWJsZSBzZXQsIE1G
UCBSZXF1aXJlZA0KPiBub3Qgc2V0KSB3aGljaCBlbmFibGVzIHRoZSB1c2Ugb2YgTUZQIGJ5IHdw
YV9zdXBwbGljYW50IGV2ZW4gb24gV1BBMiBuZXR3b3Jrcy4NCj4gDQpZZXMsIE1GUEMgaGFzdCB0
byBiZSBzZXQgYWx3YXlzIGFsc28gb24gV1BBMiBuZXR3b3JrcyBpbiB0ZXJtcyBvZiBzZWN1cml0
eSByZXF1aXJlbWVudHMgYnkgV0ZBLCBpbmRlcGVuZGVudCBmcm9tIEFQIGNvbmZpZ3VyYXRpb24u
DQpTZWUgIldpLUZpIENFUlRJRklFRCBQcm90ZWN0ZWQgTWFuYWdlbWVudCBGcmFtZXMgVGVzdCBQ
bGFuIHYxLjkucGRmIiwgMy4zLjIgIlNUQVVUIHJlcXVpcmVtZW50cyIuDQo+ID4NCj4gPiB3cGFf
c3VwcGxpY2FudCBjb25maWc6DQo+ID4NCj4gPiAqIFdQQTItUGVyc29uYWw6IGtleV9tZ210PSJX
UEEtUFNLLVNIQTI1NiIgOyBpZWU4MDIxMXc9MQ0KPiA+DQo+ID4gSXQgaXMgaW1wb3J0YW50IHRo
YXQgdGhlIGRlZmF1bHQgdmFsdWUgb2YgTUZQQyBiaXQgaXMgMSBvbiB0aGUgZmluYWwtY29tbWVy
Y2lhbA0KPiA+IHZlcnNpb24gb2YgdGhlIGRldmljZS4gSXQgaXMgYSBtYW5kYXRvcnkgV0ZBIHJl
cXVpcmVtZW50Lg0KPiANCj4gV2hpY2ggJ2RldmljZSc/ICBJIHRoaW5rIHlvdSBtYXkgYmUgcmVm
ZXJyaW5nIHRvIHNvbWV0aGluZyBzcGVjaWZpYyB0byB5b3VyIHVzZQ0KPiBjYXNlIGhlcmUuDQo+
IA0KU2VlIGFib3ZlIHN0YXRlbWVudCwgImRldmljZSIgd2FzIHJlZmVycmluZyB0byBhbnkgZGV2
aWNlIHVuZGVyIHRlc3QgZm9yIGN1cnJlbnQgV0ZBIGNlcnRpZmljYXRpb24uIA0KPiA+IC0tLQ0K
PiA+ICAgZ3N1cHBsaWNhbnQvc3VwcGxpY2FudC5jIHwgNiArKysrLS0NCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZ3N1cHBsaWNhbnQvc3VwcGxpY2FudC5jIGIvZ3N1cHBsaWNhbnQvc3VwcGxpY2FudC5j
DQo+ID4gaW5kZXggZjNiZTllN2IuLjJlYmZhMmM2IDEwMDY0NA0KPiA+IC0tLSBhL2dzdXBwbGlj
YW50L3N1cHBsaWNhbnQuYw0KPiA+ICsrKyBiL2dzdXBwbGljYW50L3N1cHBsaWNhbnQuYw0KPiA+
IEBAIC00OTU1LDYgKzQ5NTUsNyBAQCBzdGF0aWMgdm9pZCBhZGRfbmV0d29ya19zZWN1cml0eShE
QnVzTWVzc2FnZUl0ZXIgKmRpY3QsIEdTdXBwbGljYW50U1NJRA0KPiAqc3NpZCkNCj4gPiAgIAkJ
YWRkX25ldHdvcmtfc2VjdXJpdHlfY2lwaGVycyhkaWN0LCBzc2lkKTsNCj4gPiAgIAkJYnJlYWs7
DQo+ID4gICAJY2FzZSBHX1NVUFBMSUNBTlRfU0VDVVJJVFlfUFNLOg0KPiA+ICsJCWllZWU4MDIx
MXcgPSBHX1NVUFBMSUNBTlRfTUZQX09QVElPTkFMOw0KPiA+ICAgCQlpZiAoc3NpZC0+a2V5bWdt
dCAmIEdfU1VQUExJQ0FOVF9LRVlNR01UX1NBRSkgew0KPiANCj4gZG9jL2NvZGluZy1zdHlsZS50
eHQgaXRlbSBNMQ0KPiANCj4gPiAgIAkJCWlmIChzc2lkLT5rZXltZ210ICYgR19TVVBQTElDQU5U
X0tFWU1HTVRfV1BBX1BTSykgew0KPiA+ICAgCQkJCS8qDQo+ID4gQEAgLTQ5NjIsMTUgKzQ5NjMs
MTYgQEAgc3RhdGljIHZvaWQgYWRkX25ldHdvcmtfc2VjdXJpdHkoREJ1c01lc3NhZ2VJdGVyICpk
aWN0LA0KPiBHU3VwcGxpY2FudFNTSUQgKnNzaWQpDQo+ID4gICAJCQkJICogV1BBMi1QZXJzb25h
bCAoUFNLKSBhbmQgV1BBMy1QZXJzb25hbCAoU0FFKQ0KPiA+ICAgCQkJCSAqLw0KPiA+ICAgCQkJ
CWtleV9tZ210ID0gIlNBRSBXUEEtUFNLIjsNCj4gPiAtCQkJCWllZWU4MDIxMXcgPSBHX1NVUFBM
SUNBTlRfTUZQX09QVElPTkFMOw0KPiA+ICAgCQkJfSBlbHNlIHsNCj4gPiAgIAkJCQlrZXlfbWdt
dCA9ICJTQUUiOw0KPiA+ICAgCQkJCWllZWU4MDIxMXcgPSBHX1NVUFBMSUNBTlRfTUZQX1JFUVVJ
UkVEOw0KPiA+ICAgCQkJfQ0KPiA+IC0JCQlhZGRfbmV0d29ya19pZWVlODAyMTF3KGRpY3QsIHNz
aWQsIGllZWU4MDIxMXcpOw0KPiA+ICsJCX0gZWxzZSBpZiAoc3NpZC0+a2V5bWdtdCAmIEdfU1VQ
UExJQ0FOVF9LRVlNR01UX1dQQV9QU0tfMjU2KSB7DQo+ID4gKwkJCWtleV9tZ210ID0gIldQQS1Q
U0stU0hBMjU2IjsNCj4gDQo+IFRoaXMgcGFydCBzZWVtcyB0byBiZSB1bnJlbGF0ZWQgdG8gdGhl
IGNvbW1pdCBkZXNjcmlwdGlvbiBhbmQgaGFzIG5vdGhpbmcgdG8gZG8NCj4gd2l0aCBNRlA/ICBB
bHNvLCB5b3UgbWlnaHQgYWxzbyB3YW50IHRvIGVuYWJsZSBTSEEyNTYgaW4gV1BBMyBUcmFuc2l0
aW9uIG1vZGU/DQo+IA0KWW91IGFyZSByaWdodCwgbXkgQVAgY2hhbmdlZCBQU0sgdG8gUFNLLVNI
QTI1NiB3aGVuIHNldHRpbmcgTUZQQywgc28gdGhpcyBjaGFuZ2Ugd2FzIG5lZWRlZCB0byBiZSBh
YmxlIHRvIGNvbm5lY3QuIEkgd2lsbCBwcm92aWRlIGFuIHVwZGF0ZSBhbmQgYWRkICBQU0stU0hB
MjU2IGFsc28gaW4gV1BBMyBUcmFuc2l0aW9uIG1vZGUuDQo+ID4gICAJCX0gZWxzZSB7DQo+ID4g
ICAJCQlrZXlfbWdtdCA9ICJXUEEtUFNLIjsNCj4gPiAgIAkJfQ0KPiA+ICsJCWFkZF9uZXR3b3Jr
X2llZWU4MDIxMXcoZGljdCwgc3NpZCwgaWVlZTgwMjExdyk7DQo+IA0KPiBEaXR0byBpdGVtIE0x
Lg0KPiANCj4gPiAgIAkJYWRkX25ldHdvcmtfc2VjdXJpdHlfcHNrKGRpY3QsIHNzaWQpOw0KPiA+
ICAgCQlhZGRfbmV0d29ya19zZWN1cml0eV9jaXBoZXJzKGRpY3QsIHNzaWQpOw0KPiA+ICAgCQlh
ZGRfbmV0d29ya19zZWN1cml0eV9wcm90byhkaWN0LCBzc2lkKTsNCj4gDQo+IFJlZ2FyZHMsDQo+
IC1EZW5pcw0KQmVzdCByZWdhcmRzLCBTdmVuDQo=
