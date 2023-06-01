Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BEC21063
	for <connman@lists.linux.dev>; Thu,  1 Jun 2023 14:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUxUBPYMOpw34kKskHxXQNgoGAqeYiZRgsBpVVDGNrXH22uBPERgzR0si8HV/uelJw5/QO1H2pMBDJCeLXadZ43DwZg9af6+qLjcUB7lzyAVwcIIQ00DC/2idvOg8zjqSEYjuyzQGMmMiKt8MG9OeEmrNbE5jrnDsZ0bnrbkTQUQRMJnNGX63fMOW47mQM/KUhDGiRZ9D406hH+TMzamKRrvgjKT46muIcgPG2ZPK2YvDe4HYotV1UfTZqn6FgvwC+WT5e78C3jgvdyCX9WxN5VTtpStgSRBC4Sv3HpPVlhqPAMDxc8rn/fhCxFqnGkgl3NJdmgxl6hiZ4ApEjd7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCrSfTgKJhXlFkuTS83KM3PC+77OJZE6OkQD+1BUmZc=;
 b=ITLy558OV0qgIW0EvChffvmw5CQFPIgqKWdcLnBxbK9jFXaCTGu7YIOm5Q7JbKXHdFxXH45mwVf5GA6mUasTgwPtwl3ehh0/Qyiee0hrnJzEZvRTPmxB53dFbZM/k6c1TgzImsrmSZXNC9CxLyIyfObvbF0HLam4BkoEcSjEoaCraNdjLd2A9C3rAVQLUQ1OPp1hm2c0BZ8WDsOiF01MO8B9xINMeyt0T/hjoTwnn+Md17AUZl36gP9gFKHbIHBgfu5RVZkNvxxyWsvcWSv/L4hfdgmaWQLlhJ6g2cONaojcGqjjwkZcuMn2Lt4aoJM4DXHrgMEyV3sEtrC5a8z3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=monom.org smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCrSfTgKJhXlFkuTS83KM3PC+77OJZE6OkQD+1BUmZc=;
 b=5cBpnF8XGzueHRKGsU1me7WraaBc6ZjY0kfG4ruIlpQr7QdGXF4hgbyt9bXCckl9U9i5iruH15QoLZSspMqTE64QIaAUNAwqdnfyn2tbKrQbSbUUAAVQFMF1T+ga0mf0qF4CKnmcZRaXRipyUue5AB9d16Ate7HxdZj0Qv2Om8mha02DRd2eZvGLHGtmVyteshl/kLfoNKyTCBwaBUJcdpqaSvb57waLSWTNny6bgKwgUyDksSmjuT5UZMsAwBLJA39qxPytX5SG431/SdFswPAZY6NRaYqwzEYD8iAvDvo4kOWzvwdEa0X39Qx6RJLuM1gt8xrPPOYt6sKaRYq96Q==
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by AS4PR10MB5893.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:515::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 14:11:59 +0000
Received: from DBAEUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3c3:cafe::6c) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Thu, 1 Jun 2023 14:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.201 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.201; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.201) by
 DBAEUR03FT035.mail.protection.outlook.com (100.127.142.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 14:11:59 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.23; Thu, 1 Jun
 2023 16:11:57 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 16:11:57 +0200
Received: from FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 16:11:57 +0200
Received: from FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) by
 FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2507.23; Thu, 1 Jun 2023 16:11:57 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 16:11:56 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3%6]) with mapi id
 15.01.2507.023; Thu, 1 Jun 2023 16:11:56 +0200
From: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To: "wagi@monom.org" <wagi@monom.org>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
CC: "Ryll, Jan (GDE-EDS9)" <Jan.Ryll@bshg.com>, "Dembianny, Sven (GDE-EDSO)"
	<Sven.Dembianny@bshg.com>
Subject: [PATCH 0/1] Add support to get or remove known services via
Thread-Topic: [PATCH 0/1] Add support to get or remove known services via
Thread-Index: AQHZlJMGcYKRpbelm0KPnwsFjZc6YA==
Date: Thu, 1 Jun 2023 14:11:56 +0000
Message-ID: <20230601141143.3275285-1-sven.dembianny@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.25.1
x-originating-ip: [10.49.85.185]
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
X-MS-TrafficTypeDiagnostic: DBAEUR03FT035:EE_|AS4PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fc4a16-b0f7-4502-760d-08db62aa2a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pVvWtuhTVy4APyeJUQ/N2XMs/B0CxdPtqvntCA8l4BlZPLA17CtuxznCezTs5AdZrre6I9KuyrZrD/ITf0Vet6EZOtktKK+7N43Sr/mQFZ5ElrWQ6yrZ4btNsSBbu4jRivM9P4iQFom6fIijxG8VYFPd/aKpFG+m69xAbCqRD9xFjn10osezVD2Lzp8RU0bI4DY1qwcCQTiKstOwhkrYY1zxXjwVm/l2Zxmd5UU/EspZku2xLEISB9AatEEmQKQ97STKuZLRUV3hCP4UyTJ4Gl9eQPgrIHgQi6+sUyfFklovNgTNy8GCyj/yo3GkiRIP1B57z4/8YBpHjFUnH6lIbTHkj7tEqW8+xCiQGakV0B88Kn8C+jY37CTlyj/lkMGsBu2/0XOc4cPfJjwE5Ae7fV3cS/wrg4PE8PPAQCn3f5CWI51/gXD5rvpVlXJyxu3qBYUd/2bLmYrx33TaMVxFhF556SythuzUrQkDe52tkfcms7zT7U3U+0/b3JeV3X3HUuCT4hhbz1eWNXIIigO3GiFeROEPzVkGlMbhxcY7Vmf8ntDSpom+DDwON4vUJ8iSVlGEynX5lamhCRoe1DUhb30dIvo4AsFldSOTKc0tb6SRBBIXz1KJIOk1DywqWf1EV9a746Kelcmf6Epjr6gphhtnblCnFctgvNjz23fFqoCiWiBc+WmL7ULjMV1gQGHgszpeXb+IvPIVfn81H3IwUZG17UPBym1Wy71LkyOFgp7+VUVXsuqeqEexpfiPPxmSP8an7+ygxP52uihjUchAjg==
X-Forefront-Antispam-Report:
	CIP:139.15.153.201;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(47076005)(107886003)(2616005)(26005)(1076003)(40480700001)(36756003)(336012)(36860700001)(7696005)(426003)(186003)(40460700003)(41300700001)(4326008)(82960400001)(81166007)(356005)(70206006)(70586007)(82740400003)(316002)(82310400005)(86362001)(4744005)(2906002)(5660300002)(8936002)(8676002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:11:59.2081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fc4a16-b0f7-4502-760d-08db62aa2a19
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.201];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DBAEUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5893

Hi Daniel,

picked up a patch from Jan Ryll that was already provided to connman
mailing list 2020-05-27 and tried to insert all your remarks.

Unfortunately I can't find the mailing list entry to keep the old thread
alive.

This patch (without adaptions for your remarks) is now running in productio=
n
for years without issues.

Best regards, Sven

Dembianny, Sven (GED-EDSO) (1):
  Add connman get and remove known services methods

 client/commands.c   | 51 ++++++++++++++++++++++++++++++++
 doc/manager-api.txt |  9 ++++++
 src/connman.h       |  2 ++
 src/manager.c       | 56 +++++++++++++++++++++++++++++++++++
 src/service.c       | 70 ++++++++++++++++++++++++++++++++++++++++++++
 tools/manager-api.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 259 insertions(+)

--=20
2.25.1
