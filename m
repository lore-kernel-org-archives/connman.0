Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479203;
	b=EnaN8GFvhoAi+gwkE1CDYgi9D5/HW5OFjp+O+BFyhPKPxKUKFqTTLDZCnGOyeMUseNbk
	 SvNST6Du2CnuU90LLfgRSIWhY0aH6yKceqJwbkPU0Aia6z8DDw6qRfQnf+TI1DsxTYbjf
	 DKz5a1cjbEbxi0puhjhIyDwzuBgC22WSedBwm18s+vpXic0Qu9Rf2Iq1yvrSFnkWoPvIv
	 HhOpeIAOqXOazVZMSyCvJj4S2J7yULxu5SXFxevFaYDMilLYRzMcUavMhNBIu6WVqXSTu
	 GgslSO691JchpNWHA93m5yOP1AC2dQSIac7Lhg7W2Ox74iHqI8SN5+f8YT9HVydUOMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479203;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ibjaA7iJRMzWJt2kN/obmb62Jjl6fRWVav5rDQd6mNA=;
	b=wsUv3GBgSS53Qup1G9vLorMm/3eEvJ0q4cM5xLlB1l5tlWSr83G+aTR14O5CAgmtfoBj
	 vRWg4SxSejo+HITdvKqqwBBtt6Mda4U5Xgth8cqVxsTjyR+zg7bj/n2QVWpyC+P/OQI4K
	 ISHQX1cF75aUKpG4pgdEVKfS9oTFmvHjcpkPFMaAQR1kCCasgBIwIwauUJ9n9aZ8paE8G
	 4YMct3PeHm0tvN2Oklpfni0PR7fE6dzni9+3UwbPo6p9UWkkT8Yj0Cfe3OzH7W8BuI6Le
	 Oom8x0t0BuIgdJAkHVZRUSo+yJn8zrCenCipf+lgitNt8x2DN0IHYHvRMlK3Y2gfkjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=axhwMiU9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE51606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE51606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=axhwMiU9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7zW1r6G76E9I+vknAMjtOPpdwdNU8rCRzIOPNX677XEm3bLk8mTP/D91YuAKlvc4I/BwA5S++Xdu74Ecn1Uj04okq0DiEbQh1Bjs1EmJk5Q8aSOuv9y1/TGT1vZmA895rQwAZkSwX7jWWZV8vp+4LhoEjnFlJWz6958c2PgO11Vf4znxKshltbEFzDdsb31ZOtvEfUrIxxqD0MN+WDzk6MLu6xYnCusE9xb1MFxUKy8RlYVO0MXMKqZl6s2uSKnWUmG0uOlN+DVEzeItRy9hSYH5C3srzfP9ttHJqCdCvw4uA2qVv/RSpzvdwhiR9Hg3/YtAnM4oOU9+n1+wR+xCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibjaA7iJRMzWJt2kN/obmb62Jjl6fRWVav5rDQd6mNA=;
 b=dDomf6KG+GlHTX36Z1CB8Sve8NdZoeF2Uk4moj4T/rono5Eu+UiBY/eiStFtTEA2sbJ6uj8sHXOwZg26cpjOfDMkwg8IfEt1dEL3RAEe6xLX+pji3m8gknm+VwcPbXEPhN5LITVuTXMwkfK7Jj/gnb9L4duLlezRaJkQlsaPrxhLeUhRLt8z8cDeA9vu/et73Ve1rZX5Bv3IVIUpFsahycjbQzfK58ONcJuSm0uyLRffCvei1Fejgtm+z4j8j7dMUQwDxPJNIHHhkQcl/awf+dksLTg8PLUbuBNPJgqiVN6o8c1DVpvovHjXI6hfri5vZ1/0p4l2wi5Kg28sj/XyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibjaA7iJRMzWJt2kN/obmb62Jjl6fRWVav5rDQd6mNA=;
 b=axhwMiU9dhvXmoFlLRcV+KN+KQKEGu0qJl3fOOZqwE3813wI04rxfH4M8FoC8uljo6Kl92pt7RPOUleGcW6koGQl4ljm+7v2MQOj+G8ZhYdDwbCEtzBAlNc/lnXodkwb7rIPeBaAJPM2UIXBeAWY4dRl5Tc1d/Q19a2IuFOdsKs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:19 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:19 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 01/15] gsupplicant: Add support for server certificate hash
