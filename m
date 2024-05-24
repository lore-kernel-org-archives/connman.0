Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4CE7494
	for <connman@lists.linux.dev>; Fri, 24 May 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716586271; cv=fail; b=mtRFofXtA5b3z8BYI93LjINnBokGNG/GxmZmPIhXX2c09tipIEH4iHTPFhuUGvb2nu5shNf09NVDtKJgR/4TkBPFa7D5TuY0xW1ccTLANKUJXGkRcwxIE3ECI2Ss+NubsktVTW7VrLSL96Ou2tPKb4xLApoCropdPtGgzh0J9GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716586271; c=relaxed/simple;
	bh=/fRZl0YjhaCtfwgj5wW/6UWPO++5tkbhrZX0PooPBIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTuU4Brmh6SSY8vQ0XjM8JzCX9Wi2NiQno/sFnOuvsAJVU/QaHvHGCLqw5TGxz5A4TFdln9q2+hkh6EgrqQ7yePmkn0J4VELMZvsTRtX3zxjcLx7FrLd4huiMMEw+/A1wNujB2GFU7pW+aQk3E1bOw5W2rN/VwtH9Ki2eJU9dsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=cQ5YGTs6; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="cQ5YGTs6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4HCBdYlHWbaJTcBIl5Kq6xoLDyvVJtmiDYizQK8nRlVvMRixmIU2BZm5OHVd9eygLfKY01xmme0kHApeXTFX1z51/nIrHOmbfVMub1iAUxyPTBb+GueppwWSpcaiN1g6f83AeZ0Qs4V5zgStpFErpcJesW3zp6cehqBbvZ0FHhycjMBjoRnfX6GQ8O0cHzMWC86eKt/TP9jeuSFvqIvzsbVcHUC2OapDjCAtGFkANMsyvfJM/cRSvqU+8fYbRmu8zTbeAxOb1O6WHHmPR46sL2M8H4xGMre02rMU9jUCNGGzcJ5XGP5gbgpisqVyDhv+BlYIlyQkG8eOOe2q8st7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qEkHkjkRWl64uhkP7Zt4S/0Xu6PJpImvTbnXAq0+3Y=;
 b=OWpVu0lvU4HkGqqnd/O1xowQzbigl3QgNR431xDqByY9dBOlZbc8sLfdh+zKUrolXgro6U2hYR7hijnyV+nvode6aaCp4w0zqPHULb6AczPNhEigo3W90Yz10SFjQRVGgwxgrzYHG/sTP8Ih56I5fywWb+nl7+0SbuSeMXOGrDDtapQVMN0LUDXC7n3JdRc+jeLq36zWCJUFfKFxj2QNvQO4cDnM/GmoPvMHZSHyyJOmcsuM2rJUlvl/uptxdXyjz8w+W5A2CkmtoDgT5fY41Zqz6999WQqEilT+pqfG4yYlRyvSEsDWxXGEZwWlE9e+2H3XFDat/Zop/vybyVIdWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qEkHkjkRWl64uhkP7Zt4S/0Xu6PJpImvTbnXAq0+3Y=;
 b=cQ5YGTs6SLfeJVK0oT1/O3oYuLqYGPWKBiS+VYPHRy3t89f2CjG+3U54rhQdp6C8Vw/zfaFtvYz++GkudUQNAeW+iPOGxLM918q3L6CmcaBPPK/zvLBDX+/kzaqxMoHDJRwEB0bmET6AQKx4PvI28CxHTU2iaIZYQ/rYA/THH4c=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 CO6PR16MB4033.namprd16.prod.outlook.com (2603:10b6:303:af::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Fri, 24 May 2024 21:31:00 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 21:30:41 +0000
From: Colin Wee <cwee@tesla.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] Prevent a short allocation by checking upper_length
Thread-Topic: [PATCH] Prevent a short allocation by checking upper_length
Thread-Index: AQHaozVC4DTBzVpAzUaX26jraTWGdrGRJAkAgBXYtAA=
Date: Fri, 24 May 2024 21:30:22 +0000
Message-ID: <afzxdg6r2xolx6t3juav7vy6jz6jp3ui4nx266ucnxi6ep5xuq@zjca3q44s5jy>
References: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
 <20240510235325.3625167-1-cwee@tesla.com>
 <20240510235325.3625167-2-cwee@tesla.com>
