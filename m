Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2051.outbound.protection.outlook.com [40.107.9.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FD18AF3
	for <connman@lists.linux.dev>; Mon, 12 Jun 2023 13:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzKW1sBGJhHLsRjiK2wAfCgqnNX4t9Kri8UmwrSiefq9BUx4IXG9A8Fe2xIeGgYw78gLRUAVH2vj4sHNotDlExkg7qbrn7cmB4sGPyCe/lAXEGHDzjRW2RGOExoUP76WF4BaF1hl+Tlvdfx8emj3tUo/D7JufhOjX5lxpgpA2uBywldnOPxxmdN/pVNAKYMT9ThIgwsnJLnVUJMo4G3sZFAB6ZLrCDhSN7h6pl/CSNcy1X/CebHANvfHv62YO8VYipSUes5EeV4SJbMsrR5/Y+Lz0SjS+0QWpaNRQHI+6ITSJ9bPMDIacBpjl4eWCzW8zOkAnhePU+LRshbi7f10TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9zXTWp8lZSmQa6Ft6jYUBkhXDrv1m2Z40gLSH4fxU4=;
 b=UwGLOwTGNkqw4omT4VnfPmiuv/v8HUw1K7nGz622XIgcTKiZyFBRY7WR5Zc31yQGUvESzEVywFRnPKC2PUdM4/rGEHnP5HzyoCKxCYeZCY3uXHDY3xPk9zTl96wemMeFSwCSE6VYVUg9WuKqJQjdg0+hrRXzn2IANfClCfQUhEY1FRif3euLi1mj323RMoToEdUPXcyJXbWoMS1kw7a+3u9EIjl950ibZq2fcEqYuswaMtO3w3RPPTW2VqvxCDvhhCx5B/xgrDrY/zJlrirGvsPw7RRGgi+VSr1I9lc4hz+d3xcyHzfbOPCJqiAphrlfu/bW45s3341Mdhn1wSuX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9zXTWp8lZSmQa6Ft6jYUBkhXDrv1m2Z40gLSH4fxU4=;
 b=P3wDzJmpOwzdAWLeLsXCLXfsdhNlzjrAtNyofs31X967Gj23B1bZQeW8BZAI1kl74tQZGS+HZlb8mR3SLs6p1n7+oSWIr7goQpSj+tOAqzxGwt27pvGx8+dPO+nUI7WMNGIVaLM8weJh34esEdv917HLgnXtmOVVDJ4n+gZFjv0=
Received: from MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:15::22)
 by MR1P264MB3394.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:15:14 +0000
Received: from MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6da2:b278:fe73:b46b]) by MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6da2:b278:fe73:b46b%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:15:14 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH 1/3] service: Fix hidden service on invalid key error
Thread-Topic: [PATCH 1/3] service: Fix hidden service on invalid key error
Thread-Index: AQHZnS9QlSL0qMMF1E61jz3stPXN7g==
Date: Mon, 12 Jun 2023 13:15:14 +0000
Message-ID:
 <MR1P264MB1540BFB097CE5F2EE06D63FD9354A@MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB1540:EE_|MR1P264MB3394:EE_
