Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120042.outbound.protection.outlook.com [40.107.12.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C263FC4
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 07:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0FsjPtQ1EhevT1mibHXN7vzqGbqOewEPOHoK6yKY8k3IaTw/a99e8fNsOytt4kM91k5GGN6dmeexV8L5WOUweupqZuznrP5xBLupmynWPp0wSKsyD+XB+++J1AF1zLe6U990Xb3G9dqaN3FKyQ3E5RnC/PBNWeZ5BWAsTbk/THgdhdyh0KaduCrMvoGzocOLpR+3YMh9z5rJCQvQ99TySCsTtxJ0nSr/KjBnTR0LU2EHw6uRz5mr1XYLNbaBjoQCOTI8MtfZDL1Trfrp+eTSeIjfsk1AJyhVuichY+MbcYKczUAg8wvpzD2okjtYGIOf/X6fAaKwgBV8TweWrqdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=db5ZMH5n0p5jiyg6aXNbuByPkfCcikz0G4+3GaC5+40=;
 b=mRXhbfOjuDtLkciNWe+ZRtDpKZT2msCCgBimGubRQVk40gqlkkD6y37OK0FF9N59MmTUm4xl5oBY6xtVqot2oBM5uT1qj2geyg5sqZ853CIeRU/fv7X9V2vBxU7o1rw3VuenuubjRugKu7F1Asp+sfQ08YDl0M+Sw7/imDAGHsBM3BiEzeryzvn69dcjP2GLytFsPMDOEkJMjvr6gFkV82K6ukIUfdvmUCNSylqH7ZUg7N1r92bNwBI6n9+PKOuxpZxmgUe0g9nliN/8zG1CybIhUZp5MJCp63whr9zG/TCne7eXElZG6a6MomPMpwQWHtKVUOETBZBoPYcGCaBdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db5ZMH5n0p5jiyg6aXNbuByPkfCcikz0G4+3GaC5+40=;
 b=wRvj7tsSlliDWc4HF8w5q7ux9/ZMvDAPkkGtw80o18i2SNIyMLA0HrFnMrWNEkHHQq1d/SfXGs8IlIZHwIHgZbEkqFiORiJyOL9WtXnMvMurY+7aOEvRa6MZ8Zuv1ZUtLK5tLnEswWN6K3642zX9G2J/Hg9x2HldxLnQMikPL3Y=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2865.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:36::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Mon, 13 Sep 2021 07:17:13 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3144:388c:76cd:f14b]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3144:388c:76cd:f14b%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 07:17:13 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] build: Fix compiler maybe-uninitialized warnings
