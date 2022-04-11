Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120053.outbound.protection.outlook.com [40.107.12.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66410EC
	for <connman@lists.linux.dev>; Mon, 11 Apr 2022 08:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvIgjffnao1oAatx9XXcSuN1yQIrlV4etDXvyGbUC/bouibZAj4b5FO4aud7fU21LoajBDBtybyY+ba2rUo5w2EkzEomaMZ2muLNhnLgMkuEDkFFvAhAL2Mnw4UW/peenMkcP8XoOTfwQNxDc/RGux+8bZAOKaaIZzSPozlgVUmAigpm3LN05Wb1RDXwuomA7a79EEogivJl7fCv0uy9gNzz70w0jpYnch9cvVFN1OCdX0tFZ60CSk1C/godp3w0oHiHDMqD4eXab+C0CrzFuiYre4QZBF6POhdu+jxw1wTTNXGPYSOjJNJZZ6Ek8qKmfP+zkpZr0tf+9pbnnHWGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR5rESWtb0tLWGTHoGMrRYR4SSupsAVHND/PSoyRzNs=;
 b=mwjNG65bqjqem6IWumpPX1efMOkn7IFJQP7bshOmj//QcpRGEWI7DkHyvWJgZJiXkZvgKQxRvPJlmmBDwvI3dhRLx/ruzoUpTvdWYp2JEVUyxGkbp8luQW9xV4qF74RPWT27ahoKrgmbSvLlOgX513fTtHF4/mTp0NWQ3mhT+bUk2xBhIwDhUoOj01yb7SNOXnlmRGTyx/6/QWFGPrQMZTmcsTIS4qAM3TsRb3Xx4+SGOrtEubzjhac8l2iC9ZEz4WUI8bFwD0vlXhOcAxK0aCykeUUE/ynWAzKPiiUkKUAk3Z+72JUwoS+Hh8NSJuXGaaJFa2yQrab3oeaBpB9UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR5rESWtb0tLWGTHoGMrRYR4SSupsAVHND/PSoyRzNs=;
 b=vxYFf23D2bsul9sMbJRQ8V+CURDYGVuMRupsvG7sYQeVpGyN0IYnuOXwLNroNb9e2sgHtHvKw3tsogA5FGn/1c/y5HEASf8FsKqeAP6Y6ZSwCfJm2Dcr4PxT0gTFvX9UB9i9NtBLwMU8H09FTlbG71yGLKK+2y23iNdHgsc6n/w=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB4215.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:256::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 08:03:38 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8bb:351a:92ef:2b6]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8bb:351a:92ef:2b6%9]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:03:38 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Fix connection with invalid passphrase format
Thread-Topic: [PATCH] iwd: Fix connection with invalid passphrase format
Thread-Index: AQHYTXmJ+kVvqQMP3kWZjDoSdYhqwazqWP2o
Date: Mon, 11 Apr 2022 08:03:38 +0000
Message-ID:
 <MRZP264MB15441C29DB3B9AE00192133193EA9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220411075458.78136-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220411075458.78136-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d3a8b93-7e39-4960-5122-08da1b91c94d
