Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90085.outbound.protection.outlook.com [40.107.9.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE13FCC
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 12:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d33Ebf1DjDM1KDI8Ef56ppRpTTWs+amBzDHU8KO6/Nql7eL3zSGfQ65LznPdztuoEfr5zFgp9JaHeVhohVYIelAAMtqEykFh46A6eizybzeoIwreIioL4UFhknWZLWuBzfiZkFfW10z5c76hbksKTubOmXzqA9BvWAJSB/mIVzYEyzgZFIg/i+QVfOf7L3vDC+xEOj3sZns2w2TdQa466B8OF+DToZmIFYO8SCFQIJ5MbYhueaHgZzdBhaXJ38A0mW74Zr5Br+nvx8rfHtplo1Bqwq3S44FlcHrrdHpOHtP2uLj4Y9m8E+Qjjpp0BaWsnou0n+BlA5BvL/cle7phlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOUWMGC6U6OVURiGbb6hIGM+b9Ca/ZWMjlfttxnqwMg=;
 b=MRoA9FOa4W7ucwQimXTwrPwg3JEJx5ivW5eMG2NsicJ901ZE1/c+Dkuc0FkxjAb01xwYqg3XmhjJG5OBPukZRXyGtpf8K2p+MqGd83Y4lhmtjXqCQyJIEaeph23Ca71X04KKZxrl4IcxsANjlV07Eb1jDW+/rUXzbhu4fqewvB50KrEUoHiCBJcCwIDSiNig2avf9LlrSJ9jWX2OMEWOmuyiPKCNlp+BDIYlXvZGfUEyUyjm7GalSRx9R9uKg2KutDxXILERZYoGrAreOLztcyFECI7f3MzUoY9dAon4EKi88faMMQdDlu28onozzavT242wtTR2qYQDCSK2kaH4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpexterne.org; dmarc=pass action=none
 header.from=cpexterne.org; dkim=pass header.d=cpexterne.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpexterne.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOUWMGC6U6OVURiGbb6hIGM+b9Ca/ZWMjlfttxnqwMg=;
 b=UXEASiCGeNyCLXv7UsZc7KyJK1OsZ/0YJJyZ2NUc2kpchtnsIIug2IVx4HbhKecE0ghhGBC2sb5Pug0PKQHrNU4S1csbZUzXbzDFq6mPSykN7sw/yfUue0E+1yk2J8plOvl6m9fL9FBRJkdrgSYX8b/3wo423bpIoe0TiQux+is=
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::7) by
 MR1P264MB2769.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:36::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13; Fri, 1 Oct 2021 12:17:20 +0000
Received: from MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd]) by MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b87b:d837:2702:1acd%5]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 12:17:20 +0000
From: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
	<Emmanuel.VAUTRIN@cpexterne.org>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] iwd: Fix improper IPv4/6 attributes when disconnecting
Thread-Topic: [PATCH] iwd: Fix improper IPv4/6 attributes when disconnecting
Thread-Index: AQHXtr45fkSodJfQAE+udl4OFuUfTw==
Date: Fri, 1 Oct 2021 12:17:20 +0000
Message-ID:
 <MRZP264MB15442C715B7A20922755637493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
suggested_attachment_session_id: 0b7eabdf-8d66-5375-bb5a-8e33fe827f0f
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none
 header.from=cpexterne.org;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9713c130-624e-417a-4218-08d984d56acb
