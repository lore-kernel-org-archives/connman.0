Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120058.outbound.protection.outlook.com [40.107.12.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE87173
	for <connman@lists.linux.dev>; Mon, 24 Jan 2022 09:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPb9k3mGeJewrNWQ1PLTNeG2bl/iPX/K+ERAxgWTpGE/FjzZJoIy235Dp+fe5EEiT2zo1d8oKghkbfkJeEpYDA5dlYY4G8ZjWFFYh9KA2wvwfOYSto3LtPo2mocd8oXGHccrBqOzl3pPb1RdtWsmdku2MQotQvbRwLvk3bGts/T+3PnGOs46BHSgDSUsed3fwTnKz0VoIYmSo3yApw+Eh3LzSrksaJYIM9U7LYLcNyqH/dpfO6kgUV+2SCTyjKdeNBxeiXXMXoFpr4QgwJgRt3Q3U1CsI+PpH3vGe61/O7sZg0k60FCcuqzccNPgCNj9FEnimysTgO3vYgtXwf+ixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0q05HWJgDGZVZSUBvmQgyfk5Lt8EeVvsNwmRHfcNU4=;
 b=VIpbFa5BWVjef+P5u69ewR58YjEoNduoiDDctAihT5Fpm0FJKGADZQNE5kAPlgjt1m7JDd9IF6sAiokjfDrOSWEpn9sv+lepRwdHJwfIn18Iis376vwBKtshrwSRF438mq+Ha0cBWLTByXpUJmHYdcWzG7fMXaa0e8v9LBJ5fbif7UK4beHJsDRjT1BK+OVnMp75R/V/VCsc7g35U3N8Pn7gc2hzES52GgPWnsOW6ssh9j3ODfyVkmOZi97XA13qDgVVFt5y43NvLNV5jBWU6bfaSRJR78kVFGcNxkrSZJH+SX0csDpKQG7pdGiLoEZcy7nj9WMt66fQzd07aB+ncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0q05HWJgDGZVZSUBvmQgyfk5Lt8EeVvsNwmRHfcNU4=;
 b=mao02eMZ8fnYvDtrA6ilI6Opf8wWJMX9UFalomUKGbon3kUuCJNaaukTgLZFkjj20tJDWTT/DYxJA1Sz47gYBWKGjRJnhbCFiywtk1d0zPcMvyN9wXU52iqmza40vOWb4nemg+owao2RzclgQ5w0bWOr/PCF9+dumwiThgt12+c=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MRZP264MB2620.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Mon, 24 Jan 2022 09:06:27 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a9bd:bd2:963a:8e6a%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:06:27 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH v2] iwd: Always disconnect connection completely
