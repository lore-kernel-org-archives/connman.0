Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2114.outbound.protection.outlook.com [40.107.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AFC2D6
	for <connman@lists.linux.dev>; Fri, 19 Jan 2024 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649913; cv=fail; b=ak2tT5sEOlzDWp5OM9A1SuBP7FxtQTfOR8SEbjkgAKtw6cZEwsSzHXUcoJ7LljuL6C0P7LX9KDv1Jx+8TpZn3pTrFTNZDY+U1/m1Jbsij7/AytqVexzG7QIBGt//vYCZtjpMrYGKn9FJZ3dhHkMngceOvl1pbHViBdecogCR5MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649913; c=relaxed/simple;
	bh=fgtfNOm7tv9WvbDxchcDlJpOr4bcMEm085vgO8GsKbM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I5wwYe3m65LGv74fXb4/u95P871pB4iH5qmU/L/nrIfplg6F52P9JnKjeVS7GhHSbOGb3ywb6ZbXwTdHmuXe8OQHjy7KVUtZL2ONpqosmoMJH2nSskUcH1wA+KfmIYKkPvsxyI43SOinN7Xh8byLmsWHKz5BSP8zdWos9npg2sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=EjzhJqby; arc=fail smtp.client-ip=40.107.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="EjzhJqby"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2V3AADxNSVa1jt1cVx8CebhdVBgfOGJJwe2gA+vJz7jL+iXVoeHWbUnPv8f5jJiGuWEYckdoEr3JJvWb+zWqI+HqykF/W1Jnk3q0NLboiau2knor8IPpX9KrvIl+KhcLB2otR0nmKNmSra8Zl7CpNVWiANbeMnBhWdK16OcgMRjX3Dhe4OT48kp4Hw5WiHmZj8CpRwVf4O36HtFjFOZDF1pZSEWiTNpugrGUSFzNHjnqynnKS3XLCb1HmZnEPz1RjJB65kMBGNXjWuYlHN5nXDebLlMn7Lk5FMntgxhOMQpA15e4H58nXaZAydeFRge3gqZyJYO0Gjy2zlWHKIo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgtfNOm7tv9WvbDxchcDlJpOr4bcMEm085vgO8GsKbM=;
 b=cI0X7NvHfih3h2mrvWwoqhXTZQfD/Y5NRiB8X0G0f0X9GKIv8MTSX367WDl433W6nJZrPImqS4axfHVNs3BIGeLMwMKJ2mS0WSQLpUGsY9pKz1Ag2tF755cUR/AvKdMY4G1nyIJCqMCzHj0lfD7EIN8KW0iCaQP/ZDNEtvPdVe1vnmoTFT7aM1hSFfmHWtFxmyEzPssZw2Em9liYWJZxL1x92NgV84X2FgXTjhZPV1Vxa+7mC3YvJ86yDJcAs48DtgkGFPNLCnEFYT4qd40qzDuMkiTRFWmwYrHnqv901no/PX3BqzrlnRHn0AcFFLhnuzrrkFWuf2rZvh4Hit5YKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgtfNOm7tv9WvbDxchcDlJpOr4bcMEm085vgO8GsKbM=;
 b=EjzhJqbyUAkGicOIpgr4+jlF8z9ey46ok78CEjdQ5hzy01FYKX4SUWTniXI1PRzaRJ6/nZWydX0YjdbIjQN5hkqdRsZUCpEQHen3vDRxwJHAl5lcfLF6jyruEu6gBrPaVO3P2hYBkfv1jFRn9H5sxgQPN+GQ4t/XQsAHR3S1Xpg=
Received: from AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:416::15)
 by DU0PR10MB5606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:318::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 07:38:25 +0000
Received: from AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::724f:ad66:ebea:8246]) by AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::724f:ad66:ebea:8246%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:38:25 +0000
From: Gabriel Sanches <gabriel.sanches@prevas.dk>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Online check failure does not downgrades service
Thread-Topic: Online check failure does not downgrades service
Thread-Index: AQHaSqpiq5fsa/MBPECOJL3GP1Q4TQ==
Date: Fri, 19 Jan 2024 07:38:25 +0000
Message-ID:
 <AM9PR10MB485454A9E0F1F672126EA4EFE1702@AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4854:EE_|DU0PR10MB5606:EE_
