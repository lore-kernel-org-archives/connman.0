Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120077.outbound.protection.outlook.com [40.107.12.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B8A29CA
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 09:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP9rdJk5kxo/Pv1HiDYpIkoK2MER8DHYSteYD4r45Wg8hYTpNYT01Qm+ZzwjIdEcWmlh3WSKOltqOLpQYyv4aFFQ7008AI4fS9SngFZOBgV7A/eBcK2WOV/mpeTAun7T1axiqPB4hwQjAMCQCfA+cYdurbzIT97ABaUtWuImzlh2Ma3b4zjbetoiZinmur1ZjTL/bH7pmQ3a2t29alDKFW/k+tviAP8FlOZl+uz45NJsQCsQmeL5YAf6UH5rAV+pl1KAT/UgTyBd1ZNMj2DZioPkJr5ShzBFLIHzEcqI37I/Ti05GDa/0dXS54wY/7bFm+uy/oY4t8gfTAbdlMWvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ9Trm6Rnj1jGDmm3iBmerv1fEmRc4u4yStdBBhLMDo=;
 b=jlwIa1eruA9WS+GXBTzMDobRvnWl9dIIS4qeVSPRpKIWIkMyCePg1/Iy4YF1dXxesSohF6/vvKTFXpczVGKUEc+pWOpIKT0fz0cNkpwcJ5EtHoHVuBRz3Cs5yB0eFfkDFNPYtiYjoKM4uTj8zMO8enu/oQD8/46+VUblaaYgWEmTeXViVj87EbNWusd/GpThVYGpn6R2UsAn2yekp7ssfsMZfGa+8jztmOxYW82HDPlU++RkAFGUB6BkfOKQ98SQw1XEIXoDcU3lfFaj8nZ0kh/1KbIMob6DDouCirXYEViXLegw0a81XoTkKMhA0MagfZ/8TDD/sMKaDSU1pvN8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ9Trm6Rnj1jGDmm3iBmerv1fEmRc4u4yStdBBhLMDo=;
 b=Iq0UBKeQ6053/sNbXbkCa9XuAZ7HTwSE25X4iFKsMAxbe5SJUWs32rj8kKG/AkATuRqziptkaDKXxqBQwXY8luOn86TaMY8LxXl2Ke0qOk8vR+sDApx/X5rGFMNHC2sDYJO069eeHZAyMAe2Y8YIXlyn6emCfneCXX04g2vbtlg=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Mon, 4 Oct 2021 09:10:47 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 09:10:47 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 2/3] iwd: Connection of hidden networks
Thread-Topic: [PATCH 2/3] iwd: Connection of hidden networks
Thread-Index: AQHXtti10gxY7PlzJkSp8WEWjZ8UV6vCbhsAgAAYHcw=
Date: Mon, 4 Oct 2021 09:10:47 +0000
Message-ID:
 <MRZP264MB1544E27898924DAB6CBBF9E793AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB1544676D5E67A464DCECB27493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211004070314.ehj6a5wjkhexu4xb@beryllium.lan>
