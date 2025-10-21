Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020137.outbound.protection.outlook.com [52.101.84.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A32279918
	for <connman@lists.linux.dev>; Tue, 21 Oct 2025 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031791; cv=fail; b=n2ggLQRSfO0MrV7bOVEAyS1XkIIXqdU/mdP//8yyxFX7LRTvkCyJEmBgFJ175R/yk2vA/VPGPQHHXFq7hG5M9AGDdVS9shCiRsO3UQN+NEfi/1lnihaO/Xr5HjkZfwOeGos2Ym949GyTKSoPcOeAaQiIwwYEKz5TxKWHRvPlU/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031791; c=relaxed/simple;
	bh=AgAdWplkd1vX7AmeaB+rqFw/hMRzrVO/l/hwYAmF0Ew=;
	h=From:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i46wO14lhG5C6IIwCHpLMtn1mKvNLuiihw1BiMYC41tJNoeYRD0qOWVGsZsmHrauX0pUYUxDeB7OVu3Fz/vG+nNMOapX6moNpW6gVlsaWJMpZbMmFANQui5/mMgp5YGZ3gtwxwf65LiIzZwSyTclocqc75EVV5ls/isryDcjV0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goeg.at; spf=pass smtp.mailfrom=goeg.at; dkim=pass (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b=D25WIoa9; arc=fail smtp.client-ip=52.101.84.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goeg.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goeg.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b="D25WIoa9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piD8jTRwzCLHqmDN00WPi56DQPli1WACZoB8N4KiEDHRE95f6pHd/IN6EjHayJ7HKZ55ejY5OLpMk5rJw59lCimY2zqBKNseDgmgK6aWo+crDMaE5uAnLFSksm2rCtgVJQIzkBi5kuBgg1S8hiCctDQL8Izar0dle6B/W5zhyQTOjYQt/EO10lwI+t0/7/vGT3haSY0ULuDX29Wu3kj8ze7smTN31QSLtsYSZJQa2oiMZW7m0Fn5Tz/cC/q+Yt1VtuZvt85Be/Yv2Er5j359TMs8k7A+xy245gGQH5gl0IBi/8Go7ET9HSzKy5eCjzu9BVjwrPF7HFBuVZUiRUynkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgAdWplkd1vX7AmeaB+rqFw/hMRzrVO/l/hwYAmF0Ew=;
 b=VDaArcjXHmpgojD7fg5NAbxisPfGRWjOWJtY5xnPrVEG8fdz11iyyQYw19LG8IrBCFcDKGIFTCBpdbCG+cseTWcvBeJOWxIxqBs1JnXZfR/KzIGKayarmhbMtqYd1ZvgoSW010S1lmsovwkSi5SS2uPxiXNRjetCLm5DvEvvw8DppQu6th2w+ylmOjpHwJvVj9ma3cOK44G/cLhGFCAvWe31zeHm5AmTGuaGbysz/eKkQQzjowfJ0MQtcj/Sh2UI1qiE4Yef8JHeGnJAG54MJEPqa0kb5hu3Yo83e+Rgy2MPGM9+VvHcKx1VwWr/Pv8lsj1g4tK6diuI/+68eIkgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgAdWplkd1vX7AmeaB+rqFw/hMRzrVO/l/hwYAmF0Ew=;
 b=D25WIoa9uhnwkotfdEB1iMIQLtw2cUkD1EXvpwoeKUDxhWBMXgQdlZNGoSiubfMNqJj+7FgQcEJKJdhezIkUq4a8IcORRFf1le3PKGWmuiyBU9dXATY+5GFLmGTTuJC7yqkiNkTxodDbYvop68lf2aPYbMgDw8Ywu/54C5qV6JY=
Received: from VI1PR09MB4462.eurprd09.prod.outlook.com (2603:10a6:800:153::15)
 by PAWPR09MB6690.eurprd09.prod.outlook.com (2603:10a6:102:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 07:29:41 +0000
Received: from VI1PR09MB4462.eurprd09.prod.outlook.com
 ([fe80::e395:88fb:63a7:122d]) by VI1PR09MB4462.eurprd09.prod.outlook.com
 ([fe80::e395:88fb:63a7:122d%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 07:29:40 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: client: set rl_prompt after saving
Thread-Topic: client: set rl_prompt after saving
Thread-Index: AQHcQekzQaPbkFEDIkyliyt04KEAhLTMNRiA
Date: Tue, 21 Oct 2025 07:29:40 +0000
Message-ID: <a4921897-6e04-43a0-9fc2-333d328d9ef1@goeg.at>
References: <20251018212411.181909-1-jsbronder@cold-front.org>
 <f9379940-6eef-4887-9efb-481663d0731c@goeg.at>
 <aPZ0-GeJWF-vb3xS@ravine.members.linode.com>
In-Reply-To: <aPZ0-GeJWF-vb3xS@ravine.members.linode.com>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB4462:EE_|PAWPR09MB6690:EE_
x-ms-office365-filtering-correlation-id: db223658-8f2f-4229-cd61-08de107398b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1QvUmluc0svL1Noa0Z4MDFsYW9FZmVYSlA4UGpnUmlOYlo5WlRiSU9pZmVj?=
 =?utf-8?B?MjQvTTRzRzdHdjd3UExxSzBBbCszOXFCbngreFcra0I5a2xhNk4zMGl1U01P?=
 =?utf-8?B?c21zY0FtbnpBSmlnQkxkMVdoL3dFcXNGdk5uT1U3WWNWVUdXbkRWVUt6Y2l5?=
 =?utf-8?B?SDJsTnNZWno1MkhqRStTSkc5aGF5L0VnWGdBdWJPWUFqY2wvZEo0S1NIK3Z2?=
 =?utf-8?B?cG5RcENPR3FmaWpvVnZQQ2EwYncxdEdzSFBsNFh4am5FVS8yY3FaWEpGYmtD?=
 =?utf-8?B?Zkl4TDZJSEVZRGt6ZkRWZUJ0SHdNdVJXdEpuVFlCczFOblc5ckxQV29sYjVX?=
 =?utf-8?B?Rm4zRnNzQjBpM1pNaFN6ZTlycDlldUdHdlBISDBhYXZWbTJtN3U5VjNqUkxY?=
 =?utf-8?B?Sjcxc1ZYZTNQMHo1QnA2UXBEeWxQcy94bE9BYkJ5QUtVMVdRdmxZWGZlSnFh?=
 =?utf-8?B?UUhVM3BNS3lpaERuMitTaVVtUy9EWWZRWWlRTFVRQ3ZFVlJNSDFMUVNUZWZh?=
 =?utf-8?B?SXpEMURwSjNPREpGMTU0ZVdCeUhoVVdVZVpvVWlESWUxalFvSVRsZUJEZ3lZ?=
 =?utf-8?B?MGpkdUtxM3hWcG9FOGlGV095b0JETk5pRzA5RE9pME1QTWtYdithTDFpOWly?=
 =?utf-8?B?cWpqTzNJK1YzOGdldVlValpXQ1hCS3J2ayt0OCsvc2tkYlVmdDhNaVR5VVJ3?=
 =?utf-8?B?WEp1djVuSWg3ZkZObE55OGdDem5tNjRoOHpSVndacnRHMWFBOWtEdTJZVDUv?=
 =?utf-8?B?cHVBcjF0cmNwUXUxQ3pBeUJJY2FUbHNSdGwyclZNL2RKTVdFM1ZBZXBpL1Z5?=
 =?utf-8?B?dmxiNUN2QkNLTVF1cE00U2MxSGw2b3laREtKNkZZeGNMQ1NKZ0ZYRXZJZmNB?=
 =?utf-8?B?ZFhOS2tUcjZkejUzRnVucmJycUE4SnBQRmZIbTJYZFBhSGlnWmhhdlJRRXJo?=
 =?utf-8?B?a0UzWVYvQ0hHaHdHR0p6T2xSTTFCRTBTMzFwdFFyZUExUHVTQjM1NTFueHdD?=
 =?utf-8?B?SXdZL1ZzOWZkd3VkYmFMN1A4RGMwVU5Bb0RUM201cEVnTWtVS2s2SzVwQzBR?=
 =?utf-8?B?bzBQdmFyMzROWVdZYURja1VFZExvUlMyMFNaKzlMYnNPK003QWtGK3gyelJD?=
 =?utf-8?B?YjhZM2tDbXRyeWNUODUzc2V4cjBNWWMwMmZzYkpUSUxhZkFNVWxaT1lqR0hD?=
 =?utf-8?B?VVAwUUl4aUlwWU5GdUJycEpyaFIycHc0c2tnUEprdk9ZbWhoREh0VUFsYytB?=
 =?utf-8?B?UThMamhkQmdkTDZtY0pLWnlNYzF0UEZITEZIOVVxUnJleXd5Z3pidjBxRmw4?=
 =?utf-8?B?dEFkQk05cy9QVmJmMS9yVUpMUXJDZ0dyeVg1d2hSaEJJVWlLdWh5TENtNWZw?=
 =?utf-8?B?NzR4YTQ1NUY2b1JiNjltWUVUV2kyRXQzVEtNb2lCSUNTcHYyYW1mM3U1Z29X?=
 =?utf-8?B?aWcrV1U5ZmZ5cFE3Wm9Gb1dDaXI0bG5LZkJZQWtpRkkxSllNclEreWpDdUs1?=
 =?utf-8?B?WHlkWi9qb0NiZVlJU1FKWU85Q01sa1lUSlZXOW1ORS9VQ0FmT3o1UkYzd1FJ?=
 =?utf-8?B?cHN6UWs0WnFwR2VaSXRJZC85ODk4bk1kc3JOOXB2ZWJFMTdqakVUQldvSWVY?=
 =?utf-8?B?UlpkTHlVZnI4b0dqNEVIK0ZYVU5EbVhZdjFnb1JPSVlEVDU1Sk5nelptKyt0?=
 =?utf-8?B?Zkd3V2psZDMrclBSdkYvajAzWGtkVWl3S1AzQVFNczdmTzRaUnV1OFJRYmZq?=
 =?utf-8?B?S1NaZnJoVURqV3VpZjJoWXlSWG5aNVhiRjk2b1lybUpqYVZ2TnNSanlWMlNJ?=
 =?utf-8?B?VllFbmZLQ3Q3R2JrOWNqL0ZhWjJZZnYvcXo1NWFBRHlXVTQ0ZlBhbTFFd1o1?=
 =?utf-8?B?QzFTRWFUazVybEd3YVpiaEhTOTNJMmpqSkVBK24rMC9lbm5lTVBYVE9hS3pk?=
 =?utf-8?B?aDFQNVJGNmo3MCs3ZlFIOEZmNXU2eTBrK09FQ2VuTStzWStWUHAybHA2K3Rs?=
 =?utf-8?B?R1FPMjRqV2Zhb3N6SnZWM0ZreGZEa2piVWJ3RmVVY2lpMFZuNjN5Y3BpbDgv?=
 =?utf-8?Q?z9j85M?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB4462.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzY5MVJ6SUlabi9YZGQvYTNpT0V1SkUydS93SVdDN1crVUJ0TDVFb0J3QW43?=
 =?utf-8?B?ZnplTjkxbW56cXRybWJsV2FaemZmYUVlTGFXQS9xeVZocUM5aEk0MFBTYnpu?=
 =?utf-8?B?RGJnbVVncVF6Kytlb21UT1d4RFR5SFg3eWVKQ0dmcTJvc2pZTVVaZ1FqUXZU?=
 =?utf-8?B?ZnQ4YUJZQ0NFeG9JV1NNOE9tTHEyY0tRcm4xY3ZSVS9ZeEFEdll2TDFqUlZo?=
 =?utf-8?B?dG0zQlRCMk8vTElNc0hqQnIxZ0FqNW9uU0lDQVRNVjdxT0w0bkw2WnVKMnVD?=
 =?utf-8?B?TjRBcW5tUjBtdU42THlMM012cnF0a0JkZVcyUnhZbmh1M3M5dDhlTEV3UVpT?=
 =?utf-8?B?Rk5hd3ZGSjlQYmhQRGFDTm9udnRTSnpTUHdBaEx4aVY0S05sM09JQ1N6WEdm?=
 =?utf-8?B?b0szTVF1dm9BZGhHZTdaV2JBcGM3ajNLa3lVMWRsYkFCR1lxVEsyMTlCMTdQ?=
 =?utf-8?B?akJ2S2cxc2oraDVST3BNRUd3ZmhoSEowL2FYN013MnZlWTl1c214c3d1Nm42?=
 =?utf-8?B?SlVEY1BIWnFjRzk3V3N6ZHdlU01BMVk1QllUNE9nUWg2SklURFRzVitHRnpB?=
 =?utf-8?B?WHd6SjQ4TTRrUklHN2NNSkZPcGxPWEQrMUkrMjEvaDZWckIwVHdmTiswMElH?=
 =?utf-8?B?czJ6NzRFeFk0aHc4K3ZhYURSUkJCRStSM2l2Snk3dXlLWnRLbVR4UFNHeGFx?=
 =?utf-8?B?djhnbkZ5ajVLTVo4WmM0QWV4d3RhbUtvWHBxcnlNcnRuMjN2WEhLSWtQU0RS?=
 =?utf-8?B?SVBOT3V4WVBEYlMwcE0zSzA3bmp3REdiNGozdUh3S1hLNytMOUxiVkV2TjNL?=
 =?utf-8?B?TWhhVHIwZmFSdG85bzgza3NtVllQUGR5a0h1Q0tjTEcyUUZBRUowS3BhQ0Zk?=
 =?utf-8?B?bVF3SFFlRzBnVWwvNG8vSk03Vy8zcU90NjQrUU1IWEFzWWZJRzdMZ3FVNWd1?=
 =?utf-8?B?Y2FKL0p4QmptU3dtT2RLSEprUzRFK28wYlp1bjZCVEFlQUJhSmNEUTVQdGtY?=
 =?utf-8?B?ZUZJRkwxREoyaFNuN0g0bU5FWitaK205bXQ4TkRLNDB1TzhCc0tPV2UrMURX?=
 =?utf-8?B?MGdnYWtpODhhKzRhaXdraHRWdFpJajNDUXNvTUF1SWVRSnMwdjZueS8yTUtX?=
 =?utf-8?B?eVVkWTZGR1RBeEZwdEdEeEpWN1ZrVnEzV2g4ZDFSWXRjVllkOG10UzZmRGVX?=
 =?utf-8?B?TTBHanF1YmxTd01tZUsxcnc3bWFYeUxQK2Zud2I0UHZKdk54NHNsbEw5ZHRV?=
 =?utf-8?B?RVd2djNOT0lTaTRBNEpyTjVrUmxpb2ZBTy9Tc1lGWUJ6MEVoRUpYWmhrNklV?=
 =?utf-8?B?MGUvTngvYmNJWHBJZTJuZXJGVmtvYlZLOFFyYllIN0lBaC9VdTVlQjBXcnR5?=
 =?utf-8?B?T2c0NjZrQTNlTU5iL3hOelEyS25IYXRNZDRSdmx5cytQc3lMZ1hlb0VSN2di?=
 =?utf-8?B?b2ZRL0dta04xZ2t1RzE0YWthTTJuaFo3RE93c0p5QlM5VlJGbllqQmlBdXdz?=
 =?utf-8?B?T2x6R2tvdXFwQUFsb1FRaTFUbXQwMTRRdHEvaUhxV1kzODUxM2pYUkRkZStj?=
 =?utf-8?B?ZVBhUEg5Unc5NFNkWU9vWlBYMnk1MGs2WnpxUERENkZkd1VnQUwwVGx4OWgw?=
 =?utf-8?B?R2doaHdDYm5CTDFIYkVIc1R5OG9XRkVBL2VrSGVHYkg0dHZsbmJHZjJ1NStI?=
 =?utf-8?B?bGJMZlk2czdwa1YzSXk3dkhvV0xYY1BjSTBIWllVSjRWTTRRbXVjeXB3Rmsv?=
 =?utf-8?B?SW9qMjI0TEZHZnk0S2lRc2VUR0t3Z0VxcStva3IyelkvN0dOclJnREhYUElm?=
 =?utf-8?B?K3lqUVVZQ3N5K2VIL2hRMjQydlcwcGlVSW5iTjZXOEMwNUE3OTAzaGhPdlU2?=
 =?utf-8?B?WllxcDhtUWZ2bjFuSXlMWUQrUHEySngxdHU5VUxkVnJJdGVRQ0R4dncxckFT?=
 =?utf-8?B?L0VlOEtwVXcrT3c2ZkxhVTBrRXlqcUttTVd2TUNoMmUyb0RNbDhpSXpWM3ZP?=
 =?utf-8?B?cUg3TDl4RUZvU3ZMRmYzeHJHdzRXQUFVZzZpTjZZMEd2endCYjhJSlU3ZXNY?=
 =?utf-8?B?Yk1tZnZQKzJua0Y4NDg2aXBwWnl3dWNBTG5xK3phc1BnMExjMmZ6NHJGclov?=
 =?utf-8?Q?pBm9sKztqjZLBgsD0zvNgv35/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33F231C4E2E68246BEE0C0D822807A76@eurprd09.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db223658-8f2f-4229-cd61-08de107398b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 07:29:40.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cq4XcnoTu5PibhekhgMrIB8kex1ap9+fxhk6UKfp2r+6+SYjAaGzgg0Qzzgi5mmD0mK/TgWO7NvA6v8i6qOHrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6690

WWVzLCBzb3JyeSwgSSB0aGluayB5b3UncmUgcmlnaHQuIEkgbWlzcmVhZCB0aGlzLCBteSBiYWQh
DQoNCk9uIDIwLjEwLjI1IDE5OjQ0LCBKdXN0aW4gQnJvbmRlciB3cm90ZToNCj4gT24gMjAvMTAv
MjUgMDg6MDcgKzAwMDAsIFRob21hcyBCYXJ0b3NpayB3cm90ZToNCj4+IHx8U2hvdWxkbid0IHJs
X3NldF9wcm9tcHQoIiIpIGJlIGNhbGxlZCBmaXJzdCBhcyBzdGF0ZWQgaW4geW91ciBpbnRybw0K
Pj4gKGFuZCB0aGUgbGluayByZWZlcmVuY2VkKT8NCj4gQXMgSSB1bmRlcnN0YW5kIGl0LCBybF9z
YXZlX3Byb21wdCgpIHNldHMgcmxfcHJvbXB0IHRvIE5VTEwgYW5kIHdlIG5lZWQgdG8gc2V0IGl0
IHRvIHNvbWV0aGluZyBhZnRlciB0aGF0IChieSB1c2luZyBybF9zZXRfcHJvbXB0KCkpIHByaW9y
IHRvIHJsX3JlZGlzcGxheSgpIGJlaW5nIGNhbGxlZC4NCj4NCj4+IEkgb25seSBzZWUgX19jb25u
bWFuY3RsX2FnZW50X21vZGUgc2V0dGluZyB0aGUgcHJvbXB0IGFzIHdlbGwsIHNvIGlmIHRoaXMN
Cj4+IGZ1bmN0aW9uIGlzIG5vdCBjYWxsZWQgYmVmb3JlLCB0aGVyZSdzIHN0aWxsIGEgc2F2ZSB3
aXRob3V0IGEgc2V0IGJlZm9yZT8NCj4+DQo+PiBPbiAxOC4xMC4yNSAyMzoyNCwgSnVzdGluIEJy
b25kZXIgd3JvdGU6DQo+Pj4gUmVhZGxpbmUgOC4zIGNyYXNoZXMgd2hlbiBybF9zYXZlX3Byb21w
dCgpIGlzIGNhbGxlZCB3aXRob3V0DQo+Pj4gcmxfc2V0X3Byb21wdCgpIGJlaW5nIGNhbGxlZCBm
aXJzdCBbMV0uICBUaGlzIG1lYW5zIHRoYXQgaW50ZXJhY3RpdmUNCj4+PiBjb25ubWFuY3RsIGlt
bWVkaWF0ZWx5IGNyYXNoZXMgdXBvbiBpbnZvY2F0aW9uLiBBcyB3ZSdyZSBhYm91dCB0byBjbGVh
cg0KPj4+IHRoZSBsaW5lIGFueXdheXMsIHdlIGNhbiBqdXN0IHNldCB0aGUgYnVmZmVyIHRvIGFu
IGVtcHR5IHN0cmluZyBhcyB3ZWxsLg0KPj4+DQo+Pj4gQWx0ZXJuYXRpdmVseSwgSSBiZWxpZXZl
IHRoYXQgYm90aCBybF9zZXRfcHJvbXB0KCkgYW5kIHJsX3JlcGxhY2VfbGluZSgpDQo+Pj4gY291
bGQgYmUgcmVwbGFjZWQgYnkgYSBjYWxsIHRvIHJsX21lc3NhZ2UoIiIpIGJ1dCBJIGRvbid0IHdh
bnQgdG8NCj4+PiBleHBhbmQgdGhlIHNjb3BlIG9mIHRoaXMgcGF0Y2guDQo+Pj4NCj4+PiAxLiBo
dHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL2J1Zy1yZWFkbGluZS8yMDI1LTA3L21z
ZzAwMDA3Lmh0bWwNCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEp1c3RpbiBCcm9uZGVyIDxqc2Jy
b25kZXJAY29sZC1mcm9udC5vcmc+DQo+Pj4gLS0tDQo+Pj4gICAgY2xpZW50L2lucHV0LmMgfCAx
ICsNCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+Pg0KPj4+IGRpZmYg
LS1naXQgYS9jbGllbnQvaW5wdXQuYyBiL2NsaWVudC9pbnB1dC5jDQo+Pj4gaW5kZXggNzgzMTlm
ZjguLjI3YzI4MWQxIDEwMDY0NA0KPj4+IC0tLSBhL2NsaWVudC9pbnB1dC5jDQo+Pj4gKysrIGIv
Y2xpZW50L2lucHV0LmMNCj4+PiBAQCAtNjIsNiArNjIsNyBAQCB2b2lkIF9fY29ubm1hbmN0bF9z
YXZlX3JsKHZvaWQpDQo+Pj4gICAgCQlzYXZlZF9wb2ludCA9IHJsX3BvaW50Ow0KPj4+ICAgIAkJ
c2F2ZWRfbGluZSA9IHJsX2NvcHlfdGV4dCgwLCBybF9lbmQpOw0KPj4+ICAgIAkJcmxfc2F2ZV9w
cm9tcHQoKTsNCj4+PiArCQlybF9zZXRfcHJvbXB0KCIiKTsNCj4+PiAgICAJCXJsX3JlcGxhY2Vf
bGluZSgiIiwgMCk7DQo+Pj4gICAgCQlybF9yZWRpc3BsYXkoKTsNCj4+PiAgICAJfQ0KPj4NCg0K
