Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1A72
	for <connman@lists.linux.dev>; Mon, 14 Jun 2021 09:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvNzVEZBZOgos+rMlNZza8/n1i6V4Y888OcH4gD5UZfmeMQ4EGdnX5sCqzAtdRpPoGHA7HdLnzVuhz0DoKw3Q0VpiqskrPHoVSIwRvvwWNlaHgPnfv0AsWa6pOJmGWwBB0l0+kF5q413ndmfOTThs+/YBwoq0YPlg/a81oaDdcExhRq1uUnmTVkshds5GmODk9JXuM6zvlk98vZt2Xq+qCZAeiI/Ne4HkfG/tOdYrUDtokeVcJ6I9IHKy1s3th7H1Lcc5ZlAA5XGmxLP3v9GBI0Ya4mpRnZp+mhizcU7k8T73/lKy17ZJ0xwk9hc1JPr83oGq51qx4fsqJymvPpslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb6MTbHbqLxEUpDPrjshYL1YZwiyzD+jOauQMnbQv3k=;
 b=WWfFh6g+h422ELryfpee/79GNfo85jh+aCrmIpCynHGGDrEOj0qvcL8mUEkzWvdImGk9cN5e7j6rI8ZSDILT8EyKUhh7MB+lX5t2JI0lcnzdcTGepOFC3KuZi3GiGZvc3pg/rOqhoQclO6Fd8TPWudPvghLGrL5xZoOZ4qDojY86JrSAq39+qhaHod/BdUQEBN2JPDVPOJjaTzCamt7KS9jhkwBVH9vmgW5q8PPO3DpUjoNk9ZklL3TLcI0XPLyYJrIhBgXBMTt45RZGrzNGVgL8R/Jy9QC7ImoJi0YVnyJGOdqQX83P6qz7tUPpLE92+jmU4cxaZqhA2O2EiIrbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb6MTbHbqLxEUpDPrjshYL1YZwiyzD+jOauQMnbQv3k=;
 b=Vz7HaT4mesHSs/BqFmc9cCjq4VochE26+jPXIPhIUk+ytfPgbBmjxU3lZXM6Hp/BRwlbusPvsSuAf9VOn+bLVQlFK6pBTwKsyThGXgeLRNrsb2Ki/8zporMH+/lIBcvN1NXL8euoG0ISqvCFgIS3irRbpdrXyqUILCc0AM+OVR0=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PAXPR02MB7374.eurprd02.prod.outlook.com (2603:10a6:102:1bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Mon, 14 Jun
 2021 09:41:02 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830%3]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 09:41:02 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] service: Fix preferred service reordering on ready state
