Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2043.outbound.protection.outlook.com [40.107.12.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839896117
	for <connman@lists.linux.dev>; Fri, 16 Jun 2023 09:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnckjX/Z+Uvy75Py1Sx4T2RZi7X+wO/Ux37zbFyw8nn9Qr4KsWl64jvqoi/+H8U42IftEMM77lM6bnF7c7ULaFg0JdqsJtTvtH4sf6lMRkWQVw7MQ3EFqd8k6wL+tezMzTDrcydbI5C0E5VzzLoywlzp0oFPr3dgNlbm09g7jDk9puot+SHEEodBDVlhoDrWDzfeWJLmbpuzg8pL8jowfKDckeDqpPU0nB5oULNxOtgbGzYaexZyvUzFeWJILtF2Cr7CVAYChdGu6GMSWznAVL/8g3qZCSUH5CV4gPsHWfomzMaV6lRXi9o4VkqWko0K+Z68QNj8g0DIoX/hPSO/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrpOu7yig5R3I7/cgvKrH7Q1IYpbJfAqYatSdjqh4c4=;
 b=Md0GE9E3oxYedFSL8YzUGFh5NK/XOwDLT2+mDoq5kXk5/4h4WPzIP4VmKbg7gVYE3z/hCEPwpWpuJ2srx0DPUE7FdlCSViAeyQNjhm0BcmyGnfb4BNusV2bsxtwIs1B4KrdoPVUyuCQPbq3lKk1E5F5XVuSTXZtGbG0dhyBOeDIsbApdygzSjEc66U/z96Vq3wj4Mger2N/di0dpvM4kL2eIuTe6Zt9P+LBv/sGzxoBncqCjoPuHli09SWwcCi5kGO6NMbo+bT5Ccb9KL1nGAnFGlI3EgxisPz7h4Ww9LML3jtaFRH1wfUpjQtDriDgGYirba/2M/VTz5NVr5CmrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrpOu7yig5R3I7/cgvKrH7Q1IYpbJfAqYatSdjqh4c4=;
 b=Y1FEhZtZneVdvc4BHawT34HDN3HWwz0383Zk8UpalC+/92XmdeOTd2tC17FsYw3HSqeH3VRODSlBkA8hCeXK/6DCbnZ79mz/cpYH0AfvVnn1CEEMc1QG+S8YjFUkJrhOvbPLGa5FI5vbQP2PSjpNNqzBxixYcevwXxKJWpGZ1II=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB1940.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.29; Fri, 16 Jun 2023 09:51:46 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9931:1e3c:ecd8:dc54]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9931:1e3c:ecd8:dc54%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 09:51:45 +0000
From: "VAUTRIN Emmanuel (Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Fix invalid-key error on user reconnection
Thread-Topic: [PATCH] iwd: Fix invalid-key error on user reconnection
Thread-Index: AQHZoDeVx0itD82rVka+jGKNuaY1qg==
Date: Fri, 16 Jun 2023 09:51:44 +0000
Message-ID:
 <MRZP264MB1544B4C51B01525FE4CBA6C19358A@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB1544:EE_|MR1P264MB1940:EE_