x-ms-office365-filtering-correlation-id: 33f7ea4e-56d1-473f-efa2-08db6b470f1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q/Xhoe5AlfQ4TaRknESDn1ZwDd91QS3aTnq68IpoG8o140JxTUlXf14fzF9zsoadqYZu0EDxc1/65ufG2T2gZNwl+ynDnHhtxpsbyEslGSPnEBawGl+x5dj5YJL2C55herrAVrPxCdXJhXDTZ8mqtbAkE2XiyeszAhbHI1FmqATTZxgI5rElVtFloL0VQ1dgfNelfQkoeY5i4nm2Sk7y3/Q1zp85d3tbhA4hvgZneI97ZAyCnxb64AwDwrR5U+eTqDSK6Bw9/iDGg6PGYSK2VNh+B/90QE/+lWkluQnf0Bgoqff6XdDyxLcXZ7sqVrJFBW5v6J26efbEOSDGWoaX5rCjtrqtpQ0fZKXWFgyX8IVDhd2ha4gSOnWtkeva+jmxUL+7ZDh1Z0s8+cCTqQmJimYhl53tkHOu2cwpGlEqk0A9Bxu0ffyr6mPBtnIiG2TxoeMzMpuug14kiqydrJUVludH0PMhXulj0gnmr57nniGvr/pK8ZL422xtCUt4nhaIF3xdv9PYK35vjsVBQdc6zniSUY5qFt83EMg5uZ7gh0O6Zei3JNaA4YBQrnBd8r0xInWYPgDXUA7SMJ14byBteZdDL9jG1YWZghBJD294Ip91tufGhzNrCVivVyQsgTTD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6916009)(91956017)(64756008)(66476007)(66556008)(316002)(66446008)(41300700001)(76116006)(186003)(2906002)(4744005)(478600001)(66946007)(8676002)(8936002)(5660300002)(52536014)(71200400001)(7696005)(6506007)(99936003)(33656002)(122000001)(55016003)(83380400001)(9686003)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9gk8vz11Qd31PnYqUiVb97kz9H2UZnBUF9xpzsyzx6eOosRrtnkwoKR1ps?=
 =?iso-8859-1?Q?214x4Wutr95zjO9AQJgOim9rRi1M9J8SKi9J2kLLYxVAZrDof/dKpf/y0W?=
 =?iso-8859-1?Q?juA2YUXXpsO4IPv0CcwmvHiVdLA894fuEDtO1MyE/5G381j1vh/sv+6HDn?=
 =?iso-8859-1?Q?DvGfT7MK9aCHq/L6WoOlxNvN2EtRfePAnDeGO/Ydo9B4QtOqcSnrn1z+nQ?=
 =?iso-8859-1?Q?lKmRPmA3qiNNEi9GlCH5bJjCd4VIOK8xgqVZKCGTckr2J8aGMQE6qRmb6z?=
 =?iso-8859-1?Q?niu6VmBjckkYUonYTdtZfMAzjRz+sYbzyDe0eh/5N/Xu5t0pFdsrIJuh3+?=
 =?iso-8859-1?Q?oKhR/AFtd5xdGY6PHhpqza8uMTSPPBKQPnmOmCuYB/AEeL9wISg+Hi0Bik?=
 =?iso-8859-1?Q?GlN7Bl4TmuCkdomvZeckQI0/r96VuqI/raaU9IYqswAuiQNb57tsEEO3gE?=
 =?iso-8859-1?Q?j7pbwFpaOlsKC5eZ5SitaAaXHCtCjzt3493jaXjSLBF+7sGkf4GW+bsSmn?=
 =?iso-8859-1?Q?viN2PbRWGVXKxl6qIkniaYo+AOBjXCnxjmN7pRvFelslLxgwd5K7yrQ4N5?=
 =?iso-8859-1?Q?IGnR1A4X2OHu62wOEVrCCwVSvQMgD9U27UwMVJYlZ2rg02Z4prY4rrm2yb?=
 =?iso-8859-1?Q?+9jNScwL2bpmUI1oScVNczvdv15/rfknzRjiagFhyycl3UOD/IIGdsLDCB?=
 =?iso-8859-1?Q?GS8bqw/0nn98nUw9iBwiIPWBhMPWv3qPiyVg9g3w2+8xmmQQAKAEfNCJfO?=
 =?iso-8859-1?Q?Wjme/cfQvzZi9Yl4QMMEZxXWK4Acc4xFe07+PejTZm/wD0cMRWcIkwkjHa?=
 =?iso-8859-1?Q?Oj5a0fUha/mZ9MFGY7wkkJNCPb/JNV1NvsF8rkTmulUGIKQBa2Key0Vori?=
 =?iso-8859-1?Q?PRKChXahKx7sQ4Zkk6lZyILHZXfUoO/DdOCHFOXySD/wQ7fia37tV1woe6?=
 =?iso-8859-1?Q?M/GgxW0ef8biVnQB9xTE/fJfMr0BtTWDHWoFvRgfu2LksduoT0YH6QiW8I?=
 =?iso-8859-1?Q?vxe8WqWpGZ8M6agq3yg1+qYhzttbSukSCi32/Lc1Tz7FxubTv14RQGRO2/?=
 =?iso-8859-1?Q?KdgaN5Hn8+W6AhNabj1NPFTxXddO652dzCL3CYOf8zQgb7xRUUDqL/kpxT?=
 =?iso-8859-1?Q?GOCeoHU5UjxVfFdioQOaCOVKo5Z3++qqZNFkcWsQvjCDqUfgO+kMR1ftxj?=
 =?iso-8859-1?Q?+w0rnAZRB9fhuKep4x6dlYTPQMlzP9+YRJ5LTBFSj6SHJFzFGSCUCaFNzE?=
 =?iso-8859-1?Q?gpDjPD82OduMei8lxb7FbamzFwskO+IqxRo7ZLV3+mnGZalSWZDF5vSsbu?=
 =?iso-8859-1?Q?kzh4CLhMkoUxLFeJiSYhKCokvLm7cXLmvJWEp827iIA6NOB/fyZxAJrX9r?=
 =?iso-8859-1?Q?vi+aatWflBWQXB4iuGfirn1ibOfRQXEIrsu2veJVLswOeTUArYTugjp4Ra?=
 =?iso-8859-1?Q?CLk7HxZwxocqonEyH4tugbhR5yX0gV5OpFAQy4lbUZ6qJ9CTmhx1rVaOfJ?=
 =?iso-8859-1?Q?3PfoMZ+SYeTxszvgDo07VpXfAIEkgZHTNnqmIn56a9/CYsEB51WS8U1W3M?=
 =?iso-8859-1?Q?ryCub2bP3Co1YeVTETQGWIT1RjiWeYk3w5fS/rHHmpDwbTAji3iYEhMOxP?=
 =?iso-8859-1?Q?ItYAU2BwzDIuLZzcEMWFkbDkaccBoWXB9Z44wdpiMQqagtp8n0RN3VF/kz?=
 =?iso-8859-1?Q?Uotxdw5HNI2H+esXUxPyBXapQEpkFkPbuUDBAlM3gwT0FBNjE3nwN/A/8r?=
 =?iso-8859-1?Q?226A=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MR1P264MB1540BFB097CE5F2EE06D63FD9354AMR1P264MB1540FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1540.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f7ea4e-56d1-473f-efa2-08db6b470f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 13:15:14.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gScgK9IW29zBuNrge1WEWe1EQoAiFP+HEr0GiimpF0Qv/W/ra+XxzsxrB1P4Sr49t5UlsfpOwax7WsvQnLmF2f4QRVwBhndg/gZHMiW+Vp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3394

