Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F4290F
	for <connman@lists.linux.dev>; Mon,  7 Apr 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046045; cv=fail; b=G3c1uXfD11KCmTIptLALRiPnrkuJ51M2hmHDUuhtfzckHF53PQu4Ef4x/wfDxuC9gvTZSa9aaNTH71H8nipgnXR9G6N3+3DMA4HkkhpqpQ3VxRM5G0G5LrzxsJem6f//ZNmlm+YGaCwCebogudyyIO+/02sUZ/FXFK4foCVFLBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046045; c=relaxed/simple;
	bh=+h9xK51c6+dOtgd0PeTiceL7/uG2Z8YBAwpuYL+cG30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PWUL6zdl2RviGLFTrSuHVcUK2Y01GBy8jNnuySEqOHPLvt61vP99wIwkmWoEI6o/cFx3C49BtYF5CjUEkI0VFreSo8OA14uRBH7+oi/hbp6FQtuvzwdK35afzexvGrKYQqqBm1WBOwm2xo6TP/t7QEuqp/tOhkavchK762FdUp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=j5q08uj/; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="j5q08uj/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDCoQWPzBtF2mblR1ljf19SjIK2xm5AGc01Mor42MUz2yVPzlDKikbjSU6v2VbZvi2pJVTOUl8rCfZcfJXIW3zwLAnnnXyrdiMcQG/FmxSnMyS4hlY932qriM6JDAOxvFfCPNEAkSGCP8GVjHe/8yL7R1QaAMD4QCgyzImFOqcCXAb9D5aMp6J+eR7kl32UcgyTVi5NQlxBM6xRMfv0xzRCf2JoxKpyYPuvHbz9ExhnumnBzhckEyniIIIz/lFRc74CJPnR9CH8k4N6L7E2GUCAVhitzjkNZiNGVo1UCekoa026JaP4gibtsrEk5rpr8EVsACIzHiGj23Q9Vpuum/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AtjDuCqe+9M4Fpp8yqB7FPplbgLbFwW13yN3BT2UWI=;
 b=Sa3JtJ8VoS8IDGBjx5zg2yqrFrhlT52ewTRO9RsBAqKXX9Ky3MvKt/Y02Q9ga9mmYOwBQrGjsb3123ZmuAmqfHMhACUJ3QO3ioeCFWLNd9/fGYhbbDimOmaFEaOvi4QP763ZmDXwy/WdxuKcA3BlK6ZCQUi8aAeBwcpoMdxu+3mPWeSgY7qRWIO6ImJBDDByuDww0b93EkfeLhzAtD2uZ5jCtm+nxflT3o0bglqyCBb7T2ylfzd8loakNkrYg9YuNInkmVmuXAjAqauKxkTO3zSeYEwVrGqzFNV0qqKxx1RW6+4jpZ1/cuAJEHxnPOHmx610WQta/Q9yrE+LP9rIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AtjDuCqe+9M4Fpp8yqB7FPplbgLbFwW13yN3BT2UWI=;
 b=j5q08uj/mNEwG25A1NzPe26MEAD+4KBfsRY3qPEJ8hNzkzmi8PYps5CZBUrC/wI2uODC6VL7LKZUAdmuHu5kJqp+pU7Y/VALMVEs6BL8m3V7uJDfgRz4VB6lCu7nKUuQM0y6wuMYKYm2kqwWm9ydAgaLgtOaaWzeeomYUJXoFrg=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 LV8PR16MB6522.namprd16.prod.outlook.com (2603:10b6:408:231::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 17:14:00 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 17:14:00 +0000
From: Colin Wee <cwee@tesla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] gdbus: fix double free
Thread-Topic: [PATCH] gdbus: fix double free
Thread-Index: AQHbpc/SapYaCo1QX0SIw2qy7vvNV7OUUvAAgAPGXYCAAFv6gA==
Date: Mon, 7 Apr 2025 17:14:00 +0000
Message-ID: <ehg3kw272e7gcdzeemgjzmshh4w5gbukthlj3x6ujqw36bdfgt@2jfktdasfcos>
References: <20250405020929.754988-1-cwee@tesla.com>
 <20250405020929.754988-2-cwee@tesla.com>
 <399bf330-de29-40e7-a231-53fc19cfa6e3@jolla.com>
