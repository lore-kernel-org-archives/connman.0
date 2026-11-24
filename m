Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479208;
	b=SRKwly2N4APYZhrWkBJzQ0VRqhBBEXek4IRAIX+jN2bSaQB8rkh2QvVSlCdorRzs58ol
	 EXsF7zeWByJEKO2/tDuvy0f/0IpCx1WvJDT7+rME7+tuOyTQCfimCp0UeNfTjpg0iihD/
	 MiUz9SBmL2SU7FjmaBpjZliZyTQ53Dcy77tFr8S8ecFnoqbpbusEzE9QGl0lafI3ksUDN
	 3jKFtpg9/MWzOIwPmLmGjKMuqaoJNU4VMRP1sQB3pzYXxtkMZUEtNi5Oxmg6yn0rAfvPc
	 jGgcE3DCvOmJHHlwZPVE2ZGa445FMOqIzn+rh86+/2Gw0aYriRelN7gX6o1wTGwW1mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479208;
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
	bh=ZjBqCoEYsYYLhKNo2ZlJ3AS9SZ9htgzdSGUDcZRTddk=;
	b=0UYeMsb7Wi9wUfYJN8dEt1KGa360COJPTmynFHwIdeeSpkvQEJUZr0pBhliE8KpxhuZw
	 k9oaMx6HTX7NpHvf9hf7PzloyVVtGUmteXN5VlzvoiDlP47B1HkUzr0liruKcZkzH7PUb
	 W+/oU5rY6hwv0jWmZ9y7+pUSyP7dQ7StyExZjFmkLvqyjCJGqqfKxzsH7UkzzgZthO2/2
	 SG5RrnuAfDqlncPnMCk3esiMh2OErRhZCJT841wih1BGPWoGUSNLACOha7MEc2bkGT0e5
	 3Ka2AwHMUBLdjHD2NG1UKQ8LVqpPMffnNsdh/8rd72mjRjCVnXjECAn1ggshksC3E/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=nsZGn78j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CF606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 659CF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=nsZGn78j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgj0QFr2DHcZEQSRZCzziLbu4k4Km0ELWNdFoXggSMzF3nWRNzjTX18Qd1wLIN/3UOkRPrRcIj/H5i5nIsqeQr1vmHJzHgeJMNhHyPKCW87Z7SaqAYPTM3ar5jgj1PlNYQ55ogDZTB/CLox6Ot/78ec/4LB6eNvIMzKeo0cCUXIstJTehP1HDjNePFgRBm5H7HirU9GVhItnMaGpd/Anh28wNJRBRSiHHcM/vFwun7IqSxhlgS8A6hH1sarK3wjTJFVzvA6NMf6u0i2GH+d0Fbt5Sd0XYCsHhlqJGCro0BtCBxLoELPHRcJ4r54YnkaQVkNsKcKZxkfoLil92Mi+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjBqCoEYsYYLhKNo2ZlJ3AS9SZ9htgzdSGUDcZRTddk=;
 b=vcYgfXrMvx+mbfCqa3ISQznbkdirmJ2zDjhEqTSm8ZqYg1mxhw8Y76IRfTRqSuTuYWOtdiYJnZGKnGewOaWEkCEQiVnxttb3l1JVKMOWkDH9+g2yR8Xm2iJKiaeq7tCYsATZVDHL3igNVdxvAY+p5XzuT4UHBtDdga3/DhipVfkosJsHVFwH10+HXruA16o1uEY9nCAL+R4TTop7X4HE81ifsDZlahgrx3+ClpLSQJ3o/aW7J3Egn9HWIcj/OvWMWpKtE4yHY9C85M9Tq5cMLt7nlBCi8N1JMLxXufSO1LRCDPBtz13PNVP6jyEt6vzO9OlqEBEuK6hs1yC9l5fxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjBqCoEYsYYLhKNo2ZlJ3AS9SZ9htgzdSGUDcZRTddk=;
 b=nsZGn78jXsU6BdaZUg53MeF5vbzAaaY7QbW/2IetBYhkL3wjeQvhJzv52S8K25znN1b1hqPddERIRbB63TwZCNUPXz/TAgozQtVnnK2fGM37Hk1gKucgjAkforV5ux47IAePYL5+OkXgkfOchUcXYiDG0lLu05ehwLx+riSefok=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:24 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:24 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 05/15] doc: Add ServerCertHash to config format
