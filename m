Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90072.outbound.protection.outlook.com [40.107.9.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8CA168
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 10:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9BUz/Q1sa8SJnv79E9ZKO7AVwksbA3AtqZwQFJW9/73N2egdSzvRaA9rSgq55aClMq7R8iDMTW7cok2is0Pv7BPdNycJP1IDX35/xSr0mW0DcmCEp6waE1shNwPKnZ9pYddcBhCl+DuwbgvcVPG+7OVN0HJp7ke0Q47CiNleY8bv2C3zduKyLzgTz4BcSbdIQnqgiYLpYmTishKRvU4WSc3bRpaDxN2EZVTRidwLjmGctqvWXVuV9NYmSCEBo/EKLtNbyHp7ILiPeUfZ2O6RlbeI2+Fw5yNoJDyNjDN5PCTpESXR2O49JNtLkv+LZIbOMFlobNAuvr7Dpu/glFDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmtvsI12TSMI2FNMqxvXRBEXXx2LudY0d32xW6B773M=;
 b=I8OzKgBkeh+t2p3D93+o65cFAlhHyAUmNPmc2LCEI1akXfHoKDNzoIIBmSLwjfkxcSeHOrKOW3LaAk3JfXNb9YVUjDGEjYAQQJs2LtETz/WCuMMdiFgKafjaFSIEZm8uSStbDsYavxzPVLiBVxinfkfFGsTBoOgHY9BIUSGzeQ7IjcqACxXuMZ7Ky3IC3zPrJ+WDocAuz40TcpirZWofXEkiXQxcHmLrIJB5AqYMYscAh84XzRHh4kUMaXZWC6v9Ox35qU6XLW1jV0fgG+KiG5m+VIQ8E9SObndp58hfy+ybH5PZP+jk/pjeglAVVCmTmRqpygDN1s8RUJQUXdZuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmtvsI12TSMI2FNMqxvXRBEXXx2LudY0d32xW6B773M=;
 b=tz4tHjsJsQTdtU3rTRxSidBGaa39TqcxhN5ireb5DwSSFzUnfsMrvb/NfzYCMTjiwCuEj2fAuW5f8FbDZb+PjIuCgjIf3PUDpKZOYNU21zVU/1iDcYmjR0uDC9pi4Rn/KuWCakOg8HM5s7CiUFYGDK7duixdAW0E2YEtzJcZpFA=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PAYP264MB3437.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:125::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Fri, 21 Jan 2022 10:36:52 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 10:36:52 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH v3] service: Fix native connection with wrong passphrase
