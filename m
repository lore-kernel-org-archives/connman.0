Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E235175558
	for <connman@lists.linux.dev>; Fri, 10 May 2024 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385216; cv=fail; b=qC96QQ7b4AeuCLmS/2wOHfJUHGESBuTxUtIDtpRBA2A4K5FiF2+M/uIK68Gy3IT+26rk1waxiTRS87kEMkOt1kKHApMtNRn8/1wBvCZu1bv3RBspf7fPr/3j8tXwF0LRlS2sakTJAJPF5vat0ewpEt46nwi2Tn1nhcOs+wuVltU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385216; c=relaxed/simple;
	bh=lQMr403+sxHN9PzhjjmZnBjiahYBbPP52t860BxaZDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I79bLYhMPHzTw82PTKPRgNj2ERxc2dTdwduDSFuHldjCxTjuG/ym27s+rhStSQW69FVF3vmEPtE5sIi4l75ug5FqQSLHyPjv7dnPLfeSd3uEM+W9ddAFVgar/qQjptdtK4n49o+8/LezY4pHEQZJnBe/rx8SF08veAawkKZVVGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com; spf=pass smtp.mailfrom=tesla.com; dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b=IjV3+n4M; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tesla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tesla.com header.i=@tesla.com header.b="IjV3+n4M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZcFAnKmGzhkoXv1WU0JvfFQ7B2X3kXaFKFfHRXAh0N8fstq8kM22RhQMD2ka8UVytYcm+yLaFePMCxblSW+U1x9JHIjL1zqtCltHMHDfSL5bCJVADvBTcmG1vgQOQyO1aR9ije9U2S23luaYrVU8lJ0cYJiQV1Vikx+HP87zOLaD+gL2h/xfzfQ4mq8TMZo00cLQvjieXPJ+n3ZzzOm7fYL9p1QEjclRUk22l646wByoLvUvwBWFZvLSQYyO8Rn3shojMkIl8aplcRTeyb0tYozIuE+xYNdkOVe2cZk0Tl1ziy8TyMBQx2ta9WxO5A9MEU1nrfOX8A6si+d1INcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1mcHORhrABR3Mv5Lt/BaBDIZDUT7nQNVHZh33Z+0E0=;
 b=Lid6lXisCoPKat1H91Sm6NK2VzIQMVwRVbXTt+Cf5c0fJoq1DczA1x7D9Djw06QW7xi1Y0M8TIaGAdkU98zoDgfkqA2pnmRcNiKvS0/Up1o9ciCoCwuE7AJIlMd+jpnYWMIGoRvpOQxmlpoC613s4Mcxvkf8LAAfZH6zSVnDbn3PxQ0JJFJmXIBHweM+PgbCYGR3H2CGayyKy4jgacU3nrpAKZIVtzjGSqlL1XKQOaozd69b06cTtu6oaEh4g+sBgtAPd7NDl+d5n3H0QOp/WdcmMOnIT2zVdLyuD9WVLY5LqwFW6e4OKjtzRNxkB+aQgYWsb3cHzZsT3KHwn+Us7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tesla.com; dmarc=pass action=none header.from=tesla.com;
 dkim=pass header.d=tesla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1mcHORhrABR3Mv5Lt/BaBDIZDUT7nQNVHZh33Z+0E0=;
 b=IjV3+n4MLAaSSgZCu+e0p2puauIoW0iU48RLPm0IrkB+vk8m1yTAnNpRG3G5/vzzI5ezs2CIwXnFPtt8K+5/AkVu3sNKvmDQMleFDnZ6td1WAFKxUdsrJDJqoQzF7Ir1FVtzKfS0mfwpqvNpsH92V7dpTCVKUAWW2aBjJmFXH+c=
Received: from DM8PR16MB4504.namprd16.prod.outlook.com (2603:10b6:8:7::20) by
 DS0PR16MB5368.namprd16.prod.outlook.com (2603:10b6:8:167::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.47; Fri, 10 May 2024 23:53:30 +0000
Received: from DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63]) by DM8PR16MB4504.namprd16.prod.outlook.com
 ([fe80::ad2f:63a4:40b3:ea63%5]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 23:53:30 +0000
From: Colin Wee <cwee@tesla.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] Prevent a short allocation by checking upper_length
Thread-Topic: [PATCH] Prevent a short allocation by checking upper_length
Thread-Index: AQHaozVC4DTBzVpAzUaX26jraTWGdrGRJAkA
Date: Fri, 10 May 2024 23:53:30 +0000
Message-ID: <20240510235325.3625167-2-cwee@tesla.com>
References: <555F580E-1735-4CB1-89F0-7866013F6D47@holtmann.org>
 <20240510235325.3625167-1-cwee@tesla.com>
