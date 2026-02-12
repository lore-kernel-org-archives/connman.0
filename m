Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020076.outbound.protection.outlook.com [52.101.152.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1335BDB9
	for <connman@lists.linux.dev>; Thu, 12 Feb 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902738; cv=fail; b=p6lmY5ZL33++xFIh1QY2oIIAFII1cx8NMnEXh7dL+z1zOz9TEla8dfml0Q0dko/Qdck4KYixrpka0r6QDLohcRxid1mmT4brsi9iPtfqd8pG7+n1vVapoK+/tdxMG+Je3YgvckSa5rv9/QSS00ifEId1kXp1KusG+AGBHPF3ZOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902738; c=relaxed/simple;
	bh=OYiIHka41GzU6AyAeGWWQLSf8UVphvPI3jttkrTWaYc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gjTKJhIVqwQDBGDOLATneHzRyeNxG2T7qmFNr3tA3jeC16MNVZMPy2Vs6ibj43vZxddrbxDzjlgIN4I2hKERPKoQbuYID1m3xkj6LQiqHXd8YHumjwkFU4wPPssFV5f8kh8bU+aymUEpno9+o6G4NUqgGgZJnztAzV6g/tdgR/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.152.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXd8B+JPAbY6AhFJPWryBq1H4DHUSFXlefsPUZvkj0hAeim/wyxX6hoX3ec7Xjb+IDpdgCXZGwefhXcdDITwnCwiNtNOeH6FD1M2GQLub4uPq8bsH6ejGKDeolOtj3unxBxQju0Y7z9CU+w2EfH1ZRXv0MWBPfbcI8BkFM2ZBsclEMA1J/zFY5mKE2KJAlbpXU4BcMuyX3ZRDmfOmjAOlI7nQBUryGyo5K+Cejz00bO6hfwOZqIYZtXcevFoysvWpkJyBksR4Mh06sLJ1UZEo0C7bsYmiVHumDzquu6piVVg3oyEoYkalKqM3rBf/mFHsKxgL/qGp2PXnbo9HhCZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOE8xUIS/r7Tr0RpCibRIAoXhSWIxvt5wleshidGdS4=;
 b=UFSoCgfKeqRPgfpmAtKanfRwhk+NlA9XyaPBTIchuLp04ocRrfsmaNRNG07bzTJ9+dJ0pC5xD4Kdt3/3f02BRKittAVzSbmCGrtBvqt9TG2wqSa1ZPdd8Am3mYO5V1F4Yad9NHev2khfEU96cggDUCW8VrLpXFNOpwUtgxVVzXI2UOw5M7YkxrdjBNkdGP/n3/aELoqtAvrVYlhDOozNRjlty3WuEjrbsgSy1ATW42L3yIdrH90kG1NuGiFi9HaSriYvhieWIzBdm6qEB2XyF7FW0Kor/CZrANpBLd24ZUhd5MEjRGRiSCC+EwKT2moE5HCWtcCaM8xhZhYNl5WgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 ME4P282MB0838.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Thu, 12 Feb 2026 13:25:31 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 13:25:30 +0000
Date: Thu, 12 Feb 2026 13:25:15 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: connman@lists.linux.dev
Cc: rudi@heitbauum.com
Subject: [PATCH 0/5] connman: Fix issue with const return value from strrchr
 and memchr
Message-ID: <aY3Uu_Zd2b3v26ON@01676446e9f4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEVP282CA0040.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:206::15) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|ME4P282MB0838:EE_
X-MS-Office365-Filtering-Correlation-Id: a49acd1d-a399-4b32-8069-08de6a3a3165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJR4hR2xNoFw+j6O0LPWl8/piWvSxzkHHFA/XVAXKJUjJkidCzSSem6gopfx?=
 =?us-ascii?Q?ClKbrwC8jpSDuCg6FDNvJ67xZGXvicN1MKcOZhaWCQZ4dHkFQxdk1wtcKlR4?=
 =?us-ascii?Q?96h2lSSyaAlgTWNKjZeWPtx5ZoF7ZCX34Stms6tXhQb7QCaZrTvYFQ881guY?=
 =?us-ascii?Q?2JVr6qwz6i1I/1Kzc0pZO6eFLTMjUdqwlHkn0bDIWERKCZD8i2Y8GIvzKYP4?=
 =?us-ascii?Q?0LDiDp2WGzyq38t5fNFynWU3rv5kPH8RbyijAHnCVD3o+IACkOOVeYaVyHrr?=
 =?us-ascii?Q?RahVBoyA8EncIhXSOHlAYeO19q/qjTHOfvpe4fP7PU5q/lqz9a66zkgUFQU4?=
 =?us-ascii?Q?v61D7hT2xaFgm6LrpHVCpKncfLeJ876ecD+0mDj401NVj9lGDdVBucILuLAm?=
 =?us-ascii?Q?ZKQjXGXKJvVutwIC8e4uzpvsV06aXcbaNQAZqdQtJkG97ullW5Vztnh8KUWI?=
 =?us-ascii?Q?M1IQqBAe+Ir/UgD0K7KWuIyWKrbejrN8QXzJEHJTi3ps+j3KnKaC6d09wO2Z?=
 =?us-ascii?Q?wZ+fb4htB1QN990VvpFhZO1JBqH+vewcfiV2f/cceWoA9G7EsQJNubg0zF4w?=
 =?us-ascii?Q?f+WssRVcPfE/+CXiNzeNJ5kz4+F66W3nSRLh7KuyjXUnn1z4+zupkVc/yOyM?=
 =?us-ascii?Q?cC8uPMeXBdaS/8uMam0udBY03UVRtaub15G5NpbjUZtlIF3zYZ16bsSHq8xP?=
 =?us-ascii?Q?wNB2F3WVtnndoJgylBCeWASsYWqGHTEJdTGA4GMScgYFqx7Ze/YOindyum1g?=
 =?us-ascii?Q?HrCVOS++JL7OoIt/MqXJwdaFSTXWiHLW7/QEsu7U7wVFdGP/XDh0IMHC4UFM?=
 =?us-ascii?Q?zYhFBvUYour0Aa9Gb3yDQFDVDsgzeA1Gaqxw6DiKC4uN/jo60l821dsll+GT?=
 =?us-ascii?Q?1TIWHKKvfLgodGDNVnscZqOQLFgsGVp+gcSMaYIwg1NP7a05MZNWkXMHuW9X?=
 =?us-ascii?Q?dKS8Kc4MpGXMlPJncFvc55I38jqVo8KpbGup7ID0xa3VgxhaR+KScUhg5SXL?=
 =?us-ascii?Q?69buSZNYk1Ib/mHLz+OGJq3l5pdMUkRrJMKP4t5kMETrtd8HTAtWhVVp5XX/?=
 =?us-ascii?Q?cZpvTDnYwr/aclFOhjaKgDVuqDvl4XmhW6NzYBMUUPi6ITR57a5sEtaRWG/T?=
 =?us-ascii?Q?TeAzdvRWiTBeX+rj7PeMAAGv+xQOB0zZMxdj6SDYrMsGQy/5sdRrOVso1Vk1?=
 =?us-ascii?Q?3OLZ1qi8ZMS7Vip+4DhAl3DRDbJD+SAgmRosNHr4KfWITos0XiNJBrByxAys?=
 =?us-ascii?Q?p0e9mhKia9glSugL9RmPBe1WMkMdHhX+iHObJqLJogaEV4hGu/msFb72Xsxc?=
 =?us-ascii?Q?xxRv7cuOu6rEKJF78tpgFTVZ29ApIiMB/Vtjb13AA/dikHX7ZJ9LRRLODDzg?=
 =?us-ascii?Q?5AGa+wzcRtaIKyZ4isk0GEq1NuCUZLwz3CJNoqUpilaumgQ2SUICNrudRnwN?=
 =?us-ascii?Q?mvVFQmzD/l8sYlNPRq3DoRcEXhs94IETDsIF9hdZRhkGc5y0aR/l3MmbiyAV?=
 =?us-ascii?Q?lw7m6eQhY6GHiQdpqh3cE7nSvgnrJWGDUQjlO9AZzhxM2DnzvP83M+cTFmKF?=
 =?us-ascii?Q?hO/fHRDtvfInVJY5EfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+LD3g7Cn78L6iIiVrg8cG3DK6dLjfzwv2aL8wyAYb1OwJeqlEIm1uE6QzKdQ?=
 =?us-ascii?Q?qWO0KVjXAmo0rr+0QtwCHEDPOWuWeIrHbJqbvWltMt/+jMYk5TM3b5dw7bTy?=
 =?us-ascii?Q?IvHerFGurJyeK35FFDPi4eFcdiH6DhPvN0cAWGkCfQOAPmGHr6o8LPPal5qh?=
 =?us-ascii?Q?uOy1DOb9LjivgkWHF0VxnrDnQk1MIsZHixkEB9eUTczhCCoJCFRMQjIVCqww?=
 =?us-ascii?Q?1o8/X1H9Ju7K8YG1lsGLw1ia1gzQro5FfEvgJvw5DzuOTHCkN53txA44P7hw?=
 =?us-ascii?Q?eSbQMK2sGevSAxgN0QfWAtXJzZjAVmw++3o60jjH3mhccNTRMKRZ5BeXI3tk?=
 =?us-ascii?Q?TAUKHoKLZUXGUpn6d8SlXXtR8deINOL46ttS20p2a2DpN3jH99dp9aVpAf70?=
 =?us-ascii?Q?rsgdHIz97WkTJaYHnOzz///IiMINZollR9aoOQkt/X4sW3iMpsBRiOp0NY0y?=
 =?us-ascii?Q?dBvNgGYS9DtCAOr2qeqB9FxPoKTHWJ3bQ2iH9rQuZbx9OPbrK/uxOJVTJUO3?=
 =?us-ascii?Q?ez1jfOdzsez2baCoqOU3toC8W6irBz7d55vH03XZly9lPdFBNtDeFaP0yQ0W?=
 =?us-ascii?Q?9BpkVtWbrxPDgnRXHSCh4mb47ZUSflV+LaVTASXuQZqr2mpDwc6QSro/ohcU?=
 =?us-ascii?Q?Ar67lFs0ChdOWjdreaykcon1vKtr9QjWhgyf9WwYUihlrbEBddAo8qF3dmSK?=
 =?us-ascii?Q?0dXFjeMlAfFJKc2zukRYZEwj0C+gBdR7JtgL2YnQoY/yuHMrNzNiNKJl42U4?=
 =?us-ascii?Q?X4dn6byQXaQK5uBO06R42ercfsLdpAl43wTrpFiSxQAQIZB313QDd+1bBdVm?=
 =?us-ascii?Q?G8R8dOLNltk/efDiuXc0jjeVr2teEbMXCm0m/2lBhucaujyg+6C5gYerSOl7?=
 =?us-ascii?Q?AqmyfVTkZbyL/iLiJTckZtRTHg2UK4bHjRVmeEWOgZdtMznRg+euqbqwEjBR?=
 =?us-ascii?Q?6DDz5Pv2Yh3P0pNIvFwkFJrbslMRyucV/jZ6BeZzlPm3gHdnP4aaO7OHo1q1?=
 =?us-ascii?Q?7+6w8ssBfLAfnZUE5+ESMHcXAQwsi7aN4h7UNqVaKsi6hbIBuK7aNtF1oH/V?=
 =?us-ascii?Q?DmidX+CQdW8FpNW/Cp/geLxHQc01Xl27njMaTImgLsDHHd2UJ/g8gtd2NMCG?=
 =?us-ascii?Q?RktH9YdA3LH9FBwXEm4i+EyTDUgM1DEFs1pYgr6LVheFGwV6Zmcj+FPuw7Jw?=
 =?us-ascii?Q?Oe/C0ghndy+fgYwrj0/5DvtE6G4JkFXdQv2Ik9J5rT4eWkk/j6hL4cpY3FQg?=
 =?us-ascii?Q?utsKPVg5HoXDMV/vLkcQY85ClvATViH3pj7WcvYamlgtMVC4hjvecqf+2gUe?=
 =?us-ascii?Q?hSFsSUZwC25+3IrcFeQUkpc1VT2mjT7WIrCBhKihxrum7zURwdX0KjeU79TC?=
 =?us-ascii?Q?5kXxE7CW1LO2qluMurGqP8aivTkTWwfdDOudhQw6EyNv+cy5jaVYy9ObwUmi?=
 =?us-ascii?Q?HLpxfxZSR1qxqJwht5mPZLWmLj6rSwzgTUaRvnXFX8987HJVGvd0V+HX9PiA?=
 =?us-ascii?Q?Y99R/NTSqh2IjkSM4xULMIPo8vh+98maD4sim7SVmXL3Ilm1cQ5CM2AqcYJN?=
 =?us-ascii?Q?y3nATmo9L5ZQT5KO0AqDGXCLhzwVT57yGiT+RTN0M/Dhxg3zERwLesn2m0SA?=
 =?us-ascii?Q?nBW5rvN52K/XNPJksrxvX4Uz8JAIJb8LIpTj7sdkH2+GGScmsdVDMSAnBAWr?=
 =?us-ascii?Q?8tQDb9kv2vK5B7f9Asr2PvIBQlD1nWa1OC3Exvb9cXmt8+t7?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49acd1d-a399-4b32-8069-08de6a3a3165
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:25:30.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBZ4OR9Pj3fd13rjVWEJYDH9WoKb+WOKgB3ZAtqwdfJxejTRuZImT83+z5ZQj1qofuMcSucBW9CtPrNExprPUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0838

When compiling with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
warning occurs because with ISO C23, the functions strrrchr qnd memchr
return pointers into their input arrays now have definitions as macros
that return a pointer to a const-qualified type when the input argument
is a pointer to a const-qualified type.

Rudi Heitbaum (5):
  vpn: Fix issue with const return value from strrchr
  vpn-provider: Fix issue with const return value from strrchr
  gweb: Fix issue with const return value from memchr
  dundee: Fix issue with const return value from strrchr
  ofono: Fix issue with const return value from strrchr

 gweb/gweb.c        | 4 ++--
 plugins/dundee.c   | 4 ++--
 plugins/ofono.c    | 4 ++--
 plugins/vpn.c      | 8 ++++----
 vpn/vpn-provider.c | 6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.51.0

