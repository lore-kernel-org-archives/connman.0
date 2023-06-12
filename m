Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2080.outbound.protection.outlook.com [40.107.12.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A491F189
	for <connman@lists.linux.dev>; Mon, 12 Jun 2023 17:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5dlDdqNbI+3djNC4m5oD8kCZ4xLj7LwraGnyszJ1zk16IiifKoJm97bnI1W6585TlWTSV2+T5TrXjCImHjr3bo8ZodeYj5ceMOoR1YBmXbomP0JmeQUgHi+rdIBXZLUiUZXc/A4UYBBvbqW0E0B2T/LukysZ6UlFDlqxlEt/8n1FKPxJB9HlTcYL05UQKTmjOxY3FPKKz1F5+SYq33bgIQWdy3IJ5iDCMpCf0bPLqL3SHqVnv7RWAx7hiENW/jJlkdK87Jp3Ytkt9LWIv3WTLUppckk+0+5NI2BKvY1yTjAwq99rHakxh4buLzoyc9HEKAIaFwYWPn97KykCalw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOOVne2tQbfSSqhf6i9QHIVsTMu/aw57zb+eTbu+C9A=;
 b=AvpC6O9zXMSfGD0RBIlMSx6wIGeUD6/eExxU/fV2UpKLKCD9YculV17OWkLdAhTSuW+wa80wU5mrCVxj3kdeCTSW2LPNINM9PQ4/5bA8cKWE02nA4TfHpcqE8qetEbBY0XPy3kN/LW5sfKDkMCPWf5Jy460r1XMcjYSRM+/+tnV+EOHq9WVTPm0giMxqo9H3WpRgVLg4/D1NwV30UUzSLJdmRwPFNgqc/ACQdCQ8+13UMRl0r8WTueO6ZDNSclgTPxEp/wn1gpZfbYZg5biYejhrWItb66l57n9L7C0ryVIwRIOtRkgZ74+Q6+ttsajokH/UyDjWruKAL4N1KKSq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOOVne2tQbfSSqhf6i9QHIVsTMu/aw57zb+eTbu+C9A=;
 b=t/BYgP2ajCr8h6k8U8sKOVAg7hUdBQrPK6wMFxyCOW0SIEvKM45ehD9HSqyYXz02p+WFuiLyyB6V3YRcgXrmG2tVsuozUNRbekVo7grjpHID0WPTnvqXgRTiVUG+6nqze91HVcI1lcjyUDNY5cKjykZc3ag0u2pgnfwMDs675Z4=
Received: from MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:15::22)
 by PR1P264MB2030.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 17:33:53 +0000
Received: from MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6da2:b278:fe73:b46b]) by MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6da2:b278:fe73:b46b%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 17:33:52 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 3/3] wifi: Fix connect-failed error on user reconnection
Thread-Topic: [PATCH 3/3] wifi: Fix connect-failed error on user reconnection
Thread-Index: AQHZnTBRYpo13UT7VUKWojwPY6103a+HLgcAgAA+fw0=
Date: Mon, 12 Jun 2023 17:33:52 +0000
Message-ID:
 <MR1P264MB1540A67A30049B24CF43BE759354A@MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM>
References:
 <MR1P264MB1540A3B3D6777C951E8910789354A@MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uw=TcgdSf272WWnZ=ySTSUrx5En_+SjDGv8taGB2ad1yiQ@mail.gmail.com>
In-Reply-To:
 <CAOf5uw=TcgdSf272WWnZ=ySTSUrx5En_+SjDGv8taGB2ad1yiQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB1540:EE_|PR1P264MB2030:EE_
