Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479214;
	b=i/WFtxzcsbxyBD+sMiOF48tbd4iPzc7pBLJsMP+DP3OeRbFHd9c8+WVIyteUxwa9EQ4X
	 CccR+zFVVu8j/8xQs7Z0TzB5AFdZKl6fucknD1QWeG6UlK7jycbipr9kZ6DCJ/0bP1bZ5
	 WgZ1vs1xvYEB14n24SWS5ibUEGbqObKPcwpovrlnsaiyew1pcTKSxdgdwdxKUw0zje1lt
	 pKSA3chxvVTNfcqwz05XPZ8QXmWKRB8A8Zi+iWXJtoK5d25d8tuNnjaJMtV3jio0yjxvs
	 oEoyWqHEN1xcgBMbr4ykPwLj5q6iTB0KEOkYbV7LLkt3NIzXvqnENJYrwM77SMeU3IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479214;
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
	bh=u7u0lIfym4Vxg1m9fjbj6bUcuDfbS9Bq6sVqI1tjUOQ=;
	b=0cbPdmVCaHtxv3ISZ3gkiwrsEIPiUNLI7Zo2eh8+s5Cb9CvYLUIWXB6VpCHEDOSgt24b
	 1fKwy5r7/YtgioML6vzE24iGGhNxhusIW36wM17SzEFae5PpkFgPUcPp9uWKmyeP+5RlU
	 0MUE4c77X8Tzfs3sP4/tQD+lM4GoiCSP68t7rIDXdsF8YI1raU8KDIyPGllVwIEpE02RY
	 e8RTRZ6ujoy0dXtIt/LdFNy1qOJGxojLIKJPtwCivUmpN7VaNWmbCoJ/1GNLf9drcN75D
	 IeBx10VOhkKC51gkUPy28bCrEVziTnklFbSbtLGToWMjHjBXXNNs64soqeLpyQzccag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=RFkTIRly;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BE606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA3BE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=RFkTIRly
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk/sE4/1TjeN+qviUc1+taPvZgrFl06Ts87NESIXEGufNbdXQiM3pv3rbAJXIfixfcxL8PEeK3kl4ibU4ynLmrC8/FZ4swJxfHvLk6IgkOwlDTmNLYKpwiDP2JarLqTXVj8gmFXie9mCziEkF04uiZ6QVsFVhrBJRojI5+jLjwUwR8v3RIYeIHCl9jb/zkEoll5+yTWRHt1yEUa6maP5mdtG94E38nFGUYeMO/PBOT9qK3WfFGIG+BUfa5OiT00J645K9QWEsWXjX1Iauzt9/XdGhB5OXulXdIuEDwzwvSmxd7MbkrMvCddxKGf/CeAG/o8vaMzKCJgiwLUdUKPLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7u0lIfym4Vxg1m9fjbj6bUcuDfbS9Bq6sVqI1tjUOQ=;
 b=vGv8CXuxWJg3nNC7KAXNW6aAp6NUcKlW/3pq1Qh9B7HjC2QIwXvpR3H+l9jqgIPKr1Tpbl2gAVSxQo9KkB/dyKcxhw9VsX6hd9ZPAs3Hfaj7+xGMFKvuEPRpf+/zesI18Bf++UJwv7DkcSuFvnqqaxhwRLiHhFi5gOLxduFlKLM9/k6e1GO6tu8Mex751tyAlcOlJjfAiGENjvXwR6dtZ1SasE8z3xctu/7q/9QdFVAA4l35J2GYojhayjMYuacK5bxg4SapySQLn7dOeIUVHVIp+SIXeNyB7bVzmzCvZYNBYmCBIeiFdfxgqTVbc3ZU9Z6d6wrX8Tst+qs8mM7yTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7u0lIfym4Vxg1m9fjbj6bUcuDfbS9Bq6sVqI1tjUOQ=;
 b=RFkTIRly+TeyEXWwa9OVpm215MPDzvIrEVWoOkDEqgdJybcwYTsTY6Aa1NPSXDqK4EI6DWPmrfp3TrIWKdPJ+4yy3WnMw1S21vBgmbMfWJmDY/NDTU5V7qtA7wqPf1x/QQ4WAwb4fMtkm1NMpw4O2PleoMplSMefYTbxrgbG3JQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:29 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:29 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 10/15] wifi: Report the root CA seen on a TOFU probe connection