x-ms-office365-filtering-correlation-id: 6ab66eeb-73ff-43c4-e822-08db6e4f4b81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JMonf6Fd4M1ZPnMEkkoJuJ8Af5bKABsQlG7PuYXbr8wGktDGQ42A0eSjnfUw+kasfshxsP0NZiERCsmJET/9uXeaTjFv2iazivMoABDwjliZEg17yyGstZKfbUslNItb8RYQC3cLM1o5wi2r4rH7ByHavUstUALSlox5W6hCTDGn+fzPgdl3qThLzIf6YPdeRsDz2DY9wlkFY1RgiJtaVgYk9D6B1grvKv3qRfS2n27XakTouJjSW5XqDI36Kqh+OJXhOl1HYffHBX9geoUZV5WotsiH1/g6skeOM0SnzS0JDJOkv7ZXZW+QTnssbvk6dJ/92HVuc7NGIR8Igw0+YKQFuElL5yyWJeEbb0fMsvW39dLbxPXtIY3yqTJfg1QM0CBW5hOFjOeuIbCFY5W6nymWVX9vgIA4cySGHJwlCAPJzlNQcUGlZi6zpvOoT9G1gXnm7mPHXPb1eQmshgKgejR2q6QhiG9dzOmZ2a/wJq9SguCD0HBorwXdyH6RYaOOQ8oPBm5d2hIUui2NKdXTsJy/s+aWHjZFHKRC18/A5DHSsVp9JyXfX6SPnpDbigpi4Afi2GXUMl3bBsVXvVn+QCBmJITC8LLU0hOdSoZfh/ZGUrdyPIXddAbxfx5RL8Zp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(5660300002)(8676002)(52536014)(86362001)(83380400001)(8936002)(99936003)(38100700002)(316002)(41300700001)(38070700005)(66446008)(64756008)(66946007)(33656002)(66556008)(66476007)(76116006)(6916009)(91956017)(122000001)(186003)(478600001)(9686003)(6506007)(2906002)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RLj8WkuXs9LXI3rGfN16NY45RdTQZUsjsek73fozACiy7t5bCklSJfPo5u?=
 =?iso-8859-1?Q?5XGbhrYcvAJyV3JGQlO9aPpxCKBZCwHqGmfWcCZO2PcFl5kBjGBF1PpUpA?=
 =?iso-8859-1?Q?HHnUlzpRzKtmu/jG4hgl8+orN5PKvbVJUnBgns35R2WOzUB9TtXwe/bCXz?=
 =?iso-8859-1?Q?z/Zc0BdnZN0OhLKDPzfkCIY6FSeAFb1lJCgeuWpePNXXc8Noyd00XydrvJ?=
 =?iso-8859-1?Q?8HdB1SHy/lMGCgAaO3uaFZ2dUVHwSlS6ecPCx466DaV5VtrljqHdXqP92w?=
 =?iso-8859-1?Q?LjOJAszms9McfMgpTuq3rXjOLm1+yC4rW/zEt4T6k4fO6lcv6PuIYTHfN1?=
 =?iso-8859-1?Q?8dhY7nYNlzI/PKob1o1vHgou1/S/6JnWse3msDxUE5uHN3stjEeBeEJAfM?=
 =?iso-8859-1?Q?j+UbN4j+tyknlHX/gqJXMu7d7bpA5U6HNK43P+kQvJeMgIIMt4Ne2vIpRo?=
 =?iso-8859-1?Q?vJPr3Wnq6fBNt+SP5o33NDKS5XbkZ+/SaqulLcTHwNxGUxBdQ6m6wt/u0p?=
 =?iso-8859-1?Q?1Ga5EzuQV2t2ygVPKX2hOL4NvML4dry765sgphaHDPzZ2bhHRmg6K8s/y+?=
 =?iso-8859-1?Q?xuvMblocrXK3VPd0GTSSqyXH1VdAzWF4dL5FGIXDgLsLfs4dDZmS7jWeMC?=
 =?iso-8859-1?Q?zbvBFHUpMKjQcmX8gCHXw7/WVWg6BhZPEB9T/fLPFLz9wGp1PD7dMzAumx?=
 =?iso-8859-1?Q?Mgge6xvvXA6gMStp29V7ZZH5z5W7f0N3Wkp5ANr8NRKNiSVwdFKCLsNIs9?=
 =?iso-8859-1?Q?WrNyY/lGOMB16LiLYWA9bldX6xW1RZB/23jXSrgCi4oRQq149nOLbp8Dwi?=
 =?iso-8859-1?Q?p1kCx0CCzjjWpVXZOQXcbZbewaZNTwFiL4IToYHDoc3xKwY6qJ/yFTeo4/?=
 =?iso-8859-1?Q?HsYHjQgpY/goq3t/rSV75LDgvbG/IbsBSbvxDXchK9CqyqSOl0kPoPEN5T?=
 =?iso-8859-1?Q?LjXlw8II2ue7zcTcnJc7SkI0CRBc/2dD063kaZCV0INysOMa6JzBJBz69c?=
 =?iso-8859-1?Q?dbXMxSryMjTgpeSCMXMEtrnlwKV8QYpi2FNaoIBs2bzmz8tqunD1veyIUd?=
 =?iso-8859-1?Q?mnWTjs7A4waxjvq+1kFbgi2jbNy/ASSR55+aZoo5Vxpcd1qqS/y+I9qsxq?=
 =?iso-8859-1?Q?HBBb2P/NfPdwTlSZmT4aBATsavztd3U8YpUUOZEQVlt7DdXhG5jcADqbn2?=
 =?iso-8859-1?Q?Z9qYbP58q1gufkFI5bV4TWiC8O8acgpxuLmoeu4jrG65yNnsE5ysww3/HH?=
 =?iso-8859-1?Q?rcBfa0fGa4CgZbORCNxwcq75J2bCzNOxnY/sM2nti59PySUcmpJBZsYdK5?=
 =?iso-8859-1?Q?pmDTraPeNjHG8hPDyApfuIXpPk5uPqqzo+VaQanygg5fSw5HZoUhPqPL53?=
 =?iso-8859-1?Q?+g0w9439IpuFQu5Krtby4V2A9LGMSvL3M3jPm94Ht9yKv+htLk6K47h2ta?=
 =?iso-8859-1?Q?7ZQjck3im4jsIFGzRDYGQP3ly7lSPV4D9AFe8+9ALMejW0AehDNCLT7hD7?=
 =?iso-8859-1?Q?59pmhLD2GcirSeXHTGILZA6MIJg81FMAUnCjBoT1zZqSMTXJWdxxY8QekC?=
 =?iso-8859-1?Q?Sla+xtYMUmtT6183dvqJyGdvhas3K6fl4ZJCotktWgcnwWcddnhH4a9Iy3?=
 =?iso-8859-1?Q?3yOi3ky5y/hZQUZvOZtZamlrT8JThywwkfz5pCSrFuimftuQDNWRbuWK6C?=
 =?iso-8859-1?Q?OXXZazoWzOpRrNoN9Yl74OG7jmfU1BdZaiDAbB3Fu5J2zeZE4aeqEH4GTh?=
 =?iso-8859-1?Q?4WjQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB1544B4C51B01525FE4CBA6C19358AMRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab66eeb-73ff-43c4-e822-08db6e4f4b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 09:51:45.0821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRCig2H0cV6PYx2DKH8bAcr4VLCSGPBBp4QHI9LTttPSMZ2yAiA57NmKc4KXVXtPOz0sKsH+Fi/cbI4Ykg8ej6VsYWtDqATp1qd3tTCVm5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1940

