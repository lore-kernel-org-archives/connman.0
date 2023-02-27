Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2070.outbound.protection.outlook.com [40.107.12.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F42F3A
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 17:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4040ZgDhzn2+uI6PSt9nxqnyxP7m+QoV9NPH/ePrHjrZVJ137s/WyMQiY+Ea9OAJkhmNwByPtjKNYvVslhqwjU/Pajb9DqYcuXdIaBFvftQIAdM0V2Mhe+O404cHJ3ynuyLkJ5eVEw1AqMJTPEIdcq0dURWobJe9/nWbP1lNpltrjP82Xv6l5ey/sLKQ7YXzMQlXcW4UOV/zTMfIY+0GANAyYVEq1tm0lw4RV70YgJdg4JVW4fGAEgBL0jFrW/hgV7UO3u/HEdtxOvtRSTQizS5eZ/nNctk45Mb4ESWM18hKHIhvWJ9FxzSy1xrMVxlpRap7tmjL42NrNrkFWMr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQnSZoRBKiq+TzlQ4Y8E8ZsX4YjgCzJRyjR/1lSzJ5o=;
 b=eTangc8L6cQouAlo9lAG3+xc/zC5wn2safmuZWG0LkNKPy2yaju1bSE53AjwToa2KX0raimLXSB7GdmjwpeHcOgfGsfx84MQROLF8yDwg5NpG39yUx9W1srzSstP6RzRxkeX+0Fse4IXCLHBisLg6ETq7jV8VTf8yCavuUlV3EfsZQAGqg1cU7R/K3CnOJLtod8mQ2EqHF/l5cFt/j5bL3RBQpWM18K4dI/RirgT3UUD3sDr7S8LgIkJwNkvWABKeigOCxneOz+sz8AQVdrYOyPTNM2+HmAHZLKnRbvDUk5UEkZ6DB/aJHKtSkIsD9ljhdniI0DEkD8mDckIaN8qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQnSZoRBKiq+TzlQ4Y8E8ZsX4YjgCzJRyjR/1lSzJ5o=;
 b=VM21tfLvmLvoZ0UoBv8c1Vo2f+ko4BeA0T3mhtocFB9FlkEsSqlqvlVV66PBdNJcp9puH2Ln2hopHK+vnI2cocnlKhbxwZpb/GhmiVkxuMFUQlL0lIutz+CHHlRqJihWnL+7UN3/Jz0TTALOHv24aRLWK4SEklMTQNHnGlWINl0=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 PR1P264MB2078.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 17:13:13 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad0e:5229:24f3:920d]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad0e:5229:24f3:920d%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 17:13:13 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: [PATCH] network: Keep failure state after disconnection
Thread-Topic: [PATCH] network: Keep failure state after disconnection
Thread-Index: AQHZSswmMJ9x9jxugk6QqaKMEp4VZa7jB391
Date: Mon, 27 Feb 2023 17:13:13 +0000
Message-ID:
 <MRZP264MB1544A26A7D6EBCEB14A0B59793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References:
 <MRZP264MB15448014A6E161ADFD0A280793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To:
 <MRZP264MB15448014A6E161ADFD0A280793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB1544:EE_|PR1P264MB2078:EE_
