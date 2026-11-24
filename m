Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479204;
	b=4N5Qe/ZQ2O76byvfitBcghz305Bns3PnsnComILVLxJzVc1I/RvD9HBZUSmiYQ/TvzLZ
	 JX1Gqfk0qpjvw94JJB6aGUV3eAme15isBmdo7AJ7kTD/gKbyCcFUNiMNHZqT7y5uRy63r
	 ycxpUGoTn+ry4PjwQWloR4N/+o97y9RQdaI+WirLVSY2KesNd29/gISFiNpk/Zg1/E1J2
	 d59usz7dMd2yfdg3wPQvHWl7d+2jExlEDJJGPpyfYixUdwe/ruwy1Dhu5RjFUxh7IDyeV
	 sOIMSoT9XXoVk9CXA52d68IzVsKqc2C6ZpYAVPYiYbeWCjqGSVQyF4AImFEH/wS+2uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479204;
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
	bh=iO4f2DK+B2Bf8PDAobMbzYehIW4VS1nIIIwgzbGI17s=;
	b=G5Jrv43ClN4xG3NosouBxraeNCFUyUtQQrM9DGyaV5DH56ejkaSIprHPLCIp5TLkcB0U
	 XUSYI7lXqAtJADdglXY6ICs+3epDjsSvCz/UBSJ/yhSKjp1Zis6GXNeydFM30mDIgs+HP
	 7DyUBU1moUFab1X+X3bIvbS+jhb2E5M8r4HiHainQXjcRCVUTwajTKg1sk1W+7GRLzxh+
	 CMCGxRqyzmnb6E6hCvhZl/0sUwgHEuV20e/buWOsamTI0APPH8TTwzXp9Ajw5tcwKeFjy
	 d+9ywM/SeSEyJAmqsCO+bum+EokPsEKJSdcXqCWoeMw+vilbPQPQr3fHS9IB/qd9CcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=VnHDcv5u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB52B606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB52B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=VnHDcv5u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDowLMqc2wkjMsWisNWfzjqP8qzpV3xF95GoLT0cEp+d3lW59VFBSV7rm8N9nnFcrs8MCm0nXAx+TNrirtaH8jgKYEFTQEu1XqqsViW15lNuUtTLty/sgwT7Yjb/bvsUVkhGCYSxFwfEBblEteFbJwwbzjUy9BOQW3l4dTlrSNlrhu0hwNP9TqR4Niz3JVRLROIHFKm67yFofQ9R3tGG5+a6v0JMHryU2djSJWYuDNfLm+5w1agieEylH9EJ1pRRZvBRKHnuDGgNvfWTZy6zVVA8MRiQvWE8VNpptSuf8XuJDrqqon6GPd51xK8zgV0Cxjwaz2vMvGPfZuI2ARU6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO4f2DK+B2Bf8PDAobMbzYehIW4VS1nIIIwgzbGI17s=;
 b=A7HHMszF3uOBIxJ7WdFzX5Kqyd10fIwm+H6bzyUmI/g6/K9tv8FwYuo4mOIH4Lqz2mBz/pbK6MgeaULaEvQ9wpsynpESSOxX7xOtrM6juosqmPruqKzpeyVyPzNxgGUypXQrPCjKXolqljxxUZ36OAZn0bFf/ol1tTcyAbamnoyxDzY6FvxE7D6y9W5tIzz5uLHNHNWk8BogEoWkcxSd3Lx7VP+WWOS73ivatAfzzZtagcOM8V31hwMcux2iRxmmKlvIECpkFwsPNB/ue58WdSf1gZnsZ7FsTLzVl046wDbewgGtL8h7vSgAMwQIgrxT1qqrqPblCZLXsDKwEmsa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO4f2DK+B2Bf8PDAobMbzYehIW4VS1nIIIwgzbGI17s=;
 b=VnHDcv5uz9b+Vv1DBL7avF4Rl0SC5g3k/UBHTRDIKdRzgnyOPcfD4GfcIwuOW+0NLya/sTXin3E+wJyQmnhFWGdm3pEYNMXOG+Kh+YlfPGOgWWE2oA88LfhobWT/AdN3lCclLnh+kSirojiYEqbKIIOdynLKfmD53G5K4ea3ZMQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:20 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:20 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 02/15] gsupplicant: Compare 802.1X verification settings when reusing a network
