Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C3F2562
	for <connman@lists.linux.dev>; Mon, 25 Apr 2022 15:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km9gMlD6vaCC1y6ZJRQ0cO5DdkO00y2JhW2lnxFXL7tl91nbNynQIabUvbatS5WFrrw249EexQtW31ac9QG0F8zbwRyKhL5T008SpO2lgYZ4nFcn9FaFE1wrJRuttYCm6i4eBIMoiDx1/7duxBcBZuBRK20DzfA19LhW/30ZRGtu9tQAgqLIWSTeZpdH7xMd4uRpg7H+dqODG202Z0fjBwHq+alBrD8ShtU0vqepBnfj5YZTPO3msS6ERLiDXYd/IOS1p0CADXfBEcEhGaP/mRNYQaegTk5qs0nCd+1gLuDMdY9YxWv04oVdascW5Tzh2fZTpllpnHi3LeaffSe3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzZNaRFdyx/RscCxTIUYhl08euFO757r+noMq1HbZQ0=;
 b=gka+n7mQDlQYU2bL9Qbs3LlEVWdpeSpoYaBivSrE34Uiux9L4T5qhq+YPd1Q2OoA5hcJ+0fF1cSUXTiIZeGXQoT9pJ7DIEGbqu2Xv5aktd9NlEq16CSQipzKshRGNrk4+3VWqun+383H0/IkZZp0HmtLRsRAN/gDEOue0rD8K3Ubl2k//CMzBGrSaz0blpnsG0fSswNpJWh7ZMHw6pfx5bEPKCCge+Uo7suUHzfyHbLjNyAtkt84XSJfWOxIhCAt56dbBLoof/xTYigZz9fQs69K1lkVvDLOm/zo4FjAk1IovWg4JHRy4rGV7WUaSVGUHZIBhRSDmJH/aXMMLNFSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzZNaRFdyx/RscCxTIUYhl08euFO757r+noMq1HbZQ0=;
 b=OFif0IsDeK8RTsHXMcfn/vFeIHws4jueSAHMWP7KcPloBIW/hs9BZNRXWsMYoIbXEUuAmWbERW8MmNKzxL3KPEVF70d324VoIkHAebPEOAPTR6vXosr0EvbhSFzNg3atO59NxXy/UdDmBjjZI+92LYmTlpncDqmoONudl3lyA7xU9jryU44Yk9KNUi3qnvEuAaeLvC/MtMluW7kksx8knmRzluCXIge6NoQ67HPlK8RUH+B1KCRYtLHJconF0q9+scw18hC7sLll41ErrHrB52b5UwAqNprotNS1JPvCWzGlcfrv47SiGyToZSxri8Tx7tF054noaGHeBas2vOx5nQ==
Received: from DB8PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:10:110::25)
 by VI1PR10MB3294.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 15:08:46 +0000
Received: from DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::b0) by DB8PR04CA0015.outlook.office365.com
 (2603:10a6:10:110::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Mon, 25 Apr 2022 15:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.201 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.201; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.201) by
 DB5EUR03FT063.mail.protection.outlook.com (10.152.20.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 15:08:46 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 25 Apr
 2022 17:08:44 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Mon, 25 Apr 2022 17:08:44 +0200
Received: from FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:08:44 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:08:44 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Mon, 25 Apr 2022 17:08:44 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3%6]) with mapi id
 15.01.2375.024; Mon, 25 Apr 2022 17:08:44 +0200
From: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: "ariel.dalessandro@collabora.com" <ariel.dalessandro@collabora.com>,
	"Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Subject: [PATCH 0/1] Add WPA2-MFP Support
Thread-Topic: [PATCH 0/1] Add WPA2-MFP Support
Thread-Index: AQHYWLZasYePu5h/zEi8JHHjhwHuAQ==
Date: Mon, 25 Apr 2022 15:08:43 +0000
Message-ID: <20220425150837.89194-1-sven.dembianny@bshg.com>
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
X-MS-Office365-Filtering-Correlation-Id: c26b4554-30b6-4fe0-07ab-08da26cd7ea5
X-MS-TrafficTypeDiagnostic: VI1PR10MB3294:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR10MB32943B3310E6B525FBA73587F4F89@VI1PR10MB3294.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UCY8V/um4wDIzIqSGy96zZNSBV82XaKlG36iRtzB8b9QsH81Ts0EPWtd/BDwY5uLLGO5wdLn8W/oEJsaK89Mpe/mfMgQm+qoeUrjKQVDdmkiDbVjw3TNZIgAlSe7e+6MCwRj5xG5WIa0EwnDRVj6N/gjq/fiEHFnuj1SUlPV6bhr+U/DALn0dmYoVtKaIwjLqmbNEXtYvfVfwE3ENFcv3PSQK0uiydjvf3zgnlAsRHZvQtIPmgLq2b5HF8rCXy/HNaGA1FYHPOdxcm9sBzG7rC0THXi28E8+Xl0VaAr3dod8M+CD7cfzG510fOHYmORUOH7K3eZuASRst/df6WQHvHcqsed26yc9cVnospKf+trcB+E6q8uNMVGfJzb2GoSVoTJ/ihFAGSDMqsWfzfounH9w81Tdx6O9c+0+T0At0W6Fwsud0Lz8xQFly6Du04fm6h/3nFOhHlq9revX5SaAEP4SQ9oGR4HwML9j3rH6B8sgkR0pcT4W8VUlvonNqoWnfzKkONfB/tFXt3RVzXME4hkyOP6GKF9foG32FvL+KrtVJsTjt4CDr5zHxr50VQLxSb9/f8oe29KD0gK0gx9CafZpb42patWZB6h3GabN136ZVTWMqhfo7tbgqUa23N2/pT7byG3d5MQBjXtQe6VMbkyzOWWqgnlkxhv1d4JOh62LGUAEGnzCHxlkRU+MzKyLTUkBw1N+hKXs9dFgMdLOlw==
X-Forefront-Antispam-Report:
	CIP:139.15.153.201;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(2906002)(7696005)(426003)(5660300002)(558084003)(107886003)(186003)(8936002)(36860700001)(1076003)(2616005)(36756003)(26005)(82310400005)(47076005)(508600001)(4326008)(316002)(54906003)(6916009)(70206006)(40460700003)(356005)(8676002)(86362001)(70586007)(81166007)(82960400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:08:46.0148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26b4554-30b6-4fe0-07ab-08da26cd7ea5
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.201];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3294

Hi,

this expands MFP handling added by Ariel to support WPA2 & MFP required. It
was tested on Linksys WRT1200AC with OpenWrt 21.02.2

Best regards, Sven

Sven Dembianny (1):
  gsupplicant: Add MFP support for WPA2

 gsupplicant/supplicant.c | 4 ++++
 1 file changed, 4 insertions(+)

--=20
2.25.1