Thread-Topic: [PATCH v3] service: Fix native connection with wrong passphrase
Thread-Index: AQHYDrGkr9pHFVUWJ0GnIP17jv5Qa6xtRpVs
Date: Fri, 21 Jan 2022 10:36:52 +0000
Message-ID:
 <MRZP264MB1544B85627F19D2599911150935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220121102736.3323889-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220121102736.3323889-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 7192fb4e-4102-ab6e-fc93-79f6c4689495
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22ab8ec3-8021-44fb-15d9-08d9dcc9f02b
x-ms-traffictypediagnostic: PAYP264MB3437:EE_
x-microsoft-antispam-prvs:
 <PAYP264MB3437AD0FF3A3919B43CDB731935B9@PAYP264MB3437.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jWGfuK/12A28vUPnZO2js58KAP7rWEDHhslRAPyHU91r+74HBsOM2yibNSiJtXcfgJJJCEWzBRfmPstchKfvH2xB1Pk1KPQqzxBqplBq79MxGlVyfV2K60n8UYxCPCQgt/XgyJQBF2Qg5sCC68StSNPlKxRuJu1g34IMucLfY6mSFF5CTy8bZ184K+79wTP1twRM9FguZDO1UFTtEnIxiia1LHRpvGiznUYH+m53eFXPQf2e9fTYtLPf/79kvyTLlbPvyjUgc/gv5lNkBkPVQT+IXvG+ItRNT2JZzrw17RQF/GZFCQ2rD1vg6m9Km0gL/DQH7X0U7Wzd1m10CEqsGA1B3qjwsQvPCaOrNOTzNDeFm9wuscWw0+PDckyWDESDOIUR9qkdw0Ch4DrfgxWynEvRidEEvYFF+s/SpAUhKbbFK3cMDVctJDu06yGKNXklu9Awy2i0A696WjzFjmx/5TDJI+dmTWr+AmVVFSx3JeJpP7seG5hH1q5By92BRKhdrWiQaq7eKVLO/3y3Bh8dZCG11L2bcvhLzUk0lJT1ECyPplwUFUJT1Ro10Qq+Dxer7aYa4Jscq+lus32dQ1yY6NUeFgOy6jDgRqJAaj/0sa+IpyeG3hJHs5YkPf5qifT3cLkGRDrTiEIu1Y7FCEWNlSM7TZ1itui9+jkpWPGQoHdTGQhQNM/P6wJiRiJj3JHgQ0BCeDB5JKsqSM/0Fq77/g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(186003)(508600001)(6506007)(33656002)(76116006)(91956017)(64756008)(66446008)(66946007)(66476007)(66556008)(99936003)(6916009)(8676002)(122000001)(8936002)(9686003)(38100700002)(71200400001)(52536014)(86362001)(5660300002)(83380400001)(7696005)(55016003)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/ti35bGEREoMgQ5XmWJB/TsjhJ4oXSyeafbMgZe4747vIoaqK34/65G2hm?=
 =?iso-8859-1?Q?tjl6uQ+9xZe1QAp6vAQGueH4qyy6MyCKkge0SF38QW93zwT+C4LoqpPTj0?=
 =?iso-8859-1?Q?hDoXW4ZLdQxjXpNJzwgWaijGYG+oR25kggGFqzRWEJ6MX08D4U8gtFKONR?=
 =?iso-8859-1?Q?/5eP8R6NNM8bl73mDxcSSELgl27b4GhrKEKxT3FczNVlvB/jEWoZME3iji?=
 =?iso-8859-1?Q?D9Fd+9lgrFJk8f0kzcH/lfHmgQ7g86dRDDe4GXctQnjyzAJEnRiapiBOZV?=
 =?iso-8859-1?Q?owmWmY8cE+cUpEtsYW+503dC8yirUjcwaWDxO204MX5Ml7hbLhNhT25069?=
 =?iso-8859-1?Q?hR3raOGfLs/z3qoo2pfcr9TT2azui/kK3jUTH4uEDQmzdGjehCFdgGlDtW?=
 =?iso-8859-1?Q?Rq/yOE57yq4xreN/Q8GOBc06XZuhE6wXYyfaDIayuraasetI/iSXVBsGmE?=
 =?iso-8859-1?Q?3Jz4QlsL/EKjKOfm/YOWVEWyl8THuoVY4QfhZHwIzKyUDwPCpTgPF2Cl5H?=
 =?iso-8859-1?Q?KPwsJaLgIqvuxX2Vk+FxpWaLUA4m3zF3LHVl+AO403sy90YwudnYJFCQKi?=
 =?iso-8859-1?Q?Cl/eJCUq/TOddSUvpMjCnYp3VWOEQjj1NngjzismxxHg7uTWC2S1/20EBJ?=
 =?iso-8859-1?Q?4p25Xp/Hw/zfeML9UnSlmPANbPt2v0iIb5STeb2W4XXdehpF8vJy2DWdQc?=
 =?iso-8859-1?Q?QgEUh11x8/oUoGWK15+sw1vjJvihsSsXZmZC9ZY0E5vu5Xrtb32rrDk/xs?=
 =?iso-8859-1?Q?2lsi9oCBY4gw3Z+Wik8N4+f0KQBijNP4oKsGd7kDdBhJhJSsAzLW/V9UjC?=
 =?iso-8859-1?Q?7SjQxuMClNkQpE/ComAW4rp+l7bYFZpVMGA7bseqRyuFPaY8RsK7dOCoWd?=
 =?iso-8859-1?Q?LkF4w1fo6+RG0dzFLTGJ144tu1UlhEw/Al7VKbMziA3IiDo7OVV5+vXrnV?=
 =?iso-8859-1?Q?2SGSyi5haMBvT4GzsqIO2gb3rGT9G/yeWHMIIXm03kP3iS+yq4VlcSAdF+?=
 =?iso-8859-1?Q?ORo8ep1zDhX0mizX7S2AQGYk0G8789qUk/Hbo2IjH5YmsPg/wvryrz5Gu+?=
 =?iso-8859-1?Q?o0o3l/QuHEnHgdRvtb+G77QcJ02IROdQ2NOUnYn/8EJNhmlvgs6vbJkArh?=
 =?iso-8859-1?Q?MRL+D8QknNnBj8WuRtI7F//9Fx+RbxcLpYan6vrth3DMFhZoMsYbjuAoOZ?=
 =?iso-8859-1?Q?HKaKqVQn2mc/tVZGeoPDUUMd/UylxDXOSszu7pw42GvYOfEc9BV/eLrunt?=
 =?iso-8859-1?Q?2/hhFvIZ5abvP9JGvGZ4SUf7L4dUlFq2nBEZjhS8VTxH2OXaCSeRYbF2Xr?=
 =?iso-8859-1?Q?aFYg91xxpxBMh1kaab8JglIT3W81s7+2RR+K7+pkPHjpHLB+yoIcf1bro1?=
 =?iso-8859-1?Q?p0EFAMppjRmZHrBHzcP6oAbmL48b+zJ/zrpdCx+kzjbwmERxnEk/oFS5ZD?=
 =?iso-8859-1?Q?H046Q4AErax9EvoNH0m7u1WVZTKH21UXWxWwfOA3ItWxVnureLtug5ODT2?=
 =?iso-8859-1?Q?2qcBsStol5RmG5qiHho+nNYwu2U685/r1LcduEPRPIjMHEysqrAuM3Lv3g?=
 =?iso-8859-1?Q?UPd2LURag1BwLZkEFIud2eiIsmVwEVPn22Fs+mW4QjotuDa3DoYKA/DhIX?=
 =?iso-8859-1?Q?DqsJU/NYWMVMwgF8Pje7y+u1ehwT74Mv9beqX9zjOpITiZRhpyiy6leZzz?=
 =?iso-8859-1?Q?fl9ZK6H1bpBplKxzzWeqvMho41a2xD+GRdwh7ZlICnDBXU9cw6ykeq1AOx?=
 =?iso-8859-1?Q?2qsHgWJ6iQiaUY+ZZvPTcvuObr2s7hNJrlu+bvHirY7E5xt+aT5iMKWnwd?=
 =?iso-8859-1?Q?OZ8mqv0uxg=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB1544B85627F19D2599911150935B9MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ab8ec3-8021-44fb-15d9-08d9dcc9f02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 10:36:52.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlYL9Mn2fr32/VxKhq8lPrO3Hk3kJ7dILIveznxRNa04EITiZdz6oxfd0iO3798NdPdqlOQnLDFbq4281zQu3snzYz9FeeZHeAuIEaEgPLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3437

