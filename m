Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90079.outbound.protection.outlook.com [40.107.9.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1D2C82
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 13:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMbb8HgmekjFxJGpXQqEQCHo6MJekZ+TZGC0v7+gvhKdokO5m9aXMdQwn/fsEBvqrtPoI7TeIIlkezjYaDKz8nKSajyMsYB0zs/3OwooEMLd4hRSMvoxB7k42aRWSRqy4g6dJSC8Tz1MXNnzBf8Xq8lsjh40LfsBTWTRJk5RruDXuc8ksRGahO4lHTTpY1T4h9RuSq/s3Ooknc2QF3r/r6bkgW+3RZ2XOrg/I18La4yICoaEsJ0iBWxw5VY0Ep6gvY0zJCUdHEbackHGWfk4oHPBcGtCK2s40JalOyZrjoAeqhrB09In4b2rQlcUDD8xGp4HtaNbHlONOmkWomeixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KnbUs9Vt08c3Jo4d8iTHd1RWVcY8nPu3Hl5Gle1g5Q=;
 b=kXRLAtyLykgP8AQhgfLqU5yYDtmZmUp1sdsX6WEPmArSIv4DR7iFkIHXovT8xU4Pe6YGJGC2zdDn7Xey2Xhyh6xiFKceUmlY/XUdj2eAH/9wBa4LIyZU8Q8D8wWkvchvZDvOfyqmZ/KeJ5oHtbpsac3/MVRLiwFbamk2RbK9IVnG20HtXcDIswP0AiFBKkPE51emAFuw4XBN4oa1HefEvehUSf/jx+nEfB42AsTEFf+QqWd9J/I1zz0GyVAXx28wi/uf7cWy24NpLnW5P457hFgptawGiGxbNkdKCfdgHpUBkclbYpvBFi2S/+eptyJC44sdhDk0V6F5G2ZS1rC1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KnbUs9Vt08c3Jo4d8iTHd1RWVcY8nPu3Hl5Gle1g5Q=;
 b=p671cpVx7E/oGA7Q6E5CeyN4w2GvJJgVVkdKDoKq3kygkFccOYq6azsLkZRQQMghn4Zgb81IZ2xWypwiIDR2NnjRh6CKa4snVkQR7EzDESv+G3jWpuLUnAlI7ljK010ytKOR6VXPmXpbtmcTjHr/FKdKp0ImmYB9ibKjuClxSPY=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR2P264MB0654.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Tue, 18 Jan 2022 13:13:36 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 13:13:36 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH v2] service: Fix native connection with wrong passphrase
