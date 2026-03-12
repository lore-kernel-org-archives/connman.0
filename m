Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021136.outbound.protection.outlook.com [52.101.100.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2133F5A7
	for <connman@lists.linux.dev>; Thu, 12 Mar 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328510; cv=fail; b=oQ4y4/SlI5FrkDFg96/YNbxz05Y/0khdmanpamnzb6XJzPto51Lhg/1LsT0L1Ew0Rqhr0xlsEfAtWCsAfN+3i9ByLG78awD3T+KbDff0Evo2f+vzYpe5nr1+GDe8vnQGU+EHHtGtWJZ84Wvu/Slhs6tyhC9tH89HT4XIiBdnYpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328510; c=relaxed/simple;
	bh=VOMJbPplXzWpUy7lU5srv8hN4bqrtFdNnEl3KeIbtWI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nnAsn1rC9tmlNKm9q2YE8AeqPXjinnBKtLKzveMJ6gXrZQTTQS/+CW59GKPOa5ceoiIc6rz273lxPg5Y87EaDwa3RUPTu87YwSKWz8UcgeBbW+qUtAEDYNNDA3V4Lkste26hY5mfLy+WrpDcZXcIZYYXa7+YUCS8lhfb8+oEd8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tewke.com; spf=pass smtp.mailfrom=tewke.com; dkim=pass (1024-bit key) header.d=tewke.com header.i=@tewke.com header.b=CwcWB2hU; arc=fail smtp.client-ip=52.101.100.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tewke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tewke.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tewke.com header.i=@tewke.com header.b="CwcWB2hU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwAZnLy/is6ERH34MXNJKVFwSDkQUyYNrFhMh+nSsncran5sd5Uwl8BSgJGKiTv1iJYuFM2Z7Vo4nr49N0hXGIazflLWrLhvF1JWJlSEXKiBvsgGIxd/DNy2obS5ABllMqNhZqfsKRScJPc87XwrLt1Cf66pxQAkxj4enXfLw5TnF4CXpsXQdfUj4YIJGt8uWyOdQlF4lh2uxTJ5ODVC9YMoZ0JgVjtCxaxNPAgIsCtkc2ad0PUr8msBfAb+WWW6t5Ro0zdKNAjowhFBqlAb17qwE/E/90H08o+CG716P2QpByQvdmq5Gi+njy//ugvvN1vxLrIOVD2zuN4DEaVeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDD2ZgTSgeUYgBqphXQK0IZHaXKqL/IB1LGkEzmHC6k=;
 b=eAs40Fk/ylt7EmT2ONm5LlFX196OwzMOSSz+sYoIBDw5ZurUUS4/aGRSHwxwrJ0Qk3UrAnhTwLcIZl1s+GL3JAWegyBboMKEz8O9jJeP/VjV5Xw6/OGMiDxlRV15567sxY5ID9k8DHQIUtyNoTSgmglr5aPwuR1NEqzCGUXqhwczSgSWwdj/r0RkUD1Dnk+gQaK+lRHSdofoWOgjF0TGG7zNoQ6AbS9QpATz+DpnYROwpPpKoXjL8uoCSyO5SyhtJReZCsDB9JUwvetaWy9U+eTaqLFxT3c+BSdmVQfc5NxjS/+d4wpN1vl4HEmC6vJQfN1e9aY4479xjkC6JDXbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tewke.com; dmarc=pass action=none header.from=tewke.com;
 dkim=pass header.d=tewke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tewke.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDD2ZgTSgeUYgBqphXQK0IZHaXKqL/IB1LGkEzmHC6k=;
 b=CwcWB2hUD/BvaTl1De3F4ZG3mTC57cXeeqbmIbDbkx4kzpoX+xkLoh8mMUlzy0//+UpngbhjSRuhUNAMu0svJupXDfmw+3DsqTD1gYumHpL+w94EhzE4Py1oSFZ/G9OFIlBrOWhZ6eox7+KwetiHJxJk7bV7SZ1kA2Eo6yLWGes=
Received: from LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:333::7)
 by LO0P123MB6109.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 15:14:59 +0000
