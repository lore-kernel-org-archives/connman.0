Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479205;
	b=odMAygfv0va3zQNJD0GkqKV1YLIIOp1Ipi8r8GXD4BFCh3rK947q3R+AxhQOtQrK272X
	 JaaUDDvMb7lnYI7aL/pNbAnzB9KoeyD9HehNql5dKsi2fcJMdJ0dEvHLr97jt28l8jkiw
	 9xRGJTeeuRNqVXRz4hUhjXm1mAf6Yf+nSjuQDQvQA3XrPRzTRJXe60J1Bdu+krn7U08kY
	 7mbw6aZKq71iCVNeQYtJBiWJXz1jRsdjT/icfd9pAinSx8coF/FUYgH4GB5gJM7j2HrMN
	 evz/XFPjnZzb0iex81Rb1E7mttTzLmSw4ZJE0UubytgcdHto8ftZa94GHiDyZn0KncQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479205;
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
	bh=69X+f0RqMqVrZ3jEUxwWdULNeyiq1SdVTnQiAg9qmkA=;
	b=ZxnVJ8ABce0GnP5gLyAsMqRvQLGUlBekFPKzZMfjEOrAoqSf+1y5350SCm+Zfs+v5DVE
	 unXTzntkeJTCsg4gsW/rmFClFex8Xr0kNiX7XUt9KQyo42qMkkaY1Geu1pkWoFCGG4v7I
	 /GpUxkq4yDzCLfwvesd4INgdVhaIhbpOmAQmYx2iDjePlH/o8AJiYwxyiMeH+9agnrUy0
	 ow08XS62sU3kX3tcrZQhU09H5T4Krf6soDqqZNn+nGrIHoceE5k067n6Tx7GiIMstNd6X
	 ktNf3MGDZx6L7+WIvamKatkd8Uq0EyGXwS0xpz50GVoUPF8F0mtkVWVszIQtnPZqHLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=IVVMpCfk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA763606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA763606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=IVVMpCfk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmKdWGFHIsMUxbnTeNSqEEaTv+eG6cjwEEcOkyWsHL1qo0/Lx3AT6Binw4f0d9+qEipQ0OWCnuz5b9JH54/miFoWwzV0riRlh7FktNAsLDLNQ1JQMtlhli8GkENH67XdnX2zleuIAaAh29DitSg9UWqTWXJvzbina2F87HG+6J7VNdUa2akB568seCXiGhJS1t4JMeiazdtOzzL+lV9B7w9oqywWuQ6ayEarXsz+kds/t666NlBojxYVmle003L3u6RB0ws3fnzdd60S8DB00gMHnslkR8kGYc5+u+OuSQ7BcMtOMEXH0TCYs8HcGpHXdGX2BkxVSmSplz+SBHAZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69X+f0RqMqVrZ3jEUxwWdULNeyiq1SdVTnQiAg9qmkA=;
 b=E39BaTphT7LKHH4uInO9EDn71j5ElABpwDupPW26dshlmMBTXdQtP8QDy6keOAL6CmDmT7M912uqw24q0VtQo/5zXX11l7eFG0zStmaneFdbJUbwZHokT3De6cR4gQxznYexT0zgX3EeNNhhybbC5SajUJDKdQuQ0urgCQyCqVciWWUHf7sWaTcsyKLKwKNlXH8O35Ri9LGXYmmG8t3DKucHonwkzvq9IHE9kAVSgtGUQFc0OsxVfoYrp/CUHADfp5FMRaJSMmMiLlChN0wddej3n+rH+MDiJmyJIoDFq+knRPI5MLd5/Qf6QawYIEmr8fiU4p5Gm7qjSqKU1VNUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69X+f0RqMqVrZ3jEUxwWdULNeyiq1SdVTnQiAg9qmkA=;
 b=IVVMpCfkJWq5Rq8Qeq8sNlDlutlNnjHA6M3SVg+LA3tjFxoLvHE9J60sSFXW1TA4IzLoK/rS07CZCT/WrE1yhSh9P4GKtbuPkmOjofU6HtXPMh65qSdl6SIU7jH1Hu4WH7niUaFtbr+Or48b8ieQvopVRC0Aq92NH2p11ORcPbw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:21 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:21 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 03/15] service: Add ServerCertHash option for EAP networks
