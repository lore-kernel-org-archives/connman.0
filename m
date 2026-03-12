Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021107.outbound.protection.outlook.com [52.101.100.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2D2DAFDA
	for <connman@lists.linux.dev>; Thu, 12 Mar 2026 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328516; cv=fail; b=KI3hb7ENLqehOHvod0f1Wio4Et7OzFSjYIT0GCz9Yp9g2m7kvZEC/IY4NmkvDQe2hAIuUofy78c4dtmGPfFKvvvNVr/ApcpISywI6V0b42mYgzhxMjSKDBrSE45OX+OmEvQkErcd/pOih4BN7j3Sqk7MWGD7rvUUKwggMsiD9Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328516; c=relaxed/simple;
	bh=KOoh5DB6xTj8OCTU5bEOZ93641InG1iEG1le0in6FkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QSU5+kkZnf1awXcfChBWJt6404/vrCkU1HReLMGBND/WTVog2r9aSJ7iTJonBYfXmnFwCzql7E/vXbHizAmeNVDvondHVnpZ3NN17OLqe2fJ8pzCbdECvPLB9D10/bk9g2gkQGTUQWPXiq2hI6KrkJcVcsqCAItinJX0FeArlFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tewke.com; spf=pass smtp.mailfrom=tewke.com; dkim=pass (1024-bit key) header.d=tewke.com header.i=@tewke.com header.b=VSLRwMdj; arc=fail smtp.client-ip=52.101.100.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tewke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tewke.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tewke.com header.i=@tewke.com header.b="VSLRwMdj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfNhhjQgXrr5ImgiB0hM8vsmsCiASmkegKnLLpjb9GFXromisXFqiP/DrgGAj7jRz/YFX4WVsE4swobBGdNGAAqzVnrIAii+rQ6SfHbd6nLSLPw9Ocx9/jmwp6gC7xGLwLu56BeSrjuGI6LVIaXOV4VMvljLElEVFyHIGM9B+hqjZbtdxn/R/skKvBtj3jdWHPZn2fo+Y5W+Bi3VE6/JOqUPWmx+u2pIPa8ZMFwsZMurja+pkEx0VIleBtjilshRnRhsl1vx4NiMDxRCe0cPkxfXa0cBsR6TDzUjh81XVy8DkZRLzmBHBQECMJdAF9PWNkgwuG1C7lWHDo75hsoNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlO9O9ljLe2IJZ4fZ3i+cd9ODZWZUjS1h/wcbkk2Zq4=;
 b=fIHfpYI/XjYQxJEyMJkECtLWl7u9a6hXOFQNOyvMJnwFsAHLbQzmr9Pr3bbZq3E+WaAdTN5bce7N/ushPXgKUYikO2Kt5sFz4oBqo4Gc6wLI8iKMz3hlFC7z41AiTByipkCW6nYDuw6mWcT58xian9BFLvwD+FnGhAvJqAuqoQFZTSlO+hRB4c5XPMIqrfHWWpYpTbaIBEV7eh9ahMikxnfJAVjHtH78dhXupdtgeRpzoCXM+qywq0L3jivT/5hjhoOmo543yDQCoO/8fivWqZusN7hvasNtSl5jbDsza5b3neZI7AfKS6/HiZMMBZKD3Mjahp9VW6SALBQxWEtHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tewke.com; dmarc=pass action=none header.from=tewke.com;
 dkim=pass header.d=tewke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tewke.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlO9O9ljLe2IJZ4fZ3i+cd9ODZWZUjS1h/wcbkk2Zq4=;
 b=VSLRwMdjBse7DU08rrh8CUrmlLW3zckH7nRpjkN9CFjSlRZJ3LBU5czfT84zi90sdkCveK7A+19bHOBgT4fFvYVlJv2iBApzv7EC0HlUVZ1T/HXMUnjgURWc8rDVij5U8sKpuVvuxkDv9UqT0+gTc5i9wbXsl9kKVhUE1xNyZxE=
Received: from LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:333::7)
 by CWXP123MB3591.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 15:15:11 +0000
