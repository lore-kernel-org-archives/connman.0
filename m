Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521642;
	b=Vsxg68DKZhB600Ui3psYoyRxXK0k3YePSv2XKz1ecOZ43wG83JdBKG68Ea13xqCINqeP
	 u4TATIRRXRwTYpg37xN2sJvHQuXMSCAoOajuDrqonsGh/METbyPex98JkxGrw2L4fclFG
	 zKlc0EedIOGRgWY9XjxHuNAT7/fqtnG7Q5RIIKrRlAPVB2QApKT5LIU9t128a+BPxYAsv
	 Y0FFlKwOWqFRPwwmIhd02a/9yh1fIPkm42GkarV8I2FbVwDDl9lfAenC/ZU9VOkbbI6Ky
	 PWCYJ/BEnWTXaidP247YKFw8tkVUmKWWv1aHhWHmvuFuYoqJzl0c5o5ZI6+JlSJuTKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521642;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9QHcW+vu46HxhEHfLNXBqeIM03jqdlHiQ3NfNS3dYG8=;
	b=zyOetxE079Ff6yyU75CrOCA8XnDNuasZ3bHfCLTmDI6QR9k8tp5Vciw/eEcPt98hRaR5
	 CpdOepLuqYIArnQ5w2c5LvWSfJz6fIhpRqptkBBqEe7BMAi4lr0pTK+G0y4yhaUqX7kyb
	 Qhj6CuBKSN1MwDj2D4renI4aaxRAf/vg0XqUz523CXArk6NCDvn9Rk2vwXwaoOz2i57G4
	 QaDJyTH+6YjjdLtJloLHW7WHcP6v+hfOoelcIiFxk4qZ/Ac9vjSKHsiS5BN1WPCrTk0Lm
	 zHQsynG8jAdYB9bwDV9zLUdCDtYICFREVUivMfuMQv+LRVXrpjKKSLFEe1bisUXXG4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=rotFWghq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.120
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020120.outbound.protection.outlook.com [52.101.84.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE4606A321
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 12:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDE4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=rotFWghq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKYtdukuQlVlFt4OvdC/eR+36Y6Dt2relkW4d2vtacJ6MQsZmiX3wsVGdo6Z0Ep+ZlfRdAyqVy5rboxuatnZlUju2lSh9NRGm156Gv/YdO1NrLxRF62aWSJG4sEb8WML4K7h0rR0y30ZWWBCJJGJysh17SownW/Pvz5yspXZaNHju0fd6tQ17cq6nojlxipROF4inE6LGT+PJvbqpjLriW3gOfFXzQyw9tt1Wz/A8PGFj3bRL3CCgJr8Oc19ACQzjc4bFG9ybEzYfgd3aeln5yTE/P7lALL7QAJ8dHtKB1vdql+uAVLuJQWRIXXBQOQSDlrHdtAGHTlvdTbbj9rCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QHcW+vu46HxhEHfLNXBqeIM03jqdlHiQ3NfNS3dYG8=;
 b=R4JlmoDZQvM5dSluO+XG+8gMDQ3+vUilkjmWVNcehVPwLbDLGJzk8BZxCnOtWxoI8OQqKaf6MGMwlaXVBabn7Wc0Cyx2GK9PzIUqfFfpPumuaMrfYIigOsBNIgxZrR/09c1XFna7GgRFecbr1Sczi/vW8LMTt7YXgT9h2kUrnkEmv2VI+jYef9ilBaEejwcNIrVRo5jn4+ocZJWqvVl55A0Hf9vUZ1w4OuKicOo9RLpYUEdnuAMzqHz3M3HSYWd87uqNjSlmiRGnFR3JVDkXszlL5hTX2PtTvshE4yK9sx5LFSqfUpZC3v7K+sDuVUqmFT7F3BiCcG6ko0aixPIbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QHcW+vu46HxhEHfLNXBqeIM03jqdlHiQ3NfNS3dYG8=;
 b=rotFWghqnvWe7CZP0FoAUqcl0QiE4hZNLT74N500ECMOkJfHjZ6T2jz1akhY17uvrlMw4FhdiFBDSMe8BFRb941l6qNJHESKmVlWYrhPN3AHMxbg74+Oc5kcZ2ZhPeniyTjuR5FbER4p5Jh5bke4fqZ5P6gLVqbMxPYBMyU2lmM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by DBBPR08MB6026.eurprd08.prod.outlook.com
 (2603:10a6:10:1f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:00:32 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:00:32 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 1/5] network: Handle the TOFU certificate chain in the core
Date: Tue, 24 Nov 2026 13:00:25 +0100
Message-ID: <20261124120029.1288258-2-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0118.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::20) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|DBBPR08MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7022fd-e424-4b35-ce6d-08df4a228a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|786006|376014|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	uGfvgqVeIzXtThYQdZ7fyMZgwWiZc7Tm9NDs31mBteDRdTZQx2pmzyvGmCZdXCQGyyBaYUQ3sDNh/i/cNW1iT6U+xhWNBOOmVY6kkH3E9sI5PtfCcDO5ixLrCyePMzDVDuuNDKU2DYuvEXGVL/2hJvcG006Agtswl9vthmvmIqnsEQDGnUCa8KB1knNgqQpI2xqdRCUT4vlBiPiz4lSSG1+RIsP6gMjF18xcAG9cSoyGTERY/PoUZr/hx32RYykrFlGSEp48e7ezhabuvb6pAaP6pO6FQik2GdcvULrVkDMMf2lgpDQ1yvdrmcqyp6MuR5RjLulvq0p0GDh7Ckp4ihreFcBvj42y8RaYOezQ7jAyuohTftL8h5eJDTgN8S1wfAvZfQGSJHTMjuODhAkQqRpTQHs/wBo6VdcSIwRVi+WyzxWzI7ShyQlMRiN5r716n5XIfAnonXIiFTqemp6AvqXcaJbx6dsS5R30nqA39W0gunMjKBLk6J1I3lSfEN2jxKTphD0mdljTrt6Ish2UfgwvY8FbEdDpGWNEQZFytczfdHEsij8fCqJOrFEUEKXGdaN1y1nSuV1SBvnTIIFeZTlnkf1YC2+P/trfDaJFpUIiuj2HgZLUlCb7f1w4ylVUL3U4jF18L45yKKMTV0TJKczoaGfu/QPXl1yM0DedlSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(786006)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(10067099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qe791fsM8WtFr+v9e+lEce0inc/jmDz47ZjnFa9qWgKasU7tMB81dr316rfr?=
 =?us-ascii?Q?qmqrX06KKuzD7Isu/tD68nhKTU+1wjldvc7FzvXoI2FfARhw5lbOd6uXkVDF?=
 =?us-ascii?Q?+3psde6ihbtx4j8qoAPTiGRDTzXgHnlUGvq4Zik74t6qJ/PASSGD8l1opZeg?=
 =?us-ascii?Q?yyMtngW+gIxEK1WUf5m3M8wZFwN1+d253rVsgq0VC3syT8ACxUdze2/va2as?=
 =?us-ascii?Q?f3KudzwPxsBmiXKgEBTfNj1KT9LBYDyY2+Dm1NwLdh+2blYQJQJZrcor3rnS?=
 =?us-ascii?Q?i1QjBGK088OkLZjSetOrIu14wlixkN0Nay+eapyZRvZ3ouVuP9EgJHz6k7VM?=
 =?us-ascii?Q?7ya8hupWtYj17fw0PAPQ9evZby+piKb46TnUbGTl0jQ5wpMQDB0nQwuhWqcH?=
 =?us-ascii?Q?LCG+ZPO4QT7utAXBRqVAVb2J63meGrVJlzSyXU0t4uMqxhCNeTrc2NwfCJjm?=
 =?us-ascii?Q?CaR7jFaQ8ejzE2lTeOR9qiB1DaEoRYkgnQZdafrNxW1ByTii1z24egzTlWt8?=
 =?us-ascii?Q?toZ70M8KPIWcSTpe1eTGVbs+rVkAWCbX4X2tsLAjWTh+rwEvuMRCTrCQl5rQ?=
 =?us-ascii?Q?IEPmSoCnk9k/REn53mbzPmJSkI3jHciIvnPyeJfTmg+RZvjZmK3Z6ETS4sqE?=
 =?us-ascii?Q?7i2hsPF7fc6QW2lXyIYwQNk02v3cFHgdXTskyLokObvw9PD8B8evxk/eMqTy?=
 =?us-ascii?Q?MxNOSr+wC7BkylyCJqo/O2QUmHS4qtPN64Co+LWV6LO5ZWysnd+eQaW9xfO1?=
 =?us-ascii?Q?8tqU3LpZMQkGuKMwu6cpsxCTmLyMh1D1vT8kW6dIxNg/GQTjsIXdifgXYQ8z?=
 =?us-ascii?Q?qQk9l1u7IxTIrOlfwNeeZrxIzVXCqI1BuxmU03gq9Ot7cnNNDIT/yZLhY6Kx?=
 =?us-ascii?Q?P0lZx7GZ4aCl8qaJZpb/LzjQnLOGd96dKYrLn05uuey//t0sbj5HVB2E3YOM?=
 =?us-ascii?Q?wUml2YZi8dDMAj7/D5UexhAFtOzUTBcj2Lg9QQ8hrRxy/65/OwLaBzLjX4ci?=
 =?us-ascii?Q?6uJ2se5pm4repXy9FgKlYNrjutKDzbZiQYG2JlktjlcVrJYF2tcilKgICXnV?=
 =?us-ascii?Q?gS/253LGlFj66Xg0UUWKijc58aGZs6FW+kS+36tsUy2Vt/KwxVMBBDaEspb5?=
 =?us-ascii?Q?ET7tJavwXOo1Kw25QtpTWSYqXdHRWymp/S2Q2IVgtEsnwXizhA0y1Yjdsm7Z?=
 =?us-ascii?Q?lZzhurVAf/5McTJlVVPl3dx4ztRd+1e2NSoH4ECnRe7hqO6D1wXDvbxHCKoq?=
 =?us-ascii?Q?TPv2DuOfLY9YtsH4/bneh6nMEK+NPV876AfMiD9oFjucCtJAIx8Cw7WU3g24?=
 =?us-ascii?Q?eGA+IDb+TlfYTkf7/43m+i3qKQl3Imsf91mKqwdwkWnG+QSA1oztFYKcUv7e?=
 =?us-ascii?Q?u4ArtZCnHAJjSoU3SWyNEzrl1mAJ1wzwoTb6LNNfh0UUGwinEKPGHMr2DDMz?=
 =?us-ascii?Q?rEmKVnFOEoW7Eew5FOLS/qWJ1NFTEa+nTqjvBJ6Wj1eyS+Wi9Kwrl9Wzsigc?=
 =?us-ascii?Q?RuBjF820SVWurKeP/ivvKt90c+nfQf6jVmaojAkKwB3IPwDdIlLuqP6wVk60?=
 =?us-ascii?Q?+87gVB3xUC3jntCQQl2IQsyHUSvuAYFaQvjyuCXul2nvvxIMTkHZlBCJXJM2?=
 =?us-ascii?Q?C1gyhoyRY9ME90lEge8FDX61ku2NK22oGWCeJkNOzLzVHerhIEWIKYITk8tG?=
 =?us-ascii?Q?Ou2PqreWKSa7aq+tgkpfAPYjU1b/tYtlSNwl98gHBMMpi9Sc8EdhSNHCCSCO?=
 =?us-ascii?Q?2eRvdmhNFO2vSet7wbktx1HGuqYEiQxpXYUkSTbnuFWR6nvoHbHa?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7022fd-e424-4b35-ce6d-08df4a228a51
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:00:32.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q//t2bU0+ooao5XrhxQgrWt5e7Gcpv132hLcMSQcKuRl1YTt31OSj2x6w9vYa5Mcn2au/m+ntGUFj3X80LZjb51AoOSo5RkBugF+thyzCbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6026

The certificates seen on a TOFU probe connection were processed by the
wifi plugin: it kept the highest depth certificate of the chain, checked
whether it is a self-signed root CA and derived the domain from the
server certificate, before reporting them to the service.

Move this to the core, so other Wi-Fi backends can report the server's
certificate chain as well. Plugins now report each certificate with
connman_network_tofu_certificate(), and the chain seen is kept per
network and reset when connecting. Reporting the certificates to the
service is no longer part of the plugin API.

No functional change.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 include/network.h |   4 +
 include/service.h |  17 ----
 plugins/wifi.c    | 203 +-----------------------------------------
 src/connman.h     |  18 ++++
 src/network.c     | 219 ++++++++++++++++++++++++++++++++++++++++++++++
 src/service.c     |   2 +-
 6 files changed, 246 insertions(+), 217 deletions(-)

diff --git a/include/network.h b/include/network.h
index 2078509e..d8ebb232 100644
--- a/include/network.h
+++ b/include/network.h
@@ -97,6 +97,10 @@ int connman_network_set_available(struct connman_network *network,
 bool connman_network_get_available(struct connman_network *network);
 int connman_network_set_associating(struct connman_network *network,
 						bool associating);
+void connman_network_tofu_certificate(struct connman_network *network,
+				unsigned int depth, const char *subject,
+				const char **altsubject, const char *cert_hash,
+				const unsigned char *cert, size_t cert_len);
 void connman_network_set_error(struct connman_network *network,
 					enum connman_network_error error);
 int connman_network_set_connected(struct connman_network *network,
diff --git a/include/service.h b/include/service.h
index 385e0c42..f194422f 100644
--- a/include/service.h
+++ b/include/service.h
@@ -153,23 +153,6 @@ struct connman_service *connman_service_get_default(void);
 struct connman_service *connman_service_lookup_from_network(struct connman_network *network);
 struct connman_service *connman_service_lookup_from_identifier(const char* identifier);
 
-/*
- * Certificates seen on a TOFU probe connection. Hashes are SHA-256 as
- * colon separated hex pairs. The CA fields are only set when the server
- * sent a self-signed root CA certificate.
- */
-struct connman_service_tofu_cert {
-	const char *hash;
-	const char *subject;
-	const char *domain;
-	const char *ca_pem;
-	const char *ca_hash;
-	const char *ca_subject;
-};
-
-void connman_service_tofu_certificate(struct connman_service *service,
-				const struct connman_service_tofu_cert *cert);
-
 void connman_service_create_ip4config(struct connman_service *service,
 								int index);
 void connman_service_create_ip6config(struct connman_service *service,
diff --git a/plugins/wifi.c b/plugins/wifi.c
index 8ddaed33..2a3fa318 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -41,10 +41,6 @@
 #include <dbus/dbus.h>
 #include <glib.h>
 
-#ifdef HAVE_GNUTLS
-#include <gnutls/x509.h>
-#endif
-
 #define CONNMAN_API_SUBJECT_TO_CHANGE
 #include <connman/plugin.h>
 #include <connman/inet.h>
@@ -151,12 +147,6 @@ struct wifi_data {
 	unsigned int watch;
 	int retries;
 	int load_shaping_retries;
-	struct {
-		bool done;
-		unsigned int ca_depth;
-		GBytes *ca_cert;
-		char *ca_subject;
-	} tofu;
 	struct hidden_params *hidden;
 	bool postpone_hidden;
 	struct wifi_tethering_info *tethering_param;
@@ -908,15 +898,6 @@ static void check_p2p_technology(void)
 	}
 }
 
-static void tofu_reset(struct wifi_data *wifi)
-{
-	wifi->tofu.done = false;
-	wifi->tofu.ca_depth = 0;
-	g_clear_pointer(&wifi->tofu.ca_cert, g_bytes_unref);
-	g_free(wifi->tofu.ca_subject);
-	wifi->tofu.ca_subject = NULL;
-}
-
 static void wifi_remove(struct connman_device *device)
 {
 	struct wifi_data *wifi = connman_device_get_data(device);
@@ -960,8 +941,6 @@ static void wifi_remove(struct connman_device *device)
 	if (wifi->scan_params)
 		g_supplicant_free_scan_params(wifi->scan_params);
 
-	tofu_reset(wifi);
-
 	g_free(wifi->autoscan);
 	g_free(wifi->identifier);
 	g_free(wifi);
@@ -2299,7 +2278,6 @@ static int network_connect(struct connman_network *network)
 
 		wifi->network = connman_network_ref(network);
 		wifi->retries = 0;
-		tofu_reset(wifi);
 
 		return g_supplicant_interface_connect(interface, ssid,
 						connect_callback, network);
@@ -3376,161 +3354,6 @@ static void assoc_status_code(GSupplicantInterface *interface, int status_code)
 	}
 }
 
-static char *colon_hex(const unsigned char *data, size_t len)
-{
-	GString *str = g_string_sized_new(len * 3);
-	size_t i;
-
-	for (i = 0; i < len; i++)
-		g_string_append_printf(str, "%s%02X", i ? ":" : "", data[i]);
-
-	return g_string_free(str, FALSE);
-}
-
-static char *hex_to_colon_hex(const char *hex)
-{
-	GString *str = g_string_new(NULL);
-	size_t i;
-
-	for (i = 0; hex[i]; i++) {
-		if (i > 0 && i % 2 == 0)
-			g_string_append_c(str, ':');
-		g_string_append_c(str, g_ascii_toupper(hex[i]));
-	}
-
-	return g_string_free(str, FALSE);
-}
-
-static char *der_to_pem(GBytes *der)
-{
-	GString *pem;
-	const guint8 *data;
-	gsize size, len, i;
-	char *b64;
-
-	data = g_bytes_get_data(der, &size);
-	b64 = g_base64_encode(data, size);
-	len = strlen(b64);
-
-	pem = g_string_new("-----BEGIN CERTIFICATE-----\n");
-	for (i = 0; i < len; i += 64) {
-		g_string_append_len(pem, b64 + i, MIN(64, len - i));
-		g_string_append_c(pem, '\n');
-	}
-	g_string_append(pem, "-----END CERTIFICATE-----\n");
-
-	g_free(b64);
-
-	return g_string_free(pem, FALSE);
-}
-
-/*
- * Only the issuer and subject names are compared: the certificate becomes
- * a trust anchor, whose own signature is not verified by wpa_supplicant
- * either.
- */
-static bool is_self_signed(GBytes *der)
-{
-#ifdef HAVE_GNUTLS
-	gnutls_x509_crt_t crt;
-	gnutls_datum_t datum;
-	gsize size;
-	bool self_signed = false;
-
-	datum.data = (unsigned char *) g_bytes_get_data(der, &size);
-	datum.size = size;
-
-	if (gnutls_x509_crt_init(&crt) < 0)
-		return false;
-
-	if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_DER) >= 0 &&
-			gnutls_x509_crt_check_issuer(crt, crt) > 0)
-		self_signed = true;
-
-	gnutls_x509_crt_deinit(crt);
-
-	return self_signed;
-#else
-	/* Without a certificate parser fall back to pinning the server */
-	return false;
-#endif
-}
-
-/* First DNS subject alternative name, or the common name otherwise */
-static char *domain_from_cert(const GSupplicantCertification *cert)
-{
-	const char *cn, *end;
-	int i;
-
-	for (i = 0; cert->altsubject && cert->altsubject[i]; i++) {
-		if (g_str_has_prefix(cert->altsubject[i], "DNS:"))
-			return g_strdup(cert->altsubject[i] + 4);
-	}
-
-	if (!cert->subject)
-		return NULL;
-
-	cn = strstr(cert->subject, "/CN=");
-	if (!cn)
-		return NULL;
-
-	cn += 4;
-	end = strchr(cn, '/');
-
-	return end ? g_strndup(cn, end - cn) : g_strdup(cn);
-}
-
-static void tofu_report(struct wifi_data *wifi,
-				const GSupplicantCertification *cert)
-{
-	struct connman_service_tofu_cert tofu = { };
-	struct connman_service *service;
-	char *hash, *domain, *ca_pem = NULL, *ca_hash = NULL;
-
-	service = connman_service_lookup_from_network(wifi->network);
-	if (!service)
-		return;
-
-	hash = hex_to_colon_hex(cert->cert_hash);
-	domain = domain_from_cert(cert);
-
-	if (wifi->tofu.ca_cert && is_self_signed(wifi->tofu.ca_cert)) {
-		GChecksum *checksum;
-		guint8 digest[32];
-		gsize digest_len = sizeof(digest);
-		const guint8 *data;
-		gsize size;
-
-		data = g_bytes_get_data(wifi->tofu.ca_cert, &size);
-		checksum = g_checksum_new(G_CHECKSUM_SHA256);
-		g_checksum_update(checksum, data, size);
-		g_checksum_get_digest(checksum, digest, &digest_len);
-		g_checksum_free(checksum);
-
-		ca_pem = der_to_pem(wifi->tofu.ca_cert);
-		ca_hash = colon_hex(digest, digest_len);
-	}
-
-	tofu.hash = hash;
-	tofu.subject = cert->subject;
-	tofu.domain = domain;
-	tofu.ca_pem = ca_pem;
-	tofu.ca_hash = ca_hash;
-	tofu.ca_subject = wifi->tofu.ca_subject;
-
-	connman_service_tofu_certificate(service, &tofu);
-
-	g_free(hash);
-	g_free(domain);
-	g_free(ca_pem);
-	g_free(ca_hash);
-}
-
-/*
- * The chain is reported from the highest depth down, so the highest
- * depth certificate seen is the root, if the server sent it, and the
- * server certificate (depth 0) comes last.
- */
 static void certification(GSupplicantInterface *interface,
 				const GSupplicantCertification *cert)
 {
@@ -3539,30 +3362,12 @@ static void certification(GSupplicantInterface *interface,
 	DBG("depth %u subject %s hash %s", cert->depth, cert->subject,
 							cert->cert_hash);
 
-	if (!wifi || !wifi->network || wifi->tofu.done)
-		return;
-
-	if (!connman_network_get_bool(wifi->network, "WiFi.TOFUProbe"))
-		return;
-
-	if (cert->depth > 0) {
-		if (!cert->cert || cert->cert_len <= 0 ||
-				cert->depth <= wifi->tofu.ca_depth)
-			return;
-
-		g_clear_pointer(&wifi->tofu.ca_cert, g_bytes_unref);
-		wifi->tofu.ca_cert = g_bytes_new(cert->cert, cert->cert_len);
-		g_free(wifi->tofu.ca_subject);
-		wifi->tofu.ca_subject = g_strdup(cert->subject);
-		wifi->tofu.ca_depth = cert->depth;
-		return;
-	}
-
-	if (!cert->cert_hash || strlen(cert->cert_hash) != 64)
+	if (!wifi || !wifi->network || cert->cert_len < 0)
 		return;
 
-	wifi->tofu.done = true;
-	tofu_report(wifi, cert);
+	connman_network_tofu_certificate(wifi->network, cert->depth,
+				cert->subject, cert->altsubject,
+				cert->cert_hash, cert->cert, cert->cert_len);
 }
 
 static const GSupplicantCallbacks callbacks = {
diff --git a/src/connman.h b/src/connman.h
index 1eb24ae6..1afa02d1 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -859,6 +859,24 @@ int __connman_service_get_index(const struct connman_service *service);
 void __connman_service_set_hidden(struct connman_service *service);
 void __connman_service_set_tofu(struct connman_service *service, bool tofu);
 bool __connman_service_server_cert_hash_valid(const char *value);
+
+/*
+ * Certificates seen on a TOFU probe connection. Hashes are SHA-256 as
+ * colon separated hex pairs. The CA fields are only set when the server
+ * sent a self-signed root CA certificate.
+ */
+struct connman_service_tofu_cert {
+	const char *hash;
+	const char *subject;
+	const char *domain;
+	const char *ca_pem;
+	const char *ca_hash;
+	const char *ca_subject;
+};
+
+void __connman_service_tofu_certificate(struct connman_service *service,
+				const struct connman_service_tofu_cert *cert);
+
 void __connman_service_set_hostname(struct connman_service *service,
 						const char *hostname);
 const char *__connman_service_get_hostname(const struct connman_service *service);
diff --git a/src/network.c b/src/network.c
index 3de64f57..5b81c225 100644
--- a/src/network.c
+++ b/src/network.c
@@ -26,6 +26,10 @@
 #include <errno.h>
 #include <string.h>
 
+#ifdef HAVE_GNUTLS
+#include <gnutls/x509.h>
+#endif
+
 #include "connman.h"
 #include <connman/acd.h>
 #include "src/shared/arp.h"
@@ -110,6 +114,14 @@ struct connman_network {
 		char *pin_wps;
 	} wifi;
 
+	/* Server certificate chain seen on a TOFU probe connection */
+	struct {
+		bool done;
+		unsigned int ca_depth;
+		GBytes *ca_cert;
+		char *ca_subject;
+	} tofu;
+
 };
 
 static const char *type2string(enum connman_network_type type)
@@ -1221,10 +1233,21 @@ void connman_network_driver_unregister(struct connman_network_driver *driver)
 	}
 }
 
