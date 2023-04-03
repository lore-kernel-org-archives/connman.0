Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2072.outbound.protection.outlook.com [40.107.12.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFE6FA1
	for <connman@lists.linux.dev>; Mon,  3 Apr 2023 15:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcOfxC359ftMMmtl+Jb6+UK97evGeEC7ot3pOEBj8hCcjyeMIxK/VV9jqaBmxmNAbfE4/2II7YmgKFkWBC9SSID4K9yN/4Y5+67kdVi1xzpNtr3y5Vj+Ni9cLuU394YQrMl5xztRSYPpIWsh20LebAzvuDiSzK24DHPIkNztoRW8Gl0NgT+VvDODIxg82P8yNr2ycq/sFsoqXLaj5DAYK1tmtPVLxvgSbo1heYaPf9cTrWxyPqzTwdTgF7OpsgWi15qR+5aO8HOs3mMMVz8c+m+qUks/6pt2nJiRUgdGnfWi7sgeWU3awBGGin4EA4L2PrDwSbRhGO4/vmupIwDGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HYEpylGvvB5Fsdd0QXvqZRjymd6V9xQv0zMzRfiBw4=;
 b=W1HZDLV31u+c4cJlxSa/laOx3xtAXSl4jNKoBzzVwANG6xKmiwATRsG734HEP+cX2QA7xGIblKTKYgPFWU+6zGnffs3EGJU8VQFFIIYw2TU4OBorKU8iBUXISUfacFrb0xcxqghq9D37IV/q+27Sa1/V4H0Z0o4zcMGLf+oDzIpuqNTFNzPzeAJ3kbSNA+IqYuBg62H38lN2IBAyXCq3XhR4gt4VWxQ/Ib8FpR+p+A+YgfJvufGKuURnGBQ+v6ojF67tmpugqb7eYuPJ9kODjdHSlLia4NFnILsuCo7DIVKS3OkJTVAH9w+C+fa0mF4A0QJT+lPJZX4qKPLhxg3/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HYEpylGvvB5Fsdd0QXvqZRjymd6V9xQv0zMzRfiBw4=;
 b=z+hsEX6y2vLALa+dkuZnnyB/+s/+QNFihL+B3yDZSsTDuPF3qfTLCX1D0j7q2PKvdXyF/xo9Am0Dn4t/mK4b5yKRQk8xK/gyIFZJqhIXUdfnvN6nVmCXxXwv3YY2TDMUCJ3IuUKVU2/dFc6FjWa+1DszrFZb672EB9gIUeBR+kc=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB3310.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 15:02:19 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6d79:b93c:b64:95ed]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6d79:b93c:b64:95ed%9]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 15:02:19 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] timeserver: Purge timeserver list after reset
Thread-Topic: [PATCH] timeserver: Purge timeserver list after reset
Thread-Index: AQHZZjzPnz6VEK3UDkW2U5Q8sqNmwA==
Date: Mon, 3 Apr 2023 15:02:18 +0000
Message-ID:
 <MRZP264MB15443305B59D37C1180795F993929@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB1544:EE_|PR1P264MB3310:EE_
