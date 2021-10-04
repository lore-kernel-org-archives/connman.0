Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120071.outbound.protection.outlook.com [40.107.12.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A193FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 08:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApitUv50CFITq5SK5nk7GCIx3PtBy2Yt8Q0dWtuJ8Wl+rstySTlPFO9+BrLBFHA/chGvtOZ34dpHAyvaYyD6rN1rDoSAl475gaZIG716lOWA4MsF11A6ca0yj4DcYYZ0lj+eLK3VxWeuoZDIzZy+Q5T7iT4K3bBF9cDgYDhSp3w+kNrgmkAj7x2UCwYF9u+NSwbdHH5gM1OSVZ8Zg9kpzPJaQCyM181ngDxhpWqahWNuWKR5AVEbRjANdmIrbXRkQm9ZQd7DG1r/KQ6qKw9Rfziwxkigr/+i2oR2qyIrm14vLl9Kxfq4jlNHcJClzhTJXkptLAYZ5VRD3yllpt30NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBYGITAqIUtz4Q8sswZSpWleXDBqbBvmZxeV+MsTxAU=;
 b=nE5pdBSp8fQGv9QnbdayDRPGDJPn64i824k7txE98SR60IFFIMmOhGddscHQ5oj+Pv3FLczf/+VjE2SZrity8ZHJa4+FSdxmlG+sCmwyLmkBsYY+WSEUk368WzgWCDpOTkNgAtjWRicULF07wuVV2dreUIWmsFs2f8h10PQBVGJjW/cKheu09I7qS/rH6dHzTE8G8rc9am4Ibi45f9KC1d8MF2GbcHzT1hW4XLk4a8OMGH46OMcTNF8oV32KxC88rVexpW047Rr3poSwbCKeO/K9xoYgMKMhI3kO8j+CsNAiDYtWOq8YH8qubsK0DycLi2waPWDrEhmVsCQNJEaM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBYGITAqIUtz4Q8sswZSpWleXDBqbBvmZxeV+MsTxAU=;
 b=gIxntVhf+TTVQPr/2hOe7vAIDR67+pp6m6pOLGs+hDNXYhgoCveudFnDLaogqk085qNzG8UPN6hrvUGbVsgofnSjP3nkK04xGZWOidqFFwZKU/6IHuwsLQ9Sk0JL1juzcDnRahwns3hu9FDAy17iXMN2lbpAN/Vf5ACqVIsbhmo=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB3121.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.20; Mon, 4 Oct 2021 08:18:28 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 08:18:28 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 1/3] iwd: Scan hidden networks
Thread-Topic: [PATCH 1/3] iwd: Scan hidden networks
Thread-Index: AQHXttb22udP+HIkKU+24JHu2+bUZqvCaKQAgAAYSy0=
Date: Mon, 4 Oct 2021 08:18:27 +0000
Message-ID:
 <MRZP264MB154403ECD6C153C2492C665193AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB154441C6059B4972B76730FF93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211004064338.wcqkjiw5u2ywkbrb@beryllium.lan>
