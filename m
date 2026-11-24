Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479210;
	b=BxNO85JJ8ctfwmGOFh7CXz+YCNoKGz6d234s0ZCObKjCBhSaocFtqSTwNqOGfvy/oON6
	 A1NBq8y/6z2bI0zToYBUnPlpaL9JznZmVyTd6HUGxQKOegg5fhVKnggpC+vEOk1EXGMic
	 xUjCpT6e6C5UPirFWJW56m+R+QROq1IoCQilxjiYuMJoXSJskdvOVv/7fagFw+Ati4a0Y
	 697vbb/6oYLmYRsd4cQl0uRi3WuaZIg/zJ6T8ywNkkFO6aM6K3fmshTfwUCKAxmmXwsNv
	 zU6hdVOqEv1UysbM08hB5zUOXjT7LnEIpdXPgmXQxXg20qGIyOmtBIhRReQwUb4lpPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479210;
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
	bh=aXRmpcyHixIVrSZF9PThfnXb7E1VBE21TgsB/1br5S8=;
	b=CR74xeI73NOm6urHn104WETg8H+2ag11fsp3bS0HJdFMLV8cbxHf3cgO7ylZEKGrtBfh
	 2/9Is3f9JD36zIM4M2jbKsEbNVwRbcJw+W9PYOZB6MN0Q/ACdhcl7SKS5sT/P+wY476l6
	 2KgN08/SfULj7hVhSYM1fUon7IXC6nGcuMscFPOlAQpBCWDfLUPvzId+9WjFQfr7wretn
	 fGxErVeY7JIUvlvT/mHb914TYLU5aF3/5IA3KpjhQ7X8jDwh8/gEbs2EMebwCyk3sIMQT
	 c4tFOwKr8WjSDflG9mv/4kC8zs3PAXXpqbEqhSpfjtA4VOOdCteORbE7oqdPtHQgyng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b="E8GyrM/T";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4E606A321
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A4E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=E8GyrM/T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7Ufc5aHwWQk/VW7GkiTU/JNRvK9eMfttcNpbNoc8ScAiNsHhcNsFnNm2SCkW/2o2qfydStXZFYrD/7HLJysdvwi5T1BPOfno4Na2RvjohXXs6FRVjBELoIwWdrwc+1tEEqi8BETBbK3IN2uK4lRdFJkEWlBpaFN9tDjvIDSzY1s7q4Dmwl36sRnkfgHAQTpe3aTtp9/ftkSt0uR1iXaChrYqlIkv3X9EN4OmTWizrc2GQVRx5/Kf49/TRMWNwnmqI49V7KeUyNyW8bVcfxU3hNxtm2Rg0N5C4JviGIUhX+JRawcvnC8KEVwm17n/TPLyy0ml02qqpEHaH0rAC+Osw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXRmpcyHixIVrSZF9PThfnXb7E1VBE21TgsB/1br5S8=;
 b=gOrq6Q0rxoiKopUg5EtwuiL+aFPr3YPUj2koF5JOd27ileE8C9VcMcs9891nR1W8l5/oPZLJjNwP5ZyEAR2/XsGos435IEZ9rrCWZr3QarDVNYHNPTna49r5If0qb+sZSzxYbDcZr1d5Pan2rVkt+tySTMe6SwndAprEBb2xw0yYwcoVWYQHLl6loEQuzeA+4Ux0UGK64ynod52SJFipdbOK2lkxB+/vi9CJrP4IIDqjd1yC+HI8/iHrYLm40gFW1jPdnrwB02trR+DpyyXdWIU8RV3kytM9wYEKA5FEPvqYFZZjhfQij48nGe8J8/jMW6cADWn+ZbfKEomvteSH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXRmpcyHixIVrSZF9PThfnXb7E1VBE21TgsB/1br5S8=;
 b=E8GyrM/TJD/WFeXneaZH9y+mxuecswvo2AXMNJnuYXG09fKrs7ySFxk6mVSV2+vWB0/g3n31L2Qk3Bgq3zsbmgzk1mm5N3MVbeeZdKx/WiAhDnqUGBaUawCEEGzW3nVGCub/c9MStNTuYSny+hn9jJdnePklhdJ1uLOGUB65VYU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:27 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:27 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 08/15] service: Pin the certificate seen on a TOFU probe connection
