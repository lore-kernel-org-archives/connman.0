Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021135.outbound.protection.outlook.com [52.101.100.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD625D53B
	for <connman@lists.linux.dev>; Thu, 12 Mar 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328512; cv=fail; b=g2d6eTWhBvzhr8uAvO4N0xcOl7XJqBStr9aEF+/PYiVCBPaPIiXoP837/evMcesy4zILTM1w2WJTza+Eiig/xkg8DvNyVllX347b4e9As4zRYv7I9KfYa8saMKL3L1YDp9DsREyR0bEUyhFEeBbX3JFGNv2j0EVcMyoF2F6COxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328512; c=relaxed/simple;
	bh=YEyPb8Jt/bjLgn8MlQc6SvNr+A0uICR3wreS41qHaac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+xn/oKAJX5+3FU5eTVTKCrwQS6s1i8WgZ+jIL8jqch8RgSlNNovOPWZ7C1y8XufTZA/xq1LitbVeKsRvhSxhSY4tcOM82fHqu/voNk5d82rKAtXix0zFiZL3v2fQLlDJg27BKJtDoVE+nNU55KzMiD+HRraRq/Lq6fRkTFfcOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tewke.com; spf=pass smtp.mailfrom=tewke.com; dkim=pass (1024-bit key) header.d=tewke.com header.i=@tewke.com header.b=CTW2ps6z; arc=fail smtp.client-ip=52.101.100.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tewke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tewke.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tewke.com header.i=@tewke.com header.b="CTW2ps6z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inlf6Wjxx1eIGEpD+xmdGvktAB99YFvcZHfHhWlx5FR41PD3fB78Vpw7M24rw1QJ442U/44t9embdbPxOAus9udlQAbrWbJR9AnEaZpVa+11chvwhbq2sLYrXJj+MgqE1tGlDGjnbhYyvkG5VtMM+J+SHdMB2/1XjMHFbfi/f9zrvUYTAQ5WqP6gWMKgEgCMXyhnTmtJ67nGg+KK7RQnBRZmHBMO1JBvbTs/mbvPA20aVRE991GNgEwhNhfH9A+iCmRPXgzito+N7OGDxiSH74z0ECzzs54C63bRjfNnHdUvEW5HwV9+X/AmPjMLOBqIbcb+gMwvYqUbvhUSsVesog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKFZU7hpnWd5u7xx75Cj2Q11sdYMiSg7pVprD4H1tek=;
 b=B6pSFY3gMSTj2dDF8NBdSQ7lT8fZW26gpqrKHm2Ri+U/gHy4jmD9kIM/1lovIGHvxAgzoKmyCaeHecXcQkOnhLpRPZJISUPpcCtuGoqPFvQtYFkeRFL0b0w1jKWe+HgT/kVQpeWt6Zu9C6+sRlt1G5wC04C128EQMJfqUVCxec7v0bI1NqQQmjzNHi0/0PDJEISdH6dFTeEsseeZznT/eEHYJ8eTKEXbAe5xRBOk8ImMfKe0qxs4MV0ySGQkUGnjNejad7TqNZ3Ru95XFbOdhz117cRdgucpoOBALFdzhuR/ciN6PGGB6UVM3qNTARzeR23/O9URqJYKlEJzvuPLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tewke.com; dmarc=pass action=none header.from=tewke.com;
 dkim=pass header.d=tewke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tewke.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKFZU7hpnWd5u7xx75Cj2Q11sdYMiSg7pVprD4H1tek=;
 b=CTW2ps6zc5UyO4CjHTMdbLOcCizYcrsFf0u4q7K/VUmdhyOVJze8OxzWcNkNuaNFW6qqdVYP4Y26Eo0Laf3RibkNB8A22bP09XD8peZ7jZLo9g+BVclMp8qlYgKYAdnx21rHbXW3KXyZxeEBHpU5YCLrEfvY3NLbUsFUSpL9YnQ=
Received: from LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:333::7)
 by CWXP123MB3591.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 15:15:06 +0000
