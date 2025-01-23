Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA620E6FD
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632290; cv=fail; b=OiBxWYA4Ezeym2jUwB7qgbQXO0lZw5acvapQQ1PF8FYkAvdj4n3VVEufRPoX/AuGcIt4tQ39H+BMUVj5enACa7FRa+JGsOOxjUeVvHrvMX5Sro1xx1UbK/wNbuB76wDQ/v3w9HcxVVkmJO4ezesD5Mdt+6ncSIWkYfuwDiRPSzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632290; c=relaxed/simple;
	bh=CMjskL/j5361Qp4DHQfnNPAAVRfznB5iythIyTYQSoQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d6/XADPey3oSNxf5QQ1KesidPKIOPSRTnxdaYlcI8zynyurUsme3qFCxvitduI5k6NCYFGdLZnfM0BezIlXfotEq7xtIW+O8vZ/OoxCUVH/9SXCFe3sYAUgZEPE+QJWgjJjnh2GNJjHkuju7W/YyOFXsWC7O+MkwPSc6bjf22G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=QemWnEIa; arc=fail smtp.client-ip=40.107.249.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="QemWnEIa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVZ2D0FyMK76bHYkI5/1a1QRQgIijQD+V8x1wBWrxZsXlPFR36DpPo6xozryUNoLg8x+3psanDGNr/tCeorLZ478Cm3gHXIoPvkc1fn+xxtim15dBFGVCDTw4H/nlRlqI6Koqs5rx2412Wtbdt+gdRM0YG+M4Ey6p/H7cPzDeTGnppO/xbUxi/vJCSeO99T8n+07rxR6iyicZ3WvRHptaeyK/w7lZQDWR08o2i/dFzh5PCuCyW2Q9PkatTG3vfuOol9t3fQZD3J9/uLm3+e6QNZefRgMiJH64oJsrNwFeIZhe7dzxxI5Ocywe6pBB1KVPWDD6gINf/b/fVITdPnB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM7ltuHF6PJIvQVrt18zIOzMtiw5z0X/EIFqZ1rn8Cc=;
 b=nC43DSp7zzn3w8CaAI339c83dUmpjbG/jnSfnjge8i4dj7rLts76XNoo3L6Tq5AmPnbRDbNkJTxJQvVmK85+K20g5jSa0mpziFdVAnohjywhb/0L20YOHlEyKkcyKkQsy2K3zY9Dchu++4y88pQWiSjsc09cs5oEqXmD5d8H8CoTdPFZR67E6MiqLhD4ktklf8M0abVDBCtUUES1GlrKlrU06dJ5UFHgTYz0IzPIzY1+FoNRt/2taQwl186VAQyG4WPihvOWWCrfVwG7Om1u9JwT32nRQE3WAnmveQ43NjH4zsy+nqOeAteNRGl3bwDyNnhBWPao2kJScb28mxUE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM7ltuHF6PJIvQVrt18zIOzMtiw5z0X/EIFqZ1rn8Cc=;
 b=QemWnEIayZjVoXImnafmMn5mv2CiqV4Uv4wtsGRHa3CRYca0sEP6QJDItMB4jr9I7vBAen2MkOyAoNJANSINLtzW6rkYOknar1mPi1KmwAhoreNMW7JCmiYLpFqsIy4sEOQG52pyJPFREI//OHuC0sj2McuROGyWuUVgyY4rMBc=
Received: from DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::11) by
 GV1PR10MB8461.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.13; Thu, 23 Jan 2025 11:38:00 +0000
Received: from DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c0:b27c:804f:1925]) by DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c0:b27c:804f:1925%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 11:38:00 +0000
From: Gabriel Sanches <gabriel.sanches@prevas.dk>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] gateway: fix calculation of is_vpn6
Thread-Topic: [PATCH] gateway: fix calculation of is_vpn6
Thread-Index: AQHbbYrTCUk9amR0HUaegw+gngQgAg==
Date: Thu, 23 Jan 2025 11:38:00 +0000
Message-ID:
 <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR10MB1845:EE_|GV1PR10MB8461:EE_