Date: Tue, 24 Nov 2026 01:13:04 +0100
Message-ID: <20261124001311.1161845-9-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0024.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::31) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f4c3dc3d-fab2-4901-5d3b-08df49bfc36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261021123027099003|261022075727099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	70oJnzGqVRfAoioKFCTi5rAK4vEyekuDkkB++EvVJc01P8A4yKDb6BaznRiVjagnTFXdpnAt1jjNeePFACNfjAfR3j4w32XA3zQJQQ6vZ1AM2TYtA1QkgBwB+M6U9Y2jvob4OrF3H7f5VBQjgyS1i7B4eKylxByIFaxvhLXI6jEZhHINv0apyiF5dW41BbrWOvDEaX3Pl6xKMpyA8kTKrmPKwIl+QvnKuiQP+qY44/1UesgCFbmh6fBvF9vjKGW95oR1w3X+V7NS7WS/2dFRHEbMqDdjx8GRLuV1fzqPluszwik7+sebfz3yozWljEFLIcdfbdWzZgrVYFgpABzt6iXxTC+BXbXLhUWBs8rrmx47sSpmzOjnkdCe8ESFIYuTJbhluLK0RPlRE8JPzctA6g7PxvzZyT7tQYnpJDkC3vv3AgA++wAvZmfPjujfBH+JS9QgofWrRcpmS0d/dT5CCjZcuBHVBy/Vs9oihRpsPt7k6FvkRn/yj0oCtdbmNSuOKoAiL0jGgHaX5tJ+xMzOCT10iQbgSXMgxmgqgxN3tOQDkVD5sLoMDA6XyHn+bVqdCWODNY7/LLCuFk8AkJU10osHC+UAStfc/TZDlNEPLmlRRY7VykeVk50AiyXWs13aKbGUVYWgrDbsmmWVe4KGPub1ZWvCvILUUzqWNxEU0go=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhGK+vWbTHRm67uD8wZ/GefX0eKLm1pPPX3JDVS3VHZbpUjBpTMeDkAy2lw5?=
 =?us-ascii?Q?Z2S2kbgW1CIjQx+jAmKw1eo0DV0dNvaF8VONDwh30N5F83HPQCblXizyw4AC?=
 =?us-ascii?Q?MSF6PI5nK6SIdGIwTefDCT/KODOeuyg+dXRWWsklKxgOkswZ3pgcq8CU0kxF?=
 =?us-ascii?Q?GC/GBD889Z5F90H22ZKYZlvGz/Bdk8zuZC67D4sD+TgViiL3lfa+JQl1tIP6?=
 =?us-ascii?Q?v+6+gObCghHFRtkKf3rGvkKLRJsPWkCRuwaGpH7h8FcKobQEMHmnnQlmYY/f?=
 =?us-ascii?Q?REMN8GfBIpFnDsJ/SDcP3TGfd/Qw5tLereyX/S4GURksrurp8JPOfrYdqxpv?=
 =?us-ascii?Q?8VctzAn6P0vRhfHcKggoICyOQWg4YnDyOy/tTtr+xlFmoFmRXl+I1ceisy1q?=
 =?us-ascii?Q?XAn2OUr/t4DkrKvzUd/efuNpNZSU9Zu0cHZuk2iyu0NzOAzrIER9Ki/jv9vD?=
 =?us-ascii?Q?qPKDhSxTSML8qUOuPlR0hNlcT4syntpaFC5IyErqIwHizJwaNXgoQkuDNoOG?=
 =?us-ascii?Q?Nv39F/7aY8GBUzX8nX1PHA5lHzQkc31C1MdQY5N5F7ah6+lA+XkaIn1heb9L?=
 =?us-ascii?Q?qoTREIsmuNb1rOvlxcFdzMS1lhKfsLKN/SBIvmxey3eGNayh6DabEwoxMiQT?=
 =?us-ascii?Q?+lmajHPcrqRMSQcwnRAR9BJCjSx9fRFK6GyMxXYohYBkIBzJ2XPUULVKbKty?=
 =?us-ascii?Q?z1yGHQIGUmOMEkdPvocLA8W2JDM5ckYl7YLngDUhxSCX0aek4BGtASaiExnW?=
 =?us-ascii?Q?dDaifFACx1xc+gurZw/L9V+XzkV97z5uZW0T3cKvzMkJbE79dBtTo8CZwnMG?=
 =?us-ascii?Q?BiqQY3Lz9wHsNVkj64SoGIx3eFyNl07o2opzY2ypijyrbgZwR1RXiaLBITuF?=
 =?us-ascii?Q?NhLLUdRJiGbypdmF1Z7oKC6WkUCnQnB2TCdxMKy7KEN7hFnx1Tfk6OwemyjO?=
 =?us-ascii?Q?xXpJVB1jzXYZyWI8JVMQfOD+sJaABaQCL7FkhAzkO4NwTcvzDebVhDAwnTSd?=
 =?us-ascii?Q?lEWDdL6qZepJP/3MRL6fx5d0MfKe/P/dWpRKpwXWINr4h2uXfhoVEeamDCk2?=
 =?us-ascii?Q?vojBmwSPyV/usLcP5PJQN7S1yc+Qn14ety+4a3jwDIfZ22+nwG3apRM0TypT?=
 =?us-ascii?Q?x5NS5jkCM8MZQfUGJqAPi9jjVFg823zc+PxqTPZuShaLwz9D6x/bHZ0UxeOd?=
 =?us-ascii?Q?wPMpSQxOy7xuZOvp+8oLDDeMe3EmIFwx/tsuy9MEAdpmsT6ChGk3ANq6CjaQ?=
 =?us-ascii?Q?6FjA3rE4ardmscoSEVkQdmW+dvMQpMFi9VjelNKr5IFNjBDhy4PlnfgrgjbR?=
 =?us-ascii?Q?HsqIifca1IxYBLXJUsJL3CQ4WWCd0BBEEQm0o4koCNohq1GUuLKDKt3Hxxl8?=
 =?us-ascii?Q?s+RfiR1ql1JaeZWFRunpVPusMbUKfz5IhaG528K2Y+pDdUMIzDaTQ+Ekr2uQ?=
 =?us-ascii?Q?qm9lLQrhTNCUSX69POCl9YZ969InLRXX5bpKSbqwIT+6i44dEHUefrq0L5Qn?=
 =?us-ascii?Q?SxhjqcaCq96FFpw2ztd9saXzuVz77CmaI56icfarPSk+E84Y0FoU03q0dSqU?=
 =?us-ascii?Q?xYP9IJflGtiikFpWvqInCT//ESg2ZOrTL8WAvQMS5XrVr1v5/XARGKrKLbt9?=
 =?us-ascii?Q?AYvvCHS8yw7gaZvP1v/EjHET+ryvu0kv/CjK4Wn6JglIIbEhRw3wOn+vdO2o?=
 =?us-ascii?Q?wrLMLwF6+uwrOO0SSNRGh3TwtHxmJR8HeGYaRMAHVH5JHTbekKSsy28UtBlh?=
 =?us-ascii?Q?H1uoYCGPQPB7Sr2m0eMdlc4ymQnDs1iwwGUglr2q7qJVfEGAf3NqEfiEnrLO?=
