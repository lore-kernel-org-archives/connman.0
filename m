Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90078.outbound.protection.outlook.com [40.107.9.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C42CA3
	for <connman@lists.linux.dev>; Wed, 19 Jan 2022 13:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLyHsmAA/V1r0tn+v3DWdFPZ5JcHs62PGXUzpkmqQs+jckjfc3pgcvoeWJv6Tz7AWKM0yHJv4IMXVMH8OWqAQPxvdiraRk0oygXXvrO/MUimCEQVBI6/uD3hb+jLPPFTaye31SeJr9c6XEIylfhmZ8OcmjH3svTfgxjoM4y1N58WXdCyj96wf0GYexZ9KSgqnqBEvO3xXGCkb3IxOESQkEXhV9UzJJY/WovOyATuDrFowqdRIs/sID8eMFf1iOYeN3ibhvW3W7RiwMPNGW6mkWBDtunJgw9PIbU8iAw6Mm4wM2juXR0IgP2DQNjl4I5wJu95/nsXe3D10iVzr5l6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to3axfKiHWxS2WhYCBgNRA6YWT/lwgDnKcmjgxf2kkU=;
 b=fGaKshjNSfr+dZV248cxGAcFg7tmV9uXqvdvhzP0+fR+y3mQ8ZRdyovt+BZB6RyDv3H/HBmMqNHYvYnt2ApYGrMvHK2LJ+RwQ8bxQdtg44hGpXjRJ0YdDZL/g0MyTA2FMOsX/w5tWZiok999baAWku73V4II7bokiaP0I5MnQUHsKoKy/3AxtXTD7U/Wo6ZNeP1FLrT9IfxpEHI2YT/WtRIunBTfmbbn77pTGqaW2Fq3vpCJ2Nq2V0o7vB8MRHJr6sA5vobpRVrCk+fH0wHw2kMiEiRGCpQ8E0KHGx1CLgeWwFGhUkoDP+HIOA4dj6eVbq4QKAg0BJia736mYfRq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to3axfKiHWxS2WhYCBgNRA6YWT/lwgDnKcmjgxf2kkU=;
 b=gVRtddGsryqHty4xYpFKgaKrWSBZ6uJVK0rN1hLe8ursR/L23s/QSWy8jZ/+rA0bRZV8l42dKVUu5+O5OKqgOa6M1MvMIDby3vXbb1OsU+ExO9k0OzUjUXqnOqMLltKUzA4XLs5oqTzATYnBKhhppa4nQ9mlpj2VcqRyj7mzdGk=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR2P264MB0351.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Wed, 19 Jan 2022 13:43:34 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%3]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 13:43:34 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Always disconnect connection completely
Thread-Topic: [PATCH] iwd: Always disconnect connection completely
Thread-Index: AQHYDToIeiDoGCT3CUepeyAMsEYbTKxqWabq
Date: Wed, 19 Jan 2022 13:43:34 +0000
Message-ID:
 <MRZP264MB15449D2CB5CB2656550C629A93599@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220119133927.1245607-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220119133927.1245607-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 7280116d-b72d-4619-122c-bd3bed5a89b5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20cfc4f1-d2b4-49aa-3937-08d9db51b05a
