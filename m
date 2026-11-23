Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795472521;
	b=H/7uCVP9pT0QFdP5CkibZ1VZfkJPWuF+hIGrh9ktxRHoedOOB2l+486lkKu1fpVSU+Ex
	 /NgFIeeyCwyjHp2eyy1nivLYzOk1XfQReSxUPK0v2YghXvo/qH72CkBhNSZ0imArOzBbl
	 5pvgeCNsMbKxqvY2gksAYUnLXjmOwde32XqRIl5ZHxhg2uS3V5tXFTUcNLCBHzaooot72
	 iDOGCnvskz3EpdIMUcbhAwl6rROoTRVSoiTpJl2ppaSslJUyTmIQbx0RDx9gRgEKh2ksT
	 qTSLk1yzITAhC0fZt/mT8Irrcp4WCBWRwA8+QCkyyy4UznJ1iwx16sfow03okxxLxYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472521;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=FClSIa726l5i4svFJyZzzzpy/qK8YAz0ebi1XGsAoaA=;
	b=bbdZ7B/42eK5unix8I01/5nbIhKtghidyFn6eKBSyTxUaW0bl4bvKHBRQuYLMHkiNo+v
	 zZ/xlCNqS5cYn3jPniog5+ALzzWicwZ09X367Ep8xrZmNT1Vzv08IdUhy4ovSh+woMbPz
	 glh75mrLJ42g1haeHbPWjUkYS6NWPGUbumRWMawQP2jGWyzNraLR4nYbUVqsqQCkLeV+s
	 kj3Q01O2fbxQQafQCMBJWUKL1TR3UIv07y4QKWiK4HrAPYF5VzRmeXHH/ArXAlQQwiuMT
	 x6E/t8I5ADjo73o4q7m97t0tzCrDjIVSxfiectXeZm8w6uX8uHZte0qyUzaBAL7+1Uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b="ZJnY+/bL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.138
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021138.outbound.protection.outlook.com [52.101.65.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC6606A334
	for <connman@lists.linux.dev>; Mon, 23 Nov 2026 22:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98DC6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=ZJnY+/bL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4h+yx6hE0A2UMB7I6IC2Hfgbtwro5fJZUKcVl68wAvrXz/FBuY9el0K64Or4gXKvxq66q8s3gqHWV8E8bDRlz+4zr89lIAUVR56J2TU4He4xDiAYpm4LxE/3j6qnhZOAZRNMvJ9PeDhpIVJVTsO3WaLafhEskhrSzyKBDr3WfNAcB+C/6rcueClSdzjv/LwjWBm5nMnYO20Cv1wPYXoWKesXVel7OfWjGf74nDyn51p/0lH4rwQJWi7vQePi4xWH0FPggNv36HhTefHXyIphaWt7rnbyi6Ah+2VIbavTmSg5jpLjd/XsgNtAZuFvd+WB8Rs6gqQ3pi5jqWbo1kXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FClSIa726l5i4svFJyZzzzpy/qK8YAz0ebi1XGsAoaA=;
 b=RvOC1YebjS+kD+ZR5bJj86EYOIF3bif+ux8USwjV8G75f4QaFdZjPyF64l5CuGGwbi9b3bwADH8dS+AybhuN9zpWio3jlAlvSyreVWVCwuEcnMaBiMP0ia3/6vR/djs3q++mff03XXOkiddM5eq7cLRTLvfwR7PWsEkiszxdqBrYpzk19gbA4PtEuMBoi5xuRubQuqsiY7puUFtWt/wJtoHfHtHZSwmwBIqHg1pIuU6G5qZRkqhsgHkzbu8B4UclO6dR3lAEnIqtotzVc9CsrXLj5L9aZXNwTcr6b/V5IRQifqrv+82I3sPr2Kf8u3KE6mYb+/ZHviXbzAUOJp2FVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FClSIa726l5i4svFJyZzzzpy/qK8YAz0ebi1XGsAoaA=;
 b=ZJnY+/bLKv2X8DmbNphbK8EzsGtE1l8pRHCDrGTqj6eiwcSocY8YP/ofGOwH/Imd1Oje4D0ZEG+4GCNIDs7Qy9VvEFJ1UL+0qQIC08/H2g+aAZXLl22hm40mtVtY9XzMKU6a0eIBziQ6gLUQYITl0sjYZj706Z9OmvAuDQKO358=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by AS8PR08MB6728.eurprd08.prod.outlook.com
 (2603:10a6:20b:396::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 22:21:57 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:21:57 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 0/3] wifi: Fix reconnecting to the same network right after a disconnect
Date: Mon, 23 Nov 2026 23:21:39 +0100
Message-ID: <20261123222142.1092055-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::10) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9e0af4b5-7f5c-4743-8226-08df49b02fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|786006|376014|366016|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	96ym+a5aviYt0sqkxwz6eDK+M1n/90NJNm033MN2FIdsC5M8tI/WV+d2gwBm58QeoaW7CVJOQ+Zug4KVaoiCwMc+jt/s98p3F6HxW8KkSkWTOLvZoryJzi6jObEq/QP3P3qOJULlbqzZIaoqLKX1ZZFQZ64KVRIlRbYgYv/xmG1R7wjeteO3cznkB8sVZ8HB4rh/TXW28QBmPRI/LrP9d8rDSwmDZadAe+B5cNTU+ZrNCCpnHo/+9XqmjIxwur5SNQ0AkhhS7NhARZ+6JJVJYBlvb58RT7fc2VOmsTkjxLjiIDeQ24Po1z7IYM6ZjsCJqIjI8/aOCnBMZT9C6cXnFD552ket1qMId3fmyq1qXDYh8v/NOegEOVUbndUOFNQUQPBo3tBZ/rPc9qy/SzhNO87JBjLZJlNHxLcknbEo06xjsFMMQ5ZRakGjHvZyS9BgSMrXuJp7mGsfq0elsryeHHpvQAu5tomKDdiglkWrkhynmnwyWJ8fHpPMn0YwC/Cpo7gu2t3Xt7R+H9UGc/+eZHi+r6dDidHVQ3/moPTrxM6a4ttaejj8NGuFcu3yuNw/BrGDjvmn+b8bqlHG7L7CXoaMNvdUtfzwCVS4wkFXFyeTjZVpfQ3OH8YL5dpxleFOPJvbfqe+mJ4nc35c78Ixi99cz9toyITiXJocvDrt5q4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(786006)(376014)(366016)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I644FqxLS7zB5fkKrh3KT3j6dkcWxLsc7AqQ7mJxbolfV1LGLGs5tSLo3ShF?=
 =?us-ascii?Q?JenDXQlHDGIfbRLK/D3Oliy2LnOw1v1EmA6GYKVBEWdxJ1q8Iv2fCcZqCKul?=
 =?us-ascii?Q?pn9YsnEBLy8CWA6aquvAXhtUqw1KM+etfZ545pqRgd3soDqoY8Oxl9PpWMO4?=
 =?us-ascii?Q?g01cwQNRQdq0AosgWx2Qtdhy261ou7JEqy4ai0jBQl05IyLy0ppL4eO+LuYy?=
 =?us-ascii?Q?WfRhxaAP5UwehRvIEUIo/mDA62FdKg0fecBFNIn6I3NWk+HE8N+/ZhsKT0jI?=
 =?us-ascii?Q?ByJ98rj2QM0jQD1RtUNLJWf3Io0C70DpvUKHle9TDdGHwxfRjhNV+crWrcEN?=
 =?us-ascii?Q?7pfX6AvjCOyxGKNI+C8b/K+BpxZM0kLTg++/1ue78F4Z7SLh0dMVYrw1zH6P?=
 =?us-ascii?Q?YlMJz1rTdEZSeIPGmIyTh9Nx+NSRDiRXRtii1/ZrwdKeERoW4mPHoRSbS+Pt?=
 =?us-ascii?Q?CEs2zDKYpCGTTZDo2RBobhsRvZyMQNwgynew2IiTWRvqPutGqnWthstUC4WS?=
 =?us-ascii?Q?2jbNgdfyM76Q7SVvEuq5oY2HYtCjYscZogVtYCll0GVVsZ7fz7FF8foM1kl4?=
 =?us-ascii?Q?BNdvlmvHsEs34B6zv7gtodkmRRzV82TF/NZSlmCRToP+sTx/3Zbk2Y9gjcCa?=
 =?us-ascii?Q?AvcLAo+o2yzkRY7ZUa9h1r+ZNK8P0YtFg+JIKWp2DlbbUgjHyQR2csBszPjx?=
 =?us-ascii?Q?ZZmDrnO3u1ZRtBmM07eIwK0dpzuAubGxYMyg/njbezID97z7CZbqBhMXl935?=
 =?us-ascii?Q?YoTRBRfSvw62OVZ2L1nKck1l0DZq2Zll/aLALKZdvWBJZ7tZQJGO/w7thkfH?=
 =?us-ascii?Q?G07t8o4bi26/djb7B66gcdNR7jiap0Zj/6Sb8LvC78zg+m2jlrEpX2doTjPS?=
 =?us-ascii?Q?h2DrEyL2OtKc10jMmGeMmBoI8Rx61TqXXdYKjDEOlPoSzx1I6w/o+K7AdL5S?=
 =?us-ascii?Q?C5Mik/uEJR8fvGF3W7AkSqnB0kv8FcBu6RO1CfeogyFvrtJ0+A6N1zKpz7H0?=
 =?us-ascii?Q?Zp3ID0IUEUn6qIJmkYsXJG1Jf0NyPN3UwRf9TQegimww1B41/yasowj/rPIZ?=
 =?us-ascii?Q?DJ0b3XuqTdH56tTZ15bT3MV+QhXXqa2BT9YDA7kpx2PDnLKdgDCSExcgDfNW?=
 =?us-ascii?Q?yblJa00/kzW65hLFwP4zrkI8EYB4BzjNpH/yLPde36P5/Y8FEAOZyH+i0ClX?=
 =?us-ascii?Q?HHGiqLGNW0f9anf92PFLDPz4FKl9eEf9C9ZCSmX2m4ISj2sqrn7dMxWp67E9?=
 =?us-ascii?Q?EEBf4Y6eg8UR8kS4GTnX0H8CPWXrQUa9Kdj7t/3tnByivjCwO+XNe7wLKiB8?=
 =?us-ascii?Q?Gnm26KWWMnrIfpqwCoiJSoojCHZUPGcvX3RYUFs8yzRDj56wXTgIuJmNnwPx?=
 =?us-ascii?Q?qG+q4Lmj7zOh08Uv85xztTq0wv8eku/Wk719psBAI+LfBUFbVKb5rK1vdsqX?=
 =?us-ascii?Q?hwk0u8wHCCT2c1p/1CMT1VVWvSwa9EehckDl5MOLterUm7pCMP3FLAMElzpU?=
 =?us-ascii?Q?rx5qXvi9m5f87AbtObVAzG219ZPZrwQfp/nRICvmeSz+C73ahn7Di6Bl7nRc?=
 =?us-ascii?Q?EMe3bq0lwODXz1LKh0r5Utxcgnqio34pAtEj4r88au6ZjRGCINa1Om6lVQ+Q?=
 =?us-ascii?Q?5Oac6WKbJwfDFCnwhx0oig6J7Ar4aipylCChelWguI0Wg5A5Pvghy+enhG6y?=
 =?us-ascii?Q?tVswm4X+Zr7/T3DKkAAnSND4NbE36/FggHg+RrvxT10fqZ9jjWIGmsyEMmHE?=
 =?us-ascii?Q?mExKTmk8N+gCLiGXea197aa6PbWzUx3AY4OetuO3Bquhk7Bcm3xxxsJtddrq?=