Thread-Topic: [PATCH] build: Fix compiler maybe-uninitialized warnings
Thread-Index: AQHXqG8ix5L2wlh/SEuCsXQ5xgN7rQ==
Date: Mon, 13 Sep 2021 07:17:13 +0000
Message-ID:
 <MRZP264MB15449CB6E42AF281B16F54FE93D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 269f7bb8-af82-b259-00ba-2f02329d7b02
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a84b22a-2ee5-4d82-c6e4-08d97686826b
x-ms-traffictypediagnostic: MR1P264MB2865:
x-microsoft-antispam-prvs:
 <MR1P264MB28655E29E605498D119910A893D99@MR1P264MB2865.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r3EmL7Lx5wYtFzpTdtyTZCVAxCUGXfugR2dIZzOYMN6Oi3RUsnwmXBEafFE352etBKFxODj0jO86ul1oP+/zXtt1kiZzhET75q8xoSg4hO7GbidgVKi0g641YejUKA8bdObNRmMgFHhJXMp25uSdMbfR7jXqk9/eK0EHLNYMHhLLc2kkpS+kr3J83VhiITxQUuwIOiT+vPSWeFICma7PFPR1B55ZbP1RNl3g81jvz8AWPsmEyoeLDA/9RIW27GIrTDxY9O5yHq4aMi5SeDLlefY3MeapvuANwIFdyjThWWVQT8yAHp78b7w9dx+dDscCkYdh834TiJUa7zF7zeHij3oarX+Z+YkMNAeLWNoYeEe2HTvEQ7/PgOSeYH0PQx5vkULy9r5iLpdJRzHn0DGeWmAlpgBgkizU81yfO2kRQo/HjoDrRBY+CxJQKO1U5Bz40AZSVHwPgTMuyJMt7V/+rOqEGaTnDP3yivw++CKLHzX3NLMXgtsdlc1dD3EgN5eYh4ukTs/mDABYnAWvphY1c/H5EVFHIfzk4Mo6WQiuaiJDFcRFqym//7Gct2j99h8BH5HP4QPuAVOHlOkS/DjMdFr7gLCP6gDBIlK2C/0ve48BxUQOMN4S2Kg9h0UbRKqyvyi6amnolIQ3pSWQNHrHJAmL4h1RBF+R9R2QMbOT+1OSmRG/xVuh13AbbPj9AKHO//eioBkff+0a2PF64AQtHw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(86362001)(33656002)(7696005)(6506007)(52536014)(8936002)(76116006)(38070700005)(66946007)(38100700002)(316002)(66476007)(66446008)(5660300002)(66556008)(64756008)(186003)(9686003)(55016002)(2906002)(83380400001)(6916009)(478600001)(26005)(91956017)(8676002)(71200400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yfOyOGCrBvn/eBnPaMbVcGhpcdEQ4wDabSO3jGq+RXTLXr4tVb4xGrLoYR?=
 =?iso-8859-1?Q?QEtS/es7FetBI83RwPA3igj0St00DyumM/Fcuo9jiT0Jn0g63RDHa6QHPV?=
 =?iso-8859-1?Q?AVJo7bG8SQtr2fByJgSzBdAtfPrm94i+Qkk9OOFcMTeQATOJ8fB51NyAzh?=
 =?iso-8859-1?Q?6x51cQk50YB4kOTJUsjaxk2V44KeCZLsnb45hT/3huiyKMiFB0De71HeQG?=
 =?iso-8859-1?Q?R0KylySqnSrtY42UjULxhFWo6IoJXN7Q6MkOwaV89FiH1n+fJv54iTwBx+?=
 =?iso-8859-1?Q?IyBs3WU745B1YxtNVvLoM8+Pz1mL1a2EcGwpgMZHa3uye+iqfqEbJgoxmC?=
 =?iso-8859-1?Q?NC7PfHwtNvvW/Nzleu4ZnqIjzo2JyFYBXu/7UPx4psRn98no4HIhIXjD99?=
 =?iso-8859-1?Q?1zaa/5YqwzPSug8mBkoOpC3K6ydLoEb1oWONSEDYPGf+NxMuyEewbabnuB?=
 =?iso-8859-1?Q?8ILZ7GZr9zzlIQX650hudNZ6pOrmTy8tbbOyLHSXh4wU0QI21JZcaP/7wF?=
 =?iso-8859-1?Q?WhFfhasquMMt0fXcS26SxSH8AtEVpa1OJogH1KlXHTWXOV+o2COs7Fk2OM?=
 =?iso-8859-1?Q?6f+f4zI26opiKGEf2zpEij0oEUxSqgcOeT30QlqhwwF1MxKZqVP1T6aSHG?=
 =?iso-8859-1?Q?WkiiRmnuJJcw5LIzF69h/VxxiiSjuCLlDtaCxx+sooY9crkTi0s7k5/DY0?=
 =?iso-8859-1?Q?CaIkwoDtPohofESzPIKwK+WwPHdDmiz3dkPOkYgnlIswRRI4nwZWTjjsqt?=
 =?iso-8859-1?Q?HJVUHp/O/5Tg0H9nFQ9ZMtrFc7FOJp4EBrWhvKEubma49UFH20TVfFrB1p?=
 =?iso-8859-1?Q?ffDyraHFUOG+5xvC9DtY/5XLT1mmvORAAgX3kJJpl3VSMM69aa+dzjlywR?=
 =?iso-8859-1?Q?dkryAE222leL/nO2p3Ffig2/0n0mfm97uw2ZORfObchQd3y93by18Yxnod?=
 =?iso-8859-1?Q?pFB1fNwExPG1Ql69w+UFWjK8KtCfmslAcr3fkPiCmmkumemYD7CwsYk7Sh?=
 =?iso-8859-1?Q?vkOr9i4YNmz4M7YwfcouMQqNJIrb3Yp9+KyYyuMA+1GHdiOrBRYDp7V0u8?=
 =?iso-8859-1?Q?ES9PM7UEbGtt4GoYl0jY5hrEuYbyywJMlGAu+hPHpIoEPcYbZCAw3/o9z0?=
 =?iso-8859-1?Q?8mfjNaBdyVvRd9/gqdC0KoZ2PwkKGA1aequBFnRfczDHS1DAF41XaCxv29?=
 =?iso-8859-1?Q?ryKelhP1gRIyA1sXCkWsg7/51qGD3sAfWWLHWOGjQAeI9sHugxneCajV8H?=
 =?iso-8859-1?Q?StencCkts22LMPlx7Y5iHdXG+DKq60brUEz6s2dch6MSLYkXDfBdyQK5jI?=
 =?iso-8859-1?Q?JE/qFSXpSBlvEgnMSzV9sPmu8BiJA+Tetz9M9zzknwAWpLg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a84b22a-2ee5-4d82-c6e4-08d97686826b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 07:17:13.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RYtZR46cvqikPovNVumvvBWXeb5+bTF+zCZ8WEOA2ZZIF63taPgzgkDX73qfHNMt0j+NoXG6Nb88o4n4ffcM8fZopf0S9QisjPgZHd72Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2865

