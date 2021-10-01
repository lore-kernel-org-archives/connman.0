Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120059.outbound.protection.outlook.com [40.107.12.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5B2F80
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 15:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MouSGB+VCAg28KTXyBon0r7ntFT/lO6tM7nRVabN+dZxF7zs4uXAzjl+dhCyx6rQU+N01tPVS4Bhd+UyL38t2Mx0GDWDWSou2F+CVaDgD714FpR4fNcQHfx5N2XbRaUejHEgqGWI9vV9UOWUj6PHhAQWdJNKWgg0oS1B2I5pyGGOogXJshCHxLnplgMovEtpdu2r2s/wluXOwQs5nfqMGVwOs281bJGm2ZtdCbocBfmXittiFD8GDYPTYaVIFlyywbKNVbwAxH6p1bRyhPOtB89USPnygkj/d8q80olmPNk9WO8da2o89uf6i34hzkWzmsxY9ISvaAV7/+QThhtfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSZWj+zPwUCbw8i5Z/ROGu+2qfJiYjBIIlOIOBGQXg0=;
 b=BVjOX9q5d2u6AlH9ctHdQ2PLsM/VkNPyz4ZZY+AHDvQ4ock24AO35C+e1mO/nbwJ43VHM7q0nEmM/1Cola/PcdTx9pBGWP6Tfpvjc704PbktDGW8uu160XDMmqy5e/MMdfGCN5Xaw5NKhCU3FtnzWQC0Id1AhMGRCnoIbSdirfnt0n0bHGJRx0X/ld/LTtpCplXLY4iSWIFdiG+fQyjzhEZGiFWP0BegRCvuBK9XTWN5ATVzkOPXkGVnMjO2RDplnA2/deYgg3DUyQnbpcZWtaRkcQVHxmfgI/tt0rJ+3ijORDa5g8w5XadstCswUG2INOpssWN6wSNqNDu6KizPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSZWj+zPwUCbw8i5Z/ROGu+2qfJiYjBIIlOIOBGQXg0=;
 b=Bb5qLUy5BsFXj7SggvZHb/qNIWCBH2TSz+Gld1qDmmkMVj6Y/6zGdGDz10ckXJgBghePgCh2VnSvTIvDmM4KXA22wcUX0++8vQH5jKzNlHUPTgqeQFRTcubAej9f4eflqpzee9LiZKduHobOD8LOXHRDOskPmsyhunvuHcD4a64=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB1798.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Fri, 1 Oct 2021 15:27:07 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 15:27:07 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH 2/3] iwd: Connection of hidden networks