x-ms-office365-filtering-correlation-id: 1c3c6c22-3175-477c-b18b-08dd3ba263c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?fgnnLQqEMy9Md1sAvyBsmSsmlMyjGWLh2LXX860cadj+P09od/1QqCac?=
 =?Windows-1252?Q?KOerYeWVt1UJkv3RmRyH5y3pwtDfGpkdoCzpbqc0rOvSkl+Vn2ENKymd?=
 =?Windows-1252?Q?yK2buMPVB1fsZr/UeVhubtGGuYlwxsXC0i4vBz5C57jiLGKCOvGsaOtN?=
 =?Windows-1252?Q?AZ/s3KXND9xRTT+Atq4c1lG89cg8T3rwYA0dmX5Dp+lI+2GNbDohpXpo?=
 =?Windows-1252?Q?5sQjYp4+zGsTp7ECTESkQRGrRGk+lm/HcxRBQ7fIUGOYRRGV5bk6TPrg?=
 =?Windows-1252?Q?MlNNiTGTUcFpJyy4kRJDnVPYKPCt3meIdFdHOE2fgS5C/+673IsDmg3m?=
 =?Windows-1252?Q?dTdJkmV8iHl4Uu4kqdmkYR0+hGGbRxFGRw13mxDTC9FjXqd8prqYt0YO?=
 =?Windows-1252?Q?iLj42zI08Z6A1MMYXufUzchtCktDEzY6NN1qzp8Q1xzKQpnIZzsCWDa2?=
 =?Windows-1252?Q?9mkPQS00rDuaBdzaKARVdGO3O6oNpF5rgLBEhIWtx0nvcnJUm/RsGttM?=
 =?Windows-1252?Q?hFtQjR9376nGE38iuc16t6no91WdFtQh/qtJ+00ylIjxto8lO2pC5dUz?=
 =?Windows-1252?Q?FacMI+WXuA4d6/JFteJgX0eT389nFei0nNuXEtxXcUEWfsaGFrh6hey8?=
 =?Windows-1252?Q?O6LQ0iWidAH1DXIwPyHOXDHegTEAhhZi1NhJKhPzoX6APPiHP/7T0cwE?=
 =?Windows-1252?Q?MjpnjP5fIrl90LbHyc6KWba08nOV/gYVrCb9rcIfcIe2gBtybRb4PZvD?=
 =?Windows-1252?Q?Ur6tLp8FA92uydm3Xs8iuplVx/iDjgxcnNdChdZ76DmrL3NPIMoe9MNj?=
 =?Windows-1252?Q?t5DEJq9/e1r+lWQ6wlJAjIr+dgXlMSD8h183JGpDMOIXSbNKndKv3qBQ?=
 =?Windows-1252?Q?LzXIBTPDlw9oJZXwq/HC0kDu/YzXIx0f0qkdp9eG1rtP4NtZ5+S03V0v?=
 =?Windows-1252?Q?YHuKZSAW7eXX7TOpPhiPA5lY9qneL9wHuP38OK/Xqd4fUHzIyJr3vMwq?=
 =?Windows-1252?Q?r43eT9ZoTpCucCKIxAoyw91ULYzbH1MozGY3QEmoJgbhTB9ZQ98YzsWw?=
 =?Windows-1252?Q?v94U7ViJe5R/AWQIZ0GbC5/uwqG1GNh1pLMZ57gRZY+VL0mzgkhilg9p?=
 =?Windows-1252?Q?1GYsWbBNS7hiAtGdTp4gqhKvW6X9M9JcxQaNzBoCnfdAuCN2+awIm5SP?=
 =?Windows-1252?Q?K83TJnuKfEynmzsXSl/M20KDftdurHGXSsHANRbEOW7Le+eynlx2ob2g?=
 =?Windows-1252?Q?BUQu5Q8/pxqhBd1Q5cFq+5AceT/n+ILfNZJwXPKHvoZckn8u8ByEYJ5O?=
 =?Windows-1252?Q?tZ7+QuxAs3g6mmL+yv8ipJ6kgPf2fq8yJGskUkws3iWhnA2e+x46m/zD?=
 =?Windows-1252?Q?fitQhYr1/v9h7QdtDpzaRLXuzjsIIyZTofMc179yTE1ZVfHVgonfm0ax?=
 =?Windows-1252?Q?v/Tk7yRbf/mNXuoCxVMPYV9oU301uUEIsK5S4dMYUBYzG8yv79Q59Zx+?=
 =?Windows-1252?Q?GPCQ4VgVaPI37mn28D6X+JHC0USDQCAIHEt+6A7vdDHkk50Vv6WMHZ7r?=
 =?Windows-1252?Q?9bgktlbyExBghjNF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?gX4juSaRJypCwy1dktnBW4xZfQBT0d9flGDkoOgz0MrO8wCJkYkBbaDr?=
 =?Windows-1252?Q?BNAytZO+vourspa2L8VjM5/98oBf1oWQxyg4F97vJ8l84cf8hEgvHM4Q?=
 =?Windows-1252?Q?L/KRzBBRtJSMNnLaHEkh8Z9YiUuA1thLLdZQpVoCfMnzG0sTj3A2qw1b?=
 =?Windows-1252?Q?GiEFmxvPoGnn8BatZ7PelCDy6w9zSmMKgGMfeqI6LRxukraQD7GzmOmW?=
 =?Windows-1252?Q?48WAKTFLO5+N2tz65CulsA3Pqh4+XR0kyPEnVz70rQEEo017SprMCfJa?=
 =?Windows-1252?Q?bNn9JUP2agyH7/N7jNEOW3b9yVfWK7oJazQVqIA+VAughW35hnKf10Mp?=
 =?Windows-1252?Q?J/u+lQJmGgzDDSOGIV5qiLD1HnfxAjHYYjVIERDN1H0R8wBR/k6AP8X/?=
 =?Windows-1252?Q?Sra9T2E3L7TqXHHtJC4gOlIq56F2R+3AG5BxYR6GQEBPF/WikwWxcT/X?=
 =?Windows-1252?Q?O06z8MHhzOYH5jZ0lWO9Q5ba2VpHazr9DhMg4qtgUhD7tBISsa3s2nVj?=
 =?Windows-1252?Q?vmxhc+DQpPuWZIGL/goV5xnL26Pj0kXpPhVNyYRWYnOSO7Vot0kHOA9+?=
 =?Windows-1252?Q?V5/VVfLehBcSnQarDPMuC4FmqfzNevC4SL/RmjvsISHxd9/x2MzGA7Dx?=
 =?Windows-1252?Q?sTfuKKx3iiMoM0rUv3ifurMNIlsjFggZGBVAUMIEJjz+TL34/gB7zBml?=
 =?Windows-1252?Q?dfau2wLR1JLHauqtrgk3/JdHGSGdh2lAAqPKuqRsQ9NS07HIeNcE6tbO?=
 =?Windows-1252?Q?OwiUN/9l1OXOsXnPYrCnYKF7yF5IqacEIplwtzzVpaGGaMsQKxALigJV?=
 =?Windows-1252?Q?tOq6YeHAEOKSGvMzceJVZhQtaqBBnbSCgYIqOCu+yv6oB6d794uEmMgb?=
 =?Windows-1252?Q?TxlCITW5ZOc/NLW+taulVP9gjkgk/uZ/cxf7S9B2jYrbtGCr9urCnIVK?=
 =?Windows-1252?Q?GZkPUnXON1MIaP/OIq3YEk4LORO1oFlSBFb0mCjrlz+ebdCRsveAfQoC?=
 =?Windows-1252?Q?fz2jSdLj57NNWO1gmJ0C08EmxEA+DBVDOMJzX1r3ajOBHUiQ5fYFr5zL?=
 =?Windows-1252?Q?2iIsiS6LQqD+iaZeo8SRrtt9I58l8LIbz2JwTFnfUPaqxv6nbZZMR1jK?=
 =?Windows-1252?Q?0L3K4EKcAXsHReiKjHjRr5GKqJdFgVAYHg3L5mr291ZRlxGy1eqP2HoK?=
 =?Windows-1252?Q?+L8R9VF3htvGVlgZ6xTL6KDiUa7VrSJozwRMHWA3DWCQWIHAxK1jWYjV?=
 =?Windows-1252?Q?3avmLc9OIqQMCOya1dFwNYFvSnkCqeTpsKecPu/xqB/X3toMonaj3mRx?=
 =?Windows-1252?Q?kaaV5LYVk18hEjB1Y223T3B6I2X5jbtYb2E+2ys8cHZXLI/Qhv2ef4wh?=
 =?Windows-1252?Q?rvPqLzHqURes23lm+TMGyFAaxglBJJlkuWU7b0TwMfpvycMhLYiZH/ZT?=
 =?Windows-1252?Q?ra7N9/3tjZN+6ctXxfhPQiGE5VltpatHh1pkZgXrs6bnQFpK1T/zdrvh?=
 =?Windows-1252?Q?4Y9ffogIyjsSjZQtty5K/mDH6S4xVVz3USqwBXE0TJwyJO2khNg61wyw?=
 =?Windows-1252?Q?22TIlznpOsSU1dSNCVMXKjD1pZGDsBND44PvIP0eZQ8YX9YRG1reNa+s?=
 =?Windows-1252?Q?y5r9SmnHX8Ye2O1E5eJWE6GatAmIQemL6WJXxOHB9BT634WcFKoN3RLR?=
 =?Windows-1252?Q?w4AOxl33HSuhb4rfAiKZw/414Vk1PuzYRStW4UUd7gH5pLd8nwSTxC3P?=
 =?Windows-1252?Q?KHcp1VXvY9rrJe6eGXdPzbptNY9LCfgwjaj1fgLz?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3c6c22-3175-477c-b18b-08dd3ba263c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 11:38:00.1104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ySId+xTn6dr0vMp2zOarXQP/X3oYW0xkDsKAoeJ58c0GaxzCZ8wty3voDiGDEB5kfw1GWLRE7dP+P6T5HkkxLOEHxLb7rmDcmkRsH6EuXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8461