Received: from LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM
 ([fe80::9638:76cf:42ee:60a4]) by LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM
 ([fe80::9638:76cf:42ee:60a4%3]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 15:15:02 +0000
From: Ed Rose | Tewke <ed@tewke.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Ed Rose | Tewke <ed@tewke.com>
Subject: [PATCH 2/2] dhcp: Ignore empty DHCP Option 252
Thread-Topic: [PATCH 2/2] dhcp: Ignore empty DHCP Option 252
Thread-Index: AQHcsjL/2n6CXvHmEkWUuhT+C3unKw==
Date: Thu, 12 Mar 2026 15:15:02 +0000
Message-ID: <20260312151445.720413-6-ed@tewke.com>
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
x-ms-office365-filtering-correlation-id: 712db701-4c0d-4046-b313-08de804a227c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 rdwR9VmNKGK3ca4NXniOnzALgkSnzZhTZoaXWlADnNXQnVPgiqL7ES4LIe4KyI6fDD+lpWEMZECYXLO8JQ0KzFcDnx8vic6dmgbsmQqxU/0719uIv3zAeZDRl3u6aUCCdqstnI6Vx5bkm1OBxOZqXX4wkyMv6EtYLp7d3ao/zyMApNpqaEPoes9vyBCYOG59/oIhFdWnaKK2rMy5wUL6Dzqa5j1vFNLhIJFiXOMBElfAFY5tODLkaF/Gdx3G9OxpYk/jXiMvPw2TaH5C1MRRsQ5ovoYeIPHMEMKbFFwixiX33y+/KrWjVtKL1d7cC01osVvSknQ/KijlFuHEQiPiUl321fuU9tC8RwaKz0uUTGGgVaQeuFCWSnGuHH7yOA8euZF63KLtckuqH1sRUPbOvsZBfMQLJfnP+cU+3R/Qu1tT8l0V6gyL8Fr9xSWjRSTe64gZJVaypvDdFzLgrhLAoWLjUnfRUACEQGLzCk9bqhr4kNOu/sVE8VAr6FDkqdydwO2HnkKW2GUpjhcNtceFsSTEjeKwLOY+WRY6h9BGB6bcNObgZiL8tBVmQLK+CVDSvjGFVWEhXzo9IOZyqI6kOK9uqvol04fDaIwaXB8uS/pdVUFaEOxBR/QWorWqwRxjUV3hIpJqt+pqOEERNAn2ebJKpU5fGxLhUEn2uvwrBbhQgJaVTdQWbn4h0SziQ6NTtIklqEgZ1iZmWx/bTM6cJX+5AoIk/+PTGqgIwlKA5VS29CL6kDntfvGYNUYstsueWmB8wSZYYn0ytf5kFgBGVSrXk5QvW+sqbGIf0blLHHQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P123MB7137.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sXONlnBIi2+S4BNT4He2y/KwNet5t+0Q+DIb2piVBQWbKCoqavLI7wQqQ0?=
 =?iso-8859-1?Q?aoswqsUDWbcamwpvZE+9dFRHAYT++R39sXqr1uZbZ7GgHucsRu2U9YZbm3?=
 =?iso-8859-1?Q?jjYXu3TvgR405+Z05FkwI6qFiUWX5Y9SsKppUyNYFCFaU+jW6tiVi/SAM8?=
 =?iso-8859-1?Q?Jn4OTbONLcWJBBCEUbjnF2Tde7MkCT/HwMSJCyIfVP6fdNBK6X+pPLEzEy?=
 =?iso-8859-1?Q?iAq0mHxeCBFnwT/OUSYjqPVa2zArACJ0xJ9LTeAd527ADy4T41HNq6E1BY?=
 =?iso-8859-1?Q?KHAGNM2ZTmrZpBybm+mkJwJ+vizOYRKl3Eamatl/ogdXmgxGYB4vxST/6L?=
 =?iso-8859-1?Q?WxeShx/MmSo1vPjRkZ6n1dGvvSMWH59/SY1p0Rr/Cl5DBxYqEfFfJAalwj?=
 =?iso-8859-1?Q?BCkrUJjHcOImmNm4S7TqAZAic/4TOphMtugALhr//nMHHeFG3nyjnfNito?=
 =?iso-8859-1?Q?jqe4JEKBy/RGtGgRMC2zR6zOLl+fqpkyAnK0HCc4aInCFm6Kw3r+2P19jj?=
 =?iso-8859-1?Q?mN+61Ll1AB3gVhOItyzge8RokP6OOKTAV86/nzeY4T1NpBON7+3Be5QEzw?=
 =?iso-8859-1?Q?7y9hJ/in9p/XH+lRwzDhNp2ZH4TKS3TWCRpAXY2IxOypZUoDBGwQKQ/frc?=
 =?iso-8859-1?Q?6xzwppocWSmNjz5QKXaWFruvouZB0d0Cib5R3aEif7dHXF4dLm92SlGXQG?=
 =?iso-8859-1?Q?qwEE8kgSra856H4LUhij9FJ9MNlIrvOsWIopZ01wy59eFKK7OYVZzUO7GI?=
 =?iso-8859-1?Q?Wi0TbeJYvVqON5js8o92v3N8n+74LXEz3eGUUoyIz2I7NUASVk5edmcGnU?=
 =?iso-8859-1?Q?WLD7Wgdog2YKIB9P/gSOoViFuX/+R8MDIEQBhHENy2nnB6eddvdm3E3eWp?=
 =?iso-8859-1?Q?G7f4Jc/zA3eMXqB9KsnAp85332Tk9ePoDIzUqA66o9I9gh0MY1zZbnP9aQ?=
 =?iso-8859-1?Q?zeJuFD6dMbpaXl9E0PJHmc3gQ1fDVqsir9OwLr1yQIFXEa0zBCKNvGMdzB?=
 =?iso-8859-1?Q?RxlVeBBBgafQipKMC1xYYrHlX42VoTVJKbm0A6fTG9YETjxzSFeOOje4PY?=
 =?iso-8859-1?Q?S73oObvaHxtOJE7qo7peH51Z3ds3uY1PasY+uw5ynRL53LZ/tWvWqfDpKZ?=
 =?iso-8859-1?Q?VPNTp0CZLuUJj8x0cbuFWqDfIsRj99qAVDJ5H7ImSCeH2Pkti2C78L9Z6N?=
 =?iso-8859-1?Q?FNJk6IH7t7s+HDCoilFdpF5uKHt9+Uc5fbE1Ig6ftxRJxPGl8Edynd3psb?=
 =?iso-8859-1?Q?4Jt396+5CliwA0SkZPm+9OIBF9s8h9EpSoM58TPKwGP5p/oureIb5zp0uN?=
 =?iso-8859-1?Q?rYUTO5RmYilL0l9PDieVTtwpw/Grz9vcPKlOngsSLTloKoINimHybWtI3z?=
 =?iso-8859-1?Q?zYGEfOv6JqwdyZQ2AObAOfmBCBDIiqSLmFVPAwB+WqnZ6tOk597DA+RNfJ?=
 =?iso-8859-1?Q?M//V6yZ7DCU9YoYfw6jsrNPlGEOAKWYKpO3wqSYV6Vy8PY+PLyJUTXkKaV?=
 =?iso-8859-1?Q?yQ0TxAblpJ7cvrr3DSr40RHHOfb2ScPrmPhc1HDiwCQN39SuyObKdyfgEM?=
 =?iso-8859-1?Q?nP02cXwkCALXJmKlw7Q8dpFhK77h2HW8azzh/5Uk83tEE36/77a09e22yl?=
 =?iso-8859-1?Q?XBv77EX/dHYda+HP2+8hofJGj/jQDK0T+suxgxXIen8g8U9iJE1IJdtcnj?=
 =?iso-8859-1?Q?54B/snev391XVBHDS76R/1u4l0/dD7BCSS4DFGUr8pfwe3hgwFTSEenKY5?=
 =?iso-8859-1?Q?fNp86jPOSzJbrALKswfx5ogiw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 712db701-4c0d-4046-b313-08de804a227c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 15:15:02.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6ded34c4-07b4-4d4d-97eb-db680cc7886a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UzxjlYQIyYgxpOTqiRUrzrlCGr0Y6VRm7U5UXhW8CbEsn/AxvAiHIwUiKjt6orS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3591

Some routers, notably Asus, intentionally send a DHCP option 252=0A=
(proxy autoconfiguration) with a payload of '\n'. This seems to be to=0A=
workaround an overly chatty windows service and improve performance.=0A=
=0A=
Connman would check the length of the string and then strip it before=0A=
using the value. This changes the order so the string is stripped first,=0A=
then the length is checked to allow us to ignore values that contain=0A=
only whitespace.=0A=
---=0A=
 src/dhcp.c | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/src/dhcp.c b/src/dhcp.c=0A=
index c84f1de4..163a347f 100644=0A=
--- a/src/dhcp.c=0A=
+++ b/src/dhcp.c=0A=
@@ -352,7 +352,7 @@ static bool apply_lease_available_on_network(GDHCPClien=
t *dhcp_client,=0A=
=0A=
 	option =3D g_dhcp_client_get_option(dhcp_client, 252);=0A=
 	if (option)=0A=
-		pac =3D g_strdup(option->data);=0A=
+		pac =3D g_strstrip(g_strdup(option->data));=0A=
=0A=
 	option =3D g_dhcp_client_get_option(dhcp_client, G_DHCP_DNS_SERVER);=0A=
 	ns_entries =3D g_list_length(option);=0A=
@@ -418,11 +418,14 @@ static bool apply_lease_available_on_network(GDHCPCli=
ent *dhcp_client,=0A=
 		g_strfreev(timeservers);=0A=
 	}=0A=
=0A=
-	if (g_strcmp0(pac, dhcp->pac) !=3D 0) {=0A=
+	if (pac && strlen(pac) && g_strcmp0(pac, dhcp->pac) !=3D 0) {=0A=
 		g_free(dhcp->pac);=0A=
 		dhcp->pac =3D pac;=0A=
=0A=
 		__connman_service_set_proxy_autoconfig(service, dhcp->pac);=0A=
+	} else if (pac) {=0A=
+		g_free(pac);=0A=
+		pac =3D NULL;=0A=
 	}=0A=
=0A=
 	if (connman_setting_get_bool("Enable6to4"))=0A=
--=0A=
2.43.0=0A=
=0A=
