Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FF72
	for <connman@lists.linux.dev>; Mon, 14 Jun 2021 09:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC5EAFP/OvQOVGruRhCsGEWDibAPbAAXNCddUonTfu/dU2U5J2IivoYARGoDodVZ0JEBbsundFfkmA4p7USNGj6NalvX23UofnPvh/bNhdBu3B+jAluS9kkBlRFD96jjK9DpKCiq1+sWa/x4LZCvvkLMe4jsGrHszG1A+7wM6yzTFXdbcyRD92quZA0r5cjSd5KeQDiW2MZOEe43xeYqKLUoOGDxFsoavWT30JxUVVpMi+X8V5oaiVGXndqWhQPC0TKMD5T7SOqtGGXMpm96zP3Hx67uHeo7NvQO27ARq+E42w5pa54V7FN2yOYKySQBHHYKiOvrIlyBK0kTeQvzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceDhTjofSD2JAMzTP/qugnBaM/gZ+9H3Tr6yylcsL2U=;
 b=iD/vc2ULJWeryXpcNfwYb6cP6WpfZmQdiA2uLoamPdujWdfTcZs/zbTAuWpdGi8HWc4sAhDOGUmY6Fu923nCvF8vYd4CjfBKkadc/9vauQNov2nFMOk8EHYR3fCTlIm5QQEq24U7hov/mJrOi9UdI+W8nagZheN8H2iNUy4seYUx7lPEOvHS3C609LAFdO4Fr3IvxLamiJXq5MniXoUo0BPxI6tvauQhO3/ixMR3v4ifOGVETlmH1ZxWvGmBlxd3BSOhKVyYXWkpT1YGmwf1FrZ8SAzqciTUWDw3yrqWqAXXE0Dl9zI9ESD/wgcClNXpKNyYlx8noKXbHQsOg5J6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceDhTjofSD2JAMzTP/qugnBaM/gZ+9H3Tr6yylcsL2U=;
 b=fSJpAIyencmGejGs858rT610FHislt5+60isrRk857npziPH7lhv6+1QCA2Y35bT8s2dCygOEA0oXdM4bB2YA1i8Zl8vhgUicV/SaTePDYDOq/bbduUEs96mSOjZC4aYdYx4pVnytaqtNubcZzzX05y32a8A4Ik++vyVUkA351g=
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com (2603:10a6:102:5::13)
 by PA4PR02MB7134.eurprd02.prod.outlook.com (2603:10a6:102:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 09:14:48 +0000
Received: from PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830]) by PR1PR02MB4794.eurprd02.prod.outlook.com
 ([fe80::9d55:7c70:8262:f830%3]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 09:14:48 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] service: Prevent auto connection during passphrase request
Thread-Topic: [PATCH] service: Prevent auto connection during passphrase
 request
