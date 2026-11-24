Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479209;
	b=jy1sxycs11xbrJRfQ0BWOCqhQF5jHC/BtWms7ypFzlCuXd5AaGBix70lPdEy7qpS2rcc
	 Gnly91L2UfVOReT+Zj3b5KxfOsLo0cQIbpqURFYgBSsIVyqnu0b1rH8GEkGNFi32Ojuw2
	 CCRRIeIBAqqpT2zPLLWI0lHtiWRKD/qre7xIk5e7Gzk/ujXHHe3rZ3ridQCT99zllkT1h
	 jd6CyunmY+lCHOm6VQAc2ZGyJ2rtynYEsLseLJBESN52mwt++0vsVQXDIhryf0SMEiGkt
	 o4sjG7+J97jV0aJcoTicF40EhetQmZA9poEtzxrk9jpQEU14rxBrGIuzv13y7LC36cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479209;
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
	bh=mJImSN+tFTWYNzJia2guFVyHuCCkG8gSJkv9ZO59QjQ=;
	b=nFT4Q4d89w7x6VrLTuVkQFavR/8WKuGy1kp05esiPjdAtnXDlgC9Sy1Bg86r22Gptrpz
	 O5zAtERfKMxqbS7oKN5f8jOQ3MFwKG8C8neySa8K8v1wfdn575d+VhSClfhrE76y4SUN9
	 PKQiDuNtQHD1CTUU9ukN21kZ6Tz47VRtbNhz9QfB1mqqnxpJUFySS9Azio8Rc2D5Luk64
	 k6qOsNpu6dBnV6ZFpLSSq992QXTgHWNj0F9v2pga73sYAEj9Uo+9dxehz/8IhUKnoctWG
	 qDwZXkVFbhqVMz4Ijs0UtmskPBhLhl2CLThivBecM8X7OciDSglhlyWboHqfsTxMRag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=nkzQVFU0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0F606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DE0F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=nkzQVFU0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w59TyoOlt+DoPOmkf34yrD7GpLkqSL5amViEBfbBs5gBpAQP7TK28bY6t5mqO42g+jLuxpIcWMrmd97CmjWaBT79xp5OYZJwXo1BkdF5OALaSnPYBdiIPa6udelHbWTPiTdqujPiNy0QKOZT+YxflM+sgUpi+JMRrcLuOJvhLQyLMBDznYDZWF6zy0CSZMqHkaZQRXi6iLZKJLYtdyHm2e09wWRiNMYoLvaA/5+SKNTsuPtmy+B+na2tzbsc8NFztjeD7SCcngJKjRXPLMrfptgBj/rTjqsoh3xCE9fXz7giLqlpNl1VOBUTZaghTDZO/HBtp37HCXa0k1uvXKQIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJImSN+tFTWYNzJia2guFVyHuCCkG8gSJkv9ZO59QjQ=;
 b=be5wS0mqE+WHms1FeJ7RtNIczdChwndNIu72ShKe6UujpFw5n5YWsikEQyXcE3VnlI/AG01Rl1j5BEFU4+JRv87Md5mw2LWm0StdiG3hFkOHshmOSLMPWEnxyaWPs/pIX1c1by0dRLwvAQYQ4TmqVG3EBY7A+WgUWT9v5VLx5T/zTH/k/0YuUUnIVRxVn0zemFJgcfZKDY6ipi4JcBBqOgnPs3Y5Yf2hjb1bPFStPJVZbFw5HVc3JPfDdJ7lT/7MRDeJUnIFrrGvljgPVw+8zrEb4JhuX419/IWGVsXRaO011Vwr2odeCcv2WkUtgj2W4nJ9lKm5yOqGNG16vMklgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJImSN+tFTWYNzJia2guFVyHuCCkG8gSJkv9ZO59QjQ=;
 b=nkzQVFU0+kI8VUuXq9qdQRR3ITqh+kJTBekZgYSWXNweg7xcIeomM6ySXGcFA7WaliRZcoIpKlPx6uFyFx6+Ozm6Yk0aJtZQRQzVsqks8sJAEzvEMOV4HBh85uB9FqnYTdr/H7fxF92N2qpiku7149V+OxcpjYnNDLQuTCvD4Fc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:26 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:26 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 07/15] service: Add TOFU option for EAP networks
