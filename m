Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120083.outbound.protection.outlook.com [40.107.12.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0829CA
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 09:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvQPMkShoaenFn2VKSg0ERLuYkpTdjWKrdgw4qHkpQg+YQpyJg8iLuo+c9kaIrqMREKL6wQM7FNadFoaukYKX9u4cwKB5xMGS/O9SEJh+0lgKoaMYUOUYVJcVA0G835oH5rgoYGqz7axuvrCjdYfPJM46NSrKpIxoCkEfyicCz9Dx7EM06IISxC+bbwgUPO2izYk5bFHGTH7kmb1lf0f18W4Jjxp/aIxjO3qE+W5THjo4gTDTq2YhFwocHP9+TYyn3zKPZ0TgN8yLpk9Lq5qWskVCrE6g2bMbIFu1bEYFODwAJAU/BNY6J/n+WY4QYlaOHXf50HHSmztUVPn+RpkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4fR9GJQ4PCo1ZszNLqcAlsG3IxCzhHtNLmYMEewFpI=;
 b=iCGiEPfq2Sg22KAeQaKbWUyC0Sg47F2cv0ggB6sr9oPTys1fnueBHMDUNRJXgslAancnwFxoh64yAfSE/trKnapbxDFVLhQBSj680Bo/KIBV5sBwsmSvkT3vB5p13nSoCZp4IDqzIp/2DZzzlhhxCthLNXZuIjC6wjDJINshmxN1cvwIc3O8IGq7Heb9Lyq7BBAumzPRE6ZXvAfwUhZMPJSWdNbqqT/diLidGyLviIeFDx/61SBVc8/yJun+fz/gL8QhiCakW6PfSnW6Rkhktsvrg4NT/pYF56eVwRx41IuM4ErCvI2zH9kXp736xXqu8r9OxqhMS1TMDlpJrHh7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4fR9GJQ4PCo1ZszNLqcAlsG3IxCzhHtNLmYMEewFpI=;
 b=If5wLIjmyDVTQUe9/5/vh8M+C6EefHoUI4BR57PiWdcAlxiPnU8pw9pL5TuoldnrvckIrkj1hikZ+MU9lv6Eb+x1s+DxRprmbhSvXni07rKe01M3izo/0IL+VymWBxjtZ4v2nTfSkzFpI/hO+HmTW7Upf3YC2EmoOLSMa/lNE0A=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2178.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 09:22:38 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 09:22:37 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: Daniel Wagner <wagi@monom.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH 3/3] iwd: Ensure hidden services connectable after removed
Thread-Topic: [PATCH 3/3] iwd: Ensure hidden services connectable after
 removed
Thread-Index: AQHXttjmphYtqbur006hzDu6nyMvJavCbu2AgAAlkeg=
Date: Mon, 4 Oct 2021 09:22:37 +0000
Message-ID:
 <MRZP264MB15445D45BD54C00DE768979093AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB154491FD5A024CBCF0147E5B93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211004070611.usnxi6bbmkfanxs6@beryllium.lan>
In-Reply-To: <20211004070611.usnxi6bbmkfanxs6@beryllium.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 2c896355-459e-80ec-f1e5-dee429634342
authentication-results: monom.org; dkim=none (message not signed)
 header.d=none;monom.org; dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c43949e-542e-487b-f23b-08d987188204