--_002_MRZP264MB1544B85627F19D2599911150935B9MRZP264MB1544FRAP_
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
=A0src/service.c | 7 +++++++=0A=
=A01 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 9141b85dbe9c..b2c01640bd5d 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -6023,6 +6023,13 @@ static int service_indicate_state(struct connman_ser=
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
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (old_state !=3D CONNMAN=
_SERVICE_STATE_DISCONNECT)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __=
connman_service_disconnect(service);=0A=
=A0=0A=
-- =0A=
2.25.1=0A=
=0A=
> service_list_sort() and __connman_connection_update_gateway() are=0A=
> already called after the switch. This seems to be redundant.=0A=
Indeed Daniel, you are perfectly right.=0A=
=0A=
Please find the well formated patch in attachment.=0A=
=0A=
Emmanuel=0A=

--_002_MRZP264MB1544B85627F19D2599911150935B9MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="v3-0001-service-Fix-native-connection-with-wrong-passphra.patch"
Content-Description:
 v3-0001-service-Fix-native-connection-with-wrong-passphra.patch
Content-Disposition: attachment;
	filename="v3-0001-service-Fix-native-connection-with-wrong-passphra.patch";
	size=1299; creation-date="Fri, 21 Jan 2022 10:33:51 GMT";
	modification-date="Fri, 21 Jan 2022 10:33:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMjAwNDhiZmQ4ZGY4MDJkNGQ1ZTE5MWM2ZjY4NjE3MjY0NzRjNmM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFdlZCwgMTUgRGVjIDIwMjEgMTU6MDY6NTkgKzAxMDAKU3ViamVj
dDogW1BBVENIIHYzXSBzZXJ2aWNlOiBGaXggbmF0aXZlIGNvbm5lY3Rpb24gd2l0aCB3cm9uZyBw
YXNzcGhyYXNlCgpXaGVuIGEgbmF0aXZlIGNvbm5lY3Rpb24gZmFpbHMgd2l0aCBhIHdyb25nIHBh
c3NwaHJhc2UsIHRoZSB1c2VyIHN0aWxsCm5lZWRzIHRvIGJlIGluZm9ybWVkLCB2aWEgdGhlIGFn
ZW50LgpIb3dldmVyLCBpbiB0aGlzIGNhc2UsIHRoZSBhc3NvY2lhdGVkIHNlcnZpY2UgaXMgYXV0
b21hdGljYWxseQpkaXNjb25uZWN0ZWQsIGNhbmNlbGluZyB0aGUgcGVuZGluZyBhZ2VudCByZXF1
ZXN0cy4KVGhlIGludmFsaWQga2V5IGVycm9yIHNoYWxsIGJlIHJlcG9ydGVkIGJlZm9yZSB0aGlz
IGNhbmNlbGxhdGlvbi4KCkNvbW1pdCBiOWEwYTAzOWNjYzUgKCJzZXJ2aWNlOiBSZXBvcnQgZXJy
b3JzIHRvIHVzZXIgaW4gbmF0aXZlIG1vZGUiKQotLS0KIHNyYy9zZXJ2aWNlLmMgfCA3ICsrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvc2Vy
dmljZS5jIGIvc3JjL3NlcnZpY2UuYwppbmRleCA5MTQxYjg1ZGJlOWMuLmIyYzAxNjQwYmQ1ZCAx
MDA2NDQKLS0tIGEvc3JjL3NlcnZpY2UuYworKysgYi9zcmMvc2VydmljZS5jCkBAIC02MDIzLDYg
KzYwMjMsMTMgQEAgc3RhdGljIGludCBzZXJ2aWNlX2luZGljYXRlX3N0YXRlKHN0cnVjdCBjb25u
bWFuX3NlcnZpY2UgKnNlcnZpY2UpCiAJCWJyZWFrOwogCiAJY2FzZSBDT05OTUFOX1NFUlZJQ0Vf
U1RBVEVfSURMRToKKwkJaWYgKChvbGRfc3RhdGUgPT0gQ09OTk1BTl9TRVJWSUNFX1NUQVRFX0ZB
SUxVUkUgJiYKKwlzZXJ2aWNlLT5jb25uZWN0X3JlYXNvbiA9PSBDT05OTUFOX1NFUlZJQ0VfQ09O
TkVDVF9SRUFTT05fTkFUSVZFICYmCisJc2VydmljZS0+ZXJyb3IgPT0gQ09OTk1BTl9TRVJWSUNF
X0VSUk9SX0lOVkFMSURfS0VZKSkgeworCQkJX19jb25ubWFuX3NlcnZpY2VfY2xlYXJfZXJyb3Io
c2VydmljZSk7CisJCQlzZXJ2aWNlX2NvbXBsZXRlKHNlcnZpY2UpOworCQl9CisKIAkJaWYgKG9s
ZF9zdGF0ZSAhPSBDT05OTUFOX1NFUlZJQ0VfU1RBVEVfRElTQ09OTkVDVCkKIAkJCV9fY29ubm1h
bl9zZXJ2aWNlX2Rpc2Nvbm5lY3Qoc2VydmljZSk7CiAKLS0gCjIuMjUuMQoK

--_002_MRZP264MB1544B85627F19D2599911150935B9MRZP264MB1544FRAP_--