Thread-Topic: [PATCH] service: Fix preferred service reordering on ready state
Thread-Index: AQHXYP7y9dYDEFzAnkCTZSq5lr1DgA==
Date: Mon, 14 Jun 2021 09:41:02 +0000
Message-ID:
 <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-originating-ip: [176.158.51.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 371a4a04-b500-4661-e727-08d92f188603
x-ms-traffictypediagnostic: PAXPR02MB7374:
x-microsoft-antispam-prvs:
 <PAXPR02MB7374886BB01CCF2F0BE9AF3D93319@PAXPR02MB7374.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RLLetCK3D8XrH4flQ7QaO8o7ck8F3keEtdiBQ8NT1ctZirYqFSuuqhl/y3EkgE3vK10KiLzJV7tClpMXdmzPAwJAk3NsFKRMyIlXnrkzb/NWcihIg/Cw5F/mCidDVnMkfBrBJcM9mYOWc8s8O0daifi5gu1XIaCzWwAm+qxxEbUuGv8rJKUcOenhQG5KmHnF84alOKuIG9BL1rDGdjNmpKxbyCDktj6fukRXnP2urlmYxEiDFT4ll6X4SiovTnrV851tgvbBfymO36F2ayoY9x04LhUJIJNUuWIrKzeMgI02PtyoyNTTgZVEetWXiAERn1CF8o5lYAG6hKsXsS9NXJFu0lsnqRwX/NU4ZDkHJ5ynkwYZRKfW6ozPWWEurDgW2+4sKip7jTVDT4bM+s3o3lGNWniyVAD5mWUj/GsUs5sulx8MlxRW8FmSZSOa/vjN8gSujZ+fHt39mhMYQOkXNTpGSe4sTvPXwqVl1gjstN9nL66iP0ZMXEGGBxiNWJbyPuMCzD0dxemc17iCatB+7v8Qkst2BkHtrOSPyU6960VCA/vur7NVsNn8cGzkaOv22bd5tRgMsvFucUj1xbhVMAo/8S10/nVqikbHKf1E5l0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(7696005)(316002)(6506007)(186003)(26005)(2906002)(83380400001)(66446008)(5660300002)(71200400001)(33656002)(8936002)(38100700002)(6916009)(8676002)(91956017)(122000001)(9686003)(52536014)(86362001)(55016002)(64756008)(478600001)(66946007)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vUfr6fDKfzeAdvCatPC556o6PsyaLi17gA9JEtnx+aiKp8Yuk+6f8xugf+?=
 =?iso-8859-1?Q?yY8issQwvzFmKYd4umByycGKpP6RL+DCTJy97R5ZNO+n+KPMLvFA6v6KuS?=
 =?iso-8859-1?Q?rSBx2L5Exf196SbwWhJaN7ixMAci6uIAn6I1GxApRBlSO2r0hqcg9qh5yT?=
 =?iso-8859-1?Q?06ZdIxTK9E3F9piY2daPIDBCGomco5Lsh7nNsIe6QHxseI4PjNeiUceyOb?=
 =?iso-8859-1?Q?SGLhKEwS1GUAEwgCUmzpG3DJ7zqkYgAg/B7pfm3gYy62lxpvtWag5PHUc4?=
 =?iso-8859-1?Q?MW7AnXROYpv5KWdyCjn8qXeoqiJ5LNqmaNbrQAtBExi67MJD+6e6ceEdxQ?=
 =?iso-8859-1?Q?DyMEyL4ZgIWgh/W1G/MYc6mW8XVn6w+IY5KEsT/R1OcB6TK4Dci1JR5PfT?=
 =?iso-8859-1?Q?5gtYAF7Jk7p78u9M8A42WxpR1SsviI6Wnjh2216zg3L+6gliTZ736O4tws?=
 =?iso-8859-1?Q?Cn8H8FWzbpbjS4YZrvEX7Vka78TFx4yBXcphBIShNHvm1CpRccN03h07WU?=
 =?iso-8859-1?Q?US20SMnCHJ54b0/NVpgzWrKNhdZeayUgjIFfQnrCEJRVp4mWX399VI6q1w?=
 =?iso-8859-1?Q?/rVuaM9IfnysDdk9Qs5m7PpW7QndHsJO34M1G+Yr6JWj8NKd6GpfKO9xI3?=
 =?iso-8859-1?Q?2v9++POQPTew9kkI3zkdRvg5kFDzQ5nHy6y1yyim/WUFZVNeO04kAbB+Jc?=
 =?iso-8859-1?Q?urjQI5bbKfRvFhz5M8wyHDjU9Ar82+Y4QrzHSllekEwZmDM+4Cj4xbsSNw?=
 =?iso-8859-1?Q?VfSbdpkwEOUhZ5Yw8KwFgGR6yjMhir4ydbLWIddIdDeGikRjfcm/PpZwTS?=
 =?iso-8859-1?Q?zcDaZh472lgZhQCV7BdNmfzs3guve21qYs1WBOkCaJUEc7+ViweatDRU+r?=
 =?iso-8859-1?Q?0r6GBa1JP45CmSx38cJMGRdL8XXWcRKau/78TCFjIccaURc9gk8jccozW8?=
 =?iso-8859-1?Q?UAouf41srk/7mPpfybAZgj1UXc0iShD4kVvQPGTjgV30CXd4EfoxJl1Cfe?=
 =?iso-8859-1?Q?pl2OwMoqvRSVo474GIzbTjweO69Z+B9UbbvAjIZBIf/RGCz94Nu2gMLDxr?=
 =?iso-8859-1?Q?wN5IlBr7pqsUbJodYYxncGCobvh5pnkjdeCNGJUnlUjnQXvTgI/B6oKnJK?=
 =?iso-8859-1?Q?pz2dJ/jnAzlu8pwlAgxqXqw9YSwJOpIIXbv//NdTW1SD1KY1ltgh2InUpu?=
 =?iso-8859-1?Q?3xxjDKxD5XmiMNQnoB3AolT2JIWT6A5bOJTAPcB8EL1xCE4Pvk9At/97iT?=
 =?iso-8859-1?Q?3XsM+DHfw0FGJnA5woBBMT6+AzuYmM33E9cFnIrsleoUiScyHtBT+nFtMJ?=
 =?iso-8859-1?Q?/IuZXLwn2lDFBb8Xn1F9WTXlVzbE91/bR8Z0fg/dZTvbqW+cjMwIyFOABS?=
 =?iso-8859-1?Q?M3yxXOgOOP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4794.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371a4a04-b500-4661-e727-08d92f188603
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 09:41:02.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgCCZr6ToIhmvKksIsAQNRUMbly57GLyhAU4s9cZ8iioM1dOfK4V07I7BBb2pOyrd6FA2aPVjA/FqwWIIUdW7mQvoy4w9nIA6zuKmfIWnWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7374

When a service reaches the ready state, the service list shall always=0A=
be reordered according to the PreferredTechnologies config options.=0A=
=0A=
This issue can be reproduced with PreferredTechnologies=3Dethernet,wifi,=0A=
by following the steps above:=0A=
1. Starting, Ethernet (E) plugged, with a known Wifi (W) network.=0A=
E idle -> online, W idle -> ready=0A=
2. Unplug Ethernet.=0A=
E online -> idle, W ready -> online=0A=
3. Plug Ethernet.=0A=
E idle -> ready, W online=0A=
Even if Ethernet has the highest priority, it will never be online,=0A=
except if Wifi connection is lost.=0A=
=0A=
Fixes: e600366f6035 ("service: Start online check on IP address update")=0A=
---=0A=
 src/service.c | 17 ++++++-----------=0A=
 1 file changed, 6 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 20917a8923a4..cadd9fc76881 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -4711,15 +4711,11 @@ static void apply_relevant_default_downgrade(struct=
 connman_service *service)=0A=
 	struct connman_service *def_service;=0A=
 =0A=
 	def_service =3D connman_service_get_default();=0A=
-	if (!def_service)=0A=
+	if (!def_service || def_service !=3D service ||=0A=
+		def_service->state !=3D CONNMAN_SERVICE_STATE_ONLINE)=0A=
 		return;=0A=
 =0A=
-	if (def_service =3D=3D service &&=0A=
-			def_service->state =3D=3D CONNMAN_SERVICE_STATE_ONLINE) {=0A=
-		def_service->state =3D CONNMAN_SERVICE_STATE_READY;=0A=
-		__connman_notifier_leave_online(def_service->type);=0A=
-		state_changed(def_service);=0A=
-	}=0A=
+	downgrade_state(def_service);=0A=
 }=0A=
 =0A=
 static void switch_default_service(struct connman_service *default_service=
,=0A=
@@ -5898,8 +5894,7 @@ static int service_update_preferred_order(struct conn=
man_service *default_servic=0A=
 	unsigned int *tech_array;=0A=
 	int i;=0A=
 =0A=
-	if (!default_service || default_service =3D=3D new_service ||=0A=
-			default_service->state !=3D new_state)=0A=
+	if (!default_service || default_service =3D=3D new_service)=0A=
 		return 0;=0A=
 =0A=
 	tech_array =3D connman_setting_get_uint_list("PreferredTechnologies");=0A=
@@ -6051,12 +6046,12 @@ static int service_indicate_state(struct connman_se=
rvice *service)=0A=
 =0A=
 		service->new_service =3D false;=0A=
 =0A=
-		default_changed();=0A=
-=0A=
 		def_service =3D connman_service_get_default();=0A=
 =0A=
 		service_update_preferred_order(def_service, service, new_state);=0A=
 =0A=
+		default_changed();=0A=
+=0A=
 		__connman_service_set_favorite(service, true);=0A=
 =0A=
 		reply_pending(service, 0);=0A=
-- =0A=
2.25.1=0A=
=0A=
