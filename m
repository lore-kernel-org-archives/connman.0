Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70120.outbound.protection.outlook.com [40.107.7.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D5A23
	for <connman@lists.linux.dev>; Thu,  3 Nov 2022 09:04:26 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=QCvjZOUI8HO2fmUtMRRR/ObhycmT+cAGp3nKifp1gAgmCWPq9ls0TWAN1kRQhWPHYH0XqE9Q8ucjmB8ujFgrCReE2X/QWcfF5Qb1NiOkGxelue1Jnu82i9bfS/CKstvrf/vBbJ+VKRp0yWyxn3w39zgv5CZX68ErQ3pi8AeHJjvbj9B3nkglZxzT4OOgKzKgRM5dd2BvHLKxoZIxXop74jqbYm01/43NIlKoahD63OgBwnhVpTa/c5su+5nBHYbSLaEaZKHoPubLnAZJC1X3ArIAAauoThgtnVoGNO/9r/NGUj5/hMWFxp5d/GZFs8IaG3xyNo8GAXDIPwnHMJzdVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f+Jc1bJmDdh4a/c8jAFU3PgpuSvATmwq3z85Bo0qmo=;
 b=F12y6L04tC2ldlnas0ymI5h1IxKS/OYrhD4lDFAoHdalR/tuBJjKpBEpsk7ZGeZf2WHItEvfMOI6raR0RIDcjnH/Q/okSpiRSKsGiHxjiP9zhC5hAah0mibcVU7+5/XNZ+2VZKau7ndGtrRMRfy6bPQ315xex+v97TINI8baNTFpNhTCJJmLVPh+v1HJVkPOn0rt1/IMc/y6nnzTAjlGO3jnEFMO/hP4Y5kD9CgIP8sNnLYMawfeylsd8rjnZz626e5JE0iCS1pyzBNUlNpxIcb3j7nfSRI83uUU/9lgWlIC0OeCefkexJ2AsTMfY0YtgrYs8gFUdPxTTwtSNX39nw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.52.142.9) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=goeg.at;
 dmarc=bestguesspass action=none header.from=goeg.at; dkim=pass (signature was
 verified) header.d=goegat.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=goeg.at] dkim=[1,1,header.d=goeg.at]
 dmarc=[1,1,header.from=goeg.at])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f+Jc1bJmDdh4a/c8jAFU3PgpuSvATmwq3z85Bo0qmo=;
 b=lVv/toiuR+sC/lJ2S/QsLv0hq6vgem5ZlOLX2YkuIA86gbDnYfbG1jIcDnAQ6vxOUpjrejYttbNWtV7Fe2nVSSk451o+N88Uo0k58hPRcn2xP1mek5/EsC1+7uPEJuOn640SMLjhpcy9SequUtUP2bG+A7hfg9MAlP6BsMkujCQ=
Received: from AS9PR04CA0093.eurprd04.prod.outlook.com (2603:10a6:20b:50e::21)
 by DB4PR09MB5920.eurprd09.prod.outlook.com (2603:10a6:10:384::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 09:04:23 +0000
Received: from AM6EUR05FT039.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:50e:cafe::c2) by AS9PR04CA0093.outlook.office365.com
 (2603:10a6:20b:50e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Thu, 3 Nov 2022 09:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.52.142.9)
 smtp.mailfrom=goeg.at; dkim=pass (signature was verified)
 header.d=goegat.onmicrosoft.com;dmarc=bestguesspass action=none
 header.from=goeg.at;
