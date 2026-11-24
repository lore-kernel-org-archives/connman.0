Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479206;
	b=eq/a3E8j6iWXeScRxUYQ2JgPhJNHel6ZBuQl58OV4/tN+AEoQhzBvGMR73K8ss4zP6Zo
	 MsWxfUf3oCUPR2ULvqYYfk8zl+rl57voVx38q789j0LsafOt09WJakJ99vFPqVslPeEQ3
	 YOrLUtckLhskjs2as4ikGbYWlgx/E4Ci8OCE7BcVhnEVoS1VcIyc/GXDfyUCQBnd8ejQV
	 2bkjBI3in2c1NV8u/PgqjJsn5wo/bmYmZJbV+PsToNKNULA8EpsaaAoRc/j14vs13zJUD
	 kWer62arD+bTMGmLEcYEsZyPVeAJqCwKRWeNKKoSMfbvl9hl3DslZf6G19yJW0aIgzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479206;
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
	bh=xLrCtitvLwyRAAqkf8d3xGCmcBE8lTqUYNupf+ysAN8=;
	b=xYzt9DcIvCUCG7tB3BNAtt7ZkTQW8JyZhmlJtvR65jsksirVhwvvNBGIaZ4BO5gP+Xu5
	 9COhM0Z3lboTAXisIbQT78uqks0ETcvbkpB0E4uRMmHQBxIUHQ8g4BdSbLF36HnQOHObm
	 sWB1Jqscj9QV0RPU8ph7rvjbIOQQihrVK7HSsWUBVMjDk/WhGY9hK/aPtD3UdOVYgwr9J
	 wUpq03KWBz3t01XiZVSm9H01v7g3c04g8yNe/U1D0fMEsLxRHqlXUZ7qqFXNyiyFX9V3L
	 7ZYUbHGhrFSQJ/HeSHgj+Igp7EQK7rFMKNah6RCvW8Oml2U7y7TrDzMMumr4KGi1Gpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=Nk2dsuES;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.123
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF97606A31E
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 00:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF97606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=Nk2dsuES
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPRICL2zYHB7GCkXRycluhXVdCnL4uioVk+oa65kzHsbzkmHbLHkDwjRS9sBc4B8UAE1AMarkoAi6oqX3jH06JWGarg2BdN0DbAW/rF1BBuwrpZkrQme1cD7/UrmlRjZCPuu/YN/bdp4/cQfFhhtTAkVDDuRCQTDtvYQZymhV07C8qQiRYyvZWxEwbW1dv94O5PYDCPSLe8821t59NO3JVf9X71G4b8/09FPOAsYYAo21z7pnaAlVG3Wkbfx9iLzq7ohErbBRtc4l5P20A2x3M3ULJhPOLECVM1G4D/VrYtKP5AtzKnEEBNI1wQRtr84at3Jm2xxXu+3j+x4P1t/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLrCtitvLwyRAAqkf8d3xGCmcBE8lTqUYNupf+ysAN8=;
 b=gzUgrZFdm5iHE7QWcAt9KtajCOXRr9RG3sCP6kBlKlt4AO2Ztexa7xDVkuJcdpI7l/EKUr+iHycbLjbwQ2ItFVynVydhV3+pLfAYUtsdZr9iZzFCR+Dgw58CVByNp8vPijXwMDJe2N56CyV0ADJTkpFRZ5/mYJfliMRn6PMkEaec7Wi3QSnfxnPEw7joQDDMFOp5it2glK6aMP/mwW63RPiyGoZwjFP9zZUshHNyqpE/latyGnbjax6QEBwru4tk2QQ4mXVK7JC1QAT4At8eE+gWg+uCfsFuqpA2yTVfCIhITvfWm8rLqhvXPOHa6kXlAd3cfOIbL/n7qAVkW5qbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLrCtitvLwyRAAqkf8d3xGCmcBE8lTqUYNupf+ysAN8=;
 b=Nk2dsuES1C0ft6l7JPxHOtQOejpLbSlkCgs8/97KYt8o+g2knuPifriat5atQltshge0m9vRQ95CPEmPUI3lEppQOgMSTvRv+/mltcwDclTGRGC9iPCUbUTwb8KphnMsYTbyj7/ciMvKVkJHs2rJiuV5q18tWT19NC9ppfJne2g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI1PR08MB10200.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:13:17 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:13:17 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 00/15] Add Trust On First Use (TOFU) for EAP networks
