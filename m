Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795472529;
	b=RVrECxOKLXuihczZtlyfvUSW0/WNCRE+LDIZCHFY1F1gR4T9v2waDud8LL8U40lN4FYv
	 ZcX4rkR2N1gOqQ3hdSyDBpBGXFBejC2uE5/2ieHZghIrd45sEfmv+COj+py6xNvvizkVD
	 0mJ6e83cZitgFvGgrcFyOMQz1q+Xo15hBDzbuBqTemCd7TOZv3f+wDH6+PEtGEVrTeGQ1
	 8bW1wuERVMWDZ4NWj7pK8hpC/iW97ChoimliXMwfGeJYghQ+Fxwxyp5ytycMF2Q/2RC+o
	 j/V8ozipIwFrS3a/4JBzbs6IZZtIHKjQsFmEuKg1JTdIOE+kZAN9jlequY3PrClltaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472529;
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
	bh=4gR9HHlnEcWjX2hqx3VNJ3vB6jnpAbEemcdE/ZK58/k=;
	b=A4kPDjRUm/5doacIrJH9pWaRkg4EtJ1H9Gge/zkmAEG5dku2R9/j9+56RgrQu1e3pqDu
	 3StA/6vc2u1gdiuk/XzIcUf5i4fV+V12snA4cxWGhVIAvicCc7OUprKqtVmGYZBEQzZ1G
	 X+IhOH98ce0h3GG0ShooVLVugBVS3xtlqETZcV0ENp/sRyGpG4goYSjnOAWIr79xbOphm
	 WdwpmhYBJFREO+M3xEuvy4pjFQsikXo7nf+3zpIR8dK1TjTYl/ulNUzd8J1giSjDTZWLP
	 0FGKUapXr1NYPXepA1F+AQx12qWiPkp7RUMaxHLsKS7T0JYtzigCH1pXIz1iSYnBSYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=IBzrMdom;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.140
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021140.outbound.protection.outlook.com [52.101.70.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE06606A31E
	for <connman@lists.linux.dev>; Mon, 23 Nov 2026 22:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE06606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=IBzrMdom
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzhyNzhJ30r30W21jmFREhgk29Xv8tdefTU+sJ0cokeaUIAzjFUOMMmA1pRjVIfzBRzPFVbU4f/MnTLAlYD+Gbv0jRpuqYvKoqtGxDX1iybY0M7gzQy4UwxAfsBMzXiwFdpiBtb1rKpve4KLb5pRiIvROTEfeuGj17bmZUZxD/9b8jwhpY/5aKHahDhf1rBBaP5TDUlGEaycmjxCLM0sNpO42E4kZ1vV5/mzHpH9amf51lkKpncDSKx9tQyNPC4Irvbr+JRqGN8vXTeFfVbKgO2Pt/xWW3Bf0MCnD5J3K6sdm0ACFrOHhc6bwMSVLxJo3bI3a1sbFL3FdAFv0iki4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gR9HHlnEcWjX2hqx3VNJ3vB6jnpAbEemcdE/ZK58/k=;
 b=NKFjEASW2wEgGSeag3njqtKIdCMShwDANbiES2h+SdiwdSpCMCgOOewIZZqiVCPsAh436K+M80/4aoc5NTzD876S1uUPGJA9XL0KjaAoqeWKKEZOdWotZshhvUugTX65f7E8QmREgKOtskzrfLG1GTuett+v93vYJT0vLx+AQn0oXbP7AheJxBWrGqw4NautTDeTdHZZukModB263MVeGWp93GBGNT71IHspVOESPR5kJx1BvF1rW3oD0HcehB8FmlmxjbSw5TWhKE+I3sDI/F5LTBEKRkBV+CydTOZMtjWAjc7cIgAwWriS2IVx0Y0Zu9bh5iCP2MLDx0yYr2deCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gR9HHlnEcWjX2hqx3VNJ3vB6jnpAbEemcdE/ZK58/k=;
 b=IBzrMdomG7ZvuC/uJ4fStWQK+UAIywiDNgYNBW4gTXARG2o8iHVPbqjvlvvmTcTKRkB1p6DhAgLBKYQ9H59KA51G8Fer3mGzz7+GReo1xUfssWTszWVM+x6Ty2tgPjQLgikOZPBH1FPPicon1LA4PIGIFsEx9toEg4cWA8QOsHA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by AS8PR08MB6728.eurprd08.prod.outlook.com
 (2603:10a6:20b:396::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 22:22:06 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:22:06 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 1/3] wifi: Do not mark pending network as disconnected
Date: Mon, 23 Nov 2026 23:21:40 +0100
Message-ID: <20261123222142.1092055-2-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123222142.1092055-1-Mathy.Vanhoef@kuleuven.be>
References: <20261123222142.1092055-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P191CA0107.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::22) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 75a8f957-0e42-429b-4ba7-08df49b034f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|786006|376014|366016|261026121527099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	utviSM0jcrrs8JcJLFYvSs2ukq1QuLmlzo6YI9RCWu0NMgZtmqWpqcXbxAgfM7wpR+zC2e3dEijjW+/kIMPOBF6tBLOmRMIzcie8HmyZO6UT6DXWS1QoJQ8cARz6J+UuHL9cxMVHd0wNTk5trTLLopID0TfdGwhUC2ihXKj7aH3402pgmjoCChXG/op6YhKp70lD0l4DjXQgH/eF20lkPZV7Fi0EXb7KtaOyT+HhciA+dMPijZoVyz7GIJT3sjfWHgiHa9svhRct+fIl4k9vnp+lV5dJ6TpUDyi4Ueu7MhPk68FoshdscLRfl6oeR3v0R4Y6XF5ug/sjhAYxFZKBOs4IAbb+TTZpOtaLb7jsVrGEKKWf40uFpaxXahMgR+jknaGF6yYg29F3gYaqUCuXAX8/o66MAO87yji99P7ZP1rysiFV7qguNSw48I9d8QZnjOZpd2fBWMyl41et/UBvGmThHHI9onfDDV9syLXFOlJWQJuX4dq0gKeCWjtQPT4nGHHis2Z3DJ0Oj7teroEb68GQpm+2j/ZcVKpNJuB7yaWhMDSRIiQyKYpvDmg3egEgrwF7ruxkI39xcE9RJc3FVazaXGQUEsbImYdIBA1l5QeSuywekFgFj4helohUw4aX5vGW2scvBZC0oSkoUiXMWYNs4Mj/vvbv7kaQvbwF5b0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(786006)(376014)(366016)(261026121527099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sq/M7UTLzPTg9ahKTWwLdehYTxWWWxhRtj+Cvq4drEitgI8oxSZ4Z8x9074z?=
 =?us-ascii?Q?de/OrZdr3toj5W/9Cbt/a8Y60pm2sh7nlS2POtm2zC4Anf5yzgbFoBr30bXH?=
 =?us-ascii?Q?X9dnHR5gQZ7s/cjUrZZEwc7iEK9jjJXWcgYeQkZXIngnlPCJvNysIajanCS5?=
 =?us-ascii?Q?oe5IgJshPNUURQF75a8NkQKghv0pxJxTJwNHQruzxowhF67TvdaMEAWkAmDL?=
 =?us-ascii?Q?yPg3FswNZcY3PNNqo0l9Zi9fWaM9B9UXz6Ee8zCYflvkuaizMBPqKwwXM9gx?=
 =?us-ascii?Q?WKAO0AdHVtQc2Vb8Wsrr0DwIUCQZjLv9kwON/N2ylo997fEzBhPP6WCaNV1E?=
 =?us-ascii?Q?kSfPw3XSjHrxg8/YYoeLSnQtoED4Ns2KtjA55q4dU115LttqTm6+COH7He29?=
 =?us-ascii?Q?B0z9J/OOtO4MyJnufPDOoFnLzC+u2ooTIaI6EvK7i+Y36zObifl5MzeUpIjx?=
 =?us-ascii?Q?1QlwwSn8qT4Gik9xujxZ2llmLiprQK0ra00FG1EH3F4CAYOsAiTzXvlFfJHR?=
 =?us-ascii?Q?C2wq+tHv46/5fj8Oc4Bbku54DFrNdr6oivM/bmPxtS/omi4i6KBaL7RQqs3p?=
 =?us-ascii?Q?QiFw+lFUUm4D/uhbHeeHQU1yEOLgUedr/s4g/fqQnDF1m4kwMAcJ9ouwy68V?=
 =?us-ascii?Q?lEh7MaP3oJIKm9ZCLjzKuQtXBTwmLgq6T7/a1aHHVXCcNlFY9oBOq9s5J9Sw?=
 =?us-ascii?Q?ulsGr9bk9YYtzADm/yfjmVW4vw+ovq6nSQCJb1CxwFcid9xvcbArCoDJi94M?=
 =?us-ascii?Q?mKf+ABE4zFiaEtnLq27DNhJgZ3/veHy+UKCR3EGSRhs5HBo2evF5wYGq1qvC?=
 =?us-ascii?Q?mbrhCDaYbcCV0iC0BtbS59nZ+VdDNemy7t7SiEMbUs4UjuSlc4RvnAa/E24A?=
 =?us-ascii?Q?jV29lMLiJWOWYwtXO23IGWAThWbiUujQdqolEYX+bq6Lk9zDqMsek+9ULdBU?=
 =?us-ascii?Q?dn6QBJQJtBYPIizg6rrDDv2db2XIVjejsI7bBGJ2306+JJNhHHhmAXmsxMcz?=
 =?us-ascii?Q?3bNQLm7tiqkcmVl4NBnzlP2XyjspRevTUMLSMOFvgU2b8CJmP9YrRJoPkf5G?=
 =?us-ascii?Q?rThRGr69V9beoPQI+0DevAAFESmMxbz9D3SXgFh8PbZWxphMMm1W0G0sHwjJ?=
 =?us-ascii?Q?yLFpQO2ZXWMqGL3YuEtzOEY6IRJNFO4Ox6GFVa8gIWbP5VO02TUo0+fvD49f?=
 =?us-ascii?Q?MJ8DryiR6dtR4b8/pmb69ia/13ToOUpjqWxVmUfAfZxY8m7iIJosCKs2Y27n?=
 =?us-ascii?Q?z4u6hSwrkRTVqNAgIjkQhalfcsS7Rjber8ArSegIkSsUBj9l7qstPxO7kuOz?=
 =?us-ascii?Q?QfSFPY035ZFWnljtbQPfJJV4oJpifADDh0jb7zxTyQzYVlsFjf3G8XLcOc5T?=
 =?us-ascii?Q?T/8vBR07dQDf7LbTw8X0oiZW6QQfjSVW/KKUYXnTFnv3zHYmtKg7JA1BmXAM?=
 =?us-ascii?Q?AubL5nl+1JrTfJlN9FibOtevIvG/zOaCaYT0GoELWR6rz+p0GYPovLP5SmCb?=
 =?us-ascii?Q?6lbjEf7WLq1m6qJwMrS29gthn8txaTXbTBs9VEEMjcQo/Vf8QZbND4n97HVk?=
 =?us-ascii?Q?i7ih9uD6doT2FJSuqdPZGxSfTy1lD/MdqyiJhiLdv8ATdvXGn7eU1xHac4jb?=
 =?us-ascii?Q?R026kZf6DVWgmsdTELdH6BvxIvFnU7a99xK0fLGdxH4hTgPmrdhc5Ousg4is?=
 =?us-ascii?Q?RdgMBOxIflmZTkwaik0nAcVCMfkx9Soup/IBNWXABM8eFZFABgLUBOxVojdZ?=
 =?us-ascii?Q?r/ctLrMs8zg8fbj7NS+hWwx5X2tzN0Vmir/ImV8mJ0UaF8u6/xSDcND8DYNG?=
X-MS-Exchange-AntiSpam-MessageData-1: LiS3YOuynToXCO6ODLuw/eraxc2HIEhBULc=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a8f957-0e42-429b-4ba7-08df49b034f1
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:22:06.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YiRmzLJ3SSYtQ6Xe4fzrzN85aYv6SH3Q8UDu4+qaBTgSflNr4BaILZg9yfGt1S5y64OuZnHWvLt0EGXeLAvPn3uvrT+e7xtiHRVvIUl4to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6728

When implementing Trust On First Use for Enterprise Wi-Fi networks in
ConnMan, we observed bugs when disconnecting and immediately
reconnecting to the same network.

Two sequences can occur, depending on whether network_connect() is
called before or after interface_state() handles the disconnected
state reported by wpa_supplicant. This commit addresses the first
sequence, where network_connect() is called before. A later commit
addresses the second sequence.

In the first sequence, the following happens:

1. network_disconnect() is called and sets the wifi->disconnecting
   flag.
2. network_connect() is called, sees that wifi->disconnecting is set,
   and sets the same network as pending. This implies that the same
   network object is set as both the current network and the pending
   network.
3. wpa_supplicant replies to the Disconnect call. As a result,
   gsupplicant sends the RemoveNetwork call to wpa_supplicant.
4. wpa_supplicant replies to the RemoveNetwork call. This is where
   the problem occurs: because ConnMan has no separate network object
   for the current and pending network, the code

     if (g_slist_find(wifi->networks, network))
             connman_network_set_connected(network, false);

   in disconnect_callback() marks both the current *and* the pending
   network as disconnected, since both are the same object. This
   means the reconnection to the same network fails.

Fix this by never marking a pending network as disconnected in
disconnect_callback().

Note that this issue appears to have been observed and fixed before:
commit 76d2475db502 ("wifi: Fix disconnect/connect race") added a
practically identical check to disconnect_callback(). However, this
check was later removed by commit dd86f09107e8 ("wifi: Always
disconnect connection completely").

Fixes: dd86f09107e8 ("wifi: Always disconnect connection completely")
---
 plugins/wifi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 9ce7b5a3..f51c3acc 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2292,7 +2292,8 @@ static void disconnect_callback(int result, GSupplicantInterface *interface,
 		return;
 	}
 
-	if (g_slist_find(wifi->networks, network))
+	if (network != wifi->pending_network &&
+			g_slist_find(wifi->networks, network))
 		connman_network_set_connected(network, false);
 
 	wifi->disconnecting = false;
-- 
2.56.1

