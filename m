Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B71173
	for <connman@lists.linux.dev>; Thu, 24 Jun 2021 12:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGwS1gUEgtRp/ehbcaHp0jpmtYATnsbbiYl/hHpT82EqsVqNOMIrCNVIkJbT9/yFWgG4krEi//PjoAPHZ7vxp2igPevsftGNJ9Kn6EWHw5bG1mXgif32ZfXrfCIOAsJLZZvS8EwIWR7RZf1G1fjhvqv5D1o/UfTVRW83bfk0vdthyBIel1MHupPLRWNbauPPvaJtKfRB8YYizKX+rEOBorJvpSnf7vLSO+nMG4g5bE35n0AW35rnmMtbeLI7D7VZ3nZXV0epIYyeRzJ8cA9hq8mxRHFjyPRGH1END3MqPdUjhsX7agOIp4zUYPTdDUv+NYGX05Vauj/IklcO4M4dYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PzLr1f+mQDEvodym1ytYtdUaXxvLoQoZ89PAMO3H+w=;
 b=aU9PS/LSgDjUjogJawQ84prT+JwucXL0W1qIHYa+/P/Qi6lSSEW1AeJoE6XyG8Zm+4B5SjQ4wZI/XFIoAZnmdKm0RBA4mEtCNFQBqG5urgpr93YAgsFx7oyEozQ/H8/S+paVFbRz4zNlZ43UlFqM5hAG7Ilu2CsXPawgU8dSkCPzryUIB++jnXzRbv3eNyHkDXem2c0Q5Y066/Lrpuodg1hl+0usuLcZrOzANfw7PA6ZUVLfUEZaEUkIQtt6aJRSaZMjXPrrx4C5pkHyqBYM8yW3hRCAsctSQBxZ4SRyBaeU8V9DAl39rZJjSw0taEqEC0gWgkFai8g4sxwe9b7f6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PzLr1f+mQDEvodym1ytYtdUaXxvLoQoZ89PAMO3H+w=;
 b=kOFxW+88eB7q5WK88gkmRQ5RXc4Yo73Eg2QFORlfdz03idFjJQefH7yzORabTMuVPflt5kjANOwjW4o1vEo6hNbnzbqMZO+9htoSVQip1RW4QkKSrIMnQhAGRGXUXE4/Fk7uEWzYBQVm4S9grvctjqCiLixdQ6tDenbJhAwS9EA=
Received: from AM5PR0201CA0017.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::27) by AM6PR10MB2565.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:a7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 12:56:20 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::df) by AM5PR0201CA0017.outlook.office365.com
 (2603:10a6:203:3d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 12:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=pass action=none
 header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 12:56:20 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.14; Thu, 24 Jun
 2021 14:56:06 +0200
Received: from SI-MBX2014.de.bosch.com (10.3.230.137) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.14; Thu, 24 Jun 2021 14:56:06 +0200
Received: from SI-MBX2015.de.bosch.com (10.3.230.138) by
 SI-MBX2014.de.bosch.com (10.3.230.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.14; Thu, 24 Jun 2021 14:56:06 +0200
Received: from SI-MBX2015.de.bosch.com ([fe80::f028:9fbd:9f44:9bd]) by
 SI-MBX2015.de.bosch.com ([fe80::f028:9fbd:9f44:9bd%5]) with mapi id
 15.01.2176.014; Thu, 24 Jun 2021 14:56:06 +0200
From: "Athimoolam Rajkumar (XC-CI1/ECP1)" <Rajkumar.A2@in.bosch.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: multiple APN contexts activation failure
Thread-Topic: multiple APN contexts activation failure
Thread-Index: Addo+CgUnfaWBia7QTyQ0+MK4aLzGw==
Date: Thu, 24 Jun 2021 12:56:06 +0000
Message-ID: <d718d3f0a1914197944ab05cc43a3b90@in.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.34.187.63]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9706a523-df66-4646-5985-08d9370f76bc
X-MS-TrafficTypeDiagnostic: AM6PR10MB2565:
X-Microsoft-Antispam-PRVS:
	<AM6PR10MB256544C2D13602DF5F9E816F8D079@AM6PR10MB2565.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZuSw5aBCN5BbnYGVyRTGMmTgc+cL5mnqUVVdxQKNLkLjQj+xfkeiAEFWtRyI2A3RJR03NqsDxCMvcUH103Z2je3S/hW7lgO4J2v66UkPaIAvI77WhLrTUWy3Ty3xGeCDLBjX/RyvbR74eUVja0//15StUA0EBOvlpARDm5o51dg8OnSCeRTkNJNVJ/MHldAOdWzHOVXHwUy1Vzq3luv7wKPlwvpsJWb+y8SgOy7KWh06iYedSXlwWOmjV5NV2yEwOmE3ZlXRDJuPANllb7Xpg0MQLK6Q0kMhMsOTHAbf01wkCDUu/s5gwZPt8nH/1y5dkOv1e5iJME7WkBfXVhjSlH79GyxD55yd4EzDMXRBVOM8f2MzR4TJoHCYQ8YdhGgIzc9dqn4Q0KgjcryjGoQdijWe83XoPxFraznxw2WnQ81uU0MHUh7genli6wfQ68ysqD1gPZHSUKwof0+HumUmWihy8FnHQ/dedBLTcIOe+ziUMyNMHX7GosllvN5AEipn0Uum4rQ666YT061BF38TSDB0x4tBDNPtRWtwX9PCgJudWbFHSPzBpq6B499RMWrZ7MVKVAoqqIFaS/OlZnU1P87vanBAkZyw5loq+PhTbYrdFVUBcwTOm/oP4/W27Uw+sumSNe6N9mrWtqs4+ttgAl4hCI/MQsKnf6Aj0miAMM2YaHgvW4yMfz/h1ysjsXIF
X-Forefront-Antispam-Report:
	CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(47076005)(2616005)(2906002)(336012)(82310400003)(108616005)(36860700001)(8676002)(24736004)(86362001)(6916009)(316002)(8936002)(82740400003)(83380400001)(81166007)(26005)(478600001)(5660300002)(70206006)(70586007)(186003)(356005)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:56:20.4640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9706a523-df66-4646-5985-08d9370f76bc
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2565

Hi,

I was trying to activate multiple cellular contexts with Connman ( Due to r=
equirement to connect multiple APNs using the same SIM ).
It was possible directly calling the ofono APIs, but via Connman it was not=
 possible.

The available 3 APN contexts are listed as 3 different cellular context ser=
vices correctly, but when I try to connect to second cellular service, the =
previous connected cellular service is disconnected.
On looking at the logs and code, looks like it was due to calling of __conn=
man_device_disconnect(network->device) function inside __connman_network_co=
nnect in network.c

I am wondering why the different networks/APN contexts of the same modem de=
vice has to be disconnected instead of moving to "ready state" before initi=
ating the connection to the new network/APN context.
Is it then not possible at all to have multiple APN contexts activated via =
Connman?


Regards,
Raj=20

