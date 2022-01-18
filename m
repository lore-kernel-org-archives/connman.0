Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90071.outbound.protection.outlook.com [40.107.9.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC1168
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 11:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrUWK8y0fmMMPVkj5EAbiyzJ9H56OCNYFwV8FIEo28bMILwX3Tbx0FI6jYZ51TozAbQWi/l4jNUgXKdePgtM0aVi211a2K7OPIyikGqzUeJCDxKJxa55ulLcUEPbyOYqWszkv+sRUMXH0tgY7ZCI3ncKWBBwvcp3nKCPJWtTLgFEzcCyfI/adIC4xzKjttaH1j8yUvsTb1uR+gwr9IZPN35ToVIuqy1WgaUwQgIo/QcU8QoSTsugRzv7kIF82qZQCZM/cOxyjyUInLkWdilcyGYbOhkZDDbilYoQooSpEGyaeaR0woPXMSvgdzgIMkUC4W9nLpu+kK2WXUWYy/E+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUlrMD0/FORwa/FG8BWcQ9JSm3O1+H16yqODRmkIOZw=;
 b=KoxAWwg9U3oLCTuwiOciIhMQw3O3cWtGVpwE0JrdrIJ/0sMNZv61P5Dml/WIKuZNBnf4ZcBcFoJ9hdbs8lEbPZXLejeZ3EKmcRufuKtYg2zo/c8ifY+hG4mmk00QXhiH+HI8a2JSGJqE5tzMA5OHAwzv6MdQkAqRTfb/isjH6FL2OefjEn2nu/4lum2vL8HPz05KkHvFhfIUA0y0ROo2R/w58p50BHkXCbarZPPZGNpx5Uvk76TBNgKR7FaXyzIiBGNbed8lWg4CoMmPC1qES51Uk7RDX5k/GGmZS9K5UnwiCvcqJckTPI0ET1bsGfamP9inkBF3hqWch3/SAfEYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUlrMD0/FORwa/FG8BWcQ9JSm3O1+H16yqODRmkIOZw=;
 b=Q8yy/oWYZ/9QKbUO6AyUD9U0FL2gcIAJQSCAlOY5pVL1/hQ8wKfK2++EUV8pOi/6NTd0A5RMlxwbYbT4XJH7Vy3SjimcN9pOAHxAtVrlbFasntVcfCvD0Jb3daKpin318VFCjiCoTyvjBctFOMVoeJYMb7qY3cN3Q0HGY5oG0o8=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR0P264MB3128.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Tue, 18 Jan 2022 11:01:23 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 11:01:23 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Fix connection with no passphrase
Thread-Topic: [PATCH] iwd: Fix connection with no passphrase
Thread-Index: AQHYDFmAlYvDnLQE7UaxuG0/i8mtL6xomxM4
Date: Tue, 18 Jan 2022 11:01:23 +0000
Message-ID:
 <MRZP264MB154494E627C59DCFE5854FC593589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220118105214.1201110-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220118105214.1201110-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: e3c4394c-e463-0587-6c2c-726be11b98b4
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be4b6659-8d6b-4526-e603-08d9da71ddc2
x-ms-traffictypediagnostic: PR0P264MB3128:EE_
x-microsoft-antispam-prvs:
 <PR0P264MB3128FA62A6F53F8945C164FF93589@PR0P264MB3128.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rH6pk+xmFoT03KNawM789aK09NfsrKVCsozyck8SDKZdGtR+fnkspKpOGfgoL/I/ojx8uUG9sR8tprzSMRl2fSXnoKlCb5SDQw7D7zlnPgXW4bHPTwGDteCNiPQR8dcvIfpGt/bSoYQGfxqVq3/4xhpnBkIsJIdhk04cyZTuvj2dS9ET8X0bHdFGP1/Ez+NoVWn01CA3nBXWOrGv+UAfpsE5+up5tjPXZ5qPya3wYf8eHaJVckQrATvy645kRLO38XZ3w7ohYIURqKbtE+bTrkxwkUKoMv39r/Jdu+c060KQlYTmOitoUxOK26LI/RbcoHNr5Dbsa/pLnpR8SzE48FXT4VVMQWcXwF4q0NgCHgZFPajOWaMq+6j9R0U0KTPQPvboZFkl9aTlzG4Xq+OAKy984I5QCqWfEPmx8monq9HFMFyq1wls5l/krITopqIO/WDJ3o6KQ2KMWwImvTJXrNbtd0SHvG4BK9WQ33a+ZCUDGDRVfiToIKYPgKhsormq9ZXA55yWe8XHAd6IbjuOKLVFURH97kyM94BOQZfOdROKYs5XOdJ35AF1+zeDsE8ZmOcRmF/3kHBZZJ4vdDO9Gno5d41zEBUzsed2gI8/x+cWiLjgKtDODc/3K7bp8rMywd0oAL7BsiGSB2bBlloe/DUVZUzeltDBEzEr3Liial15nA7iYRNptpKtE6SXXut7UtmUyoACe5qvwQ0N/ycGOA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(83380400001)(8936002)(66446008)(186003)(64756008)(91956017)(4744005)(66556008)(76116006)(66476007)(66946007)(9686003)(52536014)(6506007)(8676002)(86362001)(5660300002)(316002)(7696005)(38100700002)(99936003)(122000001)(6916009)(508600001)(38070700005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?L9ILHdaNIwjycUA1BxiyVK9GHWyBsOXFoqQOUsRFz6Sqfqx0zdfA8nNxWH?=
 =?iso-8859-1?Q?cYaUEedUwVBYH65Qbi+XuKxCUS5JeDAbSOeykaCm4Qzs0+Hf72BVefB66j?=
 =?iso-8859-1?Q?I+ZhujI+fqi7U0ZxpqNeIRRL2QvxcPEzo5o4pk8mXutnBZG4ALbAgRA9Bz?=
 =?iso-8859-1?Q?WF8wGpUtBvzHHYGN+IvS9NSvDgfsPFr7gQUr2zgIfOfoY9jCW3T9sWWi31?=
 =?iso-8859-1?Q?gFQz+RSSevBgJCQtxMpWblhyHqrh/wsmdIvvu36yEi6+x+kmlVa4oKZZob?=
 =?iso-8859-1?Q?HsLGDyXfezcgVwaeIlt+92PH49KxHQaC3ucpfXZYspZx6/gVQQVxaku0Xz?=
 =?iso-8859-1?Q?J15ObLRJz3EleoMY5zQf/5WsI8rYBfESBLJ9OBi/0H4W/GeZ3bqfg/uvFF?=
 =?iso-8859-1?Q?I/BCogZ/8DbROjMFbCF4iRCwMCuu6BB8OMUs/jd0CDNof9mhFXXGmElPmd?=
 =?iso-8859-1?Q?zK/0qBTGhyiECVqUIIqxZ/pcPg2V8YiHzpbJF9qVnR36ipvqymxr+T7+6v?=
 =?iso-8859-1?Q?2/Ez3yZQqJ6c+DuGattAlLSKIIz9dCbf8bQDL/lOhD3XfQqavTiLJkoxh7?=
 =?iso-8859-1?Q?GcLNyp+0C+kIGbsKDc2GwKiWsBiMDv49tVh8M61DinHcTFM1dOYFZscn/L?=
 =?iso-8859-1?Q?KbN5dRb1Of9azcEdVuLjKkS3a43YAl6EUZqZBa2n9i4oqIkUrsWucUGwKc?=
 =?iso-8859-1?Q?0RLxFfqDE46RnEFxq/BULHCZHyy7wVVxvvmEsFKMoC2nEGWUeCucxPK/TA?=
 =?iso-8859-1?Q?M6ixSfCjUNETHlluKK4C+BzJJTyuKlonMk5Vwh9e5Em2rjXGGOKKtJWx1h?=
 =?iso-8859-1?Q?fZM49C/hdeMN+YYKndFfUlb6/m0CFwC14GcEKBuH7aC3qFMPfG4mHL8Goq?=
 =?iso-8859-1?Q?jLlNLvhS5RDfpBiROZIRSgokHDwQZMtYeNWqTfym1gEkafvZL3zkH68Ee2?=
 =?iso-8859-1?Q?567wtwY2Jp/kbWfb2VxhD4jeZuTTqorF+QeVwMSn6JVBsscZTB74Puy68r?=
 =?iso-8859-1?Q?oFO1su1DcDGshBfiemMr5s1UwKhYvbjTk6ZuC1AKNvtdogyPXropcX2f18?=
 =?iso-8859-1?Q?2jOeX9HiW93anMMpYzDa0YmsoGXnYIYKYzSPZzqvI7QhevCDG0vPvJ7Rfh?=
 =?iso-8859-1?Q?CCSmyqtttk1JCEr12c72WI95Mahd1mivecnFzJ0RDCvhLRxxj7hvNB0Bfc?=
 =?iso-8859-1?Q?ccHyFBZHLkuN80JZ+StZthTrrJDRASE5P/7VIkeA1DnEzu3RyRBK1rd0Zh?=
 =?iso-8859-1?Q?rU1vt0wxINrrRfthqIwKET7rriK20pFrBj70y12ceZMMLc2UF6yW51Gq+r?=
 =?iso-8859-1?Q?yG8+o0rx2hg19Vqhvg62lPJjry9UjEN9mNqYWlOBz79GoJpf3MheUXPonf?=
 =?iso-8859-1?Q?o6o3MsApOQ1JBjmqNadfIEiQ33aXUye9yvIj49nzPyX5cj52BXGGyApY1D?=
 =?iso-8859-1?Q?BaPELdHc9WE94L8GTXDkbrfhwHsSFAtZ1JBgsbXE+yMmkVbA6ss4D6MG2l?=
 =?iso-8859-1?Q?juX+z10JWhnmTH+b2B0OfglenIgoA+npIIleCCIJ8omdoodUWD5tnnlgb7?=
 =?iso-8859-1?Q?LxjAM/D9lQKPTZu34XoCo8A1HVeYFA6B0GTpKd0goLd5d3iCtlEgQ/kEJN?=
 =?iso-8859-1?Q?B9g1qXwZ4TlxwST1zNKxezTGLjP3hnfj6eA6r0tfmSBS1L7OtA5awK3MeF?=
 =?iso-8859-1?Q?wM0l1vX5lrbSj/AvJ0fKw3Trae04FLV12mIVEdmiw1xR1XBBLnjCQksGuX?=
 =?iso-8859-1?Q?LRZRLHZmb6QbieVgFkS65fYjwD3x1L65eSiecLhiPoT69aABBEahUwg0ts?=
 =?iso-8859-1?Q?0m9BWSaMfA=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB154494E627C59DCFE5854FC593589MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: be4b6659-8d6b-4526-e603-08d9da71ddc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 11:01:23.5708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kz38IaL36rCDSJtHtnczhRd05sU77x4+mzi2ZpViF0uZWmgQDBdBAP4rbRW9E9U9qVWxOFmCYr1Yog0dZbTOBUcOG0BNBgSWDmUOYHptgsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3128

--_002_MRZP264MB154494E627C59DCFE5854FC593589MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

During a failing connection on a secure network with no passphrase,=0A=
agent_request_passphrase() crashes, trying to manipulate the value=0A=
of the "WiFi.Passphrase" key, which is null.=0A=
---=0A=
=A0plugins/iwd.c | 2 ++=0A=
=A01 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index b0e17a4d6396..b524a731fb92 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -1489,6 +1489,8 @@ static DBusMessage *agent_request_passphrase(DBusConn=
ection *dbus_conn,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return get_reply_on_error(=
message, EINVAL);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 passwd =3D connman_network_get_string(iwdn->networ=
k, "WiFi.Passphrase");=0A=
+=A0=A0=A0=A0=A0=A0 if (!passwd)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return get_reply_on_error(messa=
ge, ENOKEY);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return g_dbus_create_reply(message, DBUS_TYPE_STRI=
NG, &passwd,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DBUS_TYPE_INVALID);=0A=
-- =0A=
2.25.1=0A=
Hi,=0A=
=0A=
Same problem here, I attach the patch.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=

--_002_MRZP264MB154494E627C59DCFE5854FC593589MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-iwd-Fix-connection-with-no-passphrase.patch"
Content-Description: 0001-iwd-Fix-connection-with-no-passphrase.patch
Content-Disposition: attachment;
	filename="0001-iwd-Fix-connection-with-no-passphrase.patch"; size=967;
	creation-date="Tue, 18 Jan 2022 10:57:59 GMT";
	modification-date="Tue, 18 Jan 2022 10:57:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMmE1ZTY0YTFlNzliMGMxMTJlNzY0ZTY5MTA1MGE2M2FlOWU0OWVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFRodSwgNiBKYW4gMjAyMiAxNToxMTozNCArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIGl3ZDogRml4IGNvbm5lY3Rpb24gd2l0aCBubyBwYXNzcGhyYXNlCgpEdXJpbmcg
YSBmYWlsaW5nIGNvbm5lY3Rpb24gb24gYSBzZWN1cmUgbmV0d29yayB3aXRoIG5vIHBhc3NwaHJh
c2UsCmFnZW50X3JlcXVlc3RfcGFzc3BocmFzZSgpIGNyYXNoZXMsIHRyeWluZyB0byBtYW5pcHVs
YXRlIHRoZSB2YWx1ZQpvZiB0aGUgIldpRmkuUGFzc3BocmFzZSIga2V5LCB3aGljaCBpcyBudWxs
LgotLS0KIHBsdWdpbnMvaXdkLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvcGx1Z2lucy9pd2QuYyBiL3BsdWdpbnMvaXdkLmMKaW5kZXggYjBl
MTdhNGQ2Mzk2Li5iNTI0YTczMWZiOTIgMTAwNjQ0Ci0tLSBhL3BsdWdpbnMvaXdkLmMKKysrIGIv
cGx1Z2lucy9pd2QuYwpAQCAtMTQ4OSw2ICsxNDg5LDggQEAgc3RhdGljIERCdXNNZXNzYWdlICph
Z2VudF9yZXF1ZXN0X3Bhc3NwaHJhc2UoREJ1c0Nvbm5lY3Rpb24gKmRidXNfY29ubiwKIAkJcmV0
dXJuIGdldF9yZXBseV9vbl9lcnJvcihtZXNzYWdlLCBFSU5WQUwpOwogCiAJcGFzc3dkID0gY29u
bm1hbl9uZXR3b3JrX2dldF9zdHJpbmcoaXdkbi0+bmV0d29yaywgIldpRmkuUGFzc3BocmFzZSIp
OworCWlmICghcGFzc3dkKQorCQlyZXR1cm4gZ2V0X3JlcGx5X29uX2Vycm9yKG1lc3NhZ2UsIEVO
T0tFWSk7CiAKIAlyZXR1cm4gZ19kYnVzX2NyZWF0ZV9yZXBseShtZXNzYWdlLCBEQlVTX1RZUEVf
U1RSSU5HLCAmcGFzc3dkLAogCQkJCQlEQlVTX1RZUEVfSU5WQUxJRCk7Ci0tIAoyLjI1LjEKCg==

--_002_MRZP264MB154494E627C59DCFE5854FC593589MRZP264MB1544FRAP_--
