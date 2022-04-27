Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8015621
	for <connman@lists.linux.dev>; Wed, 27 Apr 2022 07:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIpb7HaI1vw7PMRB2vRRsuLMJHYXwnvDvdgriZKUGNIzg8t9TNr+xc+P0JUv92ezoVYOzUONks+OS7OTi7Ib3ns6fXW6LJBoH1qI64c2orSfSZf2xPCFsX46uELHPDWbIcwEcjc01a1mOGAtIEq+ETFrhSzdQSXzfTJolV+VVgSeq1b1zOd15adgzTEG+1IvROWrQVDD1VBvde+5yvq6nEM1fYiWDs8uKVlYAt4Me3krkIf2b1xrq8pGHenc28p2ylXTCzdDNLR3P6aGVztAsvT/6R2V56iiPxDa0cwqWjoUp75gtBSWlgJaQ7k6T44EIpl/QYjWiwhPflotADTDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0xTS5/jMbwM2Hj3AfMqdx4c+Hib1EXe+Qdcuu8lUy8=;
 b=Z8JQMs5PNFMcwi9cYmcGJhuFgwFJ4mSJUjYqP70kwm9iMhxwliBVXzTPYX0yY58XxLNFcYScqQT4rlg167mMrLfljYG37Y+FlFafne2E/P9X+Aata8NdNP1rzXlXNrpe1+F9EBFOWfCRXVCl3GP4vU7RTikZF5CE3Ze26udpS+P98xBI32fCQh84/fXXJPr87UhIwiGs4wQxt6++AvuZk9fmk/bRl8JSSvnyB0rSDAEjuWxAOnbXdbfPYaw3LRthNW5ha9ekxWRuXWIU5xC02gN/thlV/Cmf9l27YPtFJXkrVhGNJJexwopR+7L+XR8X6bP9iNarpLVIOm7DbA6Lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=holtmann.org smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0xTS5/jMbwM2Hj3AfMqdx4c+Hib1EXe+Qdcuu8lUy8=;
 b=cHNB24r39hFvLOu/9ymWn3OwzU2qpMkoTIFXDuI0u+MPl2RSI5f4qzfThsdKEGF3Um18BK1qW2acwwp6DcAgmVrPA+Kln/XSEjZcGK0P4le7B+GVQw6N9Pzt4TSBo44sii4WTgV1NRIPePZrH5G+zEsz6Ykg9dxqe8q2npqoUR1gV8R0HM/ntO/ffNUKm/mggO7nux/3cKBIl6iZEx2yvJPf7eXwQg1RnVka/OxpmyC9Sn5r4LxfDLiEo+0y0AYqZRdjYU9sYC9eu+deFHPSGtTsZ+fZv+UPTFXUSl1OLP3TiHZj/x/4yMDXT/OtNL6DVkvTGOvPj5BdiVd180TSeg==
Received: from AS9PR07CA0023.eurprd07.prod.outlook.com (2603:10a6:20b:46c::22)
 by PAXPR10MB4827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 07:21:10 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46c:cafe::41) by AS9PR07CA0023.outlook.office365.com
 (2603:10a6:20b:46c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 07:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.199 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.199; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.199) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 07:21:09 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Wed, 27 Apr
 2022 09:20:58 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Wed, 27 Apr 2022 09:20:58 +0200
Received: from FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) by
 FE-HUB2000.de.bosch.com (10.4.103.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 09:20:58 +0200
Received: from FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) by
 FE0SWIEXHC03.bsh.corp.bshg.com (10.49.78.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 27 Apr 2022 09:20:57 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Wed, 27 Apr 2022 09:20:57 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3%6]) with mapi id
 15.01.2375.024; Wed, 27 Apr 2022 09:20:57 +0200
From: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To: Marcel Holtmann <marcel@holtmann.org>, Ariel D'Alessandro
	<ariel.dalessandro@collabora.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Thread-Topic: [PATCH 1/1] gsupplicant: Add MFP support for WPA2
Thread-Index: AQHYWLZd2qtADdGnG02gfFrLFNvjNq0CHlAAgAAHcICAASo+YA==
Date: Wed, 27 Apr 2022 07:20:57 +0000
Message-ID: <6dbc9c41e6f5459291a118bdd0dcfc5f@bshg.com>
References: <20220425150837.89194-1-sven.dembianny@bshg.com>
 <20220425150837.89194-2-sven.dembianny@bshg.com>
 <4deec7b0-a2e5-0d91-a81c-dc4bb79c1594@collabora.com>
 <8B96358C-6DA1-41E0-8C79-7724AD78EC53@holtmann.org>
