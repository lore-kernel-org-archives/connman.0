Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2051.outbound.protection.outlook.com [40.107.12.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152022F3A
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 17:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7R7F4/Ih/p6RNuJ0wuamX/FoQiclB2DwJ1pPMhn3HIUJowvFZicCtGwp2CcxYV+/pgnK7iOMdELr1vg4K3qEFBbjc36AnGjdm5pMOg0YcdScJfMJWM1jwnNL5c1p20iVTWFRN6EuVW3jcM7KfgyRfsvQNS3wHjt0y9NDF4hmUISb/6pBxJZSQkfthMztG6jyD6TdBl/WIX3ITPR2ARiS5fRkRMXyOs7vCkbi6q/Gz9Vv7X5EhCTRqkVvxcwZ50w+hIL5KbllBzGvwLA5+42z2yE0D3VfB2xncuexEaQTMk8Ts8WDxNV0eP9CgXemlCFHZ/BMAusDVMRSt/rzbc3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pWT3S336wc/l7M2v6JoXlQmGvjP9E3xnkWxHyOMC0E=;
 b=G6K1DQEwLZ3iqjgV/k0UCNCOYPYv+Or8/E6L14k3A4NQ9pcs2dJhq/aWR6zG8fM+ypkXgLteWipZ4kvRHyUA0pXmf+sjt6LmczSvM1+trVb6cQoapwLKeBb+gkc9uRfuksLwCvrpJQwNenvjukzeBU8VR5l0QFey7vKi6xejkRCd/qIb72MIXp1iCEOqx+akpZG8tL+TvMXlKA0vdwwRgvVF7TrH6B55xcplWQcrjQhivHYB2+Eye1ndJq9rb3xzQjjDibfUtkHuv8oG8phSCEmpp+8v3OCGNC1U0HQuJZ8W7hQUUX3sEh4VKvTdD2rtEG/2k3gK9Au+Yh+ehyLjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pWT3S336wc/l7M2v6JoXlQmGvjP9E3xnkWxHyOMC0E=;
 b=R2r74ZZ2XbYPR4z9lmSs3cZLzXSCNVSGSQGVBYyy+4nSaEaOj6oXa4TVczGtUV2OTOGuAz3H7OF/Qj6Ar75k3S+/zVlqDIjNq/FKvTK56umSzZcxvj8ybigSHgnSGgxGjshemlN4u23C6s3lg5+4Mtt55SlCFqVzxMIGel9lmrQ=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2234.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Mon, 27 Feb 2023 17:19:37 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad0e:5229:24f3:920d]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad0e:5229:24f3:920d%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 17:19:37 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] service: Fix hidden service with wrong passphrase
Thread-Topic: [PATCH] service: Fix hidden service with wrong passphrase
Thread-Index: AQHZSs9pXH19TjmI8kerwyJNS+e/Dg==
Date: Mon, 27 Feb 2023 17:19:37 +0000
Message-ID:
 <MRZP264MB154400DDFBFE8E6BE89E250193AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB1544:EE_|MR1P264MB2234:EE_