x-ms-traffictypediagnostic: PR1P264MB4215:EE_
x-microsoft-antispam-prvs:
 <PR1P264MB421536E2065EE61883247F0793EA9@PR1P264MB4215.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ecp4vUewb/E20X6GlddncaXGGqcEg5StsG1zUEqkQH+o6FJuRgxIib9RR+xu/9D2zj3wvp1k4NFFlZrgyvZDfduZRnVOhrhBuadixzGM4RIcfMSGCxWQnWapq7VARXExq/pPmhcGN7i7joeFByBgrMMxbnuWnrDcJJXjlbkA9ufxlfSrOdoeFPXm/+TZwmkoY91k1k+MMeWzRGg83rJOgx8nkuS/uU33DTN6lJorlkmNXUuFg/uisvnuod7uOXl1v3+jmgan21j440mxgB+zLd3tmlf0tCryI7cncPl4joqxZF3FcHV6qd9F05Z0H+7jNRCjBPQGOL4eUO7IhFCyl6AIYrIT/jsg2apBJ/eFmqyge2zCp4rqFM4RvUPOJ9fFM099Y+nUKG0uzBYH73qpDVSVaZBXKxhZm+FvmcQWEEkmUGcP/zxXZmPH6su8zosxJXJ4tS93gLz36FJIC2ay4pOJUne6Ou8y3Eaz1cTvj5/b7nQr+EMV5QydSBIZ3VqGKyvzpV1ueC661pjQUj8RHnQHuUWd4MyfjxsuSg9nWy+SUz1aGCbZE7WEfrll1R8f6gwJW1RKa2weoBsOhbbCBVujFSrtaRc5/i6djX1llfwNsGCsFRmWCiE33+xPs6jXMRc2N9eAYskPKNWS4QBIYlr2/25hFrmrHEUip0vcPq6GV9ouFxtppS0gGesdfUY7uKimSmLAd8cM89ivDVv2RQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(508600001)(33656002)(55016003)(6916009)(71200400001)(186003)(76116006)(86362001)(66446008)(8936002)(64756008)(66556008)(4744005)(38100700002)(91956017)(66476007)(99936003)(66946007)(8676002)(83380400001)(6506007)(9686003)(7696005)(38070700005)(5660300002)(122000001)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?25J5Ha9mKPlz+zlgik94z0Y7qBzDJrIS07yqmsxSm+im+f+/VllPjvbu8D?=
 =?iso-8859-1?Q?ucKt30vlPNuVPZdux3dgori8nxfcsrR9RtNsmSJAIjDfVJaeQk6N31LNWB?=
 =?iso-8859-1?Q?MUKxMaBkcQljDWp96q9osYDyhJfGB7fQcy9ojkH+4eVmaxvlVaeA5Hb5FQ?=
 =?iso-8859-1?Q?Z3Lry/nuaHDWYdx5q8l9EmDlz9u0VNd4cdmuKppd8G2fv+r82S86A+bxQG?=
 =?iso-8859-1?Q?5KRonb23LAEEKabcL30xs2Rcw6sP+UmTcS8XBz6kpTRLoJ3sGIWV5fA3Rn?=
 =?iso-8859-1?Q?BzRVI5Ia4yvLHOWH4FCb2UosoDo2wujlVz8XUgoMvGC+wCQ5uvYG2vixLq?=
 =?iso-8859-1?Q?3Bw/nNw4ROHoNkt0wVRnTjyJNL6TPYb+AFLwWZswffotbKbQqBbmUYWk/C?=
 =?iso-8859-1?Q?XRRIZpaQkTY57hbERNF47++rD9vyWNlWJ4dplTYESpdGyxm9GHpjvfS2ou?=
 =?iso-8859-1?Q?nZQ8NP/G6CQQdsPpbAOBwCMdf2Madt2nOL/aJrIz0f5QPwhzztJACmaZYr?=
 =?iso-8859-1?Q?949WDf+JTyvsY4Uy0xi40aPMZWw1PLu1VSQa4O0hCDH1kJ/uCSArxotQRg?=
 =?iso-8859-1?Q?3FqfChBfm7BA2He+YW+Cc27Rw08QIY1vMC474jdj0czOMTWL4HEerhI9xj?=
 =?iso-8859-1?Q?EnwumYXnuwnW6wyCVWHtD/htUd4ru8sRLr1Xqz4FQJWP38XvMZoSjwrGu+?=
 =?iso-8859-1?Q?Ney8nccYaxXNVUyIncumoPOb6JMSMSGHeLmFX/68V3w7m53KCnsAHfQzv5?=
 =?iso-8859-1?Q?lW2gMv5lXRAsFIL0m4fzN7OmGlVdDmV53VQeeMxI03X/YsQ9a7UfnplgLo?=
 =?iso-8859-1?Q?uWNDQLsEf2iTx8Aw+TXX6kh1Vk/picG06bUrRjT9MJlw2JA8y4+RTfQVJy?=
 =?iso-8859-1?Q?lUXaO4OrKhkgvWuuaARH2FZIvm2nWgq90VQsDt8SmpGRyTXxXIKbCbQq2i?=
 =?iso-8859-1?Q?lrMovF/C399L84l5R275scmZHTGg1Ew8wK7bnbe0WS2LrugIzJMhn0kZ5A?=
 =?iso-8859-1?Q?7rTM/BdHorwuqgYZWTfNQH6JgS1PhDVAs2g9Erw4lwREq/kn8iin08BgYG?=
 =?iso-8859-1?Q?UrTbil9FAZZ7Xr6SAg86xv6oiSfWAoczVmwuidrAwo6MU9tExgmWqzmA9r?=
 =?iso-8859-1?Q?G2wpnMN/muD7PVyyrpfv5sY16W3UGOtNrRbdFPNugpUp3ZIuApMI/4e7q1?=
 =?iso-8859-1?Q?AS8BoeBZnaKkojSYXMIjydx4jIIS97dIt42d1KFbm56FSKxOEEDHDXwS+Q?=
 =?iso-8859-1?Q?6T9BRbh42ZdWhNjGj3KCazKdLQc8tddCFeMGR6SXD7ugqi5Xpf48zBIg1b?=
 =?iso-8859-1?Q?zMUOYnbGzeytCviu4/5Q5/0Cg747mQtbPF6f28MOoJubtf0z31RgE/xija?=
 =?iso-8859-1?Q?yZ91BlrtRa5mI5Vt1nk/g4wwhhJMA/W6bXlsvubCkEojgjTuWtybgk/uXE?=
 =?iso-8859-1?Q?+kjK/gNzMTkjSb6CNY51gAD0Stydxsnh49Kg5Zmcp/T4X4tDxejzv2NYIj?=
 =?iso-8859-1?Q?GutgoVIrXysFhwECZv2PkfA2qgq3S4bicIWCS0l4v741W2cXXjp8+Z1tZv?=
 =?iso-8859-1?Q?9w3AgjnA9C4bC1amW2JLqZkRKBjqIVKHWNXB/ZY+4pSTqrlYFwK04Jq/Vm?=
 =?iso-8859-1?Q?L0r1fVWGiSquoefcgma5uDOAnUh5incSUYwOVRpj7Ar4iaDjBzqJkM8Ewi?=
 =?iso-8859-1?Q?tPFFqM9XkE5dVdlUD61Na+AKcaAmO2axOxydrfDbecywzoXyxvuH5gjsPE?=
 =?iso-8859-1?Q?6fPsK0mXJSa1oNqr6rwfGBYypW0rnbXEoqViIDXkQzLqBdOS6gVaAzHE7q?=
 =?iso-8859-1?Q?WoVCujIqBZSVws+1xvgXmCWMQs2q5Iw23lnuw+RcSylv9P+XiMIS1qY/AE?=
 =?iso-8859-1?Q?q1?=