Date: Tue, 24 Nov 2026 01:13:06 +0100
Message-ID: <20261124001311.1161845-11-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0251.eurprd05.prod.outlook.com
 (2603:10a6:20b:493::10) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: aa6bd223-d1a7-4772-c1e0-08df49bfc4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261021123027099003|261022075727099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	0XJop+YpqxCS85qhOHzKU4fqP8XS9DWpfmljowbT+Z8DHfnwchouQZwxgyyfaVxf6MygUfgB3ehxfbtWxVsbBjjTkkINUPKO/hoGpnb8RBtDF5MqGG0RNTADX79nXToKvIGJ2u3TxnnwVgmJWKr45dYUiwu0The15v9m9+HKknX+lG/HlD5PNBtbNO49krix//x13VysXMaSJ9875lctpnCzC7cj6EjKlRFqoKzIdHP4lSeiosK4kIF3pSU//wkPM5tBWx6hqyZNX0aUk2eEQ0mJbTGlvwYZ9BsqeSHNQ/mZfYNCR1SKgrHjeO+bf8FLPknkRlfzTOCWgDE4k8UckcdAApspKOxm2Mu4spMsMnOOcmnHKdYtbRHzAwTCEnwZfo26nzernhxJXF9r1QTsVYItneuZd1eJiVPvNRJPxFmVIsUdWvfShxIPRvp9Ki6znO5YGIHCUMOjOuUFVCY0e4Eu/Dbr4B65FbOoNvmAKSBFAO98pKJ4E1jESN9k3g/m755S63brKUXJbBgH/YdNoAdEWnsdXhhYlvYTy5VmJ+c5rGE3m/Ib4pHnGYSrRHRZd/4bFyeyaddJLfScBZuYV3IDa3bdVNp1oSV4zzDXPmbTR2/njLuPYSym0bXmnKVgQCrgK0Qs6t7RCmr12IT1QsmW3fDAHuNYblxQmIS2ykQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbghOEJMyfrl3zkVMvPlpPuRMtF607WWS08b1ef+3mhbl/VSpC8LPAL22Srs?=
 =?us-ascii?Q?ibQNeiH76IpCI91Km8b8A/GAJbJlNz/aRB5gnE8e2zQQFnkohYMWlYJSkwBV?=
 =?us-ascii?Q?yL+/06L29uYH5L8hiZHOXWGRGrtax/GAf8zrxeCvqX/hMrsnicD1WeFvB0q4?=
 =?us-ascii?Q?7ZzY1o1CqD1byUC9+GMh2/VAHIrR01HvOoOBHuCUV8Epu4SQ9GpoCOjTSU6L?=
 =?us-ascii?Q?K7OsHrMhJCbm1nDVWepCOs4TqVWbbBo36QMw8TWdczT+PBZDVfsxUuYMc0FS?=
 =?us-ascii?Q?jygMs2NwFNX0fb0Od3pUF1uflYlbBlHkJBWOMoVTgIt1CR/TW5sEuSlaQ6ZZ?=
 =?us-ascii?Q?8ziHQ1VRlWM9PQYldm6cT99J6UuBxw9yLpezCaA0ePvcBrG/xPdnkRrx1FrA?=
 =?us-ascii?Q?PoutdKLzwaM8u3C43XNg2veVhrjg7WyMj0/aJWhMHMT8br7++pBqXH+g/J1x?=
 =?us-ascii?Q?bSn4Q2+2XxOtT9wLKOnUMiTlFPQS989rZfZozyZ/iFfMhvwsXqgti1hMQJ2l?=
 =?us-ascii?Q?iKbc0rpUO2DA9+YfQXsd/3F3Y968OLU9tN7ShhC88lgCOO9r9olUwgkGagUx?=
 =?us-ascii?Q?FpUDf0EqNouWpM9BM2NRxhEZqhYoHivqwvwzwOMr9ZhjNW5WJMcbvWzQPeJx?=
 =?us-ascii?Q?uWPcqy0ltFf+KY37AH1LJZvXdeWrYd6McrBOpNl3Dw3YTnXMdYM3si6grYxx?=
 =?us-ascii?Q?G7Al2UWBC/7aSqIL7pwuwJpbJ1NXo8hgJk36QgLSIWfz3yZKXpSIz1wUjPtP?=
 =?us-ascii?Q?+LQIR2ciR7gRfoMwlxR25y3fY7BpErdnobNdVcQS1IxsxmOLgS6Jf9Sdc+0W?=
 =?us-ascii?Q?QlC1DwTpSRlCCdvBJNOFi/EVDt2PzRVQa/hSV+lR42LwSSz7Olv402G8Yh27?=
 =?us-ascii?Q?KoP5/W90V1Z/3nfMnQc+uwvOASu2sR5tM6XPtMJfaogemunjXZ3/8Sw4rdks?=
 =?us-ascii?Q?/YMINq6PAb5IE1tFdklsVA/5EgARVFJNmD1h9Fdypgbq8UMtcFEI5maePTZv?=
 =?us-ascii?Q?VdJL+Dw9KzcZqlT90IGDc4NrsKNhhes+bbuvmfa+j9/FrbZCe8l7/zjADDBO?=
 =?us-ascii?Q?zCiyCI79CrYHLnt64qGImxJiVT5lItrEziAst7oh8CytDOm9o0T1GvoIbs6r?=
 =?us-ascii?Q?eef9QAx0byxRAJOfFVfthbCZe9CDGHVPff94Mhh+gIsVFyXUhva9Ogi5jtFr?=
 =?us-ascii?Q?4J3V0or1DKN+jATrAa+1h5yb9RWApG2J2++WLYKXy5tH849Gt67g+bfSHNIp?=
 =?us-ascii?Q?jF3mGDutQqlFeigxfbUMEF/0RfHF9VpB0RcTD3U0s96HBwhU/XX3MOVfGdgk?=
 =?us-ascii?Q?xZEYl9jah4zBvAyFoAx0TZHMSOdNA4Qg1/SkdXnYKBSVXrZnAVqEMd1FYTOE?=
 =?us-ascii?Q?WGfwv0omBIHJ3jbO2z6hREJBWdhA3VLkDGV4MTyF2RUf4wBCrCV9HSdNQdmB?=
 =?us-ascii?Q?FlbgQc/BpHAQsoH2vM2Yye2pcdI5tdnuNxJVQYfv+3H3TPGSp+K98RaWe87J?=
 =?us-ascii?Q?ONfbKUIJPN/HKZDcvZSNkD4X4FCLg0TbhdCnvJEdOV0YruRIk42g2LcjUfTP?=
 =?us-ascii?Q?pD2bsXtvdc0TS26LQg4P5gCX/FQVNcWnk9LUW6Ew0XzN6lQZHlCTZF8FTANX?=
 =?us-ascii?Q?kcw/DHlwXVQar04A0QGvAQZM30UPFCR3dWg/cSDPWSKZqVevanmQQeI+2cwC?=
 =?us-ascii?Q?HrQhgKf6+DN+rb0p9nDefYZaGyLYiNrpu1inhA9JojU3IJKu2izN0/PD4fYZ?=
 =?us-ascii?Q?ys5YPoEm/4b7k+eq7H3yAOXz4aovQbV9hqSP20NeMEtqomOl7kY5bkkuERKf?=