Date: Tue, 24 Nov 2026 01:12:58 +0100
Message-ID: <20261124001311.1161845-3-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0153.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::20) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 65a5ec8f-89c8-4029-3f57-08df49bfbee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|3023799007|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261021123027099003|261009221227099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/u8padF8GXeuY4Azqeg6yUhAKlvuNmPlfOJafbCO45GdYJG0YcvlXmCYG27svBzVPAiuevnNi8cGPRpqvEVi9UGAbjokTABGMdYdTSEdsoJ2/J9ABphI0VkLUQwWXYmCrA8MMu0slISg4aMkPaqg/MUJieI+3QOr7ACXeSA/xjT2Hs99/VwljK+DUxjYcWtlxgVROvQhuUR0OruTVnXdx/LjqFx/BPVZnoTO4CADQI1dTqtNOweZrGWQcISthwaCVNyIGDtWlO6gqzr4xpoUP7M4/rt1ww7+T0M98/gm78ySdT2sauZN8lBc9bCCCnkpiKbDhvQ+QMXmBP4hF/J1vfFJyAO7NCmkok41Me/teDeQLYuWIlte/Chws6fN9GM4OIhDonbU57FHAJTcKYQn2pEdCqSBQA4/iKAgZ5di8fa9bdgMTjoam4MhskIlUErbvYsEE4xyi02qH4vMOX6umtKuVr6+aYtmK3rjPVVyh5e2h9acJJ2IdkA6vaaONC4bpo0UiQQC2jRPlA/rwLzxRgnduUgzyTO3b8cF2z/vW2rBiV+UIh6LjwP1LHzuElap6l+/wbAJJ/Cbi4HWO98LNMBv7BzucinXqe6vSvbo33k0ghUYVdJQ75ce4YOdMKUXZtkKtIxit1YmoRI0I4kkMeBsyh/URkwN7jygiWayTX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261021123027099003)(261009221227099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yc+J6YbxW5oVqwwmki8fZlDRj0WlercdC4hgnJeghu9o6p9F3DC3UatpQDzJ?=
 =?us-ascii?Q?B12oEbNPdjCNOg11wXUb1PVFMSrLM0Hb4fUbTlNDJtkDfHPHRAT3BEjJFZGS?=
 =?us-ascii?Q?Is5qakgcjUlsSOSd3unR4PGUlIkLPA/jUgy73Vue6Z32Xz/Ykf8jGo+GGPEK?=
 =?us-ascii?Q?lC4DjkyaxfGQG0lwAEU8Ssz3QRQdFYZKFO8ZfShFnssKDuaQ0oopR7I5qBzc?=
 =?us-ascii?Q?ok9uT9QEnb0RkOzHG8fPb7JCOtB9tfJ/RZJtk94TTI74gwXxNFd9DWVwv+7U?=
 =?us-ascii?Q?XDc7jeDev3KpCyArau26JeQfmcft0cJnuJKcfUApm01x5j2zkEkHpPF6TTA1?=
 =?us-ascii?Q?bVbuapbVtazhDoHgaQpEGdrwjouGybn19TYMBdSW/DNVS8PI7OTxIbVyJeyu?=
 =?us-ascii?Q?7YxOAOB8VKw3/H3Pwqe2gZF5bNhQc139+UgNr0t9/UANmQfQFYCdR8clk5O6?=
 =?us-ascii?Q?i61l6J6tV3M7nyUPpkWaLx5RJJ1MZ61hWF/c/btIQNc2bLmpj/3g8pq7Z52N?=
 =?us-ascii?Q?4Jo2l5OJuJazMcKzgF9w1HJzSPcVx5digJiFpu4saIdB0nv65tCBPsw3Eyhp?=
 =?us-ascii?Q?+zkbbpZLh64IOfr3T5Q4PDC/n7UDbnD2Gz5Lr/Sem+MMdrTvUsqZrQmooD3i?=
 =?us-ascii?Q?Uk4Uq8CjyQRufncvqewms6imquuu+5+zW3CAnks9HpYkGQGmLh6LYmEbQjSo?=
 =?us-ascii?Q?UBWnFI+LXj1iiqynMcVo+x3DD49ixF8sURBRT54EILWkBI2R2EOYuhvjc9v0?=
 =?us-ascii?Q?rsy1QIGA/Y6zSVrk5M4UCn0fj0a8VwZNpEEPlwlAhab41c+lipNONrZjwVFP?=
 =?us-ascii?Q?XfWhHuXpDrZn3nJvuvI7sA76WF1KTZiS8rKLUBizURZOr5KBTYJRD8df8J8D?=
 =?us-ascii?Q?zJ/jkTvkWiR4CvLF6Yq6ijrbB2ucjMSqujHDxycbVNqILbvDrTz7bHhlUC4P?=
 =?us-ascii?Q?zCWJaNelrFLLk+SMQDbo9Tj8N/d+sFjTug68kWzDlKswS0ZVqeA6XGF2knRH?=
 =?us-ascii?Q?WssRNuHrm+VqctE9EK74TTWzQ+xDUQhGEOLCfFR1JFw4hdpJheqWBV8FCxiS?=
 =?us-ascii?Q?WCHB2YqXEGGRiNVeaY6SwQDaOJorICO5NouzTTijNyFok356YvRnF+nhvZga?=
 =?us-ascii?Q?N0k/UkxoQjfknXHLkXq7GEbCasP2lg9/O0MyDv+Zo/6AaxpRLKU+FKzZ1V99?=
 =?us-ascii?Q?pEsS6/QqZaAGcbAGIfj0k3MVF6QZvEzlz7cELA3hItox4HCqthp8c6SkwVJr?=
 =?us-ascii?Q?jTVpoE1Zp+Enr2NXBZoCprgW17OFbEcHmN+5cCoY7vVko4d38hrhZ682PZQC?=
 =?us-ascii?Q?i3uVYuQv2pMQrhILKBuYOppP7qjCpYicNv/WEXZsoEqivjrn2wbf6tU04qbs?=
 =?us-ascii?Q?mmiI++JqS5uCrxH9hLidhmCq/3AouLRXMEo6tgR0lCFc3DhyhzaoMHFEVhpN?=
 =?us-ascii?Q?70imgUUenA9upePFgkLk04Jx8cSpkvYGN9mlFTwzRLhuFBAtmbVQrQDTRGtg?=
 =?us-ascii?Q?oxMvlZKaVKMPlPJK7Vtx4uBvpIbkhM10EJnlCE0QuZzQGkkcwBJMFUFjRBTd?=
 =?us-ascii?Q?VMvSC8lIoyR7A7zNykXKatoaT4fM8Gi1gl2BNpM9FUG0qoMjsLqA5hg0EZss?=
 =?us-ascii?Q?XNCUtOpSwhteoz4SD9y5YcgHZKNGV5FqajhV+E8pkYAkTONj7xYxPLdMpGSZ?=
 =?us-ascii?Q?VNfhwSlBZstHrUEzYAoEhJqH/FHrFqQ++I/VHX+oyZlSve0SNeh4WBnV4/LA?=
 =?us-ascii?Q?n9MQ2Iho6sd6vkb8jp80x55Jr/l4uWh8VFcWVD0V6+xgOAKwHD1w81L5J3L+?=
X-MS-Exchange-AntiSpam-MessageData-1: Sma6IWUcvd60jXF7uhlWG0HWfHCTf+Ganwo=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a5ec8f-89c8-4029-3f57-08df49bfbee0
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:20.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgUPaozd0/dXSGC4tuJI95+GG8AXManG9eSUA/TAT+H3Sch4gMS+1uNLchKHN10buR5wYSocXRUUBOL6UJwy5WyetCBSoKK96CN6HGuKWTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

When a connection is started while wpa_supplicant still has the
previously added network, that network is reused if it is considered
the same. This happens when the previous network was not removed, for
example after the access point deauthenticated the station.

For 802.1X only the private key passphrase was compared, so a network
whose EAP password, CA certificate, server certificate hash or domain
had changed was taken for the same one, and the connection failed with
-EALREADY instead of using the new settings. Compare these as well.

This is needed for TOFU support, where the connection that follows a
probe connection is started while wpa_supplicant still has the probe's
network, and differs from it only in its password and in the
certificate it is verified against.
---
 gsupplicant/supplicant.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 83eac964..4e096547 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -157,6 +157,9 @@ struct added_network_information {
 	GSupplicantSecurity security;
 	char * passphrase;
 	char * private_passphrase;
+	char *ca_cert_path;
+	char *server_cert_hash;
+	char *domain_match;
 };
 
 struct _GSupplicantInterface {
@@ -420,6 +423,14 @@ static bool compare_network_parameters(GSupplicantInterface *interface,
 		return FALSE;
 	}
 
+	if (g_strcmp0(interface->network_info.ca_cert_path,
+					ssid->ca_cert_path) != 0 ||
+			g_strcmp0(interface->network_info.server_cert_hash,
+					ssid->server_cert_hash) != 0 ||
+			g_strcmp0(interface->network_info.domain_match,
+					ssid->domain_match) != 0)
+		return FALSE;
+
 	return TRUE;
 }
 
@@ -428,9 +439,15 @@ static void remove_network_information(GSupplicantInterface * interface)
 	g_free(interface->network_info.ssid);
 	g_free(interface->network_info.passphrase);
 	g_free(interface->network_info.private_passphrase);
+	g_free(interface->network_info.ca_cert_path);
+	g_free(interface->network_info.server_cert_hash);
+	g_free(interface->network_info.domain_match);
 	interface->network_info.ssid = NULL;
 	interface->network_info.passphrase = NULL;
 	interface->network_info.private_passphrase = NULL;
+	interface->network_info.ca_cert_path = NULL;
+	interface->network_info.server_cert_hash = NULL;
+	interface->network_info.domain_match = NULL;
 }
 
 static int store_network_information(GSupplicantInterface * interface,
@@ -454,10 +471,21 @@ static int store_network_information(GSupplicantInterface * interface,
 		interface->network_info.passphrase = g_strdup(ssid->passphrase);
 	}
 
-	if (ssid->security == G_SUPPLICANT_SECURITY_IEEE8021X &&
-			ssid->private_key_passphrase) {
-		interface->network_info.private_passphrase =
-			g_strdup(ssid->private_key_passphrase);
+	if (ssid->security == G_SUPPLICANT_SECURITY_IEEE8021X) {
+		if (ssid->passphrase)
+			interface->network_info.passphrase =
+				g_strdup(ssid->passphrase);
+
+		if (ssid->private_key_passphrase)
+			interface->network_info.private_passphrase =
+				g_strdup(ssid->private_key_passphrase);
+
+		interface->network_info.ca_cert_path =
+					g_strdup(ssid->ca_cert_path);
+		interface->network_info.server_cert_hash =
+					g_strdup(ssid->server_cert_hash);
+		interface->network_info.domain_match =
+					g_strdup(ssid->domain_match);
 	}
 
 	return 0;
-- 
2.56.1