+static void tofu_reset(struct connman_network *network)
+{
+	network->tofu.done = false;
+	network->tofu.ca_depth = 0;
+	g_clear_pointer(&network->tofu.ca_cert, g_bytes_unref);
+	g_free(network->tofu.ca_subject);
+	network->tofu.ca_subject = NULL;
+}
+
 static void network_destruct(struct connman_network *network)
 {
 	DBG("network %p name %s", network, network->name);
 
+	tofu_reset(network);
+
 	g_free(network->wifi.ssid);
 	g_free(network->wifi.mode);
 	g_free(network->wifi.security);
@@ -1643,6 +1666,200 @@ void connman_network_set_ipv6_method(struct connman_network *network,
 	__connman_ipconfig_set_method(ipconfig, method);
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
+static char *hex_to_colon_hex(const char *hex)
+{
+	GString *str = g_string_new(NULL);
+	size_t i;
+
+	for (i = 0; hex[i]; i++) {
+		if (i > 0 && i % 2 == 0)
+			g_string_append_c(str, ':');
+		g_string_append_c(str, g_ascii_toupper(hex[i]));
+	}
+
+	return g_string_free(str, FALSE);
+}
+
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
+ * a trust anchor, whose own signature is not verified when it is used
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
+static char *domain_from_cert(const char *subject, const char **altsubject)
+{
+	const char *cn, *end;
+	int i;
+
+	for (i = 0; altsubject && altsubject[i]; i++) {
+		if (g_str_has_prefix(altsubject[i], "DNS:"))
+			return g_strdup(altsubject[i] + 4);
+	}
+
+	if (!subject)
+		return NULL;
+
+	cn = strstr(subject, "/CN=");
+	if (!cn)
+		return NULL;
+
+	cn += 4;
+	end = strchr(cn, '/');
+
+	return end ? g_strndup(cn, end - cn) : g_strdup(cn);
+}
+
+static void tofu_report(struct connman_network *network,
+				const char *subject, const char **altsubject,
+				const char *cert_hash)
+{
+	struct connman_service_tofu_cert tofu = { };
+	struct connman_service *service;
+	char *hash, *domain, *ca_pem = NULL, *ca_hash = NULL;
+
+	service = connman_service_lookup_from_network(network);
+	if (!service)
+		return;
+
+	hash = hex_to_colon_hex(cert_hash);
+	domain = domain_from_cert(subject, altsubject);
+
+	if (network->tofu.ca_cert && is_self_signed(network->tofu.ca_cert)) {
+		GChecksum *checksum;
+		guint8 digest[32];
+		gsize digest_len = sizeof(digest);
+		const guint8 *data;
+		gsize size;
+
+		data = g_bytes_get_data(network->tofu.ca_cert, &size);
+		checksum = g_checksum_new(G_CHECKSUM_SHA256);
+		g_checksum_update(checksum, data, size);
+		g_checksum_get_digest(checksum, digest, &digest_len);
+		g_checksum_free(checksum);
+
+		ca_pem = der_to_pem(network->tofu.ca_cert);
+		ca_hash = colon_hex(digest, digest_len);
+	}
+
+	tofu.hash = hash;
+	tofu.subject = subject;
+	tofu.domain = domain;
+	tofu.ca_pem = ca_pem;
+	tofu.ca_hash = ca_hash;
+	tofu.ca_subject = network->tofu.ca_subject;
+
+	__connman_service_tofu_certificate(service, &tofu);
+
+	g_free(hash);
+	g_free(domain);
+	g_free(ca_pem);
+	g_free(ca_hash);
+}
+
+/**
+ * connman_network_tofu_certificate:
+ * @network: network being connected
+ * @depth: depth of the certificate in the chain, 0 for the server
+ * @subject: subject of the certificate
+ * @altsubject: NULL terminated subject alternative names, or NULL
+ * @cert_hash: SHA-256 hash of the certificate as 64 hex digits
+ * @cert: DER encoded certificate
+ * @cert_len: length of @cert
+ *
+ * Report a certificate of the server's chain seen while connecting. The
+ * chain must be reported from the highest depth down to the server
+ * certificate (depth 0), the order in which TLS libraries verify it:
+ * the highest depth certificate seen is then the root, if the server
+ * sent it. Certificates are only used on a TOFU probe connection.
+ */
+void connman_network_tofu_certificate(struct connman_network *network,
+				unsigned int depth, const char *subject,
+				const char **altsubject, const char *cert_hash,
+				const unsigned char *cert, size_t cert_len)
+{
+	if (!network || network->tofu.done || !network->wifi.tofu_probe)
+		return;
+
+	if (depth > 0) {
+		if (!cert || cert_len == 0 || depth <= network->tofu.ca_depth)
+			return;
+
+		g_clear_pointer(&network->tofu.ca_cert, g_bytes_unref);
+		network->tofu.ca_cert = g_bytes_new(cert, cert_len);
+		g_free(network->tofu.ca_subject);
+		network->tofu.ca_subject = g_strdup(subject);
+		network->tofu.ca_depth = depth;
+		return;
+	}
+
+	if (!cert_hash || strlen(cert_hash) != 64)
+		return;
+
+	network->tofu.done = true;
+	tofu_report(network, subject, altsubject, cert_hash);
+}
+
 void connman_network_set_error(struct connman_network *network,
 					enum connman_network_error error)
 {
@@ -1805,6 +2022,8 @@ int __connman_network_connect(struct connman_network *network)
 
 	network->connecting = true;
 
+	tofu_reset(network);
+
 	err = network->driver->connect(network);
 	if (err < 0) {
 		if (err == -EINPROGRESS)
diff --git a/src/service.c b/src/service.c
index 44928978..6109eef6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7680,7 +7680,7 @@ static void tofu_check_probe(struct connman_service *service)
 	g_idle_add(tofu_probe_finished, connman_service_ref(service));
 }
 
-void connman_service_tofu_certificate(struct connman_service *service,
+void __connman_service_tofu_certificate(struct connman_service *service,
 				const struct connman_service_tofu_cert *cert)
 {
 	struct tofu_request *req;
-- 
2.53.0

