Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7893320A
	for <connman@lists.linux.dev>; Fri, 26 May 2023 06:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvNVqNhCh33AmBTucBz0HFgZzKrb26E2gW85IT5iDLGNuFacW3pMFSkXpGUTVyFIrfDZLSmYdGsu+EMXmpaRKWfIL4CrKY+lu4hjLKsG1gOlvlQCF+WOeYyUfl2fRjlObMFYP/Hi+enDJ3GAl4K5pyEIipYvEzDLxmyaS3WKZX9MTUzqAdvLfO7Z3kn+ulK7OfQZwRwGhewl2FB1b7RzlJ36dJrSIQUXEioaE56vCKqr5rp+Q3TFDYkihi2x+xcxHHtBji3Czkdu557GO1u+hcb6gTbLJUESojWKYNUbPtkPkuvuuBSnwk70fXJXL9guwtjcam5nTP6FMeAUvhkVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvheg7Ksti4K/RI25WdhdlwMn9h6PvPVqb38VDx/ijo=;
 b=f7baR7MPvGLsUwVvhgW3H5BH11iOKZLw0KMkrirEYSTvXx7F5qQKank2GECi76lg0GL5bYB+VHFYHGzEVRZ7Qwlqe/MhUZJikUr5kd1taSg34eGqrmibep6285fQVYMX/1slcy7xlhLYtUyXQ9MomkzAEaMQYKUi3xVXeZU0qnfl19ODW+bm6vLAuBQ37IJRKKeByCi5NvuoM1yJuk/rN0D4bwzce9o8AX2mYq79Fk19Nd8tzYywr5HCfzC36ysORcZ7VjHrVpBYUGrptWTv20F7uN6/PzIGBqCe54XJvTSgZeRFuE9wKkcl0vuDeTgixQntXLq1I1FbnwIDMZcrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=samnazarko.co.uk smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvheg7Ksti4K/RI25WdhdlwMn9h6PvPVqb38VDx/ijo=;
 b=SI/AvQPa3ouToQGniLEyes3ldPvNk/Xrg+P6CaGkKHzlcyeplrcL71PH/3ObdFQIlFL6R3Eo1xL8Vx5GWARw16Up32XV5apSNtd1nJMWWuFV6PN9JJjSfml8AL3IuiZvXfYsp+NfpOAA2fg2Dc97pU8U1RzfSd5rBoSnnwT0k0YdzDGgD3+913YembcWrtjumZaSqSCzr4piIJyHJpsBYpvVqkd9oURy+ZHQEod7J+VTR3xFoLeqiieBihwgXBy44qXUo2ARHM3fQodJlyb55OyUfwOo64pE6uhbxXPlde7z3U3yhhsrsLsufEW6Qm0Pi9lOAU03Vh26ji9TrA/SkA==
Received: from DUZPR01CA0324.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::29) by PAWPR10MB7365.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:2e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 06:21:33 +0000
Received: from DBAEUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4ba:cafe::d0) by DUZPR01CA0324.outlook.office365.com
 (2603:10a6:10:4ba::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18 via Frontend
 Transport; Fri, 26 May 2023 06:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.199 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.199; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.199) by
 DBAEUR03FT062.mail.protection.outlook.com (100.127.142.64) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.18 via Frontend Transport; Fri, 26 May 2023 06:21:33 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.23; Fri, 26 May
 2023 08:21:33 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 08:21:32 +0200
Received: from FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 08:21:32 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2507.23; Fri, 26 May 2023 08:21:32 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 08:21:32 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3%6]) with mapi id
 15.01.2507.023; Fri, 26 May 2023 08:21:32 +0200