Date: Tue, 24 Nov 2026 01:12:59 +0100
Message-ID: <20261124001311.1161845-4-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 06201949-e2ea-4f53-bdc4-08df49bfbf86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261022075727099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	YsTv6NuQmShSz+zMSeaB8Uj0zRPYHbjrjqdkNgex/4g9gBgtUZ6v9IgIJZQDaC38buLFVrh5q0nBc8vRLF4dYzO70FxkowafXLp0+ot0ByPmNT4KSSYcHjDFeAarqS7jipNEFSL+qZaAXvmbMVN/iOw4hHPtKosQHKEAIrDUvYFuYFBSNA7faLH8MyyYPqPghPkZftLhPQjFdnawYHjw/Ii10GHbHxGgHT6vEkKorb7AUU7quBl1S1qpa/JSgNzsDnDQiDbOCCRAD4638nS9WBWZmC/+iGAH8dtzdlffolnSDWx3vvFB36cOi36ZRxSKVy26GfV0IPtQ6Xg7fymORVixekyI+ayzxwGjN6VySOyKfLG7Ea784asDsLT9vq5wB3oij9qqmtaRKFJg7H8WSlSe3ofbaB6TJEqZL4SfGpU1Ur6KgogOKaFUfcOt5s2Zu4wV3gx2FnFUpDSvmoGmZaXCXJ3WOjKI3wA56NSMXe4vUmi0mjfS2FjscxhKJmiFOdXfzQ+XAsMUFZPLqFOZLFhWg9Es8YcIF3vNwxClwbQfp1MOhax5QFi7feM3ENil6RdaxYNlp0KbpwHESONWYyrCgFHNsANGlFlgkhZIv1nsQRJLASJgPpW9nW2eDMTzUXCZbRXGOV+TQ+UDDGvZKRicuyOT3F0U8XUSVt8nxmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261022075727099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IG0xgH3up6zuL806NkRqjPQTt6EGrjgUoFKpI0+egeVXEwivGxoLAwwnN6SB?=
 =?us-ascii?Q?do7M0KlnwSUjG/iOrv+EsEgY8zTt/EcbUWEgv+6Ig/Y3z8pePImkxiOgokbR?=
 =?us-ascii?Q?mZ9pmhoDF4D4lZYiNjAS3KILJEf2sbavgINN9seNgoS6pP2qivgDLLbsodSP?=
 =?us-ascii?Q?aZwrQEBrlfAUoiJWwCqOQ9m/jH92uJV4nQ2JWNgqlrUdbmFfgN1DHll9iWnt?=
 =?us-ascii?Q?2dHAfdAD2qntHHySF4KjtxjKCRAlfDhMzYjWjjKZgp05cHVZsshnPc9gwkn8?=
 =?us-ascii?Q?E03z56OLnHQPpqg6IlzP/iQ8OVcQdqvqyUFs4lbHjhffScvYZwSPLr5dMNXh?=
 =?us-ascii?Q?rUmieKqQifQ0UtOn72lQBu6H8yNZSgPawHyTEKTY5NibSf0qEdFobPkP5NH3?=
 =?us-ascii?Q?GfQfTQnLGzDdhpdtBI+siaaP9Io0lJX0AWoRR4wBGldNojy7GYdA9+/lOsGt?=
 =?us-ascii?Q?Pn+LkqKtriLXOzzE0PXilRBaaIqH3i6X1yRUAZKUhR1vxeq7a1E77F+l4YBu?=
 =?us-ascii?Q?bbVAlhkQH/glX+lMWOUZG2qc1QTHBizMLC5O/nepRyz3ij4nzFAJPCaVExtR?=
 =?us-ascii?Q?mABEY4IzYvLIdmAsyGlbjBoHMNW1cLzj5cvMw9I/nE5K4l4Xjt60yS042Uuo?=
 =?us-ascii?Q?LKk9miWmZhUBpvSlHG/uQ+2KusRKrTFSm4/xgubf3V/FJjiU6qVPYanWQbEf?=
 =?us-ascii?Q?01FZVlS+wbFQYI+n5GM9Mytj34ZbIT1wRakBaH+gQrxU4kxJSFO8srTIlfi/?=
 =?us-ascii?Q?cBjTBXYtrA0rTOFiOtAe9ptPMWEIM2q8HsnbiYbs9VT8H68FPpKBV3VARUMG?=
 =?us-ascii?Q?En4U8Uql7nb1hVaBfYqis9Js4aL/hSp4clwFs6Yau031/bMOSu/F2Mh3+dNo?=
 =?us-ascii?Q?MFJYa3v+z6Ih0w9cq0SwANW9LNJ8X0B7Ap4LjqfMa1p/3CinRX0Dgj4YMiUw?=
 =?us-ascii?Q?z2B7Pe45H+eIIVbZr/jAMvRkEixOgnHULnZ9Uedbr6CwCnF7VZldYEcV+Q3r?=
 =?us-ascii?Q?ADGp94GwrLGe3mEAr2l6U/bHDW2EuEMgVVeLVJfNt7SovD25h7EysPSSqlmu?=
 =?us-ascii?Q?z7wfZtmCdrdshWg1Y21xLjD2IjyJJ/ePv0Iw+N6wTBiUOyiEXoa+JDFNBadl?=
 =?us-ascii?Q?dAE/oMW13H2v+ztrgJALxobp8FQqy0LxsSeq6bX/EWo4AvNqYW1/qa2dJWdH?=
 =?us-ascii?Q?+Mbz4fS4pUJnXLlpeS3ckr3O6Iag26GgfOTuvEhCXRW8WgB22VT05r0wWiPc?=
 =?us-ascii?Q?mLf4C5uSfEhJA0q3YLcPXuKjfNweq0g9jjUZB8w1RaWYkETA5sg06avN8GhC?=
 =?us-ascii?Q?Cy28yjqXVfTlQ3bbkTZ/CdDUQHRrQ/2Xq+VaGc+bgIz+eOhgA3Y9EclUChHw?=
 =?us-ascii?Q?DVwdmPj0h7KgjRq+XdHnN7imLk8VDqSjkuCVaaKkIp/nh0ShQEkLtKdBkaRQ?=
 =?us-ascii?Q?ZWNQjWaTTjK5oAXjDua4FUHe0Hmm7F7/UM/KBySzKRq4XZhSifPaZM4RK6XP?=
 =?us-ascii?Q?JMGZIaKdhSagnI3Ots4t1m+Y4Kpd5juBgPMa3gX13/rqBTOYU16aDepa+xNB?=
 =?us-ascii?Q?QJmYHsL+kEWuwekwIbgiN9jMeySNZX4YTTpF0hrU8R2r4XQTTkKmCDtxHuFv?=
 =?us-ascii?Q?WpnFS9KO+0r8MoH4YHNCtBmwLHuIaN5LQqEZFVCedHiCw1R4iPsv4N8LEmzO?=
 =?us-ascii?Q?OwKwD/9bvWHA2RyXq4OeVs9F/jhOTMNY+RE+6IcZ3EzisA1pgpUreWHqBatg?=
 =?us-ascii?Q?kX+PGl6710NzwDUwXFYTZ9uUcwA2x1NtLnr+zuJEAhL7bo+Kc45h/lsdv0CK?=