X-MS-Exchange-AntiSpam-MessageData-1: awyIsxxkAbeHYhN7Lu+QvI4i4lNq0UyjQq4=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0af4b5-7f5c-4743-8226-08df49b02fbc
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:21:57.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1JPMUvcmB0stI3dnSee8ARV3V0qW+ZZrxP1wiWnSY56PuDU4TZ68/K5pRww/cjHF83QsppYWvEklNRUGdQPqtugon2VIVJkIPWRTvyiuCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6728

When disconnecting and immediately reconnecting to the same Wi-Fi
network, the reconnection can fail. We ran into this while implementing
Trust On First Use for Enterprise Wi-Fi networks in ConnMan, where the
real connection is started directly after a probe connection fails. It
can also be reproduced with a client that calls Connect() as soon as its
Disconnect() call returns.

Depending on whether network_connect() runs before or after
interface_state() handles the disconnected state from wpa_supplicant,
two different sequences occur. Patch 1 fixes the first one. Patch 3
fixes the second one by only clearing wifi->disconnecting once the
disconnect has actually completed. Patch 2 makes sure that completion is
always reported, even when the RemoveNetwork call cannot be sent, which
patch 3 relies on.

Mathy Vanhoef (3):
  wifi: Do not mark pending network as disconnected
  gsupplicant: Call disconnect callback when RemoveNetwork cannot be
    sent
  wifi: Keep disconnecting flag set until the disconnect completes

 gsupplicant/supplicant.c |  3 +++
 plugins/wifi.c           | 13 +++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.56.1

