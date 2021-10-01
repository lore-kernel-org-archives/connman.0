Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90052.outbound.protection.outlook.com [40.107.9.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038D2F80
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 15:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYbpJr+8bCEDWQtbKHgf6h26/FMOD3yR1tdlXG6qYyBTheLcKFxQDigptmfJTs3gbI1xIoNjle5pxtSji2/nNj8qqX+ssLYRi+N8GGL3XmUCnlpslg8BdCFdGs6tutILAa/p0gHvDp92KSthOw6lDXwtZTzbJc0AOpX1oPEEx7GH/pg+AgeiOj/In8N9kebmkWNa3dDLJiqMzyT8rF+DhPQ6YZKr6SdJB7LnrWxpDO8K7dgYqTuhK3acNtbhG88lXmig+tsbOQ2G7pQ/He1hGUBNfVicPW/f19RHLZW09KBFmdGbl3ixuB0nss4NxKrepP0RKVu0Q6oHgA0iZMh+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0T+tBQmEKK/6S7l/3Vtac8eMfHLF+SadJFaBUvgDVo=;
 b=BNwyHOp3dEZdSXvTBhvIT0VKxCV4sT5KU0gIPq0eQIpFmfkHSeDnYyTPCukia1ioc2ODiho/p/Jyg4b+F7mpkb1/8+XEACJjZTpYAEku45dEN5JwNhosxchN+cJK6qUfpNL9hnjQwcTFK9peY/iQwRsRQLuHd0rIv2nMrpAyCCcMYAxQN1V2lHmRFdftUqi7+cktRg4qLQ8+xQMdgrp+hn46DeLTgFLZuQs6lGfgpX9dGmg2MRhWsmmOgdNwbCMKvbCntCivvVI7Q/dfSV8JSDp0n7iJE7zqJDrw3XbWPJlfi4O171f34VkY8IIgpWaa/++f9d3tPsqYZhyjuQFmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0T+tBQmEKK/6S7l/3Vtac8eMfHLF+SadJFaBUvgDVo=;
 b=0gG+BVlwb1tdx6TOeM/vFQe9ztFusQSzVi0FOXi16y4lERiEkT+lMkMzHgaqDvv9IkNQ6r6Mfeuda8Mzj6J7GpcDDN9geQlpr4ecXIkeouYXqcXFO8iuwruBmT6UXM8I+N+x8RJbyN4SkVg46dD+rBUHUzXVlith9ozPkQfMNOU=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR2P264MB0641.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:12::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Fri, 1 Oct 2021 15:26:03 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 15:26:03 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH 1/3] iwd: Scan hidden networks
