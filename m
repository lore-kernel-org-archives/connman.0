Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=18.208.22.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794418398;
	b=F/rU3ZQt7rIoFvM8LvnT5lnfaes8Ey5Bl+SjvVptLdRlvmSORsJZUoNaYbOD+sigSz5x
	 WvtGTCNPrQotCgDw6hDXG2j/D5jGJinK4TtSAGpXws4n46G5fNfhEypGtPc9a52aFTFzd
	 GIOHY42wRMSFO4XyQRKH6CiiHSj4ZCJZSl5oJoSBpq+6zlL/QhW19jhXFnifW5mR1dmF1
	 qnbd4nLQjMz8IV0cWrNuFxcMBGAcOxnkmmcTUbd/80bVz2+b5fLno34hLzHsX6oWNemna
	 9WQwiaHJ9jum9UzOmtlETXOuuvoS7zdn3kSeU9WnuKLkbdr1Uks8GYDFUsSyvfw89mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418398;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
	 Date:Deferred-Delivery:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-TM-AS-ERS:
	 X-TMASE-Version:X-TMASE-Result:X-TMASE-MatchedRID:X-TMASE-XGENCLOUD:
	 X-TM-Deliver-Signature:X-TM-Addin-Auth:X-TM-Addin-ProductCode:
	 DKIM-Signature;
	bh=qusYCoEORDDmyqQQtGZhZQT4RJuIXbUsHbDAcOqQLRE=;
	b=5M30aI7ONS7pCU3eCMJFsLqf7U5GG/yMXsGABIbGTG3qq5v/VB8cuhMW7Hh+g8iyRwKc
	 CxZqORBKfPqUJrMjRrDgYnzndfnnYPBIYHgAFPNeTPvfEnl/DtSL+imISvRHapT3k3M7V
	 boEtIon8g3baCyXOWWsduMJDeErC9Oqkpe/OM8tDfucM01uUR6PURLFJotCDG4SaTH4qS
	 LRvO5T5ba/tMmrcs7ioOEBQ1QvT8EmPujT+aaid8WjVHndQ71AekTOh91GSKIg6IMEX5U
	 IOBX+wkfkuJ59yKav0ITarPa6d/Q7I5a08Njd9DLveDtHi+x8dv9/XNAckjeZFRAhMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trendmicro.com;
	spf=pass smtp.mailfrom=trendmicro.com;
	dkim=pass header.d=trendmicro.com header.i=@trendmicro.com header.a=rsa-sha256 header.s=TM-DKIM-20260724121021 header.b=deCGnPav;
	arc=fail smtp.remote-ip=18.208.22.128
