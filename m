Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521643;
	b=XFFmpi0M+55bE6oxVppNyt1AhzbI+QQ4RusniOMEN0IsJWPt2DYwnY/pNlvxGTv5K+Wk
	 lP3vDYXdo7t3yibmIT+B/02uqVGROQSOvefv/qxxZ2oKCh5UMk+EQWqK6Vo671WXDwpf0
	 efjR0eDB61bGYDTS8Hax8RE2nuCuj7SLmJoDoFU0sMGV5xP/o5qT04YDfsz0UlhFv0iCY
	 B9AtFocf7RLYeFWBe+gi2HS+d566yRCrV/ItwtX/BWoTHrUF5sPqD8o10g9kZkVJ/zZCz
	 AgBPyFzx8GRLyVQIB5f6BKdusRu15BWn326Mk6rkNOCRXLhiqGWnAPpckG8BmQm7i/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521643;
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
	bh=TXsQJJj8RNp+dcrRjCadlVDPF7Y/4tD/SLItq9V9ROo=;
	b=madKeN2vqS48G+oeUfR584wAiCR8t2+NcAKgTmL/m/ihJP0iFNuGOg4qJZ7esYsK1r+L
	 juGDhMLk8JV7Twm7stJlAofOScNkTH0UrPW2Jo/6f7QPcUzuTHgVqEAUop7FYWt56g5fx
	 /16rDfEmrTXXkDda6/4y31iOgZK2+HJhBB6sePts/GfVwYH436wvStfXO7OsUgjQBLXDO
	 M5+bmZqrNtDq5M18m71JbyRJ2jKITaDgA1bj7e8PFHHSntSorEGtuqnFgE6obg8D18r2n
	 fyAQ3kZWOlZOjM91a+f8BUoZ2/gEOjwwjCoX66sLCoqeN7nUTT92S6vI/sT7ZL8fRIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=UzwAKymG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.120
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020120.outbound.protection.outlook.com [52.101.84.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A89606A321
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 12:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15A89606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=UzwAKymG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4/8Q0bvjHd2oJdKfTaUrmfCzVGBpOBOJb0bajn4MPY6j49im8TurHXPh4QgEdPuTasCjt++y1BREP7CVkCuqf3b1bnZMTvKS6bLPeyuTWJAmprFZgY6yGZm2m/OS4bymyZiDpxqxB3H0C2OtqyS9sLDvTp8PJqxbDCR3l34Xggnroy93ZCvbdM+k/mmPtlAidgYIe61X1pPeTSWr08cFF2SURErl4vttuBphK34fNXkq5HCHqLVg+CcFJ1nbNgMjvfHzmOyCSyOpr//adHeCLGrGCRafGinA+Gozt8+G+xA0YEhYjMsyZHpp1RW6Kqcp2xSmRvT0H2t2DFPjP6T5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXsQJJj8RNp+dcrRjCadlVDPF7Y/4tD/SLItq9V9ROo=;
 b=QLGgZiSTkVQ1xaQHoEcmHPp5ND68yjtyZ656VGV89JqU4CjcgDik+RxNJthzvFpfYey2qwF9y5QqrpVKrd0xSWSkv8fs73rnVWfvfW4JmIVqnWINI7/E6f4eIrlsdtm0/oKTWkuyh+9QGEfYBDLb9XJfd8iIL0aqeHl1tRDxnTmQjpxcRLAakbAzMvPUvhV8NottvljeGlJDm6HM8Jbyv5j2+U7NDJ5Fi2Fubv28gdyNhx6AbLqmu7lYn3HIXPaVb+K39SdSHhgF5mD3tpLMuNMSotuOut/x5VEaDcah2FPAVjFUfBS7qwLrv+UZEW+IULbWSaSYhjzUDipcJjmtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXsQJJj8RNp+dcrRjCadlVDPF7Y/4tD/SLItq9V9ROo=;
 b=UzwAKymGfe5Xryl2JIU8lkboFfprZy7Sl6drsh2mS45Wwv/8SvHCS7gtmEk6HrwQDiFqdgGmxdf7baGca/hM3DAnzV70OHbp4SebnpCb3B/vM8n1vzMmxu1YZUdDJotcHDymFENy5tSrhUoQuWllQqsDWYMYH15/nVa3p+EXsvc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by DBBPR08MB6026.eurprd08.prod.outlook.com
 (2603:10a6:10:1f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:00:35 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:00:35 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 3/5] iwd: Provision 802.1X networks from the service configuration
Date: Tue, 24 Nov 2026 13:00:27 +0100
Message-ID: <20261124120029.1288258-4-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P195CA0087.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::20) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 035e35db-b6a2-491a-b4bc-08df4a228c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|786006|376014|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	Sa1uud2SDjATgZP5ilQFcYzu6X5awwcoBvb0sguePd4+kJ1Ch9+lMLEnX4g8iY2nMrmML9T9kayeQGEeYesjWDS0zKF0RNf4+pO+1/BjshkAlmHzlGCz6/p+Y5+eM39OcgxYjYfklapyuM1QTN3fi5RXzRyjJ5rqszp6uY92g0YsolcVf0dumrHECDNVd8BMHoxfrYEYkAjt3BtN8W9vbVfsko/HTWoRW0gHonK/p4kKvKky0wbuQUyVn5lHTboynLBI3CruWBqmnV/bjUB6kDFOiektjXVBOWYmsa3h8u5XJ6aQf213yKvMihwcJtJId3/R8RAwz1n9c5PR0sLknle//l7W9J19DzTJb1d2CkcrKcBAO0GE25syJGC8com3pLFXZe99k7AZk8mxHWFwWJHzmHw7CTMl8Xfudi9CMS4oRHUjJKNWQYs1gxiJH+/Ck3BWu7Tbk77EWPfN8JWgu2BauflhvjaKRucW/ZBxMbkPKaxkDJNVliyrCSgiWPXKt4kFeODhh3vH+XEb0EgV4wccLONuRuEGwECQqF2N41fDDYvcF4mlhlBwV++aqJQuxhD007tsbMoJkRwIXXmc+e5eQrEQMwkoPTlNJTWKLEX1oyovay1L6vyIxR6fTkrwMLeHDo7lnZ7sYBMlXLISXBJ8noF84j9Fwi34VO3NXoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(786006)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(10067099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LqLb0fP0SujpgHnQEzkjK3s+ny/82542aaw24Xy0EoqKP/M2LMw5Bjttcc2m?=
 =?us-ascii?Q?okTVzaTHoWw4iUwY1E1SE5BATYWtZLNKxRaPKD5i9xK6m4ocFK0ijjeUYJnu?=
 =?us-ascii?Q?1xwk6swSO7pKmPZMgea1bkiapucBOsG3AZtpJKSC/8iECoAjzkMON+Xj8Tlo?=
 =?us-ascii?Q?Z5Zi7ynmTpXFXo5VIwuAVBPziFBTFwwWRmdudx3hLcl8kz2rR9KPD093aMBD?=
 =?us-ascii?Q?Lpxe8n528Eq6fR6iGP0ypJ3QNOdpRN+l897JwPo6sDlnIdK/TWUW1MbS1k2T?=
 =?us-ascii?Q?innoTawkUqEEV7zTc3FgidbW+n8qlXmxjrO8O8UhvqcxGfOF48sm0kn762uk?=
 =?us-ascii?Q?Xc2IpP6Eeq2cBOLOwci9wiN8OUo48MZAfpoSv6CrKNacLT7TsYYHy+tSqo6m?=
 =?us-ascii?Q?AmuORWl4ZZI/KF8XuknsuvEY9ajmQgTupshrgltyHURIFnnG2JrgEfci5m0p?=
 =?us-ascii?Q?igLkI/qytOaLzzOSPwVMwMgvrOV6VGxPL4+f8iqKGzEtuddJi67WiUh4DcW0?=
 =?us-ascii?Q?swm5htwhB8N6K9WcNFMmvBIk92u+mMGcgK9c+YIJOrDaXjJDN9TtKoCHf0YP?=
 =?us-ascii?Q?3+g85dCsbwe0j9O6wEASZZDvBnNJ5wVfslRJWpWSz6qGiS5tmmSSYkqBlm5z?=
 =?us-ascii?Q?onyvFDC5Occj9BjKQo742xF9AC/WMoLnZtuy/T4EpCg1zKcB18r5wZWNXKHM?=
 =?us-ascii?Q?c9JaiAqhVmO4fzYSFh5PveCMD6qPguDrJ3gonhVIKxfCqEM/ylhWuarrVVa/?=
 =?us-ascii?Q?mBNm8Hhd1Ybp0cjZ0shAMAuptJu9+5F79faP5prQ6O9q12lBCn9aDdZAB8vH?=
 =?us-ascii?Q?5roGxmGrZNj/dCLL+5P8Rypamw1YCiF9zp/FkDDNQknOJGF1Oz4OY7zeNycp?=
 =?us-ascii?Q?zp8vycwKye1fJDkTyao2DIH+AHXnOlcnchc9TWvfrZLvbuQq1mg/12S5jzpZ?=
 =?us-ascii?Q?1gjzDDlsN2Yf8pUG3RFThd+0sIHrCTvMrRojE16WgnrW3++diY1l7vbbHxyC?=
 =?us-ascii?Q?+FF5HVFo132Bv0k53t+MMsTFHEtkfiZiLBdd24U370FST9f5xybqgfZb0bX9?=
 =?us-ascii?Q?T+nfCFKek3RPyuHlbDy4AU0d5DP4o934IPtXFJczgoKbLHwdXsFzrwkc9o5a?=
 =?us-ascii?Q?wzSmh7t5DUNUjXxPR6OnPr1sGrrsavkjB6yYV99OUWhW1IK5+QY0QiuefP6c?=
 =?us-ascii?Q?VJZBuvZjZW/5RVkwGj/cWfKq6e9/1F92CH5CP3TpyeIPwdfBXPE1VAPGOCgU?=
 =?us-ascii?Q?J0CJYNF2S1eVSQavl2PnYDMoSjilMNRNL+i4eISMhQryVbR/0fqYT7gyIsBE?=
 =?us-ascii?Q?FCz8k4E+0PqXWgDF0lSZBVu7WClBmXelaKc1Vlg73G9Ouio+FmC1kj3b5x1E?=
 =?us-ascii?Q?9CllfU4B/nm6bETO6Pv5VywWqqWaEMZvBWZDVcrLg/dwvxLZOY+R1Scs5W53?=
 =?us-ascii?Q?NR8YeK531ipap63Ul24MhKeFMTSxpOmkcYNADuKvqfdpAkBt9pn+yRFJUk9A?=
 =?us-ascii?Q?HyuEz00FyZC7pSYJJNsT/z+e0n2bZBHHIpM6zepJ6Hp8B+JDLKIeTiJqTE6e?=
 =?us-ascii?Q?Xs1A5LoVikEpufAZ2vjf9sesJeqa39NpWRHAmwIwAuY5d6FHXCrsfmwzZ9ry?=
 =?us-ascii?Q?QV0wk/cRsNyVoYRdU/UMu3/gb3vsqPywhDcwfBzFqR6trpaw+Cz/RB14aUmr?=
 =?us-ascii?Q?4D6Vqv8RhT6ixbGPMj7hTAj32gepMMGNxh6BbV2CaERWj1T3ZOBX/7SELnuw?=
 =?us-ascii?Q?0QdzoLFeVrzBmw7ZaQgjGV2VYbgdzAuaM3Yy3rELtzzaEH0if5q9?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 035e35db-b6a2-491a-b4bc-08df4a228c0c
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:00:34.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2vF0SJqjgCr/z8K/N1z6EwrTxDcAQjn0jA6plvIFBqIbeU/8IkkD10+CPFBRMucQ9RX5njqAzrNYmubt5f2bMR4AOJaLQYRjY+xSzogiNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6026