Date: Tue, 24 Nov 2026 01:12:56 +0100
Message-ID: <20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::34) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 278fccb6-0546-49b9-fb5c-08df49bfbd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|786006|23010399003|6133799003|18002099003|11063799006|56012099006|261021121427099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261021135927099003|261021123027099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	WIgd2AfVhNA77p1VGe9Il3DhWXvphdG0Df79mD1Q7JxW9pfyJUtyAHUlqaBAOJOVfi18ch+EoaMHtnYBk45EJX60qZwy+Bwi/JVcGerijtMHBU/pJXZhxvVcbQLRIXU8wniw/H/G7rgnBXGrl/oriyVqk70CNSvoVKLcbRHTfD1u0FUp8XJAGSCxpvWZJkJsryh49oaGlxivkQ3K0IzOclLHH8Ch6yDE+cwbVU7hdGkUbYQmWcCRpSLQsRGA7VjeOplad5MJouRejkbu96VhPBAsyBNagtM4ihGTOqeiW/t23OG+WSDzyrG0ZDnOPCGW83zQNLtBmPdaCPVm2ZOT8ibUMTk+EwG1lFmvCjudHf+tp1a7T4908DCXl3pAK3jlZUqy0o92XW0Mvts3VY8HZV6DfzodjHPuPvYSPGXwgJJhfUmNSQc5s7rZzG7Q2psr8tGSePIxsJQXszS0fNOEuHyNXQYCJtG9787DtssxmHVmHQ4ac2Y/uTtp+s9WvpplrLPTkxJbfd/TDBCxa94fqpxe8PnFAqCFemUyMA0ZXABmg8agCoMyzPN3dBGH93CycLtRg4QrQn7cisnOR6NZmVVVYob90wsfjiFCWEYrBZhRt1NfZ2YtHOdewrD/jR/l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(786006)(23010399003)(6133799003)(18002099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261021135927099003)(261021123027099003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7n1+3fAe6nxw4KNOfLPI4qRK5rGAVmBlKrSlgWBpvz1CTlJO9PAD8IhT7ncE?=
 =?us-ascii?Q?RSknI79nH15Knzr7qVRKHL3EYsz6XFP8i3YwZun/Jfa8nlSZ1L3E6h34GTHU?=
 =?us-ascii?Q?wKLU+x/YE8/hC0q7sIINx6XX3ZP85oCncrIHrbg73IbdN83BDnvUGT4bItaU?=
 =?us-ascii?Q?cXqP0Mj838M4bwQe/YrWM9I4W6HRhadnjEN289k7DK2lWfyOy8ECInerKDyP?=
 =?us-ascii?Q?TCDXvGAiwi8eZgQbKVxIvz7bZUuZEW9BCaXF2FWoppGyH+CZOGQ1GFgamTml?=
 =?us-ascii?Q?mObvhrQzZxlwrSk+lckou38lBALUhaEDnaZHvBzCv0LRQr0S7LGz5kfgpNSS?=
 =?us-ascii?Q?iECQT2Zax36jJxHiNy3lLoWwmcAPmJLWYARJ6hucv/7Vb4kUqtR6njHeqWDt?=
 =?us-ascii?Q?2JQu/6rysLq89UuYZPHXHUOgEMF+2EqJMl2gVXYRjRseJoPvCT26XfKcUxIy?=
 =?us-ascii?Q?/DLTcgLVwfdtoOuZ8hCG+NowvYePN31W56F3NeCdqw5MfPK2byQDjjKYeZ1x?=
 =?us-ascii?Q?qt1M04w3vaP7a7O3LZl39Y6FfbqC4h/5eFxhBWrw0g4IY+YSMMtZcp3cVqgw?=
 =?us-ascii?Q?vzHsAc0M7uw1Lny2gRtvRgW4X6oyxMU7d4FicTspo+u4Prccmtzvp1QuUC9Q?=
 =?us-ascii?Q?0jdZaKKLcJK3NG85Y5ZxSlcRM7JgO63loRvRIHz6o2JmPFqI019nr8ZZsp6n?=
 =?us-ascii?Q?7uYl0cMmCBHdYHc9GtuA4xq6GTobdpfF/RXof1qRL9MZkdI13ObovDTwFHuA?=
 =?us-ascii?Q?pg71q13JhOOku+KTqXnzWk6w2vzFUWky4KrQ6jUEYEadfqUKcVOe2K+QNJyY?=
 =?us-ascii?Q?KpojgyTJKLui0ZggVjGbPsNXTYzHqD1NkfD6Vtnjd/H7Pt1OsE1gMHui/XPK?=
 =?us-ascii?Q?l8ZMzabo9vB0YDeWB51RpOSCUOTFLieEhzsnAjlUz5bqbFLEa2LXpl3oqU9X?=
 =?us-ascii?Q?zeAJsDBkBvLItSzbxWwXCL6qKw6CxTUmz2mYqQtoSetexdzsUzU0Y9UBnmi8?=
 =?us-ascii?Q?+XFGDdbK/3odG4O77iEypBHvLYyS/0qQ5jRvOxlpOB6bV8UCHVNInYLDcHcV?=
 =?us-ascii?Q?YI5aCHyv6b7A+weTAtrSjsFf3qE//pwISIWXmoQTUiRVXPwAZotpDpp2xKoy?=
 =?us-ascii?Q?xWTHDsXOQ8z4U38uBlsrzss0FWORBLL3GRKFAFnTGSfyQT5/8Ow4rBE5n2Lx?=
 =?us-ascii?Q?fFiBYof65jm4dZpjw4U3+7SDrKjY4A3uas5NWanjMJuubvFmK5rH6JPXPzqQ?=
 =?us-ascii?Q?glGzswJZbaixJ2DAWw3/zSfsuB3WHI/7OxsjSO/NLo6GOoPRXq+LGhrbl2ur?=
 =?us-ascii?Q?B4CNhaEc5TUkakv6DmS3cixsCgGKwwDNkv94fNeaGVcQ+nMmYtEtBCg3+isx?=
 =?us-ascii?Q?T/8L5WTRo4AyPNUinZqksHVkpaXa/vebcEVFcGVwxBQPvkEy4zPo+eVX88Mo?=
 =?us-ascii?Q?NTC/gyhMBu1Hj2b87+qZIzQl6HOE5xAD/h3AXoiPZGkVon0SlN0AJqYNqlil?=
 =?us-ascii?Q?xqRlQGJt+yXkH+memLsFQmTK9e2z9s68UEb0s9MVK+/d56sXB1x9ftBJtyV1?=
 =?us-ascii?Q?q6JI8yD/T+Bm+WDQRQckZoPTRMR1bxZZ34h5OzlO2Q0Ak/hRwTFF4QjlmtpJ?=
 =?us-ascii?Q?4tZ7RLDUxoxlEzlNUjBuaA7O/GN9EgdbPWyifaQfA8HR002LhQ9beJ4X5k3R?=
 =?us-ascii?Q?H5tohwngFAFeFgoz+oCFjA1W5N7FQgCm+HSQsiV2lC3qFd3MwJITOauNPbtN?=
 =?us-ascii?Q?3Wgkd6CvmEaxABgvRnr5OR4ekj50rPrDWCaAjPNQwsljEPz0Hq/gfN7Qb9LR?=
X-MS-Exchange-AntiSpam-MessageData-1: g1q7qiYvUHtlvODRu2yXUX0O4eBBre+aP58=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 278fccb6-0546-49b9-fb5c-08df49bfbd71
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 00:13:17.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diRm0EINHMK2/jEWfJKY5kDi+RfwhoGH6Twab1bj7EyxsOpem0e0gC+5XDjcXVFRJpFq/T/11YsjlMSV8oau0gSU1CrZqGIB5HH1YTTZ/lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200

Connecting securely to an Enterprise Wi-Fi network requires configuring
a CA certificate and a domain to match. In practice many users forget
doing this, meaning the authentication server is never properly
authenticated. An attacker can then impersonate the network with a rogue
access point and capture the user's credentials. This series adds Trust
On First Use (TOFU) as a more secure fallback: the authentication
server's certificate is pinned the first time the network is used and
verified on every later connection.

The series consists of three parts:

- Patches 1-5 add a ServerCertHash provisioning option. It pins the
  server by the SHA-256 hash of its certificate, which is passed to
  wpa_supplicant as a hash://server/sha256/ ca_cert value. This is
  useful on its own, e.g. for servers with a self-signed certificate.
  Patch 2 also fixes reusing a wpa_supplicant network whose 802.1X
  verification settings have changed.

- Patches 6-11 add a TOFU provisioning option. While nothing is
  pinned yet, ConnMan first makes a probe connection on which no
  password is sent. The certificates of the server are observed
  through wpa_supplicant's Certification signal, after which the
  probe is left to fail. If the server sent a self-signed root CA,
  that CA is pinned together with a domain to match, so certificate
  renewals keep working. Otherwise the server certificate hash is
  pinned. The real connection is then made against the pinned
  certificate. Pinned certificates are stored in the service
  settings; the provisioning file is never modified.

- Patches 12-15 add a RequestCertificateAuthorization agent method,
  so that a registered agent can ask the user to confirm the
  certificate before it is pinned, plus support for it in connmanctl.
  Without a registered agent the certificate is accepted.

This series applies on top of my series "wifi: Fix reconnecting to
the same network right after a disconnect" [1], which fixes races
that the connection after the probe otherwise runs into.

[1] https://lore.kernel.org/connman/20261123222142.1092055-1-Mathy.Vanhoef@kuleuven.be/T/#t

Mathy Vanhoef (15):
  gsupplicant: Add support for server certificate hash
  gsupplicant: Compare 802.1X verification settings when reusing a
    network
  service: Add ServerCertHash option for EAP networks
  wifi: Pass ServerCertHash to wpa_supplicant
  doc: Add ServerCertHash to config format
  gsupplicant: Add support for Certification signal
  service: Add TOFU option for EAP networks
  service: Pin the certificate seen on a TOFU probe connection
  wifi: Add support for TOFU probe connections
  wifi: Report the root CA seen on a TOFU probe connection
  doc: Add TOFU to config format
  agent: Add RequestCertificateAuthorization method
  service: Ask agent to confirm TOFU certificate
  doc: Add RequestCertificateAuthorization to agent API
  client: Add support for RequestCertificateAuthorization

 client/agent.c            |  38 ++++
 configure.ac              |   1 +
 doc/agent-api.txt         |  42 ++++
 doc/config-format.txt     |  14 ++
 gsupplicant/gsupplicant.h |  19 ++
 gsupplicant/supplicant.c  | 169 ++++++++++++++-
 include/service.h         |  17 ++
 plugins/wifi.c            | 224 ++++++++++++++++++++
 src/agent-connman.c       | 112 ++++++++++
 src/config.c              |  38 ++++
 src/connman.h             |  13 ++
 src/network.c             |  12 ++
 src/service.c             | 420 +++++++++++++++++++++++++++++++++++++-
 src/storage.c             |   5 +
 14 files changed, 1106 insertions(+), 18 deletions(-)


base-commit: 9e46e4a021cd8566b942d1a72b41b14a0a58f506
prerequisite-patch-id: a32722e01b5672b188522283cf94e9a01bbf027d
prerequisite-patch-id: a7f74eb8692d927f32ea30c7e49226c8eb0e2149
prerequisite-patch-id: c8d2af71df5918931cfeca0f851a77234fe89d5e
-- 
2.56.1