Date: Tue, 24 Nov 2026 01:13:01 +0100
Message-ID: <20261124001311.1161845-6-Mathy.Vanhoef@kuleuven.be>
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
X-MS-Office365-Filtering-Correlation-Id: 0c5e26b1-0496-461a-c504-08df49bfc17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	SUKyni1fuAi2XXKoooMSPpazVIiAhgZKcwxJWT0JMxS4YGcm79PX2EvkjQo9z9WZ+l60/HkgHcpyKt0OQM67wu0on1NoAKL//CBpFlvPL/JfFSX8ff4uIWIMJE8Vb3Gfww7F+zsO3fA107r+9Jwbro7jme4K8uh7KoWBg7ap7ZtWJPGMUe8OEvqd6uTRdzRsR9uJcQ5JaXv5OoK+mtTVTv+E2jpUZTUNgsrC5YG+pA+1CMZ+ssWhRUBpd6G+VIfacb6sLxJJl14cgwJVCan65nYu101NH3OpuKUeLCulnm6o6lYcSSQNHMa58V0Qe/g20djxSAH1oEI8d+8jymr2NGM38P3F7SUSXnqH7Ys4KqEfmSI6quLOatn3W0KOiGfmpE8qIC7i0BLxVqaP03k/1FXwTDnIMvv2VWcJrbf0ThtR9QrJLMEbS9uY9vVGSt1e0DIj785+1j1DWioY0tgUA511xCsjQeEykRCpn41Un1ne0SJKu6fTt1VDMWYbn2RMxA5peibUZu7A+9UdOIBUiqiukTusMNjQxUfByrGvQsQ/Bc71srdjapIvzWgKr2oaXYttPGir+I/dyl1ZqMqFycC9bn8nTRCRiSQbjl6agNR+rugHvtaFqAWaytl0Vi/cot8ZL7/OQbTWQcesqUP8l4vBqrmkCTs9I3T4PYezpPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+Oh60MKLPpZ7Ec7DLYZldk5W58YzkAKtF3LLpvTbw9Zb3BQ7Olu+ofY1ePb?=
 =?us-ascii?Q?i7iKn+jxCpyLHWnsiQTaafUhBHb70dDFobzzRuU1IINE5hmEMj+aI1Cdzc9F?=
 =?us-ascii?Q?RPFWxwlz4td+SeSG1ukbCubwzjEvR8nnW5TLSriDioQKVH4DiaPBUyoRM9ka?=
 =?us-ascii?Q?unwhTcPsMlFVYUX4Zl5uwj6+nYCmSmH7Ucz2TFXhkJ7uZ1w0Q3NsotwgMaOE?=
 =?us-ascii?Q?O1rL7rdrCX0ljUTS8fK4vH9CdJKAKYxGGKF4vqJM+YdYbtXzYE0lHucFkmyL?=
 =?us-ascii?Q?T4/KKX6iSjlSEFa/YX53vODwqtAJVsDbbERRAhCq4tkCTGW+hNqYNWveSByi?=
 =?us-ascii?Q?iD8xzYTMsgPLhTq4t0pVFGbNLjNdvyHRxCQTUdbyrXnfwLegmdLkNQ1jLXaV?=
 =?us-ascii?Q?TYVLyV5W8dBQm4rUaFkLXInV4ktc8k4Pr6fNFPt8arlA/MeXHg3RUnqmXzel?=
 =?us-ascii?Q?N/I5gPzPcQX23YYZlgdZe3DfC2cBZWVR4P8rD+j+VG7T+fqLP8IghEj6LtQL?=
 =?us-ascii?Q?f5C197CGhkivNN4JesQSknLWoPD4y6y6AhHB+w8Gbz1PjBCfJLU7ljhll9Gc?=
 =?us-ascii?Q?4GF1TjN8HuM9of/fprlnYudfG1nAbhULbHNw/kZyPb0avuYJ8eX5Hd9MgZQO?=
 =?us-ascii?Q?wEp2SMORXuI0eHWw1N1d2wOxX2X6lOqjbucEFe2zlgcV8ZLSsyHltzofN+ky?=
 =?us-ascii?Q?mWiemODqLfJ4/oiiNeFWR6NF94V+dMxVSKQRv0Ax3z2Q/u/D1171w83m+xD2?=
 =?us-ascii?Q?J3uX2OmpCRXA69lpa/xjApHIYJl4gC9lnrv/PjdVDtYj8eLfzw5ap73laMrc?=
 =?us-ascii?Q?i6mAfRsVeeccSsMx723MgkGvAFSMECXf/AsK6pfshluoDYW7wPQrzS94j/jI?=
 =?us-ascii?Q?ZILRH2Z1lVLx1v4NRnsFFs1MfHxdwl7JifXmHpHYh5mUegxTDoeBwP1g9x72?=
 =?us-ascii?Q?dyPP79PHmsjwWPakzZS5CaC38j8/O/xuR4MK/EE6yMDq7QnF3jL19PuybHrx?=
 =?us-ascii?Q?q6JmwR6AuzKojLhbPKqecLq4xbMbpdoNm30wtahSYgy9X+H2OVTUT7a82CtW?=
 =?us-ascii?Q?WB3U7zo2QFbR3by2aELsYeBJUuv8aws9M6bLfh+8Axl7lyNclUJQMv1pvp/Z?=
 =?us-ascii?Q?p8Ixz//7FAERbBQ1EccN/0oLE+2/5TuPdNeAPfBXfpS+4ejIubMb/aFP1Er9?=
 =?us-ascii?Q?YAzWRK/+qngOi8FkXOv26ZsqOlI7uxGT17GHvKvjSbkwu40yNeYInyBVqtII?=
 =?us-ascii?Q?W152C0zICtymZjavJHL35fVBChAEkZjfEFhzgMMQINz0U+XxldZGx4S1ipzj?=
 =?us-ascii?Q?8yFLAIqWAyxG59GNdv07yq1IZKq8xsoaAy1zTyJRfsmHRhbLOR/gSWIR15Sq?=
 =?us-ascii?Q?x9JWcWPj6YNDW8JJZJ40NVzT2r1g3SZ5XTFS9McVPrmDhuntgdOtbcxz8vgk?=
 =?us-ascii?Q?gPV1sLDZaBE/3lBOkUXYdAly25Qgp1ixGKmvKlNGYeoDMObvAHX0Msmuxj4I?=
 =?us-ascii?Q?9YjThPnDlY2X0i2Jsr3MtlCioLdUXwwWS9k20qaPQuixHez9Qh8nFx2Atrgh?=
 =?us-ascii?Q?IpQWVm4TD2u5p2bdQ3JFCmfQMU94JfIND7e9hrm5wPvH8AyDmBEUtpld3SDn?=
 =?us-ascii?Q?n377/97159kdJvERwUhXOdEW8mTaPO7OQBtuXQLA3B7U/9PCG/z4T5kCAXwj?=
 =?us-ascii?Q?sq/3bsYRZ9+5WZO35wCx+YhhhE2/88yEgV6DEOn6C7G/VWDsvhCSu2fGX9jZ?=
 =?us-ascii?Q?VRjmS6MVJRYL/8AqZGoAbzmglks52ZHCMspRl5dYWJZE1utheUjaRXxYat9j?=