In-Reply-To: <20211004064338.wcqkjiw5u2ywkbrb@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: c29aa700-0c2e-c7ff-c03f-40f4f3638d06
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 316eb1ef-1ac4-4b89-89ce-08d9870f8b49
x-ms-traffictypediagnostic: MR1P264MB3121:
x-microsoft-antispam-prvs:
 <MR1P264MB312127CE754B6ECCF9DA91F993AE9@MR1P264MB3121.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sZGahcPjpzqr4SMoGOWnfqiWMCfyD6VOGjobPSLhESYqBsLgHnPP13khvvi7mk4P08VMtsy946ZKgm32U9sJpHpJKISY3jXspXMCzhn3c8b236deuHr72tAhXUvGgoIry3kPhzX3JQ54Mttcul4vrJOJkNOcJAns0isAoC+98V8ynvmHFdoWAs2NikzcrTaU+JwmESylUDfqsqO8nr1fXsJ9cM5tDlKEMEZXK00p7U/XopF2OVQlPKLy4n4vF/RklraIYIIl+GhOCN0/afeJL3rQpBuyB4AZH1src3z7D5GydZaj0KgkfQm7cY8/f7/hbtl2pNGlOPjYbfi4MKOXtX/iQM9LJbhoacyPwQzmMP2erkmU8krABIJoHFl8jmpUX1WEeiPhUg0ZGMxAg33V/j0G/PGZiKpMpx++D7GOGj7j0xvHSkbYSEfN6miyP9PbdnN2qFmFZ/4lQv2bLhnu/mHO0stVLo90Acv7aAJlPYzzzD0Qmz7XFtwfk3sCq1KeneORNHWE0a8Jj/OUGDKvhJ+BoEyrUbSsj1EkV+Q9DimbcoZ83oLclStBjGGdheuG7VHE6TXm05xPWGbwRu07lYWdRhpahteptfcH79gIz9GH8qJ1FqBGSZqD8qvaLM2ehnDKSwcajeAnghc69gTw7uC5BhQp9tN/uD39wxwzQZ1iSK01elzqyU94QgelBOK2gkFpe1GJvN1bV07b4hANDg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(38100700002)(33656002)(83380400001)(122000001)(186003)(52536014)(64756008)(66556008)(66476007)(8676002)(66446008)(8936002)(91956017)(7696005)(86362001)(316002)(9686003)(55016002)(76116006)(4326008)(38070700005)(71200400001)(6506007)(66946007)(6916009)(508600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WkQjajX+EYBFcCdbZwsP3UJvRzd6j+cr92mf+O4m4jlTHSk5Xj0h3xCEEw?=
 =?iso-8859-1?Q?/cyY1EDKBmtkF8zrrLYUsUrqoHA1qsI1HMSPNMr9gw34wfvi1qONoudEh6?=
 =?iso-8859-1?Q?EpcBF49niriMaFp0yTGyABh6m3cJ/6dq910+Otax3HkItrVid+gZd7jeuC?=
 =?iso-8859-1?Q?BDvEHFUdHWyJGhEQDt5T5a+xLDQ5Qjzgw8Y07hw1Evyld54oJLGIYEubWB?=
 =?iso-8859-1?Q?oiEfo+Sy1wdYE9D4K3aQ60k0SJqBCzHrQV+DT62jCrQDmU+68MAkgob+F7?=
 =?iso-8859-1?Q?YWi9M/qb2iP8EbwH2HHJz7iWcg1Jljx4dLRbtMX7VPilkw5GutXuM8o285?=
 =?iso-8859-1?Q?HbPQftRh2XsN2OsyyKf1lFwA8OqG+8HNECMkZF8xAkTgVZIFwe+Wrsjpok?=
 =?iso-8859-1?Q?/zG9YKJVYRDCsjWo8nhzBgK4Mo1OCLSI/MxmJNKEXcY+bPg23jiYz/GoZ8?=
 =?iso-8859-1?Q?APQSgsYMYNsLVEMsLJTVHMUtoVB8DC7GXRgzv73qvEcQ3voKMTMpjP339f?=
 =?iso-8859-1?Q?tpDYt1JY58SCSun508xYFkzJuki/tlwUlKxs8j6kacHhEJ5mPb5W9o+K+B?=
 =?iso-8859-1?Q?3UYKZKz5CeUs2cstdkdNpCmxfhokC4rwidLhjoqarLCHNysAATlcBbgJt/?=
 =?iso-8859-1?Q?Rwha1jaH9kyFdswyJJJg/kW7g5sajMpoc1iiuapglNv+5KoCr5UgubEwhC?=
 =?iso-8859-1?Q?EC3rVJGP2D+KFf2bpWnhK2H9ODk2mmfpKolKiF25kaHWCiFDfI4Fvxb16K?=
 =?iso-8859-1?Q?sOF29BDkpV5GfaJhZGGtsU7YgV/+WErkPdFsTgy5mGjQplYO0amteUl+5J?=
 =?iso-8859-1?Q?w4G+2ii8XrkQ7Rj71MgSkLHhyMOWvuXMboI5mqkEgVPiWzRCHqbDsgU8wv?=
 =?iso-8859-1?Q?8bnkG0ICtkSlk0Ihle+AGSa9K7fWC4yvaD6c7ikANciFlxKWjMj/Ke1R5c?=
 =?iso-8859-1?Q?jG3M00TarpUWlzgcdWwoJWgt6vjFSlfo1AFJUkftePP0yciSm3yALudAqX?=
 =?iso-8859-1?Q?/B/uu64jDwBq9Nql6LXZtbkuAu7IpvFmfWkvJOXomJnYlPMfpK69vFI6BP?=
 =?iso-8859-1?Q?CK3Hvqv/4B3YPPVVy8mP7IMJWH+oONYNPwRBzV8IDBH+gidsYhfckuMywc?=
 =?iso-8859-1?Q?iWc2bTD5LeqVSukpyc2UUFVsTRpOGPANx4dxRRYB2XZaaJenQPwIojpzLs?=
 =?iso-8859-1?Q?c4Gcrz9XmTTFEX2qaZUtGKN+ODPrImE2SChjcGvwDlX2UFVo2EW5s3sPv/?=
 =?iso-8859-1?Q?0WzJtRHk4YKoKL9GralwU2eIcSUbAClJbiSKSZsJzpAsl2LyxM1DaNkiki?=
 =?iso-8859-1?Q?8tuNyNw2JEjGInIzv91/I0HYznfc+lZtccZXBD3KxUoBUxE+zDjEIHEWRw?=
 =?iso-8859-1?Q?qPVCZ7Cw0uU5gB210BxQZTz6NEs5+9+kqzKsHcxjAsEi3QeIPsr4I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 316eb1ef-1ac4-4b89-89ce-08d9870f8b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 08:18:27.9941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YDVz/vbSjv4CRTPS8y3kDI+CgcP+/oWqv/vMpbuaEas2BEKWHi39hjZ2W8LUitKiCN0na+6qvY6Qa0UanpbeuNp9yHNEOqTQ463klMQvw6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3121

Only visible networks were retrieved by a scan, via GetOrderedNetworks()=0A=
iwd function. A call to GetHiddenAccessPoints() is necessary to=0A=
retrieve the hidden ones.=0A=
---=0A=
=A0plugins/iwd.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++-=
=0A=
=A01 file changed, 140 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index ec9a4574cf2d..0f2b638caceb 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -113,12 +113,22 @@ struct iwd_known_network {=0A=
=A0	bool autoconnect;=0A=
=A0};=0A=
=A0=0A=
+struct iwd_hidden_ap {=0A=
+	char *path;=0A=
+	char *device;=0A=
+	char *address;=0A=
+	char *type;=0A=
+	int16_t signal_strength;=0A=
+};=0A=
+=0A=
=A0struct iwd_station {=0A=
=A0	GDBusProxy *proxy;=0A=
=A0	char *path;=0A=
=A0	char *state;=0A=
=A0	char *connected_network;=0A=
=A0	bool scanning;=0A=
+=0A=
+	GHashTable *hidden_aps;=0A=
=A0};=0A=
=A0=0A=
=A0struct iwd_ap {=0A=
@@ -926,7 +936,8 @@ static void add_network(const char *path, struct iwd_ne=
twork *iwdn)=0A=
=A0	connman_network_set_data(iwdn->network, iwdn);=0A=
=A0=0A=
=A0	connman_network_set_name(iwdn->network, iwdn->name);=0A=
-	connman_network_set_blob(iwdn->network, "WiFi.SSID", iwdn->name,=0A=
+	if (iwdn->name)=0A=
+		connman_network_set_blob(iwdn->network, "WiFi.SSID", iwdn->name,=0A=
=A0					strlen(iwdn->name));=0A=
=A0	connman_network_set_string(iwdn->network, "WiFi.Security",=0A=
=A0					security_remap(iwdn->type));=0A=
@@ -1189,6 +1200,113 @@ static void update_signal_strength(struct iwd_stati=
on *iwds)=0A=
=A0		DBG("GetOrderedNetworks() failed");=0A=
=A0}=0A=
=A0=0A=
+static void create_hidden_network(struct iwd_hidden_ap *iwdh)=0A=
+{=0A=
+	struct iwd_network *iwdn;=0A=
+=0A=
+	iwdn =3D g_new0(struct iwd_network, 1);=0A=
+	if (!iwdn) {=0A=
+		connman_error("Out of memory creating IWD network");=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	iwdn->proxy =3D NULL;=0A=
+	iwdn->path =3D g_strdup(iwdh->path);=0A=
+	iwdn->device =3D g_strdup(iwdh->device);=0A=
+	iwdn->name =3D NULL;=0A=
+	iwdn->type =3D g_strdup(iwdh->type);=0A=
+	iwdn->connected =3D false;=0A=
+	iwdn->known_network =3D NULL;=0A=
+=0A=
+	DBG("device %s type %s",=0A=
+		iwdn->device, iwdn->type);=0A=
+=0A=
+	g_hash_table_replace(networks, iwdn->path, iwdn);=0A=
+=0A=
+	add_network(iwdn->path, iwdn);=0A=
+=0A=
+	_update_signal_strength(iwdn->path, iwdh->signal_strength);=0A=
+}=0A=
+=0A=
+static void create_hidden_ap(char *path, DBusMessageIter *array)=0A=
+{=0A=
+	struct iwd_hidden_ap *iwdh;=0A=
+	const char *address, *type;=0A=
+	struct iwd_station *iwds;=0A=
+	int16_t signal_strength;=0A=
+	DBusMessageIter value;=0A=
+=0A=
+	dbus_message_iter_recurse(array, &value);=0A=
+=0A=
+	dbus_message_iter_get_basic(&value, &address);=0A=
+=0A=
+	dbus_message_iter_next(&value);=0A=
+	dbus_message_iter_get_basic(&value, &signal_strength);=0A=
+=0A=
+	dbus_message_iter_next(&value);=0A=
+	dbus_message_iter_get_basic(&value, &type);=0A=
+=0A=
+	dbus_message_iter_next(array);=0A=
+=0A=
+	DBG("device '%s' address '%s' type %s signal_strength %d",=0A=
+		path, address, type, signal_strength);=0A=
+=0A=
+	iwds =3D g_hash_table_lookup(stations, path);=0A=
+	if (!iwds) {=0A=
+		connman_error("Related IWD station not found %s", path);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	iwdh =3D g_new0(struct iwd_hidden_ap, 1);=0A=
+	if (!iwdh) {=0A=
+		connman_error("Out of memory creating IWD hidden ap");=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	iwdh->device =3D g_strdup(path);=0A=
+	iwdh->type =3D g_strdup(type);=0A=
+	iwdh->path =3D g_strdup_printf("%s/hidden_%s", iwdh->device, iwdh->type);=
=0A=
+	iwdh->address =3D g_strdup(address);=0A=
+	iwdh->signal_strength =3D signal_strength;=0A=
+=0A=
+	g_hash_table_replace(iwds->hidden_aps, iwdh->path, iwdh);=0A=
+=0A=
+	create_hidden_network(iwdh);=0A=
+}=0A=
+=0A=
+static void hidden_access_points_cb(DBusMessage *message, void *user_data)=
=0A=
+{=0A=
+	DBusMessageIter array, entry;=0A=
+	struct iwd_station *iwds;=0A=
+	char *path =3D user_data;=0A=
+=0A=
+	DBG("");=0A=
+=0A=
+	if (!dbus_message_iter_init(message, &array))=0A=
+		return;=0A=
+=0A=
+	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)=0A=
+		return;=0A=
+=0A=
+	iwds =3D g_hash_table_lookup(stations, path);=0A=
+	if (iwds)=0A=
+		g_hash_table_remove_all(iwds->hidden_aps);=0A=
+=0A=
+	dbus_message_iter_recurse(&array, &entry);=0A=
+	while (dbus_message_iter_get_arg_type(&entry) =3D=3D DBUS_TYPE_STRUCT) {=
=0A=
+		create_hidden_ap(path, &entry);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void update_hidden_networks(struct iwd_station *iwds)=0A=
+{=0A=
+	if (!g_dbus_proxy_method_call(iwds->proxy,=0A=
+					"GetHiddenAccessPoints",=0A=
+					NULL, hidden_access_points_cb,=0A=
+					g_strdup(iwds->path), g_free))=0A=
+		DBG("GetHiddenAccessPoints() failed");=0A=
+}=0A=
+=0A=
=A0static void station_property_change(GDBusProxy *proxy, const char *name,=
=0A=
=A0		DBusMessageIter *iter, void *user_data)=0A=
=A0{=0A=
@@ -1234,6 +1352,7 @@ static void station_property_change(GDBusProxy *proxy=
, const char *name,=0A=
=A0					CONNMAN_SERVICE_TYPE_WIFI, true);=0A=
=A0		} else {=0A=
=A0			update_signal_strength(iwds);=0A=
+			update_hidden_networks(iwds);=0A=
=A0		}=0A=
=A0=0A=
=A0=0A=
@@ -1354,9 +1473,26 @@ static void station_free(gpointer data)=0A=
=A0	}=0A=
=A0	g_free(iwds->path);=0A=
=A0	g_free(iwds->connected_network);=0A=
+	g_hash_table_destroy(iwds->hidden_aps);=0A=
=A0	g_free(iwds);=0A=
=A0}=0A=
=A0=0A=
+static void hidden_ap_free(gpointer data)=0A=
+{=0A=
+	struct iwd_hidden_ap *iwdh =3D data;=0A=
+	struct iwd_network *iwdn;=0A=
+=0A=
+	iwdn =3D g_hash_table_lookup(networks, iwdh->path);=0A=
+	if (iwdn)=0A=
+		remove_network(iwdn);=0A=
+=0A=
+	g_free(iwdh->path);=0A=
+	g_free(iwdh->device);=0A=
+	g_free(iwdh->address);=0A=
+	g_free(iwdh->type);=0A=
+	g_free(iwdh);=0A=
+}=0A=
+=0A=
=A0static void ap_free(gpointer data)=0A=
=A0{=0A=
=A0	struct iwd_ap *iwdap =3D data;=0A=
@@ -1717,6 +1853,9 @@ static void create_station(GDBusProxy *proxy)=0A=
=A0	iwds->connected_network =3D g_strdup(proxy_get_string(proxy, "Connected=
Network"));=0A=
=A0	iwds->scanning =3D proxy_get_bool(proxy, "Scanning");=0A=
=A0=0A=
+	iwds->hidden_aps =3D g_hash_table_new_full(g_str_hash, g_str_equal, NULL,=
=0A=
+			hidden_ap_free);=0A=
+=0A=
=A0	DBG("state '%s' connected_network %s scanning %d",=0A=
=A0		iwds->state, iwds->connected_network, iwds->scanning);=0A=
=A0=0A=
-- =0A=
2.25.1=0A=
=0A=
---------------------------------------------------------------------------=
-------------------------=0A=
> Thanks for the feature. The patch looks pretty good. Just a minor nitpick=
 for=0A=
> this and the other 2 patches.=0A=
Great.=0A=
=0A=
> Just use g_new0(). There is no use to try to work around small memory=0A=
> allocation failures. First they are very likely never to be observed and=
=0A=
> if they do our failure path is not tested. Even more...=0A=
I have fixed it in the patch, but a cleanup of the former sources of iwd.c=
=0A=
is probably still necessary.=0A=
=0A=
Emmanuel=