Received: from repost01.tmes.trendmicro.com (repost01.tmes.trendmicro.com [18.208.22.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C1606A31C
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 17:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E1C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trendmicro.com header.i=@trendmicro.com header.a=rsa-sha256 header.s=TM-DKIM-20260724121021 header.b=deCGnPav
Received: from 52.101.46.57_.trendmicro.com (unknown [192.168.181.27])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id 3028EC0D2E96
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 17:33:11 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1794418388.655000
X-TM-MAIL-UUID: 286a6fb7-0261-4d46-8ec1-c4b94acf8810
Received: from CO1PR03CU002.outbound.protection.outlook.com (unknown [52.101.46.57])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id A03CFC00014A
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 17:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcjmqSjlrO9+uv0sag3K5abHgeMwi45zYmBQcwWz77JFIXjnnPJcdW+Itb0KUBG6AlQajoCJQWNCPTtvxc/wg6CRL1mzyn0hqJaSBLokNXLojDkHh92/WqDuH8VD2FH7soZlhXQVb16qwpHsuuK5yvTkwf0AUdXF+Q7cMtPybgZ83RTZsdnI0tzKD1tndAAvKNhtaq7Yv9i507H9LMLYWbOAE2FtKWcT/VQ6/hM08VM3vj42IIAxXdxhYSLLpvEMEp2xBNszon1IcTVfv4xHbQn/3lSiLi7JagQ4dMkmHvQw5b0RNWHwQm6nxeiSnh87vQrbQbNlWeNJFhk7suSCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrC1xWB+2tr8nDdcf/SXJeYcPdk6PstB5yS74B1CenY=;
 b=Xatw1T7DvqmlzxjZLZWoW8KRy8FOUIEWWzlOdVX2uo0QF8+/rMDo9A4zLasalhq3B0XIEU4oaMMSMVSmKz3cOpdiZ5csjWmcDIwKsD5xL4dN4sw/IOy7IDTIU+56OhtNUXzdnp4LIfLCdSzi+xMvxovkg6MyOxzc19TvdNma7H1ymx3++JdIdYodSTO6DOWHyalncMDHi6179L2IaCLxUt5ImM4OS0f7YsHdUiEEtQ6NFxZA1rCM524sN66j5VNArCzYwBP6NScBif1bbJ35HD1KWyfXNl5zkhjIvUY9UzpySGVclowKQIUj/dhRcHAkOHhBWbZChSIk4JjxulkERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
Received: from BYAPR01MB3830.prod.exchangelabs.com (2603:10b6:a02:83::21) by
 DS0PR01MB7892.prod.exchangelabs.com (2603:10b6:8:144::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Wed, 11 Nov 2026 17:33:05 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf]) by BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf%6]) with mapi id 15.21.0639.000; Wed, 11 Nov 2026
 17:33:04 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: ZDI-CAN-32005: New Vulnerability Report
Thread-Topic: ZDI-CAN-32005: New Vulnerability Report
Thread-Index: Ad1gJ0sOCDzI8ypNR+2GO43fQh9L2AR1DtwQAAG2xjA=
Date: Wed, 11 Nov 2026 17:33:01 +0000
Deferred-Delivery: Wed, 11 Nov 2026 17:32:01 +0000
Message-ID:
 <BYAPR01MB3830A147CAB45DAF7CC084F380712@BYAPR01MB3830.prod.exchangelabs.com>
References:
 <BYAPR01MB38303E339D8114E45E3EC50A80672@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB3830F9276A2996F9202B717E80712@BYAPR01MB3830.prod.exchangelabs.com>
In-Reply-To:
 <BYAPR01MB3830F9276A2996F9202B717E80712@BYAPR01MB3830.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=274ee9b2-6959-4cea-9828-25ccfee28601;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2026-10-20T00:09:42Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3830:EE_|DS0PR01MB7892:EE_