x-ms-traffictypediagnostic: PR2P264MB0351:EE_
x-microsoft-antispam-prvs:
 <PR2P264MB035144DBEDB25608993085D093599@PR2P264MB0351.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 no453IFWB0s4huWHd8mxDc9Lk9V67+p4nogQeRqm/qCPJq+9YZCmU+8THgrP8sH2IDWeKxYl1kKTO8F6oFII5as16+Twqqwec9xa9AFaI5hf+Wy9PptGsqVqDvSUlaw9CHDKmVul/2L18KBSYczovJm+P4jdOKyClt0ZrGuO1k4DP/LXhvFHfWn757QfzbpBWtqHW/e4FPyEcEarc+yQ6s5qimQM8ptYXsMCC+I1KnBrwTJ2IOS+kCerFgY2q8QA/Y6BaPKI+/8xaBJxJNVdw/u1E+Vg/pd9RD5rGdTzi5JXffY6e3D/2pIEzanimBZu+BrS6fuwMLQwp6yDYZ6IoovaUGbodQdWlC2baF+yEfm8otlqUTbp95rF91WSrohCvm7+X9wA3LoM+qd31jLsh6/JUxvkZn0eCI9gmi0RR9V7r/vsKbF48cTeOZ6AQ38IKJbnrkeJyspUhkDCyeC+20DzlApjtF56zvEBIRHnpwImV6zE2ZZ0gfNNsQ8BCB7R+3zzUtifzVEVtcPP9Kve8dYRYOnb4BXAmh1J5rkQa/2rnPc38XhrNIydX8uKouwBXBup5vuxNdRn2TxkJ9A9BzLvcVDQtC/q+aGBeMl/sHp71xEYY4qvD9SAoxeSab5RiAbN+LMS/yd1uphv/zh+LJarxLDlSVH3xuqDLlP5YjF1V7abJM4edRHP79AKa9tOpRIL9/mjx0K/e6237b+3bw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(508600001)(8936002)(38070700005)(66446008)(122000001)(66946007)(64756008)(76116006)(91956017)(66476007)(66556008)(83380400001)(186003)(55016003)(52536014)(26005)(5660300002)(86362001)(99936003)(2906002)(6506007)(7696005)(71200400001)(33656002)(9686003)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BxErLLR67n8DuJtvDa75164CQ9EqPUR9lNtlgJQEGHj0BBBA3prG26vkCC?=
 =?iso-8859-1?Q?/YhMVmwB9VGM8Rourq/5M6qJ6k/P/GrxFArezxERbZtnDEqVWoY2mmACJt?=
 =?iso-8859-1?Q?QXnb9RpPXWMlNXqLWc0Nvg4gdksC0fsqwL4ST/krFtbSRLB7Af8aVsLejn?=
 =?iso-8859-1?Q?pVjQUMeUgG5RBEHro8Xy+hPV9OKJlWzthLS0Ygpp5WH1KxR/bRgmPQhdwb?=
 =?iso-8859-1?Q?gtreL9YUdvYB3u2GzKxlXQkB+sVVq8zobuGIhqohrIN7KFAot/7QaGvCK9?=
 =?iso-8859-1?Q?p6rTUEkfnosT8YLZ3rYchHmbffD8/Ub7Yr1PB3AFbKCAGyKO5T8pFAtbjs?=
 =?iso-8859-1?Q?JwFcJrBk01rGHgS7dB9Lufo2JqB+qUg8mODdPHzXQnBcVzp+xSCmyenBgU?=
 =?iso-8859-1?Q?dM2y4qfRZM4kdeHhxy55vrySyyy4ftbrwyASq+9i0nwCg2DdG6L6oplesl?=
 =?iso-8859-1?Q?KYXCRSUFi1Gns2jQyt0XQ7ul0LWBtz0sBfLmFbwTWvVMir/f9udGBYkfJr?=
 =?iso-8859-1?Q?4WaM/YVJyxkDvc1kVnzFUYzZR6CLlrl9RzH4NdGyMqpbKLL4hVamGhshrn?=
 =?iso-8859-1?Q?AVjeEF9oT2XBiQ7Y1wsZEpz7F1cRZ01SLl3lDIjRip1f5YfTPejGhs989d?=
 =?iso-8859-1?Q?wPZzR/CE9ZRj1CPIQ2QJa84eHqf2r5dX+bxGEgmIM9AswlxkSmuxS/lUUr?=
 =?iso-8859-1?Q?73lBkiFk0Iofw2mvyH6bVQQNuYtAzGK0WjgsRm6yifQQUdWZNHkzlcHvOM?=
 =?iso-8859-1?Q?y96NuUXfach+UzoUvv1axC8JECP4mzuAeReCDzDYJ+0mJLB7AVbQfjiUt9?=
 =?iso-8859-1?Q?YeSbQu6c8IVwj725sdwe1Hnz49HF36u0lMEaaXyNtuurxjq91O4Bgwn3p9?=
 =?iso-8859-1?Q?ksgXG/54JlWwuTP9Ch6ET16CcYiL9araiIXsPFUcloVK83bW76VSWGkau9?=
 =?iso-8859-1?Q?XeT7lFyoteTj/OXFGsd5JZovtqibFmZRI6hmwNQipwkdSEBHNQStVsZ1YP?=
 =?iso-8859-1?Q?1fy2WGvikBeH57sjptIblywLOnC5+Z3kgHGRFV4vIrvHug+XCFymHZybMr?=
 =?iso-8859-1?Q?rB2x/KRXNmaCs5WUK8Ew8GBj2XVyOnYAxt6yqfDpiCSnSFFq0HkOlOflt4?=
 =?iso-8859-1?Q?r/Ab1FF9yGhem8uOzwVrMSs1onbvyo2XDxEn+eQAxXPs+5woCy/mCCMGlb?=
 =?iso-8859-1?Q?r75yl53PjeEuDMmQXS1jMQVRlTvZyzfYK3FejyhmDictaG50/PlOhlfxYz?=
 =?iso-8859-1?Q?cppRh0cYFnDbCStyW++ztxRNvB5YMmq9sKiAfOPjnlxEGInuhAyN0anFv/?=
 =?iso-8859-1?Q?at9eyMDpdr+Jtgd9GD3wCI2b5cCvaaAeqbmDz86U3LQzqAgf+cqOCzGc0M?=
 =?iso-8859-1?Q?ZJzlLX8n+C13wOcctA4vQAGpI6DhQjdaZqOdNxRLpw7GZwb+W94n0wtBAk?=
 =?iso-8859-1?Q?cZU6cytC6kGY6X3PUH7YrhSOup7vvC+WqqQapHjGqbMQ0ODac/ySTWDyj9?=
 =?iso-8859-1?Q?/11PDemrRcZb4tKjYbNPa6tgh1gEcDbQ9rGikIUtFrcPZlEKwQ5kLIC2Xi?=
 =?iso-8859-1?Q?3t2uR5A6bfEGgyuhaEYAqyoTXrVjFrwNhtMZ2Q757tN5cx7zu4kgQUIPi/?=
 =?iso-8859-1?Q?0M/xudvVYPpsV0o4oVyNfztNCEEQd8kmRlhT2NkxX+X//xV0xRK/57skVk?=
 =?iso-8859-1?Q?Es3CfyY1aAt7LdFTTxqdbXJa9cXT4J992kpbifJi/ASNYvNsAjjxLOJPrv?=
 =?iso-8859-1?Q?4DcA=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB15449D2CB5CB2656550C629A93599MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cfc4f1-d2b4-49aa-3937-08d9db51b05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 13:43:34.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDBbOEPvuCJy9DsZszsGyeRBKCwspAw7RyuFOUvZZD3Wje6DUGsAqL00fI6qolCpNr3uBYB+1Cl5NR/JWVxRPK//37MHSQ+1D4pJe8wsCuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2P264MB0351

