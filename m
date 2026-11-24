Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479215;
	b=mJ58iTAHRn04kCKC5eHdCvDEh5sewwuzPBB1QLak9UBxIk2EdUc/jvaZsHgVCNhGlxuz
	 7/iiH1xocdNRsMsqWV4I/cX0cy1LpemKhR0gfItZENyzCdAtaJ7sCKD6A6TQCOUADiaIq
	 hwgNeAxDhbnus6xjuGNFEoiZBILOW+PpyHCGhUd3396AQ7qERxxPJGKFohQ9E2bHcG6MC
	 svDK2FXFyY/zY8d333Bzfzp6Sz21PlpJR+6jzkmORnnT63PyzX0DN0LWDFAwugElqVfGZ
	 np7lxt8lUq7r4A3OhyvQme4JWMcwqY8/RSqvCerP6hhEc+iOxLmmYVIngEYIMOGpWyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479215;
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
	bh=TkJ0Ry3KSW2/yvF2FYclatJn+RR3ePYfSVP7taP/6Lk=;
	b=v5FBJd64KxxqYPz7nP42kVDlWU6mVbwuC/HSo/WlXugdYGzpE+Xclfd6nJFuP6iCy+gf
	 h2rtOjx8TJtgKCb6iANVX44qFdbns8MDMqsB/BhqKpxllymCOm/6e2tUZvF3TzdwbOPLH
	 JJJ2xB/LbDrAbOjb8R3YtYFjP3Nrcs4shps70nGZ8NcHPTYWqlb1r+gv6SNlDykzQxKsM
	 klx7eHZYLy24Eout9XJ1D811ofwLpkdPkKb5wQQ9zLOJIeeZUX8zvQlBMla0Mdj/bwG26
	 lJ5sN0ybhxZgazM0L9n+rhJx1TWS4LX5W9RvJxvVjZLAJOrLx8E7MH9b9G7SA6y9SvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=IJ10N9yX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F0606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70F0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=IJ10N9yX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaHIX1Ces18NYOfIWWk5pcNYdoJ5eYd0EwMcrx08MrDmApmklSKdJQKYoQCPczdQvw0sZOO2QyLM9zNscWkl2vqSCvazFrbg3DBTq9CLut1onb0RJ7EXglcVQt0qBik0+Gp+oTwb9ekwgDbC9mE+0bNO/8Kv8NepY2s4Jbqd4oLJFdmw5t4Bnw44eXtnyJyqa0zz84msSipQlUCkyP2TYhDFpeQ+iKpEk2zYAVRypxdfYPhxufChZlEewAX00066zPGZG6+5abLjHk7vKVIVADcNFJTShfSHX7z+dSFtlUszNi4846p1ZAlBwxpER6Ky/KW1zVCVK/4InZJorRUuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkJ0Ry3KSW2/yvF2FYclatJn+RR3ePYfSVP7taP/6Lk=;
 b=kZPQuZWn+Ro2KwqRE9B8EZII0yz9hCdrOm13lhjzfDqqlZzKVbE/R99DiOh9p5Of14jZWkFFbshoyDp4lUS82Xw5Qaveh70eP/d7TVdnWbjUQGpjSGIw5fdtHTB7RPcmvnDteKm2x+Ke/yq9naU+AmbL0dwsWYRkSBo8kyLeXYDS0fw5eYo+GReRO6duoaUQundPLjQ5s4rC7DlL2e/4bGLEHGxq8V2pb+mA/1PXyQ1l0MzPxRYup9rgQnGpzsphZKJWW7iV0fKn1Hk3zSOSyaR3H9vcpG0xAD4fOUK9isFscmCqL6ydI1uVm8brCYE46YOSG7R+jDeXCTu3MBzFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkJ0Ry3KSW2/yvF2FYclatJn+RR3ePYfSVP7taP/6Lk=;
 b=IJ10N9yXXowa64Tz/GFjpUEQK7Hy6xnWsSP5lVflAu3AGlqdzc2FsFBvoTpIgjnOOATOyMI28y3wrOVnlHjRh+L4miPyVJyN2Yvuz+up83Oavv1agPWehBfRCjjlxVFxrZk53ZiD2GujXco/h7dEygF8XvAF5AMO40sMKQcVx6E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:31 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:31 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 11/15] doc: Add TOFU to config format