X-MS-Exchange-AntiSpam-MessageData-1: sqRNOrFDdAqg7bTRQ+uOWas6+207qdO88oM=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5e26b1-0496-461a-c504-08df49bfc17e
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:24.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEYce8EYNUg/RuJtz0LZVRMSLWhovW67gnI7xxYAf5qrnk/n4gdkzPyeOjD7dsqmWIquvS4lnsRgZVn/eSEddO8+YOKzfmU2B17UumD2wyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 doc/config-format.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/config-format.txt b/doc/config-format.txt
index cdde9cbc..5420696d 100644
--- a/doc/config-format.txt
+++ b/doc/config-format.txt
@@ -82,6 +82,10 @@ The following options are valid if Type is "wifi"
   field is omitted, the Name field is used instead.
 - EAP: EAP type. We currently only support tls, ttls or peap.
 - CACertFile: File path to CA certificate file (PEM/DER).
+- ServerCertHash: SHA-256 hash of the authentication server certificate,
+  written as 32 colon separated hex pairs (e.g. "AB:CD:...:EF"). The server
+  is then verified by this hash instead of by a CA certificate. Cannot be
+  used together with CACertFile.
 - ClientCertFile: File path to client certificate file (PEM/DER).
 - PrivateKeyFile: File path to client private key file (PEM/DER/PFX).
 - PrivateKeyPassphrase: Password/passphrase for private key file.
-- 
2.56.1