--_002_MR1P264MB1540BFB097CE5F2EE06D63FD9354AMR1P264MB1540FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The connection to a hidden service with a wrong passphrase=0A=
produces a known service with an invalid key error.=0A=
An attempt to connect to this service shall be possible,=0A=
and succeed with the right passphrase.=0A=
=0A=
Commit ab9256f92356 ("service: Fix hidden service with wrong passphrase")=
=0A=
---=0A=
 src/service.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 06d02322f437..284e024c4e59 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -4605,6 +4605,10 @@ static DBusMessage *connect_service(DBusConnection *=
conn,=0A=
 =0A=
 	service->pending =3D dbus_message_ref(msg);=0A=
 =0A=
+	if (service->hidden_service &&=0A=
+			service->error =3D=3D CONNMAN_SERVICE_ERROR_INVALID_KEY)=0A=
+		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);=0A=
+=0A=
 	err =3D __connman_service_connect(service,=0A=
 			CONNMAN_SERVICE_CONNECT_REASON_USER);=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=0A=
=0A=

--_002_MR1P264MB1540BFB097CE5F2EE06D63FD9354AMR1P264MB1540FRAP_
Content-Type: text/x-patch;
	name="0001-service-Fix-hidden-service-on-invalid-key-error.patch"
Content-Description:
 0001-service-Fix-hidden-service-on-invalid-key-error.patch
