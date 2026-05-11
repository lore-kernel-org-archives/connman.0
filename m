Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526D3B9DA7
	for <connman@lists.linux.dev>; Mon, 11 May 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488225; cv=fail; b=tdfdsZJfgx1jYXREtQyeuDPrPtw/GHr0AWS+aPudjiCaL712YSK6PfbyNEE+RqmD9pXJ6ZPeu0tB7UG7JhbPeTALL8ZjsbdDCxjy/QYOpCl1RhSwXADiIOuXCj7HLnyDKAxKm3D9oU9TyXnsoGJutFZHJAo/hqEyzepZp6Fcc7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488225; c=relaxed/simple;
	bh=ZjKXmGXS6+uul0aWuXSDFKhmF3gXyyEKIGZSM7WgMXo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FPNh3XsVmM+UlH0Cx1j5okFwCiI2afYDB0NZVxAb1AMpSG/pAM8LWqpvdFUBsd6or/tfPGuvSL4ub/j5tlr/tnEZBztjiIwAiBwZWgtVGm8wMlQEptxaX8YH72UH2qNSLmH8UcNccuNRRMdonTT+1Fv1O7StDlP4ve2CqZLk3no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.51 with ESMTP; 11 May 2026 17:30:04 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo1.lge.com) (165.244.147.11)
	by 156.147.1.127 with ESMTP; 11 May 2026 17:30:04 +0900
X-Original-SENDERIP: 165.244.147.11
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO SEVP216CU002.outbound.protection.outlook.com) (40.93.138.52)
	by 165.244.147.11 with ESMTP; 11 May 2026 17:30:04 +0900
X-Original-SENDERIP: 40.93.138.52
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwQ4vy/JCGfXJZ8GBReEVx+7eIvi0eWxzfnw4MuBh4rRRAUn1dOmOnB0bQ/pq8jO+qCcTbQF9UNrOO/8vEcRS/LYXtFW8KFVNJKRpwasAh06HuTcZDpphGKyUCWhVTmOLxvVDB5RU3G6bh62aPl3uBA/L4Gwc5v5ZsjMfzNSXLv++E8wMbsBdJ9tNEiNz5FnN1WGnLEJ5AJXkdqg6W5foGt4tY17ELcq4U9knOl1Og5U8hMBZEzKXJmg4LpNd5HXwT5L0WyCR1XWJwXGJRNzwavr2YsIokUHBC1O47JkCy4T/WF6VrSrnWwDJCrw9VSVs/XpI2e4o0BRHSx5Pzvx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV9fGBL+Rj+QehRGdvzgrfiS3b3VlWUJ5ZslEiTIhsY=;
 b=tUa3aLZplXSBuClyELl9bGr66bk05Uw9RPz25uqFb7QWsoLQQBBI6m93LQg4sv6q6s5eLkCXPM37yLjM07OWNg7sxOMW3W3y+eKezMheOkcZaW55KbgdDcchH/tr5oU1juO5V86FO+Adec2zrD56s2WsOddL7QQ8olDyZYhzwWeM4sbjuOS4iYJNWW4+3VezlqF78itQcg1T/fB7IsiVFDF2GFKT/xIxrIsB7TQP91aJMs57OBn5HJFeieAirrfiYEYBRXWhtqRfW3jfTdrjWfBCrXXFVZxgprvglewSP65COi7XBig3o9Xe+LqgrEQZZUNsZFlydAqpUuJ+v87yZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by PUVP216MB3228.KORP216.PROD.OUTLOOK.COM (2603:1096:301:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:30:03 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::e5bd:8928:464c:62c2]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::e5bd:8928:464c:62c2%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:30:03 +0000
From: Shailesh Rathod/LGSI Secure & Connected Task <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] gsupplicant: Fix SIGSEGV in p2p_stop_find on NULL interface
Thread-Topic: [PATCH] gsupplicant: Fix SIGSEGV in p2p_stop_find on NULL
 interface
Thread-Index: AQHc4R/4qkf+Agp8lUCotCaWWTzzlQ==
Date: Mon, 11 May 2026 08:30:03 +0000
Message-ID:
 <SE1P216MB26472F81214100EA481E66BCF0382@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|PUVP216MB3228:EE_