Thread-Topic: [PATCH 2/3] iwd: Connection of hidden networks
Thread-Index: AQHXtti10gxY7PlzJkSp8WEWjZ8UVw==
Date: Fri, 1 Oct 2021 15:27:06 +0000
Message-ID:
 <MRZP264MB1544676D5E67A464DCECB27493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 9386c48a-2cc0-1b67-bd64-b613174b1179
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bf50577-d89f-4de5-3dc2-08d984efedd0
x-ms-traffictypediagnostic: MRZP264MB1798:
x-microsoft-antispam-prvs:
 <MRZP264MB17983DE2D01B30A46F5E2CF593AB9@MRZP264MB1798.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:34;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TQ6S/sCo1ceA/Kj3VD1WIO6+smdcfoQ7h5zF9Amw4T3QXMmahnKahhrsJGWW88O4B5oBej9uSV/OUCpYutCdZX7pgC1KP/9f6auaAeDfnIfRDXYW5haPtb6hy7kRBmZhrQu7FFzK9qgAe7UL9E+vSlg+wivCxm+tQQBHJHlQThUzHSbkq4QPoj4dH2luvPN3r/6Ny8lJvuMWo21x+NZYLwe8PVbsLCcl0y7pwdfABYiItnxhd/D4fv0ZWswvUYRXisTEmWVAMHA13P0FzF8d29rdA/lrjE8u70829kgH+HYdXrXC289nCuJcAS7mWgZ3TXD0nwTu4Cq36pzKnsuDbNCaB005sCAUpikXFi9SilOAG4mcHPgXpu/5h24gyBZXtFm7g9BBUrOYJlKgR3SWy5Qesn33LLSCLM+6WoN54r5B99bPL9+B2Z/AFQKD5GJ1AOxTQjPDKkR47NdclYT+ZW3ELZhUdnPfNBYWspNJZmjViUoYv/42PCDrmUbcTBdT3V5e088IMwRPDjCyazlh8YGiUBub4prBCLR3w1EDI/h0nEYv3eR4Jc5UmPO602p4UOYGlYMw9hm/8TEKOtUsqfQd1e1KHhtWhmcOSVvQxO1CzuZ7hth93OPknh3XCnbS+DYf4vaGj3OKZP3IUJYZ55h71myN7738+j2N/y07EeUsSiG2EgcGBd/w16I36u8rYmBNeIfzYEhGIwcD2MvjwQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6506007)(2906002)(55016002)(7696005)(91956017)(26005)(76116006)(66556008)(64756008)(86362001)(66476007)(9686003)(66446008)(71200400001)(5660300002)(52536014)(66946007)(122000001)(38100700002)(83380400001)(38070700005)(33656002)(316002)(8936002)(8676002)(6916009)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Y340kwcX7JNUjEJBOmg6EG5xR86V+C0rXIFUGnrv9Z5A92WeM86EBJ/bNH?=
 =?iso-8859-1?Q?PPapPPcYp4tUNTJjByNTo22AMkNWLklQTXallsu0FJtI85FyTIlLsL6OtL?=
 =?iso-8859-1?Q?6kuJulOzHPkVB9hZpGLhT2yScjgrBoP0mdS0A9srA1tAA3tKp75oFYmMdN?=
 =?iso-8859-1?Q?x6vu+DU9WgVSqSl43pUIYXiVNOvdLHOBHxQ5y8B0xdXEzm+K33flDlu2C5?=
 =?iso-8859-1?Q?g6BEJE2ZcPfh3NVwII9zJfpKw+TC4v1mX7elHF9te7Uvz2nCh2ekeiu0US?=
 =?iso-8859-1?Q?GoHB40EXYOz34+hO2+R/DY/yuHJeWbq2/po7Ojwn+u2oV640fZqXOqQ9MR?=
 =?iso-8859-1?Q?uTLtkbmBRFbTQnn0sqOSrKONaksSieRmZBdK47dW1gTGrXq5quawfHlMfO?=
 =?iso-8859-1?Q?d6OcLydRyqYvufRox2P0jqEGuyqzo+/kVR3q+YkmZsd4lAIlFCB/sjAhAG?=
 =?iso-8859-1?Q?bts0tN23+OIFuRqKzPcpy8QWFtbf2qWUyDErgIJtCbFk4LqnrWdIynXGvK?=
 =?iso-8859-1?Q?blEKVGHPsFU/DcveGuuE7FQiGWYNST3itMUT3EqxRVVhKsMg2mBCTqA9v4?=
 =?iso-8859-1?Q?8Bfa2pVTnhVp9/7nJt8yRcUCE4DruOuXcnx/D1+A4GyILGykxJ0rYiPi5Z?=
 =?iso-8859-1?Q?ZFAblcjUSc+4yeLc/9iRHRN7ZTi2EVjk6rbrjulInjDSSmZ11aPnzoNKlO?=
 =?iso-8859-1?Q?81BmWWcfQFhNdUZjJhIGMSVilPTXPb7qhzsZZwrXFpLqYTG4Ep1xFAxAIM?=
 =?iso-8859-1?Q?nNbWnsrKRQEAIeubKf2mIovycrome6elPNSy/GG4Rwr1ZrxBoeMgnp+7uS?=
 =?iso-8859-1?Q?YNncvAuOJWMw0sUbOh2dEoVbQSOy/3m3fGQu9Kn8nRWR6gQ6RnmuSBJbDV?=
 =?iso-8859-1?Q?65vNK7UWxlXcWt8591iPZ/fniwWgbR9OjrsHkK6CVlS8KXFIl2SB8FBBjD?=
 =?iso-8859-1?Q?cuOMu5ORRpo9fR3759SWB3ZtO5GxA2ytp5hmW30v2Q7yCxEfx4+9fs3/AR?=
 =?iso-8859-1?Q?DqoK4zVC9OW8vpuHIIF30g0cnQjNxu6y4T/s9LbWoRaugMnkC+m0t5vw8B?=
 =?iso-8859-1?Q?I8q5FHQjDhHCYXBQepvFAF8Hg010In2BjFlddxdnGvySzih3CjA0XBDsVo?=
 =?iso-8859-1?Q?eRK3qS2c5Zoa7qAyzMQKrJpC43liecaJ3mLIi+TpDLaXZ5bZ1sb7j/TKch?=
 =?iso-8859-1?Q?sxgBVWK/5nrSk/m3H3w9OyKn6qqlFEE3nsdPWps7i1yj4hdFnUTBXKs2Hj?=
 =?iso-8859-1?Q?YLSTnfcfbPTpnN8Ug7DIndzt127s/ODBABlkYGInH/EXeTA7M+SjwYTXHW?=
 =?iso-8859-1?Q?Y2pws1l47KOqvDbfHqYtf/5fQjd3OHCACjxCHIrbNSHmvgo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf50577-d89f-4de5-3dc2-08d984efedd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 15:27:06.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnXigRmIMYTfLakXuzMV2ctBMo050XslJZKeVv/cziN8n5ECy8bkygV2UIDqVNK59PeElyj8uFD0IX9nA80FESACn7cglH+Z2I9Wpqnljvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1798

Implementation of hidden networks connection.=0A=
---=0A=
 plugins/iwd.c | 227 +++++++++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 208 insertions(+), 19 deletions(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index 00578f4d4ab3..961d53196207 100644=0A=
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
+		hidden =3D g_try_new0(struct hidden_params, 1);=0A=
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
@@ -1351,8 +1533,10 @@ static void station_property_change(GDBusProxy *prox=
y, const char *name,=0A=
 				connman_device_set_scanning(iwdd->device,=0A=
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
@@ -1474,6 +1659,7 @@ static void station_free(gpointer data)=0A=
 	g_free(iwds->path);=0A=
 	g_free(iwds->connected_network);=0A=
 	g_hash_table_destroy(iwds->hidden_aps);=0A=
+	g_free(iwds->hidden);=0A=
 	g_free(iwds);=0A=
 }=0A=
 =0A=
@@ -1856,6 +2042,9 @@ static void create_station(GDBusProxy *proxy)=0A=
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
=0A=