Date: Tue, 24 Nov 2026 01:13:03 +0100
Message-ID: <20261124001311.1161845-8-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::13) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 5ee9189f-5f5f-46fc-81c5-08df49bfc2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261021123027099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	oUD/fb6liaTt0xDE4sa8S9VGUlhkRSs8bTtUMcLsc+ZIJjSpF+6An2rrqiCa5WOjXMHsRXON1OVXCKpjUxtkwbyQjrusisMkdQ8olIAtWmXUj7FpHN9whvpGattscC5KtQcMQEIsoNDDm1vSigXFAIKSUDW9gcf22PJ8X2LGZwycTd+kkVSqmhGTPmUI5b55WD7oD/Uv35PXo6YM6wq7R+3s90G+ezntykYxXZjDjkKI0ULXByBL4KdJbLchj9sylYkCVBh54x6NkgKP3o4jDS7gDSq8lCdY3PkQeGdDI6cbv7XQSvdfrLaYJGuTmrS8PFEH3WSIxtVwqlAFL55HFmddMxAFToyRciL7O3DcabyaVCGye2ABk50j3FlqjcbQUa1LKAFgPjdjGuQ1AjSCHD/ivI2SkAbuJQWC4ezGsJk8pak0ayv5Om869fSvk7kpvuwHZB3F8893v1PeirePqmlaxtaIh3UC4+H6EAeixGlQCQBlH8Uh1Ui5j+O4SpAmOO738yYMb+7MsuFJUb2VuP8l1M14082Gi/kAOFFbh5nrrD8TPkm2Yp0CoO00CIGsuPd083UYy1QzjfMcwhK5Qcq4SSwezp8Ay3g6VZhip4D9yZxCLIEfkVKxfTc0SROp94dCZW1u1F3CyrI3wXrm+6Nq1RuOrVn2QzV3+kmLXdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261021123027099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xxh/w2E24F3JND17hs/3bv+en8pHBVLGYHauxH/Qj5fkqX3TuKVZOvvLDfZE?=
 =?us-ascii?Q?CjOwkNW0MKf/W8RzCwm9xh2dzq3Y8hPgbPSzaKwC4xL9vVDPE7/DlKkBZ76n?=
 =?us-ascii?Q?AZRiUronItGMZFYHe//aeMsKc75p1fHaV/ZT+gK0x8yeffBTFM5arGFav9x0?=
 =?us-ascii?Q?/KItNnq5gcKDPLoGRfv6GQwLZnEs/HKqHCf+C4PdKM/S5cAsKWRLNKVCFywX?=
 =?us-ascii?Q?FMv7DJ6uMIYwHm3WwrWCoepTkUtw/2KY+h8P6rb8RxyPg12+juQZpfe4Ieuk?=
 =?us-ascii?Q?sgLhULsQUwEj517459+NWRRH3ho8Bo9U/OyFr2KpmSGkvp5/ksyerQqKNL86?=
 =?us-ascii?Q?ZQ5kS3rIDXFWQiskvYjZbU4W1IGWKtYgX4q1xx/LpZUJh3k0CcAoo/7BX6eu?=
 =?us-ascii?Q?6yYnsj98u1gjxVqjuA9tNMZoM087UdIzef8JKf4ZWqgEzjgccUl19Zkvl8gV?=
 =?us-ascii?Q?dulXrIQPudVHT6hC4JJCUJqk/wFe73T4g1hrMBZ5jIkjn8Zdg2efqkEyGwbz?=
 =?us-ascii?Q?czGX3zCzzEuWDBoOuvEtRYfOpe0gGg4WgIbPFeZFz0OKSTHYknO9O1JgrHRZ?=
 =?us-ascii?Q?+NIGGjP9S/W5kTwAthjhr7X9oRm7Ph1t0OyWx8hyJCrya5pRtC99OWs7vVHD?=
 =?us-ascii?Q?y9pG5PdwGBCVRZxub5BdW/NfQsSOFK51uD4HPDyQZbDljHzpMDWjp+/qNmQ8?=
 =?us-ascii?Q?mnhBtoNOTg2bfRZWdur4ODgRyYWk8KAyc7GN82+xBoh6r94dr9xQ4zz9epBH?=
 =?us-ascii?Q?vv5hedDFHtAoKp2Xq+bNZx4GqfQEz9GfkoPB+nGitbc529Wv2gP4fj814HVk?=
 =?us-ascii?Q?IF7f073dB7jJtn5thLZyos9do5tovw5RZGBAOLiHd0lTrvhMoOqh43dks3VI?=
 =?us-ascii?Q?vdoZQZyyUPiC18hWhRwDQzCa8vdTVvyXqpJsGBhAMuGgL+EvKewJjoqUsXyO?=
 =?us-ascii?Q?gnBH7yeWUDfDcGZM6M59aQofnEuP/5MGFnyE7LeODau0n+1QxI6mGftp0/9H?=
 =?us-ascii?Q?SJsaGk44ZMOdOYuZCaBw76teQO4EtMkL+cgSWrRRS6qxN8h/nhK6FKgIhp8C?=
 =?us-ascii?Q?tuTFDcfFUIUmn30+3gwF7BoovE4/KKQPiFibUi5K/CZe5BG/mb1PHtAgBNki?=
 =?us-ascii?Q?OTK8vaIwWsAOZkV0Efj5BUjncooVoL/Dhb8Zz15Xuj+RO9sxRECaoJ4d9yx3?=
 =?us-ascii?Q?Ps+Nn11aKa1MlIRSipiWl91AygsJeWrdNMWQBz26FAKkrsZSXvoLDFTa0zE0?=
 =?us-ascii?Q?LASpDV7bVETrAAylCKKwHKZQ5To8GLFeWiDVwz+LTFOmXW8AFmUaegESQRqY?=
 =?us-ascii?Q?2GgWMH91svemQZ4ktIHBhQ/41C1vUgM2X51fXljR+Efrj6LB1L4W+G+aIWqP?=
 =?us-ascii?Q?YLWcPfWcdzum+3D7SQOWQaVh9Ns+zeJ/ukNtpzSJ/W5VrS5S8xORizMHwUyC?=
 =?us-ascii?Q?bHz1zd6U38qF4U/F/XpjRPe08/uXi/jaEXEDgCRuXVjHdiG75Oa7FCkYcUGe?=
 =?us-ascii?Q?ssSpZ5JrGbNU5Yv2F+YntEgKxsiyMVYWUFWBml3EaRnegxPEqOuREs6765et?=
 =?us-ascii?Q?UgzawJEy0dxiHhczXKuoBgjmkr+MbILQJIarrRDktQN2Ga/XEoB/54hX6GbO?=
 =?us-ascii?Q?mDR8bF8EdvEJHaIbM0irUsKKOMr6sYycaf8iPyeHaogosbMwkskBy/nAJhHq?=
 =?us-ascii?Q?wewVt7TtH+uzQ9Y+IB4JJbYdfAQSWgdey8EatPI0nXFH+LmozgPlZ9Zcj+xt?=
 =?us-ascii?Q?wfkw4WQoVUi439RCRKUjnnmR/bFAGszlkU8lnpCUDcqvFaw/8jXWiub8xmEP?=