x-ms-office365-filtering-correlation-id: 3d0d1d86-a938-4451-1a30-08dc18c19ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qxvBo0beS8Gg2nWvDFeyPBUDAJuk519FkcnWNSC5f/zg6TsI15EFhdZ+f/8Vw9KLFH8pvzskuYUMp6DjZwP4DR3+ySlGvvt1Q6iCbuFECzmgOSJq+aiyNRgiiNzmv+DBeAVIsvxsl34oqZg2Goaen5p0DeJtgBTN1USu0CPjxfRHM2FRiCj+xngfRaZhJbmA2pgQX3+7XA1ndxDEDqVJvhr7W3L5G781BOlD8kHmUMvFg+oj5905YUG/UArdYJk6CFI9LbccGO3MnUEPjmmyYIHkdFlhli4JIGdlErqKEipgNcBigMMD4rpQmvu7oGeQ2FC+WdclRGjn7F4ZeKW/WADNGyl5EV1ztu56IIE+HwpPRBjLtA/7xC2Qh246JUyMjARnLGJJqA62WlSuwZkerX5lxPJdHQclX6D1EQPnN/KmA5SKRNQTxdpA4hl/MH0EZJDPr4aahTynNfCoiXG/vcKo59KSrxX45VqOxfSzVZBDf2hP9Zc+2sDAte4reKS8lEWC3JUksGEt4zi+QF8NfN+K2FgIxaX2timIgQtvNu8XbuDCDVLvMazdlvJ0Smk78ueiPowfeLnYYISkRqzt73LRZh23NMUlC7WnGovWyVYtnv0rxQ/i+0Qv8KmEiCOh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(71200400001)(478600001)(19627235002)(7696005)(6506007)(9686003)(83380400001)(5660300002)(2906002)(41300700001)(91956017)(66476007)(316002)(66556008)(66946007)(76116006)(66446008)(64756008)(6916009)(44832011)(52536014)(8936002)(8676002)(38070700009)(38100700002)(122000001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oTjoG9pltgbeMLEhS/0iXWaE3b3ZE++asCEQ8ZoTxzsQ9Gsue5HNBiD1nz?=
 =?iso-8859-1?Q?WBXnEXsQgyaC8hvM6kmiwJ5ttAb0bzABKYnhGRa4+J9Q/fVYQTBkAbOLsj?=
 =?iso-8859-1?Q?W7UQKqHEfb49PMRBGN/Tjb5Mw1azVqafldgwcQmmgV99isLzfGtCKau8yy?=
 =?iso-8859-1?Q?1AwPFU0JZ4f/RfZscj0DuSPRjgKQPNbqortGXC6pnspbf/EU/HwmCFzV2V?=
 =?iso-8859-1?Q?8LqrSP/prhGY3fNx4apwlO5E2lQtxxaFfDkIRWeCXQP5I65xhTp6Er65nY?=
 =?iso-8859-1?Q?xyhM3VFD5wqoagi146H8rMB9XXV2pyg7tA+7RZcutmBjLmX50a51aR8F3r?=
 =?iso-8859-1?Q?Ge3A+CVd/KQds7XqgByC6qgFF/5hBkzU4pwZuX3i0JSBCln2gan46TdiJd?=
 =?iso-8859-1?Q?V7nNVMPn1f6e3e+ivpB2MXZXvci+H0+EXeMLfLEaGuArVGThewyBVv572n?=
 =?iso-8859-1?Q?9c7FUpzalQCYqcSG1dupDOSCrk6wJg/zBr11PnyF7oLheb5BygMW2maUO2?=
 =?iso-8859-1?Q?LE2n97qns7wr5kZwAYOWs+2hJ2J/EPABohWJsd37azObuFreE+rg6rCUGd?=
 =?iso-8859-1?Q?zd2GrcpUeTHJWfuikx1DguuO6gwQWmXFjtVjAojLriHmrR4zlq3N1X4kiR?=
 =?iso-8859-1?Q?xjIwuUWon5RCmn4svGhc0qcqb5QD9S7ppEKk2nsdwf6jWstiqvCwwgti+o?=
 =?iso-8859-1?Q?YuMn6MnugAlTzxn31ZNS0w2ygIKpRXzdPeiaK42xZp57ZMYSHLATjte9wY?=
 =?iso-8859-1?Q?f0nbhiLk7/ewE4oaA+4DRXJj8umi8FbH/KRmgVlWVvWbXON+dTwcSd0vGo?=
 =?iso-8859-1?Q?4T9uTTgck3uvAXw9/lFHND1uCplFnHris/80hMGtVvXRugPtt2BEp6MPzB?=
 =?iso-8859-1?Q?lwQYnj3Kgp2aakcPxT7FT9U2yBQHvOx9WU15K23o+hSd71NEXL60NgXGPv?=
 =?iso-8859-1?Q?Ctars4UcG4n+Owe3a0NYAXs67O+UZXQ6oLTg5tFcK93NDwjAcFMXyHjZ8e?=
 =?iso-8859-1?Q?UvxWAdcVP/3JmWlZwR26ndIMwrWbt8mM+unU/T4koXviqU+uIYPdYM2L3D?=
 =?iso-8859-1?Q?9rahuOcGNMsur5njFiEq+KWx9BoFcP8HXJEO81W6LOa8EAiHKOMz/03n2z?=
 =?iso-8859-1?Q?6qxTacIXHLwh8Lw+alEw2UpL/1gyxI6h3Yll5u1lOXKcSqhTBA3IpLrr/K?=
 =?iso-8859-1?Q?K/NBLARVDQ+SsUrHVuuRWdi7zuyoxk/YYXv4BjgoJ2vdN52/sLynyWvVpO?=
 =?iso-8859-1?Q?P8t3Xn1UuTGjCsSIU9u5H+VMWCi2L8L7N7tQxioSrXg7zEcjqP1JyeC19A?=
 =?iso-8859-1?Q?qk4H6GhXwVeo07naiz011JeLuowlsEbFKOeNHYgGBGg4gpEcyORQZTXV+y?=
 =?iso-8859-1?Q?SHlFDp/UgdcC0noVQ3JEDFQW6FAOLFyBnPrqcHm7Ze5yEw/rD4lLNYDzIR?=
 =?iso-8859-1?Q?Z8knBtEDqnmJjJBkKcETzzwDArdLZJkqOVowoONEVjzdC4mPeS/4qMVCPo?=
 =?iso-8859-1?Q?25X2QFW9r4Ec6c04qDPhWDOIenDBhTJReSeZQFIcFt9rj/sLmPtWzPBUEx?=
 =?iso-8859-1?Q?co38bxicxmGVf1zt2Hrw7QPTiRkWH7A1RvYEJWlFN/Rxn8JrWeTWJpuTz8?=
 =?iso-8859-1?Q?QazpFcY540o4EVhNnhAmQdP7efb20GLny6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0d1d86-a938-4451-1a30-08dc18c19ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 07:38:25.0816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0iiNRoA+SF7blOPWSsI8CQQmHjfQJLqPADd5L6FIAPHCNkd2dno2K0/cTz4y2XK3qGloqb3Q13Ia1KO1WpwuSJAvt/9RZ119rk/DNPiIc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5606

While testing the online check on continuous mode, I found out that it does=
 not downgrades the service after the threshold is met.Seems like ipv6 bein=
g on state (ready) already prevents the downgrade. My assumption comes from=
 inspecting=0A=
=0A=
src/service.c:is_online_check_failure_threshold_met_predicate=0A=
=0A=
Is this the correct behavior?=0A=
=0A=
connman is on master@807ad961777ffffad36f53ea034583466a7073de=0A=
=0A=
my main.conf file :=0A=
[General]=0A=
PreferredTechnologies=3Dwifi,ethernet=0A=
DefaultAutoConnectTechnologies=3Dwifi,ethernet=0A=
BackgroundScanning=3Dtrue=0A=
EnableOnlineCheck=3Dtrue=0A=
OnlineCheckConnectTimeout=3D10=0A=
OnlineCheckMode=3Dcontinuous=0A=
OnlineCheckIntervalStyle=3Dgeometric=0A=
OnlineCheckInitialInterval=3D1=0A=
OnlineCheckMaxInterval=3D8=0A=
OnlineCheckFailuresThreshold=3D1=0A=
=0A=
relevant log:=0A=
connmand[2065]: /usr/src/debug/connman/1.43-r0/src/service.c:online_check_c=
ounters_log() service 0x18f29b0 (wifi_e8fb1ccdfacb_6d7563686f626f6d3547_man=
aged_psk) ipv4 state 5 (online) failure(s/es) 2 ipv6 state 4=0A=
(ready) failure(s/es) 0=0A=
connmand[2065]: /usr/src/debug/connman/1.43-r0/src/service.c:online_check_c=
ounter_threshold_is_met() service 0x18f29b0 (wifi_e8fb1ccdfacb_6d7563686f62=
6f6d3547_managed_psk) failure threshold 1 failure(s) met 0=0A=
connmand[2065]: /usr/src/debug/connman/1.43-r0/src/service.c:handle_continu=
ous_online_check_failure() failures threshold was met 0 failures threshold =
is met 0 default 1=0A=
connmand[2065]: /usr/src/debug/connman/1.43-r0/src/service.c:online_check_c=
ounters_log() service 0x18f29b0 (wifi_e8fb1ccdfacb_6d7563686f626f6d3547_man=
aged_psk) ipv4 state 5 (online) failure(s/es) 2 ipv6 state 4=0A=
(ready) failure(s/es) 0=0A=
connmand[2065]: /usr/src/debug/connman/1.43-r0/src/service.c:online_check_c=
ounter_threshold_is_met() service 0x18f29b0 (wifi_e8fb1ccdfacb_6d7563686f62=
6f6d3547_managed_psk) failure threshold 1 failure(s) met 0=0A=
connmand[2065]: /usr/src/debug/connman/1.43-r0/src/service.c:handle_continu=
ous_online_check_failure() failures threshold was met 0, default 1=0A=
connmand[2065]: /usr/src/debug/connman/1.43-r0/src/service.c:complete_onlin=
e_check() reschedule online check 1=0A=