X-MS-Exchange-AntiSpam-MessageData-1: 7b4ZJbPQCzAIMbfqTb/77h8l2gAcgajNAvs=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6bd223-d1a7-4772-c1e0-08df49bfc4bd
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:29.8853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tixVaXVF67yyQ5Y+bvszR0X9IDRV/w7khKMQFWTuIPHh2BAUMfun4h4W7c8Tv6kTKaS86bIDBm10NLnAIKP5K9pCw6xwMF3lT9Bu28OWGKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

When the server sends a self-signed root CA along with its certificate
on a TOFU probe connection, report that CA to the service as well,
together with the first DNS subject alternative name or common name of
the server certificate as domain to restrict the CA to.

Recognizing a self-signed certificate needs GnuTLS; without it only the
server certificate hash is pinned.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 configure.ac   |   1 +
 plugins/wifi.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index dc52cf7e..48b442cf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -499,6 +499,7 @@ AM_CONDITIONAL(CLIENT, test "${enable_client}" != "no")
 if (test "${enable_wispr}" != "no"); then
 	PKG_CHECK_MODULES(GNUTLS, gnutls, dummy=yes,
 				AC_MSG_ERROR(GnuTLS library is required))
+	AC_DEFINE(HAVE_GNUTLS, 1, [Define if GnuTLS is available])
 else
 	GNUTLS_CFLAGS=""
 	GNUTLS_LIBS=""