X-MS-Exchange-AntiSpam-MessageData-1: JUqjBf/PVMiHT+fizOHbuJPWPPZB9uitMDs=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee9189f-5f5f-46fc-81c5-08df49bfc2c5
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:26.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YbyNUgZy8GfwfZnLe3FPd5jpMfayTNrOXrYa2ENteslFi9Iko+g0zecptEhH849pxY3Juh7v+wANI1g+eiYDItVfOluBVt6UMvVXFiCjzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Add a TOFU provisioning option for EAP networks. When set and neither
CACertFile nor ServerCertHash is configured, the authentication server
certificate is pinned the first time the network is used.

Certificates pinned this way are stored in the service settings under
TOFU.ServerCertHash, or TOFU.CACertFile together with TOFU.DomainMatch,
and are only used while the provisioning file enables TOFU and does not
configure a CA certificate or server certificate hash itself. The
provisioning file is never modified. As long as nothing is pinned yet,
the network is marked to make a TOFU probe connection.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 src/config.c  |  8 +++++
 src/connman.h |  3 ++
 src/network.c |  5 +++
 src/service.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++----
 src/storage.c |  5 +++
 5 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/src/config.c b/src/config.c
index 2b0efcab..5fb75337 100644
--- a/src/config.c
+++ b/src/config.c
@@ -63,6 +63,7 @@ struct connman_config_service {
 	char *config_ident; /* file prefix */
 	char *config_entry; /* entry name */
 	bool hidden;
+	bool tofu;
 	bool virtual;
 	char *virtual_file;
 	char *ipv4_address;
@@ -116,6 +117,7 @@ static bool cleanup = false;
 #define SERVICE_KEY_PASSPHRASE         "Passphrase"
 #define SERVICE_KEY_SECURITY           "Security"
 #define SERVICE_KEY_HIDDEN             "Hidden"
+#define SERVICE_KEY_TOFU               "TOFU"
 #define SERVICE_KEY_MDNS               "mDNS"
 
 #define SERVICE_KEY_IPv4               "IPv4"
@@ -155,6 +157,7 @@ static const char *service_possible_keys[] = {
 	SERVICE_KEY_PASSPHRASE,
 	SERVICE_KEY_SECURITY,
 	SERVICE_KEY_HIDDEN,
+	SERVICE_KEY_TOFU,
 	SERVICE_KEY_IPv4,
 	SERVICE_KEY_IPv6,
 	SERVICE_KEY_IPv6_PRIVACY,
@@ -815,6 +818,9 @@ static bool load_service(GKeyFile *keyfile, const char *group,
 	service->hidden = __connman_config_get_bool(keyfile, group,
 						SERVICE_KEY_HIDDEN, NULL);
 
+	service->tofu = __connman_config_get_bool(keyfile, group,
+						SERVICE_KEY_TOFU, NULL);
+
 	if (service_created)
 		g_hash_table_insert(config->service_table, service->ident,
 					service);
@@ -1213,6 +1219,8 @@ static void provision_service_wifi(struct connman_config_service *config,
 
 	if (config->hidden)
 		__connman_service_set_hidden(service);
+
+	__connman_service_set_tofu(service, config->tofu);
 }
 
 struct connect_virtual {
diff --git a/src/connman.h b/src/connman.h
index f019a952..d86ceb02 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -299,6 +299,8 @@ bool __connman_storage_remove_provider(const char *identifier);
 char **__connman_storage_get_providers(void);
 bool __connman_storage_remove_service(const char *service_id);
 
+#define SERVICE_TOFU_CA_FILE "tofu-ca.pem"
+
 int __connman_detect_init(void);
 void __connman_detect_cleanup(void);
 
@@ -846,6 +848,7 @@ void __connman_service_set_split_routing(struct connman_service *service,
 void __connman_service_split_routing_changed(struct connman_service *service);
 int __connman_service_get_index(const struct connman_service *service);
 void __connman_service_set_hidden(struct connman_service *service);
+void __connman_service_set_tofu(struct connman_service *service, bool tofu);
 bool __connman_service_server_cert_hash_valid(const char *value);
 void __connman_service_set_hostname(struct connman_service *service,
 						const char *hostname);
diff --git a/src/network.c b/src/network.c
index 678cb587..3de64f57 100644
--- a/src/network.c
+++ b/src/network.c
@@ -95,6 +95,7 @@ struct connman_network {
 		char *agent_identity;
 		char *ca_cert_path;
 		char *server_cert_hash;
+		bool tofu_probe;
 		char *subject_match;
 		char *altsubject_match;
 		char *domain_suffix_match;
@@ -2291,6 +2292,8 @@ int connman_network_set_bool(struct connman_network *network,
 		network->wifi.wps_advertizing = value;
 	else if (g_strcmp0(key, "WiFi.UseWPS") == 0)
 		network->wifi.use_wps = value;
+	else if (g_strcmp0(key, "WiFi.TOFUProbe") == 0)
+		network->wifi.tofu_probe = value;
 
 	return -EINVAL;
 }
@@ -2313,6 +2316,8 @@ bool connman_network_get_bool(struct connman_network *network,
 		return network->wifi.wps_advertizing;
 	else if (g_str_equal(key, "WiFi.UseWPS"))
 		return network->wifi.use_wps;
+	else if (g_str_equal(key, "WiFi.TOFUProbe"))
+		return network->wifi.tofu_probe;
 
 	return false;
 }
diff --git a/src/service.c b/src/service.c
index f6efa01a..82d0a51b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -156,6 +156,10 @@ struct connman_service {
 	bool hidden;
 	bool ignore;
 	bool autoconnect;
+	bool tofu;
+	char *tofu_cert_hash;
+	char *tofu_ca_cert_file;
+	char *tofu_domain_match;
 	struct timeval modified;
 	unsigned int order;
 	char *name;
@@ -1000,6 +1004,18 @@ static int service_save(struct connman_service *service)
 		g_key_file_set_string(keyfile, service->identifier,
 				"Config.ident", service->config_entry);
 
+	if (service->tofu_cert_hash)
+		g_key_file_set_string(keyfile, service->identifier,
+				"TOFU.ServerCertHash", service->tofu_cert_hash);
+
+	if (service->tofu_ca_cert_file)
+		g_key_file_set_string(keyfile, service->identifier,
+				"TOFU.CACertFile", service->tofu_ca_cert_file);
+
+	if (service->tofu_domain_match)
+		g_key_file_set_string(keyfile, service->identifier,
+				"TOFU.DomainMatch", service->tofu_domain_match);
+
 done:
 	__connman_storage_save_service(keyfile, service->identifier);
 
@@ -5516,6 +5532,57 @@ bool __connman_service_server_cert_hash_valid(const char *value)
 	return true;
 }
 
+static void tofu_clear_pins(struct connman_service *service)
+{
+	g_free(service->tofu_cert_hash);
+	service->tofu_cert_hash = NULL;
+	g_free(service->tofu_ca_cert_file);
+	service->tofu_ca_cert_file = NULL;
+	g_free(service->tofu_domain_match);
+	service->tofu_domain_match = NULL;
+}
+
+/*
+ * Enable or disable TOFU for a provisioned service. Certificates pinned
+ * through TOFU are kept in the service settings rather than in the
+ * provisioning file, so they are (re)loaded from there.
+ */
+void __connman_service_set_tofu(struct connman_service *service, bool tofu)
+{
+	GKeyFile *keyfile;
+	char *str;
+
+	if (!service)
+		return;
+
+	service->tofu = tofu;
+	tofu_clear_pins(service);
+
+	if (!tofu)
+		return;
+
+	keyfile = connman_storage_load_service(service->identifier);
+	if (!keyfile)
+		return;
+
+	str = g_key_file_get_string(keyfile, service->identifier,
+					"TOFU.ServerCertHash", NULL);
+	if (__connman_service_server_cert_hash_valid(str))
+		service->tofu_cert_hash = g_ascii_strup(str, -1);
+	g_free(str);
+
+	str = g_key_file_get_string(keyfile, service->identifier,
+					"TOFU.CACertFile", NULL);
+	if (str && g_file_test(str, G_FILE_TEST_IS_REGULAR)) {
+		service->tofu_ca_cert_file = str;
+		service->tofu_domain_match = g_key_file_get_string(keyfile,
+				service->identifier, "TOFU.DomainMatch", NULL);
+	} else
+		g_free(str);
+
+	g_key_file_free(keyfile);
+}
+
 void __connman_service_set_hostname(struct connman_service *service,
 						const char *hostname)
 {
@@ -8130,6 +8197,7 @@ static void service_free(gpointer user_data)
 	g_free(service->phase2);
 	g_free(service->config_file);
 	g_free(service->config_entry);
+	tofu_clear_pins(service);
 
 	if (service->stats.timer)
 		g_timer_destroy(service->stats.timer);
@@ -9779,6 +9847,20 @@ static bool prepare_network(struct connman_service *service)
 
 static void prepare_8021x(struct connman_service *service)
 {
+	const char *ca_cert_file = service->ca_cert_file;
+	const char *server_cert_hash = service->server_cert_hash;
+	const char *domain_match = service->domain_match;
+	bool tofu_probe = false;
+
+	if (service->tofu && !ca_cert_file && !server_cert_hash) {
+		ca_cert_file = service->tofu_ca_cert_file;
+		server_cert_hash = service->tofu_cert_hash;
+		if (!domain_match)
+			domain_match = service->tofu_domain_match;
+
+		tofu_probe = !ca_cert_file && !server_cert_hash;
+	}
+
 	if (service->eap)
 		connman_network_set_string(service->network, "WiFi.EAP",
 								service->eap);
@@ -9792,12 +9874,14 @@ static void prepare_8021x(struct connman_service *service)
 						"WiFi.AnonymousIdentity",
 						service->anonymous_identity);
 
-	if (service->ca_cert_file)
-		connman_network_set_string(service->network, "WiFi.CACertFile",
-							service->ca_cert_file);
+	connman_network_set_string(service->network, "WiFi.CACertFile",
+							ca_cert_file);
 
 	connman_network_set_string(service->network, "WiFi.ServerCertHash",
-						service->server_cert_hash);
+							server_cert_hash);
+
+	connman_network_set_bool(service->network, "WiFi.TOFUProbe",
+							tofu_probe);
 
 	if (service->subject_match)
 		connman_network_set_string(service->network, "WiFi.SubjectMatch",
@@ -9811,9 +9895,8 @@ static void prepare_8021x(struct connman_service *service)
 		connman_network_set_string(service->network, "WiFi.DomainSuffixMatch",
 							service->domain_suffix_match);
 
-	if (service->domain_match)
-		connman_network_set_string(service->network, "WiFi.DomainMatch",
-							service->domain_match);
+	connman_network_set_string(service->network, "WiFi.DomainMatch",
+							domain_match);
 
 	if (service->client_cert_file)
 		connman_network_set_string(service->network,
diff --git a/src/storage.c b/src/storage.c
index 90f03ebc..c5b7cce1 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -317,6 +317,11 @@ bool __connman_storage_remove_service(const char *service_id)
 	if (!removed)
 		return false;
 
+	/* And a CA certificate pinned by TOFU */
+	removed = remove_file(service_id, SERVICE_TOFU_CA_FILE);
+	if (!removed)
+		return false;
+
 	removed = remove_dir(service_id);
 	if (!removed)
 		return false;
-- 
2.56.1