Thread-Topic: [PATCH v2] iwd: Always disconnect connection completely
Thread-Index: AQHYEP/731R9+FXajUGI5zk313sJNKxx3h9I
Date: Mon, 24 Jan 2022 09:06:27 +0000
Message-ID:
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
In-Reply-To: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 3516f8e4-28a3-c21b-7a43-85dfa4c60027
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75f792ff-1e21-4b3d-d2c3-08d9df18ce08
x-ms-traffictypediagnostic: MRZP264MB2620:EE_
x-microsoft-antispam-prvs:
 <MRZP264MB2620FE10F6D5DA34AA18F8ED935E9@MRZP264MB2620.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5wmcwvEt6EmLsuB4UbYOlk1E/mb1S27eWXx7rkrw9R/v/W0DH2dlwLHCr3oIAHQwNSsfUnUsiJqW/Sz5JFQo+HX7X1PEgc0VbZTX4dbqLRoLkoRFcX+pYIFQ+ZlECYUi9fGRhM8sS8NinYAuQ364R/XPeEU4jpu0NlNCl5McXDJsKsWtdx2QHtcnpl5Heg19VASLAUJJ43hJV6WX47NOyGTzfYxrkiGLxvFQVcg06MvpokrD2Q7IHZNhlRr35EnBlePNGUPBJfnUuBe4beIeVn8HdCfNq52Ju7qGiGw7h56g9r/TwOrkFYl6KPnOqVPYwIJVVAiGyM0IO0DkzRW/g9wNU02kuK0BS7oAQofl5kWXtTAiGi+n81ifVlPNf1aHFDGLAc8cjQllehProoCO8Ybxr/zIEzUW4FbtgAfZhNP6zgGTph+L8zjfmPU+iIi8pv55nGCnBK/baaDMWwTI1YgC+Hp6nwtonmbTukFWKY08UxJk5AQ5+UAvYwfCW/PHkE8n1na8y73a2EWh4hwhJwtsdeOfTWpm8F/qrpqP3wH36JwRIVQy3LoCRtqZu2MqVJAiMUkIwCTwNK8gLijpHv1WkUiNpraILWqVKfGSVN9VrvpjN4eEOb8VV6qnTvVsajpAVKKv43QTFvZ+4zpblrt7zgxxwFhTFHFWYoY0zRpfCj3e2MoAIK1Y5wPPQztHv5eFi73+bke/f647YPIzCg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(66946007)(9686003)(99936003)(38070700005)(316002)(52536014)(5660300002)(122000001)(71200400001)(86362001)(508600001)(55016003)(6506007)(33656002)(64756008)(83380400001)(66446008)(76116006)(186003)(6916009)(8676002)(26005)(91956017)(66476007)(38100700002)(66556008)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?W/9tLSIo3sBNg2nevaYY9ltCVgWVpCrmcA3Ns/JJCjpSD2tQWH9lXhKMob?=
 =?iso-8859-1?Q?9sPDU1BPwJTtWZSeXkKzapSxBjMXfMypoQGGKui5e7e2OH5s5PtNPiZ1c4?=
 =?iso-8859-1?Q?ZnKZTn/oPS2jWorbtVo6+7sXgLMgj25ou9qfK5OTs8DPwa1JX6bLu4CTQC?=
 =?iso-8859-1?Q?/KpeJFvD3oYa6vmzHxCd3/CaLVVcYtalNXvw200QxWjIbA0/nJ/E+LWecG?=
 =?iso-8859-1?Q?bNOWFCD8KfaGHZsmYdsS4YxBGgSblxhmp7bOdutybVTf2kPjD6eQdKaQ7E?=
 =?iso-8859-1?Q?n8rTqei/yjEXFAYmyqatyvzh+gcjjzj4QGWIHOEJ/G5+hIEd1r3NKSaj8e?=
 =?iso-8859-1?Q?WBoe3KshRbm8Dq/8b+/e5a2b6p58nRVMuHqcsAwN99GhiaxIE6/dh6qUl7?=
 =?iso-8859-1?Q?IE9KLlPDN1WUwi0pMksHvtA7nRoMfnFCoLxSALnucf8gb3VdPu+Cl3jSDN?=
 =?iso-8859-1?Q?9jp4dMWEA28X4WNucAvOebCOJaJ46LnwXkaeCKp5Gp8opjG6DUnuO3Apdw?=
 =?iso-8859-1?Q?/C9SiB9e6utmGN0O479/jNKgM3Sg/C1cQtSo94usio4p84UvLk3+G1ejo5?=
 =?iso-8859-1?Q?ePg6AFZ1cEwJq3FUqAbBcDeW4G/w123meW4IKjQCkZANxm48BFSN+eorUi?=
 =?iso-8859-1?Q?ngM4HcPkqROqG772jwL70BtBL+Fl8eXJQf4LyXXDMjTO5i9VoNakvLzYll?=
 =?iso-8859-1?Q?zxv2nqqOke0C4/pDoX2kAsMNZVKujzVzz8edY8MAlgZyUw7Pf3uqGGMvFB?=
 =?iso-8859-1?Q?cAj+M3R96DeDKXGw4GikfTtMs/Tpv6ThVpmDmqlLH7TG4iKHdsESKjStAz?=
 =?iso-8859-1?Q?u0wlpoJII9x5V96AbgqQQ46SJdEdksJ025XsFNh6pS0HIIEt+GfBK01B+t?=
 =?iso-8859-1?Q?cznJn4LtjA31nA408SFOIxlUtqeVEw82ttOMGIL1SMC7aVkx+Znjy/0T8v?=
 =?iso-8859-1?Q?yMzdrFewt3BfjldVRgppiLyA6Sjb/T5c9YNwjpm258hCxYg2ZAjYDAyv+0?=
 =?iso-8859-1?Q?TuEQSLv9vu3Z9UfxdXFDf4mJLAAEovztyMF/Dhtkp7CTbhDZW+cu7aswmf?=
 =?iso-8859-1?Q?uKJTXYgFeCD+6iqK/uwJYzinmgXHUAifW+TmYiOEXH/vzNrmoMkUH86GyO?=
 =?iso-8859-1?Q?k7VgRS2mdfaXfbUwHSVhsMEfs1WBvaIeCk6wTsMw3fUUgv+vcv4twkvyRI?=
 =?iso-8859-1?Q?KtUgwmuPaVpEWvLNhbcsgXVn53ClsuVcwejsu7jGo0EjMcYxS/C3YmXVsW?=
 =?iso-8859-1?Q?vTYhs9TGJCQVmmWe6J0ZknTEizj9qM6SRs7DOflaq4/iBl+j9LmoU6iE+f?=
 =?iso-8859-1?Q?I4dn585eWzE3kEEp0w+S2fSnDQtoHGQxEGcHMDzimv2oSYhRLQBIXPWVxv?=
 =?iso-8859-1?Q?kW+Vln0aINmR/mQFLcqpycRdLeI+ZZAm2Yre76pEdC3cZyw31Seoh+L7FN?=
 =?iso-8859-1?Q?GuYxR+AKX0Ayk8WEduwOc+2cQXc8UJIOkgF4oodgQ2CicX5IgGhZXEw39x?=
 =?iso-8859-1?Q?lhSHuiYs/se2upvywpFKT0KDNy128SxjVV4vlw1HXwzG4DR4a//emwA8oe?=
 =?iso-8859-1?Q?IOf0KuMXIZo/jEnpY6JFZ/RehSC6iVfZlicNJAaIIHLZHxhh2jJktsGScc?=
 =?iso-8859-1?Q?eVeRA5EG718td7QUeoqihxQwzinSWWlmzor/dLHzEAcrGyTbRq/3moec92?=
 =?iso-8859-1?Q?sOwTUNA9UgLHiE4GLnKW6AwtRU+ofivJzxuAiYrYkmjYaS+/00hcIVM0qH?=
 =?iso-8859-1?Q?kk1g=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB154447165B86A88033C533B8935E9MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f792ff-1e21-4b3d-d2c3-08d9df18ce08
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:06:27.7592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKo+SVe97B4M6nWxg9aF/e6Pxxo8W6A9yubBrCstYUao1fH5yZwIa9Lb8BZypdt88rzIPTfbdbPpbpqgIb3YXKPl98RZGu4WqZUuvEZaOD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2620

