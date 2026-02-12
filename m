Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021130.outbound.protection.outlook.com [40.107.39.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86235B634
	for <connman@lists.linux.dev>; Thu, 12 Feb 2026 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902832; cv=fail; b=C5fN/tPdEteMsutsZ5kUAL/uPK19BKV91ENeMPOY52Byy6FPYXT0J7ynOMbrysz6SfeNKRsSVT9cbcI3bs2U+SLa+Jmsmyep9UUZYVDQJK1uQ41lwzm1vSaiu3mijpgr9izKfI7D3pHOCt5E2MGmbmJzw3WVgnWHktKmGiiQLzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902832; c=relaxed/simple;
	bh=wcg5RNz7EfASeiwdJYqYo+AMNfZyIUILApR1RH90HwM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=j0OVacexacVP+r7Ub53d7W79iVY+Z62WY3YVd4yZcE/mhKDkNFcyeoZW2lnuqD6KhwAiHZjtO4VUd6bYTo87/rfagmsD93s/4LilGH45E57eurr456i8eTBIEtCYxs5+uBDcWbmGcZmqc/UBDw4FG/LXWX4DhrpXifc+990ikHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niin4TpTBjZZBPcf8QDSb8DBmzfgp1GVUPIYd6r3a3OKh8BATJ5QPT7MROcZRrQeZ0BNmbukMn6LUruujeSpCmvWr7wg9iTPhFX0CsT3srCPVeTJwVfMgwzLrClRgvLYTjMAN8DrEpSkkkqkzV1p+BaNehMGHjSY0l4a7xBj2E0rI/sLBDkFKXDz99GhTzXedtoJx+c3puDosPVAD/HWqq6bK4hTHk4/yyNNrhmKvH7hzP1sXt5h/AMtF42RQLYapkFP7fSgasYxDJZeJ6sRFUqxogGHe0B798Buam32kJIvxQEeGVAX+YMg8KnzDfQa8TwdGKueT02yI1t9lJxOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXseYlyu7V25hN81Tl8/sjZCHzGAav4CZTpSL1XHS7Y=;
 b=HlnZ2RWlq3M4qYpwRpTTr/wLk/84CAYnlv1cMIihp9znukwnMG7hD9SfoDuBMyeROzNnSBiU008P75EMW3Hj3MVZJCqZ7XmReP6gW4TjRJVXNwFHNvfmVZZNOJDrzmpIu8nQVGq9oNkaEiK2BjllEaqNGfUa6yoY/v2Eihtd2g2km2XUp79HIX93jr7xR+mpgMrJWgKON0sKJcZyUFjxGeDMw0d+KYm0oI5MjzUUWm5PiSyvT0hRPxDkFXX4Xt5AoEcJ1MySphMS3jEzBBaNhOERJ4wg7oKjwUc9SvPyfn4MW3rTYrqzGifk+Q6BOiwJXLPax3wibRkuzRR9rI6dnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 ME4P282MB0838.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Thu, 12 Feb 2026 13:27:08 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 13:27:08 +0000
Date: Thu, 12 Feb 2026 13:26:54 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: connman@lists.linux.dev
Cc: rudi@heitbauum.com
Subject: [PATCH 3/5] gweb: Fix issue with const return value from memchr
Message-ID: <aY3VHuDI-6Ir3Xt-@01676446e9f4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWP282CA0075.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1dd::12) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|ME4P282MB0838:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3660d6-d8f4-48f3-5f38-08de6a3a6bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4jq54sWAj1Q0G5hbpqHVd8ONRCY5/lrz+gMC2p0+9IH2EkAc2uF5rUcIV37j?=
 =?us-ascii?Q?M34wQxvKZ8yT1tWGboB4rl8hV0TAAvLSr21dGHsJYHJYltuseYtHCyf7Ia2G?=
 =?us-ascii?Q?qy5ClB+dyfdHed3OsVsURBOJKVAEGBfTMwh99kRE7Rk7/zRFxmU0otFQE2k6?=
 =?us-ascii?Q?95Z1JMdwpVeHILMBFm6sdh3NFmB1vYRzLrwmYjTZLrSrv75N27FQLvnoOM6R?=
 =?us-ascii?Q?nOS/1ptR3WvLB6NiruAMDkqlyYvx/chzbAwK24OK0oLsIlla4Fkv0rQ2Vxtc?=
 =?us-ascii?Q?dObSFxQopGcUKwDMlLDzumSVJJWRHdbSWdbZp0u9pHdg0OyyVz2RMNE1Iypk?=
 =?us-ascii?Q?jigpvIiHSPfr9YdDY2NUpY+c/b8UlBD0NbXY1udcUDl+/Rha8jRcTFVnwjhR?=
 =?us-ascii?Q?MS0q+Td8N0JPbaXwJvX+BoUlXcn8Eoqqxo8ry1Tt49DuY844S/+V8/2/7a3g?=
 =?us-ascii?Q?/4ciPoUVAgzmd3ujPktiQyGUlQnhRZLawYhfLDa1jy6rJ9j7NbMPQpMB00oD?=
 =?us-ascii?Q?Wn4mFftwUdFVX17Q0ePtZ7EjzbnytEuPsY2hThE/VaTrSlBZVa6WC/VKDAaB?=
 =?us-ascii?Q?RTo42ZA51+L5579T726T83WxVN1ZmHMLUYRoZMyVQZeLI69Bs4yw7rAd9rBw?=
 =?us-ascii?Q?pUq+Jfdwsuk0L6VX6Abue6/QSoDrITP9uMcHIKn6DJB6E7uW+TDdyPq0wmun?=
 =?us-ascii?Q?SKlBX+99h4vK0gzhH5PCMthG8xcwJp/1XrvA7iA871We5HajFN+RgjkzFoD3?=
 =?us-ascii?Q?/1g/DNKVHayG9l1OdDL491igM+XoXYzlRpzpf94W9KxWi3xF6lJzDmLJkeeL?=
 =?us-ascii?Q?0t4z+sPMRGI4wlTSLX5QK8PqQsOC3gnodTeV62KX5Q16nzhOR05wdbhjubaL?=
 =?us-ascii?Q?qhUWyzgsBtcHvUJMd2tBDxceuS1QKQhcgl9UiLJR9G6VJyXD/5EkvldIGaMw?=
 =?us-ascii?Q?fkq5S2tjlkIoVJSFxLZ76dUWwz4PrUnusneHCb2J/3BCtBQ+B6jUPuCLH2RU?=
 =?us-ascii?Q?3azU71CqV7N7Tdsqy3VXadgVHEwyYedxSN2PFViN3hypEF3wLdBoiJ8f90Rm?=
 =?us-ascii?Q?qAt81byifoDSj0MCy7nPQWqpCdxA4HAaUbDh1kWZi+AD7er6RZeV0dv/5MEA?=
 =?us-ascii?Q?4tHJ8GYr+O94lqWu6u7cW/DXT8c5YO/8GM0Q6nbg38p6cCOOu4lnTt7RFdSt?=
 =?us-ascii?Q?7455pJph4dAtYJ0yKmoMIZCiraF3dFOYCZw/8/WZAL0e2e5Bzp1SEMQpfFxR?=
 =?us-ascii?Q?KD1XIoMan6F8tup/g10Vib4my5aBrkC6qDmL+NdkBfm/bfnA5ryYRD/DC9JV?=
 =?us-ascii?Q?tt+PZByZZKtu+f9WlZCco7eZbf4V4fZnWO81XZY3azRY/0g3lV/vpInfVxJF?=
 =?us-ascii?Q?VTG0QWuEFAW+N44LxEBl/SHZuI76Kx5XF6z4Yu1Yx50JECC4ZGbpRf8mS0C8?=
 =?us-ascii?Q?uUEE6gyqqCGQf8GMYXRrKw1NCseDTCFT9BaEns+BUsLKmBPTBgrznCI1lNJm?=
 =?us-ascii?Q?eTBVz0ZXGv9NeaUgkdrFCgzlJJnG34PvBHF9NbWvhK6uPg1zigBgjGWvZ0jF?=
 =?us-ascii?Q?hRs8Nf7S+1cTD45uctw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jKLsmlyPMHBdX1hsVM2cjt9cxH2rohp1HnnrveNg+EgM5Bz3yHba9y9nvQGy?=
 =?us-ascii?Q?qdwtzBcJwCWrROTZ+Q/eaveZJvinHtdFLeVUeGbNN+Gy/Eco5PlRMc0Bu20M?=
 =?us-ascii?Q?vhQtSqouHQeOnqvGIi2Mw6NtJtz1PQDJO706LwpUk66fg2UvYxcgFlLGXodX?=
 =?us-ascii?Q?Qt9V5vm4N8e5Su6kJQs+IEPNxctJmkfhP59hjEkHCfwkE7f9PBEzwEFwxbvl?=
 =?us-ascii?Q?8VoAXZtFgHUxMHllnAOzkGCljSTrE0gL6S5ZXnF/Q5SjLoBFbtfRfEf+VDWE?=
 =?us-ascii?Q?PEkhEfZt0c/JtVx5aQGJxYrtB9eZb8eqUO650U3cRXLwAJ1VcGT8wAuF/Azz?=
 =?us-ascii?Q?/qXSw8w5pc3n8bpO6+81Zh707v4/3LBTwyYYcvtB66hW79aAnH2wp2Qv7Odt?=
 =?us-ascii?Q?Z4/SmfQZj5YUwAXPlvZnwRLi8Jt7y9xU6mmebyvHy/SBjcGFKrrV6ScQmiTg?=
 =?us-ascii?Q?Y7MZE038cMoIKzN70BnWZwXJzYAolNFep+8TptzK2eIqh3yp186+6IQi/rg7?=
 =?us-ascii?Q?SjlP+uZ0hOjhU9r6oSkednKCFe3cA3vdRJxJDsLrOPDVcAfUVX9G74j8oLcD?=
 =?us-ascii?Q?G2P3KcBVfU6mxoyk/FJ1VhNdlGjy7TwM9Bhx3ok6A+rTHlbeuqkrAN5wDZPH?=
 =?us-ascii?Q?96yHsTZC7fQ6y06XXLM8f9CUKmhzdb69150Zv5BW2iZBOuWYHs9DRZH08ZME?=
 =?us-ascii?Q?swmooaFtytaVEDRXFm/nytcGnSRXQq8YnV05p/RcmhnWGoH3xlRT0oc43n10?=
 =?us-ascii?Q?mQkT+zURx0C+2JsdT2dKV5a5hrln5m0Ruk4ptk108byBfXTHsa9wLQfHwmLc?=
 =?us-ascii?Q?vPqqjBb420M8uC0PYFqEGMiCt5mQBdU3J2l/rCzBP2zZuLLLq3UNdRd9u9Nm?=
 =?us-ascii?Q?qIHpm0XpsBYJwi1yhCNSRXK0lFU+hAK1cCnB7pUhrHmJJq5+8JFnrCOmRdZT?=
 =?us-ascii?Q?FowlH60YDGhT72U+UKtWWnDPDnUwDVDrlIa1aE3R0KRN+PO5wv5EHYPU4uiI?=
 =?us-ascii?Q?ZwZwK5EOOu0VjzpvZXkhUe4b7ZiYpl7cxGv8z0m03qIkiCIgLUFBaXOv1hoN?=
 =?us-ascii?Q?41KkQFklqFXQF/ddMpIdKfldYB47cTFZSzlrzitGPedTDX3boMV9aGPz2wNT?=
 =?us-ascii?Q?wbmuQLXgtkNi9nwWi//CmLo2kI8zsgui3yCrHeCUee+SW8DU7F02+1aL9xue?=
 =?us-ascii?Q?TAN0dneH3a33Y3VaaqQuc4auMBZe45k52pZ+5/B9nc7szxaPs2GbruYdjnZ4?=
 =?us-ascii?Q?vi0u/p8OMU6J4AKT0cL7Ypskle7MUV5bQfzyHllHCZM9NauCMM9+QkY8DAvw?=
 =?us-ascii?Q?K7RpxSW+L5E4KreHDLP8TJPEWmoq+/tWuroz+Xiu7uZyUbcWKdwiaAoAWx4/?=
 =?us-ascii?Q?d/DYtE5r+sAj9cVo7EKCmvE1d5aMEZ7qLEyd3IlIraugcd04QHIFA1FD4yWn?=
 =?us-ascii?Q?MIfejQ5TjnWDMhbFRILza09DLb0HdfOC6BCYqvTMIlT1nO8NJbUZyUujgC5J?=
 =?us-ascii?Q?pQtnvwSCeRfejebfSH5fXh78nTUOHSBLCFjXzGW9nMSL/NEJOKDDos4tXazQ?=
 =?us-ascii?Q?KCNLlREBY4FEKJVWCf+G6yZxupYLe9aA7UmmvcogCVw3fynGNSM5Ej66gGMd?=
 =?us-ascii?Q?DAUOidunn1cnPi/0JIIfeIz1X3PRaIAuGYtjgmmXiyBXXsTGYvoUiNIZj/gi?=
 =?us-ascii?Q?UIQZ7vvQ5Terol5XpcND87TYbKUJtrVgN3xMD8Q8cPQsz60Y?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3660d6-d8f4-48f3-5f38-08de6a3a6bc8
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:27:08.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjfjXH3Y+0+xm/KJYj2EBr2O9/IpjITGQoWUDqsmmRXdD5wM+bLPn6xGbhDQ5jboZgvyaIx+g3m/pz3qRDdVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0838

When compiling with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
warning occurs because with ISO C23, the function memchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the input argument is
a pointer to a const-qualified type.

../gweb/gweb.c: In function 'decode_chunked':
../gweb/gweb.c:1034:29: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 1034 |                         pos = memchr(ptr, '\n', len);
      |                             ^
../gweb/gweb.c: In function 'g_web_parser_feed_data':                                                                              ../gweb/gweb.c:2922:29: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]            2922 |                         pos = memchr(ptr, chr, length);                                                                          |                             ^
---
 gweb/gweb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 4dbbb4c8..0a87da64 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1025,7 +1025,7 @@ static int decode_chunked(struct web_session *session,
 	gsize counter;
 
 	while (len > 0) {
-		guint8 *pos;
+		const guint8 *pos;
 		gsize count;
 		char *str;
 
@@ -2917,7 +2917,7 @@ void g_web_parser_feed_data(GWebParser *parser,
 		guint8 chr = parser->token_str[parser->token_pos];
 
 		if (parser->token_pos == 0) {
-			guint8 *pos;
+			const guint8 *pos;
 
 			pos = memchr(ptr, chr, length);
 			if (!pos) {
-- 
2.51.0

