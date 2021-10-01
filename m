Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90083.outbound.protection.outlook.com [40.107.9.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496832F80
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 15:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1Houkr939J5OVa4LPQXlcBJufGikP/Sqjw3GgcXGSkryMsc566A+nkEWoUMQxynmNyJm4i/cb20JMHLkjGqsItun2Y8Nh4dSBvpdbvBAqZ6k6ALZtWyqcoHo2JrpCwu1ThXGPdkTuDfQk1kOTOkNx87srah+YiBVOBNGObkMtPKuh0xc3NwQN9XtU9aEfEzYMgFcOaquSdmpV2Z7r9Hha4V7DwFXb5lXKzjCw4he/u+PPEZbDUyO7RLipFybBNNPzD+kWdaxYAAWkxOTsNXblte/QYIKmgaR2YWdUpSDNtiYwvy0BCodt66jnzYSMIsL/MGaCzwiLaVEQ2btItEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsGGcpAE70QMgGD+By5MLFSjnprkoI93AwNG9UqRWAY=;
 b=MCqoVFjJH4LR4JxI8kIqkltyrLGiIswpcRjZVrjYt4yTwnFI3rZBW+T6VSKc00am+nfp8Pk2wMSJq06LiyNVXkcEApiV4fSE0l4JaMQLvqBEEZl1aAjP+UIdOQEcwFeqobeXgeQlHmQxlHdJ4jJ6Wxz+iA1m5uZIlq6eTFsxJaS76qKWNDZN3ZMnrwsABJ2uWIclHGtbzyPEJW0vd+KKgCa5U7zhr0ByOapK/S7mqbBCKxmWTdRoB8U5Jxi8NNAdmxjXvePA8ihEigKQFGDIPqaTY3SBiMeGz3QuSyM48Q3NF+hauLBAljTumdXqFLhtyvOD9l+4Ho21i1pbX5cInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsGGcpAE70QMgGD+By5MLFSjnprkoI93AwNG9UqRWAY=;
 b=TrYM0f7g0iHBY/we8KbvHygErHFpbxQiOnJJdLTG4xnaPXDPJNb/k039gpYRdlrAlzCBuNi4t2DJkv3wd1dRclMnRjltXRCPKH0pA3xY20TmM/i2QDSpOfJ/gWNl0fvq12OaJ3tO1SOXveav6J0aQCybzcZURAtC6evxr1uWE68=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB3132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Fri, 1 Oct 2021 15:29:16 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 15:29:16 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH 3/3] iwd: Ensure hidden services connectable after removed
Thread-Topic: [PATCH 3/3] iwd: Ensure hidden services connectable after
 removed