diff --git a/plugins/wifi.c b/plugins/wifi.c
index 3d5f3055..8ddaed33 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -41,6 +41,10 @@
 #include <dbus/dbus.h>
 #include <glib.h>
 
+#ifdef HAVE_GNUTLS
+#include <gnutls/x509.h>
+#endif
+
 #define CONNMAN_API_SUBJECT_TO_CHANGE
 #include <connman/plugin.h>
 #include <connman/inet.h>
@@ -149,6 +153,9 @@ struct wifi_data {
 	int load_shaping_retries;
 	struct {
 		bool done;
+		unsigned int ca_depth;
+		GBytes *ca_cert;
+		char *ca_subject;
 	} tofu;
 	struct hidden_params *hidden;
 	bool postpone_hidden;
@@ -904,6 +911,10 @@ static void check_p2p_technology(void)
 static void tofu_reset(struct wifi_data *wifi)
 {
 	wifi->tofu.done = false;
+	wifi->tofu.ca_depth = 0;
+	g_clear_pointer(&wifi->tofu.ca_cert, g_bytes_unref);
+	g_free(wifi->tofu.ca_subject);
+	wifi->tofu.ca_subject = NULL;
 }
 
 static void wifi_remove(struct connman_device *device)
@@ -949,6 +960,8 @@ static void wifi_remove(struct connman_device *device)
 	if (wifi->scan_params)
 		g_supplicant_free_scan_params(wifi->scan_params);
 
+	tofu_reset(wifi);
+
 	g_free(wifi->autoscan);
 	g_free(wifi->identifier);
 	g_free(wifi);
@@ -3363,6 +3376,17 @@ static void assoc_status_code(GSupplicantInterface *interface, int status_code)
 	}
 }
 
+static char *colon_hex(const unsigned char *data, size_t len)
+{
+	GString *str = g_string_sized_new(len * 3);
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		g_string_append_printf(str, "%s%02X", i ? ":" : "", data[i]);
+
+	return g_string_free(str, FALSE);
+}
+
 static char *hex_to_colon_hex(const char *hex)
 {
 	GString *str = g_string_new(NULL);
@@ -3377,27 +3401,136 @@ static char *hex_to_colon_hex(const char *hex)
 	return g_string_free(str, FALSE);
 }
 