x-ms-office365-filtering-correlation-id: d2684fcd-f4de-439c-035d-08db34546b98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9ymKSNcyaqhNtWreFNZjtLk4jmJC8WyuNjO0Qk5tueGGpeM6VCyVDpzAHQcnDoUqO5kZhSAFIkk2AwuSRjYy/YHebJ7L1MeXlu6XUTZxO+VLiHvr1Azqva+hsQn5I9vPSgywrerT8E8r8T88eL+5xzi6juEXK6+sc/E02+Fn2hLPcfxytILx7Mb+3DKhZnVjvHnU7euTNIfwWCbWd+zBBg08Bt88vQx2nH7dgbhWmrtpKwiPqr1+W+9PjKe5hH+6hvnbdBGbEE/wZ7E4lZ0IKHtqf/EX6jDFlIAKEWsbHIroL71rn0WT9GbEXMlSSO5BYYPDfcieuEJxDrkMQJOAA4Qn18Fkv6Gz0Ey2eZxCYywBaSAgpctf7Vu6WpiycA9JlUtqjI85/ZwKf56dJIwPGTbmOTbAwwWMfIeL2r6XZCXlNVsq95sE6AU6ezU7lPfPFm03CCVixZcakvU/W8kng2thfk9OTkiTtDu1Gxrxsm9q0X9ZyEPgk5eJTy8cVnPF+sZ008cVG7mU+BGxvZpNmYOk6o8HiY1U0zM27XxmGVb+rklBKISm+5sCXTbNligqEhHXaYj+2yDuHkKQ2z2HMVJ1pC6/AVJTyxYJ5/Dmuv/zG2xctpM39gYMbGr5CpIY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(55016003)(6916009)(99936003)(8676002)(66476007)(91956017)(66556008)(64756008)(66946007)(76116006)(66446008)(478600001)(316002)(8936002)(52536014)(4744005)(122000001)(41300700001)(38100700002)(5660300002)(186003)(83380400001)(71200400001)(6506007)(9686003)(86362001)(33656002)(2906002)(38070700005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lr332oUqjGI1i6/q5xv+ajrApadDir7UE8yTbHptDvSnfFHME4ckgKXMnG?=
 =?iso-8859-1?Q?11CqpSVyoyAVcMGEhkm7ayARd/cK25ZtvwnHRot8v8nqF3BqJaOIt5NflD?=
 =?iso-8859-1?Q?91ut6qzEho6VPwZpnKtYv8722Y/lT/JgYdr9rXLkqoNdGdbkpt8VFLSgKX?=
 =?iso-8859-1?Q?IuNDGlCQvmloWPAC/lvYHS9TnqqzqbZUoHRC8vz5GjhgU7tqGNKr3+CQqi?=
 =?iso-8859-1?Q?AR2+I95KHuek8CgziYKv2HGadI0B2K3e94IkPhr8B/rX6ElRfhZRPGg9oH?=
 =?iso-8859-1?Q?3QGnNBKxfson9vOLtA8EYJBF+yofPR4JqRzeNSyHIUx16nFt763FS9kssT?=
 =?iso-8859-1?Q?HIYRNjeKK6JDsN3k3H9JcFilHYfLFVvcEZgUjx1OSo3QJDxz1uEsMyDtwI?=
 =?iso-8859-1?Q?c7/v9VkL9ESLk2GE4bpdjrFzHo6zkQQMUQP6gWp1I/217oyWquVxHm05C4?=
 =?iso-8859-1?Q?mW8IjtofnknyauMvmcAoG5elYSeYFpAuC5ZYY6nm4NqmgGNXkWEUEvLU1n?=
 =?iso-8859-1?Q?Ao1ZRZU2lC9tFuRrY0jC/LJb6Oq87VuvhCNFMsXSEvW3Z9waSk0Xer6BlE?=
 =?iso-8859-1?Q?z0i2kQ8PS5sERS140wbRVwOgQ4uA4bVJg8VT74W+Hz68qxx3TCdvjYZdpA?=
 =?iso-8859-1?Q?UCAXvUW6p5UGPQeUZdpQXYpRi8YusPQlge84qB5CD7ZqJAKjT/+MiMfbs6?=
 =?iso-8859-1?Q?LsgjmNnjd32Q/OCMABFv/wiaR4MLl8tB21aRAipBFsNBnLxE8sM5fzdNxN?=
 =?iso-8859-1?Q?bXkwRrTmrvjN0CpV8W9thcQ14axvCofrmDhXEXeg4rnenJqtnp2aNkeYIU?=
 =?iso-8859-1?Q?6qjVYRf0vtjOS5pksGW9kDki7mDxmdBvL21yqu5x0eTEeWCPceuMYp7eSM?=
 =?iso-8859-1?Q?OaXLZJxhHFDwh/9NaK/L8drkT9a9r3n4opoYgl4ErBQKAFjikGE5sXxX55?=
 =?iso-8859-1?Q?TfEM9PZ2Q6iN1pHEO9ANHvhMx9llnYBSa7XxYNlFuVw2gP8QCESZh7za8I?=
 =?iso-8859-1?Q?MScpKdixrQ/55xCP/djXqv5IcVuxbdOGgwv/nqzQEJDL/HUfO+AJBZ+lI8?=
 =?iso-8859-1?Q?aOXzJzPn5QMf6qFaUqYOW5xiM87pA6qka5HbATZqOjxrZhWzD6qRPXTwpf?=
 =?iso-8859-1?Q?LObLhZ48o6QHGzaTBg8wQB+QjkFVCqXtWqmFtnA/Vjr5YC5UhBnYV1O+bD?=
 =?iso-8859-1?Q?FsbCdzJepJTaErSMZeH7Exu/INFQHBsWch++J8CfcT8k3jVDbRmROPlmLJ?=
 =?iso-8859-1?Q?rRVTsayDdVANFS7OQQpXT/jMLRhMmNm+t2E1WYPMdw4vvocTgDSoUM1skv?=
 =?iso-8859-1?Q?fLpVRXDTdGYuFvgOIFjq0I8coR/UpaFYdWpXNOD6TC6djmkrvex8ceQnMq?=
 =?iso-8859-1?Q?qiPQ4C/l6Rhphob4JO8oU8rvJXd6tl4RUEHJCI/1ydEFVf5mIDapxdA4Jd?=
 =?iso-8859-1?Q?pm9nBpMHWU/v1lLq4tme2OGkqLWwGk3/DFB2D6FpyHWQH7tABSGCgRp/Tq?=
 =?iso-8859-1?Q?B1r2UMmZu+HErWfFsJdqGSjA/w8ojJrUYDbMISYCqWK6M2b0Utd6fN+feG?=
 =?iso-8859-1?Q?JY+NcFqTfmkRBNXCkyxkjp4hUuTcU5JHZn7lZdVZU0qUx7WQNtB9SHm6lr?=
 =?iso-8859-1?Q?gO15PM2b8YLU203qa6aRBJv3U6/z9rAmM26dNOSesCxsLw2FNzI432+zL0?=
 =?iso-8859-1?Q?Yl7DDgNITVRLa13mk6yWWpr4LOm3FM6uMsLNGZEDEgeOLcV3K4oPPxGBOn?=
 =?iso-8859-1?Q?mUDA=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB15443305B59D37C1180795F993929MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2684fcd-f4de-439c-035d-08db34546b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 15:02:18.9965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvBREzfsRuSRseUZx9uGUfavcBS/X/wUNiZxNPvF0FATPDpwIUaQbcLE/HvnWIrM++hFiOn+6K9l49i7cCcZ5IE6RJ+6BsiaYvtR2U6IxYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3310

--_002_MRZP264MB15443305B59D37C1180795F993929MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

When reset, the timeserver list needs to be purged from whole=0A=
timesever history, in order to only contain the up-to-date values.=0A=
---=0A=
 src/timeserver.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/src/timeserver.c b/src/timeserver.c=0A=
index 4c25d4b85746..d23776faa96c 100644=0A=
--- a/src/timeserver.c=0A=
+++ b/src/timeserver.c=0A=
@@ -413,6 +413,9 @@ static void ts_reset(struct connman_service *service)=
=0A=
 =0A=
 	g_slist_free_full(timeservers_list, g_free);=0A=
 =0A=
+	g_slist_free_full(ts_list, g_free);=0A=
+	ts_list =3D NULL;=0A=
+=0A=
 	timeservers_list =3D __connman_timeserver_get_all(service);=0A=
 =0A=
 	__connman_service_timeserver_changed(service, timeservers_list);=0A=
-- =0A=
2.25.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=

--_002_MRZP264MB15443305B59D37C1180795F993929MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-timeserver-Purge-timeserver-list-after-reset.patch"
Content-Description: 0001-timeserver-Purge-timeserver-list-after-reset.patch
Content-Disposition: attachment;
	filename="0001-timeserver-Purge-timeserver-list-after-reset.patch"; size=880;
	creation-date="Mon, 03 Apr 2023 15:00:05 GMT";
	modification-date="Mon, 03 Apr 2023 15:00:05 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3MmQ3ODFkNDA2MDYwOWEyMDU3ZGNlOTE4M2JhYjNmOTIzMGNkYjhjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IE1vbiwgMyBBcHIgMjAyMyAxNjoxOTo0NiArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIHRpbWVzZXJ2ZXI6IFB1cmdlIHRpbWVzZXJ2ZXIgbGlzdCBhZnRlciByZXNldAoK
V2hlbiByZXNldCwgdGhlIHRpbWVzZXJ2ZXIgbGlzdCBuZWVkcyB0byBiZSBwdXJnZWQgZnJvbSB3
aG9sZQp0aW1lc2V2ZXIgaGlzdG9yeSwgaW4gb3JkZXIgdG8gb25seSBjb250YWluIHRoZSB1cC10
by1kYXRlIHZhbHVlcy4KLS0tCiBzcmMvdGltZXNlcnZlci5jIHwgMyArKysKIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvdGltZXNlcnZlci5jIGIvc3Jj
L3RpbWVzZXJ2ZXIuYwppbmRleCA0YzI1ZDRiODU3NDYuLmQyMzc3NmZhYTk2YyAxMDA2NDQKLS0t
IGEvc3JjL3RpbWVzZXJ2ZXIuYworKysgYi9zcmMvdGltZXNlcnZlci5jCkBAIC00MTMsNiArNDEz
LDkgQEAgc3RhdGljIHZvaWQgdHNfcmVzZXQoc3RydWN0IGNvbm5tYW5fc2VydmljZSAqc2Vydmlj
ZSkKIAogCWdfc2xpc3RfZnJlZV9mdWxsKHRpbWVzZXJ2ZXJzX2xpc3QsIGdfZnJlZSk7CiAKKwln
X3NsaXN0X2ZyZWVfZnVsbCh0c19saXN0LCBnX2ZyZWUpOworCXRzX2xpc3QgPSBOVUxMOworCiAJ
dGltZXNlcnZlcnNfbGlzdCA9IF9fY29ubm1hbl90aW1lc2VydmVyX2dldF9hbGwoc2VydmljZSk7
CiAKIAlfX2Nvbm5tYW5fc2VydmljZV90aW1lc2VydmVyX2NoYW5nZWQoc2VydmljZSwgdGltZXNl
cnZlcnNfbGlzdCk7Ci0tIAoyLjI1LjEKCg==

--_002_MRZP264MB15443305B59D37C1180795F993929MRZP264MB1544FRAP_--
