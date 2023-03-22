Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2071.outbound.protection.outlook.com [40.107.12.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C86FAA
	for <connman@lists.linux.dev>; Wed, 22 Mar 2023 14:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCfJhYBI46uhZdtJdReyEwf/s84IAPg15g4aXtf68MKp/3qgU+RLSyRgRqVmNMlm1cloWJdFd8uko9fXcl9PP/hByBX/3Tmy8eZI9ADy/WU71gRTWNoY7T4Y6kkYpuhoVRQHHLd4AH0QfvpXQNXxj7mL/7B6O5O2grsBuC9hlw8YhdrwBst8KNVJk5Wv+xvr4aA7bpNyzwykblgEen1H2xje1JfV9mQUPlGqCMB42hdf3DJ3htSFqFeam8Tu2zVjFtdX3JhZvvVMqnVNUx+kUYiIAqFof61DbpRvcgOgXOOf8funzxkh/SsjqSFFx0kIJm+R7K5+0wuVzTpe0R9CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOdE7cYboNgfUUnp9VniPh95JohBtqYIgeOOn7t+AO8=;
 b=kBi5I2fIHlTObIYLKH53Id0zEoQzGPxvzPXUX2smzBdZJcyp40BR3AhEZSJuTnAI2jESEBJWhkXPuoVPsBzhNyBcx63mmOl4L2cHeUfrA2Z5lWnBxSqH4W6vt7RrYCaR/fmdvfUdpQ6UnoXbJFIbm+6Nmm4xSF2qIYaz00V80JfSUxHGtREc1kGxRAfvX+8PntfR6fIQGMRt0/PUJbxynTKesBFFo0mt504BB7smKWG0gOK9xNafLb4nrM3ybsXVsXPHtngC+3PmwqBp2saQ/tXRCW76yWIhlLV9DDML40gAza9RB+v/JP2kbdJUOrw/92kycAinC8+LA+Inu6oFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOdE7cYboNgfUUnp9VniPh95JohBtqYIgeOOn7t+AO8=;
 b=zIPqPCUcrzixTEzcVEq0i+mW37QLHEoCfk5ClZwLcXN3w+fdot2YTTo3EE7Kn11yviCGgBhn3rTNtMPTkCXg9nx/Wrb10KiS37ZBbz7/ZyM9H+eE/yTXMYsQ7ofAg0zmUSyhEopgpwiAW7RbfIfnSck60BSRF55jEJzRL0Knt3Y=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB1792.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 14:14:39 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6d79:b93c:b64:95ed]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6d79:b93c:b64:95ed%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:14:39 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] network: Keep failure state after disconnection
Thread-Topic: [PATCH] network: Keep failure state after disconnection
Thread-Index: AQHZSswmMJ9x9jxugk6QqaKMEp4VZa7jB391gCP0FiI=
Date: Wed, 22 Mar 2023 14:14:39 +0000
Message-ID:
 <MRZP264MB1544820A56F1B893CADDE9AC93869@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB15448014A6E161ADFD0A280793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544A26A7D6EBCEB14A0B59793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To:
 <MRZP264MB1544A26A7D6EBCEB14A0B59793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB1544:EE_|PR1P264MB1792:EE_