X-MS-Exchange-AntiSpam-MessageData-1: RFZw1z6nLepg/+Px6cT8hDcHYa5PYBbMttM=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 06201949-e2ea-4f53-bdc4-08df49bfbf86
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:21.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY3/VmyYgIBMf3VUKMoy6hpzwPWiYCuF+MyFjLWlp/BQymODl4wjBTkZMLA5g/Svg3dMPwdT1+gc8rkFYhuMbANdEbDlwQOKsjtv1sdJc74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Add a ServerCertHash provisioning option that pins the authentication
server by the SHA-256 hash of its certificate, written as 32 colon
separated hex pairs. It allows verifying a server with a self-signed
or otherwise unavailable certificate without disabling validation.
Setting it together with CACertFile is rejected, as both pin the
authentication server.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 src/config.c  | 30 ++++++++++++++++++++++++++++++
 src/connman.h |  1 +
 src/network.c |  7 +++++++
 src/service.c | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/src/config.c b/src/config.c
index d2832187..2b0efcab 100644
--- a/src/config.c
+++ b/src/config.c
@@ -47,6 +47,7 @@ struct connman_config_service {
 	char *identity;
 	char *anonymous_identity;
 	char *ca_cert_file;
+	char *server_cert_hash;
 	char *subject_match;
 	char *altsubject_match;
 	char *domain_suffix_match;
@@ -100,6 +101,7 @@ static bool cleanup = false;
 #define SERVICE_KEY_SSID               "SSID"
 #define SERVICE_KEY_EAP                "EAP"
 #define SERVICE_KEY_CA_CERT            "CACertFile"
+#define SERVICE_KEY_SERVER_CERT_HASH   "ServerCertHash"
 #define SERVICE_KEY_CL_CERT            "ClientCertFile"
 #define SERVICE_KEY_PRV_KEY            "PrivateKeyFile"
 #define SERVICE_KEY_PRV_KEY_PASS       "PrivateKeyPassphrase"
@@ -138,6 +140,7 @@ static const char *service_possible_keys[] = {
 	SERVICE_KEY_SSID,
 	SERVICE_KEY_EAP,
 	SERVICE_KEY_CA_CERT,
+	SERVICE_KEY_SERVER_CERT_HASH,
 	SERVICE_KEY_CL_CERT,
 	SERVICE_KEY_PRV_KEY,
 	SERVICE_KEY_PRV_KEY_PASS,
@@ -243,6 +246,7 @@ free_only:
 	g_free(config_service->identity);
 	g_free(config_service->anonymous_identity);
 	g_free(config_service->ca_cert_file);
+	g_free(config_service->server_cert_hash);
 	g_free(config_service->subject_match);
 	g_free(config_service->altsubject_match);
 	g_free(config_service->domain_suffix_match);
@@ -660,6 +664,28 @@ static bool load_service(GKeyFile *keyfile, const char *group,
 		service->ca_cert_file = str;
 	}
 
+	str = __connman_config_get_string(keyfile, group,
+					SERVICE_KEY_SERVER_CERT_HASH, NULL);
+	if (str) {
+		if (!__connman_service_server_cert_hash_valid(str)) {
+			connman_warn("Invalid %s %s for %s",
+					SERVICE_KEY_SERVER_CERT_HASH, str,
+					group);
+			g_free(str);
+			goto err;
+		}
+
+		g_free(service->server_cert_hash);
+		service->server_cert_hash = str;
+	}
+
+	if (service->ca_cert_file && service->server_cert_hash) {
+		connman_warn("%s and %s are mutually exclusive in %s",
+				SERVICE_KEY_CA_CERT,
+				SERVICE_KEY_SERVER_CERT_HASH, group);
+		goto err;
+	}
+
 	str = __connman_config_get_string(keyfile, group, SERVICE_KEY_CL_CERT, NULL);
 	if (str) {
 		g_free(service->client_cert_file);
@@ -1126,6 +1152,10 @@ static void provision_service_wifi(struct connman_config_service *config,
 		__connman_service_set_string(service, "CACertFile",
 							config->ca_cert_file);
 
+	if (config->server_cert_hash)
+		__connman_service_set_string(service, "ServerCertHash",
+							config->server_cert_hash);
+
 	if (config->subject_match)
 		__connman_service_set_string(service, "SubjectMatch",
 							config->subject_match);
diff --git a/src/connman.h b/src/connman.h
index 7ebda7af..f019a952 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -846,6 +846,7 @@ void __connman_service_set_split_routing(struct connman_service *service,
 void __connman_service_split_routing_changed(struct connman_service *service);
 int __connman_service_get_index(const struct connman_service *service);
 void __connman_service_set_hidden(struct connman_service *service);
+bool __connman_service_server_cert_hash_valid(const char *value);
 void __connman_service_set_hostname(struct connman_service *service,
 						const char *hostname);
 const char *__connman_service_get_hostname(const struct connman_service *service);
diff --git a/src/network.c b/src/network.c
index 416a7e74..678cb587 100644
--- a/src/network.c
+++ b/src/network.c
@@ -94,6 +94,7 @@ struct connman_network {
 		char *anonymous_identity;
 		char *agent_identity;
 		char *ca_cert_path;
+		char *server_cert_hash;
 		char *subject_match;
 		char *altsubject_match;
 		char *domain_suffix_match;
@@ -1232,6 +1233,7 @@ static void network_destruct(struct connman_network *network)
 	g_free(network->wifi.anonymous_identity);
 	g_free(network->wifi.agent_identity);
 	g_free(network->wifi.ca_cert_path);
+	g_free(network->wifi.server_cert_hash);
 	g_free(network->wifi.subject_match);
 	g_free(network->wifi.altsubject_match);
 	g_free(network->wifi.domain_suffix_match);
@@ -2177,6 +2179,9 @@ int connman_network_set_string(struct connman_network *network,
 	} else if (g_str_equal(key, "WiFi.CACertFile")) {
 		g_free(network->wifi.ca_cert_path);
 		network->wifi.ca_cert_path = g_strdup(value);
+	} else if (g_str_equal(key, "WiFi.ServerCertHash")) {
+		g_free(network->wifi.server_cert_hash);
+		network->wifi.server_cert_hash = g_strdup(value);
 	} else if (g_str_equal(key, "WiFi.SubjectMatch")) {
 		g_free(network->wifi.subject_match);
 		network->wifi.subject_match = g_strdup(value);
@@ -2243,6 +2248,8 @@ const char *connman_network_get_string(struct connman_network *network,
 		return network->wifi.agent_identity;
 	else if (g_str_equal(key, "WiFi.CACertFile"))
 		return network->wifi.ca_cert_path;
+	else if (g_str_equal(key, "WiFi.ServerCertHash"))
+		return network->wifi.server_cert_hash;
 	else if (g_str_equal(key, "WiFi.SubjectMatch"))
 		return network->wifi.subject_match;
 	else if (g_str_equal(key, "WiFi.AltSubjectMatch"))
diff --git a/src/service.c b/src/service.c
index d5869b14..f6efa01a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -182,6 +182,7 @@ struct connman_service {
 	char *anonymous_identity;
 	char *agent_identity;
 	char *ca_cert_file;
+	char *server_cert_hash;
 	char *subject_match;
 	char *altsubject_match;
 	char *domain_suffix_match;
@@ -5492,6 +5493,29 @@ void __connman_service_set_hidden(struct connman_service *service)
 	service->hidden_service = true;
 }
 
+/* SHA-256 hash as 32 colon separated hex pairs, e.g. "AA:BB:...:FF" */
+bool __connman_service_server_cert_hash_valid(const char *value)
+{
+	size_t len, i;
+
+	if (!value)
+		return false;
+
+	len = strlen(value);
+	if (len != 32 * 3 - 1)
+		return false;
+
+	for (i = 0; i < len; i++) {
+		if (i % 3 == 2) {
+			if (value[i] != ':')
+				return false;
+		} else if (!g_ascii_isxdigit(value[i]))
+			return false;
+	}
+
+	return true;
+}
+
 void __connman_service_set_hostname(struct connman_service *service,
 						const char *hostname)
 {
@@ -8095,6 +8119,7 @@ static void service_free(gpointer user_data)
 	g_free(service->anonymous_identity);
 	g_free(service->agent_identity);
 	g_free(service->ca_cert_file);
+	g_free(service->server_cert_hash);
 	g_free(service->subject_match);
 	g_free(service->altsubject_match);
 	g_free(service->domain_suffix_match);
@@ -8900,6 +8925,14 @@ void __connman_service_set_string(struct connman_service *service,
 	} else if (g_str_equal(key, "CACertFile")) {
 		g_free(service->ca_cert_file);
 		service->ca_cert_file = g_strdup(value);
+	} else if (g_str_equal(key, "ServerCertHash")) {
+		g_free(service->server_cert_hash);
+		service->server_cert_hash = NULL;
+
+		if (__connman_service_server_cert_hash_valid(value))
+			service->server_cert_hash = g_ascii_strup(value, -1);
+		else if (value)
+			connman_warn("Invalid ServerCertHash %s", value);
 	} else if (g_str_equal(key, "SubjectMatch")) {
 		g_free(service->subject_match);
 		service->subject_match = g_strdup(value);
@@ -9763,6 +9796,9 @@ static void prepare_8021x(struct connman_service *service)
 		connman_network_set_string(service->network, "WiFi.CACertFile",
 							service->ca_cert_file);
 
+	connman_network_set_string(service->network, "WiFi.ServerCertHash",
+						service->server_cert_hash);
+
 	if (service->subject_match)
 		connman_network_set_string(service->network, "WiFi.SubjectMatch",
 							service->subject_match);
-- 
2.56.1