Thread-Topic: [PATCH v2] service: Fix native connection with wrong passphrase
Thread-Index: AQHYDGy5uDvG5aVpTUKHhoTSV7CCrKxowMO7
Date: Tue, 18 Jan 2022 13:13:36 +0000
Message-ID:
 <MRZP264MB1544390370DD2A30AB8F3F8993589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118130957.1205100-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220118130957.1205100-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: fff999f5-81c1-1f82-0835-7161e9307e03
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4368a0b-8f70-4646-cc38-08d9da8455fd
x-ms-traffictypediagnostic: PR2P264MB0654:EE_
x-microsoft-antispam-prvs:
 <PR2P264MB06541825FF90313E45C8684293589@PR2P264MB0654.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Dld81U2vX/ltUiADyF7BddftmQ8Rg2sBwYN2Kovwnc5PtZOh/D2sjNU/a57nM+cuRIL+/Pkeq1ePrVs8qTZYiFWr7g716e9J7iIlmcvyuYaH7OSZm2OjvzSrWckrlcmHBIDzVvOgJ5+4iWJfQT6rxWrTAmYqhgTWlgRanw3d0OKalMHI/qs0zhli6gHowz9YIQ/n/vt+GfSaAQdYFyvqeSrgIt0jKLhFtY/ibSEqp39gjOu8Z7bo5j3n3RVxGqnmkWOMn0fYtyMSU/k0HT5NcSeIeE4eWrsycIt8Hne6ZjJK1H1DRGt1VmkPKzDT5t83TNz6armgRVlTm9n5gND0oJtwM03BBYRCISvQ5hF2nysHUeYOQYS9dJ9/PGruukdtTWbECj5rVaObh9XWRd5IBgaBUkoCk8KrK7ws25C+ih7QPC7dGC6hEWLMX8Rpc8vcBJtaCDpQSatp5xR7NZBARjqlBszm+yjUzVe6ACg20rQkkX3q1+PShmHBoEbpTpXcO+ajm58yQbVFUuELdnGK2Y0SIMnX8Liyb9swfXJmfwV/9F9TD9l9uNmQexCf49DyCug4h7TpO5kWOQInAU20qQcs2bP7QK0/dZqdzutTaoxgRIhpLCTXcz++POdr7fwgjFK0BMeRIU2tLReLkTEWeilJxdPDbsx5rxa4S9aolc9Wi6A/U+8e4pBfnhuNh5Dehl/A/l792Mss3d94l70JAQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(99936003)(83380400001)(86362001)(66556008)(66476007)(55016003)(66446008)(8936002)(64756008)(7696005)(316002)(6506007)(8676002)(6916009)(508600001)(38100700002)(2906002)(91956017)(38070700005)(186003)(66946007)(52536014)(76116006)(33656002)(71200400001)(5660300002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yrBmcBgjn7yl/z9rLkZxaJ6c5ByfuCNWMSbbe8hPX98dKxUAA39V8g3YgG?=
 =?iso-8859-1?Q?BeqnwskGCAbs5BXQrfqGx4kGQ0fcrvUk2UpwtKnEp6H5hs+MghvbGJEP6z?=
 =?iso-8859-1?Q?PiBUGs8qDOL6BF8Y00XxtFLc94oAFpTZn5451I4Wj9HOILN695OQyHz0BO?=
 =?iso-8859-1?Q?2izYmokeIPenR2mMibW1obEXKOCeTfqNsHC1AoXvy7nC4t1eJb5/9WWTJH?=
 =?iso-8859-1?Q?JILeXHkK68IYxh4hgX5IK0ugp67Xzi7S2T/r2WrnK3G6543wAEImWYjbVB?=
 =?iso-8859-1?Q?1ZdPlKUJkj5BztSivTCd2dtsH3UvJx8Nxt0TNEymCu7jCDh8rMOzYaAFRs?=
 =?iso-8859-1?Q?766rmBlvXVB8yvwvF+o6dpeGjW2fPt+1Eko9nB2ZNKAwVcwLwe6SLVpLSD?=
 =?iso-8859-1?Q?Y6fuJiPeK55XcoT7bsS/Yxmwgi6YvDc9YwgEaFXyZL0vhvTlIxHkG82qaU?=
 =?iso-8859-1?Q?nODSd7oTcLUcjn2h1UqNx60lwJaPQXPxQ0rxydiiLwNZiNJ5Iy+R0mbzb3?=
 =?iso-8859-1?Q?a8zG57UbTV3ay7UWtNMOJf/Pu4q8ZW2H9bm87mz2tTRfu06n34djIsnn6j?=
 =?iso-8859-1?Q?xEfJ6r1zor0iut/PXZ6q3A6CbQDL6WW5EHjddxYZve4zydF9L6kItSaFjt?=
 =?iso-8859-1?Q?5ZKssskpNaqrml+KGrRaezG4rAVHE+Xx/v551TXiGnrsLGzyTTaTFF+Kra?=
 =?iso-8859-1?Q?u8n89fwJcmkRO4zEMoedDyVcf+AN/Hnfsine7Kqoq2T4KbKgZ0DFVY5OUz?=
 =?iso-8859-1?Q?9YWDwnJRDVEz2Kbwju89FRI7Tz3syvHjxeuY6fJgwpkDNNmFq8wS3Txg2G?=
 =?iso-8859-1?Q?ZtsuGu5U3EusP39gSB0MAycIsLaZvVItkYypN1k2mst4xt//Ab9sPUutc+?=
 =?iso-8859-1?Q?B87grDL1dXdjQlOeHsWV78NHXGlL/AnWijfNhQYM5UTDinzPhkS7uLASUa?=
 =?iso-8859-1?Q?0kBTQBD/zkx1hcwjEwMdaaLSUNMFUHGom4lbjp+v2x9G/v9l7yQ1SeH81f?=
 =?iso-8859-1?Q?GcfggyegAjQT5EqGtOMLEkpHCKKcUxqva/5lXjtnPweHIveMVVWlVqgH+8?=
 =?iso-8859-1?Q?oaUpzKifIsCEJjumLaEVC8gevOESinFuHLVb1NMi3gOY8m3IkNhGUOdfg5?=
 =?iso-8859-1?Q?322020Zyk3Ay8wr7P9kTef6SEE2BOSNyQRIE1VeSp5Vew8zohL0wi4XnzY?=
 =?iso-8859-1?Q?rWbFZ6V5rptYLVCxgugkcpVUb5Luwn0WgPK/95Lz3x0sWafPi0G1JAPu+f?=
 =?iso-8859-1?Q?pTsqQM6tPtOw7NdlSlbqATkuoJ9VONpy4WEjU9JPwmbCMydKLEOfFxpGdF?=
 =?iso-8859-1?Q?CoNG5vI7L2g/7Z5DdP/VNcHrQbBD4MIWFp9+9FQMaqDGDvL7RBLIspGiV5?=
 =?iso-8859-1?Q?jNCrms4j8N7f952Kk4HmKknLcbfuOof96/CFXmmsStOq1tlnrtuFq6Lc0f?=
 =?iso-8859-1?Q?PWoeJHSuMr1eWmZN4zGzcAo/Y5jgzBeYkrYAVTSLNcGp6itjec61z9NCSa?=
 =?iso-8859-1?Q?ffFmk5VN8rHepCYLgb9eq+oU74cGkxk4hMjDWJc4f3eZcw0DY+k+sYiD8V?=
 =?iso-8859-1?Q?NJNJyFDEGuot95noegQZtRY+ed1gX6fZSiPxkAy2+d89XQolgS74tQep+L?=
 =?iso-8859-1?Q?RhpGtJIVYEcCQiX/bptPL/iwWK/1K1Foxe8wBdusiNcgWTPwV1XaAdGHQ3?=
 =?iso-8859-1?Q?Kdc2zFRbiK9Pj5zb5zoXIf7IptTCgeva1O+YDC4i1n9uFbuPb2TiU8vVCl?=
 =?iso-8859-1?Q?+1DTdTOuHPGDODGhxSvrE/ck6FqSHNu48YU8bbAzZV0E5mqvrjudWllolB?=
 =?iso-8859-1?Q?D6Vz5NpnDQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB1544390370DD2A30AB8F3F8993589MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c4368a0b-8f70-4646-cc38-08d9da8455fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 13:13:36.2401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OI0QSpTPCIO7TNEG1Wx2yGw060R0uJaWNMU6vxtaScUhFswuFO5rWU0XruELkZ7rZ7mdN4wHhg3qBVT+yWsBlyBK2fuxlCeUU1nAblISQ4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2P264MB0654

--_002_MRZP264MB1544390370DD2A30AB8F3F8993589MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

When a native connection fails with a wrong passphrase, the user still=0A=
needs to be informed, via the agent.=0A=
However, in this case, the associated service is automatically=0A=
disconnected, canceling the pending agent requests.=0A=
The invalid key error shall be reported before this cancellation.=0A=
=0A=
Commit b9a0a039ccc5 ("service: Report errors to user in native mode")=0A=
---=0A=
=A0src/service.c | 9 +++++++++=0A=
=A01 file changed, 9 insertions(+)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 9141b85dbe9c..e6da814afe49 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -6023,6 +6023,15 @@ static int service_indicate_state(struct connman_ser=
vice *service)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case CONNMAN_SERVICE_STATE_IDLE:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((old_state =3D=3D CONNMAN_S=
ERVICE_STATE_FAILURE &&=0A=
+=A0=A0=A0=A0=A0=A0 service->connect_reason =3D=3D CONNMAN_SERVICE_CONNECT_=
REASON_NATIVE &&=0A=
+=A0=A0=A0=A0=A0=A0 service->error =3D=3D CONNMAN_SERVICE_ERROR_INVALID_KEY=
)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __connm=
an_service_clear_error(service);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 service=
_complete(service);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 service=
_list_sort();=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __connm=
an_connection_update_gateway();=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (old_state !=3D CONNMAN=
_SERVICE_STATE_DISCONNECT)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __=
connman_service_disconnect(service);=0A=
=A0=0A=
-- =0A=
2.25.1=0A=
Hi,=0A=
=0A=
Please find the right formatted patch as attached file.=0A=
=0A=
=0A=
Emmanuel=0A=

--_002_MRZP264MB1544390370DD2A30AB8F3F8993589MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="v2-0001-service-Fix-native-connection-with-wrong-passphra.patch"
Content-Description:
 v2-0001-service-Fix-native-connection-with-wrong-passphra.patch
Content-Disposition: attachment;
	filename="v2-0001-service-Fix-native-connection-with-wrong-passphra.patch";
	size=1369; creation-date="Tue, 18 Jan 2022 13:11:11 GMT";
	modification-date="Tue, 18 Jan 2022 13:11:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2YTYxNTI4MDUzNWNhZTFiNDdhN2E4OGFiODdmMmIzMGU3Mjk3NWQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFdlZCwgMTUgRGVjIDIwMjEgMTU6MDY6NTkgKzAxMDAKU3ViamVj
dDogW1BBVENIIHYyXSBzZXJ2aWNlOiBGaXggbmF0aXZlIGNvbm5lY3Rpb24gd2l0aCB3cm9uZyBw
YXNzcGhyYXNlCgpXaGVuIGEgbmF0aXZlIGNvbm5lY3Rpb24gZmFpbHMgd2l0aCBhIHdyb25nIHBh
c3NwaHJhc2UsIHRoZSB1c2VyIHN0aWxsCm5lZWRzIHRvIGJlIGluZm9ybWVkLCB2aWEgdGhlIGFn
ZW50LgpIb3dldmVyLCBpbiB0aGlzIGNhc2UsIHRoZSBhc3NvY2lhdGVkIHNlcnZpY2UgaXMgYXV0
b21hdGljYWxseQpkaXNjb25uZWN0ZWQsIGNhbmNlbGluZyB0aGUgcGVuZGluZyBhZ2VudCByZXF1
ZXN0cy4KVGhlIGludmFsaWQga2V5IGVycm9yIHNoYWxsIGJlIHJlcG9ydGVkIGJlZm9yZSB0aGlz
IGNhbmNlbGxhdGlvbi4KCkNvbW1pdCBiOWEwYTAzOWNjYzUgKCJzZXJ2aWNlOiBSZXBvcnQgZXJy
b3JzIHRvIHVzZXIgaW4gbmF0aXZlIG1vZGUiKQotLS0KIHNyYy9zZXJ2aWNlLmMgfCA5ICsrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9z
ZXJ2aWNlLmMgYi9zcmMvc2VydmljZS5jCmluZGV4IDkxNDFiODVkYmU5Yy4uZTZkYTgxNGFmZTQ5
IDEwMDY0NAotLS0gYS9zcmMvc2VydmljZS5jCisrKyBiL3NyYy9zZXJ2aWNlLmMKQEAgLTYwMjMs
NiArNjAyMywxNSBAQCBzdGF0aWMgaW50IHNlcnZpY2VfaW5kaWNhdGVfc3RhdGUoc3RydWN0IGNv
bm5tYW5fc2VydmljZSAqc2VydmljZSkKIAkJYnJlYWs7CiAKIAljYXNlIENPTk5NQU5fU0VSVklD
RV9TVEFURV9JRExFOgorCQlpZiAoKG9sZF9zdGF0ZSA9PSBDT05OTUFOX1NFUlZJQ0VfU1RBVEVf
RkFJTFVSRSAmJgorCXNlcnZpY2UtPmNvbm5lY3RfcmVhc29uID09IENPTk5NQU5fU0VSVklDRV9D
T05ORUNUX1JFQVNPTl9OQVRJVkUgJiYKKwlzZXJ2aWNlLT5lcnJvciA9PSBDT05OTUFOX1NFUlZJ
Q0VfRVJST1JfSU5WQUxJRF9LRVkpKSB7CisJCQlfX2Nvbm5tYW5fc2VydmljZV9jbGVhcl9lcnJv
cihzZXJ2aWNlKTsKKwkJCXNlcnZpY2VfY29tcGxldGUoc2VydmljZSk7CisJCQlzZXJ2aWNlX2xp
c3Rfc29ydCgpOworCQkJX19jb25ubWFuX2Nvbm5lY3Rpb25fdXBkYXRlX2dhdGV3YXkoKTsKKwkJ
fQorCiAJCWlmIChvbGRfc3RhdGUgIT0gQ09OTk1BTl9TRVJWSUNFX1NUQVRFX0RJU0NPTk5FQ1Qp
CiAJCQlfX2Nvbm5tYW5fc2VydmljZV9kaXNjb25uZWN0KHNlcnZpY2UpOwogCi0tIAoyLjI1LjEK
Cg==

--_002_MRZP264MB1544390370DD2A30AB8F3F8993589MRZP264MB1544FRAP_--
