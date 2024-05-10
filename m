Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F713B58E
	for <connman@lists.linux.dev>; Fri, 10 May 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715384521; cv=fail; b=XJVibWQ7mNLjEPb4qyt5mrfFpzgH7/k0U+u8/FHhZV+ZWqF2Wlch8XwcepdrZa1dMI5RDcjRQ+ZXbSvdTdqLcGt1vqnz/7esiPNf5kEGkJ4+Pr/PDb/ggf2x5RmLQNaM7MdCnLfTicu0gl/0Tt5+keKl8eRTNbshFXGtkJw25XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715384521; c=relaxed/simple;
	bh=VUEBBFvRyVXp5dfSbjV989o4kfKdnvCJswacFvKJ8hU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zyl+gYho5Pz8K+sRQloRZlRJDDA2uOq0nAqrhNTQlwTzjqndZtAtKr+RtdoGyknY+WTCeoYEwew4PtcJ0y3/JCTufqNClToMf2NTAHl9zxTUPEDPrOGPnLMbuOK06JNv79CxNfYpFkgmAXTO1cdaEaVYIxRixs+oK3Z5OXL8pRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=LRTyWQIt; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="LRTyWQIt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzSvEoapLHHMjEr6Fcx3o86DnK0OdEesuupa9ymodqHm5P5B2egWhsDHfeBnRcYF3LKUld1FWj/czLXbG905UpDSirh+SEANAPoiSRBmwYiZHs0Zlg/cPAQZeO9lmfoRNd00nyzmsM9WC808Accp9nWfpE5Zg2Gg9w4R+hvdrsjdiE8cTt4i47Ud6Uxtt3mzGI5mloeLUXAEoRHiqtYpYx1f6Jm7Bxojb1yYEdIpLnE2WBes6BIPibtcGTCtBobQIp+I/NAREOhY/FNA1EqaDzXB33ucs0dAZG4+gNJNg862qB8tYsMLa4EZW0yCxiGK8mtjw/v00miE9gdYym2NfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUEBBFvRyVXp5dfSbjV989o4kfKdnvCJswacFvKJ8hU=;
 b=C0LnekRLNpVLqyfdnXthfU2gfrOPpTK592nmrb0pHoz6p/Rvcg0idHHxPejnlhBu4z99p5vNBFQ2YilRXCUFTvSSDLnulimPDg8WxLAkbuGpCp8WW/LpJ+4DYYJelR0bW4qHOGNqdRwAqI5BlkwkQ87kIXIn3/XWz+00M9JFQxzoeP7El2CT/7x+Vtb9Obdfn0VhalliaFngIKsrTzw6AlJMSAh09lWYKKTstuLMZlmcaJGyYqQcUAlypYAuSHDyMpaM+Y/ohSPIiQdoy6gsxrQvw0f0thVd6Bhz426SvoAQwMN98ksfaYJyNgBxI4cr1dYH/zwTuhvRFi8mT7aOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUEBBFvRyVXp5dfSbjV989o4kfKdnvCJswacFvKJ8hU=;
 b=LRTyWQItkDLCeb5i51mQSq6KCM+lGQ6N+MbaCe6Lb/U9am2W41PtimmtBAyJ74LPBcFYGbib140hmfXqHy7t6q/jTTr9VnsJh4e1Iu0mrdoI9+muHGjBDWRs+m31P4sCPfHlc3ZLwFpkyf43bCuLDy3/tT86JTLiWRW2jaz+tng=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 SJ0PR16MB5147.namprd16.prod.outlook.com (2603:10b6:a03:4e6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.51; Fri, 10 May 2024 23:41:56 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%5]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 23:41:56 +0000
