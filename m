Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90073.outbound.protection.outlook.com [40.107.9.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7D173
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 12:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX1+exOt1UjHKBwdPWah1kN+8COYDrDBo38NQ/C/fBJth7ux93PD7gIQIbU0WJxuNAxnYf0ZALDT+XqLmzMHkbvMUOl3+QyIM/1N1icZesg35l1/L8z5HrzFnqLp2HiR0r4FBtejRtp84o41pAx4qnl5u1bLfYzstjRPi72NbOUI5afXYCL+4e2nr4RVON/M/BVSItZ9zJKaObK3iFN1P5Kt5JiOXy2ioU+ktvG9xacGYa3gFov8aNoRuRrfspkdrkjyvXIPXuv6LsRWLOABYwxXAZySWYwYrh5oYEGdK1EpPzRkGnptlakhUeR56ZBp/8MH+q+cTmTXxL6yp4N8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uncc+0v8htDQOtmy9bEj37nq6gdp5IUmIzGWvXtM54E=;
 b=BumkcIaTI1wekwec5PKBbS0E5OcsnxPV7XOaBacIwzsIM2kyevcvpd9e273zvBBPXTn2J94Mv3mGp9HSi3VHbedvvybSGuSlY8VU9uSkqeRJHBkdb3z86oUFROb6YhEggZJ9JJ6Ta64dGs2x9xir/OAIEAWcZcpcqvHNGRwmuqP3QYuc/MSHUhJOtLDVPDBMZNRTFdkSkuKLHVPpPBX9JtfrZtbtY3H2eyDHlotn1VZW/xDcje5CxQTs2TQvugd8VRbGheviSuh1pEiYfa18ve7Gvabv3udQDNF5W2NbPJku6Mm8TiMmsm8Dbk7bFwsYdF0ZJnGVzg/wi0LLk6oA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uncc+0v8htDQOtmy9bEj37nq6gdp5IUmIzGWvXtM54E=;
 b=dJDfTLRwRGr15HfwH5n0gmQ/DHdYO/50EbtLTuvxP1CJQro68mbfCUs+Q0GwdpD0jzmEfaOM3/Kz4iB7a7uKYNwuw8t8z18t9+cgWKa4NQA/T/Ys3REgLXdxQlsobvkfw11KNny3Tz1bIN5Svd/+4dqAOUHEHgW8/CxaF/D+22c=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2586.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Tue, 18 Jan 2022 12:56:30 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 12:56:30 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] iwd: Mark only reachable networks as available
Thread-Topic: [PATCH] iwd: Mark only reachable networks as available
Thread-Index: AQHYDGo9kiHGf5opQE+wqLtADTATcqxou7ky
Date: Tue, 18 Jan 2022 12:56:30 +0000
Message-ID:
 <MRZP264MB154437A17FE29544A015748A93589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118125207.1204244-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220118125207.1204244-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 2a77c34e-864b-aa6d-f2ce-1265ce35604e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e19ad9fd-ebba-49d6-c7a5-08d9da81f291
