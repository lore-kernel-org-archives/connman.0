Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C12FB8
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 13:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyY0i7IBY/FVo599kQl3IuqBTLaUUfXfH9/DYIDQadbM70uppAXkEvf6Kf39Wk4iSjn+ke1FEhvoSBMzyY/fOhXyHGX4VvBgYJK7vVKygCmN4cmy9/rUkNrhP03PPToFtkDMK9oBYiaSdyuOJxyQB9MRcFp8lPtR8og60xTg7fmTOIfl8a0hgPdJhvonm1UFPSuMUmIDLKHNtLSY730lJYKunF1iaoKRQ+8Fm5aiS206NI6vsRJ/XnB428tkAgQLNxJ2syvmh6l9mxPJyDt+jYUs1UdxTMV93ia8Nn4PofyKJ9suRiy1ixMrnaKBQmMUPqOSEOIx0KfAD0TlZdLA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae2GVrusQ3DhMy9SxWJb4+MCGq9gtOXAJ0fapkVJTfk=;
 b=MRVQW6Af+exxwHLQUG8b34RkzB4Tv4rz2Pc+fumivkSdvB7RAg/3YYpROR2g8hBST1BjIyXM35fPAE3vr9fENodIYdEUAsiwcVHW11NC9OV+7qmbveey1JxZ9NknVvRJoPU46YKsUXtPXZ5KfNe8g+XIg2peO9PQKKPaZR7K2WJTyyaJ/cdko6SWr08ao2hPa/pmlH21x+CcYOKf1rQYp3fvQUMP5Pp1kLgd2nDpBNA9Sn5rWCPAwVwSbZ6d42ZpozP9PcRgkCiq752PhtAVybRUKiUcXTX18O2OB0CXxF79r0gf7skptjNk9xKA7iszGJFmJ2sTPsZ6e+6VYJRreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae2GVrusQ3DhMy9SxWJb4+MCGq9gtOXAJ0fapkVJTfk=;
 b=HIitHfLXeWb1/1BPuHNLdiGyPJYUdBL5+AI5LgcE8GYvx6b2fEg76PPbU4iP5kRwTOkqy+55xiiKQmcgEpVsRZXLRQNJhp+GK5vikYn8Nf8Kzaou955IjZVSifOxXZaDukkRdm+UQOf1tS+RTBRp5atQhmQyFKc2UecQxd9hDWg=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PA4PR02MB6830.eurprd02.prod.outlook.com (2603:10a6:102:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 13:02:01 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 13:02:01 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] wispr: Add online check url config options
Thread-Topic: [PATCH] wispr: Add online check url config options
Thread-Index: AQHXYeTK6zVrkCfjz0+UXmRbnjdQQKsVCMen
Date: Tue, 15 Jun 2021 13:02:01 +0000
Message-ID:
 <PR1PR02MB4794EE1A5F2F997AF8032BB893309@PR1PR02MB4794.eurprd02.prod.outlook.com>
References:
 <PR1PR02MB479412B2989FCCF93E4AE58F93309@PR1PR02MB4794.eurprd02.prod.outlook.com>