In-Reply-To: <399bf330-de29-40e7-a231-53fc19cfa6e3@jolla.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|LV8PR16MB6522:EE_
x-ms-office365-filtering-correlation-id: ed66d6bf-46fe-41ac-5e43-08dd75f796de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VIs3JzcUZgWEQDxukw8j4145/5n1+DVpx4Fsyn53KIpIfYdymXiUdtzJci3s?=
 =?us-ascii?Q?dzR6yGo6rYssEfYbVLyibZNf9JwzSTMf8fLAxQ8gUqkyM2d1G3KOCjiWq7P+?=
 =?us-ascii?Q?q978EpRlkVK1YGJeL35/fIUrMJqEhtazSx75H2RIj7Rry1/fK4QsHTlZzjkc?=
 =?us-ascii?Q?npS2PGulwE+pCE5uqO+PG7/JXRMHtgsKthPGkQaSFVj7NNxwqLN4979vEhaD?=
 =?us-ascii?Q?ihcMEQYsS6VE5ooLQcyQ3VNIwvmwXFxPPpj/ab8Cs5Z1U1PRFVBRdR4JcbXV?=
 =?us-ascii?Q?KmjilZUxPRcyAyM9VYSrQMHPRWVKEGE5/eVVO05eEDcovWOIunlv4EvDDkZs?=
 =?us-ascii?Q?rTBQe+NKDVxHqFuhzfga9LmCR+H1z+aNVxmhZyKum/vIkLXSvzaBaePHVUXi?=
 =?us-ascii?Q?KX3UiJnoz8y3P36gpV7Vs+yT+ta+wJqT0bGsGSaBobJwqR+F3X3yfKatjhFO?=
 =?us-ascii?Q?5+eqTy0c7H6YkKG5pRz42XIWtfF88JaCAxlY3rRUHyiMbHHixDRZk+l16KRY?=
 =?us-ascii?Q?n4D9BiV9oUzxIXxDgpXtjkTx3k3Vq8nH18IaFIdLfW8eTd08kRNnzxGf2r06?=
 =?us-ascii?Q?WmxR4GjoTpBWJ2mlMSIj1PT5+f6m/tSN9nfBguMZQSyzHhcwRKkwgXosQLx0?=
 =?us-ascii?Q?+F03Dbf8tMe2PZo6HzfKVWqxuEab50eY2EUt8LJgvzveioX5guMbxd7FTFf3?=
 =?us-ascii?Q?mWv/pWyztuFIXgoOlrK6BKeNisGAhglJh83+S8+DnNBApejmDdNh7C8Sc7+9?=
 =?us-ascii?Q?FRznh3ZXEo0n9VJHjjiRlMa8kcH6OlWYxdcRaXxTVAaew9uaihJKXHYhjWXT?=
 =?us-ascii?Q?XdThpbuyEqDF1a992TKZiisNC3mucTsZ51c4qMwbhQBbWUMgT8S+Wm4PmZtE?=
 =?us-ascii?Q?EMium9uGCdy9z/8eOuqFDGlW9JrcVOLMxqJqzwsEqAKWXIoUnziThu9M9o9g?=
 =?us-ascii?Q?BH8Zc39KnvT0UXoxFwVBEsMLFEgrSwlFuxkjo7/7PW4PyqQKdv+Jk3fN6NDz?=
 =?us-ascii?Q?2pFUgqTuRPs4Jk6O/4ATIEb5Yk6t9AdFYKN9PQXu6ez9Ej55Bsi+Jir2Vtbf?=
 =?us-ascii?Q?lJr+sOaLDmm2oyWHDUPj27x3fVI34M/6vP/KgV0s+gd57gSv8u1BHUamaQQo?=
 =?us-ascii?Q?YoMhXSDqpF8MFXlA7Ne93CjCh0Zmu5ZVIyI/tYRRZwZDhHWd4MonjOqkxmic?=
 =?us-ascii?Q?EeABytKCy0Tuam0ojy3nemkhnsxtrfrHVqpFS2LmvUjj0I/6HSiB2Gu1nsG/?=
 =?us-ascii?Q?GwJ2CwIqRgT6tQIFZ5JLOZ+Xr+Nx9UXhEQohtawfzrfUainhlKCFbqZeV623?=
 =?us-ascii?Q?R8bgbzL8niczf2gkU9WBfnm32ZeY4+EWyN/PWrxClq81rNct9U2lXPjT99IJ?=
 =?us-ascii?Q?BLah4QuBM8TL+zX6kCN+wRtM16DT6aLqUJDOGGQVJP2Q585LOtm3l36jJc1n?=
 =?us-ascii?Q?gqYPeVLkJ4A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YZvgdY1sOH65AFjzUcnulV01rBES/ut65Bd8h2NhoWE76ltLvNwBT2Q50zjq?=
 =?us-ascii?Q?CCRj7PQoJNO4naoejJGafPDkAhj6HqNV6n1BktCExp2Np1b7xh/4x0sM6gi8?=
 =?us-ascii?Q?8WlY3nsZGsBX+AjA60jGay60TPanSR/gPHJk08LHxlgmAFds35c5SBe6Rq33?=
 =?us-ascii?Q?hna3cAHv6f32nYHe6LSRXcBy97C5cehg25CBPRP82j7R1iBMioZEOMP68onT?=
 =?us-ascii?Q?IZCZLd12ItS12y5J2PyO34UmGMHBqcmzWeIQaCjbB4IcBjOS+BoSrg8rpaS0?=
 =?us-ascii?Q?MOhOPu4/5vY7JOlpHYVnYeonm3+II6bpqDxF99Vz2bHolUXtP+8AvoAE/DMj?=
 =?us-ascii?Q?v54HFSO/7Cl0k7J+bnki2KY+SfgPmWf7RmVzfvc2TaIaXghICutndM4JI5e7?=
 =?us-ascii?Q?16hltSe4/WXgqiHkbpJ3oCuLAUq+2KkkQWZHBMFw8ThsE7VfqTybcoiI4aQy?=
 =?us-ascii?Q?qbjdTP9hFoSeRSMDkX5VLDlt/ptFa96l1G6GpYOo4g+lwQUbxf/Y9Cd5Qsl6?=
 =?us-ascii?Q?mgG9LcjuTdcDkdjbWHUGhuGslmffHupWnv7NSwJkmhz/LAVWgXeGtHcuNz17?=
 =?us-ascii?Q?Wr5wE2hDcyfQOlxzPYOtv715Rn8n+hD+ec3a06haB2tiiVblFmiqv0BybiCX?=
 =?us-ascii?Q?s/DsrgoZXsZGULoP+ZWxJwPCReFVWNhfFEVGo5WADT4mayc2JHEE6EqY8hbu?=
 =?us-ascii?Q?HqIhaq9nLR10V77l3FyVZf2TYFdIc29i45mwmOk5xzxv/ex3va06gh+ePa20?=
 =?us-ascii?Q?mcW3wFkmfKAe6RguXDb3SeIFmHkYelTjccKdEJQlzn1C0dpGYEf7znLL2QC/?=
 =?us-ascii?Q?1vcjRNVwUdEnvSVgNa3zBwGHoL/RwAT0FWYIUl3ddjbqZx7kD+tX2Me/thyq?=
 =?us-ascii?Q?xavJu1n+T9J2s8iGJCaqb0BRGsWVbP/EcU1C8JN4/HMtXQURsD1ep5NrX15Q?=
 =?us-ascii?Q?26EyBcE+UST63jf7QBDIw5JvynYu8Ztm/VVVdeR9mXy9MKY5mBfk0irdUVnG?=
 =?us-ascii?Q?0Qeb4o0OZoseYE9lbTRi1SSNfYDnXoKIV7uHI3fdQJtid50Yvu3T6a04qCHj?=
 =?us-ascii?Q?Zb04lSe+vR/qq4/VoWjMgj9vweQpFvKfOO6xEDaGcqSwNqg7h8UcIR+lB+an?=
 =?us-ascii?Q?7BUcqEW1M4l+n6oqlb4Vlxe4apktfNWJXQZOor7MG1z+vQzq6+oJAmaD9FV+?=
 =?us-ascii?Q?rin2vCd++p2JdIl8U7djvaRL27B2/6Rtj8HgSvhOR313O/4tMYRk/f3DqFVO?=
 =?us-ascii?Q?LqCTJAfaYjTvIfCVgh7UHcEAMPDZxzLaaQlZbS52ddlVJ3HloFs6i2K1XRoe?=
 =?us-ascii?Q?lSyQyoKSfHR7i2MYFXn7HpxT5Dl5lOyc1T2HkBJ0LCzTj4SGYQO8TrLVimqt?=
 =?us-ascii?Q?4crX33TGpyCgEzA+NbnsVm0LWPZkwCR6PNGMZnWEWbZbXU+m+2HBOZvP2YVa?=
 =?us-ascii?Q?z91BPmNwT7L263Y/gSWRKet06IhYzN5NzDWrHtWCoMcwqfykyGFo4c9rYEXt?=
 =?us-ascii?Q?D2Xq3UT5bAPz39BwtuHSQasnNLEyhXnlH5H6OzkkUMoYw4ueCOQwuIi9VaH1?=
 =?us-ascii?Q?kRLwuCiVU6WmQCGWuvZCzCiZglM5uXLtAGd0kV89?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <522C254A6371EB40A73726646A05A2B0@namprd16.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed66d6bf-46fe-41ac-5e43-08dd75f796de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 17:14:00.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opTUKl++dIqYhHTmiBwzB38iruDwwQF/TKLpcjZ0XoUKkOhehpI4z8e/77jQlrUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6522

Nice, Jussi! Glad we arrived at the same fix :)

-Colin

On Mon, Apr 07, 2025 at 02:44:47PM +0300, Jussi Laakkonen wrote:
> Hi Colin,
>
> +1 for this, it was also found by Clang analyzer, I forgot to push my
> finding on this here https://github.com/sailfishos/connman/commit/6aa2c29=
10edc2186233da64726d4afa0c17aa5b3
>
> Cheers,
>  Jussi
>
> On 4/5/25 05:09, Colin Wee wrote:
> > These are freed later in filter_data_free.
> >
> > Signed-off-by: Colin Wee <cwee@tesla.com>
> > ---
> >   gdbus/watch.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/gdbus/watch.c b/gdbus/watch.c
> > index 8fa76cda..5cb2167e 100644
> > --- a/gdbus/watch.c
> > +++ b/gdbus/watch.c
> > @@ -332,7 +332,6 @@ static void filter_data_call_and_free(struct filter=
_data *data)
> >                     cb->disc_func(data->connection, cb->user_data);
> >             if (cb->destroy_func)
> >                     cb->destroy_func(cb->user_data);
> > -           g_free(cb);
> >     }
> >     filter_data_free(data);
>
