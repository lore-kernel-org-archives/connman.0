Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90055.outbound.protection.outlook.com [40.107.9.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6163FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 07:26:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbfuDPwBu5OkDmes02E1fylrtMzCcgO64PaM07Che0z+kL2Liz5BkPH07Pyi2Rn/nPZuvRIC5HLf8Bz28EEqcW91NPuF3kf06CFTe029UAGdQDRaSM/+ZvKPJI6bJYo2y59/HH8P3LCok+2L451AsKxsqflQoVlMguPiOSeztw6eeRd60fuoGVxnBXd1KhGrZPlJVnKuH288LuVTP+TLgP5LlRaNbj19VGQnMoZah1o7onOgLKddCAtMAGIN7gYmh5y3LAyGoTcc8G38ETSt03n1bbI1uBB0iJ6NUlYBB6111yzsnaIJvZyy7b1DNFfGIcdXtw5cbHdkQHxo0PtRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jl6MdpIH/vdlbwuZc255qiGw9w9I8WeKgbQNcfXDdw=;
 b=T/123fHrTcsZ0EtgDtXLEW92zV0kbx+se6RFEEdDeaOmeMc94ogovdaO6pKSdQdljcwiFGnmiYe0yXnicUDKAGhrKH54zTygDw2KDoV8XNfosB9AnxaG1EepCiFJG9MKoXlpnfePquniR/6VU/gYDkodXZ59RQOOvQWudOjP6LOJxuxLoGFdPLz/PRhfGevYqbZlDemuEcvMK78rAy9FckoVcq0mqmzpSBQ7sgPrNbFEak2SuEdMrLbioAhgK2V0jt30Aq71BD6T+p1kKAE5RnkGPO0Nn1/+jBQnhrqeITenIJ6LIx+1A2d3ljs8xeIiG5ktA2USudHr2nu87FCiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jl6MdpIH/vdlbwuZc255qiGw9w9I8WeKgbQNcfXDdw=;
 b=XTxOTTeNLsjKIf2YUWedcVt1Xd7KOzgViBMN4f7eUvq3C7ex40xTVmBx5hbfOM/ubLE/ab24Q3PfDbviINRSOm9hxuSiewmqxoxUakbjYxtdD+EaFIjNUniq+0LM12q6TiT5DDSb8A1INbiSnljgQAYKV6SQRYV+UVgxB4o1hnE=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB3132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.21; Mon, 30 Aug 2021 07:26:44 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1977:70d0:ca8a:7c0c%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 07:26:44 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] service: Ignore state information in service reordering
Thread-Topic: [PATCH] service: Ignore state information in service reordering
Thread-Index:
 AQHXaEAKBbWMy4FLOEmVuozxMfJz8qsvXjiAgAADxYyAAAh0AIAAaLYXgAXKx4CATus9soAGs0AAgADTaH0=
Date: Mon, 30 Aug 2021 07:26:44 +0000
Message-ID:
 <MRZP264MB1544876132AEAB19061AD39393CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702075335.opqr3lc7kzell6lv@beryllium.lan>
 <MRZP264MB154432CD7A2E3A804089C9B0931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210702083720.hwb266z5eo4xlv7f@beryllium.lan>
 <MRZP264MB154471078FD87663548DE9BB931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210706071911.6rl5b2nrooy6lchd@beryllium.lan>
 <MRZP264MB1544E87C75134497E7EBC0D293C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210829184830.ti3pzaz3nchpma7g@beryllium.lan>