x-ms-traffictypediagnostic: MR1P264MB2178:
x-microsoft-antispam-prvs:
 <MR1P264MB21789E82E49458753F274D4B93AE9@MR1P264MB2178.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4AyvgxYE0FEcDMCyepfPio6djGvwxaWhF1ezLF+oDzM5Q6X8Qyg4EsEdgWzT2vBfppCqsJ+IVnCMpJP5dFgSx1LUP0YHnbLwf2jJyqo8SHJ2VnHQJQUsF9cZLr0Q1O8PjCHs/gnuAmQrKt3XMdZLs4O9nLYqPoANooWRlI8KrpFX8BHWy0ECeBrSed5K6Wj2Y0ky3TnB+crBsiyqA0DfSLEIIBAjp3OxYmfAxJLCvYe3aHhxKACxB7OGzQWDxZXq/koXHtQGTmLC6J0K0imvBCEVeM5rW7nMCG/o9Ip662i6Uh6powxwn6YKvW8UX1eaOKjUQW3aKEas03HP7DG3HDoQGv8VxrYI/Xa9u7lqE2ielEOtoe5CwLztbCtgiJrMge61pVanxw+t6qeNampOul5WxgjdvVKb09Qe3M+bBdwCEJc3geTP/MyVsm3havKwWbJw5dh3y25Oi8wm0S6dj0QTmrW6PRGiUFeJknu7o5fuoPF+qo9BncQ/gJ58S2QFOe7nadXzp+09rXAwIG9g8ffSJ7TJfpXgO+muXB+qvUIK7jXOww+pXmaVUMElgpXimdSm+JmvA/c8sbIMq7fbe1Dl3tXmd8DPJDcxxsjqsfz6HOP5dwz0IqYWcUoWE4ulbdhsLGPPApNv7m6eFj0a5WRmd42H+RL6MtDorXvDh36L4K2cpsnklWLdCE7H84FNxD0Tqz+2hcAaZuMyvVUNwA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(186003)(38100700002)(33656002)(5660300002)(122000001)(9686003)(8936002)(86362001)(83380400001)(6916009)(71200400001)(2906002)(508600001)(66556008)(66476007)(91956017)(76116006)(64756008)(7696005)(66946007)(66446008)(52536014)(38070700005)(4326008)(55016002)(8676002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9zgvu9L7Y3N4wv+rZOyxiRtf3uKYy/9nwvFKrOjyKR1d+UPjqqL0EIPVIl?=
 =?iso-8859-1?Q?qJYSUE4XyXOmVjSJCvCmyHJQhZshm9PGX834fDoQTxOjBXnVfku54lhBrU?=
 =?iso-8859-1?Q?uNs1ps0H4qKLHcJwFtCSlwM75M18WRzvGDU5SmgBTV15hXTcI0VM+oPFSq?=
 =?iso-8859-1?Q?QuwBWMCfJv8celrFzq+2xen4S6xOL+pytXnxf5BGeUvt94wyCHC5rqrdgV?=
 =?iso-8859-1?Q?cpwbAODLtedR+Mo4g2+IjwERx/IqPFbMGC/iS5fTGc4ZZyVpJ1In2N01lf?=
 =?iso-8859-1?Q?FNYGKRUt/IVQoskB7R0/QQfNOvZR1ZOCLQxkoYRcDikYpP1gcEGEpM6ZIH?=
 =?iso-8859-1?Q?K3htbJJ4y2zY8P8wgXCLZdQGeJyC/dP4eGLFcdenQsF+ZitVfR12j0gkbR?=
 =?iso-8859-1?Q?lgaZ/Oc3Haw1CfWtuSxfZdBaM5+VVc1crpL8AeNu4v6HQt9uSED664p3P0?=
 =?iso-8859-1?Q?5h8PJ6GmCunaKb9eEQvdDO9knAk6Afumnsx6rq17CmsL14hlpKH7CxAlcn?=
 =?iso-8859-1?Q?bHLL/59JtN/QNRStHDvKFi2mIaazH/IIvlByD1jQ92n7jcedmqAGcM72Vx?=
 =?iso-8859-1?Q?owdYV89q/aF6j6ZxAW+a7CA4nZtV7bxlvhBxSe9p05QJZi38fjRcpsq1R8?=
 =?iso-8859-1?Q?BqPFyAxUrePY69SfwkiVghIF7K3t9A66+LL0KhwD4FRGwZ5Z9WzptQf0kl?=
 =?iso-8859-1?Q?x3wfZb3AIJKT8JW/MdJ4fnCdBnpSfuAg/1bnZaDJd1LrqPrS6+rF/Wmldu?=
 =?iso-8859-1?Q?Lrr9Z6k2PXXxJ8j5wSLVeeMoa0SFr2VE9QmVvRjCy0ZRpAm+eheBJ6rdvP?=
 =?iso-8859-1?Q?vsGH3GfiTP6Kjacuw9beb54nhI37Kv64XY2hdIr99UrnI3e/VwOdUEZsU5?=
 =?iso-8859-1?Q?655wvdeWzf1AQO0vQBZcxa2emkiaxqbeGECMmT+z+VNBE4NbnItoiXWgVt?=
 =?iso-8859-1?Q?GqEKRaHPlqmCzBjX3YvRPi9l+sCen+xMlBHJ/aqEhKqn/W3F+IAbYg1pHp?=
 =?iso-8859-1?Q?P3R6CBKGO2HsdsY0RpIb8R4ZWrWK4H0H1eE3tPYnmIZnqgpUAkKLpi/igm?=
 =?iso-8859-1?Q?IyXOErJRu344CdTaxLgFeaQukqvwwgUzJvoU5xq9CaUrk3McvzLAOiSi0m?=
 =?iso-8859-1?Q?iFPDKkG5HeAstue2D9jOUkwEOQE6/eUJv8kKNBGlityj/y34uAE7GY8mpZ?=
 =?iso-8859-1?Q?CTiKYx88KNswHGn4outNavaLWxL5zCKQ1bV5WPenjRr8F/zwVtZaDN6pY0?=
 =?iso-8859-1?Q?84dArfhGcmg4k6vHeoolB9qURzj4HItIls7m1vh6QZpZe/apb2cTpml2cx?=
 =?iso-8859-1?Q?Xow0orZzIWpGZC7TygpQil/ZR56op054ev02Ijpvg9rcv6t9Hd0xdSCekY?=
 =?iso-8859-1?Q?BTYawJw4YTeZ2vgQp8NQWo6RidvsroRCbNwj0kc3kc1MkLR/TOJGE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c43949e-542e-487b-f23b-08d987188204
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 09:22:37.8748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bYfsSZGVoWvfmsAHnXRyBZfmN2acKMRhZAGN/271j6r/2EO8HkLYeaSIyhAUgonij/U99ZF+yVh2KYLpyFQV7oilqkUFBpREBurePbp8/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2178

Hidden services shall always be connectable, even after been removed.=0A=
When a hidden service is removed, the associated iwd network stays as=0A=
known and thus shall be connected as a visible network.=0A=
---=0A=
 plugins/iwd.c | 71 +++++++++++++++++++++++++++++++++++++++------------=0A=
 1 file changed, 54 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index 4d009c3515a8..a3c0ec6bba2f 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -140,6 +140,7 @@ struct iwd_station {=0A=
 	bool scanning;=0A=
 =0A=
 	GHashTable *hidden_aps;=0A=
+	GHashTable *hidden_networks;=0A=
 	struct hidden_params *hidden;=0A=
 	bool postpone_hidden;=0A=
 };=0A=
@@ -646,6 +647,37 @@ static void hidden_params_free(gpointer data)=0A=
 	g_free(hidden);=0A=
 }=0A=
 =0A=