x-ms-office365-filtering-correlation-id: 0c984c38-beba-4e32-e439-08db6b6b30dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RpeeBJtHWP4XjfvrkVg82Djb38OXE2pOBm7yYXJsyx+vMcZeiDMOr2Melu4gqzm9Qx6raX8HxHCODOYaghmE4zqrfWBPyCWP9nV9NAQkdZnwTdnxv2UnbU9AZ20TEyQ/bD4Mu4iYm/unnYv8IMezMxTMOmOESw3WZGbFNIb/YugChWj8SjCZotNaEQ81JB3mjLc/rghq4jcseGgmnLoDjdnKi6UcfDSTFGOODZaRWzEzYYpd0DVlXTfrRTtT2KoUsz1GAQI2MRQls6UHXE+IbedYi1AbX2ap3eLuP55g5lRhUEKPnfG4HQBQ47k6kZhwcTCm2QisuG7VTDQc8enahm4S0U4JLblG4jwwDDB/AaRV+RI36M7J7C69rimdAs9j5o9pI8P8qk0+B9tercPXTvl/B4PM1k6PtxCQZXcbJUePh7L18bcroEf07s5t8hvT8RcUS8KKchFVKjExBig0M/M9mlnJc+XqT3emj937KbGqe0O1EFiHBmfFxNz+WHVki+dSIB6BsZmSuYMmsMW6D31r4GW+Yz1xRNo0qJfsGcHh6x65ZVRN+mum4WLSEgcB/btFAyGkPM7GWCti/HKwpb9vgDM9xFZHbg2TUcgmZOWMtnAxncZ3zYB8WbSkRQA8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(6916009)(4326008)(66946007)(76116006)(91956017)(66446008)(66476007)(66556008)(64756008)(186003)(478600001)(2906002)(8676002)(316002)(41300700001)(86362001)(7696005)(52536014)(6506007)(33656002)(558084003)(38070700005)(122000001)(8936002)(71200400001)(9686003)(83380400001)(5660300002)(26005)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Qx9Jla1xlSCWeZpbu4v150FPocG7rNcqtt8smIpJplHvTuaGOOVmYeheoj?=
 =?iso-8859-1?Q?oQB9ZYtf0mxE2xs321gEhBHJsUfYUBd0WMLw407ke9Kz3HUwMqcG7AsRty?=
 =?iso-8859-1?Q?xMvsmiMGUKnvlTUIHX09SBTe6TfRiC2I5kPHgCzGPtM6csMtN0qozh7fkB?=
 =?iso-8859-1?Q?8hnJNMKnxzcTRy6ADcf7+pdFNOH54Z0ias2akxCC5SO5pCbIqk9Jnh9+j9?=
 =?iso-8859-1?Q?dyBJyZHuavX3nQNsDSb25+rzu24iHMGKBxpUHMUdYTt6Jg3/IZA8N9OsCK?=
 =?iso-8859-1?Q?1G/VVTB4u4lopiVLY6W44BkQUu5KBrcxjKxzJ3vt81+VjuYB+8/C39uaIc?=
 =?iso-8859-1?Q?HdnGY7+eCrEcWNb/Icihs3gIjUxdZP6Tf3EFxzDx1e0t+TxR/W0xkY7GMi?=
 =?iso-8859-1?Q?zrdpBQ7ff7aUDEbLZhQs5tBwolGdbvjWFplpeWgMdc00sBd2Cnt089ydmo?=
 =?iso-8859-1?Q?XA6cK9S3ZcCRappG5QjHgB2Lk3RRvLZFNgYxHeG5ZHaYnT77rZFa7XGnWN?=
 =?iso-8859-1?Q?mtwyfojtglDJ33G4qeVI5bAkLgIrKuP2NH8GMQLoH3UNTpAWSi//nlwr4d?=
 =?iso-8859-1?Q?Gy3s/19kHw5m+d91ZzPrqVgTu0eukP/6DgqkeuxuaIX+xm6tRwXsmq8xns?=
 =?iso-8859-1?Q?rV8rcTilxHxanE0p3neQaEx0cizaG+nt5GuuWPgGf/qR+yUAUMSAgnl0Bl?=
 =?iso-8859-1?Q?twHpi5rNTIf9n27LNU5txIpdFdCPSSXh/bo0p7uOmi2YrcJdz4Am2sO9e0?=
 =?iso-8859-1?Q?QXf7wNkgruXZrq3sCzglEttmcynWvdRhMk+hR1CA9Wnwhk5W8WxozoAPvG?=
 =?iso-8859-1?Q?O/7Ou0f1+mjk73CKsF9Qf1tQUikWgikx/P9Uc+70MhRsMVSub91paH7ulR?=
 =?iso-8859-1?Q?9ojj+h0whbZCav9kfLkMJtZxM+dtrydyLbbyI9uUipXawORobhfZQTchc5?=
 =?iso-8859-1?Q?tW+P3KZmS094ZrqmmUZmZAesKWMAPxFKC7bsAodovc5ohTt/W9nuMBwRtp?=
 =?iso-8859-1?Q?xgeW3EBs5+JHbNisp0r4jpzoWQ8SFFYVtSeaB0q+J+HnQvQZMEF1E8pZlg?=
 =?iso-8859-1?Q?27Aus59tlbh/qc/kWjgBAqRf5uYlhgCAh+dYyX7WvsQrUhgCLprv8iAxB+?=
 =?iso-8859-1?Q?K41V1JJtixBS/iIRYmY9TwUVRScQLtXYvJ32vn4qBrj2Xa28pmdEpuql61?=
 =?iso-8859-1?Q?pX7uJgKUY8gkuJuaCqPyps6TVjc3jPGMdRn1A0eNDgvJq777lEJLEibxqI?=
 =?iso-8859-1?Q?KfSXDsA6g45PBAvdUJreD3rLyMfrIyqcqf1pW4bC5Vgv40XEAFQbE3uf/4?=
 =?iso-8859-1?Q?HjlWqJMeIEkOkgADO61mNl+EZRPEs4BYoh0xH2wImZBHoNPQysFtkQpf3R?=
 =?iso-8859-1?Q?6ZBrLaJHbSQg2v6ZetSvwFyXlNTjz99Kuzdnc3AjLiWbDJ8cew/T5HY/QY?=
 =?iso-8859-1?Q?7zG9KFbcfDpF5OYBfZWlNHl5yJlJEElNX9gbsqtW9igpeJvVnfY723eWKA?=
 =?iso-8859-1?Q?iUEK5IhX+Wrpi6PvzBRKYb7JjWBUyG19x5qt3kYR5qBoe7iJPQ8I3oR1PO?=
 =?iso-8859-1?Q?PmMIO9djkj0zb2KOmuJl1D2ebpAM1q5pdWxRKh1UOTaOAG1QT1klj5+YAO?=
 =?iso-8859-1?Q?dDqQRM8lFwUZoX/7kWsq/kx7fQs0lXs4pXovhR7HSLy8zcLNxswqxrvg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c984c38-beba-4e32-e439-08db6b6b30dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 17:33:52.8208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8XxLJb7V8Z4ukm4MgVYrSXhfuLC4Tmvpi7dQ9eL4XyFKG5uYqK+m445EvWCi2RG1ffDy3XzC5/tlYEfUjlkJWFnrQsW9AB1hfhZ2IKJHmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2030

Hi Michael,=0A=
=0A=
> Can you please add a trace of connman or short trace of it in commit mess=
age?=0A=
=0A=
Unfortunately I was using my own logs, which are really verbose,  and I am =
not sure=0A=
that the basic ones show the problems.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