--_002_MRZP264MB1544B4C51B01525FE4CBA6C19358AMRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Connecting to a WiFi network under disconnection leads to an=0A=
invalid-key error, when the disconnection callback tries to reset the=0A=
connected status and the network is still connecting or associating.=0A=
In this case, connman_network_set_connected() sets a=0A=
CONNMAN_NETWORK_ERROR_CONNECT_FAIL error, which shall be ignored.=0A=
---=0A=
 plugins/iwd.c | 118 +++++++++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 106 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index 2fe49a23316b..1955140d3fcf 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -90,6 +90,10 @@ struct iwd_device {=0A=
 	char *mode;=0A=
 =0A=
 	struct connman_device *device;=0A=
+=0A=
+	char *network;=0A=
+	char *pending_network;=0A=
+	bool disconnecting;=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -243,12 +247,6 @@ static void update_network_connected(struct iwd_networ=
k *iwdn)=0A=
 	connman_network_set_connected(iwdn->network, true);=0A=
 }=0A=
 =0A=
-static void update_network_disconnected(struct iwd_network *iwdn)=0A=
-{=0A=
-	DBG("interface name %s", iwdn->name);=0A=
-	connman_network_set_connected(iwdn->network, false);=0A=
-}=0A=
-=0A=
 static void cm_network_connect_cb(DBusMessage *message, void *user_data)=
=0A=
 {=0A=
 	const char *path =3D user_data;=0A=
@@ -279,21 +277,58 @@ static void cm_network_connect_cb(DBusMessage *messag=
e, void *user_data)=0A=
 	update_network_connected(iwdn);=0A=
 }=0A=
 =0A=
+static void abort_pending_network(struct iwd_device *iwdd,=0A=
+					enum connman_network_error error)=0A=
+{=0A=
+	struct iwd_network *iwdn;=0A=
+=0A=
+	if (!iwdd->pending_network)=0A=
+		return;=0A=
+=0A=
+	iwdn =3D g_hash_table_lookup(networks, iwdd->pending_network);=0A=
+	if (iwdn)=0A=
+		connman_network_set_error(iwdn->network, error);=0A=
+=0A=
+	g_free(iwdd->pending_network);=0A=
+	iwdd->pending_network =3D NULL;=0A=
+}=0A=
+=0A=
 static int cm_network_connect(struct connman_network *network)=0A=
 {=0A=
 	struct iwd_network *iwdn =3D connman_network_get_data(network);=0A=
+	struct iwd_device *iwdd;=0A=
+	int err;=0A=
 =0A=
-	if (!iwdn)=0A=
+	if (!iwdn || !iwdn->iwdd)=0A=
 		return -EINVAL;=0A=
 =0A=
+	iwdd =3D iwdn->iwdd;=0A=
+	if (iwdd->disconnecting) {=0A=
+		if (g_strcmp0(iwdn->path, iwdd->pending_network)) {=0A=
+			abort_pending_network(iwdd,=0A=
+					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);=0A=
+			iwdd->pending_network =3D g_strdup(iwdn->path);=0A=
+		}=0A=
+		return -EINPROGRESS;=0A=
+	}=0A=
+=0A=
 	if (!g_dbus_proxy_method_call(iwdn->proxy, "Connect",=0A=
 			NULL, cm_network_connect_cb,=0A=
-			g_strdup(iwdn->path), g_free))=0A=
-		return -EIO;=0A=
+			g_strdup(iwdn->path), g_free)) {=0A=
+		err =3D -EIO;=0A=
+		goto out;=0A=
+	}=0A=
 =0A=
 	connman_network_set_associating(iwdn->network, true);=0A=
 =0A=
