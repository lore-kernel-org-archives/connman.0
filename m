Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795472541;
	b=Chj2bjfJvtpDGXNJRasLaYnvPgiz9+gw6bsCl00vmqFi6SMjIlSPVPR2yBQxGULTATUg
	 TEKtfVIHwuZ3LhwYm29oegGAczhPjHc0qmEz1olwMYM8FVI0U5pB1BvJY/aMB6e06lq1O
	 P0x35UY57sdmW9k/wfVF176Hl/EEzkeLnV6Nn5B/SmGJS0Aa4Ts2gfTuobYeW4LKObIeG
	 B4O/wnaqQ/GLuxw11WXQC+MwntPJy99YWVjEOeifjAow1Oo9DANbkKI3MAj5kddsjIBVM
	 qRbOqRaCQyLRedGx3AqiqUGyyLnygMCvgXprpv1j2N5UiPjPKxbEMKx/4cxCe4+JyFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472541;
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
	bh=niqgQEurXsTQtisla8d1NYmMI3QrflI+TIhztgeuo/0=;
	b=NC3tbArDzYzGNYBdZJLSm38+wUnoy9RMUro8j1TPcLN4bUfwPMkTqUfISE4FprZfxxJE
	 a3oXiV9ACq6YqmxB5u9cKdUfLV7oIHkOh0LXJPSKgzWLO4F0PlpC+hvG044Bujx8F/osH
	 8FQ4tN3UsnqXLVCCTk0jbd5WjkxbciWis2JS8/GeYVCJXqK/Vv8AFIExDet5zlgIN1LrW
	 HTgbZm+yXZRGCwqDyYcV8S8EYzRuLidza283nKiGgPwI7UmBhD2uY150Tkmd6ON46U20n
	 t8L5xXR/4RoNzbw01jl41LsNgxefAJvoZntIyaSo1vvvHkmtY+zVIAAqofa8OPTYwEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=SipqWsoq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.134
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020134.outbound.protection.outlook.com [52.101.69.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5D606A31E
	for <connman@lists.linux.dev>; Mon, 23 Nov 2026 22:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F5D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=SipqWsoq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6m+JBnagRMsaV+EVZilgPsjKBb90SzkkeqD2hi6qgakiF5xv1fe5o2PNMFRCepyGDYHx5wTO39uAHgxQr66kvr9Pz8kM9qzKR7Ena36L2qGv/jo9fNbjiMCHyb8j+QqW0jW824wNdKN99zl5SNbeddlmh4zy3aZZgY3Bwzpa4bejzSyGzu8kNJt2uNo+jOWEa03rpOjGuPQmfD8YDTJdKwYbWVdue4/GTDiVwkOcqI4FsQqRkdsSNU5Uo0RFjg3BGTmab3yIW1ixm1ONAssovLgg6pLncr5PQSDVUw4TKZT54OSdAPtiQ+4TR2HDBQwY/vrJ5rsceamAMuXU7i+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niqgQEurXsTQtisla8d1NYmMI3QrflI+TIhztgeuo/0=;
 b=aGcbfORVrwxiAG+kekialTD05Nujaadlm+lzUSjEp3JOYczvVmMNhhbiIkJ9YAAY+l+HC8xyb4R3QBfXi4juI2CLL+N+tW3akvjkQz+mVfaYXHUuGP3XDRtC6YhbZrO2YQKdnxwALXrRKL34ib0trnechP0o0HJkeuSj5MHCmt5Jcer+9p3+XbuMhpQSSGtAzGsyTAaKM7+fdq4RxD6a9Eo2ZgAZffoNCVr4t7gSToRvx977MeG0b91OpU7if6v8ojSO/ZYBAMY9fN8SAclQ6Q9zL9aaphGp0Oq9T3WqLtIv7Wge162sNhqv9Bhhj/sPG7JBp8ozvfE5vIfVicQwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niqgQEurXsTQtisla8d1NYmMI3QrflI+TIhztgeuo/0=;
 b=SipqWsoq5Pn0wjuWfPr/A8kcdmiaZtfwBYnAH0kRWo/6vV5286IQBdujPQhtMEvPfuwyajUiN+4xP3A9uJW8vLlmklbEUEK7x8/LBh2AA1DT5DLZEfbnsbROuwJ7ddLv5FBjDw97SI5trWKQQY56HuQ7PNHSvQyYdFGZljYdGZ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by AS8PR08MB6728.eurprd08.prod.outlook.com
 (2603:10a6:20b:396::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 22:22:18 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:22:17 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 3/3] wifi: Keep disconnecting flag set until the disconnect completes
Date: Mon, 23 Nov 2026 23:21:42 +0100
Message-ID: <20261123222142.1092055-4-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123222142.1092055-1-Mathy.Vanhoef@kuleuven.be>
References: <20261123222142.1092055-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::8) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|AS8PR08MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: a6886f47-e242-4d5e-0c73-08df49b03bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|786006|376014|366016|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|5023799004|11063799006|56012099006|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1Vpkgixvu0g7ag+mtyGOU0cJ1Z4xEncAEMy+L2EcgDczv/v8GwLYkTT5wWKyMqu1z+cqCsf9v6xBslawbN5JuaBliB12rR/p+oJgFt5SDuvcFc3zsrOynEPCmC3ZK2l2XlnpY+SoRgJom1X9gEbEP5kzQvGVGJn1BIZ8Op84nGGwfRF176GtjUWbwdBUDuRPeO/z+ONDxJgSzUsda2P+EalnVq00Mh5vMZSaT/ZQaeEngnLP2RoEgMiUxxr4QDcRfXdjG4MIQ0Ot4iM9JsnUY/NnEaPJVrHofesL8Vv8Tuv4Vt5ZHvlQ2spIHB0eiTA7yVHhM2GnOIwmwGgOM+ZYSOvWMJmEASVIIyTeKwYMvXaFjzyZmg1hq+JzmuL04yiDyPr+5r8Eo7ZZ7BMJGdHYNSmvkx/MtkRxka7Fcd+sO2RpTMjU6zov6NeVJEpiygLwblXSUnQg0Eyql9Zf/53Tc6PFT6D6Q324suT6aaaJQjomWWy76fXMS/YUHtH1Jj9watyXdoC1o1kSFVV8YXlItAb9e2WYxMwJZNy+EcqrMzVzmEXyYAgv6wu2y2hdxs6IesniFZnN8+RrYSRwRi00EUqBlUSP0Ylg6SVuDbALXa9P58iDgaRDlrx2Mv4GF9ngmOsmJ8AZRpsbXzWZcpNQCnbe+1etH/bHrh934CZw3hM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(786006)(376014)(366016)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sLa/OH2o0rfjpWv8l075053p1EzL+AbbsPT2WD76+U26fMqO4qwP1E3w5x1X?=
 =?us-ascii?Q?bTZ5E4hUBOTaiYjDKYQZ/m3Lvz/BKURc+mpzB1baw/B4wAtklC7HlDw5t5IQ?=
 =?us-ascii?Q?2jhHchlPI+F11VRGfNxbLN+BFCZwgTiY7PA8Ht+UrjQyBTT2QXsbJxeB1Eer?=
 =?us-ascii?Q?pMBnmrTFAgj+A8qKQKR4eEQ0naOk96DwSKgbl/6U5S1otR8rZNmlVCbHrjf5?=
 =?us-ascii?Q?mqK6f/c60JQQvlSeejWqchBycNCHrrN9mz1Uc9wrjwLWW2Ej+PDFCwghw/od?=
 =?us-ascii?Q?3lxmashP0LpRLQKNTz7Jdle++ZWbgk1/368p/W3LEqwoF4T2xI43DEBJ5bGY?=
 =?us-ascii?Q?skFfodGEYJNNeiZYOre37Gi+guwTvNrRQ0jZTshMnDMxecbA0/eMRwfrhfZV?=
 =?us-ascii?Q?4ck979+gpjfBfCV3H30bswX0Idb958u1rjLk/CV8VaH+pEZsHCCXb6pTJwrq?=
 =?us-ascii?Q?aeJBFzbSsHEdLFf4QSQXX+wIIpElIA0sC2BazN+yeVkXHKoLPmgtWLludlyk?=
 =?us-ascii?Q?3Z8r8VuVuNZR/YmTJOVoWWBIif79TnAZP/awdQBnveg9wsilPW+7FI2Q99kJ?=
 =?us-ascii?Q?lQDXnJWviN6+87mmHe6QOtLbR+Zdn9QHyI7eM3NiFZNEG9vrqB/Xb592f1bX?=
 =?us-ascii?Q?WR+OSQ2Jb4KKsBu7KnYhCkAMGDV3HiA5MWETukQwTOxP1OGEyQpSJLV1qxjK?=
 =?us-ascii?Q?YQDWblLBLr9YHsiXc22x1PhdMlxsF6+deg567slH6LGnv2BjJ0wkFP+WJ42r?=
 =?us-ascii?Q?OTo1YQXXsPub2yoBfDiuwNV5Q1uo/3r94BJ7Yncxgy8yM1a49SXI+FEUnJPE?=
 =?us-ascii?Q?cQ9/0sYCW9l4BoPYoE8vWasCbCvbh4cLfoEfc3pQ01XAZYfe0YCaW8OK/euO?=
 =?us-ascii?Q?bsuyMSvXtuvIWicZezqLcUAkfPJY4vSvdB2ItwaUlpvTdhriIwoJcphXUWk/?=
 =?us-ascii?Q?5b3cA4fwDpwl8E8gSlkylzm0Ukm9+bP56Ex0eIFR3Rh4AobAGdw9ZG57zmVO?=
 =?us-ascii?Q?0lIvK1eCcZ8uhRJyFgH1ahdnQOq8NflU9mOcgk5Et8BSGzbUl3fxKWMiOf6e?=
 =?us-ascii?Q?Ud5nqsHJkz3LKvScJYsTgOm+Z6ypdPGuYZg7h/ysE/YkJ/C88qARf5xb5QgV?=
 =?us-ascii?Q?91bJybU7S1i2F6YD7eCgp/Fabat7jWLvOMMMm02A9M9P6ffOpPZS2xBtG82P?=
 =?us-ascii?Q?qXej4wgwUJNDZ5tC5JMYp/k4x17Hh/2kLFDEVT5btEacnrZEgPU2ru2kaHM8?=
 =?us-ascii?Q?AeynnlFYEQbdzX1cOakCNom4XSuXz91hINPLD5WNow2B8YF/GvUrx8Vn1NG7?=
 =?us-ascii?Q?oXglJmv4a066U7rKE56LLY+91wAn+ET84n14WXRIUUIvVvo2kmriPCo4lial?=
 =?us-ascii?Q?udLRBKV9Nst/rWag5PZ0u4oy2bwDGdLOXFSI9Q2wM8gcjdmaM9YoCUQMY39Q?=
 =?us-ascii?Q?06jSGcAnlnx6fBZJgnEIbb635iXVkiXxsTOplEJs/KMdCm0cTzK1aiaI8HKs?=
 =?us-ascii?Q?yoHPEGrUpzb/FARSI/BzN069o0crAnQyio9CldaPHa479YuaXzjR2KDvNM6V?=
 =?us-ascii?Q?wOjcbURaWt7jDhjKtwm6RtDff0hW96Y/avWc188vy5C7iGe+JBi+qHOqwWcD?=
 =?us-ascii?Q?rsprqjjN3uryjCUXPhdbo3fS5jBqcuXxQkC6z7hm85iYtmES2Wkt9JqSq7Yu?=
 =?us-ascii?Q?WIPjAPtj945xCGfN8gXEI+g7YJRNO8COO5gP4pkvfj61XhF4L0yGRqUHepve?=
 =?us-ascii?Q?o8M+ZH6+qzFHtb3i4FY0sgFpuW+WdVAJZ2kIqFOjfMKF0PjKK7huwTTs5Zns?=