Received: from LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM
 ([fe80::9638:76cf:42ee:60a4]) by LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM
 ([fe80::9638:76cf:42ee:60a4%3]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 15:14:57 +0000
From: Ed Rose | Tewke <ed@tewke.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Ed Rose | Tewke <ed@tewke.com>
Subject: [PATCH 1/2] wispr: Ensure memory cleaned up in all cases
Thread-Topic: [PATCH 1/2] wispr: Ensure memory cleaned up in all cases
Thread-Index: AQHcsjL8UNmyDNytdEyCKgrMBh2uqQ==
Date: Thu, 12 Mar 2026 15:14:57 +0000
Message-ID: <20260312151445.720413-4-ed@tewke.com>
References: <20260312151445.720413-2-ed@tewke.com>
In-Reply-To: <20260312151445.720413-2-ed@tewke.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tewke.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P123MB7137:EE_|CWXP123MB3591:EE_
x-ms-office365-filtering-correlation-id: 5b706927-ce34-48bf-edcb-08de804a1f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 52eSaOFJx15KCxx0c4XYHrHPDtIdqaMbYbp8xy5+/BKcWzv001aUmItp+42xmwhx6+Zm4rVUCo+5rmPCh1txI4xz2cI86Ma2vaNJFT3b/OIcezmrasuHFeRUyukyE0Mclz17O2eb2l92JoLnvI1AIDJELQNRJh5E4IS8/f0BkAQNF8GwcwWm8YTdwC9nvUXu1XBo9aEmIWkGTjbcXbSyKF+mLCoZhd380EVVYlXrsyleoUnJeNzZBOCu1sFo2XQH91RAHuSVifqciPcqf4cScNG6GYKB858n5hXoH50iX1g5g2FDIAawN9x+uWD3wuoOg5SDy1vOUr71g8/HEVMpO3hnSrBOEBsJC83bD9qDA0aqKb3/esXAFR6Zk+pRoa/Nfs0RY2aEOh8LdnL4Nm90DnoENwxrBh7dppx9vR4fzgb837B0+c+8ZXXlaMmfLV2H7rGLdWdmxlGceI40fvE228e8nFec2JKAtnXctYEwQovtH6/JXC3vL4uplxdeaQg3Y2qNJdJTOezBUty3lFcUYz61mM3n7KX8p3TUWcYMRCcprw0ab0nAUF88FUo6IliYQRj3bgVYwXt2bCkXGxpA8xwFImTKRmc10OJytz1dUmQTUCtjx758356TpKVAaEY754OCdZog9BHk9C6HWBVmVrBg0TYVRYWsbPMl304L9PbPFw8kR2KyXo36iAx65pBe3UW8ojt4kouYltk+r7pGzQ6tkZ+hT+NzlCMv8WChQLFkM5FA0tDZd00oIgNtnHPrIaw6kDv7U2LM8CLxvgMcD/DwpQkE96+MQKI9CpzFQpc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Znmf60sYgAav/0xpie7Hv0nISwZVu+FIgxqS6sH7OAe0r3Txv97XYNKg3D?=
 =?iso-8859-1?Q?13QFKakH86n4I9wYYQsVYKabEq6BgGx8fSFK4p/Q/MsWB0yzLqWDJtomRw?=
 =?iso-8859-1?Q?uj7Bqjy/C1VtKwzyTabuqBIsv4hBTAfUATK+joRIUXrOx4zGENSppaLNBe?=
 =?iso-8859-1?Q?AngHWyiFpjZS0LraVcs2QMbVoO5tEO7g6xNyak3wx2wfpNho+m7ZjBN0Eq?=
 =?iso-8859-1?Q?dyzlnVp1ghck7p4shX3mTyzq3xKL7qTVGNqTh5q3xHKJGzXNKhAjGc+CiH?=
 =?iso-8859-1?Q?CGhbBCUi5O06LtkInHZQWXd79RHnsQwRSBOnboed/cZikpxyAnUmzIi63F?=
 =?iso-8859-1?Q?YNYY9sHM58Eh/Hagk688QWX62NcWgbCED97JSHTBYuzGwuuoH+FMqi1rol?=
 =?iso-8859-1?Q?WLiee8BPQu5BbyjOKmWyz/ilhgYbCDqiDP17WWFyiqHDJGa+ADqorK7Kyv?=
 =?iso-8859-1?Q?sXmHtNvdUHcTxK2Kf1GkGqJ/AudR7Gb2ctGXd9QGrhtN3audy+3lQkmwKY?=
 =?iso-8859-1?Q?PXepJgcdUznkW0GUpYe15Q+kHEogU5981KQ7ek8bC9TjlvJDB+dmq512y8?=
 =?iso-8859-1?Q?zrqK3fOWknUdU8VUZb1QnsDFyk/BPRlNfcyDGYdm/D+4N3gDpseHTGVS0O?=
 =?iso-8859-1?Q?JUKX7en3Jzghnf7yjGNrGmzt1bTKRLn3smnA6Nh+otWxD6+x+fxXgNaK4e?=
 =?iso-8859-1?Q?MgzVn19oZgAK86A3fRzxvxTHkZNv/caIIkCv0fo69EpKmXGgVjIDTLb4bq?=
 =?iso-8859-1?Q?8J7DLjJBkxU291wEh0MTyUh0K/C5mOanuYVb61mo0aPAuhWyyypKM/cOiN?=
 =?iso-8859-1?Q?ujelsLaM5Bjkr8keLDwBVu/2JYFeugTdqDUoDp/Y/34a8r6ZQmA7rdmqow?=
 =?iso-8859-1?Q?LEjaMFGDrOQ019xtBC/1Q02R7J8x3HK+eKg0p5Fqip4u1CEe6XwGIJMdJN?=
 =?iso-8859-1?Q?oj+U14dr4mqqGI7KkAFOktoAKFfb+Yui+3tHRU9VycTMIAyFllsFhApWro?=
 =?iso-8859-1?Q?uHD87DYJO927RmT1nj9pKwCi3wn3JHiCTJGG3a+HZm7VUdKSZaEbz+5Irc?=
 =?iso-8859-1?Q?8w7APtdGV1EIwejCayLeOnZxgH5h3P8/mhrPzYnLAieTF0uj5VeZtaDjjb?=
 =?iso-8859-1?Q?NHCzIssQKTWm4gQrcwdabnv0ZCKLtV1/ASC0VREKRwvtAX6tbvuJv5VVGV?=
 =?iso-8859-1?Q?IWCvfwOyynKtOgC1lgC5ibeqhUSZnki9b9aAfdtXiNj/ng9EQoEkAudmOJ?=
 =?iso-8859-1?Q?p+PC2/d5Tb2bujiNIlpZT0uOyYmlI6wQiUsXcLHmbVG0hjSCHR+xCcML9B?=
 =?iso-8859-1?Q?X0KzqN8VFe3vvZTMY0L4fYEYl1luGZlmQkNFb1KzID2FPTt7P6+9vgQwG0?=
 =?iso-8859-1?Q?WsYvrokSBTLcyfS0wvwSTp7QIQwAt7xve7uZKCYWt+d/JqE9tEggd+9BzM?=
 =?iso-8859-1?Q?RB1ejWFd2F97BKejw94GFqCU1jopZPAtD/uc0HP71H+FhxxbGUEWDzqO4N?=
 =?iso-8859-1?Q?w8HpC4M2FSrI/u9XgikfWzykV0Kgu5ctQPqYXfsBk11m7ct18IPvZVLkLT?=
 =?iso-8859-1?Q?xTYC7PMfd+F7fwkcdSzmcDWoXmskxtnwgK//zpRYdF3GNl0nE98M1z16DK?=
 =?iso-8859-1?Q?HX7hwIdpxQskwZs8eOMG4y0l3tASrV3SjjYpDUxCZ9xajWdh2HT8ndm/AC?=
 =?iso-8859-1?Q?aORD5ZosCkjPQhzatVIW4A3ipJPZ5vLovPzr6+t/vE1tv1xfZ+STC6W0BZ?=
 =?iso-8859-1?Q?vw0QxCS9PiaVC4hnBwvCqioiA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b706927-ce34-48bf-edcb-08de804a1f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 15:14:57.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6ded34c4-07b4-4d4d-97eb-db680cc7886a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WS9hANl9uGpUZSlgG/SOMnGhR5bwrhN5ZIhF0+I1LCPhF4ZWKLDQVMUtfh2xIdXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3591

If `connman_proxy_lookup` fails to resolve a proxy, the code path fails=0A=
to unref the `connman_wispr_portal_context` resulting in a resource=0A=
leak of both memory and file descriptors. This can lead to connman=0A=
hitting it's OS fd limit and becoming non-functional.=0A=
=0A=
Resolve this by ensuring the reference count for the portal context is=0A=
always decremented, even in error cases.=0A=
---=0A=
 src/wispr.c | 3 ++-=0A=
 1 file changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/src/wispr.c b/src/wispr.c=0A=
index a40cf353..a8e16b7e 100644=0A=
--- a/src/wispr.c=0A=
+++ b/src/wispr.c=0A=
@@ -1303,7 +1303,7 @@ static void proxy_callback(const char *proxy, void *u=
ser_data)=0A=
=0A=
 		portal_manage_failure_status(wp_context, 0, "no valid proxy");=0A=
=0A=
-		return;=0A=
+		goto done;=0A=
 	}=0A=
=0A=
 	DBG("proxy %s", proxy);=0A=
@@ -1328,6 +1328,7 @@ static void proxy_callback(const char *proxy, void *u=
ser_data)=0A=
 					xml_wispr_parser_callback, wp_context);=0A=
=0A=
 	wispr_portal_request_portal(wp_context);=0A=
+done:=0A=
 	wispr_portal_context_unref(wp_context);=0A=
 }=0A=
=0A=
--=0A=
2.43.0=0A=
=0A=