iwd only connects to 802.1X networks for which it has a settings file,
see iwd.network(5), and unlike wpa_supplicant it has no D-Bus API to
pass the EAP settings when connecting. Connecting to an 802.1X service
provisioned in a ConnMan configuration file therefore fails with
net.connman.iwd.NotConfigured, unless a matching settings file was
written to iwd's storage directory by hand.

Write this file from the service's settings instead, through a new
optional provision callback of the network driver. It is called when a
configuration is loaded or changed, so that iwd knows the network and
can connect to it automatically, and again when connecting, so that iwd
always has the current settings. When iwd does not know the network
yet, the connection is started once iwd reports it as known.

Only the [Security] group of the file is written, other settings that
iwd keeps in it are preserved. Removing the configuration forgets the
known network, after which iwd removes the file itself.

SubjectMatch, AltSubjectMatch and DomainSuffixMatch have no iwd
equivalent and are ignored with a warning.

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 include/network.h |   1 +
 plugins/iwd.c     | 281 ++++++++++++++++++++++++++++++++++++++++++++--
 src/config.c      |   1 +
 src/connman.h     |   2 +
 src/network.c     |  13 +++
 src/service.c     |  20 ++++
 6 files changed, 306 insertions(+), 12 deletions(-)

diff --git a/include/network.h b/include/network.h
index d8ebb232..b6411941 100644
--- a/include/network.h
+++ b/include/network.h
@@ -165,6 +165,7 @@ struct connman_network_driver {
 	int (*connect) (struct connman_network *network);
 	int (*disconnect) (struct connman_network *network);
 	int (*forget) (struct connman_network *network);
+	int (*provision) (struct connman_network *network);
 	int (*set_autoconnect) (struct connman_network *network,
 				bool autoconnect);
 };
