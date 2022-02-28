Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90058.outbound.protection.outlook.com [40.107.9.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DB7C
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 15:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToyefjEUWSDfCEdKddapebUeEQCKR5gLf9Wev7mwanmSK++t9Cm2ztdbE+a9euNqCGa6d36TAef0i/8NIuX6rmXlokVWoNQXciuI5WMYvMZS84gAAovZZMO/xQaLv4hBOyVvYsy7mm0JagjKKWYvvDrA65+JzqUFsuUbPskPaB2WUXCr8hApkWci3kfRfIiJMm+YjQ8Q7hOE3JPrfh5WfGItuEtecqMWJsheqmE35euW4eLDHGIYd77DH7o6/hPYMSHEbs4iRrupxjdJKLchtoDVyWat346oxnIzgdy7MDle9UiyafIpWafi/bstirgGwLaxoGrLIUPwcUJFKVIVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT9izywc2hHoKCsoBj1wEk5hBYWykhiEGgB8fGJPIvM=;
 b=Cnom/ejAlVei1/ABA+q5KicGr6WZ6FFqdqbGJQPCkfKUkutpqgo6r7poZ5vSqlbjhyOMsDt6zWXXtAVE8KS3pMj7kzhXGH2gyR/Fn4qiRkOs3QgtfDPEbcZtE3owo8imwE205kCQxQ1vA8f5DfMey74rnYkPscabjGYLhxgSMOpZKkitLeyf9FUZYQ9sMwTQeW7JNjgRFuiiqmEfBJBGb5p8iZ7Fip9PvxmJ7TkYOVn7eiyV8Mn0P64tux2viTxj/vBNTGEVV6YPRMmTth2InYBSYFTXaREgClfTAraC1dO6W3mhRwOEclIoKqrfI2iEiZSbmWuIrwjfujdLx4SX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT9izywc2hHoKCsoBj1wEk5hBYWykhiEGgB8fGJPIvM=;
 b=o7YVC4aQbFrbwtjEAMnLn1mltZjXPA3pjApMN3rBuVkfj7GbFMmfZKzlpDsvA8VXWk0o5uJMKgtlx843BK97Dcgyy3g8u/dNo0+hL0EEHz+gSbfVDmbvnO97P1kP6zsbPmmimmInragpbR/NW+AFtrw60kK5uuWNXF6GYeZgmHI=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB1741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Mon, 28 Feb 2022 15:03:40 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::89c9:5558:6083:9f7e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 15:03:40 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Forget network on service removal
Thread-Topic: [PATCH] iwd: Forget network on service removal
Thread-Index: AQHYLLOOA8J5bMMmrEWII+ZwKAmNa6ypDirR
Date: Mon, 28 Feb 2022 15:03:40 +0000
Message-ID:
 <MRZP264MB15447BECF20D7463FD6EA9C693019@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220228145743.2110055-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220228145743.2110055-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 1f6f9196-7478-5520-4264-0cfae681ebbf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d69b58b0-d47e-4930-85ce-08d9facb814d
x-ms-traffictypediagnostic: PR1P264MB1741:EE_
x-microsoft-antispam-prvs:
 <PR1P264MB17417DD8CB525AFE64B5C48593019@PR1P264MB1741.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 p5497M2brcVIVE06xsYJQ0Vq8VIx/xKvTmqdKKHiEYKqtfPocdTBIN5KFGpOInDYK1Q0dPRSCQTbFIiVS20ttVfniREDZb+XTWVEDxxBfaiqDbADpOJlJCw140aKoagC5/Djksv3c1U2lo0bd5vZN2bo+B4W+3T6ESj8PyCKO6D6Tusl6U67vEeXb9iJbCuwokDAohkDUVMP6n/f2UynDRi/x2y+teee2OL20o4N/5cGMNpVcSKLb5yFopM6a5ieZ3C4qrO0fs5e8mYbSJ23dGt5K856VRSDRKvhgDc+MfJC7tMXadpe37gPJO439oBO3huKEiP5kYeX8gtAd1BrxozGCXEhxW78dxzdwqvJk4LPAs1SverpgBXltDas/BFZZwTNlKjEiu+veoY3LNGg1HQfBrCgzX0qIw9zpjXfHZtPpeyzEFaEX/44MNaRLz0ZiXmbh1a/vhClFNKa9fa8+tI1p+QiLQjqvKS4nLQvg7po3RizGLr6xczIXCNEfN4TvXebFWhvw/Ut6PJHPTiw98YLZYsMumsrhZmshFC0flj/n7eVTTxKtLDrqr2h/nKUqRyP8468wzRYXJfJIFjIzIVENJwceMN/HSy/z7BYBKze2imN/gaGFLhOl731fetjGNDUL01+44R+SiDQNVSXNcvdBFYWQfHTZHKI1CQGbIjoau10W9yLyHGTw5kOAoece3HBcTVw2WKGNl4Q/OXGQA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(2906002)(26005)(186003)(316002)(508600001)(55016003)(5660300002)(6916009)(86362001)(66556008)(8676002)(64756008)(71200400001)(66446008)(9686003)(66476007)(83380400001)(8936002)(7696005)(6506007)(52536014)(91956017)(99936003)(66946007)(33656002)(122000001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2mKZCLsd+IS/juC0CXXEXykI8uIdcHBDHOJr0zvymUPUtpx1OQ0cJ7LbdA?=
 =?iso-8859-1?Q?uWxKGbsMgkuxot5P/JLAIwsdpK9NynZE8AaPWKTsagzhZM8avrC4nMVig6?=
 =?iso-8859-1?Q?wfiyVcazwtPSBdXYiYJCvAgd+puSnlcojO/67Wj+j4xVSrTJyiWGRu9ePh?=
 =?iso-8859-1?Q?N0FZestwj7Gq6ETaMU7HSEsavgHiYY7TqDEQ6My5yJjdcNOxnFhxRna19H?=
 =?iso-8859-1?Q?9fyyguslUpaEKEzNvn18tEqEZPNbSXDGEogh1QXjxAIhti0X/xTSQGEnjy?=
 =?iso-8859-1?Q?TP2eWIUJsCPNCI4NNkqzVHmtK8QKAQeTZqd6GiWUUhFd27lnWAwk4dZphL?=
 =?iso-8859-1?Q?69V76ei/b9nhu3OWetM3vBarP1b5jW7PcOAcijjuLjJVArkXWSl1bueCif?=
 =?iso-8859-1?Q?CN+PfcqSaBTAuSBF3nY2r/UDzY4fUj4iTYV1ie9X1JorAvtfgOKZzaTGj9?=
 =?iso-8859-1?Q?LKEuyOct1n/3ah5uWJdC+TyoVReZ6JcPbyJH5BjEqQ8RsW9LvIvsRamF4n?=
 =?iso-8859-1?Q?o3BWtWscQq/K81Wdhrl7VfuIja8WUxrew/7hvLx3Azk951xhP5HSJnrZ6F?=
 =?iso-8859-1?Q?63cH1B6QJJNPQWCsBGKSiI1w0F+o7u5cBEPo1r59VaOnVxzEk26tLiMO6x?=
 =?iso-8859-1?Q?PS+ITwoVbjqztH5x9iDLwMGBdjpr095Mf9/gHLap/qQ2bD/OLeF5I8P4XV?=
 =?iso-8859-1?Q?ZTu9a3WBSLJigfEyd25aqDVxykL59IvrGpZ9oyzcmKfgMD1Uy1XvggOlOD?=
 =?iso-8859-1?Q?MWU3yuksc6hLS+Yb7v7LH9FM9UEsbRfrhSfm3r93RczEZPRwuntNCwtu4P?=
 =?iso-8859-1?Q?4dEwLJex5EShl0c0tU7AJR/Ou1NHxYysKJ8bvb30JxnqqjuaHEId0r2FXZ?=
 =?iso-8859-1?Q?XtVwBsMrLllBlXnr/kIemyXn/aQQc/8HnSavWWXMzuBaIqLg0n3I2vL/DS?=
 =?iso-8859-1?Q?cBJuSgi3DaQ/MLTYXy3wGf4Ktop2D5C61WwaEOUZE86mpyEk+DUxcEfumM?=
 =?iso-8859-1?Q?23bY2qwx4JYtnlbesTVPzINVwxrUKKAnaYmZSekm68EZyE8MLBIExUkoiz?=
 =?iso-8859-1?Q?j5pCIACItXtbSsQiOuLiT06bKoltFgow5hDUVEHz0ezbImKB9ZDQv9e6AY?=
 =?iso-8859-1?Q?1jxTqTGa3VQAw9ZH+BxyIMGj8omkyNym1/54+xStnQmseuiRPvQHUIDTs4?=
 =?iso-8859-1?Q?7ar9RlHpNKjfv7d0Ly7+zNm/Kq47GhrNAKiYBXqzSJxRBPIMt7dIhGWpKa?=
 =?iso-8859-1?Q?HsEFHsmxVPrc83mvdpSJVH/EWthCml7vR7XDBx9AeIYMmdORFCDqxRODRr?=
 =?iso-8859-1?Q?EzoiUt22RPVzamIaoiLR6IlIYHOMOjeRCBtoAh4QMZ47vjrKm8NYbu7qVl?=
 =?iso-8859-1?Q?ZRno9950u7/vKYvi8T4WaZSYUVKTe2CXjEcy0fVmoIDeefkLR69eV5O4Lj?=
 =?iso-8859-1?Q?giY26qSU4WC0dNmCidJGQCUapfKQ8+rbbAJH+kmpG7ZlCxL66WggIWyWZK?=
 =?iso-8859-1?Q?ZT9nf0gtDmMzxPYJxOB7g5+yzpOYFSkGGAC1hx8TtCobjYRC1G39sz8REl?=
 =?iso-8859-1?Q?/BkMGuBbex+d17+KowpwbN0ule5GBbJ3Q86Pmp2TChteamG2P7+89YtYp3?=
 =?iso-8859-1?Q?7JFVDVO2izVE+O32aGuTkvgH2+/GnRWMunhpAtXZIMFAPd/FjWoLbTS0aS?=
 =?iso-8859-1?Q?gSQV1uytWZeBTL4E31yckTK5adW9ilB/g/b/INWFlV4awk6Y0iU0tlhWM9?=
 =?iso-8859-1?Q?WJlw=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB15447BECF20D7463FD6EA9C693019MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d69b58b0-d47e-4930-85ce-08d9facb814d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 15:03:40.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJwGpmT+WBKw6OLySP5fQEnx+E8es3Q7GrHrabtk2iY/7hvflv8t4jOwJn3fYrdS5iLm0nvU+BJsoOGMCvCHEiukId5ZngJaRzKgm1m3lJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1741

--_002_MRZP264MB15447BECF20D7463FD6EA9C693019MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

When a service is manually removed, the associated network, at driver=0A=
side, needs to be forgotten, to remove the corresponding known network.=0A=
---=0A=
 include/network.h |  1 +=0A=
 plugins/iwd.c     | 41 +++++++++++++++++++++++++++++++++++++++++=0A=
 src/connman.h     |  1 +=0A=
 src/network.c     | 13 +++++++++++++=0A=
 src/service.c     |  2 ++=0A=
 5 files changed, 58 insertions(+)=0A=
=0A=
diff --git a/include/network.h b/include/network.h=0A=
index 8f9dd94a7ec2..5bca62ad3a0e 100644=0A=
--- a/include/network.h=0A=
+++ b/include/network.h=0A=
@@ -163,6 +163,7 @@ struct connman_network_driver {=0A=
        void (*remove) (struct connman_network *network);=0A=
        int (*connect) (struct connman_network *network);=0A=
        int (*disconnect) (struct connman_network *network);=0A=
+       int (*forget) (struct connman_network *network);=0A=
        int (*set_autoconnect) (struct connman_network *network,=0A=
                                bool autoconnect);=0A=
 };=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index 7b59a6eb4386..ee3ed83e5957 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -270,6 +270,46 @@ static int cm_network_connect(struct connman_network *=
network)=0A=
        return -EINPROGRESS;=0A=
 }=0A=
=0A=
+static void cm_network_forget_cb(DBusMessage *message, void *user_data)=0A=
+{=0A=
+       struct iwd_known_network *iwdkn;=0A=
+       const char *path =3D user_data;=0A=
+=0A=
+       iwdkn =3D g_hash_table_lookup(known_networks, path);=0A=
+       if (!iwdkn)=0A=
+               return;=0A=
+=0A=
+       if (dbus_message_get_type(message) =3D=3D DBUS_MESSAGE_TYPE_ERROR) =
{=0A=
+               const char *dbus_error =3D dbus_message_get_error_name(mess=
age);=0A=
+=0A=
+               DBG("%s failed: %s", path, dbus_error);=0A=
+       }=0A=
+}=0A=
+=0A=
+static int cm_network_forget(struct connman_network *network)=0A=
+{=0A=
+       struct iwd_network *iwdn =3D connman_network_get_data(network);=0A=
+       struct iwd_known_network *iwdkn;=0A=
+=0A=
+       if (!iwdn)=0A=
+               return -EINVAL;=0A=
+=0A=
+       if (!iwdn->known_network)=0A=
+               return 0;=0A=
+=0A=
+       iwdkn =3D g_hash_table_lookup(known_networks,=0A=
+                               iwdn->known_network);=0A=
+       if (!iwdkn)=0A=
+               return 0;=0A=
+=0A=
+       if (!g_dbus_proxy_method_call(iwdkn->proxy, "Forget",=0A=
+                       NULL, cm_network_forget_cb,=0A=
+                       g_strdup(iwdkn->path), g_free))=0A=
+               return -EIO;=0A=
+=0A=
+       return 0;=0A=
+}=0A=
+=0A=
 static void cm_network_disconnect_cb(DBusMessage *message, void *user_data=
)=0A=
 {=0A=
        const char *path =3D user_data;=0A=
@@ -470,6 +510,7 @@ static struct connman_network_driver network_driver =3D=
 {=0A=
        .probe                  =3D cm_network_probe,=0A=
        .connect                =3D cm_network_connect,=0A=
        .disconnect             =3D cm_network_disconnect,=0A=
+       .forget         =3D cm_network_forget,=0A=
        .set_autoconnect        =3D cm_network_set_autoconnect,=0A=
 };=0A=
=0A=
diff --git a/src/connman.h b/src/connman.h=0A=
index 33dbec694a95..6405361df5df 100644=0A=
--- a/src/connman.h=0A=
+++ b/src/connman.h=0A=
@@ -607,6 +607,7 @@ void __connman_network_set_device(struct connman_networ=
k *network,=0A=
=0A=
 int __connman_network_connect(struct connman_network *network);=0A=
 int __connman_network_disconnect(struct connman_network *network);=0A=
+int __connman_network_forget(struct connman_network *network);=0A=
 int __connman_network_clear_ipconfig(struct connman_network *network,=0A=
                                        struct connman_ipconfig *ipconfig);=
=0A=
 int __connman_network_enable_ipconfig(struct connman_network *network,=0A=
diff --git a/src/network.c b/src/network.c=0A=
index 1cbdf9cfed95..2090e7fe944e 100644=0A=
--- a/src/network.c=0A=
+++ b/src/network.c=0A=
@@ -1848,6 +1848,19 @@ int __connman_network_disconnect(struct connman_netw=
ork *network)=0A=
        return err;=0A=
 }=0A=
=0A=
+int __connman_network_forget(struct connman_network *network)=0A=
+{=0A=
+       DBG("network %p", network);=0A=
+=0A=
+       if (!network->driver)=0A=
+               return -EUNATCH;=0A=
+=0A=
+       if (network->driver->forget)=0A=
+               return network->driver->forget(network);=0A=
+=0A=
+       return 0;=0A=
+}=0A=
+=0A=
 int __connman_network_clear_ipconfig(struct connman_network *network,=0A=
                                        struct connman_ipconfig *ipconfig)=
=0A=
 {=0A=
diff --git a/src/service.c b/src/service.c=0A=
index f1abb963b817..d4387361d0c7 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -4634,6 +4634,8 @@ bool __connman_service_remove(struct connman_service =
*service)=0A=
                return false;=0A=
=0A=
        __connman_service_disconnect(service);=0A=
+       if (service->network)=0A=
+               __connman_network_forget(service->network);=0A=
=0A=
        g_free(service->passphrase);=0A=
        service->passphrase =3D NULL;=0A=
--=0A=
2.25.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=

--_002_MRZP264MB15447BECF20D7463FD6EA9C693019MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-iwd-Forget-network-on-service-removal.patch"
Content-Description: 0001-iwd-Forget-network-on-service-removal.patch
Content-Disposition: attachment;
	filename="0001-iwd-Forget-network-on-service-removal.patch"; size=4199;
	creation-date="Mon, 28 Feb 2022 15:01:42 GMT";
	modification-date="Mon, 28 Feb 2022 15:01:42 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4OGY4NmU3YjVkY2U5YzkyMTRkYjMzNzg2ZThjNzI1ODY0OTYzOTljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IEZyaSwgMjUgRmViIDIwMjIgMTU6NDc6MjIgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBpd2Q6IEZvcmdldCBuZXR3b3JrIG9uIHNlcnZpY2UgcmVtb3ZhbAoKV2hlbiBh
IHNlcnZpY2UgaXMgbWFudWFsbHkgcmVtb3ZlZCwgdGhlIGFzc29jaWF0ZWQgbmV0d29yaywgYXQg
ZHJpdmVyCnNpZGUsIG5lZWRzIHRvIGJlIGZvcmdvdHRlbiwgdG8gcmVtb3ZlIHRoZSBjb3JyZXNw
b25kaW5nIGtub3duIG5ldHdvcmsuCi0tLQogaW5jbHVkZS9uZXR3b3JrLmggfCAgMSArCiBwbHVn
aW5zL2l3ZC5jICAgICB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCiBzcmMvY29ubm1hbi5oICAgICB8ICAxICsKIHNyYy9uZXR3b3JrLmMgICAgIHwgMTMgKysr
KysrKysrKysrKwogc3JjL3NlcnZpY2UuYyAgICAgfCAgMiArKwogNSBmaWxlcyBjaGFuZ2VkLCA1
OCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXR3b3JrLmggYi9pbmNsdWRl
L25ldHdvcmsuaAppbmRleCA4ZjlkZDk0YTdlYzIuLjViY2E2MmFkM2EwZSAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9uZXR3b3JrLmgKKysrIGIvaW5jbHVkZS9uZXR3b3JrLmgKQEAgLTE2Myw2ICsxNjMs
NyBAQCBzdHJ1Y3QgY29ubm1hbl9uZXR3b3JrX2RyaXZlciB7CiAJdm9pZCAoKnJlbW92ZSkgKHN0
cnVjdCBjb25ubWFuX25ldHdvcmsgKm5ldHdvcmspOwogCWludCAoKmNvbm5lY3QpIChzdHJ1Y3Qg
Y29ubm1hbl9uZXR3b3JrICpuZXR3b3JrKTsKIAlpbnQgKCpkaXNjb25uZWN0KSAoc3RydWN0IGNv
bm5tYW5fbmV0d29yayAqbmV0d29yayk7CisJaW50ICgqZm9yZ2V0KSAoc3RydWN0IGNvbm5tYW5f
bmV0d29yayAqbmV0d29yayk7CiAJaW50ICgqc2V0X2F1dG9jb25uZWN0KSAoc3RydWN0IGNvbm5t
YW5fbmV0d29yayAqbmV0d29yaywKIAkJCQlib29sIGF1dG9jb25uZWN0KTsKIH07CmRpZmYgLS1n
aXQgYS9wbHVnaW5zL2l3ZC5jIGIvcGx1Z2lucy9pd2QuYwppbmRleCA3YjU5YTZlYjQzODYuLmVl
M2VkODNlNTk1NyAxMDA2NDQKLS0tIGEvcGx1Z2lucy9pd2QuYworKysgYi9wbHVnaW5zL2l3ZC5j
CkBAIC0yNzAsNiArMjcwLDQ2IEBAIHN0YXRpYyBpbnQgY21fbmV0d29ya19jb25uZWN0KHN0cnVj
dCBjb25ubWFuX25ldHdvcmsgKm5ldHdvcmspCiAJcmV0dXJuIC1FSU5QUk9HUkVTUzsKIH0KIAor
c3RhdGljIHZvaWQgY21fbmV0d29ya19mb3JnZXRfY2IoREJ1c01lc3NhZ2UgKm1lc3NhZ2UsIHZv
aWQgKnVzZXJfZGF0YSkKK3sKKwlzdHJ1Y3QgaXdkX2tub3duX25ldHdvcmsgKml3ZGtuOworCWNv
bnN0IGNoYXIgKnBhdGggPSB1c2VyX2RhdGE7CisKKwlpd2RrbiA9IGdfaGFzaF90YWJsZV9sb29r
dXAoa25vd25fbmV0d29ya3MsIHBhdGgpOworCWlmICghaXdka24pCisJCXJldHVybjsKKworCWlm
IChkYnVzX21lc3NhZ2VfZ2V0X3R5cGUobWVzc2FnZSkgPT0gREJVU19NRVNTQUdFX1RZUEVfRVJS
T1IpIHsKKwkJY29uc3QgY2hhciAqZGJ1c19lcnJvciA9IGRidXNfbWVzc2FnZV9nZXRfZXJyb3Jf
bmFtZShtZXNzYWdlKTsKKworCQlEQkcoIiVzIGZhaWxlZDogJXMiLCBwYXRoLCBkYnVzX2Vycm9y
KTsKKwl9Cit9CisKK3N0YXRpYyBpbnQgY21fbmV0d29ya19mb3JnZXQoc3RydWN0IGNvbm5tYW5f
bmV0d29yayAqbmV0d29yaykKK3sKKwlzdHJ1Y3QgaXdkX25ldHdvcmsgKml3ZG4gPSBjb25ubWFu
X25ldHdvcmtfZ2V0X2RhdGEobmV0d29yayk7CisJc3RydWN0IGl3ZF9rbm93bl9uZXR3b3JrICpp
d2RrbjsKKworCWlmICghaXdkbikKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpZiAoIWl3ZG4tPmtu
b3duX25ldHdvcmspCisJCXJldHVybiAwOworCisJaXdka24gPSBnX2hhc2hfdGFibGVfbG9va3Vw
KGtub3duX25ldHdvcmtzLAorCQkJCWl3ZG4tPmtub3duX25ldHdvcmspOworCWlmICghaXdka24p
CisJCXJldHVybiAwOworCisJaWYgKCFnX2RidXNfcHJveHlfbWV0aG9kX2NhbGwoaXdka24tPnBy
b3h5LCAiRm9yZ2V0IiwKKwkJCU5VTEwsIGNtX25ldHdvcmtfZm9yZ2V0X2NiLAorCQkJZ19zdHJk
dXAoaXdka24tPnBhdGgpLCBnX2ZyZWUpKQorCQlyZXR1cm4gLUVJTzsKKworCXJldHVybiAwOwor
fQorCiBzdGF0aWMgdm9pZCBjbV9uZXR3b3JrX2Rpc2Nvbm5lY3RfY2IoREJ1c01lc3NhZ2UgKm1l
c3NhZ2UsIHZvaWQgKnVzZXJfZGF0YSkKIHsKIAljb25zdCBjaGFyICpwYXRoID0gdXNlcl9kYXRh
OwpAQCAtNDcwLDYgKzUxMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY29ubm1hbl9uZXR3b3JrX2RyaXZl
ciBuZXR3b3JrX2RyaXZlciA9IHsKIAkucHJvYmUJCQk9IGNtX25ldHdvcmtfcHJvYmUsCiAJLmNv
bm5lY3QJCT0gY21fbmV0d29ya19jb25uZWN0LAogCS5kaXNjb25uZWN0CQk9IGNtX25ldHdvcmtf
ZGlzY29ubmVjdCwKKwkuZm9yZ2V0CQk9IGNtX25ldHdvcmtfZm9yZ2V0LAogCS5zZXRfYXV0b2Nv
bm5lY3QJPSBjbV9uZXR3b3JrX3NldF9hdXRvY29ubmVjdCwKIH07CiAKZGlmZiAtLWdpdCBhL3Ny
Yy9jb25ubWFuLmggYi9zcmMvY29ubm1hbi5oCmluZGV4IDMzZGJlYzY5NGE5NS4uNjQwNTM2MWRm
NWRmIDEwMDY0NAotLS0gYS9zcmMvY29ubm1hbi5oCisrKyBiL3NyYy9jb25ubWFuLmgKQEAgLTYw
Nyw2ICs2MDcsNyBAQCB2b2lkIF9fY29ubm1hbl9uZXR3b3JrX3NldF9kZXZpY2Uoc3RydWN0IGNv
bm5tYW5fbmV0d29yayAqbmV0d29yaywKIAogaW50IF9fY29ubm1hbl9uZXR3b3JrX2Nvbm5lY3Qo
c3RydWN0IGNvbm5tYW5fbmV0d29yayAqbmV0d29yayk7CiBpbnQgX19jb25ubWFuX25ldHdvcmtf
ZGlzY29ubmVjdChzdHJ1Y3QgY29ubm1hbl9uZXR3b3JrICpuZXR3b3JrKTsKK2ludCBfX2Nvbm5t
YW5fbmV0d29ya19mb3JnZXQoc3RydWN0IGNvbm5tYW5fbmV0d29yayAqbmV0d29yayk7CiBpbnQg
X19jb25ubWFuX25ldHdvcmtfY2xlYXJfaXBjb25maWcoc3RydWN0IGNvbm5tYW5fbmV0d29yayAq
bmV0d29yaywKIAkJCQkJc3RydWN0IGNvbm5tYW5faXBjb25maWcgKmlwY29uZmlnKTsKIGludCBf
X2Nvbm5tYW5fbmV0d29ya19lbmFibGVfaXBjb25maWcoc3RydWN0IGNvbm5tYW5fbmV0d29yayAq
bmV0d29yaywKZGlmZiAtLWdpdCBhL3NyYy9uZXR3b3JrLmMgYi9zcmMvbmV0d29yay5jCmluZGV4
IDFjYmRmOWNmZWQ5NS4uMjA5MGU3ZmU5NDRlIDEwMDY0NAotLS0gYS9zcmMvbmV0d29yay5jCisr
KyBiL3NyYy9uZXR3b3JrLmMKQEAgLTE4NDgsNiArMTg0OCwxOSBAQCBpbnQgX19jb25ubWFuX25l
dHdvcmtfZGlzY29ubmVjdChzdHJ1Y3QgY29ubm1hbl9uZXR3b3JrICpuZXR3b3JrKQogCXJldHVy
biBlcnI7CiB9CiAKK2ludCBfX2Nvbm5tYW5fbmV0d29ya19mb3JnZXQoc3RydWN0IGNvbm5tYW5f
bmV0d29yayAqbmV0d29yaykKK3sKKwlEQkcoIm5ldHdvcmsgJXAiLCBuZXR3b3JrKTsKKworCWlm
ICghbmV0d29yay0+ZHJpdmVyKQorCQlyZXR1cm4gLUVVTkFUQ0g7CisKKwlpZiAobmV0d29yay0+
ZHJpdmVyLT5mb3JnZXQpCisJCXJldHVybiBuZXR3b3JrLT5kcml2ZXItPmZvcmdldChuZXR3b3Jr
KTsKKworCXJldHVybiAwOworfQorCiBpbnQgX19jb25ubWFuX25ldHdvcmtfY2xlYXJfaXBjb25m
aWcoc3RydWN0IGNvbm5tYW5fbmV0d29yayAqbmV0d29yaywKIAkJCQkJc3RydWN0IGNvbm5tYW5f
aXBjb25maWcgKmlwY29uZmlnKQogewpkaWZmIC0tZ2l0IGEvc3JjL3NlcnZpY2UuYyBiL3NyYy9z
ZXJ2aWNlLmMKaW5kZXggZjFhYmI5NjNiODE3Li5kNDM4NzM2MWQwYzcgMTAwNjQ0Ci0tLSBhL3Ny
Yy9zZXJ2aWNlLmMKKysrIGIvc3JjL3NlcnZpY2UuYwpAQCAtNDYzNCw2ICs0NjM0LDggQEAgYm9v
bCBfX2Nvbm5tYW5fc2VydmljZV9yZW1vdmUoc3RydWN0IGNvbm5tYW5fc2VydmljZSAqc2Vydmlj
ZSkKIAkJcmV0dXJuIGZhbHNlOwogCiAJX19jb25ubWFuX3NlcnZpY2VfZGlzY29ubmVjdChzZXJ2
aWNlKTsKKwlpZiAoc2VydmljZS0+bmV0d29yaykKKwkJX19jb25ubWFuX25ldHdvcmtfZm9yZ2V0
KHNlcnZpY2UtPm5ldHdvcmspOwogCiAJZ19mcmVlKHNlcnZpY2UtPnBhc3NwaHJhc2UpOwogCXNl
cnZpY2UtPnBhc3NwaHJhc2UgPSBOVUxMOwotLSAKMi4yNS4xCgo=

--_002_MRZP264MB15447BECF20D7463FD6EA9C693019MRZP264MB1544FRAP_--