From: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To: Sam Nazarko <email@samnazarko.co.uk>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: WPA connectivity issues with 1.41
Thread-Topic: WPA connectivity issues with 1.41
Thread-Index: AQHZh063nQqICy5NcUmOb4OrZ9Xmr69sBHkA
Date: Fri, 26 May 2023 06:21:32 +0000
Message-ID: <20230526062130.GA3841275@rbgwcw0248.bsh.corp.bshg.com>
References: <0a9616adc89f4fa08a0cd9840fecc582@samnazarko.co.uk>
In-Reply-To: <0a9616adc89f4fa08a0cd9840fecc582@samnazarko.co.uk>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.49.85.188]
Content-Type: text/plain; charset="utf-8"
Content-ID: <93738ECA7B654A429001FDA42311C364@BSHG.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT062:EE_|PAWPR10MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: d5119c5e-7388-4fd2-dda2-08db5db173b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z9v/EvUlq9uYOEhPXXFl56mVbuNy2SCTT4dSllfH+1oEgKki4S9bZNBYkdPEN2ayQfFymlT7PPnscVwqz3LsBY60B86ASlL2VIRR+06zVVHe4tB7Pw2xThG5P5WoAjZ5NFrJdht8Y7A+ZJsFzyzQYFvkYbK4aT03JlsRO+gYiSzrOSju+Ol5OpkEcgluB/xCKZL/ogmrt4XL7ejwwzLErgKYcM/GyglH9KGJHlKr9EwrQWgB4snWDx7rUXW0YNwL9klL43SeZAZd4g5ih0/9LRO2N3gpZUZ9GlyRhA4Twfk/kAiYTP55RUNOWExqmoa/cy68emujnLR+9EqduWftCYNSr3hnBF53PJTk7D3ahNAKLnvrUe8mJCrywi5d2uDZzuKqRmcg+LSQjXL2FUpYckAGEz5niqvCnMrjFic9xlyFLWh0g1qJuNSbkXOlFpe4gH+bmDijYtd6cSzFrnjdoK0f4NB1JZKckUO0v+nLn8TYy52qPS3NnRP0t2Qi9NrrFJmLM5h//5QFOwr7k5K56jRcwjSL3PLbk+8V1FCenEzkMI5YKNd1IbOoBTvj8nwMeovPKgDuerIEdx3GNa3wAXPVpb82jm2KXT+qvi/g7j3/dEAIDsnMJR1EcoWZ6ZKbZl2GD8D2QIv1JfoHS2dVbH1R4+jwSpPuUJbTstc/NQIgPxhcTjq2lez5hW247E5wHu2fVdGccBGoo7QqsDiqLAwd5MVP12PLgu7c9Q1zGY8TDg2FGdygO3clWpAwyBcyDBj4xCY3T+sDV0utYOT73w==
X-Forefront-Antispam-Report:
	CIP:139.15.153.199;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(478600001)(36860700001)(33656002)(1076003)(336012)(47076005)(83380400001)(426003)(26005)(82310400005)(186003)(86362001)(82740400003)(82960400001)(356005)(81166007)(40480700001)(70206006)(70586007)(6916009)(4326008)(5660300002)(8936002)(8676002)(316002)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 06:21:33.3856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5119c5e-7388-4fd2-dda2-08db5db173b5
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.199];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DBAEUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7365

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMDU6MDA6NTZQTSArMDAwMCwgU2FtIE5hemFya28gd3Jv
dGU6DQo+IEhpLA0KPiANCj4gQXQgT1NNQyB3ZSByZWNlbnRseSB1cGRhdGVkIHRvIHRoZSBsYXRl
c3Qgc3RhYmxlIHJlbGVhc2Ugb2YgQ29ubk1hbiAxLjQxLg0KPiANCj4gU2luY2UgdGhlbiwgd2Ug
aGF2ZSByZXBvcnRzIHRoYXQgdXNlcnMgd2VyZSB1bmFibGUgdG8gY29ubmVjdCB0byBXaUZpIG5l
dHdvcmtzIHdoZXJlIHRoZXkgaGF2ZSBXUEEyIGFuZCBXUEEzIGFjdGl2ZS4gRGlzYWJsaW5nIFdQ
QTMgZnVuY3Rpb25hbGl0eSBvbiB0aGUgQVAgc2lkZSBhbGxvd3MgdGhlIGRldmljZXMgdG8gY29u
bmVjdCBhZ2Fpbi7CoA0KPiANCj4gVGhlIHByaW1hcnkgZGV2aWNlIGJlaW5nIHVzZWQgaXMgUmFz
cGJlcnJ5IFBpIHdoaWNoIGRvZXNuJ3QgYXBwZWFyIHRvIGltcGxlbWVudCBXUEEzIHN1cHBvcnQg
YXQgdGhpcyB0aW1lLiBJdCdzIHVuY2xlYXIgZm9yIG1lIHdoeSBDb25uTWFuIGlzIHRyeWluZyB0
byBjb25uZWN0IHZpYSBXUEEzLiBXZSBhcmUgdXNpbmcgdGhlIHN0YW5kYXJkIHdwYV9zdXBwbGlj
YW50IGZyb20gRGViaWFuIEJ1bGxzZXllLsKgDQo+IA0KPiBJZiBJIHJldmVydCB0aGUgY29tbWl0
cyB3aGljaCBpbnRyb2R1Y2UgV1BBMyBmdW5jdGlvbmFsaXR5IGluIENvbm5NYW4sIHVzZXJzIGNh
biBhZ2FpbiBjb25uZWN0IHRvIGFuIEFQIHdoaWNoIGhhcyBXUEEyIGFuZCBXUEEzIGVuYWJsZWQu
wqANCj4gSSBhbHNvIHRyaWVkIGJhY2twb3J0aW5nOsKgd2lmaTogSGFuZGxlIGludmFsaWQta2V5
IGNhc2Ugb24gV1BBLVNBRSBhdXRoZW50aWNhdGlvbiBmYWlsdXJlIHRvIHNlZSBpZiB0aGlzIGhl
bHBlZCByZXNvbHZlIHRoZSBpc3N1ZSBidXQgaXQgZGlkIG5vdC4NCj4gDQo+IElzIGl0IGV4cGVj
dGVkIGJlaGF2aW91ciB0aGF0IENvbm5NYW4gc2hvdWxkIGZhaWwgdG8gY29ubmVjdCB0byBhbiBB
UCB3aGljaCBoYXMgV1BBMyBlbmFibGVkIHdoZXJlIHRoZSBkZXZpY2UgZG9lcyBub3Qgc3VwcG9y
dCBXUEEzLCBldmVuIGlmIHRoZSBBUCBhbHNvIGFsbG93cyBXUEEyPw0KPiANCj4gTWFueSB0aGFu
a3MNCj4gDQo+IFNhbSBOYXphcmtvDQo+IA0KPiANCj4gDQo+ICAgICAgDQpIaSBTYW0sDQoNCndo
aWNoIFdpLUZpIGRyaXZlci9maXJtd2FyZSBpcyB1c2VkIGluIHlvdXIgc2V0dXA/IE1heWJlIHdl
IGFyZSBmYWNpbmcgYQ0Kc2ltaWxhciBpc3N1ZS4NCkluZm8gY2FuIGJlIHJldHJpZXZlZCBieToN
Cg0KIyBkbWVzZyB8IGdyZXAgIkZpcm13YXJlOiINCiMgbW9kaW5mbyBicmNtZm1hYyB8IGdyZXAg
Il52ZXJzaW9uOiINCg0KQmVzdCByZWdhcmRzLCBTdmVu