In-Reply-To: <20211004070314.ehj6a5wjkhexu4xb@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 8e8cb205-4c49-e4cb-c1da-f6d70054f5b0
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 765475b9-7ebd-495d-2f6f-08d98716da5c
x-ms-traffictypediagnostic: MR1P264MB2980:
x-microsoft-antispam-prvs:
 <MR1P264MB29806F4B339C55EE2922E50F93AE9@MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:138;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A88HZOyGDrx6pw4ufmfzlCN5CZwZ0QaS1kcoydT3HieK5CQc2WvJKUcgr3dRO265rr2zovG701idd7UgMcz7wV7ktuGfwzRn912zW1LkzFFrq6/JTPMQTpC3pW1Z2Po/a8IuZpMTMrazxDOFf2g+Nj+XOIOxXbg2fEE3Wzy5B7rS2I3gHtGUU5QqLKhCSyZkNNwMjsxxElcQXaMFVVdx0gd9+GfpPl27ZJGX+hnz78L6HelYPZSJOdMXXMey599Rhb3KVzyTFkQfL/uafVtVcI99iCKTGorgVtjxrf0PysvQPZnVJfi12FhiA7V4H7xQVHL8JZvV1kJyLfDX9Eo2Eu17bfBtxQTzKgxFj3zTDy03XdXgSrtPtKys6/i6n/jL/UCvj06jEWy0a0iCEhvrgHh/w1NkwtGwF1eMq0FPNASIyJAghucBLIXBXtWaU1lnbtLrHu3fM6+9ncMtnaE7Jf/ylN5GtjEj9AYPYEZVNLkvCKDc9YbMfN+bc2sCEGUhyK+WmyeOpS89MlNpaISxh+AwkuavFRsvBUJM89Iua/VvOFTXlX1JmMlaLHseHcX6nrkqXzOviiFfSviqXQqjta4xzZhV52aCKIWCQtC4snZBrbRTFhs8px+jCk1K+NSKrgXk7DLL1uZ2k3qBuQQyigBAW3zR1Rlb3G0izeOdJmlSIDN78GNyv0FVXnqRps0e8uMuJ+StrsrFogE3OPQ33A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(508600001)(8676002)(86362001)(6506007)(52536014)(6916009)(5660300002)(33656002)(71200400001)(66446008)(64756008)(186003)(9686003)(66556008)(66476007)(7696005)(83380400001)(76116006)(91956017)(122000001)(55016002)(8936002)(66946007)(316002)(4326008)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FmWpR5pCkPtRKlWApxpTUo1vGUJNyIR1KcbQ1R2pLPnnpfI9BIH6psKREJ?=
 =?iso-8859-1?Q?YWfSF/wynwT8oYpMiuZ6LmdU8q91txQhSBvrVs9y4R3wAjhcKYsqPz6PHp?=
 =?iso-8859-1?Q?WabIqVC3hSa/7aoFNld8qNQHM00zyvpXgcSqJkb4bozm8mfnf2nwKmUfCk?=
 =?iso-8859-1?Q?GfOzZjkA1RVAgvVNXse2GN/bsfItbERLWLj7oGjhAT22YGu6CanGuqhxNd?=
 =?iso-8859-1?Q?LJJ8GtChiS9yequNkSVhB/i8mmlL5p3RGl+gwxFQYaMxoBbhlTL842cT+O?=
 =?iso-8859-1?Q?4QujKvxL0FMq3+wYaMyg9SDlnW5Q2gTe5Bwrwg/40+hm/meWIOdLqOoQG/?=
 =?iso-8859-1?Q?Fs1A8UFPVAPgdE/c3eHmrHbrG+PaOSHESLAxdoDhg7DdLRlA8B+HRdLI10?=
 =?iso-8859-1?Q?vF9sIf0d0qEMUKG+SSNN+/UQXlkUYmiLyjnYhacT8VfY/bSbMarkk01vzd?=
 =?iso-8859-1?Q?Bctj2sjfXJeTwSGx49ErLF4QHxFH4rG0yJAnvmeM7gkZbxy61fjvN2km51?=
 =?iso-8859-1?Q?qPcZI3nwWsccqmeQnNVP89BW3znIk0iBrk2yd6prHIUUXXENOqU8N8/ycU?=
 =?iso-8859-1?Q?tP5cvFZF/xnVSnaCcTTyGQYNe1Qc0BViYuMKhhwVeLgwx1edQk4iXhUjuq?=
 =?iso-8859-1?Q?E1++MpZSfX1Y6rzZdZDiKFz3W3vEx+a9BrbLeeGBMP9aND569f/E/tNGsI?=
 =?iso-8859-1?Q?UoVDPuJmFZmA1qX0UBaIkjYOdgBrVE4m6qdgGckGbS5RuI40qIAFMDzWz8?=
 =?iso-8859-1?Q?aJ/cr2U5WGnMYEEVK1KGMVTknwQFd3kkU5idtS0EDNiGtfJGdqFlvum3dC?=
 =?iso-8859-1?Q?+RbvM3y+r4lhdKMXiIc7STtatE8kncyJSSiYAfZ16nQKJZwHxH4wVbY4zr?=
 =?iso-8859-1?Q?nFSX8bb/imHEqtYzG6SF0Pwn3Y2hmqoDcbThH1xGHVjd+nc1EPGBIxhWNt?=
 =?iso-8859-1?Q?Zu/8CeU0ahvVKRn+eqL61yCSS9DyMQETEjc9OmRyZyPCGp8dyPMjUQogon?=
 =?iso-8859-1?Q?FcirYi+gBxf1zWMUGdh9tXOwyrXZ4MlJbyHUSDXfRTLWkDgrXT7xBUhO+r?=
 =?iso-8859-1?Q?O6aiaMmFXL5pt5wQaxdgbdBDXc4ulZymITz0qRC4SciEu4pxB7VtGhWyru?=
 =?iso-8859-1?Q?8fp3S4tAahQFd94eQTRxQ+ywO6BPFvYLsbRnGMLDxzRpP2WCp6BSs0Z1ex?=
 =?iso-8859-1?Q?9zVHgzSLfGZZgxqdWB1D9oUbBxHTHWaPR/W1sWY31ecOl/19u/pvdP01bF?=
 =?iso-8859-1?Q?WrKVHklgAHBxgAMIXNR2h3z91aPEQsTAU2o3RhtFTfDUmXevT3FSMQIp9U?=
 =?iso-8859-1?Q?GPGR8dsl1ZyJ06SIbIj73oB7hkzvIk07SStR4V2HB/dNNt+6LU6FRlU2zZ?=
 =?iso-8859-1?Q?uFL6YdYujxF6yX14AOd4LQIdAaXHrhH13bFiD1jSJCxfolhhkozik=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 765475b9-7ebd-495d-2f6f-08d98716da5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 09:10:47.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ie+XIDVE+m9Xpn9BedeJUQBq6qB3KHgFTwvcLkFJ3KZ6QrQDuN9ZPRRhob+7u/rPVu2gSlKBkrtgPCDEPcoiL+ZMpBY14P/D+IlPVyI6hgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2980