Received-SPF: Pass (protection.outlook.com: domain of goeg.at designates
 20.52.142.9 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.52.142.9; helo=goegsIQSUITE01; pr=C
Received: from goegsIQSUITE01 (20.52.142.9) by
 AM6EUR05FT039.mail.protection.outlook.com (10.233.241.178) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 09:04:23 +0000
Received: from mail pickup service by goegsIQSUITE01 with Microsoft SMTPSVC;
	 Thu, 3 Nov 2022 10:04:23 +0100
Received: from EUR05-VI1-obe.outbound.protection.outlook.com ([104.47.17.170]) by goegsIQSUITE01 over TLS secured channel with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 3 Nov 2022 10:04:22 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTlHs4SCrRbTKaetmx6IJ+16yee07Y/JjZVKEwKBLdAXu1foafs1sW3PvreFzR4tREHS7eUZknVFdrrqym7jcw42J1VhtwFUwsBw6mbD/cs3Jidju242GFmC6gWgIwBqP1EeQ7yVtDB1eRELgquqYKZqP2X0JhM/RLIQzN3cYex55c/KRVGu0ED6CrW3Ty2Nwb7VvLw8KriDfeg1t9BFtH+GQRNz1MnsOcozyfEDY46AZ6txhPg/I1E30mQETN3hnfPvVSlgXAXMZCxYYzWRwQ9I6O2WD/tq1K4yqaK4kXOdcJ/LAEnmFAzrs6J66J4v4eJg7pCfz6MNaG+V/1FU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f+Jc1bJmDdh4a/c8jAFU3PgpuSvATmwq3z85Bo0qmo=;
 b=Axeb2S/dg359suTNtZK0NnHvH1n6O8NAGP/RZ/c+0Bd96sE+lkWqKIRteYZgoVp99NQ5LOc9CenYvyZ6QbGsOFmWaAX/nvYZEbfts32SGMDd7wy6b/JWZRI7JnQpkf+M/iTh8smLwJYD7BEAgFF1ikw5CObTiyekeuW33EnpaoAnlC4mHIrXAMhidx5RoCQaiUJ1DnY9aLn3PHGuBftqlsS+ikTAErbJDkH/+wrR5G1wi7DeVKkp7w09HEdX4cmN4IiJntkxYX2ZsI3vR9QAkhW0ESw/N/9qrylB8BJFHV2Fn3rDBOxnoBabVubebvAJD8/Oe0BgQbF7x+dFEbQpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f+Jc1bJmDdh4a/c8jAFU3PgpuSvATmwq3z85Bo0qmo=;
 b=lVv/toiuR+sC/lJ2S/QsLv0hq6vgem5ZlOLX2YkuIA86gbDnYfbG1jIcDnAQ6vxOUpjrejYttbNWtV7Fe2nVSSk451o+N88Uo0k58hPRcn2xP1mek5/EsC1+7uPEJuOn640SMLjhpcy9SequUtUP2bG+A7hfg9MAlP6BsMkujCQ=
Received: from AS8PR09MB5270.eurprd09.prod.outlook.com (2603:10a6:20b:371::8)
 by VI1PR09MB3694.eurprd09.prod.outlook.com (2603:10a6:803:13c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 09:04:20 +0000
Received: from AS8PR09MB5270.eurprd09.prod.outlook.com
 ([fe80::d827:df54:c815:2f25]) by AS8PR09MB5270.eurprd09.prod.outlook.com
 ([fe80::d827:df54:c815:2f25%6]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 09:04:20 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Getting currently configured upstream DNS server
Thread-Topic: Getting currently configured upstream DNS server
Thread-Index: AQHY71j1/PTMot/Pj0i/FoWDs3IIua4s2ogAgAANSYA=
Date: Thu, 3 Nov 2022 09:04:20 +0000
Message-ID: <d5beab00-96b0-7cf0-0060-367ad03bcd36@goeg.at>
References: <c34932cf-6f39-8391-471d-7629a1b448ed@goeg.at>
 <20221103081646.pffl5mewgoehptru@beryllium.lan>
In-Reply-To: <20221103081646.pffl5mewgoehptru@beryllium.lan>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
x-ms-traffictypediagnostic:
	AS8PR09MB5270:EE_|VI1PR09MB3694:EE_|AM6EUR05FT039:EE_|DB4PR09MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0f9772-bc73-419f-62ed-08dabd7a66c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 /2JberMQv8liqfAZjEE5bxQ7ZSbLmajUi6+sthYDOhH/MpL8yHdY4h+M9fzOMKnstQNxJXTGpnNVf0O4y1BYFS758IKaYLSfwvuOrKRd/qmJYh+uZpuG6Mr3UIDSt+gfio2AMGeoSFlkHiZBBARdaf8jEJ9CQeJ93ncGul9LCyVcwGTicLgfOScLdIjGF72rb+6fwNHNSc4KryeEsATJExK3oSsAlaahbf8O0WXRrLJkJrTplHoyfJQProwUgiPfI834HbP7cdu3vcmC1yxs2vgoV3f85lWFraIRSkERl/r+0DZ/p9EkuSRDuirg47X4xdh34ksIsPbk+S6COqoagz5AAuzUap7nYH/QJktKmuaqdEB3VgaLBM4uto/twRLdaVMU2nGIetCNjGhSESb/f+JsvzF14ukNW+vGjTiTyPrCyqknt/OodRLBO2KtitTZLQMZX6x94mmuqxG6o4kOJhiL+Q73DkdTc0wOOHTUXF6ZqjfW+M2Lcl2ZbOLZrcouPDWzwp9Eruq1f7SLJ6/W0qtZsu9of86LEB7p9tFj1njLCatcJq5Wy/c+Us3b1QMt29gTA/jhz71H1s6hR2v0piMdM2V1qXzZU7PUwGlOZqWDBRW+vPI6Z/G/KCSAK0BV2nbAI69Dhx3KeiI7CAM7AaP+iHb8c5/pzL++EtxWs7k33TA+No57V70UjyzRVCFBVOXqDfFYHQxhbSM6KZpiepCDnMzKo0L5J/uIKZ3BAJUcIWPd9kCz9IFKqfb/LOm3WXQV28tKwMvYnHbahBww2z2GrIGs06Pfw2TUGwG0xnwDrZLc1RyP4avHOK5dfGHJSeNe77ryjuHh8PzJuHvwXg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR09MB5270.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39850400004)(366004)(136003)(376002)(346002)(451199015)(36756003)(38070700005)(31696002)(86362001)(122000001)(8676002)(38100700002)(76116006)(31686004)(478600001)(91956017)(4326008)(6916009)(316002)(2616005)(66556008)(6486002)(5660300002)(186003)(83380400001)(66946007)(2906002)(66574015)(66476007)(53546011)(71200400001)(66446008)(6506007)(6512007)(41300700001)(8936002)(26005)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA8C949E55EBA9478C990B9FC9B78957@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB3694
X-OriginalArrivalTime: 03 Nov 2022 09:04:22.0174 (UTC) FILETIME=[438FFBE0:01D8EF63]
X-GBS-PROC: 8nEwQmeqoarrBYExp6GMHPlxT56+UqAQXV1z8R/xjlNGjZ0lDEw/6cLvxXGlu2tn
X-GBS-PROCJOB: 5WctKSqES9zMw0gW8I9RgOF2X6X0OBfGP7ALA0zc0JDO0THU0jWa/MRLcDKzv0C9
X-GRP-TAN: goegsIQSUITE01@B2B5016CF20240BCA2787D3AED10A459
X-iqsuite-process: e13a3393-6c38-45eb-8279-3913da145940
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM6EUR05FT039.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d94641cf-d6fc-41ef-155e-08dabd7a64fd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lqkg305Sta8/wHPUNJPxrGs/LIdCHyyjS/0HIA8soZIwxNutMJdNSEDCNq7ZAY1iUtrgkppX0wlj9K1/RcWsDRwIsLZx1sFzuTbVNufEeiBBvFnVyGW5zvCgeCHQqFU9XOlilF1bVhuiIc8M7/VsbLClusRfyFO+m6IiMA6oxzDc2EeszQbn1DPk9vC/+dmnJVoJ0/njbcDd3JbpEHfn5m5ju4uNOkKA1lelRGNhndiNv8qbpDgW7B2wqvbvvBxsLyl3oZ91agaQVagAhaJmG68Pp6F5IeTF89yFM1sKCAl0vwYC+pYqvTNbasxykSyR4PJIdSEjIWPA1MIAqN7aTyjZizNzS8p/qL59OgQOIL+JboOwK0u1EeTBC632wSEK35bvaXflKQ2gIkoVevS052C7J6UaIwUaMt25RLfFa5+GjjyQZW0b5VbYVHak+1PvjLLWsB6sbNqqMPsPclrR46PJ7JQhutWnhOSpmwb/hjcZ7HWNuXGgnhRw36Eni7JuylKQUacIGDxXLABC5orV1p6UhCSOpJCZjGXnS+EiCf/6ql1U6iyQgW3UDiDEroiTgtPYYIyOA5Oyoq8QSm0NWTsBjRa24Jmb+EG4RkZH3YbdfJY7wgiN3V6ol2C1M+2/4A/MCJ7MNMvfutdtPf1Nqys8x9NC4JlNgoWhB9GRcHU5eU1wAtoJowxNV0hiqX95TcjmSKHztWCSaVGLL6ufk55diccSEbppqVH7yHPJxKeAdO+QWZjD8F9q+0q9L3lMVsjyDgpFg6wEQcLooRn674mUgqhDfzSU6+AWng8KMyVTjxEOB/yYwIFTHe9FcK29
X-Forefront-Antispam-Report:
	CIP:20.52.142.9;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:goegsIQSUITE01;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(346002)(376002)(39850400004)(136003)(396003)(451199015)(46966006)(36840700001)(36860700001)(5660300002)(26005)(8936002)(6862004)(31696002)(47076005)(6506007)(2616005)(66574015)(36756003)(86362001)(6512007)(6486002)(53546011)(2906002)(82740400003)(83380400001)(31686004)(478600001)(40480700001)(4326008)(8676002)(186003)(336012)(70586007)(70206006)(316002)(41300700001)(82310400005)(81166007)(356005)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: goeg.at
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 09:04:23.3905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0f9772-bc73-419f-62ed-08dabd7a66c5
X-MS-Exchange-CrossTenant-Id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff;Ip=[20.52.142.9];Helo=[goegsIQSUITE01]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT039.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR09MB5920

SXQgZG9lcyB3b3JrLCB0aGF0J3Mgbm90IG15IHByb2JsZW0uDQoNCkkgbWVhbnQgaG93IHRvIGdl
dCB0aGUgYWN0dWFsIElQIG9mIHRoZSBETlMgc2VydmVyIGluIHVzZSAodGhlcmUgYXJlICpzZXQq
IGNvbW1hbmRzIGluIGNvbm5tYW5jdGwsIGxpa2UgY29uZmlnIC0tbmFtZXNlcnZlcnMsIEkgbG9v
a2VkIGZvciBhICpnZXQqIGNvbW1hbmQgZm9yIHRoZSBjdXJyZW50bHkgY29uZmlndXJlZCBpdGVt
cykuDQoNCk9yIHByb2JhYmx5IGFsc28gb3RoZXIgY29uZmlnIGl0ZW1zLCBJIGdlbmVyYWxseSBj
b3VsZCBub3QgZmluZCBrbm93IGhvdyB0byByZWFkIG91dCB0aGUgY3VycmVudGx5IHJlY2VpdmVk
IGNvbmZpZyAoYW5kIHRoZSBJbnRlcm5ldCBsZXQgbWUgZG93biBvbiB0aGlzIG9uZSBhcyB3ZWxs
KQ0KDQpEaWdnaW5nIGEgbGl0dGxlIGRlZXBlciBJIGp1c3QgZm91bmQNCg0Kc2VydmljZXMgPHNl
cnZpY2VfbmFtZT4NCg0KU29ycnkgZm9yIHRoZSBub2lzZS4gVGhhdCdzIHdoYXQgSSB3YXMgbG9v
a2luZyBmb3IuIFRoZSBhdmFpbGFiaWxpdHkgb2YgYSBzZXQgY29tbWFuZCBmb3IgbmFtZXNlcnZl
cnMgbWFkZSBtZSBzZWFyY2ggZm9yIGEgc3BlY2lmaWMgZ2V0IGZ1bmN0aW9uIGZvciBpdCBpbnN0
ZWFkIG9mIGEgc3VtbWFyeS4NCg0KVGhlIGhlbHAgbWVzc2FnZSBjb3VsZCBiZSBhIGxpdHRsZSBt
b3JlIGRldGFpbGVkLCBwcm9iYWJseQ0KDQpzZXJ2aWNlc8KgwqDCoMKgwqDCoMKgIFs8c2Vydmlj
ZT5dwqDCoMKgwqDCoMKgwqDCoMKgwqAgRGlzcGxheSBhbGwgc2VydmljZXMgb3IgZGV0YWlscyBm
b3IgWzxzZXJ2aWNlPl0NCg0KaW5zdGVhZCBvZiBqdXN0DQoNCnNlcnZpY2VzwqDCoMKgwqDCoMKg
wqAgWzxzZXJ2aWNlPl3CoMKgwqDCoMKgwqDCoMKgwqDCoCBEaXNwbGF5IHNlcnZpY2VzDQoNClRo
ZSBzYW1lIG1pZ2h0IGFsc28gaG9sZCB0cnVlIGZvciBwZWVycywgdnBuY29ubmVjdGlvbnMuIFRo
ZSBwbHVyYWwgaW4gdGhlc2UgY29tbWFuZHMgc29tZWhvdyBzdWdnZXN0cyBpdCBpcyBhbHdheXMg
b25seSBhIHN1bW1hcnkuIEkgYW0gbW9yZSB1c2VkIHRvIHNvbWV0aGluZyBhbG9uZyB0aGUgbGlu
ZXMgb2YNCg0Kc2VydmljZSBbPHNlcnZpY2U+XQ0KDQpmb3IgZGV0YWlscyBhbmQNCg0Kc2Vydmlj
ZSAtLWFsbCAob3Igc2ltaWxhciwgd2l0aCBhIGRlc2NyaXB0aW9uIGluIHRoZSBoZWxwIG1lc3Nh
Z2UpDQoNCmZvciBhbiBvdmVydmlldy4NCg0KQnV0IHRoaXMgaXMganVzdCBwZXJzb25hbCBwcmVm
ZXJlbmNlLCBJIGtub3cuIFN0aWxsLCB0aGUgaGVscCBjb3VsZCBiZSBpbXByb3ZlZCwgSSB0aGlu
ay4NCg0KVGhhbmtzIGFnYWluLA0KdGgNCg0KT24gMDMuMTEuMjIgMDk6MTYsIERhbmllbCBXYWdu
ZXIgd3JvdGU6DQo+IEhpIFRob21hcywNCj4NCj4gT24gVGh1LCBOb3YgMDMsIDIwMjIgYXQgMDc6
NTA6MzZBTSArMDAwMCwgVGhvbWFzIEJhcnRvc2lrIHdyb3RlOg0KPj4gSG93IGRvIEkgZ2V0IHRo
ZSB1cHN0cmVhbSBETlMgc2VydmVyIChpLmUuIHRoZSBvbmUgcHVzaGVkIGJ5IHRoZSBWUE4NCj4+
IHNlcnZlciBpbiBteSBjYXNlKSB0aGF0IGNvbm5tYW4gY29udGFjdHMgaXRzZWxmPw0KPiBOb3Qg
c3VyZSB3aGF0IHlvdSBtZWFuIHdpdGggJ0hvdyBkbyBJIGdldCcuIERvIHdhbnQgdG8gcmVhZCB0
aGUNCj4gY29uZmlndXJhdGlvbiBmcm9tIGFuIGFwcGxpY2F0aW9uIG9yIGRvIHlvdSBtZWFuIHRv
IHVzZSB0aGUgRE5TIHNlcnZlcj8NCj4NCj4gVGhlIGxhdGVyIHNob3VsZCB3b3JrIG91dCBvZiB0
aGUgYm94LiBXaGVuIHRoZSBETlMgY29uZmlndXJhdGlvbiBpcw0KPiBwdXNoZWQgdG8gQ29ubk1h
biBpdCB3aWxsIHVzZSBpdCBmb3IgdGhlIGxpbmsuIE5vdGUgaWYgdGhlIFZQTiB0dW5uZWwgaXMN
Cj4gbm90IHRoZSBkZWZhdWx0IHJvdXRlIENvbm5NYW4gd2lsbCBwcmVmZXIgdGhlIGRlZmF1bHQg
RE5TIHNlcnZlciB1bmxlc3MNCj4gdGhlIHNlYXJjaCBkb21haW4gbWF0Y2hlcyB3aXRoIHRoZSBW
UE4gdHVubmVsIHNldHRpbmdzDQo+DQo+IERhbmllbA0KPg0K