--_002_MRZP264MB15449D2CB5CB2656550C629A93599MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Before being able to connect to a new network, finish disconnecting=0A=
the old connection. The network can change while the=0A=
cm_network_disconnect_cb is scheduled.=0A=
=0A=
Commit 024309a9e04a ("wifi: Reset disconnecting status of any network")=0A=
Commit 795883e98eba ("wifi: Check valid network in disconnect callback")=0A=
Commit dd86f09107e8 ("wifi: Always disconnect connection completely")=0A=
---=0A=
=A0plugins/iwd.c | 114 ++++++++++++++++++++++++++++++++++++++++++++------=
=0A=
=A01 file changed, 102 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index b0e17a4d6396..48f1f7136e24 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -82,6 +82,10 @@ struct iwd_device {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 char *mode;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct connman_device *device;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 char *network;=0A=
+=A0=A0=A0=A0=A0=A0 char *pending_network;=0A=
+=A0=A0=A0=A0=A0=A0 bool disconnecting;=0A=
=A0};=0A=
=A0=0A=
=A0struct iwd_network {=0A=
@@ -219,12 +223,6 @@ static void update_network_connected(struct iwd_networ=
k *iwdn)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 connman_network_set_connected(iwdn->network, true)=
;=0A=
=A0}=0A=
=A0=0A=
-static void update_network_disconnected(struct iwd_network *iwdn)=0A=
-{=0A=
-=A0=A0=A0=A0=A0=A0 DBG("interface name %s", iwdn->name);=0A=
-=A0=A0=A0=A0=A0=A0 connman_network_set_connected(iwdn->network, false);=0A=
-}=0A=
-=0A=
=A0static void cm_network_connect_cb(DBusMessage *message, void *user_data)=
=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 const char *path =3D user_data;=0A=
@@ -253,21 +251,93 @@ static void cm_network_connect_cb(DBusMessage *messag=
e, void *user_data)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 update_network_connected(iwdn);=0A=
=A0}=0A=
=A0=0A=
+void abort_pending_network(struct iwd_device *iwdd,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 enum connman_network_error error) {=0A=
+=A0=A0=A0=A0=A0=A0 struct iwd_network *iwdn;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (!iwdd->pending_network)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 iwdn =3D g_hash_table_lookup(networks, iwdd->pending_ne=
twork);=0A=
+=A0=A0=A0=A0=A0=A0 if (iwdn)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 connman_network_set_error(iwdn-=
>network, error);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->pending_network);=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->pending_network =3D NULL;=0A=
+}=0A=
+=0A=
=A0static int cm_network_connect(struct connman_network *network)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iwd_network *iwdn =3D connman_network_get_d=
ata(network);=0A=
+=A0=A0=A0=A0=A0=A0 struct iwd_device *iwdd;=0A=
+=A0=A0=A0=A0=A0=A0 int err;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 if (!iwdn)=0A=
+=A0=A0=A0=A0=A0=A0 if (!iwdn || !iwdn->iwdd)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 iwdd =3D iwdn->iwdd;=0A=
+=A0=A0=A0=A0=A0=A0 if (iwdd->disconnecting) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (g_strcmp0(iwdn->path, iwdd-=
>pending_network)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort_p=
ending_network(iwdd,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CONNMAN_NETWORK_ERROR_CONNECT_FA=
IL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iwdd->p=
ending_network =3D g_strdup(iwdn->path);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINPROGRESS;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!g_dbus_proxy_method_call(iwdn->proxy, "Connec=
t",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NU=
LL, cm_network_connect_cb,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g_strdu=
p(iwdn->path), g_free))=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g_strdu=
p(iwdn->path), g_free)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D -EIO;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 connman_network_set_associating(iwdn->network, tru=
e);=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 return -EINPROGRESS;=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->network);=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->network =3D g_strdup(iwdn->path);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 err =3D -EINPROGRESS;=0A=
+=0A=
+out:=0A=
+=A0=A0=A0=A0=A0=A0 abort_pending_network(iwdd, CONNMAN_NETWORK_ERROR_UNKNO=
WN);=0A=
+=A0=A0=A0=A0=A0=A0 return err;=0A=
+}=0A=
+=0A=
+static void update_network_disconnected(struct iwd_network *iwdn)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct iwd_device *iwdd;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (!iwdn || !iwdn->iwdd)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 iwdd =3D iwdn->iwdd;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 DBG("interface name %s", iwdn->name);=0A=
+=A0=A0=A0=A0=A0=A0 connman_network_set_connected(iwdn->network, false);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->disconnecting =3D false;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (g_strcmp0(iwdn->path, iwdd->network)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!g_strcmp0(iwdn->path, iwdd=
->pending_network)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort_p=
ending_network(iwdd,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CONNMAN_NETWORK_ERROR_CONNECT_FA=
IL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DBG("current wifi network has c=
hanged since disconnection");=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->network);=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->network =3D NULL;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (iwdd->pending_network) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iwd_network *iwdn_pendin=
g =3D=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g_hash_=
table_lookup(networks, iwdd->pending_network);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!iwdn_pending)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cm_network_connect(iwdn_pending=
->network);=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=A0}=0A=
=A0=0A=
=A0static void cm_network_disconnect_cb(DBusMessage *message, void *user_da=
ta)=0A=
@@ -279,6 +349,9 @@ static void cm_network_disconnect_cb(DBusMessage *messa=
ge, void *user_data)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!iwdn)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 if(iwdn->iwdd)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iwdn->iwdd->disconnecting =3D f=
alse;=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (dbus_message_get_type(message) =3D=3D DBUS_MES=
SAGE_TYPE_ERROR) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const char *dbus_error =3D=
 dbus_message_get_error_name(message);=0A=