+static int connect_hidden(struct iwd_station *iwds)=0A=
+{=0A=
+	struct iwd_network *iwdn;=0A=
+	char *ssid_security;=0A=
+	int err =3D 0;=0A=
+=0A=
+	ssid_security =3D g_strdup_printf("%s_%s",=0A=
+				iwds->hidden->ssid, iwds->hidden->security);=0A=
+	iwdn =3D g_hash_table_lookup(iwds->hidden_networks, ssid_security);=0A=
+	if (iwdn) {=0A=
+		err =3D connman_network_connect_hidden(iwdn->network,=0A=
+				iwds->hidden->identity,=0A=
+				iwds->hidden->passphrase,=0A=
+				iwds->hidden->user_data);=0A=
+		iwds->hidden->user_data =3D NULL;=0A=
+		if (err =3D=3D -EINPROGRESS)=0A=
+			return 0;=0A=
+	} else if (!g_dbus_proxy_method_call(iwds->proxy,=0A=
+			"ConnectHiddenNetwork",=0A=
+			hidden_network_connect_append,=0A=
+			cm_hidden_network_connect_cb,=0A=
+			iwds->hidden, hidden_params_free)) {=0A=
+		err =3D -EIO;=0A=
+	}=0A=
+=0A=
+	if (err)=0A=
+		iwds->hidden =3D NULL;=0A=
+=0A=
+	return err;=0A=
+}=0A=
+=0A=
 static void cm_device_scan_cb(DBusMessage *message, void *user_data)=0A=
 {=0A=
 	const char *path =3D user_data;=0A=
@@ -669,13 +701,7 @@ static void cm_device_scan_cb(DBusMessage *message, vo=
id *user_data)=0A=
 		iwds->hidden =3D NULL;=0A=
 	} else {=0A=
 		iwds->postpone_hidden =3D false;=0A=
-		if (!g_dbus_proxy_method_call(iwds->proxy,=0A=
-				"ConnectHiddenNetwork",=0A=
-				hidden_network_connect_append,=0A=
-				cm_hidden_network_connect_cb,=0A=
-				iwds->hidden, hidden_params_free)) {=0A=
-			iwds->hidden =3D NULL;=0A=
-		}=0A=
+		connect_hidden(iwds);=0A=
 	}=0A=
 }=0A=
 =0A=