X-MS-Exchange-AntiSpam-MessageData-1: R3UyDnOX9SxTgE0ndHZTcypAKzAI8rONrk0=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: a6886f47-e242-4d5e-0c73-08df49b03bb9
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:22:17.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gSRzGNXCaicIMfIVh8euF6lg0DrDxC1bmFUuyTlSGrIU2/MsFg9ECu3NlB8dKpalzL8sltUeHH4e0qsrvjhF/4Zx4eLF5XxgYN4KOxce08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6728

When disconnecting and immediately reconnecting to the same network,
the reconnection can also fail when network_connect() is called after
interface_state() handled the disconnected state reported by
wpa_supplicant. This is the second sequence mentioned in commit
"wifi: Do not mark pending network as disconnected". It can be
reproduced with a client that calls Connect() as soon as its
Disconnect() call returns.

In this sequence, the following happens:

1. network_disconnect() is called and sets the wifi->disconnecting
   flag.
2. wpa_supplicant replies to the Disconnect call. As a result,
   gsupplicant sends the RemoveNetwork call to wpa_supplicant.
3. wpa_supplicant signals that its state changed to disconnected. As
   a result, interface_state() clears wifi->disconnecting, even
   though the disconnect has not completed yet: the reply to the
   RemoveNetwork call has not yet been received.
