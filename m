Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021143.outbound.protection.outlook.com [52.101.65.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB42F0C68
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076982; cv=fail; b=HgW6LmpZwNoKZvNppGdqgQqTqUXR1THxWWS+y3VN29nXOUj8dtMWb+gAVcNtlozr3BKhDkP1pIgryUx4dJbbhhoBm6/DzXA7TR6IX/f4Fh3GEgxdkoA3ECJPrKrXaINL+xPF7MpzAQphJLNeGnJV640j/CHh8t7Z3xPTzf7kSEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076982; c=relaxed/simple;
	bh=sSMKzexzEKhL8KA51FZqB0NwCv68zzL18Cn91I2z2YI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tuiUeDr1Hlk14WEC41xz3IIuCP8UU9kG9WwIdiLc0JjEJ7lVFuL6Ve7zfuCb7RP4gNOs+gk4sagDIKOT1kymYwe0m3LLWkQdbdBBIC4dxrA7RV3HRox/j6P7QmFdZpe9wihZGyJ6TnN8xTSSpeT8vhglEbybqYOnwZqRfTdOprM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=K6HnudPw; arc=fail smtp.client-ip=52.101.65.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="K6HnudPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsz9tJl9xSLd0HL0xNtaT2g0IZVfU3PizKGdQALVIT9MlQqAtPGHZnhDN3dYJb+2Q/Ze4Cq310onWbNkBHPTlJ123RmwunLQmZv1oiRoG2YoAzKstXb7e03+07ZlocHVZfhmteEjF9s6UTKwlicB+VzKJ2xdI6e4tg+ioDZJoD1SsE0TyXEE0anmsuBRfhpFC7A6/zOg+dEWxRy5UY/4zRL9f5rPU9LqGG9afW2n5hh9z8zBCzbYG2MXAq441svNRfG9E482zO1kTfonjIMRghbMRl9cAjQ2Pu1d4A2RaZIWoMvBie4g/ixRm+MnMaZTg6hLu7MC3FFJJkOg3TNaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYWqnbNP6BAl/8lkdCvKUJfuy9IToL1DQ97VAgHXFoE=;
 b=Wb56e70YgfAoCsNOh0Eoa1lc8koF53GtaJl6T8vgXixq27+1CPKlb9TEV6cNgA9c8EBIjuVqv148UIIikHTd5iXrXXSKUAAJz3z2h5Sc1mBqGPq2p8UkL4z7EeIvh9c79VFntpUTesj6oMdQLOnAvGWXH9b0W+ZasuI4HLK79h9RHCpgehq3gZzpKwJDHP5xdj+TxyFq9GgbKyGCFMxAcpvGvBKCdJBWMeMciPe73KzvhQ6boIFsxFKUYaBy7w/Kf7+VPw9quodgPpKn9WcVGMZvGB/pvgu18Q33xrEMZeuUV6N00fBZoLxYsQgTYPJAz7C/h97s8Yx5XZ3oslRS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYWqnbNP6BAl/8lkdCvKUJfuy9IToL1DQ97VAgHXFoE=;
 b=K6HnudPwNjGWKJ+AmSkIp7mQYHUwVJ9aU5NIn1+AfOykWpPyJt8U4+x1bnT7wMuduYpC80XEMqZU4seYYar4UZxaoEkFMQo/ohmRX0hI2E6Q41HT5jUEeCfz2AQbq40kQ/4RR3FjG6NL71VA7mldZunBKml7IxSJohFURv0Z7FTtq5wNhxitUwm8Trgvq7XIBG8s7fY6y9wQ4Ehs6ouosazAcFvpr3c1mg+duYh+1oajKSyE47x6vWL0w8AievR5edthL6R27gOZ0G51ueBrJtLB+SgaGWGKF+pIP9aZ96YZMEzOVe0uNxohExPL56qF2wEKAWxgjnprO2ZGnvmsRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by AS5PR06MB9019.eurprd06.prod.outlook.com (2603:10a6:20b:655::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 09:22:56 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 09:22:56 +0000
Message-ID: <1ee6719a-5cf0-44dc-8aa3-abbf83eaabb2@jolla.com>
Date: Wed, 13 Aug 2025 12:22:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/45] vpn: Add VPN agent use callback for plugins
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-10-jussi.laakkonen@jolla.com>
 <4810774e-ef89-4b55-a393-356ea8b78c20@gmail.com>
 <cd769d53-45c0-4b77-93a4-26afc74d5fa1@jolla.com>
 <67c4b880-4980-4c1d-a67a-a81b9941516c@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <67c4b880-4980-4c1d-a67a-a81b9941516c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0102CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::28) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|AS5PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: ca546f88-efb3-4b0f-d59d-08ddda4afcb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3VJbWJjQ09HVTFWV2p1c1JYc2x4SGR2QnNlTEZBNTJWV1UrRldsZE03N2RJ?=
 =?utf-8?B?R1JaczJWcnRORFdxQ283R1dnaEtydVl4NVhkZXROSWRNbUUvbUl6Qk42cFNG?=
 =?utf-8?B?bG0rT2dsbkg0cHQrSlNJeWtMNUxoMmRydWN5OFY5NlduSEJZMEN1MTQ4UlVv?=
 =?utf-8?B?VnhOZ1c1MnNmT2hGZ3MzTFFxV2RlTjZSVGx4YXdpZTBVTW82ZGUwa0RGOFBp?=
 =?utf-8?B?THZsbVd5OENGY2hxV1hIdHNzcnVnamplY1lBR3VaMmxyZko1VHNuS3VjNjNv?=
 =?utf-8?B?ZUtBRHUvVG13eXJZNXJraVc2TlJaK2NJM0FCYjltN0phOVpFYzRvd3kvQkFO?=
 =?utf-8?B?L3NjVVJ6bmhsK21jc29OSG1RMjRRWXdaU0VkR2ErcmtHaXozM2gzWS93Mk92?=
 =?utf-8?B?ZzVPemN0Sk1jZ056QW13U09BYzFuM3RTWnl2blVhTTJ0N0VBQVc3ZXNXRURw?=
 =?utf-8?B?RE9DVzgvUldaVnFVLytPemN0YWF0STF0Y3E0VWJUL0c0Q0dER0xlUmwvS3NH?=
 =?utf-8?B?SUk3Y1RRZC9oMUdYUHBKS1gvUmkwSm9pOFRtQnE4anBpU3haRUE1ZGFjU1hF?=
 =?utf-8?B?Y040T3NheXp6cGhPbURaQ2RuZXEwNS8vYkxYYi9QdGpHWnl6WW5vRXdVOUhk?=
 =?utf-8?B?TFUxdGFVWkVBbkh1Y21iam0rUXgzbDFDT2M2VTgwZWpzNXNERWRUQTE4ZnJZ?=
 =?utf-8?B?dkx1amdIZStOQysvTkhPWmpxOTJteGI4MmJuQVJURFhWcGR0VUZaRGtUYUQy?=
 =?utf-8?B?bm01enhyZVpGZ3B3dnBudGpOSGtDWDlHdkxSQkdhSnkxNit3OGFZU2lXT3VY?=
 =?utf-8?B?UE0rcDhPSThlV2VtZDhrMTFCRHlHZmwzVDRPelluTmxsNy8wWTkvOVNNQWxw?=
 =?utf-8?B?YkduUFh6VjRBM2tOUFpSdkdGRU4xak1EenVaNmlPb3NpZmxGK1BTVVpYbFVP?=
 =?utf-8?B?USs5RWJHNS9MSU9uajVabEpzNU1ibE1NVDVwN1ZZV2J6UllyQ3RKbk1HL240?=
 =?utf-8?B?ZVpoVmpHQkpOVElHSTJPNzBZZEZRYWJaSkNRZ2dHSHNEK1kxMU5hUGhOVXNp?=
 =?utf-8?B?OTg4d25Mb0JOZ1Z0N3RKaWpvMWJHd2l5QnFDQm5nMWpVaUlnQlZNWURzcEEx?=
 =?utf-8?B?V0h0d2RINnZHR054bEpuV0tJaFQ4ZC9sTnBpRzgxMkVINGd4YmE1OWp5NU5q?=
 =?utf-8?B?SFNRenNkWkkvYjhrMFhGNlNTaWNPRHdDeUxVRGwxWHEzeWh4WTM2akNjU3d2?=
 =?utf-8?B?OGpTZ1FxZVJ2NDRSRm5CdTc3TjVvVDhpNm9uSWQraUQ3cEdsZlVHbW4zVS8x?=
 =?utf-8?B?S01aTkpMR1hHWTRWbGd5NGtGQjdlMXg0VzZkWi9Xbk1QR2NGZmt0cVVqaUE0?=
 =?utf-8?B?WkpWWjJ3dzZTZXRleG0xRC9YRGVrNlQ2QS9aRzh4bWExUkpqMDZtWENrM1I2?=
 =?utf-8?B?V0YyazZkVHNxamF1ejFsMlBzMWE2bDBMUHJtN2Qxd0tMcVVYSTBEMkJRZkpH?=
 =?utf-8?B?azdiWlNkMksrem4xYm1DSG9vRDNld0x1THp0emFtNEsyc2h3NFFyL0k1UHFt?=
 =?utf-8?B?YzlLLzNaLzFpS1JWYTdCbDg0a1MycCt2Qm1lUGNzNllpNzdwdHVRWDNvc09P?=
 =?utf-8?B?dGRMRDc2V2ZjWlR6ckpWbDczV0JHMzFuV0Y0ZEE0Q0xlMzBVdXNmc3BpQzdI?=
 =?utf-8?B?NHZGa1Z0TUUyeEZiN3dhNkZ2T1g4SFNpSjZtRWUyclZzdnM5TUdLeXNMSGE5?=
 =?utf-8?B?eCs5LzBxNVh6dVpjWmdxVER6K3k5dkdLUlNKMzhLaGVPVzNUVzR6cG02eExk?=
 =?utf-8?B?b2g1RUN6S1dKcVI4SDYrd3ZLNmRoYnVVVGE0ZGxvMnVGaCt0N1ZCYWMwWDlB?=
 =?utf-8?B?OFE1WkZraDFROW5sbEwyWXV5blF0Y3pxUUNNdnFmMXlQVWpIWUVqbHlvOUpQ?=
 =?utf-8?Q?GOmf8LjkbOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzZveVRTSUl3djNUTkdmTHFsdWNEb3ZudVFjdHBIS1BZTmZUN280RThHQ2Zp?=
 =?utf-8?B?Snl6SmRLNFRhVFJuUXMyaGRTYUpFU01jcFdZaDVqRWpZRGJCU3RFck1jYzBj?=
 =?utf-8?B?NjVxdmJud211dWVXVGRnV1VHOExrbWwzazJBNGdjT2toMXhtT0w0NUROMjBH?=
 =?utf-8?B?OWtpTnp5Qmk4ZUFRZ1oyRWVNdzUzd1NNUzV5ZXVZZ1JCQWcrblhteUIvYWZs?=
 =?utf-8?B?N0R3REJvZjl2bWdBZzZ4UzlMdW5aQWlJdHhkVDhSa05BZ254ZEVPVzhKNTF5?=
 =?utf-8?B?VE12WjV6LzhqZ1FpNXM5b0duNEV4WXRxV2hQUTlqdjJ4WUFrWGhCalNVcHZZ?=
 =?utf-8?B?UUJiNWU2aFM3MTR3T2NoS3dGTVNTL1hJckM1ejNWbHNMS3dLaWVrMkFmVEpp?=
 =?utf-8?B?ZStGVzBiamlpYytkTFhqS005d1hUc3dxQ0VXTCt6KzVyZTZJTXB0S0FvYkRt?=
 =?utf-8?B?UzdiSmsxWVZWaWcvSmkrWWpxOFlrNkRnQzNwcGNoS2FySUhlSkM0QkVoaHM4?=
 =?utf-8?B?MmQ4M0RKMi9WUDdwQlU1MXFYMUc0eTY2RGpiUVdLR3BHc0phUVNORU9qNlps?=
 =?utf-8?B?b2sxNUpxM1YwenNiSWZ1R040STJXeThNZ1lHWlFhdFcyU0MwRXh6S2pNUk9n?=
 =?utf-8?B?NWE5SFFHcnd2emFOQkRUR1hFcEdzSWE5SGdOb3E0M1NQakJCQ3hYek5OUVAw?=
 =?utf-8?B?S0lEcTJ3ckxxcVlvbU54M0FLWlJxUVRBazFXelVaREJMK09PdnlGaFQ1QjJw?=
 =?utf-8?B?b3JqNzNCU2VtK203MFR0Z1BtSU9Hb2szcUpqQ2E3RXNsTnB5WW9hOWlyMEY3?=
 =?utf-8?B?OEFLaE43UVNjTk1LMzVjZkhGL21ZMFE1V1hTd284Qmo2dlV1MytJdXZobWVB?=
 =?utf-8?B?YTZ4TWYxTFBaNGpaZnRDdU84U2FmWGF4cVVlU2xmQTRyTThrWVF0d1h6dEpY?=
 =?utf-8?B?VUlTYklSMmNPK25BREJOSVY4MFZhYXJDcGFJYm0ydUk1U3ZWZUZNYk1TWFNj?=
 =?utf-8?B?UThONWs1Wjdmb21iN1p3cnpBYUVxZ25wQ29QREVtNEhhOVhMdVRMOHlIeDRn?=
 =?utf-8?B?RnhlWEpuMUZoeDQzanhaZzQ5c3ZYUWpsbURFUm5ld0laNVQxVHZtYVEzRXRE?=
 =?utf-8?B?OWhlaGNrdkJ2QVh5OTRtUlh1TFZYUzdhVTJBWFRMbDNZMDNxMjVGZkliaHhR?=
 =?utf-8?B?YUw2TmViR1l6RDFweFoyK25Pb2lxUlZVZGd0cXFnYmYwQ1dpRm5qdVBXQVF4?=
 =?utf-8?B?ZVAwTG9sREF5dEhrcHFCR2FNcjFrVHpRUnlhanR2RVN6YVVaRjFtVEc1RVM4?=
 =?utf-8?B?MnMzc2dxTEo5Q1drQlArRm1pVzNUWnFCT1Q1OFpPdytCNnRyM1k1VmVyUFVt?=
 =?utf-8?B?UUNSWEdzQW5JVE96Ny8xVkZQaURITEZEZ1hhejBVcGJROHBCdWdXNFZiTklu?=
 =?utf-8?B?OU0vZHNoT2pMTkRRRGthYnQ2Q2VsdVc0SzB4UldFVkFWQTRYNnVIQ3I3RWQ0?=
 =?utf-8?B?QU5BaThyUHdaVWpURVgrVG1mUWxIZkNnZUNoOUFzWjg4eGlFNGE0TW9ybW93?=
 =?utf-8?B?cGR0bGF2N3dnOFJtbjhITzZsYzZRay9VSFZsbVdUbXErSEIzQ0JTaDVNNm5N?=
 =?utf-8?B?bTlIaW4wOGNFNldsRGp6b1Vtc1dNbkczcUVGRjJwVFJOc0J0R1hnRnl5WURS?=
 =?utf-8?B?TUdTc2Q0YzhsMFdITE1MSmhTUmtJQjEwdktrK2dDRXhmQVlhZmViVlRIc09l?=
 =?utf-8?B?VXdOc3pBdHI5NVFjNVMzcFRwendpN2VJK0dkR1hHamdUMS95L0FzZnFxR2ds?=
 =?utf-8?B?Rkx3TWc4U2doOE5vMzdhU3ZoSDRzcHFCSjk1S0h0Unp4UzYyYzlhVHl5cVBz?=
 =?utf-8?B?bDUyRFd5WHlRd21Vd2RJOGlmZFkzalc1OHMwZEZiWVlld2psekh0T0h3cnRs?=
 =?utf-8?B?bnA1MDk2eHArc3ZZQklWWng0RHdvV2wraDNhWDZxT1MvWHdQdVFneGRCWkFw?=
 =?utf-8?B?TEJSSWdETmg3UldPOWhRN2xmQkRpcWF6UVMyVkU5aXBJWCtXeUR6citzYmRE?=
 =?utf-8?B?eldORFNZalFmemlaamlsVGNwcU9STGN1UWZHK1BHam5NL2x1dGFEMnlyS0xW?=
 =?utf-8?B?VzUzdmQ1Y2lETFpNcUlqOGpHTG5uUmdZcGszNTNPaHNrWmRIMVUwaDJvM2hj?=
 =?utf-8?B?YStKakJvS1FicXhaZUVEMmdYaGFxQ2dNQUdVOWZDRi9LeGlTMmdac3NIUjdr?=
 =?utf-8?B?eURhSkQyenpYKzVvckQrdjlVSW5BPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca546f88-efb3-4b0f-d59d-08ddda4afcb5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:22:56.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZGxqXnoYLivA7ETYMEH/xbIC7nur5PARiLwXo2JevPPD2q/PWm9p9+rnmWYpQpEDvjr88WWO3doTzWbqdrEjKegY/h0xyz4eTLt3GDkOh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB9019