x-ms-office365-filtering-correlation-id: 472d2ae5-62e1-446e-e5c8-08deaf377fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 oe0Pk0BBUMwAEfp2UaSP1GYlYBHdy0D3FifyVW3JUvAZ7D8nHFZB1OoYiXeZ5Fkzn47eDEaG4drXuWDVHHodK+/PC8DJnzuWx42aqXyJsA0zoYLe7+b9UI0mFUnGn4bs3K3fL5kNU6RVdvQePgQNwYXCCl7xcjnBSHXfVG7dRdtXa0bUarK5amRaIm1kJ+J+SeqoKezxdHMUL1S2JFlsKISPJfC20pD0toh4vP82gT5QURC0KenuWaTKECkWHtBPPRcWTfeGyFfXz/37ay0/7QvSFvFUPD+OpjUjdtAeekXuk9+wBUsY0+QZrT6Rti+UAO0asDgVCFAW2MaWqDlltaiRrqXnKfSPi2Y74f5UmG/URmoU1Blz5uw7Z9I5f2Y5n6cTk7vBjqlDTITtRW3917ju3mvQLyfwo3LdH6Mum4/smZU2gbsDn701zQ55sUpgVF1SICLklBqJ0XC5zTrHGmrC+KouSO+ON5Ho04VlmsxhlZVMEOFaBuDTCnqknBlSbPYX2TgGosxEhZBb81qOTejTxQcuUxgPZE+EgFwLdAZO4uBJ27EqyHWYeVOqPXavpoiLUGMAyeBNEey8arOlw06+TXrWrcDEC/LsIAlpCwWZ+PlVuy5JHRvWUmmNxl23OIxVBp8kKgzfS1ZttlZKjZIuDOYl3Nq5OwQVPZpK9GYuvTi228BfTL3d3dauR9aNa0AEe9v1GFSSQ4ztsYyGw7EZ784mPvFOj8nIJdlE9i3QlTbtXebtLgeQ0NvK7rvK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LV98guQ+J+MRaVrUGolL2E07WQMpBXI503HytlgDMG8UN0mwXSuh7Tay4D?=
 =?iso-8859-1?Q?5eaGlwXxiB682wNu1PMuOfPlxL5b52dTUzG6yxZRK8UdDBQBxUhlpG3PDL?=
 =?iso-8859-1?Q?+UwP+o4J/+TC1Khb9tgEHEU+nUqX4lZ/KTf+o40EeCQJtzNPa4zsAxGpki?=
 =?iso-8859-1?Q?CG173x7DJS07rsN9Jdvae9TxSPrJZeru0pSDngi1zUix2MLJpQCiGqdz9O?=
 =?iso-8859-1?Q?HkVF1neSh1jhlEW6f6dUA72T5UgXkbEGTCpvoCe5Wscsp69AXcB/dGYDhl?=
 =?iso-8859-1?Q?U0cjg9KIDG7DjwBu8mi7FXlGKHzZjgAo3zM4td/UkNJBj7eUsaSf9x2kbS?=
 =?iso-8859-1?Q?UIGcTi9z7mglwqdfV/55S+Za8bFzpNNmnI+tPP975MZfsbWMFHr+Fp98Xg?=
 =?iso-8859-1?Q?43g0mJEmPDM6VhxQoHpR8sZeZa6hBUvYt6u8saTAU1fiXKFKAouQV06mKM?=
 =?iso-8859-1?Q?8LlBJ2USsl5hW70noGDNwL/lfYb5uzQ9CnE/4+xXc4+aUklYFUA+YvW+bO?=
 =?iso-8859-1?Q?+ONgN05mZ9bduZdpcbxEgpHJdHP7c48AUJHKqRgNy5UOtgoMPYk3PXO4Ab?=
 =?iso-8859-1?Q?uBSkELtPoOF8gdJReJQGVX1LbwqgOzjx82lVdTKl/0XpHS0IFW46s1AOWe?=
 =?iso-8859-1?Q?0V+ZF1gT7Q9Xra/AVmxuLowO0wwvtSnNOd889IkqgOhvZqtottuDS8c9uv?=
 =?iso-8859-1?Q?3yqd3aNKpvzXEW8EPRHNrxePs30cHF9p1/PDAnq5itgHB1d/lKnHyYisUO?=
 =?iso-8859-1?Q?opd7XpwHgMDTFtRC18lf3/F/HqI2/kfc563WldnkBe0B3+4qhHf7/jdVwe?=
 =?iso-8859-1?Q?+C0V10qK/pjNMteoxCuRDzj7LDJP1vlamftLtJYqxlUKKpfHCBoLwR/6IH?=
 =?iso-8859-1?Q?kCOlssyAi6By2b+QTUsTR5qfelIAQ/Hi4JFeIrqNWl9f5We7tHZkcZVVXI?=
 =?iso-8859-1?Q?4p0qNDB4v2eNX9POu7HXN0GfRjcIYs0tghRtGZphuRy28UoiWeQTSNpNw5?=
 =?iso-8859-1?Q?wRxLOB3451iqWwyvUfrpjZxwL/xbXX+CN2MlsR7FkFrHvrzXDD0pugpXdf?=
 =?iso-8859-1?Q?V6jG4/iOQ+KvT4SBgWgJ1WtJjVeAo1XdURyVwfdmgiFhWMGr0VxpXK/wLo?=
 =?iso-8859-1?Q?oB2izil8nZSbLL+wJFGfRvBQ5TtrNCHR0cphXaLIJW+jvAoWN5v/KB/ykJ?=
 =?iso-8859-1?Q?hq5AlnsZvsILsEb04IUvg+5FnIyXPfAPs19z+PbyxUDl5P4meSUDKfxlPM?=
 =?iso-8859-1?Q?aQLmoTq3gtj98gamZtehrEizv/2GV22EQztMjMnt5GwBnlC4y8GKwNTsYL?=
 =?iso-8859-1?Q?Cm7PAGo835ufHJheAuw+SpUnAflUdJy/Ucs5pSDh0HROd3t+/18stRvmmY?=
 =?iso-8859-1?Q?G1KmvwanlW+iy273gablIrJuiF1VpvYz9GzSzjQzDjqPqRJvalDmflAKIo?=
 =?iso-8859-1?Q?i31KT4H44x1udAt63Jmy9Wn/9n4D0Zk2Yt74HDgcy/G+5Np145ZCEz91bD?=
 =?iso-8859-1?Q?rTjSYPjaG400fGTwPigHCBtL3sdKm8b/Ont2DktbZJEfMksbSAuW4BkaoA?=
 =?iso-8859-1?Q?pGtHlWlBRiDd0T1gK64ELbRadEhG9XMFrlc5jlC/vnWmLNhV+6lqBcsuXe?=
 =?iso-8859-1?Q?1JebiSW+E+uU29/x3ewZYZk4PTgjINRl2S0UtKro36YvQ9I873f+FIZJCs?=
 =?iso-8859-1?Q?zCYm7onjYOgdQToWU7pB9t9IWvcDXNlzBLB24W+rM6itox+YHvyQyL+o9f?=
 =?iso-8859-1?Q?8dwlVx6Pl9BOmljAOsEhzcF0j8IXpUdDFtrtNTUzNvTLZMLwxFYLkVzBKa?=
 =?iso-8859-1?Q?pm55nE9GnA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	k4R9uPm2CCI7W0EvURKWKR9nwCYB7jlw4MouenUt77mGu0IrfQd4ot+Is/yfBEz+GCae/yZb3us3qSK2la9cJdy7U3LAwjkHlycuKxgnZ1lu1cTeI5qo2P3mHxMT54W/lJd6uliZRH7k9k2Bxkj5crHCnGfw1k431pFziZze5cIlmxZSvAChr+QAMOLfcI7g5FbxjSFrP8hjaiwz2JaWY1vQ6o4n5HPAL4SLLFDF86mbCW+zm7/m0kz3VS1MylQ8DaHoI4Q3Tsh/gYlEC2WPowPDCBvL3na2Fa/DbTOC+lgcTZZYtzBbdoH9qW6SSZHsYLqAq2noOJvwZg23irGFsQ==