x-ms-office365-filtering-correlation-id: 445e2bac-995d-4c68-b4f0-08db2adfc635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9VYvIACDYnieNtXz6fzXYNNGd922R4aSGpBK/FhYc0nao7oGNI5IyD+C6stbnJgWwCFujZY6xWgzHLIYa3SDAkRuDY+CncYOEM4epjJu21VmT+xEZ0amIczW/H3ADIm1PI5M5ave72S0ftf+AywpIb1qbSE0g1/by9cW4djr9Z+rCYNme4acuTJIbiLv3DtQBJYRG3c4a69NMy+u+nooBLjO2/QD5unlEARIODS/MciCF1EC4R79aGXCNcB0b26iVwKhORGDc6G4WrX2FNILCGnrqTE2F7z+GsPQtgMgj0OoM1aF+ntzWVkOMs9QGp8DVCKR9AO9cQDCjhtCGYOH1osiffH8aEXbYq2xZ0evlT0Rg1eEchkrjh7RsU81Uw3p5rdGEW285Ad4vMMHq3IFrlqUTXqkwAn+zXICOgXKIlcR9RNBt58OIFl/D4aAxbjwiCovmJZ7i5IQvOYSwaMtsfpZOqBIeFHsKpTqLHbHSEviGdq9V7yYoTdN5VJWRP8N6+QND9grvWHACkPr304SgV/UHSmThq9LQpHlSytwq4SwUfaOBGKjAIXAcBIzJhdGfyRNcMDuExvkLoXjzojrGwA77NT9pMvfDrA1Bn0sSN04dPGcjyGbSvDUWNM1sY8hHLaHlSxbjRauCASWXvn7gNKBj5pQqtApmCixPTBLTv7Fq1tQaQDQdb/V146ePKRt/OSzbPK2lMC65NHFX3gIpg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(86362001)(33656002)(38070700005)(558084003)(66476007)(41300700001)(66556008)(8676002)(316002)(478600001)(66946007)(5660300002)(76116006)(66446008)(64756008)(6916009)(8936002)(52536014)(91956017)(2906002)(71200400001)(38100700002)(186003)(9686003)(55016003)(26005)(6506007)(122000001)(4270600006)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?L2i+Ku3GfKzYOvx2eSPAaubkHPTOF77lLxzTwNlzG8hBSwJ9cCNcBJ72U0?=
 =?iso-8859-1?Q?br+j6TbPTZykZSM5457l4ZeK6AEhT7mZd0KSpaMHgcngUEkiWNrpwGlxH2?=
 =?iso-8859-1?Q?c+9ayT1hW/LKWjr7tTvqdCZsr/5Nl1/iWocoIvOq7GitCMv6qYExpQhUzx?=
 =?iso-8859-1?Q?0nwr+mf+YVfE1Uh58wIbv0eqzjTiqYh2aJ+PlyH7V1I1dotrfBSvdn7Oje?=
 =?iso-8859-1?Q?fNnfU7oSRD2B2g9KRKiHiPqJBzKwaZJjbab6/tISx/HIX0SNXKkG5oTtBT?=
 =?iso-8859-1?Q?Ay95hQCdtqrFKLSrKLyPOk1lq5bbZgYeXA6jj2YWgNf7wkysgJErLdrbWp?=
 =?iso-8859-1?Q?RqBhCFq7rTrmrlQlNv2HPsB1Tvi0xmyp5W7/51g+CGDvUQqkIcwqYfj89E?=
 =?iso-8859-1?Q?BAPoZwmqB/ugkI+Jgu8y3mTgn9u+Zh6zs11HAoq78gzwBVEDKsPFkZ055A?=
 =?iso-8859-1?Q?zRYnQj06sUfBbfwBX3PHwIDovkGuuX72gSFB0zIjB3nJ8BVvUqABsQG5RC?=
 =?iso-8859-1?Q?xCkFg2IjP+n9jtVYbGMLT4ypGIwv9sd1Nq6D5J18dAXURrH61u0evjZyw3?=
 =?iso-8859-1?Q?u2LXcz/QhpZu5hX66KCTaLD5CDcR8OzFeoYu/NVZ2uYTDpWcbE+uHcAvvj?=
 =?iso-8859-1?Q?TVV+gmRH6c4YPi6S4dsgnfBWZUurOGtAG0tx2XNpnZE1AHsWrFRinVbeJR?=
 =?iso-8859-1?Q?0DJf3skR5RLVeufb3cfaC4e6TNM+dS91FbDJCKrnI7X9AbmAavKVud/w5Y?=
 =?iso-8859-1?Q?xe9R8izqBdZUL4h/VFXRSBbhQ6BIwLZ+APhbTHWTsSDki1t2RPImM/L3vU?=
 =?iso-8859-1?Q?F3pfTWzMCVi/EizSDcHmuddWdrSfCom3W1Cr4DWBHZ8YpFm7EZxNDwsfJN?=
 =?iso-8859-1?Q?ZkTOshLMeie3nutazL45lf+AIbBbJ+XU/EEi/UWKrMSm0Qn7itnbOYh3Gp?=
 =?iso-8859-1?Q?A1rgVj7k6CsmzxJNkXh8BO6UPFzBJY/8ab3StO1pnCmpJQV2VkH711fGKn?=
 =?iso-8859-1?Q?eE2wqSCJC6sQrFRwqiPW+su9c5HjUFYVYEnl7garxs1GrBqzIPPdm8X7H1?=
 =?iso-8859-1?Q?OcxFP3N2rfasytuUg2qdXSbIp8LvdyeDIpDYXYnafMy6nvEoQZ+sx5llOd?=
 =?iso-8859-1?Q?CRjV2ncQ1yUCf1vP59m7NgsoPjtW4F/LaWXfN2BNqYDWRbARWaDEt1vygS?=
 =?iso-8859-1?Q?AdPSMB9E2M0oKyr0vgRgpfjtvP6t4xlqUXnrF0GuXzB9pAmIbVwfo7TqYj?=
 =?iso-8859-1?Q?EjDrkLyFqIwXxTlk/aL2T4srVYFE16EIF3mGtluMZHNQWCE2LeRPygAYhq?=
 =?iso-8859-1?Q?S6CotLsdmtEWYjMIqzcW5m0WW4SWjhZ53BsUnt7Sip4frW1B4nLjog/CsY?=
 =?iso-8859-1?Q?fgLvN/IJ5PLToKnH7jFEAIT0qiu8LVi0wJZTK3fBi+D97t8s39HIaT/LwT?=
 =?iso-8859-1?Q?XEoULL7UtylbaZyCTr77FFCSepagB77DJQJSF7stDu4NwGt1975VehxtC2?=
 =?iso-8859-1?Q?Vgru4i0fqowvic9Z5Rh8V5qOAVN8JKknS6gOt+bXCuTDIgerh3FTa+sliY?=
 =?iso-8859-1?Q?kib7WiNvhDPy/GOwmkdWLdYfxZcEwgKzdi1l2WYcEHOFh7aHIVNhkLQZp/?=
 =?iso-8859-1?Q?TGxDTVmJSU6ZUkl5ez53RHSdPXC90CID+HRF1y3n+NMyMPLxnCMKe5/g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 445e2bac-995d-4c68-b4f0-08db2adfc635
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 14:14:39.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WymG0KsSVsyBGw8EYH36xjOTO+U3dg5sJIXeTYZVNU7F9yj1dKdwDO0eCOAlN8ZAGAgM6ET8pnSiNY9eqh1HlHibBVmpwQ/nWzmAPFj3Zp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1792

Hello everyone.=0A=
=0A=
Has anyone been able to check this patch?=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