x-ms-office365-filtering-correlation-id: 5e145e49-6b0e-4924-68c9-08df4019d77f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|55112099003|38070700021|4143699003|11063799006|56012099006|261026135527099003|4133799003|3023799007|261021121427099003|261102123227099003|261028144727099003|261026130827099003|261021130227099003|261022105027099003|261022075727099003|261021135927099003|261022115727099003|261022113327099003|261026140227099003|261009223027099003|261021123027099003|261021133027099003|261026121527099003|10067099003|6133799003;
x-microsoft-antispam-message-info:
 30X5Jlj2T3IMjS2vNeqcS2H5G9A6sm+XAyxUVVUm8jx5wW1zVeaU/9TDD1A8YRC3X/UsendfHIaA5WtuaakwGd6xrRPadAVAqgEYtzhWLbUXEZfMyJMQUHrRpaMo/ugYUNEUMaVFBYTQ1gjDJB+fNyK/WVWrBvH3tHzj7rQcaisnRkQSJy4k28DPIOlhigwmOpAJ+nglxK9t4Tr1PDp3l7Zf9D/VkPTFNuQEhXDK+Vmeh5VoOVmRLD101j5LfhfCifT+N5J5t7C2CVXC+m4T6BD7HHbkpVjR2zpvmb+q+wtAKcPkFCSpGhZCHokQZI4m9MkK06Bc1a+pgbG1S8gGd0vJgBqzavsFutkpIC8aea7lXk9kAGPSeWUKK2zd8NUO5UP6vU5IiPtqy5riNn2Uw1PnttTDKw35hcntiUOLG6GQKXN015zsbTfd6EXbpv9842B1Hu30hcDJbBH9elQZGXbi2zjSUIP0ALubMKjHd96b6zuO3kl+DI8TkDrlETjnR+phCekS0hMR9NU7S3xvfiALcDZjIrxndyrj2eiQ4r84NKoRI7W0Mz94McESjF355uw6MHfR3qlxccpQf13OOQL1utMitfa25Gv588vGs/vTDcYiY0sfxFSJ72NiyM5Lu2wIX0YBrGM6SjLPGkZfHPtFT+S6BjlZwj6NsaiAvWI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3830.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(55112099003)(38070700021)(4143699003)(11063799006)(56012099006)(261026135527099003)(4133799003)(3023799007)(261021121427099003)(261102123227099003)(261028144727099003)(261026130827099003)(261021130227099003)(261022105027099003)(261022075727099003)(261021135927099003)(261022115727099003)(261022113327099003)(261026140227099003)(261009223027099003)(261021123027099003)(261021133027099003)(261026121527099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WNv1vzI8I/qPV8QpOM1kur0o3AyPxXxv26N+4aZflY+XlPqwDNQue3pH9S?=
 =?iso-8859-1?Q?f9wW5oQomTsJopA5i0SslyAGfvjTbIRhLKaYMKa9omKHXAXxBMKJD8BKqX?=
 =?iso-8859-1?Q?HGcjcMst+RSVt08qApcJvdXVby0Ew9FWo4+sSvb3F99FRss79dVhet7jLO?=
 =?iso-8859-1?Q?lMMOt28r4LjI9surfxw0o1sCBsC3V5YcNLeHi6oUPbbQULIjmYHPU4VISQ?=
 =?iso-8859-1?Q?xJZAVq6GhwUGe5nMXlpQJ4rz9y+RndEjRWsuC7JFxs8DC4Yb0nFYdkWGc8?=
 =?iso-8859-1?Q?lpbJaUN+LuyJ6fiWDdsvC/rEZ5yr9w6ZLJdI2iTJ0tWYcMrKh4IHerfEdz?=
 =?iso-8859-1?Q?AD9/Z6TooIqZ518np+1u4nIhB/PtvU/ShJqUOd4uEMHkjmdKv8TQzckt69?=
 =?iso-8859-1?Q?1fPMzqKBakBo/OGfh05mS2vgwAjcfQvk1Y3FYc7yvapUYFVg6YnqFsxeiS?=
 =?iso-8859-1?Q?VCUypDewkrk00QrZ3lUdYJ3yXNFDQNrT1whMBDBAmkFUn45e5rBaK4CCkh?=
 =?iso-8859-1?Q?Iv42bGpoxLaW24g8+eNKGoiEufe0Z1zl87rEc+znM+/lidHAjSMInGPNcn?=
 =?iso-8859-1?Q?SYtp0V9Ot8PDwV/GAJ+jd3hboSDwDEuupRtF+8+cbKIYHR03zoQ+0CBgdt?=
 =?iso-8859-1?Q?ItLlvVA5xiRDwdq/byR6nHocEu/xnBRZiSCEV4vEXuxmXhgKR74xcqn7EG?=
 =?iso-8859-1?Q?Tal+JR6lc3hbU3V6Fd2FKn2e6v5UGCDA1wiuTZ0339Qdrk8YrSmT1Ik76j?=
 =?iso-8859-1?Q?Wm45dCHE2ekBFioLhVaEnvLTKVbkgcZmioO+npKOX4kDbtx88TLqLavP7H?=
 =?iso-8859-1?Q?PZFnvkRVybd/IEKl3TtcFbdddVgbG4x+3hf0RZUDMkHEsZ5Z+BflR2k5Wf?=
 =?iso-8859-1?Q?BiSaiIEVndHAIW4Qg1l0RYpJyddc10rqiiqPLr2aF8v6pFXPhKlHhA8axO?=
 =?iso-8859-1?Q?LspngkiDu1yAsEGS6AAByzM4BQ3UlisuksQE2vu/VfnBgw42CJMOYSE+4o?=
 =?iso-8859-1?Q?uRyNy//Zr+ZMYHNTIzG9uaFo++55UDqH57Lhpv1CoMPJcCGfuI72pbDkxW?=
 =?iso-8859-1?Q?QXV0Jp9vtGQhTfvPfm0i8pKh+UpISMLrfuZ/+kBWXMK0iHr/4V+utTDsOw?=
 =?iso-8859-1?Q?aqCa5WdcNvGl9exGxekE1kwTG4QMGNdMfy2Lybz3PkyxjkADv7xLuzvVVZ?=
 =?iso-8859-1?Q?HHJ+iId8ERs5NE9eMWdwMEhFRybA+0fvZdNCYhtEZxKnUicmJY51j8rKTn?=
 =?iso-8859-1?Q?wb7BVb5yJOKloF7+bGAIT151fVZ+wJyxILRPKhucLEhQuWWH0lp6oGDf6J?=
 =?iso-8859-1?Q?+2MyJlVXGIe8jtxX3AyE63zACvnu1He9ugJ7Lp4k55eQ0IPgo5nLOyhDO7?=
 =?iso-8859-1?Q?8eLtMRlCStAgnBXzKtA1gIhp1LurL49n90HwBoHOwJe9HmKehqDiWnvBn6?=
 =?iso-8859-1?Q?6D4B9LvmvCDCp3texnTjVJDKdU1r1Na2fE2xxviHSDwDk/MWmSR0wEnDNt?=
 =?iso-8859-1?Q?WYilZSWhGdfLuRzG5MBmserpegWPbSXj+neGqhdyiyEs5mFr9L0RANUxID?=
 =?iso-8859-1?Q?Nje0wRHcq7K7MejHOxH4TcfHcgjMRERzggbsXbZWJcQ/z1fzM+VaVmRVbb?=
 =?iso-8859-1?Q?ODz7igTrRw4oHDMS2Ei8GyoESiSP1XK8GQZ/vfiCKK0wniCQIcm4Qs74dK?=
 =?iso-8859-1?Q?aQd8HlYb5mqRNnNTznxFaZFTXUs6XecdOwaWfcbuh+P3Qgl+OzLn+VZvhg?=
 =?iso-8859-1?Q?s14btaGsLjZ8GrN8zzGJXZovvf9em01W7MkkOrzxetg8Zr1mLCNI5ZZdKy?=
 =?iso-8859-1?Q?J5FdF58KnnOWj3hAchXrOiQBgNWceWQ=3D?=
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jpZwjIAWWuVF8jJI5Ek5ZdqWc+sH2bOFG5WwbPcdDnoMkCiQvfjzVU/l+fK9MJs61SfMABBqot8lNVnKnPQeYdEWeupM+T5Ghsu9fZuTbFlchVrR/l1ifTOsvHGkvIIztal81TbOnBNH57OJfvZ22pMhI4nLqRtU6j1CydksnO4owJNV3iRtP47tyb9M12fxUE/GGoM4FDRJnW6e3e4D34PCLwHYt2dhwKUNEp2HxcAjjVo0KZKj8O2uJetagjvuSwevZHlhkoakA0zCtYgZOfqg9bi/feLIogiCyjkgq5VoPvgk+i3+ENxAuCVhX5ZwzzhM5t56W8WaEjR62DHGug==
X-OriginatorOrg: trendmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3830.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e145e49-6b0e-4924-68c9-08df4019d77f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 17:33:04.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zW7j15Kcl6mhit7hL9xkxQ4hiOvOrJT063FKO96IWNZJf7L7P5ZxnR6QMHC3yyLq3enQ0Vp/C4PGTdWmapcKCyIIbMc64lUUBSkXXJtx2X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB7892
X-TM-AS-ERS: 52.101.46.57-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30314.000
X-TMASE-Result: 10--40.772800-4.000000
X-TMASE-MatchedRID: Aq4YSSTwDqtyv0jrUI8Jl5f6z3i56SVPZn5vLEuUAFiRtP380OywwfMT
	bRax3tnnSGBqccPO5AQdvwqYoVZ5vofIljqqoXFedcaBsQNmVY5hoklK/vWBnRHy+q9EZOmehE1
	7EBM1S6K3Ndxli9SU4cS+YmfkzlEh7OhMAPiX1XQtC1eAkW8MEtWLjs01yYolUNBFadxXG5B0tR
	NYhG3TbN11twdTvNFTx5XsPPzjJWBRiC8Ku+mhBm1Z5apx3fv4nr1BgA1DSp4yuqXx9zdQj9orN
	iZ3c9zKp5UiJFSH8ufmraR3q3Y3IUOPDid4ZLSRyBCtd5wmtkUVXHYM3VgT971MBXLTLjwb8Yq7
	KCpNJN9yZ0xHYILvNFr8xEhHX2MQc1JzVixYmuc/8Mps3pbcOZ+OD/MfMwaJgdXztqOEBnBHwPp
	oS7xiTW4q1hfzDZy5/WWMDVX8I1kvFUKwU8rrOb9QIWRlAzUkIdtRgdu7cs+TszuwlNHj3WjiCh
	uKNuyJRu/mYOdzs+XryXBtyuZTxLRHsDlXxaLVHfFpnh0rMCRLH2YCHEpiPe2j2eYSMVA3Ev4H0
	2kBVm7Mb6flCJVtQ5PqR5DaOEy7CWTipr6anh1jIjRACi/vLr+y8+LvjzkGiV3qB2lI8QOJTckz
	Lq0IkpY3wcYy4TBpAq4SKsdC36PPY5SGZRK0ZB/7f6pkt357FRDUbwLgAcliXfclRTN8VvQzq9L
	Q2xpRuPYVzr4Ch+Up7RTGYoFwi6b2QZccWexnjUJdyA5hf7plR9QcDYtqLOPTw1BlnpaB8mB4uB
	zst3ykG7vNImEpzBGe/9ZaZFOq6JRwBAUa/6KYpVMsJSZoLzmoMBkrmuf/mCYM4MaoFU9A2GsfR
	KfHmb+mYZVOIbiG2HlzhM3zNtkUJcUn5oxHfyojD85jfNIZfFl2swxGvbVc7ZIn+69YlSVNJxt7
	aXvgmwjor1Nh6wtktCmiJ7dwPk/xK0jAVuQE
X-TMASE-XGENCLOUD: cba7df53-5c4b-476f-9a15-6a65eb0ce328-0-0-200-0
X-TM-Deliver-Signature: 065A243741208D28BCF7A069B5AA32D0
X-TM-Addin-Auth: D4pD9/sHT0yDzruFjlXplYiZ22ZB0SpZmuvbD2LhfXch49pSPr8U8+lPK9x
	1/9J9VfpAwMEUxSoqM9NKLZEfhafct2tRcF62SvTzwfaBqIcyIumU2QrDvMyJBF7PiEUMr3I3MQ
	1N/2l/Xo51rbYRihJD72OwKoGUMlsr4/Y/qT1P4Etene+g3ixzaSIZ/oeT8IWCfu1920ccJC1Yx
	eTRynSIycLLtDgtMBkC/fIo1UcZOyR1notvHBA9ePq+odvnsn8/5xoa3kCgvvnY2oI/AFxWJxFq
	8akdqEeYmWslmJBRDzxBdrUsB0m0i1p4z62TL16SfOSGW5qXilrwHBEGLw==.peYHvmLmey1bT6
	0lzNKLbHvc9dxZcO00Sb9oZbe6i1KGMvDh9jyaXM+pFeWwywe69uR1w953C95U0esr/ZST1gTNt
	5itUCNz5D2kRMQDAbN+cMfUN8n+ISHERNF0IlRbXxgRGjz+KkJiFjEI/3U3uFzR651BoA+EWoCD
	LqeaiozWwMjaibw8rUIGIFj6F/5EhQAY4M/8V3967BChSuQSoyPOZo+XDZwCBl9OK7gl8R+bIp4
	x2TIKOc8ZPYHguls+gJOx5vOlp0AS5LDyBvkKq2XyBd9FIsNl3ZTzeqTSBPAq+1HcV86lvnv3lz
	dHVAXN3/jlTpjGRY0AS4oIqRpMsw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=TM-DKIM-20260724121021; t=1794418391; x=1794591191;
	bh=6yPaTBDMD9EC+KAAEr2kI+iSPR05bt6K20O+ZUTVD84=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From:To:
	 Date:Message-ID:Subject:Content-Type:Reply-To:MIME-Version;
	b=deCGnPavgQlRevKsl7VpJx6bW4WnDSD7+n6FPZfFeSff6HQoOi8eymqGNqwz9SQUB
	 AliX2Uti0oy6Q0Vi4ddPvrjzkpcI5CjSJ7smV4NTVq0G2o7Tk01yYOlFVPdMhodxkh
	 tbJiQ95n1EaKI5iH9wTcUMN6cd/7mXXX9+wBRMOxcFDhuvIDkNDXEP/31foWArF7kg
	 PXxFCqJX4jF8aPkcGEzr+YahxEcP+iNrhwkZE9e2iLu5af0UjqDgyzUczqKtZczO7V
	 04+gnHBa+csgKoe8K7V+s7CLoDT2dhtSSURwQndgc+8LMIqTdIK6Ek3CD8yXQNuNmf
	 jrp+kh5cqcKjA==

Hello, 
Please acknowledge receipt of the report. Did you have any issues with th=
e supporting files? I am re-adding them here as a OneDrive link instead o=
f attachment: https://trendmicro-my.sharepoint.com/:f:/p/rebecca_mackenzi=
e/IgAaH6MLlFevTK_0xCrdoo-9ATr2ArKzT-S-GZDDZ3XVrVg?e=3DKewW2l

Thanks,
ZDI


From: ZDI Disclosures Mailbox 
Sent: Monday, October 19, 2026 8:11 PM
To: mailto:connman@lists.linux.dev
Subject: ZDI-CAN-32005: New Vulnerability Report

ZDI-CAN-32005: ConnMan DNS Proxy Search-Domain TCP Query Stack-based Buff=
er Overflow Local Privilege Escalation Vulnerability

-- CVSS -----------------------------------------

7.8: AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affectin=
g the following products:
ConnMan - ConnMan

-- VULNERABILITY DETAILS ------------------------
* Version tested: 2.0
* Installer file: connman-2.0.tar.xz
* Platform tested: Ubuntu 26.04

---

### Analysis

ConnMan 2.0 contains a stack-based buffer overflow in the internal DNS pr=
oxy. A DNS client can send a valid TCP DNS query with a short single-labe=
l name and trailing request bytes while ConnMan has a DNS search domain c=
onfigured. When forwarding the alternate search-domain query, `ns_resolv(=
)` copies attacker-controlled request bytes into a fixed 1024-byte stack =
buffer without checking that the rewritten request still fits.

`read_tcp_data()` accepts a TCP DNS message up to `TCP_MAX_BUF_LEN` (`409=
6`) and stores the length in `req->request_len`:

- [`read_tcp_data()` rejects only messages larger than `TCP_MAX_BUF_LEN`]=
(https://kernel.googlesource.com/pub/scm/network/connman/connman/+/refs/t=
ags/2.0/src/dnsproxy.c#3266).
- [`read_tcp_data()` parses the DNS question](https://kernel.googlesource=
.com/pub/scm/network/connman/connman/+/refs/tags/2.0/src/dnsproxy.c#3287)=
.
- [`req->request_len` is set to `msg_len + 2`](https://kernel.googlesourc=
e.com/pub/scm/network/connman/connman/+/refs/tags/2.0/src/dnsproxy.c#3311=
).
- [`read_tcp_data()` creates/connects the upstream TCP DNS server path](h=
ttps://kernel.googlesource.com/pub/scm/network/connman/connman/+/refs/tag=
s/2.0/src/dnsproxy.c#3353).

When the upstream TCP server becomes writable, `tcp_server_event()` copie=
s the configured search domain list to the TCP server object and calls `n=
s_resolv()`:

- [`tcp_server_event()` copies configured domains into `server->domains`]=
(https://kernel.googlesource.com/pub/scm/network/connman/connman/+/refs/t=
ags/2.0/src/dnsproxy.c#2453).
- [`tcp_server_event()` forwards the queued request through `ns_resolv()`=
](https://kernel.googlesource.com/pub/scm/network/connman/connman/+/refs/=
tags/2.0/src/dnsproxy.c#2487).

In [`ns_resolv()`](https://kernel.googlesource.com/pub/scm/network/connma=
n/connman/+/refs/tags/2.0/src/dnsproxy.c#1445), ConnMan constructs an alt=
ernate search-domain request in a fixed stack buffer:

```c
unsigned char alt[1024];
...
altlen =3D append_query(alt + offset + DNS_HEADER_SIZE,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(al=
t) - DNS_HEADER_SIZE - offset,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 name, dom=
ain);
...
memcpy(alt + altlen,
=A0=A0=A0=A0=A0=A0 request + altlen - domlen,
=A0=A0=A0=A0=A0=A0 req->request_len - altlen + domlen);
...
err =3D send(sk, alt, req->request_len + domlen, MSG_NOSIGNAL);
```

`append_query()` checks only the rewritten query name portion against `si=
zeof(alt)`. The later [`memcpy()`](https://kernel.googlesource.com/pub/sc=
m/network/connman/connman/+/refs/tags/2.0/src/dnsproxy.c#1463) and [`send=
()`](https://kernel.googlesource.com/pub/scm/network/connman/connman/+/re=
fs/tags/2.0/src/dnsproxy.c#1473) use `req->request_len + domlen`, which i=
s controlled by the original TCP DNS request length. `parse_request()` ac=
cepts the question and does not reject the trailing bytes in this path be=
fore the request is queued for forwarding. but causes the tail copy to ex=
tend beyond `alt[1024]`.

## Steps To Reproduce

The steps below use only `/tmp/connman-dnsproxy-repro` and demonstrate co=
mmand execution by running `id` from the vulnerable `dnsproxy-standalone`=
 process.

1. Install build dependencies:

```bash
sudo apt-get update
sudo apt-get install -y \
=A0 build-essential clang pkg-config wget xz-utils python3 binutils \
=A0 libglib2.0-dev libdbus-1-dev libxtables-dev libmnl-dev libgnutls28-de=
v
```

2. Create the temporary work directory:

```bash
rm -rf /tmp/connman-dnsproxy-repro
mkdir -p /tmp/connman-dnsproxy-repro/src \
=A0=A0=A0=A0=A0=A0=A0=A0 /tmp/connman-dnsproxy-repro/build \
=A0=A0=A0=A0=A0=A0=A0=A0 /tmp/connman-dnsproxy-repro/logs
```

3. Make the attached poc.py file executable:

```bash
chmod +x /tmp/connman-dnsproxy-repro/poc.py
```

4. Download and verify ConnMan 2.0:

```bash
cd /tmp/connman-dnsproxy-repro/src
wget -O connman-2.0.tar.xz \
=A0 https://www.kernel.org/pub/linux/network/connman/connman-2.0.tar.xz

printf '%s=A0 %s\n' \
=A0 d25c2ddc0b5ad13e986ec35ad765ae8d2f4b7acb47c958a05616c943cd082527 \
=A0 connman-2.0.tar.xz | sha256sum -c -

tar -xf connman-2.0.tar.xz
```

5. Build an unprotected debug copy of the DNS proxy test binary. This loc=
al build disables stack protector and fortify so the RCE witness can show=
 controlled execution without needing a mitigation-bypass step:

```bash
cd /tmp/connman-dnsproxy-repro
cp -a src/connman-2.0 build/connman-2.0-rce
cd build/connman-2.0-rce

CC=3Dclang \
CFLAGS=3D'-O0 -g -fno-stack-protector -U_FORTIFY_SOURCE' \
./configure --with-dns-backend=3Dinternal --enable-test --disable-tools \
=A0 --disable-wifi --disable-bluetooth --disable-ofono --disable-dundee \
=A0 --disable-pacrunner --disable-polkit --disable-client

make -j"$(nproc)" tools/dnsproxy-standalone \
=A0 2>&1 | tee ../../logs/build-rce.log
```

6. Terminal 1: start the vulnerable DNS proxy. The environment variable s=
upplies the command string used by the RCE witness, and `example.com` is =
the required search domain:

```bash
cd /tmp/connman-dnsproxy-repro/build/connman-2.0-rce
sudo sh -c '
CONNMAN_DNSPROXY_RCE_CMD=3Did ./tools/dnsproxy-standalone 1070 example.co=
m 8.8.8.8 &
echo $! > /tmp/connman-dnsproxy-repro/dnsproxy.pid
wait $!
'
```

7. Terminal 2: send the RCE payload to the already-running process:

```bash
cd /tmp/connman-dnsproxy-repro
TARGET_PID=3D$(sudo cat /tmp/connman-dnsproxy-repro/dnsproxy.pid)
sudo ps -p "$TARGET_PID" -o pid,comm,args

sudo ./poc.py \
=A0 --rce \
=A0 --pid "$TARGET_PID" \
=A0 --port 1070 \
=A0 --cmd id \
=A0 2>&1 | tee logs/rce-send.log
```

8. Confirm that Terminal 1 printed the output from `id` inside the target=
 process:

```text
uid=3D0(root) gid=3D0(root) groups=3D0(root)
```

Terminal 2 should report that the payload was sent:

```text
sent RCE payload to pid <pid>: 'id'
check the target terminal for command output
```


-- CREDIT ---------------------------------------
This vulnerability was discovered by:
Mantas Sabeckis @otterly working with TrendAI Zero Day Initiative

-- FURTHER DETAILS ------------------------------

Supporting files:
https://trendmicro-my.sharepoint.com/:u:/p/mai_mostafa/IQAvTFrAkl1rQ4j8u9=
EXAm8eAZsh1H1XOKBE7-aGbz5Brto?e=3DgbJNxn

If supporting files were contained with this report they are provided wit=
hin a password protected ZIP file. The password is the ZDI candidate numb=
er in the form: ZDI-CAN-XXXX where XXXX is the ID number.

Please confirm receipt of this report. We expect all vendors to remediate=
 ZDI vulnerabilities within 120 days of the reported date. If you are rea=
dy to release a patch at any point leading up to the deadline, please coo=
rdinate with us so that we may release our advisory detailing the issue. =
If the 120-day deadline is reached and no patch has been made available w=
e will release a limited public advisory with our own mitigations, so tha=
t the public can protect themselves in the absence of a patch. Please kee=
p us updated regarding the status of this issue and feel free to contact =
us at any time:

Zero Day Initiative
mailto:zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

=A0 http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI --------------------
Established by TippingPoint and acquired by Trend Micro, the Zero Day Ini=
tiative (ZDI) neither re-sells vulnerability details nor exploit code. In=
stead, upon notifying the affected product vendor, the ZDI provides its T=
rend Micro TippingPoint customers with zero day protection through its in=
trusion prevention technology. Explicit details regarding the specifics o=
f the vulnerability are not exposed to any parties until an official vend=
or patch is publicly available.

Please contact us for further details or refer to:

=A0 http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

=A0 http://www.zerodayinitiative.com/advisories/disclosure_policy/
=A0=A0=A0 
TREND MICRO EMAIL NOTICE
The information contained in this email and any attachments is confidenti=
al
and may be subject to copyright or other intellectual property protection=
.
If you are not the intended recipient, you are not authorized to use or
disclose this information, and we request that you notify us by reply mai=
l or
telephone and delete the original message from your mail system.
For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: [ https://www.trendmicro.com/priv=
acy]

