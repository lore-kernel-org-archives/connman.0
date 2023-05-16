Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDCE34CC0
	for <connman@lists.linux.dev>; Tue, 16 May 2023 10:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl8/P4WVw+7rSa69maJCPAUzZgyL8wLvmcPBvcEp6OwMigjz8xTF+G/Mzkj0yuGpdQ6xRwx9h01z/gWgAMJw5o3Ifp0tVTZcFfK/hBh+YEgyvILjxxfjQKh70NDK6SCCZKqxOzFufCRoAT+jPdVZ94RTPJhyU3mMl/6mjEeJ3qwHaCOZHANohVHkOLSel8/ZnwWeturDo3tjDw4V0o1CffSv6rMmk1/Jy3G3CxpQf8hVIib9i4QvPoLn1/aEZx0/asUYNQHnb8+hBwlvmPxLe9Hna9QeYwtYxLzk+yWG+iNfJCgGWEeHWaJ1BXV5qugk4rjQhxaRyGDnyqEMj6RuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNigb3e5g7so3HngQQJg4MsStqsSSSXomz4lTppKzG0=;
 b=BllRNofppg9UeCVIGVo2O8f3CNF4Nag/zVwHGenrfuBX5wyX0l4kXGqErXeiqqmNAMqnTxI4SyGAc9p3K3C+Qyd+QsT82UShshoFB4OT8gckBkN7r81VzxJXdT0RdPw6JxQCzN11Eiq2Nzvq08E9HMpuNJiV1AY8S159UneDxXlm88Oo3BvcQIoO5r9NlsIycfQciF+CurtmpHaKp3OJ42b65nj+ICzHaDKlCqGj1iKLQhMNr9/RDFTBq0FufQ63uVBA/dBFrDCDyIzHRhf3jjt1u3fzTfy2firxLt5fU3pad8YkD7zzkOYyitQhFVMXYgYoSB+pGPUoBoc2PPZKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=holtmann.org smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNigb3e5g7so3HngQQJg4MsStqsSSSXomz4lTppKzG0=;
 b=XZ4E97l1ei/jyJKdklIJ4hiWD02rAxMhU/KsBwSergDoiLqdEKrp2p6zQKlxM0TcJrTu8oDhMX2XQfpZ4FIk2GGxoBa+yxA89WEPCFLoDKTRUd5SLaZG9H+0Qd4iCy3UyqJNCVxw7ovvy/R5aZNmnpY09u0IE6IScuXeO6oHwa6P+4r82BUBbOoTZNQsT5p0eLzxcSy0SAYu8HNAVYC8sZ0jGzav76bgVg9acmcPhMmoYQgGSwcfpeQ7LMg0a+wJX3HgRZbhk2+59Bm3cXOskAd5ZSSukTryXLylqNUzJ9+gRO7QEzeC2DJLZwS+X3DLtLXxN4TYeadOjRYIhf770w==
Received: from DU2PR04CA0252.eurprd04.prod.outlook.com (2603:10a6:10:28e::17)
 by AS4PR10MB5223.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:40:34 +0000
Received: from DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::d) by DU2PR04CA0252.outlook.office365.com
 (2603:10a6:10:28e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 10:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.200) by
 DBAEUR03FT021.mail.protection.outlook.com (100.127.142.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:40:34 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.23; Tue, 16 May
 2023 12:40:31 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 12:40:31 +0200
Received: from FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) by
 FE-HUB2000.de.bosch.com (10.4.103.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 12:40:30 +0200
Received: from FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) by
 FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2507.23; Tue, 16 May 2023 12:40:30 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 12:40:30 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::81ac:4f34:2616:9bad]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::81ac:4f34:2616:9bad%6]) with mapi id
 15.01.2507.023; Tue, 16 May 2023 12:40:30 +0200
From: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Thread-Topic: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Thread-Index: AQHYWLZd2qtADdGnG02gfFrLFNvjNq0CHlAAgAAHcICAASo+YIAARooAgBKmxbCCSLVpgA==
Date: Tue, 16 May 2023 10:40:29 +0000
Message-ID: <20230516104029.GA2062332@rbgwcw0248.bsh.corp.bshg.com>
References: <20220425150837.89194-1-sven.dembianny@bshg.com>
 <20220425150837.89194-2-sven.dembianny@bshg.com>
 <4deec7b0-a2e5-0d91-a81c-dc4bb79c1594@collabora.com>
 <8B96358C-6DA1-41E0-8C79-7724AD78EC53@holtmann.org>
 <6dbc9c41e6f5459291a118bdd0dcfc5f@bshg.com>
 <BC5A9223-D70D-4082-930D-AED73268EF8B@holtmann.org>
 <4b9a0754ab29428fb95b53a65c399925@bshg.com>