Thread-Index: AQHXttjmphYtqbur006hzDu6nyMvJQ==
Date: Fri, 1 Oct 2021 15:29:16 +0000
Message-ID:
 <MRZP264MB154491FD5A024CBCF0147E5B93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: e09cf03f-13ad-3893-97d3-1f5136cc77e9
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aa2bc5b-1d0b-47c6-5993-08d984f03b01
x-ms-traffictypediagnostic: MRZP264MB3132:
x-microsoft-antispam-prvs:
 <MRZP264MB313252CEBEE97239E36E6CDD93AB9@MRZP264MB3132.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:35;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rm+UcOoqOI/OMXP7u+5Yw7GccefYvxZFWxpNF22cCPobR3EbtA9br+2DaSeNzOe9VS3L0Ln1vvBNgj+YboM0VogKbkgicF0bzs10/2o8vE2FIjSWIx1Exhhvg0VcwTelx/44VTC8ImoHwyG6tjUqV38BE2v+UsXIcgiVY4vSIrZzTo/Ai4OWsCeTXOvrrTMk490ZaU/vLgVviGG6LFO4/C4E5vPw4zy90WyRI5QFFWMwFii46Rh9xneou0DMhwKd84S4vSA5xg2C38HP067vQCMEGWp4mDturhHMLACxkV0dRDhP/qXzpLEPHV64+1mGsIBUr838lllHdodqIsAtfQKOWPrnb0hfvd7jTJiGEWj2PcMbfxCb+57f603d6GCZq/bFd4jF+8ns9Gm217AQYjOIyDD2hYonrpRGThNjE7uZF0UG/OjlwnFwVRTe4tK/ITw/cI8xad360ytgAFshxdgtuInfaZcedlY+o6hi6y9Enyp0TZTs5NcgFviFHkQ+f+gAs4Jw4Wj4Th9HucFofEkuOU6/mXpSyMFRgqloZawC4CvQKQc5jeykRyqQkjEwMriD7FCB2bUApiRDvBHW31LppEWH4faud8WDEo/3dmxENYqHyvhMGUXC+EY3dvO1g7KJS6XLb3tQ5uFLtMUFzvG0w0At9CNV91U5Sp9GVMCcsMpeTi03V6TfSuiG7bpWPNWOZ68W44wGT+8Lv3grkA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(52536014)(2906002)(66556008)(8936002)(66446008)(26005)(66946007)(91956017)(33656002)(7696005)(6506007)(122000001)(38100700002)(76116006)(64756008)(508600001)(5660300002)(316002)(38070700005)(55016002)(71200400001)(186003)(8676002)(83380400001)(9686003)(6916009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vK1M7vwJs7QZplOSpcyNOpRg/ATCqgdmbNITHjuWhz7UO9KjoUISLskgP5?=
 =?iso-8859-1?Q?WH6pgXDF5Mwbcbr8vX7PylzSTz70F6RfXDYLAd44INu0z2qMq2Zztj3htH?=
 =?iso-8859-1?Q?raTWdlmAm73KhPYm8oQUdHxAamU3zf3RAjVVo60Q11GVIMOE4kq1y9ZFT2?=
 =?iso-8859-1?Q?VIMrRu5gHiVX10elM4pkvttSj8r/uvVW4k0/YVza6djAs+o29RqcTmg35v?=
 =?iso-8859-1?Q?7T3ug6pBouzgDe7rFfC1NwMI8eo3lwNNZJj/XGxndIZJJjmIk+WRe/h4P4?=
 =?iso-8859-1?Q?CljVJexl+g79Z4UQA+YBWNZ4Rad0ibCQqhMUY3in56Az16S64uI4SISzQ4?=
 =?iso-8859-1?Q?uxTtGIJ1xePQEPx+RLgtG/HQ4zszWQBdvp0Zo2U+WmwlTsN1I+5Y71hgQp?=
 =?iso-8859-1?Q?vw8iBE5aigSdNWOi1gcDRPazOMYczKKv2DJal/4cT4sK4rqv3IBxu6SUSe?=
 =?iso-8859-1?Q?DaSUm9Hco4kvLPYNoPnAzceHwN6g1q5FXE9LipoSi7MZr8CSJ9Xnt8mo8G?=
 =?iso-8859-1?Q?3wlTXfpq2Lnr7rL4m27CrW+GNn6CTjDtUOUoM3cI/X+XXr+7DvXyfzfiv5?=
 =?iso-8859-1?Q?1b/yA7PrpMQqpACbmPQW+q/uBZHoGRbUWRugb9nQpxzBxEu7CaZ7PFYp4t?=
 =?iso-8859-1?Q?h0mCyek5hgRu1K0LKt0VsKjg0DzHvM9G7GzmnyHl8lqujCznLxXdI3BzZD?=
 =?iso-8859-1?Q?NvR5I2bNLBrunoN6EUj8mDj6wH15Y9p0mEDpmViLpvdGwmqmt57t+EXS/D?=
 =?iso-8859-1?Q?tHSWec8wZQFZoy6Xae/XVi/tl05FbJC2lt2YM3Et2OTihbUE6AdX25/5oZ?=
 =?iso-8859-1?Q?7J301hbPqcfFcHXtgPANB2JFteGDXzsGo0kalQBck/ApWt8lDer+TT4Ztw?=
 =?iso-8859-1?Q?7Yo4ta4BdflhC/MzbY8XThRb+PLsWOTUzRsxcs6ey0y1sSz0xxMWnuaHGr?=
 =?iso-8859-1?Q?HEjw2iz8BrYL2TuPBXVGalTFPM48DOV5ztk/pIz92tRpSHEyLaw3LisjLB?=
 =?iso-8859-1?Q?xN4YbjHpvUWPdHznx0T9US0lF00+aVtZOVPcjTq0LvdfA7BPcDeeTPuMZO?=
 =?iso-8859-1?Q?BDjfVXW3JfPZdbzZ6oBzpeeQcIz7CTGCdjT4SEOW215lBqlAY6iDR13uYz?=
 =?iso-8859-1?Q?vzUpIBj7d55RFPePfez1R4axjlTA0F9bWMICk4ghMM3P/opYf9S4JDBUfj?=
 =?iso-8859-1?Q?Fvfv6DXXRt9UkVnq7RrPi/mk+i8oKt+9bFvA0SlU2Qn+JYSP26e1KTPkeD?=
 =?iso-8859-1?Q?eQy/EMwfEKLX857J7FH3UFd9cwAVXQa7mBoUgUFfazHCAEsvZKrcTfO8cH?=
 =?iso-8859-1?Q?QoiotX9wOKkmWizc0b7x9rPlEfr5XzuCpqEv2OM07e8p474=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa2bc5b-1d0b-47c6-5993-08d984f03b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 15:29:16.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqfF4Ai1Sw4B3uddFSm1eqcuDE6GUV704VCHfY43KDVaCJpfenYVy20mYY9d4/ovBfpwQEpiKmrFl1+wFlUhNVR5NQMCewhRwKolcvLp0/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3132

Hidden services shall always be connectable, even after been removed.=0A=
When a hidden service is removed, the associated iwd network stays as=0A=
known and thus shall be connected as a visible network.=0A=
---=0A=
=A0plugins/iwd.c | 71 +++++++++++++++++++++++++++++++++++++++------------=
=0A=
=A01 file changed, 54 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index 961d53196207..9bd27e90c346 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -140,6 +140,7 @@ struct iwd_station {=0A=
=A0	bool scanning;=0A=
=A0=0A=
=A0	GHashTable *hidden_aps;=0A=
+	GHashTable *hidden_networks;=0A=
=A0	struct hidden_params *hidden;=0A=
=A0	bool postpone_hidden;=0A=
=A0};=0A=
@@ -646,6 +647,37 @@ static void hidden_params_free(gpointer data)=0A=
=A0	g_free(hidden);=0A=
=A0}=0A=
=A0=0A=
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
+	if (err =3D=3D -EINPROGRESS)=0A=
+		err =3D 0;=0A=
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
=A0static void cm_device_scan_cb(DBusMessage *message, void *user_data)=0A=
=A0{=0A=
=A0	const char *path =3D user_data;=0A=
@@ -669,13 +701,7 @@ static void cm_device_scan_cb(DBusMessage *message, vo=
id *user_data)=0A=
=A0		iwds->hidden =3D NULL;=0A=
=A0	} else {=0A=
=A0		iwds->postpone_hidden =3D false;=0A=
-		if (!g_dbus_proxy_method_call(iwds->proxy,=0A=
-				"ConnectHiddenNetwork",=0A=
-				hidden_network_connect_append,=0A=
-				cm_hidden_network_connect_cb,=0A=
-				iwds->hidden, hidden_params_free)) {=0A=
-			iwds->hidden =3D NULL;=0A=
-		}=0A=
+		connect_hidden(iwds);=0A=
=A0	}=0A=
=A0}=0A=
=A0=0A=
@@ -740,15 +766,7 @@ static int cm_device_scan(struct connman_device *devic=
e,=0A=
=A0			return 0;=0A=
=A0		}=0A=
=A0=0A=
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
=A0	}=0A=
=A0}=0A=
=A0=0A=
@@ -1298,8 +1316,23 @@ static void network_property_change(GDBusProxy *prox=
y, const char *name,=0A=
=A0=0A=
=A0		iwdkn =3D g_hash_table_lookup(known_networks,=0A=
=A0					iwdn->known_network);=0A=
-		if (iwdkn)=0A=
+		if (iwdkn) {=0A=
=A0			update_auto_connect(iwdkn);=0A=
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
=A0	}=0A=
=A0}=0A=
=A0=0A=
@@ -1659,6 +1692,7 @@ static void station_free(gpointer data)=0A=
=A0	g_free(iwds->path);=0A=
=A0	g_free(iwds->connected_network);=0A=
=A0	g_hash_table_destroy(iwds->hidden_aps);=0A=
+	g_hash_table_destroy(iwds->hidden_networks);=0A=
=A0	g_free(iwds->hidden);=0A=
=A0	g_free(iwds);=0A=
=A0}=0A=
@@ -2042,6 +2076,9 @@ static void create_station(GDBusProxy *proxy)=0A=
=A0	iwds->hidden_aps =3D g_hash_table_new_full(g_str_hash, g_str_equal, NUL=
L,=0A=
=A0			hidden_ap_free);=0A=
=A0=0A=
+	iwds->hidden_networks =3D g_hash_table_new_full(g_str_hash, g_str_equal,=
=0A=
+			g_free, NULL);=0A=
+=0A=
=A0	iwds->hidden =3D NULL;=0A=
=A0	iwds->postpone_hidden =3D false;=0A=
=A0=0A=
-- =0A=
2.25.1=0A=
