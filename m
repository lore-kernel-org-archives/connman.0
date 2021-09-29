Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20072.outbound.protection.outlook.com [40.107.2.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112F72
	for <connman@lists.linux.dev>; Wed, 29 Sep 2021 08:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPSwO0veq3RvAR957Mm5cJKW9ov2nuLs5INuMgGlJm7oXKojXKfsZAcW3c4xDQ1x+NdOi6mo7F8ebIT41zTCELEkGLlgagb2nSDA2FRhyGrj1vxuYqvMdLUrRfVEABsaSREEyD3evUEd+EeKzPTblTvaR8OM3b2nQfvTwJ1c9Jv3FOEu7vQh06GFt0/T8S0NwbeQB/Iucyrnw7jlmOI6Gi/CixRN0YsqvkvV+EgtpIJBafYB33JP7z8VwWGWbW/nyRBD96dgPYIrnA/IrA2nB+vafj9WKBMpKyrAO1OvaFun94RN/+xpnv1M2dpZhyMXqWKVVtPAVS6w4JxerBA0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EkQmXF0joyOhO3kuWuMnmrmEirV258WQnUpdTrWb+vE=;
 b=Rx0ZoXI8xDLbP3bmM0sAOHHd6d/+kZwVpxp4WO0Vz9zvFZq1J/SYMQwUKO0pQ5IRVegMdetHCtsH3oTQkKvQftmKpxXr7hjfkp+zFe1KegrGPnFPS1ioSSFTJmI7wmB8J4IKzqMFS0i+vDkocydGbaknACcR5x/8I59FbytnvaSForcNP83Z0IY9ZsEGMpOZsOsr1My1MVrGUCWR0djVfSQ0x+72fS2HBjToST41TFE30wgMrOg6mUCUMWbS72hjulCDl60Mew5O478q9rAtmwbzBqTkbkVjJrS/+rc59m1qDOJ3iyT4hS0YUPg7a3ui9xG4StL11YyAmtO9ziSbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=overkiz.com; dmarc=pass action=none header.from=overkiz.com;
 dkim=pass header.d=overkiz.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=somfy.onmicrosoft.com;
 s=selector1-somfy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkQmXF0joyOhO3kuWuMnmrmEirV258WQnUpdTrWb+vE=;
 b=cp9P6RAPzTJpCiLE71kdt4Xjh1fPVZ+AyDfChqzWzoUqQ9hlY/NBXW0VmQLU1fel4Pf5Ea+t8owJTOaKmbK0nP+S8YE9kSPsN4WUWfYTVwLFhtwtz5i3/DcMkJCeREjvw0bZbtlfoYPBkqux2JSee3j922jra2alw4BBq2m+iYY=
Received: from AM6PR05MB5127.eurprd05.prod.outlook.com (2603:10a6:20b:6b::25)
 by AM6PR05MB6072.eurprd05.prod.outlook.com (2603:10a6:20b:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 08:57:25 +0000
Received: from AM6PR05MB5127.eurprd05.prod.outlook.com
 ([fe80::ad04:5c7d:675a:690]) by AM6PR05MB5127.eurprd05.prod.outlook.com
 ([fe80::ad04:5c7d:675a:690%3]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 08:57:25 +0000
From: HENRIET Vivien <vivien.henriet@overkiz.com>
To: "wagi@monom.org" <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] wifi: Choose a random channel when opening an ap
Thread-Topic: [PATCH] wifi: Choose a random channel when opening an ap
Thread-Index: AQHXsHjU61Efr8gILE+IMw6eQ29pw6u6vxoA
Date: Wed, 29 Sep 2021 08:57:25 +0000
Message-ID: <bd9eda8f-02c8-7ae0-7fa7-5bf8b2127db8@overkiz.com>
References: <20210923124429.1123-1-v.henriet@overkiz.com>
In-Reply-To: <20210923124429.1123-1-v.henriet@overkiz.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=overkiz.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5a5d1c3-f3b1-420c-3892-08d983272852
x-ms-traffictypediagnostic: AM6PR05MB6072:
x-microsoft-antispam-prvs:
 <AM6PR05MB60725FA51D93112B2CD9DC0C8FA99@AM6PR05MB6072.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Bg1qA1NpeUjxQcYlO5bHVYux5czKHgbcoe4t9RXqnnYvWnabMmLzrVPytZ7HyxUY0LWH9CSTmDzQdae6K8snzK3o1Jg+0T0r1sKM3KhiHOwsj/njfoXqtabuf4Gg4RsA4TmIx+H95dqwhB/2iv805/NKIgDSrl8XvfAcgSoMkaZ0vpUPhDnQZRuZ1HH3wF18EzBprrNLxoaUip/cap8VH9BRWYyvK9eV5s/MgR3ug+noOZ5PKegm1Tw2ZpXP6AHpWYxys8YFqioIhD38RLfGzEEMYqK/3ieuCWkEoLalgNPy4hiM0q0TrTjuBVtXLlGhOD9c0OdyFRDW088MNsoXhykkRYTUma9h1cp9p+VJzQhCFedMEsp8akUVxB5TLTRBBxU/ArKqO+OWI0SQX4NveBUdkt1n1Ha9KaPWSe1A4PHLgL6UqbGhg5PQ8Q1DTiJ+Cdecju/dkZZJ9aUncr2sz34K2VLo7ocOM7I454Z92RoudKvmMgLiDRlrQxoMaXDQNaeSoOpiwrZSv725Boznd4Y5SJ4dyWuHyuWdsCqcA0AZBOGXsRXdmzPvGFWrSNTyMIg4MwRzgrlW1uAqkU9AS63Y1nZxHOXgIGJMY8dAYkgP98FGYCCrTKMRuPbjXGiZuseJNIacdJKmVCFRBWh/qi0S3Le82/U3c/DjTVZCNsMDzgYcLVcRSZLWG6qCAUhHqbAg7jrSoDpbvNFGlUW1Sj++47FamiSbgidf4rzjF6qpyjAFQNxjqUY8aN/5hG7n8uYTGBm5hdpu/zQatlH+/w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB5127.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(186003)(6512007)(66446008)(316002)(91956017)(64756008)(66556008)(38070700005)(66476007)(76116006)(8936002)(26005)(122000001)(508600001)(66946007)(31696002)(36756003)(83380400001)(8676002)(38100700002)(6506007)(6916009)(2616005)(4326008)(66574015)(2906002)(31686004)(6486002)(5660300002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1VSOHZ6NXlzaWRDazVxdk55QTdMOHJtQUVtbU0yczZRclhKbHRXSGZlREpS?=
 =?utf-8?B?NzFGSmtPTVo0UkU1aFZJbkpSZi9YWmlTdVNwTTFTZWxXZldPM2dCU1FEWEhS?=
 =?utf-8?B?YWEyRnk1K3lhWk1GTGU1U1dLM0hMMDh3S3pteHk5b2hkTWpTeVFJV205ODNG?=
 =?utf-8?B?c2ZqZUZtT01WdllIeWdLZUJocG9zZ0F0aFRuSnV6UTZpTEFkU3VVWU95RjVw?=
 =?utf-8?B?VWpPMldZL1c2bzFub0doZnZwcGNBZUJmWXk1cWVMbTU0Z2R4ODl3UFo2QmIx?=
 =?utf-8?B?SWdCMktnbmsxUklvZC95cG5raWV5T0JpK1htTEU3R3BMRDBlRExhUzMvRjRK?=
 =?utf-8?B?UUxGTVExZlhBc0MyVkJPSFZJY0xBdDNkWGhvN1o3aGxxRm9OMlJRTlhkbVBu?=
 =?utf-8?B?UVV5bUpPNlZrUzNkbUlVTXNyM0RtRjM3aTM1VGF3WklvLzRJNzJ3TFZtd0Rw?=
 =?utf-8?B?R09yVzJacFdGV3ZMOXRmRnZUdi94c0VENm1YY0RTWDYwUDlpRnBQSVBZeEl5?=
 =?utf-8?B?TytjTVV5NG9idDVCN0RQS0t4R3VWb0JvZjBaR1BzSzFEVjlFMzhjeGpaazY5?=
 =?utf-8?B?ZFZJMkFPMlpHdkRLb3RjT3NUS3VkYWlJUUN5eU1ZQzZoL0JWM2hQemJSZ09K?=
 =?utf-8?B?V3lJcmN6bGpSajBSNnFvWjZzUG1OTVlKWXNHK1V0dGhvZHpWV3luRnVJN0FB?=
 =?utf-8?B?ZW0rTHBNZTR1ZUNDaEdXd2JTNGZjWWZwbUdWbzN3VHR2RW1BVkkzQ2xpZXJE?=
 =?utf-8?B?Nm9mckJ0SGhPckw0aGZ5aVVhMm10YkpneGp2YlFteFVLVUMwZDBWaXVweUZy?=
 =?utf-8?B?aUZETXBLMFlUZlJ3REMvakRQdzJpTUdwUFBxQm9XZENMbVhMTjh4aXRhT09E?=
 =?utf-8?B?dzJSQytZKzRZcTUwK1ZCMjBFT2pSMFVKOTRFOEZMVlBNcVNuTk1GMCtBUkRJ?=
 =?utf-8?B?M3cwNTdmRlJXZm5qZW81cUhyVWZ6NzFua21jRjJ2SFFBOUpIZk1VTkwvWm1P?=
 =?utf-8?B?RHNDbFU1K0NvVElPQjhteE0rSC9sYnBoYTErNEVwRHRnSUlzRTVBVEpIblhr?=
 =?utf-8?B?UmswOUZ0bnB5MDdHZkllaUtBdGkwVk5PV2RVb3UybFFuRUl1RE0vQVczdlRR?=
 =?utf-8?B?MFpEaFlxeDJTcU8wWkcwdk90QUcyYjlRNHZ4T1J0RUU0VmkwMWM4ZnRUMGI2?=
 =?utf-8?B?TGMxSlA5dUZrNWZRRFNHU0dvVHVvR0NUY0x2clRLeWVYMVk5bHdVMERSZGp2?=
 =?utf-8?B?YkhTQnViQW1seFdCcExuQ3pOZVFuVjJDQ3dLSWlHZUk2SlM5WnJpd1h1WTNJ?=
 =?utf-8?B?TlpnY05rdTFCTGJ6WktzNjIwNVQwSFZkaXJOd2R2QzZ6OWZUWVJuSnFKZ3ds?=
 =?utf-8?B?WG96R20xUVVvZDJwM0haVnB5RFJGcWZ1UENRQXFXYUdtRzFNMk1ScUYwL0ty?=
 =?utf-8?B?Ym5iVnBuRmdhS3VFUm1EQUs2UHJzK1JiOEFVdXEyZ2YwS25lVFV1SlNXQi9N?=
 =?utf-8?B?QytDZW9kTWtOYUNNNjArY1hNRUN5SzVOWkVod3JqUjBLQ3JDQkVaTlQwbkpI?=
 =?utf-8?B?WHN2VVFRTzRiNlM1NmtKVWpCRVl5SjB2SnhHVi81R0hNQy90aFhBQmVLYWpa?=
 =?utf-8?B?WVFSY1NJV3VqTnc3ajZMVzlDN1BzaFZGZ1NMbWJCTTh0YTErWjUrL3dqcVdI?=
 =?utf-8?B?dUc3K2JuYTlaZlF4ckgzWEsvVzdPTmEyUm5McStlZFY3VENFZkpBaWJ1Z296?=
 =?utf-8?Q?n5aoWX4rdJhw6BLm2I=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <10545D454DF2BF41B1F6056A241D64C0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: overkiz.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB5127.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a5d1c3-f3b1-420c-3892-08d983272852
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 08:57:25.2396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f2633ea-c60d-4a07-be1c-b5cd19f27133
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahR1YU64bPO7k5iQzAZ8s6FK30Ijl8kaeNJGRFHsty3PLtcquz5LCGlHxlVHkZ0yfx1dxxn3mpXXK/hpvPTEfaXLy6t1i18XI0qD9Sqlr2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6072

SGkgRGFuaWVsLA0KDQpDb3VsZCB5b3UgaGF2ZSBhIGxvb2sgdG8gdGhpcyBwYXRjaD8NCg0KSSB3
b3VsZCBsaWtlIHRvIGJlIGFibGUgdG8gb3BlbiB0aGUgV2lGaSBBUCBvbiBkaWZmZXJlbnQgY2hh
bm5lbC4NClRoZSBzaW1wbGVzdCB3YXkgdG8gZG8gaXQsIGlzIHRvIHNlbGVjdCBhIHJhbmRvbSBj
aGFubmVsLCB3aGljaCBmaXQgbXkgbmVlZC4NCkRvIHlvdSB0aGluayBpdHMgYWNjZXB0YWJsZSB0
byBpbnRlZ3JhdGUgdGhpcyB3YXk/DQoNCkkndmUgZ290IGFsc28gb3RoZXIgaWRlYXMgdG8gYWNo
aWV2ZSB0aGUgc2FtZSBnb2FsOg0KLSBBZGQgYW4gb3B0aW9uYWwgY2hhbm5lbCBwYXJhbWV0ZXIg
d2hlbiBvcGVuaW5nIHRoZSBBUA0KLSBBZGQgYSBnbG9iYWwgY29uZmlnIHRvIHNldCB0aGUgY2hh
bm5lbA0KLSAuLi4NCg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNCkJlc3QgcmVnYXJkcywNClZpdmll
bg0KDQpMZSAyMy8wOS8yMDIxIMOgIDE0OjQ0LCBWaXZpZW4gSGVucmlldCBhIMOpY3JpdCA6DQo+
IFdoZW4gdGhlIHRldGhlcmluZyBtb2RlIGlzIHN0YXJ0ZWQsIGEgV2lGaSBhcCBpcyBjcmVhdGVk
IHVzaW5nIHRoZSBmaXhlZA0KPiBjaGFubmVsIDEgKDI0MTIgTUh6KS4gVGhlcmUgaXMgbm8gd2F5
IHRvIGNvbmZpZ3VyZSB0aGlzIGNoYW5uZWwuDQo+DQo+IFRoaXMgcGF0Y2ggbWFrZSBjb25ubWFu
IGNob29zZSBhIHJhbmRvbSBjaGFubmVsIGV2ZXJ5IHRpbWUgdGhlIGFwIGlzIGNyZWF0ZWQuDQo+
IC0tLQ0KPiAgIHBsdWdpbnMvd2lmaS5jIHwgMTAgKysrKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL3Bs
dWdpbnMvd2lmaS5jIGIvcGx1Z2lucy93aWZpLmMNCj4gaW5kZXggNTc4YjRiZTcuLjkzNmYxNzUw
IDEwMDY0NA0KPiAtLS0gYS9wbHVnaW5zL3dpZmkuYw0KPiArKysgYi9wbHVnaW5zL3dpZmkuYw0K
PiBAQCAtMzM0NCwxMSArMzM0NCwxOSBAQCBzdGF0aWMgR1N1cHBsaWNhbnRTU0lEICpzc2lkX2Fw
X2luaXQoY29uc3QgY2hhciAqc3NpZCwgY29uc3QgY2hhciAqcGFzc3BocmFzZSkNCj4gICAgICAg
aWYgKCFhcCkNCj4gICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4NCj4gKyAgICAgLyoqDQo+
ICsgICAgICAqIENob29zZSBhIHJhbmRvbSBjaGFubmVsIGluIHRoZSByYW5nZSAxLTExLiBDaGFu
bmVscyAxMi0xNCBhcmUgbm90DQo+ICsgICAgICAqIGF2YWlsYWJsZSB3b3Jsd2lkZS4NCj4gKyAg
ICAgICogQ2hhbm5lbHMgd2l0aGluIHRoaXMgcmFuZ2UgYXJlIHNwYWNlZCA1IE1IeiBhcGFydCBm
cm9tIGVhY2ggb3RoZXIuDQo+ICsgICAgICAqLw0KPiArICAgICBpbnQgY2hhbm5lbCA9IChyYW5k
KCkgJSAxMSkgKyAxOw0KPiArICAgICBpbnQgZnJlcSA9IDI0MDcgKyBjaGFubmVsICogNTsNCj4g
Kw0KPiAgICAgICBhcC0+bW9kZSA9IEdfU1VQUExJQ0FOVF9NT0RFX01BU1RFUjsNCj4gICAgICAg
YXAtPnNzaWQgPSBzc2lkOw0KPiAgICAgICBhcC0+c3NpZF9sZW4gPSBzdHJsZW4oc3NpZCk7DQo+
ICAgICAgIGFwLT5zY2FuX3NzaWQgPSAwOw0KPiAtICAgICBhcC0+ZnJlcSA9IDI0MTI7DQo+ICsg
ICAgIGFwLT5mcmVxID0gZnJlcTsNCj4NCj4gICAgICAgaWYgKCFwYXNzcGhyYXNlIHx8IHN0cmxl
bihwYXNzcGhyYXNlKSA9PSAwKSB7DQo+ICAgICAgICAgICAgICAgYXAtPnNlY3VyaXR5ID0gR19T
VVBQTElDQU5UX1NFQ1VSSVRZX05PTkU7DQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tIEludGVybmV0
IEVtYWlsIENvbmZpZGVudGlhbGl0eSBGb290ZXIgLS0tLS0tLS0tLS0tLS0tLS0tDQpUaGUgaW5m
b3JtYXRpb24gIHRyYW5zbWl0dGVkIGluIHRoaXMgZG9jdW1lbnQgIGlzICBpbnRlbmRlZCAgb25s
eSAgZm9yICB0aGUNCnBlcnNvbiAgb3IgIGVudGl0eSB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZCAg
YW5kICBtYXkgIGNvbnRhaW4gIGNvbmZpZGVudGlhbA0KYW5kL29yIHByaXZpbGVnZWQgbWF0ZXJp
YWwuIEFueSByZXZpZXcsICByZXRyYW5zbWlzc2lvbiwgIGRpc3NlbWluYXRpb24gIG9yDQpvdGhl
ciB1c2Ugb2YsICBvciB0YWtpbmcgb2YgYW55IGFjdGlvbiBpbiByZWxpYW5jZSB1cG9uIHRoaXMg
aW5mb3JtYXRpb24gYnkNCnBlcnNvbnMgb3IgZW50aXRpZXMgb3RoZXIgdGhhbiB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50IGlzIHByb2hpYml0ZWQuIElmIHlvdQ0KcmVjZWl2ZWQgdGhpcyBpbiBlcnJv
ciwgIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzIG9mDQp0
aGUgbWF0ZXJpYWwuDQo=
