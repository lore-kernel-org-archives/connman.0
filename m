Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2045.outbound.protection.outlook.com [40.107.241.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE54C6D
	for <connman@lists.linux.dev>; Thu, 15 May 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315515; cv=fail; b=GeosFHLaLMl264jF97dsQdu7Jzk3g3JhQ56qQG48lfo0hr2MO8+/ZgmhyxcF/sbw7nDajhskSecUMQXJ1I1lzEH4k9iPYTVr75zUsqfK+6mETpJVE86aZeMF3Eqy2nVzZysDRcmj3q+STGrkRJs633GoRasPSjt90IPxOHB9tM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315515; c=relaxed/simple;
	bh=FEKINjQ/B3R8uvWXZPhTjrA8nNrcY7e9rzhYxPKE9YQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9U0oVG2mVL67q2aTWEnYZJSglXubN8/5ZADAQrYr06dpzdVF85Q+Iw/NbxiSjMpL9wb+CIbIf6NOUlg3KmdzecUox+//QtXhGXDoVNRTm00TObhUD8S4HcELWhvgjphEc0RomUV56NKFluaEqf2B+sL/DqvfbcTkz+GoZZgJ1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com; spf=pass smtp.mailfrom=bshg.com; dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b=1WtXK5i2; arc=fail smtp.client-ip=40.107.241.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bshg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bshg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bshg.com header.i=@bshg.com header.b="1WtXK5i2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWokslUVa+dqjiaNTLNF4CbsFudvQJjRfspza1wP+xHEX9sY8Ew4x/Z3PpdEoT4NvV3DPp3xTTOqyfg20Z4+OS9gxU8DMXRcCQeZgNOZMQKPjEo57emn6ft6uKTK8jsQ6Pc7/05S8lTyVWFIrExtl4miS8S/bOsQ3BZuX03Zk9In5pu9GIPwnXVacae9M3W625j6zRYslhHosFkSsHJcSO0b7srq4mM9m0FI4r1+VrrKsv5cWxga7ugJFPIwSy37BKhMgoSf+F5/u3zV4pOmpmvJk4z+VTU4XE1rbzDf8mJKI/SMYcyYwTXGOyDDfvTGm+d3seB66z0gohnq8SrB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yqsxgt5KKISXdFI+AVw7PJK4JATYzMemXeGOoRal+0I=;
 b=egFmuNK0yywmH6fLMd8gcgTZ/2pG/74weKDOAFz4eH8dhgjtItQE8M7N+kg3+IOCPZ/tZIKwYz46W5B2N/DGTKsgp3AW63yROO1VmECnR45peam1t3l6zRs/bqwJRJVQjuNi00SagHwF8nNhX2ac7Ii8q6eDmk+3xcFTxATtj4SHDpvCs/Tng4cjxr+vgRAfGXc4GA+q1cKwGtACIyXjgPwfoZ7XNsXQ66uzSPnd/AHTzmv1mOuKdpJF38kVm2XDm7KI7+5QvQNl7VnQgboavr2B00v4teVmqiEIyTFjI3tjj2aN/fSd3AdtDvxVgVCDJOKrmrH4oMeXKyzAxiQCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqsxgt5KKISXdFI+AVw7PJK4JATYzMemXeGOoRal+0I=;
 b=1WtXK5i2lhtXLXNlHznJkafYB/WOCOERiDm1saAku2L9nuiDnwxaNxE5dQy77YTD4IaQrhihMeY7tUALTQChUh5Jap+kQSrFZPsHueIt7XKSjpfCP95Y+Ipto0MFIeQnt4cIbnCBhha+feXPIQ5/hDnMFTE8lFvg1PwWuH8JxmaaHJLBopTO+sKubyaMkSrpoPqXNLpwCI7iiQJJemvE/s/XdmywzzCdh0+3SsgUkuPfIg8PMPpkvyNSo72DmNBBBstuiSRXcQfDLUDTeZyOr7/oX62zeq5S4Gk5Acx4Pm4NqTzLS5Krx188FPpD1+dlWHyUdmjQqOl0AJfep3Vq0w==
Received: from AM4PR0302CA0033.eurprd03.prod.outlook.com (2603:10a6:205:2::46)
 by VI0PR10MB8384.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 13:25:09 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:205:2:cafe::db) by AM4PR0302CA0033.outlook.office365.com
 (2603:10a6:205:2::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Thu,
 15 May 2025 13:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 13:25:09 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 May
 2025 15:25:07 +0200
Received: from localhost (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.43; Thu, 15 May
 2025 15:25:07 +0200
From: "Dembianny, Sven (GDE-EDSD7)" <sven.dembianny@bshg.com>
To: <connman@lists.linux.dev>
CC: <sven.dembianny@bshg.com>
Subject: [PATCH] gsupplicant: Set MFP optional and key_mgmt for PSK
Date: Thu, 15 May 2025 15:24:47 +0200
Message-ID: <20250515132447.1681494-1-sven.dembianny@bshg.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|VI0PR10MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: c86594fc-2a7b-418e-eace-08dd93b3ea15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CetYW8IgS1WCDPuaTVwbG+tV+iMwf8DoCXWI02WFxrtULJVNMkpNt3dm1JK?=
 =?us-ascii?Q?Sid7zB2cjoRuAiiRwicg7vSz0T/68XWCIMLUFQh7xVkONdS/n6/ARRLLSLPi?=
 =?us-ascii?Q?mMYpVKjBY0hOErxHvacjxLT2P5ZG9XS5ub3F7LdbyeAqEOjZVYBrNXZfnDgj?=
 =?us-ascii?Q?nc1TuOiUTD6B3eR9tdM2uINXMPxGWu5BoaxmJ0tMLsPXxlFo7aBJUQ4+q6Ed?=
 =?us-ascii?Q?R0RkjUenmNM/Se5lugzlTknyDjNj9Jf6N0xE6tvSNy/UAa806zJ7ZM5q9rUm?=
 =?us-ascii?Q?r6JU/Zg4qwsSjKy76wsm8lvIInxU5LbKdtG/hXYJIwpfWBvTkqo1C4gEjf/8?=
 =?us-ascii?Q?34+yyrrMZBlePsJ2bYhE84d6fTQwxbiqN7tv5m8KLnzxM+Vi1HukzmjwXi56?=
 =?us-ascii?Q?pa2mOoSjLjleAVJYnAXR7Iv1DIorGr978gicA//NUg0Gh+XAZj8WI8/x4bx9?=
 =?us-ascii?Q?gZA2nkEvT5xHtiyfONRNste5t27QQhjofpSkfjoBhnnK7qht+S4kDx/PaQh8?=
 =?us-ascii?Q?tJAxgHF1ojgb7iWZx4t48ALRUU/N3eR/bh6Gr27Cl+yat3KEqHDqCRG/XzOt?=
 =?us-ascii?Q?Ca2QmRFrhQvG1fY8VzFWTrhhXMyjIVyerTPDWUPyroU1zEzFlFHFcQ3PRfLM?=
 =?us-ascii?Q?cvbHoe+lrDDzUM6MJeU879Z91vj93CNBb6tKqhdn+oY8fdV23VMz3gyaWVF/?=
 =?us-ascii?Q?cR9yomYgGWJ4qxS668NHgBF47RakEGmmRjB7A5VwAt4pyuvAZVlf9fNBcsNQ?=
 =?us-ascii?Q?4EEoTDVKTKES0VjIVN0yxeIn2k7sKTl9RGAer5lgBCDs2G0NSyvLDi1Cwwo+?=
 =?us-ascii?Q?X916Dzi0BybQxzLald0zD7QXVIeP21uW9rASDbJt2MG7ddcvruy0tONYTlMP?=
 =?us-ascii?Q?YvJWptwNCVTdmI03ToJEpr/YgRC/bgfUdkQLAmYLz7eTSQzsHPaJRKCuwGVh?=
 =?us-ascii?Q?1w/zr0KfmUsbBK/6sUU4oZt9W2//iED5/HMUkaCR+QJlUTFNMC3LWy5Ni8p8?=
 =?us-ascii?Q?ZUtsJKpt82ItmIQohcBn2xW/aqerQ7G1t8FK4uqD0GjggiDBp3cDx7QwddDe?=
 =?us-ascii?Q?WbH3UVQQ8PpIRx5uhE7xC+rnBK+NCCD/8Oz+qgjXO6d/OmYqmdTs/m0q/0Zv?=
 =?us-ascii?Q?tDN2oh48TYiTtR7JtOccOAWyZkZpezpdzMi/HcoiUGbAXkT1WG3dl1wFoWQK?=
 =?us-ascii?Q?aVoTC3F/m/8Q5xrJGApkQFiukZwE09GxgKea04pDRxDHFXAYpHJQXDUFry28?=
 =?us-ascii?Q?LcBe9vTtoYV8jjD5u1lUoG7wU3ftLiY6Xwh8e4KgjoprryFAzjZFZqbVwWhT?=
 =?us-ascii?Q?pdVpDyyuHDgY/sAE9CEv2td9GFiTkxZjaDhqyOI0zgdCDp/R3jvrZrUks2/F?=
 =?us-ascii?Q?FwzN/OhCqtskEMdsiot1p8rg2piwc8//FEc/evnFf30TDtXX+v5FuhVUfW00?=
 =?us-ascii?Q?vkUjzdCAcu82gDFoiyiKLIRBzOlymb4zIBIvXDQAExqf2849zmSRzKWzpurN?=
 =?us-ascii?Q?PpXC6RVixgbrMqNgz2latMOkvuR1NwIdobD6?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 13:25:09.1377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c86594fc-2a7b-418e-eace-08dd93b3ea15
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8384

From: Sven Dembianny <sven.dembianny@bshg.com>

This replaces 23b09a8a and enables MFPC independent of AP setting which
is needed for WFA certification, see "Wi-Fi CERTIFIED Protected
Management Frames Test Plan v1.9.pdf", 3.3.2 "STAUT requirements".

Additionally key_mgmt is set independent of AP because roaming between
APs with different AKM, e.g. WPA2 -> WPA3 is not working, since WPA-PSK
is still set from first connection.

wpa_supplicant does not try to connect at all in that case:
    skip RSN IE - key mgmt mismatch
    reject due to mismatch with WPA/WPA2
---
 gsupplicant/supplicant.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index f3be9e7b..5e289953 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -4955,22 +4955,9 @@ static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
 		add_network_security_ciphers(dict, ssid);
 		break;
 	case G_SUPPLICANT_SECURITY_PSK:
-		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE) {
-			if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK) {
-				/*
-				 * WPA3-Personal transition mode: supports both
-				 * WPA2-Personal (PSK) and WPA3-Personal (SAE)
-				 */
-				key_mgmt = "SAE WPA-PSK";
-				ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
-			} else {
-				key_mgmt = "SAE";
-				ieee80211w = G_SUPPLICANT_MFP_REQUIRED;
-			}
-			add_network_ieee80211w(dict, ssid, ieee80211w);
-		} else {
-			key_mgmt = "WPA-PSK";
-		}
+		key_mgmt = "SAE WPA-PSK WPA-PSK-SHA256";
+		ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
+		add_network_ieee80211w(dict, ssid, ieee80211w);
 		add_network_security_psk(dict, ssid);
 		add_network_security_ciphers(dict, ssid);
 		add_network_security_proto(dict, ssid);
-- 
2.49.0