X-MS-Exchange-AntiSpam-MessageData-1: njcES0ScpxYd2od4lv1BJNS1YC2tPPskCeA=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c3dc3d-fab2-4901-5d3b-08df49bfc36d
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:27.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytyZO2JRMyBPkf3RrjeEFCASknF2pn7gd0IRV/HZg5eMttqh1TAVqLNdlWTHwms5Nii18q541hwxvGnK6LyfEkYwD0NoKlTGKHs1B0Ldg0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Add connman_service_tofu_certificate() for network drivers to report
the certificates seen on a TOFU probe connection. The probe is left to
fail by itself, so that none of its events can be taken for a failure
of the actual connection. The certificate is then pinned and the actual
connection is started against the pinned certificate.

A self-signed root CA is pinned together with a domain to match, so
server certificate renewals keep working. Without a domain to restrict
it to, the CA would trust every certificate it signed, in which case
the server certificate hash is pinned instead.

The pending Connect() reply is held back during the probe and answered
with the result of the actual connection. While the certificate is
being pinned the service is excluded from auto connect and further
Connect() calls are refused as in progress. Disconnect() cancels it:
nothing is pinned and the pending Connect() is aborted.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 include/service.h |  17 ++++
 src/service.c     | 242 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 258 insertions(+), 1 deletion(-)