=A0=0A=
@@ -303,11 +376,16 @@ static int cm_network_disconnect(struct connman_netwo=
rk *network)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iwd_network *iwdn =3D connman_network_get_d=
ata(network);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iwd_station *iwds;=0A=
+=A0=A0=A0=A0=A0=A0 struct iwd_device *iwdd;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 if (!iwdn && !iwdn->iwdd)=0A=
+=A0=A0=A0=A0=A0=A0 if (!iwdn || !iwdn->iwdd)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 iwds =3D g_hash_table_lookup(stations, iwdn->iwdd->path=
);=0A=
+=A0=A0=A0=A0=A0=A0 iwdd =3D iwdn->iwdd;=0A=
+=A0=A0=A0=A0=A0=A0 if (iwdd->disconnecting)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EALREADY;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 iwds =3D g_hash_table_lookup(stations, iwdd->path);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!iwds)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;=0A=
=A0=0A=
@@ -317,6 +395,8 @@ static int cm_network_disconnect(struct connman_network=
 *network)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NU=
LL, cm_network_disconnect_cb, g_strdup(iwdn->path), g_free))=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->disconnecting =3D true;=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=A0}=0A=
=A0=0A=
@@ -515,6 +595,12 @@ static void device_powered_cb(const DBusError *error, =
void *user_data)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 connman_device_set_powered(iwdd->device, cbd->powe=
red);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if(!cbd->powered) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort_pending_network(iwdd,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CONNMAN_NETWORK_ERROR_CONNECT_FA=
IL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iwdd->disconnecting =3D false;=
=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=A0out:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(cbd->path);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(cbd);=0A=
@@ -1307,6 +1393,10 @@ static void device_free(gpointer data)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(iwdd->adapter);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(iwdd->name);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(iwdd->address);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->network);=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->pending_network);=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(iwdd);=0A=
=A0}=0A=
=A0=0A=
-- =0A=
2.25.1=0A=
=0A=
Hi,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=0A=