Hi Denis,

On 8/8/25 18:57, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 8/8/25 7:28 AM, Jussi Laakkonen wrote:
>> Hi Denis,
>>
>> On 8/1/25 22:39, Denis Kenzior wrote:
>>> Hi Jussi,
>>>
>>> On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
>>>> Add callback that can be used by the VPN plugins to tell the vpn_driver
>>>> whether it uses VPN agent or not. Default to using VPN agent if the
>>>> function is not defined.
>>>>
>>>> This is done to accommodate the state transition in vpn-provider when
>>>> the VPN does not utilize VPN agent.
>>>
>>> What about the case where previous credentials are cached?
>>
>> This does not have anything to do with caching of credentials? It just 
>> makes it possible to tell if the plugin uses or does not use agent. If 
>> there are issues with caching it should be addressed elsewhere and in 
>> separate patch I think. Sorry for not really understanding what you 
>> mean now.
> 
> So maybe I didn't fully follow the logic, so apologies if that's the 
> case.  By my reading we have two possibilities:
> 
> 1. driver has to ask for credentials.  So when .connect is invoked, core 
> automatically puts the state into 'Association' and lets the driver 
> report back when the credentials are obtained.
> 2. driver will never ask for credentials.  Core automatically puts the 
> state into 'Association' and then 'Connecting' or whatever.
> 
> Are there situations where the driver might cache the credentials and 
> not ask for them again on subsequent connects?  The core could then 
> treat this as case 2 above.