@@ -740,15 +766,7 @@ static int cm_device_scan(struct connman_device *devic=
e,=0A=
 			return 0;=0A=
 		}=0A=
 =0A=
-		if (!g_dbus_proxy_method_call(iwds->proxy,=0A=
-				"ConnectHiddenNetwork",=0A=
-				hidden_network_connect_append,=0A=
-				cm_hidden_network_connect_cb,=0A=
-				hidden, hidden_params_free)) {=0A=
-			iwds->hidden =3D NULL;=0A=
-			return -EIO;=0A=
-		}=0A=
-		return 0;=0A=
+		return connect_hidden(iwds);=0A=
 	}=0A=
 }=0A=
 =0A=
@@ -1298,8 +1316,23 @@ static void network_property_change(GDBusProxy *prox=
y, const char *name,=0A=
 =0A=
 		iwdkn =3D g_hash_table_lookup(known_networks,=0A=
 					iwdn->known_network);=0A=
-		if (iwdkn)=0A=
+		if (iwdkn) {=0A=
 			update_auto_connect(iwdkn);=0A=
+=0A=
+			if (iwdkn->hidden) {=0A=
+				struct iwd_station *iwds;=0A=
+				char *ssid_security;=0A=
+=0A=
+				iwds =3D g_hash_table_lookup(stations, iwdn->iwdd->path);=0A=
+				if (!iwds)=0A=
+					return;=0A=
+=0A=
+				ssid_security =3D g_strdup_printf("%s_%s",=0A=
+					iwdkn->name, security_remap(iwdkn->type));=0A=
+				g_hash_table_replace(iwds->hidden_networks,=0A=
+					ssid_security, iwdn);=0A=
+			}=0A=
+		}=0A=
 	}=0A=
 }=0A=
 =0A=
@@ -1658,6 +1691,7 @@ static void station_free(gpointer data)=0A=
 	g_free(iwds->path);=0A=
 	g_free(iwds->connected_network);=0A=
 	g_hash_table_destroy(iwds->hidden_aps);=0A=
+	g_hash_table_destroy(iwds->hidden_networks);=0A=
 	g_free(iwds->hidden);=0A=
 	g_free(iwds);=0A=
 }=0A=
@@ -2041,6 +2075,9 @@ static void create_station(GDBusProxy *proxy)=0A=
 	iwds->hidden_aps =3D g_hash_table_new_full(g_str_hash, g_str_equal, NULL,=
=0A=
 			hidden_ap_free);=0A=
 =0A=
+	iwds->hidden_networks =3D g_hash_table_new_full(g_str_hash, g_str_equal,=
=0A=
+			g_free, NULL);=0A=
+=0A=
 	iwds->hidden =3D NULL;=0A=
 	iwds->postpone_hidden =3D false;=0A=
 =0A=
-- =0A=
2.25.1=0A=
=0A=
=0A=
---------------------------------------------------------------------------=
---------------------=0A=
> +=A0=A0=A0=A0 if (err =3D=3D -EINPROGRESS)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D 0;=0A=
> =0A=
> You could do a 'return 0' here.=0A=
Indeed, Daniel, you are right.=0A=
=0A=
Best Regards,=0A=
=0A=
Emmanuel=
