Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479207;
	b=Ae6WJjPMC9Cc7/m7lPl5B7lLUDwJAFENuxxHE9uIsJgTiyVEsOUhxzphH2woknipDy5S
	 At7BV78OtPKQr6kmhTr6Qo3IoQ449wW7l9Onbqbf3/k8lvls22jecyA1JIgHVo5D6otGP
	 jHKPIyykwH5wjb+LHvJSsSkUYaTOU4vfjKrerKZTIVOAyeirZdvQkb7SzpvLCSR8QVznD
	 KaY6MjBUMD6L1o6nVTTcxryhafjS2wTLdyKjV3NwCS4ehVVUWWDwNJINfpYXcQqhThQue
	 vt2l/OLRvlg8K4jTnun+2tKvJ2uhuBDdlIsID1vdIw8m+8bcSOx6trvAK5sXWBLxBEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479207;
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
	bh=uWhQvkA4BTbOdqmXIy3xlRk4HZQayc2nnOZIghiGIaA=;
	b=UL9m6efX3BRAguEcx3XFbwWvDzBS01AeV9D80Dr9mAN1eUWNgLr1LJTbLM5EH240yzgJ
	 kED1hjI+4PPB6SdhzLpd4qqUa92tQ0Eg0gb7SRx4EsNjslWFtjMPWHFR6CA5ozwgCFvCu
	 rSQEr87bvmyMNeT4NgY9eCrVmA27kxGb8Ieg/s9c3k4vRGBxUODA8z1EtfIsaKrK0Anwo
	 BvUdDWl+UfalYuqUVF19tngUZESYu7+2ynFXrJ7za3AXTDQyhE8TEu7JJJ2n1Pa0zOhJS
	 iv3VRedSiQjofl4ulNzAFwlU/rVmV4vhFZxmzTeM2WGu6+px/LhQSoCwRw73YS6JhxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=cJtCIdr6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF42606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AF42606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=cJtCIdr6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olFX5sEY0HZwbQSilnYgiMV7C86PM7GuU51+65NT7hmio3Ydy6XrEFPulTrE9veRrSVlZV0f6OlxjOR+3IRcMfZJLw9G+qLU6L19B/Z7VtDUHasEKVntDxBG0B1Ma4TdwNbifgix487NhTGgtAsI4NFuMu6WTV6E08ePqiRS/zEDr11mPkurR8fJHfcvZmLOORYDNy+30R7vFFSrGpmz20XL2vp7ae39YwE7+Q3rRre0YmJWzg2ZPjP35S5OkTNTOoQab/XSOMZHi0dtvzzWCBo33rbgR+iNla1TYuzHKkvnOZxrvGuOfYkRToBow0pA0dJgyFwebC4oL4tuPPcGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWhQvkA4BTbOdqmXIy3xlRk4HZQayc2nnOZIghiGIaA=;
 b=pwIKacSw/2zQnJd4Pj5A2bqDQmcz70RxUC5RPLzGEwYkuCueHwN8V47mjE9k1ctdKM5TaIr4QOZlxSlbbKts05wBTr4YN4QpyJ2IzUKp9dUzWCrNkEM1+fGE6PidOjGP1x7mHVzTylrPtJSLW9Db/ZcIcyMjiISqDhl1XuZZkXNqPLDn5z2KcW2xerJP6vzAKbmU3/m2afakDLQA9EfXtkVsWaToP5iNOMa00Tku3wGhMNtee5r3j3LnrBc9bEiRJUlRcW9OgVzxZxZAuCSwq09Fg4murf4RNDBB5Tv1+DdYApJWiHT3p3SL5cwwteMA4m57JK7oF/mv/TZVKWj4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWhQvkA4BTbOdqmXIy3xlRk4HZQayc2nnOZIghiGIaA=;
 b=cJtCIdr6txZISVzEvyu6GjMXe3/9/p3Fv7K24cNHp0fllg0GKUkpbVUWYMjXwVLr3TRZMZTr9fsbmCmwThiFKiZOYvlU3ItiCxrhmoqY12E2+VTZUgvuQ04Gv17yTPxVLKCybgdZkbty3WICYTJOVHx2aX3LDIqaOPsZ9E1saVw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:23 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:23 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 04/15] wifi: Pass ServerCertHash to wpa_supplicant