From: Colin Wee <cwee@tesla.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject:
Thread-Index: AQHaozOkRMPubdVaykCd2dLmiGtPTQ==
Date: Fri, 10 May 2024 23:41:56 +0000
Message-ID: <20240510234137.3619779-1-cwee@tesla.com>
References: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
In-Reply-To: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.45.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|SJ0PR16MB5147:EE_
x-ms-office365-filtering-correlation-id: ef2ce391-3f63-4b66-47a9-08dc714ac759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?CIIHXJlNLUbhN4Xy2yacuOvcCDRhLhM/1coU7vCo6b4CSYof1fx1G39NPP?=
 =?iso-8859-1?Q?Oibadt6MBZD7pYK2rDHpLUKshV+sQt0qALP/YZO2JTd7T/DsCe9BVyBL25?=
 =?iso-8859-1?Q?JgjQa5qHd66TfHbvgM4TBdByr5YBiNaRs+4DWS+X3FOPvWzOOOcwi7maFL?=
 =?iso-8859-1?Q?6csQOKOF0IMSuilBRa9QPMdKFyRaClLhb4FhK3e5gP0Ic3qlR9lL/nX7H9?=
 =?iso-8859-1?Q?eK5PsCtd8V1s3lu+8xx9v8swgg4IiVaBTleQUwtNlkgOO82siNqdi1ESX6?=
 =?iso-8859-1?Q?MJIAxjOZBQYFFfMTneihuB+vcuBc6TaoUD81H5yx2k+EESrlP8nCaW2XjK?=
 =?iso-8859-1?Q?PIadov2T3pJza/1uz2ad3G1XqR7QZCAnct8oR68DsnUgvEtwdM+HtnXGE3?=
 =?iso-8859-1?Q?jtC1F0gV4i/v4dEhvJXRB7m1sv3sdTwneJSTsNFpU2QbPc/+7DYjcVZCE5?=
 =?iso-8859-1?Q?pj63dd5OWSTdDz+ISotbzaYU9ZmWrv9DXXj6vR16Zq3AQX4zC7GFOficQN?=
 =?iso-8859-1?Q?9U8jOwjLmD7mPLOSIHTQP+L1T3nJ8SrdX3THY7uVpuYEGaGFskwDd/z+nE?=
 =?iso-8859-1?Q?udzuEuOyDORoYmlLleckkNkewPwb/LA0bvLhkZvFgn0/Hx9uVIhps+i6em?=
 =?iso-8859-1?Q?G4SDkVsryOOu5Q8ow/q37SICRDGlaDLLQJcgK88IbkDryFaK64aLiSELtX?=
 =?iso-8859-1?Q?17KUmHpyjhSDTd1/k7ZRh0TUOLa2WBnNG2Ou/dcuxPEyUsuQZYfX3pEN1J?=
 =?iso-8859-1?Q?PdropOsQxWNOfo1NLiT0lXwIiDLWF84y1++SCQuZJO+H/kL5GuI5LeVNZk?=
 =?iso-8859-1?Q?CWgA+yFfoZtCWuoKKswMwgVhf2xm7HHWe9L4ggsAgIz6R5weKEjYkdcbV7?=
 =?iso-8859-1?Q?di/3M5SQLztDzf/U0YlapDHdpKCVsI//JouJGMMwGfwzmY+cYwJcfERIOb?=
 =?iso-8859-1?Q?JLuGLuju0vBBXGDWR3Hxesb4DxtGuru/pB6zItOczVJnfYNd+p63e410AJ?=
 =?iso-8859-1?Q?CpWe/1sioVKOVuweq7l7Bsm4uO0LZAzwWApTsulCnf7fZuzglKoJS3cQsc?=
 =?iso-8859-1?Q?MMuFeuNvF5l1U0bcXWKOwMr4urqFgCg5+dgdbrl6JLOsx5QwibBNW6LvPH?=
 =?iso-8859-1?Q?uwtk/jc7tQS1iaTi8+UdenXyBtPpMZaRdMAZapJwxuMAafR9F4E5h4NuXf?=
 =?iso-8859-1?Q?rzIBtNiDdm+5n38l1L94bDweUEHy3mWHfjwJNZt23jwqQuG3TImhc7CpEf?=
 =?iso-8859-1?Q?PTgXqWvEPPaZpo/3KZjP6ZQmoQ2AtSd2pFVIGnc99k+qtcSXNda9mNUpn3?=
 =?iso-8859-1?Q?kVlNocz0vbyK8/PZba//dt3gQDQGSTvQU4jxU2JGRI/EnaiHrOV5Y6cI/P?=
 =?iso-8859-1?Q?/G+eWAFaKYNDQhUeN/J5Lcas45l6tncg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+YxiarQTne5X35RgKbeCmeJtGfDARGtZw4n2OQIGsj2lKsfDUmhHh2a06G?=
 =?iso-8859-1?Q?HzozwSE4b+1S2IWUJ6YYAlA48ExrdJWn/26IP4WtL1IgX3gm54XtRO7HYj?=
 =?iso-8859-1?Q?FM4gJBBHytfhmcu0XRRUFjCIgENfIy1h/7Jzn+Cq13kItoAQPLnB+WM9ga?=
 =?iso-8859-1?Q?prcMpTBSAUxhOrSO5cTj3LCa5kj++bdKXNDP/ZbsUhfCH/J6R+Df4E10E5?=
 =?iso-8859-1?Q?wtFKO+xDMcwSv6+MRvKQXd2XmyrSNz4vzQ9DmrVYTc82xYNy+ReMzCNmdB?=
 =?iso-8859-1?Q?HebufGX/Ukat53jajxundKckIhpsKfgL/LoCoKTY4PvDF6FpWYyMdmljDe?=
 =?iso-8859-1?Q?7omRv5/KgW+65vftVHZfMN1Iw6be6+Vh+Pxxgz0TT9QrYwXFyD2fvgyE+c?=
 =?iso-8859-1?Q?o5B3faPc2yz33J9vtOLN3VN58D6tnlnQvlQd5QZbxuHNbLylLwWEKSGLMs?=
 =?iso-8859-1?Q?KKI4f36SQzxN2DoIZS6xs1PT9LfeDVIpx770t1NA+hwUi0fObC143tISzk?=
 =?iso-8859-1?Q?xEM0Ce2i+3YvhQSUi16WsSLicKSDdhAwT3vlD2jfqbQRSOa8/rMXfwQ1mp?=
 =?iso-8859-1?Q?0pTToaFNo9euMIQwwS/YVWbR8XtdmlsT0iEc4wqRaoojXymiKoZfBFB72B?=
 =?iso-8859-1?Q?M2ARTc/DFgd1tHHB0gbtbfL3Zm6ZAfSgnKpJSgWauFCKGa7GuCHsEEmQ4N?=
 =?iso-8859-1?Q?/Cw0tLWXA6uK36evJMEKgt2EKnt+H5B09o9ZbqlxtBsSi4El800laCoDg0?=
 =?iso-8859-1?Q?gYiWSZrxaakg5pBRNIjYlZaxcKRU6euujN+K2cn6Pfvpp/MyM3escVpirW?=
 =?iso-8859-1?Q?jGNTDbQ7yQRwAp7D7A9Ru7g1B2znH3iXRDr50smRVK9RzmCMbPNIaxQ05w?=
 =?iso-8859-1?Q?7yPv8MpK5oXvaklMYvAdTSliYOmrJ4TDwwqrIq7Dhh1POFvmp68JmIgDrv?=
 =?iso-8859-1?Q?8KKCBmV0v5wghCA8uP4+GrfXo+SANYNfTHpzGeB3paHp2ofxalUXDjM1Ga?=
 =?iso-8859-1?Q?cR2u4y9xxXiayaOL0TrCgeYWWGSl6I15tD3qm9tG+h8RGzbKggu35bzYcq?=
 =?iso-8859-1?Q?DRa3M5awV0uI5ym/DB0jM2VW10KtGTeyh+p8ulxyikW/iOW0kYWnTTKC5d?=
 =?iso-8859-1?Q?Zz9J/yEG5KyOd6GsgrPvrHHpAVYVvy8GxAdUYrg+4j3DKQ445HF/7cDX3n?=
 =?iso-8859-1?Q?GfGDfbf6YW8fq3zTukCKHTkeGeWIe2OtJVHtgP8zeLWYnolyKDzpX7Rh0/?=
 =?iso-8859-1?Q?XLyQpgVXUsV5ES5fjA+5hQIDct42br0RugIlJWFxU5wAYSivLJFN7WbniD?=
 =?iso-8859-1?Q?KgKbw0giYna8EWt0kqTBL9XSsXME26Gb7uh24R6gn2TsnqII8rG6G/mW9r?=
 =?iso-8859-1?Q?5SINlJd9PaEIOxwk5vqlmEueNnPbMCQBnh16njH5cNxoK5Wm1aVOVD1tyU?=
 =?iso-8859-1?Q?2lQexYoSrTqQXbzKdMQAnMIWBL0aSygvibNRvY/L0PXX0ydJ3fMfPGOJoD?=
 =?iso-8859-1?Q?D1YZ2wM02fPyS0awKsXMNpZI16+a1dRcvx8vfP9UpvXxcPS8XPm3Pn/t4f?=
 =?iso-8859-1?Q?r4mNSEFpOo1WppTEiGm+RgzYbBM62Yku4A64cCdfbhG7AeN9BylSfq1h8b?=
 =?iso-8859-1?Q?pTfWHKYtkhSlEhRbzewvUqw1Qc7w0tq6As?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: tesla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR16MB4504.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2ce391-3f63-4b66-47a9-08dc714ac759
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 23:41:56.5385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IGi6+IzZE1Rj0Ff06URWGDDqJYzYWhL+e+qWkdrVdRZSbeuUp1FYGjge5XRFx5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB5147

Sure thing! I've updated the patch, let me know how else I can help.

-Colin