4. network_connect() is called. Because wifi->disconnecting is now
   cleared, network_connect() does not make the network pending, but
   immediately starts the new connection and sets the network as the
   current network.
5. wpa_supplicant replies to the RemoveNetwork call. This is where
   the problem occurs: since the new connection uses the same network
   object as the one being disconnected, disconnect_callback() marks
   it as disconnected and clears wifi->network. This means the new
   connection fails.

The same happens without any client involvement when a connection
fails: connman_network_set_error() disconnects the network from within
interface_state(), which then clears wifi->disconnecting right after
that disconnect was started. A connection started directly afterwards,
such as the real connection after a Trust On First Use probe, then
fails as well.

Fix this by only clearing wifi->disconnecting in disconnect_callback(),
so that a new connection waits until the disconnect has completed.
Also set the flag when disconnecting after WPS, and clear it when the
interface is no longer available, so that it cannot remain set.
---
 plugins/wifi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index f51c3acc..6ce6bb91 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2289,6 +2289,7 @@ static void disconnect_callback(int result, GSupplicantInterface *interface,
 
 	if (result == -ECONNABORTED) {
 		DBG("wifi interface no longer available");
+		wifi->disconnecting = false;
 		return;
 	}
 
@@ -2472,8 +2473,12 @@ static bool handle_wps_completion(GSupplicantInterface *interface,
 			dd->network = network;
 
 			connman_network_set_associating(network, false);
-			g_supplicant_interface_disconnect(wifi->interface,
-						disconnect_callback, dd);
+			wifi->disconnecting = true;
+			if (g_supplicant_interface_disconnect(wifi->interface,
+						disconnect_callback, dd) < 0) {
+				wifi->disconnecting = false;
+				g_free(dd);
+			}
 			return false;
 		}
 
@@ -2675,7 +2680,6 @@ static void interface_state(GSupplicantInterface *interface)
 			connman_network_set_connected(network, false);
 			connman_network_set_associating(network, false);
 		}
-		wifi->disconnecting = false;
 
 		start_autoscan(device);
 
-- 
2.56.1