Date: Tue, 24 Nov 2026 01:13:00 +0100
Message-ID: <20261124001311.1161845-5-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0166.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::33) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 25f40a69-2413-4c13-9d6c-08df49bfc0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261009223027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	rrVgIBHHPBYQLra318cKQ7V/Wkczqqifu2aXfyfHI6p5WTjB5Aozt3ySOA0wyZzEK3tQ6iNSZvyhJzTLWVDdalr05+kLx72DsL3iqVsusGMckIU7kYNB+vMbYf7E3k3oFrbx5LJNc767jaICcTht5nI28UpLq6uqfSLblU2TTlp2oKDADSRHfywRWjnZ8JbHZ+HqS13cEb0cmWmlJwI0I579NGpmwjMcSzSwERV2JaTMOXXI6dkFKZ893qkNRHQtMqAOgRI//ZnTpMusYALYzJc7rAGZM/Hp2P+hQmCc9f2ntvhbhj6c0OlDL9PHNgGkg8kXmLRZOJATb+V/fIAHPCLW9a1/QyUchJl7G1HyIm13aZm219iVHvDTYZnbAwXqtYCgzE9PdJv/F095/dIH2JVRMo2KT+LpIL68nLsk6lil42RYjj/S9CYIBjVrF6k3L9k4QXyq8bKCyBqAwU9JnmtEdXMT28hLqbzmrEoMHr/dTXx0PlZICSFzCy2s5mlIGGFcPdUANDPQ6LFiQuw00531kwOMXKigyXSD4MaflSPx/XfZh53WlQLDkGTIxWL0m+Q+8t0f3Ii50a6aTOw8RY4sQk1V54WFagVeIrU67olj7LnyagUypHoecFUGvXV+l7INYHcYIiJNgm2Bqg3sPRoeZBxgFXlJeG0NGAZ8pVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18aCLiN35vRNjkB8UvB6XuO+rEjUDTwKp43p0cNOXbcP9C06DuC0NxL91qLy?=
 =?us-ascii?Q?O+rwqxA5wchGCbV76rJkGCt9JGgHLwZzOx5jUlAazXNZEQ3OX4EmJLBdtXkH?=
 =?us-ascii?Q?5VFtmEtnu6taR1+oIRmRLOUp+WS14WrEv2GfKvkdGL4FMHZCqflqE5UBCjC1?=
 =?us-ascii?Q?mJko0gPCDjzcEgBRvchROCzcD9xmKBCYtVMiQ+8S7EXkPNq1gd9/C3dFAm/6?=
 =?us-ascii?Q?rmiPE/qQEsMpbUrh1DwyxzGV3SOHF2GS3o2GxmJGhzI8TczgU2zo3XVkg+WP?=
 =?us-ascii?Q?Klhs6AxifuXbIMSlilgVJYoI4JQg+xM8LSp691D6LVIqLMnxTFeePfJ1EPkJ?=
 =?us-ascii?Q?ukKNbd6U6XLTHdq3aSUJd7s1UU8+Fags90BjCxhN0gtPC2KmO5bm+S7l3MEA?=
 =?us-ascii?Q?OTljw8sReSNcWinaSQ0ez9u+NAKI9Eexm36PaJqmLRWwvbxlvVuxXL3U29t4?=
 =?us-ascii?Q?sItWuFn4SIxw3YhyTiaBEjduTwvR0jlDuYHzbSqyJN3GIlzwshbjFnAYBoFX?=
 =?us-ascii?Q?r3vFIoQu+E3M+/rLKhoBmsOSTXy1pfcYsymu1XCZl6nR/hkHQb+YjlbqLSSD?=
 =?us-ascii?Q?cIa6xAnPdomIiV6XHP5c0jboDpbidNdDGgQJjgwdTbiHbhbIq2mf+4uE+oNC?=
 =?us-ascii?Q?rBkJ3oVA2238hcRYuRCptRJUOt5xz9mDQ0cWQzhoJjB7IAvVF5siT1zIJZZo?=
 =?us-ascii?Q?dkADoS/fuN/V+kwy8O64sOTEjI5UeC4dIWEgxAsengWEikPEF4Tnfl8+IwgT?=
 =?us-ascii?Q?KGQ6SFCw1ZYdqFN5HUykFzMn1sEhHEYXxDvh+PHGEFsi9tWFsdCOXlbi0B4Y?=
 =?us-ascii?Q?awYQ4iwzHomVoRAmdY+j3aHcSruIp179M7so2DDyhOOQy08xv5t4ZguxXP0D?=
 =?us-ascii?Q?7jiHhy8uwaK9vFWMdCsvslc7nIP0Wvp11RcwBS2QosKkffitF9iDu0mTFOMD?=
 =?us-ascii?Q?+at1Q16oTyKaSTnPY0g1Po4Lub4TrxpSOlEIxuttxJkH63Su4KDVPZlSyja1?=
 =?us-ascii?Q?3xMmmcxxX0Xnm3kG8Gwq/I6X1HiyvXnQRiqbiNB4z16QcoMt2SELj4umsQ5y?=
 =?us-ascii?Q?aKh8NOmhcm2JWJMGN/C/dmeU1jFzhj7hKIDm9xcVXTYiN4/rrKEjwhu78zQT?=
 =?us-ascii?Q?7Suqg3To4vpKJmNJGvzs4JBLSSGAjjQMLUUfkncqI1Rn1tNMG998OBK7QG0j?=
 =?us-ascii?Q?qqJI5RvYnYlxWw7abWf4Ktm/dpLO8+f317qAt0TsPstol4en+MxZsChAfxPF?=
 =?us-ascii?Q?CnTfcPIiVO1EVyyOdE9r7xrsR4YnqA3xovG0wgQej6EOI7B3qVBpEAXb9ca5?=
 =?us-ascii?Q?h3/JKM9XFbgerJgCTXok+qh8NS4SOxU8AYGeOWBueKZ3jDscVFYMNSoHvDmV?=
 =?us-ascii?Q?SqRh+W6tROm3o/sv+cMQLZoJ3l1NEVWqWcw//BnlH+3M1omTfYksHeNyv3a1?=
 =?us-ascii?Q?+n+H8YgzAGE2Wxkb7TgY6B/8AwJIK0jUKtqA3XXeQwoKDpi9kq92XLVCKhBG?=
 =?us-ascii?Q?yD3mqFVGXBWZNqcVDCLk+CSqYU0O3fSueg6xCJU+c53lYXMwYD2JlHUWxbdp?=
 =?us-ascii?Q?uL8NxZGsNPRCvzHR8mZs5u3DzRVqp+KqxXhwTVx0nSm4xyndgyZboaUoIpDL?=
 =?us-ascii?Q?DYbGozS7205sBRyBej0warHggyb9J923myOcdzFeK97hWOb0ej9yzBExt3CN?=
 =?us-ascii?Q?n33bEhYMdPccAsd5viwRgAykCn+bvI2ltraNOLDS0Wm5RLlPoZK1NgnsMvwJ?=
 =?us-ascii?Q?Nzsm6TADWNbPASJ/bKDE6gx2zBYCgPQPFvjr5Si5n6e1+JO8MqBwqkt9ssfS?=
X-MS-Exchange-AntiSpam-MessageData-1: E1vqp7ICNBFQwtqZjCh9byOlGCPR2GhlM6M=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f40a69-2413-4c13-9d6c-08df49bfc0c6
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:23.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVvpSKjkgm3AotGErbdsQhWFbE7SqnOsPu8XTzpglC/UIbjSEtS0psQsFTavHnDxQIGQ3FpI5nt5/9lamac4KC05r0YA9OgzW0nr53h80g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 plugins/wifi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 6ce6bb91..741962d5 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2211,6 +2211,8 @@ static void ssid_init(GSupplicantSSID *ssid, struct connman_network *network)
 		connman_network_get_string(network, "WiFi.AnonymousIdentity"));
 	ssid->ca_cert_path = g_strdup(
 		connman_network_get_string(network, "WiFi.CACertFile"));
+	ssid->server_cert_hash = g_strdup(
+		connman_network_get_string(network, "WiFi.ServerCertHash"));
 	ssid->subject_match = g_strdup(
 		connman_network_get_string(network, "WiFi.SubjectMatch"));
 	ssid->altsubject_match = g_strdup(
-- 
2.56.1

