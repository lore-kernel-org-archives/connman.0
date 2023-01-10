Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347317E5
	for <connman@lists.linux.dev>; Tue, 10 Jan 2023 05:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL4clOHJN1JG3jOBXYzUsFBjbTLvid+/Btx5MSicpeAXnWEPAyFGs6rUwoltk5Xbf+7lRjnm/NAfenO4/RuZxaywH3Sm+m5m4OZ4AdTPl+7sTW7/mYPxpVzVWnj70hAJvxf4xm0towCmMpcIXYr3Baw5wwcZOMEpNhoUdixQ8uQEUd4RW21UP+IOXaLXGqRiw/Qwp24TtWdQ6DBKT2SObyCTaSWgjQVWAvZtDuKEplDzE8k0HrHjldrDxGh3XxLaqTE6Y2oVswKn8F1LtZCLseDW2EQrDeIIBUt/zbNZbx3KMuycZR4xpqEtMu8Bw2IosIJsDQ00LLcTWE6GTZc6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syBlvUR+rqw3C82Nd/xq6HIAdgN9p5L8L2+IFB8wlfI=;
 b=hVgLwJvvNPF/pDu1gTL20Pj3Nk4SUUZpgFsMnV6MV2Cxh11OzRbb2YZmnl4Gi4dLX/iD71MmiXOLWJdVKygBiAGVhsebkRiK59JKl/LqjgEUkNgsXie9yoceduf26g892SPa7etx6+MEDP2KR/XLQC14ynqeUH2P9NnWzWFdmS0E9bE1Dp84Kz63RIR/+pKJId2VogmmVxd8j2dIrRbGoAY3Y8+Fzp2Q1e5+IGD3OlS/rPnqA7bcLOPDalthX0lWB7CnI8A/WprxdCJ7Kz0w606xr9BGPP5bmsXYZcONZ1K/YQ8oGJhrtgU9/2Cx4BdRAEM/4xts+EQesbOiGAno0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moba.de; dmarc=pass action=none header.from=moba.de; dkim=pass
 header.d=moba.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MobaAG.onmicrosoft.com; s=selector2-MobaAG-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syBlvUR+rqw3C82Nd/xq6HIAdgN9p5L8L2+IFB8wlfI=;
 b=UEMU1FQNmwnxNJ0pZumnMUSV50Mks0B9Q70cZzRVRuiffqS96+YtOME3cmNmvwNJg7JBhUU41Z2eM4etj6AvP6V/6m/76zXOh1+/R1Co9m2ccoSiCX4MfXiWdmEzvOYilBQMUAvKpChJSFmMHqTSwMqMfeOWMBGINCX61dN8k58=