-	return -EINPROGRESS;=0A=
+	g_free(iwdd->network);=0A=
+	iwdd->network =3D g_strdup(iwdn->path);=0A=
+=0A=
+	err =3D -EINPROGRESS;=0A=
+=0A=
+out:=0A=
+	abort_pending_network(iwdd, CONNMAN_NETWORK_ERROR_UNKNOWN);=0A=
+	return err;=0A=
 }=0A=
 =0A=
 static void cm_network_forget_cb(DBusMessage *message, void *user_data)=0A=
@@ -336,6 +371,45 @@ static int cm_network_forget(struct connman_network *n=
etwork)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static void update_network_disconnected(struct iwd_network *iwdn)=0A=
+{=0A=
+	struct iwd_network *iwdn_pending =3D NULL;=0A=
+	struct iwd_device *iwdd;=0A=
+=0A=
+	if (!iwdn || !iwdn->iwdd)=0A=
+		return;=0A=
+=0A=
+	iwdd =3D iwdn->iwdd;=0A=
+=0A=
+	DBG("interface name %s", iwdn->name);=0A=
+=0A=
+	if (iwdd->pending_network) {=0A=
+		iwdn_pending =3D=0A=
+			g_hash_table_lookup(networks, iwdd->pending_network);=0A=
+	}=0A=
+=0A=
+	if (!iwdn_pending || g_strcmp0(iwdn->path, iwdd->pending_network))=0A=
+		connman_network_set_connected(iwdn->network, false);=0A=
+=0A=
+	iwdd->disconnecting =3D false;=0A=
+=0A=
+	if (g_strcmp0(iwdn->path, iwdd->network)) {=0A=
+		if (!g_strcmp0(iwdn->path, iwdd->pending_network)) {=0A=
+			abort_pending_network(iwdd,=0A=
+					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);=0A=
+		}=0A=
+		DBG("current wifi network has changed since disconnection");=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	g_free(iwdd->network);=0A=
+	iwdd->network =3D NULL;=0A=
+=0A=
+	if (iwdn_pending) {=0A=
+		cm_network_connect(iwdn_pending->network);=0A=
+	}=0A=
+}=0A=
+=0A=
 static void cm_network_disconnect_cb(DBusMessage *message, void *user_data=
)=0A=
 {=0A=
 	const char *path =3D user_data;=0A=
@@ -345,6 +419,9 @@ static void cm_network_disconnect_cb(DBusMessage *messa=
ge, void *user_data)=0A=
 	if (!iwdn)=0A=
 		return;=0A=
 =0A=
+	if (iwdn->iwdd)=0A=
+		iwdn->iwdd->disconnecting =3D false;=0A=
+=0A=
 	if (dbus_message_get_type(message) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {=0A=
 		const char *dbus_error =3D dbus_message_get_error_name(message);=0A=
 =0A=
@@ -369,11 +446,16 @@ static int cm_network_disconnect(struct connman_netwo=
rk *network)=0A=
 {=0A=
 	struct iwd_network *iwdn =3D connman_network_get_data(network);=0A=
 	struct iwd_station *iwds;=0A=
+	struct iwd_device *iwdd;=0A=
 =0A=
-	if (!iwdn && !iwdn->iwdd)=0A=
+	if (!iwdn || !iwdn->iwdd)=0A=
 		return -EINVAL;=0A=
 =0A=
-	iwds =3D g_hash_table_lookup(stations, iwdn->iwdd->path);=0A=
+	iwdd =3D iwdn->iwdd;=0A=
+	if (iwdd->disconnecting)=0A=
+		return -EALREADY;=0A=
+=0A=
+	iwds =3D g_hash_table_lookup(stations, iwdd->path);=0A=
 	if (!iwds)=0A=
 		return -EIO;=0A=
 =0A=
@@ -383,6 +465,8 @@ static int cm_network_disconnect(struct connman_network=
 *network)=0A=
 			NULL, cm_network_disconnect_cb, g_strdup(iwdn->path), g_free))=0A=
 		return -EIO;=0A=
 =0A=
+	iwdd->disconnecting =3D true;=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -582,6 +666,12 @@ static void device_powered_cb(const DBusError *error, =
void *user_data)=0A=
 	}=0A=
 =0A=
 	connman_device_set_powered(iwdd->device, cbd->powered);=0A=
+=0A=
+	if (!cbd->powered) {=0A=
+		abort_pending_network(iwdd,=0A=
+					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);=0A=
+		iwdd->disconnecting =3D false;=0A=
+	}=0A=
 out:=0A=
 	g_free(cbd->path);=0A=
 	g_free(cbd);=0A=
@@ -1424,6 +1514,10 @@ static void device_free(gpointer data)=0A=
 	g_free(iwdd->adapter);=0A=
 	g_free(iwdd->name);=0A=
 	g_free(iwdd->address);=0A=
+=0A=
+	g_free(iwdd->network);=0A=
+	g_free(iwdd->pending_network);=0A=
+=0A=
 	g_free(iwdd);=0A=
 }=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=

--_002_MRZP264MB1544B4C51B01525FE4CBA6C19358AMRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-iwd-Fix-invalid-key-error-on-user-reconnection.patch"
Content-Description: 0001-iwd-Fix-invalid-key-error-on-user-reconnection.patch
Content-Disposition: attachment;
	filename="0001-iwd-Fix-invalid-key-error-on-user-reconnection.patch";
	size=5660; creation-date="Fri, 16 Jun 2023 09:51:02 GMT";
	modification-date="Fri, 16 Jun 2023 09:51:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwY2E3MzRhZTc3ZTJjZTQzMmVkMTQ1Mzc3MjAyYmU3MTU0OTRmMGE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IEZyaSwgMTYgSnVuIDIwMjMgMDk6Mzk6MzYgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBpd2Q6IEZpeCBpbnZhbGlkLWtleSBlcnJvciBvbiB1c2VyIHJlY29ubmVjdGlv
bgoKQ29ubmVjdGluZyB0byBhIFdpRmkgbmV0d29yayB1bmRlciBkaXNjb25uZWN0aW9uIGxlYWRz
IHRvIGFuCmludmFsaWQta2V5IGVycm9yLCB3aGVuIHRoZSBkaXNjb25uZWN0aW9uIGNhbGxiYWNr
IHRyaWVzIHRvIHJlc2V0IHRoZQpjb25uZWN0ZWQgc3RhdHVzIGFuZCB0aGUgbmV0d29yayBpcyBz
dGlsbCBjb25uZWN0aW5nIG9yIGFzc29jaWF0aW5nLgpJbiB0aGlzIGNhc2UsIGNvbm5tYW5fbmV0
d29ya19zZXRfY29ubmVjdGVkKCkgc2V0cyBhCkNPTk5NQU5fTkVUV09SS19FUlJPUl9DT05ORUNU
X0ZBSUwgZXJyb3IsIHdoaWNoIHNoYWxsIGJlIGlnbm9yZWQuCi0tLQogcGx1Z2lucy9pd2QuYyB8
IDExOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9wbHVnaW5zL2l3ZC5jIGIvcGx1Z2lucy9pd2QuYwppbmRleCAyZmU0OWEyMzMxNmIu
LjE5NTUxNDBkM2ZjZiAxMDA2NDQKLS0tIGEvcGx1Z2lucy9pd2QuYworKysgYi9wbHVnaW5zL2l3
ZC5jCkBAIC05MCw2ICs5MCwxMCBAQCBzdHJ1Y3QgaXdkX2RldmljZSB7CiAJY2hhciAqbW9kZTsK
IAogCXN0cnVjdCBjb25ubWFuX2RldmljZSAqZGV2aWNlOworCisJY2hhciAqbmV0d29yazsKKwlj
aGFyICpwZW5kaW5nX25ldHdvcms7CisJYm9vbCBkaXNjb25uZWN0aW5nOwogfTsKIAogLyoKQEAg
LTI0MywxMiArMjQ3LDYgQEAgc3RhdGljIHZvaWQgdXBkYXRlX25ldHdvcmtfY29ubmVjdGVkKHN0
cnVjdCBpd2RfbmV0d29yayAqaXdkbikKIAljb25ubWFuX25ldHdvcmtfc2V0X2Nvbm5lY3RlZChp
d2RuLT5uZXR3b3JrLCB0cnVlKTsKIH0KIAotc3RhdGljIHZvaWQgdXBkYXRlX25ldHdvcmtfZGlz
Y29ubmVjdGVkKHN0cnVjdCBpd2RfbmV0d29yayAqaXdkbikKLXsKLQlEQkcoImludGVyZmFjZSBu
YW1lICVzIiwgaXdkbi0+bmFtZSk7Ci0JY29ubm1hbl9uZXR3b3JrX3NldF9jb25uZWN0ZWQoaXdk
bi0+bmV0d29yaywgZmFsc2UpOwotfQotCiBzdGF0aWMgdm9pZCBjbV9uZXR3b3JrX2Nvbm5lY3Rf
Y2IoREJ1c01lc3NhZ2UgKm1lc3NhZ2UsIHZvaWQgKnVzZXJfZGF0YSkKIHsKIAljb25zdCBjaGFy
ICpwYXRoID0gdXNlcl9kYXRhOwpAQCAtMjc5LDIxICsyNzcsNTggQEAgc3RhdGljIHZvaWQgY21f
bmV0d29ya19jb25uZWN0X2NiKERCdXNNZXNzYWdlICptZXNzYWdlLCB2b2lkICp1c2VyX2RhdGEp
CiAJdXBkYXRlX25ldHdvcmtfY29ubmVjdGVkKGl3ZG4pOwogfQogCitzdGF0aWMgdm9pZCBhYm9y
dF9wZW5kaW5nX25ldHdvcmsoc3RydWN0IGl3ZF9kZXZpY2UgKml3ZGQsCisJCQkJCWVudW0gY29u
bm1hbl9uZXR3b3JrX2Vycm9yIGVycm9yKQoreworCXN0cnVjdCBpd2RfbmV0d29yayAqaXdkbjsK
KworCWlmICghaXdkZC0+cGVuZGluZ19uZXR3b3JrKQorCQlyZXR1cm47CisKKwlpd2RuID0gZ19o
YXNoX3RhYmxlX2xvb2t1cChuZXR3b3JrcywgaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsKKwlpZiAo
aXdkbikKKwkJY29ubm1hbl9uZXR3b3JrX3NldF9lcnJvcihpd2RuLT5uZXR3b3JrLCBlcnJvcik7
CisKKwlnX2ZyZWUoaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsKKwlpd2RkLT5wZW5kaW5nX25ldHdv
cmsgPSBOVUxMOworfQorCiBzdGF0aWMgaW50IGNtX25ldHdvcmtfY29ubmVjdChzdHJ1Y3QgY29u
bm1hbl9uZXR3b3JrICpuZXR3b3JrKQogewogCXN0cnVjdCBpd2RfbmV0d29yayAqaXdkbiA9IGNv
bm5tYW5fbmV0d29ya19nZXRfZGF0YShuZXR3b3JrKTsKKwlzdHJ1Y3QgaXdkX2RldmljZSAqaXdk
ZDsKKwlpbnQgZXJyOwogCi0JaWYgKCFpd2RuKQorCWlmICghaXdkbiB8fCAhaXdkbi0+aXdkZCkK
IAkJcmV0dXJuIC1FSU5WQUw7CiAKKwlpd2RkID0gaXdkbi0+aXdkZDsKKwlpZiAoaXdkZC0+ZGlz
Y29ubmVjdGluZykgeworCQlpZiAoZ19zdHJjbXAwKGl3ZG4tPnBhdGgsIGl3ZGQtPnBlbmRpbmdf
bmV0d29yaykpIHsKKwkJCWFib3J0X3BlbmRpbmdfbmV0d29yayhpd2RkLAorCQkJCQlDT05OTUFO
X05FVFdPUktfRVJST1JfQ09OTkVDVF9GQUlMKTsKKwkJCWl3ZGQtPnBlbmRpbmdfbmV0d29yayA9
IGdfc3RyZHVwKGl3ZG4tPnBhdGgpOworCQl9CisJCXJldHVybiAtRUlOUFJPR1JFU1M7CisJfQor
CiAJaWYgKCFnX2RidXNfcHJveHlfbWV0aG9kX2NhbGwoaXdkbi0+cHJveHksICJDb25uZWN0IiwK
IAkJCU5VTEwsIGNtX25ldHdvcmtfY29ubmVjdF9jYiwKLQkJCWdfc3RyZHVwKGl3ZG4tPnBhdGgp
LCBnX2ZyZWUpKQotCQlyZXR1cm4gLUVJTzsKKwkJCWdfc3RyZHVwKGl3ZG4tPnBhdGgpLCBnX2Zy
ZWUpKSB7CisJCWVyciA9IC1FSU87CisJCWdvdG8gb3V0OworCX0KIAogCWNvbm5tYW5fbmV0d29y
a19zZXRfYXNzb2NpYXRpbmcoaXdkbi0+bmV0d29yaywgdHJ1ZSk7CiAKLQlyZXR1cm4gLUVJTlBS
T0dSRVNTOworCWdfZnJlZShpd2RkLT5uZXR3b3JrKTsKKwlpd2RkLT5uZXR3b3JrID0gZ19zdHJk
dXAoaXdkbi0+cGF0aCk7CisKKwllcnIgPSAtRUlOUFJPR1JFU1M7CisKK291dDoKKwlhYm9ydF9w
ZW5kaW5nX25ldHdvcmsoaXdkZCwgQ09OTk1BTl9ORVRXT1JLX0VSUk9SX1VOS05PV04pOworCXJl
dHVybiBlcnI7CiB9CiAKIHN0YXRpYyB2b2lkIGNtX25ldHdvcmtfZm9yZ2V0X2NiKERCdXNNZXNz
YWdlICptZXNzYWdlLCB2b2lkICp1c2VyX2RhdGEpCkBAIC0zMzYsNiArMzcxLDQ1IEBAIHN0YXRp
YyBpbnQgY21fbmV0d29ya19mb3JnZXQoc3RydWN0IGNvbm5tYW5fbmV0d29yayAqbmV0d29yaykK
IAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIHZvaWQgdXBkYXRlX25ldHdvcmtfZGlzY29ubmVjdGVk
KHN0cnVjdCBpd2RfbmV0d29yayAqaXdkbikKK3sKKwlzdHJ1Y3QgaXdkX25ldHdvcmsgKml3ZG5f
cGVuZGluZyA9IE5VTEw7CisJc3RydWN0IGl3ZF9kZXZpY2UgKml3ZGQ7CisKKwlpZiAoIWl3ZG4g
fHwgIWl3ZG4tPml3ZGQpCisJCXJldHVybjsKKworCWl3ZGQgPSBpd2RuLT5pd2RkOworCisJREJH
KCJpbnRlcmZhY2UgbmFtZSAlcyIsIGl3ZG4tPm5hbWUpOworCisJaWYgKGl3ZGQtPnBlbmRpbmdf
bmV0d29yaykgeworCQlpd2RuX3BlbmRpbmcgPQorCQkJZ19oYXNoX3RhYmxlX2xvb2t1cChuZXR3
b3JrcywgaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsKKwl9CisKKwlpZiAoIWl3ZG5fcGVuZGluZyB8
fCBnX3N0cmNtcDAoaXdkbi0+cGF0aCwgaXdkZC0+cGVuZGluZ19uZXR3b3JrKSkKKwkJY29ubm1h
bl9uZXR3b3JrX3NldF9jb25uZWN0ZWQoaXdkbi0+bmV0d29yaywgZmFsc2UpOworCisJaXdkZC0+
ZGlzY29ubmVjdGluZyA9IGZhbHNlOworCisJaWYgKGdfc3RyY21wMChpd2RuLT5wYXRoLCBpd2Rk
LT5uZXR3b3JrKSkgeworCQlpZiAoIWdfc3RyY21wMChpd2RuLT5wYXRoLCBpd2RkLT5wZW5kaW5n
X25ldHdvcmspKSB7CisJCQlhYm9ydF9wZW5kaW5nX25ldHdvcmsoaXdkZCwKKwkJCQkJQ09OTk1B
Tl9ORVRXT1JLX0VSUk9SX0NPTk5FQ1RfRkFJTCk7CisJCX0KKwkJREJHKCJjdXJyZW50IHdpZmkg
bmV0d29yayBoYXMgY2hhbmdlZCBzaW5jZSBkaXNjb25uZWN0aW9uIik7CisJCXJldHVybjsKKwl9
CisKKwlnX2ZyZWUoaXdkZC0+bmV0d29yayk7CisJaXdkZC0+bmV0d29yayA9IE5VTEw7CisKKwlp
ZiAoaXdkbl9wZW5kaW5nKSB7CisJCWNtX25ldHdvcmtfY29ubmVjdChpd2RuX3BlbmRpbmctPm5l
dHdvcmspOworCX0KK30KKwogc3RhdGljIHZvaWQgY21fbmV0d29ya19kaXNjb25uZWN0X2NiKERC
dXNNZXNzYWdlICptZXNzYWdlLCB2b2lkICp1c2VyX2RhdGEpCiB7CiAJY29uc3QgY2hhciAqcGF0
aCA9IHVzZXJfZGF0YTsKQEAgLTM0NSw2ICs0MTksOSBAQCBzdGF0aWMgdm9pZCBjbV9uZXR3b3Jr
X2Rpc2Nvbm5lY3RfY2IoREJ1c01lc3NhZ2UgKm1lc3NhZ2UsIHZvaWQgKnVzZXJfZGF0YSkKIAlp
ZiAoIWl3ZG4pCiAJCXJldHVybjsKIAorCWlmIChpd2RuLT5pd2RkKQorCQlpd2RuLT5pd2RkLT5k
aXNjb25uZWN0aW5nID0gZmFsc2U7CisKIAlpZiAoZGJ1c19tZXNzYWdlX2dldF90eXBlKG1lc3Nh
Z2UpID09IERCVVNfTUVTU0FHRV9UWVBFX0VSUk9SKSB7CiAJCWNvbnN0IGNoYXIgKmRidXNfZXJy
b3IgPSBkYnVzX21lc3NhZ2VfZ2V0X2Vycm9yX25hbWUobWVzc2FnZSk7CiAKQEAgLTM2OSwxMSAr
NDQ2LDE2IEBAIHN0YXRpYyBpbnQgY21fbmV0d29ya19kaXNjb25uZWN0KHN0cnVjdCBjb25ubWFu
X25ldHdvcmsgKm5ldHdvcmspCiB7CiAJc3RydWN0IGl3ZF9uZXR3b3JrICppd2RuID0gY29ubm1h
bl9uZXR3b3JrX2dldF9kYXRhKG5ldHdvcmspOwogCXN0cnVjdCBpd2Rfc3RhdGlvbiAqaXdkczsK
KwlzdHJ1Y3QgaXdkX2RldmljZSAqaXdkZDsKIAotCWlmICghaXdkbiAmJiAhaXdkbi0+aXdkZCkK
KwlpZiAoIWl3ZG4gfHwgIWl3ZG4tPml3ZGQpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JaXdkcyA9
IGdfaGFzaF90YWJsZV9sb29rdXAoc3RhdGlvbnMsIGl3ZG4tPml3ZGQtPnBhdGgpOworCWl3ZGQg
PSBpd2RuLT5pd2RkOworCWlmIChpd2RkLT5kaXNjb25uZWN0aW5nKQorCQlyZXR1cm4gLUVBTFJF
QURZOworCisJaXdkcyA9IGdfaGFzaF90YWJsZV9sb29rdXAoc3RhdGlvbnMsIGl3ZGQtPnBhdGgp
OwogCWlmICghaXdkcykKIAkJcmV0dXJuIC1FSU87CiAKQEAgLTM4Myw2ICs0NjUsOCBAQCBzdGF0
aWMgaW50IGNtX25ldHdvcmtfZGlzY29ubmVjdChzdHJ1Y3QgY29ubm1hbl9uZXR3b3JrICpuZXR3
b3JrKQogCQkJTlVMTCwgY21fbmV0d29ya19kaXNjb25uZWN0X2NiLCBnX3N0cmR1cChpd2RuLT5w
YXRoKSwgZ19mcmVlKSkKIAkJcmV0dXJuIC1FSU87CiAKKwlpd2RkLT5kaXNjb25uZWN0aW5nID0g
dHJ1ZTsKKwogCXJldHVybiAwOwogfQogCkBAIC01ODIsNiArNjY2LDEyIEBAIHN0YXRpYyB2b2lk
IGRldmljZV9wb3dlcmVkX2NiKGNvbnN0IERCdXNFcnJvciAqZXJyb3IsIHZvaWQgKnVzZXJfZGF0
YSkKIAl9CiAKIAljb25ubWFuX2RldmljZV9zZXRfcG93ZXJlZChpd2RkLT5kZXZpY2UsIGNiZC0+
cG93ZXJlZCk7CisKKwlpZiAoIWNiZC0+cG93ZXJlZCkgeworCQlhYm9ydF9wZW5kaW5nX25ldHdv
cmsoaXdkZCwKKwkJCQkJQ09OTk1BTl9ORVRXT1JLX0VSUk9SX0NPTk5FQ1RfRkFJTCk7CisJCWl3
ZGQtPmRpc2Nvbm5lY3RpbmcgPSBmYWxzZTsKKwl9CiBvdXQ6CiAJZ19mcmVlKGNiZC0+cGF0aCk7
CiAJZ19mcmVlKGNiZCk7CkBAIC0xNDI0LDYgKzE1MTQsMTAgQEAgc3RhdGljIHZvaWQgZGV2aWNl
X2ZyZWUoZ3BvaW50ZXIgZGF0YSkKIAlnX2ZyZWUoaXdkZC0+YWRhcHRlcik7CiAJZ19mcmVlKGl3
ZGQtPm5hbWUpOwogCWdfZnJlZShpd2RkLT5hZGRyZXNzKTsKKworCWdfZnJlZShpd2RkLT5uZXR3
b3JrKTsKKwlnX2ZyZWUoaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsKKwogCWdfZnJlZShpd2RkKTsK
IH0KIAotLSAKMi4zNC4xCgo=

--_002_MRZP264MB1544B4C51B01525FE4CBA6C19358AMRZP264MB1544FRAP_--