In-Reply-To:
 <PR1PR02MB479412B2989FCCF93E4AE58F93309@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-originating-ip: [194.4.243.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcb0d230-a8bb-4df2-9989-08d92ffdc407
x-ms-traffictypediagnostic: PA4PR02MB6830:
x-microsoft-antispam-prvs:
 <PA4PR02MB68306B870B8E26538165174D93309@PA4PR02MB6830.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q4Z3nPFANJc0Bb4rJosu4pMULIZZqCLiW1VW7wk94xerVohz3Rrp3W3jdlGfwJgHJ4/HWERMK6MnhpLfzpAVX+2Bc/ajvBrSD4z9d2bmWEJQUbyac7RD++Hhch2hnhEtb53UDE/GZdmox9YZ6yBL/XcmEylV/t+8c6um2ycHSbeiS91POZyjktHjM1iLB7+UyKl8MNwupetG+wKTq+uHond2uY9+MYNNYTB6rIfXMnh0QzMeF66jl+HkQMEjyuztnuRWHy1FfmR1Z5KKywuOVbaqreKNEOHTby9MIJtWTJHBuHcE6nTQ9/1MKJMz88XVeFi9aGGZgbdP0gR9RN7BMMBh96cFErAcBJ2w+npaIdcXySl4WvUyoUKzPRfT2TRpox3MieOwZbRmDrEQ1rdy8Y172YUnLHbYfogDfitkBxovIYVQfHN6+ZjXZqE7DGnr4CEBAly6O3I9ZLcbOqthE7TBYHB7Ja3ro7wG6jzsTOeC9XNy1vvDu9Po9Ku8jtPeRG23rP6wmjr8v7ynCMNCiosNF0FdosG8IIPz5rL0eULSp03gZXdMdv8USTghdO6zmHH+my8yaf1w2QSnWmdIVuAtwwWzsEBblAAI4poIOknAjGlTKfksxW1ftJYHtlI+WiTlBGYzqG67iAn1NkQ97emIFAvZVKiPcjNUz3O0XgE9nIqZJG8gan2TQlUm8yaHPioHbO8+K+OZmvNHJdCHDHcLQjYagtFRYMk3xIFIMG8uxfm46ThfYud8EPJknBLs/j+xFQYSMw6EWQSl/EyZHLPtFRhh0oputFnxdXDumxk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(38100700002)(26005)(19627235002)(316002)(7696005)(86362001)(83380400001)(66574015)(5660300002)(52536014)(6916009)(19273905006)(122000001)(66476007)(71200400001)(6506007)(2940100002)(66946007)(33656002)(8676002)(9686003)(2906002)(64756008)(76116006)(55016002)(186003)(66556008)(966005)(66446008)(478600001)(8936002)(562404015)(563064011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xlmWwbNFCnXjjPxrX6g/XHAFxwasyccG+tLvfESmkn+X+bpvGkTPnUN1t7?=
 =?iso-8859-1?Q?eHrv/9DPMauFPf7ji6z/1C96a1wvHwB8bri9Hk+Ntae2XrHZDwkn84n2s+?=
 =?iso-8859-1?Q?lEd/naK/G+suyAOrzAwYsZxWFDEDs2H+Lfry7v7ni8yFk61kbV+2F/HAgN?=
 =?iso-8859-1?Q?ww2wC6+fozaIj2nfi+0DYqvH4MoYYk1C+vnIt3v8bann3oHyaaoOeQ+iua?=
 =?iso-8859-1?Q?ufq14HQ9xXjOimCSZWcctreBb7v2ipBOlKZyUWpTMI04yllh0AMGHLuOK8?=
 =?iso-8859-1?Q?jcJXrnSph3BOfqqDeRpmWTg1gSsKJWeMevEczkl4HQBmbIZTAaAluzVDNa?=
 =?iso-8859-1?Q?gPgRkUWdqR2x14qrEd/62sFhLi65n3L9+99ssLK4EQE7IJBGGNgV/vaJV5?=
 =?iso-8859-1?Q?cW3AKr99ZPUWGf+YID1Oo6sX6NeznjKVuRzM+YjTMh+jYURlokRb6pLYwf?=
 =?iso-8859-1?Q?/QiMXYGu3ROvJ0wtQP3Jf7Ap5VvySVRyd1lVDTboioub2M5o3W7/cKvHQF?=
 =?iso-8859-1?Q?D7aW3tDbIdJKzlpxtnFvIL/U6zch/t42kbm6ER4A8Hj52Z4c9fstvcrM2/?=
 =?iso-8859-1?Q?JQ+B98Hiwflbe97AaNxpiXSpMzXz9T7eU7bk7k6yHWlaKmarLcpIUgSD2n?=
 =?iso-8859-1?Q?VmJRmL7S19WqzKyWTR2dPiEFTk5w1t4v9CJAs+CAZh79nV1/jEJF4wn01f?=
 =?iso-8859-1?Q?2QgBf6txPl58wBbMG7XpD53KF5OZjBLf0BXAvn16C3sbci3X4/MmyAXsDA?=
 =?iso-8859-1?Q?RbGFOMIPXzSDmM2U5Z+q6imMQB8lS7kts5NZgek85qUgwMlGJaABmfzQpP?=
 =?iso-8859-1?Q?QdrLeMVk5NTU1SIhxMg4hu/AfxHkuJPP1Ieasg3iYJcpNfnSRfUSd3YjiY?=
 =?iso-8859-1?Q?6huJ8abZwa+oAQPxxvsLGmSoxlrbAmWjOKQYsdX3lKHFhJ40KndDgkpeSD?=
 =?iso-8859-1?Q?d4fXr25S4IthdXy6oLg7WlWHflFGpF/ldaQaItzbEH+cdjY++bI/P9FDWA?=
 =?iso-8859-1?Q?HjzIJ25mAlXMBf7zlpjUYLUbpp9f1cjkabKrfokjk9h0SIGk9RfjZr0IfA?=
 =?iso-8859-1?Q?TFQWRoMNEg6ruUGcluQqQK+qdPlVwe6QcGdf8j1xoFXuCiQScBP29+heKB?=
 =?iso-8859-1?Q?hcERhkNJOW0vcRUw+zxY2uDqTIKH9mdckhQRIukxQkQkXlDhx8PyfirZmv?=
 =?iso-8859-1?Q?lbxe3eZVRZh3KAgnUkXxezt008xKRc87j4QI6NB7F3w1keNeRRSXhPeu7c?=
 =?iso-8859-1?Q?TOy7O+WTNJ3jBNj9Gwyb4ozLou/juxwjhKQySLRVK6+sd9HnEVvf/SR6SE?=
 =?iso-8859-1?Q?uCV0a5J2Yy0cpz2xTJ5mQfg9A2F3u+o9aDleJ2SJxM//Jqc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4794.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb0d230-a8bb-4df2-9989-08d92ffdc407
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 13:02:01.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taJFl++qMLM1QpbVSQLRYtAn3WgU+8IdITHoYZX7tuW+gwVf0rWzRjBSrXSm6XHkSpRgeN1HO+J4cJ5F9yTE5LTEfqEoFtMpdmkvZQuqoGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6830

Global config options, which allow to set the urls (IPv4 and IPv6=0A=
respectively) used during the online status check.=0A=
Default values are http://ipv4.connman.net/online/status.html and=0A=
http://ipv6.connman.net/online/status.html respectively.=0A=
---=0A=
 README                |  9 +++++++++=0A=
 doc/connman.conf.5.in | 13 ++++++++-----=0A=
 src/main.c            | 33 +++++++++++++++++++++++++++++++++=0A=
 src/main.conf         | 14 +++++++++-----=0A=
 src/wispr.c           | 14 +++++++++-----=0A=
 5 files changed, 68 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/README b/README=0A=
index b8154e67a7ac..16f813928a16 100644=0A=
--- a/README=0A=
+++ b/README=0A=
@@ -408,8 +408,17 @@ from ipv4.connman.net (for IPv4 connectivity) and ipv6=
.connman.net=0A=
 (for IPv6 connectivity). The used URL looks like this=0A=
 http://ipv{4|6}.connman.net/online/status.html=0A=
 =0A=
+When an online check request fails, another one is triggered after a=0A=
+longer interval. The intervals follow the square series of numbers=0A=
+in a specific range, by default [1, 12], corresponding to the following=0A=
+intervals, in seconds: 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121 and 144.=
=0A=
+=0A=
 See connman.conf(5) for the EnableOnlineCheck option, if you need to=0A=
 disable the feature.=0A=
+It is also possible to specify other URLs via OnlineCheckIPv4URL and=0A=
+OnlineCheckIPv6URL options.=0A=
+The range of intervals between two online check requests can be fine-tuned=
=0A=
+via OnlineCheckInitialInterval and OnlineCheckMaxInterval options.=0A=
 =0A=
 During the online check procedure, ConnMan will temporarily install=0A=
 a host route to both the ipv4.connman.net and ipv6.connman.net so that=0A=
diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in=0A=
index 2e06b3ef1f3c..82cceb7298f1 100644=0A=
--- a/doc/connman.conf.5.in=0A=
+++ b/doc/connman.conf.5.in=0A=
@@ -167,13 +167,16 @@ transitioned to ONLINE state.=0A=
 If this setting is false, the default service will remain in READY state.=
=0A=
 Default value is true.=0A=
 .TP=0A=
+.BI OnlineCheckIPv4URL=3D url, OnlineCheckIPv6URL=3D url=0A=
+Urls (IPv4 and IPv6 respectively) used during the online status check.=0A=
+Please refer to the README for more detailed information.=0A=
+Default values are http://ipv4.connman.net/online/status.html and=0A=
+http://ipv6.connman.net/online/status.html respectively.=0A=
+.TP=0A=
 .BI OnlineCheckInitialInterval=3D secs, OnlineCheckMaxInterval=3D secs=0A=
 Range of intervals between two online check requests.=0A=
-When an online check request fails, another one is triggered after a=0A=
-longer interval. The intervals follow the power of two series of numbers=
=0A=
-between OnlineCheckInitialInterval and OnlineCheckMaxInterval.=0A=
-Default range is [1, 12], corresponding to the following intervals, in=0A=
-seconds: 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121 and 144.=0A=
+Please refer to the README for more detailed information.=0A=
+Default values are 1 and 12 respectively.=0A=
 .TP=0A=
 .BI EnableOnlineToReadyTransition=3Dtrue\ \fR|\fB\ false=0A=
 WARNING: Experimental feature!!!=0A=
diff --git a/src/main.c b/src/main.c=0A=
index 6480caa62980..407207fd4947 100644=0A=
--- a/src/main.c=0A=
+++ b/src/main.c=0A=
@@ -44,6 +44,9 @@=0A=
 #define DEFAULT_INPUT_REQUEST_TIMEOUT (120 * 1000)=0A=
 #define DEFAULT_BROWSER_LAUNCH_TIMEOUT (300 * 1000)=0A=
 =0A=
+#define DEFAULT_ONLINE_CHECK_IPV4_URL "http://ipv4.connman.net/online/stat=
us.html"=0A=
+#define DEFAULT_ONLINE_CHECK_IPV6_URL "http://ipv6.connman.net/online/stat=
us.html"=0A=
+=0A=
 /*=0A=
  * We set the integer to 1 sec so that we have a chance to get=0A=
  * necessary IPv6 router advertisement messages that might have=0A=
@@ -97,6 +100,8 @@ static struct {=0A=
 	char *vendor_class_id;=0A=
 	bool enable_online_check;=0A=
 	bool enable_online_to_ready_transition;=0A=
+	char *online_check_ipv4_url;=0A=
+	char *online_check_ipv6_url;=0A=
 	unsigned int online_check_initial_interval;=0A=
 	unsigned int online_check_max_interval;=0A=
 	bool auto_connect_roaming_services;=0A=
@@ -122,6 +127,8 @@ static struct {=0A=
 	.vendor_class_id =3D NULL,=0A=
 	.enable_online_check =3D true,=0A=
 	.enable_online_to_ready_transition =3D false,=0A=
+	.online_check_ipv4_url =3D DEFAULT_ONLINE_CHECK_IPV4_URL,=0A=
+	.online_check_ipv6_url =3D DEFAULT_ONLINE_CHECK_IPV6_URL,=0A=
 	.online_check_initial_interval =3D DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL,=
=0A=
 	.online_check_max_interval =3D DEFAULT_ONLINE_CHECK_MAX_INTERVAL,=0A=
 	.auto_connect_roaming_services =3D false,=0A=
@@ -148,6 +155,8 @@ static struct {=0A=
 #define CONF_VENDOR_CLASS_ID            "VendorClassID"=0A=
 #define CONF_ENABLE_ONLINE_CHECK        "EnableOnlineCheck"=0A=
 #define CONF_ENABLE_ONLINE_TO_READY_TRANSITION "EnableOnlineToReadyTransit=
ion"=0A=
+#define CONF_ONLINE_CHECK_IPV4_URL      "OnlineCheckIPv4URL"=0A=
+#define CONF_ONLINE_CHECK_IPV6_URL      "OnlineCheckIPv6URL"=0A=
 #define CONF_ONLINE_CHECK_INITIAL_INTERVAL "OnlineCheckInitialInterval"=0A=
 #define CONF_ONLINE_CHECK_MAX_INTERVAL     "OnlineCheckMaxInterval"=0A=
 #define CONF_AUTO_CONNECT_ROAMING_SERVICES "AutoConnectRoamingServices"=0A=
@@ -174,6 +183,8 @@ static const char *supported_options[] =3D {=0A=
 	CONF_VENDOR_CLASS_ID,=0A=
 	CONF_ENABLE_ONLINE_CHECK,=0A=
 	CONF_ENABLE_ONLINE_TO_READY_TRANSITION,=0A=
+	CONF_ONLINE_CHECK_IPV4_URL,=0A=
+	CONF_ONLINE_CHECK_IPV6_URL,=0A=
 	CONF_ONLINE_CHECK_INITIAL_INTERVAL,=0A=
 	CONF_ONLINE_CHECK_MAX_INTERVAL,=0A=
 	CONF_AUTO_CONNECT_ROAMING_SERVICES,=0A=
@@ -486,6 +497,20 @@ static void parse_config(GKeyFile *config)=0A=
 =0A=
 	g_clear_error(&error);=0A=
 =0A=
+	string =3D __connman_config_get_string(config, "General",=0A=
+					CONF_ONLINE_CHECK_IPV4_URL, &error);=0A=
+	if (!error)=0A=
+		connman_settings.online_check_ipv4_url =3D string;=0A=
+=0A=
+	g_clear_error(&error);=0A=
+=0A=
+	string =3D __connman_config_get_string(config, "General",=0A=
+					CONF_ONLINE_CHECK_IPV6_URL, &error);=0A=
+	if (!error)=0A=
+		connman_settings.online_check_ipv6_url =3D string;=0A=
+=0A=
+	g_clear_error(&error);=0A=
+=0A=
 	integer =3D g_key_file_get_integer(config, "General",=0A=
 			CONF_ONLINE_CHECK_INITIAL_INTERVAL, &error);=0A=
 	if (!error && integer >=3D 0)=0A=
@@ -708,6 +733,12 @@ char *connman_setting_get_string(const char *key)=0A=
 	if (g_str_equal(key, CONF_VENDOR_CLASS_ID))=0A=
 		return connman_settings.vendor_class_id;=0A=
 =0A=
+	if (g_str_equal(key, CONF_ONLINE_CHECK_IPV4_URL))=0A=
+		return connman_settings.online_check_ipv4_url;=0A=
+=0A=
+	if (g_str_equal(key, CONF_ONLINE_CHECK_IPV6_URL))=0A=
+		return connman_settings.online_check_ipv6_url;=0A=
+=0A=
 	if (g_strcmp0(key, "wifi") =3D=3D 0) {=0A=
 		if (!option_wifi)=0A=
 			return "nl80211,wext";=0A=
@@ -989,6 +1020,8 @@ int main(int argc, char *argv[])=0A=
 	g_strfreev(connman_settings.blacklisted_interfaces);=0A=
 	g_strfreev(connman_settings.tethering_technologies);=0A=
 	g_free(connman_settings.vendor_class_id);=0A=
+	g_free(connman_settings.online_check_ipv4_url);=0A=
+	g_free(connman_settings.online_check_ipv6_url);=0A=
 =0A=
 	g_free(option_debug);=0A=
 	g_free(option_wifi);=0A=
diff --git a/src/main.conf b/src/main.conf=0A=
index df70e178742a..ddd5799610da 100644=0A=
--- a/src/main.conf=0A=
+++ b/src/main.conf=0A=
@@ -125,12 +125,16 @@=0A=
 # Default value is true.=0A=
 # EnableOnlineCheck =3D false=0A=
 =0A=
+# Urls (IPv4 and IPv6 respectively) used during the online status check.=
=0A=
+# Please refer to the README for more detailed information.=0A=
+# Default values are http://ipv4.connman.net/online/status.html and=0A=
+# http://ipv6.connman.net/online/status.html respectively.=0A=
+# OnlineCheckIPv4URL=3D http://ipv4.connman.net/online/status.html=0A=
+# OnlineCheckIPv6URL=3D http://ipv6.connman.net/online/status.html=0A=
+=0A=
 # Range of intervals between two online check requests.=0A=
-# When an online check request fails, another one is triggered after a=0A=
-# longer interval. The intervals follow the power of two series of numbers=
=0A=
-# between OnlineCheckInitialInterval and OnlineCheckMaxInterval.=0A=
-# Default range is [1, 12], corresponding to the following intervals, in=
=0A=
-# seconds: 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121 and 144.=0A=
+# Please refer to the README for more detailed information.=0A=
+# Default values are 1 and 12 respectively.=0A=
 # OnlineCheckInitialInterval =3D 1=0A=
 # OnlineCheckMaxInterval =3D 12=0A=
 =0A=
diff --git a/src/wispr.c b/src/wispr.c=0A=
index c63dc8195fde..56007a379327 100644=0A=
--- a/src/wispr.c=0A=
+++ b/src/wispr.c=0A=
@@ -30,9 +30,6 @@=0A=
 =0A=
 #include "connman.h"=0A=
 =0A=
-#define STATUS_URL_IPV4  "http://ipv4.connman.net/online/status.html"=0A=
-#define STATUS_URL_IPV6  "http://ipv6.connman.net/online/status.html"=0A=
-=0A=
 struct connman_wispr_message {=0A=
 	bool has_error;=0A=
 	const char *current_element;=0A=
@@ -96,6 +93,8 @@ static bool wispr_portal_web_result(GWebResult *result, g=
pointer user_data);=0A=
 =0A=
 static GHashTable *wispr_portal_list =3D NULL;=0A=
 =0A=
+static char *online_check_ipv4_url =3D NULL;=0A=
+static char *online_check_ipv6_url =3D NULL;=0A=
 static bool enable_online_to_ready_transition =3D false;=0A=
 =0A=
 static void connman_wispr_message_init(struct connman_wispr_message *msg)=
=0A=
@@ -910,10 +909,10 @@ static int wispr_portal_detect(struct connman_wispr_p=
ortal_context *wp_context)=0A=
 =0A=
 	if (wp_context->type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4) {=0A=
 		g_web_set_address_family(wp_context->web, AF_INET);=0A=
-		wp_context->status_url =3D STATUS_URL_IPV4;=0A=
+		wp_context->status_url =3D online_check_ipv4_url;=0A=
 	} else {=0A=
 		g_web_set_address_family(wp_context->web, AF_INET6);=0A=
-		wp_context->status_url =3D STATUS_URL_IPV6;=0A=
+		wp_context->status_url =3D online_check_ipv6_url;=0A=
 	}=0A=
 =0A=
 	for (i =3D 0; nameservers[i]; i++)=0A=
@@ -1036,6 +1035,11 @@ int __connman_wispr_init(void)=0A=
 						g_direct_equal, NULL,=0A=
 						free_connman_wispr_portal);=0A=
 =0A=
+	online_check_ipv4_url =3D=0A=
+		connman_setting_get_string("OnlineCheckIPv4URL");=0A=
+	online_check_ipv6_url =3D=0A=
+		connman_setting_get_string("OnlineCheckIPv6URL");=0A=
+=0A=
 	enable_online_to_ready_transition =3D=0A=
 		connman_setting_get_bool("EnableOnlineToReadyTransition");=0A=
 =0A=
-- =0A=
2.25.1=0A=
=0A=
---------------------------------------------------------------------------=
-----=0A=
Sorry, I think that my former e-mail was in not in raw format.=