Thread-Index: AQHXYP0z1UDC2PJp8EiESz+rAkM0Lw==
Date: Mon, 14 Jun 2021 09:14:48 +0000
Message-ID:
 <PR1PR02MB47941F36176A2E8723EB139193319@PR1PR02MB4794.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-originating-ip: [176.158.51.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 027d8e26-d98a-4508-4258-08d92f14dbb6
x-ms-traffictypediagnostic: PA4PR02MB7134:
x-microsoft-antispam-prvs:
 <PA4PR02MB71340B598591164EFF5410ED93319@PA4PR02MB7134.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 h+DEQDHEaTywAltrEFk6hdDdc9zgY5OA8lj/OjqfPjHqkL8Jd3gQC9rB6JbTMTSsr8EHpinC0AB4jU+Shyn7pXvaQBxf4jWGidQ648Dk9pyY2xz48idjPuiDjyT/CHhgqRdMyjnLnAhfmFG4EOsbZveojFvgy3GuEZdl0pAJW40UzQ8iLy3N/52kBYzdyeSzpMDImq/ZfCjdBB538HxRNVoTSzUo1WU0Otu9LdtTXWO5+aBRkilPbY/2Cx2cq7tnePFleV2xUtGqzY82lQtRoKuUMyldptygUpxz8yyqz4k9rjA9CAkbMrfN1ZefM+xfOANw/YNOnAGdk+DazwS1aww+bDtxYsm85Y3d61RqyBHyISkwrtSrVvv7KeURrLtHQCjFvl0CXSVySCvT/HcAeQeSj9WDQp5xPRwQa06bktiSJr6TEsxXHT2qq+hsc+EGbnGY1Q6H15XMaRsQQRptHCk/msHuTdlp1eYoxrE6+Y8vO3VuWLELjgxOP7cfS1jHgs46ons+Gpebrr/eCVIGJHoAFuHtdO6EhGfM30ajyf7Vw05diFbvZOGL8XlEIP5+1kWyg8pSVbbzl63ZOZb2kHpmQJbs13zYc//4RoOzhEs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4794.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(9686003)(2906002)(55016002)(38100700002)(26005)(71200400001)(186003)(5660300002)(6506007)(122000001)(7696005)(76116006)(6916009)(8936002)(86362001)(316002)(66946007)(66476007)(66446008)(64756008)(66556008)(33656002)(52536014)(8676002)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JViaQ0qXSsHip6mqezMAX4Ne1B9xMVZZTUcHywFW5pdjrMhqwUc77QDD+L?=
 =?iso-8859-1?Q?D79HJFGNuvaIMFOxbyU7iJ5xaCQq5WzuMBDRTheaDnkqlYtB6Px6umVT+2?=
 =?iso-8859-1?Q?THs2IjzdNXijsZwGna+li32Jb3ezhkAhsdNBtk4KDXEoWdghUthgeeQErl?=
 =?iso-8859-1?Q?CRPe3NSyaT+DuMgVOwPRRSfsMKZiSnV+UyEI+c+v3P4lo6sGxKCq8w5W6X?=
 =?iso-8859-1?Q?D7EQ6nn9wLhTXm5NvALE5obi7ylBaLy/zMutMuszDZ5WwDyEgdE8RcY6NC?=
 =?iso-8859-1?Q?dAwGYvB0CxkheYsxwaQC5meUWTBqlS63kD/njne6yq1vwd0aIGSVQuPVdF?=
 =?iso-8859-1?Q?+FL1Mnv9QBlc8UZE9kvmrKG5DNzPligs7XyIpPuq3yY/N5ZaWsGVdN4lrb?=
 =?iso-8859-1?Q?TQ4XV9LIubMle2BBjduJs5dNK2RVg4rNHNUpooB4R86OsXpWgnj7TDNF8d?=
 =?iso-8859-1?Q?toY4lUM5iK6eFff3piNfRt0yLHTAHo4KYHqKfyq4SX+If8srokcdmAFxHV?=
 =?iso-8859-1?Q?LVuPS6ualxIMDyzCx7ASr/Ge3oqYpL698/R8sooBbIgFwuLIEDs2P2TAjk?=
 =?iso-8859-1?Q?hD6xFuws5UVRv0ZRBdYA8eEhca1c+JZUdlsszHJ0Y1She08F1Wlg3b7LTR?=
 =?iso-8859-1?Q?kEcfV6okkCpC3tAbiJqi/QRcaOwNCG5NSEszJv72CsGv+dzBUjxzHTF6bO?=
 =?iso-8859-1?Q?aO9TmE2fVCaCfkEEwzK0g0R+E2DrSzEpSFOLyhw85vc8N5NYNlMEvlmZqL?=
 =?iso-8859-1?Q?/7eVzEtIGZgvnbsMDbiYo7jutG7ibJL5WGWmrC3/c1rPESs6HpC9wfqonW?=
 =?iso-8859-1?Q?4VRYc9MhSXWNdbW7KeD1t7shXt7J8akCxpADg47PtYvFTGrxPQ+SaTKhtB?=
 =?iso-8859-1?Q?nkWhxO3ulfzcIV3y5EO7zJ/Pvqzqf6Ywl+GiejIs3353ozCDUFw0rb6fyM?=
 =?iso-8859-1?Q?bIGNhCkjwkyz+wF7TK6AY0h+zpK+GDPfGha2jJcGFEDUtOXon+bWWBu66C?=
 =?iso-8859-1?Q?FBW8pR2vOt9iPPrnnjvXkZ8kM0L74q4tVR1Jl4cymQ7ECVdzYe0IzuCizh?=
 =?iso-8859-1?Q?GIvf9SNG3RECw7oujBewpqPMKLARQhuSDQgF9orICU3o/b7SBU8PqOhOyA?=
 =?iso-8859-1?Q?2u5htbg4YlvkH/o1MQhyrhS/5j6qDyTBI2rOf9zEz4V7f8g5BRnw8ozaS4?=
 =?iso-8859-1?Q?iu7mnLYHN2LWP2E/wGamqMYqHcihXQXq6ulJZON339bmffxaI6a89IwuAV?=
 =?iso-8859-1?Q?UPiloQ2Up1cD1csUBZf2sVBOuEwLRQkKIFsmdXuEjBGU8cUUG2Ih4X2qHp?=
 =?iso-8859-1?Q?ddq/+ZFE7WESsFDZzbBTXzJFS5hyctwzx96umrrdXQ6dnGI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 027d8e26-d98a-4508-4258-08d92f14dbb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 09:14:48.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StlDkvJTr0CUlmLQCnywTRMnqz7Ia3YaAzXgrfFnlgnP29kXkYzPyP309jbUSekYYxCn0ZZIIF88JJkw5FtG5x/A45vRrBgVHiqgTflqSkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7134

Avoid concurrent associations between a user connection to a secure=0A=
service, blocked by an agent passphrase input request, and a starting=0A=
auto connection on a different service of the same interface.=0A=
=0A=
This issue happens when the end-user wants to connect to a new secure=0A=
Wifi network (W2) via an interface where another Wifi network (W1) is=0A=
already connected. When doing that, the following steps happen:=0A=
1. Disconnection of current network (W1).=0A=
2. User-connection to W2, held by the passphrase request.=0A=
3. Auto-connection to a known available Wifi network (W1) succeeding.=0A=
4. User-connection to W2, reactivated by the passphrase response,=0A=
failing, as another Wifi (W1) is already connected.=0A=
Wifi 2 will never be able, in this configuration, to connect.=0A=
---=0A=
 src/service.c | 25 +++++++++++++++++++++++++=0A=
 1 file changed, 25 insertions(+)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 20917a8923a4..f6a4e53fe262 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -49,6 +49,7 @@ static DBusConnection *connection =3D NULL;=0A=
 =0A=
 static GList *service_list =3D NULL;=0A=
 static GHashTable *service_hash =3D NULL;=0A=
+static GHashTable *passphrase_requested =3D NULL;=0A=
 static GSList *counter_list =3D NULL;=0A=
 static unsigned int autoconnect_id =3D 0;=0A=
 static unsigned int vpn_autoconnect_id =3D 0;=0A=
@@ -4209,6 +4210,7 @@ static bool auto_connect_service(GList *services,=0A=
 	bool ignore[MAX_CONNMAN_SERVICE_TYPES] =3D { };=0A=
 	bool autoconnecting =3D false;=0A=
 	GList *list;=0A=
+	int index;=0A=
 =0A=
 	DBG("preferred %d sessions %d reason %s", preferred, active_count,=0A=
 		reason2string(reason));=0A=
@@ -4230,6 +4232,11 @@ static bool auto_connect_service(GList *services,=0A=
 			continue;=0A=
 		}=0A=
 =0A=
+		index =3D __connman_service_get_index(service);=0A=
+		if (g_hash_table_lookup(passphrase_requested,=0A=
+					GINT_TO_POINTER(index)))=0A=
+			return true;=0A=
+=0A=
 		if (service->pending ||=0A=
 				is_connecting(service->state) ||=0A=
 				is_connected(service->state)) {=0A=
@@ -5780,6 +5787,7 @@ static void request_input_cb(struct connman_service *=
service,=0A=
 	struct connman_device *device;=0A=
 	const char *security;=0A=
 	int err =3D 0;=0A=
+	int index;=0A=
 =0A=
 	DBG("RequestInput return, %p", service);=0A=
 =0A=
@@ -5842,6 +5850,10 @@ static void request_input_cb(struct connman_service =
*service,=0A=
 		err =3D __connman_service_set_passphrase(service, passphrase);=0A=
 =0A=
  done:=0A=
+	index =3D __connman_service_get_index(service);=0A=
+	g_hash_table_remove(passphrase_requested,=0A=
+				GINT_TO_POINTER(index));=0A=
+=0A=
 	if (err >=3D 0) {=0A=
 		/* We forget any previous error. */=0A=
 		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);=0A=
@@ -6693,6 +6705,7 @@ static int service_connect(struct connman_service *se=
rvice)=0A=
 int __connman_service_connect(struct connman_service *service,=0A=
 			enum connman_service_connect_reason reason)=0A=
 {=0A=
+	int index;=0A=
 	int err;=0A=
 =0A=
 	DBG("service %p state %s connect reason %s -> %s",=0A=
@@ -6779,6 +6792,13 @@ int __connman_service_connect(struct connman_service=
 *service,=0A=
 			if (service->hidden && err !=3D -EINPROGRESS)=0A=
 				service->pending =3D pending;=0A=
 =0A=
+			if (err =3D=3D -EINPROGRESS) {=0A=
+				index =3D __connman_service_get_index(service);=0A=
+				g_hash_table_replace(passphrase_requested,=0A=
+						GINT_TO_POINTER(index),=0A=
+						GINT_TO_POINTER(true));=0A=
+			}=0A=
+=0A=
 			return err;=0A=
 		}=0A=
 	}=0A=
@@ -7750,6 +7770,8 @@ int __connman_service_init(void)=0A=
 	service_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,=0A=
 							NULL, service_free);=0A=
 =0A=
+	passphrase_requested =3D g_hash_table_new(g_direct_hash, g_direct_equal);=
=0A=
+=0A=
 	services_notify =3D g_new0(struct _services_notify, 1);=0A=
 	services_notify->remove =3D g_hash_table_new_full(g_str_hash,=0A=
 			g_str_equal, g_free, NULL);=0A=
@@ -7782,6 +7804,9 @@ void __connman_service_cleanup(void)=0A=
 	g_hash_table_destroy(service_hash);=0A=
 	service_hash =3D NULL;=0A=
 =0A=
+	g_hash_table_destroy(passphrase_requested);=0A=
+	passphrase_requested =3D NULL;=0A=
+=0A=
 	g_slist_free(counter_list);=0A=
 	counter_list =3D NULL;=0A=
 =0A=
-- =0A=
2.25.1=0A=
-------------------------------------------------------------------------=
=0A=
Hi Daniel,=0A=
=0A=
A reminder of the former thread:=0A=
=0A=
> Ah I see you dropped the file descriptor and now you just store a=0A=
> boolean. In this case you could just add a boolean variable called=0A=
> passphrase_requested to 'struct service' and you could drop the hash=0A=
> table completely. So this gets=0A=
> =0A=
>       service->passphrase_requested =3D true;=0A=
>=0A=
> and in auto_connect_servcie() a simple=0A=
> =0A=
>        if (service->passphrase_requested)=0A=
>               return true;=0A=
>=0A=
> is enough.=0A=
=0A=
These information are at interface level,=0A=
and shall be shared between all related services.=0A=
I doubt setting those at service side will solve the problem.=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