Date: Tue, 24 Nov 2026 01:13:07 +0100
Message-ID: <20261124001311.1161845-12-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::14) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: bf8f8ba8-de00-430e-27bc-08df49bfc565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261022105027099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	f+BGShe69mK0GqMRy9l8P/mQkgQFTwt4dhBH7b4aXxnZsN6xCaEuALC8mm70rnkkPyvKEdMvAiC87v3g80M20Ox4Uc6bSn9bFsHUAbq+R4XauQTCxKVS4PfV80JkQ6xb1+VAF4ManmmK0Biz39Zc5jMir65C1yyN2CF6Jlnu6ZQrOFGDSh2NydvB1rILH87f0HXSd24JTgFgp8CJA5cY1kgXKUxXgjC+F2ZKdVW0Ez47qqsJEDb/Fflgfc1NR2Ir5lIKOsaU4JNuZ+6eINqL7C7HJH6ykI0659z0b4BjweDUsjLnFMHGF/FB0eC8Wn1lnvzIaZJCrPQtZnb4aQ/+7z3FHIGkE0L2UdXypRPYr6a25I/n0XetK/tuTScxu5Dhk+t2FOVcHXOrdu8OGg0mxt5oDUZwLKy7cSmPWEZKUcVK8RxewHIZkLbLxLifrnj8LmoWvQh9UzZqoEDBgBIe3QBOIo8nH2ppPQu+AirpbsNGisPgUBnbHzwf95wywItzt8URG18e5NyNxVXfpCLTY9cWGJepAewvgMBAhDWQ5yebmkYwXr8HIo6Ct8aQgjRGMuGtD8eWEitgPohVwRrPI4MHnBFD3zQhBl/UJJJYY3TEK/qoWlIPn2nx1H+TYXxnUdZDlFUBMnaqRvC80BE3SI5AdShaq3u8onSCDZaZBhE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCx04Y4m1miAwzlhKK7v8A05Z0VlleJbVZ4SMjAUQpCTrXhspdAu+6LFI3w+?=
 =?us-ascii?Q?OXBfBPDsCsZj79VlLAE/BveVkdWCkc7yYOGy+sKXSJf3lnXlPLwjyiOPqcoz?=
 =?us-ascii?Q?SO/gJL75FBerp8F1j5/9pZR4wlUNJlHt3gzwTMrtW2wrhtPutPKBnZcKbn0y?=
 =?us-ascii?Q?147Az0YXzu+6tj0p6ngpwvKRsFXJxkf9aGfK/uMQqftF5Akvq92aRfcjFnRi?=
 =?us-ascii?Q?3qHY0NLL+rBPicw5G8oXPekvDd+UHcnDj2/W1aXQgH/BX2B3az7mxWDeqpeB?=
 =?us-ascii?Q?rT0HXLNNyHOEEjtZL8wgDNEVCi5OVAnwUw411XoFtajJkDxECWie8FmoWkJH?=
 =?us-ascii?Q?ir5xzbh58OnedXzsdZUXMhsnuzn0iFtGuoayy1oKMm7RS64QB3VCGacO9PEq?=
 =?us-ascii?Q?kvnpCFTvh9SLGlmOwZ4xn8JTMUfLOUEHAB3qEjh1+36PMWE401ACgXGPAPNd?=
 =?us-ascii?Q?DdLkgOHNb7VF0GvMWyJTYphK2EJ6PBZT1Dke240BoCBRuuozrE90JO9l6PA4?=
 =?us-ascii?Q?Ogm4rEFRasup1V4vRdoDBkSJS6sD1ETDQuXCp7p1fyB0b9U/Hf4pBq12dj7I?=
 =?us-ascii?Q?AuaL8hkUMySbdcWtkFuAFfa3yX2CxlSHKWGgnmYkx8C14Sc5+xSlhVp1Vt2w?=
 =?us-ascii?Q?0EB93qKa5Fj6Q2xYSAy+WnimemhSF+srRsGQOxSrTSGdWLCd671lWvrAtElb?=
 =?us-ascii?Q?TvVqg/Fn0lzEKtL3R2XcFoOkBfRqLZjclovKZHb68Gb1lukfEDvdCVMsq3+H?=
 =?us-ascii?Q?uTsbk7iPyX9fpQ4VM4XVbJX3WNHofUp0q0qSI2lwQIYDVfQDgF/AS+q7sIAf?=
 =?us-ascii?Q?guJrmTIzY+WdcqNBwoNAyYcyD14dYgNInwTE1mI5pTTXKZjEUbXl1EWkZa1h?=
 =?us-ascii?Q?40d0tgZUemNj3tCrgaTxs9Ceac17jchbjKrL7aMK+/hXVpGRsLkJwuGDutqr?=
 =?us-ascii?Q?g3jNjL/9szuZB/TElnoMS+UuusN+QXAsb1hju2lVPnjLMTDYWOEzTJc6A3dA?=
 =?us-ascii?Q?VyJ3XiFUmSnuIqYYOsZ5d7eacQcbTDKn0G3Dzo8Bpyz39HK9mIszTqH0JAN/?=
 =?us-ascii?Q?NyaqhvwGYu0DWqwuo/1A6F+rwaf5CMVE65YZ5ozO68iaJNJCmLHIQ/dfQx3P?=
 =?us-ascii?Q?pJ3lcnM5ooBSzrBFmbXH6T6MhHDAj8yNndij/yo+2Q4FXYs0VAA48zjsJfM3?=
 =?us-ascii?Q?4u2Tpw9OHMJQg1kURURyomcRp2P0YES/W4R6B0sR+SJt9Iczpa72cJaOS6n7?=
 =?us-ascii?Q?1MA2ui+fbVWcBHU8/fW0HswPoFb3xuDIV48+1br7DdfLroZiGIAhhkkm2JFH?=
 =?us-ascii?Q?iva297nSmno2WzGwGImo3EjSHlFpW0+ky//PnROAaijSv1Ced9RF2Q+AfGGW?=
 =?us-ascii?Q?g50xhKJDBfMTxmhIbB67IwUpwjdwzY16cb9U2B95t9Hbana7lBRk+3SY7gw2?=
 =?us-ascii?Q?w1WTQsTVWsK2i9uS1ufQA1PVFyD+BSFj3KL7jiwSYoQRLtqk7h8W/v3ZpxzN?=
 =?us-ascii?Q?TE8noLGJ4da3z/ozgrfCs6d+M50ijNiGRdFXyGAvDoMTvV2LjpryUXGrSIrQ?=
 =?us-ascii?Q?m8yXuuSueWr90/WiM9v4XgE3CsvGY2HZX8wvPZ6fn4pdqlN71rt54yN9Z/Ra?=
 =?us-ascii?Q?UQIO78rXUtHo6ZfSoWq4R2Ir9bP38hwN3+mRvoadCKEHs3n0/dahx0ZIhdWD?=
 =?us-ascii?Q?wzpgAJ9vYpRUuQYU2TI+ccRcpNK2s4ZxSIrO5vJoFPisjcKaRPysZrPJjhuB?=
 =?us-ascii?Q?qfXA/AE/6tQkjH8EomAmrk1QcvkNAM6AZi/eWDmei0Qd77Q91kjaIaLVEPOi?=