Date: Tue, 24 Nov 2026 01:12:57 +0100
Message-ID: <20261124001311.1161845-2-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::33) To MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|VI1PR08MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8207a0-c499-4fc3-9553-08df49bfbe33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jg0G/AwuyVIvSFjR0FQb3p4xoWGmt5FUnOSnT70Q+it9pjQs6qPLDprklzmGUT+bqTdRWEno9GI2tG4yvaClF6ZbcQdXox+mAjnEp5PzGFCMCQKkOqSbWHZU59snkIlhcfZ4OMG0RQRAoI8efJDnQBepqbTgoBGJOFmSlAWphfPCqvlduzsm/zQC3mbtDTm+bFjrN3r+C7C41mLRp3FJmBZ0lvra49S0SU8q3CnaZ8Gg4lH2FvDGwI0dlokbbHym28SpY8zqFUsIn/aAWgE4ZBNvAzXIo+7Pqqm7UV2QKsaRAA47IK/mHGHKVxaFXBwx0Knx3+d8fHQlnGd80Ja56L1hmaReESPz1mPn7TLUUm+iCsfvLCDpv9nWCOMVli+VrFrWfVTkTzFK0Fj5wOWIDkGfpIXrA+w7mUtD3DHbhCKfUcHSowmXVlxI3gqNuhuA+y3lzSb6k3RVqL56jp06BStIH/yZVQ3cON6pO5VNOJcxU3QBslxA9NKbM/3YJt7akOkpb8pD/F9bvvHa60DWNYOUNEEuCXwbg/1zQE5rMmDHBZcrZxAsNr+mGWw4nyjI43AwLi5k4Fr64cB5tUtdu2wcdKQDDeMMhp6Ps8UWFX0kbGCK9JVhW+lfCVp/WFwE6r4w4595UkVKFEcBPGb8m/XptY9p6q4+AY+xCAsDB1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RyB52llZDFw3tXZnllFOE7tkTb1h6jX4hNCfUOOa5a1SuAal/62WkZC1jSVD?=
 =?us-ascii?Q?N8yGu60PWVfsJhkGoF+iLRP7VPLj+EcAGAzcDN1sBbKflhDIrXhO4EIzfXvu?=
 =?us-ascii?Q?y4nH9bRjC9TnKDt6B8SPWs3f90PgRy7MDw4OgABIGRokpTl/hG1iqNhxjJiF?=
 =?us-ascii?Q?wns2St/yhlU37W7lfniRhEJ3Y8JmoyJqGv+aW76LH89sou849Bt/NGcpr9hI?=
 =?us-ascii?Q?t3T76QBtIP1lZ74QxmkdhVs5ZICGhQTItfZw+nX9IWasYulu0v2ORooFwZ7e?=
 =?us-ascii?Q?DQLZYv7a3Uw2EQGRhyH2aqOzdAqrDyx7ESBEeNeP+hmSIrmic1QA/b6mnTW3?=
 =?us-ascii?Q?42lI+GKR3KUbZc53fLY07kL7NPjzZHvG3JsgBM9N6nfswwFLZAVIwyVik1tF?=
 =?us-ascii?Q?zWy/QUORSilVd/L6yeqfB6cIA0xZDWdOJPaLzTMJ6UAYdrjJfLm/gOUQonhs?=
 =?us-ascii?Q?3YdUqzzMFOwezM+FKMcu8J4l6zOr8pMcjGLGjLOM2MMJxrla3w9eXzwpMs9q?=
 =?us-ascii?Q?P34G9ZTsdfF9UV/bw6RbflxDqyFXvRd2pI/rrI6FTn42xLeeOG1ko9xvVw3J?=
 =?us-ascii?Q?notddEeGaIJpa8cHgwA3fisEc23rm96W07+GUmjmt7oSlr3EG1g4B6hoSxoc?=
 =?us-ascii?Q?OFvSb42IbCHjuUQAj1bba6C8TdGni4sdlZusC66qcBn182ejpvNH9ct+FU3w?=
 =?us-ascii?Q?EjrSRky9E4/lBtnX/nNSPJF5AEBsngBSBQ3zurpkqqYTOrmz5ZqOfmn0SbXT?=
 =?us-ascii?Q?87chAsK2oNdCu1bfx/TJkVxMoc6jy2Jujz7Afr/Ooyu9UtTPw1K9esqn4x88?=
 =?us-ascii?Q?l4wg6EprK/3f3+YY/MCSur46T3IqI1OiAB/DdKARVHghGmIjeAWhj21ZW5dS?=
 =?us-ascii?Q?8/ySp+GT8ZfOk+6l3s0XUkvg71qjf0UKYD6igciG3pa3HC/3q9Hzw6MvpXGn?=
 =?us-ascii?Q?cEig+WWExFlCOsFRvzXaC82pIhErcESbzbiouUvah16VOvD8IjN7wPqfHZ4W?=
 =?us-ascii?Q?xfrHzMEK1eVYMJacsvisJb2/EWfV5L/lGzq6ptO7KMX5yjb1avToP7c8/0lL?=
 =?us-ascii?Q?JuO1yqwoC19A6gpP7cEirOgSVlDwh37pokwnLqaYSBeDD/oMz6Ac8j1CDSoN?=
 =?us-ascii?Q?ZfIOksPC2kehWHPiAqp4bunv3iB+uCN5xN+syYbfXIs75sq6wIAoscwvHnmR?=
 =?us-ascii?Q?NlumAjLQgtPN5EdaRontbXbPCDNz8SJwE42nW3Y6iimozV3nHlXX7dAZ5+N/?=
 =?us-ascii?Q?+USsUFpc6cUFXGCFzYCrUXgp/+Ic/QPI1/prXXAv3QDtUGk17lzqkIySnNC/?=
 =?us-ascii?Q?nGd0+4YftTt3qxGM2woclYRHAeOMexFYyVaMetBhZfgr9wmKOkoNUpQMftp3?=
 =?us-ascii?Q?enYSTCeaj5ACrIS5lpT57d0QtOEalk6iLPX2tFRVi85djkEQmxH6Fi2suD85?=
 =?us-ascii?Q?4FVXTs7GgYuNCb3bKr7DHR8J9sj3waw9vmNAYcOm+VVt0GBs8iocCI4WRhaR?=
 =?us-ascii?Q?hXDZp8lEhliAXhOwdKvSXeBsiNAUqbEYTmbL+DV+s49Iif866cGDxooXVsFN?=
 =?us-ascii?Q?PWlXIhgLqUCQ0TOPgDLQ8Jaz271bVW8EQE7cvBzLDH8lR5Jgb7h60qQqLSpC?=
 =?us-ascii?Q?1b23h+OK9Wjuqs4bjo+toRoI7qknH4sOLMD6fpkaB0CTll6CKSoha408WBjF?=
 =?us-ascii?Q?g+7WQ324x/C3aAcP6mW8JKPxy9agsdz97M8bmQMVG6H/6QqpGYcnlmdlM5k8?=
 =?us-ascii?Q?elEeTMsvpqyp67VqpxB6PVdqm5Qg5m4k4hQ1KpICB73aHKqa3vKcqfZjprTU?=