x-ms-traffictypediagnostic: MR1P264MB2769:
x-microsoft-antispam-prvs:
 <MR1P264MB2769D044A202E33238DC02A693AB9@MR1P264MB2769.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xB6wr/7NALtf8D1JQ5bfFO+5HctCgNxXUjvKRIz6Okm55iqeQMuLgTP9Q33rW2AftiPYdk9T3yRK9azQaxIZtdO4jEHZfNAyadeVCOeJfj4YDLUk9n9E4TOvliVhBQW/OYrDOuW4oHfm6m6R4tyJ8W0+4nQgm3npo8ZJW+tuuzfpeW0xkWt02MQKDhWBeb+kv1/z1qXafNu+NwROjP2vgh5ALkasyadFI6q1yA3mFOU84/ASgHbFQLyqwM5m4ZxDO5nUSVB3dAyr5ydLGhKadZEL40eQVQPHOM2zN5GTOa5JfbhLi1RXDv7lYoGE9/ZLV5Cdodt4uY59Mm5Ck74eQSJJkUHJKB9cMDFGpGO8wdblazplRebs+hk7FIjrSWptrqp3zy87lXq2c3PxH2E6DgjBHoIy6jScM61tgEBsQHeoFk3fL6BbGjsiG/qdvaEGFP7nJUMna/rEnqX0wUEW5um11XaNYOAPvZoquJhWrtn+uXSXVWcLXVy2Q+4uV7tM9G1PQqn2xanABBUeyHlr3Z+IURTW3KMk0LIHB5MSFQ50LjHMmPYFMSdaKtIAzKhTwvQD7T48R4ghoqZygMXDE1HOIkDdgdkoU5VboTgFB+EjxE10NAvWDsyvj3vQOJhWMmhXQMmCBh2XboU2SbpgMLuCjOR6muykKFhvH8fYzCszhURmaiMWY4K/U1LYHwcJLrMt6uuv3ZegouU1bbm3Sw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(76116006)(8676002)(8936002)(33656002)(66556008)(66476007)(91956017)(55016002)(71200400001)(316002)(66446008)(5660300002)(186003)(2906002)(64756008)(122000001)(7696005)(26005)(86362001)(6916009)(38100700002)(508600001)(4744005)(38070700005)(6506007)(52536014)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wjjQM0Uzuc9wz1rgDFVTCmv9WJ9s8O0VCMPKTMr1EGlqmlfOR8kKrt+4wh?=
 =?iso-8859-1?Q?R6pJtolvXN1RZ6mLlgMjTahB0J2FfBg9qthimlOESu4rT3XB82Vf5XMrHO?=
 =?iso-8859-1?Q?PoGjBo0cwhl3DcJQEn7jR2Q+wAQ4ohLdgRWTju/P1IOu3pp4R6Z3A9NHxn?=
 =?iso-8859-1?Q?OB7GFYNwEpxh5BP1CvgvFfsVbyx6WbqZHu6+PH3Dsuz4FKmb7ObkyVbL0a?=
 =?iso-8859-1?Q?oivIDfRhN77qoYngkctBVZeqWd8qJuZTV5dSh3yBQhP+Bhkv7DkkL+2z85?=
 =?iso-8859-1?Q?vkevJR86T1A2fzYUgT0Ie9Fe5+TrK61ZH6I/jePAraxwxIDzQQkLLZMPVd?=
 =?iso-8859-1?Q?pqg103I8ApwuwfCvWj2NwvV2GRVFpbfbBUAuEBNLJwV2aIizpr508YdDXk?=
 =?iso-8859-1?Q?fKPT053fbEuTkNrK8zmbqUAGF/mTnVtVn8GvRXYcneITO3UQNgWe48NeYK?=
 =?iso-8859-1?Q?2Pzb/0/YS38A4/ExWR6yN4HQd1i6/Ih69fThW+los7KLvGCSygSFiA70U7?=
 =?iso-8859-1?Q?ui18skFUhfeiByadtPEUgMk0jGX16G7W5JLw8PYxQKb41H9PazGK53DVx5?=
 =?iso-8859-1?Q?vB2sU02Es4BFacMJbQMCHF0kj4jsZhEb/2bxyFhTOVUVeaCE3N5JEubwcH?=
 =?iso-8859-1?Q?CSEe5WHyN4zqxVJGgKM0bJANtWBhAlvMSa8h1iixdIZgvaVIsmfAP7G1UV?=
 =?iso-8859-1?Q?P4I96igpN3xlnPhMqUKC8dHzVTq23tR2ryP9jHBaO0codrYPLb8oTK9rSn?=
 =?iso-8859-1?Q?Sc8wqbCldpjcCKi+T5289RXerNCosJrWskSPrzwbJPo7uHE1j2LzzXjojX?=
 =?iso-8859-1?Q?jR2Rd2N/aANrw+DUEQOzN5Xghh1G6vY1ByCbBgGunNHp4RzfzLy7gS+NL+?=
 =?iso-8859-1?Q?LYOOgOAm4ArvjGovob44683dt+54HyORYvGiRWtMl5YpwKagbIOxxDk7RF?=
 =?iso-8859-1?Q?WDK/EQzAf2rCjRfzrmBlD7DDJSS90T6HmdnHO7YknXO1DhHfNPtZA3VBlb?=
 =?iso-8859-1?Q?psWR0OYQm+tQzOpWUtIgfB8GYAinMSQjy8n/J4VFb5QE9jdISnAuKwxCTO?=
 =?iso-8859-1?Q?2s5/UpN61l1f9Pbjoe86wLQT6zorgWaToI1lg6UtiPp+miP/OyVuF4OP3u?=
 =?iso-8859-1?Q?7p6ChT5NUd+tB6lW1wE+LWLALV2sYGRjbi0lSifTdLjPG10GyOER8YldKP?=
 =?iso-8859-1?Q?NtqXpVcqEEQURS+qdKgchlB/I8ILpjNOj+PtFxTntLmSAhkALkV7tza3y/?=
 =?iso-8859-1?Q?jeTiQjdL2cFjJU+Eg1eby9PmeniNhvG5uUpmBAF3+TjJXKQ3Ae0lNeOCM0?=
 =?iso-8859-1?Q?2NdrnyXshd0VM6deqjLEvBZEtzOTZQWFGAlDAgyMDWh5rlA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9713c130-624e-417a-4218-08d984d56acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 12:17:20.2867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf5c5de1-6a54-4091-a72f-90e32801628c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTQlG49GU0mqNYyxThirJKRa6w894ZzdFSUHiBWmX7eDkBs4wZau8H5nQZ7FSFiLeLUUQjc4EtxX66ZfzHeJzKOI6dbhNwizf/n/iO+r97Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2769

The Method, Address, Netmask and Gateway attributes of IPv4/6 Service=0A=
property were not flushed at network disconnection, because its=0A=
associating state was not reset.=0A=
---=0A=
 plugins/iwd.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/plugins/iwd.c b/plugins/iwd.c=0A=
index 9f2114f47311..c1c273ef4b3a 100644=0A=
--- a/plugins/iwd.c=0A=
+++ b/plugins/iwd.c=0A=
@@ -311,6 +311,8 @@ static int cm_network_disconnect(struct connman_network=
 *network)=0A=
 	if (!iwds)=0A=
 		return -EIO;=0A=
 =0A=
+	connman_network_set_associating(network, false);=0A=
+=0A=
 	if (!g_dbus_proxy_method_call(iwds->proxy, "Disconnect",=0A=
 			NULL, cm_network_disconnect_cb, g_strdup(iwdn->path), g_free))=0A=
 		return -EIO;=0A=
-- =0A=
2.25.1=0A=
=0A=