--_002_MRZP264MB15449D2CB5CB2656550C629A93599MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-iwd-Always-disconnect-connection-completely.patch"
Content-Description: 0001-iwd-Always-disconnect-connection-completely.patch
Content-Disposition: attachment;
	filename="0001-iwd-Always-disconnect-connection-completely.patch"; size=5426;
	creation-date="Wed, 19 Jan 2022 13:41:47 GMT";
	modification-date="Wed, 19 Jan 2022 13:41:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjM2QzNjI2MmRiMTEzYWJiOTk2N2YyOTk4ZjdiYTBmN2Y5ZDQ2ODUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFdlZCwgMTkgSmFuIDIwMjIgMTA6Mzg6MDcgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBpd2Q6IEFsd2F5cyBkaXNjb25uZWN0IGNvbm5lY3Rpb24gY29tcGxldGVseQoK
QmVmb3JlIGJlaW5nIGFibGUgdG8gY29ubmVjdCB0byBhIG5ldyBuZXR3b3JrLCBmaW5pc2ggZGlz
Y29ubmVjdGluZwp0aGUgb2xkIGNvbm5lY3Rpb24uIFRoZSBuZXR3b3JrIGNhbiBjaGFuZ2Ugd2hp
bGUgdGhlCmNtX25ldHdvcmtfZGlzY29ubmVjdF9jYiBpcyBzY2hlZHVsZWQuCgpDb21taXQgMDI0
MzA5YTllMDRhICgid2lmaTogUmVzZXQgZGlzY29ubmVjdGluZyBzdGF0dXMgb2YgYW55IG5ldHdv
cmsiKQpDb21taXQgNzk1ODgzZTk4ZWJhICgid2lmaTogQ2hlY2sgdmFsaWQgbmV0d29yayBpbiBk
aXNjb25uZWN0IGNhbGxiYWNrIikKQ29tbWl0IGRkODZmMDkxMDdlOCAoIndpZmk6IEFsd2F5cyBk
aXNjb25uZWN0IGNvbm5lY3Rpb24gY29tcGxldGVseSIpCi0tLQogcGx1Z2lucy9pd2QuYyB8IDEx
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDEwMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9wbHVnaW5zL2l3ZC5jIGIvcGx1Z2lucy9pd2QuYwppbmRleCBiMGUxN2E0ZDYzOTYuLjQ4
ZjFmNzEzNmUyNCAxMDA2NDQKLS0tIGEvcGx1Z2lucy9pd2QuYworKysgYi9wbHVnaW5zL2l3ZC5j
CkBAIC04Miw2ICs4MiwxMCBAQCBzdHJ1Y3QgaXdkX2RldmljZSB7CiAJY2hhciAqbW9kZTsKIAog
CXN0cnVjdCBjb25ubWFuX2RldmljZSAqZGV2aWNlOworCisJY2hhciAqbmV0d29yazsKKwljaGFy
ICpwZW5kaW5nX25ldHdvcms7CisJYm9vbCBkaXNjb25uZWN0aW5nOwogfTsKIAogc3RydWN0IGl3
ZF9uZXR3b3JrIHsKQEAgLTIxOSwxMiArMjIzLDYgQEAgc3RhdGljIHZvaWQgdXBkYXRlX25ldHdv
cmtfY29ubmVjdGVkKHN0cnVjdCBpd2RfbmV0d29yayAqaXdkbikKIAljb25ubWFuX25ldHdvcmtf
c2V0X2Nvbm5lY3RlZChpd2RuLT5uZXR3b3JrLCB0cnVlKTsKIH0KIAotc3RhdGljIHZvaWQgdXBk
YXRlX25ldHdvcmtfZGlzY29ubmVjdGVkKHN0cnVjdCBpd2RfbmV0d29yayAqaXdkbikKLXsKLQlE
QkcoImludGVyZmFjZSBuYW1lICVzIiwgaXdkbi0+bmFtZSk7Ci0JY29ubm1hbl9uZXR3b3JrX3Nl
dF9jb25uZWN0ZWQoaXdkbi0+bmV0d29yaywgZmFsc2UpOwotfQotCiBzdGF0aWMgdm9pZCBjbV9u
ZXR3b3JrX2Nvbm5lY3RfY2IoREJ1c01lc3NhZ2UgKm1lc3NhZ2UsIHZvaWQgKnVzZXJfZGF0YSkK
IHsKIAljb25zdCBjaGFyICpwYXRoID0gdXNlcl9kYXRhOwpAQCAtMjUzLDIxICsyNTEsOTMgQEAg
c3RhdGljIHZvaWQgY21fbmV0d29ya19jb25uZWN0X2NiKERCdXNNZXNzYWdlICptZXNzYWdlLCB2
b2lkICp1c2VyX2RhdGEpCiAJdXBkYXRlX25ldHdvcmtfY29ubmVjdGVkKGl3ZG4pOwogfQogCit2
b2lkIGFib3J0X3BlbmRpbmdfbmV0d29yayhzdHJ1Y3QgaXdkX2RldmljZSAqaXdkZCwKKwkJCQll
bnVtIGNvbm5tYW5fbmV0d29ya19lcnJvciBlcnJvcikgeworCXN0cnVjdCBpd2RfbmV0d29yayAq
aXdkbjsKKworCWlmICghaXdkZC0+cGVuZGluZ19uZXR3b3JrKQorCQlyZXR1cm47CisKKwlpd2Ru
ID0gZ19oYXNoX3RhYmxlX2xvb2t1cChuZXR3b3JrcywgaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsK
KwlpZiAoaXdkbikKKwkJY29ubm1hbl9uZXR3b3JrX3NldF9lcnJvcihpd2RuLT5uZXR3b3JrLCBl
cnJvcik7CisKKwlnX2ZyZWUoaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsKKwlpd2RkLT5wZW5kaW5n
X25ldHdvcmsgPSBOVUxMOworfQorCiBzdGF0aWMgaW50IGNtX25ldHdvcmtfY29ubmVjdChzdHJ1
Y3QgY29ubm1hbl9uZXR3b3JrICpuZXR3b3JrKQogewogCXN0cnVjdCBpd2RfbmV0d29yayAqaXdk
biA9IGNvbm5tYW5fbmV0d29ya19nZXRfZGF0YShuZXR3b3JrKTsKKwlzdHJ1Y3QgaXdkX2Rldmlj
ZSAqaXdkZDsKKwlpbnQgZXJyOwogCi0JaWYgKCFpd2RuKQorCWlmICghaXdkbiB8fCAhaXdkbi0+
aXdkZCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwlpd2RkID0gaXdkbi0+aXdkZDsKKwlpZiAoaXdk
ZC0+ZGlzY29ubmVjdGluZykgeworCQlpZiAoZ19zdHJjbXAwKGl3ZG4tPnBhdGgsIGl3ZGQtPnBl
bmRpbmdfbmV0d29yaykpIHsKKwkJCWFib3J0X3BlbmRpbmdfbmV0d29yayhpd2RkLAorCQkJCQlD
T05OTUFOX05FVFdPUktfRVJST1JfQ09OTkVDVF9GQUlMKTsKKwkJCWl3ZGQtPnBlbmRpbmdfbmV0
d29yayA9IGdfc3RyZHVwKGl3ZG4tPnBhdGgpOworCQl9CisJCXJldHVybiAtRUlOUFJPR1JFU1M7
CisJfQorCiAJaWYgKCFnX2RidXNfcHJveHlfbWV0aG9kX2NhbGwoaXdkbi0+cHJveHksICJDb25u
ZWN0IiwKIAkJCU5VTEwsIGNtX25ldHdvcmtfY29ubmVjdF9jYiwKLQkJCWdfc3RyZHVwKGl3ZG4t
PnBhdGgpLCBnX2ZyZWUpKQotCQlyZXR1cm4gLUVJTzsKKwkJCWdfc3RyZHVwKGl3ZG4tPnBhdGgp
LCBnX2ZyZWUpKSB7CisJCWVyciA9IC1FSU87CisJCWdvdG8gb3V0OworCX0KIAogCWNvbm5tYW5f
bmV0d29ya19zZXRfYXNzb2NpYXRpbmcoaXdkbi0+bmV0d29yaywgdHJ1ZSk7CiAKLQlyZXR1cm4g
LUVJTlBST0dSRVNTOworCWdfZnJlZShpd2RkLT5uZXR3b3JrKTsKKwlpd2RkLT5uZXR3b3JrID0g
Z19zdHJkdXAoaXdkbi0+cGF0aCk7CisKKwllcnIgPSAtRUlOUFJPR1JFU1M7CisKK291dDoKKwlh
Ym9ydF9wZW5kaW5nX25ldHdvcmsoaXdkZCwgQ09OTk1BTl9ORVRXT1JLX0VSUk9SX1VOS05PV04p
OworCXJldHVybiBlcnI7Cit9CisKK3N0YXRpYyB2b2lkIHVwZGF0ZV9uZXR3b3JrX2Rpc2Nvbm5l
Y3RlZChzdHJ1Y3QgaXdkX25ldHdvcmsgKml3ZG4pCit7CisJc3RydWN0IGl3ZF9kZXZpY2UgKml3
ZGQ7CisKKwlpZiAoIWl3ZG4gfHwgIWl3ZG4tPml3ZGQpCisJCXJldHVybjsKKworCWl3ZGQgPSBp
d2RuLT5pd2RkOworCisJREJHKCJpbnRlcmZhY2UgbmFtZSAlcyIsIGl3ZG4tPm5hbWUpOworCWNv
bm5tYW5fbmV0d29ya19zZXRfY29ubmVjdGVkKGl3ZG4tPm5ldHdvcmssIGZhbHNlKTsKKworCWl3
ZGQtPmRpc2Nvbm5lY3RpbmcgPSBmYWxzZTsKKworCWlmIChnX3N0cmNtcDAoaXdkbi0+cGF0aCwg
aXdkZC0+bmV0d29yaykpIHsKKwkJaWYgKCFnX3N0cmNtcDAoaXdkbi0+cGF0aCwgaXdkZC0+cGVu
ZGluZ19uZXR3b3JrKSkgeworCQkJYWJvcnRfcGVuZGluZ19uZXR3b3JrKGl3ZGQsCisJCQkJCUNP
Tk5NQU5fTkVUV09SS19FUlJPUl9DT05ORUNUX0ZBSUwpOworCQl9CisJCURCRygiY3VycmVudCB3
aWZpIG5ldHdvcmsgaGFzIGNoYW5nZWQgc2luY2UgZGlzY29ubmVjdGlvbiIpOworCQlyZXR1cm47
CisJfQorCisJZ19mcmVlKGl3ZGQtPm5ldHdvcmspOworCWl3ZGQtPm5ldHdvcmsgPSBOVUxMOwor
CisJaWYgKGl3ZGQtPnBlbmRpbmdfbmV0d29yaykgeworCQlzdHJ1Y3QgaXdkX25ldHdvcmsgKml3
ZG5fcGVuZGluZyA9CisJCQlnX2hhc2hfdGFibGVfbG9va3VwKG5ldHdvcmtzLCBpd2RkLT5wZW5k
aW5nX25ldHdvcmspOworCQlpZiAoIWl3ZG5fcGVuZGluZykKKwkJCXJldHVybjsKKworCQljbV9u
ZXR3b3JrX2Nvbm5lY3QoaXdkbl9wZW5kaW5nLT5uZXR3b3JrKTsKKwl9CiB9CiAKIHN0YXRpYyB2
b2lkIGNtX25ldHdvcmtfZGlzY29ubmVjdF9jYihEQnVzTWVzc2FnZSAqbWVzc2FnZSwgdm9pZCAq
dXNlcl9kYXRhKQpAQCAtMjc5LDYgKzM0OSw5IEBAIHN0YXRpYyB2b2lkIGNtX25ldHdvcmtfZGlz
Y29ubmVjdF9jYihEQnVzTWVzc2FnZSAqbWVzc2FnZSwgdm9pZCAqdXNlcl9kYXRhKQogCWlmICgh
aXdkbikKIAkJcmV0dXJuOwogCisJaWYoaXdkbi0+aXdkZCkKKwkJaXdkbi0+aXdkZC0+ZGlzY29u
bmVjdGluZyA9IGZhbHNlOworCiAJaWYgKGRidXNfbWVzc2FnZV9nZXRfdHlwZShtZXNzYWdlKSA9
PSBEQlVTX01FU1NBR0VfVFlQRV9FUlJPUikgewogCQljb25zdCBjaGFyICpkYnVzX2Vycm9yID0g
ZGJ1c19tZXNzYWdlX2dldF9lcnJvcl9uYW1lKG1lc3NhZ2UpOwogCkBAIC0zMDMsMTEgKzM3Niwx
NiBAQCBzdGF0aWMgaW50IGNtX25ldHdvcmtfZGlzY29ubmVjdChzdHJ1Y3QgY29ubm1hbl9uZXR3
b3JrICpuZXR3b3JrKQogewogCXN0cnVjdCBpd2RfbmV0d29yayAqaXdkbiA9IGNvbm5tYW5fbmV0
d29ya19nZXRfZGF0YShuZXR3b3JrKTsKIAlzdHJ1Y3QgaXdkX3N0YXRpb24gKml3ZHM7CisJc3Ry
dWN0IGl3ZF9kZXZpY2UgKml3ZGQ7CiAKLQlpZiAoIWl3ZG4gJiYgIWl3ZG4tPml3ZGQpCisJaWYg
KCFpd2RuIHx8ICFpd2RuLT5pd2RkKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCWl3ZHMgPSBnX2hh
c2hfdGFibGVfbG9va3VwKHN0YXRpb25zLCBpd2RuLT5pd2RkLT5wYXRoKTsKKwlpd2RkID0gaXdk
bi0+aXdkZDsKKwlpZiAoaXdkZC0+ZGlzY29ubmVjdGluZykKKwkJcmV0dXJuIC1FQUxSRUFEWTsK
KworCWl3ZHMgPSBnX2hhc2hfdGFibGVfbG9va3VwKHN0YXRpb25zLCBpd2RkLT5wYXRoKTsKIAlp
ZiAoIWl3ZHMpCiAJCXJldHVybiAtRUlPOwogCkBAIC0zMTcsNiArMzk1LDggQEAgc3RhdGljIGlu
dCBjbV9uZXR3b3JrX2Rpc2Nvbm5lY3Qoc3RydWN0IGNvbm5tYW5fbmV0d29yayAqbmV0d29yaykK
IAkJCU5VTEwsIGNtX25ldHdvcmtfZGlzY29ubmVjdF9jYiwgZ19zdHJkdXAoaXdkbi0+cGF0aCks
IGdfZnJlZSkpCiAJCXJldHVybiAtRUlPOwogCisJaXdkZC0+ZGlzY29ubmVjdGluZyA9IHRydWU7
CisKIAlyZXR1cm4gMDsKIH0KIApAQCAtNTE1LDYgKzU5NSwxMiBAQCBzdGF0aWMgdm9pZCBkZXZp
Y2VfcG93ZXJlZF9jYihjb25zdCBEQnVzRXJyb3IgKmVycm9yLCB2b2lkICp1c2VyX2RhdGEpCiAJ
fQogCiAJY29ubm1hbl9kZXZpY2Vfc2V0X3Bvd2VyZWQoaXdkZC0+ZGV2aWNlLCBjYmQtPnBvd2Vy
ZWQpOworCisJaWYoIWNiZC0+cG93ZXJlZCkgeworCQlhYm9ydF9wZW5kaW5nX25ldHdvcmsoaXdk
ZCwKKwkJCQkJQ09OTk1BTl9ORVRXT1JLX0VSUk9SX0NPTk5FQ1RfRkFJTCk7CisJCWl3ZGQtPmRp
c2Nvbm5lY3RpbmcgPSBmYWxzZTsKKwl9CiBvdXQ6CiAJZ19mcmVlKGNiZC0+cGF0aCk7CiAJZ19m
cmVlKGNiZCk7CkBAIC0xMzA3LDYgKzEzOTMsMTAgQEAgc3RhdGljIHZvaWQgZGV2aWNlX2ZyZWUo
Z3BvaW50ZXIgZGF0YSkKIAlnX2ZyZWUoaXdkZC0+YWRhcHRlcik7CiAJZ19mcmVlKGl3ZGQtPm5h
bWUpOwogCWdfZnJlZShpd2RkLT5hZGRyZXNzKTsKKworCWdfZnJlZShpd2RkLT5uZXR3b3JrKTsK
KwlnX2ZyZWUoaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsKKwogCWdfZnJlZShpd2RkKTsKIH0KIAot
LSAKMi4yNS4xCgo=

--_002_MRZP264MB15449D2CB5CB2656550C629A93599MRZP264MB1544FRAP_--