In-Reply-To: <20210829184830.ti3pzaz3nchpma7g@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12145072-920e-420e-6f4e-08d96b8784e9
x-ms-traffictypediagnostic: MRZP264MB3132:
x-microsoft-antispam-prvs:
 <MRZP264MB3132C024FBE9BA93C596346F93CB9@MRZP264MB3132.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ukil8YgrAu3iNtjmZ31mp8C1wCMlwug6rO7z1JNpEAalgYIFh2EYaH/B6KiB/yBXm7RCG+S+iuBaMrSfazmusBjoVC3ZQYf1feX09l+XjZWzx1gZ1rEdUgWFoAJWZ8qLBYwGTeov+1hIfPdNWndGkbp56fZ99VVr7YrL7UAOHdKSH6A9UQHWoPtkYflnQza8dHum6e3OR7Tyfkv6IKyU6D32dRayIM++8yq1hnbRlmzYnv+z+AbRowXAxn8EE7Ntlv9ywFhGOPPECG1xY55TpVKoCMRCsa85RCOLjd3fUejMte3XF88D/fmWSHHgyQl9APLKHEnSA0qiDeQyGKw6gzXGWj3r7ZW2T6lcndKjVJBPglreG7QJ3KBXQh4GIEbO4LFrpvpodLTOLIDiwiy7SzW+UO+FyKkWIUicREojPWq3isvlAUk1JJCZaH5YA8G8ZvDaQdnSPPMAwE2deMwmksfnwHcOCXXl4LdT+9mMNnuN/3bbjHxz6wxdtTwhyeH9HhqJSmjKWQhDa9rE8isGdU90pBuPwtk6P3PRcDKEoGQ4Q8Dry7l5Xw6YthS9A0rEMVOxE3coCenX09VgrUXdPJVg7ozb5l+8WMS4vY6+IVoO3Bi0i+B+sMhc+c/5e9l7N0qKLAgdRW78BQxFO3zjrV6xiA+zcUj30+kQzmspXtCcpseqiSoi5/7GM4P+t0Si4E8127k/qQdqw0/QfZv4YQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66946007)(8936002)(64756008)(66476007)(66556008)(38070700005)(6506007)(4326008)(91956017)(9686003)(2906002)(122000001)(316002)(478600001)(66446008)(52536014)(71200400001)(86362001)(38100700002)(7696005)(6916009)(5660300002)(33656002)(8676002)(55016002)(186003)(76116006)(558084003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?v9Z/cP9Uy4W1nkSR4+qq2Oi6JBtwBDdSTldy85zCDgSmnQbhOZ4AEZ3oTn?=
 =?iso-8859-1?Q?PilT99rwN3pZLfJtmquUUv3gJHY+pmkP7/Y8sOivUW85B2JOFssbnWtIgL?=
 =?iso-8859-1?Q?qm2gjpjpNZhxna+UkqEti7kR/dsHtb379Barvs9925jhaVbmWWbnBiQ0jb?=
 =?iso-8859-1?Q?NqQos2d/3cMaTAoGEaSIz++TSQ8OPmNMsfdQqj58iaF0BM5mMSvrSceZ0P?=
 =?iso-8859-1?Q?Lc3qp0pBKYBAjTaLGnIg7oNQerWVh8G/h9xX4W5rwHxoqt3sm0G4bRvgnA?=
 =?iso-8859-1?Q?zOEahAZFOZrXJQZCOxsYAz3UqxlNnZllc9HjIU9OUkyS7Ej2ZLlKiwx1i/?=
 =?iso-8859-1?Q?UMoiB/Y8qoqOnZfT13FyXVNRzEN+PccCRtT+s4QU9dtj6WjczlJYDdTihs?=
 =?iso-8859-1?Q?3uR9FHO/wBH1ExE4wpPrVgXR0P+98dhdgoicKxUsIkR9ThQ35e8YK7sQ7B?=
 =?iso-8859-1?Q?NsU5BkiST4QSWV8Gc8EykgfIPFgngBUJqA7c5LkmIoFrIHrnfoDSaXfgD1?=
 =?iso-8859-1?Q?kh4wmcTTxJg07U5C/YLdYVBvs/tJeJEzeYWCIGBHGpV1eec+BM/uvi/6B+?=
 =?iso-8859-1?Q?zivY/gOg+jIp71FlQAQHuCLR/ljyeu2w13WAvNjiI+hMOaBoT4LYfmA/d7?=
 =?iso-8859-1?Q?XSKvAYujeRSf5W3xUTRUZb7Q4BntlrXxN+YKW1/sqXuyd7xYo8fiJelh4G?=
 =?iso-8859-1?Q?0R0YBQEgg975K+jyAaiDMLuRl2D9Cle3dsX4+y45676gd+V7+IBjKpMYvo?=
 =?iso-8859-1?Q?9hZShNNJHr4ATU9TrrB+qLcJKhO8tiCzgs8pN8vGOkNq4drcCBKv9F9oXG?=
 =?iso-8859-1?Q?Ma4XFKMwRdUqMm5Pdu64xYgQy9WkCZIXSeMDKr3ROERNu3p0t0ctZIuOq0?=
 =?iso-8859-1?Q?qZLUrX+hisMz9Wu+J/WpSgk57wAfUAmw7VWVUGUu3/gCOXAKlecGIFJEki?=
 =?iso-8859-1?Q?hOaXEWgXMWQs8WixBT8i2Qs3eKmotiYApsuc1bmT4HkhBjUnE1BbCV0JIx?=
 =?iso-8859-1?Q?nLxoOmuzWqvdYdG7f6/zSPioiyDLvUqu181ok0NpkMFrgfjR8qPpjeFZDW?=
 =?iso-8859-1?Q?aT+oFU7egv8RYRYmHOjoOAtP1lxwVHhwr7P9fhiSDVB9cexhfWCqOTY5mU?=
 =?iso-8859-1?Q?MtbwG+m0zUH+I8T16UcjnjBHpVjiQ4w+MzP5UrON3VbgSQQvsl15bKNrAe?=
 =?iso-8859-1?Q?JkIgAoHthkNlITgvXEdfEAEeA3mLuYHiVO0rx8YC6USuifO4N0x7uqMGUu?=
 =?iso-8859-1?Q?Sexp/SC6DQmZRDpWRHwPzVPvvVPQYDBPzXnmjjxCH02siVTsv+CMWTOaLe?=
 =?iso-8859-1?Q?ywEC0MlCyjYoc2jcP6U34El3Udb1cK0LU7+qzwNGRugUxnFoq9NZbR2f9A?=
 =?iso-8859-1?Q?VqwtUDpq5EPl4BB6F+8/XIcKEOmSGb++4U9m8mrZNH2TprlYhHePw=3D?=
x-ms-exchange-transport-forked: True
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
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12145072-920e-420e-6f4e-08d96b8784e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 07:26:44.3616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0b+HySxIpc/qdx3r/Cp/F1M6GjiISXC9sMBHy25vhVIETKuYbT2XFwSY5xvk81zAU9xzkIO5nJa4cIzxVgZ9SFEf0QC3QWmHkcOng2ItyLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3132

Hi Daniel,=0A=
=0A=
> Terrible sorry for the long delay. Anyway, I tested this change and it=0A=
> all looks good with VPN. I've applied the patch=0A=
=0A=
Great news, thank you!=0A=
=0A=
Emmanuel=