--_002_MRZP264MB154447165B86A88033C533B8935E9MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Before being able to connect to a new network, finish disconnecting=0A=
the old connection. The network can change while the=0A=
cm_network_disconnect_cb is scheduled.=0A=
=0A=
Commit 024309a9e04a ("wifi: Reset disconnecting status of any network")=0A=
Commit 795883e98eba ("wifi: Check valid network in disconnect callback")=0A=
Commit dd86f09107e8 ("wifi: Always disconnect connection completely")=0A=
---=0A=
=A0plugins/iwd.c | 115 ++++++++++++++++++++++++++++++++++++++++++++------=
=0A=
=A01 file changed, 103 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index ac3d1e1787ad..f65148b691e7 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -82,6 +82,10 @@ struct iwd_device {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 char *mode;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct connman_device *device;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 char *network;=0A=
+=A0=A0=A0=A0=A0=A0 char *pending_network;=0A=
+=A0=A0=A0=A0=A0=A0 bool disconnecting;=0A=
=A0};=0A=
=A0=0A=
=A0struct iwd_network {=0A=
@@ -219,12 +223,6 @@ static void update_network_connected(struct iwd_networ=
k *iwdn)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 connman_network_set_connected(iwdn->network, true)=
;=0A=
=A0}=0A=
=A0=0A=
-static void update_network_disconnected(struct iwd_network *iwdn)=0A=
-{=0A=
-=A0=A0=A0=A0=A0=A0 DBG("interface name %s", iwdn->name);=0A=
-=A0=A0=A0=A0=A0=A0 connman_network_set_connected(iwdn->network, false);=0A=
-}=0A=
-=0A=
=A0static void cm_network_connect_cb(DBusMessage *message, void *user_data)=
=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 const char *path =3D user_data;=0A=
@@ -253,21 +251,94 @@ static void cm_network_connect_cb(DBusMessage *messag=
e, void *user_data)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 update_network_connected(iwdn);=0A=
=A0}=0A=
=A0=0A=
+static void abort_pending_network(struct iwd_device *iwdd,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum connman_network_error erro=
r)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct iwd_network *iwdn;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (!iwdd->pending_network)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 iwdn =3D g_hash_table_lookup(networks, iwdd->pending_ne=
twork);=0A=
+=A0=A0=A0=A0=A0=A0 if (iwdn)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 connman_network_set_error(iwdn-=
>network, error);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->pending_network);=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->pending_network =3D NULL;=0A=
+}=0A=
+=0A=
=A0static int cm_network_connect(struct connman_network *network)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iwd_network *iwdn =3D connman_network_get_d=
ata(network);=0A=
+=A0=A0=A0=A0=A0=A0 struct iwd_device *iwdd;=0A=
+=A0=A0=A0=A0=A0=A0 int err;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 if (!iwdn)=0A=
+=A0=A0=A0=A0=A0=A0 if (!iwdn || !iwdn->iwdd)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 iwdd =3D iwdn->iwdd;=0A=
+=A0=A0=A0=A0=A0=A0 if (iwdd->disconnecting) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (g_strcmp0(iwdn->path, iwdd-=
>pending_network)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort_p=
ending_network(iwdd,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CONNMAN_NETWORK_ERROR_CONNECT_FA=
IL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iwdd->p=
ending_network =3D g_strdup(iwdn->path);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINPROGRESS;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!g_dbus_proxy_method_call(iwdn->proxy, "Connec=
t",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NU=
LL, cm_network_connect_cb,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g_strdu=
p(iwdn->path), g_free))=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g_strdu=
p(iwdn->path), g_free)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D -EIO;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 connman_network_set_associating(iwdn->network, tru=
e);=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 return -EINPROGRESS;=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->network);=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->network =3D g_strdup(iwdn->path);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 err =3D -EINPROGRESS;=0A=
+=0A=
+out:=0A=
+=A0=A0=A0=A0=A0=A0 abort_pending_network(iwdd, CONNMAN_NETWORK_ERROR_UNKNO=
WN);=0A=
+=A0=A0=A0=A0=A0=A0 return err;=0A=
+}=0A=
+=0A=
+static void update_network_disconnected(struct iwd_network *iwdn)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct iwd_device *iwdd;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (!iwdn || !iwdn->iwdd)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 iwdd =3D iwdn->iwdd;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 DBG("interface name %s", iwdn->name);=0A=
+=A0=A0=A0=A0=A0=A0 connman_network_set_connected(iwdn->network, false);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->disconnecting =3D false;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (g_strcmp0(iwdn->path, iwdd->network)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!g_strcmp0(iwdn->path, iwdd=
->pending_network)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort_p=
ending_network(iwdd,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CONNMAN_NETWORK_ERROR_CONNECT_FA=
IL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DBG("current wifi network has c=
hanged since disconnection");=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->network);=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->network =3D NULL;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (iwdd->pending_network) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iwd_network *iwdn_pendin=
g =3D=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g_hash_=
table_lookup(networks, iwdd->pending_network);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!iwdn_pending)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cm_network_connect(iwdn_pending=
->network);=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=A0}=0A=
=A0=0A=
=A0static void cm_network_disconnect_cb(DBusMessage *message, void *user_da=
ta)=0A=
@@ -279,6 +350,9 @@ static void cm_network_disconnect_cb(DBusMessage *messa=
ge, void *user_data)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!iwdn)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 if(iwdn->iwdd)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iwdn->iwdd->disconnecting =3D f=
alse;=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (dbus_message_get_type(message) =3D=3D DBUS_MES=
SAGE_TYPE_ERROR) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const char *dbus_error =3D=
 dbus_message_get_error_name(message);=0A=