x-ms-office365-filtering-correlation-id: e4a040dc-ad76-4f85-c07b-08db18e6cd6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XXoFktsMbxDLTRnd4nM3tT12RMGgEBi5X1lNzZv9BpbUEgza1wv0+UBYP3Kv3Rwx7G43tpSjQAR8X3gA7lX6KXOmCVk48w/w6O6PakhbFW0I38o0/lj20M7EoEN9EwlHszBX5QJgMurOhZHfpaky63alaXJgqQJdKgII8Qfz4A2WJtVzPDWhXYZMxUaLhNB7AThIyRkUKrqtcrqsZWcFuKiVqW8EKjwqK3w2nwNVu1Yxc17KruW/5XUcSoiLekgxMteTP/YoKPXgnR8tIk0aLWsNFl/bYMBBKSqs0+6lxzbnRb9DkwKRqXp2N8Ls5GjtlbYVpaouZ8Qrid2W4r5Xp0HRSAnoAY7adtbYeCfHDSnnOh8N2Fwkcfp1Qrxri5UQw/Yf5FkMWWZBS1ucVwzGmg2Hgbb8SLSPwg6LsKt2zMEbwt2mJwRdNSwisSw0COopD/U6WnZjIQVqgzjENO/1AuwiXm6m/54WU3fnjqWd/2IhMByI5LPW9h5INW6ANGJAceWHAEF4OUxC3G4gCY+fY2z0l2sD9YRyUVF3KIeEbE5JHfc46PBGmM0Pfw7jl5ik4XOLbziAdSBgRydoQy6muZ4FkQZ3DVkWvaBwjWMtvl6FIge1Ovh+wc3qgDDsff9CKLXdBWIU0Lw8FXwfFnFDhjuzXf9jG5tYwzWCdTuqV8izS96khDZrDbK6zznvmd8c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(83380400001)(316002)(33656002)(6916009)(122000001)(99936003)(8676002)(55016003)(64756008)(38100700002)(76116006)(478600001)(6506007)(9686003)(186003)(26005)(7696005)(71200400001)(91956017)(5660300002)(66556008)(66446008)(66946007)(66476007)(52536014)(2906002)(8936002)(86362001)(38070700005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7+yocwnDHsaBnV+sQqcNW3h79XP5mmzBIZCAHZe/+QZJcGZtzRFCmdZQc6?=
 =?iso-8859-1?Q?pUFrt+uUaRatclHVaIL6gYJUr67XUpbnLmkj+0NI2rChrI73lQc/z8jDim?=
 =?iso-8859-1?Q?CSOsTeyRCRcMvhqXUB/wfKD9CequshDPPDWyP1Euts6KMUvM8ymTLkHsSD?=
 =?iso-8859-1?Q?FWHMq7pOoGCGc983OovVNJubqtzdKzuRQKjXbT1r9ey1hOuuTeCHwmnZIr?=
 =?iso-8859-1?Q?T8zhPNSnqUMxVMXY8XP69+O8d90SFXAfKF7PlSNBBOE1CMC3B9hYEtMG9F?=
 =?iso-8859-1?Q?ZxAOiFtGTNMssBEE/Gex8EWWeLsmd857Zh/2X7aIUrFn7rv4x8GlwSROPy?=
 =?iso-8859-1?Q?wcQgvKB3Futbyqcdpwdgc5RKHvBB1SqS8CXDZnCP4/tKAydxORj0izC3UE?=
 =?iso-8859-1?Q?pXQi34op8aq9cspeZQvPDweNL2TJCSlJIywh+3jnU+Eeix2+qS8C5NfW/f?=
 =?iso-8859-1?Q?HMCUXfIAs+Alc3xjbtpCSWQLHgNCaNWdDIB+E0YvnJR+1ZhHphA2yeuKgR?=
 =?iso-8859-1?Q?yqfoxIQjSPyr/cG6+cUldfuDutYyfco07WY0Jt8b6eN5MBQKt7wMKb3bdw?=
 =?iso-8859-1?Q?1Dr53Ku0YQgCTSZfIhuFoKZfd5Wja+iI0j2jsj0ps2U7F3ngb371SIo3fq?=
 =?iso-8859-1?Q?UjXxGkOUmDZcAXYUFhEXwuPXkW+B1YnAxvYxPC2Af1/ar6pDbVOnBlaD/T?=
 =?iso-8859-1?Q?rdURN0cKDCK1Urv19WdF4rNV2UhjFuU2mVddmO81wq4gFAOC9lmwDvT11N?=
 =?iso-8859-1?Q?F8aI92f4O6R0/m3DgqqWqwW3EyHEY0NjmlDh5vMLCaj4MTL3Srubj+8d/P?=
 =?iso-8859-1?Q?HUhpczQbefndr04aBzNIw/MgnmQtpJeh2wpiIF7KGsdVQ2L9PvamXa63EH?=
 =?iso-8859-1?Q?+kgSY5qMeF5sGsF6d2J8xLrMRC+QSrnTA2HBjirK+auw5ssRNR34izmDhb?=
 =?iso-8859-1?Q?0ig65OvvbCRekNgeRVXbAX8OVBtjkZBEjeUgOfRz+JgfRPe27aS6Y3yJ4C?=
 =?iso-8859-1?Q?yysi6VZwJWn6FQOoCgwqEo396zqnSe92QtJRapZsaR9xEhGTa5H2jzC0qe?=
 =?iso-8859-1?Q?N4DVwSugw12wMJGZCu1GxazOmEL7KziTl/fAJLh191nUS3Z87Q6XxQUxZs?=
 =?iso-8859-1?Q?uLZSks7QPI9VNYcZnCKnZ1VBMUY7GrJBncEMp+brLrhUkyvsm7FhiroGaq?=
 =?iso-8859-1?Q?vIfakdrv4jD0URO+3nSkdFIzTv9EGZXY3upC/lYEZL0/GfHsGNm3dfdeZW?=
 =?iso-8859-1?Q?408esjsLOZZpQjGqYrbga9V2wSQTn2Rmn7g32gKOsBS+UD+eej5pAwXHOL?=
 =?iso-8859-1?Q?iDTnJ5qJqQq5CperEouSQZv5BGqUiLwlPLq5dhqJKW3kXDJm0/oEExustm?=
 =?iso-8859-1?Q?ubbnM2A4lkZj60UsjJlQ3gxLWdKUSwfRVS+ZT8rod8fYTZi4ojjwaDaFct?=
 =?iso-8859-1?Q?z5vkW1b+fRpuY6VNe/cZAVFymOIdtBcNxg0jTQHPmNruV+3l34SFFU4qP5?=
 =?iso-8859-1?Q?Zf5VKj7HKA/+eVyslwJekX/zTnpaI0pA5Z4Cg3PfCOsbvOYKLIoAkTqYIW?=
 =?iso-8859-1?Q?4va6i2dIV/PtM3epBunWQwgYH8mFfqoCzvyxfE+RKDhhwPyPmDnJiMbvTR?=
 =?iso-8859-1?Q?k+pGHo5urM2taqI17dC2X9834FFr6BDOZ7MrAKZWf3oSk7O6fpKogzpw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_MRZP264MB154400DDFBFE8E6BE89E250193AF9MRZP264MB1544FRAP_"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cpexterne.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a040dc-ad76-4f85-c07b-08db18e6cd6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 17:19:37.0302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqblWs2UjhHBwzUouskucXxEwQm8nFytbEGJ5xUr9VV1Zr2fXrKptC3K1wfSJfxhrkGmWbLQL36BUKUmJqvXpJg4/V+AL0Wx8oyz0NCGZXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2234

--_002_MRZP264MB154400DDFBFE8E6BE89E250193AF9MRZP264MB1544FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Two cases need to be fixed during the connection to a hidden service=0A=
with a wrong passphrase:=0A=
* the invalid key error shall be reported to the user,=0A=
* another attempt to connect to this hidden service shall be possible,=0A=
and succeed with the right passphrase=0A=
---=0A=
 src/service.c | 17 ++++++++++++++---=0A=
 1 file changed, 14 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/src/service.c b/src/service.c=0A=
index 6f31adb33d6a..06d02322f437 100644=0A=
--- a/src/service.c=0A=
+++ b/src/service.c=0A=
@@ -3241,6 +3241,9 @@ int __connman_service_check_passphrase(enum connman_s=
ervice_security security,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static void set_error(struct connman_service *service,=0A=
+					enum connman_service_error error);=0A=
+=0A=
 int __connman_service_set_passphrase(struct connman_service *service,=0A=
 					const char *passphrase)=0A=
 {=0A=
@@ -3265,6 +3268,10 @@ int __connman_service_set_passphrase(struct connman_=
service *service,=0A=
 		connman_network_set_string(service->network, "WiFi.Passphrase",=0A=
 				service->passphrase);=0A=
 =0A=
+	if (service->hidden_service &&=0A=
+			service->error =3D=3D CONNMAN_SERVICE_ERROR_INVALID_KEY)=0A=
+		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -3617,9 +3624,6 @@ void __connman_service_wispr_start(struct connman_ser=
vice *service,=0A=
 	__connman_wispr_start(service, type);=0A=
 }=0A=
 =0A=
-static void set_error(struct connman_service *service,=0A=
-					enum connman_service_error error);=0A=
-=0A=
 static DBusMessage *set_property(DBusConnection *conn,=0A=
 					DBusMessage *msg, void *user_data)=0A=
 {=0A=
@@ -6824,6 +6828,13 @@ int __connman_service_connect(struct connman_service=
 *service,=0A=
 				service->pending =3D NULL;=0A=
 			}=0A=
 =0A=
+			if (service->hidden_service &&=0A=
+			service->error =3D=3D CONNMAN_SERVICE_ERROR_INVALID_KEY) {=0A=
+				__connman_service_indicate_error(service,=0A=
+					CONNMAN_SERVICE_ERROR_INVALID_KEY);=0A=
+				return err;=0A=
+			}=0A=
+=0A=
 			err =3D __connman_agent_request_passphrase_input(service,=0A=
 					request_input_cb,=0A=
 					dbus_sender,=0A=
-- =0A=
2.25.1=0A=
=0A=
Hello,=0A=
=0A=
Please find the right formatted patch in attachment.=0A=
=0A=
=0A=
Emmanuel=

--_002_MRZP264MB154400DDFBFE8E6BE89E250193AF9MRZP264MB1544FRAP_
Content-Type: text/x-patch;
	name="0001-service-Fix-hidden-service-with-wrong-passphrase.patch"
Content-Description:
 0001-service-Fix-hidden-service-with-wrong-passphrase.patch
Content-Disposition: attachment;
	filename="0001-service-Fix-hidden-service-with-wrong-passphrase.patch";
	size=2161; creation-date="Mon, 27 Feb 2023 17:18:03 GMT";
	modification-date="Mon, 27 Feb 2023 17:18:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmOWQxM2MxY2VkYjFkNjdmZDFmZDIyZjRlMmQyOTcwZGMyMzNlYzc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IE1vbiwgMjcgRmViIDIwMjMgMTQ6NTA6MjUgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBzZXJ2aWNlOiBGaXggaGlkZGVuIHNlcnZpY2Ugd2l0aCB3cm9uZyBwYXNzcGhy
YXNlCgpUd28gY2FzZXMgbmVlZCB0byBiZSBmaXhlZCBkdXJpbmcgdGhlIGNvbm5lY3Rpb24gdG8g
YSBoaWRkZW4gc2VydmljZQp3aXRoIGEgd3JvbmcgcGFzc3BocmFzZToKKiB0aGUgaW52YWxpZCBr
ZXkgZXJyb3Igc2hhbGwgYmUgcmVwb3J0ZWQgdG8gdGhlIHVzZXIsCiogYW5vdGhlciBhdHRlbXB0
IHRvIGNvbm5lY3QgdG8gdGhpcyBoaWRkZW4gc2VydmljZSBzaGFsbCBiZSBwb3NzaWJsZSwKYW5k
IHN1Y2NlZWQgd2l0aCB0aGUgcmlnaHQgcGFzc3BocmFzZQotLS0KIHNyYy9zZXJ2aWNlLmMgfCAx
NyArKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3NlcnZpY2UuYyBiL3NyYy9zZXJ2aWNlLmMK
aW5kZXggNmYzMWFkYjMzZDZhLi4wNmQwMjMyMmY0MzcgMTAwNjQ0Ci0tLSBhL3NyYy9zZXJ2aWNl
LmMKKysrIGIvc3JjL3NlcnZpY2UuYwpAQCAtMzI0MSw2ICszMjQxLDkgQEAgaW50IF9fY29ubm1h
bl9zZXJ2aWNlX2NoZWNrX3Bhc3NwaHJhc2UoZW51bSBjb25ubWFuX3NlcnZpY2Vfc2VjdXJpdHkg
c2VjdXJpdHksCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyB2b2lkIHNldF9lcnJvcihzdHJ1Y3Qg
Y29ubm1hbl9zZXJ2aWNlICpzZXJ2aWNlLAorCQkJCQllbnVtIGNvbm5tYW5fc2VydmljZV9lcnJv
ciBlcnJvcik7CisKIGludCBfX2Nvbm5tYW5fc2VydmljZV9zZXRfcGFzc3BocmFzZShzdHJ1Y3Qg
Y29ubm1hbl9zZXJ2aWNlICpzZXJ2aWNlLAogCQkJCQljb25zdCBjaGFyICpwYXNzcGhyYXNlKQog
ewpAQCAtMzI2NSw2ICszMjY4LDEwIEBAIGludCBfX2Nvbm5tYW5fc2VydmljZV9zZXRfcGFzc3Bo
cmFzZShzdHJ1Y3QgY29ubm1hbl9zZXJ2aWNlICpzZXJ2aWNlLAogCQljb25ubWFuX25ldHdvcmtf
c2V0X3N0cmluZyhzZXJ2aWNlLT5uZXR3b3JrLCAiV2lGaS5QYXNzcGhyYXNlIiwKIAkJCQlzZXJ2
aWNlLT5wYXNzcGhyYXNlKTsKIAorCWlmIChzZXJ2aWNlLT5oaWRkZW5fc2VydmljZSAmJgorCQkJ
c2VydmljZS0+ZXJyb3IgPT0gQ09OTk1BTl9TRVJWSUNFX0VSUk9SX0lOVkFMSURfS0VZKQorCQlz
ZXRfZXJyb3Ioc2VydmljZSwgQ09OTk1BTl9TRVJWSUNFX0VSUk9SX1VOS05PV04pOworCiAJcmV0
dXJuIDA7CiB9CiAKQEAgLTM2MTcsOSArMzYyNCw2IEBAIHZvaWQgX19jb25ubWFuX3NlcnZpY2Vf
d2lzcHJfc3RhcnQoc3RydWN0IGNvbm5tYW5fc2VydmljZSAqc2VydmljZSwKIAlfX2Nvbm5tYW5f
d2lzcHJfc3RhcnQoc2VydmljZSwgdHlwZSk7CiB9CiAKLXN0YXRpYyB2b2lkIHNldF9lcnJvcihz
dHJ1Y3QgY29ubm1hbl9zZXJ2aWNlICpzZXJ2aWNlLAotCQkJCQllbnVtIGNvbm5tYW5fc2Vydmlj
ZV9lcnJvciBlcnJvcik7Ci0KIHN0YXRpYyBEQnVzTWVzc2FnZSAqc2V0X3Byb3BlcnR5KERCdXND
b25uZWN0aW9uICpjb25uLAogCQkJCQlEQnVzTWVzc2FnZSAqbXNnLCB2b2lkICp1c2VyX2RhdGEp
CiB7CkBAIC02ODI0LDYgKzY4MjgsMTMgQEAgaW50IF9fY29ubm1hbl9zZXJ2aWNlX2Nvbm5lY3Qo
c3RydWN0IGNvbm5tYW5fc2VydmljZSAqc2VydmljZSwKIAkJCQlzZXJ2aWNlLT5wZW5kaW5nID0g
TlVMTDsKIAkJCX0KIAorCQkJaWYgKHNlcnZpY2UtPmhpZGRlbl9zZXJ2aWNlICYmCisJCQlzZXJ2
aWNlLT5lcnJvciA9PSBDT05OTUFOX1NFUlZJQ0VfRVJST1JfSU5WQUxJRF9LRVkpIHsKKwkJCQlf
X2Nvbm5tYW5fc2VydmljZV9pbmRpY2F0ZV9lcnJvcihzZXJ2aWNlLAorCQkJCQlDT05OTUFOX1NF
UlZJQ0VfRVJST1JfSU5WQUxJRF9LRVkpOworCQkJCXJldHVybiBlcnI7CisJCQl9CisKIAkJCWVy
ciA9IF9fY29ubm1hbl9hZ2VudF9yZXF1ZXN0X3Bhc3NwaHJhc2VfaW5wdXQoc2VydmljZSwKIAkJ
CQkJcmVxdWVzdF9pbnB1dF9jYiwKIAkJCQkJZGJ1c19zZW5kZXIsCi0tIAoyLjI1LjEKCg==

--_002_MRZP264MB154400DDFBFE8E6BE89E250193AF9MRZP264MB1544FRAP_--
