Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B54CDE0
	for <connman@lists.linux.dev>; Fri,  3 May 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773530; cv=fail; b=JtafCsGLyPpjrCmX94ZpKFzNFu31xfhVdYPiE+fzu8gScyHgVXlnJpUyUgXU7LXopHgxyNo1G3+0A99qOwGgoMRqdfgnr/BoxX0Vjn4FBJWKZclYtQ7kUIv1mNftrsbgmPS2z3saYhTPd6pJ6gBQ3i98mx7sa0hEv7tHrk2GJV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773530; c=relaxed/simple;
	bh=Wu1ZCUqF+7R/hZwTmIAsWCDC+AvASE5gUPLJbxWgNKE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LTmAOXFK7rX7toPoee72NfW0lhyijtB6m9ZDEToxnh3Lrqg3VZ7HMTt7YuPQrs7FlImi1fnXETTw3611nW1mBh2odB5xB3/NkLnCW8kX1XO4YDbGaGGFVdVYp9E6ntJ8vyjhNfK8+aVWvdSOA+YuJVnIgzQCDCeFLUSFKx4T0eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=A0zR9Dgz; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="A0zR9Dgz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwy3TZi9s0AHomSdYtK+N17ylBJjPzMp0igZzj6BjgqCbeeH8NAGJuoRbNVa+njqbo+XBg8Uuieo9han9qTepnhIrwmrss7AViKxtH4IBco874hTqTGw6wJ8CqmdMOwE9u2f3VokuNDMc6W/e+GnBnDcO08A2TsfrDnM7NuQPt7O2oYwhLrfbXrxb6vvaLFtBeCb4O1CS4vwykveMEb0BMo1uyoB+/d18Zf5zxGTTZ5FGbrq/fzRr+o1QiVeMunB5DJaUdMnXMKGGjMrSzIHIuev1IzOfMBYlZiIB5Qw0RfDlvsMXAperpFIACSpDNEvsy6B52XViFBOyBCT/jxd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnS+SMRzdY8rTXD5woAv9VnWhb6VqWMdQ6ssDr6Myc4=;
 b=Gf52UBNXoWbkF3DCuFAaHi8WTCRChL+Uw/2jBUueCj7xNm4ozFX/HCHBaJro03h3qKrCtc8iadLypAs65t9Q9Vxr9RiXcsVsbou9pryFscKmWjIe7mry25qAbwDeHqhOE+Kr1e4jKVtG2VxogUpwNGtPfkOnwAd5Dx5FgsuEDIxl0T1xYLe9Bdv+r8lMY0ZCFudzSVL1lsnJA6XFo1sbRK6mSeCQ4iWTgxueb/uLvW1uj8k/4uy7vtDbetTGo87UgAqkNFKX434RNlZqRl4vb+6uZkIfAo7Bruf2MDkw7uCRbwXw0deYpRZyiylBN+IsabEsPdp9V9o7bj0eHoYdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnS+SMRzdY8rTXD5woAv9VnWhb6VqWMdQ6ssDr6Myc4=;
 b=A0zR9DgzivOjwK0ee/vAyFQDci4ACEz8tiVApLuz1vPYbkr9a2mddgtfjUuJh4l/6WIN5lbZDYvgHAgULsueQhZT/LHD28pjyurXXwKJq+uyZiZzRc3gphlhk2VhhmWDMJ2C7GOgA+DS+VRxOueeyxfh/PXCjtjBWvWxib1uUwY=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 IA1PR16MB5288.namprd16.prod.outlook.com (2603:10b6:208:453::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.29; Fri, 3 May 2024 21:58:45 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 21:58:45 +0000
From: Colin Wee <cwee@tesla.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Prevent a short allocation by checking upper_length
Thread-Topic: [PATCH] Prevent a short allocation by checking upper_length
Thread-Index: AQHanaUR/Tr7kTIZlEmp6i82TKynsA==
Date: Fri, 3 May 2024 21:58:44 +0000
Message-ID: <lvq5tor4tudvh4xtxy47p3cescldr3v5c3fijgrqwkdfrktq5g@ycqxblnjgbaj>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|IA1PR16MB5288:EE_
x-ms-office365-filtering-correlation-id: 298c07ce-041a-4be3-c371-08dc6bbc33fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|366007|38070700009|27256008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FLbHu6Sy9srus8QAEEers0oXlKUw7cnLEdKjIOWaSJ/uREnDWNFj6lxCr9aU?=
 =?us-ascii?Q?/gWrscHU2CouJpLeUlKdep0Jr8APaq4/mNINipXh/impo9/seQ+fxiPdz6ED?=
 =?us-ascii?Q?CecUneiRHTdnWrr9ycqp7pVZ5X+m0T+OAofDLh5Lz/LV+alCVdBy2qosmQFw?=
 =?us-ascii?Q?D4fXXSLFZ83qfSR6wSz7ag+HJWcr8ldNleP5/lRiIoI7dUzVsSTwGoAWi9va?=
 =?us-ascii?Q?1hrlv9U+CdN2vFSVNWK3lN1izs7UlSV2lkix5HI6K5RceETV0eWxBd/nPVTF?=
 =?us-ascii?Q?PtY867D5faBs/wP/GVaTFQBgaJ+PAR/YVATHO6SDOp6jHQAgfC2qVINzfRJG?=
 =?us-ascii?Q?kZoKAdnSxv8MjQ71MjUXxTj8NLuNGDIdT3Re0j+xwiSXi25hmkOhTLB7gsqc?=
 =?us-ascii?Q?j4eBA6Enmma0x6uBubmrYIDJ8vA9JBrwGvOafEpaf4pvC+ukO5oSzz9hKPtc?=
 =?us-ascii?Q?AVC1KDctjvqcgfMhrrR8BXBfrNswv1AMVOHhIo9Hq7+c8WBZIMR0TKjTWKgi?=
 =?us-ascii?Q?qP9qbCB+ucc2vY2ZVL6OYOBEaDC4OLbFUOPqn3+x50AGCzLuB2cyBgOqD9ry?=
 =?us-ascii?Q?vjhS5HkjsMN07k+1tU3jsnVKsCfs/x2CA5FOl+iMK6B+J3G5LcaL1obcoWy7?=
 =?us-ascii?Q?kI4yFoL1Z1mGUj+3BDZRVislk32/9xgaGwe+PY9Tys0rPPNzGCBITbIZDGHs?=
 =?us-ascii?Q?v0VkGLYEIYnHJi3/jqBJqdUBIFYDPnCghXK2TxFyG8Ch5juP9WEC63U3pcNN?=
 =?us-ascii?Q?dn8wfaRrHi8fgUFognidC8n60vZWsZf/+C5NtRYScEU0WvwNjxPda1Ch3QDl?=
 =?us-ascii?Q?z48riUvGEBYSD4nRuehmziwB3JToYsQ2Uqfk65cGpCmCa6X25cX+tKOfzLKs?=
 =?us-ascii?Q?EfhPIsrGt3BJNLPe+iW3TvoT3voyeFkY9dd9xDGShAb/tAPkhEG5kVVblkD+?=
 =?us-ascii?Q?8mQQiBRPJshCzgBCgjdWqk5KknEWMb5+1ET4794NpPQRtd0UKl2NnMbXeKe7?=
 =?us-ascii?Q?OfauTd0qgTT4/jLt45y1DMLN2S8ERSd5ZA7D1BRMcdFcrJlfwCDCxKppzEmW?=
 =?us-ascii?Q?bUgCe4ATW231HLfvaDb52hSFgEdfsk+QxNh92goZol3hZs7su7A4b6qkjEbl?=
 =?us-ascii?Q?MeLs7/H7KtegE6wZDONF8Nd4xHsW9iroi0vbColCx/n+XVcw+zlMNQ3AB6Qe?=
 =?us-ascii?Q?iJYMUaO/VGv6xbfhrzYUQpp9WBaQN0kzgc+XRmX+IeQfITjUfZOEvqPB6F2Q?=
 =?us-ascii?Q?pmj27blfQlhsn8wtJ0FvkJs5qaQ5BhsuO7qWrBE2/ZuyL+1foUvBELIoQQ4e?=
 =?us-ascii?Q?KnX+E99knp0xwX9DdIUPP+ajonBCh8wqnSv4iV1DGLEyoOzjnlRbCJ01TpFR?=
 =?us-ascii?Q?vItdkgE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(27256008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RyaqyH0LyqSWYtB7VsD4qPAZYS8TnBe3jz/uT6oVkdqPw6N6VaGgoSblUyZm?=
 =?us-ascii?Q?4lwQDduHzIZAqDu9F8xLm+BtgNzQjjw3+f81YtKBHz76KevS5+TS0/9iL6gR?=
 =?us-ascii?Q?tSTOBRfqkSF0euL01dLCkb+rCQsxlEKTJLciM49ua08a20a0FXGcHZgga2AG?=
 =?us-ascii?Q?yVqxBZnvZrWtArlekBN0Ueg3Jpx38fcdEZhLlSa2JHehqwN1ibvX6r10eZV7?=
 =?us-ascii?Q?lGeaBxU37K7BCbbYbC82ItB0Yb5lv/4ao+gx12kw3dBilTNgxjs/cDLEAnsH?=
 =?us-ascii?Q?QbSiMwBaX6txBJ0LoTFWaHHavHzSfQPr4M7eNhlHrfQ6z4I/P9W1gtXMaqF5?=
 =?us-ascii?Q?8/QuIdRCmj3jIfFwkkn00Oh6Z4eG2Vy0Q5i6PERsPQ1AeLYy6ExCdMCSQOkM?=
 =?us-ascii?Q?wZt8txq4BpOdUuPFro4ilTsgbRZRS4de12/crHPcAkUbbUnxIRxLybCeqepa?=
 =?us-ascii?Q?msyZ3wUXg4vkI8xBrefwqGdGPDAtGU2+uGLSqI3FfwCMeLfKskzqzVpEtbY5?=
 =?us-ascii?Q?HyWMUgoHUBMSdOjgByIpIRCoBQl9a1WPbNa1Pp3TLpaLwabmLFJw17CHUnlJ?=
 =?us-ascii?Q?ZU/U2u6sEP1RjGbmO6N6vosy6lc0LJbZv8yhAFxaFKW+H1PFt3Z/GlEY4+IZ?=
 =?us-ascii?Q?2+LoiIeZwtl9Niaj5xqC3mJ3oUICWo7MF+R7RWM0R9K5Pljw3cylADIaIrHW?=
 =?us-ascii?Q?5dXFasGxjXun29poFOH5vdL0DztVTCPUIB7abAX4MdT6hCc7oveuUL4YLprJ?=
 =?us-ascii?Q?5zHy3x1nUIOmodIDApPtH31ao+I+HDaduu9GOA/YMhgtgL2dJae4tfhZ4uVR?=
 =?us-ascii?Q?CZEl3h6miaGVBbihpnwzzDO0E+xfXiFVCbFulrKgBaOGP3I+u4Owe47hKX7h?=
 =?us-ascii?Q?fkKCKjh/X+sRSlrYJMvMPTEeD2R7Qmqi5vxh9vUQXkAPHTqVt8H+UISQz6NA?=
 =?us-ascii?Q?osOmawi4jvfOdPVlFCi0X4TanKrl5kRWlgVDIy0XwD/4QRC51MB4WWgU45oP?=
 =?us-ascii?Q?hLaVYOYqDlhN3kpbiKz+sNeGp8sVf2LGFd3PkFaa7CUuRxy6PkntaxctCpTi?=
 =?us-ascii?Q?f6Xc+0Gz8lHxO7eyJoWfQRdiFgDY2dy9FJhyHx9l6Vu36M8Nu/eWd2OnxCbh?=
 =?us-ascii?Q?xUyWeAHuloPo/4lsVtDKEr6CLvzRJbBUja9pgDUqJP8AzeoCdh/FQiD/L3C8?=
 =?us-ascii?Q?QC8+3Twb+0fzJD6iNdRR+DrwuHvXWqKRAB2irz4lXi+pHI5qKgSBVaRp4dR/?=
 =?us-ascii?Q?OqM1HlT+xZKP9Wr04t7eHKTOwjjzZWWd49pCuyBPCsBqlt7QCJ2jzSPkuR2z?=
 =?us-ascii?Q?Nh0WXYtyJV05+qf2OuhofCEzGe6+eNy7Ausm1ghvkz49RJXoUN7NQ/tv1nhd?=
 =?us-ascii?Q?iFRsUQwOQPqo1fvyRKME3qAPapQf1UN9Cat4mwR6KH5JFlEx5ZItcHZS4uFX?=
 =?us-ascii?Q?zcOeYYIDd08ItSbKvRIZOqS5Cu/XEAVG3BNnbUC0KQD+9fZFKzQzLV1VLj+2?=
 =?us-ascii?Q?xfwAtW9uowG0B/URsRnKLew9VNzh4xUnckEjitpWM4fPU9D4L2nDuyMiotGQ?=
 =?us-ascii?Q?fNhTht7j7GomJB0CsP5pyN25a5dOz5175LuiX0BS?=
Content-Type: multipart/mixed;
	boundary="_002_lvq5tor4tudvh4xtxy47p3cescldr3v5c3fijgrqwkdfrktq5gycqxb_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: tesla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR16MB4504.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298c07ce-041a-4be3-c371-08dc6bbc33fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 21:58:44.9879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3NbOG7BeC8iWkMF0QQtIldFZjAtUn4xPMBoqrLJve/9rqm51ZylCkSGspWgG9u+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR16MB5288

--_002_lvq5tor4tudvh4xtxy47p3cescldr3v5c3fijgrqwkdfrktq5gycqxb_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84CDC94CA01E5F428B3D939975E8398C@namprd16.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Hey Connman Maintainers,

I'd like to submit a patch fixing potential memory corruption in
connman. I've attached it for review, please let me know what you think.

-Colin

--_002_lvq5tor4tudvh4xtxy47p3cescldr3v5c3fijgrqwkdfrktq5gycqxb_
Content-Type: text/x-patch;
	name="0001-Prevent-a-short-allocation-by-checking-upper_length.patch"
Content-Description:
 0001-Prevent-a-short-allocation-by-checking-upper_length.patch
Content-Disposition: attachment;
	filename="0001-Prevent-a-short-allocation-by-checking-upper_length.patch";
	size=759; creation-date="Fri, 03 May 2024 21:58:44 GMT";
	modification-date="Fri, 03 May 2024 21:58:44 GMT"
Content-ID: <1AAFBF4028C3534095C02B2CA2F716EC@namprd16.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBjOTQ1MmUzNGU0NWJlOGI1NGZhYzA5OTY0NjRmNGE1NDg3Nzk5Mzc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGVzbGEgT3BlblNvdXJjZSA8b3BlbnNvdXJjZUB0ZXNsYS5j
b20+DQpEYXRlOiBGcmksIDMgTWF5IDIwMjQgMTQ6NTA6MjIgLTA3MDANClN1YmplY3Q6IFtQQVRD
SF0gUHJldmVudCBhIHNob3J0IGFsbG9jYXRpb24gYnkgY2hlY2tpbmcgdXBwZXJfbGVuZ3RoDQoN
Ci0tLQ0KIGdkaGNwL2NsaWVudC5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2dkaGNwL2NsaWVudC5jIGIvZ2RoY3AvY2xpZW50LmMNCmlu
ZGV4IDJhZmExOWU2Li5jOTIzNGExOCAxMDA2NDQNCi0tLSBhL2dkaGNwL2NsaWVudC5jDQorKysg
Yi9nZGhjcC9jbGllbnQuYw0KQEAgLTE4NjMsNiArMTg2Myw4IEBAIHN0YXRpYyBjaGFyICptYWxs
b2Nfb3B0aW9uX3ZhbHVlX3N0cmluZyh1aW50OF90ICpvcHRpb24sIEdESENQT3B0aW9uVHlwZSB0
eXBlKQ0KIAkJcmV0dXJuIE5VTEw7DQogCXVwcGVyX2xlbmd0aCA9IGxlbl9vZl9vcHRpb25fYXNf
c3RyaW5nW3R5cGVdICoNCiAJCQkoKHVuc2lnbmVkKWxlbiAvICh1bnNpZ25lZClvcHRsZW4pOw0K
KwlpZiAodXBwZXJfbGVuZ3RoID09IDApDQorCQlyZXR1cm4gTlVMTDsNCiAJZGVzdCA9IHJldCA9
IGdfbWFsbG9jKHVwcGVyX2xlbmd0aCArIDEpOw0KIAlpZiAoIXJldCkNCiAJCXJldHVybiBOVUxM
Ow0KLS0gDQoyLjQ1LjANCg0K

--_002_lvq5tor4tudvh4xtxy47p3cescldr3v5c3fijgrqwkdfrktq5gycqxb_--