X-MS-Exchange-AntiSpam-MessageData-1: Fd2D2vEJP/lbgnE8yu+HYl0qFePQC0rsseE=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8207a0-c499-4fc3-9553-08df49bfbe33
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:18.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCt8MgEzg3q9+N/sMIhlxRDWLcQT1eQFd6GT/PAVVIgApf8NAXY/ZzYqPWi5O5UHEyiioNIjQZ+UtlafofYKk1vLkTIG28yt42UXbCgDo+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Allow an EAP network to pin the authentication server by the SHA-256
hash of its certificate instead of a CA certificate. The hash is
passed to wpa_supplicant as a hash://server/sha256/ ca_cert value,
which wpa_supplicant then compares against the certificate the server
presents. A configured CA certificate takes precedence.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 gsupplicant/gsupplicant.h |  1 +
 gsupplicant/supplicant.c  | 41 ++++++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/gsupplicant/gsupplicant.h b/gsupplicant/gsupplicant.h
index eab6293f..fe842696 100644
--- a/gsupplicant/gsupplicant.h
+++ b/gsupplicant/gsupplicant.h
@@ -151,6 +151,7 @@ struct _GSupplicantSSID {
 	const char *identity;
 	const char *anonymous_identity;
 	const char *ca_cert_path;
+	const char *server_cert_hash;
 	const char *subject_match;
 	const char *altsubject_match;
 	const char *domain_suffix_match;
diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 50cdeca3..83eac964 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -823,6 +823,7 @@ static void remove_ssid(gpointer data)
 	g_free((char *) ssid->identity);
 	g_free((char *) ssid->anonymous_identity);
 	g_free((char *) ssid->ca_cert_path);
+	g_free((char *) ssid->server_cert_hash);
 	g_free((char *) ssid->subject_match);
 	g_free((char *) ssid->altsubject_match);
 	g_free((char *) ssid->domain_suffix_match);
@@ -4684,6 +4685,37 @@ static void add_network_security_psk(DBusMessageIter *dict,
 	}
 }
 