Thread-Topic: [PATCH 1/3] iwd: Scan hidden networks
Thread-Index: AQHXttb22udP+HIkKU+24JHu2+bUZg==
Date: Fri, 1 Oct 2021 15:26:03 +0000
Message-ID:
 <MRZP264MB154441C6059B4972B76730FF93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 4facadec-c9d9-c6e9-29b6-7a48b9e3d2be
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5532e279-9558-4665-bccc-08d984efc7e3
x-ms-traffictypediagnostic: MR2P264MB0641:
x-microsoft-antispam-prvs:
 <MR2P264MB06410DC87CB7FE66D89F10EA93AB9@MR2P264MB0641.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:178;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Yr+AcbtTaD3zcB7sE6ZGLtDi3y090tEOOMEdlNVnZ/ANvRKl/bE4v+JYaNYP1EXfj9AjANNSNHQspeJ0jjl7iXSdfc/4yX3q6vvH+S4e03prba2En/7bPvpDtmBmlnlCD2zKdcJro3YNst0fzWGI6r+ti1CNv20XSXodjTYTND+U7+z87MBYRGY2MdRrmYZOrR2GOVDEbNvMH2anscddG7LIa/yZXotRgK5NS48CqFEtnt7h48gURj4sw2cHkIgxX23av58eM0MnsaHxZGIZPlZGtdBzKYBkDN0QQKdwIrpjsix/Zeo0t8Qy08uzRRPnibKZMx7cIYUocODGcABunNWgxBFAiCr9xpn35hFpJFS+G0yFv6Kkx4ntAzpIiokMF1WMxSMiWflRPlz2Lp7PEd8yU9pwlrnRJF5BjkjeHWXc/qSR5qqfc5CfpSfzjgqNG1DIsK1iMRZHnHw9qwrVk3INnPCrPmp90+EOBnBSGj2gx/VIMk9MVM4h9QEFiPU2ZE3SKhODS85IZ8qcYYKaU+0tUKkmUWOL3HnBI0uGGTMViOzc0D8ecE8mfTpOaUibsF3vipsmTXTy52CKwt9f3bapTjE4JIQhbl/Sp7ScnGABz2HgfS2SEwAjntqKO4Lbw0aKchE/P8bTj4/wZWv0H/T78i3RNWemywICxmK8OMcvZcMv8AjB5lc4hG87IE6Q3kK+9xvUiu56gHYNLaZHUA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(316002)(5660300002)(52536014)(33656002)(26005)(8676002)(66946007)(7696005)(66446008)(122000001)(38100700002)(66476007)(186003)(9686003)(64756008)(6916009)(66556008)(508600001)(83380400001)(55016002)(86362001)(6506007)(8936002)(91956017)(38070700005)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?i7Mg6wthQVkpRmuu35mycRG1STP0j7eENmaiVipL13q6nHAYv5Jg4SJbJn?=
 =?iso-8859-1?Q?gjIgtRVkYPN1jv2iSm157ta2Qvy8JQRNguDupAG0+PaCUfHqs01UwTZPmp?=
 =?iso-8859-1?Q?xqFzjgEN/ML4GcgCN99tH6B/1dIHaCzDQuv/J8NU1Cd+H9hGNBdU7FA+d8?=
 =?iso-8859-1?Q?PwWmkYiycWK53vlS6dHiN/DR7DYm6EInwrtmErpc0GI0ZdUuFfd0UWHsbA?=
 =?iso-8859-1?Q?BeNr/H6gDd5SvduwPtlfk8SDBqdVYf8JiKY9mFC95iv+vB6GK3WTt0gXzN?=
 =?iso-8859-1?Q?ls6kc0axOJMNZKkoZUgJbIeju+ddDpPizcQrrfsO3DfhD+LGhYLCuPjjxv?=
 =?iso-8859-1?Q?t6WjudIMZrjjqXs+zE6mypXfEL2ZzpDh7wN+BNdQ5AZZVpjLY1EGnRnxmo?=
 =?iso-8859-1?Q?0IBJNOXjiNtVF4u5UxRqKUQ3CgAeU0i0QkuG6OFJqVkSowWMrpei5DYD/k?=
 =?iso-8859-1?Q?7WqKzzP699eK+oSMxI0oS724GBy9lRno7Yv12/KQMQPJej/m1TXCnmNwCE?=
 =?iso-8859-1?Q?CcBTOHL3ijzVbdenz2CS9buIj2EPIIJ6sMnPBXhnw/7yiHF+NPcPXpf/Wp?=
 =?iso-8859-1?Q?m3rPPXZ2eQ+qXVwUW2kUZL63uRoyugZzDpWwVitgYHaDRx2w+HfNvYRaQX?=
 =?iso-8859-1?Q?KjCJ4WWRXlKvuNaj5RbtqYTQhHBo9KaXAsVkEeECUI4wb774M+l+Xtiw82?=
 =?iso-8859-1?Q?ErRDqsmWx/ulhCuXQ7kjCDvgCXpqrtq7cPNSgWeqVaq5uMJA3ZB1ZJQfz8?=
 =?iso-8859-1?Q?d8D6lYb6evWYxWvDICIdjC2skTZ2Bgx0EizLHqLNYLuUEFKQH7SXK3xUKj?=
 =?iso-8859-1?Q?cCVrb/DyuHW0BJZyhIt8/QzGI6CKUDjcNdpL2w6LbO1wMLppH07WlT1ygY?=
 =?iso-8859-1?Q?f75iwLX7CSy+Ift190WoFmakjlWA9DAms/ym5zLMOO05pZNnwvxHRGP66S?=
 =?iso-8859-1?Q?/LSRERaDYoxFiq95hShkGo2ecvEvHfvSF6INJuV+CnDOAkTbZfEmpXv+dy?=
 =?iso-8859-1?Q?1yrwUqsXnsO5Zy6rsZfliRWp1l/vhgV2YCBaSV849IqMK1nRFXM9Zjpvy0?=
 =?iso-8859-1?Q?sD90Zv78hcL42tWk+L9r5tCPEpMY1DgO9ctCOI7V8qrsTqe638m3+0c4UG?=
 =?iso-8859-1?Q?yLHBiNIPod4rDvlcxsr9arMpIOuSO76HSARiVbXAIQlNKMozcbHrztyJ3R?=
 =?iso-8859-1?Q?VfM9tc8VuB19An81AzP8jha3ft8/IGG+ujQDcowE5U5KqNwo+EDKnVatBt?=
 =?iso-8859-1?Q?dEVp6FbTfPxW7MBr86/Kzo1S4o+9CoLBQuqd7sHXL0k/WKQMKy6yWzX9S0?=
 =?iso-8859-1?Q?uGHO0yA+8wpbtEN7E0CqCnAc4fc0SMtYfzW+U7jYwvv34aY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5532e279-9558-4665-bccc-08d984efc7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 15:26:03.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hD10+aUrl6s2kztZ5WMvTP2Qtt1fiLc62cLT1c5FdIjVH6ODQIUVKIDWBndpOa2hnhGjte/84mNqHJjf7jZm62kYj7HVcyy1P7SHQcbmg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR2P264MB0641