+static char *der_to_pem(GBytes *der)
+{
+	GString *pem;
+	const guint8 *data;
+	gsize size, len, i;
+	char *b64;
+
+	data = g_bytes_get_data(der, &size);
+	b64 = g_base64_encode(data, size);
+	len = strlen(b64);
+
+	pem = g_string_new("-----BEGIN CERTIFICATE-----\n");
+	for (i = 0; i < len; i += 64) {
+		g_string_append_len(pem, b64 + i, MIN(64, len - i));
+		g_string_append_c(pem, '\n');
+	}
+	g_string_append(pem, "-----END CERTIFICATE-----\n");
+
+	g_free(b64);
+
+	return g_string_free(pem, FALSE);
+}
+
+/*
+ * Only the issuer and subject names are compared: the certificate becomes
+ * a trust anchor, whose own signature is not verified by wpa_supplicant
+ * either.
+ */
+static bool is_self_signed(GBytes *der)
+{
+#ifdef HAVE_GNUTLS
+	gnutls_x509_crt_t crt;
+	gnutls_datum_t datum;
+	gsize size;
+	bool self_signed = false;
+
+	datum.data = (unsigned char *) g_bytes_get_data(der, &size);
+	datum.size = size;
+
+	if (gnutls_x509_crt_init(&crt) < 0)
+		return false;
+
+	if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_DER) >= 0 &&
+			gnutls_x509_crt_check_issuer(crt, crt) > 0)
+		self_signed = true;
+
+	gnutls_x509_crt_deinit(crt);
+
+	return self_signed;
+#else
+	/* Without a certificate parser fall back to pinning the server */
+	return false;
+#endif
+}
+
+/* First DNS subject alternative name, or the common name otherwise */
+static char *domain_from_cert(const GSupplicantCertification *cert)
+{
+	const char *cn, *end;
+	int i;
+
+	for (i = 0; cert->altsubject && cert->altsubject[i]; i++) {
+		if (g_str_has_prefix(cert->altsubject[i], "DNS:"))
+			return g_strdup(cert->altsubject[i] + 4);
+	}
+
+	if (!cert->subject)
+		return NULL;
+
+	cn = strstr(cert->subject, "/CN=");
+	if (!cn)
+		return NULL;
+
+	cn += 4;
+	end = strchr(cn, '/');
+
+	return end ? g_strndup(cn, end - cn) : g_strdup(cn);
+}
+
 static void tofu_report(struct wifi_data *wifi,
 				const GSupplicantCertification *cert)
 {
 	struct connman_service_tofu_cert tofu = { };
 	struct connman_service *service;
-	char *hash;
+	char *hash, *domain, *ca_pem = NULL, *ca_hash = NULL;
 
 	service = connman_service_lookup_from_network(wifi->network);
 	if (!service)
 		return;
 
 	hash = hex_to_colon_hex(cert->cert_hash);
+	domain = domain_from_cert(cert);
+
+	if (wifi->tofu.ca_cert && is_self_signed(wifi->tofu.ca_cert)) {
+		GChecksum *checksum;
+		guint8 digest[32];
+		gsize digest_len = sizeof(digest);
+		const guint8 *data;
+		gsize size;
+
+		data = g_bytes_get_data(wifi->tofu.ca_cert, &size);
+		checksum = g_checksum_new(G_CHECKSUM_SHA256);
+		g_checksum_update(checksum, data, size);
+		g_checksum_get_digest(checksum, digest, &digest_len);
+		g_checksum_free(checksum);
+
+		ca_pem = der_to_pem(wifi->tofu.ca_cert);
+		ca_hash = colon_hex(digest, digest_len);
+	}
 
 	tofu.hash = hash;
 	tofu.subject = cert->subject;
+	tofu.domain = domain;
+	tofu.ca_pem = ca_pem;
+	tofu.ca_hash = ca_hash;
+	tofu.ca_subject = wifi->tofu.ca_subject;
 
 	connman_service_tofu_certificate(service, &tofu);
 
 	g_free(hash);
+	g_free(domain);
+	g_free(ca_pem);
+	g_free(ca_hash);
 }
 
+/*
+ * The chain is reported from the highest depth down, so the highest
+ * depth certificate seen is the root, if the server sent it, and the
+ * server certificate (depth 0) comes last.
+ */
 static void certification(GSupplicantInterface *interface,
 				const GSupplicantCertification *cert)
 {
@@ -3412,9 +3545,18 @@ static void certification(GSupplicantInterface *interface,
 	if (!connman_network_get_bool(wifi->network, "WiFi.TOFUProbe"))
 		return;
 
-	/* Only the server certificate, at depth 0, is pinned */
-	if (cert->depth > 0)
+	if (cert->depth > 0) {
+		if (!cert->cert || cert->cert_len <= 0 ||
+				cert->depth <= wifi->tofu.ca_depth)
+			return;
+
+		g_clear_pointer(&wifi->tofu.ca_cert, g_bytes_unref);
+		wifi->tofu.ca_cert = g_bytes_new(cert->cert, cert->cert_len);
+		g_free(wifi->tofu.ca_subject);
+		wifi->tofu.ca_subject = g_strdup(cert->subject);
+		wifi->tofu.ca_depth = cert->depth;
 		return;
+	}
 
 	if (!cert->cert_hash || strlen(cert->cert_hash) != 64)
 		return;
-- 
2.56.1