Implementation of hidden networks connection.=0A=
---=0A=
 plugins/iwd.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 206 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index 0f2b638caceb..4d009c3515a8 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -121,6 +121,17 @@ struct iwd_hidden_ap {=0A=
 	int16_t signal_strength;=0A=
 };=0A=
 =0A=
+struct hidden_params {=0A=
+	char* ssid;=0A=
+	unsigned int ssid_len;=0A=
+	char *identity;=0A=
+	char *passphrase;=0A=
+	char *security;=0A=
+	gpointer user_data;=0A=
+	char *station_path;=0A=
+	char *network_path;=0A=
+};=0A=
+=0A=
 struct iwd_station {=0A=
 	GDBusProxy *proxy;=0A=
 	char *path;=0A=
@@ -129,6 +140,8 @@ struct iwd_station {=0A=
 	bool scanning;=0A=
 =0A=
 	GHashTable *hidden_aps;=0A=
+	struct hidden_params *hidden;=0A=
+	bool postpone_hidden;=0A=
 };=0A=
 =0A=
 struct iwd_ap {=0A=
@@ -560,6 +573,79 @@ static int cm_device_disable(struct connman_device *de=
vice)=0A=
 	return set_device_powered(device, false);=0A=
 }=0A=
 =0A=
+static void hidden_network_connect_append(DBusMessageIter *iter,=0A=
+		void *user_data)=0A=
+{=0A=
+	struct hidden_params *hidden =3D user_data;=0A=
+=0A=
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &hidden->ssid);=0A=
+}=0A=
+=0A=
+static void update_signal_strength(struct iwd_station *iwds);=0A=
+static void cm_hidden_network_connect_cb(DBusMessage *message, void *user_=
data)=0A=
+{=0A=
+	struct hidden_params *hidden =3D user_data;=0A=
+	struct iwd_network *iwdn =3D NULL;=0A=
+	struct iwd_station *iwds;=0A=
+	const char *dbus_error;=0A=
+=0A=
+	if (!hidden)=0A=
+		return;=0A=
+=0A=
+	iwds =3D g_hash_table_lookup(stations, hidden->station_path);=0A=
+	if (!iwds)=0A=
+		return;=0A=
+=0A=
+	iwds->hidden =3D NULL;=0A=
+=0A=
+	if (hidden->network_path)=0A=
+		iwdn =3D g_hash_table_lookup(networks, hidden->network_path);=0A=
+=0A=
+	if (dbus_message_get_type(message) !=3D DBUS_MESSAGE_TYPE_ERROR) {=0A=
+		if (iwdn) {=0A=
+			update_network_connected(iwdn);=0A=
+			update_signal_strength(iwds);=0A=
+		}=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	dbus_error =3D dbus_message_get_error_name(message);=0A=
+	if (!strcmp(dbus_error, "net.connman.iwd.InProgress") ||=0A=
+		!strcmp(dbus_error, "net.connman.iwd.AlreadyProvisioned"))=0A=
+		return;=0A=
+=0A=
+	DBG("Hidden connection failed for station %s: %s",=0A=
+		hidden->station_path,=0A=
+		dbus_error);=0A=
+=0A=
+	if (!iwdn) {=0A=
+		connman_error("Hidden network not found for station %s",=0A=
+			hidden->station_path);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (!strcmp(dbus_error, "net.connman.iwd.Failed"))=0A=
+		connman_network_set_error(iwdn->network,=0A=
+				CONNMAN_NETWORK_ERROR_INVALID_KEY);=0A=
+	else if (!iwdn->autoconnect)=0A=
+		connman_network_set_error(iwdn->network,=0A=
+				CONNMAN_NETWORK_ERROR_CONNECT_FAIL);=0A=
+}=0A=
+=0A=
+static void hidden_params_free(gpointer data)=0A=
+{=0A=
+	struct hidden_params *hidden =3D data;=0A=
+=0A=
+	g_free(hidden->ssid);=0A=
+	g_free(hidden->identity);=0A=
+	g_free(hidden->passphrase);=0A=
+	g_free(hidden->security);=0A=
+	connman_network_clear_hidden(hidden->user_data);=0A=
+	g_free(hidden->station_path);=0A=
+	g_free(hidden->network_path);=0A=
+	g_free(hidden);=0A=
+}=0A=
+=0A=
 static void cm_device_scan_cb(DBusMessage *message, void *user_data)=0A=
 {=0A=
 	const char *path =3D user_data;=0A=
@@ -574,6 +660,23 @@ static void cm_device_scan_cb(DBusMessage *message, vo=
id *user_data)=0A=
 =0A=
 		DBG("%s scan failed: %s", path, dbus_error);=0A=
 	}=0A=
+=0A=
+	if (!iwds->hidden)=0A=
+		return;=0A=
+=0A=
+	if (!iwds->postpone_hidden) {=0A=
+		hidden_params_free(iwds->hidden);=0A=
+		iwds->hidden =3D NULL;=0A=
+	} else {=0A=
+		iwds->postpone_hidden =3D false;=0A=
+		if (!g_dbus_proxy_method_call(iwds->proxy,=0A=
+				"ConnectHiddenNetwork",=0A=
+				hidden_network_connect_append,=0A=
+				cm_hidden_network_connect_cb,=0A=
+				iwds->hidden, hidden_params_free)) {=0A=
+			iwds->hidden =3D NULL;=0A=
+		}=0A=
+	}=0A=
 }=0A=
 =0A=
 static int cm_device_scan(struct connman_device *device,=0A=
@@ -581,19 +684,72 @@ static int cm_device_scan(struct connman_device *devi=
ce,=0A=
 {=0A=
 	struct iwd_device *iwdd =3D connman_device_get_data(device);=0A=
 	struct iwd_station *iwds;=0A=
+	bool scanning;=0A=
+=0A=
+	if (!iwdd)=0A=
+		return -ENODEV;=0A=
 =0A=
 	if (strcmp(iwdd->mode, "station"))=0A=
 		return -EINVAL;=0A=
 =0A=
+	scanning =3D connman_device_get_scanning(device,=0A=
+		CONNMAN_SERVICE_TYPE_WIFI);=0A=
+=0A=
 	iwds =3D g_hash_table_lookup(stations, iwdd->path);=0A=
 	if (!iwds)=0A=
 		return -EIO;=0A=
 =0A=
-	if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",=0A=
+	if (!params->ssid || params->ssid_len =3D=3D 0 || params->ssid_len > 32) =
{=0A=
+		if (scanning)=0A=
+			return -EALREADY;=0A=
+=0A=
+		if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",=0A=
 			NULL, cm_device_scan_cb, g_strdup(iwds->path), g_free))=0A=
-		return -EIO;=0A=
+			return -EIO;=0A=
 =0A=
-	return -EINPROGRESS;=0A=
+		return -EINPROGRESS;=0A=
+	} else {=0A=
+		struct hidden_params *hidden;=0A=
+=0A=
+		if (scanning && iwds->hidden && iwds->postpone_hidden)=0A=
+			return -EALREADY;=0A=
+=0A=
+		hidden =3D g_new0(struct hidden_params, 1);=0A=
+		if (!hidden)=0A=
+			return -ENOMEM;=0A=
+=0A=
+		if (iwds->hidden) {=0A=
+			hidden_params_free(iwds->hidden);=0A=
+			iwds->hidden =3D NULL;=0A=
+		}=0A=
+=0A=
+		hidden->ssid =3D g_strndup (params->ssid, params->ssid_len);=0A=
+		hidden->ssid_len =3D params->ssid_len;=0A=
+		hidden->identity =3D g_strdup(params->identity);=0A=
+		hidden->passphrase =3D g_strdup(params->passphrase);=0A=
+		hidden->security =3D g_strdup(params->security);=0A=
+		hidden->user_data =3D params->user_data;=0A=
+		hidden->station_path =3D g_strdup(iwds->path);=0A=
+		iwds->hidden =3D hidden;=0A=
+=0A=
+		if (scanning) {=0A=
+			/* Let's keep this active scan for later,=0A=
+			 * when current scan will be over. */=0A=
+			iwds->postpone_hidden =3D true;=0A=
+=0A=
+			return 0;=0A=
+		}=0A=
+=0A=
+		if (!g_dbus_proxy_method_call(iwds->proxy,=0A=
+				"ConnectHiddenNetwork",=0A=
+				hidden_network_connect_append,=0A=
+				cm_hidden_network_connect_cb,=0A=
+				hidden, hidden_params_free)) {=0A=
+			iwds->hidden =3D NULL;=0A=
+			return -EIO;=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
 }=0A=
 =0A=
 static struct connman_device_driver device_driver =3D {=0A=
@@ -917,7 +1073,10 @@ static char *create_identifier(const char *path, cons=
t char *security)=0A=
 =0A=
 static void add_network(const char *path, struct iwd_network *iwdn)=0A=
 {=0A=
+	unsigned int ssid_len =3D 0;=0A=
+	struct iwd_station *iwds;=0A=
 	struct iwd_device *iwdd;=0A=
+	const char *security;=0A=
 	char *identifier;=0A=
 	int index;=0A=
 =0A=
@@ -926,33 +1085,56 @@ static void add_network(const char *path, struct iwd=
_network *iwdn)=0A=
 		return;=0A=
 =0A=
 	identifier =3D create_identifier(path, iwdn->type);=0A=
-	iwdn->network =3D connman_network_create(identifier,=0A=
+	iwdn->network =3D connman_device_get_network(iwdd->device, identifier);=
=0A=
+	if (!iwdn->network) {=0A=
+		iwdn->network =3D connman_network_create(identifier,=0A=
 					CONNMAN_NETWORK_TYPE_WIFI);=0A=
 =0A=
-	index =3D connman_inet_ifindex(iwdd->name);=0A=
-	if (index >=3D 0)=0A=
-		connman_network_set_index(iwdn->network, index);=0A=
+		index =3D connman_inet_ifindex(iwdd->name);=0A=
+		if (index >=3D 0)=0A=
+			connman_network_set_index(iwdn->network, index);=0A=
 =0A=
-	connman_network_set_data(iwdn->network, iwdn);=0A=
+		connman_network_set_data(iwdn->network, iwdn);=0A=
+=0A=
+		if (connman_device_add_network(iwdd->device, iwdn->network) < 0) {=0A=
+			connman_network_unref(iwdn->network);=0A=
+			iwdn->network =3D NULL;=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
 =0A=
 	connman_network_set_name(iwdn->network, iwdn->name);=0A=
-	if (iwdn->name)=0A=
+	if (iwdn->name) {=0A=
+		ssid_len =3D strlen(iwdn->name);=0A=
 		connman_network_set_blob(iwdn->network, "WiFi.SSID", iwdn->name,=0A=
-					strlen(iwdn->name));=0A=
+					ssid_len);=0A=
+	}=0A=
+=0A=
+	security =3D security_remap(iwdn->type);=0A=
 	connman_network_set_string(iwdn->network, "WiFi.Security",=0A=
-					security_remap(iwdn->type));=0A=
+					security);=0A=
 	connman_network_set_string(iwdn->network, "WiFi.Mode", "managed");=0A=
-=0A=
-	if (connman_device_add_network(iwdd->device, iwdn->network) < 0) {=0A=
-		connman_network_unref(iwdn->network);=0A=
-		iwdn->network =3D NULL;=0A=
-		return;=0A=
-	}=0A=
 	iwdn->iwdd =3D iwdd;=0A=
 =0A=
 	connman_network_set_available(iwdn->network, true);=0A=
 	connman_network_set_group(iwdn->network, identifier);=0A=
 =0A=
+	iwds =3D g_hash_table_lookup(stations, iwdn->iwdd->path);=0A=
+	if (iwds && iwds->hidden &&=0A=
+			!g_strcmp0(iwds->hidden->security, security) &&=0A=
+			iwds->hidden->ssid && iwdn->name &&=0A=
+			iwds->hidden->ssid_len =3D=3D ssid_len &&=0A=
+			!memcmp(iwds->hidden->ssid, iwdn->name, ssid_len)) {=0A=
+		connman_network_set_associating(iwdn->network, true);=0A=
+=0A=
+		iwds->hidden->network_path =3D g_strdup(iwdn->path);=0A=
+		connman_network_connect_hidden(iwdn->network,=0A=
+				iwds->hidden->identity,=0A=
+				iwds->hidden->passphrase,=0A=
+				iwds->hidden->user_data);=0A=
+		iwds->hidden->user_data =3D NULL;=0A=
+	}=0A=
+=0A=
 	g_free(identifier);=0A=
 }=0A=
 =0A=
@@ -1352,7 +1534,9 @@ static void station_property_change(GDBusProxy *proxy=
, const char *name,=0A=
 					CONNMAN_SERVICE_TYPE_WIFI, true);=0A=
 		} else {=0A=
 			update_signal_strength(iwds);=0A=
-			update_hidden_networks(iwds);=0A=
+=0A=
+			if (!iwds->hidden)=0A=
+				update_hidden_networks(iwds);=0A=
 		}=0A=
 =0A=
 =0A=
@@ -1474,6 +1658,7 @@ static void station_free(gpointer data)=0A=
 	g_free(iwds->path);=0A=
 	g_free(iwds->connected_network);=0A=
 	g_hash_table_destroy(iwds->hidden_aps);=0A=
+	g_free(iwds->hidden);=0A=
 	g_free(iwds);=0A=
 }=0A=
 =0A=
@@ -1856,6 +2041,9 @@ static void create_station(GDBusProxy *proxy)=0A=
 	iwds->hidden_aps =3D g_hash_table_new_full(g_str_hash, g_str_equal, NULL,=
=0A=
 			hidden_ap_free);=0A=
 =0A=
+	iwds->hidden =3D NULL;=0A=
+	iwds->postpone_hidden =3D false;=0A=
+=0A=
 	DBG("state '%s' connected_network %s scanning %d",=0A=
 		iwds->state, iwds->connected_network, iwds->scanning);=0A=
 =0A=
-- =0A=
2.25.1=0A=
---------------------------------------------------------------------------=
------------------------------=0A=
Hi Daniel,=0A=
=0A=
I have updated the patch with g_new0.=0A=
=0A=
> +=A0=A0=A0=A0 iwds->hidden =3D NULL;=0A=
>=0A=
> I assume iwds->hidden is supposed to NULL, right? If it's not there is=0A=
> bug? If this is the case it might be better to add a check and=0A=
> warn/error.=0A=
It is NOT supposed to be NULL here. Where do you think it has been reset=0A=
before?=0A=
It only can be reset in case of errors in connect_hidden(), but the=0A=
callback shall not be called in this case. In the other case, if the networ=
k=0A=
is reached (good SSID, passphrase, ...), add_network() is called and hidden=
=0A=
is processed. In the other hand, hidden is ignored. In all cases, to inform=
=0A=
the end of the request, iwds->hidden shall be reset by cm_hidden_network_co=
nnect_cb.=0A=
=0A=
> I skimmed through the rest of the patch. Most looks straight forward,=0A=
> but I have to say the hidden network feature always screws up the code=0A=
> base. Thought this is not your fault, it's the stupid spec.=0A=
Indeed, it is a tricky subject. At least, I have succeeded to pass my netwo=
rk=0A=
test campaign based on wpa-supplicant with this implementation and iwd 1.18=
.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