x-ms-office365-filtering-correlation-id: e6aaeaed-f080-433a-35ef-08db18e5e8f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PNkg38bbZoAdKpt1XxTUabx0wHbyf7pG68qohpu1hUydn4xVepVlteLrjl4FOKIC7pZx3C31YTl7l5/GdVuSuNPPtBcB96jRmMPiJNPpCECdYyp1vWe6WGYe+czOGk7n+2s8nfynFU9bqZW1AGm6O3dLf8r9ACj5DceTSzwCSwzfZC8nl96EOxm+7T/9ZIbm466ngQAUdbq/fIwxu8+6QrQTmlDdfi0Qzp2K+6FF3yNjYiyoBYN1tatjebX2XAAEd968L7wcX3E+LDV9hhgL8Y6hO/R0UQ8TUSCthweKuuodMYh4uSCTKARsb7qvxgMXkBL5i/76lPC9z8sJZL63iyGAdoS1B58feNLzAPS+LoU2MXu0mqNQlfJakm/Jz28Sz1sx5LQe8v10V+k0tngntj2jldIXnzWpEifjVhGTcPMh+REPWm2GRh9O03P60tIn9rS3iYJdOh+0a7D7xOFmDwmz8SfNfQNnQ60j3Q7ZTv8IecWg2pktSl58FOwxtaDHhMkpT1567P7uA5eghx67wjg8cEjPs4dP/ceTkaGxiHqI752YuIgNb9acqlngBMtCxEHMYtA/+a6TpuiHyJEJFl1k2uUHT6AzRH4QpVfxJfaygPwR4OcJdvlsxlTwdEk4F5Xn4Ur9BdIE53HSoK8sNhCzZOJ/LCsYQ7hMFBJO5b1jSb9pbIV6TKiJst4xUpl8R004Zdw+tt1rpYeqH5HacA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199018)(2940100002)(9686003)(186003)(38100700002)(91956017)(99936003)(122000001)(83380400001)(38070700005)(52536014)(8936002)(66446008)(66476007)(76116006)(66946007)(41300700001)(2906002)(5660300002)(71200400001)(7696005)(55016003)(66556008)(478600001)(64756008)(6506007)(6916009)(26005)(66574015)(316002)(33656002)(8676002)(19627405001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nD0hRe4m772XLVY3Pew5EjLXtbwROoQRN/7PZdMwkfDSMSBlBSI6wwmy2q?=
 =?iso-8859-1?Q?iVAB1Hi9iqc9e1RFKW59RJr+eSnPhdn893W8PsEHalv5juMCGsMmBAWeRE?=
 =?iso-8859-1?Q?LyLxZTVXo05pp25abssmoWGssXAg5Tl1O8fn+4hGwgCoLhAsuhJnnuHlTf?=
 =?iso-8859-1?Q?YsnAp2H5PoeZmHbehfxYTiILbWa3wQDCxrybaSO1YGU/NHfb9hEBeCuFM8?=
 =?iso-8859-1?Q?IQ9B+ui16EaEQMkHBK059cej+BgdvtBjw4uP50fJa6Vq1efK/hiOtP64TQ?=
 =?iso-8859-1?Q?w+TksQTtqFP5IrU48GJZvNydmjjtDZoRyoH/79zE5NI8O5Xk6VjzoMQuyV?=
 =?iso-8859-1?Q?Y9dX2ssjcQPEJomREnMbbOtQWN9fHpQvlgSQpdNKbjLQdqQozDq+b+cCOP?=
 =?iso-8859-1?Q?C6Yo9tUm5dGXeIGG3OVUOvZvvQ7SX8wA03yM/Y4uvcMunl7cpwH+xTY87I?=
 =?iso-8859-1?Q?UejZIaIe/VdB4bAeq1rt5yH/4JqteUK/LyTEca8iNUtPT85oIHcwjp+Phz?=
 =?iso-8859-1?Q?KWdd4M8fY5hJB+mz7v7Z337OUBsQ97ANMIN8bF9mzsRCioCKvCMdAyfvgu?=
 =?iso-8859-1?Q?1Gn2wY5RKVtaf7qIzRAd67ZfzqDlVbg9NU2DVzX09DmL5LDbHbQYzaRr3F?=
 =?iso-8859-1?Q?l8HnBgHxtVoDG6ETqzNg753GpapjgFawm6j4mLWfHGj2V4E5yWUPMLxRpi?=
 =?iso-8859-1?Q?aQ7RYNCEpticnNcFKmmmDwS7smgijhHlyGkN//6c6OeEPzcWF7Lu9JLLdL?=
 =?iso-8859-1?Q?2SYOdAfg8TYZsXOH4IQtqwE/Bq1T69j9/RBfEr1Z49oXGoQaR7IUL70xYy?=
 =?iso-8859-1?Q?ZP2Cpm4GQ5H9g8Ld5EPeeHVHj49dpZdbhyYQUNOAUOOsHleqoKxSsqU8BU?=
 =?iso-8859-1?Q?RwDgDUcqByx3qlW6phiEmHyN6yuerlRAIV37Y0KEwxuQ40NhNRSq9bLl0V?=
 =?iso-8859-1?Q?hNOycm0qErZbinXxE4nC/fiozTTIOwzhLyRVMvWckG0QvJWXyyFKKsRH+M?=
 =?iso-8859-1?Q?sIY2mO3kSH/lNDt2DXrl3CwLSWFAa7XFGZFGsGSRsKbOsfdgkzBlEsa759?=
 =?iso-8859-1?Q?5KomhtcOHQHhUKFST9oUotxY2eFTACxxjri5P4lnqXqqW9toEB/+5ROWxD?=
 =?iso-8859-1?Q?fLNgjKsCPUfW6Oe100u04YydZHWzrKGRZiol4X8WtQ1yt11koAq0Y2KRZn?=
 =?iso-8859-1?Q?6oKYblOUnueNrcX+v2I3faS7fJxqNv0gfzAYkfyawc5kIdhrWLdCDP8OjV?=
 =?iso-8859-1?Q?fHJc6JmznMk7g08C1rBqyaKOPXUU7c6+72AYipOBwviNL4Ovdyjl7cuKHM?=
 =?iso-8859-1?Q?FIyBPOwlcXL9kk1Y6GWp4qe9jeVnDAsJyYXdRRF5ncZBBaqHeL1vZ7Spxo?=
 =?iso-8859-1?Q?8sd0u0jAbhcUL9+1v+bfGgk+1StQPe5xQUe+gySnmPCspzbxuUfp+xvmGv?=
 =?iso-8859-1?Q?2eisndtXrQ8Zh71ggp15GLF2YF2I0pqiEzP9Ae4CzJfIdR3V6v/mEmrIcH?=
 =?iso-8859-1?Q?fHU6Gx7ZXdIKijy7zmkxb7h55v0mwS1EuLcp8GxAGY3pDhZ4+PBhNtPE1t?=
 =?iso-8859-1?Q?8vB0CQhoeEg56ds3OsufldWedUwchxvSRMvI2rCI3YVMVPJnj6NaOg8JYZ?=
 =?iso-8859-1?Q?PEDf7BM7NjQ5RubBBECRAc1STL3el4SACRRR4zX1lhqtmn9vT+bx018w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_MRZP264MB1544A26A7D6EBCEB14A0B59793AF9MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aaeaed-f080-433a-35ef-08db18e5e8f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 17:13:13.7287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfrWvxCopISEJOOLWIVt2UubCW6gBa+KGT6+S1bmVGredfSNqF2CsXyMK6d2gT81g5ERwhKl47Wa96NuQxXh49jmpIXuwsywqn+5dpZz3Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2078

--_004_MRZP264MB1544A26A7D6EBCEB14A0B59793AF9MRZP264MB1544FRAP_
Content-Type: multipart/alternative;
	boundary="_000_MRZP264MB1544A26A7D6EBCEB14A0B59793AF9MRZP264MB1544FRAP_"

--_000_MRZP264MB1544A26A7D6EBCEB14A0B59793AF9MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

With the right attachment (wording deconnection -> disconnection).

B.R.

Emmanuel
________________________________
De : VAUTRIN Emmanuel (Canal Plus Prestataire) <Emmanuel.VAUTRIN@cpexterne.=
org>
Envoy=E9 : lundi 27 f=E9vrier 2023 18:00
=C0 : connman@lists.linux.dev <connman@lists.linux.dev>
Objet : [PATCH] network: Keep failure state after disconnection

set_disconnected() function shall not prevent the service to process errors
by replacing failure state by idle.

For example, when a connection fails with a wrong passphrase, the user stil=
l
needs to be informed, via the agent. However, in this case, the associated
service is automatically disconnected, canceling the pending agent requests=
.
The invalid key error shall be reported, instead of a cancel error.
---
 src/network.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/src/network.c b/src/network.c
index 2090e7fe944e..06df023b076e 100644
--- a/src/network.c
+++ b/src/network.c
@@ -940,7 +940,7 @@ static void set_disconnected(struct connman_network *ne=
twork)
 {
         struct connman_ipconfig *ipconfig_ipv4, *ipconfig_ipv6;
         enum connman_ipconfig_method ipv4_method, ipv6_method;
-       enum connman_service_state state;
+       enum connman_service_state state_ipv4, state_ipv6;
         struct connman_service *service;

         service =3D connman_service_lookup_from_network(network);
@@ -1006,18 +1006,18 @@ static void set_disconnected(struct connman_network=
 *network)
          * or in failure. It does not make sense to go to disconnect
          * state if we were not connected.
          */
-       state =3D __connman_service_ipconfig_get_state(service,
+       state_ipv4 =3D __connman_service_ipconfig_get_state(service,
                                                 CONNMAN_IPCONFIG_TYPE_IPV4=
);
-       if (state !=3D CONNMAN_SERVICE_STATE_IDLE &&
-                       state !=3D CONNMAN_SERVICE_STATE_FAILURE)
+       if (state_ipv4 !=3D CONNMAN_SERVICE_STATE_IDLE &&
+                               state_ipv4 !=3D CONNMAN_SERVICE_STATE_FAILU=
RE)
                 __connman_service_ipconfig_indicate_state(service,
                                         CONNMAN_SERVICE_STATE_DISCONNECT,
                                         CONNMAN_IPCONFIG_TYPE_IPV4);

-       state =3D __connman_service_ipconfig_get_state(service,
+       state_ipv6 =3D __connman_service_ipconfig_get_state(service,
                                                 CONNMAN_IPCONFIG_TYPE_IPV6=
);
-       if (state !=3D CONNMAN_SERVICE_STATE_IDLE &&
-                               state !=3D CONNMAN_SERVICE_STATE_FAILURE)
+       if (state_ipv6 !=3D CONNMAN_SERVICE_STATE_IDLE &&
+                               state_ipv6 !=3D CONNMAN_SERVICE_STATE_FAILU=
RE)
                 __connman_service_ipconfig_indicate_state(service,
                                         CONNMAN_SERVICE_STATE_DISCONNECT,
                                         CONNMAN_IPCONFIG_TYPE_IPV6);
@@ -1041,10 +1041,14 @@ static void set_disconnected(struct connman_network=
 *network)
                 }
         }

-       __connman_service_ipconfig_indicate_state(service,
+       if (state_ipv4 !=3D CONNMAN_SERVICE_STATE_IDLE &&
+                               state_ipv4 !=3D CONNMAN_SERVICE_STATE_FAILU=
RE)
+               __connman_service_ipconfig_indicate_state(service,
                                                 CONNMAN_SERVICE_STATE_IDLE=
,
                                                 CONNMAN_IPCONFIG_TYPE_IPV4=
);

+       if (state_ipv6 !=3D CONNMAN_SERVICE_STATE_IDLE &&
+                               state_ipv6 !=3D CONNMAN_SERVICE_STATE_FAILU=
RE)
         __connman_service_ipconfig_indicate_state(service,
                                                 CONNMAN_SERVICE_STATE_IDLE=
,
                                                 CONNMAN_IPCONFIG_TYPE_IPV6=
);
--
2.25.1

Hello,

Please find the right formatted patch in attachment.


Emmanuel

--_000_MRZP264MB1544A26A7D6EBCEB14A0B59793AF9MRZP264MB1544FRAP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
With the right attachment (wording deconnection -&gt; disconnection).</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
B.R.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Emmanuel</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>De :</b> VAUTRIN Emmanuel (Cana=
l Plus Prestataire) &lt;Emmanuel.VAUTRIN@cpexterne.org&gt;<br>
<b>Envoy=E9 :</b> lundi 27 f=E9vrier 2023 18:00<br>
<b>=C0 :</b> connman@lists.linux.dev &lt;connman@lists.linux.dev&gt;<br>
<b>Objet :</b> [PATCH] network: Keep failure state after disconnection</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">set_disconnected() function shall not prevent the =
service to process errors<br>
by replacing failure state by idle.<br>
<br>
For example, when a connection fails with a wrong passphrase, the user stil=
l<br>
needs to be informed, via the agent. However, in this case, the associated<=
br>
service is automatically disconnected, canceling the pending agent requests=
.<br>
The invalid key error shall be reported, instead of a cancel error.<br>
---<br>
&nbsp;src/network.c | 20 ++++++++++++--------<br>
&nbsp;1 file changed, 12 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/src/network.c b/src/network.c<br>
index 2090e7fe944e..06df023b076e 100644<br>
--- a/src/network.c<br>
+++ b/src/network.c<br>
@@ -940,7 +940,7 @@ static void set_disconnected(struct connman_network *ne=
twork)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct connman_ipconfig *i=
pconfig_ipv4, *ipconfig_ipv6;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum connman_ipconfig_meth=
od ipv4_method, ipv6_method;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum connman_service_state state;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum connman_service_state state_ipv4=
, state_ipv6;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct connman_service *se=
rvice;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; service =3D connman_servic=
e_lookup_from_network(network);<br>
@@ -1006,18 +1006,18 @@ static void set_disconnected(struct connman_network=
 *network)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * or in failure. It =
does not make sense to go to disconnect<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * state if we were n=
ot connected.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D __connman_service_ipconfig_=
get_state(service,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_ipv4 =3D __connman_service_ipco=
nfig_get_state(service,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONNMAN_IPC=
ONFIG_TYPE_IPV4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state !=3D CONNMAN_SERVICE_STATE_=
IDLE &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state !=3D CONNM=
AN_SERVICE_STATE_FAILURE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state_ipv4 !=3D CONNMAN_SERVICE_S=
TATE_IDLE &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_ipv4 !=3D CONNMAN_SERVICE_STATE_FAILU=
RE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __connman_service_ipconfig_indicate_state(service,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CONNMAN_SERVICE_STATE_DISCONNECT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CONNMAN_IPCONFIG_TYPE_IPV4);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D __connman_service_ipconfig_=
get_state(service,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_ipv6 =3D __connman_service_ipco=
nfig_get_state(service,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONNMAN_IPC=
ONFIG_TYPE_IPV6);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state !=3D CONNMAN_SERVICE_STATE_=
IDLE &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state !=3D CONNMAN_SERVICE_STATE_FAILURE)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state_ipv6 !=3D CONNMAN_SERVICE_S=
TATE_IDLE &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_ipv6 !=3D CONNMAN_SERVICE_STATE_FAILU=
RE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __connman_service_ipconfig_indicate_state(service,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CONNMAN_SERVICE_STATE_DISCONNECT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CONNMAN_IPCONFIG_TYPE_IPV6);<br>
@@ -1041,10 +1041,14 @@ static void set_disconnected(struct connman_network=
 *network)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __connman_service_ipconfig_indicate_s=
tate(service,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state_ipv4 !=3D CONNMAN_SERVICE_S=
TATE_IDLE &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_ipv4 !=3D CONNMAN_SERVICE_STATE_FAILU=
RE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __connman_service_ipconfig_indicate_state(service,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONNMAN_SER=
VICE_STATE_IDLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONNMAN_IPC=
ONFIG_TYPE_IPV4);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state_ipv6 !=3D CONNMAN_SERVICE_S=
TATE_IDLE &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state_ipv6 !=3D CONNMAN_SERVICE_STATE_FAILU=
RE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __connman_service_ipconfig=
_indicate_state(service,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONNMAN_SER=
VICE_STATE_IDLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONNMAN_IPC=
ONFIG_TYPE_IPV6);<br>
-- <br>
2.25.1<br>
<br>
Hello,<br>
<br>
Please find the right formatted patch in attachment.<br>
<br>
<br>
Emmanuel</div>
</span></font></div>
</body>
</html>

--_000_MRZP264MB1544A26A7D6EBCEB14A0B59793AF9MRZP264MB1544FRAP_--

--_004_MRZP264MB1544A26A7D6EBCEB14A0B59793AF9MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-network-Keep-failure-state-after-disconnection.patch"
Content-Description: 0001-network-Keep-failure-state-after-disconnection.patch
Content-Disposition: attachment;
	filename="0001-network-Keep-failure-state-after-disconnection.patch";
	size=2994; creation-date="Mon, 27 Feb 2023 17:12:26 GMT";
	modification-date="Mon, 27 Feb 2023 17:12:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxYWY4ODc4NGY5MGZlNDIxNmI5MTczNjY0YzVjNTUzNTFmODlhNjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IE1vbiwgMjcgRmViIDIwMjMgMDk6NDg6MzUgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBuZXR3b3JrOiBLZWVwIGZhaWx1cmUgc3RhdGUgYWZ0ZXIgZGlzY29ubmVjdGlv
bgoKc2V0X2Rpc2Nvbm5lY3RlZCgpIGZ1bmN0aW9uIHNoYWxsIG5vdCBwcmV2ZW50IHRoZSBzZXJ2
aWNlIHRvIHByb2Nlc3MgZXJyb3JzCmJ5IHJlcGxhY2luZyBmYWlsdXJlIHN0YXRlIGJ5IGlkbGUu
CgpGb3IgZXhhbXBsZSwgd2hlbiBhIGNvbm5lY3Rpb24gZmFpbHMgd2l0aCBhIHdyb25nIHBhc3Nw
aHJhc2UsIHRoZSB1c2VyIHN0aWxsCm5lZWRzIHRvIGJlIGluZm9ybWVkLCB2aWEgdGhlIGFnZW50
LiBIb3dldmVyLCBpbiB0aGlzIGNhc2UsIHRoZSBhc3NvY2lhdGVkCnNlcnZpY2UgaXMgYXV0b21h
dGljYWxseSBkaXNjb25uZWN0ZWQsIGNhbmNlbGluZyB0aGUgcGVuZGluZyBhZ2VudCByZXF1ZXN0
cy4KVGhlIGludmFsaWQga2V5IGVycm9yIHNoYWxsIGJlIHJlcG9ydGVkLCBpbnN0ZWFkIG9mIGEg
Y2FuY2VsIGVycm9yLgotLS0KIHNyYy9uZXR3b3JrLmMgfCAyMCArKysrKysrKysrKystLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc3JjL25ldHdvcmsuYyBiL3NyYy9uZXR3b3JrLmMKaW5kZXggMjA5MGU3ZmU5NDRl
Li4wNmRmMDIzYjA3NmUgMTAwNjQ0Ci0tLSBhL3NyYy9uZXR3b3JrLmMKKysrIGIvc3JjL25ldHdv
cmsuYwpAQCAtOTQwLDcgKzk0MCw3IEBAIHN0YXRpYyB2b2lkIHNldF9kaXNjb25uZWN0ZWQoc3Ry
dWN0IGNvbm5tYW5fbmV0d29yayAqbmV0d29yaykKIHsKIAlzdHJ1Y3QgY29ubm1hbl9pcGNvbmZp
ZyAqaXBjb25maWdfaXB2NCwgKmlwY29uZmlnX2lwdjY7CiAJZW51bSBjb25ubWFuX2lwY29uZmln
X21ldGhvZCBpcHY0X21ldGhvZCwgaXB2Nl9tZXRob2Q7Ci0JZW51bSBjb25ubWFuX3NlcnZpY2Vf
c3RhdGUgc3RhdGU7CisJZW51bSBjb25ubWFuX3NlcnZpY2Vfc3RhdGUgc3RhdGVfaXB2NCwgc3Rh
dGVfaXB2NjsKIAlzdHJ1Y3QgY29ubm1hbl9zZXJ2aWNlICpzZXJ2aWNlOwogCiAJc2VydmljZSA9
IGNvbm5tYW5fc2VydmljZV9sb29rdXBfZnJvbV9uZXR3b3JrKG5ldHdvcmspOwpAQCAtMTAwNiwx
OCArMTAwNiwxOCBAQCBzdGF0aWMgdm9pZCBzZXRfZGlzY29ubmVjdGVkKHN0cnVjdCBjb25ubWFu
X25ldHdvcmsgKm5ldHdvcmspCiAJICogb3IgaW4gZmFpbHVyZS4gSXQgZG9lcyBub3QgbWFrZSBz
ZW5zZSB0byBnbyB0byBkaXNjb25uZWN0CiAJICogc3RhdGUgaWYgd2Ugd2VyZSBub3QgY29ubmVj
dGVkLgogCSAqLwotCXN0YXRlID0gX19jb25ubWFuX3NlcnZpY2VfaXBjb25maWdfZ2V0X3N0YXRl
KHNlcnZpY2UsCisJc3RhdGVfaXB2NCA9IF9fY29ubm1hbl9zZXJ2aWNlX2lwY29uZmlnX2dldF9z
dGF0ZShzZXJ2aWNlLAogCQkJCQkJQ09OTk1BTl9JUENPTkZJR19UWVBFX0lQVjQpOwotCWlmIChz
dGF0ZSAhPSBDT05OTUFOX1NFUlZJQ0VfU1RBVEVfSURMRSAmJgotCQkJc3RhdGUgIT0gQ09OTk1B
Tl9TRVJWSUNFX1NUQVRFX0ZBSUxVUkUpCisJaWYgKHN0YXRlX2lwdjQgIT0gQ09OTk1BTl9TRVJW
SUNFX1NUQVRFX0lETEUgJiYKKwkJCQlzdGF0ZV9pcHY0ICE9IENPTk5NQU5fU0VSVklDRV9TVEFU
RV9GQUlMVVJFKQogCQlfX2Nvbm5tYW5fc2VydmljZV9pcGNvbmZpZ19pbmRpY2F0ZV9zdGF0ZShz
ZXJ2aWNlLAogCQkJCQlDT05OTUFOX1NFUlZJQ0VfU1RBVEVfRElTQ09OTkVDVCwKIAkJCQkJQ09O
Tk1BTl9JUENPTkZJR19UWVBFX0lQVjQpOwogCi0Jc3RhdGUgPSBfX2Nvbm5tYW5fc2VydmljZV9p
cGNvbmZpZ19nZXRfc3RhdGUoc2VydmljZSwKKwlzdGF0ZV9pcHY2ID0gX19jb25ubWFuX3NlcnZp
Y2VfaXBjb25maWdfZ2V0X3N0YXRlKHNlcnZpY2UsCiAJCQkJCQlDT05OTUFOX0lQQ09ORklHX1RZ
UEVfSVBWNik7Ci0JaWYgKHN0YXRlICE9IENPTk5NQU5fU0VSVklDRV9TVEFURV9JRExFICYmCi0J
CQkJc3RhdGUgIT0gQ09OTk1BTl9TRVJWSUNFX1NUQVRFX0ZBSUxVUkUpCisJaWYgKHN0YXRlX2lw
djYgIT0gQ09OTk1BTl9TRVJWSUNFX1NUQVRFX0lETEUgJiYKKwkJCQlzdGF0ZV9pcHY2ICE9IENP
Tk5NQU5fU0VSVklDRV9TVEFURV9GQUlMVVJFKQogCQlfX2Nvbm5tYW5fc2VydmljZV9pcGNvbmZp
Z19pbmRpY2F0ZV9zdGF0ZShzZXJ2aWNlLAogCQkJCQlDT05OTUFOX1NFUlZJQ0VfU1RBVEVfRElT
Q09OTkVDVCwKIAkJCQkJQ09OTk1BTl9JUENPTkZJR19UWVBFX0lQVjYpOwpAQCAtMTA0MSwxMCAr
MTA0MSwxNCBAQCBzdGF0aWMgdm9pZCBzZXRfZGlzY29ubmVjdGVkKHN0cnVjdCBjb25ubWFuX25l
dHdvcmsgKm5ldHdvcmspCiAJCX0KIAl9CiAKLQlfX2Nvbm5tYW5fc2VydmljZV9pcGNvbmZpZ19p
bmRpY2F0ZV9zdGF0ZShzZXJ2aWNlLAorCWlmIChzdGF0ZV9pcHY0ICE9IENPTk5NQU5fU0VSVklD
RV9TVEFURV9JRExFICYmCisJCQkJc3RhdGVfaXB2NCAhPSBDT05OTUFOX1NFUlZJQ0VfU1RBVEVf
RkFJTFVSRSkKKwkJX19jb25ubWFuX3NlcnZpY2VfaXBjb25maWdfaW5kaWNhdGVfc3RhdGUoc2Vy
dmljZSwKIAkJCQkJCUNPTk5NQU5fU0VSVklDRV9TVEFURV9JRExFLAogCQkJCQkJQ09OTk1BTl9J
UENPTkZJR19UWVBFX0lQVjQpOwogCisJaWYgKHN0YXRlX2lwdjYgIT0gQ09OTk1BTl9TRVJWSUNF
X1NUQVRFX0lETEUgJiYKKwkJCQlzdGF0ZV9pcHY2ICE9IENPTk5NQU5fU0VSVklDRV9TVEFURV9G
QUlMVVJFKQogCV9fY29ubm1hbl9zZXJ2aWNlX2lwY29uZmlnX2luZGljYXRlX3N0YXRlKHNlcnZp
Y2UsCiAJCQkJCQlDT05OTUFOX1NFUlZJQ0VfU1RBVEVfSURMRSwKIAkJCQkJCUNPTk5NQU5fSVBD
T05GSUdfVFlQRV9JUFY2KTsKLS0gCjIuMjUuMQoK

--_004_MRZP264MB1544A26A7D6EBCEB14A0B59793AF9MRZP264MB1544FRAP_--