=A0=0A=
@@ -303,11 +377,16 @@ static int cm_network_disconnect(struct connman_netwo=
rk *network)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iwd_network *iwdn =3D connman_network_get_d=
ata(network);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iwd_station *iwds;=0A=
+=A0=A0=A0=A0=A0=A0 struct iwd_device *iwdd;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 if (!iwdn && !iwdn->iwdd)=0A=
+=A0=A0=A0=A0=A0=A0 if (!iwdn || !iwdn->iwdd)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 iwds =3D g_hash_table_lookup(stations, iwdn->iwdd->path=
);=0A=
+=A0=A0=A0=A0=A0=A0 iwdd =3D iwdn->iwdd;=0A=
+=A0=A0=A0=A0=A0=A0 if (iwdd->disconnecting)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EALREADY;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 iwds =3D g_hash_table_lookup(stations, iwdd->path);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!iwds)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;=0A=
=A0=0A=
@@ -317,6 +396,8 @@ static int cm_network_disconnect(struct connman_network=
 *network)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NU=
LL, cm_network_disconnect_cb, g_strdup(iwdn->path), g_free))=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 iwdd->disconnecting =3D true;=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=A0}=0A=
=A0=0A=
@@ -515,6 +596,12 @@ static void device_powered_cb(const DBusError *error, =
void *user_data)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 connman_device_set_powered(iwdd->device, cbd->powe=
red);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if(!cbd->powered) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort_pending_network(iwdd,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CONNMAN_NETWORK_ERROR_CONNECT_FA=
IL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iwdd->disconnecting =3D false;=
=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=A0out:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(cbd->path);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(cbd);=0A=
@@ -1309,6 +1396,10 @@ static void device_free(gpointer data)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(iwdd->adapter);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(iwdd->name);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(iwdd->address);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->network);=0A=
+=A0=A0=A0=A0=A0=A0 g_free(iwdd->pending_network);=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 g_free(iwdd);=0A=
=A0}=0A=
=A0=0A=
-- =0A=
2.25.1=0A=
Please find the well formatted path as attachment.=0A=
=0A=
> I don't have any fallouts in there. This could be just because I use a=0A=
> different compiler with different settings. Please report those=0A=
> failures. It's not good to paper over them in the long run.=0A=
Probably, by my side, I am building via Yocto.=0A=
I will send you the related patch.=0A=
=0A=
Emmanuel=