In-Reply-To: <8B96358C-6DA1-41E0-8C79-7724AD78EC53@holtmann.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.49.85.187]
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Office365-Filtering-Correlation-Id: 3af328d2-8005-42ca-1261-08da281e80a9
X-MS-TrafficTypeDiagnostic: PAXPR10MB4827:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR10MB4827CE7F286C22F8466FF453F4FA9@PAXPR10MB4827.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9jG23lJ/s11FmvEKdpPhqzxMvjlBsmOh08CM3ZVHThrM+b6JgF9PRYavlUYOBIoA+kKxmw0E2OjJs7yoXZlx3ku7OiqAKKP5JDLn/joVbyink3q1SyEQZ119FvKvESOTccVwIjT9qFm1pXOL0gjHCLw7BJo2nrlIpV1DgdK/Z9cTDfUSn9QKiF3TZrCvNN9jjFwPAgVXsq9i9TmAE2lv1qvkxhiyxiV1etYRCcFLe46guK82uZB4SzBB8GNwLGAWAZ8aSTESAAXGqZccQ1uVlmO4VkTqYmJSRdiJUyHvT7KLWF7Yr33xinDkeENLyc3S3i/25x5j4qbwGR9WMvOx6QaBoiDwnRQcy4aJ6oHi+UtjwW8OVxCPEJ/Ntjh6oX3WAKF70+DTc6XH6mIFXkE9ERx/itpowhtX6YpiuGO1gIVLrKIzf890e7yLkVF+dTBFw14Eitjtnfj4q8IqIJTRkskmRfqEMc7Dx8vjDyTXDiJs4YqR6ck4+l+WYRgREYIu2fuaJ6n8zzgGFdlqs3Vatz+Ey1CpJq4lAkMQJopMA8AiO5HofkJXX7Qpgxg3OlGKYzQfM8hoIusjFWUT5KW98eT+RZpmAwfKwqoSkbmXFUCYBMQYJ9wPqFgvPkUIIz/DSCz9fkL7tKobP0hqexP10P75dveZmON9/byXZiNQ+2CninO2OmdMECdWebuPaGlcYKOakN7mkwCIfWrXreTwmQ==
X-Forefront-Antispam-Report:
	CIP:139.15.153.199;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(508600001)(70206006)(4326008)(81166007)(70586007)(8676002)(356005)(82960400001)(40460700003)(86362001)(110136005)(8936002)(5660300002)(36860700001)(316002)(83380400001)(26005)(24736004)(2616005)(36756003)(186003)(108616005)(7696005)(47076005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 07:21:09.8259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af328d2-8005-42ca-1261-08da281e80a9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.199];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4827

Hi Ariel,
hi Marcel,

> Hi Ariel,
>=20
> >> Previous MFP support was restricted to WPA3, however it is also
> >> possible to set MFP to mandatory on APs with WPA2.
> >>
> >> wpa_supplicant config:
> >>
> >> * WPA2-Personal: key_mgmt=3D"WPA-PSK-SHA256" ; iee80211w=3D1
> >>
> >> Signed-off-by: Sven Dembianny <sven.dembianny@bshg.com>
> >> ---
> >> gsupplicant/supplicant.c | 4 ++++
> >> 1 file changed, 4 insertions(+)
> >>
> >> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> >> index 1b92ec44..e9152632 100644
> >> --- a/gsupplicant/supplicant.c
> >> +++ b/gsupplicant/supplicant.c
> >> @@ -4969,6 +4969,10 @@ static void
> add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
> >> 				ieee80211w =3D G_SUPPLICANT_MFP_REQUIRED;
> >> 			}
> >> 			add_network_ieee80211w(dict, ssid, ieee80211w);
> >> +		} else if (ssid->keymgmt &
> G_SUPPLICANT_KEYMGMT_WPA_PSK_256) {
> >> +			key_mgmt =3D "WPA-PSK-SHA256";
> >> +			ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
> >> +			add_network_ieee80211w(dict, ssid, ieee80211w);
> >> 		} else {
> >> 			key_mgmt =3D "WPA-PSK";
> >
> > Shall we also consider the "WPA-PSK" case in the same way?

As to my understanding, MFP requires SHA256.

>=20
> I prefer we remove wpa_supplicant support from ConnMan and you start usin=
g
> iwd ;)
>=20
> And I am only half joking since this part of wpa_supplicant is such a mes=
s.
> Whatever key management they introduce next will turn into your next
> problem and compatibility issues. I am running independent SSIDs in my ho=
me
> network to deal with end consumer device since they use a wpa_supplicant =
and
> management software that is too dumb.
>=20
> With iwd the WiFi protocol is in one daemon and not split between two
> daemons.

Unfortunately in our case we are tied to wpa_supplicant because of chip ven=
dor specifications.

Best regards, Sven

>=20
> Regards
>=20
> Marcel