diff --git a/include/service.h b/include/service.h
index f194422f..385e0c42 100644
--- a/include/service.h
+++ b/include/service.h
@@ -153,6 +153,23 @@ struct connman_service *connman_service_get_default(void);
 struct connman_service *connman_service_lookup_from_network(struct connman_network *network);
 struct connman_service *connman_service_lookup_from_identifier(const char* identifier);
 
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
+void connman_service_tofu_certificate(struct connman_service *service,
+				const struct connman_service_tofu_cert *cert);
+
 void connman_service_create_ip4config(struct connman_service *service,
 								int index);
 void connman_service_create_ip6config(struct connman_service *service,
diff --git a/src/service.c b/src/service.c
index 82d0a51b..8d9381ce 100644
--- a/src/service.c
+++ b/src/service.c
@@ -30,6 +30,7 @@
 #include <gdbus.h>
 #include <ctype.h>
 #include <stdint.h>
+#include <sys/stat.h>
 
 #include <connman/storage.h>
 #include <connman/setting.h>
@@ -139,6 +140,8 @@ struct online_check_state {
 	unsigned int failures;
 };
 
+struct tofu_request;
+
 struct connman_service {
 	int refcount;
 	char *identifier;
@@ -160,6 +163,7 @@ struct connman_service {
 	char *tofu_cert_hash;
 	char *tofu_ca_cert_file;
 	char *tofu_domain_match;
+	struct tofu_request *tofu_request;
 	struct timeval modified;
 	unsigned int order;
 	char *name;
@@ -253,6 +257,7 @@ static int start_online_check_if_connected(struct connman_service *service);
 static void set_error(struct connman_service *service,
 					enum connman_service_error error);
 static void clear_error(struct connman_service *service);
+static void tofu_request_free(struct tofu_request *req);
 
 struct find_data {
 	const char *path;
@@ -6950,6 +6955,9 @@ static bool is_ignore(struct connman_service *service)
 	if (service->ignore)
 		return true;
 
+	if (service->tofu_request)
+		return true;
+
 	if (service->state == CONNMAN_SERVICE_STATE_FAILURE)
 		return true;
 
@@ -7445,6 +7453,230 @@ static gboolean connect_timeout(gpointer user_data)
 	return FALSE;
 }
 
+/*
+ * Trust On First Use
+ *
+ * A service with TOFU enabled and no CA certificate or server certificate
+ * hash to verify the authentication server against first makes a probe
+ * connection: the server certificate is not verified and no password is
+ * sent, so the authentication is expected to fail. The certificate seen
+ * during that probe is pinned and the actual connection is made against
+ * the pinned certificate.
+ *
+ * The pending Connect() reply is kept back during the probe and answered
+ * by the actual connection, and the service is kept out of auto connect
+ * until a decision about the certificate has been made.
+ */
+struct tofu_request {
+	DBusMessage *pending;
+	enum connman_service_connect_reason reason;
+	bool is_ca;
+	char *hash;
+	char *subject;
+	char *ca_pem;
+	char *domain;
+	bool probe_done;
+	bool cancelled;
+	bool decided;
+	bool accepted;
+};
+
+static void tofu_request_free(struct tofu_request *req)
+{
+	if (req->pending)
+		connman_dbus_reply_pending(req->pending, ECONNABORTED, NULL);
+
+	g_free(req->hash);
+	g_free(req->subject);
+	g_free(req->ca_pem);
+	g_free(req->domain);
+	g_free(req);
+}
+
+static int tofu_store_pin(struct connman_service *service,
+						struct tofu_request *req)
+{
+	char *dir, *path;
+	int err = 0;
+
+	tofu_clear_pins(service);
+
+	if (!req->is_ca) {
+		service->tofu_cert_hash = g_strdup(req->hash);
+		goto save;
+	}
+
+	dir = g_strdup_printf("%s/%s", STORAGEDIR, service->identifier);
+	path = g_strdup_printf("%s/%s", dir, SERVICE_TOFU_CA_FILE);
+
+	if (g_mkdir_with_parents(dir, S_IRUSR | S_IWUSR | S_IXUSR) < 0 ||
+			!g_file_set_contents(path, req->ca_pem, -1, NULL)) {
+		connman_error("Failed to store TOFU CA certificate %s", path);
+		g_free(path);
+		err = -EIO;
+	} else {
+		service->tofu_ca_cert_file = path;
+		service->tofu_domain_match = g_strdup(req->domain);
+	}
+
+	g_free(dir);
+
+save:
+	service_save(service);
+
+	return err;
+}
+
+static void tofu_resolve(struct connman_service *service)
+{
+	struct tofu_request *req = service->tofu_request;
+	int err = req->cancelled ? -ECONNABORTED : -ECONNREFUSED;
+
+	service->tofu_request = NULL;
+
+	if (req->accepted)
+		err = tofu_store_pin(service, req);
+
+	if (err < 0) {
+		connman_dbus_reply_pending(req->pending, -err, NULL);
+		req->pending = NULL;
+
+		/*
+		 * Keep the service in failure state, so it is not auto
+		 * connected again, until the user connects it. When the user
+		 * disconnected, the probe failure is not of interest.
+		 */
+		if (req->cancelled) {
+			__connman_service_clear_error(service);
+			clear_error(service);
+		} else {
+			service->connect_reason =
+				CONNMAN_SERVICE_CONNECT_REASON_AUTO;
+			if (service->state == CONNMAN_SERVICE_STATE_FAILURE)
+				set_error(service,
+					CONNMAN_SERVICE_ERROR_AUTH_FAILED);
+			else
+				__connman_service_indicate_error(service,
+					CONNMAN_SERVICE_ERROR_AUTH_FAILED);
+		}
+
+		tofu_request_free(req);
+		return;
+	}
+
+	connman_info("TOFU: pinned %s certificate %s for %s",
+			req->is_ca ? "CA" : "server", req->hash,
+			service->identifier);
+
+	service->pending = req->pending;
+	req->pending = NULL;
+
+	err = __connman_service_connect(service, req->reason);
+	if (err != -EINPROGRESS)
+		reply_pending(service, -err);
+
+	tofu_request_free(req);
+}
+
+static void tofu_decide(struct connman_service *service)
+{
+	struct tofu_request *req = service->tofu_request;
+
+	connman_info("TOFU: accepting %s certificate %s for %s without "
+			"verification", req->is_ca ? "CA" : "server",
+			req->hash, service->identifier);
+
+	req->decided = true;
+	req->accepted = true;
+}
+
+static gboolean tofu_probe_finished(gpointer user_data)
+{
+	struct connman_service *service = user_data;
+
+	if (service->tofu_request) {
+		if (service->tofu_request->cancelled)
+			service->tofu_request->decided = true;
+		else if (!service->tofu_request->decided)
+			tofu_decide(service);
+
+		if (service->tofu_request && service->tofu_request->decided)
+			tofu_resolve(service);
+	}
+
+	connman_service_unref(service);
+
+	return FALSE;
+}
+
+/*
+ * The probe is left to fail by itself rather than being disconnected:
+ * only then is it certain that no events of the probe are still on
+ * their way, which would otherwise be taken for a failure of the actual
+ * connection.
+ */
+static void tofu_check_probe(struct connman_service *service)
+{
+	if (!service->tofu_request || service->tofu_request->probe_done)
+		return;
+
+	/* Even though no password was sent the probe could succeed */
+	if (is_connected(service->state)) {
+		__connman_service_disconnect(service);
+		return;
+	}
+
+	if (is_connecting(service->state))
+		return;
+
+	service->tofu_request->probe_done = true;
+	g_idle_add(tofu_probe_finished, connman_service_ref(service));
+}
+
+void connman_service_tofu_certificate(struct connman_service *service,
+				const struct connman_service_tofu_cert *cert)
+{
+	struct tofu_request *req;
+	const char *domain;
+
+	if (!service || !service->tofu || !cert || !cert->hash ||
+			service->tofu_request)
+		return;
+
+	req = g_new0(struct tofu_request, 1);
+
+	/*
+	 * Prefer pinning a self-signed root CA, which survives server
+	 * certificate renewals, but only together with a domain: the CA
+	 * alone would trust every certificate it signed.
+	 */
+	domain = service->domain_match ? NULL : cert->domain;
+	if (cert->ca_pem && cert->ca_hash &&
+			(service->domain_match || domain)) {
+		req->is_ca = true;
+		req->hash = g_strdup(cert->ca_hash);
+		req->subject = g_strdup(cert->ca_subject);
+		req->ca_pem = g_strdup(cert->ca_pem);
+		req->domain = g_strdup(domain);
+	} else {
+		req->hash = g_strdup(cert->hash);
+		req->subject = g_strdup(cert->subject);
+	}
+
+	connman_info("TOFU: probe of %s found %s certificate %s (%s)",
+			service->identifier, req->is_ca ? "CA" : "server",
+			req->hash, req->subject ? req->subject : "");
+
+	req->pending = service->pending;
+	service->pending = NULL;
+
+	/* The probe is expected to fail, do not report that as an error */
+	req->reason = service->connect_reason;
+	service->connect_reason = CONNMAN_SERVICE_CONNECT_REASON_AUTO;
+
+	service->tofu_request = req;
+}
+
 static DBusMessage *connect_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -7455,7 +7687,7 @@ static DBusMessage *connect_service(DBusConnection *conn,
 	DBG("service %p", service);
 
 	/* Hidden services do not keep the pending msg, check it from agent */
-	if (service->pending || (service->hidden &&
+	if (service->pending || service->tofu_request || (service->hidden &&
 				__connman_agent_is_request_pending(service,
 						dbus_message_get_sender(msg))))
 		return __connman_error_in_progress(msg);
@@ -7505,6 +7737,10 @@ static DBusMessage *disconnect_service(DBusConnection *conn,
 
 	service->ignore = true;
 
+	/* Do not pin a certificate the user is no longer connecting for */
+	if (service->tofu_request)
+		service->tofu_request->cancelled = true;
+
 	err = __connman_service_disconnect(service);
 	if (err < 0 && err != -EINPROGRESS)
 		return __connman_error_failed(msg, -err);
@@ -8198,6 +8434,8 @@ static void service_free(gpointer user_data)
 	g_free(service->config_file);
 	g_free(service->config_entry);
 	tofu_clear_pins(service);
+	if (service->tofu_request)
+		tofu_request_free(service->tofu_request);
 
 	if (service->stats.timer)
 		g_timer_destroy(service->stats.timer);
@@ -9544,6 +9782,8 @@ notifier:
 		DEFAULT_CHANGED();
 	}
 
+	tofu_check_probe(service);
+
 	return 0;
 }
 
-- 
2.56.1