x-ms-exchange-antispam-messagedata-1: dwMwVktutt7e334v8+j7EpogQP4HR2UTE0A=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB15441C29DB3B9AE00192133193EA9MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3a8b93-7e39-4960-5122-08da1b91c94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:03:38.7216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSs11OyRl2KolIBkY9B36sAGA4/FuefXKWH5XFli3+3KRAH12P2zYYFs1fVdOtIC9D9h+VBmGBIwgfz+SSqoT73k7BVSYFqmRHCCsSILOt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB4215

--_002_MRZP264MB15441C29DB3B9AE00192133193EA9MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It is no more possible to connect to a secure network, after entering=0A=
an invalid passphrase format, for example 64 characters.=0A=
In this case, the user agent still needs to be called, to request a new=0A=
passphrase.=0A=
---=0A=
 plugins/iwd.c | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index ee3ed83e5957..f2d368336d1a 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -241,7 +241,9 @@ static void cm_network_connect_cb(DBusMessage *message,=
 void *user_data)=0A=
                        return;=0A=
=0A=
                DBG("%s connect failed: %s", path, dbus_error);=0A=
-               if (!strcmp(dbus_error, "net.connman.iwd.Failed"))=0A=
+               if (!strcmp(dbus_error, "net.connman.iwd.Failed") ||=0A=
+                                       !strcmp(dbus_error,=0A=
+                                       "net.connman.iwd.InvalidFormat"))=
=0A=
                        connman_network_set_error(iwdn->network,=0A=
                                        CONNMAN_NETWORK_ERROR_INVALID_KEY);=