diff --git a/plugins/iwd.c b/plugins/iwd.c
index 7cfec424..b857c2ea 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -25,6 +25,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <sys/stat.h>
 #include <stdbool.h>
 #include <linux/if_ether.h>
 
@@ -57,6 +58,7 @@ static bool agent_registered;
 
 #define IWD_SERVICE			"net.connman.iwd"
 #define IWD_PATH			"/"
+#define IWD_STORAGEDIR			"/var/lib/iwd"
 #define IWD_AGENT_MANAGER_INTERFACE	"net.connman.iwd.AgentManager"
 #define IWD_ADAPTER_INTERFACE		"net.connman.iwd.Adapter"
 #define IWD_DEVICE_INTERFACE		"net.connman.iwd.Device"
@@ -109,6 +111,11 @@ struct iwd_network {
 	char *type;
 	bool connected;
 	char *known_network;
+	/*
+	 * Connect() deferred until iwd has picked up the 802.1X settings
+	 * file we just wrote and reports the network as known.
+	 */
+	bool connect_pending;
 
 	struct iwd_device *iwdd;
 	struct connman_network *network;
@@ -306,25 +313,200 @@ static void abort_pending_network(struct iwd_device *iwdd,
 	iwdd->pending_network = NULL;
 }
 
-static int cm_network_connect(struct connman_network *network)
+/*
+ * iwd only connects to 802.1X networks it has a settings file for, see
+ * iwd.network(5). The file name follows iwd's storage_get_network_file_path():
+ * the SSID itself if it only has alphanumerics, '-', '_' and ' ', otherwise
+ * '=' followed by the SSID in hex.
+ */
+static char *iwd_8021x_file_path(const char *ssid)
 {
-	struct iwd_network *iwdn = connman_network_get_data(network);
-	struct iwd_device *iwdd;
-	int err;
+	const char *c;
+	GString *path;
 
-	if (!iwdn || !iwdn->iwdd)
+	for (c = ssid; *c; c++)
+		if (!g_ascii_isalnum(*c) && !strchr("-_ ", *c))
+			break;
+
+	if (!*c)
+		return g_strdup_printf("%s/%s.8021x", IWD_STORAGEDIR, ssid);
+
+	path = g_string_new(IWD_STORAGEDIR "/=");
+	for (c = ssid; *c; c++)
+		g_string_append_printf(path, "%02x", (unsigned char) *c);
+	g_string_append(path, ".8021x");
+
+	return g_string_free(path, FALSE);
+}
+
+/*
+ * connman's Phase2 follows wpa_supplicant: "EAP-<method>" (and GTC with
+ * TTLS) is an inner EAP method, anything else is a TTLS non-EAP method.
+ * iwd names the latter Tunneled-<method>.
+ */
+static char *iwd_phase2_method(const char *eap, const char *phase2)
+{
+	if (g_str_has_prefix(phase2, "EAP-"))
+		return g_strdup(phase2 + strlen("EAP-"));
+
+	if (g_ascii_strcasecmp(eap, "ttls") || !g_strcmp0(phase2, "GTC"))
+		return g_strdup(phase2);
+
+	if (!g_strcmp0(phase2, "MSCHAPV2"))
+		return g_strdup("Tunneled-MSCHAPv2");
+
+	return g_strdup_printf("Tunneled-%s", phase2);
+}
+
+/* "AB:CD:..." as stored by connman to the plain hex iwd expects */
+static char *iwd_server_cert_hash(const char *hash)
+{
+	GString *hex = g_string_new(NULL);
+	const char *c;
+
+	for (c = hash; *c; c++)
+		if (*c != ':')
+			g_string_append_c(hex, g_ascii_tolower(*c));
+
+	return g_string_free(hex, FALSE);
+}
+
+static void set_8021x_string(GKeyFile *keyfile, const char *prefix,
+				const char *key, const char *value)
+{
+	char *name;
+
+	if (!value)
+		return;
+
+	name = g_strdup_printf("%s%s", prefix, key);
+	g_key_file_set_string(keyfile, "Security", name, value);
+	g_free(name);
+}
+
+/*
+ * Writes the iwd settings file for an 802.1X network from the service's
+ * WiFi.* settings, so connman's own service config is the only one needed.
+ * Only the [Security] group is replaced, anything iwd keeps in the file
+ * itself (e.g. [Settings] AutoConnect) is preserved.
+ */
+static int provision_8021x(struct iwd_network *iwdn)
+{
+	struct connman_network *network = iwdn->network;
+	const char *eap = connman_network_get_string(network, "WiFi.EAP");
+	const char *identity, *anonymous_identity, *phase2, *hash;
+	GKeyFile *keyfile;
+	char *path, *prefix, *method, *data = NULL, *old = NULL;
+	int err = 0;
+
+	if (!eap)
 		return -EINVAL;
 
-	iwdd = iwdn->iwdd;
-	if (iwdd->disconnecting) {
-		if (g_strcmp0(iwdn->path, iwdd->pending_network)) {
-			abort_pending_network(iwdd,
-					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);
-			iwdd->pending_network = g_strdup(iwdn->path);
+	if (g_ascii_strcasecmp(eap, "peap") &&
+			g_ascii_strcasecmp(eap, "ttls") &&
+			g_ascii_strcasecmp(eap, "tls")) {
+		connman_warn("EAP method %s is not supported with iwd", eap);
+		return -EOPNOTSUPP;
+	}
+
+	if (connman_network_get_string(network, "WiFi.SubjectMatch") ||
+			connman_network_get_string(network,
+						"WiFi.AltSubjectMatch") ||
+			connman_network_get_string(network,
+						"WiFi.DomainSuffixMatch"))
+		connman_warn("%s: SubjectMatch, AltSubjectMatch and "
+				"DomainSuffixMatch are not supported with "
+				"iwd, ignoring them", iwdn->name);
+
+	path = iwd_8021x_file_path(iwdn->name);
+	method = g_ascii_strup(eap, -1);
+	prefix = g_strdup_printf("EAP-%s-", method);
+
+	keyfile = g_key_file_new();
+	g_key_file_load_from_file(keyfile, path, G_KEY_FILE_KEEP_COMMENTS,
+					NULL);
+	g_key_file_remove_group(keyfile, "Security", NULL);
+
+	if (!g_key_file_has_group(keyfile, "Settings"))
+		g_key_file_set_boolean(keyfile, "Settings", "AutoConnect",
+					iwdn->cm_autoconnect);
+
+	identity = connman_network_get_string(network, "WiFi.Identity");
+	anonymous_identity = connman_network_get_string(network,
+						"WiFi.AnonymousIdentity");
+
+	set_8021x_string(keyfile, "EAP-", "Method", method);
+	set_8021x_string(keyfile, "EAP-", "Identity",
+			anonymous_identity ? anonymous_identity : identity);
+
+	set_8021x_string(keyfile, prefix, "CACert",
+			connman_network_get_string(network, "WiFi.CACertFile"));
+	set_8021x_string(keyfile, prefix, "ServerDomainMask",
+			connman_network_get_string(network, "WiFi.DomainMatch"));
+
+	hash = connman_network_get_string(network, "WiFi.ServerCertHash");
+	if (hash) {
+		char *hex = iwd_server_cert_hash(hash);
+
+		set_8021x_string(keyfile, prefix, "ServerCertHash", hex);
+		g_free(hex);
+	}
+
+	if (!g_ascii_strcasecmp(eap, "tls")) {
+		set_8021x_string(keyfile, prefix, "ClientCert",
+				connman_network_get_string(network,
+						"WiFi.ClientCertFile"));
+		set_8021x_string(keyfile, prefix, "ClientKey",
+				connman_network_get_string(network,
+						"WiFi.PrivateKeyFile"));
+		set_8021x_string(keyfile, prefix, "ClientKeyPassphrase",
+				connman_network_get_string(network,
+						"WiFi.PrivateKeyPassphrase"));
+	} else {
+		phase2 = connman_network_get_string(network, "WiFi.Phase2");
+		if (phase2) {
+			char *phase2_method = iwd_phase2_method(eap, phase2);
+
+			set_8021x_string(keyfile, prefix, "Phase2-Method",
+						phase2_method);
+			g_free(phase2_method);
+		}
+
+		set_8021x_string(keyfile, prefix, "Phase2-Identity", identity);
+		set_8021x_string(keyfile, prefix, "Phase2-Password",
+				connman_network_get_string(network,
+						"WiFi.Passphrase"));
+	}
+
+	data = g_key_file_to_data(keyfile, NULL, NULL);
+	g_file_get_contents(path, &old, NULL, NULL);
+
+	if (g_strcmp0(old, data)) {
+		DBG("writing %s", path);
+
+		/* holds the password, keep it readable by root only */
+		if (!g_file_set_contents(path, data, -1, NULL) ||
+				chmod(path, 0600) < 0) {
+			connman_error("Failed to write %s", path);
+			err = -EIO;
 		}
-		return -EINPROGRESS;
 	}
 
+	g_free(old);
+	g_free(data);
+	g_key_file_free(keyfile);
+	g_free(prefix);
+	g_free(method);
+	g_free(path);
+
+	return err;
+}
+
+static int network_connect(struct iwd_network *iwdn)
+{
+	struct iwd_device *iwdd = iwdn->iwdd;
+	int err;
+
 	if (!g_dbus_proxy_method_call(iwdn->proxy, "Connect",
 			NULL, cm_network_connect_cb,
 			g_strdup(iwdn->path), g_free)) {
@@ -344,6 +526,66 @@ out:
 	return err;
 }
 
+static int cm_network_connect(struct connman_network *network)
+{
+	struct iwd_network *iwdn = connman_network_get_data(network);
+	struct iwd_device *iwdd;
+	int err;
+
+	if (!iwdn || !iwdn->iwdd)
+		return -EINVAL;
+
+	iwdd = iwdn->iwdd;
+	if (iwdd->disconnecting) {
+		if (g_strcmp0(iwdn->path, iwdd->pending_network)) {
+			abort_pending_network(iwdd,
+					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);
+			iwdd->pending_network = g_strdup(iwdn->path);
+		}
+		return -EINPROGRESS;
+	}
+
+	if (!g_strcmp0(iwdn->type, "8021x")) {
+		err = provision_8021x(iwdn);
+		if (err < 0)
+			return err;
+
+		/*
+		 * iwd notices a new settings file through inotify; Connect()
+		 * before that fails with NotConfigured, so wait for the
+		 * network's KnownNetwork property to show up.
+		 */
+		if (!iwdn->known_network) {
+			DBG("%s waiting for iwd to load the settings",
+								iwdn->path);
+			iwdn->connect_pending = true;
+			connman_network_set_associating(network, true);
+			return -EINPROGRESS;
+		}
+	}
+
+	return network_connect(iwdn);
+}
+
+/*
+ * A provisioned service's config was loaded or changed: write the settings
+ * file now, so iwd knows the network and can autoconnect to it. Removing
+ * the config forgets the known network (cm_network_forget()), and iwd then
+ * deletes the file itself.
+ */
+static int cm_network_provision(struct connman_network *network)
+{
+	struct iwd_network *iwdn = connman_network_get_data(network);
+
+	if (!iwdn)
+		return -EINVAL;
+
+	if (g_strcmp0(iwdn->type, "8021x"))
+		return 0;
+
+	return provision_8021x(iwdn);
+}
+
 static void cm_network_forget_cb(DBusMessage *message, void *user_data)
 {
 	struct iwd_known_network *iwdkn;
@@ -465,6 +707,13 @@ static int cm_network_disconnect(struct connman_network *network)
 		return -EINVAL;
 
 	iwdd = iwdn->iwdd;
+
+	if (iwdn->connect_pending) {
+		iwdn->connect_pending = false;
+		connman_network_set_associating(network, false);
+		return 0;
+	}
+
 	if (iwdd->disconnecting)
 		return -EALREADY;
 
@@ -634,6 +883,7 @@ static struct connman_network_driver network_driver = {
 	.connect		= cm_network_connect,
 	.disconnect		= cm_network_disconnect,
 	.forget		= cm_network_forget,
+	.provision		= cm_network_provision,
 	.set_autoconnect	= cm_network_set_autoconnect,
 };
 
@@ -1285,6 +1535,13 @@ static void network_property_change(GDBusProxy *proxy, const char *name,
 			iwdkn->cm_autoconnect = iwdn->cm_autoconnect;
 			update_auto_connect(iwdkn);
 		}
+
+		if (iwdn->connect_pending) {
+			iwdn->connect_pending = false;
+			if (network_connect(iwdn) != -EINPROGRESS)
+				connman_network_set_error(iwdn->network,
+					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);
+		}
 	}
 }
 
diff --git a/src/config.c b/src/config.c
index 5fb75337..de3b04ec 100644
--- a/src/config.c
+++ b/src/config.c
@@ -1459,6 +1459,7 @@ static int try_provision_service(struct connman_config_service *config,
 
 	if (type == CONNMAN_SERVICE_TYPE_WIFI) {
 		provision_service_wifi(config, service, network);
+		__connman_service_provision_network(service);
 	}
 
 	__connman_service_mark_dirty();
diff --git a/src/connman.h b/src/connman.h
index 1afa02d1..7f9b99c4 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -655,6 +655,7 @@ void __connman_network_set_device(struct connman_network *network,
 int __connman_network_connect(struct connman_network *network);
 int __connman_network_disconnect(struct connman_network *network);
 int __connman_network_forget(struct connman_network *network);
+int __connman_network_provision(struct connman_network *network);
 int __connman_network_clear_ipconfig(struct connman_network *network,
 					struct connman_ipconfig *ipconfig);
 int __connman_network_enable_ipconfig(struct connman_network *network,
@@ -800,6 +801,7 @@ int __connman_service_disconnect(struct connman_service *service);
 void __connman_service_set_active_session(bool enable, GSList *list);
 void __connman_service_auto_connect(enum connman_service_connect_reason reason);
 bool __connman_service_remove(struct connman_service *service);
+void __connman_service_provision_network(struct connman_service *service);
 void __connman_service_set_hidden_data(struct connman_service *service,
 				gpointer user_data);
 void __connman_service_return_error(struct connman_service *service,
diff --git a/src/network.c b/src/network.c
index 5b81c225..d136a5cb 100644
--- a/src/network.c
+++ b/src/network.c
@@ -2086,6 +2086,19 @@ int __connman_network_forget(struct connman_network *network)
 	return 0;
 }
 
+int __connman_network_provision(struct connman_network *network)
+{
+	DBG("network %p", network);
+
+	if (!network->driver)
+		return -EUNATCH;
+
+	if (network->driver->provision)
+		return network->driver->provision(network);
+
+	return 0;
+}
+
 int __connman_network_clear_ipconfig(struct connman_network *network,
 					struct connman_ipconfig *ipconfig)
 {
diff --git a/src/service.c b/src/service.c
index 6109eef6..2c68d6af 100644
--- a/src/service.c
+++ b/src/service.c
@@ -10205,6 +10205,26 @@ static void prepare_8021x(struct connman_service *service)
 							service->phase2);
 }
 
+/*
+ * Hands a provisioned 802.1X service's settings to the network driver
+ * right away, for backends that keep their own copy of them (iwd)
+ * instead of getting them on each connect.
+ */
+void __connman_service_provision_network(struct connman_service *service)
+{
+	if (!service->network ||
+			service->security != CONNMAN_SERVICE_SECURITY_8021X)
+		return;
+
+	if (service->passphrase)
+		connman_network_set_string(service->network,
+				"WiFi.Passphrase", service->passphrase);
+
+	prepare_8021x(service);
+
+	__connman_network_provision(service->network);
+}
+
 static int service_connect(struct connman_service *service)
 {
 	int err;
-- 
2.53.0