Only visible networks were retrieved by a scan, via GetOrderedNetworks()=0A=
iwd function. A call to GetHiddenAccessPoints() is necessary to=0A=
retrieve the hidden ones.=0A=
---=0A=
 plugins/iwd.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 140 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index ec9a4574cf2d..00578f4d4ab3 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -113,12 +113,22 @@ struct iwd_known_network {=0A=
 	bool autoconnect;=0A=
 };=0A=
 =0A=
+struct iwd_hidden_ap {=0A=
+	char *path;=0A=
+	char *device;=0A=
+	char *address;=0A=
+	char *type;=0A=
+	int16_t signal_strength;=0A=
+};=0A=
+=0A=
 struct iwd_station {=0A=
 	GDBusProxy *proxy;=0A=
 	char *path;=0A=
 	char *state;=0A=
 	char *connected_network;=0A=
 	bool scanning;=0A=
+=0A=
+	GHashTable *hidden_aps;=0A=
 };=0A=
 =0A=
 struct iwd_ap {=0A=
@@ -926,7 +936,8 @@ static void add_network(const char *path, struct iwd_ne=
twork *iwdn)=0A=
 	connman_network_set_data(iwdn->network, iwdn);=0A=
 =0A=
 	connman_network_set_name(iwdn->network, iwdn->name);=0A=
-	connman_network_set_blob(iwdn->network, "WiFi.SSID", iwdn->name,=0A=
+	if (iwdn->name)=0A=
+		connman_network_set_blob(iwdn->network, "WiFi.SSID", iwdn->name,=0A=
 					strlen(iwdn->name));=0A=
 	connman_network_set_string(iwdn->network, "WiFi.Security",=0A=
 					security_remap(iwdn->type));=0A=
@@ -1189,6 +1200,113 @@ static void update_signal_strength(struct iwd_stati=
on *iwds)=0A=
 		DBG("GetOrderedNetworks() failed");=0A=
 }=0A=
 =0A=
+static void create_hidden_network(struct iwd_hidden_ap *iwdh)=0A=
+{=0A=
+	struct iwd_network *iwdn;=0A=
+=0A=
+	iwdn =3D g_try_new0(struct iwd_network, 1);=0A=
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
+	iwdh =3D g_try_new0(struct iwd_hidden_ap, 1);=0A=
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
 static void station_property_change(GDBusProxy *proxy, const char *name,=
=0A=
 		DBusMessageIter *iter, void *user_data)=0A=
 {=0A=
@@ -1234,6 +1352,7 @@ static void station_property_change(GDBusProxy *proxy=
, const char *name,=0A=
 					CONNMAN_SERVICE_TYPE_WIFI, true);=0A=
 		} else {=0A=
 			update_signal_strength(iwds);=0A=
+			update_hidden_networks(iwds);=0A=
 		}=0A=
 =0A=
 =0A=
@@ -1354,9 +1473,26 @@ static void station_free(gpointer data)=0A=
 	}=0A=
 	g_free(iwds->path);=0A=
 	g_free(iwds->connected_network);=0A=
+	g_hash_table_destroy(iwds->hidden_aps);=0A=
 	g_free(iwds);=0A=
 }=0A=
 =0A=
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
 static void ap_free(gpointer data)=0A=
 {=0A=
 	struct iwd_ap *iwdap =3D data;=0A=
@@ -1717,6 +1853,9 @@ static void create_station(GDBusProxy *proxy)=0A=
 	iwds->connected_network =3D g_strdup(proxy_get_string(proxy, "ConnectedNe=
twork"));=0A=
 	iwds->scanning =3D proxy_get_bool(proxy, "Scanning");=0A=
 =0A=
+	iwds->hidden_aps =3D g_hash_table_new_full(g_str_hash, g_str_equal, NULL,=
=0A=
+			hidden_ap_free);=0A=
+=0A=
 	DBG("state '%s' connected_network %s scanning %d",=0A=
 		iwds->state, iwds->connected_network, iwds->scanning);=0A=
 =0A=
-- =0A=
2.25.1=0A=
=0A=