Fix is_vpn6 to use ipv6 variables not ipv4 variables. This stops=0A=
the WireGuard plugin from faulting on startup.=0A=
=0A=
Fixes: commit 823d5a2a8cc4 ("connection: Refactor =91__connman_connection_g=
ateway_add=92=94)=94=0A=
=0A=
Signed-of-by: Gabriel Sanches <gabriel.sanches@prevas.dk>=0A=
Tested-by: Christian Hewitt <christianshewitt@gmail.com>=0A=
=0A=
---=0A=
 src/gateway.c | 6 +++---=0A=
 1 file changed, 3 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/src/gateway.c b/src/gateway.c=0A=
index 16c87f83..b2c211e2 100644=0A=
--- a/src/gateway.c=0A=
+++ b/src/gateway.c=0A=
@@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service *s=
ervice,=0A=
                                         is_gateway_config_vpn(=0A=
                                                 new_gateway->ipv4_config);=
=0A=
 =0A=
-               is_vpn6 =3D do_ipv4 &&=0A=
-                                       new_gateway->ipv4_config &&=0A=
+               is_vpn6 =3D do_ipv6 &&=0A=
+                                       new_gateway->ipv6_config &&=0A=
                                         is_gateway_config_vpn(=0A=
-                                               new_gateway->ipv4_config);=
=0A=
+                                               new_gateway->ipv6_config);=
=0A=
 =0A=
         } else {=0A=
                 if (do_ipv4 && new_gateway->ipv4_config)=0A=
-- =0A=
2.43.0=