Content-Disposition: attachment;
	filename="0001-service-Fix-hidden-service-on-invalid-key-error.patch";
	size=1076; creation-date="Mon, 12 Jun 2023 13:12:33 GMT";
	modification-date="Mon, 12 Jun 2023 13:12:33 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkYzQ3ZWFhNzlmNDUyMjAzYmU1NzlkZWZiZjQ4N2MwY2JlYzNkMzE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IEZyaSwgMiBKdW4gMjAyMyAwOTo1Mjo1MSArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggMS8zXSBzZXJ2aWNlOiBGaXggaGlkZGVuIHNlcnZpY2Ugb24gaW52YWxpZCBrZXkg
ZXJyb3IKClRoZSBjb25uZWN0aW9uIHRvIGEgaGlkZGVuIHNlcnZpY2Ugd2l0aCBhIHdyb25nIHBh
c3NwaHJhc2UKcHJvZHVjZXMgYSBrbm93biBzZXJ2aWNlIHdpdGggYW4gaW52YWxpZCBrZXkgZXJy
b3IuCkFuIGF0dGVtcHQgdG8gY29ubmVjdCB0byB0aGlzIHNlcnZpY2Ugc2hhbGwgYmUgcG9zc2li
bGUsCmFuZCBzdWNjZWVkIHdpdGggdGhlIHJpZ2h0IHBhc3NwaHJhc2UuCgpDb21taXQgYWI5MjU2
ZjkyMzU2ICgic2VydmljZTogRml4IGhpZGRlbiBzZXJ2aWNlIHdpdGggd3JvbmcgcGFzc3BocmFz
ZSIpCi0tLQogc3JjL3NlcnZpY2UuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9zZXJ2aWNlLmMgYi9zcmMvc2VydmljZS5jCmluZGV4
IDA2ZDAyMzIyZjQzNy4uMjg0ZTAyNGM0ZTU5IDEwMDY0NAotLS0gYS9zcmMvc2VydmljZS5jCisr
KyBiL3NyYy9zZXJ2aWNlLmMKQEAgLTQ2MDUsNiArNDYwNSwxMCBAQCBzdGF0aWMgREJ1c01lc3Nh
Z2UgKmNvbm5lY3Rfc2VydmljZShEQnVzQ29ubmVjdGlvbiAqY29ubiwKIAogCXNlcnZpY2UtPnBl
bmRpbmcgPSBkYnVzX21lc3NhZ2VfcmVmKG1zZyk7CiAKKwlpZiAoc2VydmljZS0+aGlkZGVuX3Nl
cnZpY2UgJiYKKwkJCXNlcnZpY2UtPmVycm9yID09IENPTk5NQU5fU0VSVklDRV9FUlJPUl9JTlZB
TElEX0tFWSkKKwkJc2V0X2Vycm9yKHNlcnZpY2UsIENPTk5NQU5fU0VSVklDRV9FUlJPUl9VTktO
T1dOKTsKKwogCWVyciA9IF9fY29ubm1hbl9zZXJ2aWNlX2Nvbm5lY3Qoc2VydmljZSwKIAkJCUNP
Tk5NQU5fU0VSVklDRV9DT05ORUNUX1JFQVNPTl9VU0VSKTsKIAotLSAKMi4zNC4xCgo=

--_002_MR1P264MB1540BFB097CE5F2EE06D63FD9354AMR1P264MB1540FRAP_--