=0A=
                else if (!iwdn->autoconnect)=0A=
--=0A=
2.25.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the well formatted patch in attachment.=0A=
=0A=
Emmanuel=0A=
=0A=

--_002_MRZP264MB15441C29DB3B9AE00192133193EA9MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-iwd-Fix-connection-with-invalid-passphrase-format.patch"
Content-Description:
 0001-iwd-Fix-connection-with-invalid-passphrase-format.patch
Content-Disposition: attachment;
	filename="0001-iwd-Fix-connection-with-invalid-passphrase-format.patch";
	size=1109; creation-date="Mon, 11 Apr 2022 08:02:52 GMT";
	modification-date="Mon, 11 Apr 2022 08:02:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4Y2JkMzRhYTUzNjI4NGE1MzQ5ZWU2MWEwYmRiYTEyNmI4YjQyZmJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IEZyaSwgOCBBcHIgMjAyMiAxNzoyNDoxOSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIGl3ZDogRml4IGNvbm5lY3Rpb24gd2l0aCBpbnZhbGlkIHBhc3NwaHJhc2UgZm9y
bWF0CgpJdCBpcyBubyBtb3JlIHBvc3NpYmxlIHRvIGNvbm5lY3QgdG8gYSBzZWN1cmUgbmV0d29y
aywgYWZ0ZXIgZW50ZXJpbmcKYW4gaW52YWxpZCBwYXNzcGhyYXNlIGZvcm1hdCwgZm9yIGV4YW1w
bGUgNjQgY2hhcmFjdGVycy4KSW4gdGhpcyBjYXNlLCB0aGUgdXNlciBhZ2VudCBzdGlsbCBuZWVk
cyB0byBiZSBjYWxsZWQsIHRvIHJlcXVlc3QgYSBuZXcKcGFzc3BocmFzZS4KLS0tCiBwbHVnaW5z
L2l3ZC5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvcGx1Z2lucy9pd2QuYyBiL3BsdWdpbnMvaXdkLmMKaW5kZXgg
ZWUzZWQ4M2U1OTU3Li5mMmQzNjgzMzZkMWEgMTAwNjQ0Ci0tLSBhL3BsdWdpbnMvaXdkLmMKKysr
IGIvcGx1Z2lucy9pd2QuYwpAQCAtMjQxLDcgKzI0MSw5IEBAIHN0YXRpYyB2b2lkIGNtX25ldHdv
cmtfY29ubmVjdF9jYihEQnVzTWVzc2FnZSAqbWVzc2FnZSwgdm9pZCAqdXNlcl9kYXRhKQogCQkJ
cmV0dXJuOwogCiAJCURCRygiJXMgY29ubmVjdCBmYWlsZWQ6ICVzIiwgcGF0aCwgZGJ1c19lcnJv
cik7Ci0JCWlmICghc3RyY21wKGRidXNfZXJyb3IsICJuZXQuY29ubm1hbi5pd2QuRmFpbGVkIikp
CisJCWlmICghc3RyY21wKGRidXNfZXJyb3IsICJuZXQuY29ubm1hbi5pd2QuRmFpbGVkIikgfHwK
KwkJCQkJIXN0cmNtcChkYnVzX2Vycm9yLAorCQkJCQkibmV0LmNvbm5tYW4uaXdkLkludmFsaWRG
b3JtYXQiKSkKIAkJCWNvbm5tYW5fbmV0d29ya19zZXRfZXJyb3IoaXdkbi0+bmV0d29yaywKIAkJ
CQkJQ09OTk1BTl9ORVRXT1JLX0VSUk9SX0lOVkFMSURfS0VZKTsKIAkJZWxzZSBpZiAoIWl3ZG4t
PmF1dG9jb25uZWN0KQotLSAKMi4yNS4xCgo=

--_002_MRZP264MB15441C29DB3B9AE00192133193EA9MRZP264MB1544FRAP_--