--_002_MRZP264MB154447165B86A88033C533B8935E9MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="v2-0001-iwd-Always-disconnect-connection-completely.patch"
Content-Description: v2-0001-iwd-Always-disconnect-connection-completely.patch
Content-Disposition: attachment;
	filename="v2-0001-iwd-Always-disconnect-connection-completely.patch";
	size=5435; creation-date="Mon, 24 Jan 2022 08:55:36 GMT";
	modification-date="Mon, 24 Jan 2022 08:55:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNTI2NjA0MTMzZjhiZjQ3ZGEzMjM0NjUwZjA2ZmYyN2ZhMDFlY2IxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFdlZCwgMTkgSmFuIDIwMjIgMTA6Mzg6MDcgKzAxMDAKU3ViamVj
dDogW1BBVENIIHYyXSBpd2Q6IEFsd2F5cyBkaXNjb25uZWN0IGNvbm5lY3Rpb24gY29tcGxldGVs
eQoKQmVmb3JlIGJlaW5nIGFibGUgdG8gY29ubmVjdCB0byBhIG5ldyBuZXR3b3JrLCBmaW5pc2gg
ZGlzY29ubmVjdGluZwp0aGUgb2xkIGNvbm5lY3Rpb24uIFRoZSBuZXR3b3JrIGNhbiBjaGFuZ2Ug
d2hpbGUgdGhlCmNtX25ldHdvcmtfZGlzY29ubmVjdF9jYiBpcyBzY2hlZHVsZWQuCgpDb21taXQg
MDI0MzA5YTllMDRhICgid2lmaTogUmVzZXQgZGlzY29ubmVjdGluZyBzdGF0dXMgb2YgYW55IG5l
dHdvcmsiKQpDb21taXQgNzk1ODgzZTk4ZWJhICgid2lmaTogQ2hlY2sgdmFsaWQgbmV0d29yayBp
biBkaXNjb25uZWN0IGNhbGxiYWNrIikKQ29tbWl0IGRkODZmMDkxMDdlOCAoIndpZmk6IEFsd2F5
cyBkaXNjb25uZWN0IGNvbm5lY3Rpb24gY29tcGxldGVseSIpCi0tLQogcGx1Z2lucy9pd2QuYyB8
IDExNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9wbHVnaW5zL2l3ZC5jIGIvcGx1Z2lucy9pd2QuYwppbmRleCBhYzNkMWUxNzg3YWQu
LmY2NTE0OGI2OTFlNyAxMDA2NDQKLS0tIGEvcGx1Z2lucy9pd2QuYworKysgYi9wbHVnaW5zL2l3
ZC5jCkBAIC04Miw2ICs4MiwxMCBAQCBzdHJ1Y3QgaXdkX2RldmljZSB7CiAJY2hhciAqbW9kZTsK
IAogCXN0cnVjdCBjb25ubWFuX2RldmljZSAqZGV2aWNlOworCisJY2hhciAqbmV0d29yazsKKwlj
aGFyICpwZW5kaW5nX25ldHdvcms7CisJYm9vbCBkaXNjb25uZWN0aW5nOwogfTsKIAogc3RydWN0
IGl3ZF9uZXR3b3JrIHsKQEAgLTIxOSwxMiArMjIzLDYgQEAgc3RhdGljIHZvaWQgdXBkYXRlX25l
dHdvcmtfY29ubmVjdGVkKHN0cnVjdCBpd2RfbmV0d29yayAqaXdkbikKIAljb25ubWFuX25ldHdv
cmtfc2V0X2Nvbm5lY3RlZChpd2RuLT5uZXR3b3JrLCB0cnVlKTsKIH0KIAotc3RhdGljIHZvaWQg
dXBkYXRlX25ldHdvcmtfZGlzY29ubmVjdGVkKHN0cnVjdCBpd2RfbmV0d29yayAqaXdkbikKLXsK
LQlEQkcoImludGVyZmFjZSBuYW1lICVzIiwgaXdkbi0+bmFtZSk7Ci0JY29ubm1hbl9uZXR3b3Jr
X3NldF9jb25uZWN0ZWQoaXdkbi0+bmV0d29yaywgZmFsc2UpOwotfQotCiBzdGF0aWMgdm9pZCBj
bV9uZXR3b3JrX2Nvbm5lY3RfY2IoREJ1c01lc3NhZ2UgKm1lc3NhZ2UsIHZvaWQgKnVzZXJfZGF0
YSkKIHsKIAljb25zdCBjaGFyICpwYXRoID0gdXNlcl9kYXRhOwpAQCAtMjUzLDIxICsyNTEsOTQg
QEAgc3RhdGljIHZvaWQgY21fbmV0d29ya19jb25uZWN0X2NiKERCdXNNZXNzYWdlICptZXNzYWdl
LCB2b2lkICp1c2VyX2RhdGEpCiAJdXBkYXRlX25ldHdvcmtfY29ubmVjdGVkKGl3ZG4pOwogfQog
CitzdGF0aWMgdm9pZCBhYm9ydF9wZW5kaW5nX25ldHdvcmsoc3RydWN0IGl3ZF9kZXZpY2UgKml3
ZGQsCisJCWVudW0gY29ubm1hbl9uZXR3b3JrX2Vycm9yIGVycm9yKQoreworCXN0cnVjdCBpd2Rf
bmV0d29yayAqaXdkbjsKKworCWlmICghaXdkZC0+cGVuZGluZ19uZXR3b3JrKQorCQlyZXR1cm47
CisKKwlpd2RuID0gZ19oYXNoX3RhYmxlX2xvb2t1cChuZXR3b3JrcywgaXdkZC0+cGVuZGluZ19u
ZXR3b3JrKTsKKwlpZiAoaXdkbikKKwkJY29ubm1hbl9uZXR3b3JrX3NldF9lcnJvcihpd2RuLT5u
ZXR3b3JrLCBlcnJvcik7CisKKwlnX2ZyZWUoaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsKKwlpd2Rk
LT5wZW5kaW5nX25ldHdvcmsgPSBOVUxMOworfQorCiBzdGF0aWMgaW50IGNtX25ldHdvcmtfY29u
bmVjdChzdHJ1Y3QgY29ubm1hbl9uZXR3b3JrICpuZXR3b3JrKQogewogCXN0cnVjdCBpd2RfbmV0
d29yayAqaXdkbiA9IGNvbm5tYW5fbmV0d29ya19nZXRfZGF0YShuZXR3b3JrKTsKKwlzdHJ1Y3Qg
aXdkX2RldmljZSAqaXdkZDsKKwlpbnQgZXJyOwogCi0JaWYgKCFpd2RuKQorCWlmICghaXdkbiB8
fCAhaXdkbi0+aXdkZCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwlpd2RkID0gaXdkbi0+aXdkZDsK
KwlpZiAoaXdkZC0+ZGlzY29ubmVjdGluZykgeworCQlpZiAoZ19zdHJjbXAwKGl3ZG4tPnBhdGgs
IGl3ZGQtPnBlbmRpbmdfbmV0d29yaykpIHsKKwkJCWFib3J0X3BlbmRpbmdfbmV0d29yayhpd2Rk
LAorCQkJCQlDT05OTUFOX05FVFdPUktfRVJST1JfQ09OTkVDVF9GQUlMKTsKKwkJCWl3ZGQtPnBl
bmRpbmdfbmV0d29yayA9IGdfc3RyZHVwKGl3ZG4tPnBhdGgpOworCQl9CisJCXJldHVybiAtRUlO
UFJPR1JFU1M7CisJfQorCiAJaWYgKCFnX2RidXNfcHJveHlfbWV0aG9kX2NhbGwoaXdkbi0+cHJv
eHksICJDb25uZWN0IiwKIAkJCU5VTEwsIGNtX25ldHdvcmtfY29ubmVjdF9jYiwKLQkJCWdfc3Ry
ZHVwKGl3ZG4tPnBhdGgpLCBnX2ZyZWUpKQotCQlyZXR1cm4gLUVJTzsKKwkJCWdfc3RyZHVwKGl3
ZG4tPnBhdGgpLCBnX2ZyZWUpKSB7CisJCWVyciA9IC1FSU87CisJCWdvdG8gb3V0OworCX0KIAog
CWNvbm5tYW5fbmV0d29ya19zZXRfYXNzb2NpYXRpbmcoaXdkbi0+bmV0d29yaywgdHJ1ZSk7CiAK
LQlyZXR1cm4gLUVJTlBST0dSRVNTOworCWdfZnJlZShpd2RkLT5uZXR3b3JrKTsKKwlpd2RkLT5u
ZXR3b3JrID0gZ19zdHJkdXAoaXdkbi0+cGF0aCk7CisKKwllcnIgPSAtRUlOUFJPR1JFU1M7CisK
K291dDoKKwlhYm9ydF9wZW5kaW5nX25ldHdvcmsoaXdkZCwgQ09OTk1BTl9ORVRXT1JLX0VSUk9S
X1VOS05PV04pOworCXJldHVybiBlcnI7Cit9CisKK3N0YXRpYyB2b2lkIHVwZGF0ZV9uZXR3b3Jr
X2Rpc2Nvbm5lY3RlZChzdHJ1Y3QgaXdkX25ldHdvcmsgKml3ZG4pCit7CisJc3RydWN0IGl3ZF9k
ZXZpY2UgKml3ZGQ7CisKKwlpZiAoIWl3ZG4gfHwgIWl3ZG4tPml3ZGQpCisJCXJldHVybjsKKwor
CWl3ZGQgPSBpd2RuLT5pd2RkOworCisJREJHKCJpbnRlcmZhY2UgbmFtZSAlcyIsIGl3ZG4tPm5h
bWUpOworCWNvbm5tYW5fbmV0d29ya19zZXRfY29ubmVjdGVkKGl3ZG4tPm5ldHdvcmssIGZhbHNl
KTsKKworCWl3ZGQtPmRpc2Nvbm5lY3RpbmcgPSBmYWxzZTsKKworCWlmIChnX3N0cmNtcDAoaXdk
bi0+cGF0aCwgaXdkZC0+bmV0d29yaykpIHsKKwkJaWYgKCFnX3N0cmNtcDAoaXdkbi0+cGF0aCwg
aXdkZC0+cGVuZGluZ19uZXR3b3JrKSkgeworCQkJYWJvcnRfcGVuZGluZ19uZXR3b3JrKGl3ZGQs
CisJCQkJCUNPTk5NQU5fTkVUV09SS19FUlJPUl9DT05ORUNUX0ZBSUwpOworCQl9CisJCURCRygi
Y3VycmVudCB3aWZpIG5ldHdvcmsgaGFzIGNoYW5nZWQgc2luY2UgZGlzY29ubmVjdGlvbiIpOwor
CQlyZXR1cm47CisJfQorCisJZ19mcmVlKGl3ZGQtPm5ldHdvcmspOworCWl3ZGQtPm5ldHdvcmsg
PSBOVUxMOworCisJaWYgKGl3ZGQtPnBlbmRpbmdfbmV0d29yaykgeworCQlzdHJ1Y3QgaXdkX25l
dHdvcmsgKml3ZG5fcGVuZGluZyA9CisJCQlnX2hhc2hfdGFibGVfbG9va3VwKG5ldHdvcmtzLCBp
d2RkLT5wZW5kaW5nX25ldHdvcmspOworCQlpZiAoIWl3ZG5fcGVuZGluZykKKwkJCXJldHVybjsK
KworCQljbV9uZXR3b3JrX2Nvbm5lY3QoaXdkbl9wZW5kaW5nLT5uZXR3b3JrKTsKKwl9CiB9CiAK
IHN0YXRpYyB2b2lkIGNtX25ldHdvcmtfZGlzY29ubmVjdF9jYihEQnVzTWVzc2FnZSAqbWVzc2Fn
ZSwgdm9pZCAqdXNlcl9kYXRhKQpAQCAtMjc5LDYgKzM1MCw5IEBAIHN0YXRpYyB2b2lkIGNtX25l
dHdvcmtfZGlzY29ubmVjdF9jYihEQnVzTWVzc2FnZSAqbWVzc2FnZSwgdm9pZCAqdXNlcl9kYXRh
KQogCWlmICghaXdkbikKIAkJcmV0dXJuOwogCisJaWYoaXdkbi0+aXdkZCkKKwkJaXdkbi0+aXdk
ZC0+ZGlzY29ubmVjdGluZyA9IGZhbHNlOworCiAJaWYgKGRidXNfbWVzc2FnZV9nZXRfdHlwZSht
ZXNzYWdlKSA9PSBEQlVTX01FU1NBR0VfVFlQRV9FUlJPUikgewogCQljb25zdCBjaGFyICpkYnVz
X2Vycm9yID0gZGJ1c19tZXNzYWdlX2dldF9lcnJvcl9uYW1lKG1lc3NhZ2UpOwogCkBAIC0zMDMs
MTEgKzM3NywxNiBAQCBzdGF0aWMgaW50IGNtX25ldHdvcmtfZGlzY29ubmVjdChzdHJ1Y3QgY29u
bm1hbl9uZXR3b3JrICpuZXR3b3JrKQogewogCXN0cnVjdCBpd2RfbmV0d29yayAqaXdkbiA9IGNv
bm5tYW5fbmV0d29ya19nZXRfZGF0YShuZXR3b3JrKTsKIAlzdHJ1Y3QgaXdkX3N0YXRpb24gKml3
ZHM7CisJc3RydWN0IGl3ZF9kZXZpY2UgKml3ZGQ7CiAKLQlpZiAoIWl3ZG4gJiYgIWl3ZG4tPml3
ZGQpCisJaWYgKCFpd2RuIHx8ICFpd2RuLT5pd2RkKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCWl3
ZHMgPSBnX2hhc2hfdGFibGVfbG9va3VwKHN0YXRpb25zLCBpd2RuLT5pd2RkLT5wYXRoKTsKKwlp
d2RkID0gaXdkbi0+aXdkZDsKKwlpZiAoaXdkZC0+ZGlzY29ubmVjdGluZykKKwkJcmV0dXJuIC1F
QUxSRUFEWTsKKworCWl3ZHMgPSBnX2hhc2hfdGFibGVfbG9va3VwKHN0YXRpb25zLCBpd2RkLT5w
YXRoKTsKIAlpZiAoIWl3ZHMpCiAJCXJldHVybiAtRUlPOwogCkBAIC0zMTcsNiArMzk2LDggQEAg
c3RhdGljIGludCBjbV9uZXR3b3JrX2Rpc2Nvbm5lY3Qoc3RydWN0IGNvbm5tYW5fbmV0d29yayAq
bmV0d29yaykKIAkJCU5VTEwsIGNtX25ldHdvcmtfZGlzY29ubmVjdF9jYiwgZ19zdHJkdXAoaXdk
bi0+cGF0aCksIGdfZnJlZSkpCiAJCXJldHVybiAtRUlPOwogCisJaXdkZC0+ZGlzY29ubmVjdGlu
ZyA9IHRydWU7CisKIAlyZXR1cm4gMDsKIH0KIApAQCAtNTE1LDYgKzU5NiwxMiBAQCBzdGF0aWMg
dm9pZCBkZXZpY2VfcG93ZXJlZF9jYihjb25zdCBEQnVzRXJyb3IgKmVycm9yLCB2b2lkICp1c2Vy
X2RhdGEpCiAJfQogCiAJY29ubm1hbl9kZXZpY2Vfc2V0X3Bvd2VyZWQoaXdkZC0+ZGV2aWNlLCBj
YmQtPnBvd2VyZWQpOworCisJaWYoIWNiZC0+cG93ZXJlZCkgeworCQlhYm9ydF9wZW5kaW5nX25l
dHdvcmsoaXdkZCwKKwkJCQkJQ09OTk1BTl9ORVRXT1JLX0VSUk9SX0NPTk5FQ1RfRkFJTCk7CisJ
CWl3ZGQtPmRpc2Nvbm5lY3RpbmcgPSBmYWxzZTsKKwl9CiBvdXQ6CiAJZ19mcmVlKGNiZC0+cGF0
aCk7CiAJZ19mcmVlKGNiZCk7CkBAIC0xMzA5LDYgKzEzOTYsMTAgQEAgc3RhdGljIHZvaWQgZGV2
aWNlX2ZyZWUoZ3BvaW50ZXIgZGF0YSkKIAlnX2ZyZWUoaXdkZC0+YWRhcHRlcik7CiAJZ19mcmVl
KGl3ZGQtPm5hbWUpOwogCWdfZnJlZShpd2RkLT5hZGRyZXNzKTsKKworCWdfZnJlZShpd2RkLT5u
ZXR3b3JrKTsKKwlnX2ZyZWUoaXdkZC0+cGVuZGluZ19uZXR3b3JrKTsKKwogCWdfZnJlZShpd2Rk
KTsKIH0KIAotLSAKMi4yNS4xCgo=

--_002_MRZP264MB154447165B86A88033C533B8935E9MRZP264MB1544FRAP_--