The configuration for the VPNs are read by vpn-provider.c and that does 
not update them when the content changes on the file that was read. That 
is why using VPN agent is a better option as that can be made to handle 
the caching cases well, and the errors are reported back to the agent so 
it can clear them when they're invalid. This is how it works on Sailfish 
OS, so an external storage is used for them by the agent to make sure 
caching is not an issue. Thus, the implementation here should not take a 
stance on it.

Since WireGuard does get the credentials through vpn-provider.c I think 
this goes beyond this patch set and would require further work to 
address any caching issues. It is already blowing out of proportions now 
I think.

> 
> <snip>
> 
>>>
>>> The only user of this would seem to be wireguard which blankly 
>>> returns false. Can this be made into a boolean of a set of flags 
>>> instead?
>>
>> I simply followed the approach that is used by the VPNs in general. 
>> Seemed simplest and most readable way to do it.
> 
> Hmm, but we already have:
> 
> #define VPN_FLAG_NO_TUN     1
> #define VPN_FLAG_NO_DAEMON  2
> 
> Wouldn't this fit the existing pattern?
> 

Um, no. A daemonless VPN can have a VPN agent in use. I was planning to 
implement this for WireGuard too. But for now this minor change is a 
clear distinction between the cases of agent and no-agent from my 
perspective.

Br,
  Jussi

P.S. I'll send a v2 of this whole set as some changes required changing 
the commits here and there and I lost track of them, easier to put a new 
complete one to avoid problems.