=0A=
---=0A=
 src/config.c           | 6 ++----=0A=
 src/dnsproxy.c         | 2 +-=0A=
 tools/ip6tables-test.c | 2 +-=0A=
 tools/iptables-test.c  | 2 +-=0A=
 4 files changed, 5 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/src/config.c b/src/config.c=0A=
index 62023b1072da..33fdc7375c15 100644=0A=
--- a/src/config.c=0A=
+++ b/src/config.c=0A=
@@ -1106,8 +1106,7 @@ static char *config_pem_fsid(const char *pem_file)=0A=
 =0A=
 static void provision_service_wifi(struct connman_config_service *config,=
=0A=
 				struct connman_service *service,=0A=
-				struct connman_network *network,=0A=
-				const void *ssid, unsigned int ssid_len)=0A=
+				struct connman_network *network)=0A=
 {=0A=
 	if (config->eap)=0A=
 		__connman_service_set_string(service, "EAP", config->eap);=0A=
@@ -1418,8 +1417,7 @@ static int try_provision_service(struct connman_confi=
g_service *config,=0A=
 						config->timeservers);=0A=
 =0A=
 	if (type =3D=3D CONNMAN_SERVICE_TYPE_WIFI) {=0A=
-		provision_service_wifi(config, service, network,=0A=
-							ssid, ssid_len);=0A=
+		provision_service_wifi(config, service, network);=0A=
 	}=0A=
 =0A=
 	__connman_service_mark_dirty();=0A=
diff --git a/src/dnsproxy.c b/src/dnsproxy.c=0A=
index 4b65b3790bb9..fbbee0413f8f 100644=0A=
--- a/src/dnsproxy.c=0A=
+++ b/src/dnsproxy.c=0A=
@@ -2707,7 +2707,7 @@ static void update_domain(int index, const char *doma=
in, bool append)=0A=
 	for (list =3D server_list; list; list =3D list->next) {=0A=
 		struct server_data *data =3D list->data;=0A=
 		GList *dom_list;=0A=
-		char *dom;=0A=
+		char *dom =3D NULL;=0A=
 		bool dom_found =3D false;=0A=
 =0A=
 		if (data->index < 0)=0A=
diff --git a/tools/ip6tables-test.c b/tools/ip6tables-test.c=0A=
index 41e842dd64af..a52f4af04edf 100644=0A=
--- a/tools/ip6tables-test.c=0A=
+++ b/tools/ip6tables-test.c=0A=
@@ -45,7 +45,7 @@ int main(int argc, char *argv[])=0A=
 {=0A=
 	enum iptables_command cmd =3D IPTABLES_COMMAND_UNKNOWN;=0A=
 	char *table =3D NULL, *chain =3D NULL, *rule =3D NULL, *tmp;=0A=
-	int err, c, i;=0A=
+	int err =3D -EINVAL, c, i;=0A=
 =0A=
 	opterr =3D 0;=0A=
 =0A=
diff --git a/tools/iptables-test.c b/tools/iptables-test.c=0A=
index e9b7cb224d7a..f9d091eb9490 100644=0A=
--- a/tools/iptables-test.c=0A=
+++ b/tools/iptables-test.c=0A=
@@ -44,7 +44,7 @@ int main(int argc, char *argv[])=0A=
 {=0A=
 	enum iptables_command cmd =3D IPTABLES_COMMAND_UNKNOWN;=0A=
 	char *table =3D NULL, *chain =3D NULL, *rule =3D NULL, *tmp;=0A=
-	int err, c, i;=0A=
+	int err =3D -EINVAL, c, i;=0A=
 =0A=
 	opterr =3D 0;=0A=
 =0A=
-- =0A=
2.25.1=0A=
=0A=