Received: from LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM
 ([fe80::9638:76cf:42ee:60a4]) by LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM
 ([fe80::9638:76cf:42ee:60a4%3]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 15:14:52 +0000
From: Ed Rose | Tewke <ed@tewke.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Ed Rose | Tewke <ed@tewke.com>
Subject: [PATCH 0/2] Resource leaks and Asus routers
Thread-Topic: [PATCH 0/2] Resource leaks and Asus routers
Thread-Index: AQHcsjL5+6JL4PjWtE2EH6Vw55nxiQ==
Date: Thu, 12 Mar 2026 15:14:52 +0000
Message-ID: <20260312151445.720413-2-ed@tewke.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tewke.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P123MB7137:EE_|LO0P123MB6109:EE_
x-ms-office365-filtering-correlation-id: faf02e62-559d-4885-f244-08de804a1c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 xBsRHEoBuL55PVvxvu01vEdyZUAAMDkVVMqmkD3i+/c4GeYAw6JIPIiHsG4zUONt4SItHFDGVzWFUPlTIO8UjhDvYPaUfu3pFoQtxHSwWlz6QY9xk24G7FsikpDEUvT3PFDidNqKrQW1/LMLYoXXid62ag7J2GHJOuEwRlcR/owozaMSCjICCgJkeILVQ6Ky1sD7n7CRhVzfkGjZkzIrLWmqOMxyKlmO72yf+bYsuQ5nYgWe3ZIT/NojTz9lyePZRgfJ9CWaTks0FY4pGq/Y65yxYNEhJvH6Fvu9kXFu7Us1BfPLXqlSX/hJzQo73bAkgmsxrnRnnKKXC9bgjBzlPO0bbZ9Ytwba1F5RjNMD4Dh3YfHhEZwc7ve9o61WIGFqHPnETVvs4ruxyb8Uk8rUgh3EaeN/uf2oCRHjtJkGmFsTecKMLbKHV9cV1fq9B6UBm6oBmq19ds7MdXOIhYSBijSFv0P9GZRZjyUMOHYW6elv7eq/l4iUlsVymEfIWYH7tea2AaTUL0Ak3kN5/aNMmuDMuL5DcwZsdstQtBKCGYmyrgxwWoQnzaHvlg4oydfaeitfy8pFl4VGIzec5S2cmXFOxY2bUw0oIjZsR1uSuiFK6J6lCozrKZoh9Wo8/nG7ib1W87ykWpyBmWrr5aICT3Qji3IMGjkMICDebhyFtF+JcwoLGNMyPHZPlBhVU/yQ7vksNU45+VxtADrhaRVMLSHUTWLuOYJ1D+zDYUqNRqFqgjp76baJ5q4CoOAAMmgp5VOGTTs5pBaiYLZ4IeI5v/bxzEVR3Aha1M3pXlRvEUs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?likUSNIZv9ZV0ITqYWFh7N2z7RXatNqgEyUMT3uHxEn0HojhyZfzQQiKPW?=
 =?iso-8859-1?Q?AJ/+NR9H7gtvu/lIa/CJx0q0Q513MivcCkT8KVjHAqzKicQbH6oPlBVKir?=
 =?iso-8859-1?Q?0st88COgPgviJBbxgClY/MgdyIUPxrYL//zODQqweMXiE1MRSrKwOL8QQP?=
 =?iso-8859-1?Q?w0Q6qUaF3hHoVjzRPFaCgYTOzY0+07GlbSAOSE9sIG09VUiISnYV+GU8hT?=
 =?iso-8859-1?Q?WBF8bs1TTLF0HoPx340t+UUserAonBoSZ6QVg1W7F3RuEPv6FVte+mx2wp?=
 =?iso-8859-1?Q?K3emxxWegG/+ZdXJnCt07hfy1oqti/5m7HZy/UzVNoV/dGR0YYcYHjJ+zM?=
 =?iso-8859-1?Q?pmWgTln4nbeGi5gLulqkK5eTJR/7G6qclpltJ3aspKOP1z5NkqL0+XWWBd?=
 =?iso-8859-1?Q?Ib2yEks//DQ2X+cxL/c1P7vziNvT4FlADZl2UZkQM+LTbHclNsT7lxJ7vU?=
 =?iso-8859-1?Q?joS3/cWF1TZCKwJFZG9nKToib7Xei4iyOwj2RLHZgsFDvD3X8aYAvsw5HE?=
 =?iso-8859-1?Q?hhAjcsECMXzNp8Q6Owo83Gf2IiGzRbDEfmMJkLQg8Zv4UbGHS7ryaQFwzm?=
 =?iso-8859-1?Q?MWAWcUTgwZwO0MXGZb3+sa5j0tlcFuMloWsQYUK+ydZEaxe9bpBdQcKMRb?=
 =?iso-8859-1?Q?4rONwfzsoyWH2OwwPfz04VEvnX5vWBdXmt3Dr/21cM+rf6ZokVja2BQWRI?=
 =?iso-8859-1?Q?zMm4C/vP+xLdDpg81AXJkP2xnjgzILicbXg9g9c8GW7eKtc7fqZEs64dAp?=
 =?iso-8859-1?Q?ZUnuRG3PHqJgfak1L6g++FZmi8EfckuCwRobyVW172riEkfGKr0R9pszJM?=
 =?iso-8859-1?Q?u92ESBMgBB6zyb/OEW4w+8MM4k2PZobR65Ns29TD4oQnWjfBX6troHgQFq?=
 =?iso-8859-1?Q?wE5Rb/4n6a9ljId/URVVrPPBOO4YEipMy534wuKCsKCSbK6B4hdErcKaPa?=
 =?iso-8859-1?Q?eVwJ3B6/QtMO/qQpXvrXdCo3+I4DAoNkRvxVt5N4VuJdLMBkjj8253h/v1?=
 =?iso-8859-1?Q?JNIKcKInBPVqg5K2xokZJWjIj+reKonWjzlawKFSs3OyzCHvnh7nVUbcGl?=
 =?iso-8859-1?Q?YPw8UifSekDZQ4/6D/Ynv4Q+5PyemuQXDBeYLs5aHc+q0ZwAOx1Hej+4Yx?=
 =?iso-8859-1?Q?ugGiveONPE7aFmH/kyui+tEngLPYmKlzC8/8i19+2rqrwgwi2Lc0zatnLl?=
 =?iso-8859-1?Q?JOP6mfdWFfCFcVXQrwKtUcuCLOR7+sFMmf01+oqGk2irxwKCsNc75lQmAO?=
 =?iso-8859-1?Q?OE0jCiqbNcjykWadshl/nkc+UtA2pkpIuYyLIdhseY1H+lAKJnUzFZbTqa?=
 =?iso-8859-1?Q?XvEajADrnZlv1Am/NPAlPWhbBfr3O2Er9kfglKNHahtcL7yYLRNQ665yyd?=
 =?iso-8859-1?Q?Cq0ie1bpJ/RBg94nfz1TQ930lufyZTXQKTFL3wNRntAj8OAwpvqqHySUnF?=
 =?iso-8859-1?Q?L2kZMrYBwz4JBuYZ113Pn9K1FD8Y4mKmaYef16tMq1FZpewimLNInOf711?=
 =?iso-8859-1?Q?hKonJClwBSdHZITq5c/BqP3CV9pOJFgGjCYO9q+AK52L7oEq6cwlWh3c/3?=
 =?iso-8859-1?Q?t14EB8qrpG5/njDUSQvW3gjHyqv8IYxLwB4JoROJFKhHSuaY5aJbvvydAB?=
 =?iso-8859-1?Q?gseZHFjlUrPvRgmVNVpulmM4wZGRmLTFzhLr/n2lRtqSBJk5oZu0hUjf8R?=
 =?iso-8859-1?Q?5uwEc3NYhXy6Slnlq4RnP2v4Sf0ZWuAWWT4YzZlM2RHcu6J0DjSWqIC18k?=
 =?iso-8859-1?Q?2BYFPnI0w8yWdZy2jmOcFKgEA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: tewke.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: faf02e62-559d-4885-f244-08de804a1c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 15:14:52.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6ded34c4-07b4-4d4d-97eb-db680cc7886a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPKQrG8jMr1AYAyorNBVrWVa716R/3VvxJ6pcDO+SevFfypCB22lb8Pxihrf0qDx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6109

Hi all,=0A=
=0A=
This is my first time submitting a patch to a mailing list so I apologise i=
f I've made mistakes with formatting.=0A=
=0A=
This short patch series fixes a couple of bugs that we've discovered in Con=
nman that are triggered by a weird hack some mainstream routers have implem=
ented. I'll attach a link to an article below on the topic, but the TL;DR i=
s that Asus routers intentionally try to crash a buggy windows service that=
 handles Proxy Auto-configuration by adding DHCP option 252 with the conten=
ts '\n' (apparently for performance reasons). Connman unfortunately tries t=
o use this value and gets itself into a loop of failing online checks, brea=
king online detection and triggering the second bug.=0A=
=0A=
The second bug is a memory and file descriptor leak that occurs due to the =
`wispr_portal_context` not being unreffed under some conditions, notably wh=
en it fails to resolve a proxy.=0A=
=0A=
The result of both of these together is that connman eventually exhausts it=
s fd limit and is unable to function.=0A=
=0A=
Here is a link to a blog post explaining the strange DHCP behaviour:=0A=
https://nuxx.net/blog/2022/12/23/how-asus-and-a-microsoft-bug-almost-broke-=
remote-work/=0A=
=0A=
This bug is super easy to replicate if you have a router that allows config=
uring DHCP. Ensure connman is configured to perform online checks and set o=
ption 252 with a payload of '\n' (0x0a). Watch the file descriptor list in =
`/proc/<pid>/fd` grow.=0A=
=0A=
Ed Rose (2):=0A=
  wispr: Ensure memory cleaned up in all cases=0A=
  dhcp: Ignore empty DHCP Option 252=0A=
=0A=
 src/dhcp.c  | 7 +++++--=0A=
 src/wispr.c | 3 ++-=0A=
 2 files changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
--=0A=
2.43.0=0A=
=0A=
