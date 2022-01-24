Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120053.outbound.protection.outlook.com [40.107.12.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93992173
	for <connman@lists.linux.dev>; Mon, 24 Jan 2022 09:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDoo4PVh5l3jL5E81FujnlrvYegrqxyQ0J4Uy0wdZ0zVB/eI0u6bEPxNLyvNs80bC2LNlwHpnGBA1wvXqwhDm0fB8V5lcBo33wlOMoHJToGVER6+nT4BG0i4INYSHMMys1iCAhLb7D+Sh17rvNzsKJtWo2TG8neBxYk/0+Qz3KzttjlXyndJmQ73h5On9VOZqJiFPX7H1hSaX5VqraBzsTZpz2OBFdd9JtW7RxtmAbXlgd3f3U3B62N0Qk4xIjMW1VncgSRgQnWMGzbNLrVWGndahOYcxAhhFNLJ6jAZzX5mvmp/Ys5ZpX89cF1TwEsI9L9rJPh4jIREWD77JnXQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfR93mHdH+3FJFWcidsuNZm2Rq5+5ohrxAPZ/DhDoqI=;
 b=aaESgnFdV1hyfqjyT2Kqk7WcUMD9dXLoQSMoafUNIExNCVBCfACt+ov0DspztDFTfZn5Z0eeVdEkFYGuy8ivJ1wzrs+VpMKYn1OfIxhTld88ccBfYOUnOy76Aetqzpo/RsfRmOBtMWfmZuOMxvtWOAWMKoaF331YvNucvKfmvTTawMDL2HdTYCPRWxQ55wtasORlWY+3cdImoCN20ZhWdNDBd8LpMb69H7wnMWoeg8xuUJkPLnGTRJ/rPcQ2yX2yVVgLvyYct7CHjxbpDyINc1IkfCiWLU4smMRHk33hGvlM9cdsr+IqNtPJMg7heFm+EC03vwvTNbdUEkPcSEoouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfR93mHdH+3FJFWcidsuNZm2Rq5+5ohrxAPZ/DhDoqI=;
 b=Zymx8l2Ey9/QiaH9yFvFMcn4tbCxz0GjV2fQUpBWfZgeg7c69SB78KB1Xo9lZWZ8xx8ufp4YFMyZ+0U4uE54/SpBvFlAhCkAr/S5xbueAPd217afr4S50+Gz19Ax1E//BCykCDX7hUclvGJEHgWN5TAu9oj9axMWT0qD4ZULHAU=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2150.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Mon, 24 Jan 2022 09:38:59 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:38:59 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] unit: Fix missing declarations in test-iptables
Thread-Topic: [PATCH] unit: Fix missing declarations in test-iptables
Thread-Index: AQHYEQW9tntueUCvX0OTmh9ny0k/J6xx6bAZ
Date: Mon, 24 Jan 2022 09:38:59 +0000
Message-ID:
 <MRZP264MB1544E155AD12B597E4474458935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220124093515.7166-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220124093515.7166-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 5077800c-859b-3e22-57fa-bc60539d2f8c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b5a1d90-4067-40d1-2bd0-08d9df1d595f
x-ms-traffictypediagnostic: MRZP264MB2150:EE_
x-microsoft-antispam-prvs:
 <MRZP264MB2150359793E76990A6BF7ECD935E9@MRZP264MB2150.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 56mCBv8WRlT1qTnhJve3PPPaGryKSpmh1DEb+KtuoUmfkn48kBJkbckfC/+HtSvrtXlN08QVneXUYuIRWVY2BHnpeK+g0ET39pZ3GlSyNxeTAm8zWRppaBi7OS+zT1Apv5jRXo9ecsVSRLATHZng/w8OS/C6B46P1SxPwsaMT/e7/tUCh3lT3OQnvp6NbQWScySAMEu1ja8WL0BzBVJtLUGDYHLCZ5GXhKo+DKER75OKAdi5NHL5QaMISLkJQZrHlAWERMsAYkniJzdFkb4T+AaObEyTTb/gxOTdbvPHHarFNVskMkNCq98lrAAtyzXG1/1s9l6sLblv+Lf4b9LeTNoZewYbLoivah1XdjgCMIKkoftnWtklevZ9/+p/KtAyknkVTLfaFljamfFr7KsM96fGDagwhUliTuy/FWLJHGV49nA2yi0WmlwSzOOl2r61lmA2JD2RINI1PQX3s3NQEj+QCuYAP0pHOLoPXM8Ys79vJUjjsD8FCAW3mc+798B36HZOrNusuW30OAKsAszSN3chfrUDAgDzdglPWYNplJHD1uYkllIOuf86KHzfuu0tkEWnCaJrZ2G8s7peCi4nSmCoSzAk4r6xQonD00L2foic3bmXz/QekgoJJryhOoqVzMiM3rq8mg5cKRW2vga1io1SNS4bVKKL2NfnGb2U6Nnv7EifgErLTDEmg/x5vA1zcykx4DYI/w0NItmuTREbZQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(19627405001)(86362001)(5660300002)(38100700002)(2906002)(99936003)(71200400001)(76116006)(91956017)(6916009)(508600001)(6506007)(316002)(33656002)(38070700005)(122000001)(8676002)(8936002)(186003)(66446008)(66946007)(55016003)(66476007)(64756008)(66556008)(9686003)(83380400001)(52536014)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SVr1CZR3D/EeAdKd/pLQ9r8D04t6F0jWdp0uHhYC5aJAyU1k0UzkPcFg71?=
 =?iso-8859-1?Q?AMfQtIrN4eWD5HP7BpzriFQxGFbyZjGfdbyuJY2IIl95qvY69FOdafPYvQ?=
 =?iso-8859-1?Q?3BvS9Gms+LEmag+9d87L2mx403RVH/ZAMYrQibGQZZbsVISYdTjreCF5FZ?=
 =?iso-8859-1?Q?b5ZcC3ZqsXX6Q0iNfs7k7f2Umlio1q1HtgBk1E/G8Jltbm7N639sH2vEnV?=
 =?iso-8859-1?Q?nvTKSbCBNpoy2PxnsgWPrvsP8JM9eyMOCIL+L3ysRyZC4xwWUverxzsyqa?=
 =?iso-8859-1?Q?hdURHpoVSyI9zFbOjXyr9Dy77KTVpENeelJK8s7Y7G82iq12x+7566oT98?=
 =?iso-8859-1?Q?UMRg6x696DqiEK39GN+NUyZQS1x3JQX04Q0SfmOi4P32Jo/WBp24h4z/A/?=
 =?iso-8859-1?Q?Kcb7U02x2GvO2RaS2RlyWKEYZ80JPe0gYFeT5caqlqJv/Qh3xzl7lfLyDV?=
 =?iso-8859-1?Q?p5csQSiOZESWmMcqzLbC4LAdGwa03FyE34oi0V2Q8txxOqCHsJxHtIX9qe?=
 =?iso-8859-1?Q?FsfVGMw23uTCWBiL91+Ypk3KKb5u0e7av2GJ6czJ2BxDxd1emTtHaIC4R3?=
 =?iso-8859-1?Q?JX6yrnlq2a5uxrmrG0rwljoyhwRNImwh2VpzdVgkNK5EXBzTEyKmh13cK0?=
 =?iso-8859-1?Q?dTHkVe4EUMbQBuUjA5myCJAL1kldlnjBbmbHNiES4yP6VMB8oBhlaZL6eR?=
 =?iso-8859-1?Q?GKCoOmRYKXtIlwCwKxpU7fW2RYF7lG6SkdkSY0p2bIIj167TQFjUEVzisi?=
 =?iso-8859-1?Q?Uh/p5jBArInC2J/7Q93QebrZ3aOOt3oOmNmuyc6c70g9knLT47qNddTXHb?=
 =?iso-8859-1?Q?pQISnJ6sR5Z+g0lNr2y2mcSq/JS+hjfZEplmcgmCcdl22LrM6guRtE0s+o?=
 =?iso-8859-1?Q?iazsh3G1yXPUFSyoJikLXtnhmroUSixG7ShSc+pasCkSCMW3usuxu0sjGV?=
 =?iso-8859-1?Q?spUFOlZl8JNEqcowK/mVGxCHK3sexzAW3/92Gpj5sV3Axef0VkOYb7TesV?=
 =?iso-8859-1?Q?/k3503u3fk/d3voEhiik6PPEUawK2ItkrWxWEAe8wzT2bZ3et/9nkwJp63?=
 =?iso-8859-1?Q?B+MDUu6FSoApd+2WrAV8gAhRnlsnDbskaSpDyXJuKdQPyY78OLNZSCook4?=
 =?iso-8859-1?Q?5ZEED6bnIZIgrVxV4vnUz6mavai1Yva56l9HAwMY25gXpH30RU5QV3iqxj?=
 =?iso-8859-1?Q?qWZC/TAH042AD348CNt9Yr1HnE14P0WhwBVkyDXra+wy6U9lQx5alawavs?=
 =?iso-8859-1?Q?2oas+XvigIdnV9aH3OIMc2c0uU50e+HWVz7tQkDpRXW3oXxlidtZ5hRyTX?=
 =?iso-8859-1?Q?9qstNRGdqatiB3+YrEUiky4IX3XYRLg8ideJSStUZ/tocuYxmjjhPKuTjh?=
 =?iso-8859-1?Q?RKEx0S5HQCqJqZnPjqBavOScNVeQY37nAxC2NQnMBN084jhU0hm9XA3gG0?=
 =?iso-8859-1?Q?k5+V4snFtEkGXJoNgSbfyQResPj9wHgsrxDkm0RdVGF4fMVeDc2n8649Gl?=
 =?iso-8859-1?Q?7oLhmmop4r8FYNY0QTZ0PlgrlP/2rgMj8J/CIUmeZLTS2ws7AroU3M10aX?=
 =?iso-8859-1?Q?15d+moidUEIAlX7hLnfv7M0WHKKzvX8Z3SWE6c6JLL9oywejE20XqOisN2?=
 =?iso-8859-1?Q?ka7J/qU8rvesotQTFdFusQxsRIh1bMiue++nz4cA3A8er1oZiPI1vAgNwh?=
 =?iso-8859-1?Q?nUteaXcqe3rUFtojc+mQhI8Kc3dk3rugec7EB8pObfEgqAgBrnjhHjItz6?=
 =?iso-8859-1?Q?0IQG5iePZ63f560uh5IESCAKRQ3EDY1lVEv9DZ+3XAraLRvJa2wOpLtiLt?=
 =?iso-8859-1?Q?Ukn6qDYapQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_MRZP264MB1544E155AD12B597E4474458935E9MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5a1d90-4067-40d1-2bd0-08d9df1d595f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:38:59.5453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BjOLD5HTRLYA3uVvWvf9d2+f+Y73LRIMZCGuy72yQepa7014fbMxZUoET30YE3WxC08GHdmYxKiDszDWH1oPTjslP7H35LmzbDhOjDf9fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2150

--_004_MRZP264MB1544E155AD12B597E4474458935E9MRZP264MB1544FRAP_
Content-Type: multipart/alternative;
	boundary="_000_MRZP264MB1544E155AD12B597E4474458935E9MRZP264MB1544FRAP_"

--_000_MRZP264MB1544E155AD12B597E4474458935E9MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

gcc reports with:

 unit/test-iptables.c:72:5: error: no previous declaration for 'xt_match_pa=
rse' [-Werror=3Dmissing-declarations]
  72 | int xt_match_parse(int c, char **argv, int invert, unsigned int *fla=
gs,
     |     ^~~~~~~~~~~~~~
 unit/test-iptables.c:78:5: error: no previous declaration for 'xt_target_p=
arse' [-Werror=3Dmissing-declarations]
  78 | int xt_target_parse(int c, char **argv, int invert, unsigned int *fl=
ags,
     |     ^~~~~~~~~~~~~~~
---
 unit/test-iptables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-iptables.c b/unit/test-iptables.c
index cd261d054132..f08736ea5f0e 100644
--- a/unit/test-iptables.c
+++ b/unit/test-iptables.c
@@ -69,13 +69,13 @@ static void set_test_config(enum configtype type)
 #define IP6T_SO_GET_INFO                (IP6T_BASE_CTL)
 #define IP6T_SO_GET_ENTRIES             (IP6T_BASE_CTL + 1)

-int xt_match_parse(int c, char **argv, int invert, unsigned int *flags,
+int static xt_match_parse(int c, char **argv, int invert, unsigned int *fl=
ags,
                        const void *entry, struct xt_entry_match **match)
 {
        return 0;
 }

-int xt_target_parse(int c, char **argv, int invert, unsigned int *flags,
+int static xt_target_parse(int c, char **argv, int invert, unsigned int *f=
lags,
                        const void *entry, struct xt_entry_target **targeti=
nfo)
 {
        return 0;
--
2.25.1


--_000_MRZP264MB1544E155AD12B597E4474458935E9MRZP264MB1544FRAP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
gcc reports with:<br>
<div><br>
</div>
<div>&nbsp;unit/test-iptables.c:72:5: error: no previous declaration for 'x=
t_match_parse' [-Werror=3Dmissing-declarations]<br>
</div>
<div>&nbsp; 72 | int xt_match_parse(int c, char **argv, int invert, unsigne=
d int *flags,<br>
</div>
<div>&nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; ^~~~~~~~~~~~~~<br>
</div>
<div>&nbsp;unit/test-iptables.c:78:5: error: no previous declaration for 'x=
t_target_parse' [-Werror=3Dmissing-declarations]<br>
</div>
<div>&nbsp; 78 | int xt_target_parse(int c, char **argv, int invert, unsign=
ed int *flags,<br>
</div>
<div>&nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; ^~~~~~~~~~~~~~~<br>
</div>
<div>---<br>
</div>
<div>&nbsp;unit/test-iptables.c | 4 ++--<br>
</div>
<div>&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
</div>
<div><br>
</div>
<div>diff --git a/unit/test-iptables.c b/unit/test-iptables.c<br>
</div>
<div>index cd261d054132..f08736ea5f0e 100644<br>
</div>
<div>--- a/unit/test-iptables.c<br>
</div>
<div>+++ b/unit/test-iptables.c<br>
</div>
<div>@@ -69,13 +69,13 @@ static void set_test_config(enum configtype type)<=
br>
</div>
<div>&nbsp;#define IP6T_SO_GET_INFO &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;(IP6T_BASE_CTL)<br>
</div>
<div>&nbsp;#define IP6T_SO_GET_ENTRIES &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; (IP6T_BASE_CTL + 1)<br>
</div>
<div>&nbsp;<br>
</div>
<div>-int xt_match_parse(int c, char **argv, int invert, unsigned int *flag=
s,<br>
</div>
<div>+int static xt_match_parse(int c, char **argv, int invert, unsigned in=
t *flags,<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; const void *entry, struct xt_entry_match **match)<br>
</div>
<div>&nbsp;{<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
</div>
<div>&nbsp;}<br>
</div>
<div>&nbsp;<br>
</div>
<div>-int xt_target_parse(int c, char **argv, int invert, unsigned int *fla=
gs,<br>
</div>
<div>+int static xt_target_parse(int c, char **argv, int invert, unsigned i=
nt *flags,<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; const void *entry, struct xt_entry_target **targetinfo)<br>
</div>
<div>&nbsp;{<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
</div>
<div>-- <br>
</div>
<div>2.25.1<br>
</div>
<div><br>
</div>
</body>
</html>

--_000_MRZP264MB1544E155AD12B597E4474458935E9MRZP264MB1544FRAP_--

--_004_MRZP264MB1544E155AD12B597E4474458935E9MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-unit-Fix-missing-declarations-in-test-iptables.patch"
Content-Description: 0001-unit-Fix-missing-declarations-in-test-iptables.patch
Content-Disposition: attachment;
	filename="0001-unit-Fix-missing-declarations-in-test-iptables.patch";
	size=1559; creation-date="Mon, 24 Jan 2022 09:36:56 GMT";
	modification-date="Mon, 24 Jan 2022 09:37:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmMTUxMzNhMTUxMTEwNWEwN2IxNGUzZjlmMzIxNzJkYjUxZTAzMWU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IE1vbiwgMjQgSmFuIDIwMjIgMTA6MTE6NDAgKzAxMDAKU3ViamVj
dDogW1BBVENIXSB1bml0OiBGaXggbWlzc2luZyBkZWNsYXJhdGlvbnMgaW4gdGVzdC1pcHRhYmxl
cwoKZ2NjIHJlcG9ydHMgd2l0aDoKCiB1bml0L3Rlc3QtaXB0YWJsZXMuYzo3Mjo1OiBlcnJvcjog
bm8gcHJldmlvdXMgZGVjbGFyYXRpb24gZm9yICd4dF9tYXRjaF9wYXJzZScgWy1XZXJyb3I9bWlz
c2luZy1kZWNsYXJhdGlvbnNdCiAgIDcyIHwgaW50IHh0X21hdGNoX3BhcnNlKGludCBjLCBjaGFy
ICoqYXJndiwgaW50IGludmVydCwgdW5zaWduZWQgaW50ICpmbGFncywKICAgICAgfCAgICAgXn5+
fn5+fn5+fn5+fn4KIHVuaXQvdGVzdC1pcHRhYmxlcy5jOjc4OjU6IGVycm9yOiBubyBwcmV2aW91
cyBkZWNsYXJhdGlvbiBmb3IgJ3h0X3RhcmdldF9wYXJzZScgWy1XZXJyb3I9bWlzc2luZy1kZWNs
YXJhdGlvbnNdCiAgIDc4IHwgaW50IHh0X3RhcmdldF9wYXJzZShpbnQgYywgY2hhciAqKmFyZ3Ys
IGludCBpbnZlcnQsIHVuc2lnbmVkIGludCAqZmxhZ3MsCiAgICAgIHwgICAgIF5+fn5+fn5+fn5+
fn5+fgotLS0KIHVuaXQvdGVzdC1pcHRhYmxlcy5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3VuaXQvdGVzdC1p
cHRhYmxlcy5jIGIvdW5pdC90ZXN0LWlwdGFibGVzLmMKaW5kZXggY2QyNjFkMDU0MTMyLi5mMDg3
MzZlYTVmMGUgMTAwNjQ0Ci0tLSBhL3VuaXQvdGVzdC1pcHRhYmxlcy5jCisrKyBiL3VuaXQvdGVz
dC1pcHRhYmxlcy5jCkBAIC02OSwxMyArNjksMTMgQEAgc3RhdGljIHZvaWQgc2V0X3Rlc3RfY29u
ZmlnKGVudW0gY29uZmlndHlwZSB0eXBlKQogI2RlZmluZSBJUDZUX1NPX0dFVF9JTkZPCQkoSVA2
VF9CQVNFX0NUTCkKICNkZWZpbmUgSVA2VF9TT19HRVRfRU5UUklFUwkJKElQNlRfQkFTRV9DVEwg
KyAxKQogCi1pbnQgeHRfbWF0Y2hfcGFyc2UoaW50IGMsIGNoYXIgKiphcmd2LCBpbnQgaW52ZXJ0
LCB1bnNpZ25lZCBpbnQgKmZsYWdzLAoraW50IHN0YXRpYyB4dF9tYXRjaF9wYXJzZShpbnQgYywg
Y2hhciAqKmFyZ3YsIGludCBpbnZlcnQsIHVuc2lnbmVkIGludCAqZmxhZ3MsCiAJCQljb25zdCB2
b2lkICplbnRyeSwgc3RydWN0IHh0X2VudHJ5X21hdGNoICoqbWF0Y2gpCiB7CiAJcmV0dXJuIDA7
CiB9CiAKLWludCB4dF90YXJnZXRfcGFyc2UoaW50IGMsIGNoYXIgKiphcmd2LCBpbnQgaW52ZXJ0
LCB1bnNpZ25lZCBpbnQgKmZsYWdzLAoraW50IHN0YXRpYyB4dF90YXJnZXRfcGFyc2UoaW50IGMs
IGNoYXIgKiphcmd2LCBpbnQgaW52ZXJ0LCB1bnNpZ25lZCBpbnQgKmZsYWdzLAogCQkJY29uc3Qg
dm9pZCAqZW50cnksIHN0cnVjdCB4dF9lbnRyeV90YXJnZXQgKip0YXJnZXRpbmZvKQogewogCXJl
dHVybiAwOwotLSAKMi4yNS4xCgo=

--_004_MRZP264MB1544E155AD12B597E4474458935E9MRZP264MB1544FRAP_--