+/*
+ * The server certificate hash is stored as colon separated hex pairs,
+ * wpa_supplicant expects it as hash://server/sha256/<lowercase hex>.
+ */
+static void add_network_ca_cert(DBusMessageIter *dict, GSupplicantSSID *ssid)
+{
+	GString *uri;
+	char *str;
+	const char *p;
+
+	if (ssid->ca_cert_path) {
+		supplicant_dbus_dict_append_basic(dict, "ca_cert",
+					DBUS_TYPE_STRING, &ssid->ca_cert_path);
+		return;
+	}
+
+	if (!ssid->server_cert_hash)
+		return;
+
+	uri = g_string_new("hash://server/sha256/");
+	for (p = ssid->server_cert_hash; *p; p++) {
+		if (*p != ':')
+			g_string_append_c(uri, g_ascii_tolower(*p));
+	}
+
+	str = g_string_free(uri, FALSE);
+	supplicant_dbus_dict_append_basic(dict, "ca_cert",
+					DBUS_TYPE_STRING, &str);
+	g_free(str);
+}
+
 static void add_network_security_tls(DBusMessageIter *dict,
 					GSupplicantSSID *ssid)
 {
@@ -4704,9 +4736,7 @@ static void add_network_security_tls(DBusMessageIter *dict,
 	if (!ssid->private_key_passphrase)
 		return;
 
-	if (ssid->ca_cert_path)
-		supplicant_dbus_dict_append_basic(dict, "ca_cert",
-					DBUS_TYPE_STRING, &ssid->ca_cert_path);
+	add_network_ca_cert(dict, ssid);
 
 	supplicant_dbus_dict_append_basic(dict, "private_key",
 						DBUS_TYPE_STRING,
@@ -4774,10 +4804,7 @@ static void add_network_security_peap(DBusMessageIter *dict,
 						DBUS_TYPE_STRING,
 						&ssid->passphrase);
 
-	if (ssid->ca_cert_path)
-		supplicant_dbus_dict_append_basic(dict, "ca_cert",
-						DBUS_TYPE_STRING,
-						&ssid->ca_cert_path);
+	add_network_ca_cert(dict, ssid);
 
 	supplicant_dbus_dict_append_basic(dict, "phase2",
 						DBUS_TYPE_STRING,
-- 
2.56.1

