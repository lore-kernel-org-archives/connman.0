Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120085.outbound.protection.outlook.com [40.107.12.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561653FCC
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 12:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1lBb1ks7gq0ZrQmifYRYo52e+XSm1JENJiL69LgaCzQuVwAUXRja1JCpK6b11n/HGRhOCysmqaXw6UrKyEN6dzlP/GdesJSAxjkC+5KkWl2manxhmnNWbYsAjmPMmbUN84JbJ9DkQdLMFTOuRCr4Mjo4i7Sfc8/yQ2gAutd6SSNpV2yCZlcrS5VucYemRXMJRorAvTnQ5ZnDdqX9hUT+yqeJ++FZNHrW/WsmUwVmcPpBM+gHiOqShn5dkgh9H4IB68SX0LARtDDMsmXj9zFaq+zaKNjBTUqfzFRnyX+pP0LZr9KSXjVix8UMYUxZexT/62U1ORlzD0Ja4ql5y3VaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSxLP30uloTzXaqNhgv2QbWJGqZalx9O7O1kteHtWjo=;
 b=flxNpFvxAtgWWQqMAWOE89JtD0tsImrIjuXZXx3IDEWLYfv3SaSvTj99nwKw1o7SA8pb6f+gkEt6/kKrpBt7na6y/pnVbvTR+9gY5U73lJ0NybLhOqxyfOkBEcCzUKmv8Bxc18MjZHK+e6TRbyUVQaINaqp1CoAIikch39tVC4xyRXH5yKBaZwQPYj7xnMlruh2iOZ17QM1eIHendAVFueuomVEVPRHb04zANOskkP4FrsRVmlAvPxl6OUwOyb3MaLFVebE+6Bi7N+z0tMYbAOkLFPtGk1dKNF/W2AjK15n5FDHvKq8qri2jzVBtTjH2WOktj0GXaFy2Q7RHq1tU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSxLP30uloTzXaqNhgv2QbWJGqZalx9O7O1kteHtWjo=;
 b=D0piF5q78fng8oFl6CkhBRP6qt7dJsW1/qX5duZOz2wO2b3W1ZTCR8+hn9BYsya6761chU0seqRys1GiWVOChRwDkKtarBOic1a11j1rlgNvxGPF6VUQR0NUm2XwR3AxQngMk+ketNkw3Tm88WXL4p5j0Iw8Lie52AMdgiOMfDM=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1555.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Fri, 1 Oct 2021 12:13:50 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 12:13:50 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Fix missing Ethernet attributes
Thread-Topic: [PATCH] iwd: Fix missing Ethernet attributes
Thread-Index: AQHXtr0zj4eFWvbcdUqNbSuyQwaOlQ==
Date: Fri, 1 Oct 2021 12:13:49 +0000
Message-ID:
 <MRZP264MB1544A93191E9041F8D1C61C393AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 67c1e82b-35b0-18f7-59c7-4c2c729d6e40
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40bd63a3-3cc2-4ac9-1b4d-08d984d4ed69
x-ms-traffictypediagnostic: MR1P264MB1555:
x-microsoft-antispam-prvs:
 <MR1P264MB15557B3C3BBFA8CBBC882D6193AB9@MR1P264MB1555.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hd9oYdRCPgrTRADO+fyxwEhSOC66UoQDZIwLem9LvZU3YyMdj6AsmNZ/B7XfjnBegTB7Den/mN701MBubylTLQdvdcLcmiLJNdPrnjXqKetk9k7oanJs1N1r6nJujdM6Nzv/Sx1vZhqB+SEx1eqVQtyC67G5YVDVps9jKm6yjsTkY1BumqAg7vxMr5kg18NDX1XJECV31BKpnj1SyLjenVR4Szwl+QN1zzV41wSrmhXbqi9EE3QpkTjR06iSQr0js2F1RDf0K374SPr5j0PHau6DwoQNuRbJ4MmmpT58qWQ8wEC2Y+q0TnS0O4MAaUkVqnciThf22YK7lacH9g1RfHMc9k8fj71beHdgvjvphOqWukfFACaZaPmmbJhrti56cVWD2NMhRFZgjgcbEmU7JTGZy5ipxH9UoxhXbH7WgL1gvzcI0FfG/1XLdi397lCnQykt+9GzXX46P/DootygxwHCa2frNIkL2OTbPZDTjwDa5f9KdQDi7VR3/dSat1ikAKAKh4XPnayPpW6ffcuvl0+q0cPbE63Dv7nSu0w/W0wIDG5thgqJhMrPzGfsghwdMI4gbkF6XFRa1ag2mEDJucmsQlTTC9Ghv0pOjE37R0O0JKy7j7QLQ/L564c5dzatcwmlpUGTshSbls1Dkigeg/xVce8RWeiHMdE2z3ONclOjSHAam1jUKBpIHQ6BAU+OaAWMkHa8W3CGeCKX1/2XQA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6506007)(508600001)(38070700005)(52536014)(26005)(122000001)(86362001)(33656002)(83380400001)(316002)(66946007)(8676002)(91956017)(76116006)(6916009)(66556008)(64756008)(66446008)(66476007)(186003)(2906002)(55016002)(7696005)(5660300002)(8936002)(71200400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?og/oK87PcruBDYwVqVQddz9hhl/UJOEfMNjIAS7AaUSWJnGx5SOdsiHJ3t?=
 =?iso-8859-1?Q?FfmEKrMPkbWkBdxHnE8aFuJ1XD+dxIoWndvcKGOy4M8Cjo8vYcWxKVOq5a?=
 =?iso-8859-1?Q?Bu4Zn5bwXxIq7XxdC+PJoU53mGeDcUowBgZOsL79gKxZ/JfxWnSuik/VnQ?=
 =?iso-8859-1?Q?oGRaeSfNCMSJ2smjha6ingML9q3KPV/Jw3yMQumSbMaMkAZlSLWwwvpv3s?=
 =?iso-8859-1?Q?vul8CZGPAx+q/FgzOu6xOPXZvyzpuzLG2WrcLnIQNuF/45HqfE/gq0Jx5l?=
 =?iso-8859-1?Q?AKd/oqpD2RSKUbjm3sg4yGi+FcwU2AQbsQiynv65KGw0+wIvPtkHYIXe91?=
 =?iso-8859-1?Q?iWR58y025H+K7VSFFAUZmxDs4NoeM2Hv4PJVWqrdGFJv7bFD15Ucwvq+8B?=
 =?iso-8859-1?Q?1C/02Ar+1UuKT52QhrskUbdUQTk4OoKpi27bYyVfzHomRJAoOQkmiB5lHj?=
 =?iso-8859-1?Q?KeeeHJeNpG7bcpnoQ4YrWjNoiKb5sXwFYdlzMeYJMKYFferNhnFW+W9heQ?=
 =?iso-8859-1?Q?9VBNLAYQyrotl5pD2EPa+VsbJ8eTt/thggLKmg6nWeWQMyg8HyQIvKg9Nb?=
 =?iso-8859-1?Q?TjJH2ndsvp9D3VCNZaOuPsu/A2/jRMMFU7S2oQigQI0xXeaGdHDyMzqEwM?=
 =?iso-8859-1?Q?hZlS1l/wSksOFvrZHv8X/ZgikCi29MXoYnHLzynFMWboSgFIyA+OctHTct?=
 =?iso-8859-1?Q?qeTX9mRe5xRZDwHkz+jUDvYPcHkZ8aXYZfZXs5B8pBNoU0oM9Mf99cAveS?=
 =?iso-8859-1?Q?FiPGFiim9YremIg4Y+P2BeW1j01/6W2yE+ZoJHbAxbHl9LWEexbMJTT3hG?=
 =?iso-8859-1?Q?ZKc3evyKJcSNZxirbnhxu70EY2qY5OWx9U00aA26m//HnbX71v3U7NGE/k?=
 =?iso-8859-1?Q?iKbfZlZTvnTCgFOZAnQ56hA8tykn9EtwEPC5pQ5QPN/3uzJnezTZQaZC1L?=
 =?iso-8859-1?Q?17DRz7V26CkoeCbzFCUmMxGGiuGwOdFoIdGHZhBrY1IXfclvZXoe3qiHV8?=
 =?iso-8859-1?Q?LwC/K4vV/HyOu8Y73sEJSwuQ7U6Q6zbGJ5tjGmNjMn12fJMxTh7nFI8R/j?=
 =?iso-8859-1?Q?jWUtLLAP6DkLWkyO8XIqF4fPMydmHsRCjdwQ1tJE2nqll5QwJ0S8yYopWf?=
 =?iso-8859-1?Q?1D7inIBd6cplUmOa3TeWcm7BeL+Hij0c1Uo9IocQIc6p/zqISyU101HhWR?=
 =?iso-8859-1?Q?l2RwAO1B/K66+YbvogjAGJDimczGE+zg/xwNvy9Rk6VG1c9rkSbC1uoU3j?=
 =?iso-8859-1?Q?1y1pEy4F85XKrTy1IqPhodqAOlXxs06yo69RA2oTBz0v01l3PhXXYNTqm7?=
 =?iso-8859-1?Q?nxClIGz7Eriq865d5uckTIa6sRK9iZReG5O48YY/8PpX0RI=3D?=
x-ms-exchange-transport-forked: True
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bd63a3-3cc2-4ac9-1b4d-08d984d4ed69
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 12:13:49.9193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NancExMaIuzt0l3Z/RcfAxCybqfJhV10p1PIMu7REx3MpdKr+LSHzWNowno45ICpd9CkUGSj0+hQCTAOThOP2/7GMOXOAEsJkCCLU77/yjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1555

The Interface, Address and MTU attributes of Ethernet Service property=0A=
were not retrieved because the interface index was specified to late=0A=
(at network connection instead of creation), preventing the access=0A=
to the corresponding ipconfig.=0A=
---=0A=
 plugins/iwd.c | 15 ++++++++-------=0A=
 1 file changed, 8 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index 14a442a7b67c..9f2114f47311 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -209,18 +209,13 @@ static int cm_network_probe(struct connman_network *n=
etwork)=0A=
 static void update_network_connected(struct iwd_network *iwdn)=0A=
 {=0A=
 	struct iwd_device *iwdd;=0A=
-	int index;=0A=
 =0A=
 	iwdd =3D g_hash_table_lookup(devices, iwdn->device);=0A=
 	if (!iwdd)=0A=
 		return;=0A=
 =0A=
-	index =3D connman_inet_ifindex(iwdd->name);=0A=
-	if (index < 0)=0A=
-		return;=0A=
-=0A=
-	DBG("interface name %s index %d", iwdd->name, index);=0A=
-	connman_network_set_index(iwdn->network, index);=0A=
+	DBG("interface name %s index %d", iwdd->name,=0A=
+		connman_network_get_index(iwdn->network));=0A=
 	connman_network_set_connected(iwdn->network, true);=0A=
 }=0A=
 =0A=
@@ -912,6 +907,7 @@ static void add_network(const char *path, struct iwd_ne=
twork *iwdn)=0A=
 {=0A=
 	struct iwd_device *iwdd;=0A=
 	char *identifier;=0A=
+	int index;=0A=
 =0A=
 	iwdd =3D g_hash_table_lookup(devices, iwdn->device);=0A=
 	if (!iwdd)=0A=
@@ -920,6 +916,11 @@ static void add_network(const char *path, struct iwd_n=
etwork *iwdn)=0A=
 	identifier =3D create_identifier(path, iwdn->type);=0A=
 	iwdn->network =3D connman_network_create(identifier,=0A=
 					CONNMAN_NETWORK_TYPE_WIFI);=0A=
+=0A=
+	index =3D connman_inet_ifindex(iwdd->name);=0A=
+	if (index >=3D 0)=0A=
+		connman_network_set_index(iwdn->network, index);=0A=
+=0A=
 	connman_network_set_data(iwdn->network, iwdn);=0A=
 =0A=
 	connman_network_set_name(iwdn->network, iwdn->name);=0A=
-- =0A=
2.25.1=0A=