x-ms-traffictypediagnostic: MRZP264MB2586:EE_
x-microsoft-antispam-prvs:
 <MRZP264MB2586798E89E71F12E6EF17E893589@MRZP264MB2586.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 60bJVzCuwiH6hIJDgwUxMsDxGU4hXIkfTyozcq8l9FsW4K8NEvtsvnPN6n9/nRGVZ6m87k1SUTX1Kp9t6+k0uFMNNzN/efbM7k2zFjWqUtmPO5eOgvJQv6kwOPWxXtOwd1bIpg5BT7KG8gfzk3tMRu+azS8TG1dXRxt/vqWdrWRZ/2AkeAoTczgVISK7op8JR1BDo+uHNuiCNKf+/v6oZlyLwQhtNE6Ht+5LtjvIxYb587mHHKTgtx4KbolVw8MmEGl6Zl8rc3TxkLL2uZz0wuiPzMkHrjIgWUGKwS77DZZBkHSWXWYD8UGPIzIjtdeYy/3YCEnZ3Oek5Ol4QQbVH2mzUSHLXYktUAMBZrIwQrFLxLQ40AOlEiUj7+Sr2TkCcLXYh4ff5t2cz5g9Jp2MzmjqnX+tkIpuAS5sCo2EazsAPWMZH48qDmajBG8qp9t56OGoljPlYeo7bMIDfo0htmYDoAx7aLByPCokxnON3Ewo7+TcE/UNVTyjQPfBdwU4Y7T3YgGWrVbQkYg4aB/SzsFm6fc0uiEiVAkksn9h2GleWY5Henxy051dkSafySM1W+VWfcyTScjcS6wAmPNlCyTQfC6GxdfM4frlNHoIzuS1NLavK7j2QDhq6RSU3P3HgxzNIv3R1GSLM+6b7ir91AZyw9SaLrY9QIrERmGEbRWfaMvxztOdUN2RmliapbF2n9LtKWSnmf9Mblx2mJXirQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(4744005)(186003)(52536014)(83380400001)(33656002)(38100700002)(7696005)(2906002)(99936003)(316002)(508600001)(66476007)(5660300002)(6506007)(8676002)(71200400001)(55016003)(66946007)(6916009)(86362001)(66556008)(66446008)(76116006)(91956017)(64756008)(8936002)(9686003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4bi+AfdOwR8B+pwJN42rfW++dHrjhJlND1i3OkQBmZK2wvfG7uQqwRX6GU?=
 =?iso-8859-1?Q?bBWBSEUYOnDgsukhQ52BQF8lQmQi5ZRn+zXiZgKdU8Yf3+6RCh6kxnT7v6?=
 =?iso-8859-1?Q?UECqGMyreg9hREILY0ODVG90URQdq/CMax+VQyrJXFqljHQfOVdDCwX0j4?=
 =?iso-8859-1?Q?89shwUs4heu/3gwPlu/IXAoPpxYVSWoQP9a49C+o0gg0EtA9vavDSXZ5l1?=
 =?iso-8859-1?Q?jx5N0EI5Fqdlv2vND4wrSvkIj/Uv1y++Bsjb1H9ZXXZVIvYaaPXakraTcr?=
 =?iso-8859-1?Q?kptuIRNDGueR7dD8EIDstmdTvGXyingU0EDSzs872El0I7KbTWiykbIYPM?=
 =?iso-8859-1?Q?PfEKvHsraMREBUzROoaKsUHfv8fv2tM2Qn68msCvC866Niw4gTFg6hkOkV?=
 =?iso-8859-1?Q?rJWl8WymuPVblz8SWODIHjtv8IUshlj9H8i7bH9DTBeNFuSp/Mw7vnNiYk?=
 =?iso-8859-1?Q?M7mRuFiRcaYwnfnYuKz0n+M8ijjYCF9BUQFSJZ+FCN/seOTK60WdxaU/U1?=
 =?iso-8859-1?Q?s0tJTTXLOEGQbEcICkDhGoDUREz/K8KFYF+P38q0swb88e38fIQjyS1hjw?=
 =?iso-8859-1?Q?agzKMiO6/gvCP2grmauJPFe4rPgjQEK1vqG7WwFpsYqf7pr0nWzVvDPr5F?=
 =?iso-8859-1?Q?DNPfw4krXL27IYE77oQi9QgPpaY+jgaVXl9QOZQ3wcE8fe/xmvylXniQxC?=
 =?iso-8859-1?Q?+QxncBOILG5RfhuzHWCumvzxXmJ5lpADjGwlGT6O7bWsCp3fG1ZACY/hhK?=
 =?iso-8859-1?Q?GXC72b/vcpC8cD6emInOOF5sN72/uC1O9V2E9wAom5XnFXZw+h5XF11LqU?=
 =?iso-8859-1?Q?DYhbtQfkIZnmMD0wF/fY/GcAA8RKXwUWd++gedkOR4vICQFzqH7wF5FOA5?=
 =?iso-8859-1?Q?rdYLFlfkNQV9AagxC9ypqI7WuEexiI5B9egejbL5EtJ735ZS9nqkJGJazr?=
 =?iso-8859-1?Q?SEEsxrdeEYlF+sArw06VoV0G22oTSARlvAy5GCDBW/4fbnVO1xtG4s8BbG?=
 =?iso-8859-1?Q?mnAmPKD1cgt0aVf0PY/6zSrQTPfePH9Mfnxo/hIG6VZ3U1/Y8BbkTQ4oKr?=
 =?iso-8859-1?Q?rnlKqBhKMmB3Baml7g862rk3HCwR3CUNLGJ3MpRwZ5/8PmrauenOS0X93H?=
 =?iso-8859-1?Q?P6K0Qnos+xAryWYiKV0tKWaVYy0/ND3gIOgWWdXnonjAoT0QXJvYgIxhrZ?=
 =?iso-8859-1?Q?dxXwQQ7dzvQ2AguNQrxZZC9BmUFo1lNC86jd/1R4sxUwn6EjFd+ouj4IZ7?=
 =?iso-8859-1?Q?nuIPITBWPbbGeIZM2ecAZ+m60G2dyphrny/cGMsOyMdqWaFaAwpK3W3MiO?=
 =?iso-8859-1?Q?UfojpQvjbYiRgKkGeQ8UNb7uZ5n2UeJc7IRdItkWyHFZM3cTZeDDzb92P5?=
 =?iso-8859-1?Q?pIm5GmsJCAIHpaTAqJPbMcngmyR8vAolSGVLxb/sP1jIAv1np+kyeepOU4?=
 =?iso-8859-1?Q?D2Z1kdsuWAToHOjtADodi+AbW98bvN4o7n7Hb+OGPbEx/hlaHtq21rC/OB?=
 =?iso-8859-1?Q?1G8Nky2n4MtjmrCCgNu0RUmE++lAe4txqDf3BT75VVy11xGeTLpAhQdkCv?=
 =?iso-8859-1?Q?0k6e38RTAuifz4C5stT7HzhECyiL5QwN7GqlrEwEC9QpCSlxh9v+09+4hk?=
 =?iso-8859-1?Q?FJQnIhqxgIWf1DbwlgpPjd20owEC19wRr2rDmvkarjC/o7PRBKVm/44QIn?=
 =?iso-8859-1?Q?SUTsuUt0FYeXFVwhMGUAKUupCGa50lRR93zleIsM2WfyYsFarmqS8wWwsK?=
 =?iso-8859-1?Q?rxiqIq8z2yOHN9LsPu3UpjOZj41esl+CREux4rUBee/tAT5UeyOqFXN+QM?=
 =?iso-8859-1?Q?QHNPhRFjKQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB154437A17FE29544A015748A93589MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e19ad9fd-ebba-49d6-c7a5-08d9da81f291
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 12:56:30.3974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hj6X1wM1XrfNa/mnMeqf2Xi7jBieeCKSdA5FdSh+nuFujgWrP5gqYjvzoRXJu0sIGANDWIP97migy9EenmjJ0gmm2Z1YGRG4DbOlVbPiyTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2586

--_002_MRZP264MB154437A17FE29544A015748A93589MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Only reachable networks, with a significant signal strength, shall be=0A=
marked as available.=0A=
---=0A=
=A0plugins/iwd.c | 4 +++-=0A=
=A01 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index b0e17a4d6396..a17e9c35398b 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -943,7 +943,9 @@ static void add_network(const char *path, struct iwd_ne=
twork *iwdn)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 iwdn->iwdd =3D iwdd;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 connman_network_set_available(iwdn->network, true);=0A=
+=A0=A0=A0=A0=A0=A0 if (connman_network_get_strength(iwdn->network))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 connman_network_set_available(i=
wdn->network, true);=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 connman_network_set_group(iwdn->network, identifie=
r);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(identifier);=0A=
-- =0A=
2.25.1=0A=
Hi,=0A=
=0A=
Please find the right formatted patch as attached file.=0A=
=0A=
Emmanuel=0A=

--_002_MRZP264MB154437A17FE29544A015748A93589MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-iwd-Mark-only-reachable-networks-as-available.patch"
Content-Description: 0001-iwd-Mark-only-reachable-networks-as-available.patch
Content-Disposition: attachment;
	filename="0001-iwd-Mark-only-reachable-networks-as-available.patch";
	size=890; creation-date="Tue, 18 Jan 2022 12:53:14 GMT";
	modification-date="Tue, 18 Jan 2022 12:53:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzY2Y3YzdkMmNjMjMwYjAxM2Y5NzBjMzk4NzYzODc1NDY5NzY5NDcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFR1ZSwgMTEgSmFuIDIwMjIgMTQ6MDg6MjYgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBpd2Q6IE1hcmsgb25seSByZWFjaGFibGUgbmV0d29ya3MgYXMgYXZhaWxhYmxl
CgpPbmx5IHJlYWNoYWJsZSBuZXR3b3Jrcywgd2l0aCBhIHNpZ25pZmljYW50IHNpZ25hbCBzdHJl
bmd0aCwgc2hhbGwgYmUKbWFya2VkIGFzIGF2YWlsYWJsZS4KLS0tCiBwbHVnaW5zL2l3ZC5jIHwg
NCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvcGx1Z2lucy9pd2QuYyBiL3BsdWdpbnMvaXdkLmMKaW5kZXggYjBlMTdhNGQ2
Mzk2Li5hMTdlOWMzNTM5OGIgMTAwNjQ0Ci0tLSBhL3BsdWdpbnMvaXdkLmMKKysrIGIvcGx1Z2lu
cy9pd2QuYwpAQCAtOTQzLDcgKzk0Myw5IEBAIHN0YXRpYyB2b2lkIGFkZF9uZXR3b3JrKGNvbnN0
IGNoYXIgKnBhdGgsIHN0cnVjdCBpd2RfbmV0d29yayAqaXdkbikKIAl9CiAJaXdkbi0+aXdkZCA9
IGl3ZGQ7CiAKLQljb25ubWFuX25ldHdvcmtfc2V0X2F2YWlsYWJsZShpd2RuLT5uZXR3b3JrLCB0
cnVlKTsKKwlpZiAoY29ubm1hbl9uZXR3b3JrX2dldF9zdHJlbmd0aChpd2RuLT5uZXR3b3JrKSkK
KwkJY29ubm1hbl9uZXR3b3JrX3NldF9hdmFpbGFibGUoaXdkbi0+bmV0d29yaywgdHJ1ZSk7CisK
IAljb25ubWFuX25ldHdvcmtfc2V0X2dyb3VwKGl3ZG4tPm5ldHdvcmssIGlkZW50aWZpZXIpOwog
CiAJZ19mcmVlKGlkZW50aWZpZXIpOwotLSAKMi4yNS4xCgo=

--_002_MRZP264MB154437A17FE29544A015748A93589MRZP264MB1544FRAP_--