In-Reply-To: <20240510235325.3625167-1-cwee@tesla.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.45.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tesla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR16MB4504:EE_|DS0PR16MB5368:EE_
x-ms-office365-filtering-correlation-id: 4eeb4438-3893-4a4d-660d-08dc714c650d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4u7rMWOfYXNWvkAU7rMt0jgYRi0emepTfjzv1+vQ4tHwLbN7/efuNhGq3J?=
 =?iso-8859-1?Q?PYKbdQZSg6ic01chepei1v0a6c3Rpt598A4FjRZvryUVNjiFzcJY474pQP?=
 =?iso-8859-1?Q?k3CpNycjoGFbNMLijmX47jb5nZatsNAFdAnX1Lhxz5QEzX4FbGRl5y8YjF?=
 =?iso-8859-1?Q?ukh8jP4OYQbDnaMyJCnaAMJAlKD+F+1JUzSC2BAes4nre524ceMPpgSztE?=
 =?iso-8859-1?Q?J1qrjrx2Yhry7oopEAWbTXexHgwfBK7g4/u2eDqUqP2Jjxmxzm88gbshJq?=
 =?iso-8859-1?Q?gKDNpOk+CXOJkjfBcR+xMP89TqH7VrlwG+E9O6Qes6Z1XvGoYeWPRHYXNm?=
 =?iso-8859-1?Q?uh+zIIHdld7KSzE2nmZEJ+G4Rj2v2b9+EJGCrEPNw8PdGBLgSdPZhH9sKm?=
 =?iso-8859-1?Q?wY4g9E7dLI56ULSk96xD0MwgX3OV15HylWj+n35jlvzCFLihYnxX7v6SuJ?=
 =?iso-8859-1?Q?thXJIC7qfhxKq1WCwphNlZ0sbR0gkQaR3UkgpzUemgSTPSGYFKFPh8ZFoz?=
 =?iso-8859-1?Q?uYnHq3KlokVfDlfpjD3T7REvO5NLjokVX098uT972H13n06t0nkbLgedHu?=
 =?iso-8859-1?Q?LqLlGC/vcOVfz00trIs5t04+byO9OARGuUU8+V4Lv3GOPmf6/TAvwYKfId?=
 =?iso-8859-1?Q?iUtapfwBReQLSsKYkiQCzbOXWvreeUeIDy4EPXFi88vSh8H7HBsZ9aeyhc?=
 =?iso-8859-1?Q?bNt0CItx8garXa3iIVgHwTECZvFVarVXvNL3rnuEe1kyTOTIXGAV/Jwb+t?=
 =?iso-8859-1?Q?TesgXvAw7lnGV/iNhdRWE4H/4ZLHnCWXsBAebBUMRfhu0fBvYHi8+hiil8?=
 =?iso-8859-1?Q?HmWy9GNUxgz2XYHmZwbezI0peFQrBINwcNbFyx8g2J6+0eUu4KmjnXnf4W?=
 =?iso-8859-1?Q?6SGu+eXuy+ZsRDZqdAIdd+PEM/m1rFEDSKJsHu8oMbHCR5syGOZdnmdhA9?=
 =?iso-8859-1?Q?NQi3//26buiTUt93FbOv9ujSu8UhpQqh24QZoRtnE+JReIAxoe+UwKWatr?=
 =?iso-8859-1?Q?V5imWfPDkkvO3ZhNMdySpfKPRn/GD3Nl5kqtGx0NA5A6drgJrQXzqGU+JX?=
 =?iso-8859-1?Q?VmXBCD/axwsDN+dS27a521jUBEbuPsYOWR4ChymlgFIQVb54NHr2l9ao9Y?=
 =?iso-8859-1?Q?q7hoYfiFE+WlVaV9LQXKhf2xHcAbmVDPDqbKU37/+qfIuXGSnOecCT9ofg?=
 =?iso-8859-1?Q?cadGmsllbgXOrhbLg0+5bxIcJ70wbaZIyMagO88CHG6erWeQKW/IGWvh+o?=
 =?iso-8859-1?Q?DeaghV/gxSoIg6JKunXa2qUn9bootVQGZPV3BKwGeVwGzRlauxMa1bWJa9?=
 =?iso-8859-1?Q?8OJDKwy6eVRkAp0xcGDr0psgUCKx/Y9RUFWHopdYAXuTQFtBVbqCNpYIGB?=
 =?iso-8859-1?Q?QGaK8L49+I5HmJkRhpibW9ErNo6xPmIQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR16MB4504.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5Kzat7PRAO33qRVj+Letp79xjf6VhCMoWc50QUR3aOyYberoBYcgO3FciP?=
 =?iso-8859-1?Q?wfIdXEsGrkKNw8AhRqpmk7FoX6ORJmZfz9j47FaR1FWojXv32WzxCzlxB/?=
 =?iso-8859-1?Q?k0gCfoBXynY9djE5VXogzf0JsBcHC3TAq6ggK8X+lwY5ha+Bi752UCEdzG?=
 =?iso-8859-1?Q?gt0BjfupO1BIPho8ZOUjraTxP9D40Aj+TAkem9qZrf2yJjYjC4aYX5SlB+?=
 =?iso-8859-1?Q?0RZ46tV37YJkNtIKb1Zc4obIsiE11TBdFa9nYdKhJfUaGPOa0iJz3t6s/2?=
 =?iso-8859-1?Q?p8NJQ3k7uMHcbMvUAZY0HrfjIH+42tsSHZcKK+1z0W5WpIJXSS9knp6yG7?=
 =?iso-8859-1?Q?/Zs6U8lKNCf1W7TEHrHWkH8MMIsaoTRjrQ1fh7qdMgqJNtEZe0VXOb6GEA?=
 =?iso-8859-1?Q?Z8TUOVyxnYIeAV2arwBn3bBvYghii1Ab/Z1aUHZ5prxVViwXUO1VAS9vD+?=
 =?iso-8859-1?Q?gHx14yQeyzBLZBOSaRXNq8q9K3+qEiDzNhcAbXutRK01ZXw5GksK9/rZD8?=
 =?iso-8859-1?Q?TlIxIR62eV+7eZF4KAGGFG2WA+wDukX1gIC41J2w4N1sWquobzuYmmQkks?=
 =?iso-8859-1?Q?UEdwjhjxvUsakp8pngNP+D0CtSa/jBQ17Hjj7S7TczqOa0XoPJjhFPhs4u?=
 =?iso-8859-1?Q?ouUsH3HjrLjVIyXC7tiXdEvTiuud4Ss7r8U8W25WnlGvLAIYLzuBbA9rnd?=
 =?iso-8859-1?Q?s3mUdcmlU3nADLR5RAjuA/1H4NpsKVoZFprgoPop5jVDAtxHk5kAAH5qjj?=
 =?iso-8859-1?Q?29W5pZTj2vX60lePbYc+ON2d0WvRaa/0Iu9BvOf21jEay88ig1JMbxwrpG?=
 =?iso-8859-1?Q?Bdttc25egg8tbyivYVTS/VWroTcrxL0JzexX5u4mpAY5ta6hK4dnV8zvff?=
 =?iso-8859-1?Q?8Z2Vt5TbzeIykQvdIKyotuIoUV0Fba9+IFTBIEUgQbdqqd/ltYK5HOTtbE?=
 =?iso-8859-1?Q?fttcw3TCRzHTPPIJNmoknqHqTo2IYCdj6oijfOxV4w40DDxHg6jko2hji2?=
 =?iso-8859-1?Q?5XiI23QflTlBJwTcF87RD6CTXEhvA2O1tP2pq1MQOjwydNaszM6waPsB2e?=
 =?iso-8859-1?Q?UDtYkdgzmB9QIxzRaIDtNaXY5ODZMbCa1udaekBUOCjGPoEAoCVbbNU1O1?=
 =?iso-8859-1?Q?2Jz0dspIaxSXzlHyGDoUWJXv4nZ/YjVocZaX1TIkArxWf/H02Mw7WvArw5?=
 =?iso-8859-1?Q?KOgTlfa7+vKxg2/HawWtnKaiCfgtWCJPih06UgXyUOs0EGiBL+wHkD7fia?=
 =?iso-8859-1?Q?QW+avTak04kgZLMdNgHdPjxge/2A9B4H5S2hqOG6COQpU0ib20rO3UDSia?=
 =?iso-8859-1?Q?JDRlc14iy9w3cl3Uxk5i7wyBnzLzrBdvd6WpK8SXR9YfUC9Yb0KOLsI2fo?=
 =?iso-8859-1?Q?o+eA7ZvQ9UjUSxqwPKt6l+abkCqj403hXjKDNxoz6uwKs4IWM3wzdId0M7?=
 =?iso-8859-1?Q?BTlyFViX84z6zqmjBN1YILk90UDWyW32BCULOL3Lamn1srhvVySPp2O7lN?=
 =?iso-8859-1?Q?S6ebP0cKqQvUfaWEb4YLqClOg7u8Z+S05A8pcUt5sZ8nMrCMc4mAWE0iFu?=
 =?iso-8859-1?Q?+98IZ2NanaSISjIV79MZuUyNhVlgyqNHKoM6F4knni1X3gOHuHXAObdE6l?=
 =?iso-8859-1?Q?YrTX2JJ+VaHSxwlaIkRT1yGo4UBy8fqdro?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: tesla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR16MB4504.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eeb4438-3893-4a4d-660d-08dc714c650d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 23:53:30.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9026c5f4-86d0-4b9f-bd39-b7d4d0fb4674
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j473d5kqC5r/ED0BAE9+ZctbZlF3V4EbrzVof+dZW8namX3+iuGI9gKnF6uD4YQ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5368

From: Craig Young <cryoung@tesla.com>

---
 gdhcp/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index 2afa19e6..c9234a18 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -1863,6 +1863,8 @@ static char *malloc_option_value_string(uint8_t *opti=
on, GDHCPOptionType type)
 		return NULL;
 	upper_length =3D len_of_option_as_string[type] *
 			((unsigned)len / (unsigned)optlen);
+	if (upper_length =3D=3D 0)
+		return NULL;
 	dest =3D ret =3D g_malloc(upper_length + 1);
 	if (!ret)
 		return NULL;
--=20
2.45.0