X-MS-Exchange-AntiSpam-MessageData-1: Ok4WBkRnZjeD1yah3zg1eW7jON4G562Tq88=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8f8ba8-de00-430e-27bc-08df49bfc565
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:30.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAngRu1Y44pxV5uHKhgAAVxRsYUXg6k+AkFkxNk5w42dPo8Vrro6FpEJbOPbOvyk3D6P0Cwvn17ETr+XO0tzVMpGVbGghw1tE8lhgVU5SXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 doc/config-format.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/config-format.txt b/doc/config-format.txt
index 5420696d..04a09cda 100644
--- a/doc/config-format.txt
+++ b/doc/config-format.txt
@@ -114,6 +114,15 @@ The following options are valid if Type is "wifi"
   passphrase is present and 'none' otherwise.
 - Hidden: If set to true, then this AP is hidden. If missing or set to false,
   then AP is not hidden.
+- TOFU: If set to true, the authentication server of an EAP network is
+  trusted on first use when neither CACertFile nor ServerCertHash is set.
+  The first connection is then a probe that does not verify the server and
+  does not send the password. The certificate seen is pinned and used to
+  verify the server from then on: a self-signed root CA sent by the server
+  together with the server domain name as DomainMatch, or otherwise the
+  server certificate hash. The pinned certificate is kept in the service
+  settings, not in this file, and is forgotten when the service is removed.
+  If missing or set to false, TOFU is not used.
 
 
 Examples
-- 
2.56.1

