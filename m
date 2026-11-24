Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521640;
	b=FN2VubYAbxurwkA8EpLmaq++04d41v+UuJtGmcpwIdZ9dQ4iqGx9WHgNhaPUlznlBYfW
	 V4KshvgGRvlfhLyZOOViMp9sAcvBlWnxluO/MC1GQJreu2lqMylJZ9YRXwPyrigXvRbLy
	 PM1nnHjHTHTjBYplVf2UuRrmcr0qcZqcemhUzQ88iuHRUM5FxeHAieHmwmbfzqwzep9ur
	 HUaRA44UDVyqOK82s5VlQV1TihvD5iMd/y1JeR+g5jlijFkMej3nBAVIYc/wxt7UDgsKL
	 hl3510p+0dwlHRvHLJ/bp27nv3ETEW4maWjs5F7B/VcSwudr5q4ILi7xRObncWgnM6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521640;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=39rICKIeM6sXDWU2Lizuhc6L2Ec4TRjKFuED6xuS/R0=;
	b=m1ZWz6b5bGoNfyZg9kHjVSaVUpo+4M7MayUvt++fs3epf8wTXTK0ZU9qY7/+YDxcT4Rt
	 sD1Tb7cXZuKqxNBBV2cgxah6x91TL3tBmDfhIF4H6q1Krbg9+UacTc+9TJmRLmoBf9Q/r
	 BMJHUe79/3bnNSltrLUE8mcBkCbdtLwSgt0mnPy8t2jc9GgEwKdqrdK5KQ+GMr6V+UEYr
	 cnPG+lsH3+BnfZnxenn2GQS+0jbcrxqrUEez8AhwUXJJ/Jwoey77EWRrPcSrzUHdaf2O8
	 SmyfbGA4My5DhpmVN4tzmeWWa+3AGn+evms1H9TbwUxgWyX/hM3HYAqcUOpfCaJ9xCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=dxnckDXc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.120
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020120.outbound.protection.outlook.com [52.101.84.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96408606A321
	for <connman@lists.linux.dev>; Tue, 24 Nov 2026 12:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96408606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=dxnckDXc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qml/RTfoqEOnumFDhWPeRXQQ7v92cYHJnY57zVJrxEzQOVQMqqrHNBXVhKWvgXnJM80DtGQmhfIGK9wEdO7i1mHi+/OqS0SoZBX31859nT0s88G+pjMynpy+3wuWjMiRfm6E0yQQs2yc4UfOPv3CXzJhLTYNR2dZUQWbQ63EjIRQa+wplEsP6bjRA+X7g952TZdOd0kod/kLBDpy87ng0KvGvSfgPlb4NwB7o8eM/RwX+hxFeVOKjJ7wQWzyZvOwVvPQxXcE50cWd/t32xfcccbYK6zgk+nPZT9qzA3NeL+q5ivR38+YHdiCCiSooinxWZqgf6/LcbbnBHTBRLLWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39rICKIeM6sXDWU2Lizuhc6L2Ec4TRjKFuED6xuS/R0=;
 b=h0MGeRH3MLnvFYOWGz1GsLvJBymYvjQBWZ3331VYk0KgUe8yhmOpQDi7Gwfo7RKJa5dR28ZpVzva4XbH6pq7vRKFxh9JOSjWmdSUJ3hh5FY2k0oSBtzpzARYu3hfyvCSAAvuleOvmcRsBd8O+tv/OSlhXbxwXd1OQuNgLwauikpRoghcHZP/M3aUohquCSe0EC/pzr7n/nZHQMZDnwTDNUEaXofkY29mujbY/RatTmQt5+13L6XFk23zk4KzLsCaqnVlgTa5rebZlCpL2DPqF72CB28Xw5Zw+UNDZJEMhIfn98pr4xXdSkI6B7xb5z8P2BwmvigqOwSSJSBonxJBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39rICKIeM6sXDWU2Lizuhc6L2Ec4TRjKFuED6xuS/R0=;
 b=dxnckDXcMKnwNpuUsCM6kPlrLE/wclg8LNVZKZ2oP7+r9kQY541/XnU595FNWr6T4ZcDKtguDGAfe++dto/6s7I1tw1u2yiJ4tS1DhMmNSUl9MaUGBwDXPhXSZqZLUfCdcLcpOK0Ckjk9/UgSSmgg/FP7LoX2P4GqJI4/Nk+LW0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by DBBPR08MB6026.eurprd08.prod.outlook.com
 (2603:10a6:10:1f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:00:32 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:00:30 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 0/5] iwd: Add 802.1X provisioning and TOFU support
Date: Tue, 24 Nov 2026 13:00:24 +0100
Message-ID: <20261124120029.1288258-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0037.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::22) To MI9PR08MB763857.eurprd08.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 259c258b-c3a5-49cb-f5d4-08df4a228992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|786006|376014|1800799024|6133799003|32116099003|18002099003|13003099007|56012099006|11063799006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	iwv/U8FwFjDTYoEpiKcPVrsXL+VOqO9I/ur85Fpu1XU6xj0yhWaG6J8r9f8ffsc+7uovYEBxE4U+23ziH1qVg5ePV8PlYbz35Tpo17gZsyrcvNZmV48AupGXkYmI6iO6d1o90ujsQjgt+fkuih+eFq54wEDfXnckJY3d3s9Ix6Mlw/1ec7IoobK+bQQGAs8MZbq77pWQ/hey71XL7nNkZ6Xt8iE50+T2XhjBFVGujupiFyKWpKGJVprGaTV+GDGtdFCuJeTPvsWgFZgNUki/TWw+owO5PircBoUPs5LY+SmsIzTJDaYhxSJzQX0pBeN9Bf7mlINDox+xzGfoFHKB3U6EqnOs3wCoFtfsbQY+xbZH6bpZbIwMfJsAhCA3d1vD8e1/6YAKdKxASmw4CzrtrA7lAwQf+q1z2UmCEqPcf4LxifNEBNmW3Mnx4wCegvD2V08rPvRBtVLcTFaumZtP2fNRaFU+vUhimItZD+pLdrk6yTT1/cb9jsojV09OXhtXm1RdViMWPoRjTB1ZNP2wcEqP/z7764Q9Aev2PihlvO4PKo+0ubqTQe+heO0FnsTqFv332HiZH/L9q4MNRUYBRlPXQjaduQpaxIuqU+8sUcBo4/+GAspssZRxEsyv7ei8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(786006)(376014)(1800799024)(6133799003)(32116099003)(18002099003)(13003099007)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(10067099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SdPb8XR7Wocb6W3EhhkqJMflAOkHhVhsNdiIwdqMFGSF43T189vkDL9qtuPx?=
 =?us-ascii?Q?Ik8pkdSSuqEJ+h9VudE5g/eTiCRyn3aRq4hrw0nXf6VZrNfFlpmtvi42bZlh?=
 =?us-ascii?Q?BaOmou7jMpdaJMtWeOQtUJas67cQpBoF3LqQnwQYd5qp43ias6FNLccwGaH9?=
 =?us-ascii?Q?ZTYOPTgeBWK33c6ox6yDj5h/gEPyZFCyo7dL3WiZMBy7k3JpXi1sJGYpGTgl?=
 =?us-ascii?Q?L0Fx1oZfjnZGswA4xktSbbEVQbrW8W/zag569q2te8VqwBzNCB31xz+ffvGs?=
 =?us-ascii?Q?sbRGVxHVkienTPFVE9YXs9PqJxlZD0rfAHQylrxbwm0bh3VXsj12BA9SRtpj?=
 =?us-ascii?Q?kwwye/BPO1rtO96hTg6ivDT8JmnY2Vea6UffWToyYey/t5Xs1kTptfDU2cCS?=
 =?us-ascii?Q?rR5505CSuHJVLrjZZSW/wmgk2RqIDGEeDa06NxyVpJDASkYsGqLHzZ2QXL4F?=
 =?us-ascii?Q?QHRGsmbbnlZutQswGiho8GOMCcmLEPN9qnmmaSR7aO/pkHLf4KL64teWVh4b?=
 =?us-ascii?Q?jh57zS7QKOQ+ntdMFrhIbZUEonrEwJT48a3Dh8WtyUswkfwpty7PJpyrOfvt?=
 =?us-ascii?Q?mnxnB7tVmm8AAaYPbNdpwcSkjFrJpPyqs+sGEPG4HgROXEcUvipmgJoZpKZ7?=
 =?us-ascii?Q?DsjowUdMjVBtPym9CMyvFmTvezFrF2qW6KWuSm6LGP/K0c6GTs/Bl5NagdpO?=
 =?us-ascii?Q?8vVbLoQUrKBdgck2xDGinjIJQYg8VEhh1KxNDm8rNYzBvwUNgRphRrq728wW?=
 =?us-ascii?Q?/OJCxfYChFYdqc7qlErZOplsabvThg/Vb5xuqX5mECvztXWgjL55vS2V7+KO?=
 =?us-ascii?Q?IhMO9LdA9TC3uVIrjznyD9Mb2G75YtIFmph+rXeoGFX1KxLgNRbTb/csNxFt?=
 =?us-ascii?Q?rhafTIyZMs1qOIlplmv2rVqJB24Gw9nMjmoVyDsSrEBPaYCao2KiE83Gieyi?=
 =?us-ascii?Q?rwM5XuUYo3L3G5BOHiGdZ2jc/ODdgqTSGws5FNWJj2wsP6/h35Zb78rGLXHM?=
 =?us-ascii?Q?hcDS8FRi916hwYlmGzb8k1FWdiDEcVWFs8T0leaivxwFHYqskct7r0cNViyB?=
 =?us-ascii?Q?l+kmE86siqMUyayRvEFy1fbaOqGRkstz4382O0jdFfm+n8JnshAJR1sQJ1mi?=
 =?us-ascii?Q?r09djVOCPbcCCeT9yk3IdbDIZ/kLmrNCMV5vIb0tw4JAx8YNcLYhYaYK+X1g?=
 =?us-ascii?Q?2srnFffhiz8gpOLyflnyBQj0PZJRzn0n0mrBn/xQYFGiiPOlUlxK9q8UarP0?=
 =?us-ascii?Q?hHevh27EAKyyWmmml4hZRaqvcBSaHUWuX4VT2lZHA3Hd10juRXqmhxTMbMRV?=
 =?us-ascii?Q?oaFEsyFpve5BxwxbCuseo4S/6/sXj6vOLIW8zBZoYsmdHOAnXbIZZdkl1VJt?=
 =?us-ascii?Q?ZrjWXVynqVRJogPyto3+fiFjimfuvZYoO0pqsVePIcC/3ysoVejeevN48b+5?=
 =?us-ascii?Q?nna/zoZjdqYxQt17OtxCSDWCSQxuw5C2MExkMtzbuCllewk5NVICtrVGKf7e?=
 =?us-ascii?Q?v22EFJWiJ1xY6IEJAvd38bM9RXCwFp0KP0a0BlEM9W14URMT/TvHey+3ElbU?=
 =?us-ascii?Q?K0DDiaOfGUTbtjWM3aaCLYeAWHaKh3YC9y2eVEg/J1AN06yaArOtHkYcr87m?=
 =?us-ascii?Q?xHCjECtRtoKGDZCzmA1BleSqlwLb97YqQr4Nesy8HsK7NMdvtLPvvcqn5Iuu?=
 =?us-ascii?Q?MsWgMOIHZrOHZDaPnky+LJ3Mi1V1aUkWG7VTrv2tX7fagQhYlwDC4G+lPg73?=
 =?us-ascii?Q?dDUhKdt6A6Tmip1CsGpuUGwvTw1q5x4ejB5IDU1wMszDoph9mzEx?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 259c258b-c3a5-49cb-f5d4-08df4a228992
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:00:30.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiTizLkPK3jore4DIUzfv0/fHQL+hQ0yb5m6RxDSlz2V832TFiUX2ZVmfcpJYo6G/SWHLcZ9LZjfErUf1MuLUw9yLTNFf18SY9wuekgSzYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6026

This series makes the ServerCertHash and TOFU options of my series "Add
Trust On First Use (TOFU) for EAP networks" [1] work with iwd as well,
and adds 802.1X provisioning to the iwd plugin, which they need.

- Patch 1 moves the handling of the certificate chain seen on a TOFU
  probe connection from the wifi plugin to the core, so that the iwd
  plugin can use it as well.  No functional change.

- Patch 2 fixes the iwd plugin reporting a network as connected as
  soon as iwd starts connecting to it.  With a fixed IPv4 configuration
  the service then became ready, and Connect() succeeded, even when
  the 802.1X authentication failed afterwards.

- Patch 3 writes iwd's settings file for 802.1X networks from the
  service configuration.  Without it, connecting to an 802.1X service
  provisioned in a ConnMan configuration file fails, unless a settings
  file for iwd was written by hand.

- Patches 4-5 pass ServerCertHash to iwd, and add TOFU probe
  connections to the iwd plugin.  Both need an iwd with the
  ServerCertHash setting and the Station Certification signal, sent to
  the iwd list as "Add EAP ServerCertHash setting and Certification
  signal" [2].  Older iwd versions would ignore ServerCertHash and
  accept any server, so ConnMan first checks that iwd has the
  Certification signal, and otherwise refuses to connect to such
  networks.

This series applies on top of the TOFU series [1].

[1] https://lore.kernel.org/connman/20261124001311.1161845-1-Mathy.Vanhoef@kuleuven.be/T/#t
[2] https://lore.kernel.org/iwd/20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be/T/#t

Mathy Vanhoef (5):
  network: Handle the TOFU certificate chain in the core
  iwd: Report a network connected only once iwd is connected
  iwd: Provision 802.1X networks from the service configuration
  iwd: Only pass ServerCertHash to an iwd that supports it
  iwd: Add support for TOFU probe connections

 include/network.h |   5 +
 include/service.h |  17 --
 plugins/iwd.c     | 719 +++++++++++++++++++++++++++++++++++++++++++---
 plugins/wifi.c    | 203 +------------
 src/config.c      |   1 +
 src/connman.h     |  20 ++
 src/network.c     | 232 +++++++++++++++
 src/service.c     |  22 +-
 8 files changed, 970 insertions(+), 249 deletions(-)

-- 
2.53.0