X-OriginatorOrg: lge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d2ae5-62e1-446e-e5c8-08deaf377fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:30:03.4049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5P2jIcE3LGhktCRauyHolp+Y4MU+TI7f//uUqZKujJMKchyn/84rMA0twPsIMdd5DrTkMi94ddBZSnPEBE9RYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB3228

From: shailesh <shailesh.rathod@lge.com>=0A=
Date: Mon, 11 May 2026 08:01:32 +0000=0A=
Subject: [PATCH] gsupplicant: Fix SIGSEGV in p2p_stop_find on NULL interfac=
e=0A=
=0A=
Add a NULL check for the interface pointer in=0A=
g_supplicant_interface_p2p_stop_find() to prevent a crash when=0A=
called from trigger_auto_scan() in wifi.c where the interface=0A=
may not be initialized.=0A=
=0A=
Signed-off-by: shailesh <shailesh.rathod@lge.com>=0A=
---=0A=
=A0gsupplicant/supplicant.c | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c=0A=
index 5e289953..a50d61db 100644=0A=
--- a/gsupplicant/supplicant.c=0A=
+++ b/gsupplicant/supplicant.c=0A=
@@ -5442,7 +5442,7 @@ bool g_supplicant_interface_is_p2p_finding(GSupplican=
tInterface *interface)=0A=
=A0=0A=
=A0int g_supplicant_interface_p2p_stop_find(GSupplicantInterface *interface=
)=0A=
=A0{=0A=
-	if (!interface->p2p_finding)=0A=
+	if (!interface || !interface->p2p_finding)=0A=
=A0 =A0return 0;=0A=
=A0=0A=
=A0	SUPPLICANT_DBG("");=0A=
--=0A=
2.34.1=