In-Reply-To: <4b9a0754ab29428fb95b53a65c399925@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.49.85.190]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F5CC1D5CC870E4183A4A2C87EB59646@BSHG.COM>
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
X-MS-TrafficTypeDiagnostic: DBAEUR03FT021:EE_|AS4PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 59beb4d2-eaea-41fe-7ab3-08db55f9fad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AO4Rk/cn0Lm1knnajzJNlWF4hz+xnlS24elPiFYpeHP79og3hxFTzYbATSgoU/LDBuYeHjXmFacsqjrHJ8okkL5DOCCf4FfFFGgSZycxzRbiUoN2TAC8Mlj+2Rihx58tWo/FbPZATlxrbqj6CvekZsyBsR6nXzcmt+k1xRlNxBGG1sikJ2i/D3cd7upSS+jLmyaUtaPsoHmqcwkZNAPT1asLU7/YTUt83c/SwDbMD1vaz2aAo6Ojw31qNupVna63mFBEBxmx9E2RHeXeqjX7q64U8F9fobhJQlMAndLFFLYHlxGYxNhvIp37vwIJa2UJvqRsgeM6BmOz4gG//2QpzLmoTba1xsbUrX5LV7hcUuQpk7nEry9gEoMCarpfRB2wMOoEDOx8AUjgqZUF6zCnK9CIDN9oMyDWkmwjz7Qi+EcJEIULrXEWVvLjaya0a5K1+JBLvIAzdYLMlw7Snik183qhiaKNyG5vltvdbyo2Q0BbN7XWA4FEGz9FBRMMvtjfcLylcENnEs7EOsrPLPuq2vjcL5RXpAnkV91eRZcDn3ywqzZs9RX00/1QfDn8hmwuYI+OGrfwoC+iHezrsApn7z772dVc/uLBJt8F6uBGrVK/E5SPsdsn4ng71EphW8HJappW3MYLMdNw4ZeWDSd0Aj7GoL9UpnBihw+6Q54ZxrPfZt0SChEzxg4gtS8UlrNzUJ1mM/D/LWl2oInpqaMH/Nl9BiE6Pruvp8hFT7VGypi/AXwRmDm6bPJHAh8C5+a/hkryF7BZt5av9nOdj86g8Q==
X-Forefront-Antispam-Report:
	CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(54906003)(41300700001)(316002)(8936002)(5660300002)(82310400005)(33656002)(82960400001)(82740400003)(356005)(81166007)(70206006)(66899021)(2906002)(478600001)(6916009)(70586007)(4326008)(8676002)(966005)(36860700001)(26005)(1076003)(47076005)(336012)(40460700003)(426003)(186003)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:40:34.4991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59beb4d2-eaea-41fe-7ab3-08db55f9fad0
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5223

> > >>>
> > >>> Shall we also consider the "WPA-PSK" case in the same way?
> > >
> > > As to my understanding, MFP requires SHA256.
> > >
> > >>
> > >> I prefer we remove wpa_supplicant support from ConnMan and you start
> > >> using iwd ;)
> > >>
> > >> And I am only half joking since this part of wpa_supplicant is such =
a mess.
> > >> Whatever key management they introduce next will turn into your next
> > >> problem and compatibility issues. I am running independent SSIDs in
> > >> my home network to deal with end consumer device since they use a
> > >> wpa_supplicant and management software that is too dumb.
> > >>
> > >> With iwd the WiFi protocol is in one daemon and not split between tw=
o
> > >> daemons.
> > >
> > > Unfortunately in our case we are tied to wpa_supplicant because of ch=
ip
> > vendor specifications.
> >=20
> > that is horrible. What is missing in nl80211 that you need wpa_supplica=
nt? I am
> > really curious about that.
>=20
> You can find the patches on wpa_supplicant from chip vendor in cypress-ho=
stap_2_9-1-2022_0321.tar.gz, included in driver package:
>=20
> https://community.infineon.com/gfawx74859/attachments/gfawx74859/WiFiBlue=
toothLinux/2314/4/cypress-fmac-v5.10.9-2022_0331.zip
>=20
> No idea, if Wi-Fi chip will also work with iwd without adaptions.
>=20
> Best regards, Sven
Hi Marcel,

sorry there was connman@lists.linux.dev missing in first mail.

any update here?
Unfortunately we can't solve the vendor dependencies, but I want to get
rid of
manual updates of the patch for every connman release.

Asking chip vendor for iwd support is all I could do at the moment. We
are planning to switch to iwd, but this needs alignment with supplier.

Best regards, Sven=
