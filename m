Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50065.outbound.protection.outlook.com [40.107.5.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1372FB8
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 12:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaN+MNJDrxrxCWdH/+bNqW0xbj6om7GnHdLvJMzltWEISFbiMWeE3nIOAfOH8T0i5eBssYLUS2j0AEtcJsp5stwRHo+E2REJj4gwT30Co0OX9/Yzn29fIQNmM1heoNOqPI3I0/8szagYIxaLJxruN8DqBF1VwNIkz4KmEyagM/Ewh7IuWSV5aUFeNK/VNqXSK0pA+ZSZZGeK1LgwDBJjRrPWCUO8SXp5zpWgy1QLfLdEWDg7ltthD+me44BMutgnaj6vT3J9XG5whANarrvVP++HFHbCJb8ZTkuCJu53UnotVuK6ZOqhqYKBFr6FJKiVXegxWYmHhBzaWgNk+JnQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTISrbcTULk0sJccal/RXvNUmqLWf6MBMpsY+mHzV0=;
 b=R2NlZxHDfKExch6o7N3b0BzSPAmLgaSz6K4So7WuDAOU/zfMng/zdLfQXCzWPeD3BDTQ1rQhOfSgBnZ43mt98oR4Mlsfsa1yh+y6E8BgMHFE0aw9tnySBHv0Hw7k7MRDTtXiF442ZPCaADbmYrdB3NL6uTttGk+zsyqSkYyFER1jMrISNuFO1MYGsH7HijQYDGxsS++OVyVQ/TeOllXT4W99NoJc7+A3UAy/uxy0hCChSzu4MMmkbQ1FtoUX3RUgXYg1s9qzASkI06GtunLDMQY8eZ5psj0fV4y+6ea4cCfWeX8H0slnpO2Gp++MQDeOcZA6baWg7auTiKJLXWRSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTISrbcTULk0sJccal/RXvNUmqLWf6MBMpsY+mHzV0=;
 b=o4I6e9AONOQJCj3DkmOgrsCn5zopTUbz9CBPKs1Ho7DZPhEgpTvG+4txBJGiwf1JREJ0+XDILCb73+po7FdPQJU53d38BHlq8oLtDP9oLaxvdHYfz+a36BucRxbwneatHg7SxKUcgWjrU1x2uSXdYYdxPvnFZdzm2gX5LDv9ho4=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PA4PR02MB6797.eurprd02.prod.outlook.com (2603:10a6:102:f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 12:58:16 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 12:58:16 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] wispr: Add online check url config options
Thread-Topic: [PATCH] wispr: Add online check url config options
Thread-Index: AQHXYeTK6zVrkCfjz0+UXmRbnjdQQA==
Date: Tue, 15 Jun 2021 12:58:16 +0000
Message-ID:
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
x-ms-office365-filtering-correlation-id: baff7155-0f12-4f2e-c919-08d92ffd3e1a
x-ms-traffictypediagnostic: PA4PR02MB6797:
x-microsoft-antispam-prvs:
 <PA4PR02MB67977BCC5AE2C80F1D99718693309@PA4PR02MB6797.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HDnCY/brgAR2/yV9oAYZan7NoCM9rS4XJWj+mnS3GvGjhKtPDrGyToBQGcgb9Xebowy1+8TS5rPwGRZvr1NxfmIqaEX30lVrZ74p4KYF5dShJohSHw77MFVdM5U02rKHOrGxr3fGS6TsCppmh2+hd8P8AEZki97TZqwABYsaONICxiHdcsRpvtIvsYwpVIw27POn7z8fsumKskN7+Q4mA8cp12eksHOXdOgObVowA/bXWdWOEq+FN8XrqewZ5QHUfF5zTptXaxocuqwchdlDnKOVOkfc8/nC1xhWddZbJzf+llrbRHFlMi0SPdTXEh0kv2+V3u/V2YIQbo+LMX4bD0xYiiBqaUePa52nhcMfRvje8p9B6Ti02IEK2MYzX+ypcocfUNemKM0CLsJwwtqaBwGs20SaUZ3T/L8e0hdNveOcJRQUHX0fpo0rTJPBCvLeyxFqkZ1THf7kWQ6IpiuuvW17U9HWMSGYeK5Ruoq4grbUtLBa/q9oTtAp9wYCAApIzjB7OwgRa+CkpfjrnnMEN+vRBIkOHmAtPurq/r0SLjWVK49hjiK4ZyD7Xq3HOrvhubgTvWjsG/qG+5raq0lYzQnA156V6Y971gm4hpx7F462nMpMmKmFAvPtF7oF8I1K/+CXI/jkOce1G+KxYSQo78Iuf1m/B2uZ/21bhNz/k9PVuKTEa18B1wZ0vig2kaEvG+sVM/msSvYt0ZiTFE8UdYDURjF90hcJPWVQDbhXVaY+1BzbsbgpK/XumUsBTlwEVHFs/HvTg88ivUQrTWKe+H66/fkVhgT48IcM9ItCab8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(86362001)(9686003)(71200400001)(6506007)(26005)(8676002)(2906002)(478600001)(19273905006)(52536014)(7696005)(8936002)(966005)(5660300002)(6916009)(38100700002)(66574015)(76116006)(66446008)(66476007)(55016002)(186003)(64756008)(66556008)(19627235002)(66946007)(316002)(33656002)(122000001)(83380400001)(562404015)(563064011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sJ9AxMpudXsJy+fAwPZDQsBi858HHQvdWrZ6kC7Qt4My6KqGyPCeoTOOeY?=
 =?iso-8859-1?Q?gVSXsKQ0lkEug6vWi7URgTG0kRx9OOmHe6kUziI7S8RpnDsOkm+X2YLO4z?=
 =?iso-8859-1?Q?oIgyGWvgWFfguRkn161PHABQv12MkLyrk7JbQfoJIyQ3DGynA+cFZdLMHp?=
 =?iso-8859-1?Q?bPxNbZxfT8En9r2UUrM0YVgF3VMRkO4AmUGD6Iu026QniiAQDr1Ly15aZb?=
 =?iso-8859-1?Q?k2Udgn9SWwOZR58ZdfvlQ0JN+Kx48ZVeEmhTC+G6XO7t78BFF0i/M8LjN2?=
 =?iso-8859-1?Q?Faxm3N9mG21tJGDDIEmRuGCtA9HM4J9oGHLEGUjeELwV9INM5HuxpzEt46?=
 =?iso-8859-1?Q?v/ZvV2XH27rcFZypYW5enP5cVObY+9tRLtYRsJp23LzKA9mkCjzjRvk0zF?=
 =?iso-8859-1?Q?PjM29L3fUg1r3efQEUoB9s4FJCQjyWrNhmQux5c6w0ElYBjbXC1OVg7jqZ?=
 =?iso-8859-1?Q?dCmRV3xszE1Gex0OwrWxT1gcYn+mX5yAuAMoN4VV2DhWjobjJl6mKKA2GY?=
 =?iso-8859-1?Q?kVlzygaf4mhvK7YsT7YC0ig2XLW0tXNmDYT2VMDf2sy7Bd8cIOxJAIoCzc?=
 =?iso-8859-1?Q?9T63bOfRkLxLzRuejha6aoRGCwOmYE12x4NKzWnAb2CivRPYNi268pcC4d?=
 =?iso-8859-1?Q?bU7u8QCc3CewKtizwE3yGUNMB6/nKWPzi+HC9S3O5oEMUDuJHkaCQFCCcY?=
 =?iso-8859-1?Q?SHDZrJkHJq1gizVFrVXZufn21PYFrhVcv5uIi0gcQnqdwW8ZWeuYFjhbIF?=
 =?iso-8859-1?Q?/UaJxSt7ZWCPgQCIZLCO25XoW3x8YulQYB16DLDMu/aOqseEPQjEiZuU0a?=
 =?iso-8859-1?Q?HVRSt4zF6l202AXxHR/m0CxpljB/A4JgF0+vvsqjURUlj5YIPMJLhpigPh?=
 =?iso-8859-1?Q?oVoE0NZsEDmJhqypvOO0HOFOCqrexOGRbrOzfOuR4EgWW1lgnJ3JbNMyF0?=
 =?iso-8859-1?Q?bIoHkAi03/hDZ91sZmowul9ugb+EIEp6C6qmT8+8t6FK4IpsRVLrWk2c0h?=
 =?iso-8859-1?Q?lhAI4jD1tKyka3uEOXDJ9RtQ0fNBaKrTaVHUCDbniLnqVJUPWWyRrON8c1?=
 =?iso-8859-1?Q?peZ40kXvuyiVBm0mZuQsuq54UQCZXWkWAQvIwZc8c+nYLKRklK0yrCmiXY?=
 =?iso-8859-1?Q?tD1w6ZACvcbduF4s66kN7ODJRo7alZh4OVONvedP2MhSVJqQ2g3s0wag+e?=
 =?iso-8859-1?Q?b8si9AXhwaNKs/8pHKrI5bwKxrztDQ36y7vIueZVAtOfRXGXHhnF6Gpi7x?=
 =?iso-8859-1?Q?FNbq+7UyVVAx6X+D+th7fy5fveahGQ2xlrfLnDKhJmN7n3ldw7U5SFhE0Y?=
 =?iso-8859-1?Q?4P5MQ6mrFxTpK9VabHm9SIP3/NwuSPXkOwnoJuKiJi2gzQo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: baff7155-0f12-4f2e-c919-08d92ffd3e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 12:58:16.3950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXFvEfBSGNzVirvNFmtFAw050uq3Ied4DPEK4T29ZiMB0faKjzoDUEnynOQ+cZh25PCf885fLWjup7zRjoYtllNGVNWR0yVw7lAa5kehML8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6797

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
---------------------------------------=0A=
Hi Ryan,=0A=
=0A=
> Nice work on improving ConnMan.=0A=
Thank you, much appreciated.=0A=
=0A=
> I've just noticed that the documentation incorrectly states that the back=
off period follows the power of two series.=0A=
> It seems that this must have been intended to say that it follows the ser=
ies of squares, as it is clearly not the power of two series.=0A=
> Alternatively, maybe the code does follow the power of two series=0A=
> but the intervals listed in the documentation incorrectly are listed as a=
 series of squares.=0A=
> [...]=0A=
> I know that this wording preexists your changes, but this seems like a go=
od opportunity to fix it.=0A=
Yes, it makes sense. It was my mistake on the previous version.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