In-Reply-To: <20240510235325.3625167-2-cwee@tesla.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|CO6PR16MB4033:EE_
x-ms-office365-filtering-correlation-id: ada93b63-71d7-4aae-749b-08dc7c38b7be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0x/oIklvLGUE0mqy/BsFYjGOgmyltbrMD52yp61mAj8mNe553+DJjyVNi8Bg?=
 =?us-ascii?Q?OeyGlEv4dftXRdlUqindMGS0gDDUTKtKXP6eUyyOa25wiCKgyHffzp0AxBkQ?=
 =?us-ascii?Q?/OAbLZU1EWBPwAJBdSW12EcG+9SVwa2W6C84Ra+NywBlQcFfa/V4wumXKUAq?=
 =?us-ascii?Q?2cGAfhcctoZ3g9Gt+XJZC2TlN3pqNDqiNTLhT8smOVsFqujwtFrgxcVo2QJw?=
 =?us-ascii?Q?jPFmDs5NxDHlNw0mLmW8grXsCH5AYeYXOIW0w5CwZOvssgLDZVVlg20OC3Yn?=
 =?us-ascii?Q?LJTEot6N8UO95XJtRx6EoFshJ5Jw8lNGIXRWPSP7T6A8Cu08qThbrfo389l2?=
 =?us-ascii?Q?ixCdXwe/cMdNBD/5ypFuSdW0DYHCl/+m2uSMDJ+tFz3iZnZyrwAbFftzSee+?=
 =?us-ascii?Q?lhP6WROVr98x1jPPalIwjjPET3fncTu8wLHPDergU0mrrwfTPv5eD5WgcDh+?=
 =?us-ascii?Q?Cvm+v5jNRz7JT9F0vFFn4IqqqIzW0OTRKg3Cz1+Ol3zhSxnwQ9+bQQ16Q8rm?=
 =?us-ascii?Q?b6dmuQcyDpTFFRzZmfZJInNXmjJX3KUkwp/EJBUJyZnrVrLL8RPOrhMVlLzQ?=
 =?us-ascii?Q?XxuOZnuZcDOoWgjwEhjvxa/kiSC8VMOt8D1K779EkZjyPZ7YFA7TC0k4WN09?=
 =?us-ascii?Q?Um3LSo+ttV6T9ALPUB4gBQ8l7gs36dAAKmvRmqUhpmlHbWPeZV2vJQHe5rtt?=
 =?us-ascii?Q?/HrriVg2C1W/BhXuLSKIcYXKkhsA64JrtIzrDwgW89BKKLxm5Ip1WRYBYE0R?=
 =?us-ascii?Q?XOFD/kOx8Cl9GdtSwUkhJ6tpPvuuMae/g4P1WNP2PUBAmOZ3U3ATASci6nfK?=
 =?us-ascii?Q?Q0PdbHHvUPyXmkiLb16uPQvhwFgU+q0vVtoyg/Cgk5PVcl0npm7hS3gAJFVL?=
 =?us-ascii?Q?MtNC1WYG93H/NlwFnBQPEdldyVUESEJD0fKRLe9iYkx4ILhrHwBU1z67K7Dh?=
 =?us-ascii?Q?IV7hMk3UPgok7PZFDnFSmS7z7xk/jWBvDICW9mBJ7dLFObT0NYzcqD0gbe8X?=
 =?us-ascii?Q?+lg5z/UJ/dZ6KGavKi/zHwo2TGBAFLK+bkXtbciZXLwWghTz4/BE2LKxiNvB?=
 =?us-ascii?Q?NAi3f8GEvg6jr7qSYX45K7kvjETID90qU+zOH7YGyz+7jCc5spBldw/O+P8C?=
 =?us-ascii?Q?LSmUMMl41LY9RMLcXsvu3c/2yswTxoriiFtVT7xN5grSuawzjZ9v4TOa8DKt?=
 =?us-ascii?Q?rq3olsHyeqBBTrgCzXdi1s40bwh57sC28diLejB/gdmm8kWeXdKatqvvxXfS?=
 =?us-ascii?Q?xh3WeBwMlsqISMmnJDfrOLZjhjr3Tl7dDXrWKlmFRptrRkF47WstGSnuznI+?=
 =?us-ascii?Q?QbzTKGcyUb40kAj3OOf+e7pRbkDLt7GIKDzABgd4u4i6TA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G8Xopy3vzbSqGSs5+767MSEWES4Nmco0ICSU8umZi7fsQ6YiBfdcDuVKtMfj?=
 =?us-ascii?Q?nzTWD3XUXRKztNapM+q2hJOmmICy4w5R3+QfLN2gcKd7WsiTRPUmSlhI74hR?=
 =?us-ascii?Q?mvsvyEyFCR5TjXdjlDUcDEDgn77rYViHB4qeNPdCfmvInV80a8JSpXq5jVaY?=
 =?us-ascii?Q?9EyCKWX4cH5ETSNFgtO+O7dFIZz/jRdwJL/kZg8RVuv/5wAbkX87JRsuofHF?=
 =?us-ascii?Q?eXKoikrGBeP/IhOZWqgIBF1/iqLIrtGwpsi+evxaHvF6f83OguqjiumHtkqS?=
 =?us-ascii?Q?0dUrQSO/UxSvxvi5x8fpHvKayTjSoslhZKABhOPA8r7fkSjMhJl/RX8CxcEy?=
 =?us-ascii?Q?eYtXZEFvBEbxukeTW0r9hW78p8Z/dGq3gBluij3L60eGUYBHxe2Mf2kfrWor?=
 =?us-ascii?Q?DEuBhyJd2EkT/x/eZAo33XJ6re7Kq+OVgXL9gjmUbHdw26kgFE3KhosYKRQr?=
 =?us-ascii?Q?RhSkScoXcNckIFxvpkXAVRJb7mEUe+izmeyIYZUc+vovaaw3LurOuAykgSGm?=
 =?us-ascii?Q?CTumNx0Jv8i974zFmaLuU8tBwqEAv99XKWNTuk/NOx1PyINw9zqBU25uuLsA?=
 =?us-ascii?Q?OssQM4Lqb7hQPDYqyoK8QTIPAY6Bj7k732Psle15kzVsH9jk31WgKjEErOtA?=
 =?us-ascii?Q?Kbv0aamIZyTXWOFKDOUE6rNxsyE9j1G+1BpvNhnbDd2/2t5oNdEuOiHqX0oy?=
 =?us-ascii?Q?m+VoyOyUY/C7OZfLcb1tM889VkEhCVaOAsNz/Vgyp/H/aAdENcK6Bp/aKOaM?=
 =?us-ascii?Q?hELTLA/By54ZmbwwccIwK2a4Ci+oLNdFbNqhCqg1x+kJTgnWTsWBJNChoczJ?=
 =?us-ascii?Q?7Hfza9+oWo0LBBtO0oQiIRQAdUvzasSkbpm3mkv0gZwZb2vn6UWHLfmivjzm?=
 =?us-ascii?Q?Z4qcIQOSVyNmmBoxlkybu3RtexjsWdx1ooYtjSjCy8P2PRPPn7/JKWgQ3DRb?=
 =?us-ascii?Q?b0mFlgHhTlDRUuIGYrAb6iBJejhWDNrbBmzpaIOXsOjN66iAUbzb32NI4BgI?=
 =?us-ascii?Q?I1+jIdKdj2IDJbjniAQN3ov143mmt1OIbOUZ3J76ZA74V6g+yAX7q1BR5xbA?=
 =?us-ascii?Q?oOfJu96MaY+MnZ4rWKI0Ys9hi9Qt7bXuclLWkNo8qnbQGXg1dwGmrSUe8jou?=
 =?us-ascii?Q?cU6CFahKsula4pA6ejuLg06rz3TMdj8t2s4F4KCRf1OXGdjKeJAMAwEYNAXJ?=
 =?us-ascii?Q?f96QMc1ViJFyXpYLgtOWyhPzIcWgsTFu0z3F6trMCKC0vP4DfiMscJs3JQS4?=
 =?us-ascii?Q?HuiAlDUolKIOB4lM2qa6mETHOY8rRXAGh3Ffts/6DJeXgy9K7MBrN1U//aWh?=
 =?us-ascii?Q?3TrsXytxfupDoPuSCCYZwsu+yHWf2B3lHrGem4SvsArF0QIDUfS8Dv2OV3ti?=
 =?us-ascii?Q?7T/iaEUWXDjbcMIsVyUxdtQLoRNqvtZ7uFldul2P4vyMPsfh98Cl5eScFA1v?=
 =?us-ascii?Q?Ynqgg/m7lFz5YCbVxbF1FnAmKZLovYxfJCibyu+SCUsdIB990TXEkQmbMEJM?=
 =?us-ascii?Q?ehECYrhdt9sVSYBjWhClCvE8+HmwCsrkDXDIZhNn/Syn4xVOSyFDPLy5rfJ9?=
 =?us-ascii?Q?FsOXuiCEjJ4fBNLVJd5m/cpKH+Vp/LdLuwTqcWwh?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50AB99A9908A3348B264B472A520C414@namprd16.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ada93b63-71d7-4aae-749b-08dc7c38b7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 21:30:22.1954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89AOM8yPZHc/9mYJFg/0czMEI/jKr97UNludwXgPlNgYO3+WCfUS5jr9GQmhFVER
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4033

Hey Marcel / Connman team,

Just wanted to check in here. Have you had a chance to review this patch?

-Colin

On Fri, May 10, 2024 at 04:53:16PM GMT, Colin Wee wrote:
> From: Craig Young <cryoung@tesla.com>
>=20
> ---
>  gdhcp/client.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/gdhcp/client.c b/gdhcp/client.c
> index 2afa19e6..c9234a18 100644
> --- a/gdhcp/client.c
> +++ b/gdhcp/client.c
> @@ -1863,6 +1863,8 @@ static char *malloc_option_value_string(uint8_t *op=
tion, GDHCPOptionType type)
>  		return NULL;
>  	upper_length =3D len_of_option_as_string[type] *
>  			((unsigned)len / (unsigned)optlen);
> +	if (upper_length =3D=3D 0)
> +		return NULL;
>  	dest =3D ret =3D g_malloc(upper_length + 1);
>  	if (!ret)
>  		return NULL;
> --=20
> 2.45.0=