Received: from AM9PR09MB4756.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::5)
 by DB9PR09MB6032.eurprd09.prod.outlook.com (2603:10a6:10:3d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 05:43:49 +0000
Received: from AM9PR09MB4756.eurprd09.prod.outlook.com
 ([fe80::cb80:d06:6ed5:286f]) by AM9PR09MB4756.eurprd09.prod.outlook.com
 ([fe80::cb80:d06:6ed5:286f%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 05:43:49 +0000
From: "Stahl, Michael" <mstahl@moba.de>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: dhcp-client with fallback IP
Thread-Topic: dhcp-client with fallback IP
Thread-Index: AQHZJLYnnwhCOll0n0iEr6BF1XXE666XI1qo
Date: Tue, 10 Jan 2023 05:43:49 +0000
Message-ID:
 <AM9PR09MB47564FE0CAD5E5553184F12CDBFF9@AM9PR09MB4756.eurprd09.prod.outlook.com>
References:
 <AM9PR09MB4756C6950B763CC9F2A8887CDBFF9@AM9PR09MB4756.eurprd09.prod.outlook.com>
In-Reply-To:
 <AM9PR09MB4756C6950B763CC9F2A8887CDBFF9@AM9PR09MB4756.eurprd09.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moba.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4756:EE_|DB9PR09MB6032:EE_
x-ms-office365-filtering-correlation-id: 177e4168-428f-47aa-ea92-08daf2cda648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ml2SDPZEn9MRM8dL3dO+zd+jnoyzc/tg7rc4rvlvsTtkbMwoCQKn4LNtk2HDnGxMwt+A+4W9vU/wNq6WcFk4WobSxPDN2kz6G+V60JKsA8w5yGt7qiGSVlziEjGlHB69rlUMIH3WcRRVz88jAvdRPHAwwJRa/X5RDZ80bxmkpRbvhHGnjWTfDmViY3lmPQRS0LXugmOtUKIZhTzVlYT+xERZZBr8iU5nYa5EGS3Pc0fgWb8bjVMOusBhDVaJ7lHWCK10Pc8dgxLgRP6DIvVJlmnRxj5i4Z5jHIbE2sxOjF+aTqlkzHTaisP7I65dok7sTHr/o+TJU8GeJhfVJBCxszdEeeoJJYF3rA8hxM9akycG5FzQgFqj0pf9eWkXqzQ8uWVFmGRbBIzsWpoY2j4nrCDtobGrOQnNB/a/HJ2WrR72BRXQ1WWs4nz/LbsYaPTO7aEIuzIzmyeNXDPejPX9ioTIC8AyryNXZol3uFL9PtbxX6yXgsfMRmxcWOWV5Qt/RVDT6WPV8nB46z9VRhX9Lh6EOrF+wpNmWHF2/qKVhOVDL8RwXENnqg8Sy4Y4JQCWWDRK7jRFE73MnUviKRymgQbadcwrFhLyg38rlE0fDbuvgQC8dQdylWTex7KJFV4Hqpj/oQB6fJjzOozaRkrgkaay9HgbZImnIa/N5Ytv4Ig4MejP4tKeYq0Zw7A2vfgrqbK4k+GhzAXbtmQh4Etn8Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4756.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(376002)(366004)(396003)(136003)(346002)(451199015)(33656002)(558084003)(2906002)(8936002)(5660300002)(52536014)(41300700001)(3480700007)(122000001)(71200400001)(91956017)(66946007)(7696005)(86362001)(76116006)(38070700005)(66556008)(6506007)(38100700002)(186003)(55016003)(66476007)(8676002)(26005)(2940100002)(316002)(66446008)(64756008)(478600001)(9686003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ubwVohZfIJrCNRyeop1z1hhOTWLxk09Fk07nhFc2irScpawrYU7J+ntsXv?=
 =?iso-8859-1?Q?QCcGH9K78LvhtvxN6SJ7Dt72YUjnyN1KmzbP9TgUf/AKwvPbpkN/I9B0YR?=
 =?iso-8859-1?Q?JcLBNvfzTmAQ546ND7MpVIn/60ecmrIoEeN6NT0obJ4snG8T16EycoT/FP?=
 =?iso-8859-1?Q?OfJPwlHKvRdY5kWfnS4IeerQiw4TWzQz7IPAGxQ8uqu/35CGr9Bi6wSwua?=
 =?iso-8859-1?Q?SGadWdnO6C5p+nAaK1YfBK4FWiFmgZSzBB7cFRGFHNgbl3XSfRFjka3y4p?=
 =?iso-8859-1?Q?d0DIZV6EBxMbnlEhbTtHqd5+2B5695kCsFdHEHMNbfjdjfY61AbUgXy13z?=
 =?iso-8859-1?Q?v0RbINcrWJ6ct1x+U3eOkHoiiLDRP8aGR8DZBfbhD8FMLnQU+1oh2P1+Nc?=
 =?iso-8859-1?Q?pHQ4LvPv7RrryjwyhFYw/GvymIggzLT/UMo08vpi888qqEK6Hfx47dwcsW?=
 =?iso-8859-1?Q?tcOdcDGfkMPHZIOAZwPR6uO8jdtU2O3r6iD86It6jF/bmBF6GMn/viVKcX?=
 =?iso-8859-1?Q?uQZCJ8XVyXE/uJEkc/nRVm13Bldr3ZoBh97shq541xB+HxIHaeuJyDIzmQ?=
 =?iso-8859-1?Q?S4GDgjoEhGORjRCoIq2GPbJA0N6FEOxR4wHZ3LDImazzhu2WDnKm0AmN1M?=
 =?iso-8859-1?Q?ElyvJH9H4oU2oDKanrNwiNoM8J53VUEUCKlm0IACaXHfnsvbRc7s4JHPTF?=
 =?iso-8859-1?Q?z+s7QqmlrGJIKP/BOknEtNQdF+gZBeBhJKM9GoibRgEkpiCmfb1CNWe7cl?=
 =?iso-8859-1?Q?4IU1gksIcMyj0Fsbd9pNr0jkEPrL4EmopEeGFpuNGxMRGkrq8faQH6geWp?=
 =?iso-8859-1?Q?1qXo/Q42lPP0t+xZpn/Kj6eb3VXbBBGhnPQokhNqHHmid7qTcf/CnjLTFQ?=
 =?iso-8859-1?Q?PgCz8z7rS1E22TNBADj+Jbpg2hSkmtgzUCPAn4Zce8hDELXP05+Fv1OOiR?=
 =?iso-8859-1?Q?Zzw83rvJqVoISKAI6l8gbdJefHsVJ0aB4gJC7RxQANi1GJAolw1UADeLOL?=
 =?iso-8859-1?Q?ccHDbf6e3x+mCfmiX14scMsrkeDP3qBXeeYHfTeqQmuHy8Tv5lpnq6YjM0?=
 =?iso-8859-1?Q?/bFVVVR1M9OGi5M8hxk0Ziiy6yY40cPA/GA7MVlEnp1Oi8WW1ys5TwnXsF?=
 =?iso-8859-1?Q?KPKxGrpSjYoQG9ykOvY1DRlqxsUoRhwi3mUGLDaFYKWWjxhvs57eqAYVWi?=
 =?iso-8859-1?Q?dlZl1Nf9IlCYEC4YI7Y3xuLYe70QZLXxsUDAQF6k1gpWlxQ3Ea2zCprHZ6?=
 =?iso-8859-1?Q?ope44EGST86Y/2HDmYRIl7Mepq/E0sk5ZNsLC89AQ5SipuoHmuRnyQBBgV?=
 =?iso-8859-1?Q?A2KVRp+tTBEEKeM3fhgpjZiopLmEbtkayxGCcPuodXlCxa89kJVnWQIzBC?=
 =?iso-8859-1?Q?bx3xfvQp6d/uJdNeovn/z7PjjJZPCx9DEEWqO/bPvTeUlpTDCVdHV8F1tK?=
 =?iso-8859-1?Q?Cj9fvTQBHmDec2fGRJ43LH4J33pkGSNTdTw/CZLixBoJX3N/VjPzC9Zhy3?=
 =?iso-8859-1?Q?LiwanECZEtPK3wocEUrLHmCMtxmfFWXNZBeM6fI21HEo9IeR44chIE8PsZ?=
 =?iso-8859-1?Q?5a6lQeksDQ4CR6YEKON8X0tGNMT4fcXYrDR5KZfYgMnJDjW6zG0J18aSuQ?=
 =?iso-8859-1?Q?nwlyRYk4/e9q0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: moba.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4756.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177e4168-428f-47aa-ea92-08daf2cda648
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 05:43:49.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f43877ac-6976-4beb-b238-f92e268fc98c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMsW3+pLf3I+4eT4CkR9sKTkxQIafolSDwRbhio2OqplVpI8qlyK2LXZSc33nf1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6032

Hi,=0A=
is there a posibility to configure connman to use dhcp-client and in case o=
f timeout or x retries use a static IP (fallback)?=0A=
=0A=
I would like to do the configuration by a .config file if it is possible.=
=0A=
=0A=
Thanks=
