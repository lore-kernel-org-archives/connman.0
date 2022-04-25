Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF52562
	for <connman@lists.linux.dev>; Mon, 25 Apr 2022 15:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtXEQM9ut62m1LTb4B1Kbhbs5ZjEfDBUcgsNbztvPPQbNq7Gs3mYIWY+B32A57q6Xq4WTyTAv0ImaDw84bZ32dDXhjB1HC46ESU0NNpi1pi5CaLxhpFV0I2KJaUTjtV6wYjcP1tFZZyep6fu5G5a/NDFIQirecf7ADmSU0xRWZDjyaBbrYw753AFIusJsNIdfcLNGXUJaOUkZ1tJWexQJFNqvYmvXpl1RB+vEc8ct/flMc4iJvkT4ww1MGOuFsi6Rtu7E8THtWJQoC6zaQOEOlStti1qSf0XKXH4qS16qd27EO42tmEbxiO32PmA0xFqWAZxV5vfqakcOLMLhq4lEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb1eNhrR4sSms2fFBVeBDVxTMNMkaJGvZvzV44Wxy+4=;
 b=CGxuvC353WRULuxjc4NaGbtTDSPiMeExcjqgjdW+BD/1dmDlHZfDoJlWedNwvyiPDdEuYkRxRCtRLJgUNMyeHSnPyH8pcXh7v3leVxg74Q6cuNB3GdboBJWTkWK3QK7JZZcPyTBeMTAodrVMBzcxSZCwBUaNmxO/0TD3EukpfNiQ6AAEIjIPd29Mq48/0aFej66oz2kdcwZyg3kvNliGHoOZV6tctYDvjnHsVf0GxD5wBmJgM95Z293qOvkkXiey4RSRR37BWo0po/SoZQA7Ak8cNtVMV/Gdn/pu/FVO4xyDIe0sgtSHEiat6zWPSHch2BBydwxvC7ay5yUAHwRzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb1eNhrR4sSms2fFBVeBDVxTMNMkaJGvZvzV44Wxy+4=;
 b=XKPfIvABgpuRFpEIaGlJSruDH5GnKXwPWWJTzR+uwQa5/6tJPwb2khfz+5Ap/Ug6vKtr0My5ZyN7aYk+bHCSB+DAXtGdpv0pqFqKU+MPKup0/72u9CAP/j1ogXn1TgxAbHAYOUELrtZgj2l3vFPExNkiczmo+xjornOlE3SeNOFQLtfY+dyMaIo4TgCmbWqTz5EmA71LuqmYb5eZoWKxAEbIwsb0+qCqAPEXLpt5CxSzaObdIQdiH3/7rOyve6h1i07TrP/TUXmyiSkUy0AqKjnr03UM9dDq44DRknURunleNzdRhE51PCRcZWJbYZNLnB0lgCItHqCDW5dmBzv/Cw==
Received: from FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::16)
 by AM6PR10MB2933.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 15:08:52 +0000
Received: from VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:1c:cafe::6d) by FR3P281CA0030.outlook.office365.com
 (2603:10a6:d10:1c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Mon, 25 Apr 2022 15:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 VE1EUR03FT007.mail.protection.outlook.com (10.152.18.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 15:08:51 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 25 Apr
 2022 17:08:48 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Mon, 25 Apr 2022 17:08:48 +0200
Received: from FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) by
 FE-HUB2000.de.bosch.com (10.4.103.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:08:48 +0200
Received: from FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) by
 FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:08:47 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Mon, 25 Apr 2022 17:08:47 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3%6]) with mapi id
 15.01.2375.024; Mon, 25 Apr 2022 17:08:47 +0200
From: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: "ariel.dalessandro@collabora.com" <ariel.dalessandro@collabora.com>,
	"Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Subject: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Thread-Topic: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Thread-Index: AQHYWLZd2qtADdGnG02gfFrLFNvjNg==
Date: Mon, 25 Apr 2022 15:08:47 +0000
Message-ID: <20220425150837.89194-2-sven.dembianny@bshg.com>
References: <20220425150837.89194-1-sven.dembianny@bshg.com>
In-Reply-To: <20220425150837.89194-1-sven.dembianny@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.25.1
x-originating-ip: [10.49.85.189]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 228265a0-bd93-45ab-a8ad-08da26cd822c
X-MS-TrafficTypeDiagnostic: AM6PR10MB2933:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR10MB293304EE80526B2D77074C3DF4F89@AM6PR10MB2933.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PS6JvAUZ+/gxjiIjtg4YHPA8dvdWY14gQZzDih2OCNCoTvAKOsPxk3YACiINwjCu+bO8N+EYHPvwU2JpqSVBJPShWIvzx2nHqzi4y815DxIP3EEye8VcuyZSeceU8R05/NJJZ/j7mYVltWYnhIIJc5ked7spCWP3fIct9/3+PcM/4D0AgwjvYEYfaPa8bFVQCcO9DVndopvRWwHprX+yoXlPBVuZ5cATBM7qoTT83BW5WMtmWdaJ2T6QaERd760ASJJCir82UKjlP0agtinbvUh6jogF/qLSr2RAPpHBAI9drHee7egYNx1ZFmmeZ0c4hnD+i2E3QL/nlVx3RvkBTJksqlnHQEybGJfn5l6pyHmL/rhPPw3iZWJxGE8n/O5lyzVSL2CMAWRWCn5WSFofECNTz1QOcMmPyeMkU+79DgCznZ1ExVRz75vq2TiQ6Y11WGXAqrWtEdmztklTPXtCpO7+LCQp8LPwHfeKHhXLclBHt8X0CqM3TRAjDXftb4lKOCrtq186UV+f/7CR/HIo28Mxx7mNkxdQut7H2V7G9uxFLIKdA76kIbL2jHFsPNi3AVnITCi0A7cXUXg1Csorff2MO5U27Fq+9Nj8a5A3O9Exv/p9963woZDHbU4ZvvqgXxFBKkb0fulSbNSlsw1CSnNfA5v8NmRmyBxATtt35RzbenNRbM5SyuHePaGejZK+TaXhgZJx0s+yeFZEuEX34g==
X-Forefront-Antispam-Report:
	CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(5660300002)(508600001)(86362001)(336012)(40460700003)(2906002)(7696005)(4744005)(26005)(36860700001)(82960400001)(356005)(8936002)(1076003)(47076005)(426003)(82310400005)(107886003)(81166007)(186003)(83380400001)(8676002)(54906003)(316002)(4326008)(36756003)(6916009)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:08:51.9525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228265a0-bd93-45ab-a8ad-08da26cd822c
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2933

Previous MFP support was restricted to WPA3, however it is also possible
to set MFP to mandatory on APs with WPA2.

wpa_supplicant config:

* WPA2-Personal: key_mgmt=3D"WPA-PSK-SHA256" ; iee80211w=3D1

Signed-off-by: Sven Dembianny <sven.dembianny@bshg.com>
---
 gsupplicant/supplicant.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 1b92ec44..e9152632 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -4969,6 +4969,10 @@ static void add_network_security(DBusMessageIter *di=
ct, GSupplicantSSID *ssid)
 				ieee80211w =3D G_SUPPLICANT_MFP_REQUIRED;
 			}
 			add_network_ieee80211w(dict, ssid, ieee80211w);
+		} else if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK_256) {
+			key_mgmt =3D "WPA-PSK-SHA256";
+			ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
+			add_network_ieee80211w(dict, ssid, ieee80211w);
 		} else {
 			key_mgmt =3D "WPA-PSK";
 		}
--=20
2.25.1
